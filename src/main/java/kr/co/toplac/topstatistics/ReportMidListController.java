package kr.co.toplac.topstatistics;

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

import kr.co.toplac.topindividual.NoSiteMngCpstVO;
import kr.co.toplac.topteam.TopMbrAuthVO;

@Controller
public class ReportMidListController {

	private static final Logger logger = LoggerFactory.getLogger(ReportMidListController.class);

	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value = "getReportMidList", method = RequestMethod.GET)
	public String getReportMidList(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= getReportMidList =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			logger.info("getReportMidList - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		List<NoSiteMngCpstVO> reportMidList = null;
		List<NoSiteMngCpstVO> reportMidListcnt = null;
		reportMidList = sqlSession.selectList("ReportMidListMapper.getReportMidList");
		reportMidListcnt = sqlSession.selectList("ReportMidListMapper.getReportMidListCnt");

		model.addAttribute("reportMidList", reportMidList);
		model.addAttribute("teamCnt", reportMidListcnt);
		model.addAttribute("pgid", "report_mid_list");

		return "top_statistics/statistics_index";
	}//getReportMidList

}//end of class
