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
public class ResultTeamController {
	
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
	@RequestMapping(value = "/result_team", method = RequestMethod.GET)
	public String resultTeam(Model model, HttpServletRequest request, ResultTeamViewVO vo2) {
		String viewName = resultTeamPost(model, request, vo2);
		return viewName;
	}

	@RequestMapping(value = "/result_team", method = RequestMethod.POST)
	public String resultTeamPost(Model model, HttpServletRequest request, ResultTeamViewVO vo2) {
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
		List<ResultTeamVO> ReusltTList4 = new ArrayList<ResultTeamVO>();
		ReusltTList4 = sqlSession.selectList("ResultTeamMapper.selkindT4");
		//4종 팀 조회 End
		
		List<ResultTeamVO> RT4List = new ArrayList<ResultTeamVO>();
		int intForkind4 = 0;
		
		for(int i = 0; i < ReusltTList4.size(); i++, intForkind4++){
			ResultTeamVO ResultT4VO = ReusltTList4.get(i);
			String tmpTI = ResultT4VO.getTeam_id();
			
			map.put("tmpTI", tmpTI);

			//4종 log 조회 Start
			ResultTeamVO Result4List = sqlSession.selectOne("ResultTeamMapper.result4list", map);
			//4종 log 조회 End
			Result4List.setTeam_id(ResultT4VO.getTeam_id());
			Result4List.setTeam_name(ResultT4VO.getTeam_name());
			k4s_report_result1 += Integer.parseInt(Result4List.getReport_result1());
			k4s_report_result2 += Integer.parseInt(Result4List.getReport_result2());
			k4s_report_result3 += Integer.parseInt(Result4List.getReport_result3());
			k4s_report_result4 += Integer.parseInt(Result4List.getReport_result4());
			k4s_report_result5 += Integer.parseInt(Result4List.getReport_result5());
			k4s_report_result6 += Integer.parseInt(Result4List.getReport_result6());
			k4s_report_result7 += Integer.parseInt(Result4List.getReport_result7());
			k4s_report_result8 += Integer.parseInt(Result4List.getReport_result8());
			k4s_report_result9 += Integer.parseInt(Result4List.getReport_result9());
			k4s_report_result_sum += Integer.parseInt(Result4List.getReport_result_sum());
			
			RT4List.add(Result4List);
		}
		
		
		ResultTeamVO ResultTeamSumVO = new ResultTeamVO();
		ResultTeamSumVO.setSum_report_result1(""+(k4s_report_result1));
		ResultTeamSumVO.setSum_report_result2(""+(k4s_report_result2));
		ResultTeamSumVO.setSum_report_result3(""+(k4s_report_result3));
		ResultTeamSumVO.setSum_report_result4(""+(k4s_report_result4));
		ResultTeamSumVO.setSum_report_result5(""+(k4s_report_result5));
		ResultTeamSumVO.setSum_report_result6(""+(k4s_report_result6));
		ResultTeamSumVO.setSum_report_result7(""+(k4s_report_result7));
		ResultTeamSumVO.setSum_report_result8(""+(k4s_report_result8));
		ResultTeamSumVO.setSum_report_result9(""+(k4s_report_result9));
		ResultTeamSumVO.setSum_report_result_sum(""+(k4s_report_result_sum));
		
		model.addAttribute("ResultTeamSumVO", ResultTeamSumVO);
		model.addAttribute("ReusltTList4", ReusltTList4);
		model.addAttribute("RT4List", RT4List);
		model.addAttribute("pgid", "result_team");

		return "ls_log/log_index";
	}
	
	@RequestMapping(value = "/result_team_excel", method = RequestMethod.POST)
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
