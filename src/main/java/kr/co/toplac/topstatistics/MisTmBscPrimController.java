package kr.co.toplac.topstatistics;

import java.util.ArrayList;
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

import kr.co.toplac.lslog.LogMember2VO;
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
public class MisTmBscPrimController {

	private static final Logger logger = LoggerFactory.getLogger(MisTmBscPrimController.class);

	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value = "/getMisTmBscPrim", method = RequestMethod.GET)
	public String getMisTmBscPrim(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= getMisTmBscPrim =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			logger.info("getMisTmBscPrim - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_force_logout";
		}

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

		List<MisTmBscVO> getMisTmBscPrim1 = sqlSession.selectList("MisTmBscPrimMapper.getMisTmBscPrim1", inVO);
		model.addAttribute("getMisTmBscPrim1",getMisTmBscPrim1);

		List<MisTmBscVO> getMisTmBscPrim4 = sqlSession.selectList("MisTmBscPrimMapper.getMisTmBscPrim4", inVO);
		model.addAttribute("getMisTmBscPrim4",getMisTmBscPrim4);

		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_tm_bsc_prim";
	}//getMisTmBscPrim

	@RequestMapping(value = "/getMisTmBscPrimMbr", method = RequestMethod.GET)
	public String getMisTmBscPrimMbr(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= getMisTmBscPrimMbr =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			logger.info("getMisTmBscPrimMbr - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_force_logout";
		}

		if(inVO.getViewFromDate() == null || inVO.getViewFromDate().equals("")){
			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate");
			inVO.setViewFromDate(nowVO.getNow_from());
			inVO.setViewToDate(nowVO.getNow_to());
			inVO.setViewFromYear(nowVO.getYear_from());
			inVO.setViewToYear(nowVO.getYear_to());
		}else{
			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate2", inVO);
			inVO.setViewFromYear(nowVO.getYear_from());
			inVO.setViewToYear(nowVO.getYear_to());
		}

		List<String> getMisPrimTmMbrList = sqlSession.selectList("MisTmBscPrimMbrMapper.getMisPrimTmMbrList", inVO);
		List<MisTmBscVO> getMisTmBscMbr = null;
		if(getMisPrimTmMbrList.size() > 0){
			getMisTmBscMbr = new ArrayList<MisTmBscVO>();
		}
		if(inVO.getTeam_type() != null && inVO.getTeam_type().equals("1")){
			for(int i = 0; i < getMisPrimTmMbrList.size(); i++){
				inVO.setUser_no(getMisPrimTmMbrList.get(i));
				MisTmBscVO tmpVO = sqlSession.selectOne("MisTmBscPrimMbrMapper.getMisTmBscPrimMbr1", inVO);
				getMisTmBscMbr.add(tmpVO);
			}
		}else{
			for(int i = 0; i < getMisPrimTmMbrList.size(); i++){
				inVO.setUser_no(getMisPrimTmMbrList.get(i));
				MisTmBscVO tmpVO = sqlSession.selectOne("MisTmBscPrimMbrMapper.getMisTmBscPrimMbr4", inVO);
				getMisTmBscMbr.add(tmpVO);
			}
		}
		if(getMisTmBscMbr != null){
			model.addAttribute("getMisTmBscMbr",getMisTmBscMbr);
		}

		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_tm_bsc_prim_mbr";
	}//getMisTmBscPrimMbr

	@RequestMapping(value = "/getMisTmBscPrimMbr2", method = RequestMethod.GET)
	public String getMisTmBscPrimMbr2(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= getMisTmBscPrimMbr2 =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			logger.info("getMisTmBscPrimMbr2 - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_force_logout";
		}

		if(inVO.getViewFromDate() == null || inVO.getViewFromDate().equals("")){
			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate");
			inVO.setViewFromDate(nowVO.getNow_from());
			inVO.setViewToDate(nowVO.getNow_to());
			inVO.setViewFromYear(nowVO.getYear_from());
			inVO.setViewToYear(nowVO.getYear_to());
		}else{
			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate2", inVO);
			inVO.setViewFromYear(nowVO.getYear_from());
			inVO.setViewToYear(nowVO.getYear_to());
		}

		List<String> getMisPrimTmMbrList = sqlSession.selectList("MisTmBscPrimMbrMapper.getMisPrimTmMbr2List", inVO);
		List<MisTmBscVO> getMisTmBscMbr = null;
		if(getMisPrimTmMbrList.size() > 0){
			getMisTmBscMbr = new ArrayList<MisTmBscVO>();
		}
		for(int i = 0; i < getMisPrimTmMbrList.size(); i++){
			inVO.setUser_no(getMisPrimTmMbrList.get(i));
			MisTmBscVO tmpVO = sqlSession.selectOne("MisTmBscPrimMbrMapper.getMisTmBscPrimMbr_2", inVO);
			getMisTmBscMbr.add(tmpVO);
		}
		if(getMisTmBscMbr != null){
			model.addAttribute("getMisTmBscMbr",getMisTmBscMbr);
		}

		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_tm_bsc_prim_mbr_2";
	}//getMisTmBscPrimMbr2

}//class
