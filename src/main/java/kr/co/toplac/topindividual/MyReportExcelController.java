/*
*********************************************************
* Program ID	: PrimbizSuimListController
* Program Name	: PrimbizSuimListController
* Description	: 농작물 수임대장 리스트
* Author		: 
* Date			: 2016.06.09.
*********************************************************
*/
package kr.co.toplac.topindividual;

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

import kr.co.toplac.topsuit17.SuimSuit_17VO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.page.PageUtilityBasic;

@Controller
public class MyReportExcelController {

	private static final Logger logger = LoggerFactory.getLogger(MyReportExcelController.class);

	@Autowired
	private SqlSession sqlSession;

	/*
	*********************************************************
	* Program ID	: MyReportExcel
	* Program Name	: MyReportExcel
	* Description	: 나의미결현황
	* Author		: 
	* Date			: 2016.09.01.
	*********************************************************
	*/
	@RequestMapping(value = "/myReportExcel", method = RequestMethod.GET)
	public String myReportExcel(Model model, HttpSession session, HttpServletResponse response, MyReportExcelVO myreportVO, String reqPgNo) {

		logger.info("======= myReportExcel =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("myReportExcel - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		Calendar today = Calendar.getInstance();
		int dateInt = today.get(Calendar.DATE);
		int monthInt = today.get(Calendar.MONTH) + 1;
		int yearInt = today.get(Calendar.YEAR);
		
		String todate = (""+ yearInt) +"-"+ (""+ monthInt) +"-"+ (""+ dateInt);
		
		/*로그인 유저의 세션 정보 추출 시작*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		model.addAttribute("mbrAuthSessionVo", mbrAuthVo);
		model.addAttribute("mbrVo",mbrVo);
		String user_no = (String) session.getAttribute("user_no_Session");
		String team_name = mbrVo.getTeam_name();
		String user_name = mbrVo.getUser_name();
		/*로그인 유저의 세션 정보 추출 끝*/
		//System.out.println(team_name + ":team_name");
		//System.out.println(todate + ":todate");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("user_no", user_no);
		
		List<MyReportExcelVO> getMyReportExcel = sqlSession.selectList("MyReportExcel.getMyReportExcel", map);

		model.addAttribute("getMyReportExcel", getMyReportExcel);
		model.addAttribute("team_name", team_name);
		model.addAttribute("todate", todate);
		
		String filename = user_name+todate+"미결현황";
		try {
			filename = java.net.URLEncoder.encode(filename,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		response.setHeader("Content-Disposition", "attachment;filename="+filename+".xls");
		response.setHeader("Content-Description", "JSP Generated Data");
		/*int udtSuimSuit17Lock = sqlSession.update("SuimSuit17ListMapper.udtSuimSuit17Lock", map);
		model.addAttribute("udtSuimSuit17Lock", udtSuimSuit17Lock);*/
		
		return "top_individual/my_report_excel";
	}
	
	
	

}//end of class
