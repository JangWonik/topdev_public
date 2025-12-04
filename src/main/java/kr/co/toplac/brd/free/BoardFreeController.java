/*
*********************************************************
* Program ID	: BoardFreeController
* Program Name	: BoardFreeController
* Description	: 자유게시판
* Author		: 
* Date			: 2016.06.11.
*********************************************************
*/
package kr.co.toplac.brd.free;

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
import kr.co.toplac.topmain.MainLeftSuimVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.rpt.MainLeftUtil;

@Controller
public class BoardFreeController {

	private static final Logger logger = LoggerFactory.getLogger(BoardFreeController.class);

	@Autowired
	SqlSession sqlSession;

	@Autowired
	MainLeftUtil mlu;
	
	/**
     * 다중 첨부파일 다운로드 Modal
     */
    @RequestMapping(value="/brdFreeBoardDetailModal")
    public String brdFreeBoardDetailModal(HttpServletRequest request, Model model) {
    	
    	logger.info("========= brdFreeBoardDetailModal =========");    	
    	
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sBoardNo = paramMap.get("board_no").toString();
		
		List<Map<String,Object>> boardDetailFile = sqlSession.selectList("BoardFreeMapper.getBoardFileList", sBoardNo);
		
		String sTitle = boardDetailFile.get(0).get("title").toString();
		
		model.addAttribute("boardTitle", sTitle);
		model.addAttribute("boardDetailFile", boardDetailFile);
    	
    	return "brd_free/board_attach_modal";
    }
	
