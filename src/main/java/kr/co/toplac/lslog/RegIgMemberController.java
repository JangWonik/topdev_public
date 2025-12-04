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
public class RegIgMemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(RegIgMemberController.class);

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
	@RequestMapping(value = "/reg_ig_member", method = RequestMethod.GET)
	public String regIgMember(Model model, HttpServletRequest request, RegIgMemberVO vo2, String ig_id, String rid, String year, String month, String fromdate, String todate, String team_id, String ig_nick, String team_name) {
		String viewName = regIgMemberPost(model, request, vo2, rid, year, month, ig_id,fromdate, todate, team_id, ig_nick, team_name);
		return viewName;
	}

	@RequestMapping(value = "/reg_ig_member", method = RequestMethod.POST)
	public String regIgMemberPost(Model model, HttpServletRequest request, RegIgMemberVO vo2, String rid, String year, String month, String ig_id, String fromdate, String todate, String team_id, String ig_nick, String team_name) {
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
		map.put("tmpTeamid", team_id);
		map.put("ig_nick", ig_nick);
		map.put("team_name", team_name);
		
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
		
		List<RegIgVO> memberList = new ArrayList<RegIgVO>();
		memberList = sqlSession.selectList("RegIgMemberMapper.selteam", map);
		
		
		//1종 소계 변수 선언 종료

				List<RegIgVO> regmemberList = new ArrayList<RegIgVO>();
				int intForkind1 = 0;

				for(int i = 0; i < memberList.size(); i++, intForkind1++){
					RegIgVO regmemberVO = memberList.get(i);
					String tmpName = regmemberVO.getName();
					String tmpNo = regmemberVO.getNo();
					map.put("tmpName", tmpName);
					map.put("tmpNo", tmpNo);
					
					//1종 log 조회 Start
					RegIgVO regTmemberList = sqlSession.selectOne("RegIgMemberMapper.regmember", map);
					//1종 log 조회 End

					regTmemberList.setIg_id(regmemberVO.getIg_id());
					regTmemberList.setName(regmemberVO.getName());
					regTmemberList.setNo(regmemberVO.getNo());
					regTmemberList.setTeam_id(regmemberVO.getTeam_id());
					regTmemberList.setTeam_name(regmemberVO.getTeam_name());
					k1s_reg_rid += Integer.parseInt(regTmemberList.getReg_rid());
					k1s_end_rid += Integer.parseInt(regTmemberList.getEnd_rid());
					k1s_reg_rid2 += Integer.parseInt(regTmemberList.getReg_rid2());
					k1s_end_rid2 += Integer.parseInt(regTmemberList.getEnd_rid2());
					k1s_reg_rid3 += Integer.parseInt(regTmemberList.getReg_rid3());
					k1s_end_rid3 += Integer.parseInt(regTmemberList.getEnd_rid3());
					k1s_reg_rid4 += Integer.parseInt(regTmemberList.getReg_rid4());
					k1s_end_rid4 += Integer.parseInt(regTmemberList.getEnd_rid4());
					k1s_reg_rid5 += Integer.parseInt(regTmemberList.getReg_rid5());
					k1s_end_rid5 += Integer.parseInt(regTmemberList.getEnd_rid5());
					k1s_reg_rid6 += Integer.parseInt(regTmemberList.getReg_rid6());
					k1s_end_rid6 += Integer.parseInt(regTmemberList.getEnd_rid6());
					k1s_reg_rid7 += Integer.parseInt(regTmemberList.getReg_rid7());
					k1s_end_rid7 += Integer.parseInt(regTmemberList.getEnd_rid7());
					k1s_reg_rid8 += Integer.parseInt(regTmemberList.getReg_rid8());
					k1s_end_rid8 += Integer.parseInt(regTmemberList.getEnd_rid8());
					k1s_reg_rid9 += Integer.parseInt(regTmemberList.getReg_rid9());
					k1s_end_rid9 += Integer.parseInt(regTmemberList.getEnd_rid9());
					k1s_reg_rid10 += Integer.parseInt(regTmemberList.getReg_rid10());
					k1s_end_rid10 += Integer.parseInt(regTmemberList.getEnd_rid10());
					k1s_reg_rid11 += Integer.parseInt(regTmemberList.getReg_rid11());
					k1s_end_rid11 += Integer.parseInt(regTmemberList.getEnd_rid11());
					k1s_reg_rid12 += Integer.parseInt(regTmemberList.getReg_rid12());
					k1s_end_rid12 += Integer.parseInt(regTmemberList.getEnd_rid12());
					k1s_reg_sum += Integer.parseInt(regTmemberList.getReg_sum());
					k1s_end_sum += Integer.parseInt(regTmemberList.getEnd_sum());
					regmemberList.add(regTmemberList);
					
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
				
				model.addAttribute("regmemberList", regmemberList);
				model.addAttribute("sum_reg", regsum1VO);
				model.addAttribute("sum_end", endsum1VO);
				model.addAttribute("memberList", memberList);
				model.addAttribute("ig_id", ig_id);
				
							
				
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
				
				
						
				model.addAttribute("vo2", vo2);
				model.addAttribute("sum_reg14", regsum14VO);
				model.addAttribute("sum_end14", endsum14VO);
				model.addAttribute("pgid", "reg_ig_member");

		return "ls_log/log_index";
	}
	
	@RequestMapping(value = "/reg_ig_member_excel", method = RequestMethod.POST)
	public void logMemberExcel(Model model, HttpServletRequest request, HttpServletResponse response, String hidtab) {
		//String nowDate=DateUtil.getDate("yyyyMMddHHmmss");

		response.reset();
		//response.setCharacterEncoding("euc-kr");
		response.setContentType("application/vnd.ms-excel; charset=UTF-8");
		response.setHeader("Content-Disposition","attachment;filename=reg_ig_member_excel_.xls");
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
