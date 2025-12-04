package kr.co.toplac.topteam;

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

import kr.co.toplac.util.rpt.MainLeftUtil;

@Controller
public class TmMngListController {

	private static final Logger logger = LoggerFactory.getLogger(TmMngListController.class);
	
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	MainLeftUtil mlu;
	
	@RequestMapping(value = "teamlist", method = RequestMethod.GET)
	public String teamlist( Model model, HttpSession session, HttpServletRequest request) {

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_13().equals("0")){
			logger.info("teamlist - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		//탭 선택
		String selTab  = request.getParameter("selTab") != null ? request.getParameter("selTab") : "0";		
		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		//팀 전체 목록 추출 후 전달 - 1번
		List<TopTmBscVO> TeamList0 = sqlSession.selectList("TmMngListMapper.managementlist0");
		List<TopTmBscVO> TeamList1 = sqlSession.selectList("TmMngListMapper.managementlist1");
		List<TopTmBscVO> TeamList4 = sqlSession.selectList("TmMngListMapper.managementlist4");
		
		/*for (int i = 0; i < TeamList.size() ; i++) {
			TeamList.get(i).getTeam_type()
		}*/
		int span0 = TeamList0.size();
		int span1 = TeamList1.size();
		int span4 = TeamList4.size();
		
		model.addAttribute("teamlist0",TeamList0);
		model.addAttribute("teamlist1",TeamList1);
		model.addAttribute("teamlist4",TeamList4);
		
		model.addAttribute("span0",span0);
		model.addAttribute("span1",span1);
		model.addAttribute("span4",span4);
		
		//탭 선택 추가
		model.addAttribute("selTab", selTab);
		
		model.addAttribute("page","teamlist");
		return "top_team/tm_mng_list";
	}

}
