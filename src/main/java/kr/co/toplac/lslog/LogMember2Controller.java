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

/*
*********************************************************
* Program ID	: LogMember2Controller // 영문 프로그램 이름 (파일 이름 가능)
* Program Name	: // 국문 프로그램 이름 (파일 이름 가능)
* Description	: // 간략한 설명
* Author		: leedongik // 개발자 이름
* Date			: 2015.12.30.// 최초 작성일
* Update		: // 수정일 + 수정 요청자(있는 경우) + 수정 내용
*********************************************************
*/
@Controller
public class LogMember2Controller  {
	
	private static final Logger logger = LoggerFactory.getLogger(LogTeamController.class);

	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value = "/log_member2", method = RequestMethod.GET)
	public String logmember2(Model model, LogMemberViewVO vo2, String name, String team_name, String user_id, String rid, String team_id) {
		String viewName = logmember2Post(model, vo2, name, team_name, user_id, rid, team_id);
		return viewName;
	}
		
	@RequestMapping(value = "/log_member2", method = RequestMethod.POST)
	public String logmember2Post(Model model, LogMemberViewVO vo2, String name, String team_name, String user_id, String rid, String team_id) {
		//날짜만들기 시작
			String fromdate = vo2.getViewFromDate();
			String todate = vo2.getViewToDate();
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
			map.put("team_name", team_name);
			map.put("team_id", team_id);
			
			//화면에서 오는 구분값 받기 start
			String typeF = vo2.getTypeF();
			String baseF = vo2.getBaseF();
			String nscF = vo2.getNscF();
			String contractF = vo2.getContractF();
			String MselectVal = vo2.getMselectVal();
			
			
			
			
			if(MselectVal == null || MselectVal == "") {
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
			if(baseF == null & nscF == null & contractF == null) {
				baseF = "ok";
				map.put("baseF", baseF);
			}

			String tmpStr3 = user_id;
			map.put("tmpStr3", tmpStr3);
			
			
			if(MselectVal == null || MselectVal == "") {
				MselectVal = tmpStr3;
			}
			
			model.addAttribute("rid", rid);
			model.addAttribute("team_name", team_name);
			model.addAttribute("team_id", team_id);
			model.addAttribute("fromdate", fromdate);
			model.addAttribute("todate", todate);
			model.addAttribute("fromYear", fromYear);
			model.addAttribute("toYear", toYear);
			model.addAttribute("toAccumYear", toAccumYear);
			model.addAttribute("toMonthInt", todate.substring(5, 7));
			model.addAttribute("baseF", baseF);
			model.addAttribute("nscF", nscF);
			model.addAttribute("contractF", contractF);
			
			
			DecimalFormat format1 = new DecimalFormat("###,##0.##");
			DecimalFormat format2 = new DecimalFormat("#,###");	
			/*LogMemberVO zeroVO = new LogMemberVO();
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
			zeroVO.setSum_price_total("0");*/

			//변수 만들것 주석!!!
			
				
				map.put("team_id", team_id);
				map.put("user_id", user_id);
				map.put("name", name);
				map.put("MselectVal", MselectVal);
				
			model.addAttribute("team_id", team_id);
			model.addAttribute("name", name);
			model.addAttribute("user_id", user_id);
			List<LogMember2VO> member2List = sqlSession.selectList("LogMember2Mapper.member2list", map);
			
			model.addAttribute("member2List", member2List);
			
			List<LogMember2VO> memberNList = sqlSession.selectList("LogMember2Mapper.memberNlist", map);
			model.addAttribute("memberNList", memberNList);
			String Selname = name;
			
			map.put("Selname", Selname);
			model.addAttribute("MselectVal", MselectVal);
			model.addAttribute("Selname", Selname);
			
			//개인별 통계 조회 Start
			//List<LogMember2VO> idmemberListBase = new ArrayList<LogMember2VO>();
			List<LogMember2VO> idmemberListBase = sqlSession.selectList("LogMember2Mapper.imemberBase", map);
			List<LogMember2VO> idmemberListNsc = sqlSession.selectList("LogMember2Mapper.imemberNsc", map);
			List<LogMember2VO> idmemberListContract = sqlSession.selectList("LogMember2Mapper.imemberContract", map);
			//개인별 통계 조회 End

			//개인별 통계 합계 변수 선언 시작
			String report_id = "";
			int price_assess = 0;
			int price_time = 0;
			int report_ea = 0;
			int p_price_mi_a = 0;
			int p_price_mi_b = 0;
			int report_ea_mi = 0;
			int p_price_pl_a = 0;
			int p_price_pl_b = 0;
			int report_ea_pl = 0;
			int sum_little = 0;
			int price_traffic = 0;
			int price_question = 0;
			int price_receipt = 0;
			int sum_hap = 0;
			int myself = 0;
			int together = 0;
			String ig_nick = "";
			String ig_client = "";
			String ig_insured = "";
			int end_date = 0;
			int price_traffic_mi = 0;
			int price_question_mi = 0;
			int price_receipt_mi = 0;
			int sum_hap_mi = 0;
			int price_assess_mi = 0;
			int price_time_mi = 0;
			
			//기본통계
			if(idmemberListBase.size() != 0)
			{
				for(int i = 0; i < idmemberListBase.size(); i++)
				{
					LogMember2VO imemberVO = idmemberListBase.get(i);

					if(imemberVO.getGubun().equals("1")){
						myself++;
					}else{
						together++;
					}
					report_id += (imemberVO.getReport_id());
					price_assess += Integer.parseInt(imemberVO.getPrice_assess());
					price_time += Integer.parseInt(imemberVO.getPrice_time());
					report_ea += Double.parseDouble(imemberVO.getReport_ea());
					p_price_mi_a += Double.parseDouble(imemberVO.getP_price_mi_a()); 
					p_price_mi_b += Double.parseDouble(imemberVO.getP_price_mi_b());
					report_ea_mi += Double.parseDouble(imemberVO.getReport_ea_mi());
					p_price_pl_a += Double.parseDouble(imemberVO.getP_price_pl_a());
					p_price_pl_b += Double.parseDouble(imemberVO.getP_price_pl_b());
					report_ea_pl += Double.parseDouble(imemberVO.getReport_ea_pl());
					sum_little += Double.parseDouble(imemberVO.getSum_little());
					price_traffic += Integer.parseInt(imemberVO.getPrice_traffic());
					price_question += Integer.parseInt(imemberVO.getPrice_question());
					price_receipt += Integer.parseInt(imemberVO.getPrice_receipt());
					sum_hap += Double.parseDouble(imemberVO.getSum_hap());
				}//end of for
			}//end of if
			
			LogMember2VO member2SumVO = new LogMember2VO();
			member2SumVO.setName("합 계");
			member2SumVO.setPrice_assess(""+format2.format(price_assess));
			member2SumVO.setPrice_time(""+format2.format(price_time));
			member2SumVO.setReport_ea(""+format2.format(report_ea));
			member2SumVO.setP_price_mi_a(""+format2.format(p_price_mi_a));
			member2SumVO.setP_price_mi_b(""+format2.format(p_price_mi_b));
			member2SumVO.setReport_ea_mi(""+format2.format(report_ea_mi));
			member2SumVO.setP_price_pl_a(""+format2.format(p_price_pl_a));
			member2SumVO.setP_price_pl_b(""+format2.format(p_price_pl_b));
			member2SumVO.setReport_ea_pl(""+format2.format(report_ea_pl));
			member2SumVO.setSum_little(""+format2.format(sum_little));
			member2SumVO.setPrice_traffic(""+format2.format(price_traffic));
			member2SumVO.setPrice_question(""+format2.format(price_question));
			member2SumVO.setPrice_receipt(""+format2.format(price_receipt));
			member2SumVO.setSum_hap(""+format2.format(sum_hap));
			
			//미수금내역 조회 Start
			List<LogMember2VO> mimemberList = new ArrayList<LogMember2VO>();
			mimemberList = sqlSession.selectList("LogMember2Mapper.mimember", map);
			//미수금내역 조회 End
			for(int i = 0; i < mimemberList.size(); i++)
			{
				LogMember2VO mimemberVO = mimemberList.get(i);
			ig_nick += (mimemberVO.getIg_nick());
			report_id += (mimemberVO.getReport_id());
			ig_client += (mimemberVO.getIg_client());
			ig_insured += (mimemberVO.getIg_insured()); 
			end_date += Double.parseDouble(mimemberVO.getEnd_date());
			price_assess += Double.parseDouble(mimemberVO.getPrice_assess());
			price_time += Double.parseDouble(mimemberVO.getPrice_time());
			price_traffic += Double.parseDouble(mimemberVO.getPrice_traffic());
			price_question += Double.parseDouble(mimemberVO.getPrice_question());
			price_receipt += Double.parseDouble(mimemberVO.getPrice_receipt());
			sum_hap += Double.parseDouble(mimemberVO.getSum_hap());
			
			}
			
			LogMember2VO mimember2SumVO = new LogMember2VO();
			mimember2SumVO.setName("미수금 합계");
			mimember2SumVO.setPrice_assess(""+format2.format(price_assess));
			mimember2SumVO.setPrice_time(""+format2.format(price_time));
			mimember2SumVO.setPrice_traffic(""+format2.format(price_traffic));
			mimember2SumVO.setPrice_question(""+format2.format(price_question));
			mimember2SumVO.setPrice_receipt(""+format2.format(price_receipt));	
			mimember2SumVO.setSum_hap(""+format2.format(sum_hap));
			
			//농작물
			if(idmemberListNsc.size() != 0)
			{
				for(int i = 0; i < idmemberListNsc.size(); i++)
				{
					LogMember2VO imemberVO = idmemberListNsc.get(i);

					if(imemberVO.getGubun().equals("1")){
						myself++;
					}else{
						together++;
					}
					report_id += (imemberVO.getReport_id());
					price_assess += Integer.parseInt(imemberVO.getPrice_assess());
					price_time += Integer.parseInt(imemberVO.getPrice_time());
					report_ea += Double.parseDouble(imemberVO.getReport_ea());
					p_price_mi_a += Double.parseDouble(imemberVO.getP_price_mi_a()); 
					p_price_mi_b += Double.parseDouble(imemberVO.getP_price_mi_b());
					report_ea_mi += Double.parseDouble(imemberVO.getReport_ea_mi());
					p_price_pl_a += Double.parseDouble(imemberVO.getP_price_pl_a());
					p_price_pl_b += Double.parseDouble(imemberVO.getP_price_pl_b());
					report_ea_pl += Double.parseDouble(imemberVO.getReport_ea_pl());
					sum_little += Double.parseDouble(imemberVO.getSum_little());
					price_traffic += Integer.parseInt(imemberVO.getPrice_traffic());
					price_question += Integer.parseInt(imemberVO.getPrice_question());
					price_receipt += Integer.parseInt(imemberVO.getPrice_receipt());
					sum_hap += Double.parseDouble(imemberVO.getSum_hap());
				}//end of for
			}//end of if
			
			LogMember2VO member2SumNscVO = new LogMember2VO();
			member2SumNscVO.setName("합 계");
			member2SumNscVO.setPrice_assess(""+format2.format(price_assess));
			member2SumNscVO.setPrice_time(""+format2.format(price_time));
			member2SumNscVO.setReport_ea(""+format2.format(report_ea));
			member2SumNscVO.setP_price_mi_a(""+format2.format(p_price_mi_a));
			member2SumNscVO.setP_price_mi_b(""+format2.format(p_price_mi_b));
			member2SumNscVO.setReport_ea_mi(""+format2.format(report_ea_mi));
			member2SumNscVO.setP_price_pl_a(""+format2.format(p_price_pl_a));
			member2SumNscVO.setP_price_pl_b(""+format2.format(p_price_pl_b));
			member2SumNscVO.setReport_ea_pl(""+format2.format(report_ea_pl));
			member2SumNscVO.setSum_little(""+format2.format(sum_little));
			member2SumNscVO.setPrice_traffic(""+format2.format(price_traffic));
			member2SumNscVO.setPrice_question(""+format2.format(price_question));
			member2SumNscVO.setPrice_receipt(""+format2.format(price_receipt));
			member2SumNscVO.setSum_hap(""+format2.format(sum_hap));
			
			//미수금내역 조회 Start
			List<LogMember2VO> mimemberListNsc = new ArrayList<LogMember2VO>();
			mimemberListNsc = sqlSession.selectList("LogMember2Mapper.mimember", map);
			//미수금내역 조회 End
			for(int i = 0; i < mimemberListNsc.size(); i++)
			{
				LogMember2VO mimemberVO = mimemberListNsc.get(i);
			ig_nick += (mimemberVO.getIg_nick());
			report_id += (mimemberVO.getReport_id());
			ig_client += (mimemberVO.getIg_client());
			ig_insured += (mimemberVO.getIg_insured()); 
			end_date += Double.parseDouble(mimemberVO.getEnd_date());
			price_assess += Double.parseDouble(mimemberVO.getPrice_assess());
			price_time += Double.parseDouble(mimemberVO.getPrice_time());
			price_traffic += Double.parseDouble(mimemberVO.getPrice_traffic());
			price_question += Double.parseDouble(mimemberVO.getPrice_question());
			price_receipt += Double.parseDouble(mimemberVO.getPrice_receipt());
			sum_hap += Double.parseDouble(mimemberVO.getSum_hap());
			
			}
			
			LogMember2VO mimember2SumNscVO = new LogMember2VO();
			mimember2SumNscVO.setName("미수금 합계");
			mimember2SumNscVO.setPrice_assess(""+format2.format(price_assess));
			mimember2SumNscVO.setPrice_time(""+format2.format(price_time));
			mimember2SumNscVO.setPrice_traffic(""+format2.format(price_traffic));
			mimember2SumNscVO.setPrice_question(""+format2.format(price_question));
			mimember2SumNscVO.setPrice_receipt(""+format2.format(price_receipt));	
			mimember2SumNscVO.setSum_hap(""+format2.format(sum_hap));
			
			
			//적부
			if(idmemberListContract.size() != 0)
			{
				for(int i = 0; i < idmemberListContract.size(); i++)
				{
					LogMember2VO imemberVO = idmemberListContract.get(i);

					if(imemberVO.getGubun().equals("1")){
						myself++;
					}else{
						together++;
					}
					report_id += (imemberVO.getReport_id());
					price_assess += Integer.parseInt(imemberVO.getPrice_assess());
					price_time += Integer.parseInt(imemberVO.getPrice_time());
					report_ea += Double.parseDouble(imemberVO.getReport_ea());
					p_price_mi_a += Double.parseDouble(imemberVO.getP_price_mi_a()); 
					p_price_mi_b += Double.parseDouble(imemberVO.getP_price_mi_b());
					report_ea_mi += Double.parseDouble(imemberVO.getReport_ea_mi());
					p_price_pl_a += Double.parseDouble(imemberVO.getP_price_pl_a());
					p_price_pl_b += Double.parseDouble(imemberVO.getP_price_pl_b());
					report_ea_pl += Double.parseDouble(imemberVO.getReport_ea_pl());
					sum_little += Double.parseDouble(imemberVO.getSum_little());
					price_traffic += Integer.parseInt(imemberVO.getPrice_traffic());
					price_question += Integer.parseInt(imemberVO.getPrice_question());
					price_receipt += Integer.parseInt(imemberVO.getPrice_receipt());
					sum_hap += Double.parseDouble(imemberVO.getSum_hap());
				}//end of for
			}//end of if
			
			LogMember2VO member2SumContractVO = new LogMember2VO();
			member2SumContractVO.setName("합 계");
			member2SumContractVO.setPrice_assess(""+format2.format(price_assess));
			member2SumContractVO.setPrice_time(""+format2.format(price_time));
			member2SumContractVO.setReport_ea(""+format2.format(report_ea));
			member2SumContractVO.setP_price_mi_a(""+format2.format(p_price_mi_a));
			member2SumContractVO.setP_price_mi_b(""+format2.format(p_price_mi_b));
			member2SumContractVO.setReport_ea_mi(""+format2.format(report_ea_mi));
			member2SumContractVO.setP_price_pl_a(""+format2.format(p_price_pl_a));
			member2SumContractVO.setP_price_pl_b(""+format2.format(p_price_pl_b));
			member2SumContractVO.setReport_ea_pl(""+format2.format(report_ea_pl));
			member2SumContractVO.setSum_little(""+format2.format(sum_little));
			member2SumContractVO.setPrice_traffic(""+format2.format(price_traffic));
			member2SumContractVO.setPrice_question(""+format2.format(price_question));
			member2SumContractVO.setPrice_receipt(""+format2.format(price_receipt));
			member2SumContractVO.setSum_hap(""+format2.format(sum_hap));
			
			//미수금내역 조회 Start
			List<LogMember2VO> mimemberListContract = new ArrayList<LogMember2VO>();
			mimemberListContract = sqlSession.selectList("LogMember2Mapper.mimember", map);
			//미수금내역 조회 End
			for(int i = 0; i < mimemberListContract.size(); i++)
			{
				LogMember2VO mimemberVO = mimemberListContract.get(i);
			ig_nick += (mimemberVO.getIg_nick());
			report_id += (mimemberVO.getReport_id());
			ig_client += (mimemberVO.getIg_client());
			ig_insured += (mimemberVO.getIg_insured()); 
			end_date += Double.parseDouble(mimemberVO.getEnd_date());
			price_assess += Double.parseDouble(mimemberVO.getPrice_assess());
			price_time += Double.parseDouble(mimemberVO.getPrice_time());
			price_traffic += Double.parseDouble(mimemberVO.getPrice_traffic());
			price_question += Double.parseDouble(mimemberVO.getPrice_question());
			price_receipt += Double.parseDouble(mimemberVO.getPrice_receipt());
			sum_hap += Double.parseDouble(mimemberVO.getSum_hap());
			
			}
			
			LogMember2VO mimember2SumContractVO = new LogMember2VO();
			mimember2SumContractVO.setName("미수금 합계");
			mimember2SumContractVO.setPrice_assess(""+format2.format(price_assess));
			mimember2SumContractVO.setPrice_time(""+format2.format(price_time));
			mimember2SumContractVO.setPrice_traffic(""+format2.format(price_traffic));
			mimember2SumContractVO.setPrice_question(""+format2.format(price_question));
			mimember2SumContractVO.setPrice_receipt(""+format2.format(price_receipt));	
			mimember2SumContractVO.setSum_hap(""+format2.format(sum_hap));
			
			
			
			model.addAttribute("summimember2", mimember2SumVO);
			model.addAttribute("summember2", member2SumVO);
			model.addAttribute("summimember2Nsc", mimember2SumNscVO);
			model.addAttribute("summember2Nsc", member2SumNscVO);
			model.addAttribute("summimember2Contract", mimember2SumContractVO);
			model.addAttribute("summember2Contract", member2SumContractVO);
			model.addAttribute("mimemberList", mimemberList);
			model.addAttribute("mimemberListNsc", mimemberListNsc);
			model.addAttribute("mimemberListContract", mimemberListContract);
			model.addAttribute("myself", myself);
			model.addAttribute("together", together);
			model.addAttribute("idmemberListBase", idmemberListBase);
			model.addAttribute("idmemberListNsc", idmemberListNsc);
			model.addAttribute("idmemberListContract", idmemberListContract);
			model.addAttribute("pgid", "log_member2_main");
			
			return "ls_log/log_index";
		}
	
	}
