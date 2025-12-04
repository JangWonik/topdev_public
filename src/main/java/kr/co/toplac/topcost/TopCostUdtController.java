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

import kr.co.toplac.topteam.TopMbrBscVO;

@Controller
public class TopCostUdtController {

	private static final Logger logger = LoggerFactory.getLogger(TopCostUdtController.class);

	@Autowired
	private SqlSession sqlSession;

	/*
	*********************************************************
	* Program ID	: TopCostUdt
	* Program Name	: TopCostUdt
	* Description	: 경비내역(결재)
	* Author		: 
	* Date			: 2016.07.09.
	*********************************************************
	*/
	@RequestMapping(value = "topCostUdtOK", method = RequestMethod.POST)
	public String topCostUdtOK(Model model, HttpSession session, HttpServletResponse response, String action, TopCostCompositeVO costVO, TopMbrBscVO tmbVO, String cost_class_no) {

		logger.info("topCostUdtOK");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("primbizSuimList - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
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
		
		String date_deposit = costVO.getDate_deposit();
		String user_id = costVO.getUser_id();
		String team_id = costVO.getTeam_id();
		String team_name = costVO.getTeam_name();
		String user_name = costVO.getUser_name();
		String cost_deposit_no = costVO.getCost_deposit_no();
		String sum_cost_bill_ea = costVO.getSum_cost_bill_ea();
		String sum_cost_pay_amt = costVO.getSum_cost_pay_amt();
		String amt_deposit = costVO.getAmt_deposit();
		String cost_no = costVO.getCost_no();
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fromdate", fromdate);
		map.put("todate", todate);
		map.put("fromYear", fromYear);
		map.put("toYear", toYear);
		map.put("user_no", user_no);
		map.put("cost_class_no", cost_class_no);
		map.put("user_id", user_id);
		map.put("cost_deposit_no", cost_deposit_no);
		map.put("date_deposit", date_deposit);
		map.put("sum_cost_bill_ea", sum_cost_bill_ea);
		map.put("sum_cost_pay_amt", sum_cost_pay_amt);
		map.put("amt_deposit", amt_deposit);
		map.put("cost_no", cost_no);
		
		model.addAttribute("cost_class_no",cost_class_no);
		model.addAttribute("user_id",user_id);
		model.addAttribute("team_id",team_id);
		model.addAttribute("team_name",team_name);
		model.addAttribute("user_name",user_name);
		model.addAttribute("cost_class_no",cost_class_no);
		model.addAttribute("team_id",team_id);
		model.addAttribute("team_name",team_name);
		model.addAttribute("fromdate",fromdate);
		model.addAttribute("todate",todate);
		model.addAttribute("cost_no",cost_no);
		
		//팀장 결재하기
		if(action.equals("submit")){
			
			int topCostActionSubmit = sqlSession.update("topCostAsign.topCostActionSubmit",map);
			int topCostActionSubmit_deposit = sqlSession.update("topCostAsign.topCostActionSubmit_deposit",map);
			int result = 0;
			if((topCostActionSubmit > 0) && (topCostActionSubmit_deposit > 0)){
				
				result = 1;
			}
			
			out.print(result);
			
		}
		
		//팀장 결재 취소하기
		if(action.equals("submit_x")){
			
			int topCostActionSubmit_x = sqlSession.update("topCostAsign.topCostActionSubmit_x",map);
			int result = 0;
			if(topCostActionSubmit_x > 0){
				
				result = 1;
			}
			
			out.print(result);
			
		}
		
		//본부장 결재하기
		if(action.equals("submit_hq")){
			
			int topCostActionSubmit_hq_item = sqlSession.update("topCostAsign.topCostActionSubmit_hq_item",map);
			int topCostActionSubmit_hq_deposit = sqlSession.update("topCostAsign.topCostActionSubmit_hq_deposit",map);
			int result = 0;
			if((topCostActionSubmit_hq_item > 0) && (topCostActionSubmit_hq_deposit > 0)){
				
				result = 1;
			}
			
			out.print(result);
			
		}
		
		//본부장 결재 취소하기
		if(action.equals("submit_hq_x")){
			
			int topCostActionSubmit_hq_x_item = sqlSession.update("topCostAsign.topCostActionSubmit_hq_x_item",map);
			int topCostActionSubmit_hq_x_deposit = sqlSession.update("topCostAsign.topCostActionSubmit_hq_x_deposit",map);
			int result = 0;
			if((topCostActionSubmit_hq_x_item > 0) && (topCostActionSubmit_hq_x_deposit > 0)){
				
				result = 1;
			}
			
			out.print(result);
			
		}
		
		//재경팀 결재하기
		if(action.equals("submit_finance")){
			
			int topCostActionSubmit_finance_item = sqlSession.update("topCostAsign.topCostActionSubmit_finance_item",map);
			int topCostActionSubmit_finance_deposit = sqlSession.update("topCostAsign.topCostActionSubmit_finance_deposit",map);
			int result = 0;
			if((topCostActionSubmit_finance_item > 0) && (topCostActionSubmit_finance_deposit > 0)){
				
				result = 1;
			}
			
			out.print(result);
			
		}
		
		//재경팀 결재 취소하기
		if(action.equals("submit_finance_x")){
			
			int topCostActionSubmit_finance_x_item = sqlSession.update("topCostAsign.topCostActionSubmit_finance_x_item",map);
			int topCostActionSubmit_finance_x_deposit = sqlSession.update("topCostAsign.topCostActionSubmit_finance_x_deposit",map);
			int result = 0;
			if((topCostActionSubmit_finance_x_item > 0) && (topCostActionSubmit_finance_x_deposit > 0)){
				
				result = 1;
			}
			
			out.print(result);
			
		}
		
		//입금하기
		if(action.equals("submit_deposit")){
			
			int topCostActionSubmit_deposit_item = sqlSession.update("topCostAsign.topCostActionSubmit_deposit_item",map);
			int topCostActionSubmit_deposit_deposit = sqlSession.update("topCostAsign.topCostActionSubmit_deposit_deposit",map);
			int result = 0;
			if((topCostActionSubmit_deposit_item > 0) && (topCostActionSubmit_deposit_deposit > 0)){
				
				result = 1;
			}
			
			out.print(result);
			
		}
		
		//입금취소하기
		if(action.equals("submit_deposit_x")){
			
			int topCostActionSubmit_deposit_x_item = sqlSession.update("topCostAsign.topCostActionSubmit_deposit_x_item",map);
			int topCostActionSubmit_deposit_x_deposit = sqlSession.update("topCostAsign.topCostActionSubmit_deposit_x_deposit",map);
			int result = 0;
			if((topCostActionSubmit_deposit_x_item > 0) && (topCostActionSubmit_deposit_x_deposit > 0)){
				
				result = 1;
			}
			
			out.print(result);
			
		}

		return "top_cost/top_cost_team";
	}
	
}
