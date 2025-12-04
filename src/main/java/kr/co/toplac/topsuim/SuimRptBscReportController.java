package kr.co.toplac.topsuim;

import kr.co.toplac.rptin.SuimPrint1001VO;
import kr.co.toplac.util.cmm.CommonUtils;
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
import java.io.File;
import java.util.*;

/**
 * Created by kohyeonseok on 2017. 7. 4..
 */
@Controller
public class SuimRptBscReportController {
    private static final Logger logger = LoggerFactory.getLogger(SuimRptBscReportController.class);


    @Autowired
    private SqlSession sqlSession;
    
    @ResponseBody
    @RequestMapping(value="/updateEstimationValue")
    public String updateEstimationValue(HttpServletRequest request, Model model) {
    	
    	String sRet = "";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	    	
    	sqlSession.update("SuimReportMapper.updateEstimationValue", paramMap);
    	
    	sRet = paramMap.get("estimation_amount").toString();
    	
    	return sRet;
    }
    
    /**
     * 조사결과 옵션 1 정보 갱신
     * @param request
     * @param model
     * @return
     */    
    @ResponseBody
    @RequestMapping(value="/updateResultOption1Value")
    public int updateResultOption1Value(HttpServletRequest request, Model model) {
    	    	
    	int nRet = 0;
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String suim_rpt_no = request.getParameter("suim_rpt_no") != null ? request.getParameter("suim_rpt_no") : "";
    	
    	nRet = sqlSession.selectOne("SuimReportMapper.selectResultOption1Cnt", suim_rpt_no);    	
    	
    	//신규 추가
    	
    	if( nRet == 0 ) {
    		nRet = sqlSession.insert("SuimReportMapper.insertResultOption1Value",paramMap);    		
    	}else{
    		nRet = sqlSession.update("SuimReportMapper.updateResultOption1Value",paramMap);
    	}    	
    	
    	return nRet;
    }
    
    /**
     * 조사결과 옵션 2 정보 갱신
     * @param request
     * @param model
     * @return
     */    
    @ResponseBody
    @RequestMapping(value="/updateResultOption2Value")
    public int updateResultOption2Value(HttpServletRequest request, Model model) {
    	    	
    	int nRet = 0;
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String suim_rpt_no = request.getParameter("suim_rpt_no") != null ? request.getParameter("suim_rpt_no") : "";
    	
    	nRet = sqlSession.selectOne("SuimReportMapper.selectResultOption1Cnt", suim_rpt_no);    	
    	
    	//신규 추가
    	
    	if( nRet == 0 ) {
    		nRet = sqlSession.insert("SuimReportMapper.insertResultOption2Value",paramMap);    		
    	}else{
    		nRet = sqlSession.update("SuimReportMapper.updateResultOption2Value",paramMap);
    	}    	
    	
    	return nRet;
    }
    
    /**
     * 조사결과 옵션 3 정보 갱신
     * @param request
     * @param model
     * @return
     */    
    @ResponseBody
    @RequestMapping(value="/updateResultOption3Value")
    public int updateResultOption3Value(HttpServletRequest request, Model model) {
    	    	
    	int nRet = 0;
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String suim_rpt_no = request.getParameter("suim_rpt_no") != null ? request.getParameter("suim_rpt_no") : "";
    	
    	nRet = sqlSession.selectOne("SuimReportMapper.selectResultOption1Cnt", suim_rpt_no);    	
    	
    	//신규 추가
    	
    	if( nRet == 0 ) {
    		nRet = sqlSession.insert("SuimReportMapper.insertResultOption3Value",paramMap);    		
    	}else{
    		nRet = sqlSession.update("SuimReportMapper.updateResultOption3Value",paramMap);
    	}    	
    	
    	return nRet;
    }
    
    /**
     * 조사결과 옵션 4 정보 갱신
     * @param request
     * @param model
     * @return
     */    
    @ResponseBody
    @RequestMapping(value="/updateResultOption4Value")
    public int updateResultOption4Value(HttpServletRequest request, Model model) {
    	    	
    	int nRet = 0;
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String suim_rpt_no = request.getParameter("suim_rpt_no") != null ? request.getParameter("suim_rpt_no") : "";
    	
    	nRet = sqlSession.selectOne("SuimReportMapper.selectResultOption1Cnt", suim_rpt_no);    	
    	
    	//신규 추가
    	
    	if( nRet == 0 ) {
    		nRet = sqlSession.insert("SuimReportMapper.insertResultOption4Value",paramMap);    		
    	}else{
    		nRet = sqlSession.update("SuimReportMapper.updateResultOption4Value",paramMap);
    	}    	
    	
    	return nRet;
    }
    
    /**
     * 조사결과 옵션 5 정보 갱신
     * @param request
     * @param model
     * @return
     */    
    @ResponseBody
    @RequestMapping(value="/updateResultOption5Value")
    public int updateResultOption5Value(HttpServletRequest request, Model model) {
    	    	
    	int nRet = 0;
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String suim_rpt_no = request.getParameter("suim_rpt_no") != null ? request.getParameter("suim_rpt_no") : "";
    	
    	nRet = sqlSession.selectOne("SuimReportMapper.selectResultOption1Cnt", suim_rpt_no);    	
    	
    	//신규 추가
    	
    	if( nRet == 0 ) {
    		nRet = sqlSession.insert("SuimReportMapper.insertResultOption5Value",paramMap);    		
    	}else{
    		nRet = sqlSession.update("SuimReportMapper.updateResultOption5Value",paramMap);
    	}    	
    	
    	return nRet;
    }
    
    /**
     * 총괄 데이터 삭제
     * @param request
     * @param model
     * @return
     */    
    @ResponseBody
    @RequestMapping(value="/deleteSummaryValue")
    public int deleteSummaryValue(HttpServletRequest request, Model model) {
    	
    	logger.info("============= deleteSummaryValue =============");
    	    	
    	int nRet = 0;
    	
    	String serial_no = request.getParameter("serial_no") != null ? request.getParameter("serial_no") : "";    	
    	
    	if( serial_no != null && !"".equals(serial_no) ) {
    		nRet = sqlSession.delete("SuimReportMapper.deleteSummaryValue", serial_no);
    	}
    	
    	return nRet;
    }
    
    /**
     * 기타 특이사항 (탐문리스트 가져오기)
     * @param request
     * @param model
     * @return
     */    
    @RequestMapping(value="/getOffceList7")
    public String getOffceList7(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getOffceList7 =========");
    	    	
    	String sUrl = "/top_suim_print/ajax/print_general_office_7";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);    	
    	
    	List<Map<String, Object>> reportOfficeList7 = sqlSession.selectList("SuimReportMapper.selectReportOfficeList7", paramMap);    	
    	
    	model.addAttribute("reportOfficeList7", reportOfficeList7);
    	
