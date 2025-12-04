package kr.co.toplac.brd.guide;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import kr.co.toplac.brd.common.BoardSearchVO;
import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.PaginationInfo;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;
import kr.co.toplac.util.cmm.WebUtil;

@Controller
public class GuideBoardController {
	private static final String SVR_PATH = "/home/hosting_users/toplac/www";
    //private static final String SVR_PATH = "D:/home/hosting_users/toplac/www";
    
	 @Autowired
	 private SqlSession sqlSession;
	 
	 @RequestMapping("/brd_guide_list")
	 public String guideList(Model model, HttpServletRequest request){
		 	//===============================================
	        //	파라미터 체크
	        //===============================================
		 	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
	        String guideType = StringUtil.null2blank(request.getParameter("guide_type"));

	        if ("".equals(guideType)){
	            paramMap.put("guide_type", "-1");
	        }

	        //===============================================
	        // 권한 처리
	        //===============================================
	        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	        if ("99".equals(guideType) && !"9".equals(mbrVo.getUser_state())) {
	            return "redirect:/brd_guide_list";
	        }
	        
	        //===============================================
	        // 페이지 관련 변수 선언
	        //===============================================
	        int sizePerPage = 15;       // 한페이지당 보여줄 글 갯수
	        int sizePerBlock = 10;      // 페이지당 보여줄 블럭 갯수
	        int currentPage = 0;        // 현재 페이지
	        int limitPage = 0;          // sql limit

	        //===============================================
	        // 현재 페이지 세팅
	        //===============================================
	        String pageIdx = StringUtil.null2blank(request.getParameter("pageIdx"));
	        if("".equals(pageIdx)){
	            currentPage = 0;
	            limitPage = 0;
	        }else{
	            currentPage = (Integer.parseInt(pageIdx) - 1);
	            limitPage = ((Integer.parseInt(pageIdx) - 1) * sizePerPage);
	        }
	        paramMap.put("sizePerPage", sizePerPage);
	        paramMap.put("limitPage", limitPage);

	        //===============================================
	        // 비즈니스 로직
	        //===============================================
	        //검색 리스트 가져오기
	        List<Map<String, Object>> list = sqlSession.selectList("BrdGuideMapper.selectList", paramMap);
	        Long count = sqlSession.selectOne("BrdGuideMapper.selectListCnt", paramMap);
	        
	        //코드 리스트 가져오기
	        /*SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();
	        codeVo.setTbl_nm("brd_faq");
	        codeVo.setCol_nm("faq_type");
	        List<SysAdmCodeDicVO> codeList = service.codeList(codeVo); */


	        //===============================================
	        // 뷰단 데이터 세팅
	        //===============================================
	        // 페이징 처리
	        PaginationInfo pageInfo = new PaginationInfo();
	        pageInfo.setRecordCountPerPage(sizePerPage);            // 한페이지당 보여줄 글 갯수
	        pageInfo.setPageSize(sizePerBlock);                     //페이지 리스트 에 보여줄 불럭 갯수
	        pageInfo.setCurrentPageNo(currentPage + 1);             // index 가 0 부터 시작 해서 플러스 1해줌
	        pageInfo.setTotalRecordCount(count);                    // 총 글 갯수

	        model.addAttribute("pageInfo",pageInfo);
	        model.addAttribute("list", list);
	        model.addAttribute("srchArg", paramMap);
		 return "brd_guide/brd_guide_list";
	 }
	 
	 @RequestMapping("/brd_guide_write")
	 public String guideWrite(Model model, HttpServletRequest request, HttpSession session){
		 	//===============================================
	        //	권한체크
	        //===============================================
		 	TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		 	TopMbrAuthVO tmpAuthSessionVO = (TopMbrAuthVO)session.getAttribute("mbrAuthVo_Session");
		 	
		 	if (!"9".equals(mbrVo.getUser_state()) && !"1".equals(tmpAuthSessionVO.getMbr_pms_26())){
	            return "redirect:/brd_guide_list";
	        }
		 
	        
		 return "brd_guide/brd_guide_write";
	 }
	 
