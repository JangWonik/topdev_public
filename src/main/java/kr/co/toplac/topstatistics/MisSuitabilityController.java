package kr.co.toplac.topstatistics;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
public class MisSuitabilityController {

	private static final Logger logger = LoggerFactory.getLogger(MisSuitabilityController.class);

	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value = "/getMisSuitabilityTm", method = RequestMethod.GET)
	public String getMisSuitabilityTm(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= getMisSuitabilityTm =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			logger.info("getMisContractTm - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		if(inVO.getViewFromDate() == null || inVO.getViewFromDate().equals("")){
			DateFormat tmpFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date tmpToday = new Date();
			String tmpNow_to = tmpFormat.format(tmpToday);

			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsSuitDate", tmpNow_to);
			inVO.setViewFromDate(nowVO.getNow_from());
			inVO.setViewToDate(nowVO.getNow_to());
			inVO.setViewFromYear(nowVO.getYear_from());
			inVO.setViewToYear(nowVO.getYear_to());
		}else{
			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsSuitDate2", inVO);
			inVO.setViewFromYear(nowVO.getYear_from());
			inVO.setViewToYear(nowVO.getYear_to());
		}

		List<MisContractVO> getMisSuitabilityTm1 = sqlSession.selectList("MisSuitabilityTmMapper.getMisSuitabilityTm1", inVO);
		model.addAttribute("getMisSuitabilityTm1",getMisSuitabilityTm1);

		List<MisContractVO> getMisSuitabilityTm4 = sqlSession.selectList("MisSuitabilityTmMapper.getMisSuitabilityTm4", inVO);
		model.addAttribute("getMisSuitabilityTm4",getMisSuitabilityTm4);

		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_suitability_tm";
	}//getMisContractTm

	@RequestMapping(value = "/getMisSuitabilityTmMbr", method = RequestMethod.GET)
	public String getMisSuitabilityTmMbr(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= getMisSuitabilityTmMbr =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			logger.info("getMisContractTmMbr - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_force_logout";
		}

		if(inVO.getViewFromDate() == null || inVO.getViewFromDate().equals("")){
			DateFormat tmpFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date tmpToday = new Date();
			String tmpNow_to = tmpFormat.format(tmpToday);

			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsSuitDate", tmpNow_to);
			inVO.setViewFromDate(nowVO.getNow_from());
			inVO.setViewToDate(nowVO.getNow_to());
			inVO.setViewFromYear(nowVO.getYear_from());
			inVO.setViewToYear(nowVO.getYear_to());
		}else{
			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsSuitDate2", inVO);
			inVO.setViewFromYear(nowVO.getYear_from());
			inVO.setViewToYear(nowVO.getYear_to());
		}

		List<String> getMisTmMbrList = sqlSession.selectList("MisTmBscMbrMapper.getMisTmMbrList", inVO);
		List<MisSuitabilityVO> getMisSuitabilityTmMbr = null;
		if(getMisTmMbrList.size() > 0){
			getMisSuitabilityTmMbr = new ArrayList<MisSuitabilityVO>();
		}
		for(int i = 0; i < getMisTmMbrList.size(); i++){
			inVO.setUser_no(getMisTmMbrList.get(i));
			MisSuitabilityVO tmpVO = sqlSession.selectOne("MisSuitabilityTmMbrMapper.getMisSuitabilityTmMbr", inVO);
			getMisSuitabilityTmMbr.add(tmpVO);
		}
		if(getMisSuitabilityTmMbr != null){
			model.addAttribute("getMisSuitabilityTmMbr",getMisSuitabilityTmMbr);
		}

		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_suitability_tm_mbr";
	}//getMisContractTmMbr
	
	@RequestMapping(value = "/getMisSuitabilityTmMbr2", method = RequestMethod.GET)
	public String getMisSuitabilityTmMbr2(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= getMisSuitabilityTmMbr2 =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			logger.info("getMisContractTmMbr - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_force_logout";
		}

		if(inVO.getViewFromDate() == null || inVO.getViewFromDate().equals("")){
			DateFormat tmpFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date tmpToday = new Date();
			String tmpNow_to = tmpFormat.format(tmpToday);

			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsSuitDate", tmpNow_to);
			inVO.setViewFromDate(nowVO.getNow_from());
			inVO.setViewToDate(nowVO.getNow_to());
			inVO.setViewFromYear(nowVO.getYear_from());
			inVO.setViewToYear(nowVO.getYear_to());
		}else{
			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsSuitDate2", inVO);
			inVO.setViewFromYear(nowVO.getYear_from());
			inVO.setViewToYear(nowVO.getYear_to());
		}

			List<MisSuitabilityVO> getMisSuitabilityTmMbr2 = sqlSession.selectList("MisSuitabilityTmMbr2Mapper.getMisSuitabilityTmMbr2", inVO);
			model.addAttribute("getMisSuitabilityTmMbr2",getMisSuitabilityTmMbr2);
		
		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_suitability_tm_mbr2";
	}//getMisContractTmMbr
	
	@RequestMapping(value = "/getMisSuitabilityUnitMbr", method = RequestMethod.GET)
	public String getMisSuitabilityUnitMbr(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= getMisSuitabilityUnitMbr =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			logger.info("getMisContractTmMbr - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_force_logout";
		}

		if(inVO.getViewFromDate() == null || inVO.getViewFromDate().equals("")){
			DateFormat tmpFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date tmpToday = new Date();
			String tmpNow_to = tmpFormat.format(tmpToday);

			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsSuitDate", tmpNow_to);
			inVO.setViewFromDate(nowVO.getNow_from());
			inVO.setViewToDate(nowVO.getNow_to());
			inVO.setViewFromYear(nowVO.getYear_from());
			inVO.setViewToYear(nowVO.getYear_to());
		}else{
			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsSuitDate2", inVO);
			inVO.setViewFromYear(nowVO.getYear_from());
			inVO.setViewToYear(nowVO.getYear_to());
		}
		List<MisSuitabilityVO> getMisSuitabilityUnitMbr = sqlSession.selectList("MisSuitabilityUnitMbrMapper.getMisSuitabilityUnitMbr", inVO);
		model.addAttribute("getMisSuitabilityUnitMbr",getMisSuitabilityUnitMbr);
		

		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_suitability_unit_mbr";
	}//getMisContractTmMbr

}//class
