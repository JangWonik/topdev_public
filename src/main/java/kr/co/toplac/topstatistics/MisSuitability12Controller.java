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
public class MisSuitability12Controller {

	private static final Logger logger = LoggerFactory.getLogger(MisSuitability12Controller.class);

	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value = "/getMisSuitability12Tm", method = RequestMethod.GET)
	public String getMisSuitability12Tm(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= getMisSuitability12Tm =======");
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

		List<MisContractVO> getMisSuitability12Tm1 = sqlSession.selectList("MisSuitability12TmMapper.getMisSuitability12Tm1", inVO);
		model.addAttribute("getMisSuitability12Tm1",getMisSuitability12Tm1);

		List<MisContractVO> getMisSuitability12Tm4 = sqlSession.selectList("MisSuitability12TmMapper.getMisSuitability12Tm4", inVO);
		model.addAttribute("getMisSuitability12Tm4",getMisSuitability12Tm4);

		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_suitability12_tm";
	}//getMisContractTm

	@RequestMapping(value = "/getMisSuitability12TmMbr", method = RequestMethod.GET)
	public String getMisSuitability12TmMbr(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= getMisSuitability12TmMbr =======");
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
		List<MisSuitability12VO> getMisSuitability12TmMbr = null;
		if(getMisTmMbrList.size() > 0){
			getMisSuitability12TmMbr = new ArrayList<MisSuitability12VO>();
		}
		for(int i = 0; i < getMisTmMbrList.size(); i++){
			inVO.setUser_no(getMisTmMbrList.get(i));
			MisSuitability12VO tmpVO = sqlSession.selectOne("MisSuitability12TmMbrMapper.getMisSuitability12TmMbr", inVO);
			getMisSuitability12TmMbr.add(tmpVO);
		}
		if(getMisSuitability12TmMbr != null){
			model.addAttribute("getMisSuitability12TmMbr",getMisSuitability12TmMbr);
		}

		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_suitability12_tm_mbr";
	}//getMisContractTmMbr
	
	@RequestMapping(value = "/getMisSuitability12TmMbr2", method = RequestMethod.GET)
	public String getMisSuitability12TmMbr2(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= getMisSuitability12TmMbr2 =======");
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

			List<MisSuitability12VO> getMisSuitability12TmMbr2 = sqlSession.selectList("MisSuitability12TmMbr2Mapper.getMisSuitability12TmMbr2", inVO);
			model.addAttribute("getMisSuitability12TmMbr2",getMisSuitability12TmMbr2);
		
		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_suitability12_tm_mbr2";
	}//getMisContractTmMbr
	
	@RequestMapping(value = "/getMisSuitability12UnitMbr", method = RequestMethod.GET)
	public String getMisSuitability12UnitMbr(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= getMisSuitability12UnitMbr =======");
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
		List<MisSuitability12VO> getMisSuitability12UnitMbr = sqlSession.selectList("MisSuitability12UnitMbrMapper.getMisSuitability12UnitMbr", inVO);
		model.addAttribute("getMisSuitability12UnitMbr",getMisSuitability12UnitMbr);
		

		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_suitability12_unit_mbr";
	}//getMisContractTmMbr
	

}//class
