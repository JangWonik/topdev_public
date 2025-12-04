package kr.co.toplac.topsuim;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.toplac.rptin.SuimPrint1001VO;
import kr.co.toplac.toprptinv.TopRptInvDtlViewVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopMbrSgnVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.etc.Damo;

@Controller
public class SuimRptBodyController {
	
private static final Logger logger = LoggerFactory.getLogger(SuimRptBodyController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	/*
	 * ***************************************
	 * Method ID : suimRptBody6EditeOk
	 * Method Name :  suimRptBody6EditeOk
	 * Description : 농협 인보험 건 Body 정보 업데이트
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160628
	 * ***************************************
	 * */
	@RequestMapping(value = "suimRptBody6EditeOk", method = RequestMethod.POST)
	public void suimRptBody6EditeOk(Model model, SuimRptBody6VO suimRptBody6Vo, HttpServletResponse response,PrintWriter out) {
		
		logger.info("suimRptBody6EditeOk");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody6",suimRptBody6Vo);
		out.print(result);
		out.close();
	}
	

	/*
	 * ***************************************
	 * Method ID : suimRptBody6PrintOut
	 * Method Name :  suimRptBody6PrintOut
	 * Description : 보고서 Body 6 : 농협 Word 다운, 인쇄
	 * 
	 * Author : 이선형
	 * Date : 20160628
	 * ***************************************
	 * */
	@RequestMapping(value = "suimRptBody6PrintOut", method = RequestMethod.GET)
	public String suimRptBody6PrintOut(Model model, HttpServletResponse response, HttpSession session, String suimRptNo, String serialNo, String type) {
		
		if(type.equals("word")){
			logger.info("suimRptBody6PrintOut - word");			
		}else{
			logger.info("suimRptBody6PrintOut - page");
		}
		
		SuimRptCompositeVO suimListDtl = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", suimRptNo);
		
		TopTmBscVO topTmBscVo = sqlSession.selectOne("SuimRptBodyMapper.topTmInfoForBody", suimListDtl.getTeam_id());
		TopMbrBscVO mbrVoForBody = sqlSession.selectOne("SuimRptBodyMapper.mbrinfo", suimListDtl.getUser_no());
		
		/*** 암호화 ***/
		Damo damo = new Damo();
		if ( suimListDtl.getPolicyholder_ssn() != null && !suimListDtl.getPolicyholder_ssn().equals("") ){
			suimListDtl.setPolicyholder_ssn( damo.decodeDamo(suimListDtl.getPolicyholder_ssn()) );
		}
		
		
		/*결재자의 사인 정보 추출*/
		TopMbrSgnVO signVo = new TopMbrSgnVO();
		
		if(suimListDtl.getSuimRptAprvUserNo() != null){
			if(!suimListDtl.getSuimRptAprvUserNo().equals("")){
				signVo = sqlSession.selectOne("MyInfoUdtMapper.membersign",suimListDtl.getSuimRptAprvUserNo());
				model.addAttribute("signVoSantion", signVo);
			}else{
				model.addAttribute("signVoSantion", "");
			}
		}else{
			model.addAttribute("signVoSantion", "");
		}
		
		/*조사자의 사인 정보 추출*/
		TopMbrSgnVO signVoForRptUser = new TopMbrSgnVO();
		if(suimListDtl.getUser_no() != null){
			if(!suimListDtl.getUser_no().equals("")){
				signVoForRptUser = sqlSession.selectOne("MyInfoUdtMapper.membersign",suimListDtl.getUser_no());
				model.addAttribute("signVoForRptUser", signVoForRptUser);
			}else{
				model.addAttribute("signVoForRptUser", "");
			}
		}else{
			model.addAttribute("signVoForRptUser", "");
		}
		
		SuimRptBody6VO suimRptBody6Vo = sqlSession.selectOne("SuimRptBodyMapper.getBody6", suimRptNo);
		
		TopMbrBscVO mbrVoForBodySantion = sqlSession.selectOne("SuimRptBodyMapper.mbrinfo", suimListDtl.getSuimRptAprvUserNo());
		
		if(suimRptBody6Vo == null){
			int nextBody6Serial = sqlSession.selectOne("SuimRptBodyMapper.nextBody6Serial");
			sqlSession.insert("SuimRptBodyMapper.insNewBody6", suimRptNo);
			
			suimRptBody6Vo = sqlSession.selectOne("SuimRptBodyMapper.getBody6AfterIns", nextBody6Serial);
		}
		
		model.addAttribute("suimRptBodyVo",suimRptBody6Vo);
		model.addAttribute("tmInforForBody",topTmBscVo);
		model.addAttribute("mbrVoForBody",mbrVoForBody);
		model.addAttribute("mbrVoForBodySantion",mbrVoForBodySantion);
		model.addAttribute("suimVO", suimListDtl);
		
		//인보험 손해사정사 정보 추가 시작		
		List<Map<String, Object>> certiManager4ReportUser = new ArrayList<Map<String, Object>>();
		
		Map<String, Object> paramMap = new HashMap<String, Object>(); 

		//조사 담당자
		String sUserNo = String.valueOf(suimListDtl.getUser_no());
		
		paramMap.put("user_no", sUserNo);

		//종결건은 담당손해사정사가 별도 저장되어있음 (top_rpt_certi_end) 저장된 손해사정사 정보가 별도로 있는지 체크(인보험용)
		int nEndCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiEndCntBy4",paramMap);        

		if( nEndCnt == 0 ) {			//정보가 없는 경우 실시간으로 가져온다.
			
			if( !"0".equals(sUserNo) ) {		//0은 미배당건
			
			int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
			
			//보고서 작성자를 paramMap 에 추가한다.
			paramMap.put("user_no", suimListDtl.getUser_no());
			
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
		
		if(type.equals("word")){
			
			String filename = suimListDtl.getSuim_accept_no();
			try {
				filename = java.net.URLEncoder.encode(filename,"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			response.setHeader("Content-Disposition", "attachment;filename="+filename+".doc");
			response.setHeader("Content-Description", "JSP Generated Data");
		    //response.setContentType("application/vnd.ms-word");
			
			return "top_suim_print/suim_rpt_bsc_print_6_word";				
		}else if(type.equals("page")){
			return "top_suim_print/suim_rpt_bsc_print_6_page";
		}			
		
		
		return "";
		
	}
	
	/*
	 * ***************************************
	 * Method ID : suimRptBody1PrintOut
	 * Method Name :  suimRptBody1PrintOut
	 * Description : 보고서 Body 1 : 일반 word, page 인쇄
	 * 
	 * Author : 이선형
	 * Date : 20160706
	 * ***************************************
	 * */
	@RequestMapping(value = "suimRptBody1PrintOut", method = RequestMethod.GET)
	public String suimRptBody1PrintOut(Model model, HttpServletResponse response, HttpSession session, String suimRptNo, String type) {
		
		if(type.equals("word")){
			logger.info("suimRptBody1PrintOut - word");			
		}else{
			logger.info("suimRptBody1PrintOut - page");
		}
		
		String suim_rpt_no= suimRptNo;
		
		List<SuimRptCompositeVO> suimListDtl = sqlSession.selectList("SuimBookDtlMapper.getSuimBookDtl", suim_rpt_no);
		
		/*** 암호화 ***/
		Damo damo = new Damo();
		if ( suimListDtl.get(0).getPolicyholder_ssn() != null && !suimListDtl.get(0).getPolicyholder_ssn().equals("") ){
			suimListDtl.get(0).setPolicyholder_ssn( damo.decodeDamo(suimListDtl.get(0).getPolicyholder_ssn()) );
		}
		
		if ( suimListDtl.get(0).getPolicyholder_tel() != null && !suimListDtl.get(0).getPolicyholder_tel().equals("") ){
			suimListDtl.get(0).setPolicyholder_tel( damo.decodeDamo(suimListDtl.get(0).getPolicyholder_tel()) );
		}
		
		if ( suimListDtl.get(0).getBeneficiary_ssn() != null && !suimListDtl.get(0).getBeneficiary_ssn().equals("") ){
			suimListDtl.get(0).setBeneficiary_ssn( damo.decodeDamo(suimListDtl.get(0).getBeneficiary_ssn()) );
		}
		
		
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
		
		/*Print1_6_1 정보 추출*/
		List<SuimRptBody1_6_1VO> suimRptBody1_6_1List = sqlSession.selectList("SuimRptBodyMapper.getPrint1_6_1List", suimRptBody1_13467Vo.getRptPrintNo());
		
		/*Print1_6_1 정보 추출*/
		List<SuimRptBody1_8VO> suimRptBody1_8List = sqlSession.selectList("SuimRptBodyMapper.getPrint1_8List", suimRptBody1_13467Vo.getRptPrintNo());
		
		/*Print1_6_1 개행 처리 */
		for (int i = 0; i < suimRptBody1_6_1List.size(); i++) {
			suimRptBody1_6_1List.get(i).setInvestigateDtl(suimRptBody1_6_1List.get(i).getInvestigateDtl().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
		}
		
		/*Print1_6_2 정보 추출*/
		List<SuimRptBody1_6_2VO> suimRptBody1_6_2List = sqlSession.selectList("SuimRptBodyMapper.getPrint1_6_2List", suimRptBody1_13467Vo.getRptPrintNo());
		
		/*Print1_2 개행 처리 */
		for (int i = 0; i < suimRptBody1_2List.size(); i++) {
			suimRptBody1_2List.get(i).setOtherInsuDtl(suimRptBody1_2List.get(i).getOtherInsuDtl().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
		}
		
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
		
		/*6.다-1 조사내용 개행처리*/
		suimRptBody1_13467Vo.setPastRespect6(suimRptBody1_13467Vo.getPastRespect6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
		suimRptBody1_13467Vo.setPastHospital6(suimRptBody1_13467Vo.getPastHospital6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
		suimRptBody1_13467Vo.setPastResult6(suimRptBody1_13467Vo.getPastResult6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
		
		/*조사사항 개행처리*/
		suimRptBody1_13467Vo.setInspectPoint4(suimRptBody1_13467Vo.getInspectPoint4().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
		suimRptBody1_13467Vo.setInspectResult4(suimRptBody1_13467Vo.getInspectResult4().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
		
		/*조사내용 개행처리*/
		suimRptBody1_13467Vo.setFaceInsuredJob6(suimRptBody1_13467Vo.getFaceInsuredJob6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
		suimRptBody1_13467Vo.setFaceContractSituation6(suimRptBody1_13467Vo.getFaceContractSituation6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
		suimRptBody1_13467Vo.setFaceEtcMemo6(suimRptBody1_13467Vo.getFaceEtcMemo6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
		suimRptBody1_13467Vo.setFaceInformSignYn6(suimRptBody1_13467Vo.getFaceInformSignYn6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
		suimRptBody1_13467Vo.setFaceOccurSituation6(suimRptBody1_13467Vo.getFaceOccurSituation6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
		
		/*손해사정 결과 개행처리*/
		suimRptBody1_13467Vo.setAdjustResult7(suimRptBody1_13467Vo.getAdjustResult7().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
		
		/*보고서 이미지 추출*/
		List<SuimRptImgPrint_1VO> suimRptImgPrint_1List = sqlSession.selectList("SuimRptBodyMapper.getRptPrint1ImgList", suim_rpt_no);
		
		/*사고처리 과정표 정보 추출 시작*/
		List<SuimRptSagoBscVO> sagoList  = sqlSession.selectList("SagoBscMapper.getSagoList", suim_rpt_no);
		model.addAttribute("sagoList", sagoList);
		/*사고처리 과정표 정보 추출 끝*/
		
		/*인보이스 정보 추출 시작*/
		TopRptInvDtlViewVO suimInvVO = sqlSession.selectOne("InvoiceDtlMapper.getInvoiceDtlForRptDtl", suim_rpt_no);
		model.addAttribute("suimInvVO", suimInvVO);
		/*인보이스 정보 추출 끝*/
		
		/*GetImageBase64 imgUtil = new GetImageBase64();
		for (int i = 0; i < suimRptImgPrint_1List.size(); i++) {
			
			suimRptImgPrint_1List.get(i).setImgStream(
				imgUtil.getOneImgeBase64("/upload/rptImgPrint1/"+suim_rpt_no+"/"+suimRptImgPrint_1List.get(i).getSerialNo()+"/"+suimRptImgPrint_1List.get(i).getImgName(),
						suimRptImgPrint_1List.get(i).getImgName().substring(suimRptImgPrint_1List.get(i).getImgName().lastIndexOf(".")+1, suimRptImgPrint_1List.get(i).getImgName().length())
				)
			);
		}*/
		
		/*Print 공통 정보 추출 시작*/
		TopTmBscVO topTmBscVo = sqlSession.selectOne("SuimRptBodyMapper.topTmInfoForBody", suimListDtl.get(0).getTeam_id());
		TopMbrBscVO mbrVoForBody = sqlSession.selectOne("SuimRptBodyMapper.mbrinfo", suimListDtl.get(0).getUser_no());
		
		/*부모 건의 결재자 정보를 추출 */
		TopMbrBscVO mbrVoForBodySantion = sqlSession.selectOne("SuimRptBodyMapper.mbrinfo", suimListDtl.get(0).getSuimRptAprvUserNo());
		
		/*결재자의 사인 정보 추출*/
		TopMbrSgnVO signVo = new TopMbrSgnVO();
		if(suimListDtl.get(0).getSuimRptAprvUserNo() != null){
			if(!suimListDtl.get(0).getSuimRptAprvUserNo().equals("")){
				signVo = sqlSession.selectOne("MyInfoUdtMapper.membersign",suimListDtl.get(0).getSuimRptAprvUserNo());
				model.addAttribute("signVoSantion", signVo);
			}else{
				model.addAttribute("signVoSantion", "");
			}
		}else{
			model.addAttribute("signVoSantion", "");
		}
		
		/*조사자의 사인 정보 추출*/
		TopMbrSgnVO signVoForRptUser = new TopMbrSgnVO();
		if(suimListDtl.get(0).getUser_no() != null){
			if(!suimListDtl.get(0).getUser_no().equals("")){
				signVoForRptUser = sqlSession.selectOne("MyInfoUdtMapper.membersign",suimListDtl.get(0).getUser_no());
				model.addAttribute("signVoForRptUser", signVoForRptUser);
			}else{
				model.addAttribute("signVoForRptUser", "");
			}
		}else{
			model.addAttribute("signVoForRptUser", "");
		}
		/*Print 공통 정보 추출 끝*/
		
		model.addAttribute("suimVO", suimListDtl.get(0));
		model.addAttribute("mbrVoForBody",mbrVoForBody);
		model.addAttribute("mbrVoForBodySantion",mbrVoForBodySantion);
		model.addAttribute("tmInforForBody",topTmBscVo);
		
		model.addAttribute("suimRptImgPrint_1List",suimRptImgPrint_1List);
		model.addAttribute("suimRptBody1_8List",suimRptBody1_8List);
		model.addAttribute("suimRptBody1_6_2List",suimRptBody1_6_2List);
		model.addAttribute("suimRptBody1_6_1List",suimRptBody1_6_1List);
		model.addAttribute("suimRptBody1_5List",suimRptBody1_5List);
		model.addAttribute("suimRptBody1_2List",suimRptBody1_2List);
		model.addAttribute("suimRptBody1_13467Vo",suimRptBody1_13467Vo);
		
		if(type.equals("word")){
			
			String filename = suimListDtl.get(0).getSuim_accept_no();
			try {
				filename = java.net.URLEncoder.encode(filename,"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			response.setHeader("Content-Disposition", "attachment;filename="+filename+".doc");
			response.setHeader("Content-Description", "JSP Generated Data");
		    //response.setContentType("application/vnd.ms-word");
			
			return "top_suim_print/suim_rpt_bsc_print_1_word";				
		}else if(type.equals("page")){
			return "top_suim_print/suim_rpt_bsc_print_1_page";
		}			
		return "";
		
	}
	
	
	
	/*
	 * ***************************************
	 * Method ID : suimRptBody17PrintOut
	 * Method Name :  suimRptBody17PrintOut
	 * Description : 보고서 Body 17 : 일반 word, page 인쇄
	 * 
	 * Author : 이선형
	 * Date : 20160803
	 * ***************************************
	 * */
	@RequestMapping(value = "suimRptBody17PrintOut", method = RequestMethod.GET)
	public String suimRptBody17PrintOut(Model model, HttpServletResponse response, HttpSession session, String suimRptNo, String type) {
		
		if(type.equals("word")){
			logger.info("suimRptBody17PrintOut - word");			
		}else{
			logger.info("suimRptBody17PrintOut - page");
		}
		
		String suim_rpt_no= suimRptNo;
		
		List<SuimRptCompositeVO> suimListDtl = sqlSession.selectList("SuimBookDtlMapper.getSuimBookDtl", suim_rpt_no);
		
		/*print1_13467 1단계 : 부모 건의 수임No로 입력되어있는 Body 정보(Tobe에서는 Print 정보) 를 추출 */
		SuimRptBody17_1356891112VO suimRptBody17_1356891112Vo = sqlSession.selectOne("SuimRptBodyMapper.getPrint17ForDtl", suim_rpt_no);
		
		/*Print17_2 정보 추출*/
		SuimRptBody17_2VO suimRptBody17_2Vo = sqlSession.selectOne("SuimRptBodyMapper.getPrint17_2", suim_rpt_no);
		
		/*Print17_4 정보 추출*/
		List<SuimRptBody17_4VO> suimRptBody17_4List = sqlSession.selectList("SuimRptBodyMapper.getPrint17_4List", suim_rpt_no);
		
		/*Print17_7 정보 추출*/
		List<SuimRptBody17_7VO> suimRptBody17_7List = sqlSession.selectList("SuimRptBodyMapper.getPrint17_7List", suim_rpt_no);

		/*Print17_13 정보 추출*/
		List<SuimRptBody17_13VO> suimRptBody17_13List = sqlSession.selectList("SuimRptBodyMapper.getPrint17_13List", suim_rpt_no);
		
		for (int i = 0; i < suimRptBody17_7List.size(); i++) {
			
			suimRptBody17_7List.get(i).setMedicalHistoryDiagnosis(suimRptBody17_7List.get(i).getMedicalHistoryDiagnosis().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
			suimRptBody17_7List.get(i).setMedicalHistoryHospital(suimRptBody17_7List.get(i).getMedicalHistoryHospital().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
			suimRptBody17_7List.get(i).setMedicalHistoryMedicine(suimRptBody17_7List.get(i).getMedicalHistoryMedicine().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
			suimRptBody17_7List.get(i).setMedicalHistoryPeriod(suimRptBody17_7List.get(i).getMedicalHistoryPeriod().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
			suimRptBody17_7List.get(i).setMedicalHistoryTest(suimRptBody17_7List.get(i).getMedicalHistoryTest().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
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
		
		/*사고처리 과정표 정보 추출 시작*/
		List<SuimRptSagoBscVO> sagoList  = sqlSession.selectList("SagoBscMapper.getSagoList", suim_rpt_no);
		model.addAttribute("sagoList", sagoList);
		/*사고처리 과정표 정보 추출 끝*/
		
		/*인보이스 정보 추출 시작*/
		TopRptInvDtlViewVO suimInvVO = sqlSession.selectOne("InvoiceDtlMapper.getInvoiceDtlForRptDtl", suim_rpt_no);
		model.addAttribute("suimInvVO", suimInvVO);
		/*인보이스 정보 추출 끝*/

		/*Print 공통 정보 추출 시작*/
		TopTmBscVO topTmBscVo = sqlSession.selectOne("SuimRptBodyMapper.topTmInfoForBody", suimListDtl.get(0).getTeam_id());
		TopMbrBscVO mbrVoForBody = sqlSession.selectOne("SuimRptBodyMapper.mbrinfo", suimListDtl.get(0).getUser_no());
		
		/*부모 건의 결재자 정보를 추출 */
		TopMbrBscVO mbrVoForBodySantion = sqlSession.selectOne("SuimRptBodyMapper.mbrinfo", suimListDtl.get(0).getSuimRptAprvUserNo());
		
		/*결재자의 사인 정보 추출*/
		TopMbrSgnVO signVo = new TopMbrSgnVO();
		if(suimListDtl.get(0).getSuimRptAprvUserNo() != null){
			if(!suimListDtl.get(0).getSuimRptAprvUserNo().equals("")){
				signVo = sqlSession.selectOne("MyInfoUdtMapper.membersign",suimListDtl.get(0).getSuimRptAprvUserNo());
				model.addAttribute("signVoSantion", signVo);
			}else{
				model.addAttribute("signVoSantion", "");
			}
		}else{
			model.addAttribute("signVoSantion", "");
		}
		
		/*조사자의 사인 정보 추출*/
		TopMbrSgnVO signVoForRptUser = new TopMbrSgnVO();
		if(suimListDtl.get(0).getUser_no() != null){
			if(!suimListDtl.get(0).getUser_no().equals("")){
				signVoForRptUser = sqlSession.selectOne("MyInfoUdtMapper.membersign",suimListDtl.get(0).getUser_no());
				model.addAttribute("signVoForRptUser", signVoForRptUser);
			}else{
				model.addAttribute("signVoForRptUser", "");
			}
		}else{
			model.addAttribute("signVoForRptUser", "");
		}
		/*Print 공통 정보 추출 끝*/
		
		//인보험 손해사정사 정보 추가 시작		
		List<Map<String, Object>> certiManager4ReportUser = new ArrayList<Map<String, Object>>();
		
		Map<String, Object> paramMap = new HashMap<String, Object>(); 

		//조사 담당자
		String sUserNo = String.valueOf(suimListDtl.get(0).getUser_no());
		
		paramMap.put("user_no", sUserNo);

		//종결건은 담당손해사정사가 별도 저장되어있음 (top_rpt_certi_end) 저장된 손해사정사 정보가 별도로 있는지 체크(인보험용)
		int nEndCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiEndCntBy4",paramMap);        

		if( nEndCnt == 0 ) {			//정보가 없는 경우 실시간으로 가져온다.
			
			if( !"0".equals(sUserNo) ) {		//0은 미배당건
			
			int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
			
			//보고서 작성자를 paramMap 에 추가한다.
			paramMap.put("user_no", suimListDtl.get(0).getUser_no());
			
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
		
		model.addAttribute("suimVO", suimListDtl.get(0));
		model.addAttribute("mbrVoForBody",mbrVoForBody);
		model.addAttribute("mbrVoForBodySantion",mbrVoForBodySantion);
		model.addAttribute("tmInforForBody",topTmBscVo);
		
		model.addAttribute("suimRptBody17_2Vo",suimRptBody17_2Vo);
		model.addAttribute("suimRptBody17_4List",suimRptBody17_4List);
		model.addAttribute("suimRptBody17_7List",suimRptBody17_7List);
		model.addAttribute("suimRptBody17_13List",suimRptBody17_13List);
		model.addAttribute("suimRptBody17_1356891112Vo",suimRptBody17_1356891112Vo);
		
		if(type.equals("word")){
			
			String filename = suimListDtl.get(0).getSuim_accept_no();
			try {
				filename = java.net.URLEncoder.encode(filename,"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			response.setHeader("Content-Disposition", "attachment;filename="+filename+".doc");
			response.setHeader("Content-Description", "JSP Generated Data");
		    //response.setContentType("application/vnd.ms-word");
			
			return "top_suim_print/suim_rpt_bsc_print_17_word";				
		}else if(type.equals("page")){
			return "top_suim_print/suim_rpt_bsc_print_17_page";
		}			
		
		
		return "";
		
	}
	
	/*
	 * ***************************************
	 * Method ID : suimRptBody1700PrintOut
	 * Method Name :  suimRptBody1700PrintOut
	 * Description : 보고서 Body 1700 : 일반 word, page 인쇄
	 * 
	 * Author : 이선형
	 * Date : 20160810
	 * ***************************************
	 * */
	@RequestMapping(value = "suimRptBody1700PrintOut", method = RequestMethod.GET)
	public String suimRptBody1700PrintOut(Model model, HttpServletResponse response, HttpSession session, String suimRptNo, String type) {
		
		if(type.equals("word")){
			logger.info("suimRptBody1700PrintOut - word");			
		}else{
			logger.info("suimRptBody1700PrintOut - page");
		}
		
		String suim_rpt_no= suimRptNo;
		
		List<SuimRptCompositeVO> suimListDtl = sqlSession.selectList("SuimBookDtlMapper.getSuimBookDtl", suim_rpt_no);
		
		/*print1700 1단계 : 부모 건의 수임No로 입력되어있는 Body 정보(Tobe에서는 Print 정보) 를 추출 */
		SuimRptBody1700VO suimRptBody1700Vo = sqlSession.selectOne("SuimRptBodyMapper.getPrint1700ForDtl", suim_rpt_no);
		
		/*Print1700_7 정보 추출*/
		List<SuimRptBody1_8VO> suimRptBody1700_7List = sqlSession.selectList("SuimRptBodyMapper.getPrint1700_7List",suim_rpt_no);
		
		/*컴마처리 */
		suimRptBody1700Vo.setAmtReq1(Comma_won(suimRptBody1700Vo.getAmtReq1())); 
		suimRptBody1700Vo.setAmtReduce1(Comma_won(suimRptBody1700Vo.getAmtReduce1()));
		suimRptBody1700Vo.setTotSal3(Comma_won(suimRptBody1700Vo.getTotSal3()));
		suimRptBody1700Vo.setAmtHomeSum4(Comma_won(suimRptBody1700Vo.getAmtHomeSum4()));
		suimRptBody1700Vo.setAmtSettleSum4(Comma_won(suimRptBody1700Vo.getAmtSettleSum4()));
		suimRptBody1700Vo.setAmtNhis3(Comma_won(suimRptBody1700Vo.getAmtNhis3()));
		
		/*사고처리 과정표 정보 추출 시작*/
		List<SuimRptSagoBscVO> sagoList  = sqlSession.selectList("SagoBscMapper.getSagoList", suim_rpt_no);
		model.addAttribute("sagoList", sagoList);
		/*사고처리 과정표 정보 추출 끝*/
		
		/*인보이스 정보 추출 시작*/
		TopRptInvDtlViewVO suimInvVO = sqlSession.selectOne("InvoiceDtlMapper.getInvoiceDtlForRptDtl", suim_rpt_no);
		model.addAttribute("suimInvVO", suimInvVO);
		/*인보이스 정보 추출 끝*/

		/*Print 공통 정보 추출 시작*/
		TopTmBscVO topTmBscVo = sqlSession.selectOne("SuimRptBodyMapper.topTmInfoForBody", suimListDtl.get(0).getTeam_id());
		TopMbrBscVO mbrVoForBody = sqlSession.selectOne("SuimRptBodyMapper.mbrinfo", suimListDtl.get(0).getUser_no());
		
		/*부모 건의 결재자 정보를 추출 */
		TopMbrBscVO mbrVoForBodySantion = sqlSession.selectOne("SuimRptBodyMapper.mbrinfo", suimListDtl.get(0).getSuimRptAprvUserNo());
		
		/*결재자의 사인 정보 추출*/
		TopMbrSgnVO signVo = new TopMbrSgnVO();
		if(suimListDtl.get(0).getSuimRptAprvUserNo() != null){
			if(!suimListDtl.get(0).getSuimRptAprvUserNo().equals("")){
				signVo = sqlSession.selectOne("MyInfoUdtMapper.membersign",suimListDtl.get(0).getSuimRptAprvUserNo());
				model.addAttribute("signVoSantion", signVo);
			}else{
				model.addAttribute("signVoSantion", "");
			}
		}else{
			model.addAttribute("signVoSantion", "");
		}
		
		/*조사자의 사인 정보 추출*/
		TopMbrSgnVO signVoForRptUser = new TopMbrSgnVO();
		if(suimListDtl.get(0).getUser_no() != null){
			if(!suimListDtl.get(0).getUser_no().equals("")){
				signVoForRptUser = sqlSession.selectOne("MyInfoUdtMapper.membersign",suimListDtl.get(0).getUser_no());
				model.addAttribute("signVoForRptUser", signVoForRptUser);
			}else{
				model.addAttribute("signVoForRptUser", "");
			}
		}else{
			model.addAttribute("signVoForRptUser", "");
		}
		/*Print 공통 정보 추출 끝*/
		
		model.addAttribute("suimVO", suimListDtl.get(0));
		model.addAttribute("mbrVoForBody",mbrVoForBody);
		model.addAttribute("mbrVoForBodySantion",mbrVoForBodySantion);
		model.addAttribute("tmInforForBody",topTmBscVo);
		
		model.addAttribute("suimRptBody1700Vo",suimRptBody1700Vo);
		model.addAttribute("suimRptBody1700_7List",suimRptBody1700_7List);
		
		if(type.equals("word")){
			
			String filename = suimListDtl.get(0).getSuim_accept_no();
			try {
				filename = java.net.URLEncoder.encode(filename,"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			response.setHeader("Content-Disposition", "attachment;filename="+filename+".doc");
			response.setHeader("Content-Description", "JSP Generated Data");
		    //response.setContentType("application/vnd.ms-word");
			
			return "top_suim_print/suim_rpt_bsc_print_1700_word";				
		}else if(type.equals("page")){
			return "top_suim_print/suim_rpt_bsc_print_1700_page";
		}			
		
		
		return "";
		
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
	 * Method ID : suimRptBody9PrintOut
	 * Method Name :  suimRptBody9PrintOut
	 * Description : 보고서 Body 9 : 일반 word, page 인쇄
	 * 
	 * Author : 이선형
	 * Date : 20160712
	 * ***************************************
	 * */
	@RequestMapping(value = "suimRptBody9PrintOut", method = RequestMethod.GET)
	public String suimRptBody9PrintOut(Model model, HttpServletResponse response, HttpSession session, String suimRptNo, String type) {
		
		if(type.equals("word")){
			logger.info("suimRptBody9PrintOut - word");			
		}else{
			logger.info("suimRptBody9PrintOut - page");
		}
		
		String suim_rpt_no= suimRptNo;
		
		List<SuimRptCompositeVO> suimListDtl = sqlSession.selectList("SuimBookDtlMapper.getSuimBookDtl", suim_rpt_no);
		
		Damo damo = new Damo();
		if ( suimListDtl.get(0).getPolicyholder_ssn() != null && !suimListDtl.get(0).getPolicyholder_ssn().equals("") ){
			suimListDtl.get(0).setPolicyholder_ssn( damo.decodeDamo(suimListDtl.get(0).getPolicyholder_ssn()) );
		}
		
		if ( suimListDtl.get(0).getBeneficiary_ssn() != null && !suimListDtl.get(0).getBeneficiary_ssn().equals("") ){
			suimListDtl.get(0).setBeneficiary_ssn( damo.decodeDamo(suimListDtl.get(0).getBeneficiary_ssn()) );
		}
		
		SuimRptBody9_13467VO suimRptBody9_13467Vo = sqlSession.selectOne("SuimRptBodyMapper.getPrint9ForDtl", suim_rpt_no);
		
		/*계약확인사항 개행처리*/
		suimRptBody9_13467Vo.setInsuMortgage1(suimRptBody9_13467Vo.getInsuMortgage1().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020").replaceAll("&nbsp;", "\u0020"));
		suimRptBody9_13467Vo.setInsuMortgageDtl1(suimRptBody9_13467Vo.getInsuMortgageDtl1().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020").replaceAll("&nbsp;", "\u0020"));
		suimRptBody9_13467Vo.setInsuredJob1(suimRptBody9_13467Vo.getInsuredJob1().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020").replaceAll("&nbsp;", "\u0020"));
		
		/*조사결과(요약) 개행처리*/
		suimRptBody9_13467Vo.setDiagnosisDisease3(suimRptBody9_13467Vo.getDiagnosisDisease3().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020").replaceAll("&nbsp;", "\u0020"));
		suimRptBody9_13467Vo.setAccidentDtl3(suimRptBody9_13467Vo.getAccidentDtl3().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020").replaceAll("&nbsp;", "\u0020"));
		suimRptBody9_13467Vo.setInspectPoint3(suimRptBody9_13467Vo.getInspectPoint3().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020").replaceAll("&nbsp;", "\u0020"));
		suimRptBody9_13467Vo.setInspectResult3(suimRptBody9_13467Vo.getInspectResult3().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020").replaceAll("&nbsp;", "\u0020"));
		
		/*조사내용(요약) : 가. 피보험자 면담사항 개행처리*/
		suimRptBody9_13467Vo.setFaceContractSituation4(suimRptBody9_13467Vo.getFaceContractSituation4().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020").replaceAll("&nbsp;", "\u0020"));
		suimRptBody9_13467Vo.setFaceInformSignYn4(suimRptBody9_13467Vo.getFaceInformSignYn4().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020").replaceAll("&nbsp;", "\u0020"));
		suimRptBody9_13467Vo.setFaceOtherInsuMemo4(suimRptBody9_13467Vo.getFaceOtherInsuMemo4().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020").replaceAll("&nbsp;", "\u0020"));
		suimRptBody9_13467Vo.setFaceInsuredDemand4(suimRptBody9_13467Vo.getFaceInsuredDemand4().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020").replaceAll("&nbsp;", "\u0020"));
		
		/*기타 병원 확인결과 개행처리*/
		suimRptBody9_13467Vo.setHospitalMemo6(suimRptBody9_13467Vo.getHospitalMemo6().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020").replaceAll("&nbsp;", "\u0020").replaceAll("&nbsp;", "\u0020"));
		
		/*조사결과 개행처리*/
		suimRptBody9_13467Vo.setDetailRecord7(suimRptBody9_13467Vo.getDetailRecord7().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020").replaceAll("&nbsp;", "\u0020").replaceAll("&nbsp;", "\u0020"));
		
		/*피보험자 병력사항 요약 경과표*/
		List<SuimRptBody9_3aVO> SuimRptBody9_3aList = sqlSession.selectList("SuimRptBodyMapper.getPrint9_3aList",suimRptBody9_13467Vo.getRptPrintNo());
		
		/*병력사항 요약 경과표 개행처리*/
		for (int i = 0; i < SuimRptBody9_3aList.size(); i++) {
			SuimRptBody9_3aList.get(i).setProcessDtl(SuimRptBody9_3aList.get(i).getProcessDtl().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020").replaceAll("&nbsp;", "\u0020"));
		}
		
		/*타 보험사 계약사항*/
		List<SuimRptBody9_3cVO> SuimRptBody9_3cList = sqlSession.selectList("SuimRptBodyMapper.getPrint9_3cList",suimRptBody9_13467Vo.getRptPrintNo());
		
		for (int i = 0; i < SuimRptBody9_3cList.size(); i++) {
			SuimRptBody9_3cList.get(i).setOtherInsuContract(SuimRptBody9_3cList.get(i).getOtherInsuContract().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020").replaceAll("&nbsp;", "\u0020"));
			SuimRptBody9_3cList.get(i).setOtherInsuProcess(SuimRptBody9_3cList.get(i).getOtherInsuProcess().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020").replaceAll("&nbsp;", "\u0020"));
			SuimRptBody9_3cList.get(i).setOtherInsuEtcMemo(SuimRptBody9_3cList.get(i).getOtherInsuEtcMemo().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020").replaceAll("&nbsp;", "\u0020"));
		}
		
		/*피보험자 조사내용*/
		List<SuimRptBody9_3dVO> SuimRptBody9_3dList = sqlSession.selectList("SuimRptBodyMapper.getPrint9_3dList",suimRptBody9_13467Vo.getRptPrintNo());
		
		for (int i = 0; i < SuimRptBody9_3dList.size(); i++) {
			SuimRptBody9_3dList.get(i).setInvestigateDtl(SuimRptBody9_3dList.get(i).getInvestigateDtl().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020").replaceAll("&nbsp;", "\u0020"));
		}
		
		/*Print1_6_8 정보 추출*/
		List<SuimRptBody1_8VO> suimRptBody9_fileList = sqlSession.selectList("SuimRptBodyMapper.getPrint9_fileList", suimRptBody9_13467Vo.getRptPrintNo());
		
		/*사고처리 과정표 정보 추출 시작*/
		List<SuimRptSagoBscVO> sagoList  = sqlSession.selectList("SagoBscMapper.getSagoList", suim_rpt_no);
		model.addAttribute("sagoList", sagoList);
		/*사고처리 과정표 정보 추출 끝*/
		
		/*인보이스 정보 추출 시작*/
		TopRptInvDtlViewVO suimInvVO = sqlSession.selectOne("InvoiceDtlMapper.getInvoiceDtlForRptDtl", suim_rpt_no);
		model.addAttribute("suimInvVO", suimInvVO);
		/*인보이스 정보 추출 끝*/
		
		/*Print 공통 정보 추출 시작*/
		TopTmBscVO topTmBscVo = sqlSession.selectOne("SuimRptBodyMapper.topTmInfoForBody", suimListDtl.get(0).getTeam_id());
		TopMbrBscVO mbrVoForBody = sqlSession.selectOne("SuimRptBodyMapper.mbrinfo", suimListDtl.get(0).getUser_no());
		
		/*부모 건의 결재자 정보를 추출 */
		TopMbrBscVO mbrVoForBodySantion = sqlSession.selectOne("SuimRptBodyMapper.mbrinfo", suimListDtl.get(0).getSuimRptAprvUserNo());
		
		/*결재자의 사인 정보 추출*/
		TopMbrSgnVO signVo = new TopMbrSgnVO();
		if(suimListDtl.get(0).getSuimRptAprvUserNo() != null){
			if(!suimListDtl.get(0).getSuimRptAprvUserNo().equals("")){
				signVo = sqlSession.selectOne("MyInfoUdtMapper.membersign",suimListDtl.get(0).getSuimRptAprvUserNo());
				model.addAttribute("signVoSantion", signVo);
			}else{
				model.addAttribute("signVoSantion", "");
			}
		}else{
			model.addAttribute("signVoSantion", "");
		}
		
		/*조사자의 사인 정보 추출*/
		TopMbrSgnVO signVoForRptUser = new TopMbrSgnVO();
		if(suimListDtl.get(0).getUser_no() != null){
			if(!suimListDtl.get(0).getUser_no().equals("")){
				signVoForRptUser = sqlSession.selectOne("MyInfoUdtMapper.membersign",suimListDtl.get(0).getUser_no());
				model.addAttribute("signVoForRptUser", signVoForRptUser);
			}else{
				model.addAttribute("signVoForRptUser", "");
			}
		}else{
			model.addAttribute("signVoForRptUser", "");
		}
		/*Print 공통 정보 추출 끝*/
		
		
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
		
		model.addAttribute("suimVO", suimListDtl.get(0));
		model.addAttribute("mbrVoForBody",mbrVoForBody);
		model.addAttribute("mbrVoForBodySantion",mbrVoForBodySantion);
		model.addAttribute("tmInforForBody",topTmBscVo);

		model.addAttribute("suimRptBody9_fileList",suimRptBody9_fileList);
		model.addAttribute("SuimRptBody9_3dList",SuimRptBody9_3dList);
		model.addAttribute("SuimRptBody9_3cList",SuimRptBody9_3cList);
		model.addAttribute("SuimRptBody9_3aList",SuimRptBody9_3aList);
		model.addAttribute("suimRptBody9_13467Vo",suimRptBody9_13467Vo);
		
		if(type.equals("word")){
			
			String filename = suimListDtl.get(0).getSuim_accept_no();
			try {
				filename = java.net.URLEncoder.encode(filename,"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			response.setHeader("Content-Disposition", "attachment;filename="+filename+".doc");
			response.setHeader("Content-Description", "JSP Generated Data");
		    //response.setContentType("application/vnd.ms-word");
			
			return "top_suim_print/suim_rpt_bsc_print_9_word";				
		}else if(type.equals("page")){
			return "top_suim_print/suim_rpt_bsc_print_9_page";
		}			
		
		
		return "";
		
	}
	
	/*
	 * ***************************************
	 * Method ID : suimRptBody16PrintOut
	 * Method Name :  suimRptBody16PrintOut
	 * Description : 보고서 Body 16 : 일반 word, page 인쇄
	 * 
	 * Author : 이선형
	 * Date : 20160725
	 * ***************************************
	 * */
	@RequestMapping(value = "suimRptBody16PrintOut", method = RequestMethod.GET)
	public String suimRptBody16PrintOut(Model model, HttpServletResponse response, HttpSession session, String suimRptNo, String type) {
		
		if(type.equals("word")){
			logger.info("suimRptBody16PrintOut - word");			
		}else{
			logger.info("suimRptBody16PrintOut - page");
		}
		
		String suim_rpt_no= suimRptNo;
		
		List<SuimRptCompositeVO> suimListDtl = sqlSession.selectList("SuimBookDtlMapper.getSuimBookDtl", suim_rpt_no);
		
		//주민등록번호 암호화 해제
		Damo damo = new Damo();
		if(suimListDtl.get(0).getBeneficiary_ssn() != null && !suimListDtl.get(0).getBeneficiary_ssn().equals("") ){
			String decSsn = damo.decodeDamo(suimListDtl.get(0).getBeneficiary_ssn());
			suimListDtl.get(0).setBeneficiary_ssn(decSsn);
		}
		
		/*16의 사고처리 과정표 추출 시작*/
		List<SuimRptSagoBsc16VO> sagoList  = sqlSession.selectList("SagoBscMapper.getSagoList16", suim_rpt_no);
		
		for (int i = 0; i < sagoList.size(); i++) {
			sagoList.get(i).setControlMemo(sagoList.get(i).getControlMemo().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
		}
		model.addAttribute("sagoList", sagoList);
		/*16의 사고처리 과정표 추출 끝*/
		
		/*인보이스 정보 추출 시작*/
		TopRptInvDtlViewVO suimInvVO = sqlSession.selectOne("InvoiceDtlMapper.getInvoiceDtlForRptDtl", suim_rpt_no);
		model.addAttribute("suimInvVO", suimInvVO);
		/*인보이스 정보 추출 끝*/
		
		/*Print 공통 정보 추출 시작*/
		TopTmBscVO topTmBscVo = sqlSession.selectOne("SuimRptBodyMapper.topTmInfoForBody", suimListDtl.get(0).getTeam_id());
		TopMbrBscVO mbrVoForBody = sqlSession.selectOne("SuimRptBodyMapper.mbrinfo", suimListDtl.get(0).getUser_no());

		SuimRptBody16_1267VO suimRptBody16_1267Vo = sqlSession.selectOne("SuimRptBodyMapper.getPrint16ForDtl", suim_rpt_no);
		
		/*print16_1267 : Print 정보 없을 경우, 신규 입력함 */
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
		
		model.addAttribute("suimVO", suimListDtl.get(0));
		model.addAttribute("mbrVoForBody",mbrVoForBody);
		model.addAttribute("tmInforForBody",topTmBscVo);
		
		if(type.equals("word")){
			
			String filename = suimListDtl.get(0).getSuim_accept_no();
			try {
				filename = java.net.URLEncoder.encode(filename,"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			response.setHeader("Content-Disposition", "attachment;filename="+filename+".doc");
			response.setHeader("Content-Description", "JSP Generated Data");
		    //response.setContentType("application/vnd.ms-word");
			
			return "top_suim_print/suim_rpt_bsc_print_16_word";				
		}else if(type.equals("page")){
			return "top_suim_print/suim_rpt_bsc_print_16_page";
		}			
		
		return "";
		
	}
	
	
	/*
	 * ***************************************
	 * Method ID : editeBody1_1Ok
	 * Method Name :  editeBody1_1Ok
	 * Description : Print_1 보험 계약사항 업데이트
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160630
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody1_1Ok", method = RequestMethod.POST)
	public void editeBody1_1Ok(Model model, SuimRptBody1_13467VO suimRptBody1_13467Vo, HttpServletResponse response,PrintWriter out) {
		
		logger.info("editeBody1_1Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody1_1",suimRptBody1_13467Vo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : editeBody1_6_cOk
	 * Method Name :  editeBody1_6_cOk
	 * Description : Print1 과거력 업데이트
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160705
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody1_6_cOk", method = RequestMethod.POST)
	public void editeBody1_6_cOk(SuimRptBody1_13467VO suimRptBody1_13467Vo, PrintWriter out) {
		
		logger.info("editeBody1_6_cOk");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody1_6_c",suimRptBody1_13467Vo);
		out.print(result);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : editeBody1_6_2Ok
	 * Method Name :  editeBody1_6_2Ok
	 * Description : Print1 기타사항
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160705
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody1_6_2Ok", method = RequestMethod.POST)
	public void editeBody1_6_2Ok(SuimRptBody1_6_2VO suimRptBody1_6_2Vo, PrintWriter out) {
		
		logger.info("editeBody1_6_2Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody1_6_2",suimRptBody1_6_2Vo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : editeBody9_1Ok
	 * Method Name :  editeBody9_1Ok
	 * Description : Print9 계약확인사항 업데이트
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160711
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody9_1Ok", method = RequestMethod.POST)
	public void editeBody9_1Ok(SuimRptBody9_13467VO suimRptBody9_13467Vo, PrintWriter out) {
		
		logger.info("editeBody9_1Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody9_1",suimRptBody9_13467Vo);
		out.print(result);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : editeBody9_2Ok
	 * Method Name :  editeBody9_2Ok
	 * Description : Print9 조사결과(요약) 업데이트
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160711
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody9_2Ok", method = RequestMethod.POST)
	public void editeBody9_2Ok(SuimRptBody9_13467VO suimRptBody9_13467Vo, PrintWriter out) {
		
		logger.info("editeBody9_2Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody9_2",suimRptBody9_13467Vo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : editeBody9_6Ok
	 * Method Name :  editeBody9_6Ok
	 * Description : Print9_6 기타병원 확인내용 업데이트
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160711
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody9_6Ok", method = RequestMethod.POST)
	public void editeBody9_6Ok(SuimRptBody9_13467VO suimRptBody9_13467Vo, PrintWriter out) {
		
		logger.info("editeBody9_6Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody9_6",suimRptBody9_13467Vo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : editeBody9_7Ok
	 * Method Name :  editeBody9_7Ok
	 * Description : Print9_7 조사결과 업데이트
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160712
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody9_7Ok", method = RequestMethod.POST)
	public void editeBody9_7Ok(SuimRptBody9_13467VO suimRptBody9_13467Vo, PrintWriter out) {
		
		logger.info("editeBody9_7Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody9_7",suimRptBody9_13467Vo);
		out.print(result);
		out.close();
	}
	
	
	
	/*
	 * ***************************************
	 * Method ID : editeBody16_1Ok
	 * Method Name :  editeBody16_1Ok
	 * Description : Print16_1 계약 사항 및 손해사항 업데이트
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160718
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody16_1Ok", method = RequestMethod.POST)
	public void editeBody16_1Ok(SuimRptBody16_1267VO suimRptBody16_1267Vo, PrintWriter out) {
		
		logger.info("editeBody16_1Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody16_1",suimRptBody16_1267Vo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : editeBody17_1Ok
	 * Method Name :  editeBody17_1Ok
	 * Description : Print17_1 계약사항 업데이트
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160726
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody17_1Ok", method = RequestMethod.POST)
	public void editeBody17_1Ok(SuimRptBody17_1356891112VO suimRptBody17_1356891112Vo, HttpServletResponse response) {
		
		logger.info("editeBody17_1Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		
		PrintWriter out = null;
		
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		String chungguVal = "";
		
		if(suimRptBody17_1356891112Vo.getChungguType().equals("0")){
			chungguVal = "없음";
		}else if(suimRptBody17_1356891112Vo.getChungguType().equals("1")){
			chungguVal = "과거력";
		}else if(suimRptBody17_1356891112Vo.getChungguType().equals("2")){
			chungguVal = "2대질병";
		}else if(suimRptBody17_1356891112Vo.getChungguType().equals("3")){
			chungguVal = "암";
		}else if(suimRptBody17_1356891112Vo.getChungguType().equals("4")){
			chungguVal = "상해사망";
		}else if(suimRptBody17_1356891112Vo.getChungguType().equals("5")){
			chungguVal = "일당,간병비";
		}else if(suimRptBody17_1356891112Vo.getChungguType().equals("6")){
			chungguVal = "후유장해";
		}
		
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody17_1",suimRptBody17_1356891112Vo);
		out.print(result+"+"+chungguVal);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : editeBody17_3Ok
	 * Method Name :  editeBody17_3Ok
	 * Description : Print17_3 면담내용 업데이트
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160728
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody17_3Ok", method = RequestMethod.POST)
	public void editeBody17_3Ok(SuimRptBody17_1356891112VO suimRptBody17_1356891112Vo, PrintWriter out) {
		
		logger.info("editeBody17_3Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody17_3",suimRptBody17_1356891112Vo);
		out.print(result);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : editeBody17_2Ok
	 * Method Name :  editeBody17_2Ok
	 * Description : Print17_2 청구내용 업데이트
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160726
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody17_2Ok", method = RequestMethod.POST)
	public void editeBody17_2Ok(String suimRptNo, @RequestParam(value="chungguDtl[]") List<String> chungguDtl , int chungguContentsCount, HttpServletResponse response) {
		
		logger.info("editeBody17_2Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		
		PrintWriter out = null;
		
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		SuimRptBody17_2VO suimRptBody17_2Vo = new SuimRptBody17_2VO();
		
		suimRptBody17_2Vo.setSuimRptNo(suimRptNo);
		
		if(chungguContentsCount == 7){
			suimRptBody17_2Vo.setChungguDtl1(chungguDtl.get(0));
			suimRptBody17_2Vo.setChungguDtl2(chungguDtl.get(1));
			suimRptBody17_2Vo.setChungguDtl3(chungguDtl.get(2));
			suimRptBody17_2Vo.setChungguDtl4(chungguDtl.get(3));
			suimRptBody17_2Vo.setChungguDtl5(chungguDtl.get(4));
			suimRptBody17_2Vo.setChungguDtl6(chungguDtl.get(5));
			suimRptBody17_2Vo.setChungguDtl7(chungguDtl.get(6));
		}else if(chungguContentsCount == 9){
			suimRptBody17_2Vo.setChungguDtl1(chungguDtl.get(0));
			suimRptBody17_2Vo.setChungguDtl2(chungguDtl.get(1));
			suimRptBody17_2Vo.setChungguDtl3(chungguDtl.get(2));
			suimRptBody17_2Vo.setChungguDtl4(chungguDtl.get(3));
			suimRptBody17_2Vo.setChungguDtl5(chungguDtl.get(4));
			suimRptBody17_2Vo.setChungguDtl6(chungguDtl.get(5));
			suimRptBody17_2Vo.setChungguDtl7(chungguDtl.get(6));
			suimRptBody17_2Vo.setChungguDtl8(chungguDtl.get(7));
			suimRptBody17_2Vo.setChungguDtl9(chungguDtl.get(8));
		}else if(chungguContentsCount == 10){
			suimRptBody17_2Vo.setChungguDtl1(chungguDtl.get(0));
			suimRptBody17_2Vo.setChungguDtl2(chungguDtl.get(1));
			suimRptBody17_2Vo.setChungguDtl3(chungguDtl.get(2));
			suimRptBody17_2Vo.setChungguDtl4(chungguDtl.get(3));
			suimRptBody17_2Vo.setChungguDtl5(chungguDtl.get(4));
			suimRptBody17_2Vo.setChungguDtl6(chungguDtl.get(5));
			suimRptBody17_2Vo.setChungguDtl7(chungguDtl.get(6));
			suimRptBody17_2Vo.setChungguDtl8(chungguDtl.get(7));
			suimRptBody17_2Vo.setChungguDtl9(chungguDtl.get(8));
			suimRptBody17_2Vo.setChungguDtl10(chungguDtl.get(9));
		} 		
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody17_2",suimRptBody17_2Vo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : editeBody1700_1Ok
	 * Method Name :  editeBody1700_1Ok
	 * Description : Print1700_1 민원관련 및 전달 사항
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160810
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody1700_1Ok", method = RequestMethod.POST)
	public void editeBody1700_1Ok(SuimRptBody1700VO suimRptBody1700Vo, PrintWriter out) {
		
		logger.info("editeBody1700_1Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody1700_1",suimRptBody1700Vo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : editeBody1700_2Ok
	 * Method Name :  editeBody1700_2Ok
	 * Description : Print1700_2 조사내용
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160810
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody1700_2Ok", method = RequestMethod.POST)
	public void editeBody1700_2Ok(SuimRptBody1700VO suimRptBody1700Vo, PrintWriter out) {
		
		logger.info("editeBody1700_2Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody1700_2",suimRptBody1700Vo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : insBody1_2Ok
	 * Method Name :  insBody1_2Ok
	 * Description : Print_2 보험 계약사항 신규 입력
	 * 
	 * 번호 1 :  신규 입력 
	 * Author : 이선형
	 * Date : 20160630
	 * ***************************************
	 * */
	@RequestMapping(value = "insBody1_2Ok", method = RequestMethod.POST)
	public void insBody1_2Ok(Model model, SuimRptBody1_2VO suimRptBody1_2Vo,PrintWriter out) {
		
		logger.info("insBody1_2Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int nextPrint1_2Serial = sqlSession.selectOne("SuimRptBodyMapper.nextPrint1_2Serial");
		int result = sqlSession.insert("SuimRptBodyMapper.insBody1_2",suimRptBody1_2Vo);
		
		/*입력 성공 시 방금 입력한 보고서Print1_2 시리얼을 전달 함*/
		if(result >0){
			out.print(nextPrint1_2Serial);
		}else{
			out.print(result);			
		}
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : insBody1_5Ok
	 * Method Name :  insBody1_5Ok
	 * Description : Print_5 경과 표 신규 입력
	 * 
	 * 번호 1 :  신규 입력 
	 * Author : 이선형
	 * Date : 20160701
	 * ***************************************
	 * */
	@RequestMapping(value = "insBody1_5Ok", method = RequestMethod.POST)
	public void insBody1_5Ok(SuimRptBody1_5VO suimRptBody1_5Vo,PrintWriter out) {
		
		logger.info("insBody1_5Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int nextPrint1_5Serial = sqlSession.selectOne("SuimRptBodyMapper.nextPrint1_5Serial");
		int result = sqlSession.insert("SuimRptBodyMapper.insBody1_5",suimRptBody1_5Vo);
		
		/*입력 성공 시 방금 입력한 보고서Print1_2 시리얼을 전달 함*/
		if(result >0){
			out.print(nextPrint1_5Serial);
		}else{
			out.print(result);			
		}
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : insBody1_6_1Ok
	 * Method Name :  insBody1_6_1Ok
	 * Description : Print_6_1 사고내용 신규 입력
	 * 
	 * 번호 1 :  신규 입력 
	 * Author : 이선형
	 * Date : 20160704
	 * ***************************************
	 * */
	@RequestMapping(value = "insBody1_6_1Ok", method = RequestMethod.POST)
	public void insBody1_6_1Ok(SuimRptBody1_6_1VO suimRptBody1_6_1Vo,PrintWriter out) {
		
		logger.info("insBody1_6_1Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int nextPrint1_6_1Serial = sqlSession.selectOne("SuimRptBodyMapper.nextPrint1_6_1Serial");
		int result = sqlSession.insert("SuimRptBodyMapper.insBody1_6_1",suimRptBody1_6_1Vo);
		
		/*입력 성공 시 방금 입력한 보고서Print1_6_1 시리얼을 전달 함*/
		if(result >0){
			out.print(nextPrint1_6_1Serial);
		}else{
			out.print(result);			
		}
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : insBody1_8Ok
	 * Method Name :  insBody1_8Ok
	 * Description : insBody1_8Ok 첨부파일 신규 입력
	 * 
	 * 번호 1 :  신규 입력 
	 * Author : 이선형
	 * Date : 20160705
	 * ***************************************
	 * */
	@RequestMapping(value = "insBody1_8Ok", method = RequestMethod.POST)
	public void insBody1_8Ok(SuimRptBody1_8VO suimRptBody1_8Vo,PrintWriter out) {
		
		logger.info("insBody1_8Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int nextPrint1_8Serial = sqlSession.selectOne("SuimRptBodyMapper.nextPrint1_8Serial");
		int result = sqlSession.insert("SuimRptBodyMapper.insBody1_8",suimRptBody1_8Vo);
		
		String thisNum = sqlSession.selectOne("SuimRptBodyMapper.get1_8Num", suimRptBody1_8Vo.getRptPrintNo());
		
		/*입력 성공 시 방금 입력한 보고서Print1_6_1 시리얼을 전달 함*/
		if(result >0){
			out.print(thisNum+"+"+nextPrint1_8Serial);
		}else{
			out.print(result);			
		}
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : insBody9_fileOk
	 * Method Name :  insBody9_fileOk
	 * Description : insBody9_fileOk 첨부파일 신규 입력
	 * 
	 * 번호 1 :  신규 입력 
	 * Author : 이선형
	 * Date : 20160712
	 * ***************************************
	 * */
	@RequestMapping(value = "insBody9_fileOk", method = RequestMethod.POST)
	public void insBody9_fileOk(SuimRptBody1_8VO suimRptBody1_8Vo,PrintWriter out) {
		
		logger.info("insBody9_fileOk");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int nextPrint9_fileSerial = sqlSession.selectOne("SuimRptBodyMapper.nextPrint9_fileSerial");
		int result = sqlSession.insert("SuimRptBodyMapper.insBody9_file",suimRptBody1_8Vo);
		
		String thisNum = sqlSession.selectOne("SuimRptBodyMapper.get9_fileNum", suimRptBody1_8Vo.getRptPrintNo());
		
		/*입력 성공 시 방금 입력한 보고서Print9_file 시리얼을 전달 함*/
		if(result >0){
			out.print(thisNum+"+"+nextPrint9_fileSerial);
		}else{
			out.print(result);			
		}
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : insBody1_6_2Ok
	 * Method Name :  insBody1_6_2Ok
	 * Description : insBody1_6_2Ok 확인내용 신규 입력
	 * 
	 * 번호 1 :  신규 입력 
	 * Author : 이선형
	 * Date : 20160705
	 * ***************************************
	 * */
	@RequestMapping(value = "insBody1_6_2Ok", method = RequestMethod.POST)
	public void insBody1_6_2Ok(SuimRptBody1_6_2VO suimRptBody1_6_2Vo,PrintWriter out) {
		
		logger.info("insBody1_6_2Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int nextPrint1_6_2Serial = sqlSession.selectOne("SuimRptBodyMapper.nextPrint1_6_2Serial");
		int result = sqlSession.insert("SuimRptBodyMapper.insBody1_6_2",suimRptBody1_6_2Vo);
		
		/*입력 성공 시 방금 입력한 보고서Print1_6_1 시리얼을 전달 함*/
		if(result >0){
			out.print(nextPrint1_6_2Serial);
		}else{
			out.print(result);			
		}
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : insBody9_3aOk
	 * Method Name :  insBody9_3aOk
	 * Description : insBody9_3aOk 조사내용(요약) 나.
	 * 
	 * 번호 1 :  신규 입력 
	 * Author : 이선형
	 * Date : 20160711
	 * ***************************************
	 * */
	@RequestMapping(value = "insBody9_3aOk", method = RequestMethod.POST)
	public void insBody9_3aOk(SuimRptBody9_3aVO suimRptBody9_3aVo,PrintWriter out) {
		
		logger.info("insBody9_3aOk");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int nextPrint9_3a_Serial = sqlSession.selectOne("SuimRptBodyMapper.nextPrint9_3aSerial");
		int result = sqlSession.insert("SuimRptBodyMapper.insBody9_3a",suimRptBody9_3aVo);
		
		/*입력 성공 시 방금 입력한 보고서Print1_6_1 시리얼을 전달 함*/
		if(result >0){
			out.print(nextPrint9_3a_Serial);
		}else{
			out.print(result);			
		}
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : insBody9_3cOk
	 * Method Name :  insBody9_3cOk
	 * Description : insBody9_3cOk 조사내용(요약) 다.
	 * 
	 * 번호 1 :  신규 입력 
	 * Author : 이선형
	 * Date : 20160712
	 * ***************************************
	 * */
	@RequestMapping(value = "insBody9_3cOk", method = RequestMethod.POST)
	public void insBody9_3cOk(SuimRptBody9_3cVO suimRptBody9_3cVo,PrintWriter out) {
		
		logger.info("insBody9_3cOk");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int nextPrint9_3c_Serial = sqlSession.selectOne("SuimRptBodyMapper.nextPrint9_3cSerial");
		int result = sqlSession.insert("SuimRptBodyMapper.insBody9_3c",suimRptBody9_3cVo);
		
		/*입력 성공 시 방금 입력한 보고서Print1_6_1 시리얼을 전달 함*/
		if(result >0){
			out.print(nextPrint9_3c_Serial);
		}else{
			out.print(result);			
		}
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : insBody9_3dOk
	 * Method Name :  insBody9_3dOk
	 * Description : insBody9_3dOk 청구관련 조사내용(상세) 신규 입력
	 * 
	 * 번호 1 :  신규 입력 
	 * Author : 이선형
	 * Date : 20160712
	 * ***************************************
	 * */
	@RequestMapping(value = "insBody9_3dOk", method = RequestMethod.POST)
	public void insBody9_3dOk(SuimRptBody9_3dVO suimRptBody9_3dVo,PrintWriter out) {
		
		logger.info("insBody9_3dOk");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int nextPrint9_3d_Serial = sqlSession.selectOne("SuimRptBodyMapper.nextPrint9_3dSerial");
		int result = sqlSession.insert("SuimRptBodyMapper.insBody9_3d",suimRptBody9_3dVo);
		
		/*입력 성공 시 방금 입력한 보고서Print9_6 시리얼을 전달 함*/
		if(result >0){
			out.print(nextPrint9_3d_Serial);
		}else{
			out.print(result);			
		}
		out.close();
	}
	
	
	
	/*
	 * ***************************************
	 * Method ID : insBody16_3Ok
	 * Method Name :  insBody16_3Ok
	 * Description : insBody16_3Ok 청구내용 및 조사결과 신규 입력
	 * 
	 * 번호 1 :  신규 입력 
	 * Author : 이선형
	 * Date : 20160719
	 * ***************************************
	 * */
	@RequestMapping(value = "insBody16_3Ok", method = RequestMethod.POST)
	public void insBody16_3Ok(SuimRptBody16_3VO suimRptBody16_3Vo,PrintWriter out) {
		
		logger.info("insBody16_3Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int nextPrint16_3_Serial = sqlSession.selectOne("SuimRptBodyMapper.nextPrint16_3Serial");
		int result = sqlSession.insert("SuimRptBodyMapper.insBody16_3",suimRptBody16_3Vo);
		
		/*입력 성공 시 방금 입력한 보고서Print16_3 시리얼을 전달 함*/
		if(result >0){
			out.print(nextPrint16_3_Serial);
		}else{
			out.print(result);			
		}
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : insBody16_4Ok
	 * Method Name :  insBody16_4Ok
	 * Description : insBody16_4Ok 타사 가입사항 추가
	 * 
	 * 번호 1 :  신규 입력 
	 * Author : 이선형
	 * Date : 20160719
	 * ***************************************
	 * */
	@RequestMapping(value = "insBody16_4Ok", method = RequestMethod.POST)
	public void insBody16_4Ok(SuimRptBody16_4VO suimRptBody16_4Vo,PrintWriter out) {
		
		logger.info("insBody16_4Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int nextPrint16_4_Serial = sqlSession.selectOne("SuimRptBodyMapper.nextPrint16_4Serial");
		int result = sqlSession.insert("SuimRptBodyMapper.insBody16_4",suimRptBody16_4Vo);
		
		/*입력 성공 시 방금 입력한 보고서Print16_3 시리얼을 전달 함*/
		if(result >0){
			out.print(nextPrint16_4_Serial);
		}else{
			out.print(result);			
		}
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : insBody17_4Ok
	 * Method Name :  insBody17_4Ok
	 * Description : insBody17_4Ok 타사 가입사항 추가
	 * 
	 * 번호 1 :  신규 입력 
	 * Author : 이선형
	 * Date : 20160728
	 * ***************************************
	 * */
	@RequestMapping(value = "insBody17_4Ok", method = RequestMethod.POST)
	public void insBody17_4Ok(SuimRptBody17_4VO suimRptBody17_4Vo,PrintWriter out) {
		
		logger.info("insBody17_4Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		
		int nextPrint17_4_Serial = sqlSession.selectOne("SuimRptBodyMapper.nextPrint17_4Serial");
		int result = sqlSession.insert("SuimRptBodyMapper.insBody17_4",suimRptBody17_4Vo);
		if(result > 0){
			out.print(nextPrint17_4_Serial);
		}else{
			out.print(result);						
		}
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : insBody17_7Ok
	 * Method Name :  insBody17_7Ok
	 * Description : insBody17_7Ok 치료력
	 * 
	 * 번호 1 :  신규 입력 
	 * Author : 이선형
	 * Date : 20160803
	 * ***************************************
	 * */
	@RequestMapping(value = "insBody17_7Ok", method = RequestMethod.POST)
	public void insBody17_7Ok(SuimRptBody17_7VO suimRptBody17_7Vo,PrintWriter out) {
		
		logger.info("insBody17_7Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		
		int result = sqlSession.insert("SuimRptBodyMapper.insBody17_7",suimRptBody17_7Vo);
		String serialNo = sqlSession.selectOne("SuimRptBodyMapper.getBody17_7Serial", suimRptBody17_7Vo.getSuimRptNo()); 
		if(result > 0){
			out.print(serialNo);
		}else{
			out.print(result);						
		}
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : insBody17_13Ok
	 * Method Name :  insBody17_13Ok
	 * Description : insBody17_13Ok 탐문내역
	 * 
	 * 번호 1 :  신규 입력 
	 * Author : 이선형
	 * Date : 20160803
	 * ***************************************
	 * */
	@RequestMapping(value = "insBody17_13Ok", method = RequestMethod.POST)
	public void insBody17_13Ok(SuimRptBody17_13VO suimRptBody17_13Vo,PrintWriter out) {
		
		logger.info("insBody17_13Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		
		int result = sqlSession.insert("SuimRptBodyMapper.insBody17_13",suimRptBody17_13Vo);
		String serialNo = sqlSession.selectOne("SuimRptBodyMapper.getBody17_13Serial", suimRptBody17_13Vo.getSuimRptNo()); 
		if(result > 0){
			out.print(serialNo);
		}else{
			out.print(result);						
		}
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : insBody1700_7Ok
	 * Method Name :  insBody1700_7Ok
	 * Description : insBody1700_7Ok 첨부파일 신규 입력
	 * 
	 * 번호 1 :  신규 입력 
	 * Author : 이선형
	 * Date : 20160810
	 * ***************************************
	 * */
	@RequestMapping(value = "insBody1700_7Ok", method = RequestMethod.POST)
	public void insBody1700_7Ok(SuimRptBody1_8VO suimRptBody1_8Vo,PrintWriter out) {
		
		logger.info("insBody1700_7Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int nextPrint1700_7Serial = sqlSession.selectOne("SuimRptBodyMapper.nextPrint1700_7Serial");
		int result = sqlSession.insert("SuimRptBodyMapper.insBody1700_7",suimRptBody1_8Vo);
		
		String thisNum = sqlSession.selectOne("SuimRptBodyMapper.get1700_7Num", suimRptBody1_8Vo.getSuimRptNo());
		
		/*입력 성공 시 방금 입력한 보고서Print1_6_1 시리얼을 전달 함*/
		if(result >0){
			out.print(thisNum+"+"+nextPrint1700_7Serial);
		}else{
			out.print(result);			
		}
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : delBody1_2Ok
	 * Method Name :  delBody1_2Ok
	 * Description : Print_1 보험 계약사항 삭제
	 * 
	 * 번호 1 :  삭제 
	 * Author : 이선형
	 * Date : 20160630
	 * ***************************************
	 * */
	@RequestMapping(value = "delBody1_2Ok", method = RequestMethod.POST)
	public void delBody1_2Ok(String serialNo, PrintWriter out) {
		
		logger.info("delBody1_2Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.delete("SuimRptBodyMapper.delBody1_2",serialNo);
		out.print(result);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : delBody1_5Ok
	 * Method Name :  delBody1_5Ok
	 * Description : Print_5 경과표
	 * 
	 * 번호 1 :  삭제 
	 * Author : 이선형
	 * Date : 20160701
	 * ***************************************
	 * */
	@RequestMapping(value = "delBody1_5Ok", method = RequestMethod.POST)
	public void delBody1_5Ok(String serialNo, PrintWriter out) {
		
		logger.info("delBody1_5Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.delete("SuimRptBodyMapper.delBody1_5",serialNo);
		out.print(result);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : delBody1_6_1Ok
	 * Method Name :  delBody1_6_1Ok
	 * Description : Print_6_1 경과표
	 * 
	 * 번호 1 :  삭제 
	 * Author : 이선형
	 * Date : 20160704
	 * ***************************************
	 * */
	@RequestMapping(value = "delBody1_6_1Ok", method = RequestMethod.POST)
	public void delBody1_6_1Ok(String serialNo, PrintWriter out) {
		
		logger.info("delBody1_6_1Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.delete("SuimRptBodyMapper.delBody1_6_1",serialNo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : delBody1_6_2Ok
	 * Method Name :  delBody1_6_2Ok
	 * Description : Print_6_2 기타사항
	 * 
	 * 번호 1 :  삭제 
	 * Author : 이선형
	 * Date : 20160705
	 * ***************************************
	 * */
	@RequestMapping(value = "delBody1_6_2Ok", method = RequestMethod.POST)
	public void delBody1_6_2Ok(String serialNo, PrintWriter out) {
		
		logger.info("delBody1_6_2Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.delete("SuimRptBodyMapper.delBody1_6_2",serialNo);
		out.print(result);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : delBody1_8Ok
	 * Method Name :  delBody1_8Ok
	 * Description : Print_8 첨부파일 목록 삭제
	 * 
	 * 번호 1 :  삭제 
	 * Author : 이선형
	 * Date : 20160705
	 * ***************************************
	 * */
	@RequestMapping(value = "delBody1_8Ok", method = RequestMethod.POST)
	public void delBody1_8Ok(String serialNo, PrintWriter out) {
		
		logger.info("delBody1_8Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.delete("SuimRptBodyMapper.delBody1_8",serialNo);
		out.print(result);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : delBody1700_7Ok
	 * Method Name :  delBody1700_7Ok
	 * Description : Print_1700_7 첨부파일 목록 삭제
	 * 
	 * 번호 1 :  삭제 
	 * Author : 이선형
	 * Date : 20160810
	 * ***************************************
	 * */
	@RequestMapping(value = "delBody1700_7Ok", method = RequestMethod.POST)
	public void delBody1700_7Ok(String serialNo, PrintWriter out) {
		
		logger.info("delBody1700_7Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.delete("SuimRptBodyMapper.delBody1700_7",serialNo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : delBody9_fileOk
	 * Method Name :  delBody9_fileOk
	 * Description : Print9_file 첨부파일 목록 삭제
	 * 
	 * 번호 1 :  삭제 
	 * Author : 이선형
	 * Date : 20160712
	 * ***************************************
	 * */
	@RequestMapping(value = "delBody9_fileOk", method = RequestMethod.POST)
	public void delBody9_fileOk(String serialNo, PrintWriter out) {
		
		logger.info("delBody9_fileOk");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.delete("SuimRptBodyMapper.delBody9_file",serialNo);
		out.print(result);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : delBody9_3aOk
	 * Method Name :  delBody9_3aOk
	 * Description : Print9_3a 피보험자 병력사항 요약 경과표 삭제
	 * 
	 * 번호 1 :  삭제 
	 * Author : 이선형
	 * Date : 20160711
	 * ***************************************
	 * */
	@RequestMapping(value = "delBody9_3aOk", method = RequestMethod.POST)
	public void delBody9_3aOk(String serialNo, PrintWriter out) {
		
		logger.info("delBody9_3aOk");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.delete("SuimRptBodyMapper.delBody9_3a",serialNo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : delBody9_3cOk
	 * Method Name :  delBody9_3cOk
	 * Description : Print9_3c 타 보험사 계약사항
	 * 
	 * 번호 1 :  삭제 
	 * Author : 이선형
	 * Date : 20160712
	 * ***************************************
	 * */
	@RequestMapping(value = "delBody9_3cOk", method = RequestMethod.POST)
	public void delBody9_3cOk(String serialNo, PrintWriter out) {
		
		logger.info("delBody9_3cOk");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.delete("SuimRptBodyMapper.delBody9_3c",serialNo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : delBody9_3dOk
	 * Method Name :  delBody9_3dOk
	 * Description : Print9_3c 청구관련 조사내용 삭제
	 * 
	 * 번호 1 :  삭제 
	 * Author : 이선형
	 * Date : 20160712
	 * ***************************************
	 * */
	@RequestMapping(value = "delBody9_3dOk", method = RequestMethod.POST)
	public void delBody9_3dOk(String serialNo, PrintWriter out) {
		
		logger.info("delBody9_3dOk");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.delete("SuimRptBodyMapper.delBody9_3d",serialNo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : delBody16_3Ok
	 * Method Name :  delBody16_3Ok
	 * Description : Print16_3 조사 일자별 확인사항 삭제
	 * 
	 * 번호 1 :  삭제 
	 * Author : 이선형
	 * Date : 20160719
	 * ***************************************
	 * */
	@RequestMapping(value = "delBody16_3Ok", method = RequestMethod.POST)
	public void delBody16_3Ok(String serialNo, PrintWriter out) {
		
		logger.info("delBody16_3Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.delete("SuimRptBodyMapper.delBody16_3",serialNo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : delBody16_4Ok
	 * Method Name :  delBody16_4Ok
	 * Description : Print16_4 타사 가입사항 삭제
	 * 
	 * 번호 1 :  삭제 
	 * Author : 이선형
	 * Date : 20160719
	 * ***************************************
	 * */
	@RequestMapping(value = "delBody16_4Ok", method = RequestMethod.POST)
	public void delBody16_4Ok(String serialNo, PrintWriter out) {
		
		logger.info("delBody16_4Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.delete("SuimRptBodyMapper.delBody16_4",serialNo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : delBody17_4Ok
	 * Method Name :  delBody17_4Ok
	 * Description : Print17_4 타사 가입사항 삭제
	 * 
	 * 번호 1 :  삭제 
	 * Author : 이선형
	 * Date : 20160728
	 * ***************************************
	 * */
	@RequestMapping(value = "delBody17_4Ok", method = RequestMethod.POST)
	public void delBody17_4Ok(String serialNo, PrintWriter out) {
		
		logger.info("delBody16_4Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.delete("SuimRptBodyMapper.delBody17_4",serialNo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : delBody17_7Ok
	 * Method Name :  delBody17_7Ok
	 * Description : Print17_7 치료력 관련 조사내용
	 * 
	 * 번호 1 :  삭제 
	 * Author : 이선형
	 * Date : 20160803
	 * ***************************************
	 * */
	@RequestMapping(value = "delBody17_7Ok", method = RequestMethod.POST)
	public void delBody17_7Ok(String serialNo, PrintWriter out) {
		
		logger.info("delBody17_7Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.delete("SuimRptBodyMapper.delBody17_7",serialNo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : delBody17_13Ok
	 * Method Name :  delBody17_13Ok
	 * Description : Print17_13 탐문내역 삭제
	 * 
	 * 번호 1 :  삭제 
	 * Author : 이선형
	 * Date : 20160803
	 * ***************************************
	 * */
	@RequestMapping(value = "delBody17_13Ok", method = RequestMethod.POST)
	public void delBody17_13Ok(String serialNo, PrintWriter out) {
		
		logger.info("delBody17_13Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.delete("SuimRptBodyMapper.delBody17_13",serialNo);
		out.print(result);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : editeBody1_2Ok
	 * Method Name :  editeBody1_2Ok
	 * Description : Print1_2 타 보험 계약사항 업데이트
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160630
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody1_2Ok", method = RequestMethod.POST)
	public void editeBody1_2Ok(SuimRptBody1_2VO suimRptBody1_2Vo, PrintWriter out) {
		
		logger.info("editeBody1_2Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody1_2",suimRptBody1_2Vo);
		out.print(result);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : editeBody1_5Ok
	 * Method Name :  editeBody1_5Ok
	 * Description : Print1_5 타 보험 계약사항 업데이트
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160701
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody1_5Ok", method = RequestMethod.POST)
	public void editeBody1_5Ok(SuimRptBody1_5VO suimRptBody1_5Vo, PrintWriter out) {
		
		logger.info("editeBody1_5Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody1_5",suimRptBody1_5Vo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : editeBody1_6_1Ok
	 * Method Name :  editeBody1_6_1Ok
	 * Description : Print1_6_1 타 보험 계약사항 업데이트
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160704
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody1_6_1Ok", method = RequestMethod.POST)
	public void editeBody1_6_1Ok(SuimRptBody1_6_1VO suimRptBody1_6_1Vo, PrintWriter out) {
		
		logger.info("editeBody1_6_1Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody1_6_1",suimRptBody1_6_1Vo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : editeBody1_3Ok
	 * Method Name :  editeBody1_3Ok
	 * Description : Print1_3 사고사항 업데이트
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160630
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody1_3Ok", method = RequestMethod.POST)
	public void editeBody1_3Ok(SuimRptBody1_13467VO suimRptBody1_13467Vo, PrintWriter out) {
		
		logger.info("editeBody1_3Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody1_3",suimRptBody1_13467Vo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : editeBody1_4Ok
	 * Method Name :  editeBody1_4Ok
	 * Description : Print1_4 조사사항 업데이트
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160630
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody1_4Ok", method = RequestMethod.POST)
	public void editeBody1_4Ok(SuimRptBody1_13467VO suimRptBody1_13467Vo, PrintWriter out) {
		
		logger.info("editeBody1_4Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*suimRptBody1_13467Vo.setInspectPoint4(suimRptBody1_13467Vo.getInspectPoint4().replace("\n", "<br>"));
		suimRptBody1_13467Vo.setInspectResult4(suimRptBody1_13467Vo.getInspectResult4().replace("\n", "<br>"));*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody1_4",suimRptBody1_13467Vo);
		out.print(result);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : editeBody1_6Ok
	 * Method Name :  editeBody1_6Ok
	 * Description : Print1_6 조사내용 업데이트
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160704
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody1_6Ok", method = RequestMethod.POST)
	public void editeBody1_6Ok(SuimRptBody1_13467VO suimRptBody1_13467Vo, PrintWriter out) {
		
		logger.info("editeBody1_6Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*suimRptBody1_13467Vo.setInspectPoint4(suimRptBody1_13467Vo.getInspectPoint4().replace("\n", "<br>"));
		suimRptBody1_13467Vo.setInspectResult4(suimRptBody1_13467Vo.getInspectResult4().replace("\n", "<br>"));*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody1_6",suimRptBody1_13467Vo);
		out.print(result);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : editeBody1_7Ok
	 * Method Name :  editeBody1_7Ok
	 * Description : Print1_7 손해사정결과 업데이트
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160705
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody1_7Ok", method = RequestMethod.POST)
	public void editeBody1_7Ok(SuimRptBody1_13467VO suimRptBody1_13467Vo, PrintWriter out) {
		
		logger.info("editeBody1_7Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*suimRptBody1_13467Vo.setInspectPoint4(suimRptBody1_13467Vo.getInspectPoint4().replace("\n", "<br>"));
		suimRptBody1_13467Vo.setInspectResult4(suimRptBody1_13467Vo.getInspectResult4().replace("\n", "<br>"));*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody1_7",suimRptBody1_13467Vo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : editeBody1_8Ok
	 * Method Name :  editeBody1_8Ok
	 * Description : Print1_8 첨부파일 목록 업데이트
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160705
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody1_8Ok", method = RequestMethod.POST)
	public void editeBody1_8Ok(SuimRptBody1_8VO suimRptBody1_8Vo, PrintWriter out) {
		
		logger.info("editeBody1_8Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody1_8",suimRptBody1_8Vo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : editeBody16_2Ok
	 * Method Name :  editeBody16_2Ok
	 * Description : Print16_2 청구내용 및 조사결과
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160718
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody16_2Ok", method = RequestMethod.POST)
	public void editeBody16_2Ok(SuimRptBody16_1267VO suimRptBody16_1267Vo, PrintWriter out) {
		
		logger.info("editeBody16_2Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody16_2",suimRptBody16_1267Vo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : editeBody16_5Ok
	 * Method Name :  editeBody16_5Ok
	 * Description : Print16_5 주요쟁점사항
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160720
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody16_5Ok", method = RequestMethod.POST)
	public void editeBody16_5Ok(SuimRptBody16_1267VO suimRptBody16_1267Vo, PrintWriter out) {
		
		logger.info("editeBody16_5Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody16_5",suimRptBody16_1267Vo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : editeBody16_7Ok
	 * Method Name :  editeBody16_7Ok
	 * Description : Print16_7 피보험자 면담
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160720
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody16_7Ok", method = RequestMethod.POST)
	public void editeBody16_7Ok(SuimRptBody16_1267VO suimRptBody16_1267Vo, PrintWriter out) {
		
		logger.info("editeBody16_7Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody16_7",suimRptBody16_1267Vo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : editeBody17_4Ok
	 * Method Name :  editeBody17_4Ok
	 * Description : Print17_4 타사 가입내역 수정
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160728
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody17_4Ok", method = RequestMethod.POST)
	public void editeBody17_4Ok(SuimRptBody17_4VO suimRptBody17_4Vo, PrintWriter out) {
		
		logger.info("editeBody17_4Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody17_4",suimRptBody17_4Vo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : editeBody17_5Ok
	 * Method Name :  editeBody17_5Ok
	 * Description : Print17_5 형사기록 수정
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160728
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody17_5Ok", method = RequestMethod.POST)
	public void editeBody17_5Ok(SuimRptBody17_1356891112VO suimRptBody17_1356891112Vo, PrintWriter out) {
		
		logger.info("editeBody17_5Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody17_5",suimRptBody17_1356891112Vo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : editeBody17_6Ok
	 * Method Name :  editeBody17_6Ok
	 * Description : Print17_6 사실확인 / 면부책여부 수정
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160728
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody17_6Ok", method = RequestMethod.POST)
	public void editeBody17_6Ok(SuimRptBody17_1356891112VO suimRptBody17_1356891112Vo, PrintWriter out) {
		
		logger.info("editeBody17_6Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody17_6",suimRptBody17_1356891112Vo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : editeBody17_7Ok
	 * Method Name :  editeBody17_7Ok
	 * Description : Print17_7 치료력
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160803
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody17_7Ok", method = RequestMethod.POST)
	public void editeBody17_7Ok(SuimRptBody17_7VO suimRptBody17_7Vo, PrintWriter out) {
		
		logger.info("editeBody17_7Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody17_7",suimRptBody17_7Vo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : editeBody17_8Ok
	 * Method Name :  editeBody17_8Ok
	 * Description : Print17_8 체결경위
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160728
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody17_8Ok", method = RequestMethod.POST)
	public void editeBody17_8Ok(SuimRptBody17_1356891112VO suimRptBody17_1356891112Vo, PrintWriter out) {
		
		logger.info("editeBody17_8Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody17_8",suimRptBody17_1356891112Vo);
		out.print(result);
		out.close();
	}
	

	/*
	 * ***************************************
	 * Method ID : 	editeBody17_9Ok
	 * Method Name :  	editeBody17_9Ok
	 * Description : Print17_9 조사결과 요약
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160728
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody17_9Ok", method = RequestMethod.POST)
	public void editeBody17_9Ok(SuimRptBody17_1356891112VO suimRptBody17_1356891112Vo, PrintWriter out) {
		
		logger.info("editeBody17_9Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody17_9",suimRptBody17_1356891112Vo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : 	editeBody17_12Ok
	 * Method Name :  	editeBody17_12Ok
	 * Description : Print17_12 제3자 개입여부
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160729
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody17_12Ok", method = RequestMethod.POST)
	public void editeBody17_12Ok(SuimRptBody17_1356891112VO suimRptBody17_1356891112Vo, PrintWriter out) {
		
		logger.info("editeBody17_12Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody17_12",suimRptBody17_1356891112Vo);
		out.print(result);
		out.close();
	}
	
	
	
	/*
	 * ***************************************
	 * Method ID : 	editeBody17_13Ok
	 * Method Name :  	editeBody17_13Ok
	 * Description : Print17_13 탐문내역
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160803
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody17_13Ok", method = RequestMethod.POST)
	public void editeBody17_13Ok(SuimRptBody17_13VO suimRptBody17_13Vo, PrintWriter out) {
		
		logger.info("editeBody17_13Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody17_13",suimRptBody17_13Vo);
		out.print(result);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : 	editeBody17_11Ok
	 * Method Name :  	editeBody17_11Ok
	 * Description : Print17_11 현장조사 체크리스트
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160729
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody17_11Ok", method = RequestMethod.POST)
	public void editeBody17_11Ok(SuimRptBody17_1356891112VO suimRptBody17_1356891112Vo, PrintWriter out) {
		
		logger.info("editeBody17_11Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody17_11",suimRptBody17_1356891112Vo);
		out.print(result);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : editeBody1700_7Ok
	 * Method Name :  editeBody1700_7Ok
	 * Description : Print1700_7 첨부파일 목록 업데이트
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160810
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody1700_7Ok", method = RequestMethod.POST)
	public void editeBody1700_7Ok(SuimRptBody1_8VO suimRptBody1_8Vo, PrintWriter out) {
		
		logger.info("editeBody1700_7Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody1700_7",suimRptBody1_8Vo);
		out.print(result);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : editeBody9_fileOk
	 * Method Name :  editeBody9_fileOk
	 * Description : Print9_file 첨부파일 목록 업데이트
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160712
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody9_fileOk", method = RequestMethod.POST)
	public void editeBody9_fileOk(SuimRptBody1_8VO suimRptBody1_8Vo, PrintWriter out) {
		
		logger.info("editeBody9_fileOk");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody9_file",suimRptBody1_8Vo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : editeBody9_3aOk
	 * Method Name :  editeBody9_3aOk
	 * Description : Print9_3a 조사내용(요약) 경과표
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160711
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody9_3aOk", method = RequestMethod.POST)
	public void editeBody9_3aOk(SuimRptBody9_3aVO suimRptBody9_3aVo, PrintWriter out) {
		
		logger.info("editeBody9_3aOk");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody9_3a",suimRptBody9_3aVo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : editeBody9_3cOk
	 * Method Name :  editeBody9_3cOk
	 * Description : Print9_3c 타 보험사 처리 내역
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160712
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody9_3cOk", method = RequestMethod.POST)
	public void editeBody9_3cOk(SuimRptBody9_3cVO suimRptBody9_3cVo, PrintWriter out) {
		
		logger.info("editeBody9_3cOk");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody9_3c",suimRptBody9_3cVo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : editeBody9_3dOk
	 * Method Name :  editeBody9_3dOk
	 * Description : Print9_3d 청구관련 조사내용 상세 업데이트
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160712
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody9_3dOk", method = RequestMethod.POST)
	public void editeBody9_3dOk(SuimRptBody9_3dVO suimRptBody9_3dVo, PrintWriter out) {
		
		logger.info("editeBody9_3dOk");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody9_3d",suimRptBody9_3dVo);
		out.print(result);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : editeBody9_3bOk
	 * Method Name :  editeBody9_3bOk
	 * Description : Print9_3b 조사내용(요약) 가.
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160711
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody9_3bOk", method = RequestMethod.POST)
	public void editeBody9_3bOk(SuimRptBody9_13467VO suimRptBody9_13467Vo, PrintWriter out) {
		
		logger.info("editeBody9_3bOk");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody9_3b",suimRptBody9_13467Vo);
		out.print(result);
		out.close();
	}
	
	
	
	/*
	 * ***************************************
	 * Method ID : editeBody16_3Ok
	 * Method Name :  editeBody16_3Ok
	 * Description : Print16_3 업데이트
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160719
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody16_3Ok", method = RequestMethod.POST)
	public void editeBody16_3Ok(SuimRptBody16_3VO suimRptBody16_3Vo, PrintWriter out) {
		
		logger.info("editeBody16_3Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody16_3",suimRptBody16_3Vo);
		out.print(result);
		out.close();
	}
	
	
	
	/*
	 * ***************************************
	 * Method ID : editeBody16_4Ok
	 * Method Name :  editeBody16_4Ok
	 * Description : Print16_4 업데이트
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160719
	 * ***************************************
	 * */
	@RequestMapping(value = "editeBody16_4Ok", method = RequestMethod.POST)
	public void editeBody16_4Ok(SuimRptBody16_4VO suimRptBody16_4Vo, PrintWriter out) {
		
		logger.info("editeBody16_4Ok");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody16_4",suimRptBody16_4Vo);
		out.print(result);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : print1ImgEditOk
	 * Method Name :  print1ImgEditOk
	 * Description : Print1 첨부 설명 업데이트
	 * 
	 * 번호 1 :  업데이트 
	 * Author : 이선형
	 * Date : 20160706 
	 * ***************************************
	 * */
	@RequestMapping(value = "print1ImgEditOk", method = RequestMethod.POST)
	public void print1ImgEditOk(SuimRptImgPrint_1VO suimRptImgPrint_1Vo, PrintWriter out) {
		
		logger.info("print1ImgEditOk");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*번호 1*/
		int result = sqlSession.update("SuimRptBodyMapper.udtBody1ImgInfo",suimRptImgPrint_1Vo);
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : print1ImgDelOk
	 * Method Name :  print1ImgDelOk
	 * Description : Print1 첨부 이미지 삭제
	 * 
	 * 번호 1 :  삭제 
	 * Author : 이선형
	 * Date : 20160706
	 * ***************************************
	 * */
	@RequestMapping(value = "print1ImgDelOk", method = RequestMethod.POST)
	public void print1ImgDelOk(String imgSerial, String suimRptNo, PrintWriter out, String imgName) {
		
		logger.info("print1ImgDelOk");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		int result = 0;
		String path = "/home/hosting_users/toplac/www"+sqlSession.selectOne("SuimRptBodyMapper.getDelPrint1FilePath", imgSerial);
		String fileforder = path.substring(0, path.lastIndexOf("/"));
		/*파일 삭제 시작*/
		if(!fileforder.equals("")){
			
			File file = new File(path);
			File dir = new File(fileforder);
			file.delete();
			dir.delete();
			
			result = 1;
		}
		/*파일 삭제 끝*/
		
		/*번호 1*/
		if(result >0){
			result = sqlSession.delete("SuimRptBodyMapper.delPrint1Img",imgSerial);			
		}
		out.print(result);
		out.close();
	}
	
	
	/*
	*********************************************************
	* Program ID	: ins9printCtrl
	* Program Name	: ins9printCtrl
	* Description	: 롯데보고서 사고처리과정표 - 처리과정 - INSERT
	* Author		: 임대성
	* Date			: 2017.06.23.
	*********************************************************
	*/
	@RequestMapping(value = "ins9printCtrl", method = RequestMethod.POST)
	public String ins9printCtrl(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= ins9printCtrl =======");
		
		int insCnt = sqlSession.insert("SuimRptBodyMapper.ins9printCtrl", print1001Vo);
		
		if( insCnt == 1){
			List<SuimPrint1001VO> print_9_ctrl = sqlSession.selectList("SuimRptBodyMapper.get9Print_9_ctrl", print1001Vo.getRptPrintNo());
			SuimPrint1001VO print_9_ctrl_delay_cnt = sqlSession.selectOne("SuimRptBodyMapper.get9Print_9_ctrl_delay_cnt", print1001Vo.getRptPrintNo());
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
			model.addAttribute("print_9_ctrl_delay_cnt",print_9_ctrl_delay_cnt);
			model.addAttribute("print_9_ctrl",print_9_ctrl);
			
			return "top_suim_print/suim_rpt_bsc_print_9_printCtrlLotte";
			
		}else{
			return "rpt_in/suim_rpt_bsc_print_1001_ajaxError"; 
		}
	}	



	/*
	*********************************************************
	* Program ID	: del9printCtrl
	* Program Name	: del9printCtrl
	* Description	: 롯데보고서 사고처리과정표 - 처리과정 DELETE
	* Author		: 임대성
	* Date			: 2017.06.23.
	*********************************************************
	*/
	@RequestMapping(value = "del9printCtrl", method = RequestMethod.POST)
	public String del9printCtrl(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= del9printCtrl =======");
		
		int delCnt = sqlSession.delete("SuimRptBodyMapper.del9printCtrl", print1001Vo.getSerialNo());
		
		if( delCnt == 1){
			List<SuimPrint1001VO> print_9_ctrl = sqlSession.selectList("SuimRptBodyMapper.get9Print_9_ctrl", print1001Vo.getRptPrintNo());
			SuimPrint1001VO print_9_ctrl_delay_cnt = sqlSession.selectOne("SuimRptBodyMapper.get9Print_9_ctrl_delay_cnt", print1001Vo.getRptPrintNo());
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
			
			model.addAttribute("print_9_ctrl_delay_cnt",print_9_ctrl_delay_cnt);
			model.addAttribute("print_9_ctrl",print_9_ctrl);
			
			return "top_suim_print/suim_rpt_bsc_print_9_printCtrlLotte";
			
		}else{
			return "rpt_in/suim_rpt_bsc_print_1001_ajaxError"; 
		}
	}



	/*
	*********************************************************
	* Program ID	: udt9printCtrl
	* Program Name	: udt9printCtrl
	* Description	: 롯데보고서 사고처리과정표 - 처리과정 UPDATE
	* Author		: 임대성
	* Date			: 2017.06.23.
	*********************************************************
	*/
	@RequestMapping(value = "udt9printCtrl", method = RequestMethod.POST)
	public String udt9printCtrl(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= udt9printCtrl =======");
		
		int uptCnt = sqlSession.update("SuimRptBodyMapper.udt9printCtrl", print1001Vo);
		
		if( uptCnt == 1){
			List<SuimPrint1001VO> print_9_ctrl = sqlSession.selectList("SuimRptBodyMapper.get9Print_9_ctrl", print1001Vo.getRptPrintNo());
			SuimPrint1001VO print_9_ctrl_delay_cnt = sqlSession.selectOne("SuimRptBodyMapper.get9Print_9_ctrl_delay_cnt", print1001Vo.getRptPrintNo());
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
			
			model.addAttribute("print_9_ctrl_delay_cnt",print_9_ctrl_delay_cnt);
			model.addAttribute("print_9_ctrl",print_9_ctrl);
			
			return "top_suim_print/suim_rpt_bsc_print_9_printCtrlLotte";
		}else{
			return "rpt_in/suim_rpt_bsc_print_1001_ajaxError"; 
		}
	}
	
	/*
	*********************************************************
	* Program ID	: udt9printCtrlDelay
	* Program Name	: udt9printCtrlDelay
	* Description	: 롯데보고서 사고처리과정표 - 처리과정 UPDATE
	* Author		: 임대성
	* Date			: 2017.06.23.
	*********************************************************
	*/
	@RequestMapping(value = "udt9printCtrlDelay", method = RequestMethod.POST)
	public String udt9printCtrlDelay(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= udt9printCtrlDelay =======");
		
		int uptCnt = sqlSession.update("SuimRptBodyMapper.udt9printCtrlDelay", print1001Vo);
		
		if( uptCnt == 1){
			List<SuimPrint1001VO> print_9_ctrl = sqlSession.selectList("SuimRptBodyMapper.get9Print_9_ctrl", print1001Vo.getRptPrintNo());
			SuimPrint1001VO print_9_ctrl_delay_cnt = sqlSession.selectOne("SuimRptBodyMapper.get9Print_9_ctrl_delay_cnt", print1001Vo.getRptPrintNo());
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
			
			model.addAttribute("print_9_ctrl_delay_cnt",print_9_ctrl_delay_cnt);
			model.addAttribute("print_9_ctrl",print_9_ctrl);
			
			return "top_suim_print/suim_rpt_bsc_print_9_printCtrlLotte";
		}else{
			return "rpt_in/suim_rpt_bsc_print_1001_ajaxError"; 
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
