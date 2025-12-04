package kr.co.toplac.rptin;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

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

import com.google.gson.Gson;
import com.mchange.v2.sql.filter.SynchronizedFilterCallableStatement;

import kr.co.toplac.toprptinv.TopRptInvDtlViewVO;
import kr.co.toplac.topsuim.SuimRptBody6VO;
import kr.co.toplac.topsuim.SuimRptCompositeVO;
import kr.co.toplac.topsuim.SuimRptSagoBsc16VO;
import kr.co.toplac.topsuim.SuimRptSagoBscVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopMbrSgnVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.etc.Damo;


@Controller
public class SuimPrintController {

	private static final Logger logger = LoggerFactory.getLogger(SuimPrintController.class);

	@Autowired
	private SqlSession sqlSession;

	
	/*
	 * ***************************************
	 * Method ID : PrintWord1001
	 * Method Name :  PrintWord1001
	 * Description : 보고서 워드다운 및 인쇄하기
	 * Author : 임대성
	 * Date : 20170223
	 * ***************************************
	 * */
	@RequestMapping(value = "PrintWord1001", method = RequestMethod.GET)
	public String PrintWord1001(Model model, HttpServletResponse response, HttpSession session, String suimRptNo, String type) {
		if(type.equals("word")){
			logger.info("PrintWord1001 - word");			
		}else{
			logger.info("PrintWord1001 - page");
		}
		
		SuimPrint1001 print1001 = new SuimPrint1001();
		print1001.SuimPrint1001_print1(sqlSession,model,suimRptNo);
		
		SuimRptCompositeVO suimListDtl = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", suimRptNo);
		
		TopTmBscVO topTmBscVo = sqlSession.selectOne("SuimRptBodyMapper.topTmInfoForBody", suimListDtl.getTeam_id());
		TopMbrBscVO mbrVoForBody = sqlSession.selectOne("SuimRptBodyMapper.mbrinfo", suimListDtl.getUser_no());
		
		TopRptInvDtlViewVO suimInvVO = sqlSession.selectOne("InvoiceDtlMapper.getInvoiceDtlForRptDtl", suimRptNo);
		
		/*** 암호화 ***/
		Damo damo = new Damo();
		if ( suimListDtl.getPolicyholder_ssn() != null && !suimListDtl.getPolicyholder_ssn().equals("") ){
			suimListDtl.setPolicyholder_ssn( damo.decodeDamo(suimListDtl.getPolicyholder_ssn()) );
		}
		if ( suimListDtl.getBeneficiary_ssn() != null && !suimListDtl.getBeneficiary_ssn().equals("") ){
			suimListDtl.setBeneficiary_ssn( damo.decodeDamo(suimListDtl.getBeneficiary_ssn()) );
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
		
		TopMbrBscVO mbrVoForBodySantion = sqlSession.selectOne("SuimRptBodyMapper.mbrinfo", suimListDtl.getSuimRptAprvUserNo());
		
		/*사고처리 과정표 정보 추출 시작*/
		List<SuimRptSagoBscVO> sagoList  = sqlSession.selectList("SagoBscMapper.getSagoList", suimRptNo);

		model.addAttribute("sagoList", sagoList);
		model.addAttribute("tmInforForBody",topTmBscVo);
		model.addAttribute("mbrVoForBody",mbrVoForBody);
		model.addAttribute("mbrVoForBodySantion",mbrVoForBodySantion);
		model.addAttribute("suimVO", suimListDtl);
		model.addAttribute("suimInvVO", suimInvVO);
		
		if(type.equals("word")){
			String filename = suimListDtl.getSuim_accept_no();
			try {
				filename = java.net.URLEncoder.encode(filename,"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			response.setHeader("Content-Disposition", "attachment;filename="+filename+".doc");
			response.setHeader("Content-Description", "JSP Generated Data");
		    response.setContentType("application/vnd.ms-word");
			
			return "rpt_in/suim_rpt_bsc_print_1001_word";				
		}else{
			return "rpt_in/suim_rpt_bsc_print_1001_print";
		}			
	}
	
	
	/*
	*********************************************************
	* Program ID	: udtPrint1001One
	* Program Name	: udtPrint1001One
	* Description	: 단순보고서 1.계약확인사항 update
	* Author		: 임대성
	* Date			: 2017.02.16.
	*********************************************************
	*/
	@RequestMapping(value = "udtPrint1001One", method = RequestMethod.POST)
	public void udtPrint1001One(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= udtPrint1001One =======");
		
		int bodyUdtCnt = sqlSession.update("SuimRptPrintMapper.udt1001OneBody", print1001Vo);
		int Print1UdtCnt = sqlSession.update("SuimRptPrintMapper.udt1001OnePrint1", print1001Vo);
		if (bodyUdtCnt == 1 && Print1UdtCnt == 1){
			PrintWriter out = null;
			try {
				out = response.getWriter();
			} catch (IOException e) {
				e.printStackTrace();
			} 
			out.print("1");
			out.close();
		}
	}
	
	/*
	*********************************************************
	* Program ID	: udt1001claim
	* Program Name	: udt1001claim
	* Description	: 단순보고서 2.청구사항 update
	* Author		: 임대성
	* Date			: 2017.02.16.
	*********************************************************
	*/
	@RequestMapping(value = "udt1001claim", method = RequestMethod.POST)
	public void udt1001claim(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= udt1001claim =======");
		
		int insCnt = sqlSession.update("SuimRptPrintMapper.udt1001claim", print1001Vo);
		
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		if (insCnt == 1){
			out.print("1");
		}else{
			out.print("0");
		}
		
		out.close();
	}
	
	
	/*
	*********************************************************
	* Program ID	: ins1001Assure
	* Program Name	: ins1001Assure
	* Description	: 단순보고서 2.청구사항 - 담보내역 insert
	* Author		: 임대성
	* Date			: 2017.02.16.
	*********************************************************
	*/
	@RequestMapping(value = "ins1001Assure", method = RequestMethod.POST)
	public String ins1001Assure(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= ins1001Assure =======");
		
		int insCnt = sqlSession.insert("SuimRptPrintMapper.ins1001Assure", print1001Vo);
		if ( insCnt == 1){
			List<SuimPrint1001VO> print_1_assure = sqlSession.selectList("SuimRptPrintMapper.get1001Print_1_assure", print1001Vo.getRptPrintNo());
			
			model.addAttribute("print_1_assure",print_1_assure);
			return "rpt_in/suim_rpt_bsc_print_1001_assure";
		}else{
			return "rpt_in/suim_rpt_bsc_print_1001_ajaxError";
		}
	}
	
	/*
	*********************************************************
	* Program ID	: del1001Assure
	* Program Name	: del1001Assure
	* Description	: 단순보고서 2.청구사항 - 담보내역 delete
	* Author		: 임대성
	* Date			: 2017.03.10.
	*********************************************************
	*/
	@RequestMapping(value = "del1001Assure", method = RequestMethod.POST)
	public String delPrint1001Claim(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, String rptPrintNo, String serialNo) {
		logger.info("======= del1001assure =======");
		
		int delCnt = sqlSession.delete("SuimRptPrintMapper.del1001Assure", serialNo);
		
		if( delCnt == 1 ){
			List<SuimPrint1001VO> print_1_assure = sqlSession.selectList("SuimRptPrintMapper.get1001Print_1_assure", rptPrintNo);
			
			model.addAttribute("print_1_assure",print_1_assure);
			return "rpt_in/suim_rpt_bsc_print_1001_assure";
		}else{
			return "rpt_in/suim_rpt_bsc_print_1001_ajaxError";
		}
	}
	
	
	/*
	*********************************************************
	* Program ID	: del1001Assure
	* Program Name	: del1001Assure
	* Description	: 단순보고서 2.청구사항 - 담보내역 update
	* Author		: 임대성
	* Date			: 2017.03.10.
	*********************************************************
	*/
	@RequestMapping(value = "udt1001Assure", method = RequestMethod.POST)
	public String udt1001Assure(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= udt1001Assure =======");
		
		int udtCnt = sqlSession.update("SuimRptPrintMapper.udt1001Assure", print1001Vo);
		
		if (udtCnt == 1){
			List<SuimPrint1001VO> print_1_assure = sqlSession.selectList("SuimRptPrintMapper.get1001Print_1_assure", print1001Vo.getRptPrintNo());
				
			model.addAttribute("print_1_assure",print_1_assure);
			return "rpt_in/suim_rpt_bsc_print_1001_assure";
		}else{
			return "rpt_in/suim_rpt_bsc_print_1001_ajaxError";
		}
		
	}
	
	
	/*
	*********************************************************
	* Program ID	: ins1001otherInsu
	* Program Name	: ins1001otherInsu
	* Description	: 단순보고서 3.타 보험사 계약 및 지급사항
	* Author		: 임대성
	* Date			: 2017.03.17.
	*********************************************************
	*/
	@RequestMapping(value = "ins1001otherInsu", method = RequestMethod.POST)
	public String ins1001otherInsu(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= ins1001otherInsu =======");
		
		int insCnt = sqlSession.insert("SuimRptPrintMapper.ins1001otherInsu", print1001Vo);
		
		if( insCnt == 1){
			List<SuimPrint1001VO> print_1_2_1001 = sqlSession.selectList("SuimRptPrintMapper.get1001Print_1_2", print1001Vo.getRptPrintNo());
			
			model.addAttribute("print_1_2",print_1_2_1001);
			return "rpt_in/suim_rpt_bsc_print_1001_otherInsu";
		}else{
			return "rpt_in/suim_rpt_bsc_print_1001_ajaxError"; 
		}
	}

	
	/*
	*********************************************************
	* Program ID	: del1001otherInsu
	* Program Name	: del1001otherInsu
	* Description	: 단순보고서 3.타 보험사 계약 및 지급사항 - 삭제
	* Author		: 임대성
	* Date			: 2017.03.17.
	*********************************************************
	*/
	@RequestMapping(value = "del1001otherInsu", method = RequestMethod.POST)
	public String del1001otherInsu(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= del1001otherInsu =======");
		
		int delCnt = sqlSession.delete("SuimRptPrintMapper.del1001otherInsu", print1001Vo.getSerialNo());
		
		if( delCnt == 1){
			List<SuimPrint1001VO> print_1_2_1001 = sqlSession.selectList("SuimRptPrintMapper.get1001Print_1_2", print1001Vo.getRptPrintNo());
			
			model.addAttribute("print_1_2",print_1_2_1001);
			return "rpt_in/suim_rpt_bsc_print_1001_otherInsu";
		}else{
			return "rpt_in/suim_rpt_bsc_print_1001_ajaxError"; 
		}
	}
	
	/*
	*********************************************************
	* Program ID	: udt1001otherInsu
	* Program Name	: udt1001otherInsu
	* Description	: 단순보고서 3.타 보험사 계약 및 지급사항 - 수정
	* Author		: 임대성
	* Date			: 2017.03.10.
	*********************************************************
	*/
	@RequestMapping(value = "udt1001otherInsu", method = RequestMethod.POST)
	public String udt1001otherInsu(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= udt1001otherInsu =======");
		
		int udtCnt = sqlSession.update("SuimRptPrintMapper.udt1001otherInsu", print1001Vo);
		
		if (udtCnt == 1){
			List<SuimPrint1001VO> print_1_2_1001 = sqlSession.selectList("SuimRptPrintMapper.get1001Print_1_2", print1001Vo.getRptPrintNo());
			
			model.addAttribute("print_1_2",print_1_2_1001);
			return "rpt_in/suim_rpt_bsc_print_1001_otherInsu";
		}else{
			return "rpt_in/suim_rpt_bsc_print_1001_ajaxError"; 
		}
		
	}

	/*
	*********************************************************
	* Program ID	: udt1001inspectPoint
	* Program Name	: udt1001inspectPoint
	* Description	: 단순보고서 4. 중점 조사사항 및 조사 결과 - 중점 조사사항 UPDATE
	* Author		: 임대성
	* Date			: 2017.03.10.
	*********************************************************
	*/
	@RequestMapping(value = "udt1001inspectPoint", method = RequestMethod.POST)
	public void udt1001inspectPoint(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= udt1001inspectPoint =======");
		
		int udtCnt = sqlSession.update("SuimRptPrintMapper.udt1001inspectPoint", print1001Vo);
		
		if (udtCnt == 1){
			PrintWriter out = null;
			try {
				out = response.getWriter();
			} catch (IOException e) {
				e.printStackTrace();
			} 
			out.print("1");
			out.close();
		}
	}
	
	/*
	*********************************************************
	* Program ID	: udt1001inspectResult
	* Program Name	: udt1001inspectResult
	* Description	: 단순보고서 4. 중점 조사사항 및 조사 결과 - 조사결과 UPDATE
	* Author		: 임대성
	* Date			: 2017.03.10.
	*********************************************************
	*/
	@RequestMapping(value = "udt1001inspectResult", method = RequestMethod.POST)
	public void udt1001inspectResult(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= udt1001inspectResult =======");
		
		int udtCnt = sqlSession.update("SuimRptPrintMapper.udt1001inspectResult", print1001Vo);
		
		if (udtCnt == 1){
			PrintWriter out = null;
			try {
				out = response.getWriter();
			} catch (IOException e) {
				e.printStackTrace();
			} 
			out.print("1");
			out.close();
		}
	}
	
	/*
	*********************************************************
	* Program ID	: ins1001passTable
	* Program Name	: ins1001passTable
	* Description	: 단순보고서 5. 총괄 경과표 - INSERT
	* Author		: 임대성
	* Date			: 2017.03.22.
	*********************************************************
	*/
	@RequestMapping(value = "ins1001passTable", method = RequestMethod.POST)
	public String ins1001passTable(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= ins1001passTable =======");
		
		int insCnt = sqlSession.insert("SuimRptPrintMapper.ins1001passTable", print1001Vo);
		
		if( insCnt == 1){
			List<SuimPrint1001VO> print_1_6_1_1001 = sqlSession.selectList("SuimRptPrintMapper.get1001Print_1_6_1", print1001Vo.getRptPrintNo());
			model.addAttribute("print_1_6_1",print_1_6_1_1001);
			return "rpt_in/suim_rpt_bsc_print_1001_passTable";
		}else{
			return "rpt_in/suim_rpt_bsc_print_1001_ajaxError"; 
		}
	}
	
	/*
	*********************************************************
	* Program ID	: udt1001passTable
	* Program Name	: udt1001passTable
	* Description	: 단순보고서 5. 총괄 경과표 - UPDATE
	* Author		: 임대성
	* Date			: 2017.03.22.
	*********************************************************
	*/
	@RequestMapping(value = "udt1001passTable", method = RequestMethod.POST)
	public String udt1001passTable(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= udt1001passTable =======");
		
		int udtCnt = sqlSession.update("SuimRptPrintMapper.udt1001passTable", print1001Vo);
		
		if( udtCnt == 1){
			List<SuimPrint1001VO> print_1_6_1_1001 = sqlSession.selectList("SuimRptPrintMapper.get1001Print_1_6_1", print1001Vo.getRptPrintNo());
			model.addAttribute("print_1_6_1",print_1_6_1_1001);
			return "rpt_in/suim_rpt_bsc_print_1001_passTable";
		}else{
			return "rpt_in/suim_rpt_bsc_print_1001_ajaxError"; 
		}
	}
	
	/*
	*********************************************************
	* Program ID	: del1001passTable
	* Program Name	: del1001passTable
	* Description	: 단순보고서 5. 총괄 경과표 - DELETE
	* Author		: 임대성
	* Date			: 2017.03.22.
	*********************************************************
	*/
	@RequestMapping(value = "del1001passTable", method = RequestMethod.POST)
	public String del1001passTable(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= del1001passTable =======");
		
		int delCnt = sqlSession.delete("SuimRptPrintMapper.del1001passTable", print1001Vo.getSerialNo());
		
		if( delCnt == 1){
			List<SuimPrint1001VO> print_1_6_1_1001 = sqlSession.selectList("SuimRptPrintMapper.get1001Print_1_6_1", print1001Vo.getRptPrintNo());
			model.addAttribute("print_1_6_1",print_1_6_1_1001);
			
			return "rpt_in/suim_rpt_bsc_print_1001_passTable";
		}else{
			return "rpt_in/suim_rpt_bsc_print_1001_ajaxError"; 
		}
	}
	
	/*
	*********************************************************
	* Program ID	: ins1001printCtrl
	* Program Name	: ins1001printCtrl
	* Description	: 단순보고서 사고처리과정표 - 처리과정 - INSERT
	* Author		: 임대성
	* Date			: 2017.03.24.
	*********************************************************
	*/
	@RequestMapping(value = "ins1001printCtrl", method = RequestMethod.POST)
	public String ins1001printCtrl(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= ins1001printCtrl =======");
		
		int insCnt = sqlSession.insert("SuimRptPrintMapper.ins1001printCtrl", print1001Vo);
		
		if( insCnt == 1){
			List<SuimPrint1001VO> print_1_ctrl = sqlSession.selectList("SuimRptPrintMapper.get1001Print_1_ctrl", print1001Vo.getRptPrintNo());
			SuimPrint1001VO print_1_ctrl_delay_cnt = sqlSession.selectOne("SuimRptPrintMapper.get1001Print_1_ctrl_delay_cnt", print1001Vo.getRptPrintNo());
			//지연주체가 보험사인 경우의 지연 일수의 합.
			int insuDelayCnt = 0;
			for(int i=0; i < print_1_ctrl.size() ;i++){
				if ( print_1_ctrl.get(i).getControlDelayCnt() != null && !print_1_ctrl.get(i).getControlDelayCnt().equals("") ){
					if ( print_1_ctrl.get(i).getControlDelayAgent().equals("1") ){
						insuDelayCnt += Integer.parseInt( print_1_ctrl.get(i).getControlDelayCnt() ) ;
					}
				}
			}
			
			model.addAttribute("insuDelayCnt",insuDelayCnt);
			model.addAttribute("print_1_ctrl_delay_cnt",print_1_ctrl_delay_cnt);
			model.addAttribute("print_1_ctrl",print_1_ctrl);
			if (print1001Vo.getFlag().equals("lotte")){
				return "rpt_in/suim_rpt_bsc_print_1001_printCtrlLotte";
			}else{
				return "rpt_in/suim_rpt_bsc_print_1001_printCtrl";
			}
			
		}else{
			return "rpt_in/suim_rpt_bsc_print_1001_ajaxError"; 
		}
	}	
	

	/*
	*********************************************************
	* Program ID	: getPrintCtrlList
	* Program Name	: getPrintCtrlList
	* Description	: 단순보고서 사고처리과정표 - 처리과정 - 처리목록 생성
	* Author		: 임대성
	* Date			: 2017.03.24.
	*********************************************************
	*/
	@RequestMapping(value = "getPrintCtrlList", method = RequestMethod.POST)
	public void getPrintCtrlList(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, String rptPrintNo, String ptnrName) {
		logger.info("======= getPrintCtrlList =======");
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		
		List<SuimPrint1001VO> print_1_6_1_1001 = sqlSession.selectList("SuimRptPrintMapper.get1001Print_1_6_1", rptPrintNo);
		
//		/** 처리과정 항목 SELECT OPTION 값 세팅 **/
		Set<String> tmpStr = new HashSet<String>();//HashSet을 이용한 중복제거
		for(int i=0; i < print_1_6_1_1001.size() ; i++){
			tmpStr.add( print_1_6_1_1001.get(i).getInvestigateOutline() );
		}
		Iterator<String> iterator = tmpStr.iterator();
		List<SuimPrint1001VO> printCtrlList = new ArrayList<SuimPrint1001VO>();
		for(int i=0; i < tmpStr.size()+4 ;i++){
			SuimPrint1001VO tmpVo = new SuimPrint1001VO();
			tmpVo.setCol_cd(""+i);
			if ( i == 0 ){
				tmpVo.setCol_val("담당자");
			}else if( i == 1 ){
				tmpVo.setCol_val("피보험자");
			}else if( i == 2 ){
				tmpVo.setCol_val("계약자");
			}else if( i == 3 ){
				tmpVo.setCol_val(ptnrName);				
			}else{
				tmpVo.setCol_val(iterator.next());
			}
			printCtrlList.add(tmpVo);
		}
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("tbl_nm", "top_rpt_print_1_ctrl");
		map.put("col_nm", "control_memo");
		List<SuimPrint1001VO> ctrlMemoList = sqlSession.selectList("SuimRptPrintMapper.getCodeList",map);
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("printList", printCtrlList);
		jsonMap.put("memoList", ctrlMemoList);
		
		String strJson = new Gson().toJson(jsonMap);
		
//		System.out.println(strJson);
		
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		out.print(strJson);
		
		out.close();
	    
	}
	
	/*
	*********************************************************
	* Program ID	: del1001printCtrl
	* Program Name	: del1001printCtrl
	* Description	: 단순보고서 사고처리과정표 - 처리과정 DELETE
	* Author		: 임대성
	* Date			: 2017.03.27.
	*********************************************************
	*/
	@RequestMapping(value = "del1001printCtrl", method = RequestMethod.POST)
	public String del1001printCtrl(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= del1001printCtrl =======");
		
		int delCnt = sqlSession.delete("SuimRptPrintMapper.del1001printCtrl", print1001Vo.getSerialNo());
		
		if( delCnt == 1){
			List<SuimPrint1001VO> print_1_ctrl = sqlSession.selectList("SuimRptPrintMapper.get1001Print_1_ctrl", print1001Vo.getRptPrintNo());
			SuimPrint1001VO print_1_ctrl_delay_cnt = sqlSession.selectOne("SuimRptPrintMapper.get1001Print_1_ctrl_delay_cnt", print1001Vo.getRptPrintNo());
			//지연주체가 보험사인 경우의 지연 일수의 합.
			int insuDelayCnt = 0;
			for(int i=0; i < print_1_ctrl.size() ;i++){
				if ( print_1_ctrl.get(i).getControlDelayCnt() != null && !print_1_ctrl.get(i).getControlDelayCnt().equals("") ){
					if ( print_1_ctrl.get(i).getControlDelayAgent().equals("1") ){
						insuDelayCnt += Integer.parseInt( print_1_ctrl.get(i).getControlDelayCnt() ) ;
					}
				}
			}
			model.addAttribute("insuDelayCnt",insuDelayCnt);
			
			model.addAttribute("print_1_ctrl_delay_cnt",print_1_ctrl_delay_cnt);
			model.addAttribute("print_1_ctrl",print_1_ctrl);
			
			if (print1001Vo.getFlag().equals("lotte")){
				return "rpt_in/suim_rpt_bsc_print_1001_printCtrlLotte";
			}else{
				return "rpt_in/suim_rpt_bsc_print_1001_printCtrl";
			}
		}else{
			return "rpt_in/suim_rpt_bsc_print_1001_ajaxError"; 
		}
	}
	
	/*
	*********************************************************
	* Program ID	: udt1001printCtrl
	* Program Name	: udt1001printCtrl
	* Description	: 단순보고서 사고처리과정표 - 처리과정 UPDATE
	* Author		: 임대성
	* Date			: 2017.03.27.
	*********************************************************
	*/
	@RequestMapping(value = "udt1001printCtrl", method = RequestMethod.POST)
	public String udt1001printCtrl(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= udt1001printCtrl =======");
		
		int uptCnt = sqlSession.update("SuimRptPrintMapper.udt1001printCtrl", print1001Vo);
		
		if( uptCnt == 1){
			List<SuimPrint1001VO> print_1_ctrl = sqlSession.selectList("SuimRptPrintMapper.get1001Print_1_ctrl", print1001Vo.getRptPrintNo());
			SuimPrint1001VO print_1_ctrl_delay_cnt = sqlSession.selectOne("SuimRptPrintMapper.get1001Print_1_ctrl_delay_cnt", print1001Vo.getRptPrintNo());
			//지연주체가 보험사인 경우의 지연 일수의 합.
			System.out.println("111");
			int insuDelayCnt = 0;
			for(int i=0; i < print_1_ctrl.size() ;i++){
				if ( print_1_ctrl.get(i).getControlDelayCnt() != null && !print_1_ctrl.get(i).getControlDelayCnt().equals("") ){
					if ( print_1_ctrl.get(i).getControlDelayAgent().equals("1") ){
						insuDelayCnt += Integer.parseInt( print_1_ctrl.get(i).getControlDelayCnt() ) ;
					}
				}
			}
			System.out.println("222");
			model.addAttribute("insuDelayCnt",insuDelayCnt);
			
			model.addAttribute("print_1_ctrl_delay_cnt",print_1_ctrl_delay_cnt);
			model.addAttribute("print_1_ctrl",print_1_ctrl);
			System.out.println("33");
			if (print1001Vo.getFlag().equals("lotte")){
				System.out.println("1");
				return "rpt_in/suim_rpt_bsc_print_1001_printCtrlLotte";
			}else{
				System.out.println("2");
				return "rpt_in/suim_rpt_bsc_print_1001_printCtrl";
			}
		}else{
			return "rpt_in/suim_rpt_bsc_print_1001_ajaxError"; 
		}
	}
	
	/*
	*********************************************************
	* Program ID	: udt1001printCtrlDelay
	* Program Name	: udt1001printCtrlDelay
	* Description	: 단순보고서 사고처리과정표 - 처리과정 UPDATE
	* Author		: 임대성
	* Date			: 2017.03.27.
	*********************************************************
	*/
	@RequestMapping(value = "udt1001printCtrlDelay", method = RequestMethod.POST)
	public String udt1001printCtrlDelay(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= udt1001printCtrlDelay =======");
		
		int uptCnt = sqlSession.update("SuimRptPrintMapper.udt1001printCtrlDelay", print1001Vo);
		
		if( uptCnt == 1){
			List<SuimPrint1001VO> print_1_ctrl = sqlSession.selectList("SuimRptPrintMapper.get1001Print_1_ctrl", print1001Vo.getRptPrintNo());
			SuimPrint1001VO print_1_ctrl_delay_cnt = sqlSession.selectOne("SuimRptPrintMapper.get1001Print_1_ctrl_delay_cnt", print1001Vo.getRptPrintNo());
			//지연주체가 보험사인 경우의 지연 일수의 합.
			int insuDelayCnt = 0;
			for(int i=0; i < print_1_ctrl.size() ;i++){
				if ( print_1_ctrl.get(i).getControlDelayCnt() != null && !print_1_ctrl.get(i).getControlDelayCnt().equals("") ){
					if ( print_1_ctrl.get(i).getControlDelayAgent().equals("1") ){
						insuDelayCnt += Integer.parseInt( print_1_ctrl.get(i).getControlDelayCnt() ) ;
					}
				}
			}
			model.addAttribute("insuDelayCnt",insuDelayCnt);
			
			
			model.addAttribute("print_1_ctrl",print_1_ctrl);
			model.addAttribute("print_1_ctrl_delay_cnt",print_1_ctrl_delay_cnt);
			
			return "rpt_in/suim_rpt_bsc_print_1001_printCtrlLotte";
		}else{
			return "rpt_in/suim_rpt_bsc_print_1001_ajaxError"; 
		}
	}
	
	
	
	
	/*
	*********************************************************
	* Program ID	: ins1001sagoDoc
	* Program Name	: ins1001sagoDoc
	* Description	: 단순보고서 사고처리과정표 - 첨부서류 - INSERT
	* Author		: 임대성
	* Date			: 2017.03.28.
	*********************************************************
	*/
	@RequestMapping(value = "ins1001sagoDoc", method = RequestMethod.POST)
	public String ins1001sagoDoc(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= ins1001sagoDoc =======");
		
		int insCnt = sqlSession.insert("SuimRptPrintMapper.ins1001sagoDoc", print1001Vo);
		
		if( insCnt == 1){
			List<SuimPrint1001VO> print1_8 = sqlSession.selectList("SuimRptPrintMapper.get1001Print_1_8",print1001Vo.getRptPrintNo());
			model.addAttribute("print1_8",print1_8);
			return "rpt_in/suim_rpt_bsc_print_1001_sagoDoc";
		}else{
			return "rpt_in/suim_rpt_bsc_print_1001_ajaxError"; 
		}
	}	
	
	/*
	*********************************************************
	* Program ID	: udt1001sagoDoc
	* Program Name	: udt1001sagoDoc
	* Description	: 단순보고서 사고처리과정표 - 첨부서류 - UPDATE
	* Author		: 임대성
	* Date			: 2017.03.28.
	*********************************************************
	*/
	@RequestMapping(value = "udt1001sagoDoc", method = RequestMethod.POST)
	public String udt1001sagoDoc(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= udt1001sagoDoc =======");
		
		int udtCnt = sqlSession.update("SuimRptPrintMapper.udt1001sagoDoc", print1001Vo);
		
		if( udtCnt == 1){
			List<SuimPrint1001VO> print1_8 = sqlSession.selectList("SuimRptPrintMapper.get1001Print_1_8",print1001Vo.getRptPrintNo());
			model.addAttribute("print1_8",print1_8);
			return "rpt_in/suim_rpt_bsc_print_1001_sagoDoc";
		}else{
			return "rpt_in/suim_rpt_bsc_print_1001_ajaxError"; 
		}
	}		
	
	/*
	*********************************************************
	* Program ID	: del1001sagoDoc
	* Program Name	: del1001sagoDoc
	* Description	: 단순보고서 사고처리과정표 - 첨부서류 DELETE
	* Author		: 임대성
	* Date			: 2017.03.28.
	*********************************************************
	*/
	@RequestMapping(value = "del1001sagoDoc", method = RequestMethod.POST)
	public String del1001sagoDoc(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= del1001sagoDoc =======");
		
		int delCnt = sqlSession.delete("SuimRptPrintMapper.del1001sagoDoc", print1001Vo.getSerialNo());
		
		if( delCnt == 1){
			List<SuimPrint1001VO> print1_8 = sqlSession.selectList("SuimRptPrintMapper.get1001Print_1_8",print1001Vo.getRptPrintNo());
			model.addAttribute("print1_8",print1_8);
			return "rpt_in/suim_rpt_bsc_print_1001_sagoDoc";
		}else{
			return "rpt_in/suim_rpt_bsc_print_1001_ajaxError"; 
		}
	}
	
	/*
	*********************************************************
	* Program ID	: getSagoDocSubjectList
	* Program Name	: getSagoDocSubjectList
	* Description	: 단순보고서 사고처리과정표 - 첨부서류 - 비고목록 생성
	* Author		: 임대성
	* Date			: 2017.03.27.
	*********************************************************
	*/
	@RequestMapping(value = "getSagoDocSubjectList", method = RequestMethod.POST)
	public void getSagoDocNoteList(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, String rptPrintNo) {
		logger.info("======= getSagoDocNoteList =======");
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		
		List<SuimPrint1001VO> print_1_ctrl = sqlSession.selectList("SuimRptPrintMapper.get1001Print_1_ctrl", rptPrintNo);
//		/** 처리과정 항목 SELECT OPTION 값 세팅 **/
		Set<String> tmpStr = new HashSet<String>();//HashSet을 이용한 중복제거
		for(int i=0; i < print_1_ctrl.size() ; i++){
			tmpStr.add( print_1_ctrl.get(i).getControlSubject() );
		}
		Iterator<String> iterator = tmpStr.iterator();
		List<SuimPrint1001VO> sagoDocSubjectList = new ArrayList<SuimPrint1001VO>();
		for(int i=0; i < tmpStr.size() ;i++){
			SuimPrint1001VO tmpVo = new SuimPrint1001VO();
			tmpVo.setCol_cd(""+i);
			tmpVo.setCol_val(iterator.next());
			sagoDocSubjectList.add(tmpVo);
		}
		
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		jsonMap.put("sagoDocSubjectList", sagoDocSubjectList);
		
		String strJson = new Gson().toJson(jsonMap);
		
		System.out.println(strJson);
		
		out.print(strJson);
		
		out.close();
	    
	}
	
	/*
	*********************************************************
	* Program ID	: upt1001Flag
	* Program Name	: upt1001Flag
	* Description	: 단순보고서 화면 출력 플래그값 설정
	* Author		: 임대성
	* Date			: 2017.03.29.
	*********************************************************
	*/
	
	@RequestMapping(value = "upt1001Flag", method = RequestMethod.POST)
	public void upt1001Flag(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, int flag, String gubun, String rptPrintNo) {
		logger.info("======= upt1001Flag =======");
		HashMap<String,String> map = new HashMap<String,String>();

		map.put("gubun", gubun);
		map.put("rptPrintNo",rptPrintNo);
		map.put("flag",""+flag);
		
		if (gubun.equals("sagoDoc")){
			int UdtCnt = sqlSession.update("SuimRptPrintMapper.udt1001Flag", map);
			if (UdtCnt == 1){
				PrintWriter out = null;
				try {
					out = response.getWriter();
				} catch (IOException e) {
					e.printStackTrace();
				} 
				out.print("1");
				out.close();
			}
		}else{
			//기 입력건이 있는지 확인
			if (gubun.equals("job")){
				map.put("gubun", ""+1);
			}else if(gubun.equals("accident")){
				map.put("gubun", ""+2);
			}else if(gubun.equals("hospital")){
				map.put("gubun", ""+3);
			}else if(gubun.equals("advice")){
				map.put("gubun", ""+4);
			}else if(gubun.equals("hurdle")){   /* 2017.07.03 khs 추가 */
				map.put("gubun", "5");
			}else{
				map.put("gubun", ""+99);
			}
			
			SuimPrint1001VO insertChkVo = sqlSession.selectOne("SuimRptPrintMapper.getDetailInsertChk",map);
			
			int insCnt = 0;
			int udtCnt = 0;
			if (insertChkVo == null){
				insCnt = sqlSession.insert("SuimRptPrintMapper.ins1001DtlChkFlag", map);
			}else{
				udtCnt = sqlSession.update("SuimRptPrintMapper.udt1001DtlChkFlag", map);
			}
			
			PrintWriter out = null;
			try {
				out = response.getWriter();
			} catch (IOException e) {
				e.printStackTrace();
			} 
			
			if (insCnt == 1 || udtCnt == 1){
				out.print("1");
				out.close();
			}
		}
		
	}
	
	/*
	*********************************************************
	* Program ID	: dtlChkInsert
	* Program Name	: dtlChkInsert
	* Description	: 단순보고서 상세확인사항 - 기본 4개메뉴 
	* Author		: 임대성
	* Date			: 2017.03.29.
	*********************************************************
	*/
	@RequestMapping(value = "dtlChkInsert", method = RequestMethod.POST)
	public void dtlChkInsert(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= dtlChkInsert =======");
		
		if (print1001Vo.getDetailGubun().equals("job")){
			print1001Vo.setDetailGubun("1");
		}else if(print1001Vo.getDetailGubun().equals("accident")){
			print1001Vo.setDetailGubun("2");
		}else if(print1001Vo.getDetailGubun().equals("hospital")){
			print1001Vo.setDetailGubun("3");
		}else if(print1001Vo.getDetailGubun().equals("advice")){
			print1001Vo.setDetailGubun("4");
		}else if(print1001Vo.getDetailGubun().equals("hurdle")){    /* 2017.07.03 khs 추가*/
			print1001Vo.setDetailGubun("5");
		}else{
			print1001Vo.setDetailGubun("99");
		}
		
		int UdtCnt = sqlSession.update("SuimRptPrintMapper.udt1001DtlChk", print1001Vo);
		if (UdtCnt == 1){
			PrintWriter out = null;
			try {
				out = response.getWriter();
			} catch (IOException e) {
				e.printStackTrace();
			} 
			out.print("1");
			out.close();
		}
		
	}
	/*** BREAK POINT ***/
	
	/*
	*********************************************************
	* Program ID	: ins1001etcDtlChk
	* Program Name	: ins1001etcDtlChk
	* Description	: 상세 확인사항 - 추가메뉴 - INSERT
	* Author		: 임대성
	* Date			: 2017.04.03.
	*********************************************************
	*/
	@RequestMapping(value = "ins1001etcDtlChk", method = RequestMethod.POST)
	public String ins1001etcDtlChk(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= ins1001etcDtlChk =======");
		
		int insCnt = sqlSession.insert("SuimRptPrintMapper.ins1001etcDtlChk", print1001Vo);
		
		if( insCnt == 1){
			List<SuimPrint1001VO> print_1_detail_check = sqlSession.selectList("SuimRptPrintMapper.get1001Print_1_detail_check",print1001Vo.getRptPrintNo());
			model.addAttribute("print_1_detail",print_1_detail_check); //상세 확인사항
			return "rpt_in/suim_rpt_bsc_print_1001_etcDtlChk";
		}else{
			return "rpt_in/suim_rpt_bsc_print_1001_ajaxError"; 
		}
	}	
	
	/*
	*********************************************************
	* Program ID	: del1001etcDtlChk
	* Program Name	: del1001etcDtlChk
	* Description	: 상세 확인사항 - 추가메뉴 - DELETE
	* Author		: 임대성
	* Date			: 2017.04.03.
	*********************************************************
	*/
	@RequestMapping(value = "del1001etcDtlChk", method = RequestMethod.POST)
	public String del1001etcDtlChk(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= del1001etcDtlChk =======");
		
		int delCnt = sqlSession.delete("SuimRptPrintMapper.del1001etcDtlChk", print1001Vo.getSerialNo());
		
		if( delCnt == 1){
			List<SuimPrint1001VO> print_1_detail_check = sqlSession.selectList("SuimRptPrintMapper.get1001Print_1_detail_check",print1001Vo.getRptPrintNo());
			model.addAttribute("print_1_detail",print_1_detail_check); //상세 확인사항
			return "rpt_in/suim_rpt_bsc_print_1001_etcDtlChk";
		}else{
			return "rpt_in/suim_rpt_bsc_print_1001_ajaxError"; 
		}
	}	
	
	/*
	*********************************************************
	* Program ID	: udt1001etcDtlChk
	* Program Name	: udt1001etcDtlChk
	* Description	: 상세 확인사항 - 추가메뉴 - DELETE
	* Author		: 임대성
	* Date			: 2017.04.03.
	*********************************************************
	*/
	@RequestMapping(value = "udt1001etcDtlChk", method = RequestMethod.POST)
	public String udt1001etcDtlChk(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= udt1001etcDtlChk =======");
		
		int udtCnt = sqlSession.update("SuimRptPrintMapper.udt1001etcDtlChk", print1001Vo);
		
		if( udtCnt == 1){
			List<SuimPrint1001VO> print_1_detail_check = sqlSession.selectList("SuimRptPrintMapper.get1001Print_1_detail_check",print1001Vo.getRptPrintNo());
			model.addAttribute("print_1_detail",print_1_detail_check); //상세 확인사항
			return "rpt_in/suim_rpt_bsc_print_1001_etcDtlChk";
		}else{
			return "rpt_in/suim_rpt_bsc_print_1001_ajaxError"; 
		}
	}	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*
	*********************************************************
	* Program ID	: udtPrint1001two
	* Program Name	: udtPrint1001two
	* Description	: 단순보고서 2.조사결과(요약) update
	* Author		: 임대성
	* Date			: 2017.02.16.
	*********************************************************
	*/
	@RequestMapping(value = "udtPrint1001two", method = RequestMethod.POST)
	public void udtPrint1001two(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= udtPrint1001two =======");
		
		int UdtCnt = sqlSession.update("SuimRptPrintMapper.udt1001TwoPrint1", print1001Vo);
		if (UdtCnt == 1){
			PrintWriter out = null;
			try {
				out = response.getWriter();
			} catch (IOException e) {
				e.printStackTrace();
			} 
			out.print("1");
			out.close();
		}
	}
	
	/*
	*********************************************************
	* Program ID	: insPrint1001Three1
	* Program Name	: insPrint1001Three1
	* Description	: 단순보고서 3.조사내용 - 피보험자 병력사항 요약 경과표 Insert
	* Author		: 임대성
	* Date			: 2017.02.16.
	*********************************************************
	*/
	@RequestMapping(value = "insPrint1001Three1", method = RequestMethod.POST)
	public void insPrint1001Three1(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= insPrint1001Three1 =======");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		} 
		
		int insCnt = sqlSession.insert("SuimRptPrintMapper.insPrint1001Three1", print1001Vo);
		if (insCnt == 1){
			out.print(print1001Vo.getSerialNo());
		}else{
			out.print(0);
		}
		out.close();
	}
	
	/*
	*********************************************************
	* Program ID	: delPrint1001Three1
	* Program Name	: delPrint1001Three1
	* Description	: 단순보고서 3.조사내용 - 피보험자 병력사항 요약 경과표 Delete
	* Author		: 임대성
	* Date			: 2017.02.20.
	*********************************************************
	*/
	@RequestMapping(value = "delPrint1001Three1", method = RequestMethod.POST)
	public void delPrint1001Three1(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, String serialNo) {
		logger.info("======= delPrint1001Three1 =======");
		/** AJAX 기본 출력 **/
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		} 
		
		System.out.println("serialNo : " + serialNo);
		
		int delCnt = sqlSession.delete("SuimRptPrintMapper.delPrint1001Three1", serialNo);
		if (delCnt == 1){
			out.print("1");
			out.close();
		}
	}
	
	/*
	*********************************************************
	* Program ID	: udtPrint1001Three1
	* Program Name	: udtPrint1001Three1
	* Description	: 단순보고서 3.조사내용 - 피보험자 병력사항 요약 경과표 Update
	* Author		: 임대성
	* Date			: 2017.02.20.
	*********************************************************
	*/
	@RequestMapping(value = "udtPrint1001Three1", method = RequestMethod.POST)
	public void udtPrint1001Three1(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= udtPrint1001Three1 =======");
		/** AJAX 기본 출력 **/
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		} 
		
		int updCnt = sqlSession.update("SuimRptPrintMapper.udtPrint1001Three1", print1001Vo);
		if (updCnt == 1){
			out.print(1);
		}else{
			out.print(0);
		}
		out.close();
	}
	
	/*
	*********************************************************
	* Program ID	: insPrint1001Three2
	* Program Name	: insPrint1001Three2
	* Description	: 단순보고서 3.조사내용 - 타보험사 처리내역 Insert
	* Author		: 임대성
	* Date			: 2017.02.16.
	*********************************************************
	*/
	@RequestMapping(value = "insPrint1001Three2", method = RequestMethod.POST)
	public void insPrint1001Three2(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= insPrint1001Three2 =======");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		} 
		
		int insCnt = sqlSession.insert("SuimRptPrintMapper.insPrint1001Three2", print1001Vo);
		if (insCnt == 1){
			System.out.println(print1001Vo.getSerialNo());
			out.print(print1001Vo.getSerialNo());
		}else{
			out.print(0);
		}
		out.close();
	}
	
	
	/*
	*********************************************************
	* Program ID	: delPrint1001Three2
	* Program Name	: delPrint1001Three2
	* Description	: 단순보고서 3.조사내용 - 타보험사 처리내역  Delete
	* Author		: 임대성
	* Date			: 2017.02.20.
	*********************************************************
	*/
	@RequestMapping(value = "delPrint1001Three2", method = RequestMethod.POST)
	public void delPrint1001Three2(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, String serialNo) {
		logger.info("======= delPrint1001Three2 =======");
		/** AJAX 기본 출력 **/
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		} 
		
		int delCnt = sqlSession.delete("SuimRptPrintMapper.delPrint1001Three2", serialNo);
		if (delCnt == 1){
			out.print("1");
			out.close();
		}
	}
	
