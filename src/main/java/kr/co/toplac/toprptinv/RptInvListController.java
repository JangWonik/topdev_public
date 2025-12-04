package kr.co.toplac.toprptinv;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import kr.co.toplac.sysadm.SysAdmCodeDicVO;
import kr.co.toplac.topptnr.TopPtnrBscVO;
import kr.co.toplac.topstatistics.StatisticsNowVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.page.PageUtilityBasic;

@Controller
public class RptInvListController {

	private static final Logger logger = LoggerFactory.getLogger(RptInvListController.class);

	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "rptTaxListExcel", method = RequestMethod.GET)
	public String rptTaxListExcel(Model model, HttpSession session, TopRptTaxListSearchVO searchVO, String reqPgNo, HttpServletRequest request) {

		logger.info("======= rptTaxListExcel =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_7().equals("0") ){
			logger.info("rptInvList - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}			
		
		//페이징 없이 전체 목록
		List<TopRptTaxListViewVO> invListTotal = sqlSession.selectList("RptInvListMapper.getTaxListTotal", searchVO);		
		
		double total_tax_amount = 0;
		double total_deposit_amount = 0;
		double total_minus_amount = 0;
		
		for(int i=0; i < invListTotal.size(); i++) {
			total_tax_amount += invListTotal.get(i).getSum_tax_val();
			total_deposit_amount += invListTotal.get(i).getSum_deposit_val();
			total_minus_amount += invListTotal.get(i).getSum_minus_val();
		}

		model.addAttribute("searchVO", searchVO);
		model.addAttribute("invList", invListTotal);
		
		model.addAttribute("total_tax_amount", total_tax_amount);
		model.addAttribute("total_deposit_amount", total_deposit_amount);
		model.addAttribute("total_minus_amount", total_minus_amount);

		return "top_rpt_inv/rpt_tax_list_excel";
	}
	
	/**
	 * 보험사별 세금계산서 합계 엑셀다운
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "topRptTaxSummaryExcel")
	public String topRptTaxSummaryExcel(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= topRptTaxSummaryExcel =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);		
		
		List<Map<String, Object>> summaryExcelList = sqlSession.selectList("RptInvListMapper.getInvTaxPtnrSummaryList", paramMap);		
		
		model.addAttribute("summaryExcelList", summaryExcelList);
		model.addAttribute("srchParam", paramMap);

		return "top_rpt_inv/top_rpt_tax_summary_excel";
	}
	
	/**
	 * 보험사별 세금계산서 합계 통계
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "topRptTaxSummaryAjax")
	public String topRptTaxSummaryAjax(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= topRptTaxSummaryAjax =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);		
		
		List<Map<String, Object>> summaryList = sqlSession.selectList("RptInvListMapper.getInvTaxPtnrSummaryList", paramMap);		
		
		model.addAttribute("summaryList", summaryList);
		model.addAttribute("srchParam", paramMap);

		return "top_rpt_inv/top_rpt_tax_summary_ajax";
	}
	
	@RequestMapping(value = "rptTaxSearch", method = RequestMethod.GET)
	public String rptTaxSearch(Model model, HttpSession session, TopRptTaxListSearchVO searchVO, String reqPgNo, HttpServletRequest request) {

		logger.info("======= rptTaxSearch =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_7().equals("0") ){
			logger.info("rptInvList - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
					
		/* 팀목록 추출*/
		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
		model.addAttribute("teamList", teamList);
		/* 파트너목록 추출*/
		List<TopPtnrBscVO> ptnrList = sqlSession.selectList("RptInvListMapper.ptnrListForSearch");
		model.addAttribute("ptnrList", ptnrList);
		
		/*직원리스트 가져오기*/
		List<TopTmBscVO> memberList = sqlSession.selectList("StatisticBasic.selectTopMemberList", paramMap);
		model.addAttribute("memberList", memberList);
		
		PageUtilityBasic pageUtil = new PageUtilityBasic();
		int totCntInt = sqlSession.selectOne("RptInvListMapper.getTaxListCnt", searchVO);//총 조회 건수		
		int queryPgNoInt = pageUtil.pageBasic2(1, totCntInt, reqPgNo, model, "rptTaxSearch");
		searchVO.setQueryPgNoInt(queryPgNoInt);		

		List<TopRptTaxListViewVO> invList = sqlSession.selectList("RptInvListMapper.getTaxList", searchVO);
		
		//페이징 없이 전체 목록
		List<TopRptTaxListViewVO> invListTotal = sqlSession.selectList("RptInvListMapper.getTaxListTotal", searchVO);		
		
		double total_tax_amount = 0;
		double total_deposit_amount = 0;
		double total_minus_amount = 0;
		
		for(int i=0; i < invListTotal.size(); i++) {
			total_tax_amount += invListTotal.get(i).getSum_tax_val();
			total_deposit_amount += invListTotal.get(i).getSum_deposit_val();
			total_minus_amount += invListTotal.get(i).getSum_minus_val();
		}

		model.addAttribute("searchVO", searchVO);
		model.addAttribute("invList", invList);
		model.addAttribute("totCntInt", totCntInt);		
		
		model.addAttribute("total_tax_amount", total_tax_amount);
		model.addAttribute("total_deposit_amount", total_deposit_amount);
		model.addAttribute("total_minus_amount", total_minus_amount);

		return "top_rpt_inv/rpt_tax_list";
	}
	
	@RequestMapping(value = "sDepositManage", method = RequestMethod.GET)
	public String sDepositManage(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= sDepositManage =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_7().equals("0") ){
			logger.info("rptInvList - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		/* 보험사 목록 추출*/
		List<TopPtnrBscVO> ptnrList = sqlSession.selectList("RptInvListMapper.ptnrListForSearch");
		model.addAttribute("ptnrList", ptnrList);
		
		return "top_rpt_inv/small_deposit_manage";
		
	}
	
	/**
	 * 소액 입금관리 목록 엑셀다운
	 * @param model
	 * @param session
	 * @param response
	 * @param request
	 * @param incomeFile
	 * @return
	 */
	@RequestMapping(value = "smallDepositManageExcel", method = RequestMethod.POST)	
	public String smallDepositManageExcel(Model model, HttpSession session,HttpServletResponse response, HttpServletRequest request, MultipartFile incomeFile) {
		
		logger.info("======= smallDepositManageExcel =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);		

		List<Map<String, Object>> depositList = sqlSession.selectList("InvoiceDtlMapper.selectDepositSearchList", paramMap);
		
		Date dateToday = new Date();
		DateFormat df = new SimpleDateFormat("yyyyMMdd");//오늘날자구하기
		String today = df.format(dateToday);
		
		String fileName = "소액입금관리_"+today+".xls";
		String title = "소액입금관리_"+today;
		
		try {
			fileName = java.net.URLEncoder.encode(fileName,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("depositList", depositList);
		model.addAttribute("depositListCnt", depositList.size());
		model.addAttribute("today",today);
		model.addAttribute("title",title);
		
		response.setHeader("Content-Disposition", "attachment;filename="+fileName);
		response.setHeader("Content-Type", "application/vnd.ms-xls");
		response.setHeader("Content-Description", "JSP Generated Data");
		response.setHeader("Content-Transfer-Encoding", "binary");
		
		return "top_rpt_inv/small_deposit_manage_excel";
	}
	
	/** 
	 * 소액 입금관리 목록 불러오기 
	 * @param model
	 * @param session
	 * @param response
	 * @param request
	 * @param incomeFile
	 * @return
	 */
	@RequestMapping(value = "smallDepositManageAjax", method = RequestMethod.POST)	
	public String smallDepositManageAjax(Model model, HttpSession session,HttpServletResponse response, HttpServletRequest request, MultipartFile incomeFile) {
		
		logger.info("======= smallDepositManageAjax =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		List<Map<String, Object>> depositList = sqlSession.selectList("InvoiceDtlMapper.selectDepositSearchList", paramMap);
		
		/* 보험사 목록 추출*/
		List<TopPtnrBscVO> ptnrList = sqlSession.selectList("RptInvListMapper.ptnrListForSearch");
		model.addAttribute("ptnrList", ptnrList);
				
		model.addAttribute("depositList", depositList);
		model.addAttribute("param", paramMap);
		
		return "top_rpt_inv/small_deposit_manage_ajax";
	}
	
	/**
	 * 재무 소액 입금데이터 등록,수정,삭제처리
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/depositManageAction")
    @ResponseBody
    public Map<String, Object> depositManageAction(HttpServletRequest request, Model model, HttpSession session) {
		
		Map<String, Object> returnMap = new HashMap<>();		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		//작업자 등록을 위한 사번체크
		String sWorkUserNo = String.valueOf(session.getAttribute("user_no_Session"));
				
		String sActionFlag = String.valueOf(paramMap.get("action"));			//I:추가 U:갱신, D:삭제
		int nChk = 0;
				
		if( "I".equals(sActionFlag) ) {		//데이터 추가
			//작업자 사번을 등록사번으로 넣는다.
			paramMap.put("reg_user_no", sWorkUserNo);
			
			nChk = sqlSession.insert("RptInvListMapper.insertSmallDepositManage", paramMap);
			
		}
		
		if( "U".equals(sActionFlag) ) {
			//작업자 사번을 수정사번으로 넣는다.
			paramMap.put("modify_user_no", sWorkUserNo);
			
			nChk = sqlSession.update("RptInvListMapper.updateSmallDepositManage", paramMap);
		}
		
		if( "D".equals(sActionFlag) ) {
			paramMap.put("del_user_no", sWorkUserNo);
			
			nChk = sqlSession.update("RptInvListMapper.deleteSmallDepositManage", paramMap);
		}
		
		if( nChk == 1 ) {
			returnMap.put("msg", "success");
		}else{
			returnMap.put("msg", "fail");
		}
		
		return returnMap;
	}
	
	@RequestMapping(value = "rptTaxList", method = RequestMethod.GET)
	public String rptTaxList(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= rptTaxList =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_7().equals("0") ){
			logger.info("rptInvList - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);

		/* 팀목록 추출*/
		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
		model.addAttribute("teamList", teamList);
		/* 파트너목록 추출*/
		List<TopPtnrBscVO> ptnrList = sqlSession.selectList("RptInvListMapper.ptnrListForSearch");
		model.addAttribute("ptnrList", ptnrList);
		
		/*직원리스트 가져오기*/
		List<TopTmBscVO> memberList = sqlSession.selectList("StatisticBasic.selectTopMemberList", paramMap);
		model.addAttribute("memberList", memberList);
		
		/* suim_rpt_type1 추출*/
		//List<SysAdmCodeDicVO> type1List = sqlSession.selectList("RptInvListMapper.suimRptType1ForSearch");
		//model.addAttribute("type1List", type1List);
				

		return "top_rpt_inv/rpt_tax_list";
	}

	/*
	*********************************************************
	* Program ID	: suimBookList
	* Program Name	: suimBookList
	* Description	: 수임대장 리스트
	* Author		: 이동익
	* Date			: 2016.05.02.
	* 번호 1(수정:이선형): 2016.05.09. 
	*********************************************************
	*/
	@RequestMapping(value = "rptInvList", method = RequestMethod.GET)
	public String rptInvList(Model model, HttpSession session) {

		logger.info("======= rptInvList =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_7().equals("0") ){
			logger.info("rptInvList - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		/* 팀목록 추출*/
		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
		model.addAttribute("teamList", teamList);
		/* 파트너목록 추출*/
		List<TopPtnrBscVO> ptnrList = sqlSession.selectList("RptInvListMapper.ptnrListForSearch");
		model.addAttribute("ptnrList", ptnrList);
		/* suim_rpt_type1 추출*/
		List<SysAdmCodeDicVO> type1List = sqlSession.selectList("RptInvListMapper.suimRptType1ForSearch");
		model.addAttribute("type1List", type1List);

		return "top_rpt_inv/rpt_inv_list";
	}//rptInvList
	
	@RequestMapping(value = "incomeLogListAjax", method = RequestMethod.POST)	
	public String incomeLogListAjax(Model model, HttpSession session,HttpServletResponse response, HttpServletRequest request, MultipartFile incomeFile) {
		
		logger.info("======= incomeLogListAjax =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);		
		
		List<Map<String, Object>> logSearchList = sqlSession.selectList("InvoiceDtlMapper.selectInComeLogSearchList", paramMap);
				
		model.addAttribute("logSearchList", logSearchList);		
		
		return "top_rpt_inv/rpt_inv_income_file_log_search_ajax";
	}
	
	/**
	 * 입금일 파일등록 로그 조회
	 * @param model
	 * @param session
	 * @param response
	 * @param request
	 * @param incomeFile
	 * @return
	 */
	@RequestMapping(value = "incomeWorkLogView", method = RequestMethod.POST)	
	public String incomeWorkLogView(Model model, HttpSession session,HttpServletResponse response, HttpServletRequest request, MultipartFile incomeFile) {
		
		logger.info("======= incomeWorkLogView =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		model.addAttribute("paramMap", paramMap);

		return "top_rpt_inv/rpt_inv_income_file_log_search";
	}
	
	/**
	 * 등록하려는 파일 목록 조회
	 * @param model
	 * @param session
	 * @param response
	 * @param request
	 * @param incomeFile
	 * @return
	 */	
	@RequestMapping(value = "incomeFileListView", method = RequestMethod.POST)	
	public String incomeFileListView(Model model, HttpSession session,HttpServletResponse response, HttpServletRequest request, MultipartFile incomeFile) {
		
		logger.info("======= incomeFileListView =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sFileExt = "";			//파일 확장자
		String sFileName = "";		//원본 파일명		
		int nChk = 0;					//보고서 존재여부
				
		if( incomeFile != null ) {			//파일이 있는 경우 처리
			
			sFileName = incomeFile.getOriginalFilename();
			sFileExt = FilenameUtils.getExtension(sFileName);						//파일 확장자
			
			List<Map<String, Object>> prevList = new ArrayList<Map<String,Object>>(); 
			
			if( "csv".equals(sFileExt) ) {				
				try( BufferedReader br = new BufferedReader(new InputStreamReader(incomeFile.getInputStream())) ){
					
					String line = "";
					int nIdx = 0;				//순번					
					
					//String sSuimRptNo = "";			//보고서 번호
					String sAcceptNo = "";				//접수번호
					String sInComeDate = "";			//입금일자
					String [] orgLine;
					
					while( (line = br.readLine()) != null ) {
						
						Map<String,Object> tempMap = new HashMap<String,Object>();						
						
						//암호화 된 파일인지 확인한다.
						if( line.contains("ShadowCube") ) {
							paramMap.put("error", "Secure : 암호화 해제 후 등록 해 주세요.");
							break;
						}
						
						if( nIdx > 0 ) {			//첫번째 헤더는 제외							
							//콤마가 있는 경우만 콤마로 데이터를 구분한다.
							if(line.contains(",")) {
								orgLine = line.split(",");
								sAcceptNo = orgLine[0].trim();
								sInComeDate = orgLine[1].trim();
								tempMap.put("accept_no", sAcceptNo);
								tempMap.put("income_date", sInComeDate);								
								
								//접수번호로 보고서 존재여부 확인
								nChk = sqlSession.selectOne("InvoiceDtlMapper.countTopRptHeadBySuimAcceptNo", sAcceptNo);
								
								if( nChk == 1 ) {
									tempMap.put("enable", "true");		 //보고서 있음
								}else{
									tempMap.put("enable", "false");		//보고서 없음
								}
								
								prevList.add(tempMap);
							}
							
						}
						
						nIdx++;
					}
					model.addAttribute("prevList", prevList);					
									
				}catch( Exception e ) {
					//파일 에러
					paramMap.put("error", "FileError 파일 등록 오류가 발생하였습니다.");
				}
				
			}else{								//파일 형식이 안맞는 경우 (.csv 파일이 아닌 경우)			
				paramMap.put("error", "csv 파일이 아닙니다.");
			}			
			
		}else{									//업로드 할 파일이 없는 경우
			paramMap.put("error", "Date Empty");
		}
		
		model.addAttribute("paramMap", paramMap);		
		
		return "top_rpt_inv/rpt_inv_income_file_prev_list";
	}
	
	
	/**
	 * 입금일 파일 업로드 처리
	 * @param model
	 * @param session
	 * @param response
	 * @param request
	 * @param multipartRequest
	 * @return
	 */
	@RequestMapping(value = "incomeFileUpdate", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> incomeFileUpdate(Model model, HttpSession session,HttpServletResponse response, HttpServletRequest request, MultipartFile incomeFile) {
		
		logger.info("======= incomeFileUpdate =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		//결과값
		Map<String,Object> resultMap = new HashMap<String,Object>();		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);		
		
		String sFileExt = "";			//파일 확장자
		String sFileName = "";		//원본 파일명
		int resultInsertCnt = 0;				//입금일 등록수
		int resultUpdateCnt = 0;				//입금일 갱신수
		int resultFailCnt = 0;					//기존값이 있어 skip된 수
		int nEnd_chk = 0;						//작업완료 표시 여부
		
		//작업완료후 알려줄 메세지
		String resultMsg = "";
		
		//로그 등록 변수 시작		
		String work_no = DateUtil.getTimeStamp().substring(2, 14);			//작업번호				
		String work_user_no = mbrVo.getUser_no();				//작업자 사번
		String sActionFlag = "";
		//로그 등록 변수 끝
				
		if( incomeFile != null ) {			//파일이 있는 경우 처리
			
			sFileName = incomeFile.getOriginalFilename();
			sFileExt = FilenameUtils.getExtension(sFileName);						//파일 확장자
			
			if( "csv".equals(sFileExt) ) {				
				try( BufferedReader br = new BufferedReader(new InputStreamReader(incomeFile.getInputStream())) ){
					
					String line = "";
					int nIdx = 0;				//순번
					int nCnt = 0;				//DB 체크 변수
					int nTotal_amt = 0;		//인보이스 합계금액
					int nCnt_sub = 0;		//기존 등록일자 금액이 없는 경우 체크 변수
					
					String sSuimRptNo = "";			//보고서 번호
					String sAcceptNo = "";				//접수번호
					String sInComeDate = "";			//입금일자
					String [] orgLine;					
					
					while( (line = br.readLine()) != null ) {
						
						//System.out.println( nIdx + " : "+line );
						
						//암호화 된 파일인지 확인한다.
						if( line.contains("ShadowCube") ) {
							resultMap.put("result", "Secure");
							break;
						}
						
						if( nIdx > 0 ) {			//첫번째 헤더는 제외
							
							//콤마가 있는 경우만 콤마로 데이터를 구분한다.
							if(line.contains(",")) {								
								
								Map<String,Object> logMap = new HashMap<String,Object>();	
								
								orgLine = line.split(",");
								sAcceptNo = orgLine[0].trim();
								sInComeDate = orgLine[1].trim();
								
								sSuimRptNo = sqlSession.selectOne("SuimRegInsMapper.getSuimRptNo", sAcceptNo);
								
								//보고서 번호
								paramMap.put("suim_rpt_no", sSuimRptNo);
								//입금일자.
								paramMap.put("deposit_date", sInComeDate);
								
								//세금계산서 테이블에 기존에 등록된 값을 체크한다.    			
								nCnt = sqlSession.selectOne("InvoiceDtlMapper.getInvTaxCnt", sSuimRptNo);
								
								//인보이스 합계금액을 가져온다.
								nTotal_amt = sqlSession.selectOne("InvoiceDtlMapper.getInvTotalAmt", sSuimRptNo);
								
								//입금액 신규추가
								paramMap.put("deposit_amount", nTotal_amt);
								
								//신규 세금계산서 테이블 정보 입력
								if( nCnt == 0 ) {
									//세금계산서 발행금액은 초기금액으로 입력
									paramMap.put("publish_amount", 0);
									sqlSession.insert("InvoiceDtlMapper.insertInvTax", paramMap);
									resultInsertCnt++;		//추가한 수를 증가시킨다.
									sActionFlag = "I";
								}else {    				
									//기존 입금일자 등록값이 있는지 확인한다.
									nCnt_sub = sqlSession.selectOne("InvoiceDtlMapper.getInvTaxDepositCnt", sSuimRptNo);
									if( nCnt_sub == 0 ){		//기존등록일자와 금액이 없는 경우만 update 한다.
										sqlSession.update("InvoiceDtlMapper.updateInvTaxDeposit", paramMap);
										resultUpdateCnt++;		//갱신한 수를 증가시킨다.
										sActionFlag = "U";										
									}else{
										resultFailCnt++;			//기존값이 있어서 skip 한 건수를 증가시킨다.
										sActionFlag = "P";										
									}
								}
								
								//인보이스 입금일자가 기존에 없는 경우 갱신
								sqlSession.update("InvoiceDtlMapper.updateInvDepositDate", paramMap);

								//인보이스의 세금계산서, 입금액 합을 비교하여 동일하면 작업완료로 표시한다.
								nEnd_chk = sqlSession.selectOne("InvoiceDtlMapper.chkInvTaxAmountSum", sSuimRptNo);    			    			

								//nEnd_chk : 1 (동일), 0 (합계값이 다름)
								paramMap.put("tax_edit_end", nEnd_chk);
								sqlSession.update("InvoiceDtlMapper.updateTaxWork", paramMap);

								//세금계산서 No를 인보이스킷값으로 갱신한다.    			
								sqlSession.update("InvoiceDtlMapper.updateInvInvoiceNoAutoSuimNo", sSuimRptNo);									
								
								//로그 등록 시작
								//로그 등록을 위한 임시 Map									
								logMap = sqlSession.selectOne("InvoiceDtlMapper.selectInComeLogInfo", sSuimRptNo);
								
								logMap.put("work_no", work_no);
								logMap.put("work_user_no", work_user_no);
								
								if( "I".equals(sActionFlag) ) {
									logMap.put("action_flag", "추가");
								}else if( "U".equals(sActionFlag) ) {
									logMap.put("action_flag", "갱신");
								}else{
									logMap.put("action_flag", "통과");
								}								
								
								sqlSession.insert("InvoiceDtlMapper.insertInComeLogInfo", logMap);
								//로그 등록 끝
							}
							
						}
						
						nIdx++;
					}
					
					
				}catch( Exception e ) {
					//파일 에러
					resultMap.put("result", "99");
				}				
				
			}else{								//파일 형식이 안맞는 경우 (.csv 파일이 아닌 경우)			
				resultMap.put("result", "9");
			}			
			
			//알림창으로 알려줄 메세지
			resultMsg += "세금계산서 등록 : "+resultInsertCnt+"건 \n";
			resultMsg += "세금계산서 갱신 : "+resultUpdateCnt+"건 \n";
			resultMsg += "세금계산서 존재(skip) : "+resultFailCnt+"건";
			resultMap.put("result", resultMsg);
			resultMap.put("work_no", work_no);
		}else{									//업로드 할 파일이 없는 경우
			resultMap.put("result", "empty");
		}		
		
		return resultMap;		
	}
	
	/**
	 * 입금일 파일업로드 모달창
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "incomeFileModal")
	public String incomeFileModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= incomeFileModal =======");
		
		return "top_rpt_inv/rpt_inv_income_file_modal";
	}
	
	/**
	 * 입금일자 일괄처리 모달
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "incomeUpdateModal")
	public String incomeUpdateModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= incomeUpdateModal =======");
						
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String [] sInvNo = request.getParameterValues("invList");			//인보이스 키값
		
		List<Map<String, Object>> invDetailList = new ArrayList<Map<String,Object>>();
		Map<String, Object> invMap;
		
		for(int i=0; i < sInvNo.length; i++) {
			paramMap.put("invoice_no", sInvNo[i]);
			invMap = sqlSession.selectOne("RptInvListMapper.getInvInfoDetail", paramMap);
			invDetailList.add(invMap);
		}
		
		model.addAttribute("invDetailList", invDetailList);
		
		return "top_rpt_inv/rpt_inv_income_update_modal";
	}
	
	/**
	 * 계산서 No 일괄등록 모달
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "publishNoUpdateModal")
	public String publishNoUpdateModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= publishNoUpdateModal =======");
						
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String [] sInvNo = request.getParameterValues("invList");			//인보이스 키값
		
		List<Map<String, Object>> invDetailList = new ArrayList<Map<String,Object>>();
		Map<String, Object> invMap;
		
		for(int i=0; i < sInvNo.length; i++) {
			paramMap.put("invoice_no", sInvNo[i]);
			invMap = sqlSession.selectOne("RptInvListMapper.getInvInfoDetail", paramMap);
			invDetailList.add(invMap);
		}
		
		model.addAttribute("invDetailList", invDetailList);

		return "top_rpt_inv/rpt_inv_publish_no_update_modal";
	}
	
	/**
	 * 계산서 일괄처리 모달
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "publishUpdateModal")
	public String publishUpdateModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= publishUpdateModal =======");
						
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String [] sInvNo = request.getParameterValues("invList");			//인보이스 키값
		
		List<Map<String, Object>> invDetailList = new ArrayList<Map<String,Object>>();
		Map<String, Object> invMap;
		
		for(int i=0; i < sInvNo.length; i++) {
			paramMap.put("invoice_no", sInvNo[i]);
			invMap = sqlSession.selectOne("RptInvListMapper.getInvInfoDetail", paramMap);
			invDetailList.add(invMap);
		}
		
		model.addAttribute("invDetailList", invDetailList);
		
		return "top_rpt_inv/rpt_inv_publish_update_modal";
	}
	
	/**
	 * 입금일자 정보 갱신
	 * @param request
	 * @param model
	 * @return
	 */	
	@RequestMapping(value="/updateIncomeDate")
    @ResponseBody
    public Map<String,Object> updateIncomeDate(HttpServletRequest request, Model model) {
		
		logger.info("======== updateIncomeDate ========");
		
		//결과값
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		int resultInsertCnt = 0;		//추가수
		int resultUpdateCnt = 0;		//갱신수
		int resultFailCnt = 0;			//기존입력값이 있어서 제외된 수
		String sMsg = "";					//결과 메시지
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String income_date = paramMap.get("income_date").toString();
    	
    	String [] sSuimNo = request.getParameterValues("suim_rpt_no[]");			//top_rpt_invoice_tax 테이블 조회를 위한 suim_rpt_no
    	
    	//세금계산서 테이블 사전체크 변수
    	int nCnt = 0;
    	int nCnt_sub = 0;
    	int nEnd_chk = 0;
    	String suim_rpt_no = "";
    	//인보이스 합계금액
    	int nTotal_amt = 0;
    	
    	//입금일자가 있는 경우만 처리한다.
    	if( !"".equals(income_date) ) {
    		paramMap.put("income_date", income_date);    		
    		for( int i=0; i < sSuimNo.length; i++ ) {
    			//paramMap.put("suim_rpt_no", sSuimNo[i]);    			
    			//기존 등록 데이터가 있는지 확인필요
    			suim_rpt_no = sSuimNo[i];    			
    			paramMap.put("suim_rpt_no", suim_rpt_no);
    			
    			//입금일자
				paramMap.put("deposit_date", income_date);
				
    			//세금계산서 테이블에 기존에 등록된 값을 체크한다.    			
    			nCnt = sqlSession.selectOne("InvoiceDtlMapper.getInvTaxCnt", suim_rpt_no);
    			
    			//인보이스 합계금액을 가져온다.
    			nTotal_amt = sqlSession.selectOne("InvoiceDtlMapper.getInvTotalAmt", suim_rpt_no);
    			
    			//입금액 신규추가
				paramMap.put("deposit_amount", nTotal_amt);
    			
    			//System.out.println("suim_rpt_no : "+ sSuimNo[i]+" : "+nCnt);
    			
    			//신규 세금계산서 테이블 정보 입력
    			if( nCnt == 0 ) {    				
    				//System.out.println("Insert");    				
    				//세금계산서 발행금액은 초기금액으로 입력
    				paramMap.put("publish_amount", 0);
    				sqlSession.insert("InvoiceDtlMapper.insertInvTax", paramMap);
    				resultInsertCnt++;		//추가한 수를 증가시킨다.    				
    			}else {    				
    				//기존 입금일자 등록값이 있는지 확인한다.
    				nCnt_sub = sqlSession.selectOne("InvoiceDtlMapper.getInvTaxDepositCnt", suim_rpt_no);
    				if( nCnt_sub == 0 ){		//기존등록일자와 금액이 없는 경우만 update 한다.
    					sqlSession.update("InvoiceDtlMapper.updateInvTaxDeposit", paramMap);
    					resultUpdateCnt++;		//갱신한 수를 증가시킨다.
    				}else{
    					resultFailCnt++;			//기존값이 있어서 skip 한 건수를 증가시킨다.
    				}
    			}
    			
    			//인보이스 입금일자가 기존에 없는 경우 갱신
    			sqlSession.update("InvoiceDtlMapper.updateInvDepositDate", paramMap);
    			
    			//인보이스의 세금계산서, 입금액 합을 비교하여 동일하면 작업완료로 표시한다.
    			nEnd_chk = sqlSession.selectOne("InvoiceDtlMapper.chkInvTaxAmountSum", suim_rpt_no);    			    			
    			
    			//nEnd_chk : 1 (동일), 0 (합계값이 다름)
    			paramMap.put("tax_edit_end", nEnd_chk);
    			sqlSession.update("InvoiceDtlMapper.updateTaxWork", paramMap);
    			
    			//세금계산서 No를 인보이스킷값으로 갱신한다.    			
    			sqlSession.update("InvoiceDtlMapper.updateInvInvoiceNoAutoSuimNo", suim_rpt_no);
    			
    		}
    		sMsg = "입금일자 일괄처리 결과\n";
    		sMsg += "추가 건수 : "+resultInsertCnt+" 건\n";
    		sMsg += "갱신 건수 : "+resultUpdateCnt+" 건\n";
    		sMsg += "기 입력 건수 : "+resultFailCnt+" 건\n";    		
    	}
    	
    	resultMap.put("msg", sMsg);
    		
    	return resultMap;
    }
	
	/**
	 * 세금계산서 No 일괄등록
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/updatePublishNo")
    @ResponseBody
    public Map<String,Object> updatePublishNo(HttpServletRequest request, Model model) {
		
		logger.info("======== updatePublishNo ========");
		
		//결과값
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		int resultInsertCnt = 0;		//추가수		
		int resultFailCnt = 0;			//기존입력값이 있어서 제외된 수
		String sMsg = "";					//결과 메시지
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String tax_invoice_no = paramMap.get("tax_invoice_no").toString();
    	
    	String [] sSuimNo = request.getParameterValues("suim_rpt_no[]");			//top_rpt_invoice_tax 테이블 조회를 위한 suim_rpt_no
    	
    	String suim_rpt_no = "";
    	
    	String temp_tax_invoice_no = "";			//기존 세금계산서 No 임시 변수
    	
    	//세금계산서 No 가 있는 경우만 처리한다.
    	if( !"".equals(tax_invoice_no) ) {
    		paramMap.put("tax_invoice_no", tax_invoice_no);    		
    		for( int i=0; i < sSuimNo.length; i++ ) {   			
    			//기존 등록 데이터가 있는지 확인필요
    			suim_rpt_no = sSuimNo[i];    			
    			paramMap.put("suim_rpt_no", suim_rpt_no);    			
    			
    			temp_tax_invoice_no = sqlSession.selectOne("InvoiceDtlMapper.getInoviceTaxNo",suim_rpt_no);
    			
    			if( "".equals(temp_tax_invoice_no) ) {		//값이 없는 경우만 갱신한다.
    				sqlSession.update("InvoiceDtlMapper.updateTaxInvoiceNoBySuimRptNo", paramMap);    				
    				resultInsertCnt++;
    			}else{
    				resultFailCnt++;
    			}    			
    			
    		}
    		sMsg = "세금계산서 No 일괄등록 결과\n";
    		sMsg += "추가 건수 : "+resultInsertCnt+" 건\n";    		
    		sMsg += "기 입력 건수 : "+resultFailCnt+" 건\n";    		
    	}
    	
    	resultMap.put("msg", sMsg);
    		
    	return resultMap;
    }
	
	/**
	 * 세금계산서 일자 정보생신
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/updatePublishDate")
    @ResponseBody
    public Map<String,Object> updatePublishDate(HttpServletRequest request, Model model) {
		
		logger.info("======== updatePublishDate ========");
		
		//결과값
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		int resultInsertCnt = 0;		//추가수
		int resultUpdateCnt = 0;		//갱신수
		int resultFailCnt = 0;			//기존입력값이 있어서 제외된 수
		String sMsg = "";					//결과 메시지
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String publish_date = paramMap.get("publish_date").toString();
    	
    	String [] sSuimNo = request.getParameterValues("suim_rpt_no[]");			//top_rpt_invoice_tax 테이블 조회를 위한 suim_rpt_no
    	
    	//세금계산서 테이블 사전체크 변수
    	int nCnt = 0;
    	int nCnt_sub = 0;
    	int nEnd_chk = 0;
    	String suim_rpt_no = "";
    	//인보이스 합계금액
    	int nTotal_amt = 0;
    	
    	//입금일자가 있는 경우만 처리한다.
    	if( !"".equals(publish_date) ) {
    		paramMap.put("publish_date", publish_date);    		
    		for( int i=0; i < sSuimNo.length; i++ ) {
    			//paramMap.put("suim_rpt_no", sSuimNo[i]);    			
    			//기존 등록 데이터가 있는지 확인필요
    			suim_rpt_no = sSuimNo[i];    			
    			paramMap.put("suim_rpt_no", suim_rpt_no);
    			
    			//세금계산서 등록일자
				paramMap.put("publish_date", publish_date);
				
    			//세금계산서 테이블에 기존에 등록된 값을 체크한다.    			
    			nCnt = sqlSession.selectOne("InvoiceDtlMapper.getInvTaxCnt", suim_rpt_no);
    			
    			//인보이스 합계금액을 가져온다.
    			nTotal_amt = sqlSession.selectOne("InvoiceDtlMapper.getInvTotalAmt", suim_rpt_no);
    			
    			//세금계산서 확인금액 신규추가
				paramMap.put("publish_amount", nTotal_amt);    			
    			
    			//신규 세금계산서 테이블 정보 입력
    			if( nCnt == 0 ) {
    				//입금금액은 초기금액으로 입력
    				paramMap.put("deposit_amount", 0);
    				sqlSession.insert("InvoiceDtlMapper.insertInvTax", paramMap);
    				resultInsertCnt++;		//추가한 수를 증가시킨다.    				
    			}else {    				
    				//기존 입금일자 등록값이 있는지 확인한다.
    				nCnt_sub = sqlSession.selectOne("InvoiceDtlMapper.getInvTaxPublishCnt", suim_rpt_no);
    				if( nCnt_sub == 0 ){		//기존 세금계산서 일자와 금액이 없는 경우만 update 한다.
    					sqlSession.update("InvoiceDtlMapper.updateInvTaxPublish", paramMap);
    					resultUpdateCnt++;		//갱신한 수를 증가시킨다.
    				}else{
    					resultFailCnt++;			//기존값이 있어서 skip 한 건수를 증가시킨다.
    				}
    			}
    			
    			//인보이스 세금계산서 재발급일이 기존에 없는 경우 갱신
    			sqlSession.update("InvoiceDtlMapper.updateInvPublishDate", paramMap);    			
    			
    			//인보이스의 세금계산서, 입금액 합을 비교하여 동일하면 작업완료로 표시한다.
    			nEnd_chk = sqlSession.selectOne("InvoiceDtlMapper.chkInvTaxAmountSum", suim_rpt_no);    			    			
    			
    			//nEnd_chk : 1 (동일), 0 (합계값이 다름)
    			paramMap.put("tax_edit_end", nEnd_chk);
    			sqlSession.update("InvoiceDtlMapper.updateTaxWork", paramMap);
    			
    			//세금계산서 No를 인보이스킷값으로 갱신한다.    			
    			sqlSession.update("InvoiceDtlMapper.updateInvInvoiceNoAutoSuimNo", suim_rpt_no);
    			
    		}
    		sMsg = "세금계산서 일괄처리 결과\n";
    		sMsg += "추가 건수 : "+resultInsertCnt+" 건\n";
    		sMsg += "갱신 건수 : "+resultUpdateCnt+" 건\n";
    		sMsg += "기 입력 건수 : "+resultFailCnt+" 건\n";    		
    	}
    	
    	resultMap.put("msg", sMsg);
    		
    	return resultMap;
    }

	@RequestMapping(value = "rptInvSearch", method = RequestMethod.GET)
	public String rptInvSearch(Model model, HttpSession session, TopRptInvListSearchVO searchVO, String reqPgNo, String pagesize_val) {

		logger.info("======= rptInvSearch =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_7().equals("0") ){
			logger.info("rptInvList - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		String work_user_no = mbrVo.getUser_no();		
		searchVO.setWorkUserNo(work_user_no);		

		/* 팀목록 추출*/
		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
		model.addAttribute("teamList", teamList);
		/* 파트너목록 추출*/
		List<TopPtnrBscVO> ptnrList = sqlSession.selectList("RptInvListMapper.ptnrListForSearch");
		model.addAttribute("ptnrList", ptnrList);
		/* suim_rpt_type1 추출*/
		List<SysAdmCodeDicVO> type1List = sqlSession.selectList("RptInvListMapper.suimRptType1ForSearch");
		model.addAttribute("type1List", type1List);
/*
		System.out.println("reqPgNo           : "+reqPgNo);
		System.out.println("tmSearch          : "+searchVO.getTmSearch());
		System.out.println("tmGubun           : "+searchVO.getTmGubun());
		System.out.println("ptnrSearch        : "+searchVO.getPtnrSearch());
		System.out.println("ptnrGubun         : "+searchVO.getPtnrGubun());
		System.out.println("type1Search       : "+searchVO.getType1Search());
		System.out.println("speedCheck        : "+searchVO.getSpeedCheck());
		System.out.println("invoice_date_From : "+searchVO.getInvoice_date_From());
		System.out.println("invoice_date_To   : "+searchVO.getInvoice_date_To());
		System.out.println("invDateEditCheck  : "+searchVO.getInvDateEditCheck());
		System.out.println("userNmSearch      : "+searchVO.getUserNmSearch());
		System.out.println("ptnrUserNmSearch  : "+searchVO.getPtnrUserNmSearch());
		System.out.println("orderBy           : "+searchVO.getOrderBy());
		System.out.println("close_date_From   : "+searchVO.getClose_date_From());
		System.out.println("close_date_To     : "+searchVO.getClose_date_To());
		System.out.println("benefiNmSearch    : "+searchVO.getBenefiNmSearch());
		System.out.println("policyhNmSearch   : "+searchVO.getPolicyhNmSearch());
		System.out.println("acceptNoSearch    : "+searchVO.getAcceptNoSearch());
		System.out.println("deposit_date_From : "+searchVO.getDeposit_date_From());
		System.out.println("deposit_date_To   : "+searchVO.getDeposit_date_To());
		System.out.println("totAmtF           : "+searchVO.getTotAmtF());
		System.out.println("totAmtT           : "+searchVO.getTotAmtT());
		System.out.println("depositNoCheck    : "+searchVO.getDepositNoCheck());
		System.out.println("amtEditCheck      : "+searchVO.getAmtEditCheck());
		System.out.println("taxNoSearch       : "+searchVO.getTaxNoSearch());
		System.out.println("taxNoCheck        : "+searchVO.getTaxNoCheck());
		System.out.println("tax_date_From     : "+searchVO.getTax_date_From());
		System.out.println("tax_date_To       : "+searchVO.getTax_date_To());
*/		

		if(			(searchVO.getTmSearch() == null || searchVO.getTmSearch().equals("0"))
				&& (searchVO.getPtnrSearch() == null || searchVO.getPtnrSearch().equals("0"))
				&& (searchVO.getType1Search() == null || searchVO.getType1Search().equals("0"))

				&& (searchVO.getSpeedCheck() == null || searchVO.getSpeedCheck().equals(""))
				&& (searchVO.getInvDateEditCheck() == null || searchVO.getInvDateEditCheck().equals(""))
				&& (searchVO.getDepositNoCheck() == null || searchVO.getDepositNoCheck().equals(""))
				&& (searchVO.getAmtEditCheck() == null || searchVO.getAmtEditCheck().equals(""))
				&& (searchVO.getTaxNoCheck() == null || searchVO.getTaxNoCheck().equals(""))

				&& (searchVO.getPtnrUserNmSearch() == null || searchVO.getPtnrUserNmSearch().equals(""))
				&& (searchVO.getUserNmSearch() == null || searchVO.getUserNmSearch().equals(""))
				&& (searchVO.getBenefiNmSearch() == null || searchVO.getBenefiNmSearch().equals(""))
				&& (searchVO.getPolicyhNmSearch() == null || searchVO.getPolicyhNmSearch().equals(""))
				&& (searchVO.getAcceptNoSearch() == null || searchVO.getAcceptNoSearch().equals(""))
				&& (searchVO.getTotAmtF() == null || searchVO.getTotAmtF().equals(""))
				&& (searchVO.getTotAmtT() == null || searchVO.getTotAmtT().equals(""))
				&& (searchVO.getTaxNoSearch() == null || searchVO.getTaxNoSearch().equals(""))

				&& (searchVO.getInvoice_date_From() == null || searchVO.getInvoice_date_From().equals(""))
				&& (searchVO.getInvoice_date_To() == null || searchVO.getInvoice_date_To().equals(""))
				&& (searchVO.getClose_date_From() == null || searchVO.getClose_date_From().equals(""))
				&& (searchVO.getClose_date_To() == null || searchVO.getClose_date_To().equals(""))
				&& (searchVO.getDeposit_date_From() == null || searchVO.getDeposit_date_From().equals(""))
				&& (searchVO.getDeposit_date_To() == null || searchVO.getDeposit_date_To().equals(""))
				&& (searchVO.getTax_date_From() == null || searchVO.getTax_date_From().equals(""))
				&& (searchVO.getTax_date_To() == null || searchVO.getTax_date_To().equals(""))				
				&& (searchVO.getAccidentNoSearch() == null || searchVO.getAccidentNoSearch().equals(""))				
				&& (searchVO.getQueryPgSizeInt() == 18)
		){
			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate");
			searchVO.setClose_date_From(nowVO.getYear_from());
			searchVO.setClose_date_To(nowVO.getYear_to());
		}
		
		//접수 번호 '-' 처리 (재경팀 요청사항) 시작 20230609
		String sSuimAcceptNo = String.valueOf(searchVO.getAcceptNoSearch());		
				
		if( !sSuimAcceptNo.contains("-") ) {		//검색 할 접수번호에 - 가 없으면 처리한다.
			int nLen = 0;
			nLen = sSuimAcceptNo.length();
			if( nLen == 10) {
				StringBuffer sb = new StringBuffer();
				sb.append(sSuimAcceptNo);
				sb.insert(6, "-");
				sSuimAcceptNo = sb.toString();
				searchVO.setAcceptNoSearch(sSuimAcceptNo);
			}
		}		
		//접수 번호 '-' 처리 (재경팀 요청사항) 끝 20230609

		PageUtilityBasic pageUtil = new PageUtilityBasic();
		TopRptInvListViewVO totVO = sqlSession.selectOne("RptInvListMapper.getInvListCnt", searchVO);//총 조회 건수
		int totCntInt = totVO.getTotCntInt();		
		//int queryPgNoInt = pageUtil.pageBasic2(1, totCntInt, reqPgNo, model, "rptInvSearch");
		
		//페이지 사이즈 (페이지에서 request 로 받는 방식으로 수정필요)		
		int pgSize = 18;
		
		if( searchVO.getQueryPgSizeInt() != 0 ) {
			pgSize = searchVO.getQueryPgSizeInt();
		}
		
		if( pagesize_val != null ) {
			pgSize = Integer.parseInt(pagesize_val);
		}	
		
		int queryPgNoInt = pageUtil.pageBasic3(1, totCntInt, reqPgNo, model, "rptInvSearch", pgSize);
		
		searchVO.setQueryPgNoInt(queryPgNoInt);
		searchVO.setQueryPgSizeInt(pgSize);
		
		List<TopRptInvListViewVO> invList = sqlSession.selectList("RptInvListMapper.getInvList", searchVO);
		
		//인보이스 금액 수정액 표기 기능 추가 시작 by top3009 (20211123)
		if("on".equals(searchVO.getAmtEditCheck())) {		
			int nEditAmt = 0;
			double dModify_amout = 0;		
			for( int i = 0; i < invList.size(); i++) {
				nEditAmt = Integer.parseInt(invList.get(i).getEdit_amt_cnt());
				if( nEditAmt > 0 ) {									
					dModify_amout = sqlSession.selectOne("RptInvListMapper.getAmtTotalDefVal", invList.get(i).getRpt_invoice_no());
					invList.get(i).setModify_amout(dModify_amout);
				}
			}		
		}
		//인보이스 금액 수정액 표기 기능 추가 끝
		
		double totAmtNotDeposit = sqlSession.selectOne("RptInvListMapper.getAmtNotDeposit", searchVO);//총 조회 건수		
		
		model.addAttribute("pgSize", pgSize);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("invList", invList);
		model.addAttribute("totVO", totVO);
		model.addAttribute("totCntInt", totCntInt);
		model.addAttribute("totAmtNotDeposit", totAmtNotDeposit);

		return "top_rpt_inv/rpt_inv_list";
	}//rptInvSearch

	@RequestMapping(value = "rptInvListExcel", method = RequestMethod.GET)
	public String rptInvListExcel(Model model, HttpSession session, TopRptInvListSearchVO searchVO, String reqPgNo) {

		logger.info("======= rptInvListExcel =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_7().equals("0") ){
			logger.info("rptInvListExcel - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		/* 팀목록 추출*/
		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
		model.addAttribute("teamList", teamList);
		/* 파트너목록 추출*/
		List<TopPtnrBscVO> ptnrList = sqlSession.selectList("RptInvListMapper.ptnrListForSearch");
		model.addAttribute("ptnrList", ptnrList);
		/* suim_rpt_type1 추출*/
		List<SysAdmCodeDicVO> type1List = sqlSession.selectList("RptInvListMapper.suimRptType1ForSearch");
		model.addAttribute("type1List", type1List);

		if(			(searchVO.getTmSearch() == null || searchVO.getTmSearch().equals("0"))
				&& (searchVO.getPtnrSearch() == null || searchVO.getPtnrSearch().equals("0"))
				&& (searchVO.getType1Search() == null || searchVO.getType1Search().equals("0"))

				&& (searchVO.getSpeedCheck() == null || searchVO.getSpeedCheck().equals(""))
				&& (searchVO.getInvDateEditCheck() == null || searchVO.getInvDateEditCheck().equals(""))
				&& (searchVO.getDepositNoCheck() == null || searchVO.getDepositNoCheck().equals(""))
				&& (searchVO.getAmtEditCheck() == null || searchVO.getAmtEditCheck().equals(""))
				&& (searchVO.getTaxNoCheck() == null || searchVO.getTaxNoCheck().equals(""))

				&& (searchVO.getPtnrUserNmSearch() == null || searchVO.getPtnrUserNmSearch().equals(""))
				&& (searchVO.getUserNmSearch() == null || searchVO.getUserNmSearch().equals(""))
				&& (searchVO.getBenefiNmSearch() == null || searchVO.getBenefiNmSearch().equals(""))
				&& (searchVO.getPolicyhNmSearch() == null || searchVO.getPolicyhNmSearch().equals(""))
				&& (searchVO.getAcceptNoSearch() == null || searchVO.getAcceptNoSearch().equals(""))
				&& (searchVO.getTotAmtF() == null || searchVO.getTotAmtF().equals(""))
				&& (searchVO.getTotAmtT() == null || searchVO.getTotAmtT().equals(""))
				&& (searchVO.getTaxNoSearch() == null || searchVO.getTaxNoSearch().equals(""))

				&& (searchVO.getInvoice_date_From() == null || searchVO.getInvoice_date_From().equals(""))
				&& (searchVO.getInvoice_date_To() == null || searchVO.getInvoice_date_To().equals(""))
				&& (searchVO.getClose_date_From() == null || searchVO.getClose_date_From().equals(""))
				&& (searchVO.getClose_date_To() == null || searchVO.getClose_date_To().equals(""))
				&& (searchVO.getDeposit_date_From() == null || searchVO.getDeposit_date_From().equals(""))
				&& (searchVO.getDeposit_date_To() == null || searchVO.getDeposit_date_To().equals(""))
				&& (searchVO.getTax_date_From() == null || searchVO.getTax_date_From().equals(""))
				&& (searchVO.getTax_date_To() == null || searchVO.getTax_date_To().equals(""))
				&& (searchVO.getAccidentNoSearch() == null || searchVO.getAccidentNoSearch().equals(""))
		){
			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate");
			searchVO.setClose_date_From(nowVO.getYear_from());
			searchVO.setClose_date_To(nowVO.getYear_to());
		}

		TopRptInvListViewVO totVO = sqlSession.selectOne("RptInvListMapper.getInvListCnt", searchVO);//총 조회 건수

		List<TopRptInvListViewVO> invList = sqlSession.selectList("RptInvListMapper.getInvListExcel", searchVO);
		
		//인보이스 금액 수정액 표기 기능 추가 시작 by top3009 (20211123)
		if("on".equals(searchVO.getAmtEditCheck())) {		
			int nEditAmt = 0;
			double dModify_amout = 0;		
			for( int i = 0; i < invList.size(); i++) {
				nEditAmt = Integer.parseInt(invList.get(i).getEdit_amt_cnt());
				if( nEditAmt > 0 ) {									
					dModify_amout = sqlSession.selectOne("RptInvListMapper.getAmtTotalDefVal", invList.get(i).getRpt_invoice_no());
					invList.get(i).setModify_amout(dModify_amout);
				}
			}		
		}
		//인보이스 금액 수정액 표기 기능 추가 끝

		double totAmtNotDeposit = sqlSession.selectOne("RptInvListMapper.getAmtNotDeposit", searchVO);//총 조회 건수

		model.addAttribute("searchVO", searchVO);
		model.addAttribute("invList", invList);
		model.addAttribute("totVO", totVO);
		model.addAttribute("totAmtNotDeposit", totAmtNotDeposit);

		return "top_rpt_inv/rpt_inv_list_excel";
	}//rptInvListExcel

}//end of class
