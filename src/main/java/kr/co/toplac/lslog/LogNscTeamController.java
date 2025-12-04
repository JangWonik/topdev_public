package kr.co.toplac.lslog;


import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
public class LogNscTeamController {
	
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
	@RequestMapping(value = "/log_nsc_team", method = RequestMethod.GET)
	public String logNscTeam(Model model, HttpServletRequest request, LogTeamViewVO vo2) {
		String viewName = logNscTeamPost(model, request, vo2);
		return viewName;
	}

	@RequestMapping(value = "/log_nsc_team", method = RequestMethod.POST)
	public String logNscTeamPost(Model model, HttpServletRequest request, LogTeamViewVO vo2) {
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

		//1종 팀 조회 Start
		List<LogNscTeamVO> nsc_teamList = sqlSession.selectList("LogNscTeamMapper.teamsnkind1");
		//1종 팀 조회 End

		//1종 소계 변수 선언 시작
		
		int k1s_nsc_price_assess = 0;
		int k1s_nsc_price_time = 0;
		int k1s_nsc_price_sum1 = 0;
		int k1s_nsc_price_traffic = 0;
		int k1s_nsc_price_question = 0;
		int k1s_nsc_price_receipt = 0;
		int k1s_nsc_price_sum2 = 0;
		int k1s_price_assess = 0;
		int k1s_price_time = 0;
		int k1s_price_sum1 = 0;
		int k1s_price_traffic = 0;
		int k1s_price_question = 0;
		int k1s_price_receipt = 0;
		int k1s_price_sum2 = 0;
		int k1s_nsc_price_total = 0;
		int k1s_price_total = 0;
		int k1s_unit_cn = 0;
		int myself = 0;
		int together = 0;
		
		//1종 소계 변수 선언 종료

		List<LogNscTeamVO> nkind1List = new ArrayList<LogNscTeamVO>();
		int intForkind1 = 0;

		for(int i = 0; i < nsc_teamList.size(); i++, intForkind1++){
			LogNscTeamVO nsc_team1VO = nsc_teamList.get(i);
			String tmpStr = nsc_team1VO.getTeam_id();
			map.put("tmpStr", tmpStr);
			

			/*if(nsc_team1VO.getGubun().equals("1")){
				myself++;
			}else{
				together++;
			}*/
			//1종 log 조회 Start
			LogNscTeamVO log1List = sqlSession.selectOne("LogNscTeamMapper.lognkind1", map);
			//1종 log 조회 End
			


			log1List.setTeam_id(nsc_team1VO.getTeam_id());
			log1List.setTeam_name(nsc_team1VO.getTeam_name());
			
			k1s_unit_cn += Integer.parseInt(log1List.getUnit_cn());
			k1s_nsc_price_assess += Integer.parseInt(log1List.getNsc_price_assess());
			k1s_nsc_price_time += Integer.parseInt(log1List.getNsc_price_time());
			k1s_nsc_price_sum1 += Integer.parseInt(log1List.getNsc_price_sum1());
			k1s_nsc_price_traffic += Integer.parseInt(log1List.getNsc_price_traffic());
			k1s_nsc_price_question += Integer.parseInt(log1List.getNsc_price_question());
			k1s_nsc_price_receipt += Integer.parseInt(log1List.getNsc_price_receipt());
			k1s_nsc_price_sum2 += Integer.parseInt(log1List.getNsc_price_sum2());
			k1s_nsc_price_total += Integer.parseInt(log1List.getNsc_price_total());
			k1s_price_assess += Integer.parseInt(log1List.getPrice_assess());
			k1s_price_time += Integer.parseInt(log1List.getPrice_time());
			k1s_price_sum1 += Integer.parseInt(log1List.getPrice_sum1());
			k1s_price_traffic += Integer.parseInt(log1List.getPrice_traffic());
			k1s_price_question += Integer.parseInt(log1List.getPrice_question());
			k1s_price_receipt += Integer.parseInt(log1List.getPrice_receipt());
			k1s_price_sum2 += Integer.parseInt(log1List.getPrice_sum2());
			k1s_price_total += Integer.parseInt(log1List.getPrice_total());
			
			nkind1List.add(log1List);
		}
		DecimalFormat format1 = new DecimalFormat("###,##0.##");
		DecimalFormat format2 = new DecimalFormat("#,###");
		
		LogNscTeamVO kind1SumVO = new LogNscTeamVO();
		kind1SumVO.setTeam_name("소계");
		kind1SumVO.setUnit_cn(""+format2.format(k1s_unit_cn));
		kind1SumVO.setNsc_price_assess(""+format2.format(k1s_nsc_price_assess));
		kind1SumVO.setNsc_price_time(""+format2.format(k1s_nsc_price_time));
		kind1SumVO.setNsc_price_sum1(""+format2.format(k1s_nsc_price_assess + k1s_nsc_price_time));
		kind1SumVO.setNsc_price_traffic(""+format2.format(k1s_nsc_price_traffic));
		kind1SumVO.setNsc_price_question(""+format2.format(k1s_nsc_price_question));
		kind1SumVO.setNsc_price_receipt(""+format2.format(k1s_nsc_price_receipt));
		kind1SumVO.setNsc_price_sum2(""+format2.format(k1s_nsc_price_assess + k1s_nsc_price_time + k1s_nsc_price_traffic + k1s_nsc_price_question + k1s_nsc_price_receipt));
		kind1SumVO.setNsc_price_total(""+format2.format(k1s_nsc_price_total));
		kind1SumVO.setPrice_assess(""+format2.format(k1s_price_assess + k1s_nsc_price_assess));
		kind1SumVO.setPrice_time(""+format2.format(k1s_price_time + k1s_nsc_price_time));
		kind1SumVO.setPrice_sum1(""+format2.format(k1s_price_assess + k1s_nsc_price_assess + k1s_price_time + k1s_nsc_price_time));
		kind1SumVO.setPrice_traffic(""+format2.format(k1s_price_traffic + k1s_nsc_price_traffic));
		kind1SumVO.setPrice_question(""+format2.format(k1s_price_question + k1s_nsc_price_question));
		kind1SumVO.setPrice_receipt(""+format2.format(k1s_price_receipt + k1s_nsc_price_receipt));
		kind1SumVO.setPrice_sum2(""+format2.format(k1s_price_assess + k1s_nsc_price_assess + k1s_price_time + k1s_nsc_price_time + k1s_price_traffic + k1s_nsc_price_traffic
				+ k1s_price_question + k1s_nsc_price_question + k1s_price_receipt + k1s_nsc_price_receipt));
		kind1SumVO.setPrice_total(""+format2.format(k1s_price_total));
		nkind1List.add(kind1SumVO); 

		model.addAttribute("nkind1List", nkind1List);

		//4종 팀 조회 Start
		List<LogNscTeamVO> teamList4 = sqlSession.selectList("LogNscTeamMapper.teamsnkind4");
		//4종 팀 조회 End

		//4종 소계 변수 선언 시작
		int k4s_nsc_price_assess = 0;
		int k4s_nsc_price_time = 0;
		int k4s_nsc_price_sum1 = 0;
		int k4s_nsc_price_traffic = 0;
		int k4s_nsc_price_question = 0;
		int k4s_nsc_price_receipt = 0;
		int k4s_nsc_price_sum2 = 0;
		int k4s_price_assess = 0;
		int k4s_price_time = 0;
		int k4s_price_sum1 = 0;
		int k4s_price_traffic = 0;
		int k4s_price_question = 0;
		int k4s_price_receipt = 0;
		int k4s_price_sum2 = 0;
		int k4s_unit_cn = 0;
		int k4s_nsc_price_total = 0;
		int k4s_price_total = 0;

		List<LogNscTeamVO> nkind4List = new ArrayList<LogNscTeamVO>();
		int intForkind4 = 0;
		for(int i = 0; i < teamList4.size(); i++, intForkind4++){
			LogNscTeamVO team4VO = teamList4.get(i);
			String tmpStr2 = team4VO.getTeam_id();
			map.put("tmpStr2", tmpStr2);

			//4종 log 조회 Start
			LogNscTeamVO log4List = sqlSession.selectOne("LogNscTeamMapper.lognkind4", map);
			//4종 log 조회 End
			log4List.setTeam_id(team4VO.getTeam_id());
			log4List.setTeam_name(team4VO.getTeam_name());
			
			k4s_unit_cn += Integer.parseInt(log4List.getUnit_cn());
			k4s_nsc_price_assess += Integer.parseInt(log4List.getNsc_price_assess());
			k4s_nsc_price_time += Integer.parseInt(log4List.getNsc_price_time());
			k4s_nsc_price_sum1 += Integer.parseInt(log4List.getNsc_price_sum1());
			k4s_nsc_price_traffic += Integer.parseInt(log4List.getNsc_price_traffic());
			k4s_nsc_price_question += Integer.parseInt(log4List.getNsc_price_question());
			k4s_nsc_price_receipt += Integer.parseInt(log4List.getNsc_price_receipt());
			k4s_nsc_price_sum2 += Integer.parseInt(log4List.getNsc_price_sum2());
			k4s_nsc_price_total += Integer.parseInt(log4List.getNsc_price_total());
			k4s_price_assess += Integer.parseInt(log4List.getPrice_assess());
			k4s_price_time += Integer.parseInt(log4List.getPrice_time());
			k4s_price_sum1 += Integer.parseInt(log4List.getPrice_sum1());
			k4s_price_traffic += Integer.parseInt(log4List.getPrice_traffic());
			k4s_price_question += Integer.parseInt(log4List.getPrice_question());
			k4s_price_receipt += Integer.parseInt(log4List.getPrice_receipt());
			k4s_price_sum2 += Integer.parseInt(log4List.getPrice_sum2());
			k4s_price_total += Integer.parseInt(log4List.getPrice_total());
			
			nkind4List.add(log4List);
		}
		
		
		LogNscTeamVO kind4SumVO = new LogNscTeamVO();
		kind4SumVO.setTeam_name("소계");
		kind4SumVO.setUnit_cn(""+format2.format(k4s_unit_cn));
		kind4SumVO.setNsc_price_assess(""+format2.format(k4s_nsc_price_assess));
		kind4SumVO.setNsc_price_time(""+format2.format(k4s_nsc_price_time));
		kind4SumVO.setNsc_price_sum1(""+format2.format(k4s_nsc_price_assess + k4s_nsc_price_time));
		kind4SumVO.setNsc_price_traffic(""+format2.format(k4s_nsc_price_traffic));
		kind4SumVO.setNsc_price_question(""+format2.format(k4s_nsc_price_question));
		kind4SumVO.setNsc_price_receipt(""+format2.format(k4s_nsc_price_receipt));
		kind4SumVO.setNsc_price_sum2(""+format2.format(k4s_nsc_price_assess + k4s_nsc_price_time + k4s_nsc_price_traffic + k4s_nsc_price_question + k4s_nsc_price_receipt));
		kind4SumVO.setNsc_price_total(""+format2.format(k4s_nsc_price_total));
		kind4SumVO.setPrice_assess(""+format2.format(k4s_price_assess + k4s_nsc_price_assess));
		kind4SumVO.setPrice_time(""+format2.format(k4s_price_time + k4s_nsc_price_time));
		kind4SumVO.setPrice_sum1(""+format2.format(k4s_price_assess + k4s_nsc_price_assess + k4s_price_time + k4s_nsc_price_time));
		kind4SumVO.setPrice_traffic(""+format2.format(k4s_price_traffic + k4s_nsc_price_traffic));
		kind4SumVO.setPrice_question(""+format2.format(k4s_price_question + k4s_nsc_price_question));
		kind4SumVO.setPrice_receipt(""+format2.format(k4s_price_receipt + k4s_nsc_price_receipt));
		kind4SumVO.setPrice_sum2(""+format2.format(k4s_price_assess + k4s_nsc_price_assess + k4s_price_time + k4s_nsc_price_time + k4s_price_traffic + k4s_nsc_price_traffic
				+ k4s_price_question + k4s_nsc_price_question + k4s_price_receipt + k4s_nsc_price_receipt));
		kind4SumVO.setPrice_total(""+format2.format(k4s_price_total));
		nkind4List.add(kind4SumVO);
		
		LogNscTeamVO kind14SumVO = new LogNscTeamVO();
		kind14SumVO.setSum_nsc_price_assess((k1s_nsc_price_assess+k4s_nsc_price_assess)+"");
		kind14SumVO.setSum_nsc_price_time(""+(k1s_nsc_price_time+k4s_nsc_price_time));
		kind14SumVO.setSum_nsc_price_sum1(""+(k1s_nsc_price_assess + k1s_nsc_price_time + k4s_nsc_price_assess + k4s_nsc_price_time));
		kind14SumVO.setSum_nsc_price_traffic(""+(k1s_nsc_price_traffic+k4s_nsc_price_traffic));
		kind14SumVO.setSum_nsc_price_question(""+format1.format(k1s_nsc_price_question+k4s_nsc_price_question));
		kind14SumVO.setSum_nsc_price_receipt(""+format1.format(k1s_nsc_price_receipt+k4s_nsc_price_receipt));
		kind14SumVO.setSum_nsc_price_sum2(""+(k1s_nsc_price_assess + k1s_nsc_price_time + k1s_nsc_price_traffic + k1s_nsc_price_question + k1s_nsc_price_receipt + k4s_nsc_price_assess + k4s_nsc_price_time + k4s_nsc_price_traffic + k4s_nsc_price_question + k4s_nsc_price_receipt));
		kind14SumVO.setSum_nsc_price_total(""+format1.format(k1s_nsc_price_total+k4s_nsc_price_total));
		kind14SumVO.setSum_price_assess((k1s_nsc_price_assess+k4s_nsc_price_assess)+"");
		kind14SumVO.setSum_price_time(""+(k1s_price_time+k4s_price_time));
		kind14SumVO.setSum_price_sum1(""+(k1s_price_assess + k1s_price_time + k4s_price_assess + k4s_price_time));
		kind14SumVO.setSum_price_traffic(""+(k1s_price_traffic+k4s_price_traffic));
		kind14SumVO.setSum_price_question(""+format1.format(k1s_price_question+k4s_price_question));
		kind14SumVO.setSum_price_receipt(""+format1.format(k1s_price_receipt+k4s_price_receipt));
		kind14SumVO.setSum_price_sum2(""+(k1s_price_assess + k1s_price_time + k1s_price_traffic + k1s_price_question + k1s_price_receipt + k4s_price_assess + k4s_price_time + k4s_price_traffic + k4s_price_question + k4s_price_receipt));
		kind14SumVO.setSum_price_total(""+format1.format(k1s_price_total+k4s_price_total));
		model.addAttribute("nkind4List", nkind4List);
		model.addAttribute("sumobj", kind14SumVO);
		model.addAttribute("pgid", "log_nsc_team");
		model.addAttribute("myself", myself);
		model.addAttribute("together", together);

		return "ls_log/log_index";
	}

}
