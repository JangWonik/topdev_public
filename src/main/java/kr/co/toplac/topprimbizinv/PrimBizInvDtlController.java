package kr.co.toplac.topprimbizinv;

import java.io.IOException;
import java.io.PrintWriter;
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

import kr.co.toplac.toprptinv.TopRptInvLogVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.cmm.RequestUtil;

@Controller
public class PrimBizInvDtlController {

	private static final Logger logger = LoggerFactory.getLogger(PrimBizInvDtlController.class);

	@Autowired
	private SqlSession sqlSession;

	/*
	*********************************************************
	* Program ID	: 
	* Program Name	: 
	* Description	: 
	* Author		: 이동익
	* Date			: 2016.05.02.
	*********************************************************
	*/
	@RequestMapping(value = "primBizInvDtl", method = RequestMethod.GET)
	public String primBizInvDtl(Model model, HttpSession session, String rpt_invoice_no, String tabIdx) {

		logger.info("======= primBizInvDtl =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_8().equals("0") ){
			logger.info("primBizInvDtl - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		TopPrimBizInvCompositeVO primBizInvDtl = sqlSession.selectOne("PrimBizInvDtlMapper.getPrimBizInvDtl", rpt_invoice_no);
		model.addAttribute("primBizInvDtl", primBizInvDtl);

		List<TopRptInvLogVO> invoiceLogList = sqlSession.selectList("PrimBizInvDtlMapper.getInvoiceLogList", rpt_invoice_no);
		model.addAttribute("invoiceLogList", invoiceLogList);

		List<TopPrimBizInvShareVO> primBizInvShareList = sqlSession.selectList("PrimBizInvDtlMapper.getPrimBizInvShareList", rpt_invoice_no);
		model.addAttribute("primBizInvShareList", primBizInvShareList);

		List<TopPrimBizInvShareLogVO> primBizInvShareLogList = sqlSession.selectList("PrimBizInvDtlMapper.getPrimBizInvShareLogList", rpt_invoice_no);
		model.addAttribute("primBizInvShareLogList", primBizInvShareLogList);

		/*검색에 사용될 팀목록 추출*/
		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
		model.addAttribute("teamList", teamList);

		model.addAttribute("tabIdx", tabIdx);

		return "top_prim_biz_inv/prim_biz_inv_dtl";
	}//primBizInvDtl

	@RequestMapping(value = "primBizInvUdtOK", method = RequestMethod.POST)
	public void primBizInvUdtOK(HttpSession session, HttpServletResponse response, HttpServletRequest request, TopPrimBizInvDtlViewVO viewVO) {

		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		logger.info("======= primBizInvUdtOK =======");

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
		orgTaxNo = sqlSession.selectOne("PrimBizInvDtlMapper.selectInvPrimInvoiceNo", viewVO);
		
		//기존 세금계산서 No 가 없는 경우
		if( "".equals(orgTaxNo) ) {
			if( !"".equals(deposit_date) || !"".equals(tax_date)) {		//입금일이나 세금계산서 일자중 하나라도 입력된 경우는 자동으로 세금계산서 No를 넣어준다. 
				//세금계산서 No를 인보이스킷값으로 갱신한다.
				sqlSession.update("PrimBizInvDtlMapper.updateInvPrimInvoiceNoAuto", viewVO);
			}
			
			if( !"".equals(tax_invoice_no) ){
				//세금계산서 No를 입력값으로 갱신한다.				
				sqlSession.update("PrimBizInvDtlMapper.updateInvPrimInvoiceNoData", viewVO);
			}
			
		}else{			//기존 세금계산서 값이 있는경우
			if( "".equals(tax_invoice_no) ) {		//입력폼의 세금계산서 No를 삭제한 경우
				//세금계산서 No를 빈값으로 갱신한다.
				sqlSession.update("PrimBizInvDtlMapper.updateInvPrimInvoiceNoEmpty", viewVO);
			}else {
				//세금계산서 No를 입력값으로 갱신한다.				
				sqlSession.update("PrimBizInvDtlMapper.updateInvPrimInvoiceNoData", viewVO);
			}
		}

		int successCnt = 0;
		successCnt = sqlSession.update("PrimBizInvDtlMapper.updateRptInvDtl", viewVO);
		if(successCnt > 0){
			viewVO.setRegUserNo((String) session.getAttribute("user_no_Session"));
			sqlSession.insert("PrimBizInvDtlMapper.insertTopPrimBizInvLog", viewVO);
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
		nTotal_amt = sqlSession.selectOne("primBizInvListMapper.getInvPrimTotalAmt", suim_rpt_no);
		
		//입금일자가 입력 된 경우만 처리한다.  
		if(!"".equals(deposit_date)) {
			
			paramMap.put("deposit_date", deposit_date);
			
			//세금계산서 테이블에 기존에 등록된 값을 체크한다.    			
			nCnt = sqlSession.selectOne("primBizInvListMapper.getInvPrimTaxCnt", suim_rpt_no);
			
			//입금액 신규추가
			paramMap.put("deposit_amount", nTotal_amt);
			
			//신규 세금계산서 테이블 정보 입력
			if( nCnt == 0 ) {
				paramMap.put("publish_amount", 0);
				sqlSession.insert("primBizInvListMapper.insertInvPrimTax", paramMap);				    				
			}else {    				
				//기존 입금일자 등록값이 있는지 확인한다.
				nCnt_sub = sqlSession.selectOne("primBizInvListMapper.getInvPrimTaxDepositCnt", suim_rpt_no);
				if( nCnt_sub == 0 ){		//기존등록일자와 금액이 없는 경우만 update 한다.
					sqlSession.update("primBizInvListMapper.updateInvPrimTaxDeposit", paramMap);					
				}
			}
			
			//인보이스의 세금계산서, 입금액 합을 비교하여 동일하면 작업완료로 표시한다.			
			nEnd_chk = sqlSession.selectOne("primBizInvListMapper.chkInvPrimTaxAmountSum", suim_rpt_no);
			
			//nEnd_chk : 1 (동일), 0 (합계값이 다름)
			paramMap.put("tax_edit_end", nEnd_chk);
			sqlSession.update("primBizInvListMapper.updatePrimTaxWork", paramMap);
		}
		
		//세금계산서 수정 여부 체크 시작
		nCnt = 0;
		nCnt_sub = 0;
		nEnd_chk = 0;		
		
		if(!"".equals(tax_date)) {
			paramMap.put("publish_date", tax_date);
			
			//세금계산서 테이블에 기존에 등록된 값을 체크한다.    			
			nCnt = sqlSession.selectOne("primBizInvListMapper.getInvPrimTaxCnt", suim_rpt_no);			
			
			//세금계산서 확인금액 신규추가
			paramMap.put("publish_amount", nTotal_amt);
			
			//신규 세금계산서 테이블 정보 입력
			if( nCnt == 0 ) {
				//입금금액은 초기금액으로 입력
				paramMap.put("deposit_amount", 0);
				sqlSession.insert("primBizInvListMapper.insertInvPrimTax", paramMap);    				
			}else {    				
				//기존 입금일자 등록값이 있는지 확인한다.
				nCnt_sub = sqlSession.selectOne("primBizInvListMapper.getInvPrimTaxPublishCnt", suim_rpt_no);
				if( nCnt_sub == 0 ){		//기존 세금계산서 일자와 금액이 없는 경우만 update 한다.
					sqlSession.update("primBizInvListMapper.updateInvPrimTaxPublish", paramMap);					
				}
			}
			
			//인보이스의 세금계산서, 입금액 합을 비교하여 동일하면 작업완료로 표시한다.			
			nEnd_chk = sqlSession.selectOne("primBizInvListMapper.chkInvPrimTaxAmountSum", suim_rpt_no);
			
			//nEnd_chk : 1 (동일), 0 (합계값이 다름)
			paramMap.put("tax_edit_end", nEnd_chk);			
			sqlSession.update("primBizInvListMapper.updatePrimTaxWork", paramMap);
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

	}//primBizInvUdtOK

	@RequestMapping(value = "primBizInvShareAddOK", method = RequestMethod.POST)
	public String primBizInvShareAddOK(HttpSession session, TopPrimBizInvShareViewVO shareVO) {

		logger.info("======= primBizInvShareAddOK =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_8().equals("0") ){
			logger.info("primBizInvShareAddOK - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		if(shareVO.getFormShareAmtBasic() == null || shareVO.getFormShareAmtBasic().equals("")){
			shareVO.setFormShareAmtBasic("0");
		}
		if(shareVO.getFormShareAmtDaily() == null || shareVO.getFormShareAmtDaily().equals("")){
			shareVO.setFormShareAmtDaily("0");
		}
		if(shareVO.getFormShareAmtTraffic() == null || shareVO.getFormShareAmtTraffic().equals("")){
			shareVO.setFormShareAmtTraffic("0");
		}
		if(shareVO.getFormShareAmtCounsel() == null || shareVO.getFormShareAmtCounsel().equals("")){
			shareVO.setFormShareAmtCounsel("0");
		}
		if(shareVO.getFormShareAmtEtc() == null || shareVO.getFormShareAmtEtc().equals("")){
			shareVO.setFormShareAmtEtc("0");
		}
		if(shareVO.getFormShareEa() == null || shareVO.getFormShareEa().equals("")){
			shareVO.setFormShareEa("0");
		}

		int successCnt = 0;
		String tabIdx = "";
		successCnt = sqlSession.insert("PrimBizInvDtlMapper.insertPrimBizInvShare", shareVO);
		if(successCnt > 0){
			tabIdx = "shareAdd";
			shareVO.setFormRegUserNo((String) session.getAttribute("user_no_Session"));
			shareVO.setFormRegType("1");
			sqlSession.insert("PrimBizInvDtlMapper.insertPrimBizInvShareLog", shareVO);
		}
		return "redirect:/primBizInvDtl?rpt_invoice_no="+shareVO.getFormRptInvNo()+"&tabIdx="+tabIdx;				

	}//primBizInvShareAddOK

	@RequestMapping(value = "primBizInvShareUdtOK", method = RequestMethod.POST)
	public String primBizInvShareUdtOK(HttpSession session, TopPrimBizInvShareViewVO shareVO) {

		logger.info("======= primBizInvShareUdtOK =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_8().equals("0") ){
			logger.info("primBizInvShareUdtOK - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		if(shareVO.getFormShareAmtBasic() == null || shareVO.getFormShareAmtBasic().equals("")){
			shareVO.setFormShareAmtBasic("0");
		}
		if(shareVO.getFormShareAmtDaily() == null || shareVO.getFormShareAmtDaily().equals("")){
			shareVO.setFormShareAmtDaily("0");
		}
		if(shareVO.getFormShareAmtTraffic() == null || shareVO.getFormShareAmtTraffic().equals("")){
			shareVO.setFormShareAmtTraffic("0");
		}
		if(shareVO.getFormShareAmtCounsel() == null || shareVO.getFormShareAmtCounsel().equals("")){
			shareVO.setFormShareAmtCounsel("0");
		}
		if(shareVO.getFormShareAmtEtc() == null || shareVO.getFormShareAmtEtc().equals("")){
			shareVO.setFormShareAmtEtc("0");
		}
		if(shareVO.getFormShareEa() == null || shareVO.getFormShareEa().equals("")){
			shareVO.setFormShareEa("0");
		}

		int successCnt = 0;
		String tabIdx = "";
		successCnt = sqlSession.update("PrimBizInvDtlMapper.updatePrimBizInvShare", shareVO);
		if(successCnt > 0){
			tabIdx = "shareUdt";
			shareVO.setFormRegUserNo((String) session.getAttribute("user_no_Session"));
			shareVO.setFormRegType("2");
			sqlSession.insert("PrimBizInvDtlMapper.insertPrimBizInvShareLog", shareVO);
		}

		return "redirect:/primBizInvDtl?rpt_invoice_no="+shareVO.getFormRptInvNo()+"&tabIdx="+tabIdx;				

	}//primBizInvShareUdtOK

	@RequestMapping(value = "primBizInvShareDelOK", method = RequestMethod.POST)
	public String primBizInvShareDelOK(HttpSession session, TopPrimBizInvShareViewVO shareVO) {

		logger.info("======= primBizInvShareDelOK =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_8().equals("0") ){
			logger.info("primBizInvShareDelOK - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		int successCnt = 0;
		String tabIdx = "";
		successCnt = sqlSession.delete("PrimBizInvDtlMapper.deletePrimBizInvShare", shareVO);
		if(successCnt > 0){
			tabIdx = "shareDel";
			shareVO.setFormRegUserNo((String) session.getAttribute("user_no_Session"));
			shareVO.setFormRegType("3");
			sqlSession.insert("PrimBizInvDtlMapper.insertPrimBizInvShareLog", shareVO);
		}

		return "redirect:/primBizInvDtl?rpt_invoice_no="+shareVO.getFormRptInvNo()+"&tabIdx="+tabIdx;				

	}//primBizInvShareDelOK

}//end of class
