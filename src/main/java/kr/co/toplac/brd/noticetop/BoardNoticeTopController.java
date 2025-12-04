/*
*********************************************************
* Program ID	: BoardNoticeTopController
* Program Name	: BoardNoticeTopController
* Description	: 탑공지사항
* Author		: 
* Date			: 2016.06.11.
*********************************************************
*/
package kr.co.toplac.brd.noticetop;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import kr.co.toplac.brd.common.BoardFileUtil;
import kr.co.toplac.brd.common.BoardFileVO;
import kr.co.toplac.brd.common.BoardMemoViewVO;
import kr.co.toplac.brd.common.BoardPageUtil;
import kr.co.toplac.brd.common.BoardSearchVO;
import kr.co.toplac.brd.common.BoardVO;
import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.sysadm.SysAdmCodeDicVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;
import kr.co.toplac.util.cmm.WebUtil;
import kr.co.toplac.util.rpt.MainLeftUtil;

@Controller
public class BoardNoticeTopController {

	private static final Logger logger = LoggerFactory.getLogger(BoardNoticeTopController.class);

	@Autowired
	SqlSession sqlSession;

	@Autowired
	MainLeftUtil mlu;
	
	private static final String SVR_PATH = "/home/hosting_users/toplac/www";
	
	/**
     * 다중 첨부파일 다운로드 Modal
     */
    @RequestMapping(value="/brdGuideBoardDetailModal")
    public String brdGuideBoardDetailModal(HttpServletRequest request, Model model) {
    	
    	logger.info("========= brdGuideBoardDetailModal =========");    	
    	
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sBoardNo = paramMap.get("board_no").toString();
		
		List<Map<String,Object>> boardDetailFile = sqlSession.selectList("BrdGuideMapper.getBoardFileList", sBoardNo);
		
		String sTitle = boardDetailFile.get(0).get("title").toString();
		
		model.addAttribute("boardTitle", sTitle);
		model.addAttribute("boardDetailFile", boardDetailFile);
    	
    	return "brd_guide_new/board_attach_modal";
    }
        
    @RequestMapping(value="/supportTopBoardDetailModal")
    public String supportTopBoardDetailModal(HttpServletRequest request, Model model) {
    	
    	logger.info("========= supportTopBoardDetailModal =========");    	
    	
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sBoardNo = paramMap.get("board_no").toString();
		
		List<Map<String,Object>> boardDetailFile = sqlSession.selectList("BoardNoticeTopMapper.getBoardFileListSupport", sBoardNo);
		
		String sTitle = boardDetailFile.get(0).get("title").toString();
		
		model.addAttribute("boardTitle", sTitle);
		model.addAttribute("boardDetailFile", boardDetailFile);
    	
    	return "brd_support/board_attach_modal";
    }
    
	/**
     * 다중 첨부파일 다운로드 Modal
     */
    @RequestMapping(value="/noticeTopBoardDetailModal")
    public String noticeTopBoardDetailModal(HttpServletRequest request, Model model) {
    	
    	logger.info("========= noticeTopBoardDetailModal =========");    	
    	
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sBoardNo = paramMap.get("board_no").toString();
		
		List<Map<String,Object>> boardDetailFile = sqlSession.selectList("BoardNoticeTopMapper.getBoardFileList", sBoardNo);
		
		String sTitle = boardDetailFile.get(0).get("title").toString();
		
		model.addAttribute("boardTitle", sTitle);
		model.addAttribute("boardDetailFile", boardDetailFile);
    	
    	return "brd_notice_top/board_attach_modal";
    }
    
