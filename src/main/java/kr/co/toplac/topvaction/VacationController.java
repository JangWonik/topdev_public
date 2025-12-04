package kr.co.toplac.topvaction;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.toplac.cmm.service.CodeDicService;
import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.sysadm.SysAdmCodeDicVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.cmm.CalendarUtil;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.PaginationInfo;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;
import kr.co.toplac.util.cmm.WebUtil;




@Controller
public class VacationController {

private static final Logger logger = LoggerFactory.getLogger(VacationController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private CodeDicService CodeDicService;
	
	/**
	 * 사용자 휴가 사용대장 목록
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "VacationUseMyHistory")
	public String VacationUseMyHistory(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= VacationUseMyHistory(1) =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();		
		
		String userNo = mbrVo.getUser_no();			//사번		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String srchYear = StringUtil.null2blank(request.getParameter("srchYear"));
		String srchTeamId = StringUtil.null2blank(request.getParameter("srchTeamId"));
		
		String yearStr = StringUtil.null2blank(request.getParameter("year"));
		String monthStr = StringUtil.null2blank(request.getParameter("month"));
		
		//검색 대상 이름 추가.
		String srchName = request.getParameter("srchName") != null ? request.getParameter("srchName") : "";
		
		if (srchYear == "") {
			srchYear = DateUtil.getTodayString("yyyy-MM-dd").substring(0,4);			
			paramMap.put("srchYear", srchYear);			
		}
		
		String sToday = DateUtil.getTodayString("yyyy-MM-dd");
		
		paramMap.put("user_no", userNo);
		
				
		//계산해야 할 사용자 목록 SELECT
		List<VacationInfoBean> userInfoList = sqlSession.selectList("topVacationMapper.getVacationHistoryMyInfo",paramMap);
				
		//계산해야할 사용자목록으로 계산후 값을 넣어준다.
		int nUserno = 0;			//임시사번변수
		String [] temp = null;
		String afterYear = String.valueOf((Integer.parseInt(srchYear)+1));
		
		VacationUseBean useBean = new VacationUseBean();
				
		double vacationProgress = 0;		//진행율 변수
		double nVacationGoal = 0;			//목표수
		int useInterval = 0;			//연차발생일로 부터 오늘시점까지의 날짜
		double vacationPer100 = 0;			//연차사용일 / 할당수 * 100
		
		for(int i=0; i < userInfoList.size(); i++) {
			nUserno = userInfoList.get(i).getUser_no();			
			temp = getVacationPoint(nUserno,srchYear);
			//입사일 기준 연차발생시작일과 종료일을 만들어준다.
			userInfoList.get(i).setNow_join_date(srchYear+userInfoList.get(i).getJoin_date().substring(4, 10));
			userInfoList.get(i).setAfter_join_date(afterYear+userInfoList.get(i).getJoin_date().substring(4, 10));
			
			//연차 할당 및 사용일수를 넣어준다.					
			
			paramMap.put("user_no", userInfoList.get(i).getUser_no());
			paramMap.put("base_year", srchYear);
			
			//null 인경우 예외처리
			try {
				useBean = sqlSession.selectOne("topVacationMapper.vacationBaseYearUseList", paramMap);
				
				if( useBean != null ) {
					userInfoList.get(i).setAnnual_set(useBean.getAnnual_set());
					userInfoList.get(i).setAnnual_use(useBean.getAnnual_use());
					
					//연차시작일로부터 조회날짜까지의 날짜수 계산					
					//휴가 진행율 계산 시작
					useInterval = DateUtil.getDiffDayCountNew(srchYear+userInfoList.get(i).getJoin_date().substring(4, 10), sToday);					
					
					if( useInterval != 0 && useBean.getAnnual_set() != 0 ) {		//날짜와 연차가 0이 아닐경우만 계산
						
						if(useBean.getAnnual_set() > 14) {		//연차인 경우 계산
							nVacationGoal = (useInterval * useBean.getAnnual_set()) / 365;
							vacationProgress = (100 * useBean.getAnnual_use()) / nVacationGoal;							
							
						}else {					//월차인경우 별도 계산
							vacationProgress = (100 * useBean.getAnnual_use()) / useBean.getAnnual_set();
						}
						
						//절대값 진행률 추가 by top3009
						vacationPer100 = useBean.getAnnual_use() / useBean.getAnnual_set() * 100;
					}else {
						nVacationGoal = 0;
						vacationProgress = 0;
						vacationPer100 = 0;
					}
					userInfoList.get(i).setnVacationProgress(vacationProgress);
					//휴가 진행율 계산 끝					
					userInfoList.get(i).setnVacationPer100(vacationPer100);
					
				}else {
					userInfoList.get(i).setAnnual_set(0);
					userInfoList.get(i).setAnnual_use(0);
					userInfoList.get(i).setnVacationProgress(0);
					userInfoList.get(i).setnVacationPer100(0);
				}
			} catch (Exception e) {
				userInfoList.get(i).setAnnual_set(0);
				userInfoList.get(i).setAnnual_use(0);
				userInfoList.get(i).setnVacationProgress(0);
				userInfoList.get(i).setnVacationPer100(0);
			}
						
			userInfoList.get(i).setCol_1(Double.parseDouble(temp[0]));
			userInfoList.get(i).setCol_2(Double.parseDouble(temp[1]));
			userInfoList.get(i).setCol_3(Double.parseDouble(temp[2]));
			userInfoList.get(i).setCol_4(Double.parseDouble(temp[3]));
			userInfoList.get(i).setCol_5(Double.parseDouble(temp[4]));
			userInfoList.get(i).setCol_6(Double.parseDouble(temp[5]));
			userInfoList.get(i).setCol_7(Double.parseDouble(temp[6]));
			userInfoList.get(i).setCol_8(Double.parseDouble(temp[7]));
			userInfoList.get(i).setCol_9(Double.parseDouble(temp[8]));
			userInfoList.get(i).setCol_10(Double.parseDouble(temp[9]));
			userInfoList.get(i).setCol_11(Double.parseDouble(temp[10]));
			userInfoList.get(i).setCol_12(Double.parseDouble(temp[11]));
			/*
			 * System.out.println(temp[0] + " : " + temp[1] + " : " + temp[2] + " : " +
			 * temp[3] + " : " + temp[4] + " : " + temp[5] + " : " + temp[6] + " : " +
			 * temp[7] + " : " + temp[8] + " : " + temp[9] + " : " + temp[10] + " : " +
			 * temp[11]);
			 */
		}
				
		model.addAttribute("userInfoList", userInfoList);
		model.addAttribute("srchParam",paramMap);		
		model.addAttribute("srchYear", srchYear);
		model.addAttribute("srchName", srchName);
		
