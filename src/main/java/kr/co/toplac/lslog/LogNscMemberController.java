package kr.co.toplac.lslog;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

	
@Controller
public class LogNscMemberController {
		
	//private static final Logger logger = LoggerFactory.getLogger(LogTeamController.class);

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
		@RequestMapping(value = "/log_nsc_member", method = RequestMethod.GET)
		public String logMember(Model model, LogMemberViewVO vo, String team_id, String team_name, String user_id) {
			String viewName = logMemberPost(model, vo, team_id, team_name, user_id);
			return viewName;
		}

		@RequestMapping(value = "/log_nsc_member", method = RequestMethod.POST)
		public String logMemberPost(Model model, LogMemberViewVO vo, String team_id, String team_name, String user_id) {
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
			
			model.addAttribute("user_id", user_id);
			model.addAttribute("team_name", team_name);
			model.addAttribute("team_id", team_id);
			model.addAttribute("fromdate", fromdate);
			model.addAttribute("todate", todate);
			model.addAttribute("fromYear", fromYear);
			model.addAttribute("toYear", toYear);
			model.addAttribute("toAccumYear", toAccumYear);
			model.addAttribute("toMonthInt", todate.substring(5, 7));
			
			
			//팀별 인원 이름 조회 Start
			List<LogMemberVO> memberList = sqlSession.selectList("LogMemberMapper.kmember", map);
			
			
			
			//팀별 인원 이름 조회 End
			String tmp_team_type = memberList.get(0).getTeam_type();
			String minusDay = "1296000";//15일
			if(tmp_team_type.equals("1")){
				minusDay = "2592000";//30일
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
			DecimalFormat format1 = new DecimalFormat("###,##0.##");
			DecimalFormat format2 = new DecimalFormat("#,###");
			
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
			model.addAttribute("pgid", "log_nsc_member");
			
			return "ls_log/log_index";
		}
			

	}
