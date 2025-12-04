/*
*********************************************************
* Program ID	: BoardReferenceTopController
* Program Name	: BoardReferenceTopController
* Description	: 탑자료실
* Author		: 
* Date			: 2016.06.11.
*********************************************************
*/
package kr.co.toplac.brd.referencetop;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartRequest;

import kr.co.toplac.brd.common.BoardFileUtil;
import kr.co.toplac.brd.common.BoardFileVO;
import kr.co.toplac.brd.common.BoardMemoViewVO;
import kr.co.toplac.brd.common.BoardPageUtil;
import kr.co.toplac.brd.common.BoardSearchVO;
import kr.co.toplac.brd.common.BoardVO;
import kr.co.toplac.sysadm.SysAdmCodeDicVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.rpt.MainLeftUtil;

@Controller
public class BoardReferenceTopController {

	private static final Logger logger = LoggerFactory.getLogger(BoardReferenceTopController.class);

	@Autowired
	SqlSession sqlSession;

	@Autowired
	MainLeftUtil mlu;
	
	/**
     * 다중 첨부파일 다운로드 Modal
     */
    @RequestMapping(value="/referencePtnrBoardDetailModal")
    public String noticeTopBoardDetailModal(HttpServletRequest request, Model model) {
    	
    	logger.info("========= noticeTopBoardDetailModal =========");    	
    	
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sBoardNo = paramMap.get("board_no").toString();
		
		List<Map<String,Object>> boardDetailFile = sqlSession.selectList("BoardReferencePtnrMapper.getBoardFileList", sBoardNo);
		
		String sTitle = boardDetailFile.get(0).get("title").toString();
		
		model.addAttribute("boardTitle", sTitle);
		model.addAttribute("boardDetailFile", boardDetailFile);
    	
    	return "brd_reference_ptnr/board_attach_modal";
    }
    
    /**
     * 글분류 변경 Modal
     */
    @RequestMapping(value="/referenceCategoryDetailModal")
    public String referenceCategoryDetailModal(HttpServletRequest request, Model model) {
    	
    	logger.info("========= referenceCategoryDetailModal =========");    	
    	
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		/* 종목 목록 */
		HashMap<String, String> eventCode = new HashMap<String, String>();
		eventCode.put("tname", "brd_ref_report");
		eventCode.put("cname", "cate_code");
		List<SysAdmCodeDicVO> cateList = sqlSession.selectList("CodeDicInsMapper.codeList",eventCode);
		model.addAttribute("cateList",cateList);
		
		String sBoardNo = paramMap.get("board_no").toString();
		
		BoardVO boardDetail = sqlSession.selectOne("BoardReferenceTopMapper.boardDetail", sBoardNo);
		model.addAttribute("boardDetail", boardDetail);
    	
    	return "brd_reference_top_new/board_category_modal";
    }
        
	@ResponseBody
    @RequestMapping(value="/referenceTopBoardCategoryUpdate")
    public int referenceTopBoardCategoryUpdate(HttpServletRequest request, Model model) {
    	
    	logger.info("========= referenceTopBoardCategoryUpdate =========");    	
    	
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		int nRet = sqlSession.update("BoardReferenceTopMapper.boardCategoryUpdate",paramMap);
		
    	return nRet;
    }
	
	/**
     * 다중 첨부파일 다운로드 Modal
     */
    @RequestMapping(value="/referenceTopBoardDetailModal")
    public String referenceTopBoardDetailModal(HttpServletRequest request, Model model) {
    	
    	logger.info("========= referenceTopBoardDetailModal =========");    	
    	
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sBoardNo = paramMap.get("board_no").toString();
		
		List<Map<String,Object>> boardDetailFile = sqlSession.selectList("BoardReferenceTopMapper.getBoardFileList", sBoardNo);
		
		String sTitle = boardDetailFile.get(0).get("title").toString();
		
		model.addAttribute("boardTitle", sTitle);
		model.addAttribute("boardDetailFile", boardDetailFile);
    	
    	return "brd_reference_top_new/board_attach_modal";
    }
		
