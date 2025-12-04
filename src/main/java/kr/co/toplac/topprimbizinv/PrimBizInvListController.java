package kr.co.toplac.topprimbizinv;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
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
import kr.co.toplac.toprptinv.TopRptInvTaxBean;
import kr.co.toplac.topstatistics.StatisticsNowVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;
import kr.co.toplac.util.page.PageUtilityBasic;

@Controller
public class PrimBizInvListController {

	private static final Logger logger = LoggerFactory.getLogger(PrimBizInvListController.class);
	
	/**
	 * 세금계산서 작업상태 업데이트
	 * @param request
	 * @param model
	 * @return
	 */	
	@RequestMapping(value="/invPrimTaxUpdateWork")
    @ResponseBody
    public int invTaxUpdateWork(HttpServletRequest request, Model model) {
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	int upCnt = sqlSession.update("primBizInvListMapper.updatePrimTaxWork", paramMap);
    	
    	logger.info("======== invPrimTaxUpdateWork ("+upCnt+") ========");
    	
    	return upCnt;
    }

	@Autowired
	private SqlSession sqlSession;
	
	/**
	 * 세금계산서 정보 업데이트 컨트롤러
	 * @param request
	 * @param model
	 * @return
	 */	
	@RequestMapping(value="/invPrimTaxUpdate")
    @ResponseBody
    public int invPrimTaxUpdate(HttpServletRequest request, Model model) {
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	int udtCnt = 0;
    	
    	String [] sTemp = request.getParameterValues("taxList");			//총괄표에서 넘어온 배열
    	String [] splTemp = null;					//배열처리 임시변수
    	
    	String sSuim_rpt_no = request.getParameter("suim_rpt_no").toString();								//보고서번호
    	
    	String sPublish_date = "";						//발행일자
    	String sPublish_amount = "";				//발행금액
    	String sDeposit_date = "";					//입금일자 
    	String sDeposit_amount = "";				//입금액
    	
		//추가하기전에 삭제 한다.    	
    	sqlSession.delete("primBizInvListMapper.deleteInvPrimTax", sSuim_rpt_no);    	
		
		for(int i=0; i < sTemp.length; i++) {
			
			splTemp = sTemp[i].split("\\|");			
			sPublish_date = splTemp[0];
			sPublish_amount = splTemp[1];
			sDeposit_date = splTemp[2];
			sDeposit_amount = splTemp[3];
			
			paramMap.put("suim_rpt_no", sSuim_rpt_no);
			paramMap.put("publish_date", sPublish_date);
			paramMap.put("publish_amount", StringUtil.removeComma(sPublish_amount));
			paramMap.put("deposit_date", sDeposit_date);
			paramMap.put("deposit_amount", StringUtil.removeComma(sDeposit_amount));
			
			sqlSession.insert("primBizInvListMapper.insertInvPrimTax", paramMap);						
		}
		
		udtCnt = sTemp.length; 
    	
    	logger.info("======== invPrimTaxUpdate ("+udtCnt+") ========");
    	
    	return udtCnt;
    }
	
	/**
	 * 세금계산서 삭제 컨트롤러
	 * @param request
	 * @param model
	 * @return
	 */	
	@RequestMapping(value="/invPrimTaxDelete")
    @ResponseBody
    public int invTaxDelete(HttpServletRequest request, Model model) {
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	int delCnt = sqlSession.delete("primBizInvListMapper.deleteInvPrimTaxNo", paramMap);
    	
    	logger.info("======== invPrimTaxDelete ("+delCnt+") ========");
    	
    	return delCnt;
    }
	