	 @RequestMapping("/brd_guide_insert") 
	 public String guideInsert(HttpServletRequest request, MultipartRequest multipartRequest, HttpSession session) throws Exception{
		 	//===============================================
	        //	권한체크
	        //===============================================
		 	TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		 	TopMbrAuthVO tmpAuthSessionVO = (TopMbrAuthVO)session.getAttribute("mbrAuthVo_Session");
		 	
		 	if (!"9".equals(mbrVo.getUser_state()) && !"1".equals(tmpAuthSessionVO.getMbr_pms_26())){
	            return "redirect:/brd_guide_list";
	        }
		 	
		 	//===============================================
	        //	파라미터 체크
	        //===============================================
	        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
	        
	        //사용자 정보 입력
	        paramMap.put("reg_user_no", mbrVo.getUser_no());
	        
	        //===============================================
	        // 비즈니스 로직
	        //===============================================
	        sqlSession.insert("BrdGuideMapper.insert", paramMap);
	        
	        //===============================================
	        //첨부파일 처리
	        //===============================================
	        String guideNo = paramMap.get("guide_no").toString();   
	        String dateFrm = DateUtil.getTodayString("yyyyMM");

	        String svrPath = SVR_PATH;
	        String dbPath = "/wp_board/upload/guide/" + dateFrm + "/" + guideNo + "/";


	        String savePath = svrPath + dbPath;
	        List<Map<String, String>> saveFileList = uploadFileSaves(multipartRequest, savePath);

	        for (Map<String, String> fileMap : saveFileList){
	            fileMap.put("guideNo", guideNo);
	            fileMap.put("streFilePath", fileMap.get("streFilePath").toString().replace(svrPath,""));
	            sqlSession.insert("BrdGuideMapper.insertFile", fileMap);
	        }	        

	     return "redirect:/brdGuideBoardList?insertSuccess=1";			
	 }	
	 
	 @RequestMapping("/brd_guide_view")
	 public String guideView(Model model, HttpServletRequest request, HttpSession session, String boardNo, String reqPgNo, BoardSearchVO searchVO){
		 
		 	//===============================================
	        //	파라미터 체크
	        //===============================================
	        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);	        
	        
	        String guideNo = StringUtil.null2blank(request.getParameter("guide_no"));
	        
	        if("".equals(guideNo)){
	        	return "redirect:/brd_guide_list";
	        }
	        
	        //===============================================
	        // 비즈니스 로직
	        //===============================================	        
	        Map<String, Object> guideVo = sqlSession.selectOne("BrdGuideMapper.select", paramMap);
	        
	        if(guideVo == null){
	        	return "redirect:/brd_guide_list";
	        }
	        
	        //===============================================
	        // 권한 처리
	        //===============================================
	        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	        TopMbrAuthVO tmpAuthSessionVO = (TopMbrAuthVO)session.getAttribute("mbrAuthVo_Session");
	        
	        String useAt = guideVo.get("useAt").toString();
	        if ("N".equals(useAt) && !"9".equals(mbrVo.getUser_state())) {
	            return "redirect:/brd_guide_list";
	        }

	        
	        //조회수 count
	        String regUserNo = String.valueOf(guideVo.get("regUserNo"));
	        
	        if(!regUserNo.equals(mbrVo.getUser_no())){
	        	sqlSession.update("BrdGuideMapper.boardguideAddCnt", paramMap);
	        }
	        
	        //파일 리스트 가져오기
	        List<Map<String, String>> fileList = sqlSession.selectList("BrdGuideMapper.selectFileList", paramMap);
	        
	        //===============================================
	        // 뷰에 전달할 값들 세팅
	        //===============================================
	        model.addAttribute("guideVo", guideVo);
	        model.addAttribute("fileList", fileList);
	        model.addAttribute("tmpAuthSessionVO", tmpAuthSessionVO);
	        model.addAttribute("reqPgNo", reqPgNo);
			model.addAttribute("searchVO", searchVO);
			