	/*
	*********************************************************
	* Program ID	: udtPrint1002Three2
	* Program Name	: udtPrint1002Three2
	* Description	: 단순보고서 3.조사내용 - 타보험사 처리내역 Update
	* Author		: 임대성
	* Date			: 2017.02.20.
	*********************************************************
	*/
	@RequestMapping(value = "udtPrint1001Three2", method = RequestMethod.POST)
	public void udtPrint1002Three2(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= udtPrint1001Three2 =======");
		/** AJAX 기본 출력 **/
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		} 
		
		int updCnt = sqlSession.update("SuimRptPrintMapper.udtPrint1001Three2", print1001Vo);
		if (updCnt == 1){
			out.print(1);
		}else{
			out.print(0);
		}
		out.close();
	}
	
	/*
	*********************************************************
	* Program ID	: udtPrint1001four
	* Program Name	: udtPrint1001four
	* Description	: 단순보고서 4.탐문 내역
	* Author		: 임대성
	* Date			: 2017.02.21.
	*********************************************************
	*/
	@RequestMapping(value = "udtPrint1001four", method = RequestMethod.POST)
	public void udtPrint1001four(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= udtPrint1001four =======");
		
		int udtCnt = sqlSession.update("SuimRptPrintMapper.udt1001four", print1001Vo);
		if (udtCnt == 1){
			PrintWriter out = null;
			try {
				out = response.getWriter();
			} catch (IOException e) {
				e.printStackTrace();
			} 
			out.print("1");
			out.close();
		}
	}
	
	/*
	*********************************************************
	* Program ID	: insPrint1001SagoDoc
	* Program Name	: insPrint1001SagoDoc
	* Description	: 단순보고서 사고처리과정표 - 첨부서류 Insert
	* Author		: 임대성
	* Date			: 2017.02.22.
	*********************************************************
	*/
	@RequestMapping(value = "insPrint1001SagoDoc", method = RequestMethod.POST)
	public void insPrint1001SagoDoc(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= insPrint1001SagoDoc =======");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		} 
		
		int insCnt = sqlSession.insert("SuimRptPrintMapper.insPrint1001SagoDoc", print1001Vo);
		if (insCnt == 1){
			System.out.println(print1001Vo.getSerialNo());
			out.print(print1001Vo.getSerialNo());
		}else{
			out.print(0);
		}
		out.close();
	}
	
	/*
	*********************************************************
	* Program ID	: udtPrint1001SagoDoc
	* Program Name	: udtPrint1001SagoDoc
	* Description	: 단순보고서 사고처리과정표 - 첨부서류 Update
	* Author		: 임대성
	* Date			: 2017.02.22.
	*********************************************************
	*/
	@RequestMapping(value = "udtPrint1001SagoDoc", method = RequestMethod.POST)
	public void udtPrint1001SagoDoc(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, SuimPrint1001VO print1001Vo) {
		logger.info("======= udtPrint1001SagoDoc =======");
		/** AJAX 기본 출력 **/
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		} 
		
		int updCnt = sqlSession.update("SuimRptPrintMapper.udtPrint1001SagoDoc", print1001Vo);
		if (updCnt == 1){
			out.print(1);
		}else{
			out.print(0);
		}
		out.close();
	}
	
	/*
	*********************************************************
	* Program ID	: delPrint1001SagoDoc
	* Program Name	: delPrint1001SagoDoc
	* Description	: 단순보고서 사고처리과정표 - 첨부서류 Update
	* Author		: 임대성
	* Date			: 2017.02.22.
	*********************************************************
	*/
	@RequestMapping(value = "delPrint1001SagoDoc", method = RequestMethod.POST)
	public void delPrint1001SagoDoc(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, String serialNo) {
		logger.info("======= delPrint1001SagoDoc =======");
		/** AJAX 기본 출력 **/
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		} 
		
		int delCnt = sqlSession.delete("SuimRptPrintMapper.delPrint1001SagoDoc", serialNo);
		System.out.println(delCnt);
		if (delCnt == 1){
			out.print("1");
			out.close();
		}
	}	
	
}
