package kr.co.toplac.topmain;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
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

import kr.co.toplac.brd.common.BoardVO;
import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.sysadm.TopDivPopupVO;
import kr.co.toplac.sysadm.TopPrmLinkVO;
import kr.co.toplac.topgeneral.EmpNmlstTmDtlVO;
import kr.co.toplac.topindividual.MyVacationInfoTemp;
import kr.co.toplac.topprimbiz.TopPrimBizRptHeadVO;
import kr.co.toplac.topsuim.TopRptHeadVO;
import kr.co.toplac.topsuit.SuimSuit_10VO;
import kr.co.toplac.topsuit.SuimSuit_18VO;
import kr.co.toplac.topsuit12.SuimSuit_12VO;
import kr.co.toplac.topsuit17.SuimSuit_17VO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topvaction.VacationInfoBean;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.WebUtil;
import kr.co.toplac.util.rpt.MainLeftUtil;

@Controller
public class TopMainController {

	private static final Logger logger = LoggerFactory.getLogger(TopMainController.class);

	@Autowired
	SqlSession sqlSession;
	
	@Autowired
	MainLeftUtil mlu;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, HttpSession session) {

		logger.info("======= TOP Login =======");
		
		if( (session.getAttribute("user_no_Session") != null)){
//			return "top_main/top_main_index";				
			return "redirect:/topMainIndex";				
		}else{
			return "top_login/top_login";
		}

	}//home

	@RequestMapping(value = "/mainNoticePop", method = RequestMethod.GET)
	public String mainNoticePop(Model model, HttpSession session) {

		logger.info("======= mainNoticePop =======");
  
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		
		Map<String, String> paramMap = new HashMap<>();
		paramMap.put("user_no", mbrVo.getUser_no());
        
        Map<String, Object> evaluateUrl = sqlSession.selectOne("BrdFaqNewMapper.selectEvaluateUrl", paramMap);
        model.addAttribute("evUrlInfo", evaluateUrl);
		
		
		return "top_main/tmp_pop";
	}//mainNoticePop


    @RequestMapping(value = "/top_main_left")
    public String topMainLeft(Model model, HttpServletRequest request){

        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();        

        mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
        mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

        return "top_main/top_main_left";

    }


	@RequestMapping(value = "/topMainIndex", method = RequestMethod.GET)
	public String topMainIndex(Model model, HttpSession session, HttpServletRequest request
			, String fromLogInPage, String timeDifferForPwAlert, String firstLogin) {
		
		logger.info("======= topMainIndex =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		
		if(mbrVo == null){
			logger.info("home - no permession : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		
		//권한테이블에 데이터가 없는 경우 오류 Insert 처리 by top3009 (20191125)
		int authCnt = sqlSession.selectOne("TopLoginMapper.getAuthCnt",mbrVo.getUser_no());
		
		if( authCnt == 0 ) {			//권한테이블에 데이터가 없는경우.. 정상적인경우 1개가 존재해야함.
			sqlSession.insert("TopLoginMapper.insTopMbrPms", mbrVo.getUser_no());
		}
		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

//		MainLeftSuimVO mainLeftMySuimVO = sqlSession.selectOne("MainLeftMySuimMapper.mainLeftMySuimState", mbrVo.getUser_no());
//		model.addAttribute("mainLeftMySuimVO", mainLeftMySuimVO);
//
//		MainLeftSuimVO mainLeftTmSuimVO = sqlSession.selectOne("MainLeftMySuimMapper.mainLeftTmSuimState", mbrVo.getTeam_id_main());
//		model.addAttribute("mainLeftTmSuimVO", mainLeftTmSuimVO);

		
		List<BoardVO> topMainBoardNoticeList = sqlSession.selectList("TopMainBoardMapper.topMainBoardNoticeList");
		model.addAttribute("topMainBoardNoticeList", topMainBoardNoticeList);

		List<BoardVO> topMainBoardFreeList = sqlSession.selectList("TopMainBoardMapper.topMainBoardFreeList");
		model.addAttribute("topMainBoardFreeList", topMainBoardFreeList);
		
		List<Map<String,Object>> topMainGuidelist = sqlSession.selectList("TopMainBoardMapper.topMainBoardGuideList");
		model.addAttribute("topMainGuidelist",topMainGuidelist);
		
		String user_no = mbrVo.getUser_no();
		List<TopRptHeadVO> mainIndexSuimList = sqlSession.selectList("MainIndexListMapper.mainIndexSuimList", user_no);
		model.addAttribute("mainIndexSuimList", mainIndexSuimList);

		List<TopPrimBizRptHeadVO> mainIndexPrimbizList = sqlSession.selectList("MainIndexListMapper.mainIndexPrimbizList", user_no);
		model.addAttribute("mainIndexPrimbizList", mainIndexPrimbizList);

		List<SuimSuit_10VO> mainIndexSuit10List = sqlSession.selectList("MainIndexListMapper.mainIndexSuit10List", user_no);
		model.addAttribute("mainIndexSuit10List", mainIndexSuit10List);

		List<SuimSuit_12VO> mainIndexSuit12List = sqlSession.selectList("MainIndexListMapper.mainIndexSuit12List", user_no);
		model.addAttribute("mainIndexSuit12List", mainIndexSuit12List);

		List<SuimSuit_17VO> mainIndexSuit17List = sqlSession.selectList("MainIndexListMapper.mainIndexSuit17List", user_no);
		model.addAttribute("mainIndexSuit17List", mainIndexSuit17List);

		List<SuimSuit_18VO> mainIndexSuit18List = sqlSession.selectList("MainIndexListMapper.mainIndexSuit18List", user_no);
		model.addAttribute("mainIndexSuit18List", mainIndexSuit18List);
		
		// 연봉협상 플래그
		Long salaryCnt = sqlSession.selectOne("MemberSalAprvMapper.selectUserSalaryCnt",user_no);
		session.setAttribute("salFlag", String.valueOf(salaryCnt));
		
		Long internCnt = sqlSession.selectOne("MemberSalAprvMapper.selectUserInternCnt",user_no);
		session.setAttribute("internSalFlag", String.valueOf(internCnt));
		
		// 회사만족도 및 상향평가 플래그
		String sUpperSurvey = sqlSession.selectOne("MemberSalAprvMapper.getUpperSurvey",user_no);
		session.setAttribute("upperSurvey", sUpperSurvey);		
/*
		
		String salFlag = sqlSession.selectOne("MemberSalAprvMapper.getUserAgree",user_no);
		session.setAttribute("salFlag", salFlag);
		
		String internSalFlag = sqlSession.selectOne("MemberSalAprvMapper.getInternAgree",user_no);
		session.setAttribute("internSalFlag", internSalFlag);
*/
		
		
		/***************/
		
		
		model.addAttribute("fromLogInPage", fromLogInPage);
		model.addAttribute("timeDifferForPwAlert", timeDifferForPwAlert);
		model.addAttribute("firstLogin", firstLogin);
		
		//연차휴가 안내 팝업 데이터 가져오기 시작
		MyVacationInfoTemp vacationTemp = sqlSession.selectOne("MemberSalAprvMapper.getMyVacationTemp",user_no);		
		session.setAttribute("vacationTemp", vacationTemp);
		//연차휴가 안내 팝업 데이터 가져오기 끝
		
		//신규휴가결재권한이 있는 사용자 인지 체크 (top_tm_bsc 에 team_manager로 등록되어있는지 확인)
		int nManagerCnt = sqlSession.selectOne("MemberSalAprvMapper.getTeamManagerCnt",user_no);
		if( nManagerCnt > 0 ) {
			session.setAttribute("vacationApprovalAuth", 1);
		}else {
			session.setAttribute("vacationApprovalAuth", 0);
		}
		
		//오늘 휴가자 찾기 시작
		//팀장(3,7) 센터장(14,15)인 경우만 처리한다.		
		String sWork_type_cd = mbrVo.getWork_type_cd();
		
		String sToday = DateUtil.getTodayString("yyyy-MM-dd");
		
		Map<String, String> paramMap = new HashMap<>();
		
		if( "14".equals(sWork_type_cd) || "15".equals(sWork_type_cd) || "3".equals(sWork_type_cd) || "7".equals(sWork_type_cd) ){
			
			//휴가 결재권한을 가지고 있는 팀을 가져온다.			
			TopMbrAuthVO mbrVacationAuth = sqlSession.selectOne("TopLoginMapper.getVacation1Auth", user_no);
			String sTeamList = "";
			String sMemberList = "";
			
			//휴가 결재 권한을 뺀경우 권한 테이블에 | 한개값만 남는 오류가 있어 수정함 by top3009
			if( mbrVacationAuth != null && !mbrVacationAuth.getLs_admin_vacation1().equals("|")) {
				sTeamList = mbrVacationAuth.getLs_admin_vacation1();				
				//sql In절에 들어갈 팀 조건 string 을 만든다.
				sTeamList = WebUtil.makeInsqlString(sTeamList,"\\|");				
				paramMap.put("team_list", sTeamList);				
				List<VacationInfoBean> userInfoList = sqlSession.selectList("topVacationMapper.getVacationTeamMember",paramMap);				
				
				for(int i = 0; i< userInfoList.size(); i++) {
					sMemberList += userInfoList.get(i).getUser_no()+",";
				}
				
				sMemberList = sMemberList.substring(0, sMemberList.length() - 1);		//맨끝쉼표제거				
				
				//해당 직원들의 휴가상태값을 가져온다.
				paramMap.put("today", sToday);
				paramMap.put("member_list", sMemberList);
				
				if( !"".equals(sMemberList) ) {		//맴버가 있는경우만 조회					
					List<VacationInfoBean> nowVacationUserList = sqlSession.selectList("topVacationMapper.getVacationMemberList",paramMap);
					model.addAttribute("vacationMember", nowVacationUserList);
					model.addAttribute("sToday",sToday);
				}else {
					model.addAttribute("vacationMember", null);
				}
				
			}else {
				model.addAttribute("vacationMember", null);
			}			
			
		}
		//오늘 휴가자 찾기 끝
		
		//오늘 휴가자 조회 권한 체크 시작 (ls_admin 의 ls_today_vacation 권한)
		String sTodayVacationTeams = sqlSession.selectOne("PopMbrAuth2DtlMapper.getLsTodayVacation",user_no);
		model.addAttribute("sTodayVacationTeams", sTodayVacationTeams);
		//오늘 휴가자 조회 권한 체크 끝 (ls_admin 의 ls_today_vacation 권한)
		
		//손해사정서 미교부현황목록 시작
		//팀장(3,7) 
		//센터장(14,15)과 부문장(2:1종 부문장, 6:4종 부문장) 경우만 처리한다.
		
		List<Map<String,Object>> teamSendResult = null;		
		Map<String,Object> personSendResult = null;			//개인기준 손해사정서 미교부현황 데이터
		
		//현장보고서 팝업여부 (팝업 사용안함 : 0, 총괄화면 : 1, 센터장화면 : 2, 팀장 화면  : 3, 개인화면 : 4)
		String sitePopAuth = "0";
		//List<Map<String,Object>> teamSiteResult = null;	//팀기준 현장보고서 제출 팝업데이터
		//Map<String,Object> personSiteResult = null;			//개인기준 현장보고서 제출 팝업데이터
		
		//로그인을 한경우만 손해사정서 미발송 팝업을 띄운다.
		if( "1".equals(fromLogInPage) ) {		
			String sector_flag = "";
			String team_id = mbrVo.getTeam_id_main();
			
			String center_flag = "";			
			String sAuthTeam = "";		//권한테이블에서 조회된 팀목록
			String sSqlAuthTeam = "";
			
			//1종 부문장 또는 4종 부문장
			if( "2".equals(sWork_type_cd) || "6".equals(sWork_type_cd) ) {
				//부문코드를 가져온다.
				sector_flag = sqlSession.selectOne("TopLoginMapper.selectSectorCode", team_id);
				//System.out.println(team_id+" : "+sector_flag);
				
				//기타부문이 아닌경우만 처리한다.
				if(!"9".equals(sector_flag)) {
					teamSendResult = sqlSession.selectList("TopLoginMapper.selectTeamListSector", sector_flag);				
				}
				
				//1종 센터장 또는 4종 센터장
			}else if( "14".equals(sWork_type_cd) || "15".equals(sWork_type_cd) ){
				//센터코드를 가져온다.
				center_flag = sqlSession.selectOne("TopLoginMapper.selectCenterCode", team_id);
				
				//기타부문이 아닌경우만 처리한다.
				if(!"999".equals(center_flag)) {
					teamSendResult = sqlSession.selectList("TopLoginMapper.selectTeamListCenter", center_flag);				
				}
				
				//1종 팀장 또는 4종 팀장
			}else if( "3".equals(sWork_type_cd) || "7".equals(sWork_type_cd) ){
				//자신이 팀메니저로 있는 팀의 목록을 가져온다.
				teamSendResult = sqlSession.selectList("TopLoginMapper.selectTeamListManager", user_no);			
			}else{		//work_type 이 부문장, 센터장, 팀장이 아닌경우엔 권한테이블을 체크한다.
				sAuthTeam = sqlSession.selectOne("TopLoginMapper.selectTeamListAuth", user_no);
				
				if(!"".equals(sAuthTeam) && !"|".equals(sAuthTeam)) {		//팀조회권한이있는경우만 처리한다.
					sSqlAuthTeam = WebUtil.makeInsqlString(sAuthTeam, "\\|");					
					paramMap.put("sqlTeam", sSqlAuthTeam);
					teamSendResult = sqlSession.selectList("TopLoginMapper.selectTeamListAuthSearch", paramMap);					
				}
			}
			
			//임시 손해사정서 미발송 카운트
			int nTempSendResultCnt = 0;
			String sTeamid = "";			
			String sTotalCntTemp = "";
			
			if( teamSendResult != null ) {
				for( int i=0; i < teamSendResult.size(); i++ ) {
					sTeamid = teamSendResult.get(i).get("teamId").toString();
					nTempSendResultCnt = sqlSession.selectOne("TopLoginMapper.selectNoSendReportCnt",sTeamid);
					teamSendResult.get(i).put("no_send_cnt", nTempSendResultCnt);				
				}
			}else{
				//팀기준(별도권한 또는 부문장,센터장, 팀장이 아닌경우)
				personSendResult = sqlSession.selectOne("TopLoginMapper.selectNoSendPersonInfo", user_no);
				sTotalCntTemp = personSendResult.get("total_cnt").toString();
				
				//미발송수가 0인경우는 객체를 null 처리한다.(팝업이 나타나지 않음)
				if( "0".equals(sTotalCntTemp)){
					personSendResult = null;
				}
			}
			
			//현장보고서 팝업권한 체크 시작			
			String team_type = mbrVo.getTeam_type();
			
			if("4".equals(team_type)) {			//인보험은 현장보고서 팝업사용 안함
				sitePopAuth = "0";
			}else{										//물보험 및 본사만 사용여부를 체크한다.
				if( "1".equals(mbrAuthVo.getMbr_pms_38()) || "2".equals(sWork_type_cd)) {			//현장보고서 팝업 전체 사용권한 또는 1종 부문장										
					sitePopAuth = "1";				//총괄화면권한					
				}else if( "14".equals(sWork_type_cd) ){			//1종 센터장
					sitePopAuth = "2";				//센터장화면					
				}else{														//1종 팀장이거나 개인조회 대상자
					//담당 관리 부서체크 박스 권한이 있는 경우 1종 팀장권한과 같이 처리한다.
					String sAuthTeam23 = "";
					
					sAuthTeam23 = sqlSession.selectOne("TopLoginMapper.selectTeamListAuth23", user_no);
					
					if(!"".equals(sAuthTeam23) && !"|".equals(sAuthTeam23)) {		//팀조회권한이있는경우만 처리한다.
						sitePopAuth = "3";
					}else{								//담당관리부서 체크박스권한이 없는경우 >> 개인조사자
						//최근 30일내 수임건이 있는지 체크 (수임건이 없으면 팝업을 사용하지 않는다.)
						int nSuim30 = sqlSession.selectOne("TopLoginMapper.selectSuimCnt30", user_no);
						if( nSuim30 > 0) {
							sitePopAuth = "4";			//현장보고서 개인 팝업 사용하는 경우
						}else {
							sitePopAuth = "0";			//최근 30일내 수임건이 없으면 팝업을 사용하지 않는다.
						}						
					}
				}				
			}
			//결과 확인
			model.addAttribute("sitePopAuth", sitePopAuth);			
		}
		
		model.addAttribute("personSendResult", personSendResult);
		model.addAttribute("teamSendResult", teamSendResult);
		
		//손해사정서 미교부현황목록 끝
		
		
		//로그인 전 팝업 사용을 체크시작		
		TopDivPopupVO popupVO = new TopDivPopupVO();
		
		//사용여부 (is_use = 1:로그인 후)
		popupVO.setIs_use("2");
		
		Calendar cal = Calendar.getInstance() ;
		
		//week_flag (요일 : 일, 월, 화..토, 1 ~ 7)		
		int nWeekflag = cal.DAY_OF_WEEK - 1;
		int nDay = cal.get(cal.DATE);		
		
		popupVO.setWeek_flag(nWeekflag);
		
		//month_flag (오늘 날짜)
		popupVO.setMonth_flag(nDay);
		
		//현시점에 해당하는 팝업만 가져오기
		List<TopDivPopupVO> divPopupList = sqlSession.selectList("CodeDicInsMapper.selectDivPopupListChk", popupVO);
		
		model.addAttribute("divPopupList", divPopupList);
		//로그인 전 팝업 사용을 체크 끝

		return "top_main/top_main_index";
	}//topMainIndex
	
	/**
	 * 현장보고서 결재요청 목록 
	 * @param request
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/siteApprovalListModal")
	 public String siteApprovalListModal(HttpServletRequest request, Model model, HttpSession session) {
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");

		if(mbrVo == null){
				logger.info("home - no permession : "+request.getRemoteAddr());
				session.invalidate();
				return "top_login/top_login";
		}
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String user_no = mbrVo.getUser_no();
		
		logger.info("========= siteApprovalListModal =========");
		
		String sLsApprovalSite = "";			//겸직자 결재팀
		sLsApprovalSite = sqlSession.selectOne("PopMbrAuth2DtlMapper.getLsApprovalSite", user_no);        
		sLsApprovalSite = WebUtil.makeInsqlString(sLsApprovalSite,"\\|");
		
		paramMap.put("approval_team", sLsApprovalSite);
		List<Map<String, Object>> approvalSiteList = sqlSession.selectList("TmMainLeftUtilMapper.selectApprovalSiteList",paramMap);
		
		model.addAttribute("approvalSiteList", approvalSiteList);		
		
		return "top_main/site_approval_list_modal";
	}
	
	/**
	 * 오늘 휴가자 알림 모달창 보기
	 */
	 @RequestMapping(value="/siteTodayVacationModal")
	 public String siteTodayVacationModal(HttpServletRequest request, Model model, HttpSession session) {
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");

		if(mbrVo == null){
				logger.info("home - no permession : "+request.getRemoteAddr());
				session.invalidate();
				return "top_login/top_login";
		}
		String user_no = mbrVo.getUser_no();		
		
		logger.info("========= siteTodayVacationModal =========");
		
		//String sUrl = "top_main/site_report_center_modal";
		String sUrl = "top_main/site_today_vacation_modal";
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		//오늘 휴가자 조회 권한 있는 팀목록가져오기
		String sTodayVacationTeams = sqlSession.selectOne("PopMbrAuth2DtlMapper.getLsTodayVacation", user_no);
		
		sTodayVacationTeams = WebUtil.makeInsqlString(sTodayVacationTeams, "\\|");
		String sToday = DateUtil.getTodayString("yyyy-MM-dd");
		
		paramMap.put("today", sToday);
		paramMap.put("todayVacationTeams", sTodayVacationTeams);
		
		List<Map<String,Object>> vacationUserList = sqlSession.selectList("PopMbrAuth2DtlMapper.getTodayVacationByTeams", paramMap);
		
		model.addAttribute("vacationUserList", vacationUserList);
		model.addAttribute("today", sToday);
		
		return sUrl;
	 }
	
	/**
	 * 전체 센터 현장보고서 제출현황 보기
	 */
	 @RequestMapping(value="/siteReportCenterModal")
	 public String siteReportCenterModal(HttpServletRequest request, Model model, HttpSession session) {
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");

		if(mbrVo == null){
				logger.info("home - no permession : "+request.getRemoteAddr());
				session.invalidate();
				return "top_login/top_login";
		}
		String user_no = mbrVo.getUser_no();
		
		String mbr_pms_38 = mbrAuthVo.getMbr_pms_38().toString();
		String work_type_cd = mbrVo.getWork_type_cd().toString();
		
		logger.info("========= siteReportCenterModal =========");
		
		String sUrl = "top_main/site_report_center_modal";
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	//CommonUtils.printMap(paramMap);			 
    	
    	String sTeam_center = paramMap.get("team_center").toString();
    	
    	List<Map<String,Object>> centerSiteResult = new ArrayList<>();		//센터기준 현장보고서 제출 팝업데이터    	
    	List<Map<String,Object>> teamSiteResult = new ArrayList<>();		//팀기준 현장보고서 제출 팝업데이터
    	
    	String sToday = DateUtil.getTodayString("yyyy-MM-dd");    	
    	String sStartYear = DateUtil.getStartYearDay(sToday);
    	String sEndYear = DateUtil.getEndYearDay(sToday);

    	paramMap.put("start_date", sStartYear);
    	paramMap.put("end_date", sEndYear);
    	
    	try {
    		String textDate = DateUtil.getTextDateFormat(sStartYear);
    		model.addAttribute("start_date", textDate);
		} catch (Exception e) {
			logger.error("parseError : "+e.getMessage());
		}
    	
    	//전체 팀 통계
    	List<Map<String,Object>> teamSiteAllList = sqlSession.selectList("TopLoginMapper.selectSiteTeamReportListAll",paramMap);
    	
    	String menuType = "";
    	
    	if( "0".equals(sTeam_center)) {
    		menuType = "All";
    		
    		//전체 센터 목록
        	List<Map<String,Object>> centerInfoList = sqlSession.selectList("TopLoginMapper.selectCenterListFor1");
        	
        	int sum_suim_cnt = 0;
        	int sum_sub_3_in_cnt = 0;
        	int sum_sub_3_over_cnt = 0;
        	int sum_not_3_in_cnt = 0;
        	int sum_not_3_over_cnt = 0;
        	int sum_not_30_over_cnt = 0;
        	int nOverPer = 0;
        	int sum_end_average_cnt = 0;
        	
        	String sCenterNo = "";
        	String sCenterName = ""; 
        	int teamCnt = 0;
        	
        	for(int i=0; i < centerInfoList.size(); i++) {
        		//System.out.println(centerInfoList.get(i).get("center_no").toString()+" : "+centerInfoList.get(i).get("center_name").toString());
        		
        		Map<String,Object> centerSiteMap = new HashMap<>();						//for 문내에서 Map 사용시 밖에서 선언하면 안됨.				
        		sCenterNo = centerInfoList.get(i).get("center_no").toString();
        		sCenterName = centerInfoList.get(i).get("center_name").toString();				
				
        		centerSiteMap.put("team_center", sCenterNo);
        		centerSiteMap.put("center_name", sCenterName);
        		centerSiteMap.put("suim_cnt", "0");
        		centerSiteMap.put("sub_3_in_cnt", "0");
        		centerSiteMap.put("sub_3_over_cnt", "0");
        		centerSiteMap.put("not_3_in_cnt", "0");
        		centerSiteMap.put("not_3_over_cnt", "0");
        		centerSiteMap.put("over_per", "0");
        		centerSiteMap.put("not_30_over_cnt", "0");
        		centerSiteMap.put("end_average_cnt", "0");
        		
        		for(int k=0; k < teamSiteAllList.size(); k++) {
					if( sCenterNo.equals(teamSiteAllList.get(k).get("team_center").toString()) ) {
						sum_suim_cnt += Integer.parseInt(teamSiteAllList.get(k).get("suim_cnt").toString());
						sum_sub_3_in_cnt += Integer.parseInt(teamSiteAllList.get(k).get("sub_3_in_cnt").toString());
						sum_sub_3_over_cnt += Integer.parseInt(teamSiteAllList.get(k).get("sub_3_over_cnt").toString());
						sum_not_3_in_cnt += Integer.parseInt(teamSiteAllList.get(k).get("not_3_in_cnt").toString());
						sum_not_3_over_cnt += Integer.parseInt(teamSiteAllList.get(k).get("not_3_over_cnt").toString());
						sum_not_30_over_cnt += Integer.parseInt(teamSiteAllList.get(k).get("not_30_over_cnt").toString());
						sum_end_average_cnt += Integer.parseInt(teamSiteAllList.get(k).get("end_average_cnt").toString());
						teamCnt++;
					}					
				}
        		centerSiteMap.put("suim_cnt", sum_suim_cnt);
        		centerSiteMap.put("sub_3_in_cnt", sum_sub_3_in_cnt);
        		centerSiteMap.put("sub_3_over_cnt", sum_sub_3_over_cnt);
        		centerSiteMap.put("not_3_in_cnt", sum_not_3_in_cnt);
        		centerSiteMap.put("not_3_over_cnt", sum_not_3_over_cnt);
        		centerSiteMap.put("not_30_over_cnt", sum_not_30_over_cnt);
        		
        		if( teamCnt > 0 ) {
        			centerSiteMap.put("end_average_cnt", sum_end_average_cnt / teamCnt);
        		}else {
        			centerSiteMap.put("end_average_cnt", 0);
        		}
        		
        		if( sum_suim_cnt > 0 ) {
        			nOverPer = ((sum_sub_3_over_cnt + sum_not_3_over_cnt) * 100) / sum_suim_cnt;
        		}else{
        			nOverPer = 0;
        		}
        		
        		centerSiteMap.put("over_per", nOverPer);        		
        		
				centerSiteResult.add(i, centerSiteMap);
				
				//합계값 초기화
				sum_suim_cnt = 0;
	        	sum_sub_3_in_cnt = 0;
	        	sum_sub_3_over_cnt = 0;
	        	sum_not_3_in_cnt = 0;
	        	sum_not_3_over_cnt = 0;
	        	sum_not_30_over_cnt = 0;
	        	sum_end_average_cnt = 0;
	        	nOverPer = 0;
	        	teamCnt = 0;
        	}
        	
    	}else{				//특정센터를 호출한경우
    		menuType = "Center";
    		
    		List<Map<String,Object>> teamInfoList = sqlSession.selectList("TopLoginMapper.selectTeamListCenter", sTeam_center);
    		
    		//회사전체(센터전체)의 초과율을 계산한다. (특정센터를 계산하는 경우는 sel_team_center 값으로 paramMap 에 넣어준다.)
    		String total_over_per = "";
    		total_over_per = sqlSession.selectOne("TopLoginMapper.selectSiteOverPerCal",paramMap);    		
    		
    		String tempTeamId = "";
    		String tempTeamname = "";
    		String sCenter_name = "";
    		
    		int nTempSuimCnt = 0;					//30일내 수임건수			
    		int nTempSub3OverCnt = 0;				//3일초과 현장보고서 결재			
    		int nTempNot3OverCnt = 0;				//3일초과 현장보고서 미결재			
    		int nOverPer = 0;							//초과비율(3영업일초과건수 / 전체수임건)
    		
    		int nIndex = 0;
    		
    		for( int i=0; i < teamInfoList.size(); i++) {
    			//System.out.println( teamInfoList.get(i).get("teamId").toString() +" : "+ teamInfoList.get(i).get("teamName").toString() );
    			
    			Map<String,Object> teamSiteMap = new HashMap<>();						//for 문내에서 Map 사용시 밖에서 선언하면 안됨.				
				tempTeamId = teamInfoList.get(i).get("teamId").toString();
				tempTeamname = teamInfoList.get(i).get("teamName").toString();
				sCenter_name =  teamInfoList.get(i).get("centerName").toString();
				
				teamSiteMap.put("team_id", tempTeamId);
				teamSiteMap.put("team_name", tempTeamname);
				teamSiteMap.put("suim_cnt", "0");
				teamSiteMap.put("sub_3_in_cnt", "0");
				teamSiteMap.put("sub_3_over_cnt", "0");
				teamSiteMap.put("not_3_in_cnt", "0");
				teamSiteMap.put("not_3_over_cnt", "0");
				teamSiteMap.put("over_per", "0");
				teamSiteMap.put("not_30_over_cnt", "0");
				teamSiteMap.put("end_average_cnt", "0");				
				
				//System.out.println(teamInfoList.get(i).get("teamId").toString()+" : "+teamInfoList.get(i).get("teamName").toString());
				
				for(int k=0; k < teamSiteAllList.size(); k++) {
					if( tempTeamId.equals(teamSiteAllList.get(k).get("team_id").toString()) ) {						
						teamSiteMap.put("suim_cnt", teamSiteAllList.get(k).get("suim_cnt").toString());
						teamSiteMap.put("sub_3_in_cnt", teamSiteAllList.get(k).get("sub_3_in_cnt").toString());
						teamSiteMap.put("sub_3_over_cnt", teamSiteAllList.get(k).get("sub_3_over_cnt").toString());
						teamSiteMap.put("not_3_in_cnt", teamSiteAllList.get(k).get("not_3_in_cnt").toString());
						teamSiteMap.put("not_3_over_cnt", teamSiteAllList.get(k).get("not_3_over_cnt").toString());						
						teamSiteMap.put("not_30_over_cnt", teamSiteAllList.get(k).get("not_30_over_cnt").toString());
						teamSiteMap.put("end_average_cnt", teamSiteAllList.get(k).get("end_average_cnt").toString());
						//퍼센트 계산
						nTempSuimCnt = Integer.parseInt(teamSiteAllList.get(k).get("suim_cnt").toString());
						nTempSub3OverCnt = Integer.parseInt(teamSiteAllList.get(k).get("sub_3_over_cnt").toString());
						nTempNot3OverCnt = Integer.parseInt(teamSiteAllList.get(k).get("not_3_over_cnt").toString());
						if( nTempSuimCnt > 0) {
							nOverPer = ((nTempSub3OverCnt+nTempNot3OverCnt) * 100) / nTempSuimCnt;
						}else {
							nOverPer = 0;
						}						
						teamSiteMap.put("over_per", String.valueOf(nOverPer));						
					}
				}
				
				//조회 대상 수(수임0, 1개월 미재출건 0)가 전부 0인경우는 목록에서 빠진다.
				//if( "0".equals(teamSiteMap.get("suim_cnt").toString() ) && "0".equals(teamSiteMap.get("not_30_over_cnt").toString() ) ) {
				//조회 대상 수(수임0, 1개월 미재출건 0)가 전부 0인경우는 목록에서 빠진다.
				if( "0".equals(teamSiteMap.get("suim_cnt").toString() ) && "0".equals(teamSiteMap.get("not_30_over_cnt").toString() ) && "0".equals(teamSiteMap.get("end_average_cnt").toString() ) ) {
					//logger.info("Skip Team : "+tempTeamname);
					//갯수가 없어 빠진 팀 목록
				}else {					
					teamSiteResult.add(nIndex, teamSiteMap);
					nIndex++;
				}								
			}
    		
    		//전체평균값 추가
    		model.addAttribute("total_over_per", total_over_per);    		
    		model.addAttribute("title_team_center", sTeam_center);
    		model.addAttribute("title_center_name", sCenter_name);    		
    		
    	}    	
    	
    	model.addAttribute("menuType", menuType);
    	model.addAttribute("teamSiteResult", teamSiteResult);
    	model.addAttribute("centerSiteResult", centerSiteResult);
    	
    	model.addAttribute("mbr_pms_38", mbr_pms_38);
    	model.addAttribute("work_type_cd", work_type_cd);
    	
		return sUrl; 
	 }
	
	
	/**
     * 팀장 개인별 현장보고서 제출현황 Modal
     */
    @RequestMapping(value="/siteReportTeamModal")
    public String siteReportTeamModal(HttpServletRequest request, Model model, HttpSession session) {
    	
    	TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
    	TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		
		if(mbrVo == null){
			logger.info("home - no permession : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		
    	String user_no = mbrVo.getUser_no();
    	
    	String mbr_pms_38 = mbrAuthVo.getMbr_pms_38().toString();
    	String work_type_cd = mbrVo.getWork_type_cd().toString();
    	
    	logger.info("========= siteReportTeamModal =========");
    	
    	String sUrl = "top_main/site_report_team_modal";
    	
    	Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String sTeam_id = paramMap.get("team_id").toString();
    	
    	List<Map<String,Object>> teamInfoList = null;	//팀기준 현장보고서 제출 팝업데이터    	
    	List<Map<String,Object>> teamSiteResult = new ArrayList<>();	//팀기준 현장보고서 제출 팝업데이터
    	
    	List<Map<String,Object>> memberSiteResult = new ArrayList<>();		//팀원기준 현장보고서 제출 팝업데이터
    	    	
    	//long beforeTime = System.currentTimeMillis();
    	
    	String menuType = "";
    	
    	int nTempSuimCnt = 0;					//30일내 수임건수			
		int nTempSub3OverCnt = 0;				//3일초과 현장보고서 결재			
		int nTempNot3OverCnt = 0;				//3일초과 현장보고서 미결재			
		int nOverPer = 0;							//초과비율(3영업일초과건수 / 전체수임건)
		
		String sToday = DateUtil.getTodayString("yyyy-MM-dd");    	
		String sStartYear = DateUtil.getStartYearDay(sToday);
		String sEndYear = DateUtil.getEndYearDay(sToday);		

		paramMap.put("start_date", sStartYear);
		paramMap.put("end_date", sEndYear);
		
		try {
    		String textDate = DateUtil.getTextDateFormat(sStartYear);
    		model.addAttribute("start_date", textDate);
		} catch (Exception e) {
			logger.error("parseError : "+e.getMessage());
		}		
    	    	
    	if( "0".equals(sTeam_id) ) {			//권한이 있는 팀의 팀원목록을 불러온다.
    		
    		List<Map<String,Object>> teamSiteAllList = sqlSession.selectList("TopLoginMapper.selectSiteTeamReportListAll",paramMap);
    		
    		menuType = "Team";
    		
    		//담당 관리 부서체크 박스 권한이 있는 경우 1종 팀장권한과 같이 처리한다.
			String sAuthTeam23 = "";
			String sSqlAuthTeam23 = "";			
			
			sAuthTeam23 = sqlSession.selectOne("TopLoginMapper.selectTeamListAuth23", user_no);
			
			if(!"".equals(sAuthTeam23) && !"|".equals(sAuthTeam23)) {		//팀조회권한이있는경우만 처리한다.
				sSqlAuthTeam23 = WebUtil.makeInsqlString(sAuthTeam23, "\\|");				
				//System.out.println("sSqlAuthTeam23 : "+sSqlAuthTeam23);				
				paramMap.put("sqlTeam", sSqlAuthTeam23);
				teamInfoList = sqlSession.selectList("TopLoginMapper.selectTeamListAuthSearchFor1", paramMap);
			}
			
			String tempTeamId = "";
			String tempTeamname = "";
			String tempCenterName = "";
			
			int nIndex = 0;
			
			for(int i=0; i < teamInfoList.size(); i++) {
				
				Map<String,Object> teamSiteMap = new HashMap<>();						//for 문내에서 Map 사용시 밖에서 선언하면 안됨.				
				tempTeamId = teamInfoList.get(i).get("teamId").toString();
				tempTeamname = teamInfoList.get(i).get("teamName").toString();
				tempCenterName = teamInfoList.get(i).get("centerName").toString();
				
				teamSiteMap.put("team_id", tempTeamId);
				teamSiteMap.put("team_name", tempTeamname);
				teamSiteMap.put("suim_cnt", "0");
				teamSiteMap.put("sub_3_in_cnt", "0");
				teamSiteMap.put("sub_3_over_cnt", "0");
				teamSiteMap.put("not_3_in_cnt", "0");
				teamSiteMap.put("not_3_over_cnt", "0");
				teamSiteMap.put("over_per", "0");
				teamSiteMap.put("not_30_over_cnt", "0");
				teamSiteMap.put("end_average_cnt", "0");
				
				//System.out.println(teamInfoList.get(i).get("teamId").toString()+" : "+teamInfoList.get(i).get("teamName").toString());
				
				for(int k=0; k < teamSiteAllList.size(); k++) {
					if( tempTeamId.equals(teamSiteAllList.get(k).get("team_id").toString()) ) {						
						teamSiteMap.put("suim_cnt", teamSiteAllList.get(k).get("suim_cnt").toString());
						teamSiteMap.put("sub_3_in_cnt", teamSiteAllList.get(k).get("sub_3_in_cnt").toString());
						teamSiteMap.put("sub_3_over_cnt", teamSiteAllList.get(k).get("sub_3_over_cnt").toString());
						teamSiteMap.put("not_3_in_cnt", teamSiteAllList.get(k).get("not_3_in_cnt").toString());
						teamSiteMap.put("not_3_over_cnt", teamSiteAllList.get(k).get("not_3_over_cnt").toString());						
						teamSiteMap.put("not_30_over_cnt", teamSiteAllList.get(k).get("not_30_over_cnt").toString());
						teamSiteMap.put("end_average_cnt", teamSiteAllList.get(k).get("end_average_cnt").toString());
						//퍼센트 계산
						nTempSuimCnt = Integer.parseInt(teamSiteAllList.get(k).get("suim_cnt").toString());
						nTempSub3OverCnt = Integer.parseInt(teamSiteAllList.get(k).get("sub_3_over_cnt").toString());
						nTempNot3OverCnt = Integer.parseInt(teamSiteAllList.get(k).get("not_3_over_cnt").toString());
						if( nTempSuimCnt > 0) {
							nOverPer = ((nTempSub3OverCnt+nTempNot3OverCnt) * 100) / nTempSuimCnt;
						}else {
							nOverPer = 0;
						}						
						teamSiteMap.put("over_per", String.valueOf(nOverPer));						
					}
				}
				
				//조회 대상 수(수임0, 1개월 미재출건 0)가 전부 0인경우는 목록에서 빠진다.
				//if( "0".equals(teamSiteMap.get("suim_cnt").toString() ) && "0".equals(teamSiteMap.get("not_30_over_cnt").toString() ) ) {
				if( "0".equals(teamSiteMap.get("suim_cnt").toString() ) && "0".equals(teamSiteMap.get("not_30_over_cnt").toString() ) && "0".equals(teamSiteMap.get("end_average_cnt").toString() ) ) {
					//logger.info("Skip Team : "+tempTeamname);
					//갯수가 없어 빠진 팀 목록
				}else {					
					teamSiteResult.add(nIndex, teamSiteMap);
					nIndex++;
				}				
			}
			
			model.addAttribute("title_center_name", "팀목록");
    		
    	}else{										//특정 팀의 통계정보를 가져온다.    		
    		menuType = "Member";
    		
    		List<Map<String,Object>> memberSiteAllList = sqlSession.selectList("TopLoginMapper.selectSiteMemberReportListAll",paramMap);
    		
    		List<EmpNmlstTmDtlVO> memberList = sqlSession.selectList("empNmlstTmDtlMapper.getMemberAll",sTeam_id);
    		
    		String tempUserNo = "";
    		String tempUserName = "";
    		String tempTeamName = "";
    		
    		for( int i = 0; i < memberList.size(); i++ ) {    			
    			Map<String,Object> memberSiteMap = new HashMap<>();						//for 문내에서 Map 사용시 밖에서 선언하면 안됨.
    			
    			tempUserNo = memberList.get(i).getUser_no();
				tempUserName = memberList.get(i).getUser_name();
				tempTeamName = memberList.get(i).getTeam_name();				
				
				memberSiteMap.put("user_no", tempUserNo);
				memberSiteMap.put("user_name", tempUserName);
				memberSiteMap.put("tempTeamName", tempTeamName);
				memberSiteMap.put("suim_cnt", "0");
				memberSiteMap.put("sub_3_in_cnt", "0");
				memberSiteMap.put("sub_3_over_cnt", "0");
				memberSiteMap.put("not_3_in_cnt", "0");
				memberSiteMap.put("not_3_over_cnt", "0");
				memberSiteMap.put("over_per", "0");
				memberSiteMap.put("not_30_over_cnt", "0");
				memberSiteMap.put("end_average_cnt", "0");				
				
				for(int k=0; k < memberSiteAllList.size(); k++) {
					if( tempUserNo.equals(memberSiteAllList.get(k).get("user_no").toString()) ) {						
						memberSiteMap.put("suim_cnt", memberSiteAllList.get(k).get("suim_cnt").toString());
						memberSiteMap.put("sub_3_in_cnt", memberSiteAllList.get(k).get("sub_3_in_cnt").toString());
						memberSiteMap.put("sub_3_over_cnt", memberSiteAllList.get(k).get("sub_3_over_cnt").toString());
						memberSiteMap.put("not_3_in_cnt", memberSiteAllList.get(k).get("not_3_in_cnt").toString());
						memberSiteMap.put("not_3_over_cnt", memberSiteAllList.get(k).get("not_3_over_cnt").toString());						
						memberSiteMap.put("not_30_over_cnt", memberSiteAllList.get(k).get("not_30_over_cnt").toString());
						memberSiteMap.put("end_average_cnt", memberSiteAllList.get(k).get("end_average_cnt").toString());
						//퍼센트 계산
						nTempSuimCnt = Integer.parseInt(memberSiteAllList.get(k).get("suim_cnt").toString());
						nTempSub3OverCnt = Integer.parseInt(memberSiteAllList.get(k).get("sub_3_over_cnt").toString());
						nTempNot3OverCnt = Integer.parseInt(memberSiteAllList.get(k).get("not_3_over_cnt").toString());
						if( nTempSuimCnt > 0) {
							nOverPer = ((nTempSub3OverCnt+nTempNot3OverCnt) * 100) / nTempSuimCnt;
						}else {
							nOverPer = 0;
						}						
						memberSiteMap.put("over_per", String.valueOf(nOverPer));						
					}
				}
				
				//memberSiteMap = sqlSession.selectOne("TopLoginMapper.selectSitePersonReportList", tempUserNo);
				
				memberSiteResult.add(i,memberSiteMap);
    			
    		}    		
    		
    		//네비게이션 용 파라미터
    		Map<String,Object> naviMap = sqlSession.selectOne("TopLoginMapper.selectSiteNaviTeam", sTeam_id);
    		    		
    		model.addAttribute("title_team_id", naviMap.get("team_id").toString());
    		model.addAttribute("title_team_name", tempTeamName);
    		model.addAttribute("title_team_center", naviMap.get("team_center").toString());
    		model.addAttribute("title_center_name", naviMap.get("center_name").toString());
    		
    		//상위단계 초과율 계산
    		String total_over_per = "";
    		paramMap.put("sel_team_center", naviMap.get("team_center").toString());
    		total_over_per = sqlSession.selectOne("TopLoginMapper.selectSiteOverPerCal",paramMap);
    		model.addAttribute("total_over_per", total_over_per);    		
    		
    	}
    	
    	model.addAttribute("menuType", menuType);
    	model.addAttribute("memberSiteResult", memberSiteResult);
    	model.addAttribute("teamSiteResult", teamSiteResult);
    	model.addAttribute("mbr_pms_38", mbr_pms_38);
    	model.addAttribute("work_type_cd", work_type_cd);
    	   	
    	return sUrl;
    }
	
	/**
     * 개인별 현장보고서 제출현황 Modal
     */
    @RequestMapping(value="/siteReportUserModal")
    public String siteReportUserModal(HttpServletRequest request, Model model) {
    	
    	logger.info("========= siteReportUserModal =========");
    	    	
    	String sUrl = "top_main/site_report_user_modal";
    	
    	String sToday = DateUtil.getTodayString("yyyy-MM-dd");    	
    	String sStartYear = DateUtil.getStartYearDay(sToday);
    	String sEndYear = DateUtil.getEndYearDay(sToday);    	
    	
    	Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	paramMap.put("start_date", sStartYear);
    	paramMap.put("end_date", sEndYear);
    	
    	try {
    		String textDate = DateUtil.getTextDateFormat(sStartYear);
    		model.addAttribute("start_date", textDate);
		} catch (Exception e) {
			logger.error("parseError : "+e.getMessage());
		}
    	    	
    	//개인별 현장보고서 통계목록
    	Map<String,Object> memberSiteMap = sqlSession.selectOne("TopLoginMapper.selectSitePersonReportList", paramMap);
    	        
        model.addAttribute("memberSiteMap", memberSiteMap);
        
        //소속센터 초과율 평균 계산시작
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
        String sTeam_center = mbrVo.getTeam_center();        
        paramMap.put("sel_team_center", sTeam_center);
        
        String total_over_per = "";
        total_over_per = sqlSession.selectOne("TopLoginMapper.selectSiteOverPerCal",paramMap);
        model.addAttribute("total_over_per", total_over_per);        
    	   	
    	return sUrl;
    }
	
	@RequestMapping(value = "prmListDownMenu", method = RequestMethod.POST)
	public void prmListDownMenu(HttpServletResponse response ) {
		
		logger.info("prmListDownMenu");
		
		List<TopPrmLinkVO> prmList = sqlSession.selectList("TopPrmLink.getPrmList");
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		
		PrintWriter out = null;
		
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		JSONArray arr = new JSONArray();
		for(int i=0; i < prmList.size(); i++){
			
			TopPrmLinkVO topPrmLinkVo = prmList.get(i);
			
			JSONObject obj = new JSONObject();
			
			obj.put("pllink", topPrmLinkVo.getPllink());
			obj.put("plname", topPrmLinkVo.getPlname());

			arr.add(obj);
		}
		
		String jsonStr = arr.toString();
		out.print(jsonStr);
		
	}
	
	@RequestMapping(value = "pwdEditeRec", method = RequestMethod.GET)
	public String pwdEditeRec(Model model, HttpSession session) {
		
		logger.info("pwdEditeRec");
		
		return "top_main/top_pwd_edite_rec";
	}
	
	@RequestMapping(value = "prmEdite", method = RequestMethod.GET)
	public String prmEdite(Model model, HttpSession session) {
		
		logger.info("prmEdite");
		
		List<TopPrmLinkVO> prmList = sqlSession.selectList("TopPrmLink.getPrmList");
		
		model.addAttribute("prmList", prmList);
		
		return "top_main/top_prm_pop";
	}
	
	
	@RequestMapping(value = "prmNameSel", method = RequestMethod.POST)
	public void prmNameSel(String plno, HttpServletResponse response ) {
		
		logger.info("prmNameSel");
		
		TopPrmLinkVO topPrmLinkVo = sqlSession.selectOne("TopPrmLink.getPrmOne", plno);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		
		PrintWriter out = null;
		
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		if(!topPrmLinkVo.getPlname().equals("")){
			out.print(topPrmLinkVo.getPlname()+"+"+topPrmLinkVo.getPllink());						
		}else{
			out.print("");
		}
		
	}
	
	
//	@RequestMapping(value = "prmOk", method = RequestMethod.POST)
//	public void prmOk(HttpServletResponse response,HttpSession session, TopPrmLinkVO topPrmLinkVo, PrintWriter out, String action ) {
//		
//		logger.info("prmOk");
//		
//		int result = 0;
//		
//		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
//		
//		topPrmLinkVo.setUser(mbrVo.getUser_no());
//		
//		if(action.equals("0")){
//			result = sqlSession.update("TopPrmLink.uptPrm", topPrmLinkVo);			
//			out.print(result);
//		}else if(action.equals("1")){
//			result = sqlSession.insert("TopPrmLink.insPrm", topPrmLinkVo);
//			out.print(topPrmLinkVo.getPlno());
//		}
//	}
	
	
	@RequestMapping(value = "prmDel", method = RequestMethod.POST)
	public void prmDel(HttpServletResponse response,HttpSession session, String plno, PrintWriter out) {
		
		logger.info("prmDel");
		
		int result = sqlSession.delete("TopPrmLink.prmDel",plno);
		
		out.print(result);
	}
	
	@RequestMapping(value = "noSendMemberListModal")
	public String noSendMemberListModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= noSendMemberListModal =======");
						
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sTeam_id = paramMap.get("team_id").toString();
		
		//System.out.println("team_id="+paramMap.get("team_id").toString());
		
		List<EmpNmlstTmDtlVO> memberList = sqlSession.selectList("empNmlstTmDtlMapper.getMemberAll",sTeam_id);
		
		paramMap.put("team_id", sTeam_id);
		
		Map<String, Object> noSendCnt;
		
		for(int i=0; i < memberList.size(); i++) {
			paramMap.put("user_no", memberList.get(i).getUser_no());
			noSendCnt = sqlSession.selectOne("TopLoginMapper.selectNoSendMemberList", paramMap);
			memberList.get(i).setnNoSend_Type1(Integer.parseInt(noSendCnt.get("type1_cnt").toString()));
			memberList.get(i).setnNoSend_Type5(Integer.parseInt(noSendCnt.get("type5_cnt").toString()));
			memberList.get(i).setnNoSend_Type10(Integer.parseInt(noSendCnt.get("type10_cnt").toString()));
			memberList.get(i).setnNoSend_Total(Integer.parseInt(noSendCnt.get("total_cnt").toString()));
		}
		
		//List<Map<String, Object>> memberList = sqlSession.selectList("TopLoginMapper.selectNoSendMemberList", sTeam_id);
		
		//System.out.println("team_name : "+userinfoList.get(0).getTeam_name());
		
		//팀이름
		model.addAttribute("team_name", memberList.get(0).getTeam_name());
		
		model.addAttribute("memberList", memberList);

		//return "top_mbr_vacation/vacation_update_approval_modal";
		return "top_main/nosend_memberlist_modal";
	}
	
	@RequestMapping(value = "noSendReportListModal")
	public String noSendReportListModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= noSendReportListModal =======");
						
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sUser_no = paramMap.get("user_no").toString();
		String sUser_name = paramMap.get("user_name").toString();
		
		List<Map<String, Object>> reportList = sqlSession.selectList("TopLoginMapper.selectNoSendReportList", paramMap);
		
		Map<String,Object> sendResult;
		String sSuim_rpt_no = "";
		
		for(int i=0; i < reportList.size(); i++) {			
			sSuim_rpt_no = reportList.get(i).get("suim_rpt_no").toString();
			sendResult = sqlSession.selectOne("TopLoginMapper.selectNoSendReportResult", sSuim_rpt_no);
			reportList.get(i).put("con_method", sendResult.get("con_method").toString());
			reportList.get(i).put("ins_method", sendResult.get("ins_method").toString());
			reportList.get(i).put("cla_method", sendResult.get("cla_method").toString());
		}		
		
		model.addAttribute("user_name", sUser_name);
		model.addAttribute("reportList", reportList);
		
		return "top_main/nosend_reportlist_modal";
	}


}//end of class
