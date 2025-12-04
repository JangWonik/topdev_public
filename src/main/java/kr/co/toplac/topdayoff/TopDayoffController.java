/*
*********************************************************
* Program ID	: PrimbizSuimListController
* Program Name	: PrimbizSuimListController
* Description	: 농작물 수임대장 리스트
* Author		: 
* Date			: 2016.06.09.
*********************************************************
*/
package kr.co.toplac.topdayoff;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

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

import kr.co.toplac.topcost.TopCostCompositeVO;
import kr.co.toplac.topindividual.MyDayoffVO;
import kr.co.toplac.topmain.MainLeftSuimVO;
import kr.co.toplac.topprimbiz.TopPrimBizRptHeadVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.page.PageUtilityBasic;
import kr.co.toplac.util.rpt.MainLeftUtil;

@Controller
public class TopDayoffController {

	private static final Logger logger = LoggerFactory.getLogger(TopDayoffController.class);

	@Autowired
	private SqlSession sqlSession;

	@Autowired
	MainLeftUtil mlu;

	/*
	*********************************************************
	* Program ID	: 
	* Program Name	: 
	* Description	: 연차내역 결제 리스트
	* Author		: 
	* Date			: 2016.12.20.
	*********************************************************
	*/
	@RequestMapping(value = "topDayoffList", method = RequestMethod.GET)
	public String topDayoffList(Model model, HttpSession session, TopDayoffVO dayoffVO, TopMbrBscVO tmbVO, HttpServletRequest request
			, String reqPgNo, String presentPage, String ustat, String tid, String searchStr, String[] chkdayoff ) {

		logger.info("topDayoffList");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("myDayoffInsList - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());
		
		/*검색에 사용될 팀목록 추출*/
		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
		model.addAttribute("teamList", teamList);
		
		//해당월 조회기간 구하기 시작
		String fromdate = dayoffVO.getViewFromDate();
		String todate = dayoffVO.getViewToDate();
		String toServerYear = dayoffVO.getToServerYear();
		Calendar today = Calendar.getInstance();
		int dateInt = today.get(Calendar.DATE);
		int monthInt = today.get(Calendar.MONTH) + 1;
		int yearInt = today.get(Calendar.YEAR);
		if(toServerYear == null || toServerYear.equals("")){
			toServerYear = ""+yearInt;
		}
		model.addAttribute("yearInt",yearInt);
		model.addAttribute("toServerYear",toServerYear);
		
		String user_no = (String) session.getAttribute("user_no_Session");
		String work_level = mbrVo.getWork_level_cd();
		String team_id = mbrVo.getTeam_id_main();
		String team_name = mbrVo.getTeam_name();
		String work_type_state = mbrVo.getWork_type_cd();
		dayoffVO.setUser_no(user_no);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("toServerYear", toServerYear);
		map.put("user_no", user_no);
		map.put("team_id", team_id);
		map.put("ustat", ustat);
		map.put("tid", tid);
		map.put("searchStr", searchStr);
		
		model.addAttribute("user_no",user_no);
		model.addAttribute("team_id",team_id);
		model.addAttribute("team_name",team_name);
		model.addAttribute("work_level",work_level);
		model.addAttribute("work_type_state",work_type_state);
		model.addAttribute("ustat",ustat);
		model.addAttribute("tid",tid);
		
		String returnURL = ""; 
		if(user_no.equals("966") || user_no.equals("215") || user_no.equals("670")){
			returnURL = "top_dayoff/top_dayoff_list";
			map.put("type", "manager");
		} else {
			returnURL = "top_dayoff/top_dayoff_mid_list";
			map.put("type", "team");
			
		}
		
		PageUtilityBasic pageUtil = new PageUtilityBasic();
		List<TopDayoffVO> getTopDayoff = (List<TopDayoffVO>) pageUtil.pageBasic1Search(1, sqlSession, "TopDayoff.getTopDayoffList", reqPgNo, model, "topDayoffList", map);
		model.addAttribute("getTopDayoff",getTopDayoff);
		model.addAttribute("reqPgNo",reqPgNo);
		model.addAttribute("searchStr",searchStr);
		
		
		//List<TopDayoffVO> getTopDayoff = sqlSession.selectList("TopDayoff.getTopDayoffList" ,map);
		
		/* 리소스 낭비로 쿼리 통합 180116 lds
		List<TopDayoffVO> getTopDayoffMid
		= (List<TopDayoffVO>) pageUtil.pageBasic1Search(2, sqlSession, "TopDayoff.getTopDayoffMidList", reqPgNo, model, "topDayoffList", map);
		model.addAttribute("TopDayoffmidMid",getTopDayoffMid);
		*/
		
		return returnURL;

	}
	
	@RequestMapping(value = "DayoffUserListPop", method = RequestMethod.GET)
	public String DayoffUserListPop(Model model, HttpSession session, TopDayoffVO dayoffVO, TopMbrBscVO tmbVO, HttpServletRequest request
			, String reqPgNo, String presentPage, String ustat, String tid, String searchStr, String[] chkdayoff, String user_no ) {

		logger.info("topDayoffList");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("myDayoffInsList - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
//		
//		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
//		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());
		
		String work_level = mbrVo.getWork_level_cd();
		String team_id = mbrVo.getTeam_id_main();
		String team_name = mbrVo.getTeam_name();
		String work_type_state = mbrVo.getWork_type_cd();
		dayoffVO.setUser_no(user_no);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("user_no", user_no);
		map.put("team_id", team_id);
		map.put("ustat", ustat);
		map.put("tid", tid);
		map.put("searchStr", searchStr);
		
		model.addAttribute("user_no",user_no);
		model.addAttribute("team_id",team_id);
		model.addAttribute("team_name",team_name);
		model.addAttribute("work_level",work_level);
		model.addAttribute("work_type_state",work_type_state);
		model.addAttribute("ustat",ustat);
		model.addAttribute("tid",tid);
		
//		List<TopDayoffVO> getTopDayoffUserList = sqlSession.selectList("TopDayoff.getTopDayoffUserList" ,map);
//		model.addAttribute("getTopDayoffUserList",getTopDayoffUserList);
		PageUtilityBasic pageUtil = new PageUtilityBasic();
		List<TopDayoffVO> getTopDayoffUserList
		= (List<TopDayoffVO>) pageUtil.pageBasic1Search(1, sqlSession, "TopDayoff.getTopDayoffUserList", reqPgNo, model, "DayoffUserListPop", map);
		model.addAttribute("getTopDayoffUserList",getTopDayoffUserList);
//		
//		List<TopDayoffVO> getTopDayoffMid
//		= (List<TopDayoffVO>) pageUtil.pageBasic1Search(2, sqlSession, "TopDayoff.getTopDayoffMidList", reqPgNo, model, "topDayoffList", map);
//		model.addAttribute("TopDayoffmidMid",getTopDayoffMid);
		
//		if(work_type_state.equals("3") && user_no.equals("38")){
		
			return "top_dayoff/top_dayoff_user_list";
		
	}
	
	@RequestMapping(value = "topDayoffMidSign", method = RequestMethod.GET)
	public String topDayoffMidSign(Model model, HttpSession session, TopDayoffVO dayoffVO, TopMbrBscVO tmbVO, HttpServletRequest request
			, String reqPgNo, String presentPage, String ustat, String tid, String searchStr, String[] chkdayoff ) {

		logger.info("topDayoffMidSign");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("myDayoffInsList - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		//해당월 조회기간 구하기 시작
		String fromdate = dayoffVO.getViewFromDate();
		String todate = dayoffVO.getViewToDate();
		String toServerYear = dayoffVO.getToServerYear();
		Calendar today = Calendar.getInstance();
		int dateInt = today.get(Calendar.DATE);
		int monthInt = today.get(Calendar.MONTH) + 1;
		int yearInt = today.get(Calendar.YEAR);
		if(toServerYear == null || toServerYear.equals("")){
			toServerYear = ""+yearInt;
		}
		System.out.println("toServerYear:"+toServerYear);
		model.addAttribute("yearInt",yearInt);
		model.addAttribute("toServerYear",toServerYear);
		
		
		String user_no = (String) session.getAttribute("user_no_Session");
		String work_level = mbrVo.getWork_level_cd();
		String team_id = mbrVo.getTeam_id_main();
		String team_name = mbrVo.getTeam_name();
		String work_type_state = mbrVo.getWork_type_cd();
		dayoffVO.setUser_no(user_no);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("toServerYear", toServerYear);
		map.put("user_no", user_no);
		map.put("team_id", team_id);
		map.put("ustat", ustat);
		map.put("tid", tid);
		map.put("searchStr", searchStr);
		
		if(chkdayoff != null){
			for(int i=0; i<chkdayoff.length; i++){
				
				map.put("chkdayoff", chkdayoff[i]);
				int dayoffMidSignUdt = sqlSession.update("TopDayoff.dayoffMidSignUdt",map);
				
			}
		}
		
		model.addAttribute("user_no",user_no);
		model.addAttribute("team_id",team_id);
		model.addAttribute("team_name",team_name);
		model.addAttribute("work_level",work_level);
		model.addAttribute("work_type_state",work_type_state);
		model.addAttribute("ustat",ustat);
		model.addAttribute("tid",tid);
		//model.addAttribute("dayoffMidSignUdt",dayoffMidSignUdt);
		
		return "redirect:topDayoffList";
	}
	
	@RequestMapping(value = "topDayoffSign", method = RequestMethod.GET)
	public String topDayoffSign(Model model, HttpSession session, TopDayoffVO dayoffVO, TopMbrBscVO tmbVO, HttpServletRequest request
			, String reqPgNo, String presentPage, String ustat, String tid, String searchStr, String[] chkdayoff) {

		logger.info("topDayoffSign");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("myDayoffInsList - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		
		String user_no = (String) session.getAttribute("user_no_Session");
		String work_level = mbrVo.getWork_level_cd();
		String team_id = mbrVo.getTeam_id_main();
		String team_name = mbrVo.getTeam_name();
		String work_type_state = mbrVo.getWork_type_cd();
		dayoffVO.setUser_no(user_no);
		
		
		System.out.println(work_level + ":work_level");
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("user_no", user_no);
		map.put("team_id", team_id);
		map.put("ustat", ustat);
		map.put("tid", tid);
		map.put("searchStr", searchStr);
		
		
		System.out.println(chkdayoff);
		System.out.println(chkdayoff[0]);
		
		if(chkdayoff != null){
			for(int i=0; i<chkdayoff.length; i++){
				map.put("chkdayoff", chkdayoff[i]);
				int dayoffSignUdt = sqlSession.update("TopDayoff.dayoffSignUdt",map);
			}
		}
		
		model.addAttribute("user_no",user_no);
		model.addAttribute("team_id",team_id);
		model.addAttribute("team_name",team_name);
		model.addAttribute("work_level",work_level);
		model.addAttribute("work_type_state",work_type_state);
		
		model.addAttribute("ustat",ustat);
		model.addAttribute("tid",tid);
		model.addAttribute("searchStr",searchStr);
		model.addAttribute("reqPgNo",reqPgNo);
		

		//model.addAttribute("dayoffMidSignUdt",dayoffMidSignUdt);
		
		return "redirect:topDayoffList";
	}
	
	@RequestMapping(value = "DayoffReturnPop", method = RequestMethod.GET)
	public String DayoffReturnPop(Model model, HttpSession session, MyDayoffVO dayoffVO, TopMbrBscVO tmbVO, String toServerYear, String serial_no) {
		logger.info("DayoffReturnPop");
		//String strToday = sqlSession.selectOne("MyDayoff.getToday");
		//model.addAttribute("strToday",strToday);
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("myDayoffInsList - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		//해당월 조회기간 구하기 시작
		String year = dayoffVO.getYeartxt();
		//해당월 조회기간 구하기 끝
		
		String user_no = (String) session.getAttribute("user_no_Session");
		dayoffVO.setUser_no(user_no);
		String team_id = dayoffVO.getTeam_id();
		String user_name = dayoffVO.getUser_name();
		String work_level = dayoffVO.getWork_level();
		//String serial_no = dayoffVO.getSerial_no();
		System.out.println("1111111111");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("user_no", user_no);
		map.put("team_id", team_id);
		map.put("toServerYear", toServerYear);
		map.put("serial_no", serial_no);
		System.out.println("222222222222");
		TopDayoffVO selCancelMemo = sqlSession.selectOne("TopDayoff.selCancelMemo", map);
		
		model.addAttribute("team_id",team_id);
		model.addAttribute("user_no",user_no);
		model.addAttribute("user_name",user_name);
		model.addAttribute("work_level",work_level);
		model.addAttribute("serial_no",serial_no);
		model.addAttribute("selCancelMemo",selCancelMemo);
		System.out.println("333333333333");
		return "top_dayoff/top_dayoff_return_pop";
	}
	
		
	@RequestMapping(value = "topDayoffReturn", method = RequestMethod.POST)
	public void topDayoffReturn(Model model, HttpServletResponse response, HttpSession session, MyDayoffVO dayoffVO, TopMbrBscVO tmbVO, String serial_no, String cancel_memo) {

		logger.info("topDayoffReturn");
		System.out.println();
		
		
				
		String user_no = (String) session.getAttribute("user_no_Session");
		dayoffVO.setUser_no(user_no);
		TopMbrBscVO myInfoVo = sqlSession.selectOne("MyEmpCertIns.getMyInfo", user_no);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("user_no", user_no);
		map.put("serial_no", serial_no);
		map.put("cancel_memo", cancel_memo);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
				
		//해당 유저의 월차내역 반려하기
		int dayoffReturn = sqlSession.update("TopDayoff.dayoffReturn", map);
		
		int result = 0;
		if(dayoffReturn > 0){
			
			result = 1;
	}
		
		out.print(result);
	}//primBizInvShareAddOK
	
	
	
	/*@RequestMapping(value = "myDayoffPop", method = RequestMethod.GET)
	public String myDayoffPop(Model model, HttpSession session, TopDayoffVO dayoffVO, TopMbrBscVO tmbVO, String toServerYear) {
		logger.info("myDayoffPop");
		String strToday = sqlSession.selectOne("MyDayoff.getToday");
		model.addAttribute("strToday",strToday);

		//해당월 조회기간 구하기 시작
		String year = dayoffVO.getYeartxt();
		//해당월 조회기간 구하기 끝
		
		String user_no = (String) session.getAttribute("user_no_Session");
		dayoffVO.setUser_no(user_no);
		String team_id = dayoffVO.getTeam_id();
		String user_name = dayoffVO.getUser_name();
		String work_level = dayoffVO.getWork_level();
		System.out.println(team_id + ":team_id");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("user_no", user_no);
		map.put("team_id", team_id);
		map.put("toServerYear", toServerYear);
		
		TopDayoffVO myDayoffInfo = sqlSession.selectOne("MyDayoff.getMyDayoffInfo" ,map);
		TopDayoffVO myDayoffsel = sqlSession.selectOne("MyDayoff.myDayoffsel" ,map);
		
		model.addAttribute("myDayoffInfo",myDayoffInfo);
		model.addAttribute("myDayoffsel",myDayoffsel);
		model.addAttribute("team_id",team_id);
		model.addAttribute("user_no",user_no);
		model.addAttribute("user_name",user_name);
		model.addAttribute("work_level",work_level);
		
		return "top_individual/my_dayoff_pop";
	}*/
	
	/*@RequestMapping(value = "mydayoffinsOK", method = RequestMethod.POST)
	public void mydayoffinsOK(Model model, HttpServletResponse response, HttpSession session, TopDayoffVO dayoffVO, TopMbrBscVO tmbVO) {

		logger.info("mydayoffinsOK");
		System.out.println();
		
		
				
		String user_no = (String) session.getAttribute("user_no_Session");
		dayoffVO.setUser_no(user_no);
		TopMbrBscVO myInfoVo = sqlSession.selectOne("MyEmpCertIns.getMyInfo", user_no);
		
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		
				
		//로그인 유저의 해당월 경비내역 추가하기
		int myDayoffInsAdd = sqlSession.insert("MyDayoff.myDayoffInsAdd", dayoffVO);
		
		int result = 0;
		if(myDayoffInsAdd > 0){
			
			result = 1;
	}
		
		out.print(result);
	}//primBizInvShareAddOK
*/


	/*@RequestMapping(value = "calcDayoffCnt", method = RequestMethod.POST)
	public void calcDayoffCnt(String dayoffFromDate, String dayoffToDate, HttpServletResponse response) {

		logger.info("======= calcDayoffCnt =======");

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		HashMap<String, String> queryMap = new HashMap<String, String>();
		queryMap.put("dayoffFromDate", dayoffFromDate);
		queryMap.put("dayoffToDate", dayoffToDate);

		int result = 0;
		result = sqlSession.selectOne("MyDayoff.calcDayoffCnt", queryMap);

		out.print(result);
		out.close();
	}//calcDayoffCnt
*/
}
