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

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.page.PageUtilityBasic;

@Controller
public class PrimbizRptListController {

	private static final Logger logger = LoggerFactory.getLogger(PrimbizRptListController.class);

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
	@RequestMapping(value = "primbizRptList", method = RequestMethod.GET)
	public String primbizRptList(Model model, HttpSession session, String reqPgNo) {

		logger.info("======= primbizRptList =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("primbizRptList - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		PageUtilityBasic pageUtil = new PageUtilityBasic();
		List<TopPrimBizRptHeadVO> primbizRptList
			= (List<TopPrimBizRptHeadVO>) pageUtil.pageBasic1(1, sqlSession, "PrimbizRptListMapper.getPrimbizRptList", reqPgNo, model, "primbizRptList");
		model.addAttribute("primbizRptList", primbizRptList);

		return "top_prim_biz/prim_biz_rpt_list";
	}//primbizRptList

}//end of class