	        return "brd_guide/brd_guide_view";
	 		}
	 
	 @RequestMapping("/brd_guide_edit")
	 public String guideEdit(Model model, HttpServletRequest request, HttpSession session, String boardNo, String reqPgNo, BoardSearchVO searchVO){
		 	//===============================================
	        //	권한체크
	        //===============================================
	        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	        TopMbrAuthVO tmpAuthSessionVO = (TopMbrAuthVO)session.getAttribute("mbrAuthVo_Session");

	        if (!"9".equals(mbrVo.getUser_state()) && !"1".equals(tmpAuthSessionVO.getMbr_pms_26())){
	            return "redirect:/brd_guide_list";
	        }        
	        
	        //===============================================
	        //	파라미터 체크
	        //===============================================
	        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
	        String guideNo = StringUtil.null2blank(request.getParameter("guide_no"));
	        
	        if("".equals(guideNo)){
	        	return "redirect:/brd_guide_list";
	        }
	        
	        //===============================================
	        // 비즈니스 로직
	        //===============================================
	        Map<String, Object> guideVo = sqlSession.selectOne("BrdGuideMapper.select", paramMap);
	        
	        if(guideVo == null){
	        	return "redirect:/brd_guide_list";
	        }
	        
	        //파일 리스트 가져오기
	        List<Map<String, String>> fileList = sqlSession.selectList("BrdGuideMapper.selectFileList", paramMap);
	        
	        //===============================================
	        // 뷰에 전달할 값들 세팅
	        //===============================================
	        model.addAttribute("guideVo", guideVo);
	        model.addAttribute("fileList", fileList);
	        model.addAttribute("reqPgNo", reqPgNo);
			model.addAttribute("searchVO", searchVO);
			
		 return "brd_guide/brd_guide_edit";
	 }
	 
	 @RequestMapping("/brd_guide_update")
	 public String guideUpdate(HttpServletRequest request, MultipartRequest multipartRequest, HttpSession session,  String reqPgNo, BoardSearchVO searchVO) throws Exception{
		//===============================================
	    //	권한체크
	    //===============================================
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	    TopMbrAuthVO tmpAuthSessionVO = (TopMbrAuthVO)session.getAttribute("mbrAuthVo_Session");

	    if (!"9".equals(mbrVo.getUser_state()) && !"1".equals(tmpAuthSessionVO.getMbr_pms_26())){
	        return "redirect:/brdGuideBoardDetail";
	    }
		 
	  	//===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String guideNo = StringUtil.null2blank(request.getParameter("guide_no"));

        if ("".equals(guideNo)){
            return "redirect:/brdGuideBoardDetail";
        }
		
        //===============================================
        // 비즈니스 로직
        //===============================================
        Map<String, Object> guideVo = sqlSession.selectOne("BrdGuideMapper.select", paramMap);

        if (guideVo == null){
            return "redirect:/brdGuideBoardDetail";
        }
        
        paramMap.put("user_no",mbrVo.getUser_no());
        
        sqlSession.update("BrdGuideMapper.update",paramMap);
        
        //===============================================
        //첨부파일 처리
        //===============================================
        String dateFrm = DateUtil.getTodayString("yyyyMM");

        String svrPath = SVR_PATH;
        String dbPath = "/wp_board/upload/guide/" + dateFrm + "/" + guideNo + "/";


        String savePath = svrPath + dbPath;
        List<Map<String, String>> saveFileList = uploadFileSaves(multipartRequest, savePath);

        for (Map<String, String> fileMap : saveFileList){
            fileMap.put("guideNo", guideNo);
            fileMap.put("streFilePath", fileMap.get("streFilePath").toString().replace(svrPath,""));
            sqlSession.insert("BrdGuideMapper.insertFile", fileMap);
        }
		 //return "redirect:/brd_guide_list";
        return "redirect:/brdGuideBoardList?updateSuccess=1"
		+"&boardSrcType="+searchVO.getBoardSrcType()
		+"&boardSrcWord="+searchVO.getBoardSrcWord()
		+"&titleSearch="+searchVO.getTitleSearch()
		+"&reqPgNo="+searchVO.getReqPgNo();
	 }
	 
	 
	 @RequestMapping("/brd_guide_file_down")
	 public void guideFileDown(HttpServletRequest request, HttpServletResponse response) throws Exception {
		 //===============================================
	     //	파라미터 체크
	     //===============================================
		 Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		 String file_no = StringUtil.null2blank(request.getParameter("file_no"));
		 
		 Map<String, String> resultMap = sqlSession.selectOne("BrdGuideMapper.selectFile",paramMap);
		 
		 if(resultMap != null){
			 String svrPath = SVR_PATH;
	         String dbPath = resultMap.get("streFilePath");
	         
	         String streFilePath = svrPath + dbPath;
	         File uFile = new File(streFilePath, resultMap.get("streFileNm"));
	         
	         String mimetype = "application/x-msdownload";
	         
	         response.setContentType(mimetype);
	         response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(resultMap.get("orignlFileNm"), "utf-8") + "\"");
			 
	         BufferedInputStream in = null;
	         BufferedOutputStream out = null;
	         
	         try{
		         in = new BufferedInputStream(new FileInputStream(uFile));
		         out = new BufferedOutputStream(response.getOutputStream());
		         
		         FileCopyUtils.copy(in, out);
		         out.flush();
	         } catch (IOException ex){
	        	 ex.printStackTrace();
	         } finally {
	        	 in.close();
	        	 out.close();
	         }
		 }else{
	            response.setCharacterEncoding("utf-8");
	            System.out.println("파일없을때 ......");
	            response.setContentType("text/html;charset=utf-8");

	            PrintWriter printwriter = response.getWriter();

	            printwriter.println("<html>");
	            printwriter.println("<br><br><br><h2>파일을 찾을수 없습니다.</h2>");
	            printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
	            printwriter.println("<br><br><br>&copy; webAccess");
	            printwriter.println("</html>");

	            printwriter.flush();
	            printwriter.close();			 
		 }
	 }
	 
	 @RequestMapping(value = "/brd_guide_file_delete")
	 public @ResponseBody Map<String, Object> guideFileDelete(HttpServletRequest request, Model model){
		//===============================================
	    //	파라미터 체크
	    //===============================================
	    Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
	    
	    paramMap.put("Authorize", "T");
	    
	    //===============================================
        //	권한체크
        //===============================================
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	    
	    String sUserno = mbrVo.getUser_no().toString();
	    String sWriter = paramMap.get("reg_user_no").toString();	    
	    
	    if (!"9".equals(mbrVo.getUser_state()) && !sWriter.equals(sUserno) ){	    	
            paramMap.put("Authorize", "F");
            return paramMap;
        }
	    
	    //===============================================
        // 비즈니스 로직
        //===============================================
        // 이미 있는지 체크
	    Map<String, String> guideFile = sqlSession.selectOne("BrdGuideMapper.selectFile", paramMap);
	    
	    if (guideFile != null){
            sqlSession.delete("BrdGuideMapper.deleteFile", paramMap);

            //파일 삭제 처리
            String svrPath = SVR_PATH;
            String dbPath = guideFile.get("streFilePath");
            String streFileNm = guideFile.get("streFileNm");
            String filePath = svrPath + dbPath + streFileNm;
            File file = new File(filePath);
            file.delete();

            paramMap.put("Result", "success");
        }else{
            paramMap.put("Result", "fail");
        }
		 return paramMap;
	 }
	 
	 @RequestMapping("/brd_guide_delete")
	 public String guideDelete(HttpServletRequest request, HttpSession session, String boardNo, String reqPgNo, BoardSearchVO searchVO){
		//===============================================
	    //	권한체크
	    //===============================================
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();

	    if (!"9".equals(mbrVo.getUser_state())){
	         return "redirect:/brd_guide_list";
	        }      	
		 
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
	    String guideNo = StringUtil.null2blank(request.getParameter("guide_no"));
	    
	    if("".equals(guideNo)){
	    	return "redirect:/brd_guide_list";
	    }
		
        //===============================================
        // 비즈니스 로직
        //===============================================	    
		Map<String, Object> guideVo = sqlSession.selectOne("BrdGuideMapper.select", paramMap);
		
		if(guideVo == null){
			return "redirect:/brdGuideBoardList";
		}
		
		//파일 리스트 가져오기
		List<Map<String,String>> fileList = sqlSession.selectList("BrdGuideMapper.selectFileList", paramMap);
		
		if(fileList != null){
			sqlSession.delete("BrdGuideMapper.delete", paramMap);
			deleteFiles(fileList);
		}
		
		sqlSession.delete("BrdGuideMapper.delete", paramMap);
				
		return "redirect:/brdGuideBoardList?boardSrcType="+searchVO.getBoardSrcType()
		+"&boardSrcWord="+searchVO.getBoardSrcWord()
		+"&titleSearch="+searchVO.getTitleSearch()
		+"&reqPgNo="+searchVO.getReqPgNo();
	 }
	 
	 
	 
	 
	 private List<Map<String, String>> uploadFileSaves(MultipartRequest multipartRequest, String savePath) throws Exception {

	        int fileKey = 0;

	        File dir = new File(savePath);

	        if(!dir.exists() || !dir.isDirectory()){
//	            System.out.println("exists!!!!!!!!===============");
	            dir.mkdirs();
	        }

	        List<Map<String, String>> resultList = new ArrayList<Map<String, String>>();

	        String filePath = "";
	        Iterator<String> files = multipartRequest.getFileNames();

	        while (files.hasNext()){
	            String upFileKey = files.next();
	            MultipartFile mFile = multipartRequest.getFile(upFileKey);

	            String orignlFileNm = mFile.getOriginalFilename();
	            //======================================
	            // 원 파일명이 없는 경우 처리
	            // (첨부가 되지 않은 input file type)
	            //======================================
	            if ("".equals(orignlFileNm)) {
	                continue;
	            }

	            //String streFileNm = DateUtil.getTimeStamp() + fileKey;
	            String streFileNm = StringUtil.getRandomUUID() + fileKey;

	            if (!"".equals(orignlFileNm)) {
	                filePath = savePath + File.separator + streFileNm;
	                mFile.transferTo(new File(WebUtil.filePathBlackList(filePath)));
	            }

	            Map<String, String> resultMap = new HashMap<>();
	            resultMap.put("streFilePath", savePath);
	            resultMap.put("streFileNm", streFileNm);
	            resultMap.put("orignlFileNm", orignlFileNm);

	            resultList.add(resultMap);

//	            System.out.println("orignlfileNm:["+orignlFileNm+"]");
//	            System.out.println("streFileNm:["+streFileNm+"]");
//	            System.out.println("streFilePath:["+savePath+"]");

	            fileKey++;

	        }
	        return resultList;
	    }
	 
	 private void deleteFiles(List<Map<String,String>> fileList){
		 String realSvrPath = SVR_PATH;
		 
		 for(int i = 0; i < fileList.size(); i++){
			 Map<String, String> item = fileList.get(i);
			 String filePath = item.get("streFilePath") + item.get("streFileNm");
			 String folderPath = String.valueOf(item.get("streFilePath"));
			 
			 String realFilePath = realSvrPath + filePath;
			 String realFolderPath = realSvrPath + folderPath;
			 
			 if(!folderPath.equals("")){
				 File file = new File(realFilePath);
				 File dir = new File(realFolderPath);
				 file.delete();
				 dir.delete();
			 }
		 }
	 }
	 
		@RequestMapping(value = "/BoardGuidePrint", method = RequestMethod.GET)
		public String freeBoardPrint(Model model, HttpSession session,  HttpServletRequest request) {
		    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
			if(mbrVo == null){
				session.invalidate();
				return "top_login/top_login";
			}
			
        
			Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
			
			
			Map<String, Object> guideVo = sqlSession.selectOne("BrdGuideMapper.select", paramMap);
			
			model.addAttribute("guideVo", guideVo);

			return "brd_guide/brd_guide_print_pop";
		}//freeBoardPrint
	 
	 
	 
	 
	 
	 
	 
	 
}