    	return sUrl;
    }
    
    /**
     * 기타 특이사항 (확인사항 안내 가져오기)
     * @param request
     * @param model
     * @return
     */    
    @RequestMapping(value="/getOffceList6")
    public String getOffceList6(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getOffceList6 =========");
    	    	
    	String sUrl = "/top_suim_print/ajax/print_general_office_6";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	
    	List<Map<String, Object>> reportOfficeList6 = sqlSession.selectList("SuimReportMapper.selectReportOfficeList6", paramMap);    	
    	
    	model.addAttribute("reportOfficeList6", reportOfficeList6);
    	
    	return sUrl;
    }
    
    /**
     * 기타 특이사항 (확인사항 안내 가져오기)
     * @param request
     * @param model
     * @return
     */    
    @RequestMapping(value="/getOffceList5")
    public String getOffceList5(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getOffceList5 =========");
    	    	
    	String sUrl = "/top_suim_print/ajax/print_general_office_5";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	
    	List<Map<String, Object>> reportOfficeList5 = sqlSession.selectList("SuimReportMapper.selectReportOfficeList5", paramMap);    	
    	
    	model.addAttribute("reportOfficeList5", reportOfficeList5);
    	
    	return sUrl;
    }
    
    /**
     * 관공서 관련 사항 4번 가져오기
     * @param request
     * @param model
     * @return
     */    
    @RequestMapping(value="/getOffceList4")
    public String getOffceList4(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getOffceList4 =========");
    	    	
    	String sUrl = "/top_suim_print/ajax/print_general_office_4";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	
    	List<Map<String, Object>> reportOfficeList4 = sqlSession.selectList("SuimReportMapper.selectReportOfficeList4", paramMap);    	
    	
    	model.addAttribute("reportOfficeList4", reportOfficeList4);
    	
    	return sUrl;
    }
    
    /**
     * 관공서 관련 사항 3번 가져오기
     * @param request
     * @param model
     * @return
     */    
    @RequestMapping(value="/getOffceList3")
    public String getOffceList3(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getOffceList3 =========");
    	    	
    	String sUrl = "/top_suim_print/ajax/print_general_office_3";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	
    	List<Map<String, Object>> reportOfficeList3 = sqlSession.selectList("SuimReportMapper.selectReportOfficeList3", paramMap);    	
    	
    	model.addAttribute("reportOfficeList3", reportOfficeList3);
    	
    	return sUrl;
    }
    
    /**
     * 관공서 관련 사항 2번 가져오기
     * @param request
     * @param model
     * @return
     */    
    @RequestMapping(value="/getOffceList2")
    public String getOffceList2(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getOffceList2 =========");
    	    	
    	String sUrl = "/top_suim_print/ajax/print_general_office_2";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	
    	List<Map<String, Object>> reportOfficeList2 = sqlSession.selectList("SuimReportMapper.selectReportOfficeList2", paramMap);    	
    	
    	model.addAttribute("reportOfficeList2", reportOfficeList2);
    	
    	return sUrl;
    }
    
    /**
     * 사고처리과정표 삭제
     * @param request
     * @param model
     * @return
     */    
    @ResponseBody
    @RequestMapping(value="/deleteSagoListValue")
    public int deleteSagoListValue(HttpServletRequest request, Model model) {
    	
    	logger.info("========= deleteSagoListValue =========");
    	    	
    	int nRet = 0;
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String serial_no = request.getParameter("serial_no") != null ? request.getParameter("serial_no") : "";
    	
    	if( serial_no != null && !"".equals(serial_no)) {
    		nRet = sqlSession.delete("SuimReportMapper.deleteSagoListValue",paramMap);    		
    	}
    	
    	return nRet;
    }
    
    /**
     * 사고처리과정표 추가
     * @param request
     * @param model
     * @return
     */    
    @ResponseBody
    @RequestMapping(value="/insertSagoListValue")
    public int insertSagoListValue(HttpServletRequest request, Model model) {
    	
    	logger.info("========= insertSagoListValue =========");
    	    	
    	int nRet = 0;
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String suim_rpt_no = request.getParameter("suim_rpt_no") != null ? request.getParameter("suim_rpt_no") : "";
    	
    	if( suim_rpt_no != null && !"".equals(suim_rpt_no)) {
    		nRet = sqlSession.insert("SuimReportMapper.insertSagoListValue",paramMap);    		
    	}
    	
    	return nRet;
    }
    
    /**
     * 사고처리과정표 수정
     * @param request
     * @param model
     * @return
     */    
    @ResponseBody
    @RequestMapping(value="/updateSagoListValue")
    public int updateSagoListValue(HttpServletRequest request, Model model) {
    	
    	logger.info("========= updateSagoListValue =========");
    	    	
    	int nRet = 0;
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String serial_no = request.getParameter("serial_no") != null ? request.getParameter("serial_no") : "";
    	
    	if( serial_no != null && !"".equals(serial_no)) {
    		nRet = sqlSession.update("SuimReportMapper.updateSagoListValue",paramMap);    		
    	}
    	
    	return nRet;
    }
    
    /**
     * 사고처리과정표 처리과정 가져오기
     * @param request
     * @param model
     * @return
     */    
    @RequestMapping(value="/getSagoList")
    public String getSagoList(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getSagoList =========");
    	    	
    	String sUrl = "/top_suim_print/ajax/print_general_sagolist";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);    	
    	
    	List<SuimRptSagoBscVO> sagoList = sqlSession.selectList("SagoBscMapper.getSagoListForPrint", paramMap.get("suim_rpt_no").toString());    	
    	
    	model.addAttribute("sagoList", sagoList);
    	
    	return sUrl;
    }
    
    /**
     * 관공서 관련 사항 1번 가져오기
     * @param request
     * @param model
     * @return
     */    
    @RequestMapping(value="/getOffceList1")
    public String getOffceList1(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getOffceList1 =========");
    	    	
    	String sUrl = "/top_suim_print/ajax/print_general_office_1";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	
    	List<Map<String, Object>> reportOfficeList1 = sqlSession.selectList("SuimReportMapper.selectReportOfficeList1", paramMap);    	
    	
    	model.addAttribute("reportOfficeList1", reportOfficeList1);
    	
    	return sUrl;
    }
    
    /**
     * 총괄표 데이터 목록
     * @param request
     * @param model
     * @return
     */    
    @RequestMapping(value="/getSummaryList")
    public String getSummaryList(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getSummaryList =========");
    	    	
    	String sUrl = "/top_suim_print/ajax/print_general_summary";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	
    	List<Map<String, Object>> reportSummaryList = sqlSession.selectList("SuimReportMapper.selectReportSummaryList", paramMap);    	
    	
    	model.addAttribute("reportSummaryList", reportSummaryList);
    	
    	return sUrl;
    }
    
    /**
     * 총괄표 데이터 추가
     * @param request
     * @param model
     * @return
     */    
    @ResponseBody
    @RequestMapping(value="/updateSummaryValue")
    public int updateSummaryValue(HttpServletRequest request, Model model) {
    	    	
    	int nRet = 0;
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String serial_no = request.getParameter("serial_no") != null ? request.getParameter("serial_no") : "";
    	
    	if( serial_no != null && !"".equals(serial_no)) {
    		nRet = sqlSession.update("SuimReportMapper.updateSummaryValue",paramMap);    		
    	}
    	
    	return nRet;
    }
    
    /**
     * 총괄표 데이터 추가
     * @param request
     * @param model
     * @return
     */    
    @ResponseBody
    @RequestMapping(value="/insertSummaryValue")
    public int insertSummaryValue(HttpServletRequest request, Model model) {
    	    	
    	int nRet = 0;
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	nRet = sqlSession.insert("SuimReportMapper.insertSummaryValue",paramMap);    	    	
    	
    	return nRet;
    }
    
    /**
     * 관공서 관련 사항 갱신
     * @param request
     * @param model
     * @return
     */    
    @ResponseBody
    @RequestMapping(value="/updateReportOffceList")
    public int updateReportOffceList(HttpServletRequest request, Model model) {
    	    	
    	int nRet = 0;
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String suim_rpt_no = request.getParameter("suim_rpt_no") != null ? request.getParameter("suim_rpt_no") : "";
    	
    	nRet = sqlSession.selectOne("SuimReportMapper.selectReportOfficeCnt", suim_rpt_no);
    	
    	if( nRet == 0 ) {
    		nRet = sqlSession.insert("SuimReportMapper.insertReportOfficeValue",paramMap);
    	}else {
    		nRet = sqlSession.update("SuimReportMapper.updateReportOfficeValue",paramMap);
    	}
    	
    	return nRet;
    }
    
    /**
     * 관공서 관련 사항 갱신7
     * @param request
     * @param model
     * @return
     */    
    @ResponseBody
    @RequestMapping(value="/updateReportOffceList7")
    public int updateReportOffceList7(HttpServletRequest request, Model model) {
    	    	
    	int nRet = 0;
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String suim_rpt_no = request.getParameter("suim_rpt_no") != null ? request.getParameter("suim_rpt_no") : "";
    	
    	nRet = sqlSession.selectOne("SuimReportMapper.selectReportOfficeCnt", suim_rpt_no);
    	
    	if( nRet == 0 ) {
    		nRet = sqlSession.insert("SuimReportMapper.insertReportOfficeValue",paramMap);
    	}else {
    		nRet = sqlSession.update("SuimReportMapper.updateReportOfficeValue7",paramMap);
    	}
    	
    	return nRet;
    }
    
    /**
     * 관공서 관련 사항 갱신6
     * @param request
     * @param model
     * @return
     */    
    @ResponseBody
    @RequestMapping(value="/updateReportOffceList6")
    public int updateReportOffceList6(HttpServletRequest request, Model model) {
    	    	
    	int nRet = 0;
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String suim_rpt_no = request.getParameter("suim_rpt_no") != null ? request.getParameter("suim_rpt_no") : "";
    	
    	nRet = sqlSession.selectOne("SuimReportMapper.selectReportOfficeCnt", suim_rpt_no);
    	
    	if( nRet == 0 ) {
    		nRet = sqlSession.insert("SuimReportMapper.insertReportOfficeValue",paramMap);
    	}else {
    		nRet = sqlSession.update("SuimReportMapper.updateReportOfficeValue6",paramMap);
    	}
    	
    	return nRet;
    }
    
    /**
     * 관공서 관련 사항 갱신5
     * @param request
     * @param model
     * @return
     */    
    @ResponseBody
    @RequestMapping(value="/updateReportOffceList5")
    public int updateReportOffceList5(HttpServletRequest request, Model model) {
    	    	
    	int nRet = 0;
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String suim_rpt_no = request.getParameter("suim_rpt_no") != null ? request.getParameter("suim_rpt_no") : "";
    	
    	nRet = sqlSession.selectOne("SuimReportMapper.selectReportOfficeCnt", suim_rpt_no);
    	
    	if( nRet == 0 ) {
    		nRet = sqlSession.insert("SuimReportMapper.insertReportOfficeValue",paramMap);
    	}else {
    		nRet = sqlSession.update("SuimReportMapper.updateReportOfficeValue5",paramMap);
    	}
    	
    	return nRet;
    }
    
    /**
     * 관공서 관련 사항 갱신4
     * @param request
     * @param model
     * @return
     */    
    @ResponseBody
    @RequestMapping(value="/updateReportOffceList4")
    public int updateReportOffceList4(HttpServletRequest request, Model model) {
    	    	
    	int nRet = 0;
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String suim_rpt_no = request.getParameter("suim_rpt_no") != null ? request.getParameter("suim_rpt_no") : "";
    	
    	nRet = sqlSession.selectOne("SuimReportMapper.selectReportOfficeCnt", suim_rpt_no);
    	
    	if( nRet == 0 ) {
    		nRet = sqlSession.insert("SuimReportMapper.insertReportOfficeValue",paramMap);
    	}else {
    		nRet = sqlSession.update("SuimReportMapper.updateReportOfficeValue4",paramMap);
    	}
    	
    	return nRet;
    }
    
    /**
     * 관공서 관련 사항 갱신3
     * @param request
     * @param model
     * @return
     */    
    @ResponseBody
    @RequestMapping(value="/updateReportOffceList3")
    public int updateReportOffceList3(HttpServletRequest request, Model model) {
    	    	
    	int nRet = 0;
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String suim_rpt_no = request.getParameter("suim_rpt_no") != null ? request.getParameter("suim_rpt_no") : "";
    	
    	nRet = sqlSession.selectOne("SuimReportMapper.selectReportOfficeCnt", suim_rpt_no);
    	
    	if( nRet == 0 ) {
    		nRet = sqlSession.insert("SuimReportMapper.insertReportOfficeValue",paramMap);
    	}else {
    		nRet = sqlSession.update("SuimReportMapper.updateReportOfficeValue3",paramMap);
    	}
    	
    	return nRet;
    }
    
    /**
     * 관공서 관련 사항 갱신2
     * @param request
     * @param model
     * @return
     */    
    @ResponseBody
    @RequestMapping(value="/updateReportOffceList2")
    public int updateReportOffceList2(HttpServletRequest request, Model model) {
    	    	
    	int nRet = 0;
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String suim_rpt_no = request.getParameter("suim_rpt_no") != null ? request.getParameter("suim_rpt_no") : "";
    	
    	nRet = sqlSession.selectOne("SuimReportMapper.selectReportOfficeCnt", suim_rpt_no);
    	
    	if( nRet == 0 ) {
    		nRet = sqlSession.insert("SuimReportMapper.insertReportOfficeValue",paramMap);
    	}else {
    		nRet = sqlSession.update("SuimReportMapper.updateReportOfficeValue2",paramMap);
    	}
    	
    	return nRet;
    }
    
    /**
     * 관공서 관련 사항 갱신1
     * @param request
     * @param model
     * @return
     */    
    @ResponseBody
    @RequestMapping(value="/updateReportOffceList1")
    public int updateReportOffceList1(HttpServletRequest request, Model model) {
    	    	
    	int nRet = 0;
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String suim_rpt_no = request.getParameter("suim_rpt_no") != null ? request.getParameter("suim_rpt_no") : "";
    	
    	nRet = sqlSession.selectOne("SuimReportMapper.selectReportOfficeCnt", suim_rpt_no);
    	
    	if( nRet == 0 ) {
    		nRet = sqlSession.insert("SuimReportMapper.insertReportOfficeValue",paramMap);
    	}else {
    		nRet = sqlSession.update("SuimReportMapper.updateReportOfficeValue1",paramMap);
    	}
    	
    	return nRet;
    }
    
    /**
     * 조사결과 옵션2 줄바꿈 처리값 가져오기
     * @param request
     * @param model
     * @return
     */    
    @ResponseBody
    @RequestMapping(value="/getResultOption2Value", produces = "application/text; charset=utf8")
    public String getResultOption2Value(HttpServletRequest request, Model model) {
    	
    	String sVal = "";
    	
    	String suim_rpt_no = request.getParameter("suim_rpt_no") != null ? request.getParameter("suim_rpt_no") : "";
    	
    	sVal = sqlSession.selectOne("SuimReportMapper.selectResultOption2Value", suim_rpt_no);
    	
    	//줄바꿈 처리
    	if( sVal != null && !"".equals(sVal) ) {    		
    		sVal = sVal.replaceAll("\n","<br/>");
    	}    	
    	return sVal;
    }
    
    /**
     * 조사결과 옵션3 줄바꿈 처리값 가져오기
     * @param request
     * @param model
     * @return
     */    
    @ResponseBody
    @RequestMapping(value="/getResultOption3Value", produces = "application/text; charset=utf8")
    public String getResultOption3Value(HttpServletRequest request, Model model) {
    	
    	String sVal = "";
    	
    	String suim_rpt_no = request.getParameter("suim_rpt_no") != null ? request.getParameter("suim_rpt_no") : "";
    	
    	sVal = sqlSession.selectOne("SuimReportMapper.selectResultOption3Value", suim_rpt_no);
    	
    	//줄바꿈 처리
    	if( sVal != null && !"".equals(sVal) ) {    		
    		sVal = sVal.replaceAll("\n","<br/>");
    	}    	
    	return sVal;
    }
    
    /**
     * 조사결과 옵션4 줄바꿈 처리값 가져오기
     * @param request
     * @param model
     * @return
     */    
    @ResponseBody
    @RequestMapping(value="/getResultOption4Value", produces = "application/text; charset=utf8")
    public String getResultOption4Value(HttpServletRequest request, Model model) {
    	
    	String sVal = "";
    	
    	String suim_rpt_no = request.getParameter("suim_rpt_no") != null ? request.getParameter("suim_rpt_no") : "";
    	
    	sVal = sqlSession.selectOne("SuimReportMapper.selectResultOption4Value", suim_rpt_no);
    	
    	//줄바꿈 처리
    	if( sVal != null && !"".equals(sVal) ) {    		
    		sVal = sVal.replaceAll("\n","<br/>");
    	}    	
    	return sVal;
    }
    
    /**
     * 조사결과 옵션5 줄바꿈 처리값 가져오기
     * @param request
     * @param model
     * @return
     */    
    @ResponseBody
    @RequestMapping(value="/getResultOption5Value", produces = "application/text; charset=utf8")
    public String getResultOption5Value(HttpServletRequest request, Model model) {
    	
    	String sVal = "";
    	
    	String suim_rpt_no = request.getParameter("suim_rpt_no") != null ? request.getParameter("suim_rpt_no") : "";
    	
    	sVal = sqlSession.selectOne("SuimReportMapper.selectResultOption5Value", suim_rpt_no);
    	
    	//줄바꿈 처리
    	if( sVal != null && !"".equals(sVal) ) {    		
    		sVal = sVal.replaceAll("\n","<br/>");
    	}    	
    	return sVal;
    }
    
    /**
     * 조사결과 옵션1 줄바꿈 처리값 가져오기
     * @param request
     * @param model
     * @return
     */    
    @ResponseBody
    @RequestMapping(value="/getResultOption1Value", produces = "application/text; charset=utf8")
    public String getResultOption1Value(HttpServletRequest request, Model model) {
    	
    	String sVal = "";
    	
    	String suim_rpt_no = request.getParameter("suim_rpt_no") != null ? request.getParameter("suim_rpt_no") : "";
    	
    	sVal = sqlSession.selectOne("SuimReportMapper.selectResultOption1Value", suim_rpt_no);
    	
    	//줄바꿈 처리
    	if( sVal != null && !"".equals(sVal) ) {    		
    		sVal = sVal.replaceAll("\n","<br/>");
    	}    	
    	return sVal;
    }
    
    /**
     * 조사결과 옵션1 값 가져오기
     * @param request
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/getResultOption1EditValue", produces = "application/text; charset=utf8")
    public String getResultOption1EditValue(HttpServletRequest request, Model model) {
    	
    	String sVal = "";
    	
    	String suim_rpt_no = request.getParameter("suim_rpt_no") != null ? request.getParameter("suim_rpt_no") : "";
    	
    	sVal = sqlSession.selectOne("SuimReportMapper.selectResultOption1Value", suim_rpt_no);
    	    	
    	return sVal;
    }
    
    /**
     * 조사결과 옵션2 값 가져오기
     * @param request
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/getResultOption2EditValue", produces = "application/text; charset=utf8")
    public String getResultOption2EditValue(HttpServletRequest request, Model model) {
    	
    	String sVal = "";
    	
    	String suim_rpt_no = request.getParameter("suim_rpt_no") != null ? request.getParameter("suim_rpt_no") : "";
    	
    	sVal = sqlSession.selectOne("SuimReportMapper.selectResultOption2Value", suim_rpt_no);
    	    	
    	return sVal;
    }
    
    /**
     * 조사결과 옵션3 값 가져오기
     * @param request
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/getResultOption3EditValue", produces = "application/text; charset=utf8")
    public String getResultOption3EditValue(HttpServletRequest request, Model model) {
    	
    	String sVal = "";
    	
    	String suim_rpt_no = request.getParameter("suim_rpt_no") != null ? request.getParameter("suim_rpt_no") : "";
    	
    	sVal = sqlSession.selectOne("SuimReportMapper.selectResultOption3Value", suim_rpt_no);
    	    	
    	return sVal;
    }
    
    /**
     * 조사결과 옵션4 값 가져오기
     * @param request
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/getResultOption4EditValue", produces = "application/text; charset=utf8")
    public String getResultOption4EditValue(HttpServletRequest request, Model model) {
    	
    	String sVal = "";
    	
    	String suim_rpt_no = request.getParameter("suim_rpt_no") != null ? request.getParameter("suim_rpt_no") : "";
    	
    	sVal = sqlSession.selectOne("SuimReportMapper.selectResultOption4Value", suim_rpt_no);
    	    	
    	return sVal;
    }
    
    /**
     * 조사결과 옵션5 값 가져오기
     * @param request
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/getResultOption5EditValue", produces = "application/text; charset=utf8")
    public String getResultOption5EditValue(HttpServletRequest request, Model model) {
    	
    	String sVal = "";
    	
    	String suim_rpt_no = request.getParameter("suim_rpt_no") != null ? request.getParameter("suim_rpt_no") : "";
    	
    	sVal = sqlSession.selectOne("SuimReportMapper.selectResultOption5Value", suim_rpt_no);
    	    	
    	return sVal;
    }
    
    @ResponseBody
    @RequestMapping(value="/getEstimationValue")
    public String getEstimationValue(HttpServletRequest request, Model model) {
    	
    	String sVal = "";
    	
    	String suim_rpt_no = request.getParameter("suim_rpt_no") != null ? request.getParameter("suim_rpt_no") : "";
    	
    	sVal = sqlSession.selectOne("SuimReportMapper.selectEstimationValue", suim_rpt_no);
    	
    	return sVal;
    }
    
    /**
     * 신규 4종 보고서 컨트롤러
     * @param request
     * @param model
     * @return
     */    
    @RequestMapping(value = "/reportBscInfoNew")
    public String reportBscInfoNew(HttpServletRequest request, Model model){
        
        logger.info("======== reportBscInfoNew ========");
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String cmd = StringUtil.null2blank(request.getParameter("cmd"));
        //===============================================
        // 비즈니스 로직
        //===============================================
        //기본정보 가져오기
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

        //================================================================
        //  일반 보고서 기본정보
        //================================================================
        //일반 보고서 기본정보가 있는지 확인 없으면 기본입력
        Map<String, Object> reportPrint1isExist = sqlSession.selectOne("SuimReportMapper.selectReportPrint1", paramMap);
        if (reportPrint1isExist == null){
            sqlSession.insert("SuimReportMapper.insertReportPrint1ForExist", paramMap);
        }

        //일반 보고서 기본정보
        Map<String, Object> reportPrint1 = sqlSession.selectOne("SuimReportMapper.selectReportPrint1", paramMap);

        //담보내역 리스트
        paramMap.put("rpt_print_no", reportPrint1.get("rptPrintNo"));
        List<Map<String, Object>> reportAssureList = sqlSession.selectList("SuimReportMapper.selectReportPrint1AssureList", paramMap);
        
        List<Map<String, Object>> reportAssureListSub = sqlSession.selectList("SuimReportMapper.selectReportPrint1AssureListSub", paramMap);

        //타 보험사 계약 및 지급사항
        List<Map<String, Object>> reportOtherInsuList = sqlSession.selectList("SuimReportMapper.selectOtherInsuList", paramMap);


        //중점 조사사항 및 조사결과
        //조사사항 코드리스트
        paramMap.put("tbl_nm", "top_rpt_print_1");
        paramMap.put("col_nm", "inspect_point_4");
        List<Map<String, Object>> reportPointCodeList = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);

        //조사결과 코드리스트
        paramMap.put("tbl_nm", "top_rpt_print_1");
        paramMap.put("col_nm", "inspect_result_4");
        List<Map<String, Object>> reportResultCodeList = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);

        //총괄경과표
        List<Map<String, Object>> reportGeneralPassList = sqlSession.selectList("SuimReportMapper.selectGeneralPassList",paramMap);

        //상세 확인사항
        paramMap.put("tbl_nm", "top_rpt_print_1_detail_check");
        paramMap.put("col_nm", "job");
        List<Map<String, Object>> reportJobCodeList = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);

        paramMap.put("tbl_nm", "top_rpt_print_1_detail_check");
        paramMap.put("col_nm", "accident");
        List<Map<String, Object>> reportAccidentCodeList = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);

        List<Map<String, Object>> tempDetailConfirmList = sqlSession.selectList("SuimReportMapper.selectDetailConfirmList",paramMap);


        Map<String, Object> reportDetailConfirmMap = new HashMap<>();
        List<Map<String, Object>> reportDetailConfirmList = new ArrayList<>();

        for (int i = 0; i < tempDetailConfirmList.size(); i++){
            Map<String, Object> item = tempDetailConfirmList.get(i);
            String gubun = item.get("detailGubun").toString();

            if("1".equals(gubun)){
                reportDetailConfirmMap.put("detail1", item);

            }else if("2".equals(gubun)){
                reportDetailConfirmMap.put("detail2", item);

            }else if("3".equals(gubun)){
                reportDetailConfirmMap.put("detail3", item);

            }else if("4".equals(gubun)){
                reportDetailConfirmMap.put("detail4", item);

            }else if("5".equals(gubun)){
                reportDetailConfirmMap.put("detail5", item);

            }else if("99".equals(gubun)){
                reportDetailConfirmList.add(item);
            }
        }

        //사고처리과정 처리과정 리스트
        List<Map<String, Object>> reportAccidentProcessList = sqlSession.selectList("SuimReportMapper.selectReportPrint1CtrlList",paramMap);

        //세부내용 코드리스트
        paramMap.put("tbl_nm", "top_rpt_print_1_ctrl");
        paramMap.put("col_nm", "control_memo");
        List<Map<String, Object>> reportMemoCodeList = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);

        //=============================================================
        // 업무내용 코드리스트
        //=============================================================
        // 담당자, 피보험자, 계약자 + 보험사 + 총괄경과표 비고 리스트
        //=============================================================
        //reportGeneralPassList 총괄경과표
        List<String> reportWorkCodeList = new ArrayList<>();
        reportWorkCodeList.add("담당자");
        reportWorkCodeList.add("피보험자");
        reportWorkCodeList.add("계약자");
        reportWorkCodeList.add(reportBscInfo.get("ptnrName").toString());

        Set<String> tmpSetList = new HashSet<String>();
        for(int idx=0; idx < reportGeneralPassList.size() ; idx++){
            tmpSetList.add(reportGeneralPassList.get(idx).get("investigateOutline").toString());
        }
        Iterator<String> iterator = tmpSetList.iterator();
        while( iterator.hasNext() ) {
            reportWorkCodeList.add(iterator.next());
        }

        //=============================================================
        // 첨부 서류 리스트
        //=============================================================
        List<Map<String, Object>> reportAttachDocList = sqlSession.selectList("SuimReportMapper.selectAttachDocList",paramMap);
        List<String> reportAttachDocCodeList = new ArrayList<>();

        tmpSetList = new HashSet<String>();
        for(int idx=0; idx < reportAccidentProcessList.size() ; idx++){
            tmpSetList.add(reportAccidentProcessList.get(idx).get("controlSubject").toString());
        }
        Iterator<String> itrAttachDoc = tmpSetList.iterator();
        while( itrAttachDoc.hasNext() ) {
            reportAttachDocCodeList.add(itrAttachDoc.next());
        }

        //=============================================================
        // 병의원 탐문 기록지
        //=============================================================
        List<Map<String, Object>> reportHospitalQuestionList = sqlSession.selectList("SuimReportMapper.selectHospitalQuestionList",paramMap);

        //=============================================================
        // 첨부 이미지 리스트
        //=============================================================
        List<Map<String, Object>> reportAttachImageList = sqlSession.selectList("SuimReportMapper.selectAttachImageList",paramMap);
        
        //신규 조사결과 by top3009
        List<Map<String,Object>> reportResult = sqlSession.selectList("SuimReportMapper.selectReportResult", paramMap);
        
        //신규 총과 경과표
        List<Map<String, Object>> reportSummaryList = sqlSession.selectList("SuimReportMapper.selectReportSummaryList", paramMap);
        
        //신규 관공서확인사항
        List<Map<String, Object>> reportOfficeList1 = sqlSession.selectList("SuimReportMapper.selectReportOfficeList1", paramMap);
        List<Map<String, Object>> reportOfficeList2 = sqlSession.selectList("SuimReportMapper.selectReportOfficeList2", paramMap);
        List<Map<String, Object>> reportOfficeList3 = sqlSession.selectList("SuimReportMapper.selectReportOfficeList3", paramMap);
        List<Map<String, Object>> reportOfficeList4 = sqlSession.selectList("SuimReportMapper.selectReportOfficeList4", paramMap);
        List<Map<String, Object>> reportOfficeList5 = sqlSession.selectList("SuimReportMapper.selectReportOfficeList5", paramMap);
        List<Map<String, Object>> reportOfficeList6 = sqlSession.selectList("SuimReportMapper.selectReportOfficeList6", paramMap);
        List<Map<String, Object>> reportOfficeList7 = sqlSession.selectList("SuimReportMapper.selectReportOfficeList7", paramMap);
        
        //공통 사고처리과정표 가져오기
        List<SuimRptSagoBscVO> sagoList = sqlSession.selectList("SagoBscMapper.getSagoListForPrint", paramMap.get("suim_rpt_no").toString());
        
        
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
        model.addAttribute("reportPrint1", reportPrint1);
        model.addAttribute("reportAssureList", reportAssureList);
        model.addAttribute("reportAssureListSub", reportAssureListSub);
        model.addAttribute("reportOtherInsuList", reportOtherInsuList);
        model.addAttribute("reportPointCodeList", reportPointCodeList);
        model.addAttribute("reportResultCodeList", reportResultCodeList);
        model.addAttribute("reportGeneralPassList", reportGeneralPassList);

        model.addAttribute("reportJobCodeList", reportJobCodeList);
        model.addAttribute("reportAccidentCodeList", reportAccidentCodeList);
        model.addAttribute("reportDetailConfirmMap", reportDetailConfirmMap);
        model.addAttribute("reportDetailConfirmList", reportDetailConfirmList);

        model.addAttribute("reportAccidentProcessList", reportAccidentProcessList);
        model.addAttribute("reportMemoCodeList", reportMemoCodeList);
        model.addAttribute("reportWorkCodeList", reportWorkCodeList);

        model.addAttribute("reportAttachDocList", reportAttachDocList);
        model.addAttribute("reportAttachDocCodeList", reportAttachDocCodeList);

        model.addAttribute("reportHospitalQuestionList", reportHospitalQuestionList);
        model.addAttribute("reportAttachImageList", reportAttachImageList);
        
        model.addAttribute("reportResult", reportResult);
        model.addAttribute("reportSummaryList", reportSummaryList);
        
        model.addAttribute("reportOfficeList1", reportOfficeList1);
        model.addAttribute("reportOfficeList2", reportOfficeList2);
        model.addAttribute("reportOfficeList3", reportOfficeList3);
        model.addAttribute("reportOfficeList4", reportOfficeList4);
        model.addAttribute("reportOfficeList5", reportOfficeList5);
        model.addAttribute("reportOfficeList6", reportOfficeList6);
        model.addAttribute("reportOfficeList7", reportOfficeList7);
        
        model.addAttribute("sagoList", sagoList);

        String retURL = "top_suim_print/suim_rpt_bsc_print_general_new";

        if ("word".equals(cmd)){
            retURL = "top_suim_print/suim_rpt_bsc_print_general_new_word";
        }else if("print".equals(cmd)){
            retURL = "top_suim_print/suim_rpt_bsc_print_general_new_print";
        }

        System.out.println("retURL:["+retURL+"]");

        return retURL;
    }

    @RequestMapping(value = "/reportBscInfo")
    public String reportBscInfo(HttpServletRequest request, Model model){
        
        logger.info("======== reportBscInfo ========");
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String cmd = StringUtil.null2blank(request.getParameter("cmd"));
        //===============================================
        // 비즈니스 로직
        //===============================================
        //기본정보 가져오기
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

        //================================================================
        //  일반 보고서 기본정보
        //================================================================
        //일반 보고서 기본정보가 있는지 확인 없으면 기본입력
        Map<String, Object> reportPrint1isExist = sqlSession.selectOne("SuimReportMapper.selectReportPrint1", paramMap);
        if (reportPrint1isExist == null){
            sqlSession.insert("SuimReportMapper.insertReportPrint1ForExist", paramMap);
        }

        //일반 보고서 기본정보
        Map<String, Object> reportPrint1 = sqlSession.selectOne("SuimReportMapper.selectReportPrint1", paramMap);

        //담보내역 리스트
        paramMap.put("rpt_print_no", reportPrint1.get("rptPrintNo"));
        List<Map<String, Object>> reportAssureList = sqlSession.selectList("SuimReportMapper.selectReportPrint1AssureList", paramMap);
        
        List<Map<String, Object>> reportAssureListSub = sqlSession.selectList("SuimReportMapper.selectReportPrint1AssureListSub", paramMap);

        //타 보험사 계약 및 지급사항
        List<Map<String, Object>> reportOtherInsuList = sqlSession.selectList("SuimReportMapper.selectOtherInsuList", paramMap);


        //중점 조사사항 및 조사결과
        //조사사항 코드리스트
        paramMap.put("tbl_nm", "top_rpt_print_1");
        paramMap.put("col_nm", "inspect_point_4");
        List<Map<String, Object>> reportPointCodeList = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);

        //조사결과 코드리스트
        paramMap.put("tbl_nm", "top_rpt_print_1");
        paramMap.put("col_nm", "inspect_result_4");
        List<Map<String, Object>> reportResultCodeList = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);

        //총괄경과표
        List<Map<String, Object>> reportGeneralPassList = sqlSession.selectList("SuimReportMapper.selectGeneralPassList",paramMap);

        //상세 확인사항
        paramMap.put("tbl_nm", "top_rpt_print_1_detail_check");
        paramMap.put("col_nm", "job");
        List<Map<String, Object>> reportJobCodeList = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);

        paramMap.put("tbl_nm", "top_rpt_print_1_detail_check");
        paramMap.put("col_nm", "accident");
        List<Map<String, Object>> reportAccidentCodeList = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);

        List<Map<String, Object>> tempDetailConfirmList = sqlSession.selectList("SuimReportMapper.selectDetailConfirmList",paramMap);


        Map<String, Object> reportDetailConfirmMap = new HashMap<>();
        List<Map<String, Object>> reportDetailConfirmList = new ArrayList<>();

        for (int i = 0; i < tempDetailConfirmList.size(); i++){
            Map<String, Object> item = tempDetailConfirmList.get(i);
            String gubun = item.get("detailGubun").toString();

            if("1".equals(gubun)){
                reportDetailConfirmMap.put("detail1", item);

            }else if("2".equals(gubun)){
                reportDetailConfirmMap.put("detail2", item);

            }else if("3".equals(gubun)){
                reportDetailConfirmMap.put("detail3", item);

            }else if("4".equals(gubun)){
                reportDetailConfirmMap.put("detail4", item);

            }else if("5".equals(gubun)){
                reportDetailConfirmMap.put("detail5", item);

            }else if("99".equals(gubun)){
                reportDetailConfirmList.add(item);
            }
        }

        //사고처리과정 처리과정 리스트
        List<Map<String, Object>> reportAccidentProcessList = sqlSession.selectList("SuimReportMapper.selectReportPrint1CtrlList",paramMap);

        //세부내용 코드리스트
        paramMap.put("tbl_nm", "top_rpt_print_1_ctrl");
        paramMap.put("col_nm", "control_memo");
        List<Map<String, Object>> reportMemoCodeList = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);

        //=============================================================
        // 업무내용 코드리스트
        //=============================================================
        // 담당자, 피보험자, 계약자 + 보험사 + 총괄경과표 비고 리스트
        //=============================================================
        //reportGeneralPassList 총괄경과표
        List<String> reportWorkCodeList = new ArrayList<>();
        reportWorkCodeList.add("담당자");
        reportWorkCodeList.add("피보험자");
        reportWorkCodeList.add("계약자");
        reportWorkCodeList.add(reportBscInfo.get("ptnrName").toString());

        Set<String> tmpSetList = new HashSet<String>();
        for(int idx=0; idx < reportGeneralPassList.size() ; idx++){
            tmpSetList.add(reportGeneralPassList.get(idx).get("investigateOutline").toString());
        }
        Iterator<String> iterator = tmpSetList.iterator();
        while( iterator.hasNext() ) {
            reportWorkCodeList.add(iterator.next());
        }

        //=============================================================
        // 첨부 서류 리스트
        //=============================================================
        List<Map<String, Object>> reportAttachDocList = sqlSession.selectList("SuimReportMapper.selectAttachDocList",paramMap);
        List<String> reportAttachDocCodeList = new ArrayList<>();

        tmpSetList = new HashSet<String>();
        for(int idx=0; idx < reportAccidentProcessList.size() ; idx++){
            tmpSetList.add(reportAccidentProcessList.get(idx).get("controlSubject").toString());
        }
        Iterator<String> itrAttachDoc = tmpSetList.iterator();
        while( itrAttachDoc.hasNext() ) {
            reportAttachDocCodeList.add(itrAttachDoc.next());
        }

        //=============================================================
        // 병의원 탐문 기록지
        //=============================================================
        List<Map<String, Object>> reportHospitalQuestionList = sqlSession.selectList("SuimReportMapper.selectHospitalQuestionList",paramMap);

        //=============================================================
        // 첨부 이미지 리스트
        //=============================================================
        List<Map<String, Object>> reportAttachImageList = sqlSession.selectList("SuimReportMapper.selectAttachImageList",paramMap);

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("reportBscInfo", reportBscInfo);
        model.addAttribute("reportTeamInfo", reportTeamInfo);
        model.addAttribute("reportInvgUser", reportInvgUser);
        model.addAttribute("reportAprvUser", reportAprvUser);
        model.addAttribute("reportPrint1", reportPrint1);
        model.addAttribute("reportAssureList", reportAssureList);
        model.addAttribute("reportAssureListSub", reportAssureListSub);
        model.addAttribute("reportOtherInsuList", reportOtherInsuList);
        model.addAttribute("reportPointCodeList", reportPointCodeList);
        model.addAttribute("reportResultCodeList", reportResultCodeList);
        model.addAttribute("reportGeneralPassList", reportGeneralPassList);

        model.addAttribute("reportJobCodeList", reportJobCodeList);
        model.addAttribute("reportAccidentCodeList", reportAccidentCodeList);
        model.addAttribute("reportDetailConfirmMap", reportDetailConfirmMap);
        model.addAttribute("reportDetailConfirmList", reportDetailConfirmList);

        model.addAttribute("reportAccidentProcessList", reportAccidentProcessList);
        model.addAttribute("reportMemoCodeList", reportMemoCodeList);
        model.addAttribute("reportWorkCodeList", reportWorkCodeList);

        model.addAttribute("reportAttachDocList", reportAttachDocList);
        model.addAttribute("reportAttachDocCodeList", reportAttachDocCodeList);

        model.addAttribute("reportHospitalQuestionList", reportHospitalQuestionList);
        model.addAttribute("reportAttachImageList", reportAttachImageList);


        String retURL = "top_suim_print/suim_rpt_bsc_print_general";

        if ("word".equals(cmd)){
            retURL = "top_suim_print/suim_rpt_bsc_print_general_word";
        }else if("print".equals(cmd)){
            retURL = "top_suim_print/suim_rpt_bsc_print_general_print";
        }

        System.out.println("retURL:["+retURL+"]");

        return retURL;
    }

    /**
     * 계약사항 업데이트
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_contract_update")
    public String reportContractUpdate(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        //기본정보 업데이트
        sqlSession.update("SuimReportMapper.updateSuimReportContract", paramMap);

        //일반보고서 업데이트
        sqlSession.update("SuimReportMapper.updateReportPrint1Contract", paramMap);

        //기본정보 가져오기
        Map<String, Object> reportBscInfo = sqlSession.selectOne("SuimReportMapper.selectSuimReport", paramMap);

        //일반 보고서 기본정보
        Map<String, Object> reportPrint1 = sqlSession.selectOne("SuimReportMapper.selectReportPrint1", paramMap);

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("reportBscInfo", reportBscInfo);
        model.addAttribute("reportPrint1", reportPrint1);
        return "top_suim_print/ajax/print_contract";
    }

    /**
     * 청구사항 업데이트
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_claim_update")
    public String reportClaimUpdate(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        //일반보고서 업데이트
        sqlSession.update("SuimReportMapper.updateReportPrint1Claim", paramMap);

        //일반 보고서 기본정보
        Map<String, Object> reportPrint1 = sqlSession.selectOne("SuimReportMapper.selectReportPrint1", paramMap);
        //담보내역 리스트
        paramMap.put("rpt_print_no", reportPrint1.get("rptPrintNo"));
        List<Map<String, Object>> reportAssureList = sqlSession.selectList("SuimReportMapper.selectReportPrint1AssureList", paramMap);
        
      //담보내역 리스트
        List<Map<String, Object>> reportAssureListSub = sqlSession.selectList("SuimReportMapper.selectReportPrint1AssureListSub", paramMap);

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("reportPrint1", reportPrint1);        
        model.addAttribute("reportAssureList", reportAssureList);
        model.addAttribute("reportAssureListSub", reportAssureListSub);
        return "top_suim_print/ajax/print_claim";
    }
    
    @RequestMapping(value = "/report_claim_sub2_insert")
    public String reportClaimSub2Insert(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        //담보내역 및 추정손해약 추가
        sqlSession.insert("SuimReportMapper.insertReportPrint1ClaimSub2", paramMap);

        //일반 보고서 기본정보
        Map<String, Object> reportPrint1 = sqlSession.selectOne("SuimReportMapper.selectReportPrint1", paramMap);
        //담보내역 리스트
        paramMap.put("rpt_print_no", reportPrint1.get("rptPrintNo"));
        List<Map<String, Object>> reportAssureListSub = sqlSession.selectList("SuimReportMapper.selectReportPrint1AssureListSub", paramMap);

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("reportPrint1", reportPrint1);
        model.addAttribute("reportAssureListSub", reportAssureListSub);
        return "top_suim_print/ajax/print_claim";
    }
    
    @RequestMapping(value = "/report_claim_sub2_update")
    public String reportClaimSub2Update(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        //담보내역 및 추정손해약 추가
        sqlSession.update("SuimReportMapper.updateReportPrint1ClaimSub2", paramMap);        

        //일반 보고서 기본정보
        Map<String, Object> reportPrint1 = sqlSession.selectOne("SuimReportMapper.selectReportPrint1", paramMap);
        //담보내역 리스트
        paramMap.put("rpt_print_no", reportPrint1.get("rptPrintNo"));
        List<Map<String, Object>> reportAssureListSub = sqlSession.selectList("SuimReportMapper.selectReportPrint1AssureListSub", paramMap);

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("reportPrint1", reportPrint1);
        model.addAttribute("reportAssureListSub", reportAssureListSub);
        return "top_suim_print/ajax/print_claim";
    }

    @RequestMapping(value = "/report_claim_sub_insert")
    public String reportClaimSubInsert(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        //담보내역 및 추정손해약 추가
        sqlSession.insert("SuimReportMapper.insertReportPrint1ClaimSub", paramMap);

        //일반 보고서 기본정보
        Map<String, Object> reportPrint1 = sqlSession.selectOne("SuimReportMapper.selectReportPrint1", paramMap);
        //담보내역 리스트
        paramMap.put("rpt_print_no", reportPrint1.get("rptPrintNo"));
        List<Map<String, Object>> reportAssureList = sqlSession.selectList("SuimReportMapper.selectReportPrint1AssureList", paramMap);

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("reportPrint1", reportPrint1);
        model.addAttribute("reportAssureList", reportAssureList);
        return "top_suim_print/ajax/print_claim";
    }

    @RequestMapping(value = "/report_claim_sub_update")
    public String reportClaimSubUpdate(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        //담보내역 및 추정손해약 추가
        sqlSession.update("SuimReportMapper.updateReportPrint1ClaimSub", paramMap);

        //일반 보고서 기본정보
        Map<String, Object> reportPrint1 = sqlSession.selectOne("SuimReportMapper.selectReportPrint1", paramMap);

        //담보내역 리스트
        List<Map<String, Object>> reportAssureList = sqlSession.selectList("SuimReportMapper.selectReportPrint1AssureList", paramMap);

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("reportPrint1", reportPrint1);
        model.addAttribute("reportAssureList", reportAssureList);
        return "top_suim_print/ajax/print_claim";
    }

    @RequestMapping(value = "/report_claim_sub_delete")
    public String reportClaimSubDelete(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        //담보내역 및 추정손해약 추가
        sqlSession.delete("SuimReportMapper.deleteReportPrint1ClaimSub", paramMap);

        //일반 보고서 기본정보
        Map<String, Object> reportPrint1 = sqlSession.selectOne("SuimReportMapper.selectReportPrint1", paramMap);

        //담보내역 리스트
        List<Map<String, Object>> reportAssureList = sqlSession.selectList("SuimReportMapper.selectReportPrint1AssureList", paramMap);

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("reportPrint1", reportPrint1);
        model.addAttribute("reportAssureList", reportAssureList);
        return "top_suim_print/ajax/print_claim";
    }
    
    @RequestMapping(value = "/report_claim_sub2_delete")
    public String reportClaimSub2Delete(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        //담보내역 및 추정손해약 추가
        sqlSession.delete("SuimReportMapper.deleteReportPrint1ClaimSub2", paramMap);

        //일반 보고서 기본정보
        Map<String, Object> reportPrint1 = sqlSession.selectOne("SuimReportMapper.selectReportPrint1", paramMap);

        //담보내역 리스트
        List<Map<String, Object>> reportAssureListSub = sqlSession.selectList("SuimReportMapper.selectReportPrint1AssureListSub", paramMap);

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("reportPrint1", reportPrint1);
        model.addAttribute("reportAssureListSub", reportAssureListSub);
        return "top_suim_print/ajax/print_claim";
    }


    @RequestMapping(value = "/report_other_insu_insert")
    public String reportOtherInsuInsert(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        //타 보험사 계약 및 지급사항 추가
        sqlSession.insert("SuimReportMapper.insertReportOtherInsu", paramMap);

        //타 보험사 계약 및 지급사항
        List<Map<String, Object>> reportOtherInsuList = sqlSession.selectList("SuimReportMapper.selectOtherInsuList", paramMap);

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("reportOtherInsuList", reportOtherInsuList);
        return "top_suim_print/ajax/print_other_insu";
    }

    @RequestMapping(value = "/report_other_insu_update")
    public String reportOtherInsuUpdate(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        //타 보험사 계약 및 지급사항 수정
        sqlSession.update("SuimReportMapper.updateReportOtherInsu", paramMap);

        //타 보험사 계약 및 지급사항
        List<Map<String, Object>> reportOtherInsuList = sqlSession.selectList("SuimReportMapper.selectOtherInsuList", paramMap);

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("reportOtherInsuList", reportOtherInsuList);
        return "top_suim_print/ajax/print_other_insu";
    }

    @RequestMapping(value = "/report_other_insu_delete")
    public String reportOtherInsuDelete(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        //타 보험사 계약 및 지급사항 삭제
        sqlSession.delete("SuimReportMapper.deleteReportOtherInsu", paramMap);

        //타 보험사 계약 및 지급사항
        List<Map<String, Object>> reportOtherInsuList = sqlSession.selectList("SuimReportMapper.selectOtherInsuList", paramMap);

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("reportOtherInsuList", reportOtherInsuList);
        return "top_suim_print/ajax/print_other_insu";
    }

    @RequestMapping(value = "/report_emphasis_invest_update")
    public String reportEmphasisInvestUpdate(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        //중점조사사항 업데이트
        sqlSession.update("SuimReportMapper.updateEmphasisInvest", paramMap);

        //일반 보고서 기본정보
        Map<String, Object> reportPrint1 = sqlSession.selectOne("SuimReportMapper.selectReportPrint1", paramMap);

        //중점 조사사항 및 조사결과
        //조사사항 코드리스트
        paramMap.put("tbl_nm", "top_rpt_print_1");
        paramMap.put("col_nm", "inspect_point_4");
        List<Map<String, Object>> reportPointCodeList = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);

        //조사결과 코드리스트
        paramMap.put("tbl_nm", "top_rpt_print_1");
        paramMap.put("col_nm", "inspect_result_4");
        List<Map<String, Object>> reportResultCodeList = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("reportPrint1", reportPrint1);
        model.addAttribute("reportPointCodeList", reportPointCodeList);
        model.addAttribute("reportResultCodeList", reportResultCodeList);

        return "top_suim_print/ajax/print_emphasis";
    }


    @RequestMapping(value = "/report_emphasis_result_update")
    public String reportEmphasisResultUpdate(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        //중점조사사항 업데이트
        sqlSession.update("SuimReportMapper.updateEmphasisResult", paramMap);

        //일반 보고서 기본정보
        Map<String, Object> reportPrint1 = sqlSession.selectOne("SuimReportMapper.selectReportPrint1", paramMap);

        //중점 조사사항 및 조사결과
        //조사사항 코드리스트
        paramMap.put("tbl_nm", "top_rpt_print_1");
        paramMap.put("col_nm", "inspect_point_4");
        List<Map<String, Object>> reportPointCodeList = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);

        //조사결과 코드리스트
        paramMap.put("tbl_nm", "top_rpt_print_1");
        paramMap.put("col_nm", "inspect_result_4");
        List<Map<String, Object>> reportResultCodeList = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("reportPrint1", reportPrint1);
        model.addAttribute("reportPointCodeList", reportPointCodeList);
        model.addAttribute("reportResultCodeList", reportResultCodeList);

        return "top_suim_print/ajax/print_emphasis";
    }

    /**
     * 총괄경과표 입력 수정 삭제
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_general_pass")
    public String reportGeneralPass(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String type = String.valueOf(paramMap.get("type"));

        //===============================================
        // 비즈니스 로직
        //===============================================
        //총괄경과표 업데이트
        if ("C".equals(type)){
            sqlSession.insert("SuimReportMapper.insertGeneralPass", paramMap);
        }else if("U".equals(type)){
            sqlSession.update("SuimReportMapper.updateGeneralPass", paramMap);
        }else if("D".equals(type)){
            sqlSession.delete("SuimReportMapper.deleteGeneralPass", paramMap);
        }

        //총괄경과표
        List<Map<String, Object>> reportGeneralPassList = sqlSession.selectList("SuimReportMapper.selectGeneralPassList",paramMap);

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("reportGeneralPassList", reportGeneralPassList);
        return "top_suim_print/ajax/print_general_pass";
    }

    /**
     * 상세 확인사항 사용 미사용
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_detail_confirm_useflag")
    public @ResponseBody Map<String, Object> reportDetailConfirmUseFlag(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        //이미 있는지 체크
        Long cnt = sqlSession.selectOne("SuimReportMapper.selectDetailConfirmExistCnt", paramMap);

        System.out.println("CNT:["+cnt+"]");


        if (cnt > 0){
            sqlSession.update("SuimReportMapper.updateDetailConfirmUseFlag", paramMap);

        } else {
            sqlSession.insert("SuimReportMapper.insertDetailConfirm", paramMap);
        }

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================

        return paramMap;
    }

    /**
     * 상세확인사항 내용 업데이트
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_detail_confirm_update")
    public @ResponseBody Map<String, Object> reportDetailConfirmUpdate(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        sqlSession.update("SuimReportMapper.updateDetailConfirm", paramMap);

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================

        return paramMap;
    }

    /**
     * 상세확인사항 기타 입력
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_detail_confirm_insert")
    public String reportDetailConfirmInsert(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        paramMap.put("use_flag", "1");
        sqlSession.insert("SuimReportMapper.insertDetailConfirm", paramMap);


        //상세 확인사항
        List<Map<String, Object>> tempDetailConfirmList = sqlSession.selectList("SuimReportMapper.selectDetailConfirmList",paramMap);


        Map<String, Object> reportDetailConfirmMap = new HashMap<>();
        List<Map<String, Object>> reportDetailConfirmList = new ArrayList<>();

        for (int i = 0; i < tempDetailConfirmList.size(); i++){
            Map<String, Object> item = tempDetailConfirmList.get(i);
            String gubun = item.get("detailGubun").toString();

            if("1".equals(gubun)){
                reportDetailConfirmMap.put("detail1", item);

            }else if("2".equals(gubun)){
                reportDetailConfirmMap.put("detail2", item);

            }else if("3".equals(gubun)){
                reportDetailConfirmMap.put("detail3", item);

            }else if("4".equals(gubun)){
                reportDetailConfirmMap.put("detail4", item);

            }else if("5".equals(gubun)){
                reportDetailConfirmMap.put("detail5", item);

            }else if("99".equals(gubun)){
                reportDetailConfirmList.add(item);
            }
        }
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("reportDetailConfirmMap", reportDetailConfirmMap);
        model.addAttribute("reportDetailConfirmList", reportDetailConfirmList);

        return "top_suim_print/ajax/print_detail_confirm";
    }

    /**
     * 상세확인 사항 삭제
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_detail_confirm_delete")
    public String reportDetailConfirmDelete(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        sqlSession.delete("SuimReportMapper.deleteDetailConfirm", paramMap);

        //상세 확인사항
        List<Map<String, Object>> tempDetailConfirmList = sqlSession.selectList("SuimReportMapper.selectDetailConfirmList",paramMap);


        Map<String, Object> reportDetailConfirmMap = new HashMap<>();
        List<Map<String, Object>> reportDetailConfirmList = new ArrayList<>();

        for (int i = 0; i < tempDetailConfirmList.size(); i++){
            Map<String, Object> item = tempDetailConfirmList.get(i);
            String gubun = item.get("detailGubun").toString();

            if("1".equals(gubun)){
                reportDetailConfirmMap.put("detail1", item);

            }else if("2".equals(gubun)){
                reportDetailConfirmMap.put("detail2", item);

            }else if("3".equals(gubun)){
                reportDetailConfirmMap.put("detail3", item);

            }else if("4".equals(gubun)){
                reportDetailConfirmMap.put("detail4", item);

            }else if("5".equals(gubun)){
                reportDetailConfirmMap.put("detail5", item);

            }else if("99".equals(gubun)){
                reportDetailConfirmList.add(item);
            }
        }
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("reportDetailConfirmMap", reportDetailConfirmMap);
        model.addAttribute("reportDetailConfirmList", reportDetailConfirmList);

        return "top_suim_print/ajax/print_detail_confirm";
    }


    /**
     * 손해사정결과 (조사자 의견) 사용 미사용 처리
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_emphasis_opinion_useat")
    public @ResponseBody Map<String, Object> reportEmphasisOpinionUseAt(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        sqlSession.update("SuimReportMapper.updateEmphasisOpinionUseAt", paramMap);

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================

        return paramMap;
    }


    /**
     * 손해사정결과 (조사자 의견) 업데이트
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_emphasis_opinion_update")
    public @ResponseBody Map<String, Object> reportEmphasisOpinionUpdate(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        sqlSession.update("SuimReportMapper.updateEmphasisOpinion", paramMap);

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================

        return paramMap;
    }

    /**
     * 사고처리 과정표 사고처리 입력 수정 삭제
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_accident_process")
    public String reportAccidentProcess(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String cmd = String.valueOf(paramMap.get("cmd"));

        //===============================================
        // 비즈니스 로직
        //===============================================
        if ("C".equals(cmd)){
            sqlSession.insert("SuimReportMapper.insertAccidentProcess", paramMap);
        }else if("U".equals(cmd)){
            sqlSession.update("SuimReportMapper.updateAccidentProcess", paramMap);
        }else if("D".equals(cmd)){
            sqlSession.delete("SuimReportMapper.deleteAccidentProcess", paramMap);
        }else if("TU".equals(cmd)){
            sqlSession.update("SuimReportMapper.updateAccidentProcessPrint1", paramMap);
        }

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================

        //기본정보
        Map<String, Object> reportBscInfo = sqlSession.selectOne("SuimReportMapper.selectSuimReport", paramMap);

        //일반 보고서 기본정보
        Map<String, Object> reportPrint1 = sqlSession.selectOne("SuimReportMapper.selectReportPrint1", paramMap);

        //총괄경과표
        List<Map<String, Object>> reportGeneralPassList = sqlSession.selectList("SuimReportMapper.selectGeneralPassList",paramMap);

        //사고처리과정 처리과정 리스트
        List<Map<String, Object>> reportAccidentProcessList = sqlSession.selectList("SuimReportMapper.selectReportPrint1CtrlList",paramMap);

        //세부내용 코드리스트
        paramMap.put("tbl_nm", "top_rpt_print_1_ctrl");
        paramMap.put("col_nm", "control_memo");
        List<Map<String, Object>> reportMemoCodeList = sqlSession.selectList("SuimReportMapper.selectCodeList",paramMap);

        //=============================================================
        // 업무내용 코드리스트
        //=============================================================
        // 담당자, 피보험자, 계약자 + 보험사 + 총괄경과표 비고 리스트
        //=============================================================
        //reportGeneralPassList 총괄경과표
        List<String> reportWorkCodeList = new ArrayList<>();
        reportWorkCodeList.add("담당자");
        reportWorkCodeList.add("피보험자");
        reportWorkCodeList.add("계약자");
        reportWorkCodeList.add(reportBscInfo.get("ptnrName").toString());

        Set<String> tmpSetList = new HashSet<String>();
        for(int idx=0; idx < reportGeneralPassList.size() ; idx++){
            tmpSetList.add(reportGeneralPassList.get(idx).get("investigateOutline").toString());
        }
        Iterator<String> iterator = tmpSetList.iterator();
        while( iterator.hasNext() ) {
            reportWorkCodeList.add(iterator.next());
        }

        model.addAttribute("reportAccidentProcessList", reportAccidentProcessList);
        model.addAttribute("reportMemoCodeList", reportMemoCodeList);
        model.addAttribute("reportWorkCodeList", reportWorkCodeList);
        model.addAttribute("reportPrint1", reportPrint1);

        String ptnrId = reportBscInfo.get("ptnrId").toString();

        String retURL = "top_suim_print/ajax/print_accident_process_basic";

        if ("9".equals(ptnrId)){
            retURL = "top_suim_print/ajax/print_accident_process_ptnr9";
        }

        return retURL;
    }

    /**
     * 첨부서류 사용여부 업데이트
     * @param request(suim_rpt_no, rpt_print_no, use_flag:사용여부)
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_attach_doc_useflag")
    public @ResponseBody Map<String, Object> reportAttachDocUseFlag(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        sqlSession.update("SuimReportMapper.updateAttachDocUseFlag", paramMap);

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================

        return paramMap;
    }

    /**
     * 첨부서류 입력 수정 삭제
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_attach_doc")
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
            sqlSession.insert("SuimReportMapper.insertAttachDoc", paramMap);
        }else if("U".equals(cmd)){
            sqlSession.update("SuimReportMapper.updateAttachDoc", paramMap);
        }else if("D".equals(cmd)){
            sqlSession.delete("SuimReportMapper.deleteAttachDoc", paramMap);
        }

        //===============================================
        // 뷰단 데이터 세팅
        //==============================================
        //사고처리과정 처리과정 리스트
        List<Map<String, Object>> reportAccidentProcessList = sqlSession.selectList("SuimReportMapper.selectReportPrint1CtrlList",paramMap);

        List<Map<String, Object>> reportAttachDocList = sqlSession.selectList("SuimReportMapper.selectAttachDocList",paramMap);
        List<String> reportAttachDocCodeList = new ArrayList<>();

        //사고처리 과정표 업무내용이 첨부서류 비고 select box 코드 리스트가 됨
        Set<String> tmpSetList = new HashSet<String>();
        for(int idx=0; idx < reportAccidentProcessList.size() ; idx++){
            tmpSetList.add(reportAccidentProcessList.get(idx).get("controlSubject").toString());
        }
        Iterator<String> itrAttachDoc = tmpSetList.iterator();
        while( itrAttachDoc.hasNext() ) {
            reportAttachDocCodeList.add(itrAttachDoc.next());
        }

        model.addAttribute("reportAttachDocList", reportAttachDocList);
        model.addAttribute("reportAttachDocCodeList", reportAttachDocCodeList);

        return "top_suim_print/ajax/print_attach_doc";
    }

    /**
     * 병의원 탐문 기록지 입력 수정 삭제
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_hospital_question")
    public String reportHospitalQuestion(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String cmd = String.valueOf(paramMap.get("cmd"));

        //===============================================
        // 비즈니스 로직
        //===============================================
        if ("C".equals(cmd)){
            sqlSession.insert("SuimReportMapper.insertHospitalQuestion", paramMap);
        }else if("U".equals(cmd)){
            sqlSession.update("SuimReportMapper.updateHospitalQuestion", paramMap);
        }else if("D".equals(cmd)){
            sqlSession.delete("SuimReportMapper.deleteHospitalQuestion", paramMap);
        }

        //===============================================
        // 뷰단 데이터 세팅
        //==============================================
        List<Map<String, Object>> reportHospitalQuestionList = sqlSession.selectList("SuimReportMapper.selectHospitalQuestionList",paramMap);
        model.addAttribute("reportHospitalQuestionList", reportHospitalQuestionList);

        return "top_suim_print/ajax/print_hospital_question";
    }

    /**
     * 첨부 이미지 수정 삭제
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_attach_image")
    public String reportAttachImage(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String cmd = String.valueOf(paramMap.get("cmd"));

        //===============================================
        // 비즈니스 로직
        //===============================================
        if ("U".equals(cmd)){
            sqlSession.update("SuimReportMapper.updateAttachImage", paramMap);
        }else if("D".equals(cmd)){
            //첨부파일 삭제
            String realPath = "";
            //realPath = "/home/hosting_users/toplac/www";
            realPath = "/Users/kohyeonseok/devroot/21.idea_workspace/toplac/upload";

            Map<String, Object> item = sqlSession.selectOne("SuimReportMapper.selectAttachImage", paramMap);

            String filePath = item.get("filePath").toString();
            String imgName = item.get("imgName").toString();

            realPath = realPath + filePath + imgName;
            try {
                File file = new File(realPath);
                file.delete();
            } catch (Exception e){
                e.printStackTrace();
            }

            //데이터 삭제
            sqlSession.delete("SuimReportMapper.deleteAttachImage", paramMap);
        }

        //===============================================
        // 뷰단 데이터 세팅
        //==============================================
        List<Map<String, Object>> reportAttachImageList = sqlSession.selectList("SuimReportMapper.selectAttachImageList",paramMap);
        model.addAttribute("reportAttachImageList", reportAttachImageList);

        return "top_suim_print/ajax/print_attach_image";
    }

}
