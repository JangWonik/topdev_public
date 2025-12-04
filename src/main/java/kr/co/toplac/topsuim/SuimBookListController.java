package kr.co.toplac.topsuim;

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

import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.util.page.PageUtilityBasic;

@Controller
public class SuimBookListController {

	private static final Logger logger = LoggerFactory.getLogger(SuimBookListController.class);

	@Autowired
	private SqlSession sqlSession;

	/*
	*********************************************************
	* Program ID	: suimBookList
	* Program Name	: suimBookList
	* Description	: 수임대장 리스트
	* Author		: 이동익
	* Date			: 2016.05.02.
	* 번호 1(수정:이선형): 2016.05.09. 
	*********************************************************
	*/
	@RequestMapping(value = "suimBookList", method = RequestMethod.GET)
	public String suimBookList(Model model, HttpSession session, String reqPgNo) {

		logger.info("======= suimBookList =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		/*로그인 정보 유지 여부 확인*/
		if( (mbrAuthVo == null) || (session.getAttribute("user_no_Session") == null) ){
			logger.info("suimBookList - no session information ");
			session.invalidate();
			model.addAttribute("authFlag", "logout");
			return "top_suim/suim_book_list";
		}

		PageUtilityBasic pageUtil = new PageUtilityBasic();
		List<TopRptHeadVO> suimBookList
		= (List<TopRptHeadVO>) pageUtil.pageBasic1(1, sqlSession, "SuimBookListMapper.getSuimBookList", reqPgNo, model, "suimBookList");
		model.addAttribute("suimBookList", suimBookList);

		String topRptListTotCnt = "";
		topRptListTotCnt = ""+sqlSession.selectOne("SuimBookListMapper.getSuimBookListCnt");
		model.addAttribute("topRptListTotCnt", topRptListTotCnt);
		
		if(reqPgNo == null || reqPgNo.equals("")){
			reqPgNo = "1";
		}
		
		int j=0;
		for (int i = Integer.parseInt(topRptListTotCnt)-(18*(Integer.parseInt(reqPgNo)-1)) ; i > (Integer.parseInt(topRptListTotCnt)-(18*(Integer.parseInt(reqPgNo)-1)) - suimBookList.size() ); i--) {
			
			suimBookList.get(j).setROWNUM(Integer.toString(i));
			j++;
		}

		return "top_suim/suim_book_list";
	}//suimBookList

}
