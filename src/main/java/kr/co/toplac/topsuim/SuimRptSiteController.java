package kr.co.toplac.topsuim;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import kr.co.toplac.util.etc.Damo;
import kr.co.toplac.util.etc.SplitPhoneNo;
import kr.co.toplac.util.file.FileUpload;
import kr.co.toplac.util.file.GetImageBase64;

@Controller
public class SuimRptSiteController {
	
private static final Logger logger = LoggerFactory.getLogger(SuimRptSiteController.class);
	
	@Autowired
	private SqlSession sqlSession;
	

	/*
	 * ***************************************
	 * Method ID : siteRptAdd
	 * Method Name :  siteRptAdd
	 * Description : 현장,중간 보고서 입력 페이지 호출
	 * 
	 * Author : 이선형
	 * Date : 20160601
	 * ***************************************
	 * */
	@RequestMapping(value = "siteRptAdd", method = RequestMethod.GET)
	public String siteRptAdd(Model model, HttpSession session, String suimRptNo, String interimFlag) {
		
		if(interimFlag.equals("site")){
			logger.info("siteRptAdd");			
		}else if(interimFlag.equals("interim")){
			logger.info("interimRptAdd");
		}else{
            logger.info("ProgressRptAdd");
		}
		
		SuimRptSiteCompositeVO suimListDtl = sqlSession.selectOne("SuimRptSiteMapper.getSuimBookDtl", suimRptNo);
		
		Damo damo = new Damo();
		if ( suimListDtl.getPtnrMbrHp()!=null && !suimListDtl.getPtnrMbrHp().equals("") ){
			suimListDtl.setPtnrMbrHp( damo.decodeDamo(suimListDtl.getPtnrMbrHp()) );
		}
		
		/*계약자 주민번호*/
		if(suimListDtl.getPolicyholderSsn() != null && !suimListDtl.getPolicyholderSsn().equals("")){
			suimListDtl.setPolicyholderSsn( damo.decodeDamo(suimListDtl.getPolicyholderSsn()) );
			String[]  policyholderSsn = suimListDtl.getPolicyholderSsn().split("-");
			/*
			if(policyholderSsn.length > 1){
				model.addAttribute("policyholderSsn1", policyholderSsn[0]);
				model.addAttribute("policyholderSsn2", policyholderSsn[1]);					
			}
			*/
		}else{
			model.addAttribute("policyholderSsn1", "");
			model.addAttribute("policyholderSsn2", "");
		}
		
		
		/*피보험자 주민번호*/
		if(suimListDtl.getBeneficiarySsn() != null && !suimListDtl.getBeneficiarySsn().equals("")){
			suimListDtl.setBeneficiarySsn( damo.decodeDamo(suimListDtl.getBeneficiarySsn()) );
			String[]  beneficiarySsn = suimListDtl.getBeneficiarySsn().split("-");
			/*
			if(beneficiarySsn.length > 1){
				model.addAttribute("beneficiarySsn1", beneficiarySsn[0]);
				model.addAttribute("beneficiarySsn2", beneficiarySsn[1]);					
			}
			*/
		}else{
			model.addAttribute("beneficiarySsn1", "");
			model.addAttribute("beneficiarySsn2", "");
		}
		
		SplitPhoneNo telSplit = new  SplitPhoneNo();
		
		/*계약자 핸드폰*/
		if(suimListDtl.getPolicyholderTel() != null){
			suimListDtl.setPolicyholderTel( damo.decodeDamo(suimListDtl.getPolicyholderTel()) );			
			
			//전화번호가져오기 오류 수정 by top3009 (2020-02-18)
			//if(!suimListDtl.getPolicyholderTel().equals("") && !(suimListDtl.getPolicyholderTel().length() > 12)){
			if(!suimListDtl.getPolicyholderTel().equals("") && suimListDtl.getPolicyholderTel().length() > 12){
				telSplit.splitPhoneNo(model, suimListDtl.getPolicyholderTel(), "-", "policyholder_tel");			
			}else{
				model.addAttribute("policyholder_tel_1", "");
				model.addAttribute("policyholder_tel_2", "");
				model.addAttribute("policyholder_tel_3", "");
			}			
		}
		
		/* 피해자 핸드폰 */
		if(suimListDtl.getDamagedTel() != null){
			suimListDtl.setDamagedTel( damo.decodeDamo(suimListDtl.getDamagedTel()) );
			
			//전화번호가져오기 오류 수정 by top3009 (2020-02-18)
			//if(!suimListDtl.getDamagedTel().equals("") && !(suimListDtl.getDamagedTel().length() > 12)){
			if(!suimListDtl.getDamagedTel().equals("") && suimListDtl.getDamagedTel().length() > 12){
				telSplit.splitPhoneNo(model, suimListDtl.getDamagedTel(), "-", "damaged_tel");			
			}else{
				model.addAttribute("damaged_tel_1", "");
				model.addAttribute("damaged_tel_2", "");
				model.addAttribute("damaged_tel_3", "");
			}			
		}

		model.addAttribute("suimListDtl", suimListDtl);
		
		/** 문제점 및 향후처리방안 **/
		List<SuimRptProblemVO> probList = sqlSession.selectList("SuimBookDtlMapper.getProblem",suimRptNo);
		model.addAttribute("probList", probList);
		
		List<SuimRptProblemVO> planList = sqlSession.selectList("SuimBookDtlMapper.getPlan",suimRptNo);
		model.addAttribute("planList", planList);
		/** 문제점 및 향후처리방안 **/
		

		/* 현장 중간 가장 최근 내용 가져오기 */
        SuimRptSiteVO suimRptSiteVo = sqlSession.selectOne("SuimRptSiteMapper.selectRecentSite", suimRptNo);
        model.addAttribute("suimRptSiteVo", suimRptSiteVo);


		/*현장, 중간 플래그 세팅*/
		if(interimFlag.equals("site")){
			suimListDtl.setInterimFlag("0");
			return "top_suim/pop_suim_rpt_site_add";
		}else if(interimFlag.equals("interim")){
			suimListDtl.setInterimFlag("1");
			return "top_suim/pop_suim_rpt_interim_add";
		}else{
            suimListDtl.setInterimFlag("2");
            return "top_suim/pop_suim_rpt_interim_add";
        }
		
	}
	