	@RequestMapping(value = "/freeTopBoardListAjax", method = RequestMethod.POST)
	public String freeTopBoardListAjax(Model model, HttpServletRequest request, HttpSession session, BoardSearchVO searchVO, String boardWriteSuccess, String boardUpdateSuccess) {
		logger.info("======= freeTopBoardListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		BoardPageUtil pageUtil = new BoardPageUtil();
		List<BoardVO> boardList = (List<BoardVO>) pageUtil.boardPageSearch2(1, sqlSession, "BoardFreeMapper.boardFreeList", searchVO, model, "freeBoardList");
		model.addAttribute("boardList", boardList);
		
		int boardListCnt = sqlSession.selectOne("BoardFreeMapper.boardFreeListCnt", searchVO);

		model.addAttribute("boardList", boardList);
		model.addAttribute("boardListCnt", boardListCnt);
		model.addAttribute("reqPgNo", paramMap.get("reqPgNo"));
		model.addAttribute("boardWriteSuccess", boardWriteSuccess);
		model.addAttribute("boardUpdateSuccess", boardUpdateSuccess);
		model.addAttribute("searchVO", searchVO);		
		
		return "brd_free/board_list_ajax";
	}

	@RequestMapping(value = "/freeBoardList", method = RequestMethod.GET)
	public String freeBoardList(Model model, HttpSession session
			, String boardFreeWriteSuccess, String boardFreeUpdateSuccess, BoardSearchVO searchVO) {
		logger.info("======= freeBoardList =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("freeBoardList - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		//BoardPageUtil pageUtil = new BoardPageUtil();
		//List<BoardVO> boardFreeList = (List<BoardVO>) pageUtil.boardPageSearch1(1, sqlSession, "BoardFreeMapper.boardFreeList", searchVO, model, "freeBoardList");
		//model.addAttribute("boardFreeList", boardFreeList);
		
		model.addAttribute("boardFreeWriteSuccess", boardFreeWriteSuccess);
		model.addAttribute("boardFreeUpdateSuccess", boardFreeUpdateSuccess);
		model.addAttribute("searchVO", searchVO);

		return "brd_free/free_board_list";
	}//freeBoardList

	@RequestMapping(value = "/freeBoardWriteForm", method = RequestMethod.GET)
	public String freeBoardWriteForm(Model model, HttpSession session) {
		logger.info("======= freeBoardWriteForm =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("freeBoardWriteForm - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		
		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		return "brd_free/free_board_write_form";
	}//freeBoardWriteForm

	@RequestMapping(value = "/freeBoardWrite", method = RequestMethod.POST)
	public String freeBoardWrite(Model model, HttpSession session, HttpServletRequest request, MultipartRequest multipartRequest, BoardVO inVO) {
		logger.info("======= freeBoardWrite =======");

		/*******게시글 부분 시작*******/
		int result = 0;
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		inVO.setUser_no(mbrAuthVo.getUser_no());
		inVO.setReg_ip(request.getRemoteAddr());
		result = sqlSession.insert("BoardFreeMapper.boardFreeWrite", inVO);
		/*******게시글 부분 종료*******/
		/*******첨부 파일 부분 시작*******/
		BoardFileUtil bfcu = new BoardFileUtil();
		String boardNo = "", path = "/home/hosting_users/toplac/www/wp_board/upload/free/";
		int file_flag = 0;
		if(result > 0){
			boardNo = sqlSession.selectOne("BoardFreeMapper.getBoardNo", inVO);
			path = path+boardNo+"/";
			file_flag = bfcu.fileUploadProcessor(multipartRequest, boardNo, path, sqlSession, "BoardFreeMapper.boardFreeFileWrite");
		}//if(result > 0)
		/*******첨부 파일 부분 종료*******/
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 시작*******/
		String ckStrPath = null;
		ckStrPath = bfcu.mvCKFileDirTmpToReal(inVO.getContents(), "free", boardNo);

		if(ckStrPath != null){
			bfcu.deleteDir(ckStrPath);//임시 폴더 내부 자료 및 임시 폴더 삭제

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", boardNo);
			map.put("oldStr", ckStrPath);//임시 폴더 경로
			map.put("newStr", "/home/hosting_users/toplac/www/wp_board/data/free/"+boardNo+"/");//정식 폴더 경로
			sqlSession.update("BoardFreeMapper.updateCKPath", map);//게시글 내부의 임시 폴더 경로를 정식 폴더 경로로 바꾸기
		}
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 종료*******/

		if(result < 1 || (file_flag < 1)){//게시글 입력 실패 또는 첨부파일 저장 실패
			model.addAttribute("boardFreeWriteFailVO", inVO);
			return "brd_free/free_board_write_form";
		}
		//(게시글 입력 완료 && 첨부파일이 없음) 또는 (게시글 입력 완료 && 첨부파일 저장 성공)
		return "redirect:/freeBoardList?boardFreeWriteSuccess=1";
	}//freeBoardWrite

	@RequestMapping(value = "/freeBoardDetail", method = RequestMethod.GET)
	public String freeBoardDetail(Model model, HttpSession session, String boardNo, String reqPgNo, BoardSearchVO searchVO) {
		logger.info("======= freeBoardDetail =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("freeBoardDetail - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		
		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		if(!boardNo.equals(session.getAttribute("brd_no_Session"))){
			sqlSession.update("BoardFreeMapper.boardFreeAddCnt", boardNo);
		}
		session.setAttribute("brd_no_Session", boardNo);

		BoardVO freeBoardDetail = sqlSession.selectOne("BoardFreeMapper.freeBoardDetail", boardNo);
		model.addAttribute("freeBoardDetail", freeBoardDetail);

		List<BoardFileVO> boardFreeFileList = sqlSession.selectList("BoardFreeMapper.boardFreeFileList", boardNo);
		model.addAttribute("boardFreeFileList", boardFreeFileList);

		model.addAttribute("reqPgNo", reqPgNo);
		model.addAttribute("searchVO", searchVO);

		return "brd_free/free_board_detail";
	}//freeBoardDetail

	@RequestMapping(value = "freeBoardDelete", method = RequestMethod.POST)
	public void freeBoardDelete(HttpServletResponse response, String boardNo) {
		logger.info("======= freeBoardDelete =======");

		int result = 0;
		result = sqlSession.delete("BoardFreeMapper.freeBoardDelete", boardNo);

		int file_flag = 0;
		int file_result = 0;
		if(result > 0){
			BoardFileUtil bfcu = new BoardFileUtil();
			bfcu.deleteDir("/home/hosting_users/toplac/www/wp_board/data/free/"+boardNo+"/");

			file_flag = bfcu.deleteDirReturnFlag("/home/hosting_users/toplac/www/wp_board/upload/free/"+boardNo+"/");

			file_result = sqlSession.delete("BoardFreeMapper.freeBoardFilesDelete", boardNo);

			BoardMemoViewVO memoViewVO = new BoardMemoViewVO();
			memoViewVO.setLinkNo(boardNo);
			memoViewVO.setTargetStr("free");
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

	}//freeBoardDelete

	@RequestMapping(value = "/freeBoardUpdateForm", method = RequestMethod.GET)
	public String freeBoardUpdateForm(Model model, HttpSession session, String boardNo, String reqPgNo, BoardSearchVO searchVO) {
		logger.info("======= freeBoardUpdateForm =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("freeBoardUpdateForm - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		BoardVO freeBoardDetail = sqlSession.selectOne("BoardFreeMapper.freeBoardDetail", boardNo);
		model.addAttribute("freeBoardDetail", freeBoardDetail);

		List<BoardFileVO> boardFreeFileList = sqlSession.selectList("BoardFreeMapper.boardFreeFileList", boardNo);
		model.addAttribute("boardFreeFileList", boardFreeFileList);

		model.addAttribute("reqPgNo", reqPgNo);
		model.addAttribute("searchVO", searchVO);

		return "brd_free/free_board_update_form";
	}//freeBoardUpdateForm

	@RequestMapping(value = "freeBoardFileDelete", method = RequestMethod.POST)
	public void freeBoardFileDelete(HttpServletResponse response, String fileNo, String filePath, String fileName) {
		logger.info("======= freeBoardFileDelete =======");

		BoardFileVO tmpBoardFreeFileVO = sqlSession.selectOne("BoardFreeMapper.freeBoardFileOneSelect", fileNo);
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
		file_result = sqlSession.delete("BoardFreeMapper.freeBoardFileDelete", fileNo);

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

	}//freeBoardFileDelete

	@RequestMapping(value = "/freeBoardUpdate", method = RequestMethod.POST)
	public String freeBoardUpdate(Model model, HttpSession session, HttpServletRequest request, MultipartRequest multipartRequest
			, BoardVO inVO, BoardSearchVO searchVO) {
		logger.info("======= freeBoardUpdate =======");

		/*******게시글 부분 시작*******/
		int result = 0;
		result = sqlSession.update("BoardFreeMapper.freeBoardUpdate", inVO);
		/*******게시글 부분 종료*******/
		/*******첨부 파일 부분 시작*******/
		BoardFileUtil bfcu = new BoardFileUtil();
		String boardNo = "", path = "/home/hosting_users/toplac/www/wp_board/upload/free/";
		int file_flag = 0;
		if(result > 0){
			boardNo = inVO.getBoard_no();
			path = path+boardNo+"/";
			file_flag = bfcu.fileUploadProcessor(multipartRequest, boardNo, path, sqlSession, "BoardFreeMapper.boardFreeFileWrite");
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
			sqlSession.update("BoardFreeMapper.updateCKPath", map);//게시글 내부의 정식 폴더 경로를 임시 폴더 경로로 바꾸기

			inVO.setContents(inVO.getContents().replaceAll(beforeUpdateCKPath, "/home/hosting_users/toplac/www/wp_board/data/ckeditor_tmp/"+userNo+"/"));
		}
		//아래 부분을 삭제하면 기존 본문 이미지가 누락됨 by top3009
		//bfcu.deleteDir("/home/hosting_users/toplac/www/wp_board/data/free/"+boardNo+"/");//정식 폴더 내부 자료 및 정식 폴더 삭제
		/*******게시글에서 수정 전 CKEDITOR 이미지 URL 분리 부분 종료*******/
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 시작*******/
		String ckStrPath = null;
		ckStrPath = bfcu.mvCKFileDirTmpToReal(inVO.getContents(), "free", boardNo);

		if(ckStrPath != null){
			bfcu.deleteDir(ckStrPath);//임시 폴더 내부 자료 및 임시 폴더 삭제

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", boardNo);
			map.put("oldStr", ckStrPath);//임시 폴더 경로
			map.put("newStr", "/home/hosting_users/toplac/www/wp_board/data/free/"+boardNo+"/");//정식 폴더 경로
			sqlSession.update("BoardFreeMapper.updateCKPath", map);//게시글 내부의 임시 폴더 경로를 정식 폴더 경로로 바꾸기
		}
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 종료*******/

		if(result < 1 || (file_flag < 1)){//게시글 입력 실패 또는 첨부파일 저장 실패
			List<BoardFileVO> boardFreeFileList = sqlSession.selectList("BoardFreeMapper.boardFreeFileList", boardNo);
			model.addAttribute("boardFreeFileList", boardFreeFileList);
			model.addAttribute("freeBoardUpdateFailFlag", 1);
			model.addAttribute("freeBoardDetail", inVO);
			return "brd_free/free_board_update_form";
		}
		//(게시글 입력 완료 && 첨부파일이 없음) 또는 (게시글 입력 완료 && 첨부파일 저장 성공)
		return "redirect:/freeBoardList?boardFreeUpdateSuccess=1"
				+"&boardSrcType="+searchVO.getBoardSrcType()
				+"&boardSrcWord="+searchVO.getBoardSrcWord()
				+"&reqPgNo="+searchVO.getReqPgNo();
	}//freeBoardUpdate

	@RequestMapping(value = "/freeBoardPrint", method = RequestMethod.GET)
	public String freeBoardPrint(Model model, HttpSession session, String boardNo) {
		logger.info("======= freeBoardPrint =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("freeBoardDetail - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		BoardVO freeBoardDetail = sqlSession.selectOne("BoardFreeMapper.freeBoardDetail", boardNo);
		model.addAttribute("boardDetail", freeBoardDetail);

		return "brd_common/board_print_pop";
	}//freeBoardPrint

}//end of class
