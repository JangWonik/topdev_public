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

import kr.co.toplac.topindividual.TopMyCostInsCompositeVO;
import kr.co.toplac.topprimbiz.TopPrimBizRptOrgFileVO;
import kr.co.toplac.topprimbizinv.TopPrimBizInvDtlViewVO;
import kr.co.toplac.topprimbizinv.TopPrimBizInvShareViewVO;
import kr.co.toplac.topteam.TopMbrBscVO;

@Controller
public class TopCostMemberController {

	private static final Logger logger = LoggerFactory.getLogger(TopCostMemberController.class);

	@Autowired
	private SqlSession sqlSession;

	/*
	*********************************************************
	* Program ID	: TopCostMember
	* Program Name	: TopCostMember
	* Description	: 경비내역
	* Author		: 
	* Date			: 2016.07.09.
	*********************************************************
	*/
	@RequestMapping(value = "topCostMember", method = RequestMethod.GET)
	public String topCostMember(Model model, HttpSession session, TopCostCompositeVO costVO, TopMbrBscVO tmbVO, String cost_class_no) {

		logger.info("topCostMember");

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
		String user_name = costVO.getUser_name();
		String cost_aprv_state = costVO.getCost_aprv_state();
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fromdate", fromdate);
		map.put("todate", todate);
		map.put("fromYear", fromYear);
		map.put("toYear", toYear);
		map.put("user_no", user_no);
		map.put("cost_class_no", cost_class_no);
		map.put("user_id", user_id);
		map.put("team_id", team_id);
		System.out.println(user_id + ":user_id 1111111111111");
		
		model.addAttribute("cost_class_no",cost_class_no);
		model.addAttribute("user_id",user_id);
		model.addAttribute("team_id",team_id);
		model.addAttribute("team_name",team_name);
		model.addAttribute("user_name",user_name);
		model.addAttribute("fromdate",fromdate);
		model.addAttribute("todate",todate);
		model.addAttribute("fromYear",fromYear);
		model.addAttribute("toYear",toYear);
		model.addAttribute("user_no",user_no);
		model.addAttribute("cost_aprv_state",cost_aprv_state);
		
		//해당 유저의 경비내역 리스트 조회
		List<TopCostCompositeVO> getCostMemberList = sqlSession.selectList("TopCostMember.getCostMemberList", map);
		
		int costMemberListSize = getCostMemberList.size();
		model.addAttribute("costMemberListSize", costMemberListSize);
		
		//해당 경비내역의 권한 조회
		/*TopCostCompositeVO getCost_aprv_state = sqlSession.selectOne("TopCostMember.getCostAprvState", map);
		
		model.addAttribute("getCost_aprv_state",getCost_aprv_state);*/
		
		/*수임건*/
		List<TopMyCostInsCompositeVO> getMyHelpRptList = sqlSession.selectList("TopCostMember.getMyHelpRptList", map);
		/*의뢰건*/
		List<TopMyCostInsCompositeVO> getMyHelpRptListAccept = sqlSession.selectList("TopCostMember.getMyHelpRptListAccept", map);
		/*수임건합계*/
		TopMyCostInsCompositeVO getMyHelpRptListSum = sqlSession.selectOne("TopCostMember.getMyHelpRptListSum", map);
		/*의뢰건합계*/
		TopMyCostInsCompositeVO getMyHelpRptListAcceptSum = sqlSession.selectOne("TopCostMember.getMyHelpRptListAcceptSum", map);
		
		//로그인 유저의 해당월 경비내역 합계 구하기
		TopCostCompositeVO getMemberCostInfo = sqlSession.selectOne("TopCostMember.getMemberCostSum",map);
		TopCostCompositeVO getMemberCostDepositInfo = sqlSession.selectOne("TopCostMember.getMemberCostDepositInfo",map);
		
		if(getMemberCostDepositInfo != null)
		{
			String cost_deposit_no = getMemberCostDepositInfo.getCost_deposit_no();
			map.put("cost_deposit_no", cost_deposit_no);
			
			/*보고서 원본 파일 정보 추출 시작*/
			List<TopCostCompositeVO> memberCostBillFileList  = sqlSession.selectList("TopCostMember.memberCostBillFileList", map);
			model.addAttribute("memberCostBillFileList", memberCostBillFileList);
			/*보고서 원본 파일 정보 추출 끝*/
		}

			model.addAttribute("getCostMemberList", getCostMemberList);
			model.addAttribute("getMyHelpRptList", getMyHelpRptList);
			model.addAttribute("getMyHelpRptListAccept", getMyHelpRptListAccept);
			model.addAttribute("getMyHelpRptListSum", getMyHelpRptListSum);
			model.addAttribute("getMyHelpRptListAcceptSum", getMyHelpRptListAcceptSum);
			model.addAttribute("getMemberCostInfo", getMemberCostInfo);
			model.addAttribute("getMemberCostDepositInfo", getMemberCostDepositInfo);
		
		
		

		return "top_cost/top_cost_member";
	}
	
