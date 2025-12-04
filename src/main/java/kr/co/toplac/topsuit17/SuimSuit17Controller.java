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

import java.io.BufferedOutputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.WebUtil;
import kr.co.toplac.util.etc.Damo;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.topsuit17.SuimSuit_17VO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.page.PageUtilityBasic;

@Controller
public class SuimSuit17Controller {

	private static final Logger logger = LoggerFactory.getLogger(SuimSuit17Controller.class);
 
	//private static final String SVR_TR_PATH = "/home/hosting_users/toplac/www/ls_contract/tmp/";
    //private static final String SVR_TR_PATH = "/Users/kohyeonseok/devroot/91.devUpload/toplac/hosting_users/toplac/www/ls_contract/tmp/";

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
	@RequestMapping(value = "topSuimSuit17List", method = RequestMethod.GET)
	public String topSuimSuit17List(Model model, HttpSession session, String reqPgNo, SuimSuit_17VO dtlVO) {

		logger.info("======= topSuimSuit17List =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("topSuimSuit17List - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		/*로그인 유저의 세션 정보 추출 시작*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		model.addAttribute("mbrAuthSessionVo", mbrAuthVo);
		model.addAttribute("mbrVo",mbrVo);
		/*로그인 유저의 세션 정보 추출 끝*/

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("viewFromDate", dtlVO.getViewFromDate());
		map.put("viewToDate", dtlVO.getViewToDate());

		PageUtilityBasic pageUtil = new PageUtilityBasic();
		List<SuimSuit_17VO> suimSuit17List
			= (List<SuimSuit_17VO>) pageUtil.pageBasic1Search(1, sqlSession, "SuimSuit17ListMapper.getSuimSuit17List", reqPgNo, model, "topSuimSuit17List", map);

		model.addAttribute("suimSuit17List", suimSuit17List);
		model.addAttribute("viewFromDate", dtlVO.getViewFromDate());
		model.addAttribute("viewToDate", dtlVO.getViewToDate());

		return "top_suim_suit17/top_suim_suit17_list";
	}//primbizSuimList
	
	@RequestMapping(value = "/topSuimSuit17List_Excel", method = RequestMethod.GET)
	public String topSuimSuit17List_Excel(Model model, HttpSession session, HttpServletResponse response, SuimSuit_17VO dtlVO, String reqPgNo) {

		logger.info("======= topSuimSuit17List_Excel =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("topSuimSuit17List_Excel - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		/*로그인 유저의 세션 정보 추출 시작*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		model.addAttribute("mbrAuthSessionVo", mbrAuthVo);
		model.addAttribute("mbrVo",mbrVo);
		/*로그인 유저의 세션 정보 추출 끝*/
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("viewFromDate", dtlVO.getViewFromDate());
		map.put("viewToDate", dtlVO.getViewToDate());
		
		List<SuimSuit_17VO> getSuimSuit17ListExcel = sqlSession.selectList("SuimSuit17ListMapper.getSuimSuit17ListExcel", map);

		model.addAttribute("getSuimSuit17ListExcel", getSuimSuit17ListExcel);
		
		/*int udtSuimSuit17Lock = sqlSession.update("SuimSuit17ListMapper.udtSuimSuit17Lock", map);
		model.addAttribute("udtSuimSuit17Lock", udtSuimSuit17Lock);*/
		
		return "top_suim_suit17/top_suim_suit17_list_excel";
	}
	
/*	@RequestMapping(value = "/topSuimSuit17List_Rs", method = RequestMethod.GET)
	public String topSuimSuit17List_Rs(Model model, HttpSession session, HttpServletResponse response, SuimSuit_17VO dtlVO, String reqPgNo) {

		logger.info("======= topSuimSuit17List_Rs =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("topSuimSuit17List_Rs - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		*//*로그인 유저의 세션 정보 추출 시작*//*
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		model.addAttribute("mbrAuthSessionVo", mbrAuthVo);
		model.addAttribute("mbrVo",mbrVo);
		*//*로그인 유저의 세션 정보 추출 끝*//*
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("viewFromDate", dtlVO.getViewFromDate());
		map.put("viewToDate", dtlVO.getViewToDate());
		
		List<SuimSuit_17VO> getSuimSuit17ListRs = sqlSession.selectList("SuimSuit17ListMapper.getSuimSuit17ListRs", map);
		model.addAttribute("getSuimSuit17ListRs", getSuimSuit17ListRs);
		
		int udtSuimSuit17Lock = sqlSession.update("SuimSuit17ListMapper.udtSuimSuit17Lock", map);
		model.addAttribute("udtSuimSuit17Lock", udtSuimSuit17Lock);
		
		*//*오늘날자구하기*//*
		*//*Date today = new Date();
		DateFormat timeForNaming = new SimpleDateFormat("yyyyMMdd");
		String filename = timeForNaming.format(today);//String형으로 변환
		model.addAttribute("filename", filename);
		
		try {
			filename = java.net.URLEncoder.encode(filename,"UTF-8").replaceAll("\\+", "_");
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		response.setHeader("Content-Disposition", "attachment;filename="+"흥국화재_적부_결과_"+filename+".xls");
		response.setHeader("Content-Type", "application/vnd.ms-xls");
		response.setHeader("Content-Description", "JSP Generated Data");
		response.setHeader("Content-Transfer-Encoding", "binary");*//*
		
		return "top_suim_suit17/top_suim_suit17_list_rs";
	}*/
	
	@RequestMapping(value = "/topSuimSuit17List_Rs", method = RequestMethod.GET)
	public void topSuimSuit17List_Rs(Model model, HttpSession session, HttpServletResponse response, SuimSuit_17VO dtlVO, String reqPgNo) throws Exception {

		logger.info("======= topSuimSuit17List_Rs =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		/*로그인 유저의 세션 정보 추출 시작*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		model.addAttribute("mbrAuthSessionVo", mbrAuthVo);
		model.addAttribute("mbrVo",mbrVo);
		/*로그인 유저의 세션 정보 추출 끝*/
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("viewFromDate", dtlVO.getViewFromDate());
		map.put("viewToDate", dtlVO.getViewToDate());
		
		List<SuimSuit_17VO> getSuimSuit17ListRs = sqlSession.selectList("SuimSuit17ListMapper.getSuimSuit17ListRs", map);
		model.addAttribute("getSuimSuit17ListRs", getSuimSuit17ListRs);
		
		int udtSuimSuit17Lock = sqlSession.update("SuimSuit17ListMapper.udtSuimSuit17Lock", map);
		model.addAttribute("udtSuimSuit17Lock", udtSuimSuit17Lock);
		
		Damo damo = new Damo();
		//===========================================================================
        //  보낼 데이터를 스트링으로 묶는다.
        //===========================================================================
		StringBuffer sb = new StringBuffer();
        
        for (SuimSuit_17VO vo : getSuimSuit17ListRs) {
            sb.append(vo.getReport1() + "|");       //조사완료여부
            sb.append(vo.getInfoA() + "|");         //설계번호
            sb.append(vo.getInfoM() + "|");         //물건구분명
            sb.append(vo.getReC() + "|");           //실사일자
            sb.append(vo.getUserName() + "|");      //실사자명
            sb.append(vo.getHandphone() + "|");     //실사자휴대전화번호
            sb.append(vo.getReF() + "|");           //책임자명
            sb.append(vo.getReG() + "|");           //건물급수확인사항
            sb.append(vo.getReH() + "|");           //건물급수일치여부
            sb.append(vo.getReI() + "|");           //가입업종확인사항
            sb.append(vo.getReJ() + "|");           //가입업종일치여부
            sb.append(vo.getReK() + "|");           //요율업종확인사항
            sb.append(vo.getReL() + "|");           //요율업종일치여부
            sb.append(vo.getInfoAa() + "|");        //소재지우편번호
            sb.append(vo.getInfoAb() + "|");        //소재지주소
            sb.append(damo.decodeDamo(vo.getInfoAc()) + "|");        //소재지기타주소(암호화 해제)
            sb.append(vo.getReP() + "|");           //소재지일치여부
            sb.append(vo.getReQ() + "|");           //소유자확인사항
            sb.append(vo.getReR() + "|");           //소유자일치여부
            sb.append(WebUtil.removeCRLF(vo.getInfoAe()) + "|");        //중점요청사항
            sb.append(vo.getReT() + "|");           //중점요청사항일치여부
            sb.append(vo.getReU() + "|");           //구조건물구조조사의견
            sb.append(vo.getReV() + "|");           //구조방화구획조사의견
            sb.append(vo.getReW() + "|");           //구조확인의견
            sb.append(vo.getReX() + "|");           //업종일반층별업종조사의견
            sb.append(vo.getReY() + "|");           //업종일반확인의견
            sb.append(vo.getReZ() + "|");           //업종공장공정조사의견
            sb.append(vo.getReAa() + "|");          //업종공장생산품조사의견
            sb.append(vo.getReAb() + "|");          //업종공장확인의견
            sb.append(vo.getReAc() + "\n");         //소재지확인의견
        }
        
        //===========================================================================
        // 파일을 내려준다.
        //===========================================================================
        String fileName = DateUtil.getTodayString() + "_TOPRES.txt";
        String mimetype = "application/x-msdownload";
        
        response.setContentType(mimetype);
        response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(fileName, "UTF-8") + "\"");
        
        
        BufferedOutputStream bos = null;
        bos = new BufferedOutputStream(response.getOutputStream());
        //UTF-8 BOM BOM 제거
        bos.write(sb.toString().replace("\uFEFF", "").getBytes("EUC-KR"));
        
        bos.flush();
        bos.close();

	}
	

}//end of class