	@RequestMapping(value = "/ajax/ajax_prim_biz_tax_dtl")			//농작물 세금계산서 상세페이지 값가져오기
    public String reportIssueSamsungJemul(HttpServletRequest request, Model model){		    	

    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String cont_edit_type = request.getParameter("cont_edit_type") != null ? request.getParameter("cont_edit_type") : "view";
    	
    	String suim_rpt_no = paramMap.get("suimRptNo").toString();
    	
    	int rptAmtTotal = Integer.parseInt(paramMap.get("rptAmtTotal").toString());
    	
    	String tax_edit_end = paramMap.get("tax_edit_end").toString();
    	
    	//List<TopRptInvTaxBean> taxList = sqlSession.selectList("InvoiceDtlMapper.getInvTaxList", suim_rpt_no);    	
    	
    	//작업중..    	
    	List<TopRptInvTaxBean> taxList = sqlSession.selectList("primBizInvListMapper.getPrimTaxList", suim_rpt_no);
    	
    	//계산서 합계
    	int nSum_tax = 0;    	
    	
    	//일치여부 (O,X)
    	String sChk_tax = "X";
    	
    	//입금합계
    	int nSum_deposit = 0;
    	
    	//계산서, 입금 합계금액 계산
    	for( int i = 0; i < taxList.size(); i++) {
    		nSum_tax += Integer.parseInt(taxList.get(i).getPublish_amount());
    		nSum_deposit += Integer.parseInt(taxList.get(i).getDeposit_amount());
    	}
    	
    	//System.out.println("rptAmtTotal="+rptAmtTotal);
    	//System.out.println("nSum_tax="+nSum_tax);
    	//System.out.println("nSum_deposit="+nSum_deposit);
    	
    	if( nSum_tax == rptAmtTotal ) {
    		sChk_tax = "O";
    	}
    	
    	//미수잔액
    	int nSum_outpay = 0;
    	
    	nSum_outpay = nSum_tax - nSum_deposit; 
    	
    	model.addAttribute("sum_tax", nSum_tax);
    	model.addAttribute("chk_tax", sChk_tax);
    	model.addAttribute("sum_deposit", nSum_deposit);
    	model.addAttribute("sum_outpay", nSum_outpay);
    	   	
    	model.addAttribute("tax_edit_end", tax_edit_end);
    	model.addAttribute("suim_rpt_no", suim_rpt_no);
    	model.addAttribute("cont_edit_type", cont_edit_type);
    	model.addAttribute("taxList", taxList);
    	
    	String sUrl = "top_prim_biz_inv/ajax/ajax_prim_biz_tax_dtl";
    	
    	return sUrl;
    }

