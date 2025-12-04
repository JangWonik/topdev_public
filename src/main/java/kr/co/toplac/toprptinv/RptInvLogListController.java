package kr.co.toplac.toprptinv;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.cmm.RequestUtil;

@Controller
public class RptInvLogListController {

	private static final Logger logger = LoggerFactory.getLogger(RptInvLogListController.class);

	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value = "rptInvLogList", method = RequestMethod.GET)
	public String rptInvLogList(Model model, HttpSession session, TopRptInvLogVO vo, TopTmBscVO vo3) {

		logger.info("======= rptInvLogList =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_8().equals("0") ){
			logger.info("rptInvDtl - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		List<TopRptInvLogVO> invoiceLogList = sqlSession.selectList("InvoiceLogListMapper.getInvoiceLogList", vo);

		model.addAttribute("invoiceLogList", invoiceLogList);

		return "top_rpt_inv/rpt_inv_log_list";
	}
	
	/**
     * 인보이스 금액변경내역 Modal
     */
    @RequestMapping(value="/openInvoiceLogModal")
    public String openInvoiceLogModal(HttpServletRequest request, Model model) {
    	
    	logger.info("========= openInvoiceLogModal =========");
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String no = String.valueOf(paramMap.get("rpt_invoice_no")); 
    	
    	List<TopRptInvLogVO> invoiceLogList = sqlSession.selectList("InvoiceDtlMapper.getInvoiceLogList", no);
		model.addAttribute("invoiceLogList", invoiceLogList);
    	
    	return "top_rpt_inv/rpt_inv_log_modal";
    }

}
