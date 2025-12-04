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

import kr.co.toplac.topsuim.TopRptHeadVO;
import kr.co.toplac.topteam.TopMbrBscVO;

@Controller
public class AIASearchController {

	private static final Logger logger = LoggerFactory.getLogger(AIASearchController.class);

	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value = "aiaSearch", method = RequestMethod.GET)
	public String aiaSearch(Model model, HttpSession session, HttpServletRequest request, String fromMainLeftStr) {

		logger.info("======= aiaSearch =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("aiaSearch - no permession : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		String user_no = mbrVo.getUser_no();
		String team_id = mbrVo.getTeam_name();
		String msgToScreen = "";
		List<TopRptHeadVO> suimBookList = null;
		if(fromMainLeftStr.equals("mycnt")){
			msgToScreen = "AIA 보완 ("+mbrVo.getUser_name()+")";
			suimBookList = sqlSession.selectList("AIASearchListMapper.getMyAIASearchList", user_no);
		}else if(fromMainLeftStr.equals("tmcnt")){
			msgToScreen = "AIA 보완 ("+team_id+")";
			suimBookList = sqlSession.selectList("AIASearchListMapper.getTmAIASearchList", team_id);
		}if(fromMainLeftStr.equals("tm1cntall")){
			msgToScreen = "AIA 상신 (전체팀)";
			suimBookList = sqlSession.selectList("AIASearchListMapper.getTm1AllAIASearchList");
		}if(fromMainLeftStr.equals("tm11cntall")){
			msgToScreen = "AIA 반려 (전체팀)";
			suimBookList = sqlSession.selectList("AIASearchListMapper.getTm11AllAIASearchList");
		}if(fromMainLeftStr.equals("tmcntall")){
			msgToScreen = "AIA 보완 (전체팀)";
			suimBookList = sqlSession.selectList("AIASearchListMapper.getTmAllAIASearchList");
		}

		model.addAttribute("suimBookList", suimBookList);
		model.addAttribute("msgToScreen", msgToScreen);
		return "search_main/aia_search_main";
	}//aiaSearch

}//end of class
