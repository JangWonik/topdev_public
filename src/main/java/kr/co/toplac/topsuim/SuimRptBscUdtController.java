package kr.co.toplac.topsuim;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
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
import kr.co.toplac.sysadm.AprvUserInsViewVO;
import kr.co.toplac.sysadm.SysAdmCodeDicVO;
import kr.co.toplac.toprptinv.TopRptInvDtlViewVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.etc.Damo;
import kr.co.toplac.util.etc.SplitPhoneNo;
import kr.co.toplac.util.mail.Sendmail;

@Controller
public class SuimRptBscUdtController {

private static final Logger logger = LoggerFactory.getLogger(SuimRptBscUdtController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
    @Autowired
    private CodeDicService service;
	/*
	*********************************************************
	* Program ID	: suimRptBscUdtPage
	* Program Name	: suimRptBscUdtPage
	* Description	: 보고서 기본정보 수정 페이지 호출
	* Author		: 이선형
	* Date			: 2016.05.18.
	*********************************************************
	*/
	@RequestMapping(value = "suimRptBscUdtPage", method = RequestMethod.GET)
	public String suimRptBscUdtPage(Model model, String rid, HttpSession session) {
		
		logger.info("suimRptBscUdtPage");
		
		SuimRptCompositeVO rptOne = sqlSession.selectOne("SuimBookUdtMapper.getSuimBookOne", rid);
		
		SplitPhoneNo telSplit = new  SplitPhoneNo();
		
		/*login session*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");

		/*login confirm*/
		if( (mbrAuthVo == null) || (session.getAttribute("user_no_Session") == null) ){
			logger.info("suimRptBscDtl - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			model.addAttribute("authFlag", "logout");
			return "top_suim/suim_rpt_bsc_dtl";
		}

		HashMap<String,String> map =  new HashMap<String,String>();
		map.put("suim_rpt_no", rid);
		map.put("user_no_session", mbrVo.getUser_no());

		//불필요한 SELECT 주석처리.
		//SuimRptCompositeVO suimListDtlVO = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", map);
		
		/** 보고서 대상 구분 편집 권한 **/
		HashMap<String,String> lsAdminMap =  new HashMap<String,String>();
		lsAdminMap.put("user_no", ""+session.getAttribute("user_no_Session"));
		//lsAdminMap.put("team_id", suimListDtlVO.getTeam_id());
		lsAdminMap.put("team_id", rptOne.getTeam_id());
		String ls_admin24 = sqlSession.selectOne("SuimBookDtlMapper.getAuth24", lsAdminMap);
		model.addAttribute("auth24Flag",ls_admin24);		
		
		Damo damo = new Damo(); //디아모 암호화 적용 클래스 생성
		String strDec = "";
		
		/*계약자 핸드폰*/
		if(rptOne.getPolicyholder_tel() != null && !rptOne.getPolicyholder_tel().equals("")){
			strDec = damo.decodeDamo(rptOne.getPolicyholder_tel());
			rptOne.setPolicyholder_tel(strDec);
			telSplit.splitPhoneNo(model, rptOne.getPolicyholder_tel(), "-", "policyholder_tel");	
		}else{
			model.addAttribute("policyholder_tel_1", "");
			model.addAttribute("policyholder_tel_2", "");
			model.addAttribute("policyholder_tel_3", "");
		}
		
		/*피보험자 핸드폰*/
		if(rptOne.getBeneficiary_tel() != null && !rptOne.getBeneficiary_tel().equals("")){
			strDec = damo.decodeDamo(rptOne.getBeneficiary_tel());
			rptOne.setBeneficiary_tel(strDec);
			telSplit.splitPhoneNo(model, rptOne.getBeneficiary_tel(), "-", "beneficiary_tel");			
		}else{
			model.addAttribute("beneficiary_tel_1", "");
			model.addAttribute("beneficiary_tel_2", "");
			model.addAttribute("beneficiary_tel_3", "");
			
		}
		
		/*피해자 핸드폰*/
		if(rptOne.getDamaged_tel() != null && !rptOne.getDamaged_tel().equals("")){
			strDec = damo.decodeDamo(rptOne.getDamaged_tel());
			rptOne.setDamaged_tel(strDec);
			telSplit.splitPhoneNo(model, rptOne.getDamaged_tel(), "-", "damaged_tel");			
		}else{
			model.addAttribute("damaged_tel_1", "");
			model.addAttribute("damaged_tel_2", "");
			model.addAttribute("damaged_tel_3", "");
		}
		
		
		/*계약자 주민번호*/
		if(rptOne.getPolicyholder_ssn() != null && !rptOne.getPolicyholder_ssn().equals("")){
			
			strDec = damo.decodeDamo(rptOne.getPolicyholder_ssn());
			rptOne.setPolicyholder_ssn(strDec);
			/*
			String[] polSsnId = rptOne.getPolicyholder_ssn().split("-");
			if( polSsnId.length > 1){
				model.addAttribute("polSsn1Id", polSsnId[0]);
				model.addAttribute("polSsn2Id", polSsnId[1]);
			}
			*/
		}else{
			model.addAttribute("polSsn1Id", "");
			model.addAttribute("polSsn2Id", "");
		}
		
		/*피보험자 주민번호*/
		if(rptOne.getBeneficiary_ssn() != null && !rptOne.getBeneficiary_ssn().equals("")){
			strDec = damo.decodeDamo(rptOne.getBeneficiary_ssn());
			rptOne.setBeneficiary_ssn(strDec);
			/*
			String[] benSsnId = rptOne.getBeneficiary_ssn().split("-");
			if( benSsnId.length > 1){
				model.addAttribute("benSsn1Id", benSsnId[0]);
				model.addAttribute("benSsn2Id", benSsnId[1]);
			}
			*/
		}else{
			model.addAttribute("benSsn1Id", "");
			model.addAttribute("benSsn2Id", "");
		}
		
		/*사고일 0 일 경우*/
		if(rptOne.getAccident_date() != null){
			if(!rptOne.getAccident_date().equals("") && !(rptOne.getAccident_date() != null)){
				if(rptOne.getAccident_date().equals("0")){
					rptOne.setAccident_date("");
				}
			}			
		}
		
		/*수임일 0 일 경우*/
		if(rptOne.getReg_date() != null){
			if(!rptOne.getReg_date().equals("") && !(rptOne.getReg_date() != null)){
				if(rptOne.getReg_date().equals("0")){
					rptOne.setReg_date("");
				}
			}			
		}
		
		/*일반건 전환일 0일 경우 */
		if(rptOne.getTrans_date() != null) {
			if(!rptOne.getTrans_date().equals("") && !(rptOne.getTrans_date() != null)) {
				if(rptOne.getTrans_date().equals("0")) {
					rptOne.setTrans_date("");
				}
			}			
		}
		
        //코드 리스트 가져오기
        SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();
        codeVo.setTbl_nm("top_rpt_head");
        codeVo.setCol_nm("speed_type");
        List<SysAdmCodeDicVO> speedCodeList = service.codeList(codeVo);
		
		//기준 업무량 코드 
		Calendar cal = Calendar.getInstance();    
		cal.setTime(new Date());            
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
		String today = df.format(cal.getTime());
//		String today = "2018-12-16";
		
		int year = Integer.parseInt(today.split("-")[0]);
		int month = Integer.parseInt(today.split("-")[1]);
		int day = Integer.parseInt(today.split("-")[2]);
		
		if (month == 12 && day > 15){
			++year;
		}
        codeVo.setTbl_nm("top_rpt_head");
        codeVo.setCol_nm("workload_type_"+year);
        List<SysAdmCodeDicVO> workloadTypeList = service.codeList2(codeVo);
        
        model.addAttribute("speedCodeList", speedCodeList);
        model.addAttribute("workloadTypeList", workloadTypeList);
		model.addAttribute("rptOne", rptOne);
		
		return "top_suim/suim_rpt_bsc_udt";
	}
	
	
	/*
	 * ***************************************
	 * Method ID : rptBscUdt
	 * Method Name :  rptBscUdt
	 * Description : 보고서 기본정보 수정 
	 * 
	 * Author : 이선형
	 * Date : 20160524
	 * ***************************************
	 * */
	@RequestMapping(value = "rptBscUdt", method = RequestMethod.POST)
	public void rptBscUdt(Model model, HttpSession session, SuimRptUdtViewVO suimRptUdtViewVo, PrintWriter out) {
		
		logger.info("=========== rptBscUdt =============");		
		
		//보험사 세부코드 추가
		if( suimRptUdtViewVo.getPtnrIdSub() == null ) {
			suimRptUdtViewVo.setPtnrIdSub("0");
		}else{
			suimRptUdtViewVo.setPtnrIdSub(suimRptUdtViewVo.getPtnrIdSub());
		}
		
		//보험사 계약기간 코드 추가
		if( suimRptUdtViewVo.getPeriodFlag() == null ) {
			suimRptUdtViewVo.setPeriodFlag("0");
		}else{
			suimRptUdtViewVo.setPeriodFlag(suimRptUdtViewVo.getPeriodFlag());
		}
		
		/*전화번호 빈칸 입력 시 구분자 없애기*/
		if(suimRptUdtViewVo.getDamagedTel().equals("--")){
			suimRptUdtViewVo.setDamagedTel("");
		}
		if(suimRptUdtViewVo.getBeneficiaryTel().equals("--")){
			suimRptUdtViewVo.setBeneficiaryTel("");
		}
		if(suimRptUdtViewVo.getPolicyholderTel().equals("--")){
			suimRptUdtViewVo.setPolicyholderTel("");
		}
		
		/*추정 손해액, 추정 수수료 미입력시 0 으로 세팅*/
		/*
		if(suimRptUdtViewVo.getCommissionEstimated() == null || suimRptUdtViewVo.getCommissionEstimated().equals("")){
			suimRptUdtViewVo.setCommissionEstimated("0");
		}
		
		if(suimRptUdtViewVo.getAmtEstimatedDamage() == null || suimRptUdtViewVo.getAmtEstimatedDamage().equals("")){
			suimRptUdtViewVo.setAmtEstimatedDamage("0");
		}
		*/
		if(suimRptUdtViewVo.getSuimRptType2() == null){
			suimRptUdtViewVo.setSuimRptType2("1");
		}
		
		Damo damo = new Damo(); //디아모 암호화 적용 클래스 생성
		/*
		if (suimRptUdtViewVo.getPolicyholderSsn() != null || suimRptUdtViewVo.getPolicyholderSsn() != ""){
			suimRptUdtViewVo.setPolicyholderSsn( damo.encodeDamo(suimRptUdtViewVo.getPolicyholderSsn()) );	
		}
		*/
		if (suimRptUdtViewVo.getPolicyholderTel() != null || suimRptUdtViewVo.getPolicyholderTel() != ""){
			suimRptUdtViewVo.setPolicyholderTel( damo.encodeDamo(suimRptUdtViewVo.getPolicyholderTel()) );	
		}
		/*
		if (suimRptUdtViewVo.getBeneficiarySsn() != null || suimRptUdtViewVo.getBeneficiarySsn() != ""){
			suimRptUdtViewVo.setBeneficiarySsn( damo.encodeDamo(suimRptUdtViewVo.getBeneficiarySsn()) );	
		}
		*/
		if (suimRptUdtViewVo.getBeneficiaryTel() != null || suimRptUdtViewVo.getBeneficiaryTel() != ""){
			suimRptUdtViewVo.setBeneficiaryTel( damo.encodeDamo(suimRptUdtViewVo.getBeneficiaryTel()) );	
		}
		if (suimRptUdtViewVo.getDamagedTel() != null || suimRptUdtViewVo.getDamagedTel() != ""){
			suimRptUdtViewVo.setDamagedTel( damo.encodeDamo(suimRptUdtViewVo.getDamagedTel()) );	
		}

		if(suimRptUdtViewVo.getAmtSelfPay() != null && "".equals(suimRptUdtViewVo.getAmtSelfPay())){
            suimRptUdtViewVo.setAmtSelfPay(null);
        }

		if(suimRptUdtViewVo.getAmtCompensationLimit() != null && "".equals(suimRptUdtViewVo.getAmtCompensationLimit())){
            suimRptUdtViewVo.setAmtCompensationLimit(null);
        }
		
		if ( "null".equals(  String.valueOf(suimRptUdtViewVo.getWorkloadType()) ) ){
			suimRptUdtViewVo.setWorkloadType("0");
			suimRptUdtViewVo.setWorkloadEa("0");
			
		}
		
		//스피드 구분이 변경 될 시, 평가건수 및 인보이스가 정보 변경되야함
		if ( !suimRptUdtViewVo.getBefSpeedType().equals(suimRptUdtViewVo.getSpeedType()) ){

			HashMap<String,Object> map = new HashMap<String,Object>();
			String SpeedType = suimRptUdtViewVo.getSpeedType();
			String suimRptEa = "";
			String invoiceBasic = "";
			
			switch (SpeedType){
				case "0" 	: suimRptEa = "0"; invoiceBasic = "0"; break;		
				case "1" 	: suimRptEa = "0.1"; invoiceBasic = "40000"; break;	//간이(단순입력)	
				case "11" 	: suimRptEa = "0.1"; invoiceBasic = "40000"; break;	//간이(타사)
				case "12" 	: suimRptEa = "0.1"; invoiceBasic = "40000"; break;	//간이(구내치료비)
				case "13" 	: suimRptEa = "0.1"; invoiceBasic = "40000"; break;	//간이(홀인원)
				case "2" 	: suimRptEa = "0.1"; invoiceBasic = "100000"; break;	//대인
				case "3" 	: suimRptEa = "0.1"; invoiceBasic = "80000"; break;	//대물
				case "4" 	: suimRptEa = "0.1"; invoiceBasic = "80000"; break;	//재물
				case "41" 	: suimRptEa = "0.1"; invoiceBasic = "80000"; break;	//재물(6대가전)
				case "42" 	: suimRptEa = "0.1"; invoiceBasic = "80000"; break;	//재물(도난)
				case "43" 	: suimRptEa = "0.1"; invoiceBasic = "80000"; break;	//재물(골프용품)
				case "44" 	: suimRptEa = "0.1"; invoiceBasic = "80000"; break;	//재물(풍수재)
				case "45" 	: suimRptEa = "0.1"; invoiceBasic = "80000"; break;	//재물(여행자)
				case "46" 	: suimRptEa = "0.1"; invoiceBasic = "80000"; break;	//재물(위로금)
				case "47" 	: suimRptEa = "0.1"; invoiceBasic = "80000"; break;	//재물(일반)
				case "5" 	: suimRptEa = "0.1"; invoiceBasic = "100000"; break;	//대인+대물
				case "7" 	: suimRptEa = "0.1"; invoiceBasic = "40000"; break;	//면책
				case "6" 	: suimRptEa = "0.033"; invoiceBasic = "20000"; break;	//임의종결
			}
			
			map.put("suimRptNo", suimRptUdtViewVo.getSuimRptNo());
			map.put("suimRptEa",suimRptEa);
			map.put("invoiceBasic",invoiceBasic);
			
			
			sqlSession.update("SuimBookUdtMapper.udtRptHeadForSpeedType", map);
			sqlSession.update("SuimBookUdtMapper.udtInvoiceForSpeedType", map);
		}
		

		/*번호 1*/
		int resultHead = sqlSession.update("SuimBookUdtMapper.rptBscHeadUdt", suimRptUdtViewVo);
		
		/*번호 2*/
		int resultBody = sqlSession.update("SuimBookUdtMapper.rptBscBodyUdt", suimRptUdtViewVo);
		
		int result = 0;
		if( (resultHead >0) && (resultBody >0)){
			result = 1;
			SuimCommon SuimCommon = new SuimCommon();
    		SuimCommon.insSuimRptLog(sqlSession,"suim_update", suimRptUdtViewVo.getSuimRptNo());
		}
		
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : editeEndInfoOk
	 * Method Name :  editeEndInfoOk
	 * Description : 보고서 종결 내용 업데이트
	 *   
	 * Author : 이선형
	 * Date : 20160613
	 * ***************************************
	 * */
	@RequestMapping(value = "editeEndInfoOk", method = RequestMethod.POST)
	public void editeEndInfoOk(Model model, HttpSession session, SuimRptEndViewVO suimRptEndViewVo, HttpServletResponse response) {
		
		logger.info("editeEndInfoOk");
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		
		PrintWriter out = null;
		
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		int resultHead= sqlSession.update("SuimBookUdtMapper.rptEndHeadUdt", suimRptEndViewVo);
		int resultBody= sqlSession.update("SuimBookUdtMapper.rptEndBodyUdt", suimRptEndViewVo);
		
		if( (resultHead > 0) && (resultBody >0) ){
			out.print(1);
		}else{
			out.print(0);
		}
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : editeInvInfoOk
	 * Method Name :  editeInvInfoOk
	 * Description : 보고서 종결 내용- 인보이스 업데이트
	 *   
	 * Author : 이선형
	 * Date : 20160712	 * 
	 * ***************************************
	 * */
	@RequestMapping(value = "editeInvInfoOk", method = RequestMethod.POST)
	public void editeInvInfoOk(Model model, HttpSession session, TopRptInvDtlViewVO topRptInvDtlViewVo, HttpServletResponse response) {
	
		logger.info("editeInvInfoOk");
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		
		PrintWriter out = null;
		
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}		
		
		int result = 0;
		
		/**
		 * top_rpt_invoice 에 suim_rpt_no 로 데이터가 없는 경우가 있어 별도 처리함
		 * by top3009 
		 * 20210713 
		 */
		
		//인보이스 테이블에 데이터가 있는 지 확인한다.
		int nChk = sqlSession.selectOne("SuimRegInsMapper.suimInvoiceChk",topRptInvDtlViewVo.getSuimRptNo());
		String tempInvoiceNo = "";
		
		//인보이스 테이블 정보가 없는 경우 새로 행을 추가하고 갱신한다.
		if( nChk == 0 ) {
			result = sqlSession.insert("SuimRegInsMapper.suimInsInvoice", topRptInvDtlViewVo.getSuimRptNo());
			tempInvoiceNo = sqlSession.selectOne("SuimRegInsMapper.suimInvoiceNoOne",topRptInvDtlViewVo.getSuimRptNo());
			topRptInvDtlViewVo.setRptInvNo(tempInvoiceNo);
			result = sqlSession.update("SuimBookUdtMapper.rptEndInvUdt", topRptInvDtlViewVo);
		}else{		//갱신
			result = sqlSession.update("SuimBookUdtMapper.rptEndInvUdt", topRptInvDtlViewVo);			
		}
		
		if( result > 0 ) {
			sqlSession.insert("InvoiceDtlMapper.invoiceLogInsForRptDtl", topRptInvDtlViewVo);
		}
		
		//결재수수료 사용여부를 체크 한다.
		String approvalUseFlag = topRptInvDtlViewVo.getApprovalUseFlag();
		String approvalUserNo = topRptInvDtlViewVo.getApprovalUserNo();
		String approvalPrice = topRptInvDtlViewVo.getApprovalPrice();
		String approvalUserTeamId = "";
		
		if( "1".endsWith(approvalUseFlag) ) {
			//결재수수료 결재자 팀아이디를 가져온다.
			approvalUserTeamId = sqlSession.selectOne("topVacationMapper.selectTeamId",topRptInvDtlViewVo.getApprovalUserNo());
			topRptInvDtlViewVo.setApprovalTeamId(approvalUserTeamId);
			
			//공동수행 테이블에 결재수수료 정보가 있는지 체크한다.
			int nApChk = sqlSession.selectOne("SuimRptCollaboMapper.selectCollaboApprovalCnt", topRptInvDtlViewVo.getSuimRptNo());
						
			if( nApChk == 0 ) {			//기존 공동수행 테이블에 정보를 추가한다.
				sqlSession.insert("SuimRptCollaboMapper.insertCollaboApproval", topRptInvDtlViewVo);
			}else{							//기존 공동수행테이블에 정보를 수정한다.
				sqlSession.update("SuimRptCollaboMapper.updateCollaboApproval", topRptInvDtlViewVo);
			}
			
		}
		
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : actionReportOk
	 * Method Name :  actionReportOk
	 * Description : 보고서 결재라인 동작 ( 반려, 종결, )
	 *   
	 * Author : 이선형
	 * Date : 20160616
	 * ***************************************
	 * */
	@RequestMapping(value = "actionReportOk", method = RequestMethod.POST)
	public synchronized void actionReportOk(Model model,String action, HttpSession session, PrintWriter out, String suimRptNo) {
	
		logger.info("actionReportOk");
		
		//현재 로그인 사용자 정보						
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		int result = 0;
		
		String suim_rpt_no = suimRptNo;
		SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", suim_rpt_no);

		/*이 보고서의 미결 협조건 수 추출*/
		int suimRptHelpNotEndCount = sqlSession.selectOne("HelpBscMapper.getHelpNotEndCountForRptEnd", suimRptNo);
		
		/*이 보고서의 협조건 수 추출*/
		List<SuimRptHelpBscVO> suimRptHelpList = sqlSession.selectList("HelpBscMapper.getHelpListForRptEnd", suimRptNo);
		
		/*이 보고서의 공동 조사자 수 추출*/
		List<SuimRptCollaboVO> suimRptCollaboList = sqlSession.selectList("HelpBscMapper.getCollaboListForRptEnd", suimRptNo);
		
		/*인보이스 정보 추출 시작*/
		TopRptInvDtlViewVO suimInvVO = sqlSession.selectOne("InvoiceDtlMapper.getInvoiceDtlForRptDtl", suim_rpt_no);
		/*인보이스 정보 추출 끝*/
		
		int nSuimRptState = 0;			//보고서 정보 갱신전 상태값 체크 플래그 (0:미결, 1:결재대기, 2:종결상태)		
		nSuimRptState = sqlSession.selectOne("SuimBookDtlMapper.getSuimRptStateNow", suimRptNo);		
		
		/*협조자 목록에 없는 공동조사자가 있을 경우*/
		/*
		int noMatchHelpCollaboCount = 0;
		boolean blockEndCausedHelpAndCollabo = false;
		for (int i = 0; i < suimRptHelpList.size(); i++) {
			
			for (int j = 0; j < suimRptCollaboList.size(); j++) {
				
				if(!suimRptHelpList.get(i).getAcceptId().equals(suimRptCollaboList.get(j).getUserId())){
					noMatchHelpCollaboCount++;
				}
			}
			
			if(noMatchHelpCollaboCount == suimRptCollaboList.size()){
				blockEndCausedHelpAndCollabo = true;
			}
			
			noMatchHelpCollaboCount = 0;
		}*/
		
		
		if(action.equals("returnRpt")){ //반려하기
			
			result = sqlSession.update("SuimBookUdtMapper.rptActionRptReturn", suimRptNo);

			//결재로그 Todo
			/*"insert into log_ls_report_action values('','$rid','$action','$member[no]','$ip_addr',$log_date)";*/
		}else if(action.equals("return_x")){ //반려 재결재하기

			result = sqlSession.update("SuimBookUdtMapper.rptActionRptReturnCancel", suimRptNo);
			//결재로그 Todo
			/*$sql="insert into log_ls_report_action values('','$rid','$action','$member[no]','$ip_addr',$log_date)";*/

		}else if(action.equals("end")){ //종결하기 일반
			
			/*협조건 미종결 건 있을 경우 종결 막기*/
			
			/*협조건 중 미결이 없을 경우 종결 진행*/
			if( !(suimRptHelpNotEndCount >0 )){
				
				/*협조건의 존재하나 공동조사자가 없을 경우 종결 막음 */
				if( (suimRptHelpList.size() > 0 ) && (suimRptCollaboList.size() ==0)){
					out.print(3);
				}else{		
					/*현재날짜계산*/
					Calendar cal = Calendar.getInstance();    
					cal.setTime(new Date());    
					
					DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
					String today = df.format(cal.getTime());
					String thisYear = today.substring(2, 4);
					String nextRptCloseNoStr = "";
					String nextCloseNo = "";
					
					if( suimVo.getSuimRptType1().equals("14") || suimVo.getSuimRptType1().equals("18") ){
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
					}else{
						
						/*이 보고서의 현재 종결No 앞자리 구하기 TF + 팀코드 + 연도2자리*/
						String searchStr = "TF"+suimVo.getTeam_id()+thisYear;
						
						/*차기 종결 번호 구하기 시작*/
						if(suimVo.getTeam_id().equals("6") || suimVo.getTeam_id().equals("8") || suimVo.getTeam_id().equals("9") || suimVo.getTeam_id().equals("10")
								|| suimVo.getTeam_id().equals("11")|| suimVo.getTeam_id().equals("13")|| suimVo.getTeam_id().equals("24")|| suimVo.getTeam_id().equals("38")
								|| suimVo.getTeam_id().equals("39")|| suimVo.getTeam_id().equals("40")|| suimVo.getTeam_id().equals("44")|| suimVo.getTeam_id().equals("43")){
	/* //notUse-2016.11.02.rjh
							String maxResultNo = sqlSession.selectOne("SuimBookDtlMapper.getNowResultNo1",searchStr); 
							if(maxResultNo == null){
								maxResultNo = "0";
							}
	*/
							HashMap<String, String> mapForAcceptSeqNo = new HashMap<String, String>();
							mapForAcceptSeqNo.put("suim_accept_seq_no", "");
							sqlSession.update("SuimBookDtlMapper.getNowResultNo12", mapForAcceptSeqNo);
							nextRptCloseNoStr = mapForAcceptSeqNo.get("suim_accept_seq_no");

							/*현재종결No 의 최신값에 +1 한 값으로 다음 종결No 구함 : nextRptCloseNoStr*/
							//nextRptCloseNoStr = nextRptCloseNoStr(maxResultNo);
							
						}else if(suimVo.getTeam_id().equals("12") || suimVo.getTeam_id().equals("14") || suimVo.getTeam_id().equals("27") 	){
	/* //notUse-2016.11.02.rjh
							String maxResultNo = sqlSession.selectOne("SuimBookDtlMapper.getNowResultNo2",searchStr); 
							if(maxResultNo == null){
								maxResultNo = "0";
							}
	*/
							HashMap<String, String> mapForAcceptSeqNo = new HashMap<String, String>();
							mapForAcceptSeqNo.put("suim_accept_seq_no", "");
							sqlSession.update("SuimBookDtlMapper.getNowResultNo22", mapForAcceptSeqNo);
							nextRptCloseNoStr = mapForAcceptSeqNo.get("suim_accept_seq_no");

							//nextRptCloseNoStr = nextRptCloseNoStr(maxResultNo);
						
						}else{
							
							HashMap<String,String> map = new HashMap<String,String>();
							
							map.put("team_id", suimVo.getTeam_id());
							map.put("searchStr", searchStr);
							String maxResultNo = sqlSession.selectOne("SuimBookDtlMapper.getNowResultNo3",map); 
							
							if(maxResultNo == null){
								maxResultNo = "0";
							}
							
							nextRptCloseNoStr = nextRptCloseNoStr(maxResultNo);
						}
						/*차기 종결 번호 구하기 끝*/
						nextCloseNo = "TF"+ suimVo.getTeam_id()+thisYear+"-"+nextRptCloseNoStr;
					}
					
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
					/* 보고서 종결시 종결시점 보조인, 손해사정사 정보 저장 시작 */	
					Map<String, Object> paramMap = new HashMap<String, Object>();
					
					paramMap.put("user_no", String.valueOf(suimVo.getUser_no()));					
					
			        List<Map<String, Object>> certiManagerReportUser = null;		//담당손해사정사 목록
					List<Map<String, Object>> certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiMemberInfo", paramMap);
	            	
	            	int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
	            	
	            	nCertiManagerCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiManagerCnt", paramMap);
	            	
	            	if( nCertiManagerCnt > 0 ) {			//담당손해사정사가 있는 경우
	            		certiManagerReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiManagerList", paramMap);
	            		for( int i=0; i < certiManagerReportUser.size(); i++) {
	            			certiReportUser.add(certiManagerReportUser.get(i));		//보고서 하단에 들어갈 담당자 정보에 담당손해사정서를 추가한다.
	            		}
	            	}
	            	
	            	//top_rpt_certi_end 테이블에 추가한다.
	            	if( certiReportUser != null ) {
	            		//기존에 등록된 정보 삭제후 추가한다.
	            		sqlSession.update("RptIssueMapper.deleteTopRptCertiEnd", suimRptNo);
	                	for( int k=0;  k < certiReportUser.size(); k++ ) {
	                    	//CommonUtils.printMap(certiReportUser.get(k));
	                    	certiReportUser.get(k).put("suim_rpt_no", suimRptNo);
	                    	sqlSession.insert("RptIssueMapper.insertTopRptCertiEnd", certiReportUser.get(k));
	                    	
	                    }
	                }
					/* 보고서 종결시 종결시점 보조인, 손해사정사 정보 저장 끝 */
					
					//결재완료(종결) 알림메일 발송 시작
					//인보험, 물보험 서면심사 제외
					// 결재 메일 알림은 오픈 제외 20211020 by top3009
					/**
					if( !( suimVo.getSuim_rpt_type1().equals("3") || suimVo.getSuim_rpt_type1().equals("4") || suimVo.getSuim_rpt_type1().equals("14") || suimVo.getSuim_rpt_type1().equals("15") || suimVo.getSuim_rpt_type1().equals("16") || suimVo.getSuim_rpt_type1().equals("17") || suimVo.getSuim_rpt_type1().equals("18") ) ){
						//결재요청자가 종결권한이 있는지 확인
						String sangsinUserNo = suimVo.getUser_no();
						String sangsinUserName = suimVo.getUser_name();
						String sangsinEmail = suimVo.getEmail();
						
						String lsAdmin7 = sqlSession.selectOne("TopLoginMapper.getLsAdmin7", sangsinUserNo);
						
						lsAdmin7 = lsAdmin7.replaceAll("\\|", "");				//"|"를 전부 제거하고 값이 없는경우 (권한이 없는경우)만 결재요청 Email 을 발송한다.
						
						if( "".equals(lsAdmin7) ) {				//종결권한이 없는 직원인 경우
							
							//결재자 정보							
							//String sManagerNo = String.valueOf(mbrVo.getUser_no());							
							String sManagerName = String.valueOf(mbrVo.getUser_name());
							String sManagerEmail = String.valueOf(mbrVo.getEmail());
							String sManagerHandphone = String.valueOf(mbrVo.getHandphone());							
							
							//결재요청 메일 내용 시작
							String sFromName = sManagerName;
							String sFromAddress = sManagerEmail;
							String sToAddress = sangsinEmail;
							String sSubject = "[접수번호 : "+suimVo.getSuim_accept_no()+"] 보고서 결재완료";
							
							String sContent = "<table style='border-collapse:collapse;width:400px;font-size:12px;font-weight:bold;letter-spacing:1px;' border='1'>" + 
									"	<tr>" + 
									"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#e0f8f1'>상태</td>" + 
									"		<td height='30' style='text-align: left; padding-left: 10px;'><font color='green'>결재완료</font></td>" + 
									"	</tr>" + 
									"	<tr>" + 
									"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#e0f8f1'>접수번호</td>" + 
									"		<td height='30' style='text-align: left; padding-left: 10px;'>"+suimVo.getSuim_accept_no()+"</td>" + 
									"	</tr>" + 
									"	<tr>" + 
									"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#e0f8f1'>결재자</td>" + 
									"		<td height='30' style='text-align: left; padding-left: 10px;'>"+sManagerName+" ("+sManagerHandphone+")</td>" + 
									"	</tr>" + 
									"	<tr>" + 
									"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#e0f8f1'>결재요청자</td>" + 
									"		<td height='30' style='text-align: left; padding-left: 10px;'>"+sangsinUserName+"</td>" + 
									"	</tr>" + 
									"  </table>";							
							//결재요청 메일 내용 끝
							
							Sendmail sendmail = new Sendmail();
							try {
								//알림메일 발송
								sendmail.send( sFromName, sFromAddress, sToAddress, sSubject, sContent, "", "" );								
								logger.info("Sendmail End Submit : "+sToAddress +" : "+ suimVo.getSuim_accept_no());
							} catch (Exception e) {
								System.out.println("Sendmail End Submit : "+e.getMessage());
							}
														
						}
						
					}
					**/
					//결재완료(종결) 알림메일 발송 끝					
					// 결재 메일 알림은 오픈 제외 20211020 by top3009
					
					//결재로그 Todo
				}
				
			
			}else{  /*협조건 중 미결이 있을 경우 종결 취소*/
				out.print(2);
			}
		
		}else if(action.equals("end19")){ //종결하기 AIA
			
			/*협조건 중 미결이 없을 경우 종결 진행*/
			if( !(suimRptHelpNotEndCount >0 )){
				result = sqlSession.update("SuimBookUdtMapper.rptActionRptEnd19", suimRptNo);
				
			}else{
				out.print(2);
			}
			//결재로그 Todo
			
		}else if(action.equals("submit")){ //결재하기
			
			//인보험 조사자 1일 5건까지 가능 (일주일 안된건 미포함)
			//매월 1일~15일 사이건만 체크
			
			int chkDay = 18;
			int hanHwaChkDay = 10;
			int heungChkDay = 10;
			int ligChkDay = 15;
			
			/*현재날짜계산 - 7일 전, 1일 후, 오늘 */
			Calendar cal = Calendar.getInstance();    
			cal.setTime(new Date());    
			cal.add(Calendar.DATE, -7);
			
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
			String dayBefore7 = df.format(cal.getTime());
			
			cal.setTime(new Date());
			String today = df.format(cal.getTime());
			
			cal.setTime(new Date());
			cal.add(Calendar.DATE, 1);
			String dayAfter1 = df.format(cal.getTime());
			
			/*건 구분이 인보험이면서 현재 날이 마감일(16) 전일 경우*/ 
			if( (suimVo.getSuim_rpt_type1().equals("3") || suimVo.getSuim_rpt_type1().equals("4")) 
					&& ( Integer.parseInt(today.substring(today.lastIndexOf("-")+1,today.length())) < chkDay) ){
				
				HashMap<String,String> map = new HashMap<String,String>();
				map.put("user_no", suimVo.getUser_no());
				map.put("dayBefore7", dayBefore7);
				map.put("today", today);
				map.put("dayAfter1", dayAfter1);
				
				/*이 담당자로 종결된 건들이 등록일이 7일 이내이면서 제출일이 오늘과 내일 사이로 입력되어있는 건의 수 :  이 개수가 5를 초과하면 상신을 못함*/
				int latestSubCount = sqlSession.selectOne("SuimBookDtlMapper.latestSubCountForRptSub", map);
				
				/*이 건의 수임 등록일이 7일 이내일 경우*/
				boolean is7DaysIn = false;
				
				Calendar c1 = Calendar.getInstance();
				Calendar c2 = Calendar.getInstance();
				
				String[] dayBefore7Split = dayBefore7.split("-");
				String[] regDateSplit = suimVo.getReg_date().split("-");
								
				c1.set( Integer.parseInt(regDateSplit[0]), Integer.parseInt(regDateSplit[1]), Integer.parseInt(regDateSplit[2]) );
				c2.set(Integer.parseInt(dayBefore7Split[0]), Integer.parseInt(dayBefore7Split[1]), Integer.parseInt(dayBefore7Split[2]) );
				
				/*c1 날짜가 c2 날짜 보다 이전이냐*/ 
				if (c1.before(c2)){
					is7DaysIn = true;
				}

				if( is7DaysIn && (latestSubCount >= 5) ){ 
					out.print(4);
					return;
				}
			}//end 건 구분이 인보험이면서 현재 날이 마감일(16) 전일 경우
			
			/*인보험 특정보험사 중간보고서 유무 확인 시작*/
			if( (suimVo.getSuim_rpt_type1().equals("3") || suimVo.getSuim_rpt_type1().equals("4"))  ){
				
				/*최종 중간 보고서 파일 업로드한 날짜*/
				
				String latestInterimSubDate = sqlSession.selectOne("SuimRptSiteMapper.latestInterimSubDate", suimRptNo);
				String sDate = "";
				
				/*중간 보고서 제출일 (or 수임 등록일) 과 현재 사이의 일수 차이를 계산 시작.*/
				if(latestInterimSubDate != null){
					if(!latestInterimSubDate.equals("") && !latestInterimSubDate.equals("1970-01-01")){
						sDate = latestInterimSubDate;
					}else{
						sDate = suimVo.getReg_date();
					}					
				}else{
					sDate = suimVo.getReg_date();
				}
				
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				
				Date beginDate = null;
				try {
					beginDate = formatter.parse(sDate);
				} catch (ParseException e) {
					e.printStackTrace();
				}
			    Date endDate = null;
				try {
					endDate = formatter.parse(today);
				} catch (ParseException e) {
					e.printStackTrace();
				}
				
				long timeDiffer = (endDate.getTime() - beginDate.getTime())/(24*3600*1000);
				
				/*중간 보고서 제출일 (or 수임 등록일) 과 현재 사이의 일수 차이를 계산 끝.*/
				
				/*한화 손해는 10일 이내에 중간 보고서를 제출해야 상신 가능*/
				if( suimVo.getPtnr_id().equals("12") && (timeDiffer > hanHwaChkDay) ){
					out.print(5);
					return;
				}
				
				/*흥국 생명은 10일 이내에 중간 보고서를 제출해야 상신 가능*/
				if( suimVo.getPtnr_id().equals("27") && (timeDiffer > heungChkDay) ){
					out.print(6);
					return;
				}
				
//				/*LIG는 15일 이내에 중간 보고서를 제출해야 상신 가능*/
//				if( suimVo.getPtnr_id().equals("10") && (timeDiffer > ligChkDay) ){
//					out.print(7);
//					return;
//				}
			}/*인보험 특정보험사 중간보고서 유무 확인 끝*/
			
			/*협조건 중 미결이 없을 경우 결재 진행*/
			if( !(suimRptHelpNotEndCount >0 )){
				
				/*협조건의 존재하나 공동조사자가 없을 경우 상신 막음 */
				if( (suimRptHelpList.size() > 0 ) && (suimRptCollaboList.size() ==0)){
					out.print(3);
					return;
				}else{
					
					/*종결파일 유무 확인 후 결재 진행 : 종결파일은 파일명에 '손사' or '종결' 단어가 반듯이 포함되어야함*/
					//서면심사가 아닌경우만 파일 체크를 한다.
					
					//if(!suimVo.getSuimRptType1().equals("14")) {
					if( !(suimVo.getSuimRptType1().equals("14") || suimVo.getSuimRptType1().equals("15") || suimVo.getSuimRptType1().equals("16") || suimVo.getSuimRptType1().equals("17") || suimVo.getSuimRptType1().equals("18") || suimVo.getSuimRptType1().equals("19") ) ) {
						
						int filnalFileYn = sqlSession.selectOne("SuimBookDtlMapper.getFinalRptFileYn",suimVo.getSuim_rpt_no());
						if(!(filnalFileYn >0)){
							out.print(9);
							return;
						}
						
					}					
					
					/*결재자 정보 추출*/
					String taskCode = "";
					String taskVal = "";
					
					if(suimVo.getSuim_rpt_type1().equals("3") || suimVo.getSuim_rpt_type1().equals("4")){
						taskVal = "4종종결";
					}else{
						taskVal = "1종종결";
					}
					
					taskCode = sqlSession.selectOne("CodeDicInsMapper.getColCodeForRptSub", taskVal);
					if(taskCode != null){
						AprvUserInsViewVO aprvUserInsViewVo = new AprvUserInsViewVO();
						aprvUserInsViewVo.setTaskNo(taskCode);
						aprvUserInsViewVo.setTeamNo(suimVo.getTeam_id());
						String sysAdmAprvUser = "0";
						
						/** 17.02.27 1종과 결재자 로직 분리, by lds **/
						if(!suimVo.getSuim_rpt_type1().equals("3") && !suimVo.getSuim_rpt_type1().equals("4")){
							sysAdmAprvUser = sqlSession.selectOne("AprvUserMapper.selectOneAprvUserForRptSub", aprvUserInsViewVo);
						}else{
							sysAdmAprvUser = sqlSession.selectOne("AprvUserMapper.selectOneAprvUserForRptInbo",suimRptNo);
							if (sysAdmAprvUser == null || sysAdmAprvUser == ""){
								sysAdmAprvUser = (String) session.getAttribute("user_no_Session");
							}
						}
						
						HashMap<String,String> map = new HashMap<String,String>();
						
						map.put("apvNo", sysAdmAprvUser);
						map.put("suimRptNo", suimRptNo);
						
						result = sqlSession.update("SuimBookUdtMapper.rptActionSangsin",suimRptNo);
						int resultApv = sqlSession.update("SuimBookUdtMapper.rptActionSangsinBodyApvNo",map);
						
						if(resultApv > 0 && result >0){
							out.print(result);													
						}
						
						//결재요청(상신) 알림메일 발송 시작
						//인보험, 물보험 서면심사 제외
						// 결재 메일 알림은 오픈 제외 20211020 by top3009
						/**
						if( !( suimVo.getSuim_rpt_type1().equals("3") || suimVo.getSuim_rpt_type1().equals("4") || suimVo.getSuim_rpt_type1().equals("14") || suimVo.getSuim_rpt_type1().equals("15") || suimVo.getSuim_rpt_type1().equals("16") || suimVo.getSuim_rpt_type1().equals("17") || suimVo.getSuim_rpt_type1().equals("18") ) ){
							
							String sangsinUserNo = String.valueOf(mbrVo.getUser_no());
							String sangsinUserName = String.valueOf(mbrVo.getUser_name());
							String sangsinEmail = String.valueOf(mbrVo.getEmail());
							
							String lsAdmin7 = sqlSession.selectOne("TopLoginMapper.getLsAdmin7", sangsinUserNo);
							
							lsAdmin7 = lsAdmin7.replaceAll("\\|", "");				//"|"를 전부 제거하고 값이 없는경우 (권한이 없는경우)만 결재요청 Email 을 발송한다.
							
							if( "".equals(lsAdmin7) ) {				//종결권한이 없는 직원인 경우
								//해당 보고서의 팀 매니저 사번과 이메일주소를 가져온다.
								Map<String,Object> managerMap = new HashMap<String,Object>();
								managerMap = sqlSession.selectOne("TopLoginMapper.getManagerInfoToSuimRptNo", suimRptNo);
								
								//팀장정보(결재자)
								//String sManagerName = String.valueOf(managerMap.get("manager_name"));
								//String sManagerNo = String.valueOf(managerMap.get("manager_no"));
								String sManagerEmail = String.valueOf(managerMap.get("manager_email"));								
								
								//결재요청 메일 내용 시작
								String sFromName = sangsinUserName;
								String sFromAddress = sangsinEmail;
								String sToAddress = sManagerEmail;
								String sSubject = "[접수번호 : "+suimVo.getSuim_accept_no()+"] 보고서 결재요청";
								
								String sContent = "<table style='border-collapse:collapse;width:400px;font-size:12px;font-weight:bold;letter-spacing:1px;' border='1'>" + 
										"	<tr>" + 
										"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#e0f8f1'>상태</td>" + 
										"		<td height='30' style='text-align: left; padding-left: 10px;'><font color='blue'>결재요청</font></td>" + 
										"	</tr>" + 
										"	<tr>" + 
										"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#e0f8f1'>접수번호</td>" + 
										"		<td height='30' style='text-align: left; padding-left: 10px;'>"+suimVo.getSuim_accept_no()+"</td>" + 
										"	</tr>" + 
										"	<tr>" + 
										"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#e0f8f1'>처리담당자</td>" + 
										"		<td height='30' style='text-align: left; padding-left: 10px;'>"+suimVo.getUser_name()+" ("+suimVo.getHandphone()+")</td>" + 
										"	</tr>" + 
										"  </table>";							
								//결재요청 메일 내용 끝
								
								Sendmail sendmail = new Sendmail();
								try {
									//알림메일 발송
									sendmail.send( sFromName, sFromAddress, sToAddress, sSubject, sContent, "", "" );
									logger.info("Sendmail SangSin : "+sToAddress +" : "+ suimVo.getSuim_accept_no());
								} catch (Exception e) {
									System.out.println("SangSin Sendmail Error : "+e.getMessage());
								}
															
							}			
						}
						//결재요청(상신) 알림메일 발송 끝
						**/
						// 결재 메일 알림은 오픈 제외 20211020 by top3009
						
					}else{
						out.print("8");
						return;
					}
					//결재로그
					/*$sql="insert into log_ls_report_action values('','$rid','$action','$member[no]','$ip_addr',$log_date)";*/					
				}
			}else{
				out.print(2);
				return;
			}
			
		}else if(action.equals("submit_x")){ // 상신 취소하기
			
			//상신 취소전 보고서 실시간 상태값 확인 (종결인 경우 실행 불가 error code : result=10)			
			if( nSuimRptState == 2 ) {
				result = 10;
			}else{
				result = sqlSession.update("SuimBookUdtMapper.rptActionSangsinCancel",suimRptNo);
			}			
			
		}else if(action.equals("submit_e_x")){ // 종결 취소하기
			result = sqlSession.update("SuimBookUdtMapper.rptActionEndedCancel",suimRptNo);
			//종결이 취소된경우 저장된 손해사정사 정보를 삭제한다.
    		sqlSession.update("RptIssueMapper.deleteTopRptCertiEnd", suimRptNo);			
		}else if(action.equals("report_supp")){

			result = sqlSession.update("SuimBookUdtMapper.rptActionSuppReq",suimRptNo);
			//결재로그
			/*$sql="insert into log_ls_report_action values('','$rid','$action','$member[no]','$ip_addr',$log_date)";
			mysql_query($sql) or die(mysql_error());*/
			

		//보고서 보완완료
		}else if(action.equals("report_supp_ok")){

			result = sqlSession.update("SuimBookUdtMapper.rptActionSuppEnd",suimRptNo);
			//결재로그
			/*$sql="insert into log_ls_report_action values('','$rid','$action','$member[no]','$ip_addr',$log_date)";
			mysql_query($sql) or die(mysql_error());*/

			
		}else if(action.equals("cancel")){ // 위임취소하기 - 프로세스 변경으로 미사용 170802 by.lds

			result = sqlSession.update("SuimBookUdtMapper.rptActionCancel",suimRptNo);
			//결재로그
			/*$sql="insert into log_ls_report_action values('','$rid','$action','$member[no]','$ip_addr',$log_date)";
			mysql_query($sql) or die(mysql_error());*/

		}else if(action.equals("cancel_x")){ // 위임 취소를 취소하기  - 프로세스 변경으로 미사용 170802 by.lds

			result = sqlSession.update("SuimBookUdtMapper.rptActionCancelX",suimRptNo);
			
			//결재로그
			/*$sql="insert into log_ls_report_action values('','$rid','$action','$member[no]','$ip_addr',$log_date)";
			mysql_query($sql) or die(mysql_error());*/

		}else if(action.equals("report_del")){ //보고서 삭제하기
			
			/*보고서 헤드 정보 삭제 -> 수정사항 삭제일 업데이트로 수정만 하기*/
			result = sqlSession.update("SuimBookUdtMapper.rptActionDelHead",suimRptNo);
			
			/*보고서 바디 정보 삭제 -> 수정사항 삭제일 업데이트로 수정만 하기*/
			/*if(result > 0 ){
				result = sqlSession.update("SuimBookUdtMapper.rptActionDelBody",suimRptNo);
			}*/
			
			/*Todo 이미지 및 파일 삭제*/
			/*원본 파일 삭제 시작*/
			/*List<SuimRptOrgFileVO> suimRptOrgFileList = sqlSession.selectList("SuimBookDtlMapper.rptOrgFileList",suim_rpt_no);
			
			if(suimRptOrgFileList.size() >0){
				for (int i = 0; i < suimRptOrgFileList.size(); i++) {
					
					String fileforder = suimRptOrgFileList.get(i).getFilePath().substring(0, suimRptOrgFileList.get(i).getFilePath().lastIndexOf("/"));
					
					//파일 삭제 시작
					if(!fileforder.equals("")){
						
						File file = new File(suimRptOrgFileList.get(i).getFilePath());
						File dir = new File(fileforder);
						file.delete();
						dir.delete();
						
					}
					//파일 삭제 종료
					
					sqlSession.delete("SuimBookUdtMapper.delRptOrgFile", suimRptOrgFileList.get(i).getSerialNo());
					
				}
			}
			원본 파일 삭제 끝
			
			현장 중간 , 이미지&파일&DB 삭제 시작
			List<SuimRptSiteVO> suimRptSiteInterimList = sqlSession.selectList("SuimRptSiteMapper.getSiteInterimListForDelete", suim_rpt_no);
			
			String imgSerial = "";
			String thisfile = "";
			String fileforder = "";
			String fileforderForSiteInterim = "";
			String siteRptNo = "";
			
			for (int i = 0; i < suimRptSiteInterimList.size(); i++) {
				
				List<SuimRptSiteImgVO> suimRptSiteImgList = sqlSession.selectList("SuimRptSiteMapper.getSiteInterimImgList",suimRptSiteInterimList.get(i).getRptSiteNo());
				
				
				현장, 중간 이미지 삭제 시작
				for (int j = 0; j < suimRptSiteImgList.size(); j++) {
					
					imgSerial = suimRptSiteImgList.get(j).getRptSiteImgNo();
					thisfile = suimRptSiteImgList.get(j).getImgPath();
					fileforder = thisfile.substring(0, thisfile.lastIndexOf("/"));
					
					//현장,중간 이미지 파일 삭제 시작
					if(fileforder != ""){
						
						File file = new File(thisfile);
						File dir = new File(fileforder);
						file.delete();
						dir.delete();
						
					}
					//현장,중간 이미지 삭제 종료
					
					번호 1
					sqlSession.update("SuimRptSiteMapper.siteImgDel", imgSerial );
				} // end for j
				현장, 중간 이미지 삭제 끝
				
				fileforderForSiteInterim = suimRptSiteInterimList.get(i).getFilePath().substring(0, suimRptSiteInterimList.get(i).getFilePath().lastIndexOf("/"));
				
				//파일 삭제 시작
				if(!fileforderForSiteInterim.equals("")){
					
					File file = new File(suimRptSiteInterimList.get(i).getFilePath());
					File dir = new File(fileforderForSiteInterim);
					file.delete();
					dir.delete();
					
				}
				//파일 삭제 종료
				
				siteRptNo = suimRptSiteInterimList.get(i).getRptSiteNo();
				sqlSession.update("SuimRptSiteMapper.delSiteInterimFile", siteRptNo);
				
			}*/
			/*현장 중간 , 이미지&파일&DB 삭제 끝*/
			
			/*현장 중간 보고서 삭제*/
			/*sqlSession.delete("SuimBookUdtMapper.rptActionDelSiteInterim",suimRptNo);
			
			협조건 정보 삭제
			sqlSession.delete("SuimBookUdtMapper.rptActionDelHelp",suimRptNo);
			
			공동 조사자 정보 삭제
			sqlSession.delete("SuimBookUdtMapper.rptActionDelCollabo",suimRptNo);
			
			인보이스 정보 삭제
			sqlSession.delete("SuimBookUdtMapper.rptActionDelInv",suimRptNo);
			
			사고처리 과정표 삭제
			sqlSession.delete("SuimBookUdtMapper.rptActionDelCtrl",suimRptNo);
			
			보고서 관련 메모 삭제
			sqlSession.delete("SuimBookUdtMapper.rptActionDelMemo",suimRptNo);*/
			
			

			//삭제로그
			/*$sql="insert into log_ls_report_action values('','$rid','$action','$member[no]','$ip_addr',$log_date)";
			mysql_query($sql) or die(mysql_error());*/
			
		}else if(action.equals("un_lock")){
			result = sqlSession.delete("SuimBookUdtMapper.rptActionUnLock",suimRptNo);
			
			//결재로그
			/*$sql="insert into log_ls_report_action values('','$rid','$action','$member[no]','$ip_addr',$log_date)";*/
			
		}else if(action.equals("site_submit")) {			//현장보고서 결재올리기
			result = sqlSession.update("SuimBookUdtMapper.rptActionSiteSangsin",suimRptNo);
		}else if(action.equals("site_submit_x")) {		//현장보고서 상신취소하기
			result = sqlSession.update("SuimBookUdtMapper.rptActionSiteSangsinCancel",suimRptNo);
		}else if(action.equals("site_end")) {				//현장보고서 결재하기
			//현장보고서로 결재하는 경우
			int nSiteChk = sqlSession.selectOne("SuimBookUdtMapper.rptActionSiteChk0", suimRptNo);
			
			if( nSiteChk > 0 ) {
				result = sqlSession.update("SuimBookUdtMapper.rptActionSiteEnd0",suimRptNo);
			}else{
				//일정보고서로 결재요청 확인
				nSiteChk = sqlSession.selectOne("SuimBookUdtMapper.rptActionSiteChk1", suimRptNo);
				if( nSiteChk > 0 ) {
					result = sqlSession.update("SuimBookUdtMapper.rptActionSiteEnd1",suimRptNo);
				}else{
					result = sqlSession.update("SuimBookUdtMapper.rptActionSiteEnd",suimRptNo);
				}
			}
			
		}else if(action.equals("site_e_x")) {				//현장보고서 결재취소하기
			result = sqlSession.update("SuimBookUdtMapper.rptActionSiteEndCancel",suimRptNo);
		}
		
		SuimCommon comm = new SuimCommon();
		comm.insSuimRptLog(sqlSession, action, suim_rpt_no);

		/* 기존 로그 생성 프로세스 분리 (위임취소 처리 및 보고서 삭제시 로직 오류) 170802 by.lds
		if(!action.equals("report_del")){
			SuimRptCompositeVO suimVoAfterUdt = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", suim_rpt_no);
			SuimLogVO logVo = new SuimLogVO();
			
			logVo.setSuimRptNo(suim_rpt_no);
			logVo.setSuimRptType1(suimVoAfterUdt.getSuimRptType1());
			
			if(suimVoAfterUdt.getSuimRptType1().equals("14")){
				logVo.setSpeedType(suimVoAfterUdt.getSpeedType());			
			}else{
				logVo.setSpeedType("0");
			}
			
			//IP 얻기
			HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
			String ip = req.getHeader("X-FORWARDED-FOR");
			if (ip == null){
				ip = req.getRemoteAddr(); 
			}
			
			logVo.setSuimRptType1Close12(suimVoAfterUdt.getSuimRptType1Close12());
			logVo.setSuimRptType1Close34(suimVoAfterUdt.getSuimRptType1Close34());
			logVo.setMoralFlag(suimVoAfterUdt.getMoralFlag());
			logVo.setRegDate(suimVoAfterUdt.getReg_date());
			logVo.setSuimCancelDate(suimVoAfterUdt.getSuimCancelDate());
			logVo.setSuimRptAprvDate(suimVoAfterUdt.getSuimRptAprvDate());
			logVo.setCloseDate(suimVoAfterUdt.getCloseDate());
			
			if(action.equals("report_del")){
				
				Calendar cal = Calendar.getInstance();    
				cal.setTime(new Date());    
				
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
				String today = df.format(cal.getTime());
				
				logVo.setDelDate(today);
			}else{
				logVo.setDelDate("1970-01-01");
			}
			
			logVo.setSuimRptState(suimVoAfterUdt.getSuimRptState());
			logVo.setLockFlag(suimVoAfterUdt.getLockFlag());;
			logVo.setMinwonFlag(suimVoAfterUdt.getMinwonFlag());
			logVo.setLogIp(ip);
			logVo.setLogUserNo((String)session.getAttribute("user_no_Session"));
			
			if(result > 0){
				int resultLog = sqlSession.insert("SuimBookUdtMapper.suimLogForAction", logVo);			
			}
			
		} 
		*/
		
		out.print(result);
		out.close();
	}


	/*결재하기 동작 중 다음 종결 No 구하기*/ 
	private String nextRptCloseNoStr(String maxResultNo) {
		int nextRptCloseNo = 0;
		
		if(maxResultNo.split("-").length ==2){
			String nowRptCloseNo = maxResultNo.split("-")[1];
			nextRptCloseNo = Integer.parseInt(nowRptCloseNo)+1;					
		}else{
			nextRptCloseNo = 1;
		}
		
		String nextRptCloseNoStr = Integer.toString(nextRptCloseNo);
		
		if(nextRptCloseNoStr.length() == 1){
			nextRptCloseNoStr = "000"+nextRptCloseNoStr;
		}else if(nextRptCloseNoStr.length() == 2){
			nextRptCloseNoStr = "00"+nextRptCloseNoStr;
		}else if(nextRptCloseNoStr.length() == 3){
			nextRptCloseNoStr = "0"+nextRptCloseNoStr;
		}
		
		return nextRptCloseNoStr;
	}
	
	/*
	 * ***************************************
	 * Method ID : rptOrgFileDel
	 * Method Name :  rptOrgFileDel
	 * Description : 보고서 원본 파일 삭제
	 * 번호 1 : 
	 * Author : 이선형
	 * Date : 20160621
	 * ***************************************
	 * */
	@RequestMapping(value = "rptOrgFileDel", method = RequestMethod.POST)
	public void rptOrgFileDel(String serialNo, PrintWriter out) {
		
		logger.info("rptOrgFileDel");
		
		String path = "/home/hosting_users/toplac/www"+sqlSession.selectOne("SuimBookUdtMapper.getRptOrgFilePathForDel", serialNo);
		
		String fileforder = path.substring(0, path.lastIndexOf("/"));
		
		int result = 0;
		
		//파일 삭제 시작
		if(!fileforder.equals("")){
			
			File file = new File(path);
			File dir = new File(fileforder);
			file.delete();
			dir.delete();
			
			result = 1;
		}
		//파일 삭제 종료
		
		sqlSession.selectOne("SuimBookUdtMapper.delRptOrgFile", serialNo);
		
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : taskCheckUdt
	 * Method Name :  taskCheckUdt
	 * Description : 보고서 처리내용 확인사항 업데이트
	 * 번호 1 : 
	 * Author : 이선형
	 * Date : 20160725
	 * ***************************************
	 * */
	@RequestMapping(value = "taskCheckUdt", method = RequestMethod.POST)
	public void taskCheckUdt(String suimRptNo, String gubun, String checkYn, String checkMemo, PrintWriter out) {
		
		logger.info("taskCheckUdt");
		
		SuimRptTaskChkVO suimRptTaskChkVo = new SuimRptTaskChkVO();
		
		suimRptTaskChkVo.setSuimRptNo(suimRptNo);
		suimRptTaskChkVo.setGubun(gubun);
		
		if(gubun.equals("Contract")){
			suimRptTaskChkVo.setContactMemo(checkMemo);
			suimRptTaskChkVo.setContactYn(checkYn);
		}else if(gubun.equals("Face")){
			suimRptTaskChkVo.setFaceMemo(checkMemo);
			suimRptTaskChkVo.setFaceYn(checkYn);
		}else if(gubun.equals("Interim")){
			suimRptTaskChkVo.setInterimMemo(checkMemo);
			suimRptTaskChkVo.setInterimYn(checkYn);
		}
		
		
		int result = sqlSession.update("SuimBookUdtMapper.taskCheckUdt", suimRptTaskChkVo);

		out.print(result);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : probRptIns
	 * Method Name :  probRptIns
	 * Description : 문제점 및 향후 처리 방안
	 * Author : 임대성	
	 * Date : 20161208
	 * Update Date : 20160113
	 * Update : 한글내용 ?? 깨짐 처리
	 * ***************************************
	 * */
	@RequestMapping(value = "probRptIns", method = RequestMethod.POST)
	public void probRptIns(String suimRptNo, String contents, String regdate, String flag, PrintWriter out, HttpServletResponse response) {
		
		logger.info("probRptIns");
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("contents", contents);
		map.put("suimRptNo", suimRptNo);
		map.put("regDate", regdate);
		
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		JSONArray arr = new JSONArray();
		
		JSONObject obj = new JSONObject();
		
		int result = 0;
		if (flag.equals("prob")) {
			result = sqlSession.insert("SuimBookUdtMapper.insProblem", map);
			int tmpNo = Integer.parseInt(map.get("primaryKey")); 
			
			if(result >0){
				String tmpContent = "";
				try {
					tmpContent = java.net.URLEncoder.encode(contents,"UTF-8");
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				obj.put("regDate", regdate);
				obj.put("contents", tmpContent);
				obj.put("tmpNo", ""+tmpNo);
				
				arr.add(obj);
				
				String jsonStr = arr.toString();
				out.print(jsonStr);
			}else{
				out.print(0);
			}
			
		}else{
			result = sqlSession.insert("SuimBookUdtMapper.insPlan", map);
			int tmpNo = Integer.parseInt(map.get("primaryKey")); 
			if(result >0){
				String tmpContent = "";
				try {
					tmpContent = java.net.URLEncoder.encode(contents,"UTF-8");
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				obj.put("regDate", regdate);
				obj.put("contents", tmpContent);
				obj.put("tmpNo", ""+tmpNo);
				
				arr.add(obj);
				
				String jsonStr = arr.toString();
				out.print(jsonStr);
			}else{
				out.print(0);
			}
		}
	}
	
	/*
	 * ***************************************
	 * Method ID : probRptDel
	 * Method Name :  probRptDel
	 * Description : 문제점 삭제
	 * Author : 임대성
	 * Date : 20161208
	 * ***************************************
	 * */
	@RequestMapping(value = "probRptDel", method = RequestMethod.POST)
	public void probRptDel(Model model, HttpSession session, String serialNo, PrintWriter out) {
		
		logger.info("probRptDel");
	
		int result = sqlSession.delete("SuimBookUdtMapper.delProblem", serialNo);
		
		if (result == 1){
			out.print(serialNo);
		}else{
			out.print(0);
		}
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : probRptUdt
	 * Method Name :  probRptUdt
	 * Description : 문제점 수정
	 * Author : 임대성
	 * Date : 20161208
	 * ***************************************
	 * */
	@RequestMapping(value = "probRptUdt", method = RequestMethod.POST)
	public void probRptUdt(Model model, HttpSession session, SuimRptProblemVO srProbVO, HttpServletResponse response) {
		
		logger.info("probRptUdt");
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		
		PrintWriter out = null;
		
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		
		/*번호 1*/
		int result = sqlSession.update("SuimBookUdtMapper.udtProblem",srProbVO);

		if(result >0){
			
			obj.put("regDate",srProbVO.getPrb_date());
			obj.put("contents", srProbVO.getPrb_memo());
			obj.put("serialNo", srProbVO.getSerial_no());
			
			arr.add(obj);
			
			String jsonStr = arr.toString();
			out.print(jsonStr);
		}else{
			out.print(0);
		}
		out.close();
	}
	
	
	
	/*
	 * ***************************************
	 * Method ID : planRptDel
	 * Method Name :  planRptDel
	 * Description : 향후처리방안 삭제
	 * Author : 임대성
	 * Date : 20161208
	 * ***************************************
	 * */
	@RequestMapping(value = "planRptDel", method = RequestMethod.POST)
	public void planRptDel(Model model, HttpSession session, String serialNo, PrintWriter out) {
		
		logger.info("planRptDel");
	
		int result = sqlSession.delete("SuimBookUdtMapper.delPlan", serialNo);
		
		if (result == 1){
			out.print(serialNo);
		}else{
			out.print(0);
		}
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : probRptUdt
	 * Method Name :  probRptUdt
	 * Description : 문제점 수정
	 * Author : 임대성
	 * Date : 20161208
	 * ***************************************
	 * */
	@RequestMapping(value = "planRptUdt", method = RequestMethod.POST)
	public void planRptUdt(Model model, HttpSession session, SuimRptProblemVO srProbVO, HttpServletResponse response) {
		
		logger.info("planRptUdt");
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		
		PrintWriter out = null;
		
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		
		int result = sqlSession.update("SuimBookUdtMapper.udtPlan",srProbVO);

		if(result >0){
			
			obj.put("regDate",srProbVO.getPln_date());
			obj.put("contents", srProbVO.getPln_memo());
			obj.put("serialNo", srProbVO.getSerial_no());
			
			arr.add(obj);
			
			String jsonStr = arr.toString();
			out.print(jsonStr);
		}else{
			out.print(0);
		}
		out.close();
	}

    /**
     * 보고서 기본정보 chkList 업데이트 추가
     * khs 2017-06-02
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "chkListUpdate", method = RequestMethod.POST)
    @ResponseBody
	public Map<String, Object> chkListUpdate(HttpServletRequest request, Model model){
        //===============================================
        //	결과 맵 생성
        //===============================================
        Map<String,Object> resultMap = new HashedMap();

        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        //	권한체크
        //===============================================
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
        //TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();

        //기본수임정보를 가져온다.
        Map<String, Object> paramMap2 = new HashMap<String, Object>();
        paramMap2.put("suim_rpt_no", String.valueOf(paramMap.get("suimRptNo")));
        paramMap2.put("user_no_session", mbrVo.getUser_no());

        SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap2);

        String editYN = suimVo.getEditYN();

        //종결후 권한을 가져온다.
        Map<String, Object> paramMap3 = new HashMap<String, Object>();
        paramMap3.put("user_no", mbrVo.getUser_no());
        paramMap3.put("team_id", suimVo.getTeam_id());

        String endModFlag = sqlSession.selectOne("SuimBookDtlMapper.getEndModAuth", paramMap3);

        String authYN = "N";

        //미결이고 수정권한이 있거나 종결후 수정 권한이 있을경우
        if ( ("0".equals(suimVo.getSuimRptState()) && Integer.parseInt(editYN) > 0) || Integer.parseInt(endModFlag) > 0 ) {
            authYN = "Y";
        }

        //권한이 없을경우 권한없음 코드 반환
        if ("N".equals(authYN)){
            resultMap.put("result","2020");
            return resultMap;
        }

        //===============================================
        //	비즈니스 로직
        //===============================================
        try {

            sqlSession.update("SuimBookUdtMapper.updateRptBodyChkList",paramMap);
            resultMap.put("result", "0000");
            resultMap.put("retData", paramMap);

        } catch (Exception e){

            resultMap.put("result","1010");
            e.printStackTrace();

        }

        return resultMap;
    }
    
    
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
    
}
