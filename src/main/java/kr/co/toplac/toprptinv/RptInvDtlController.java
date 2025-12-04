package kr.co.toplac.toprptinv;

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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;

@Controller
public class RptInvDtlController {

	private static final Logger logger = LoggerFactory.getLogger(RptInvDtlController.class);

	@Autowired
	private SqlSession sqlSession;
	
	/**
	 * 인보이스 작업상태 확인
	 * @param model
	 * @param session
	 * @param response
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "checkInvoiceWorkStateEnable", method = RequestMethod.POST)
	@ResponseBody 
	public Map<String, Object> checkInvoiceWorkStateEnable(Model model, HttpSession session, HttpServletResponse response, HttpServletRequest request) {
		logger.info("======= checkInvoiceWorkStateEnable =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String user_no = paramMap.get("user_no").toString();		
	
		Map<String, Object> resultMap = sqlSession.selectOne("InvoiceDtlMapper.getInvWorkStateInfo", paramMap);
		
		String work_user_no = String.valueOf(resultMap.get("work_user_no"));
		String work_state =  String.valueOf(resultMap.get("work_state"));		
		
		if( "0".equals(work_state) ) {
			resultMap.put("result", true);
		}else{
			if( work_user_no.equals(user_no) ) {		//작업자와 접속자가 같으면
				resultMap.put("result", true);
			}else{												//작업자와 접속자가 다르면서 작업중인 상태 (수정불가)
				resultMap.put("result", false);
			}
		}
		
        return resultMap; 
	}
	
	/**
	 * 인보이스 작업상태 확인
	 * @param model
	 * @param session
	 * @param response
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "checkInvoiceWorkState", method = RequestMethod.POST)
	@ResponseBody 
	public Map<String, Object> checkInvoiceWorkState(Model model, HttpSession session, HttpServletResponse response, HttpServletRequest request) {
		logger.info("======= checkInvoiceWorkState =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
		Map<String, Object> resultMap = sqlSession.selectOne("InvoiceDtlMapper.getInvWorkStateInfo", paramMap);
		
        return resultMap; 
	}
	
	/**
	 * 인보이스 작업상태 변경
	 * @param model
	 * @param session
	 * @param response
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "updateInvoiceWorkState", method = RequestMethod.POST)
	@ResponseBody 
	public Map<String, Object> updateInvoiceWorkState(Model model, HttpSession session, HttpServletResponse response, HttpServletRequest request) {
		logger.info("======= updateInvoiceWorkState =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		Map<String, Object> resultMap = new HashMap<String,Object>();		
		
		String sAction = paramMap.get("action_flag").toString();
		String user_no = paramMap.get("user_no").toString();
		
		Map<String, Object> sQryMap = sqlSession.selectOne("InvoiceDtlMapper.getInvWorkStateInfo", paramMap);
				
		String work_state = "";
		work_state = sQryMap.get("work_state").toString();
		
		String work_user_no = "";
		work_user_no = sQryMap.get("work_user_no").toString();
		
		//작업중으로 상태 값을 변경한 경우
		if( "work_ing".equals(sAction) ) {			
			//대기상태인경우
			if( "0".equals(work_state) ) {
				//작업중으로 상태를 변경하고 작업자 사번을 업데이트 한다.
				paramMap.put("work_state", 1);				
				sqlSession.update("InvoiceDtlMapper.updateInvWorkStateInfo",paramMap);
				//갱신후에 다시 값을 가져온다.
				resultMap = sqlSession.selectOne("InvoiceDtlMapper.getInvWorkStateInfo", paramMap);
			}
		}else if( "work_standby".equals(sAction) ) {
			//작업중인경우
			if( "1".equals(work_state) ) {
				//현재 작업자가 현재 로그인 사용자인지 확인한다. (작업자가 다른경우 갱신 불가)
				if( user_no.equals(work_user_no) ) {
					paramMap.put("work_state", 0);
					paramMap.put("user_no", 0);
					sqlSession.update("InvoiceDtlMapper.updateInvWorkStateInfo",paramMap);					
					resultMap = sqlSession.selectOne("InvoiceDtlMapper.getInvWorkStateInfo", paramMap);
					resultMap.put("result", 1);
				}else{
					//현재 작업자와 로그인 사용자가 달라 갱신 불가
					resultMap.put("work_user_nm", sQryMap.get("work_user_nm").toString());
					resultMap.put("result", 9999);
				}
			}
		}
		
        return resultMap; 
	}	
    
	
	@RequestMapping(value = "/ajax/ajax_rpt_tax_dtl")			//세금계산서 상세페이지 값가져오기
    public String reportIssueSamsungJemul(HttpServletRequest request, Model model){		    	

    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String cont_edit_type = request.getParameter("cont_edit_type") != null ? request.getParameter("cont_edit_type") : "view";
    	
    	String suim_rpt_no = paramMap.get("suimRptNo").toString();
    	
    	int rptAmtTotal = Integer.parseInt(paramMap.get("rptAmtTotal").toString());
    	
    	String tax_edit_end = paramMap.get("tax_edit_end").toString();
    	
    	List<TopRptInvTaxBean> taxList = sqlSession.selectList("InvoiceDtlMapper.getInvTaxList", suim_rpt_no);    	
    	
    	//계산서 합계
    	int nSum_tax = 0;    	
    	
    	//일치여부 (O,X)
    	String sChk_tax = "X";
    	
    	//입금합계
    	int nSum_deposit = 0;
    	
    	//계산서, 입금 합계금액 계산
    	for( int i = 0; i < taxList.size(); i++) {
    		nSum_tax += Integer.parseInt(taxList.get(i).getPublish_amount());
    		nSum_deposit += Integer.parseInt(taxList.get(i).getDeposit_amount());
    	}
    	
    	if( nSum_tax == rptAmtTotal ) {
    		sChk_tax = "O";
    	}
    	
    	//미수잔액
    	int nSum_outpay = 0;
    	
    	nSum_outpay = nSum_tax - nSum_deposit; 
    	
    	model.addAttribute("sum_tax", nSum_tax);
    	model.addAttribute("chk_tax", sChk_tax);
    	model.addAttribute("sum_deposit", nSum_deposit);
    	model.addAttribute("sum_outpay", nSum_outpay);
    	   	
    	model.addAttribute("tax_edit_end", tax_edit_end);
    	model.addAttribute("suim_rpt_no", suim_rpt_no);
    	model.addAttribute("cont_edit_type", cont_edit_type);
    	model.addAttribute("taxList", taxList);
    	
    	String sUrl = "top_rpt_inv/ajax/ajax_rpt_tax_dtl";
    	
    	return sUrl;
    }
	
	/**
	 * 세금계산서 작성 팝업창
	 * @param model
	 * @param session
	 * @param no
	 * @return
	 */
	
