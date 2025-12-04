/*
*********************************************************
* Program ID	: BoardHelpDeskController
* Program Name	: BoardHelpDeskController
* Description	: 전산지원요청
* Author		: 
* Date			: 2016.06.11.
*********************************************************
*/
package kr.co.toplac.brd.helpdesk;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URLDecoder;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.converter.FormHttpMessageConverter;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.UriComponentsBuilder;

import kr.co.toplac.brd.common.BoardFileUtil;
import kr.co.toplac.brd.common.BoardFileVO;
import kr.co.toplac.brd.common.BoardMemoViewVO;
import kr.co.toplac.brd.common.BoardPageUtil;
import kr.co.toplac.brd.common.BoardSearchVO;
import kr.co.toplac.brd.common.BoardVO;
import kr.co.toplac.topmain.MainLeftSuimVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;
import kr.co.toplac.util.rpt.MainLeftUtil;

@Controller
public class BoardHelpDeskController {

	private static final Logger logger = LoggerFactory.getLogger(BoardHelpDeskController.class);

	@Autowired
	SqlSession sqlSession;

	@Autowired
	MainLeftUtil mlu;
	
	@RequestMapping(value = "/equip_apply_save", method = RequestMethod.POST)
	@ResponseBody
	public int equip_apply_save(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= equip_apply_save =======");
				
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        int nRet = 0;

        /*ip 얻기 시작*/
        String sLog_ip = "";
		HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		sLog_ip = req.getHeader("X-FORWARDED-FOR");
		
		if (sLog_ip == null){
			sLog_ip = req.getRemoteAddr(); 
		}
		/*ip 얻기 끝*/
		
		BoardVO inVO = new BoardVO();
		
		String body_subject = String.valueOf(paramMap.get("body_subject"));					//글 제목
		String body_team_name = String.valueOf(paramMap.get("body_team_name"));		//사용자 팀명
		String body_eq_memo = String.valueOf(paramMap.get("body_eq_memo"));				//신청 사유
		String body_eq_name = String.valueOf(paramMap.get("body_eq_name"));				//신청 장비명
		String body_user_name = String.valueOf(paramMap.get("body_user_name"));			//사용자 이름
		String body_reg_date =  String.valueOf(paramMap.get("body_reg_date"));				//사용 희망일
		
		String team_id = String.valueOf(paramMap.get("team_id"));									//신청자 팀아이디
		String user_no = String.valueOf(paramMap.get("user_no"));									//신청자 사번
				
        //글 등록시작
		String sBodyContent = "";
		sBodyContent +="<p>사용자 부서 : "+body_team_name+"</p>";
		sBodyContent +="<p>사용자 이름 : "+body_user_name+"</p>";
		sBodyContent +="<p>신청 장비명 : "+body_eq_name+"</p>";
		sBodyContent +="<p>신청 사유 : "+body_eq_memo+"</p>";
		sBodyContent +="<p>사용 예정일 : "+body_reg_date+"</p>";				
				
		inVO.setTitle(body_subject);
		inVO.setUser_no(user_no);
		inVO.setTeam_id(team_id);
		inVO.setContents(sBodyContent);
		inVO.setReg_ip(sLog_ip);
		
		nRet = sqlSession.insert("BoardHelpDeskMapper.boardWrite", inVO);        
        //글 등록 끝
				
		//문자발송 시작
		String smsContents = "";
		smsContents +="[전산지원신청]\n";
		smsContents +="신청자 : "+mbrVo.getTeam_name()+" "+mbrVo.getUser_name() + " (연락처 : "+mbrVo.getHandphone()+")\n";
		smsContents +="제목 : "+inVO.getTitle()+"\n";
		smsContents +="내용 : 전산장비신청\n";		
		smsContents +="사용자 부서 : "+body_team_name+"\n";		
		smsContents +="사용자 이름 : "+body_user_name+"\n";
		smsContents +="신청 장비명 : "+body_eq_name+"\n";
		smsContents +="신청 사유 : "+body_eq_memo+"\n";
		smsContents +="사용 예정일 : "+body_reg_date+"\n";	
				
		//태그제거
		smsContents = smsContents.replaceAll("<br />", "\n");
		smsContents = smsContents.replaceAll("&nbsp;", " ");
		smsContents = smsContents.replaceAll("<(/)?([a-zA-Z]*)(\\\\s[a-zA-Z]*=[^>]*)?(\\\\s)*(/)?>", "");		
		
		int smsType = 1;				//신청접수
		
		List<Map<String,Object>> receiveList = sqlSession.selectList("BoardHelpDeskMapper.selectItHandphoneList");
		String receiveNo = "";
		String senderNo = "0260774600";				
		
		for( int i=0; i < receiveList.size(); i++ ) {
			receiveNo = receiveList.get(i).get("handphone").toString();
			receiveNo = receiveNo.replaceAll("-", "");
			sendKakaoTalk(senderNo, receiveNo, smsContents, smsType);
		}		
		//문자발송 끝		
        
		return nRet;		
	}
	
