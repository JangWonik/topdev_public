/*
*********************************************************
* Program ID	: PrimbizSuimListController
* Program Name	: PrimbizSuimListController
* Description	: 농작물 수임대장 리스트
* Author		: 
* Date			: 2016.06.09.
*********************************************************
*/
package kr.co.toplac.sysadm.report;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

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

import kr.co.toplac.toplogin.TopLogInLogCompositeVO;
import kr.co.toplac.topprimbiz.TopPrimBizRptCompositeVO;
import kr.co.toplac.topprimbiz.TopPrimBizRptHeadVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;

@Controller
public class RptLockMngController {

	private static final Logger logger = LoggerFactory.getLogger(RptLockMngController.class);

	@Autowired
	private SqlSession sqlSession;

	/*
	*********************************************************
	* Program ID	: primbizSuimList
	* Program Name	: primbizSuimList
	* Description	: 농작물 수임대장 리스트
	* Author		: 
	* Date			: 2016.06.09.
	*********************************************************
	*/
	@RequestMapping(value = "rptLockMngMain", method = RequestMethod.GET)
	public String rptLocMngMain(Model model, HttpSession session) {

		logger.info("rptLockMngMain");

		List<RptPrimLockMngCompositeVO> rptLockList = sqlSession.selectList("RptLockListMapper.rptLockList");

		model.addAttribute("rptLockList", rptLockList);

		return "sysadm_report/rpt_lock_mng";
	}//rptLocMngMain
	
	@RequestMapping(value = "/rptLockList_Excel", method = RequestMethod.GET)
	public String rptLockList_Excel(Model model, HttpSession session, HttpServletResponse response, RptPrimLockMngCompositeVO LockVO, String reqPgNo) {
		//String nowDate=DateUtil.getDate("yyyyMMddHHmmss");

		logger.info("======= rptLockList_Excel =======");
		
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_7().equals("0") ){
			logger.info("rptLockList_Excel - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("primbizSuimList - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		List<RptPrimLockMngCompositeVO> rptLockListExcel = sqlSession.selectList("RptLockListMapper.rptLockListExcel");

		model.addAttribute("rptLockListExcel", rptLockListExcel);
		
		return "sysadm_report/rpt_lock_list_excel";
	}
	
	@RequestMapping(value = "rptLockUdtOK", method = RequestMethod.POST)
	public void rptLockUdtOK(TopPrimBizRptCompositeVO vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.info("rptLockUdtOK");
		
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		vo.setLog_user_no(mbrAuthVo.getUser_no());
		vo.setLog_ip(request.getRemoteAddr());

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		int updateRptLock = sqlSession.update("RptLockListMapper.updateRptLock");
		
		int result = 0;
		if(updateRptLock >0){
			
			result = 1;
			
		}
		
		out.print(result);
	}
	

}//end of class