	@RequestMapping(value = "rptTaxDtl", method = RequestMethod.GET)
	public String rptTaxDtl(Model model, HttpSession session, String no) {

		logger.info("======= rptTaxDtl =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_8().equals("0") ){
			logger.info("rptInvDtl - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		TopRptInvCompositeVO invoiceDtl = sqlSession.selectOne("InvoiceDtlMapper.getInvoiceDtl", no);
		model.addAttribute("invoiceDtl", invoiceDtl);
		
		String suim_rpt_no = invoiceDtl.getSuim_rpt_no();
		
		int nTaxListCnt = sqlSession.selectOne("InvoiceDtlMapper.getInvTaxCnt", suim_rpt_no);
		
		//창을 호출 할때는 view 모드로 호출한다.
		model.addAttribute("cont_edit_type", "view");
		model.addAttribute("taxListCnt", nTaxListCnt);
		
		return "top_rpt_inv/rpt_tax_dtl";
	}//rptInvDt
	
	/**
	 * 세금계산서 갯수 체크 컨트롤러
	 * @param request
	 * @param model
	 * @return
	 */	
	@RequestMapping(value="/invTaxCnt")
    @ResponseBody
    public int invTaxCnt(HttpServletRequest request, Model model) {
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String suim_rpt_no = paramMap.get("suimRptNo").toString();
    	    	
    	int nTaxListCnt = sqlSession.selectOne("InvoiceDtlMapper.getInvTaxCnt", suim_rpt_no);
    	
    	logger.info("======== invTaxDelete ("+nTaxListCnt+") ========");
    	
    	return nTaxListCnt;
    }
	
	/**
	 * 세금계산서 작업상태 업데이트
	 * @param request
	 * @param model
	 * @return
	 */	
	@RequestMapping(value="/invTaxUpdateWork")
    @ResponseBody
    public int invTaxUpdateWork(HttpServletRequest request, Model model) {
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	int upCnt = sqlSession.update("InvoiceDtlMapper.updateTaxWork", paramMap);
    	
    	logger.info("======== invTaxUpdateWork ("+upCnt+") ========");
    	
    	return upCnt;
    }
	
	/**
	 * 세금계산서 삭제 컨트롤러
	 * @param request
	 * @param model
	 * @return
	 */	
	@RequestMapping(value="/invTaxDelete")
    @ResponseBody
    public int invTaxDelete(HttpServletRequest request, Model model) {
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	int delCnt = sqlSession.delete("InvoiceDtlMapper.deleteInvTaxNo", paramMap);
    	
    	logger.info("======== invTaxDelete ("+delCnt+") ========");
    	
    	return delCnt;
    }
	
	/**
	 * 세금계산서 정보 업데이트 컨트롤러
	 * @param request
	 * @param model
	 * @return
	 */	
	@RequestMapping(value="/invTaxUpdate")
    @ResponseBody
    public int invTaxUpdate(HttpServletRequest request, Model model) {
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	int udtCnt = 0;
    	
    	String [] sTemp = request.getParameterValues("taxList");			//총괄표에서 넘어온 배열
    	String [] splTemp = null;					//배열처리 임시변수
    	
    	String sSuim_rpt_no = request.getParameter("suim_rpt_no").toString();								//보고서번호
    	
    	String sPublish_date = "";						//발행일자
    	String sPublish_amount = "";				//발행금액
    	String sDeposit_date = "";					//입금일자 
    	String sDeposit_amount = "";				//입금액
    	
		//추가하기전에 삭제 한다.
		//sqlSession.update("RptIssueMapper.deleteRptIssueSummaryNumLotteTotal", paramMap);
    	
    	sqlSession.delete("InvoiceDtlMapper.deleteInvTax", sSuim_rpt_no);
		
		for(int i=0; i < sTemp.length; i++) {
			
			splTemp = sTemp[i].split("\\|");			
			sPublish_date = splTemp[0];
			sPublish_amount = splTemp[1];
			sDeposit_date = splTemp[2];
			sDeposit_amount = splTemp[3];
			
			//System.out.println(sSuim_rpt_no+" : "+sPublish_date+" : "+sPublish_amount+ " : "+sDeposit_date+" : "+sDeposit_amount);
			
			paramMap.put("suim_rpt_no", sSuim_rpt_no);
			paramMap.put("publish_date", sPublish_date);
			paramMap.put("publish_amount", StringUtil.removeComma(sPublish_amount));
			paramMap.put("deposit_date", sDeposit_date);
			paramMap.put("deposit_amount", StringUtil.removeComma(sDeposit_amount));
			
			sqlSession.insert("InvoiceDtlMapper.insertInvTax", paramMap);			
		}
		
		udtCnt = sTemp.length; 
    	
    	logger.info("======== invTaxUpdate ("+udtCnt+") ========");
    	
    	return udtCnt;
    }
	
	@RequestMapping(value = "updatePtnrTaxMbr", method = RequestMethod.POST)
	@ResponseBody 
	public Map<String, Object> updatePtnrTaxMbr(Model model, HttpSession session, HttpServletResponse response, HttpServletRequest request) {
		logger.info("======= updatePtnrTaxMbr =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		String ptnr_tax_mbr_nm = paramMap.get("ptnr_tax_mbr_nm").toString();		
		
		sqlSession.update("InvoiceDtlMapper.updatePtnrTaxMbrNm",paramMap);		
		
		resultMap.put("ptnr_tax_nm", ptnr_tax_mbr_nm);
		
        return resultMap; 
	}

	/*
	*********************************************************
	* Program ID	: 
	* Program Name	: 
	* Description	: 
	* Author		: 이동익
	* Date			: 2016.05.02.
	*********************************************************
	*/
	@RequestMapping(value = "rptInvDtl", method = RequestMethod.GET)
	public String rptInvDtl(Model model, HttpSession session, String no) {

		logger.info("======= rptInvDtl =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_8().equals("0") ){
			logger.info("rptInvDtl - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		TopRptInvCompositeVO invoiceDtl = sqlSession.selectOne("InvoiceDtlMapper.getInvoiceDtl", no);
		model.addAttribute("invoiceDtl", invoiceDtl);

		List<TopRptInvLogVO> invoiceLogList = sqlSession.selectList("InvoiceDtlMapper.getInvoiceLogList", no);
		model.addAttribute("invoiceLogList", invoiceLogList);

		return "top_rpt_inv/rpt_inv_dtl";
	}//rptInvDtl

	@RequestMapping(value = "rptInvUdtOK", method = RequestMethod.POST)
	public void rptInvUdtOK(HttpSession session, HttpServletResponse response, HttpServletRequest request, TopRptInvDtlViewVO viewVO ) {
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

		logger.info("======= rptInvUdtOK =======");

		String reg_user_no = (String) session.getAttribute("user_no_Session");
		viewVO.setRegUserNo(reg_user_no);
		int successCnt = 0;

		if(viewVO.getAmtBasic() == null || viewVO.getAmtBasic().equals("")){
			viewVO.setAmtBasic("0");
		}
		if(viewVO.getAmtDaily() == null || viewVO.getAmtDaily().equals("")){
			viewVO.setAmtDaily("0");
		}
		if(viewVO.getAmtTraffic() == null || viewVO.getAmtTraffic().equals("")){
			viewVO.setAmtTraffic("0");
		}
		if(viewVO.getAmtCounsel() == null || viewVO.getAmtCounsel().equals("")){
			viewVO.setAmtCounsel("0");
		}
		if(viewVO.getAmtEtc() == null || viewVO.getAmtEtc().equals("")){
			viewVO.setAmtEtc("0");
		}
		
		String deposit_date = viewVO.getDepositDate();
		String tax_date = viewVO.getTaxDate();
		String tax_invoice_no = viewVO.getTaxNo();
		
		//기존 세금계산서 번호		
		String orgTaxNo = "";		
		orgTaxNo = sqlSession.selectOne("InvoiceDtlMapper.selectInvInvoiceNo", viewVO);
		
		//기존 세금계산서 No 가 없는 경우
		if( "".equals(orgTaxNo) ) {
			if( !"".equals(deposit_date) || !"".equals(tax_date)) {		//입금일이나 세금계산서 일자중 하나라도 입력된 경우는 자동으로 세금계산서 No를 넣어준다. 
				//세금계산서 No를 인보이스킷값으로 갱신한다.
				sqlSession.update("InvoiceDtlMapper.updateInvInvoiceNoAuto", viewVO);
			}
			
			if( !"".equals(tax_invoice_no) ){
				//세금계산서 No를 입력값으로 갱신한다.				
				sqlSession.update("InvoiceDtlMapper.updateInvInvoiceNoData", viewVO);
			}
			
		}else{			//기존 세금계산서 값이 있는경우
			if( "".equals(tax_invoice_no) ) {		//입력폼의 세금계산서 No를 삭제한 경우
				//세금계산서 No를 빈값으로 갱신한다.
				sqlSession.update("InvoiceDtlMapper.updateInvInvoiceNoEmpty", viewVO);
			}else{
				//세금계산서 No를 입력값으로 갱신한다.				
				sqlSession.update("InvoiceDtlMapper.updateInvInvoiceNoData", viewVO);
			}
		}

		successCnt = sqlSession.update("InvoiceDtlMapper.updateRptInvDtl", viewVO);
		if(successCnt > 0){
			sqlSession.insert("InvoiceDtlMapper.insertRptInvLog", viewVO);
		}
				
		//입금일 수정 여부 체크 시작
		int nCnt = 0;
		int nCnt_sub = 0;
		int nEnd_chk = 0;
		//인보이스 합계금액
    	int nTotal_amt = 0;
    	
		String suim_rpt_no = viewVO.getSuimRptNo();
		paramMap.put("suim_rpt_no", suim_rpt_no);
		
		//인보이스 합계금액을 가져온다.
		nTotal_amt = sqlSession.selectOne("InvoiceDtlMapper.getInvTotalAmt", suim_rpt_no);
		
		//입금일자가 입력 된 경우만 처리한다.  
		if(!"".equals(deposit_date)) {
			
			paramMap.put("deposit_date", deposit_date);
			
			//세금계산서 테이블에 기존에 등록된 값을 체크한다.    			
			nCnt = sqlSession.selectOne("InvoiceDtlMapper.getInvTaxCnt", suim_rpt_no);
			
			//입금액 신규추가
			paramMap.put("deposit_amount", nTotal_amt);
			
			//신규 세금계산서 테이블 정보 입력
			if( nCnt == 0 ) {
				paramMap.put("publish_amount", 0);
				sqlSession.insert("InvoiceDtlMapper.insertInvTax", paramMap);				    				
			}else {    				
				//기존 입금일자 등록값이 있는지 확인한다.
				nCnt_sub = sqlSession.selectOne("InvoiceDtlMapper.getInvTaxDepositCnt", suim_rpt_no);
				if( nCnt_sub == 0 ){		//기존등록일자와 금액이 없는 경우만 update 한다.
					sqlSession.update("InvoiceDtlMapper.updateInvTaxDeposit", paramMap);					
				}
			}
			
			//인보이스의 세금계산서, 입금액 합을 비교하여 동일하면 작업완료로 표시한다.
			nEnd_chk = sqlSession.selectOne("InvoiceDtlMapper.chkInvTaxAmountSum", suim_rpt_no);    			    			
			
			//nEnd_chk : 1 (동일), 0 (합계값이 다름)
			paramMap.put("tax_edit_end", nEnd_chk);
			sqlSession.update("InvoiceDtlMapper.updateTaxWork", paramMap);
		}
		
		//세금계산서 수정 여부 체크 시작
		nCnt = 0;
		nCnt_sub = 0;
		nEnd_chk = 0;		
		
		if(!"".equals(tax_date)) {
			paramMap.put("publish_date", tax_date);
			
			//세금계산서 테이블에 기존에 등록된 값을 체크한다.    			
			nCnt = sqlSession.selectOne("InvoiceDtlMapper.getInvTaxCnt", suim_rpt_no);		
			
			//세금계산서 확인금액 신규추가
			paramMap.put("publish_amount", nTotal_amt);
			
			//신규 세금계산서 테이블 정보 입력
			if( nCnt == 0 ) {
				//입금금액은 초기금액으로 입력
				paramMap.put("deposit_amount", 0);
				sqlSession.insert("InvoiceDtlMapper.insertInvTax", paramMap);    				
			}else {    				
				//기존 입금일자 등록값이 있는지 확인한다.
				nCnt_sub = sqlSession.selectOne("InvoiceDtlMapper.getInvTaxPublishCnt", suim_rpt_no);
				if( nCnt_sub == 0 ){		//기존 세금계산서 일자와 금액이 없는 경우만 update 한다.
					sqlSession.update("InvoiceDtlMapper.updateInvTaxPublish", paramMap);
				}
			}
			
			//인보이스의 세금계산서, 입금액 합을 비교하여 동일하면 작업완료로 표시한다.
			nEnd_chk = sqlSession.selectOne("InvoiceDtlMapper.chkInvTaxAmountSum", suim_rpt_no);    			    			
			
			//nEnd_chk : 1 (동일), 0 (합계값이 다름)
			paramMap.put("tax_edit_end", nEnd_chk);
			sqlSession.update("InvoiceDtlMapper.updateTaxWork", paramMap);			
		}

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		//작업상태 초기화
		sqlSession.update("InvoiceDtlMapper.updateInvWorkClean", paramMap);

		out.print(successCnt);
	}//rptInvUdtOK

}//end of class
