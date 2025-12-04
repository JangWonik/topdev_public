package kr.co.toplac.toprptinv;

import java.io.IOException;
import java.io.PrintWriter;

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

import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopTmBscVO;

@Controller
public class RptInvMemoPopController {

	private static final Logger logger = LoggerFactory.getLogger(RptInvMemoPopController.class);

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
	@RequestMapping(value = "rptInvMemoPop", method = RequestMethod.GET)
	public String rptInvMemoPop(Model model, HttpSession session, TopRptInvCompositeVO vo, TopRptInvLogVO vo2, TopTmBscVO vo3) {

		logger.info("======= rptInvMemoPop =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_7().equals("0") ){
			logger.info("rptInvList - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		TopRptInvCompositeVO invoiceMemo = sqlSession.selectOne("InvoiceMemoPopMapper.getInvoiceMemo", vo);

		model.addAttribute("invoiceMemo", invoiceMemo);

		return "top_rpt_inv/rpt_inv_memo_pop"; 
	}

	@RequestMapping(value = "rptInvMemoUdtOK", method = RequestMethod.POST)
	public void rptInvMemoUdtOK(TopRptInvCompositeVO vo, TopRptInvLogVO vo2, HttpServletResponse response, HttpSession session) {

		logger.info("======= rptInvMemoUdtOK =======");

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		int RptInvUdt = sqlSession.update("InvoiceMemoPopMapper.updateRptInvMemoPop", vo);

		out.print(RptInvUdt);
	}

}
