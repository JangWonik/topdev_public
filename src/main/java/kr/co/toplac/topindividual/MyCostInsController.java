/*
*********************************************************
* Program ID	: PrimbizSuimListController
* Program Name	: PrimbizSuimListController
* Description	: 농작물 수임대장 리스트
* Author		: 
* Date			: 2016.06.09.
*********************************************************
*/
package kr.co.toplac.topindividual;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.toplac.util.cmm.StringUtil;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.topmain.MainLeftSuimVO;
import kr.co.toplac.topprimbiz.TopPrimBizRptCompositeVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.rpt.MainLeftUtil;

@Controller
public class MyCostInsController {

	private static final Logger logger = LoggerFactory.getLogger(MyCostInsController.class);

	@Autowired
	private SqlSession sqlSession;

	@Autowired
	MainLeftUtil mlu;

	/*
	*********************************************************
	* Program ID	: primbizSuimList
	* Program Name	: primbizSuimList
	* Description	: 농작물 수임대장 리스트
	* Author		: 
	* Date			: 2016.06.09.
	*********************************************************
	*/
	@RequestMapping(value = "myCostInsList", method = RequestMethod.GET)
	public String myCostInsList(Model model, HttpSession session, TopMyCostInsCompositeVO costVO, TopMbrBscVO tmbVO, String cost_class_no) {

		logger.info("myCostInsList");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("primbizSuimList - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

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
		if(cost_class_no == null){
			cost_class_no = "0";
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
		model.addAttribute("fromdate",fromdate);
		model.addAttribute("todate",todate);
		//해당월 조회기간 구하기 끝
		
		String user_no = (String) session.getAttribute("user_no_Session");
		costVO.setUser_no(user_no);
		//String cost_class_no = costVO.getCost_class_no();
		/*String class_no = "0";
		if(cost_class_no == null){
			cost_class_no = class_no;
		}*/
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fromdate", fromdate);
		map.put("todate", todate);
		map.put("fromYear", fromYear);
		map.put("toYear", toYear);
		map.put("user_no", user_no);
		map.put("cost_class_no", cost_class_no);
		
		model.addAttribute("cost_class_no",cost_class_no);
		model.addAttribute("user_no",user_no);
		
		List<TopMyCostInsCompositeVO> getMyCostInsList = sqlSession.selectList("MyCostIns.getMyCostInsList", map);
		for(int i = 0; i < getMyCostInsList.size(); i++){
			System.out.println(getMyCostInsList.get(i).getCost_class_no() + ":::::::::::");
		}
		int mycostListSize = getMyCostInsList.size();
		model.addAttribute("mycostListSize",mycostListSize);
		/*수임건*/
		List<TopMyCostInsCompositeVO> getMyHelpRptList = sqlSession.selectList("MyCostIns.getMyHelpRptList", map);
		/*의뢰건*/
		List<TopMyCostInsCompositeVO> getMyHelpRptListAccept = sqlSession.selectList("MyCostIns.getMyHelpRptListAccept", map);
		/*수임건합계*/
		TopMyCostInsCompositeVO getMyHelpRptListSum = sqlSession.selectOne("MyCostIns.getMyHelpRptListSum", map);
		/*의뢰건합계*/
		TopMyCostInsCompositeVO getMyHelpRptListAcceptSum = sqlSession.selectOne("MyCostIns.getMyHelpRptListAcceptSum", map);
		
		TopMyCostInsCompositeVO getMyCostSum = sqlSession.selectOne("MyCostIns.getMyCostSum", map);
		TopMyCostInsCompositeVO getMyCostDepositInfo = sqlSession.selectOne("MyCostIns.getMyCostDepositInfo",map);
		
		if(getMyCostDepositInfo != null)
		{
			String cost_deposit_no = getMyCostDepositInfo.getCost_deposit_no();
			map.put("cost_deposit_no", cost_deposit_no);
			
			/*보고서 원본 파일 정보 추출 시작*/
			List<TopMyCostBillFileVO> myCostBillFileList  = sqlSession.selectList("MyCostIns.myCostBillFileList", map);
			model.addAttribute("myCostBillFileList", myCostBillFileList);
			/*보고서 원본 파일 정보 추출 끝*/
		}

			model.addAttribute("getMyCostInsList", getMyCostInsList);
			model.addAttribute("getMyHelpRptList", getMyHelpRptList);
			model.addAttribute("getMyHelpRptListAccept", getMyHelpRptListAccept);
			model.addAttribute("getMyHelpRptListSum", getMyHelpRptListSum);
			model.addAttribute("getMyHelpRptListAcceptSum", getMyHelpRptListAcceptSum);
			model.addAttribute("getMyCostSum", getMyCostSum);
			model.addAttribute("getMyCostDepositInfo", getMyCostDepositInfo);

		return "top_individual/my_cost_ins";
	}
	
	@RequestMapping(value = "myCostInsAddOK", method = RequestMethod.POST)
	public void myCostInsAddOK(HttpSession session, HttpServletResponse response, TopMyCostInsCompositeVO costVO, TopMbrBscVO tmbVO) {

		logger.info("myCostInsAddOK");
		
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
		if(fromAccumMonth < 12){
			fromAccumYear--;
		}
		String fromYear = fromAccumYear + "12" + "16";
		String toYear = toAccumYear + "12" + "16";
		//해당월 조회기간 구하기 끝
		
		String user_no = (String) session.getAttribute("user_no_Session");
		costVO.setUser_no(user_no);
		TopMbrBscVO myInfoVo = sqlSession.selectOne("MyEmpCertIns.getMyInfo", user_no);
		String team_id = (String) myInfoVo.getTeam_id_loc();
		costVO.setTeam_id(team_id);
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fromdate", fromdate);
		map.put("todate", todate);
		map.put("fromYear", fromYear);
		map.put("toYear", toYear);
		map.put("user_no", user_no);
		map.put("team_id", team_id);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		int myCostDepositUdt = 0;
		int myCostDepositAdd = 0;
		
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
		List<TopMyCostInsCompositeVO> getMyCostDepositList = sqlSession.selectList("MyCostIns.getMyCostDepositList", map);
		
		//로그인 유저의 해당월 경비내역 합계 구하기
		TopMyCostInsCompositeVO getMyCostInfo = sqlSession.selectOne("MyCostIns.getMyCostSum",map);
		
		
		String sum_cost = getMyCostInfo.getSum_cost_pay_amt();
		
		/*if(getMyCostInfo.getSum_cost_pay_amt() == null){
			sum_cost = "0";
		}else{
			sum_cost = getMyCostInfo.getSum_cost_pay_amt();
		};*/
		costVO.setSum_cost(sum_cost);
		
		String sum_bill = getMyCostInfo.getSum_cost_bill_ea();
		/*if(getMyCostInfo.getSum_cost_bill_ea() == null){
			sum_bill = "0";
		}else{
			sum_bill = getMyCostInfo.getSum_cost_bill_ea();
		};*/
		costVO.setSum_bill(sum_bill);
		
		//로그인 유저의 해당월 경비내역 추가하기
		int myCostInsAdd = sqlSession.insert("MyCostIns.myCostInsAdd", costVO);
		
		if(getMyCostDepositList.size()> 0){
			
			myCostDepositUdt = sqlSession.update("MyCostUdt.myCostDepositUdt", costVO);
		}else{
			myCostDepositAdd = sqlSession.insert("MyCostIns.myCostDepositAdd", costVO);
		}
		int result = 0;
		if(((myCostInsAdd > 0) && (myCostDepositUdt > 0)) || ((myCostInsAdd > 0) && (myCostDepositAdd > 0))){
			
			result = 1;
	}
		
		out.print(result);
	}//primBizInvShareAddOK
	
	@RequestMapping(value = "myCostUdtOK", method = RequestMethod.POST)
	public void myCostUdtOK(HttpSession session, HttpServletResponse response, TopMyCostInsCompositeVO costVO, TopMbrBscVO tmbVO) {

		logger.info("myCostUdtOK");
		
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
		if(fromAccumMonth < 12){
			fromAccumYear--;
		}
		String fromYear = fromAccumYear + "12" + "16";
		String toYear = toAccumYear + "12" + "16";
		//해당월 조회기간 구하기 끝
		
		String user_no = (String) session.getAttribute("user_no_Session");
		costVO.setUser_no(user_no);
		TopMbrBscVO myInfoVo = sqlSession.selectOne("MyEmpCertIns.getMyInfo", user_no);
		String team_id = (String) myInfoVo.getTeam_id_main();
		costVO.setTeam_id(team_id);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
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
		
		int myCostDepositUdt = 0;
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fromdate", fromdate);
		map.put("todate", todate);
		map.put("fromYear", fromYear);
		map.put("toYear", toYear);
		map.put("user_no", user_no);
		map.put("team_id", team_id);
		
		//로그인 유저의 해당월 경비내역 수정하기
		int udtMyCost = sqlSession.update("MyCostUdt.udtMyCost", costVO);
		
		TopMyCostInsCompositeVO getMyCostInfo = sqlSession.selectOne("MyCostIns.getMyCostSum",map);
		TopMyCostInsCompositeVO getMyCostDepositInfo = sqlSession.selectOne("MyCostIns.getMyCostDepositInfo",map);
		
		String sum_cost = getMyCostInfo.getSum_cost_pay_amt();
		String cost_deposit_no = getMyCostDepositInfo.getCost_deposit_no();
		map.put("sum_cost", sum_cost);
		map.put("cost_deposit_no", cost_deposit_no);
		
		myCostDepositUdt = sqlSession.update("MyCostUdt.myCostDepositUdt", map);
		int result = 0;
		if((udtMyCost > 0) && (myCostDepositUdt > 0)){
			
			result = 1;
	}
		
		out.print(result);
	}//primBizInvShareAddOK
	
	/* 영수증 파일 다운로드 */
	@RequestMapping(value = "myCostBillFileDownload", method = RequestMethod.GET)
	 public void myCostBillFileDownload(String key,String type, String cost_deposit_no, HttpServletResponse response)
			 throws IOException{
		
		logger.info("myCostBillFileDownload");
		
		String path = "";
		String fullPath = "";
		String fileName = "";
		String tmpFName = ""; //encode file명
		if(type.equals("rptOrigin")){
			path = sqlSession.selectOne("MyCostUdt.getMyCostBillFileNameForDown", key);
			fileName = path.substring(path.lastIndexOf("/")+1);
			fullPath = "/home/hosting_users/toplac/www"+path;
		}
		
		try {
			tmpFName = java.net.URLEncoder.encode(fileName,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		response.setHeader("Content-Disposition","attachment;filename="+tmpFName);

		ServletOutputStream sout = response.getOutputStream();
		FileInputStream fin = new FileInputStream(fullPath);
		
		byte[] buf = new byte[1024];
		int size=0;
		while((size=fin.read(buf,0,1024))!=-1){
			sout.write(buf,0,size);
		}
		sout.flush();
		fin.close();
		sout.close();
	}
	
	
	@RequestMapping(value = "myCostDelOK", method = RequestMethod.POST)
	public void myCostDelOK(HttpSession session, HttpServletResponse response, TopMyCostInsCompositeVO costVO, TopMbrBscVO tmbVO) {

		logger.info("myCostDelOK");

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
		if(fromAccumMonth < 12){
			fromAccumYear--;
		}
		String fromYear = fromAccumYear + "12" + "16";
		String toYear = toAccumYear + "12" + "16";
		//해당월 조회기간 구하기 끝
		
		String user_no = (String) session.getAttribute("user_no_Session");
		costVO.setUser_no(user_no);
		TopMbrBscVO myInfoVo = sqlSession.selectOne("MyEmpCertIns.getMyInfo", user_no);
		String team_id = (String) myInfoVo.getTeam_id_main();
		costVO.setTeam_id(team_id);
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fromdate", fromdate);
		map.put("todate", todate);
		map.put("fromYear", fromYear);
		map.put("toYear", toYear);
		map.put("user_no", user_no);
		map.put("team_id", team_id);
		
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		int udtMyCostDepositDel = 0;
		
		int delMyCost = sqlSession.delete("MyCostUdt.delMyCost", costVO);
		
		TopMyCostInsCompositeVO getMyCostInfo = sqlSession.selectOne("MyCostIns.getMyCostSum",map);
		TopMyCostInsCompositeVO getMyCostDepositInfo = sqlSession.selectOne("MyCostIns.getMyCostDepositInfo",map);
		
		String sum_cost = getMyCostInfo.getSum_cost_pay_amt();
		String cost_deposit_no = getMyCostDepositInfo.getCost_deposit_no();
		map.put("sum_cost", sum_cost);
		map.put("cost_deposit_no", cost_deposit_no);
		
		udtMyCostDepositDel = sqlSession.update("MyCostUdt.myCostDepositUdt", map);
		
		int result = 0;
		if((delMyCost > 0) && (udtMyCostDepositDel > 0)){
			
			result = 1;
	}
		
		out.print(result);
	}//primBizInvShareAddOK

	
	
	@RequestMapping(value = "myCostBillFileDel", method = RequestMethod.POST)
	public void myCostBillFileDel(String serialNo, PrintWriter out) {
		
		logger.info("myCostBillFileDel");
		
		String path = sqlSession.selectOne("MyCostUdt.getMyCostBillFilePathForDel", serialNo);
		
		String fileforder = path.substring(0, path.lastIndexOf("/"));
		
		int result = 0;
		
		//파일 삭제 시작
		if(!fileforder.equals("")){
			
			File file = new File(path);
			File dir = new File(fileforder);
			file.delete();
			dir.delete();
			
			result = 1;
		}
		//파일 삭제 종료
		
		sqlSession.selectOne("MyCostUdt.delMyCostBillFile", serialNo);
		
		out.print(result);
	}
	
	@RequestMapping(value = "printMyCost", method = RequestMethod.GET)
	public String printMyCost(Model model, HttpSession session, TopMyCostInsCompositeVO costVO, TopMbrBscVO tmbVO) {
	
		logger.info("printMyCost");
		
		
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
		
		
		String user_no = (String) session.getAttribute("user_no_Session");
		costVO.setUser_no(user_no);
		TopMbrBscVO myInfoVo = sqlSession.selectOne("MyEmpCertIns.getMyInfo", user_no);
		String team_name = (String) myInfoVo.getTeam_name();
		String user_name = (String) myInfoVo.getUser_name();
		//String cost_class_no = costVO.getCost_class_no();
		/*String class_no = "0";
		if(cost_class_no == null){
			cost_class_no = class_no;
		}*/
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fromdate", fromdate);
		map.put("todate", todate);
		map.put("fromYear", fromYear);
		map.put("toYear", toYear);
		map.put("user_no", user_no);
				
		/*경비내역 카드정보출 시작*/
		List<TopMyCostInsCompositeVO> selCardList = sqlSession.selectList("MyCostIns.selCardList", map);
		/*경비내역 현금정보출 시작*/
		List<TopMyCostInsCompositeVO> selCashList = sqlSession.selectList("MyCostIns.selCashList", map);
		
		/*클레임교통비내역 카드정보출 시작*/
		List<TopMyCostInsCompositeVO> selClaimCardList = sqlSession.selectList("MyCostIns.selClaimCardList", map);
		/*클레임교통비내역 현금정보출 시작*/
		List<TopMyCostInsCompositeVO> selClaimCashList = sqlSession.selectList("MyCostIns.selClaimCashList", map);
		
		/*추가경비내역 카드정보출 시작*/
		List<TopMyCostInsCompositeVO> selAddCardList = sqlSession.selectList("MyCostIns.selAddMyCardList", map);
		/*추가경비내역 현금정보출 시작*/
		List<TopMyCostInsCompositeVO> selAddCashList = sqlSession.selectList("MyCostIns.selAddMyCashList", map);
		
		
		/*수임건*/
		List<TopMyCostInsCompositeVO> getMyHelpRptList = sqlSession.selectList("MyCostIns.getMyHelpRptList", map);
		/*의뢰건*/
		List<TopMyCostInsCompositeVO> getMyHelpRptListAccept = sqlSession.selectList("MyCostIns.getMyHelpRptListAccept", map);
		/*수임건합계*/
		TopMyCostInsCompositeVO getMyHelpRptListSum = sqlSession.selectOne("MyCostIns.getMyHelpRptListSum", map);
		/*의뢰건합계*/
		TopMyCostInsCompositeVO getMyHelpRptListAcceptSum = sqlSession.selectOne("MyCostIns.getMyHelpRptListAcceptSum", map);
		/*경비내역 카드정보 합계*/
		TopMyCostInsCompositeVO getMyCostCardSum = sqlSession.selectOne("MyCostIns.getMyCostCardSum", map);
		/*경비내역 현금정보 합계*/
		TopMyCostInsCompositeVO getMyCostCashSum = sqlSession.selectOne("MyCostIns.getMyCostCashSum", map);
		/*클레임 교통비 내역 카드정보 합계*/
		TopMyCostInsCompositeVO getMyCostClaimCardSum = sqlSession.selectOne("MyCostIns.getMyCostClaimCardSum", map);
		/*클레임 교통비 내역 현금정보 합계*/
		TopMyCostInsCompositeVO getMyCostClaimCashSum = sqlSession.selectOne("MyCostIns.getMyCostClaimCashSum", map);
		/*추가경비내역 카드정보 합계*/
		TopMyCostInsCompositeVO getMyCostAddCardSum = sqlSession.selectOne("MyCostIns.getMyCostAddCardSum", map);
		
		
		/*추가내역 현금정보 합계*/
		TopMyCostInsCompositeVO getMyCostAddCashSum = sqlSession.selectOne("MyCostIns.getMyCostAddCashSum", map);
		/*총 합계*/
		
		int sum_cost_bill_ea = 0;
		sum_cost_bill_ea += Integer.parseInt(getMyCostCardSum.getSum_cost_bill_ea());
		sum_cost_bill_ea += Integer.parseInt(getMyCostCashSum.getSum_cost_bill_ea());
		sum_cost_bill_ea += Integer.parseInt(getMyCostClaimCardSum.getSum_cost_bill_ea());
		sum_cost_bill_ea += Integer.parseInt(getMyCostClaimCashSum.getSum_cost_bill_ea());
		sum_cost_bill_ea += Integer.parseInt(getMyCostAddCardSum.getSum_cost_bill_ea());
		sum_cost_bill_ea += Integer.parseInt(getMyCostAddCashSum.getSum_cost_bill_ea());
				
		int sum_cost_pay_amt = 0;
		sum_cost_pay_amt += Integer.parseInt(getMyCostCardSum.getSum_cost_pay_amt());
		sum_cost_pay_amt += Integer.parseInt(getMyCostCashSum.getSum_cost_pay_amt());
		sum_cost_pay_amt += Integer.parseInt(getMyCostClaimCardSum.getSum_cost_pay_amt());
		sum_cost_pay_amt += Integer.parseInt(getMyCostClaimCashSum.getSum_cost_pay_amt());
		sum_cost_pay_amt += Integer.parseInt(getMyCostAddCardSum.getSum_cost_pay_amt());
		sum_cost_pay_amt += Integer.parseInt(getMyCostAddCashSum.getSum_cost_pay_amt());
		
		TopMyCostInsCompositeVO MyCostSum = new TopMyCostInsCompositeVO();
		MyCostSum.setSum_cost_bill_ea(String.valueOf(sum_cost_bill_ea));
		MyCostSum.setSum_cost_pay_amt(String.valueOf(sum_cost_pay_amt));
		 
		model.addAttribute("user_name", user_name);
		model.addAttribute("team_name", team_name);
		model.addAttribute("selCardList", selCardList);
		model.addAttribute("selCashList", selCashList);
		model.addAttribute("selClaimCardList", selClaimCardList);
		model.addAttribute("selClaimCashList", selClaimCashList);
		model.addAttribute("getMyCostCardSum", getMyCostCardSum);
		model.addAttribute("getMyCostCashSum", getMyCostCashSum);
		model.addAttribute("getMyCostClaimCardSum", getMyCostClaimCardSum);
		model.addAttribute("getMyCostClaimCashSum", getMyCostClaimCashSum);
		model.addAttribute("MyCostSum", MyCostSum);
		model.addAttribute("getMyHelpRptList", getMyHelpRptList);
		model.addAttribute("getMyHelpRptListAccept", getMyHelpRptListAccept);
		model.addAttribute("getMyHelpRptListSum", getMyHelpRptListSum);
		model.addAttribute("getMyHelpRptListAcceptSum", getMyHelpRptListAcceptSum);
		model.addAttribute("selAddCardList", selAddCardList);
		model.addAttribute("selAddCashList", selAddCashList);
		model.addAttribute("getMyCostAddCardSum", getMyCostAddCardSum);
		model.addAttribute("getMyCostAddCashSum", getMyCostAddCashSum);
		
		return "top_individual/my_cost_print";	
		
	}
	
	@RequestMapping(value = "printCost", method = RequestMethod.GET)
	public String printCost(Model model, HttpSession session, TopMyCostInsCompositeVO costVO, TopMbrBscVO tmbVO, String user_no, HttpServletRequest request) {
	
		logger.info("printCost");
		
		//==========================================
		//	엑셀 처리
		//==========================================
		String excelYN = StringUtil.null2blank(request.getParameter("excelYN"));  //엑셀다운 여부
		
		if ("".equals(excelYN)){
			excelYN = "N";
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
		String fromYear = fromAccumYear + "12" + "16";
		String toYear = toAccumYear + "12" + "16";
		
		System.out.println("fromdate :" +fromdate);
		System.out.println("todate :" +todate);
		model.addAttribute("toAccumYear",toAccumYear);
		model.addAttribute("toAccumMonth",toAccumMonth);
		//해당월 조회기간 구하기 끝
		
		
		TopMbrBscVO myInfoVo = sqlSession.selectOne("MyEmpCertIns.getMyInfo", user_no);
		String team_name = (String) myInfoVo.getTeam_name();
		String user_name = (String) myInfoVo.getUser_name();
		//String cost_class_no = costVO.getCost_class_no();
		/*String class_no = "0";
		if(cost_class_no == null){
			cost_class_no = class_no;
		}*/
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fromdate", fromdate);
		map.put("todate", todate);
		map.put("fromYear", fromYear);
		map.put("toYear", toYear);
		map.put("user_no", user_no);
				
		/*경비내역 카드정보출 시작*/
		List<TopMyCostInsCompositeVO> selCardList = sqlSession.selectList("MyCostIns.selCardList", map);
		/*경비내역 현금정보출 시작*/
		List<TopMyCostInsCompositeVO> selCashList = sqlSession.selectList("MyCostIns.selCashList", map);
		
		/*클레임교통비내역 카드정보출 시작*/
		List<TopMyCostInsCompositeVO> selClaimCardList = sqlSession.selectList("MyCostIns.selClaimCardList", map);
		/*클레임교통비내역 현금정보출 시작*/
		List<TopMyCostInsCompositeVO> selClaimCashList = sqlSession.selectList("MyCostIns.selClaimCashList", map);
		
		/*추가경비내역 카드정보출 시작*/
		List<TopMyCostInsCompositeVO> selAddCardList = sqlSession.selectList("MyCostIns.selAddCardList", map);
		/*추가경비내역 현금정보출 시작*/
		List<TopMyCostInsCompositeVO> selAddCashList = sqlSession.selectList("MyCostIns.selAddCashList", map);
		
		
		/*수임건*/
		List<TopMyCostInsCompositeVO> getMyHelpRptList = sqlSession.selectList("MyCostIns.getMyHelpRptList", map);
		/*의뢰건*/
		List<TopMyCostInsCompositeVO> getMyHelpRptListAccept = sqlSession.selectList("MyCostIns.getMyHelpRptListAccept", map);
		/*수임건합계*/
		TopMyCostInsCompositeVO getMyHelpRptListSum = sqlSession.selectOne("MyCostIns.getMyHelpRptListSum", map);
		/*의뢰건합계*/
		TopMyCostInsCompositeVO getMyHelpRptListAcceptSum = sqlSession.selectOne("MyCostIns.getMyHelpRptListAcceptSum", map);
		
		/*카드정보 합계*/
		TopMyCostInsCompositeVO getMyCostCardSum = sqlSession.selectOne("MyCostIns.getMyCostCardSum", map);
		/*현금정보 합계*/
		TopMyCostInsCompositeVO getMyCostCashSum = sqlSession.selectOne("MyCostIns.getMyCostCashSum", map);
		/*클레임 교통비 내역 카드정보 합계*/
		TopMyCostInsCompositeVO getMyCostClaimCardSum = sqlSession.selectOne("MyCostIns.getMyCostClaimCardSum", map);
		/*클레임 교통비 내역 현금정보 합계*/
		TopMyCostInsCompositeVO getMyCostClaimCashSum = sqlSession.selectOne("MyCostIns.getMyCostClaimCashSum", map);
		/*추가경비내역 카드정보 합계*/
		TopMyCostInsCompositeVO getMyCostAddCardSum = sqlSession.selectOne("MyCostIns.getMyCostAddCardSum", map);
		/*추가내역 현금정보 합계*/
		TopMyCostInsCompositeVO getMyCostAddCashSum = sqlSession.selectOne("MyCostIns.getMyCostAddCashSum", map);		
		/*총 합계*/
		
		int sum_cost_bill_ea = 0;
		sum_cost_bill_ea += Integer.parseInt(getMyCostCardSum.getSum_cost_bill_ea());
		sum_cost_bill_ea += Integer.parseInt(getMyCostCashSum.getSum_cost_bill_ea());
		sum_cost_bill_ea += Integer.parseInt(getMyCostClaimCardSum.getSum_cost_bill_ea());
		sum_cost_bill_ea += Integer.parseInt(getMyCostClaimCashSum.getSum_cost_bill_ea());
		sum_cost_bill_ea += Integer.parseInt(getMyCostAddCardSum.getSum_cost_bill_ea());
		sum_cost_bill_ea += Integer.parseInt(getMyCostAddCashSum.getSum_cost_bill_ea());
				
		int sum_cost_pay_amt = 0;
		sum_cost_pay_amt += Integer.parseInt(getMyCostCardSum.getSum_cost_pay_amt());
		sum_cost_pay_amt += Integer.parseInt(getMyCostCashSum.getSum_cost_pay_amt());
		sum_cost_pay_amt += Integer.parseInt(getMyCostClaimCardSum.getSum_cost_pay_amt());
		sum_cost_pay_amt += Integer.parseInt(getMyCostClaimCashSum.getSum_cost_pay_amt());
		sum_cost_pay_amt += Integer.parseInt(getMyCostAddCardSum.getSum_cost_pay_amt());
		sum_cost_pay_amt += Integer.parseInt(getMyCostAddCashSum.getSum_cost_pay_amt());
		
		TopMyCostInsCompositeVO MyCostSum = new TopMyCostInsCompositeVO();
		MyCostSum.setSum_cost_bill_ea(String.valueOf(sum_cost_bill_ea));
		MyCostSum.setSum_cost_pay_amt(String.valueOf(sum_cost_pay_amt));
		
		//TopMyCostInsCompositeVO MyCostSum = sqlSession.selectOne("MyCostIns.MyCostSum", map);
        
        System.out.println("user_name:["+user_name+"]");
        
        model.addAttribute("user_name", user_name);
		model.addAttribute("team_name", team_name);
		model.addAttribute("selCardList", selCardList);
		model.addAttribute("selCashList", selCashList);
		model.addAttribute("selClaimCardList", selClaimCardList);
		model.addAttribute("selClaimCashList", selClaimCashList);
		model.addAttribute("getMyCostCardSum", getMyCostCardSum);
		model.addAttribute("getMyCostCashSum", getMyCostCashSum);
		model.addAttribute("getMyCostClaimCardSum", getMyCostClaimCardSum);
		model.addAttribute("getMyCostClaimCashSum", getMyCostClaimCashSum);
		model.addAttribute("MyCostSum", MyCostSum);
		model.addAttribute("getMyHelpRptList", getMyHelpRptList);
		model.addAttribute("getMyHelpRptListAccept", getMyHelpRptListAccept);
		model.addAttribute("getMyHelpRptListSum", getMyHelpRptListSum);
		model.addAttribute("getMyHelpRptListAcceptSum", getMyHelpRptListAcceptSum);
		model.addAttribute("selAddCardList", selAddCardList);
		model.addAttribute("selAddCashList", selAddCashList);
		model.addAttribute("getMyCostAddCardSum", getMyCostAddCardSum);
		model.addAttribute("getMyCostAddCashSum", getMyCostAddCashSum);
		
		String retURL = "top_individual/my_cost_print";
		
		if ("Y".equals(excelYN)){
			retURL = "top_individual/my_cost_print_excel";
		}
		
		return retURL;
		
	}
}
