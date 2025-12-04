/*
*********************************************************
* Program ID	: PrimbizSuimListController
* Program Name	: PrimbizSuimListController
* Description	: 농작물 수임대장 리스트
* Author		: 
* Date			: 2016.06.09.
*********************************************************
*/
package kr.co.toplac.topindividual;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.topsuim.TopRptHeadVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.RequestUtil;

@Controller
public class MyNoSiteListController {

	private static final Logger logger = LoggerFactory.getLogger(MyNoSiteListController.class);

	@Autowired
	private SqlSession sqlSession;

	/*
	*********************************************************
	* Program ID	: myNoSiteList
	* Program Name	: myNoSiteList
	* Description	: 현장 중간 미보고 목록
	* Author		: 
	* Date			: 2016.10.07.
	*********************************************************
	*/
	
	@RequestMapping(value = "myNoSiteList", method = RequestMethod.GET)
	public String myNoSiteList(Model model, HttpSession session, HttpServletRequest request
			, String reqPgNo, String presentPage) {
		logger.info("======= myNoSiteList =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("myNoSiteList - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("user_no", mbrVo.getUser_no());
		map.put("team_id", mbrVo.getTeam_id_main());

		if(mbrVo.getTeam_type().equals("1") || mbrVo.getTeam_type().equals("0")){
	        Date today = new Date();
	        DateFormat dayFormat = new SimpleDateFormat("ddHH");
	        String nowDay = dayFormat.format(today);//String형으로 변환
	        map.put("now_day",nowDay);
			
	        
			if(presentPage == null || presentPage.equals("") || presentPage.equals("mynositetab")){
				//현장 3일이내 미제출
				List<TopRptHeadVO> myNoSiteList = null;
				myNoSiteList = sqlSession.selectList("MyNoSiteListMapper.getMyNoSiteListPop", map);
				model.addAttribute("myNoSiteList", myNoSiteList);
			}
			
			
			if(presentPage == null || presentPage.equals("") || presentPage.equals("mynositeovertab")){
				//현장 3일 초과
				List<TopRptHeadVO> myNoSiteOverList = null;
				myNoSiteOverList = sqlSession.selectList("MyNoSiteListMapper.getMyNoSiteOverListPop", map);
				model.addAttribute("myNoSiteOverList", myNoSiteOverList);
			}
			
			
			if(presentPage == null || presentPage.equals("") || presentPage.equals("mynointerimtab")){
				//중간 미제출
				List<TopRptHeadVO> myNoInterimList = null;
				myNoInterimList = sqlSession.selectList("MyNoSiteListMapper.getMyNoInterimListPop", map);
				model.addAttribute("myNoInterimList", myNoInterimList);
			}
			
			if(presentPage == null || presentPage.equals("") || presentPage.equals("mynointerim5daytab")){
				//중간-5일
				List<TopRptHeadVO> myNoInterim5DayList = null;
				myNoInterim5DayList = sqlSession.selectList("MyNoSiteListMapper.getMyNoInterim5DayListPop", map);
				model.addAttribute("myNoInterim5DayList", myNoInterim5DayList);
			}
			
			if(presentPage == null || presentPage.equals("") || presentPage.equals("mynointerim2tab")){
				//진행경과 미제출
				List<TopRptHeadVO> myNoInterimList2 = null;
				myNoInterimList2 = sqlSession.selectList("MyNoSiteListMapper.getMyNoInterimList2Pop", map);
				model.addAttribute("myNoInterimList2", myNoInterimList2);
			}	

			if(presentPage == null || presentPage.equals("") || presentPage.equals("mynointerim5day2tab")){
				//진행경과-5일 미제출
				List<TopRptHeadVO> myNoInterim5DayList2 = null;
				myNoInterim5DayList2 = sqlSession.selectList("MyNoSiteListMapper.getMyNoInterim5DayList2Pop", map);
				model.addAttribute("myNoInterim5DayList2", myNoInterim5DayList2);			
			}
			
			if(presentPage == null || presentPage.equals("") || presentPage.equals("mynosagotab")){
				//사고처리과정표 
				List<TopRptHeadVO> myNoSagoListPop = null;
				myNoSagoListPop = sqlSession.selectList("MyNoSiteListMapper.getMyNoSagoListPop", map);
				model.addAttribute("myNoSagoListPop", myNoSagoListPop);			
			}
			
			if(presentPage == null || presentPage.equals("") || presentPage.equals("mynonowtab")){
				//미결사유
				List<TopRptHeadVO> myNoNowListPop = null;
				myNoNowListPop = sqlSession.selectList("MyNoSiteListMapper.getMyNoNowListPop", map);
				model.addAttribute("myNoNowListPop", myNoNowListPop);
			}
			
			if(presentPage == null || presentPage.equals("") || presentPage.equals("mynoprbtab")){
				//문제점
				List<TopRptHeadVO> myNoPrbListPop = null;
				myNoPrbListPop = sqlSession.selectList("MyNoSiteListMapper.getMyNoPrbListPop", map);
				model.addAttribute("myNoPrbListPop", myNoPrbListPop);
			}
			
			if(presentPage == null || presentPage.equals("") || presentPage.equals("mynoplntab")){
				//향후처리
				List<TopRptHeadVO> myNoPlnListPop = null;
				myNoPlnListPop = sqlSession.selectList("MyNoSiteListMapper.getMyNoPlnListPop", map);
				model.addAttribute("myNoPlnListPop", myNoPlnListPop);
			}
			
			
			

			
			if(presentPage == null || presentPage.equals("") || presentPage.equals("tmnositetab")){
				//팀현장 3일이내 미제출
				List<TopRptHeadVO> tmNoSiteList = null;
				tmNoSiteList = sqlSession.selectList("MyNoSiteListMapper.getTmNoSiteListPop", map);
				model.addAttribute("tmNoSiteList", tmNoSiteList);
			}
			
			
			if(presentPage == null || presentPage.equals("") || presentPage.equals("tmnositeovertab")){
				//팀현장 3일 초과
				List<TopRptHeadVO> tmNoSiteOverList = null;
				tmNoSiteOverList = sqlSession.selectList("MyNoSiteListMapper.getTmNoSiteOverListPop", map);
				model.addAttribute("tmNoSiteOverList", tmNoSiteOverList);
			}
			
			if(presentPage == null || presentPage.equals("") || presentPage.equals("tmnointerim5daytab")){
				//팀중간-5일
				List<TopRptHeadVO> tmNoInterim5DayList = null;
				tmNoInterim5DayList = sqlSession.selectList("MyNoSiteListMapper.getTmNoInterim5DayListPop", map);
				model.addAttribute("tmNoInterim5DayList", tmNoInterim5DayList);
			}		
			
			if(presentPage == null || presentPage.equals("") || presentPage.equals("tmnointerimtab")){
				//팀중간 미제출
				List<TopRptHeadVO> tmNoInterimList = null;
				tmNoInterimList = sqlSession.selectList("MyNoSiteListMapper.getTmNoInterimListPop", map);
				model.addAttribute("tmNoInterimList", tmNoInterimList);
			}
			

			
//			
//			if(presentPage == null || presentPage.equals("") || presentPage.equals("tmnositetab")){
//				List<TopRptHeadVO> tmNoSiteList = null;
//				tmNoSiteList = sqlSession.selectList("MyNoSiteListMapper.getTmNoSiteListPop", map);
//				model.addAttribute("tmNoSiteList", tmNoSiteList);
//			}
//			
//			if(presentPage == null || presentPage.equals("") || presentPage.equals("tmnointerimtab")){
//				List<TopRptHeadVO> tmNoInterimList = null;
//				tmNoInterimList = sqlSession.selectList("MyNoSiteListMapper.getTmNoInterimListPop", map);
//				model.addAttribute("tmNoInterimList", tmNoInterimList);
//			}
//			
			
			
			
		}else{
			if(presentPage == null || presentPage.equals("") || presentPage.equals("mykind4mitab")){
				List<TopRptHeadVO> myKind4MiList = null;
				myKind4MiList = sqlSession.selectList("MyNoSiteListMapper.getMyKind4MiListPop", map);
				model.addAttribute("myKind4MiList", myKind4MiList);
			}
		}		
		
		
		
/*20170612		
		if(mbrVo.getTeam_type().equals("1")){
			if(presentPage == null || presentPage.equals("") || presentPage.equals("mynositetab")){
				List<TopRptHeadVO> myNoSiteList = null;
				myNoSiteList = sqlSession.selectList("MyNoSiteListMapper.getMyNoSiteListPop", map);
				model.addAttribute("myNoSiteList", myNoSiteList);
			}
			if(presentPage == null || presentPage.equals("") || presentPage.equals("mynointerimtab")){
				List<TopRptHeadVO> myNoInterimList = null;
				myNoInterimList = sqlSession.selectList("MyNoSiteListMapper.getMyNoInterimListPop", map);
				model.addAttribute("myNoInterimList", myNoInterimList);
			}
			if(presentPage == null || presentPage.equals("") || presentPage.equals("mynointerim2tab")){
				List<TopRptHeadVO> myNoInterimList2 = null;
				myNoInterimList2 = sqlSession.selectList("MyNoSiteListMapper.getMyNoInterimList2Pop", map);
				model.addAttribute("myNoInterimList2", myNoInterimList2);
			}
			if(presentPage == null || presentPage.equals("") || presentPage.equals("tmnositetab")){
				List<TopRptHeadVO> tmNoSiteList = null;
				tmNoSiteList = sqlSession.selectList("MyNoSiteListMapper.getTmNoSiteListPop", map);
				model.addAttribute("tmNoSiteList", tmNoSiteList);
			}
			if(presentPage == null || presentPage.equals("") || presentPage.equals("tmnointerimtab")){
				List<TopRptHeadVO> tmNoInterimList = null;
				tmNoInterimList = sqlSession.selectList("MyNoSiteListMapper.getTmNoInterimListPop", map);
				model.addAttribute("tmNoInterimList", tmNoInterimList);
			}
		}else{
			if(presentPage == null || presentPage.equals("") || presentPage.equals("mykind4mitab")){
				List<TopRptHeadVO> myKind4MiList = null;
				myKind4MiList = sqlSession.selectList("MyNoSiteListMapper.getMyKind4MiListPop", map);
				model.addAttribute("myKind4MiList", myKind4MiList);
			}
		}
*/
/* 20170201
		PageUtilityBasic pageUtil = new PageUtilityBasic();

		if(presentPage == null || presentPage.equals("") || presentPage.equals("mynositetab")){
			List<TopRptHeadVO> myNoSiteList = null;
			myNoSiteList = (List<TopRptHeadVO>) pageUtil.pageBasic1Search(1, sqlSession, "MyNoSiteListMapper.getMyNoSiteList", reqPgNo, model, "myNoSiteList", map);
			model.addAttribute("myNoSiteList", myNoSiteList);
		}

		if(presentPage == null || presentPage.equals("") || presentPage.equals("mynointerimtab")){
			List<TopRptHeadVO> myNoInterimList = null;
			myNoInterimList = (List<TopRptHeadVO>) pageUtil.pageBasic1Search(2, sqlSession, "MyNoSiteListMapper.getMyNoInterimList", reqPgNo, model, "myNoSiteList", map);
			model.addAttribute("myNoInterimList", myNoInterimList);
		}

		if(presentPage == null || presentPage.equals("") || presentPage.equals("mynointerim2tab")){
			List<TopRptHeadVO> myNoInterimList2 = null;
			myNoInterimList2 = (List<TopRptHeadVO>) pageUtil.pageBasic1Search(5, sqlSession, "MyNoSiteListMapper.getMyNoInterimList2", reqPgNo, model, "myNoSiteList", map);
			model.addAttribute("myNoInterimList2", myNoInterimList2);
		}

		if(presentPage == null || presentPage.equals("") || presentPage.equals("mykind4mitab")){
			List<TopRptHeadVO> myKind4MiList = null;
			myKind4MiList = (List<TopRptHeadVO>) pageUtil.pageBasic1Search(6, sqlSession, "MyNoSiteListMapper.getMyKind4MiList", reqPgNo, model, "myNoSiteList", map);
			model.addAttribute("myKind4MiList", myKind4MiList);
		}

		if(presentPage == null || presentPage.equals("") || presentPage.equals("tmnositetab")){
			List<TopRptHeadVO> tmNoSiteList = null;
			tmNoSiteList = (List<TopRptHeadVO>) pageUtil.pageBasic1Search(3, sqlSession, "MyNoSiteListMapper.getTmNoSiteList", reqPgNo, model, "myNoSiteList", map);
			model.addAttribute("tmNoSiteList", tmNoSiteList);
		}

		if(presentPage == null || presentPage.equals("") || presentPage.equals("tmnointerimtab")){
			List<TopRptHeadVO> tmNoInterimList = null;
			tmNoInterimList = (List<TopRptHeadVO>) pageUtil.pageBasic1Search(4, sqlSession, "MyNoSiteListMapper.getTmNoInterimList", reqPgNo, model, "myNoSiteList", map);
			model.addAttribute("tmNoInterimList", tmNoInterimList);
		}
*/
		return "top_individual/my_no_main";
	}//myNoSiteList
	
	@RequestMapping(value = "mySubListPop", method = RequestMethod.GET)
	public String mySubListPop(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= mySubListPop =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("myNoSiteListPop - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		String user_no = mbrVo.getUser_no();
		
		Map<String, String> paramMap = new HashMap<>();
		
		paramMap.put("user_no", user_no);
		
		/* 겸직 목록 추출*/
		List<Map<String, Object>> subJobList = sqlSession.selectList("TopMbrDtlMapper.selectSubjobList",paramMap);
		
		String subTeam = "";
		
		for(int i=0; i < subJobList.size(); i++) {			
			subTeam += subJobList.get(i).get("teamIdMain").toString()+",";			
		}
		
		subTeam = subTeam.substring(0, subTeam.length()-1);
		
		paramMap.put("sub_team_id", subTeam);
		
		List<TopRptHeadVO> mySubList = sqlSession.selectList("MyNoSiteListMapper.getMySubListPop", paramMap);
		
		model.addAttribute("myNoSiteList", mySubList);
		
		return "top_individual/my_no_sub_pop";
	}
	
	@RequestMapping(value = "memberNoSiteListPop", method = RequestMethod.POST)
	public String memberNoSiteListPop(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= memberNoSiteListPop =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("memberNoSiteListPop - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		//탭키
		String sMenuType = "";
		String sUserNo = "";
		String sEndAverage = "";
		
		sMenuType = paramMap.get("pop_menutype").toString();
		sUserNo = paramMap.get("pop_userno").toString();
		sEndAverage = paramMap.get("pop_end_average").toString();
		
		String titleUserName = "";
		String titleTeamName = "";		
		
		Map<String,Object> popUserInfo = sqlSession.selectOne("MyNoSiteListMapper.getPopUserInfoTitle", sUserNo);
		titleUserName = popUserInfo.get("user_name").toString();
		titleTeamName = popUserInfo.get("team_name").toString();
		
		model.addAttribute("title_username", titleUserName);
		model.addAttribute("title_teamname", titleTeamName);
		
		//근무일기준(공유일체크) 3일전 기준날짜 시작
		String sBeforeWorkDay = DateUtil.getChkDateTo3Workdays(sqlSession, "");		//오늘기준		
		
		paramMap.put("before_workday", sBeforeWorkDay);
		paramMap.put("user_no", sUserNo);
		//근무일기준(공유일체크) 3일전 기준날짜 끝		
		
		//30일내 수임건 목록
		List<TopRptHeadVO> suim30List = sqlSession.selectList("MyNoSiteListMapper.getMemberNoSiteListPop30Suim", sUserNo);
		model.addAttribute("suim30List", suim30List);
		
		//3일내 현장보고서 제출목록
		List<TopRptHeadVO> sub3InList = sqlSession.selectList("MyNoSiteListMapper.getMemberNoSiteListPopSub3In", sUserNo);
		model.addAttribute("sub3InList", sub3InList);
		
		//3일초과 현장보고서 제출목록
		List<TopRptHeadVO> sub3OverList = sqlSession.selectList("MyNoSiteListMapper.getMemberNoSiteListPopSub3Over", sUserNo);
		model.addAttribute("sub3OverList", sub3OverList);
		
		//3일내 현장보고서 미제출목록
		//List<TopRptHeadVO> not3InList = sqlSession.selectList("MyNoSiteListMapper.getMemberNoSiteListPopNot3In", sUserNo);
		List<TopRptHeadVO> not3InList = sqlSession.selectList("MyNoSiteListMapper.getMemberNoSiteListPopNot3InParam", paramMap);
		model.addAttribute("not3InList", not3InList);
		
		//3일초과 현장보고서 미제출목록
		//List<TopRptHeadVO> not3OverList = sqlSession.selectList("MyNoSiteListMapper.getMemberNoSiteListPopNot3Over", sUserNo);
		List<TopRptHeadVO> not3OverList = sqlSession.selectList("MyNoSiteListMapper.getMemberNoSiteListPopNot3OverParam", paramMap);
		model.addAttribute("not3OverList", not3OverList);
		
		//30일초과 현장보고서 제출목록
		List<TopRptHeadVO> not30OverList = sqlSession.selectList("MyNoSiteListMapper.getMemberNoSiteListPopNot30Over", sUserNo);
		model.addAttribute("not30OverList", not30OverList);
		
		//처리기한 목록		
		String sToday = DateUtil.getTodayString("yyyy-MM-dd");    	
		String sStartYear = DateUtil.getStartYearDay(sToday);
		String sEndYear = DateUtil.getEndYearDay(sToday);

		paramMap.put("start_date", sStartYear);
		paramMap.put("end_date", sEndYear);
		paramMap.put("user_no", sUserNo);
		
		try {
    		String textDate = DateUtil.getTextDateFormat(sStartYear);
    		model.addAttribute("start_date", textDate);
		} catch (Exception e) {
			logger.error("parseError : "+e.getMessage());
		}
		
		List<TopRptHeadVO> endAverageList = sqlSession.selectList("MyNoSiteListMapper.getMemberNoSiteListPopEndAverage", paramMap);
		model.addAttribute("endAverageList", endAverageList);
		
		//CommonUtils.printMap(paramMap);
		
		model.addAttribute("menuType", sMenuType);
		model.addAttribute("end_average_cnt", sEndAverage);		
		
		return "top_individual/member_no_main_pop";
	}

	/*
	*********************************************************
	* Program ID	: myNoSiteListPop
	* Program Name	: myNoSiteListPop
	* Description	: 현장 중간 미보고 목록
	* Author		: 
	* Date			: 2016.10.07.
	*********************************************************
	*/
	@RequestMapping(value = "myNoSiteListPop", method = RequestMethod.GET)
	public String myNoSiteListPop(Model model, HttpSession session, HttpServletRequest request
			, String tmNo, String UsrNo, String reqPgNo, String presentPage) {

		logger.info("======= myNoSiteListPop =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("myNoSiteListPop - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		HashMap<String, Object> map = new HashMap<String, Object>();
		if(tmNo != null && !tmNo.equals("") && UsrNo != null && !UsrNo.equals("")){
			map.put("user_no", UsrNo);
			map.put("team_id", tmNo);
		}else{
			map.put("user_no", mbrVo.getUser_no());
			map.put("team_id", mbrVo.getTeam_id_main());
		}

		if(mbrVo.getTeam_type().equals("1") || mbrVo.getTeam_type().equals("0")){
	        Date today = new Date();
	        DateFormat dayFormat = new SimpleDateFormat("ddHH");
	        String nowDay = dayFormat.format(today);//String형으로 변환
	        map.put("now_day",nowDay);
			
			//현장 3일이내 미제출
			List<TopRptHeadVO> myNoSiteList = null;
			myNoSiteList = sqlSession.selectList("MyNoSiteListMapper.getMyNoSiteListPop", map);
			model.addAttribute("myNoSiteList", myNoSiteList);

			//현장 3일 초과
			List<TopRptHeadVO> myNoSiteOverList = null;
			myNoSiteOverList = sqlSession.selectList("MyNoSiteListMapper.getMyNoSiteOverListPop", map);
			model.addAttribute("myNoSiteOverList", myNoSiteOverList);
			
			//중간 미제출
			List<TopRptHeadVO> myNoInterimList = null;
			myNoInterimList = sqlSession.selectList("MyNoSiteListMapper.getMyNoInterimListPop", map);
			model.addAttribute("myNoInterimList", myNoInterimList);
			
			//중간-5일
			List<TopRptHeadVO> myNoInterim5DayList = null;
			myNoInterim5DayList = sqlSession.selectList("MyNoSiteListMapper.getMyNoInterim5DayListPop", map);
			model.addAttribute("myNoInterim5DayList", myNoInterim5DayList);
			
			//진행경과 미제출
			List<TopRptHeadVO> myNoInterimList2 = null;
			myNoInterimList2 = sqlSession.selectList("MyNoSiteListMapper.getMyNoInterimList2Pop", map);
			model.addAttribute("myNoInterimList2", myNoInterimList2);
			
			//진행경과-5일 미제출
			List<TopRptHeadVO> myNoInterim5DayList2 = null;
			myNoInterim5DayList2 = sqlSession.selectList("MyNoSiteListMapper.getMyNoInterim5DayList2Pop", map);
			model.addAttribute("myNoInterim5DayList2", myNoInterim5DayList2);			
			
			//사고처리과정표 
			List<TopRptHeadVO> myNoSagoListPop = null;
			myNoSagoListPop = sqlSession.selectList("MyNoSiteListMapper.getMyNoSagoListPop", map);
			model.addAttribute("myNoSagoListPop", myNoSagoListPop);			
			
			//미결사유
			List<TopRptHeadVO> myNoNowListPop = null;
			myNoNowListPop = sqlSession.selectList("MyNoSiteListMapper.getMyNoNowListPop", map);
			model.addAttribute("myNoNowListPop", myNoNowListPop);
			
			//문제점
			List<TopRptHeadVO> myNoPrbListPop = null;
			myNoPrbListPop = sqlSession.selectList("MyNoSiteListMapper.getMyNoPrbListPop", map);
			model.addAttribute("myNoPrbListPop", myNoPrbListPop);
			
			//향후처리방안
			List<TopRptHeadVO> myNoPlnListPop = null;
			myNoPlnListPop = sqlSession.selectList("MyNoSiteListMapper.getMyNoPlnListPop", map);
			model.addAttribute("myNoPlnListPop", myNoPlnListPop);
			
			
		}else{
			List<TopRptHeadVO> myKind4MiList = null;
			myKind4MiList = sqlSession.selectList("MyNoSiteListMapper.getMyKind4MiListPop", map);
			model.addAttribute("myKind4MiList", myKind4MiList);
		}

/* 20170201
		PageUtilityBasic pageUtil = new PageUtilityBasic();

		if(presentPage == null || presentPage.equals("") || presentPage.equals("mynositetab")){
			List<TopRptHeadVO> myNoSiteList = null;
			myNoSiteList = (List<TopRptHeadVO>) pageUtil.pageBasic1Search(1, sqlSession, "MyNoSiteListMapper.getMyNoSiteList", reqPgNo, model, "myNoSiteList", map);
			model.addAttribute("myNoSiteList", myNoSiteList);
		}

		if(presentPage == null || presentPage.equals("") || presentPage.equals("mynointerimtab")){
			List<TopRptHeadVO> myNoInterimList = null;
			myNoInterimList = (List<TopRptHeadVO>) pageUtil.pageBasic1Search(2, sqlSession, "MyNoSiteListMapper.getMyNoInterimList", reqPgNo, model, "myNoSiteList", map);
			model.addAttribute("myNoInterimList", myNoInterimList);
		}

		if(presentPage == null || presentPage.equals("") || presentPage.equals("mynointerim2tab")){
			List<TopRptHeadVO> myNoInterimList2 = null;
			myNoInterimList2 = (List<TopRptHeadVO>) pageUtil.pageBasic1Search(5, sqlSession, "MyNoSiteListMapper.getMyNoInterimList2", reqPgNo, model, "myNoSiteList", map);
			model.addAttribute("myNoInterimList2", myNoInterimList2);
		}

		if(presentPage == null || presentPage.equals("") || presentPage.equals("mykind4mitab")){
			List<TopRptHeadVO> myKind4MiList = null;
			myKind4MiList = (List<TopRptHeadVO>) pageUtil.pageBasic1Search(6, sqlSession, "MyNoSiteListMapper.getMyKind4MiList", reqPgNo, model, "myNoSiteList", map);
			model.addAttribute("myKind4MiList", myKind4MiList);
		}
*/
		return "top_individual/my_no_main_pop";
	}//myNoSiteListPop

}//end of class
