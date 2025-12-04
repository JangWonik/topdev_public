/*
*********************************************************
* Program ID	: PrimbizSuimListController
* Program Name	: PrimbizSuimListController
* Description	: 농작물 수임대장 리스트
* Author		: 
* Date			: 2016.06.09.
*********************************************************
*/
package kr.co.toplac.topcostnew;

import java.util.List;
import java.util.Map;

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

import kr.co.toplac.topstatistics.MisTmBscViewVO;
import kr.co.toplac.topstatistics.StatisticsNowVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;

@Controller
public class TopCostStatisticsController {

	private static final Logger logger = LoggerFactory.getLogger(TopCostStatisticsController.class);

	@Autowired
	private SqlSession sqlSession;

	/*
	*********************************************************
	* Program ID	: topCostStatistics
	* Program Name	: topCostStatistics
	* Description	: 경비통계
	* Author		: 
	* Date			: 2017.01.06.
	*********************************************************
	*/
	@RequestMapping(value = "topCostStatistics", method = RequestMethod.GET)
	public String topCostStatistics(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= topCostStatistics =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || mbrVo.getUser_no() == ""){
			logger.info("topCostStatistics - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		/*
		String srch_flag = StringUtil.null2blank(request.getParameter("srch_flag"));
		System.out.println(srch_flag + ":플래그값");
		if("".equals(srch_flag)){
			srch_flag = "1";
		}
		paramMap.put("srch_flag", srch_flag);
		model.addAttribute("srch_flag", srch_flag);
		*/
		
		//==========================================
		//	엑셀 처리
		//==========================================
		String excelYN = StringUtil.null2blank(request.getParameter("excelYN"));  //엑셀다운 여부
        
        if ("".equals(excelYN)){
            excelYN = "N";
        }

		if(inVO.getViewFromDate() == null || inVO.getViewFromDate().equals("")){
			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate");
			inVO.setViewFromDate(nowVO.getNow_from());
			inVO.setViewToDate(nowVO.getNow_to());
		}
		
		//경비내역 가져오기
		List<TopCostStatisticsVO> getTCStm0 = sqlSession.selectList("TopCostStatisticsMapper.getTCStm0", inVO);
		List<TopCostStatisticsVO> getTCStm1 = sqlSession.selectList("TopCostStatisticsMapper.getTCStm1", inVO);
		List<TopCostStatisticsVO> getTCStm4 = sqlSession.selectList("TopCostStatisticsMapper.getTCStm4", inVO);
		
		//클레임교통비내역 가져오기
		List<TopCostStatisticsVO> getTCStmClaim0 = sqlSession.selectList("TopCostStatisticsMapper.getTCStmClaim0", inVO);
		List<TopCostStatisticsVO> getTCStmClaim1 = sqlSession.selectList("TopCostStatisticsMapper.getTCStmClaim1", inVO);
		List<TopCostStatisticsVO> getTCStmClaim4 = sqlSession.selectList("TopCostStatisticsMapper.getTCStmClaim4", inVO);
		
		//추가경비내역 가져오기
		List<TopCostStatisticsVO> getTCStmAdd0 = sqlSession.selectList("TopCostStatisticsMapper.getTCStmAdd0", inVO);
		List<TopCostStatisticsVO> getTCStmAdd1 = sqlSession.selectList("TopCostStatisticsMapper.getTCStmAdd1", inVO);
		List<TopCostStatisticsVO> getTCStmAdd4 = sqlSession.selectList("TopCostStatisticsMapper.getTCStmAdd4", inVO);
		
		//직원리스트 가져오기
		List<TopTmBscVO> topMbrList = sqlSession.selectList("NewCostListMapper.getMbrList",paramMap);		
		
		//팀 정보 가져오기
//		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
		List<TopTmBscVO> topTeamList = sqlSession.selectList("SuimRegInsMapper.topTeamList",paramMap);	
		String team_id= String.valueOf(paramMap.get("team_id")); 
		List<TopMbrBscVO>  mbrList = sqlSession.selectList("SuimRegInsMapper.getThisTeamMbr",team_id);
		
		//===============================================
        // 뷰단 데이터 세팅
        //===============================================           
        model.addAttribute("getTCStm0", getTCStm0);
        model.addAttribute("getTCStm1", getTCStm1);
        model.addAttribute("getTCStm4", getTCStm4);
        model.addAttribute("getTCStmClaim0", getTCStmClaim0);
        model.addAttribute("getTCStmClaim1", getTCStmClaim1);
        model.addAttribute("getTCStmClaim4", getTCStmClaim4);
        model.addAttribute("getTCStmAdd0", getTCStmAdd0);
        model.addAttribute("getTCStmAdd1", getTCStmAdd1);
        model.addAttribute("getTCStmAdd4", getTCStmAdd4);
        model.addAttribute("inVO", inVO);
        model.addAttribute("srchArg",paramMap);
//        model.addAttribute("teamList",teamList);
        model.addAttribute("mbrList",mbrList);
        model.addAttribute("topTeamList",topTeamList);
        model.addAttribute("topMbrList",topMbrList);
        
        
        String retURL = "top_cost_new/top_cost_statistics";
        
        if ("Y".equals(excelYN)){
            retURL = "top_cost_new/top_cost_statistics_excel";
        }
        return retURL;
		
	}//topCostStatistics

	@RequestMapping(value = "/topCostStatisticsTmMbr", method = RequestMethod.GET)
	public String topCostStatisticsTmMbr(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= topCostStatisticsTmMbr =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || mbrVo.getUser_no() == ""){
			logger.info("topCostStatisticsTmMbr - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
//		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		/*
		String srch_flag = StringUtil.null2blank(request.getParameter("srch_flag"));
		System.out.println(srch_flag + ":플래그값");
		if("".equals(srch_flag)){
			srch_flag = "1";
		}
		paramMap.put("srch_flag", srch_flag);
		model.addAttribute("srch_flag", srch_flag);
		*/
		
		if(inVO.getViewFromDate() == null || inVO.getViewFromDate().equals("")){
			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate");
			inVO.setViewFromDate(nowVO.getNow_from());
			inVO.setViewToDate(nowVO.getNow_to());
		}
		
		//직원리스트 가져오기
		List<TopTmBscVO> topMbrList = sqlSession.selectList("NewCostListMapper.getMbrList",paramMap);		
		
		//팀 정보 가져오기
		TopCostStatisticsVO getTeamInfo = sqlSession.selectOne("TopCostStatisticsMapper.getTeamInfo", inVO);
		List<TopTmBscVO> topTeamList = sqlSession.selectList("SuimRegInsMapper.topTeamList",paramMap);	
		String team_id= String.valueOf(paramMap.get("team_id")); 
		List<TopMbrBscVO>  mbrList = sqlSession.selectList("SuimRegInsMapper.getThisTeamMbr",team_id);
		
		//경비내역 가져오기
		List<TopCostStatisticsVO> getTCStmMbr = sqlSession.selectList("TopCostStatisticsMapper.getTCStmMbr", inVO);

		//클레임교통비내역 가져오기
		List<TopCostStatisticsVO> getTCStmMbrClaim = sqlSession.selectList("TopCostStatisticsMapper.getTCStmMbrClaim", inVO);
		
		//추가경비내역 가져오기
		List<TopCostStatisticsVO> getTCStmAddMbr = sqlSession.selectList("TopCostStatisticsMapper.getTCStmAddMbr", inVO);
		
		//===============================================
        // 뷰단 데이터 세팅
        //=============================================== 
//		model.addAttribute("teamList", teamList);
		model.addAttribute("getTeamInfo", getTeamInfo);
		model.addAttribute("getTCStmMbr", getTCStmMbr);  
		model.addAttribute("getTCStmMbrClaim", getTCStmMbrClaim);
		model.addAttribute("getTCStmAddMbr", getTCStmAddMbr);
		model.addAttribute("inVO", inVO);
		model.addAttribute("mbrList", mbrList);
		model.addAttribute("topTeamList", topTeamList);
		model.addAttribute("topMbrList", topMbrList);
		
		
		return "top_cost_new/top_cost_statistics_tm_mbr";
	}//topCostStatisticsTmMbr

}//class
