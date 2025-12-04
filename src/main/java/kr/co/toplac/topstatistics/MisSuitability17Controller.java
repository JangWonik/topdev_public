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
public class MisSuitability17Controller {

	private static final Logger logger = LoggerFactory.getLogger(MisSuitability17Controller.class);

	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value = "/getMisSuitability17Tm", method = RequestMethod.GET)
	public String getMisSuitability17Tm(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= getMisSuitability17Tm =======");
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

		List<MisContractVO> getMisSuitability17Tm1 = sqlSession.selectList("MisSuitability17TmMapper.getMisSuitability17Tm1", inVO);
		model.addAttribute("getMisSuitability17Tm1",getMisSuitability17Tm1);

		List<MisContractVO> getMisSuitability17Tm4 = sqlSession.selectList("MisSuitability17TmMapper.getMisSuitability17Tm4", inVO);
		model.addAttribute("getMisSuitability17Tm4",getMisSuitability17Tm4);

		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_suitability17_tm";
	}//getMisContractTm

	@RequestMapping(value = "/getMisSuitability17TmMbr", method = RequestMethod.GET)
	public String getMisSuitability17TmMbr(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= getMisSuitability17TmMbr =======");
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
		List<MisSuitability17VO> getMisSuitability17TmMbr = null;
		if(getMisTmMbrList.size() > 0){
			getMisSuitability17TmMbr = new ArrayList<MisSuitability17VO>();
		}
		for(int i = 0; i < getMisTmMbrList.size(); i++){
			inVO.setUser_no(getMisTmMbrList.get(i));
			MisSuitability17VO tmpVO = sqlSession.selectOne("MisSuitability17TmMbrMapper.getMisSuitability17TmMbr", inVO);
			getMisSuitability17TmMbr.add(tmpVO);
		}
		if(getMisSuitability17TmMbr != null){
			model.addAttribute("getMisSuitability17TmMbr",getMisSuitability17TmMbr);
		}

		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_suitability17_tm_mbr";
	}//getMisContractTmMbr
	
	@RequestMapping(value = "/getMisSuitability17TmMbr2", method = RequestMethod.GET)
	public String getMisSuitability17TmMbr2(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= getMisSuitability17TmMbr2 =======");
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

			List<MisSuitability17VO> getMisSuitability17TmMbr2 = sqlSession.selectList("MisSuitability17TmMbr2Mapper.getMisSuitability17TmMbr2", inVO);
			model.addAttribute("getMisSuitability17TmMbr2",getMisSuitability17TmMbr2);
		
		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_suitability17_tm_mbr2";
	}//getMisContractTmMbr
	
	@RequestMapping(value = "/getMisSuitability17UnitMbr", method = RequestMethod.GET)
	public String getMisSuitability17UnitMbr(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= getMisSuitability17UnitMbr =======");
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
		List<MisSuitability17VO> getMisSuitability17UnitMbr = sqlSession.selectList("MisSuitability17UnitMbrMapper.getMisSuitability17UnitMbr", inVO);
		model.addAttribute("getMisSuitability17UnitMbr",getMisSuitability17UnitMbr);
		

		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_suitability17_unit_mbr";
	}//getMisContractTmMbr

}//class
