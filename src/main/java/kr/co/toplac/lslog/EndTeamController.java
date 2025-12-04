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
public class EndTeamController {
	
	private static final Logger logger = LoggerFactory.getLogger(EndTeamController.class);

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
	@RequestMapping(value = "/end_team", method = RequestMethod.GET)
	public String endTeam(Model model, HttpServletRequest request, EndTeamViewVO vo2, String ig_id, String rid, String year, String month, String fromdate, String todate, String team_id, String ig_nick, String team_name) {
		String viewName = end_TeamPost(model, request, vo2, rid, year, month, ig_id,fromdate, todate, team_id, ig_nick, team_name);
		return viewName;
	}

	@RequestMapping(value = "/end_team", method = RequestMethod.POST)
	public String end_TeamPost(Model model, HttpServletRequest request, EndTeamViewVO vo2, String rid, String year, String month, String ig_id, String fromdate, String todate, String team_id, String ig_nick, String team_name) {
		//날짜만들기 시작
				Calendar today = Calendar.getInstance();
				
				int dateInt = today.get(Calendar.DATE);
				int monthInt = today.get(Calendar.MONTH) + 1;
				int yearInt = today.get(Calendar.YEAR);
				int fromDateInt = 16, fromMonthInt = 0, fromYearInt = yearInt;
				int toDateInt = 16, toMonthInt = 0, toYearInt = yearInt;
				if(fromdate == null || "".equals(fromdate)){
					if(dateInt < 16){
						fromMonthInt = monthInt - 1;
					}else if(dateInt >= 16){
						fromMonthInt = monthInt;
					}
					if(fromMonthInt == 0){
						fromMonthInt = 12;
						fromYearInt--;
					}
					fromdate = "" + fromYearInt +"-"+ ((fromMonthInt < 10)? "0"+fromMonthInt : fromMonthInt) +"-"+ fromDateInt;
				}
				if(todate == null || "".equals(todate)){
					if(dateInt < 16){
						toMonthInt = monthInt;
					}else if(dateInt >= 16){
						toMonthInt = monthInt + 1;
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
		//map.put("tmpTeamid", team_id);
		map.put("ig_nick", ig_nick);
		
		
		model.addAttribute("team_name", team_name);
		model.addAttribute("ig_nick", ig_nick);
		model.addAttribute("team_id", team_id);
		model.addAttribute("ig_id", ig_id);
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
		int k1s_end_rid = 0;
		int k1s_price_assess = 0;
		int k1s_price_time = 0;
		int k1s_price_traffic = 0;
		int k1s_price_qr = 0;
		int k1s_end_rid2 = 0;
		int k1s_price_assess2 = 0;
		int k1s_price_time2 = 0;
		int k1s_price_traffic2 = 0;
		int k1s_price_qr2 = 0;
		int k1s_end_rid3 = 0;
		int k1s_price_assess3 = 0;
		int k1s_price_time3 = 0;
		int k1s_price_traffic3 = 0;
		int k1s_price_qr3 = 0;
		int k1s_end_rid4 = 0;
		int k1s_price_assess4 = 0;
		int k1s_price_time4 = 0;
		int k1s_price_traffic4 = 0;
		int k1s_price_qr4 = 0;
		int k1s_end_rid5 = 0;
		int k1s_price_assess5 = 0;
		int k1s_price_time5 = 0;
		int k1s_price_traffic5 = 0;
		int k1s_price_qr5 = 0;
		int k1s_end_rid6 = 0;
		int k1s_price_assess6 = 0;
		int k1s_price_time6 = 0;
		int k1s_price_traffic6 = 0;
		int k1s_price_qr6 = 0;
		int k1s_end_rid7 = 0;
		int k1s_price_assess7 = 0;
		int k1s_price_time7 = 0;
		int k1s_price_traffic7 = 0;
		int k1s_price_qr7 = 0;
		int k1s_end_rid8 = 0;
		int k1s_price_assess8 = 0;
		int k1s_price_time8 = 0;
		int k1s_price_traffic8 = 0;
		int k1s_price_qr8 = 0;
		int k1s_end_rid9 = 0;
		int k1s_price_assess9 = 0;
		int k1s_price_time9 = 0;
		int k1s_price_traffic9 = 0;
		int k1s_price_qr9 = 0;
		int k1s_end_rid10 = 0;
		int k1s_price_assess10 = 0;
		int k1s_price_time10 = 0;
		int k1s_price_traffic10 = 0;
		int k1s_price_qr10 = 0;
		int k1s_end_rid11 = 0;
		int k1s_price_assess11 = 0;
		int k1s_price_time11 = 0;
		int k1s_price_traffic11 = 0;
		int k1s_price_qr11 = 0;
		int k1s_end_rid12 = 0;
		int k1s_price_assess12 = 0;
		int k1s_price_time12 = 0;
		int k1s_price_traffic12 = 0;
		int k1s_price_qr12 = 0;
		int k1s_end_sum = 0;
		int k1s_price_assess_sum = 0;
		int k1s_price_time_sum = 0;
		int k1s_price_traffic_sum = 0;
		int k1s_price_qr_sum = 0;
		int k1s_price_total = 0;
		int k1s_price_total2 = 0;
		int k1s_price_total3 = 0;
		int k1s_price_total4 = 0;
		int k1s_price_total5 = 0;
		int k1s_price_total6 = 0;
		int k1s_price_total7 = 0;
		int k1s_price_total8 = 0;
		int k1s_price_total9 = 0;
		int k1s_price_total10 = 0;
		int k1s_price_total11 = 0;
		int k1s_price_total12 = 0;
		int k1s_price_total_sum = 0;
		
		
		//4종 변수 설정
		String k4s_rid = "";
		int k4s_end_rid = 0;
		int k4s_price_assess = 0;
		int k4s_price_time = 0;
		int k4s_price_traffic = 0;
		int k4s_price_qr = 0;
		int k4s_end_rid2 = 0;
		int k4s_price_assess2 = 0;
		int k4s_price_time2 = 0;
		int k4s_price_traffic2 = 0;
		int k4s_price_qr2 = 0;
		int k4s_end_rid3 = 0;
		int k4s_price_assess3 = 0;
		int k4s_price_time3 = 0;
		int k4s_price_traffic3 = 0;
		int k4s_price_qr3 = 0;
		int k4s_end_rid4 = 0;
		int k4s_price_assess4 = 0;
		int k4s_price_time4 = 0;
		int k4s_price_traffic4 = 0;
		int k4s_price_qr4 = 0;
		int k4s_end_rid5 = 0;
		int k4s_price_assess5 = 0;
		int k4s_price_time5 = 0;
		int k4s_price_traffic5 = 0;
		int k4s_price_qr5 = 0;
		int k4s_end_rid6 = 0;
		int k4s_price_assess6 = 0;
		int k4s_price_time6 = 0;
		int k4s_price_traffic6 = 0;
		int k4s_price_qr6 = 0;
		int k4s_end_rid7 = 0;
		int k4s_price_assess7 = 0;
		int k4s_price_time7 = 0;
		int k4s_price_traffic7 = 0;
		int k4s_price_qr7 = 0;
		int k4s_end_rid8 = 0;
		int k4s_price_assess8 = 0;
		int k4s_price_time8 = 0;
		int k4s_price_traffic8 = 0;
		int k4s_price_qr8 = 0;
		int k4s_end_rid9 = 0;
		int k4s_price_assess9 = 0;
		int k4s_price_time9 = 0;
		int k4s_price_traffic9 = 0;
		int k4s_price_qr9 = 0;
		int k4s_end_rid10 = 0;
		int k4s_price_assess10 = 0;
		int k4s_price_time10 = 0;
		int k4s_price_traffic10 = 0;
		int k4s_price_qr10 = 0;
		int k4s_end_rid11 = 0;
		int k4s_price_assess11 = 0;
		int k4s_price_time11 = 0;
		int k4s_price_traffic11 = 0;
		int k4s_price_qr11 = 0;
		int k4s_end_rid12 = 0;
		int k4s_price_assess12 = 0;
		int k4s_price_time12 = 0;
		int k4s_price_traffic12 = 0;
		int k4s_price_qr12 = 0;
		int k4s_end_sum = 0;
		int k4s_price_assess_sum = 0;
		int k4s_price_time_sum = 0;
		int k4s_price_traffic_sum = 0;
		int k4s_price_qr_sum = 0;
		int k4s_price_total = 0;
		int k4s_price_total2 = 0;
		int k4s_price_total3 = 0;
		int k4s_price_total4 = 0;
		int k4s_price_total5 = 0;
		int k4s_price_total6 = 0;
		int k4s_price_total7 = 0;
		int k4s_price_total8 = 0;
		int k4s_price_total9 = 0;
		int k4s_price_total10 = 0;
		int k4s_price_total11 = 0;
		int k4s_price_total12 = 0;
		int k4s_price_total_sum = 0;
		
		List<EndTeamVO> end1List = new ArrayList<EndTeamVO>();
		end1List = sqlSession.selectList("EndTeamMapper.selend1", vo2);
		//model.addAttribute("end1List", end1List);
		//1종 소계 변수 선언 종료
				List<EndTeamVO> kind1endList = new ArrayList<EndTeamVO>();
				int intForkind1 = 0;

				for(int i = 0; i < end1List.size(); i++, intForkind1++){
					EndTeamVO end1VO = end1List.get(i);
					String tmpTN = end1VO.getTeam_name();
					String tmpTeamid = end1VO.getTeam_id();
					map.put("tmpTN", tmpTN);
					map.put("tmpTeamid", tmpTeamid);
					//1종 log 조회 Start
					EndTeamVO endT1List = sqlSession.selectOne("EndTeamMapper.endkind1", map);
					//1종 log 조회 End

					endT1List.setTeam_name(end1VO.getTeam_name());
					endT1List.setTeam_id(end1VO.getTeam_id());
					endT1List.setIg_nick(end1VO.getIg_nick());
					k1s_end_rid += Integer.parseInt(endT1List.getEnd_rid());
					k1s_price_assess += Integer.parseInt(endT1List.getPrice_assess());
					k1s_price_time += Integer.parseInt(endT1List.getPrice_time());
					k1s_price_traffic += Integer.parseInt(endT1List.getPrice_traffic());
					k1s_price_qr += Integer.parseInt(endT1List.getPrice_qr());
					k1s_price_total += Integer.parseInt(endT1List.getPrice_total());
					k1s_end_rid2 += Integer.parseInt(endT1List.getEnd_rid2());
					k1s_price_assess2 += Integer.parseInt(endT1List.getPrice_assess2());
					k1s_price_time2 += Integer.parseInt(endT1List.getPrice_time2());
					k1s_price_traffic2 += Integer.parseInt(endT1List.getPrice_traffic2());
					k1s_price_qr2 += Integer.parseInt(endT1List.getPrice_qr2());
					k1s_price_total2 += Integer.parseInt(endT1List.getPrice_total2());;
					k1s_end_rid3 += Integer.parseInt(endT1List.getEnd_rid3());
					k1s_price_assess3 += Integer.parseInt(endT1List.getPrice_assess3());
					k1s_price_time3 += Integer.parseInt(endT1List.getPrice_time3());
					k1s_price_traffic3 += Integer.parseInt(endT1List.getPrice_traffic3());
					k1s_price_qr3 += Integer.parseInt(endT1List.getPrice_qr3());
					k1s_price_total3 += Integer.parseInt(endT1List.getPrice_total3());
					k1s_end_rid4 += Integer.parseInt(endT1List.getEnd_rid4());
					k1s_price_assess4 += Integer.parseInt(endT1List.getPrice_assess4());
					k1s_price_time4 += Integer.parseInt(endT1List.getPrice_time4());
					k1s_price_traffic4 += Integer.parseInt(endT1List.getPrice_traffic4());
					k1s_price_qr4 += Integer.parseInt(endT1List.getPrice_qr4());
					k1s_price_total4 += Integer.parseInt(endT1List.getPrice_total4());
					k1s_end_rid5 += Integer.parseInt(endT1List.getEnd_rid5());
					k1s_price_assess5 += Integer.parseInt(endT1List.getPrice_assess5());
					k1s_price_time5 += Integer.parseInt(endT1List.getPrice_time5());
					k1s_price_traffic5 += Integer.parseInt(endT1List.getPrice_traffic5());
					k1s_price_qr5 += Integer.parseInt(endT1List.getPrice_qr5());
					k1s_price_total5 += Integer.parseInt(endT1List.getPrice_total5());
					k1s_end_rid6 += Integer.parseInt(endT1List.getEnd_rid6());
					k1s_price_assess6 += Integer.parseInt(endT1List.getPrice_assess6());
					k1s_price_time6 += Integer.parseInt(endT1List.getPrice_time6());
					k1s_price_traffic6 += Integer.parseInt(endT1List.getPrice_traffic6());
					k1s_price_qr6 += Integer.parseInt(endT1List.getPrice_qr6());
					k1s_price_total6 += Integer.parseInt(endT1List.getPrice_total6());
					k1s_end_rid7 += Integer.parseInt(endT1List.getEnd_rid7());
					k1s_price_assess7 += Integer.parseInt(endT1List.getPrice_assess7());
					k1s_price_time7 += Integer.parseInt(endT1List.getPrice_time7());
					k1s_price_traffic7 += Integer.parseInt(endT1List.getPrice_traffic7());
					k1s_price_qr7 += Integer.parseInt(endT1List.getPrice_qr7());
					k1s_price_total7 += Integer.parseInt(endT1List.getPrice_total7());
					k1s_end_rid8 += Integer.parseInt(endT1List.getEnd_rid8());
					k1s_price_assess8 += Integer.parseInt(endT1List.getPrice_assess8());
					k1s_price_time8 += Integer.parseInt(endT1List.getPrice_time8());
					k1s_price_traffic8 += Integer.parseInt(endT1List.getPrice_traffic8());
					k1s_price_qr8 += Integer.parseInt(endT1List.getPrice_qr8());
					k1s_price_total8 += Integer.parseInt(endT1List.getPrice_total8());
					k1s_end_rid9 += Integer.parseInt(endT1List.getEnd_rid9());
					k1s_price_assess9 += Integer.parseInt(endT1List.getPrice_assess9());
					k1s_price_time9 += Integer.parseInt(endT1List.getPrice_time9());
					k1s_price_traffic9 += Integer.parseInt(endT1List.getPrice_traffic9());
					k1s_price_qr9 += Integer.parseInt(endT1List.getPrice_qr9());
					k1s_price_total9 += Integer.parseInt(endT1List.getPrice_total9());
					k1s_end_rid10 += Integer.parseInt(endT1List.getEnd_rid10());
					k1s_price_assess10 += Integer.parseInt(endT1List.getPrice_assess10());
					k1s_price_time10 += Integer.parseInt(endT1List.getPrice_time10());
					k1s_price_traffic10 += Integer.parseInt(endT1List.getPrice_traffic10());
					k1s_price_qr10 += Integer.parseInt(endT1List.getPrice_qr10());
					k1s_price_total10 += Integer.parseInt(endT1List.getPrice_total10());
					k1s_end_rid11 += Integer.parseInt(endT1List.getEnd_rid11());
					k1s_price_assess11 += Integer.parseInt(endT1List.getPrice_assess11());
					k1s_price_time11 += Integer.parseInt(endT1List.getPrice_time11());
					k1s_price_traffic11 += Integer.parseInt(endT1List.getPrice_traffic11());
					k1s_price_qr11 += Integer.parseInt(endT1List.getPrice_qr11());
					k1s_price_total11 += Integer.parseInt(endT1List.getPrice_total11());
					k1s_end_rid12 += Integer.parseInt(endT1List.getEnd_rid12());
					k1s_price_assess12 += Integer.parseInt(endT1List.getPrice_assess12());
					k1s_price_time12 += Integer.parseInt(endT1List.getPrice_time12());
					k1s_price_traffic12 += Integer.parseInt(endT1List.getPrice_traffic12());
					k1s_price_qr12 += Integer.parseInt(endT1List.getPrice_qr12());
					k1s_price_total12 += Integer.parseInt(endT1List.getPrice_total12());
					k1s_end_sum += Integer.parseInt(endT1List.getEnd_sum());
					k1s_price_assess_sum += Integer.parseInt(endT1List.getPrice_assess_sum());
					k1s_price_time_sum += Integer.parseInt(endT1List.getPrice_time_sum());
					k1s_price_traffic_sum += Integer.parseInt(endT1List.getPrice_traffic_sum());
					k1s_price_qr_sum += Integer.parseInt(endT1List.getPrice_qr_sum());
					k1s_price_total_sum += Integer.parseInt(endT1List.getPrice_total_sum());
					kind1endList.add(endT1List);
					
				}
				
				
				EndTeamVO pricesum1VO = new EndTeamVO();
				pricesum1VO.setSum_rid(""+(k1s_end_rid));
				pricesum1VO.setSum_assess(""+(k1s_price_assess));
				pricesum1VO.setSum_time(""+(k1s_price_time));
				pricesum1VO.setSum_traffic(""+(k1s_price_traffic));
				pricesum1VO.setSum_qr(""+(k1s_price_qr));
				pricesum1VO.setSum_total(""+(k1s_price_total));
				pricesum1VO.setSum_rid2(""+(k1s_end_rid2));
				pricesum1VO.setSum_assess2(""+(k1s_price_assess2));
				pricesum1VO.setSum_time2(""+(k1s_price_time2));
				pricesum1VO.setSum_traffic2(""+(k1s_price_traffic2));
				pricesum1VO.setSum_qr2(""+(k1s_price_qr2));
				pricesum1VO.setSum_total2(""+(k1s_price_total2));
				pricesum1VO.setSum_rid3(""+(k1s_end_rid3));
				pricesum1VO.setSum_assess3(""+(k1s_price_assess3));
				pricesum1VO.setSum_time3(""+(k1s_price_time3));
				pricesum1VO.setSum_traffic3(""+(k1s_price_traffic3));
				pricesum1VO.setSum_qr3(""+(k1s_price_qr3));
				pricesum1VO.setSum_total3(""+(k1s_price_total3));
				pricesum1VO.setSum_rid4(""+(k1s_end_rid4));
				pricesum1VO.setSum_assess4(""+(k1s_price_assess4));
				pricesum1VO.setSum_time4(""+(k1s_price_time4));
				pricesum1VO.setSum_traffic4(""+(k1s_price_traffic4));
				pricesum1VO.setSum_qr4(""+(k1s_price_qr4));
				pricesum1VO.setSum_total4(""+(k1s_price_total4));
				pricesum1VO.setSum_rid5(""+(k1s_end_rid5));
				pricesum1VO.setSum_assess5(""+(k1s_price_assess5));
				pricesum1VO.setSum_time5(""+(k1s_price_time5));
				pricesum1VO.setSum_traffic5(""+(k1s_price_traffic5));
				pricesum1VO.setSum_qr5(""+(k1s_price_qr5));
				pricesum1VO.setSum_total5(""+(k1s_price_total5));
				pricesum1VO.setSum_rid6(""+(k1s_end_rid6));
				pricesum1VO.setSum_assess6(""+(k1s_price_assess6));
				pricesum1VO.setSum_time6(""+(k1s_price_time6));
				pricesum1VO.setSum_traffic6(""+(k1s_price_traffic6));
				pricesum1VO.setSum_qr6(""+(k1s_price_qr6));
				pricesum1VO.setSum_total6(""+(k1s_price_total6));
				pricesum1VO.setSum_rid7(""+(k1s_end_rid7));
				pricesum1VO.setSum_assess7(""+(k1s_price_assess7));
				pricesum1VO.setSum_time7(""+(k1s_price_time7));
				pricesum1VO.setSum_traffic7(""+(k1s_price_traffic7));
				pricesum1VO.setSum_qr7(""+(k1s_price_qr7));
				pricesum1VO.setSum_total7(""+(k1s_price_total7));
				pricesum1VO.setSum_rid8(""+(k1s_end_rid8));
				pricesum1VO.setSum_assess8(""+(k1s_price_assess8));
				pricesum1VO.setSum_time8(""+(k1s_price_time8));
				pricesum1VO.setSum_traffic8(""+(k1s_price_traffic8));
				pricesum1VO.setSum_qr8(""+(k1s_price_qr8));
				pricesum1VO.setSum_total8(""+(k1s_price_total8));
				pricesum1VO.setSum_rid9(""+(k1s_end_rid9));
				pricesum1VO.setSum_assess9(""+(k1s_price_assess9));
				pricesum1VO.setSum_time9(""+(k1s_price_time9));
				pricesum1VO.setSum_traffic9(""+(k1s_price_traffic9));
				pricesum1VO.setSum_qr9(""+(k1s_price_qr9));
				pricesum1VO.setSum_total9(""+(k1s_price_total9));
				pricesum1VO.setSum_rid10(""+(k1s_end_rid10));
				pricesum1VO.setSum_assess10(""+(k1s_price_assess10));
				pricesum1VO.setSum_time10(""+(k1s_price_time10));
				pricesum1VO.setSum_traffic10(""+(k1s_price_traffic10));
				pricesum1VO.setSum_qr10(""+(k1s_price_qr10));
				pricesum1VO.setSum_total10(""+(k1s_price_total10));
				pricesum1VO.setSum_rid11(""+(k1s_end_rid11));
				pricesum1VO.setSum_assess11(""+(k1s_price_assess11));
				pricesum1VO.setSum_time11(""+(k1s_price_time11));
				pricesum1VO.setSum_traffic11(""+(k1s_price_traffic11));
				pricesum1VO.setSum_qr11(""+(k1s_price_qr11));
				pricesum1VO.setSum_total11(""+(k1s_price_total11));
				pricesum1VO.setSum_rid12(""+(k1s_end_rid12));
				pricesum1VO.setSum_assess12(""+(k1s_price_assess12));
				pricesum1VO.setSum_time12(""+(k1s_price_time12));
				pricesum1VO.setSum_traffic12(""+(k1s_price_traffic12));
				pricesum1VO.setSum_qr12(""+(k1s_price_qr12));
				pricesum1VO.setSum_total12(""+(k1s_price_total12));
				pricesum1VO.setSum_rid_t(""+(k1s_end_sum));
				pricesum1VO.setSum_assess_t(""+(k1s_price_assess_sum));
				pricesum1VO.setSum_time_t(""+(k1s_price_time_sum));
				pricesum1VO.setSum_traffic_t(""+(k1s_price_traffic_sum));
				pricesum1VO.setSum_qr_t(""+(k1s_price_qr_sum));
				pricesum1VO.setSum_total_t(""+(k1s_price_total_sum));
				
				
				model.addAttribute("kind1endList", kind1endList);
				model.addAttribute("end1List", end1List);
				model.addAttribute("sum_end1", pricesum1VO);
				
				List<EndTeamVO> end4List = new ArrayList<EndTeamVO>();
				end4List = sqlSession.selectList("EndTeamMapper.selend4", vo2);
				
				//4종 소계 변수 선언 종료
						List<EndTeamVO> kind4endList = new ArrayList<EndTeamVO>();
						int intForkind4 = 0;

						for(int i = 0; i < end4List.size(); i++, intForkind4++){
							EndTeamVO end4VO = end4List.get(i);
							String tmpTN = end4VO.getTeam_name();
							String tmpTeamid = end4VO.getTeam_id();
							map.put("tmpTN", tmpTN);
							map.put("tmpTeamid", tmpTeamid);
							//1종 log 조회 Start
							EndTeamVO endT4List = sqlSession.selectOne("EndTeamMapper.endkind4", map);
							//1종 log 조회 End

							endT4List.setTeam_name(end4VO.getTeam_name());
							endT4List.setTeam_id(end4VO.getTeam_id());
							endT4List.setIg_nick(end4VO.getIg_nick());
							k4s_end_rid += Integer.parseInt(endT4List.getEnd_rid());
							k4s_price_assess += Integer.parseInt(endT4List.getPrice_assess());
							k4s_price_time += Integer.parseInt(endT4List.getPrice_time());
							k4s_price_traffic += Integer.parseInt(endT4List.getPrice_traffic());
							k4s_price_qr += Integer.parseInt(endT4List.getPrice_qr());
							k4s_price_total += Integer.parseInt(endT4List.getPrice_total());
							k4s_end_rid2 += Integer.parseInt(endT4List.getEnd_rid2());
							k4s_price_assess2 += Integer.parseInt(endT4List.getPrice_assess2());
							k4s_price_time2 += Integer.parseInt(endT4List.getPrice_time2());
							k4s_price_traffic2 += Integer.parseInt(endT4List.getPrice_traffic2());
							k4s_price_qr2 += Integer.parseInt(endT4List.getPrice_qr2());
							k4s_price_total2 += Integer.parseInt(endT4List.getPrice_total2());;
							k4s_end_rid3 += Integer.parseInt(endT4List.getEnd_rid3());
							k4s_price_assess3 += Integer.parseInt(endT4List.getPrice_assess3());
							k4s_price_time3 += Integer.parseInt(endT4List.getPrice_time3());
							k4s_price_traffic3 += Integer.parseInt(endT4List.getPrice_traffic3());
							k4s_price_qr3 += Integer.parseInt(endT4List.getPrice_qr3());
							k4s_price_total3 += Integer.parseInt(endT4List.getPrice_total3());
							k4s_end_rid4 += Integer.parseInt(endT4List.getEnd_rid4());
							k4s_price_assess4 += Integer.parseInt(endT4List.getPrice_assess4());
							k4s_price_time4 += Integer.parseInt(endT4List.getPrice_time4());
							k4s_price_traffic4 += Integer.parseInt(endT4List.getPrice_traffic4());
							k4s_price_qr4 += Integer.parseInt(endT4List.getPrice_qr4());
							k4s_price_total4 += Integer.parseInt(endT4List.getPrice_total4());
							k4s_end_rid5 += Integer.parseInt(endT4List.getEnd_rid5());
							k4s_price_assess5 += Integer.parseInt(endT4List.getPrice_assess5());
							k4s_price_time5 += Integer.parseInt(endT4List.getPrice_time5());
							k4s_price_traffic5 += Integer.parseInt(endT4List.getPrice_traffic5());
							k4s_price_qr5 += Integer.parseInt(endT4List.getPrice_qr5());
							k4s_price_total5 += Integer.parseInt(endT4List.getPrice_total5());
							k4s_end_rid6 += Integer.parseInt(endT4List.getEnd_rid6());
							k4s_price_assess6 += Integer.parseInt(endT4List.getPrice_assess6());
							k4s_price_time6 += Integer.parseInt(endT4List.getPrice_time6());
							k4s_price_traffic6 += Integer.parseInt(endT4List.getPrice_traffic6());
							k4s_price_qr6 += Integer.parseInt(endT4List.getPrice_qr6());
							k4s_price_total6 += Integer.parseInt(endT4List.getPrice_total6());
							k4s_end_rid7 += Integer.parseInt(endT4List.getEnd_rid7());
							k4s_price_assess7 += Integer.parseInt(endT4List.getPrice_assess7());
							k4s_price_time7 += Integer.parseInt(endT4List.getPrice_time7());
							k4s_price_traffic7 += Integer.parseInt(endT4List.getPrice_traffic7());
							k4s_price_qr7 += Integer.parseInt(endT4List.getPrice_qr7());
							k4s_price_total7 += Integer.parseInt(endT4List.getPrice_total7());
							k4s_end_rid8 += Integer.parseInt(endT4List.getEnd_rid8());
							k4s_price_assess8 += Integer.parseInt(endT4List.getPrice_assess8());
							k4s_price_time8 += Integer.parseInt(endT4List.getPrice_time8());
							k4s_price_traffic8 += Integer.parseInt(endT4List.getPrice_traffic8());
							k4s_price_qr8 += Integer.parseInt(endT4List.getPrice_qr8());
							k4s_price_total8 += Integer.parseInt(endT4List.getPrice_total8());
							k4s_end_rid9 += Integer.parseInt(endT4List.getEnd_rid9());
							k4s_price_assess9 += Integer.parseInt(endT4List.getPrice_assess9());
							k4s_price_time9 += Integer.parseInt(endT4List.getPrice_time9());
							k4s_price_traffic9 += Integer.parseInt(endT4List.getPrice_traffic9());
							k4s_price_qr9 += Integer.parseInt(endT4List.getPrice_qr9());
							k4s_price_total9 += Integer.parseInt(endT4List.getPrice_total9());
							k4s_end_rid10 += Integer.parseInt(endT4List.getEnd_rid10());
							k4s_price_assess10 += Integer.parseInt(endT4List.getPrice_assess10());
							k4s_price_time10 += Integer.parseInt(endT4List.getPrice_time10());
							k4s_price_traffic10 += Integer.parseInt(endT4List.getPrice_traffic10());
							k4s_price_qr10 += Integer.parseInt(endT4List.getPrice_qr10());
							k4s_price_total10 += Integer.parseInt(endT4List.getPrice_total10());
							k4s_end_rid11 += Integer.parseInt(endT4List.getEnd_rid11());
							k4s_price_assess11 += Integer.parseInt(endT4List.getPrice_assess11());
							k4s_price_time11 += Integer.parseInt(endT4List.getPrice_time11());
							k4s_price_traffic11 += Integer.parseInt(endT4List.getPrice_traffic11());
							k4s_price_qr11 += Integer.parseInt(endT4List.getPrice_qr11());
							k4s_price_total11 += Integer.parseInt(endT4List.getPrice_total11());
							k4s_end_rid12 += Integer.parseInt(endT4List.getEnd_rid12());
							k4s_price_assess12 += Integer.parseInt(endT4List.getPrice_assess12());
							k4s_price_time12 += Integer.parseInt(endT4List.getPrice_time12());
							k4s_price_traffic12 += Integer.parseInt(endT4List.getPrice_traffic12());
							k4s_price_qr12 += Integer.parseInt(endT4List.getPrice_qr12());
							k4s_price_total12 += Integer.parseInt(endT4List.getPrice_total12());
							k4s_end_sum += Integer.parseInt(endT4List.getEnd_sum());
							k4s_price_assess_sum += Integer.parseInt(endT4List.getPrice_assess_sum());
							k4s_price_time_sum += Integer.parseInt(endT4List.getPrice_time_sum());
							k4s_price_traffic_sum += Integer.parseInt(endT4List.getPrice_traffic_sum());
							k4s_price_qr_sum += Integer.parseInt(endT4List.getPrice_qr_sum());
							k4s_price_total_sum += Integer.parseInt(endT4List.getPrice_total_sum());
							kind4endList.add(endT4List);
							
						}
						
						EndTeamVO pricesum4VO = new EndTeamVO();
						pricesum4VO.setSum_rid(""+(k4s_end_rid));
						pricesum4VO.setSum_assess(""+(k4s_price_assess));
						pricesum4VO.setSum_time(""+(k4s_price_time));
						pricesum4VO.setSum_traffic(""+(k4s_price_traffic));
						pricesum4VO.setSum_qr(""+(k4s_price_qr));
						pricesum4VO.setSum_total(""+(k4s_price_total));
						pricesum4VO.setSum_rid2(""+(k4s_end_rid2));
						pricesum4VO.setSum_assess2(""+(k4s_price_assess2));
						pricesum4VO.setSum_time2(""+(k4s_price_time2));
						pricesum4VO.setSum_traffic2(""+(k4s_price_traffic2));
						pricesum4VO.setSum_qr2(""+(k4s_price_qr2));
						pricesum4VO.setSum_total2(""+(k4s_price_total2));
						pricesum4VO.setSum_rid3(""+(k4s_end_rid3));
						pricesum4VO.setSum_assess3(""+(k4s_price_assess3));
						pricesum4VO.setSum_time3(""+(k4s_price_time3));
						pricesum4VO.setSum_traffic3(""+(k4s_price_traffic3));
						pricesum4VO.setSum_qr3(""+(k4s_price_qr3));
						pricesum4VO.setSum_total3(""+(k4s_price_total3));
						pricesum4VO.setSum_rid4(""+(k4s_end_rid4));
						pricesum4VO.setSum_assess4(""+(k4s_price_assess4));
						pricesum4VO.setSum_time4(""+(k4s_price_time4));
						pricesum4VO.setSum_traffic4(""+(k4s_price_traffic4));
						pricesum4VO.setSum_qr4(""+(k4s_price_qr4));
						pricesum4VO.setSum_total4(""+(k4s_price_total4));
						pricesum4VO.setSum_rid5(""+(k4s_end_rid5));
						pricesum4VO.setSum_assess5(""+(k4s_price_assess5));
						pricesum4VO.setSum_time5(""+(k4s_price_time5));
						pricesum4VO.setSum_traffic5(""+(k4s_price_traffic5));
						pricesum4VO.setSum_qr5(""+(k4s_price_qr5));
						pricesum4VO.setSum_total5(""+(k4s_price_total5));
						pricesum4VO.setSum_rid6(""+(k4s_end_rid6));
						pricesum4VO.setSum_assess6(""+(k4s_price_assess6));
						pricesum4VO.setSum_time6(""+(k4s_price_time6));
						pricesum4VO.setSum_traffic6(""+(k4s_price_traffic6));
						pricesum4VO.setSum_qr6(""+(k4s_price_qr6));
						pricesum4VO.setSum_total6(""+(k4s_price_total6));
						pricesum4VO.setSum_rid7(""+(k4s_end_rid7));
						pricesum4VO.setSum_assess7(""+(k4s_price_assess7));
						pricesum4VO.setSum_time7(""+(k4s_price_time7));
						pricesum4VO.setSum_traffic7(""+(k4s_price_traffic7));
						pricesum4VO.setSum_qr7(""+(k4s_price_qr7));
						pricesum4VO.setSum_total7(""+(k4s_price_total7));
						pricesum4VO.setSum_rid8(""+(k4s_end_rid8));
						pricesum4VO.setSum_assess8(""+(k4s_price_assess8));
						pricesum4VO.setSum_time8(""+(k4s_price_time8));
						pricesum4VO.setSum_traffic8(""+(k4s_price_traffic8));
						pricesum4VO.setSum_qr8(""+(k4s_price_qr8));
						pricesum4VO.setSum_total8(""+(k4s_price_total8));
						pricesum4VO.setSum_rid9(""+(k4s_end_rid9));
						pricesum4VO.setSum_assess9(""+(k4s_price_assess9));
						pricesum4VO.setSum_time9(""+(k4s_price_time9));
						pricesum4VO.setSum_traffic9(""+(k4s_price_traffic9));
						pricesum4VO.setSum_qr9(""+(k4s_price_qr9));
						pricesum4VO.setSum_total9(""+(k4s_price_total9));
						pricesum4VO.setSum_rid10(""+(k4s_end_rid10));
						pricesum4VO.setSum_assess10(""+(k4s_price_assess10));
						pricesum4VO.setSum_time10(""+(k4s_price_time10));
						pricesum4VO.setSum_traffic10(""+(k4s_price_traffic10));
						pricesum4VO.setSum_qr10(""+(k4s_price_qr10));
						pricesum4VO.setSum_total10(""+(k4s_price_total10));
						pricesum4VO.setSum_rid11(""+(k4s_end_rid11));
						pricesum4VO.setSum_assess11(""+(k4s_price_assess11));
						pricesum4VO.setSum_time11(""+(k4s_price_time11));
						pricesum4VO.setSum_traffic11(""+(k4s_price_traffic11));
						pricesum4VO.setSum_qr11(""+(k4s_price_qr11));
						pricesum4VO.setSum_total11(""+(k4s_price_total11));
						pricesum4VO.setSum_rid12(""+(k4s_end_rid12));
						pricesum4VO.setSum_assess12(""+(k4s_price_assess12));
						pricesum4VO.setSum_time12(""+(k4s_price_time12));
						pricesum4VO.setSum_traffic12(""+(k4s_price_traffic12));
						pricesum4VO.setSum_qr12(""+(k4s_price_qr12));
						pricesum4VO.setSum_total12(""+(k4s_price_total12));
						pricesum4VO.setSum_rid_t(""+(k4s_end_sum));
						pricesum4VO.setSum_assess_t(""+(k4s_price_assess_sum));
						pricesum4VO.setSum_time_t(""+(k4s_price_time_sum));
						pricesum4VO.setSum_traffic_t(""+(k4s_price_traffic_sum));
						pricesum4VO.setSum_qr_t(""+(k4s_price_qr_sum));
						pricesum4VO.setSum_total_t(""+(k4s_price_total_sum));
						
						EndTeamVO pricesum14VO = new EndTeamVO();
						pricesum14VO.setSum_rid(""+(k1s_end_rid+k4s_end_rid));
						pricesum14VO.setSum_assess(""+(k1s_price_assess+k4s_price_assess));
						pricesum14VO.setSum_time(""+(k1s_price_time+k4s_price_time));
						pricesum14VO.setSum_traffic(""+(k1s_price_traffic+k4s_price_traffic));
						pricesum14VO.setSum_qr(""+(k1s_price_qr+k4s_price_qr));
						pricesum14VO.setSum_total(""+(k1s_price_total+k4s_price_total));
						pricesum14VO.setSum_rid2(""+(k1s_end_rid2+k4s_end_rid2));
						pricesum14VO.setSum_assess2(""+(k1s_price_assess2+k4s_price_assess2));
						pricesum14VO.setSum_time2(""+(k1s_price_time2+k4s_price_time2));
						pricesum14VO.setSum_traffic2(""+(k1s_price_traffic2+k4s_price_traffic2));
						pricesum14VO.setSum_qr2(""+(k1s_price_qr2+k4s_price_qr2));
						pricesum14VO.setSum_total2(""+(k1s_price_total2+k4s_price_total2));
						pricesum14VO.setSum_rid3(""+(k1s_end_rid3+k4s_end_rid3));
						pricesum14VO.setSum_assess3(""+(k1s_price_assess3+k4s_price_assess3));
						pricesum14VO.setSum_time3(""+(k1s_price_time3+k4s_price_time3));
						pricesum14VO.setSum_traffic3(""+(k1s_price_traffic3+k4s_price_traffic3));
						pricesum14VO.setSum_qr3(""+(k1s_price_qr3+k4s_price_qr3));
						pricesum14VO.setSum_total3(""+(k1s_price_total3+k4s_price_total3));
						pricesum14VO.setSum_rid4(""+(k1s_end_rid4+k4s_end_rid4));
						pricesum14VO.setSum_assess4(""+(k1s_price_assess4+k4s_price_assess4));
						pricesum14VO.setSum_time4(""+(k1s_price_time4+k4s_price_time4));
						pricesum14VO.setSum_traffic4(""+(k1s_price_traffic4+k4s_price_traffic4));
						pricesum14VO.setSum_qr4(""+(k1s_price_qr4+k4s_price_qr4));
						pricesum14VO.setSum_total4(""+(k1s_price_total4+k4s_price_total4));
						pricesum14VO.setSum_rid5(""+(k1s_end_rid5+k4s_end_rid5));
						pricesum14VO.setSum_assess5(""+(k1s_price_assess5+k4s_price_assess5));
						pricesum14VO.setSum_time5(""+(k1s_price_time5+k4s_price_time5));
						pricesum14VO.setSum_traffic5(""+(k1s_price_traffic5+k4s_price_traffic5));
						pricesum14VO.setSum_qr5(""+(k1s_price_qr5+k4s_price_qr5));
						pricesum14VO.setSum_total5(""+(k1s_price_total5+k4s_price_total5));
						pricesum14VO.setSum_rid6(""+(k1s_end_rid6+k4s_end_rid6));
						pricesum14VO.setSum_assess6(""+(k1s_price_assess6+k4s_price_assess6));
						pricesum14VO.setSum_time6(""+(k1s_price_time6+k4s_price_time6));
						pricesum14VO.setSum_traffic6(""+(k1s_price_traffic6+k4s_price_traffic6));
						pricesum14VO.setSum_qr6(""+(k1s_price_qr6+k4s_price_qr6));
						pricesum14VO.setSum_total6(""+(k1s_price_total6+k4s_price_total6));
						pricesum14VO.setSum_rid7(""+(k1s_end_rid7+k4s_end_rid7));
						pricesum14VO.setSum_assess7(""+(k1s_price_assess7+k4s_price_assess7));
						pricesum14VO.setSum_time7(""+(k1s_price_time7+k4s_price_time7));
						pricesum14VO.setSum_traffic7(""+(k1s_price_traffic7+k4s_price_traffic7));
						pricesum14VO.setSum_qr7(""+(k1s_price_qr7+k4s_price_qr7));
						pricesum14VO.setSum_total7(""+(k1s_price_total7+k4s_price_total7));
						pricesum14VO.setSum_rid8(""+(k1s_end_rid8+k4s_end_rid8));
						pricesum14VO.setSum_assess8(""+(k1s_price_assess8+k4s_price_assess8));
						pricesum14VO.setSum_time8(""+(k1s_price_time8+k4s_price_time8));
						pricesum14VO.setSum_traffic8(""+(k1s_price_traffic8+k4s_price_traffic8));
						pricesum14VO.setSum_qr8(""+(k1s_price_qr8+k4s_price_qr8));
						pricesum14VO.setSum_total8(""+(k1s_price_total8+k4s_price_total8));
						pricesum14VO.setSum_rid9(""+(k1s_end_rid9+k4s_end_rid9));
						pricesum14VO.setSum_assess9(""+(k1s_price_assess9+k4s_price_assess9));
						pricesum14VO.setSum_time9(""+(k1s_price_time9+k4s_price_time9));
						pricesum14VO.setSum_traffic9(""+(k1s_price_traffic9+k4s_price_traffic9));
						pricesum14VO.setSum_qr9(""+(k1s_price_qr9+k4s_price_qr9));
						pricesum14VO.setSum_total9(""+(k1s_price_total9+k4s_price_total9));
						pricesum14VO.setSum_rid10(""+(k1s_end_rid10+k4s_end_rid10));
						pricesum14VO.setSum_assess10(""+(k1s_price_assess10+k4s_price_assess10));
						pricesum14VO.setSum_time10(""+(k1s_price_time10+k4s_price_time10));
						pricesum14VO.setSum_traffic10(""+(k1s_price_traffic10+k4s_price_traffic10));
						pricesum14VO.setSum_qr10(""+(k1s_price_qr10+k4s_price_qr10));
						pricesum14VO.setSum_total10(""+(k1s_price_total10+k4s_price_total10));
						pricesum14VO.setSum_rid11(""+(k1s_end_rid11+k4s_end_rid11));
						pricesum14VO.setSum_assess11(""+(k1s_price_assess11+k4s_price_assess11));
						pricesum14VO.setSum_time11(""+(k1s_price_time11+k4s_price_time11));
						pricesum14VO.setSum_traffic11(""+(k1s_price_traffic11+k4s_price_traffic11));
						pricesum14VO.setSum_qr11(""+(k1s_price_qr11+k4s_price_qr11));
						pricesum14VO.setSum_total11(""+(k1s_price_total11+k4s_price_total11));
						pricesum14VO.setSum_rid12(""+(k1s_end_rid12+k4s_end_rid12));
						pricesum14VO.setSum_assess12(""+(k1s_price_assess12+k4s_price_assess12));
						pricesum14VO.setSum_time12(""+(k1s_price_time12+k4s_price_time12));
						pricesum14VO.setSum_traffic12(""+(k1s_price_traffic12+k4s_price_traffic12));
						pricesum14VO.setSum_qr12(""+(k1s_price_qr12+k4s_price_qr12));
						pricesum14VO.setSum_total12(""+(k1s_price_total12+k4s_price_total12));
						pricesum14VO.setSum_rid_t(""+(k1s_end_sum+k4s_end_sum));
						pricesum14VO.setSum_assess_t(""+(k1s_price_assess_sum+k4s_price_assess_sum));
						pricesum14VO.setSum_time_t(""+(k1s_price_time_sum+k4s_price_time_sum));
						pricesum14VO.setSum_traffic_t(""+(k1s_price_traffic_sum+k4s_price_traffic_sum));
						pricesum14VO.setSum_qr_t(""+(k1s_price_qr_sum+k4s_price_qr_sum));
						pricesum14VO.setSum_total_t(""+(k1s_price_total_sum+k4s_price_total_sum));
						
						model.addAttribute("kind4endList", kind4endList);
						model.addAttribute("end4List", end4List);
						model.addAttribute("sum_end4", pricesum4VO);
						model.addAttribute("sum_end14", pricesum14VO);
						
						
					
				model.addAttribute("vo2", vo2);
				
				model.addAttribute("pgid", "end_team");

		return "ls_log/log_index";
	}
	
	@RequestMapping(value = "/end_team_excel", method = RequestMethod.POST)
	public void EndTeamExcel(Model model, HttpServletRequest request, HttpServletResponse response, String hidtab) {
		//String nowDate=DateUtil.getDate("yyyyMMddHHmmss");

		response.reset();
		//response.setCharacterEncoding("euc-kr");
		response.setContentType("application/vnd.ms-excel; charset=UTF-8");
		response.setHeader("Content-Disposition","attachment;filename=reg_member_excel_.xls");
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