	@RequestMapping(value = "/helpDeskBoardListExcel", method = RequestMethod.POST)
	public String helpDeskBoardListExcel(Model model, HttpSession session) {
		logger.info("======= helpDeskBoardListExcel =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		String sUser_state = mbrVo.getUser_state().toString();
		
		if(mbrVo == null || !"9".equals(sUser_state) ){					//시스템 권한이 없는사람은 접근불가
			logger.info("helpDeskBoardList - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		//전체목록을 다 불러온다.
		List<BoardVO> boardListAuth = sqlSession.selectList("BoardHelpDeskMapper.boardListAuthAll");
		
		model.addAttribute("boardListAuth", boardListAuth);		
		
		return "brd_help_desk/board_list_auth_excel";
	}

	@RequestMapping(value = "/helpDeskBoardList", method = RequestMethod.GET)
	public String helpDeskBoardList(Model model, HttpSession session
			, String boardWriteSuccess, String boardUpdateSuccess, BoardSearchVO searchVO, String currentTab, String smsContents) {
		logger.info("======= helpDeskBoardList =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("helpDeskBoardList - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());
				
		//목록 조회권한 체크 by oniku
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");		
		String approval_auth = mbrAuthVo.getMbr_pms_30().toString();
		
		String sUser_state = mbrVo.getUser_state().toString();
		if( "9".equals(sUser_state) ){
			approval_auth = "5";
		}		
		searchVO.setApproval_auth(approval_auth);

		BoardPageUtil pageUtil = new BoardPageUtil();
		List<BoardVO> boardList
		= (List<BoardVO>) pageUtil.boardPageSearch1(1, sqlSession, "BoardHelpDeskMapper.boardList", searchVO, model, "helpDeskBoardList");
		model.addAttribute("boardList", boardList);

		List<BoardVO> boardListIntra
		= (List<BoardVO>) pageUtil.boardPageSearch1(2, sqlSession, "BoardHelpDeskMapper.boardListIntra", searchVO, model, "helpDeskBoardList");
		model.addAttribute("boardListIntra", boardListIntra);

		List<BoardVO> boardListPc
		= (List<BoardVO>) pageUtil.boardPageSearch1(3, sqlSession, "BoardHelpDeskMapper.boardListPc", searchVO, model, "helpDeskBoardList");
		model.addAttribute("boardListPc", boardListPc);

		List<BoardVO> boardListTel
		= (List<BoardVO>) pageUtil.boardPageSearch1(4, sqlSession, "BoardHelpDeskMapper.boardListTel", searchVO, model, "helpDeskBoardList");
		model.addAttribute("boardListTel", boardListTel);

		List<BoardVO> boardListSecu
		= (List<BoardVO>) pageUtil.boardPageSearch1(5, sqlSession, "BoardHelpDeskMapper.boardListSecu", searchVO, model, "helpDeskBoardList");
		model.addAttribute("boardListSecu", boardListSecu);

		List<BoardVO> boardListEtc
		= (List<BoardVO>) pageUtil.boardPageSearch1(6, sqlSession, "BoardHelpDeskMapper.boardListEtc", searchVO, model, "helpDeskBoardList");
		model.addAttribute("boardListEtc", boardListEtc);

		List<BoardVO> boardListMail
		= (List<BoardVO>) pageUtil.boardPageSearch1(7, sqlSession, "BoardHelpDeskMapper.boardListMail", searchVO, model, "helpDeskBoardList");
		model.addAttribute("boardListMail", boardListMail);
		
		List<BoardVO> boardListAuth
		= (List<BoardVO>) pageUtil.boardPageSearch1(8, sqlSession, "BoardHelpDeskMapper.boardListAuth", searchVO, model, "helpDeskBoardList");
		model.addAttribute("boardListAuth", boardListAuth);
		
		List<BoardVO> boardListEquip
		= (List<BoardVO>) pageUtil.boardPageSearch1(9, sqlSession, "BoardHelpDeskMapper.boardListEquip", searchVO, model, "helpDeskBoardList");
		model.addAttribute("boardListEquip", boardListEquip);
		
		List<Map<String, Object>> teamList = sqlSession.selectList("ItMgmtMapper.selectTeamList");
		model.addAttribute("teamList", teamList);
		
		model.addAttribute("boardWriteSuccess", boardWriteSuccess);
		model.addAttribute("boardUpdateSuccess", boardUpdateSuccess);
		model.addAttribute("searchVO", searchVO);
		
		model.addAttribute("smsContents",smsContents);
		model.addAttribute("currentTab", currentTab);
		
		return "brd_help_desk/board_list";
	}//helpDeskBoardList

	@RequestMapping(value = "/helpDeskBoardWriteForm", method = RequestMethod.GET)
	public String helpDeskBoardWriteForm(Model model, HttpSession session) {
		logger.info("======= helpDeskBoardWriteForm =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("helpDeskBoardWriteForm - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());
		
		return "brd_help_desk/board_write_form";
	}//helpDeskBoardWriteForm

	@RequestMapping(value = "/helpDeskBoardWrite", method = RequestMethod.POST)
	public String helpDeskBoardWrite(Model model, HttpSession session, HttpServletRequest request, MultipartRequest multipartRequest, BoardVO inVO, RedirectAttributes redirectAttributes) {
		logger.info("======= helpDeskBoardWrite =======");

		/*******게시글 부분 시작*******/
		int result = 0;
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		inVO.setTeam_id(mbrVo.getTeam_id_main());
		//TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session"); 
		inVO.setUser_no(mbrVo.getUser_no());
		inVO.setReg_ip(request.getRemoteAddr());
		result = sqlSession.insert("BoardHelpDeskMapper.boardWrite", inVO);
		/*******게시글 부분 종료*******/
		/*******첨부 파일 부분 시작*******/
		BoardFileUtil bfcu = new BoardFileUtil();
		String boardNo = "", path = "/home/hosting_users/toplac/www/wp_board/upload/helpDesk/";
		int file_flag = 0;
		if(result > 0){
			boardNo = sqlSession.selectOne("BoardHelpDeskMapper.getBoardNo", inVO);
			path = path+boardNo+"/";
			file_flag = bfcu.fileUploadProcessor(multipartRequest, boardNo, path, sqlSession, "BoardHelpDeskMapper.boardFileWrite");
		}//if(result > 0)
		/*******첨부 파일 부분 종료*******/
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 시작*******/
		String ckStrPath = null;
		ckStrPath = bfcu.mvCKFileDirTmpToReal(inVO.getContents(), "helpDesk", boardNo);

		if(ckStrPath != null){
			bfcu.deleteDir(ckStrPath);//임시 폴더 내부 자료 및 임시 폴더 삭제

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", boardNo);
			map.put("oldStr", ckStrPath);//임시 폴더 경로
			map.put("newStr", "/home/hosting_users/toplac/www/wp_board/data/helpDesk/"+boardNo+"/");//정식 폴더 경로
			sqlSession.update("BoardHelpDeskMapper.updateCKPath", map);//게시글 내부의 임시 폴더 경로를 정식 폴더 경로로 바꾸기
		}
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 종료*******/

		if(result < 1 || (file_flag < 1)){//게시글 입력 실패 또는 첨부파일 저장 실패
			model.addAttribute("boardWriteFailVO", inVO);
			return "brd_help_desk/board_write_form";
		}
		//(게시글 입력 완료 && 첨부파일이 없음) 또는 (게시글 입력 완료 && 첨부파일 저장 성공)
		
		//문자발송 메시지
		String smsContents = "";
		smsContents +="[전산지원신청]\n";
		smsContents +="신청자 : "+mbrVo.getTeam_name()+" "+mbrVo.getUser_name() + " (연락처 : "+mbrVo.getHandphone()+")\n";
		smsContents +="제목 : "+inVO.getTitle()+"\n";
		smsContents +="내용 : "+inVO.getContents();
		
		//태그제거
		smsContents = smsContents.replaceAll("<br />", "\n");
		smsContents = smsContents.replaceAll("&nbsp;", " ");
		smsContents = smsContents.replaceAll("<(/)?([a-zA-Z]*)(\\\\s[a-zA-Z]*=[^>]*)?(\\\\s)*(/)?>", "");
		
		
		//System.out.println("smsContents="+smsContents);
		
		int smsType = 1;				//신청접수
		
		List<Map<String,Object>> receiveList = sqlSession.selectList("BoardHelpDeskMapper.selectItHandphoneList");
		String receiveNo = "";
		String senderNo = "0260774600";
		
		for( int i=0; i < receiveList.size(); i++ ) {
			receiveNo = receiveList.get(i).get("handphone").toString();
			receiveNo = receiveNo.replaceAll("-", "");
			sendKakaoTalk(senderNo, receiveNo, smsContents, smsType);
		}
		
		//redirectAttributes.addAttribute("smsContents",StringUtil.getMaxByteString(smsContents,100));
		
		return "redirect:/helpDeskBoardList?boardWriteSuccess=1";
	}//helpDeskBoardWrite
	
	/**
	 * 전산신청시 카카오톡 방식으로 변경
	 * SmsType(1:접수, 2:완료)	 
	 **/
	public static String sendKakaoTalk(String senderNo, String receiveNo, String sMsg, int smsType){				//smsType에 따라 메세지가 달라짐
		String sRet = "";
		
		String tmplId = "toplac_helpdesk_1";		//helpdesk 접수시 안내문자
		
		if( smsType == 2 ){			//helpdesk 완료시 안내문자 
			tmplId = "toplac_helpdesk_2";
		}
		
		String msg = sMsg;								//발송메세지
		
		String phn = "82"+receiveNo.substring(1);
		
		RestTemplate restTemplate = new RestTemplate();
		// RestTemplate 에 MessageConverter 세팅
	    List<HttpMessageConverter<?>> converters = new ArrayList<HttpMessageConverter<?>>();
	    converters.add(new FormHttpMessageConverter());
	    converters.add(new StringHttpMessageConverter(Charset.forName("UTF-8")));
		
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.add("Accept", "application/json");
		httpHeaders.add("Content-type", "application/json");
		httpHeaders.add("userId", "toplac"); //실제
		
		
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		obj.put("message_type", "at");
		obj.put("phn", phn);
		obj.put("profile", "22e9cd927d652e02daca5dc631170e021f02ae51");	//실제
		obj.put("tmplId", tmplId);
		obj.put("msg", msg);
	
		obj.put("smsKind", "L");
		obj.put("msgSms", msg);
		obj.put("smsSender", "0260774600");
	
		obj.put("smsLmsTit", "탑손해사정주식회사");
		obj.put("reserveDt", "00000000000000");
		
		//메시지 길이가 930자 이상인경우 SMS 로 전환하여 발송
		int msgLength = msg.length();
		if( msgLength > 930 ) {
			obj.put("smsOnly", "Y");
		}
		
		arr.add(obj);
		
		HttpEntity entity = new HttpEntity(arr, httpHeaders);
		
		URI uri = UriComponentsBuilder.fromHttpUrl("https://alimtalk-api.bizmsg.kr/v2/sender/send")
				.build().toUri();
				
		
		String responseEntity = restTemplate.postForObject(uri, entity, String.class);
		
		//logger.info("IT Helpdesk SendKakao : "+phn+" : "+msg+" : "+tmplId);
		
		return sRet;		
	}

	@RequestMapping(value = "/helpDeskBoardDetail", method = RequestMethod.GET)
	public String helpDeskBoardDetail(Model model, HttpSession session, String boardNo, String reqPgNo, BoardSearchVO searchVO) {
		logger.info("======= helpDeskBoardDetail =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("helpDeskBoardDetail - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		if(!boardNo.equals(session.getAttribute("brd_no_Session"))){
			sqlSession.update("BoardHelpDeskMapper.boardAddCnt", boardNo);
		}
		session.setAttribute("brd_no_Session", boardNo);

		BoardVO boardDetail = sqlSession.selectOne("BoardHelpDeskMapper.boardDetail", boardNo);
		
		model.addAttribute("boardDetail", boardDetail);

		List<BoardFileVO> boardFileList = sqlSession.selectList("BoardHelpDeskMapper.boardFileList", boardNo);
		model.addAttribute("boardFileList", boardFileList);
		
		//결재권한 확인 
		//top_mbr_pms 테이블 30번의 값을 세션으로 가져온다.
		
		//권한 세션
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");		
		String auth_approval = mbrAuthVo.getMbr_pms_30().toString();
		
		model.addAttribute("auth_approval", auth_approval);
		model.addAttribute("reqPgNo", reqPgNo);
		model.addAttribute("searchVO", searchVO);

		return "brd_help_desk/board_detail";
	}//helpDeskBoardDetail

	@RequestMapping(value = "helpDeskBoardDelete", method = RequestMethod.POST)
	public void helpDeskBoardDelete(HttpServletResponse response, String boardNo) {
		logger.info("======= helpDeskBoardDelete =======");

		int result = 0;
		result = sqlSession.delete("BoardHelpDeskMapper.boardDelete", boardNo);

		int file_flag = 0;
		int file_result = 0;
		if(result > 0){
			BoardFileUtil bfcu = new BoardFileUtil();
			bfcu.deleteDir("/home/hosting_users/toplac/www/wp_board/data/helpDesk/"+boardNo+"/");

			file_flag = bfcu.deleteDirReturnFlag("/home/hosting_users/toplac/www/wp_board/upload/helpDesk/"+boardNo+"/");

			file_result = sqlSession.delete("BoardHelpDeskMapper.boardFilesDelete", boardNo);

			BoardMemoViewVO memoViewVO = new BoardMemoViewVO();
			memoViewVO.setLinkNo(boardNo);
			memoViewVO.setTargetStr("helpDesk");
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

	}//helpDeskBoardDelete

	@RequestMapping(value = "/helpDeskBoardUpdateForm", method = RequestMethod.GET)
	public String helpDeskBoardUpdateForm(Model model, HttpSession session, String boardNo, String reqPgNo, BoardSearchVO searchVO) {
		logger.info("======= helpDeskBoardUpdateForm =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("helpDeskBoardUpdateForm - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		BoardVO boardDetail = sqlSession.selectOne("BoardHelpDeskMapper.boardDetail", boardNo);
		model.addAttribute("boardDetail", boardDetail);

		List<BoardFileVO> boardFileList = sqlSession.selectList("BoardHelpDeskMapper.boardFileList", boardNo);
		model.addAttribute("boardFileList", boardFileList);

		model.addAttribute("reqPgNo", reqPgNo);
		model.addAttribute("searchVO", searchVO);

		return "brd_help_desk/board_update_form";
	}//helpDeskBoardUpdateForm

	@RequestMapping(value = "helpDeskBoardFileDelete", method = RequestMethod.POST)
	public void helpDeskBoardFileDelete(HttpServletResponse response, String fileNo, String filePath, String fileName) {
		logger.info("======= helpDeskBoardFileDelete =======");

		BoardFileVO tmpBoardFreeFileVO = sqlSession.selectOne("BoardHelpDeskMapper.helpDeskFileOneSelect", fileNo);
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
		file_result = sqlSession.delete("BoardHelpDeskMapper.boardFileDelete", fileNo);

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

	}//helpDeskBoardFileDelete

	@RequestMapping(value = "/helpDeskBoardUpdate", method = RequestMethod.POST)
	public String helpDeskBoardUpdate(Model model, HttpSession session, HttpServletRequest request, MultipartRequest multipartRequest
			, BoardVO inVO, BoardSearchVO searchVO) {
		logger.info("======= helpDeskBoardUpdate =======");

		/*******게시글 부분 시작*******/
		int result = 0;
		result = sqlSession.update("BoardHelpDeskMapper.boardUpdate", inVO);
		/*******게시글 부분 종료*******/
		/*******첨부 파일 부분 시작*******/
		BoardFileUtil bfcu = new BoardFileUtil();
		String boardNo = "", path = "/home/hosting_users/toplac/www/wp_board/upload/helpDesk/";
		int file_flag = 0;
		if(result > 0){
			boardNo = inVO.getBoard_no();
			path = path+boardNo+"/";
			file_flag = bfcu.fileUploadProcessor(multipartRequest, boardNo, path, sqlSession, "BoardHelpDeskMapper.boardFileWrite");
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
			sqlSession.update("BoardHelpDeskMapper.updateCKPath", map);//게시글 내부의 정식 폴더 경로를 임시 폴더 경로로 바꾸기

			inVO.setContents(inVO.getContents().replaceAll(beforeUpdateCKPath, "/home/hosting_users/toplac/www/wp_board/data/ckeditor_tmp/"+userNo+"/"));
		}
		bfcu.deleteDir("/home/hosting_users/toplac/www/wp_board/data/helpDesk/"+boardNo+"/");//정식 폴더 내부 자료 및 정식 폴더 삭제
		/*******게시글에서 수정 전 CKEDITOR 이미지 URL 분리 부분 종료*******/
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 시작*******/
		String ckStrPath = null;
		ckStrPath = bfcu.mvCKFileDirTmpToReal(inVO.getContents(), "helpDesk", boardNo);

		if(ckStrPath != null){
			bfcu.deleteDir(ckStrPath);//임시 폴더 내부 자료 및 임시 폴더 삭제

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", boardNo);
			map.put("oldStr", ckStrPath);//임시 폴더 경로
			map.put("newStr", "/home/hosting_users/toplac/www/wp_board/data/helpDesk/"+boardNo+"/");//정식 폴더 경로
			sqlSession.update("BoardHelpDeskMapper.updateCKPath", map);//게시글 내부의 임시 폴더 경로를 정식 폴더 경로로 바꾸기
		}
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 종료*******/

		if(result < 1 || (file_flag < 1)){//게시글 입력 실패 또는 첨부파일 저장 실패
			List<BoardFileVO> boardFileList = sqlSession.selectList("BoardHelpDeskMapper.boardFileList", boardNo);
			model.addAttribute("boardFileList", boardFileList);
			model.addAttribute("boardUpdateFailFlag", 1);
			model.addAttribute("boardDetail", inVO);
			return "brd_help_desk/board_update_form";
		}
		//(게시글 입력 완료 && 첨부파일이 없음) 또는 (게시글 입력 완료 && 첨부파일 저장 성공)
		return "redirect:/helpDeskBoardList?updateSuccess=1"
		+"&boardSrcType="+searchVO.getBoardSrcType()
		+"&boardSrcWord="+searchVO.getBoardSrcWord()
		+"&reqPgNo="+searchVO.getReqPgNo();
	}//helpDeskBoardUpdate

	@RequestMapping(value = "/helpDeskBoardPrint", method = RequestMethod.GET)
	public String helpDeskBoardPrint(Model model, HttpSession session, String boardNo) {
		logger.info("======= helpDeskBoardPrint =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("helpDeskBoardPrint - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		BoardVO boardDetail = sqlSession.selectOne("BoardHelpDeskMapper.boardDetail", boardNo);
		model.addAttribute("boardDetail", boardDetail);

		return "brd_common/board_print_pop";
	}//helpDeskBoardPrint

	@RequestMapping(value = "helpDeskAccept", method = RequestMethod.POST)
	public void helpDeskAccept(HttpServletResponse response, HttpSession session, BoardVO inVO) {
		logger.info("======= helpDeskAccept =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		inVO.setUser_no(mbrVo.getUser_no());

		int result = 0;
		result = sqlSession.update("BoardHelpDeskMapper.helpDeskAccept", inVO);

		int outMsg = 1;
		if(result < 1){
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

	}//helpDeskAccept
	
	@RequestMapping(value = "helpDeskApproval", method = RequestMethod.POST)
	public void helpDeskApproval(HttpServletResponse response, HttpServletRequest request, HttpSession session, BoardVO inVO ) {
		logger.info("======= helpDeskApproval =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		inVO.setUser_no(mbrVo.getUser_no());
		
		Map<String,Object> paramMap = new HashMap<String,Object>();
		
		String board_no = request.getParameter("board_no") != null ? request.getParameter("board_no") : "";
		String approval_comment = request.getParameter("approval_comment") != null ? request.getParameter("approval_comment") : "";
		//String approval_type = request.getParameter("approval_type") != null ? request.getParameter("approval_type") : "";		
		String solve_state = request.getParameter("solve_state") != null ? request.getParameter("solve_state") : "";
		
		paramMap.put("board_no", board_no);
		paramMap.put("approval_comment",approval_comment);
		//paramMap.put("approval_type", approval_type);
		paramMap.put("solve_state", solve_state);
		paramMap.put("approval_no", mbrVo.getUser_no());		//

		int result = 0;
		
		result = sqlSession.update("BoardHelpDeskMapper.helpDeskApproval",paramMap);				

		int outMsg = 1;
		if(result < 1){
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

	}//helpdeskApproval
	
	@RequestMapping(value = "helpDeskAuth", method = RequestMethod.POST)
	public void helpDeskAuth(HttpServletResponse response, HttpServletRequest request, HttpSession session, BoardVO inVO ) {
		logger.info("======= helpDeskAuth =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		inVO.setUser_no(mbrVo.getUser_no());
		
		Map<String,Object> paramMap = new HashMap<String,Object>();
		
		String board_no = request.getParameter("board_no") != null ? request.getParameter("board_no") : "";
		String auth_memo = request.getParameter("auth_memo") != null ? request.getParameter("auth_memo") : "";
		String auth_type = request.getParameter("auth_type") != null ? request.getParameter("auth_type") : "";
		String solve_state = request.getParameter("solve_state") != null ? request.getParameter("solve_state") : "";		
		
		paramMap.put("board_no", board_no);
		paramMap.put("auth_memo", auth_memo);
		paramMap.put("auth_type", auth_type);
		paramMap.put("solve_state", solve_state);
		paramMap.put("drafter_no", mbrVo.getUser_no());		//기안자사번

		int result = 0;
		//result = sqlSession.update("BoardHelpDeskMapper.helpDeskSolve", inVO);
		result = sqlSession.update("BoardHelpDeskMapper.helpDeskAuth",paramMap);

		int outMsg = 1;
		if(result < 1){
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

	}//helpDeskSolve

	@RequestMapping(value = "helpDeskSolve", method = RequestMethod.POST)
	public void helpDeskSolve(HttpServletResponse response, HttpSession session, BoardVO inVO) {
		logger.info("======= helpDeskSolve =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		inVO.setUser_no(mbrVo.getUser_no());

		int result = 0;
		result = sqlSession.update("BoardHelpDeskMapper.helpDeskSolve", inVO);
		
		//신청자 연락처를 가져온다.		 
		Map<String,Object> helpUser = sqlSession.selectOne("BoardHelpDeskMapper.getHelpdeskUserInfo", inVO);
		//완료 알림보내기
		String sSubject = inVO.getTitle();
		String solveMemo = inVO.getSolve_memo();
		if( "".equals(solveMemo) ){
			solveMemo = "완료되었습니다.";
		}
		
		String user_name = helpUser.get("user_name").toString();
		String receiveNo = helpUser.get("handphone").toString();		
		receiveNo = receiveNo.replaceAll("-", "");
		
		String smsContents = "";
		smsContents +="[전산지원완료]\n";
		smsContents +="신청자 : "+user_name+"\n";
		smsContents +="제목 : "+sSubject+"\n";
		smsContents +="담당자 : "+mbrVo.getUser_name()+" (IT정보보호파트)\n";
		smsContents +="조치내용 : "+solveMemo;
		
		//태그제거
		smsContents = smsContents.replaceAll("<br />", "\n");
		smsContents = smsContents.replaceAll("&nbsp;", " ");
		smsContents = smsContents.replaceAll("<(/)?([a-zA-Z]*)(\\\\s[a-zA-Z]*=[^>]*)?(\\\\s)*(/)?>", "");
		
		int smsType = 2;				//신청완료
		
		List<Map<String,Object>> receiveList = sqlSession.selectList("BoardHelpDeskMapper.selectItHandphoneList");		
		String senderNo = "0260774600";
		
		//신청자에게 발송
		sendKakaoTalk(senderNo, receiveNo, smsContents, smsType);
		
		//IT정보보호파트 담당자에게 발송
		for( int i=0; i < receiveList.size(); i++ ) {
			receiveNo = receiveList.get(i).get("handphone").toString();
			receiveNo = receiveNo.replaceAll("-", "");
			sendKakaoTalk(senderNo, receiveNo, smsContents, smsType);
		}

		int outMsg = 1;
		if(result < 1){
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

	}//helpDeskSolve
	
	
	@RequestMapping(value = "/helpDeskBoardSMS", method = RequestMethod.GET)
	public String helpDeskBoardSMS(Model model, HttpSession session, HttpServletRequest request) throws UnsupportedEncodingException {
		logger.info("======= helpDeskBoardSMS =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("helpDeskBoardSMS - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		String smsContents = request.getParameter("smsContents");
		String decodeSms = URLDecoder.decode(smsContents,"UTF-8");
		//System.out.println(smsContents);
		//System.out.println(decodeSms);
		
		model.addAttribute("smsContents",decodeSms);
		
		return "brd_help_desk/board_smsSend";
	}//helpDeskBoardPrint


}//end of class
