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
public class SaveLogController {
	
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
	@RequestMapping(value = "/save_log", method = RequestMethod.GET)
	public String saveLog(Model model, HttpServletRequest request, SaveLogVO vo2, String team_id, String team_name) {
		String viewName = saveLogPost(model, request, vo2, team_id, team_name);
		return viewName;
	}

	@RequestMapping(value = "/save_log", method = RequestMethod.POST)
	public String saveLogPost(Model model, HttpServletRequest request, SaveLogVO vo2, String team_id, String team_name) {
		//날짜만들기 시작
		/*String fromdate = vo2.getViewFromDate();
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
		int regmonth = Integer.parseInt(todate.substring(5, 7));
		model.addAttribute("regmonth", regmonth); */		
		
		//날짜만들기 종료
		HashMap<String, String> map = new HashMap<String, String>();
		
		//map.put("fromdate", fromdate);
		//map.put("todate", todate);
		//map.put("fromYear", fromYear);
		//map.put("toYear", toYear);
		map.put("team_name", team_name);
		map.put("team_id", team_id);
		
		
		/*model.addAttribute("fromdate", fromdate);
		model.addAttribute("todate", todate);
		model.addAttribute("fromYear", fromYear);
		model.addAttribute("toYear", toYear);
		model.addAttribute("toAccumYear", toAccumYear);
		model.addAttribute("toMonthInt", todate.substring(5, 7));*/
		model.addAttribute("team_name", team_name);
		model.addAttribute("team_id", team_id);
		


		//해당 년,월 소계 변수 선언 시작
		String log_year = "";
		String log_month = "";
		
		//4종 팀 조회 Start
		List<SaveLogVO> Log_Result = new ArrayList<SaveLogVO>();
		Log_Result = sqlSession.selectList("SaveLogMapper.sel_log", map);
		//4종 팀 조회 End
		
		List<SaveLogVO> Log_List = new ArrayList<SaveLogVO>();
		
		for(int i = 0; i < Log_Result.size(); i++){
			SaveLogVO Log_ListVO = Log_Result.get(i);
			//String tmpUI = ResultM4VO.getUser_id();
			
			//map.put("tmpUI", tmpUI);
			/*Log_Result.setNo(Log_ListVO.getNo());
			Log_Result.setYear(Log_ListVO.getYear());
			Log_Result.setMonth(Log_ListVO.getMonth());*/
			String no = Log_ListVO.getNo();
			String year = Log_ListVO.getYear();
			String month = Log_ListVO.getMonth();
			
			

			//4종 log 조회 Start
			//ResultMemberVO ResultM4List = sqlSession.selectOne("ResultMemberMapper.resultM4list", map);
			//4종 log 조회 End
			/*ResultM4List.setName(ResultM4VO.getName());
			ResultM4List.setUser_id(ResultM4VO.getUser_id());
			ResultM4List.setTeam_id(ResultM4VO.getTeam_id());
			ResultM4List.setTeam_name(ResultM4VO.getTeam_name());
			k4s_report_result1 += Integer.parseInt(ResultM4List.getReport_result1());
			k4s_report_result2 += Integer.parseInt(ResultM4List.getReport_result2());
			k4s_report_result3 += Integer.parseInt(ResultM4List.getReport_result3());
			k4s_report_result4 += Integer.parseInt(ResultM4List.getReport_result4());
			k4s_report_result5 += Integer.parseInt(ResultM4List.getReport_result5());
			k4s_report_result6 += Integer.parseInt(ResultM4List.getReport_result6());
			k4s_report_result7 += Integer.parseInt(ResultM4List.getReport_result7());
			k4s_report_result8 += Integer.parseInt(ResultM4List.getReport_result8());
			k4s_report_result9 += Integer.parseInt(ResultM4List.getReport_result9());
			k4s_report_result_sum += Integer.parseInt(ResultM4List.getReport_result_sum());
			
			RM4List.add(ResultM4List);*/
		}
		
		
		model.addAttribute("Log_Result", Log_Result);
		//model.addAttribute("RM4List", RM4List);
		model.addAttribute("pgid", "save_log");

		return "ls_log/log_index";
	}
	
	/*@RequestMapping(value = "/result_member_excel", method = RequestMethod.POST)
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
	}*/

}
