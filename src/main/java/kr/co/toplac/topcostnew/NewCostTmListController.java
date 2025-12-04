/*
*********************************************************
* Program ID	: 
* Program Name	: 
* Description	: 
* Author		: 
* Date			: 2016.06.09.
*********************************************************
*/
package kr.co.toplac.topcostnew;


import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.topcost.TopCostCompositeVO;
import kr.co.toplac.topstatistics.StatisticsNowVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.cmm.RequestUtil;

@Controller
public class NewCostTmListController {

	private static final Logger logger = LoggerFactory.getLogger(NewCostTmListController.class);

	@Autowired
	private SqlSession sqlSession;

	/*
	*********************************************************
	* Program ID	: 
	* Program Name	: 
	* Description	: 
	* Author		: 
	* Date			: 2016.06.09.
	*********************************************************
	*/
	@RequestMapping(value = "getNewCostTmList", method = RequestMethod.GET)
	public String getNewCostTmList(Model model, HttpSession session, HttpServletRequest request
			, NewCostViewVO inVO) throws UnsupportedEncodingException {

		logger.info("======= getNewCostTmList =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (!mbrVo.getTeam_id_main().equals("7")&&mbrAuthVo.getMbr_pms_17().equals("0")&&mbrAuthVo.getMbr_pms_18().equals("0"))){
			logger.info("getNewCostTmList - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_force_logout";
		}
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		if(inVO.getViewFromDate() == null || inVO.getViewFromDate().equals("")){
			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate");
			inVO.setViewFromDate(nowVO.getNow_from());
			inVO.setViewToDate(nowVO.getNow_to());
		}else{
			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate2", inVO);
			inVO.setViewFromDate(nowVO.getNow_from());
			inVO.setViewToDate(nowVO.getNow_to());
		}
		
		//팀 정보 가져오기
		NewCostViewVO getTeamInfo = sqlSession.selectOne("NewCostTmListMapper.getTeamInfo", inVO);
		List<TopTmBscVO> topTeamList = sqlSession.selectList("SuimRegInsMapper.topTeamList",paramMap);		
		String user_name = String.valueOf(paramMap.get("search_name")); 
		String team_id= String.valueOf(paramMap.get("team_id")); 
		
		List<NewCostCpstVO> getNewCostTmList = sqlSession.selectList("NewCostTmListMapper.getNewCostTmList_20180703", inVO);
		List<TopMbrBscVO>  mbrList = sqlSession.selectList("SuimRegInsMapper.getThisTeamMbr",team_id);
		
		//직원리스트 가져오기
		List<TopTmBscVO> topMbrList = sqlSession.selectList("NewCostListMapper.getMbrList",paramMap);
		
		model.addAttribute("inVO", inVO);
		model.addAttribute("getTeamInfo", getTeamInfo);
		model.addAttribute("getNewCostTmList", getNewCostTmList);
		model.addAttribute("user_name", user_name);
		model.addAttribute("topTeamList", topTeamList);
		model.addAttribute("mbrList", mbrList);
		model.addAttribute("topMbrList", topMbrList);
		
		
		return "top_cost_new/new_cost_tm_list";
	}//getNewCostTmList

	@RequestMapping(value = "udtNewCostAprv", method = RequestMethod.POST)
	public void udtNewCostAprv(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response
			, NewCostViewVO inVO) {

		logger.info("======= udtNewCostAprv =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		inVO.setLoginUserNo(mbrVo.getUser_no());

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		int aprv_item = 0;
		int aprv_addition_item = 0;
		
		//경비내역,클레임교통비내역 update
		aprv_item = sqlSession.update("NewCostTmListMapper.aprv_item",inVO);
		
		//추가경비내역 update
		aprv_addition_item = sqlSession.update("NewCostTmListMapper.aprv_addtion_item",inVO);
		
		int aprv_deposit = 0;
		aprv_deposit = sqlSession.update("NewCostTmListMapper.aprv_deposit",inVO);

		int result = 0;
		if((aprv_item > 0) && (aprv_addition_item >0 ) && (aprv_deposit > 0)){
			result = 1;
		}
		out.print(result);
		out.close();

	}//udtNewCostAprv

	@RequestMapping(value = "getNewCostDepositPop", method = RequestMethod.GET)
	public String getNewCostDepositPop(Model model, HttpSession session, HttpServletRequest request
			, NewCostViewVO inVO) {

		logger.info("======= getNewCostDepositPop =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (!mbrVo.getTeam_id_main().equals("7")&&mbrAuthVo.getMbr_pms_17().equals("0")&&mbrAuthVo.getMbr_pms_18().equals("0"))){
			logger.info("getNewCostDepositPop - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_force_logout";
		}
		
		NewCostViewVO getUserInfo = sqlSession.selectOne("NewCostTmListMapper.getUserInfo", inVO);
		
		model.addAttribute("inVO", inVO);
		model.addAttribute("getUserInfo", getUserInfo);

		List<TopCostCompositeVO> getNewCostDepositPop = sqlSession.selectList("NewCostTmListMapper.getNewCostDepositPop", inVO);
		model.addAttribute("getNewCostDepositPop", getNewCostDepositPop);

		return "top_cost_new/new_cost_deposit_pop"; 
	}//getNewCostDepositPop

}//class
