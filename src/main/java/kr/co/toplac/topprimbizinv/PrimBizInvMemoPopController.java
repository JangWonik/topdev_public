package kr.co.toplac.topprimbizinv;

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
public class PrimBizInvMemoPopController {

	private static final Logger logger = LoggerFactory.getLogger(PrimBizInvMemoPopController.class);

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
	@RequestMapping(value = "primbizinvMemoPop", method = RequestMethod.GET)
	public String primbizinvMemoPop(Model model, HttpSession session, TopPrimBizInvCompositeVO vo, TopTmBscVO vo3) {

		logger.info("======= primbizinvMemoPop =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_7().equals("0") ){
			logger.info("primbizinvMemoPop - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		TopPrimBizInvCompositeVO primBizInvMemo = sqlSession.selectOne("PrimBizInvMemoPopMapper.getPrimBizInvMemo", vo);

		model.addAttribute("primBizInvMemo", primBizInvMemo);

		return "top_prim_biz_inv/prim_biz_inv_memo_pop"; 
	}//primbizinvMemoPop

	@RequestMapping(value = "primBizInvMemoUdtOK", method = RequestMethod.POST)
	public void primBizInvMemoUdtOK(TopPrimBizInvCompositeVO vo, HttpServletResponse response, HttpSession session) {

		logger.info("======= primBizInvMemoUdtOK =======");

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		int RptInvUdt = sqlSession.update("PrimBizInvMemoPopMapper.updatePrimBizInvMemo", vo);

		out.print(RptInvUdt);
	}

}
