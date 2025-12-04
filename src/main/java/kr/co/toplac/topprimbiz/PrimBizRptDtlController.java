/*
*********************************************************
* Program ID	: PrimbizSuimListController
* Program Name	: PrimbizSuimListController
* Description	: 농작물 수임대장 리스트
* Author		: 
* Date			: 2016.06.09.
*********************************************************
*/
package kr.co.toplac.topprimbiz;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.cmm.service.CodeDicService;
import kr.co.toplac.sysadm.SysAdmCodeDicVO;
import kr.co.toplac.topsuim.SuimRptCancelVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.etc.Damo;
import kr.co.toplac.util.etc.SplitPhoneNo;

@Controller
public class PrimBizRptDtlController {

	private static final Logger logger = LoggerFactory.getLogger(PrimBizRptDtlController.class);

	@Autowired
	private SqlSession sqlSession;
	
    @Autowired
    private CodeDicService service;
    
	@RequestMapping(value = "primBizRptDtl", method = RequestMethod.GET)
	public String primBizRptDtl(Model model, HttpSession session, TopPrimBizRptCompositeVO inVO, String saveFlag) {

		logger.info("======= primBizRptDtl =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || mbrVo.getUser_no() == ""){
			logger.info("primBizRptDtl - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		inVO.setPresent_user_no(mbrVo.getUser_no());

		/*검색에 사용될 팀목록 추출 시작*/
		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
		model.addAttribute("teamList", teamList);
		/*검색에 사용될 팀목록 추출 끝*/

		/*suim_rpt_type1_close12 start*/
		List<SysAdmCodeDicVO> type1Close12List = sqlSession.selectList("PrimBizRptDtlMapper.primBizRptType1Close12List");
		model.addAttribute("type1Close12List", type1Close12List);
		/*suim_rpt_type1_close12 end*/
		
		
		//기준업무량 년도 구분
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

		inVO.setYear(String.valueOf(year));
		/*보고서 기본정보 추출 시작*/
		TopPrimBizRptCompositeVO primBizRptDtl = sqlSession.selectOne("PrimBizRptDtlMapper.getPrimBizRptDtl", inVO);
		model.addAttribute("primBizRptDtl", primBizRptDtl);
		/*보고서 기본정보 추출 끝*/
		
		Damo damo = new Damo(); //디아모 암호화 적용 클래스 생성
		if (primBizRptDtl.getPolicyholder_ssn() != null || primBizRptDtl.getPolicyholder_ssn() != ""){
			primBizRptDtl.setPolicyholder_ssn( damo.decodeDamo(primBizRptDtl.getPolicyholder_ssn()) );
		}
		if (primBizRptDtl.getPolicyholder_tel() != null || primBizRptDtl.getPolicyholder_tel() != ""){
			primBizRptDtl.setPolicyholder_tel( damo.decodeDamo(primBizRptDtl.getPolicyholder_tel()) );
		}
		if (primBizRptDtl.getBeneficiary_ssn() != null || primBizRptDtl.getBeneficiary_ssn() != ""){
			primBizRptDtl.setBeneficiary_ssn( damo.decodeDamo(primBizRptDtl.getBeneficiary_ssn()) );
		}
		if (primBizRptDtl.getBeneficiary_tel() != null || primBizRptDtl.getBeneficiary_tel() != ""){
			primBizRptDtl.setBeneficiary_tel( damo.decodeDamo(primBizRptDtl.getBeneficiary_tel()) );
		}
		if (primBizRptDtl.getDamaged_tel() != null || primBizRptDtl.getDamaged_tel() != ""){
			primBizRptDtl.setDamaged_tel( damo.decodeDamo(primBizRptDtl.getDamaged_tel()) );
		}
		if (primBizRptDtl.getInvestigate_addr1() != null || primBizRptDtl.getInvestigate_addr1() != ""){
			primBizRptDtl.setInvestigate_addr1( damo.decodeDamo(primBizRptDtl.getInvestigate_addr1()) );
		}
		if (primBizRptDtl.getPtnr_mbr_hp() != null || primBizRptDtl.getPtnr_mbr_hp() != ""){
			primBizRptDtl.setPtnr_mbr_hp( damo.decodeDamo(primBizRptDtl.getPtnr_mbr_hp()) );
		}

		SplitPhoneNo splitPhoneNo = new SplitPhoneNo();
		/*계약자 핸드폰*/
		if((primBizRptDtl.getPolicyholder_tel() != null) && (!primBizRptDtl.getPolicyholder_tel().equals(""))){
			splitPhoneNo.splitPhoneNo(model, primBizRptDtl.getPolicyholder_tel(), "-", "policyholder_tel");
		}
		/*피보험자 핸드폰*/
		if((primBizRptDtl.getBeneficiary_tel() != null) && (!primBizRptDtl.getBeneficiary_tel().equals(""))){
			splitPhoneNo.splitPhoneNo(model, primBizRptDtl.getBeneficiary_tel(), "-", "beneficiary_tel");
		}
		/*피해자 핸드폰*/
		if((primBizRptDtl.getDamaged_tel() != null) && (!primBizRptDtl.getDamaged_tel().equals(""))){
			splitPhoneNo.splitPhoneNo(model, primBizRptDtl.getDamaged_tel(), "-", "damaged_tel");
		}
		
		//공동수행자에 속하면 조회 권한을 준다.		
		int nCollaboAuth = sqlSession.selectOne("PrimBizSuimDtlMapper.selectCollaboAuthChk", inVO);
		
		if( nCollaboAuth > 0 ) {
			primBizRptDtl.setRead_yn(String.valueOf(nCollaboAuth));
		}

		/*공동조사자 정보 추출 시작*/
		List<TopPrimBizRptCompositeVO> primBizShareList = sqlSession.selectList("PrimBizRptDtlMapper.getPrimBizShareList", inVO);
		model.addAttribute("primBizShareList", primBizShareList);
		/*공동조사자 정보 추출 끝*/

		/*보고서 원본 파일 정보 추출 시작*/
		List<TopPrimBizRptOrgFileVO> rptOrgFileList  = sqlSession.selectList("PrimBizRptDtlMapper.rptOrgFileList", inVO);
		model.addAttribute("rptOrgFileList", rptOrgFileList);
		/*보고서 원본 파일 정보 추출 끝*/

		model.addAttribute("saveFlag", saveFlag);
		
		/**** 170801 위임취소 프로세스 추가 ****/
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("suimRptNo", inVO.getSuim_rpt_no());
		paramMap.put("processChk", "2");
		
		SuimRptCancelVO rptCancel = sqlSession.selectOne("SuimRptCancelMapper.getRptCancel",paramMap);
		model.addAttribute("processChk","2"); //수임 : 농작물 구분 FLAG
		model.addAttribute("rptCancel", rptCancel);
		
		//기준 업무량 코드
        SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();
        codeVo.setTbl_nm("top_rpt_head");
        codeVo.setCol_nm("workload_type_"+year);
        List<SysAdmCodeDicVO> workloadTypeList = service.codeList2(codeVo);
        model.addAttribute("workloadTypeList",workloadTypeList);

		return "top_prim_biz/prim_biz_rpt_dtl";
	}//primBizRptDtl
	
	@RequestMapping(value = "printPrimRpt", method = RequestMethod.GET)
	public String printPrimRpt(Model model, String suim_rpt_no, TopPrimBizRptCompositeVO inVO) {
	
		logger.info("printPrimRpt");
		
		/*보고서 기본정보 추출 시작*/
		TopPrimBizRptCompositeVO primBizRptDtl = sqlSession.selectOne("PrimBizRptDtlMapper.getPrimBizRptDtl", inVO);
		/*보고서 기본정보 추출 끝*/
		
		Damo damo = new Damo();																
		if (primBizRptDtl.getPolicyholder_tel() != null && !primBizRptDtl.getPolicyholder_tel().equals("")){
			primBizRptDtl.setPolicyholder_tel( damo.decodeDamo(primBizRptDtl.getPolicyholder_tel()) );
		}
		if (primBizRptDtl.getDamaged_tel() != null && !primBizRptDtl.getDamaged_tel().equals("")){
			primBizRptDtl.setDamaged_tel( damo.decodeDamo(primBizRptDtl.getDamaged_tel()) );
		}
		if (primBizRptDtl.getBeneficiary_tel() != null && !primBizRptDtl.getBeneficiary_tel().equals("")){
			primBizRptDtl.setBeneficiary_tel( damo.decodeDamo(primBizRptDtl.getBeneficiary_tel()) );
		}
		
		/*현재날짜계산*/
		Calendar cal = Calendar.getInstance();    
		cal.setTime(new Date());    
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd H:mm:ss");    
		String timeNow = df.format(cal.getTime());
		
		model.addAttribute("timeNow", timeNow);
		model.addAttribute("primBizRptDtl", primBizRptDtl);
		
		return "top_prim_biz/prim_biz_rpt_print";	
		
	}

}//end of class
