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
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.toplac.toprptmbrchg.service.RptMbrchgService;
import kr.co.toplac.topstatistics.StatisticsNowVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.cmm.RequestUtil;

@Controller
public class NewCostListController {

	private static final Logger logger = LoggerFactory.getLogger(NewCostListController.class);

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
	@RequestMapping(value = "newCostList", method = RequestMethod.GET)
	public String newCostList(Model model, HttpSession session, HttpServletRequest request
			, NewCostViewVO inVO) {

		logger.info("======= newCostList =======");
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (!mbrVo.getTeam_id_main().equals("7")&&mbrAuthVo.getMbr_pms_17().equals("0")&&mbrAuthVo.getMbr_pms_18().equals("0"))){
			logger.info("newCostList - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_force_logout";
		}
		
		if(inVO.getViewFromDate() == null || inVO.getViewFromDate().equals("")){
			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate");
			inVO.setViewFromDate(nowVO.getNow_from());
			inVO.setViewToDate(nowVO.getNow_to());
		}else{
			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate2", inVO);
			inVO.setViewFromDate(nowVO.getNow_from());
			inVO.setViewToDate(nowVO.getNow_to());
		}

		model.addAttribute("inVO", inVO);

		//팀 정보 가져오기
		List<TopTmBscVO> topTeamList = sqlSession.selectList("SuimRegInsMapper.topTeamList",paramMap);		
		
		//직원리스트 가져오기
		List<TopTmBscVO> topMbrList = sqlSession.selectList("NewCostListMapper.getMbrList",paramMap);		
		
		//경비내역 가져오기
		List<NewCostCpstVO> getCostList0 = sqlSession.selectList("NewCostListMapper.getNewCostList0", inVO);
		List<NewCostCpstVO> getCostList1 = sqlSession.selectList("NewCostListMapper.getNewCostList1", inVO);
		List<NewCostCpstVO> getCostList4 = sqlSession.selectList("NewCostListMapper.getNewCostList4", inVO);
		
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================		
		model.addAttribute("getCostList0", getCostList0);
		model.addAttribute("getCostList1", getCostList1);
		model.addAttribute("getCostList4", getCostList4);
		model.addAttribute("topTeamList", topTeamList);
		model.addAttribute("topMbrList", topMbrList);

		return "top_cost_new/new_cost_list";
	}//newCostList

	@RequestMapping(value="topDeptForSelectedMbr")
	@ResponseBody
	public String lectureRoomIns(HttpServletRequest request, Model model,HttpServletResponse response) throws IOException {
		//===============================================
        //	파라미터 체크
        //===============================================		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//===============================================
        // 비즈니스 로직
        //===============================================
        //user_no에 해당하는 team_id가져오기
		String team_id = sqlSession.selectOne("NewCostListMapper.getMbrList2",paramMap);
		
		return team_id;
	}
	
	
}//class
