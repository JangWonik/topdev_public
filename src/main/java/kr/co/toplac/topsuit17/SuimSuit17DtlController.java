/*
*********************************************************
* Program ID	: PrimbizSuimListController
* Program Name	: PrimbizSuimListController
* Description	: 농작물 수임대장 리스트
* Author		: 
* Date			: 2016.06.09.
*********************************************************
*/
package kr.co.toplac.topsuit17;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
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
import kr.co.toplac.topsuit17.SuimSuit_17VO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.etc.Damo;

@Controller
public class SuimSuit17DtlController {

	private static final Logger logger = LoggerFactory.getLogger(SuimSuit17DtlController.class);

	@Autowired
	private SqlSession sqlSession;

	/*
	*********************************************************
	* Program ID	: suimSuit17List
	* Program Name	: suimSuit17List
	* Description	: 적부(흥국) 리스트
	* Author		: 
	* Date			: 2016.09.01.
	*********************************************************
	*/
	@RequestMapping(value = "topSuimSuit17Dtl", method = RequestMethod.GET)
	public String topSuimSuit17Dtl(Model model, HttpSession session, String reqPgNo, SuimSuit_17VO dtlVO, String suimRptNo) {

		logger.info("======= topSuimSuit17Dtl =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("topSuimSuitDtl17 - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		/*로그인 유저의 세션 정보 추출 시작*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		//model.addAttribute("mbrAuthSessionVo", mbrAuthVo);
		model.addAttribute("mbrVo",mbrVo);
		/*로그인 유저의 세션 정보 추출 끝*/
		
		model.addAttribute("suimRptNo",suimRptNo);
		
		dtlVO.setUser_no_session(mbrVo.getUser_no());
		SuimSuit_17VO getSuimSuit17DtlBsc = sqlSession.selectOne("SuimSuit17DtlMapper.getSuimSuit17DtlBsc", dtlVO);
		/**디아모 복호화**/
 		Damo damo = new Damo();
		//계약자 자택 전화번호
		if( getSuimSuit17DtlBsc.getPolicyholderTel1() != null && !getSuimSuit17DtlBsc.getPolicyholderTel1().equals("") ){
			getSuimSuit17DtlBsc.setPolicyholderTel1(damo.decodeDamo(getSuimSuit17DtlBsc.getPolicyholderTel1()));
		}
		//계약자 휴대폰
		if( getSuimSuit17DtlBsc.getPolicyholderHp() != null && !getSuimSuit17DtlBsc.getPolicyholderHp().equals("") ){
			getSuimSuit17DtlBsc.setPolicyholderHp(damo.decodeDamo(getSuimSuit17DtlBsc.getPolicyholderHp()));
		}
		
		TopMbrBscVO mbrVoForBody = sqlSession.selectOne("SuimRptBodyMapper.mbrinfo", getSuimSuit17DtlBsc.getUserNo());
		
		model.addAttribute("getSuimSuit17DtlBsc", getSuimSuit17DtlBsc);
		model.addAttribute("mbrVoForBody", mbrVoForBody);
		
		return "top_suim_suit17/top_suim_suit17_dtl";
	}//primbizSuimList
	
	@RequestMapping(value = "suimSuit17DtlUdt", method = RequestMethod.POST)
	public String suimSuit17DtlUdt(Model model, HttpSession session, String reqPgNo, SuimSuit_17VO dtlVO, String suimRptNo) {

		logger.info("======= suimSuit17DtlUdt =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("suimSuit17DtlUdt - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		/*로그인 유저의 세션 정보 추출 시작*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		model.addAttribute("mbrAuthSessionVo", mbrAuthVo);
		model.addAttribute("mbrVo",mbrVo);
		/*로그인 유저의 세션 정보 추출 끝*/
		
		model.addAttribute("suimRptNo",suimRptNo);
		dtlVO.setUser_no_session((String) session.getAttribute("user_no_Session"));
		SuimSuit_17VO getSuimSuit17DtlBsc = sqlSession.selectOne("SuimSuit17DtlMapper.getSuimSuit17DtlBsc", dtlVO);
		
		TopMbrBscVO mbrVoForBody = sqlSession.selectOne("SuimRptBodyMapper.mbrinfo", getSuimSuit17DtlBsc.getUserNo());
		
		model.addAttribute("mbrVoForBody", mbrVoForBody);
		model.addAttribute("getSuimSuit17DtlBsc", getSuimSuit17DtlBsc);
		return "top_suim_suit17/top_suim_suit17_dtl_udt";
	}//suimSuit17DtlUdt
	
	//조사 수정하기
	@RequestMapping(value = "suimSuit17DtlUdtOK", method = RequestMethod.POST)
	public void suimSuit17DtlUdtOK(Model model, HttpSession session, HttpServletResponse response, String reqPgNo, SuimSuit_17VO dtlVO, String suimRptNo) {

		logger.info("======= suimSuit17DtlUdtOK =======");
		
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

		int udtSuimSiut17Dtl = 0;
		udtSuimSiut17Dtl = sqlSession.update("SuimSuit17DtlMapper.udtSuimSiut17Dtl", dtlVO);
		
		int result = 0;
		if(udtSuimSiut17Dtl >0){
			result = 1;
		}
		out.print(result);
	}//suimSuit17DtlUdtOK
	
	@RequestMapping(value = "suimSuit17DtlRptUdt", method = RequestMethod.POST)
	public String suimSuit17DtlRptUdt(Model model, HttpSession session, String reqPgNo, SuimSuit_17VO dtlVO, String suimRptNo) {

		logger.info("======= suimSuit17DtlRptUdt =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("suimSuit17DtlRptUdt - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		/*로그인 유저의 세션 정보 추출 시작*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		model.addAttribute("mbrAuthSessionVo", mbrAuthVo);
		model.addAttribute("mbrVo",mbrVo);
		/*로그인 유저의 세션 정보 추출 끝*/
		
		model.addAttribute("suimRptNo",suimRptNo);
		
		/*보고서 작성 정보 추출*/
		dtlVO.setUser_no_session((String) session.getAttribute("user_no_Session"));
		SuimSuit_17VO getSuimSuit17DtlBsc = sqlSession.selectOne("SuimSuit17DtlMapper.getSuimSuit17DtlBsc", dtlVO);
		model.addAttribute("getSuimSuit17DtlBsc", getSuimSuit17DtlBsc);
		
		/** 디아모 소재지 기타주소 복호화 **/
		Damo damo = new Damo();
		System.out.println("암호화전 : "+ getSuimSuit17DtlBsc.getInfoAc());
		if ( getSuimSuit17DtlBsc.getInfoAc() != null && !getSuimSuit17DtlBsc.getInfoAc().equals("") ){
			 getSuimSuit17DtlBsc.setInfoAc(damo.decodeDamo(getSuimSuit17DtlBsc.getInfoAc())); 
		}
		System.out.println("암호화후 : "+ getSuimSuit17DtlBsc.getInfoAc());
		
		/*면담자(관계) 리스트 추출*/
		List<SysAdmCodeDicVO> b2CodeList = sqlSession.selectList("SuimSuit17DtlMapper.b2CodeList");
		model.addAttribute("b2CodeList", b2CodeList);
		
		/*보고서 원본 파일 정보 추출 시작*/
		List<SuimSuit17OrgFileVO> suimSuit17FileList  = sqlSession.selectList("SuimSuit17DtlMapper.suimSuit17FileList", suimRptNo);
		model.addAttribute("suimSuit17FileList", suimSuit17FileList);
		model.addAttribute("fileListSize", suimSuit17FileList.size());
		
		/*보고서 원본 파일 정보 추출 끝*/
		
		return "top_suim_suit17/top_suim_suit17_dtl_rpt_udt";
	}//suimSuit17DtlRptUdt
	
	@RequestMapping(value = "suimSuit17DtlRptUdtOK", method = RequestMethod.POST)
	public void suimSuit17DtlRptUdtOK(Model model, HttpSession session, HttpServletResponse response, String reqPgNo, SuimSuit_17VO dtlVO, String suimRptNo) {

		logger.info("======= suimSuit17DtlRptUdtOK =======");
		
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

		int udtSuimSiut17DtlRpt = 0;
		System.out.println("d2 : " + dtlVO.getD2());
		System.out.println("d4 : " + dtlVO.getD4());
		
		udtSuimSiut17DtlRpt = sqlSession.update("SuimSuit17DtlMapper.udtSuimSiut17DtlRpt", dtlVO);
		
		int result = 0;
		if(udtSuimSiut17DtlRpt >0){
			
			result = 1;
			
		}
		
		out.print(result);
	}//suimSuit17DtlUdtOK
	
	@RequestMapping(value = "suit17ImgDelOk", method = RequestMethod.POST)
	public void suit17ImgDelOk(Model model, HttpSession session, HttpServletResponse response, String serialNo, PrintWriter out) {
		
		logger.info("suit17ImgDelOk");
		
		/*로그인 유저의 세션 정보 추출 시작*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		model.addAttribute("mbrAuthSessionVo", mbrAuthVo);

		/*로그인 유저의 세션 정보 추출 끝*/
		int result = 0;		
		String path = "/home/hosting_users/toplac/www"+sqlSession.selectOne("SuimSuit17DtlMapper.getSuimSuit17RptFilePathForDel", serialNo);
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
		
		sqlSession.selectOne("SuimSuit17DtlMapper.delSuimSuit17RptFile", serialNo);
		
		out.print(result);
	}
	



	@RequestMapping(value = "suimSuit17RptWordDown", method = RequestMethod.GET)
	public String interimPrintPage(Model model, HttpServletResponse response, HttpSession session, String suimRptNo, String interimFlag, String rptSiteNo, String type, SuimSuit_17VO dtlVO) {
		
		logger.info("suimSuit17RptWordDown");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("suimSuit17DtlRptUdt - no permession user_no : "+session.getAttribute("user_no_Session"));
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
		Damo damo = new Damo();
		SuimSuit_17VO getSuimSuit17DtlBsc = sqlSession.selectOne("SuimSuit17DtlMapper.getSuimSuit17DtlBsc", dtlVO);
		if (getSuimSuit17DtlBsc.getPolicyholderTel1() != null || getSuimSuit17DtlBsc.getPolicyholderTel1() != ""){
			getSuimSuit17DtlBsc.setPolicyholderTel1( damo.decodeDamo(getSuimSuit17DtlBsc.getPolicyholderTel1()) );
		}
		
		if (getSuimSuit17DtlBsc.getPolicyholderTel2() != null || getSuimSuit17DtlBsc.getPolicyholderTel2() !=""){
			getSuimSuit17DtlBsc.setPolicyholderTel2( damo.decodeDamo(getSuimSuit17DtlBsc.getPolicyholderTel2()) );
		}
		
		if (getSuimSuit17DtlBsc.getPolicyholderHp() != null || getSuimSuit17DtlBsc.getPolicyholderHp() !=""){
			getSuimSuit17DtlBsc.setPolicyholderHp( damo.decodeDamo(getSuimSuit17DtlBsc.getPolicyholderHp()) );
		}
		
		if (getSuimSuit17DtlBsc.getInfoW() != null || getSuimSuit17DtlBsc.getInfoW() !=""){
			getSuimSuit17DtlBsc.setInfoW( damo.decodeDamo(getSuimSuit17DtlBsc.getInfoW()) );
		}
		
		if (getSuimSuit17DtlBsc.getInfoZ() != null || getSuimSuit17DtlBsc.getInfoZ() !=""){
			getSuimSuit17DtlBsc.setInfoZ( damo.decodeDamo(getSuimSuit17DtlBsc.getInfoZ()) );
		}
		
		if (getSuimSuit17DtlBsc.getInfoAc() != null || getSuimSuit17DtlBsc.getInfoAc() !=""){
			getSuimSuit17DtlBsc.setInfoAc( damo.decodeDamo(getSuimSuit17DtlBsc.getInfoAc()) );
		}
		model.addAttribute("getSuimSuit17DtlBsc", getSuimSuit17DtlBsc);			
		
		/*보고서 원본 파일 정보 추출 시작*/
		List<SuimSuit17OrgFileVO> suimSuit17FileList  = sqlSession.selectList("SuimSuit17DtlMapper.suimSuit17FileList", suimRptNo);
		model.addAttribute("suimSuit17FileList", suimSuit17FileList);
		
		/*Print 공통 정보 추출 시작*/
		TopTmBscVO topTmBscVo = sqlSession.selectOne("SuimRptBodyMapper.topTmInfoForBody", getSuimSuit17DtlBsc.getTeamId());
		TopMbrBscVO mbrVoForBody = sqlSession.selectOne("SuimRptBodyMapper.mbrinfo", getSuimSuit17DtlBsc.getUserNo());
		
		model.addAttribute("topTmBscVo", topTmBscVo);
		model.addAttribute("mbrVoForBody", mbrVoForBody);
		
		String filename = getSuimSuit17DtlBsc.getSuimAcceptNo();
		try {
			filename = java.net.URLEncoder.encode(filename,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		response.setHeader("Content-Disposition", "attachment;filename="+filename+".doc");
		response.setHeader("Content-Description", "JSP Generated Data");
	    //response.setContentType("application/vnd.ms-word");
		return "top_suim_suit17/top_suim_suit17_dtl_word";				
		
	}
	
	@RequestMapping(value = "suimSuit17DtlView", method = RequestMethod.GET)
	public String suimSuit17DtlView(Model model, HttpServletResponse response, HttpSession session, String suimRptNo, SuimSuit_17VO dtlVO) {
		
		logger.info("suimSuit17DtlView");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("suimSuit17DtlViewInfoAc - no permession user_no : "+session.getAttribute("user_no_Session"));
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
		/* 보고서 정보 추출*/
		Damo damo = new Damo();
		SuimSuit_17VO getSuimSuit17DtlView = sqlSession.selectOne("SuimSuit17DtlMapper.getSuimSuit17DtlView", dtlVO);
		if (getSuimSuit17DtlView.getInfoAc() != null || getSuimSuit17DtlView.getInfoAc() != ""){
			getSuimSuit17DtlView.setInfoAc(damo.decodeDamo(getSuimSuit17DtlView.getInfoAc()));
		}
		if (getSuimSuit17DtlView.getPolicyholderTel2() != null || getSuimSuit17DtlView.getPolicyholderTel2() != ""){
			getSuimSuit17DtlView.setPolicyholderTel2(damo.decodeDamo(getSuimSuit17DtlView.getPolicyholderTel2()));
		}		
		if (getSuimSuit17DtlView.getInfoW() != null || getSuimSuit17DtlView.getInfoW() != ""){
			getSuimSuit17DtlView.setInfoW(damo.decodeDamo(getSuimSuit17DtlView.getInfoW()));
		}
		if (getSuimSuit17DtlView.getInfoZ() != null || getSuimSuit17DtlView.getInfoZ() != ""){
			getSuimSuit17DtlView.setInfoZ(damo.decodeDamo(getSuimSuit17DtlView.getInfoZ()));
		}	
		model.addAttribute("getSuimSuit17DtlView", getSuimSuit17DtlView);			
		
		return "top_suim_suit17/top_suim_suit17_dtl_view";				
		
	}
	
	/* 적부(흥국) 보고서 파일 다운로드 */
	@RequestMapping(value = "suimSuit17RptFileDownload", method = RequestMethod.GET)
	 public void suimSuit17RptFileDownload(String key,String type, String suimRptNo, HttpServletResponse response)
			 throws IOException{
		
		logger.info("suimSuit17RptFileDownload");
		
		String filePath = "";
		String fileName = "";
		
		if(type.equals("rptOrigin")){
			filePath = "/home/hosting_users/toplac/www"+sqlSession.selectOne("SuimSuit17DtlMapper.getSuimSuit17RptFileNameForDown", key);
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
