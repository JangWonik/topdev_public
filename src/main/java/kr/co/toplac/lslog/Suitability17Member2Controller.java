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
* Date			: 2015.17.30.// 최초 작성일
* Update		: // 수정일 + 수정 요청자(있는 경우) + 수정 내용
*********************************************************
*/
@Controller
public class Suitability17Member2Controller {
	
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
	@RequestMapping(value = "/suitability_17_member2", method = RequestMethod.GET)
	public String suitability17Member2(Model model, HttpServletRequest request, Suitability17Member2ViewVO vo2, String user_id, String name, String team_name) {
		String viewName = suitability17Member2Post(model, request, vo2, user_id, name, team_name);
		return viewName;
	}

	@RequestMapping(value = "/suitability_17_member2", method = RequestMethod.POST)
	public String suitability17Member2Post(Model model, HttpServletRequest request, Suitability17Member2ViewVO vo2, String user_id, String name, String team_name) {

		//날짜만들기 시작
		String fromdate = vo2.getViewFromDate();
		String todate = vo2.getViewToDate();
		Calendar today = Calendar.getInstance();
		int dateInt = today.get(Calendar.DATE);
		int monthInt = today.get(Calendar.MONTH) + 1;
		int yearInt = today.get(Calendar.YEAR);
		/*int year = today.get(Calendar.DATE);
		int month = monthInt;
		int day = dateInt;*/
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
		String report_1 = "";
		
		//1종 소계 변수 선언 종료
		
			List<Suitability17Member2VO> Suit17_selList = new ArrayList<Suitability17Member2VO>();
			Suit17_selList = sqlSession.selectList("Suitability17Member2Mapper.Suit17_M2", map);
			
			List<Suitability17Member2VO> Suit17_M2List = new ArrayList<Suitability17Member2VO>();
				for(int i = 0; i < Suit17_selList.size(); i++){
					Suitability17Member2VO Suit17_M2VO = Suit17_selList.get(i);
					String tmpIg = Suit17_M2VO.getIg_id();
					map.put("tmpIg", tmpIg);
					//1종 log 조회 Start
					Suitability17Member2VO Suit17_List = sqlSession.selectOne("Suitability17Member2Mapper.Suit17_M2List", map);
					//1종 log 조회 End
					
					Suit17_List.setIg_id(Suit17_M2VO.getIg_id());
					Suit17_List.setIg_client(Suit17_M2VO.getIg_client());
					Suit17_List.setReport_id(Suit17_M2VO.getReport_id());
					Suit17_List.setResult_id(Suit17_M2VO.getResult_id());
					Suit17_List.setReg_date(Suit17_M2VO.getReg_date());
					Suit17_List.setEnd_date(Suit17_M2VO.getEnd_date());
					Suit17_List.setBd_type(Suit17_M2VO.getBd_type());
					Suit17_List.setReport_1(Suit17_M2VO.getReport_1());
					cons_ig_nick += (Suit17_M2VO.getIg_nick());
					
					Suit17_M2List.add(Suit17_List);
					}
				
				/*ContractMember2VO ConS_MsumVO = new ContractMember2VO();
				
				ConS_MsumVO.setSum_reg_m(""+(mb_reg_m));
				ConS_MsumVO.setSum_reg_y(""+(mb_reg_y));
				ConS_MsumVO.setSum_endok_m(""+(mb_endok_m));
				ConS_MsumVO.setSum_endok_y(""+(mb_endok_y));
				ConS_MsumVO.setSum_endno_m(""+(mb_endno_m));
				ConS_MsumVO.setSum_endno_y(""+(mb_endno_y));
				ConS_MsumVO.setSum_end_sum_m(""+(mb_end_sum_m));
				ConS_MsumVO.setSum_end_sum_y(""+(mb_end_sum_y));
				ConS_MsumVO.setSum_rid_mi(""+(mb_rid_mi));
				ConS_MsumVO.setSum_price_g(""+(mb_price_g));
				ConS_MsumVO.setSum_price_f(""+(mb_price_f));
				ConS_MsumVO.setSum_price_sum(""+(mb_price_sum));*/
				
				model.addAttribute("Suit17_M2List", Suit17_M2List);
				//model.addAttribute("ConS_Msum", ConS_MsumVO);
				
				
					
					
				model.addAttribute("vo2", vo2);
				model.addAttribute("pgid", "suitability_17_member2");

		return "ls_log/log_index";
	}

	
	
	/*@RequestMapping(value = "/contract_team_excel", method = RequestMethod.POST)
	public void contractTeamExcel(Model model, HttpServletRequest request, HttpServletResponse response, String hidtab) {
		//String nowDate=DateUtil.getDate("yyyyMMddHHmmss");

		
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
	}*/

}
