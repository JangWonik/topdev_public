package kr.co.toplac.lslog;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class Suitability12Member2Controller {
	
	private static final Logger logger = LoggerFactory.getLogger(SuitabilityMember2Controller.class);

	@Autowired
	private SqlSession sqlSession;

	/*
	*********************************************************
	* Method ID		: // 영문 메소드 이름
	* Method Name	: // 국문 메소드 이름
	* Description	: // 간략한 설명
	* Author		: // 개발자 이름
	* Date			: // 최초 작성일
	* Update		: // 수정일 + 수정 요청자(있는 경우) + 수정 내용
	*********************************************************
	*/
	@RequestMapping(value = "/suitability_12_member2", method = RequestMethod.GET)
	public String suitability12Member2(Model model, HttpServletRequest request, Suitability12Member2ViewVO vo2, String user_id, String name, String team_name) {
		String viewName = suitability12Member2Post(model, request, vo2, user_id, name, team_name);
		return viewName;
	}

	@RequestMapping(value = "/suitability_12_member2", method = RequestMethod.POST)
	public String suitability12Member2Post(Model model, HttpServletRequest request, Suitability12Member2ViewVO vo2, String user_id, String name, String team_name) {

		//날짜만들기 시작
		String fromdate = vo2.getViewFromDate();
		String todate = vo2.getViewToDate();
		Calendar today = Calendar.getInstance();
		int dateInt = today.get(Calendar.DATE);
		int monthInt = today.get(Calendar.MONTH) + 1;
		int yearInt = today.get(Calendar.YEAR);
		int toDateInt = 1;
		
		if(fromdate != null){
		int s_fromdate = Integer.parseInt(fromdate.substring(5, 7));	
		fromdate = (fromdate.substring(0, 4)) +"-"+ ((s_fromdate < 10)? "0" + s_fromdate : s_fromdate) +"-"+ (fromdate.substring(8, 10));
		}
		
		if(todate != null){
		int s_todate = Integer.parseInt(todate.substring(5, 7));
		int s_fromdate = Integer.parseInt(fromdate.substring(5, 7));
		if(s_todate == s_fromdate){
			todate = (todate.substring(0, 4)) +"-"+ ((s_todate < 9)? "0" + (s_todate+1) : (s_todate+1)) +"-"+ (todate.substring(8, 10));
		}else{
			todate = (todate.substring(0, 4)) +"-"+ ((s_todate < 9)? "0" + s_todate : s_todate) +"-"+ (todate.substring(8, 10));
			}
		}
		
		if(fromdate == null || "".equals(fromdate)){
			if(monthInt == 0){
				monthInt = 12;
				yearInt--;
			}
			fromdate = "" + yearInt +"-"+ ((monthInt < 10)? "0"+monthInt : monthInt) +"-"+ "0" + toDateInt;
		}
		if(todate == null || "".equals(todate)){
			if(monthInt == 13){
				monthInt = 1;
				yearInt++;
			}
			todate = "" + yearInt + "-" + ((monthInt < 10)? "0"+(monthInt+1) : (monthInt+1)) + "-" + ((dateInt < 10)? "0" +toDateInt : "0" + toDateInt);
		}
		
		
		String year = todate.substring(0, 4);
		String month = todate.substring(5, 7);
		
		int fromAccumYear = Integer.parseInt(fromdate.substring(0, 4));
		int fromAccumMonth = Integer.parseInt(fromdate.substring(5, 7));
		int toAccumYear = Integer.parseInt(todate.substring(0, 4));
		if(fromAccumMonth < 12){
			fromAccumYear--;
		}
		String fromYear = fromAccumYear + "12" + "16";
		String toYear = toAccumYear + "12" + "16";
		int toMonthInt = (Integer.parseInt(month) -1);
		if(toMonthInt == 0){
			toMonthInt = 12;
		}
		
		model.addAttribute("year",year);
		model.addAttribute("month",month);
		model.addAttribute("todate",todate);
		
		//날짜만들기 종료
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fromdate", fromdate);
		map.put("todate", todate);
		map.put("user_id", user_id);
		map.put("team_name", team_name);
		
		model.addAttribute("user_id", user_id);
		model.addAttribute("name", name);
		model.addAttribute("team_name", team_name);
		model.addAttribute("dateInt", dateInt);
		model.addAttribute("monthInt", monthInt);
		model.addAttribute("fromdate", fromdate);
		model.addAttribute("todate", todate);
		model.addAttribute("toAccumYear", toAccumYear);
		model.addAttribute("toMonthInt", toMonthInt);
		
		//1종 변수 설정
		String cons_report_id = "";
		String cons_result_id = "";
		String cons_ig_id = "";
		String cons_ig_nick = "";
		String cons_bd_type = "";
		String cons_ig_client = "";
		String cons_reg_date = "";
		String cons_end_date = "";
		String cons_report_ch = "";
		String rstPptyNvCpltYn = "";
		
		//1종 소계 변수 선언 종료
		
			List<Suitability12Member2VO> Suit12_selList = new ArrayList<Suitability12Member2VO>();
			Suit12_selList = sqlSession.selectList("Suitability12Member2Mapper.Suit12_M2", map);
			
			List<Suitability12Member2VO> Suit12_M2List = new ArrayList<Suitability12Member2VO>();
				for(int i = 0; i < Suit12_selList.size(); i++){
					Suitability12Member2VO Suit12_M2VO = Suit12_selList.get(i);
					String tmpIg = Suit12_M2VO.getIg_id();
					map.put("tmpIg", tmpIg);
					//log 조회 Start
					Suitability12Member2VO Suit12_List = sqlSession.selectOne("Suitability12Member2Mapper.Suit12_M2List", map);
					//log 조회 End
					
					Suit12_List.setIg_id(Suit12_M2VO.getIg_id());
					Suit12_List.setIg_client(Suit12_M2VO.getIg_client());
					Suit12_List.setReport_id(Suit12_M2VO.getReport_id());
					Suit12_List.setResult_id(Suit12_M2VO.getResult_id());
					Suit12_List.setReg_date(Suit12_M2VO.getReg_date());
					Suit12_List.setEnd_date(Suit12_M2VO.getEnd_date());
					Suit12_List.setBd_type(Suit12_M2VO.getBd_type());
					Suit12_List.setRstPptyNvCpltYn(Suit12_M2VO.getRstPptyNvCpltYn());
					cons_ig_nick += (Suit12_M2VO.getIg_nick());
					
					Suit12_M2List.add(Suit12_List);
					}
				
				model.addAttribute("Suit12_M2List", Suit12_M2List);
				
				
					
					
				model.addAttribute("vo2", vo2);
				model.addAttribute("pgid", "suitability_12_member2");

		return "ls_log/log_index";
	}

	
	
	@RequestMapping(value = "/suitability12_member2_excel", method = RequestMethod.POST)
	public void suitability12Member2Excel(Model model, HttpServletRequest request, HttpServletResponse response, String hidtab) {
		
		response.setCharacterEncoding("euc-kr");
		response.setHeader("Content-Disposition","attachment;filename=suitability12_member2_excel.xls");
	    response.setHeader("Content-Description", "JSP Generated Data");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		out.println(hidtab);
	}

}
