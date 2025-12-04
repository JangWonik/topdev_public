/*
*********************************************************
* Program ID	: BoardNoticePtnr4Controller
* Program Name	: BoardNoticePtnr4Controller
* Description	: 보험사공지(4종)
* Author		: 
* Date			: 2016.06.11.
*********************************************************
*/
package kr.co.toplac.brd.noticeptnr;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

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
import kr.co.toplac.topptnr.TopPtnrBscVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.rpt.MainLeftUtil;

@Controller
public class BoardNoticePtnr4Controller {

	private static final Logger logger = LoggerFactory.getLogger(BoardNoticePtnr4Controller.class);

	@Autowired
	SqlSession sqlSession;

	@Autowired
	MainLeftUtil mlu;

	@RequestMapping(value = "/noticePtnr4Board", method = RequestMethod.GET)
	public String noticePtnr4Board(Model model, HttpSession session) {
		logger.info("======= noticePtnr4Board =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_12().equals("0"))){
			logger.info("noticePtnr4Board - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		List<TopPtnrBscVO> ptnrBoardlist = sqlSession.selectList("BoardNoticePtnr4Mapper.ptnrBoardlist");

		model.addAttribute("ptnrBoardlist",ptnrBoardlist);

		return "brd_notice_ptnr4/board_ptnr_notice";
	}//noticePtnr4Board

	@RequestMapping(value = "/noticePtnr4BoardList", method = RequestMethod.GET)
	public String noticePtnr4BoardList(Model model, HttpSession session
			, String boardWriteSuccess, String boardUpdateSuccess, BoardSearchVO searchVO) {
		logger.info("======= noticePtnr4BoardList =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_12().equals("0"))){
			logger.info("noticePtnr4BoardList - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		BoardPageUtil pageUtil = new BoardPageUtil();
		List<BoardVO> boardList
		= (List<BoardVO>) pageUtil.boardPageSearch1(1, sqlSession, "BoardNoticePtnr4Mapper.boardList", searchVO, model, "noticePtnr4BoardList");

		model.addAttribute("boardList", boardList);
		model.addAttribute("boardWriteSuccess", boardWriteSuccess);
		model.addAttribute("boardUpdateSuccess", boardUpdateSuccess);
		model.addAttribute("searchVO", searchVO);

		String insu = searchVO.getInsu();
		String insuNm = sqlSession.selectOne("BoardNoticePtnr4Mapper.getInsuNm", insu);
		model.addAttribute("insuNm", insuNm);

		return "brd_notice_ptnr4/board_list";
	}//noticePtnr4BoardList

	@RequestMapping(value = "/noticePtnr4BoardWriteForm", method = RequestMethod.GET)
	public String noticePtnr4BoardWriteForm(Model model, HttpSession session, String insu) {
		logger.info("======= noticePtnr4BoardWriteForm =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_12().equals("0"))){
			logger.info("noticePtnr4BoardWriteForm - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		String insuNm = sqlSession.selectOne("BoardNoticePtnr4Mapper.getInsuNm", insu);
		model.addAttribute("insu", insu);
		model.addAttribute("insuNm", insuNm);

		return "brd_notice_ptnr4/board_write_form";
	}//noticePtnr4BoardWriteForm

	@RequestMapping(value = "/noticePtnr4BoardWrite", method = RequestMethod.POST)
	public String noticePtnr4BoardWrite(Model model, HttpSession session, HttpServletRequest request, MultipartRequest multipartRequest, BoardVO inVO) {
		logger.info("======= noticePtnr4BoardWrite =======");

		/*******게시글 부분 시작*******/
		int result = 0;
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		inVO.setUser_no(mbrAuthVo.getUser_no());
		inVO.setReg_ip(request.getRemoteAddr());
		result = sqlSession.insert("BoardNoticePtnr4Mapper.boardWrite", inVO);
		/*******게시글 부분 종료*******/
		/*******첨부 파일 부분 시작*******/
		BoardFileUtil bfcu = new BoardFileUtil();
		String boardNo = "", path = "/home/hosting_users/toplac/www/wp_board/upload/noticePtnr4/";
		int file_flag = 0;
		if(result > 0){
			boardNo = sqlSession.selectOne("BoardNoticePtnr4Mapper.getBoardNo", inVO);
			path = path+boardNo+"/";
			file_flag = bfcu.fileUploadProcessor(multipartRequest, boardNo, path, sqlSession, "BoardNoticePtnr4Mapper.boardFileWrite");
		}//if(result > 0)
		/*******첨부 파일 부분 종료*******/
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 시작*******/
		String ckStrPath = null;
		ckStrPath = bfcu.mvCKFileDirTmpToReal(inVO.getContents(), "noticePtnr4", boardNo);

		if(ckStrPath != null){
			bfcu.deleteDir(ckStrPath);//임시 폴더 내부 자료 및 임시 폴더 삭제

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", boardNo);
			map.put("oldStr", ckStrPath);//임시 폴더 경로
			map.put("newStr", "/home/hosting_users/toplac/www/wp_board/data/noticePtnr4/"+boardNo+"/");//정식 폴더 경로
			sqlSession.update("BoardNoticePtnr4Mapper.updateCKPath", map);//게시글 내부의 임시 폴더 경로를 정식 폴더 경로로 바꾸기
		}
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 종료*******/

		if(result < 1 || (file_flag < 1)){//게시글 입력 실패 또는 첨부파일 저장 실패
			model.addAttribute("boardWriteFailVO", inVO);
			return "brd_notice_ptnr4/board_write_form";
		}
		//(게시글 입력 완료 && 첨부파일이 없음) 또는 (게시글 입력 완료 && 첨부파일 저장 성공)
		return "redirect:/noticePtnr4BoardList?insu="+inVO.getPtnr_id()+"&boardWriteSuccess=1";
	}//noticePtnr4BoardWrite

	@RequestMapping(value = "/noticePtnr4BoardDetail", method = RequestMethod.GET)
	public String noticePtnr4BoardDetail(Model model, HttpSession session, String boardNo, String reqPgNo, BoardSearchVO searchVO) {
		logger.info("======= noticePtnr4BoardDetail =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_12().equals("0"))){
			logger.info("noticePtnr4BoardDetail - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		if(!boardNo.equals(session.getAttribute("brd_no_Session"))){
			sqlSession.update("BoardNoticePtnr4Mapper.boardAddCnt", boardNo);
		}
		session.setAttribute("brd_no_Session", boardNo);

		BoardVO boardDetail = sqlSession.selectOne("BoardNoticePtnr4Mapper.boardDetail", boardNo);
		model.addAttribute("boardDetail", boardDetail);

		List<BoardFileVO> boardFileList = sqlSession.selectList("BoardNoticePtnr4Mapper.boardFileList", boardNo);
		model.addAttribute("boardFileList", boardFileList);

		model.addAttribute("reqPgNo", reqPgNo);
		model.addAttribute("searchVO", searchVO);

		return "brd_notice_ptnr4/board_detail";
	}//noticePtnr4BoardDetail

	@RequestMapping(value = "noticePtnr4BoardDelete", method = RequestMethod.POST)
	public void noticePtnr4BoardDelete(HttpServletResponse response, String boardNo) {
		logger.info("======= noticePtnr4BoardDelete =======");

		int result = 0;
		result = sqlSession.delete("BoardNoticePtnr4Mapper.boardDelete", boardNo);

		int file_flag = 0;
		int file_result = 0;
		if(result > 0){
			BoardFileUtil bfcu = new BoardFileUtil();
			bfcu.deleteDir("/home/hosting_users/toplac/www/wp_board/data/noticePtnr4/"+boardNo+"/");

			file_flag = bfcu.deleteDirReturnFlag("/home/hosting_users/toplac/www/wp_board/upload/noticePtnr4/"+boardNo+"/");

			file_result = sqlSession.delete("BoardNoticePtnr4Mapper.boardFilesDelete", boardNo);

			BoardMemoViewVO memoViewVO = new BoardMemoViewVO();
			memoViewVO.setLinkNo(boardNo);
			memoViewVO.setTargetStr("noticePtnr4");
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

	}//noticePtnr4BoardDelete

	@RequestMapping(value = "/noticePtnr4BoardUpdateForm", method = RequestMethod.GET)
	public String noticePtnr4BoardUpdateForm(Model model, HttpSession session, String boardNo, String reqPgNo, BoardSearchVO searchVO) {
		logger.info("======= noticePtnr4BoardUpdateForm =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_12().equals("0"))){
			logger.info("noticePtnr4BoardUpdateForm - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		BoardVO boardDetail = sqlSession.selectOne("BoardNoticePtnr4Mapper.boardDetail", boardNo);
		model.addAttribute("boardDetail", boardDetail);

		List<BoardFileVO> boardFileList = sqlSession.selectList("BoardNoticePtnr4Mapper.boardFileList", boardNo);
		model.addAttribute("boardFileList", boardFileList);

		model.addAttribute("reqPgNo", reqPgNo);
		model.addAttribute("searchVO", searchVO);

		return "brd_notice_ptnr4/board_update_form";
	}//noticePtnr4BoardUpdateForm

	@RequestMapping(value = "noticePtnr4BoardFileDelete", method = RequestMethod.POST)
	public void noticePtnr4BoardFileDelete(HttpServletResponse response, String fileNo, String filePath, String fileName) {
		logger.info("======= noticePtnr4BoardFileDelete =======");

		BoardFileVO tmpBoardFreeFileVO = sqlSession.selectOne("BoardNoticePtnr1Mapper.noticePtnr4FileOneSelect", fileNo);
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
		file_result = sqlSession.delete("BoardNoticePtnr4Mapper.boardFileDelete", fileNo);

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

	}//noticePtnr4BoardFileDelete

	@RequestMapping(value = "/noticePtnr4BoardUpdate", method = RequestMethod.POST)
	public String noticePtnr4BoardUpdate(Model model, HttpSession session, HttpServletRequest request, MultipartRequest multipartRequest
			, BoardVO inVO, BoardSearchVO searchVO) {
		logger.info("======= noticePtnr4BoardUpdate =======");

		/*******게시글 부분 시작*******/
		int result = 0;
		result = sqlSession.update("BoardNoticePtnr4Mapper.boardUpdate", inVO);
		/*******게시글 부분 종료*******/
		/*******첨부 파일 부분 시작*******/
		BoardFileUtil bfcu = new BoardFileUtil();
		String boardNo = "", path = "/home/hosting_users/toplac/www/wp_board/upload/noticePtnr4/";
		int file_flag = 0;
		if(result > 0){
			boardNo = inVO.getBoard_no();
			path = path+boardNo+"/";
			file_flag = bfcu.fileUploadProcessor(multipartRequest, boardNo, path, sqlSession, "BoardNoticePtnr4Mapper.boardFileWrite");
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
			sqlSession.update("BoardNoticePtnr4Mapper.updateCKPath", map);//게시글 내부의 정식 폴더 경로를 임시 폴더 경로로 바꾸기

			inVO.setContents(inVO.getContents().replaceAll(beforeUpdateCKPath, "/home/hosting_users/toplac/www/wp_board/data/ckeditor_tmp/"+userNo+"/"));
		}
		bfcu.deleteDir("/home/hosting_users/toplac/www/wp_board/data/noticePtnr4/"+boardNo+"/");//정식 폴더 내부 자료 및 정식 폴더 삭제
		/*******게시글에서 수정 전 CKEDITOR 이미지 URL 분리 부분 종료*******/
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 시작*******/
		String ckStrPath = null;
		ckStrPath = bfcu.mvCKFileDirTmpToReal(inVO.getContents(), "noticePtnr4", boardNo);

		if(ckStrPath != null){
			bfcu.deleteDir(ckStrPath);//임시 폴더 내부 자료 및 임시 폴더 삭제

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", boardNo);
			map.put("oldStr", ckStrPath);//임시 폴더 경로
			map.put("newStr", "/home/hosting_users/toplac/www/wp_board/data/noticePtnr4/"+boardNo+"/");//정식 폴더 경로
			sqlSession.update("BoardNoticePtnr4Mapper.updateCKPath", map);//게시글 내부의 임시 폴더 경로를 정식 폴더 경로로 바꾸기
		}
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 종료*******/

		if(result < 1 || (file_flag < 1)){//게시글 입력 실패 또는 첨부파일 저장 실패
			List<BoardFileVO> boardFileList = sqlSession.selectList("BoardNoticePtnr4Mapper.boardFileList", boardNo);
			model.addAttribute("boardFileList", boardFileList);
			model.addAttribute("boardUpdateFailFlag", 1);
			model.addAttribute("boardDetail", inVO);
			return "brd_notice_ptnr4/board_update_form";
		}
		//(게시글 입력 완료 && 첨부파일이 없음) 또는 (게시글 입력 완료 && 첨부파일 저장 성공)
		return "redirect:/noticePtnr4BoardList?updateSuccess=1"
		+"&insu="+inVO.getPtnr_id()
		+"&boardSrcType="+searchVO.getBoardSrcType()
		+"&boardSrcWord="+searchVO.getBoardSrcWord()
		+"&reqPgNo="+searchVO.getReqPgNo();
	}//noticePtnrBoardUpdate

	@RequestMapping(value = "/noticePtnr4BoardPrint", method = RequestMethod.GET)
	public String noticePtnr4BoardPrint(Model model, HttpSession session, String boardNo) {
		logger.info("======= noticePtnr4BoardPrint =======");

		/*세션 유효 검사 시작*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_12().equals("0"))){
			logger.info("noticePtnr4BoardPrint - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		BoardVO boardDetail = sqlSession.selectOne("BoardNoticePtnr4Mapper.boardDetail", boardNo);
		model.addAttribute("boardDetail", boardDetail);

		return "brd_common/board_print_pop";
	}//noticePtnr4BoardPrint

	@RequestMapping(value = "noticePtnr4ReWrite", method = RequestMethod.POST)
	public void noticePtnr4ReWrite(HttpServletResponse response, String boardNo) {
		logger.info("======= noticePtnr4ReWrite =======");

		BoardVO boardDetail = sqlSession.selectOne("BoardNoticePtnr4Mapper.boardDetail", boardNo);

		int result = 0;
		result = sqlSession.insert("BoardNoticePtnr4Mapper.boardWrite2", boardDetail);

		if(result > 0){
			String newBoardNo = sqlSession.selectOne("BoardNoticePtnr4Mapper.getBoardNo", boardDetail);

			File attachFileDir = new File("/home/hosting_users/toplac/www/wp_board/upload/noticePtnr4/"+boardNo+"/");
			if(attachFileDir.exists()){
				File attachFileDir2 = new File("/home/hosting_users/toplac/www/wp_board/upload/noticePtnr4/"+newBoardNo+"/");
				attachFileDir.renameTo(attachFileDir2);
			}
			File ckFileDir = new File("/home/hosting_users/toplac/www/wp_board/data/noticePtnr4/"+boardNo+"/");
			if(ckFileDir.exists()){
				File ckFileDir2 = new File("/home/hosting_users/toplac/www/wp_board/data/noticePtnr4/"+newBoardNo+"/");
				ckFileDir.renameTo(ckFileDir2);
			}

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", boardNo);
			map.put("newBoardNo", newBoardNo);
			map.put("attachFileDir", "/"+boardNo+"/");
			map.put("attachFileDir2", "/"+newBoardNo+"/");
			map.put("ckFileDir", "/home/hosting_users/toplac/www/wp_board/data/noticePtnr4/"+boardNo+"/");
			map.put("ckFileDir2", "/home/hosting_users/toplac/www/wp_board/data/noticePtnr4/"+newBoardNo+"/");

			sqlSession.update("BoardNoticePtnr4Mapper.updateCKPath2", map);
			sqlSession.update("BoardNoticePtnr4Mapper.updateBoardFiles", map);
			sqlSession.update("BoardNoticePtnr4Mapper.updateBoardMemos", map);
			sqlSession.delete("BoardNoticePtnr4Mapper.boardDelete", boardNo);
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

	}//noticePtnr4ReWrite

}//end of class
