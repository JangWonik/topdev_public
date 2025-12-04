package kr.co.toplac.topsuim;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

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

@Controller
public class SuimRptNowController {
	
private static final Logger logger = LoggerFactory.getLogger(SuimRptNowController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	/*
	 * ***************************************
	 * Method ID : nowRptIns
	 * Method Name :  nowRptIns
	 * Description : 보고서 상세 화면에서 현재 진행 상황 입력 동작
	 * 
	 * 번호 1 :  
	 * Author : 이선형
	 * Date : 20160525
	 * ***************************************
	 * */
	@RequestMapping(value = "nowRptIns", method = RequestMethod.POST)
	public void nowRptIns(Model model, HttpSession session, SuimRptNowBscVO suimRptNowBscVo, HttpServletResponse response) {
		
		logger.info("nowRptIns");
		
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
		
		JSONArray arr = new JSONArray();
		
		JSONObject obj = new JSONObject();
		
		/*번호 1*/
		int result = sqlSession.insert("RptNowBscMapper.rptNowIns", suimRptNowBscVo );
		String nowNo = sqlSession.selectOne("RptNowBscMapper.getJustNowNo", suimRptNowBscVo.getSuimRptNo());

		if(result >0){
			
			obj.put("regDate", suimRptNowBscVo.getRegDate());
			obj.put("content", suimRptNowBscVo.getContent());
			obj.put("closePrarnDate", suimRptNowBscVo.getClosePrarnDate());
			obj.put("nowNo", nowNo);
			
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
	 * Method ID : nowRptUdt
	 * Method Name :  nowRptUdt
	 * Description : 보고서 상세 화면에서 현재 진행 상황 수정
	 * 
	 * 번호 1 :  
	 * Author : 이선형
	 * Date : 20160525
	 * ***************************************
	 * */
	@RequestMapping(value = "nowRptUdt", method = RequestMethod.POST)
	public void nowRptUdt(Model model, HttpSession session, SuimRptNowBscVO suimRptNowBscVo, HttpServletResponse response) {
		
		logger.info("nowRptUdt");
		
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
		
		JSONArray arr = new JSONArray();
		
		JSONObject obj = new JSONObject();
		
		/*번호 1*/
		int result = sqlSession.update("RptNowBscMapper.rptNowUdt", suimRptNowBscVo );

		if(result >0){
			
			obj.put("regDate", suimRptNowBscVo.getRegDate());
			obj.put("content", suimRptNowBscVo.getContent());
			obj.put("nowNo", suimRptNowBscVo.getNowNo());
			obj.put("closePrarnDate", suimRptNowBscVo.getClosePrarnDate());

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
	 * Method ID : nowRptDel
	 * Method Name :  nowRptDel
	 * Description : 현재 진행 상황 삭제
	 * 번호 1 : 테이블 삭제
	 * Author : 이선형
	 * Date : 20160525
	 * ***************************************
	 * */
	@RequestMapping(value = "nowRptDel", method = RequestMethod.POST)
	public void nowRptDel(Model model, HttpSession session, String nowNo, PrintWriter out) {
		
		logger.info("nowRptDel");
	
		/*번호 1*/
		int result = sqlSession.update("RptNowBscMapper.rptNowDel", nowNo);

		out.print(result);
		out.close();
	}
}
