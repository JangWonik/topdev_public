package kr.co.toplac.topteam;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.cmm.service.CodeDicService;
import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.etc.SplitPhoneNo;
import kr.co.toplac.util.file.GetImageBase64;
import kr.co.toplac.util.page.PageUtilityBasic;
import kr.co.toplac.util.rpt.MainLeftUtil;

@Controller
public class MbrStatListController {
	
	private static final Logger logger = LoggerFactory.getLogger(MbrStatListController.class);
	
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	MainLeftUtil mlu;
	
	@Autowired
	private CodeDicService service;
	
	/**
	 * 보험사별 지역 심사자 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/insaInsuZoneStatTable")
    public String insaInsuZoneStatTable(HttpServletRequest request, Model model) {
    	
    	logger.info("========= insaInsuZoneStatTable =========");    	    	

    	String sUrl = "top_team/top_insa_stat_insu_table";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	//CommonUtils.printMap(paramMap);
    	
    	//보험사별 지역목록 최종
    	List<Map<String,Object>> ptnrToZoneList = new ArrayList<>();
    	
    	//팀 지역설정용 목록 불러오기
    	List<Map<String, Object>> zoneStatList = sqlSession.selectList("MbrStatListMapper.selectTeamZoneStatList");
    	
    	String team_zone = "";
    	String team_zone_val = "";
    	String team_ptnr_id = String.valueOf(paramMap.get("ptnr_id"));    	
    	int nTempMember = 0;
    	
    	for( int i=0; i < zoneStatList.size(); i++) {
			
			Map<String, Object> sqlMap = new HashMap<>();
			Map<String, Object> returnMap = new HashMap<>();
			
			team_zone = String.valueOf(zoneStatList.get(i).get("team_zone"));
			team_zone_val = String.valueOf(zoneStatList.get(i).get("team_zone_val"));
			
			sqlMap.put("team_zone", team_zone);
			sqlMap.put("team_zone_val", team_zone_val);
			sqlMap.put("ptnr_id", team_ptnr_id);
			
			returnMap = sqlSession.selectOne("MbrStatListMapper.selectPtnrStatByTeamzone", sqlMap);
			
			nTempMember = Integer.parseInt(returnMap.get("ptnr_member_total_cnt").toString());
			
			if( nTempMember > 0 ) {
				ptnrToZoneList.add(returnMap);
			}
			
		}
    	
    	model.addAttribute("ptnrToZoneList", ptnrToZoneList);
    	
    	model.addAttribute("member_1_2_sum", paramMap.get("member_1_2_sum"));
    	model.addAttribute("member_4_2_sum", paramMap.get("member_4_2_sum"));
    	model.addAttribute("member_4_3_sum", paramMap.get("member_4_3_sum"));
    	model.addAttribute("member_4_4_sum", paramMap.get("member_4_4_sum"));
    	
    	return sUrl;
    }
	
	/**
	 * 4종 지역 보험사 별 심사인원수 가져오기
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/insaZoneInsu4StatTable")
    public String insaZoneInsu4StatTable(HttpServletRequest request, Model model) {
    	
    	logger.info("========= insaZoneInsu4StatTable =========");    	    	

    	String sUrl = "top_team/top_insa_stat_4_table";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	//CommonUtils.printMap(paramMap);    	
    	
    	//팀 보험사 지정용 보험사 목록 가져오기(통계 보험사 목록과 동일)
    	List<Map<String, Object>> teamPtnrList = sqlSession.selectList("MisPtnrBsc.selectTeamPtnrList");
    	
    	String team_zone = String.valueOf(paramMap.get("team_zone"));
    	String team_ptnr_id = "";
    	String team_ptnr_id_val = "";
    	int nTempMember = 0;
    	
    	List<Map<String, Object>> result4Member = new ArrayList<>(); 
    	
    	for( int i=0; i < teamPtnrList.size(); i++ ) {
    		
    		Map<String, Object> sqlMap = new HashMap<>();
    		Map<String, Object> returnMap = new HashMap<>();
    		
    		team_ptnr_id = String.valueOf(teamPtnrList.get(i).get("ptnr_id"));
    		team_ptnr_id_val = String.valueOf(teamPtnrList.get(i).get("ptnr_nick"));
    		
    		sqlMap.put("team_zone", team_zone);
    		sqlMap.put("team_ptnr_id", team_ptnr_id);
    		sqlMap.put("team_ptnr_id_val", team_ptnr_id_val);
    		
    		returnMap = sqlSession.selectOne("MbrStatListMapper.selectMemberStatZoneByPtnr4", sqlMap);
    		
    		nTempMember = Integer.parseInt(returnMap.get("total_member_cnt").toString());
    		
    		if( nTempMember > 0 ) {
    			result4Member.add(returnMap);
    		}
    		
    	}
    	
    	model.addAttribute("result4Member", result4Member);
    	model.addAttribute("member_sum", paramMap.get("member_sum"));
    	model.addAttribute("member_2_sum", paramMap.get("member_2_sum"));
    	model.addAttribute("member_3_sum", paramMap.get("member_3_sum"));
    	model.addAttribute("member_4_sum", paramMap.get("member_4_sum"));
    	
    	return sUrl;
    }
	
	/**
	 * 1종 지역 보험사 별 심사인원수 가져오기
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/insaZoneInsu1StatTable")
    public String insaZoneInsu1StatTable(HttpServletRequest request, Model model) {
    	
    	logger.info("========= insaZoneInsu1StatTable =========");    	    	

    	String sUrl = "top_team/top_insa_stat_1_table";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	//CommonUtils.printMap(paramMap);    	
    	
    	//팀 보험사 지정용 보험사 목록 가져오기(통계 보험사 목록과 동일)
    	List<Map<String, Object>> teamPtnrList = sqlSession.selectList("MisPtnrBsc.selectTeamPtnrList");
    	
    	String team_zone = String.valueOf(paramMap.get("team_zone"));
    	String team_ptnr_id = "";
    	String team_ptnr_id_val = "";
    	int nTempMember = 0;
    	
    	List<Map<String, Object>> result1Member = new ArrayList<>(); 
    	
    	for( int i=0; i < teamPtnrList.size(); i++ ) {
    		
    		Map<String, Object> sqlMap = new HashMap<>();
    		Map<String, Object> returnMap = new HashMap<>();
    		
    		team_ptnr_id = String.valueOf(teamPtnrList.get(i).get("ptnr_id"));
    		team_ptnr_id_val = String.valueOf(teamPtnrList.get(i).get("ptnr_nick"));
    		
    		sqlMap.put("team_zone", team_zone);
    		sqlMap.put("team_ptnr_id", team_ptnr_id);
    		sqlMap.put("team_ptnr_id_val", team_ptnr_id_val);
    		
    		returnMap = sqlSession.selectOne("MbrStatListMapper.selectMemberStatZoneByPtnr1", sqlMap);
    		
    		nTempMember = Integer.parseInt(returnMap.get("member_cnt").toString());
    		
    		if( nTempMember > 0 ) {
    			result1Member.add(returnMap);
    		}
    		
    	}
    	
    	model.addAttribute("result1Member", result1Member);
    	model.addAttribute("member_sum", paramMap.get("member_sum"));
    	
    	return sUrl;
    }
	
	/**
	 * 지역, 보험사별 인원 모달
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/insaMemberDetailStatModal")
    public String insaMemberDetailStatModal(HttpServletRequest request, Model model) {
    	
    	logger.info("========= insaMemberDetailStatModal =========");

    	String sUrl = "top_team/top_insa_stat_detail_modal";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String teamZoneVal = "";
    	String teamPtnrIdVal = "";
    	
    	if( "".equals(String.valueOf(paramMap.get("teamZone"))) ) {
    		teamZoneVal = "-";
    	}else {
    		teamZoneVal = sqlSession.selectOne("MbrStatListMapper.selectTeamZoneName", String.valueOf(paramMap.get("teamZone")));
    	}
    	
    	teamPtnrIdVal = sqlSession.selectOne("MbrStatListMapper.selectPtnrIdNick", String.valueOf(paramMap.get("teamPtnrId")));
    	
    	List<Map<String, Object>> memberModalList = sqlSession.selectList("MbrStatListMapper.selectWorkJobStatByType", paramMap);    	
    	
    	model.addAttribute("teamZoneVal", teamZoneVal);
    	model.addAttribute("teamPtnrIdVal", teamPtnrIdVal);
    	model.addAttribute("memberModalList", memberModalList);
    	model.addAttribute("paramMap", paramMap);
    	
    	return sUrl;
    }
	
	/**
	 * 직무별 인원목록 모달
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/insaMemberStatModal")
    public String insaMemberStatModal(HttpServletRequest request, Model model) {
    	
    	logger.info("========= insaMemberStatModal =========");
    	    	
    	//String sUrl = "top_lecture/lecture_process_modal";
    	String sUrl = "top_team/top_insa_stat_modal";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	List<Map<String, Object>> memberModalList = sqlSession.selectList("MbrStatListMapper.selectWorkJobStatByType", paramMap);    	
    	
    	model.addAttribute("memberModalList", memberModalList);
    	model.addAttribute("paramMap", paramMap);
    	
    	return sUrl;
    }
	
	/**
	 * 인사관리 현황통계 메인
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "topInsaStatMain", method = RequestMethod.GET)
	public String topInsaStatMain(Model model, HttpSession session, HttpServletRequest request) {
		logger.info("======= topInsaStatMain =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_14().equals("0") && mbrAuthVo.getMbr_pms_15().equals("0"))){
			logger.info("topInsaStatMain - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//직무별 인원 카운트
		Map<String, Object> workjobStatMap = sqlSession.selectOne("MbrStatListMapper.selectWorkJobStatCntList");		
		model.addAttribute("workjobStatMap", workjobStatMap);
		
		//지역별 인원 카운트 시작
		
		//지역별 통계 최종 List
		List<Map<String,Object>> zoneStatCalList = new ArrayList<>();
		
		String team_zone = "";
		String team_zone_val = "";
		
		//팀 지역설정용 목록 불러오기
		List<Map<String, Object>> zoneStatList = sqlSession.selectList("MbrStatListMapper.selectTeamZoneStatList");
		
		for( int i=0; i < zoneStatList.size(); i++) {
			
			Map<String, Object> sqlMap = new HashMap<>();
			Map<String, Object> returnMap = new HashMap<>();
			
			team_zone = zoneStatList.get(i).get("team_zone").toString();
			team_zone_val = zoneStatList.get(i).get("team_zone_val").toString();
			
			sqlMap.put("team_zone", team_zone);
			sqlMap.put("team_zone_val", team_zone_val);
			
			returnMap = sqlSession.selectOne("MbrStatListMapper.selectMemberStatByTeamzone", sqlMap);
			
			zoneStatCalList.add(returnMap);
			
		}
		
		model.addAttribute("zoneStatCalList", zoneStatCalList);
		
		//지역별 인원 카운트 끝
		
		//보험사별 인원 카운트 시작
		List<Map<String,Object>> ptnrStatCalList = new ArrayList<>();
		
		String team_ptnr_id = "";
		String team_ptnr_id_val = "";
		int nPtnrCnt = 0;
		
		//팀 보험사 지정용 보험사 목록 가져오기(통계 보험사 목록과 동일)
		List<Map<String, Object>> teamPtnrList = sqlSession.selectList("MisPtnrBsc.selectTeamPtnrList");
		
		for( int k=0; k < teamPtnrList.size(); k++ ) {
			
			Map<String, Object> sqlMap = new HashMap<>();
			Map<String, Object> returnMap = new HashMap<>();
			
			team_ptnr_id = teamPtnrList.get(k).get("ptnr_id").toString();
			team_ptnr_id_val = teamPtnrList.get(k).get("ptnr_nick").toString();
			
			sqlMap.put("team_ptnr_id", team_ptnr_id);
			sqlMap.put("team_ptnr_id_val", team_ptnr_id_val);
			
			returnMap = sqlSession.selectOne("MbrStatListMapper.selectMemberStatByTeamPtnrid", sqlMap);
			
			nPtnrCnt = Integer.parseInt(returnMap.get("work_job_cnt_1_2").toString())
					+ Integer.parseInt(returnMap.get("work_job_cnt_4_2").toString())
					+ Integer.parseInt(returnMap.get("work_job_cnt_4_3").toString())
					+ Integer.parseInt(returnMap.get("work_job_cnt_4_4").toString());
			
			if( nPtnrCnt > 0 ) {
				ptnrStatCalList.add(returnMap);
			}			
			
		}
		
		model.addAttribute("ptnrStatCalList", ptnrStatCalList);
		
		//보험사별 인원 카운트 끝				
		
		model.addAttribute("paramMap", paramMap);

		return "top_team/top_insa_stat_main";
		//return "top_team/mbr_stat_list";
	}
	
	@RequestMapping(value = "topMemberStateNew", method = RequestMethod.GET)
	public String topMemberStateNew(Model model, HttpSession session, HttpServletRequest request
			, String team_id, String reqPgNo, String tab, String orderFlag, String orderFlag2, String orderFlag3, String orderFlag4, String orderFlag5, String orderFlag6) {
		logger.info("======= topMemberStateNew =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_14().equals("0") && mbrAuthVo.getMbr_pms_15().equals("0"))){
			logger.info("topMemberState - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		//최초의 탭메뉴 선택시 처리
		tab = request.getParameter("tab") != null ? request.getParameter("tab") : "work";
		
		//검색에 사용될 팀목록 추출
		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
		model.addAttribute("teamList", teamList);
		
		//검색할 센터목록
    	List<Map<String, Object>> centerList = sqlSession.selectList("ItMgmtMapper.selectCenterListAll");
    	model.addAttribute("centerList",centerList);
    	
		model.addAttribute("orderFlag", orderFlag);
		model.addAttribute("tab", tab);
		model.addAttribute("team_id", team_id);

		return "top_team/mbr_stat_list_new";
	}	

	/*인사/재무 > 사원관리*/
	@RequestMapping(value = "topMemberState", method = RequestMethod.GET)
	public String topMemberState(Model model, HttpSession session, HttpServletRequest request
			, String team_id, String reqPgNo, String tab, String orderFlag, String orderFlag2, String orderFlag3, String orderFlag4, String orderFlag5, String orderFlag6) {
		logger.info("======= topMemberState =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_14().equals("0") && mbrAuthVo.getMbr_pms_15().equals("0"))){
			logger.info("topMemberState - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		if(orderFlag == null){
			orderFlag = "3";
		}
		
		model.addAttribute("orderFlagToPaging", orderFlag);
		model.addAttribute("orderFlag2", orderFlag2);
		model.addAttribute("orderFlag3", orderFlag3);
		model.addAttribute("orderFlag4", orderFlag4);
		model.addAttribute("orderFlag5", orderFlag5);
		model.addAttribute("orderFlag6", orderFlag6);
		model.addAttribute("orderFlagToPaging", orderFlag);

		HashMap<String,String> map =  new HashMap<String,String>();
		map.put("orderFlag", orderFlag);
		map.put("orderFlag2", orderFlag2);
		map.put("orderFlag3", orderFlag3);
		map.put("orderFlag4", orderFlag4);
		map.put("orderFlag5", orderFlag5);
		map.put("orderFlag6", orderFlag6);
		map.put("team_id", team_id);
		
		if(team_id != null && !team_id.equals("")){
			
			/*근무자 탭 시작*/
			List<TopMbrBscVO> workMemberList = sqlSession.selectList("MbrStatListMapper.getWorkMemberOne",map);

			/*대기자 탭 시작*/
			List<TopMbrBscVO> pendingMemberList = sqlSession.selectList("MbrStatListMapper.getPendingMemberOne",team_id);

			/*퇴사자 탭 시작*/
			List<TopMbrBscVO> retireMemberList = sqlSession.selectList("MbrStatListMapper.getRetireMemberOne",map);

			model.addAttribute("workMemberList", workMemberList);
			model.addAttribute("pendingMemberList", pendingMemberList);
			model.addAttribute("retireMemberList", retireMemberList);
			model.addAttribute("action", "fromTmState");

		}else{
			PageUtilityBasic pageUtil = new PageUtilityBasic();
			String reqPgNo1 = null, reqPgNo2 = null;
			if(tab != null){
				if(tab.equals("1")){
					reqPgNo1 = reqPgNo;
				}else if(tab.equals("3")){
					reqPgNo2 = reqPgNo;
				}
			}

			/*근무자 탭 시작*/
//			List<TopMbrBscVO> workMemberList
//				= (List<TopMbrBscVO>) pageUtil.pageBasic1(1, sqlSession, "MbrStatListMapper.getWorkMemberAll", reqPgNo1, model, "topMemberState");
			List<TopMbrBscVO> workMemberList = sqlSession.selectList("MbrStatListMapper.getWorkMemberAll",map);

			/*대기자 탭 시작*/
			List<TopMbrBscVO> pendingMemberList = sqlSession.selectList("MbrStatListMapper.getPendingMemberAll");

			/*퇴사자 탭 시작*/
			List<TopMbrBscVO> retireMemberList = sqlSession.selectList("MbrStatListMapper.getRetireMemberAll",map);

			model.addAttribute("workMemberList", workMemberList);
			model.addAttribute("pendingMemberList", pendingMemberList);
			model.addAttribute("retireMemberList", retireMemberList);
		}
		
		/*검색에 사용될 팀목록 추출*/
		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
		model.addAttribute("teamList", teamList);

		if(orderFlag.equals("1")){
			orderFlag = "2";
		}else if(orderFlag.equals("2")){
			orderFlag = "1";
		}else if(orderFlag.equals("3")){
			orderFlag = "4";
		}else if(orderFlag.equals("4")){
			orderFlag = "3";
		}
		model.addAttribute("orderFlag", orderFlag);
		model.addAttribute("tab", tab);
		model.addAttribute("team_id", team_id);

		return "top_team/mbr_stat_list";
	}
	
	@RequestMapping(value = "topMemberSearchAjax")
	public String topMemberSearchAjax(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= topMemberSearchAjax =======");
				
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);				
		
		List<TopMbrBscVO> searchMemberList = sqlSession.selectList("MbrStatListMapper.searchMemberListByCidNew", paramMap);
		
		model.addAttribute("param", paramMap);
		model.addAttribute("searchStatMemberList", searchMemberList);
		
		return "top_team/mbr_stat_list_search_ajax";
	}
	
