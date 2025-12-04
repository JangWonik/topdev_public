package kr.co.toplac.brd.faq;

import kr.co.toplac.cmm.service.CodeDicService;
import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.sysadm.SysAdmCodeDicVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.cmm.*;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;


/**
 * Created by kohyeonseok on 2017. 6. 20..
 */
@Controller
public class FaqBrdController {
    private static final Logger logger = LoggerFactory.getLogger(FaqBrdController.class);

    private static final String SVR_PATH = "/home/hosting_users/toplac/www";
    //private static final String SVR_PATH = "/Users/kohyeonseok/devroot/91.devUpload/toplac/hosting_users/toplac/www";

    @Autowired
    private SqlSession sqlSession;

    @Autowired
    private CodeDicService service;

    @RequestMapping("/brd_faq_list")
    public String faqList(Model model, HttpServletRequest request){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String faqType = StringUtil.null2blank(request.getParameter("faq_type"));

        if ("".equals(faqType)){
            paramMap.put("faq_type", "-1");
        }

        //===============================================
        // 권한 처리
        //===============================================
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
        if ("99".equals(faqType) && !"9".equals(mbrVo.getUser_state())) {
            return "redirect:/brd_faq_list";
        }


        //===============================================
        // 페이지 관련 변수 선언
        //===============================================
        int sizePerPage = 10;       // 한페이지당 보여줄 글 갯수
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
        //베스트 FAQ 가져오기
        List<Map<String, Object>> bestList = sqlSession.selectList("BrdFaqNewMapper.selectBestList",paramMap);

        //검색 리스트 가져오기
        List<Map<String, Object>> list = sqlSession.selectList("BrdFaqNewMapper.selectList",paramMap);
        Long count = sqlSession.selectOne("BrdFaqNewMapper.selectListCnt",paramMap);

        //코드 리스트 가져오기
        SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();
        codeVo.setTbl_nm("brd_faq");
        codeVo.setCol_nm("faq_type");
        List<SysAdmCodeDicVO> codeList = service.codeList(codeVo);


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
        model.addAttribute("bestList", bestList);
        model.addAttribute("codeList", codeList);
        model.addAttribute("srchArg", paramMap);

        return "brd_faq/brd_faq_list";
    }

    @RequestMapping("/brd_faq_write")
    public String faqWrite(Model model){
        //===============================================
        //	권한체크
        //===============================================
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();

        if (!"9".equals(mbrVo.getUser_state())){
            return "redirect:/brd_faq_list";
        }

        //코드 리스트 가져오기
        SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();
        codeVo.setTbl_nm("brd_faq");
        codeVo.setCol_nm("faq_type");
        List<SysAdmCodeDicVO> codeList = service.codeList(codeVo);

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("codeList", codeList);


        return "brd_faq/brd_faq_write";
    }

