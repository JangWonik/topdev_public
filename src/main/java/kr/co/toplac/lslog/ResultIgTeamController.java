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
public class ResultIgTeamController {
	
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
	@RequestMapping(value = "/result_ig_team", method = RequestMethod.GET)
	public String resultIgTeam(Model model, HttpServletRequest request, ResultIgTeamViewVO vo2, String team_id, String team_name, String ig_id, String ig_nick) {
		String viewName = resultIgTeamPost(model, request, vo2, team_id, team_name, ig_id, ig_nick);
		return viewName;
	}

	@RequestMapping(value = "/result_ig_team", method = RequestMethod.POST)
	public String resultIgTeamPost(Model model, HttpServletRequest request, ResultIgTeamViewVO vo2, String team_id, String team_name, String ig_id, String ig_nick) {
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
		int regmonth = Integer.parseInt(todate.substring(5, 7));
		model.addAttribute("regmonth", regmonth);
		
		//날짜만들기 종료
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fromdate", fromdate);
		map.put("todate", todate);
		map.put("fromYear", fromYear);
		map.put("toYear", toYear);
		map.put("team_name", team_name);
		map.put("team_id", team_id);
		map.put("ig_id", ig_id);
		map.put("ig_nick", ig_nick);
		
		model.addAttribute("fromdate", fromdate);
		model.addAttribute("todate", todate);
		model.addAttribute("fromYear", fromYear);
		model.addAttribute("toYear", toYear);
		model.addAttribute("toAccumYear", toAccumYear);
		model.addAttribute("toMonthInt", todate.substring(5, 7));
		model.addAttribute("team_name", team_name);
		model.addAttribute("team_id", team_id);
		model.addAttribute("ig_id", ig_id);
		model.addAttribute("ig_nick", ig_nick);
		


		//4종 소계 변수 선언 시작
		int k4s_report_result1 = 0;
		int k4s_report_result2 = 0;
		int k4s_report_result3 = 0;
		int k4s_report_result4 = 0;
		int k4s_report_result5 = 0;
		int k4s_report_result6 = 0;
		int k4s_report_result7 = 0;
		int k4s_report_result8 = 0;
		int k4s_report_result9 = 0;
		int k4s_report_result_sum = 0;
		
		//4종 팀 조회 Start
				List<ResultIgTeamVO> ReusltIgTList4 = new ArrayList<ResultIgTeamVO>();
				ReusltIgTList4 = sqlSession.selectList("ResultIgTeamMapper.sel_Ig_Tkind4");
				//4종 팀 조회 End
				
				List<ResultIgTeamVO> R_Ig_T4List = new ArrayList<ResultIgTeamVO>();
				int intForkind4 = 0;
				
				for(int i = 0; i < ReusltIgTList4.size(); i++, intForkind4++){
					ResultIgTeamVO Result_Ig_T4VO = ReusltIgTList4.get(i);
					String tmpTi = Result_Ig_T4VO.getTeam_id();
					
					map.put("tmpTi", tmpTi);

					//4종 log 조회 Start
					ResultIgTeamVO Result_Ig_T4List = sqlSession.selectOne("ResultIgTeamMapper.Result_Ig_T4List", map);
					//4종 log 조회 End
					Result_Ig_T4List.setIg_id(Result_Ig_T4VO.getIg_id());
					Result_Ig_T4List.setIg_nick(Result_Ig_T4VO.getIg_nick());
					Result_Ig_T4List.setTeam_id(Result_Ig_T4VO.getTeam_id());
					Result_Ig_T4List.setTeam_name(Result_Ig_T4VO.getTeam_name());
					k4s_report_result1 += Integer.parseInt(Result_Ig_T4List.getReport_result1());
					k4s_report_result2 += Integer.parseInt(Result_Ig_T4List.getReport_result2());
					k4s_report_result3 += Integer.parseInt(Result_Ig_T4List.getReport_result3());
					k4s_report_result4 += Integer.parseInt(Result_Ig_T4List.getReport_result4());
					k4s_report_result5 += Integer.parseInt(Result_Ig_T4List.getReport_result5());
					k4s_report_result6 += Integer.parseInt(Result_Ig_T4List.getReport_result6());
					k4s_report_result7 += Integer.parseInt(Result_Ig_T4List.getReport_result7());
					k4s_report_result8 += Integer.parseInt(Result_Ig_T4List.getReport_result8());
					k4s_report_result9 += Integer.parseInt(Result_Ig_T4List.getReport_result9());
					k4s_report_result_sum += Integer.parseInt(Result_Ig_T4List.getReport_result_sum());
					
					R_Ig_T4List.add(Result_Ig_T4List);
				}
				
				
				ResultIgTeamVO ResultIgSumVO = new ResultIgTeamVO();
				ResultIgSumVO.setSum_report_result1(""+(k4s_report_result1));
				ResultIgSumVO.setSum_report_result2(""+(k4s_report_result2));
				ResultIgSumVO.setSum_report_result3(""+(k4s_report_result3));
				ResultIgSumVO.setSum_report_result4(""+(k4s_report_result4));
				ResultIgSumVO.setSum_report_result5(""+(k4s_report_result5));
				ResultIgSumVO.setSum_report_result6(""+(k4s_report_result6));
				ResultIgSumVO.setSum_report_result7(""+(k4s_report_result7));
				ResultIgSumVO.setSum_report_result8(""+(k4s_report_result8));
				ResultIgSumVO.setSum_report_result9(""+(k4s_report_result9));
				ResultIgSumVO.setSum_report_result_sum(""+(k4s_report_result_sum));
				
				model.addAttribute("ResultIgSumVO", ResultIgSumVO);
				model.addAttribute("ReusltIgTList4", ReusltIgTList4);
				model.addAttribute("R_Ig_T4List", R_Ig_T4List);
				model.addAttribute("pgid", "result_ig_team");

		return "ls_log/log_index";
	}
	
	@RequestMapping(value = "/result_ig_team_excel", method = RequestMethod.POST)
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