	/*사원 검색 동작*/
	@RequestMapping(value = "topMemberSearch", method = RequestMethod.POST)
	public void topMemberSearch(String ustat, String tid, String searchStr, String gid, HttpServletResponse response) {

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		HashMap<String, String> queryMap = new HashMap<String, String>();
		queryMap.put("ustat", ustat);
		queryMap.put("tid", tid);
		queryMap.put("searchStr", searchStr);
		queryMap.put("gid", gid);

		List<TopMbrBscVO> searchMemberList = sqlSession.selectList("MbrStatListMapper.searchMemberList", queryMap);
		JSONArray arr = new JSONArray();
		for(int i=0; i < searchMemberList.size(); i++){
			TopMbrBscVO tmpvo = searchMemberList.get(i);
			JSONObject obj = new JSONObject();
			obj.put("rownum", tmpvo.getRownum());
			obj.put("user_no", tmpvo.getUser_no());
			obj.put("user_name", tmpvo.getUser_name());
			obj.put("user_id", tmpvo.getUser_id());
			obj.put("center_name", tmpvo.getCenter_name());
			obj.put("team_name", tmpvo.getTeam_name());
			obj.put("work_type", tmpvo.getWork_type());
			obj.put("work_rank", tmpvo.getWork_rank());
			obj.put("work_level", tmpvo.getWork_level());
			obj.put("user_state", tmpvo.getUser_state());
			obj.put("join_date", tmpvo.getJoin_date());
			obj.put("out_date", tmpvo.getOut_date());
			arr.add(obj);
		}
		String jsonStr = arr.toString();
		out.print(jsonStr);
		out.close();
	}//topMemberSearch
	