		return "top_mbr_vacation/vacation_use_my_history";
	}
	
	/**
	 * 신규휴가 사용대장 목록
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "VacationUseHistory")
	public String VacationUseHistory(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= VacationUseHistory(1) =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
		
		String userNo = mbrVo.getUser_no();			//사번		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String srchYear = StringUtil.null2blank(request.getParameter("srchYear"));
		String srchTeamId = StringUtil.null2blank(request.getParameter("srchTeamId"));
		
		String yearStr = StringUtil.null2blank(request.getParameter("year"));
		String monthStr = StringUtil.null2blank(request.getParameter("month"));
		
		String searchActionVal = StringUtil.null2blank(request.getParameter("searchActionVal"));
		//검색 대상 이름 추가.
		String srchName = request.getParameter("srchName") != null ? request.getParameter("srchName") : "";
		
		String sToday = DateUtil.getTodayString("yyyy-MM-dd");
		
		if (srchYear == "") {
			srchYear = sToday.substring(0, 4);
			paramMap.put("srchYear", srchYear);
			//srchYear = "2020";
		}		
		
		//선택년도의 오늘날짜로 변경
		
		//sToday = srchYear + sToday.substring(4, 10);
		
		//System.out.println("sToday="+sToday);
		//System.out.println("srchYear="+srchYear);
		
		if (srchTeamId == "") paramMap.put("srchTeamId", "0");
		
		//사용 대장 조회 권한 체크 (결재권한하고는 무관함)
		
		String sTeamList = "";
		String authLevel = "";		//결재대장 조회권한
			
		
		//1차 결재권한을 가지고 있는 팀을 가져온다.
		TopMbrAuthVO mbrVacationAuth = sqlSession.selectOne("TopLoginMapper.getVacation1Auth", userNo);
		
		if( mbrVacationAuth != null) {
			sTeamList = mbrVacationAuth.getLs_admin_vacation1();			
			
			//sql In절에 들어갈 팀 조건 string 을 만든다.
			sTeamList = WebUtil.makeInsqlString(sTeamList,"\\|");			
			authLevel = "2";		//1또는 2차 결재권한이 있는 사람				
		}else {
			authLevel = "0";			//일반사용자
		}
		
		//System.out.println("authLevel="+authLevel);
		//System.out.println("sTeamList="+sTeamList);
		
		//검색 테스트
		//System.out.println("srchYear="+srchYear+" : srchTeamId="+srchTeamId);
		
		paramMap.put("authLevel", authLevel);
		paramMap.put("team_list", sTeamList);		//권한이 있는  팀 아이디		
		paramMap.put("srchYear", srchYear);			//조회년도
		paramMap.put("srchName", srchName);			//대상자이름
		
		//검색에 사용 되는 팀 목록 SELECT
		List<TopTmBscVO> teamList = null;
		if(!"0".equals(authLevel)) {			
			teamList = sqlSession.selectList("topVacationMapper.teamListForSearchVacation",paramMap);
		}				
		
		paramMap.put("srchTeamId", srchTeamId);		//검색한 팀 아이디
		paramMap.put("user_no", userNo);		//사용자 아이디
		
		List<VacationInfoBean> userInfoList = new ArrayList<VacationInfoBean>();
		
		//계산해야 할 사용자 목록 SELECT
		if(!"".equals(searchActionVal)){
			userInfoList = sqlSession.selectList("topVacationMapper.getVacationHistoryMember",paramMap);
		}				
				
		//계산해야할 사용자목록으로 계산후 값을 넣어준다.
		int nUserno = 0;			//임시사번변수
		String [] temp = null;
		String afterYear = String.valueOf((Integer.parseInt(srchYear)+1));
		
		VacationUseBean useBean = new VacationUseBean();
				
		double vacationProgress = 0;		//진행율 변수
		double nVacationGoal = 0;			//목표수
		int useInterval = 0;			//연차발생일로 부터 오늘시점까지의 날짜
		double vacationPer100 = 0;			//연차사용일 / 할당수 * 100
		
		for(int i=0; i < userInfoList.size(); i++) {
			nUserno = userInfoList.get(i).getUser_no();			
			temp = getVacationPoint(nUserno,srchYear);
			//입사일 기준 연차발생시작일과 종료일을 만들어준다.
			userInfoList.get(i).setNow_join_date(srchYear+userInfoList.get(i).getJoin_date().substring(4, 10));
			userInfoList.get(i).setAfter_join_date(afterYear+userInfoList.get(i).getJoin_date().substring(4, 10));
			
			//연차 할당 및 사용일수를 넣어준다.					
			
			paramMap.put("user_no", userInfoList.get(i).getUser_no());
			paramMap.put("base_year", srchYear);
			
			//null 인경우 예외처리
			try {
				useBean = sqlSession.selectOne("topVacationMapper.vacationBaseYearUseList", paramMap);
				
				if( useBean != null ) {
					userInfoList.get(i).setAnnual_set(useBean.getAnnual_set());
					userInfoList.get(i).setAnnual_use(useBean.getAnnual_use());
					
					//연차시작일로부터 조회날짜까지의 날짜수 계산					
					//휴가 진행율 계산 시작
					useInterval = DateUtil.getDiffDayCountNew(srchYear+userInfoList.get(i).getJoin_date().substring(4, 10), sToday);					
					
					if( useInterval != 0 && useBean.getAnnual_set() != 0 ) {		//날짜와 연차가 0이 아닐경우만 계산
						
						if(useBean.getAnnual_set() > 14) {		//연차인 경우 계산
							nVacationGoal = (useInterval * useBean.getAnnual_set()) / 365;
							vacationProgress = (100 * useBean.getAnnual_use()) / nVacationGoal;							
							
						}else {					//월차인경우 별도 계산
							vacationProgress = (100 * useBean.getAnnual_use()) / useBean.getAnnual_set();
						}
						
						//절대값 진행률 추가 by top3009
						vacationPer100 = useBean.getAnnual_use() / useBean.getAnnual_set() * 100;
					}else {
						nVacationGoal = 0;
						vacationProgress = 0;
						vacationPer100 = 0;
					}
					userInfoList.get(i).setnVacationProgress(vacationProgress);
					//휴가 진행율 계산 끝					
					userInfoList.get(i).setnVacationPer100(vacationPer100);
					
				}else {
					userInfoList.get(i).setAnnual_set(0);
					userInfoList.get(i).setAnnual_use(0);
					userInfoList.get(i).setnVacationProgress(0);
					userInfoList.get(i).setnVacationPer100(0);
				}
			} catch (Exception e) {
				userInfoList.get(i).setAnnual_set(0);
				userInfoList.get(i).setAnnual_use(0);
				userInfoList.get(i).setnVacationProgress(0);
				userInfoList.get(i).setnVacationPer100(0);
			}
						
			userInfoList.get(i).setCol_1(Double.parseDouble(temp[0]));
			userInfoList.get(i).setCol_2(Double.parseDouble(temp[1]));
			userInfoList.get(i).setCol_3(Double.parseDouble(temp[2]));
			userInfoList.get(i).setCol_4(Double.parseDouble(temp[3]));
			userInfoList.get(i).setCol_5(Double.parseDouble(temp[4]));
			userInfoList.get(i).setCol_6(Double.parseDouble(temp[5]));
			userInfoList.get(i).setCol_7(Double.parseDouble(temp[6]));
			userInfoList.get(i).setCol_8(Double.parseDouble(temp[7]));
			userInfoList.get(i).setCol_9(Double.parseDouble(temp[8]));
			userInfoList.get(i).setCol_10(Double.parseDouble(temp[9]));
			userInfoList.get(i).setCol_11(Double.parseDouble(temp[10]));
			userInfoList.get(i).setCol_12(Double.parseDouble(temp[11]));
			/*
			 * System.out.println(temp[0] + " : " + temp[1] + " : " + temp[2] + " : " +
			 * temp[3] + " : " + temp[4] + " : " + temp[5] + " : " + temp[6] + " : " +
			 * temp[7] + " : " + temp[8] + " : " + temp[9] + " : " + temp[10] + " : " +
			 * temp[11]);
			 */
		}
				
		model.addAttribute("userInfoList", userInfoList);
		model.addAttribute("srchParam",paramMap);
		model.addAttribute("teamList", teamList);
		model.addAttribute("srchYear", srchYear);
		model.addAttribute("srchName", srchName);
		
		return "top_mbr_vacation/vacation_use_history";
	}
	
	/**
	 * 신규휴가 사용대장 목록 1,2차 결재 라인을 사용하지 않는다. 
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "VacationUseHistory_20191107")
	public String VacationUseHistoryBk(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= VacationUseHistory(1) =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
		
		String userNo = mbrVo.getUser_no();			//사번		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String srchYear = StringUtil.null2blank(request.getParameter("srchYear"));
		String srchTeamId = StringUtil.null2blank(request.getParameter("srchTeamId"));
		
		String yearStr = StringUtil.null2blank(request.getParameter("year"));
		String monthStr = StringUtil.null2blank(request.getParameter("month"));
		
		if (srchYear == "") {
			paramMap.put("srchYear", "2019");
			srchYear = "2019";
		}
		if (srchTeamId == "") paramMap.put("srchTeamId", "0");
		
		int year, month;
		if ("".equals(yearStr)){
			Calendar cal = Calendar.getInstance();
			year = cal.get(Calendar.YEAR);
			month = cal.get(Calendar.MONTH) + 1;
		}else{
			year = Integer.parseInt(yearStr);
			month = Integer.parseInt(monthStr);
		}
		
		//사용 대장 권한 체크 by oniku
		//휴가정보 전체 조회권한이 있는 사용자
		String authLevel = "";			//authLevel : 4(전체조회사용자), 3(1,2 단계 결재권한이 있는 사람), 2(2단계결재권한), 1(1단계결재권한), 0(일반사용자)		
		String showAll = mbrAuthVo.getMbr_pms_28();
		String sTeamList = "";
		
		if("1".equals(showAll)) {
			authLevel = "3";			//전체조회권한			
		}else{
			//1차 결재권한을 가지고 있는 팀을 가져온다.
			TopMbrAuthVO mbrVacationAuth = sqlSession.selectOne("TopLoginMapper.getVacationAuth", userNo);
			
			if( mbrVacationAuth != null) {				
				String sTeamList1 = mbrVacationAuth.getLs_admin_vacation1();
				String sTeamList2 = mbrVacationAuth.getLs_admin_vacation2();
				
				//sql In절에 들어갈 팀 조건 string 을 만든다.
				sTeamList1 = WebUtil.makeInsqlString(sTeamList1,"\\|");
				sTeamList2 = WebUtil.makeInsqlString(sTeamList2,"\\|");
				
				authLevel = "2";		//1또는 2차 결재권한이 있는 사람
				
				if( !"".equals(sTeamList1) && !"".equals(sTeamList2)) {
					sTeamList = sTeamList1+","+sTeamList2;					
				}else{
					if( !"".equals(sTeamList1) ){
						sTeamList = sTeamList1;						
					}
					
					if( !"".equals(sTeamList2) ){
						sTeamList = sTeamList2;						
					}
				}				
			}else{
				authLevel = "0";			//일반사용자				
			}
		}
		
		//System.out.println("authLevel="+authLevel);
		//System.out.println("sTeamList="+sTeamList);
		
		//검색 테스트
		//System.out.println("srchYear="+srchYear+" : srchTeamId="+srchTeamId);
		
		paramMap.put("authLevel", authLevel);
		paramMap.put("team_list", sTeamList);		//권한이 있는  팀 아이디		
		paramMap.put("srchYear", srchYear);			//조회년도
		//검색에 사용 되는 팀 목록 SELECT
		List<TopTmBscVO> teamList = null;
		if(!"0".equals(authLevel)) {			
			teamList = sqlSession.selectList("topVacationMapper.teamListForSearchVacation",paramMap);
		}				
		
		paramMap.put("srchTeamId", srchTeamId);		//검색한 팀 아이디
		paramMap.put("user_no", userNo);		//사용자 아이디
		
		//계산해야 할 사용자 목록 SELECT
		List<VacationInfoBean> userInfoList = sqlSession.selectList("topVacationMapper.getVacationHistoryMember",paramMap);
				
		//계산해야할 사용자목록으로 계산후 값을 넣어준다.
		int nUserno = 0;			//임시사번변수
		String [] temp = null;
		
		for(int i=0; i < userInfoList.size(); i++) {
			nUserno = userInfoList.get(i).getUser_no();
			//System.out.println("nUserno="+nUserno);
			temp = getVacationPoint(nUserno,srchYear);
			userInfoList.get(i).setCol_1(Double.parseDouble(temp[0]));
			userInfoList.get(i).setCol_2(Double.parseDouble(temp[1]));
			userInfoList.get(i).setCol_3(Double.parseDouble(temp[2]));
			userInfoList.get(i).setCol_4(Double.parseDouble(temp[3]));
			userInfoList.get(i).setCol_5(Double.parseDouble(temp[4]));
			userInfoList.get(i).setCol_6(Double.parseDouble(temp[5]));
			userInfoList.get(i).setCol_7(Double.parseDouble(temp[6]));
			userInfoList.get(i).setCol_8(Double.parseDouble(temp[7]));
			userInfoList.get(i).setCol_9(Double.parseDouble(temp[8]));
			userInfoList.get(i).setCol_10(Double.parseDouble(temp[9]));
			userInfoList.get(i).setCol_11(Double.parseDouble(temp[10]));
			userInfoList.get(i).setCol_12(Double.parseDouble(temp[11]));
			/*
			 * System.out.println(temp[0] + " : " + temp[1] + " : " + temp[2] + " : " +
			 * temp[3] + " : " + temp[4] + " : " + temp[5] + " : " + temp[6] + " : " +
			 * temp[7] + " : " + temp[8] + " : " + temp[9] + " : " + temp[10] + " : " +
			 * temp[11]);
			 */
		}
				
		model.addAttribute("userInfoList", userInfoList);
		model.addAttribute("srchParam",paramMap);
		model.addAttribute("teamList", teamList);
		model.addAttribute("srchYear", srchYear);
		
		return "top_mbr_vacation/vacation_use_history";
	}
	
	/**
	 * 휴가 사용 계산 함수
	 * @param sUserno 조회하려는 사번
	 * @param sYear 조회 년도
	 * @return 12개 배열
	 * @throws Exception
	 */
	public String [] getVacationPoint(int sUserno, String sYear) throws Exception{
		
		String[] monthCal = {"","","","","","","","","","","",""};			//12개월 합산 점수 
		
    	Map<String, Object> paramMap = new HashMap();
    	
    	String sNextYear = String.valueOf( Integer.parseInt(sYear)+1 );
    	
    	paramMap.put("user_no", sUserno); 		//조회 아이디
		paramMap.put("sYear", sYear);			//조회 년도		
		paramMap.put("sNextYear", sNextYear);			//조회 다음년도
    	
    	//1년간 합산값을 넣어준다.    	
    	List<Map<String, Object>> calList = sqlSession.selectList("topVacationMapper.getVacationMonthCal", paramMap);
    	
    	for(int i=0; i < calList.size(); i++) {
    		Map<String,Object> map = calList.get(i);
    		monthCal[0] = map.get("col_1").toString();
    		monthCal[1] = map.get("col_2").toString();
    		monthCal[2] = map.get("col_3").toString();
    		monthCal[3] = map.get("col_4").toString();
    		monthCal[4] = map.get("col_5").toString();
    		monthCal[5] = map.get("col_6").toString();
    		monthCal[6] = map.get("col_7").toString();
    		monthCal[7] = map.get("col_8").toString();
    		monthCal[8] = map.get("col_9").toString();
    		monthCal[9] = map.get("col_10").toString();
    		monthCal[10] = map.get("col_11").toString();
    		monthCal[11] = map.get("col_12").toString();
    	}    	    		
    	return monthCal;
    }

	/**
	 * 휴가 신청자의 휴가 및 사용자 정보를 가져온다.
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "getApUserVacationInfo")
	@ResponseBody
	public Map<String,Object> getApUserVacationInfo(Model model, HttpServletRequest request, HttpSession session) throws Exception{
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String,Object> returnMap = new HashMap<>();
		
		logger.info("======= getApUserVacationInfo =======");		

		String sUser_no = request.getParameter("user_no") != null ? request.getParameter("user_no") : "";
		
		//System.out.println("sUser_no="+sUser_no);
		
		VacationUseBean userBean = sqlSession.selectOne("topVacationMapper.vacationUseListLastManager",paramMap);
		
		//System.out.println("ap_userInfo="+userBean.getUser_name()+" : "+userBean.getTeam_name());
		
		String sTeam_type = userBean.getTeam_type();
		String approvaler_01 = "";
		String approvaler_name_01 = "";
		
		//팀타입(물, 인보험 기획팀)에 따라 1차 결재자를 지정한다.
		//99991:물보험 기획팀, 99994:인보험 기획팀
		if( "4".equals(sTeam_type) ) {
			approvaler_01 = "99994";
			approvaler_name_01 = "인보험기획팀";
		}else{
			approvaler_01 = "99991";
			approvaler_name_01 = "물보험기획팀";
			//0인경우(본사)도 1종으로 넣어준다. 
			sTeam_type = "1";
		}
		
		//인사총무팀장 사번 가져오기
		List<VacationApprovalBean> approvalList3 = sqlSession.selectList("topVacationMapper.vacationLastApprovalList",paramMap);
		
		returnMap.put("ap_user_no", userBean.getUser_no());
		returnMap.put("ap_user_name", userBean.getUser_name());
		returnMap.put("ap_team_name", userBean.getTeam_name());
		returnMap.put("ap_team_id", userBean.getTeam_id());
		returnMap.put("ap_team_type", sTeam_type);
		
		returnMap.put("ap_base_year", userBean.getBase_year());		
		returnMap.put("ap_annual_set", userBean.getAnnual_set());
		returnMap.put("ap_annual_use", userBean.getAnnual_use());
		
		//소숫점 문제로 수정		
		double ap_annual_remain = userBean.getAnnual_set() - userBean.getAnnual_use();
		ap_annual_remain = Math.round(ap_annual_remain*100) / 100.0;
		returnMap.put("ap_annual_remain", ap_annual_remain);
		//returnMap.put("ap_annual_remain", userBean.getAnnual_set() - userBean.getAnnual_use());
		
		//1차 결재자정보
		returnMap.put("ap_approvaler_01", approvaler_01);		
		returnMap.put("approvaler_name_01", approvaler_name_01);
		
		//인사총무팀장 사번
		returnMap.put("ap_approvaler_03", approvalList3.get(0).getUser_no());
				
		//returnMap.put("result", "작업중");
		
		return returnMap;
	}
	
	
	/*
	*********************************************************
	* Program ID	: myLeaveMain
	* Program Name	: myLeaveMain
	* Description	: 휴직신청 내역 메인
	* Author		: 장원익
	* Date			: 2020.10.06
	*********************************************************
	*/
	@RequestMapping(value = "myLeaveMain")
	public String myLeaveMain(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= myLeaveMain =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();		
		String user_no = mbrVo.getUser_no();			//사번		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		paramMap.put("user_no", user_no);
		
		//휴직사용내역 변수
		String searchStartDate = request.getParameter("searchStartDate") != null ? request.getParameter("searchStartDate") : "";
		String searchEndDate = request.getParameter("searchEndDate") != null ? request.getParameter("searchEndDate") : "";
		
		List<LeaveCode> vCodeList = sqlSession.selectList("topVacationMapper.selectLeaveCodeList",paramMap);
		model.addAttribute("vCodeList", vCodeList);
		
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
        String pageIdx = StringUtil.null2blank((String)paramMap.get("pageIdx"));        
        
        if("".equals(pageIdx)){
            currentPage = 0;
            limitPage = 0;
        }else{
            currentPage = (Integer.parseInt(pageIdx) - 1);
            limitPage = ((Integer.parseInt(pageIdx) - 1) * sizePerPage);
        }
        paramMap.put("sizePerPage", sizePerPage);
        paramMap.put("limitPage", limitPage);        
        
		// 휴직신청내역		(작업중.)
		List<LeaveInfoBean> leaveList = sqlSession.selectList("topVacationMapper.selectLeaveInfoList",paramMap);
		
		long leaveListCnt = sqlSession.selectOne("topVacationMapper.selectLeaveInfoListCnt",paramMap);
		
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        PaginationInfo pageInfo = new PaginationInfo();			
        pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
        pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
        pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
        pageInfo.setTotalRecordCount(leaveListCnt);   				// 총 글 갯수        
        
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("leaveListCnt", leaveListCnt);
		model.addAttribute("leaveList", leaveList);
		model.addAttribute("searchStartDate", searchStartDate);
		model.addAttribute("searchEndDate", searchEndDate);
		
		return "top_mbr_leave/my_leave_main";
	}	
	
	
	/*
	*********************************************************
	* Program ID	: myVacationMainNew
	* Program Name	: myVacationMainNew
	* Description	: 휴가(1종 신규) 메인 화면
	* Author		: 장원익
	* Date			: 2019.04.26
	*********************************************************
	*/
	@RequestMapping(value = "myVacationMainNew")
	public String myVacationMainNew(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= myVacationMainMain =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();		
		String userNo = mbrVo.getUser_no();			//사번		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		//연차발생조회 년도 변수
		String sAnnualYear = request.getParameter("selectAnnualYear") != null ? request.getParameter("selectAnnualYear") : "";
		
		//휴가사용내역 변수
		String searchStartDate = request.getParameter("searchStartDate") != null ? request.getParameter("searchStartDate") : "";
		String searchEndDate = request.getParameter("searchEndDate") != null ? request.getParameter("searchEndDate") : "";
				
		VacationUseBean userBean;	
		
		paramMap.put("user_no", userNo);
		
		if( "".equals(sAnnualYear) ) {			
			userBean = sqlSession.selectOne("topVacationMapper.vacationUseListLast",paramMap);			
			sAnnualYear = String.valueOf(userBean.getBase_year());
		}else {
			sAnnualYear = paramMap.get("selectAnnualYear").toString();
		}		
		
		/* 조회시점 할당된 연차가져오기 */
		paramMap.put("base_year", sAnnualYear);
		
		VacationUseBean vacationUseList = sqlSession.selectOne("topVacationMapper.vacationBaseYearUseList",paramMap);
		
		model.addAttribute("vacation", vacationUseList);		//연차할당정보		
		
		/* 휴가사용내역 조회시작 */		
		String sJoin_date = "";		//입사일자				
		if("".equals(searchStartDate)) {			//입력값이 없으면 입사일부터 조회한다.
			sJoin_date = sqlSession.selectOne("topVacationMapper.selectUserJoinDate",paramMap);
			searchStartDate = sJoin_date;
		}
		
		if("".equals(searchEndDate)) {			//입력값이 없으면 오늘날짜로 한다.
			searchEndDate = DateUtil.getTodayString("yyyy-MM-dd");
		}		
		
		model.addAttribute("searchStartDate", searchStartDate);
		model.addAttribute("searchEndDate", searchEndDate);
				
		
		List<VacationCode> vCodeList = sqlSession.selectList("topVacationMapper.selectVacationCodeList",paramMap);		
		model.addAttribute("vCodeList", vCodeList);
		
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
        String pageIdx = StringUtil.null2blank((String)paramMap.get("pageIdx"));        
        
        if("".equals(pageIdx)){
            currentPage = 0;
            limitPage = 0;
        }else{
            currentPage = (Integer.parseInt(pageIdx) - 1);
            limitPage = ((Integer.parseInt(pageIdx) - 1) * sizePerPage);
        }
        paramMap.put("sizePerPage", sizePerPage);
        paramMap.put("limitPage", limitPage);
        paramMap.put("searchStartDate", searchStartDate);		//휴가사용내역 시작일
        paramMap.put("searchEndDate", DateUtil.addDateNew(searchEndDate, 1));		//종료일 +1일을 해준다.
        //paramMap.put("base_date", selBasedate);		
        
		// 휴가신청내역		
		List<VacationInfoBean> vacationList = sqlSession.selectList("topVacationMapper.selectVacationInfoNewList",paramMap);
		
		long vacationListCnt = sqlSession.selectOne("topVacationMapper.selectVacationInfoListNewCnt",paramMap);
		
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        PaginationInfo pageInfo = new PaginationInfo();			
        pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
        pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
        pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
        pageInfo.setTotalRecordCount(vacationListCnt);   				// 총 글 갯수        
        
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("vacationList", vacationList);
		
		model.addAttribute("selectAnnualYear", sAnnualYear);			//연차 발생내역 선택년도
		
		return "top_mbr_vacation/my_vacation_main_new";
	}
	
	/*
	*********************************************************
	* Program ID	: myVacationMain
	* Program Name	: myVacationMain
	* Description	: 휴가(신규) 메인 화면
	* Author		: 임대성
	* Date			: 2018.06.07
	*********************************************************
	*/
	@RequestMapping(value = "myVacationMain")
	public String myVacationMain(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= myVacationMain =======");
		
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String yearStr = StringUtil.null2blank(request.getParameter("year"));
		String monthStr = StringUtil.null2blank(request.getParameter("month"));
		String tabStr = StringUtil.null2blank(request.getParameter("tab"));
		
		int year, month;
        if ("".equals(yearStr)){
        	Calendar cal = Calendar.getInstance();
        	year = cal.get(Calendar.YEAR);
        	month = cal.get(Calendar.MONTH) + 1;
        }else{
        	year = Integer.parseInt(yearStr);
        	month = Integer.parseInt(monthStr);
        }
        
        if ("".equals(tabStr)){
        	paramMap.put("tab", "main");
        }
        
	    //===============================================
	    //	권한체크
	    //===============================================
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		/*
	    TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
	    */
		
        //연휴 테이블 생성
        //CalendarUtil.restDayMaker(sqlSession);
        
        // 달력 생성
		ArrayList<Map<String,Object>> dsCalendar = CalendarUtil.makeCalendar(year,month,sqlSession);
		
		
		if ("0".equals(mbrVo.getTeam_type())){
			paramMap.put("teamType", 1);
		}else{
			paramMap.put("teamType", mbrVo.getTeam_type());
		}
		paramMap.put("userNo",mbrVo.getUser_no());
		paramMap.put("teamId",mbrVo.getTeam_id_main());
		
		paramMap.put("year",year);
		paramMap.put("month",month);
		
		paramMap.put("srchYear", "99");
		paramMap.put("srchKind", "99");
		paramMap.put("srchState", "99");		
		paramMap.put("srchTeamId", "0");		
		paramMap.put("srchUserName", "");		
		 
		// 총 휴가일수
		/* 4종 요청에 따라 변경..
		Integer vacationDayCnt = sqlSession.selectOne("topVacationMapper.selectVacationDayCnt",paramMap);	//보종별
		//개인별 입력한 날짜가 없을 경우 보종별 입력일자 적용
		if (vacationDayCnt == null){
			vacationDayCnt = 15;
		}
		*/
		
		
		int vacationDayCnt = 0;
		if ("4".equals(mbrVo.getTeam_type())){
			Calendar cal = Calendar.getInstance();
			Integer joinYear = Integer.parseInt(mbrVo.getJoin_date().split("-")[0]);
			Integer joinMonth = Integer.parseInt(mbrVo.getJoin_date().split("-")[1]);
			
			vacationDayCnt = 11;
/*			if (joinYear == cal.get(Calendar.YEAR) && joinMonth > 6){*/
			if (joinYear == cal.get(Calendar.YEAR)){
				vacationDayCnt = (11 - joinMonth > 0)? 11-joinMonth : 0;
			}
		}else{
			vacationDayCnt = 999;
		}
		
		
		// 사용한 휴가일수
		//Double vacationUseCnt = sqlSession.selectOne("topVacationMapper.selectVacationUseCnt",paramMap);
		// 사용한 휴가일수 (연차만 계산)
		Double vacationUseCnt = sqlSession.selectOne("topVacationMapper.selectVacationTotalUseCnt",paramMap);		
		
		if (vacationUseCnt == null){
			vacationUseCnt = 0.0;
		}
		
		
		// 최근 휴가 신청 내역
		paramMap.put("gubun", "main");
		List<VacationVo> vacationList = sqlSession.selectList("topVacationMapper.selectVacationList",paramMap);
		
		paramMap.put("vacationDayCnt",vacationDayCnt);
		paramMap.put("vacationUseCnt",vacationUseCnt);
		
		//휴가 신청 내역 추가
		for (Map<String,Object> calendar : dsCalendar){
			int monthDay = Integer.parseInt(""+calendar.get("monthDay"));
			for(VacationVo vacation : vacationList){
				if ( calendar.get("year").equals(vacation.getYear())
					 && (vacation.getStartMonthDay() <= monthDay && monthDay <= vacation.getEndMonthDay())){
					String vacationTitle = vacation.getVacationStateValue() +"<br/>"+vacation.getVacationKindValue() +"<br/>"+  vacation.getVacationStartDate() + " ~ " +vacation.getVacationEndDate() +"<br/>"+ vacation.getVacationComment();
					calendar.put("vacationTitle", vacationTitle);
					calendar.put("vacationDay", "Y");
					break;
				}else{
					calendar.put("vacationDay", "N");
				}
			}
		}
		
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("srchParam",paramMap);
		model.addAttribute("calendar", dsCalendar);
		model.addAttribute("vacationList",vacationList);
		
		return "top_mbr_vacation/my_vacation_main";
	}
	
	
	/*
	*********************************************************
	* Program ID	: myVacationList
	* Program Name	: myVacationList
	* Description	: 나의 휴가 내역(신규) 
	* Author		: 임대성
	* Date			: 2018.06.11
	*********************************************************
	*/
	@RequestMapping(value = "myVacationList")
	public String myVacationList(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= myVacationList =======");
		
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		String srchYear = StringUtil.null2blank(request.getParameter("srchYear"));
		String srchKind = StringUtil.null2blank(request.getParameter("srchKind"));
		String srchState = StringUtil.null2blank(request.getParameter("srchState"));
		String srchUserName = StringUtil.null2blank(request.getParameter("srchUserName"));
		
		if (srchYear == "") paramMap.put("srchYear", "99");
		if (srchKind == "") paramMap.put("srchKind", "99");
		if (srchState == "") paramMap.put("srchState", "99");
		if (srchUserName == "") paramMap.put("srchUserName", "");
		
		paramMap.put("srchTeamId", 0);
	    //===============================================
	    //	권한체크
	    //===============================================
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		/*
	    TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
	    */
//		
		if ("0".equals(mbrVo.getTeam_type())){
			paramMap.put("teamType", 1);
		}else{
			paramMap.put("teamType", mbrVo.getTeam_type());
		}
	    
		
		paramMap.put("userNo",mbrVo.getUser_no());
		paramMap.put("teamId",mbrVo.getTeam_id_main());
		
        //===============================================
        // 페이지 관련 변수 선언
        //===============================================
        int sizePerPage = 20;       // 한페이지당 보여줄 글 갯수
        int sizePerBlock = 10;      // 페이지당 보여줄 블럭 갯수
        int currentPage = 0;        // 현재 페이지
        int limitPage = 0;          // sql limit

        //===============================================
        // 현재 페이지 세팅
        //===============================================
        String pageIdx = StringUtil.null2blank((String)paramMap.get("pageIdx"));
        if("".equals(pageIdx)){
            currentPage = 0;
            limitPage = 0;
        }else{
            currentPage = (Integer.parseInt(pageIdx) - 1);
            limitPage = ((Integer.parseInt(pageIdx) - 1) * sizePerPage);
        }
        paramMap.put("sizePerPage", sizePerPage);
        paramMap.put("limitPage", limitPage);
		
		paramMap.put("gubun", "list");
		List<VacationVo> vacationList = sqlSession.selectList("topVacationMapper.selectVacationList",paramMap);
		long vacationListCnt = sqlSession.selectOne("topVacationMapper.selectVacationListCnt",paramMap);
		
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        PaginationInfo pageInfo = new PaginationInfo();			
        pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
        pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
        pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
        pageInfo.setTotalRecordCount(vacationListCnt);   				// 총 글 갯수        	
        
        //===============================================
        // 뷰단 검색 옵션 세팅
        //===============================================      
		//휴가 종류 SELECT
        SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();
        codeVo.setTbl_nm("top_mbr_vacation");
        codeVo.setCol_nm("vacation_kind");
        List<SysAdmCodeDicVO> vacationKindList = CodeDicService.codeList(codeVo);
        
		//휴가 상태 SELECT
        codeVo.setTbl_nm("top_mbr_vacation");
        codeVo.setCol_nm("vacation_state");
        List<SysAdmCodeDicVO> vacationStateList = CodeDicService.codeList(codeVo);        
        
        //검색 년도 SETTING (2016년 ~ 올해 + 1년)
    	Calendar cal = Calendar.getInstance();
    	int year = cal.get(Calendar.YEAR);
    	List<Integer> yearList = new ArrayList<>();
    	for(int i=2016; i <= year+1 ;i++){
    		yearList.add(i);
    	}
        
		model.addAttribute("srchParam",paramMap);
		model.addAttribute("vacationList",vacationList);
		model.addAttribute("vacationKindList",vacationKindList);
		model.addAttribute("vacationStateList",vacationStateList);
		model.addAttribute("yearList",yearList);
		model.addAttribute("pageInfo",pageInfo);
		
		return "top_mbr_vacation/my_vacation_list";
	}
	
	/**
	 * 총 휴직 신청일수 (공휴일, 휴일 미포함)
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "countLeave")
	@ResponseBody
	public double countLeave(HttpServletRequest request, HttpSession session) throws Exception {
		double vacationCnt = 0;		//휴직신청일수
		
		logger.info("====== countLeave ======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String startDateStr = String.valueOf(paramMap.get("vacationStartDate"));		//휴가신청 시작일
		String endDateStr = String.valueOf(paramMap.get("vacationEndDate"));			//휴가신청 종료일
		
		startDateStr = startDateStr.replaceAll("-", "");
		endDateStr = endDateStr.replaceAll("-", "");
		
		paramMap.put("vacationStartDate", startDateStr);
		paramMap.put("vacationEndDate", endDateStr);		
		
		//주말제외한 근무일수
		//vacationCnt = DateUtil.getDiffDayCountNotWeekend(startDateStr,endDateStr);
		
		//절대일수
		vacationCnt = DateUtil.getDiffDayCount(startDateStr, endDateStr)+1;
		
		//System.out.println(vacationCnt + ": "+ startDateStr+" : "+endDateStr);
		
		return vacationCnt;
	}
	
	
	/**
	 * 휴가신청 시작일과 종료일을 가지고 실제 신청일자를 계산한다. (토,일, 휴무일 제외)
	 * @param request
	 * @param session
	 * @return vacationCnt (신청일자)
	 * @throws Exception
	 */
	@RequestMapping(value = "countVacation")
	@ResponseBody
	public double countVacation(HttpServletRequest request, HttpSession session) throws Exception {
		double vacationCnt = 0;		//휴가신청일수
		
		logger.info("====== countVacation ======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sUserNo = String.valueOf(paramMap.get("userNo"));							//휴가 신청자 사번
		String startDateStr = String.valueOf(paramMap.get("vacationStartDate"));		//휴가신청 시작일
		String endDateStr = String.valueOf(paramMap.get("vacationEndDate"));			//휴가신청 종료일
		String vacationCode = String.valueOf(paramMap.get("checkedVacationVal"));	//휴가코드		
		
		startDateStr = startDateStr.replaceAll("-", "");
		endDateStr = endDateStr.replaceAll("-", "");
		
		//System.out.println(startDateStr+" : "+endDateStr+" : "+vacationCode);
		
		paramMap.put("vacationStartDate", startDateStr);
		paramMap.put("vacationEndDate", endDateStr);
		
		//날짜사이 기간
		int diffDayCnt = 0;
		//공휴일
		int eventDayCnt = 0;
		
		//휴가자의 돌봄단축이 등록되어있는지 확인한다
		//List<Map<String, Object>> getMbrCare = sqlSession.selectList("PopMbrAppointMapper.getMbrCare",sUserNo);
		int nCareCnt = sqlSession.selectOne("PopMbrAppointMapper.getMbrCareCount",sUserNo);		
		
		//돌봄단축 등록값이 있으면 별도로 계산한다. 
		if( nCareCnt == 0 ) {				//돌봄단축이 없는 경우 기존과 동일
			//배우자출산은 연차와 동일하게 계산한다.(공휴일 제외)
			//출산휴가는 공휴일, 주말을 계산하지 않고 절대날짜수로 기간을 계산한다.
			if( "500".equals(vacationCode) || "600".equals(vacationCode) ) {
				diffDayCnt = DateUtil.getDiffDayCount(startDateStr,endDateStr);
				vacationCnt = diffDayCnt+1;		//신청일 포함으로 +1
			}		
			//반차의 경우 사용 휴가일수 0.5일
			else if ("200".equals(vacationCode)){			
				diffDayCnt = DateUtil.getDiffDayCountNotWeekend(startDateStr,endDateStr);
				eventDayCnt = sqlSession.selectOne("topVacationMapper.selectEventDayCnt",paramMap);
				vacationCnt = (diffDayCnt - eventDayCnt) * 0.5;
			}
			//반반차의 경우 사용 휴가일수 0.5일
			else if ("210".equals(vacationCode)){			
				diffDayCnt = DateUtil.getDiffDayCountNotWeekend(startDateStr,endDateStr);
				eventDayCnt = sqlSession.selectOne("topVacationMapper.selectEventDayCnt",paramMap);
				vacationCnt = (diffDayCnt - eventDayCnt) * 0.25;
			
			}else{						
				diffDayCnt = DateUtil.getDiffDayCountNotWeekend(startDateStr,endDateStr);
				eventDayCnt = sqlSession.selectOne("topVacationMapper.selectEventDayCnt",paramMap);			
				vacationCnt = diffDayCnt - eventDayCnt;
			}
		}else{									//돌봄단축이 등록되어있는 경우 별도 계산함수 이용			
			//출산휴가는 공휴일, 주말을 계산하지 않고 절대날짜수로 기간을 계산한다.
			if( "500".equals(vacationCode) || "600".equals(vacationCode) ) {
				diffDayCnt = DateUtil.getDiffDayCount(startDateStr,endDateStr);
				vacationCnt = diffDayCnt+1;		//신청일 포함으로 +1
			}else {
				vacationCnt = careToVacationCal( startDateStr, endDateStr, sUserNo, vacationCode );				
			}
			
		}
		
				
		return vacationCnt;
	}
	
	/**
	 * 돌봄 단축을 계산한 연차 반차 일수 계산	
	 * @param vacationStartDate
	 * @param vacationEndDate
	 * @param sUserNo
	 * @param sVacationType
	 * @return
	 */
	public double careToVacationCal(String vacationStartDate, String vacationEndDate, String sUserNo, String sVacationType ) {
		
		double returnVal = 0;
		
		List<String> dateList = DateUtil.getBetweenWorkDateToList(vacationStartDate, vacationEndDate, sqlSession);		
		
		double tempVal = 0;
	
		for( int i = 0; i < dateList.size(); i++ ) {
			Map<String, Object> chkMap = new HashMap<>();
			chkMap.put("user_no", sUserNo);
			chkMap.put("chkDate", dateList.get(i));
			tempVal = sqlSession.selectOne("topVacationMapper.calVacationToCare",chkMap);
			
			if( "200".equals(sVacationType) ) {
				returnVal = tempVal * 0.5;
				returnVal = Math.round(returnVal*100) / 100.0;
			}else if( "210".equals(sVacationType) ) {			//반반차 계산추가
				returnVal = tempVal * 0.25;
				returnVal = Math.round(returnVal*100) / 100.0;
			}else{
				returnVal += tempVal;
			}
		}
		
		return returnVal;
		
	}
	
	//신규 관리자 휴가신청 1종 취소
	@RequestMapping(value = "actionVacationManagerCancel")
	@ResponseBody
	public Map<String,Object> actionVacationManagerCancel(Model model, HttpServletRequest request, HttpSession session, MultipartFile vacationFile) throws Exception {
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String,Object> returnMap = new HashMap<>();
		
		logger.info("====== actionVacationManagerCancel ======");
		
		//String vacation_serial_no = String.valueOf(paramMap.get("serial_no"));		//휴가 신청 취소시 DB Key
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
				
		String action_manager = mbrVo.getUser_no();
		paramMap.put("action_manager", action_manager);
		
		VacationInfoBean vBean = sqlSession.selectOne("topVacationMapper.selectVacationInfoOne", paramMap);
		
		paramMap.put("user_no", vBean.getUser_no());
		paramMap.put("vacation_interval", vBean.getVacation_interval());
		
		String vacation_type = String.valueOf(vBean.getVacation_type());
				
		//휴가신청상태를 취소로 수정
		sqlSession.update("topVacationMapper.updateVacationManagerNewCancel", paramMap);		
		
		//휴가사용(신청)정보를 갱신한다.
		//연차,반차인경우는 기존 연차신청 갯수에서 빼준다. 
		if( "100".equals(vacation_type) || "200".equals(vacation_type)) {
			sqlSession.update("topVacationMapper.updateVacationUseAnnualMinus", paramMap);
			sqlSession.update("topVacationMapper.updateVacationUseVacationMinus", paramMap);
		}else {		//일반휴가인경우 총 휴가 신청 갯수에서만 빼준다.
			sqlSession.update("topVacationMapper.updateVacationUseVacationMinus", paramMap);
		}		
		
		returnMap.put("result", "0020");//취소
		
		return returnMap;
	}
	
	// 관리자 휴직취소
	@RequestMapping(value = "actionLeaveManagerCancel")
	@ResponseBody
	public Map<String,Object> actionLeaveManagerCancel(Model model, HttpServletRequest request, HttpSession session, MultipartFile vacationFile) throws Exception {
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String,Object> returnMap = new HashMap<>();
		
		logger.info("====== actionLeaveManagerCancel ======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
				
		String action_manager = mbrVo.getUser_no();
		paramMap.put("action_manager", action_manager);
		
		String leave_serial_no = String.valueOf(paramMap.get("serial_no"));		//휴가 신청 취소시 DB Key
		
		paramMap.put("serial_no", leave_serial_no);
				
		//관리자 휴직신청 취소로 변경
		sqlSession.update("topVacationMapper.updateLeaveManagerCancel", paramMap);		
		
		returnMap.put("result", "0020");//취소
		
		return returnMap;
	}
	
	//휴직 취소
	@RequestMapping(value = "actionLeaveCancel")
	@ResponseBody
	public Map<String,Object> actionLeaveCancel(Model model, HttpServletRequest request, HttpSession session, MultipartFile vacationFile) throws Exception {
		
		logger.info("====== actionLeaveCancel ======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String,Object> returnMap = new HashMap<>();
		
		String leave_serial_no = String.valueOf(paramMap.get("serial_no"));		//휴가 신청 취소시 DB Key
		
		paramMap.put("serial_no", leave_serial_no);
				
		//휴직신청 취소로 변경
		sqlSession.update("topVacationMapper.updateLeaveCancel", paramMap);		
		
		returnMap.put("result", "0020");//취소
		
		return returnMap;
	}
	
	//신규 휴가신청 1종 취소
	@RequestMapping(value = "actionVacationCancel")
	@ResponseBody
	public Map<String,Object> actionVacationCancel(Model model, HttpServletRequest request, HttpSession session, MultipartFile vacationFile) throws Exception {
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String,Object> returnMap = new HashMap<>();
		
		String vacation_serial_no = String.valueOf(paramMap.get("serial_no"));		//휴가 신청 취소시 DB Key
		String user_no = String.valueOf(paramMap.get("userNo"));
		String sDate = String.valueOf(paramMap.get("vacation_basedate"));
		String vacation_interval = String.valueOf(paramMap.get("vacationIntervalVal"));
		String vacation_type = String.valueOf(paramMap.get("vacationType"));		
		String base_date = sDate.substring(0,4)+"-01-01";
		
		/*
		 * System.out.println("키 : "+vacation_serial_no+ " 취소처리시작 ");
		 * System.out.println("사번="+user_no);
		 * System.out.println("base_date="+base_date);
		 * System.out.println("vacation_interval="+vacation_interval);
		 * System.out.println("vacation_type="+vacation_type);
		 */		 
		
		paramMap.put("base_date", base_date);
		paramMap.put("user_no", user_no);
		paramMap.put("vacation_interval", vacation_interval);		
		
		//취소하는 휴가의 등록일 기준으로 연차 증감 수정 시작 
		String sReg_date = "";		
		VacationInfoBean vacationInfo = sqlSession.selectOne("topVacationMapper.selectVacationInfoOne",paramMap);		
		sReg_date = vacationInfo.getRegdate();		
		paramMap.put("reg_date", sReg_date);
		//취소하는 휴가의 등록일 기준으로 연차 증감 수정 시작
				
		//휴가신청상태를 취소로 수정
		sqlSession.update("topVacationMapper.updateVacationNewCancel", paramMap);		
		
		//휴가사용(신청)정보를 갱신한다.
		//연차,반차인경우는 기존 연차신청 갯수에서 빼준다. 
		if( "100".equals(vacation_type) || "200".equals(vacation_type)) {
			sqlSession.update("topVacationMapper.updateVacationUseAnnualMinus", paramMap);
			sqlSession.update("topVacationMapper.updateVacationUseVacationMinus", paramMap);
		}else {		//일반휴가인경우 총 휴가 신청 갯수에서만 빼준다.
			sqlSession.update("topVacationMapper.updateVacationUseVacationMinus", paramMap);
		}		
		
		returnMap.put("result", "0020");//취소
		//returnMap.put("msg", "휴가 신청취소가 완료되었습니다.");
		
		return returnMap;
	}
	
	//신규 휴가신청 1종
	@RequestMapping(value = "actionVacationNewManager")
	@ResponseBody
	public Map<String,Object> actionVacationNewManager(Model model, HttpServletRequest request, HttpSession session, MultipartFile vacationFile) throws Exception {
				
		
		logger.info("=======actionVacationNewManager=======");
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String,Object> returnMap = new HashMap<>();
		
		String startDateStr = String.valueOf(paramMap.get("vacationStartDate"));
		String endDateStr = String.valueOf(paramMap.get("vacationEndDate"));
		String year = startDateStr.substring(0,4);
				
		String action = String.valueOf(paramMap.get("action"));
		
		String vacation_interval = String.valueOf(paramMap.get("vacationIntervalVal"));		//연차차감과 상관없는 휴가신청일 by oniku
		String vacation_kind = String.valueOf(paramMap.get("vacationKind"));					//휴가종류
		String vacation_content = String.valueOf(paramMap.get("vacationComment"));		//휴가 사유
		String base_date = year+"-01-01";							//신청기준날짜
		
		double vacationCnt = 1;
		
		//notApproval 대신 pass_approval 을 사용한다.
		String notApproval = String.valueOf(paramMap.get("notApproval"));		//휴가결재라인이 없는 경우 예외처리 변수 (0: 정상, 3: 최종결재자없음 2:2차결재자 없음, 1:1차결재자 없음)
		
		String pass_approval = String.valueOf(paramMap.get("passApproval")); 		//휴가라인 변수 (1: 최종결재로 넘어감, 0: 1차결재후 최종결재로 처리)
		String sApprovaler_01 = String.valueOf(paramMap.get("approvaler_01"));		//1차결재자(신규 결재자)
		String sApprovaler_03 = String.valueOf(paramMap.get("approvaler_03"));		//최종결재자
		
		String user_no = request.getParameter("userNo") != null ? request.getParameter("userNo") : "";
		String sTeamId = request.getParameter("teamId") != null ? request.getParameter("teamId") : "";
		String sTeam_type = request.getParameter("teamType") != null ? request.getParameter("teamType") : "";
		
		String sRemainVacationUse = "";
		
		//TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();		
		//String user_no = mbrVo.getUser_no();
		//String sTeamId = mbrVo.getTeam_id_main();
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		
		String action_manager = mbrVo.getUser_no();
		paramMap.put("action_manager", action_manager);
		
		//결제상태 설정 (3차결재자 ~ 1차결재자까지 체크해서 자기자신이거나 결재자가 null 인 경우 상위결재자로 설정한다.)
		//approval_state = 10 : 팀장승인대기(1차), 20 : 센터장승인대기(2차), 30 : 최종승인대기, 99:취소		
		
		int approval_state = 0;
		
		if("4".equals(sTeam_type)) {
			paramMap.put("sTeamtype", 4);
		}else {
			paramMap.put("sTeamtype", 1);
		}		
		
		//user_team_type 추가
		paramMap.put("user_team_type", sTeam_type);
		
		paramMap.put("user_no", user_no);
		paramMap.put("sTeamId", sTeamId);
		
		int approvalChk = 0;
		int approval_now = 0;
				
		//신규 결재 라인 작업시작			
		approvalChk = sqlSession.selectOne("topVacationMapper.vacationApprovalRealCnt3",paramMap);			

		//approval_state = 30;			//최종승인대기
		approval_state = 31;			//1단계 결재처리로 인해 바로 결재완료
		//approval_now = Integer.parseInt(sApprovaler_03);
		
		//신규 결재 라인 작업끝			
		
		paramMap.put("user_no", user_no);
		paramMap.put("user_team_id", sTeamId);
		paramMap.put("vacation_type", vacation_kind);
		paramMap.put("vacation_content", vacation_content);
		paramMap.put("approval_state", approval_state);
		paramMap.put("sdate", startDateStr);
		paramMap.put("edate", endDateStr);
		//vacation_count 추가
		paramMap.put("use_count", vacation_interval);
		paramMap.put("vacation_interval", vacation_interval);
		//paramMap.put("approvaler_now", approval_now);
		paramMap.put("base_date", base_date);
		
		//기존에 사용 또는 결재중인 휴가기간에 신청한 휴가기간이 포함되어있는지 체크한다.
		int beforeVacation = sqlSession.selectOne("topVacationMapper.selectBeforeVacationCnt",paramMap);
		
		if( beforeVacation > 0 ) {
			action = "F";			//휴가기간설정 문제로 인한 휴가 신청 불가
		}
		
		//휴가시작 일자가 입사일자보다 이전인지 체크한다. (20231123 : 김두현부장님 요청사항)
		/**
		String sJoinDate = sqlSession.selectOne("topVacationMapper.selectJoinDateFmtByUserNo", paramMap);
		
		if( DateUtil.compareDate(sJoinDate, startDateStr) < 1) {			//휴가 신청일이 입사일과 같거나 이전 인경우 에러처리
			action = "JP_ERR";
		}
		**/
				
		
		if("C".equals(action)) {		//action 이 추가인경우
			
			String orgFileName = "";
			String fileExt = "";
			String encFileName = "";
			
			if ( vacationFile != null ){		//첨부파일이 있는 경우 처리
				orgFileName = vacationFile.getOriginalFilename();							//원본 파일명
				fileExt = FilenameUtils.getExtension(orgFileName);						//파일 확장자
				encFileName = UUID.randomUUID().toString().replaceAll("-", "") +"."+fileExt;	//암호화 파일명
				
				//운영
				String fullPath = "/home" + File.separator + "hosting_users" + File.separator + "toplac"
						+ File.separator + "www" + File.separator + "ls_data" + File.separator + "vacation_new";

				//개발
				//String fullPath = "D:\\home" + File.separator + "hosting_users" + File.separator + "toplac"
						//+ File.separator + "www" + File.separator + "ls_data" + File.separator + "vacation_new";						
				
				paramMap.put("vacation_org_file", orgFileName);
				paramMap.put("vacation_enc_file", encFileName);
				
				try {
					File file = new File(fullPath,encFileName);
					if(!file.exists()){
						file.mkdirs();
					}
					vacationFile.transferTo(file);
					
				} catch (IOException e) {
					e.printStackTrace();
				}				
			}
							
				
			//휴가신청일수 추가 (연차인경우 신청시 결재전까지 저장)			
			if("100".equals(vacation_kind) || "200".equals(vacation_kind) || "210".equals(vacation_kind) ) {		//신청휴가가 연차인경우
				//sqlSession.update("topVacationMapper.updateVacationUseAnnualPlus",paramMap);
				//sqlSession.update("topVacationMapper.updateVacationUseVacationPlus",paramMap);
				//결재전 남은 연차수를 가져온다.
				sRemainVacationUse = sqlSession.selectOne("topVacationMapper.selectVacationUseRemainCountByUserNo", paramMap);
	    		paramMap.put("remain_vacation_use", sRemainVacationUse);
				
				sqlSession.update("topVacationMapper.updateVacationAnnualUsePlus", paramMap);
				sqlSession.update("topVacationMapper.updateVacationVacationUsePlus", paramMap);
			}else {
				//총 휴가신청일수만 추가
				sqlSession.update("topVacationMapper.updateVacationUseVacationPlus",paramMap);
			}
			
			
			//휴가신청 DB에 insert
			//sqlSession.insert("topVacationMapper.insertVacationInfo",paramMap);
			
			//관리자 신청시 DB insert
			paramMap.put("approvaler_03", sApprovaler_01);
			paramMap.put("approvaler_now", sApprovaler_01);
			
			if( "99991".equals(sApprovaler_01) ) {
				paramMap.put("ap_comment_03", "물보험기획팀 관리자 휴가 신청");
			}else{	//99994
				paramMap.put("ap_comment_03", "인보험기획팀 관리자 휴가 신청");
			}
						
			sqlSession.insert("topVacationMapper.insertVacationInfoManager",paramMap);
			
			//remain_vacation_use
			//top_vacation_info 의 remain_vacation_use 값 갱신 시작 (연차 신청자가 결재 대기중인 상태의 건이 있는경우 차감된 연차값으로 update
    		
    		//결재 후 남은 연차수를 가져온다.
    		sRemainVacationUse = sqlSession.selectOne("topVacationMapper.selectVacationUseRemainCountByUserNo", paramMap);
    		paramMap.put("remain_vacation_use", sRemainVacationUse);
    		
    		//결재 대기 상태인 휴가 신청건의 remain_vacation_use 값을 갱신한다.
    		sqlSession.update("topVacationMapper.updateVacationInfoRemainVacationUseByUserNo",paramMap);    		
    		//top_vacation_info 의 remain_vacation_use 값 갱신 끝
			
			returnMap.put("result", "0000");//신청
			//returnMap.put("msg", "휴가 신청이 완료되었습니다.");
			returnMap.put("vacationCnt", vacationCnt);
			
			
		}else if("F".equals(action)) {
			returnMap.put("result", "900");
		}else if("FC".equals(action)){
			returnMap.put("result", "901");
		}else if("FN".equals(action)){
			returnMap.put("result", "902");
		}else if("AP_ERR".equals(action)){
			returnMap.put("result", "999");
		}else if("JP_ERR".equals(action)) {
			returnMap.put("result", "903");
		}
		
		return returnMap;
		
	}
	
	//신규 관리자 휴직신청
	@RequestMapping(value = "actionLeaveManager")
	@ResponseBody
	public Map<String,Object> actionLeaveManager(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= actionLeaveManager =======");
				
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String,Object> returnMap = new HashMap<>();
		
		String startDateStr = String.valueOf(paramMap.get("vacationStartDate"));
		String endDateStr = String.valueOf(paramMap.get("vacationEndDate"));
		String year = startDateStr.substring(0,4);
				
		String action = String.valueOf(paramMap.get("action"));
		
		String vacation_interval = String.valueOf(paramMap.get("vacationIntervalVal"));		//근무일 기준 휴직신청일
		String leave_interval = String.valueOf(paramMap.get("leaveIntervalVal"));		//휴직신청일 (휴무일 포함된 총 신청일자)
		String leave_kind = String.valueOf(paramMap.get("leaveKind"));					//휴직 종류
		String leave_content = String.valueOf(paramMap.get("leaveComment"));		//휴직 사유

		String notApproval = String.valueOf(paramMap.get("notApproval"));		//휴가결재라인이 없는 경우 예외처리 변수 (0: 정상, 3: 최종결재자없음 2:2차결재자 없음, 1:1차결재자 없음)
		
		String pass_approval = String.valueOf(paramMap.get("passApproval")); 		//휴가라인 변수 (1: 최종결재로 넘어감, 0: 1차결재후 최종결재로 처리)
		String sApprovaler_01 = String.valueOf(paramMap.get("approvaler_01"));		//1차결재자(신규 결재자)
		String sApprovaler_03 = String.valueOf(paramMap.get("approvaler_03"));		//최종결재자
		
		String user_no = request.getParameter("userNo") != null ? request.getParameter("userNo") : "";
		String sTeamId = request.getParameter("teamId") != null ? request.getParameter("teamId") : "";
		String sTeam_type = request.getParameter("leaveTeamType") != null ? request.getParameter("leaveTeamType") : "";
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		
		String action_manager = mbrVo.getUser_no();
		paramMap.put("action_manager", action_manager);
		
		//String user_no = mbrVo.getUser_no();
		//String sTeamId = mbrVo.getTeam_id_main();
		
		//결제상태 설정 (3차결재자 ~ 1차결재자까지 체크해서 자기자신이거나 결재자가 null 인 경우 상위결재자로 설정한다.)
		//approval_state = 10 : 팀장승인대기(1차), 20 : 센터장승인대기(2차), 30 : 최종승인대기, 99:취소		
		
		int approval_state = 0;
		
		//팀타입설정 (1종 : 1, 4종 : 4)
		if("4".equals(sTeam_type)) {
			paramMap.put("sTeamtype", 4);
		}else {
			paramMap.put("sTeamtype", 1);
		}
				
		//user_team_type 추가
		paramMap.put("user_team_type", sTeam_type);
		
		paramMap.put("user_no", user_no);
		paramMap.put("sTeamId", sTeamId);
		
		int approvalChk = 0;
		int approval_now = 0;
				
		//신규 결재 라인 작업시작		
		approvalChk = sqlSession.selectOne("topVacationMapper.vacationApprovalRealCnt3",paramMap);
		
		approval_state = 30;			//최종승인대기			
		approval_now = Integer.parseInt(sApprovaler_03);
		
		
		//신규 결재 라인 작업끝		
		paramMap.put("user_team_id", sTeamId);
		paramMap.put("leave_type", leave_kind);
		paramMap.put("leave_content", leave_content);
		paramMap.put("approval_state", approval_state);
		paramMap.put("sdate", startDateStr);
		paramMap.put("edate", endDateStr);

		paramMap.put("use_count", vacation_interval);
		paramMap.put("leave_interval", leave_interval);
		paramMap.put("approvaler_now", approval_now);		
		
		//기존에 사용 또는 결재중인 휴가기간에 신청한 휴가기간이 포함되어있는지 체크한다.
		int beforeLeave = sqlSession.selectOne("topVacationMapper.selectBeforeLeaveCnt",paramMap);
		
		if( beforeLeave > 0 ) {
			action = "F";			//휴직기간설정 문제로 인한 휴가 신청 불가
		}				
		
		if("C".equals(action)) {		//action 이 추가인경우			
			//휴직신청 DB에 insert
			//sqlSession.insert("topVacationMapper.insertLeaveInfo",paramMap);
			
			//관리자 신청시 DB insert
			paramMap.put("approvaler_01", sApprovaler_01);
			
			if( "99991".equals(sApprovaler_01) ) {
				paramMap.put("ap_comment_01", "물보험기획팀 관리자 휴직 신청");
			}else{	//99994
				paramMap.put("ap_comment_01", "인보험기획팀 관리자 휴직 신청");
			}
			
			sqlSession.insert("topVacationMapper.insertLeaveInfoManager",paramMap);
			
			returnMap.put("result", "0000");//신청
		}else if("F".equals(action)) {
			returnMap.put("result", "900");
		}else if("AP_ERR".equals(action)){
			returnMap.put("result", "999");
		}
		
		return returnMap;
		
	}
	
	//신규 휴직신청
	@RequestMapping(value = "actionLeave")
	@ResponseBody
	public Map<String,Object> actionLeave(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= actionLeave =======");
				
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String,Object> returnMap = new HashMap<>();
		
		String startDateStr = String.valueOf(paramMap.get("vacationStartDate"));
		String endDateStr = String.valueOf(paramMap.get("vacationEndDate"));
		String year = startDateStr.substring(0,4);
				
		String action = String.valueOf(paramMap.get("action"));
		
		String vacation_interval = String.valueOf(paramMap.get("vacationIntervalVal"));		//근무일 기준 휴직신청일
		String leave_interval = String.valueOf(paramMap.get("leaveIntervalVal"));		//휴직신청일 (휴무일 포함된 총 신청일자)
		String leave_kind = String.valueOf(paramMap.get("leaveKind"));					//휴직 종류
		String leave_content = String.valueOf(paramMap.get("leaveComment"));		//휴직 사유

		String notApproval = String.valueOf(paramMap.get("notApproval"));		//휴가결재라인이 없는 경우 예외처리 변수 (0: 정상, 3: 최종결재자없음 2:2차결재자 없음, 1:1차결재자 없음)
		
		String pass_approval = String.valueOf(paramMap.get("passApproval")); 		//휴가라인 변수 (1: 최종결재로 넘어감, 0: 1차결재후 최종결재로 처리)
		String sApprovaler_01 = String.valueOf(paramMap.get("approvaler_01"));		//1차결재자(신규 결재자)
		String sApprovaler_03 = String.valueOf(paramMap.get("approvaler_03"));		//최종결재자
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		
		String user_no = mbrVo.getUser_no();
		String sTeamId = mbrVo.getTeam_id_main();
		
		//결제상태 설정 (3차결재자 ~ 1차결재자까지 체크해서 자기자신이거나 결재자가 null 인 경우 상위결재자로 설정한다.)
		//approval_state = 10 : 팀장승인대기(1차), 20 : 센터장승인대기(2차), 30 : 최종승인대기, 99:취소		
		
		int approval_state = 0;
		
		//팀타입설정 (1종 : 1, 4종 : 4)
		if ("0".equals(mbrVo.getTeam_type())){
			paramMap.put("sTeamtype", 1);
		}else{
			paramMap.put("sTeamtype", mbrVo.getTeam_type());
		}
		
		String sTeam_type = mbrVo.getTeam_type();
				
		//user_team_type 추가
		paramMap.put("user_team_type", sTeam_type);
		
		paramMap.put("user_no", user_no);
		paramMap.put("sTeamId", sTeamId);
		
		int approvalChk = 0;
		int approval_now = 0;
				
		//신규 결재 라인 작업시작		
		approvalChk = sqlSession.selectOne("topVacationMapper.vacationApprovalRealCnt3",paramMap);
		
		//if( approvalChk > 0) {		//자기자신이 최종결재자인 상태
		if("966".equals(user_no)) {			//최종결재권한이 있더라도 하명호상무님이 아니면 결재라인 타야함 (신경혜차장, 김두현부장님의 경우)
			//System.out.println("최종결재자");			
			approval_state = 31;
		}else if("1".equals(pass_approval)) {		//최종결재만 받으면 되는상태
			//System.out.println("최종결재대기");
			approval_state = 30;			//최종승인대기
			approval_now = Integer.parseInt(sApprovaler_03);
		}else{						//1차결재후 최종결재받아야하는 상태
			//System.out.println("일반결재 : "+pass_approval);
			approval_state = 10;
			approval_now = Integer.parseInt(sApprovaler_01);
		}
		
		//신규 결재 라인 작업끝
		paramMap.put("user_no", user_no);
		paramMap.put("user_team_id", sTeamId);
		paramMap.put("leave_type", leave_kind);
		paramMap.put("leave_content", leave_content);
		paramMap.put("approval_state", approval_state);
		paramMap.put("sdate", startDateStr);
		paramMap.put("edate", endDateStr);

		paramMap.put("use_count", vacation_interval);
		paramMap.put("leave_interval", leave_interval);
		paramMap.put("approvaler_now", approval_now);		
		
		//기존에 사용 또는 결재중인 휴가기간에 신청한 휴가기간이 포함되어있는지 체크한다.
		int beforeLeave = sqlSession.selectOne("topVacationMapper.selectBeforeLeaveCnt",paramMap);
		
		if( beforeLeave > 0 ) {
			action = "F";			//휴직기간설정 문제로 인한 휴가 신청 불가
		}				
		
		if("C".equals(action)) {		//action 이 추가인경우			
			//휴가신청 DB에 insert
			sqlSession.insert("topVacationMapper.insertLeaveInfo",paramMap);
			
			returnMap.put("result", "0000");//신청
		}else if("F".equals(action)) {
			returnMap.put("result", "900");
		}else if("AP_ERR".equals(action)){
			returnMap.put("result", "999");
		}
		
		return returnMap;
		
	}	
	
	
	//신규 휴가신청 1종
	@RequestMapping(value = "actionVacationNew")
	@ResponseBody
	public Map<String,Object> actionVacationNew(Model model, HttpServletRequest request, HttpSession session, MultipartFile vacationFile) throws Exception {
				
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String,Object> returnMap = new HashMap<>();
			
		String startDateStr = String.valueOf(paramMap.get("vacationStartDate"));
		String endDateStr = String.valueOf(paramMap.get("vacationEndDate"));
		String year = startDateStr.substring(0,4);
				
		String action = String.valueOf(paramMap.get("action"));
		
		String vacation_interval = String.valueOf(paramMap.get("vacationIntervalVal"));		//연차차감과 상관없는 휴가신청일 by oniku
		String vacation_kind = String.valueOf(paramMap.get("vacationKind"));					//휴가종류
		String vacation_option = String.valueOf(paramMap.get("vacationOption"));				//반차, 반반차 시작시간
		
		String vacation_content = String.valueOf(paramMap.get("vacationComment"));		//휴가 사유
		String base_date = year+"-01-01";							//신청기준날짜
		
		double vacationCnt = 1;
		
		//notApproval 대신 pass_approval 을 사용한다.
		String notApproval = String.valueOf(paramMap.get("notApproval"));		//휴가결재라인이 없는 경우 예외처리 변수 (0: 정상, 3: 최종결재자없음 2:2차결재자 없음, 1:1차결재자 없음)
		
		String pass_approval = String.valueOf(paramMap.get("passApproval")); 		//휴가라인 변수 (1: 최종결재로 넘어감, 0: 1차결재후 최종결재로 처리)
		String sApprovaler_01 = String.valueOf(paramMap.get("approvaler_01"));		//1차결재자(신규 결재자)
		String sApprovaler_03 = String.valueOf(paramMap.get("approvaler_03"));		//최종결재자
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		
		String user_no = mbrVo.getUser_no();
		String sTeamId = mbrVo.getTeam_id_main();
		
		//결제상태 설정 (3차결재자 ~ 1차결재자까지 체크해서 자기자신이거나 결재자가 null 인 경우 상위결재자로 설정한다.)
		//approval_state = 10 : 팀장승인대기(1차), 20 : 센터장승인대기(2차), 30 : 최종승인대기, 99:취소		
		
		int approval_state = 0;
		
		//팀타입설정 (1종 : 1, 4종 : 4)
		if ("0".equals(mbrVo.getTeam_type())){
			paramMap.put("sTeamtype", 1);
		}else{
			paramMap.put("sTeamtype", mbrVo.getTeam_type());
		}
		
		String sTeam_type = mbrVo.getTeam_type();
		
		
		//user_team_type 추가
		paramMap.put("user_team_type", sTeam_type);
		
		paramMap.put("user_no", user_no);
		paramMap.put("sTeamId", sTeamId);
		
		int approvalChk = 0;
		int approval_now = 0;
		
		//1단계 결재방식으로 변경시작 20251021
		//별도의 결재없이 바로 승인으로 처리 (부문장:강태화(노경훈에서 변경), 남희경, 황명숙, 남윤) : 20230804 김두현부장님 요청사항, 20250827:임성진부사장 추가
		//pass_approval : 부문장이나 상위 결재자가 없는 경우 바로 승인처리		
		
		if( "1".equals(pass_approval) || "966".equals(user_no) || "770".equals(user_no) || "360".equals(user_no) || "42".equals(user_no) || "474".equals(user_no) || "3976".equals(user_no) ) {
			approval_state = 31;
			//결재자가 본인인경우 추가 시작
			paramMap.put("approvaler_now", user_no);
			paramMap.put("approvaler_03", user_no);			
			//결재자가 본인인경우 추가 끝
			
		}else{			//1단계 결재로 변경
			approval_state = 30;
			approval_now = Integer.parseInt(sApprovaler_01);
			paramMap.put("approvaler_now", approval_now);
		}
		//1단계 결재방식으로 변경 끝 20251021
		
				
		//2단계 결재 제거시작
		/**
		//신규 결재 라인 작업시작		
		approvalChk = sqlSession.selectOne("topVacationMapper.vacationApprovalRealCnt3",paramMap);
		
		//if( approvalChk > 0) {		//자기자신이 최종결재자인 상태
		//if("966".equals(user_no)) {			//최종결재권한이 있더라도 하명호상무님이 아니면 결재라인 타야함 (신경혜차장, 김두현부장님의 경우)
		if( "966".equals(user_no) || "770".equals(user_no) || "360".equals(user_no) || "42".equals(user_no) || "474".equals(user_no) || "3976".equals(user_no) ) {			//별도의 결재없이 바로 승인으로 처리 (부문장:강태화(노경훈에서 변경), 남희경, 황명숙, 남윤) : 20230804 김두현부장님 요청사항, 20250827:임성진부사장 추가	
			//System.out.println("최종결재자");			
			approval_state = 31;
		}else if("1".equals(pass_approval)) {		//최종결재만 받으면 되는상태
			//System.out.println("최종결재대기");
			approval_state = 30;			//최종승인대기
			approval_now = Integer.parseInt(sApprovaler_03);
		}else{						//1차결재후 최종결재받아야하는 상태
			//System.out.println("일반결재 : "+pass_approval);
			approval_state = 10;
			approval_now = Integer.parseInt(sApprovaler_01);
		}
		//신규 결재 라인 작업끝
		//2단계 결재 제거 끝
		**/
		 
		
		//approvalChk = sqlSession.selectOne("topVacationMapper.vacationApprovalCnt3",paramMap);
		//approvalChk = sqlSession.selectOne("topVacationMapper.vacationApprovalRealCnt3",paramMap);
		/**
		if( approvalChk > 0 ){		
			//자신이 최종결재자인 경우 결재 라인없이 최종결재된 것으로 처리됨
			approval_state = 31;			
		}else{			
			approvalChk = sqlSession.selectOne("topVacationMapper.vacationApprovalCnt2",paramMap);
			if( approvalChk > 0 || "2".equals(notApproval) ){				
				//자신이 2차결재자인 경우 최종 승인대기로 설정한다.
				approval_state = 30;
				//현재결재자는 최종결재자
				approval_now = sqlSession.selectOne("topVacationMapper.vacationApproval3Info", paramMap);
			}else{				
				approvalChk = sqlSession.selectOne("topVacationMapper.vacationApprovalCnt1",paramMap);
				if( approvalChk > 0 || "1".equals(notApproval)) {					
					//자신이 1차결재자인 경우 2차결재 승인대기상태로 설정한다.
					approval_state = 20;
					//현재결재자는 2차결재자
					approval_now = sqlSession.selectOne("topVacationMapper.vacationApproval2Info", paramMap);
				}else{					
					//결재라인에 자신이 없는경우 1차승인대기상태로 설정한다.
					if( "0".equals(notApproval)) {
						approval_state = 10;
						//현재결재자는 1차결재자
						approval_now = sqlSession.selectOne("topVacationMapper.vacationApproval1Info", paramMap);
					}else{			//최종결재자도 아니면서 최종결재자 정보 또한 없는경우						
						action = "AP_ERR";
					}					
				}
			}
		}
		**/

		
		/*
		 * System.out.println("#########################");
		 * System.out.println("user_no="+user_no);
		 * System.out.println("startDateStr="+startDateStr);
		 * System.out.println("endDateStr="+endDateStr);
		 * System.out.println("vacation_interval="+vacation_interval);
		 * System.out.println("approval_state="+approval_state);
		 * System.out.println("vacationKind="+vacation_kind);
		 * System.out.println("approval_now="+approval_now);
		 * System.out.println("vacation_content="+vacation_content);
		 */
		
		//if( "".equals(vacation_option) ) {
			//vacation_option = "0";
		//}
		
		paramMap.put("user_no", user_no);
		paramMap.put("user_team_id", sTeamId);
		paramMap.put("vacation_type", vacation_kind);
		paramMap.put("vacation_option", vacation_option);
		paramMap.put("vacation_content", vacation_content);
		paramMap.put("approval_state", approval_state);
		paramMap.put("sdate", startDateStr);
		paramMap.put("edate", endDateStr);
		//vacation_count 추가
		paramMap.put("use_count", vacation_interval);
		paramMap.put("vacation_interval", vacation_interval);
		//paramMap.put("approvaler_now", approval_now);
		paramMap.put("base_date", base_date);
		
		//기존에 사용 또는 결재중인 휴가기간에 신청한 휴가기간이 포함되어있는지 체크한다.
		int beforeVacation = sqlSession.selectOne("topVacationMapper.selectBeforeVacationCnt",paramMap);
		
		if( beforeVacation > 0 ) {
			action = "F";			//휴가기간설정 문제로 인한 휴가 신청 불가
		}
		
		//휴가시작 일자가 입사일자보다 이전인지 체크한다. (20231123 : 김두현부장님 요청사항)
		/**
		String sJoinDate = sqlSession.selectOne("topVacationMapper.selectJoinDateFmtByUserNo", paramMap);
		
		if( DateUtil.compareDate(sJoinDate, startDateStr) < 1) {			//휴가 신청일이 입사일과 같거나 이전 인경우 에러처리
			action = "JP_ERR";
		}	
		**/	
		
		if("C".equals(action)) {		//action 이 추가인경우
			
			String orgFileName = "";
			String fileExt = "";
			String encFileName = "";
			
			if ( vacationFile != null ){		//첨부파일이 있는 경우 처리
				orgFileName = vacationFile.getOriginalFilename();							//원본 파일명
				fileExt = FilenameUtils.getExtension(orgFileName);						//파일 확장자
				encFileName = UUID.randomUUID().toString().replaceAll("-", "") +"."+fileExt;	//암호화 파일명
				
				//운영
				String fullPath = "/home" + File.separator + "hosting_users" + File.separator + "toplac"
						+ File.separator + "www" + File.separator + "ls_data" + File.separator + "vacation_new";

				//개발
				//String fullPath = "D:\\home" + File.separator + "hosting_users" + File.separator + "toplac"
						//+ File.separator + "www" + File.separator + "ls_data" + File.separator + "vacation_new";						
				
				paramMap.put("vacation_org_file", orgFileName);
				paramMap.put("vacation_enc_file", encFileName);
				
				try {
					File file = new File(fullPath,encFileName);
					if(!file.exists()){
						file.mkdirs();
					}
					vacationFile.transferTo(file);
					
				} catch (IOException e) {
					e.printStackTrace();
				}				
			}
			
			//최종결재자가 자신인경우 바로 최종결재 처리한다.
			if(approval_state == 31) {
				
				//최종결재인경우 신청자의 신청휴가 사용일수 또는 연차사용일수를 추가한다. (210 : 반반차 추가)
				if( "100".equals(vacation_kind) || "200".equals(vacation_kind) || "210".equals(vacation_kind) ) {
					sqlSession.update("topVacationMapper.updateVacationAnnualUsePlus", paramMap);
					sqlSession.update("topVacationMapper.updateVacationVacationUsePlus", paramMap);		    		
				}else {					
					sqlSession.update("topVacationMapper.updateVacationVacationUsePlus", paramMap);		    		
				}
				
			}else{				
				
				//휴가신청일수 추가 (연차, 반차, 반반차 인경우 신청시 결재전까지 저장)			
				if("100".equals(vacation_kind) || "200".equals(vacation_kind) || "210".equals(vacation_kind) ) {		//신청휴가가 연차인경우				
					sqlSession.update("topVacationMapper.updateVacationUseAnnualPlus",paramMap);
					sqlSession.update("topVacationMapper.updateVacationUseVacationPlus",paramMap);
				}else {
					//총 휴가신청일수만 추가
					sqlSession.update("topVacationMapper.updateVacationUseVacationPlus",paramMap);
				}
			}						
			
			//휴가신청 DB에 insert
			sqlSession.insert("topVacationMapper.insertVacationInfo",paramMap);
			
			returnMap.put("result", "0000");//신청
			//returnMap.put("msg", "휴가 신청이 완료되었습니다.");
			returnMap.put("vacationCnt", vacationCnt);
			
			
		}else if("F".equals(action)) {
			returnMap.put("result", "900");
		}else if("FC".equals(action)){
			returnMap.put("result", "901");
		}else if("FN".equals(action)){
			returnMap.put("result", "902");
		}else if("AP_ERR".equals(action)){
			returnMap.put("result", "999");
		}else if("JP_ERR".equals(action)) {
			returnMap.put("result", "903");
		}
		
		return returnMap;
		
	}	
	
	//신규 휴가신청 1종 기존 3단계결재용.. 안쓴다..
	@RequestMapping(value = "actionVacationNewBk")
	@ResponseBody
	public Map<String,Object> actionVacationNewBk(Model model, HttpServletRequest request, HttpSession session, MultipartFile vacationFile) throws Exception {
				
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String,Object> returnMap = new HashMap<>();
		
		String startDateStr = String.valueOf(paramMap.get("vacationStartDate"));
		String endDateStr = String.valueOf(paramMap.get("vacationEndDate"));
		String year = startDateStr.substring(0,4);
				
		String action = String.valueOf(paramMap.get("action"));
		
		String vacation_interval = String.valueOf(paramMap.get("vacationIntervalVal"));		//연차차감과 상관없는 휴가신청일 by oniku
		String vacation_kind = String.valueOf(paramMap.get("vacationKind"));					//휴가종류
		String vacation_content = String.valueOf(paramMap.get("vacationComment"));		//휴가 사유
		String base_date = year+"-01-01";							//신청기준날짜
		
		double vacationCnt = 1;
		
		String notApproval = String.valueOf(paramMap.get("notApproval"));		//휴가결재라인이 없는 경우 예외처리 변수 (0: 정상, 3: 최종결재자없음 2:2차결재자 없음, 1:1차결재자 없음)
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		
		String user_no = mbrVo.getUser_no();
		String sTeamId = mbrVo.getTeam_id_main();
		
		//결제상태 설정 (3차결재자 ~ 1차결재자까지 체크해서 자기자신이거나 결재자가 null 인 경우 상위결재자로 설정한다.)
		//approval_state = 10 : 팀장승인대기(1차), 20 : 센터장승인대기(2차), 30 : 최종승인대기, 99:취소		
		
		int approval_state = 0;
		
		//팀타입설정 (1종 : 1, 4종 : 4)
		if ("0".equals(mbrVo.getTeam_type())){
			paramMap.put("sTeamtype", 1);
		}else{
			paramMap.put("sTeamtype", mbrVo.getTeam_type());
		}
		
		paramMap.put("user_no", user_no);
		paramMap.put("sTeamId", sTeamId);
		
		int approvalChk = 0;
		int approval_now = 0;
		
		//approvalChk = sqlSession.selectOne("topVacationMapper.vacationApprovalCnt3",paramMap);
		approvalChk = sqlSession.selectOne("topVacationMapper.vacationApprovalRealCnt3",paramMap);
		
		if( approvalChk > 0 ){		
			//자신이 최종결재자인 경우 결재 라인없이 최종결재된 것으로 처리됨
			approval_state = 31;			
		}else{			
			approvalChk = sqlSession.selectOne("topVacationMapper.vacationApprovalCnt2",paramMap);
			if( approvalChk > 0 || "2".equals(notApproval) ){				
				//자신이 2차결재자인 경우 최종 승인대기로 설정한다.
				approval_state = 30;
				//현재결재자는 최종결재자
				approval_now = sqlSession.selectOne("topVacationMapper.vacationApproval3Info", paramMap);
			}else{				
				approvalChk = sqlSession.selectOne("topVacationMapper.vacationApprovalCnt1",paramMap);
				if( approvalChk > 0 || "1".equals(notApproval)) {					
					//자신이 1차결재자인 경우 2차결재 승인대기상태로 설정한다.
					approval_state = 20;
					//현재결재자는 2차결재자
					approval_now = sqlSession.selectOne("topVacationMapper.vacationApproval2Info", paramMap);
				}else{					
					//결재라인에 자신이 없는경우 1차승인대기상태로 설정한다.
					if( "0".equals(notApproval)) {
						approval_state = 10;
						//현재결재자는 1차결재자
						approval_now = sqlSession.selectOne("topVacationMapper.vacationApproval1Info", paramMap);
					}else{			//최종결재자도 아니면서 최종결재자 정보 또한 없는경우						
						action = "AP_ERR";
					}					
				}
			}
		}

		
		/*
		 * System.out.println("#########################");
		 * System.out.println("user_no="+user_no);
		 * System.out.println("startDateStr="+startDateStr);
		 * System.out.println("endDateStr="+endDateStr);
		 * System.out.println("vacation_interval="+vacation_interval);
		 * System.out.println("approval_state="+approval_state);
		 * System.out.println("vacationKind="+vacation_kind);
		 * System.out.println("approval_now="+approval_now);
		 * System.out.println("vacation_content="+vacation_content);
		 */
		
		paramMap.put("user_no", user_no);
		paramMap.put("user_team_id", sTeamId);
		paramMap.put("vacation_type", vacation_kind);
		paramMap.put("vacation_content", vacation_content);
		paramMap.put("approval_state", approval_state);
		paramMap.put("sdate", startDateStr);
		paramMap.put("edate", endDateStr);
		paramMap.put("vacation_interval", vacation_interval);
		paramMap.put("approvaler_now", approval_now);
		paramMap.put("base_date", base_date);
		
		//기존에 사용 또는 결재중인 휴가기간에 신청한 휴가기간이 포함되어있는지 체크한다.
		int beforeVacation = sqlSession.selectOne("topVacationMapper.selectBeforeVacationCnt",paramMap);
		
		if( beforeVacation > 0 ) {
			action = "F";			//휴가기간설정 문제로 인한 휴가 신청 불가
		}
		
		//할당된 연차일수를 초과하더라도 신청할수 있도록 수정
		//연차의 경우 이미 결재 진행 중인 날짜를 포함하여 할당된 연차보다 넘어가는 경우 신청불가
		/**
		if("100".equals(vacation_kind) || "200".equals(vacation_kind)) {			
			double annualSet = 0;
			double annualUse = 0;
			double annualApply = 0;
			double apply_interval = 0;
			
			VacationUseBean vacationUseList = sqlSession.selectOne("topVacationMapper.vacationUseList", paramMap);
			if( vacationUseList == null ) {		//연차정보가 등록되어 있지 않음\
				action = "FN";		//부여된 연차정보가 없음 top_vacation_use 테이블에 정보없음				
			}else{										//연차정보가 있는경우 신청 휴가수와 비교한다.				
				annualSet = vacationUseList.getAnnual_set();			//연차할당일수
				annualUse = vacationUseList.getAnnual_use();		//사용한 연차일수
				annualApply = vacationUseList.getAnnual_apply(); 	//결재진행중인 연차일수
				apply_interval = Double.parseDouble(vacation_interval);	//신규로 신청한 연차일수
				
				double annualCal = annualSet - annualUse - annualApply - apply_interval;				
				
				if( annualCal < 0 ) {
					action = "FC";		//기존에 할당된 연차일수를 초과함 
				}				
				
			}
			
		}
		**/		
		
		if("C".equals(action)) {		//action 이 추가인경우	휴가개발 작업중 2019.05.24
			
			String orgFileName = "";
			String fileExt = "";
			String encFileName = "";
			
			if ( vacationFile != null ){		//첨부파일이 있는 경우 처리
				orgFileName = vacationFile.getOriginalFilename();							//원본 파일명
				fileExt = FilenameUtils.getExtension(orgFileName);						//파일 확장자
				encFileName = UUID.randomUUID().toString().replaceAll("-", "") +"."+fileExt;	//암호화 파일명
				
				//운영
				String fullPath = "/home" + File.separator + "hosting_users" + File.separator + "toplac"
						+ File.separator + "www" + File.separator + "ls_data" + File.separator + "vacation_new"

				//개발
				//String fullPath = "D:\\home" + File.separator + "hosting_users" + File.separator + "toplac"
						+ File.separator + "www" + File.separator + "ls_data" + File.separator + "vacation_new";						
				
				paramMap.put("vacation_org_file", orgFileName);
				paramMap.put("vacation_enc_file", encFileName);
				
				try {
					File file = new File(fullPath,encFileName);
					if(!file.exists()){
						file.mkdirs();
					}
					vacationFile.transferTo(file);
					
				} catch (IOException e) {
					e.printStackTrace();
				}				
			}
			
			//최종결재자가 자신인경우 바로 최종결재 처리한다.
			if(approval_state == 31) {
				
				//최종결재인경우 신청자의 신청휴가 사용일수 또는 연차사용일수를 추가한다.
				if( "100".equals(vacation_kind) || "200".equals(vacation_kind) || "210".equals(vacation_kind) ) {
					sqlSession.update("topVacationMapper.updateVacationAnnualUsePlus", paramMap);
					sqlSession.update("topVacationMapper.updateVacationVacationUsePlus", paramMap);		    		
				}else {					
					sqlSession.update("topVacationMapper.updateVacationVacationUsePlus", paramMap);		    		
				}
				
			}else{				
				
				//휴가신청일수 추가 (연차인경우 신청시 결재전까지 저장)			
				if("100".equals(vacation_kind) || "200".equals(vacation_kind) || "210".equals(vacation_kind) ) {		//신청휴가가 연차인경우				
					sqlSession.update("topVacationMapper.updateVacationUseAnnualPlus",paramMap);
					sqlSession.update("topVacationMapper.updateVacationUseVacationPlus",paramMap);
				}else {
					//총 휴가신청일수만 추가
					sqlSession.update("topVacationMapper.updateVacationUseVacationPlus",paramMap);
				}
			}
			
			//휴가신청 DB에 insert
			sqlSession.insert("topVacationMapper.insertVacationInfo",paramMap);
			
			returnMap.put("result", "0000");//신청
			//returnMap.put("msg", "휴가 신청이 완료되었습니다.");
			returnMap.put("vacationCnt", vacationCnt);
			
			
		}else if("F".equals(action)) {
			returnMap.put("result", "900");
		}else if("FC".equals(action)){
			returnMap.put("result", "901");
		}else if("FN".equals(action)){
			returnMap.put("result", "902");
		}else if("AP_ERR".equals(action)){
			returnMap.put("result", "999");
		}
		
		return returnMap;
		
	}
	
	@RequestMapping(value = "actionVacation")
	@ResponseBody
	public Map<String,Object> actionVacation(Model model, HttpServletRequest request, HttpSession session, MultipartFile vacationFile) throws Exception {
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String,Object> returnMap = new HashMap<>();
		
		String startDateStr = String.valueOf(paramMap.get("vacationStartDate"));
		String endDateStr = String.valueOf(paramMap.get("vacationEndDate"));
		String year = startDateStr.substring(0,4);
		
		String teamType = String.valueOf(paramMap.get("vacationTeamType"));
		String vacationKind = String.valueOf(paramMap.get("vacationKind"));
		String action = String.valueOf(paramMap.get("action"));
		
		double vacationRemainCnt = Double.parseDouble( (String.valueOf(paramMap.get("vacationRemainCnt"))) );
		double vacationCnt = 1;
		
		//반차의 경우 사용 휴가일수 0.5일
		if ("5".equals(vacationKind)){
			vacationCnt= 0.5;
		}else{
			//휴가 신청 년도가 다음해로 넘어갈 경우
			if ( !startDateStr.substring(0,4).equals(endDateStr.substring(0,4)) ){
				String startDate1= startDateStr;
				String endDate1= startDateStr.substring(0,4)+"1231";
				String startDate2= endDateStr.substring(0,4)+"0101";
				String endDate2= endDateStr;
				
				paramMap.put("vacationStartDate", startDate1);
				paramMap.put("vacationEndDate", endDate1);
				int diffDayCnt1 = DateUtil.getDiffDayCountNotWeekend(startDate1,endDate1);
				int eventDayCnt1 = sqlSession.selectOne("topVacationMapper.selectEventDayCnt",paramMap);
				vacationCnt = diffDayCnt1 - eventDayCnt1;
				
				paramMap.put("vacationStartDate", startDate2);
				paramMap.put("vacationEndDate", endDate2);
				int diffDayCnt2 = DateUtil.getDiffDayCountNotWeekend(startDate2,endDate2);
				int eventDayCnt2 = sqlSession.selectOne("topVacationMapper.selectEventDayCnt",paramMap);
				int vacationCnt2 = diffDayCnt2 - eventDayCnt2;
				
				paramMap.put("startDate1", startDate1);
				paramMap.put("endDate1", endDate1);
				paramMap.put("vacationCnt1", vacationCnt);
				paramMap.put("year1", year);
				
				paramMap.put("startDate2", startDate2);
				paramMap.put("endDate2", endDate2);
				paramMap.put("vacationCnt2", vacationCnt2);
				paramMap.put("year2", Integer.parseInt(year)+1);
				
			}else{
				int diffDayCnt = DateUtil.getDiffDayCountNotWeekend(startDateStr,endDateStr);
				int eventDayCnt = sqlSession.selectOne("topVacationMapper.selectEventDayCnt",paramMap);
				vacationCnt = diffDayCnt - eventDayCnt;
			}
		}

		//1차 결재자 설정
		if( !"0".equals(paramMap.get("teamManagerYn")) && !"4".equals(teamType) ){
			paramMap.put("subAprvUserNo", paramMap.get("centerManager"));
		}else{
			paramMap.put("subAprvUserNo", paramMap.get("teamManager"));
		}
		
		paramMap.put("year", year);
		paramMap.put("vacationCnt", vacationCnt);		
		
		//4종의 경우 휴가일수 초과 체크
		if ("4".equals(teamType)){
			//20191024 방승록과장 요청사항으로 초과일 수에 대해서 허용하여 휴가신청을 받음 
			
			//if (vacationRemainCnt < vacationCnt){
				//String returnMsg = "사용 가능한 휴가일수가 초과 되었습니다.\n 남은 일수 : "+vacationRemainCnt+"일, 신청 일수 : "+vacationCnt+"일";
				//returnMap.put("msg", returnMsg);
				//returnMap.put("result", "9941");//4종 휴가일수 초과
				//returnMap.put("vacationCnt", vacationCnt);
				//return returnMap;
			//}
		}
		
		if ("D".equals(action) || "FD".equals(action)){
			vacationFileDelete(paramMap);
			sqlSession.update("topVacationMapper.updateVacationFileDel",paramMap);
			returnMap.put("result", "0100"); 
		}
		
		if ("C".equals(action)){
			//1차 결재자와 신청한 사람이 같을 경우 자동으로 팀장승인 처리
			if (paramMap.get("userNo").equals(paramMap.get("subAprvUserNo"))){
				paramMap.put("vacationState", 1);
			}else{
				paramMap.put("vacationState", 0);
			}
			
			sqlSession.insert("topVacationMapper.insertVacation",paramMap);
			
			returnMap.put("result", "0000");//신청
			returnMap.put("msg", "휴가 신청이 완료되었습니다.");
			returnMap.put("vacationCnt", vacationCnt);
			
		}else if("U".equals(action)){
			sqlSession.update("topVacationMapper.updateVacation",paramMap);
			returnMap.put("result", "0010");//수정
			returnMap.put("msg", "휴가 수정이 완료되었습니다.");
			returnMap.put("vacationCnt", vacationCnt);		
			
		}else if("D".equals(action)){
			paramMap.put("vacationState", 90);
			sqlSession.update("topVacationMapper.updateVacationForCancel",paramMap);
			returnMap.put("result", "0020");//개인 취소
			returnMap.put("msg", "휴가 신청 취소가 완료되었습니다.");
			returnMap.put("vacationCnt", vacationCnt);			
		}
		
		
		
		//파일처리
		if ( vacationFile != null ){
			String orgFileName = vacationFile.getOriginalFilename();							//원본 파일명
			String fileExt = FilenameUtils.getExtension(orgFileName);						//파일 확장자
			String encFileName = UUID.randomUUID().toString().replaceAll("-", "") +"."+fileExt;	//암호화 파일명
			
			String fullPath = "/home/hosting_users/toplac/www/ls_data/vacation/"+paramMap.get("vacationNo");
			
			paramMap.put("vacationOrgFile", orgFileName);
			paramMap.put("vacationEncFile", encFileName);
			
			try {
				File file = new File(fullPath,encFileName);
				if(!file.exists()){
					file.mkdirs();
				}
				vacationFile.transferTo(file);
				sqlSession.update("topVacationMapper.updateVacationFile",paramMap);
				
			} catch (IOException e) {
				e.printStackTrace();
			} // try - catch
		}
		
		return returnMap;
		
	}
	
	/**
	 * 관리자 휴직신청 페이지 by top3009
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "leaveManager")
	public String leaveManager(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= leaveManager =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();		
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sView_type = String.valueOf(paramMap.get("view_type"));			//탭이동 파라미터		
		
		//===============================================
		// 페이지 관련 변수 선언
		//===============================================
		int sizePerPage = 20;       // 한페이지당 보여줄 글 갯수
		int sizePerBlock = 10;      // 페이지당 보여줄 블럭 갯수
		int currentPage = 0;        // 현재 페이지
		int limitPage = 0;          // sql limit

		//===============================================
		// 현재 페이지 세팅
		//===============================================
		String pageIdx = StringUtil.null2blank((String)paramMap.get("pageIdx"));
		
		if("".equals(pageIdx)){
		    currentPage = 0;
		    limitPage = 0;
		}else{
		    currentPage = (Integer.parseInt(pageIdx) - 1);
		    limitPage = ((Integer.parseInt(pageIdx) - 1) * sizePerPage);
		}
		paramMap.put("sizePerPage", sizePerPage);
		paramMap.put("limitPage", limitPage);
		
		
		PaginationInfo pageInfo = new PaginationInfo();			
		pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
		pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
		pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
		//pageInfo.setTotalRecordCount(approvalListCnt);   				// 총 글 갯수
		model.addAttribute("pageInfo", pageInfo);
		
		model.addAttribute("view_type", sView_type);

		//return "top_mbr_vacation/vacation_manager_main";
		return "top_mbr_leave/leave_manager_main";
	}
	
	/**
	 * (신규) 관리자 휴가신청 페이지 by top3009
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "vacationManager")
	public String vacationManager(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= vacationManager =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();		
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sView_type = String.valueOf(paramMap.get("view_type"));			//탭이동 파라미터		
		
		//===============================================
		// 페이지 관련 변수 선언
		//===============================================
		int sizePerPage = 20;       // 한페이지당 보여줄 글 갯수
		int sizePerBlock = 10;      // 페이지당 보여줄 블럭 갯수
		int currentPage = 0;        // 현재 페이지
		int limitPage = 0;          // sql limit

		//===============================================
		// 현재 페이지 세팅
		//===============================================
		String pageIdx = StringUtil.null2blank((String)paramMap.get("pageIdx"));
		
		if("".equals(pageIdx)){
		    currentPage = 0;
		    limitPage = 0;
		}else{
		    currentPage = (Integer.parseInt(pageIdx) - 1);
		    limitPage = ((Integer.parseInt(pageIdx) - 1) * sizePerPage);
		}
		paramMap.put("sizePerPage", sizePerPage);
		paramMap.put("limitPage", limitPage);
		
		
		PaginationInfo pageInfo = new PaginationInfo();			
		pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
		pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
		pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
		//pageInfo.setTotalRecordCount(approvalListCnt);   				// 총 글 갯수
		model.addAttribute("pageInfo", pageInfo);
		
		model.addAttribute("view_type", sView_type);

		return "top_mbr_vacation/vacation_manager_main";
	}
	
	/**
	 * 휴직 결재화면 by top3009
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "leaveApproval")
	public String leaveApproval(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= leaveApproval =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();		
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sView_type = String.valueOf(paramMap.get("view_type"));			//탭이동 파라미터		
		
		//===============================================
		// 페이지 관련 변수 선언
		//===============================================
		int sizePerPage = 20;       // 한페이지당 보여줄 글 갯수
		int sizePerBlock = 10;      // 페이지당 보여줄 블럭 갯수
		int currentPage = 0;        // 현재 페이지
		int limitPage = 0;          // sql limit

		//===============================================
		// 현재 페이지 세팅
		//===============================================
		String pageIdx = StringUtil.null2blank((String)paramMap.get("pageIdx"));
		
		if("".equals(pageIdx)){
		    currentPage = 0;
		    limitPage = 0;
		}else{
		    currentPage = (Integer.parseInt(pageIdx) - 1);
		    limitPage = ((Integer.parseInt(pageIdx) - 1) * sizePerPage);
		}
		paramMap.put("sizePerPage", sizePerPage);
		paramMap.put("limitPage", limitPage);
		
		
		String user_no = mbrVo.getUser_no();
		paramMap.put("auth_no", user_no);			//결재자 사번 셋팅		
		
		/*권한 정보 셋팅 : mbrAuthVo*/
		TopMbrAuthVO mbrAuthVo = sqlSession.selectOne("TopLoginMapper.getAuth", user_no);
		
		//최종 결재 권한을 가지고 있는 경우
		String sChk = mbrAuthVo.getMbr_pms_28_v();
		
		//휴가정보 전체 조회권한이 있는 사용자
		String showAll = mbrAuthVo.getMbr_pms_28();
		
		List<LeaveInfoBean> approvalList = null;
		int approvalListCnt = 0;		
		
		paramMap.put("user_no", user_no);			//결재자 사번 셋팅
		
		if( "1".equals(sChk) ) {			//최종결재자
			//최종 결재 대기중인 값만 가져온다.
			//approvalList = sqlSession.selectList("topVacationMapper.selectApprovalListLeaveLast", paramMap);
			//approvalListCnt = sqlSession.selectOne("topVacationMapper.selectApprovalListLeaveLastCnt", paramMap);
			
			approvalList = sqlSession.selectList("topVacationMapper.selectApprovalListLeaveTotal", paramMap);
			approvalListCnt = sqlSession.selectOne("topVacationMapper.selectApprovalListLeaveTotalCnt", paramMap);
		}else{				//1차결재자
			approvalList = sqlSession.selectList("topVacationMapper.selectApprovalListLeave", paramMap);
			approvalListCnt = sqlSession.selectOne("topVacationMapper.selectApprovalListLeaveCnt", paramMap);
		}
		
		PaginationInfo pageInfo = new PaginationInfo();			
		pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
		pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
		pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
		pageInfo.setTotalRecordCount(approvalListCnt);   				// 총 글 갯수
		model.addAttribute("pageInfo", pageInfo);
		
		model.addAttribute("approvalListCnt", approvalListCnt);		//결재해야할 건수
		model.addAttribute("approvalList", approvalList);
		model.addAttribute("showAll", showAll);
		model.addAttribute("view_type", sView_type);
		
		return "top_mbr_leave/leave_approval_main";
	}
	
	/**
	 * 휴가(1종) 신규 결재화면 by top3009
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "vacationApproval")
	public String vacationApproval(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= vacationApproval(1) =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();		
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sView_type = String.valueOf(paramMap.get("view_type"));			//탭이동 파라미터		
		
		//===============================================
		// 페이지 관련 변수 선언
		//===============================================
		int sizePerPage = 20;       // 한페이지당 보여줄 글 갯수
		int sizePerBlock = 10;      // 페이지당 보여줄 블럭 갯수
		int currentPage = 0;        // 현재 페이지
		int limitPage = 0;          // sql limit

		//===============================================
		// 현재 페이지 세팅
		//===============================================
		String pageIdx = StringUtil.null2blank((String)paramMap.get("pageIdx"));
		
		if("".equals(pageIdx)){
		    currentPage = 0;
		    limitPage = 0;
		}else{
		    currentPage = (Integer.parseInt(pageIdx) - 1);
		    limitPage = ((Integer.parseInt(pageIdx) - 1) * sizePerPage);
		}
		paramMap.put("sizePerPage", sizePerPage);
		paramMap.put("limitPage", limitPage);
		
		
		String user_no = mbrVo.getUser_no();
		paramMap.put("auth_no", user_no);			//결재자 사번 셋팅		
		
		/*권한 정보 셋팅 : mbrAuthVo*/
		TopMbrAuthVO mbrAuthVo = sqlSession.selectOne("TopLoginMapper.getAuth", user_no);
		
		//최종 결재 권한을 가지고 있는 경우
		String sChk = mbrAuthVo.getMbr_pms_28_v();
		
		//휴가정보 전체 조회권한이 있는 사용자
		String showAll = mbrAuthVo.getMbr_pms_28();
		
		List<VacationInfoBean> approvalList = null;
		int approvalListCnt = 0;
		
		paramMap.put("user_no", user_no);			//결재자 사번 셋팅
		
		/**
		if( "1".equals(sChk) ) {			//최종결재자
			//최종 결재 대기중인 값만 가져온다.
			//approvalList = sqlSession.selectList("topVacationMapper.selectApprovalListLast", paramMap);
			//approvalListCnt = sqlSession.selectOne("topVacationMapper.selectApprovalListLastCnt", paramMap);
			
			//최종 결재 대기중인 값만 가져온다. (1차결재자인경우도 합산)
			approvalList = sqlSession.selectList("topVacationMapper.selectApprovalListTotal", paramMap);			
			approvalListCnt = sqlSession.selectOne("topVacationMapper.selectApprovalListTotalCnt", paramMap);
			
		}else{				//1차결재자
			approvalList = sqlSession.selectList("topVacationMapper.selectApprovalList", paramMap);
			approvalListCnt = sqlSession.selectOne("topVacationMapper.selectApprovalListCnt", paramMap);
		}
		**/
		
		approvalList = sqlSession.selectList("topVacationMapper.selectApprovalList", paramMap);
		approvalListCnt = sqlSession.selectOne("topVacationMapper.selectApprovalListCnt", paramMap);
		
		PaginationInfo pageInfo = new PaginationInfo();			
		pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
		pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
		pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
		pageInfo.setTotalRecordCount(approvalListCnt);   				// 총 글 갯수
		model.addAttribute("pageInfo", pageInfo);
		
		//최종결재권한을 페이지로 넘겨준다.
		model.addAttribute("lastApAuth", sChk);
		model.addAttribute("approvalListCnt", approvalListCnt);		//결재해야할 건수
		model.addAttribute("approvalList", approvalList);
		model.addAttribute("showAll", showAll);
		model.addAttribute("view_type", sView_type);
		
		return "top_mbr_vacation/vacation_approval_main";
	}
	
	/**
	 * 휴가(1종) 신규 결재화면 by top3009		//3차결재라인 안쓴다..
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "vacationApprovalBk")
	public String vacationApprovalBk(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= vacationApproval(1) =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();		
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sView_type = String.valueOf(paramMap.get("view_type"));			//탭이동 파라미터				
		
		//===============================================
		// 페이지 관련 변수 선언
		//===============================================
		int sizePerPage = 20;       // 한페이지당 보여줄 글 갯수
		int sizePerBlock = 10;      // 페이지당 보여줄 블럭 갯수
		int currentPage = 0;        // 현재 페이지
		int limitPage = 0;          // sql limit

		//===============================================
		// 현재 페이지 세팅
		//===============================================
		String pageIdx = StringUtil.null2blank((String)paramMap.get("pageIdx"));
		
		if("".equals(pageIdx)){
		    currentPage = 0;
		    limitPage = 0;
		}else{
		    currentPage = (Integer.parseInt(pageIdx) - 1);
		    limitPage = ((Integer.parseInt(pageIdx) - 1) * sizePerPage);
		}
		paramMap.put("sizePerPage", sizePerPage);
		paramMap.put("limitPage", limitPage);
		
		
		String user_no = mbrVo.getUser_no();
		paramMap.put("auth_no", user_no);			//결재자 사번 셋팅
		
		//결재해야할 카운트를 가져온다.
		int approvalCnt = 0;		//전체 결재해야 할 카운트
		int approval1Cnt = 0; 		//1차 결재해야하는 카운트
		int approval2Cnt = 0;		//2차 결재해야하는 카운트
		int approval3Cnt = 0;		//최종결재해야하는 카운트

		/*권한 정보 셋팅 : mbrAuthVo*/
		TopMbrAuthVO mbrAuthVo = sqlSession.selectOne("TopLoginMapper.getAuth", user_no);
		
		//1차 결재권한을 가지고 있는 팀을 가져온다.
		TopMbrAuthVO mbrVacationAuth = sqlSession.selectOne("TopLoginMapper.getVacationAuth", user_no);
		
		List<VacationInfoBean> approvalList = null;
		int approvalListCnt = 0;
		
		if( mbrVacationAuth != null) {
			
			String sTeamList1 = mbrVacationAuth.getLs_admin_vacation1();
			String sTeamList2 = mbrVacationAuth.getLs_admin_vacation2();
			
			//sql In절에 들어갈 팀 조건 string 을 만든다.
			sTeamList1 = WebUtil.makeInsqlString(sTeamList1,"\\|");
			sTeamList2 = WebUtil.makeInsqlString(sTeamList2,"\\|");
			
			
			if( !"".equals(sTeamList1) ){
				paramMap.put("teamlist1", sTeamList1);
				//approval1Cnt = sqlSession.selectOne("topVacationMapper.selectApproval1Cnt",paramMap);
				//approvalCnt += approval1Cnt;
			}
			
			if( !"".equals(sTeamList2) ){
				paramMap.put("teamlist2", sTeamList2);
				//approval2Cnt = sqlSession.selectOne("topVacationMapper.selectApproval2Cnt",paramMap);
				//approvalCnt += approval2Cnt;
			}			
			
			approvalList = sqlSession.selectList("topVacationMapper.selectApprovalList", paramMap);
			approvalListCnt = sqlSession.selectOne("topVacationMapper.selectApprovalListCnt", paramMap);
			//System.out.println("listSize="+approvalList.size());			
			//System.out.println("sTeamList1="+sTeamList1+" : approval1Cnt="+approval1Cnt);			
			//System.out.println("sTeamList2="+sTeamList2+" : approval2Cnt="+approval2Cnt);
			//System.out.println("approvalCnt="+approvalCnt);
			
		}
		
		//3차 결재 권한을 가지고 있는 경우 (실제 결재권한)
		String sChk = mbrAuthVo.getMbr_pms_28_v();
		
		//휴가정보 전체 조회권한이 있는 사용자
		String showAll = mbrAuthVo.getMbr_pms_28();		
		
		if("1".equals(sChk)){				//1종 총괄
			approval3Cnt = sqlSession.selectOne("topVacationMapper.selectApproval3Cnt",paramMap);
			approvalCnt += approval3Cnt;
			
			//최종 결재 대기중인 값만 가져온다.
			approvalList = sqlSession.selectList("topVacationMapper.selectApprovalListLast", paramMap);
			approvalListCnt = sqlSession.selectOne("topVacationMapper.selectApprovalListLastCnt", paramMap);
		}else if("4".equals(sChk)) {		//4종 총괄 부분 수정해야함.
			approval3Cnt = sqlSession.selectOne("topVacationMapper.selectApproval3Cnt",paramMap);
			approvalCnt += approval3Cnt;
			
			//최종 결재 대기중인 값만 가져온다.
			approvalList = sqlSession.selectList("topVacationMapper.selectApprovalListLast", paramMap);
			approvalListCnt = sqlSession.selectOne("topVacationMapper.selectApprovalListLastCnt", paramMap);
		}
		
		//별도 카운트는 가져와야할때 가져오자..
		//model.addAttribute("approvalCnt", approvalCnt);
		
		PaginationInfo pageInfo = new PaginationInfo();			
		pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
		pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
		pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
		pageInfo.setTotalRecordCount(approvalListCnt);   				// 총 글 갯수
		model.addAttribute("pageInfo", pageInfo);
		
		model.addAttribute("approvalListCnt", approvalListCnt);		//결재해야할 건수
		model.addAttribute("approvalList", approvalList);
		model.addAttribute("showAll", showAll);
		model.addAttribute("view_type", sView_type);
		
		return "top_mbr_vacation/vacation_approval_main";
	}
	
	/**
	 * 연차 부여 / 사용 조회페이지
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "vacationAnnualSetAll")
	public String vacationAnnualSetAll(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= vacationAnnualSetAll(1) =======");
		
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sToday = DateUtil.getTodayString("yyyy-MM-dd");
		
		String srchAnnualYear = StringUtil.null2blank(request.getParameter("srchAnnualYear"));
		String srchAnnualTeamId = StringUtil.null2blank(request.getParameter("srchAnnualTeamId"));				
		String srchAnnualTeamType = StringUtil.null2blank(request.getParameter("srchAnnualTeamType"));
		String srchUserName = StringUtil.null2blank(request.getParameter("srchUserName"));
		String srchUserState = StringUtil.null2blank(request.getParameter("srchUserState"));		
		
		if (srchAnnualYear == "") paramMap.put("srchAnnualYear", "9999");				//연차 부여 년도 (9999:기본값을 현재사용중인 연차기준으로 설정)		
		if (srchAnnualTeamId == "") paramMap.put("srchAnnualTeamId", "0");		//팀아이디		
		if (srchAnnualTeamType == "") paramMap.put("srchAnnualTeamType", "5");			//팀구분은 (5:전체, 4:인보험, 1:물보험)
		if (srchUserName == "") paramMap.put("srchUserName", "");						//이름
		if (srchUserState == "") paramMap.put("srchUserState", "0");						//재직상태 (기본은 : 0, 전체 : 99)
		
		//===============================================
		// 페이지 관련 변수 선언
		//===============================================
		int sizePerPage = 18;       // 한페이지당 보여줄 글 갯수
		int sizePerBlock = 10;      // 페이지당 보여줄 블럭 갯수
		int currentPage = 0;        // 현재 페이지
		int limitPage = 0;          // sql limit

		//===============================================
		// 현재 페이지 세팅
		//===============================================
		String pageIdxAnnual = StringUtil.null2blank((String)paramMap.get("pageIdxAnnual"));		
		
		if("".equals(pageIdxAnnual)){
		    currentPage = 0;
		    limitPage = 0;
		}else{
		    currentPage = (Integer.parseInt(pageIdxAnnual) - 1);
		    limitPage = ((Integer.parseInt(pageIdxAnnual) - 1) * sizePerPage);
		}
		paramMap.put("sizePerPage", sizePerPage);
		paramMap.put("limitPage", limitPage);				
        
	    //===============================================
	    //	권한체크
	    //===============================================
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	    TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();

	    String workType = mbrVo.getWork_type_cd();
	    String pms28 = mbrAuthVo.getMbr_pms_28();	    
	    
	    
		if ("0".equals(mbrVo.getTeam_type())){
			paramMap.put("teamType", 1);
		}else{
			paramMap.put("teamType", mbrVo.getTeam_type());
		}
	    
	    paramMap.put("workType", workType);
	    paramMap.put("pms28", pms28);
	    
		paramMap.put("userNo",mbrVo.getUser_no());
		paramMap.put("teamId",mbrVo.getTeam_id_main());
		
		String sTeamList = "";				//팀장 센터장의 경우 사용하는 팀목록
		
		//휴가사용대장조회권한 팀목록을 가져온다.
		TopMbrAuthVO mbrVacationAuth = sqlSession.selectOne("TopLoginMapper.getVacation1Auth", mbrVo.getUser_no());
		
		//휴가 조회권한 전체(5)를 제외하고는 체크박스한 팀만 조회되도록 한다.
		if( "5".equals(pms28) ) {
			paramMap.put("srchTeamType",5);
		}else{
			if( mbrVacationAuth != null) {
				sTeamList = mbrVacationAuth.getLs_admin_vacation1();				
				//sql In절에 들어갈 팀 조건 string 을 만든다.
				sTeamList = WebUtil.makeInsqlString(sTeamList,"\\|");
			}else{			//체크박스가 없는경우는 내팀만 조회한다.
				sTeamList = mbrVo.getTeam_id_main();
			}
			
			if( "1".equals(pms28) ) {
				paramMap.put("srchTeamType",1);
			}else if( "4".equals(pms28) ) {
				paramMap.put("srchTeamType",4);
			}
		}
		//조회할 휴가내역 1,4, 전체 구분
		/*
		if( "1".equals(pms28) ) {
			paramMap.put("srchAnnualTeamType",1);
		}else if( "4".equals(pms28) ) {
			paramMap.put("srchAnnualTeamType",4);
		}else if( "5".equals(pms28)){
			paramMap.put("srchAnnualTeamType",5);
		}else{					//1,4종 조회권한이 없는 팀장 또는 센터장은 자기가 속한 팀구분값으로 넣어준다.
			srchAnnualTeamType = mbrVo.getTeam_type();
			//work_type : 팀장 (3,7), 센터장 (14,15) 의 경우로 인사권한의 체크박스 기준으로 팀목록을 가져온다. by oniku			
			//휴가사용대장조회권한 팀목록을 가져온다.
			TopMbrAuthVO mbrVacationAuth = sqlSession.selectOne("TopLoginMapper.getVacation1Auth", mbrVo.getUser_no());			
			if( mbrVacationAuth != null) {
				sTeamList = mbrVacationAuth.getLs_admin_vacation1();				
				//sql In절에 들어갈 팀 조건 string 을 만든다.
				sTeamList = WebUtil.makeInsqlString(sTeamList,"\\|");
			}else{			//체크박스가 없는경우는 내팀만 조회한다.
				sTeamList = mbrVo.getTeam_id_main();
			}			
		}
		*/
		
		paramMap.put("sTeamList", sTeamList);
				
		int vacationUseListCnt = 0;		
		
		if(!"".equals(srchAnnualTeamType)) {
			paramMap.put("srchAnnualTeamType", srchAnnualTeamType);
		}		
		
		//전체결재목록
		List<VacationUseBean> vacationUseList = sqlSession.selectList("topVacationMapper.selectAnnualSetListSearch",paramMap);
		vacationUseListCnt = sqlSession.selectOne("topVacationMapper.selectAnnualSetListSearchCnt", paramMap);
		
		String annual_start_date = "";
		String annual_end_date = "";
		double vacation_progress = 0;
		double day_progress = 0;
		
		for(int i = 0; i < vacationUseList.size(); i++) {
			annual_start_date = String.valueOf(vacationUseList.get(i).getBase_year())+vacationUseList.get(i).getJoin_date().subSequence(4, 10);
			annual_end_date = String.valueOf(vacationUseList.get(i).getBase_year()+1)+vacationUseList.get(i).getJoin_date().subSequence(4, 10);
			//사용 종기일입사일 하루 전날이다. (날짜패턴 yyyy-mm-dd)
			annual_end_date = DateUtil.addDateNew(annual_end_date, -1);
			
			if( vacationUseList.get(i).getAnnual_set() == 0 || vacationUseList.get(i).getAnnual_use() == 0 ) {
				vacation_progress = 0;
			}else {
				vacation_progress = vacationUseList.get(i).getAnnual_use() / vacationUseList.get(i).getAnnual_set() * 100;
			}
			
			//기간 경과율 계산시작
			day_progress = DateUtil.getDiffDayCountNew(annual_start_date, sToday);
			if( day_progress > 364){			//1년이상지난경우
				vacationUseList.get(i).setDay_progress(100);
			}else if( day_progress < 1 ) {
				vacationUseList.get(i).setDay_progress(0);
			}else {
				day_progress = day_progress / 365 * 100;
				vacationUseList.get(i).setDay_progress(day_progress);
			}			
			
			//기간 경과율 계산끝			
			vacationUseList.get(i).setAnnual_start_date(annual_start_date);
			vacationUseList.get(i).setAnnual_end_date(annual_end_date);
			vacationUseList.get(i).setVacation_progress(vacation_progress);
		}
				
        //===============================================
        // 뷰단 검색 옵션 세팅
        //===============================================				
    	
    	//검색에 사용 되는 팀 목록 SELECT
		paramMap.put("srchTeamType", srchAnnualTeamType);
		
		List<TopTmBscVO> teamList = sqlSession.selectList("topVacationMapper.teamListForSearch",paramMap);		
		
		PaginationInfo pageInfo = new PaginationInfo();			
		pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
		pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
		pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
		pageInfo.setTotalRecordCount(vacationUseListCnt);   				// 총 글 갯수
		model.addAttribute("pageInfo", pageInfo);
		
		model.addAttribute("srchAnnualYear", srchAnnualYear);
		model.addAttribute("srchAnnualTeamType",srchAnnualTeamType);
		model.addAttribute("srchAnnualTeamId",srchAnnualTeamId);
		model.addAttribute("srchUserName",srchUserName);
		model.addAttribute("srchUserState",srchUserState);		
		
		model.addAttribute("srchParam",paramMap);
		model.addAttribute("teamList", teamList);		
		
		model.addAttribute("vacationUseList",vacationUseList);
		
		model.addAttribute("pms28", pms28);
		
		return "top_mbr_vacation/vacation_annual_set_list";
	}
	
	/**
	 * 연차 부여 / 사용 조회 엑셀다운로드
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "vacationAnnualSetAllExcel")
	public String vacationAnnualSetAllExcel(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= vacationAnnualSetAllExcel(1) =======");
		
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sToday = DateUtil.getTodayString("yyyy-MM-dd");
		
		String srchAnnualYear = StringUtil.null2blank(request.getParameter("srchAnnualYear"));
		String srchAnnualTeamId = StringUtil.null2blank(request.getParameter("srchAnnualTeamId"));				
		String srchAnnualTeamType = StringUtil.null2blank(request.getParameter("srchAnnualTeamType"));
		String srchUserName = StringUtil.null2blank(request.getParameter("srchUserName"));
		String srchUserState = StringUtil.null2blank(request.getParameter("srchUserState"));		
		
		if (srchAnnualYear == "") paramMap.put("srchAnnualYear", "9999");				//연차 부여 년도 (9999:기본값을 현재사용중인 연차기준으로 설정)		
		if (srchAnnualTeamId == "") paramMap.put("srchAnnualTeamId", "0");		//팀아이디		
		if (srchAnnualTeamType == "") paramMap.put("srchAnnualTeamType", "5");			//팀구분은 (5:전체, 4:인보험, 1:물보험)
		if (srchUserName == "") paramMap.put("srchUserName", "");						//이름
		if (srchUserState == "") paramMap.put("srchUserState", "0");						//재직상태 (기본은 : 0, 전체 : 99)
		
		//===============================================
		// 페이지 관련 변수 선언
		//===============================================
		int sizePerPage = 18;       // 한페이지당 보여줄 글 갯수
		int sizePerBlock = 10;      // 페이지당 보여줄 블럭 갯수
		int currentPage = 0;        // 현재 페이지
		int limitPage = 0;          // sql limit

		//===============================================
		// 현재 페이지 세팅
		//===============================================
		String pageIdxAnnual = StringUtil.null2blank((String)paramMap.get("pageIdxAnnual"));		
		
		if("".equals(pageIdxAnnual)){
		    currentPage = 0;
		    limitPage = 0;
		}else{
		    currentPage = (Integer.parseInt(pageIdxAnnual) - 1);
		    limitPage = ((Integer.parseInt(pageIdxAnnual) - 1) * sizePerPage);
		}
		paramMap.put("sizePerPage", sizePerPage);
		paramMap.put("limitPage", limitPage);				
        
	    //===============================================
	    //	권한체크
	    //===============================================
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	    TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();

	    String workType = mbrVo.getWork_type_cd();
	    String pms28 = mbrAuthVo.getMbr_pms_28();	    
	    
	    
		if ("0".equals(mbrVo.getTeam_type())){
			paramMap.put("teamType", 1);
		}else{
			paramMap.put("teamType", mbrVo.getTeam_type());
		}
	    
	    paramMap.put("workType", workType);
	    paramMap.put("pms28", pms28);
	    
		paramMap.put("userNo",mbrVo.getUser_no());
		paramMap.put("teamId",mbrVo.getTeam_id_main());
		
		String sTeamList = "";				//팀장 센터장의 경우 사용하는 팀목록
		
		//조회할 휴가내역 1,4, 전체 구분
		if( "1".equals(pms28) ) {
			paramMap.put("srchAnnualTeamType",1);
		}else if( "4".equals(pms28) ) {
			paramMap.put("srchAnnualTeamType",4);
		}else if( "5".equals(pms28)){
			paramMap.put("srchAnnualTeamType",5);
		}else{					//1,4종 조회권한이 없는 팀장 또는 센터장은 자기가 속한 팀구분값으로 넣어준다.
			srchAnnualTeamType = mbrVo.getTeam_type();
			//work_type : 팀장 (3,7), 센터장 (14,15) 의 경우로 인사권한의 체크박스 기준으로 팀목록을 가져온다. by oniku			
			//휴가사용대장조회권한 팀목록을 가져온다.
			TopMbrAuthVO mbrVacationAuth = sqlSession.selectOne("TopLoginMapper.getVacation1Auth", mbrVo.getUser_no());			
			if( mbrVacationAuth != null) {
				sTeamList = mbrVacationAuth.getLs_admin_vacation1();				
				//sql In절에 들어갈 팀 조건 string 을 만든다.
				sTeamList = WebUtil.makeInsqlString(sTeamList,"\\|");
			}else{			//체크박스가 없는경우는 내팀만 조회한다.
				sTeamList = mbrVo.getTeam_id_main();
			}			
		}
		
		paramMap.put("sTeamList", sTeamList);
				
		int vacationUseListCnt = 0;		
		
		if(!"".equals(srchAnnualTeamType)) {
			paramMap.put("srchAnnualTeamType", srchAnnualTeamType);
		}		
		
		//전체결재목록
		List<VacationUseBean> vacationUseList = sqlSession.selectList("topVacationMapper.selectAnnualSetListSearchExcel",paramMap);
		vacationUseListCnt = sqlSession.selectOne("topVacationMapper.selectAnnualSetListSearchCnt", paramMap);
		
		String annual_start_date = "";
		String annual_end_date = "";
		double vacation_progress = 0;
		double day_progress = 0;
		
		for(int i = 0; i < vacationUseList.size(); i++) {
			annual_start_date = String.valueOf(vacationUseList.get(i).getBase_year())+vacationUseList.get(i).getJoin_date().subSequence(4, 10);
			annual_end_date = String.valueOf(vacationUseList.get(i).getBase_year()+1)+vacationUseList.get(i).getJoin_date().subSequence(4, 10);
			//사용 종기일입사일 하루 전날이다. (날짜패턴 yyyy-mm-dd)
			annual_end_date = DateUtil.addDateNew(annual_end_date, -1);
			
			if( vacationUseList.get(i).getAnnual_set() == 0 || vacationUseList.get(i).getAnnual_use() == 0 ) {
				vacation_progress = 0;
			}else {
				vacation_progress = vacationUseList.get(i).getAnnual_use() / vacationUseList.get(i).getAnnual_set() * 100;
			}
			
			//기간 경과율 계산시작
			day_progress = DateUtil.getDiffDayCountNew(annual_start_date, sToday);
			if( day_progress > 364){			//1년이상지난경우
				vacationUseList.get(i).setDay_progress(100);
			}else if( day_progress < 1 ) {
				vacationUseList.get(i).setDay_progress(0);
			}else {
				day_progress = day_progress / 365 * 100;
				vacationUseList.get(i).setDay_progress(day_progress);
			}			
			
			//기간 경과율 계산끝			
			vacationUseList.get(i).setAnnual_start_date(annual_start_date);
			vacationUseList.get(i).setAnnual_end_date(annual_end_date);
			vacationUseList.get(i).setVacation_progress(vacation_progress);
		}
				
        //===============================================
        // 뷰단 검색 옵션 세팅
        //===============================================				
    	
    	//검색에 사용 되는 팀 목록 SELECT
		paramMap.put("srchTeamType", srchAnnualTeamType);
		
		List<TopTmBscVO> teamList = sqlSession.selectList("topVacationMapper.teamListForSearch",paramMap);		
		
		PaginationInfo pageInfo = new PaginationInfo();			
		pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
		pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
		pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
		pageInfo.setTotalRecordCount(vacationUseListCnt);   				// 총 글 갯수
		model.addAttribute("pageInfo", pageInfo);
		
		model.addAttribute("srchAnnualYear", srchAnnualYear);
		model.addAttribute("srchAnnualTeamType",srchAnnualTeamType);
		model.addAttribute("srchAnnualTeamId",srchAnnualTeamId);
		model.addAttribute("srchUserName",srchUserName);
		model.addAttribute("srchUserState",srchUserState);		
		
		model.addAttribute("srchParam",paramMap);
		model.addAttribute("teamList", teamList);		
		
		model.addAttribute("vacationUseList",vacationUseList);
		
		model.addAttribute("pms28", pms28);
		
		return "top_mbr_vacation/vacation_annual_set_list_excel";
	}
	
	/**
	 * 휴직 엑셀다운로드
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "leaveApprovalAllExcel")
	public String leaveApprovalAllExcel(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= leaveApprovalAllExcel =======");
		
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String yearStr = StringUtil.null2blank(request.getParameter("year"));
		String monthStr = StringUtil.null2blank(request.getParameter("month"));
		
		String srchYear = StringUtil.null2blank(request.getParameter("srchYear"));
		String srchKind = StringUtil.null2blank(request.getParameter("srchKind"));
		String srchState = StringUtil.null2blank(request.getParameter("srchState"));
		String srchTeamId = StringUtil.null2blank(request.getParameter("srchTeamId"));
		String srchUserName = StringUtil.null2blank(request.getParameter("srchUserName"));		
		String srchTeamType = StringUtil.null2blank(request.getParameter("srchTeamType"));
		
		if (srchYear == "") paramMap.put("srchYear", "99");
		if (srchKind == "") paramMap.put("srchKind", "99");
		if (srchState == "") paramMap.put("srchState", "00");				//결재상태는 전체조회가 00
		if (srchTeamId == "") paramMap.put("srchTeamId", "0");
		if (srchUserName == "") paramMap.put("srchUserName", "");		
		if (srchTeamType == "") paramMap.put("srchTeamType", "5");			//팀구분은 5 (전체)
		
		int year, month;
        if ("".equals(yearStr)){
        	Calendar cal = Calendar.getInstance();
        	year = cal.get(Calendar.YEAR);
        	month = cal.get(Calendar.MONTH) + 1;
        }else{
        	year = Integer.parseInt(yearStr);
        	month = Integer.parseInt(monthStr);
        }
        
	    //===============================================
	    //	권한체크
	    //===============================================
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	    TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();

	    String workType = mbrVo.getWork_type_cd();
	    String pms28 = mbrAuthVo.getMbr_pms_28();	    
	    
	    
		if ("0".equals(mbrVo.getTeam_type())){
			paramMap.put("teamType", 1);
		}else{
			paramMap.put("teamType", mbrVo.getTeam_type());
		}
	    
	    paramMap.put("workType", workType);
	    paramMap.put("pms28", pms28);
	    
		paramMap.put("userNo",mbrVo.getUser_no());
		paramMap.put("teamId",mbrVo.getTeam_id_main());
		
		paramMap.put("year",year);
		paramMap.put("month",month);
		
		String sTeamList = "";				//팀장 센터장의 경우 사용하는 팀목록
		
		//조회할 휴가내역 1,4, 전체 구분
		if( "1".equals(pms28) ) {
			paramMap.put("srchTeamType",1);
		}else if( "4".equals(pms28) ) {
			paramMap.put("srchTeamType",4);
		}else if( "5".equals(pms28)){
			paramMap.put("srchTeamType",5);
		}else{					//1,4종 조회권한이 없는 팀장 또는 센터장은 자기가 속한 팀구분값으로 넣어준다.
			srchTeamType = mbrVo.getTeam_type();
			//work_type : 팀장 (3,7), 센터장 (14,15) 의 경우로 인사권한의 체크박스 기준으로 팀목록을 가져온다. by oniku			
			//휴가사용대장조회권한 팀목록을 가져온다.
			TopMbrAuthVO mbrVacationAuth = sqlSession.selectOne("TopLoginMapper.getVacation1Auth", mbrVo.getUser_no());			
			if( mbrVacationAuth != null) {
				sTeamList = mbrVacationAuth.getLs_admin_vacation1();				
				//sql In절에 들어갈 팀 조건 string 을 만든다.
				sTeamList = WebUtil.makeInsqlString(sTeamList,"\\|");
			}else{			//체크박스가 없는경우는 내팀만 조회한다.
				sTeamList = mbrVo.getTeam_id_main();
			}			
		}
		
		paramMap.put("sTeamList", sTeamList);		
		
		if(!"".equals(srchTeamType)) {
			paramMap.put("srchTeamType", srchTeamType);
		}
		
		//전체결재목록
		List<LeaveInfoBean> approvalList = sqlSession.selectList("topVacationMapper.selectLeaveApprovalSearchExcel",paramMap);
				
        //===============================================
        // 뷰단 검색 옵션 세팅
        //===============================================
		
		//휴직 종류 코드목록 List
		List<LeaveCode> leaveKindList =  sqlSession.selectList("topVacationMapper.selectLeaveCodeDetailList",paramMap);
		
		//휴직 결재종료 코드목록 List
		List<LeaveCode> leaveStateList = sqlSession.selectList("topVacationMapper.selectLeaveApprovalCodeList",paramMap);
    	
    	//검색에 사용 되는 팀 목록 SELECT
		List<TopTmBscVO> teamList = sqlSession.selectList("topVacationMapper.teamListForSearch",paramMap);		
		
		model.addAttribute("srchYear", srchYear);
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("srchParam",paramMap);
		model.addAttribute("leaveKindList",leaveKindList);
		model.addAttribute("leaveStateList",leaveStateList);
		model.addAttribute("teamList", teamList);
		model.addAttribute("srchTeamType",srchTeamType);
		
		model.addAttribute("approvalList",approvalList);
		
		//구분 검색권한
		model.addAttribute("pms28",pms28);		
		
		//return "top_mbr_vacation/vacation_approval_all_excel";
		return "top_mbr_leave/leave_approval_all_excel";
	}
	
	/**
	 * 신규(1종) 휴가 엑셀다운로드
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "vacationApprovalAllExcel")
	public String vacationApprovalAllExcel(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= vacationApprovalAllExcel(1) =======");
		
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String yearStr = StringUtil.null2blank(request.getParameter("year"));
		String monthStr = StringUtil.null2blank(request.getParameter("month"));
		
		String srchYear = StringUtil.null2blank(request.getParameter("srchYear"));
		String srchKind = StringUtil.null2blank(request.getParameter("srchKind"));
		String srchState = StringUtil.null2blank(request.getParameter("srchState"));
		String srchTeamId = StringUtil.null2blank(request.getParameter("srchTeamId"));
		String srchUserName = StringUtil.null2blank(request.getParameter("srchUserName"));		
		String srchTeamType = StringUtil.null2blank(request.getParameter("srchTeamType"));
		
		String srchApDateOrder = StringUtil.null2blank(request.getParameter("srchApDateOrder"));
		String srchSdate = StringUtil.null2blank(request.getParameter("srch_sdate"));
		String srchEdate = StringUtil.null2blank(request.getParameter("srch_edate"));
		
		if (srchYear == "") paramMap.put("srchYear", "99");
		if (srchKind == "") paramMap.put("srchKind", "99");
		if (srchState == "") paramMap.put("srchState", "00");				//결재상태는 전체조회가 00
		if (srchTeamId == "") paramMap.put("srchTeamId", "0");
		if (srchUserName == "") paramMap.put("srchUserName", "");		
		if (srchTeamType == "") paramMap.put("srchTeamType", "5");			//팀구분은 5 (전체)
		
		if (srchApDateOrder == "") paramMap.put("srchApDateOrder", "99");			//결재일 정렬 기준은 최초는 등록일 기준 (99:등록일기준, 결재일기준 : DESC, ASC)
		if (srchSdate == "") paramMap.put("srch_sdate", "");
		if (srchEdate == "") paramMap.put("srch_edate", "");
		
		int year, month;
        if ("".equals(yearStr)){
        	Calendar cal = Calendar.getInstance();
        	year = cal.get(Calendar.YEAR);
        	month = cal.get(Calendar.MONTH) + 1;
        }else{
        	year = Integer.parseInt(yearStr);
        	month = Integer.parseInt(monthStr);
        }
        
	    //===============================================
	    //	권한체크
	    //===============================================
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	    TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();

	    String workType = mbrVo.getWork_type_cd();
	    String pms28 = mbrAuthVo.getMbr_pms_28();	    
	    
	    
		if ("0".equals(mbrVo.getTeam_type())){
			paramMap.put("teamType", 1);
		}else{
			paramMap.put("teamType", mbrVo.getTeam_type());
		}
	    
	    paramMap.put("workType", workType);
	    paramMap.put("pms28", pms28);
	    
		paramMap.put("userNo",mbrVo.getUser_no());
		paramMap.put("teamId",mbrVo.getTeam_id_main());
		
		paramMap.put("year",year);
		paramMap.put("month",month);
		
		String sTeamList = "";				//팀장 센터장의 경우 사용하는 팀목록
		
		//조회할 휴가내역 1,4, 전체 구분
		if( "1".equals(pms28) ) {
			paramMap.put("srchTeamType",1);
		}else if( "4".equals(pms28) ) {
			paramMap.put("srchTeamType",4);
		}else if( "5".equals(pms28)){
			paramMap.put("srchTeamType",5);
		}else{					//1,4종 조회권한이 없는 팀장 또는 센터장은 자기가 속한 팀구분값으로 넣어준다.
			srchTeamType = mbrVo.getTeam_type();
			//work_type : 팀장 (3,7), 센터장 (14,15) 의 경우로 인사권한의 체크박스 기준으로 팀목록을 가져온다. by oniku			
			//휴가사용대장조회권한 팀목록을 가져온다.
			TopMbrAuthVO mbrVacationAuth = sqlSession.selectOne("TopLoginMapper.getVacation1Auth", mbrVo.getUser_no());			
			if( mbrVacationAuth != null) {
				sTeamList = mbrVacationAuth.getLs_admin_vacation1();				
				//sql In절에 들어갈 팀 조건 string 을 만든다.
				sTeamList = WebUtil.makeInsqlString(sTeamList,"\\|");
			}else{			//체크박스가 없는경우는 내팀만 조회한다.
				sTeamList = mbrVo.getTeam_id_main();
			}			
		}
		
		paramMap.put("sTeamList", sTeamList);		
		
		if(!"".equals(srchTeamType)) {
			paramMap.put("srchTeamType", srchTeamType);
		}
		
		//전체결재목록
		List<VacationInfoBean> approvalList = sqlSession.selectList("topVacationMapper.selectApprovalSearchExcel",paramMap);		
				
        //===============================================
        // 뷰단 검색 옵션 세팅
        //===============================================
		
		//휴가 종류 코드목록 List
		List<VacationCode> vacationKindList = sqlSession.selectList("topVacationMapper.selectVacationCodeDetailList",paramMap);
		
		//휴가 결재종료 코드목록 List
		List<VacationCode> vacationStateList = sqlSession.selectList("topVacationMapper.selectVacationApprovalCodeList",paramMap);
    	
    	//검색에 사용 되는 팀 목록 SELECT
		List<TopTmBscVO> teamList = sqlSession.selectList("topVacationMapper.teamListForSearch",paramMap);		
		
		model.addAttribute("srchYear", srchYear);
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("srchParam",paramMap);
		model.addAttribute("vacationKindList",vacationKindList);
		model.addAttribute("vacationStateList",vacationStateList);
		model.addAttribute("teamList", teamList);
		model.addAttribute("srchTeamType",srchTeamType);
		
		model.addAttribute("approvalList",approvalList);
		
		//구분 검색권한
		model.addAttribute("pms28",pms28);	
		
		model.addAttribute("srchApDateOrder", srchApDateOrder);
		model.addAttribute("srch_sdate", srchSdate);
		model.addAttribute("srch_edate", srchEdate);
		
		return "top_mbr_vacation/vacation_approval_all_excel";
	}
	
	/**
	 * 신규관리자 휴직신청 목록 페이지
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "leaveManagerAll")
	public String leaveManagerAll(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= leaveManagerAll =======");
		
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String yearStr = StringUtil.null2blank(request.getParameter("year"));
		String monthStr = StringUtil.null2blank(request.getParameter("month"));
		
		String srchYear = StringUtil.null2blank(request.getParameter("srchYear"));
		String srchKind = StringUtil.null2blank(request.getParameter("srchKind"));
		String srchState = StringUtil.null2blank(request.getParameter("srchState"));
		String srchTeamId = StringUtil.null2blank(request.getParameter("srchTeamId"));
		String srchUserName = StringUtil.null2blank(request.getParameter("srchUserName"));		
		String srchTeamType = StringUtil.null2blank(request.getParameter("srchTeamType"));		
		//신청자 대상 목록
		String srchUserList = StringUtil.null2blank(request.getParameter("srchUserList"));
		//퇴직자 포함여부
		String user_state = StringUtil.null2blank(request.getParameter("user_state"));
		
		if (srchYear == "") paramMap.put("srchYear", "99");
		if (srchKind == "") paramMap.put("srchKind", "99");
		if (srchState == "") paramMap.put("srchState", "00");				//결재상태는 전체조회가 00
		if (srchTeamId == "") paramMap.put("srchTeamId", "0");
		if (srchUserName == "") paramMap.put("srchUserName", "");		
		if (srchTeamType == "") paramMap.put("srchTeamType", "5");			//팀구분은 5 (전체)		
		if (srchUserList == "") paramMap.put("srchUserList", "0");			//신청자
		if (user_state == "") paramMap.put("user_state", "0");			//신청자중 퇴직자 포함여부
		
		//===============================================
		// 페이지 관련 변수 선언
		//===============================================
		int sizePerPage = 18;       // 한페이지당 보여줄 글 갯수
		int sizePerBlock = 10;      // 페이지당 보여줄 블럭 갯수
		int currentPage = 0;        // 현재 페이지
		int limitPage = 0;          // sql limit

		//===============================================
		// 현재 페이지 세팅
		//===============================================
		String pageIdxSearch = StringUtil.null2blank((String)paramMap.get("pageIdxSearch"));
		
		if("".equals(pageIdxSearch)){
		    currentPage = 0;
		    limitPage = 0;
		}else{
		    currentPage = (Integer.parseInt(pageIdxSearch) - 1);
		    limitPage = ((Integer.parseInt(pageIdxSearch) - 1) * sizePerPage);
		}
		paramMap.put("sizePerPage", sizePerPage);
		paramMap.put("limitPage", limitPage);
		
		//System.out.println("검색결과==== : "+srchYear+" : "+srchKind+" : "+ srchState+ " : "+srchTeamId+" : "+srchUserName);
		//System.out.println("srchTeamId="+srchTeamId);
		
		int year, month;
        if ("".equals(yearStr)){
        	Calendar cal = Calendar.getInstance();
        	year = cal.get(Calendar.YEAR);
        	month = cal.get(Calendar.MONTH) + 1;
        }else{
        	year = Integer.parseInt(yearStr);
        	month = Integer.parseInt(monthStr);
        }
        
	    //===============================================
	    //	권한체크
	    //===============================================
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	    TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();

	    String workType = mbrVo.getWork_type_cd();
	    String pms34 = mbrAuthVo.getMbr_pms_34();	    
	    
		if ("0".equals(mbrVo.getTeam_type())){
			paramMap.put("teamType", 1);
		}else{
			paramMap.put("teamType", mbrVo.getTeam_type());
		}
	    
	    paramMap.put("workType", workType);
	    paramMap.put("pms34", pms34);
	    
		paramMap.put("userNo",mbrVo.getUser_no());
		paramMap.put("teamId",mbrVo.getTeam_id_main());
		
		paramMap.put("year",year);
		paramMap.put("month",month);
		
		String sTeamList = "";				//팀장 센터장의 경우 사용하는 팀목록
		
		//조회할 휴가내역 1,4, 전체 구분
		if( "1".equals(pms34) ) {
			paramMap.put("srchTeamType",1);			
			//휴가 신청자 종구분용설정
			paramMap.put("team_type", 1);
		}else if( "4".equals(pms34) ) {
			paramMap.put("srchTeamType",4);
			//휴가 신청자 종구분용설정
			paramMap.put("team_type", 4);
		}else if( "5".equals(pms34)){
			paramMap.put("srchTeamType",5);
			//휴가 신청자 종구분용설정 (전체)
			paramMap.put("team_type", 0);
		}else{					//1,4종 조회권한이 없는 팀장 또는 센터장은 자기가 속한 팀구분값으로 넣어준다.
			srchTeamType = mbrVo.getTeam_type();					
		}
		
		paramMap.put("sTeamList", sTeamList);	
		
		//신청할 사용자 목록
		paramMap.put("user_state", user_state);
		List<Map<Object, String>> ApUserList = sqlSession.selectList("topVacationMapper.selectUserListTeamType",paramMap); 
				
		int approvalListCnt = 0;		
		
		if(!"".equals(srchTeamType)) {
			paramMap.put("srchTeamType", srchTeamType);
		}
		
		//전체결재목록
		List<LeaveInfoBean> approvalList = sqlSession.selectList("topVacationMapper.selectLeaveApprovalManagerSearch",paramMap);
		approvalListCnt = sqlSession.selectOne("topVacationMapper.selectLeaveApprovalManagerSearchCnt", paramMap);		
				
        //===============================================
        // 뷰단 검색 옵션 세팅
        //===============================================
		
		//휴직 종류 코드목록 List
		List<LeaveCode> leaveCodeList = sqlSession.selectList("topVacationMapper.selectLeaveCodeDetailList",paramMap);
		
		//휴직 결재종료 코드목록 List
		List<LeaveCode> leaveStateList = sqlSession.selectList("topVacationMapper.selectLeaveApprovalCodeList",paramMap);
    	
    	//검색에 사용 되는 팀 목록 SELECT
		List<TopTmBscVO> teamList = sqlSession.selectList("topVacationMapper.teamListForSearch",paramMap);		
		
		PaginationInfo pageInfo = new PaginationInfo();			
		pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
		pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
		pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
		pageInfo.setTotalRecordCount(approvalListCnt);   				// 총 글 갯수
		model.addAttribute("pageInfo", pageInfo);
		
		model.addAttribute("srchYear", srchYear);
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("srchParam",paramMap);
		model.addAttribute("leaveKindList",leaveCodeList);
		model.addAttribute("leaveStateList",leaveStateList);				

		model.addAttribute("teamList", teamList);
		model.addAttribute("srchTeamType",srchTeamType);
		
		model.addAttribute("approvalList",approvalList);
		
		//구분 검색권한
		model.addAttribute("pms34",pms34);
		//신청자 목록
		model.addAttribute("ApUserList", ApUserList);

		return "top_mbr_leave/leave_manager_all";
	}
	
	/**
	 * 신규관리자 휴가신청 목록 페이지
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "vacationManagerAll")
	public String vacationManagerAll(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= vacationManagerAll =======");
		
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String yearStr = StringUtil.null2blank(request.getParameter("year"));
		String monthStr = StringUtil.null2blank(request.getParameter("month"));
		
		String srchYear = StringUtil.null2blank(request.getParameter("srchYear"));
		String srchKind = StringUtil.null2blank(request.getParameter("srchKind"));
		String srchState = StringUtil.null2blank(request.getParameter("srchState"));
		String srchTeamId = StringUtil.null2blank(request.getParameter("srchTeamId"));
		String srchUserName = StringUtil.null2blank(request.getParameter("srchUserName"));		
		String srchTeamType = StringUtil.null2blank(request.getParameter("srchTeamType"));		
		//신청자 대상 목록
		String srchUserList = StringUtil.null2blank(request.getParameter("srchUserList"));
		//퇴직자 포함여부
		String user_state = StringUtil.null2blank(request.getParameter("user_state"));
		
		if (srchYear == "") paramMap.put("srchYear", "99");
		if (srchKind == "") paramMap.put("srchKind", "99");
		if (srchState == "") paramMap.put("srchState", "00");				//결재상태는 전체조회가 00
		if (srchTeamId == "") paramMap.put("srchTeamId", "0");
		if (srchUserName == "") paramMap.put("srchUserName", "");		
		if (srchTeamType == "") paramMap.put("srchTeamType", "5");			//팀구분은 5 (전체)		
		if (srchUserList == "") paramMap.put("srchUserList", "0");			//신청자
		if (user_state == "") paramMap.put("user_state", "0");			//신청자중 퇴직자 포함여부
		
		//===============================================
		// 페이지 관련 변수 선언
		//===============================================
		int sizePerPage = 18;       // 한페이지당 보여줄 글 갯수
		int sizePerBlock = 10;      // 페이지당 보여줄 블럭 갯수
		int currentPage = 0;        // 현재 페이지
		int limitPage = 0;          // sql limit

		//===============================================
		// 현재 페이지 세팅
		//===============================================
		String pageIdxSearch = StringUtil.null2blank((String)paramMap.get("pageIdxSearch"));
		
		if("".equals(pageIdxSearch)){
		    currentPage = 0;
		    limitPage = 0;
		}else{
		    currentPage = (Integer.parseInt(pageIdxSearch) - 1);
		    limitPage = ((Integer.parseInt(pageIdxSearch) - 1) * sizePerPage);
		}
		paramMap.put("sizePerPage", sizePerPage);
		paramMap.put("limitPage", limitPage);
		
		//System.out.println("검색결과==== : "+srchYear+" : "+srchKind+" : "+ srchState+ " : "+srchTeamId+" : "+srchUserName);
		//System.out.println("srchTeamId="+srchTeamId);
		
		int year, month;
        if ("".equals(yearStr)){
        	Calendar cal = Calendar.getInstance();
        	year = cal.get(Calendar.YEAR);
        	month = cal.get(Calendar.MONTH) + 1;
        }else{
        	year = Integer.parseInt(yearStr);
        	month = Integer.parseInt(monthStr);
        }
        
	    //===============================================
	    //	권한체크
	    //===============================================
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	    TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();

	    String workType = mbrVo.getWork_type_cd();
	    //String pms28 = mbrAuthVo.getMbr_pms_28();
	    String pms34 = mbrAuthVo.getMbr_pms_34();
	    
	    //System.out.println("pms34="+pms34);
	    
	    
		if ("0".equals(mbrVo.getTeam_type())){
			paramMap.put("teamType", 1);
		}else{
			paramMap.put("teamType", mbrVo.getTeam_type());
		}
	    
	    paramMap.put("workType", workType);
	    paramMap.put("pms34", pms34);
	    
		paramMap.put("userNo",mbrVo.getUser_no());
		paramMap.put("teamId",mbrVo.getTeam_id_main());
		
		paramMap.put("year",year);
		paramMap.put("month",month);
		
		String sTeamList = "";				//팀장 센터장의 경우 사용하는 팀목록
		
		//조회할 휴가내역 1,4, 전체 구분
		if( "1".equals(pms34) ) {
			paramMap.put("srchTeamType",1);			
			//휴가 신청자 종구분용설정
			paramMap.put("team_type", 1);
		}else if( "4".equals(pms34) ) {
			paramMap.put("srchTeamType",4);
			//휴가 신청자 종구분용설정
			paramMap.put("team_type", 4);
		}else if( "5".equals(pms34)){
			paramMap.put("srchTeamType",5);
			//휴가 신청자 종구분용설정 (전체)
			paramMap.put("team_type", 0);
		}else{					//1,4종 조회권한이 없는 팀장 또는 센터장은 자기가 속한 팀구분값으로 넣어준다.
			srchTeamType = mbrVo.getTeam_type();
			//work_type : 팀장 (3,7), 센터장 (14,15) 의 경우로 인사권한의 체크박스 기준으로 팀목록을 가져온다. by oniku			
			//휴가사용대장조회권한 팀목록을 가져온다.
			/**
			TopMbrAuthVO mbrVacationAuth = sqlSession.selectOne("TopLoginMapper.getVacation1Auth", mbrVo.getUser_no());			
			if( mbrVacationAuth != null) {
				sTeamList = mbrVacationAuth.getLs_admin_vacation1();				
				//sql In절에 들어갈 팀 조건 string 을 만든다.
				sTeamList = WebUtil.makeInsqlString(sTeamList,"\\|");
			}else{			//체크박스가 없는경우는 내팀만 조회한다.
				sTeamList = mbrVo.getTeam_id_main();
			}	
			**/		
		}
		
		paramMap.put("sTeamList", sTeamList);	
		
		//신청할 사용자 목록
		paramMap.put("user_state", user_state);
		List<Map<Object, String>> ApUserList = sqlSession.selectList("topVacationMapper.selectUserListTeamType",paramMap); 
				
		int approvalListCnt = 0;		
		
		if(!"".equals(srchTeamType)) {
			paramMap.put("srchTeamType", srchTeamType);
		}
		
		//전체결재목록
		List<VacationInfoBean> approvalList = sqlSession.selectList("topVacationMapper.selectApprovalManagerSearch",paramMap);
		approvalListCnt = sqlSession.selectOne("topVacationMapper.selectApprovalManagerSearchCnt", paramMap);		
				
        //===============================================
        // 뷰단 검색 옵션 세팅
        //===============================================
		
		//휴가 종류 코드목록 List
		List<VacationCode> vacationKindList = sqlSession.selectList("topVacationMapper.selectVacationCodeDetailList",paramMap);
		
		//휴가 결재종료 코드목록 List
		List<VacationCode> vacationStateList = sqlSession.selectList("topVacationMapper.selectVacationApprovalCodeList",paramMap);		
    	
    	//검색에 사용 되는 팀 목록 SELECT
		List<TopTmBscVO> teamList = sqlSession.selectList("topVacationMapper.teamListForSearch",paramMap);		
		
		PaginationInfo pageInfo = new PaginationInfo();			
		pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
		pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
		pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
		pageInfo.setTotalRecordCount(approvalListCnt);   				// 총 글 갯수
		model.addAttribute("pageInfo", pageInfo);
		
		model.addAttribute("srchYear", srchYear);
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("srchParam",paramMap);
		model.addAttribute("vacationKindList",vacationKindList);
		model.addAttribute("vacationStateList",vacationStateList);		
		//model.addAttribute("yearList",yearList);
		model.addAttribute("teamList", teamList);
		model.addAttribute("srchTeamType",srchTeamType);
		
		model.addAttribute("approvalList",approvalList);
		
		//구분 검색권한
		model.addAttribute("pms34",pms34);
		//신청자 목록
		model.addAttribute("ApUserList", ApUserList);

		return "top_mbr_vacation/vacation_manager_all";
	}
	
	/**
	 * 휴직 전제목록 페이지
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "leaveApprovalAll")
	public String leaveApprovalAll(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= leaveApprovalAll =======");
		
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String yearStr = StringUtil.null2blank(request.getParameter("year"));
		String monthStr = StringUtil.null2blank(request.getParameter("month"));
		
		String srchYear = StringUtil.null2blank(request.getParameter("srchYear"));
		String srchKind = StringUtil.null2blank(request.getParameter("srchKind"));
		String srchState = StringUtil.null2blank(request.getParameter("srchState"));
		String srchTeamId = StringUtil.null2blank(request.getParameter("srchTeamId"));
		String srchUserName = StringUtil.null2blank(request.getParameter("srchUserName"));		
		String srchTeamType = StringUtil.null2blank(request.getParameter("srchTeamType"));
		
		if (srchYear == "") paramMap.put("srchYear", "99");
		if (srchKind == "") paramMap.put("srchKind", "99");
		if (srchState == "") paramMap.put("srchState", "00");				//결재상태는 전체조회가 00
		if (srchTeamId == "") paramMap.put("srchTeamId", "0");
		if (srchUserName == "") paramMap.put("srchUserName", "");		
		if (srchTeamType == "") paramMap.put("srchTeamType", "5");			//팀구분은 5 (전체)
		
		//===============================================
		// 페이지 관련 변수 선언
		//===============================================
		int sizePerPage = 18;       // 한페이지당 보여줄 글 갯수
		int sizePerBlock = 10;      // 페이지당 보여줄 블럭 갯수
		int currentPage = 0;        // 현재 페이지
		int limitPage = 0;          // sql limit

		//===============================================
		// 현재 페이지 세팅
		//===============================================
		String pageIdxSearch = StringUtil.null2blank((String)paramMap.get("pageIdxSearch"));
		
		if("".equals(pageIdxSearch)){
		    currentPage = 0;
		    limitPage = 0;
		}else{
		    currentPage = (Integer.parseInt(pageIdxSearch) - 1);
		    limitPage = ((Integer.parseInt(pageIdxSearch) - 1) * sizePerPage);
		}
		paramMap.put("sizePerPage", sizePerPage);
		paramMap.put("limitPage", limitPage);
		
		//System.out.println("검색결과==== : "+srchYear+" : "+srchKind+" : "+ srchState+ " : "+srchTeamId+" : "+srchUserName);
		//System.out.println("srchTeamId="+srchTeamId);		
        
	    //===============================================
	    //	권한체크
	    //===============================================
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	    TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();

	    String workType = mbrVo.getWork_type_cd();
	    String pms28 = mbrAuthVo.getMbr_pms_28();	    
	    
	    
		if ("0".equals(mbrVo.getTeam_type())){
			paramMap.put("teamType", 1);
		}else{
			paramMap.put("teamType", mbrVo.getTeam_type());
		}
	    
	    paramMap.put("workType", workType);
	    paramMap.put("pms28", pms28);
	    
		paramMap.put("userNo",mbrVo.getUser_no());
		paramMap.put("teamId",mbrVo.getTeam_id_main());
		
		String sTeamList = "";				//팀장 센터장의 경우 사용하는 팀목록
		
		//조회할 휴가내역 1,4, 전체 구분
		if( "1".equals(pms28) ) {
			paramMap.put("srchTeamType",1);
		}else if( "4".equals(pms28) ) {
			paramMap.put("srchTeamType",4);
		}else if( "5".equals(pms28)){
			paramMap.put("srchTeamType",5);
		}else{					//1,4종 조회권한이 없는 팀장 또는 센터장은 자기가 속한 팀구분값으로 넣어준다.
			srchTeamType = mbrVo.getTeam_type();
			//work_type : 팀장 (3,7), 센터장 (14,15) 의 경우로 인사권한의 체크박스 기준으로 팀목록을 가져온다. by oniku			
			//휴가사용대장조회권한 팀목록을 가져온다.
			TopMbrAuthVO mbrVacationAuth = sqlSession.selectOne("TopLoginMapper.getVacation1Auth", mbrVo.getUser_no());			
			if( mbrVacationAuth != null) {
				sTeamList = mbrVacationAuth.getLs_admin_vacation1();				
				//sql In절에 들어갈 팀 조건 string 을 만든다.
				sTeamList = WebUtil.makeInsqlString(sTeamList,"\\|");
			}else{			//체크박스가 없는경우는 내팀만 조회한다.
				sTeamList = mbrVo.getTeam_id_main();
			}			
		}
		
		paramMap.put("sTeamList", sTeamList);		
				
		int approvalListCnt = 0;		
		
		if(!"".equals(srchTeamType)) {
			paramMap.put("srchTeamType", srchTeamType);
		}
		
		//전체결재목록
		//List<VacationInfoBean> approvalList = sqlSession.selectList("topVacationMapper.selectApprovalSearch",paramMap);
		List<LeaveInfoBean> approvalList = sqlSession.selectList("topVacationMapper.selectLeaveApprovalSearch",paramMap);
		//approvalListCnt = sqlSession.selectOne("topVacationMapper.selectApprovalSearchCnt", paramMap);
		approvalListCnt = sqlSession.selectOne("topVacationMapper.selectLeaveApprovalSearchCnt", paramMap);
				
        //===============================================
        // 뷰단 검색 옵션 세팅
        //===============================================
		
		//휴직 종류 코드목록 List
		//List<VacationCode> vacationKindList = sqlSession.selectList("topVacationMapper.selectVacationCodeDetailList",paramMap);
		List<LeaveCode> leaveCodeList = sqlSession.selectList("topVacationMapper.selectLeaveCodeDetailList",paramMap);
		
		//휴가 결재종료 코드목록 List
		//List<VacationCode> vacationStateList = sqlSession.selectList("topVacationMapper.selectVacationApprovalCodeList",paramMap);
		List<LeaveCode> leaveStateList = sqlSession.selectList("topVacationMapper.selectLeaveApprovalCodeList",paramMap);
    	
    	//검색에 사용 되는 팀 목록 SELECT
		List<TopTmBscVO> teamList = sqlSession.selectList("topVacationMapper.teamListForSearch",paramMap);		
		
		PaginationInfo pageInfo = new PaginationInfo();			
		pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
		pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
		pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
		pageInfo.setTotalRecordCount(approvalListCnt);   				// 총 글 갯수
		model.addAttribute("pageInfo", pageInfo);
		
		model.addAttribute("srchYear", srchYear);		
		model.addAttribute("srchParam",paramMap);
		model.addAttribute("leaveKindList",leaveCodeList);
		model.addAttribute("leaveStateList",leaveStateList);		
		model.addAttribute("teamList", teamList);
		model.addAttribute("srchTeamType",srchTeamType);
		
		model.addAttribute("approvalList",approvalList);
		
		//구분 검색권한
		model.addAttribute("pms28",pms28);		
		
		//return "top_mbr_vacation/vacation_approval_all";
		return "top_mbr_leave/leave_approval_all";
	}
	
	/**
	 * 신규(1종) 휴가 전제목록 페이지
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "vacationApprovalAll")
	public String vacationApprovalAll(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= vacationApprovalAll(1) =======");
		
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);		
		
		String yearStr = StringUtil.null2blank(request.getParameter("year"));
		String monthStr = StringUtil.null2blank(request.getParameter("month"));
		
		String srchYear = StringUtil.null2blank(request.getParameter("srchYear"));
		String srchKind = StringUtil.null2blank(request.getParameter("srchKind"));
		String srchState = StringUtil.null2blank(request.getParameter("srchState"));
		String srchTeamId = StringUtil.null2blank(request.getParameter("srchTeamId"));
		String srchUserName = StringUtil.null2blank(request.getParameter("srchUserName"));		
		String srchTeamType = StringUtil.null2blank(request.getParameter("srchTeamType"));
		
		String srchApDateOrder = StringUtil.null2blank(request.getParameter("srchApDateOrder"));
		String srchSdate = StringUtil.null2blank(request.getParameter("srch_sdate"));
		String srchEdate = StringUtil.null2blank(request.getParameter("srch_edate"));
		
		if (srchYear == "") paramMap.put("srchYear", "99");
		if (srchKind == "") paramMap.put("srchKind", "99");
		if (srchState == "") paramMap.put("srchState", "00");				//결재상태는 전체조회가 00
		if (srchTeamId == "") paramMap.put("srchTeamId", "0");
		if (srchUserName == "") paramMap.put("srchUserName", "");		
		if (srchTeamType == "") paramMap.put("srchTeamType", "5");			//팀구분은 5 (전체)
		
		if (srchApDateOrder == "") paramMap.put("srchApDateOrder", "99");			//결재일 정렬 기준은 최초는 등록일 기준 (99:등록일기준, 결재일기준 : DESC, ASC)
		if (srchSdate == "") paramMap.put("srch_sdate", "");
		if (srchEdate == "") paramMap.put("srch_edate", "");
		
		//===============================================
		// 페이지 관련 변수 선언
		//===============================================
		int sizePerPage = 18;       // 한페이지당 보여줄 글 갯수
		int sizePerBlock = 10;      // 페이지당 보여줄 블럭 갯수
		int currentPage = 0;        // 현재 페이지
		int limitPage = 0;          // sql limit

		//===============================================
		// 현재 페이지 세팅
		//===============================================
		String pageIdxSearch = StringUtil.null2blank((String)paramMap.get("pageIdxSearch"));
		
		if("".equals(pageIdxSearch)){
		    currentPage = 0;
		    limitPage = 0;
		}else{
		    currentPage = (Integer.parseInt(pageIdxSearch) - 1);
		    limitPage = ((Integer.parseInt(pageIdxSearch) - 1) * sizePerPage);
		}
		paramMap.put("sizePerPage", sizePerPage);
		paramMap.put("limitPage", limitPage);
		
		//System.out.println("검색결과==== : "+srchYear+" : "+srchKind+" : "+ srchState+ " : "+srchTeamId+" : "+srchUserName);
		//System.out.println("srchTeamId="+srchTeamId);
		
		int year, month;
        if ("".equals(yearStr)){
        	Calendar cal = Calendar.getInstance();
        	year = cal.get(Calendar.YEAR);
        	month = cal.get(Calendar.MONTH) + 1;
        }else{
        	year = Integer.parseInt(yearStr);
        	month = Integer.parseInt(monthStr);
        }
        
	    //===============================================
	    //	권한체크
	    //===============================================
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	    TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();

	    String workType = mbrVo.getWork_type_cd();
	    String pms28 = mbrAuthVo.getMbr_pms_28();	    
	    
	    
		if ("0".equals(mbrVo.getTeam_type())){
			paramMap.put("teamType", 1);
		}else{
			paramMap.put("teamType", mbrVo.getTeam_type());
		}
	    
	    paramMap.put("workType", workType);
	    paramMap.put("pms28", pms28);
	    
		paramMap.put("userNo",mbrVo.getUser_no());
		paramMap.put("teamId",mbrVo.getTeam_id_main());
		
		paramMap.put("year",year);
		paramMap.put("month",month);
		
		String sTeamList = "";				//팀장 센터장의 경우 사용하는 팀목록
		
		//휴가사용대장조회권한 팀목록을 가져온다.
		TopMbrAuthVO mbrVacationAuth = sqlSession.selectOne("TopLoginMapper.getVacation1Auth", mbrVo.getUser_no());
		
		//휴가 조회권한 전체(5)를 제외하고는 체크박스한 팀만 조회되도록 한다.
		if( "5".equals(pms28) ) {
			paramMap.put("srchTeamType",5);
		}else{
			if( mbrVacationAuth != null) {
				sTeamList = mbrVacationAuth.getLs_admin_vacation1();				
				//sql In절에 들어갈 팀 조건 string 을 만든다.
				sTeamList = WebUtil.makeInsqlString(sTeamList,"\\|");
			}else{			//체크박스가 없는경우는 내팀만 조회한다.
				sTeamList = mbrVo.getTeam_id_main();
			}
			
			if( "1".equals(pms28) ) {
				paramMap.put("srchTeamType",1);
			}else if( "4".equals(pms28) ) {
				paramMap.put("srchTeamType",4);
			}
		}
		
		/*
		//조회할 휴가내역 1,4, 전체 구분
		if( "1".equals(pms28) ) {
			paramMap.put("srchTeamType",1);
		}else if( "4".equals(pms28) ) {
			paramMap.put("srchTeamType",4);
		}else if( "5".equals(pms28)){
			paramMap.put("srchTeamType",5);
		}else{					//1,4종 조회권한이 없는 팀장 또는 센터장은 자기가 속한 팀구분값으로 넣어준다.
			srchTeamType = mbrVo.getTeam_type();
			//work_type : 팀장 (3,7), 센터장 (14,15) 의 경우로 인사권한의 체크박스 기준으로 팀목록을 가져온다. by oniku			
			//휴가사용대장조회권한 팀목록을 가져온다.
			TopMbrAuthVO mbrVacationAuth = sqlSession.selectOne("TopLoginMapper.getVacation1Auth", mbrVo.getUser_no());			
			if( mbrVacationAuth != null) {
				sTeamList = mbrVacationAuth.getLs_admin_vacation1();				
				//sql In절에 들어갈 팀 조건 string 을 만든다.
				sTeamList = WebUtil.makeInsqlString(sTeamList,"\\|");
			}else{			//체크박스가 없는경우는 내팀만 조회한다.
				sTeamList = mbrVo.getTeam_id_main();
			}			
		}
		*/
		
		paramMap.put("sTeamList", sTeamList);		
				
		int approvalListCnt = 0;		
		
		if(!"".equals(srchTeamType)) {
			paramMap.put("srchTeamType", srchTeamType);
		}
		
		//전체결재목록
		List<VacationInfoBean> approvalList = sqlSession.selectList("topVacationMapper.selectApprovalSearch",paramMap);
		approvalListCnt = sqlSession.selectOne("topVacationMapper.selectApprovalSearchCnt", paramMap);		
				
        //===============================================
        // 뷰단 검색 옵션 세팅
        //===============================================
		
		//휴가 종류 코드목록 List
		List<VacationCode> vacationKindList = sqlSession.selectList("topVacationMapper.selectVacationCodeDetailList",paramMap);
		
		//휴가 결재종료 코드목록 List
		List<VacationCode> vacationStateList = sqlSession.selectList("topVacationMapper.selectVacationApprovalCodeList",paramMap);
		
        //검색 년도 SETTING (2016년 ~ 올해 + 1년)
        //임의로 2019, 2020으로 처리 향후 변경필요
		/*
		 * Calendar cal = Calendar.getInstance(); year = cal.get(Calendar.YEAR);
		 * List<Integer> yearList = new ArrayList<>(); for(int i=2016; i <= year+1
		 * ;i++){ yearList.add(i); }
		 */		
    	
    	//검색에 사용 되는 팀 목록 SELECT
		List<TopTmBscVO> teamList = sqlSession.selectList("topVacationMapper.teamListForSearch",paramMap);		
		
		PaginationInfo pageInfo = new PaginationInfo();			
		pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
		pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
		pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
		pageInfo.setTotalRecordCount(approvalListCnt);   				// 총 글 갯수
		model.addAttribute("pageInfo", pageInfo);
		
		model.addAttribute("srchYear", srchYear);
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("srchParam",paramMap);
		model.addAttribute("vacationKindList",vacationKindList);
		model.addAttribute("vacationStateList",vacationStateList);		
		//model.addAttribute("yearList",yearList);
		model.addAttribute("teamList", teamList);
		model.addAttribute("srchTeamType",srchTeamType);
		
		model.addAttribute("approvalList",approvalList);
		
		//구분 검색권한
		model.addAttribute("pms28",pms28);
		
		model.addAttribute("srchApDateOrder", srchApDateOrder);
		model.addAttribute("srch_sdate", srchSdate);
		model.addAttribute("srch_edate", srchEdate);
		
		return "top_mbr_vacation/vacation_approval_all";
	}
	
	
	/*
	*********************************************************
	* Program ID	: vacationAprvList
	* Program Name	: vacationAprvList
	* Description	: 휴가(신규) 결재 화면
	* Author		: 임대성
	* Date			: 2018.06.15
	*********************************************************
	*/
	@RequestMapping(value = "vacationAprvList")
	public String vacationAprvList(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= vacationAprvList =======");
		
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String yearStr = StringUtil.null2blank(request.getParameter("year"));
		String monthStr = StringUtil.null2blank(request.getParameter("month"));
		
		String srchYear = StringUtil.null2blank(request.getParameter("srchYear"));
		String srchKind = StringUtil.null2blank(request.getParameter("srchKind"));
		String srchState = StringUtil.null2blank(request.getParameter("srchState"));
		String srchTeamId = StringUtil.null2blank(request.getParameter("srchTeamId"));
		String srchUserName = StringUtil.null2blank(request.getParameter("srchUserName"));
		
		if (srchYear == "") paramMap.put("srchYear", "99");
		if (srchKind == "") paramMap.put("srchKind", "99");
		if (srchState == "") paramMap.put("srchState", "99");
		if (srchTeamId == "") paramMap.put("srchTeamId", "0");
		if (srchUserName == "") paramMap.put("srchUserName", "");
		
		int year, month;
        if ("".equals(yearStr)){
        	Calendar cal = Calendar.getInstance();
        	year = cal.get(Calendar.YEAR);
        	month = cal.get(Calendar.MONTH) + 1;
        }else{
        	year = Integer.parseInt(yearStr);
        	month = Integer.parseInt(monthStr);
        }
        
	    //===============================================
	    //	권한체크
	    //===============================================
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	    TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
	    
	    int managerCnt = sqlSession.selectOne("topVacationMapper.selectManagerCnt",mbrVo.getUser_no());
	    String workType = mbrVo.getWork_type_cd();
	    String pms28 = mbrAuthVo.getMbr_pms_28();
	    
        //===============================================
        // 권한 처리
	    // 팀장이 아니거나, 1종 및 4종 센터장이 아니거나, 결재권한이 없거나, IT가 아닌경우
        //===============================================
	    if (  !(managerCnt > 0 
	    		|| "3".equals(workType) || "7".equals(workType)
	    		|| "14".equals(workType) || "15".equals(workType)
	    		|| "1".equals(pms28) || "4".equals(pms28) 
	    		|| !"9".equals(mbrVo.getUser_state())) ){
            return "redirect://";
        }
	    
		if ("0".equals(mbrVo.getTeam_type())){
			paramMap.put("teamType", 1);
		}else{
			paramMap.put("teamType", mbrVo.getTeam_type());
		}
	    
	    paramMap.put("workType", workType);
	    paramMap.put("pms28", pms28);
	    
		paramMap.put("userNo",mbrVo.getUser_no());
		paramMap.put("teamId",mbrVo.getTeam_id_main());
		
		paramMap.put("year",year);
		paramMap.put("month",month);
		
		 
		// 결재 해야할 휴가 내역
		List<VacationVo> vacationAprvList = sqlSession.selectList("topVacationMapper.selectVacationAprvList",paramMap);
		
		
        //===============================================
        // 뷰단 검색 옵션 세팅
        //===============================================      
		//휴가 종류 SELECT
        SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();
        codeVo.setTbl_nm("top_mbr_vacation");
        codeVo.setCol_nm("vacation_kind");
        List<SysAdmCodeDicVO> vacationKindList = CodeDicService.codeList(codeVo);
        
		//휴가 상태 SELECT
        codeVo.setTbl_nm("top_mbr_vacation");
        codeVo.setCol_nm("vacation_state");
        List<SysAdmCodeDicVO> vacationStateList = CodeDicService.codeList(codeVo);        
        
        //검색 년도 SETTING (2016년 ~ 올해 + 1년)
    	Calendar cal = Calendar.getInstance();
    	year = cal.get(Calendar.YEAR);
    	List<Integer> yearList = new ArrayList<>();
    	for(int i=2016; i <= year+1 ;i++){
    		yearList.add(i);
    	}
    	
    	//검색에 사용 되는 팀 목록 SELECT
		List<TopTmBscVO> teamList = sqlSession.selectList("topVacationMapper.teamListForSearch");
		
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("srchParam",paramMap);
		model.addAttribute("vacationKindList",vacationKindList);
		model.addAttribute("vacationStateList",vacationStateList);
		model.addAttribute("yearList",yearList);
		model.addAttribute("teamList", teamList);
		
		model.addAttribute("vacationAprvList",vacationAprvList);
		
		return "top_mbr_vacation/vacation_aprv_main";
	}
	
	
	/*
	*********************************************************
	* Program ID	: vacationLogList
	* Program Name	: vacationLogList
	* Description	: 휴가(신규) 로그 화면
	* Author		: 임대성
	* Date			: 2018.06.15
	*********************************************************
	*/
	@RequestMapping(value = "vacationLogList")
	public String vacationLogList(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= vacationLogList =======");
		
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		String srchYear = StringUtil.null2blank(request.getParameter("srchYear"));
		String srchKind = StringUtil.null2blank(request.getParameter("srchKind"));
		String srchState = StringUtil.null2blank(request.getParameter("srchState"));
		String srchTeamId = StringUtil.null2blank(request.getParameter("srchTeamId"));
		String srchUserName = StringUtil.null2blank(request.getParameter("srchUserName"));
		
		if (srchYear == "") paramMap.put("srchYear", "99");
		if (srchKind == "") paramMap.put("srchKind", "99");
		if (srchState == "") paramMap.put("srchState", "99");
		if (srchTeamId == "") paramMap.put("srchTeamId", "0");
		if (srchUserName == "") paramMap.put("srchUserName", "");
				
	    //===============================================
	    //	권한체크
	    //===============================================
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	    TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
	    
        String pms28 = mbrAuthVo.getMbr_pms_28();
        paramMap.put("pms28", pms28);	    
    	
    	if ( (!"1".equals(pms28) && !"4".equals(pms28)) && srchTeamId == "" ){
    		paramMap.put("srchTeamId", "9999");
    	}
    	
    	//검색에 사용 되는 팀 목록 SELECT
    	//work_type - 3 : 1종팀장, 14: 1종 센터장
    	paramMap.put("sessTeamType", mbrVo.getTeam_type());
    	paramMap.put("sessWorkType", mbrVo.getWork_type_cd());
    	paramMap.put("sessTeamId", mbrVo.getTeam_id_main());
    	
		List<TopTmBscVO> teamList = sqlSession.selectList("topVacationMapper.teamListForSearch",paramMap);
	    
		String sAllteam = "";
		String sCenter = "";		
		
		if(teamList.size() > 1) {		//2개이상의 팀을 가지고 있는 경우만 가지고 온다.	여기부터 작업해야함...	
			for(int i=0; i < teamList.size(); i++) {
				if( i < teamList.size()-1 ) {
					sAllteam += teamList.get(i).getTeam_id()+",";
				}else{
					sAllteam += teamList.get(i).getTeam_id();
				}			
			}
			sCenter = teamList.get(0).getTeam_id();		//Center id
		}
		
		//System.out.println("sAllteam="+sAllteam);
	    
        //===============================================
        // 페이지 관련 변수 선언 
        //===============================================
        int sizePerPage = 20;       // 한페이지당 보여줄 글 갯수
        int sizePerBlock = 10;      // 페이지당 보여줄 블럭 갯수
        int currentPage = 0;        // 현재 페이지
        int limitPage = 0;          // sql limit

        //===============================================
        // 현재 페이지 세팅
        //===============================================
        String pageIdx = StringUtil.null2blank((String)paramMap.get("pageIdx"));
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
        // 권한 처리
	    // 1종 및 4종 센터장이 아니거나, 결재권한이 없거나, IT가 아닌경우
        //===============================================
	    /*
	    if (  !("1".equals(pms28) || "4".equals(pms28) || !"9".equals(mbrVo.getUser_state())) ){
            return "redirect://";
        }
	    */
        
        //System.out.println("srchTeamId="+srchTeamId);
        
        if( "".equals(srchTeamId) ){        	
        	paramMap.put("sAllteam", sAllteam);
        }else if( !sCenter.equals(srchTeamId) ){        	        	
        	paramMap.put("sAllteam", null);			//빈값을 넣는다.
        }else{        	
        	paramMap.put("sAllteam", sAllteam);
        }	    
		paramMap.put("gubun", "log");
		
		//System.out.println("srchTeamId="+srchTeamId);
		
		List<VacationVo> vacationLogList = sqlSession.selectList("topVacationMapper.selectVacationList",paramMap);
		long vacationLogListCnt = sqlSession.selectOne("topVacationMapper.selectVacationListCnt",paramMap);
		
		//System.out.println("vacationLogListCnt="+vacationLogListCnt);
		
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        PaginationInfo pageInfo = new PaginationInfo();			
        pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
        pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
        pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
        pageInfo.setTotalRecordCount(vacationLogListCnt);   			// 총 글 갯수        
        pageInfo.setPageName("log");

        
        //===============================================
        // 뷰단 검색 옵션 세팅
        //===============================================      
		//휴가 종류 SELECT
        SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();
        codeVo.setTbl_nm("top_mbr_vacation");
        codeVo.setCol_nm("vacation_kind");
        List<SysAdmCodeDicVO> vacationKindList = CodeDicService.codeList(codeVo);
        
		//휴가 상태 SELECT
        codeVo.setTbl_nm("top_mbr_vacation");
        codeVo.setCol_nm("vacation_state");
        List<SysAdmCodeDicVO> vacationStateList = CodeDicService.codeList(codeVo);        
        
        //검색 년도 SETTING (2016년 ~ 올해 + 1년)
    	Calendar cal = Calendar.getInstance();
    	int year = cal.get(Calendar.YEAR);
    	List<Integer> yearList = new ArrayList<>();
    	for(int i=2016; i <= year+1 ;i++){
    		yearList.add(i);
    	}    	
		
		model.addAttribute("logParam",paramMap);
		model.addAttribute("vacationKindList",vacationKindList);
		model.addAttribute("vacationStateList",vacationStateList);
		model.addAttribute("yearList",yearList);
		model.addAttribute("teamList", teamList);
		
		model.addAttribute("vacationLogList",vacationLogList);
		model.addAttribute("vacationLogListCnt",vacationLogListCnt);
		
		model.addAttribute("pageInfo",pageInfo);
		
						
		return "top_mbr_vacation/vacation_log_list";
	}
	
	/**
	 * 휴직 결재내역 by top3009
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "leaveApprovalResult")
	public String leaveApprovalResult(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= leaveApprovalResult =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();		
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		//===============================================
		// 페이지 관련 변수 선언
		//===============================================
		int sizePerPage = 20;       // 한페이지당 보여줄 글 갯수
		int sizePerBlock = 10;      // 페이지당 보여줄 블럭 갯수
		int currentPage = 0;        // 현재 페이지
		int limitPage = 0;          // sql limit

		//===============================================
		// 현재 페이지 세팅
		//===============================================
		String pageIdxResult = StringUtil.null2blank((String)paramMap.get("pageIdxResult"));
		
		if("".equals(pageIdxResult)){
		    currentPage = 0;
		    limitPage = 0;
		}else{
		    currentPage = (Integer.parseInt(pageIdxResult) - 1);
		    limitPage = ((Integer.parseInt(pageIdxResult) - 1) * sizePerPage);
		}
		paramMap.put("sizePerPage", sizePerPage);
		paramMap.put("limitPage", limitPage);		
		
		String user_no = mbrVo.getUser_no();
		paramMap.put("auth_no", user_no);			//결재자 사번 셋팅
		paramMap.put("user_no", user_no);			//결재자 사번 셋팅
		
		
		List<LeaveInfoBean> approvalList = null;
		int approvalListCnt = 0;				
			
		approvalList = sqlSession.selectList("topVacationMapper.selectLeaveApprovalResult", paramMap);
		approvalListCnt = sqlSession.selectOne("topVacationMapper.selectLeaveApprovalResultCnt", paramMap);
				
		PaginationInfo pageInfo = new PaginationInfo();			
		pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
		pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
		pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
		pageInfo.setTotalRecordCount(approvalListCnt);   				// 총 글 갯수
		
		model.addAttribute("pageInfo", pageInfo);
		
		model.addAttribute("approvalListCnt", approvalListCnt);		//결재해야할 건수
		model.addAttribute("approvalList", approvalList);
		
		//return "top_mbr_vacation/vacation_approval_result";
		return "top_mbr_leave/leave_approval_result";
	}
	
	/**
	 * 휴가(1종) 신규 결재화면 by top3009
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "vacationApprovalResult")
	public String vacationInfoResult(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= vacationApprovalResult(1) =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();		
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String srchApDateOrderTab2 = StringUtil.null2blank(request.getParameter("srchApDateOrderTab2"));
		if (srchApDateOrderTab2 == "") paramMap.put("srchApDateOrderTab2", "99");			//결재일 정렬 기준은 최초는 등록일 기준 (99:등록일기준, 결재일기준 : DESC, ASC)
		
		//===============================================
		// 페이지 관련 변수 선언
		//===============================================
		int sizePerPage = 20;       // 한페이지당 보여줄 글 갯수
		int sizePerBlock = 10;      // 페이지당 보여줄 블럭 갯수
		int currentPage = 0;        // 현재 페이지
		int limitPage = 0;          // sql limit

		//===============================================
		// 현재 페이지 세팅
		//===============================================
		String pageIdxResult = StringUtil.null2blank((String)paramMap.get("pageIdxResult"));
		
		if("".equals(pageIdxResult)){
		    currentPage = 0;
		    limitPage = 0;
		}else{
		    currentPage = (Integer.parseInt(pageIdxResult) - 1);
		    limitPage = ((Integer.parseInt(pageIdxResult) - 1) * sizePerPage);
		}
		paramMap.put("sizePerPage", sizePerPage);
		paramMap.put("limitPage", limitPage);		
		
		String user_no = mbrVo.getUser_no();
		paramMap.put("auth_no", user_no);			//결재자 사번 셋팅
		paramMap.put("user_no", user_no);			//결재자 사번 셋팅
		
		
		List<VacationInfoBean> approvalList = null;
		int approvalListCnt = 0;				
			
		approvalList = sqlSession.selectList("topVacationMapper.selectApprovalResult", paramMap);
		approvalListCnt = sqlSession.selectOne("topVacationMapper.selectApprovalResultCnt", paramMap);
				
		PaginationInfo pageInfo = new PaginationInfo();			
		pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
		pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
		pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
		pageInfo.setTotalRecordCount(approvalListCnt);   				// 총 글 갯수
		
		model.addAttribute("pageInfo", pageInfo);
		
		model.addAttribute("approvalListCnt", approvalListCnt);		//결재해야할 건수
		model.addAttribute("approvalList", approvalList);
		model.addAttribute("srchApDateOrderTab2", srchApDateOrderTab2);
		
		return "top_mbr_vacation/vacation_approval_result";
	}
	
	/**
	 * 휴가(1종) 신규 결재화면, 결재라인 변경으로 사용안함. by top3009
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "vacationApprovalResultBk")
	public String vacationInfoResultBk(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= vacationApprovalResultBk(1) =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();		
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		//===============================================
		// 페이지 관련 변수 선언
		//===============================================
		int sizePerPage = 20;       // 한페이지당 보여줄 글 갯수
		int sizePerBlock = 10;      // 페이지당 보여줄 블럭 갯수
		int currentPage = 0;        // 현재 페이지
		int limitPage = 0;          // sql limit

		//===============================================
		// 현재 페이지 세팅
		//===============================================
		String pageIdxResult = StringUtil.null2blank((String)paramMap.get("pageIdxResult"));
		
		if("".equals(pageIdxResult)){
		    currentPage = 0;
		    limitPage = 0;
		}else{
		    currentPage = (Integer.parseInt(pageIdxResult) - 1);
		    limitPage = ((Integer.parseInt(pageIdxResult) - 1) * sizePerPage);
		}
		paramMap.put("sizePerPage", sizePerPage);
		paramMap.put("limitPage", limitPage);		
		
		String user_no = mbrVo.getUser_no();
		paramMap.put("auth_no", user_no);			//결재자 사번 셋팅
		
		//결재해야할 카운트를 가져온다.
		int approvalCnt = 0;		//전체 결재해야 할 카운트
		int approval1Cnt = 0; 		//1차 결재해야하는 카운트
		int approval2Cnt = 0;		//2차 결재해야하는 카운트
		int approval3Cnt = 0;		//최종결재해야하는 카운트

		/*권한 정보 셋팅 : mbrAuthVo*/
		TopMbrAuthVO mbrAuthVo = sqlSession.selectOne("TopLoginMapper.getAuth", user_no);
		
		//1차 결재권한을 가지고 있는 팀을 가져온다.
		TopMbrAuthVO mbrVacationAuth = sqlSession.selectOne("TopLoginMapper.getVacationAuth", user_no);
		
		List<VacationInfoBean> approvalList = null;
		int approvalListCnt = 0;
		
		if( mbrVacationAuth != null) {
			
			String sTeamList1 = mbrVacationAuth.getLs_admin_vacation1();
			String sTeamList2 = mbrVacationAuth.getLs_admin_vacation2();
			
			//sql In절에 들어갈 팀 조건 string 을 만든다.
			sTeamList1 = WebUtil.makeInsqlString(sTeamList1,"\\|");
			sTeamList2 = WebUtil.makeInsqlString(sTeamList2,"\\|");
			
			
			if( !"".equals(sTeamList1) ){
				paramMap.put("teamlist1", sTeamList1);			
			}
			
			if( !"".equals(sTeamList2) ){
				paramMap.put("teamlist2", sTeamList2);
			}			
			
			approvalList = sqlSession.selectList("topVacationMapper.selectApprovalResult", paramMap);
			approvalListCnt = sqlSession.selectOne("topVacationMapper.selectApprovalResultCnt", paramMap);
		}
		
		//3차 결재 권한을 가지고 있는 경우 (실제 결재권한)
		String sChk = mbrAuthVo.getMbr_pms_28_v();
		
		//휴가정보 전체 조회권한이 있는 사용자
		String showAll = mbrAuthVo.getMbr_pms_28();
		
		if("1".equals(sChk)){
			approval3Cnt = sqlSession.selectOne("topVacationMapper.selectApproval3Cnt",paramMap);
			approvalCnt += approval3Cnt;
			
			//최종 결재 대기중인 값만 가져온다.
			approvalList = sqlSession.selectList("topVacationMapper.selectApprovalResultLast", paramMap);
			approvalListCnt = sqlSession.selectOne("topVacationMapper.selectApprovalResultLastCnt", paramMap);
		}
		
		//별도 카운트는 가져와야할때 가져오자..
		//model.addAttribute("approvalCnt", approvalCnt);
		
		PaginationInfo pageInfo = new PaginationInfo();			
		pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
		pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
		pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
		pageInfo.setTotalRecordCount(approvalListCnt);   				// 총 글 갯수
		
		model.addAttribute("pageInfo", pageInfo);
		
		model.addAttribute("approvalListCnt", approvalListCnt);		//결재해야할 건수
		model.addAttribute("approvalList", approvalList);
		
		return "top_mbr_vacation/vacation_approval_result";
	}

	/*
	*********************************************************
	* Program ID	: vacationInfoList
	* Program Name	: vacationInfoList
	* Description	: 휴가(신규) - 직원 휴가 정보 검색
	* Author		: 임대성
	* Date			: 2018.06.15
	*********************************************************
	*/
	@RequestMapping(value = "vacationInfoList")
	public String vacationInfoList(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= vacationInfoList =======");
		
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		String srchTeamId = StringUtil.null2blank(request.getParameter("srchTeamId"));
		String srchUserName = StringUtil.null2blank(request.getParameter("srchUserName"));
		
		if (srchTeamId == "") paramMap.put("srchTeamId", "0");
		if (srchUserName == "") paramMap.put("srchUserName", "");
		
		
	    //===============================================
	    //	권한체크
	    //===============================================
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	    TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
	    
	    
        //===============================================
        // 페이지 관련 변수 선언
        //===============================================
        int sizePerPage = 20;       // 한페이지당 보여줄 글 갯수
        int sizePerBlock = 10;      // 페이지당 보여줄 블럭 갯수
        int currentPage = 0;        // 현재 페이지
        int limitPage = 0;          // sql limit

        //===============================================
        // 현재 페이지 세팅
        //===============================================
        String pageIdx = StringUtil.null2blank((String)paramMap.get("pageIdx"));
        if("".equals(pageIdx)){
            currentPage = 0;
            limitPage = 0;
        }else{
            currentPage = (Integer.parseInt(pageIdx) - 1);
            limitPage = ((Integer.parseInt(pageIdx) - 1) * sizePerPage);
        }
        paramMap.put("sizePerPage", sizePerPage);
        paramMap.put("limitPage", limitPage);
		
	    String pms28 = mbrAuthVo.getMbr_pms_28();
	    
        //===============================================
        // 권한 처리
        //===============================================
	    if (  !("1".equals(pms28) || "4".equals(pms28) || !"9".equals(mbrVo.getUser_state())) ){
            return "redirect://";
        }
	    
    	Calendar cal = Calendar.getInstance();
    	int year = cal.get(Calendar.YEAR);
    	
    	paramMap.put("year", year);
	    paramMap.put("pms28", pms28);
	    
		List<VacationVo> vacationInfoList = sqlSession.selectList("topVacationMapper.selectVacationInfoList",paramMap);
		long vacationInfoListCnt = sqlSession.selectOne("topVacationMapper.selectVacationInfoListCnt",paramMap);
		
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        PaginationInfo pageInfo = new PaginationInfo();			
        pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
        pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
        pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
        pageInfo.setTotalRecordCount(vacationInfoListCnt);   			// 총 글 갯수      
        pageInfo.setPageName("info");
        

        for(VacationVo vo : vacationInfoList){
        	int vacationDayCnt = 11;
        	
			if (4 == vo.getTeamType()){
				Integer joinYear = Integer.parseInt(vo.getJoinDate().split("-")[0]);
				Integer joinMonth = Integer.parseInt(vo.getJoinDate().split("-")[1]);
				
/*				if (joinYear == cal.get(Calendar.YEAR) && joinMonth > 1){*/
				if (joinYear == cal.get(Calendar.YEAR)){
					vacationDayCnt = (11 - joinMonth > 0)? 11-joinMonth : 0;
				}
			}else{
				vacationDayCnt = 999;
			}
			vo.setVacationDayCnt(vacationDayCnt);
        }
        
        //===============================================
        // 뷰단 검색 옵션 세팅
        //===============================================      
    	//검색에 사용 되는 팀 목록 SELECT
		List<TopTmBscVO> teamList = sqlSession.selectList("topVacationMapper.teamListForSearch");
		
		model.addAttribute("infoParam",paramMap);
		model.addAttribute("teamList", teamList);
		
		model.addAttribute("vacationInfoList",vacationInfoList);
		model.addAttribute("vacationInfoListCnt",vacationInfoListCnt);
		
		model.addAttribute("pageInfo",pageInfo);
						
		return "top_mbr_vacation/vacation_info_list";
	}
	
	
	/**
	 * 휴가 상세 보기
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "myVacationModalDetail")	
	public String myVacationModalDetail(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= myVacationModalDetail =======");
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String,Object> returnMap = new HashMap<>();
			    
	    
	    String user_no = String.valueOf(paramMap.get("user_no"));	    
	    String vacation_date = String.valueOf(paramMap.get("vacation_date"));
	    	    
	    //System.out.println( user_no + " : "+vacation_date);
	    
	    paramMap.put("user_no", user_no);
	    paramMap.put("vacation_date", vacation_date);
	    
	    List<VacationInfoBean> detailList = sqlSession.selectList("topVacationMapper.selectVacationDetailMonth",paramMap);
	    
	    //System.out.println("detailList="+detailList.size());
	    
	    model.addAttribute("detailList", detailList);
	    model.addAttribute("vacation_date", vacation_date);
		
	    return "top_mbr_vacation/my_vacation_modal_detail";
	}
	
	@RequestMapping(value = "actionLeaveApproval")
	@ResponseBody
	public Map<String,Object> actionLeaveApproval(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= actionLeaveApproval =======");
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String,Object> returnMap = new HashMap<>();
		
	    TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();	    
	    String sAuth_user = mbrVo.getUser_name();			//결재자 이름
	    String sAuth_user_no = mbrVo.getUser_no();			//결재자 사번

	    String sAction = String.valueOf(paramMap.get("action"));	    
	    String sSerial_no =  String.valueOf(paramMap.get("serial_no"));
	    String sApproval_state = String.valueOf(paramMap.get("approval_state"));
	    String sLeave_type = String.valueOf(paramMap.get("leave_type"));
	    String sLeave_interval = String.valueOf(paramMap.get("leave_interval"));
	    String sAp_comment = String.valueOf(paramMap.get("ap_comment"));
	    String sUser_no = String.valueOf(paramMap.get("user_no"));			//신청자사번
	    String sDate = String.valueOf(paramMap.get("leave_sdate"));		//휴직 시작일자
	    String sApprovaler_now = "";						//현재결재자
	    
	    paramMap.put("leave_interval", sLeave_interval);	    
	    paramMap.put("user_no", sUser_no);
	    
	    String sApFlag = "";
	    //action : A (승인), C(반려)	, AC(승인취소)    
	    if("A".equals(sAction)) {//승인
	    	
	    	//결재 승인이면 최종결재 대기로 최종결재면 결재완료로 바꾼다.  
	    	if("10".equals(sApproval_state)) {
	    		sApFlag = "30";	    		
	    		paramMap.put("approvaler_01",sAuth_user_no);
	    		paramMap.put("ap_comment_01", sAp_comment);	    		
	    		returnMap.put("msg", "휴직 결재가 완료되었습니다.");
	    		//최종결재자 사번을 셋팅한다.
	    		List<VacationApprovalBean> approvalList3 = sqlSession.selectList("topVacationMapper.vacationLastApprovalList",paramMap);
	    		sApprovaler_now = approvalList3.get(0).getUser_no();
	    		
	    		paramMap.put("approvaler_now",sApprovaler_now);
	    		
	    	}else if("30".equals(sApproval_state)) {		//최종승인 대기인 경우는 최종승인 완료로 처리한다.
	    		sApFlag = "31";	    		
	    		paramMap.put("approvaler_03",sAuth_user_no);
	    		paramMap.put("ap_comment_03", sAp_comment);	    		
	    		returnMap.put("msg", "최종 휴직 결재가 완료되었습니다.");
	    	}
	    	
	    }else if("C".equals(sAction)){		//반려
	    	
	    	//1차반려, 2차반려, 최종반려의 경우 sApFlag 를 업데이트 한다.
	    	if("10".equals(sApproval_state)) {
	    		sApFlag = "12";	    		
	    		paramMap.put("approvaler_01",sAuth_user_no);
	    		paramMap.put("ap_comment_01", sAp_comment);	    		
	    		returnMap.put("msg", "휴직 결재가 반려되었습니다.");
	    	}else if("30".equals(sApproval_state)) {
	    		sApFlag = "32";	    		
	    		paramMap.put("approvaler_03",sAuth_user_no);
	    		paramMap.put("ap_comment_03", sAp_comment);	    		
	    		returnMap.put("msg", "최종 휴직 결재가 반려되었습니다.");
	    	}
	    	
	    }else if("AC".equals(sAction)){		//승인취소
	    	if("30".equals(sApproval_state)) {		//1차결재후 최종승인 대기상태	    		
	    		paramMap.put("serial_no",sSerial_no);
	    		paramMap.put("approvaler_now",sAuth_user_no);		//현재결재자를 1차결재자로 변경
	    		paramMap.put("approval_state", 10);
	    		sqlSession.update("topVacationMapper.updateLeaveInfoCancel_01", paramMap);	    		
	    		returnMap.put("msg", "결재가 취소되었습니다.");
	    	}else{			//최종결재상태
	    		//System.out.println("최종확인취소");
	    		paramMap.put("serial_no",sSerial_no);	    		
	    		paramMap.put("approval_state", 30);
	    		sqlSession.update("topVacationMapper.updateLeaveInfoCancel_03", paramMap);
	    		
	    		returnMap.put("msg", "최종확인이 취소되었습니다.");
	    	}
	    }
	    
	    //결재취소가 아닌경우만 처리한다.
	    if( !"AC".equals(sAction) ) {
	    	paramMap.put("approval_state", sApFlag);
	    	//결재정보 DB 업데이트
	    	sqlSession.update("topVacationMapper.updateLeaveApproval",paramMap);
	    }	    
	    
	    returnMap.put("result", "0000");
		
		return returnMap;
		
	}
	
	@RequestMapping(value = "actionVacationApproval")
	@ResponseBody
	public Map<String,Object> actionVacationApproval(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= actionVacationApproval =======");
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String,Object> returnMap = new HashMap<>();
		
	    TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();	    
	    String sAuth_user = mbrVo.getUser_name();			//결재자 이름
	    String sAuth_user_no = mbrVo.getUser_no();			//결재자 사번

	    String sAction = String.valueOf(paramMap.get("action"));	    
	    String sSerial_no =  String.valueOf(paramMap.get("serial_no"));
	    String sApproval_state = String.valueOf(paramMap.get("approval_state"));
	    String sVacation_type = String.valueOf(paramMap.get("vacation_type"));
	    String sVacation_interval = String.valueOf(paramMap.get("vacation_interval"));
	    String sAp_comment = String.valueOf(paramMap.get("ap_comment"));
	    String sUser_no = String.valueOf(paramMap.get("user_no"));			//신청자사번
	    String sDate = String.valueOf(paramMap.get("vacation_sdate"));		//휴가 시작일자
	    String sBase_date = sDate.substring(0,4)+"-01-01";
	    String sApprovaler_now = "";						//현재결재자	    
	    //System.out.println( sAuth_user+ " : " +sAction + " : " + sSerial_no + " : " + sApproval_state + " : "+ sVacation_type + " : "+ sVacation_interval + " : "+sUser_no+" :" +sAp_comment);
	    
	    String sRemainVacationUse = "";		//차감되고 남은 연차 수
	    
	    paramMap.put("vacation_interval", sVacation_interval);
	    paramMap.put("base_date", sBase_date);
	    paramMap.put("user_no", sUser_no);
	    	    
	  	//취소하는 휴가의 등록일 기준으로 연차 증감 수정 시작 
		String sReg_date = "";		
		VacationInfoBean vacationInfo = sqlSession.selectOne("topVacationMapper.selectVacationInfoOne",paramMap);		
		sReg_date = vacationInfo.getRegdate();		
		paramMap.put("reg_date", sReg_date);
		
		paramMap.put("updateChkDate", "2025-10-27");			//2025년 10월 27일 이후에 신청한 휴가에 대해서만 결재전 연차일수를 계산한다.
		
	    String sApFlag = "";
	    //action : A (승인), C(반려)	, AC(승인취소)    
	    if("A".equals(sAction)) {//승인
	    	
	    	//결재 승인이면 최종결재 대기로 최종결재면 결재완료로 바꾼다.
	    	/**
	    	if("10".equals(sApproval_state)) {
	    		sApFlag = "30";	    		
	    		paramMap.put("approvaler_01",sAuth_user_no);
	    		paramMap.put("ap_comment_01", sAp_comment);	    		
	    		returnMap.put("msg", "휴가 결재가 완료되었습니다.");
	    		//최종결재자 사번을 셋팅한다.
	    		List<VacationApprovalBean> approvalList3 = sqlSession.selectList("topVacationMapper.vacationLastApprovalList",paramMap);
	    		sApprovaler_now = approvalList3.get(0).getUser_no();
	    		
	    		paramMap.put("approvaler_now",sApprovaler_now);
	    		
	    	}else if("30".equals(sApproval_state)) {		//최종승인 대기인 경우는 최종승인 완료로 처리한다.
	    	**/
	    	if( "10".equals(sApproval_state) || "30".equals(sApproval_state) ) {		//결재 대기는 결재 처리 시 최종결재 상태로 변경 (1단계 결재방식으로 변경) 
	    		sApFlag = "31";	    		
	    		paramMap.put("approvaler_03",sAuth_user_no);
	    		paramMap.put("ap_comment_03", sAp_comment);
	    		returnMap.put("msg", "휴가 결재가 완료되었습니다.");
	    		
	    		//최종결재인경우 신청자의 신청일수 차감 후 휴가 사용일수 또는 연차사용일수를 추가한다.
		    	if( "100".equals(sVacation_type) || "200".equals(sVacation_type) || "210".equals(sVacation_type) ) {
		    		//신청수 감소
		    		sqlSession.update("topVacationMapper.updateVacationUseAnnualMinus", paramMap);
		    		sqlSession.update("topVacationMapper.updateVacationUseVacationMinus", paramMap);
		    		//사용수 증가
		    		sqlSession.update("topVacationMapper.updateVacationAnnualUsePlus", paramMap);
		    		sqlSession.update("topVacationMapper.updateVacationVacationUsePlus", paramMap);
		    		
		    		//현재 결재건 이후의 결재전 잔여일 갱신 시작
		    		//CommonUtils.printMap(paramMap);
		    		sqlSession.update("topVacationMapper.updateVacationApplyNextVacationByRemainUseCnt", paramMap);
		    		//현재 결재건 이후의 결재전 잔여일 갱신 끝
		    		
		    	}else {		//일반휴가인경우 총 휴가 신청 갯수에서만 빼준다.
		    		sqlSession.update("topVacationMapper.updateVacationUseVacationMinus", paramMap);
		    		sqlSession.update("topVacationMapper.updateVacationVacationUsePlus", paramMap);		    		
		    	}
	    	}
	    	
	    }else if("C".equals(sAction)){		//반려
	    	
	    	//1차반려, 2차반려, 최종반려의 경우 sApFlag 를 업데이트 한다.
	    	if("10".equals(sApproval_state)) {
	    		sApFlag = "12";	    		
	    		paramMap.put("approvaler_01",sAuth_user_no);
	    		paramMap.put("ap_comment_01", sAp_comment);	    		
	    		returnMap.put("msg", "휴가 결재가 반려되었습니다.");
	    	}else if("30".equals(sApproval_state)) {
	    		sApFlag = "32";	    		
	    		paramMap.put("approvaler_03",sAuth_user_no);
	    		paramMap.put("ap_comment_03", sAp_comment);
	    		returnMap.put("msg", "휴가 결재가 반려되었습니다.");
	    	}
	    	
	    	//반려처리 시 신청자의 신청중인 휴가일 차감 (신청취소와 동일하게 처리)	    	
	    	//연차,반차인경우는 기존 연차신청 갯수에서 빼준다. 
	    	if( "100".equals(sVacation_type) || "200".equals(sVacation_type) || "210".equals(sVacation_type) ) {
	    		sqlSession.update("topVacationMapper.updateVacationUseAnnualMinus", paramMap);
	    		sqlSession.update("topVacationMapper.updateVacationUseVacationMinus", paramMap);
	    	}else {		//일반휴가인경우 총 휴가 신청 갯수에서만 빼준다.
	    		sqlSession.update("topVacationMapper.updateVacationUseVacationMinus", paramMap);
	    	}
	    	
	    }else if("AC".equals(sAction)){		//승인취소
	    	
	    	paramMap.put("serial_no",sSerial_no);	    		
    		paramMap.put("approval_state", 30);
    		sqlSession.update("topVacationMapper.updateVacationInfoCancel_03", paramMap);
    		
    		//최종결재인경우 신청자의 신청일수 차감 후 휴가 사용일수 또는 연차사용일수를 추가한다.
	    	if( "100".equals(sVacation_type) || "200".equals(sVacation_type) || "210".equals(sVacation_type) ) {
	    		//연차사용수 감소		    		
	    		sqlSession.update("topVacationMapper.updateVacationAnnualUseMinus", paramMap);
	    		//휴가사용수 감소
	    		sqlSession.update("topVacationMapper.updateVacationVacationUseMinus", paramMap);
	    	}else {		//일반휴가인경우 총 휴가 신청 갯수에서만 빼준다.
	    		//휴가 사용수만 감소
	    		sqlSession.update("topVacationMapper.updateVacationVacationUseMinus", paramMap);		    		
	    	}
	    	
    		returnMap.put("msg", "휴가확인이 취소되었습니다.");
	    	
	    	/*	    	
	    	if("30".equals(sApproval_state)) {		//1차결재후 최종승인 대기상태
	    		paramMap.put("serial_no",sSerial_no);
	    		paramMap.put("approvaler_now",sAuth_user_no);		//현재결재자를 1차결재자로 변경
	    		paramMap.put("approval_state", 10);
	    		sqlSession.update("topVacationMapper.updateVacationInfoCancel_01", paramMap);	    		
	    		returnMap.put("msg", "결재가 취소되었습니다.");
	    	}else{			//최종결재상태	    		
	    		paramMap.put("serial_no",sSerial_no);	    		
	    		paramMap.put("approval_state", 30);
	    		sqlSession.update("topVacationMapper.updateVacationInfoCancel_03", paramMap);
	    		
	    		//최종결재인경우 신청자의 신청일수 차감 후 휴가 사용일수 또는 연차사용일수를 추가한다.
		    	if( "100".equals(sVacation_type) || "200".equals(sVacation_type) || "210".equals(sVacation_type) ) {
		    		//신청수 감소
		    		//sqlSession.update("topVacationMapper.updateVacationUseAnnualPlus", paramMap);
		    		//sqlSession.update("topVacationMapper.updateVacationUseVacationPlus", paramMap);
		    		//연차사용수 감소		    		
		    		sqlSession.update("topVacationMapper.updateVacationAnnualUseMinus", paramMap);
		    		//휴가사용수 감소
		    		sqlSession.update("topVacationMapper.updateVacationVacationUseMinus", paramMap);
		    	}else {		//일반휴가인경우 총 휴가 신청 갯수에서만 빼준다.
		    		//sqlSession.update("topVacationMapper.updateVacationUseVacationPlus", paramMap);
		    		//휴가 사용수만 감소
		    		sqlSession.update("topVacationMapper.updateVacationVacationUseMinus", paramMap);		    		
		    	}
	    		
	    		//returnMap.put("msg", "최종확인이 취소되었습니다.");
	    		returnMap.put("msg", "휴가확인이 취소되었습니다.");
	    	}
	    	*/
	    }
	    
	    //결재취소가 아닌경우만 처리한다.  (결재취소도 재계산처리)
	    //결재취소인 경우는 별도 처리한다. (신청 시점 이후 결재전 휴가 재계산처리)
	    if( "AC".equals(sAction) ) {
	    	
	    	//결재 취소 시 결재 전 잔여일 처리 시작	    		    	
	    	sqlSession.update("topVacationMapper.updateVacationManagerCancelByRemainUseCnt", paramMap);	    	
	    	//결재 취소 시 결재 전 잔여일 처리 끝
	    	//로그를 남기기 위한 현재결재자 추가
	    	sApprovaler_now = sqlSession.selectOne("topVacationMapper.selectApprovalerNowBySerialNo", sSerial_no);
	    	paramMap.put("approvaler_03", sApprovaler_now);
	    	
	    }else {
	    	paramMap.put("approval_state", sApFlag);
	    	//결재정보 DB 업데이트
	    	sqlSession.update("topVacationMapper.updateVacationNewApproval",paramMap);
	    		    	
	    	//top_vacation_info 의 remain_vacation_use 값 갱신 시작 (연차 신청자가 결재 대기중인 상태의 건이 있는경우 차감된 연차값으로 update)
    		
    		//결재 후 남은 연차수를 가져온다.
    		sRemainVacationUse = sqlSession.selectOne("topVacationMapper.selectVacationUseRemainCountByUserNo", paramMap);
    		paramMap.put("remain_vacation_use", sRemainVacationUse);
    		
    		//결재 대기 상태인 휴가 신청건의 remain_vacation_use 값을 갱신한다.
    		sqlSession.update("topVacationMapper.updateVacationInfoRemainVacationUseByUserNo",paramMap);    		
    		//top_vacation_info 의 remain_vacation_use 값 갱신 끝
	    }	    
	    //신청처리된 휴가일(시작일 기준)이 연차 발생 전/후 인 경우 별도로 동기화를 처리 시작 (선연차 또는 연차 발생 후 결재완료되는 경우)	    
	    
	    //현재 사용중인 연차 시작일, 종료일을 가져온다.
	    VacationUseBean nowVacationUse = sqlSession.selectOne("topVacationMapper.vacationUseListLast", paramMap);
	    
	    //휴가 시작일 sDate
	    int nStartVacationDate = Integer.parseInt( sDate.replaceAll("-", "") );
	    
	    int nStartAnuualSet = Integer.parseInt(nowVacationUse.getAnnual_start_date().replaceAll("-", ""));
	    int nEndAnnualSet = Integer.parseInt(nowVacationUse.getAnnual_end_date().replaceAll("-", ""));
	    
	    double dAnnualSet = nowVacationUse.getAnnual_set();
	    double dAnnualUse = nowVacationUse.getAnnual_use();
	    double dVacationInterval = Double.parseDouble(sVacation_interval);
	    
	    String sApprovalState = paramMap.get("approval_state").toString();	    
	    
	    //현재 사용중인 연차발생 이전 휴가 결재인 경우는 등록시점
	    if( nStartVacationDate < nStartAnuualSet &&  "31".equals(sApprovalState) ) {
	    	//이전 년도 연차 할당수와 사용수에 결재될 휴가 일수를 합산하여 비교한다.	    		    	
	    	userVacationSync( sUser_no );	    	
	    }else if( nStartVacationDate >= nStartAnuualSet &&  "31".equals(sApprovalState) ) {
	    	//선연차 여부만 확인한다.
	    	if( "100".equals(sVacation_type) || "200".equals(sVacation_type) || "210".equals(sVacation_type) ) {		//연차 반차 반반차 인경우	    		
	    		//if( dAnnualSet < (dAnnualUse+dVacationInterval) ) {
	    		if( dAnnualSet < dAnnualUse ) {			//휴가 사용이 DB에서 가져오기 전에 이미 추가 계산됨 
	    			sqlSession.update("topVacationMapper.updateVacationInfoNextUseBy1",paramMap);
	    		}
	    	}	    	
	    }
	    
	    //신청처리된 휴가일(시작일 기준)이 연차 발생 전/후 인 경우 별도로 동기화를 처리 끝 (선연차 또는 연차 발생 후 결재완료되는 경우)
	    
	    //휴가 결재, 취소, 반려관련 로그 남기기 시작	    
	    paramMap.put("logger_no", sAuth_user_no);
	    
	    sqlSession.insert("topVacationMapper.insertTopVacationApprovalLog", paramMap);
	    //휴가 결재, 취소, 반려관련 로그 남기기 끝
	    
	    returnMap.put("result", "0000");
		
		return returnMap;
		
	}
	
	/**
	 * 해당 사번으로 연차 다시 계산
	 * @param sUserNo
	 */
	public void userVacationSync( String sUserNo ) {
		
		Map<String,Object> paramMap = new HashMap<>();
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		
		String apUserNo = mbrVo.getUser_no();
		String sTargetUserNo = sUserNo;
		
		//연차 동기화 시작 (동기화 연차기준은 시작일 : 2020-11-10 이후 발생연차 부터 동기화)
		List<Map<String, Object>> vacationUseList = sqlSession.selectList("topVacationMapper.selectVacationUseListByUserNoToDate",sTargetUserNo);
		
		//입사일자
		String sJoinDate = sqlSession.selectOne("topVacationMapper.selectUserJoinDate", sTargetUserNo);
		
		//이름
		String sUserName = sqlSession.selectOne("topVacationMapper.selectUserName", sTargetUserNo);
		
		//연차 테이블 변수
		String sSerialNo = "";			//연차 키
		String sStartDate = "";			//기준 시작일
		String sEndDate = "";			//기준 종료일
		Double dAnnualSet = 0.0;		//기존 연차할당일
		Double dAnnualUse = 0.0;	//기존 연차사용일
		
		Double dNextAnnual = 0.0;	//이월연차
		int nTempAnnualSet = 0;
		
		for( int i = 0; i < vacationUseList.size(); i++) {
			
			//휴가사용 테이블 변수
			String sInfoSerialNo = "";		//휴가키
			Double dUseCount = 0.0;		//휴가사용일
			Double dSumUseCount = 0.0;	//휴가사용합계
			
			sSerialNo = vacationUseList.get(i).get("serial_no").toString();
			sStartDate = vacationUseList.get(i).get("annual_start_date").toString();
			sEndDate = vacationUseList.get(i).get("annual_end_date").toString();
			
			nTempAnnualSet = DateUtil.nCalYearVacation(sJoinDate, sStartDate);
			
			//기존에 연차가 계산되어 있는경우 (전년도 연차) 그대로 계산한다.
			if( i == 0 ) {			//첫번째 연차계산의경우
				dAnnualSet = Double.valueOf(vacationUseList.get(i).get("annual_set").toString());
			}else{
				dAnnualSet = (double)nTempAnnualSet;
			}
			
			/**
			if( nTempAnnualSet == 0 ) {
				dAnnualSet = Double.valueOf(vacationUseList.get(i).get("annual_set").toString());
			}else{
				dAnnualSet = (double)nTempAnnualSet;
			}
			**/
			
			dAnnualUse = Double.valueOf(vacationUseList.get(i).get("annual_use").toString());
			
			paramMap.put("user_no", sTargetUserNo);
			paramMap.put("annual_start_date", sStartDate);
			paramMap.put("annual_end_date", sEndDate);
			
			if( dNextAnnual < 0 ) {		//선연차 쓴 경우 총사용 값에 미리 더 해준다.  
				dSumUseCount = (dNextAnnual * -1);
			}else if( dNextAnnual > 0 ) {		//연차가 남은경우 할당량에 이월해준다.
				dAnnualSet += dNextAnnual;
			}
			
			//해당 연차에 사용한 휴가목록을 가져온다.
			List<Map<String, Object>> vacationInfoList = sqlSession.selectList("topVacationMapper.selectVacationInfoListByUserNoToDate", paramMap);
			
			for( int k = 0; k < vacationInfoList.size(); k++ ) {
				sInfoSerialNo = vacationInfoList.get(k).get("serial_no").toString();
				dUseCount = Double.parseDouble(vacationInfoList.get(k).get("use_count").toString());
				dSumUseCount += dUseCount;
				
				//선연차 플래그 갱신 (연차할당 보다 사용수가 크면 선연차로 표시)
				if( dAnnualSet < dSumUseCount ) {
					sqlSession.update("topVacationMapper.updateVacationInfoNextUseBy1",sInfoSerialNo);					
				}else {
					sqlSession.update("topVacationMapper.updateVacationInfoNextUseBy0",sInfoSerialNo);
				}				
			}
			
			paramMap.put("serial_no", sSerialNo);			
			
			//이월연차 = 할당연차 - 사용연차
			dNextAnnual = dAnnualSet - dSumUseCount;
				
			//연차사용 수 갱신
			paramMap.put("annual_set", dAnnualSet);
			paramMap.put("annual_use", dSumUseCount);
			paramMap.put("vacation_use", dSumUseCount);
				
			sqlSession.update("topVacationMapper.updateVacationUseBySync",paramMap);
				
		}				
		//연차 동기화 끝
		
		//별도 동기화시 이메일 시스템 로그에 남기기 시작
		Map<String,Object> logMap = new HashMap<>();
        
        logMap.put("user_no", sUserNo);
        logMap.put("manager_no", apUserNo);
        logMap.put("db_action", "reCal");
        
        sqlSession.insert("topVacationMapper.insertTopVacationActionLog", logMap);		
		//별도 동기화시 이메일 시스템 로그에 남기기 끝
		
		
		//이메일 발송시 함수 다수 호출시 지연문제가 있을수 있어 db에 로그로 남김
		
		//별도 동기화 처리 알림 이메일 발송 시작
		/**
		Sendmail sendmail = new Sendmail();
    	
    	String sFromName = "휴가알리미";    	
    	String sFromAddress = "webnotice@toplac.co.kr";
    	String sToAddress = "top3009@toplac.co.kr";
    	String sSubject = sUserName+" 님 연차 재계산 알림";
    	String sContent = "";
    	
    	sContent += "<table style='border-collapse:collapse;width:800px;font-size:12px;font-weight:bold;letter-spacing:1px;' border='1'>";
    	sContent += "<tr>";
    	sContent += "<th height='30' style='text-align: center;' bgcolor='#EFF5FB'>사번</th>"
				+ "<th height='30' style='text-align: center;' bgcolor='#EFF5FB'>이름</th>"
				+ "<th height='30' style='text-align: center;' bgcolor='#EFF5FB'>입사일자</th>";
		sContent += "</tr>";
		sContent += "<tr>";
		sContent += "<td height='30' style='text-align: center;'>"+sUserNo+"</td>";
		sContent += "<td height='30' style='text-align: center;'>"+sUserName+"</td>";
		sContent += "<td height='30' style='text-align: center;'>"+sJoinDate+"</td>";
		sContent += "</tr>";
    	sContent += "</table>";
    	
    	try {
			//알림메일 발송
			sendmail.send( sFromName, sFromAddress, sToAddress, sSubject, sContent, "", "" );
			logger.info("Vacation Sync Sendmail Submit : "+sUserNo);
		} catch (Exception e) {
			System.out.println("Vacation Sync Sendmail Error : "+e.getMessage());
		}
    	**/
		//별도 동기화 처리 알림 이메일 발송 끝
		
	}
	
	/**
	 * 3차결재 > 2차결재로 바뀌어 안씀.
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "actionVacationApproval_20191106")
	@ResponseBody
	public Map<String,Object> actionVacationApprovalBk(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= actionVacationApprovalBk =======");
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String,Object> returnMap = new HashMap<>();
		
	    TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();	    
	    String sAuth_user = mbrVo.getUser_name();			//결재자 이름
	    String sAuth_user_no = mbrVo.getUser_no();			//결재자 사번

	    String sAction = String.valueOf(paramMap.get("action"));	    
	    String sSerial_no =  String.valueOf(paramMap.get("serial_no"));
	    String sApproval_state = String.valueOf(paramMap.get("approval_state"));
	    String sVacation_type = String.valueOf(paramMap.get("vacation_type"));
	    String sVacation_interval = String.valueOf(paramMap.get("vacation_interval"));
	    String sAp_comment = String.valueOf(paramMap.get("ap_comment"));
	    String sUser_no = String.valueOf(paramMap.get("user_no"));			//신청자사번
	    String sDate = String.valueOf(paramMap.get("vacation_sdate"));		//휴가 시작일자
	    String sBase_date = sDate.substring(0,4)+"-01-01";
	    
	    //System.out.println( sAuth_user+ " : " +sAction + " : " + sSerial_no + " : " + sApproval_state + " : "+ sVacation_type + " : "+ sVacation_interval + " : "+sUser_no+" :" +sAp_comment);
	    
	    paramMap.put("vacation_interval", sVacation_interval);
	    paramMap.put("base_date", sBase_date);
	    paramMap.put("user_no", sUser_no);
	    
	    String sApFlag = "";
	    //action : A (승인), C(반려)	    
	    if("A".equals(sAction)) {//승인
	    	
	    	//1차 승인이면, 2차 승인대기로, 2차 승인이면 최종승인대기로 sApFlag를 업데이트 한다.
	    	if("10".equals(sApproval_state)) {
	    		sApFlag = "20";	    		
	    		paramMap.put("approvaler_01",sAuth_user_no);
	    		paramMap.put("ap_comment_01", sAp_comment);	    		
	    		returnMap.put("msg", "1차 휴가 결재가 완료되었습니다.");	    		
	    	}else if("20".equals(sApproval_state)) {
	    		sApFlag = "30";	    		
	    		paramMap.put("approvaler_02",sAuth_user_no);
	    		paramMap.put("ap_comment_02", sAp_comment);	    		
	    		returnMap.put("msg", "2차 휴가 결재가 완료되었습니다.");
	    	}else if("30".equals(sApproval_state)) {		//최종승인 대기인 경우는 최종승인 완료로 처리한다.
	    		sApFlag = "31";	    		
	    		paramMap.put("approvaler_03",sAuth_user_no);
	    		paramMap.put("ap_comment_03", sAp_comment);	    		
	    		returnMap.put("msg", "최종 휴가 결재가 완료되었습니다.");	    		
	    		
	    		//최종결재인경우 신청자의 신청일수 차감 후 휴가 사용일수 또는 연차사용일수를 추가한다.
		    	if( "100".equals(sVacation_type) || "200".equals(sVacation_type)) {
		    		//신청수 감소
		    		sqlSession.update("topVacationMapper.updateVacationUseAnnualMinus", paramMap);
		    		sqlSession.update("topVacationMapper.updateVacationUseVacationMinus", paramMap);
		    		//사용수 증가
		    		sqlSession.update("topVacationMapper.updateVacationAnnualUsePlus", paramMap);
		    		sqlSession.update("topVacationMapper.updateVacationVacationUsePlus", paramMap);		    		
		    	}else {		//일반휴가인경우 총 휴가 신청 갯수에서만 빼준다.
		    		sqlSession.update("topVacationMapper.updateVacationUseVacationMinus", paramMap);
		    		sqlSession.update("topVacationMapper.updateVacationVacationUsePlus", paramMap);		    		
		    	}
	    	}
	    	
	    }else if("C".equals(sAction)){		//반려
	    	
	    	//1차반려, 2차반려, 최종반려의 경우 sApFlag 를 업데이트 한다.
	    	if("10".equals(sApproval_state)) {
	    		sApFlag = "12";	    		
	    		paramMap.put("approvaler_01",sAuth_user_no);
	    		paramMap.put("ap_comment_01", sAp_comment);	    		
	    		returnMap.put("msg", "1차 휴가 결재가 반려되었습니다.");
	    	}else if("20".equals(sApproval_state)) {
	    		sApFlag = "22";	    		
	    		paramMap.put("approvaler_02",sAuth_user_no);
	    		paramMap.put("ap_comment_02", sAp_comment);	    		
	    		returnMap.put("msg", "2차 휴가 결재가 반려되었습니다.");
	    	}else if("30".equals(sApproval_state)) {
	    		sApFlag = "32";	    		
	    		paramMap.put("approvaler_03",sAuth_user_no);
	    		paramMap.put("ap_comment_03", sAp_comment);	    		
	    		returnMap.put("msg", "최종 휴가 결재가 반려되었습니다.");
	    	}
	    	
	    	//반려처리 시 신청자의 신청중인 휴가일 차감 (신청취소와 동일하게 처리)	    	
	    	//연차,반차인경우는 기존 연차신청 갯수에서 빼준다. 
	    	if( "100".equals(sVacation_type) || "200".equals(sVacation_type)) {
	    		sqlSession.update("topVacationMapper.updateVacationUseAnnualMinus", paramMap);
	    		sqlSession.update("topVacationMapper.updateVacationUseVacationMinus", paramMap);
	    	}else {		//일반휴가인경우 총 휴가 신청 갯수에서만 빼준다.
	    		sqlSession.update("topVacationMapper.updateVacationUseVacationMinus", paramMap);
	    	}
	    	
	    }
	    
	    paramMap.put("approval_state", sApFlag);
    	//결재정보 DB 업데이트
    	sqlSession.update("topVacationMapper.updateVacationNewApproval",paramMap);
	    
	    returnMap.put("result", "0000");
		
		return returnMap;
		
	}
	
	/*
	 * 체크박스를 이용한 관리자 일괄 결재
	 */
	@RequestMapping(value = "actionVacationApprovalChk")
	@ResponseBody
	public Map<String,Object> actionVacationApprovalChk(Model model, HttpServletRequest request, HttpSession session) throws Exception {
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String,Object> returnMap = new HashMap<>();
		
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	    
	    String[] vacationNoArr = request.getParameterValues("approvalVacationList");
	    
	    String apUserName = mbrVo.getUser_name();
	    String apUserNo = mbrVo.getUser_no();	    
	    String approvalState = "31";
	    String sVacationType = "";
	    String sUserNo = "";
	    String sRegDate = "";
	    String sVacationInterval = "";
	    String sDate = "";
	    
	    for(String vacationNo : vacationNoArr){
			paramMap.put("serial_no", vacationNo);
			paramMap.put("approval_state", approvalState);
			paramMap.put("approvaler_03", apUserNo);
			paramMap.put("ap_comment_03", "");
						
			//휴가 결재처리 시작
	    	VacationInfoBean vBean = sqlSession.selectOne("topVacationMapper.selectVacationInfoOne", paramMap);
	    	
	    	sUserNo = String.valueOf(vBean.getUser_no());
	    	sVacationType = String.valueOf(vBean.getVacation_type());
	    	sRegDate = String.valueOf(vBean.getRegdate());
	    	sVacationInterval = String.valueOf(vBean.getVacation_interval());
	    	sDate = String.valueOf(vBean.getSdate()).substring(0,10);	    	
	    	
	    	paramMap.put("user_no", sUserNo);
	    	paramMap.put("vacation_type", sVacationType);
	    	paramMap.put("reg_date", sRegDate);
	    	paramMap.put("vacation_interval",sVacationInterval);
	    	
	    	
	    	//최종결재인경우 신청자의 신청일수 차감 후 휴가 사용일수 또는 연차사용일수를 추가한다.
	    	if( "100".equals(sVacationType) || "200".equals(sVacationType) || "210".equals(sVacationType) ) {
	    		//신청수 감소
	    		sqlSession.update("topVacationMapper.updateVacationUseAnnualMinus", paramMap);
	    		sqlSession.update("topVacationMapper.updateVacationUseVacationMinus", paramMap);
	    		//사용수 증가
	    		sqlSession.update("topVacationMapper.updateVacationAnnualUsePlus", paramMap);
	    		sqlSession.update("topVacationMapper.updateVacationVacationUsePlus", paramMap);		    		
	    	}else {		//일반휴가인경우 총 휴가 신청 갯수에서만 빼준다.
	    		sqlSession.update("topVacationMapper.updateVacationUseVacationMinus", paramMap);
	    		sqlSession.update("topVacationMapper.updateVacationVacationUsePlus", paramMap);		    		
	    	}
	    	
	    	sqlSession.update("topVacationMapper.updateVacationNewApproval",paramMap);
	    	
	    	//신청처리된 휴가일(시작일 기준)이 연차 발생 전/후 인 경우 별도로 동기화를 처리 시작 (선연차 또는 연차 발생 후 결재완료되는 경우)	    
		    
	        //현재 사용중인 연차 시작일, 종료일을 가져온다.
	        VacationUseBean nowVacationUse = sqlSession.selectOne("topVacationMapper.vacationUseListLast", paramMap);
	        
	        //휴가 시작일 sDate
	        int nStartVacationDate = Integer.parseInt( sDate.replaceAll("-", "") );
	        
	        int nStartAnuualSet = Integer.parseInt(nowVacationUse.getAnnual_start_date().replaceAll("-", ""));
	        int nEndAnnualSet = Integer.parseInt(nowVacationUse.getAnnual_end_date().replaceAll("-", ""));
	        
	        double dAnnualSet = nowVacationUse.getAnnual_set();
	        double dAnnualUse = nowVacationUse.getAnnual_use();
	        double dVacationInterval = Double.parseDouble(sVacationInterval);
	        
	        String sApprovalState = paramMap.get("approval_state").toString();	    
	        
	        //현재 사용중인 연차발생 이전 휴가 결재인 경우는 등록시점
	        if( nStartVacationDate < nStartAnuualSet &&  "31".equals(sApprovalState) ) {
	        	//이전 년도 연차 할당수와 사용수에 결재될 휴가 일수를 합산하여 비교한다.	    		    	
	        	userVacationSync( sUserNo );	    	
	        }else if( nStartVacationDate >= nStartAnuualSet &&  "31".equals(sApprovalState) ) {
	        	//선연차 여부만 확인한다.
	        	if( "100".equals(sVacationType) || "200".equals(sVacationType) || "210".equals(sVacationType) ) {		//연차 반차 인경우
		    		if( dAnnualSet < dAnnualUse ) {			//휴가 사용이 DB에서 가져오기 전에 이미 추가 계산됨 
		    			sqlSession.update("topVacationMapper.updateVacationInfoNextUseBy1",paramMap);
		    		}
	    		}	    	
	        }	        
	        //신청처리된 휴가일(시작일 기준)이 연차 발생 전/후 인 경우 별도로 동기화를 처리 끝 (선연차 또는 연차 발생 후 결재완료되는 경우)
	        
	        //체크박스를 이용한 결재자 로그 남기기 시작
	        Map<String,Object> logMap = new HashMap<>();
	        
	        logMap.put("user_no", sUserNo);
	        logMap.put("manager_no", apUserNo);
	        logMap.put("db_action", "chkAp");
	        
	        sqlSession.insert("topVacationMapper.insertTopVacationActionLog", logMap);	        
	        //체크박스를 이용한 결재자 로그 남기기 끝
			//휴가 결재처리 끝			
		}	    
	    
		returnMap.put("msg", "처리완료되었습니다.");				
		
		return returnMap;		
	}
	
	
	@RequestMapping(value = "actionVacationAprv")
	@ResponseBody
	public Map<String,Object> actionVacationAprv(Model model, HttpServletRequest request, HttpSession session) throws Exception {
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String,Object> returnMap = new HashMap<>();
		
	    TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	    
	    String[] vacationNoArr = request.getParameterValues("vacationNo");

	    
	    paramMap.put("aprvUserNo", mbrVo.getUser_no());
	    paramMap.put("pms28", mbrAuthVo.getMbr_pms_28());
	    
		String action = String.valueOf(paramMap.get("action"));
		
		returnMap.put("result", "0000");
		if ("R".equals(action)){
			for(String vacationNo : vacationNoArr){
				paramMap.put("vacationNo", vacationNo);
				sqlSession.update("topVacationMapper.updateVacationReturn",paramMap);
			}
			returnMap.put("msg", "휴가 반려가 완료되었습니다.");
		}else if ("A".equals(action)){
			for(String vacationNo : vacationNoArr){
				paramMap.put("vacationNo", vacationNo);
				sqlSession.update("topVacationMapper.updateVacationApproval",paramMap);
			}
			returnMap.put("msg", "휴가 승인이 완료되었습니다.");
		}else if ("C".equals(action)){
			for(String vacationNo : vacationNoArr){
				paramMap.put("vacationNo", vacationNo);
				sqlSession.update("topVacationMapper.updateVacationCancel",paramMap);
			}
			returnMap.put("msg", "승인 취소가 완료되었습니다.");
		}
		
		return returnMap;
		
	}
	
	/*
	*********************************************************
	* Program ID	: leaveActionModal
	* Program Name	: leaveActionModal
	* Description	: 휴직 신청 및 수정 modal
	* Author		: Top3009
	* Date		: 2020.10.07
	*********************************************************
	*/
	@RequestMapping(value = "leaveActionModal")
	public String leaveActionModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= leaveActionModal =======");
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
	    //===============================================
	    //	권한체크
	    //===============================================
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();		
		
		if ("0".equals(mbrVo.getTeam_type())){
			paramMap.put("teamType", 1);
		}else{
			paramMap.put("teamType", mbrVo.getTeam_type());
		}
		paramMap.put("userNo",mbrVo.getUser_no());
		paramMap.put("user_no",mbrVo.getUser_no());
		paramMap.put("teamId",mbrVo.getTeam_id_main());
				
		paramMap.put("sTeamtype", paramMap.get("teamType").toString());
		paramMap.put("sTeamId", mbrVo.getTeam_id_main().toString());		

		
		//휴가 신청 기본정보 SELECT
		HashMap<String,Object> vacationInsBasicData = sqlSession.selectOne("topVacationMapper.selectVacationInsBasicData",paramMap);

		//기존 1차 결재자가 차상위 결재자로 변경됨
		String sApprovaler_01 = getVacationApprovalUserNo(mbrVo.getUser_no());
		
		String sApprovaler_name_01 = "";
		
		//최종결재자 (인사총무팀장: 인사관리의 최종결재자 표시여부 체크표시되어있는경우)
		List<VacationApprovalBean> approvalList3 = sqlSession.selectList("topVacationMapper.vacationLastApprovalList",paramMap);
		
		//인사총무팀장 사번
		String sInsaUserno = approvalList3.get(0).getUser_no();
		
		String sPassApproval = "0";
				
		//결재자정보추가, 임원, 부문장
		if("0".equals(sApprovaler_01)) {
			sApprovaler_01 = sInsaUserno;
			sPassApproval = "1";
		}else{				//결재자가 따로 있는 경우(팀원, 팀장, 센터장)
			sApprovaler_name_01 = sqlSession.selectOne("topVacationMapper.selectUserName",sApprovaler_01);
			sPassApproval = "0";			//1차 결재자가 있는 경우 이외에는 다 최종결재만 결재처리한다.			
		}		
		
		//4종의 경우 1차결재자를 전부 황명숙이사로 변경 by top3009 (2020.05.27 : 인사팀 요청사항)
		//시작
		if("4".equals(mbrVo.getTeam_type())) {
			sApprovaler_01 = "474";			
			sApprovaler_name_01 = "황명숙";
			if("474".contentEquals(mbrVo.getUser_no())){		//신청자가 황명숙 이사님인경우
				sPassApproval = "1";
			}
		}		
		//끝		
		
		model.addAttribute("approvaler_01", sApprovaler_01);						//결재자 사번		
		model.addAttribute("approvaler_name_01", sApprovaler_name_01);	//결재자 이름
		model.addAttribute("approvaler_03", sInsaUserno);						//인사총무팀장 결재자 사번
		model.addAttribute("pass_approval", sPassApproval);						//결재자유무 (1차)
		model.addAttribute("approvalList3", approvalList3);
		
		//휴가 신청종류 신규 SEL
		List<LeaveCode> vCodeList = sqlSession.selectList("topVacationMapper.selectLeaveCodeDetailList",paramMap);		
		model.addAttribute("vCodeList", vCodeList);
		
		model.addAttribute("srchParam",paramMap);
		model.addAttribute("vacationInsBasicData",vacationInsBasicData);		
		
		//return "top_mbr_vacation/vacation_action_modal_new";
		return "top_mbr_leave/leave_action_modal";
	}
	
	/*
	*********************************************************
	* Program ID	: vacationActionModalNew
	* Program Name	: vacationActionModalNew
	* Description	: 1종 신규휴가 신청 및 수정 modal
	* Author		: Top3009
	* Date		: 2019.05.13
	*********************************************************
	*/
	@RequestMapping(value = "vacationActionModalNew")
	public String vacationActionViewNew(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= vacationActionModalNew =======");
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String yearStr = StringUtil.null2blank(request.getParameter("year"));
		String monthStr = StringUtil.null2blank(request.getParameter("month"));
		
		int year, month;
        if ("".equals(yearStr)){
        	Calendar cal = Calendar.getInstance();
        	year = cal.get(Calendar.YEAR);
        	month = cal.get(Calendar.MONTH) + 1;
        }else{
        	year = Integer.parseInt(yearStr);
        	month = Integer.parseInt(monthStr);
        }
        
	    //===============================================
	    //	권한체크
	    //===============================================
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();		
		
		if ("0".equals(mbrVo.getTeam_type())){
			paramMap.put("teamType", 1);
		}else{
			paramMap.put("teamType", mbrVo.getTeam_type());
		}
		paramMap.put("userNo",mbrVo.getUser_no());
		paramMap.put("user_no",mbrVo.getUser_no());
		paramMap.put("teamId",mbrVo.getTeam_id_main());
		
		//1종인경우
		
		paramMap.put("year",year);
		paramMap.put("month",month);
		
		//System.out.println("team_type="+paramMap.get("teamType").toString());
				
		paramMap.put("sTeamtype", paramMap.get("teamType").toString());
		paramMap.put("sTeamId", mbrVo.getTeam_id_main().toString());
		
		//결재자 목록 불러오기 (전체)
		//List<VacationApprovalBean> approvalList = sqlSession.selectList("topVacationMapper.vacationApprovalList",paramMap);				
		//model.addAttribute("approvalList", approvalList);
		
		//휴가 신청 기본정보 SELECT
		HashMap<String,Object> vacationInsBasicData = sqlSession.selectOne("topVacationMapper.selectVacationInsBasicData",paramMap);

		//기존 1차 결재자가 차상위 결재자로 변경됨
		String sApprovaler_01 = getVacationApprovalUserNo(mbrVo.getUser_no());
		
		String sApprovaler_name_01 = "";
		
		//String sApprovaler_01 = getVacationApprovalUserNo("632");		//팀장		
		//String sApprovaler_01 = getVacationApprovalUserNo("16");		//센터장		
		//String sApprovaler_01 = getVacationApprovalUserNo("770");		//부문장 남윤
		//String sApprovaler_01 = getVacationApprovalUserNo("154");		//부문장 노경훈		
		//4종
		//String sApprovaler_01 = getVacationApprovalUserNo("1340");		//팀원
		//String sApprovaler_01 = getVacationApprovalUserNo("1760");		//팀장
		//String sApprovaler_01 = getVacationApprovalUserNo("805");		//센터장
		//String sApprovaler_01 = getVacationApprovalUserNo("474");		//총괄
		
		//System.out.println("sApprovaler_01="+sApprovaler_01);		
				
		//기존 휴가 결재자 체크
		//List<VacationApprovalBean> approvalList1 = sqlSession.selectList("topVacationMapper.vacationApprovalList1",paramMap);
		//List<VacationApprovalBean> approvalList2 = sqlSession.selectList("topVacationMapper.vacationApprovalList2",paramMap);
		
		//최종결재자 (인사총무팀장: 인사관리의 최종결재자 표시여부 체크표시되어있는경우)
		//List<VacationApprovalBean> approvalList3 = sqlSession.selectList("topVacationMapper.vacationApprovalList3",paramMap);
		List<VacationApprovalBean> approvalList3 = sqlSession.selectList("topVacationMapper.vacationLastApprovalList",paramMap);
		
		//인사총무팀장 사번
		String sInsaUserno = approvalList3.get(0).getUser_no();
		
		//System.out.println("sInsaUserno="+sInsaUserno);
		
		String sPassApproval = "0";
		
		//System.out.println("확인 : "+sApprovaler_01+" : "+sInsaUserno);
				
		//결재자정보추가, 임원, 부문장
		if("0".equals(sApprovaler_01)) {
			sApprovaler_01 = sInsaUserno;
			sPassApproval = "1";
		}else{				//결재자가 따로 있는 경우(팀원, 팀장, 센터장)
			sApprovaler_name_01 = sqlSession.selectOne("topVacationMapper.selectUserName",sApprovaler_01);
			sPassApproval = "0";			//1차 결재자가 있는 경우 이외에는 다 최종결재만 결재처리한다.			
		}		
		
		//model.addAttribute("approvalList1", approvalList1);
		//model.addAttribute("approvalList2", approvalList2);
		
		//System.out.println("결재자="+sApprovaler_01+" : "+sApprovaler_name_01);
		//System.out.println("최종결재="+sInsaUserno);
		//System.out.println("결재유무="+sPassApproval);
		
		//4종의 경우 1차결재자를 전부 황명숙이사로 변경 by top3009 (2020.05.27 : 인사팀 요청사항)
		//시작
		if("4".equals(mbrVo.getTeam_type())) {
			sApprovaler_01 = "474";			
			sApprovaler_name_01 = "황명숙";
			if("474".contentEquals(mbrVo.getUser_no())){		//신청자가 황명숙 이사님인경우
				sPassApproval = "1";
			}
		}		
		//끝		
		
		model.addAttribute("approvaler_01", sApprovaler_01);						//결재자 사번		
		model.addAttribute("approvaler_name_01", sApprovaler_name_01);	//결재자 이름
		model.addAttribute("approvaler_03", sInsaUserno);						//인사총무팀장 결재자 사번
		model.addAttribute("pass_approval", sPassApproval);						//결재자유무 (1차)
		model.addAttribute("approvalList3", approvalList3);
		
		// 사용한 휴가일수
		Double vacationUseCnt = sqlSession.selectOne("topVacationMapper.selectVacationUseCnt",paramMap);
		if (vacationUseCnt == null){
			vacationUseCnt = 0.0;		}		
		
		paramMap.put("vacationUseCnt", vacationUseCnt);		
		
		//휴가 신청 기본정보 SELECT
		//HashMap<String,Object> vacationInsBasicData = sqlSession.selectOne("topVacationMapper.selectVacationInsBasicData",paramMap);
		
		//휴가 신청종류 신규 SEL
		List<VacationCode> vCodeList = sqlSession.selectList("topVacationMapper.selectVacationCodeDetailList",paramMap);		
		model.addAttribute("vCodeList", vCodeList);		
		
		/* 조회시점 할당된 연차가져오기*/
		VacationUseBean vacationUseList = sqlSession.selectOne("topVacationMapper.vacationUseListLast",paramMap);

		model.addAttribute("vacation", vacationUseList);
		
		model.addAttribute("srchParam",paramMap);
		model.addAttribute("vacationInsBasicData",vacationInsBasicData);		
		
		return "top_mbr_vacation/vacation_action_modal_new";
	}
	
	/*
	*********************************************************
	* Program ID	: vacationActionModal
	* Program Name	: vacationActionModal
	* Description	: 휴가 신청 및 수정 modal
	* Author		: 임대성
	* Date			: 2018.06.11
	*********************************************************
	*/
	@RequestMapping(value = "vacationActionModal")
	public String vacationActionView(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= vacationActionModal =======");
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String yearStr = StringUtil.null2blank(request.getParameter("year"));
		String monthStr = StringUtil.null2blank(request.getParameter("month"));
		
		int year, month;
        if ("".equals(yearStr)){
        	Calendar cal = Calendar.getInstance();
        	year = cal.get(Calendar.YEAR);
        	month = cal.get(Calendar.MONTH) + 1;
        }else{
        	year = Integer.parseInt(yearStr);
        	month = Integer.parseInt(monthStr);
        }
        
	    //===============================================
	    //	권한체크
	    //===============================================
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		/*
	    TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
	    */
		
		if ("0".equals(mbrVo.getTeam_type())){
			paramMap.put("teamType", 1);
		}else{
			paramMap.put("teamType", mbrVo.getTeam_type());
		}
		paramMap.put("userNo",mbrVo.getUser_no());
		paramMap.put("teamId",mbrVo.getTeam_id_main());
		
		paramMap.put("year",year);
		paramMap.put("month",month);
		
		// 총 휴가일수
		/* 4종 요청에 따라 변경..
		Integer vacationDayCnt = sqlSession.selectOne("topVacationMapper.selectVacationDayCnt",paramMap);	//보종별
		//개인별 입력한 날짜가 없을 경우 보종별 입력일자 적용
		if (vacationDayCnt == null){
			vacationDayCnt = 15;
		}
		*/
		
		int vacationDayCnt = 0;
		if ("4".equals(mbrVo.getTeam_type())){
			Calendar cal = Calendar.getInstance();
			Integer joinYear = Integer.parseInt(mbrVo.getJoin_date().split("-")[0]);
			Integer joinMonth = Integer.parseInt(mbrVo.getJoin_date().split("-")[1]);
			
			//vacationDayCnt = 7;
			vacationDayCnt = 11;			//휴가일수 오류로 인한 수정 by top3009 2019.04.01
			if (joinYear == cal.get(Calendar.YEAR) && joinMonth > 6){
				vacationDayCnt = (11 - joinMonth > 0)? 11-joinMonth : 0;
			}
		}else{
			vacationDayCnt = 999;
		}		
		
		// 사용한 휴가일수
		Double vacationUseCnt = sqlSession.selectOne("topVacationMapper.selectVacationUseCnt",paramMap);
		if (vacationUseCnt == null){
			vacationUseCnt = 0.0;
		}
		
		paramMap.put("vacationDayCnt", vacationDayCnt);
		paramMap.put("vacationUseCnt", vacationUseCnt);
		
		
		//휴가 신청 기본정보 SELECT
		HashMap<String,Object> vacationInsBasicData = sqlSession.selectOne("topVacationMapper.selectVacationInsBasicData",paramMap);
		
		//휴가 종류 SELECT
        SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();
        codeVo.setTbl_nm("top_mbr_vacation");
        codeVo.setCol_nm("vacation_kind");
        List<SysAdmCodeDicVO> vacationKindList = CodeDicService.codeList(codeVo);
		
		model.addAttribute("srchParam",paramMap);
		model.addAttribute("vacationKindList",vacationKindList);
		model.addAttribute("vacationInsBasicData",vacationInsBasicData);
		
		
		return "top_mbr_vacation/vacation_action_modal";
	}
	
	/**
	 * 신규 직원 휴가내역 조회 Modal 
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 * @author by top3009
	 */
	
	@RequestMapping(value = "vacationUserInfoNewModal")
	public String vacationUserInfoNewModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= vacationUserInfoNewModal =======");
		
	    //===============================================
	    //	파라미터 체크
	    //===============================================
						
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String user_no = request.getParameter("user_no") != null ? request.getParameter("user_no") : "";						//휴가조회 대상자 사번
		String user_name = request.getParameter("user_name") != null ? request.getParameter("user_name") : "";			//휴가조회 대상자 이름
		String start_date = request.getParameter("start_date") != null ? request.getParameter("start_date") : "";			//휴가조회 시작일
		String end_date = request.getParameter("end_date") != null ? request.getParameter("end_date") : "";				//휴가조회 종료일
		
		paramMap.put("user_no", user_no);
		paramMap.put("limitPage", 0);
		paramMap.put("sizePerPage", 1000);		//한페이지에서 다보여줘야하므로 무제한 1000개로 설정
		
		//String searchEndDate = DateUtil.addDateNew(end_date, 1);			//종료검색조건에 하루를 더해줘야 함 (ex: 2019-11-11 00:00:00 으로 쿼리에서 인식함)
		String searchEndDate = end_date;			//종료검색조건(사용종기) 날짜가 하루 감소하여 값을 그대로 넣어준다. by top3009 2020-01-22		
		
		paramMap.put("searchStartDate", start_date);
		paramMap.put("searchEndDate", searchEndDate);		//사용종기가 하루 줄어야함으로 위에 searchEndDate 변수는 쓰지 않는다. 				
				
		
		//List<VacationInfoBean> vacationList = sqlSession.selectList("topVacationMapper.selectVacationInfoNewList",paramMap);
		List<VacationInfoBean> vacationList = sqlSession.selectList("topVacationMapper.selectVacationInfoNewListPopup",paramMap);
		
		//전년도 선연차 사용분 표시를 위한 목록
		String beforeStartDate = DateUtil.beforeYear(start_date, 1);
		String beforeEndDate = DateUtil.beforeYear(searchEndDate, 1);		
		
		paramMap.put("beforeStartDate", beforeStartDate);
		paramMap.put("beforeEndDate", beforeEndDate);
		
		List<VacationInfoBean> beforeVacationList = sqlSession.selectList("topVacationMapper.selectVacationInfoNewListPopupBefore",paramMap);
		
		model.addAttribute("user_name", user_name);
		model.addAttribute("start_date", start_date);
		model.addAttribute("end_date", end_date);
		model.addAttribute("vacationList", vacationList);
		model.addAttribute("beforeVacationList", beforeVacationList);		
		
		return "top_mbr_vacation/vacation_userinfo_new_modal";
	}
	
	/**
	 * 현재 휴직 결재자 수정
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	
	@RequestMapping(value = "/updateLeaveApprovalNow", method = RequestMethod.POST)
	@ResponseBody
	public int updateLeaveApprovalNow(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= updateLeaveApprovalNow =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);		
        
        int nRet = 0;
        
        nRet = sqlSession.update("topVacationMapper.updateLeaveApprovalerNow", paramMap);
        
		return nRet;		
	}
	
	/**
	 * 현재 결재자 수정
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	
	@RequestMapping(value = "/updateVacationApprovalNow", method = RequestMethod.POST)
	@ResponseBody
	public int updateVacationApprovalNow(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= updateVacationApprovalNow =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
        
        int nRet = 0;
        
        nRet = sqlSession.update("topVacationMapper.updateVacationApprovalerNow", paramMap);
        
		return nRet;		
	}
	
	/**
	 * 현재 휴직 결재자 수정 페이지
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 * @author by top3009
	 */
	
	@RequestMapping(value = "leaveUpdateApprovalModal")
	public String leaveUpdateApprovalModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= leaveUpdateApprovalModal =======");
						
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		LeaveInfoBean vBean = sqlSession.selectOne("topVacationMapper.selectLeaveInfoDetail", paramMap);
		
		// 직원리스트 가져오기
		List<TopTmBscVO> memberList = sqlSession.selectList("StatisticBasic.selectTopMemberList", paramMap);
		
		model.addAttribute("approval_now", vBean.getApprovaler_now());
		model.addAttribute("leaveInfo", vBean);
		model.addAttribute("memberList", memberList);

		//return "top_mbr_vacation/vacation_update_approval_modal";
		return "top_mbr_leave/leave_update_approval_modal";
	}
	
	/**
	 * 현재 결재자 수정 페이지
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 * @author by top3009
	 */
	
	@RequestMapping(value = "vacationUpdateApprovalNowModal")
	public String vacationUpdateApprovalNowModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= vacationUpdateApprovalNowModal =======");
						
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		VacationInfoBean vBean = sqlSession.selectOne("topVacationMapper.selectVacationInfoDetail", paramMap);
		
		// 직원리스트 가져오기
		List<TopTmBscVO> memberList = sqlSession.selectList("StatisticBasic.selectTopMemberList", paramMap);
		
		model.addAttribute("approval_now", vBean.getApprovaler_now());
		model.addAttribute("vacationInfo", vBean);
		model.addAttribute("memberList", memberList);

		return "top_mbr_vacation/vacation_update_approval_modal";
	}
	
	
	@RequestMapping(value = "leaveDetailManagerModal")
	public String leaveDetailManagerModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= leaveDetailManagerModal =======");
		
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();		
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();		
						
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sViewType = String.valueOf(paramMap.get("view_type"));		//상세보기 여부 플래그		
		
		LeaveInfoBean vBean = sqlSession.selectOne("topVacationMapper.selectLeaveInfoDetail", paramMap);
		
		
		//결재상태
		int nApprovalstate = vBean.getApproval_state();
		//1차결재자
		int nArpprovaler_01 = vBean.getApprovaler_01();
		
		//신청취소가능여부 
		int nCancelAuth = 0;		
		
		//최종결재완료 전이면서 결재자가 물,인보험 기획팀인경우만 신청 취소가능
		if( nApprovalstate == 30 ) {
			if( nArpprovaler_01 == 99991 || nArpprovaler_01 == 99994 ) {
				nCancelAuth = 1;
			}
		}		
		
		model.addAttribute("cancel_auth", nCancelAuth);
		model.addAttribute("view_type", sViewType);
		model.addAttribute("leaveInfo", vBean);		

		return "top_mbr_leave/leave_detail_manager_modal";
	}
	
	/**
	 * 관리자 신규 휴가 결재 상세페이지 
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 * @author by top3009
	 */
	
	@RequestMapping(value = "vacationDetailManagerNewModal")
	public String vacationDetailManagerNewModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= vacationDetailManagerNewModal =======");
		
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();		
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();		
						
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sViewType = String.valueOf(paramMap.get("view_type"));		//상세보기 여부 플래그
		
		VacationInfoBean vBean = sqlSession.selectOne("topVacationMapper.selectVacationInfoDetail", paramMap);
		
		//휴가신청자 연차할당내역 조회
		paramMap.put("user_no", vBean.getUser_no());
		VacationUseBean useBean = sqlSession.selectOne("topVacationMapper.vacationUseListLast", paramMap);		
				
		//휴가 신청 취소 표시추가	
		//결재상태
		int nApprovalstate = vBean.getApproval_state();
		//1차결재자
		int nArpprovaler_01 = vBean.getApprovaler_01();
		
		//System.out.println( nApprovalstate+ " : "+ nArpprovaler_01 );
		
		//신청취소가능여부 
		int nCancelAuth = 0;
		
		//최종결재완료 전이면서 결재자가 물,인보험 기획팀인경우만 신청 취소가능
		if( nApprovalstate == 30 ) {
			if( nArpprovaler_01 == 99991 || nArpprovaler_01 == 99994 ) {
				nCancelAuth = 1;
			}
		}
		
		//결재취소는 필요없음
		model.addAttribute("cancel_auth", nCancelAuth);
		model.addAttribute("view_type", sViewType);
		model.addAttribute("vacationInfo", vBean);
		model.addAttribute("vacationUse", useBean);
		
		//return "top_mbr_vacation/vacation_detail_new_modal";
		return "top_mbr_vacation/vacation_detail_manager_new_modal";
	}
	
	/**
	 * 휴직 결재 상세페이지 
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 * @author by top3009
	 */
	
	@RequestMapping(value = "leaveDetailModal")
	public String leaveDetailModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= leaveDetailModal =======");
		
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();		
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();		
						
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sViewType = String.valueOf(paramMap.get("view_type"));		//상세보기 여부 플래그
		
		//VacationInfoBean vBean = sqlSession.selectOne("topVacationMapper.selectVacationInfoDetail", paramMap);
		LeaveInfoBean vBean = sqlSession.selectOne("topVacationMapper.selectLeaveInfoDetail", paramMap);
				
		//결재취소 표시추가
		//최종 결재 권한을 가지고 있는 경우
		String sChk = mbrAuthVo.getMbr_pms_28_v();
		String userNo = mbrVo.getUser_no();			//사용자 사번
		int nUser_no = Integer.parseInt(userNo);		//사용자 사번
		
		//결재상태
		int nApprovalstate = vBean.getApproval_state();
		//1차결재자
		int nArpprovaler_01 = vBean.getApprovaler_01();	
		
		//결재취소 권한 
		int nCancelAuth = 0;
		
		//최종승인 이면서 최종 확인권한이 있는경우는 결재완료상태에서 취소할수 있음		
		if( nApprovalstate == 31 &&  "1".equals(sChk)) {
			nCancelAuth = 1;
		}else if( nApprovalstate == 30 && nUser_no == nArpprovaler_01) {			//1차결재완료 상태이면서 결재자가 자기 자신인 경우
			nCancelAuth = 1;
		}else{
			nCancelAuth = 0;
		}
		
		model.addAttribute("cancel_auth", nCancelAuth);
		model.addAttribute("view_type", sViewType);
		model.addAttribute("leaveInfo", vBean);		
		
		//return "top_mbr_vacation/vacation_detail_new_modal";
		return "top_mbr_leave/leave_detail_modal";
	}
	
	/**
	 * 신규 휴가 결재 상세페이지 
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 * @author by top3009
	 */
	
	@RequestMapping(value = "vacationDetailNewModal")
	public String vacationDetailNewModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= vacationDetailNewModal =======");
		
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();		
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();		
						
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sViewType = String.valueOf(paramMap.get("view_type"));		//상세보기 여부 플래그
		
		VacationInfoBean vBean = sqlSession.selectOne("topVacationMapper.selectVacationInfoDetail", paramMap);
		
		//휴가신청자 연차할당내역 조회
		paramMap.put("user_no", vBean.getUser_no());
		VacationUseBean useBean = sqlSession.selectOne("topVacationMapper.vacationUseListLast", paramMap);		
				
		//결재취소 표시추가
		//최종 결재 권한을 가지고 있는 경우
		String sChk = mbrAuthVo.getMbr_pms_28_v();
		String userNo = mbrVo.getUser_no();			//사용자 사번
		int nUser_no = Integer.parseInt(userNo);		//사용자 사번
		
		//결재상태
		int nApprovalstate = vBean.getApproval_state();
		//1차결재자
		int nArpprovaler_01 = vBean.getApprovaler_01();	
		
		//결재취소 권한 
		int nCancelAuth = 0;
		
		//최종승인 이면서 최종 확인권한이 있는경우는 결재완료상태에서 취소할수 있음		
		if( nApprovalstate == 31 &&  "1".equals(sChk) ) {
			nCancelAuth = 1;
		}else if( nApprovalstate == 30 && nUser_no == nArpprovaler_01 ) {			//1차결재완료 상태이면서 결재자가 자기 자신인 경우
			nCancelAuth = 1;
		}else{
			nCancelAuth = 0;
		}
		
		model.addAttribute("cancel_auth", nCancelAuth);
		model.addAttribute("view_type", sViewType);
		model.addAttribute("vacationInfo", vBean);
		model.addAttribute("vacationUse", useBean);
		
		return "top_mbr_vacation/vacation_detail_new_modal";
	}
	
	/*
	*********************************************************
	* Program ID	: vacationDetailModal
	* Program Name	: vacationDetailModal
	* Description	: 휴가 상세보기 MODAL
	* Author		: 임대성
	* Date			: 2018.06.15
	*********************************************************
	*/
	@RequestMapping(value = "vacationDetailModal")
	public String vacationDetailModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= vacationDetailModal =======");
		
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		paramMap.put("gubun", "detail");
		VacationVo vacationVo = sqlSession.selectOne("topVacationMapper.selectVacationList",paramMap);
		
		String userNo = String.valueOf(vacationVo.getUserNo());
		String teamType = String.valueOf(vacationVo.getTeamType());
		
		String[] vacationStartDate = String.valueOf(vacationVo.getVacationStartDate()).split("-");
		int year = Integer.parseInt(vacationStartDate[0]);
		int month = Integer.parseInt(vacationStartDate[1]);
		
		paramMap.put("userNo", userNo);
		paramMap.put("teamType", teamType);
		paramMap.put("year", year);
		paramMap.put("month", month);
		
        // 달력 생성
		ArrayList<Map<String,Object>> dsCalendar = CalendarUtil.makeCalendar(year,month,sqlSession);
		
		//휴가 신청 내역 추가
		for (Map<String,Object> calendar : dsCalendar){
			int monthDay = Integer.parseInt(""+calendar.get("monthDay"));
			if ( calendar.get("year").equals(vacationVo.getYear())
				 && (vacationVo.getStartMonthDay() <= monthDay && monthDay <= vacationVo.getEndMonthDay())){
				String vacationTitle = vacationVo.getVacationStateValue() +"<br/>"+vacationVo.getVacationKindValue() +"<br/>"+  vacationVo.getVacationStartDate() + " ~ " +vacationVo.getVacationEndDate() +"<br/>"+ vacationVo.getVacationComment();
				calendar.put("vacationTitle", vacationTitle);
				calendar.put("vacationDay", "Y");
			}else{
				calendar.put("vacationDay", "N");
			}
		}
		
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("srchParam",paramMap);
		model.addAttribute("calendar", dsCalendar);
		model.addAttribute("vacationVo",vacationVo);
		
		
		return "top_mbr_vacation/vacation_detail_modal";
	}
	
	
	
	/*
	*********************************************************
	* Program ID	: 휴가 첨부파일 다운로드
	* Program Name	: 휴가 첨부파일 다운로드
	* Description	: 게시글 파일 다운로드
	* Author		: 임대성
	* Date			: 2017.12.01
	*********************************************************
	*/    
	
	@RequestMapping(value = "vacationFileDown")
    public void vacationFileDown(HttpServletRequest request, HttpServletResponse response){
    	
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);    	
    	
		paramMap.put("gubun", "detail");
		VacationVo vacationVo = sqlSession.selectOne("topVacationMapper.selectVacationList",paramMap);

		String origFilename = vacationVo.getVacationOrgFile();
    	String encFilename = vacationVo.getVacationEncFile();
    	
    	
		try {
			origFilename = java.net.URLEncoder.encode(origFilename,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		response.setHeader("Content-Disposition","attachment;filename="+origFilename);
		
    	String uploadPath = "/home/hosting_users/toplac/www/ls_data/vacation/"+paramMap.get("vacationNo")+"/";
    	String fullPath = uploadPath + encFilename;
		
		ServletOutputStream sout;
		
		try {
			sout = response.getOutputStream();
			FileInputStream fin = new FileInputStream(fullPath);
			byte[] buf = new byte[1024];
			int size=0;
			while((size=fin.read(buf,0,1024))!=-1){
				sout.write(buf,0,size);
			}
			sout.flush();
			fin.close();
			sout.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
	/**
	 * 신규 휴가 파일 다운로드 by top3009
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "vacationFileDownNew")
    public void vacationFileDownNew(HttpServletRequest request, HttpServletResponse response){
    	
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		//System.out.println("serial_no="+paramMap.get("serial_no").toString());
				
		VacationInfoBean vBean = sqlSession.selectOne("topVacationMapper.selectVacationInfoOne", paramMap);

		String orgFilename = vBean.getVacation_org_file();
		String encFilename = vBean.getVacation_enc_file();
    	
		try {
			orgFilename = java.net.URLEncoder.encode(orgFilename,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		response.setHeader("Content-Disposition","attachment;filename="+orgFilename);
    	
    	//운영
		String uploadPath = "/home" + File.separator + "hosting_users" + File.separator + "toplac"
				+ File.separator + "www" + File.separator + "ls_data" + File.separator + "vacation_new"+File.separator;

		//개발
		//String uploadPath = "D:\\home" + File.separator + "hosting_users" + File.separator + "toplac"
		//		+ File.separator + "www" + File.separator + "ls_data" + File.separator + "vacation_new"+File.separator;
		
    	String fullPath = uploadPath + encFilename;
		
		ServletOutputStream sout;
		
		try {
			sout = response.getOutputStream();
			FileInputStream fin = new FileInputStream(fullPath);
			byte[] buf = new byte[1024];
			int size=0;
			while((size=fin.read(buf,0,1024))!=-1){
				sout.write(buf,0,size);
			}
			sout.flush();
			fin.close();
			sout.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
	
	public void vacationFileDeleteNew(Map<String,Object> paramMap){
    			
		VacationInfoBean vBean = sqlSession.selectOne("topVacationMapper.selectVacationInfoOne", paramMap);
    	
		if (vBean != null){			
			
	    	String encFilename = vBean.getVacation_enc_file();
	    	
	    	//운영
			String uploadPath = "/home" + File.separator + "hosting_users" + File.separator + "toplac"
					+ File.separator + "www" + File.separator + "ls_data" + File.separator + "vacation_new"+File.separator;

			//개발
			//String uploadPath = "D:\\home" + File.separator + "hosting_users" + File.separator + "toplac"
			//		+ File.separator + "www" + File.separator + "ls_data" + File.separator + "vacation_new"+File.separator;
			
	    	String fullPath = uploadPath + encFilename;
						
			
			File file = new File(fullPath);
			if(file.exists() == true){
				file.delete();
			}
		}
    		
    }
	
    public void vacationFileDelete(Map<String,Object> paramMap){
    	
		paramMap.put("gubun", "detail");
		VacationVo vacationVo = sqlSession.selectOne("topVacationMapper.selectVacationList",paramMap);
    	
		if (vacationVo != null){
			
			String origFilename = vacationVo.getVacationOrgFile();
	    	String encFilename = vacationVo.getVacationEncFile();
	    	
	    	String uploadPath = "/home/hosting_users/toplac/www/ls_data/vacation/"+paramMap.get("vacationNo")+"/";
	    	String fullPath = uploadPath + encFilename;
						
			
			File file = new File(fullPath);
			if(file.exists() == true){
				file.delete();
			}
		}
    		
    }
    
    /**
     * 휴가 결재자 정보 가져오기
     * @param nUserNo
     * @return 팀원 > 팀장, 팀장 > 센터장, 센터장 > 부분장
     */
    
    public String getVacationApprovalUserNo(String sUserNo) {
    	String nApprovaler = "";
    	String sTeam_id = "";
    	//부문장정보를 가져온다.
		String sSector = "";
    	
    	nApprovaler = sqlSession.selectOne("topVacationMapper.selectTeamManagerUserNo",sUserNo);
    	
    	if("0".equals(nApprovaler) || "770".equals(sUserNo) || "360".equals(sUserNo) || "154".equals(sUserNo) || "474".equals(sUserNo)) {		//임원인 경우 (부문장도 임원으로 처리)
    		nApprovaler = "0";
    	}else if(nApprovaler.equals(sUserNo)){			//팀장이상인 경우    		    		
    		nApprovaler = sqlSession.selectOne("topVacationMapper.selectCenterManagerUserNo",sUserNo);		//센터장 정보를 결재자에 넣어준다.
    		
    		sTeam_id = sqlSession.selectOne("topVacationMapper.selectTeamId", sUserNo);
    		
    		if(nApprovaler.equals(sUserNo)) {			//센터장인 경우 부문장정보를 결재자정보에 넣어준다.
    			/**
    			 * 지방센터장인 경우는 별도로 처리한다. (2020.07.09 ) by top3009
    			 * 지방(충청,대구,호남,재물센터)센터의 경우 정책부문장으로 결재자를 고정한다.
    			 * (78, 79, 122, 206)
    			 */
    			
    			//if( "78".equals(sTeam_id) || "79".equals(sTeam_id) || "122".equals(sTeam_id) || "206".equals(sTeam_id) ) {
    			//충청:78, 부산:79 > 정책부문에서 제외 (2020.12.16) by top3009
    			if( "122".equals(sTeam_id) || "206".equals(sTeam_id) ) {
    				//정책부문값 (1)
    				sSector = "1";
    			}else{    				    			
        			sSector = sqlSession.selectOne("topVacationMapper.selectSectorNo",sUserNo);        			
    			}    			
    			nApprovaler = sqlSession.selectOne("topVacationMapper.selectSectorManagerUserNo",sSector);    			    			
    		}
    		
    		//재경관리파트의 팀장인경우는 재경팀의 팀장으로 휴가 결재자를 지정한다 (ex : 유미성, 김미영 파트장은 이성은 전무님으로 고정) : 20240625    		
    		if("20240516".equals(sTeam_id)) {
    			nApprovaler = "252";
    		}
    		
    	}
    	return nApprovaler;
    }    
	
}

