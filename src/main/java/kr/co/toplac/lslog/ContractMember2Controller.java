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

/*
*********************************************************
* Program ID	: LogTeamController // 영문 프로그램 이름 (파일 이름 가능)
* Program Name	: // 국문 프로그램 이름 (파일 이름 가능)
* Description	: // 간략한 설명
* Author		: rojaiho // 개발자 이름
* Date			: 2015.12.30.// 최초 작성일
* Update		: // 수정일 + 수정 요청자(있는 경우) + 수정 내용
*********************************************************
*/
@Controller
public class ContractMember2Controller {
	
	private static final Logger logger = LoggerFactory.getLogger(ContractMember2Controller.class);

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
	@RequestMapping(value = "/contract_member2", method = RequestMethod.GET)
	public String contractMember2(Model model, HttpServletRequest request, ContractMember2ViewVO vo2, String user_id, String name, String team_name) {
		String viewName = contractMember2Post(model, request, vo2, user_id, name, team_name);
		return viewName;
	}

	@RequestMapping(value = "/contract_member2", method = RequestMethod.POST)
	public String contractMember2Post(Model model, HttpServletRequest request, ContractMember2ViewVO vo2, String user_id, String name, String team_name) {

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
				
		//변수 설정
		String cons_report_id = "";
		String cons_result_id = "";
		String cons_ig_id = "";
		String cons_ig_nick = "";
		String cons_bd_type = "";
		String cons_ig_client = "";
		String cons_reg_date = "";
		String cons_end_date = "";
		String cons_report_ch = "";
		String cons_report_1 = "";
		//변수 선언 종료
		
			List<ContractMember2VO> ConS_selList = new ArrayList<ContractMember2VO>();
			ConS_selList = sqlSession.selectList("ContractMember2Mapper.ConS_M2", map);
			
			List<ContractMember2VO> ConS_M2List = new ArrayList<ContractMember2VO>();
				for(int i = 0; i < ConS_selList.size(); i++){
					ContractMember2VO ConS_M2VO = ConS_selList.get(i);
					String tmpIg = ConS_M2VO.getIg_id();
					map.put("tmpIg", tmpIg);
					//log 조회 Start
					ContractMember2VO ConS_List = sqlSession.selectOne("ContractMember2Mapper.ConS_M2List", map);
					//log 조회 End
					
					ConS_List.setIg_id(ConS_M2VO.getIg_id());
					ConS_List.setIg_client(ConS_M2VO.getIg_client());
					ConS_List.setReport_id(ConS_M2VO.getReport_id());
					ConS_List.setResult_id(ConS_M2VO.getResult_id());
					ConS_List.setReg_date(ConS_M2VO.getReg_date());
					ConS_List.setEnd_date(ConS_M2VO.getEnd_date());
					ConS_List.setBd_type(ConS_M2VO.getBd_type());
					ConS_List.setReport_1(ConS_M2VO.getReport_1());
					cons_ig_nick += (ConS_List.getIg_nick());
					
					ConS_M2List.add(ConS_List);
					}
				
				model.addAttribute("ConS_M2List", ConS_M2List);
				model.addAttribute("vo2", vo2);
				model.addAttribute("pgid", "contract_member2");

		return "ls_log/log_index";
	}
	
	@RequestMapping(value = "/contract_member2_excel", method = RequestMethod.POST)
	public void contractTeamExcel(Model model, HttpServletRequest request, HttpServletResponse response, String hidtab) {
		
		response.setCharacterEncoding("euc-kr");
		response.setHeader("Content-Disposition","attachment;filename=contract_team_excel.xls");
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