	/**
	 * 신규 검색 결과 다운로드
	 * @param model
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */	
	@RequestMapping(value = "excelTopMemberNew")
	public String excelTopMemberNew(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		
		logger.info("======= excelTopMemberNew =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String searchStr = String.valueOf(paramMap.get("downSearchStr"));
		String ustat = String.valueOf(paramMap.get("downUstat"));
		String tid = String.valueOf(paramMap.get("downTid"));
		String cid = String.valueOf(paramMap.get("downCid"));
		
		//엑셀다운시 탭메뉴를 기준으로 다운로드를 처리한다.
		String sTab = String.valueOf(paramMap.get("tabMenu"));				//work : 근무자명단		
		
		String fileName = "";
		String title = "";
		
		if( sTab.equals("retire") ){
			fileName = "퇴사자명부.xls";
			title = "퇴사자 명부";
			ustat = "1";
			paramMap.put("outOrder", "ASC");
		}else if( sTab.equals("work") ){
			fileName = "근무자명부.xls";
			title = "근무자 명부";	
			ustat = "0";
		}else if( sTab.equals("standby") ){
			fileName = "발령대기자명부.xls";
			title = "발령대기자명부";
			ustat = "2";
		}else{
			fileName = "검색결과명부.xls";
			title = "검색결과명부";
		}
		
		paramMap.put("searchStr", searchStr);
		paramMap.put("ustat", ustat);
		paramMap.put("tid", tid);
		paramMap.put("cid", cid);
		
		List<TopMbrBscVO> memberList = sqlSession.selectList("MbrStatListMapper.searchMemberListByCidNewExcel", paramMap);
		
		Date dateToday = new Date();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");//오늘날자구하기
		
		String today = df.format(dateToday);
		
		try {
			fileName = java.net.URLEncoder.encode(fileName,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("memberList",memberList);
		model.addAttribute("memberListCnt",memberList.size());
		model.addAttribute("today",today);
		model.addAttribute("title",title);
		
		response.setHeader("Content-Disposition", "attachment;filename="+fileName);
		response.setHeader("Content-Type", "application/vnd.ms-xls");
		response.setHeader("Content-Description", "JSP Generated Data");
		response.setHeader("Content-Transfer-Encoding", "binary");
		
		return "top_team/mbr_stat_list_excel";
	}
	
	/*사원 검색 동작*/
	@RequestMapping(value = "excelTopMember", method = RequestMethod.GET)
	public String excelTopMember(Model model, HttpSession session, HttpServletRequest request, String gubun, HttpServletResponse response) {
		logger.info("======= excelTopMember =======");
		System.out.println("gubun : "+ gubun);
		List<TopMbrBscVO> memberList = sqlSession.selectList("MbrStatListMapper.topMemberListExcel",gubun);
		
		Date dateToday = new Date();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");//오늘날자구하기
		
		String today = df.format(dateToday);
		
		String fileName = "";
		String title = "";
		if( gubun.equals("out") ){
			fileName = "퇴사자명부.xls";
			title = "퇴사자 명부";
		}else if( gubun.equals("work") ){
			fileName = "근무자명부.xls";
			title = "근무자 명부";
		}else if( gubun.equals("standby") ){
			fileName = "발령대기자명부.xls";
			title = "발령대기자 명부";
		}
		
		try {
			fileName = java.net.URLEncoder.encode(fileName,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("memberList",memberList);
		model.addAttribute("memberListCnt",memberList.size());
		model.addAttribute("today",today);
		model.addAttribute("title",title);
		
		response.setHeader("Content-Disposition", "attachment;filename="+fileName);
		response.setHeader("Content-Type", "application/vnd.ms-xls");
		response.setHeader("Content-Description", "JSP Generated Data");
		response.setHeader("Content-Transfer-Encoding", "binary");
		
		return "top_team/mbr_stat_list_excel";
	}
	
	/** 
	 * 입 / 퇴사확인 엑셀다운로드
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/topStaffListNewExcel")
	public String topStaffListNewExcel(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= topStaffListNewExcel =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		

		List<Map<String, Object>> memberList = sqlSession.selectList("ItMgmtMapper.selectStaffMemberList", paramMap);
		
		model.addAttribute("memberList", memberList);
		model.addAttribute("srchArg",paramMap);		
		
		return "top_team/staff_list_new_excel";
	}
	
	/**
	 * 신규 입/퇴사 확인 목록 Ajax
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getTopStaffListNewAjax")
	public String getTopStaffListNewAjax(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= getTopStaffListNewAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		

		List<Map<String, Object>> memberList = sqlSession.selectList("ItMgmtMapper.selectStaffMemberList", paramMap);
		
		model.addAttribute("memberList", memberList);
		model.addAttribute("srchArg",paramMap);		
		
		return "top_team/staff_list_new_ajax";
	}
	
	/**
	 * 신규 입/퇴사 확인 목록
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "topStaffListNew")
	public String topStaffListNew(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= topStaffListNew =======");

        //===============================================
        //	권한체크
        //===============================================

        TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();

        if ("0".equals(mbrAuthVo.getMbr_pms_7())){
            return "redirect:/";
        }
		
        //검색용 팀 목록
        List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
        model.addAttribute("teamList", teamList);
        
		return "top_team/staff_list_new";		
	}
	
	
	 
	  
	/*
	 * 재무 - 입/퇴사 확인 
	 * 180705. by lds
	 */
	@RequestMapping(value = "topStaffList")
	public String topStaffList(Model model, HttpSession session, HttpServletRequest request) {
		logger.info("======= topStaffList =======");

        //===============================================
        //	권한체크
        //===============================================
        //TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
        TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();

        if ("0".equals(mbrAuthVo.getMbr_pms_7())){
            return "redirect:/";
        }
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        if (null == paramMap.get("staffState")){
        	 paramMap.put("staffState","0");
        }
        
        if (null == paramMap.get("teamId")){
       	 	paramMap.put("teamId ","0");
        }
       
        //직원 SELECT
        List<TopMbrBscVO> staffList = sqlSession.selectList("MbrStatListMapper.selectStaffList",paramMap);
        
        
        //검색용 팀 목록
        List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
        model.addAttribute("teamList", teamList);
        
		model.addAttribute("staffList",staffList);
		model.addAttribute("srchArg",paramMap);

		return "top_team/staff_list"; 
	}
	
	/*
	 * 재무 - 입/퇴사 확인 
	 * 180705. by lds
	 */
	@RequestMapping(value = "topStaffDetail")
	public String topStaffDetail(Model model, HttpSession session, HttpServletRequest request) {
		logger.info("======= topStaffList =======");

        //===============================================
        //	권한체크
        //===============================================
        //TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
        TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();

        if ("0".equals(mbrAuthVo.getMbr_pms_7())){
            return "redirect:/";
        }
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
       
        String userNo = String.valueOf(paramMap.get("user_no"));

		TopMbrBscVO memberVo = sqlSession.selectOne("TopMbrDtlMapper.mbrinfo", paramMap.get("user_no"));
		TopMbrSgnVO signVo = sqlSession.selectOne("MyInfoUdtMapper.membersign",paramMap.get("user_no"));
		
		//휴직사항
		List<TopMbrWorkVO> getMbrWork = sqlSession.selectList("PopMbrAppointMapper.getMbrWork",userNo);
		
		String sDate = "";
		String old_sDate = "";
		String eDate = "";
		String old_eDate = "";
		int nInterval = 0;
		
		for(int i=0; i < getMbrWork.size(); i++) {
			sDate = getMbrWork.get(i).getWork_sdate_fmt();
			old_sDate = sDate.replaceAll("-", "");
			
			eDate = getMbrWork.get(i).getWork_edate_fmt();
			
			if(eDate == null || "".equals(eDate)){
				eDate = DateUtil.getTodayString("yyyy-MM-dd");
				old_eDate = DateUtil.getTodayString();
			}else{				
				old_eDate = eDate.replaceAll("-", "");
			}
			
			nInterval = DateUtil.getDiffDayCountNew(sDate, eDate)+1;				//신청일포함되므로 +1
			getMbrWork.get(i).setLeave_interval(String.valueOf(nInterval));						
		}
		
		GetImageBase64 imageUtil = new GetImageBase64();

		SplitPhoneNo splitPhoneNo = new SplitPhoneNo();
		
		/* 이미지 시작 */
		if( (memberVo.getPicture() != null ) ){
			if(!memberVo.getPicture().equals("")){
				
				String dbpath = "/home/hosting_users/toplac/www/ls_data/member/"+memberVo.getPicture();
				String fileType = dbpath.substring(dbpath.lastIndexOf(".")+1, dbpath.length());

				File fd = new File(dbpath);
				if (fd.exists()){
					System.out.println(fd);
					model.addAttribute("imageBase64", imageUtil.getOneImgeBase64(dbpath, fileType));
				}
			}
		}

		/*사인 시작*/
		if(signVo != null){
				
			String dbpath = "/home/hosting_users/toplac/www/ls_data/member_sign/"+signVo.getUser_no()+"/"+signVo.getUser_sign();
			String fileType = dbpath.substring(dbpath.lastIndexOf(".")+1, dbpath.length());

//			signVo.setSign_buffer(imageUtil.getOneImgeBase64(dbpath, fileType));
			model.addAttribute("signImg",dbpath);
		}
		
		model.addAttribute("memberVo",memberVo);
		model.addAttribute("workList",getMbrWork);

		return "top_team/staff_detail"; 
	}	
	
	
	
	

}//end of class
