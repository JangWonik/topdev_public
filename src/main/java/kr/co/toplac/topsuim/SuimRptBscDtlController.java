package kr.co.toplac.topsuim;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import kr.co.toplac.brd.noticeptnr.InsuTemplateBean;
import kr.co.toplac.cmm.service.CodeDicService;
import kr.co.toplac.rptin.SuimPrint1001;
import kr.co.toplac.rptin.SuimPrint1001VO;
import kr.co.toplac.sysadm.SysAdmCodeDicVO;
import kr.co.toplac.sysadm.TopEndSetupVO;
import kr.co.toplac.toprptinv.TopRptInvDtlViewVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopMbrSgnVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.WebUtil;
import kr.co.toplac.util.etc.Damo;
import kr.co.toplac.util.file.GetImageBase64;

@Controller
public class SuimRptBscDtlController {

private static final Logger logger = LoggerFactory.getLogger(SuimRptBscDtlController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
    @Autowired
    private CodeDicService service;
    
    /**
     * 손해사정서 교부동의서 첨부파일 갯수 확인
     * @param sSuim_rpt_no
     * @return
     */
    
    @RequestMapping(value="/reportIssueChkAttachFile")
    @ResponseBody
    public int reportIssueChkAttachFile(HttpServletRequest request) {
    	
    	int nRet = 0;
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);    	
    	nRet = sqlSession.selectOne("RptIssueMapper.getTopRptIssueFileCount", paramMap);    	
    	logger.info("======== reportIssueChkAttachFile ("+nRet+") ========");
    	
    	return nRet;
    }
    
