package kr.co.toplac.topsuim;

import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Controller
@RequestMapping("/meritz")
public class SuimRptMeritzReportController {
    private static final Logger logger = LoggerFactory.getLogger(SuimRptMeritzReportController.class);
    
    @Autowired
    private SqlSession sqlSession;
    
    @ResponseBody
    @RequestMapping(value = "/meritz_mid_content_action")
    public String meritz_mid_content_action(HttpServletRequest request, Model model) {
    	String sRet = "";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String action = request.getParameter("action") != null ? request.getParameter("action") : "";
    			    	
    	int result = 0;
    	
    	if( "minwon".equals(action) ) {
    		logger.info("======= /reportMeritzMidInfo Minwon Update =======");
    		
    		result = sqlSession.selectOne("SagoBscMapper.getSagoList16Cnt", paramMap.get("suimRptNo").toString());    		
    		    		
    		if( result == 0 ) {				//기존값이 없으면 insert
    			result = sqlSession.insert("SagoBscMapper.InsertRptCtrlMid16", paramMap);
    		}else {
    			result = sqlSession.update("SagoBscMapper.updateRptCtrlMid16", paramMap);
    		}    		
    		
    		if( result == 1 ) {
    			sRet = "success";
    		}
    		
    	}else if( "report".equals(action) ) {
    		logger.info("======= /reportMeritzMidInfo ReportDate Updated =======");
    		    		
    		result = sqlSession.selectOne("SagoBscMapper.getSagoList16Cnt", paramMap.get("suimRptNo").toString());    		
    		
    		if( result == 0 ) {				//기존값이 없으면 insert
    			result = sqlSession.insert("SagoBscMapper.InsertRptCtrlMid16", paramMap);
    		}else {
    			result = sqlSession.update("SagoBscMapper.updateRptCtrlMid16", paramMap);
    		}    		
    		
    		if( result == 1 ) {
    			sRet = "success";
    		}
    		
    	}else {
    		sRet = "fail";
    	}
    	
    	return sRet;
    }
    
