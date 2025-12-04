package kr.co.toplac.topcost2nd;


import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.toplac.cmm.service.CodeDicService;
import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.sysadm.SysAdmCodeDicVO;
import kr.co.toplac.topcost.TopCostCompositeVO;
import kr.co.toplac.topcostnew.NewCostViewVO;
import kr.co.toplac.topcostnew.TopCostStatisticsVO;
import kr.co.toplac.topstatistics.MisTmBscViewVO;
import kr.co.toplac.topstatistics.StatisticsNowVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;

@Controller
public class CostStatisticsController {

	private static final Logger logger = LoggerFactory.getLogger(CostStatisticsController.class);

	@Autowired
	private SqlSession sqlSession;
	
    @Autowired
    private CodeDicService service;
	
	/*
	*********************************************************
	* Program ID	: cost_statistics
	* Program Name	: cost_statistics
	* Description	: 경비통계 (2nd)
	* Author		: LDS
	* Date			: 2018.11.06. 
	*********************************************************
	*/
	@RequestMapping(value = "cost_statistics", method = RequestMethod.GET)
	public String topCostStatistics(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= cost_statistics =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || mbrVo.getUser_no() == ""){
			logger.info("topCostStatistics - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}		
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		
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
		List<TopCostStatisticsVO> getTCStm0 = sqlSession.selectList("CostStatisticsMapper.getTCStm0", inVO);
		List<TopCostStatisticsVO> getTCStm1 = sqlSession.selectList("CostStatisticsMapper.getTCStm1", inVO);
		List<TopCostStatisticsVO> getTCStm4 = sqlSession.selectList("CostStatisticsMapper.getTCStm4", inVO);
		
		//추가경비내역 가져오기
		//추가경비의 경우 청구일이 아닌, 발생일 기준
		List<TopCostStatisticsVO> getTCStmAdd0 = sqlSession.selectList("CostStatisticsMapper.getTCStmAdd0", inVO);
		List<TopCostStatisticsVO> getTCStmAdd1 = sqlSession.selectList("CostStatisticsMapper.getTCStmAdd1", inVO);
		List<TopCostStatisticsVO> getTCStmAdd4 = sqlSession.selectList("CostStatisticsMapper.getTCStmAdd4", inVO);
		
		//클레임교통비내역 가져오기
		List<TopCostStatisticsVO> getTCStmClaim0 = sqlSession.selectList("CostStatisticsMapper.getTCStmClaim0", inVO);
		List<TopCostStatisticsVO> getTCStmClaim1 = sqlSession.selectList("CostStatisticsMapper.getTCStmClaim1", inVO);
		List<TopCostStatisticsVO> getTCStmClaim4 = sqlSession.selectList("CostStatisticsMapper.getTCStmClaim4", inVO);
		
		
		//직원리스트 가져오기
		List<TopTmBscVO> topMbrList = sqlSession.selectList("NewCostListMapper.getMbrList",paramMap);		
		
		//팀 정보 가져오기
		List<TopTmBscVO> topTeamList = sqlSession.selectList("SuimRegInsMapper.topTeamList",paramMap);	
		String team_id= String.valueOf(paramMap.get("team_id")); 
		
		List<TopMbrBscVO>  mbrList = sqlSession.selectList("SuimRegInsMapper.getThisTeamMbr",team_id);
		
		//엑셀로 다운로드시 경비내역에 추가경비합계, 클래임 교통비 합계 항목을 추가한다.		
		if ("Y".equals(excelYN)){
			
			//임시 팀 아이디
			String sourceTeamId = "";
			String targetTeamId = "";
			float addCardSum = 0;
			float addCashSum = 0;
			float claimCardSum = 0;
			float claimCashSum = 0;						
			
			//본사 시작			
			for( int i=0; i < getTCStm0.size(); i++) {
				sourceTeamId = getTCStm0.get(i).getTeam_id();			
				
				//추가경비 합계
				for( int k=0; k < getTCStmAdd0.size(); k++ ) {
					targetTeamId = getTCStmAdd0.get(k).getTeam_id();					
					
					//팀아이디가 일치하는 경우만 합산값을 더한다.
					if( targetTeamId.equals(sourceTeamId) ) {
						addCardSum = Float.parseFloat(getTCStmAdd0.get(k).getCard11())
											+Float.parseFloat(getTCStmAdd0.get(k).getCard21())
											+Float.parseFloat(getTCStmAdd0.get(k).getCard31())
											+Float.parseFloat(getTCStmAdd0.get(k).getCard41())
											+Float.parseFloat(getTCStmAdd0.get(k).getCard51())
											+Float.parseFloat(getTCStmAdd0.get(k).getCard61())
											+Float.parseFloat(getTCStmAdd0.get(k).getCard71())
											+Float.parseFloat(getTCStmAdd0.get(k).getCard81())
											+Float.parseFloat(getTCStmAdd0.get(k).getCard91())											
											+Float.parseFloat(getTCStmAdd0.get(k).getCard101())
											+Float.parseFloat(getTCStmAdd0.get(k).getCard111())
											+Float.parseFloat(getTCStmAdd0.get(k).getCard121())
											+Float.parseFloat(getTCStmAdd0.get(k).getCard131());
						addCashSum = Float.parseFloat(getTCStmAdd0.get(k).getCash11())
											+Float.parseFloat(getTCStmAdd0.get(k).getCash21())
											+Float.parseFloat(getTCStmAdd0.get(k).getCash31())
											+Float.parseFloat(getTCStmAdd0.get(k).getCash41())
											+Float.parseFloat(getTCStmAdd0.get(k).getCash51())
											+Float.parseFloat(getTCStmAdd0.get(k).getCash61())
											+Float.parseFloat(getTCStmAdd0.get(k).getCash71())
											+Float.parseFloat(getTCStmAdd0.get(k).getCash81())
											+Float.parseFloat(getTCStmAdd0.get(k).getCash91())											
											+Float.parseFloat(getTCStmAdd0.get(k).getCash101())
											+Float.parseFloat(getTCStmAdd0.get(k).getCash111())
											+Float.parseFloat(getTCStmAdd0.get(k).getCash121())
											+Float.parseFloat(getTCStmAdd0.get(k).getCash131());	
					}
				}
				getTCStm0.get(i).setAddCardSum(String.valueOf(Math.round(addCardSum)));
				getTCStm0.get(i).setAddCashSum(String.valueOf(Math.round(addCashSum)));				
				
				//클레임 교통비 합계
				for( int j=0; j < getTCStmClaim0.size(); j++ ) {
					targetTeamId = getTCStmClaim0.get(j).getTeam_id();
					
					if( targetTeamId.equals(sourceTeamId) ) {
						claimCardSum = Float.parseFloat(getTCStmClaim0.get(j).getCard11())
											+Float.parseFloat(getTCStmClaim0.get(j).getCard21())
											+Float.parseFloat(getTCStmClaim0.get(j).getCard31());						
						claimCashSum = Float.parseFloat(getTCStmClaim0.get(j).getCash11())
											+Float.parseFloat(getTCStmClaim0.get(j).getCash21())
											+Float.parseFloat(getTCStmClaim0.get(j).getCash31());
					}
				}
				getTCStm0.get(i).setClaimCardSum(String.valueOf(Math.round(claimCardSum)));
				getTCStm0.get(i).setClaimCashSum(String.valueOf(Math.round(claimCashSum)));				
			}
			//본사 끝
			
			//1종 시작
			for( int i=0; i < getTCStm1.size(); i++) {
				sourceTeamId = getTCStm1.get(i).getTeam_id();			
				
				//추가경비 합계
				for( int k=0; k < getTCStmAdd1.size(); k++ ) {
					targetTeamId = getTCStmAdd1.get(k).getTeam_id();					
					
					//팀아이디가 일치하는 경우만 합산값을 더한다.
					if( targetTeamId.equals(sourceTeamId) ) {
						addCardSum = Float.parseFloat(getTCStmAdd1.get(k).getCard11())
											+Float.parseFloat(getTCStmAdd1.get(k).getCard21())
											+Float.parseFloat(getTCStmAdd1.get(k).getCard31())
											+Float.parseFloat(getTCStmAdd1.get(k).getCard41())
											+Float.parseFloat(getTCStmAdd1.get(k).getCard51())
											+Float.parseFloat(getTCStmAdd1.get(k).getCard61())
											+Float.parseFloat(getTCStmAdd1.get(k).getCard71())
											+Float.parseFloat(getTCStmAdd1.get(k).getCard81())
											+Float.parseFloat(getTCStmAdd1.get(k).getCard91())											
											+Float.parseFloat(getTCStmAdd1.get(k).getCard101())
											+Float.parseFloat(getTCStmAdd1.get(k).getCard111())
											+Float.parseFloat(getTCStmAdd1.get(k).getCard121())
											+Float.parseFloat(getTCStmAdd1.get(k).getCard131());
						addCashSum = Float.parseFloat(getTCStmAdd1.get(k).getCash11())
											+Float.parseFloat(getTCStmAdd1.get(k).getCash21())
											+Float.parseFloat(getTCStmAdd1.get(k).getCash31())
											+Float.parseFloat(getTCStmAdd1.get(k).getCash41())
											+Float.parseFloat(getTCStmAdd1.get(k).getCash51())
											+Float.parseFloat(getTCStmAdd1.get(k).getCash61())
											+Float.parseFloat(getTCStmAdd1.get(k).getCash71())
											+Float.parseFloat(getTCStmAdd1.get(k).getCash81())
											+Float.parseFloat(getTCStmAdd1.get(k).getCash91())											
											+Float.parseFloat(getTCStmAdd1.get(k).getCash101())
											+Float.parseFloat(getTCStmAdd1.get(k).getCash111())
											+Float.parseFloat(getTCStmAdd1.get(k).getCash121())
											+Float.parseFloat(getTCStmAdd1.get(k).getCash131());	
					}
				}
				getTCStm1.get(i).setAddCardSum(String.valueOf(Math.round(addCardSum)));
				getTCStm1.get(i).setAddCashSum(String.valueOf(Math.round(addCashSum)));				
				
				//클레임 교통비 합계
				for( int j=0; j < getTCStmClaim1.size(); j++ ) {
					targetTeamId = getTCStmClaim1.get(j).getTeam_id();
					
					if( targetTeamId.equals(sourceTeamId) ) {
						claimCardSum = Float.parseFloat(getTCStmClaim1.get(j).getCard11())
											+Float.parseFloat(getTCStmClaim1.get(j).getCard21())
											+Float.parseFloat(getTCStmClaim1.get(j).getCard31());						
						claimCashSum = Float.parseFloat(getTCStmClaim1.get(j).getCash11())
											+Float.parseFloat(getTCStmClaim1.get(j).getCash21())
											+Float.parseFloat(getTCStmClaim1.get(j).getCash31());
					}
				}
				getTCStm1.get(i).setClaimCardSum(String.valueOf(Math.round(claimCardSum)));
				getTCStm1.get(i).setClaimCashSum(String.valueOf(Math.round(claimCashSum)));				
			}
			//1종 끝
			
			//4종 시작
			for( int i=0; i < getTCStm4.size(); i++) {
				sourceTeamId = getTCStm4.get(i).getTeam_id();			
				
				//추가경비 합계
				for( int k=0; k < getTCStmAdd4.size(); k++ ) {
					targetTeamId = getTCStmAdd4.get(k).getTeam_id();					
					
					//팀아이디가 일치하는 경우만 합산값을 더한다.
					if( targetTeamId.equals(sourceTeamId) ) {
						addCardSum = Float.parseFloat(getTCStmAdd4.get(k).getCard11())
											+Float.parseFloat(getTCStmAdd4.get(k).getCard21())
											+Float.parseFloat(getTCStmAdd4.get(k).getCard31())
											+Float.parseFloat(getTCStmAdd4.get(k).getCard41())
											+Float.parseFloat(getTCStmAdd4.get(k).getCard51())
											+Float.parseFloat(getTCStmAdd4.get(k).getCard61())
											+Float.parseFloat(getTCStmAdd4.get(k).getCard71())
											+Float.parseFloat(getTCStmAdd4.get(k).getCard81())
											+Float.parseFloat(getTCStmAdd4.get(k).getCard91())											
											+Float.parseFloat(getTCStmAdd4.get(k).getCard101())
											+Float.parseFloat(getTCStmAdd4.get(k).getCard111())
											+Float.parseFloat(getTCStmAdd4.get(k).getCard121())
											+Float.parseFloat(getTCStmAdd4.get(k).getCard131());
						addCashSum = Float.parseFloat(getTCStmAdd4.get(k).getCash11())
											+Float.parseFloat(getTCStmAdd4.get(k).getCash21())
											+Float.parseFloat(getTCStmAdd4.get(k).getCash31())
											+Float.parseFloat(getTCStmAdd4.get(k).getCash41())
											+Float.parseFloat(getTCStmAdd4.get(k).getCash51())
											+Float.parseFloat(getTCStmAdd4.get(k).getCash61())
											+Float.parseFloat(getTCStmAdd4.get(k).getCash71())
											+Float.parseFloat(getTCStmAdd4.get(k).getCash81())
											+Float.parseFloat(getTCStmAdd4.get(k).getCash91())											
											+Float.parseFloat(getTCStmAdd4.get(k).getCash101())
											+Float.parseFloat(getTCStmAdd4.get(k).getCash111())
											+Float.parseFloat(getTCStmAdd4.get(k).getCash121())
											+Float.parseFloat(getTCStmAdd4.get(k).getCash131());	
					}
				}
				getTCStm4.get(i).setAddCardSum(String.valueOf(Math.round(addCardSum)));
				getTCStm4.get(i).setAddCashSum(String.valueOf(Math.round(addCashSum)));				
				
				//클레임 교통비 합계
				for( int j=0; j < getTCStmClaim4.size(); j++ ) {
					targetTeamId = getTCStmClaim4.get(j).getTeam_id();
					
					if( targetTeamId.equals(sourceTeamId) ) {
						claimCardSum = Float.parseFloat(getTCStmClaim4.get(j).getCard11())
											+Float.parseFloat(getTCStmClaim4.get(j).getCard21())
											+Float.parseFloat(getTCStmClaim4.get(j).getCard31());						
						claimCashSum = Float.parseFloat(getTCStmClaim4.get(j).getCash11())
											+Float.parseFloat(getTCStmClaim4.get(j).getCash21())
											+Float.parseFloat(getTCStmClaim4.get(j).getCash31());
					}
				}
				getTCStm4.get(i).setClaimCardSum(String.valueOf(Math.round(claimCardSum)));
				getTCStm4.get(i).setClaimCashSum(String.valueOf(Math.round(claimCashSum)));				
			}			
			//4종 끝
						
		}
		
		//===============================================
        // 뷰단 데이터 세팅
        //===============================================           
        model.addAttribute("getTCStm0", getTCStm0);
        model.addAttribute("getTCStm1", getTCStm1);
        model.addAttribute("getTCStm4", getTCStm4);
        model.addAttribute("getTCStmAdd0", getTCStmAdd0);
        model.addAttribute("getTCStmAdd1", getTCStmAdd1);
        model.addAttribute("getTCStmAdd4", getTCStmAdd4);
        model.addAttribute("getTCStmClaim0", getTCStmClaim0);
        model.addAttribute("getTCStmClaim1", getTCStmClaim1);
        model.addAttribute("getTCStmClaim4", getTCStmClaim4);
        model.addAttribute("inVO", inVO);
        model.addAttribute("srchArg",paramMap);
//        model.addAttribute("teamList",teamList);
        model.addAttribute("mbrList",mbrList);
        model.addAttribute("topTeamList",topTeamList);
        model.addAttribute("topMbrList",topMbrList);        
        
        String retURL = "top_cost_2nd/cost_statistics";
        
        if ("Y".equals(excelYN)){
            retURL = "top_cost_2nd/cost_statistics_excel";
        }
        return retURL;
		
	}//topCostStatistics
	
	
	@RequestMapping(value = "/cost_statistics_mbr", method = RequestMethod.GET)
	public String topCostStatisticsTmMbr(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= cost_statistics_mbr =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || mbrVo.getUser_no() == ""){
			logger.info("topCostStatisticsTmMbr - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		
		
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
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
		List<TopCostStatisticsVO> getTCStmMbr = sqlSession.selectList("CostStatisticsMapper.getTCStmMbr", inVO);

		//클레임교통비내역 가져오기
		List<TopCostStatisticsVO> getTCStmMbrClaim = sqlSession.selectList("CostStatisticsMapper.getTCStmMbrClaim", inVO);
		
		//추가경비내역 가져오기
		List<TopCostStatisticsVO> getTCStmAddMbr = sqlSession.selectList("CostStatisticsMapper.getTCStmAddMbr", inVO);
		
		//===============================================
        // 뷰단 데이터 세팅
        //=============================================== 
//		model.addAttribute("teamList", teamList);
		
		model.addAttribute("srchArg",paramMap);
		model.addAttribute("getTeamInfo", getTeamInfo);
		model.addAttribute("getTCStmMbr", getTCStmMbr);  
		model.addAttribute("getTCStmMbrClaim", getTCStmMbrClaim);
		model.addAttribute("getTCStmAddMbr", getTCStmAddMbr);
		model.addAttribute("inVO", inVO);
		model.addAttribute("mbrList", mbrList);
		model.addAttribute("topTeamList", topTeamList);
		model.addAttribute("topMbrList", topMbrList);
		
		
		return "top_cost_2nd/cost_statistics_tm_mbr";
	}//topCostStatisticsTmMbr
	
	/**
	 * 개인별 경비통계 엑셀다운로드
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/cost_statistics_mbr1_excel", method = RequestMethod.GET)
	public String topCostStatisticsTmMbrExcel(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= cost_statistics_mbr_excel =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || mbrVo.getUser_no() == ""){
			logger.info("topCostStatisticsTmMbr - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		
		
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
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
		List<TopCostStatisticsVO> getTCStmMbr = sqlSession.selectList("CostStatisticsMapper.getTCStmMbr", inVO);
		
		//===============================================
        // 뷰단 데이터 세팅
        //=============================================== 
//		model.addAttribute("teamList", teamList);
		
		model.addAttribute("srchArg",paramMap);
		model.addAttribute("getTeamInfo", getTeamInfo);
		model.addAttribute("getTCStmMbr", getTCStmMbr);
		model.addAttribute("inVO", inVO);
		model.addAttribute("mbrList", mbrList);
		model.addAttribute("topTeamList", topTeamList);
		model.addAttribute("topMbrList", topMbrList);
		
		
		return "top_cost_2nd/cost_statistics_tm_mbr1_excel";
	}

}//class
