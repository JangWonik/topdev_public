package kr.co.toplac.searchmain;

import java.util.List;

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

import kr.co.toplac.sysadm.SysAdmCodeDicVO;
import kr.co.toplac.topsuim.SuimRptHelpBscVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.page.PageUtilityBasic;

@Controller
public class HelpSearchController {

	private static final Logger logger = LoggerFactory.getLogger(HelpSearchController.class);

	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value = "helpSearch", method = RequestMethod.GET)
	public String helpSearch(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= helpSearch =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("helpSearch - no permession : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		/* 팀목록 추출*/
		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
		model.addAttribute("teamList", teamList);
		/* helpStateList */
		List<SysAdmCodeDicVO> helpStateList = sqlSession.selectList("HelpSearchListMapper.helpStateForSearch");
		model.addAttribute("helpStateList", helpStateList);

		return "search_main/help_search_main";
	}//helpSearch

	@RequestMapping(value = "helpSearchQuery", method = RequestMethod.POST)
	public String helpSearchQuery(Model model, HttpSession session, HttpServletRequest request
			, HelpSearchQueryVO searchVO, String reqPgNo) {

		logger.info("======= helpSearchQuery =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("helpSearchQuery - no permession : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		/* 팀목록 추출*/
		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
		model.addAttribute("teamList", teamList);
		/* helpStateList */
		List<SysAdmCodeDicVO> helpStateList = sqlSession.selectList("HelpSearchListMapper.helpStateForSearch");
		model.addAttribute("helpStateList", helpStateList);
/*
		System.out.println("reqPgNo           : "+reqPgNo);
		System.out.println("tmSearchClient          : "+searchVO.getTmSearchClient());
		System.out.println("tmGubunClient          : "+searchVO.getTmGubunClient());
		System.out.println("clientNmSearch          : "+searchVO.getClientNmSearch());
		System.out.println("regDateFromSearch          : "+searchVO.getRegDateFromSearch());
		System.out.println("regDateToSearch          : "+searchVO.getRegDateToSearch());
		System.out.println("endDateFromSearch          : "+searchVO.getEndDateFromSearch());
		System.out.println("endDateToSearch          : "+searchVO.getEndDateToSearch());
		System.out.println("tmSearchAccept          : "+searchVO.getTmSearchAccept());
		System.out.println("tmGubunAccept          : "+searchVO.getTmGubunAccept());
		System.out.println("acceptNmSearch          : "+searchVO.getAcceptNmSearch());
		System.out.println("stateSearch          : "+searchVO.getStateSearch());
*/

		PageUtilityBasic pageUtil = new PageUtilityBasic();
		int totCntInt = 0;
		int queryPgNoInt = 0;

		searchVO.setUser_no_session((String) session.getAttribute("user_no_Session"));
		List<SuimRptHelpBscVO> suimRptHelpBscList = null;
		totCntInt = sqlSession.selectOne("HelpSearchListMapper.getHelpSearchListCnt", searchVO);//총 조회 건수
		if(totCntInt > 0){
			queryPgNoInt = pageUtil.pageBasic2(1, totCntInt, reqPgNo, model, "searchMainQuery");
			searchVO.setQueryPgNoInt(queryPgNoInt);
			suimRptHelpBscList = sqlSession.selectList("HelpSearchListMapper.getHelpSearchList", searchVO);
		}
		model.addAttribute("helpBookListTotCnt", totCntInt);
		model.addAttribute("helpBookList", suimRptHelpBscList);

		model.addAttribute("searchVO", searchVO);
		return "search_main/help_search_main";
	}//helpSearchQuery

}//end of class
