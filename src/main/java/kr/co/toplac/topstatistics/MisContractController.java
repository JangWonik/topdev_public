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
public class MisContractController {

	private static final Logger logger = LoggerFactory.getLogger(MisContractController.class);

	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value = "/getMisContractTm", method = RequestMethod.GET)
	public String getMisContractTm(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= getMisContractTm =======");
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

		List<MisContractVO> getMisContractTm1 = sqlSession.selectList("MisContractTmMapper.getMisContractTm1", inVO);
		model.addAttribute("getMisContractTm1",getMisContractTm1);

		List<MisContractVO> getMisContractTm4 = sqlSession.selectList("MisContractTmMapper.getMisContractTm4", inVO);
		model.addAttribute("getMisContractTm4",getMisContractTm4);

		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_contract_tm";
	}//getMisContractTm

	@RequestMapping(value = "/getMisContractTmMbr", method = RequestMethod.GET)
	public String getMisContractTmMbr(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= getMisContractTmMbr =======");
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
		List<MisContractVO> getMisContractTmMbr = null;
		if(getMisTmMbrList.size() > 0){
			getMisContractTmMbr = new ArrayList<MisContractVO>();
		}
		for(int i = 0; i < getMisTmMbrList.size(); i++){
			inVO.setUser_no(getMisTmMbrList.get(i));
			MisContractVO tmpVO = sqlSession.selectOne("MisContractTmMbrMapper.getMisContractTmMbr", inVO);
			getMisContractTmMbr.add(tmpVO);
		}
		if(getMisContractTmMbr != null){
			model.addAttribute("getMisContractTmMbr",getMisContractTmMbr);
		}

		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_contract_tm_mbr";
	}//getMisContractTmMbr
	
	@RequestMapping(value = "/getMisContractTmMbr2", method = RequestMethod.GET)
	public String getMisContractTmMbr2(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= getMisContractTmMbr2 =======");
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

//		List<String> getMisTmMbrList = sqlSession.selectList("MisTmBscMbrMapper.getMisTmMbrList", inVO);
//		List<MisContractVO> getMisContractTmMbr = null;
		/*if(getMisTmMbrList.size() > 0){
			getMisContractTmMbr = new ArrayList<MisContractVO>();
		}
		for(int i = 0; i < getMisTmMbrList.size(); i++){*/
			List<MisContractVO> getMisContractTmMbr2 = sqlSession.selectList("MisContractTmMbr2Mapper.getMisContractTmMbr2", inVO);
			model.addAttribute("getMisContractTmMbr2",getMisContractTmMbr2);
		
			/*}
		if(getMisContractTmMbr != null){
		}*/

		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_contract_tm_mbr2";
	}//getMisContractTmMbr
	
	@RequestMapping(value = "/getMisContractUnitMbr", method = RequestMethod.GET)
	public String getMisContractUnitMbr(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= getMisContractUnitMbr =======");
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
		List<MisContractVO> getMisContractUnitMbr = sqlSession.selectList("MisContractUnitMbrMapper.getMisContractUnitMbr", inVO);
		model.addAttribute("getMisContractUnitMbr",getMisContractUnitMbr);
		

		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_contract_unit_mbr";
	}//getMisContractTmMbr

}//class
