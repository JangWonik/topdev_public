/*
*********************************************************
* Program ID	: 
* Program Name	: 
* Description	: 
* Author		: 
* Date			: 2016.06.09.
*********************************************************
*/
package kr.co.toplac.topindividual;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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

import kr.co.toplac.topstatistics.StatisticsNowVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;

@Controller
public class MyCostInsNewController {

	private static final Logger logger = LoggerFactory.getLogger(MyCostInsNewController.class);

	@Autowired
	private SqlSession sqlSession;

	/*
	*********************************************************
	* Program ID	: 
	* Program Name	: 
	* Description	: 
	* Author		: 
	* Date			: 2016.06.09.
	*********************************************************
	경비신청 처음 리스트 화면
	*/
	@RequestMapping(value = "myCostInsListNew", method = RequestMethod.GET)
	public String myCostInsListNew(Model model, HttpSession session, HttpServletRequest request
			, MyCostInsViewVO inVO) {

		logger.info("======= myCostInsListNew =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		/*
		String srch_flag = StringUtil.null2blank(request.getParameter("srch_flag"));
		if("".equals(srch_flag)){
			srch_flag = "1";
		}
		
		paramMap.put("srch_flag", srch_flag);
		*/
		
		if(inVO.getViewFromDate() == null || inVO.getViewFromDate().equals("")){
			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate");
			inVO.setViewFromDate(nowVO.getNow_from());
			inVO.setViewToDate(nowVO.getNow_to());
			inVO.setViewFromYear(nowVO.getYear_from());
			inVO.setViewToYear(nowVO.getYear_to());
			inVO.setCost_apply_date(nowVO.getToday());
			inVO.setSelect_class_no("0");
		}else{
			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate2", inVO);
			inVO.setViewFromDate(nowVO.getNow_from());
			inVO.setViewToDate(nowVO.getNow_to());
			inVO.setViewFromYear(nowVO.getYear_from());
			inVO.setViewToYear(nowVO.getYear_to());
			inVO.setCost_apply_date(nowVO.getToday());
		}
		inVO.setUser_no(mbrVo.getUser_no());
		inVO.setUser_name(mbrVo.getUser_name());
		inVO.setTeam_id(mbrVo.getTeam_id_main());
		inVO.setTeam_name(mbrVo.getTeam_name());
		inVO.setTeam_type(mbrVo.getTeam_type());
		
		String cost_gubun_flag = inVO.getCost_gubun_flag();
		
		//경비내역 건 가져오기
		List<MyCostInsListVO> getMyCostInsList = sqlSession.selectList("MyCostInsNewMapper.getMyCostInsNewList", inVO);
		
		//클레임교통비 건 가져오기 
		List<MyCostInsListVO> getMyCostInsClaimList = sqlSession.selectList("MyCostInsNewMapper.getMyCostInsClaimNewList", inVO);
		
		//추가경비내역 건 가져오기
		List<String> getMyCostInsAddList = sqlSession.selectList("MyCostInsNewMapper.getMyCostInsAddList", inVO);
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fromdate", inVO.getViewFromDate());
		map.put("todate", inVO.getViewToDate());
		map.put("fromYear", inVO.getViewFromYear());
		map.put("toYear", inVO.getViewToYear());
		map.put("user_no", inVO.getUser_no());

		/*수임건*/
		List<TopMyCostInsCompositeVO> getMyHelpRptList = sqlSession.selectList("MyCostIns.getMyHelpRptList", map);
		/*의뢰건*/
		List<TopMyCostInsCompositeVO> getMyHelpRptListAccept = sqlSession.selectList("MyCostIns.getMyHelpRptListAccept", map);
		/*수임건합계*/
		TopMyCostInsCompositeVO getMyHelpRptListSum = sqlSession.selectOne("MyCostIns.getMyHelpRptListSum", map);
		/*의뢰건합계*/
		TopMyCostInsCompositeVO getMyHelpRptListAcceptSum = sqlSession.selectOne("MyCostIns.getMyHelpRptListAcceptSum", map);

		TopMyCostInsCompositeVO getMyCostDepositInfo = sqlSession.selectOne("MyCostIns.getMyCostDepositInfo",map);

		if(getMyCostDepositInfo != null) {
			String cost_deposit_no = getMyCostDepositInfo.getCost_deposit_no();
			map.put("cost_deposit_no", cost_deposit_no);

			/*보고서 원본 파일 정보 추출 시작*/
			List<TopMyCostBillFileVO> myCostBillFileList  = sqlSession.selectList("MyCostIns.myCostBillFileList", map);
			model.addAttribute("myCostBillFileList", myCostBillFileList);
			/*보고서 원본 파일 정보 추출 끝*/
		}
		
		//===============================================
        // 뷰단 데이터 세팅
        //===============================================   		
//		model.addAttribute("srch_flaag", srch_flag);
		model.addAttribute("cost_gubun_flag", cost_gubun_flag);
		model.addAttribute("inVO", inVO);
		model.addAttribute("getMyCostInsList", getMyCostInsList);
		model.addAttribute("srchArg", paramMap);
		model.addAttribute("getMyCostInsClaimList", getMyCostInsClaimList);
		model.addAttribute("getMyCostInsAddList", getMyCostInsAddList);
		model.addAttribute("getMyHelpRptList", getMyHelpRptList);
		model.addAttribute("getMyHelpRptListAccept", getMyHelpRptListAccept);
		model.addAttribute("getMyHelpRptListSum", getMyHelpRptListSum);
		model.addAttribute("getMyHelpRptListAcceptSum", getMyHelpRptListAcceptSum);
		model.addAttribute("getMyCostDepositInfo", getMyCostDepositInfo);
		
		return "top_individual/my_cost_ins_new";
	}//myCostInsListNew

	@RequestMapping(value = "myCostInsNewAddOK", method = RequestMethod.POST)
	public void myCostInsAddOK(HttpSession session, HttpServletResponse response
			, MyCostInsViewVO inVO,HttpServletRequest request) {

		logger.info("======= myCostInsNewAddOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		StatisticsNowVO nowVO = sqlSession.selectOne("MyCostInsNewMapper.getMyCostInsNewDate", inVO);
		inVO.setViewFromDate(nowVO.getNow_from());
		inVO.setViewToDate(nowVO.getNow_to());
		inVO.setUser_no(mbrVo.getUser_no());
		inVO.setUser_name(mbrVo.getUser_name());
		inVO.setTeam_id(mbrVo.getTeam_id_main());
		inVO.setTeam_name(mbrVo.getTeam_name());
		inVO.setTeam_type(mbrVo.getTeam_type());

		if(inVO.getCost_pay_place() == null || inVO.getCost_pay_place().equals("")){
			inVO.setCost_pay_place("-");
		}
		if(inVO.getCost_involved_com() == null || inVO.getCost_involved_com().equals("")){
			inVO.setCost_involved_com("-");
		}
		if(inVO.getCost_involved_man() == null || inVO.getCost_involved_man().equals("")){
			inVO.setCost_involved_man("-");
		}
		if(inVO.getCost_memo() == null || inVO.getCost_memo().equals("")){
			inVO.setCost_memo("-");
		}
		if(inVO.getCost_class_no() == null || inVO.getCost_class_no().equals("")){
			inVO.setCost_class_no("999");
		}

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		String cost_gubun_flag = String.valueOf(paramMap.get("cost_gubun_flag"));
		int intMyCostInsNewAdd = 0;

		//추가경비내역-정산된 내역 조회 X. 경비내역,클레임교통비,추가경비내역 추가
		if(cost_gubun_flag.equals("3")) {
			intMyCostInsNewAdd = sqlSession.insert("MyCostInsNewMapper.myCostInsNewAdditionAdd", inVO);
			if(intMyCostInsNewAdd == 0){
				out.print("경비 내역 입력 오류가 발생하였습니다.\n물보험기획팀 전산파트로 문의하세요.");
				out.close();
				return;
			}
		}else {
			int intDepositCloseYN = 0;
			intDepositCloseYN = sqlSession.selectOne("MyCostInsNewMapper.getMyCostInsNewDepositCloseYN", inVO);
			if(intDepositCloseYN > 0){
				out.print("정산 된 내역이 존재하는 기간에는 등록이 안됩니다!");
				out.close();
				return;
			}
			
			intMyCostInsNewAdd = sqlSession.insert("MyCostInsNewMapper.myCostInsNewAdd", inVO);
			if(intMyCostInsNewAdd == 0){
				out.print("경비 내역 입력 오류가 발생하였습니다.\n물보험기획팀 전산파트로 문의하세요.");
				out.close();
				return;
			}
		}

		String strMyCostDepositNo = "";
		strMyCostDepositNo = sqlSession.selectOne("MyCostInsNewMapper.getMyCostInsNewDepositNo", inVO);
		inVO.setCost_deposit_no(strMyCostDepositNo);

		int intMyCostDepositAddOrUdt = 0;
		if(strMyCostDepositNo != null && !strMyCostDepositNo.equals("")){
			intMyCostDepositAddOrUdt = sqlSession.update("MyCostInsNewMapper.myCostInsNewDepositUdt", inVO);
		}else{
			intMyCostDepositAddOrUdt = sqlSession.insert("MyCostInsNewMapper.myCostInsNewDepositAdd", inVO);
		}
		if(intMyCostDepositAddOrUdt == 0){
			out.print("경비 내역 결제 정보 입력 오류가 발생하였습니다.\n물보험기획팀 전산파트로 문의하세요.");
			out.close();
			return;
		}

		out.print("경비 내역 입력이 완료 되었습니다.");
		out.close();
	}//myCostInsNewAddOK

	@RequestMapping(value = "myCostInsNewDelOK", method = RequestMethod.POST)
	public void myCostInsNewDelOK(HttpSession session, HttpServletResponse response
			, MyCostInsViewVO inVO) {

		logger.info("======= myCostInsNewDelOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		StatisticsNowVO nowVO = sqlSession.selectOne("MyCostInsNewMapper.getMyCostInsNewDate", inVO);
		inVO.setViewFromDate(nowVO.getNow_from());
		inVO.setViewToDate(nowVO.getNow_to());
		inVO.setUser_no(mbrVo.getUser_no());
		inVO.setUser_name(mbrVo.getUser_name());
		inVO.setTeam_id(mbrVo.getTeam_id_main());
		inVO.setTeam_name(mbrVo.getTeam_name());
		inVO.setTeam_type(mbrVo.getTeam_type());

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		int intMyCostInsNewDel = 0;
		intMyCostInsNewDel = sqlSession.delete("MyCostInsNewMapper.myCostInsNewDelMyCost", inVO);
		if(intMyCostInsNewDel == 0){
			out.print("경비 내역 삭제 오류가 발생하였습니다.\n물보험기획팀 전산파트로 문의하세요.");
			out.close();
			return;
		}

		String strMyCostDepositNo = "";
		strMyCostDepositNo = sqlSession.selectOne("MyCostInsNewMapper.getMyCostInsNewDepositNo", inVO);
		inVO.setCost_deposit_no(strMyCostDepositNo);

		int intMyCostDepositAddOrUdt = 0;
		if(strMyCostDepositNo != null && !strMyCostDepositNo.equals("")){
			intMyCostDepositAddOrUdt = sqlSession.update("MyCostInsNewMapper.myCostInsNewDepositUdt", inVO);
		}else{
			intMyCostDepositAddOrUdt = sqlSession.insert("MyCostInsNewMapper.myCostInsNewDepositAdd", inVO);
		}
		if(intMyCostDepositAddOrUdt == 0){
			out.print("경비 내역 결제 정보 입력 오류가 발생하였습니다.\n물보험기획팀 전산파트로 문의하세요.");
			out.close();
			return;
		}

		out.print("경비 내역 삭제가 완료 되었습니다.");
		out.close();
	}//myCostInsNewDelOK

	@RequestMapping(value = "myCostInsNewUdtOK", method = RequestMethod.POST)
	public void myCostInsNewUdtOK(HttpSession session, HttpServletResponse response
			, MyCostInsViewVO inVO, HttpServletRequest request) {

		logger.info("======= myCostInsNewUdtOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		StatisticsNowVO nowVO = sqlSession.selectOne("MyCostInsNewMapper.getMyCostInsNewDate", inVO);
		inVO.setViewFromDate(nowVO.getNow_from());
		inVO.setViewToDate(nowVO.getNow_to());
		inVO.setUser_no(mbrVo.getUser_no());
		inVO.setUser_name(mbrVo.getUser_name());
		inVO.setTeam_id(mbrVo.getTeam_id_main());
		inVO.setTeam_name(mbrVo.getTeam_name());
		inVO.setTeam_type(mbrVo.getTeam_type());

		if(inVO.getCost_pay_place() == null || inVO.getCost_pay_place().equals("")){
			inVO.setCost_pay_place("-");
		}
		if(inVO.getCost_involved_com() == null || inVO.getCost_involved_com().equals("")){
			inVO.setCost_involved_com("-");
		}
		if(inVO.getCost_involved_man() == null || inVO.getCost_involved_man().equals("")){
			inVO.setCost_involved_man("-");
		}
		if(inVO.getCost_memo() == null || inVO.getCost_memo().equals("")){
			inVO.setCost_memo("-");
		}

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		String cost_gubun_flag = inVO.getCost_gubun_flag();
//		System.out.println("@@@");
//		System.out.println(!cost_gubun_flag.equals("3"));
//		System.out.println(cost_gubun_flag);
		if(!cost_gubun_flag.equals("3")) {
			int intDepositCloseYN = 0;
			intDepositCloseYN = sqlSession.selectOne("MyCostInsNewMapper.getMyCostInsNewDepositCloseYN", inVO);
			if(intDepositCloseYN > 0){
				out.print("정산 된 내역이 존재하는 기간에는 등록이 안됩니다!");
				out.close();
				return;
			}
		}
		//해당월 경비내역 업데이트하기
		int intMyCostInsNewUdt = 0;
		if(cost_gubun_flag.equals("2")){
			intMyCostInsNewUdt = sqlSession.insert("MyCostInsNewMapper.myCostInsNewUdtMyCostClaim", inVO);	
		}else if(cost_gubun_flag.equals("1")){
			intMyCostInsNewUdt = sqlSession.insert("MyCostInsNewMapper.myCostInsNewUdtMyCost", inVO);
		}else if(cost_gubun_flag.equals("3")) {
			intMyCostInsNewUdt = sqlSession.insert("MyCostInsNewMapper.myCostInsAddUdtMyCost", inVO);
		}
		
		if(intMyCostInsNewUdt == 0){
			out.print("경비 내역 수정 오류가 발생하였습니다.\n물보험기획팀 전산파트로 문의하세요.");
			out.close();
			return;
		}

		String strMyCostDepositNo = "";
		strMyCostDepositNo = sqlSession.selectOne("MyCostInsNewMapper.getMyCostInsNewDepositNo", inVO);
		inVO.setCost_deposit_no(strMyCostDepositNo);

		int intMyCostDepositAddOrUdt = 0;
		if(strMyCostDepositNo != null && !strMyCostDepositNo.equals("")){
			intMyCostDepositAddOrUdt = sqlSession.update("MyCostInsNewMapper.myCostInsNewDepositUdt", inVO);
		}else{
			intMyCostDepositAddOrUdt = sqlSession.insert("MyCostInsNewMapper.myCostInsNewDepositAdd", inVO);
		}
		if(intMyCostDepositAddOrUdt == 0){
			out.print("경비 내역 결제 정보 입력 오류가 발생하였습니다.\n물보험기획팀 전산파트로 문의하세요.");
			out.close();
			return;
		}

		out.print("경비 내역 수정이 완료 되었습니다.");
		out.close();
	}//myCostInsNewUdtOK
	

}//class
