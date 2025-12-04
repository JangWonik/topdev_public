package kr.co.toplac.sysadm;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.memo.MemoUtilViewVO;
import kr.co.toplac.util.memo.TopRptMemoVO;

@Controller
public class HolidayController {

	@Autowired
	private SqlSession sqlSession;

	private static final Logger logger = LoggerFactory.getLogger(HolidayController.class);

	@RequestMapping(value = "/holidayPan", method = RequestMethod.GET)
	public String holidayPan(Model model, HttpSession session, HolidayViewVO inVO) {

		logger.info("holidayPan");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("holidayPan - no permession user_no : "+mbrVo.getUser_no());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		if(inVO.getSelectMonth() == null || inVO.getSelectMonth().equals("")){
			Date today = new Date();
			DateFormat sd1 = new SimpleDateFormat("yyyy-MM");
			inVO.setSearchString(sd1.format(today));
		}else{
			if(inVO.getSelectMonth().length() == 1){
				inVO.setSelectMonth("0"+inVO.getSelectMonth());
			}
			inVO.setSearchString(inVO.getSelectYear() + "-" + inVO.getSelectMonth());
		}

		List<String> yearList = sqlSession.selectList("HolidayMapper.yearList");
		model.addAttribute("yearList", yearList);

		List<SysAdmHolidayVO> oneMonthList = sqlSession.selectList("HolidayMapper.oneMonthList", inVO);
		model.addAttribute("oneMonthList", oneMonthList);
		model.addAttribute("selectedYear", inVO.getSearchString().substring(0, 4));
		model.addAttribute("selectedMonth", inVO.getSearchString().substring(5));
		model.addAttribute("startYoil", oneMonthList.get(0).getHoliday_yoil());

		return "sys_adm/holiday_pan";
	}//sampleMemoPan

	@RequestMapping(value = "holidaySearch", method = RequestMethod.POST)
	public void holidaySearch(HttpServletResponse response, HolidayViewVO inVO) {

		logger.info("holidaySearch");

		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		SysAdmHolidayVO searchHoliday = sqlSession.selectOne("HolidayMapper.holidaySearch", inVO);
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		obj.put("basis", searchHoliday.getHoliday_basis());
		arr.add(obj);
		String jsonStr = arr.toString();
		out.print(jsonStr);
		out.close();

	}//holidaySearch

	@RequestMapping(value = "holidayUpdate", method = RequestMethod.POST)
	public void holidayUpdate(HttpServletResponse response, HolidayViewVO inVO) {

		logger.info("holidayUpdate");

		int result = 0;
		result = sqlSession.update("HolidayMapper.holidayUpdate", inVO);

		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		if(result > 0){
			out.print(result);
		}
		out.close();

	}//holidayUpdate
	@RequestMapping(value = "restoreHolidayUpdate", method = RequestMethod.POST)
	public void restoreHolidayUpdate(HttpServletResponse response, HolidayViewVO inVO) {

		logger.info("restoreHolidayUpdate");

		int result = 0;
		result = sqlSession.update("HolidayMapper.restoreHolidayUpdate", inVO);

		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		if(result > 0){
			out.print(result);
		}
		out.close();

	}//restoreHolidayUpdate

}//end of class
