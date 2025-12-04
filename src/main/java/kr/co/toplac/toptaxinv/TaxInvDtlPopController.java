package kr.co.toplac.toptaxinv;

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

@Controller
public class TaxInvDtlPopController {

	private static final Logger logger = LoggerFactory.getLogger(TaxInvDtlPopController.class);

	@Autowired
	private SqlSession sqlSession;

	/*
	*********************************************************
	* Program ID	: suimBookList
	* Program Name	: suimBookList
	* Description	: 수임대장 리스트
	* Author		: 이동익
	* Date			: 2016.05.02.
	*********************************************************
	*/
	@RequestMapping(value = "taxInvDtlPop", method = RequestMethod.GET)
	public String taxInvDtlPop(Model model, HttpSession session, TopTaxInvDtlCompositVO vo) {

		logger.info("======= taxInvDtlPop =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_7().equals("0") ){
			logger.info("rptInvList - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		TopTaxInvDtlCompositVO taxInvDtl = sqlSession.selectOne("TaxInvDtlPopMapper.getTaxInvDtlPop", vo);
		model.addAttribute("taxInvDtl", taxInvDtl);
		return "top_tax_inv/tax_inv_dtl_pop"; 
	}

	@RequestMapping(value = "primBizTaxInvDtlPop", method = RequestMethod.GET)
	public String primBizTaxInvDtlPop(Model model, HttpSession session, TopTaxInvDtlCompositVO vo) {

		logger.info("======= primBizTaxInvDtlPop =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_7().equals("0") ){
			logger.info("rptInvList - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		TopTaxInvDtlCompositVO primBizTaxInvDtl = sqlSession.selectOne("TaxInvDtlPopMapper.getPrimBizTaxInvDtlPop", vo);
		model.addAttribute("taxInvDtl", primBizTaxInvDtl);
		return "top_tax_inv/tax_inv_dtl_pop"; 
	}

}