    @RequestMapping(value = "/brd_faq_insert", method = RequestMethod.POST)
    public String faqInsert(HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {
        //===============================================
        //	권한체크
        //===============================================
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();

        if (!"9".equals(mbrVo.getUser_state())){
            return "redirect:/brd_faq_list";
        }

        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //사용자 정보 입력
        paramMap.put("reg_user_no", mbrVo.getUser_no());

        //remove XSS
        //paramMap.put("title", WebUtil.removeXSS(paramMap.get("title").toString(), false) );
        //paramMap.put("contents", WebUtil.unscript(paramMap.get("contents").toString()));

        //===============================================
        // 비즈니스 로직
        //===============================================
        sqlSession.insert("BrdFaqNewMapper.insert", paramMap);

        //===============================================
        //첨부파일 처리
        //===============================================
        String faqNo = paramMap.get("faq_no").toString();   //입력된 faq 일련번호
        String dateFrm = DateUtil.getTodayString("yyyyMM");

        String svrPath = SVR_PATH;
        String dbPath = "/wp_board/upload/faq/" + dateFrm + "/" + faqNo + "/";


        String savePath = svrPath + dbPath;
        List<Map<String, String>> saveFileList = uploadFileSaves(multipartRequest, savePath);

        for (Map<String, String> fileMap : saveFileList){
            fileMap.put("faqNo", faqNo);
            fileMap.put("streFilePath", fileMap.get("streFilePath").toString().replace(svrPath,""));
            sqlSession.insert("BrdFaqNewMapper.insertFile", fileMap);

        }


        return "redirect:/brd_faq_list";
    }

    @RequestMapping("/brd_faq_view")
    public String faqView(Model model, HttpServletRequest request){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String faqNo = StringUtil.null2blank(request.getParameter("faq_no"));

        if ("".equals(faqNo)){
            return "redirect:/brd_faq_list";
        }

        //===============================================
        // 비즈니스 로직
        //===============================================
        Map<String, Object> faqVo = sqlSession.selectOne("BrdFaqNewMapper.select", paramMap);

        if (faqVo == null){
            return "redirect:/brd_faq_list";
        }
        
        //===============================================
        // 권한 처리
        //===============================================
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
        String useAt = faqVo.get("useAt").toString();
        if ("N".equals(useAt) && !"9".equals(mbrVo.getUser_state())) {
            return "redirect:/brd_faq_list";
        }


        //코드 리스트 가져오기
        SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();
        codeVo.setTbl_nm("brd_faq");
        codeVo.setCol_nm("faq_type");
        List<SysAdmCodeDicVO> codeList = service.codeList(codeVo);

        //파일 리스트 가져오기
        List<Map<String, String>> fileList = sqlSession.selectList("BrdFaqNewMapper.selectFileList", paramMap);

        //===============================================
        // 뷰에 전달할 값들 세팅
        //===============================================
        model.addAttribute("faqVo", faqVo);
        model.addAttribute("codeList", codeList);
        model.addAttribute("fileList", fileList);

        return "brd_faq/brd_faq_view";
    }

    @RequestMapping("/brd_faq_edit")
    public String faqEdit(Model model, HttpServletRequest request){
        //===============================================
        //	권한체크
        //===============================================
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();

        if (!"9".equals(mbrVo.getUser_state())){
            return "redirect:/brd_faq_list";
        }        
    	
    	//===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String faqNo = StringUtil.null2blank(request.getParameter("faq_no"));

        if ("".equals(faqNo)){
            return "redirect:/brd_faq_list";
        }

        //===============================================
        // 비즈니스 로직
        //===============================================
        Map<String, Object> faqVo = sqlSession.selectOne("BrdFaqNewMapper.select", paramMap);

        if (faqVo == null){
            return "redirect:/brd_faq_list";
        }

        //코드 리스트 가져오기
        SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();
        codeVo.setTbl_nm("brd_faq");
        codeVo.setCol_nm("faq_type");
        List<SysAdmCodeDicVO> codeList = service.codeList(codeVo);

        //파일 리스트 가져오기
        List<Map<String, String>> fileList = sqlSession.selectList("BrdFaqNewMapper.selectFileList", paramMap);

        //===============================================
        // 뷰에 전달할 값들 세팅
        //===============================================
        model.addAttribute("faqVo", faqVo);
        model.addAttribute("codeList", codeList);
        model.addAttribute("fileList", fileList);

        return "brd_faq/brd_faq_edit";
    }

    @RequestMapping("/brd_faq_update")
    public String faqUpdate(HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {
        //===============================================
        //	권한체크
        //===============================================
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();

        if (!"9".equals(mbrVo.getUser_state())){
            return "redirect:/brd_faq_list";
        }    	
    	
    	
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String faqNo = StringUtil.null2blank(request.getParameter("faq_no"));

        if ("".equals(faqNo)){
            return "redirect:/brd_faq_list";
        }

        //===============================================
        // 비즈니스 로직
        //===============================================
        Map<String, Object> faqVo = sqlSession.selectOne("BrdFaqNewMapper.select", paramMap);

        if (faqVo == null){
            return "redirect:/brd_faq_list";
        }


        paramMap.put("user_no", mbrVo.getUser_no());
        //remove XSS
        //paramMap.put("title", WebUtil.removeXSS(paramMap.get("title").toString(), false) );
        //paramMap.put("contents", WebUtil.unscript(paramMap.get("contents").toString()));

        sqlSession.update("BrdFaqNewMapper.update", paramMap);

        //===============================================
        //첨부파일 처리
        //===============================================
        String dateFrm = DateUtil.getTodayString("yyyyMM");

        String svrPath = SVR_PATH;
        String dbPath = "/wp_board/upload/faq/" + dateFrm + "/" + faqNo + "/";


        String savePath = svrPath + dbPath;
        List<Map<String, String>> saveFileList = uploadFileSaves(multipartRequest, savePath);

        for (Map<String, String> fileMap : saveFileList){
            fileMap.put("faqNo", faqNo);
            fileMap.put("streFilePath", fileMap.get("streFilePath").toString().replace(svrPath,""));
            sqlSession.insert("BrdFaqNewMapper.insertFile", fileMap);

        }


        //===============================================
        //  뷰단으로 리다이렉트
        //===============================================
        return "redirect:/brd_faq_list";
    }

    @RequestMapping("/brd_faq_delete")
    public String faqDelete(HttpServletRequest request){
        //===============================================
        //	권한체크
        //===============================================
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();

        if (!"9".equals(mbrVo.getUser_state())){
            return "redirect:/brd_faq_list";
        }      	
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String faqNo = StringUtil.null2blank(request.getParameter("faq_no"));

        if ("".equals(faqNo)){
            return "redirect:/brd_faq_list";
        }

        //===============================================
        // 비즈니스 로직
        //===============================================
        Map<String, Object> faqVo = sqlSession.selectOne("BrdFaqNewMapper.select", paramMap);

        if (faqVo == null){
            return "redirect:/brd_faq_list";
        }

        //파일 리스트 가져오기
        List<Map<String, String>> fileList = sqlSession.selectList("BrdFaqNewMapper.selectFileList", paramMap);

        if (fileList != null){
            sqlSession.delete("BrdFaqNewMapper.deleteFiles", paramMap);
            deleteFiles(fileList);
        }

        sqlSession.delete("BrdFaqNewMapper.delete", paramMap);

        return "redirect:/brd_faq_list";
    }

    /**
     * FAQ 첨부파일 삭제
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/brd_faq_file_delete")
    public @ResponseBody
    Map<String, Object> faqFileDelete(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        paramMap.put("Authorize", "T");

        //===============================================
        //	권한체크
        //===============================================
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();

        if (!"9".equals(mbrVo.getUser_state())){
            paramMap.put("Authorize", "F");
            return paramMap;
        }

        //===============================================
        // 비즈니스 로직
        //===============================================
        //이미 있는지 체크
        Map<String, String> faqFile = sqlSession.selectOne("BrdFaqNewMapper.selectFile", paramMap);

        if (faqFile != null){
            sqlSession.delete("BrdFaqNewMapper.deleteFile", paramMap);

            //파일 삭제 처리
            String svrPath = SVR_PATH;
            String dbPath = faqFile.get("streFilePath");
            String streFileNm = faqFile.get("streFileNm");
            String filePath = svrPath + dbPath + streFileNm;
            File file = new File(filePath);
            file.delete();

            paramMap.put("Result", "success");
        }else{
            paramMap.put("Result", "fail");
        }

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================

        return paramMap;
    }








    /**
     * FAQ 파일 다운로드 처리
     * @param request
     * @param response
     */
    @RequestMapping("/brd_faq_file_down")
    public void faqFileDown(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String file_no = StringUtil.null2blank(request.getParameter("file_no"));

        Map<String, String> resutMap = sqlSession.selectOne("BrdFaqNewMapper.selectFile", paramMap);

        if (resutMap != null){

            String svrPath = SVR_PATH;
            String dbPath = resutMap.get("streFilePath");

            String streFilePath = svrPath + dbPath;
            File uFile = new File(streFilePath, resutMap.get("streFileNm"));

            String mimetype = "application/x-msdownload";

            response.setContentType(mimetype);
            response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(resutMap.get("orignlFileNm"), "utf-8") + "\"");

            BufferedInputStream in = null;
            BufferedOutputStream out = null;

            try {
                in = new BufferedInputStream(new FileInputStream(uFile));
                out = new BufferedOutputStream(response.getOutputStream());

                FileCopyUtils.copy(in, out);
                out.flush();
            } catch (IOException ex) {
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



    /**
     * 여러파일 업로드 처리
     * @param multipartRequest
     * @return Map
     * streFilePath : 저장경로
     * streFileNm   : 저장파일명
     * orignlFileNm : 원본파일명
     */
    private List<Map<String, String>> uploadFileSaves(MultipartRequest multipartRequest, String savePath) throws Exception {

        int fileKey = 0;

        File dir = new File(savePath);

        if(!dir.exists() || !dir.isDirectory()){
            System.out.println("exists!!!!!!!!===============");
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

            System.out.println("orignlfileNm:["+orignlFileNm+"]");
            System.out.println("streFileNm:["+streFileNm+"]");
            System.out.println("streFilePath:["+savePath+"]");

            fileKey++;

        }
        return resultList;
    }

    /**
     * 단일파일 업로드 처리
     * @param multipartFile
     * @return Map
     * streFilePath : 저장경로
     * streFileNm   : 저장파일명
     * orignlFileNm : 원본파일명
     */
    private Map<String, String> uploadfileSave(MultipartFile multipartFile, String savePath){
        return null;
    }

    /**
     * 첨부파일 삭제
     * @param fileList
     */
    private void deleteFiles(List<Map<String, String>> fileList) {

        String realSvrPath = SVR_PATH;

        for (int i = 0; i < fileList.size(); i++){

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


}
