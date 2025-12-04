/*
*********************************************************
* Program ID	: PrimbizSuimListController
* Program Name	: PrimbizSuimListController
* Description	: 농작물 수임대장 리스트
* Author		: 
* Date			: 2016.06.09.
*********************************************************
*/
package kr.co.toplac.topprimbiz;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.etc.Damo;

@Controller
public class PrimBizRptDtlUdtController {

	private static final Logger logger = LoggerFactory.getLogger(PrimBizRptDtlUdtController.class);

	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value = "primBizRptDtlBscUdt", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> primBizRptDtlBscUdt(HttpSession session, HttpServletRequest request, TopPrimBizRptCompositeVO inVO) {
		//해당 컨트롤러 폼전송 방식에서 AJAX(JSON) 방식으로 변경
		//기존 리턴 페이지에 flag값 전송 방식으로 인하여
		//인보이스 수정 후, 다른 것 수정할 경우에도 계속 알림창이 뜸
		logger.info("======= primBizRptDtlBscUdt =======");

		/*
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || mbrVo.getUser_no() == ""){
			logger.info("primBizRptDtlBscUdt - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		*/

		inVO.setLog_user_no((String) session.getAttribute("user_no_Session"));
		inVO.setLog_ip(request.getRemoteAddr());
		
		Damo damo = new Damo(); //디아모 암호화 적용 클래스 생성
		if (inVO.getPolicyholder_ssn() != null || inVO.getPolicyholder_ssn() != ""){
			inVO.setPolicyholder_ssn( damo.encodeDamo(inVO.getPolicyholder_ssn()) );
		}
		if (inVO.getPolicyholder_tel() != null || inVO.getPolicyholder_tel() != ""){
			inVO.setPolicyholder_tel( damo.encodeDamo(inVO.getPolicyholder_tel()) );
		}
		if (inVO.getBeneficiary_ssn() != null || inVO.getBeneficiary_ssn() != ""){
			inVO.setBeneficiary_ssn( damo.encodeDamo(inVO.getBeneficiary_ssn()) );
		}
		if (inVO.getBeneficiary_tel() != null || inVO.getBeneficiary_tel() != ""){
			inVO.setBeneficiary_tel( damo.encodeDamo(inVO.getBeneficiary_tel()) );
		}
		if (inVO.getDamaged_tel() != null || inVO.getDamaged_tel() != ""){
			inVO.setDamaged_tel( damo.encodeDamo(inVO.getDamaged_tel()) );
		}
		if (inVO.getInvestigate_addr1() != null || inVO.getInvestigate_addr1() != ""){
			inVO.setInvestigate_addr1( damo.encodeDamo(inVO.getInvestigate_addr1()) );
		}
		
		/* number field - 0 setting, replace comma */
		if(inVO.getCommission_estimated() == null || inVO.getCommission_estimated().trim().equals("")){
			inVO.setCommission_estimated("0");
		}else if(inVO.getCommission_estimated() != null && !inVO.getCommission_estimated().trim().equals("")){
			inVO.setCommission_estimated(inVO.getCommission_estimated().trim().replaceAll(",", ""));
		}
		if(inVO.getAmt_estimated_damage() == null || inVO.getAmt_estimated_damage().trim().equals("")){
			inVO.setAmt_estimated_damage("0");
		}else if(inVO.getAmt_estimated_damage() != null && !inVO.getAmt_estimated_damage().trim().equals("")){
			inVO.setAmt_estimated_damage(inVO.getAmt_estimated_damage().trim().replaceAll(",", ""));
		}

		int bodyUdt = 0, headUdt = 0, headLogUdt = 0;
		bodyUdt = sqlSession.update("PrimBizRptDtlUdtMapper.updatePrimBizRptBody", inVO);
		if(bodyUdt > 0){
			headUdt = sqlSession.update("PrimBizRptDtlUdtMapper.updatePrimBizRptHead", inVO);
		}
		if(headUdt > 0){
			headLogUdt = sqlSession.insert("PrimBizRptDtlUdtMapper.primBizRptLogAdd", inVO);
		}
		
		HashMap<String,Object> resultMap = new HashMap<>();
		resultMap.put("result", headLogUdt);
		
		return resultMap;

//		return "redirect:/primBizRptDtl?suim_rpt_no="+inVO.getSuim_rpt_no()+"&saveFlag=bsc";
		
		
		
		
	}//primBizRptDtlBscUdt

	
	
	
	@RequestMapping(value = "primBizRptDtlInvUdt", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> primBizRptDtlInvUdt(HttpSession session, HttpServletRequest request, TopPrimBizRptCompositeVO inVO) {
		//해당 컨트롤러 폼전송 방식에서 AJAX(JSON) 방식으로 변경
		//기존 리턴 페이지에 flag값 전송 방식으로 인하여
		//인보이스 수정 후, 다른 것 수정할 경우에도 계속 알림창이 뜸
		logger.info("======= primBizRptDtlInvUdt =======");
		/*
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || mbrVo.getUser_no() == ""){
			logger.info("primBizRptDtlInvUdt - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		*/
		/*ip 얻기 시작*/
		HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		String ip = req.getHeader("X-FORWARDED-FOR");
		
		if (ip == null){
			ip = req.getRemoteAddr(); 
		}
		/*ip 얻기 끝*/
		
		inVO.setLog_user_no((String) session.getAttribute("user_no_Session"));
		inVO.setLog_ip(ip);
		/* number field - 0 setting, replace comma */
		if(inVO.getSuim_rpt_ea() == null || inVO.getSuim_rpt_ea().trim().equals("")){
			inVO.setSuim_rpt_ea("0");
		}else if(inVO.getSuim_rpt_ea() != null && !inVO.getSuim_rpt_ea().trim().equals("")){
			inVO.setSuim_rpt_ea(inVO.getSuim_rpt_ea().trim().replaceAll(",", ""));
		}
		if(inVO.getAmt_estimated_damage() == null || inVO.getAmt_estimated_damage().trim().equals("")){
			inVO.setAmt_estimated_damage("0");
		}else if(inVO.getAmt_estimated_damage() != null && !inVO.getAmt_estimated_damage().trim().equals("")){
			inVO.setAmt_estimated_damage(inVO.getAmt_estimated_damage().trim().replaceAll(",", ""));
		}
		if(inVO.getAmt_reduction() == null || inVO.getAmt_reduction().trim().equals("")){
			inVO.setAmt_reduction("0");
		}else if(inVO.getAmt_reduction() != null && !inVO.getAmt_reduction().trim().equals("")){
			inVO.setAmt_reduction(inVO.getAmt_reduction().trim().replaceAll(",", ""));
		}
		if(inVO.getAmt_claimed() == null || inVO.getAmt_claimed().trim().equals("")){
			inVO.setAmt_claimed("0");
		}else if(inVO.getAmt_claimed() != null && !inVO.getAmt_claimed().trim().equals("")){
			inVO.setAmt_claimed(inVO.getAmt_claimed().trim().replaceAll(",", ""));
		}
		if(inVO.getAmt_settlement() == null || inVO.getAmt_settlement().trim().equals("")){
			inVO.setAmt_settlement("0");
		}else if(inVO.getAmt_settlement() != null && !inVO.getAmt_settlement().trim().equals("")){
			inVO.setAmt_settlement(inVO.getAmt_settlement().trim().replaceAll(",", ""));
		}
		if(inVO.getAmt_self_pay() == null || inVO.getAmt_self_pay().trim().equals("")){
			inVO.setAmt_self_pay("0");
		}else if(inVO.getAmt_self_pay() != null && !inVO.getAmt_self_pay().trim().equals("")){
			inVO.setAmt_self_pay(inVO.getAmt_self_pay().trim().replaceAll(",", ""));
		}
		if(inVO.getAmt_insu_payment() == null || inVO.getAmt_insu_payment().trim().equals("")){
			inVO.setAmt_insu_payment("0");
		}else if(inVO.getAmt_insu_payment() != null && !inVO.getAmt_insu_payment().trim().equals("")){
			inVO.setAmt_insu_payment(inVO.getAmt_insu_payment().trim().replaceAll(",", ""));
		}
		if(inVO.getAmt_basic() == null || inVO.getAmt_basic().trim().equals("")){
			inVO.setAmt_basic("0");
		}else if(inVO.getAmt_basic() != null && !inVO.getAmt_basic().trim().equals("")){
			inVO.setAmt_basic(inVO.getAmt_basic().trim().replaceAll(",", ""));
		}
		if(inVO.getAmt_daily() == null || inVO.getAmt_daily().trim().equals("")){
			inVO.setAmt_daily("0");
		}else if(inVO.getAmt_daily() != null && !inVO.getAmt_daily().trim().equals("")){
			inVO.setAmt_daily(inVO.getAmt_daily().trim().replaceAll(",", ""));
		}
		if(inVO.getAmt_traffic() == null || inVO.getAmt_traffic().trim().equals("")){
			inVO.setAmt_traffic("0");
		}else if(inVO.getAmt_traffic() != null && !inVO.getAmt_traffic().trim().equals("")){
			inVO.setAmt_traffic(inVO.getAmt_traffic().trim().replaceAll(",", ""));
		}
		if(inVO.getAmt_counsel() == null || inVO.getAmt_counsel().trim().equals("")){
			inVO.setAmt_counsel("0");
		}else if(inVO.getAmt_counsel() != null && !inVO.getAmt_counsel().trim().equals("")){
			inVO.setAmt_counsel(inVO.getAmt_counsel().trim().replaceAll(",", ""));
		}
		if(inVO.getAmt_etc() == null || inVO.getAmt_etc().trim().equals("")){
			inVO.setAmt_etc("0");
		}else if(inVO.getAmt_etc() != null && !inVO.getAmt_etc().trim().equals("")){
			inVO.setAmt_etc(inVO.getAmt_etc().trim().replaceAll(",", ""));
		}

		int bodyUdt = 0, headUdt = 0, headLogUdt = 0, invUdt = 0, invLogUdt = 0;
		bodyUdt = sqlSession.update("PrimBizRptDtlUdtMapper.updatePrimBizRptEndBody", inVO);
		if(bodyUdt > 0){
			headUdt = sqlSession.update("PrimBizRptDtlUdtMapper.updatePrimBizRptEndHead", inVO);
		}
		if(headUdt > 0){
			headLogUdt = sqlSession.insert("PrimBizRptDtlUdtMapper.primBizRptLogAdd", inVO);
		}
		if(headLogUdt > 0){
			invUdt = sqlSession.update("PrimBizRptDtlUdtMapper.updatePrimBizRptEndInv", inVO);
		}
		if(invUdt > 0){
			invLogUdt = sqlSession.insert("PrimBizRptDtlUdtMapper.primBizInvLogAdd", inVO);
		}
		
		HashMap<String,Object> resultMap = new HashMap<>();
		resultMap.put("result", invLogUdt);
		
//		return "redirect:/primBizRptDtl?suim_rpt_no="+inVO.getSuim_rpt_no()+"&saveFlag=inv";
		return resultMap;
	}//primBizRptDtlInvUdt
	
	
	

	@RequestMapping(value = "primBizRptDtlShaAdd", method = RequestMethod.POST)
	public void primBizRptDtlShaAdd(HttpSession session, HttpServletResponse response, TopPrimBizRptCompositeVO inVO) {

		logger.info("======= primBizRptDtlShaAdd =======");

		/* number field - 0 setting, replace comma */
		if(inVO.getShare_amt_basic() == null || inVO.getShare_amt_basic().trim().equals("")){
			inVO.setShare_amt_basic("0");
		}else if(inVO.getShare_amt_basic() != null && !inVO.getShare_amt_basic().trim().equals("")){
			inVO.setShare_amt_basic(inVO.getShare_amt_basic().trim().replaceAll(",", ""));
		}
		if(inVO.getShare_amt_daily() == null || inVO.getShare_amt_daily().trim().equals("")){
			inVO.setShare_amt_daily("0");
		}else if(inVO.getShare_amt_daily() != null && !inVO.getShare_amt_daily().trim().equals("")){
			inVO.setShare_amt_daily(inVO.getShare_amt_daily().trim().replaceAll(",", ""));
		}
		if(inVO.getShare_amt_traffic() == null || inVO.getShare_amt_traffic().trim().equals("")){
			inVO.setShare_amt_traffic("0");
		}else if(inVO.getShare_amt_traffic() != null && !inVO.getShare_amt_traffic().trim().equals("")){
			inVO.setShare_amt_traffic(inVO.getShare_amt_traffic().trim().replaceAll(",", ""));
		}
		if(inVO.getShare_amt_counsel() == null || inVO.getShare_amt_counsel().trim().equals("")){
			inVO.setShare_amt_counsel("0");
		}else if(inVO.getShare_amt_counsel() != null && !inVO.getShare_amt_counsel().trim().equals("")){
			inVO.setShare_amt_counsel(inVO.getShare_amt_counsel().trim().replaceAll(",", ""));
		}
		if(inVO.getShare_amt_etc() == null || inVO.getShare_amt_etc().trim().equals("")){
			inVO.setShare_amt_etc("0");
		}else if(inVO.getShare_amt_etc() != null && !inVO.getShare_amt_etc().trim().equals("")){
			inVO.setShare_amt_etc(inVO.getShare_amt_etc().trim().replaceAll(",", ""));
		}
		if(inVO.getShare_ea() == null || inVO.getShare_ea().trim().equals("")){
			inVO.setShare_ea("0");
		}else if(inVO.getShare_ea() != null && !inVO.getShare_ea().trim().equals("")){
			inVO.setShare_ea(inVO.getShare_ea().trim().replaceAll(",", ""));
		}

		int successCnt = 0;
		successCnt = sqlSession.insert("PrimBizRptDtlUdtMapper.insertPrimBizShare", inVO);
		if(successCnt > 0){
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("serial_no", inVO.getSerial_no());
			map.put("reg_user_no", (String) session.getAttribute("user_no_Session"));
			map.put("reg_type", "1");
			sqlSession.insert("PrimBizRptDtlUdtMapper.insPrimBizInvShareLogByMap", map);
		}

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		out.print(successCnt);
		out.close();
	}//primBizRptDtlShaAdd

	@RequestMapping(value = "primBizRptDtlShaUdt", method = RequestMethod.POST)
	public void primBizRptDtlShaUdt(HttpSession session, HttpServletResponse response, TopPrimBizRptCompositeVO inVO) {

		logger.info("======= primBizRptDtlShaUdt =======");

		/* number field - 0 setting, replace comma */
		if(inVO.getShare_amt_basic() == null || inVO.getShare_amt_basic().trim().equals("")){
			inVO.setShare_amt_basic("0");
		}else if(inVO.getShare_amt_basic() != null && !inVO.getShare_amt_basic().trim().equals("")){
			inVO.setShare_amt_basic(inVO.getShare_amt_basic().trim().replaceAll(",", ""));
		}
		if(inVO.getShare_amt_daily() == null || inVO.getShare_amt_daily().trim().equals("")){
			inVO.setShare_amt_daily("0");
		}else if(inVO.getShare_amt_daily() != null && !inVO.getShare_amt_daily().trim().equals("")){
			inVO.setShare_amt_daily(inVO.getShare_amt_daily().trim().replaceAll(",", ""));
		}
		if(inVO.getShare_amt_traffic() == null || inVO.getShare_amt_traffic().trim().equals("")){
			inVO.setShare_amt_traffic("0");
		}else if(inVO.getShare_amt_traffic() != null && !inVO.getShare_amt_traffic().trim().equals("")){
			inVO.setShare_amt_traffic(inVO.getShare_amt_traffic().trim().replaceAll(",", ""));
		}
		if(inVO.getShare_amt_counsel() == null || inVO.getShare_amt_counsel().trim().equals("")){
			inVO.setShare_amt_counsel("0");
		}else if(inVO.getShare_amt_counsel() != null && !inVO.getShare_amt_counsel().trim().equals("")){
			inVO.setShare_amt_counsel(inVO.getShare_amt_counsel().trim().replaceAll(",", ""));
		}
		if(inVO.getShare_amt_etc() == null || inVO.getShare_amt_etc().trim().equals("")){
			inVO.setShare_amt_etc("0");
		}else if(inVO.getShare_amt_etc() != null && !inVO.getShare_amt_etc().trim().equals("")){
			inVO.setShare_amt_etc(inVO.getShare_amt_etc().trim().replaceAll(",", ""));
		}
		if(inVO.getShare_ea() == null || inVO.getShare_ea().trim().equals("")){
			inVO.setShare_ea("0");
		}else if(inVO.getShare_ea() != null && !inVO.getShare_ea().trim().equals("")){
			inVO.setShare_ea(inVO.getShare_ea().trim().replaceAll(",", ""));
		}
		
		if(inVO.getShare_workload_ea() == null || inVO.getShare_workload_ea().trim().equals("")){
			inVO.setShare_workload_ea("0");
		}else if(inVO.getShare_workload_ea() != null && !inVO.getShare_workload_ea().trim().equals("")){
			inVO.setShare_workload_ea(inVO.getShare_workload_ea().trim().replaceAll(",", ""));
		}


		
		
		int successCnt = 0;
		successCnt = sqlSession.update("PrimBizRptDtlUdtMapper.updatePrimBizShare", inVO);
		if(successCnt > 0){
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("serial_no", inVO.getSerial_no());
			map.put("reg_user_no", (String) session.getAttribute("user_no_Session"));
			map.put("reg_type", "2");
			sqlSession.insert("PrimBizRptDtlUdtMapper.insPrimBizInvShareLogByMap", map);
		}

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		out.print(successCnt);
		out.close();
	}//primBizRptDtlShaUdt

	@RequestMapping(value = "primBizRptDtlShaDel", method = RequestMethod.POST)
	public void primBizRptDtlShaDel(HttpSession session, HttpServletResponse response, TopPrimBizRptCompositeVO vo) {

		logger.info("======= primBizRptDtlShaDel =======");

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("serial_no", vo.getSerial_no());
		map.put("reg_user_no", (String) session.getAttribute("user_no_Session"));
		map.put("reg_type", "3");
		sqlSession.insert("PrimBizRptDtlUdtMapper.insPrimBizInvShareLogByMap", map);

		int successCnt = 0;
		successCnt = sqlSession.delete("PrimBizRptDtlUdtMapper.deletePrimBizShare", vo);

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		out.print(successCnt);
		out.close();
	}//primBizRptDtlShaDel

}//end of class
