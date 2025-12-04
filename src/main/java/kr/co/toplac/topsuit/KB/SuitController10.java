package kr.co.toplac.topsuit.KB;

import java.io.File;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

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

import kr.co.toplac.topsuim.SuimRegInsController;
import kr.co.toplac.topsuit.SuimSuit_10VO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.page.PageUtilityBasic;

@Controller
public class SuitController10 {
	@Autowired
	private SqlSession sqlSession;
	
	private static final Logger logger = LoggerFactory.getLogger(SuitController10.class);
	
	/*
	*********************************************************
	* Program ID	: suitList10
	* Program Name	: suitList10
	* Description	: KB 적부 리스트
	* Author		: 이선형
	* Date			: 2016.09.06.
	*  
	*********************************************************
	*/
	@RequestMapping(value = "suitList10", method = RequestMethod.GET)
	public String suitList10(Model model, HttpSession session, String reqPgNo, String src) {

		logger.info("======= suitList10 =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		/*로그인 정보 유지 여부 확인*/
		if( (mbrAuthVo == null) || (session.getAttribute("user_no_Session") == null) ){
			logger.info("suitList10 - no session information ");
			session.invalidate();
			model.addAttribute("authFlag", "logout");
			return "top_suit/suit_book_list_10";
		}

		PageUtilityBasic pageUtil = new PageUtilityBasic();
			
		List<SuimSuit_10VO> suitList10
		= (List<SuimSuit_10VO>) pageUtil.pageBasic1(1, sqlSession, "Suit10Mapper.getSuitList10", reqPgNo, model, "suitList10");			
		
		int rowNum = sqlSession.selectOne("Suit10Mapper.cntRpt");
		
		if(reqPgNo == null || reqPgNo.equals("")){
			reqPgNo = "1";
		}
		
		int j=0;
		for (int i = rowNum-(18*(Integer.parseInt(reqPgNo)-1)) ; i > (rowNum-(18*(Integer.parseInt(reqPgNo)-1)) - suitList10.size() ); i--) {
			
			suitList10.get(j).setROWNUM(Integer.toString(i));
			j++;
		}
		
		model.addAttribute("rowNum", rowNum);
		model.addAttribute("mbrAuthVo", mbrAuthVo);
		model.addAttribute("suitList10", suitList10);

		return "top_suit/suit_book_list_10";
	}//suimBookList
	
	/*
	*********************************************************
	* Program ID	: suit10ListSrced
	* Program Name	: suit10ListSrced
	* Description	: KB 적부 리스트 ( 검색 결과 )
	* Author		: 이선형
	* Date			: 2016.09.19.
	*  
	*********************************************************
	*/
	@RequestMapping(value = "suit10ListSrced", method = RequestMethod.GET)
	public String suit10ListSrced(Model model, HttpSession session, String reqPgNo, String sDay, String eDay) {

		logger.info("======= suitList10 =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		/*로그인 정보 유지 여부 확인*/
		if( (mbrAuthVo == null) || (session.getAttribute("user_no_Session") == null) ){
			logger.info("suitList10 - no session information ");
			session.invalidate();
			model.addAttribute("authFlag", "logout");
			return "top_suit/suit_book_list_10";
		}

		HashMap<String,Object> map = new HashMap<String, Object>();
		
		map.put("sDay", sDay);
		map.put("eDay", eDay);
		
		PageUtilityBasic pageUtil = new PageUtilityBasic();
			
		List<SuimSuit_10VO> suitList10
		= (List<SuimSuit_10VO>) pageUtil.pageBasic1Search(1, sqlSession, "Suit10Mapper.getSuitList10Srced", reqPgNo, model, "suit10ListSrced",map);			
		
		int rowNum = sqlSession.selectOne("Suit10Mapper.cntRptSrc",map);
		
		if(reqPgNo == null || reqPgNo.equals("")){
			reqPgNo = "1";
		}
		
		int j=0;
		for (int i = rowNum-(18*(Integer.parseInt(reqPgNo)-1)) ; i > (rowNum-(18*(Integer.parseInt(reqPgNo)-1)) - suitList10.size() ); i--) {
			
			suitList10.get(j).setROWNUM(Integer.toString(i));
			j++;
		}
		
		model.addAttribute("rowNum", rowNum);
		model.addAttribute("mbrAuthVo", mbrAuthVo);
		model.addAttribute("suitList10", suitList10);
		model.addAttribute("sDay", sDay);
		model.addAttribute("eDay", eDay);

		return "top_suit/suit_book_list_10";
	}//suimBookList
	
	
	
	
	/*
	*********************************************************
	* Program ID	: popSuit10Dtl
	* Program Name	: popSuit10Dtl
	* Description	: 수임대장 리스트
	* Author		: 이선형
	* Date			: 2016.09.06.
	*  
	*********************************************************
	*/
	@RequestMapping(value = "popSuit10Dtl", method = RequestMethod.GET)
	public String popSuit10Dtl(Model model, HttpSession session, String suim_rpt_no) {

		logger.info("======= popSuit10Dtl =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		/*로그인 정보 유지 여부 확인*/
		if( (mbrAuthVo == null) || (session.getAttribute("user_no_Session") == null) ){
			logger.info("popSuit10Dtl - no session information ");
			session.invalidate();
			model.addAttribute("authFlag", "logout");
			return "top_suit/suit10_rpt_dtl_pop";
		}
		
		/*열람권한 추출*/
		HashMap<String,String> map = new HashMap<String,String>(); 
		map.put("suim_rpt_no", suim_rpt_no);
		map.put("user_no", (String)(session.getAttribute("user_no_Session")) );
		map.put("user_no_session", (String)(session.getAttribute("user_no_Session")) );
		
		/*SuimSuitController 적부 열람 권한 */
		//int suitReadYn = sqlSession.selectOne("SuimSuitMapper.getReadYn", map);

		SuimSuit_10VO suimSuit_10Vo = sqlSession.selectOne("Suit10Mapper.getOneOfSuit10", map);
		
		//model.addAttribute("suitReadYn", suitReadYn);
		model.addAttribute("mbrAuthVo", mbrAuthVo);
		model.addAttribute("mbrVo", mbrVo);
		
		//if(suitReadYn >= 1){
			model.addAttribute("suimSuit_10Vo", suimSuit_10Vo);			
		//}

		return "top_suit/suit10_rpt_dtl_pop";
	}//suimBookList
	
	/*
	*********************************************************
	* Program ID	: josaEditeOk
	* Program Name	: josaEditeOk
	* Description	: KB 적부 조사 내용 수정
	* Author		: 이선형
	* Date			: 2016.09.06.
	*  
	*********************************************************
	*/
	@RequestMapping(value = "josaEditeOk", method = RequestMethod.POST)
	public void josaEditeOk(Model model, SuimSuit_10VO suimSuit_10Vo, PrintWriter out) { //param
		
		int result = sqlSession.update("Suit10Mapper.udtJosa10", suimSuit_10Vo);
		
		out.print(result);
		
	}
	
	
	/*
	*********************************************************
	* Program ID	: rptEditePop
	* Program Name	: rptEditePop
	* Description	: KB 적부 보고서 내용 수정 화면 호출
	* Author		: 이선형
	* Date			: 2016.09.07.
	*  
	*********************************************************
	*/
	@RequestMapping(value = "rpt10EditePop", method = RequestMethod.GET)
	public String rpt10EditePop(Model model, String suim_rpt_no, HttpSession session) { //param
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("suim_rpt_no", suim_rpt_no);
		map.put("user_no_session", (String) session.getAttribute("user_no_Session"));
		
		SuimSuit_10VO suimSuit_10Vo = sqlSession.selectOne("Suit10Mapper.getOneOfSuit10", map);
		
		
		List<SuimSuit_10_FileVO> suimSuit_10_FileList = sqlSession.selectList("Suit10Mapper.getSuit10ImgList", suim_rpt_no);
		model.addAttribute("suimSuit_10Vo", suimSuit_10Vo);
		model.addAttribute("suimSuit_10Vo", suimSuit_10Vo);
		model.addAttribute("suimSuit_10_FileList", suimSuit_10_FileList);
		model.addAttribute("fileListSize", suimSuit_10_FileList.size());
		return "top_suit/suit10_rpt_udt_pop";
		
	}
	
	
	/*
	*********************************************************
	* Program ID	: suit10RptEditeOk
	* Program Name	: suit10RptEditeOk
	* Description	: KB 적부 보고서 내용 수정
	* Author		: 이선형
	* Date			: 2016.09.07.
	*  
	*********************************************************
	*/
	@RequestMapping(value = "suit10RptEditeOk", method = RequestMethod.POST)
	public void suit10RptEditeOk(Model model, SuimSuit_10VO suimSuit_10Vo, PrintWriter out) { //param
		
		int result = sqlSession.update("Suit10Mapper.udtRpt10", suimSuit_10Vo);
		
		out.print(result);
		
	}
	
	
	/*
	*********************************************************
	* Program ID	: suit10ImgDelOk
	* Program Name	: suit10ImgDelOk
	* Description	: KB 적부 보고서 이미지 삭제
	* Author		: 이선형
	* Date			: 2016.09.08.
	*  
	*********************************************************
	*/
	@RequestMapping(value = "suit10ImgDelOk", method = RequestMethod.POST)
	public void suit10ImgDelOk(Model model, String serialNo,String suimRptNo, PrintWriter out) { //param
		
		int result = 0;
		String path = "/home/hosting_users/toplac/www"+sqlSession.selectOne("Suit10Mapper.suimSuit10ImgPath", serialNo);
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
		
		sqlSession.delete("Suit10Mapper.delSuimSuit10Img", serialNo);
		
		out.print(result);
		
	}
	
	
	/*
	*********************************************************
	* Program ID	: josaEditeOk
	* Program Name	: josaEditeOk
	* Description	: KB 적부 보고서 wordDown
	* Author		: 이선형
	* Date			: 2016.09.09.
	*  
	*********************************************************
	*/
	@RequestMapping(value = "suit10Word", method = RequestMethod.GET)
	public String suit10Word(Model model, String suim_rpt_no, HttpServletResponse response, HttpSession session) { //param
		
		/*파일정보*/
		List<SuimSuit_10_FileVO> suimSuit_10_FileList = sqlSession.selectList("Suit10Mapper.getSuit10ImgList", suim_rpt_no);
		
		/*적부 한건 정보*/
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("suim_rpt_no", suim_rpt_no);
		map.put("user_no_session", (String) session.getAttribute("user_no_Session"));
		SuimSuit_10VO suimSuit_10Vo = sqlSession.selectOne("Suit10Mapper.getOneOfSuit10", map);
		
		/*팀정보*/
		String team_id = suimSuit_10Vo.getTeamId();
		TopTmBscVO topTmBscVo = sqlSession.selectOne("SuimRptBodyMapper.topTmInfoForBody", team_id);
		
		/*사원정보*/	
		String user_no = suimSuit_10Vo.getUserNo();
		TopMbrBscVO mbrVoForBody = sqlSession.selectOne("SuimRptBodyMapper.mbrinfo", user_no);
		
		/*오늘날자구하기*/
//		Date today = new Date();
//		DateFormat timeForNaming = new SimpleDateFormat("yyyyMMddHHmmss");
//		String filename = timeForNaming.format(today);//String형으로 변환
		//170124 적부파일명 - 적부번호로 변경, by lds.
		
		String filename = suimSuit_10Vo.getJuckbuNo();
		try {
			//적부번호로 파일명 변경
			
			filename = java.net.URLEncoder.encode(filename,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		response.setHeader("Content-Disposition", "attachment;filename="+filename+".doc");
		response.setHeader("Content-Description", "JSP Generated Data");

		model.addAttribute("suimSuit_10_FileList", suimSuit_10_FileList);
		model.addAttribute("suimSuit_10Vo", suimSuit_10Vo);
		model.addAttribute("topTmInfoForBody", topTmBscVo);
		model.addAttribute("mbrVoForBody", mbrVoForBody);

		return "top_suit/suit10_rpt_print_word";	
		
	}
	
	/*문자열 오른쪽 패딩 */
	public static String Rpad(String str, int len, String addStr) {
		
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
              result = result+addStr;
        }
        
        return result;
    }
	
	/*
	*********************************************************
	* Program ID	: suit10Rs
	* Program Name	: suit10Rs
	* Description	: KB 적부 보고서 응답 전문 txt 출력
	* Author		: 이선형
	* Date			: 2016.09.12.
	*  
	*********************************************************
	*/
	@RequestMapping(value = "suit10Rs", method = RequestMethod.GET)
	public String suit10Rs(Model model, String suim_rpt_no, HttpServletResponse response, HttpSession session) { //param
		
		/*적부 한건 정보*/
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("suim_rpt_no", suim_rpt_no);
		map.put("user_no_session", (String) session.getAttribute("user_no_Session"));
		SuimSuit_10VO suimSuit_10Vo = sqlSession.selectOne("Suit10Mapper.getOneOfSuit10", map);
		
		String reponseStr = "";
		String report3 = "";
		String report4 = "";
		String report5 = "";
		String report6 = "";
		String report7 = "";
		String report8 = "";
		String report9 = "";
		String report11 = "";
		String d2 = "";
		String d4 = "";
		String d6 = "";
		
		if(suimSuit_10Vo.getReport3() != null && suimSuit_10Vo.getReport3() != ""){
			switch (Integer.parseInt(suimSuit_10Vo.getReport3())) {
			case 1:
				report3 = "01";
				break;
			case 2:
				report3 = "02";
				break;
			case 9:
				report3 = "03";
				break;
			default:
				break;
			}
		}
		
		if(suimSuit_10Vo.getReport5() != null && suimSuit_10Vo.getReport5() != ""){
			switch (Integer.parseInt(suimSuit_10Vo.getReport5())) {
			case 1:
				report5 = "Y";
				break;
			case 2:
				report5 = "N";
				break;
			default:
				break;
			}
			
		}
		
		if(suimSuit_10Vo.getReport4() != null && suimSuit_10Vo.getReport4() != ""){
			switch (Integer.parseInt(suimSuit_10Vo.getReport4())) {
			case 1:
				report4 = "Y";
				break;
			case 2:
				report4 = "N";
				break;
			default:
				break;
			}
			
		}
		
		if(suimSuit_10Vo.getReport11() != null && suimSuit_10Vo.getReport11() != ""){
			switch (Integer.parseInt(suimSuit_10Vo.getReport11())) {
			case 1:
				report11 = "Y";
				break;
			case 2:
				report11 = "N";
				break;
			default:
				break;
			}
			
		}
		
		if(suimSuit_10Vo.getReport6() != null && suimSuit_10Vo.getReport6() != ""){
			switch (Integer.parseInt(suimSuit_10Vo.getReport6())) {
			case 1:
				report6 = "Y";
				break;
			case 2:
				report6 = "N";
				break;
			default:
				break;
			}
			
		}
		
		if(suimSuit_10Vo.getReport7() != null && suimSuit_10Vo.getReport7() != ""){
			
			switch (Integer.parseInt(suimSuit_10Vo.getReport7())) {
			case 1:
				report7 = "Y";
				break;
			case 2:
				report7 = "N";
				break;
			default:
				break;
			}
			
		}
		
		if(suimSuit_10Vo.getReport8() != null && suimSuit_10Vo.getReport8() != ""){
			switch (Integer.parseInt(suimSuit_10Vo.getReport8())) {
			case 1:
				report8 = "Y";
				break;
			case 2:
				report8 = "N";
				break;
			default:
				break;
			}
			
		}
		
		if(suimSuit_10Vo.getReport9() != null && suimSuit_10Vo.getReport9() != ""){
			switch (Integer.parseInt(suimSuit_10Vo.getReport9())) {
			case 1:
				report9 = "Y";
				break;
			case 2:
				report9 = "N";
				break;
			default:
				break;
			}
			
		}
		
		if(suimSuit_10Vo.getD6() != null && suimSuit_10Vo.getD6() != ""){
			switch (Integer.parseInt(suimSuit_10Vo.getD6())) {
			case 1:
				d6 = "Y";
				break;
			case 0:
				d6 = "N";
				break;
			default:
				break;
			}
			
		}
		
		if(suimSuit_10Vo.getD2() != null && suimSuit_10Vo.getD2() != ""){
			switch (Integer.parseInt(suimSuit_10Vo.getD2())) {
			case 1:
				d2 = "Y";
				break;
			case 0:
				d2 = "N";
				break;
			default:
				break;
			}
			
		}
		
		if(suimSuit_10Vo.getD4() != null && suimSuit_10Vo.getD4() != ""){
			
			switch (Integer.parseInt(suimSuit_10Vo.getD4())) {
			case 1:
				d4 = "Y";
				break;
			case 0:
				d4 = "N";
				break;
			default:
				break;
			}
		}
		
		String floorType = "";
		
		if(!suimSuit_10Vo.getBdType().equals("03")){
			if(suimSuit_10Vo.getD8() != ""){
				floorType = "1층:"+suimSuit_10Vo.getD8();
			}
			if(suimSuit_10Vo.getD9() != ""){
				floorType = "/2층:"+suimSuit_10Vo.getD9();
			}
			if(suimSuit_10Vo.getD10() != ""){
				floorType = "/3층:"+suimSuit_10Vo.getD10();
			}
			if(suimSuit_10Vo.getD11() != ""){
				floorType = "/4층:"+suimSuit_10Vo.getD11();
			}
			if(suimSuit_10Vo.getD12() != ""){
				floorType = "/5층:"+suimSuit_10Vo.getD12();
			}
			if(suimSuit_10Vo.getD13() != ""){
				floorType = "/5층이상:"+suimSuit_10Vo.getD13();
			}
			
		}else{
			if(suimSuit_10Vo.getD8() != ""){
				floorType = "공정"+suimSuit_10Vo.getD8();
			}
			if(suimSuit_10Vo.getD9() != ""){
				floorType = "/생산품"+suimSuit_10Vo.getD9();
			}
		}
		
		reponseStr = "";
		
		reponseStr = Rpad(suimSuit_10Vo.getJuckbuNo().substring(0, 11),11," ")+";\n";
		reponseStr += suimSuit_10Vo.getB1()+";\n";
		reponseStr += suimSuit_10Vo.getBdType()+";\n";
		reponseStr += report3+";\n";
		reponseStr += suimSuit_10Vo.getReport2()+";\n";
		reponseStr += Rpad(suimSuit_10Vo.getUserName(),50-suimSuit_10Vo.getUserName().length()," ")+";\n";
		reponseStr += Rpad(suimSuit_10Vo.getHandphone(),13," ")+";\n";
		reponseStr += Rpad(suimSuit_10Vo.getB2(),50-suimSuit_10Vo.getB2().length()," ")+";\n";
		reponseStr += suimSuit_10Vo.getB2Code()+";\n";
		reponseStr += Rpad(suimSuit_10Vo.getB3(),13-suimSuit_10Vo.getB3().length()," ")+";\n";
		reponseStr += Rpad(suimSuit_10Vo.getBuildingAddr(),300-suimSuit_10Vo.getBuildingAddr().length()," ")+";\n";
		reponseStr += Rpad(report5,1," ")+";\n";
		reponseStr += Rpad(suimSuit_10Vo.getC5(),50-suimSuit_10Vo.getC5().length()," ")+";\n";
		reponseStr += Rpad(report4,1," ")+";\n";
		reponseStr += Rpad(suimSuit_10Vo.getC6(),300-suimSuit_10Vo.getC6().length()," ")+";\n";
		reponseStr += Rpad(report11,1," ")+";\n";
		reponseStr += Rpad(suimSuit_10Vo.getD16(),1," ")+";\n";
		reponseStr += Rpad(suimSuit_10Vo.getD1(),300-suimSuit_10Vo.getD1().length()," ")+";\n";
		reponseStr += Rpad(report6,1," ")+";\n";
		reponseStr += Rpad(suimSuit_10Vo.getC2(),150-suimSuit_10Vo.getC2().length()," ")+";\n";
		reponseStr += Rpad(report7,1," ")+";\n";
		reponseStr += Rpad(suimSuit_10Vo.getC3(),150-suimSuit_10Vo.getC3().length()," ")+";\n";
		reponseStr += Rpad(report8,1," ")+";\n";
		reponseStr += Rpad(d6,1," ")+";\n";
		reponseStr += Rpad(d2,1," ")+";\n";
		reponseStr += Rpad(suimSuit_10Vo.getD3(),150-suimSuit_10Vo.getD3().length()," ")+";\n";
		reponseStr += Rpad(d4,1," ")+";\n";
		reponseStr += Rpad(suimSuit_10Vo.getD5(),150-suimSuit_10Vo.getD5().length()," ")+";\n";
		reponseStr += Rpad(report9,1," ")+";\n";
		reponseStr += Rpad(suimSuit_10Vo.getD7(),300-suimSuit_10Vo.getD7().length()," ")+";\n";
		reponseStr += Rpad(suimSuit_10Vo.getD14(),300-suimSuit_10Vo.getD14().length()," ")+";\n";
		reponseStr += Rpad(floorType,300," ")+";\n";
		reponseStr += Rpad(suimSuit_10Vo.getReport10(),300-suimSuit_10Vo.getReport10().length()," ")+";\n";

		/*오늘날자구하기*/
		Date today = new Date();
		DateFormat timeForNaming = new SimpleDateFormat("yyyyMMdd");
		String filename = timeForNaming.format(today);//String형으로 변환
		
		try {
			filename = java.net.URLEncoder.encode(filename,"UTF-8").replaceAll("\\+", "_");
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		response.setHeader("Content-Disposition", "attachment;filename="+filename+"_01.txt");
		/*response.setHeader("Content-Description", "JSP Generated Data");*/
		response.setHeader("Content-Transfer-Encoding", "binary");

		model.addAttribute("reponseStr", reponseStr);

		return "top_suit/suit10_rpt_print_rs";	
		
	}
	
	/*
	*********************************************************
	* Program ID	: suit10RsList
	* Program Name	: suit10RsList
	* Description	: KB 적부 보고서 응답 전문 txt 출력
	* Author		: 이선형
	* Date			: 2016.09.19.
	*  
	*********************************************************
	*/
	@RequestMapping(value = "suit10RsList", method = RequestMethod.GET)
	public String suit10RsList(Model model, HttpServletResponse response, String sDay, String eDay) { //param
		
		HashMap<String,String> map = new HashMap<String, String>();
		map.put("sDay", sDay);
		map.put("eDay", eDay);

		/*적부 목록 정보*/
		List<SuimSuit_10VO> suimSuit_10List = sqlSession.selectList("Suit10Mapper.getSuit10ListForRs", map);
		
		String reponseStr = "";
		
		for (int i = 0; i < suimSuit_10List.size(); i++) {
			
			
			String report3 = "";
			String report4 = "";
			String report5 = "";
			String report6 = "";
			String report7 = "";
			String report8 = "";
			String report9 = "";
			String report11 = "";
			String d2 = "";
			String d4 = "";
			String d6 = "";
			
			if(suimSuit_10List.get(i).getReport3() != null && suimSuit_10List.get(i).getReport3() != ""){
				switch (Integer.parseInt(suimSuit_10List.get(i).getReport3())) {
				case 1:
					report3 = "01";
					break;
				case 2:
					report3 = "02";
					break;
				case 9:
					report3 = "03";
					break;
				default:
					break;
				}
			}
			
			if(suimSuit_10List.get(i).getReport5() != null && suimSuit_10List.get(i).getReport5() != ""){
				switch (Integer.parseInt(suimSuit_10List.get(i).getReport5())) {
				case 1:
					report5 = "Y";
					break;
				case 2:
					report5 = "N";
					break;
				default:
					break;
				}
				
			}
			
			if(suimSuit_10List.get(i).getReport4() != null && suimSuit_10List.get(i).getReport4() != ""){
				switch (Integer.parseInt(suimSuit_10List.get(i).getReport4())) {
				case 1:
					report4 = "Y";
					break;
				case 2:
					report4 = "N";
					break;
				default:
					break;
				}
				
			}
			
			if(suimSuit_10List.get(i).getReport11() != null && suimSuit_10List.get(i).getReport11() != ""){
				switch (Integer.parseInt(suimSuit_10List.get(i).getReport11())) {
				case 1:
					report11 = "Y";
					break;
				case 2:
					report11 = "N";
					break;
				default:
					break;
				}
				
			}
			
			if(suimSuit_10List.get(i).getReport6() != null && suimSuit_10List.get(i).getReport6() != ""){
				switch (Integer.parseInt(suimSuit_10List.get(i).getReport6())) {
				case 1:
					report6 = "Y";
					break;
				case 2:
					report6 = "N";
					break;
				default:
					break;
				}
				
			}
			
			if(suimSuit_10List.get(i).getReport7() != null && suimSuit_10List.get(i).getReport7() != ""){
				
				switch (Integer.parseInt(suimSuit_10List.get(i).getReport7())) {
				case 1:
					report7 = "Y";
					break;
				case 2:
					report7 = "N";
					break;
				default:
					break;
				}
				
			}
			
			if(suimSuit_10List.get(i).getReport8() != null && suimSuit_10List.get(i).getReport8() != ""){
				switch (Integer.parseInt(suimSuit_10List.get(i).getReport8())) {
				case 1:
					report8 = "Y";
					break;
				case 2:
					report8 = "N";
					break;
				default:
					break;
				}
				
			}
			
			if(suimSuit_10List.get(i).getReport9() != null && suimSuit_10List.get(i).getReport9() != ""){
				switch (Integer.parseInt(suimSuit_10List.get(i).getReport9())) {
				case 1:
					report9 = "Y";
					break;
				case 2:
					report9 = "N";
					break;
				default:
					break;
				}
				
			}
			
			if(suimSuit_10List.get(i).getD6() != null && suimSuit_10List.get(i).getD6() != ""){
				switch (Integer.parseInt(suimSuit_10List.get(i).getD6())) {
				case 1:
					d6 = "Y";
					break;
				case 0:
					d6 = "N";
					break;
				default:
					break;
				}
				
			}
			
			if(suimSuit_10List.get(i).getD2() != null && suimSuit_10List.get(i).getD2() != ""){
				switch (Integer.parseInt(suimSuit_10List.get(i).getD2())) {
				case 1:
					d2 = "Y";
					break;
				case 0:
					d2 = "N";
					break;
				default:
					break;
				}
				
			}
			
			if(suimSuit_10List.get(i).getD4() != null && suimSuit_10List.get(i).getD4() != ""){
				
				switch (Integer.parseInt(suimSuit_10List.get(i).getD4())) {
				case 1:
					d4 = "Y";
					break;
				case 0:
					d4 = "N";
					break;
				default:
					break;
				}
			}
			
			
			String floorType = "";
			
			if(!suimSuit_10List.get(i).getBdType().equals("03")){
				if(suimSuit_10List.get(i).getD8() != ""){
					floorType = "1층:"+suimSuit_10List.get(i).getD8();
				}
				if(suimSuit_10List.get(i).getD9() != ""){
					floorType = "/2층:"+suimSuit_10List.get(i).getD9();
				}
				if(suimSuit_10List.get(i).getD10() != ""){
					floorType = "/3층:"+suimSuit_10List.get(i).getD10();
				}
				if(suimSuit_10List.get(i).getD11() != ""){
					floorType = "/4층:"+suimSuit_10List.get(i).getD11();
				}
				if(suimSuit_10List.get(i).getD12() != ""){
					floorType = "/5층:"+suimSuit_10List.get(i).getD12();
				}
				if(suimSuit_10List.get(i).getD13() != ""){
					floorType = "/5층이상:"+suimSuit_10List.get(i).getD13();
				}
				
			}else{
				if(suimSuit_10List.get(i).getD8() != ""){
					floorType = "공정"+suimSuit_10List.get(i).getD8();
				}
				if(suimSuit_10List.get(i).getD9() != ""){
					floorType = "/생산품"+suimSuit_10List.get(i).getD9();
				}
			}
			
			reponseStr += Rpad(suimSuit_10List.get(i).getJuckbuNo().substring(0, 11),11," ")+";";
			reponseStr += suimSuit_10List.get(i).getB1()+";";
			reponseStr += suimSuit_10List.get(i).getBdType()+";";
			reponseStr += report3+";";
			reponseStr += suimSuit_10List.get(i).getReport2()+";";
			//reponseStr += Rpad(suimSuit_10List.get(i).getUserName(),50-suimSuit_10List.get(i).getUserName().length()," ")+";";
			reponseStr += Rpad(suimSuit_10List.get(i).getUserName(),50," ")+";";
			reponseStr += Rpad(suimSuit_10List.get(i).getHandphone(),13," ")+";";
			reponseStr += Rpad(suimSuit_10List.get(i).getB2(),50," ")+";";
			reponseStr += suimSuit_10List.get(i).getB2Code()+";";
			reponseStr += Rpad(suimSuit_10List.get(i).getB3(),13," ")+";";
			reponseStr += Rpad(suimSuit_10List.get(i).getBuildingAddr(),300," ")+";";
			reponseStr += Rpad(report5,1," ")+";";
			reponseStr += Rpad(suimSuit_10List.get(i).getC5(),50," ")+";";
			reponseStr += Rpad(report4,1," ")+";";
			reponseStr += Rpad(suimSuit_10List.get(i).getC6(),300," ")+";";
			reponseStr += Rpad(report11,1," ")+";";
			reponseStr += Rpad(suimSuit_10List.get(i).getD16(),1," ")+";";
			reponseStr += Rpad(suimSuit_10List.get(i).getD1(),300," ")+";";
			reponseStr += Rpad(report6,1," ")+";";
			reponseStr += Rpad(suimSuit_10List.get(i).getC2(),150," ")+";";
			reponseStr += Rpad(report7,1," ")+";";
			reponseStr += Rpad(suimSuit_10List.get(i).getC3(),150," ")+";";
			reponseStr += Rpad(report8,1," ")+";";
			reponseStr += Rpad(d6,1," ")+";";
			reponseStr += Rpad(d2,1," ")+";";
			reponseStr += Rpad(suimSuit_10List.get(i).getD3(),150," ")+";";
			reponseStr += Rpad(d4,1," ")+";";
			reponseStr += Rpad(suimSuit_10List.get(i).getD5(),150," ")+";";
			reponseStr += Rpad(report9,1," ")+";";
			reponseStr += Rpad(suimSuit_10List.get(i).getD7(),300," ")+";";
			reponseStr += Rpad(suimSuit_10List.get(i).getD14(),300," ")+";";
			reponseStr += Rpad(floorType,300," ")+";";
			reponseStr += Rpad(suimSuit_10List.get(i).getReport10(),300," ")+";";
			reponseStr += "\n";
		}
		
		/*응답전문 내보낸 건들 락걸기*/
		sqlSession.update("Suit10Mapper.suit10lockAfterRsPrint",map);

		/*오늘날자구하기*/
		Date today = new Date();
		DateFormat timeForNaming = new SimpleDateFormat("yyyyMMdd");
		String filename = timeForNaming.format(today);//String형으로 변환
		
		
		try {
			filename = java.net.URLEncoder.encode(filename,"UTF-8").replaceAll("\\+", "_");
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		response.setHeader("Content-Disposition", "attachment;filename="+filename+"_01.txt");
		/*response.setHeader("Content-Description", "JSP Generated Data");*/
		response.setHeader("Content-Transfer-Encoding", "binary");

		model.addAttribute("reponseStr", reponseStr);

		return "top_suit/suit10_rpt_print_rs";	
		
	}
	
	
	/*
	*********************************************************
	* Program ID	: actionSuit10ReportOk
	* Program Name	: actionSuit10ReportOk
	* Description	: KB 적부 보고서 상태 값 변경
	* Author		: 이선형
	* Date			: 2016.09.12.
	*  
	*********************************************************
	*/
	@RequestMapping(value = "actionSuit10ReportOk", method = RequestMethod.POST)
	public void actionSuit10ReportOk(Model model, String suimRptNo, String action,  PrintWriter out) { //param
		
		int result = 0;
		
		/*결재하기 시작*/
		if(action.equals("submit")){
			
			result = sqlSession.update("Suit10Mapper.actionSubmit",suimRptNo);
		}else if(action.equals("submit_x")){
			
			result = sqlSession.update("Suit10Mapper.actionSubmit_X",suimRptNo);
		}else if(action.equals("returnRpt")){
			
			result = sqlSession.update("Suit10Mapper.actionReturnRpt",suimRptNo);
		}else if(action.equals("return_x")){
			
			result = sqlSession.update("Suit10Mapper.actionReturnRpt_X",suimRptNo);
		}else if(action.equals("end")){
			
			/*날짜 계산*/
			Calendar cal = Calendar.getInstance();    
			cal.setTime(new Date());  
			
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
			String suimDay = df.format(cal.getTime());  
			
			/*접수번호 앞자리의 연도 YY + 월 MM*/
			String suimYear = suimDay.substring(2, 4);
			String suimMonth = suimDay.substring(5, 7);
			
			String todayCloseFront = "TJE"+suimYear+suimMonth;
			
			String nextCloseNo = sqlSession.selectOne("Suit10Mapper.getNextCloseNoForSuit10", todayCloseFront);
			
			if(nextCloseNo == null || nextCloseNo.equals("")){
				nextCloseNo = "0001";
    		}else{
    			nextCloseNo = SuimRegInsController.makeFourNumberWithZero(nextCloseNo);
    			//acceptNo = String.format("%04d", acceptNo);			    			
    		}
			
			nextCloseNo = todayCloseFront+"-"+nextCloseNo;
			
			HashMap<String,String> map = new HashMap<String,String>();
			map.put("nextCloseNo", nextCloseNo);
			map.put("suimRptNo", suimRptNo);
			
			result = sqlSession.update("Suit10Mapper.actionSubmit_E",map);
			
		}else if(action.equals("submit_e_x")){ // 종결 취소하기
			
			result = sqlSession.update("Suit10Mapper.actionSubmit_E_X",suimRptNo);
			
		}else if(action.equals("cancel")){ // 위임 취소하기
			
			result = sqlSession.update("Suit10Mapper.actionCancel",suimRptNo);
			
		}else if(action.equals("cancel_x")){ // 위임 취소하기
			
			result = sqlSession.update("Suit10Mapper.actionCancel_X",suimRptNo);
			
		}else if(action.equals("report_del")){ // 위임 취소를
			
			result = sqlSession.update("Suit10Mapper.actionDel",suimRptNo);
		}
	
		
		out.print(result);
	}
	
	
}
