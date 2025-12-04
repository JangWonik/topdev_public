package kr.co.toplac.topstatistics.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.topvaction.VacationInfoBean;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;

/**
 * Created by kohyeonseok on 2017. 3. 15..
 */
@Controller
public class StatisticBasicController {

	private static final Logger logger = LoggerFactory.getLogger(StatisticBasicController.class);

	@Autowired
	private SqlSession sqlSession;
	
	/**
	 * 서면심사 취소건을 삭제한다. 
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "deleteWrittenCancel")
	@ResponseBody
	public Map<String, Object> deleteWrittenCancel(Model model, HttpServletRequest request) throws Exception {
		// ===============================================
		// 파라미터 체크
		// ===============================================
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		//String log_serial_no = paramMap.get("serial_no").toString();
		
		//System.out.println("log_serial_no="+log_serial_no);
		
		//resultMap = sqlSession.selectOne("ItMgmtMapper.selectWrittenInfoSimple",paramMap);
		resultMap = sqlSession.selectOne("ItMgmtMapper.selectWrittenLogInfo",paramMap);
		
		//CommonUtils.printMap(resultMap);
		
		//기존 취소건에 대한 롤백처리 시작
		
		String user_no = resultMap.get("userNo").toString();
		String team_id = resultMap.get("teamId").toString();
		String suim_date = resultMap.get("suimDateFmt").toString();
		String base_date = resultMap.get("baseDateFmt").toString();
		String cancel_cnt = String.valueOf(Integer.parseInt(resultMap.get("cancelCnt").toString()) * -1);			//취소건에 대한 음수처리
		
		//취소건을 역으로 취소한다.
		doWrittenCancelProcess(user_no, team_id, suim_date, base_date, cancel_cnt,"cancel_del","0");
		
		sqlSession.update("ItMgmtMapper.updateWrittenLogDel",paramMap);
		
		//기존 취소건에 대한 롤백처리 끝
		
		return resultMap;
	}
	
	/**
	 * 서면심사 사용자, 기준일자로 수임, 종결건수를 가져온다. 
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "getWrittenSuimInfo")
	@ResponseBody
	public Map<String, Object> getWrittenSuimInfo(Model model, HttpServletRequest request) throws Exception {
		// ===============================================
		// 파라미터 체크
		// ===============================================
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		String user_no = String.valueOf(paramMap.get("user_no"));
		String base_date = String.valueOf(paramMap.get("base_date"));
		
		resultMap = sqlSession.selectOne("ItMgmtMapper.selectWrittenInfoSimple",paramMap);
		
		return resultMap;
	}

	@RequestMapping(value = "expenseTeamListAction")
	@ResponseBody
	public Map<String, Object> expenseTeamListAction(Model model, HttpServletRequest request) throws Exception {
		// ===============================================
		// 파라미터 체크
		// ===============================================
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String, Object> resultMap = new HashMap<String, Object>();

		String sTeamId = String.valueOf(paramMap.get("team_id"));
		String sBaseDate = String.valueOf(paramMap.get("base_date"));
		String sMemberCnt = String.valueOf(paramMap.get("member_cnt"));

		// System.out.println("sTeamId="+sTeamId+" : "+sBaseDate+" : "+sMemberCnt);

		if ("null".equals(sTeamId) || "null".equals(sBaseDate) || "null".equals(sMemberCnt)) {
			resultMap.put("result", "Empty Value");
		} else {
			// 기존에 스케줄러로 입력된 값이 있는지 확인
			int nChk = 0;
			paramMap.put("base_date", sBaseDate);
			paramMap.put("team_id", sTeamId);
			paramMap.put("member_cnt", sMemberCnt);

			nChk = sqlSession.selectOne("StatisticBasic.selectExpenseTeamChk", paramMap);

			if (nChk == 0) { // 스케줄러가 입력한 값이 없는 상태
				resultMap.put("result", "Empty Schedule");
			} else {
				sqlSession.update("StatisticBasic.updateExpenseTeamCnt", paramMap);
				resultMap.put("result", "Success");
			}
		}
		return resultMap;
	}

	@RequestMapping(value = "expenseTeamList")
	public String teamList(HttpServletRequest request, Model model) throws Exception {
		logger.info("==== expenseTeamList =====");

		String retURL = "top_statistics/expense_team_list";

		// ===============================================
		// 파라미터 체크
		// ===============================================
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

		// ===============================================
		// 현재 일자 세팅
		// ===============================================
		String baseYear = StringUtil.null2blank(request.getParameter("baseYear")); // 기준년도
		String baseMonth = StringUtil.null2blank(request.getParameter("baseMonth")); // 기준월

		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde")); // 기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde")); // 기준일자 종료일
		
		String excelYN = StringUtil.null2blank(request.getParameter("excelYN"));  //엑셀다운 여부
		
		String s_team_id = request.getParameter("s_team_id") != null ? request.getParameter("s_team_id") : "";		//팀아이디		

		if ("".equals(stdBgnde)) {
			stdBgnde = DateUtil.getStartMonthDay();
			stdEndde = DateUtil.getEndMonthDay();

			stdBgnde = DateUtil.getDateFormat(stdBgnde, "-");
			stdEndde = DateUtil.getDateFormat(stdEndde, "-");

			paramMap.put("stdBgnde", stdBgnde);
			paramMap.put("stdEndde", stdEndde);
			paramMap.put("excelYN", "N");
		}

		if ("".equals(stdEndde)) { // 기준년도나 기준월이 없으면 현재시간으로 설정한다.
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar c1 = Calendar.getInstance();
			String strToday = sdf.format(c1.getTime());
			baseYear = strToday.substring(0, 4);
			baseMonth = strToday.substring(5, 7);
		} else {
			baseYear = stdEndde.substring(0, 4);
			baseMonth = stdEndde.substring(5, 7);
		}

		ArrayList<String> dates = DateUtil.getBetweenDate(stdBgnde, stdEndde);

		paramMap.put("base_year", baseYear);
		paramMap.put("base_month", baseMonth);
		paramMap.put("stdBgnde", stdBgnde); // 검색 시작날 기준으로 팀목록을 가져온다.
		paramMap.put("stdEndde", stdEndde); // 검색 마지막날 기준으로 팀목록을 가져온다.
		paramMap.put("s_team_id", s_team_id);		//검색 팀

		// System.out.println("stdBgnde="+stdBgnde+ " : stdEndde ="+stdEndde );

		// List<Map<String, Object>> expenseList =
		// sqlSession.selectList("StatisticBasic.selectExpenseInfoList",paramMap);
		
		// 검색용 팀목록 가져오기
		List<Map<String, Object>> teamList = sqlSession.selectList("ItMgmtMapper.selectTeamList");

		List<Map<String, Object>> expenseTeamList = sqlSession.selectList("StatisticBasic.selectExpenseTeamList",
				paramMap);

		int nMemberCnt = 0; // 팀인원수 임시변수
		int nChk = 0;
		int nMemberTotlCnt = 0; // 한달합산 계수
		
		try {
			for (int i = 0; i < expenseTeamList.size(); i++) {

				int nDivisionCnt = 0; // 평균을 구하기 위한 카운트 변수

				for (int k = 0; k < dates.size(); k++) {
					paramMap.put("base_date", dates.get(k));
					paramMap.put("team_id", expenseTeamList.get(i).get("teamId"));
					// System.out.println(expenseTeamList.get(i).get("teamId")+" : "+dates.get(k));

					nChk = sqlSession.selectOne("StatisticBasic.selectExpenseTeamChk", paramMap);

					if (nChk == 0) {
						nMemberCnt = 0;
					} else {
						nDivisionCnt++; // 평균계산 카운트 증가
						nMemberCnt = sqlSession.selectOne("StatisticBasic.selectExpenseTeamCnt", paramMap);
					}
					expenseTeamList.get(i).put("cnt" + k, nMemberCnt);
					nMemberTotlCnt += nMemberCnt;

					expenseTeamList.get(i).put("date" + k, dates.get(k)); // 날짜정보 추가
				}

				expenseTeamList.get(i).put("totalCnt", nMemberTotlCnt);
				expenseTeamList.get(i).put("divisionCnt", nDivisionCnt);
				expenseTeamList.get(i).put("daysCnt", dates.size());
				nMemberTotlCnt = 0; // 초기화
			}
		} catch (Exception e) {
			e.printStackTrace();
		}		

		model.addAttribute("expenseTeamList", expenseTeamList);
		model.addAttribute("dates", dates);
		model.addAttribute("baseYear", baseYear);
		model.addAttribute("baseMonth", baseMonth);
		model.addAttribute("stdBgnde", stdBgnde);
		model.addAttribute("stdEndde", stdEndde);
		//검색용 팀목록
		model.addAttribute("teamList", teamList);
		model.addAttribute("s_team_id", s_team_id);
		
		if ("Y".equals(excelYN)){
            retURL = "top_statistics/expense_team_list_excel";
            model.addAttribute("excelYN", "N");
        }

		return retURL;
	}
	
	@RequestMapping(value = "expenseExtraAction", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> expenseExtraAction(HttpServletRequest request) throws Exception{
		
		
		logger.info("======= expenseExtraAction =======");
		
		//===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String,Object> returnMap = new HashMap<>();		
		
		/*
		 * String sBaseyear = paramMap.get("v_baseYear").toString(); String sBasemonth =
		 * paramMap.get("v_baseMonth").toString(); String sUserno =
		 * paramMap.get("v_userNo").toString(); String sNonghyp_cost =
		 * paramMap.get("v_nonghypCost").toString(); String sDispatch_cost =
		 * paramMap.get("v_dispatchCost").toString(); String sElegance_cost =
		 * paramMap.get("v_eleganceCost").toString(); String sDeduction_cost =
		 * paramMap.get("v_deductionCost").toString();
		 * 
		 * System.out.println(sBaseyear+" : "+sBasemonth+" : "+sUserno+" : "
		 * +sNonghyp_cost+" : "+sDispatch_cost+" : "+sElegance_cost+" : "
		 * +sDeduction_cost);
		 */
		
		//기존 extra 데이터 삭제 후 추가
		sqlSession.delete("StatisticBasic.deleteExpenseExtraInfo", paramMap);		
		sqlSession.insert("StatisticBasic.insertExpenseExtraInfo", paramMap);
		