    /**
     * 사내규정 지침 신규 List Ajax
     * @param model
     * @param request
     * @param session
     * @param searchVO
     * @param boardWriteSuccess
     * @param boardUpdateSuccess
     * @return
     */
    @RequestMapping(value = "/brdGuidBoardListAjax", method = RequestMethod.POST)
	public String brdGuidBoardListAjax(Model model, HttpServletRequest request, HttpSession session, BoardSearchVO searchVO, String boardWriteSuccess, String boardUpdateSuccess) {
		logger.info("======= brdGuidBoardListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
		BoardPageUtil pageUtil = new BoardPageUtil();
		List<BoardVO> boardList	= (List<BoardVO>) pageUtil.boardPageSearch2(1, sqlSession, "BrdGuideMapper.boardList", searchVO, model, "brdGuideBoardList");
		model.addAttribute("boardList", boardList);		
		
		int boardListCnt = sqlSession.selectOne("BrdGuideMapper.boardListCnt", searchVO);

		model.addAttribute("boardList", boardList);
		model.addAttribute("boardListCnt", boardListCnt);
		model.addAttribute("reqPgNo", paramMap.get("reqPgNo"));
		model.addAttribute("boardWriteSuccess", boardWriteSuccess);
		model.addAttribute("boardUpdateSuccess", boardUpdateSuccess);
		model.addAttribute("searchVO", searchVO);		
		
		return "brd_guide_new/board_list_ajax";
	}
    
    @RequestMapping(value = "/lectureBoardDataWrite", method = RequestMethod.POST)
	public String lectureBoardDataWrite(Model model, HttpSession session, HttpServletRequest request, MultipartRequest multipartRequest, BoardVO inVO) {
		logger.info("======= lectureBoardDataWrite =======");

		/*******게시글 부분 시작*******/
		int result = 0;
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		inVO.setUser_no(mbrAuthVo.getUser_no());
		inVO.setReg_ip(request.getRemoteAddr());
		
		String titleSelect = request.getParameter("titleSelect") != null ? request.getParameter("titleSelect") : "0";		
		String boardType = request.getParameter("boardType") != null ? request.getParameter("boardType") : "1";
		
		inVO.setBoard_type(boardType);
		inVO.setPkey(titleSelect);
			
		result = sqlSession.insert("BrdLectureMapper.boardWrite", inVO);
		/*******게시글 부분 종료*******/
		/*******첨부 파일 부분 시작*******/
		BoardFileUtil bfcu = new BoardFileUtil();
		String boardNo = "", path = "/home/hosting_users/toplac/www/wp_board/upload/lecture/";
		int file_flag = 0;
		if(result > 0){
			boardNo = sqlSession.selectOne("BrdLectureMapper.getBoardNo", inVO);
			path = path+boardNo+"/";
			file_flag = bfcu.fileUploadProcessor(multipartRequest, boardNo, path, sqlSession, "BrdLectureMapper.boardFileWrite");
		}//if(result > 0)
		/*******첨부 파일 부분 종료*******/
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 시작*******/
		String ckStrPath = null;
		ckStrPath = bfcu.mvCKFileDirTmpToReal(inVO.getContents(), "lecture", boardNo);

		if(ckStrPath != null){
			bfcu.deleteDir(ckStrPath);//임시 폴더 내부 자료 및 임시 폴더 삭제

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", boardNo);
			map.put("oldStr", ckStrPath);//임시 폴더 경로
			map.put("newStr", "/home/hosting_users/toplac/www/wp_board/data/lecture/"+boardNo+"/");//정식 폴더 경로
			sqlSession.update("BrdLectureMapper.updateCKPath", map);//게시글 내부의 임시 폴더 경로를 정식 폴더 경로로 바꾸기
		}
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 종료*******/

		if(result < 1 || (file_flag < 1)){//게시글 입력 실패 또는 첨부파일 저장 실패
			model.addAttribute("boardWriteFailVO", inVO);
			return "brd_lecture_data/board_write_form";
		}
		//(게시글 입력 완료 && 첨부파일이 없음) 또는 (게시글 입력 완료 && 첨부파일 저장 성공)
		return "redirect:/brdLectureBoardList?boardWriteSuccess=1&boardType=1";
	}
    
    @RequestMapping(value = "/lectureBoardWrite", method = RequestMethod.POST)
	public String lectureBoardWrite(Model model, HttpSession session, HttpServletRequest request, MultipartRequest multipartRequest, BoardVO inVO) {
		logger.info("======= lectureBoardWrite =======");

		/*******게시글 부분 시작*******/
		int result = 0;
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		inVO.setUser_no(mbrAuthVo.getUser_no());
		inVO.setReg_ip(request.getRemoteAddr());
		
		String titleSelect = request.getParameter("titleSelect") != null ? request.getParameter("titleSelect") : "0";
		String boardType = request.getParameter("boardType") != null ? request.getParameter("boardType") : "0";
		
		inVO.setBoard_type(boardType);
		inVO.setPkey(titleSelect);
			
		result = sqlSession.insert("BrdLectureMapper.boardWrite", inVO);
		/*******게시글 부분 종료*******/
		/*******첨부 파일 부분 시작*******/
		BoardFileUtil bfcu = new BoardFileUtil();
		String boardNo = "", path = "/home/hosting_users/toplac/www/wp_board/upload/lecture/";
		int file_flag = 0;
		if(result > 0){
			boardNo = sqlSession.selectOne("BrdLectureMapper.getBoardNo", inVO);
			path = path+boardNo+"/";
			file_flag = bfcu.fileUploadProcessor(multipartRequest, boardNo, path, sqlSession, "BrdLectureMapper.boardFileWrite");
		}//if(result > 0)
		/*******첨부 파일 부분 종료*******/
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 시작*******/
		String ckStrPath = null;
		ckStrPath = bfcu.mvCKFileDirTmpToReal(inVO.getContents(), "lecture", boardNo);

		if(ckStrPath != null){
			bfcu.deleteDir(ckStrPath);//임시 폴더 내부 자료 및 임시 폴더 삭제

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", boardNo);
			map.put("oldStr", ckStrPath);//임시 폴더 경로
			map.put("newStr", "/home/hosting_users/toplac/www/wp_board/data/lecture/"+boardNo+"/");//정식 폴더 경로
			sqlSession.update("BrdLectureMapper.updateCKPath", map);//게시글 내부의 임시 폴더 경로를 정식 폴더 경로로 바꾸기
		}
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 종료*******/

		if(result < 1 || (file_flag < 1)){//게시글 입력 실패 또는 첨부파일 저장 실패
			model.addAttribute("boardWriteFailVO", inVO);
			return "brd_lecture_qna/board_write_form";
		}
		//(게시글 입력 완료 && 첨부파일이 없음) 또는 (게시글 입력 완료 && 첨부파일 저장 성공)
		return "redirect:/brdLectureBoardList?boardWriteSuccess=1";
	}
    
    private List<Map<String, String>> uploadFileSaves(MultipartRequest multipartRequest, String savePath) throws Exception {

        int fileKey = 0;

        File dir = new File(savePath);

        if(!dir.exists() || !dir.isDirectory()){
//            System.out.println("exists!!!!!!!!===============");
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

//            System.out.println("orignlfileNm:["+orignlFileNm+"]");
//            System.out.println("streFileNm:["+streFileNm+"]");
//            System.out.println("streFilePath:["+savePath+"]");

            fileKey++;

        }
        return resultList;
    }
    
    /**
     * 
     * @param model
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/brdLectureDataWrite", method = RequestMethod.POST)
	 public String brdLectureDataWrite(Model model, HttpServletRequest request, HttpSession session, BoardSearchVO searchVO){    	
    	logger.info("======= brdLectureDataWrite =======");		
		
		String searchPkey = request.getParameter("pkeyVal") != null ? request.getParameter("pkeyVal") : "0";
		String boardType = request.getParameter("boardType") != null ? request.getParameter("boardType") : "1";		
		
		//목록에서 선택한 페이지를 셋팅해준다.
		searchVO.setTitleSearch(searchPkey);
		searchVO.setBoardType(boardType);
				
		model.addAttribute("searchVO", searchVO);

		return "brd_lecture_data/board_write_form";
	 }
    
    /**
     * 
     * @param model
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/brd_lecture_write", method = RequestMethod.POST)
	 public String lectureBrdWrite(Model model, HttpServletRequest request, HttpSession session, BoardSearchVO searchVO){    	
    	logger.info("======= lectureBrdWrite =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String searchPkey = request.getParameter("pkeyVal") != null ? request.getParameter("pkeyVal") : "0";
		
		//목록에서 선택한 페이지를 셋팅해준다.
		searchVO.setTitleSearch(searchPkey);
		
		//QnA 를 사용하는 교육과정목록 가져오기
		List<Map<String,Object>> qnaLectureList = sqlSession.selectList("LectureMapper.selectLectureProcesslistQna", paramMap);
		
		model.addAttribute("qnaLectureList",qnaLectureList);		
		model.addAttribute("searchVO", searchVO);

		return "brd_lecture_qna/board_write_form";
	 }
    
    /**
     * 교육 QnA List Ajax
     * @param model
     * @param request
     * @param session
     * @param searchVO
     * @param boardWriteSuccess
     * @param boardUpdateSuccess
     * @return
     */
    @RequestMapping(value = "/brdLectureBoardListAjax", method = RequestMethod.POST)
	public String brdLectureBoardListAjax(Model model, HttpServletRequest request, HttpSession session, BoardSearchVO searchVO, String boardWriteSuccess, String boardUpdateSuccess) {
		logger.info("======= brdLectureBoardListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String boardType = request.getParameter("boardType") != null ? request.getParameter("boardType") : "0";
		String titleSearch = request.getParameter("titleSearch") != null ? request.getParameter("titleSearch") : "0";
		
		searchVO.setBoardType(boardType);
		searchVO.setTitleSearch(titleSearch);
		
		BoardPageUtil pageUtil = new BoardPageUtil();
		List<BoardVO> boardList	= (List<BoardVO>) pageUtil.boardPageSearch1(1, sqlSession, "BrdLectureMapper.boardList", searchVO, model, "brdLectureBoardList");
		model.addAttribute("boardList", boardList);	
		
		int boardListCnt = sqlSession.selectOne("BrdLectureMapper.boardListCnt", searchVO);

		model.addAttribute("boardList", boardList);
		model.addAttribute("boardListCnt", boardListCnt);
		model.addAttribute("reqPgNo", paramMap.get("reqPgNo"));
		model.addAttribute("boardWriteSuccess", boardWriteSuccess);
		model.addAttribute("boardUpdateSuccess", boardUpdateSuccess);
		model.addAttribute("searchVO", searchVO);		
		
		if( "1".equals(boardType) ) {
			return "brd_lecture_data/board_list_ajax";
		}else{
			return "brd_lecture_qna/board_list_ajax";
		}
	}
    
    @RequestMapping(value = "/supportTopBoardListAjax", method = RequestMethod.POST)
	public String supportTopBoardListAjax(Model model, HttpServletRequest request, HttpSession session, BoardSearchVO searchVO, String boardWriteSuccess, String boardUpdateSuccess) {
		logger.info("======= supportTopBoardListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
		BoardPageUtil pageUtil = new BoardPageUtil();
		List<BoardVO> boardList	= (List<BoardVO>) pageUtil.boardPageSearch3(1, sqlSession, "BoardNoticeTopMapper.boardListSupport", searchVO, model, "supportTopBoardList");
		model.addAttribute("boardList", boardList);		
		
		//int boardListCnt = sqlSession.selectOne("BoardNoticeTopMapper.boardListCntSupport", searchVO);
		int boardListCnt = sqlSession.selectOne("BoardNoticeTopMapper.boardListSupportCnt", searchVO);		
		

		model.addAttribute("boardList", boardList);
		model.addAttribute("boardListCnt", boardListCnt);
		model.addAttribute("reqPgNo", paramMap.get("reqPgNo"));
		model.addAttribute("boardWriteSuccess", boardWriteSuccess);
		model.addAttribute("boardUpdateSuccess", boardUpdateSuccess);
		model.addAttribute("searchVO", searchVO);		
		
		return "brd_support/board_list_ajax";
	}
	
	@RequestMapping(value = "/noticeTopBoardListAjax", method = RequestMethod.POST)
	public String noticeTopBoardListAjax(Model model, HttpServletRequest request, HttpSession session, BoardSearchVO searchVO, String boardWriteSuccess, String boardUpdateSuccess) {
		logger.info("======= noticeTopBoardListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
		BoardPageUtil pageUtil = new BoardPageUtil();
		List<BoardVO> boardList	= (List<BoardVO>) pageUtil.boardPageSearch2(1, sqlSession, "BoardNoticeTopMapper.boardList", searchVO, model, "noticeTopBoardList");
		model.addAttribute("boardList", boardList);		
		
		int boardListCnt = sqlSession.selectOne("BoardNoticeTopMapper.boardListCnt", searchVO);

		model.addAttribute("boardList", boardList);
		model.addAttribute("boardListCnt", boardListCnt);
		model.addAttribute("reqPgNo", paramMap.get("reqPgNo"));
		model.addAttribute("boardWriteSuccess", boardWriteSuccess);
		model.addAttribute("boardUpdateSuccess", boardUpdateSuccess);
		model.addAttribute("searchVO", searchVO);		
		
		return "brd_notice_top/board_list_ajax";
	}
	
	/**
	 * 사내규정 지침 신규 게시판
	 * @param model
	 * @param session
	 * @param boardWriteSuccess
	 * @param boardUpdateSuccess
	 * @param searchVO
	 * @return
	 */
	@RequestMapping(value = "/brdGuideBoardList", method = RequestMethod.GET)
	public String brdGuideBoardList(Model model, HttpSession session, String boardWriteSuccess, String boardUpdateSuccess, BoardSearchVO searchVO) {
		logger.info("======= brdGuideBoardList =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("brdGuideBoardList - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("tname", "brd_notice_top");
		map.put("cname", "title_classify");
		List<SysAdmCodeDicVO> codeList = sqlSession.selectList("CodeDicInsMapper.codeList",map);
		model.addAttribute("titleClassifyList",codeList);
		
		model.addAttribute("boardWriteSuccess", boardWriteSuccess);
		model.addAttribute("boardUpdateSuccess", boardUpdateSuccess);
		model.addAttribute("searchVO", searchVO);

		return "brd_guide_new/board_list";
	}
	
	/**
	 * Top Edu Qna 게시판
	 * @param model
	 * @param session
	 * @param boardWriteSuccess
	 * @param boardUpdateSuccess
	 * @param searchVO
	 * @return
	 */
	@RequestMapping(value = "/brdLectureBoardList", method = RequestMethod.GET)
	public String brdLectureBoardList(Model model, HttpSession session, HttpServletRequest request, String boardWriteSuccess, String boardUpdateSuccess, BoardSearchVO searchVO) {
		logger.info("======= brdLectureBoardList =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("brdLectureBoardList - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}		
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
		String boardType = String.valueOf(paramMap.get("boardType"));
		String titleSearch = String.valueOf(paramMap.get("titleSearch"));		
		
		//QnA 를 사용하는 교육과정목록 가져오기
		List<Map<String,Object>> qnaLectureList = sqlSession.selectList("LectureMapper.selectLectureProcesslistQna", paramMap);
		
		model.addAttribute("qnaLectureList",qnaLectureList);
		
		model.addAttribute("boardWriteSuccess", boardWriteSuccess);
		model.addAttribute("boardUpdateSuccess", boardUpdateSuccess);
		model.addAttribute("searchVO", searchVO);

		if( "1".equals(boardType) ) {
			return "brd_lecture_data/board_list";
		}else{
			return "brd_lecture_qna/board_list";
		}
	}
	
	@RequestMapping(value = "/supportTopBoardList", method = RequestMethod.GET)
	public String supportTopBoardList(Model model, HttpSession session, String boardWriteSuccess, String boardUpdateSuccess, BoardSearchVO searchVO) {
		logger.info("======= supportTopBoardList =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("noticeTopBoardList - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("tname", "brd_support");
		map.put("cname", "category_id");
		List<SysAdmCodeDicVO> codeList = sqlSession.selectList("CodeDicInsMapper.codeList",map);
		model.addAttribute("categoryList",codeList);
		
		//상단 best 글 불러오기
		List<BoardVO> bestBoardList = sqlSession.selectList("BoardNoticeTopMapper.boardListSupportBest");
		model.addAttribute("bestBoardList", bestBoardList);
		
		model.addAttribute("boardWriteSuccess", boardWriteSuccess);
		model.addAttribute("boardUpdateSuccess", boardUpdateSuccess);
		model.addAttribute("searchVO", searchVO);

		return "brd_support/board_list";
	}

	@RequestMapping(value = "/noticeTopBoardList", method = RequestMethod.GET)
	public String noticeTopBoardList(Model model, HttpSession session
			, String boardWriteSuccess, String boardUpdateSuccess, BoardSearchVO searchVO) {
		logger.info("======= noticeTopBoardList =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("noticeTopBoardList - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("tname", "brd_notice_top");
		map.put("cname", "title_classify");
		List<SysAdmCodeDicVO> codeList = sqlSession.selectList("CodeDicInsMapper.codeList",map);
		model.addAttribute("titleClassifyList",codeList);
		
		model.addAttribute("boardWriteSuccess", boardWriteSuccess);
		model.addAttribute("boardUpdateSuccess", boardUpdateSuccess);
		model.addAttribute("searchVO", searchVO);

		return "brd_notice_top/board_list";
	}//noticeTopBoardList
	
	@RequestMapping(value = "/supportTopBoardWriteForm", method = RequestMethod.GET)
	public String supportTopBoardWriteForm(Model model, HttpSession session) {
		logger.info("======= supportTopBoardWriteForm =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("supportTopBoardWriteForm - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("tname", "brd_support");
		map.put("cname", "category_id");
		List<SysAdmCodeDicVO> codeList = sqlSession.selectList("CodeDicInsMapper.codeList",map);
		model.addAttribute("categoryList",codeList);

		return "brd_support/board_write_form";
	}

	@RequestMapping(value = "/noticeTopBoardWriteForm", method = RequestMethod.GET)
	public String noticeTopBoardWriteForm(Model model, HttpSession session) {
		logger.info("======= noticeTopBoardWriteForm =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("noticeTopBoardWriteForm - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("tname", "brd_notice_top");
		map.put("cname", "title_classify");

		List<SysAdmCodeDicVO> codeList = sqlSession.selectList("CodeDicInsMapper.codeList",map);

		model.addAttribute("titleClassifyList",codeList);

		return "brd_notice_top/board_write_form";
	}//noticeTopBoardWriteForm
	
	@RequestMapping(value = "/supportTopBoardWrite", method = RequestMethod.POST)
	public String supportTopBoardWrite(Model model, HttpSession session, HttpServletRequest request, MultipartRequest multipartRequest, BoardVO inVO) {
		logger.info("======= supportTopBoardWrite =======");

		/*******게시글 부분 시작*******/
		int result = 0;
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		inVO.setUser_no(mbrAuthVo.getUser_no());
		inVO.setReg_ip(request.getRemoteAddr());
		result = sqlSession.insert("BoardNoticeTopMapper.boardWriteSupport", inVO);
		/*******게시글 부분 종료*******/
		/*******첨부 파일 부분 시작*******/
		BoardFileUtil bfcu = new BoardFileUtil();
		String boardNo = "", path = "/home/hosting_users/toplac/www/wp_board/upload/support/";
		int file_flag = 0;
		if(result > 0){
			boardNo = sqlSession.selectOne("BoardNoticeTopMapper.getBoardNoSupport", inVO);
			path = path+boardNo+"/";
			file_flag = bfcu.fileUploadProcessor(multipartRequest, boardNo, path, sqlSession, "BoardNoticeTopMapper.boardFileWriteSupport");
		}//if(result > 0)
		/*******첨부 파일 부분 종료*******/
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 시작*******/
		String ckStrPath = null;
		//ckStrPath = bfcu.mvCKFileDirTmpToReal(inVO.getContents(), "notice", boardNo);
		ckStrPath = bfcu.mvCKFileDirTmpToReal(inVO.getContents(), "support", boardNo);

		if(ckStrPath != null){
			bfcu.deleteDir(ckStrPath);//임시 폴더 내부 자료 및 임시 폴더 삭제

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", boardNo);
			map.put("oldStr", ckStrPath);//임시 폴더 경로
			map.put("newStr", "/home/hosting_users/toplac/www/wp_board/data/support/"+boardNo+"/");//정식 폴더 경로
			sqlSession.update("BoardNoticeTopMapper.updateCKPathSupport", map);//게시글 내부의 임시 폴더 경로를 정식 폴더 경로로 바꾸기
		}
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 종료*******/

		if(result < 1 || (file_flag < 1)){//게시글 입력 실패 또는 첨부파일 저장 실패
			model.addAttribute("boardWriteFailVO", inVO);
			return "brd_support/board_write_form";
		}
		//(게시글 입력 완료 && 첨부파일이 없음) 또는 (게시글 입력 완료 && 첨부파일 저장 성공)
		return "redirect:/supportTopBoardList?boardWriteSuccess=1";
	}

	@RequestMapping(value = "/noticeTopBoardWrite", method = RequestMethod.POST)
	public String noticeTopBoardWrite(Model model, HttpSession session, HttpServletRequest request, MultipartRequest multipartRequest, BoardVO inVO) {
		logger.info("======= noticeTopBoardWrite =======");

		/*******게시글 부분 시작*******/
		int result = 0;
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		inVO.setUser_no(mbrAuthVo.getUser_no());
		inVO.setReg_ip(request.getRemoteAddr());
		result = sqlSession.insert("BoardNoticeTopMapper.boardWrite", inVO);
		/*******게시글 부분 종료*******/
		/*******첨부 파일 부분 시작*******/
		BoardFileUtil bfcu = new BoardFileUtil();
		String boardNo = "", path = "/home/hosting_users/toplac/www/wp_board/upload/notice/";
		int file_flag = 0;
		if(result > 0){
			boardNo = sqlSession.selectOne("BoardNoticeTopMapper.getBoardNo", inVO);
			path = path+boardNo+"/";
			file_flag = bfcu.fileUploadProcessor(multipartRequest, boardNo, path, sqlSession, "BoardNoticeTopMapper.boardFileWrite");
		}//if(result > 0)
		/*******첨부 파일 부분 종료*******/
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 시작*******/
		String ckStrPath = null;
		ckStrPath = bfcu.mvCKFileDirTmpToReal(inVO.getContents(), "notice", boardNo);

		if(ckStrPath != null){
			bfcu.deleteDir(ckStrPath);//임시 폴더 내부 자료 및 임시 폴더 삭제

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", boardNo);
			map.put("oldStr", ckStrPath);//임시 폴더 경로
			map.put("newStr", "/home/hosting_users/toplac/www/wp_board/data/notice/"+boardNo+"/");//정식 폴더 경로
			sqlSession.update("BoardNoticeTopMapper.updateCKPath", map);//게시글 내부의 임시 폴더 경로를 정식 폴더 경로로 바꾸기
		}
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 종료*******/

		if(result < 1 || (file_flag < 1)){//게시글 입력 실패 또는 첨부파일 저장 실패
			model.addAttribute("boardWriteFailVO", inVO);
			return "brd_notice_top/board_write_form";
		}
		//(게시글 입력 완료 && 첨부파일이 없음) 또는 (게시글 입력 완료 && 첨부파일 저장 성공)
		return "redirect:/noticeTopBoardList?boardWriteSuccess=1";
	}//noticeTopBoardWrite
	
	@RequestMapping(value = "/supportTopBoardDetail", method = RequestMethod.GET)
	public String supportTopBoardDetail(Model model, HttpSession session, String boardNo, String reqPgNo, BoardSearchVO searchVO) {
		logger.info("======= supportTopBoardDetail =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("noticeTopBoardDetail - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		if(!boardNo.equals(session.getAttribute("brd_no_Session"))){
			sqlSession.update("BoardNoticeTopMapper.boardAddCntSupport", boardNo);
		}
		session.setAttribute("brd_no_Session", boardNo);

		BoardVO boardDetail = sqlSession.selectOne("BoardNoticeTopMapper.boardDetailSupport", boardNo);
		model.addAttribute("boardDetail", boardDetail);

		List<BoardFileVO> boardFileList = sqlSession.selectList("BoardNoticeTopMapper.boardFileListSupport", boardNo);
		model.addAttribute("boardFileList", boardFileList);

		model.addAttribute("reqPgNo", reqPgNo);
		model.addAttribute("searchVO", searchVO);

		return "brd_support/board_detail";
	}
	
	@RequestMapping(value = "/lectureBoardDetail", method = RequestMethod.GET)
	public String lectureBoardDetail(Model model, HttpSession session, String boardNo, String reqPgNo, BoardSearchVO searchVO) {
		logger.info("======= lectureBoardDetail =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("lectureBoardDetail - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		if(!boardNo.equals(session.getAttribute("brd_no_Session"))){
			sqlSession.update("BrdLectureMapper.boardAddCnt", boardNo);
		}
		session.setAttribute("brd_no_Session", boardNo);

		BoardVO boardDetail = sqlSession.selectOne("BrdLectureMapper.boardDetail", boardNo);
		model.addAttribute("boardDetail", boardDetail);

		List<BoardFileVO> boardFileList = sqlSession.selectList("BrdLectureMapper.boardFileList", boardNo);
		model.addAttribute("boardFileList", boardFileList);

		model.addAttribute("reqPgNo", reqPgNo);
		model.addAttribute("searchVO", searchVO);

		return "brd_lecture_qna/board_detail";
	}

	@RequestMapping(value = "/noticeTopBoardDetail", method = RequestMethod.GET)
	public String noticeTopBoardDetail(Model model, HttpSession session, String boardNo, String reqPgNo, BoardSearchVO searchVO) {
		logger.info("======= noticeTopBoardDetail =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("noticeTopBoardDetail - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		if(!boardNo.equals(session.getAttribute("brd_no_Session"))){
			sqlSession.update("BoardNoticeTopMapper.boardAddCnt", boardNo);
		}
		session.setAttribute("brd_no_Session", boardNo);

		BoardVO boardDetail = sqlSession.selectOne("BoardNoticeTopMapper.boardDetail", boardNo);
		model.addAttribute("boardDetail", boardDetail);

		List<BoardFileVO> boardFileList = sqlSession.selectList("BoardNoticeTopMapper.boardFileList", boardNo);
		model.addAttribute("boardFileList", boardFileList);

		model.addAttribute("reqPgNo", reqPgNo);
		model.addAttribute("searchVO", searchVO);

		return "brd_notice_top/board_detail";
	}//noticeTopBoardDetail

	@RequestMapping(value = "supportTopBoardDelete", method = RequestMethod.POST)
	public void supportTopBoardDelete(HttpServletResponse response, String boardNo) {
		logger.info("======= supportTopBoardDelete =======");

		int result = 0;
		result = sqlSession.delete("BoardNoticeTopMapper.boardDeleteSupport", boardNo);

		int file_flag = 0;
		int file_result = 0;
		if(result > 0){
			BoardFileUtil bfcu = new BoardFileUtil();
			bfcu.deleteDir("/home/hosting_users/toplac/www/wp_board/data/support/"+boardNo+"/");

			file_flag = bfcu.deleteDirReturnFlag("/home/hosting_users/toplac/www/wp_board/upload/support/"+boardNo+"/");

			file_result = sqlSession.delete("BoardNoticeTopMapper.boardFilesDeleteSupport", boardNo);

			BoardMemoViewVO memoViewVO = new BoardMemoViewVO();
			memoViewVO.setLinkNo(boardNo);
			memoViewVO.setTargetStr("supportTop");
			sqlSession.delete("BoardMemoMapper.boardMemoDeleteByFK", memoViewVO);
		}

		int outMsg = 1;
		if(result < 1 || (file_flag > 0 && file_result < 1)){//게시글 입력 실패 또는 첨부파일 삭제 실패
			outMsg = 0;
		}
		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		if(outMsg > 0){
			out.print(outMsg);
		}
		out.close();

	}
	
	@RequestMapping(value = "lectureBoardDelete", method = RequestMethod.POST)
	public void lectureBoardDelete(HttpServletResponse response, String boardNo) {
		logger.info("======= lectureBoardDelete =======");

		int result = 0;
		result = sqlSession.delete("BrdLectureMapper.boardDelete", boardNo);

		int file_flag = 0;
		int file_result = 0;
		if(result > 0){
			BoardFileUtil bfcu = new BoardFileUtil();
			bfcu.deleteDir("/home/hosting_users/toplac/www/wp_board/data/lecture/"+boardNo+"/");

			file_flag = bfcu.deleteDirReturnFlag("/home/hosting_users/toplac/www/wp_board/upload/lecture/"+boardNo+"/");

			file_result = sqlSession.delete("BrdLectureMapper.boardFilesDelete", boardNo);

			BoardMemoViewVO memoViewVO = new BoardMemoViewVO();
			memoViewVO.setLinkNo(boardNo);
			memoViewVO.setTargetStr("lectureQna");
			sqlSession.delete("BoardMemoMapper.boardMemoDeleteByFK", memoViewVO);
		}

		int outMsg = 1;
		if(result < 1 || (file_flag > 0 && file_result < 1)){//게시글 입력 실패 또는 첨부파일 삭제 실패
			outMsg = 0;
		}
		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		if(outMsg > 0){
			out.print(outMsg);
		}
		out.close();

	}
	
	@RequestMapping(value = "noticeTopBoardDelete", method = RequestMethod.POST)
	public void noticeTopBoardDelete(HttpServletResponse response, String boardNo) {
		logger.info("======= noticeTopBoardDelete =======");

		int result = 0;
		result = sqlSession.delete("BoardNoticeTopMapper.boardDelete", boardNo);

		int file_flag = 0;
		int file_result = 0;
		if(result > 0){
			BoardFileUtil bfcu = new BoardFileUtil();
			bfcu.deleteDir("/home/hosting_users/toplac/www/wp_board/data/notice/"+boardNo+"/");

			file_flag = bfcu.deleteDirReturnFlag("/home/hosting_users/toplac/www/wp_board/upload/notice/"+boardNo+"/");

			file_result = sqlSession.delete("BoardNoticeTopMapper.boardFilesDelete", boardNo);

			BoardMemoViewVO memoViewVO = new BoardMemoViewVO();
			memoViewVO.setLinkNo(boardNo);
			memoViewVO.setTargetStr("noticeTop");
			sqlSession.delete("BoardMemoMapper.boardMemoDeleteByFK", memoViewVO);
		}

		int outMsg = 1;
		if(result < 1 || (file_flag > 0 && file_result < 1)){//게시글 입력 실패 또는 첨부파일 삭제 실패
			outMsg = 0;
		}
		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		if(outMsg > 0){
			out.print(outMsg);
		}
		out.close();

	}//noticeTopBoardDelete
	
	@RequestMapping(value = "/supportTopBoardUpdateForm", method = RequestMethod.GET)
	public String supportTopBoardUpdateForm(Model model, HttpSession session, String boardNo, String reqPgNo, BoardSearchVO searchVO) {
		logger.info("======= supportTopBoardUpdateForm =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("noticeTopBoardUpdateForm - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		BoardVO boardDetail = sqlSession.selectOne("BoardNoticeTopMapper.boardDetailSupport", boardNo);
		model.addAttribute("boardDetail", boardDetail);

		List<BoardFileVO> boardFileList = sqlSession.selectList("BoardNoticeTopMapper.boardFileListSupport", boardNo);
		model.addAttribute("boardFileList", boardFileList);

		model.addAttribute("reqPgNo", reqPgNo);
		model.addAttribute("searchVO", searchVO);

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("tname", "brd_support");
		map.put("cname", "category_id");
		List<SysAdmCodeDicVO> codeList = sqlSession.selectList("CodeDicInsMapper.codeList",map);
		
		model.addAttribute("categoryList",codeList);

		return "brd_support/board_update_form";
	}
	
	@RequestMapping(value = "/lectureBoardUpdateForm", method = RequestMethod.GET)
	public String lectureBoardUpdateForm(Model model, HttpSession session, HttpServletRequest request, String boardNo, String reqPgNo, BoardSearchVO searchVO) {
		logger.info("======= lectureBoardUpdateForm =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("lectureBoardUpdateForm - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

		BoardVO boardDetail = sqlSession.selectOne("BrdLectureMapper.boardDetail", boardNo);
		model.addAttribute("boardDetail", boardDetail);

		List<BoardFileVO> boardFileList = sqlSession.selectList("BrdLectureMapper.boardFileList", boardNo);
		model.addAttribute("boardFileList", boardFileList);

		model.addAttribute("reqPgNo", reqPgNo);
		model.addAttribute("searchVO", searchVO);
		
		//QnA 를 사용하는 교육과정목록 가져오기
		List<Map<String,Object>> qnaLectureList = sqlSession.selectList("LectureMapper.selectLectureProcesslistQna", paramMap);
		
		model.addAttribute("qnaLectureList",qnaLectureList);

		/*
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("tname", "brd_notice_top");
		map.put("cname", "title_classify");

		List<SysAdmCodeDicVO> codeList = sqlSession.selectList("CodeDicInsMapper.codeList",map);

		model.addAttribute("titleClassifyList",codeList);
		*/

		return "brd_lecture_qna/board_update_form";
	}
	
	@RequestMapping(value = "/noticeTopBoardUpdateForm", method = RequestMethod.GET)
	public String noticeTopBoardUpdateForm(Model model, HttpSession session, String boardNo, String reqPgNo, BoardSearchVO searchVO) {
		logger.info("======= noticeTopBoardUpdateForm =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("noticeTopBoardUpdateForm - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		BoardVO boardDetail = sqlSession.selectOne("BoardNoticeTopMapper.boardDetail", boardNo);
		model.addAttribute("boardDetail", boardDetail);

		List<BoardFileVO> boardFileList = sqlSession.selectList("BoardNoticeTopMapper.boardFileList", boardNo);
		model.addAttribute("boardFileList", boardFileList);

		model.addAttribute("reqPgNo", reqPgNo);
		model.addAttribute("searchVO", searchVO);

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("tname", "brd_notice_top");
		map.put("cname", "title_classify");

		List<SysAdmCodeDicVO> codeList = sqlSession.selectList("CodeDicInsMapper.codeList",map);

		model.addAttribute("titleClassifyList",codeList);

		return "brd_notice_top/board_update_form";
	}//noticeTopBoardUpdateForm
	
	@RequestMapping(value = "brdGuideBoardFileDelete", method = RequestMethod.POST)
	public void brdGuideBoardFileDelete(HttpServletResponse response, String fileNo, String filePath, String fileName) {
		logger.info("======= brdGuideBoardFileDelete =======");

		BoardFileVO tmpBoardFreeFileVO = sqlSession.selectOne("BrdGuideMapper.brdGuideFileOneSelect", fileNo);
		filePath = "/home/hosting_users/toplac/www"+tmpBoardFreeFileVO.getFile_path();
		fileName = tmpBoardFreeFileVO.getFile_name();

		File DeleteTarget = new File(filePath+fileName);
		DeleteTarget.delete();

		File DeleteTargetPath = new File(filePath);
		File tmpFileArr [] = DeleteTargetPath.listFiles();
		if(tmpFileArr == null || tmpFileArr.length < 1){
			DeleteTargetPath.delete();
		}
		DeleteTarget.delete();

		int file_result = 0;
		file_result = sqlSession.delete("BrdGuideMapper.boardFileDelete", fileNo);

		int outMsg = 1;
		if(file_result < 1){//첨부파일 삭제 실패
			outMsg = 0;
		}

		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		if(outMsg > 0){
			out.print(outMsg);
		}
		out.close();

	}
	
	@RequestMapping(value = "supportTopBoardFileDelete", method = RequestMethod.POST)
	public void supportTopBoardFileDelete(HttpServletResponse response, String fileNo, String filePath, String fileName) {
		logger.info("======= supportTopBoardFileDelete =======");

		BoardFileVO tmpBoardFreeFileVO = sqlSession.selectOne("BoardNoticeTopMapper.supportTopFileOneSelect", fileNo);
		filePath = "/home/hosting_users/toplac/www"+tmpBoardFreeFileVO.getFile_path();
		fileName = tmpBoardFreeFileVO.getFile_name();

		File DeleteTarget = new File(filePath+fileName);
		DeleteTarget.delete();

		File DeleteTargetPath = new File(filePath);
		File tmpFileArr [] = DeleteTargetPath.listFiles();
		if(tmpFileArr == null || tmpFileArr.length < 1){
			DeleteTargetPath.delete();
		}
		DeleteTarget.delete();

		int file_result = 0;
		file_result = sqlSession.delete("BoardNoticeTopMapper.boardFileDeleteSupport", fileNo);

		int outMsg = 1;
		if(file_result < 1){//첨부파일 삭제 실패
			outMsg = 0;
		}

		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		if(outMsg > 0){
			out.print(outMsg);
		}
		out.close();

	}
	
	@RequestMapping(value = "lectureBoardFileDelete", method = RequestMethod.POST)
	public void lectureBoardFileDelete(HttpServletResponse response, String fileNo, String filePath, String fileName) {
		logger.info("======= lectureBoardFileDelete =======");

		BoardFileVO tmpBoardFreeFileVO = sqlSession.selectOne("BrdLectureMapper.noticeTopFileOneSelect", fileNo);
		filePath = "/home/hosting_users/toplac/www"+tmpBoardFreeFileVO.getFile_path();
		fileName = tmpBoardFreeFileVO.getFile_name();

		File DeleteTarget = new File(filePath+fileName);
		DeleteTarget.delete();

		File DeleteTargetPath = new File(filePath);
		File tmpFileArr [] = DeleteTargetPath.listFiles();
		if(tmpFileArr == null || tmpFileArr.length < 1){
			DeleteTargetPath.delete();
		}
		DeleteTarget.delete();

		int file_result = 0;
		file_result = sqlSession.delete("BrdLectureMapper.boardFileDelete", fileNo);

		int outMsg = 1;
		if(file_result < 1){//첨부파일 삭제 실패
			outMsg = 0;
		}

		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		if(outMsg > 0){
			out.print(outMsg);
		}
		out.close();

	}

	@RequestMapping(value = "noticeTopBoardFileDelete", method = RequestMethod.POST)
	public void noticeTopBoardFileDelete(HttpServletResponse response, String fileNo, String filePath, String fileName) {
		logger.info("======= noticeTopBoardFileDelete =======");

		BoardFileVO tmpBoardFreeFileVO = sqlSession.selectOne("BoardNoticeTopMapper.noticeTopFileOneSelect", fileNo);
		filePath = "/home/hosting_users/toplac/www"+tmpBoardFreeFileVO.getFile_path();
		fileName = tmpBoardFreeFileVO.getFile_name();

		File DeleteTarget = new File(filePath+fileName);
		DeleteTarget.delete();

		File DeleteTargetPath = new File(filePath);
		File tmpFileArr [] = DeleteTargetPath.listFiles();
		if(tmpFileArr == null || tmpFileArr.length < 1){
			DeleteTargetPath.delete();
		}
		DeleteTarget.delete();

		int file_result = 0;
		file_result = sqlSession.delete("BoardNoticeTopMapper.boardFileDelete", fileNo);

		int outMsg = 1;
		if(file_result < 1){//첨부파일 삭제 실패
			outMsg = 0;
		}

		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		if(outMsg > 0){
			out.print(outMsg);
		}
		out.close();

	}//noticeTopBoardFileDelete
	
	@RequestMapping(value = "/supportTopBoardUpdate", method = RequestMethod.POST)
	public String supportTopBoardUpdate(Model model, HttpSession session, HttpServletRequest request, MultipartRequest multipartRequest, BoardVO inVO, BoardSearchVO searchVO) {
		logger.info("======= supportTopBoardUpdate =======");

		/*******게시글 부분 시작*******/
		int result = 0;
		result = sqlSession.update("BoardNoticeTopMapper.boardUpdateSupport", inVO);
		/*******게시글 부분 종료*******/
		/*******첨부 파일 부분 시작*******/
		BoardFileUtil bfcu = new BoardFileUtil();
		String boardNo = "", path = "/home/hosting_users/toplac/www/wp_board/upload/support/";
		int file_flag = 0;
		if(result > 0){
			boardNo = inVO.getBoard_no();
			path = path+boardNo+"/";
			file_flag = bfcu.fileUploadProcessor(multipartRequest, boardNo, path, sqlSession, "BoardNoticeTopMapper.boardFileWriteSupport");
		}//if(result > 0)
		/*******첨부 파일 부분 종료*******/
		/*******게시글에서 수정 전 CKEDITOR 이미지 URL 분리 부분 시작*******/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		String userNo = mbrAuthVo.getUser_no();

		String beforeUpdateCKPath = null;
		beforeUpdateCKPath = bfcu.mvCKFileDirRealToTmp(inVO.getContents(), userNo);

		if(beforeUpdateCKPath != null){
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", boardNo);
			map.put("oldStr", beforeUpdateCKPath);//정식 폴더 경로
			map.put("newStr", "/home/hosting_users/toplac/www/wp_board/data/ckeditor_tmp/"+userNo+"/");//임시 폴더 경로
			sqlSession.update("BoardNoticeTopMapper.updateCKPathSupport", map);//게시글 내부의 정식 폴더 경로를 임시 폴더 경로로 바꾸기

			inVO.setContents(inVO.getContents().replaceAll(beforeUpdateCKPath, "/home/hosting_users/toplac/www/wp_board/data/ckeditor_tmp/"+userNo+"/"));
		}
		//아래 부분을 삭제하면 기존 본문 이미지가 누락됨 by top3009
		//bfcu.deleteDir("/home/hosting_users/toplac/www/wp_board/data/notice/"+boardNo+"/");//정식 폴더 내부 자료 및 정식 폴더 삭제
		/*******게시글에서 수정 전 CKEDITOR 이미지 URL 분리 부분 종료*******/
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 시작*******/
		String ckStrPath = null;
		ckStrPath = bfcu.mvCKFileDirTmpToReal(inVO.getContents(), "notice", boardNo);

		if(ckStrPath != null){
			bfcu.deleteDir(ckStrPath);//임시 폴더 내부 자료 및 임시 폴더 삭제

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", boardNo);
			map.put("oldStr", ckStrPath);//임시 폴더 경로
			map.put("newStr", "/home/hosting_users/toplac/www/wp_board/data/support/"+boardNo+"/");//정식 폴더 경로
			sqlSession.update("BoardNoticeTopMapper.updateCKPathSupport", map);//게시글 내부의 임시 폴더 경로를 정식 폴더 경로로 바꾸기
		}
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 종료*******/

		if(result < 1 || (file_flag < 1)){//게시글 입력 실패 또는 첨부파일 저장 실패
			List<BoardFileVO> boardFileList = sqlSession.selectList("BoardNoticeTopMapper.boardFileListSupport", boardNo);
			model.addAttribute("boardFileList", boardFileList);
			model.addAttribute("boardUpdateFailFlag", 1);
			model.addAttribute("boardDetail", inVO);
			return "brd_notice_top/board_update_form";
		}
		//(게시글 입력 완료 && 첨부파일이 없음) 또는 (게시글 입력 완료 && 첨부파일 저장 성공)
		return "redirect:/supportTopBoardList?updateSuccess=1"
		+"&boardSrcType="+searchVO.getBoardSrcType()
		+"&boardSrcWord="+searchVO.getBoardSrcWord()
		+"&cateSearch="+searchVO.getCateSearch()
		+"&reqPgNo="+searchVO.getReqPgNo();
	}
	
	@RequestMapping(value = "/lectureBoardUpdate", method = RequestMethod.POST)
	public String lectureBoardUpdate(Model model, HttpSession session, HttpServletRequest request, MultipartRequest multipartRequest, BoardVO inVO, BoardSearchVO searchVO) {
		logger.info("======= lectureBoardUpdate =======");

		/*******게시글 부분 시작*******/
		int result = 0;
		
		String titleSelect = request.getParameter("titleSelect") != null ? request.getParameter("titleSelect") : "0";
		String boardType = request.getParameter("boardType") != null ? request.getParameter("boardType") : "0";
		inVO.setPkey(titleSelect);
		inVO.setBoard_type(boardType);
		
		result = sqlSession.update("BrdLectureMapper.boardUpdate", inVO);
		/*******게시글 부분 종료*******/
		/*******첨부 파일 부분 시작*******/
		BoardFileUtil bfcu = new BoardFileUtil();
		String boardNo = "", path = "/home/hosting_users/toplac/www/wp_board/upload/lecture/";
		int file_flag = 0;
		if(result > 0){
			boardNo = inVO.getBoard_no();
			path = path+boardNo+"/";
			file_flag = bfcu.fileUploadProcessor(multipartRequest, boardNo, path, sqlSession, "BrdLectureMapper.boardFileWrite");
		}//if(result > 0)
		/*******첨부 파일 부분 종료*******/
		/*******게시글에서 수정 전 CKEDITOR 이미지 URL 분리 부분 시작*******/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		String userNo = mbrAuthVo.getUser_no();

		String beforeUpdateCKPath = null;
		beforeUpdateCKPath = bfcu.mvCKFileDirRealToTmp(inVO.getContents(), userNo);

		if(beforeUpdateCKPath != null){
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", boardNo);
			map.put("oldStr", beforeUpdateCKPath);//정식 폴더 경로
			map.put("newStr", "/home/hosting_users/toplac/www/wp_board/data/ckeditor_tmp/"+userNo+"/");//임시 폴더 경로
			sqlSession.update("BoardNoticeTopMapper.updateCKPath", map);//게시글 내부의 정식 폴더 경로를 임시 폴더 경로로 바꾸기

			inVO.setContents(inVO.getContents().replaceAll(beforeUpdateCKPath, "/home/hosting_users/toplac/www/wp_board/data/ckeditor_tmp/"+userNo+"/"));
		}
		//아래 부분을 삭제하면 기존 본문 이미지가 누락됨 by top3009
		//bfcu.deleteDir("/home/hosting_users/toplac/www/wp_board/data/notice/"+boardNo+"/");//정식 폴더 내부 자료 및 정식 폴더 삭제
		/*******게시글에서 수정 전 CKEDITOR 이미지 URL 분리 부분 종료*******/
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 시작*******/
		String ckStrPath = null;
		ckStrPath = bfcu.mvCKFileDirTmpToReal(inVO.getContents(), "notice", boardNo);

		if(ckStrPath != null){
			bfcu.deleteDir(ckStrPath);//임시 폴더 내부 자료 및 임시 폴더 삭제

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", boardNo);
			map.put("oldStr", ckStrPath);//임시 폴더 경로
			map.put("newStr", "/home/hosting_users/toplac/www/wp_board/data/lecture/"+boardNo+"/");//정식 폴더 경로
			sqlSession.update("BrdLectureMapper.updateCKPath", map);//게시글 내부의 임시 폴더 경로를 정식 폴더 경로로 바꾸기
		}
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 종료*******/

		if(result < 1 || (file_flag < 1)){//게시글 입력 실패 또는 첨부파일 저장 실패
			List<BoardFileVO> boardFileList = sqlSession.selectList("BrdLectureMapper.boardFileList", boardNo);
			model.addAttribute("boardFileList", boardFileList);
			model.addAttribute("boardUpdateFailFlag", 1);
			model.addAttribute("boardDetail", inVO);
			return "brd_lecture_qna/board_update_form";
		}
		//(게시글 입력 완료 && 첨부파일이 없음) 또는 (게시글 입력 완료 && 첨부파일 저장 성공)
		return "redirect:/brdLectureBoardList?updateSuccess=1"
		+"&boardSrcType="+searchVO.getBoardSrcType()
		+"&boardSrcWord="+searchVO.getBoardSrcWord()
		+"&titleSearch="+searchVO.getTitleSearch()
		+"&boardType="+searchVO.getBoardType()
		+"&reqPgNo="+searchVO.getReqPgNo();
	}

	@RequestMapping(value = "/noticeTopBoardUpdate", method = RequestMethod.POST)
	public String noticeTopBoardUpdate(Model model, HttpSession session, HttpServletRequest request, MultipartRequest multipartRequest
			, BoardVO inVO, BoardSearchVO searchVO) {
		logger.info("======= noticeTopBoardUpdate =======");

		/*******게시글 부분 시작*******/
		int result = 0;
		result = sqlSession.update("BoardNoticeTopMapper.boardUpdate", inVO);
		/*******게시글 부분 종료*******/
		/*******첨부 파일 부분 시작*******/
		BoardFileUtil bfcu = new BoardFileUtil();
		String boardNo = "", path = "/home/hosting_users/toplac/www/wp_board/upload/notice/";
		int file_flag = 0;
		if(result > 0){
			boardNo = inVO.getBoard_no();
			path = path+boardNo+"/";
			file_flag = bfcu.fileUploadProcessor(multipartRequest, boardNo, path, sqlSession, "BoardNoticeTopMapper.boardFileWrite");
		}//if(result > 0)
		/*******첨부 파일 부분 종료*******/
		/*******게시글에서 수정 전 CKEDITOR 이미지 URL 분리 부분 시작*******/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		String userNo = mbrAuthVo.getUser_no();

		String beforeUpdateCKPath = null;
		beforeUpdateCKPath = bfcu.mvCKFileDirRealToTmp(inVO.getContents(), userNo);

		if(beforeUpdateCKPath != null){
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", boardNo);
			map.put("oldStr", beforeUpdateCKPath);//정식 폴더 경로
			map.put("newStr", "/home/hosting_users/toplac/www/wp_board/data/ckeditor_tmp/"+userNo+"/");//임시 폴더 경로
			sqlSession.update("BoardNoticeTopMapper.updateCKPath", map);//게시글 내부의 정식 폴더 경로를 임시 폴더 경로로 바꾸기

			inVO.setContents(inVO.getContents().replaceAll(beforeUpdateCKPath, "/home/hosting_users/toplac/www/wp_board/data/ckeditor_tmp/"+userNo+"/"));
		}
		//아래 부분을 삭제하면 기존 본문 이미지가 누락됨 by top3009
		//bfcu.deleteDir("/home/hosting_users/toplac/www/wp_board/data/notice/"+boardNo+"/");//정식 폴더 내부 자료 및 정식 폴더 삭제
		/*******게시글에서 수정 전 CKEDITOR 이미지 URL 분리 부분 종료*******/
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 시작*******/
		String ckStrPath = null;
		ckStrPath = bfcu.mvCKFileDirTmpToReal(inVO.getContents(), "notice", boardNo);

		if(ckStrPath != null){
			bfcu.deleteDir(ckStrPath);//임시 폴더 내부 자료 및 임시 폴더 삭제

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", boardNo);
			map.put("oldStr", ckStrPath);//임시 폴더 경로
			map.put("newStr", "/home/hosting_users/toplac/www/wp_board/data/notice/"+boardNo+"/");//정식 폴더 경로
			sqlSession.update("BoardNoticeTopMapper.updateCKPath", map);//게시글 내부의 임시 폴더 경로를 정식 폴더 경로로 바꾸기
		}
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 종료*******/

		if(result < 1 || (file_flag < 1)){//게시글 입력 실패 또는 첨부파일 저장 실패
			List<BoardFileVO> boardFileList = sqlSession.selectList("BoardNoticeTopMapper.boardFileList", boardNo);
			model.addAttribute("boardFileList", boardFileList);
			model.addAttribute("boardUpdateFailFlag", 1);
			model.addAttribute("boardDetail", inVO);
			return "brd_notice_top/board_update_form";
		}
		//(게시글 입력 완료 && 첨부파일이 없음) 또는 (게시글 입력 완료 && 첨부파일 저장 성공)
		return "redirect:/noticeTopBoardList?updateSuccess=1"
		+"&boardSrcType="+searchVO.getBoardSrcType()
		+"&boardSrcWord="+searchVO.getBoardSrcWord()
		+"&titleSearch="+searchVO.getTitleSearch()
		+"&reqPgNo="+searchVO.getReqPgNo();
	}//noticeTopBoardUpdate
	
	@RequestMapping(value = "/supportTopBoardPrint", method = RequestMethod.GET)
	public String supportTopBoardPrint(Model model, HttpSession session, String boardNo) {
		logger.info("======= supportTopBoardPrint =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("noticeTopBoardPrint - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		BoardVO boardDetail = sqlSession.selectOne("BoardNoticeTopMapper.boardDetailSupport", boardNo);
		model.addAttribute("boardDetail", boardDetail);

		return "brd_support/board_print_pop";
	}

	@RequestMapping(value = "/noticeTopBoardPrint", method = RequestMethod.GET)
	public String noticeTopBoardPrint(Model model, HttpSession session, String boardNo) {
		logger.info("======= noticeTopBoardPrint =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("noticeTopBoardPrint - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		BoardVO boardDetail = sqlSession.selectOne("BoardNoticeTopMapper.boardDetail", boardNo);
		model.addAttribute("boardDetail", boardDetail);

		return "brd_notice_top/board_print_pop";
	}//noticeTopBoardPrint
	
	@RequestMapping(value = "/lectureBoardPrint", method = RequestMethod.GET)
	public String lectureBoardPrint(Model model, HttpSession session, String boardNo) {
		logger.info("======= lectureBoardPrint =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("lectureBoardPrint - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		BoardVO boardDetail = sqlSession.selectOne("BrdLectureMapper.boardDetail", boardNo);
		model.addAttribute("boardDetail", boardDetail);

		return "brd_lecture_qna/board_print_pop";
	}//noticeTopBoardPrint

	@RequestMapping(value = "noticeTopReWrite", method = RequestMethod.POST)
	public void noticeTopReWrite(HttpServletResponse response, String boardNo) {
		logger.info("======= noticeTopReWrite =======");

		BoardVO boardDetail = sqlSession.selectOne("BoardNoticeTopMapper.boardDetail", boardNo);

		int result = 0;
		result = sqlSession.insert("BoardNoticeTopMapper.boardWrite2", boardDetail);

		if(result > 0){
			String newBoardNo = sqlSession.selectOne("BoardNoticeTopMapper.getBoardNo", boardDetail);

			File attachFileDir = new File("/home/hosting_users/toplac/www/wp_board/upload/notice/"+boardNo+"/");
			if(attachFileDir.exists()){
				File attachFileDir2 = new File("/home/hosting_users/toplac/www/wp_board/upload/notice/"+newBoardNo+"/");
				attachFileDir.renameTo(attachFileDir2);
			}
			File ckFileDir = new File("/home/hosting_users/toplac/www/wp_board/data/notice/"+boardNo+"/");
			if(ckFileDir.exists()){
				File ckFileDir2 = new File("/home/hosting_users/toplac/www/wp_board/data/notice/"+newBoardNo+"/");
				ckFileDir.renameTo(ckFileDir2);
			}

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", boardNo);
			map.put("newBoardNo", newBoardNo);
			map.put("attachFileDir", "/"+boardNo+"/");
			map.put("attachFileDir2", "/"+newBoardNo+"/");
			map.put("ckFileDir", "/home/hosting_users/toplac/www/wp_board/data/notice/"+boardNo+"/");
			map.put("ckFileDir2", "/home/hosting_users/toplac/www/wp_board/data/notice/"+newBoardNo+"/");

			sqlSession.update("BoardNoticeTopMapper.updateCKPath2", map);
			sqlSession.update("BoardNoticeTopMapper.updateBoardFiles", map);
			sqlSession.update("BoardNoticeTopMapper.updateBoardMemos", map);
			sqlSession.delete("BoardNoticeTopMapper.boardDelete", boardNo);
		}

		int outMsg = 1;
		if(result < 1){//실패
			outMsg = 0;
		}
		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		if(outMsg > 0){
			out.print(outMsg);
		}
		out.close();

	}//noticeTopReWrite

}//end of class