	/**
	 * 농작물 세금계산서 작성 팝업창
	 * @param model
	 * @param session
	 * @param no
	 * @return
	 */	
	@RequestMapping(value = "primTaxDtl", method = RequestMethod.GET)
	public String primTaxDtl(Model model, HttpSession session, String no) {

		logger.info("======= primTaxDtl =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_8().equals("0") ){
			logger.info("rptInvDtl - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}		
		
		TopPrimBizInvListViewVO invoiceDtl = sqlSession.selectOne("primBizInvListMapper.getPrimDtl", no);
		model.addAttribute("invoiceDtl", invoiceDtl);
		
		String suim_rpt_no = invoiceDtl.getSuim_rpt_no();
		
		int nTaxListCnt = sqlSession.selectOne("primBizInvListMapper.getPrimTaxCnt", suim_rpt_no);
		
		//창을 호출 할때는 view 모드로 호출한다.
		model.addAttribute("cont_edit_type", "view");
		model.addAttribute("taxListCnt", nTaxListCnt);
		
		return "top_prim_biz_inv/prim_biz_tax_dtl";
	}//rptInvDt
	
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
	@RequestMapping(value = "primBizInvList", method = RequestMethod.GET)
	public String primBizInvList(Model model, HttpSession session) {

		logger.info("======= primBizInvList =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_7().equals("0") ){
			logger.info("primBizInvList - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		/* 팀목록 추출*/
		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
		model.addAttribute("teamList", teamList);
		/* 파트너목록 추출*/
		List<TopPtnrBscVO> ptnrList = sqlSession.selectList("primBizInvListMapper.ptnrListForSearch");
		model.addAttribute("ptnrList", ptnrList);
		/*suim_rpt_type1 추출*/
		List<SysAdmCodeDicVO> type1List = sqlSession.selectList("primBizInvListMapper.suimRptType1ForSearch");
		model.addAttribute("type1List", type1List);

		return "top_prim_biz_inv/prim_biz_inv_list";
	}//primBizInvList

	@RequestMapping(value = "primBizInvSearch", method = RequestMethod.GET)
	public String primBizInvSearch(Model model, HttpSession session, TopPrimBizInvListSearchVO searchVO, String reqPgNo, String pagesize_val) {

		logger.info("======= primBizInvSearch =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_7().equals("0") ){
			logger.info("primBizInvSearch - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		/* 팀목록 추출*/
		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
		model.addAttribute("teamList", teamList);
		/* 파트너목록 추출*/
		List<TopPtnrBscVO> ptnrList = sqlSession.selectList("primBizInvListMapper.ptnrListForSearch");
		model.addAttribute("ptnrList", ptnrList);
		/* suim_rpt_type1 추출*/
		List<SysAdmCodeDicVO> type1List = sqlSession.selectList("primBizInvListMapper.suimRptType1ForSearch");
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
		//검색어 없이 검색 시 DB부하 문제가 있어 종결일 기준 1년으로 조건 추가
		if((searchVO.getTmSearch() == null || searchVO.getTmSearch().equals("0"))
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
		TopPrimBizInvListViewVO totVO = sqlSession.selectOne("primBizInvListMapper.getInvListCnt", searchVO);//총 조회 건수
		int totCntInt = totVO.getTotCntInt();
		//int queryPgNoInt = pageUtil.pageBasic2(1, totCntInt, reqPgNo, model, "primBizInvSearch");
		
		//페이지 사이즈 (페이지에서 request 로 받는 방식으로 수정필요)		
		int pgSize = 18;		

		if( searchVO.getQueryPgSizeInt() != 0 ) {
			pgSize = searchVO.getQueryPgSizeInt();
		}
		
		if( pagesize_val != null ) {
			pgSize = Integer.parseInt(pagesize_val);
		}				

		int queryPgNoInt = pageUtil.pageBasic3(1, totCntInt, reqPgNo, model, "primBizInvSearch", pgSize);

		searchVO.setQueryPgNoInt(queryPgNoInt);
		searchVO.setQueryPgSizeInt(pgSize);		

		List<TopPrimBizInvListViewVO> invList = sqlSession.selectList("primBizInvListMapper.getInvList", searchVO);

		int totAmtNotDeposit = sqlSession.selectOne("primBizInvListMapper.getAmtNotDeposit", searchVO);
		
		model.addAttribute("pgSize", pgSize);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("invList", invList);
		model.addAttribute("totVO", totVO);
		model.addAttribute("totCntInt", totCntInt);
		model.addAttribute("totAmtNotDeposit", totAmtNotDeposit);

		return "top_prim_biz_inv/prim_biz_inv_list";
	}//primBizInvSearch
	
	/**
	 * 농작물 입금일 파일업로드 모달창
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "incomeFilePrimBizModal")
	public String incomeFileModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= incomeFilePrimBizModal =======");
		
		return "top_prim_biz_inv/prim_biz_inv_income_file_modal";
	}
	
	/**
	 * 농작물 입금일자 등록하려는 파일 목록 조회
	 * @param model
	 * @param session
	 * @param response
	 * @param request
	 * @param incomeFile
	 * @return
	 */	
	@RequestMapping(value = "incomeFileListPrimBizView", method = RequestMethod.POST)	
	public String incomeFileListPrimBizView(Model model, HttpSession session,HttpServletResponse response, HttpServletRequest request, MultipartFile incomeFile) {
		
		logger.info("======= incomeFileListPrimBizView =======");
		
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
								nChk = sqlSession.selectOne("primBizInvListMapper.countTopRptHeadBySuimAcceptNo", sAcceptNo);
								
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

		return "top_prim_biz_inv/prim_biz_inv_income_file_prev_list";
	}
	
	/**
	 * 농작물 입금일 파일 업로드 처리
	 * @param model
	 * @param session
	 * @param response
	 * @param request
	 * @param multipartRequest
	 * @return
	 */
	@RequestMapping(value = "incomeFilePrimBizUpdate", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> incomeFilePrimBizUpdate(Model model, HttpSession session,HttpServletResponse response, HttpServletRequest request, MultipartFile incomeFile) {
		
		logger.info("======= incomeFilePrimBizUpdate =======");
		
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
								
								//농작물 수임건 직전 접수번호 가져오기
								sSuimRptNo = sqlSession.selectOne("SuimRegInsMapper.getSuimRptNoForNsc", sAcceptNo);
								
								//보고서 번호
								paramMap.put("suim_rpt_no", sSuimRptNo);
								//입금일자.
								paramMap.put("deposit_date", sInComeDate);
								
								//세금계산서 테이블에 기존에 등록된 값을 체크한다.
								nCnt = sqlSession.selectOne("primBizInvListMapper.getInvTaxCnt", sSuimRptNo);
								
								//농작물 인보이스 합계금액을 가져온다.
								nTotal_amt = sqlSession.selectOne("primBizInvListMapper.getInvTotalAmt", sSuimRptNo);
								
								//입금액 신규추가
								paramMap.put("deposit_amount", nTotal_amt);
								
								//신규 세금계산서 테이블 정보 입력
								if( nCnt == 0 ) {
									//세금계산서 발행금액은 초기금액으로 입력
									paramMap.put("publish_amount", 0);
									sqlSession.insert("primBizInvListMapper.insertInvTax", paramMap);
									resultInsertCnt++;		//추가한 수를 증가시킨다.
									sActionFlag = "I";
								}else {    				
									//기존 입금일자 등록값이 있는지 확인한다.
									nCnt_sub = sqlSession.selectOne("primBizInvListMapper.getInvTaxDepositCnt", sSuimRptNo);
									if( nCnt_sub == 0 ){		//기존등록일자와 금액이 없는 경우만 update 한다.
										sqlSession.update("primBizInvListMapper.updateInvTaxDeposit", paramMap);
										resultUpdateCnt++;		//갱신한 수를 증가시킨다.
										sActionFlag = "U";										
									}else{
										resultFailCnt++;			//기존값이 있어서 skip 한 건수를 증가시킨다.
										sActionFlag = "P";										
									}
								}
								
								//인보이스 입금일자가 기존에 없는 경우 갱신
								sqlSession.update("primBizInvListMapper.updateInvDepositDate", paramMap);

								//인보이스의 세금계산서, 입금액 합을 비교하여 동일하면 작업완료로 표시한다.
								nEnd_chk = sqlSession.selectOne("primBizInvListMapper.chkInvTaxAmountSum", sSuimRptNo);    			    			

								//nEnd_chk : 1 (동일), 0 (합계값이 다름)
								paramMap.put("tax_edit_end", nEnd_chk);
								sqlSession.update("primBizInvListMapper.updateTaxWork", paramMap);

								//세금계산서 No를 인보이스킷값으로 갱신한다.    			
								sqlSession.update("primBizInvListMapper.updateInvInvoiceNoAutoSuimNo", sSuimRptNo);									
								
								//로그 등록 시작
								//로그 등록을 위한 임시 Map									
								logMap = sqlSession.selectOne("primBizInvListMapper.selectInComeLogInfo", sSuimRptNo);
								
								logMap.put("work_no", work_no);
								logMap.put("work_user_no", work_user_no);
								
								if( "I".equals(sActionFlag) ) {
									logMap.put("action_flag", "추가");
								}else if( "U".equals(sActionFlag) ) {
									logMap.put("action_flag", "갱신");
								}else{
									logMap.put("action_flag", "통과");
								}								
								
								sqlSession.insert("primBizInvListMapper.insertInComePrimLogInfo", logMap);
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
	 * 농작물 입금일 파일등록 로그 조회
	 * @param model
	 * @param session
	 * @param response
	 * @param request
	 * @param incomeFile
	 * @return
	 */
	@RequestMapping(value = "incomeWorkLogPrimBizView", method = RequestMethod.POST)	
	public String incomeWorkLogPrimBizView(Model model, HttpSession session,HttpServletResponse response, HttpServletRequest request, MultipartFile incomeFile) {
		
		logger.info("======= incomeWorkLogPrimBizView =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		model.addAttribute("paramMap", paramMap);

		return "top_prim_biz_inv/prim_biz_inv_income_file_log_search";
	}
	
	/**
	 * 농작물 입금일 파일등록 로그 목록 조회
	 * @param model
	 * @param session
	 * @param response
	 * @param request
	 * @param incomeFile
	 * @return
	 */
	@RequestMapping(value = "incomeLogListPrimBizAjax", method = RequestMethod.POST)	
	public String incomeLogListPrimBizAjax(Model model, HttpSession session,HttpServletResponse response, HttpServletRequest request, MultipartFile incomeFile) {
		
		logger.info("======= incomeLogListPrimBizAjax =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);		
		
		List<Map<String, Object>> logSearchList = sqlSession.selectList("primBizInvListMapper.selectInComeLogSearchList", paramMap);
				
		model.addAttribute("logSearchList", logSearchList);		
		
		return "top_prim_biz_inv/prim_biz_inv_income_file_log_search_ajax";
	}

	@RequestMapping(value = "primBizInvListExcel", method = RequestMethod.GET)
	public String primBizInvListExcel(Model model, HttpSession session, TopPrimBizInvListSearchVO searchVO, String reqPgNo) {

		logger.info("======= primBizInvListExcel =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_7().equals("0") ){
			logger.info("primBizInvListExcel - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		/* 팀목록 추출*/
		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
		model.addAttribute("teamList", teamList);
		/* 파트너목록 추출*/
		List<TopPtnrBscVO> ptnrList = sqlSession.selectList("primBizInvListMapper.ptnrListForSearch");
		model.addAttribute("ptnrList", ptnrList);
		/* suim_rpt_type1 추출*/
		List<SysAdmCodeDicVO> type1List = sqlSession.selectList("primBizInvListMapper.suimRptType1ForSearch");
		model.addAttribute("type1List", type1List);

		TopPrimBizInvListViewVO totVO = sqlSession.selectOne("primBizInvListMapper.getInvListCnt", searchVO);//총 조회 건수
		int totCntInt = totVO.getTotCntInt();		

		List<TopPrimBizInvListViewVO> invList = sqlSession.selectList("primBizInvListMapper.getInvListExcel", searchVO);

		int totAmtNotDeposit = sqlSession.selectOne("primBizInvListMapper.getAmtNotDeposit", searchVO);

		model.addAttribute("searchVO", searchVO);
		model.addAttribute("invList", invList);		
		model.addAttribute("totVO", totVO);
		model.addAttribute("totCntInt", totCntInt);
		model.addAttribute("totAmtNotDeposit", totAmtNotDeposit);

		return "top_prim_biz_inv/prim_biz_inv_list_excel";
	}//primBizInvListExcel
	
	/**
	 * 농작물 입금일자 일괄처리 모달
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "incomePrimUpdateModal")
	public String incomePrimUpdateModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= incomePrimUpdateModal =======");
						
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		
		String [] sInvNo = request.getParameterValues("invList");			//인보이스 키값
		
		List<Map<String, Object>> invDetailList = new ArrayList<Map<String,Object>>();
		Map<String, Object> invMap;
		
		for(int i=0; i < sInvNo.length; i++) {
			paramMap.put("invoice_no", sInvNo[i]);
			invMap = sqlSession.selectOne("primBizInvListMapper.getInvPrimInfoDetail", paramMap);
			invDetailList.add(invMap);
		}
		
		model.addAttribute("invDetailList", invDetailList);
		
		return "top_prim_biz_inv/prim_biz_inv_income_update_modal";
	}
	
	/**
	 * 농작물 계산서 일괄처리 모달
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "publishPrimUpdateModal")
	public String publishPrimUpdateModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= publishPrimUpdateModal =======");
						
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String [] sInvNo = request.getParameterValues("invList");			//인보이스 키값
		
		List<Map<String, Object>> invDetailList = new ArrayList<Map<String,Object>>();
		Map<String, Object> invMap;
		
		for(int i=0; i < sInvNo.length; i++) {
			paramMap.put("invoice_no", sInvNo[i]);
			invMap = sqlSession.selectOne("primBizInvListMapper.getInvPrimInfoDetail", paramMap);
			invDetailList.add(invMap);
		}
		
		model.addAttribute("invDetailList", invDetailList);
		
		return "top_prim_biz_inv/prim_biz_inv_publish_update_modal";
	}
	
	/**
	 * 농작물 입금일자 정보 갱신
	 * @param request
	 * @param model
	 * @return
	 */	
	@RequestMapping(value="/updatePrimIncomeDate")
    @ResponseBody
    public Map<String,Object> updatePrimIncomeDate(HttpServletRequest request, Model model) {
		
		logger.info("======== updatePrimIncomeDate ========");
		
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
    			//기존 등록 데이터가 있는지 확인필요
    			suim_rpt_no = sSuimNo[i];    			
    			paramMap.put("suim_rpt_no", suim_rpt_no);
    			
    			//입금일자
				paramMap.put("deposit_date", income_date);
				
    			//세금계산서 테이블에 기존에 등록된 값을 체크한다.    			
    			nCnt = sqlSession.selectOne("primBizInvListMapper.getInvPrimTaxCnt", suim_rpt_no);
    			
    			//인보이스 합계금액을 가져온다.
    			nTotal_amt = sqlSession.selectOne("primBizInvListMapper.getInvPrimTotalAmt", suim_rpt_no);
    			
    			//입금액 신규추가
				paramMap.put("deposit_amount", nTotal_amt);
    			
    			//신규 세금계산서 테이블 정보 입력
    			if( nCnt == 0 ) {    				    				
    				//세금계산서 발행금액은 초기금액으로 입력
    				paramMap.put("publish_amount", 0);    				
    				sqlSession.insert("primBizInvListMapper.insertInvPrimTax", paramMap);
    				resultInsertCnt++;		//추가한 수를 증가시킨다.    				
    			}else {    				
    				//기존 입금일자 등록값이 있는지 확인한다.
    				nCnt_sub = sqlSession.selectOne("primBizInvListMapper.getInvPrimTaxDepositCnt", suim_rpt_no);
    				if( nCnt_sub == 0 ){		//기존등록일자와 금액이 없는 경우만 update 한다.    					
    					sqlSession.update("primBizInvListMapper.updateInvPrimTaxDeposit", paramMap);
    					resultUpdateCnt++;		//갱신한 수를 증가시킨다.
    				}else{
    					resultFailCnt++;			//기존값이 있어서 skip 한 건수를 증가시킨다.
    				}
    			}
    			
    			//인보이스 입금일자가 기존에 없는 경우 갱신
    			sqlSession.update("primBizInvListMapper.updateInvPrimDepositDate", paramMap);
    			
    			//인보이스의 세금계산서, 입금액 합을 비교하여 동일하면 작업완료로 표시한다.
    			nEnd_chk = sqlSession.selectOne("primBizInvListMapper.chkInvPrimTaxAmountSum", suim_rpt_no);
    			
    			//nEnd_chk : 1 (동일), 0 (합계값이 다름)
    			paramMap.put("tax_edit_end", nEnd_chk);
    			sqlSession.update("primBizInvListMapper.updatePrimTaxWork", paramMap);
    			
    			//세금계산서 No를 인보이스킷값으로 갱신한다.    			
    			sqlSession.update("PrimBizInvDtlMapper.updateInvPrimInvoiceNoAutoSuimNo", suim_rpt_no);
    			
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
	 * 농작물 세금계산서 일자 정보생신
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/updatePrimPublishDate")
    @ResponseBody
    public Map<String,Object> updatePrimPublishDate(HttpServletRequest request, Model model) {
		
		logger.info("======== updatePrimPublishDate ========");
		
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
    			//기존 등록 데이터가 있는지 확인필요
    			suim_rpt_no = sSuimNo[i];    			
    			paramMap.put("suim_rpt_no", suim_rpt_no);
    			
    			//세금계산서 등록일자
				paramMap.put("publish_date", publish_date);
				
    			//세금계산서 테이블에 기존에 등록된 값을 체크한다.    			
    			nCnt = sqlSession.selectOne("primBizInvListMapper.getInvPrimTaxCnt", suim_rpt_no);
    			
    			//인보이스 합계금액을 가져온다.
    			nTotal_amt = sqlSession.selectOne("primBizInvListMapper.getInvPrimTotalAmt", suim_rpt_no);
    			
    			//세금계산서 확인금액 신규추가
				paramMap.put("publish_amount", nTotal_amt);    			
    			
    			//신규 세금계산서 테이블 정보 입력
    			if( nCnt == 0 ) {
    				//입금금액은 초기금액으로 입력
    				paramMap.put("deposit_amount", 0);
    				sqlSession.insert("primBizInvListMapper.insertInvPrimTax", paramMap);
    				resultInsertCnt++;		//추가한 수를 증가시킨다.    				
    			}else {    				
    				//기존 입금일자 등록값이 있는지 확인한다.
    				nCnt_sub = sqlSession.selectOne("primBizInvListMapper.getInvPrimTaxPublishCnt", suim_rpt_no);
    				if( nCnt_sub == 0 ){		//기존 세금계산서 일자와 금액이 없는 경우만 update 한다.
    					sqlSession.update("primBizInvListMapper.updateInvPrimTaxPublish", paramMap);
    					resultUpdateCnt++;		//갱신한 수를 증가시킨다.
    				}else{
    					resultFailCnt++;			//기존값이 있어서 skip 한 건수를 증가시킨다.
    				}
    			}
    			
    			//인보이스 세금계산서 재발급일이 기존에 없는 경우 갱신
    			sqlSession.update("primBizInvListMapper.updateInvPrimPublishDate", paramMap);
    			
    			//인보이스의 세금계산서, 입금액 합을 비교하여 동일하면 작업완료로 표시한다.
    			nEnd_chk = sqlSession.selectOne("primBizInvListMapper.chkInvPrimTaxAmountSum", suim_rpt_no);    			    			
    			
    			//nEnd_chk : 1 (동일), 0 (합계값이 다름)
    			paramMap.put("tax_edit_end", nEnd_chk);
    			sqlSession.update("primBizInvListMapper.updatePrimTaxWork", paramMap);
    			
    			//세금계산서 No를 인보이스킷값으로 갱신한다.    			
    			sqlSession.update("PrimBizInvDtlMapper.updateInvPrimInvoiceNoAutoSuimNo", suim_rpt_no);    			
    		}
    		sMsg = "입금일자 일괄처리 결과\n";
    		sMsg += "추가 건수 : "+resultInsertCnt+" 건\n";
    		sMsg += "갱신 건수 : "+resultUpdateCnt+" 건\n";
    		sMsg += "기 입력 건수 : "+resultFailCnt+" 건\n";    		
    	}
    	
    	resultMap.put("msg", sMsg);
    		
    	return resultMap;
    }

}//end of class