    @RequestMapping(value = "suimRptAccSearchDetail")
	public String suimRptAccSearchDetail(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		
		logger.info("======= suimRptAccSearchDetail =======");
		
		return "top_suim/suim_rpt_acc_search_detail";
    }
    
    
    @RequestMapping(value = "/accSearchListAjax")
	public String accSearchListAjax(Model model, HttpServletRequest request, HttpSession session) {
		logger.info("======= accSearchListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
		List<Map<String, Object>> accList = sqlSession.selectList("SuimBookDtlMapper.getAccSearchDetail", paramMap);
		
		//보험사 정보 추가
		String sPtnrName = "";
		String sSuimRptNo = "";
		
		for(int i=0; i < accList.size(); i++) {
			sSuimRptNo = String.valueOf(accList.get(i).get("suim_rpt_no"));
			sPtnrName = sqlSession.selectOne("SuimBookDtlMapper.selectPtnrNameBySuimRptNo", sSuimRptNo);
			accList.get(i).put("ptnr_name", sPtnrName);			
		}
		
		model.addAttribute("accList", accList);		
		
		return "top_suim/suim_rpt_acc_search_detail_ajax";		
    }
    
	/*
	*********************************************************
	* Program ID	: suimRptBscDtl
	* Program Name	: suimRptBscDtl
	* Description	: 수임대장 리스트
	* 권한 관련 : 권한 여부를 선 확인 후 팝업창에 authFalg 로 판별해 팝업창과 부모창을 제어한다.
	* Author		: 이선형
	* Date			: 2016.05.02.
	*********************************************************
	*/
	@RequestMapping(value = "suimRptBscDtl", method = RequestMethod.GET)
	public String suimRptBscDtl(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response
			, SuimRptCompositeVO SuimRptVO, String suim_rpt_no, String rptWriteFlag) {
		
		logger.info("======= suimRptBscDtl =======");
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

		HashMap<String,Object> map =  new HashMap<String,Object>();
		map.put("suim_rpt_no", suim_rpt_no);
		map.put("user_no_session", mbrVo.getUser_no());
		
		Calendar cal = Calendar.getInstance();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
		String today = df.format(cal.getTime());
//		String today = "2018-12-16";
		
		int year = Integer.parseInt(today.split("-")[0]);
		int month = Integer.parseInt(today.split("-")[1]);
		int day = Integer.parseInt(today.split("-")[2]);
		
		if (month == 12 && day > 15){
			++year;
		}
		map.put("year", year);
		
		// ================================================
		// 180131 기준업무량 관련 
		// ================================================
		SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();
        codeVo.setTbl_nm("top_rpt_head");
        codeVo.setCol_nm("workload_type_"+year);
        List<SysAdmCodeDicVO> workloadTypeList = service.codeList2(codeVo);
        model.addAttribute("workloadTypeList", workloadTypeList);

		SuimRptCompositeVO suimListDtlVO = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", map);
		
		//조회 권한 추가 (기존 조회권한 + 공동수행체크)
		int rptReadAuth = Integer.parseInt(suimListDtlVO.getEditYN());
		
		//공동수행자 인지 확인 시작
		
		// nCollaboAuth 이 1이상 인 경우 공동수행자 임
		int nCollaboAuth = sqlSession.selectOne("SuimRptCollaboMapper.selectCollaboAuthChk", map);		
		//공동수행자 인지 확인 끝
		
		rptReadAuth = rptReadAuth+nCollaboAuth;		
				
		if (rptReadAuth <= 0){
			return "top_suim/suim_rpt_bsc_dtl_no_auth";
		}
		
		//수정권한을 공동수행자 여부까지 체크해서 다시 Setting 한다.
		suimListDtlVO.setEditYN(String.valueOf(rptReadAuth));
		
		/** 종결 후 수정 **/
		HashMap<String,String> lsAdminMap =  new HashMap<String,String>();
		lsAdminMap.put("user_no", ""+session.getAttribute("user_no_Session"));
		lsAdminMap.put("team_id", suimListDtlVO.getTeam_id());
		String ls_admin22 = sqlSession.selectOne("SuimBookDtlMapper.getEndModAuth", lsAdminMap);
		model.addAttribute("endModFlag",ls_admin22);
		
		/** 총무 경리 수정(종결 후 보고서 작성자 변경) **/
		lsAdminMap.put("user_no", ""+session.getAttribute("user_no_Session"));
		lsAdminMap.put("team_id", suimListDtlVO.getTeam_id());
		String ls_admin11 = sqlSession.selectOne("SuimBookDtlMapper.getEndModRptWriter", lsAdminMap);
		model.addAttribute("endModRptWriter",ls_admin11);
		
		
//		/** 담당 관리 부서(위임 취소 결재자) **/
//		lsAdminMap.put("user_no", ""+session.getAttribute("user_no_Session"));
//		lsAdminMap.put("team_id", suimListDtlVO.getTeam_id());
//		String ls_admin23 = sqlSession.selectOne("SuimBookDtlMapper.getDeptMngAuth", lsAdminMap);
//		model.addAttribute("deptMngAuth",ls_admin23);
		
		
//		if(suimListDtlVO.getUser_no().equals(mbrVo.getUser_no())){
//			int intEditeYN = Integer.parseInt(suimListDtlVO.getEditYN()) + 1;
//			suimListDtlVO.setEditYN("" + intEditeYN);
//		}

		//log insert select start
		/*ip 얻기 시작*/
		HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		String ip = req.getHeader("X-FORWARDED-FOR");
		
		if (ip == null){
			ip = req.getRemoteAddr(); 
		}
		/*ip 얻기 끝*/
		
		TopRptLogReadVO logReadVO = new TopRptLogReadVO();
		logReadVO.setSuim_rpt_no(suim_rpt_no);
		logReadVO.setUser_no((String) session.getAttribute("user_no_Session"));
		logReadVO.setUser_ip(ip);
		sqlSession.insert("SuimRptBscDtlLogMapper.insTopRptLogRead", logReadVO);
		List<TopRptLogReadVO> suimRptBscDtlReadLogList = sqlSession.selectList("SuimRptBscDtlLogMapper.suimRptBscDtlReadLogList", suim_rpt_no);
		model.addAttribute("suimRptBscDtlReadLogList", suimRptBscDtlReadLogList);
		List<TopRptLogFileVO> suimRptBscDtlFileLogList = sqlSession.selectList("SuimRptBscDtlLogMapper.suimRptBscDtlFileLogList", suim_rpt_no);
		model.addAttribute("suimRptBscDtlFileLogList", suimRptBscDtlFileLogList);
		List<TopRptHeadLogVO> suimRptBscDtlLogList = sqlSession.selectList("SuimRptBscDtlLogMapper.suimRptBscDtlLogList", suim_rpt_no);
		model.addAttribute("suimRptBscDtlLogList", suimRptBscDtlLogList);
		
		//log insert select end

		
		// ================================================
		// 170801 위임취소 프로세스 추가
		// ================================================
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("suimRptNo", suim_rpt_no);
		paramMap.put("processChk", "1");
		
		SuimRptCancelVO rptCancel = sqlSession.selectOne("SuimRptCancelMapper.getRptCancel",paramMap);
		model.addAttribute("processChk","1"); //수임 : 농작물 구분 FLAG
		model.addAttribute("rptCancel", rptCancel);
		
		
		Damo damo = new Damo(); //디아모 암호화
		String strDec = "";

		if(suimListDtlVO.getCommission_estimated() != null){
			if(suimListDtlVO.getCommission_estimated().equals("0")){
				suimListDtlVO.setCommission_estimated("-");
			}			
		}
		
		if(suimListDtlVO.getAmt_estimated_damage() != null){
			if(suimListDtlVO.getAmt_estimated_damage().equals("0")){
				suimListDtlVO.setAmt_estimated_damage("-");
			}			
		}

		/*피보험자 주민번호가 없을 경우*/
		if(suimListDtlVO.getBeneficiary_ssn() != null && !suimListDtlVO.getBeneficiary_ssn().equals("")){
			strDec = damo.decodeDamo(suimListDtlVO.getBeneficiary_ssn());
			
			if(strDec.trim().equals("-")){
				suimListDtlVO.setBeneficiary_ssn("");
			}else{
				suimListDtlVO.setBeneficiary_ssn(strDec);
				
				//마스킹된 주민등록번호
				/*
				String[] splitSsn = strDec.split("-");
				splitSsn[1] = splitSsn[1].substring(0, 1) + "******";
				String maskSsn = splitSsn[0]+"-"+splitSsn[1];
				suimListDtlVO.setBeneficiary_ssn2(maskSsn);
				*/
			}
		}
				
		/*계약자 주민번호가 없을 경우*/
		if(suimListDtlVO.getPolicyholder_ssn() != null && !suimListDtlVO.getPolicyholder_ssn().equals("")){
			strDec = damo.decodeDamo(suimListDtlVO.getPolicyholder_ssn());
			if(strDec.trim().equals("-")){
				suimListDtlVO.setPolicyholder_ssn("");
			}else{
				suimListDtlVO.setPolicyholder_ssn(strDec);
				
				//마스킹된 주민등록번호
				/*
				String[] splitSsn = strDec.split("-");
				splitSsn[1] = splitSsn[1].substring(0, 1) + "******";
				String maskSsn = splitSsn[0]+"-"+splitSsn[1];
				suimListDtlVO.setPolicyholder_ssn2(maskSsn);
				*/
				
			}			
		}
		
		if (suimListDtlVO.getPolicyholder_tel() != null || suimListDtlVO.getPolicyholder_tel() != ""){
			strDec = damo.decodeDamo(suimListDtlVO.getPolicyholder_tel());
			suimListDtlVO.setPolicyholder_tel(strDec);
		}
		
		if (suimListDtlVO.getBeneficiary_tel() != null || suimListDtlVO.getBeneficiary_tel() != ""){
			strDec = damo.decodeDamo(suimListDtlVO.getBeneficiary_tel());
			suimListDtlVO.setBeneficiary_tel(strDec);
		}

		if(suimListDtlVO.getDamaged_tel() != null || suimListDtlVO.getDamaged_tel() != ""){
			strDec = damo.decodeDamo(suimListDtlVO.getDamaged_tel());
			suimListDtlVO.setDamaged_tel(strDec);
		}
		
		if(suimListDtlVO.getPtnr_mbr_hp() != null || suimListDtlVO.getPtnr_mbr_hp() != ""){
			strDec = damo.decodeDamo(suimListDtlVO.getPtnr_mbr_hp());
			suimListDtlVO.setPtnr_mbr_hp(strDec);
		}
		
		if(suimListDtlVO.getPtnr_mbr_office_tel() != null || suimListDtlVO.getPtnr_mbr_office_tel() != ""){
			strDec = damo.decodeDamo(suimListDtlVO.getPtnr_mbr_office_tel());
			suimListDtlVO.setPtnr_mbr_office_tel(strDec);
		}
		/*금액 부분 컴마 처리*/
//		if(suimListDtlVO.getAmtClaimed() != null){
//			suimListDtlVO.setAmtClaimed(Comma_won(suimListDtlVO.getAmtClaimed()));					
//		}
//		if(suimListDtlVO.getAmtEstimatedDamage() != null){
//			suimListDtlVO.setAmtEstimatedDamage(Comma_won(suimListDtlVO.getAmtEstimatedDamage()));					
//		}
//		if(suimListDtlVO.getAmtSettlement() != null){
//			suimListDtlVO.setAmtSettlement(Comma_won(suimListDtlVO.getAmtSettlement()));					
//		}
//		if(suimListDtlVO.getAmtSelfPay() != null){
//			suimListDtlVO.setAmtSelfPay(Comma_won(suimListDtlVO.getAmtSelfPay()));					
//		}
//		if(suimListDtlVO.getAmtInsuPayment() != null){
//			suimListDtlVO.setAmtInsuPayment(Comma_won(suimListDtlVO.getAmtInsuPayment()));					
//		}
//		if(suimListDtlVO.getAmtReduction() != null){
//			suimListDtlVO.setAmtReduction(Comma_won(suimListDtlVO.getAmtReduction()));					
//		}
				
		/*** 전직원 ***/
//		List<TopMbrBscVO> workMember = sqlSession.selectList("SuimBookDtlMapper.getAllMember");
//		model.addAttribute("workMember", workMember);
		
		
		/** 4종 결재자 목록 수정 by top3009 (2019.09.27)
		String tmLevel = sqlSession.selectOne("SuimBookDtlMapper.getTmLevel",suimListDtlVO.getTeam_id());
		if (tmLevel.equals("2")){
			List<String> list = new ArrayList<String>();
			
			List<String> tmp = sqlSession.selectList("SuimBookDtlMapper.getTmID",suimListDtlVO.getTeam_id());
			for(int i=0 ; i < tmp.size() ; i++){
				list.add(tmp.get(i));
			}
			List<TopMbrBscVO> workMember = sqlSession.selectList("SuimBookDtlMapper.getLevel2MyTeam",list);
			model.addAttribute("workMember", workMember);
		}else{
			List<TopMbrBscVO> workMember = sqlSession.selectList("SuimBookDtlMapper.getAllMyTeam",suimListDtlVO.getTeam_id());
			model.addAttribute("workMember", workMember);
		}
		**/
		/** 4종 결재 목록 수정 시작 by top3009 (20190927)*/				
		List<TopMbrBscVO> workMember = sqlSession.selectList("SuimBookDtlMapper.getApprovalMemberList4",suimListDtlVO.getTeam_id());
		model.addAttribute("workMember", workMember);		
		/** 4종 결재 목록 수정 끝 */		
				
		/*보고서 원본 파일 정보 추출 시작*/
		List<SuimRptOrgFileVO> rptOrgFileList  = sqlSession.selectList("SuimBookDtlMapper.rptOrgFileList", suim_rpt_no);
		model.addAttribute("rptOrgFileList", rptOrgFileList);
		/*보고서 원본 파일 정보 추출 끝*/

		/*수임일 기준으로 경과일 계산 : 처리내용 확인사항 부분*/
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		
		Date endDate = null;
				
		if(suimListDtlVO.getSuim_rpt_type1().equals("3") || suimListDtlVO.getSuim_rpt_type1().equals("4")){
			
			try {
				endDate = formatter.parse(today);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			long timeDiffer = 0;
			
			Date beginDate = null;
			
			try {
				beginDate = formatter.parse(suimListDtlVO.getReg_date());
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			timeDiffer = (endDate.getTime() - beginDate.getTime())/(24*3600*1000);
			suimListDtlVO.setPastDays( Long.toString(timeDiffer));
			/*수임일 기준으로 경과일 계산 끝 */
	
			/*처리내용 확인사항 시작*/			
			int taskChk = 0;
			
			taskChk = sqlSession.selectOne("SuimBookDtlMapper.getTaskOneCount", suim_rpt_no);
			
			SuimRptTaskChkVO suimRptTaskChkVo;
			
			if( taskChk == 0) {
				sqlSession.insert("SuimBookDtlMapper.insNewTask",suim_rpt_no);
			}else if( taskChk > 1 ) {		//두개 이상 존재하는 경우 삭제하고 다시 1개의 행만 생성한다.
				sqlSession.delete("SuimBookDtlMapper.delNewTask",suim_rpt_no);
				sqlSession.insert("SuimBookDtlMapper.insNewTask",suim_rpt_no);
			}
			
			suimRptTaskChkVo = sqlSession.selectOne("SuimBookDtlMapper.getTaskOne", suim_rpt_no);
			
			//if(suimRptTaskChkVo == null){
				//sqlSession.insert("SuimBookDtlMapper.insNewTask",suim_rpt_no);
				//suimRptTaskChkVo = sqlSession.selectOne("SuimBookDtlMapper.getTaskOne", suim_rpt_no); 
			//}
			
			if(!suimRptTaskChkVo.getContactMemo().equals("") ){
				suimRptTaskChkVo.setContactMemo(suimRptTaskChkVo.getContactMemo().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));					
			}
			
			if(!suimRptTaskChkVo.getFaceMemo().equals("")){
				suimRptTaskChkVo.setFaceMemo(suimRptTaskChkVo.getFaceMemo().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));					
			}
			
			if(suimRptTaskChkVo.getInterimMemo().equals("")){
				suimRptTaskChkVo.setInterimMemo(suimRptTaskChkVo.getInterimMemo().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));					
			}
			
			model.addAttribute("suimRptTaskChkVo", suimRptTaskChkVo);
			/*처리내용 확인사항 끝*/
			
		}

		/*사고처리 과정표 정보 추출 시작*/
		if( (suimListDtlVO.getSuim_rpt_type1().equals("3") || suimListDtlVO.getSuim_rpt_type1().equals("4")) &&  suimListDtlVO.getSuim_rpt_type2().equals("16") ){
			List<SuimRptSagoBsc16VO> sagoList  = sqlSession.selectList("SagoBscMapper.getSagoList16", suim_rpt_no);
			for (int i = 0; i < sagoList.size(); i++) {
				sagoList.get(i).setControlMemo(sagoList.get(i).getControlMemo().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
			}
			model.addAttribute("sagoList", sagoList);
		}else{
			List<SuimRptSagoBscVO> sagoList  = sqlSession.selectList("SagoBscMapper.getSagoList", suim_rpt_no);
			model.addAttribute("sagoList", sagoList);
		}
		/*사고처리 과정표 정보 추출 끝*/
		
		/*현재 진행 상황(미결사유) 정보 추출 시작*/
		List<SuimRptNowBscVO> nowList  = sqlSession.selectList("RptNowBscMapper.getNowList", suim_rpt_no);
		model.addAttribute("nowList", nowList);
		/*현재 진행 상황(미결사유) 정보 추출 끝*/
		
		/*보고서 협조건 정보 추출 시작*/
		List<SuimRptHelpBscVO> helpList  = sqlSession.selectList("HelpBscMapper.getHelpList", suim_rpt_no);
		model.addAttribute("helpList", helpList);
				
		for (int i = 0; i < helpList.size(); i++) {
			
			if(helpList.get(i).getHelpState().equals("0")){
				helpList.get(i).setHelpState("대기");
			}else if(helpList.get(i).getHelpState().equals("1")){
				helpList.get(i).setHelpState("진행");
			}else if(helpList.get(i).getHelpState().equals("2")){
				helpList.get(i).setHelpState("완료요청");
			}else if(helpList.get(i).getHelpState().equals("3")){
				helpList.get(i).setHelpState("완료");
			}
			
			if(helpList.get(i).getAcceptMbr() ==  null){
				helpList.get(i).setAcceptMbr("0");
			}
			
			if(helpList.get(i).getHelpFile() != null){
				if(!helpList.get(i).getHelpFile().equals("")){
					helpList.get(i).setHelpFile(helpList.get(i).getHelpFile().substring(helpList.get(i).getHelpFile().lastIndexOf("/")+1));
				}
			}
			
		}
		/*보고서 협조건 정보 추출 끝*/
		
		/*문제점 및 향후 처리방안*/
		List<SuimRptProblemVO> probList = sqlSession.selectList("SuimBookDtlMapper.getProblem",suim_rpt_no);
		model.addAttribute("probList", probList);
		
		List<SuimRptProblemVO> planList = sqlSession.selectList("SuimBookDtlMapper.getPlan",suim_rpt_no);
		model.addAttribute("planList", planList);
				
				
		/*현장 보고서 정보 추출 시작*/
		List<SuimRptSiteVO> siteList = sqlSession.selectList("SuimRptSiteMapper.getSiteListForRptDtl", suim_rpt_no);
//		for (int i = 0; i < siteList.size(); i++) {
//			if(siteList.get(i).getSubDate() == null || siteList.get(i).getSubDate().equals("1970-01-01")){
//				siteList.get(i).setSubDate("미제출");
//			}
//		}		
		model.addAttribute("siteList", siteList);		 
		/*현장 보고서 정보 추출 끝*/
		
		/*현장 보고서 내 첨부된 보고서 갯수 시작*/
		int siteCnt = 0;
		siteCnt = sqlSession.selectOne("SuimRptSiteMapper.getSiteListFileCnt", suim_rpt_no);
		model.addAttribute("siteCnt", siteCnt);
		/*현장 보고서 내 첨부된 보고서 갯수 끝*/
		
		/* 현장보고서 겸직부서 조회권한 체크시작 (2025-03-11) */		
		boolean sApprovalSiteAuth = false;
		String sUserNo = String.valueOf(session.getAttribute("user_no_Session"));		
		String sLsApprovalSite = "";			//겸직자 결재팀
        sLsApprovalSite = sqlSession.selectOne("PopMbrAuth2DtlMapper.getLsApprovalSite", sUserNo);
        sLsApprovalSite = WebUtil.makeInsqlString(sLsApprovalSite,"\\|");
        
        //현장보고서 겸직부서 권한이있으면 보고서 팀아이디와 체크한다.
        if( !"".equals(sLsApprovalSite) ) {
        	String [] approvalTemp = sLsApprovalSite.split(",");
        	//현장보고서 결재권한 배열 내 보고서 팀아이디가 존재하는지 체크한다.
        	if( Arrays.asList(approvalTemp).contains(suimListDtlVO.getTeam_id()) ) {
        		sApprovalSiteAuth = true;
        	}        	
        }
        
        //현장보고서 결재권한 셋팅 (true:권한있음, false:권한없음)
        model.addAttribute("approvalSiteAuth", sApprovalSiteAuth);        
		/* 현장보고서 겸직부서 조회권한 체크 끝 (2025-03-11) */
				
		/*중간 보고서 정보 추출 시작*/
		List<SuimRptSiteVO> interimList = sqlSession.selectList("SuimRptSiteMapper.getInterimListForRptDtl", suim_rpt_no);
		for (int i = 0; i < interimList.size(); i++) {
			if(interimList.get(i).getSubDate() == null || interimList.get(i).getSubDate().equals("1970-01-01")){
				interimList.get(i).setSubDate("미제출");
			}
		}
		model.addAttribute("interimList", interimList);
		/*중간 보고서 정보 추출 끝*/

		/*진행경과 보고서 정보 추출 시작*/
        //List<SuimRptSiteVO> prgssList = sqlSession.selectList("SuimRptSiteMapper.getPrgssListForRptDtl", suim_rpt_no);
        //model.addAttribute("prgssList", prgssList);
		/*진행경과 보고서 정보 추출 끝*/

				
		/*공동 수행자 정보 추출 시작*/
//		List<SuimRptCollaboVO> collaboList = sqlSession.selectList("SuimRptCollaboMapper.getCollaboListForRptDtl",suim_rpt_no);
		List<SuimRptCollaboVO> collaboList = sqlSession.selectList("SuimRptCollaboMapper.selectCollaboNew",suim_rpt_no);	
		
		model.addAttribute("collaboList", collaboList);
		
		/*인보이스 정보 추출 시작*/
		TopRptInvDtlViewVO suimInvVO = sqlSession.selectOne("InvoiceDtlMapper.getInvoiceDtlForRptDtl", suim_rpt_no);
		
		/* 결재수수료 정보 불러오기 (보험사 : 현대해상 :14) */
		String sPtnrId = suimListDtlVO.getPtnr_id();
		String sSuimRptType1 = suimListDtlVO.getSuim_rpt_type1();
		
		if( "14".equals(sPtnrId) && !"3".equals(sSuimRptType1) && !"4".equals(sSuimRptType1) ) {			
			SuimRptCollaboVO collaboApprovalVO = new SuimRptCollaboVO();
			
			//기존 결재수수료 입력 건이 있는지 체크한다.
			int nCnt = sqlSession.selectOne("SuimRptCollaboMapper.selectCollaboApprovalCnt", suim_rpt_no);
			
			if( nCnt == 1 ) {
				collaboApprovalVO = sqlSession.selectOne("SuimRptCollaboMapper.selectCollaboApproval",suim_rpt_no);
				
				//결재 수수료가 있는 경우 결재 수수료를 재계산 해서 넣어준다. (컬럼값 수정으로 주석처리)
				/*
				int nAmtTotal = Integer.parseInt(suimInvVO.getAmtTotal());
				int nCollaboPrice = Integer.parseInt(collaboApprovalVO.getCollaboPrice());
				
				nAmtTotal = nAmtTotal+nCollaboPrice;
				
				suimInvVO.setAmtTotal(String.valueOf(nAmtTotal));
				*/
			}
			
			model.addAttribute("collaboApprovalVO", collaboApprovalVO);
			
			//재직중인 직원의 목록을 물러온다.
			List<Map<String, Object>> approvalUserList = sqlSession.selectList("StatisticBasic.selectTopMemberListByApprovalAmt");		
			model.addAttribute("approvalUserList", approvalUserList);
		}
				
//		if( suimInvVO != null){
//			if(suimInvVO.getAmtBasic() != null){
//				if(suimInvVO.getAmtBasic().equals("0")){
//					suimInvVO.setAmtBasic("-");
//				}					
//				suimInvVO.setAmtBasic(Comma_won(suimInvVO.getAmtBasic()));
//			}
//			if(suimInvVO.getAmtCounsel() != null){
//				if(suimInvVO.getAmtCounsel().equals("0")){
//					suimInvVO.setAmtCounsel("-");
//				}					
//				suimInvVO.setAmtCounsel(Comma_won(suimInvVO.getAmtCounsel() ));
//			}
//			if(suimInvVO.getAmtDaily() != null){
//				if(suimInvVO.getAmtDaily().equals("0")){
//					suimInvVO.setAmtDaily("-");
//				}					
//				suimInvVO.setAmtDaily(Comma_won(suimInvVO.getAmtDaily()));
//			}
//			if(suimInvVO.getAmtEtc() != null){
//				if(suimInvVO.getAmtEtc().equals("0")){
//					suimInvVO.setAmtEtc("-");
//				}					
//				suimInvVO.setAmtEtc(Comma_won(suimInvVO.getAmtEtc()));
//			}
//			if(suimInvVO.getAmtTraffic() != null){
//				if(suimInvVO.getAmtTraffic().equals("0")){
//					suimInvVO.setAmtTraffic("-");
//				}					
//				suimInvVO.setAmtTraffic(Comma_won( suimInvVO.getAmtTraffic()));
//			}
//			if(suimInvVO.getAmtTotal() != null){
//				if(suimInvVO.getAmtTotal().equals("0")){
//					suimInvVO.setAmtTotal("-");
//				}					
//				suimInvVO.setAmtTotal(Comma_won(suimInvVO.getAmtTotal()));
//			}
//		}
		model.addAttribute("suimInvVO", suimInvVO);
		/*인보이스 정보 추출 끝*/
				
		/*이 건이 종결 혹은 위임취소 되고 15일이 지났느냐 */
		boolean is15DaysOutClose = false;
		boolean is15DaysOutCancel = false;
				
		cal.setTime(new Date());    
		
		today = df.format(cal.getTime());
		
		String[] closeDateSplit = null;
		String[] cancelDateSplit = null;

		Calendar c1 = Calendar.getInstance();
		Calendar c2 = Calendar.getInstance();
		
		String[] todaySplit = today.split("-");
		c2.set(Integer.parseInt(todaySplit[0]), Integer.parseInt(todaySplit[1]) - 1, Integer.parseInt(todaySplit[2]) );
        
		
		
        //System.out.println("CLOSE2:["+df.format(c2.getTime())+"]");
        
        if(suimListDtlVO.getCloseDate() != null ){
			if(!suimListDtlVO.getCloseDate().equals("1970-01-01") && (suimListDtlVO.getCloseDate().split("-").length == 3)){
				closeDateSplit = suimListDtlVO.getCloseDate().split("-");

				c1.set( Integer.parseInt(closeDateSplit[0]), Integer.parseInt(closeDateSplit[1]) - 1, Integer.parseInt(closeDateSplit[2]) );
				c1.add(Calendar.DATE, 15);
                
                //System.out.println("CLOSE1:["+df.format(c1.getTime())+"]");
				/*c1(종결 15일 후) 날짜가 c2(오늘) 날짜 보다 이전이냐*/ 
				if (c1.before(c2)){
					is15DaysOutClose = true;
				}
				
				c1.setTime(new Date());
			}
		}
				
		if(suimListDtlVO.getSuimCancelDate() != null ){
			if(!suimListDtlVO.getSuimCancelDate().equals("1970-01-01") && (suimListDtlVO.getSuimCancelDate().split("-").length == 3)){
				cancelDateSplit = suimListDtlVO.getSuimCancelDate().split("-");

				c1.set( Integer.parseInt(cancelDateSplit[0]), Integer.parseInt(cancelDateSplit[1]) - 1, Integer.parseInt(cancelDateSplit[2]) );
				c1.add(Calendar.DATE, 15);

				/*c1(종결 15일 후) 날짜가 c2(오늘) 날짜 보다 이전이냐*/ 
				if (c1.before(c2)){
					is15DaysOutCancel = true;
				}
			}
		}
				
		model.addAttribute("is15DaysOutClose", is15DaysOutClose);
		model.addAttribute("is15DaysOutCancel", is15DaysOutCancel);
		/*이 건이 종결 혹은 위임 취소 되고 15일이 지났느냐 끝*/
		
		/* 탑 팀목록 추출*/
		List<TopTmBscVO> topTeamList = sqlSession.selectList("HelpBscMapper.topTeamList");
		model.addAttribute("topTeamList", topTeamList);
		
		/*인보험의 경우 Print 정보를 추출한다*/
		if(suimListDtlVO.getSuim_rpt_type1().equals("3") || suimListDtlVO.getSuim_rpt_type1().equals("4")){
			
			/*Print 공통 정보 추출 시작*/
			TopTmBscVO topTmBscVo = sqlSession.selectOne("SuimRptBodyMapper.topTmInfoForBody", suimListDtlVO.getTeam_id());
			TopMbrBscVO mbrVoForBody = sqlSession.selectOne("SuimRptBodyMapper.mbrinfo", suimListDtlVO.getUser_no());

			/*부모 건의 결재자 정보를 추출 */
			TopMbrBscVO mbrVoForBodySantion = sqlSession.selectOne("SuimRptBodyMapper.mbrinfo", suimListDtlVO.getSuimRptAprvUserNo());
			
			/*결재자의 사인 정보 추출*/
			TopMbrSgnVO signVo = new TopMbrSgnVO();
			if(suimListDtlVO.getSuimRptAprvUserNo() != null){
				if(!suimListDtlVO.getSuimRptAprvUserNo().equals("")){
					signVo = sqlSession.selectOne("MyInfoUdtMapper.membersign",suimListDtlVO.getSuimRptAprvUserNo());
					model.addAttribute("signVoSantion", signVo);
				}else{
					model.addAttribute("signVoSantion", "");
				}
			}else{
				model.addAttribute("signVoSantion", "");
			}
					
			/*조사자의 사인 정보 추출*/
			TopMbrSgnVO signVoForRptUser = new TopMbrSgnVO();
			if(suimListDtlVO.getUser_no() != null){
				if(!suimListDtlVO.getUser_no().equals("")){
					signVoForRptUser = sqlSession.selectOne("MyInfoUdtMapper.membersign",suimListDtlVO.getUser_no());
					model.addAttribute("signVoForRptUser", signVoForRptUser);
				}else{
					model.addAttribute("signVoForRptUser", "");
				}
			}else{
				model.addAttribute("signVoForRptUser", "");
			}
			/*Print 공통 정보 추출 끝*/
					
			/*보고서 농협 ( Print_6 ),  정보 추출 : 인보험일 경우만*/
			if( suimListDtlVO.getSuim_rpt_type2().equals("6")){
				
				/*print_6 1단계 : 부모 건의 수임No로 입력되어있는 Body 정보(Tobe에서는 Print 정보) 를 추출 */
				SuimRptBody6VO suimRptBody6Vo = sqlSession.selectOne("SuimRptBodyMapper.getBody6", suim_rpt_no);
				
				/*print_6 2단계 : Print 정보 없을 경우, 신규 입력함 */
				if(suimRptBody6Vo == null){
					int nextBody6Serial = sqlSession.selectOne("SuimRptBodyMapper.nextBody6Serial");
					sqlSession.insert("SuimRptBodyMapper.insNewBody6", suim_rpt_no);
					
					/*직전 입력한 Print 정보를 추출하여 전달*/
					suimRptBody6Vo = sqlSession.selectOne("SuimRptBodyMapper.getBody6AfterIns", nextBody6Serial);
				}
				
				model.addAttribute("suimRptBodyVo",suimRptBody6Vo);
				
			}else if(suimListDtlVO.getSuim_rpt_type2().equals("109999")){ // 인보험 일반 건의 경우 Print_1 정보 추출
				//==============================================
                // 인보험 일반건 일경우 따로 처리
                // 이구문이 실행 안되도록 1에서 109999로 변경함
                // 2017.07.20 khs
                //==============================================
				
				/*print1_13467 1단계 : 부모 건의 수임No로 입력되어있는 Body 정보(Tobe에서는 Print 정보) 를 추출 */
				SuimRptBody1_13467VO suimRptBody1_13467Vo = sqlSession.selectOne("SuimRptBodyMapper.getBody1_13467", suim_rpt_no);
				
				/*print1_13467 2단계 : Print 정보 없을 경우, 신규 입력함 */
				if(suimRptBody1_13467Vo == null){
					int nextBody1_13467Serial = sqlSession.selectOne("SuimRptBodyMapper.nextBody1_13467");
					sqlSession.insert("SuimRptBodyMapper.insBody1_13467", suim_rpt_no);
					
					/*직전 입력한 Print 정보를 추출하여 전달*/
					suimRptBody1_13467Vo = sqlSession.selectOne("SuimRptBodyMapper.getBody1_13467AfterIns", nextBody1_13467Serial);
				}
			
				/*Print1_2 정보 추출*/
				List<SuimRptBody1_2VO> suimRptBody1_2List = sqlSession.selectList("SuimRptBodyMapper.getPrint1_2List", suimRptBody1_13467Vo.getRptPrintNo());
				
				/*Print1_5 정보 추출*/
				List<SuimRptBody1_5VO> suimRptBody1_5List = sqlSession.selectList("SuimRptBodyMapper.getPrint1_5List", suimRptBody1_13467Vo.getRptPrintNo());
				
				/*Print1_6_6 정보 추출*/
				List<SuimRptBody1_6_1VO> suimRptBody1_6_1List = sqlSession.selectList("SuimRptBodyMapper.getPrint1_6_1List", suimRptBody1_13467Vo.getRptPrintNo());
				
				/*Print1_6_8 정보 추출*/
				List<SuimRptBody1_8VO> suimRptBody1_8List = sqlSession.selectList("SuimRptBodyMapper.getPrint1_8List", suimRptBody1_13467Vo.getRptPrintNo());
				
				/*Print1_2 개행 처리 */
				for (int i = 0; i < suimRptBody1_2List.size(); i++) {
					suimRptBody1_2List.get(i).setOtherInsuDtl(suimRptBody1_2List.get(i).getOtherInsuDtl().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				}
				
				/*Print1_6_1 개행 처리 */
				for (int i = 0; i < suimRptBody1_6_1List.size(); i++) {
					suimRptBody1_6_1List.get(i).setInvestigateDtl(suimRptBody1_6_1List.get(i).getInvestigateDtl().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				}
				
				/*Print1_6_2 정보 추출*/
				List<SuimRptBody1_6_2VO> suimRptBody1_6_2List = sqlSession.selectList("SuimRptBodyMapper.getPrint1_6_2List", suimRptBody1_13467Vo.getRptPrintNo());
				
				/*Print1_6_1 개행 처리 */
				for (int i = 0; i < suimRptBody1_6_2List.size(); i++) {
					suimRptBody1_6_2List.get(i).setConfirmDtl(suimRptBody1_6_2List.get(i).getConfirmDtl().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				}
				
				/*Print_5 개행 처리 Print*/
				for (int i = 0; i < suimRptBody1_5List.size(); i++) {
					suimRptBody1_5List.get(i).setProcessDtl(suimRptBody1_5List.get(i).getProcessDtl().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				}
				
				//inVO.setmContents(inVO.getmContents().replace("\n", "<br>"));
				suimRptBody1_13467Vo.setInspectPoint4Span(suimRptBody1_13467Vo.getInspectPoint4());
				suimRptBody1_13467Vo.setInspectResult4Span(suimRptBody1_13467Vo.getInspectResult4());
				
				/*조사사항 개행처리*/
				suimRptBody1_13467Vo.setInspectPoint4(suimRptBody1_13467Vo.getInspectPoint4().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody1_13467Vo.setInspectResult4(suimRptBody1_13467Vo.getInspectResult4().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				
				/*6.다-1 조사내용 개행처리*/
				suimRptBody1_13467Vo.setPastRespect6(suimRptBody1_13467Vo.getPastRespect6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody1_13467Vo.setPastHospital6(suimRptBody1_13467Vo.getPastHospital6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody1_13467Vo.setPastResult6(suimRptBody1_13467Vo.getPastResult6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				
				/*조사내용 개행처리*/
				suimRptBody1_13467Vo.setFaceInsuredJob6(suimRptBody1_13467Vo.getFaceInsuredJob6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody1_13467Vo.setFaceContractSituation6(suimRptBody1_13467Vo.getFaceContractSituation6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody1_13467Vo.setFaceEtcMemo6(suimRptBody1_13467Vo.getFaceEtcMemo6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody1_13467Vo.setFaceInformSignYn6(suimRptBody1_13467Vo.getFaceInformSignYn6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody1_13467Vo.setFaceOccurSituation6(suimRptBody1_13467Vo.getFaceOccurSituation6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				
				/*손해사정 결과 개행처리*/
				suimRptBody1_13467Vo.setAdjustResult7(suimRptBody1_13467Vo.getAdjustResult7().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				
				/*사고사항 개행처리*/
				suimRptBody1_13467Vo.setAccidentDtl3(suimRptBody1_13467Vo.getAccidentDtl3().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody1_13467Vo.setClaimDtl3(suimRptBody1_13467Vo.getClaimDtl3().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				
				/*보고서 이미지 추출*/
				List<SuimRptImgPrint_1VO> suimRptImgPrint_1List = sqlSession.selectList("SuimRptBodyMapper.getRptPrint1ImgList", suim_rpt_no);

				GetImageBase64 imgUtil = new GetImageBase64();
				for (int i = 0; i < suimRptImgPrint_1List.size(); i++) {
					suimRptImgPrint_1List.get(i).setImgStream(
						imgUtil.getOneImgeBase64("/home/hosting_users/toplac/www"+suimRptImgPrint_1List.get(i).getFilePath()+suimRptImgPrint_1List.get(i).getImgName(),
								suimRptImgPrint_1List.get(i).getImgName().substring(suimRptImgPrint_1List.get(i).getImgName().lastIndexOf(".")+1, suimRptImgPrint_1List.get(i).getImgName().length())
						)
					);
				}
				
				model.addAttribute("suimRptImgPrint_1List",suimRptImgPrint_1List);
				model.addAttribute("suimRptBody1_8List",suimRptBody1_8List);
				model.addAttribute("suimRptBody1_6_2List",suimRptBody1_6_2List);
				model.addAttribute("suimRptBody1_6_1List",suimRptBody1_6_1List);
				model.addAttribute("suimRptBody1_5List",suimRptBody1_5List);
				model.addAttribute("suimRptBody1_2List",suimRptBody1_2List);
				model.addAttribute("suimRptBody1_13467Vo",suimRptBody1_13467Vo);
						
			}else if(suimListDtlVO.getSuim_rpt_type2().equals("1001")){ // 단순 보고서 
				SuimPrint1001 print1001 = new SuimPrint1001();
				print1001.SuimPrint1001_print1(sqlSession,model,suim_rpt_no);
				
			}else if(suimListDtlVO.getSuim_rpt_type2().equals("909999")){ // 인보험 롯데 건의 경우 Print_9 정보 추출
				//==============================================
				// 인보험 롯데건 일경우 따로 처리
				// 이구문이 실행 안되도록 9에서 909999로 변경함
				// 2017.08.30 khs
				//==============================================

				SuimRptBody9_13467VO suimRptBody9_13467Vo = sqlSession.selectOne("SuimRptBodyMapper.getPrint9ForDtl", suim_rpt_no);
				
				/*print1_13467 2단계 : Print 정보 없을 경우, 신규 입력함 */
				if(suimRptBody9_13467Vo == null){
					int nextBody9_13467Serial = sqlSession.selectOne("SuimRptBodyMapper.nextBody9_13467");
					sqlSession.insert("SuimRptBodyMapper.insBody9_13467", suim_rpt_no);
					
					/*직전 입력한 Print 정보를 추출하여 전달*/
					suimRptBody9_13467Vo = sqlSession.selectOne("SuimRptBodyMapper.getBody9_13467AfterIns", nextBody9_13467Serial);
				}
				
				/*계약확인사항 개행처리*/
				suimRptBody9_13467Vo.setInsuMortgage1(suimRptBody9_13467Vo.getInsuMortgage1().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody9_13467Vo.setInsuMortgageDtl1(suimRptBody9_13467Vo.getInsuMortgageDtl1().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody9_13467Vo.setInsuredJob1(suimRptBody9_13467Vo.getInsuredJob1().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				
				/*조사결과(요약) 개행처리*/
				suimRptBody9_13467Vo.setDiagnosisDisease3(suimRptBody9_13467Vo.getDiagnosisDisease3().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody9_13467Vo.setAccidentDtl3(suimRptBody9_13467Vo.getAccidentDtl3().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody9_13467Vo.setInspectPoint3(suimRptBody9_13467Vo.getInspectPoint3().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody9_13467Vo.setInspectResult3(suimRptBody9_13467Vo.getInspectResult3().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				
				/*조사내용(요약) : 가. 피보험자 면담사항 개행처리*/
				suimRptBody9_13467Vo.setFaceContractSituation4(suimRptBody9_13467Vo.getFaceContractSituation4().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody9_13467Vo.setFaceInformSignYn4(suimRptBody9_13467Vo.getFaceInformSignYn4().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody9_13467Vo.setFaceOtherInsuMemo4(suimRptBody9_13467Vo.getFaceOtherInsuMemo4().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody9_13467Vo.setFaceInsuredDemand4(suimRptBody9_13467Vo.getFaceInsuredDemand4().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				
				/*기타 병원 확인결과 개행처리*/
				suimRptBody9_13467Vo.setHospitalMemo6(suimRptBody9_13467Vo.getHospitalMemo6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020").replaceAll("&nbsp;", "\u0020"));
				
				/*조사결과 개행처리*/
				suimRptBody9_13467Vo.setDetailRecord7(suimRptBody9_13467Vo.getDetailRecord7().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020").replaceAll("&nbsp;", "\u0020"));
				
				/*피보험자 병력사항 요약 경과표*/
				List<SuimRptBody9_3aVO> SuimRptBody9_3aList = sqlSession.selectList("SuimRptBodyMapper.getPrint9_3aList",suimRptBody9_13467Vo.getRptPrintNo());
				
				/*병력사항 요약 경과표 개행처리*/
				for (int i = 0; i < SuimRptBody9_3aList.size(); i++) {
					SuimRptBody9_3aList.get(i).setProcessDtl(SuimRptBody9_3aList.get(i).getProcessDtl().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				}
				
				/*타 보험사 계약사항*/
				List<SuimRptBody9_3cVO> SuimRptBody9_3cList = sqlSession.selectList("SuimRptBodyMapper.getPrint9_3cList",suimRptBody9_13467Vo.getRptPrintNo());
				
				for (int i = 0; i < SuimRptBody9_3cList.size(); i++) {
					SuimRptBody9_3cList.get(i).setOtherInsuContract(SuimRptBody9_3cList.get(i).getOtherInsuContract().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
					SuimRptBody9_3cList.get(i).setOtherInsuProcess(SuimRptBody9_3cList.get(i).getOtherInsuProcess().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
					SuimRptBody9_3cList.get(i).setOtherInsuEtcMemo(SuimRptBody9_3cList.get(i).getOtherInsuEtcMemo().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				}
						
				/*피보험자 조사내용*/
				List<SuimRptBody9_3dVO> SuimRptBody9_3dList = sqlSession.selectList("SuimRptBodyMapper.getPrint9_3dList",suimRptBody9_13467Vo.getRptPrintNo());
				
				for (int i = 0; i < SuimRptBody9_3dList.size(); i++) {
					SuimRptBody9_3dList.get(i).setInvestigateDtl(SuimRptBody9_3dList.get(i).getInvestigateDtl().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				}
				
				/*Print1_6_8 정보 추출*/
				List<SuimRptBody1_8VO> suimRptBody9_fileList = sqlSession.selectList("SuimRptBodyMapper.getPrint9_fileList", suimRptBody9_13467Vo.getRptPrintNo());
				
				/** 사고처리과정표 - 처리과정 **/
				List<SuimPrint1001VO> print_9_ctrl = sqlSession.selectList("SuimRptBodyMapper.get9Print_9_ctrl", suimRptBody9_13467Vo.getRptPrintNo());
				SuimPrint1001VO print_9_ctrl_delay_cnt = sqlSession.selectOne("SuimRptBodyMapper.get9Print_9_ctrl_delay_cnt", suimRptBody9_13467Vo.getRptPrintNo());
				//지연주체가 보험사인 경우의 지연 일수의 합.
				int insuDelayCnt = 0;
				for(int i=0; i < print_9_ctrl.size() ;i++){
					if ( print_9_ctrl.get(i).getControlDelayCnt() != null && !print_9_ctrl.get(i).getControlDelayCnt().equals("") ){
						if ( print_9_ctrl.get(i).getControlDelayAgent().equals("1") ){
							insuDelayCnt += Integer.parseInt( print_9_ctrl.get(i).getControlDelayCnt() ) ;
						}
					}
				}
				model.addAttribute("insuDelayCnt",insuDelayCnt);
				model.addAttribute("print_9_ctrl",print_9_ctrl);
				model.addAttribute("print_9_ctrl_delay_cnt",print_9_ctrl_delay_cnt);
				
				model.addAttribute("suimRptBody9_fileList",suimRptBody9_fileList);
				model.addAttribute("SuimRptBody9_3dList",SuimRptBody9_3dList);
				model.addAttribute("SuimRptBody9_3cList",SuimRptBody9_3cList);
				model.addAttribute("SuimRptBody9_3aList",SuimRptBody9_3aList);
				model.addAttribute("suimRptBody9_13467Vo",suimRptBody9_13467Vo);

			}else if(suimListDtlVO.getSuim_rpt_type2().equals("16")){ // 인보험 메리츠 건의 경우 Print_16 정보 추출
						
				SuimRptBody16_1267VO suimRptBody16_1267Vo = sqlSession.selectOne("SuimRptBodyMapper.getPrint16ForDtl", suim_rpt_no);
				
				/*print1_13467 2단계 : Print 정보 없을 경우, 신규 입력함 */
				if(suimRptBody16_1267Vo == null){
					int nextBody16_1267Serial = sqlSession.selectOne("SuimRptBodyMapper.nextBody16_1267");
					sqlSession.insert("SuimRptBodyMapper.insBody16_1267", suim_rpt_no);
					
					/*직전 입력한 Print 정보를 추출하여 전달*/
					suimRptBody16_1267Vo = sqlSession.selectOne("SuimRptBodyMapper.getBody16_1267AfterIns", nextBody16_1267Serial);
				}
				
				/*Print_16 개행처리*/
				suimRptBody16_1267Vo.setAccidentSumUp1(suimRptBody16_1267Vo.getAccidentSumUp1().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody16_1267Vo.setAmtEstimatedDmgDtl1(suimRptBody16_1267Vo.getAmtEstimatedDmgDtl1().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody16_1267Vo.setAmtTotInsu1(suimRptBody16_1267Vo.getAmtTotInsu1().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody16_1267Vo.setContractState1(suimRptBody16_1267Vo.getContractState1().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody16_1267Vo.setDiagnosisCode1(suimRptBody16_1267Vo.getDiagnosisCode1().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody16_1267Vo.setDiagnosisDisease1(suimRptBody16_1267Vo.getDiagnosisDisease1().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody16_1267Vo.setInsuMortgageDtl1(suimRptBody16_1267Vo.getInsuMortgageDtl1().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody16_1267Vo.setInsuPeriodE1(suimRptBody16_1267Vo.getInsuPeriodE1().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody16_1267Vo.setInsuPeriodS1(suimRptBody16_1267Vo.getInsuPeriodS1().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody16_1267Vo.setJobGradeAccident1(suimRptBody16_1267Vo.getJobGradeAccident1().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody16_1267Vo.setJobGradeJoin1(suimRptBody16_1267Vo.getJobGradeJoin1().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				
				suimRptBody16_1267Vo.setClaimDtl2(suimRptBody16_1267Vo.getClaimDtl2().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody16_1267Vo.setComplaintAvoidActivity2(suimRptBody16_1267Vo.getComplaintAvoidActivity2().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody16_1267Vo.setInspectResult2(suimRptBody16_1267Vo.getInspectResult2().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				
				suimRptBody16_1267Vo.setConfirmPublic6(suimRptBody16_1267Vo.getConfirmPublic6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody16_1267Vo.setCounselLegal6(suimRptBody16_1267Vo.getCounselLegal6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody16_1267Vo.setCounselMedical6(suimRptBody16_1267Vo.getCounselMedical6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody16_1267Vo.setDisability6(suimRptBody16_1267Vo.getDisability6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody16_1267Vo.setJobGradeConfirm6(suimRptBody16_1267Vo.getJobGradeConfirm6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody16_1267Vo.setNoticeDuty16(suimRptBody16_1267Vo.getNoticeDuty16().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody16_1267Vo.setNoticeDuty26(suimRptBody16_1267Vo.getNoticeDuty26().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody16_1267Vo.setSitePicture6(suimRptBody16_1267Vo.getSitePicture6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody16_1267Vo.setAccidentDtl6(suimRptBody16_1267Vo.getAccidentDtl6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
						
				suimRptBody16_1267Vo.setDelegate7(suimRptBody16_1267Vo.getDelegate7().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody16_1267Vo.setQuestioning7(suimRptBody16_1267Vo.getQuestioning7().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody16_1267Vo.setMoreDocument7(suimRptBody16_1267Vo.getMoreDocument7().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody16_1267Vo.setGuideEtc7(suimRptBody16_1267Vo.getGuideEtc7().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody16_1267Vo.setFaceMemo7(suimRptBody16_1267Vo.getFaceMemo7().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				
				/*Print16_3 : B 추출*/
				List<SuimRptBody16_3VO> suimRptBody16_3BList = sqlSession.selectList("SuimRptBodyMapper.getPrint16_3BList",suimRptBody16_1267Vo.getRptPrintNo());
				
				for (int i = 0; i < suimRptBody16_3BList.size(); i++) {
					suimRptBody16_3BList.get(i).setConfirmDate(suimRptBody16_3BList.get(i).getConfirmDate().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
					suimRptBody16_3BList.get(i).setConfirmDtl(suimRptBody16_3BList.get(i).getConfirmDtl().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
					suimRptBody16_3BList.get(i).setRelativeOrgan(suimRptBody16_3BList.get(i).getRelativeOrgan().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				}
				
				/*Print16_3 : D 추출*/
				List<SuimRptBody16_3VO> suimRptBody16_3DList = sqlSession.selectList("SuimRptBodyMapper.getPrint16_3DList",suimRptBody16_1267Vo.getRptPrintNo());
				
				for (int i = 0; i < suimRptBody16_3DList.size(); i++) {
					suimRptBody16_3DList.get(i).setConfirmDate(suimRptBody16_3DList.get(i).getConfirmDate().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
					suimRptBody16_3DList.get(i).setConfirmDtl(suimRptBody16_3DList.get(i).getConfirmDtl().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
					suimRptBody16_3DList.get(i).setRelativeOrgan(suimRptBody16_3DList.get(i).getRelativeOrgan().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				}
				
				
				/*Print16_3 : A 추출*/
				List<SuimRptBody16_3VO> suimRptBody16_3AList = sqlSession.selectList("SuimRptBodyMapper.getPrint16_3AList",suimRptBody16_1267Vo.getRptPrintNo());
				
				for (int i = 0; i < suimRptBody16_3AList.size(); i++) {
					suimRptBody16_3AList.get(i).setConfirmDate(suimRptBody16_3AList.get(i).getConfirmDate().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
					suimRptBody16_3AList.get(i).setConfirmDtl(suimRptBody16_3AList.get(i).getConfirmDtl().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
					suimRptBody16_3AList.get(i).setRelativeOrgan(suimRptBody16_3AList.get(i).getRelativeOrgan().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				}
				
						
				/*Print16_4 : 추출*/
				List<SuimRptBody16_4VO> suimRptBody16_4List = sqlSession.selectList("SuimRptBodyMapper.getPrint16_4List",suimRptBody16_1267Vo.getRptPrintNo());
				
				for (int i = 0; i < suimRptBody16_4List.size(); i++) {
					suimRptBody16_4List.get(i).setOtherInsuCom(suimRptBody16_4List.get(i).getOtherInsuCom().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
					suimRptBody16_4List.get(i).setOtherInsuEtcMemo(suimRptBody16_4List.get(i).getOtherInsuEtcMemo().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
					suimRptBody16_4List.get(i).setOtherInsuMortgage(suimRptBody16_4List.get(i).getOtherInsuMortgage().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
					suimRptBody16_4List.get(i).setOtherInsuPeriod(suimRptBody16_4List.get(i).getOtherInsuPeriod().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				}
				
				model.addAttribute("suimRptBody16_3BList",suimRptBody16_3BList);
				model.addAttribute("suimRptBody16_3DList",suimRptBody16_3DList);
				model.addAttribute("suimRptBody16_3AList",suimRptBody16_3AList);
				
				model.addAttribute("suimRptBody16_4List",suimRptBody16_4List);
				
				model.addAttribute("suimRptBody16_1267Vo",suimRptBody16_1267Vo);
				
				//인보험 메리츠 인경우 중간보고서 탭을 추가하기위해 paraMeter 추가 by top3009 
				model.addAttribute("middle_report_16", 1);
				
			}else if(suimListDtlVO.getSuim_rpt_type2().equals("17")){ // 인보험 흥국 일반 건의 경우 Print_17 정보 추출
				
				SuimRptBody17_1356891112VO suimRptBody17_1356891112Vo = sqlSession.selectOne("SuimRptBodyMapper.getPrint17ForDtl", suim_rpt_no);
				
				/*print1_13467 2단계 : Print 정보 없을 경우, 신규 입력함 */
				if(suimRptBody17_1356891112Vo == null){
					sqlSession.insert("SuimRptBodyMapper.insBody17_1356891112", suim_rpt_no);
					
					/*직전 입력한 Print 정보를 추출하여 전달*/
					suimRptBody17_1356891112Vo = sqlSession.selectOne("SuimRptBodyMapper.getPrint17ForDtl", suim_rpt_no);
				}
				
				/*흥국 일반 계약사항(Print17_1) 개행처리*/
				suimRptBody17_1356891112Vo.setContractPeriod1(suimRptBody17_1356891112Vo.getContractPeriod1().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody17_1356891112Vo.setAmtTotInsu1(suimRptBody17_1356891112Vo.getAmtTotInsu1().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody17_1356891112Vo.setMortgageDtl1(suimRptBody17_1356891112Vo.getMortgageDtl1().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody17_1356891112Vo.setEtc1(suimRptBody17_1356891112Vo.getEtc1().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				
				/*면담내용 개행처리*/
				suimRptBody17_1356891112Vo.setFaceDate3(suimRptBody17_1356891112Vo.getFaceDate3().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody17_1356891112Vo.setFaceDtl3(suimRptBody17_1356891112Vo.getFaceDtl3().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody17_1356891112Vo.setMoreDocument3(suimRptBody17_1356891112Vo.getMoreDocument3().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				
				/*형사기록 개행처리*/
				suimRptBody17_1356891112Vo.setRecordDocNm5(suimRptBody17_1356891112Vo.getRecordDocNm5().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody17_1356891112Vo.setRecordDtl5(suimRptBody17_1356891112Vo.getRecordDtl5().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody17_1356891112Vo.setRecordEtc5(suimRptBody17_1356891112Vo.getRecordEtc5().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody17_1356891112Vo.setRecordPublic5(suimRptBody17_1356891112Vo.getRecordPublic5().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				
				/*제3자 개입여부 개행처리*/
				suimRptBody17_1356891112Vo.setInterveneNm12(suimRptBody17_1356891112Vo.getInterveneNm12().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody17_1356891112Vo.setInterveneSituation12(suimRptBody17_1356891112Vo.getInterveneSituation12().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody17_1356891112Vo.setInterveneStaff12(suimRptBody17_1356891112Vo.getInterveneStaff12().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody17_1356891112Vo.setInterveneTel12(suimRptBody17_1356891112Vo.getInterveneTel12().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				
				/*면책여부 개행처리*/
				suimRptBody17_1356891112Vo.setExemptionBasis6(suimRptBody17_1356891112Vo.getExemptionBasis6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody17_1356891112Vo.setExemptionDtl6(suimRptBody17_1356891112Vo.getExemptionDtl6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody17_1356891112Vo.setExemptionProve6(suimRptBody17_1356891112Vo.getExemptionProve6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				
				/*계약체결경위 개행처리*/
				suimRptBody17_1356891112Vo.setContractRelation8(suimRptBody17_1356891112Vo.getContractRelation8().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody17_1356891112Vo.setContractAgent8(suimRptBody17_1356891112Vo.getContractAgent8().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody17_1356891112Vo.setContractSituation8(suimRptBody17_1356891112Vo.getContractSituation8().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				
				/*조사결과요약 개행처리*/
				suimRptBody17_1356891112Vo.setInspectBasis9(suimRptBody17_1356891112Vo.getInspectBasis9().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody17_1356891112Vo.setInspectInsist9(suimRptBody17_1356891112Vo.getInspectInsist9().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody17_1356891112Vo.setInspectResult9(suimRptBody17_1356891112Vo.getInspectResult9().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
						
				/*청구내용 추출*/
				SuimRptBody17_2VO suimRptBody17_2Vo = sqlSession.selectOne("SuimRptBodyMapper.getPrint17_2", suim_rpt_no);
				
				if(suimRptBody17_2Vo == null){
					sqlSession.insert("SuimRptBodyMapper.insBody17_2", suim_rpt_no);
					
					/*직전 입력한 Print 정보를 추출하여 전달*/
					suimRptBody17_2Vo = sqlSession.selectOne("SuimRptBodyMapper.getPrint17_2", suim_rpt_no);
				}
				
				/*청구내용 개행처리*/
				suimRptBody17_2Vo.setChungguDtl1(suimRptBody17_2Vo.getChungguDtl1().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody17_2Vo.setChungguDtl2(suimRptBody17_2Vo.getChungguDtl2().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody17_2Vo.setChungguDtl3(suimRptBody17_2Vo.getChungguDtl3().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody17_2Vo.setChungguDtl4(suimRptBody17_2Vo.getChungguDtl4().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody17_2Vo.setChungguDtl5(suimRptBody17_2Vo.getChungguDtl5().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody17_2Vo.setChungguDtl6(suimRptBody17_2Vo.getChungguDtl6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody17_2Vo.setChungguDtl7(suimRptBody17_2Vo.getChungguDtl7().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody17_2Vo.setChungguDtl8(suimRptBody17_2Vo.getChungguDtl8().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody17_2Vo.setChungguDtl9(suimRptBody17_2Vo.getChungguDtl9().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody17_2Vo.setChungguDtl10(suimRptBody17_2Vo.getChungguDtl10().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));

				/*타사가입 목록 추출*/
				List<SuimRptBody17_4VO> suimRptBody17_4List = sqlSession.selectList("SuimRptBodyMapper.getPrint17_4List", suim_rpt_no);
				
				/*치료력 목록 추출*/
				List<SuimRptBody17_7VO> suimRptBody17_7List = sqlSession.selectList("SuimRptBodyMapper.getPrint17_7List", suim_rpt_no);
				
				for (int i = 0; i < suimRptBody17_7List.size(); i++) {
					
					suimRptBody17_7List.get(i).setMedicalHistoryDiagnosis(suimRptBody17_7List.get(i).getMedicalHistoryDiagnosis().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
					suimRptBody17_7List.get(i).setMedicalHistoryHospital(suimRptBody17_7List.get(i).getMedicalHistoryHospital().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
					suimRptBody17_7List.get(i).setMedicalHistoryMedicine(suimRptBody17_7List.get(i).getMedicalHistoryMedicine().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
					suimRptBody17_7List.get(i).setMedicalHistoryPeriod(suimRptBody17_7List.get(i).getMedicalHistoryPeriod().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
					suimRptBody17_7List.get(i).setMedicalHistoryTest(suimRptBody17_7List.get(i).getMedicalHistoryTest().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				}
				
				/*탐문내역 목록 추출*/
				List<SuimRptBody17_13VO> suimRptBody17_13List = sqlSession.selectList("SuimRptBodyMapper.getPrint17_13List", suim_rpt_no);
				
				model.addAttribute("suimRptBody17_13List",suimRptBody17_13List);
				model.addAttribute("suimRptBody17_7List",suimRptBody17_7List);
				model.addAttribute("suimRptBody17_4List",suimRptBody17_4List);
				
				model.addAttribute("suimRptBody17_2Vo",suimRptBody17_2Vo);
				model.addAttribute("suimRptBody17_1356891112Vo",suimRptBody17_1356891112Vo);
				
			}else if(suimListDtlVO.getSuim_rpt_type2().equals("1700")){ // 인보험 흥국 의료 건의 경우 Print_1700 정보 추출
						
				SuimRptBody1700VO suimRptBody1700Vo = sqlSession.selectOne("SuimRptBodyMapper.getPrint1700ForDtl", suim_rpt_no);
				
				/*print1700  : Print 정보 없을 경우, 신규 입력함 */
				if(suimRptBody1700Vo == null){
					sqlSession.insert("SuimRptBodyMapper.insBody1700", suim_rpt_no);
					
					/*직전 입력한 Print 정보를 추출하여 전달*/
					suimRptBody1700Vo = sqlSession.selectOne("SuimRptBodyMapper.getPrint1700ForDtl", suim_rpt_no);
				}
				
				/*개행처리*/
				suimRptBody1700Vo.setHospital1(suimRptBody1700Vo.getHospital1().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody1700Vo.setPatientPeriod1(suimRptBody1700Vo.getPatientPeriod1().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody1700Vo.setIssue2(suimRptBody1700Vo.getIssue2().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody1700Vo.setAmtHome4(suimRptBody1700Vo.getAmtHome4().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody1700Vo.setAmtSettle4(suimRptBody1700Vo.getAmtSettle4().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody1700Vo.setBasis4(suimRptBody1700Vo.getBasis4().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody1700Vo.setEtcMemo5(suimRptBody1700Vo.getEtcMemo5().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				
				suimRptBody1700Vo.setMinwonCustomer6(suimRptBody1700Vo.getMinwonCustomer6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				suimRptBody1700Vo.setMinwonMemo6(suimRptBody1700Vo.getMinwonMemo6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
				
				suimRptBody1700Vo.setAmtReq1(Comma_won(suimRptBody1700Vo.getAmtReq1())); 
				suimRptBody1700Vo.setAmtReduce1(Comma_won(suimRptBody1700Vo.getAmtReduce1()));
				suimRptBody1700Vo.setTotSal3(Comma_won(suimRptBody1700Vo.getTotSal3()));
				suimRptBody1700Vo.setAmtHomeSum4(Comma_won(suimRptBody1700Vo.getAmtHomeSum4()));
				suimRptBody1700Vo.setAmtSettleSum4(Comma_won(suimRptBody1700Vo.getAmtSettleSum4()));
				suimRptBody1700Vo.setAmtNhis3(Comma_won(suimRptBody1700Vo.getAmtNhis3()));
				
				List<SuimRptBody1_8VO> suimRptBody1700_7List = sqlSession.selectList("SuimRptBodyMapper.getPrint1700_7List",suim_rpt_no);
				
				
				model.addAttribute("suimRptBody1700_7List",suimRptBody1700_7List);
				model.addAttribute("suimRptBody1700Vo",suimRptBody1700Vo);
				
			}

			model.addAttribute("mbrVoForBody",mbrVoForBody);
			model.addAttribute("mbrVoForBodySantion",mbrVoForBodySantion);
			model.addAttribute("tmInforForBody",topTmBscVo);
			
			
			//인보험 보고서 손해사정사 정보 추가 시작
			List<Map<String, Object>> certiManager4ReportUser = new ArrayList<Map<String, Object>>(); 

			//조사 담당자
			String sReportUserNo = String.valueOf(suimListDtlVO.getUser_no());
			
			//종결건은 담당손해사정사가 별도 저장되어있음 (top_rpt_certi_end) 저장된 손해사정사 정보가 별도로 있는지 체크(인보험용)
			int nEndCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiEndCntBy4",paramMap);        

			if( nEndCnt == 0 ) {			//정보가 없는 경우 실시간으로 가져온다.
				
				if( !"0".equals(sReportUserNo) ) {		//0은 미배당건
				
				int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
				
				//보고서 작성자를 paramMap 에 추가한다.
				paramMap.put("user_no", suimListDtlVO.getUser_no());
				
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
			//인보험 보고서 손해사정사 정보 추가 끝
		}
		
		//처리 담당자 직급 정보 추가 (미결인경우 제외)
		
		String sWorkLevelNm = "";			//처리담당자 직급
		if( Integer.parseInt(suimListDtlVO.getUser_no()) > 0 ) {
			sWorkLevelNm = sqlSession.selectOne("SuimRptBodyMapper.getMbrWorkLevelNm", suimListDtlVO.getUser_no());
			suimListDtlVO.setWork_level_nm(sWorkLevelNm);
		}	
		
		/*종결 허용 정보 추출*/
		TopEndSetupVO topEndSetupVo =  sqlSession.selectOne("SetupEndMapper.getSetupEndInfo");
		model.addAttribute("topEndSetupVo",topEndSetupVo);
		
		model.addAttribute("suimRptNoFromServer", suim_rpt_no);
		model.addAttribute("suimVO", suimListDtlVO);
		
		model.addAttribute("authFlag", "success");
		model.addAttribute("rptWriteFlag", rptWriteFlag);		
		
		//ctype 추가
		model.addAttribute("ctype",request.getParameter("ctype"));
		
		//top_rpt_head 에 손해사정서 발송상태를 확인하여 모두 완료 된경우 issue_send_result = 1로 업데이트 한다.
		int sendCnt = 0;
		
		sendCnt = sqlSession.selectOne("SuimRptBodyMapper.getIssueSendResultCnt", suim_rpt_no);
		
		if(sendCnt == 3) {			//계약자, 피보험자, 보험 청구권자 모두 교부한경우 보고서에 완료플래그를 갱신해준다.
			sqlSession.update("RptIssueMapper.updateRptIssueSendresult", suim_rpt_no);
		}else{
			sqlSession.update("RptIssueMapper.updateRptIssueCancelresult", suim_rpt_no);
		}
		
		int sendListCnt = 0;
		
		sendListCnt = sqlSession.selectOne("SuimRptBodyMapper.getIssueSendResultListCnt", suim_rpt_no);
		
		model.addAttribute("sendListCnt", sendListCnt);
		
		//보험사 양식 정보 불러오기 시작		
		paramMap.put("srchPtnrType",suimListDtlVO.getPtnr_id());		//보험사아이디
		paramMap.put("srchCategoryType",0);									//등록된 양식은 다 불러온다.
		
		//인보험 (4종)
		if( suimListDtlVO.getSuim_rpt_type1().equals("3") || suimListDtlVO.getSuim_rpt_type1().equals("4") ) {
			paramMap.put("srchTeamType", 4);			
		}else{			//물보험(1종)			
			paramMap.put("srchTeamType", 1);
		}
		
		List<InsuTemplateBean> templateList = sqlSession.selectList("BoardNoticePtnr1Mapper.insuTemplateList", paramMap);
		
		//System.out.println("templateList="+templateList.size());
		
		model.addAttribute("templateList", templateList);
		//보험사 양식 정보 불러오기 끝		
		
		return "top_suim/suim_rpt_bsc_dtl";

	}//suimRptBscDtl
	
	
	/*
	 * ***************************************
	 * Method ID : printRptDoc
	 * Method Name :  printRptDoc
	 * Description : 보고서 서류철 인쇄
	 * 
	 * Author : 이선형
	 * Date : 20160818
	 * ***************************************
	 * */
	@RequestMapping(value = "printRptDoc", method = RequestMethod.GET)
	public String printRptDoc(Model model, String suim_rpt_no) {
	
		logger.info("printRptDoc");
		
		SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", suim_rpt_no);
		
		Damo damo = new Damo();
		if (suimVo.getPolicyholder_tel() != null && !suimVo.getPolicyholder_tel().equals("")){
			suimVo.setPolicyholder_tel( damo.decodeDamo(suimVo.getPolicyholder_tel()) );
		}
		if (suimVo.getDamaged_tel() != null && !suimVo.getDamaged_tel().equals("")){
			suimVo.setDamaged_tel( damo.decodeDamo(suimVo.getDamaged_tel()) );
		}
		if (suimVo.getBeneficiary_tel() != null && !suimVo.getBeneficiary_tel().equals("")){
			suimVo.setBeneficiary_tel( damo.decodeDamo(suimVo.getBeneficiary_tel()) );
		}
		
		if (suimVo.getPtnr_mbr_hp() != null && !suimVo.getPtnr_mbr_hp().equals("")){
			suimVo.setPtnr_mbr_hp( damo.decodeDamo(suimVo.getPtnr_mbr_hp()) );
		}
		
		if (suimVo.getPtnr_mbr_office_tel() != null && !suimVo.getPtnr_mbr_office_tel().equals("")){
			suimVo.setPtnr_mbr_office_tel( damo.decodeDamo(suimVo.getPtnr_mbr_office_tel()) );
		}
		
		
		/*현재날짜계산*/
		/*
		 * Calendar cal = Calendar.getInstance(); cal.setTime(new Date());
		 * 
		 * DateFormat df = new SimpleDateFormat("yyyy-MM-dd H:mm:ss"); String timeNow =
		 * df.format(cal.getTime());
		 * 
		 * model.addAttribute("timeNow", timeNow);
		 */
		model.addAttribute("suimVo", suimVo);
		
		//return "top_suim/suim_rpt_doc_print";
		return "top_suim/suim_rpt_doc_print_new";
		
	}
	
	/*
	 * ***************************************
	 * Method ID : Comma_won
	 * Method Name :  Comma_won
	 * Description : 금액 영역 콤마 처리
	 * 
	 * 번호 1 :  
	 * Author : 이선형
	 * Date : 20160614
	 * ***************************************
	 * */
	public String Comma_won(String str) {
		
		if(str.equals("-")){
			return "-";
		}else{
			if(!str.equals("")){
				int inValues = Integer.parseInt(str);
				DecimalFormat Commas = new DecimalFormat("#,###");
				String result_int = (String)Commas.format(inValues);
				return result_int;							
			}else{
				return "";
			}
			
		}
	 }
	
	/*
	 * ***************************************
	 * Method ID : suimRptUserNoEdite
	 * Method Name :  suimRptUserNoEdite
	 * Description : 보고서 기본 정보 처리 담당자 목록 호출
	 * 
	 * 번호 1 :  
	 * Author : 이선형
	 * Date : 20160531
	 * ***************************************
	 * */
	@RequestMapping(value = "suimRptUserNoEdite", method = RequestMethod.POST)
	public void suimRptUserNoEdite(Model model, HttpSession session, String topTeamId, HttpServletResponse response) {
	
		logger.info("suimRptUserNoEdite");
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		
		PrintWriter out = null;
		
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		List<SuimRptHelpAcceptMbrVO> topMbrVoList = sqlSession.selectList("SuimBookDtlMapper.getTopMbrListForUserNoEdite",topTeamId); 
		
		JSONArray arr = new JSONArray();
		for(int i=0; i < topMbrVoList.size(); i++){
			
			SuimRptHelpAcceptMbrVO mbrVo = topMbrVoList.get(i);
			
			JSONObject obj = new JSONObject();
			
			obj.put("user_no", mbrVo.getUser_no());
			obj.put("user_name", mbrVo.getUser_name());

			arr.add(obj);
		}
		
		String jsonStr = arr.toString();
		out.print(jsonStr);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : suimRptUserNoEditeOk
	 * Method Name :  suimRptUserNoEditeOk
	 * Description : 보고서 기본 정보 처리 담당자 변경
	 * 
	 * 번호 1 :  
	 * Author : 이선형
	 * Date : 20160531
	 * ***************************************
	 * */
	@RequestMapping(value = "suimRptUserNoEditeOk", method = RequestMethod.POST)
	public void suimRptUserNoEditeOk(Model model, HttpSession session, String topUserNo, String suimRptNo, HttpServletResponse response) {
	
		logger.info("suimRptUserNoEditeOk");
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		
		PrintWriter out = null;
		
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		HashMap<String,String> map = new HashMap<String,String>();
		
		map.put("topUserNo", topUserNo);
		map.put("suimRptNo", suimRptNo);
		
		int result = sqlSession.update("SuimBookDtlMapper.rptTopUserChange", map);
		
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : suimRptSantionNoEditeOk
	 * Method Name :  suimRptSantionNoEditeOk
	 * Description : 보고서 기본 정보 결재자 변경
	 * 
	 * 번호 1 :  
	 * Author : 이선형
	 * Date : 20160628
	 * ***************************************
	 * */
	@RequestMapping(value = "suimRptSantionNoEditeOk", method = RequestMethod.POST)
	public void suimRptSantionNoEditeOk(Model model, HttpSession session, String topUserNo, String suimRptNo, HttpServletResponse response) {
	
		logger.info("suimRptSantionNoEditeOk");
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		
		PrintWriter out = null;
		
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		HashMap<String,String> map = new HashMap<String,String>();
		
		map.put("topUserNo", topUserNo);
		map.put("suimRptNo", suimRptNo);
		
		int result = sqlSession.update("SuimBookDtlMapper.rptTopSantionChange", map);
		
		out.print(result);
		out.close();
	}
	/*
	 * ***************************************
	 * Method ID : suimRptPtnrDeptMbrNoEdite
	 * Method Name :  suimRptPtnrDeptMbrNoEdite
	 * Description : 보고서 기본 정보 보험사 담당자 목록 호출
	 * 
	 * 번호 1 :  
	 * Author : 이선형
	 * Date : 20160531
	 * ***************************************
	 * */
	@RequestMapping(value = "suimRptPtnrDeptMbrNoEdite", method = RequestMethod.POST)
	public void suimRptPtnrDeptMbrNoEdite(Model model, HttpSession session, String ptnrDeptId, HttpServletResponse response) {
	
		logger.info("suimRptUserNoEdite");
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		
		PrintWriter out = null;
		
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		List<SuimRptHelpAcceptMbrVO> ptnrMbrVoList = sqlSession.selectList("SuimBookDtlMapper.getPtnrDeptMbrListForPtnrMbrNoEdite",ptnrDeptId); 
		
		JSONArray arr = new JSONArray();
		for(int i=0; i < ptnrMbrVoList.size(); i++){
			
			SuimRptHelpAcceptMbrVO ptnrMbrVo = ptnrMbrVoList.get(i);
			
			JSONObject obj = new JSONObject();
			
			obj.put("user_no", ptnrMbrVo.getUser_no());
			obj.put("user_name", ptnrMbrVo.getUser_name());

			arr.add(obj);
		}
		
		String jsonStr = arr.toString();
		out.print(jsonStr);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : suimRptPtnrMbrNoEditeOk
	 * Method Name :  suimRptPtnrMbrNoEditeOk
	 * Description : 보고서 기본 정보 보험사 담당자 변경
	 * 
	 * 번호 1 :  
	 * Author : 이선형
	 * Date : 20160531
	 * ***************************************
	 * */
	@RequestMapping(value = "suimRptPtnrMbrNoEditeOk", method = RequestMethod.POST)
	public void suimRptPtnrMbrNoEditeOk(Model model, HttpSession session, String ptnrUserNo, String suimRptNo, HttpServletResponse response) {
	
		logger.info("suimRptUserNoEditeOk");
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		
		PrintWriter out = null;
		
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		HashMap<String,String> map = new HashMap<String,String>();
		
		map.put("ptnrUserNo", ptnrUserNo);
		map.put("suimRptNo", suimRptNo);
		
		int result = sqlSession.update("SuimBookDtlMapper.rptPtnrUserChange", map);
		
		out.print(result);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : setSuim4rptAprvUser
	 * Method Name :  setSuim4rptAprvUser
	 * Description : 4종 수임건 결재자 처리
	 * Author : 임대성
	 * Date : 20161219
	 * ***************************************
	 * */
	@RequestMapping(value = "setSuim4rptAprvUser", method = RequestMethod.POST)
	public void setSuim4rptAprvUser(Model model, HttpSession session, String rptAprvUserNo, String suimRptNo, HttpServletResponse response) {
		logger.info("setSuim4rptAprvUser");
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		
		PrintWriter out = null;
		
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("rptAprvUserNo", rptAprvUserNo);
		map.put("suimRptNo", suimRptNo);
		
		int result = sqlSession.update("SuimBookDtlMapper.udtRptAprvUser", map);
		
		out.print(result);
		out.close();
	}
	
	
	
	
	
}
