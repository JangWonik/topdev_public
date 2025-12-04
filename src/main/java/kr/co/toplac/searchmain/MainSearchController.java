package kr.co.toplac.searchmain;

import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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

import kr.co.toplac.sysadm.SysAdmCodeDicVO;
import kr.co.toplac.topprimbiz.TopPrimBizRptHeadVO;
import kr.co.toplac.topptnr.TopPtnrBscVO;
import kr.co.toplac.toprptinv.TopRptInvDtlViewVO;
import kr.co.toplac.topsuim.SuimCommon;
import kr.co.toplac.topsuim.SuimRptCancelVO;
import kr.co.toplac.topsuim.SuimRptCompositeVO;
import kr.co.toplac.topsuim.TopRptCtrlAllBean;
import kr.co.toplac.topsuim.TopRptHeadVO;
import kr.co.toplac.topsuit.SuimSuit_10VO;
import kr.co.toplac.topsuit.SuimSuit_18VO;
import kr.co.toplac.topsuit.SS.SuimSuit_18_SmsVO;
import kr.co.toplac.topsuit12.SuimSuit_12VO;
import kr.co.toplac.topsuit17.SuimSuit_17VO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.etc.Damo;
import kr.co.toplac.util.page.PageUtilityBasic;

@Controller
public class MainSearchController {

