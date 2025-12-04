/*
*********************************************************
* Program ID	: PrimbizSuimListController
* Program Name	: PrimbizSuimListController
* Description	: 농작물 수임대장 리스트
* Author		: 
* Date			: 2016.06.09.
*********************************************************
*/
package kr.co.toplac.topcost;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.topprimbiz.TopPrimBizRptOrgFileVO;
import kr.co.toplac.topprimbizinv.TopPrimBizInvDtlViewVO;
import kr.co.toplac.topprimbizinv.TopPrimBizInvShareViewVO;
import kr.co.toplac.toprptinv.TopRptInvCompositeVO;
import kr.co.toplac.toprptinv.TopRptInvLogVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;

@Controller
public class TopCostTeamController {

	private static final Logger logger = LoggerFactory.getLogger(TopCostTeamController.class);

	@Autowired
	private SqlSession sqlSession;

	/*
	*********************************************************
	* Program ID	: TopCostTeam
	* Program Name	: TopCostTeam
	* Description	: 경비내역(팀별)
	* Author		: 
	* Date			: 2016.07.09.
	*********************************************************
	*/
	@RequestMapping(value = "topCostTeam", method = RequestMethod.GET)
	public String topCostTeam(Model model, HttpSession session, TopCostCompositeVO costVO, TopMbrBscVO tmbVO, String cost_class_no) {

		logger.info("topCostTeam");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("primbizSuimList - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		//해당월 조회기간 구하기 시작
		String fromdate = costVO.getViewFromDate();
		String todate = costVO.getViewToDate();
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
		int toAccumMonth = Integer.parseInt(todate.substring(5, 7));
		if(fromAccumMonth < 12){
			fromAccumYear--;
		}
		String toMonth = todate.substring(5, 7);
		String fromYear = fromAccumYear + "12" + "16";
		String toYear = toAccumYear + "12" + "16";
		
		model.addAttribute("toAccumYear",toAccumYear);
		model.addAttribute("toAccumMonth",toAccumMonth);
		model.addAttribute("toMonthInt",toMonthInt);
		model.addAttribute("toMonth",toMonth);
		
		//해당월 조회기간 구하기 끝
		
		String user_no = (String) session.getAttribute("user_no_Session");
		costVO.setUser_no(user_no);
		String user_id = costVO.getUser_id();
		String team_id = costVO.getTeam_id();
		String team_name = costVO.getTeam_name();
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fromdate", fromdate);
		map.put("todate", todate);
		map.put("fromYear", fromYear);
		map.put("toYear", toYear);
		map.put("user_no", user_no);
		map.put("user_id", user_id);
		map.put("cost_class_no", cost_class_no);
		map.put("team_id", team_id);
		
		model.addAttribute("cost_class_no",cost_class_no);
		model.addAttribute("team_id",team_id);
		model.addAttribute("user_id",user_id);
		model.addAttribute("team_name",team_name);
		model.addAttribute("fromdate",fromdate);
		model.addAttribute("todate",todate);
		
		//팀별 경비내역 조회하기
		List<TopCostCompositeVO> getCostTeamList = sqlSession.selectList("TopCostTeam.getCostTeamList", map);
		
		TopCostCompositeVO getCostTeamListTotal = sqlSession.selectOne("TopCostTeam.getCostTeamListTotal", map);
		
		model.addAttribute("getCostTeamList", getCostTeamList);
		model.addAttribute("getCostTeamListTotal", getCostTeamListTotal);

		return "top_cost/top_cost_team";
	}
	
	@RequestMapping(value = "topCostDepositPop", method = RequestMethod.GET)
	public String topCostDepositPop(Model model, HttpSession session, TopCostCompositeVO costVO, TopMbrBscVO tmbVO, String cost_class_no) {
		logger.info("topCostDepositPop");
		
		//해당월 조회기간 구하기 시작
		String fromdate = costVO.getViewFromDate();
		String todate = costVO.getViewToDate();
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
		String today_Deposit = "";
		if(monthInt < 10){
			
			today_Deposit = yearInt + "-" + "0" + monthInt + "-" + dateInt;
		}

		int fromAccumYear = Integer.parseInt(fromdate.substring(0, 4));
		int fromAccumMonth = Integer.parseInt(fromdate.substring(5, 7));
		int toAccumYear = Integer.parseInt(todate.substring(0, 4));
		int toAccumMonth = Integer.parseInt(todate.substring(5, 7));
		if(fromAccumMonth < 12){
			fromAccumYear--;
		}
		String toMonth = todate.substring(5, 7);
		String fromYear = fromAccumYear + "12" + "16";
		String toYear = toAccumYear + "12" + "16";
		
		model.addAttribute("toAccumYear",toAccumYear);
		model.addAttribute("toAccumMonth",toAccumMonth);
		model.addAttribute("toMonthInt",toMonthInt);
		model.addAttribute("toMonth",toMonth);
		model.addAttribute("today_Deposit",today_Deposit);
		
		//해당월 조회기간 구하기 끝
		
		String user_no = (String) session.getAttribute("user_no_Session");
		costVO.setUser_no(user_no);
		String team_id = costVO.getTeam_id();
		String team_name = costVO.getTeam_name();
		String user_id = costVO.getUser_id();
		String user_name = costVO.getUser_name();
		String cost_no = costVO.getCost_no();
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fromdate", fromdate);
		map.put("todate", todate);
		map.put("fromYear", fromYear);
		map.put("toYear", toYear);
		map.put("user_no", user_no);
		map.put("cost_class_no", cost_class_no);
		map.put("team_id", team_id);
		map.put("user_id", user_id);
		map.put("cost_no", cost_no);
		
		model.addAttribute("cost_class_no",cost_class_no);
		model.addAttribute("team_id",team_id);
		model.addAttribute("user_id",user_id);
		model.addAttribute("team_name",team_name);
		model.addAttribute("user_name",user_name);
		model.addAttribute("fromdate",fromdate);
		model.addAttribute("todate",todate);
		model.addAttribute("cost_no",cost_no);

		//승인하기 팝업창 리스트 출력
		List<TopCostCompositeVO> getCostMemberDeposit = sqlSession.selectList("TopCostTeam.getCostMemberDeposit", map);
		
		model.addAttribute("getCostMemberDeposit", getCostMemberDeposit);
		
		return "top_cost/top_cost_deposit_pop"; 
	}
	
	
}
