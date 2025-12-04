 package kr.co.toplac.topstatistics;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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

import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopTmBscVO;

@Controller
public class StatisticsIndexController {

	private static final Logger logger = LoggerFactory.getLogger(StatisticsIndexController.class);

	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value = "/statisticsIndex", method = RequestMethod.GET)
	public String statisticsIndex(Model model, HttpSession session, HttpServletRequest request
			, String statisticsIndexToday) {
		logger.info("======= statisticsIndex =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			logger.info("statisticsIndex - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		if(statisticsIndexToday == null || statisticsIndexToday.equals("")){
			Date today = new Date();
			DateFormat sd1 = new SimpleDateFormat("yyyy-MM-dd");
			statisticsIndexToday = sd1.format(today);//String형으로 변환
		}

		StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsIndexDate", statisticsIndexToday);
		nowVO.setStatisticsIndexToday(statisticsIndexToday);
		model.addAttribute("nowVO", nowVO);

		List<StatisticsIndexViewVO> team1List = sqlSession.selectList("StatisticsIndexMapper.team1ListForStatisticsIndex", nowVO);
		model.addAttribute("team1List", team1List);

		List<StatisticsIndexViewVO> team4List = sqlSession.selectList("StatisticsIndexMapper.team4ListForStatisticsIndex", nowVO);
		model.addAttribute("team4List", team4List);

		List<StatisticsIndexViewVO> ptnr1List = sqlSession.selectList("StatisticsIndexMapper.ptnr1ListForStatisticsIndex", nowVO);
		model.addAttribute("ptnr1List", ptnr1List);

		List<StatisticsIndexViewVO> ptnr4List = sqlSession.selectList("StatisticsIndexMapper.ptnr4ListForStatisticsIndex", nowVO);
		model.addAttribute("ptnr4List", ptnr4List);

		model.addAttribute("statisticsIndexToday", statisticsIndexToday);
		model.addAttribute("statisticsIndexTodayText", statisticsIndexToday.substring(0, 4)+"년"
								+statisticsIndexToday.substring(5, 7)+"월"+statisticsIndexToday.substring(8, 10)+"일");

		return "top_statistics/statistics_index";
	}//statisticsIndex

}