	@RequestMapping(value = "CostMemberAddOK", method = RequestMethod.POST)
	public void CostMemberAddOK(Model model, HttpSession session, HttpServletResponse response, TopCostCompositeVO costVO, TopMbrBscVO tmbVO) {

		logger.info("CostMemberAddOK");
		
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
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fromdate", fromdate);
		map.put("todate", todate);
		map.put("fromYear", fromYear);
		map.put("toYear", toYear);
		map.put("user_no", user_no);
		map.put("user_id", user_id);
		map.put("team_id", team_id);
		
		model.addAttribute("user_id",user_id);
		model.addAttribute("team_id",team_id);
		model.addAttribute("fromdate",fromdate);
		model.addAttribute("todate",todate);
		model.addAttribute("fromYear",fromYear);
		model.addAttribute("toYear",toYear);
		model.addAttribute("user_no",user_no);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		int MemberCostDepositUdt = 0;
		int MemberCostDepositAdd = 0;
		
		//지급처, 관련회사, 면담자, 비고 미입력시 처리
		if(costVO.getCost_pay_place() == null || costVO.getCost_pay_place().equals("")){
			costVO.setCost_pay_place("-");
		}
		
		if(costVO.getCost_involved_com() == null || costVO.getCost_involved_com().equals("")){
			costVO.setCost_involved_com("-");
		}
		
		if(costVO.getCost_involved_man() == null || costVO.getCost_involved_man().equals("")){
			costVO.setCost_involved_man("-");
		}
		
		if(costVO.getCost_memo() == null || costVO.getCost_memo().equals("")){
			costVO.setCost_memo("-");
		}
		
		//로그인 유저의 해당월 데이터 사이즈 구하기
		List<TopCostCompositeVO> getMemberCostDepositList = sqlSession.selectList("TopCostMember.getMemberCostDepositList", map);
		
		int MemberCostAdd = sqlSession.insert("TopCostMember.MemberCostAdd", costVO);
		//로그인 유저의 해당월 경비내역 합계 구하기
		TopCostCompositeVO getMemberCostInfo = sqlSession.selectOne("TopCostMember.getMemberCostSum",map);
		
		String sum_cost = getMemberCostInfo.getSum_cost_pay_amt();
		String sum_bill = getMemberCostInfo.getSum_cost_bill_ea();
		costVO.setSum_cost(sum_cost);
		costVO.setSum_bill(sum_bill);
		
		
		if(getMemberCostDepositList.size() > 0){
			TopCostCompositeVO getMemberCostDepositInfo = sqlSession.selectOne("TopCostMember.getMemberCostDepositInfo",map);
			String cost_deposit_no = getMemberCostDepositInfo.getCost_deposit_no();
			costVO.setCost_deposit_no(cost_deposit_no);
			
			MemberCostDepositUdt = sqlSession.update("TopCostMember.memberCostDepositUdt", costVO);
		}else{
			MemberCostDepositAdd = sqlSession.insert("TopCostMember.memberCostDepositAdd", costVO);
		}
		int result = 0;
		if(((MemberCostAdd > 0) && (MemberCostDepositUdt > 0)) || ((MemberCostAdd > 0) && (MemberCostDepositAdd > 0))){
			
			result = 1;
	}
		out.print(result);
	}
	
