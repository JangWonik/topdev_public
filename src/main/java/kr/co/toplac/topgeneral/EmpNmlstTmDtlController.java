package kr.co.toplac.topgeneral;

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

import kr.co.toplac.topmain.MainLeftSuimVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.rpt.MainLeftUtil;

@Controller
public class EmpNmlstTmDtlController {
	
private static final Logger logger = LoggerFactory.getLogger(EmpNmlstTmDtlController.class);
	
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	MainLeftUtil mlu;
	
	@RequestMapping(value = "/empNmlstTmDtl", method = RequestMethod.GET)
	public String empNmlstTmDtl(Model model, HttpSession session, HttpServletRequest request, String team_id) {

		logger.info("======= empNmlstTmDtl =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("empNmlstTmDtl - no permession : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		//팀정보 조회 시작
		EmpNmlstTmDtlVO team_info = sqlSession.selectOne("empNmlstTmDtlMapper.getTeamIF",team_id);
		//팀정보 조회 종료//
		
		//팀 상세 정보 조회 시작
		List<EmpNmlstTmDtlVO> memberList = sqlSession.selectList("empNmlstTmDtlMapper.getMemberAll",team_id);
		//팀 상세 정보 조회 종료//
		
		model.addAttribute("team_info", team_info);
		model.addAttribute("memberList", memberList);

		return "top_general/emp_nmlst_tm_dtl";
	}
	
	
	@RequestMapping(value = "/popEmpNmlstTmDtl", method = RequestMethod.GET)
	public String popEmpNmlstTmDtl(Model model, HttpSession session, HttpServletRequest request, String team_id) {

		logger.info("======= popEmpNmlstTmDtl =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("popEmpNmlstTmDtl - no permession : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		//팀정보 조회 시작
		List<EmpNmlstTmDtlVO> team_info = sqlSession.selectList("empNmlstTmDtlMapper.getTeamIF",team_id);
		//팀정보 조회 종료//
		
		//팀 상세 정보 조회 시작
		List<EmpNmlstTmDtlVO> memberList = sqlSession.selectList("empNmlstTmDtlMapper.getMemberAll",team_id);
		//팀 상세 정보 조회 종료//
		
		model.addAttribute("team_info", team_info);
		model.addAttribute("memberList", memberList);

		return "top_general/emp_nmlst_tm_dtl_pop";
	}
	
	
	
}