	private static final Logger logger = LoggerFactory.getLogger(MainSearchController.class);

	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "sagoDetailNewModal", method = RequestMethod.POST)
    public String sagoDetailNewModal(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		
    	logger.info("======= sagoDetailNewModal =======");
    	
    	TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("searchMain - no permession : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		
		String suim_rpt_no = request.getParameter("suim_rpt_no") != null ? request.getParameter("suim_rpt_no") : "";		
		
		//신규 사고처리 과정표 정보 가져오기
		List<TopRptCtrlAllBean> sagoTotalList  = sqlSession.selectList("SagoBscMapper.getSagoAllList", suim_rpt_no);
		
		model.addAttribute("sagoTotalList", sagoTotalList);
    	
    	return "search_main/sago_detail_new_modal";
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
	@RequestMapping(value = "searchMain")
	public String searchMain(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= searchMain =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("searchMain - no permession : "+request.getRemoteAddr());
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

		return "search_main/search_main";
	}//searchMain
	
	//반려처리
	@RequestMapping(value = "returnRpt_action")
    @ResponseBody
    public int returnRpt_action(HttpServletRequest request, Model model){
    	logger.info("======== returnRpt_action_update ========");
        
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        String suimRptNo = paramMap.get("suim_rpt_no").toString();        

        int result = sqlSession.update("SuimBookUdtMapper.rptActionRptReturn", suimRptNo);
        
        String action = "returnRpt";		//반려Action
        
        SuimCommon comm = new SuimCommon();
        comm.insSuimRptLog(sqlSession, action, suimRptNo);

        return result;
    }
	
	//종결처리
	@RequestMapping(value = "endRpt_action")
    @ResponseBody
    public int endRpt_action(HttpServletRequest request, Model model){
    	logger.info("======== endRpt_action_update ========");
        
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        String suimRptNo = paramMap.get("suim_rpt_no").toString();
        
        //System.out.println("종결="+suimRptNo);

        int result = 0;
        
        /*현재날짜계산*/
		Calendar cal = Calendar.getInstance();    
		cal.setTime(new Date());    
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
		String today = df.format(cal.getTime());
		String thisYear = today.substring(2, 4);		
		String nextCloseNo = "";
        
        //종결하기        
        String suim_rpt_no = suimRptNo;
        
		SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", suim_rpt_no);
		
		/*인보이스 정보 추출 시작*/
		TopRptInvDtlViewVO suimInvVO = sqlSession.selectOne("InvoiceDtlMapper.getInvoiceDtlForRptDtl", suim_rpt_no);
		
        HashMap<String, String> mapForAcceptSeqNo = new HashMap<String, String>();
        mapForAcceptSeqNo.put("suim_accept_seq_no", "");

        //======== 스피드 종결 번호==========
        String endCode = sqlSession.selectOne("SuimRegInsMapper.getEcode",suimVo.getTeam_id() );
        String searchStr = endCode+thisYear;
        //입력될 보고서의 접수번호 뒷자리 = 보고서 현재 '접수번호 앞자리' 로 검색되는 보고서의 총 개수 +1  
        sqlSession.update("SuimRegInsMapper.getSuimEndSeqNo", mapForAcceptSeqNo);
        String SpeedClose = mapForAcceptSeqNo.get("suim_close_seq_no2");
        nextCloseNo = searchStr+"-"+makeFourNumberWithZero(SpeedClose);
        //======== 스피드 종결 번호==========

        HashMap<String,String> map = new HashMap<String,String>();
        map.put("suimRptNo", suimRptNo);
        map.put("nextCloseNo", nextCloseNo);

        String closeDate = "";

        if(suimVo.getCloseDate() != null){
        	if(!suimVo.getCloseDate().equals("1970-01-01")){
        		closeDate = suimVo.getCloseDate();
        	}else{
        		closeDate = today;
        	}
        }else{
        	closeDate = today;
        }
        map.put("closeDate", closeDate);

        /*보고서 정보 종결 업데이트*/
        result = sqlSession.update("SuimBookUdtMapper.rptActionRptEnd", map);

        /*인보이스 정보 종결 업데이트*/
        String closeDateInv = "";
        if(result > 0){        	
        	map.clear();        	
        	if(suimInvVO.getInvoiceDate() != null){
        		if(!suimInvVO.getInvoiceDate().equals("1970-01-01")){
        			closeDateInv = suimInvVO.getInvoiceDate();
        		}else{
        			closeDateInv = closeDate;
        		}
        	}else{
        		closeDateInv = closeDate;
        	}
        	
        	map.put("invoiceDate", closeDateInv);
        	map.put("suimRptNo", suimRptNo);
        	
        	result = sqlSession.update("SuimBookUdtMapper.rptActionRptEndInv", map);						
        }
        
        /*
         * 로그남기기
         */
        SuimCommon comm = new SuimCommon();

        String action = "end";		//종결상태로 로그남기기        
        comm.insSuimRptLog(sqlSession, action, suim_rpt_no);

        return result;
    }
	
	//신규 빠른 결재 페이지 이동
	@RequestMapping(value = "quickApprovalList")
	public String quickApprovalList(Model model, HttpSession session, HttpServletRequest request
			, SearchMainQueryVO searchVO, String reqPgNo, String presentPage) {

		logger.info("======= quickApprovalList =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("searchMainQuery - no permession : "+request.getRemoteAddr());
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

		if(searchVO.getStateSearch() == null || searchVO.getStateSearch().equals("")) {
			searchVO.setStateSearch("1");		//결재상태인것만 가져온다.
		}else {
			//System.out.println("oniku search="+searchVO.getStateSearch());
			searchVO.setStateSearch(searchVO.getStateSearch());
		}			
		searchVO.setApprovalId("1");		//빠른결재인경우 권한이있는 문서만 불러온다. by top3009
		searchVO.setNoUserSearch("");
		searchVO.setType1Search("0");
		
		if(searchVO.getRegDateFromSearch() == null || searchVO.getRegDateFromSearch().equals("")) {
			searchVO.setRegDateFromSearch("");
		}else{
			searchVO.setRegDateFromSearch(searchVO.getRegDateFromSearch().toString());
		}
		
		if(searchVO.getRegDateToSearch() == null || searchVO.getRegDateToSearch().equals("")) {
			searchVO.setRegDateToSearch("");
		}else{
			searchVO.setRegDateToSearch(searchVO.getRegDateToSearch().toString());
		}			

		searchVO.setCancelDateFromSearch("");
		searchVO.setCancelDateToSearch("");
		
		if(searchVO.getTmSearch() == null || searchVO.getTmSearch().equals("")) {
			searchVO.setTmSearch("0");
		}else {
			searchVO.setTmSearch(searchVO.getTmSearch());
		}		
		
		if( searchVO.getTmGubun() == null || searchVO.getTmGubun().equals("") ){
			searchVO.setTmGubun("");
		}else{
			searchVO.setTmGubun( searchVO.getTmGubun() );
		}
		
		if( searchVO.getUserNmSearch() == null || searchVO.getUserNmSearch().equals("") ) {
			searchVO.setUserNmSearch("");
		}else{
			searchVO.setUserNmSearch(searchVO.getUserNmSearch());
		}
		
		searchVO.setAprvDateFromSearch("");
		searchVO.setAprvDateToSearch("");
		searchVO.setCloseDateFromSearch("");
		searchVO.setCloseDateToSearch("");
		searchVO.setPtnrSearch("0");
		searchVO.setPtnrGubun("");
		searchVO.setPtnrDeptNmSearch("");
		searchVO.setPtnrUserNmSearch("");
		searchVO.setInsuNmSearch("");
		
		if(searchVO.getPolicyhNmSearch() == null || searchVO.getPolicyhNmSearch().equals("")) {
			searchVO.setPolicyhNmSearch("");
		}else{
			searchVO.setPolicyhNmSearch(searchVO.getPolicyhNmSearch());
		}
		
		searchVO.setPolicySsn1Search("");
		searchVO.setPolicySsn2Search("");
		searchVO.setBenefiNmSearch("");
		searchVO.setBenefiSsn1Search("");
		searchVO.setBenefiSsn2Search("");
		searchVO.setDamagedNmSearch("");
		searchVO.setPolicyNoSearch("");
		searchVO.setAccidentFactsSearch("");
		
		if(searchVO.getAcceptNoSearch() == null || searchVO.getAcceptNoSearch().equals("")) {
			searchVO.setAcceptNoSearch("");
		}else {
			searchVO.setAcceptNoSearch(searchVO.getAcceptNoSearch().toString());
		}
		
		if(searchVO.getAccidentNoSearch() == null || searchVO.getAccidentNoSearch().equals("")) {
			searchVO.setAccidentNoSearch("");
		}else {			
			searchVO.setAccidentNoSearch(searchVO.getAccidentNoSearch());
		}
					
		searchVO.setMoralSearch("");
		searchVO.setMinwonSearch("3");
		searchVO.setMinwonDateFromSearch("");
		searchVO.setMinwonDateToSearch("");
		searchVO.setMoralDateFromSearch("");
		searchVO.setMoralDateToSearch("");
		searchVO.setUserNo(mbrVo.getUser_no());		

		PageUtilityBasic pageUtil = new PageUtilityBasic();
		int totCntInt = 0;
		int queryPgNoInt = 0;

		//101
		if(presentPage == null || presentPage.equals("") || presentPage.equals("suimrpttab")){
			List<TopRptHeadVO> suimBookList = null;
			totCntInt = sqlSession.selectOne("SearchMainSuimMapper.searchApprovalSuimRptListCnt", searchVO);//총 조회 건수			
			
			if(totCntInt > 0){
				queryPgNoInt = pageUtil.pageBasic2(101, totCntInt, reqPgNo, model, "searchMainQuery");
				searchVO.setQueryPgNoInt(queryPgNoInt);
				suimBookList = sqlSession.selectList("SearchMainSuimMapper.searchApprovalSuimRptList", searchVO);
			}
			model.addAttribute("suimRptListTotCnt", totCntInt);
			model.addAttribute("suimBookList", suimBookList);
		}

		model.addAttribute("searchVO", searchVO);
		model.addAttribute("presentPage", presentPage);
		model.addAttribute("searchMainSimpleQueryTxt", searchVO.getSearchMainSimpleQueryTxt());
		return "search_main/quick_approval_list";
	}//quickApprovalList
	

	@RequestMapping(value = "searchMainQuery")
	public String searchMainQuery(Model model, HttpSession session, HttpServletRequest request
			, SearchMainQueryVO searchVO, String reqPgNo, String presentPage) {

		logger.info("======= searchMainQuery =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("searchMainQuery - no permession : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		
		//검색 로그 남기기 시작 (20240109)
		String sUserNo = mbrVo.getUser_no();		
		String sUserName = mbrVo.getUser_name();
		String sIp = mbrVo.getUser_ip();
		String sLogPage = "상세검색";
		
		Map<String, Object> logMap = new HashMap<String, Object>();
		
		logMap.put("user_no", sUserNo);
		logMap.put("user_name", sUserName);
		logMap.put("user_ip", sIp);
		logMap.put("search_page", sLogPage);
		
		sqlSession.insert("SaveLogMapper.insertTopSearchLog",logMap);
		//검색 로그 남기기 끝 (20240109)
		
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
		System.out.println("presentPage           : "+presentPage);
		System.out.println("stateSearch          : "+searchVO.getStateSearch());
		System.out.println("noUserSearch          : "+searchVO.getNoUserSearch());
		System.out.println("type1Search          : "+searchVO.getType1Search());
		System.out.println("regDateFromSearch          : "+searchVO.getRegDateFromSearch());
		System.out.println("regDateToSearch          : "+searchVO.getRegDateToSearch());
		System.out.println("cancelDateFromSearch          : "+searchVO.getCancelDateFromSearch());
		System.out.println("cancelDateToSearch          : "+searchVO.getCancelDateToSearch());
		System.out.println("tmSearch          : "+searchVO.getTmSearch());
		System.out.println("tmGubun          : "+searchVO.getTmGubun());
		System.out.println("userNmSearch          : "+searchVO.getUserNmSearch());
		System.out.println("aprvDateFromSearch          : "+searchVO.getAprvDateFromSearch());
		System.out.println("aprvDateToSearch          : "+searchVO.getAprvDateToSearch());
		System.out.println("closeDateFromSearch          : "+searchVO.getCloseDateFromSearch());
		System.out.println("closeDateToSearch          : "+searchVO.getCloseDateToSearch());
		System.out.println("ptnrSearch          : "+searchVO.getPtnrSearch());
		System.out.println("ptnrGubun          : "+searchVO.getPtnrGubun());
		System.out.println("ptnrUserNmSearch          : "+searchVO.getPtnrUserNmSearch());
		System.out.println("insuNmSearch          : "+searchVO.getInsuNmSearch());
		System.out.println("policyhNmSearch          : "+searchVO.getPolicyhNmSearch());
		System.out.println("policySsn1Search          : "+searchVO.getPolicySsn1Search());
		System.out.println("policySsn2Search          : "+searchVO.getPolicySsn2Search());
		System.out.println("benefiNmSearch          : "+searchVO.getBenefiNmSearch());
		System.out.println("benefiSsn1Search          : "+searchVO.getBenefiSsn1Search());
		System.out.println("benefiSsn2Search          : "+searchVO.getBenefiSsn2Search());
		System.out.println("damagedNmSearch          : "+searchVO.getDamagedNmSearch());
		System.out.println("accidentNoSearch          : "+searchVO.getAccidentNoSearch());
		System.out.println("policyNoSearch          : "+searchVO.getPolicyNoSearch());
		System.out.println("accidentFactsSearch          : "+searchVO.getAccidentFactsSearch());
		System.out.println("acceptNoSearch          : "+searchVO.getAcceptNoSearch());
		System.out.println("moralSearch          : "+searchVO.getMoralSearch());
		System.out.println("minwonSearch          : "+searchVO.getMinwonSearch());
		System.out.println("searchMainSimpleQueryTxt          : "+searchVO.getSearchMainSimpleQueryTxt());
		System.out.println("searchMainSimpleQueryTxt          : "+searchVO.getSearchMainSimpleQueryTxt());
		*/		

		if(!searchVO.getSearchMainSimpleQueryTxt().trim().equals("")){
			searchVO.setStateSearch("9999");
			searchVO.setSiteStateSearch("9999");
			searchVO.setNoUserSearch("");
			searchVO.setType1Search("0");
			searchVO.setRegDateFromSearch("");
			searchVO.setRegDateToSearch("");
			searchVO.setCancelDateFromSearch("");
			searchVO.setCancelDateToSearch("");
			searchVO.setTmSearch("0");
			searchVO.setTmGubun("");
			searchVO.setUserNmSearch("");
			searchVO.setAprvDateFromSearch("");
			searchVO.setAprvDateToSearch("");
			searchVO.setCloseDateFromSearch("");
			searchVO.setCloseDateToSearch("");
			searchVO.setPtnrSearch("0");
			searchVO.setPtnrGubun("");
			searchVO.setPtnrDeptNmSearch("");
			searchVO.setPtnrUserNmSearch("");
			searchVO.setInsuNmSearch("");
			searchVO.setPolicyhNmSearch("");
			searchVO.setPolicySsn1Search("");
			searchVO.setPolicySsn2Search("");
			searchVO.setBenefiNmSearch("");
			searchVO.setBenefiSsn1Search("");
			searchVO.setBenefiSsn2Search("");
			searchVO.setDamagedNmSearch("");
			searchVO.setAccidentNoSearch("");
			searchVO.setPolicyNoSearch("");
			searchVO.setAccidentFactsSearch("");
			searchVO.setAcceptNoSearch("");
			searchVO.setMoralSearch("");
			searchVO.setMinwonSearch("3");
			searchVO.setMinwonDateFromSearch("");
			searchVO.setMinwonDateToSearch("");
			searchVO.setMoralDateFromSearch("");
			searchVO.setMoralDateToSearch("");
			searchVO.setSiteResultSearch("");
			
		}

		PageUtilityBasic pageUtil = new PageUtilityBasic();
		int totCntInt = 0;
		int queryPgNoInt = 0;

		//101
		if(presentPage == null || presentPage.equals("") || presentPage.equals("suimrpttab")){
			List<TopRptHeadVO> suimBookList = null;
			totCntInt = sqlSession.selectOne("SearchMainSuimMapper.searchMainSuimRptListCnt", searchVO);//총 조회 건수
			if(totCntInt > 0){
				queryPgNoInt = pageUtil.pageBasic2(101, totCntInt, reqPgNo, model, "searchMainQuery");
				searchVO.setQueryPgNoInt(queryPgNoInt);
				suimBookList = sqlSession.selectList("SearchMainSuimMapper.searchMainSuimRptList", searchVO);
			}
			model.addAttribute("suimRptListTotCnt", totCntInt);
			model.addAttribute("suimBookList", suimBookList);
		}

		//201
		if(presentPage == null || presentPage.equals("") || presentPage.equals("primbizrpttab")){
			if (
				   !"".equals(searchVO.getMinwonDateFromSearch())	//민원발생일
				|| !"".equals(searchVO.getMinwonDateToSearch())		//민원발생일
				|| !"".equals(searchVO.getMoralDateFromSearch())	//공문수신일
				|| !"".equals(searchVO.getMoralDateToSearch())		//공문수신일						
			){
				searchVO.setNotSearch("1");;
			}			
			
			List<TopPrimBizRptHeadVO> primbizRptList = null;
			totCntInt = sqlSession.selectOne("SearchMainPrimbizMapper.searchMainPrimbizRptListCnt", searchVO);//총 조회 건수+
			if(totCntInt > 0){
				queryPgNoInt = pageUtil.pageBasic2(201, totCntInt, reqPgNo, model, "searchMainQuery");
				searchVO.setQueryPgNoInt(queryPgNoInt);
				primbizRptList = sqlSession.selectList("SearchMainPrimbizMapper.searchMainPrimbizRptList", searchVO);
			}
			model.addAttribute("primbizRptListTotCnt", totCntInt);
			model.addAttribute("primbizRptList", primbizRptList);
		}
		
		/*
		System.out.println(  !"".equals(searchVO.getPtnrUserNmSearch() ));
		System.out.println(  !"0".equals(searchVO.getType1Search() ));//
		System.out.println(  !"".equals(searchVO.getBenefiNmSearch() ));
		System.out.println(  !"".equals(searchVO.getDamagedNmSearch() ));
		System.out.println(  !"".equals(searchVO.getAccidentNoSearch() ));
		System.out.println(  !"".equals(searchVO.getPolicyNoSearch() ));
		System.out.println(  !"".equals(searchVO.getAccidentFactsSearch() ));
		System.out.println(  null != searchVO.getMoralSearch() ); //
		System.out.println(  !"3".equals(searchVO.getMinwonSearch() )); //
		
		System.out.println(  !"".equals(searchVO.getMinwonDateFromSearch() ));
		System.out.println(  !"".equals(searchVO.getMinwonDateToSearch() ));
		System.out.println(  !"".equals(searchVO.getPtnrDeptNmSearch() ));
		
		System.out.println( "["+ searchVO.getPtnrUserNmSearch() +"]" );
		System.out.println( "["+ searchVO.getType1Search()+"]" );//
		System.out.println( "["+ searchVO.getBenefiNmSearch() +"]");
		System.out.println( "["+ searchVO.getDamagedNmSearch()+"]" );
		System.out.println( "["+ searchVO.getAccidentNoSearch()+"]" );
		System.out.println( "["+ searchVO.getPolicyNoSearch()+"]" );
		System.out.println( "["+ searchVO.getAccidentFactsSearch()+"]" );
		System.out.println( "["+ searchVO.getMoralSearch()+"]" ); //
		System.out.println( "["+ searchVO.getMinwonSearch()+"]" ); //
		
		System.out.println( "["+ searchVO.getMinwonDateFromSearch()+"]" );
		System.out.println( "["+ searchVO.getMinwonDateToSearch()+"]" );
		System.out.println( "["+ searchVO.getPtnrDeptNmSearch()+"]" );
		*/
		
		//310
		if(presentPage == null || presentPage.equals("") || presentPage.equals("suit10rpttab")){
			
			if (
				 !"".equals(searchVO.getPtnrUserNmSearch())		//보험사 담당자
				|| !"0".equals(searchVO.getType1Search())		//보험사 담당자
				|| !"".equals(searchVO.getBenefiNmSearch())		//피보험자
				|| !"".equals(searchVO.getDamagedNmSearch())		//피해자
				|| !"".equals(searchVO.getAccidentNoSearch()) 	//사고번호
				|| !"".equals(searchVO.getAccidentFactsSearch())	//사고내용
				|| !"3".equals(searchVO.getMinwonSearch())			//민원
				|| !"".equals(searchVO.getMinwonDateFromSearch())	//민원발생일
				|| !"".equals(searchVO.getMinwonDateToSearch())		//민원발생일
				|| !"".equals(searchVO.getPtnrDeptNmSearch())		//보험사 팀
				|| !"".equals(searchVO.getMoralDateFromSearch())	//공문수신일
				|| !"".equals(searchVO.getMoralDateToSearch())		//공문수신일				
			){
				searchVO.setNotSearch("1");;
			}
			
			List<SuimSuit_10VO> suitList10 = null;
			
			totCntInt = sqlSession.selectOne("SearchMainSuit10Mapper.searchMainSuit10RptListCnt", searchVO);//총 조회 건수
			if(totCntInt > 0){
				queryPgNoInt = pageUtil.pageBasic2(310, totCntInt, reqPgNo, model, "searchMainQuery");
				searchVO.setQueryPgNoInt(queryPgNoInt);
				suitList10 = sqlSession.selectList("SearchMainSuit10Mapper.searchMainSuit10RptList", searchVO);
			}
			model.addAttribute("suit10RptListTotCnt", totCntInt);
			model.addAttribute("suitList10", suitList10);
		}

		//312
		if(presentPage == null || presentPage.equals("") || presentPage.equals("suit12rpttab")){
			if (
				 !"".equals(searchVO.getPtnrUserNmSearch())		//보험사 담당자
				|| !"0".equals(searchVO.getType1Search())		//보험사 담당자
				|| !"".equals(searchVO.getBenefiNmSearch())		//피보험자
				|| !"".equals(searchVO.getDamagedNmSearch())		//피해자
				|| !"".equals(searchVO.getAccidentNoSearch()) 		//사고번호
				|| !"".equals(searchVO.getAccidentFactsSearch())	//사고내용
				|| !"3".equals(searchVO.getMinwonSearch())			//민원
				|| !"".equals(searchVO.getMinwonDateFromSearch())	//민원발생일
				|| !"".equals(searchVO.getMinwonDateToSearch())		//민원발생일
				|| !"".equals(searchVO.getPtnrDeptNmSearch())		//보험사 팀
				|| !"".equals(searchVO.getMoralDateFromSearch())	//공문수신일
				|| !"".equals(searchVO.getMoralDateToSearch())		//공문수신일						
			){
				searchVO.setNotSearch("1");;
			}
			List<SuimSuit_12VO> suimSuit12List = null;
			totCntInt = sqlSession.selectOne("SearchMainSuit12Mapper.searchMainSuit12RptListCnt", searchVO);//총 조회 건수
			if(totCntInt > 0){
				queryPgNoInt = pageUtil.pageBasic2(312, totCntInt, reqPgNo, model, "searchMainQuery");
				searchVO.setQueryPgNoInt(queryPgNoInt);
				suimSuit12List = sqlSession.selectList("SearchMainSuit12Mapper.searchMainSuit12RptList", searchVO);
			}
			model.addAttribute("suit12RptListTotCnt", totCntInt);
			model.addAttribute("suimSuit12List", suimSuit12List);
		}

		//317
		if(presentPage == null || presentPage.equals("") || presentPage.equals("suit17rpttab")){
			if (
				 !"".equals(searchVO.getPtnrUserNmSearch())		//보험사 담당자
				|| !"0".equals(searchVO.getType1Search())		//보험사 담당자
				|| !"".equals(searchVO.getBenefiNmSearch())		//피보험자
				|| !"".equals(searchVO.getDamagedNmSearch())		//피해자
				|| !"".equals(searchVO.getAccidentNoSearch()) 		//사고번호
				|| !"".equals(searchVO.getPolicyNoSearch())			//증권번호
				|| !"".equals(searchVO.getAccidentFactsSearch())	//사고내용
				|| !"3".equals(searchVO.getMinwonSearch())			//민원
				|| !"".equals(searchVO.getMinwonDateFromSearch())	//민원발생일
				|| !"".equals(searchVO.getMinwonDateToSearch())		//민원발생일
				|| !"".equals(searchVO.getPtnrDeptNmSearch())		//보험사 팀
				|| !"".equals(searchVO.getMoralDateFromSearch())	//공문수신일
				|| !"".equals(searchVO.getMoralDateToSearch())		//공문수신일						
			){
				searchVO.setNotSearch("1");
			}
			List<SuimSuit_17VO> suimSuit17List = null;
			totCntInt = sqlSession.selectOne("SearchMainSuit17Mapper.searchMainSuit17RptListCnt", searchVO);//총 조회 건수
			if(totCntInt > 0){
				queryPgNoInt = pageUtil.pageBasic2(317, totCntInt, reqPgNo, model, "searchMainQuery");
				searchVO.setQueryPgNoInt(queryPgNoInt);
				suimSuit17List = sqlSession.selectList("SearchMainSuit17Mapper.searchMainSuit17RptList", searchVO);
			}
			model.addAttribute("suit17RptListTotCnt", totCntInt);
			model.addAttribute("suimSuit17List", suimSuit17List);
		}

		//318
		if(presentPage == null || presentPage.equals("") || presentPage.equals("suit18rpttab")){
			
			/*
			System.out.println("1 : "+ !"".equals(searchVO.getPtnrUserNmSearch()) );
			System.out.println("2 : "+ !"0".equals(searchVO.getType1Search()) );
			System.out.println("3 : "+ !"".equals(searchVO.getBenefiNmSearch()) );
			System.out.println("4 : "+ !"".equals(searchVO.getDamagedNmSearch()) );
			System.out.println("5 : "+ !"".equals(searchVO.getAccidentNoSearch()) );
			System.out.println("6 : "+ !"".equals(searchVO.getAccidentFactsSearch()) );
			System.out.println("7 : "+ null != searchVO.getMoralSearch() );
			System.out.println("8 : "+  !"3".equals(searchVO.getMinwonSearch()) );
			System.out.println("9 : "+ !"".equals(searchVO.getMinwonDateFromSearch()) );
			System.out.println("10 : "+ !"".equals(searchVO.getMinwonDateToSearch()) );
			System.out.println("11 : "+ !"".equals(searchVO.getPtnrDeptNmSearch()) );
			*/
			
			if (
				 !"".equals(searchVO.getPtnrUserNmSearch())		//보험사 담당자
				|| !"0".equals(searchVO.getType1Search())		//보험사 담당자
				|| !"".equals(searchVO.getBenefiNmSearch())		//피보험자
				|| !"".equals(searchVO.getDamagedNmSearch())		//피해자
				|| !"".equals(searchVO.getAccidentNoSearch()) 	//사고번호
				|| !"".equals(searchVO.getAccidentFactsSearch())	//사고내용
				|| !"3".equals(searchVO.getMinwonSearch())			//민원
				|| !"".equals(searchVO.getMinwonDateFromSearch())	//민원발생일
				|| !"".equals(searchVO.getMinwonDateToSearch())		//민원발생일
				|| !"".equals(searchVO.getPtnrDeptNmSearch())		//보험사 팀
				|| !"".equals(searchVO.getMoralDateFromSearch())	//공문수신일
				|| !"".equals(searchVO.getMoralDateToSearch())		//공문수신일						
			){
				searchVO.setNotSearch("1");
			}
			List<SuimSuit_18VO> suitList18 = null;
			totCntInt = sqlSession.selectOne("SearchMainSuit18Mapper.searchMainSuit18RptListCnt", searchVO);//총 조회 건수
			if(totCntInt > 0){
				queryPgNoInt = pageUtil.pageBasic2(318, totCntInt, reqPgNo, model, "searchMainQuery");
				searchVO.setQueryPgNoInt(queryPgNoInt);
				suitList18 = sqlSession.selectList("SearchMainSuit18Mapper.searchMainSuit18RptList", searchVO);
				
				Damo damo = new Damo();
				for(int i=0; i < suitList18.size() ;i++){
					
					String suim_rpt_no = suitList18.get(i).getSuimRptNo();
					/*문자 정보 추출*/
					List<SuimSuit_18_SmsVO> samsungSmsList = sqlSession.selectList("Suit18Mapper.getSmsList",suim_rpt_no);
					
					int conCnt1 =0;
					int conCnt2 =0;
					
					for (int k = 0; k < samsungSmsList.size(); k++) {
						if(samsungSmsList.get(k).getSmsType().equals("1")){
							conCnt1++;
						}
						
						if(samsungSmsList.get(k).getSmsType().equals("2")){
							conCnt2++;
						}
						
					}
					
					suitList18.get(i).setConCnt1(Integer.toString(conCnt1));
					suitList18.get(i).setConCnt2(Integer.toString(conCnt2));
					
					if(suitList18.get(i).getConHndPhoneNo() != null && !suitList18.get(i).getConHndPhoneNo().equals("")){
						suitList18.get(i).setConHndPhoneNo( damo.decodeDamo(suitList18.get(i).getConHndPhoneNo()) );
					}
					if(suitList18.get(i).getClerkHndPhoneNo() != null && !suitList18.get(i).getClerkHndPhoneNo().equals("")){
						suitList18.get(i).setClerkHndPhoneNo( damo.decodeDamo(suitList18.get(i).getClerkHndPhoneNo()) );
					}
				}
				
			}
			model.addAttribute("suit18RptListTotCnt", totCntInt);
			model.addAttribute("suitList18", suitList18);
		}

		model.addAttribute("searchVO", searchVO);
		model.addAttribute("presentPage", presentPage);
		model.addAttribute("searchMainSimpleQueryTxt", searchVO.getSearchMainSimpleQueryTxt());
		return "search_main/search_main";
	}//searchMainQuery

	@RequestMapping(value = "searchMainQuerySuimExcel", method = RequestMethod.POST)
	public String searchMainQuerySuimExcel(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response
			, SearchMainQueryVO searchVO, String reqPgNo) {
		logger.info("======= searchMainQuerySuimExcel =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("searchMainQuerySuimExcel - no permession : "+request.getRemoteAddr());
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

		if(!searchVO.getSearchMainSimpleQueryTxt().trim().equals("")){
			searchVO.setMinwonSearch("3");
		}
		if (!"".equals(searchVO.getUserNmSearch()) ){
			String userNo = sqlSession.selectOne("SearchMainSuimMapper.selectUserNo", searchVO);
			searchVO.setUserNo(userNo);
			
		}
		//101
		//List<TopRptHeadVO> suimBookList = null;
		List<SearchMainExcelVO> suimBookList = null;
		suimBookList = sqlSession.selectList("SearchMainSuimMapper.searchMainSuimRptListExcel", searchVO);
		
		
		String sSagoTotalMsg = "";
		String sSuimRptNo = "";
		List<TopRptCtrlAllBean> sagoTotalList;
		
		for(int i=0; i < suimBookList.size(); i++) {
			
			sSuimRptNo = suimBookList.get(i).getSuim_rpt_no();
			
			//신규 사고처리 과정표 정보 가져오기
			sagoTotalList  = sqlSession.selectList("SagoBscMapper.getSagoAllList", sSuimRptNo);
			
			for(int k=0; k < sagoTotalList.size(); k++){
				sSagoTotalMsg += sagoTotalList.get(k).getControl_date()+" : "+sagoTotalList.get(k).getControl_subject()+" : "+sagoTotalList.get(k).getControl_memo()+"<br style='mso-data-placement:same-cell;'>";
			}
			
			sSagoTotalMsg = sSagoTotalMsg.replaceAll("\n", "<br style='mso-data-placement:same-cell;'>");
			sSagoTotalMsg = sSagoTotalMsg.replaceAll("<br>", "<br style='mso-data-placement:same-cell;'>");
			
			suimBookList.get(i).setSagoTotalMsg(sSagoTotalMsg);
			//massage Clear
			sSagoTotalMsg = "";
		}
		
		/*
		SearchMainExcelVO tmpVO = null;
		String tmpPtnrDeptNo = "";
		String tmpPtnrMbrNo = "";
		String tmpRptNo = "";
		String tmpPtnrDeptNm = "";
		String tmpPtnrTeamNm = "";//
		String tmpPtnrMbrNm = "";
		String tmpNow = "";
		String tmpProb = "";
		String tmpPlan = "";
		String tmpSiteDate = "";
		String tmpInterimDate = "";
		String tmpSiteDateFmt = "";
		String tmpInterimDateFmt = "";
		String tmpSago1 = "";
		String tmpSago2 = "";
		String tmpDate = "";
		String tmpPastDate = "";
		String past_date_ing = "";
		
		for(int i = 0; i < suimBookList.size(); i++){
			tmpVO = suimBookList.get(i);
			tmpRptNo = tmpVO.getSuim_rpt_no();
			tmpPtnrDeptNo = tmpVO.getPtnr_dept_id();
			tmpPtnrMbrNo = tmpVO.getPtnr_mbr_no();
			
			tmpNow = sqlSession.selectOne("SearchMainSuimMapper.searchMainSuimRptListExcelNow", tmpRptNo);
			tmpVO.setNow_memo(tmpNow);
			tmpPtnrDeptNm = sqlSession.selectOne("SearchMainSuimMapper.searchMainSuimRptListExcelPtnrDeptNm", tmpPtnrDeptNo);
			tmpVO.setPtnr_dept_nm(tmpPtnrDeptNm);
			tmpPtnrMbrNm = sqlSession.selectOne("SearchMainSuimMapper.searchMainSuimRptListExcelPtnrMbrNm", tmpPtnrMbrNo);
			tmpVO.setPtnr_mbr_nm(tmpPtnrMbrNm);
			tmpPtnrTeamNm = sqlSession.selectOne("SearchMainSuimMapper.searchMainSuimRptListExcelPtnrTeamNm", tmpPtnrMbrNo);
			tmpVO.setPtnr_tm2_nm(tmpPtnrTeamNm);
			
			tmpProb = sqlSession.selectOne("SearchMainSuimMapper.searchMainSuimRptListExcelProb", tmpRptNo);
			if (tmpProb != null){
				tmpVO.setPrb_memo(tmpProb.replaceAll("<br>", "<BR style='mso-data-placement: same-cell'>"));
			}
			
			tmpPlan = sqlSession.selectOne("SearchMainSuimMapper.searchMainSuimRptListExcelPlan", tmpRptNo);
			if (tmpPlan != null){
				tmpVO.setPln_memo(tmpPlan.replaceAll("<br>", "<BR style='mso-data-placement: same-cell'>"));
			}
			
			
			//SearchMainExcelVO tmpSelectVO1 = sqlSession.selectOne("SearchMainSuimMapper.searchMainSuimRptListExcelSiteDateFmt3", tmpRptNo);
			//tmpVO.setSite_date_fmt(tmpSelectVO1.getSite_date_fmt());
			//tmpVO.setSite_date(tmpSelectVO1.getSite_date());
			//SearchMainExcelVO tmpSelectVO2 = sqlSession.selectOne("SearchMainSuimMapper.searchMainSuimRptListExcelInterimDateFmt3", tmpRptNo);
			//tmpVO.setInterim_date_fmt(tmpSelectVO2.getInterim_date_fmt());
			//tmpVO.setInterim_date(tmpSelectVO2.getInterim_date());
			//SearchMainExcelVO tmpSelectVO3 = sqlSession.selectOne("SearchMainSuimMapper.searchMainSuimRptListExcelSago3", tmpRptNo);
			//tmpVO.setControl_date_cnt(tmpSelectVO3.getControl_date_cnt());
			//tmpVO.setControl_memo(tmpSelectVO3.getControl_memo());
			
			
			tmpSiteDateFmt = sqlSession.selectOne("SearchMainSuimMapper.searchMainSuimRptListExcelSiteDateFmt", tmpRptNo);
			tmpVO.setSite_date_fmt(tmpSiteDateFmt);
			
			tmpInterimDateFmt = sqlSession.selectOne("SearchMainSuimMapper.searchMainSuimRptListExcelInterimDateFmt", tmpRptNo);
			tmpVO.setInterim_date_fmt(tmpInterimDateFmt);
			
			
			
			tmpSago1 = sqlSession.selectOne("SearchMainSuimMapper.searchMainSuimRptListExcelSago1", tmpRptNo);
			tmpVO.setControl_date_cnt(tmpSago1);
			
			tmpSago2 = sqlSession.selectOne("SearchMainSuimMapper.searchMainSuimRptListExcelSago2", tmpRptNo);
			if (tmpSago2 != null){
				tmpVO.setControl_memo(tmpSago2.replaceAll("<BR>", "<BR style='mso-data-placement: same-cell'>"));
			}
			
			tmpSiteDate = sqlSession.selectOne("SearchMainSuimMapper.searchMainSuimRptListExcelSiteDate", tmpRptNo);
			tmpVO.setSite_date(tmpSiteDate);
			
			tmpInterimDate = sqlSession.selectOne("SearchMainSuimMapper.searchMainSuimRptListExcelInterimDate", tmpRptNo);
			tmpVO.setInterim_date(tmpInterimDate);
			
			

			if(Integer.parseInt(tmpVO.getSite_date()) > 0 || Integer.parseInt(tmpVO.getInterim_date()) > 0){
				if(Integer.parseInt(tmpVO.getSite_date()) >= Integer.parseInt(tmpVO.getInterim_date())){
					tmpDate = tmpVO.getSite_date();
				}else{
					tmpDate = tmpVO.getInterim_date();
				}
			}else{
				tmpDate = tmpVO.getReg_date();
			}
			
			
//			past_date_ing = sqlSession.selectOne("SearchMainSuimMapper.searchMainSuimRptListExcelPast_date_ing", tmpDate);
			System.out.println("tmpVO.getClose_date() : " +tmpVO.getClose_date());
			
			if(tmpVO.getClose_date() != null && !tmpVO.getClose_date().equals("")){
				HashMap<String, String> tmpMap = new HashMap<String, String>();
				tmpMap.put("close_date", tmpVO.getClose_date());
				tmpMap.put("tmpDate", tmpDate);
				past_date_ing = sqlSession.selectOne("SearchMainSuimMapper.searchMainSuimRptListExcelPast_date_ing3", tmpMap);
			}
			else{
				past_date_ing = sqlSession.selectOne("SearchMainSuimMapper.searchMainSuimRptListExcelPast_date_ing", tmpDate);
			}
			tmpVO.setPast_date_ing(past_date_ing);//select getDateDiff(숫자)

//			if(tmpVO.getClose_date() != null && !tmpVO.getClose_date().equals("")){
//				tmpPastDate = sqlSession.selectOne("SearchMainSuimMapper.searchMainSuimRptListExcelTmpPastDate", tmpVO);//reg_date - close_date
//				tmpVO.setPast_date_fmt(tmpPastDate);
//				System.out.println(tmpPastDate + ":tmpPastDate");
//			}
		}
		*/
		
		Date dt = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		String now = sdf.format(dt);
		

		model.addAttribute("suimBookList", suimBookList);
		
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("now", now);		
		
		response.setHeader("Content-Disposition", "attachment;filename=suimbook_"+now+"+.xls");
		response.setHeader("Content-Type", "application/vnd.ms-xls");
		response.setHeader("Content-Description", "JSP Generated Data");
		response.setHeader("Content-Transfer-Encoding", "binary");

		return "search_main/search_excel_suim";
	}//searchMainQuerySuimExcel

	@RequestMapping(value = "searchMainQueryPrimBizExcel", method = RequestMethod.POST)
	public String searchMainQueryPrimBizExcel(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response
			, SearchMainQueryVO searchVO, String reqPgNo) {

		logger.info("======= searchMainQueryPrimBizExcel =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("searchMainQueryPrimBizExcel - no permession : "+request.getRemoteAddr());
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

		if(!searchVO.getSearchMainSimpleQueryTxt().trim().equals("")){
			searchVO.setMinwonSearch("-1");
		}

		List<TopPrimBizRptHeadVO> primbizRptList = null;
		primbizRptList = sqlSession.selectList("SearchMainPrimbizMapper.searchMainPrimbizRptListExcel", searchVO);
//		
//		<!-- 담당 팀 -->											
//		<td>
//			${suimVO.ptnr_tm2_nm}
//		</td>
//		
		
		model.addAttribute("primbizRptList", primbizRptList);

		model.addAttribute("searchVO", searchVO);
		
		
		Date dt = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String now = sdf.format(dt);
		
		model.addAttribute("now", now);
		
		response.setHeader("Content-Disposition", "attachment;filename=primbizbook_"+now+"+.xls");
		response.setHeader("Content-Type", "application/vnd.ms-xls");
		response.setHeader("Content-Description", "JSP Generated Data");
		response.setHeader("Content-Transfer-Encoding", "binary");		

		return "search_main/search_excel_prim_biz";
	}//searchMainQueryPrimBizExcel

	@RequestMapping(value = "searchMainQuerySuit10Excel", method = RequestMethod.POST)
	public String searchMainQuerySuit10Excel(Model model, HttpSession session, HttpServletRequest request
			, SearchMainQueryVO searchVO, String reqPgNo) {

		logger.info("======= searchMainQuerySuit10Excel =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("searchMainQuerySuit10Excel - no permession : "+request.getRemoteAddr());
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

		List<SuimSuit_10VO> suitList10 = null;
		suitList10 = sqlSession.selectList("SearchMainSuit10Mapper.searchMainSuit10RptListExcel", searchVO);

		model.addAttribute("suitList10", suitList10);

		model.addAttribute("searchVO", searchVO);

		return "search_main/search_excel_suit10";
	}//searchMainQuerySuit10Excel

	@RequestMapping(value = "searchMainQuerySuit12Excel", method = RequestMethod.POST)
	public String searchMainQuerySuit12Excel(Model model, HttpSession session, HttpServletRequest request
			, SearchMainQueryVO searchVO, String reqPgNo) {

		logger.info("======= searchMainQuerySuit12Excel =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("searchMainQuerySuit12Excel - no permession : "+request.getRemoteAddr());
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

		List<SuimSuit_12VO> suimSuit12List = null;
		suimSuit12List = sqlSession.selectList("SearchMainSuit12Mapper.searchMainSuit12RptListExcel", searchVO);

		model.addAttribute("suimSuit12List", suimSuit12List);

		model.addAttribute("searchVO", searchVO);

		return "search_main/search_excel_suit12";
	}//searchMainQuerySuit12Excel

	@RequestMapping(value = "searchMainQuerySuit17Excel", method = RequestMethod.POST)
	public String searchMainQuerySuit17Excel(Model model, HttpSession session, HttpServletRequest request
			, SearchMainQueryVO searchVO, String reqPgNo) {

		logger.info("======= searchMainQuerySuit17Excel =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("searchMainQuerySuit17Excel - no permession : "+request.getRemoteAddr());
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

		List<SuimSuit_17VO> suimSuit17List = null;
		suimSuit17List = sqlSession.selectList("SearchMainSuit17Mapper.searchMainSuit17RptListExcel", searchVO);

		model.addAttribute("suimSuit17List", suimSuit17List);

		model.addAttribute("searchVO", searchVO);

		return "search_main/search_excel_suit17";
	}//searchMainQuerySuit17Excel

	@RequestMapping(value = "searchMainQuerySuit18Excel", method = RequestMethod.POST)
	public String searchMainQuerySuit18Excel(Model model, HttpSession session, HttpServletRequest request
			, SearchMainQueryVO searchVO, String reqPgNo) {

		logger.info("======= searchMainQuerySuit18Excel =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("searchMainQuerySuit18Excel - no permession : "+request.getRemoteAddr());
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

		List<SuimSuit_18VO> suitList18 = null;
		suitList18 = sqlSession.selectList("SearchMainSuit18Mapper.searchMainSuit18RptListExcel", searchVO);

		model.addAttribute("suitList18", suitList18);

		model.addAttribute("searchVO", searchVO);

		return "search_main/search_excel_suit18";
	}//searchMainQuerySuit18Excel
	
	
	@RequestMapping(value = "searchMainQueryCancelExcel", method = RequestMethod.POST)
	public String searchMainQueryCancelExcel(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response
			, SearchMainQueryVO searchVO, String reqPgNo) {

		logger.info("======= searchMainQueryCancelExcel =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("searchMainQuerySuit18Excel - no permession : "+request.getRemoteAddr());
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

		
		List<SuimRptCancelVO> cancelList = null;
		cancelList = sqlSession.selectList("SearchMainSuimMapper.searchMainCancelListExcel", searchVO);
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String toDate = dateFormat.format(new Date());
		
		String fileName = "";
		if ( "32".equals(searchVO.getStateSearch()) ){
			fileName = "위임취소-단순위임취소-"+toDate+".xls";;
		}else{
			fileName = "위임취소-서면일반전환-"+toDate+".xls";;
		}
		//순서가 바뀌면 인코딩 되어 화면상에서 인코딩 된 값 나옴
		model.addAttribute("fileName", fileName);
		
		try {
			fileName = java.net.URLEncoder.encode(fileName,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		response.setHeader("Content-Disposition", "attachment;filename="+fileName);
		response.setHeader("Content-Type", "application/vnd.ms-xls");
		response.setHeader("Content-Description", "JSP Generated Data");
		response.setHeader("Content-Transfer-Encoding", "binary");
		
		model.addAttribute("cancelList", cancelList);
		
		model.addAttribute("searchVO", searchVO);

		return "search_main/search_excel_cancel";
	}//searchMainQuerySuit18Excel
		
	
	/*
	 * ***************************************
	 * Method ID : makeFourNumberWithZero
	 * Method Name :  makeFourNumberWithZero
	 * Description : 0을 포함한 4자리 숫자로 채움
	 * 
	 * 번호 1 :  
	 * Author : 이선형
	 * Date : 20160614
	 * ***************************************
	 * */

	public static String makeFourNumberWithZero(String maxSuimNo) {
		if(maxSuimNo.length() == 1){
			maxSuimNo = "000"+maxSuimNo;
		}else if(maxSuimNo.length() == 2){
			maxSuimNo = "00"+maxSuimNo;
		}else if(maxSuimNo.length() == 3){
			maxSuimNo = "0"+maxSuimNo;
		}
		return maxSuimNo;
	}	

}//end of class