    @ResponseBody
    @RequestMapping(value = "/meritz_mid_acc_action")
    public String meritz_mid_acc_action(HttpServletRequest request, Model model) {
    	String sRet = "";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String action = request.getParameter("action") != null ? request.getParameter("action") : "";
		    	
    	int result = 0;
    	
    	if( "add".equals(action) ) {
    		logger.info("======= /reportMeritzMidInfo Add =======");
    		
    		result = sqlSession.insert("SagoBscMapper.InsertRptSagoIns16", paramMap);
    		
    		if( result == 1 ) {
    			sRet = "success";
    		}
    		
    	}else if( "mod".equals(action) ) {
    		logger.info("======= /reportMeritzMidInfo Mod =======");
    		    		
    		result = sqlSession.update("SagoBscMapper.rptSagoUdtMid16", paramMap);
    		
    		if( result == 1 ) {
    			sRet = "success";
    		}
    		
    	}else if( "del".equals(action) ){
    		logger.info("======= /reportMeritzMidInfo Del =======");
    		
    		result = sqlSession.update("SagoBscMapper.rptSagoDel16", paramMap.get("serialNo").toString());
    		
    		if( result == 1 ) {
    			sRet = "success";
    		}    		
    		
    	}else {
    		sRet = "fail";
    	}
    	
    	return sRet;
    }
    
    
    @RequestMapping(value = "/reportMeritzMidInfo")
    public String reportMeritzMidInfo(HttpServletRequest request, Model model){
    	
    	logger.info("======= /reportMeritzMidInfo =======");
    	
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String cmd = StringUtil.null2blank(request.getParameter("cmd"));
        
        //===============================================
        // 비즈니스 로직
        //===============================================
        
        //===== 일반 보고서 SuimReportMapper 사용 =====//
        //보고서 기본정보 가져오기
        Map<String, Object> reportBscInfo = sqlSession.selectOne("SuimReportMapper.selectSuimReport", paramMap);

        //조사자 정보
        paramMap.put("user_no", reportBscInfo.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
        
        String userSignPath = "";
        
        if( reportInvgUser != null ) {
        	
	        //서명경로 추가	        
	        String userSignFileName = String.valueOf(reportInvgUser.get("userSign"));	        
	        
	        try {
	        	
	        	if( !"null".equals(userSignFileName) && !"".equals(userSignFileName)) {
	        		userSignPath = "https://toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/"+String.valueOf(reportInvgUser.get("userNo"))+"/"+userSignFileName;
	        	}
	        	
			} catch (Exception e) {
				userSignPath = "";
				logger.info("reportMeritzMidInfo Sign Error : "+ String.valueOf(paramMap.get("suim_rpt_no"))+" : "+e.getMessage());
			}
	        
        }
        
        //현장진행사항 추가
        List<SuimRptSagoBsc16VO> sagoList  = sqlSession.selectList("SagoBscMapper.getSagoList16", paramMap.get("suim_rpt_no").toString());
        
        //보고일자 정보 추가
        List<SuimRptSagoBsc16MidVO> sagoMidList  = sqlSession.selectList("SagoBscMapper.getSagoList16Mid", paramMap.get("suim_rpt_no").toString());
    	
    	String reportDate = "";    	
    	
    	if( sagoMidList.size() == 0 ) {
    		reportDate = DateUtil.getTodayString("yyyy-MM-dd");
    	}else{
    		if( sagoMidList.get(0).getReportDate() == null || "".equals(sagoMidList.get(0).getReportDate().toString()) ) {
    			reportDate = DateUtil.getTodayString("yyyy-MM-dd");
    		}else{
    			reportDate = sagoMidList.get(0).getReportDate().toString();
    		}    		 
    	}
        
        model.addAttribute("userSignPath",userSignPath);
        model.addAttribute("sagoList",sagoList);
        model.addAttribute("sagoMidList",sagoMidList);        
        model.addAttribute("reportDate",reportDate);
        model.addAttribute("reportBscInfo",reportBscInfo);
        model.addAttribute("reportInvgUser",reportInvgUser);
        
        String retURL = "top_suim_print/suim_rpt_bsc_print_meritz_mid";
    
        if ("word".equals(cmd)){
            retURL = "top_suim_print/suim_rpt_bsc_print_meritz_mid_word";
        }else if("print".equals(cmd)){
            retURL = "top_suim_print/suim_rpt_bsc_print_meritz_mid_print";
        }
    
        return retURL;
    }
    
    @RequestMapping(value = "/meritz_mid_report")			//계약사항 목록 가져오기 방식으로 수정 by top3009
    public String meritzMidReport(HttpServletRequest request, Model model){
    	
    	logger.info("======= /ajax/meritz_mid_report =======");
    	
    	//top_rpt_issue_cont_lotte 테이블에서 등록된 보험목적물 정보를 가져온다.
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);    	
    	
    	String sSuim_rpt_no = paramMap.get("suim_rpt_no").toString();    	
    	
    	List<SuimRptSagoBsc16MidVO> sagoMidList  = sqlSession.selectList("SagoBscMapper.getSagoList16Mid", sSuim_rpt_no);
    	
    	String reportDate = "";    	
    	
    	if( sagoMidList.size() == 0 ) {
    		reportDate = DateUtil.getTodayString("yyyy-MM-dd");
    	}else{
    		if( sagoMidList.get(0).getReportDate() == null || "".equals(sagoMidList.get(0).getReportDate().toString()) ) {
    			reportDate = DateUtil.getTodayString("yyyy-MM-dd");
    		}else{
    			reportDate = sagoMidList.get(0).getReportDate().toString();
    		}    		 
    	}    	
    	
    	model.addAttribute("report_edit_type", paramMap.get("report_edit_type"));		//ajax 에 보여줄 모드
    	model.addAttribute("suim_rpt_no",paramMap.get("suim_rpt_no"));
    	model.addAttribute("reportDate",reportDate);    	
    	
    	String sUrl = "top_suim_print/ajax/meritz_mid_report";
    	
    	return sUrl;
    }
    
    @RequestMapping(value = "/meritz_mid_content")			//계약사항 목록 가져오기 방식으로 수정 by top3009
    public String meritzMidConent(HttpServletRequest request, Model model){
    	
    	logger.info("======= /ajax/meritz_mid_content =======");
    	
    	//top_rpt_issue_cont_lotte 테이블에서 등록된 보험목적물 정보를 가져온다.
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);    	
    	
    	String sSuim_rpt_no = paramMap.get("suim_rpt_no").toString();
    	
    	//System.out.println("sSuim_rpt_no="+sSuim_rpt_no);
    	//System.out.println("content_edit_type="+paramMap.get("content_edit_type").toString());
    	
