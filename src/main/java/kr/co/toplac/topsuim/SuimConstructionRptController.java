package kr.co.toplac.topsuim;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.junit.Assert;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.HttpProxy;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;

@Controller
public class SuimConstructionRptController {
	private static final Logger logger = LoggerFactory.getLogger(SuimConstructionRptController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	
	@RequestMapping(value="/constructionRptInfo")
	public String cstRptInfo(HttpServletRequest request, Model model) throws Exception {
//		 System.out.println("constructionRptInfo");
		
        //===============================================
        //	파라미터 체크
        //===============================================
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		String cmd = StringUtil.null2blank(request.getParameter("cmd"));
		
		//===============================================
        // 비즈니스 로직
        //===============================================
        //기본정보 가져오기
		Map<String, Object> reportBscInfo = sqlSession.selectOne("SuimReportMapper.selectSuimReport",paramMap);
		
		//담당팀 기본정보 가져오기
        paramMap.put("team_id", reportBscInfo.get("teamId"));
        Map<String, Object> reportTeamInfo = sqlSession.selectOne("SuimReportMapper.selectSuimReportTeam", paramMap);

        //조사자 정보
        paramMap.put("user_no", reportBscInfo.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);

        //승인자 정보
        paramMap.put("user_no", reportBscInfo.get("suimRptAprvUserNo"));        
        Map<String, Object> reportAprvUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
		
        //================================================================
        //  건설공제 보고서 기본정보
        //================================================================
        //  건설공제 보고서 기본정보가 있는지 확인. 없으면 기본입력		
		Map<String, Object> reportPrint30isExist = sqlSession.selectOne("ConstructionReportMapper.selectReportPrint30", paramMap);
		if(reportPrint30isExist == null) {
			sqlSession.insert("ConstructionReportMapper.insertReportPrint30ForExist",paramMap);
		}
		
		//건설공제 보고서 기본정보
		Map<String, Object> reportPrint30 = sqlSession.selectOne("ConstructionReportMapper.selectReportPrint30", paramMap);
		
		//건설공제 보고서 기본정보
//		Map<String, Object> reportPrint30 = sqlSession.selectOne("ConstructionReportMapper.selectReportPrint30",paramMap);
		
		paramMap.put("rptPrintNo", reportPrint30.get("rptPrintNo"));
		
		//청구공제금 리스트
		List<Map<String, Object>> reportOtherWorkerList = sqlSession.selectList("ConstructionReportMapper.selectOtherWorkerList", paramMap);
		
		//공제계약사항
		Map<String, Object> contractDetail = sqlSession.selectOne("ConstructionReportMapper.selectReportPrint30", paramMap);
		
		//면책자,부책자,보완 인원 가져오기
		int workerType1 = sqlSession.selectOne("ConstructionReportMapper.selectCountType1", paramMap);
		int workerType2 = sqlSession.selectOne("ConstructionReportMapper.selectCountType2", paramMap);
		int workerType3 = sqlSession.selectOne("ConstructionReportMapper.selectCountType3", paramMap);
		
		//면책자 정보 가져오기
		List<Map<String,Object>> reportWorkerType2 = sqlSession.selectList("ConstructionReportMapper.selectWorkerType2", paramMap);
		//부책자 정보 가져오기
		List<Map<String,Object>> reportWorkerType1 = sqlSession.selectList("ConstructionReportMapper.selectWorkerType1", paramMap);
		
		//첨부파일 리스트
		List<Map<String, Object>> reportAttachDocList = sqlSession.selectList("ConstructionReportMapper.selectAttachDocList",paramMap);
		
        //================================================================
        //  환율정보 가져오기
        //================================================================
        //  날짜 가져오기			
//		String day = DateUtil.addDate(DateUtil.getTodayString(), -7);
		List<Map<String,Object>> countryList = new ArrayList<>();
		
		
		if (reportPrint30.get("exchangeRateDate") != null) {
			String day = String.valueOf( reportPrint30.get("exchangeRateDate") ).replaceAll("-","");
			
			String targetURL = "https://www.kebhana.com/cms/rate/wpfxd651_01i_01.do?pbldDvCd=1&inqStrDt="+day+"&inqKindCd=1";
			HttpProxy httpProxy = new HttpProxy();
			
			String result = httpProxy.borwserGet(targetURL);
			Document document = Jsoup.parse(result);
			
			Element table = document.select("table").get(0); //select the first table.
			Element tbody = table.select("tbody").get(0);
			Elements rows = tbody.select("tr");
			
			//환율정보 가져오기
			for (int i = 0; i < rows.size(); i++) { //first row is the col names so skip it.
				Map<String,Object> countryMap = new HashMap<>();
				
				Element row = rows.get(i);
				String rateExchange = row.select(".txtAr").get(4).text(); //송금(보낼때)
				String country = row.select(".tc u").get(0).text().split("\\s")[0]; //나라 목록
				String countryUnit = row.select(".tc u").get(0).text().split("\\s")[1]; //나라단위 목록
				
				countryMap.put("rateExchange", rateExchange);
				countryMap.put("country", country);
				countryMap.put("countryUnit", countryUnit);
				
				countryList.add(countryMap);
			}
		}
		
		
		//청구공제금 합계
		int deductionSum = sqlSession.selectOne("ConstructionReportMapper.selectDeductionSum", paramMap);
		//지급액 합계
		int paymentSum = sqlSession.selectOne("ConstructionReportMapper.selectPaymentSum", paramMap);
		
		
		
		/*
		System.out.println(reportPrint30.get("exchangeRateDate") != null);
		if(reportPrint30.get("exchangeRateDate") != null) {
			String exchangeRateDate = String.valueOf(reportPrint30.get("exchangeRateDate"));
			String[] dates = exchangeRateDate.split("-");
			String part1 = dates[0];
			String part2 = dates[1];
			String part3 = dates[2];
			String day = part1 + part2 + part3;
			
	        String targetURL = "https://www.kebhana.com/cms/rate/wpfxd651_01i_01.do?pbldDvCd=1&inqStrDt="+day+"&inqKindCd=1";
	        HttpProxy httpProxy = new HttpProxy();
	    
	        String result = httpProxy.borwserGet(targetURL);
	        Document document = Jsoup.parse(result);
	        
	        
	        Element table = document.select("table").get(0); //select the first table.
	        Element tbody = table.select("tbody").get(0);
	        Elements rows = tbody.select("tr");
	        
	        //환율정보 가져오기
	        for (int i = 0; i < rows.size(); i++) { //first row is the col names so skip it.
	            Map<String,Object> countryMap = new HashMap<>();
	        	
	            Element row = rows.get(i);
	            String rateExchange = row.select(".txtAr").get(8).text(); //매매기준율
	            String country = row.select(".tc u").get(0).text().split("\\s")[0]; //나라 목록
	            String countryUnit = row.select(".tc u").get(0).text().split("\\s")[1]; //나라단위 목록
	            
	            countryMap.put("rateExchange", rateExchange);
	            countryMap.put("country", country);
	            countryMap.put("countryUnit", countryUnit);
	           
	            countryList.add(countryMap);

			}
		}

		//청구공제금 합계
		Object deductionSum =sqlSession.selectOne("ConstructionReportMapper.selectDeductionSum", paramMap);
		//지급액 합계
		Object paymentSum = sqlSession.selectOne("ConstructionReportMapper.selectPaymentSum", paramMap);
        
        */
        
//        Assert.assertEquals(0,0);
		
		
		//인보험 손해사정사 정보 추가 시작
		List<Map<String, Object>> certiManager4ReportUser = new ArrayList<Map<String, Object>>(); 

		//조사 담당자
		String sUserNo = String.valueOf(reportBscInfo.get("userNo"));

		//종결건은 담당손해사정사가 별도 저장되어있음 (top_rpt_certi_end) 저장된 손해사정사 정보가 별도로 있는지 체크(인보험용)
		int nEndCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiEndCntBy4",paramMap);        

		if( nEndCnt == 0 ) {			//정보가 없는 경우 실시간으로 가져온다.
			
			if( !"0".equals(sUserNo) ) {		//0은 미배당건
			
			int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
			
			//보고서 작성자를 paramMap 에 추가한다.
			paramMap.put("user_no", reportBscInfo.get("userNo"));
			
			nCertiManagerCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiManagerCnt", paramMap);        	
			
				if( nCertiManagerCnt > 0 ) {			//담당손해사정사가 있는 경우	        		
					certiManager4ReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiManagerList", paramMap);	        		
				}else{										//자기자신이 손해사정사인경우
					certiManager4ReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiMemberInfo", paramMap);
				}
		    }
			
		}else{								//정보가 있는 경우 top_rpt_certi_end 테이블에서 불러온다.
			certiManager4ReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiEndInfoBy4", paramMap);
		}

		model.addAttribute("certiManager4ReportUser", certiManager4ReportUser);
		//인보험 손해사정사 정보 추가 끝
		
		
		//===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("reportBscInfo", reportBscInfo);
        model.addAttribute("reportTeamInfo", reportTeamInfo);
        model.addAttribute("reportInvgUser", reportInvgUser);
        model.addAttribute("reportAprvUser", reportAprvUser);
        model.addAttribute("reportPrint30", reportPrint30);
        model.addAttribute("reportOtherWorkerList", reportOtherWorkerList);
        model.addAttribute("contractDetail", contractDetail);
        model.addAttribute("workerType1", workerType1);
        model.addAttribute("workerType2", workerType2);
        model.addAttribute("workerType3", workerType3);
        model.addAttribute("reportAttachDocList", reportAttachDocList);
        model.addAttribute("countryList", countryList);
        model.addAttribute("deductionSum", deductionSum);
        model.addAttribute("paymentSum", paymentSum);
        model.addAttribute("reportWorkerType1", reportWorkerType1);
        model.addAttribute("reportWorkerType2", reportWorkerType2);
        /*
        model.addAttribute("basicRateExchange", basicRateExchange);
        model.addAttribute("country", country);
        model.addAttribute("countryUnit", countryUnit);
        */
        //model.addAttribute("reportOtherWorkerPaymentList", reportOtherWorkerPaymentList);
		
		
		String retURL = "top_suim_print/suim_rpt_bsc_print_construction";
		
        if ("word".equals(cmd)){
            retURL = "top_suim_print/suim_rpt_bsc_print_construction_word";
        }else if("print".equals(cmd)){
            retURL = "top_suim_print/suim_rpt_bsc_print_construction_print";
        }else if("excel1".equals(cmd)) {
        	retURL = "top_suim_print/suim_rpt_bsc_print_construction_excel1";
        }else if("excel2".equals(cmd)) {
        	retURL = "top_suim_print/suim_rpt_bsc_print_construction_excel2";
        }
		
		return retURL;
	}
	
	@RequestMapping(value="/report_other_worker_insert")
	public String reportOtherWorkerInsert(HttpServletRequest request, Model model) {
        //===============================================
        //	파라미터 체크
        //===============================================		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//===============================================
        // 비즈니스 로직
        //===============================================
        // 청구공제금 근로자 추가
		sqlSession.insert("ConstructionReportMapper.insertReportOtherWorker", paramMap);
	
		/* 
		//청구공제금 근로자리스트
		List<Map<String, Object>> reportOtherWorkerList = sqlSession.selectList("ConstructionReportMapper.selectOtherWorkerList", paramMap);
		
		//===============================================
        // 뷰단 데이터 세팅
        //===============================================
		model.addAttribute("reportOtherWorkerList", reportOtherWorkerList);
		
		return "top_suim_print/ajax/print_other_worker";
		*/
		String suimRptNo = String.valueOf(paramMap.get("suimRptNo"));
        
        return "redirect:/constructionRptInfo?suim_rpt_no="+suimRptNo;
	}
	
	@RequestMapping(value = "/report_other_worker_update")
	public String reportOtherInsuUpdate(HttpServletRequest request, Model model){
		//===============================================
		//	파라미터 체크
		//===============================================
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//===============================================
		// 비즈니스 로직
		//===============================================
		//청구공제금 근로자 수정
		sqlSession.update("ConstructionReportMapper.updateOtherWorker", paramMap);
		
		/*
		//청구공제금 근로자
		List<Map<String, Object>> reportOtherWorkerList = sqlSession.selectList("ConstructionReportMapper.selectOtherWorkerList", paramMap);
		
		//===============================================
		// 뷰단 데이터 세팅
		//===============================================
		model.addAttribute("reportOtherWorkerList", reportOtherWorkerList); 
		return "top_suim_print/ajax/print_other_worker";
		*/
		String suimRptNo = String.valueOf(paramMap.get("suimRptNo"));
        
        return "redirect:/constructionRptInfo?suim_rpt_no="+suimRptNo;		
	}

	@RequestMapping(value = "/report_other_worker_delete")
    public String reportOtherWorkerDelete(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        //===============================================
        // 비즈니스 로직
        //===============================================
        //청구공제금 근로자 삭제
        sqlSession.delete("ConstructionReportMapper.deleteOtherWorker", paramMap);

        /*
        List<Map<String, Object>> reportOtherWorkerList = sqlSession.selectList("ConstructionReportMapper.selectOtherWorkerList", paramMap);
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("reportOtherWorkerList", reportOtherWorkerList);

        return "top_suim_print/ajax/print_other_worker";
        */
        
        String suimRptNo = String.valueOf(paramMap.get("suimRptNo"));
        
        return "redirect:/constructionRptInfo?suim_rpt_no="+suimRptNo;
    }
	
	@RequestMapping(value="/report_other_worker_payment_insert")
	public String reportOtherWorkerPaymentInsert(HttpServletRequest request, Model model) {
        //===============================================
        //	파라미터 체크
        //===============================================		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		//===============================================
        // 비즈니스 로직
        //===============================================
        // 지급공제금 지급처 입력
		sqlSession.update("ConstructionReportMapper.updateReportOtherWorkerPayment", paramMap);
		
		/*
		//지급공제금 지급처 리스트
		List<Map<String, Object>> reportOtherWorkerList = sqlSession.selectList("ConstructionReportMapper.selectOtherWorkerList", paramMap);
		
		//===============================================
        // 뷰단 데이터 세팅
        //===============================================
		model.addAttribute("reportOtherWorkerList", reportOtherWorkerList);
		return "top_suim_print/ajax/print_other_worker";
		*/
		
		String suimRptNo = String.valueOf(paramMap.get("suimRptNo"));
        
        return "redirect:/constructionRptInfo?suim_rpt_no="+suimRptNo;		
	}	
	
	@RequestMapping(value="report_contract_detail_update")
	public String reportContractDetailUpdate(HttpServletRequest request, Model model) {
        //===============================================
        //	파라미터 체크
        //===============================================		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		//===============================================
        // 비즈니스 로직
        //===============================================
        // 기본정보
		Map<String, Object> reportBscInfo = sqlSession.selectOne("SuimReportMapper.selectSuimReport",paramMap);
		
		// 공제계약사항 입력
		sqlSession.update("ConstructionReportMapper.updateContractDetail", paramMap);
		
		//공제계약사항
		Map<String, Object> contractDetail = sqlSession.selectOne("ConstructionReportMapper.selectReportPrint30", paramMap);
		
		//===============================================
        // 뷰단 데이터 세팅
        //===============================================		
		model.addAttribute("reportBscInfo", reportBscInfo);
        model.addAttribute("contractDetail", contractDetail);
        
		return "top_suim_print/ajax/print_contract_detail";
	}
	
	@RequestMapping(value="report_compensation_response_update")
	public String reportCompensationResponseUpdate(HttpServletRequest request, Model model) {
        //===============================================
        //	파라미터 체크
        //===============================================		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		//===============================================
        // 비즈니스 로직
        //===============================================
		Map<String, Object> reportBscInfo = sqlSession.selectOne("SuimReportMapper.selectSuimReport",paramMap);
		List<Map<String, Object>> reportOtherWorkerList = sqlSession.selectList("ConstructionReportMapper.selectOtherWorkerList", paramMap);
		
		
		//질병 업데이트
		sqlSession.update("ConstructionReportMapper.updateDisease", paramMap);
		
		//String[] serialNo = (String[]) paramMap.get("obj");
		//String[] judgement_reason = (String[]) paramMap.get("obj2");
		String[] serialNo = request.getParameterValues("serialNo");
		String[] judgement_reason = request.getParameterValues("reason");
		
		for(int i=0; i<serialNo.length; i++) {
			paramMap.put("serial_no", serialNo[i]);
			paramMap.put("judgement_reason",judgement_reason[i]);
			
			sqlSession.update("ConstructionReportMapper.updateJudgementReason",paramMap);
		}
		
		String suimRptNo = String.valueOf(paramMap.get("suimRptNo"));
        
        return "redirect:/constructionRptInfo?suim_rpt_no="+suimRptNo;			
	}
	
	@RequestMapping(value="report_accident_date_update")
	public String reportImmunityUpdate(HttpServletRequest request, Model model) {
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
		//===============================================
        // 비즈니스 로직
        //===============================================        
		// 면책건 사고일자 업데이트
        sqlSession.update("ConstructionReportMapper.updateImmunity", paramMap);
        
		String suimRptNo = String.valueOf(paramMap.get("suimRptNo"));
        
        return "redirect:/constructionRptInfo?suim_rpt_no="+suimRptNo;			
	}
	
	@RequestMapping(value="report_supplement_accident_date_update")
	public String reportSupplementUpdate(HttpServletRequest request, Model model) {
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
		//===============================================
        // 비즈니스 로직
        //===============================================        
		// 보완건 사고일자 업데이트
        sqlSession.update("ConstructionReportMapper.updateSupplement", paramMap);
        
		String suimRptNo = String.valueOf(paramMap.get("suimRptNo"));
        return "redirect:/constructionRptInfo?suim_rpt_no="+suimRptNo;			
	}
		
    @RequestMapping(value = "/report_construction_attach_doc_useflag")
    public @ResponseBody Map<String, Object> reportAttachDocUseFlag(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        sqlSession.update("ConstructionReportMapper.updateAttachDocUseFlag", paramMap);

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================

        return paramMap;
    }
	
	
    @RequestMapping(value = "/report_construction_attach_doc")
    public String reportAttachDoc(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String cmd = String.valueOf(paramMap.get("cmd"));

        //===============================================
        // 비즈니스 로직
        //===============================================
        if ("C".equals(cmd)){
            sqlSession.insert("ConstructionReportMapper.insertAttachDoc", paramMap);
        }else if("U".equals(cmd)){
            sqlSession.update("ConstructionReportMapper.updateAttachDoc", paramMap);
        }else if("D".equals(cmd)){
            sqlSession.delete("ConstructionReportMapper.deleteAttachDoc", paramMap);
        }

        //===============================================
        // 뷰단 데이터 세팅
        //==============================================
        //사고처리과정 처리과정 리스트
//        List<Map<String, Object>> reportAccidentProcessList = sqlSession.selectList("ConstructionReportMapper.selectReportPrint1CtrlList",paramMap);

        List<Map<String, Object>> reportAttachDocList = sqlSession.selectList("ConstructionReportMapper.selectAttachDocList",paramMap);
//        List<String> reportAttachDocCodeList = new ArrayList<>();

        //사고처리 과정표 업무내용이 첨부서류 비고 select box 코드 리스트가 됨
        /*
         * Set<String> tmpSetList = new HashSet<String>();
        
        for(int idx=0; idx < reportAccidentProcessList.size() ; idx++){
            tmpSetList.add(reportAccidentProcessList.get(idx).get("controlSubject").toString());
        }
        Iterator<String> itrAttachDoc = tmpSetList.iterator();
        while( itrAttachDoc.hasNext() ) {
            reportAttachDocCodeList.add(itrAttachDoc.next());
        }
        */
        model.addAttribute("reportAttachDocList", reportAttachDocList);
//        model.addAttribute("reportAttachDocCodeList", reportAttachDocCodeList);

		String suimRptNo = String.valueOf(paramMap.get("suimRptNo"));
        
        return "redirect:/constructionRptInfo?suim_rpt_no="+suimRptNo;	
    }
	
    /*
    @RequestMapping(value = "/exchangePopUp")
    public String exchangePopUp(HttpServletRequest request, Model model){
    	
    	return "";
    }
	*/
	
	@RequestMapping(value="report_exchange_date_update")
	public String reportExchageDateUpdate(HttpServletRequest request, Model model) {
	        //===============================================
	        //	파라미터 체크
	        //===============================================
	        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		

			//===============================================
	        // 비즈니스 로직
	        //===============================================        
			// 환율기준일자 업데이트
	        sqlSession.update("ConstructionReportMapper.updateExchangeRateDate", paramMap);
	        
			String suimRptNo = String.valueOf(paramMap.get("suim_rpt_no"));
	        return "redirect:/constructionRptInfo?suim_rpt_no="+suimRptNo;	
	}
	
	
	
	
	
	
	
	
}