	@RequestMapping(value = "/referenceTopBoardWriteFormNew", method = RequestMethod.GET)
	public String referenceTopBoardWriteFormNew(Model model, HttpSession session, HttpServletRequest request, BoardSearchVO searchVO) {
		logger.info("======= referenceTopBoardWriteFormNew =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String cateSearch = searchVO.getCateSearch();
		
		if(mbrVo == null){
			logger.info("refReportBoardWriteForm - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		/* 종목 목록 */
		HashMap<String, String> eventCode = new HashMap<String, String>();
		eventCode.put("tname", "brd_ref_report");
		eventCode.put("cname", "event_code");
		List<SysAdmCodeDicVO> eventList = sqlSession.selectList("CodeDicInsMapper.codeList",eventCode);
		model.addAttribute("eventList",eventList);
		
		/* 유형 목록 */
		HashMap<String, String> typeCode = new HashMap<String, String>();
		typeCode.put("tname", "brd_ref_report");
		typeCode.put("cname", "type_code");
		List<SysAdmCodeDicVO> typeList = sqlSession.selectList("CodeDicInsMapper.codeList",typeCode);
		model.addAttribute("typeList",typeList);
		
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		String mbr_pms_39 = mbrAuthVo.getMbr_pms_39().toString();
		
		if( Integer.parseInt(cateSearch) > 1 && "0".contentEquals(mbr_pms_39) ) {
			logger.info("referenceTopBoardWriteFormNew - no Auth : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());		
		
		model.addAttribute("searchVO",searchVO);

		return "brd_reference_top_new/board_write_form";
	}
	
	@RequestMapping(value = "/topReferenceTopBoardListAjax", method = RequestMethod.POST)
	public String topReferenceTopBoardListAjax(Model model, HttpServletRequest request, HttpSession session, BoardSearchVO searchVO, String boardWriteSuccess, String boardUpdateSuccess) {
		logger.info("======= topReferenceTopBoardListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		BoardPageUtil pageUtil = new BoardPageUtil();
		
		List<BoardVO> boardList	= (List<BoardVO>) pageUtil.boardPageSearch2(1, sqlSession, "BoardReferenceTopMapper.boardList", searchVO, model, "referenceTopBoardList");
		
		int boardListCnt = sqlSession.selectOne("BoardReferenceTopMapper.boardListCnt", searchVO);

		model.addAttribute("boardList", boardList);
		model.addAttribute("boardListCnt", boardListCnt);
		model.addAttribute("reqPgNo", paramMap.get("reqPgNo"));
		model.addAttribute("boardWriteSuccess", boardWriteSuccess);
		model.addAttribute("boardUpdateSuccess", boardUpdateSuccess);
		model.addAttribute("searchVO", searchVO);		
		
		return "brd_reference_top_new/board_list_ajax";
	}
	
	@RequestMapping(value = "/referenceTopBoardListNew", method = RequestMethod.GET)
	public String referenceTopBoardListNew(Model model, HttpServletRequest request, HttpSession session, String boardWriteSuccess, String boardUpdateSuccess, BoardSearchVO searchVO) {
		logger.info("======= referenceTopBoardListNew =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("referenceTopBoardList - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		String cateSearch = request.getParameter("cateSearch") != null ? request.getParameter("cateSearch") : "0";			//기본 탭
		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());
		
		/* 종목 목록 */
		HashMap<String, String> eventCode = new HashMap<String, String>();
		eventCode.put("tname", "brd_ref_report");
		eventCode.put("cname", "event_code");
		List<SysAdmCodeDicVO> eventList = sqlSession.selectList("CodeDicInsMapper.codeList",eventCode);
		model.addAttribute("eventList",eventList);
		
		/* 유형 목록 */
		HashMap<String, String> typeCode = new HashMap<String, String>();
		typeCode.put("tname", "brd_ref_report");
		typeCode.put("cname", "type_code");
		List<SysAdmCodeDicVO> typeList = sqlSession.selectList("CodeDicInsMapper.codeList",typeCode);
		model.addAttribute("typeList",typeList);

		BoardPageUtil pageUtil = new BoardPageUtil();
		List<BoardVO> boardList
		= (List<BoardVO>) pageUtil.boardPageSearch1(1, sqlSession, "BoardReferenceTopMapper.boardList", searchVO, model, "referenceTopBoardList");

		model.addAttribute("boardList", boardList);
		model.addAttribute("boardWriteSuccess", boardWriteSuccess);
		model.addAttribute("boardUpdateSuccess", boardUpdateSuccess);
		model.addAttribute("searchVO", searchVO);
		
		model.addAttribute("cateSearch",cateSearch);

		return "brd_reference_top_new/board_list";
	}

	@RequestMapping(value = "/referenceTopBoardList", method = RequestMethod.GET)
	public String referenceTopBoardList(Model model, HttpSession session
			, String boardWriteSuccess, String boardUpdateSuccess, BoardSearchVO searchVO) {
		logger.info("======= referenceTopBoardList =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("referenceTopBoardList - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		BoardPageUtil pageUtil = new BoardPageUtil();
		List<BoardVO> boardList
		= (List<BoardVO>) pageUtil.boardPageSearch1(1, sqlSession, "BoardReferenceTopMapper.boardList", searchVO, model, "referenceTopBoardList");

		model.addAttribute("boardList", boardList);
		model.addAttribute("boardWriteSuccess", boardWriteSuccess);
		model.addAttribute("boardUpdateSuccess", boardUpdateSuccess);
		model.addAttribute("searchVO", searchVO);

		return "brd_reference_top/board_list";
	}//referenceTopBoardList

	@RequestMapping(value = "/referenceTopBoardWriteForm", method = RequestMethod.GET)
	public String referenceTopBoardWriteForm(Model model, HttpSession session) {
		logger.info("======= referenceTopBoardWriteForm =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("referenceTopBoardWriteForm - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		return "brd_reference_top/board_write_form";
	}//referenceTopBoardWriteForm

	@RequestMapping(value = "/referenceTopBoardWrite", method = RequestMethod.POST)
	public String referenceTopBoardWrite(Model model, HttpSession session, HttpServletRequest request, MultipartRequest multipartRequest, BoardVO inVO) {
		logger.info("======= referenceTopBoardWrite =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String cateSearch = paramMap.get("cateSearch").toString();		
		
		inVO.setCategory_id(paramMap.get("cateSearch").toString());		
		inVO.setEvent_id(paramMap.get("eventSelect").toString());
		inVO.setType_id(paramMap.get("typeSelect").toString());

		/*******게시글 부분 시작*******/
		int result = 0;
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		inVO.setUser_no(mbrAuthVo.getUser_no());
		inVO.setReg_ip(request.getRemoteAddr());
		result = sqlSession.insert("BoardReferenceTopMapper.boardWrite", inVO);
		/*******게시글 부분 종료*******/
		/*******첨부 파일 부분 시작*******/
		BoardFileUtil bfcu = new BoardFileUtil();
		String boardNo = "", path = "/home/hosting_users/toplac/www/wp_board/upload/pds/";
		int file_flag = 0;
		if(result > 0){
			boardNo = sqlSession.selectOne("BoardReferenceTopMapper.getBoardNo", inVO);
			path = path+boardNo+"/";
			file_flag = bfcu.fileUploadProcessor(multipartRequest, boardNo, path, sqlSession, "BoardReferenceTopMapper.boardFileWrite");
		}//if(result > 0)
		/*******첨부 파일 부분 종료*******/
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 시작*******/
		String ckStrPath = null;
		ckStrPath = bfcu.mvCKFileDirTmpToReal(inVO.getContents(), "pds", boardNo);

		if(ckStrPath != null){
			bfcu.deleteDir(ckStrPath);//임시 폴더 내부 자료 및 임시 폴더 삭제

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", boardNo);
			map.put("oldStr", ckStrPath);//임시 폴더 경로
			map.put("newStr", "/home/hosting_users/toplac/www/wp_board/data/pds/"+boardNo+"/");//정식 폴더 경로
			sqlSession.update("BoardReferenceTopMapper.updateCKPath", map);//게시글 내부의 임시 폴더 경로를 정식 폴더 경로로 바꾸기
		}
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 종료*******/

		if(result < 1 || (file_flag < 1)){//게시글 입력 실패 또는 첨부파일 저장 실패
			model.addAttribute("boardWriteFailVO", inVO);
			return "brd_reference_top_new/board_write_form";
		}
		//(게시글 입력 완료 && 첨부파일이 없음) 또는 (게시글 입력 완료 && 첨부파일 저장 성공)
		//return "redirect:/referenceTopBoardList?boardWriteSuccess=1";
		return "redirect:/referenceTopBoardListNew?boardWriteSuccess=1&cateSearch="+cateSearch;		
	}//referenceTopBoardWrite
	
	@RequestMapping(value = "/referenceTopBoardDetailNew", method = RequestMethod.GET)
	public String referenceTopBoardDetailNew(Model model, HttpSession session, String boardNo, String reqPgNo, BoardSearchVO searchVO) {
		logger.info("======= referenceTopBoardDetailNew =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("referenceTopBoardDetailNew - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		if(!boardNo.equals(session.getAttribute("brd_no_Session"))){
			sqlSession.update("BoardReferenceTopMapper.boardAddCnt", boardNo);
		}
		session.setAttribute("brd_no_Session", boardNo);

		BoardVO boardDetail = sqlSession.selectOne("BoardReferenceTopMapper.boardDetail", boardNo);
		model.addAttribute("boardDetail", boardDetail);

		List<BoardFileVO> boardFileList = sqlSession.selectList("BoardReferenceTopMapper.boardFileList", boardNo);
		model.addAttribute("boardFileList", boardFileList);

		model.addAttribute("reqPgNo", reqPgNo);
		model.addAttribute("searchVO", searchVO);

		return "brd_reference_top_new/board_detail";
	}

	@RequestMapping(value = "/referenceTopBoardDetail", method = RequestMethod.GET)
	public String referenceTopBoardDetail(Model model, HttpSession session, String boardNo, String reqPgNo, BoardSearchVO searchVO) {
		logger.info("======= referenceTopBoardDetail =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("referenceTopBoardDetail - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		if(!boardNo.equals(session.getAttribute("brd_no_Session"))){
			sqlSession.update("BoardReferenceTopMapper.boardAddCnt", boardNo);
		}
		session.setAttribute("brd_no_Session", boardNo);

		BoardVO boardDetail = sqlSession.selectOne("BoardReferenceTopMapper.boardDetail", boardNo);
		model.addAttribute("boardDetail", boardDetail);

		List<BoardFileVO> boardFileList = sqlSession.selectList("BoardReferenceTopMapper.boardFileList", boardNo);
		model.addAttribute("boardFileList", boardFileList);

		model.addAttribute("reqPgNo", reqPgNo);
		model.addAttribute("searchVO", searchVO);

		return "brd_reference_top/board_detail";
	}//referenceTopBoardDetail

	@RequestMapping(value = "referenceTopBoardDelete", method = RequestMethod.POST)
	public void referenceTopBoardDelete(HttpServletResponse response, String boardNo) {
		logger.info("======= referenceTopBoardDelete =======");

		int result = 0;
		result = sqlSession.delete("BoardReferenceTopMapper.boardDelete", boardNo);

		int file_flag = 0;
		int file_result = 0;
		if(result > 0){
			BoardFileUtil bfcu = new BoardFileUtil();
			bfcu.deleteDir("/home/hosting_users/toplac/www/wp_board/data/pds/"+boardNo+"/");

			file_flag = bfcu.deleteDirReturnFlag("/home/hosting_users/toplac/www/wp_board/upload/pds/"+boardNo+"/");

			file_result = sqlSession.delete("BoardReferenceTopMapper.boardFilesDelete", boardNo);

			BoardMemoViewVO memoViewVO = new BoardMemoViewVO();
			memoViewVO.setLinkNo(boardNo);
			memoViewVO.setTargetStr("referenceTop");
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

	}//referenceTopBoardDelete

	@RequestMapping(value = "/referenceTopBoardUpdateForm", method = RequestMethod.GET)
	public String referenceTopBoardUpdateForm(Model model, HttpSession session, String boardNo, String reqPgNo, BoardSearchVO searchVO) {
		logger.info("======= referenceTopBoardUpdateForm =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("referenceTopBoardUpdateForm - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		/* 종목 목록 */
		HashMap<String, String> eventCode = new HashMap<String, String>();
		eventCode.put("tname", "brd_ref_report");
		eventCode.put("cname", "event_code");
		List<SysAdmCodeDicVO> eventList = sqlSession.selectList("CodeDicInsMapper.codeList",eventCode);
		model.addAttribute("eventList",eventList);
		
		/* 유형 목록 */
		HashMap<String, String> typeCode = new HashMap<String, String>();
		typeCode.put("tname", "brd_ref_report");
		typeCode.put("cname", "type_code");
		List<SysAdmCodeDicVO> typeList = sqlSession.selectList("CodeDicInsMapper.codeList",typeCode);
		model.addAttribute("typeList",typeList);
		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		BoardVO boardDetail = sqlSession.selectOne("BoardReferenceTopMapper.boardDetail", boardNo);
		model.addAttribute("boardDetail", boardDetail);

		List<BoardFileVO> boardFileList = sqlSession.selectList("BoardReferenceTopMapper.boardFileList", boardNo);
		model.addAttribute("boardFileList", boardFileList);

		model.addAttribute("reqPgNo", reqPgNo);
		model.addAttribute("searchVO", searchVO);

		return "brd_reference_top_new/board_update_form";
	}//referenceTopBoardUpdateForm

	@RequestMapping(value = "referenceTopBoardFileDelete", method = RequestMethod.POST)
	public void referenceTopBoardFileDelete(HttpServletResponse response, String fileNo, String filePath, String fileName) {
		logger.info("======= referenceTopBoardFileDelete =======");

		BoardFileVO tmpBoardFreeFileVO = sqlSession.selectOne("BoardReferenceTopMapper.refTopFileOneSelect", fileNo);
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
		file_result = sqlSession.delete("BoardReferenceTopMapper.boardFileDelete", fileNo);

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

	}//referenceTopBoardFileDelete

	@RequestMapping(value = "/referenceTopBoardUpdate", method = RequestMethod.POST)
	public String referenceTopBoardUpdate(Model model, HttpSession session, HttpServletRequest request, MultipartRequest multipartRequest
			, BoardVO inVO, BoardSearchVO searchVO) {
		logger.info("======= referenceTopBoardUpdate =======");

		/*******게시글 부분 시작*******/
		int result = 0;
		result = sqlSession.update("BoardReferenceTopMapper.boardUpdate", inVO);
		/*******게시글 부분 종료*******/
		/*******첨부 파일 부분 시작*******/
		BoardFileUtil bfcu = new BoardFileUtil();
		String boardNo = "", path = "/home/hosting_users/toplac/www/wp_board/upload/pds/";
		int file_flag = 0;
		if(result > 0){
			boardNo = inVO.getBoard_no();
			path = path+boardNo+"/";
			file_flag = bfcu.fileUploadProcessor(multipartRequest, boardNo, path, sqlSession, "BoardReferenceTopMapper.boardFileWrite");
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
			sqlSession.update("BoardReferenceTopMapper.updateCKPath", map);//게시글 내부의 정식 폴더 경로를 임시 폴더 경로로 바꾸기

			inVO.setContents(inVO.getContents().replaceAll(beforeUpdateCKPath, "/home/hosting_users/toplac/www/wp_board/data/ckeditor_tmp/"+userNo+"/"));
		}
		//아래 부분을 삭제하면 기존 본문 이미지가 누락됨 by top3009
		//bfcu.deleteDir("/home/hosting_users/toplac/www/wp_board/data/pds/"+boardNo+"/");//정식 폴더 내부 자료 및 정식 폴더 삭제
		/*******게시글에서 수정 전 CKEDITOR 이미지 URL 분리 부분 종료*******/
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 시작*******/
		String ckStrPath = null;
		ckStrPath = bfcu.mvCKFileDirTmpToReal(inVO.getContents(), "pds", boardNo);

		if(ckStrPath != null){
			bfcu.deleteDir(ckStrPath);//임시 폴더 내부 자료 및 임시 폴더 삭제

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", boardNo);
			map.put("oldStr", ckStrPath);//임시 폴더 경로
			map.put("newStr", "/home/hosting_users/toplac/www/wp_board/data/pds/"+boardNo+"/");//정식 폴더 경로
			sqlSession.update("BoardReferenceTopMapper.updateCKPath", map);//게시글 내부의 임시 폴더 경로를 정식 폴더 경로로 바꾸기
		}
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 종료*******/

		if(result < 1 || (file_flag < 1)){//게시글 입력 실패 또는 첨부파일 저장 실패
			List<BoardFileVO> boardFileList = sqlSession.selectList("BoardReferenceTopMapper.boardFileList", boardNo);
			model.addAttribute("boardFileList", boardFileList);
			model.addAttribute("boardUpdateFailFlag", 1);
			model.addAttribute("boardDetail", inVO);
			return "brd_reference_top_new/board_update_form";
		}
		//(게시글 입력 완료 && 첨부파일이 없음) 또는 (게시글 입력 완료 && 첨부파일 저장 성공)
		return "redirect:/referenceTopBoardListNew?updateSuccess=1"
		+"&boardSrcType="+searchVO.getBoardSrcType()
		+"&boardSrcWord="+searchVO.getBoardSrcWord()
		+"&reqPgNo="+searchVO.getReqPgNo()
		+"&cateSearch="+searchVO.getCateSearch();
	}//referenceTopBoardUpdate

	@RequestMapping(value = "/referenceTopBoardPrint", method = RequestMethod.GET)
	public String referenceTopBoardPrint(Model model, HttpSession session, String boardNo) {
		logger.info("======= referenceTopBoardPrint =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("referenceTopBoardPrint - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		BoardVO boardDetail = sqlSession.selectOne("BoardReferenceTopMapper.boardDetail", boardNo);
		model.addAttribute("boardDetail", boardDetail);

		return "brd_common/board_print_pop";
	}//referenceTopBoardPrint

}//end of class
