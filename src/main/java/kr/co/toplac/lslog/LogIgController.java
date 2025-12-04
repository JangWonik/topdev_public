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
public class LogIgController {
	
	private static final Logger logger = LoggerFactory.getLogger(LogIgController.class);

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
	@RequestMapping(value = "/log_ig", method = RequestMethod.GET)
	public String logIg(Model model, HttpServletRequest request, LogIgViewVO vo2, String ig_id) {
		String viewName = logIgPost(model, request, vo2);
		return viewName;
	}

	@RequestMapping(value = "/log_ig", method = RequestMethod.POST)
	public String logIgPost(Model model, HttpServletRequest request, LogIgViewVO vo2) {
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
		
		model.addAttribute("fromdate", fromdate);
		model.addAttribute("todate", todate);
		model.addAttribute("fromYear", fromYear);
		model.addAttribute("toYear", toYear);
		model.addAttribute("toAccumYear", toAccumYear);
		model.addAttribute("toMonthInt", todate.substring(5, 7));
		
		int report_type = 0;
		int gubun = 0;
		
		List<LogIgVO> gubunList = sqlSession.selectList("LogIgMapper.gubunkind");
		
		
		
		

		//1종 보험사 조회 Start
		List<LogIgVO> igList = sqlSession.selectList("LogIgMapper.igskind1");
		//1종 보험사 조회 End

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

		List<LogIgVO> kind1List = new ArrayList<LogIgVO>();
		int intForkind1 = 0;

		for(int i = 0; i < igList.size(); i++, intForkind1++){
			LogIgVO ig1VO = igList.get(i);
			String tmpStr = ig1VO.getIg_id();
			map.put("tmpStr", tmpStr);
			
			
			

			//1종 log 조회 Start
			LogIgVO log1List = sqlSession.selectOne("LogIgMapper.logkind1", map);
			//1종 log 조회 End
			
			log1List.setIg_id(ig1VO.getIg_id());
			log1List.setIg_nick(ig1VO.getIg_nick());
			k1s_reg_m += Integer.parseInt(log1List.getReg_m());
			k1s_reg_y += Integer.parseInt(log1List.getReg_y());
			k1s_end_m += Integer.parseInt(log1List.getEnd_m());
			k1s_end_y += Integer.parseInt(log1List.getEnd_y());			
			k1s_nend_p += Integer.parseInt(log1List.getNend_p());			
			k1s_endea_m += Double.parseDouble(log1List.getEndea_m());
			k1s_endea_y += Double.parseDouble(log1List.getEndea_y());
			k1s_price_assess += Integer.parseInt(log1List.getPrice_assess());
			k1s_price_time += Integer.parseInt(log1List.getPrice_time());
			k1s_price_sum1 += Integer.parseInt(log1List.getPrice_sum1());
			k1s_price_traffic += Integer.parseInt(log1List.getPrice_traffic());
			k1s_price_question += Integer.parseInt(log1List.getPrice_question());
			k1s_price_receipt += Integer.parseInt(log1List.getPrice_receipt());
			k1s_price_sum2 += Integer.parseInt(log1List.getPrice_sum2());
			//k1s_price_total += Integer.parseInt(log1List.getPrice_total());
			kind1List.add(log1List);
			
		}
		

		DecimalFormat format1 = new DecimalFormat("###,##0.##");
		DecimalFormat format2 = new DecimalFormat("#,###");
		
		LogIgVO kind1SumVO = new LogIgVO();
		kind1SumVO.setIg_nick("소계");
		kind1SumVO.setReg_m(""+k1s_reg_m);
		kind1SumVO.setReg_y(""+k1s_reg_y);
		kind1SumVO.setEnd_m(""+k1s_end_m);
		kind1SumVO.setEnd_y(""+k1s_end_y);
		kind1SumVO.setNend_p(""+k1s_nend_p);
		kind1SumVO.setEndea_m(""+format1.format(k1s_endea_m));
		kind1SumVO.setEndea_y(""+format1.format(k1s_endea_y));
		kind1SumVO.setPrice_assess(""+format2.format(k1s_price_assess));
		kind1SumVO.setPrice_time(""+format2.format(k1s_price_time));
		kind1SumVO.setPrice_sum1(""+format2.format(k1s_price_sum1));
		kind1SumVO.setPrice_traffic(""+format2.format(k1s_price_traffic));
		kind1SumVO.setPrice_question(""+format2.format(k1s_price_question));
		kind1SumVO.setPrice_receipt(""+format2.format(k1s_price_receipt));
		kind1SumVO.setPrice_sum2(""+format2.format(k1s_price_sum2));
		kind1List.add(kind1SumVO);

		model.addAttribute("kind1List", kind1List);
		

			//4종 보험사 조회 Start
			List<LogIgVO> ig4List = sqlSession.selectList("LogIgMapper.igskind4");
			//4종 보험사 조회 End

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
			
			//4종 소계 변수 선언 종료

			List<LogIgVO> kind4List = new ArrayList<LogIgVO>();
			//int intForkind4 = 0;

			for(int i = 0; i < ig4List.size(); i++){
				LogIgVO ig4VO = ig4List.get(i);
				String tmpStr2 = ig4VO.getIg_id();
				map.put("tmpStr2", tmpStr2);
				

				//4종 log 조회 Start
				LogIgVO log4List = sqlSession.selectOne("LogIgMapper.logkind4", map);
				//4종 log 조회 End

				log4List.setIg_id(ig4VO.getIg_id());
				log4List.setIg_nick(ig4VO.getIg_nick());
				k4s_reg_m += Integer.parseInt(log4List.getReg_m());
				k4s_reg_y += Integer.parseInt(log4List.getReg_y());
				k4s_end_m += Integer.parseInt(log4List.getEnd_m());
				k4s_end_y += Integer.parseInt(log4List.getEnd_y());			
				k4s_nend_p += Integer.parseInt(log4List.getNend_p());			
				k4s_endea_m += Double.parseDouble(log4List.getEndea_m());
				k4s_endea_y += Double.parseDouble(log4List.getEndea_y());
				k4s_price_assess += Integer.parseInt(log4List.getPrice_assess());
				k4s_price_time += Integer.parseInt(log4List.getPrice_time());
				k4s_price_sum1 += Integer.parseInt(log4List.getPrice_sum1());
				k4s_price_traffic += Integer.parseInt(log4List.getPrice_traffic());
				k4s_price_question += Integer.parseInt(log4List.getPrice_question());
				k4s_price_receipt += Integer.parseInt(log4List.getPrice_receipt());
				k4s_price_sum2 += Integer.parseInt(log4List.getPrice_sum2());
				kind4List.add(log4List);
			}
			
			
			LogIgVO kind4SumVO = new LogIgVO();
			kind4SumVO.setIg_nick("소계");
			kind4SumVO.setReg_m(""+k4s_reg_m);
			kind4SumVO.setReg_y(""+k4s_reg_y);
			kind4SumVO.setEnd_m(""+k4s_end_m);
			kind4SumVO.setEnd_y(""+k4s_end_y);		
			kind4SumVO.setNend_p(""+k4s_nend_p);		
			kind4SumVO.setEndea_m(""+format1.format(k4s_endea_m));
			kind4SumVO.setEndea_y(""+format1.format(k4s_endea_y));
			kind4SumVO.setPrice_assess(""+format2.format(k4s_price_assess));
			kind4SumVO.setPrice_time(""+format2.format(k4s_price_time));
			kind4SumVO.setPrice_sum1(""+format2.format(k4s_price_sum1));
			kind4SumVO.setPrice_traffic(""+format2.format(k4s_price_traffic));
			kind4SumVO.setPrice_question(""+format2.format(k4s_price_question));
			kind4SumVO.setPrice_receipt(""+format2.format(k4s_price_receipt));
			kind4SumVO.setPrice_sum2(""+format2.format(k4s_price_sum2));
			kind4List.add(kind4SumVO);
				
		LogIgVO kind14SumVO = new LogIgVO();
		kind14SumVO.setSum_reg_m(""+format2.format(k1s_reg_m+k4s_reg_m));
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
		kind14SumVO.setSum_price_sum2(""+format2.format(k1s_price_sum2+k4s_price_sum2));


	
		model.addAttribute("gubun", gubun);
		model.addAttribute("kind4List", kind4List);
		model.addAttribute("sumobj", kind14SumVO);
		model.addAttribute("pgid", "log_ig");

		return "ls_log/log_index";
	}
	
	@RequestMapping(value = "/log_ig_excel", method = RequestMethod.POST)
	public void logTeamExcel(Model model, HttpServletRequest request, HttpServletResponse response, String hidtab) {
		//String nowDate=DateUtil.getDate("yyyyMMddHHmmss");

		
		response.setCharacterEncoding("euc-kr");
		response.setHeader("Content-Disposition","attachment;filename=log_ig_excel_.xls");
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
