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
public class RptPrimLockMngController {

	private static final Logger logger = LoggerFactory.getLogger(RptPrimLockMngController.class);

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
	@RequestMapping(value = "rptPrimLockMngMain", method = RequestMethod.GET)
	public String rptPrimLockMngMain(Model model, HttpSession session) {

		logger.info("rptPrimLockMngMain");

		List<RptPrimLockMngCompositeVO> rptPrimLockList = sqlSession.selectList("PrimbizLockListMapper.rptPrimLockList");

		model.addAttribute("rptPrimLockList", rptPrimLockList);

		return "sysadm_report/prim_biz_lock_mng";
	}//rptLocMngMain
	
	@RequestMapping(value = "/primBizLockList_Excel", method = RequestMethod.GET)
	public String primBizLockList_Excel(Model model, HttpSession session, HttpServletResponse response, RptPrimLockMngCompositeVO LockVO, String reqPgNo) {
		//String nowDate=DateUtil.getDate("yyyyMMddHHmmss");

		logger.info("======= primBizLockList_Excel =======");
		
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_7().equals("0") ){
			logger.info("primBizInvListExcel - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("primbizSuimList - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		/*String user_no = (String) session.getAttribute("user_no_Session");
		logVO.setUser_no(user_no);
		String user_nm = logVO.getMbrNm();
		String mbrNo = logVO.getMbrNo();
		
		model.addAttribute("user_nm",user_nm);
		model.addAttribute("mbrNo",mbrNo);
		
		String user_id = logVO.getUser_id();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("user_nm", user_nm);
		map.put("mbrNo", mbrNo);
		map.put("user_id", user_id);*/
		
		List<RptPrimLockMngCompositeVO> rptPrimLockListExcel = sqlSession.selectList("PrimbizLockListMapper.rptPrimLockListExcel");

		model.addAttribute("rptPrimLockListExcel", rptPrimLockListExcel);
		
		return "sysadm_report/prim_biz_lock_list_excel";
	}
	
	@RequestMapping(value = "primBizLockUdtOK", method = RequestMethod.POST)
	public void primBizSuimUdtOK(TopPrimBizRptCompositeVO vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.info("primBizSuimUdtOK");
		
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
		
		int updateRptPrimLock = sqlSession.update("PrimbizLockListMapper.updateRptPrimLock", vo);
		
		int result = 0;
		if(updateRptPrimLock >0){
			
			result = 1;
			
		}
		
		out.print(result);
	}
	
	/*@RequestMapping(value = "primBizSuimEndUdtPage", method = RequestMethod.GET)
	public String primBizSuimEndUdtPage(Model model, TopPrimBizRptCompositeVO vo) {
		
		logger.info("primBizSuimEndUdtPage");
		
		TopPrimBizRptCompositeVO prim_Biz_Suim_End_Udt = sqlSession.selectOne("PrimBizSuimUdtMapper.getPrimBizSuimUdt", vo);
		
		model.addAttribute("prim_Biz_Suim_End_Udt", prim_Biz_Suim_End_Udt);
		
		return "top_prim_biz/prim_biz_suim_end_udt";
	}*/

}//end of class