		return returnMap;		
	}
	

	@RequestMapping(value = "expenseList")
	public String expenseList(HttpServletRequest request, Model model) throws Exception {
		logger.info("==== expenseList =====");

		String retURL = "top_statistics/expense_list";

		// ===============================================
		// 파라미터 체크
		// ===============================================
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

		// ===============================================
		// 현재 일자 세팅
		// ===============================================
		String baseYear = StringUtil.null2blank(request.getParameter("baseYear")); // 기준년도
		String baseMonth = StringUtil.null2blank(request.getParameter("baseMonth")); // 기준월

		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde")); // 기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde")); // 기준일자 종료일
		
		String excelYN = StringUtil.null2blank(request.getParameter("excelYN"));  //엑셀다운 여부

		if ("".equals(stdBgnde)) {
			stdBgnde = DateUtil.getStartMonthDay();
			stdEndde = DateUtil.getEndMonthDay();

			stdBgnde = DateUtil.getDateFormat(stdBgnde, "-");
			stdEndde = DateUtil.getDateFormat(stdEndde, "-");

			paramMap.put("stdBgnde", stdBgnde);
			paramMap.put("stdEndde", stdEndde);
			paramMap.put("excelYN", "N");
		}

		if ("".equals(stdEndde)) { // 기준년도나 기준월이 없으면 현재시간으로 설정한다.
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar c1 = Calendar.getInstance();
			String strToday = sdf.format(c1.getTime());
			baseYear = strToday.substring(0, 4);
			baseMonth = strToday.substring(5, 7);
		} else {
			baseYear = stdEndde.substring(0, 4);
			baseMonth = stdEndde.substring(5, 7);
		}

		paramMap.put("base_year", baseYear);
		paramMap.put("base_month", baseMonth);

		List<Map<String, Object>> expenseList = sqlSession.selectList("StatisticBasic.selectExpenseInfoList", paramMap);

		model.addAttribute("expenseList", expenseList);
		model.addAttribute("baseYear", baseYear);
		model.addAttribute("baseMonth", baseMonth);
		model.addAttribute("stdBgnde", stdBgnde);
		model.addAttribute("stdEndde", stdEndde);
		
		if ("Y".equals(excelYN)){
            retURL = "top_statistics/expense_list_excel";
            model.addAttribute("excelYN", "N");
        }

		return retURL;
	}
	
	/**
     * 서면심사 종결건수 통계 목록 엑셀다운로드
     * @param request
     * @param model
     * @return
     */    
    @RequestMapping(value="/doDownWrittenList")
    public String doDownWrittenList(HttpServletRequest request, Model model) {
    	
    	logger.info("========= doDownWrittenList =========");
    	    	
    	String sUrl = "top_statistics/written_review_search_excel";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	//검색 파라미터		
		String s_team_id = request.getParameter("s_team_id") != null ? request.getParameter("s_team_id") : "";		//팀아이디
		String s_user_no = request.getParameter("s_user_no") != null ? request.getParameter("s_user_no") : "";		//사용자아이디
		String s_out_user = request.getParameter("s_out_user") != null ? request.getParameter("s_out_user") : "0";	//퇴사자조회여부
		String s_base_date = request.getParameter("s_base_date") != null ? request.getParameter("s_base_date") : "";		//기준일
		
		//기준업무량 계산을 위한 기간 계산 시작
		String sBaseDate = s_base_date.replace("-", "");				//변환기준일
		String sStartdate = "";				//기준업무량 검색기준 시작일
		String sEnddate = "";				//기준업무량 검색기준 종료일
		
		int nYear = Integer.parseInt(sBaseDate.substring(0, 4));
		int nMonth = Integer.parseInt(sBaseDate.substring(4, 6));
		int nDay = Integer.parseInt(sBaseDate.substring(6, 8));

		if (nMonth == 12 && nDay > 15) {
			++nYear;
		}
		
		sStartdate = (nYear-1)+"1216";
		sEnddate = nYear+"1216";
		
		paramMap.put("bgnDe", sStartdate);
		paramMap.put("endDe", sEnddate);
		paramMap.put("year", nYear);
		//기준업무량 계산을 위한 기간 계산 끝
		
		//검색 기간 설정 시작
		String toSdate = "";				//당월 시작날짜
		String toEdate = "";				//당월 종료날짜
		String beforeSdate = "";		//전월 시작날짜
		String beforeEdate = "";		//전월 종료날짜
		
		String toWeekSdate = "";		//금주 시작일자
		String toWeekEdate = "";		//금주 종료일자
		String beforeWeekSdate = "";		//전주 시작일자
		String beforeWeekEdate = "";		//전주 종료일자
		
		toSdate = DateUtil.getStartMonthDate(s_base_date);
		toEdate = DateUtil.getEndMonthDate(s_base_date);
		beforeSdate = DateUtil.getBeforeStartMonthDate(s_base_date);
		beforeEdate = DateUtil.getBeforeEndMonthDate(s_base_date);
		
		toWeekSdate = DateUtil.getStartWeek(s_base_date);
		toWeekEdate = DateUtil.getEndWeek(s_base_date);
		beforeWeekSdate = DateUtil.addDate(toWeekSdate, -7);
		beforeWeekEdate = DateUtil.addDate(toWeekEdate, -7);		
		
		paramMap.put("bm_sdate", beforeSdate);				//전월
		paramMap.put("bm_edate", beforeEdate);
		
		paramMap.put("tm_sdate", toSdate);						//당월
		paramMap.put("tm_edate", toEdate);
				
		paramMap.put("bw_sdate", beforeWeekSdate);		//전주
		paramMap.put("bw_edate", beforeWeekEdate);
		
		paramMap.put("tw_sdate", toWeekSdate);				//금주
		paramMap.put("tw_edate", toWeekEdate);
		
		// 부서를 전체로 놓고 검색하는 경우 사용할 팀 목록		
		List<Map<String, Object>> teamList = sqlSession.selectList("ItMgmtMapper.selectWrittenTeamList");
		
    	// 검색결과 가져오기
    	List<Map<String, Object>> writtenList = sqlSession.selectList("ItMgmtMapper.selectWrittenMemberSearchList",paramMap);
    	
    	//수임건수 테이블에 조회를 위한 임시 사번변수
    	String sUser_no = "";
    	
    	//기준업무량 목표건수 변수
    	String yearEa = "";
    	
    	Map<String, Object> writtenInfo;			//수임건수테이블에 데이터 있는경우의 값
    	
    	String sTeamName = "";
    	String sTeamId = "";
    	
    	for(int i = 0; i < writtenList.size(); i++) {
    		sUser_no = writtenList.get(i).get("userNo").toString();
    		sTeamName = writtenList.get(i).get("teamName").toString();
    		sTeamId = writtenList.get(i).get("teamId").toString();
    		paramMap.put("user_no", sUser_no);
    		paramMap.put("team_id", sTeamId);
    		paramMap.put("base_date", s_base_date);
    		
    		//기준업무량 계산 시작
    		yearEa = sqlSession.selectOne("StatisticBasic.selectPersonYearEa", paramMap);

    		if (yearEa == null || yearEa.equals("")) { // 값이 null 인경우 최종 발령팀 기준으로 가져온다.
    			yearEa = sqlSession.selectOne("StatisticBasic.selectPersonYearEaNull", paramMap);
    		}
    		
    		writtenList.get(i).put("yearEa", yearEa);
    		//기준업무량 계산 끝
    		
    		//통계합산값 가져오기
			writtenInfo = sqlSession.selectOne("ItMgmtMapper.selectWrittenInfoTotal",paramMap);
						
			writtenList.get(i).put("bmSuimCnt", writtenInfo.get("bmSuimCnt"));
			writtenList.get(i).put("tmSuimCnt", writtenInfo.get("tmSuimCnt"));
			writtenList.get(i).put("bwSuimCnt", writtenInfo.get("bwSuimCnt"));
			writtenList.get(i).put("twSuimCnt", writtenInfo.get("twSuimCnt"));
			
			writtenList.get(i).put("bmEndCnt", writtenInfo.get("bmEndCnt"));
			writtenList.get(i).put("tmEndCnt", writtenInfo.get("tmEndCnt"));
			writtenList.get(i).put("bwEndCnt", writtenInfo.get("bwEndCnt"));
			writtenList.get(i).put("twEndCnt", writtenInfo.get("twEndCnt"));			
			
			writtenList.get(i).put("bmUnsolveCnt", writtenInfo.get("bmUnsolveCnt"));
			writtenList.get(i).put("tmUnsolveCnt", writtenInfo.get("tmUnsolveCnt"));
			writtenList.get(i).put("bwUnsolveCnt", writtenInfo.get("bwUnsolveCnt"));
			writtenList.get(i).put("twUnsolveCnt", writtenInfo.get("twUnsolveCnt"));    		
    	}    	
    	
    	model.addAttribute("teamList", teamList);
    	model.addAttribute("writtenList", writtenList);
    	model.addAttribute("s_base_date", s_base_date);
    	
    	//팀아이디 (전체선택 여부)
    	model.addAttribute("teamName", sTeamName);
    	model.addAttribute("s_team_id", s_team_id);
    	
    	return sUrl;
    }
	
	/**
     * 서면심사 종결건수 통계 목록 ajax 가져오기
     * @param request
     * @param model
     * @return
     */    
    @RequestMapping(value="/getSearchWrittenList")
    public String getSearchWrittenList(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getSearchWrittenList =========");
    	    	
    	String sUrl = "top_statistics/written_review_search_ajax";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	//검색 파라미터		
		String s_team_id = request.getParameter("s_team_id") != null ? request.getParameter("s_team_id") : "";		//팀아이디
		String s_user_no = request.getParameter("s_user_no") != null ? request.getParameter("s_user_no") : "";		//사용자아이디
		String s_out_user = request.getParameter("s_out_user") != null ? request.getParameter("s_out_user") : "0";	//퇴사자조회여부
		String s_base_date = request.getParameter("s_base_date") != null ? request.getParameter("s_base_date") : "";		//기준일
		
		//기준업무량 계산을 위한 기간 계산 시작
		String sBaseDate = s_base_date.replace("-", "");				//변환기준일
		String sStartdate = "";				//기준업무량 검색기준 시작일
		String sEnddate = "";				//기준업무량 검색기준 종료일
		
		int nYear = Integer.parseInt(sBaseDate.substring(0, 4));
		int nMonth = Integer.parseInt(sBaseDate.substring(4, 6));
		int nDay = Integer.parseInt(sBaseDate.substring(6, 8));

		if (nMonth == 12 && nDay > 15) {
			++nYear;
		}
		
		sStartdate = (nYear-1)+"1216";
		sEnddate = nYear+"1216";
		
		paramMap.put("bgnDe", sStartdate);
		paramMap.put("endDe", sEnddate);
		paramMap.put("year", nYear);
		//기준업무량 계산을 위한 기간 계산 끝
		
		//검색 기간 설정 시작
		String toSdate = "";				//당월 시작날짜
		String toEdate = "";				//당월 종료날짜
		String beforeSdate = "";		//전월 시작날짜
		String beforeEdate = "";		//전월 종료날짜
		
		String toWeekSdate = "";		//금주 시작일자
		String toWeekEdate = "";		//금주 종료일자
		String beforeWeekSdate = "";		//전주 시작일자
		String beforeWeekEdate = "";		//전주 종료일자
		
		toSdate = DateUtil.getStartMonthDate(s_base_date);
		toEdate = DateUtil.getEndMonthDate(s_base_date);
		beforeSdate = DateUtil.getBeforeStartMonthDate(s_base_date);
		beforeEdate = DateUtil.getBeforeEndMonthDate(s_base_date);
		
		toWeekSdate = DateUtil.getStartWeek(s_base_date);
		toWeekEdate = DateUtil.getEndWeek(s_base_date);
		beforeWeekSdate = DateUtil.addDate(toWeekSdate, -7);
		beforeWeekEdate = DateUtil.addDate(toWeekEdate, -7);		
		
		//System.out.println("전월 : "+beforeSdate +" ~ "+beforeEdate);
		//System.out.println("당월 : "+toSdate+" ~ "+toEdate);		
		//System.out.println("전주 : "+beforeWeekSdate+" ~ "+beforeWeekEdate);		
		//System.out.println("금주 : "+toWeekSdate+" ~ "+toWeekEdate);
		
		paramMap.put("bm_sdate", beforeSdate);				//전월
		paramMap.put("bm_edate", beforeEdate);
		
		paramMap.put("tm_sdate", toSdate);						//당월
		paramMap.put("tm_edate", toEdate);
				
		paramMap.put("bw_sdate", beforeWeekSdate);		//전주
		paramMap.put("bw_edate", beforeWeekEdate);
		
		paramMap.put("tw_sdate", toWeekSdate);				//금주
		paramMap.put("tw_edate", toWeekEdate);
		
		//검색 기간 설정 끝
		//System.out.println("sStartdate="+sStartdate+" : "+sEnddate+" : "+nYear);
		
		// 부서를 전체로 놓고 검색하는 경우 사용할 팀 목록		
		List<Map<String, Object>> teamList = sqlSession.selectList("ItMgmtMapper.selectWrittenTeamList");
		
    	// 검색결과 가져오기
    	List<Map<String, Object>> writtenList = sqlSession.selectList("ItMgmtMapper.selectWrittenMemberSearchList",paramMap);
    	
    	//수임건수 테이블에 조회를 위한 임시 사번변수
    	String sUser_no = "";
    	
    	//기준업무량 목표건수 변수
    	String yearEa = "";
    	
    	Map<String, Object> writtenInfo;			//수임건수테이블에 데이터 있는경우의 값
    	
    	String sTeamName = "";
    	String sTeamId = "";
    	
    	for(int i = 0; i < writtenList.size(); i++) {
    		sUser_no = writtenList.get(i).get("userNo").toString();
    		sTeamName = writtenList.get(i).get("teamName").toString();
    		sTeamId = writtenList.get(i).get("teamId").toString();
    		paramMap.put("user_no", sUser_no);
    		paramMap.put("team_id", sTeamId);
    		paramMap.put("base_date", s_base_date);
    		
    		//sCalPuposeWorkload(sUser_no,s_base_date);
    		
    		//System.out.println("user_no : "+sUser_no+" : "+paramMap.get("year").toString()+" : "+paramMap.get("bgnDe").toString()+" : "+paramMap.get("endDe").toString());
    		
    		//기준업무량 계산 시작
    		yearEa = sqlSession.selectOne("StatisticBasic.selectPersonYearEa", paramMap);

    		if (yearEa == null || yearEa.equals("")) { // 값이 null 인경우 최종 발령팀 기준으로 가져온다.
    			yearEa = sqlSession.selectOne("StatisticBasic.selectPersonYearEaNull", paramMap);
    		}
    		
    		writtenList.get(i).put("yearEa", yearEa);
    		//기준업무량 계산 끝
    		
    		//통계합산값 가져오기
			writtenInfo = sqlSession.selectOne("ItMgmtMapper.selectWrittenInfoTotal",paramMap);
						
			writtenList.get(i).put("bmSuimCnt", writtenInfo.get("bmSuimCnt"));
			writtenList.get(i).put("tmSuimCnt", writtenInfo.get("tmSuimCnt"));
			writtenList.get(i).put("bwSuimCnt", writtenInfo.get("bwSuimCnt"));
			writtenList.get(i).put("twSuimCnt", writtenInfo.get("twSuimCnt"));
			
			writtenList.get(i).put("bmEndCnt", writtenInfo.get("bmEndCnt"));
			writtenList.get(i).put("tmEndCnt", writtenInfo.get("tmEndCnt"));
			writtenList.get(i).put("bwEndCnt", writtenInfo.get("bwEndCnt"));
			writtenList.get(i).put("twEndCnt", writtenInfo.get("twEndCnt"));			
			
			writtenList.get(i).put("bmUnsolveCnt", writtenInfo.get("bmUnsolveCnt"));
			writtenList.get(i).put("tmUnsolveCnt", writtenInfo.get("tmUnsolveCnt"));
			writtenList.get(i).put("bwUnsolveCnt", writtenInfo.get("bwUnsolveCnt"));
			writtenList.get(i).put("twUnsolveCnt", writtenInfo.get("twUnsolveCnt"));    		
    	}    	
    	
    	model.addAttribute("teamList", teamList);
    	model.addAttribute("writtenList", writtenList);
    	model.addAttribute("s_base_date", s_base_date);
    	
    	//팀아이디 (전체선택 여부)
    	model.addAttribute("teamName", sTeamName);
    	model.addAttribute("s_team_id", s_team_id);
    	
    	return sUrl;
    }
    
    /**
     * 기준업무량 목표건수 가져오기 (개발중 기준이 모호하여 중단.. 향후 사용할수 있음) by top3009
     * @param user_no
     * @param sBaseDate : 기준일
     * @return
     */
    public String sCalPuposeWorkload(String sUserNo, String sBaseDate) {
    	String sRet = "";
    	logger.info("=============sCalPuposeWorkload===================");
    	
    	Map<String, Object> paramMap = new HashMap<String, Object>();
    	
    	//기준업무량 계산을 위한 기간 계산 시작
    	sBaseDate = sBaseDate.replace("-", "");				//변환기준일
		String sStartdate = "";				//기준업무량 검색기준 시작일
		String sEnddate = "";				//기준업무량 검색기준 종료일
		String sEnddateCal = "";				//날짜계산용 검색기준 종료일
		
		int nYear = Integer.parseInt(sBaseDate.substring(0, 4));
		int nMonth = Integer.parseInt(sBaseDate.substring(4, 6));
		int nDay = Integer.parseInt(sBaseDate.substring(6, 8));

		if (nMonth == 12 && nDay > 15) {
			++nYear;
		}
		
		sStartdate = (nYear-1)+"1216";
		sEnddate = nYear+"1216";
		sEnddateCal = nYear+"1215";
		
		paramMap.put("user_no", sUserNo);
		paramMap.put("bgnDe", sStartdate);
		paramMap.put("endDe", sEnddate);
		paramMap.put("year", nYear);
		//기준업무량 계산을 위한 기간 계산 끝
		
		//검색시작일과 종료일사이에 발령목록을 가져온다.
		
		List<Map<String, Object>> appointList;
		List<Map<String, Object>> beforeAppointMap;		//직전 발령정보		
		String beforeAppointWorkJobCd = "";						//직전 표준업무코드
		
		//List<Map<String, Object>> writtenList = sqlSession.selectList("ItMgmtMapper.selectWrittenMemberList",paramMap);
		
		int nCnt = 0;
		nCnt = sqlSession.selectOne("StatisticBasic.selectPersonYearCnt", paramMap);
				
		if( nCnt == 0 ) {
			sRet = sqlSession.selectOne("StatisticBasic.selectPersonYearEaNull", paramMap);
		}else{
			//해당년도 시작기준일 직전 발령정보를 가져온다.
			paramMap.put("base_date", sStartdate);			
			
			beforeAppointMap = sqlSession.selectList("StatisticBasic.selectPersonBeforeAppointInfo",paramMap);
			
			//해당년도 시작기준일 직전 발령정보가 없는경우 (올해신규입사자)
			if( beforeAppointMap.size() == 0 ) {
				sRet = sqlSession.selectOne("StatisticBasic.selectPersonYearEaNull", paramMap);
			}else{
				beforeAppointWorkJobCd = beforeAppointMap.get(0).get("appointWorkJobCd").toString();
				System.out.println("beforeAppointWorkJobCd="+beforeAppointWorkJobCd);
			}
			
			appointList = sqlSession.selectList("StatisticBasic.selectPersonAppointInfo",paramMap);			
			
			String sTempPurpose = "";	//임시 목표건수
			
			String nNextPupose = "";		//다음 목표건수
			int nIntervalDate = 0;			
			int nListSize = appointList.size();
			
			//System.out.println("sUserNo="+sUserNo);
			
			double dTemp = 0;			//임시 합산 기준업무량 건수
			
			//목표건수 계산시작
			for(int i=0; i < appointList.size(); i++) {
				
				if(nListSize == 1) {		//1번 발령난경우
					//발령전까지의 목표량
					paramMap.put("appoint_work_job_cd", beforeAppointWorkJobCd);
					sTempPurpose = sqlSession.selectOne("StatisticBasic.getPurposeWorkloadCode", paramMap);
					nIntervalDate = DateUtil.getDiffDayCount(sStartdate, appointList.get(i).get("appointDateFmt").toString());
					dTemp += ((double)nIntervalDate / 365) * Double.parseDouble(sTempPurpose);
					
					nNextPupose = appointList.get(i).get("appointWorkJobCd").toString();
					
					//발령이후 목표량
					paramMap.put("appoint_work_job_cd", nNextPupose);
					sTempPurpose = sqlSession.selectOne("StatisticBasic.getPurposeWorkloadCode", paramMap);
					
					nIntervalDate = DateUtil.getDiffDayCount(appointList.get(i).get("appointDateFmt").toString(),sEnddateCal);
					dTemp += ((double)nIntervalDate / 365) * Double.parseDouble(sTempPurpose);
				}else{						//2번이상 발령 난 경우
					//발령전까지의 목표량
					paramMap.put("appoint_work_job_cd", beforeAppointWorkJobCd);
					sTempPurpose = sqlSession.selectOne("StatisticBasic.getPurposeWorkloadCode", paramMap);
					nIntervalDate = DateUtil.getDiffDayCount(sStartdate, appointList.get(i).get("appointDateFmt").toString());
					dTemp += ((double)nIntervalDate / 365) * Double.parseDouble(sTempPurpose);
					
					nNextPupose = appointList.get(i).get("appointWorkJobCd").toString();
					
					
				}
				
				//시작일로부터 첫번째 발령일까지 계산
				//if( i == 0 ) {
					//paramMap.put("appoint_work_job_cd", beforeAppointWorkJobCd);
					//sTempPurpose = sqlSession.selectOne("StatisticBasic.getPurposeWorkloadCode", paramMap);
					//nIntervalDate = DateUtil.getDiffDayCount(sStartdate, appointList.get(i).get("appointDateFmt").toString());
					//발령일을 다음 발령일의 시작일로 셋팅한다.
					//beforeDate = appointList.get(i).get("appointDateFmt").toString();					
				//}
				
				//dTemp = (nIntervalDate / 365) * Integer.parseInt(sTempPurpose);
				
				System.out.println( "sUserNo : "+sUserNo+" : "+i +" : "+dTemp);
				
			}
			
		}
		
		//sRet =dTemp;
		
		//System.out.println("oniku="+sUserNo+" : "+sStartdate+" : "+sEnddate+" : "+nYear + " : "+nCnt+" : "+sRet);
		//해당기간에 발령횟수를 체크한다.
		
    	
    	return sRet;
    }
    
	
	/**
     * 서면심사 종결건수 관리 목록 ajax 가져오기
     * @param request
     * @param model
     * @return
     */    
    @RequestMapping(value="/getWrittenList")
    public String getWrittenList(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getWrittenList =========");
    	    	
    	String sUrl = "top_statistics/written_review_manage_ajax";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	//검색 파라미터		
		String s_team_id = request.getParameter("s_team_id") != null ? request.getParameter("s_team_id") : "";		//팀아이디
		String s_user_no = request.getParameter("s_user_no") != null ? request.getParameter("s_user_no") : "";		//사용자아이디
		String s_out_user = request.getParameter("s_out_user") != null ? request.getParameter("s_out_user") : "0";	//퇴사자조회여부
		String s_base_date = request.getParameter("s_base_date") != null ? request.getParameter("s_base_date") : "";		//기준일
		
		String s_ptnr_id = request.getParameter("s_ptnr_id") != null ? request.getParameter("s_ptnr_id") : "0";		//보험사코드

    	// 검색결과 가져오기
    	List<Map<String, Object>> writtenList = sqlSession.selectList("ItMgmtMapper.selectWrittenMemberList",paramMap);
    	
    	//수임건수 테이블에 조회를 위한 임시 사번변수
    	String sUser_no = "";
    	
    	Map<String, Object> writtenInfo;			//수임건수테이블에 데이터 있는경우의 값    	
    	int nCount = 0;
    	
    	for(int i = 0; i < writtenList.size(); i++) {
    		sUser_no = writtenList.get(i).get("userNo").toString();
    		paramMap.put("user_no", sUser_no);
    		paramMap.put("base_date", s_base_date);
    		//갯수 체크
    		
    		nCount = sqlSession.selectOne("ItMgmtMapper.selectWrittenListCount", paramMap);
    		
    		if( nCount == 1 ) {
    			//조회된 값이 있는경우
    			writtenInfo = sqlSession.selectOne("ItMgmtMapper.selectWrittenInfo",paramMap);
    			writtenList.get(i).put("serialNo", writtenInfo.get("serialNo"));
    			writtenList.get(i).put("suimCnt", writtenInfo.get("suimCnt"));
    			writtenList.get(i).put("endCnt", writtenInfo.get("endCnt"));
    			writtenList.get(i).put("unsolveCnt", writtenInfo.get("unsolveCnt"));
    			writtenList.get(i).put("cancelCnt", writtenInfo.get("cancelCnt"));
    			writtenList.get(i).put("transCnt", writtenInfo.get("transCnt"));
    			//페이지에 표시될때 이첩건수를 마이너스(-)로 표시하기위한 변수 추가
    			writtenList.get(i).put("transCntMinus", Integer.parseInt(writtenInfo.get("transCnt").toString()) * -1);
    			writtenList.get(i).put("baseDateFmt", writtenInfo.get("baseDateFmt"));
    			writtenList.get(i).put("regDateFmt", writtenInfo.get("regDateFmt"));
    			
    		}else{
    			//조회된 값이 없는경우
    			writtenList.get(i).put("serialNo", "");
    			writtenList.get(i).put("suimCnt", 0);
    			writtenList.get(i).put("endCnt", 0);
    			writtenList.get(i).put("unsolveCnt", 0);
    			writtenList.get(i).put("cancelCnt", 0);
    			writtenList.get(i).put("transCnt", 0);
    			writtenList.get(i).put("transCntMinus", 0);
    			writtenList.get(i).put("baseDateFmt", "");
    			writtenList.get(i).put("regDateFmt", "");
    		}
    	}
    	
    	String sToday = DateUtil.getTodayString("yyyy-MM-dd");
    	
    	//수정 삭제가 가능한 날짜 체크 (기준일이 오늘보다 과거인경우 수정, 삭제 불가)   	
    	//nChkDate = 0 보다 작은경우 기준일이 과거
    	int nChkDate = -1;
    	if(!"".equals(s_base_date)) {
    		nChkDate = DateUtil.compareDate(sToday, s_base_date);
    	}    	
    	
    	model.addAttribute("nChkDate", nChkDate);    	
    	model.addAttribute("writtenList", writtenList);
    	model.addAttribute("s_base_date", s_base_date);
    	
    	return sUrl;
    }
    
    @RequestMapping(value="/writtenDelete")
    @ResponseBody
    public int writtenDelete(HttpServletRequest request, Model model) {
    	int nCnt = 0;
    	
    	String serial_no = request.getParameter("serial_no") != null ? request.getParameter("serial_no") : "";
    	
    	if(!"".equals(serial_no)) {
    		nCnt = sqlSession.delete("ItMgmtMapper.deleteWritten", serial_no);
    	}    	
    	
    	return nCnt;
    }
    
    @RequestMapping(value="/writtenUpdateOne")
    @ResponseBody
    public int writtenUpdateOne(HttpServletRequest request, Model model) {
    	int nCnt = 0;
    	
    	TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);    	
    	
    	int last_unsolve_cnt = 0;		//입력하기 전 마지막 미결건수
    	
    	String unsolve_cnt = "";		//DB에 입력될 미결건수
    	
    	String user_no = request.getParameter("addUserNo") != null ? request.getParameter("addUserNo") : "";					//사번
    	String team_id = request.getParameter("addTeamId") != null ? request.getParameter("addTeamId") : "";				//팀아이디
    	String base_date = request.getParameter("addBasedate") != null ? request.getParameter("addBasedate") : "";		//기준일
    	String suim_cnt = request.getParameter("addSuimCnt") != null ? request.getParameter("addSuimCnt") : "0";				//수임건수
    	String end_cnt = request.getParameter("addEndCnt") != null ? request.getParameter("addEndCnt") : "0";					//종결건수
    	//String cancel_cnt = request.getParameter("addCancelCnt") != null ? request.getParameter("addCancelCnt") : "0";		//취소건수
    	//String trans_cnt = request.getParameter("addTransCnt") != null ? request.getParameter("addTransCnt") : "0";		//취소건수
    	    	
    	paramMap.put("log_user_no", mbrVo.getUser_no());
    	paramMap.put("log_ip", mbrVo.getUser_ip());
    	    	
    	paramMap.put("user_no", user_no);		
		paramMap.put("base_date", base_date);		
		
		//등록전 마지막 미결건수 가져오기. 없으면 0
		last_unsolve_cnt = sqlSession.selectOne("ItMgmtMapper.selectWrittenLastUnsolveCount", paramMap);
		
		int nTempUnsolve = 0;
		
		int before_cancel_cnt = 0;	//기존에 취소되었던 건수(임시변수)
    	int before_trans_cnt = 0;		//기존에 이내첩되었던 건수(임시변수)
    	
    	//해당 기준일로 기존에 취소되었던 건이 있는지 확인
		before_cancel_cnt = sqlSession.selectOne("ItMgmtMapper.selectWrittenListBeforeCancel", paramMap);
		
		//해당 기준일로 기존에 취소되었던 건이 있는지 확인
		before_trans_cnt = sqlSession.selectOne("ItMgmtMapper.selectWrittenListBeforeTrans", paramMap);
		
		//System.out.println("before_cancel_cnt="+before_cancel_cnt);
		
		//미결 = 수임건 - 종결건 - 취소건 - 기존미결건 - 이첩건
		//nTempUnsolve = Integer.parseInt(suim_cnt) - Integer.parseInt(end_cnt) - Integer.parseInt(cancel_cnt) + last_unsolve_cnt + Integer.parseInt(trans_cnt);
		//nTempUnsolve = Integer.parseInt(suim_cnt) - Integer.parseInt(end_cnt) + last_unsolve_cnt;
		
		//미결 = 수임건 - 종결건 + 기존미결 + 기존 취소건 + 기존이내첩건
		nTempUnsolve = Integer.parseInt(suim_cnt) - Integer.parseInt(end_cnt) + last_unsolve_cnt - before_cancel_cnt - before_trans_cnt;
		
		unsolve_cnt = String.valueOf(nTempUnsolve);
    		
		paramMap.put("user_no", user_no);
		paramMap.put("suim_cnt", suim_cnt);
		paramMap.put("end_cnt", end_cnt);		
		paramMap.put("unsolve_cnt", unsolve_cnt);
		//paramMap.put("cancel_cnt", cancel_cnt);
		//paramMap.put("trans_cnt", trans_cnt);
		paramMap.put("base_date", base_date);
		paramMap.put("team_id", team_id);
		
		int nCount = 0;
		nCount = sqlSession.selectOne("ItMgmtMapper.selectWrittenListCount", paramMap);
		
		if( nCount == 0 ){
			//신규 추가
			nCnt = sqlSession.insert("ItMgmtMapper.insertWrittenList", paramMap);
			
			//로그추가
			paramMap.put("log_action", "insert");
			paramMap.put("trans_user_no", "0");
			sqlSession.insert("ItMgmtMapper.insertWrittenListLog", paramMap);
		}else{
			//갱신
			nCnt = sqlSession.update("ItMgmtMapper.updateWrittenList", paramMap);
			
			//로그추가
			paramMap.put("log_action", "update");
			paramMap.put("trans_user_no", "0");
			sqlSession.insert("ItMgmtMapper.insertWrittenListLog", paramMap);
		}
		
    	return nCnt;
    }
    
    /**
     * 서면심사 이내첩 처리
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/writtenTransAll")
    @ResponseBody
    public Map<String, Object> writtenTransAll(HttpServletRequest request, Model model) {
    	    	
    	String returnMsg = "";
    	
    	Map<String, Object> returnMap = new HashMap<>();
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String [] sTemp = request.getParameterValues("transList");			//목록에서 이내첩해야할 임시 배열
    	String [] splTemp = null;					//배열처리 임시변수    	
    	
    	String user_no = "";				//내첩자사번
    	String team_id = "";				//내첩팀아이디    	
    	String suim_date = "";			//수임날짜
    	String base_date = "";			//기준날짜
    	String trans_cnt = "";			//내첩건수
    	String trans_user_no = "";	//이첩대상자 사번
    	String trans_user_name = "";	//이첩대상자 이름
    	String trans_team_id = "";	//이첩담당자 팀아이디
    	String minus_trans_cnt = "";		//이첩받는 사람의 건수(음수처리된값)
    	
    	int total_trans = 0;		//취소건 전체
		
		returnMsg += "=========이내첩결과==========\n\n";
    	
    	for(int i=0; i < sTemp.length; i++) {
    		splTemp = sTemp[i].split("\\|");
    		user_no = splTemp[0];
    		team_id = splTemp[1];    		
    		base_date = splTemp[2];
    		suim_date = splTemp[3];
    		trans_cnt = splTemp[4];
    		trans_user_no = splTemp[5];
    		
    		total_trans += Integer.parseInt(trans_cnt);
    		
    		paramMap.put("user_no", user_no);
    		paramMap.put("team_id", team_id);
    		paramMap.put("suim_date", suim_date);
    		paramMap.put("base_date", base_date);
    		paramMap.put("trans_cnt", trans_cnt);
    		
    		//System.out.println(user_no + " : "+team_id+" : "+suim_date+" : "+trans_cnt+" : "+trans_user_no);
    		
    		//내첩담당자 건수에서 이첩취소처리한다.
    		doWrittenCancelProcess(user_no, team_id, suim_date, base_date, trans_cnt,"trans",trans_user_no);
    		
    		trans_user_name = sqlSession.selectOne("ItMgmtMapper.selectSimpleUsername",trans_user_no);
    		trans_team_id = sqlSession.selectOne("ItMgmtMapper.selectSimpleTeamId",trans_user_no);
    		
    		returnMsg += "수임일자 : "+suim_date+" | 이첩건수 : "+trans_cnt+" 건 | 이첩담당자 : "+ trans_user_name +"\n";
    		
    		//이첩담당자 건수에서 추가처리한다.
    		minus_trans_cnt = String.valueOf((Integer.parseInt(trans_cnt) * -1));    		
    		doWrittenCancelProcess(trans_user_no, trans_team_id, suim_date, base_date, minus_trans_cnt,"trans",user_no);
    		
    	}
    	
    	returnMsg += "\n전체이첩건수 : "+total_trans+" 건\n\n";
    	
    	returnMsg += "============================";
    	    	
    	returnMap.put("msg", returnMsg);
    	
    	return returnMap;
    }
    
    
    /**
     * 서면심사 취소처리
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/writtenCancelAll")
    @ResponseBody
    public Map<String, Object> writtenCancelAll(HttpServletRequest request, Model model) {
    	    	
    	String returnMsg = "";
    	
    	Map<String, Object> returnMap = new HashMap<>();
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String [] sTemp = request.getParameterValues("cancelList");			//목록에서 취소해야할 임시 배열
    	String [] splTemp = null;					//배열처리 임시변수    	
    	
    	String user_no = "";				//취소자사번
    	String team_id = "";				//취소자팀아이디
    	String base_date = "";			//기준일
    	String suim_date = "";			//수임날짜
    	String cancel_cnt = "";			//취소건수
    	
    	int total_cancel = 0;		//취소건 전체
		
		returnMsg += "=========수임취소결과==========\n\n";
    	
    	for(int i=0; i < sTemp.length; i++) {
    		splTemp = sTemp[i].split("\\|");
    		user_no = splTemp[0];
    		team_id = splTemp[1];
    		base_date = splTemp[2];
    		suim_date = splTemp[3];
    		cancel_cnt = splTemp[4];
    		
    		total_cancel += Integer.parseInt(cancel_cnt);
    		
    		paramMap.put("user_no", user_no);
    		paramMap.put("team_id", team_id);
    		paramMap.put("base_date", base_date);
    		paramMap.put("suim_date", suim_date);    		
    		paramMap.put("cancel_cnt", cancel_cnt);
    		    		
    		returnMsg += "수임일자 : "+suim_date+" | 취소건수 : "+cancel_cnt+" 건\n";
    		
    		//수임건 취소처리 함수
    		doWrittenCancelProcess(user_no, team_id, suim_date, base_date, cancel_cnt, "cancel", "0");
    		
    	}
    	
    	returnMsg += "\n전체취소건수 : "+total_cancel+" 건\n\n";
    	
    	returnMsg += "============================";
    	    	
    	returnMap.put("msg", returnMsg);
    	
    	return returnMap;
    }
    
    /**
     * 수임건 취소 함수
     * @param user_no : 취소대상자
     * @param team_id : 취소자 팀
     * @param suim_date : 취소할 건수의 수임일자
     * @param cancel_cnt : 취소 건수
     * @param action : cancel(취소), trans(이내첩으로 인한 취소)
     * @param trans_user_no : 내첩담당자사번 (없는경우는 0)
     */
    public void doWrittenCancelProcess(String user_no, String team_id, String suim_date, String base_date, String cancel_cnt, String action, String trans_user_no){
    	
    	TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
    	
    	int temp_suim_cnt = 0;		//임시수임건 변수
    	int temp_cancel_cnt = 0;		//임시취소건 변수
    	int temp_trans_cnt	=	0;		//임시이첩건 변수
    	int last_unsolve_cnt = 0;		//마지막 미결건수
    	
    	Map<String, Object> paramMap = new HashMap<String, Object>();
    	
    	//로그 추가 정보
    	paramMap.put("log_user_no", mbrVo.getUser_no());
		paramMap.put("log_ip", mbrVo.getUser_ip());
		paramMap.put("log_action", action);
		paramMap.put("trans_user_no", trans_user_no);
    	
    	paramMap.put("user_no", user_no);
		paramMap.put("team_id", team_id);
		paramMap.put("base_date", base_date);
		paramMap.put("suim_date", suim_date);
		paramMap.put("cancel_cnt", cancel_cnt);
		paramMap.put("trans_cnt", cancel_cnt);
		
		//System.out.println("action="+action+" : "+user_no+" : "+cancel_cnt);		
		//System.out.println("base_date="+base_date);
		//System.out.println("suim_date="+suim_date);
		    	
    	//해당 수임일자에 취소건을 기존 수임건에서 차감한다.
		int nCount = 0;    		
		nCount = sqlSession.selectOne("ItMgmtMapper.selectWrittenListCountSuim", paramMap);
		
		//System.out.println("nCount="+nCount);
		
		//취소할 날짜의 수임건이 있는 없는경우 0에서 마이너스 처리해준다.
		if( nCount == 0 ){
			//수임일자의 취소건수를 음수로 변환해서 수임건으로 넣어준다.
			paramMap.put("suim_cnt", (Integer.parseInt(cancel_cnt)*-1) );			
			
			//이첩으로 처리
			if( "trans".equals(action) ) {
				//작업날짜 기준으로 취소 숫자를 합산해준다.
				//sqlSession.insert("ItMgmtMapper.insertWrittenTransCnt", paramMap);
				sqlSession.update("ItMgmtMapper.updateWrittenTransCnt", paramMap);
				
				paramMap.put("log_trans_cnt", cancel_cnt);
			}else {		//취소로처리			
				
				//작업날짜 기준으로 취소 숫자를 합산해준다.
				sqlSession.update("ItMgmtMapper.updateWrittenCancelCnt", paramMap);
				
				paramMap.put("log_cancel_cnt", cancel_cnt);
			}
			
			//해당 수임일의 취소, 이내첩건수는 변동되지 않는다.
			paramMap.put("cancel_cnt", null);
			paramMap.put("trans_cnt", null);
			
			//sqlSession.insert("ItMgmtMapper.insertWrittenList", paramMap);
			
			//수임일자를 기준일자로 처리하여 추가함
			sqlSession.insert("ItMgmtMapper.insertWrittenListSuimDate", paramMap);
			
			if(!"cancel_del".equals(action)) {			
				//취소삭제건이 아닌경우만 로그추가			
				sqlSession.insert("ItMgmtMapper.insertWrittenListLog", paramMap);
			}
			
		}else{
			//취소할 날짜의 수임건이 있는경우 수임건에서 차감한값을 갱신한다.
			//temp_suim_cnt = sqlSession.selectOne("ItMgmtMapper.selectWrittenSuimCnt", paramMap);    			
			//temp_suim_cnt = temp_suim_cnt - Integer.parseInt(cancel_cnt);		//갱신할 수임건수
			
			//paramMap.put("suim_cnt", String.valueOf(temp_suim_cnt));
			
			//sqlSession.update("ItMgmtMapper.updateWrittenList", paramMap);
			
			sqlSession.update("ItMgmtMapper.updateWrittenSuimCnt", paramMap);
						
			//paramMap.put("cancel_cnt", null);
			//paramMap.put("trans_cnt", null);
			
			//이첩으로 처리
			if( "trans".equals(action) ) {			
				
				//작업날짜 기준으로 취소 숫자를 합산해준다.
				sqlSession.update("ItMgmtMapper.updateWrittenTransCnt", paramMap);
				
				//paramMap.put("cancel_cnt", null);				
				//temp_trans_cnt = sqlSession.selectOne("ItMgmtMapper.selectWrittenTransCnt", paramMap);
				//temp_trans_cnt = temp_trans_cnt + Integer.parseInt(cancel_cnt);		//갱신할 취소건수
				//paramMap.put("trans_cnt", String.valueOf(temp_trans_cnt));
				
				//로그 등록용 건수
				paramMap.put("log_trans_cnt", cancel_cnt);
				
			}else {		//취소로처리
				//paramMap.put("trans_cnt", null);
				
				//작업날짜 기준으로 취소 숫자를 갱신해준다.
				sqlSession.update("ItMgmtMapper.updateWrittenCancelCnt", paramMap);
				
				//temp_cancel_cnt = sqlSession.selectOne("ItMgmtMapper.selectWrittenCancelCnt", paramMap);
				//temp_cancel_cnt = temp_cancel_cnt + Integer.parseInt(cancel_cnt);		//갱신할 취소건수
				//paramMap.put("cancel_cnt", String.valueOf(temp_cancel_cnt));
				
				//로그 등록용 건수
				paramMap.put("log_cancel_cnt", cancel_cnt);
			}
			
			if(!"cancel_del".equals(action)) {
				//취소삭제건이 아닌경우만 로그추가			
				sqlSession.insert("ItMgmtMapper.insertWrittenListLog", paramMap);
			}
			
		}
		
		//해당 사용자의 최종 미결건수를 가져와서 차감한다.
		last_unsolve_cnt = sqlSession.selectOne("ItMgmtMapper.selectWrittenLastOneUnsolveCount", paramMap);    	
    	last_unsolve_cnt = last_unsolve_cnt - Integer.parseInt(cancel_cnt);    	
    	paramMap.put("last_unsolve_cnt", last_unsolve_cnt);
    	
    	//미결건수 처리
    	sqlSession.update("ItMgmtMapper.updateWrittenLastUnsolve",paramMap);
		
    }
    
    @RequestMapping(value = "writtenTransViewModal")	
	public String writtenTransViewModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= writtenTransViewModal =======");

		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		// 이내첩목록 가져오기		
		paramMap.put("log_action", "trans");		
		//이내첩 조회로그
		List<Map<String, Object>> transList = sqlSession.selectList("ItMgmtMapper.selectWrittenTransList",paramMap);
		
		model.addAttribute("transList", transList);
		model.addAttribute("base_date", paramMap.get("base_date"));
		model.addAttribute("team_name", paramMap.get("team_name"));
		model.addAttribute("user_name", paramMap.get("user_name"));
	    
	    //return "top_statistics/written_cancel_view";
	    return "top_statistics/written_trans_view";
	}
    
    @RequestMapping(value = "writtenCancelViewModal")	
	public String writtenCancelViewModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= writtenCancelViewModal =======");

		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		// 취소목록 가져오기		
		paramMap.put("log_action", "cancel");
		
		List<Map<String, Object>> cancelList = sqlSession.selectList("ItMgmtMapper.selectWrittenCancelList",paramMap);
		
		model.addAttribute("cancelList", cancelList);
		model.addAttribute("base_date", paramMap.get("base_date"));
		model.addAttribute("team_name", paramMap.get("team_name"));
		model.addAttribute("user_name", paramMap.get("user_name"));
	    
	    return "top_statistics/written_cancel_view";
	}	
    
    @RequestMapping(value="/writtenUpdateAll")
    @ResponseBody
    public Map<String, Object> writtenUpdateAll(HttpServletRequest request, Model model) {
    	
    	TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
    	
    	int nInCnt = 0;		//추가된 결과값
    	int nUpCnt = 0;		//갱신된 결과값
    	int nChkFail = 0;		//갱신불가 체크횟수
    	String returnMsg = "";
    	
    	String sFailUser = "";	//갱신불가 사용자이름
    	
    	Map<String, Object> returnMap = new HashMap<>();
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String [] sTemp = request.getParameterValues("writtenList");			//목록에서 수정해야할 임시 배열
    	String [] splTemp = null;					//배열처리 임시변수    	
    	
    	String user_no = "";				//사번
    	String suim_cnt = "";			//수임건수
    	String end_cnt = "";				//종결건수
    	String unsolve_cnt = "";		//미결건수
    	//String cancel_cnt = "";			//취소건수
    	//String trans_cnt = "";			//이내첩건수
    	String base_date = "";			//기준일자
    	String team_id = "";				//팀아이디
    	String ptnr_id = "";				//보험사아이디
    	String sFailname = "";			//실패자이름 임시변수
    	
    	int last_unsolve_cnt = 0;		//마지막 미결건수
    	int nTempUnsolve = 0;			//미결 임시 변수
    	int before_cancel_cnt = 0;	//기존에 취소되었던 건수(임시변수)
    	int before_trans_cnt = 0;		//기존에 이내첩되었던 건수(임시변수)
    	
    	paramMap.put("log_user_no", mbrVo.getUser_no());
		paramMap.put("log_ip", mbrVo.getUser_ip());		
    	
    	for(int i=0; i < sTemp.length; i++) {
    		splTemp = sTemp[i].split("\\|");
    		user_no = splTemp[0];
    		suim_cnt = splTemp[1];
    		end_cnt = splTemp[2];    		
    		base_date = splTemp[3];
    		team_id = splTemp[4];
    		ptnr_id = splTemp[5];
    		
    		//unsolve_cnt = splTemp[3];
    		//cancel_cnt = splTemp[3];
    		//trans_cnt = splTemp[4];
    		
    		//System.out.println(i+" : "+user_no+" : "+suim_cnt+" : "+end_cnt+" : "+unsolve_cnt+" : "+cancel_cnt+" : "+trans_cnt+" : "+base_date);
    		//System.out.println(i+" : "+user_no+" : "+suim_cnt+" : "+end_cnt+" : "+base_date+" : "+team_id);
    		
    		paramMap.put("user_no", user_no);
    		paramMap.put("suim_cnt", suim_cnt);
    		paramMap.put("end_cnt", end_cnt);
    		//paramMap.put("cancel_cnt", cancel_cnt);
    		//paramMap.put("unsolve_cnt", unsolve_cnt);
    		//paramMap.put("trans_cnt", trans_cnt);
    		paramMap.put("base_date", base_date);
    		paramMap.put("team_id", team_id);
    		paramMap.put("ptnr_id", ptnr_id);
    		
    		//등록 전 입력된 기준일보다 미래날짜에 입력값이 있으면 등록 제외
    		nChkFail = sqlSession.selectOne("ItMgmtMapper.selectWrittenOverdateChk", paramMap);
    		
    		if( nChkFail > 0 ) {
    			sFailname = sqlSession.selectOne("ItMgmtMapper.getUsername", paramMap);    			
    			sFailUser = sFailUser + sFailname +" ";
    		}else{		//미래날짜가 없는 경우만 갱신
    			//등록전 마지막 미결건수 가져오기. 없으면 0
        		last_unsolve_cnt = sqlSession.selectOne("ItMgmtMapper.selectWrittenLastUnsolveCount", paramMap);
        		
        		//미결 = 수임건 - 종결건 - 취소건 - 기존종결건        		
        		//nTempUnsolve = Integer.parseInt(suim_cnt) - Integer.parseInt(end_cnt) - Integer.parseInt(cancel_cnt) + last_unsolve_cnt;
        		//nTempUnsolve = Integer.parseInt(suim_cnt) - Integer.parseInt(end_cnt) - Integer.parseInt(cancel_cnt) + last_unsolve_cnt + Integer.parseInt(trans_cnt);
        		
        		//해당 기준일로 기존에 취소되었던 건이 있는지 확인
        		before_cancel_cnt = sqlSession.selectOne("ItMgmtMapper.selectWrittenListBeforeCancel", paramMap);
        		
        		//해당 기준일로 기존에 취소되었던 건이 있는지 확인
        		before_trans_cnt = sqlSession.selectOne("ItMgmtMapper.selectWrittenListBeforeTrans", paramMap);
        		
        		//System.out.println("before_cancel_cnt="+before_cancel_cnt);
        		
        		//미결 = 수임건 - 종결건 + 기존미결 + 기존 취소건 + 기존이내첩건
        		nTempUnsolve = Integer.parseInt(suim_cnt) - Integer.parseInt(end_cnt) + last_unsolve_cnt - before_cancel_cnt - before_trans_cnt;
        		
        		unsolve_cnt = String.valueOf(nTempUnsolve);
        		
        		//계산된 미결건수로 셋팅
        		paramMap.put("unsolve_cnt", unsolve_cnt);
        		
        		int nCount = 0;
        		nCount = sqlSession.selectOne("ItMgmtMapper.selectWrittenListCount", paramMap);
        		
        		if( nCount == 0 ){
        			//신규 추가
        			sqlSession.insert("ItMgmtMapper.insertWrittenList", paramMap);
        			nInCnt++;
        			
        			//로그추가
        			paramMap.put("log_action", "insert");
        			paramMap.put("trans_user_no", "0");
        			paramMap.put("suim_date", base_date);
        			sqlSession.insert("ItMgmtMapper.insertWrittenListLog", paramMap);
        		}else{
        			//갱신
        			sqlSession.update("ItMgmtMapper.updateWrittenList", paramMap);
        			nUpCnt++;
        			
        			//로그추가
        			paramMap.put("log_action", "update");
        			paramMap.put("trans_user_no", "0");
        			paramMap.put("suim_date", base_date);
        			sqlSession.insert("ItMgmtMapper.insertWrittenListLog", paramMap);
        		}
    		}
    	}
    	
    	returnMsg += "추가 : "+nInCnt+"건\n";
    	returnMsg += "갱신 : "+nUpCnt+"건";
    	
    	if(!"".equals(sFailUser)) {
    		returnMsg += "\n\n============== 추가알림 ===============";
    		returnMsg += "\n기준일 이후 정보가 존재하여 갱신에 실패한 직원\n("+sFailUser+")\n";
    		returnMsg += "※ 기준일 이후의 정보를 삭제 후 갱신해 주십시오.\n";
    		returnMsg += "====================================";
    	}
    	
    	returnMap.put("msg", returnMsg);
    	
    	//return nCnt;
    	return returnMap;
    }
    
    /**
     * 서면심사 종결 및 수임 통계조회
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    
    @RequestMapping(value="writtenReviewSearch")
	public String writtenReviewSearch(HttpServletRequest request, Model model) throws Exception {
    	logger.info("==== writtenReviewSearch =====");
		
		String retURL="top_statistics/written_review_search";
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		//검색 파라미터		
		String s_team_id = request.getParameter("s_team_id") != null ? request.getParameter("s_team_id") : "";		//팀아이디
		String s_user_no = request.getParameter("s_user_no") != null ? request.getParameter("s_user_no") : "";		//사용자아이디
		String s_out_user = request.getParameter("s_out_user") != null ? request.getParameter("s_out_user") : "0";	//퇴사자조회여부
		String s_base_date = request.getParameter("s_base_date") != null ? request.getParameter("s_base_date") : "";		//기준일
				
		List<TopTmBscVO> memberList;
		
		if( "1".equals(s_out_user) ) {
			// 퇴사자를 포함한 직원리스트 가져오기
			memberList = sqlSession.selectList("ItMgmtMapper.selectWrittenTopMemberListAll", paramMap);
		}else {
			// 퇴사자 제외 직원리스트 가져오기
			memberList = sqlSession.selectList("ItMgmtMapper.selectWrittenTopMemberList", paramMap);
		}
		
		// 팀목록 가져오기		
		List<Map<String, Object>> teamList = sqlSession.selectList("ItMgmtMapper.selectWrittenTeamList");		
		
		model.addAttribute("memberList", memberList);		
		model.addAttribute("teamList", teamList);
		
		//기준일이 없는경우 오늘 날짜 지정
    	String sToday = DateUtil.getTodayString("yyyy-MM-dd");    	
    	model.addAttribute("sToday", sToday);
		
		//검색 파라미터 셋팅
		model.addAttribute("s_team_id", s_team_id);
		model.addAttribute("s_user_no", s_user_no);
		model.addAttribute("s_out_user", s_out_user);
		model.addAttribute("s_base_date", s_base_date);
		
		return retURL;
    }
    
    /**
     * 서면심사 종결건수 관리 목록 신규 ajax 가져오기
     * @param request
     * @param model
     * @return
     */    
    @RequestMapping(value="/getWrittenListOneExcel")
    public String getWrittenListOneExcel(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getWrittenListOneExcel =========");
    	    	
    	String sUrl = "top_statistics/written_review_manage_one_excel";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);    	

    	List<Map<String, Object>> writtenList = sqlSession.selectList("ItMgmtMapper.selectWrittenSearchOne",paramMap);
    	
    	model.addAttribute("writtenList", writtenList);
    	
    	return sUrl;
    }
    
    /**
     * 서면심사 종결건수 관리 목록 신규 ajax 가져오기
     * @param request
     * @param model
     * @return
     */    
    @RequestMapping(value="/getWrittenListNewExcel")
    public String getWrittenListNewExcel(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getWrittenListNewExcel =========");
    	    	
    	String sUrl = "top_statistics/written_review_manage_new_excel";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);    	

    	List<Map<String, Object>> writtenList = sqlSession.selectList("ItMgmtMapper.selectWrittenSearchList",paramMap);
    	
    	model.addAttribute("writtenList", writtenList);
    	
    	return sUrl;
    }
    
    /**
     * 서면심사 개별 관리 목록 신규 ajax 가져오기
     * @param request
     * @param model
     * @return
     */    
    @RequestMapping(value="/getWrittenListOne")
    public String getWrittenListOne(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getWrittenListOne =========");
    	    	
    	String sUrl = "top_statistics/written_review_manage_one_ajax";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	//검색 파라미터		
		String s_team_id = request.getParameter("s_team_id") != null ? request.getParameter("s_team_id") : "";		//팀아이디
		String s_ptnr_id = request.getParameter("s_ptnr_id") != null ? request.getParameter("s_ptnr_id") : "0";		//보험사아이디
		String s_user_no = request.getParameter("s_user_no") != null ? request.getParameter("s_user_no") : "";		//사용자아이디		
		String s_base_date = request.getParameter("s_base_date") != null ? request.getParameter("s_base_date") : "";		//검색시작 기준일
		String e_base_date = request.getParameter("e_base_date") != null ? request.getParameter("e_base_date") : "";		//검색종료 기준일
		
		//System.out.println(s_team_id+" : "+s_user_no+" : "+s_base_date+" : "+e_base_date);
		
		//CommonUtils.printMap(paramMap);		

    	// 검색결과 가져오기
    	List<Map<String, Object>> writtenList = sqlSession.selectList("ItMgmtMapper.selectWrittenSearchOne",paramMap);
    	
    	model.addAttribute("writtenList", writtenList);
    	
    	return sUrl;
    }
    
    /**
     * 서면심사 종결건수 팀 관리 엑셀 다운로드
     * @param request
     * @param model
     * @return
     */    
    @RequestMapping(value="/getWrittenTeamListNewExcel")
    public String getWrittenTeamListNewExcel(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getWrittenTeamListNewExcel =========");    	    	

    	String sUrl = "top_statistics/written_review_manage_team_new_excel";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	//검색 파라미터		
		String s_team_id = request.getParameter("s_team_id") != null ? request.getParameter("s_team_id") : "";		//팀아이디
		String s_user_no = request.getParameter("s_user_no") != null ? request.getParameter("s_user_no") : "";		//사용자아이디		
		String s_base_date = request.getParameter("s_base_date") != null ? request.getParameter("s_base_date") : "";		//검색시작 기준일
		String e_base_date = request.getParameter("e_base_date") != null ? request.getParameter("e_base_date") : "";		//검색종료 기준일
		
		String [] s_team_id_sub = request.getParameterValues("s_team_id_sub");			//검색할 팀목록
		
		String searchTeamList = "";
		
		if( s_team_id_sub.length > 0) {
			searchTeamList = Arrays.toString(s_team_id_sub);
			searchTeamList = searchTeamList.replaceAll("\\[", "");
			searchTeamList = searchTeamList.replaceAll("\\]", "");
		}
		
		if( searchTeamList.contains("9999") || "".equals(searchTeamList) ) {		//문자열에 전체가 포함되어있으면 그냥 전체로 검색한다.
			searchTeamList = "9999";
		}
		
		//검색할 팀목록
		paramMap.put("searchTeamList", searchTeamList);
		
    	//팀검색목록 가져오기
    	List<Map<String, Object>> writtenTeamList;
    	
    	List<Map<String, Object>> writtenTeamCalList;		//각 팀별 계산값을 넣기위한 임시 List
    	
    	if( "9999".equals(searchTeamList) ) {		//전체검색인경우
    		writtenTeamList = sqlSession.selectList("ItMgmtMapper.selectWrittenTeamList");
    	}else{							//특정팀 인 경우
    		paramMap.put("sTeamlist", searchTeamList);
    		writtenTeamList = sqlSession.selectList("ItMgmtMapper.selectWrittenSearchTeamList",paramMap);
    	}
    	
    	//검색대상팀의 각 건수를 계산한다.
    	for(int i=0; i < writtenTeamList.size(); i++) {
    		paramMap.put("cal_team_id", writtenTeamList.get(i).get("teamId").toString());
    		
    		writtenTeamCalList = sqlSession.selectList("ItMgmtMapper.selectWrittenCalTeamList",paramMap);
    		
    		if( writtenTeamCalList.size() == 0 ) {
    			writtenTeamList.get(i).put("suimCnt", "0");
        		writtenTeamList.get(i).put("endCnt", "0");
        		writtenTeamList.get(i).put("unsolveCnt", "0");
        		writtenTeamList.get(i).put("transCnt", "0");
        		writtenTeamList.get(i).put("transCntMinus", "0");
        		writtenTeamList.get(i).put("cancelCnt", "0");
        		writtenTeamList.get(i).put("baseDate", "-");
        		writtenTeamList.get(i).put("baseDateFmt", "-");
        		writtenTeamList.get(i).put("regDate", "-");
        		writtenTeamList.get(i).put("regDateFmt", "-");
    		}else{    			
        		writtenTeamList.get(i).put("suimCnt", writtenTeamCalList.get(0).get("suimCnt").toString());
        		writtenTeamList.get(i).put("endCnt", writtenTeamCalList.get(0).get("endCnt").toString());
        		writtenTeamList.get(i).put("unsolveCnt", writtenTeamCalList.get(0).get("unsolveCnt").toString());
        		writtenTeamList.get(i).put("transCnt", writtenTeamCalList.get(0).get("transCnt").toString());
        		writtenTeamList.get(i).put("transCntMinus", Integer.parseInt(writtenTeamCalList.get(0).get("transCnt").toString())*-1);
        		writtenTeamList.get(i).put("cancelCnt", writtenTeamCalList.get(0).get("cancelCnt").toString());
        		writtenTeamList.get(i).put("baseDate", writtenTeamCalList.get(0).get("baseDate").toString());
        		writtenTeamList.get(i).put("baseDateFmt", writtenTeamCalList.get(0).get("baseDateFmt").toString());
        		writtenTeamList.get(i).put("regDate", writtenTeamCalList.get(0).get("regDate").toString());
        		writtenTeamList.get(i).put("regDateFmt", writtenTeamCalList.get(0).get("regDateFmt").toString());
    		}
    	}
    	
    	model.addAttribute("writtenTeamList", writtenTeamList);
    	
    	return sUrl;
    }
    
    /**
     * 서면심사 종결건수 팀 관리 목록 신규 ajax 가져오기
     * @param request
     * @param model
     * @return
     */    
    @RequestMapping(value="/getWrittenTeamListNew")
    public String getWrittenTeamListNew(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getWrittenTeamListNew =========");
    	    	
    	String sUrl = "top_statistics/written_review_manage_team_new_ajax";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	//검색 파라미터		
		String s_team_id = request.getParameter("s_team_id") != null ? request.getParameter("s_team_id") : "";		//팀아이디		
		String s_user_no = request.getParameter("s_user_no") != null ? request.getParameter("s_user_no") : "";		//사용자아이디		
		String s_base_date = request.getParameter("s_base_date") != null ? request.getParameter("s_base_date") : "";		//검색시작 기준일
		String e_base_date = request.getParameter("e_base_date") != null ? request.getParameter("e_base_date") : "";		//검색종료 기준일
		
		String [] s_team_id_sub = request.getParameterValues("s_team_id_sub");			//검색할 팀목록
		
		String searchTeamList = "";

		//System.out.println("s_team_id_sub length="+s_team_id_sub.length);
		
		if( s_team_id_sub.length > 0) {
			searchTeamList = Arrays.toString(s_team_id_sub);
			searchTeamList = searchTeamList.replaceAll("\\[", "");
			searchTeamList = searchTeamList.replaceAll("\\]", "");
		}
		
		if( searchTeamList.contains("9999") || "".equals(searchTeamList) ) {		//문자열에 전체가 포함되어있으면 그냥 전체로 검색한다.
			searchTeamList = "9999";
		}
		
		//System.out.println("searchTeamList="+searchTeamList);
		
		//검색할 팀목록
		paramMap.put("searchTeamList", searchTeamList);
		
    	//팀검색목록 가져오기
    	List<Map<String, Object>> writtenTeamList;
    	
    	List<Map<String, Object>> writtenTeamCalList;		//각 팀별 계산값을 넣기위한 임시 List
    	
    	if( "9999".equals(searchTeamList) ) {		//전체검색인경우
    		writtenTeamList = sqlSession.selectList("ItMgmtMapper.selectWrittenTeamList");
    	}else{							//특정팀 인 경우
    		paramMap.put("sTeamlist", searchTeamList);
    		writtenTeamList = sqlSession.selectList("ItMgmtMapper.selectWrittenSearchTeamList",paramMap);
    	}
    	
    	//CommonUtils.printMap(paramMap);
    	//CommonUtils.printList(writtenTeamList);    	
    	
    	//검색대상팀의 각 건수를 계산한다.
    	for(int i=0; i < writtenTeamList.size(); i++) {
    		paramMap.put("cal_team_id", writtenTeamList.get(i).get("teamId").toString());
    		
    		writtenTeamCalList = sqlSession.selectList("ItMgmtMapper.selectWrittenCalTeamList",paramMap);
    		
    		if( writtenTeamCalList.size() == 0 ) {
    			writtenTeamList.get(i).put("suimCnt", "0");
        		writtenTeamList.get(i).put("endCnt", "0");
        		writtenTeamList.get(i).put("unsolveCnt", "0");
        		writtenTeamList.get(i).put("transCnt", "0");
        		writtenTeamList.get(i).put("transCntMinus", "0");
        		writtenTeamList.get(i).put("cancelCnt", "0");
        		writtenTeamList.get(i).put("baseDate", "-");
        		writtenTeamList.get(i).put("baseDateFmt", "-");
        		writtenTeamList.get(i).put("regDate", "-");
        		writtenTeamList.get(i).put("regDateFmt", "-");
    		}else{    			
        		writtenTeamList.get(i).put("suimCnt", writtenTeamCalList.get(0).get("suimCnt").toString());
        		writtenTeamList.get(i).put("endCnt", writtenTeamCalList.get(0).get("endCnt").toString());
        		writtenTeamList.get(i).put("unsolveCnt", writtenTeamCalList.get(0).get("unsolveCnt").toString());
        		writtenTeamList.get(i).put("transCnt", writtenTeamCalList.get(0).get("transCnt").toString());
        		writtenTeamList.get(i).put("transCntMinus", Integer.parseInt(writtenTeamCalList.get(0).get("transCnt").toString()) * -1 );
        		writtenTeamList.get(i).put("cancelCnt", writtenTeamCalList.get(0).get("cancelCnt").toString());
        		writtenTeamList.get(i).put("baseDate", writtenTeamCalList.get(0).get("baseDate").toString());
        		writtenTeamList.get(i).put("baseDateFmt", writtenTeamCalList.get(0).get("baseDateFmt").toString());
        		writtenTeamList.get(i).put("regDate", writtenTeamCalList.get(0).get("regDate").toString());
        		writtenTeamList.get(i).put("regDateFmt", writtenTeamCalList.get(0).get("regDateFmt").toString());
    		}
    	}
    	
    	//CommonUtils.printList(writtenTeamList);    	
    	
    	model.addAttribute("writtenTeamList", writtenTeamList);
    	
    	return sUrl;
    }
    
    /**
     * 서면심사 종결건수 관리 목록 신규 ajax 가져오기
     * @param request
     * @param model
     * @return
     */    
    @RequestMapping(value="/getWrittenListNew")
    public String getWrittenListNew(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getWrittenListNew =========");
    	    	
    	String sUrl = "top_statistics/written_review_manage_new_ajax";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	//검색 파라미터		
		String s_team_id = request.getParameter("s_team_id") != null ? request.getParameter("s_team_id") : "";		//팀아이디
		String s_ptnr_id = request.getParameter("s_ptnr_id") != null ? request.getParameter("s_ptnr_id") : "0";		//보험사아이디
		String s_user_no = request.getParameter("s_user_no") != null ? request.getParameter("s_user_no") : "";		//사용자아이디		
		String s_base_date = request.getParameter("s_base_date") != null ? request.getParameter("s_base_date") : "";		//검색시작 기준일
		String e_base_date = request.getParameter("e_base_date") != null ? request.getParameter("e_base_date") : "";		//검색종료 기준일
		
    	// 검색결과 가져오기
    	List<Map<String, Object>> writtenList = sqlSession.selectList("ItMgmtMapper.selectWrittenSearchList",paramMap);
    	
    	model.addAttribute("writtenList", writtenList);    	
    	
    	return sUrl;
    }
    
    /**
     * 서면심사 실적개별관리(수정)
     * @param request
     * @param model
     * @return
     * @throws Exception
     */    
    @RequestMapping(value="writtenReviewManageOne")
	public String writtenReviewManageOne(HttpServletRequest request, Model model) throws Exception {
    	logger.info("==== writtenReviewManageOne =====");
		
		String retURL="top_statistics/written_review_manage_one";
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);		
		
		//검색기준일이 없는 경우 오늘날짜로 셋팅
		String sToday = DateUtil.getTodayString("yyyy-MM-dd");
		String sYesterday = DateUtil.addDateNew(sToday, -1);
		
		//검색 파라미터		
		String s_team_id = request.getParameter("s_team_id") != null ? request.getParameter("s_team_id") : "";		//팀아이디
		String s_ptnr_id = request.getParameter("s_ptnr_id") != null ? request.getParameter("s_ptnr_id") : "0";		//보험사아이디
		String s_user_no = request.getParameter("s_user_no") != null ? request.getParameter("s_user_no") : "";		//사용자아이디
		String s_out_user = request.getParameter("s_out_user") != null ? request.getParameter("s_out_user") : "0";	//퇴사자조회여부
		String s_base_date = request.getParameter("s_base_date") != null ? request.getParameter("s_base_date") : sYesterday;		//검색시작 기준일을 어제날짜로 변경
		String e_base_date = request.getParameter("e_base_date") != null ? request.getParameter("e_base_date") : sYesterday;		//검색종료 기준일을 어제날짜로 변경
		
		paramMap.put("s_base_date", s_base_date);
		paramMap.put("e_base_date", e_base_date);
		
		// 팀목록 가져오기		
		List<Map<String, Object>> teamList = sqlSession.selectList("ItMgmtMapper.selectWrittenTeamList");
		
		//서면심사용 보험사목록 불러오기
		List<Map<String, Object>> writtenPtnrIdList = sqlSession.selectList("MisPtnrBsc.selectWrittenPtnrInfo");
		model.addAttribute("writtenPtnrIdList", writtenPtnrIdList);
		
		//사용자목록 가져오기
		List<TopTmBscVO> memberList;
		List<TopTmBscVO> addMemberList;		//개별등록 사용자 (항상 퇴직자 포함)
		
		//addMemberList = sqlSession.selectList("ItMgmtMapper.selectWrittenTopMemberListAll", paramMap);
		
		//퇴직자를 포함한 전직원으로 변경		
		addMemberList = sqlSession.selectList("ItMgmtMapper.selectTopMemberListAll", paramMap);
		
		if( "1".equals(s_out_user) ) {
			// 퇴사자를 포함한 직원리스트 가져오기
			memberList = sqlSession.selectList("ItMgmtMapper.selectWrittenTopMemberListAll", paramMap);			
		}else {
			// 퇴사자 제외 직원리스트 가져오기
			memberList = sqlSession.selectList("ItMgmtMapper.selectWrittenTopMemberList", paramMap);
		}
		
		model.addAttribute("addMemberList",addMemberList);
		model.addAttribute("memberList", memberList);
		model.addAttribute("teamList", teamList);
		
		//검색 파라미터 셋팅
		model.addAttribute("s_team_id", s_team_id);
		model.addAttribute("s_user_no", s_user_no);
		model.addAttribute("s_out_user", s_out_user);
		model.addAttribute("s_base_date", s_base_date);
		model.addAttribute("e_base_date", e_base_date);
		
		return retURL;
    }
    
    /**
     * 서면심사 실적관리 신규
     * @param request
     * @param model
     * @return
     * @throws Exception
     */    
    @RequestMapping(value="writtenReviewManageNew")
	public String writtenReviewManageNew(HttpServletRequest request, Model model) throws Exception {
    	logger.info("==== writtenReviewManageNew =====");
		
		String retURL="top_statistics/written_review_manage_new";
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sStartToday = DateUtil.getStartMonthDay();			//한달간격의 시작일자
		String sEndToday = DateUtil.getEndMonthDay();				//한달간격의 종료일자
		
		sStartToday = DateUtil.getDateFormat(sStartToday, "-");
		sEndToday = DateUtil.getDateFormat(sEndToday, "-");		
		
		//System.out.println(sStartToday+" : "+sEndToday);
		
		//검색 파라미터		
		String s_team_id = request.getParameter("s_team_id") != null ? request.getParameter("s_team_id") : "";		//팀아이디
		String s_ptnr_id = request.getParameter("s_ptnr_id") != null ? request.getParameter("s_ptnr_id") : "0";		//보험사아이디
		String s_user_no = request.getParameter("s_user_no") != null ? request.getParameter("s_user_no") : "";		//사용자아이디
		String s_out_user = request.getParameter("s_out_user") != null ? request.getParameter("s_out_user") : "0";	//퇴사자조회여부
		String s_base_date = request.getParameter("s_base_date") != null ? request.getParameter("s_base_date") : sStartToday;		//검색시작 기준일
		String e_base_date = request.getParameter("e_base_date") != null ? request.getParameter("e_base_date") : sEndToday;		//검색종료 기준일
		
		// 팀목록 가져오기		
		List<Map<String, Object>> teamList = sqlSession.selectList("ItMgmtMapper.selectWrittenTeamList");
		
		//서면심사용 보험사목록 불러오기
		List<Map<String, Object>> writtenPtnrIdList = sqlSession.selectList("MisPtnrBsc.selectWrittenPtnrInfo");
		model.addAttribute("writtenPtnrIdList", writtenPtnrIdList);
		
		//사용자목록 가져오기
		List<TopTmBscVO> memberList;
		
		if( "1".equals(s_out_user) ) {
			// 퇴사자를 포함한 직원리스트 가져오기
			memberList = sqlSession.selectList("ItMgmtMapper.selectWrittenTopMemberListAll", paramMap);			
		}else {
			// 퇴사자 제외 직원리스트 가져오기
			memberList = sqlSession.selectList("ItMgmtMapper.selectWrittenTopMemberList", paramMap);
		}
		
		model.addAttribute("memberList", memberList);
		model.addAttribute("teamList", teamList);
		
		//검색 파라미터 셋팅
		model.addAttribute("s_team_id", s_team_id);
		model.addAttribute("s_ptnr_id", s_ptnr_id);
		model.addAttribute("s_user_no", s_user_no);
		model.addAttribute("s_out_user", s_out_user);
		model.addAttribute("s_base_date", s_base_date);
		model.addAttribute("e_base_date", e_base_date);
		
		return retURL;
    }
	
	/**
	 * 서면심사 종결 및 수임 등록 관리
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 * @author top3009
	 */
	@RequestMapping(value="writtenReviewManage")
	public String writtenReviewManage(HttpServletRequest request, Model model) throws Exception {
		
		logger.info("==== writtenReviewManage =====");
		
		String retURL="top_statistics/written_review_manage";
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sToday = DateUtil.getTodayString("yyyy-MM-dd");
		String sYesterday = DateUtil.addDateNew(sToday, -1);
		
		//검색 파라미터		
		String s_team_id = request.getParameter("s_team_id") != null ? request.getParameter("s_team_id") : "";		//팀아이디
		String s_user_no = request.getParameter("s_user_no") != null ? request.getParameter("s_user_no") : "";		//사용자아이디
		String s_out_user = request.getParameter("s_out_user") != null ? request.getParameter("s_out_user") : "0";	//퇴사자조회여부
		String s_base_date = request.getParameter("s_base_date") != null ? request.getParameter("s_base_date") : sYesterday;		//기준일을 어제날짜로 변경
		
		List<TopTmBscVO> memberList;
		List<TopTmBscVO> addMemberList;		//개별등록 사용자 (항상 퇴직자 포함)
		
		addMemberList = sqlSession.selectList("ItMgmtMapper.selectWrittenTopMemberListAll", paramMap);
		
		if( "1".equals(s_out_user) ) {
			// 퇴사자를 포함한 직원리스트 가져오기
			memberList = sqlSession.selectList("ItMgmtMapper.selectWrittenTopMemberListAll", paramMap);			
		}else {
			// 퇴사자 제외 직원리스트 가져오기
			memberList = sqlSession.selectList("ItMgmtMapper.selectWrittenTopMemberList", paramMap);
		}		
		
		// 팀목록 가져오기		
		List<Map<String, Object>> teamList = sqlSession.selectList("ItMgmtMapper.selectWrittenTeamList");
		
		//서면심사용 보험사목록 불러오기
		List<Map<String, Object>> writtenPtnrIdList = sqlSession.selectList("MisPtnrBsc.selectWrittenPtnrInfo");
		model.addAttribute("writtenPtnrIdList", writtenPtnrIdList);
		
		// 검색결과 가져오기
		//List<Map<String, Object>> writtenList = sqlSession.selectList("ItMgmtMapper.selectWrittenMemberList",paramMap);
		
		model.addAttribute("memberList", memberList);		
		model.addAttribute("teamList", teamList);		
		
		//개별등록용 사용자목록
		model.addAttribute("addMemberList", addMemberList);
		
		//검색 파라미터 셋팅
		model.addAttribute("s_team_id", s_team_id);
		model.addAttribute("s_user_no", s_user_no);
		model.addAttribute("s_out_user", s_out_user);
		model.addAttribute("s_base_date", s_base_date);
		
		return retURL;		
	}

	@RequestMapping(value = "expenseMain")
	public String expenseMain(HttpServletRequest request, Model model) throws Exception {

		logger.info("==== expenseMain =====");

		String retURL = "top_statistics/expense_main";

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();

		if (!"1".equals(mbrAuthVo.getMbr_pms_21())) {
			return "redirect:/";
		}

		// ===============================================
		// 파라미터 체크
		// ===============================================
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

		// ===============================================
		// 현재 일자 세팅
		// ===============================================
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde")); // 기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde")); // 기준일자 종료일
		String excelYN = StringUtil.null2blank(request.getParameter("excelYN")); // 엑셀다운 여부
		// String tabType = StringUtil.null2blank(request.getParameter("tabType"));
		// //탭종류(1: 1종, 4: 4종, 5: 1+4종)
		String tabType = "1"; // 탭종류(1: 1종, 4: 4종, 5: 1+4종)
		String dataUpdate = StringUtil.null2blank(request.getParameter("dataUpdate")); // 이재조사비 임시테이블 갱신여부 (Y:업데이트)

		if ("".equals(stdBgnde)) {
			stdBgnde = DateUtil.getStartMonthDay();
			stdEndde = DateUtil.getEndMonthDay();

			stdBgnde = DateUtil.getDateFormat(stdBgnde, "-");
			stdEndde = DateUtil.getDateFormat(stdEndde, "-");

			paramMap.put("stdBgnde", stdBgnde);
			paramMap.put("stdEndde", stdEndde);
			paramMap.put("excelYN", "N");

			// =============================================
			// 수임 농작물 적부 기본값 세팅
			// =============================================
			paramMap.put("basicYN", "Y");
			paramMap.put("primYN", "Y");
			paramMap.put("contractYN", "N");
		}

		// ===============================================
		// 필요 날짜 SET
		// ===============================================
		String bgnDe = stdBgnde.replace("-", "");
		String endDe = DateUtil.addDate(stdEndde.replace("-", ""), 1);
		String bgnYearDe = (Integer.parseInt(endDe.substring(0, 4)) - 1) + "1216";
		String endYearDe = endDe.substring(0, 4) + "1216";
		String sEndyear = endDe.substring(0, 4) + "-12-16";

		paramMap.put("bgnDe", bgnDe);
		paramMap.put("endDe", endDe);
		paramMap.put("bgnYearDe", bgnYearDe);
		paramMap.put("endYearDe", endYearDe);

		// 사용자별 년 목표량
		int year = Integer.parseInt(bgnDe.substring(0, 4));
		int month = Integer.parseInt(bgnDe.substring(4, 6));
		int day = Integer.parseInt(bgnDe.substring(6, 8));

		if (month == 12 && day > 15) {
			++year;
		}

		int eYear = Integer.parseInt(stdEndde.substring(0, 4));
		int eMonth = Integer.parseInt(stdEndde.substring(5, 7));
		int eDay = Integer.parseInt(stdEndde.substring(8, 10));

		// 월계산기준 날짜 (이번달 해당월 16일)
		String chkMonthDate = "";

		// 검색종료날짜기준
		if (eDay > 15) {
			eMonth = eMonth + 1;
			month = month + 1;
		}

		if (eMonth < 10) {
			chkMonthDate = String.valueOf(eYear) + "-0" + String.valueOf(eMonth) + "-17";
		} else {
			chkMonthDate = String.valueOf(eYear) + "-" + String.valueOf(eMonth) + "-17";
		}

		// 월계산기준 날짜 (지난달 해당월 17일)
		String chkLastMonthDate = "";

		if ((eMonth - 1) == 0) {
			chkLastMonthDate = String.valueOf(year - 1) + "-12-17"; // 연마감처리로 인해 하루 추가 16일기준으로 계산
		} else {
			if ((eMonth - 1) < 10) {
				chkLastMonthDate = String.valueOf(year) + "-0" + String.valueOf(eMonth - 1) + "-17";
			} else {
				chkLastMonthDate = String.valueOf(year) + "-" + String.valueOf(eMonth - 1) + "-17";
			}
		}

		paramMap.put("chkLastMonthDate", chkLastMonthDate);
		paramMap.put("chkMonthDate", chkMonthDate);
		paramMap.put("sEndyear", sEndyear);
		paramMap.put("year", year); // 기준업무량 년목표계산을 위한 변수

		// System.out.println("year="+year);
		// System.out.println("sEndyear="+sEndyear);

		// System.out.println("bgnDe="+bgnDe);
		// System.out.println("endDe="+endDe);
		// System.out.println("tabType="+tabType);

		// 기준년 월
		String baseYear = stdEndde.substring(0, 4);
		String baseMonth = stdEndde.substring(5, 7);

		// System.out.println("baseYear="+baseYear);
		// System.out.println("baseMonth="+baseMonth);
		// System.out.println("dataUpdate="+dataUpdate);

		// 이재조사비 조회용 직원리스트 가져오기
		// List<TopTmBscVO> memberList =
		// sqlSession.selectList("StatisticBasic.selectExpenseMemberList",paramMap);

		List<Map<String, Object>> memberList = sqlSession.selectList("StatisticBasic.selectExpenseMemberList",
				paramMap);

		double workloadMonth = 0;
		String workloadCal = ""; // 기준업무량 달성량
		double workloadPer = 0; // 기준업무량 달성률

		float amt_daily = 0;
		float share_amt_daily = 0;
		float sum_amt_daily = 0;

		int amt_daily_val = 0;
		int share_amt_daily_val = 0;
		int sum_amt_daily_val = 0;

		float amt_basic = 0;
		float share_amt_basic = 0;
		float sum_amt_basic = 0;

		int amt_basic_val = 0;
		int share_amt_basic_val = 0;
		int sum_amt_basic_val = 0;
		
		float amt_traffic = 0;
		float share_amt_traffic = 0;
		float sum_amt_traffic = 0;

		int amt_traffic_val = 0;
		int share_amt_traffic_val = 0;
		int sum_amt_traffic_val = 0;

		float inside_cost = 0; // 간접비
		//float inside_cost_base = 37000000; // 2019년 간접비 기본액
		String member_avg = "";
		float member_avg_val = 0;

		int nCenterManage_cost = 0; // 센터품질관리비
		
		int nMac_cnt = 0;		//서면심사(맥도날드) 갯수
		int nWc_cnt = 0;			//서면심사(WC) 갯수
		int nSs_cnt = 0;			//서면심사(스마트스코어) 갯수
		
		double dExtra_cnt = 0;		//서면심사 물보험심사센터제외 금액
		
		double suhyp_workload_ea = 0;		//수협기준업무량 건수 (승신지원비계산용)
		double suhyp_workload_cost = 0;		//승선지원비
		
		double cow_workload_ea = 0;			//가축재해 기준업무량 건수 (가축재해이재조사비)
		double cow_workload_cost = 0;		//가축재해이재조사비

		// 재계산 후 입력 (월목표)
		for (int i = 0; i < memberList.size(); i++) {
			// Map<String,Object> map = memberList.get(i);

			// 기준년월 추가
			memberList.get(i).put("baseYear", baseYear);
			memberList.get(i).put("baseMonth", baseMonth);
			
			paramMap.put("user_no", memberList.get(i).get("userNo").toString());

			if ("0".equals(memberList.get(i).get("workloadYear").toString())) {
				workloadMonth = 0;
				memberList.get(i).put("workloadMonth", workloadMonth);
				memberList.get(i).put("workloadCal", "0");
				memberList.get(i).put("workloadPer", "0");
				
				memberList.get(i).put("amtBasic", "0");
				memberList.get(i).put("shareAmtBasic", "0");
				memberList.get(i).put("sumAmtBasic", "0");
				
				memberList.get(i).put("amtDaily", "0");
				memberList.get(i).put("shareAmtDaily", "0");
				memberList.get(i).put("sumAmtDaily", "0");				
				
				memberList.get(i).put("amtTraffic", "0");
				memberList.get(i).put("shareAmtTraffic", "0");
				memberList.get(i).put("sumAmtTraffic", "0");				
			} else {
				workloadMonth = Double.parseDouble(memberList.get(i).get("workloadYear").toString()) / 12;
				workloadMonth = (Math.round(workloadMonth * 1000)) / 1000.0; // 소숫점 3째자리까지 표기, 반올림처리
				memberList.get(i).put("workloadMonth", workloadMonth);

				// 기준업무량 계산값 가져오기 by oniku
				workloadCal = getUserWorkpoint(memberList.get(i).get("userNo").toString(), bgnDe, endDe);
				memberList.get(i).put("workloadCal", workloadCal);
				// 기준업무량 달성률 계산하기
				workloadPer = Double.parseDouble(workloadCal) * 100 / workloadMonth;
				workloadPer = (Math.round(workloadPer * 1000)) / 1000.0; // 소숫점 3째자리까지 표기, 반올림처리
				memberList.get(i).put("workloadPer", workloadPer);

				// 기본비(수수료매출) 일비계산 시작				
				Map<String, Object> amtDaily = sqlSession.selectOne("StatisticBasic.selectAmtDailyPerson", paramMap);

				amt_basic = Float.parseFloat(amtDaily.get("amtBasic").toString());
				share_amt_basic = Float.parseFloat(amtDaily.get("shareAmtBasic").toString());
				sum_amt_basic = amt_basic + share_amt_basic;

				amt_basic_val = Math.round(amt_basic);
				share_amt_basic_val = Math.round(share_amt_basic);
				sum_amt_basic_val = Math.round(sum_amt_basic);

				memberList.get(i).put("amtBasic", amt_basic_val);
				memberList.get(i).put("shareAmtBasic", share_amt_basic_val);
				memberList.get(i).put("sumAmtBasic", sum_amt_basic_val);

				amt_daily = Float.parseFloat(amtDaily.get("amtDaily").toString());
				share_amt_daily = Float.parseFloat(amtDaily.get("shareAmtDaily").toString());
				sum_amt_daily = amt_daily + share_amt_daily;

				amt_daily_val = Math.round(amt_daily);
				share_amt_daily_val = Math.round(share_amt_daily);
				sum_amt_daily_val = Math.round(sum_amt_daily);

				memberList.get(i).put("amtDaily", amt_daily_val);
				memberList.get(i).put("shareAmtDaily", share_amt_daily_val);
				memberList.get(i).put("sumAmtDaily", sum_amt_daily_val);
				
				//수정
				amt_traffic = Float.parseFloat(amtDaily.get("amtTraffic").toString());
				share_amt_traffic = Float.parseFloat(amtDaily.get("shareAmtTraffic").toString());
				sum_amt_traffic = amt_traffic + share_amt_traffic;

				amt_traffic_val = Math.round(amt_traffic);
				share_amt_traffic_val = Math.round(share_amt_traffic);
				sum_amt_traffic_val = Math.round(sum_amt_traffic);

				memberList.get(i).put("amtTraffic", amt_traffic_val);
				memberList.get(i).put("shareAmtTraffic", share_amt_traffic_val);
				memberList.get(i).put("sumAmtTraffic", sum_amt_traffic_val);
				// 수수료매출, 일비계산, 교통비 끝
			}
			
			//서면심사 맥도날드, WC 계산 시작
			nMac_cnt = sqlSession.selectOne("StatisticBasic.countMcHead", paramMap);
			nWc_cnt = sqlSession.selectOne("StatisticBasic.countWcHead", paramMap);
			//서면심사 스마트스코어 추가 계산 시작
			nSs_cnt = sqlSession.selectOne("StatisticBasic.countSsHead", paramMap);
			
			if( nMac_cnt == 0 ) {
				memberList.get(i).put("mcCost", 0);
			}else {
				memberList.get(i).put("mcCost", nMac_cnt * 10000);		//서면심사 맥도날드 금액 (갯수 X 10000)
			}
			
			if( nWc_cnt == 0 ) {
				memberList.get(i).put("wcCost", 0);			//서면심사 WC 금액 (갯수 X 10000)
			}else {
				memberList.get(i).put("wcCost", nWc_cnt * 5000);			//서면심사 WC 금액 (갯수 X 5000)
			}
			
			if( nSs_cnt == 0 ) {
				memberList.get(i).put("ssCost", 0);			//서면심사 WC 금액 (갯수 X 10000)
			}else {
				memberList.get(i).put("ssCost", nSs_cnt * 10000);			//서면심사 스마트스코어 금액 (갯수 X 10000)
			}				
			//서면심사 맥도날드, WC, 스마트스코어 계산 끝
			
			//서면심사 물보험심사센터외 계산시작						
			dExtra_cnt = sqlSession.selectOne("StatisticBasic.sumExtraWc", paramMap);
			if( dExtra_cnt == 0 ) {
				memberList.get(i).put("extraCost", 0);			//서면심사 물보험심사센터외 총 기본료의 10%
			}else{
				dExtra_cnt = dExtra_cnt * 0.1;				
				memberList.get(i).put("extraCost", Math.round(dExtra_cnt));			//서면심사 물보험심사센터외 총 기본료의 10%
			}
			//서면심사 물보험심사센터외 계산 끝
			
			//승선지원비 시작 (수협:양식보험, 수협:인수조사)
			suhyp_workload_ea = sqlSession.selectOne("StatisticBasic.sumSuhypWLCnt", paramMap);		//공동수행건 포함으로 쿼리수정 20200327
			if( suhyp_workload_ea == 0 ) {
				memberList.get(i).put("extraSuhypCost", 0);				
			}else {
				//소숫점 셋째자리까지 계산
				suhyp_workload_ea = (Math.round(suhyp_workload_ea * 1000)) / 1000.0; // 소숫점 3째자리까지 표기, 반올림처리
				//suhyp_workload_cost = suhyp_workload_ea * 20000;			//기준업무량건수 * 20000(원)
				//수식변경 기준업무량 종결건수 / 1.1 * 20000 원 by 20200807
				suhyp_workload_cost = (suhyp_workload_ea / 1.1) * 20000;			//기준업무량건수 * 20000(원)				
				memberList.get(i).put("extraSuhypCost", Math.round(suhyp_workload_cost));
			}
			//승선지원비 끝
			
			//가축재해이제조사비 시작(정책:가축재해-소/일반, 가축재해-일반)
			cow_workload_ea = sqlSession.selectOne("StatisticBasic.sumCowWLCnt", paramMap);
			if( cow_workload_ea == 0 ) {
				memberList.get(i).put("extraCowCost", 0);				
			}else {
				//소숫점 셋째자리까지 계산
				cow_workload_ea = (Math.round(cow_workload_ea * 1000)) / 1000.0; // 소숫점 3째자리까지 표기, 반올림처리
				cow_workload_cost = cow_workload_ea * 20000;			//기준업무량건수 * 20000(원)				
				memberList.get(i).put("extraCowCost", Math.round(cow_workload_cost));
			}			
			//가축재해이제조사비 끝

			// 팀인원 정보가 없는 달은 예외가 발생할 수 있음.
			try {

				// 간접비 계산시작
				if ("14".equals(memberList.get(i).get("workType").toString())) { // 센터장
					// 센터 아이디를 가져온다.
					String sCenter_id = "";

					paramMap.put("team_id", memberList.get(i).get("teamId"));
					sCenter_id = sqlSession.selectOne("StatisticBasic.selectCenterId", paramMap);

					paramMap.put("team_id", sCenter_id);
					member_avg = sqlSession.selectOne("StatisticBasic.selectExpenseTeamMemberAvg", paramMap);
					
					member_avg_val = Float.parseFloat(member_avg);
					
					if( member_avg_val > 0 ) {			//값이 있는경우만 처리한다.
						//member_avg_val = Math.round((member_avg_val * 10) / 10.0) - 1; // 자기자신은 인원에서 뺀다. (소숫점 첫째자리까지..)
						member_avg_val = Math.round((member_avg_val * 10) / 10.0); // 스케줄러에서 자기자신은 인원이 빠지도록 기능수정됨. by top3009
					}										

					inside_cost = 37000000 - (member_avg_val * 1500000);

					if (inside_cost > 17000000) {
						memberList.get(i).put("insideCost", StringUtil.NumberFormat(inside_cost));
					} else {
						memberList.get(i).put("insideCost", 17000000);
					}
					memberList.get(i).put("memberAvg", member_avg_val);					

					int last_member_cnt = sqlSession.selectOne("StatisticBasic.selectExpenseTeamMemberLastCnt", paramMap);
					
					if( last_member_cnt != 0 ) {
						last_member_cnt = sqlSession.selectOne("StatisticBasic.selectExpenseTeamMemberLast", paramMap);
					}					

					nCenterManage_cost = last_member_cnt * 50000;

					memberList.get(i).put("centerManageCost", nCenterManage_cost);

					// System.out.println("sCenter_id="+sCenter_id+" :
					// "+memberList.get(i).get("userNo").toString()+" : "+member_avg_val+" :
					// "+inside_cost);

				} else if ("3".equals(memberList.get(i).get("workType").toString())) { // 팀장
					paramMap.put("team_id", memberList.get(i).get("teamId"));

					member_avg = sqlSession.selectOne("StatisticBasic.selectExpenseTeamMemberAvg", paramMap);
					
					member_avg_val = Float.parseFloat(member_avg);
					
					if( member_avg_val > 0 ) {		//값이 있는경우만 처리한다.
						//member_avg_val = Math.round((member_avg_val * 10) / 10.0) - 1; // 자기자신은 인원에서 뺀다. (소숫점 첫째자리까지..)					
						member_avg_val = Math.round((member_avg_val * 10) / 10.0); // 스케줄러에서 자기자신은 인원이 빠지도록 기능수정됨. by top3009
					}

					inside_cost = 37000000 - (member_avg_val * 2500000);

					if (inside_cost > 27000000) {
						memberList.get(i).put("insideCost", StringUtil.NumberFormat(inside_cost));
					} else {
						memberList.get(i).put("insideCost", 27000000);
					}
					
					//백원일 부장 간접비 예외처리 (고정 : 27,000,000원) 시작
					if( "18".equals(memberList.get(i).get("userNo").toString() ) ) {
						memberList.get(i).put("insideCost", 27000000);
					}
					//백원일 부장 간접비 예외처리 (고정 : 27,000,000원) 끝
					
					memberList.get(i).put("memberAvg", member_avg_val);
					memberList.get(i).put("centerManageCost", 0);					

				} else {
					memberList.get(i).put("memberAvg", "-");
					memberList.get(i).put("insideCost", 37000000);
					memberList.get(i).put("centerManageCost", 0);
				}				
				
				// 간접비 계산끝

			} catch (Exception e) {
				e.printStackTrace();
				memberList.get(i).put("memberAvg", "-");
				memberList.get(i).put("insideCost", "-");
			}

		}

		model.addAttribute("memberList", memberList);
		model.addAttribute("srchArg", paramMap);
		model.addAttribute("tabType", tabType);

		// 갱신플래그가 Y 인 경우 이재조사비 임시테이블의 기존년월정보를 삭제하고 현재 정보로 갱신한다.
		if ("Y".equals(dataUpdate)) {
			// 기존 년월 정보로 등록된 데이터를 삭제한다.
			paramMap.put("baseYear", baseYear);
			paramMap.put("baseMonth", baseMonth);
			sqlSession.delete("StatisticBasic.deleteExpenseInfo", paramMap);

			// memberList 를 추가한다.
			sqlSession.insert("StatisticBasic.insertExpenseInfo", memberList);
			// retURL =
			// "top_statistics/expenseList?baseYear="+baseYear+"&baseMonth="+baseMonth;
		}

		return retURL;
	}

	/**
	 * 팀별 기본 통계 (기준업무량 제외)
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/statistics_basic_team_list_quick")
	public String basicTeamListQuick(HttpServletRequest request, Model model, HttpSession session) throws Exception {

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();

		if (!"1".equals(mbrAuthVo.getMbr_pms_21())) {
			return "redirect:/";
		}
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		//검색 로그 남기기 시작 (20240109)
		String sUserNo = mbrVo.getUser_no();		
		String sUserName = mbrVo.getUser_name();
		String sIp = mbrVo.getUser_ip();
		String sLogPage = "기준업무량 미포함통계";

		Map<String, Object> logMap = new HashMap<String, Object>();

		logMap.put("user_no", sUserNo);
		logMap.put("user_name", sUserName);
		logMap.put("user_ip", sIp);
		logMap.put("search_page", sLogPage);

		sqlSession.insert("SaveLogMapper.insertTopSearchLog",logMap);
		//검색 로그 남기기 끝 (20240109)

		// ===============================================
		// 파라미터 체크
		// ===============================================
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

		// ===============================================
		// 현재 일자 세팅
		// ===============================================
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde")); // 기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde")); // 기준일자 종료일
		String excelYN = StringUtil.null2blank(request.getParameter("excelYN")); // 엑셀다운 여부
		String tabType = StringUtil.null2blank(request.getParameter("tabType")); // 탭종류(1: 1종, 4: 4종, 5: 1+4종)

		if ("".equals(stdBgnde)) {
			stdBgnde = DateUtil.getStartMonthDay();
			stdEndde = DateUtil.getEndMonthDay();

			stdBgnde = DateUtil.getDateFormat(stdBgnde, "-");
			stdEndde = DateUtil.getDateFormat(stdEndde, "-");

			paramMap.put("stdBgnde", stdBgnde);
			paramMap.put("stdEndde", stdEndde);
			paramMap.put("excelYN", "N");

			// =============================================
			// 수임 농작물 적부 기본값 세팅
			// =============================================
			paramMap.put("basicYN", "Y");
			paramMap.put("primYN", "Y");
			paramMap.put("contractYN", "N");
		}

		// ===============================================
		// 필요 날짜 SET
		// ===============================================
		String bgnDe = stdBgnde.replace("-", "");
		String endDe = DateUtil.addDate(stdEndde.replace("-", ""), 1);
		String bgnYearDe = (Integer.parseInt(endDe.substring(0, 4)) - 1) + "1216";
		String endYearDe = endDe.substring(0, 4) + "1216";
		String sEndyear = endDe.substring(0, 4) + "-12-16";

		paramMap.put("bgnDe", bgnDe);
		paramMap.put("endDe", endDe);
		paramMap.put("bgnYearDe", bgnYearDe);
		paramMap.put("endYearDe", endYearDe);

		// 사용자별 년 목표량
		int year = Integer.parseInt(bgnDe.substring(0, 4));
		int month = Integer.parseInt(bgnDe.substring(4, 6));
		int day = Integer.parseInt(bgnDe.substring(6, 8));

		if (month == 12 && day > 15) {
			++year;
		}

		int eYear = Integer.parseInt(stdEndde.substring(0, 4));
		int eMonth = Integer.parseInt(stdEndde.substring(5, 7));
		int eDay = Integer.parseInt(stdEndde.substring(8, 10));

		// 월계산기준 날짜 (이번달 해당월 16일)
		String chkMonthDate = "";

		// 검색종료날짜기준
		if (eDay > 15) {
			eMonth = eMonth + 1;
			month = month + 1;
		}

		if (eMonth < 10) {
			chkMonthDate = String.valueOf(eYear) + "-0" + String.valueOf(eMonth) + "-17";
		} else {
			chkMonthDate = String.valueOf(eYear) + "-" + String.valueOf(eMonth) + "-17";
		}

		// 월계산기준 날짜 (지난달 해당월 17일)
		String chkLastMonthDate = "";

		if ((eMonth - 1) == 0) {
			chkLastMonthDate = String.valueOf(year - 1) + "-12-17"; // 연마감처리로 인해 하루 추가 16일기준으로 계산
		} else {
			if ((eMonth - 1) < 10) {
				chkLastMonthDate = String.valueOf(year) + "-0" + String.valueOf(eMonth - 1) + "-17";
			} else {
				chkLastMonthDate = String.valueOf(year) + "-" + String.valueOf(eMonth - 1) + "-17";
			}
		}

		paramMap.put("chkLastMonthDate", chkLastMonthDate);
		paramMap.put("chkMonthDate", chkMonthDate);
		paramMap.put("sEndyear", sEndyear);

		// 직원리스트 가져오기
		List<TopTmBscVO> memberList = sqlSession.selectList("StatisticBasic.selectTopMemberList", paramMap);

		// ===============================================
		// 비즈니스 로직 호출
		// ===============================================
		List<Map<String, Object>> teamList1 = null;
		List<Map<String, Object>> teamList4 = null;
		
		if ("5".equals(tabType)) {
			teamList1 = sqlSession.selectList("StatisticBasic.selectBasicTeamList1Quick", paramMap);
			teamList4 = sqlSession.selectList("StatisticBasic.selectBasicTeamList4Quick", paramMap);

		} else if ("4".equals(tabType)) {
			teamList4 = sqlSession.selectList("StatisticBasic.selectBasicTeamList4Quick", paramMap);
		} else {
			teamList1 = sqlSession.selectList("StatisticBasic.selectBasicTeamList1Quick", paramMap);
		}
		
		
		//1종 서면심사팀인 경우 추가계산 시작
		if( teamList1 != null ) {
			String sWrittenChk = "";
			Map<String,Object> writtenMonthCntMap = new HashMap<String, Object>();
			
			//1종 서면심사팀인 경우 별도 계산 시작
			for(int i=0; i < teamList1.size(); i++) {
				sWrittenChk = teamList1.get(i).get("teamWritten").toString();
				if("1".equals(sWrittenChk)) {
					//System.out.println("written : "+teamList1.get(i).get("teamName").toString()+" : "+teamList1.get(i).get("teamId").toString());
					writtenMonthCntMap = getTeamWrittenListSum(teamList1.get(i).get("teamId").toString(),bgnDe,endDe);
					//System.out.println("writtenCnt : "+writtenMonthCntMap.get("sumBeforeUnsolveCnt")+" (전달) : "+writtenMonthCntMap.get("sumSuimCnt")+ " : " +writtenMonthCntMap.get("sumEndCnt") + " : "+writtenMonthCntMap.get("sumUnsolveCnt"));
					//당월수임건
					teamList1.get(i).put("receiveMonthCnt", writtenMonthCntMap.get("sumSuimCnt").toString());
					//당월종결건
					teamList1.get(i).put("closeMonthCnt", writtenMonthCntMap.get("sumEndCnt").toString());
					//전달미결건
					teamList1.get(i).put("pendingMonthlyCnt", writtenMonthCntMap.get("sumBeforeUnsolveCnt").toString());
					//당월미결현황
					teamList1.get(i).put("pendingCurrentCnt", writtenMonthCntMap.get("sumUnsolveCnt").toString());				
					//년누계수임건
					teamList1.get(i).put("receiveYearCnt", writtenMonthCntMap.get("sumYearSuimCnt").toString());
					//년누계종결건
					teamList1.get(i).put("closeYearCnt", writtenMonthCntMap.get("sumYearEndCnt").toString());
				}
			}
		}
		//1종 서면심사팀인 경우 추가계산 끝
		
		

		// ===============================================
		// 뷰단 데이터 세팅
		// ===============================================
		model.addAttribute("teamList1", teamList1);
		model.addAttribute("teamList4", teamList4);
		model.addAttribute("memberList", memberList);
		model.addAttribute("srchArg", paramMap);
		model.addAttribute("tabType", tabType);

		String retURL = "top_statistics/statistics_basic_team_list_quick";

		if ("Y".equals(excelYN)) {
			retURL = "top_statistics/statistics_basic_team_list_excel_quick";
		}

		return retURL;
	}
	
	/**
	 * 사용자별 서면심사 수임, 종결, 미결건수 가져오기
	 * @param sUser_no : 사용자 사번
	 * @param sDate : 합산 시작일
	 * @param eDate : 합산 종료일
	 * @return Map
	 */
	//public Map<String,Object> getMemberWrittenListSum(String sUser_no, String sDate, String eDate) {
	public Map<String,Object> getMemberWrittenListSum(String sUser_no, String sTeam_id, String sDate, String eDate) {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();		
		
		//top_rpt_written_info(서면심사 수임관리 테이블)에 해당팀의 데이터가 있는지 확인한다.
		int nChk = 0;					//이번달 건수체크		
		int nTempCnt = 0;			//미결카운트 임시변수
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("user_no", sUser_no);
		paramMap.put("team_id", sTeam_id);
		paramMap.put("sdate", sDate);
		paramMap.put("edate", eDate);
		
		nChk = sqlSession.selectOne("StatisticBasic.selectCountMemberWrittenList", paramMap);		
		
		List<Map<String, Object>> calList;
		
		//이번달 조회건수가 없는경우
		if( nChk == 0 ) {
			resultMap.put("sumSuimCnt", 0);
			resultMap.put("sumEndCnt", 0);
			//resultMap.put("sumUnsolveCnt", 0);
		}else {
			calList = sqlSession.selectList("StatisticBasic.selectSumMemberWrittenList", paramMap);
			resultMap.put("sumSuimCnt", calList.get(0).get("suimCnt"));
			resultMap.put("sumEndCnt", calList.get(0).get("endCnt"));
			//resultMap.put("sumUnsolveCnt", calList.get(0).get("unsolveCnt"));
		}
		
		//현재 미결건수		
		//기준은 내일날짜
		paramMap.put("base_date", DateUtil.addDate(DateUtil.getTodayString(), 1));
		nTempCnt = sqlSession.selectOne("ItMgmtMapper.selectWrittenLastUnsolveCount", paramMap);
		resultMap.put("sumUnsolveCnt", nTempCnt);
		
		//지난달 미결건수를 체크하기위해 시작
		String beforeSmonth = DateUtil.getBeforeStartMonthDate(sDate);		//지난달 시작일자
		String beforeEmonth = DateUtil.getBeforeStartMonthDate(eDate);		//지난달 종료일자
		
		paramMap.put("sdate", beforeSmonth);
		paramMap.put("edate", beforeEmonth);		
		
		//beforeChk = sqlSession.selectOne("StatisticBasic.selectCountMemberWrittenList", paramMap);
		
		//calList = sqlSession.selectList("StatisticBasic.selectSumMemberWrittenList", paramMap);
		//지난달 종결일자의 마지막 미결수를 가져온다.
		
		//등록전 마지막 미결건수 가져오기. 없으면 0
		//오늘 날짜보다 전달의 기준날짜가 큰경우는 0으로 처리한다.
		String sToday = DateUtil.getTodayString();		
		
		if( Integer.parseInt(sToday) < Integer.parseInt(beforeEmonth) ) {
			resultMap.put("sumBeforeUnsolveCnt", 0);			//지난달 미결건수
		}else {		
			paramMap.put("base_date", beforeEmonth);		
			nTempCnt = sqlSession.selectOne("ItMgmtMapper.selectWrittenLastUnsolveCount", paramMap);		
			resultMap.put("sumBeforeUnsolveCnt", nTempCnt);			//지난달 미결건수
		}
				
		//년도 정보 가져오기
		String bgnYearDe = (Integer.parseInt(eDate.substring(0, 4)) - 1) + "1216";
		String endYearDe = eDate.substring(0, 4) + "1216";
		
		int yearChk = 0;			//1년 건수체크
		
		paramMap.put("sdate", bgnYearDe);
		paramMap.put("edate", endYearDe);
	
		yearChk = sqlSession.selectOne("StatisticBasic.selectCountMemberWrittenList", paramMap);
		
		if( yearChk == 0 ) {
			resultMap.put("sumYearSuimCnt", 0);
			resultMap.put("sumYearEndCnt", 0);
		}else{
			calList = sqlSession.selectList("StatisticBasic.selectSumMemberWrittenList", paramMap);			
			resultMap.put("sumYearSuimCnt", calList.get(0).get("suimCnt"));			//년누계처리건수
			resultMap.put("sumYearEndCnt", calList.get(0).get("endCnt"));				//년누계절대건수
		}		
		
		return resultMap;
	}
	
	
	/**
	 * 팀별 서면심사 수임, 종결, 미결건수 가져오기
	 * @param sTeam_id : 대상 팀아이디
	 * @param sDate : 합산 시작일
	 * @param eDate : 합산 종료일
	 * @return Map
	 */	
	public Map<String,Object> getTeamWrittenListSum(String sTeam_id, String sDate, String eDate) {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();		
		
		//top_rpt_written_info(서면심사 수임관리 테이블)에 해당팀의 데이터가 있는지 확인한다.
		//int nChk = 0;					//이번달 건수체크
		//int nTempCnt = 0;			//임시 미결 변수
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("team_id", sTeam_id);		
		paramMap.put("sdate", sDate);
		paramMap.put("edate", eDate);
		
		//nChk = sqlSession.selectOne("StatisticBasic.selectCountWrittenList", paramMap);		
		
		List<Map<String, Object>> calList;
		
		paramMap.put("base_date", DateUtil.addDate(DateUtil.getTodayString(), 1));
				
		calList = sqlSession.selectList("StatisticBasic.selectSumWrittenList", paramMap);
		resultMap.put("sumSuimCnt", calList.get(0).get("suimCnt"));
		resultMap.put("sumEndCnt", calList.get(0).get("endCnt"));
		resultMap.put("sumUnsolveCnt", calList.get(0).get("unsolveCnt"));
		
		
		//지난달 미결건수를 체크하기위해 시작
		//int beforeChk = 0;			//전달 건수체크
		
		String beforeSmonth = DateUtil.getBeforeStartMonthDate(sDate);		//지난달 시작일자
		String beforeEmonth = DateUtil.getBeforeStartMonthDate(eDate);		//지난달 종료일자
		
		paramMap.put("sdate", beforeSmonth);
		paramMap.put("edate", beforeEmonth);
		
		//beforeChk = sqlSession.selectOne("StatisticBasic.selectCountWrittenList", paramMap);
		
		paramMap.put("base_date", beforeEmonth);
		
		//오늘 날짜보다 전달의 기준날짜가 큰경우는 0으로 처리한다.
		String sToday = DateUtil.getTodayString();
		
		if( Integer.parseInt(sToday) < Integer.parseInt(beforeEmonth) ) {			
			resultMap.put("sumBeforeUnsolveCnt", 0);			//지난달 미결건수
		}else{			
			calList = sqlSession.selectList("StatisticBasic.selectSumWrittenList", paramMap);			
			resultMap.put("sumBeforeUnsolveCnt", calList.get(0).get("unsolveCnt"));			//지난달 미결건수
		}		
		
		//년도 정보 가져오기
		String bgnYearDe = (Integer.parseInt(eDate.substring(0, 4)) - 1) + "1216";
		String endYearDe = eDate.substring(0, 4) + "1216";
		
		int yearChk = 0;			//1년 건수체크
		
		paramMap.put("sdate", bgnYearDe);
		paramMap.put("edate", endYearDe);
	
		yearChk = sqlSession.selectOne("StatisticBasic.selectCountWrittenList", paramMap);
		
		if( yearChk == 0 ) {
			resultMap.put("sumYearSuimCnt", 0);
			resultMap.put("sumYearEndCnt", 0);
		}else{
			calList = sqlSession.selectList("StatisticBasic.selectSumWrittenList", paramMap);			
			resultMap.put("sumYearSuimCnt", calList.get(0).get("suimCnt"));			//년누계처리건수
			resultMap.put("sumYearEndCnt", calList.get(0).get("endCnt"));				//년누계절대건수
		}		
		
		return resultMap;
	}

	/**
	 * 팀별 기본 통계
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/statistics_basic_team_list")
	public String basicTeamList(HttpServletRequest request, Model model, HttpSession session) throws Exception {
		// ===============================================
		// 권한체크
		// ===============================================
		// TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();

		if (!"1".equals(mbrAuthVo.getMbr_pms_21())) {
			return "redirect:/";
		}
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		//검색 로그 남기기 시작 (20240109)
		String sUserNo = mbrVo.getUser_no();		
		String sUserName = mbrVo.getUser_name();
		String sIp = mbrVo.getUser_ip();
		String sLogPage = "기본통계(전체)";

		Map<String, Object> logMap = new HashMap<String, Object>();

		logMap.put("user_no", sUserNo);
		logMap.put("user_name", sUserName);
		logMap.put("user_ip", sIp);
		logMap.put("search_page", sLogPage);

		sqlSession.insert("SaveLogMapper.insertTopSearchLog",logMap);
		//검색 로그 남기기 끝 (20240109)

		// ===============================================
		// 파라미터 체크
		// ===============================================
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

		// ===============================================
		// 현재 일자 세팅
		// ===============================================
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde")); // 기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde")); // 기준일자 종료일
		String excelYN = StringUtil.null2blank(request.getParameter("excelYN")); // 엑셀다운 여부
		String tabType = StringUtil.null2blank(request.getParameter("tabType")); // 탭종류(1: 1종, 4: 4종, 5: 1+4종)

		if ("".equals(stdBgnde)) {
			stdBgnde = DateUtil.getStartMonthDay();
			stdEndde = DateUtil.getEndMonthDay();

			stdBgnde = DateUtil.getDateFormat(stdBgnde, "-");
			stdEndde = DateUtil.getDateFormat(stdEndde, "-");

			paramMap.put("stdBgnde", stdBgnde);
			paramMap.put("stdEndde", stdEndde);
			paramMap.put("excelYN", "N");

			// =============================================
			// 수임 농작물 적부 기본값 세팅
			// =============================================
			paramMap.put("basicYN", "Y");
			paramMap.put("primYN", "Y");
			paramMap.put("contractYN", "N");
		}

		// ===============================================
		// 필요 날짜 SET
		// ===============================================
		String bgnDe = stdBgnde.replace("-", "");
		String endDe = DateUtil.addDate(stdEndde.replace("-", ""), 1);
		String bgnYearDe = (Integer.parseInt(endDe.substring(0, 4)) - 1) + "1216";
		String endYearDe = endDe.substring(0, 4) + "1216";
		String sEndyear = endDe.substring(0, 4) + "-12-16";

		paramMap.put("bgnDe", bgnDe);
		paramMap.put("endDe", endDe);
		paramMap.put("bgnYearDe", bgnYearDe);
		paramMap.put("endYearDe", endYearDe);

//        System.out.println("bgnDe:["+bgnDe+"]");
//        System.out.println("endDe:["+endDe+"]");
//        System.out.println("bgnYearDe:["+bgnYearDe+"]");
//        System.out.println("endYearDe:["+endYearDe+"]");

		// 사용자별 년 목표량
		int year = Integer.parseInt(bgnDe.substring(0, 4));
		int month = Integer.parseInt(bgnDe.substring(4, 6));
		int day = Integer.parseInt(bgnDe.substring(6, 8));

		if (month == 12 && day > 15) {
			++year;
		}

		int eYear = Integer.parseInt(stdEndde.substring(0, 4));
		int eMonth = Integer.parseInt(stdEndde.substring(5, 7));
		int eDay = Integer.parseInt(stdEndde.substring(8, 10));

		// 월계산기준 날짜 (이번달 해당월 16일)
		String chkMonthDate = "";

		// 검색종료날짜기준
		if (eDay > 15) {
			eMonth = eMonth + 1;
			month = month + 1;
		}

		if (eMonth < 10) {
			chkMonthDate = String.valueOf(eYear) + "-0" + String.valueOf(eMonth) + "-17";
		} else {
			chkMonthDate = String.valueOf(eYear) + "-" + String.valueOf(eMonth) + "-17";
		}

		// 월계산기준 날짜 (지난달 해당월 17일)
		String chkLastMonthDate = "";

		if ((eMonth - 1) == 0) {
			chkLastMonthDate = String.valueOf(year - 1) + "-12-17"; // 연마감처리로 인해 하루 추가 16일기준으로 계산
		} else {
			if ((eMonth - 1) < 10) {
				chkLastMonthDate = String.valueOf(year) + "-0" + String.valueOf(eMonth - 1) + "-17";
			} else {
				chkLastMonthDate = String.valueOf(year) + "-" + String.valueOf(eMonth - 1) + "-17";
			}
		}

		paramMap.put("chkLastMonthDate", chkLastMonthDate);
		paramMap.put("chkMonthDate", chkMonthDate);
		paramMap.put("sEndyear", sEndyear);

		// List<String> userList = new ArrayList();
		// paramMap.put("userList", userList);

		// 직원리스트 가져오기
		List<TopTmBscVO> memberList = sqlSession.selectList("StatisticBasic.selectTopMemberList", paramMap);

		// ===============================================
		// 비즈니스 로직 호출
		// ===============================================
		List<Map<String, Object>> teamList1 = null;
		List<Map<String, Object>> teamList4 = null;

		String sTeamid = "";
		double sSumTeamPoint = 0;
		double sSumYearTeamPoint = 0;
		
		//년누계 시작 고정값
		String bgnYearCumul = bgnYearDe;		//년누계 계산 시작일
		String endYearCumul = sEndyear;		//년누계 계산 종료일

		if ("5".equals(tabType)) {
			teamList1 = sqlSession.selectList("StatisticBasic.selectBasicTeamList1", paramMap);
			teamList4 = sqlSession.selectList("StatisticBasic.selectBasicTeamList4", paramMap);

			// 가져온 리스트에 합산된 workload 값을 넣어준다.
			for (int i = 0; i < teamList1.size(); i++) {
				Map<String, Object> map = teamList1.get(i);
				sTeamid = map.get("teamId").toString();
				
				// 사용자 고유번호와 시작일자 종료일자를 가지고 표준환산합계점수를 가져온다.				
				sSumTeamPoint = getTeamWorkpoint(sTeamid, bgnDe, endDe);

				// 환산점수를 리스트에 넣어준다.
				teamList1.get(i).put("workLoadMonthCal", sSumTeamPoint);
				
				// 년누계 값을 현재값으로 가져온다. by top3009
				sSumYearTeamPoint = getTeamWorkpoint(sTeamid, bgnYearCumul, endYearCumul);
				teamList1.get(i).put("workloadYearResult", sSumYearTeamPoint);				
				
			}
		} else if ("4".equals(tabType)) {
			teamList4 = sqlSession.selectList("StatisticBasic.selectBasicTeamList4", paramMap);
		} else {
			teamList1 = sqlSession.selectList("StatisticBasic.selectBasicTeamList1", paramMap);

			// 가져온 리스트에 합산된 workload 값을 넣어준다.
			for (int i = 0; i < teamList1.size(); i++) {
				Map<String, Object> map = teamList1.get(i);
				sTeamid = map.get("teamId").toString();

				// 사용자 고유번호와 시작일자 종료일자를 가지고 표준환산합계점수를 가져온다.
				sSumTeamPoint = getTeamWorkpoint(sTeamid, bgnDe, endDe);

				// 환산점수를 리스트에 넣어준다.
				teamList1.get(i).put("workLoadMonthCal", sSumTeamPoint);
				
				// 년누계 값을 현재값으로 가져온다. by top3009
				sSumYearTeamPoint = getTeamWorkpoint(sTeamid, bgnYearCumul, endYearCumul);
				teamList1.get(i).put("workloadYearResult", sSumYearTeamPoint);
			}
		}
		
		//1종 서면심사팀인 경우 추가계산 시작
		if( teamList1 != null ) {
			String sWrittenChk = "";
			Map<String,Object> writtenMonthCntMap = new HashMap<String, Object>();
			
			//1종 서면심사팀인 경우 별도 계산 시작
			for(int i=0; i < teamList1.size(); i++) {
				sWrittenChk = teamList1.get(i).get("teamWritten").toString();
				if("1".equals(sWrittenChk)) {
					//System.out.println("written : "+teamList1.get(i).get("teamName").toString()+" : "+teamList1.get(i).get("teamId").toString());
					writtenMonthCntMap = getTeamWrittenListSum(teamList1.get(i).get("teamId").toString(),bgnDe,endDe);
					//당월수임건
					teamList1.get(i).put("receiveMonthCnt", writtenMonthCntMap.get("sumSuimCnt").toString());
					//당월종결건
					teamList1.get(i).put("closeMonthCnt", writtenMonthCntMap.get("sumEndCnt").toString());
					//전달미결건
					teamList1.get(i).put("pendingMonthlyCnt", writtenMonthCntMap.get("sumBeforeUnsolveCnt").toString());
					//당월미결현황
					teamList1.get(i).put("pendingCurrentCnt", writtenMonthCntMap.get("sumUnsolveCnt").toString());				
					//년누계수임건
					teamList1.get(i).put("receiveYearCnt", writtenMonthCntMap.get("sumYearSuimCnt").toString());
					//년누계종결건
					teamList1.get(i).put("closeYearCnt", writtenMonthCntMap.get("sumYearEndCnt").toString());
				}
			}
		}
		//1종 서면심사팀인 경우 추가계산 끝

		// ===============================================
		// 뷰단 데이터 세팅
		// ===============================================
		model.addAttribute("teamList1", teamList1);
		model.addAttribute("teamList4", teamList4);
		model.addAttribute("memberList", memberList);
		model.addAttribute("srchArg", paramMap);
		model.addAttribute("tabType", tabType);

		String retURL = "top_statistics/statistics_basic_team_list";

		if ("Y".equals(excelYN)) {
			retURL = "top_statistics/statistics_basic_team_list_excel";
		}

		return retURL;
	}

	/**
	 * 개인별 기본 통계 기준업무량 제외
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/statistics_basic_member_list_quick")
	public String basicMemberListQuick(HttpServletRequest request, Model model) throws Exception {

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
		if (!"1".equals(mbrAuthVo.getMbr_pms_21())) {
			return "redirect:/";
		}

		// ===============================================
		// 파라미터 체크
		// ===============================================
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

		// ===============================================
		// 현재 일자 세팅
		// ===============================================
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde")); // 기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde")); // 기준일자 종료일
		String teamId = StringUtil.null2blank(request.getParameter("team_id")); // 팀 아이디
		String excelYN = StringUtil.null2blank(request.getParameter("excelYN")); // 엑셀다운 여부

		if ("".equals(stdBgnde)) {
			stdBgnde = DateUtil.getStartMonthDay();
			stdEndde = DateUtil.getEndMonthDay();

			stdBgnde = DateUtil.getDateFormat(stdBgnde, "-");
			stdEndde = DateUtil.getDateFormat(stdEndde, "-");

			paramMap.put("stdBgnde", stdBgnde);
			paramMap.put("stdEndde", stdEndde);
			paramMap.put("excelYN", "N");

			// =============================================
			// 수임 농작물 적부 기본값 세팅
			// =============================================
			paramMap.put("basicYN", "Y");
			paramMap.put("primYN", "N");
			paramMap.put("contractYN", "N");

		}

		if ("".equals(teamId)) {
			return "redirect:/";
		}

		// ===============================================
		// 필요 날짜 SET
		// ===============================================
		String bgnDe = stdBgnde.replace("-", "");
		String endDe = DateUtil.addDate(stdEndde.replace("-", ""), 1);
		String bgnYearDe = (Integer.parseInt(endDe.substring(0, 4)) - 1) + "1216";
		String endYearDe = endDe.substring(0, 4) + "1216";
		String sStartYear = (Integer.parseInt(endDe.substring(0, 4)) - 1) + "-12-16";
		String sEndyear = endDe.substring(0, 4) + "-12-16";

		paramMap.put("bgnDe", bgnDe);
		paramMap.put("endDe", endDe);
		paramMap.put("bgnYearDe", bgnYearDe);
		paramMap.put("endYearDe", endYearDe);
		paramMap.put("sStartYear", sStartYear); // 시작하는 년도 날짜
		paramMap.put("sEndyear", sEndyear); // 종료하는 년도 날짜

		// 사용자별 년 목표량
		int year = Integer.parseInt(bgnDe.substring(0, 4));
		int month = Integer.parseInt(bgnDe.substring(4, 6));
		int day = Integer.parseInt(bgnDe.substring(6, 8));

		if (month == 12 && day > 15) {
			++year;
		}

		int eYear = Integer.parseInt(stdEndde.substring(0, 4));
		int eMonth = Integer.parseInt(stdEndde.substring(5, 7));
		int eDay = Integer.parseInt(stdEndde.substring(8, 10));

		// 월계산기준 날짜 (이번달 해당월 16일)
		String chkMonthDate = "";

		// 검색종료날짜기준
		if (eDay > 15) {
			eMonth = eMonth + 1;
			month = month + 1;
		}

		if (eMonth < 10) {
			chkMonthDate = String.valueOf(eYear) + "-0" + String.valueOf(eMonth) + "-17";
		} else {
			chkMonthDate = String.valueOf(eYear) + "-" + String.valueOf(eMonth) + "-17";
		}

		// 월계산기준 날짜 (지난달 해당월 17일)
		String chkLastMonthDate = "";

		if ((eMonth - 1) == 0) {
			chkLastMonthDate = String.valueOf(year - 1) + "-12-17"; // 연마감처리로 인해 하루 추가 16일기준으로 계산
		} else {
			if ((eMonth - 1) < 10) {
				chkLastMonthDate = String.valueOf(year) + "-0" + String.valueOf(eMonth - 1) + "-17";
			} else {
				chkLastMonthDate = String.valueOf(year) + "-" + String.valueOf(eMonth - 1) + "-17";
			}
		}

		paramMap.put("chkLastMonthDate", chkLastMonthDate);
		paramMap.put("chkMonthDate", chkMonthDate);
		paramMap.put("sEndyear", sEndyear);
		paramMap.put("year", year);

		// ===============================================
		// 비즈니스 로직 호출
		// ===============================================
		TopTmBscVO teamVo = sqlSession.selectOne("TmMngDtlMapper.selectOneTeam", teamId);
		if (teamVo == null) {
			return "redirect:/";
		}

		List<Map<String, Object>> teamList = sqlSession.selectList("StatisticBasic.selectStatisticTeamList");
		List<Map<String, Object>> memberList = null;
		List<Map<String, Object>> memberPersonStandardList = null;
		
		if ("1".equals(teamVo.getTeam_type())) {
			memberList = sqlSession.selectList("StatisticBasic.selectBasicMemberList1Quick", paramMap);
			memberPersonStandardList = sqlSession.selectList("StatisticBasic.selectBasicMemberPersonStandardList1Quick",
					paramMap);
			
			//1종 서면심사인경우만 별도 카운트처리			
			//서면심사 팀에 속한 경우만 사용자의 수임종결건수를 별도계산한다.
			if("1".equals(teamVo.getTeam_written())) {
				
				Map<String,Object> writtenMonthCntMap = new HashMap<String, Object>();
				
				for(int i=0; i < memberList.size(); i++) {
					writtenMonthCntMap = getMemberWrittenListSum(memberList.get(i).get("userNo").toString(),teamId,bgnDe,endDe);
					//당월수임건
					memberList.get(i).put("receiveMonthCnt", writtenMonthCntMap.get("sumSuimCnt").toString());
					//당월종결건
					memberList.get(i).put("closeMonthCnt", writtenMonthCntMap.get("sumEndCnt").toString());
					//전달미결건
					memberList.get(i).put("pendingMonthlyCnt", writtenMonthCntMap.get("sumBeforeUnsolveCnt").toString());
					//당월미결현황
					memberList.get(i).put("pendingCurrentCnt", writtenMonthCntMap.get("sumUnsolveCnt").toString());				
					//년누계수임건
					memberList.get(i).put("receiveYearCnt", writtenMonthCntMap.get("sumYearSuimCnt").toString());
					//년누계종결건
					memberList.get(i).put("closeYearCnt", writtenMonthCntMap.get("sumYearEndCnt").toString());
				}
				
				for(int i=0; i < memberPersonStandardList.size(); i++) {
					writtenMonthCntMap = getMemberWrittenListSum(memberPersonStandardList.get(i).get("userNo").toString(),teamId,bgnDe,endDe);
					//당월수임건
					memberPersonStandardList.get(i).put("receiveMonthCnt", writtenMonthCntMap.get("sumSuimCnt").toString());
					//당월종결건
					memberPersonStandardList.get(i).put("closeMonthCnt", writtenMonthCntMap.get("sumEndCnt").toString());
					//전달미결건
					memberPersonStandardList.get(i).put("pendingMonthlyCnt", writtenMonthCntMap.get("sumBeforeUnsolveCnt").toString());
					//당월미결현황
					memberPersonStandardList.get(i).put("pendingCurrentCnt", writtenMonthCntMap.get("sumUnsolveCnt").toString());				
					//년누계수임건
					memberPersonStandardList.get(i).put("receiveYearCnt", writtenMonthCntMap.get("sumYearSuimCnt").toString());
					//년누계종결건
					memberPersonStandardList.get(i).put("closeYearCnt", writtenMonthCntMap.get("sumYearEndCnt").toString());
				}
			}
			
		} else {
			memberList = sqlSession.selectList("StatisticBasic.selectBasicMemberList4", paramMap);
			memberPersonStandardList = sqlSession.selectList("StatisticBasic.selectBasicMemberPersonStandardList4",
					paramMap);
		}
		
		//미수금 별도 처리 시작 20211216 by top3009			
		long totalOutAmt = 0;
		totalOutAmt = sqlSession.selectOne("StatisticBasic.selectSumOutAmtByTeamId",paramMap);		
		model.addAttribute("totalOutAmt", totalOutAmt);
		//미수금 별도 처리 끝 20211216 by top3009

		// ===============================================
		// 뷰단 데이터 세팅
		// ===============================================
		model.addAttribute("teamVo", teamVo);
		model.addAttribute("teamList", teamList);
		model.addAttribute("memberList", memberList);
		model.addAttribute("memberPersonStandardList", memberPersonStandardList);
		model.addAttribute("srchArg", paramMap);

		String retURL = "top_statistics/statistics_basic_member_list_quick";

		if ("Y".equals(excelYN)) {
			retURL = "top_statistics/statistics_basic_member_list_excel_quick";
		}

		return retURL;

	}

	/**
	 * 개인별 기본 통계
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/statistics_basic_member_list")
	public String basicMemberList(HttpServletRequest request, Model model) throws Exception {
		// ===============================================
		// 권한체크
		// ===============================================
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
		if (!"1".equals(mbrAuthVo.getMbr_pms_21())) {
			return "redirect:/";
		}

		// ===============================================
		// 파라미터 체크
		// ===============================================
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

		// ===============================================
		// 현재 일자 세팅
		// ===============================================
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde")); // 기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde")); // 기준일자 종료일
		String teamId = StringUtil.null2blank(request.getParameter("team_id")); // 팀 아이디
		String excelYN = StringUtil.null2blank(request.getParameter("excelYN")); // 엑셀다운 여부

		if ("".equals(stdBgnde)) {
			stdBgnde = DateUtil.getStartMonthDay();
			stdEndde = DateUtil.getEndMonthDay();

			stdBgnde = DateUtil.getDateFormat(stdBgnde, "-");
			stdEndde = DateUtil.getDateFormat(stdEndde, "-");

			paramMap.put("stdBgnde", stdBgnde);
			paramMap.put("stdEndde", stdEndde);
			paramMap.put("excelYN", "N");

			// =============================================
			// 수임 농작물 적부 기본값 세팅
			// =============================================
			paramMap.put("basicYN", "Y");
			paramMap.put("primYN", "N");
			paramMap.put("contractYN", "N");

		}

		if ("".equals(teamId)) {
			return "redirect:/";
		}

		// ===============================================
		// 필요 날짜 SET
		// ===============================================
		String bgnDe = stdBgnde.replace("-", "");
		String endDe = DateUtil.addDate(stdEndde.replace("-", ""), 1);
		String bgnYearDe = (Integer.parseInt(endDe.substring(0, 4)) - 1) + "1216";
		String endYearDe = endDe.substring(0, 4) + "1216";
		String sStartYear = (Integer.parseInt(endDe.substring(0, 4)) - 1) + "-12-16";
		String sEndyear = endDe.substring(0, 4) + "-12-16";

		paramMap.put("bgnDe", bgnDe);
		paramMap.put("endDe", endDe);
		paramMap.put("bgnYearDe", bgnYearDe);
		paramMap.put("endYearDe", endYearDe);
		paramMap.put("sStartYear", sStartYear); // 시작하는 년도 날짜
		paramMap.put("sEndyear", sEndyear); // 종료하는 년도 날짜

		// 사용자별 년 목표량
		int year = Integer.parseInt(bgnDe.substring(0, 4));
		int month = Integer.parseInt(bgnDe.substring(4, 6));
		int day = Integer.parseInt(bgnDe.substring(6, 8));

		if (month == 12 && day > 15) {
			++year;
		}

		int eYear = Integer.parseInt(stdEndde.substring(0, 4));
		int eMonth = Integer.parseInt(stdEndde.substring(5, 7));
		int eDay = Integer.parseInt(stdEndde.substring(8, 10));

		// 월계산기준 날짜 (이번달 해당월 16일)
		String chkMonthDate = "";

		// 검색종료날짜기준
		if (eDay > 15) {
			eMonth = eMonth + 1;
			month = month + 1;
		}

		if (eMonth < 10) {
			chkMonthDate = String.valueOf(eYear) + "-0" + String.valueOf(eMonth) + "-17";
		} else {
			chkMonthDate = String.valueOf(eYear) + "-" + String.valueOf(eMonth) + "-17";
		}

		// 월계산기준 날짜 (지난달 해당월 17일)
		String chkLastMonthDate = "";

		if ((eMonth - 1) == 0) {
			chkLastMonthDate = String.valueOf(year - 1) + "-12-17"; // 연마감처리로 인해 하루 추가 16일기준으로 계산
		} else {
			if ((eMonth - 1) < 10) {
				chkLastMonthDate = String.valueOf(year) + "-0" + String.valueOf(eMonth - 1) + "-17";
			} else {
				chkLastMonthDate = String.valueOf(year) + "-" + String.valueOf(eMonth - 1) + "-17";
			}
		}

		paramMap.put("chkLastMonthDate", chkLastMonthDate);
		paramMap.put("chkMonthDate", chkMonthDate);
		paramMap.put("sEndyear", sEndyear);

		// System.out.println("년체크="+sEndyear);
		// System.out.println("기준월="+chkMonthDate);
		// System.out.println("지난월="+chkLastMonthDate);

		paramMap.put("year", year);

		// ===============================================
		// 비즈니스 로직 호출
		// ===============================================
		TopTmBscVO teamVo = sqlSession.selectOne("TmMngDtlMapper.selectOneTeam", teamId);
		if (teamVo == null) {
			return "redirect:/";
		}

		List<Map<String, Object>> teamList = sqlSession.selectList("StatisticBasic.selectStatisticTeamList");
		List<Map<String, Object>> memberList = null;
		List<Map<String, Object>> memberPersonStandardList = null;

		// System.out.println("chkMonthDate="+chkMonthDate);
		// System.out.println("월체크="+stdBgnde+ " : "+stdEndde);
		// System.out.println("년체크="+sStartYear+ " : "+sEndyear);

		if ("1".equals(teamVo.getTeam_type())) {
			memberList = sqlSession.selectList("StatisticBasic.selectBasicMemberList1", paramMap);
			memberPersonStandardList = sqlSession.selectList("StatisticBasic.selectBasicMemberPersonStandardList1",
					paramMap);
			
			//1종 서면심사인경우만 별도 카운트처리			
			//서면심사 팀에 속한 경우만 사용자의 수임종결건수를 별도계산한다.
			if("1".equals(teamVo.getTeam_written())) {
				
				Map<String,Object> writtenMonthCntMap = new HashMap<String, Object>();
				
				for(int i=0; i < memberList.size(); i++) {
					writtenMonthCntMap = getMemberWrittenListSum(memberList.get(i).get("userNo").toString(),teamId,bgnDe,endDe);
					//당월수임건
					memberList.get(i).put("receiveMonthCnt", writtenMonthCntMap.get("sumSuimCnt").toString());
					//당월종결건
					memberList.get(i).put("closeMonthCnt", writtenMonthCntMap.get("sumEndCnt").toString());
					//전달미결건
					memberList.get(i).put("pendingMonthlyCnt", writtenMonthCntMap.get("sumBeforeUnsolveCnt").toString());
					//당월미결현황
					memberList.get(i).put("pendingCurrentCnt", writtenMonthCntMap.get("sumUnsolveCnt").toString());				
					//년누계수임건
					memberList.get(i).put("receiveYearCnt", writtenMonthCntMap.get("sumYearSuimCnt").toString());
					//년누계종결건
					memberList.get(i).put("closeYearCnt", writtenMonthCntMap.get("sumYearEndCnt").toString());
				}
				
				for(int i=0; i < memberPersonStandardList.size(); i++) {
					writtenMonthCntMap = getMemberWrittenListSum(memberPersonStandardList.get(i).get("userNo").toString(),teamId,bgnDe,endDe);
					//당월수임건
					memberPersonStandardList.get(i).put("receiveMonthCnt", writtenMonthCntMap.get("sumSuimCnt").toString());
					//당월종결건
					memberPersonStandardList.get(i).put("closeMonthCnt", writtenMonthCntMap.get("sumEndCnt").toString());
					//전달미결건
					memberPersonStandardList.get(i).put("pendingMonthlyCnt", writtenMonthCntMap.get("sumBeforeUnsolveCnt").toString());
					//당월미결현황
					memberPersonStandardList.get(i).put("pendingCurrentCnt", writtenMonthCntMap.get("sumUnsolveCnt").toString());				
					//년누계수임건
					memberPersonStandardList.get(i).put("receiveYearCnt", writtenMonthCntMap.get("sumYearSuimCnt").toString());
					//년누계종결건
					memberPersonStandardList.get(i).put("closeYearCnt", writtenMonthCntMap.get("sumYearEndCnt").toString());
				}
			}
			
		} else {
			memberList = sqlSession.selectList("StatisticBasic.selectBasicMemberList4", paramMap);
			memberPersonStandardList = sqlSession.selectList("StatisticBasic.selectBasicMemberPersonStandardList4",
					paramMap);
		}

		String sUserno = "";
		String userSumPoint = "";
		String userSumYearPoint = "";
		
		String sTeam_id = paramMap.get("team_id").toString();
		int nChk_amp = 0; // 발령체크
		paramMap.put("team_id", sTeam_id);
		
		//년누계 시작 고정값
		String bgnYearCumul = bgnYearDe;		//년누계 계산 시작일
		String endYearCumul = sEndyear;		//년누계 계산 종료일

		// 가져온 리스트에 합산된 workload 값을 넣어준다.
		for (int i = 0; i < memberPersonStandardList.size(); i++) {
			Map<String, Object> map = memberPersonStandardList.get(i);
			sUserno = map.get("userNo").toString();
			paramMap.put("user_no", sUserno);
			// 기간내 팀소속인지 확인 (개인기준은 소속팀 체크 제외.. 20211220 by top3009)
			//nChk_amp = sqlSession.selectOne("StatisticBasic.appointChk", paramMap);

			// System.out.println("팀 체크 : "+ i +" : "+sUserno+" : "+sTeam_id+" : "+bgnDe+" :
			// "+endDe+" : "+nChk_amp);
			//if (nChk_amp == 0) { // 검색기간중 소속팀이 아닌경우
				//userSumPoint = "0";
			//} else {
				// 사용자 고유번호와 시작일자 종료일자를 가지고 표준환산합계점수를 가져온다.
				userSumPoint = getUserWorkpoint(sUserno, bgnDe, endDe);
				
				// 사용자 고유번호와 년시작일자 년 종료일자를 가지고 표준환산합계점수를 가져온다.					
				userSumYearPoint = getUserWorkpoint(sUserno, bgnYearCumul, endYearCumul);
			//}

			// 환산점수를 리스트에 넣어준다.
			memberPersonStandardList.get(i).put("workLoadMonthCal", userSumPoint);
			
			memberPersonStandardList.get(i).put("workLoadYear", userSumYearPoint);

			// System.out.println(sUserno+" : "+userSumPoint);
		}

		// 팀별리스트설정
		for (int i = 0; i < memberList.size(); i++) {
			Map<String, Object> map = memberList.get(i);
			sUserno = map.get("userNo").toString();
			paramMap.put("user_no", sUserno);
			
			// 기간내 팀소속인지 확인
			nChk_amp = sqlSession.selectOne("StatisticBasic.appointChk", paramMap);
			
			if (nChk_amp == 0) { // 검색기간중 소속팀이 아닌경우
				userSumPoint = "0";
			} else {
				// 사용자 고유번호와 시작일자 종료일자를 가지고 표준환산합계점수를 가져온다.
				userSumPoint = getUserWorkpoint(sUserno, bgnDe, endDe);
				
				// 사용자 고유번호와 년시작일자 년 종료일자를 가지고 표준환산합계점수를 가져온다.					
				userSumYearPoint = getUserWorkpoint(sUserno, bgnYearCumul, endYearCumul);
			}

			// 환산점수를 리스트에 넣어준다.
			memberList.get(i).put("workLoadMonthCal", userSumPoint);
			
			memberList.get(i).put("workLoadYear", userSumYearPoint);

			// System.out.println(sUserno+" : "+userSumPoint);
			// System.out.println(sUserno+" : "+sUsername+" : "+userSumPoint+" :
			// ("+work_load_month+" - "+work_load_last_month+")");
		}
		
		//미수금 별도 처리 시작 20211216 by top3009			
		long totalOutAmt = 0;
		totalOutAmt = sqlSession.selectOne("StatisticBasic.selectSumOutAmtByTeamId",paramMap);		
		model.addAttribute("totalOutAmt", totalOutAmt);
		//미수금 별도 처리 끝 20211216 by top3009

		// ===============================================
		// 뷰단 데이터 세팅
		// ===============================================
		model.addAttribute("teamVo", teamVo);
		model.addAttribute("teamList", teamList);
		model.addAttribute("memberList", memberList);
		model.addAttribute("memberPersonStandardList", memberPersonStandardList);
		model.addAttribute("srchArg", paramMap);

		String retURL = "top_statistics/statistics_basic_member_list";

		if ("Y".equals(excelYN)) {
			retURL = "top_statistics/statistics_basic_member_list_excel";
		}

		return retURL;

	}

	/**
	 * 팀별 기준업무량 환산점수 계산 함수 param1 : sTeamid : 팀아이디 param2 : sStartdate : 조회시작일자
	 * param3 : sEnddate : 조회종료일자
	 * 
	 * @return String sRet 기준업무량 합계점수
	 */
	public double getTeamWorkpoint(String sTeamid, String sStartdate, String sEnddate) throws Exception {
		double dRet = 0;

		Map<String, Object> paramMap = new HashMap();
		paramMap.put("bgnYearDe", sStartdate); // 조회시작일
		paramMap.put("endYearDe", sEnddate); // 조회종료일
		paramMap.put("bgnDe", sStartdate); // 팀체크용 조회시작일추가
		paramMap.put("endDe", sEnddate); // 팀체크용 조회종료일추가
		paramMap.put("team_id", sTeamid); // 팀아이디

		// 팀의 구성원 목록을 가져온다.
		List<Map<String, Object>> memberList = sqlSession.selectList("StatisticBasic.selectStatisticMemberList",
				paramMap);

		String sUserno = "";
		int nChk_amp = 0; // 발령체크

		for (int i = 0; i < memberList.size(); i++) {
			Map<String, Object> map = memberList.get(i);
			sUserno = map.get("userNo").toString();
			paramMap.put("user_no", sUserno);

			// 기간내 팀소속인지 확인
			nChk_amp = sqlSession.selectOne("StatisticBasic.appointChk", paramMap);

			if (nChk_amp > 0) { // 검색기간중 소속팀인경우만 합산한다.
				dRet += Double.parseDouble(getUserWorkpoint(sUserno, sStartdate, sEnddate));
			}
		}
		return dRet;
	}

	/**
	 * 개인 기준업무량 환산점수 계산 함수 param1 : sUserno : 개인고유번호 param2 : sStartdate : 조회시작일자
	 * param3 : sEnddate : 조회종료일자
	 * 
	 * @return String sRet 기준업무량 합계점수
	 */
	public String getUserWorkpoint(String sUserno, String sStartdate, String sEnddate) throws Exception {

		String sRet = "";

		Map<String, Object> paramMap = new HashMap();

		sStartdate = sStartdate.replace("-", "");
		sEnddate = sEnddate.replace("-", "");

		int year = Integer.parseInt(sStartdate.substring(0, 4));
		int month = Integer.parseInt(sStartdate.substring(4, 6));
		int day = Integer.parseInt(sStartdate.substring(6, 8));

		if (month == 12 && day > 15) {
			++year;
		}
		// System.out.println(year +" : "+month+" : "+day);
		// System.out.println("sUserno="+sUserno);
		// System.out.println("sStartdate="+sStartdate);
		// System.out.println("sEnddate="+sEnddate);
		// System.out.println("year="+year);

		paramMap.put("bgnDe", sStartdate);
		paramMap.put("endDe", sEnddate);
		paramMap.put("user_no", sUserno);
		paramMap.put("year", year);

		String yearEa = sqlSession.selectOne("StatisticBasic.selectPersonYearEa", paramMap);

		if (yearEa == null || yearEa.equals("")) { // 값이 null 인경우 최종 발령팀 기준으로 가져온다.
			yearEa = sqlSession.selectOne("StatisticBasic.selectPersonYearEaNull", paramMap);
		}
		
		// =============================================
		// 수임 농작물 적부 기본값 세팅
		// =============================================
		paramMap.put("basicYN", "Y");
		paramMap.put("primYN", "Y");

		paramMap.put("yearEa", yearEa); // 년간 목표량

		// System.out.println("yearEa="+yearEa);

		sRet = sqlSession.selectOne("StatisticBasic.sumPersonWorkload", paramMap); // 개인별 기준업무량 환산점수
		
		// System.out.println("sRet="+sRet);

		return sRet;
	}

	/**
	 * 개인별 기본 통계 팀 전체 엑셀 다운로드
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/statistics_basic_member_list_whole_excel_quick")
	public String basicMemberListWholeExcelQuick(HttpServletRequest request, Model model) throws Exception {
		// ===============================================
		// 권한체크
		// ===============================================
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
		if (!"1".equals(mbrAuthVo.getMbr_pms_21())) {
			return "redirect:/";
		}

		// ===============================================
		// 파라미터 체크
		// ===============================================
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

		// ===============================================
		// 현재 일자 세팅
		// ===============================================
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde")); // 기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde")); // 기준일자 종료일
		String teamId = StringUtil.null2blank(request.getParameter("team_id")); // 팀 아이디
		String excelYN = StringUtil.null2blank(request.getParameter("excelYN")); // 엑셀다운 여부
		String retireUser = StringUtil.null2blank(request.getParameter("retireUser")); // 다운로드시 퇴직자 포함여부
		String sToday = DateUtil.getTodayString();

		if ("".equals(stdBgnde)) {
			stdBgnde = DateUtil.getStartMonthDay();
			stdEndde = DateUtil.getEndMonthDay();

			stdBgnde = DateUtil.getDateFormat(stdBgnde, "-");
			stdEndde = DateUtil.getDateFormat(stdEndde, "-");

			paramMap.put("stdBgnde", stdBgnde);
			paramMap.put("stdEndde", stdEndde);
			paramMap.put("excelYN", "N");

			// =============================================
			// 수임 농작물 적부 기본값 세팅
			// =============================================
			paramMap.put("basicYN", "Y");
			paramMap.put("primYN", "N");
			paramMap.put("contractYN", "N");

		}

		if ("".equals(teamId)) {
			return "redirect:/";
		}

		// ===============================================
		// 필요 날짜 SET
		// ===============================================
		String bgnDe = stdBgnde.replace("-", "");
		String endDe = DateUtil.addDate(stdEndde.replace("-", ""), 1);
		String bgnYearDe = (Integer.parseInt(endDe.substring(0, 4)) - 1) + "1216";
		String endYearDe = endDe.substring(0, 4) + "1216";

		paramMap.put("bgnDe", bgnDe);
		paramMap.put("endDe", endDe);
		paramMap.put("bgnYearDe", bgnYearDe);
		paramMap.put("endYearDe", endYearDe);
		paramMap.put("today", sToday);

		// ===============================================
		// 비즈니스 로직 호출
		// ===============================================
		TopTmBscVO teamVo = sqlSession.selectOne("TmMngDtlMapper.selectOneTeam", teamId);
		if (teamVo == null) {
			return "redirect:/";
		}

		List<Map<String, Object>> teamList = sqlSession.selectList("StatisticBasic.selectStatisticTeamList");

		// ==============================================
		// 팀 전체 내용을 가져온다.
		// ==============================================
		List<Map<String, Object>> teamExcelList = new ArrayList<>();
		List<Map<String, Object>> personExcelList = new ArrayList<>();

		for (int idx = 0; idx < teamList.size(); idx++) {
			Map<String, Object> team = teamList.get(idx);

			String _teamId = String.valueOf(team.get("teamId"));
			String _teamType = String.valueOf(team.get("teamType"));

			paramMap.put("team_id", _teamId);

			List<Map<String, Object>> memberList = new ArrayList<>();
			List<Map<String, Object>> memberPersonStandardList = new ArrayList<>();

			if ("1".equals(_teamType)) {
				memberList = sqlSession.selectList("StatisticBasic.selectBasicMemberList1Quick", paramMap);				
				if( "Y".equals(retireUser) ) {		//퇴직자 포함다운로드
					//매달 재경팀 엑셀데이터 제출시 사용(퇴직일이 검색일자 내에 포함된 퇴직자)
					memberPersonStandardList = sqlSession.selectList("StatisticBasic.selectBasicMemberPersonStandardList1_retire",	paramMap);
				}else {
					memberPersonStandardList = sqlSession.selectList("StatisticBasic.selectBasicMemberPersonStandardList1Quick", paramMap);
				}
				
				//1종 서면심사인경우만 별도 카운트처리			
				//서면심사 팀에 속한 경우만 사용자의 수임종결건수를 별도계산한다.
				if("1".equals(teamVo.getTeam_written())) {
					
					Map<String,Object> writtenMonthCntMap = new HashMap<String, Object>();
					
					for(int i=0; i < memberList.size(); i++) {
						writtenMonthCntMap = getMemberWrittenListSum(memberList.get(i).get("userNo").toString(),teamId,bgnDe,endDe);
						//당월수임건
						memberList.get(i).put("receiveMonthCnt", writtenMonthCntMap.get("sumSuimCnt").toString());
						//당월종결건
						memberList.get(i).put("closeMonthCnt", writtenMonthCntMap.get("sumEndCnt").toString());
						//전달미결건
						memberList.get(i).put("pendingMonthlyCnt", writtenMonthCntMap.get("sumBeforeUnsolveCnt").toString());
						//당월미결현황
						memberList.get(i).put("pendingCurrentCnt", writtenMonthCntMap.get("sumUnsolveCnt").toString());				
						//년누계수임건
						memberList.get(i).put("receiveYearCnt", writtenMonthCntMap.get("sumYearSuimCnt").toString());
						//년누계종결건
						memberList.get(i).put("closeYearCnt", writtenMonthCntMap.get("sumYearEndCnt").toString());
					}
					
					for(int i=0; i < memberPersonStandardList.size(); i++) {
						writtenMonthCntMap = getMemberWrittenListSum(memberPersonStandardList.get(i).get("userNo").toString(),teamId,bgnDe,endDe);
						//당월수임건
						memberPersonStandardList.get(i).put("receiveMonthCnt", writtenMonthCntMap.get("sumSuimCnt").toString());
						//당월종결건
						memberPersonStandardList.get(i).put("closeMonthCnt", writtenMonthCntMap.get("sumEndCnt").toString());
						//전달미결건
						memberPersonStandardList.get(i).put("pendingMonthlyCnt", writtenMonthCntMap.get("sumBeforeUnsolveCnt").toString());
						//당월미결현황
						memberPersonStandardList.get(i).put("pendingCurrentCnt", writtenMonthCntMap.get("sumUnsolveCnt").toString());				
						//년누계수임건
						memberPersonStandardList.get(i).put("receiveYearCnt", writtenMonthCntMap.get("sumYearSuimCnt").toString());
						//년누계종결건
						memberPersonStandardList.get(i).put("closeYearCnt", writtenMonthCntMap.get("sumYearEndCnt").toString());
					}
				}
				
			} else {
				memberList = sqlSession.selectList("StatisticBasic.selectBasicMemberList4", paramMap);
				memberPersonStandardList = sqlSession.selectList("StatisticBasic.selectBasicMemberPersonStandardList4",
						paramMap);
			}

			Map<String, Object> teamMap = new HashMap<>();
			teamMap.put("teamList", memberList);
			teamExcelList.add(teamMap);

			Map<String, Object> personMap = new HashMap<>();
			personMap.put("personList", memberPersonStandardList);
			personExcelList.add(personMap);
		}

		// ===============================================
		// 뷰단 데이터 세팅
		// ===============================================
		model.addAttribute("teamVo", teamVo);
		model.addAttribute("teamList", teamList);
		model.addAttribute("teamExcelList", teamExcelList);
		model.addAttribute("personExcelList", personExcelList);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/statistics_basic_member_list_whole_excel_quick";

	}

	/**
	 * 개인별 기본 통계 팀 전체 엑셀 다운로드
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/statistics_basic_member_list_whole_excel")
	public String basicMemberListWholeExcel(HttpServletRequest request, Model model) throws Exception {
		// ===============================================
		// 권한체크
		// ===============================================
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
		if (!"1".equals(mbrAuthVo.getMbr_pms_21())) {
			return "redirect:/";
		}

		// ===============================================
		// 파라미터 체크
		// ===============================================
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

		// ===============================================
		// 현재 일자 세팅
		// ===============================================
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde")); // 기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde")); // 기준일자 종료일
		String teamId = StringUtil.null2blank(request.getParameter("team_id")); // 팀 아이디
		String excelYN = StringUtil.null2blank(request.getParameter("excelYN")); // 엑셀다운 여부
		String retireUser = StringUtil.null2blank(request.getParameter("retireUser")); // 다운로드시 퇴직자 포함여부
		String sToday = DateUtil.getTodayString();

		if ("".equals(stdBgnde)) {
			stdBgnde = DateUtil.getStartMonthDay();
			stdEndde = DateUtil.getEndMonthDay();

			stdBgnde = DateUtil.getDateFormat(stdBgnde, "-");
			stdEndde = DateUtil.getDateFormat(stdEndde, "-");

			paramMap.put("stdBgnde", stdBgnde);
			paramMap.put("stdEndde", stdEndde);
			paramMap.put("excelYN", "N");

			// =============================================
			// 수임 농작물 적부 기본값 세팅
			// =============================================
			paramMap.put("basicYN", "Y");
			paramMap.put("primYN", "N");
			paramMap.put("contractYN", "N");

		}

		if ("".equals(teamId)) {
			return "redirect:/";
		}

		// ===============================================
		// 필요 날짜 SET
		// ===============================================
		String bgnDe = stdBgnde.replace("-", "");
		String endDe = DateUtil.addDate(stdEndde.replace("-", ""), 1);
		String bgnYearDe = (Integer.parseInt(endDe.substring(0, 4)) - 1) + "1216";
		String endYearDe = endDe.substring(0, 4) + "1216";
		String sEndyear = endDe.substring(0, 4) + "-12-16";

		paramMap.put("bgnDe", bgnDe);
		paramMap.put("endDe", endDe);
		paramMap.put("bgnYearDe", bgnYearDe);
		paramMap.put("endYearDe", endYearDe);
		paramMap.put("today", sToday);
		
		paramMap.put("sEndyear", sEndyear);		

		// ===============================================
		// 비즈니스 로직 호출
		// ===============================================
		TopTmBscVO teamVo = sqlSession.selectOne("TmMngDtlMapper.selectOneTeam", teamId);
		if (teamVo == null) {
			return "redirect:/";
		}

		List<Map<String, Object>> teamList = sqlSession.selectList("StatisticBasic.selectStatisticTeamList");

		// ==============================================
		// 팀 전체 내용을 가져온다.
		// ==============================================
		List<Map<String, Object>> teamExcelList = new ArrayList<>();
		List<Map<String, Object>> personExcelList = new ArrayList<>();

		for (int idx = 0; idx < teamList.size(); idx++) {
			Map<String, Object> team = teamList.get(idx);

			String _teamId = String.valueOf(team.get("teamId"));
			String _teamType = String.valueOf(team.get("teamType"));

			paramMap.put("team_id", _teamId);

			List<Map<String, Object>> memberList = new ArrayList<>();
			List<Map<String, Object>> memberPersonStandardList = new ArrayList<>();

			if ("1".equals(_teamType)) {
				memberList = sqlSession.selectList("StatisticBasic.selectBasicMemberList1", paramMap);
				
				if( "Y".equals(retireUser) ) {		//퇴직자 포함다운로드
					//매달 재경팀 엑셀데이터 제출시 사용(퇴직일이 검색일자 내에 포함된 퇴직자)
					memberPersonStandardList = sqlSession.selectList("StatisticBasic.selectBasicMemberPersonStandardList1_retire",	paramMap);
				}else {
					memberPersonStandardList = sqlSession.selectList("StatisticBasic.selectBasicMemberPersonStandardList1",	paramMap);
				}
				
				//1종 서면심사인경우만 별도 카운트처리			
				//서면심사 팀에 속한 경우만 사용자의 수임종결건수를 별도계산한다.
				if("1".equals(teamVo.getTeam_written())) {
					
					Map<String,Object> writtenMonthCntMap = new HashMap<String, Object>();
					
					for(int i=0; i < memberList.size(); i++) {
						writtenMonthCntMap = getMemberWrittenListSum(memberList.get(i).get("userNo").toString(),teamId,bgnDe,endDe);
						//당월수임건
						memberList.get(i).put("receiveMonthCnt", writtenMonthCntMap.get("sumSuimCnt").toString());
						//당월종결건
						memberList.get(i).put("closeMonthCnt", writtenMonthCntMap.get("sumEndCnt").toString());
						//전달미결건
						memberList.get(i).put("pendingMonthlyCnt", writtenMonthCntMap.get("sumBeforeUnsolveCnt").toString());
						//당월미결현황
						memberList.get(i).put("pendingCurrentCnt", writtenMonthCntMap.get("sumUnsolveCnt").toString());				
						//년누계수임건
						memberList.get(i).put("receiveYearCnt", writtenMonthCntMap.get("sumYearSuimCnt").toString());
						//년누계종결건
						memberList.get(i).put("closeYearCnt", writtenMonthCntMap.get("sumYearEndCnt").toString());
					}
					
					for(int i=0; i < memberPersonStandardList.size(); i++) {
						writtenMonthCntMap = getMemberWrittenListSum(memberPersonStandardList.get(i).get("userNo").toString(),teamId,bgnDe,endDe);
						//당월수임건
						memberPersonStandardList.get(i).put("receiveMonthCnt", writtenMonthCntMap.get("sumSuimCnt").toString());
						//당월종결건
						memberPersonStandardList.get(i).put("closeMonthCnt", writtenMonthCntMap.get("sumEndCnt").toString());
						//전달미결건
						memberPersonStandardList.get(i).put("pendingMonthlyCnt", writtenMonthCntMap.get("sumBeforeUnsolveCnt").toString());
						//당월미결현황
						memberPersonStandardList.get(i).put("pendingCurrentCnt", writtenMonthCntMap.get("sumUnsolveCnt").toString());				
						//년누계수임건
						memberPersonStandardList.get(i).put("receiveYearCnt", writtenMonthCntMap.get("sumYearSuimCnt").toString());
						//년누계종결건
						memberPersonStandardList.get(i).put("closeYearCnt", writtenMonthCntMap.get("sumYearEndCnt").toString());
					}
				}
			} else {
				memberList = sqlSession.selectList("StatisticBasic.selectBasicMemberList4", paramMap);
				memberPersonStandardList = sqlSession.selectList("StatisticBasic.selectBasicMemberPersonStandardList4", paramMap);
				
				//매달 재경팀 엑셀데이터 제출시 사용(퇴직일이 검색일자 내에 포함된 퇴직자)
				//memberPersonStandardList = sqlSession.selectList("StatisticBasic.selectBasicMemberPersonStandardList4_20200716", paramMap);
			}
			
			//월별 기준업무량 시작
			String sUserno = "";
			String userSumPoint = "";
			String userSumYearPoint = ""; 
			
			String sTeam_id = paramMap.get("team_id").toString();
			int nChk_amp = 0; // 발령체크
			paramMap.put("team_id", sTeam_id);
			
			//년누계 시작 고정값
			String bgnYearCumul = bgnYearDe;		//년누계 계산 시작일
			String endYearCumul = sEndyear;		//년누계 계산 종료일

			// 가져온 리스트에 합산된 workload 값을 넣어준다.
			for (int i = 0; i < memberPersonStandardList.size(); i++) {
				Map<String, Object> map = memberPersonStandardList.get(i);
				sUserno = map.get("userNo").toString();
				paramMap.put("user_no", sUserno);
				// 기간내 팀소속인지 확인 (개인기준은 소속팀 체크 제외.. 20211220 by top3009)
				//nChk_amp = sqlSession.selectOne("StatisticBasic.appointChk", paramMap);

				// System.out.println("팀 체크 : "+ i +" : "+sUserno+" : "+sTeam_id+" : "+bgnDe+" :
				// "+endDe+" : "+nChk_amp);
				//if (nChk_amp == 0) { // 검색기간중 소속팀이 아닌경우
					//userSumPoint = "0";
				//} else {
					// 사용자 고유번호와 시작일자 종료일자를 가지고 표준환산합계점수를 가져온다.
					userSumPoint = getUserWorkpoint(sUserno, bgnDe, endDe);
					
					// 사용자 고유번호와 년시작일자 년 종료일자를 가지고 표준환산합계점수를 가져온다.					
					userSumYearPoint = getUserWorkpoint(sUserno, bgnYearCumul, endYearCumul);
				//}

				// 환산점수를 리스트에 넣어준다.
				memberPersonStandardList.get(i).put("workLoadMonthCal", userSumPoint);
				
				memberPersonStandardList.get(i).put("workLoadYear", userSumYearPoint);

				// System.out.println(sUserno+" : "+userSumPoint);
			}

			// 팀별리스트설정
			for (int i = 0; i < memberList.size(); i++) {
				Map<String, Object> map = memberList.get(i);
				sUserno = map.get("userNo").toString();
				paramMap.put("user_no", sUserno);

				// 기간내 팀소속인지 확인
				nChk_amp = sqlSession.selectOne("StatisticBasic.appointChk", paramMap);

				if (nChk_amp == 0) { // 검색기간중 소속팀이 아닌경우
					userSumPoint = "0";
				} else {
					// 사용자 고유번호와 시작일자 종료일자를 가지고 표준환산합계점수를 가져온다.
					userSumPoint = getUserWorkpoint(sUserno, bgnDe, endDe);
					
					// 사용자 고유번호와 년시작일자 년 종료일자를 가지고 표준환산합계점수를 가져온다.					
					userSumYearPoint = getUserWorkpoint(sUserno, bgnYearCumul, endYearCumul);
				}

				// 환산점수를 리스트에 넣어준다.
				memberList.get(i).put("workLoadMonthCal", userSumPoint);
				
				memberList.get(i).put("workLoadYear", userSumYearPoint);

				// System.out.println(sUserno+" : "+userSumPoint);
				// System.out.println(sUserno+" : "+sUsername+" : "+userSumPoint+" :
				// ("+work_load_month+" - "+work_load_last_month+")");
			}			
			//월별 기준업무량 끝

			Map<String, Object> teamMap = new HashMap<>();
			teamMap.put("teamList", memberList);
			teamExcelList.add(teamMap);

			Map<String, Object> personMap = new HashMap<>();
			personMap.put("personList", memberPersonStandardList);
			personExcelList.add(personMap);
		}

		// ===============================================
		// 뷰단 데이터 세팅
		// ===============================================
		model.addAttribute("teamVo", teamVo);
		model.addAttribute("teamList", teamList);
		model.addAttribute("teamExcelList", teamExcelList);
		model.addAttribute("personExcelList", personExcelList);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/statistics_basic_member_list_whole_excel";

	}

	/**
	 * 개인별 기본 통계 상세
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/statistics_basic_member_detail")
	public String basicMemberDetail(HttpServletRequest request, Model model) throws Exception {
		// ===============================================
		// 권한체크
		// ===============================================
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
		if (!"1".equals(mbrAuthVo.getMbr_pms_21())) {
			return "redirect:/";
		}

		// ===============================================
		// 파라미터 체크
		// ===============================================
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

		// ===============================================
		// 현재 일자 세팅
		// ===============================================
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde")); // 기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde")); // 기준일자 종료일
		String teamId = StringUtil.null2blank(request.getParameter("team_id")); // 팀 아이디
		String userNo = StringUtil.null2blank(request.getParameter("user_no")); // 유저 번호
		String excelYN = StringUtil.null2blank(request.getParameter("excelYN")); // 엑셀다운 여부

		if ("".equals(stdBgnde)) {
			stdBgnde = DateUtil.getStartMonthDay();
			stdEndde = DateUtil.getEndMonthDay();

			stdBgnde = DateUtil.getDateFormat(stdBgnde, "-");
			stdEndde = DateUtil.getDateFormat(stdEndde, "-");

			paramMap.put("stdBgnde", stdBgnde);
			paramMap.put("stdEndde", stdEndde);
			paramMap.put("excelYN", "N");

			// =============================================
			// 수임 농작물 적부 기본값 세팅
			// =============================================
			paramMap.put("basicYN", "Y");
			paramMap.put("primYN", "Y");
			paramMap.put("contractYN", "N");

		}

		if ("".equals(teamId) || "".equals(userNo)) {
			return "redirect:/";
		}

		// ===============================================
		// 필요 날짜 SET
		// ===============================================
		String bgnDe = stdBgnde.replace("-", "");
		String endDe = DateUtil.addDate(stdEndde.replace("-", ""), 1);
		String bgnYearDe = (Integer.parseInt(endDe.substring(0, 4)) - 1) + "1216";
		String endYearDe = endDe.substring(0, 4) + "1216";

		paramMap.put("bgnDe", bgnDe);
		paramMap.put("endDe", endDe);
		paramMap.put("bgnYearDe", bgnYearDe);
		paramMap.put("endYearDe", endYearDe);

		// 사용자별 년 목표량
		int year = Integer.parseInt(bgnDe.substring(0, 4));
		int month = Integer.parseInt(bgnDe.substring(4, 6));
		int day = Integer.parseInt(bgnDe.substring(6, 8));

		if (month == 12 && day > 15) {
			++year;
		}

		paramMap.put("year", year);

		String yearEa = sqlSession.selectOne("StatisticBasic.selectPersonYearEa", paramMap);

		if (yearEa == null || yearEa.equals("")) { // 값이 null 인경우 최종 발령팀 기준으로 가져온다.
			yearEa = sqlSession.selectOne("StatisticBasic.selectPersonYearEaNull", paramMap);
		}

		// System.out.println("시작일="+bgnDe+" : 종료일="+endDe);
		// System.out.println("bgnYearDe="+bgnYearDe+" : endYearDe="+endYearDe);
		// System.out.println("yearEa="+yearEa);

		// 년간 업무목표량
		paramMap.put("yearEa", yearEa);

		// List<Map<String,Object>> workloadList =
		// workloadService.workloadStatistics(userList, paramMap);

		// ===============================================
		// 비즈니스 로직 호출
		// ===============================================

		TopTmBscVO teamVo = sqlSession.selectOne("TmMngDtlMapper.selectOneTeam", teamId);
		Map<String, Object> memberVo = sqlSession.selectOne("StatisticBasic.selectStatisticMember", paramMap);
		List<Map<String, Object>> memberList = sqlSession.selectList("StatisticBasic.selectStatisticMemberList",
				paramMap);

		// 상세리스트 및 미수금 리스트
		List<Map<String, Object>> detailList = sqlSession.selectList("StatisticBasic.selectDetailList", paramMap);
		List<Map<String, Object>> detailPersonStandardList = sqlSession.selectList("StatisticBasic.selectDetailPersonStandardList", paramMap);
		List<Map<String, Object>> detailOutAmtList = sqlSession.selectList("StatisticBasic.selectDetailOutAmtList",	paramMap);

		// ===============================================
		// 뷰단 데이터 세팅
		// ===============================================
		model.addAttribute("teamVo", teamVo);
		model.addAttribute("memberVo", memberVo);
		model.addAttribute("memberList", memberList);

		model.addAttribute("detailList", detailList);
		model.addAttribute("detailPersonStandardList", detailPersonStandardList);
		model.addAttribute("detailOutAmtList", detailOutAmtList);

		model.addAttribute("srchArg", paramMap);

		String retURL = "top_statistics/statistics_basic_member_detail";

		if ("Y".equals(excelYN)) {
			retURL = "top_statistics/statistics_basic_member_detail_excel";
		}

		return retURL;
	}

	/**
	 * 업무처리현황 엑셀 다운로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/statistics_basic_list_excel", method = RequestMethod.POST)
	public String basicExcel(HttpServletRequest request, HttpServletResponse response) {
		// ===============================================
		// 권한체크
		// ===============================================
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();

		if (!"1".equals(mbrAuthVo.getMbr_pms_21())) {
			return "redirect:/";
		}

		String excelHtml = StringUtil.null2blank(request.getParameter("excelHtml")); // 엑셀 표시 부분
		String gubun = StringUtil.null2blank(request.getParameter("gubun")); // 팀 멤버 구분

		response.reset();
		// response.setCharacterEncoding("euc-kr");
		response.setContentType("application/vnd.ms-excel; charset=UTF-8");
		response.setHeader("Content-Disposition", "attachment;filename=basic_" + gubun + "_statistic.xls");
		response.setHeader("Content-Description", "JSP Generated Data");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		out.println(excelHtml);

		return null;
	}

	/*
	 * public static void main(String[] args) {
	 * 
	 * //개인별 기준업무량 환산계산 String nUserno = "426"; String sStart = "2019-04-16"; String
	 * sEnd = "2019-05-15";
	 * 
	 * double dSum = 0; StatisticBasicController sc = new
	 * StatisticBasicController(); try { dSum =
	 * Double.parseDouble(sc.getUserWorkpoint(nUserno, sStart, sEnd));
	 * }catch(Exception ex) { ex.printStackTrace(); }
	 * 
	 * System.out.println("dSum="+dSum);
	 * 
	 * }
	 */
}
