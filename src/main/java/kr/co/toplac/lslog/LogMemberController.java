package kr.co.toplac.lslog;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
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

import kr.co.toplac.topstatistics.StatisticsNowVO;

/*
*********************************************************
* Program ID	: LogMemberController
* Program Name	: 
* Description	: 
* Author		: leedongik
* Date			: 2015.12.30.
* Update		: 
*********************************************************
*/
@Controller
public class LogMemberController {

	private static final Logger logger = LoggerFactory.getLogger(LogTeamController.class);

	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value = "/log_member", method = RequestMethod.GET)
	public String logMember(Model model, LogMemberViewVO vo, String team_id, String team_name, String user_id) {
		String viewName = logMemberPost(model, vo, team_id, team_name, user_id);
		return viewName;
	}

	@RequestMapping(value = "/log_member111", method = RequestMethod.POST)
	public String logMemberPost(Model model, LogMemberViewVO vo, String team_id, String team_name, String user_id) {
		logger.info("======= logMemberPost =======");

		//날짜만들기 시작
		String fromdate = vo.getViewFromDate();
		String todate = vo.getViewToDate();

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
		//날짜만들기 종료

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fromdate", fromdate);
		map.put("todate", todate);
		map.put("fromYear", fromYear);
		map.put("toYear", toYear);
		map.put("team_id", team_id);
		
		//화면에서 오는 구분값 받기 start
				String typeF = vo.getTypeF();
				String baseF = vo.getBaseF();
				String nscF = vo.getNscF();
				String contractF = vo.getContractF();
				String selectVal = vo.getSelectVal();
				if(selectVal == null) {
					baseF = "ok";
					map.put("baseF", baseF);
				}				
				if(baseF != null) {
					map.put("baseF", baseF);
				}
				if(nscF != null) {
					map.put("nscF", nscF);
				}
				if(contractF != null) {
					map.put("contractF", contractF);
				}
				if(baseF == null & nscF == null & contractF == null){
					baseF = "ok";
					map.put("baseF", baseF);
				}
		//화면에서 오는 구분값 받기 end

		model.addAttribute("user_id", user_id);
		model.addAttribute("team_name", team_name);
		model.addAttribute("team_id", team_id);
		model.addAttribute("fromdate", fromdate);
		model.addAttribute("todate", todate);
		model.addAttribute("fromYear", fromYear);
		model.addAttribute("toYear", toYear);
		model.addAttribute("toAccumYear", toAccumYear);
		model.addAttribute("toMonthInt", todate.substring(5, 7));
		model.addAttribute("typeF", typeF);
		model.addAttribute("baseF", baseF);
		model.addAttribute("nscF", nscF);
		model.addAttribute("contractF", contractF);

		DecimalFormat format1 = new DecimalFormat("###,##0.##");
		DecimalFormat format2 = new DecimalFormat("#,###");	
		LogMemberVO zeroVO = new LogMemberVO();
		zeroVO.setSum_reg_m("0");
		zeroVO.setSum_reg_y("0");
		zeroVO.setSum_end_m("0");
		zeroVO.setSum_end_y("0");
		zeroVO.setSum_proc_m("0");
		zeroVO.setSum_proc_y("0");
		zeroVO.setSum_nend_p("0");
		zeroVO.setSum_nend_30r("0");
		zeroVO.setSum_endea_m("0");
		zeroVO.setSum_endea_y("0");
		zeroVO.setSum_price_assess("0");
		zeroVO.setSum_price_time("0");
		zeroVO.setSum_price_sum1("0");
		zeroVO.setSum_price_traffic("0");
		zeroVO.setSum_price_question("0");
		zeroVO.setSum_price_receipt("0");
		zeroVO.setSum_price_sum2("0");
		zeroVO.setSum_price_total("0");

		//팀별 인원 이름 조회 Start
		if(selectVal == null || selectVal == "") {
			selectVal = team_id;
		}
		map.put("selectVal", selectVal);
		model.addAttribute("selectVal", selectVal);	
		List<LogMemberVO> memberList = sqlSession.selectList("LogMemberMapper.k1member", map);
		//팀별 인원 이름 조회 End

		String minusDay = "1296000";//15일
		if(memberList.size() > 0) {	
			String tmp_team_type = memberList.get(0).getTeam_type();
			if(tmp_team_type.equals("1")){
				minusDay = "2592000";//30일
			}
		}

		//개인별 통계 합계 변수 선언 시작
		int mem_reg_m = 0;
		int mem_reg_y = 0;
		int mem_end_m = 0;
		int mem_end_y = 0;
		double mem_proc_m = 0;
		double mem_proc_y = 0;
		int mem_nend_p = 0;
		double mem_nend_30r = 0;
		double mem_ea_sum = 0;
		double mem_endea_y = 0;
		int mem_price_assess = 0;
		int mem_price_time = 0;
		int mem_price_sum1 = 0;
		int mem_price_traffic = 0;
		int mem_price_question = 0;
		int mem_price_receipt = 0;
		int mem_price_sum2 = 0;
		int mem_price_total = 0;
		int mem_report_ea = 0;
		int mem_p_price_a = 0;
		int mem_p_price_b = 0;
		int mem_sum_little = 0;
		int mem_sum_hap = 0;
		int mem_no_settle = 0;
		//개인별 통계 합계 변수 선언 종료

		List<LogMemberVO> kmemberList = new ArrayList<LogMemberVO>();
		int intFormember = 0;

		for(int i = 0; i < memberList.size(); i++, intFormember++){
			LogMemberVO memberVO = memberList.get(i);
			String tmpStr = memberVO.getUser_id();

			map.put("tmpStr", tmpStr);

			//개인별log 조회 Start
			LogMemberVO logmList = sqlSession.selectOne("LogMemberMapper.logmember", map);
			//개인별log 조회 End

			logmList.setName(memberVO.getName());
			logmList.setUser_id(memberVO.getUser_id());
			logmList.setTeam_id(memberVO.getTeam_id());
			logmList.setTeam_name(memberVO.getTeam_name());
			mem_reg_m += Integer.parseInt(logmList.getReg_m());
			mem_reg_y += Integer.parseInt(logmList.getReg_y());
			mem_end_m += Integer.parseInt(logmList.getEnd_m());
			mem_end_y += Integer.parseInt(logmList.getEnd_y());
			mem_proc_m += Double.parseDouble(logmList.getProc_m());
			mem_proc_y += Double.parseDouble(logmList.getProc_y());
			mem_nend_p += Integer.parseInt(logmList.getNend_p());
			mem_nend_30r += Double.parseDouble(logmList.getNend_30r());
			mem_ea_sum += Double.parseDouble(logmList.getEa_sum());
			mem_report_ea += Double.parseDouble(logmList.getReport_ea());
			mem_price_assess += Integer.parseInt(logmList.getPrice_assess());
			mem_price_time += Integer.parseInt(logmList.getPrice_time());
			mem_p_price_a += Double.parseDouble(logmList.getP_price_a());
			mem_p_price_b += Double.parseDouble(logmList.getP_price_b());
			mem_sum_little += Double.parseDouble(logmList.getSum_little());
			mem_price_traffic += Integer.parseInt(logmList.getPrice_traffic());
			mem_price_question += Integer.parseInt(logmList.getPrice_question()); 
			mem_price_receipt += Integer.parseInt(logmList.getPrice_receipt());
			mem_sum_hap += Double.parseDouble(logmList.getSum_hap()); 
			mem_no_settle += Double.parseDouble(logmList.getNo_settle());
			
			kmemberList.add(logmList);
		}
		
		
			//전체팀 조회 Start
			List<LogMemberVO> MteamList = sqlSession.selectList("LogMemberMapper.teamlist", vo);
			
			model.addAttribute("MteamList",MteamList);
			
			//전체팀 조회 조회 End
			

		//팀 log 합계 start
		LogMemberVO kind1SumVO = new LogMemberVO();
		kind1SumVO.setName("합 계");
		kind1SumVO.setReg_m(""+mem_reg_m);
		kind1SumVO.setReg_y(""+mem_reg_y);
		kind1SumVO.setEnd_m(""+mem_end_m);
		kind1SumVO.setEnd_y(""+mem_end_y);
		kind1SumVO.setProc_m(""+format1.format((mem_proc_m/intFormember)));
		kind1SumVO.setProc_y(""+format1.format(mem_proc_y/intFormember));
		kind1SumVO.setNend_p(""+mem_nend_p);
		kind1SumVO.setNend_30r(""+format1.format(mem_nend_30r/intFormember));
		kind1SumVO.setEa_sum(""+format1.format(mem_ea_sum));
		kind1SumVO.setReport_ea(""+format1.format(mem_report_ea));
		kind1SumVO.setPrice_assess(""+format2.format(mem_price_assess));
		kind1SumVO.setPrice_time(""+format2.format(mem_price_time));
		kind1SumVO.setP_price_a(""+format2.format(mem_p_price_a));
		kind1SumVO.setP_price_b(""+format2.format(mem_p_price_b));
		kind1SumVO.setSum_little(""+format2.format(mem_sum_little));
		kind1SumVO.setPrice_traffic(""+format2.format(mem_price_traffic));
		kind1SumVO.setPrice_question(""+format2.format(mem_price_question));
		kind1SumVO.setPrice_receipt(""+format2.format(mem_price_receipt));
		kind1SumVO.setSum_hap(""+format2.format(mem_sum_hap));
		kind1SumVO.setNo_settle(""+format2.format(mem_no_settle));
		kmemberList.add(kind1SumVO);
		//팀 log 합계 end
		
		model.addAttribute("kmemberList", kmemberList);
		model.addAttribute("minusDay", minusDay);
		model.addAttribute("pgid", "log_member");
		
		return "ls_log/log_index";
	}

	@RequestMapping(value = "/log_member_excel", method = RequestMethod.POST)
	public void logTeamExcel(Model model, HttpServletRequest request, HttpServletResponse response, String hidtab) {
		logger.info("======= logTeamExcel =======");

		response.setCharacterEncoding("euc-kr");
		response.setHeader("Content-Disposition","attachment;filename=log_member_excel_.xls");
	    response.setHeader("Content-Description", "JSP Generated Data");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		out.println(hidtab);
		out.close();
	}//logTeamExcel

}//class
