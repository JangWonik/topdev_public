package kr.co.toplac.topsuit.SS;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.nio.charset.Charset;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.converter.FormHttpMessageConverter;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import kr.co.toplac.topsuit.SuimSuit_18VO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.cmm.StringUtil;
import kr.co.toplac.util.etc.Damo;
import kr.co.toplac.util.ftp.FtpControll;
import kr.co.toplac.util.page.PageUtilityBasic;

@Controller
public class SuitController18 {
	@Autowired
	private SqlSession sqlSession;
	
	private static final Logger logger = LoggerFactory.getLogger(SuitController18.class);
	
	/*
	*********************************************************
	* Program ID	: suitList18
	* Program Name	: suitList18
	* Description	: 삼성 적부 리스트
	* Author		: 이선형
	* Date			: 2016.09.20.
	* UpdateDate	: 2016.01.18.
	* Udt Explain	: sms 발송 체크 관련 복호화
	*********************************************************
	*/
	@RequestMapping(value = "suitList18", method = RequestMethod.GET)
	public String suitList18(Model model, HttpSession session, String reqPgNo, String src) {

		logger.info("======= suitList18 =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		/*로그인 정보 유지 여부 확인*/
		if( (mbrAuthVo == null) || (session.getAttribute("user_no_Session") == null) ){
			logger.info("suitList18 - no session information ");
			session.invalidate();
			model.addAttribute("authFlag", "logout");
			return "top_suit/suit_book_list_18";
		}

		PageUtilityBasic pageUtil = new PageUtilityBasic();
			
		List<SuimSuit_18VO> suitList18
		= (List<SuimSuit_18VO>) pageUtil.pageBasic1Samsung(1, sqlSession, "Suit18Mapper.getSuitList18", reqPgNo, model, "suitList18");			
		
		int rowNum = sqlSession.selectOne("Suit18Mapper.cntRpt");
		
		if(reqPgNo == null || reqPgNo.equals("")){
			reqPgNo = "1";
		}
		
		int j=0;
		for (int i = rowNum-(17*(Integer.parseInt(reqPgNo)-1)) ; i > (rowNum-(17*(Integer.parseInt(reqPgNo)-1)) - suitList18.size() ); i--) {
			
			suitList18.get(j).setROWNUM(Integer.toString(i));
			j++;
		}
		
		
		Damo damo = new Damo();
		for (int i = 0; i < suitList18.size(); i++) {
			
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
		
		model.addAttribute("rowNum", rowNum);
		model.addAttribute("mbrAuthVo", mbrAuthVo);
		model.addAttribute("suitList18", suitList18);

		return "top_suit/suit_book_list_18";
	}//suimBookList
	
	/*
	*********************************************************
	* Program ID	: suit18ListSrced
	* Program Name	: suit18ListSrced
	* Description	: 삼성 적부 리스트 ( 검색 결과 )
	* Author		: 이선형
	* Date			: 2016.09.20.
	*  
	*********************************************************
	*/
	@RequestMapping(value = "suit18ListSrced", method = RequestMethod.GET)
	public String suit18ListSrced(Model model, HttpSession session, String reqPgNo, String sDay, String eDay) {

		logger.info("======= suitList18 =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		/*로그인 정보 유지 여부 확인*/
		if( (mbrAuthVo == null) || (session.getAttribute("user_no_Session") == null) ){
			logger.info("suitList18 - no session information ");
			session.invalidate();
			model.addAttribute("authFlag", "logout");
			return "top_suit/suit_book_list_18";
		}

		HashMap<String,Object> map = new HashMap<String, Object>();
		
		map.put("sDay", sDay);
		map.put("eDay", eDay);
		
		PageUtilityBasic pageUtil = new PageUtilityBasic();
			
		List<SuimSuit_18VO> suitList18
		= (List<SuimSuit_18VO>) pageUtil.pageBasicSamsungSearch(1, sqlSession, "Suit18Mapper.getSuitList18Srced", reqPgNo, model, "suit18ListSrced",map);			
		
		int rowNum = sqlSession.selectOne("Suit18Mapper.cntRptSrc",map);
		
		if(reqPgNo == null || reqPgNo.equals("")){
			reqPgNo = "1";
		}
		
		int j=0;
		for (int i = rowNum-(17*(Integer.parseInt(reqPgNo)-1)) ; i > (rowNum-(17*(Integer.parseInt(reqPgNo)-1)) - suitList18.size() ); i--) {
			
			suitList18.get(j).setROWNUM(Integer.toString(i));
			j++;
		}
		Damo damo = new Damo();
		for (int i = 0; i < suitList18.size(); i++) {
			
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
		
		model.addAttribute("rowNum", rowNum);
		model.addAttribute("mbrAuthVo", mbrAuthVo);
		model.addAttribute("suitList18", suitList18);
		model.addAttribute("sDay", sDay);
		model.addAttribute("eDay", eDay);

		return "top_suit/suit_book_list_18";
	}//suimBookListSrced
	
	/*
	*********************************************************
	* Program ID	: popSuit18Dtl
	* Program Name	: popSuit18Dtl
	* Description	: 삼성 적부 상세
	* Author		: 이선형
	* Date			: 2016.09.21.
	*  
	*********************************************************
	*/
	@RequestMapping(value = "popSuit18Dtl", method = RequestMethod.GET)
	public String popSuit18Dtl(Model model, HttpSession session, String suim_rpt_no) {

		logger.info("======= popSuit18Dtl =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		/*로그인 정보 유지 여부 확인*/
		if( (mbrAuthVo == null) || (session.getAttribute("user_no_Session") == null) ){
			logger.info("popSuit18Dtl - no session information ");
			session.invalidate();
			model.addAttribute("authFlag", "logout");
			return "top_suit/suit18_rpt_dtl_pop";
		}
		
		/*열람권한 추출*/
		HashMap<String,String> map = new HashMap<String,String>(); 
		map.put("suim_rpt_no", suim_rpt_no);
		map.put("user_no", (String)(session.getAttribute("user_no_Session")) );
		map.put("user_no_session", (String)(session.getAttribute("user_no_Session")) );
		
		/*SuimSuitController 적부 열람 권한 */
		//int suitReadYn = sqlSession.selectOne("SuimSuitMapper.getReadYn", map);

		SuimSuit_18VO suimSuit_18Vo = sqlSession.selectOne("Suit18Mapper.getOneOfSuit18", map);
		
		Damo damo = new Damo();
		if(suimSuit_18Vo.getConHndPhoneNo() != null && !suimSuit_18Vo.getConHndPhoneNo().equals("")){
			suimSuit_18Vo.setConHndPhoneNo( damo.decodeDamo(suimSuit_18Vo.getConHndPhoneNo()) );
		}
		
		if(suimSuit_18Vo.getClerkHndPhoneNo() != null && !suimSuit_18Vo.getClerkHndPhoneNo().equals("")){
			suimSuit_18Vo.setClerkHndPhoneNo( damo.decodeDamo(suimSuit_18Vo.getClerkHndPhoneNo()) );
		}
		if(suimSuit_18Vo.getPolicyholderHp() != null && !suimSuit_18Vo.getPolicyholderHp().equals("")){
			suimSuit_18Vo.setPolicyholderHp( damo.decodeDamo(suimSuit_18Vo.getPolicyholderHp()) );
		}
		
		if(suimSuit_18Vo.getConHomeTelNo() != null && !suimSuit_18Vo.getConHomeTelNo().equals("")){
			suimSuit_18Vo.setConHomeTelNo( damo.decodeDamo(suimSuit_18Vo.getConHomeTelNo()) );
		}
		
		if(suimSuit_18Vo.getClerkOfcTelNo() != null && !suimSuit_18Vo.getClerkOfcTelNo().equals("")){
			suimSuit_18Vo.setClerkOfcTelNo( damo.decodeDamo(suimSuit_18Vo.getClerkOfcTelNo()) );
		}
		
		if(suimSuit_18Vo.getB1() != null && !suimSuit_18Vo.getB1().equals("")){
			suimSuit_18Vo.setB1( damo.decodeDamo(suimSuit_18Vo.getB1()) );
		}
		
		if(suimSuit_18Vo.getBd1B() != null && !suimSuit_18Vo.getBd1B().equals("")){
			suimSuit_18Vo.setBd1B( damo.decodeDamo(suimSuit_18Vo.getBd1B()) );
		}
		
		if(suimSuit_18Vo.getBd1D() != null && !suimSuit_18Vo.getBd1D().equals("")){
			suimSuit_18Vo.setBd1D( damo.decodeDamo(suimSuit_18Vo.getBd1D()) );
		}
		
		if(suimSuit_18Vo.getBd2B() != null && !suimSuit_18Vo.getBd2B().equals("")){
			suimSuit_18Vo.setBd2B( damo.decodeDamo(suimSuit_18Vo.getBd2B()) );
		}
		
		if(suimSuit_18Vo.getBd2D() != null && !suimSuit_18Vo.getBd2D().equals("")){
			suimSuit_18Vo.setBd2D( damo.decodeDamo(suimSuit_18Vo.getBd2D()) );
		}
		
		if(suimSuit_18Vo.getBd3B() != null && !suimSuit_18Vo.getBd3B().equals("")){
			suimSuit_18Vo.setBd3B( damo.decodeDamo(suimSuit_18Vo.getBd3B()) );
		}
		
		if(suimSuit_18Vo.getBd3D() != null && !suimSuit_18Vo.getBd3D().equals("")){
			suimSuit_18Vo.setBd3D( damo.decodeDamo(suimSuit_18Vo.getBd3D()) );
		}		
		
		if(suimSuit_18Vo.getPtnrMbrOfficeTel() != null && !suimSuit_18Vo.getPtnrMbrOfficeTel().equals("")){
			suimSuit_18Vo.setPtnrMbrOfficeTel( damo.decodeDamo(suimSuit_18Vo.getPtnrMbrOfficeTel()) );
		}		
		
		/*문자 정보 추출*/
		List<SuimSuit_18_SmsVO> samsungSmsList = sqlSession.selectList("Suit18Mapper.getSmsList",suim_rpt_no);
		
		int conCnt1 =0;
		int conCnt2 =0;
		int timeDiffer = 0;
		
		for (int i = 0; i < samsungSmsList.size(); i++) {
			if(samsungSmsList.get(i).getSmsType().equals("1")){
				conCnt1++;
				timeDiffer = Integer.parseInt(samsungSmsList.get(i).getPastTime());
			}
			
			if(samsungSmsList.get(i).getSmsType().equals("2")){
				conCnt2++;
			}
			
			/*sms 디아모 적용*/
			if (samsungSmsList.get(i).getsHp() != null || samsungSmsList.get(i).getsHp() != ""){	
				samsungSmsList.get(i).setsHp(damo.decodeDamo(samsungSmsList.get(i).getsHp()));
			}
			if (samsungSmsList.get(i).getrHp() != null || samsungSmsList.get(i).getrHp() != ""){			
				samsungSmsList.get(i).setrHp(damo.decodeDamo(samsungSmsList.get(i).getrHp()));
			}
		}
		
//		String tmpPhoneFront = suimSuit_18Vo.getConHndPhoneNo().substring(0, 3);
		String cn1Ok = "";
		//System.out.println("conCnt2 : " +conCnt2);
		//System.out.println("suimSuit_18Vo.getConHndPhoneNo() : " +suimSuit_18Vo.getConHndPhoneNo());
		//System.out.println("suimSuit_18Vo.getConHndPhoneNo().length() : "+suimSuit_18Vo.getConHndPhoneNo().length());
		
		if( conCnt2 > 0 && suimSuit_18Vo.getConHndPhoneNo() != "" && 
			suimSuit_18Vo.getConHndPhoneNo().length() > 10){
			cn1Ok = "ok";
 		}
//		String tmpPhoneFront = suimSuit_18Vo.getConHndPhoneNo().substring(0, 3);
//		String cn1Ok = "";
//		if( !(conCnt1 < 1 && ( (suimSuit_18Vo.getConHndPhoneNo() != "") && 
//				(tmpPhoneFront.equals("010") ||  tmpPhoneFront.equals("011") || tmpPhoneFront.equals("016") || tmpPhoneFront.equals("017") || tmpPhoneFront.equals("018") || tmpPhoneFront.equals("019")) 
//				))){
//			cn1Ok = "ok";
//		}
		
		/*전송된 이미지 정보 추출*/
		List<SuimSuit_18_FileSendVO> suimSuit_18_FileSendList = sqlSession.selectList("Suit18Mapper.getSendList", suim_rpt_no); 
		
		
		model.addAttribute("cn1Ok", cn1Ok);
		model.addAttribute("conCnt1", conCnt1);
		model.addAttribute("conCnt2", conCnt2);
		model.addAttribute("timeDiffer", timeDiffer);
		
		
		model.addAttribute("suimSuit_18_FileSendList", suimSuit_18_FileSendList);
		model.addAttribute("samsungSmsList", samsungSmsList);
		//model.addAttribute("suitReadYn", suitReadYn);
		model.addAttribute("mbrAuthVo", mbrAuthVo);
		model.addAttribute("mbrVo", mbrVo);
		
		//if(suitReadYn >= 1){
			model.addAttribute("suimSuit_18Vo", suimSuit_18Vo);			
		//}

		return "top_suit/suit18_rpt_dtl_pop";
	}//suimBookList
	
	/*
	*********************************************************
	* Program ID	: suit18Word
	* Program Name	: suit18Word
	* Description	: 삼성 적부 보고서 wordDown
	* Author		: 이선형
	* Date			: 2016.09.22.
	*  
	*********************************************************
	*/
	@RequestMapping(value = "suit18Word", method = RequestMethod.GET)
	public String suit18Word(Model model, String suim_rpt_no, HttpServletResponse response,HttpSession session) { //param
		
		/*파일정보*/
		List<SuimSuit_18_FileVO> suimSuit_18_FileList = sqlSession.selectList("Suit18Mapper.getSuit18ImgList", suim_rpt_no);
		//System.out.println("suimSuit_18_FileList.size() : " +suimSuit_18_FileList.size());
		
		
		/*적부 한건 정보*/
		HashMap<String,String> map = new HashMap<String,String>(); 
		map.put("suim_rpt_no", suim_rpt_no);
		map.put("user_no", (String)(session.getAttribute("user_no_Session")) );
		map.put("user_no_session", (String)(session.getAttribute("user_no_Session")) );
		
		SuimSuit_18VO suimSuit_18Vo = sqlSession.selectOne("Suit18Mapper.getOneOfSuit18", map);
		Damo damo = new Damo();
		if (suimSuit_18Vo.getB1() != null || suimSuit_18Vo.getB1() != ""){
			suimSuit_18Vo.setB1(damo.decodeDamo(suimSuit_18Vo.getB1()));
		}
		if (suimSuit_18Vo.getBd1B() != null || suimSuit_18Vo.getBd1B() != ""){
			suimSuit_18Vo.setBd1B(damo.decodeDamo(suimSuit_18Vo.getBd1B()));
		}
		if (suimSuit_18Vo.getBd1D() != null || suimSuit_18Vo.getBd1D() != ""){
			suimSuit_18Vo.setBd1D(damo.decodeDamo(suimSuit_18Vo.getBd1D()));
		}
		
		if (suimSuit_18Vo.getBd2B() != null || suimSuit_18Vo.getBd2B() != ""){
			suimSuit_18Vo.setBd2B(damo.decodeDamo(suimSuit_18Vo.getBd2B()));
		}
		if (suimSuit_18Vo.getBd2D() != null || suimSuit_18Vo.getBd2D() != ""){
			suimSuit_18Vo.setBd2D(damo.decodeDamo(suimSuit_18Vo.getBd2D()));
		}
		
		if (suimSuit_18Vo.getBd3B() != null || suimSuit_18Vo.getBd3B() != ""){
			suimSuit_18Vo.setBd3B(damo.decodeDamo(suimSuit_18Vo.getBd3B()));
		}
		if (suimSuit_18Vo.getBd3D() != null || suimSuit_18Vo.getBd3D() != ""){
			suimSuit_18Vo.setBd3D(damo.decodeDamo(suimSuit_18Vo.getBd3D()));
		}
		
		/*팀정보*/
		String team_id = suimSuit_18Vo.getTeamId();
		TopTmBscVO topTmBscVo = sqlSession.selectOne("SuimRptBodyMapper.topTmInfoForBody", team_id);
		
		/*사원정보*/	
		String user_no = suimSuit_18Vo.getUserNo();
		TopMbrBscVO mbrVoForBody = sqlSession.selectOne("SuimRptBodyMapper.mbrinfo", user_no);
		
		/*오늘날자구하기*/
		Date today = new Date();
		DateFormat timeForNaming = new SimpleDateFormat("yyyyMMdd");
		DateFormat todayForPrint = new SimpleDateFormat("yyyy.MM.dd");
		
		String formatTime = timeForNaming.format(today);//String형으로 변환
		
		String filename = suimSuit_18Vo.getEntyDsgnNo()+"70990890A0A0320000_"+ formatTime;
		
		String todayForWord = todayForPrint.format(today);//String형으로 변환
		try {
			filename = java.net.URLEncoder.encode(filename,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		response.setHeader("Content-Disposition", "attachment;filename="+filename+".doc");
		response.setHeader("Content-Description", "JSP Generated Data");
		
		model.addAttribute("suimSuit_18_FileList", suimSuit_18_FileList);
		model.addAttribute("todayForWord", todayForWord);
		model.addAttribute("suimSuit_18Vo", suimSuit_18Vo);
		model.addAttribute("topTmInfoForBody", topTmBscVo);
		model.addAttribute("mbrVoForBody", mbrVoForBody);

		return "top_suit/suit18_rpt_print_word";	
		
	}
	
	
	/*
	*********************************************************
	* Program ID	: suit18Rs
	* Program Name	: suit18Rs
	* Description	: 삼성 적부 보고서 응답 전문 txt 출력
	* Author		: 이선형
	* Date			: 2016.09.23.
	*  
	*********************************************************
	*/
	@RequestMapping(value = "suit18Rs", method = RequestMethod.GET)
	public void suit18Rs(Model model, String suim_rpt_no, HttpServletRequest request, HttpServletResponse response, PrintWriter out, HttpSession session) { //param
		logger.info("======= suit18Rs =======");
		
		
		/*적부 한건 정보*/
		HashMap<String,String> map = new HashMap<String,String>(); 
		map.put("suim_rpt_no", suim_rpt_no);
		map.put("user_no", (String)(session.getAttribute("user_no_Session")) );
		map.put("user_no_session", (String)(session.getAttribute("user_no_Session")) );
		SuimSuit_18VO suimSuit_18Vo = sqlSession.selectOne("Suit18Mapper.getOneOfSuit18", map);
		
		/*오늘날자구하기*/
		Date today = new Date();
		DateFormat timeForNaming = new SimpleDateFormat("yyyy-MM-dd");
		String filename = timeForNaming.format(today);//String형으로 변환
		
		String reponseStr = "";
		
		String userName1 = "";
		String userName2 = "";
		String userName3 = "";
		
		if(suimSuit_18Vo.getBd1I() != ""){
			userName1 = suimSuit_18Vo.getUserName();
		}else if(suimSuit_18Vo.getBd2I() != ""){
			userName2 = suimSuit_18Vo.getUserName();
		}else if(suimSuit_18Vo.getBd3I() != ""){
			userName3 = suimSuit_18Vo.getUserName();
		}
		
		reponseStr += filename+";";
		reponseStr += "11;";
		reponseStr += "01;";
		reponseStr += suimSuit_18Vo.getBdType()+";";
		reponseStr += Rpad(suimSuit_18Vo.getPlcyNo(), 17, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getEntyDsgnNo(), 16, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getContractorName(), 30, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getReport1(), 2, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getReport2(), 2, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getReport3(), 2, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getReport4(), 1, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getReport5(), 1, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getReport6(), 1, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getReport7(), 1, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getReport8(), 1, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getReport9(), 1, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getReport10(), 300, " ") +";";
		
		reponseStr += Rpad(suimSuit_18Vo.getBd1N(), 20, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getBd1O(), 2, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getBd1K(), 2, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getBd1L(), 60, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getBd1M(), 60, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getBd1I(), 20, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getBd1J(), 10, " ") +";";
		
		reponseStr += Rpad(userName1, 20, " ") +";";
		
		reponseStr += Rpad(suimSuit_18Vo.getBd2N(), 20, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getBd2O(), 2, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getBd2K(), 2, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getBd2L(), 60, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getBd2M(), 60, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getBd2I(), 20, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getBd2J(), 10, " ") +";";
		
		reponseStr += Rpad(userName2, 20, " ") +";";
		
		reponseStr += Rpad(suimSuit_18Vo.getBd3N(), 20, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getBd3O(), 2, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getBd3K(), 2, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getBd3L(), 60, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getBd3M(), 60, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getBd3I(), 20, " ") +";";
		reponseStr += Rpad(suimSuit_18Vo.getBd3J(), 10, " ") +";";
		
		reponseStr += Rpad(userName3, 20, " ") +";";
		
		timeForNaming = new SimpleDateFormat("yyyyMMdd");
		filename = timeForNaming.format(today);//String형으로 변환
		
		int result = 0;
		String file = "R.JUTORS."+filename+".001.txt";
		
		/*웹서버에 임시 파일 저장*/
		try
        {
            FileWriter fw = new FileWriter(FtpControll.IMG_TMP+"//"+file); // 절대주소 경로 가능
            BufferedWriter bw = new BufferedWriter(fw);
 
            bw.write(reponseStr);
            bw.newLine(); // 줄바꿈
            bw.close();
        }
        catch (IOException e)
        {
            System.err.println(e); // 에러가 있다면 메시지 출력
            
            //System.exit(1); //System.exit(1)을 할 경우, was가 내려갈 수 있음.
            result = 1;
        }
		
		/*삼성 적부 피씨로 업로드*/
		try {
			FtpControll.upload(FtpControll.IMG_TMP+"//"+ file, FtpControll.RS_DIR, file, request);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			result = 1;
			e.printStackTrace();
		}
		
		//임시 파일 삭제 시작
//		if(file != ""){
//				/*파일삭제*/
//				File tmpFile = new File(FtpControll.IMG_TMP+"//"+ file);
//				tmpFile.delete();
//					
//		}
		//파일 삭제 종료

		out.print(result);	
		
	}
	
	/*
	*********************************************************
	* Program ID	: josa18EditeOk
	* Program Name	: josa18EditeOk
	* Description	: 삼성 적부 조사 내용 수정
	* Author		: 이선형
	* Date			: 2016.09.22.
	*  
	*********************************************************
	*/
	@RequestMapping(value = "josa18EditeOk", method = RequestMethod.POST)
	public void josa18EditeOk(Model model, SuimSuit_18VO suimSuit_18Vo, PrintWriter out) { //param
		
		int result = sqlSession.update("Suit18Mapper.udtJosa18", suimSuit_18Vo);
		
		out.print(result);
		
	}
	
	/*
	*********************************************************
	* Program ID	: rpt18EditePop
	* Program Name	: rpt18EditePop
	* Description	: 삼성 적부 보고서 내용 수정 화면 호출
	* Author		: 이선형
	* Date			: 2016.09.22.
	*  
	*********************************************************
	*/
	@RequestMapping(value = "rpt18EditePop", method = RequestMethod.GET)
	public String rpt18EditePop(Model model, String suim_rpt_no, HttpSession session) { //param
		
		
		HashMap<String,String> map = new HashMap<String,String>(); 
		map.put("suim_rpt_no", suim_rpt_no);
		map.put("user_no", (String)(session.getAttribute("user_no_Session")) );
		map.put("user_no_session", (String)(session.getAttribute("user_no_Session")) );
		SuimSuit_18VO suimSuit_18Vo = sqlSession.selectOne("Suit18Mapper.getOneOfSuit18", map);
		Damo damo = new Damo();
		if ( suimSuit_18Vo.getB1() != null && !suimSuit_18Vo.getB1().equals("") ){
			suimSuit_18Vo.setB1( damo.decodeDamo(suimSuit_18Vo.getB1()) );
		}
		
		if( suimSuit_18Vo.getClerkHndPhoneNo() != null &&  !suimSuit_18Vo.getClerkHndPhoneNo().equals("") ) {
			suimSuit_18Vo.setClerkHndPhoneNo( damo.decodeDamo(suimSuit_18Vo.getClerkHndPhoneNo()) );
		}
		
		if( suimSuit_18Vo.getBd1D() != null && !suimSuit_18Vo.getBd1D().equals("") ) {
			suimSuit_18Vo.setBd1D( damo.decodeDamo(suimSuit_18Vo.getBd1D()) );
		}
		
		List<SuimSuit_18_FileVO> suimSuit_18_FileList = sqlSession.selectList("Suit18Mapper.getSuit18ImgList", suim_rpt_no);
		model.addAttribute("suimSuit_18Vo", suimSuit_18Vo);
		model.addAttribute("suimSuit_18_FileList", suimSuit_18_FileList);
		model.addAttribute("fileListSize", suimSuit_18_FileList.size());
		
		
		return "top_suit/suit18_rpt_udt_pop";
		
	}
	
	/*
	*********************************************************
	* Program ID	: suit18RptEditeOk
	* Program Name	: suit18RptEditeOk
	* Description	: 삼성 적부 보고서 내용 수정
	* Author		: 이선형
	* Date			: 2016.09.22.
	*  
	*********************************************************
	*/
	@RequestMapping(value = "suit18RptEditeOk", method = RequestMethod.POST)
	public void suit18RptEditeOk(Model model, SuimSuit_18VO suimSuit_18Vo, PrintWriter out) { //param
		
		Damo damo = new Damo();
		if(suimSuit_18Vo.getB1() != null || suimSuit_18Vo.getB1() != ""){
			suimSuit_18Vo.setB1( damo.encodeDamo(suimSuit_18Vo.getB1()) );
		}
		int result = sqlSession.update("Suit18Mapper.udtRpt18", suimSuit_18Vo);
		
		out.print(result);
		
	}
	
	
	/*
	*********************************************************
	* Program ID	: smsSend
	* Program Name	: smsSend
	* Description	: 삼성 적부 보고서 내 문자발송
	* Author		: 이선형
	* Date			: 2016.09.26.
	*  
	*********************************************************
	*/
	@RequestMapping(value = "smsSend", method = RequestMethod.POST)
	public void smsSend(Model model, String suimRptNo, int smsType, String receiveTel, String sendTel, PrintWriter out, HttpSession session) { //param
		
		String result = "0";
		String suim_rpt_no = suimRptNo;
		
		HashMap<String,String> map = new HashMap<String,String>(); 
		map.put("suim_rpt_no", suim_rpt_no);
		map.put("user_no", (String)(session.getAttribute("user_no_Session")) );
		map.put("user_no_session", (String)(session.getAttribute("user_no_Session")) );
		SuimSuit_18VO suimSuit_18Vo = sqlSession.selectOne("Suit18Mapper.getOneOfSuit18", map);
		
		//System.out.println("receiveTel : " +receiveTel);
		//System.out.println("sendTel : " + sendTel);

		
		
		if( (smsType ==1) && (suimRptNo != null) ){
			/*String userPhone1 = suimSuit_18Vo.getHandphone().substring(0, 3);
			String userPhone2 = suimSuit_18Vo.getHandphone().substring(4, 8);
			String userPhone3 = suimSuit_18Vo.getHandphone().substring(9, suimSuit_18Vo.getHandphone().length());*/
//			String clerkPhone1 = suimSuit_18Vo.getClerkHndPhoneNo().substring(0, 3);
//			String clerkPhone2 = suimSuit_18Vo.getClerkHndPhoneNo().substring(3, 7);
//			String clerkPhone3 = suimSuit_18Vo.getClerkHndPhoneNo().substring(7, suimSuit_18Vo.getClerkHndPhoneNo().length());
			
			if( (receiveTel != null && receiveTel.length() > 9 ) && (sendTel != null && sendTel.length() > 9) ){
//				String hpId = "1";
				
				Damo damo = new Damo();
//				String rHp = damo.encodeDamo(suimSuit_18Vo.getClerkHndPhoneNo());
//				String sHp = damo.encodeDamo(suimSuit_18Vo.getHandphone().replaceAll("-", ""));
				
				String rHp = damo.encodeDamo(receiveTel);
				String sHp = damo.encodeDamo(sendTel);
				
				String msg = "안녕하십니까? 최근 체결하신 "+suimSuit_18Vo.getContractorName()+" 고객님의 삼성화재 화재보험을 임의 선정절차에 따라 계약확인 위탁업무를 담당하게 된 탑손해사정의 "
						+suimSuit_18Vo.getUserName()+" 입니다. 고객님께 연락 후 현장 방문예정입니다. 궁금하신 사항 있으시면 연락 부탁드립니다.";

				
				/*DB 입력동작*/
				SuimSuit_18_SmsVO suimSuit_18_SmsVo = new SuimSuit_18_SmsVO();
				suimSuit_18_SmsVo.setrMsg(msg);
				
				/** 실 발송시 암호화가 되지 않은 번호로 전송해야함 **/
				suimSuit_18_SmsVo.setrHp(receiveTel);
				suimSuit_18_SmsVo.setsHp(sendTel);
				
				//npro 문자발송제거 by top3009
				//sqlSession.insert("Suit18Mapper.insMmsInfo", suimSuit_18_SmsVo);
				//sqlSession.insert("Suit18Mapper.insMmsData", suimSuit_18_SmsVo);
				
				//카카오를 통한 발송으로 변경 (sendNo를 넣어도 대표번호로 발송되도록 함)
				sendKakaoTalk(sendTel,receiveTel,msg,smsType);
				
				suimSuit_18_SmsVo.setrHp(rHp);
				suimSuit_18_SmsVo.setsHp(sHp);
				suimSuit_18_SmsVo.setSuimRptNo(suimRptNo);
				suimSuit_18_SmsVo.setSmsType(Integer.toString(smsType));
				sqlSession.insert("Suit18Mapper.insContractSms", suimSuit_18_SmsVo);
				
				result = "1";
			}else{
				result = "휴대폰 번호가 잘못됐습니다.";
			}
		}
		
		
		if( (smsType ==2) && (suimRptNo != null) ){
//			String conPhone1 = suimSuit_18Vo.getConHndPhoneNo().substring(0, 3);
//			String conPhone2 = suimSuit_18Vo.getConHndPhoneNo().substring(3, 7);
//			String conPhone3 = suimSuit_18Vo.getConHndPhoneNo().substring(7, suimSuit_18Vo.getConHndPhoneNo().length());
			
			if( (receiveTel != null && receiveTel.length() >= 10 ) && (sendTel != null && sendTel.length() >= 10) ){
				
				Damo damo = new Damo();
//				String rHp = damo.encodeDamo(suimSuit_18Vo.getConHndPhoneNo());
//				String sHp = damo.encodeDamo(suimSuit_18Vo.getHandphone().replaceAll("-", ""));
				String rHp = damo.encodeDamo(receiveTel);
				String sHp = damo.encodeDamo(sendTel);
				String msg = "안녕하십니까? 최근 체결하신 "+suimSuit_18Vo.getContractorName()+" 고객님 안녕하십니까? 삼성화재 화재보험 가입에 감사합니다."
						+ " 계약확인 위탁업무를 담당하게 된 탑손해사정의 담당자 "+suimSuit_18Vo.getUserName() +" 입니다. 차후 방문을 위해 해당번호로 전화 드리겠습니다.";
				
				/*DB 입력동작*/
				SuimSuit_18_SmsVO suimSuit_18_SmsVo = new SuimSuit_18_SmsVO();
				suimSuit_18_SmsVo.setrMsg(msg);
				
				suimSuit_18_SmsVo.setrHp(receiveTel);
				suimSuit_18_SmsVo.setsHp(sendTel);
				
				//npro 문자발송제거 by top3009
				//sqlSession.insert("Suit18Mapper.insMmsInfo", suimSuit_18_SmsVo);
				//sqlSession.insert("Suit18Mapper.insMmsData", suimSuit_18_SmsVo);
				
				//카카오를 통한 발송으로 변경 (sendNo를 넣어도 대표번호로 발송되도록 함)
				sendKakaoTalk(sendTel,receiveTel,msg,smsType);
				
				/** 실 발송시 암호화가 되지 않은 번호로 전송해야함 **/
				suimSuit_18_SmsVo.setrHp(rHp);
				suimSuit_18_SmsVo.setsHp(sHp);
				suimSuit_18_SmsVo.setSuimRptNo(suimRptNo);
				suimSuit_18_SmsVo.setSmsType(Integer.toString(smsType));
				sqlSession.insert("Suit18Mapper.insContractSms", suimSuit_18_SmsVo);
				
				result = "1";
				
			}else{
				result = "휴대폰 번호가 잘못됐습니다.";				
			}
			
		}
		
		out.print(result);
		
	}
	
	/**
	 * 카카오발송 방식으로 변경	 
	 **/
	public static String sendKakaoTalk(String senderNo, String receiveNo, String sMsg, int smsType){				//smsType에 따라 메세지가 달라짐
		String sRet = "";
		
		String tmplId = "toplac_suit_18_1";		//삼성적부템플릿코드
		
		if( smsType == 2 ){			//1인 경우는 기본템플릿 2인 경우는 변경템플릿으로 바꾼다. 
			tmplId = "toplac_suit_18_2";
		}
		
		String msg = sMsg;								//발송메세지
		
		String phn = "82"+receiveNo.substring(1);
		
		RestTemplate restTemplate = new RestTemplate();
		// RestTemplate 에 MessageConverter 세팅
	    List<HttpMessageConverter<?>> converters = new ArrayList<HttpMessageConverter<?>>();
	    converters.add(new FormHttpMessageConverter());
	    converters.add(new StringHttpMessageConverter(Charset.forName("UTF-8")));
		
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.add("Accept", "application/json");
		httpHeaders.add("Content-type", "application/json");
		httpHeaders.add("userId", "toplac"); //실제
		
		
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		obj.put("message_type", "at");
		obj.put("phn", phn);
		obj.put("profile", "22e9cd927d652e02daca5dc631170e021f02ae51");	//실제
		obj.put("tmplId", tmplId);
		obj.put("msg", msg);
	
		obj.put("smsKind", "L");
		obj.put("msgSms", msg);
		obj.put("smsSender", "0260774600");
	
		obj.put("smsLmsTit", "탑손해사정주식회사");
		obj.put("reserveDt", "00000000000000");
		
		//메시지 길이가 930자 이상인경우 SMS 로 전환하여 발송
		int msgLength = msg.length();
		if( msgLength > 930 ) {
			obj.put("smsOnly", "Y");
		}
		
		arr.add(obj);
		
		HttpEntity entity = new HttpEntity(arr, httpHeaders);
		
		//System.out.println(tmplId);
		
		URI uri = UriComponentsBuilder.fromHttpUrl("https://alimtalk-api.bizmsg.kr/v2/sender/send")
				.build().toUri();
				
		
		String responseEntity = restTemplate.postForObject(uri, entity, String.class);
		
		logger.info("SamSung Jukbu SendKakao : "+phn+" : "+msg+" : "+tmplId);
		
		return sRet;		
	}
	
	
	
	/*
	*********************************************************
	* Program ID	: suit18ImgDelOk
	* Program Name	: suit18ImgDelOk
	* Description	: 삼성 적부 보고서 이미지 삭제
	* Author		: 이선형
	* Date			: 2016.09.26.
	*  
	*********************************************************
	*/
	@RequestMapping(value = "suit18ImgDelOk", method = RequestMethod.POST)
	public void suit18ImgDelOk(Model model, String serialNo,String suimRptNo,String fileName,  PrintWriter out) { //param

		int result = 0;
		String path = "/home/hosting_users/toplac/www"+sqlSession.selectOne("Suit18Mapper.suimSuit18ImgPath", serialNo);
		String filefolder = path.substring(0, path.lastIndexOf("/"));
				
		//파일 삭제 시작
		if(!filefolder.equals("")){
			
			File file = new File(path);
			File dir = new File(filefolder);
			file.delete();
			dir.delete();
			
			result = 1;
		}
		//파일 삭제 종료
		
		sqlSession.delete("Suit18Mapper.delSuimSuit18Img", serialNo);
		
		out.print(result);
		
	}
	
	/*
	*********************************************************
	* Program ID	: smsPageCall
	* Program Name	: smsPageCall
	* Description	: 삼성 적부 보고서 내 문자발송
	* Author		: 이선형
	* Date			: 2016.09.26.
	*  
	*********************************************************
	*/
	@RequestMapping(value = "smsPageCall", method = RequestMethod.GET)
	public String smsPageCall(Model model, String suimRptNo, int smsType, HttpSession session) { //param
		
		String suim_rpt_no = suimRptNo;
		
		HashMap<String,String> map = new HashMap<String,String>(); 
		map.put("suim_rpt_no", suim_rpt_no);
		map.put("user_no", (String)(session.getAttribute("user_no_Session")) );
		map.put("user_no_session", (String)(session.getAttribute("user_no_Session")) );

		SuimSuit_18VO suimSuit_18Vo = sqlSession.selectOne("Suit18Mapper.getOneOfSuit18", map);
		SuimSuit_18_SmsVO suimSuit_18_SmsVo = new SuimSuit_18_SmsVO();
		
		if( (smsType ==1) && (suimRptNo != null) ){
				
			String msg = "안녕하십니까? 최근 체결하신 "+suimSuit_18Vo.getContractorName()+"고객님의 삼성화재 화재보험을 임의 선정절차에 따라 계약확인 위탁업무를 담당하게 된 탑손해사정의 "
						+suimSuit_18Vo.getUserName()+"입니다. 고객님께 연락 후 현장 방문예정입니다. 궁금하신 사항 있으시면 연락 부탁드립니다.";
			
			
			suimSuit_18_SmsVo.setrMsg(msg);
		}
		
		if( (smsType ==2) && (suimRptNo != null) ){

			String msg = "안녕하십니까? 최근 체결하신 "+suimSuit_18Vo.getContractorName()+"고객님 안녕하십니까? 삼성화재 화재보험 가입에 감사합니다. "
						+ "계약확인 위탁업무를 담당하게 된 탑손해사정의 담당자 "+suimSuit_18Vo.getUserName() +"입니다. 차후 방문을 위해 해당번호로 전화 드리겠습니다.";
			suimSuit_18_SmsVo.setrMsg(msg);
		}
		
		suimSuit_18_SmsVo.setSmsType(Integer.toString(smsType));
		
		Damo damo = new Damo();
		if (suimSuit_18Vo.getClerkHndPhoneNo() != null && !suimSuit_18Vo.getClerkHndPhoneNo().equals("")){
			suimSuit_18Vo.setClerkHndPhoneNo( damo.decodeDamo(suimSuit_18Vo.getClerkHndPhoneNo()).replaceAll("-", "") );
		}
		if (suimSuit_18Vo.getConHndPhoneNo() != null && !suimSuit_18Vo.getConHndPhoneNo().equals("")){
			suimSuit_18Vo.setConHndPhoneNo( damo.decodeDamo(suimSuit_18Vo.getConHndPhoneNo()).replaceAll("-", "") );
		}
		
		suimSuit_18Vo.setHandphone(suimSuit_18Vo.getHandphone().replaceAll("-",""));
		
		//회사 대표번호추가 (실제 발송될때 사용되는 송신번호)
		suimSuit_18Vo.setKeyOfficeNumber("0260774600");
		
//		suimSuit_18Vo.setHandphone("01071418158");
		
		
		model.addAttribute("suimSuit_18Vo", suimSuit_18Vo);
		model.addAttribute("suimSuit_18_SmsVo", suimSuit_18_SmsVo);
		
		return "util_sms/samsung_sms_form";
	}
	
	
	/*
	*********************************************************
	* Program ID	: endDateUdt
	* Program Name	: endDateUdt
	* Description	: 삼성 적부 보고서 종결일 수정 화면 호출
	* Author		: 이선형
	* Date			: 2016.09.27.
	*  
	*********************************************************
	*/
	@RequestMapping(value = "endDateUdt", method = RequestMethod.GET)
	public String endDateUdt(Model model, String suimRptNo, String endDate, String accNo) { //param
		
		
		model.addAttribute("suimRptNo", suimRptNo);
		model.addAttribute("endDate", endDate);
		model.addAttribute("accNo", accNo);
		
		return "top_suit/suit18_end_date_pop";
	}
	
	
	/*
	*********************************************************
	* Program ID	: endDateUdtOk
	* Program Name	: endDateUdtOk
	* Description	: 삼성 적부 보고서 종결일 수정
	* Author		: 이선형
	* Date			: 2016.09.27.
	*  
	*********************************************************
	*/
	@RequestMapping(value = "endDateUdtOk", method = RequestMethod.POST)
	public void endDateUdtOk(Model model, String suimRptNo, String end_date1,String end_date2,String end_date3,PrintWriter out) { //param
		
		HashMap<String,String> map = new HashMap<String,String>();
		
		map.put("suimRptNo", suimRptNo);
		map.put("closeDate", end_date1+"-"+end_date2+"-"+end_date3);
		
		int result = sqlSession.update("Suit18Mapper.endDateUdt",map);
		
		out.print(result);
	}
	
	
	/*
	*********************************************************
	* Program ID	: actionSuit18ReportOk
	* Program Name	: actionSuit18ReportOk
	* Description	: 삼성 적부 보고서 결재 동작
	* Author		: 이선형
	* Date			: 2016.09.27.
	*  
	*********************************************************
	*/
	@RequestMapping(value = "actionSuit18ReportOk", method = RequestMethod.POST)
	public void actionSuit18ReportOk(Model model,String action, String suimRptNo, PrintWriter out) { //param
		
		int result = 0;
		
		/*결재하기 시작*/
		if(action.equals("submit")){
			
			result = sqlSession.update("Suit18Mapper.actionSubmit",suimRptNo);
		}else if(action.equals("submit_x")){
			
			result = sqlSession.update("Suit18Mapper.actionSubmit_X",suimRptNo);
		}else if(action.equals("returnRpt")){
			
			result = sqlSession.update("Suit18Mapper.actionReturnRpt",suimRptNo);
		}else if(action.equals("return_x")){
			
			result = sqlSession.update("Suit18Mapper.actionReturnRpt_X",suimRptNo);
		}else if(action.equals("end")){
			
			/*날짜 계산*/
			Calendar cal = Calendar.getInstance();    
			cal.setTime(new Date());  
			
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
			String suimDay = df.format(cal.getTime());  
			
			/*접수번호 앞자리의 연도 YY + 월 MM*/
			String suimYear = suimDay.substring(2, 4);
			String suimMonth = suimDay.substring(5, 7);
			
			String todayCloseFront = "TE"+suimYear+suimMonth;
/* //notUse-2016.11.02.rjh
			String nextCloseNo = sqlSession.selectOne("Suit18Mapper.getNextCloseNoForSuit18", todayCloseFront);
			if(nextCloseNo == null || nextCloseNo.equals("")){
				nextCloseNo = "0001";
    		}else{
    			nextCloseNo = SuimRegInsController.makeFourNumberWithZero(nextCloseNo);
    			//acceptNo = String.format("%04d", acceptNo);			    			
    		}
*/
			String nextCloseNo = "0";
			HashMap<String, String> mapForAcceptSeqNo = new HashMap<String, String>();
			mapForAcceptSeqNo.put("suim_accept_seq_no", "");
			sqlSession.update("Suit18Mapper.getNextCloseNoForSuit182", mapForAcceptSeqNo);
			nextCloseNo = mapForAcceptSeqNo.get("suim_accept_seq_no");
			for(int i = nextCloseNo.length(); i < 4; i++){
				nextCloseNo = "0"+nextCloseNo;
			}

			nextCloseNo = todayCloseFront+"-"+nextCloseNo;
			
			HashMap<String,String> map = new HashMap<String,String>();
			map.put("nextCloseNo", nextCloseNo);
			map.put("suimRptNo", suimRptNo);
			
			result = sqlSession.update("Suit18Mapper.actionSubmit_E",map);
			
		}else if(action.equals("submit_e_x")){ // 종결 취소하기
			
			result = sqlSession.update("Suit18Mapper.actionSubmit_E_X",suimRptNo);
			
		}else if(action.equals("cancel")){ // 위임 취소하기
			
			result = sqlSession.update("Suit18Mapper.actionCancel",suimRptNo);
			
		}else if(action.equals("cancel_x")){ // 위임 취소하기
			
			result = sqlSession.update("Suit18Mapper.actionCancel_X",suimRptNo);
			
		}else if(action.equals("report_del")){ // 위임 취소를
			
			result = sqlSession.update("Suit18Mapper.actionDel",suimRptNo);
		}
	
		
		out.print(result);
		
	}
	
	
	/*
	*********************************************************
	* Program ID	: suit18RsList
	* Program Name	: suit18RsList
	* Description	: 삼성 적부 보고서 목록화면 응답 전문 txt 출력
	* Author		: 이선형
	* Date			: 2016.09.27.
	*  
	*********************************************************
	*/
	
	@RequestMapping(value = "suit18RsList", method = RequestMethod.GET)
	public void suit18RsList(Model model, String sDay, String eDay, HttpServletRequest request, HttpServletResponse response, PrintWriter out) { //param
		logger.info("======= suit18RsList =======");
		
		/*적부 한건 정보*/
		HashMap<String,String> map = new HashMap<String, String>();
		map.put("sDay", sDay);
		map.put("eDay", eDay);
		//System.out.println(sDay);
		//System.out.println(eDay);
		
		
		/*적부 목록 정보*/
		List<SuimSuit_18VO> suimSuit_18List = sqlSession.selectList("Suit18Mapper.getSuit18ListForRs", map);
		
		/*오늘날자구하기*/
		Date today = new Date();
		DateFormat timeForNaming = new SimpleDateFormat("yyyy-MM-dd");
		String filename = timeForNaming.format(today);//String형으로 변환
		
		StringBuffer reponseStr = new StringBuffer();
		
		String userName1 = "";
		String userName2 = "";
		String userName3 = "";
		
		
		for (int i = 0; i < suimSuit_18List.size(); i++) {
			
			if(suimSuit_18List.get(i).getBd1I() != ""){
				userName1 = suimSuit_18List.get(i).getUserName();
			}else if(suimSuit_18List.get(i).getBd2I() != ""){
				userName2 = suimSuit_18List.get(i).getUserName();
			}else if(suimSuit_18List.get(i).getBd3I() != ""){
				userName3 = suimSuit_18List.get(i).getUserName();
			}
			
			reponseStr.append(filename+";");
			reponseStr.append("11;");
			reponseStr.append("01;");
			reponseStr.append(suimSuit_18List.get(i).getBdType()+";");
			reponseStr.append(Lpad(suimSuit_18List.get(i).getPlcyNo(), 17, "0") +";");
			reponseStr.append(Rpad(suimSuit_18List.get(i).getEntyDsgnNo(), 16, " ") +";");
			reponseStr.append(Rpad(suimSuit_18List.get(i).getContractorName(), 30, " ") +";");
			reponseStr.append(Rpad(suimSuit_18List.get(i).getReport1(), 2, " ") +";"); 
			reponseStr.append(Rpad(suimSuit_18List.get(i).getReport2(), 2, " ") +";"); 
			reponseStr.append(Rpad(suimSuit_18List.get(i).getReport3(), 2, " ") +";"); 
			reponseStr.append(Rpad(suimSuit_18List.get(i).getReport4(), 1, " ") +";"); 
			reponseStr.append(Rpad(suimSuit_18List.get(i).getReport5(), 1, " ") +";"); 
			reponseStr.append(Rpad(suimSuit_18List.get(i).getReport6(), 1, " ") +";");
			reponseStr.append(Rpad(suimSuit_18List.get(i).getReport7(), 1, " ") +";"); 
			reponseStr.append(Rpad(suimSuit_18List.get(i).getReport8(), 1, " ") +";");
			reponseStr.append(Rpad(suimSuit_18List.get(i).getReport9(), 1, " ") +";"); 
			reponseStr.append(Rpad(suimSuit_18List.get(i).getReport10(), 300, " ") +";"); 
			
			reponseStr.append(Rpad(suimSuit_18List.get(i).getBd1N(), 30, " ") +";");
			reponseStr.append(Rpad(suimSuit_18List.get(i).getBd1O(), 2, " ") +";"); 
			reponseStr.append(Rpad(suimSuit_18List.get(i).getBd1K(), 2, " ") +";"); 
			reponseStr.append(Rpad(suimSuit_18List.get(i).getBd1L(), 60, " ") +";"); 
			reponseStr.append(Rpad(suimSuit_18List.get(i).getBd1M(), 60, " ") +";"); 
			reponseStr.append(Rpad(suimSuit_18List.get(i).getBd1I(), 20, " ") +";");			
			//날짜가 8자리로 들어가는 경우 포맷수정 by top3009			
			//reponseStr.append(Rpad(suimSuit_18List.get(i).getBd1J(), 10, " ") +";");
			reponseStr.append(Rpad(StringUtil.parseDateFormat(suimSuit_18List.get(i).getBd1J()), 10, " ") +";");
			
			reponseStr.append(Rpad(userName1, 20, " ") +";"); 
			
			reponseStr.append(Rpad(suimSuit_18List.get(i).getBd2N(), 30, " ") +";");
			reponseStr.append(Rpad(suimSuit_18List.get(i).getBd2O(), 2, " ") +";"); 
			reponseStr.append(Rpad(suimSuit_18List.get(i).getBd2K(), 2, " ") +";"); 
			reponseStr.append(Rpad(suimSuit_18List.get(i).getBd2L(), 60, " ") +";"); 
			reponseStr.append(Rpad(suimSuit_18List.get(i).getBd2M(), 60, " ") +";"); 
			reponseStr.append(Rpad(suimSuit_18List.get(i).getBd2I(), 20, " ") +";");
			//날짜가 8자리로 들어가는 경우 포맷수정 by top3009			
			//reponseStr.append(Rpad(suimSuit_18List.get(i).getBd2J(), 10, " ") +";");
			reponseStr.append(Rpad(StringUtil.parseDateFormat(suimSuit_18List.get(i).getBd2J()), 10, " ") +";");
			
			reponseStr.append(Rpad(userName2, 20, " ") +";"); 
			
			reponseStr.append(Rpad(suimSuit_18List.get(i).getBd3N(), 30, " ") +";");
			reponseStr.append(Rpad(suimSuit_18List.get(i).getBd3O(), 2, " ") +";"); 
			reponseStr.append(Rpad(suimSuit_18List.get(i).getBd3K(), 2, " ") +";"); 
			reponseStr.append(Rpad(suimSuit_18List.get(i).getBd3L(), 60, " ") +";"); 
			reponseStr.append(Rpad(suimSuit_18List.get(i).getBd3M(), 60, " ") +";"); 
			reponseStr.append(Rpad(suimSuit_18List.get(i).getBd3I(), 20, " ") +";");
			//날짜가 8자리로 들어가는 경우 포맷수정 by top3009
			//reponseStr.append(Rpad(suimSuit_18List.get(i).getBd3J(), 10, " ") +";");
			reponseStr.append(Rpad(StringUtil.parseDateFormat(suimSuit_18List.get(i).getBd3J()), 10, " ") +";");			
			
			//맨 마지막 공백은 1줄만 들어가야함..
			if (i+1 != suimSuit_18List.size()){
				reponseStr.append(Rpad(userName3, 20, " ") +";"+"\n");	
			}else{
				reponseStr.append(Rpad(userName3, 20, " ") +";");
			}
			 
		}
		
		
		timeForNaming = new SimpleDateFormat("yyyyMMdd");
		filename = timeForNaming.format(today);//String형으로 변환
		
		int result = 0;
		String file = "R.JUTORS."+filename+".001.txt";		
		
		/*웹서버에 임시 파일 저장*/
		try
        {
            FileWriter fw = new FileWriter(FtpControll.IMG_TMP+"//"+file); // 절대주소 경로 가능
            //BufferedWriter bw = new BufferedWriter(fw);
            //ANSI 인코딩으로 변경
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(FtpControll.IMG_TMP+"//"+file), "EUC_KR"));
 
            bw.write(reponseStr.toString());
            
            bw.newLine(); // 줄바꿈
            bw.close();
            
        }
        catch (IOException e)
        {
            System.err.println(e); // 에러가 있다면 메시지 출력
            //System.exit(1); // System.exit(1)을 할 경우, was가 내려갈 수 있음.
            result = 1;
        }
		
		/*삼성 적부 피씨로 업로드*/		
		try {
			FtpControll.upload(FtpControll.IMG_TMP+"//"+ file, FtpControll.RS_DIR, file, request);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			result = 1;
			e.printStackTrace();
		}		
		
		//임시 파일 삭제 시작
//		if(file != ""){
//				/*파일삭제*/
//				File tmpFile = new File(FtpControll.IMG_TMP+"//"+ file);
//				tmpFile.delete();
//					
//		}
		//파일 삭제 종료

		out.print(result);	
		
	}
	/*문자열 오른쪽 패딩 */
	public String Rpad(String str, int len, String addStr) {
		
		//입력받은 문자열의 빈칸이 있는지 체크후 처리한다. by top3009
		str = str.trim();
		
		byte[] bytTemp = null;
		int realLength = 0;
		
		try {
			bytTemp = str.getBytes("EUC-KR");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		int iLength = bytTemp.length;

		for(int iIndex = 0; iIndex < iLength; iIndex++) {
			
			int iChar = (int)bytTemp[iIndex];
			
			if((iChar > 127)|| (iChar < 0)) {				
				
				iIndex++;
				realLength++;
			}
			
			realLength++;
		}
		
        String result = str;
        int templen   = len - realLength; //result.length()
		
		//제한 길이보다 입력데이터가 크면 크기만큼 자른다. (자른후 다시 공백을 넣는다.)
		if( templen < 0 ) {
			result = StringUtil.substringHangulByBytes(str, 0, len);
		}else {		
	        for (int i = 0; i < templen; i++){
	              result = result+addStr;
	        }
		}
        
        return result;
    }
	
	public String Lpad(String str, int len, String addStr) {
		
		//입력받은 문자열의 빈칸이 있는지 체크후 처리한다. by top3009
		str = str.trim();
		
		byte[] bytTemp = null;
		int realLength = 0;
		
		try {
			bytTemp = str.getBytes("EUC-KR");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		int iLength = bytTemp.length;
		
		
		for(int iIndex = 0; iIndex < iLength; iIndex++) {
			
			int iChar = (int)bytTemp[iIndex];
			
			if((iChar > 127)|| (iChar < 0)) {
				
				iIndex++;
				realLength++;
			}
			
			realLength++;
		}
		
		
		String result = str;
		int templen   = len - realLength; //result.length()
		
		for (int i = 0; i < templen; i++){
			result = addStr + result;
		}
		
		return result;
	}
	
	
	/*
	*********************************************************
	* Program ID	: Suit18ListSmsExc
	* Program Name	: Suit18ListSmsExc
	* Description	: 삼성 적부 보고서 문자 로그 엑셀다운
	* Author		: 이선형
	* Date			: 2016.09.27.
	*  
	*********************************************************
	*/
	@RequestMapping(value = "Suit18ListSmsExc", method = RequestMethod.GET)
	public String Suit18ListSmsExc(Model model, String sDay, String eDay, HttpServletResponse response,HttpSession session) { //param
		
		HashMap<String,String> map = new HashMap<String, String>();
		map.put("sDay", sDay);
		map.put("eDay", eDay);
		
		/*적부 목록 정보*/
		List<SuimSuit_18VO> suimSuit_18List = sqlSession.selectList("Suit18Mapper.getSuit18List", map);
		
		for (int i = 0; i < suimSuit_18List.size(); i++) {
			
			/*SMS 기록 추출*/
			String suim_rpt_no  = suimSuit_18List.get(i).getSuimRptNo();
			
			List<SuimSuit_18_SmsVO> samsungSmsList = sqlSession.selectList("Suit18Mapper.getSmsList",suim_rpt_no);
			

			int conCnt1 =0;
			int conCnt2 =0;
			int timeDiffer = 0;
			
			for (int j = 0; j < samsungSmsList.size(); j++) {
				if(samsungSmsList.get(j).getSmsType().equals("1")){
					conCnt1++;
					suimSuit_18List.get(i).setMsg1(samsungSmsList.get(j).getrMsg());
					suimSuit_18List.get(i).setsDate1(samsungSmsList.get(j).getsDate());
				}
				
				if(samsungSmsList.get(j).getSmsType().equals("2")){
					conCnt2++;
					suimSuit_18List.get(i).setMsg2(samsungSmsList.get(j).getrMsg());
					suimSuit_18List.get(i).setsDate2(samsungSmsList.get(j).getsDate());
				}
			}
			
			suimSuit_18List.get(i).setConCnt1(Integer.toString(conCnt1));
			suimSuit_18List.get(i).setConCnt2(Integer.toString(conCnt2));
			
		}

		/*오늘날자구하기*/
		Date today = new Date();
		DateFormat timeForNaming = new SimpleDateFormat("yyyyMMddHHmmss");
		String filename = "삼성_SMS_로그";//String형으로 변환
		
		try {
			filename = java.net.URLEncoder.encode(filename,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		response.setHeader("Content-Disposition", "attachment;filename="+filename+".xls");
		response.setHeader("Content-Description", "JSP Generated Data");
		

		model.addAttribute("suimSuit_18List", suimSuit_18List);
		return "top_suit/suit18_rpt_sms_exc";	
		
	}	
}
