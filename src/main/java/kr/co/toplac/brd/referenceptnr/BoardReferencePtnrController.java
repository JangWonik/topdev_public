/*
*********************************************************
* Program ID	: BoardReferencePtnrController
* Program Name	: BoardReferencePtnrController
* Description	: 보험사자료실
* Author		: 
* Date			: 2016.06.11.
*********************************************************
*/
package kr.co.toplac.brd.referenceptnr;

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
import org.springframework.web.multipart.MultipartRequest;

import kr.co.toplac.brd.common.BoardFileUtil;
import kr.co.toplac.brd.common.BoardFileVO;
import kr.co.toplac.brd.common.BoardMemoViewVO;
import kr.co.toplac.brd.common.BoardPageUtil;
import kr.co.toplac.brd.common.BoardSearchVO;
import kr.co.toplac.brd.common.BoardVO;
import kr.co.toplac.sysadm.SysAdmCodeDicVO;
import kr.co.toplac.topptnr.TopPtnrBscVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.rpt.MainLeftUtil;

@Controller
public class BoardReferencePtnrController {

	private static final Logger logger = LoggerFactory.getLogger(BoardReferencePtnrController.class);

	@Autowired
	SqlSession sqlSession;

	@Autowired
	MainLeftUtil mlu;
	
	@RequestMapping(value = "/topReferencePtnrBoardListAjax", method = RequestMethod.POST)
	public String topReferencePtnrBoardListAjax(Model model, HttpServletRequest request, HttpSession session, BoardSearchVO searchVO, String boardWriteSuccess, String boardUpdateSuccess) {
		logger.info("======= topReferencePtnrBoardListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
				
		BoardPageUtil pageUtil = new BoardPageUtil();
		List<BoardVO> boardList	= (List<BoardVO>) pageUtil.boardPageSearch2(1, sqlSession, "BoardReferencePtnrMapper.boardList", searchVO, model, "referencePtnrBoardList");
		
		int boardListCnt = sqlSession.selectOne("BoardReferencePtnrMapper.boardListCnt", searchVO);

		model.addAttribute("boardList", boardList);
		model.addAttribute("boardListCnt", boardListCnt);
		model.addAttribute("reqPgNo", paramMap.get("reqPgNo"));
		model.addAttribute("boardWriteSuccess", boardWriteSuccess);
		model.addAttribute("boardUpdateSuccess", boardUpdateSuccess);
		model.addAttribute("searchVO", searchVO);		
		
		return "brd_reference_ptnr/board_list_ajax";
	}
	
	/**
     * 다중 첨부파일 다운로드 Modal
     */
    @RequestMapping(value="/refReportDetailModal")
    public String contractDetailModal(HttpServletRequest request, Model model) {
    	
    	logger.info("========= refReportDetailModal =========");    	
    	
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sBoardNo = paramMap.get("board_no").toString();
		
		List<Map<String,Object>> boardDetailFile = sqlSession.selectList("BoardRefReportMapper.getBoardFileList", sBoardNo);
		
		String sTitle = boardDetailFile.get(0).get("title").toString();
		
		model.addAttribute("boardTitle", sTitle);
		model.addAttribute("boardDetailFile", boardDetailFile);
    	
    	return "brd_ref_report/board_attach_modal";
    }
	
	@RequestMapping(value = "/refBoardListAjax", method = RequestMethod.POST)
	public String refBoardListAjax(Model model, HttpServletRequest request, HttpSession session, BoardSearchVO searchVO, String boardWriteSuccess, String boardUpdateSuccess) {
		logger.info("======= refBoardListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		BoardPageUtil pageUtil = new BoardPageUtil();
		
		List<BoardVO> boardList	= (List<BoardVO>) pageUtil.boardPageSearch2(1, sqlSession, "BoardRefReportMapper.boardList", searchVO, model, "refReportBoardList");
		
		int boardListCnt = sqlSession.selectOne("BoardRefReportMapper.boardListCnt", searchVO);

		model.addAttribute("boardList", boardList);
		model.addAttribute("boardListCnt", boardListCnt);
		model.addAttribute("reqPgNo", paramMap.get("reqPgNo"));
		model.addAttribute("boardWriteSuccess", boardWriteSuccess);
		model.addAttribute("boardUpdateSuccess", boardUpdateSuccess);
		model.addAttribute("searchVO", searchVO);		
		
		return "brd_ref_report/board_list_ajax";
	}
	
	@RequestMapping(value = "/refReportBoardList", method = RequestMethod.GET)
	public String refReportBoardList(Model model, HttpServletRequest request, HttpSession session	, String boardWriteSuccess, String boardUpdateSuccess, BoardSearchVO searchVO) {
		logger.info("======= refReportBoardList =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("refReportBoardList - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String cateSearch = request.getParameter("cateSearch") != null ? request.getParameter("cateSearch") : "0";			//기본 탭
		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());
		model.addAttribute("searchVO", searchVO);
		
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
		
		model.addAttribute("cateSearch",cateSearch);

		return "brd_ref_report/board_list";
	}
	
	@RequestMapping(value = "/refReportBoardWriteForm", method = RequestMethod.GET)
	public String refReportBoardWriteForm(Model model, HttpSession session, HttpServletRequest request, BoardSearchVO searchVO) {
		logger.info("======= refReportBoardWriteForm =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		if(mbrVo == null){
			logger.info("refReportBoardWriteForm - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		String mbr_pms_39 = mbrAuthVo.getMbr_pms_39().toString();
		
		if( "0".contentEquals(mbr_pms_39) ) {
			logger.info("refReportBoardWriteForm - no Auth : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());
		
		/* 탭메뉴 (카테고리) 목록 */
		HashMap<String, String> cateCode = new HashMap<String, String>();
		cateCode.put("tname", "brd_ref_report");
		cateCode.put("cname", "cate_code");
		List<SysAdmCodeDicVO> cateList = sqlSession.selectList("CodeDicInsMapper.codeList",cateCode);
		model.addAttribute("cateList",cateList);

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
		
		model.addAttribute("searchVO",searchVO);

		return "brd_ref_report/board_write_form";
	}

	@RequestMapping(value = "/referencePtnrBoardList", method = RequestMethod.GET)
	public String referencePtnrBoardList(Model model, HttpServletRequest request, HttpSession session
			, String boardWriteSuccess, String boardUpdateSuccess, BoardSearchVO searchVO) {
		logger.info("======= referencePtnrBoardList =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("referencePtnrBoardList - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		String cateSearch = request.getParameter("cateSearch") != null ? request.getParameter("cateSearch") : "0";			//기본 탭
		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		//BoardPageUtil pageUtil = new BoardPageUtil();
		//List<BoardVO> boardList	= (List<BoardVO>) pageUtil.boardPageSearch1(1, sqlSession, "BoardReferencePtnrMapper.boardList", searchVO, model, "referencePtnrBoardList");

		//model.addAttribute("boardList", boardList);
		model.addAttribute("boardWriteSuccess", boardWriteSuccess);
		model.addAttribute("boardUpdateSuccess", boardUpdateSuccess);
		model.addAttribute("searchVO", searchVO);

		/* 파트너목록 추출 */
		List<TopPtnrBscVO> ptnrList = sqlSession.selectList("RptInvListMapper.ptnrListForSearch");
		model.addAttribute("ptnrList", ptnrList);
		/* 1종 / 4종 구분 */
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("tname", "brd_notice_top");
		map.put("cname", "title_classify");
		List<SysAdmCodeDicVO> codeList = sqlSession.selectList("CodeDicInsMapper.codeList",map);
		model.addAttribute("titleClassifyList",codeList);
		/* 문서 타입 추출 */
		HashMap<String, String> map2 = new HashMap<String, String>();
		map2.put("tname", "brd_reference_ptnr");
		map2.put("cname", "type_classify");
		List<SysAdmCodeDicVO> typeList = sqlSession.selectList("CodeDicInsMapper.codeList",map2);
		model.addAttribute("typeList",typeList);
		
		model.addAttribute("cateSearch",cateSearch);

		return "brd_reference_ptnr/board_list";
	}//referencePtnrBoardList
	
	@RequestMapping(value = "/referencePtnrBoardWriteForm", method = RequestMethod.GET)
	public String referencePtnrBoardWriteForm(Model model, HttpSession session, BoardSearchVO searchVO) {
		logger.info("======= referencePtnrBoardWriteForm =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("referencePtnrBoardWriteForm - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		/* 파트너목록 추출 */
		List<TopPtnrBscVO> ptnrList = sqlSession.selectList("RptInvListMapper.ptnrListForSearch");
		model.addAttribute("ptnrList", ptnrList);
		/* 1종 / 4종 구분 */
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("tname", "brd_notice_top");
		map.put("cname", "title_classify");
		List<SysAdmCodeDicVO> codeList = sqlSession.selectList("CodeDicInsMapper.codeList",map);
		model.addAttribute("titleClassifyList",codeList);
		/* 문서 타입 추출 */
		HashMap<String, String> map2 = new HashMap<String, String>();
		map2.put("tname", "brd_reference_ptnr");
		map2.put("cname", "type_classify");
		List<SysAdmCodeDicVO> typeList = sqlSession.selectList("CodeDicInsMapper.codeList",map2);
		model.addAttribute("typeList",typeList);
		
		model.addAttribute("searchVO",searchVO);

		return "brd_reference_ptnr/board_write_form";
	}//referencePtnrBoardWriteForm
	
	@RequestMapping(value = "/refReportBoardWrite", method = RequestMethod.POST)
	public String refReportBoardWrite(Model model, HttpSession session, HttpServletRequest request, MultipartRequest multipartRequest, BoardVO inVO) {
		logger.info("======= refReportBoardWrite =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String cateSearch = paramMap.get("cateSearch").toString();

		/*******게시글 부분 시작*******/
		int result = 0;
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		inVO.setUser_no(mbrAuthVo.getUser_no());
		inVO.setReg_ip(request.getRemoteAddr());
		//result = sqlSession.insert("BoardReferencePtnrMapper.boardWrite", inVO);
		
		inVO.setCategory_id(paramMap.get("cateSearch").toString());
		inVO.setEvent_id(paramMap.get("eventSelect").toString());
		inVO.setType_id(paramMap.get("typeSelect").toString());
		
		result = sqlSession.insert("BoardRefReportMapper.boardWrite", inVO);
		/*******게시글 부분 종료*******/
		/*******첨부 파일 부분 시작*******/
		
		BoardFileUtil bfcu = new BoardFileUtil();
		String boardNo = "";
		boardNo = inVO.getBoard_no();
				
		String path = "/home" + File.separator + "hosting_users" + File.separator + "toplac" + File.separator
				+ "www" + File.separator + "ls_data" + File.separator + "ref_board" + File.separator
				+ inVO.getCategory_id() + File.separator;
				
		int file_flag = 0;
		if(result > 0){			
			path = path+boardNo+File.separator;
			file_flag = bfcu.fileUploadProcessor(multipartRequest, boardNo, path, sqlSession, "BoardRefReportMapper.boardFileWrite");
		}//if(result > 0)
		/*******첨부 파일 부분 종료*******/
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 시작*******/
		String ckStrPath = null;
		ckStrPath = bfcu.mvCKFileDirTmpToReal(inVO.getContents(), "ref_board/"+inVO.getCategory_id(), boardNo);

		if(ckStrPath != null){
			bfcu.deleteDir(ckStrPath);//임시 폴더 내부 자료 및 임시 폴더 삭제

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", boardNo);
			map.put("oldStr", ckStrPath);//임시 폴더 경로
			map.put("newStr", "/home/hosting_users/toplac/www/wp_board/data/ref_board/"+inVO.getCategory_id()+"/"+boardNo+"/");//정식 폴더 경로
			sqlSession.update("BoardRefReportMapper.updateCKPath", map);//게시글 내부의 임시 폴더 경로를 정식 폴더 경로로 바꾸기
		}
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 종료*******/

		if(result < 1 || (file_flag < 1)){//게시글 입력 실패 또는 첨부파일 저장 실패
			model.addAttribute("boardWriteFailVO", inVO);
			return "brd_ref_report/board_write_form";
		}		
		
		//(게시글 입력 완료 && 첨부파일이 없음) 또는 (게시글 입력 완료 && 첨부파일 저장 성공)
		return "redirect:/refReportBoardList?boardWriteSuccess=1&cateSearch="+cateSearch;
	}

	@RequestMapping(value = "/referencePtnrBoardWrite", method = RequestMethod.POST)
	public String referencePtnrBoardWrite(Model model, HttpSession session, HttpServletRequest request, MultipartRequest multipartRequest, BoardVO inVO) {
		logger.info("======= referencePtnrBoardWrite =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

		/*******게시글 부분 시작*******/
		int result = 0;
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		
		String cateSearch = paramMap.get("cateSearch").toString();		
		
		inVO.setCategory_id(paramMap.get("cateSearch").toString());		
		inVO.setUser_no(mbrAuthVo.getUser_no());
		inVO.setReg_ip(request.getRemoteAddr());
		result = sqlSession.insert("BoardReferencePtnrMapper.boardWrite", inVO);
		/*******게시글 부분 종료*******/
		/*******첨부 파일 부분 시작*******/
		BoardFileUtil bfcu = new BoardFileUtil();
		String boardNo = "", path = "/home/hosting_users/toplac/www/ls_data/ig_pds/"+inVO.getPtnr_id()+"/";
		int file_flag = 0;
		if(result > 0){
			boardNo = sqlSession.selectOne("BoardReferencePtnrMapper.getBoardNo", inVO);
			path = path+boardNo+"/";
			file_flag = bfcu.fileUploadProcessor(multipartRequest, boardNo, path, sqlSession, "BoardReferencePtnrMapper.boardFileWrite");
		}//if(result > 0)
		/*******첨부 파일 부분 종료*******/
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 시작*******/
		String ckStrPath = null;
		ckStrPath = bfcu.mvCKFileDirTmpToReal(inVO.getContents(), "ig_pds/"+inVO.getPtnr_id(), boardNo);

		if(ckStrPath != null){
			bfcu.deleteDir(ckStrPath);//임시 폴더 내부 자료 및 임시 폴더 삭제

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", boardNo);
			map.put("oldStr", ckStrPath);//임시 폴더 경로
			map.put("newStr", "/home/hosting_users/toplac/www/wp_board/data/ig_pds/"+inVO.getPtnr_id()+"/"+boardNo+"/");//정식 폴더 경로
			sqlSession.update("BoardReferencePtnrMapper.updateCKPath", map);//게시글 내부의 임시 폴더 경로를 정식 폴더 경로로 바꾸기
		}
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 종료*******/

		if(result < 1 || (file_flag < 1)){//게시글 입력 실패 또는 첨부파일 저장 실패
			model.addAttribute("boardWriteFailVO", inVO);
			return "brd_reference_ptnr/board_write_form";
		}
		//(게시글 입력 완료 && 첨부파일이 없음) 또는 (게시글 입력 완료 && 첨부파일 저장 성공)
		//return "redirect:/referencePtnrBoardList?boardWriteSuccess=1";
		return "redirect:/referencePtnrBoardList?boardWriteSuccess=1&cateSearch="+cateSearch;
	}//referencePtnrBoardWrite
	
	@RequestMapping(value = "/refReportBoardDetail", method = RequestMethod.GET)
	public String refReportBoardDetail(Model model, HttpSession session, String boardNo, String reqPgNo, BoardSearchVO searchVO) {
		logger.info("======= refReportBoardDetail =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("refReportBoardDetail - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		if(!boardNo.equals(session.getAttribute("brd_no_Session"))){
			sqlSession.update("BoardRefReportMapper.boardAddCnt", boardNo);
		}
		session.setAttribute("brd_no_Session", boardNo);

		BoardVO boardDetail = sqlSession.selectOne("BoardRefReportMapper.boardDetail", boardNo);
		model.addAttribute("boardDetail", boardDetail);

		List<BoardFileVO> boardFileList = sqlSession.selectList("BoardRefReportMapper.boardFileList", boardNo);
		model.addAttribute("boardFileList", boardFileList);

		model.addAttribute("reqPgNo", reqPgNo);
		model.addAttribute("searchVO", searchVO);

		return "brd_ref_report/board_detail";
	}

	@RequestMapping(value = "/referencePtnrBoardDetail", method = RequestMethod.GET)
	public String referencePtnrBoardDetail(Model model, HttpSession session, String boardNo, String reqPgNo, BoardSearchVO searchVO) {
		logger.info("======= referencePtnrBoardDetail =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("referencePtnrBoardDetail - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		if(!boardNo.equals(session.getAttribute("brd_no_Session"))){
			sqlSession.update("BoardReferencePtnrMapper.boardAddCnt", boardNo);
		}
		session.setAttribute("brd_no_Session", boardNo);

		BoardVO boardDetail = sqlSession.selectOne("BoardReferencePtnrMapper.boardDetail", boardNo);
		model.addAttribute("boardDetail", boardDetail);

		List<BoardFileVO> boardFileList = sqlSession.selectList("BoardReferencePtnrMapper.boardFileList", boardNo);
		model.addAttribute("boardFileList", boardFileList);

		model.addAttribute("reqPgNo", reqPgNo);
		model.addAttribute("searchVO", searchVO);

		return "brd_reference_ptnr/board_detail";
	}//referencePtnrBoardDetail
	
	@RequestMapping(value = "refReportBoardDelete", method = RequestMethod.POST)
	public void refReportBoardDelete(HttpServletResponse response, String boardNo, String categoryId) {
		logger.info("======= refReportBoardDelete =======");

		int result = 0;
		result = sqlSession.delete("BoardRefReportMapper.boardDelete", boardNo);

		int file_flag = 0;
		int file_result = 0;
		if(result > 0){
			BoardFileUtil bfcu = new BoardFileUtil();
			//운영
			bfcu.deleteDir("/home/hosting_users/toplac/www/wp_board/data/ref_board/"+categoryId+"/"+boardNo+"/");
			file_flag = bfcu.deleteDirReturnFlag("/home/hosting_users/toplac/www/ls_data/ref_board/"+categoryId+"/"+boardNo+"/");
			file_result = sqlSession.delete("BoardRefReportMapper.boardFilesDelete", boardNo);
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

	@RequestMapping(value = "referencePtnrBoardDelete", method = RequestMethod.POST)
	public void referencePtnrBoardDelete(HttpServletResponse response, String boardNo, String ptnrId) {
		logger.info("======= referencePtnrBoardDelete =======");

		int result = 0;
		result = sqlSession.delete("BoardReferencePtnrMapper.boardDelete", boardNo);

		int file_flag = 0;
		int file_result = 0;
		if(result > 0){
			BoardFileUtil bfcu = new BoardFileUtil();
			bfcu.deleteDir("/home/hosting_users/toplac/www/wp_board/data/ig_pds/"+ptnrId+"/"+boardNo+"/");

			file_flag = bfcu.deleteDirReturnFlag("/home/hosting_users/toplac/www/ls_data/ig_pds/"+ptnrId+"/"+boardNo+"/");

			file_result = sqlSession.delete("BoardReferencePtnrMapper.boardFilesDelete", boardNo);

			BoardMemoViewVO memoViewVO = new BoardMemoViewVO();
			memoViewVO.setLinkNo(boardNo);
			memoViewVO.setTargetStr("referencePtnr");
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

	}//referencePtnrBoardDelete
	
	@RequestMapping(value = "/refReportBoardUpdateForm", method = RequestMethod.GET)
	public String refReportBoardUpdateForm(Model model, HttpSession session, String boardNo, String reqPgNo, BoardSearchVO searchVO) {
		logger.info("======= refReportBoardUpdateForm =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("refReportBoardUpdateForm - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		BoardVO boardDetail = sqlSession.selectOne("BoardRefReportMapper.boardDetail", boardNo);
		model.addAttribute("boardDetail", boardDetail);

		List<BoardFileVO> boardFileList = sqlSession.selectList("BoardRefReportMapper.boardFileList", boardNo);
		model.addAttribute("boardFileList", boardFileList);

		model.addAttribute("reqPgNo", reqPgNo);
		model.addAttribute("searchVO", searchVO);

		/* 탭메뉴 (카테고리) 목록 */
		/**
		HashMap<String, String> cateCode = new HashMap<String, String>();
		cateCode.put("tname", "brd_ref_report");
		cateCode.put("cname", "cate_code");
		List<SysAdmCodeDicVO> cateList = sqlSession.selectList("CodeDicInsMapper.codeList",cateCode);
		model.addAttribute("cateList",cateList);
		**/

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

		return "brd_ref_report/board_update_form";
	}

	@RequestMapping(value = "/referencePtnrBoardUpdateForm", method = RequestMethod.GET)
	public String referencePtnrBoardUpdateForm(Model model, HttpSession session, String boardNo, String reqPgNo, BoardSearchVO searchVO) {
		logger.info("======= referencePtnrBoardUpdateForm =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("referencePtnrBoardUpdateForm - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		BoardVO boardDetail = sqlSession.selectOne("BoardReferencePtnrMapper.boardDetail", boardNo);
		model.addAttribute("boardDetail", boardDetail);

		List<BoardFileVO> boardFileList = sqlSession.selectList("BoardReferencePtnrMapper.boardFileList", boardNo);
		model.addAttribute("boardFileList", boardFileList);

		model.addAttribute("reqPgNo", reqPgNo);
		model.addAttribute("searchVO", searchVO);

		/* 파트너목록 추출 */
		List<TopPtnrBscVO> ptnrList = sqlSession.selectList("RptInvListMapper.ptnrListForSearch");
		model.addAttribute("ptnrList", ptnrList);
		/* 1종 / 4종 구분 */
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("tname", "brd_notice_top");
		map.put("cname", "title_classify");
		List<SysAdmCodeDicVO> codeList = sqlSession.selectList("CodeDicInsMapper.codeList",map);
		model.addAttribute("titleClassifyList",codeList);
		/* 문서 타입 추출 */
		HashMap<String, String> map2 = new HashMap<String, String>();
		map2.put("tname", "brd_reference_ptnr");
		map2.put("cname", "type_classify");
		List<SysAdmCodeDicVO> typeList = sqlSession.selectList("CodeDicInsMapper.codeList",map2);
		model.addAttribute("typeList",typeList);

		return "brd_reference_ptnr/board_update_form";
	}//referencePtnrBoardUpdateForm
	
	@RequestMapping(value = "refReportBoardFileDelete", method = RequestMethod.POST)
	public void refReportBoardFileDelete(HttpServletResponse response, String fileNo, String filePath, String fileName) {
		logger.info("======= refReportBoardFileDelete =======");

		BoardFileVO tmpBoardFreeFileVO = sqlSession.selectOne("BoardRefReportMapper.refPtnrFileOneSelect", fileNo);
		filePath = tmpBoardFreeFileVO.getFile_path();
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
		file_result = sqlSession.delete("BoardRefReportMapper.boardFileDelete", fileNo);

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

	@RequestMapping(value = "referencePtnrBoardFileDelete", method = RequestMethod.POST)
	public void referencePtnrBoardFileDelete(HttpServletResponse response, String fileNo, String filePath, String fileName) {
		logger.info("======= referencePtnrBoardFileDelete =======");

		BoardFileVO tmpBoardFreeFileVO = sqlSession.selectOne("BoardReferencePtnrMapper.refPtnrFileOneSelect", fileNo);
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
		file_result = sqlSession.delete("BoardReferencePtnrMapper.boardFileDelete", fileNo);

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

	}//referencePtnrBoardFileDelete
	
	@RequestMapping(value = "/refReportBoardUpdate", method = RequestMethod.POST)
	public String refReportBoardUpdate(Model model, HttpSession session, HttpServletRequest request, MultipartRequest multipartRequest
			, BoardVO inVO, BoardSearchVO searchVO) {
		logger.info("======= refReportBoardUpdate =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String catagory_id = request.getParameter("catagory_id") != null ? request.getParameter("catagory_id") : "0";

		/*******게시글 부분 시작*******/
		int result = 0;
		result = sqlSession.update("BoardRefReportMapper.boardUpdate", inVO);
		/*******게시글 부분 종료*******/
		/*******첨부 파일 부분 시작*******/
		BoardFileUtil bfcu = new BoardFileUtil();
		String boardNo = "";		
		
		String path = "/home" + File.separator + "hosting_users" + File.separator + "toplac" + File.separator
				+ "www" + File.separator + "ls_data" + File.separator + "ref_board" + File.separator
				+ inVO.getCategory_id() + File.separator;
		
		int file_flag = 0;
		if(result > 0){
			boardNo = inVO.getBoard_no();
			path = path+boardNo+File.separator;
			file_flag = bfcu.fileUploadProcessor(multipartRequest, boardNo, path, sqlSession, "BoardRefReportMapper.boardFileWrite");			
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
			sqlSession.update("BoardRefReportMapper.updateCKPath", map);//게시글 내부의 정식 폴더 경로를 임시 폴더 경로로 바꾸기

			inVO.setContents(inVO.getContents().replaceAll(beforeUpdateCKPath, "/home/hosting_users/toplac/www/wp_board/data/ckeditor_tmp/"+userNo+"/"));
		}
		//아래 부분을 삭제하면 기존 본문 이미지가 누락됨 by top3009
		//bfcu.deleteDir("/home/hosting_users/toplac/www/wp_board/data/ref_board/"+catagory_id+"/"+boardNo+"/");//정식 폴더 내부 자료 및 정식 폴더 삭제
		/*******게시글에서 수정 전 CKEDITOR 이미지 URL 분리 부분 종료*******/
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 시작*******/
		String ckStrPath = null;
		ckStrPath = bfcu.mvCKFileDirTmpToReal(inVO.getContents(), "ref_board/"+catagory_id, boardNo);

		if(ckStrPath != null){
			bfcu.deleteDir(ckStrPath);//임시 폴더 내부 자료 및 임시 폴더 삭제

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", boardNo);
			map.put("oldStr", ckStrPath);//임시 폴더 경로
			map.put("newStr", "/home/hosting_users/toplac/www/wp_board/data/ref_board/"+catagory_id+"/"+boardNo+"/");//정식 폴더 경로
			sqlSession.update("BoardRefReportMapper.updateCKPath", map);//게시글 내부의 임시 폴더 경로를 정식 폴더 경로로 바꾸기
		}
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 종료*******/

		if(result < 1 || (file_flag < 1)){//게시글 입력 실패 또는 첨부파일 저장 실패
			List<BoardFileVO> boardFileList = sqlSession.selectList("updateCKPath.boardFileList", boardNo);
			model.addAttribute("boardFileList", boardFileList);
			model.addAttribute("boardUpdateFailFlag", 1);
			model.addAttribute("boardDetail", inVO);
			return "brd_ref_report/board_update_form";
		}
		//(게시글 입력 완료 && 첨부파일이 없음) 또는 (게시글 입력 완료 && 첨부파일 저장 성공)
		return "redirect:/refReportBoardList?updateSuccess=1"
		+"&boardSrcType="+searchVO.getBoardSrcType()
		+"&boardSrcWord="+searchVO.getBoardSrcWord()
		+"&reqPgNo="+searchVO.getReqPgNo()
		+"&cateSearch="+searchVO.getCateSearch()
		+"&eventSearch="+searchVO.getEventSearch()		
		+"&typeSearch="+searchVO.getTypeSearch();
	}

	@RequestMapping(value = "/referencePtnrBoardUpdate", method = RequestMethod.POST)
	public String referencePtnrBoardUpdate(Model model, HttpSession session, HttpServletRequest request, MultipartRequest multipartRequest
			, BoardVO inVO, BoardSearchVO searchVO) {
		logger.info("======= referencePtnrBoardUpdate =======");

		/*******게시글 부분 시작*******/
		int result = 0;
		result = sqlSession.update("BoardReferencePtnrMapper.boardUpdate", inVO);
		/*******게시글 부분 종료*******/
		/*******첨부 파일 부분 시작*******/
		BoardFileUtil bfcu = new BoardFileUtil();
		String boardNo = "", path = "/home/hosting_users/toplac/www/ls_data/ig_pds/"+inVO.getPtnr_id()+"/";
		int file_flag = 0;
		if(result > 0){
			boardNo = inVO.getBoard_no();
			path = path+boardNo+"/";
			file_flag = bfcu.fileUploadProcessor(multipartRequest, boardNo, path, sqlSession, "BoardReferencePtnrMapper.boardFileWrite");
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
			sqlSession.update("BoardReferencePtnrMapper.updateCKPath", map);//게시글 내부의 정식 폴더 경로를 임시 폴더 경로로 바꾸기

			inVO.setContents(inVO.getContents().replaceAll(beforeUpdateCKPath, "/home/hosting_users/toplac/www/wp_board/data/ckeditor_tmp/"+userNo+"/"));
		}
		bfcu.deleteDir("/home/hosting_users/toplac/www/wp_board/data/ig_pds/"+inVO.getPtnr_id()+"/"+boardNo+"/");//정식 폴더 내부 자료 및 정식 폴더 삭제
		/*******게시글에서 수정 전 CKEDITOR 이미지 URL 분리 부분 종료*******/
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 시작*******/
		String ckStrPath = null;
		ckStrPath = bfcu.mvCKFileDirTmpToReal(inVO.getContents(), "ig_pds/"+inVO.getPtnr_id(), boardNo);

		if(ckStrPath != null){
			bfcu.deleteDir(ckStrPath);//임시 폴더 내부 자료 및 임시 폴더 삭제

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", boardNo);
			map.put("oldStr", ckStrPath);//임시 폴더 경로
			map.put("newStr", "/home/hosting_users/toplac/www/wp_board/data/ig_pds/"+inVO.getPtnr_id()+"/"+boardNo+"/");//정식 폴더 경로
			sqlSession.update("BoardReferencePtnrMapper.updateCKPath", map);//게시글 내부의 임시 폴더 경로를 정식 폴더 경로로 바꾸기
		}
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 종료*******/

		if(result < 1 || (file_flag < 1)){//게시글 입력 실패 또는 첨부파일 저장 실패
			List<BoardFileVO> boardFileList = sqlSession.selectList("BoardReferencePtnrMapper.boardFileList", boardNo);
			model.addAttribute("boardFileList", boardFileList);
			model.addAttribute("boardUpdateFailFlag", 1);
			model.addAttribute("boardDetail", inVO);
			return "brd_reference_ptnr/board_update_form";
		}
		//(게시글 입력 완료 && 첨부파일이 없음) 또는 (게시글 입력 완료 && 첨부파일 저장 성공)
		return "redirect:/referencePtnrBoardList?updateSuccess=1"
		+"&boardSrcType="+searchVO.getBoardSrcType()
		+"&boardSrcWord="+searchVO.getBoardSrcWord()
		+"&reqPgNo="+searchVO.getReqPgNo()
		+"&ptnrSearch="+searchVO.getPtnrSearch()
		+"&ptnrGubun="+searchVO.getPtnrGubun()
		+"&titleSearch="+searchVO.getTitleSearch()
		+"&typeSearch="+searchVO.getTypeSearch()
		+"&yearSearch="+searchVO.getYearSearch()
		+"&cateSearch="+searchVO.getCateSearch();
	}//referencePtnrBoardUpdate


	@RequestMapping(value = "/referencePtnrBoardPrint", method = RequestMethod.GET)
	public String referencePtnrBoardPrint(Model model, HttpSession session, String boardNo) {
		logger.info("======= referencePtnrBoardPrint =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("referencePtnrBoardPrint - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		BoardVO boardDetail = sqlSession.selectOne("BoardReferencePtnrMapper.boardDetail", boardNo);
		model.addAttribute("boardDetail", boardDetail);

		return "brd_common/board_print_pop";
	}//referencePtnrBoardPrint
	
	@RequestMapping(value = "/referencePtnrBoardListPop", method = RequestMethod.GET)
	public String referencePtnrBoardListPop(Model model, HttpServletRequest request, HttpSession session
			, String boardWriteSuccess, String boardUpdateSuccess, BoardSearchVO searchVO) {
		logger.info("======= referencePtnrBoardListPop =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("referencePtnrBoardListPop - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		String cateSearch = request.getParameter("cateSearch") != null ? request.getParameter("cateSearch") : "0";			//기본 탭

		BoardPageUtil pageUtil = new BoardPageUtil();
		List<BoardVO> boardList
		= (List<BoardVO>) pageUtil.boardPageSearch1(1, sqlSession, "BoardReferencePtnrMapper.boardList", searchVO, model, "referencePtnrBoardList");

		model.addAttribute("boardList", boardList);
		model.addAttribute("boardWriteSuccess", boardWriteSuccess);
		model.addAttribute("boardUpdateSuccess", boardUpdateSuccess);
		model.addAttribute("searchVO", searchVO);

		/* 파트너목록 추출 */
		List<TopPtnrBscVO> ptnrList = sqlSession.selectList("RptInvListMapper.ptnrListForSearch");
		model.addAttribute("ptnrList", ptnrList);
		/* 1종 / 4종 구분 */
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("tname", "brd_notice_top");
		map.put("cname", "title_classify");
		List<SysAdmCodeDicVO> codeList = sqlSession.selectList("CodeDicInsMapper.codeList",map);
		model.addAttribute("titleClassifyList",codeList);
		/* 문서 타입 추출 */
		HashMap<String, String> map2 = new HashMap<String, String>();
		map2.put("tname", "brd_reference_ptnr");
		map2.put("cname", "type_classify");
		List<SysAdmCodeDicVO> typeList = sqlSession.selectList("CodeDicInsMapper.codeList",map2);
		model.addAttribute("typeList",typeList);
		
		model.addAttribute("cateSearch",cateSearch);

		return "brd_reference_ptnr/board_list";
		//return "brd_reference_ptnr/board_list_pop";
	}//referencePtnrBoardListPop

	@RequestMapping(value = "/referencePtnrBoardDetailPop", method = RequestMethod.GET)
	public String referencePtnrBoardDetailPop(Model model, HttpSession session, String boardNo, String reqPgNo, BoardSearchVO searchVO) {
		logger.info("======= referencePtnrBoardDetailPop =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("referencePtnrBoardDetailPop - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		if(!boardNo.equals(session.getAttribute("brd_no_Session"))){
			sqlSession.update("BoardReferencePtnrMapper.boardAddCnt", boardNo);
		}
		session.setAttribute("brd_no_Session", boardNo);

		BoardVO boardDetail = sqlSession.selectOne("BoardReferencePtnrMapper.boardDetail", boardNo);
		model.addAttribute("boardDetail", boardDetail);

		List<BoardFileVO> boardFileList = sqlSession.selectList("BoardReferencePtnrMapper.boardFileList", boardNo);
		model.addAttribute("boardFileList", boardFileList);

		model.addAttribute("reqPgNo", reqPgNo);
		model.addAttribute("searchVO", searchVO);

		return "brd_reference_ptnr/board_detail_pop";
	}//referencePtnrBoardDetailPop

}//end of class