	/**
	 * 4종 중간손해사정서 컨트롤러 추가 by top3009
	 * @param model
	 * @param session
	 * @param suimRptSiteCompositeVo
	 * @param response
	 * @param request
	 */
	@RequestMapping(value = "addSiteRpt4", method = RequestMethod.POST)
	public void addSiteRpt4(Model model, HttpSession session, SuimRptSiteCompositeVO suimRptSiteCompositeVo, HttpServletResponse response) {

        if(suimRptSiteCompositeVo.getInterimFlag().equals("0")){
            logger.info("siteRptAdd");
        }else if(suimRptSiteCompositeVo.getInterimFlag().equals("1")){
            logger.info("interimRptAdd");
        }else{
            logger.info("ProgressRptAdd");
        }
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		
		PrintWriter out = null;
		
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		/*계약자 연락처 안들어올경우*/
		if(suimRptSiteCompositeVo.getPolicyholderContact().equals("--")){
			suimRptSiteCompositeVo.setPolicyholderContact("");
		}
		

		/*현장 보고서의 사고지역 설정*/
		suimRptSiteCompositeVo.setSiteZone(suimRptSiteCompositeVo.getInvestigateAddr1()+" "+suimRptSiteCompositeVo.getInvestigateAddr2());
		
		/*** 암호화 ***/
		Damo damo =  new Damo();
		suimRptSiteCompositeVo.setBeneficiarySsn(damo.encodeDamo(suimRptSiteCompositeVo.getBeneficiarySsn()));
		suimRptSiteCompositeVo.setPolicyholderSsn(damo.encodeDamo(suimRptSiteCompositeVo.getPolicyholderSsn()));
		
		/*현장 보고서 기본 입력*/
		int result = sqlSession.insert("SuimRptSiteMapper.insNewSiteRpt", suimRptSiteCompositeVo);
		
		/*현장,중간 보고서 ID 구하기 시작*/
		int latestSiteNo = sqlSession.selectOne("SuimRptSiteMapper.getLatestSiteNo", suimRptSiteCompositeVo);
		
		int maxSiteNoLength = 6;
		int paddNumber = maxSiteNoLength - (latestSiteNo+"").length();
		
		String siteReportId =  "T1" ;
		
		for (int i = 0; i < paddNumber; i++) {
			siteReportId += "0";
		}
		
		siteReportId += latestSiteNo;
		/*현장,중간 보고서 ID 구하기 끝*/
		
		/*현장,중간 보고서 ID 입력 시작*/
		int siteIdUdtResult = 0;
		if(result > 0){
			
			HashMap<String,String> map = new HashMap<String,String>();
			map.put("site_report_id", siteReportId);
			map.put("rpt_site_no", latestSiteNo+"");
			siteIdUdtResult = sqlSession.update("SuimRptSiteMapper.setSiteId", map );
		}
		/*현장,중간 보고서 ID 입력 끝*/
				
		/*현장,중간 보고서 업데이트 성공 시 보고서 기본 정보 수정 시작*/
		
		if(suimRptSiteCompositeVo.getAmtCompensationLimit().equals("")){
			suimRptSiteCompositeVo.setAmtCompensationLimit("0");
		} // delcimal 타입의 값이 공백으로 들어올때 
		
		int rptBscResult = 0;
		if(siteIdUdtResult > 0){
			
			/*보고서 Head 정보 수정 시작*/
			int rptHeadResult = sqlSession.update("SuimRptSiteMapper.udtRptBscHead", suimRptSiteCompositeVo);
			int rptBodyResult = sqlSession.update("SuimRptSiteMapper.udtRptBscBody", suimRptSiteCompositeVo);
			if( (rptHeadResult > 0) && (rptBodyResult >0) ){
				rptBscResult = 1;
			}
		}

		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		
		/*보고서 기본 정보 수정 성공 시*/	
		if(rptBscResult > 0){
			
			obj.put("siteDate", suimRptSiteCompositeVo.getSiteDate());
			obj.put("rptSiteNo", latestSiteNo);
			obj.put("subDate", "미제출");
			
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
	 * Method ID : addSiteRpt
	 * Method Name :  addSiteRpt
	 * Description : 현장 보고서 Insert
	 * 
	 * Author : 이선형
	 * Date : 20160603
	 * ***************************************
	 * */
	@RequestMapping(value = "addSiteRpt", method = RequestMethod.POST)
	public void addSiteRpt(Model model, HttpSession session, SuimRptSiteCompositeVO suimRptSiteCompositeVo, HttpServletResponse response, MultipartRequest request) {

        if(suimRptSiteCompositeVo.getInterimFlag().equals("0")){
            logger.info("siteRptAdd");
        }else if(suimRptSiteCompositeVo.getInterimFlag().equals("1")){
            logger.info("interimRptAdd");
        }else{
            logger.info("ProgressRptAdd");
        }

//        if(suimRptSiteCompositeVo.getInterimFlag().equals("0")){
//			logger.info("addSiteRpt");
//		}else{
//			logger.info("addInterimRpt");
//		}
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		
		PrintWriter out = null;
		
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		/*회차 구하기 시작*/
//		System.out.println(suimRptSiteCompositeVo.getOrderNo() + ":회차");
//		if (suimRptSiteCompositeVo.getOrderNo() == null){
//			suimRptSiteCompositeVo.setOrderNo(Integer.parseInt("0"));
//		}
			
//			int countExistOrderNo = sqlSession.selectOne("SuimRptSiteMapper.countExistOrderNo", suimRptSiteCompositeVo); 
//			int nextOrderNo = 0;
//			
//			if(countExistOrderNo == 0){
//				nextOrderNo = countExistOrderNo+1;
//			}else{
//				countExistOrderNo = sqlSession.selectOne("SuimRptSiteMapper.maxExistOrderNo", suimRptSiteCompositeVo);
//				nextOrderNo = countExistOrderNo+1;
//			}
//			
//			suimRptSiteCompositeVo.setOrderNo(nextOrderNo+"");
//		}
		/*회차 구하기 끝*/
		
		/*계약자 연락처 안들어올경우*/
		if(suimRptSiteCompositeVo.getPolicyholderContact().equals("--")){
			suimRptSiteCompositeVo.setPolicyholderContact("");
		}
		

		/*현장 보고서의 사고지역 설정*/
		suimRptSiteCompositeVo.setSiteZone(suimRptSiteCompositeVo.getInvestigateAddr1()+" "+suimRptSiteCompositeVo.getInvestigateAddr2());
		
		
		
		/*** 암호화 ***/
		Damo damo =  new Damo();
		suimRptSiteCompositeVo.setBeneficiarySsn(damo.encodeDamo(suimRptSiteCompositeVo.getBeneficiarySsn()));
		suimRptSiteCompositeVo.setPolicyholderSsn(damo.encodeDamo(suimRptSiteCompositeVo.getPolicyholderSsn()));
		
		
		
		/*현장 보고서 기본 입력*/
		int result = sqlSession.insert("SuimRptSiteMapper.insNewSiteRpt", suimRptSiteCompositeVo);
		
		/*현장,중간 보고서 ID 구하기 시작*/
		int latestSiteNo = sqlSession.selectOne("SuimRptSiteMapper.getLatestSiteNo", suimRptSiteCompositeVo);
		
		int maxSiteNoLength = 6;
		int paddNumber = maxSiteNoLength - (latestSiteNo+"").length();
		
		String siteReportId =  "T1" ;
		
		for (int i = 0; i < paddNumber; i++) {
			siteReportId += "0";
		}
		
		siteReportId += latestSiteNo;
		/*현장,중간 보고서 ID 구하기 끝*/
		
		/*현장,중간 보고서 ID 입력 시작*/
		int siteIdUdtResult = 0;
		if(result > 0){
			
			HashMap<String,String> map = new HashMap<String,String>();
			map.put("site_report_id", siteReportId);
			map.put("rpt_site_no", latestSiteNo+"");
			siteIdUdtResult = sqlSession.update("SuimRptSiteMapper.setSiteId", map );
		}
		/*현장,중간 보고서 ID 입력 끝*/
		
		/* 보고서 첨부파일 정보 추가 시작*/
		MultipartFile file = request.getFile("attachFile");		
		
		if( file != null ) {
			Date today = new Date();//오늘날자구하기
			DateFormat timeForNaming = new SimpleDateFormat("yyyyMMddHHmmss");
			String sigan = timeForNaming.format(today);//String형으로 변환
			String year = sigan.substring(0, 4);
			String month = sigan.substring(4, 6);
			String day = sigan.substring(6, 8);
			
			String fileName = file.getOriginalFilename();
			String fileType = fileName.substring(fileName.lastIndexOf("."), fileName.length());
			//암호화 된 8자리 값 생성
			String uid = UUID.randomUUID().toString().replaceAll("-", "").substring(0, 8);
			
			//String replaceName =  uid + fileType;  //파일 이름의 중복을 막기 위해서 이름을 재설정합니다.
			
			String replaceName = fileName;
			
			String rptSiteNo = String.valueOf(latestSiteNo); 
			
			
			String uppath = "/home/hosting_users/toplac/www/ls_data/report_other/site/"+year+"/"+month+"/"+day+"/"+rptSiteNo+"/";
			
			localUploadFunc(file, uppath, replaceName);
			/******************************파일명 DB 등록 시작********************************/
			
			uppath = "/ls_data/report_other/site/"+year+"/"+month+"/"+day+"/"+rptSiteNo+"/";
			
			HashMap<String,String> map =  new HashMap<String,String>();
			map.put("rptSiteNo", rptSiteNo);
			map.put("path", uppath);
			map.put("filename", replaceName);
			map.put("site_flag", suimRptSiteCompositeVo.getSiteFlag());
			
			result = sqlSession.update("SuimRptSiteMapper.insSiteInterimFile", map);
			
		}
		
		/* 보고서 첨부파일 정보 추가 끝*/
		
		/* 현장보고서가 일정보고서로 결재완료인 상태인 경우 정식보고서가 등록되면 정식보고서결재완료 상태로 바꾸어준다. */
		String site_result_flag = sqlSession.selectOne("SuimRptSiteMapper.selectSiteResultFlagHead", suimRptSiteCompositeVo.getSuimRptNo());
		
		if( "1".equals(site_result_flag) ){
			sqlSession.update("SuimBookUdtMapper.rptActionSiteEndEx",suimRptSiteCompositeVo.getSuimRptNo());
		}		
		
		/*현장,중간 보고서 업데이트 성공 시 보고서 기본 정보 수정 시작*/
		
		if(suimRptSiteCompositeVo.getAmtCompensationLimit().equals("")){
			suimRptSiteCompositeVo.setAmtCompensationLimit("0");
		} // delcimal 타입의 값이 공백으로 들어올때 
		
		int rptBscResult = 0;
		if(siteIdUdtResult > 0){
			
			/*보고서 Head 정보 수정 시작*/
			int rptHeadResult = sqlSession.update("SuimRptSiteMapper.udtRptBscHead", suimRptSiteCompositeVo);
			int rptBodyResult = sqlSession.update("SuimRptSiteMapper.udtRptBscBody", suimRptSiteCompositeVo);
			if( (rptHeadResult > 0) && (rptBodyResult >0) ){
				rptBscResult = 1;
			}
		}

		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		
		/*보고서 기본 정보 수정 성공 시*/	
		if(rptBscResult > 0){
			
			obj.put("siteDate", suimRptSiteCompositeVo.getSiteDate());
			obj.put("rptSiteNo", latestSiteNo);
			obj.put("subDate", "미제출");
			
			arr.add(obj);
			
			String jsonStr = arr.toString();
			out.print(jsonStr);
		}else{
			out.print(0);
		}
		out.close();
	}
	
	
	//실제 파일 업로드 함수
	public void localUploadFunc(MultipartFile file, String uppath, String replaceName){
		File dir = new File(uppath);		

		if(!dir.exists()){
			dir.mkdirs();
		}

		try {
			FileUpload.fileUpload(file, uppath, replaceName);			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * ***************************************
	 * Method ID : siteRptEdite
	 * Method Name :  siteRptEdite
	 * Description : 현장 보고서 수정 페이지 호출
	 * 
	 * Author : 이선형
	 * Date : 20160607
	 * ***************************************
	 * */
	@RequestMapping(value = "siteRptEdite", method = RequestMethod.GET)
	public String siteRptEdite(Model model, HttpSession session, String suimRptNo, String interimFlag, String rptSiteNo) {


        if(interimFlag.equals("site")){
            logger.info("siteRptAdd");
        }else if(interimFlag.equals("interim")){
            logger.info("interimRptAdd");
        }else{
            logger.info("ProgressRptAdd");
        }
		
		SuimRptSiteCompositeVO suimListDtl = sqlSession.selectOne("SuimRptSiteMapper.getSuimBookDtl", suimRptNo);
		
		Damo damo = new Damo();
		
		if ( suimListDtl.getPtnrMbrHp()!=null && !suimListDtl.getPtnrMbrHp().equals("") ){
			suimListDtl.setPtnrMbrHp( damo.decodeDamo(suimListDtl.getPtnrMbrHp()) );
		}
		/*계약자 주민번호*/
		if(suimListDtl.getPolicyholderSsn() != null && !suimListDtl.getPolicyholderSsn().equals("")){
			suimListDtl.setPolicyholderSsn( damo.decodeDamo(suimListDtl.getPolicyholderSsn()) );
			String[]  policyholderSsn = suimListDtl.getPolicyholderSsn().split("-");
			/*
			if(policyholderSsn.length > 1){
				model.addAttribute("policyholderSsn1", policyholderSsn[0]);
				model.addAttribute("policyholderSsn2", policyholderSsn[1]);					
			}
			*/
		}else{
			model.addAttribute("policyholderSsn1", "");
			model.addAttribute("policyholderSsn2", "");
		}
		
		
		/*피보험자 주민번호*/
		if(suimListDtl.getBeneficiarySsn() != null && !suimListDtl.getBeneficiarySsn().equals("")){
			suimListDtl.setBeneficiarySsn( damo.decodeDamo(suimListDtl.getBeneficiarySsn()) );
			String[]  beneficiarySsn = suimListDtl.getBeneficiarySsn().split("-");
			if(beneficiarySsn.length > 1){
				model.addAttribute("beneficiarySsn1", beneficiarySsn[0]);
				model.addAttribute("beneficiarySsn2", beneficiarySsn[1]);					
			}
		}else{
			model.addAttribute("beneficiarySsn1", "");
			model.addAttribute("beneficiarySsn2", "");
		}
		
		
		SplitPhoneNo telSplit = new  SplitPhoneNo();
		
		/*계약자 핸드폰*/
		if(suimListDtl.getPolicyholderContact() != null){
			if(!suimListDtl.getPolicyholderContact().equals("") && !(suimListDtl.getPolicyholderContact().length() > 12)){
				telSplit.splitPhoneNo(model, suimListDtl.getPolicyholderContact(), "-", "policyholder_tel");			
			}else{
				model.addAttribute("policyholder_tel_1", "");
				model.addAttribute("policyholder_tel_2", "");
				model.addAttribute("policyholder_tel_3", "");
			}			
		}
		
		/*현장, 중간 플래그 세팅*/
		if(interimFlag.equals("site")){
			suimListDtl.setInterimFlag("0");			
		}else if(interimFlag.equals("interim")){
			suimListDtl.setInterimFlag("1");
		}else if(interimFlag.equals("prgss")){
            suimListDtl.setInterimFlag("2");
        }
		
		
		/** 문제점 및 향후처리방안 **/
		List<SuimRptProblemVO> probList = sqlSession.selectList("SuimBookDtlMapper.getProblem",suimRptNo);
		model.addAttribute("probList", probList);
		
		List<SuimRptProblemVO> planList = sqlSession.selectList("SuimBookDtlMapper.getPlan",suimRptNo);
		model.addAttribute("planList", planList);
		/** 문제점 및 향후처리방안 **/
		
		model.addAttribute("suimListDtl", suimListDtl);
		
		if(interimFlag.equals("site")){
			/*현장 보고서 정보 추출*/
			SuimRptSiteVO suimRptSiteVo = sqlSession.selectOne("SuimRptSiteMapper.getSiteOne", rptSiteNo);
			model.addAttribute("suimRptSiteVo", suimRptSiteVo);			
		}else if(interimFlag.equals("interim")){
			/*중간 보고서 정보 추출*/
			SuimRptSiteVO suimRptSiteVo = sqlSession.selectOne("SuimRptSiteMapper.getInterimOne", rptSiteNo);
			model.addAttribute("suimRptSiteVo", suimRptSiteVo);
		}else{
			/*진행 경과보고서 추출*/
            SuimRptSiteVO suimRptSiteVo = sqlSession.selectOne("SuimRptSiteMapper.getPrgssOne", rptSiteNo);
            model.addAttribute("suimRptSiteVo", suimRptSiteVo);
        }
		
		/*첨부 이미지 추출 시작*/
		List<SuimRptSiteImgVO> suimRptSiteImgList = sqlSession.selectList("SuimRptSiteMapper.getSiteInterimImgList",rptSiteNo);
		
		for (int i = 0; i < suimRptSiteImgList.size(); i++) {
			String filepath = "/home/hosting_users/toplac/www"+suimRptSiteImgList.get(i).getImgPath();
			GetImageBase64 imageBaseUtil = new  GetImageBase64();
			suimRptSiteImgList.get(i).setImgStream(
				imageBaseUtil.getOneImgeBase64(filepath, 
					suimRptSiteImgList.get(i).getImgName().substring(suimRptSiteImgList.get(i).getImgName().indexOf(".")+1, 
					suimRptSiteImgList.get(i).getImgName().length()
					) // substring
				)//getOneImgeBase64
			); //setImgStream
		}
		
		model.addAttribute("suimRptSiteImgList", suimRptSiteImgList);
		model.addAttribute("suimRptSiteImgListLength", suimRptSiteImgList.size());
		model.addAttribute("interimFlag",interimFlag);
		/*첨부 이미지 추출 끝*/
		
		if(interimFlag.equals("site")){
			return "top_suim/pop_suim_rpt_site_edite";			
		}else if(interimFlag.equals("interim")){
			return "top_suim/pop_suim_rpt_interim_edite";
		}else{
            return "top_suim/pop_suim_rpt_interim_edite";
        }
		
	}
	
	/**
	 * 4종 중간보고서 수정 추가 by top3009
	 * @param model
	 * @param session
	 * @param suimRptSiteCompositeVo
	 * @param request
	 * @param out
	 */
	@RequestMapping(value = "editeSiteRpt4", method = RequestMethod.POST)
	public void editeSiteRpt4(Model model, HttpSession session, SuimRptSiteCompositeVO suimRptSiteCompositeVo, PrintWriter out) {
		if(suimRptSiteCompositeVo.getInterimFlag().equals("0")){
			logger.info("editeSiteRpt");			
		}else if(suimRptSiteCompositeVo.getInterimFlag().equals("1")){
			logger.info("editeInterimRpt");
		}else{
            logger.info("editePrgssRpt");
        }
		
		/*계약자 연락처 안들어올경우*/
		if(suimRptSiteCompositeVo.getPolicyholderContact().equals("--")){
			suimRptSiteCompositeVo.setPolicyholderContact("");
		}
		
		/**** 암호화 ****/
		Damo damo = new Damo();
		suimRptSiteCompositeVo.setPolicyholderSsn( damo.encodeDamo(suimRptSiteCompositeVo.getPolicyholderSsn()) );
		suimRptSiteCompositeVo.setBeneficiarySsn( damo.encodeDamo(suimRptSiteCompositeVo.getBeneficiarySsn()) );
		
		/*현장 보고서 수정 */
		int result = sqlSession.update("SuimRptSiteMapper.udtSiteRpt", suimRptSiteCompositeVo);
		/*현장 보고서 업데이트 성공 시 보고서 기본 정보 수정 시작*/
		
		if(suimRptSiteCompositeVo.getAmtCompensationLimit().equals("")){
			suimRptSiteCompositeVo.setAmtCompensationLimit("0");
		} // delcimal 타입의 값이 공백으로 들어올때 
		
		int rptBscResult = 0;
		if(result > 0){
			/*보고서 Head 정보 수정 시작*/
			int rptHeadResult = sqlSession.update("SuimRptSiteMapper.udtRptBscHead", suimRptSiteCompositeVo);
			int rptBodyResult = sqlSession.update("SuimRptSiteMapper.udtRptBscBody", suimRptSiteCompositeVo);
			if( (rptHeadResult > 0) && (rptBodyResult >0) ){
				rptBscResult = 1;
			}
		}
		out.print(rptBscResult);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : editeSiteRpt
	 * Method Name :  editeSiteRpt
	 * Description : 현장, 중간 보고서 update
	 * 
	 * Author : 이선형
	 * Date : 20160607
	 * ***************************************
	 * */
	@RequestMapping(value = "editeSiteRpt", method = RequestMethod.POST)
	public void editeSiteRpt(Model model, HttpSession session, SuimRptSiteCompositeVO suimRptSiteCompositeVo, MultipartRequest request, PrintWriter out) {
		if(suimRptSiteCompositeVo.getInterimFlag().equals("0")){
			logger.info("editeSiteRpt");			
		}else if(suimRptSiteCompositeVo.getInterimFlag().equals("1")){
			logger.info("editeInterimRpt");
		}else{
            logger.info("editePrgssRpt");
        }
		
		/*계약자 연락처 안들어올경우*/
		if(suimRptSiteCompositeVo.getPolicyholderContact().equals("--")){
			suimRptSiteCompositeVo.setPolicyholderContact("");
		}
		
		/**** 암호화 ****/
		Damo damo = new Damo();
		suimRptSiteCompositeVo.setPolicyholderSsn( damo.encodeDamo(suimRptSiteCompositeVo.getPolicyholderSsn()) );
		suimRptSiteCompositeVo.setBeneficiarySsn( damo.encodeDamo(suimRptSiteCompositeVo.getBeneficiarySsn()) );
		
		/*현장 보고서 수정 */
		int result = sqlSession.update("SuimRptSiteMapper.udtSiteRpt", suimRptSiteCompositeVo);
		/*현장 보고서 업데이트 성공 시 보고서 기본 정보 수정 시작*/
		
		if(suimRptSiteCompositeVo.getAmtCompensationLimit().equals("")){
			suimRptSiteCompositeVo.setAmtCompensationLimit("0");
		} // delcimal 타입의 값이 공백으로 들어올때 
		
		/* 보고서 첨부파일 정보 추가 시작*/
		String rptSiteNo = suimRptSiteCompositeVo.getRptSiteNo();
		
		MultipartFile file = request.getFile("attachFileEdit");		
		
		if( file != null ) {
			Date today = new Date();//오늘날자구하기
			DateFormat timeForNaming = new SimpleDateFormat("yyyyMMddHHmmss");
			String sigan = timeForNaming.format(today);//String형으로 변환
			String year = sigan.substring(0, 4);
			String month = sigan.substring(4, 6);
			String day = sigan.substring(6, 8);
			
			String fileName = file.getOriginalFilename();
			String fileType = fileName.substring(fileName.lastIndexOf("."), fileName.length());
			//암호화 된 8자리 값 생성
			String uid = UUID.randomUUID().toString().replaceAll("-", "").substring(0, 8);
			
			//String replaceName =  uid + fileType;  //파일 이름의 중복을 막기 위해서 이름을 재설정합니다.
			
			String replaceName = fileName;
			
			String uppath = "/home/hosting_users/toplac/www/ls_data/report_other/site/"+year+"/"+month+"/"+day+"/"+rptSiteNo+"/";
			
			localUploadFunc(file, uppath, replaceName);
			/******************************파일명 DB 등록 시작********************************/
			
			uppath = "/ls_data/report_other/site/"+year+"/"+month+"/"+day+"/"+rptSiteNo+"/";
			
			HashMap<String,String> map =  new HashMap<String,String>();
			map.put("rptSiteNo", rptSiteNo);
			map.put("path", uppath);
			map.put("filename", replaceName);
			map.put("site_flag", suimRptSiteCompositeVo.getSiteFlag());
			
			result = sqlSession.update("SuimRptSiteMapper.insSiteInterimFile", map);
			
		}
		
		/* 보고서 첨부파일 정보 추가 끝*/
		
		int rptBscResult = 0;
		if(result > 0){
			/*보고서 Head 정보 수정 시작*/
			int rptHeadResult = sqlSession.update("SuimRptSiteMapper.udtRptBscHead", suimRptSiteCompositeVo);
			int rptBodyResult = sqlSession.update("SuimRptSiteMapper.udtRptBscBody", suimRptSiteCompositeVo);
			if( (rptHeadResult > 0) && (rptBodyResult >0) ){
				rptBscResult = 1;
			}
		}
		out.print(rptBscResult);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : siteRptDel
	 * Method Name :  siteRptDel
	 * Description : 현장 보고서 삭제
	 * 번호 1 : 
	 * Author : 이선형
	 * Date : 20160607
	 * ***************************************
	 * */
	@RequestMapping(value = "siteRptDel", method = RequestMethod.POST)
	public void siteRptDel(Model model, HttpSession session, PrintWriter out, String rptSiteNo) {
		
		logger.info("siteRptDel");
		
		List<SuimRptSiteImgVO> siteImgListForDel = sqlSession.selectList("SuimRptSiteMapper.getSiteInterimImgList", rptSiteNo);
		
		/*이미지 파일 삭제*/
		if(siteImgListForDel.size() > 0){
			for (int i = 0; i < siteImgListForDel.size(); i++) {
				siteImgDelOk(siteImgListForDel.get(i).getRptSiteImgNo(), siteImgListForDel.get(i).getImgPath()); 
			}
		}
		
		/*보고서 문서 파일 삭제*/
		String siteRptNo = 	rptSiteNo;
		String filepath = "/home/hosting_users/toplac/www"+sqlSession.selectOne("SuimRptSiteMapper.getSiteFilePathForDel", siteRptNo);
		if(!filepath.equals("")){
			siteFileDelOk(filepath, siteRptNo);			
		}
	
		/*번호 1*/
		int result = sqlSession.delete("SuimRptSiteMapper.siteRptDel", rptSiteNo );

		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : interimPrintPage
	 * Method Name :  interimPrintPage
	 * Description : 현장,중간 보고서 Word 다운, 인쇄
	 * 
	 * Author : 이선형
	 * Date : 20160608
	 * ***************************************
	 * */
	@RequestMapping(value = "interimPrintPage", method = RequestMethod.GET)
	public String interimPrintPage(Model model, HttpServletResponse response, HttpSession session, String suimRptNo, String interimFlag, String rptSiteNo, String type) {
		
		if(interimFlag.equals("site")){
			logger.info("sitePrintPage");			
		}else if(interimFlag.equals("interim")){
			logger.info("interimPrintPage");
		}else{
            logger.info("ProgressPrintPage");
        }
		
		SuimRptSiteCompositeVO suimListDtl = sqlSession.selectOne("SuimRptSiteMapper.getSuimBookDtl", suimRptNo);
		
		
		Damo damo = new Damo();
		/*보험사 담당자*/
		if(suimListDtl.getPtnrMbrHp() != null && !suimListDtl.getPtnrMbrHp().equals("")){
			suimListDtl.setPtnrMbrHp( damo.decodeDamo( suimListDtl.getPtnrMbrHp()) ) ;
		}
		
		/*보험사 담당자 전화번호*/
		if(suimListDtl.getPtnr_mbr_office_tel() != null && !suimListDtl.getPtnr_mbr_office_tel().equals("")){
			suimListDtl.setPtnr_mbr_office_tel( damo.decodeDamo( suimListDtl.getPtnr_mbr_office_tel()) ) ;
		}
		
				
		/*계약자 주민번호*/
		if(suimListDtl.getPolicyholderSsn() != null){
			if(!suimListDtl.getPolicyholderSsn().equals("") && !(suimListDtl.getPolicyholderSsn().length() > 13) ){
				suimListDtl.setPolicyholderSsn( damo.decodeDamo( suimListDtl.getPolicyholderSsn()) ) ;
				String[]  policyholderSsn = suimListDtl.getPolicyholderSsn().split("-");
				/*
				if(policyholderSsn.length ==2){
					model.addAttribute("policyholderSsn1", policyholderSsn[0]);
					model.addAttribute("policyholderSsn2", policyholderSsn[1]);					
				}
				*/
			}else{
				model.addAttribute("policyholderSsn1", "");
				model.addAttribute("policyholderSsn2", "");
			}			
		}
		
		/*피보험자 주민번호*/
		if(suimListDtl.getBeneficiarySsn() != null){
			if(!suimListDtl.getBeneficiarySsn().equals("") && !(suimListDtl.getBeneficiarySsn().length() > 13) ){
				suimListDtl.setBeneficiarySsn( damo.decodeDamo( suimListDtl.getBeneficiarySsn()) ) ;
				String[]  beneficiarySsn = suimListDtl.getBeneficiarySsn().split("-");
				/*
				if(beneficiarySsn.length ==2){
					model.addAttribute("beneficiarySsn1", beneficiarySsn[0]);
					model.addAttribute("beneficiarySsn2", beneficiarySsn[1]);					
				}
				*/
			}else{
				model.addAttribute("beneficiarySsn1", "");
				model.addAttribute("beneficiarySsn2", "");
			}			
		}
		
		
		SplitPhoneNo telSplit = new  SplitPhoneNo();
		
		/*계약자 핸드폰*/
		if(suimListDtl.getPolicyholderContact() != null && !suimListDtl.getPolicyholderContact().equals("")){
			if(  !(suimListDtl.getPolicyholderContact().length() > 12)){
				telSplit.splitPhoneNo(model, suimListDtl.getPolicyholderContact(), "-", "policyholder_tel");			
			}else{
				model.addAttribute("policyholder_tel_1", "");
				model.addAttribute("policyholder_tel_2", "");
				model.addAttribute("policyholder_tel_3", "");
			}			
		}
		
		/*현장, 중간 플래그 세팅 */
		if(interimFlag.equals("site")){
			suimListDtl.setInterimFlag("0");			
		}else if(interimFlag.equals("interim")){
			suimListDtl.setInterimFlag("1");
		}else {
            suimListDtl.setInterimFlag("2");
        }
		
		model.addAttribute("suimListDtl", suimListDtl);
		
		String orderNo = "1";
		if(interimFlag.equals("site")){
			/*현장 보고서 정보 추출*/
			SuimRptSiteVO suimRptSiteVo = sqlSession.selectOne("SuimRptSiteMapper.getSiteOne", rptSiteNo);
			List<SuimRptSiteVO> OrderNoList = sqlSession.selectList("SuimRptSiteMapper.getSiteOrderNoList", suimRptNo);
			for (int i=0; i < OrderNoList.size() ; i++){
				if ( suimRptSiteVo.getRptSiteNo().equals(OrderNoList.get(i).getRptSiteNo()) ){
					orderNo = OrderNoList.get(i).getOrderNo();
					suimRptSiteVo.setOrderNo(orderNo);
					break;
				}
			}
			model.addAttribute("suimRptSiteVo", suimRptSiteVo);			
		}else if(interimFlag.equals("interim") || interimFlag.equals("prgss")) {
			/*중간 보고서 정보 추출*/
            SuimRptSiteVO suimRptSiteVo = null;
			if (interimFlag.equals("interim")){
                suimRptSiteVo = sqlSession.selectOne("SuimRptSiteMapper.getInterimOne", rptSiteNo);
            }else{
                suimRptSiteVo = sqlSession.selectOne("SuimRptSiteMapper.getPrgssOne", rptSiteNo);
            }

			
			/** 기존 정렬하던 방식이 orderNo에서 site_date로 바뀜에 따라 orderNo가 무의미해져 별도 처리 **/
			/** 파일명에도 차수가 들어가기때문에 컨트롤러단에서 처리 **/
            List<SuimRptSiteVO> OrderNoList = null;
            if (interimFlag.equals("interim")){
                OrderNoList = sqlSession.selectList("SuimRptSiteMapper.getInterimOrderNoList", suimRptNo);
            }else{
                OrderNoList = sqlSession.selectList("SuimRptSiteMapper.getPrgssOrderNoList", suimRptNo);
            }

            for (int i=0; i < OrderNoList.size() ; i++){
				if ( suimRptSiteVo.getRptSiteNo().equals(OrderNoList.get(i).getRptSiteNo()) ){
					orderNo = OrderNoList.get(i).getOrderNo();
					String tmpOrderNo = OrderNoList.get(i).getOrderNo();
					//워드파일에 번호가 이미지로 처리되어 이미지로 치환작업
					String OrderNoImg = "";
					for(int j=0; j<tmpOrderNo.length() ;j++){
						switch (tmpOrderNo.charAt(j)){
							case '0' :  OrderNoImg += "<img src=http://renew.toplac.co.kr/resources/ls_img/report/0.jpg width=20 height=56>"; break;
							case '1' :  OrderNoImg += "<img src=http://renew.toplac.co.kr/resources/ls_img/report/1.jpg width=20 height=56>"; break;
							case '2' :  OrderNoImg += "<img src=http://renew.toplac.co.kr/resources/ls_img/report/2.jpg width=20 height=56>"; break;
							case '3' :  OrderNoImg += "<img src=http://renew.toplac.co.kr/resources/ls_img/report/3.jpg width=20 height=56>"; break;
							case '4' :  OrderNoImg += "<img src=http://renew.toplac.co.kr/resources/ls_img/report/4.jpg width=20 height=56>"; break;
							case '5' :  OrderNoImg += "<img src=http://renew.toplac.co.kr/resources/ls_img/report/5.jpg width=20 height=56>"; break;
							case '6' :  OrderNoImg += "<img src=http://renew.toplac.co.kr/resources/ls_img/report/6.jpg width=20 height=56>"; break;
							case '7' :  OrderNoImg += "<img src=http://renew.toplac.co.kr/resources/ls_img/report/7.jpg width=20 height=56>"; break;
							case '8' :  OrderNoImg += "<img src=http://renew.toplac.co.kr/resources/ls_img/report/8.jpg width=20 height=56>"; break;
							case '9' :  OrderNoImg += "<img src=http://renew.toplac.co.kr/resources/ls_img/report/9.jpg width=20 height=56>"; break;
						}
					}
					suimRptSiteVo.setOrderNo(OrderNoImg);
				}
			}
			model.addAttribute("suimRptSiteVo", suimRptSiteVo);
		}
		
		String suim_rpt_no = suimRptNo; 
		
		/*사고처리 과정표 정보 추출 시작*/
		List<SuimRptSagoBscVO> sagoList  = sqlSession.selectList("SagoBscMapper.getSagoList", suim_rpt_no);
		model.addAttribute("sagoList", sagoList);
		/*사고처리 과정표 정보 추출 끝*/
		
		/* 문제점 및 향후처리방안 */
		List<SuimRptProblemVO> probList = sqlSession.selectList("SuimBookDtlMapper.getProblem",suimRptNo);
		model.addAttribute("probList", probList);
		
		List<SuimRptProblemVO> planList = sqlSession.selectList("SuimBookDtlMapper.getPlan",suimRptNo);
		model.addAttribute("planList", planList);
		
		/*첨부 이미지 추출 시작*/
		List<SuimRptSiteImgVO> suimRptSiteImgList = sqlSession.selectList("SuimRptSiteMapper.getSiteInterimImgList",rptSiteNo);
		
		/*word 문서에서 이미지 첨부는 src 속성에 주소값을 넣어줘야함*/
		if(!type.equals("word")){
			for (int i = 0; i < suimRptSiteImgList.size(); i++) {
				
				String filepath = suimRptSiteImgList.get(i).getImgPath();
				GetImageBase64 imageBaseUtil = new  GetImageBase64();
				
				suimRptSiteImgList.get(i).setImgStream(
					imageBaseUtil.getOneImgeBase64("/home/hosting_users/toplac/www"+filepath, 
						suimRptSiteImgList.get(i).getImgName().substring(suimRptSiteImgList.get(i).getImgName().indexOf(".")+1, 
						suimRptSiteImgList.get(i).getImgName().length()
						) // substring
					)//getOneImgeBase64
				); //setImgStream
			}
		}
		
		model.addAttribute("suimRptSiteImgList", suimRptSiteImgList);
		model.addAttribute("suimRptSiteImgListLength", suimRptSiteImgList.size());
		/*첨부 이미지 추출 끝*/
		
		
		if(interimFlag.equals("site")){
			if(type.equals("word")){
				
				String filename = suimListDtl.getSuimAcceptNo()+"_현장조사보고서_"+orderNo+"차";
				try {
					filename = java.net.URLEncoder.encode(filename,"UTF-8");
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
				response.setHeader("Content-Disposition", "attachment;filename="+filename+".doc");
				response.setHeader("Content-Description", "JSP Generated Data");
			    //response.setContentType("application/vnd.ms-word");
				
				return "top_suim/suim_rpt_bsc_site_word";				
			}else if(type.equals("print")){
				return "top_suim/suim_rpt_bsc_site_print";
			}			
			
		}else{
			if(type.equals("word")){
				
				String filename = "";
                if (interimFlag.equals("interim")){
                    filename = suimListDtl.getSuimAcceptNo()+"_중간손해사정서_"+ orderNo +"차";
                }else{
                    filename = suimListDtl.getSuimAcceptNo()+"_진행경과보고서_"+ orderNo +"차";
                }




				try {
					filename = java.net.URLEncoder.encode(filename,"UTF-8");
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
				response.setHeader("Content-Disposition", "attachment;filename="+filename+".doc");
				response.setHeader("Content-Description", "JSP Generated Data");
			    //response.setContentType("application/vnd.ms-word");
				
				return "top_suim/suim_rpt_bsc_interim_word";				
			}else if(type.equals("print")){
				return "top_suim/suim_rpt_bsc_interim_print";
			}
		}
		
		return "";
		
	}
	
	
	/*
	 * ***************************************
	 * Method ID : siteImgEditOk
	 * Method Name :  siteImgEditOk
	 * Description : 현장 보고서 이미지 설명 수정
	 * 번호 1 : 설명 업뎃
	 * Author : 이선형
	 * Date : 20160609
	 * ***************************************
	 * */
	@RequestMapping(value = "siteImgEditOk", method = RequestMethod.POST)
	public void siteImgEditOk(PrintWriter out, String imgSerial, String subject) {
		
		logger.info("siteImgEditOk");
		
		HashMap<String,String> map = new HashMap<String, String>();	
		map.put("imgSerial", imgSerial);
		map.put("subject", subject);
	
		/*번호 1*/
		int result = sqlSession.update("SuimRptSiteMapper.siteImgSubjectEdit", map );

		out.print(result);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : siteImgDelOk
	 * Method Name :  siteImgDelOk
	 * Description : 현장 보고서 이미지 삭제
	 * 번호 1 : 이미지 삭제
	 * Author : 이선형
	 * Date : 20160609
	 * ***************************************
	 * */
	@RequestMapping(value = "siteImgDelOk", method = RequestMethod.POST)
	public void siteImgDelOk(PrintWriter out, String imgSerial) {
		
		logger.info("siteImgDelOk");
		
		String thisfile = "/home/hosting_users/toplac/www"+sqlSession.selectOne("SuimRptSiteMapper.getSiteImgPathForDel", imgSerial);
		String fileforder = thisfile.substring(0, thisfile.lastIndexOf("/"));
		
		//파일 삭제 시작
		if(fileforder != ""){
			
			File file = new File(thisfile);
			File dir = new File(fileforder);
			file.delete();
			dir.delete();
			
		}
		//파일 삭제 종료
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptSiteMapper.siteImgDel", imgSerial );

		out.print(result);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : siteImgDelOk
	 * Method Name :  siteImgDelOk
	 * Description : 현장 보고서 삭제  > 현장 보고서 이미지 삭제
	 * 번호 1 : 이미지 삭제
	 * Author : 이선형
	 * Date : 20160613
	 * ***************************************
	 * */
	public int siteImgDelOk(String imgSerial, String path) {
		
		logger.info("siteImgDelOk");


		path = "/home/hosting_users/toplac/www" + path ;
		String fileforder = path.substring(0, path.lastIndexOf("/"));
		
		
		//파일 삭제 시작
		if(fileforder != ""){
			
			File file = new File(path);
			File dir = new File(fileforder);
			file.delete();
			dir.delete();
			
		}
		//파일 삭제 종료
		
		/*번호 1*/
		int result = sqlSession.delete("SuimRptSiteMapper.siteImgDel", imgSerial );

		return result;
	}
	
	
	
	/*
	 * ***************************************
	 * Method ID : getsiteInterimFileModule
	 * Method Name :  getsiteInterimFileModule
	 * Description : 
	 * 
	 * Author : 이선형
	 * Date : 20160610
	 * ***************************************
	 * */
	@RequestMapping(value = "getsiteInterimFileModule", method = RequestMethod.GET)
	public void getsiteInterimFileModule(PrintWriter out){
		out.println("include/uploadform_siteInterimFile.jsp"); ;
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : siteFileDelOk
	 * Method Name :  siteFileDelOk
	 * Description : 현장 보고서 파일 삭제
	 * 번호 1 : 
	 * Author : 이선형
	 * Date : 20160610
	 * ***************************************
	 * */
	@RequestMapping(value = "siteFileDelOk", method = RequestMethod.POST)
	public void siteFileDelOk(PrintWriter out, String siteRptNo) {
		
		logger.info("siteFileDelOk");
		
		String thisfile = "/home/hosting_users/toplac/www"+sqlSession.selectOne("SuimRptSiteMapper.getSiteFilePathForDel", siteRptNo);
		String fileforder = thisfile.substring(0, thisfile.lastIndexOf("/"));
		
		//파일 삭제 시작
		if(fileforder != ""){
			
			File file = new File(thisfile);
			File dir = new File(fileforder);
			file.delete();
			dir.delete();
			
		}
		//파일 삭제 종료
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptSiteMapper.delSiteInterimFile", siteRptNo );

		out.print(result);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : siteFileDelOk
	 * Method Name :  siteFileDelOk
	 * Description : 현장 보고서 파일 원본 삭제
	 * 번호 1 : 
	 * Author : 이선형
	 * Date : 20160610
	 * ***************************************
	 * */
	public int siteFileDelOk(String path, String siteRptNo) {
		
		logger.info("siteFileDelOkForRptDel");
		
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

		return result;
	}
	
}