    	List<SuimRptSagoBsc16MidVO> sagoMidList  = sqlSession.selectList("SagoBscMapper.getSagoList16Mid", sSuim_rpt_no);
    	
    	model.addAttribute("content_edit_type", paramMap.get("content_edit_type"));		//ajax 에 보여줄 모드
    	model.addAttribute("suim_rpt_no",paramMap.get("suim_rpt_no"));
    	model.addAttribute("sagoMidList",sagoMidList);
    	
    	String sUrl = "top_suim_print/ajax/meritz_mid_content";
    	
    	return sUrl;
    }
    
    @RequestMapping(value = "/meritz_mid_acc")			//계약사항 목록 가져오기 방식으로 수정 by top3009
    public String meritzMidAcc(HttpServletRequest request, Model model){
    	
    	logger.info("======= /ajax/meritz_mid_acc =======");
    	
    	//top_rpt_issue_cont_lotte 테이블에서 등록된 보험목적물 정보를 가져온다.
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String editType = paramMap.get("acc_edit_type").toString();
    	String sSuim_rpt_no = paramMap.get("suim_rpt_no").toString();
    	
    	List<SuimRptSagoBsc16VO> sagoList  = sqlSession.selectList("SagoBscMapper.getSagoList16", sSuim_rpt_no);    	
    	
    	String sToday = DateUtil.getTodayString("yyyy-MM-dd");    	
    	
    	model.addAttribute("sToday", sToday);
    	model.addAttribute("acc_edit_type", paramMap.get("acc_edit_type"));		//ajax 에 보여줄 모드
    	model.addAttribute("suim_rpt_no",paramMap.get("suim_rpt_no"));
    	model.addAttribute("sagoList",sagoList);
    	
    	String sUrl = "top_suim_print/ajax/meritz_mid_acc";
    	
    	return sUrl;
    }
    
    @RequestMapping(value = "/reportMeritzInfo")
    public String reportMeritzInfo(HttpServletRequest request, Model model){
    	
    	logger.info("======= /reportMeritzInfo =======");
    	
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String cmd = StringUtil.null2blank(request.getParameter("cmd"));
        
        //===============================================
        // 비즈니스 로직
        //===============================================
        
        //===== 일반 보고서 SuimReportMapper 사용 =====//
        //보고서 기본정보 가져오기
        Map<String, Object> reportBscInfo = sqlSession.selectOne("SuimReportMapper.selectSuimReport", paramMap);

        //담당팀 기본정보 가져오기
        paramMap.put("team_id", reportBscInfo.get("teamId"));
        Map<String, Object> reportTeamInfo = sqlSession.selectOne("SuimReportMapper.selectSuimReportTeam", paramMap);

        //조사자 정보
        paramMap.put("user_no", reportBscInfo.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);

        //승인자 정보
        paramMap.put("user_no", reportBscInfo.get("suimRptAprvUserNo"));
        Map<String, Object> reportAprvUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
        //===== 일반 보고서 SuimReportMapper 사용 =====//
        
        
        Map<String,Object> rptBasic  = sqlSession.selectOne("SuimMeritzReportMapper.selectMeritzReport",paramMap);
        if(rptBasic == null){
        	sqlSession.insert("SuimMeritzReportMapper.insertReportPrint16ForExist",paramMap);
        }
        
        paramMap.put("rpt_print_no", rptBasic.get("rptPrintNo"));
        //메리츠 보고서 일자별 확인사항 정보
        List<Map<String,Object>> rptConfirm  = sqlSession.selectList("SuimMeritzReportMapper.selectMeritzReportConfirm",paramMap);
        //메리츠 보고서 타사 가입사항 정보
        List<Map<String,Object>> rptOtherInsu  = sqlSession.selectList("SuimMeritzReportMapper.selectMeritzReportOtherInsu",paramMap);
        //메리츠 보고서 사고조사 처리과정 정보
        List<Map<String,Object>> rptControl  = sqlSession.selectList("SuimMeritzReportMapper.selectMeritzReportControl",paramMap);
        
        //청구내용 및 조사결과
        //청구내용 코드리스트
        paramMap.put("tbl_nm", "top_rpt_print_1");
        paramMap.put("col_nm", "inspect_point_4");
        List<Map<String, Object>> claimCodeList = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);

        //조사결과 코드리스트
        paramMap.put("tbl_nm", "top_rpt_print_1");
        paramMap.put("col_nm", "inspect_result_4");
        List<Map<String, Object>> resultCodeList = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);
        
        //주요쟁점사항 - 사고내용
        paramMap.put("tbl_nm", "top_rpt_print_1_detail_check");
        paramMap.put("col_nm", "accident");
        List<Map<String, Object>> issuesAccidentCode = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);
		
        //주요쟁점사항 - 직업급수
        paramMap.put("tbl_nm", "top_rpt_print_1_detail_check");
        paramMap.put("col_nm", "job");
        List<Map<String, Object>> issuesjobCode = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);
        
        
        //사고조사 처리과정 - 주요내용 코드리스트
        paramMap.put("tbl_nm", "top_rpt_print_1_ctrl");
        paramMap.put("col_nm", "control_memo");
        List<Map<String, Object>> reportMemoCodeList = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);
        
        //사고조사 처리과정 - 면담자 코드리스트
        List<String> reportWorkCodeList = new ArrayList<>();
        reportWorkCodeList.add("본인");
        reportWorkCodeList.add("담당자");
        reportWorkCodeList.add("피보험자");
        reportWorkCodeList.add("계약자");
        reportWorkCodeList.add(reportBscInfo.get("ptnrName").toString());

        //사고조사 처리과정 - 관계 코드리스트
        List<String> reportRelationCodeList = new ArrayList<>();
        reportRelationCodeList.add("본인");
        reportRelationCodeList.add("배우자");
        reportRelationCodeList.add("자녀");
        reportRelationCodeList.add("계약자");
        reportRelationCodeList.add("피보험자");
        reportRelationCodeList.add("담당자");
        reportRelationCodeList.add("병원");
        reportRelationCodeList.add(reportBscInfo.get("ptnrName").toString());
        
        //사고조사 처리과정 - 접촉방법 코드리스트
        List<String> reportContactCodeList = new ArrayList<>();
        reportContactCodeList.add("방문");
        reportContactCodeList.add("유선");
        reportContactCodeList.add("대면");
        
        //=============================================================
        // 첨부 이미지 리스트
        //=============================================================
        List<Map<String, Object>> reportAttachImageList = sqlSession.selectList("SuimReportMapper.selectAttachImageList",paramMap);
        
        model.addAttribute("reportBscInfo",reportBscInfo);
        model.addAttribute("reportTeamInfo",reportTeamInfo);
        model.addAttribute("reportInvgUser",reportInvgUser);
        model.addAttribute("reportAprvUser",reportAprvUser);
        
        model.addAttribute("issuesAccidentCode",issuesAccidentCode);
        model.addAttribute("issuesjobCode",issuesjobCode);
        
        model.addAttribute("claimCodeList",claimCodeList);
        model.addAttribute("resultCodeList",resultCodeList);
        
        model.addAttribute("reportMemoCodeList",reportMemoCodeList);
        model.addAttribute("reportWorkCodeList",reportWorkCodeList);
        model.addAttribute("reportRelationCodeList",reportRelationCodeList);
        model.addAttribute("reportContactCodeList",reportContactCodeList);
        
        model.addAttribute("rptBasic",rptBasic);
        model.addAttribute("rptConfirm",rptConfirm);
        model.addAttribute("rptOtherInsu",rptOtherInsu);
        model.addAttribute("rptControl",rptControl);
        model.addAttribute("reportAttachImageList",reportAttachImageList);
        
        
        String retURL = "top_suim_print/suim_rpt_bsc_print_meritz";
    
        if ("word".equals(cmd)){
            retURL = "top_suim_print/suim_rpt_bsc_print_meritz_word";
        }else if("print".equals(cmd)){
            retURL = "top_suim_print/suim_rpt_bsc_print_meritz_print";
        }
    
        return retURL;
    }
    
    
    
    /**
     * 메리츠 보고서 계약사항 업데이트
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/meritz_rpt_contract_update")
    public String meritzRptContractUpdate(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        //메리츠 계약사항 업데이트 
        sqlSession.update("SuimMeritzReportMapper.updateMeritzContract",paramMap);
        
        //기본정보 가져오기
        Map<String, Object> reportBscInfo = sqlSession.selectOne("SuimReportMapper.selectSuimReport", paramMap);

        //일반 보고서 기본정보
        Map<String,Object> rptBasic  = sqlSession.selectOne("SuimMeritzReportMapper.selectMeritzReport",paramMap);
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("reportBscInfo", reportBscInfo);
        model.addAttribute("rptBasic", rptBasic);
        return "top_suim_print/ajax/meritz_print_contract";
    }
    
    /**
     * 메리츠 보고서 손해사항 업데이트
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/meritz_rpt_loss_update")
    public String meritzRptLossUpdate(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        
        //메리츠 손해사항 업데이트 
        sqlSession.update("SuimMeritzReportMapper.updateMeritzLoss",paramMap);
        
        //기본정보 가져오기
        Map<String, Object> reportBscInfo = sqlSession.selectOne("SuimReportMapper.selectSuimReport", paramMap);

        //일반 보고서 기본정보
        Map<String,Object> rptBasic  = sqlSession.selectOne("SuimMeritzReportMapper.selectMeritzReport",paramMap);
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("reportBscInfo", reportBscInfo);
        model.addAttribute("rptBasic", rptBasic);
        return "top_suim_print/ajax/meritz_print_loss";
    }    
    
    /**
     * 메리츠 보고서 청구내용 업데이트
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/meritz_rpt_claim_update")
    public String meritz_rpt_claim_update(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        
        //메리츠 손해사항 업데이트 
        sqlSession.update("SuimMeritzReportMapper.updateMeritzClaim",paramMap);
        
        //기본정보 가져오기
        Map<String, Object> reportBscInfo = sqlSession.selectOne("SuimReportMapper.selectSuimReport", paramMap);

        //일반 보고서 기본정보
        Map<String,Object> rptBasic  = sqlSession.selectOne("SuimMeritzReportMapper.selectMeritzReport",paramMap);
        
        //청구내용 및 조사결과
        //청구내용 코드리스트
        paramMap.put("tbl_nm", "top_rpt_print_1");
        paramMap.put("col_nm", "inspect_point_4");
        List<Map<String, Object>> claimCodeList = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);

        //조사결과 코드리스트
        paramMap.put("tbl_nm", "top_rpt_print_1");
        paramMap.put("col_nm", "inspect_result_4");
        List<Map<String, Object>> resultCodeList = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("reportBscInfo", reportBscInfo);
        model.addAttribute("rptBasic", rptBasic);
        model.addAttribute("claimCodeList", claimCodeList);
        model.addAttribute("resultCodeList", resultCodeList);
        
        return "top_suim_print/ajax/meritz_print_inquiry";
    }    
       

    /**
     * 메리츠 보고서 민원예방활동 업데이트
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/meritz_rpt_complaint_aviod_update")
    public String meritz_rpt_complaint_aviod_update(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        
        //메리츠 손해사항 업데이트 
        sqlSession.update("SuimMeritzReportMapper.updateMeritzComplaintAvoid",paramMap);
        
        //기본정보 가져오기
        Map<String, Object> reportBscInfo = sqlSession.selectOne("SuimReportMapper.selectSuimReport", paramMap);

        //일반 보고서 기본정보
        Map<String,Object> rptBasic  = sqlSession.selectOne("SuimMeritzReportMapper.selectMeritzReport",paramMap);
        
        //청구내용 및 조사결과
        //청구내용 코드리스트
        paramMap.put("tbl_nm", "top_rpt_print_1");
        paramMap.put("col_nm", "inspect_point_4");
        List<Map<String, Object>> claimCodeList = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);

        //조사결과 코드리스트
        paramMap.put("tbl_nm", "top_rpt_print_1");
        paramMap.put("col_nm", "inspect_result_4");
        List<Map<String, Object>> resultCodeList = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);        
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("reportBscInfo", reportBscInfo);
        model.addAttribute("rptBasic", rptBasic);
        model.addAttribute("claimCodeList", claimCodeList);
        model.addAttribute("resultCodeList", resultCodeList);
        
        return "top_suim_print/ajax/meritz_print_inquiry";
    }    
    

    /**
     * 메리츠 보고서 민원예방활동 업데이트
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/meritz_rpt_result_update")
    public String meritz_rpt_result_update(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        
        //메리츠 손해사항 업데이트 
        sqlSession.update("SuimMeritzReportMapper.updateMeritzResult",paramMap);
        
        //기본정보 가져오기
        Map<String, Object> reportBscInfo = sqlSession.selectOne("SuimReportMapper.selectSuimReport", paramMap);

        //일반 보고서 기본정보
        Map<String,Object> rptBasic  = sqlSession.selectOne("SuimMeritzReportMapper.selectMeritzReport",paramMap);
        
        //청구내용 및 조사결과
        //청구내용 코드리스트
        paramMap.put("tbl_nm", "top_rpt_print_1");
        paramMap.put("col_nm", "inspect_point_4");
        List<Map<String, Object>> claimCodeList = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);

        //조사결과 코드리스트
        paramMap.put("tbl_nm", "top_rpt_print_1");
        paramMap.put("col_nm", "inspect_result_4");
        List<Map<String, Object>> resultCodeList = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("reportBscInfo", reportBscInfo);
        model.addAttribute("rptBasic", rptBasic);
        model.addAttribute("claimCodeList", claimCodeList);
        model.addAttribute("resultCodeList", resultCodeList);
        
        
        return "top_suim_print/ajax/meritz_print_inquiry";
    }    
 
    /**
     * 메리츠 보고서 조사자 일자별 확인사항 INSERT UPDATE DELETE
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/meritz_rpt_confirm")
    public String meritz_rpt_confirm(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        String type = String.valueOf(paramMap.get("type"));
        
        if ("C".equals(type)){
        	sqlSession.insert("SuimMeritzReportMapper.insertMeritzConfirm",paramMap);
        }else if ("U".equals(type)){
        	sqlSession.update("SuimMeritzReportMapper.updateMeritzConfirm",paramMap);
        }else if ("D".equals(type)){
        	sqlSession.delete("SuimMeritzReportMapper.deleteMeritzConfirm",paramMap);
        }
        	
        //메리츠 보고서 일자별 확인사항 정보
        List<Map<String,Object>> rptConfirm  = sqlSession.selectList("SuimMeritzReportMapper.selectMeritzReportConfirm",paramMap);
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("rptConfirm", rptConfirm);
        
        
        return "top_suim_print/ajax/meritz_print_confirm_by_date";
    }    


    /**
     * 메리츠 보고서 타사 가입사항 INSERT UPDATE DELETE
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/meritz_rpt_other_insu")
    public String meritz_rpt_other_insu(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        String type = String.valueOf(paramMap.get("type"));
        
        if ("C".equals(type)){
        	sqlSession.insert("SuimMeritzReportMapper.insertMeritzOtherInsu",paramMap);
        }else if ("U".equals(type)){
        	sqlSession.update("SuimMeritzReportMapper.updateMeritzOtherInsu",paramMap);
        }else if ("D".equals(type)){
        	sqlSession.delete("SuimMeritzReportMapper.deleteMeritzOtherInsu",paramMap);
        }
        	
        //메리츠 보고서 타사 가입사항 정보
        List<Map<String,Object>> rptOtherInsu  = sqlSession.selectList("SuimMeritzReportMapper.selectMeritzReportOtherInsu",paramMap);
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("rptOtherInsu", rptOtherInsu);
        
        return "top_suim_print/ajax/meritz_print_other_insu";
    } 
    
    /**
     * 메리츠 보고서 주요 쟁점사항 사용여부 UPDATE
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/meritz_rpt_issues_use_at_update")
    @ResponseBody
    public Map<String,Object> meritz_rpt_issues_use_at_update(HttpServletRequest request, Model model){    
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        
        //메리츠 주요쟁점사항 사용여부 업데이트 
        sqlSession.update("SuimMeritzReportMapper.updateMeritzIssuesUseAt",paramMap);
        
        return paramMap;
    }
    

    /**
     * 메리츠 보고서 주요 쟁점사항 UPDATE
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/meritz_rpt_issues_contents_update")
    public String meritz_rpt_issues_contents_update(HttpServletRequest request, Model model){    
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        //메리츠 주요쟁점사항 사용여부 업데이트 
        sqlSession.update("SuimMeritzReportMapper.updateMeritzIssuesContents",paramMap);
        
        //기본정보 가져오기
        Map<String, Object> reportBscInfo = sqlSession.selectOne("SuimReportMapper.selectSuimReport", paramMap);

        //일반 보고서 기본정보
        Map<String,Object> rptBasic  = sqlSession.selectOne("SuimMeritzReportMapper.selectMeritzReport",paramMap);
        
        //주요쟁점사항 - 사고내용
        paramMap.put("tbl_nm", "top_rpt_print_1_detail_check");
        paramMap.put("col_nm", "accident");
        List<Map<String, Object>> issuesAccidentCode = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);
		
        //주요쟁점사항 - 직업급수
        paramMap.put("tbl_nm", "top_rpt_print_1_detail_check");
        paramMap.put("col_nm", "job");
        List<Map<String, Object>> issuesjobCode = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("reportBscInfo", reportBscInfo);
        model.addAttribute("rptBasic", rptBasic);
        model.addAttribute("issuesAccidentCode", issuesAccidentCode);
        model.addAttribute("issuesjobCode", issuesjobCode);
        
        return "top_suim_print/ajax/meritz_print_major_jssues";
    }
    
    /**
     * 메리츠 보고서 관련자면담 및 특이사항 업데이트
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/meritz_rpt_interview_update")
    public String meritzRptInterviewUpdate(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        
        //메리츠 손해사항 업데이트 
        sqlSession.update("SuimMeritzReportMapper.updateMeritzInterview",paramMap);
        
        //기본정보 가져오기
        Map<String, Object> reportBscInfo = sqlSession.selectOne("SuimReportMapper.selectSuimReport", paramMap);

        //일반 보고서 기본정보
        Map<String,Object> rptBasic  = sqlSession.selectOne("SuimMeritzReportMapper.selectMeritzReport",paramMap);
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("reportBscInfo", reportBscInfo);
        model.addAttribute("rptBasic", rptBasic);
        return "top_suim_print/ajax/meritz_print_interview";
    }        
    
    
    /**
     * 메리츠 보고서 사고조사 처리과정 INSERT UPDATE DELETE
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/meritz_rpt_control")
    public String meritz_rpt_control(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        String type = String.valueOf(paramMap.get("type"));
        
        if ("C".equals(type)){
        	sqlSession.insert("SuimMeritzReportMapper.insertMeritzReportControl",paramMap);
        }else if ("U".equals(type)){
        	sqlSession.update("SuimMeritzReportMapper.updateMeritzReportControl",paramMap);
        }else if ("D".equals(type)){
        	sqlSession.delete("SuimMeritzReportMapper.deleteMeritzReportControl",paramMap);
        }
        	
        //메리츠 보고서 타사 가입사항 정보
        List<Map<String,Object>> rptControl  = sqlSession.selectList("SuimMeritzReportMapper.selectMeritzReportControl",paramMap);
        
        //보고서 기본정보 가져오기
        Map<String, Object> reportBscInfo = sqlSession.selectOne("SuimReportMapper.selectSuimReport", paramMap);
        
        //사고조사 처리과정 - 주요내용 코드리스트
        paramMap.put("tbl_nm", "top_rpt_print_1_ctrl");
        paramMap.put("col_nm", "control_memo");
        List<Map<String, Object>> reportMemoCodeList = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);
        
        //사고조사 처리과정 - 면담자 코드리스트
        List<String> reportWorkCodeList = new ArrayList<>();
        reportWorkCodeList.add("본인");
        reportWorkCodeList.add("담당자");
        reportWorkCodeList.add("피보험자");
        reportWorkCodeList.add("계약자");
        reportWorkCodeList.add(reportBscInfo.get("ptnrName").toString());

        //사고조사 처리과정 - 관계 코드리스트
        List<String> reportRelationCodeList = new ArrayList<>();
        reportRelationCodeList.add("본인");
        reportRelationCodeList.add("배우자");
        reportRelationCodeList.add("자녀");
        reportRelationCodeList.add("계약자");
        reportRelationCodeList.add("피보험자");
        reportRelationCodeList.add("담당자");
        reportRelationCodeList.add("병원");
        reportRelationCodeList.add(reportBscInfo.get("ptnrName").toString());
        
        //사고조사 처리과정 - 접촉방법 코드리스트
        List<String> reportContactCodeList = new ArrayList<>();
        reportContactCodeList.add("방문");
        reportContactCodeList.add("유선");
        reportContactCodeList.add("대면");
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("rptControl", rptControl);
        
        model.addAttribute("reportMemoCodeList", reportMemoCodeList);
        model.addAttribute("reportWorkCodeList", reportWorkCodeList);
        model.addAttribute("reportRelationCodeList", reportRelationCodeList);
        model.addAttribute("reportContactCodeList", reportContactCodeList);
        
        
        return "top_suim_print/ajax/meritz_print_control";
    } 
    
    
    
    
    

}