	@RequestMapping(value = "memberCostUdtOK", method = RequestMethod.POST)
	public void memberCostUdtOK(Model model, HttpSession session, HttpServletResponse response, TopCostCompositeVO costVO, TopMbrBscVO tmbVO) {

		logger.info("memberCostUdtOK");
		
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
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fromdate", fromdate);
		map.put("todate", todate);
		map.put("fromYear", fromYear);
		map.put("toYear", toYear);
		map.put("user_no", user_no);
		map.put("user_id", user_id);
		map.put("team_id", team_id);
		
		model.addAttribute("user_id",user_id);
		model.addAttribute("team_id",team_id);
		model.addAttribute("fromdate",fromdate);
		model.addAttribute("todate",todate);
		model.addAttribute("fromYear",fromYear);
		model.addAttribute("toYear",toYear);
		model.addAttribute("user_no",user_no);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		//지급처, 관련회사, 면담자, 비고 미입력시 처리
		if(costVO.getCost_pay_place() == null || costVO.getCost_pay_place().equals("")){
			costVO.setCost_pay_place("-");
		}
		
		if(costVO.getCost_involved_com() == null || costVO.getCost_involved_com().equals("")){
			costVO.setCost_involved_com("-");
		}
		
		if(costVO.getCost_involved_man() == null || costVO.getCost_involved_man().equals("")){
			costVO.setCost_involved_man("-");
		}
		
		if(costVO.getCost_memo() == null || costVO.getCost_memo().equals("")){
			costVO.setCost_memo("-");
		}
		
		int memberCostDepositUdt = 0;
		
		//로그인 유저의 해당월 경비내역 수정하기
		int udtMemberCost = sqlSession.update("TopCostMember.udtMemberCost", costVO);
		
		TopCostCompositeVO getMemberCostInfo = sqlSession.selectOne("TopCostMember.getMemberCostSum",map);
		TopCostCompositeVO getMemberCostDepositInfo = sqlSession.selectOne("TopCostMember.getMemberCostDepositInfo",map);
		
		String sum_cost = getMemberCostInfo.getSum_cost_pay_amt();
		String cost_deposit_no = getMemberCostDepositInfo.getCost_deposit_no();
		
		map.put("sum_cost", sum_cost);
		map.put("cost_deposit_no", cost_deposit_no);
		
		memberCostDepositUdt = sqlSession.update("TopCostMember.memberCostDepositUdt", map);
		int result = 0;
		if((udtMemberCost > 0) && (memberCostDepositUdt > 0)){
			
			result = 1;
	}
		
		out.print(result);
	}
	
