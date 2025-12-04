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

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

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

import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.page.PageUtilityBasic;

@Controller
public class SuimSuit12Controller {

	private static final Logger logger = LoggerFactory.getLogger(SuimSuit12Controller.class);

	@Autowired
	private SqlSession sqlSession;

	/*
	*********************************************************
	* Program ID	: suimSuit12List
	* Program Name	: suimSuit12List
	* Description	: 적부(한화) 리스트
	* Author		: 
	* Date			: 2016.09.01.
	*********************************************************
	*/
	@RequestMapping(value = "topSuimSuit12List", method = RequestMethod.GET)
	public String topSuimSuit12List(Model model, HttpSession session, String reqPgNo, SuimSuit_12VO dtlVO) {

		logger.info("======= topSuimSuit12List =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("topSuimSuit12List - no permession user_no : "+session.getAttribute("user_no_Session"));
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
		List<SuimSuit_12VO> suimSuit12List
			= (List<SuimSuit_12VO>) pageUtil.pageBasic1Search(1, sqlSession, "SuimSuit12ListMapper.getSuimSuit12List", reqPgNo, model, "topSuimSuit12List", map);
		
		//쿼리 속도 개선을 위해 처리 지연일수 계산을 별도처리 시작 (getDateDiff 함수 별도처리)
		int nPastDate = 0;
		String sCloseDate = "";		
		
		for( int i=0; i < suimSuit12List.size(); i++) {
			sCloseDate = suimSuit12List.get(i).getCloseDate();
			if( "0".equals(sCloseDate)) {		//종결되지 않은경우 지연일수를 계산한다.				
				nPastDate = sqlSession.selectOne("HolidayMapper.countWorkDay", suimSuit12List.get(i).getRegDateFmt());
				suimSuit12List.get(i).setPastDate(String.valueOf(nPastDate));
			}
		}
		//쿼리 속도 개선을 위해 처리 지연일수 계산을 별도처리 끝 (getDateDiff 함수 별도처리)

		model.addAttribute("suimSuit12List", suimSuit12List);
		model.addAttribute("viewFromDate", dtlVO.getViewFromDate());
		model.addAttribute("viewToDate", dtlVO.getViewToDate());

		return "top_suim_suit12/top_suim_suit12_list";
	}//primbizSuimList
	
	@RequestMapping(value = "/topSuimSuit12List_Excel", method = RequestMethod.GET)
	public String topSuimSuit12List_Excel(Model model, HttpSession session, HttpServletResponse response, SuimSuit_12VO dtlVO, String reqPgNo) {

		logger.info("======= topSuimSuit12List_Excel =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("topSuimSuit12List_Excel - no permession user_no : "+session.getAttribute("user_no_Session"));
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
		
		List<SuimSuit_12VO> getSuimSuit12ListExcel = sqlSession.selectList("SuimSuit12ListMapper.getSuimSuit12ListExcel", map);
		
		//쿼리 속도 개선을 위해 처리 지연일수 계산을 별도처리 시작 (getDateDiff 함수 별도처리)
		int nPastDate = 0;
		String sCloseDate = "";		
		
		for( int i=0; i < getSuimSuit12ListExcel.size(); i++) {
			sCloseDate = getSuimSuit12ListExcel.get(i).getCloseDate();
			if( "0".equals(sCloseDate)) {		//종결되지 않은경우 지연일수를 계산한다.				
				nPastDate = sqlSession.selectOne("HolidayMapper.countWorkDay", getSuimSuit12ListExcel.get(i).getRegDateFmt());
				getSuimSuit12ListExcel.get(i).setPastDate(String.valueOf(nPastDate));
			}
		}
		//쿼리 속도 개선을 위해 처리 지연일수 계산을 별도처리 끝 (getDateDiff 함수 별도처리)

		//int udtSuimSuit12Lock = sqlSession.update("SuimSuit12ListMapper.udtSuimSuit12Lock", map);
		model.addAttribute("getSuimSuit12ListExcel", getSuimSuit12ListExcel);
		
		return "top_suim_suit12/top_suim_suit12_list_excel";
	}

}//end of class
