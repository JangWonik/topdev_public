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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

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
public class LogTeamController {
	
	private static final Logger logger = LoggerFactory.getLogger(LogTeamController.class);

	@Autowired
	private SqlSession sqlSession;


	@RequestMapping(value = "/log_team", method = RequestMethod.GET)
	public String logTeam(Model model, HttpServletRequest request, LogTeamViewVO vo2) {
		String viewName = logTeamPost(model, request, vo2);
		return viewName;
	}

	@RequestMapping(value = "/log_team", method = RequestMethod.POST)
	public String logTeamPost(Model model, HttpServletRequest request, LogTeamViewVO vo2) {
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
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fromdate", fromdate);
		map.put("todate", todate);
		map.put("fromYear", fromYear);
		map.put("toYear", toYear);

		//화면에서 오는 구분값 받기 start
		String typeF = vo2.getTypeF();
		String baseF = vo2.getBaseF();
		String nscF = vo2.getNscF();
		String contractF = vo2.getContractF();
		String selectKind = vo2.getSelectKind();
		if(typeF == null) {
			typeF = "all";
			baseF = "on";
			//map.put("baseF", baseF);
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
		//화면에서 오는 구분값 받기 end

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
		model.addAttribute("selectKind", selectKind);
		
		List<LogTeamVO> kind1List = null;
		int kind1HapNo = 0;
		if(typeF.equals("1") || typeF.equals("all")) {
			kind1List = kind1Select(map);
			kind1HapNo = kind1List.size()-1;
			model.addAttribute("kind1List", kind1List);
		}//if(1종 조회)
		
		List<LogTeamVO> kind4List = null;
		int kind4HapNo = 0;
		if(typeF.equals("4") || typeF.equals("all")) {
			kind4List = kind4Select(map);
			kind4HapNo = kind4List.size()-1;	
			model.addAttribute("kind4List", kind4List);
		}//if(4종 조회)
		
		DecimalFormat format1 = new DecimalFormat("###,##0.##");
		DecimalFormat format2 = new DecimalFormat("#,###");	
		LogTeamVO kind14SumVO = new LogTeamVO();
		LogTeamVO zeroVO = new LogTeamVO();
		zeroVO.setReg_m("0");
		zeroVO.setReg_y("0");
		zeroVO.setEnd_m("0");
		zeroVO.setEnd_y("0");
		zeroVO.setProc_m("0");
		zeroVO.setProc_y("0");
		zeroVO.setNend_p("0");
		zeroVO.setNend_30r("0");
		zeroVO.setEndea_m("0");
		zeroVO.setEndea_y("0");
		zeroVO.setPrice_assess("0");
		zeroVO.setPrice_time("0");
		zeroVO.setPrice_sum1("0");
		zeroVO.setPrice_traffic("0");
		zeroVO.setPrice_question("0");
		zeroVO.setPrice_receipt("0");
		zeroVO.setPrice_sum2("0");
		zeroVO.setPrice_total("0");
		if(kind1List == null){
			kind1List = new ArrayList<LogTeamVO>();
			kind1List.add(zeroVO);
		}
		if(kind4List == null){
			kind4List = new ArrayList<LogTeamVO>();
			kind4List.add(zeroVO);
		}
		kind14SumVO.setSum_reg_m(""+(Integer.parseInt(kind1List.get(kind1HapNo).getReg_m())+Integer.parseInt(kind4List.get(kind4HapNo).getReg_m())));
		kind14SumVO.setSum_reg_y(""+(Integer.parseInt(kind1List.get(kind1HapNo).getReg_y())+Integer.parseInt(kind4List.get(kind4HapNo).getReg_y())));
		kind14SumVO.setSum_end_m(""+(Integer.parseInt(kind1List.get(kind1HapNo).getEnd_m())+Integer.parseInt(kind4List.get(kind4HapNo).getEnd_m())));
		kind14SumVO.setSum_end_y(""+(Integer.parseInt(kind1List.get(kind1HapNo).getEnd_y())+Integer.parseInt(kind4List.get(kind4HapNo).getEnd_y())));
		kind14SumVO.setSum_proc_m(""+(Double.parseDouble(kind1List.get(kind1HapNo).getProc_m())+Double.parseDouble(kind4List.get(kind4HapNo).getProc_m()))/2);
		kind14SumVO.setSum_proc_y(""+(Double.parseDouble(kind1List.get(kind1HapNo).getProc_y())+Double.parseDouble(kind4List.get(kind4HapNo).getProc_y()))/2);
		kind14SumVO.setSum_nend_p(""+(Integer.parseInt(kind1List.get(kind1HapNo).getNend_p())+Integer.parseInt(kind4List.get(kind4HapNo).getNend_p())));
		kind14SumVO.setSum_nend_30r(""+((Double.parseDouble(kind1List.get(kind1HapNo).getNend_30r())+Double.parseDouble(kind4List.get(kind4HapNo).getNend_30r())))/2);
		kind14SumVO.setSum_endea_m(""+(Double.parseDouble(kind1List.get(kind1HapNo).getEndea_m())+Double.parseDouble(kind4List.get(kind4HapNo).getEndea_m())));
		kind14SumVO.setSum_endea_y(""+(Double.parseDouble(kind1List.get(kind1HapNo).getEndea_y())+Double.parseDouble(kind4List.get(kind4HapNo).getEndea_y())));
		kind14SumVO.setSum_price_assess(""+(Integer.parseInt(kind1List.get(kind1HapNo).getPrice_assess())+Integer.parseInt(kind4List.get(kind4HapNo).getPrice_assess())));
		kind14SumVO.setSum_price_time(""+(Integer.parseInt(kind1List.get(kind1HapNo).getPrice_time())+Integer.parseInt(kind4List.get(kind4HapNo).getPrice_time())));
		kind14SumVO.setSum_price_sum1(""+(Integer.parseInt(kind1List.get(kind1HapNo).getPrice_sum1())+Integer.parseInt(kind4List.get(kind4HapNo).getPrice_sum1())));
		kind14SumVO.setSum_price_traffic(""+(Integer.parseInt(kind1List.get(kind1HapNo).getPrice_traffic())+Integer.parseInt(kind4List.get(kind4HapNo).getPrice_traffic())));
		kind14SumVO.setSum_price_question(""+(Integer.parseInt(kind1List.get(kind1HapNo).getPrice_question())+Integer.parseInt(kind4List.get(kind4HapNo).getPrice_question())));
		kind14SumVO.setSum_price_receipt(""+(Integer.parseInt(kind1List.get(kind1HapNo).getPrice_receipt())+Integer.parseInt(kind4List.get(kind4HapNo).getPrice_receipt())));
		kind14SumVO.setSum_price_sum2(""+(Integer.parseInt(kind1List.get(kind1HapNo).getPrice_sum2())+Integer.parseInt(kind4List.get(kind4HapNo).getPrice_sum2())));
		kind14SumVO.setSum_price_total(""+(Integer.parseInt(kind1List.get(kind1HapNo).getPrice_total())+Integer.parseInt(kind4List.get(kind4HapNo).getPrice_total())));

		model.addAttribute("sumobj", kind14SumVO);
		
		model.addAttribute("pgid", "log_team");

		return "ls_log/log_index";
	}

	public List<LogTeamVO> kind1Select(HashMap<String, String> map){
		//1종 팀 조회 Start
		List<LogTeamVO> teamList = sqlSession.selectList("LogTeamMapper.teamskind1");
		//1종 팀 조회 End

		//1종 소계 변수 선언 시작
		int k1s_reg_m = 0;
		int k1s_reg_y = 0;
		int k1s_end_m = 0;
		int k1s_end_y = 0;
		double k1s_proc_m = 0;
		double k1s_proc_y = 0;
		int k1s_nend_p = 0;
		double k1s_nend_30r = 0;
		double k1s_endea_m = 0;
		double k1s_endea_y = 0;
		int k1s_price_assess = 0;
		int k1s_price_time = 0;
		int k1s_price_sum1 = 0;
		int k1s_price_traffic = 0;
		int k1s_price_question = 0;
		int k1s_price_receipt = 0;
		int k1s_price_sum2 = 0;
		int k1s_price_total = 0;
		//1종 소계 변수 선언 종료

		List<LogTeamVO> kind1List = new ArrayList<LogTeamVO>();
		int intForkind1 = 0;

		for(int i = 0; i < teamList.size(); i++, intForkind1++){
			LogTeamVO team1VO = teamList.get(i);
			String tmpStr = team1VO.getTeam_id();
			map.put("tmpStr", tmpStr);

			//1종 log 조회 Start
			LogTeamVO log1List = sqlSession.selectOne("LogTeamMapper.logkind1", map);
			//1종 log 조회 End

			log1List.setTeam_id(team1VO.getTeam_id());
			log1List.setTeam_name(team1VO.getTeam_name());
			k1s_reg_m += Integer.parseInt(log1List.getReg_m());
			k1s_reg_y += Integer.parseInt(log1List.getReg_y());
			k1s_end_m += Integer.parseInt(log1List.getEnd_m());
			k1s_end_y += Integer.parseInt(log1List.getEnd_y());
			k1s_proc_m += Double.parseDouble(log1List.getProc_m());
			k1s_proc_y += Double.parseDouble(log1List.getProc_y());
			k1s_nend_p += Integer.parseInt(log1List.getNend_p());
			k1s_nend_30r += Double.parseDouble(log1List.getNend_30r());
			k1s_endea_m += Double.parseDouble(log1List.getEndea_m());
			k1s_endea_y += Double.parseDouble(log1List.getEndea_y());
			k1s_price_assess += Integer.parseInt(log1List.getPrice_assess());
			k1s_price_time += Integer.parseInt(log1List.getPrice_time());
			k1s_price_sum1 += Integer.parseInt(log1List.getPrice_sum1());
			k1s_price_traffic += Integer.parseInt(log1List.getPrice_traffic());
			k1s_price_question += Integer.parseInt(log1List.getPrice_question());
			k1s_price_receipt += Integer.parseInt(log1List.getPrice_receipt());
			k1s_price_sum2 += Integer.parseInt(log1List.getPrice_sum2());
			k1s_price_total += Integer.parseInt(log1List.getPrice_total());
			kind1List.add(log1List);
		}
		DecimalFormat format1 = new DecimalFormat("###,##0.##");
		DecimalFormat format2 = new DecimalFormat("#,###");
		
		LogTeamVO kind1SumVO = new LogTeamVO();
		kind1SumVO.setTeam_name("소계");
		kind1SumVO.setReg_m(""+k1s_reg_m);
		kind1SumVO.setReg_y(""+k1s_reg_y);
		kind1SumVO.setEnd_m(""+k1s_end_m);
		kind1SumVO.setEnd_y(""+k1s_end_y);
		kind1SumVO.setProc_m(""+(k1s_proc_m/intForkind1));
		kind1SumVO.setProc_y(""+(k1s_proc_y/intForkind1));
		kind1SumVO.setNend_p(""+k1s_nend_p);
		kind1SumVO.setNend_30r(""+(k1s_nend_30r/intForkind1));
		kind1SumVO.setEndea_m(""+(k1s_endea_m));
		kind1SumVO.setEndea_y(""+(k1s_endea_y));
		kind1SumVO.setPrice_assess(""+(k1s_price_assess));
		kind1SumVO.setPrice_time(""+(k1s_price_time));
		kind1SumVO.setPrice_sum1(""+(k1s_price_sum1));
		kind1SumVO.setPrice_traffic(""+(k1s_price_traffic));
		kind1SumVO.setPrice_question(""+(k1s_price_question));
		kind1SumVO.setPrice_receipt(""+(k1s_price_receipt));
		kind1SumVO.setPrice_sum2(""+(k1s_price_sum2));
		kind1SumVO.setPrice_total(""+(k1s_price_total));
		kind1List.add(kind1SumVO);

		return kind1List;
	}//kind1Select
	
	public List<LogTeamVO> kind4Select(HashMap<String, String> map){
	
		//4종 팀 조회 Start
				List<LogTeamVO> teamList4 = sqlSession.selectList("LogTeamMapper.teamskind4");
				//4종 팀 조회 End

				//4종 소계 변수 선언 시작
				int k4s_reg_m = 0;
				int k4s_reg_y = 0;
				int k4s_end_m = 0;
				int k4s_end_y = 0;
				double k4s_proc_m = 0;
				double k4s_proc_y = 0;
				int k4s_nend_p = 0;
				double k4s_nend_30r = 0;
				double k4s_endea_m = 0;
				double k4s_endea_y = 0;
				int k4s_price_assess = 0;
				int k4s_price_time = 0;
				int k4s_price_sum1 = 0;
				int k4s_price_traffic = 0;
				int k4s_price_question = 0;
				int k4s_price_receipt = 0;
				int k4s_price_sum2 = 0;
				int k4s_price_total = 0;

				List<LogTeamVO> kind4List = new ArrayList<LogTeamVO>();
				int intForkind4 = 0;
				for(int i = 0; i < teamList4.size(); i++, intForkind4++){
					LogTeamVO team4VO = teamList4.get(i);
					String tmpStr2 = team4VO.getTeam_id();
					map.put("tmpStr2", tmpStr2);

					//4종 log 조회 Start
					LogTeamVO log4List = sqlSession.selectOne("LogTeamMapper.logkind4", map);
					//4종 log 조회 End
					log4List.setTeam_name(team4VO.getTeam_name());
					log4List.setTeam_id(team4VO.getTeam_id());
					k4s_reg_m += Integer.parseInt(log4List.getReg_m());
					k4s_reg_y += Integer.parseInt(log4List.getReg_y());
					k4s_end_m += Integer.parseInt(log4List.getEnd_m());
					k4s_end_y += Integer.parseInt(log4List.getEnd_y());
					k4s_proc_m += Double.parseDouble(log4List.getProc_m());
					k4s_proc_y += Double.parseDouble(log4List.getProc_y());
					k4s_nend_p += Integer.parseInt(log4List.getNend_p());
					k4s_nend_30r += Double.parseDouble(log4List.getNend_30r());
					k4s_endea_m += Double.parseDouble(log4List.getEndea_m());
					k4s_endea_y += Double.parseDouble(log4List.getEndea_y());
					k4s_price_assess += Integer.parseInt(log4List.getPrice_assess());
					k4s_price_time += Integer.parseInt(log4List.getPrice_time());
					k4s_price_sum1 += Integer.parseInt(log4List.getPrice_sum1());
					k4s_price_traffic += Integer.parseInt(log4List.getPrice_traffic());
					k4s_price_question += Integer.parseInt(log4List.getPrice_question());
					k4s_price_receipt += Integer.parseInt(log4List.getPrice_receipt());
					k4s_price_sum2 += Integer.parseInt(log4List.getPrice_sum2());
					k4s_price_total += Integer.parseInt(log4List.getPrice_total());
					kind4List.add(log4List);
				}
				
				DecimalFormat format1 = new DecimalFormat("###,##0.##");
				DecimalFormat format2 = new DecimalFormat("#,###");
				LogTeamVO kind4SumVO = new LogTeamVO();
				kind4SumVO.setTeam_name("소계");
				kind4SumVO.setReg_m(""+k4s_reg_m);
				kind4SumVO.setReg_y(""+k4s_reg_y);
				kind4SumVO.setEnd_m(""+k4s_end_m);
				kind4SumVO.setEnd_y(""+k4s_end_y);
				kind4SumVO.setProc_m(""+(k4s_proc_m/intForkind4));
				kind4SumVO.setProc_y(""+(k4s_proc_y/intForkind4));
				kind4SumVO.setNend_p(""+k4s_nend_p);
				kind4SumVO.setNend_30r(""+(k4s_nend_30r/intForkind4));
				kind4SumVO.setEndea_m(""+(k4s_endea_m));
				kind4SumVO.setEndea_y(""+(k4s_endea_y));
				kind4SumVO.setPrice_assess(""+(k4s_price_assess));
				kind4SumVO.setPrice_time(""+(k4s_price_time));
				kind4SumVO.setPrice_sum1(""+(k4s_price_sum1));
				kind4SumVO.setPrice_traffic(""+(k4s_price_traffic));
				kind4SumVO.setPrice_question(""+(k4s_price_question));
				kind4SumVO.setPrice_receipt(""+(k4s_price_receipt));
				kind4SumVO.setPrice_sum2(""+(k4s_price_sum2));
				kind4SumVO.setPrice_total(""+(k4s_price_total));
				kind4List.add(kind4SumVO);
	return kind4List;
				
	}//kind4Select

	@RequestMapping(value = "/log_team_excel", method = RequestMethod.POST)
	public void logTeamExcel(Model model, HttpServletRequest request, HttpServletResponse response, String hidtab) {
		//String nowDate=DateUtil.getDate("yyyyMMddHHmmss");

		
		response.reset();
		//response.setCharacterEncoding("euc-kr");
		response.setContentType("application/vnd.ms-excel; charset=UTF-8");
		response.setHeader("Content-Disposition","attachment;filename=log_team_excel_.xls");
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
	
}//class
