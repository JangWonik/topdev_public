package kr.co.toplac.topteam;

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

import kr.co.toplac.topmain.MainLeftSuimVO;
import kr.co.toplac.util.rpt.MainLeftUtil;

@Controller
public class TmStatListController {

	private static final Logger logger = LoggerFactory.getLogger(TmStatListController.class);
	
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	MainLeftUtil mlu;

	/**********************************팀현황 시작**********************************/
	@RequestMapping(value = "topTeamState", method = RequestMethod.GET)
	public String topTeamState(Model model, HttpSession session) {

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_14().equals("0") && mbrAuthVo.getMbr_pms_15().equals("0"))){
			logger.info("topTeamState - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		/*팀현황 TAB 시작*/
		List<TopTmBscVO> teamList = sqlSession.selectList("TopTeamMapper.getAllTeam");
		
		for (int i = 0; i < teamList.size(); i++) {
			if(teamList.get(i).getCnt().equals("0")){
				teamList.get(i).setCnt("-");
			}
		}
		
		String countWorkTotal = sqlSession.selectOne("TopTeamMapper.countAllWorkMember");
		String countPendingTotal = sqlSession.selectOne("TopTeamMapper.countAllPendingMember");
		String countRetireTotal = sqlSession.selectOne("TopTeamMapper.countAllRetireMember");
		
		model.addAttribute("teamList",teamList);
		
		model.addAttribute("countWorkTotal",countWorkTotal);
		model.addAttribute("countPendingTotal",countPendingTotal);
		model.addAttribute("countRetireTotal",countRetireTotal);
		/*팀현황 TAB 끝*/
		
		return "top_team/tm_stat_list";
	}
	
}