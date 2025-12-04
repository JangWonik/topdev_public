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
public class EndMemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(EndMemberController.class);

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
	@RequestMapping(value = "/end_member", method = RequestMethod.GET)
	public String endMember(Model model, HttpServletRequest request, EndMemberViewVO vo2, String ig_id, String rid, String year, String month, String fromdate, String todate, String team_id, String ig_nick, String team_name) {
		String viewName = end_MemberPost(model, request, vo2, rid, year, month, ig_id,fromdate, todate, team_id, ig_nick, team_name);
		return viewName;
	}

	@RequestMapping(value = "/end_member", method = RequestMethod.POST)
	public String end_MemberPost(Model model, HttpServletRequest request, EndMemberViewVO vo2, String rid, String year, String month, String ig_id, String fromdate, String todate, String team_id, String ig_nick, String team_name) {
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
		map.put("ig_nick", ig_nick);
		map.put("team_id", team_id);
		
		
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
		
		//팀별 개인 변수 설정
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
		
		
		List<EndMemberVO> endMList = new ArrayList<EndMemberVO>();
		endMList = sqlSession.selectList("EndMemberMapper.selendM", vo2);
		//팀별 개인 변수 선언 종료
				List<EndMemberVO> endMemberList = new ArrayList<EndMemberVO>();
				int intForkind1 = 0;

				for(int i = 0; i < endMList.size(); i++, intForkind1++){
					EndMemberVO endMVO = endMList.get(i);
					String tmpTeamid = endMVO.getTeam_id();
					String tmpN = endMVO.getName();
					String tmpNo = endMVO.getUser_id();
					
					map.put("tmpN", tmpN);
					map.put("tmpTeamid", team_id);
					map.put("tmpNo", tmpNo);
					//팀별 개인 조회 Start
					EndMemberVO endTMList = sqlSession.selectOne("EndMemberMapper.endmember", map);
					//팀별 개인 조회 End

					endTMList.setUser_id(endMVO.getUser_id());
					endTMList.setTeam_name(endMVO.getTeam_name());
					endTMList.setTeam_id(endMVO.getTeam_id());
					endTMList.setName(endMVO.getName());
					endTMList.setIg_nick(endMVO.getIg_nick());
					k1s_end_rid += Integer.parseInt(endTMList.getEnd_rid());
					k1s_price_assess += Integer.parseInt(endTMList.getPrice_assess());
					k1s_price_time += Integer.parseInt(endTMList.getPrice_time());
					k1s_price_traffic += Integer.parseInt(endTMList.getPrice_traffic());
					k1s_price_qr += Integer.parseInt(endTMList.getPrice_qr());
					k1s_price_total += Integer.parseInt(endTMList.getPrice_total());
					k1s_end_rid2 += Integer.parseInt(endTMList.getEnd_rid2());
					k1s_price_assess2 += Integer.parseInt(endTMList.getPrice_assess2());
					k1s_price_time2 += Integer.parseInt(endTMList.getPrice_time2());
					k1s_price_traffic2 += Integer.parseInt(endTMList.getPrice_traffic2());
					k1s_price_qr2 += Integer.parseInt(endTMList.getPrice_qr2());
					k1s_price_total2 += Integer.parseInt(endTMList.getPrice_total2());;
					k1s_end_rid3 += Integer.parseInt(endTMList.getEnd_rid3());
					k1s_price_assess3 += Integer.parseInt(endTMList.getPrice_assess3());
					k1s_price_time3 += Integer.parseInt(endTMList.getPrice_time3());
					k1s_price_traffic3 += Integer.parseInt(endTMList.getPrice_traffic3());
					k1s_price_qr3 += Integer.parseInt(endTMList.getPrice_qr3());
					k1s_price_total3 += Integer.parseInt(endTMList.getPrice_total3());
					k1s_end_rid4 += Integer.parseInt(endTMList.getEnd_rid4());
					k1s_price_assess4 += Integer.parseInt(endTMList.getPrice_assess4());
					k1s_price_time4 += Integer.parseInt(endTMList.getPrice_time4());
					k1s_price_traffic4 += Integer.parseInt(endTMList.getPrice_traffic4());
					k1s_price_qr4 += Integer.parseInt(endTMList.getPrice_qr4());
					k1s_price_total4 += Integer.parseInt(endTMList.getPrice_total4());
					k1s_end_rid5 += Integer.parseInt(endTMList.getEnd_rid5());
					k1s_price_assess5 += Integer.parseInt(endTMList.getPrice_assess5());
					k1s_price_time5 += Integer.parseInt(endTMList.getPrice_time5());
					k1s_price_traffic5 += Integer.parseInt(endTMList.getPrice_traffic5());
					k1s_price_qr5 += Integer.parseInt(endTMList.getPrice_qr5());
					k1s_price_total5 += Integer.parseInt(endTMList.getPrice_total5());
					k1s_end_rid6 += Integer.parseInt(endTMList.getEnd_rid6());
					k1s_price_assess6 += Integer.parseInt(endTMList.getPrice_assess6());
					k1s_price_time6 += Integer.parseInt(endTMList.getPrice_time6());
					k1s_price_traffic6 += Integer.parseInt(endTMList.getPrice_traffic6());
					k1s_price_qr6 += Integer.parseInt(endTMList.getPrice_qr6());
					k1s_price_total6 += Integer.parseInt(endTMList.getPrice_total6());
					k1s_end_rid7 += Integer.parseInt(endTMList.getEnd_rid7());
					k1s_price_assess7 += Integer.parseInt(endTMList.getPrice_assess7());
					k1s_price_time7 += Integer.parseInt(endTMList.getPrice_time7());
					k1s_price_traffic7 += Integer.parseInt(endTMList.getPrice_traffic7());
					k1s_price_qr7 += Integer.parseInt(endTMList.getPrice_qr7());
					k1s_price_total7 += Integer.parseInt(endTMList.getPrice_total7());
					k1s_end_rid8 += Integer.parseInt(endTMList.getEnd_rid8());
					k1s_price_assess8 += Integer.parseInt(endTMList.getPrice_assess8());
					k1s_price_time8 += Integer.parseInt(endTMList.getPrice_time8());
					k1s_price_traffic8 += Integer.parseInt(endTMList.getPrice_traffic8());
					k1s_price_qr8 += Integer.parseInt(endTMList.getPrice_qr8());
					k1s_price_total8 += Integer.parseInt(endTMList.getPrice_total8());
					k1s_end_rid9 += Integer.parseInt(endTMList.getEnd_rid9());
					k1s_price_assess9 += Integer.parseInt(endTMList.getPrice_assess9());
					k1s_price_time9 += Integer.parseInt(endTMList.getPrice_time9());
					k1s_price_traffic9 += Integer.parseInt(endTMList.getPrice_traffic9());
					k1s_price_qr9 += Integer.parseInt(endTMList.getPrice_qr9());
					k1s_price_total9 += Integer.parseInt(endTMList.getPrice_total9());
					k1s_end_rid10 += Integer.parseInt(endTMList.getEnd_rid10());
					k1s_price_assess10 += Integer.parseInt(endTMList.getPrice_assess10());
					k1s_price_time10 += Integer.parseInt(endTMList.getPrice_time10());
					k1s_price_traffic10 += Integer.parseInt(endTMList.getPrice_traffic10());
					k1s_price_qr10 += Integer.parseInt(endTMList.getPrice_qr10());
					k1s_price_total10 += Integer.parseInt(endTMList.getPrice_total10());
					k1s_end_rid11 += Integer.parseInt(endTMList.getEnd_rid11());
					k1s_price_assess11 += Integer.parseInt(endTMList.getPrice_assess11());
					k1s_price_time11 += Integer.parseInt(endTMList.getPrice_time11());
					k1s_price_traffic11 += Integer.parseInt(endTMList.getPrice_traffic11());
					k1s_price_qr11 += Integer.parseInt(endTMList.getPrice_qr11());
					k1s_price_total11 += Integer.parseInt(endTMList.getPrice_total11());
					k1s_end_rid12 += Integer.parseInt(endTMList.getEnd_rid12());
					k1s_price_assess12 += Integer.parseInt(endTMList.getPrice_assess12());
					k1s_price_time12 += Integer.parseInt(endTMList.getPrice_time12());
					k1s_price_traffic12 += Integer.parseInt(endTMList.getPrice_traffic12());
					k1s_price_qr12 += Integer.parseInt(endTMList.getPrice_qr12());
					k1s_price_total12 += Integer.parseInt(endTMList.getPrice_total12());
					k1s_end_sum += Integer.parseInt(endTMList.getEnd_sum());
					k1s_price_assess_sum += Integer.parseInt(endTMList.getPrice_assess_sum());
					k1s_price_time_sum += Integer.parseInt(endTMList.getPrice_time_sum());
					k1s_price_traffic_sum += Integer.parseInt(endTMList.getPrice_traffic_sum());
					k1s_price_qr_sum += Integer.parseInt(endTMList.getPrice_qr_sum());
					k1s_price_total_sum += Integer.parseInt(endTMList.getPrice_total_sum());
					endMemberList.add(endTMList);
					
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
				
				
				model.addAttribute("endMemberList", endMemberList);
				model.addAttribute("endMList", endMList);
				model.addAttribute("sum_end1", pricesum1VO);
			
				model.addAttribute("vo2", vo2);
				model.addAttribute("pgid", "end_member");

		return "ls_log/log_index";
	}
	
	@RequestMapping(value = "/end_member_excel", method = RequestMethod.POST)
	public void EndMemberExcel(Model model, HttpServletRequest request, HttpServletResponse response, String hidtab) {

		response.reset();
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