	@RequestMapping(value = "delMemberCostOK", method = RequestMethod.POST)
	public void delMemberCostOK(Model model, HttpSession session, HttpServletResponse response, TopCostCompositeVO costVO, TopMbrBscVO tmbVO) {

		logger.info("delMemberCostOK");
		
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
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fromdate", fromdate);
		map.put("todate", todate);
		map.put("fromYear", fromYear);
		map.put("toYear", toYear);
		map.put("user_no", user_no);
		map.put("user_id", user_id);
		map.put("team_id", team_id);
		
		model.addAttribute("user_id",user_id);
		model.addAttribute("team_id",team_id);
		model.addAttribute("fromdate",fromdate);
		model.addAttribute("todate",todate);
		model.addAttribute("fromYear",fromYear);
		model.addAttribute("toYear",toYear);
		model.addAttribute("user_no",user_no);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		int MemberCostDepositDel = 0;
		
		//로그인 유저의 해당월 경비내역 삭제하기
		int delMemberCost = sqlSession.delete("TopCostMember.delMemberCost", costVO);
		
		TopCostCompositeVO getMemberCostInfo = sqlSession.selectOne("TopCostMember.getMemberCostSum",map);
		TopCostCompositeVO getMemberCostDepositInfo = sqlSession.selectOne("TopCostMember.getMemberCostDepositInfo",map);
		
		String sum_cost = getMemberCostInfo.getSum_cost_pay_amt();
		String cost_deposit_no = getMemberCostDepositInfo.getCost_deposit_no();
		
		map.put("sum_cost", sum_cost);
		map.put("cost_deposit_no", cost_deposit_no);
		
		MemberCostDepositDel = sqlSession.update("TopCostMember.memberCostDepositUdt", map);
		int result = 0;
		if((delMemberCost > 0) && (MemberCostDepositDel > 0)){
			
			result = 1;
	}
		
		out.print(result);
	}
	/*
	@RequestMapping(value = "printCost", method = RequestMethod.GET)
	public String printCost(Model model, HttpSession session, TopMyCostInsCompositeVO costVO, TopMbrBscVO tmbVO) {
	
		logger.info("printCost");
		
		
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
				String fromYear = fromAccumYear + "12" + "16";
				String toYear = toAccumYear + "12" + "16";
				
				System.out.println("fromdate :" +fromdate);
				System.out.println("todate :" +todate);
				model.addAttribute("toAccumYear",toAccumYear);
				model.addAttribute("toAccumMonth",toAccumMonth);
				//해당월 조회기간 구하기 끝
				
				
				String user_no = costVO.getUser_no();
				TopMbrBscVO myInfoVo = sqlSession.selectOne("MyEmpCertIns.getMyInfo", user_no);
				String team_name = (String) myInfoVo.getTeam_name();
				String user_name = (String) myInfoVo.getUser_name();
				//String cost_class_no = costVO.getCost_class_no();
				/*String class_no = "0";
				if(cost_class_no == null){
					cost_class_no = class_no;
				}
				
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("fromdate", fromdate);
				map.put("todate", todate);
				map.put("fromYear", fromYear);
				map.put("toYear", toYear);
				map.put("user_no", user_no);
				
		/*카드정보출 시작
		List<TopMyCostInsCompositeVO> selCardList = sqlSession.selectList("MyCostIns.selCardList", map);
		/*카드정보 추출 끝
	
		/*현금정보출 시작
		List<TopMyCostInsCompositeVO> selCashList = sqlSession.selectList("MyCostIns.selCashList", map);
		/*현금정보 추출 끝
		/*수임건
		List<TopMyCostInsCompositeVO> getMyHelpRptList = sqlSession.selectList("MyCostIns.getMyHelpRptList", map);
		/*의뢰건
		List<TopMyCostInsCompositeVO> getMyHelpRptListAccept = sqlSession.selectList("MyCostIns.getMyHelpRptListAccept", map);
		/*수임건합계
		TopMyCostInsCompositeVO getMyHelpRptListSum = sqlSession.selectOne("MyCostIns.getMyHelpRptListSum", map);
		/*의뢰건합계
		TopMyCostInsCompositeVO getMyHelpRptListAcceptSum = sqlSession.selectOne("MyCostIns.getMyHelpRptListAcceptSum", map);
		/*카드정보 합계
		TopMyCostInsCompositeVO getMyCostCardSum = sqlSession.selectOne("MyCostIns.getMyCostCardSum", map);
		/*현금정보 합계
		TopMyCostInsCompositeVO getMyCostCashSum = sqlSession.selectOne("MyCostIns.getMyCostCashSum", map);
		/*총 합계
		TopMyCostInsCompositeVO MyCostSum = sqlSession.selectOne("MyCostIns.MyCostSum", map);
		
		model.addAttribute("user_name", user_name);
		model.addAttribute("team_name", team_name);
		model.addAttribute("selCardList", selCardList);
		model.addAttribute("selCashList", selCashList);
		model.addAttribute("getMyCostCardSum", getMyCostCardSum);
		model.addAttribute("getMyCostCashSum", getMyCostCashSum);
		model.addAttribute("MyCostSum", MyCostSum);
		model.addAttribute("getMyHelpRptList", getMyHelpRptList);
		model.addAttribute("getMyHelpRptListAccept", getMyHelpRptListAccept);
		model.addAttribute("getMyHelpRptListSum", getMyHelpRptListSum);
		model.addAttribute("getMyHelpRptListAcceptSum", getMyHelpRptListAcceptSum);
		
		return "top_individual/my_cost_print";	
		
	}
	*/
	
	
	
}
