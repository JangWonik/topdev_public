package kr.co.toplac.topcost2nd;


import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.toplac.cmm.service.CodeDicService;
import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.topcostnew.NewCostCpstVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;

@Controller
public class CostListController {

	private static final Logger logger = LoggerFactory.getLogger(CostListController.class);

	@Autowired
	private SqlSession sqlSession;
	
    @Autowired
    private CodeDicService service;
	
    
    @RequestMapping(value = "cost_person_list_excel")
	public String cost_person_list_excel(Model model, HttpSession session, HttpServletRequest request) {
    	logger.info("======= cost_person_list_excel =======");
    	
    	String sUrl = "top_cost_2nd/cost_person_list_excel";
    	
    	//===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        //===============================================
        // 현재 일자 세팅
        //===============================================
        String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));  //기준일자 시작일
        String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));  //기준일자 종료일
        
        if ("".equals(stdBgnde)){
            stdBgnde = DateUtil.getStartMonthDay();
            stdEndde = DateUtil.getEndMonthDay();

            stdBgnde = DateUtil.getDateFormat(stdBgnde,"-");
            stdEndde = DateUtil.getDateFormat(stdEndde,"-");

            paramMap.put("stdBgnde",stdBgnde);
            paramMap.put("stdEndde",stdEndde);
        }

        //===============================================
        // 필요 날짜 SET
        //===============================================
        String bgnDe = stdBgnde.replace("-","");
        String endDe = DateUtil.addDate(stdEndde.replace("-",""),1);
        String yearMonth = endDe.substring(2,6);
        String bgnYearDe = (Integer.parseInt(endDe.substring(0,4)) - 1)  + "1216";
        String endYearDe = endDe.substring(0,4) + "1216";

        paramMap.put("bgnDe", bgnDe);
        paramMap.put("endDe", endDe);
        paramMap.put("bgnYearDe", bgnYearDe);
        paramMap.put("endYearDe", endYearDe);
        paramMap.put("yearMonth", yearMonth);
    	
        
        //개인별 경비내역 시작
  		//재직중인 사용자 목록을 개인별 경비내역을 계산하기 위한 List에 넣는다. by top3009
  		List<NewCostCpstVO> personList = sqlSession.selectList("CostListMapper.selectStatisticsMbrListOut",paramMap);  		

  		Map<String, Object> tempPersonMap = new HashMap<String, Object>();
  		
  		for( int i=0; i < personList.size(); i++) {
  			paramMap.put("user_no", personList.get(i).getUser_no());
  			tempPersonMap = sqlSession.selectOne("CostListMapper.selectCostDeposit2ndPersonInfo",paramMap);
  			personList.get(i).setCost_deposit_no(tempPersonMap.get("costDepositNo").toString());
  			personList.get(i).setCost_base_deposit_amt(tempPersonMap.get("basicAmt").toString());
  			personList.get(i).setCost_addition_deposit_amt(tempPersonMap.get("addAmt").toString());
  			personList.get(i).setCost_claim_deposit_amt(tempPersonMap.get("claimAmt").toString());
  			personList.get(i).setCost_total_amt(tempPersonMap.get("totalAmt").toString());
  			personList.get(i).setCost_deposit_amt(tempPersonMap.get("depositAmt").toString());
  			
  			personList.get(i).setTm_aprv_amt(tempPersonMap.get("tmAprvAmt").toString());
  			personList.get(i).setHq_aprv_amt(tempPersonMap.get("hqAprvAmt").toString());
  			personList.get(i).setFinance_aprv_amt(tempPersonMap.get("financeAprvAmt").toString());
  			personList.get(i).setCost_aprv_state(tempPersonMap.get("costDepositState").toString());
  			
  			personList.get(i).setHelp_client_traffic_fee(tempPersonMap.get("helpClientTrafficFee").toString());
  			personList.get(i).setHelp_client_chart_fee(tempPersonMap.get("helpClientChartFee").toString());
  			
  			personList.get(i).setHelp_accept_traffic_fee(tempPersonMap.get("helpAcceptTrafficFee").toString());
  			personList.get(i).setHelp_accept_chart_fee(tempPersonMap.get("helpAcceptChartFee").toString());
  			personList.get(i).setCost_deposit_date(tempPersonMap.get("depositDate").toString());
  			personList.get(i).setCost_deposit_date_fmt(tempPersonMap.get("depositDateFmt").toString());			
  		}		
  		
  		model.addAttribute("personList", personList);
    	
    	return sUrl;
    }
    
    @RequestMapping(value = "cost_tm_list_excel")
	public String cost_tm_list_excel(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= cost_tm_list_excel =======");
		 
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 현재 일자 세팅
        //===============================================
        String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));  //기준일자 시작일
        String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));  //기준일자 종료일
        
        if ("".equals(stdBgnde)){
            stdBgnde = DateUtil.getStartMonthDay();
            stdEndde = DateUtil.getEndMonthDay();

            stdBgnde = DateUtil.getDateFormat(stdBgnde,"-");
            stdEndde = DateUtil.getDateFormat(stdEndde,"-");

            paramMap.put("stdBgnde",stdBgnde);
            paramMap.put("stdEndde",stdEndde);
        }

        //===============================================
        // 필요 날짜 SET
        //===============================================
        String bgnDe = stdBgnde.replace("-","");
        String endDe = DateUtil.addDate(stdEndde.replace("-",""),1);
        String yearMonth = endDe.substring(2,6);
        String bgnYearDe = (Integer.parseInt(endDe.substring(0,4)) - 1)  + "1216";
        String endYearDe = endDe.substring(0,4) + "1216";

        paramMap.put("bgnDe", bgnDe);
        paramMap.put("endDe", endDe);
        paramMap.put("bgnYearDe", bgnYearDe);
        paramMap.put("endYearDe", endYearDe);
        paramMap.put("yearMonth", yearMonth);        		
		
        //===============================================
        //	경비내역 리스트 
        //===============================================	   
		List<Map<String,Object>> costTmList0 = sqlSession.selectList("CostListMapper.selectCostTmList0",paramMap);
		List<Map<String,Object>> costTmList1 = sqlSession.selectList("CostListMapper.selectCostTmList1",paramMap);
		List<Map<String,Object>> costTmList4 = sqlSession.selectList("CostListMapper.selectCostTmList4",paramMap);
		
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================		
        model.addAttribute("srchArg", paramMap);
		
		model.addAttribute("costTmList0", costTmList0);
		model.addAttribute("costTmList1", costTmList1);
		model.addAttribute("costTmList4", costTmList4);
		
		return "top_cost_2nd/cost_tm_list_excel";
	}
	
	@RequestMapping(value = "cost_tm_list")
	public String cost_tm_list(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= cost_tm_list =======");
		
        //===============================================
        //	권한체크
        //===============================================
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
        TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
        
		if(mbrAuthVo == null || (!mbrVo.getTeam_id_main().equals("7")&&mbrAuthVo.getMbr_pms_17().equals("0")&&mbrAuthVo.getMbr_pms_18().equals("0"))){
			logger.info("cost_mbr_list - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_force_logout";
		}
        
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 현재 일자 세팅
        //===============================================
        String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));  //기준일자 시작일
        String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));  //기준일자 종료일
        
        if ("".equals(stdBgnde)){
            stdBgnde = DateUtil.getStartMonthDay();
            stdEndde = DateUtil.getEndMonthDay();

            stdBgnde = DateUtil.getDateFormat(stdBgnde,"-");
            stdEndde = DateUtil.getDateFormat(stdEndde,"-");

            paramMap.put("stdBgnde",stdBgnde);
            paramMap.put("stdEndde",stdEndde);
        }

        //===============================================
        // 필요 날짜 SET
        //===============================================
        String bgnDe = stdBgnde.replace("-","");
        String endDe = DateUtil.addDate(stdEndde.replace("-",""),1);
        String yearMonth = endDe.substring(2,6);
        String bgnYearDe = (Integer.parseInt(endDe.substring(0,4)) - 1)  + "1216";
        String endYearDe = endDe.substring(0,4) + "1216";

        paramMap.put("bgnDe", bgnDe);
        paramMap.put("endDe", endDe);
        paramMap.put("bgnYearDe", bgnYearDe);
        paramMap.put("endYearDe", endYearDe);
        paramMap.put("yearMonth", yearMonth);
        
        //===============================================
        //	검색용 팀, 직원리스트
        //===============================================	       
		List<TopTmBscVO> tmList = sqlSession.selectList("SuimRegInsMapper.topTeamList",paramMap);		
		List<TopTmBscVO> mbrList = sqlSession.selectList("CostListMapper.selectStatisticsMbrList",paramMap);		
		
        //===============================================
        //	경비내역 리스트 
        //===============================================	   
		List<Map<String,Object>> costTmList0 = sqlSession.selectList("CostListMapper.selectCostTmList0",paramMap);
		List<Map<String,Object>> costTmList1 = sqlSession.selectList("CostListMapper.selectCostTmList1",paramMap);
		List<Map<String,Object>> costTmList4 = sqlSession.selectList("CostListMapper.selectCostTmList4",paramMap);
		
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================		
        model.addAttribute("srchArg", paramMap);
		
		model.addAttribute("tmList", tmList);
		model.addAttribute("mbrList", mbrList);  
		
		model.addAttribute("costTmList0", costTmList0);
		model.addAttribute("costTmList1", costTmList1);
		model.addAttribute("costTmList4", costTmList4);
		
		//개인별 경비내역 시작
		//재직중인 사용자 목록을 개인별 경비내역을 계산하기 위한 List에 넣는다. by top3009
		List<NewCostCpstVO> personList = sqlSession.selectList("CostListMapper.selectStatisticsMbrListOut",paramMap);
		
		//selectCostDeposit2ndPersonInfo
		//CommonUtils.printMap(paramMap);
		Map<String, Object> tempPersonMap = new HashMap<String, Object>();
		
		for( int i=0; i < personList.size(); i++) {
			//System.out.println( i + " : "+personList.get(i).getTeam_name()+" : "+personList.get(i).getUser_name()+" : "+personList.get(i).getUser_no());
			paramMap.put("user_no", personList.get(i).getUser_no());
			tempPersonMap = sqlSession.selectOne("CostListMapper.selectCostDeposit2ndPersonInfo",paramMap);
			personList.get(i).setCost_deposit_no(tempPersonMap.get("costDepositNo").toString());
			personList.get(i).setCost_base_deposit_amt(tempPersonMap.get("basicAmt").toString());
			personList.get(i).setCost_addition_deposit_amt(tempPersonMap.get("addAmt").toString());
			personList.get(i).setCost_claim_deposit_amt(tempPersonMap.get("claimAmt").toString());
			personList.get(i).setCost_total_amt(tempPersonMap.get("totalAmt").toString());
			personList.get(i).setCost_deposit_amt(tempPersonMap.get("depositAmt").toString());
			
			personList.get(i).setTm_aprv_amt(tempPersonMap.get("tmAprvAmt").toString());
			personList.get(i).setHq_aprv_amt(tempPersonMap.get("hqAprvAmt").toString());
			personList.get(i).setFinance_aprv_amt(tempPersonMap.get("financeAprvAmt").toString());
			personList.get(i).setCost_aprv_state(tempPersonMap.get("costDepositState").toString());
			
			personList.get(i).setHelp_client_traffic_fee(tempPersonMap.get("helpClientTrafficFee").toString());
			personList.get(i).setHelp_client_chart_fee(tempPersonMap.get("helpClientChartFee").toString());
			
			personList.get(i).setHelp_accept_traffic_fee(tempPersonMap.get("helpAcceptTrafficFee").toString());
			personList.get(i).setHelp_accept_chart_fee(tempPersonMap.get("helpAcceptChartFee").toString());
			personList.get(i).setCost_deposit_date(tempPersonMap.get("depositDate").toString());
			personList.get(i).setCost_deposit_date_fmt(tempPersonMap.get("depositDateFmt").toString());			
		}		
		
		model.addAttribute("personList", personList);
		
		return "top_cost_2nd/cost_tm_list";
	}
	
	
	
	@RequestMapping(value = "cost_mbr_list")
	public String cost_mbr_list(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= cost_mbr_list =======");
		
        //===============================================
        //	권한체크
        //===============================================
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
        TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
		if(mbrAuthVo == null || (!mbrVo.getTeam_id_main().equals("7") && mbrAuthVo.getMbr_pms_17().equals("0") && mbrAuthVo.getMbr_pms_18().equals("0"))){
			logger.info("cost_mbr_list - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_force_logout";
		}	
	
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
        //===============================================
        // 현재 일자 세팅
        //===============================================
        String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));  //기준일자 시작일
        String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));  //기준일자 종료일
        
        if ("".equals(stdBgnde)){
            stdBgnde = DateUtil.getStartMonthDay();
            stdEndde = DateUtil.getEndMonthDay();

            stdBgnde = DateUtil.getDateFormat(stdBgnde,"-");
            stdEndde = DateUtil.getDateFormat(stdEndde,"-");

            paramMap.put("stdBgnde",stdBgnde);
            paramMap.put("stdEndde",stdEndde);
        }

        //===============================================
        // 필요 날짜 SET
        //===============================================
        String bgnDe = stdBgnde.replace("-","");
        String endDe = DateUtil.addDate(stdEndde.replace("-",""),1);
        String yearMonth = endDe.substring(2,6);
        String bgnYearDe = (Integer.parseInt(endDe.substring(0,4)) - 1)  + "1216";
        String endYearDe = endDe.substring(0,4) + "1216";

        paramMap.put("bgnDe", bgnDe);
        paramMap.put("endDe", endDe);
        paramMap.put("bgnYearDe", bgnYearDe);
        paramMap.put("endYearDe", endYearDe);
        paramMap.put("yearMonth", yearMonth);
        
        
        if (paramMap.get("cost_deposit_no") != null){
        	paramMap.put("cost_aprv_user_no", mbrVo.getUser_no());
        	if (paramMap.get("settle_cancel") == null){
        		sqlSession.update("CostListMapper.updateAprvCostItem",paramMap);
        		sqlSession.update("CostListMapper.updateAprvCostDeposit",paramMap);
        		sqlSession.insert("CostListMapper.insertAprvCostDepositLog",paramMap);
        	}else{
        		sqlSession.update("CostListMapper.updateAprvCostSettleCancel",paramMap);
        		sqlSession.update("CostListMapper.updateAprvCostSettleCancel2",paramMap);
        		sqlSession.insert("CostListMapper.insertAprvCostDepositLog",paramMap);        		
        	}
        }
        
        
        //===============================================
        //	검색용 팀, 직원리스트
        //===============================================	       
		List<TopTmBscVO> tmList = sqlSession.selectList("SuimRegInsMapper.topTeamList",paramMap);		
		List<TopTmBscVO> mbrList = sqlSession.selectList("CostListMapper.selectStatisticsMbrList",paramMap);			
		
		List<Map<String,Object>> costMbrList =  sqlSession.selectList("CostListMapper.selectCostMbrList",paramMap);
		
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================		
        model.addAttribute("srchArg", paramMap);
		model.addAttribute("tmList", tmList);
		model.addAttribute("mbrList", mbrList);  
		model.addAttribute("costMbrList", costMbrList);  
		
		return "top_cost_2nd/cost_mbr_list";
	}
	
	
	@RequestMapping(value = "cost_settle_pop")
	public String cost_settle_pop(Model model, HttpSession session, HttpServletRequest request) {
		logger.info("======= cost_settle_pop =======");

        //===============================================
        //	권한체크
        //===============================================
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
        TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
		if(mbrAuthVo == null || (!mbrVo.getTeam_id_main().equals("7") && mbrAuthVo.getMbr_pms_17().equals("0") && mbrAuthVo.getMbr_pms_18().equals("0"))){
			logger.info("cost_mbr_list - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_force_logout";
		}	

        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

		Map<String, Object> costSettle = sqlSession.selectOne("CostListMapper.selectCostSettlePop", paramMap);
		model.addAttribute("costSettle", costSettle);
		
		return "top_cost_2nd/cost_settle_pop";
	}
	
	@RequestMapping(value = "aprv_cost_settle")
	@ResponseBody
	public Map<String,Object> aprv_cost_settle(Model model, HttpSession session, HttpServletRequest request) {
		logger.info("======= aprv_cost_settle =======");

        //===============================================
        //	권한체크
        //===============================================
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        paramMap.put("cost_aprv_user_no",mbrVo.getUser_no());
        
        sqlSession.update("CostDetailMapper.updateAprvCostItem",paramMap);
        sqlSession.update("CostListMapper.updateAprvCostSettle",paramMap);
        sqlSession.insert("CostListMapper.insertAprvCostDepositLog",paramMap);
        
		return paramMap;
	}	
	
	

	@RequestMapping(value = "selectStatisticsMbrList", method = RequestMethod.POST)
	@ResponseBody
	public List<TopTmBscVO> selectStatisticsMbrList(Model model, HttpSession session, String team_id, HttpServletRequest request) {
		logger.info("====== selectStatisticsMbrList ======");
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		
		List<TopTmBscVO> mbrList = sqlSession.selectList("CostListMapper.selectStatisticsMbrList",paramMap);			
		
		return mbrList;

	}
	
	
	

		

}//class
