/*
*********************************************************
* Program ID	: PrimbizSuimListController
* Program Name	: PrimbizSuimListController
* Description	: 농작물 수임대장 리스트
* Author		: 
* Date			: 2016.06.09.
*********************************************************
*/
package kr.co.toplac.topsuit12;

import java.io.File;
import java.io.FileInputStream;
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

import javax.servlet.ServletOutputStream;
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

import kr.co.toplac.sysadm.SysAdmCodeDicVO;
import kr.co.toplac.topprimbiz.TopPrimBizRptCompositeVO;
import kr.co.toplac.topprimbizinv.TopPrimBizInvCompositeVO;
import kr.co.toplac.topsuit12.SuimSuit_12VO;
import kr.co.toplac.topsuit17.SuimSuit17OrgFileVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.etc.Damo;

@Controller
public class SuimSuit12DtlController {

	private static final Logger logger = LoggerFactory.getLogger(SuimSuit12DtlController.class);

	@Autowired
	private SqlSession sqlSession;

	/*
	*********************************************************
	* Program ID	: suimSuit12List
	* Program Name	: suimSuit12List
	* Description	: 적부(흥국) 리스트 
	* Author		: 
	* Date			: 2016.09.01.
	*********************************************************
	*/
	@RequestMapping(value = "topSuimSuit12Dtl", method = RequestMethod.GET)
	public String topSuimSuit12Dtl(Model model, HttpSession session, String reqPgNo, SuimSuit_12VO dtlVO, String suimRptNo) {

		logger.info("======= topSuimSuit12Dtl =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("topSuimSuitDtl12 - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		/*로그인 유저의 세션 정보 추출 시작*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		//model.addAttribute("mbrAuthSessionVo", mbrAuthVo);
		model.addAttribute("mbrVo",mbrVo);
		/*로그인 유저의 세션 정보 추출 끝*/
		
		model.addAttribute("suimRptNo",suimRptNo);
		
		/*보고서 기본정보 추출*/
		dtlVO.setUser_no_session(mbrVo.getUser_no());
		SuimSuit_12VO getSuimSuit12DtlBsc = sqlSession.selectOne("SuimSuit12DtlMapper.getSuimSuit12DtlBsc", dtlVO);
		Damo damo = new Damo();
		if( getSuimSuit12DtlBsc.getPolicyholderHp() != null || getSuimSuit12DtlBsc.getPolicyholderHp() != ""){
			getSuimSuit12DtlBsc.setPolicyholderHp( damo.decodeDamo(getSuimSuit12DtlBsc.getPolicyholderHp()));
		}
		if( getSuimSuit12DtlBsc.getRqCrtHndphTlNo() != null || getSuimSuit12DtlBsc.getRqCrtHndphTlNo() != ""){
			getSuimSuit12DtlBsc.setRqCrtHndphTlNo( damo.decodeDamo(getSuimSuit12DtlBsc.getRqCrtHndphTlNo()));
		}
		if( getSuimSuit12DtlBsc.getRqCrtHomeTlNo() != null || getSuimSuit12DtlBsc.getRqCrtHomeTlNo() != ""){
			getSuimSuit12DtlBsc.setRqCrtHomeTlNo( damo.decodeDamo(getSuimSuit12DtlBsc.getRqCrtHomeTlNo()));
		}
		if( getSuimSuit12DtlBsc.getRqCrtWpcTlNo() != null || getSuimSuit12DtlBsc.getRqCrtWpcTlNo() != ""){
			getSuimSuit12DtlBsc.setRqCrtWpcTlNo( damo.decodeDamo(getSuimSuit12DtlBsc.getRqCrtWpcTlNo()));
		}
		
		//보험계약자 핸드폰 추가 by top3009 20220711
		if( getSuimSuit12DtlBsc.getPrHndphTlno() != null || getSuimSuit12DtlBsc.getPrHndphTlno() != ""){
			getSuimSuit12DtlBsc.setPrHndphTlno( damo.decodeDamo(getSuimSuit12DtlBsc.getPrHndphTlno()));
		}
		
		model.addAttribute("getSuimSuit12DtlBsc", getSuimSuit12DtlBsc);

		TopMbrBscVO mbrVoForBody = sqlSession.selectOne("SuimRptBodyMapper.mbrinfo", getSuimSuit12DtlBsc.getUserNo());
		model.addAttribute("mbrVoForBody", mbrVoForBody);
		
		/*건물정보 추출*/
		List<SuimSuit_12VO> getSuimSuit12DtlBld = sqlSession.selectList("SuimSuit12DtlMapper.getSuimSuit12DtlBld", dtlVO);
		model.addAttribute("getSuimSuit12DtlBld", getSuimSuit12DtlBld);
		
		/*목적물정보 추출*/
		List<SuimSuit_12VO> getSuimSuit12DtlOj = sqlSession.selectList("SuimSuit12DtlMapper.getSuimSuit12DtlOj", dtlVO);
		model.addAttribute("getSuimSuit12DtlOj", getSuimSuit12DtlOj);
		
		return "top_suim_suit12/top_suim_suit12_dtl";
	}//primbizSuimList
	
	@RequestMapping(value = "suimSuit12DtlUdt", method = RequestMethod.POST)
	public String suimSuit12DtlUdt(Model model, HttpSession session, String reqPgNo, SuimSuit_12VO dtlVO, String suimRptNo) {

		logger.info("======= suimSuit12DtlUdt =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("suimSuit12DtlUdt - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		/*로그인 유저의 세션 정보 추출 시작*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		model.addAttribute("mbrAuthSessionVo", mbrAuthVo);
		model.addAttribute("mbrVo",mbrVo);
		/*로그인 유저의 세션 정보 추출 끝*/
		
		model.addAttribute("suimRptNo",suimRptNo);
		/*보고서 기본정보 추출*/
		
		dtlVO.setUser_no_session(mbrVo.getUser_no());
		SuimSuit_12VO getSuimSuit12DtlBsc = sqlSession.selectOne("SuimSuit12DtlMapper.getSuimSuit12DtlBsc", dtlVO);
		model.addAttribute("getSuimSuit12DtlBsc", getSuimSuit12DtlBsc);

		TopMbrBscVO mbrVoForBody = sqlSession.selectOne("SuimRptBodyMapper.mbrinfo", getSuimSuit12DtlBsc.getUserNo());
		model.addAttribute("mbrVoForBody", mbrVoForBody);
		
		/*건물정보 추출*/
		List<SuimSuit_12VO> getSuimSuit12DtlBld = sqlSession.selectList("SuimSuit12DtlMapper.getSuimSuit12DtlBld", dtlVO);
		model.addAttribute("getSuimSuit12DtlBldList", getSuimSuit12DtlBld);
		
		/*목적물정보 추출*/
		List<SuimSuit_12VO> getSuimSuit12DtlOj = sqlSession.selectList("SuimSuit12DtlMapper.getSuimSuit12DtlOj", dtlVO);
		model.addAttribute("getSuimSuit12DtlOjList", getSuimSuit12DtlOj);
		return "top_suim_suit12/top_suim_suit12_dtl_udt";
	}//suimSuit12DtlUdt
	
	//조사 수정하기
	@RequestMapping(value = "suimSuit12DtlUdtOK", method = RequestMethod.POST)
	public void suimSuit12DtlUdtOK(Model model, HttpSession session, HttpServletResponse response
			, String reqPgNo, SuimSuit_12VO dtlVO, SuimSuit12BldObjViewVO bldVO, SuimSuit12OjObjViewVO ojVO, String suimRptNo) {

		logger.info("======= suimSuit12DtlUdtOK =======");
		
		/*로그인 유저의 세션 정보 추출 시작*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		model.addAttribute("mbrAuthSessionVo", mbrAuthVo);
		/*로그인 유저의 세션 정보 추출 끝*/

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		int udtSuimSuit12Dtl = 0;
		int udtSuimSuit12Bld = 0;
		int udtSuimSuit12Oj = 0;
		
		udtSuimSuit12Dtl = sqlSession.update("SuimSuit12DtlMapper.udtSuimSuit12Dtl", dtlVO);
		
		
		SuimSuit12BldVO tmpBldVO = new SuimSuit12BldVO();
		for(int i=0; i < bldVO.getSerialNoBldArr().length; i++){
			tmpBldVO.setSerialNoBld(bldVO.getSerialNoBldArr()[i]);
			tmpBldVO.setRstBld_RcnDt(bldVO.getRstBld_RcnDt()[i]);
			tmpBldVO.setRstBld_InvpsNm(bldVO.getRstBld_InvpsNm()[i]);       
			tmpBldVO.setRstBld_CrRelpcRel(bldVO.getRstBld_CrRelpcRel()[i]);    
			tmpBldVO.setRstBld_InvpsCntAd(bldVO.getRstBld_InvpsCntAd()[i]);    
			tmpBldVO.setRstBld_RlOwrNm(bldVO.getRstBld_RlOwrNm()[i]);       
			tmpBldVO.setRstBld_CtnAdr(bldVO.getRstBld_CtnAdr()[i]);        
			tmpBldVO.setRstBld_MngmBnNm(bldVO.getRstBld_MngmBnNm()[i]);      
			tmpBldVO.setRstBld_BldRnkCd(bldVO.getRstBld_BldRnkCd()[i]);      
			tmpBldVO.setRstBld_GrodEqalYn(bldVO.getRstBld_GrodEqalYn()[i]);    
			tmpBldVO.setRstBld_UndgEqalYn(bldVO.getRstBld_UndgEqalYn()[i]);    
			tmpBldVO.setRstBld_TtareEqalYn(bldVO.getRstBld_TtareEqalYn()[i]);   
			tmpBldVO.setRstBld_IsAreEqalYn(bldVO.getRstBld_IsAreEqalYn()[i]);   
			tmpBldVO.setRstBld_IsTpEqalYn(bldVO.getRstBld_IsTpEqalYn()[i]);    
			tmpBldVO.setRstBld_RlOwrNmEtMtt(bldVO.getRstBld_RlOwrNmEtMtt()[i]);  
			tmpBldVO.setRstBld_CtnAdrEtMtt(bldVO.getRstBld_CtnAdrEtMtt()[i]);   
			tmpBldVO.setRstBld_MngmBnnmEtMtt(bldVO.getRstBld_MngmBnnmEtMtt()[i]); 
			tmpBldVO.setRstBld_BldRnkcdEtMtt(bldVO.getRstBld_BldRnkcdEtMtt()[i]); 
			tmpBldVO.setRstBld_GrodEtMtt(bldVO.getRstBld_GrodEtMtt()[i]);     
			tmpBldVO.setRstBld_UndgEtMtt(bldVO.getRstBld_UndgEtMtt()[i]);     
			tmpBldVO.setRstBld_TtareEtMtt(bldVO.getRstBld_TtareEtMtt()[i]);    
			tmpBldVO.setRstBld_IsAreEtMtt(bldVO.getRstBld_IsAreEtMtt()[i]);    
			tmpBldVO.setRstBld_IsTpEtMtt(bldVO.getRstBld_IsTpEtMtt()[i]);     
			tmpBldVO.setRstBld_PleNm(bldVO.getRstBld_PleNm()[i]);         
			tmpBldVO.setRstBld_RofNm(bldVO.getRstBld_RofNm()[i]);         
			tmpBldVO.setRstBld_WllNm(bldVO.getRstBld_WllNm()[i]);         
			tmpBldVO.setRstBld_PanlYn(bldVO.getRstBld_PanlYn()[i]);        
			tmpBldVO.setRstBld_PanlPst(bldVO.getRstBld_PanlPst()[i]);       
			tmpBldVO.setRstBld_TntYn(bldVO.getRstBld_TntYn()[i]);         
			tmpBldVO.setRstBld_TntPst(bldVO.getRstBld_TntPst()[i]);        
			tmpBldVO.setRstBld_FlrFirZoneYn(bldVO.getRstBld_FlrFirZoneYn()[i]);  
			tmpBldVO.setRstBld_EtMtt1(bldVO.getRstBld_EtMtt1()[i]);        
			tmpBldVO.setRstBld_FlrBtpUndg(bldVO.getRstBld_FlrBtpUndg()[i]);    
			tmpBldVO.setRstBld_FlrBtpFloor1(bldVO.getRstBld_FlrBtpFloor1()[i]);  
			tmpBldVO.setRstBld_FlrBtpFloor2(bldVO.getRstBld_FlrBtpFloor2()[i]);  
			tmpBldVO.setRstBld_FlrBtpFloor3(bldVO.getRstBld_FlrBtpFloor3()[i]);  
			tmpBldVO.setRstBld_SlEqmtDcYn(bldVO.getRstBld_SlEqmtDcYn()[i]);    
			tmpBldVO.setRstBld_MrkYn(bldVO.getRstBld_MrkYn()[i]);         
			tmpBldVO.setRstBld_EtMtt2(bldVO.getRstBld_EtMtt2()[i]);
			udtSuimSuit12Bld = sqlSession.update("SuimSuit12DtlMapper.udtSuimSuit12Bld", tmpBldVO);
		}

		SuimSuit12OjVO tmpOJVO = new SuimSuit12OjVO();
		for(int i=0; i < ojVO.getSerialNoOjArr().length; i++){
			tmpOJVO.setSerialNoOj(ojVO.getSerialNoOjArr()[i]);
			tmpOJVO.setRstOj_OjTpEqalYn(ojVO.getRstOj_OjTpEqalYn()[i]);
			tmpOJVO.setRstOj_RnkEqalYn(ojVO.getRstOj_RnkEqalYn()[i]);
			tmpOJVO.setRstOj_Dt_MttEqalYn(ojVO.getRstOj_Dt_MttEqalYn()[i]);
			tmpOJVO.setRstOj_Dt_AccptPlcEqalYn(ojVO.getRstOj_Dt_AccptPlcEqalYn()[i]);
			tmpOJVO.setRstOj_AccptPlcFlgcdEqalYn(ojVO.getRstOj_AccptPlcFlgcdEqalYn()[i]);
			tmpOJVO.setRstOj_FldstObjFlgcdEqalYn(ojVO.getRstOj_FldstObjFlgcdEqalYn()[i]);
			tmpOJVO.setRstOj_UndgAccptYnEqalYn(ojVO.getRstOj_UndgAccptYnEqalYn()[i]);
			tmpOJVO.setRstOj_EtMtt(ojVO.getRstOj_EtMtt()[i]);
			
			udtSuimSuit12Oj = sqlSession.update("SuimSuit12DtlMapper.udtSuimSuit12Oj", tmpOJVO);
		}
		
		
		int result = 0;
		if((udtSuimSuit12Dtl >0) && (udtSuimSuit12Bld > 0) && (udtSuimSuit12Oj > 0)){
			
			result = 1;
			
		}
		
		out.print(result);
	}//suimSuit12DtlUdtOK
	
	@RequestMapping(value = "suimSuit12DtlRptUdt", method = RequestMethod.POST)
	public String suimSuit12DtlRptUdt(Model model, HttpSession session, String reqPgNo, SuimSuit_12VO dtlVO, String suimRptNo) {

		logger.info("======= suimSuit12DtlRptUdt =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("suimSuit12DtlRptUdt - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		/*로그인 유저의 세션 정보 추출 시작*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		model.addAttribute("mbrAuthSessionVo", mbrAuthVo);
		model.addAttribute("mbrVo",mbrVo);
		/*로그인 유저의 세션 정보 추출 끝*/
		
		model.addAttribute("suimRptNo",suimRptNo);
		
		
		/*면담자(관계) 리스트 추출*/
		List<SysAdmCodeDicVO> b2CodeList = sqlSession.selectList("SuimSuit12DtlMapper.b2CodeList");
		model.addAttribute("b2CodeList", b2CodeList);
		
		/*보고서 기본정보 추출*/
		dtlVO.setUser_no_session(mbrVo.getUser_no());
		SuimSuit_12VO getSuimSuit12DtlBsc = sqlSession.selectOne("SuimSuit12DtlMapper.getSuimSuit12DtlBsc", dtlVO);
		model.addAttribute("getSuimSuit12DtlBsc", getSuimSuit12DtlBsc);

		TopMbrBscVO mbrVoForBody = sqlSession.selectOne("SuimRptBodyMapper.mbrinfo", getSuimSuit12DtlBsc.getUserNo());
		model.addAttribute("mbrVoForBody", mbrVoForBody);
		
		/*건물정보 추출*/
		List<SuimSuit_12VO> getSuimSuit12DtlBld = sqlSession.selectList("SuimSuit12DtlMapper.getSuimSuit12DtlBld", dtlVO);
		model.addAttribute("getSuimSuit12DtlBldList", getSuimSuit12DtlBld);
		
		/*목적물정보 추출*/
		List<SuimSuit_12VO> getSuimSuit12DtlOj = sqlSession.selectList("SuimSuit12DtlMapper.getSuimSuit12DtlOj", dtlVO);
		model.addAttribute("getSuimSuit12DtlOjList", getSuimSuit12DtlOj);
		
		/*보고서 원본 파일 정보 추출 시작*/
		List<SuimSuit17OrgFileVO> suimSuit12FileList  = sqlSession.selectList("SuimSuit12DtlMapper.suimSuit12FileList", suimRptNo);
		model.addAttribute("suimSuit12FileList", suimSuit12FileList);
		model.addAttribute("fileListSize", suimSuit12FileList.size());
		
		/*보고서 원본 파일 정보 추출 끝*/
		
		return "top_suim_suit12/top_suim_suit12_dtl_rpt_udt";
	}//suimSuit12DtlRptUdt
	
	@RequestMapping(value = "suimSuit12DtlRptUdtOK", method = RequestMethod.POST)
	public void suimSuit12DtlRptUdtOK(Model model, HttpSession session, HttpServletResponse response, String reqPgNo, SuimSuit_12VO dtlVO, String suimRptNo) {

		logger.info("======= suimSuit12DtlRptUdtOK =======");
		
		/*로그인 유저의 세션 정보 추출 시작*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		model.addAttribute("mbrAuthSessionVo", mbrAuthVo);
		/*로그인 유저의 세션 정보 추출 끝*/

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		int udtSuimSiut12DtlRpt = 0;
		udtSuimSiut12DtlRpt = sqlSession.update("SuimSuit12DtlMapper.udtSuimSiut12DtlRpt", dtlVO);
		
		int result = 0;
		if(udtSuimSiut12DtlRpt >0){
			
			result = 1;
			
		}
		
		out.print(result);
	}//suimSuit12DtlUdtOK
	
	@RequestMapping(value = "suit12ImgDelOk", method = RequestMethod.POST)
	public void suit12ImgDelOk(Model model, HttpSession session, HttpServletResponse response, String serialNo, PrintWriter out) {
		logger.info("suit12ImgDelOk");
		
		/*로그인 유저의 세션 정보 추출 시작*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		model.addAttribute("mbrAuthSessionVo", mbrAuthVo);
		/*로그인 유저의 세션 정보 추출 끝*/
		
		int result = 0;		
		String path = "/home/hosting_users/toplac/www"+sqlSession.selectOne("SuimSuit12DtlMapper.getSuimSuit12RptFilePathForDel", serialNo);
		String fileforder = path.substring(0, path.lastIndexOf("/"));
		
		//파일 삭제 시작
		if(!fileforder.equals("")){
			
			File file = new File(path);
			File dir = new File(fileforder);
			file.delete();
			dir.delete();
			
			result = 1;
		}
		//파일 삭제 종료
		
		sqlSession.selectOne("SuimSuit12DtlMapper.delSuimSuit12RptFile", serialNo);
		
		out.print(result);
	}
	
	@RequestMapping(value = "suimSuit12RptWordDown", method = RequestMethod.GET)
	public String interimPrintPage(Model model, HttpServletResponse response, HttpSession session, String suimRptNo, String interimFlag, String rptSiteNo, String type, SuimSuit_12VO dtlVO) {
		
		logger.info("suimSuit12RptWordDown");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("suimSuit12DtlRptUdt - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		/*로그인 유저의 세션 정보 추출 시작*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		model.addAttribute("mbrAuthSessionVo", mbrAuthVo);
		model.addAttribute("mbrVo",mbrVo);
		/*로그인 유저의 세션 정보 추출 끝*/
		
		model.addAttribute("suimRptNo",suimRptNo);
		
		/* 보고서 정보 추출*/
		SuimSuit_12VO getSuimSuit12DtlBsc = sqlSession.selectOne("SuimSuit12DtlMapper.getSuimSuit12DtlBsc", dtlVO);
		
		//날짜 워드전환일
		DateFormat sd1 = new SimpleDateFormat("yyyy.MM.dd");
		Date today = null;
		today = new Date();//오늘날자구하기
		String wordDate = sd1.format(today);//String형으로 변환
		model.addAttribute("wordDate", wordDate);
		
		//계약일 및 위임일 날짜 포멧변경
		DateFormat sdBef = new SimpleDateFormat("yyyyMMdd");
		DateFormat sdAft = new SimpleDateFormat("yyyy.MM.dd");
		String rqCnrDt =""; //계약일
		String rqPptyRqDt =""; //위임일
		
		try {
			Date tmpdate = sdBef.parse(getSuimSuit12DtlBsc.getRqCnrDt());
			rqCnrDt = sdAft.format(tmpdate);
			tmpdate = sdBef.parse(getSuimSuit12DtlBsc.getRqPptyRqDt());
			rqPptyRqDt = sdAft.format(tmpdate);
			
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		getSuimSuit12DtlBsc.setRqCnrDt(rqCnrDt);
		getSuimSuit12DtlBsc.setRqPptyRqDt(rqPptyRqDt);
		
		model.addAttribute("getSuimSuit12DtlBsc", getSuimSuit12DtlBsc);			
		
		/*보고서 원본 파일 정보 추출 시작*/
		List<SuimSuit12OrgFileVO> suimSuit12FileList  = sqlSession.selectList("SuimSuit12DtlMapper.suimSuit12FileList", suimRptNo);
		model.addAttribute("suimSuit12FileList", suimSuit12FileList);
		
		/*건물정보 추출*/
		List<SuimSuit_12VO> getSuimSuit12DtlBld = sqlSession.selectList("SuimSuit12DtlMapper.getSuimSuit12DtlBld", dtlVO);
		model.addAttribute("getSuimSuit12DtlBldList", getSuimSuit12DtlBld);
		
		/*목적물정보 추출*/
		List<SuimSuit_12VO> getSuimSuit12DtlOj = sqlSession.selectList("SuimSuit12DtlMapper.getSuimSuit12DtlOj", dtlVO);
		model.addAttribute("getSuimSuit12DtlOjList", getSuimSuit12DtlOj);
		
		/*** 첨부파일 이미지 ***/
//		List<SuimSuit_12VO> getSuimSuit12File = sqlSession.selectList("SuimSuit12DtlMapper.getSuimSuit12File", suimRptNo);
		
		
		/*Print 공통 정보 추출 시작*/
		TopTmBscVO topTmBscVo = sqlSession.selectOne("SuimRptBodyMapper.topTmInfoForBody", getSuimSuit12DtlBsc.getTeamId());
		TopMbrBscVO mbrVoForBody = sqlSession.selectOne("SuimRptBodyMapper.mbrinfo", getSuimSuit12DtlBsc.getUserNo());
		
		
		model.addAttribute("topTmBscVo", topTmBscVo);
		model.addAttribute("mbrVoForBody", mbrVoForBody);
		
		String filename = getSuimSuit12DtlBsc.getRqPlNo()+"_"+getSuimSuit12DtlBsc.getRqRequSeqNo().trim();
		try {
			filename = java.net.URLEncoder.encode(filename,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		response.setHeader("Content-Disposition", "attachment;filename="+filename+".doc");
		response.setHeader("Content-Description", "JSP Generated Data");
	    //response.setContentType("application/vnd.ms-word");
		return "top_suim_suit12/top_suim_suit12_dtl_word";				
		
	}
	
	@RequestMapping(value = "suimSuit12DtlView", method = RequestMethod.GET)
	public String suimSuit12DtlView(Model model, HttpServletResponse response, HttpSession session, String suimRptNo, SuimSuit_12VO dtlVO) {
		
		logger.info("suimSuit12DtlView");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("suimSuit12DtlViewInfoAc - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		/*로그인 유저의 세션 정보 추출 시작*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		model.addAttribute("mbrAuthSessionVo", mbrAuthVo);
		model.addAttribute("mbrVo",mbrVo);
		/*로그인 유저의 세션 정보 추출 끝*/
		
		model.addAttribute("suimRptNo",suimRptNo);
		model.addAttribute("data", dtlVO.getData());
		
		/* 보고서 정보 추출*/
		SuimSuit_12VO getSuimSuit12DtlView = sqlSession.selectOne("SuimSuit12DtlMapper.getSuimSuit12DtlView", dtlVO);
		model.addAttribute("getSuimSuit12DtlView", getSuimSuit12DtlView);			
		
		return "top_suim_suit12/top_suim_suit12_dtl_view";				
		
	}
	
	/* 적부(한화) 보고서 파일 다운로드 */
	@RequestMapping(value = "suimSuit12RptFileDownload", method = RequestMethod.GET)
	 public void suimSuit12RptFileDownload(String key,String type, String suimRptNo, HttpServletResponse response)
			 throws IOException{
		
		logger.info("suimSuit12RptFileDownload");
		
		String filePath = "";
		String fileName = "";
		
		if(type.equals("rptOrigin")){
			filePath = "/home/hosting_users/toplac/www"+sqlSession.selectOne("SuimSuit12DtlMapper.getSuimSuit12RptFileNameForDown", key);
			fileName = filePath.substring(filePath.lastIndexOf("/")+1);
		}
		
		String tmpFName = "";
		
		try {
			tmpFName = java.net.URLEncoder.encode(fileName,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		response.setHeader("Content-Disposition","attachment;filename="+tmpFName);


		ServletOutputStream sout = response.getOutputStream();
		FileInputStream fin = new FileInputStream(filePath);
		
		byte[] buf = new byte[1024];
		int size=0;
		while((size=fin.read(buf,0,1024))!=-1){
			sout.write(buf,0,size);
		}
		sout.flush();
		fin.close();
		sout.close();
	}
	
}//end of class
