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
import kr.co.toplac.topteam.TopTmBscVO;

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
public class MisTmBscController {

	private static final Logger logger = LoggerFactory.getLogger(MisTmBscController.class);

	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value = "/getMisTmBsc", method = RequestMethod.GET)
	public String getMisTmBsc(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= getMisTmBsc =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			logger.info("getMisTmBsc - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
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
		

//		if(inVO.getBasicYN() != null && inVO.getBasicYN().equals("Y")){
			List<MisTmBscVO> getMisTmBsc1 = sqlSession.selectList("MisTmBscMapper.getMisTmBsc1", inVO);
			model.addAttribute("getMisTmBsc1",getMisTmBsc1);
	
			List<MisTmBscVO> getMisTmBsc4 = sqlSession.selectList("MisTmBscMapper.getMisTmBsc4", inVO);
			model.addAttribute("getMisTmBsc4",getMisTmBsc4);
//		}

//		if(inVO.getPrimYN() != null && inVO.getPrimYN().equals("Y")){
//			List<MisTmBscVO> getMisTmBscPrim1 = sqlSession.selectList("MisTmBscMapper.getMisTmBscPrim1", inVO);
//			model.addAttribute("getMisTmBscPrim1",getMisTmBscPrim1);
			
//			List<MisTmBscVO> getMisTmBscPrim4 = sqlSession.selectList("MisTmBscMapper.getMisTmBscPrim4", inVO);
//			model.addAttribute("getMisTmBscPrim4",getMisTmBscPrim4);
//		}

//		if(inVO.getPrimContractYN() != null && inVO.getPrimContractYN().equals("Y")){
//			List<MisTmBscVO> getMisTmBscPrimContract1 = sqlSession.selectList("MisTmBscMapper.getMisTmBscPrimContract1", inVO);
//			model.addAttribute("getMisTmBscPrimContract1",getMisTmBscPrimContract1);

//			List<MisTmBscVO> getMisTmBscPrimContract4 = sqlSession.selectList("MisTmBscMapper.getMisTmBscPrimContract4", inVO);
//			model.addAttribute("getMisTmBscPrimContract4",getMisTmBscPrimContract4);
//		}

		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_tm_bsc";
	}//getMisTmBsc

	@RequestMapping(value = "/getMisTmBscMbr", method = RequestMethod.GET)
	public String getMisTmBscMbr(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= getMisTmBscMbr =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			logger.info("getMisTmBscMbr - no permession user_no : "+request.getRemoteAddr());
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

//		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
//		model.addAttribute("teamList", teamList);

//		if(inVO.getBasicYN() != null && inVO.getBasicYN().equals("Y")){
			List<String> getMisTmMbrList = sqlSession.selectList("MisTmBscMbrMapper.getMisTmMbrList", inVO);
			List<MisTmBscVO> getMisTmBscMbr = null;
			if(getMisTmMbrList.size() > 0){
				getMisTmBscMbr = new ArrayList<MisTmBscVO>();
			}
			if(inVO.getTeam_type() != null && inVO.getTeam_type().equals("1")){
				for(int i = 0; i < getMisTmMbrList.size(); i++){
					inVO.setUser_no(getMisTmMbrList.get(i));
					MisTmBscVO tmpVO = sqlSession.selectOne("MisTmBscMbrMapper.getMisTmBscMbr1", inVO);
					getMisTmBscMbr.add(tmpVO);
				}
			}else{
				for(int i = 0; i < getMisTmMbrList.size(); i++){
					inVO.setUser_no(getMisTmMbrList.get(i));
					MisTmBscVO tmpVO = sqlSession.selectOne("MisTmBscMbrMapper.getMisTmBscMbr4", inVO);
					getMisTmBscMbr.add(tmpVO);
				}
			}
			if(getMisTmBscMbr != null){
				model.addAttribute("getMisTmBscMbr",getMisTmBscMbr);
			}
//		}

//		if(inVO.getPrimYN() != null && inVO.getPrimYN().equals("Y")){
//			List<MisTmBscVO> getMisTmBscMbrPrim = sqlSession.selectList("MisTmBscMbrMapper.getMisTmBscMbrPrim", inVO);
//			model.addAttribute("getMisTmBscMbrPrim",getMisTmBscMbrPrim);
//		}

//		if(inVO.getPrimContractYN() != null && inVO.getPrimContractYN().equals("Y")){
//			List<MisTmBscVO> getMisTmBscMbrPrimContract = sqlSession.selectList("MisTmBscMbrMapper.getMisTmBscMbrPrimContract", inVO);
//			model.addAttribute("getMisTmBscMbrPrimContract",getMisTmBscMbrPrimContract);
//		}

		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_tm_bsc_mbr";
	}//getMisTmBscMbr

	@RequestMapping(value = "/getMisTmBscMbr2", method = RequestMethod.GET)
	public String getMisTmBscMbr2(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= getMisTmBscMbr2 =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			logger.info("getMisTmBscMbr2 - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
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

//		List<TopTmBscVO> teamMemberList = sqlSession.selectList("MisTmBscMbr2Mapper.teamMemberList", inVO);
//		model.addAttribute("teamMemberList", teamMemberList);



		List<LogMember2VO> getMisTmBscMbr2141 = sqlSession.selectList("MisTmBscMbr2Mapper.getMisTmBscMbr2141", inVO);
		model.addAttribute("getMisTmBscMbr2141", getMisTmBscMbr2141);

		List<LogMember2VO> getMisTmBscMbr2142 = sqlSession.selectList("MisTmBscMbr2Mapper.getMisTmBscMbr2142", inVO);
		model.addAttribute("getMisTmBscMbr2142", getMisTmBscMbr2142);
		
		List<LogMember2VO> getMisTmBscMbr2Mi = sqlSession.selectList("MisTmBscMbr2Mapper.getMisTmBscMbr2Mi", inVO);
		model.addAttribute("getMisTmBscMbr2Mi", getMisTmBscMbr2Mi);



//		List<LogMember2VO> getMisTmBscMbr2Prim1 = sqlSession.selectList("MisTmBscMbr2Mapper.getMisTmBscMbr2Prim1", inVO);
//		model.addAttribute("getMisTmBscMbr2Prim1", getMisTmBscMbr2Prim1);

//		List<LogMember2VO> getMisTmBscMbr2Prim2 = sqlSession.selectList("MisTmBscMbr2Mapper.getMisTmBscMbr2Prim2", inVO);
//		model.addAttribute("getMisTmBscMbr2Prim2", getMisTmBscMbr2Prim2);

//		List<LogMember2VO> getMisTmBscMbr2MiPrim = sqlSession.selectList("MisTmBscMbr2Mapper.getMisTmBscMbr2MiPrim", inVO);
//		model.addAttribute("getMisTmBscMbr2MiPrim", getMisTmBscMbr2MiPrim);



//		List<LogMember2VO> getMisTmBscMbr2PrimContract1 = sqlSession.selectList("MisTmBscMbr2Mapper.getMisTmBscMbr2PrimContract1", inVO);
//		model.addAttribute("getMisTmBscMbr2PrimContract1", getMisTmBscMbr2PrimContract1);

//		List<LogMember2VO> getMisTmBscMbr2PrimContract2 = sqlSession.selectList("MisTmBscMbr2Mapper.getMisTmBscMbr2PrimContract2", inVO);
//		model.addAttribute("getMisTmBscMbr2PrimContract2", getMisTmBscMbr2PrimContract2);

//		List<LogMember2VO> getMisTmBscMbr2MiPrimContract = sqlSession.selectList("MisTmBscMbr2Mapper.getMisTmBscMbr2MiPrimContract", inVO);
//		model.addAttribute("getMisTmBscMbr2MiPrimContract", getMisTmBscMbr2MiPrimContract);



		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_tm_bsc_mbr_2";
	}//getMisTmBscMbr2

}//class
