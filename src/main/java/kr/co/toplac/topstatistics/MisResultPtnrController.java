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

import kr.co.toplac.topstatistics.StatisticsNowVO;
import kr.co.toplac.topteam.TopMbrAuthVO;

/*
*********************************************************
* Program ID	: LogMemberController
* Program Name	: 
* Description	: 
* Author		: leedongik
* Date			: 2015.12.30.
* Update		: 
*********************************************************
*/
@Controller
public class MisResultPtnrController {

	private static final Logger logger = LoggerFactory.getLogger(MisRegTmController.class);

	@Autowired
	private SqlSession sqlSession;


	@RequestMapping(value = "/MisResultPtnr", method = RequestMethod.GET)
	public String MisResultPtnr(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= MisResultPtnr =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}

//		String tmpNow_to = "";
//		if(inVO.getViewToDate() == null || inVO.getViewToDate().equals("")){
//			DateFormat tmpFormat = new SimpleDateFormat("yyyy-MM-16");
//			Date tmpToday = new Date();
//			tmpNow_to = tmpFormat.format(tmpToday);
//		}else{
//			tmpNow_to = inVO.getViewToDate();
//		}
//		inVO.setViewToDate(tmpNow_to);
		if(inVO.getViewFromDate() == null || inVO.getViewFromDate().equals("")){
			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate");
			inVO.setViewFromDate(nowVO.getNow_from());
			inVO.setViewToDate(nowVO.getNow_to());
			inVO.setViewFromYear(nowVO.getYear_from());
			inVO.setViewToYear(nowVO.getYear_to());
			inVO.setBasicYN("Y");
		}else{
			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate2", inVO);
			inVO.setViewFromYear(nowVO.getYear_from());
			inVO.setViewToYear(nowVO.getYear_to());
		}
		
		List<MisResultPtnrVO> MisResultPtnr = sqlSession.selectList("MisResultPtnrMapper.MisResultPtnr", inVO);
		model.addAttribute("MisResultPtnr",MisResultPtnr);

//		model.addAttribute("nowVO", nowVO);

		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_result_ptnr";
	}
	
	@RequestMapping(value = "/MisResultPtnrTm", method = RequestMethod.GET)
	public String MisResultPtnrTm(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= MisResultPtnrTm =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}

//		String tmpNow_to = "";
//		if(inVO.getViewToDate() == null || inVO.getViewToDate().equals("")){
//			DateFormat tmpFormat = new SimpleDateFormat("yyyy-MM-16");
//			Date tmpToday = new Date();
//			tmpNow_to = tmpFormat.format(tmpToday);
//		}else{
//			tmpNow_to = inVO.getViewToDate();
//		}
//		inVO.setViewToDate(tmpNow_to);
		if(inVO.getViewFromDate() == null || inVO.getViewFromDate().equals("")){
			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate");
			inVO.setViewFromDate(nowVO.getNow_from());
			inVO.setViewToDate(nowVO.getNow_to());
			inVO.setViewFromYear(nowVO.getYear_from());
			inVO.setViewToYear(nowVO.getYear_to());
			inVO.setBasicYN("Y");
		}else{
			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate2", inVO);
			inVO.setViewFromYear(nowVO.getYear_from());
			inVO.setViewToYear(nowVO.getYear_to());
		}
		
		
		List<MisResultPtnrVO> MisResultPtnrTm = sqlSession.selectList("MisResultPtnrMapper.MisResultPtnrTm", inVO);
		model.addAttribute("MisResultPtnrTm",MisResultPtnrTm);

//		model.addAttribute("nowVO", nowVO);

		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_result_ptnr_tm";
	}
	
	@RequestMapping(value = "/MisResultPtnrMbr", method = RequestMethod.GET)
	public String MisResultPtnrMbr(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= MisResultPtnrMbr =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}

//		String tmpNow_to = "";
//		if(inVO.getViewToDate() == null || inVO.getViewToDate().equals("")){
//			DateFormat tmpFormat = new SimpleDateFormat("yyyy-MM-16");
//			Date tmpToday = new Date();
//			tmpNow_to = tmpFormat.format(tmpToday);
//		}else{
//			tmpNow_to = inVO.getViewToDate();
//		}
//		inVO.setViewToDate(tmpNow_to);
		if(inVO.getViewFromDate() == null || inVO.getViewFromDate().equals("")){
			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate");
			inVO.setViewFromDate(nowVO.getNow_from());
			inVO.setViewToDate(nowVO.getNow_to());
			inVO.setViewFromYear(nowVO.getYear_from());
			inVO.setViewToYear(nowVO.getYear_to());
			inVO.setBasicYN("Y");
		}else{
			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate2", inVO);
			inVO.setViewFromYear(nowVO.getYear_from());
			inVO.setViewToYear(nowVO.getYear_to());
		}
		List<MisResultPtnrVO> MisResultPtnrMbr = sqlSession.selectList("MisResultPtnrMapper.MisResultPtnrMbr", inVO);
		model.addAttribute("MisResultPtnrMbr",MisResultPtnrMbr);

//		model.addAttribute("nowVO", nowVO);

		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_result_ptnr_mbr";
	}
}//class
