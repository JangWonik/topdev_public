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
public class RegTeamController {
	
	private static final Logger logger = LoggerFactory.getLogger(RegTeamController.class);

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
	@RequestMapping(value = "/reg_team", method = RequestMethod.GET)
	public String regTeam(Model model, HttpServletRequest request, RegIgTeamVO vo2, String ig_id, String rid, String year, String month, String fromdate, String todate, String ig_nick) {
		String viewName = regTeamPost(model, request, vo2, rid, year, month, ig_id,fromdate, todate, ig_nick);
		return viewName;
	}

	@RequestMapping(value = "/reg_team", method = RequestMethod.POST)
	public String regTeamPost(Model model, HttpServletRequest request, RegIgTeamVO vo2, String rid, String year, String month, String ig_id, String fromdate, String todate, String ig_nick) {
		//날짜만들기 시작
				Calendar today = Calendar.getInstance();
				
				int dateInt = today.get(Calendar.DATE);
				int monthInt = today.get(Calendar.MONTH) + 1;
				int yearInt = today.get(Calendar.YEAR);
				int fromDateInt = 16, fromMonthInt = 0, fromYearInt = yearInt;
				int toDateInt = 16, toMonthInt = 0, toYearInt = yearInt;
				if(fromdate == null || "".equals(fromdate)){
					if(dateInt < 16){
						fromMonthInt = monthInt - 2;
					}else if(dateInt >= 16){
						fromMonthInt = monthInt - 1;
					}
					if(fromMonthInt == 0){
						fromMonthInt = 12;
						fromYearInt--;
					}
					fromdate = "" + fromYearInt +"-"+ ((fromMonthInt < 10)? "0"+fromMonthInt : fromMonthInt) +"-"+ fromDateInt;
				}
				if(todate == null || "".equals(todate)){
					if(dateInt < 16){
						toMonthInt = monthInt - 1;
					}else if(dateInt >= 16){
						toMonthInt = monthInt;
					}
					if(toMonthInt == 13){
						toMonthInt = 1;
						toYearInt++;
					}
					todate = "" + toYearInt +"-"+ ((toMonthInt < 10)? "0"+toMonthInt : toMonthInt) +"-"+ toDateInt;
				}
				
				int fromAccumYear = Integer.parseInt(fromdate.substring(0, 4));
				int fromAccumMonth = Integer.parseInt(fromdate.substring(5, 7));
				int toAccumYear = Integer.parseInt(todate.substring(0, 4));
				if(fromAccumMonth < 12){
					fromAccumYear--;
				}
				String fromYear = fromAccumYear + "12" + "16";
				String toYear = toAccumYear + "12" + "16";
				
				int regmonth = Integer.parseInt(todate.substring(5, 7));
				model.addAttribute("regmonth", regmonth);
				
				
		//날짜만들기 종료
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fromdate", fromdate);
		map.put("todate", todate);
		map.put("fromYear", fromYear);
		map.put("toYear", toYear);
		map.put("tmpIg", ig_id);
		map.put("ig_nick", ig_nick);
		
		model.addAttribute("ig_nick", ig_nick);
		model.addAttribute("month", month);
		model.addAttribute("monthInt", monthInt);
		model.addAttribute("fromdate", fromdate);
		model.addAttribute("todate", todate);
		model.addAttribute("fromYear", fromYear);
		model.addAttribute("toYear", toYear);
		model.addAttribute("toAccumYear", toAccumYear);
		model.addAttribute("toMonthInt", todate.substring(5, 7));
		
		//1종 변수 설정
		String k1s_rid = "";
		int k1s_reg_rid = 0;
		int k1s_end_rid = 0;	
		int k1s_reg_rid2 = 0;
		int k1s_end_rid2 = 0;
		int k1s_reg_rid3 = 0;
		int k1s_end_rid3 = 0;
		int k1s_reg_rid4 = 0;
		int k1s_end_rid4 = 0;
		int k1s_reg_rid5 = 0;
		int k1s_end_rid5 = 0;
		int k1s_reg_rid6 = 0;
		int k1s_end_rid6 = 0;
		int k1s_reg_rid7 = 0;
		int k1s_end_rid7 = 0;
		int k1s_reg_rid8 = 0;
		int k1s_end_rid8 = 0;
		int k1s_reg_rid9 = 0;
		int k1s_end_rid9 = 0;
		int k1s_reg_rid10 = 0;
		int k1s_end_rid10 = 0;
		int k1s_reg_rid11 = 0;
		int k1s_end_rid11 = 0;
		int k1s_reg_rid12 = 0;
		int k1s_end_rid12 = 0;
		int k1s_reg_sum = 0;
		int k1s_end_sum = 0;
		
		//4종 변수 설정
		String k4s_rid = "";
		int k4s_reg_rid = 0;
		int k4s_end_rid = 0;	
		int k4s_reg_rid2 = 0;
		int k4s_end_rid2 = 0;
		int k4s_reg_rid3 = 0;
		int k4s_end_rid3 = 0;
		int k4s_reg_rid4 = 0;
		int k4s_end_rid4 = 0;
		int k4s_reg_rid5 = 0;
		int k4s_end_rid5 = 0;
		int k4s_reg_rid6 = 0;
		int k4s_end_rid6 = 0;
		int k4s_reg_rid7 = 0;
		int k4s_end_rid7 = 0;
		int k4s_reg_rid8 = 0;
		int k4s_end_rid8 = 0;
		int k4s_reg_rid9 = 0;
		int k4s_end_rid9 = 0;
		int k4s_reg_rid10 = 0;
		int k4s_end_rid10 = 0;
		int k4s_reg_rid11 = 0;
		int k4s_end_rid11 = 0;
		int k4s_reg_rid12 = 0;
		int k4s_end_rid12 = 0;
		int k4s_reg_sum = 0;
		int k4s_end_sum = 0;
		
		List<RegIgVO> team1List = new ArrayList<RegIgVO>();
		team1List = sqlSession.selectList("RegTeamMapper.selteam1", vo2);
		
		
		//1종 소계 변수 선언 종료

				List<RegIgVO> kind1regList = new ArrayList<RegIgVO>();
				int intForkind1 = 0;

				for(int i = 0; i < team1List.size(); i++, intForkind1++){
					RegIgVO regig1VO = team1List.get(i);
					String tmpTeamid = regig1VO.getTeam_id();
					map.put("tmpTeamid", tmpTeamid);
					
					//1종 log 조회 Start
					RegIgVO regig1List = sqlSession.selectOne("RegTeamMapper.regkind1", map);
					//1종 log 조회 End

					regig1List.setIg_id(regig1VO.getIg_id());
					regig1List.setTeam_id(regig1VO.getTeam_id());
					regig1List.setTeam_name(regig1VO.getTeam_name());
					k1s_reg_rid += Integer.parseInt(regig1List.getReg_rid());
					k1s_end_rid += Integer.parseInt(regig1List.getEnd_rid());
					k1s_reg_rid2 += Integer.parseInt(regig1List.getReg_rid2());
					k1s_end_rid2 += Integer.parseInt(regig1List.getEnd_rid2());
					k1s_reg_rid3 += Integer.parseInt(regig1List.getReg_rid3());
					k1s_end_rid3 += Integer.parseInt(regig1List.getEnd_rid3());
					k1s_reg_rid4 += Integer.parseInt(regig1List.getReg_rid4());
					k1s_end_rid4 += Integer.parseInt(regig1List.getEnd_rid4());
					k1s_reg_rid5 += Integer.parseInt(regig1List.getReg_rid5());
					k1s_end_rid5 += Integer.parseInt(regig1List.getEnd_rid5());
					k1s_reg_rid6 += Integer.parseInt(regig1List.getReg_rid6());
					k1s_end_rid6 += Integer.parseInt(regig1List.getEnd_rid6());
					k1s_reg_rid7 += Integer.parseInt(regig1List.getReg_rid7());
					k1s_end_rid7 += Integer.parseInt(regig1List.getEnd_rid7());
					k1s_reg_rid8 += Integer.parseInt(regig1List.getReg_rid8());
					k1s_end_rid8 += Integer.parseInt(regig1List.getEnd_rid8());
					k1s_reg_rid9 += Integer.parseInt(regig1List.getReg_rid9());
					k1s_end_rid9 += Integer.parseInt(regig1List.getEnd_rid9());
					k1s_reg_rid10 += Integer.parseInt(regig1List.getReg_rid10());
					k1s_end_rid10 += Integer.parseInt(regig1List.getEnd_rid10());
					k1s_reg_rid11 += Integer.parseInt(regig1List.getReg_rid11());
					k1s_end_rid11 += Integer.parseInt(regig1List.getEnd_rid11());
					k1s_reg_rid12 += Integer.parseInt(regig1List.getReg_rid12());
					k1s_end_rid12 += Integer.parseInt(regig1List.getEnd_rid12());
					k1s_reg_sum += Integer.parseInt(regig1List.getReg_sum());
					k1s_end_sum += Integer.parseInt(regig1List.getEnd_sum());
					kind1regList.add(regig1List);
					
				}
				
				DecimalFormat format2 = new DecimalFormat("#,###");
				
				RegIgVO regsum1VO = new RegIgVO();
				regsum1VO.setSum_reg(""+format2.format(k1s_reg_rid));
				regsum1VO.setSum_reg2(""+format2.format(k1s_reg_rid2));
				regsum1VO.setSum_reg3(""+format2.format(k1s_reg_rid3));
				regsum1VO.setSum_reg4(""+format2.format(k1s_reg_rid4));	
				regsum1VO.setSum_reg5(""+format2.format(k1s_reg_rid5));
				regsum1VO.setSum_reg6(""+format2.format(k1s_reg_rid6));
				regsum1VO.setSum_reg7(""+format2.format(k1s_reg_rid7));
				regsum1VO.setSum_reg8(""+format2.format(k1s_reg_rid8));
				regsum1VO.setSum_reg9(""+format2.format(k1s_reg_rid9));
				regsum1VO.setSum_reg10(""+format2.format(k1s_reg_rid10));
				regsum1VO.setSum_reg11(""+format2.format(k1s_reg_rid11));
				regsum1VO.setSum_reg12(""+format2.format(k1s_reg_rid12));
				regsum1VO.setSum_reg_sum(""+format2.format(k1s_reg_sum));
				
				RegIgVO endsum1VO = new RegIgVO();
				endsum1VO.setSum_end(""+format2.format(k1s_end_rid));
				endsum1VO.setSum_end2(""+format2.format(k1s_end_rid2));
				endsum1VO.setSum_end3(""+format2.format(k1s_end_rid3));
				endsum1VO.setSum_end4(""+format2.format(k1s_end_rid4));	
				endsum1VO.setSum_end5(""+format2.format(k1s_end_rid5));
				endsum1VO.setSum_end6(""+format2.format(k1s_end_rid6));
				endsum1VO.setSum_end7(""+format2.format(k1s_end_rid7));
				endsum1VO.setSum_end8(""+format2.format(k1s_end_rid8));
				endsum1VO.setSum_end9(""+format2.format(k1s_end_rid9));
				endsum1VO.setSum_end10(""+format2.format(k1s_end_rid10));
				endsum1VO.setSum_end11(""+format2.format(k1s_end_rid11));
				endsum1VO.setSum_end12(""+format2.format(k1s_end_rid12));
				endsum1VO.setSum_end_sum(""+format2.format(k1s_end_sum));
				
				model.addAttribute("kind1regList", kind1regList);
				model.addAttribute("sum_reg", regsum1VO);
				model.addAttribute("sum_end", endsum1VO);
				model.addAttribute("team1List", team1List);
				model.addAttribute("ig_id", ig_id);
				
				
				List<RegIgVO> team4List = new ArrayList<RegIgVO>();
				team4List = sqlSession.selectList("RegTeamMapper.selteam4", vo2);
				
				//4종 소계 변수 선언 종료

						List<RegIgVO> kind4regList = new ArrayList<RegIgVO>();
						int intForkind4 = 0;

						for(int i = 0; i < team4List.size(); i++, intForkind4++){
							RegIgVO regig4VO = team4List.get(i);
							String tmpTeamid2 = regig4VO.getTeam_id();
							map.put("tmpTeamid2", tmpTeamid2);
							
							//4종 log 조회 Start
							RegIgVO regig4List = sqlSession.selectOne("RegTeamMapper.regkind4", map);
							//4종 log 조회 End

							regig4List.setIg_id(regig4VO.getIg_id());
							regig4List.setTeam_id(regig4VO.getTeam_id());
							regig4List.setTeam_name(regig4VO.getTeam_name());
							k4s_reg_rid += Integer.parseInt(regig4List.getReg_rid());
							k4s_end_rid += Integer.parseInt(regig4List.getEnd_rid());
							k4s_reg_rid2 += Integer.parseInt(regig4List.getReg_rid2());
							k4s_end_rid2 += Integer.parseInt(regig4List.getEnd_rid2());
							k4s_reg_rid3 += Integer.parseInt(regig4List.getReg_rid3());
							k4s_end_rid3 += Integer.parseInt(regig4List.getEnd_rid3());
							k4s_reg_rid4 += Integer.parseInt(regig4List.getReg_rid4());
							k4s_end_rid4 += Integer.parseInt(regig4List.getEnd_rid4());
							k4s_reg_rid5 += Integer.parseInt(regig4List.getReg_rid5());
							k4s_end_rid5 += Integer.parseInt(regig4List.getEnd_rid5());
							k4s_reg_rid6 += Integer.parseInt(regig4List.getReg_rid6());
							k4s_end_rid6 += Integer.parseInt(regig4List.getEnd_rid6());
							k4s_reg_rid7 += Integer.parseInt(regig4List.getReg_rid7());
							k4s_end_rid7 += Integer.parseInt(regig4List.getEnd_rid7());
							k4s_reg_rid8 += Integer.parseInt(regig4List.getReg_rid8());
							k4s_end_rid8 += Integer.parseInt(regig4List.getEnd_rid8());
							k4s_reg_rid9 += Integer.parseInt(regig4List.getReg_rid9());
							k4s_end_rid9 += Integer.parseInt(regig4List.getEnd_rid9());
							k4s_reg_rid10 += Integer.parseInt(regig4List.getReg_rid10());
							k4s_end_rid10 += Integer.parseInt(regig4List.getEnd_rid10());
							k4s_reg_rid11 += Integer.parseInt(regig4List.getReg_rid11());
							k4s_end_rid11 += Integer.parseInt(regig4List.getEnd_rid11());
							k4s_reg_rid12 += Integer.parseInt(regig4List.getReg_rid12());
							k4s_end_rid12 += Integer.parseInt(regig4List.getEnd_rid12());
							k4s_reg_sum += Integer.parseInt(regig4List.getReg_sum());
							k4s_end_sum += Integer.parseInt(regig4List.getEnd_sum());
							kind4regList.add(regig4List);
							
						}
						
						//DecimalFormat format2 = new DecimalFormat("#,###");
						
						RegIgVO regsum4VO = new RegIgVO();
						regsum4VO.setSum_reg(""+format2.format(k4s_reg_rid));
						regsum4VO.setSum_reg2(""+format2.format(k4s_reg_rid2));
						regsum4VO.setSum_reg3(""+format2.format(k4s_reg_rid3));
						regsum4VO.setSum_reg4(""+format2.format(k4s_reg_rid4));	
						regsum4VO.setSum_reg5(""+format2.format(k4s_reg_rid5));
						regsum4VO.setSum_reg6(""+format2.format(k4s_reg_rid6));
						regsum4VO.setSum_reg7(""+format2.format(k4s_reg_rid7));
						regsum4VO.setSum_reg8(""+format2.format(k4s_reg_rid8));
						regsum4VO.setSum_reg9(""+format2.format(k4s_reg_rid9));
						regsum4VO.setSum_reg10(""+format2.format(k4s_reg_rid10));
						regsum4VO.setSum_reg11(""+format2.format(k4s_reg_rid11));
						regsum4VO.setSum_reg12(""+format2.format(k4s_reg_rid12));
						regsum4VO.setSum_reg_sum4(""+format2.format(k4s_reg_sum));
						
						RegIgVO endsum4VO = new RegIgVO();
						endsum4VO.setSum_end(""+format2.format(k4s_end_rid));
						endsum4VO.setSum_end2(""+format2.format(k4s_end_rid2));
						endsum4VO.setSum_end3(""+format2.format(k4s_end_rid3));
						endsum4VO.setSum_end4(""+format2.format(k4s_end_rid4));	
						endsum4VO.setSum_end5(""+format2.format(k4s_end_rid5));
						endsum4VO.setSum_end6(""+format2.format(k4s_end_rid6));
						endsum4VO.setSum_end7(""+format2.format(k4s_end_rid7));
						endsum4VO.setSum_end8(""+format2.format(k4s_end_rid8));
						endsum4VO.setSum_end9(""+format2.format(k4s_end_rid9));
						endsum4VO.setSum_end10(""+format2.format(k4s_end_rid10));
						endsum4VO.setSum_end11(""+format2.format(k4s_end_rid11));
						endsum4VO.setSum_end12(""+format2.format(k4s_end_rid12));
						endsum4VO.setSum_end_sum4(""+format2.format(k4s_end_sum));			
				
						RegIgVO regsum14VO = new RegIgVO();
						regsum14VO.setSum_total_reg(""+format2.format(k1s_reg_rid + k4s_reg_rid));
						regsum14VO.setSum_total_reg2(""+format2.format(k1s_reg_rid2 + k4s_reg_rid2));
						regsum14VO.setSum_total_reg3(""+format2.format(k1s_reg_rid3 + k4s_reg_rid3));
						regsum14VO.setSum_total_reg4(""+format2.format(k1s_reg_rid4 + k4s_reg_rid4));	
						regsum14VO.setSum_total_reg5(""+format2.format(k1s_reg_rid5 + k4s_reg_rid5));
						regsum14VO.setSum_total_reg6(""+format2.format(k1s_reg_rid6 + k4s_reg_rid6));
						regsum14VO.setSum_total_reg7(""+format2.format(k1s_reg_rid7 + k4s_reg_rid7));
						regsum14VO.setSum_total_reg8(""+format2.format(k1s_reg_rid8 + k4s_reg_rid8));
						regsum14VO.setSum_total_reg9(""+format2.format(k1s_reg_rid9 + k4s_reg_rid9));
						regsum14VO.setSum_total_reg10(""+format2.format(k1s_reg_rid10 + k4s_reg_rid10));
						regsum14VO.setSum_total_reg11(""+format2.format(k1s_reg_rid11 + k4s_reg_rid11));
						regsum14VO.setSum_total_reg12(""+format2.format(k1s_reg_rid12 + k4s_reg_rid12));
						regsum14VO.setSum_reg_sum14(""+format2.format(k1s_reg_sum + k4s_reg_sum));
						
						RegIgVO endsum14VO = new RegIgVO();
						endsum14VO.setSum_total_end(""+format2.format(k1s_end_rid + k4s_end_rid));
						endsum14VO.setSum_total_end2(""+format2.format(k1s_end_rid2 + k4s_end_rid2));
						endsum14VO.setSum_total_end3(""+format2.format(k1s_end_rid3 + k4s_end_rid3));
						endsum14VO.setSum_total_end4(""+format2.format(k1s_end_rid4 + k4s_end_rid4));	
						endsum14VO.setSum_total_end5(""+format2.format(k1s_end_rid5 + k4s_end_rid5));
						endsum14VO.setSum_total_end6(""+format2.format(k1s_end_rid6 + k4s_end_rid6));
						endsum14VO.setSum_total_end7(""+format2.format(k1s_end_rid7 + k4s_end_rid7));
						endsum14VO.setSum_total_end8(""+format2.format(k1s_end_rid8 + k4s_end_rid8));
						endsum14VO.setSum_total_end9(""+format2.format(k1s_end_rid9 + k4s_end_rid9));
						endsum14VO.setSum_total_end10(""+format2.format(k1s_end_rid10 + k4s_end_rid10));
						endsum14VO.setSum_total_end11(""+format2.format(k1s_end_rid11 + k4s_end_rid11));
						endsum14VO.setSum_total_end12(""+format2.format(k1s_end_rid12 + k4s_end_rid12));
						endsum14VO.setSum_end_sum14(""+format2.format(k1s_end_sum + k4s_end_sum));
				
				
						/*kind14SumVO.setSum_reg_m(""+format2.format(k1s_reg_m+k4s_reg_m));
						kind14SumVO.setSum_reg_y(""+format2.format(k1s_reg_y+k4s_reg_y));
						kind14SumVO.setSum_end_m(""+format2.format(k1s_end_m+k4s_end_m));
						kind14SumVO.setSum_end_y(""+format2.format(k1s_end_y+k4s_end_y));	
						kind14SumVO.setSum_nend_p(""+format2.format(k1s_nend_p+k4s_nend_p));
						kind14SumVO.setSum_endea_m(""+format2.format(k1s_endea_m+k4s_endea_m));
						kind14SumVO.setSum_endea_y(""+format2.format(k1s_endea_y+k4s_endea_y));
						kind14SumVO.setSum_price_assess(""+format2.format(k1s_price_assess+k4s_price_assess));
						kind14SumVO.setSum_price_time(""+format2.format(k1s_price_time+k4s_price_time));
						kind14SumVO.setSum_price_sum1(""+format2.format(k1s_price_sum1+k4s_price_sum1));
						kind14SumVO.setSum_price_traffic(""+format2.format(k1s_price_traffic+k4s_price_traffic));
						kind14SumVO.setSum_price_question(""+format2.format(k1s_price_question+k4s_price_question));
						kind14SumVO.setSum_price_receipt(""+format2.format(k1s_price_receipt+k4s_price_receipt));
						kind14SumVO.setSum_price_sum2(""+format2.format(k1s_price_sum2+k4s_price_sum2));*/

						//model.addAttribute("kind4List", kind4List);
						//model.addAttribute("sumobj", kind14SumVO);
				model.addAttribute("vo2", vo2);
				model.addAttribute("kind4regList", kind4regList);
				model.addAttribute("sum_reg4", regsum4VO);
				model.addAttribute("sum_end4", endsum4VO);
				model.addAttribute("sum_reg14", regsum14VO);
				model.addAttribute("sum_end14", endsum14VO);
				model.addAttribute("team4List", team4List);
				model.addAttribute("pgid", "reg_team");

		return "ls_log/log_index";
	}
	
	@RequestMapping(value = "/reg_team_excel", method = RequestMethod.POST)
	public void RegTeamExcel(Model model, HttpServletRequest request, HttpServletResponse response, String hidtab) {
		//String nowDate=DateUtil.getDate("yyyyMMddHHmmss");

		
		response.setCharacterEncoding("euc-kr");
		response.setHeader("Content-Disposition","attachment;filename=reg_team_excel_.xls");
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
