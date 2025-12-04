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

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

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

import kr.co.toplac.topcost.TopCostCompositeVO;
import kr.co.toplac.topmain.MainLeftSuimVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.rpt.MainLeftUtil;

@Controller
public class MyDayoffInsController {

	private static final Logger logger = LoggerFactory.getLogger(MyDayoffInsController.class);

	@Autowired
	private SqlSession sqlSession;

	@Autowired
	MainLeftUtil mlu;

	/*
	*********************************************************
	* Program ID	: primbizSuimList
	* Program Name	: primbizSuimList
	* Description	: 농작물 수임대장 리스트
	* Author		: 
	* Date			: 2016.06.09.
	*********************************************************
	*/
	@RequestMapping(value = "myDayoffInsList", method = RequestMethod.GET)
	public String myDayoffInsList(Model model, HttpSession session, MyDayoffVO dayoffVO, TopMbrBscVO tmbVO) {

		logger.info("myDayoffInsList");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("myDayoffInsList - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());
		
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
		
		System.out.println(yearInt + ":yearInt");
		
		String user_no = (String) session.getAttribute("user_no_Session");
		String work_level = mbrVo.getWork_level_cd();
		String team_id = mbrVo.getTeam_id_main();
		dayoffVO.setUser_no(user_no);
		
		System.out.println(work_level + ":work_level");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("toServerYear", toServerYear);
		map.put("user_no", user_no);
		map.put("team_id", team_id);
		
		model.addAttribute("user_no",user_no);
		model.addAttribute("team_id",team_id);
		model.addAttribute("work_level",work_level);
		
		List<MyDayoffVO> getMyDayoff = sqlSession.selectList("MyDayoff.getMyDayoffList" ,map);
		
		List<MyDayoffVO> getMyDayoffCount = sqlSession.selectList("MyDayoff.getMyDayoffCount",map);
		
		MyDayoffVO myDayoffsel = sqlSession.selectOne("MyDayoff.myDayoffsel" ,map);
		
		model.addAttribute("getMyDayoff",getMyDayoff);
		model.addAttribute("getMyDayoffCount",getMyDayoffCount);
		model.addAttribute("myDayoffsel",myDayoffsel);
		
		return "top_individual/my_dayoff_ins";
	}
	
	@RequestMapping(value = "myDayoffPop", method = RequestMethod.GET)
	public String myDayoffPop(Model model, HttpSession session, MyDayoffVO dayoffVO, TopMbrBscVO tmbVO, String toServerYear) {
		logger.info("myDayoffPop");
		String strToday = sqlSession.selectOne("MyDayoff.getToday");
		model.addAttribute("strToday",strToday);

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		//해당월 조회기간 구하기 시작
		String year = dayoffVO.getYeartxt();
		//해당월 조회기간 구하기 끝
		
		String user_no = (String) session.getAttribute("user_no_Session");
		dayoffVO.setUser_no(user_no);
		String team_id = mbrVo.getTeam_id_main();
		String user_name = mbrVo.getUser_name();
		String work_level = mbrVo.getWork_level_cd();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("user_no", user_no);
		map.put("team_id", team_id);
		map.put("toServerYear", toServerYear);
		
		MyDayoffVO myDayoffInfo = sqlSession.selectOne("MyDayoff.getMyDayoffInfo" ,map);
		List<MyDayoffVO> myDayoffSelect = sqlSession.selectList("MyDayoff.myDayoffSelect" ,map);
		if(myDayoffSelect.size() == 0){
			int myDayoffStartInfo = sqlSession.insert("MyDayoff.myDayoffStartInfo", map);
		}
		MyDayoffVO myDayoffsel = sqlSession.selectOne("MyDayoff.myDayoffsel" ,map);
		
		model.addAttribute("myDayoffInfo",myDayoffInfo);
		model.addAttribute("myDayoffsel",myDayoffsel);
		model.addAttribute("team_id",team_id);
		model.addAttribute("user_no",user_no);
		model.addAttribute("user_name",user_name);
		model.addAttribute("work_level",work_level);
		model.addAttribute("toServerYear",toServerYear);
		
		return "top_individual/my_dayoff_pop";
	}
	
	@RequestMapping(value = "mydayoffinsOK", method = RequestMethod.POST)
	public void mydayoffinsOK(Model model, HttpServletResponse response, HttpSession session, MyDayoffVO dayoffVO, TopMbrBscVO tmbVO) {

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
		
		
		
				
		//로그인 유저의 휴가내역 추가하기
//		if(dayoffVO.getDayoff_type() == "1"){
//			int myDayoffInsAdd = sqlSession.insert("MyDayoff.myDayoffInsAdd", dayoffVO);
//		}else{
//			dayoffVO.setDayoffCnt("0");
//		}
		System.out.println(dayoffVO.getDayoff_type() + ": 타입");
		int myDayoffInsAdd = sqlSession.insert("MyDayoff.myDayoffInsAdd", dayoffVO);
		int myDayoffInsInfo = sqlSession.update("MyDayoff.myDayoffInsInfo", dayoffVO);
		
		int result = 0;
		if((myDayoffInsAdd > 0) && (myDayoffInsInfo > 0)){
			
			result = 1;
	}
		
		out.print(result);
	}//primBizInvShareAddOK

	@RequestMapping(value = "myDayoffUdtPop", method = RequestMethod.GET)
	public String myDayoffUdtPop(Model model, HttpSession session, MyDayoffVO dayoffVO, TopMbrBscVO tmbVO, String toServerYear) {
		logger.info("myDayoffPop");
		String strToday = sqlSession.selectOne("MyDayoff.getToday");
		model.addAttribute("strToday",strToday);

		//해당월 조회기간 구하기 시작
		String year = dayoffVO.getYeartxt();
		//해당월 조회기간 구하기 끝
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		String user_no = (String) session.getAttribute("user_no_Session");
		dayoffVO.setUser_no(user_no);
		String team_id = mbrVo.getTeam_id_main();
		String user_name = mbrVo.getUser_name();
		String work_level = mbrVo.getWork_level_cd();
		String serial_no = dayoffVO.getSerial_no();

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("user_no", user_no);
		map.put("team_id", team_id);
		map.put("toServerYear", toServerYear);
		map.put("serial_no", serial_no);
		
		MyDayoffVO myDayoffInfo = sqlSession.selectOne("MyDayoff.getMyDayoffInfo" ,map);
		MyDayoffVO myDayoffUdtSel = sqlSession.selectOne("MyDayoff.myDayoffUdtSel" ,map);
		MyDayoffVO myDayoffsel = sqlSession.selectOne("MyDayoff.myDayoffsel" ,map);
		
		model.addAttribute("myDayoffInfo",myDayoffInfo);
		model.addAttribute("myDayoffUdtSel",myDayoffUdtSel);
		model.addAttribute("myDayoffsel",myDayoffsel);
		model.addAttribute("team_id",team_id);
		model.addAttribute("user_no",user_no);
		model.addAttribute("user_name",user_name);
		model.addAttribute("work_level",work_level);
		model.addAttribute("serial_no",serial_no);
		model.addAttribute("toServerYear",toServerYear);
		
		return "top_individual/my_dayoff_udt_pop";
	}
	
	@RequestMapping(value = "mydayoffUdtOK", method = RequestMethod.POST)
	public void mydayoffUdtOK(Model model, HttpServletResponse response, HttpSession session, MyDayoffVO dayoffVO, TopMbrBscVO tmbVO, String toServerYear) {

		logger.info("mydayoffinsOK");
		System.out.println();
		
		
				
		String user_no = (String) session.getAttribute("user_no_Session");
		dayoffVO.setUser_no(user_no);
		dayoffVO.setToServerYear(toServerYear);
		TopMbrBscVO myInfoVo = sqlSession.selectOne("MyEmpCertIns.getMyInfo", user_no);
		
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		MyDayoffVO myDayoffUdtSelect = sqlSession.selectOne("MyDayoff.myDayoffUdtSelect" ,dayoffVO);
		String dayOffMiCount = myDayoffUdtSelect.getDays();
		String dayOffType = myDayoffUdtSelect.getDayoff_type();
		dayoffVO.setDayOffMiCount(dayOffMiCount);
//		if(dayOffType == "1"){
//		}else{
//			dayoffVO.setDayOffMiCount("0");
//		}
		
		//나의 휴가내역 수정하기
		int myDayoffUdt = sqlSession.update("MyDayoff.myDayoffUdt", dayoffVO);
		int myDayoffUdtInfo = sqlSession.update("MyDayoff.myDayoffUdtInfo", dayoffVO);
		System.out.println(dayoffVO.getDayOffMiCount() + ": 마이너스카운트");
		System.out.println(dayoffVO.getDayoffCnt() + ": 플러스 카운트");
		int result = 0;
		if(myDayoffUdt>0){
			result = 1;
			
		}
		if(myDayoffUdtInfo>0){
			result = 1;
		}
		if((myDayoffUdtInfo > 0) && (myDayoffUdt > 0)){
	}
		
		out.print(result);
	}//primBizInvShareAddOK
	
	@RequestMapping(value = "myDayoffDelOK", method = RequestMethod.POST)
	public void myDayoffDelOK(Model model, HttpServletResponse response, HttpSession session, MyDayoffVO dayoffVO, TopMbrBscVO tmbVO, String serial_no) {

		logger.info("myDayoffDelOK");
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
		
		
		
				
		//로그인 유저의 해당 월차내역 삭제하기
		int myDayoffDel = sqlSession.delete("MyDayoff.myDayoffDel", serial_no);
		
		int result = 0;
		if(myDayoffDel > 0){
			
			result = 1;
	}
		
		out.print(result);
	}//primBizInvShareAddOK


	@RequestMapping(value = "calcDayoffCnt", method = RequestMethod.POST)
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

}
