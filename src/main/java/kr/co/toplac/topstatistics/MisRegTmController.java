package kr.co.toplac.topstatistics;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.toplac.cmm.service.CodeDicService;
import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.sysadm.SysAdmCodeDicVO;
import kr.co.toplac.topgeneral.EmpNmlstTmDtlVO;
import kr.co.toplac.topptnr.TopPtnrBscVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;
import kr.co.toplac.util.cmm.WebUtil;

/*
*********************************************************
* Program ID	: MisRegTmController
* Program Name	: 
* Description	: 
* Author		: leedongik
* Date			: 2015.12.30.
* Update		: lds 180820, 수임,농작물 분리 
*********************************************************
*/
@Controller
public class MisRegTmController {

	private static final Logger logger = LoggerFactory.getLogger(MisRegTmController.class);

	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private CodeDicService service;
	
	
	/**
	 * 보험사별 손해사정서 교부현황 엑셀 다운로드
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getSuimReportPtnrExcel")
	public String getSuimReportPtnrExcel(Model model, HttpSession session, HttpServletRequest request) {
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		List<Map<String,Object>> ReportList = sqlSession.selectList("MisEndTmMapper.getInsuReportListByDetail", paramMap);
				
		String sSuimRptNo = "";
		Map<String,Object> ReportMethodMap = new HashMap<>();		
		for(int i=0; i < ReportList.size(); i++) {
			sSuimRptNo = String.valueOf(ReportList.get(i).get("suimRptNo"));
			ReportMethodMap = sqlSession.selectOne("MisEndTmMapper.getInsuReportListBySendMethod", sSuimRptNo);
			ReportList.get(i).put("conMethod", ReportMethodMap.get("conMethod"));
			ReportList.get(i).put("insMethod", ReportMethodMap.get("insMethod"));
			ReportList.get(i).put("claMethod", ReportMethodMap.get("claMethod"));
		}		
		
		model.addAttribute("ReportList", ReportList);
		
		return "top_statistics/suim_report_ptnr_excel";
	}
	
	/**
	 * 보험사별 손해사정서 교부현황 목록 가져오기
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getSuimReportPtnrAjax")
	public String getSuimReportPtnrAjax(Model model, HttpSession session, HttpServletRequest request) {
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		List<Map<String,Object>> ReportList = sqlSession.selectList("MisEndTmMapper.getInsuReportListByDetail", paramMap);
				
		String sSuimRptNo = "";
		Map<String,Object> ReportMethodMap = new HashMap<>();		
		for(int i=0; i < ReportList.size(); i++) {
			sSuimRptNo = String.valueOf(ReportList.get(i).get("suimRptNo"));
			ReportMethodMap = sqlSession.selectOne("MisEndTmMapper.getInsuReportListBySendMethod", sSuimRptNo);
			ReportList.get(i).put("conMethod", ReportMethodMap.get("conMethod"));
			ReportList.get(i).put("insMethod", ReportMethodMap.get("insMethod"));
			ReportList.get(i).put("claMethod", ReportMethodMap.get("claMethod"));
		}		
		
		model.addAttribute("ReportList", ReportList);
		
		return "top_statistics/suim_report_ptnr_ajax";
	}
	
	/**
	 * 보험사별 손해사정서 교부현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/getSuimReportPtnr")
	public String getSuimReportPtnr(Model model, HttpSession session, HttpServletRequest request) {
		
		//조회 권한 불러오기		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	    TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
	    
	    String pms47 = mbrAuthVo.getMbr_pms_47();
	    model.addAttribute("pms47", pms47);		
		
		//검색할 보험사 목록		
		List<TopPtnrBscVO> ptnrList = sqlSession.selectList("RptInvListMapper.ptnrListForSearch");
		model.addAttribute("ptnrList", ptnrList);
		
		//직원 검색의 직원리스트 가져오기
		List<TopTmBscVO> memberSelList = sqlSession.selectList("StatisticBasic.selectTopMemberList");		
		model.addAttribute("memberSelList",memberSelList);
		
		//검색 시작일과 종료일 구하기 (조회길 기준 지난달의 첫날과 말일을 넣어준다.)
		String srchSdate = "";
		String srchEdate = "";
		
		//오늘날짜		
		//한달전 날짜를 불러온다.		
		String sToday = DateUtil.getTodayString();
        Date dToday = DateUtil.getDateFromDateStr(sToday);
        int nLastDay = 31;		//지난달의 마지막날

        Calendar cal = Calendar.getInstance();        
        cal.setTime(dToday);
        cal.add(Calendar.MONTH, -1);
        nLastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String sLastMonth = sdf.format(cal.getTime());
        
        srchSdate = sLastMonth.substring(0,8)+"01";
        srchEdate = sLastMonth.substring(0,8)+Integer.toString(nLastDay);
        
		model.addAttribute("srchSdate",srchSdate);
		model.addAttribute("srchEdate",srchEdate);
		
		String excelYN = StringUtil.null2blank(request.getParameter("excelYN"));  //엑셀다운 여부
		
		return "top_statistics/suim_report_ptnr";
	}
		
	@RequestMapping(value = "/getSuimReportTm")
	public String getSuimReportTm(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= getSuimReportTm =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			logger.info("getMisRegTm - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        //menuId 값에 따라 종결일자 데이터를 제한한다. (old : 2025-09-31이전, new : 2025-09-31이후)
        String sMenuId = request.getParameter("menuId") == null ? "new" : request.getParameter("menuId");
        String sChkDate = request.getParameter("chkDate") == null ? "2025-10-01" : request.getParameter("chkDate");
        
        //===============================================
        // 현재 일자 세팅
        //===============================================
        String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));  //기준일자 시작일
        String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));  //기준일자 종료일        
        
        String sViewType = request.getParameter("view_type") == null ? "Team" : request.getParameter("view_type");
        String sTeam_id = request.getParameter("team_id") == null ? "" : request.getParameter("team_id");
        String sTeam_name = request.getParameter("team_name") == null ? "" : request.getParameter("team_name");
        String sTeam_type = request.getParameter("team_type") == null ? "" : request.getParameter("team_type");
        String sUser_no = request.getParameter("user_no") == null ? "" : request.getParameter("user_no");
        String sPtnr_id = request.getParameter("ptnr_id") == null ? "" : request.getParameter("ptnr_id");		//보험사아이디
        String sPtnr_nick = request.getParameter("ptnr_nick") == null ? "" : request.getParameter("ptnr_nick");		//보험사이름
        String sInsu_type = request.getParameter("insu_type") == null ? "" : request.getParameter("insu_type");		//1,4종 구분값
        String sUser_name = request.getParameter("user_name") == null ? "" : request.getParameter("user_name");
        String excelYN = StringUtil.null2blank(request.getParameter("excelYN"));  //엑셀다운 여부
        
        //String sViewType = request.getParameter("view_type");			//목록 타입 (Team : 팀통계목록, Member : 직원통계목록)

        if ("".equals(stdBgnde)){
            stdBgnde = DateUtil.getStartMonthDay();
            stdEndde = DateUtil.getEndMonthDay();

            stdBgnde = DateUtil.getDateFormat(stdBgnde,"-");
            stdEndde = DateUtil.getDateFormat(stdEndde,"-");

            paramMap.put("stdBgnde",stdBgnde);
            paramMap.put("stdEndde",stdEndde);
            paramMap.put("excelYN", "N");

            //=============================================
            // 수임 농작물 적부 기본값 세팅
            //=============================================
            paramMap.put("basicYN", "Y");			//기본수임
            paramMap.put("primYN", "Y");			//농작물
            
            paramMap.put("chkDate", sChkDate);		//메뉴변경에 따른 chkDate 추가 (2025-10-01)

        }        

        //===============================================
        // 필요 날짜 SET
        //===============================================
        String bgnDe = stdBgnde.replace("-","");
        String endDe = DateUtil.addDate(stdEndde.replace("-",""),1);
        String bgnYearDe = (Integer.parseInt(endDe.substring(0,4)) - 1)  + "-12-16";
        String endYearDe = endDe.substring(0,4) + "-12-16";

        paramMap.put("bgnDe", bgnDe);
        paramMap.put("endDe", endDe);
        paramMap.put("bgnYearDe", bgnYearDe);
        paramMap.put("endYearDe", endYearDe);		
        
		StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", bgnDe);
		nowVO.setBasicYN( String.valueOf(paramMap.get("basicYN")) );
		nowVO.setPrimYN( String.valueOf(paramMap.get("primYN")) );
		
		//System.out.println("sViewType="+sViewType);
		//System.out.println("oniku 검색기간 = "+stdBgnde+" : "+stdEndde);
		//System.out.println("sTeam_id="+sTeam_id);
		//System.out.println("sUser_no="+sUser_no);
		//System.out.println("excelYN="+excelYN);
		//System.out.println("sPtnr_id="+sPtnr_id);
		//System.out.println("sInsu_type="+sInsu_type);
		
		paramMap.put("startDate", stdBgnde);
		paramMap.put("endDate", stdEndde);
		
		//직원 검색의 직원리스트 가져오기
		List<TopTmBscVO> memberSelList = sqlSession.selectList("StatisticBasic.selectTopMemberList",paramMap);		
		model.addAttribute("memberSelList",memberSelList);
		
		if( sViewType.equals("Member") ) {			//개인 통계 목록			
			paramMap.put("team_id", sTeam_id);
			paramMap.put("team_type", sTeam_name);
			paramMap.put("team_name", sTeam_type);
			List<MisRegTmVO> MemberList = sqlSession.selectList("MisEndTmMapper.getMemberList", paramMap);			
			model.addAttribute("MemberList",MemberList);
			model.addAttribute("team_id", sTeam_id);
			model.addAttribute("team_type", sTeam_type);
			model.addAttribute("team_name", sTeam_name);			
		}else if(sViewType.equals("Person")) {			
			paramMap.put("user_no", sUser_no);
			List<MisRegTmVO> ReportList = sqlSession.selectList("MisEndTmMapper.getReportList", paramMap);
			model.addAttribute("team_id", sTeam_id);
			model.addAttribute("team_type", sTeam_type);
			model.addAttribute("user_no", sUser_no);			
			model.addAttribute("user_name", sUser_name);
			model.addAttribute("team_name", sTeam_name);
			model.addAttribute("ReportList", ReportList);
		}else if(sViewType.equals("Insu")) {			//보험사별 목록			
			List<MisRegTmVO> TeamList1 = sqlSession.selectList("MisEndTmMapper.getReportInsu1", paramMap);
			model.addAttribute("TeamList1",TeamList1);
			List<MisRegTmVO> TeamList4 = sqlSession.selectList("MisEndTmMapper.getReportInsu4", paramMap);
			model.addAttribute("TeamList4",TeamList4);
		}else if(sViewType.equals("InsuDetail")){		//보험사 내 보고서 목록			
			paramMap.put("ptnr_id", sPtnr_id);			
			paramMap.put("insu_type", sInsu_type);
			List<MisRegTmVO> ReportList = sqlSession.selectList("MisEndTmMapper.getInsuReportList", paramMap);			
			model.addAttribute("ptnr_id", sPtnr_id);
			model.addAttribute("ptnr_nick", sPtnr_nick);
			model.addAttribute("insu_type", sInsu_type);
			model.addAttribute("ReportList", ReportList);
		}else{										//기본 팀 통계 목록			
			List<MisRegTmVO> TeamList1 = sqlSession.selectList("MisEndTmMapper.getReportTeam1", paramMap);			
			model.addAttribute("TeamList1",TeamList1);
			List<MisRegTmVO> TeamList4 = sqlSession.selectList("MisEndTmMapper.getReportTeam4", paramMap);
			model.addAttribute("TeamList4",TeamList4);
		} 		

		model.addAttribute("view_type", sViewType);		
		model.addAttribute("nowVO", nowVO);
        model.addAttribute("srchArg",paramMap);
        
        String retURL = "top_statistics/suim_report_tm";
        
        if ("Y".equals(excelYN)){
            retURL = "top_statistics/suim_report_tm_excel";
            model.addAttribute("excelYN", "N");
        }

		return retURL; 
	}
	
	/**
	 * 현장보고서 엑셀다운로드
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getSiteExcelDown")
	public String getSiteExcelDown(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= getSiteExcelDown =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String exelType = paramMap.get("exelType").toString();
		
		String sToday = DateUtil.getTodayString("yyyy-MM-dd");    	
		String sStartYear = DateUtil.getStartYearDay(sToday);
		String sEndYear = DateUtil.getEndYearDay(sToday);

		paramMap.put("start_date", sStartYear);
		paramMap.put("end_date", sEndYear);
		
		try {
    		String textDate = DateUtil.getTextDateFormat(sStartYear);
    		model.addAttribute("start_date", textDate);
		} catch (Exception e) {
			logger.error("parseError : "+e.getMessage());
		}
        
        //개인별 현장보고서 제출 현황
        List<Map<String,Object>> memberSiteResult = sqlSession.selectList("MisRegTmMapper.selectSiteReportMemberList",paramMap);
        model.addAttribute("memberSiteResult", memberSiteResult);
        
        //팀으로 조회한 전체 보고서 목록
        List<Map<String,Object>> teamSiteAllList = sqlSession.selectList("MisRegTmMapper.selectSiteReportTeamListAll",paramMap);
        
        //팀별 현장보고서 제출 현황            	
    	List<Map<String,Object>> teamSiteResult = new ArrayList<>();	//팀기준 현장보고서 제출 팝업데이터    	
    	List<Map<String,Object>> teamInfoList = sqlSession.selectList("TopLoginMapper.selectTeamListAuthSearchFor1", paramMap);
    	    	
    	String tempTeamId = "";
		String tempTeamname = "";
		String tempCenterName = "";
		
		int nTempSuimCnt = 0;					//30일내 수임건수			
		int nTempSub3OverCnt = 0;				//3일초과 현장보고서 결재			
		int nTempNot3OverCnt = 0;				//3일초과 현장보고서 미결재			
		int nOverPer = 0;							//초과비율(3영업일초과건수 / 전체수임건)
    	
    	int nIndex = 0;
		
		for(int i=0; i < teamInfoList.size(); i++) {
			
			Map<String,Object> teamSiteMap = new HashMap<>();						//for 문내에서 Map 사용시 밖에서 선언하면 안됨.				
			tempTeamId = teamInfoList.get(i).get("teamId").toString();
			tempTeamname = teamInfoList.get(i).get("teamName").toString();
			tempCenterName = teamInfoList.get(i).get("centerName").toString();			
			
			teamSiteMap.put("team_id", tempTeamId);
			teamSiteMap.put("team_name", tempTeamname);
			teamSiteMap.put("center_name", tempCenterName);
			teamSiteMap.put("suim_cnt", "0");
			teamSiteMap.put("sub_3_in_cnt", "0");
			teamSiteMap.put("sub_3_over_cnt", "0");
			teamSiteMap.put("not_3_in_cnt", "0");
			teamSiteMap.put("not_3_over_cnt", "0");
			teamSiteMap.put("over_per", "0");
			teamSiteMap.put("not_30_over_cnt", "0");
			teamSiteMap.put("end_average_cnt", "0");
			
			//System.out.println(teamInfoList.get(i).get("teamId").toString()+" : "+teamInfoList.get(i).get("teamName").toString());
			
			for(int k=0; k < teamSiteAllList.size(); k++) {
				if( tempTeamId.equals(teamSiteAllList.get(k).get("team_id").toString()) ) {						
					teamSiteMap.put("suim_cnt", teamSiteAllList.get(k).get("suim_cnt").toString());
					teamSiteMap.put("sub_3_in_cnt", teamSiteAllList.get(k).get("sub_3_in_cnt").toString());
					teamSiteMap.put("sub_3_over_cnt", teamSiteAllList.get(k).get("sub_3_over_cnt").toString());
					teamSiteMap.put("not_3_in_cnt", teamSiteAllList.get(k).get("not_3_in_cnt").toString());
					teamSiteMap.put("not_3_over_cnt", teamSiteAllList.get(k).get("not_3_over_cnt").toString());						
					teamSiteMap.put("not_30_over_cnt", teamSiteAllList.get(k).get("not_30_over_cnt").toString());
					teamSiteMap.put("end_average_cnt", teamSiteAllList.get(k).get("end_average_cnt").toString());
					
					//퍼센트 계산
					nTempSuimCnt = Integer.parseInt(teamSiteAllList.get(k).get("suim_cnt").toString());
					nTempSub3OverCnt = Integer.parseInt(teamSiteAllList.get(k).get("sub_3_over_cnt").toString());
					nTempNot3OverCnt = Integer.parseInt(teamSiteAllList.get(k).get("not_3_over_cnt").toString());
					
					if( nTempSuimCnt > 0) {
						nOverPer = ((nTempSub3OverCnt+nTempNot3OverCnt) * 100) / nTempSuimCnt;
					}else {
						nOverPer = 0;
					}						
					teamSiteMap.put("over_per", String.valueOf(nOverPer));						
				}
			}
			
			//조회 대상 수(수임0, 1개월 미재출건 0)가 전부 0이 아닌경우
			//if( "0".equals(teamSiteMap.get("suim_cnt").toString() ) && "0".equals(teamSiteMap.get("not_30_over_cnt").toString() ) ) {
			if( "0".equals(teamSiteMap.get("suim_cnt").toString() ) && "0".equals(teamSiteMap.get("not_30_over_cnt").toString() ) && "0".equals(teamSiteMap.get("end_average_cnt").toString() ) ) {
				//
			}else {
				teamSiteResult.add(nIndex, teamSiteMap);
				nIndex++;
			}
		}
        
		model.addAttribute("teamSiteResult", teamSiteResult);
        
		//센터별 현장보고서 제출 현황            	
    	List<Map<String,Object>> centerSiteResult = new ArrayList<>();				//센터기준 현장보고서 제출 팝업데이터    	
    	List<Map<String,Object>> centerInfoList = sqlSession.selectList("TopLoginMapper.selectCenterListFor1");
    	
    	String sCenterNo = "";
    	String sCenterName = "";
    	
    	int sum_suim_cnt = 0;
    	int sum_sub_3_in_cnt = 0;
    	int sum_sub_3_over_cnt = 0;
    	int sum_not_3_in_cnt = 0;
    	int sum_not_3_over_cnt = 0;
    	int sum_not_30_over_cnt = 0;
    	int sum_end_average_cnt = 0;
    	
    	int teamCnt = 0;
    	
    	for(int i=0; i < centerInfoList.size(); i++) {
    		
    		Map<String,Object> centerSiteMap = new HashMap<>();						//for 문내에서 Map 사용시 밖에서 선언하면 안됨.				
    		sCenterNo = centerInfoList.get(i).get("center_no").toString();
    		sCenterName = centerInfoList.get(i).get("center_name").toString();				
			
    		centerSiteMap.put("team_center", sCenterNo);
    		centerSiteMap.put("center_name", sCenterName);
    		centerSiteMap.put("suim_cnt", "0");
    		centerSiteMap.put("sub_3_in_cnt", "0");
    		centerSiteMap.put("sub_3_over_cnt", "0");
    		centerSiteMap.put("not_3_in_cnt", "0");
    		centerSiteMap.put("not_3_over_cnt", "0");
    		centerSiteMap.put("over_per", "0");
    		centerSiteMap.put("not_30_over_cnt", "0");
    		centerSiteMap.put("end_average_cnt", "0");
    		
    		for(int k=0; k < teamSiteAllList.size(); k++) {
				if( sCenterNo.equals(teamSiteAllList.get(k).get("team_center").toString()) ) {
					sum_suim_cnt += Integer.parseInt(teamSiteAllList.get(k).get("suim_cnt").toString());
					sum_sub_3_in_cnt += Integer.parseInt(teamSiteAllList.get(k).get("sub_3_in_cnt").toString());
					sum_sub_3_over_cnt += Integer.parseInt(teamSiteAllList.get(k).get("sub_3_over_cnt").toString());
					sum_not_3_in_cnt += Integer.parseInt(teamSiteAllList.get(k).get("not_3_in_cnt").toString());
					sum_not_3_over_cnt += Integer.parseInt(teamSiteAllList.get(k).get("not_3_over_cnt").toString());
					sum_not_30_over_cnt += Integer.parseInt(teamSiteAllList.get(k).get("not_30_over_cnt").toString());
					sum_end_average_cnt += Integer.parseInt(teamSiteAllList.get(k).get("end_average_cnt").toString());
					teamCnt++;
				}					
			}
    		centerSiteMap.put("suim_cnt", sum_suim_cnt);
    		centerSiteMap.put("sub_3_in_cnt", sum_sub_3_in_cnt);
    		centerSiteMap.put("sub_3_over_cnt", sum_sub_3_over_cnt);
    		centerSiteMap.put("not_3_in_cnt", sum_not_3_in_cnt);
    		centerSiteMap.put("not_3_over_cnt", sum_not_3_over_cnt);
    		centerSiteMap.put("not_30_over_cnt", sum_not_30_over_cnt);
    		
    		if( teamCnt > 0 ) {
    			centerSiteMap.put("end_average_cnt", sum_end_average_cnt / teamCnt);
    		}else {
    			centerSiteMap.put("end_average_cnt", 0);
    		}
    		
    		if( sum_suim_cnt > 0 ) {
    			nOverPer = ((sum_sub_3_over_cnt + sum_not_3_over_cnt) * 100) / sum_suim_cnt;
    		}else{
    			nOverPer = 0;
    		}
    		
    		centerSiteMap.put("over_per", nOverPer);        		
    		
			centerSiteResult.add(i, centerSiteMap);
			
			//합계값 초기화
			sum_suim_cnt = 0;
        	sum_sub_3_in_cnt = 0;
        	sum_sub_3_over_cnt = 0;
        	sum_not_3_in_cnt = 0;
        	sum_not_3_over_cnt = 0;
        	sum_not_30_over_cnt = 0;
        	sum_end_average_cnt = 0;
        	nOverPer = 0;
        	teamCnt = 0;     		
    	}
    	
    	model.addAttribute("centerSiteResult", centerSiteResult);
    	
    	//부문별 현장보고서 제출현황
    	List<Map<String,Object>> sectorSiteResult = new ArrayList<>();				//부문기준 현장보고서 제출 팝업데이터    	
    	List<Map<String,Object>> sectorInfoList = sqlSession.selectList("TopLoginMapper.selectSectorListFor1");
    	
    	String sSectorNo = "";
    	String sSectorName = "";
    	
    	int sector_sum_suim_cnt = 0;
    	int sector_sum_sub_3_in_cnt = 0;
    	int sector_sum_sub_3_over_cnt = 0;
    	int sector_sum_not_3_in_cnt = 0;
    	int sector_sum_not_3_over_cnt = 0;
    	int sector_sum_not_30_over_cnt = 0;
    	int sector_sum_end_average_cnt = 0;
    	int sector_nOverPer = 0;
    	int sector_teamCnt = 0;
    	
    	for(int i=0; i < sectorInfoList.size(); i++) {
    		
    		Map<String,Object> sectorSiteMap = new HashMap<>();						//for 문내에서 Map 사용시 밖에서 선언하면 안됨.				
    		sSectorNo = sectorInfoList.get(i).get("team_sector").toString();
    		sSectorName = sectorInfoList.get(i).get("sector_name").toString();				
			
    		sectorSiteMap.put("team_sector", sSectorNo);
    		sectorSiteMap.put("sector_name", sSectorName);
    		sectorSiteMap.put("suim_cnt", "0");
    		sectorSiteMap.put("sub_3_in_cnt", "0");
    		sectorSiteMap.put("sub_3_over_cnt", "0");
    		sectorSiteMap.put("not_3_in_cnt", "0");
    		sectorSiteMap.put("not_3_over_cnt", "0");
    		sectorSiteMap.put("over_per", "0");
    		sectorSiteMap.put("not_30_over_cnt", "0");
    		sectorSiteMap.put("end_average_cnt", "0");
    		
    		for(int k=0; k < teamSiteAllList.size(); k++) {
				if( sSectorNo.equals(teamSiteAllList.get(k).get("team_sector").toString()) ) {
					sector_sum_suim_cnt += Integer.parseInt(teamSiteAllList.get(k).get("suim_cnt").toString());
					sector_sum_sub_3_in_cnt += Integer.parseInt(teamSiteAllList.get(k).get("sub_3_in_cnt").toString());
					sector_sum_sub_3_over_cnt += Integer.parseInt(teamSiteAllList.get(k).get("sub_3_over_cnt").toString());
					sector_sum_not_3_in_cnt += Integer.parseInt(teamSiteAllList.get(k).get("not_3_in_cnt").toString());
					sector_sum_not_3_over_cnt += Integer.parseInt(teamSiteAllList.get(k).get("not_3_over_cnt").toString());
					sector_sum_not_30_over_cnt += Integer.parseInt(teamSiteAllList.get(k).get("not_30_over_cnt").toString());
					sector_sum_end_average_cnt += Integer.parseInt(teamSiteAllList.get(k).get("end_average_cnt").toString());
					sector_teamCnt++;
				}					
			}
    		sectorSiteMap.put("suim_cnt", sector_sum_suim_cnt);
    		sectorSiteMap.put("sub_3_in_cnt", sector_sum_sub_3_in_cnt);
    		sectorSiteMap.put("sub_3_over_cnt", sector_sum_sub_3_over_cnt);
    		sectorSiteMap.put("not_3_in_cnt", sector_sum_not_3_in_cnt);
    		sectorSiteMap.put("not_3_over_cnt", sector_sum_not_3_over_cnt);
    		sectorSiteMap.put("not_30_over_cnt", sector_sum_not_30_over_cnt);
    		
    		if( sector_teamCnt > 0 ) {
    			sectorSiteMap.put("end_average_cnt", sector_sum_end_average_cnt / sector_teamCnt);
    		}else {
    			sectorSiteMap.put("end_average_cnt", 0);
    		}
    		
    		if( sector_sum_suim_cnt > 0 ) {
    			sector_nOverPer = ((sector_sum_sub_3_over_cnt + sector_sum_not_3_over_cnt) * 100) / sector_sum_suim_cnt;
    		}else{
    			sector_nOverPer = 0;
    		}
    		
    		sectorSiteMap.put("over_per", sector_nOverPer);        		
    		
			sectorSiteResult.add(i, sectorSiteMap);
			
			//합계값 초기화
			sector_sum_suim_cnt = 0;
			sector_sum_sub_3_in_cnt = 0;
			sector_sum_sub_3_over_cnt = 0;
			sector_sum_not_3_in_cnt = 0;
			sector_sum_not_3_over_cnt = 0;
			sector_sum_not_30_over_cnt = 0;
			sector_sum_end_average_cnt = 0;
        	sector_nOverPer = 0;
        	sector_teamCnt = 0;
    	}
    	
    	model.addAttribute("sectorSiteResult", sectorSiteResult);        
        
        model.addAttribute("exelType", exelType);
        
        return "top_statistics/site_report_all_excel";
	}
	
	@RequestMapping(value="/siteReportDetailModal")
	public String siteReportDetailModal(HttpServletRequest request, Model model, HttpSession session) {
		logger.info("======= siteReportDetailModal =======");
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        String modalType = request.getParameter("modalType") != null ? request.getParameter("modalType") : "";
        
        int nChk = 0;
        
        if( "M".equals(modalType) ) {			//개인별 상세 정보
        	
        	Map<String,Object> memberSiteMap = new HashMap<>();
        	
        	paramMap.put("user_no", paramMap.get("modalKey").toString());
        	paramMap.put("reg_date", paramMap.get("modalDate").toString());
        	
        	nChk = sqlSession.selectOne("MisRegTmMapper.selectMemberDetailInfoCnt", paramMap);
        	
        	if( nChk == 1) {
        		memberSiteMap = sqlSession.selectOne("MisRegTmMapper.selectMemberDetailInfo", paramMap);
        	}else{
        		memberSiteMap = sqlSession.selectOne("MisRegTmMapper.selectMemberDetailInfoSimple", paramMap);
        	}
        	
        	model.addAttribute("memberSiteMap", memberSiteMap);
        	
        } else if( "T".equals(modalType) ) {
        	Map<String,Object> teamSiteMap = new HashMap<>();
        	
        	paramMap.put("team_id", paramMap.get("modalKey").toString());
        	paramMap.put("reg_date", paramMap.get("modalDate").toString());
        	
        	nChk = sqlSession.selectOne("MisRegTmMapper.selectTeamDetailInfoCnt", paramMap);
        	
        	if( nChk == 1) {
        		teamSiteMap = sqlSession.selectOne("MisRegTmMapper.selectTeamDetailInfo", paramMap);
        	}else{
        		teamSiteMap = sqlSession.selectOne("MisRegTmMapper.selectTeamDetailInfoSimple", paramMap);
        	}
        	
        	model.addAttribute("teamSiteMap", teamSiteMap);
        	
        } else if( "C".equals(modalType) ) {
        	Map<String,Object> centerSiteMap = new HashMap<>();
        	
        	paramMap.put("team_center", paramMap.get("modalKey").toString());
        	paramMap.put("reg_date", paramMap.get("modalDate").toString());
        	
        	nChk = sqlSession.selectOne("MisRegTmMapper.selectCenterDetailInfoCnt", paramMap);
        	
        	if( nChk > 0) {			//1개 이상의 센터에 소속된 팀실적이 있는경우
        		centerSiteMap = sqlSession.selectOne("MisRegTmMapper.selectCenterDetailInfo", paramMap);
        	}else{
        		centerSiteMap = sqlSession.selectOne("MisRegTmMapper.selectCenterDetailInfoSimple", paramMap);
        	}
        	
        	model.addAttribute("centerSiteMap", centerSiteMap);
        } else if( "S".equals(modalType) ) {
        	Map<String,Object> sectorSiteMap = new HashMap<>();
        	
        	paramMap.put("team_sector", paramMap.get("modalKey").toString());
        	paramMap.put("reg_date", paramMap.get("modalDate").toString());
        	
        	nChk = sqlSession.selectOne("MisRegTmMapper.selectSectorDetailInfoCnt", paramMap);
        	
        	if( nChk > 0) {			//1개 이상의 센터에 소속된 팀실적이 있는경우
        		sectorSiteMap = sqlSession.selectOne("MisRegTmMapper.selectSectorDetailInfo", paramMap);
        	}else{
        		sectorSiteMap = sqlSession.selectOne("MisRegTmMapper.selectSectorDetailInfoSimple", paramMap);
        	}
        	
        	model.addAttribute("sectorSiteMap", sectorSiteMap);
        }
        
        //CommonUtils.printMap(paramMap);
        
        model.addAttribute("modalType", modalType);
		
		return "top_statistics/site_report_detail_modal";
	}
	
	/**
	 * 현장보고서 개인 (팀원) 모달창 막대그래프 
	 * @param request
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/frontChartMemberModal")
	public String frontChartMemberModal(HttpServletRequest request, Model model, HttpSession session) {
		
		logger.info("======= frontChartMemberModal =======");
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        String sTeam_id = paramMap.get("team_id").toString();
        String center_total_over_per = paramMap.get("total_over_per").toString();
        String center_total_over_per_val = "";
        
        List<Map<String,Object>> memberSiteAllList = sqlSession.selectList("TopLoginMapper.selectSiteMemberReportListAll",paramMap);
		
		List<EmpNmlstTmDtlVO> memberList = sqlSession.selectList("empNmlstTmDtlMapper.getMemberAll",sTeam_id);
		
		String tempUserNo = "";
		String tempUserName = "";
		String tempTeamName = "";
		
		List<Map<String,Object>> memberSiteResult = new ArrayList<>();		//팀원기준 현장보고서 제출 팝업데이터
    	
    	int nTempSuimCnt = 0;					//30일내 수임건수			
		int nTempSub3OverCnt = 0;				//3일초과 현장보고서 결재			
		int nTempNot3OverCnt = 0;				//3일초과 현장보고서 미결재			
		int nOverPer = 0;							//초과비율(3영업일초과건수 / 전체수임건)
		
		String user_name_val = "";
		String over_per_val = "";
		
		int sum_sub_3_over_cnt = 0;
		int sum_not_3_over_cnt = 0;
		int sum_suim_cnt = 0;
		int total_over_per = 0;
		String total_over_per_val = "";
		
		for( int i = 0; i < memberList.size(); i++ ) {    			
			Map<String,Object> memberSiteMap = new HashMap<>();						//for 문내에서 Map 사용시 밖에서 선언하면 안됨.
			
			tempUserNo = memberList.get(i).getUser_no();
			tempUserName = memberList.get(i).getUser_name();
			tempTeamName = memberList.get(i).getTeam_name();				
			
			memberSiteMap.put("user_no", tempUserNo);
			memberSiteMap.put("user_name", tempUserName);
			memberSiteMap.put("tempTeamName", tempTeamName);
			memberSiteMap.put("suim_cnt", "0");
			memberSiteMap.put("sub_3_in_cnt", "0");
			memberSiteMap.put("sub_3_over_cnt", "0");
			memberSiteMap.put("not_3_in_cnt", "0");
			memberSiteMap.put("not_3_over_cnt", "0");
			memberSiteMap.put("over_per", "0");
			memberSiteMap.put("not_30_over_cnt", "0");
			memberSiteMap.put("end_average_cnt", "0");				
			
			for(int k=0; k < memberSiteAllList.size(); k++) {
				if( tempUserNo.equals(memberSiteAllList.get(k).get("user_no").toString()) ) {						
					memberSiteMap.put("suim_cnt", memberSiteAllList.get(k).get("suim_cnt").toString());
					memberSiteMap.put("sub_3_in_cnt", memberSiteAllList.get(k).get("sub_3_in_cnt").toString());
					memberSiteMap.put("sub_3_over_cnt", memberSiteAllList.get(k).get("sub_3_over_cnt").toString());
					memberSiteMap.put("not_3_in_cnt", memberSiteAllList.get(k).get("not_3_in_cnt").toString());
					memberSiteMap.put("not_3_over_cnt", memberSiteAllList.get(k).get("not_3_over_cnt").toString());						
					memberSiteMap.put("not_30_over_cnt", memberSiteAllList.get(k).get("not_30_over_cnt").toString());
					memberSiteMap.put("end_average_cnt", memberSiteAllList.get(k).get("end_average_cnt").toString());
					//퍼센트 계산
					nTempSuimCnt = Integer.parseInt(memberSiteAllList.get(k).get("suim_cnt").toString());
					nTempSub3OverCnt = Integer.parseInt(memberSiteAllList.get(k).get("sub_3_over_cnt").toString());
					nTempNot3OverCnt = Integer.parseInt(memberSiteAllList.get(k).get("not_3_over_cnt").toString());
					if( nTempSuimCnt > 0) {
						nOverPer = ((nTempSub3OverCnt+nTempNot3OverCnt) * 100) / nTempSuimCnt;
					}else {
						nOverPer = 0;
					}						
					memberSiteMap.put("over_per", String.valueOf(nOverPer));
					sum_suim_cnt += nTempSuimCnt;
					sum_sub_3_over_cnt += nTempSub3OverCnt;
					sum_not_3_over_cnt += nTempNot3OverCnt;
				}
			}			
			memberSiteResult.add(i,memberSiteMap);			
		}
		
		total_over_per = Math.round( ( ( (sum_sub_3_over_cnt+sum_not_3_over_cnt) * 100 ) / sum_suim_cnt ) );
		
		for( int i=0; i < memberSiteResult.size(); i++ ) {
			user_name_val += "['"+memberSiteResult.get(i).get("user_name").toString()+"','("+memberSiteResult.get(i).get("over_per").toString()+"%)']";			
			over_per_val +=  "'"+memberSiteResult.get(i).get("over_per").toString()+"'";
			total_over_per_val += "'"+String.valueOf(total_over_per)+"'";
			center_total_over_per_val += "'"+center_total_over_per+"'";
			
			if( i < memberSiteResult.size() ) {
				user_name_val += ",";
				over_per_val += ",";
				total_over_per_val += ",";
				center_total_over_per_val += ",";
			}
		}
		
		/*
		System.out.println( "user_name_val : "+user_name_val );
		System.out.println( "over_per_val : "+over_per_val );		
		System.out.println( "sum_suim_cnt : "+sum_suim_cnt );
		System.out.println( "sum_sub_3_over_cnt : "+sum_sub_3_over_cnt );
		System.out.println( "sum_not_3_over_cnt : "+sum_not_3_over_cnt );		
		System.out.println( "total_over_per : "+total_over_per );		
		System.out.println( "tempTeamName : "+tempTeamName );
		*/		
		
		model.addAttribute("user_name_val", user_name_val);
		model.addAttribute("over_per_val", over_per_val);
		model.addAttribute("total_over_per", total_over_per_val);		
		model.addAttribute("team_name", tempTeamName);
		
		model.addAttribute("center_total_over_per", center_total_over_per);
		model.addAttribute("center_total_over_per_val", center_total_over_per_val);
		
		model.addAttribute("all_over_per_sum_text", total_over_per);		
        
        return "top_main/front_chart_member_modal";
	}
	
	/**
	 * 현장보고서 모달창 막대그래프 
	 * @param request
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/frontChartDetailModal")
	public String frontChartDetailModal(HttpServletRequest request, Model model, HttpSession session) {
		
		logger.info("======= frontChartDetailModal =======");
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        //CommonUtils.printMap(paramMap);
                
        String [] all_name = request.getParameterValues("all_name[]");
        String [] all_over_per = request.getParameterValues("all_over_per[]");
        String all_over_per_sum = request.getParameter("all_over_per_sum");
        String total_over_per = request.getParameter("total_over_per");
        
        String viewType = request.getParameter("viewType");
        
        //String name_val = Arrays.toString(all_name);
        
        String name_val = "";
        String over_per_val = Arrays.toString(all_over_per);
        String all_over_per_sum_val = "";
        String total_over_per_val = "";
        
        for( int i=0; i < all_name.length; i++ ) {
        	
        	all_over_per_sum_val += all_over_per_sum;
        	total_over_per_val +=total_over_per;
        	
        	name_val += "\'"+all_name[i]+"\'";
        	if( i < all_name.length-1 ) {
        		name_val += ",";
        		all_over_per_sum_val += ",";
        		total_over_per_val +=",";
        	}
        }
        
        name_val = name_val.replaceAll("'\\[", "\\[");
        name_val = name_val.replaceAll("\\]'", "\\]");
        
        String title_main = "";
        String title_sub1 = "";
        String title_sub2 = "";
        String title_sub3 = "";			//팀, 개인 조회시 사용
        
        title_main = "현장보고서 기한내 제출율 비교현황";
        
        int nY = 0;
        int nX = 0;
        
        if("center_all".equals(viewType)) {        	
            title_sub1 = "센터 전체 평균";            
            title_sub2 = "센터 기한내 제출율";
            nY = all_name.length*100;
            nX = 750;            
        }else if( "center_sel".equals(viewType) ) {
        	title_sub1 = "팀 평균 기한내 제출율(소속센터)";
            title_sub2 = "팀 기한내 제출율";
            title_sub3 = "팀 평균 기한내 제출율(전체)";
            nY = 800;
            nX = 400;
        }else if( "team_sel".equals(viewType) ) {        	
        	title_sub1 = "팀 평균 기한내 제출율(소속팀)";
            title_sub2 = "개인 기한내 제출율";
            title_sub3 = "팀 평균 기한내 제출율(소속센터)";
            nY = 800;
            nX = 400;
        }else if( "team_all".equals(viewType) ) {        	
        	title_sub1 = "팀 전체 평균";
            title_sub2 = "팀 기한내 제출율";
            nY = 1600;
            nX = 700;
        }else if("sector_all".equals(viewType)) {
        	title_sub1 = "부문 전체 평균";
            title_sub2 = "부문 기한내 제출율";
            nY = 800;
            nX = 400;
        }
        
        model.addAttribute("viewType", viewType);
        	
        model.addAttribute("nYsize", nY);
        model.addAttribute("nXsize", nX);
        
        model.addAttribute("title_main", title_main);
        model.addAttribute("title_sub1", title_sub1);
        model.addAttribute("title_sub2", title_sub2);
        model.addAttribute("title_sub3", title_sub3);
        
        model.addAttribute("all_name", name_val);
        model.addAttribute("all_over_per", over_per_val);
        
        //평균값 1개
        model.addAttribute("all_over_per_sum_text",all_over_per_sum);
        model.addAttribute("all_over_per_sum", all_over_per_sum_val);
        
        //상위단계 평균값
        model.addAttribute("total_over_per", total_over_per);
        model.addAttribute("total_over_per_val", total_over_per_val);        
        
        return "top_main/front_chart_detail_modal";        
	}
	
	/**
	 * 현장보고서 막대 그래프 보기 
	 * @param request
	 * @param model
	 * @param session
	 * @return
	 */	
	@RequestMapping(value="/siteChartBarDetailModal")
	public String siteChartBarDetailModal(HttpServletRequest request, Model model, HttpSession session) {
		
		logger.info("======= siteChartDetailModal =======");
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        String modalType = request.getParameter("modalType") != null ? request.getParameter("modalType") : "";
        
        String sUrl = "";
        
        //CommonUtils.printMap(paramMap);
        
        if( "M".equals(modalType) ) {
        	sUrl = "top_statistics/site_chart_member_bar_modal";
        	model.addAttribute("center_name", paramMap.get("modalCenterName").toString());
        	model.addAttribute("team_name", paramMap.get("modalTeamName").toString());
        	model.addAttribute("user_name", paramMap.get("modalUserName").toString());
        	
        	//전달 값
        	model.addAttribute("suim_cnt", paramMap.get("modalSuim").toString());
        	model.addAttribute("sub_3_in", paramMap.get("modalSub3In").toString());
        	model.addAttribute("sub_3_over", paramMap.get("modalSub3Over").toString());
        	model.addAttribute("not_3_in", paramMap.get("modalNot3In").toString());
        	model.addAttribute("not_3_over", paramMap.get("modalNot3Over").toString());        	
        }
        
        model.addAttribute("modalType", modalType);
        
        return sUrl;
	}
	
	/**
	 * 현장보고서 통계 그래프 보기 
	 * @param request
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/siteChartDetailModal")
	public String siteChartDetailModal(HttpServletRequest request, Model model, HttpSession session) {
		logger.info("======= siteChartDetailModal =======");
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        String modalType = request.getParameter("modalType") != null ? request.getParameter("modalType") : "";
        
        //기준일자
        String modalDate = request.getParameter("modalDate") != null ? request.getParameter("modalDate") : DateUtil.getTodayString("yyyy-MM-dd");
        
        //CommonUtils.printMap(paramMap);
        
        StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics30DaysDate", modalDate);
        
        String sUrl = "";
        
        //개인 그래프인경우 사번으로 셋팅
        if( "M".equals(modalType) ) {
        	nowVO.setUser_no(paramMap.get("modalKey").toString());			//개인사번셋팅        	
        	sUrl = "top_statistics/site_chart_member_modal";
        }else if( "T".equals(modalType) ){
        	nowVO.setTeam_id(paramMap.get("modalKey").toString());
        	sUrl = "top_statistics/site_chart_team_modal";
        }else if( "C".equals(modalType) ) {
        	nowVO.setTeam_center(paramMap.get("modalKey").toString());
        	sUrl = "top_statistics/site_chart_center_modal";
        }else if( "S".equals(modalType) ) {
        	nowVO.setTeam_sector(paramMap.get("modalKey").toString());
        	sUrl = "top_statistics/site_chart_sector_modal";
        }
        
        model.addAttribute("nowVO", nowVO);
        
        //그래프의 가로열(날짜목록을 만든다)
        String chart_period_val = "";
        
		chart_period_val = "'"+nowVO.getDayBefore30().substring(8,10) + "','" + nowVO.getDayBefore29().substring(8,10) + "','" + nowVO.getDayBefore28().substring(8,10) + "','"
				+ nowVO.getDayBefore27().substring(8,10) + "','" + nowVO.getDayBefore26().substring(8,10) + "','" + nowVO.getDayBefore25().substring(8,10) + "','"
				+ nowVO.getDayBefore24().substring(8,10) + "','" + nowVO.getDayBefore23().substring(8,10) + "','" + nowVO.getDayBefore22().substring(8,10) + "','"
				+ nowVO.getDayBefore21().substring(8,10) + "','" + nowVO.getDayBefore20().substring(8,10) + "','" + nowVO.getDayBefore19().substring(8,10) + "','"
				+ nowVO.getDayBefore18().substring(8,10) + "','" + nowVO.getDayBefore17().substring(8,10) + "','" + nowVO.getDayBefore16().substring(8,10) + "','"
				+ nowVO.getDayBefore15().substring(8,10) + "','" + nowVO.getDayBefore14().substring(8,10) + "','" + nowVO.getDayBefore13().substring(8,10) + "','"
				+ nowVO.getDayBefore12().substring(8,10) + "','" + nowVO.getDayBefore11().substring(8,10) + "','" + nowVO.getDayBefore10().substring(8,10) + "','"
				+ nowVO.getDayBefore9().substring(8,10) + "','" + nowVO.getDayBefore8().substring(8,10) + "','" + nowVO.getDayBefore7().substring(8,10) + "','"
				+ nowVO.getDayBefore6().substring(8,10) + "','" + nowVO.getDayBefore5().substring(8,10) + "','" + nowVO.getDayBefore4().substring(8,10) + "','"
				+ nowVO.getDayBefore3().substring(8,10) + "','" + nowVO.getDayBefore2().substring(8,10) + "','" + nowVO.getDayBefore1().substring(8,10) + "'";		
		model.addAttribute("chart_period_val", chart_period_val);
		
		String chart_interval_days = nowVO.getDayBefore30() + " ~ " + nowVO.getDayBefore1();		
		model.addAttribute("chart_interval_days", chart_interval_days);
		
		//개인 그래프인경우 사번으로 셋팅
        if( "M".equals(modalType) ) {
		
			//개인 초과율 목록
			Map<String,Object> memberSiteMap = sqlSession.selectOne("MisRegTmMapper.selectSiteMember30OverChart", nowVO);
			
			String chart_member_val = "";
			
			chart_member_val = memberSiteMap.get("over_per_30").toString() + ","
					+ memberSiteMap.get("over_per_29").toString() + "," + memberSiteMap.get("over_per_28").toString() + ","
					+ memberSiteMap.get("over_per_27").toString() + "," + memberSiteMap.get("over_per_26").toString() + ","
					+ memberSiteMap.get("over_per_25").toString() + "," + memberSiteMap.get("over_per_24").toString() + ","
					+ memberSiteMap.get("over_per_23").toString() + "," + memberSiteMap.get("over_per_22").toString() + ","
					+ memberSiteMap.get("over_per_21").toString() + "," + memberSiteMap.get("over_per_20").toString() + ","
					+ memberSiteMap.get("over_per_19").toString() + "," + memberSiteMap.get("over_per_18").toString() + ","
					+ memberSiteMap.get("over_per_17").toString() + "," + memberSiteMap.get("over_per_16").toString() + ","
					+ memberSiteMap.get("over_per_15").toString() + "," + memberSiteMap.get("over_per_14").toString() + ","
					+ memberSiteMap.get("over_per_13").toString() + "," + memberSiteMap.get("over_per_12").toString() + ","
					+ memberSiteMap.get("over_per_11").toString() + "," + memberSiteMap.get("over_per_10").toString() + ","
					+ memberSiteMap.get("over_per_9").toString() + "," + memberSiteMap.get("over_per_8").toString() + ","
					+ memberSiteMap.get("over_per_7").toString() + "," + memberSiteMap.get("over_per_6").toString() + ","
					+ memberSiteMap.get("over_per_5").toString() + "," + memberSiteMap.get("over_per_4").toString() + ","
					+ memberSiteMap.get("over_per_3").toString() + "," + memberSiteMap.get("over_per_2").toString() + ","
					+ memberSiteMap.get("over_per_1").toString();
			
			model.addAttribute("chart_member_val", chart_member_val);
			model.addAttribute("memberSiteMap", memberSiteMap);
			
			//팀별 초과율 목록
			nowVO.setTeam_id(memberSiteMap.get("team_id").toString());			
			
			Map<String,Object> teamSiteMap = sqlSession.selectOne("MisRegTmMapper.selectSiteTeam30OverChart", nowVO);
			
			String chart_team_val = "";
			
			chart_team_val = teamSiteMap.get("over_per_30").toString() + ","
					+ teamSiteMap.get("over_per_29").toString() + "," + teamSiteMap.get("over_per_28").toString() + ","
					+ teamSiteMap.get("over_per_27").toString() + "," + teamSiteMap.get("over_per_26").toString() + ","
					+ teamSiteMap.get("over_per_25").toString() + "," + teamSiteMap.get("over_per_24").toString() + ","
					+ teamSiteMap.get("over_per_23").toString() + "," + teamSiteMap.get("over_per_22").toString() + ","
					+ teamSiteMap.get("over_per_21").toString() + "," + teamSiteMap.get("over_per_20").toString() + ","
					+ teamSiteMap.get("over_per_19").toString() + "," + teamSiteMap.get("over_per_18").toString() + ","
					+ teamSiteMap.get("over_per_17").toString() + "," + teamSiteMap.get("over_per_16").toString() + ","
					+ teamSiteMap.get("over_per_15").toString() + "," + teamSiteMap.get("over_per_14").toString() + ","
					+ teamSiteMap.get("over_per_13").toString() + "," + teamSiteMap.get("over_per_12").toString() + ","
					+ teamSiteMap.get("over_per_11").toString() + "," + teamSiteMap.get("over_per_10").toString() + ","
					+ teamSiteMap.get("over_per_9").toString() + "," + teamSiteMap.get("over_per_8").toString() + ","
					+ teamSiteMap.get("over_per_7").toString() + "," + teamSiteMap.get("over_per_6").toString() + ","
					+ teamSiteMap.get("over_per_5").toString() + "," + teamSiteMap.get("over_per_4").toString() + ","
					+ teamSiteMap.get("over_per_3").toString() + "," + teamSiteMap.get("over_per_2").toString() + ","
					+ teamSiteMap.get("over_per_1").toString();			
			
			model.addAttribute("chart_team_val", chart_team_val);
			model.addAttribute("teamSiteMap", teamSiteMap);
			
			//센터 초과율 목록
			String team_center = memberSiteMap.get("team_center").toString();
			
			nowVO.setTeam_center(team_center);
			
			Map<String,Object> centerSiteMap = sqlSession.selectOne("MisRegTmMapper.selectSiteCenter30OverChart", nowVO);
			
			//스케줄러상에 등록되어있는 센터 목록 수를 가져온다.
			int nCenterCnt = sqlSession.selectOne("MisRegTmMapper.selectSiteCenter30OverChartCnt", nowVO);
			
			float center_over_per_1 = 0;
	        float center_over_per_2 = 0;
	        float center_over_per_3 = 0;
	        float center_over_per_4 = 0;
	        float center_over_per_5 = 0;
	        float center_over_per_6 = 0;
	        float center_over_per_7 = 0;
	        float center_over_per_8 = 0;
	        float center_over_per_9 = 0;
	        float center_over_per_10 = 0;
	        float center_over_per_11 = 0;
	        float center_over_per_12 = 0;
	        float center_over_per_13 = 0;
	        float center_over_per_14 = 0;
	        float center_over_per_15 = 0;
	        float center_over_per_16 = 0;
	        float center_over_per_17 = 0;
	        float center_over_per_18 = 0;
	        float center_over_per_19 = 0;
	        float center_over_per_20 = 0;
	        float center_over_per_21 = 0;
	        float center_over_per_22 = 0;
	        float center_over_per_23 = 0;
	        float center_over_per_24 = 0;
	        float center_over_per_25 = 0;
	        float center_over_per_26 = 0;
	        float center_over_per_27 = 0;
	        float center_over_per_28 = 0;
	        float center_over_per_29 = 0;
	        float center_over_per_30 = 0;
	        
	        if( nCenterCnt > 0 ) {
	        	center_over_per_1 = Float.parseFloat(centerSiteMap.get("over_per_1").toString());
	        	if( center_over_per_1 > 0 ) {
	        		center_over_per_1 = Math.round(center_over_per_1 / nCenterCnt);
	        	}
	        	
	        	center_over_per_2 = Float.parseFloat(centerSiteMap.get("over_per_2").toString());
	        	if( center_over_per_2 > 0 ) {
	        		center_over_per_2 = Math.round(center_over_per_2 / nCenterCnt);
	        	}
	        	
	        	center_over_per_3 = Float.parseFloat(centerSiteMap.get("over_per_3").toString());
	        	if( center_over_per_3 > 0 ) {
	        		center_over_per_3 = Math.round(center_over_per_3 / nCenterCnt);
	        	}
	        	
	        	center_over_per_4 = Float.parseFloat(centerSiteMap.get("over_per_4").toString());
	        	if( center_over_per_4 > 0 ) {
	        		center_over_per_4 = Math.round(center_over_per_4 / nCenterCnt);
	        	}
	        	
	        	center_over_per_5 = Float.parseFloat(centerSiteMap.get("over_per_5").toString());
	        	if( center_over_per_5 > 0 ) {
	        		center_over_per_5 = Math.round(center_over_per_5 / nCenterCnt);
	        	}
	        	
	        	center_over_per_6 = Float.parseFloat(centerSiteMap.get("over_per_6").toString());
	        	if( center_over_per_6 > 0 ) {
	        		center_over_per_6 = Math.round(center_over_per_6 / nCenterCnt);
	        	}
	        	
	        	center_over_per_7 = Float.parseFloat(centerSiteMap.get("over_per_7").toString());
	        	if( center_over_per_7 > 0 ) {
	        		center_over_per_7= Math.round(center_over_per_7 / nCenterCnt);
	        	}
	        	
	        	center_over_per_8 = Float.parseFloat(centerSiteMap.get("over_per_8").toString());
	        	if( center_over_per_8 > 0 ) {
	        		center_over_per_8 = Math.round(center_over_per_8 / nCenterCnt);
	        	}
	        	
	        	center_over_per_9 = Float.parseFloat(centerSiteMap.get("over_per_9").toString());
	        	if( center_over_per_9 > 0 ) {
	        		center_over_per_9 = Math.round(center_over_per_9 / nCenterCnt);
	        	}
	        	
	        	center_over_per_10 = Float.parseFloat(centerSiteMap.get("over_per_10").toString());
	        	if( center_over_per_10 > 0 ) {
	        		center_over_per_10 = Math.round(center_over_per_10 / nCenterCnt);
	        	}
	        	
	        	center_over_per_11 = Float.parseFloat(centerSiteMap.get("over_per_11").toString());
	        	if( center_over_per_11 > 0 ) {
	        		center_over_per_11 = Math.round(center_over_per_11 / nCenterCnt);
	        	}
	        	
	        	center_over_per_12 = Float.parseFloat(centerSiteMap.get("over_per_12").toString());
	        	if( center_over_per_12 > 0 ) {
	        		center_over_per_12 = Math.round(center_over_per_12 / nCenterCnt);
	        	}
	        	
	        	center_over_per_13 = Float.parseFloat(centerSiteMap.get("over_per_13").toString());
	        	if( center_over_per_13 > 0 ) {
	        		center_over_per_13 = Math.round(center_over_per_13 / nCenterCnt);
	        	}
	        	
	        	center_over_per_14 = Float.parseFloat(centerSiteMap.get("over_per_14").toString());
	        	if( center_over_per_14 > 0 ) {
	        		center_over_per_14 = Math.round(center_over_per_14 / nCenterCnt);
	        	}
	        	
	        	center_over_per_15 = Float.parseFloat(centerSiteMap.get("over_per_15").toString());
	        	if( center_over_per_15 > 0 ) {
	        		center_over_per_15 = Math.round(center_over_per_15 / nCenterCnt);
	        	}
	        	
	        	center_over_per_16 = Float.parseFloat(centerSiteMap.get("over_per_16").toString());
	        	if( center_over_per_16 > 0 ) {
	        		center_over_per_16 = Math.round(center_over_per_16 / nCenterCnt);
	        	}
	        	
	        	center_over_per_17 = Float.parseFloat(centerSiteMap.get("over_per_17").toString());
	        	if( center_over_per_17 > 0 ) {
	        		center_over_per_17= Math.round(center_over_per_17 / nCenterCnt);
	        	}
	        	
	        	center_over_per_18 = Float.parseFloat(centerSiteMap.get("over_per_18").toString());
	        	if( center_over_per_18 > 0 ) {
	        		center_over_per_18 = Math.round(center_over_per_18 / nCenterCnt);
	        	}
	        	
	        	center_over_per_19 = Float.parseFloat(centerSiteMap.get("over_per_19").toString());
	        	if( center_over_per_19 > 0 ) {
	        		center_over_per_19 = Math.round(center_over_per_19 / nCenterCnt);
	        	}
	        	
	        	center_over_per_20 = Float.parseFloat(centerSiteMap.get("over_per_20").toString());
	        	if( center_over_per_20 > 0 ) {
	        		center_over_per_20 = Math.round(center_over_per_20 / nCenterCnt);
	        	}
	        	
	        	center_over_per_21 = Float.parseFloat(centerSiteMap.get("over_per_21").toString());
	        	if( center_over_per_21 > 0 ) {
	        		center_over_per_21 = Math.round(center_over_per_21 / nCenterCnt);
	        	}
	        	
	        	center_over_per_22 = Float.parseFloat(centerSiteMap.get("over_per_22").toString());
	        	if( center_over_per_22 > 0 ) {
	        		center_over_per_22 = Math.round(center_over_per_22 / nCenterCnt);
	        	}
	        	
	        	center_over_per_23 = Float.parseFloat(centerSiteMap.get("over_per_23").toString());
	        	if( center_over_per_23 > 0 ) {
	        		center_over_per_23 = Math.round(center_over_per_23 / nCenterCnt);
	        	}
	        	
	        	center_over_per_24 = Float.parseFloat(centerSiteMap.get("over_per_24").toString());
	        	if( center_over_per_24 > 0 ) {
	        		center_over_per_24 = Math.round(center_over_per_24 / nCenterCnt);
	        	}
	        	
	        	center_over_per_25 = Float.parseFloat(centerSiteMap.get("over_per_25").toString());
	        	if( center_over_per_25 > 0 ) {
	        		center_over_per_25 = Math.round(center_over_per_25 / nCenterCnt);
	        	}
	        	
	        	center_over_per_26 = Float.parseFloat(centerSiteMap.get("over_per_26").toString());
	        	if( center_over_per_26 > 0 ) {
	        		center_over_per_26 = Math.round(center_over_per_26 / nCenterCnt);
	        	}
	        	
	        	center_over_per_27 = Float.parseFloat(centerSiteMap.get("over_per_27").toString());
	        	if( center_over_per_27 > 0 ) {
	        		center_over_per_27= Math.round(center_over_per_27 / nCenterCnt);
	        	}
	        	
	        	center_over_per_28 = Float.parseFloat(centerSiteMap.get("over_per_28").toString());
	        	if( center_over_per_28 > 0 ) {
	        		center_over_per_28 = Math.round(center_over_per_28 / nCenterCnt);
	        	}
	        	
	        	center_over_per_29 = Float.parseFloat(centerSiteMap.get("over_per_29").toString());
	        	if( center_over_per_29 > 0 ) {
	        		center_over_per_29 = Math.round(center_over_per_29 / nCenterCnt);
	        	}
	        	
	        	center_over_per_30 = Float.parseFloat(centerSiteMap.get("over_per_30").toString());
	        	if( center_over_per_30 > 0 ) {
	        		center_over_per_30 = Math.round(center_over_per_30 / nCenterCnt);
	        	}
	        }
	        
	        String chart_center_val = "";
	        
			chart_center_val = center_over_per_30 + "," + center_over_per_29 + "," + center_over_per_28 + ","
					+ center_over_per_27 + "," + center_over_per_26 + "," + center_over_per_25 + ","
					+ center_over_per_24 + "," + center_over_per_23 + "," + center_over_per_22 + ","
					+ center_over_per_21 + "," + center_over_per_20 + "," + center_over_per_19 + ","
					+ center_over_per_18 + "," + center_over_per_17 + "," + center_over_per_16 + ","
					+ center_over_per_15 + "," + center_over_per_14 + "," + center_over_per_13 + ","
					+ center_over_per_12 + "," + center_over_per_11 + "," + center_over_per_10 + "," 
					+ center_over_per_9 + "," + center_over_per_8 + "," + center_over_per_7 + "," 
					+ center_over_per_6 + "," + center_over_per_5 + "," + center_over_per_4 + ","
					+ center_over_per_3 + "," + center_over_per_2 + "," + center_over_per_1;	        
	        
	        model.addAttribute("chart_center_val", chart_center_val);
			
			//부문 초과율 목록
			String team_sector = memberSiteMap.get("team_sector").toString();
			
			nowVO.setTeam_sector(team_sector);
			
			Map<String,Object> sectorSiteMap = sqlSession.selectOne("MisRegTmMapper.selectSiteSector30OverChart", nowVO);
			
			//스케줄러상에 등록되어있는 부문 목록 수를 가져온다.
			int nSectorCnt = sqlSession.selectOne("MisRegTmMapper.selectSiteSector30OverChartCnt", nowVO);			
			
			float sector_over_per_1 = 0;
	        float sector_over_per_2 = 0;
	        float sector_over_per_3 = 0;
	        float sector_over_per_4 = 0;
	        float sector_over_per_5 = 0;
	        float sector_over_per_6 = 0;
	        float sector_over_per_7 = 0;
	        float sector_over_per_8 = 0;
	        float sector_over_per_9 = 0;
	        float sector_over_per_10 = 0;
	        float sector_over_per_11 = 0;
	        float sector_over_per_12 = 0;
	        float sector_over_per_13 = 0;
	        float sector_over_per_14 = 0;
	        float sector_over_per_15 = 0;
	        float sector_over_per_16 = 0;
	        float sector_over_per_17 = 0;
	        float sector_over_per_18 = 0;
	        float sector_over_per_19 = 0;
	        float sector_over_per_20 = 0;
	        float sector_over_per_21 = 0;
	        float sector_over_per_22 = 0;
	        float sector_over_per_23 = 0;
	        float sector_over_per_24 = 0;
	        float sector_over_per_25 = 0;
	        float sector_over_per_26 = 0;
	        float sector_over_per_27 = 0;
	        float sector_over_per_28 = 0;
	        float sector_over_per_29 = 0;
	        float sector_over_per_30 = 0;
	        
	        if( nSectorCnt > 0 ) {
	        	sector_over_per_1 = Float.parseFloat(sectorSiteMap.get("over_per_1").toString());
	        	if( sector_over_per_1 > 0 ) {
	        		sector_over_per_1 = Math.round(sector_over_per_1 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_2 = Float.parseFloat(sectorSiteMap.get("over_per_2").toString());
	        	if( sector_over_per_2 > 0 ) {
	        		sector_over_per_2 = Math.round(sector_over_per_2 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_3 = Float.parseFloat(sectorSiteMap.get("over_per_3").toString());
	        	if( sector_over_per_3 > 0 ) {
	        		sector_over_per_3 = Math.round(sector_over_per_3 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_4 = Float.parseFloat(sectorSiteMap.get("over_per_4").toString());
	        	if( sector_over_per_4 > 0 ) {
	        		sector_over_per_4 = Math.round(sector_over_per_4 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_5 = Float.parseFloat(sectorSiteMap.get("over_per_5").toString());
	        	if( sector_over_per_5 > 0 ) {
	        		sector_over_per_5 = Math.round(sector_over_per_5 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_6 = Float.parseFloat(sectorSiteMap.get("over_per_6").toString());
	        	if( sector_over_per_6 > 0 ) {
	        		sector_over_per_6 = Math.round(sector_over_per_6 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_7 = Float.parseFloat(sectorSiteMap.get("over_per_7").toString());
	        	if( sector_over_per_7 > 0 ) {
	        		sector_over_per_7= Math.round(sector_over_per_7 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_8 = Float.parseFloat(sectorSiteMap.get("over_per_8").toString());
	        	if( sector_over_per_8 > 0 ) {
	        		sector_over_per_8 = Math.round(sector_over_per_8 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_9 = Float.parseFloat(sectorSiteMap.get("over_per_9").toString());
	        	if( sector_over_per_9 > 0 ) {
	        		sector_over_per_9 = Math.round(sector_over_per_9 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_10 = Float.parseFloat(sectorSiteMap.get("over_per_10").toString());
	        	if( sector_over_per_10 > 0 ) {
	        		sector_over_per_10 = Math.round(sector_over_per_10 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_11 = Float.parseFloat(sectorSiteMap.get("over_per_11").toString());
	        	if( sector_over_per_11 > 0 ) {
	        		sector_over_per_11 = Math.round(sector_over_per_11 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_12 = Float.parseFloat(sectorSiteMap.get("over_per_12").toString());
	        	if( sector_over_per_12 > 0 ) {
	        		sector_over_per_12 = Math.round(sector_over_per_12 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_13 = Float.parseFloat(sectorSiteMap.get("over_per_13").toString());
	        	if( sector_over_per_13 > 0 ) {
	        		sector_over_per_13 = Math.round(sector_over_per_13 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_14 = Float.parseFloat(sectorSiteMap.get("over_per_14").toString());
	        	if( sector_over_per_14 > 0 ) {
	        		sector_over_per_14 = Math.round(sector_over_per_14 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_15 = Float.parseFloat(sectorSiteMap.get("over_per_15").toString());
	        	if( sector_over_per_15 > 0 ) {
	        		sector_over_per_15 = Math.round(sector_over_per_15 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_16 = Float.parseFloat(sectorSiteMap.get("over_per_16").toString());
	        	if( sector_over_per_16 > 0 ) {
	        		sector_over_per_16 = Math.round(sector_over_per_16 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_17 = Float.parseFloat(sectorSiteMap.get("over_per_17").toString());
	        	if( sector_over_per_17 > 0 ) {
	        		sector_over_per_17= Math.round(sector_over_per_17 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_18 = Float.parseFloat(sectorSiteMap.get("over_per_18").toString());
	        	if( sector_over_per_18 > 0 ) {
	        		sector_over_per_18 = Math.round(sector_over_per_18 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_19 = Float.parseFloat(sectorSiteMap.get("over_per_19").toString());
	        	if( sector_over_per_19 > 0 ) {
	        		sector_over_per_19 = Math.round(sector_over_per_19 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_20 = Float.parseFloat(sectorSiteMap.get("over_per_20").toString());
	        	if( sector_over_per_20 > 0 ) {
	        		sector_over_per_20 = Math.round(sector_over_per_20 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_21 = Float.parseFloat(sectorSiteMap.get("over_per_21").toString());
	        	if( sector_over_per_21 > 0 ) {
	        		sector_over_per_21 = Math.round(sector_over_per_21 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_22 = Float.parseFloat(sectorSiteMap.get("over_per_22").toString());
	        	if( sector_over_per_22 > 0 ) {
	        		sector_over_per_22 = Math.round(sector_over_per_22 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_23 = Float.parseFloat(sectorSiteMap.get("over_per_23").toString());
	        	if( sector_over_per_23 > 0 ) {
	        		sector_over_per_23 = Math.round(sector_over_per_23 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_24 = Float.parseFloat(sectorSiteMap.get("over_per_24").toString());
	        	if( sector_over_per_24 > 0 ) {
	        		sector_over_per_24 = Math.round(sector_over_per_24 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_25 = Float.parseFloat(sectorSiteMap.get("over_per_25").toString());
	        	if( sector_over_per_25 > 0 ) {
	        		sector_over_per_25 = Math.round(sector_over_per_25 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_26 = Float.parseFloat(sectorSiteMap.get("over_per_26").toString());
	        	if( sector_over_per_26 > 0 ) {
	        		sector_over_per_26 = Math.round(sector_over_per_26 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_27 = Float.parseFloat(sectorSiteMap.get("over_per_27").toString());
	        	if( sector_over_per_27 > 0 ) {
	        		sector_over_per_27= Math.round(sector_over_per_27 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_28 = Float.parseFloat(sectorSiteMap.get("over_per_28").toString());
	        	if( sector_over_per_28 > 0 ) {
	        		sector_over_per_28 = Math.round(sector_over_per_28 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_29 = Float.parseFloat(sectorSiteMap.get("over_per_29").toString());
	        	if( sector_over_per_29 > 0 ) {
	        		sector_over_per_29 = Math.round(sector_over_per_29 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_30 = Float.parseFloat(sectorSiteMap.get("over_per_30").toString());
	        	if( sector_over_per_30 > 0 ) {
	        		sector_over_per_30 = Math.round(sector_over_per_30 / nSectorCnt);
	        	}
	        }
	        
	        String chart_sector_val = "";
	        
			chart_sector_val = sector_over_per_30 + "," + sector_over_per_29 + "," + sector_over_per_28 + ","
					+ sector_over_per_27 + "," + sector_over_per_26 + "," + sector_over_per_25 + ","
					+ sector_over_per_24 + "," + sector_over_per_23 + "," + sector_over_per_22 + ","
					+ sector_over_per_21 + "," + sector_over_per_20 + "," + sector_over_per_19 + ","
					+ sector_over_per_18 + "," + sector_over_per_17 + "," + sector_over_per_16 + ","
					+ sector_over_per_15 + "," + sector_over_per_14 + "," + sector_over_per_13 + ","
					+ sector_over_per_12 + "," + sector_over_per_11 + "," + sector_over_per_10 + "," 
					+ sector_over_per_9 + "," + sector_over_per_8 + "," + sector_over_per_7 + "," 
					+ sector_over_per_6 + "," + sector_over_per_5 + "," + sector_over_per_4 + ","
					+ sector_over_per_3 + "," + sector_over_per_2 + "," + sector_over_per_1;	        
	        
	        model.addAttribute("chart_sector_val", chart_sector_val);	
	        
        }else if( "T".equals(modalType) ) {			//팀 탭 선택시
        	
        	//팀별 초과율 목록
			Map<String,Object> teamSiteMap = sqlSession.selectOne("MisRegTmMapper.selectSiteTeam30OverChart", nowVO);
			
			String chart_team_val = "";
			
			chart_team_val = teamSiteMap.get("over_per_30").toString() + ","
					+ teamSiteMap.get("over_per_29").toString() + "," + teamSiteMap.get("over_per_28").toString() + ","
					+ teamSiteMap.get("over_per_27").toString() + "," + teamSiteMap.get("over_per_26").toString() + ","
					+ teamSiteMap.get("over_per_25").toString() + "," + teamSiteMap.get("over_per_24").toString() + ","
					+ teamSiteMap.get("over_per_23").toString() + "," + teamSiteMap.get("over_per_22").toString() + ","
					+ teamSiteMap.get("over_per_21").toString() + "," + teamSiteMap.get("over_per_20").toString() + ","
					+ teamSiteMap.get("over_per_19").toString() + "," + teamSiteMap.get("over_per_18").toString() + ","
					+ teamSiteMap.get("over_per_17").toString() + "," + teamSiteMap.get("over_per_16").toString() + ","
					+ teamSiteMap.get("over_per_15").toString() + "," + teamSiteMap.get("over_per_14").toString() + ","
					+ teamSiteMap.get("over_per_13").toString() + "," + teamSiteMap.get("over_per_12").toString() + ","
					+ teamSiteMap.get("over_per_11").toString() + "," + teamSiteMap.get("over_per_10").toString() + ","
					+ teamSiteMap.get("over_per_9").toString() + "," + teamSiteMap.get("over_per_8").toString() + ","
					+ teamSiteMap.get("over_per_7").toString() + "," + teamSiteMap.get("over_per_6").toString() + ","
					+ teamSiteMap.get("over_per_5").toString() + "," + teamSiteMap.get("over_per_4").toString() + ","
					+ teamSiteMap.get("over_per_3").toString() + "," + teamSiteMap.get("over_per_2").toString() + ","
					+ teamSiteMap.get("over_per_1").toString();			
			
			model.addAttribute("chart_team_val", chart_team_val);
			model.addAttribute("teamSiteMap", teamSiteMap);
			
			//센터 초과율 목록
			String team_center = teamSiteMap.get("team_center").toString();
			
			nowVO.setTeam_center(team_center);
			
			Map<String,Object> centerSiteMap = sqlSession.selectOne("MisRegTmMapper.selectSiteCenter30OverChart", nowVO);
			
			//스케줄러상에 등록되어있는 센터 목록 수를 가져온다.
			int nCenterCnt = sqlSession.selectOne("MisRegTmMapper.selectSiteCenter30OverChartCnt", nowVO);
			
			float center_over_per_1 = 0;
	        float center_over_per_2 = 0;
	        float center_over_per_3 = 0;
	        float center_over_per_4 = 0;
	        float center_over_per_5 = 0;
	        float center_over_per_6 = 0;
	        float center_over_per_7 = 0;
	        float center_over_per_8 = 0;
	        float center_over_per_9 = 0;
	        float center_over_per_10 = 0;
	        float center_over_per_11 = 0;
	        float center_over_per_12 = 0;
	        float center_over_per_13 = 0;
	        float center_over_per_14 = 0;
	        float center_over_per_15 = 0;
	        float center_over_per_16 = 0;
	        float center_over_per_17 = 0;
	        float center_over_per_18 = 0;
	        float center_over_per_19 = 0;
	        float center_over_per_20 = 0;
	        float center_over_per_21 = 0;
	        float center_over_per_22 = 0;
	        float center_over_per_23 = 0;
	        float center_over_per_24 = 0;
	        float center_over_per_25 = 0;
	        float center_over_per_26 = 0;
	        float center_over_per_27 = 0;
	        float center_over_per_28 = 0;
	        float center_over_per_29 = 0;
	        float center_over_per_30 = 0;
	        
	        if( nCenterCnt > 0 ) {
	        	center_over_per_1 = Float.parseFloat(centerSiteMap.get("over_per_1").toString());
	        	if( center_over_per_1 > 0 ) {
	        		center_over_per_1 = Math.round(center_over_per_1 / nCenterCnt);
	        	}
	        	
	        	center_over_per_2 = Float.parseFloat(centerSiteMap.get("over_per_2").toString());
	        	if( center_over_per_2 > 0 ) {
	        		center_over_per_2 = Math.round(center_over_per_2 / nCenterCnt);
	        	}
	        	
	        	center_over_per_3 = Float.parseFloat(centerSiteMap.get("over_per_3").toString());
	        	if( center_over_per_3 > 0 ) {
	        		center_over_per_3 = Math.round(center_over_per_3 / nCenterCnt);
	        	}
	        	
	        	center_over_per_4 = Float.parseFloat(centerSiteMap.get("over_per_4").toString());
	        	if( center_over_per_4 > 0 ) {
	        		center_over_per_4 = Math.round(center_over_per_4 / nCenterCnt);
	        	}
	        	
	        	center_over_per_5 = Float.parseFloat(centerSiteMap.get("over_per_5").toString());
	        	if( center_over_per_5 > 0 ) {
	        		center_over_per_5 = Math.round(center_over_per_5 / nCenterCnt);
	        	}
	        	
	        	center_over_per_6 = Float.parseFloat(centerSiteMap.get("over_per_6").toString());
	        	if( center_over_per_6 > 0 ) {
	        		center_over_per_6 = Math.round(center_over_per_6 / nCenterCnt);
	        	}
	        	
	        	center_over_per_7 = Float.parseFloat(centerSiteMap.get("over_per_7").toString());
	        	if( center_over_per_7 > 0 ) {
	        		center_over_per_7= Math.round(center_over_per_7 / nCenterCnt);
	        	}
	        	
	        	center_over_per_8 = Float.parseFloat(centerSiteMap.get("over_per_8").toString());
	        	if( center_over_per_8 > 0 ) {
	        		center_over_per_8 = Math.round(center_over_per_8 / nCenterCnt);
	        	}
	        	
	        	center_over_per_9 = Float.parseFloat(centerSiteMap.get("over_per_9").toString());
	        	if( center_over_per_9 > 0 ) {
	        		center_over_per_9 = Math.round(center_over_per_9 / nCenterCnt);
	        	}
	        	
	        	center_over_per_10 = Float.parseFloat(centerSiteMap.get("over_per_10").toString());
	        	if( center_over_per_10 > 0 ) {
	        		center_over_per_10 = Math.round(center_over_per_10 / nCenterCnt);
	        	}
	        	
	        	center_over_per_11 = Float.parseFloat(centerSiteMap.get("over_per_11").toString());
	        	if( center_over_per_11 > 0 ) {
	        		center_over_per_11 = Math.round(center_over_per_11 / nCenterCnt);
	        	}
	        	
	        	center_over_per_12 = Float.parseFloat(centerSiteMap.get("over_per_12").toString());
	        	if( center_over_per_12 > 0 ) {
	        		center_over_per_12 = Math.round(center_over_per_12 / nCenterCnt);
	        	}
	        	
	        	center_over_per_13 = Float.parseFloat(centerSiteMap.get("over_per_13").toString());
	        	if( center_over_per_13 > 0 ) {
	        		center_over_per_13 = Math.round(center_over_per_13 / nCenterCnt);
	        	}
	        	
	        	center_over_per_14 = Float.parseFloat(centerSiteMap.get("over_per_14").toString());
	        	if( center_over_per_14 > 0 ) {
	        		center_over_per_14 = Math.round(center_over_per_14 / nCenterCnt);
	        	}
	        	
	        	center_over_per_15 = Float.parseFloat(centerSiteMap.get("over_per_15").toString());
	        	if( center_over_per_15 > 0 ) {
	        		center_over_per_15 = Math.round(center_over_per_15 / nCenterCnt);
	        	}
	        	
	        	center_over_per_16 = Float.parseFloat(centerSiteMap.get("over_per_16").toString());
	        	if( center_over_per_16 > 0 ) {
	        		center_over_per_16 = Math.round(center_over_per_16 / nCenterCnt);
	        	}
	        	
	        	center_over_per_17 = Float.parseFloat(centerSiteMap.get("over_per_17").toString());
	        	if( center_over_per_17 > 0 ) {
	        		center_over_per_17= Math.round(center_over_per_17 / nCenterCnt);
	        	}
	        	
	        	center_over_per_18 = Float.parseFloat(centerSiteMap.get("over_per_18").toString());
	        	if( center_over_per_18 > 0 ) {
	        		center_over_per_18 = Math.round(center_over_per_18 / nCenterCnt);
	        	}
	        	
	        	center_over_per_19 = Float.parseFloat(centerSiteMap.get("over_per_19").toString());
	        	if( center_over_per_19 > 0 ) {
	        		center_over_per_19 = Math.round(center_over_per_19 / nCenterCnt);
	        	}
	        	
	        	center_over_per_20 = Float.parseFloat(centerSiteMap.get("over_per_20").toString());
	        	if( center_over_per_20 > 0 ) {
	        		center_over_per_20 = Math.round(center_over_per_20 / nCenterCnt);
	        	}
	        	
	        	center_over_per_21 = Float.parseFloat(centerSiteMap.get("over_per_21").toString());
	        	if( center_over_per_21 > 0 ) {
	        		center_over_per_21 = Math.round(center_over_per_21 / nCenterCnt);
	        	}
	        	
	        	center_over_per_22 = Float.parseFloat(centerSiteMap.get("over_per_22").toString());
	        	if( center_over_per_22 > 0 ) {
	        		center_over_per_22 = Math.round(center_over_per_22 / nCenterCnt);
	        	}
	        	
	        	center_over_per_23 = Float.parseFloat(centerSiteMap.get("over_per_23").toString());
	        	if( center_over_per_23 > 0 ) {
	        		center_over_per_23 = Math.round(center_over_per_23 / nCenterCnt);
	        	}
	        	
	        	center_over_per_24 = Float.parseFloat(centerSiteMap.get("over_per_24").toString());
	        	if( center_over_per_24 > 0 ) {
	        		center_over_per_24 = Math.round(center_over_per_24 / nCenterCnt);
	        	}
	        	
	        	center_over_per_25 = Float.parseFloat(centerSiteMap.get("over_per_25").toString());
	        	if( center_over_per_25 > 0 ) {
	        		center_over_per_25 = Math.round(center_over_per_25 / nCenterCnt);
	        	}
	        	
	        	center_over_per_26 = Float.parseFloat(centerSiteMap.get("over_per_26").toString());
	        	if( center_over_per_26 > 0 ) {
	        		center_over_per_26 = Math.round(center_over_per_26 / nCenterCnt);
	        	}
	        	
	        	center_over_per_27 = Float.parseFloat(centerSiteMap.get("over_per_27").toString());
	        	if( center_over_per_27 > 0 ) {
	        		center_over_per_27= Math.round(center_over_per_27 / nCenterCnt);
	        	}
	        	
	        	center_over_per_28 = Float.parseFloat(centerSiteMap.get("over_per_28").toString());
	        	if( center_over_per_28 > 0 ) {
	        		center_over_per_28 = Math.round(center_over_per_28 / nCenterCnt);
	        	}
	        	
	        	center_over_per_29 = Float.parseFloat(centerSiteMap.get("over_per_29").toString());
	        	if( center_over_per_29 > 0 ) {
	        		center_over_per_29 = Math.round(center_over_per_29 / nCenterCnt);
	        	}
	        	
	        	center_over_per_30 = Float.parseFloat(centerSiteMap.get("over_per_30").toString());
	        	if( center_over_per_30 > 0 ) {
	        		center_over_per_30 = Math.round(center_over_per_30 / nCenterCnt);
	        	}
	        }
	        
	        String chart_center_val = "";
	        
			chart_center_val = center_over_per_30 + "," + center_over_per_29 + "," + center_over_per_28 + ","
					+ center_over_per_27 + "," + center_over_per_26 + "," + center_over_per_25 + ","
					+ center_over_per_24 + "," + center_over_per_23 + "," + center_over_per_22 + ","
					+ center_over_per_21 + "," + center_over_per_20 + "," + center_over_per_19 + ","
					+ center_over_per_18 + "," + center_over_per_17 + "," + center_over_per_16 + ","
					+ center_over_per_15 + "," + center_over_per_14 + "," + center_over_per_13 + ","
					+ center_over_per_12 + "," + center_over_per_11 + "," + center_over_per_10 + "," 
					+ center_over_per_9 + "," + center_over_per_8 + "," + center_over_per_7 + "," 
					+ center_over_per_6 + "," + center_over_per_5 + "," + center_over_per_4 + ","
					+ center_over_per_3 + "," + center_over_per_2 + "," + center_over_per_1;	        
	        
	        model.addAttribute("chart_center_val", chart_center_val);
			
			//부문 초과율 목록
			String team_sector = teamSiteMap.get("team_sector").toString();
			
			nowVO.setTeam_sector(team_sector);
			
			Map<String,Object> sectorSiteMap = sqlSession.selectOne("MisRegTmMapper.selectSiteSector30OverChart", nowVO);
			
			//스케줄러상에 등록되어있는 부문 목록 수를 가져온다.
			int nSectorCnt = sqlSession.selectOne("MisRegTmMapper.selectSiteSector30OverChartCnt", nowVO);			
			
			float sector_over_per_1 = 0;
	        float sector_over_per_2 = 0;
	        float sector_over_per_3 = 0;
	        float sector_over_per_4 = 0;
	        float sector_over_per_5 = 0;
	        float sector_over_per_6 = 0;
	        float sector_over_per_7 = 0;
	        float sector_over_per_8 = 0;
	        float sector_over_per_9 = 0;
	        float sector_over_per_10 = 0;
	        float sector_over_per_11 = 0;
	        float sector_over_per_12 = 0;
	        float sector_over_per_13 = 0;
	        float sector_over_per_14 = 0;
	        float sector_over_per_15 = 0;
	        float sector_over_per_16 = 0;
	        float sector_over_per_17 = 0;
	        float sector_over_per_18 = 0;
	        float sector_over_per_19 = 0;
	        float sector_over_per_20 = 0;
	        float sector_over_per_21 = 0;
	        float sector_over_per_22 = 0;
	        float sector_over_per_23 = 0;
	        float sector_over_per_24 = 0;
	        float sector_over_per_25 = 0;
	        float sector_over_per_26 = 0;
	        float sector_over_per_27 = 0;
	        float sector_over_per_28 = 0;
	        float sector_over_per_29 = 0;
	        float sector_over_per_30 = 0;
	        
	        if( nSectorCnt > 0 ) {
	        	sector_over_per_1 = Float.parseFloat(sectorSiteMap.get("over_per_1").toString());
	        	if( sector_over_per_1 > 0 ) {
	        		sector_over_per_1 = Math.round(sector_over_per_1 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_2 = Float.parseFloat(sectorSiteMap.get("over_per_2").toString());
	        	if( sector_over_per_2 > 0 ) {
	        		sector_over_per_2 = Math.round(sector_over_per_2 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_3 = Float.parseFloat(sectorSiteMap.get("over_per_3").toString());
	        	if( sector_over_per_3 > 0 ) {
	        		sector_over_per_3 = Math.round(sector_over_per_3 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_4 = Float.parseFloat(sectorSiteMap.get("over_per_4").toString());
	        	if( sector_over_per_4 > 0 ) {
	        		sector_over_per_4 = Math.round(sector_over_per_4 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_5 = Float.parseFloat(sectorSiteMap.get("over_per_5").toString());
	        	if( sector_over_per_5 > 0 ) {
	        		sector_over_per_5 = Math.round(sector_over_per_5 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_6 = Float.parseFloat(sectorSiteMap.get("over_per_6").toString());
	        	if( sector_over_per_6 > 0 ) {
	        		sector_over_per_6 = Math.round(sector_over_per_6 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_7 = Float.parseFloat(sectorSiteMap.get("over_per_7").toString());
	        	if( sector_over_per_7 > 0 ) {
	        		sector_over_per_7= Math.round(sector_over_per_7 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_8 = Float.parseFloat(sectorSiteMap.get("over_per_8").toString());
	        	if( sector_over_per_8 > 0 ) {
	        		sector_over_per_8 = Math.round(sector_over_per_8 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_9 = Float.parseFloat(sectorSiteMap.get("over_per_9").toString());
	        	if( sector_over_per_9 > 0 ) {
	        		sector_over_per_9 = Math.round(sector_over_per_9 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_10 = Float.parseFloat(sectorSiteMap.get("over_per_10").toString());
	        	if( sector_over_per_10 > 0 ) {
	        		sector_over_per_10 = Math.round(sector_over_per_10 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_11 = Float.parseFloat(sectorSiteMap.get("over_per_11").toString());
	        	if( sector_over_per_11 > 0 ) {
	        		sector_over_per_11 = Math.round(sector_over_per_11 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_12 = Float.parseFloat(sectorSiteMap.get("over_per_12").toString());
	        	if( sector_over_per_12 > 0 ) {
	        		sector_over_per_12 = Math.round(sector_over_per_12 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_13 = Float.parseFloat(sectorSiteMap.get("over_per_13").toString());
	        	if( sector_over_per_13 > 0 ) {
	        		sector_over_per_13 = Math.round(sector_over_per_13 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_14 = Float.parseFloat(sectorSiteMap.get("over_per_14").toString());
	        	if( sector_over_per_14 > 0 ) {
	        		sector_over_per_14 = Math.round(sector_over_per_14 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_15 = Float.parseFloat(sectorSiteMap.get("over_per_15").toString());
	        	if( sector_over_per_15 > 0 ) {
	        		sector_over_per_15 = Math.round(sector_over_per_15 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_16 = Float.parseFloat(sectorSiteMap.get("over_per_16").toString());
	        	if( sector_over_per_16 > 0 ) {
	        		sector_over_per_16 = Math.round(sector_over_per_16 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_17 = Float.parseFloat(sectorSiteMap.get("over_per_17").toString());
	        	if( sector_over_per_17 > 0 ) {
	        		sector_over_per_17= Math.round(sector_over_per_17 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_18 = Float.parseFloat(sectorSiteMap.get("over_per_18").toString());
	        	if( sector_over_per_18 > 0 ) {
	        		sector_over_per_18 = Math.round(sector_over_per_18 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_19 = Float.parseFloat(sectorSiteMap.get("over_per_19").toString());
	        	if( sector_over_per_19 > 0 ) {
	        		sector_over_per_19 = Math.round(sector_over_per_19 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_20 = Float.parseFloat(sectorSiteMap.get("over_per_20").toString());
	        	if( sector_over_per_20 > 0 ) {
	        		sector_over_per_20 = Math.round(sector_over_per_20 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_21 = Float.parseFloat(sectorSiteMap.get("over_per_21").toString());
	        	if( sector_over_per_21 > 0 ) {
	        		sector_over_per_21 = Math.round(sector_over_per_21 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_22 = Float.parseFloat(sectorSiteMap.get("over_per_22").toString());
	        	if( sector_over_per_22 > 0 ) {
	        		sector_over_per_22 = Math.round(sector_over_per_22 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_23 = Float.parseFloat(sectorSiteMap.get("over_per_23").toString());
	        	if( sector_over_per_23 > 0 ) {
	        		sector_over_per_23 = Math.round(sector_over_per_23 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_24 = Float.parseFloat(sectorSiteMap.get("over_per_24").toString());
	        	if( sector_over_per_24 > 0 ) {
	        		sector_over_per_24 = Math.round(sector_over_per_24 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_25 = Float.parseFloat(sectorSiteMap.get("over_per_25").toString());
	        	if( sector_over_per_25 > 0 ) {
	        		sector_over_per_25 = Math.round(sector_over_per_25 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_26 = Float.parseFloat(sectorSiteMap.get("over_per_26").toString());
	        	if( sector_over_per_26 > 0 ) {
	        		sector_over_per_26 = Math.round(sector_over_per_26 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_27 = Float.parseFloat(sectorSiteMap.get("over_per_27").toString());
	        	if( sector_over_per_27 > 0 ) {
	        		sector_over_per_27= Math.round(sector_over_per_27 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_28 = Float.parseFloat(sectorSiteMap.get("over_per_28").toString());
	        	if( sector_over_per_28 > 0 ) {
	        		sector_over_per_28 = Math.round(sector_over_per_28 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_29 = Float.parseFloat(sectorSiteMap.get("over_per_29").toString());
	        	if( sector_over_per_29 > 0 ) {
	        		sector_over_per_29 = Math.round(sector_over_per_29 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_30 = Float.parseFloat(sectorSiteMap.get("over_per_30").toString());
	        	if( sector_over_per_30 > 0 ) {
	        		sector_over_per_30 = Math.round(sector_over_per_30 / nSectorCnt);
	        	}
	        }
	        
	        String chart_sector_val = "";
	        
			chart_sector_val = sector_over_per_30 + "," + sector_over_per_29 + "," + sector_over_per_28 + ","
					+ sector_over_per_27 + "," + sector_over_per_26 + "," + sector_over_per_25 + ","
					+ sector_over_per_24 + "," + sector_over_per_23 + "," + sector_over_per_22 + ","
					+ sector_over_per_21 + "," + sector_over_per_20 + "," + sector_over_per_19 + ","
					+ sector_over_per_18 + "," + sector_over_per_17 + "," + sector_over_per_16 + ","
					+ sector_over_per_15 + "," + sector_over_per_14 + "," + sector_over_per_13 + ","
					+ sector_over_per_12 + "," + sector_over_per_11 + "," + sector_over_per_10 + "," 
					+ sector_over_per_9 + "," + sector_over_per_8 + "," + sector_over_per_7 + "," 
					+ sector_over_per_6 + "," + sector_over_per_5 + "," + sector_over_per_4 + ","
					+ sector_over_per_3 + "," + sector_over_per_2 + "," + sector_over_per_1;	        
	        
	        model.addAttribute("chart_sector_val", chart_sector_val);	
        	
        }else if( "C".equals(modalType) ) {			//센터 탭 선택시
        	
        	Map<String,Object> centerSiteMap = sqlSession.selectOne("MisRegTmMapper.selectSiteCenter30OverChart", nowVO);
        	
			//스케줄러상에 등록되어있는 센터 목록 수를 가져온다.
			int nCenterCnt = sqlSession.selectOne("MisRegTmMapper.selectSiteCenter30OverChartCnt", nowVO);
			
			float center_over_per_1 = 0;
	        float center_over_per_2 = 0;
	        float center_over_per_3 = 0;
	        float center_over_per_4 = 0;
	        float center_over_per_5 = 0;
	        float center_over_per_6 = 0;
	        float center_over_per_7 = 0;
	        float center_over_per_8 = 0;
	        float center_over_per_9 = 0;
	        float center_over_per_10 = 0;
	        float center_over_per_11 = 0;
	        float center_over_per_12 = 0;
	        float center_over_per_13 = 0;
	        float center_over_per_14 = 0;
	        float center_over_per_15 = 0;
	        float center_over_per_16 = 0;
	        float center_over_per_17 = 0;
	        float center_over_per_18 = 0;
	        float center_over_per_19 = 0;
	        float center_over_per_20 = 0;
	        float center_over_per_21 = 0;
	        float center_over_per_22 = 0;
	        float center_over_per_23 = 0;
	        float center_over_per_24 = 0;
	        float center_over_per_25 = 0;
	        float center_over_per_26 = 0;
	        float center_over_per_27 = 0;
	        float center_over_per_28 = 0;
	        float center_over_per_29 = 0;
	        float center_over_per_30 = 0;
	        
	        if( nCenterCnt > 0 ) {
	        	center_over_per_1 = Float.parseFloat(centerSiteMap.get("over_per_1").toString());
	        	if( center_over_per_1 > 0 ) {
	        		center_over_per_1 = Math.round(center_over_per_1 / nCenterCnt);
	        	}
	        	
	        	center_over_per_2 = Float.parseFloat(centerSiteMap.get("over_per_2").toString());
	        	if( center_over_per_2 > 0 ) {
	        		center_over_per_2 = Math.round(center_over_per_2 / nCenterCnt);
	        	}
	        	
	        	center_over_per_3 = Float.parseFloat(centerSiteMap.get("over_per_3").toString());
	        	if( center_over_per_3 > 0 ) {
	        		center_over_per_3 = Math.round(center_over_per_3 / nCenterCnt);
	        	}
	        	
	        	center_over_per_4 = Float.parseFloat(centerSiteMap.get("over_per_4").toString());
	        	if( center_over_per_4 > 0 ) {
	        		center_over_per_4 = Math.round(center_over_per_4 / nCenterCnt);
	        	}
	        	
	        	center_over_per_5 = Float.parseFloat(centerSiteMap.get("over_per_5").toString());
	        	if( center_over_per_5 > 0 ) {
	        		center_over_per_5 = Math.round(center_over_per_5 / nCenterCnt);
	        	}
	        	
	        	center_over_per_6 = Float.parseFloat(centerSiteMap.get("over_per_6").toString());
	        	if( center_over_per_6 > 0 ) {
	        		center_over_per_6 = Math.round(center_over_per_6 / nCenterCnt);
	        	}
	        	
	        	center_over_per_7 = Float.parseFloat(centerSiteMap.get("over_per_7").toString());
	        	if( center_over_per_7 > 0 ) {
	        		center_over_per_7= Math.round(center_over_per_7 / nCenterCnt);
	        	}
	        	
	        	center_over_per_8 = Float.parseFloat(centerSiteMap.get("over_per_8").toString());
	        	if( center_over_per_8 > 0 ) {
	        		center_over_per_8 = Math.round(center_over_per_8 / nCenterCnt);
	        	}
	        	
	        	center_over_per_9 = Float.parseFloat(centerSiteMap.get("over_per_9").toString());
	        	if( center_over_per_9 > 0 ) {
	        		center_over_per_9 = Math.round(center_over_per_9 / nCenterCnt);
	        	}
	        	
	        	center_over_per_10 = Float.parseFloat(centerSiteMap.get("over_per_10").toString());
	        	if( center_over_per_10 > 0 ) {
	        		center_over_per_10 = Math.round(center_over_per_10 / nCenterCnt);
	        	}
	        	
	        	center_over_per_11 = Float.parseFloat(centerSiteMap.get("over_per_11").toString());
	        	if( center_over_per_11 > 0 ) {
	        		center_over_per_11 = Math.round(center_over_per_11 / nCenterCnt);
	        	}
	        	
	        	center_over_per_12 = Float.parseFloat(centerSiteMap.get("over_per_12").toString());
	        	if( center_over_per_12 > 0 ) {
	        		center_over_per_12 = Math.round(center_over_per_12 / nCenterCnt);
	        	}
	        	
	        	center_over_per_13 = Float.parseFloat(centerSiteMap.get("over_per_13").toString());
	        	if( center_over_per_13 > 0 ) {
	        		center_over_per_13 = Math.round(center_over_per_13 / nCenterCnt);
	        	}
	        	
	        	center_over_per_14 = Float.parseFloat(centerSiteMap.get("over_per_14").toString());
	        	if( center_over_per_14 > 0 ) {
	        		center_over_per_14 = Math.round(center_over_per_14 / nCenterCnt);
	        	}
	        	
	        	center_over_per_15 = Float.parseFloat(centerSiteMap.get("over_per_15").toString());
	        	if( center_over_per_15 > 0 ) {
	        		center_over_per_15 = Math.round(center_over_per_15 / nCenterCnt);
	        	}
	        	
	        	center_over_per_16 = Float.parseFloat(centerSiteMap.get("over_per_16").toString());
	        	if( center_over_per_16 > 0 ) {
	        		center_over_per_16 = Math.round(center_over_per_16 / nCenterCnt);
	        	}
	        	
	        	center_over_per_17 = Float.parseFloat(centerSiteMap.get("over_per_17").toString());
	        	if( center_over_per_17 > 0 ) {
	        		center_over_per_17= Math.round(center_over_per_17 / nCenterCnt);
	        	}
	        	
	        	center_over_per_18 = Float.parseFloat(centerSiteMap.get("over_per_18").toString());
	        	if( center_over_per_18 > 0 ) {
	        		center_over_per_18 = Math.round(center_over_per_18 / nCenterCnt);
	        	}
	        	
	        	center_over_per_19 = Float.parseFloat(centerSiteMap.get("over_per_19").toString());
	        	if( center_over_per_19 > 0 ) {
	        		center_over_per_19 = Math.round(center_over_per_19 / nCenterCnt);
	        	}
	        	
	        	center_over_per_20 = Float.parseFloat(centerSiteMap.get("over_per_20").toString());
	        	if( center_over_per_20 > 0 ) {
	        		center_over_per_20 = Math.round(center_over_per_20 / nCenterCnt);
	        	}
	        	
	        	center_over_per_21 = Float.parseFloat(centerSiteMap.get("over_per_21").toString());
	        	if( center_over_per_21 > 0 ) {
	        		center_over_per_21 = Math.round(center_over_per_21 / nCenterCnt);
	        	}
	        	
	        	center_over_per_22 = Float.parseFloat(centerSiteMap.get("over_per_22").toString());
	        	if( center_over_per_22 > 0 ) {
	        		center_over_per_22 = Math.round(center_over_per_22 / nCenterCnt);
	        	}
	        	
	        	center_over_per_23 = Float.parseFloat(centerSiteMap.get("over_per_23").toString());
	        	if( center_over_per_23 > 0 ) {
	        		center_over_per_23 = Math.round(center_over_per_23 / nCenterCnt);
	        	}
	        	
	        	center_over_per_24 = Float.parseFloat(centerSiteMap.get("over_per_24").toString());
	        	if( center_over_per_24 > 0 ) {
	        		center_over_per_24 = Math.round(center_over_per_24 / nCenterCnt);
	        	}
	        	
	        	center_over_per_25 = Float.parseFloat(centerSiteMap.get("over_per_25").toString());
	        	if( center_over_per_25 > 0 ) {
	        		center_over_per_25 = Math.round(center_over_per_25 / nCenterCnt);
	        	}
	        	
	        	center_over_per_26 = Float.parseFloat(centerSiteMap.get("over_per_26").toString());
	        	if( center_over_per_26 > 0 ) {
	        		center_over_per_26 = Math.round(center_over_per_26 / nCenterCnt);
	        	}
	        	
	        	center_over_per_27 = Float.parseFloat(centerSiteMap.get("over_per_27").toString());
	        	if( center_over_per_27 > 0 ) {
	        		center_over_per_27= Math.round(center_over_per_27 / nCenterCnt);
	        	}
	        	
	        	center_over_per_28 = Float.parseFloat(centerSiteMap.get("over_per_28").toString());
	        	if( center_over_per_28 > 0 ) {
	        		center_over_per_28 = Math.round(center_over_per_28 / nCenterCnt);
	        	}
	        	
	        	center_over_per_29 = Float.parseFloat(centerSiteMap.get("over_per_29").toString());
	        	if( center_over_per_29 > 0 ) {
	        		center_over_per_29 = Math.round(center_over_per_29 / nCenterCnt);
	        	}
	        	
	        	center_over_per_30 = Float.parseFloat(centerSiteMap.get("over_per_30").toString());
	        	if( center_over_per_30 > 0 ) {
	        		center_over_per_30 = Math.round(center_over_per_30 / nCenterCnt);
	        	}
	        }
	        
	        String chart_center_val = "";
	        
			chart_center_val = center_over_per_30 + "," + center_over_per_29 + "," + center_over_per_28 + ","
					+ center_over_per_27 + "," + center_over_per_26 + "," + center_over_per_25 + ","
					+ center_over_per_24 + "," + center_over_per_23 + "," + center_over_per_22 + ","
					+ center_over_per_21 + "," + center_over_per_20 + "," + center_over_per_19 + ","
					+ center_over_per_18 + "," + center_over_per_17 + "," + center_over_per_16 + ","
					+ center_over_per_15 + "," + center_over_per_14 + "," + center_over_per_13 + ","
					+ center_over_per_12 + "," + center_over_per_11 + "," + center_over_per_10 + "," 
					+ center_over_per_9 + "," + center_over_per_8 + "," + center_over_per_7 + "," 
					+ center_over_per_6 + "," + center_over_per_5 + "," + center_over_per_4 + ","
					+ center_over_per_3 + "," + center_over_per_2 + "," + center_over_per_1;	        
	        
	        model.addAttribute("chart_center_val", chart_center_val);
			
			//부문 초과율 목록
	        String team_sector = centerSiteMap.get("team_sector").toString();
			
			nowVO.setTeam_sector(team_sector);
			
			Map<String,Object> sectorSiteMap = sqlSession.selectOne("MisRegTmMapper.selectSiteSector30OverChart", nowVO);
			
			//스케줄러상에 등록되어있는 부문 목록 수를 가져온다.
			int nSectorCnt = sqlSession.selectOne("MisRegTmMapper.selectSiteSector30OverChartCnt", nowVO);			
			
			float sector_over_per_1 = 0;
	        float sector_over_per_2 = 0;
	        float sector_over_per_3 = 0;
	        float sector_over_per_4 = 0;
	        float sector_over_per_5 = 0;
	        float sector_over_per_6 = 0;
	        float sector_over_per_7 = 0;
	        float sector_over_per_8 = 0;
	        float sector_over_per_9 = 0;
	        float sector_over_per_10 = 0;
	        float sector_over_per_11 = 0;
	        float sector_over_per_12 = 0;
	        float sector_over_per_13 = 0;
	        float sector_over_per_14 = 0;
	        float sector_over_per_15 = 0;
	        float sector_over_per_16 = 0;
	        float sector_over_per_17 = 0;
	        float sector_over_per_18 = 0;
	        float sector_over_per_19 = 0;
	        float sector_over_per_20 = 0;
	        float sector_over_per_21 = 0;
	        float sector_over_per_22 = 0;
	        float sector_over_per_23 = 0;
	        float sector_over_per_24 = 0;
	        float sector_over_per_25 = 0;
	        float sector_over_per_26 = 0;
	        float sector_over_per_27 = 0;
	        float sector_over_per_28 = 0;
	        float sector_over_per_29 = 0;
	        float sector_over_per_30 = 0;
	        
	        if( nSectorCnt > 0 ) {
	        	sector_over_per_1 = Float.parseFloat(sectorSiteMap.get("over_per_1").toString());
	        	if( sector_over_per_1 > 0 ) {
	        		sector_over_per_1 = Math.round(sector_over_per_1 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_2 = Float.parseFloat(sectorSiteMap.get("over_per_2").toString());
	        	if( sector_over_per_2 > 0 ) {
	        		sector_over_per_2 = Math.round(sector_over_per_2 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_3 = Float.parseFloat(sectorSiteMap.get("over_per_3").toString());
	        	if( sector_over_per_3 > 0 ) {
	        		sector_over_per_3 = Math.round(sector_over_per_3 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_4 = Float.parseFloat(sectorSiteMap.get("over_per_4").toString());
	        	if( sector_over_per_4 > 0 ) {
	        		sector_over_per_4 = Math.round(sector_over_per_4 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_5 = Float.parseFloat(sectorSiteMap.get("over_per_5").toString());
	        	if( sector_over_per_5 > 0 ) {
	        		sector_over_per_5 = Math.round(sector_over_per_5 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_6 = Float.parseFloat(sectorSiteMap.get("over_per_6").toString());
	        	if( sector_over_per_6 > 0 ) {
	        		sector_over_per_6 = Math.round(sector_over_per_6 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_7 = Float.parseFloat(sectorSiteMap.get("over_per_7").toString());
	        	if( sector_over_per_7 > 0 ) {
	        		sector_over_per_7= Math.round(sector_over_per_7 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_8 = Float.parseFloat(sectorSiteMap.get("over_per_8").toString());
	        	if( sector_over_per_8 > 0 ) {
	        		sector_over_per_8 = Math.round(sector_over_per_8 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_9 = Float.parseFloat(sectorSiteMap.get("over_per_9").toString());
	        	if( sector_over_per_9 > 0 ) {
	        		sector_over_per_9 = Math.round(sector_over_per_9 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_10 = Float.parseFloat(sectorSiteMap.get("over_per_10").toString());
	        	if( sector_over_per_10 > 0 ) {
	        		sector_over_per_10 = Math.round(sector_over_per_10 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_11 = Float.parseFloat(sectorSiteMap.get("over_per_11").toString());
	        	if( sector_over_per_11 > 0 ) {
	        		sector_over_per_11 = Math.round(sector_over_per_11 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_12 = Float.parseFloat(sectorSiteMap.get("over_per_12").toString());
	        	if( sector_over_per_12 > 0 ) {
	        		sector_over_per_12 = Math.round(sector_over_per_12 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_13 = Float.parseFloat(sectorSiteMap.get("over_per_13").toString());
	        	if( sector_over_per_13 > 0 ) {
	        		sector_over_per_13 = Math.round(sector_over_per_13 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_14 = Float.parseFloat(sectorSiteMap.get("over_per_14").toString());
	        	if( sector_over_per_14 > 0 ) {
	        		sector_over_per_14 = Math.round(sector_over_per_14 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_15 = Float.parseFloat(sectorSiteMap.get("over_per_15").toString());
	        	if( sector_over_per_15 > 0 ) {
	        		sector_over_per_15 = Math.round(sector_over_per_15 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_16 = Float.parseFloat(sectorSiteMap.get("over_per_16").toString());
	        	if( sector_over_per_16 > 0 ) {
	        		sector_over_per_16 = Math.round(sector_over_per_16 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_17 = Float.parseFloat(sectorSiteMap.get("over_per_17").toString());
	        	if( sector_over_per_17 > 0 ) {
	        		sector_over_per_17= Math.round(sector_over_per_17 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_18 = Float.parseFloat(sectorSiteMap.get("over_per_18").toString());
	        	if( sector_over_per_18 > 0 ) {
	        		sector_over_per_18 = Math.round(sector_over_per_18 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_19 = Float.parseFloat(sectorSiteMap.get("over_per_19").toString());
	        	if( sector_over_per_19 > 0 ) {
	        		sector_over_per_19 = Math.round(sector_over_per_19 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_20 = Float.parseFloat(sectorSiteMap.get("over_per_20").toString());
	        	if( sector_over_per_20 > 0 ) {
	        		sector_over_per_20 = Math.round(sector_over_per_20 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_21 = Float.parseFloat(sectorSiteMap.get("over_per_21").toString());
	        	if( sector_over_per_21 > 0 ) {
	        		sector_over_per_21 = Math.round(sector_over_per_21 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_22 = Float.parseFloat(sectorSiteMap.get("over_per_22").toString());
	        	if( sector_over_per_22 > 0 ) {
	        		sector_over_per_22 = Math.round(sector_over_per_22 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_23 = Float.parseFloat(sectorSiteMap.get("over_per_23").toString());
	        	if( sector_over_per_23 > 0 ) {
	        		sector_over_per_23 = Math.round(sector_over_per_23 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_24 = Float.parseFloat(sectorSiteMap.get("over_per_24").toString());
	        	if( sector_over_per_24 > 0 ) {
	        		sector_over_per_24 = Math.round(sector_over_per_24 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_25 = Float.parseFloat(sectorSiteMap.get("over_per_25").toString());
	        	if( sector_over_per_25 > 0 ) {
	        		sector_over_per_25 = Math.round(sector_over_per_25 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_26 = Float.parseFloat(sectorSiteMap.get("over_per_26").toString());
	        	if( sector_over_per_26 > 0 ) {
	        		sector_over_per_26 = Math.round(sector_over_per_26 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_27 = Float.parseFloat(sectorSiteMap.get("over_per_27").toString());
	        	if( sector_over_per_27 > 0 ) {
	        		sector_over_per_27= Math.round(sector_over_per_27 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_28 = Float.parseFloat(sectorSiteMap.get("over_per_28").toString());
	        	if( sector_over_per_28 > 0 ) {
	        		sector_over_per_28 = Math.round(sector_over_per_28 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_29 = Float.parseFloat(sectorSiteMap.get("over_per_29").toString());
	        	if( sector_over_per_29 > 0 ) {
	        		sector_over_per_29 = Math.round(sector_over_per_29 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_30 = Float.parseFloat(sectorSiteMap.get("over_per_30").toString());
	        	if( sector_over_per_30 > 0 ) {
	        		sector_over_per_30 = Math.round(sector_over_per_30 / nSectorCnt);
	        	}
	        	
	        	model.addAttribute("centerSiteMap", centerSiteMap);
	        }
	        
	        String chart_sector_val = "";
	        
			chart_sector_val = sector_over_per_30 + "," + sector_over_per_29 + "," + sector_over_per_28 + ","
					+ sector_over_per_27 + "," + sector_over_per_26 + "," + sector_over_per_25 + ","
					+ sector_over_per_24 + "," + sector_over_per_23 + "," + sector_over_per_22 + ","
					+ sector_over_per_21 + "," + sector_over_per_20 + "," + sector_over_per_19 + ","
					+ sector_over_per_18 + "," + sector_over_per_17 + "," + sector_over_per_16 + ","
					+ sector_over_per_15 + "," + sector_over_per_14 + "," + sector_over_per_13 + ","
					+ sector_over_per_12 + "," + sector_over_per_11 + "," + sector_over_per_10 + "," 
					+ sector_over_per_9 + "," + sector_over_per_8 + "," + sector_over_per_7 + "," 
					+ sector_over_per_6 + "," + sector_over_per_5 + "," + sector_over_per_4 + ","
					+ sector_over_per_3 + "," + sector_over_per_2 + "," + sector_over_per_1;	        
	        
	        model.addAttribute("chart_sector_val", chart_sector_val);
	        
        }else if( "S".equals(modalType) ) {		//부문 탬 선택시
			
			Map<String,Object> sectorSiteMap = sqlSession.selectOne("MisRegTmMapper.selectSiteSector30OverChart", nowVO);
			
			//스케줄러상에 등록되어있는 부문 목록 수를 가져온다.
			int nSectorCnt = sqlSession.selectOne("MisRegTmMapper.selectSiteSector30OverChartCnt", nowVO);			
			
			float sector_over_per_1 = 0;
	        float sector_over_per_2 = 0;
	        float sector_over_per_3 = 0;
	        float sector_over_per_4 = 0;
	        float sector_over_per_5 = 0;
	        float sector_over_per_6 = 0;
	        float sector_over_per_7 = 0;
	        float sector_over_per_8 = 0;
	        float sector_over_per_9 = 0;
	        float sector_over_per_10 = 0;
	        float sector_over_per_11 = 0;
	        float sector_over_per_12 = 0;
	        float sector_over_per_13 = 0;
	        float sector_over_per_14 = 0;
	        float sector_over_per_15 = 0;
	        float sector_over_per_16 = 0;
	        float sector_over_per_17 = 0;
	        float sector_over_per_18 = 0;
	        float sector_over_per_19 = 0;
	        float sector_over_per_20 = 0;
	        float sector_over_per_21 = 0;
	        float sector_over_per_22 = 0;
	        float sector_over_per_23 = 0;
	        float sector_over_per_24 = 0;
	        float sector_over_per_25 = 0;
	        float sector_over_per_26 = 0;
	        float sector_over_per_27 = 0;
	        float sector_over_per_28 = 0;
	        float sector_over_per_29 = 0;
	        float sector_over_per_30 = 0;
	        
	        if( nSectorCnt > 0 ) {
	        	sector_over_per_1 = Float.parseFloat(sectorSiteMap.get("over_per_1").toString());
	        	if( sector_over_per_1 > 0 ) {
	        		sector_over_per_1 = Math.round(sector_over_per_1 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_2 = Float.parseFloat(sectorSiteMap.get("over_per_2").toString());
	        	if( sector_over_per_2 > 0 ) {
	        		sector_over_per_2 = Math.round(sector_over_per_2 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_3 = Float.parseFloat(sectorSiteMap.get("over_per_3").toString());
	        	if( sector_over_per_3 > 0 ) {
	        		sector_over_per_3 = Math.round(sector_over_per_3 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_4 = Float.parseFloat(sectorSiteMap.get("over_per_4").toString());
	        	if( sector_over_per_4 > 0 ) {
	        		sector_over_per_4 = Math.round(sector_over_per_4 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_5 = Float.parseFloat(sectorSiteMap.get("over_per_5").toString());
	        	if( sector_over_per_5 > 0 ) {
	        		sector_over_per_5 = Math.round(sector_over_per_5 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_6 = Float.parseFloat(sectorSiteMap.get("over_per_6").toString());
	        	if( sector_over_per_6 > 0 ) {
	        		sector_over_per_6 = Math.round(sector_over_per_6 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_7 = Float.parseFloat(sectorSiteMap.get("over_per_7").toString());
	        	if( sector_over_per_7 > 0 ) {
	        		sector_over_per_7= Math.round(sector_over_per_7 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_8 = Float.parseFloat(sectorSiteMap.get("over_per_8").toString());
	        	if( sector_over_per_8 > 0 ) {
	        		sector_over_per_8 = Math.round(sector_over_per_8 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_9 = Float.parseFloat(sectorSiteMap.get("over_per_9").toString());
	        	if( sector_over_per_9 > 0 ) {
	        		sector_over_per_9 = Math.round(sector_over_per_9 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_10 = Float.parseFloat(sectorSiteMap.get("over_per_10").toString());
	        	if( sector_over_per_10 > 0 ) {
	        		sector_over_per_10 = Math.round(sector_over_per_10 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_11 = Float.parseFloat(sectorSiteMap.get("over_per_11").toString());
	        	if( sector_over_per_11 > 0 ) {
	        		sector_over_per_11 = Math.round(sector_over_per_11 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_12 = Float.parseFloat(sectorSiteMap.get("over_per_12").toString());
	        	if( sector_over_per_12 > 0 ) {
	        		sector_over_per_12 = Math.round(sector_over_per_12 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_13 = Float.parseFloat(sectorSiteMap.get("over_per_13").toString());
	        	if( sector_over_per_13 > 0 ) {
	        		sector_over_per_13 = Math.round(sector_over_per_13 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_14 = Float.parseFloat(sectorSiteMap.get("over_per_14").toString());
	        	if( sector_over_per_14 > 0 ) {
	        		sector_over_per_14 = Math.round(sector_over_per_14 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_15 = Float.parseFloat(sectorSiteMap.get("over_per_15").toString());
	        	if( sector_over_per_15 > 0 ) {
	        		sector_over_per_15 = Math.round(sector_over_per_15 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_16 = Float.parseFloat(sectorSiteMap.get("over_per_16").toString());
	        	if( sector_over_per_16 > 0 ) {
	        		sector_over_per_16 = Math.round(sector_over_per_16 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_17 = Float.parseFloat(sectorSiteMap.get("over_per_17").toString());
	        	if( sector_over_per_17 > 0 ) {
	        		sector_over_per_17= Math.round(sector_over_per_17 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_18 = Float.parseFloat(sectorSiteMap.get("over_per_18").toString());
	        	if( sector_over_per_18 > 0 ) {
	        		sector_over_per_18 = Math.round(sector_over_per_18 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_19 = Float.parseFloat(sectorSiteMap.get("over_per_19").toString());
	        	if( sector_over_per_19 > 0 ) {
	        		sector_over_per_19 = Math.round(sector_over_per_19 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_20 = Float.parseFloat(sectorSiteMap.get("over_per_20").toString());
	        	if( sector_over_per_20 > 0 ) {
	        		sector_over_per_20 = Math.round(sector_over_per_20 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_21 = Float.parseFloat(sectorSiteMap.get("over_per_21").toString());
	        	if( sector_over_per_21 > 0 ) {
	        		sector_over_per_21 = Math.round(sector_over_per_21 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_22 = Float.parseFloat(sectorSiteMap.get("over_per_22").toString());
	        	if( sector_over_per_22 > 0 ) {
	        		sector_over_per_22 = Math.round(sector_over_per_22 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_23 = Float.parseFloat(sectorSiteMap.get("over_per_23").toString());
	        	if( sector_over_per_23 > 0 ) {
	        		sector_over_per_23 = Math.round(sector_over_per_23 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_24 = Float.parseFloat(sectorSiteMap.get("over_per_24").toString());
	        	if( sector_over_per_24 > 0 ) {
	        		sector_over_per_24 = Math.round(sector_over_per_24 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_25 = Float.parseFloat(sectorSiteMap.get("over_per_25").toString());
	        	if( sector_over_per_25 > 0 ) {
	        		sector_over_per_25 = Math.round(sector_over_per_25 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_26 = Float.parseFloat(sectorSiteMap.get("over_per_26").toString());
	        	if( sector_over_per_26 > 0 ) {
	        		sector_over_per_26 = Math.round(sector_over_per_26 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_27 = Float.parseFloat(sectorSiteMap.get("over_per_27").toString());
	        	if( sector_over_per_27 > 0 ) {
	        		sector_over_per_27= Math.round(sector_over_per_27 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_28 = Float.parseFloat(sectorSiteMap.get("over_per_28").toString());
	        	if( sector_over_per_28 > 0 ) {
	        		sector_over_per_28 = Math.round(sector_over_per_28 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_29 = Float.parseFloat(sectorSiteMap.get("over_per_29").toString());
	        	if( sector_over_per_29 > 0 ) {
	        		sector_over_per_29 = Math.round(sector_over_per_29 / nSectorCnt);
	        	}
	        	
	        	sector_over_per_30 = Float.parseFloat(sectorSiteMap.get("over_per_30").toString());
	        	if( sector_over_per_30 > 0 ) {
	        		sector_over_per_30 = Math.round(sector_over_per_30 / nSectorCnt);
	        	}
	        	
	        	model.addAttribute("sectorSiteMap", sectorSiteMap);
	        }
	        
	        String chart_sector_val = "";
	        
			chart_sector_val = sector_over_per_30 + "," + sector_over_per_29 + "," + sector_over_per_28 + ","
					+ sector_over_per_27 + "," + sector_over_per_26 + "," + sector_over_per_25 + ","
					+ sector_over_per_24 + "," + sector_over_per_23 + "," + sector_over_per_22 + ","
					+ sector_over_per_21 + "," + sector_over_per_20 + "," + sector_over_per_19 + ","
					+ sector_over_per_18 + "," + sector_over_per_17 + "," + sector_over_per_16 + ","
					+ sector_over_per_15 + "," + sector_over_per_14 + "," + sector_over_per_13 + ","
					+ sector_over_per_12 + "," + sector_over_per_11 + "," + sector_over_per_10 + "," 
					+ sector_over_per_9 + "," + sector_over_per_8 + "," + sector_over_per_7 + "," 
					+ sector_over_per_6 + "," + sector_over_per_5 + "," + sector_over_per_4 + ","
					+ sector_over_per_3 + "," + sector_over_per_2 + "," + sector_over_per_1;	        
	        
	        model.addAttribute("chart_sector_val", chart_sector_val);        	
        }
        
        //전체(전직원) 현장보고서 평균시작
        Map<String,Object> allSiteMap = sqlSession.selectOne("MisRegTmMapper.selectSiteAll30OverChart", nowVO);
        
        //스케줄러상에 등록되어있는 직원의 목록 수를 가져온다.
		int nAllCnt = sqlSession.selectOne("MisRegTmMapper.selectSiteAll30OverChartCnt", nowVO);
		
		float all_over_per_1 = 0;
        float all_over_per_2 = 0;
        float all_over_per_3 = 0;
        float all_over_per_4 = 0;
        float all_over_per_5 = 0;
        float all_over_per_6 = 0;
        float all_over_per_7 = 0;
        float all_over_per_8 = 0;
        float all_over_per_9 = 0;
        float all_over_per_10 = 0;
        float all_over_per_11 = 0;
        float all_over_per_12 = 0;
        float all_over_per_13 = 0;
        float all_over_per_14 = 0;
        float all_over_per_15 = 0;
        float all_over_per_16 = 0;
        float all_over_per_17 = 0;
        float all_over_per_18 = 0;
        float all_over_per_19 = 0;
        float all_over_per_20 = 0;
        float all_over_per_21 = 0;
        float all_over_per_22 = 0;
        float all_over_per_23 = 0;
        float all_over_per_24 = 0;
        float all_over_per_25 = 0;
        float all_over_per_26 = 0;
        float all_over_per_27 = 0;
        float all_over_per_28 = 0;
        float all_over_per_29 = 0;
        float all_over_per_30 = 0;
        
        if( nAllCnt > 0 ) {
        	all_over_per_1 = Float.parseFloat(allSiteMap.get("over_per_1").toString());
        	if( all_over_per_1 > 0 ) {
        		all_over_per_1 = Math.round(all_over_per_1 / nAllCnt);
        	}
        	
        	all_over_per_2 = Float.parseFloat(allSiteMap.get("over_per_2").toString());
        	if( all_over_per_2 > 0 ) {
        		all_over_per_2 = Math.round(all_over_per_2 / nAllCnt);
        	}
        	
        	all_over_per_3 = Float.parseFloat(allSiteMap.get("over_per_3").toString());
        	if( all_over_per_3 > 0 ) {
        		all_over_per_3 = Math.round(all_over_per_3 / nAllCnt);
        	}
        	
        	all_over_per_4 = Float.parseFloat(allSiteMap.get("over_per_4").toString());
        	if( all_over_per_4 > 0 ) {
        		all_over_per_4 = Math.round(all_over_per_4 / nAllCnt);
        	}
        	
        	all_over_per_5 = Float.parseFloat(allSiteMap.get("over_per_5").toString());
        	if( all_over_per_5 > 0 ) {
        		all_over_per_5 = Math.round(all_over_per_5 / nAllCnt);
        	}
        	
        	all_over_per_6 = Float.parseFloat(allSiteMap.get("over_per_6").toString());
        	if( all_over_per_6 > 0 ) {
        		all_over_per_6 = Math.round(all_over_per_6 / nAllCnt);
        	}
        	
        	all_over_per_7 = Float.parseFloat(allSiteMap.get("over_per_7").toString());
        	if( all_over_per_7 > 0 ) {
        		all_over_per_7= Math.round(all_over_per_7 / nAllCnt);
        	}
        	
        	all_over_per_8 = Float.parseFloat(allSiteMap.get("over_per_8").toString());
        	if( all_over_per_8 > 0 ) {
        		all_over_per_8 = Math.round(all_over_per_8 / nAllCnt);
        	}
        	
        	all_over_per_9 = Float.parseFloat(allSiteMap.get("over_per_9").toString());
        	if( all_over_per_9 > 0 ) {
        		all_over_per_9 = Math.round(all_over_per_9 / nAllCnt);
        	}
        	
        	all_over_per_10 = Float.parseFloat(allSiteMap.get("over_per_10").toString());
        	if( all_over_per_10 > 0 ) {
        		all_over_per_10 = Math.round(all_over_per_10 / nAllCnt);
        	}
        	
        	all_over_per_11 = Float.parseFloat(allSiteMap.get("over_per_11").toString());
        	if( all_over_per_11 > 0 ) {
        		all_over_per_11 = Math.round(all_over_per_11 / nAllCnt);
        	}
        	
        	all_over_per_12 = Float.parseFloat(allSiteMap.get("over_per_12").toString());
        	if( all_over_per_12 > 0 ) {
        		all_over_per_12 = Math.round(all_over_per_12 / nAllCnt);
        	}
        	
        	all_over_per_13 = Float.parseFloat(allSiteMap.get("over_per_13").toString());
        	if( all_over_per_13 > 0 ) {
        		all_over_per_13 = Math.round(all_over_per_13 / nAllCnt);
        	}
        	
        	all_over_per_14 = Float.parseFloat(allSiteMap.get("over_per_14").toString());
        	if( all_over_per_14 > 0 ) {
        		all_over_per_14 = Math.round(all_over_per_14 / nAllCnt);
        	}
        	
        	all_over_per_15 = Float.parseFloat(allSiteMap.get("over_per_15").toString());
        	if( all_over_per_15 > 0 ) {
        		all_over_per_15 = Math.round(all_over_per_15 / nAllCnt);
        	}
        	
        	all_over_per_16 = Float.parseFloat(allSiteMap.get("over_per_16").toString());
        	if( all_over_per_16 > 0 ) {
        		all_over_per_16 = Math.round(all_over_per_16 / nAllCnt);
        	}
        	
        	all_over_per_17 = Float.parseFloat(allSiteMap.get("over_per_17").toString());
        	if( all_over_per_17 > 0 ) {
        		all_over_per_17= Math.round(all_over_per_17 / nAllCnt);
        	}
        	
        	all_over_per_18 = Float.parseFloat(allSiteMap.get("over_per_18").toString());
        	if( all_over_per_18 > 0 ) {
        		all_over_per_18 = Math.round(all_over_per_18 / nAllCnt);
        	}
        	
        	all_over_per_19 = Float.parseFloat(allSiteMap.get("over_per_19").toString());
        	if( all_over_per_19 > 0 ) {
        		all_over_per_19 = Math.round(all_over_per_19 / nAllCnt);
        	}
        	
        	all_over_per_20 = Float.parseFloat(allSiteMap.get("over_per_20").toString());
        	if( all_over_per_20 > 0 ) {
        		all_over_per_20 = Math.round(all_over_per_20 / nAllCnt);
        	}
        	
        	all_over_per_21 = Float.parseFloat(allSiteMap.get("over_per_21").toString());
        	if( all_over_per_21 > 0 ) {
        		all_over_per_21 = Math.round(all_over_per_21 / nAllCnt);
        	}
        	
        	all_over_per_22 = Float.parseFloat(allSiteMap.get("over_per_22").toString());
        	if( all_over_per_22 > 0 ) {
        		all_over_per_22 = Math.round(all_over_per_22 / nAllCnt);
        	}
        	
        	all_over_per_23 = Float.parseFloat(allSiteMap.get("over_per_23").toString());
        	if( all_over_per_23 > 0 ) {
        		all_over_per_23 = Math.round(all_over_per_23 / nAllCnt);
        	}
        	
        	all_over_per_24 = Float.parseFloat(allSiteMap.get("over_per_24").toString());
        	if( all_over_per_24 > 0 ) {
        		all_over_per_24 = Math.round(all_over_per_24 / nAllCnt);
        	}
        	
        	all_over_per_25 = Float.parseFloat(allSiteMap.get("over_per_25").toString());
        	if( all_over_per_25 > 0 ) {
        		all_over_per_25 = Math.round(all_over_per_25 / nAllCnt);
        	}
        	
        	all_over_per_26 = Float.parseFloat(allSiteMap.get("over_per_26").toString());
        	if( all_over_per_26 > 0 ) {
        		all_over_per_26 = Math.round(all_over_per_26 / nAllCnt);
        	}
        	
        	all_over_per_27 = Float.parseFloat(allSiteMap.get("over_per_27").toString());
        	if( all_over_per_27 > 0 ) {
        		all_over_per_27= Math.round(all_over_per_27 / nAllCnt);
        	}
        	
        	all_over_per_28 = Float.parseFloat(allSiteMap.get("over_per_28").toString());
        	if( all_over_per_28 > 0 ) {
        		all_over_per_28 = Math.round(all_over_per_28 / nAllCnt);
        	}
        	
        	all_over_per_29 = Float.parseFloat(allSiteMap.get("over_per_29").toString());
        	if( all_over_per_29 > 0 ) {
        		all_over_per_29 = Math.round(all_over_per_29 / nAllCnt);
        	}
        	
        	all_over_per_30 = Float.parseFloat(allSiteMap.get("over_per_30").toString());
        	if( all_over_per_30 > 0 ) {
        		all_over_per_30 = Math.round(all_over_per_30 / nAllCnt);
        	}
        	
        }
        
        String chart_all_val = "";
        
		chart_all_val = all_over_per_30 + "," + all_over_per_29 + "," + all_over_per_28 + ","
				+ all_over_per_27 + "," + all_over_per_26 + "," + all_over_per_25 + ","
				+ all_over_per_24 + "," + all_over_per_23 + "," + all_over_per_22 + ","
				+ all_over_per_21 + "," + all_over_per_20 + "," + all_over_per_19 + ","
				+ all_over_per_18 + "," + all_over_per_17 + "," + all_over_per_16 + ","
				+ all_over_per_15 + "," + all_over_per_14 + "," + all_over_per_13 + ","
				+ all_over_per_12 + "," + all_over_per_11 + "," + all_over_per_10 + "," 
				+ all_over_per_9 + "," + all_over_per_8 + "," + all_over_per_7 + "," 
				+ all_over_per_6 + "," + all_over_per_5 + "," + all_over_per_4 + ","
				+ all_over_per_3 + "," + all_over_per_2 + "," + all_over_per_1;	        
        
        model.addAttribute("chart_all_val", chart_all_val);
        
        //전체(전직원) 현장보고서 평균 끝
        
        model.addAttribute("modalType", modalType);		
		
		//return "top_statistics/site_chart_detail_modal";
        return sUrl;
	}
	
	/**
	 * 평균처리일 현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/getEndIntervalSearch")
	public String getEndIntervalSearch(Model model, HttpSession session, HttpServletRequest request) {
		logger.info("======= getEndIntervalSearch =======");
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        String start_date = StringUtil.null2blank(request.getParameter("start_date"));  //기준일자 시작일
        String end_date = StringUtil.null2blank(request.getParameter("end_date"));  //기준일자 종료일        

        String exelType = request.getParameter("exelType") != null ? request.getParameter("exelType") : "Member";

        if ("".equals(start_date)){
        	String sToday = DateUtil.getTodayString("yyyy-MM-dd");
        	start_date = DateUtil.getStartYearDay(sToday);
        	end_date = DateUtil.getEndYearDay(sToday);        	

        	//start_date = DateUtil.getDateFormat(start_date,"-");
        	//end_date = DateUtil.getDateFormat(end_date,"-");
            paramMap.put("start_date",start_date);
            paramMap.put("end_date",end_date);
        }
        
        //탭메뉴
        String viewType = request.getParameter("viewType") != null ? request.getParameter("viewType") : "member";        
        //엑셀다운여부
        String excelYN = request.getParameter("excelYN") != null ? request.getParameter("excelYN") : "N";        
        
        //개인별 평균처리기일 목록
        List<Map<String,Object>> memberList = sqlSession.selectList("MisRegTmMapper.selectEndIntervalMemberList",paramMap);
        model.addAttribute("memberList", memberList);
        
        //팀별 평균처리기일 목록
        List<Map<String,Object>> teamList = sqlSession.selectList("MisRegTmMapper.selectEndIntervalTeamList",paramMap);
        model.addAttribute("teamList", teamList);
        
        //센터별 평균처리기일 목록
        List<Map<String,Object>> centerList = new ArrayList<>();				//센터기준결과 목록
        List<Map<String,Object>> centerInfoList = sqlSession.selectList("TopLoginMapper.selectCenterListFor1");
        
        float center_end_average_cnt = 0;
        float center_all_end_total_cnt = 0;
        float center_all_total_period_date = 0;
        
        float center_div = 0;
        
        String sCenterNo = "";
        String sCenterName = "";
        
        for( int i = 0; i < centerInfoList.size(); i++) {
        	Map<String,Object> centerSiteMap = new HashMap<>();
        	sCenterNo = centerInfoList.get(i).get("center_no").toString();
        	sCenterName = centerInfoList.get(i).get("center_name").toString();				
			
    		centerSiteMap.put("team_center", sCenterNo);
    		centerSiteMap.put("center_name", sCenterName);
    		
    		centerSiteMap.put("end_average_cnt", "0");
    		centerSiteMap.put("all_end_total_cnt", "0");
    		centerSiteMap.put("all_total_period_date", "0");
    		
    		for( int k = 0; k < teamList.size(); k++) {
        		if( sCenterNo.equals(teamList.get(k).get("team_center").toString()) ) {
        			center_end_average_cnt += Float.parseFloat(teamList.get(k).get("end_average_cnt").toString());
        			center_all_end_total_cnt += Float.parseFloat(teamList.get(k).get("all_end_total_cnt").toString());
        			center_all_total_period_date += Float.parseFloat(teamList.get(k).get("all_total_period_date").toString());
        			
        			center_div++;
        		}       		
        		
        	}
    		
    		if( center_div > 0 ) {
	        	centerSiteMap.put("end_average_cnt", Math.round(center_end_average_cnt / center_div));
	        	centerSiteMap.put("all_end_total_cnt", Math.round(center_all_end_total_cnt / center_div));
	        	centerSiteMap.put("all_total_period_date", Math.round(center_all_total_period_date / center_div));	        	
        	}
        	
        	//센터 결과목록에 추가
        	centerList.add(i, centerSiteMap);
        	
        	//합계값 초기화
        	center_end_average_cnt = 0;
            center_all_end_total_cnt = 0;
            center_all_total_period_date = 0;            
            center_div = 0;    		
        }        
        //센터별 초과율 목록 끝
        
        //부문별 초과율 목록 시작
        List<Map<String,Object>> sectorList = new ArrayList<>();				//센터기준결과 목록
        List<Map<String,Object>> sectorInfoList = sqlSession.selectList("TopLoginMapper.selectSectorListFor1");
        
        float sector_end_average_cnt = 0;
        float sector_all_end_total_cnt = 0;
        float sector_all_total_period_date = 0;
        
        float sector_div = 0;
        
        String sSectorNo = "";
        String sSectorName = "";
        
        for( int i = 0; i < sectorInfoList.size(); i++) {
        	Map<String,Object> sectorSiteMap = new HashMap<>();
        	sSectorNo = sectorInfoList.get(i).get("team_sector").toString();
        	sSectorName = sectorInfoList.get(i).get("sector_name").toString();				
			
    		sectorSiteMap.put("team_sector", sSectorNo);
    		sectorSiteMap.put("sector_name", sSectorName);
    		
    		sectorSiteMap.put("end_average_cnt", "0");
    		sectorSiteMap.put("all_end_total_cnt", "0");
    		sectorSiteMap.put("all_total_period_date", "0");
    		
    		for( int k = 0; k < teamList.size(); k++) {
        		if( sSectorNo.equals(teamList.get(k).get("team_sector").toString()) ) {
        			sector_end_average_cnt += Float.parseFloat(teamList.get(k).get("end_average_cnt").toString());
        			sector_all_end_total_cnt += Float.parseFloat(teamList.get(k).get("all_end_total_cnt").toString());
        			sector_all_total_period_date += Float.parseFloat(teamList.get(k).get("all_total_period_date").toString());
        			
        			sector_div++;
        		}       		
        		
        	}
    		
    		if( sector_div > 0 ) {
    			sectorSiteMap.put("end_average_cnt", Math.round(sector_end_average_cnt / sector_div));
    			sectorSiteMap.put("all_end_total_cnt", Math.round(sector_all_end_total_cnt / sector_div));
    			sectorSiteMap.put("all_total_period_date", Math.round(sector_all_total_period_date / sector_div));	        	
        	}
        	
        	//센터 결과목록에 추가
        	sectorList.add(i, sectorSiteMap);
        	
        	//합계값 초기화
        	sector_end_average_cnt = 0;        	
        	sector_all_end_total_cnt = 0;            
        	sector_div = 0;
        }
        
        model.addAttribute("centerList", centerList);
        model.addAttribute("sectorList", sectorList);
        model.addAttribute("srchArg",paramMap);
        model.addAttribute("viewType",viewType);        
        
        if( "N".equals(excelYN) ) {
        	return "top_statistics/end_interval_search_all";
        }else{
        	model.addAttribute("exelType", exelType);
        	return "top_statistics/end_interval_search_all_excel";
        }
	}
	
	/**
	 * 일자별 현장보고서 현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/getSiteReportDaily")
	public String getSiteReportDaily(Model model, HttpSession session, HttpServletRequest request) {
		logger.info("======= getSiteReportDaily =======");
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        //검색일자
        String stdBgnde = request.getParameter("searchDateVal") != null ? request.getParameter("searchDateVal") : "";
        //탭메뉴
        String viewType = request.getParameter("viewType") != null ? request.getParameter("viewType") : "member";        
        //엑셀다운여부
        String excelYN = request.getParameter("excelYN") != null ? request.getParameter("excelYN") : "N";
        
        String calStdBgnde = "";		//넘어오는 값이 없는 경우 오늘날짜로 넣고 있는 경우 해당일 다음날로 처리 
        
        //검색일자가 없는경우 오늘 날짜 기준으로 검색한다.
        if( "".equals(stdBgnde) ) {
        	calStdBgnde = DateUtil.getTodayString("yyyy-MM-dd");		//오늘 날짜
        	stdBgnde = DateUtil.getTodayString("yyyy-MM-dd");
        }else{
        	calStdBgnde = DateUtil.addDateNew(stdBgnde, 1);        	
        }
                
        StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics30DaysDate", calStdBgnde);        
        model.addAttribute("nowVO", nowVO);
        
        //개인 초과율 목록
        List<Map<String, Object>> memberList = sqlSession.selectList("MisRegTmMapper.selectSiteMember30Over", nowVO);
        
        //팀별 초과율 목록
        List<Map<String, Object>> teamList = sqlSession.selectList("MisRegTmMapper.selectSiteTeam30Over", nowVO);
        
        //센터별 초과율 목록 시작
        List<Map<String,Object>> centerList = new ArrayList<>();				//센터기준결과 목록
        List<Map<String,Object>> centerInfoList = sqlSession.selectList("TopLoginMapper.selectCenterListFor1");
        
        float center_over_per_1 = 0;
        float center_over_per_2 = 0;
        float center_over_per_3 = 0;
        float center_over_per_4 = 0;
        float center_over_per_5 = 0;
        float center_over_per_6 = 0;
        float center_over_per_7 = 0;
        float center_over_per_8 = 0;
        float center_over_per_9 = 0;
        float center_over_per_10 = 0;
        float center_over_per_11 = 0;
        float center_over_per_12 = 0;
        float center_over_per_13 = 0;
        float center_over_per_14 = 0;
        float center_over_per_15 = 0;
        float center_over_per_16 = 0;
        float center_over_per_17 = 0;
        float center_over_per_18 = 0;
        float center_over_per_19 = 0;
        float center_over_per_20 = 0;
        float center_over_per_21 = 0;
        float center_over_per_22 = 0;
        float center_over_per_23 = 0;
        float center_over_per_24 = 0;
        float center_over_per_25 = 0;
        float center_over_per_26 = 0;
        float center_over_per_27 = 0;
        float center_over_per_28 = 0;
        float center_over_per_29 = 0;
        float center_over_per_30 = 0;
        
        float center_div = 0;
        
        String sCenterNo = "";
        String sCenterName = "";
        
        for( int i = 0; i < centerInfoList.size(); i++) {
        	Map<String,Object> centerSiteMap = new HashMap<>();
        	sCenterNo = centerInfoList.get(i).get("center_no").toString();
        	sCenterName = centerInfoList.get(i).get("center_name").toString();				
			
    		centerSiteMap.put("team_center", sCenterNo);
    		centerSiteMap.put("center_name", sCenterName);    		
    		
    		centerSiteMap.put("over_per_1", "0");
    		centerSiteMap.put("over_per_2", "0");
    		centerSiteMap.put("over_per_3", "0");
    		centerSiteMap.put("over_per_4", "0");
    		centerSiteMap.put("over_per_5", "0");
    		centerSiteMap.put("over_per_6", "0");
    		centerSiteMap.put("over_per_7", "0");
    		centerSiteMap.put("over_per_8", "0");
    		centerSiteMap.put("over_per_9", "0");
    		centerSiteMap.put("over_per_10", "0");
    		
    		centerSiteMap.put("over_per_11", "0");
    		centerSiteMap.put("over_per_12", "0");
    		centerSiteMap.put("over_per_13", "0");
    		centerSiteMap.put("over_per_14", "0");
    		centerSiteMap.put("over_per_15", "0");
    		centerSiteMap.put("over_per_16", "0");
    		centerSiteMap.put("over_per_17", "0");
    		centerSiteMap.put("over_per_18", "0");
    		centerSiteMap.put("over_per_19", "0");
    		centerSiteMap.put("over_per_20", "0");
    		
    		centerSiteMap.put("over_per_21", "0");
    		centerSiteMap.put("over_per_22", "0");
    		centerSiteMap.put("over_per_23", "0");
    		centerSiteMap.put("over_per_24", "0");
    		centerSiteMap.put("over_per_25", "0");
    		centerSiteMap.put("over_per_26", "0");
    		centerSiteMap.put("over_per_27", "0");
    		centerSiteMap.put("over_per_28", "0");
    		centerSiteMap.put("over_per_29", "0");
    		centerSiteMap.put("over_per_30", "0");    		
        	
        	for( int k = 0; k < teamList.size(); k++) {
        		if( sCenterNo.equals(teamList.get(k).get("team_center").toString()) ) {
        			center_over_per_1 += Float.parseFloat(teamList.get(k).get("over_per_1").toString());
        			center_over_per_2 += Float.parseFloat(teamList.get(k).get("over_per_2").toString());
        			center_over_per_3 += Float.parseFloat(teamList.get(k).get("over_per_3").toString());
        			center_over_per_4 += Float.parseFloat(teamList.get(k).get("over_per_4").toString());
        			center_over_per_5 += Float.parseFloat(teamList.get(k).get("over_per_5").toString());
        			center_over_per_6 += Float.parseFloat(teamList.get(k).get("over_per_6").toString());
        			center_over_per_7 += Float.parseFloat(teamList.get(k).get("over_per_7").toString());
        			center_over_per_8 += Float.parseFloat(teamList.get(k).get("over_per_8").toString());
        			center_over_per_9 += Float.parseFloat(teamList.get(k).get("over_per_9").toString());
        			center_over_per_10 += Float.parseFloat(teamList.get(k).get("over_per_10").toString());
        			
        			center_over_per_11 += Float.parseFloat(teamList.get(k).get("over_per_11").toString());
        			center_over_per_12 += Float.parseFloat(teamList.get(k).get("over_per_12").toString());
        			center_over_per_13 += Float.parseFloat(teamList.get(k).get("over_per_13").toString());
        			center_over_per_14 += Float.parseFloat(teamList.get(k).get("over_per_14").toString());
        			center_over_per_15 += Float.parseFloat(teamList.get(k).get("over_per_15").toString());
        			center_over_per_16 += Float.parseFloat(teamList.get(k).get("over_per_16").toString());
        			center_over_per_17 += Float.parseFloat(teamList.get(k).get("over_per_17").toString());
        			center_over_per_18 += Float.parseFloat(teamList.get(k).get("over_per_18").toString());
        			center_over_per_19 += Float.parseFloat(teamList.get(k).get("over_per_19").toString());
        			center_over_per_20 += Float.parseFloat(teamList.get(k).get("over_per_20").toString());
        			
        			center_over_per_21 += Float.parseFloat(teamList.get(k).get("over_per_21").toString());
        			center_over_per_22 += Float.parseFloat(teamList.get(k).get("over_per_22").toString());
        			center_over_per_23 += Float.parseFloat(teamList.get(k).get("over_per_23").toString());
        			center_over_per_24 += Float.parseFloat(teamList.get(k).get("over_per_24").toString());
        			center_over_per_25 += Float.parseFloat(teamList.get(k).get("over_per_25").toString());
        			center_over_per_26 += Float.parseFloat(teamList.get(k).get("over_per_26").toString());
        			center_over_per_27 += Float.parseFloat(teamList.get(k).get("over_per_27").toString());
        			center_over_per_28 += Float.parseFloat(teamList.get(k).get("over_per_28").toString());
        			center_over_per_29 += Float.parseFloat(teamList.get(k).get("over_per_29").toString());
        			center_over_per_30 += Float.parseFloat(teamList.get(k).get("over_per_30").toString());
        			center_div++;
        		}       		
        		
        	}
        	
        	if( center_div > 0 ) {
	        	centerSiteMap.put("over_per_1", Math.round(center_over_per_1 / center_div));
	        	centerSiteMap.put("over_per_2", Math.round(center_over_per_2 / center_div));
	        	centerSiteMap.put("over_per_3", Math.round(center_over_per_3 / center_div));
	        	centerSiteMap.put("over_per_4", Math.round(center_over_per_4 / center_div));
	        	centerSiteMap.put("over_per_5", Math.round(center_over_per_5 / center_div));
	        	centerSiteMap.put("over_per_6", Math.round(center_over_per_6 / center_div));
	        	centerSiteMap.put("over_per_7", Math.round(center_over_per_7 / center_div));
	        	centerSiteMap.put("over_per_8", Math.round(center_over_per_8 / center_div));
	        	centerSiteMap.put("over_per_9", Math.round(center_over_per_9 / center_div));
	        	centerSiteMap.put("over_per_10", Math.round(center_over_per_10 / center_div));
	        	
	        	centerSiteMap.put("over_per_11", Math.round(center_over_per_11 / center_div));
	        	centerSiteMap.put("over_per_12", Math.round(center_over_per_12 / center_div));
	        	centerSiteMap.put("over_per_13", Math.round(center_over_per_13 / center_div));
	        	centerSiteMap.put("over_per_14", Math.round(center_over_per_14 / center_div));
	        	centerSiteMap.put("over_per_15", Math.round(center_over_per_15 / center_div));
	        	centerSiteMap.put("over_per_16", Math.round(center_over_per_16 / center_div));
	        	centerSiteMap.put("over_per_17", Math.round(center_over_per_17 / center_div));
	        	centerSiteMap.put("over_per_18", Math.round(center_over_per_18 / center_div));
	        	centerSiteMap.put("over_per_19", Math.round(center_over_per_19 / center_div));
	        	centerSiteMap.put("over_per_20", Math.round(center_over_per_20 / center_div));
	        	
	        	centerSiteMap.put("over_per_21", Math.round(center_over_per_21 / center_div));
	        	centerSiteMap.put("over_per_22", Math.round(center_over_per_22 / center_div));
	        	centerSiteMap.put("over_per_23", Math.round(center_over_per_23 / center_div));
	        	centerSiteMap.put("over_per_24", Math.round(center_over_per_24 / center_div));
	        	centerSiteMap.put("over_per_25", Math.round(center_over_per_25 / center_div));
	        	centerSiteMap.put("over_per_26", Math.round(center_over_per_26 / center_div));
	        	centerSiteMap.put("over_per_27", Math.round(center_over_per_27 / center_div));
	        	centerSiteMap.put("over_per_28", Math.round(center_over_per_28 / center_div));
	        	centerSiteMap.put("over_per_29", Math.round(center_over_per_29 / center_div));
	        	centerSiteMap.put("over_per_30", Math.round(center_over_per_30 / center_div));
        	}
        	
        	//센터 결과목록에 추가
        	centerList.add(i, centerSiteMap);
        	
        	//합계값 초기화
        	center_over_per_1 = 0;
            center_over_per_2 = 0;
            center_over_per_3 = 0;
            center_over_per_4 = 0;
            center_over_per_5 = 0;
            center_over_per_6 = 0;
            center_over_per_7 = 0;
            center_over_per_8 = 0;
            center_over_per_9 = 0;
            center_over_per_10 = 0;
            center_over_per_11 = 0;
            center_over_per_12 = 0;
            center_over_per_13 = 0;
            center_over_per_14 = 0;
            center_over_per_15 = 0;
            center_over_per_16 = 0;
            center_over_per_17 = 0;
            center_over_per_18 = 0;
            center_over_per_19 = 0;
            center_over_per_20 = 0;
            center_over_per_21 = 0;
            center_over_per_22 = 0;
            center_over_per_23 = 0;
            center_over_per_24 = 0;
            center_over_per_25 = 0;
            center_over_per_26 = 0;
            center_over_per_27 = 0;
            center_over_per_28 = 0;
            center_over_per_29 = 0;
            center_over_per_30 = 0;        	
            center_div = 0;
        }        
        //센터별 초과율 목록 끝
        
        //부문별 초과율 목록 시작
        List<Map<String,Object>> sectorList = new ArrayList<>();				//센터기준결과 목록
        List<Map<String,Object>> sectorInfoList = sqlSession.selectList("TopLoginMapper.selectSectorListFor1");
        
        float sector_over_per_1 = 0;
        float sector_over_per_2 = 0;
        float sector_over_per_3 = 0;
        float sector_over_per_4 = 0;
        float sector_over_per_5 = 0;
        float sector_over_per_6 = 0;
        float sector_over_per_7 = 0;
        float sector_over_per_8 = 0;
        float sector_over_per_9 = 0;
        float sector_over_per_10 = 0;
        float sector_over_per_11 = 0;
        float sector_over_per_12 = 0;
        float sector_over_per_13 = 0;
        float sector_over_per_14 = 0;
        float sector_over_per_15 = 0;
        float sector_over_per_16 = 0;
        float sector_over_per_17 = 0;
        float sector_over_per_18 = 0;
        float sector_over_per_19 = 0;
        float sector_over_per_20 = 0;
        float sector_over_per_21 = 0;
        float sector_over_per_22 = 0;
        float sector_over_per_23 = 0;
        float sector_over_per_24 = 0;
        float sector_over_per_25 = 0;
        float sector_over_per_26 = 0;
        float sector_over_per_27 = 0;
        float sector_over_per_28 = 0;
        float sector_over_per_29 = 0;
        float sector_over_per_30 = 0;
        
        float sector_div = 0;
        
        String sSectorNo = "";
        String sSectorName = "";
        
        for( int i = 0; i < sectorInfoList.size(); i++) {
        	Map<String,Object> sectorSiteMap = new HashMap<>();
        	sSectorNo = sectorInfoList.get(i).get("team_sector").toString();
        	sSectorName = sectorInfoList.get(i).get("sector_name").toString();				
			
    		sectorSiteMap.put("team_sector", sSectorNo);
    		sectorSiteMap.put("sector_name", sSectorName);    		
    		
    		sectorSiteMap.put("over_per_1", "0");
    		sectorSiteMap.put("over_per_2", "0");
    		sectorSiteMap.put("over_per_3", "0");
    		sectorSiteMap.put("over_per_4", "0");
    		sectorSiteMap.put("over_per_5", "0");
    		sectorSiteMap.put("over_per_6", "0");
    		sectorSiteMap.put("over_per_7", "0");
    		sectorSiteMap.put("over_per_8", "0");
    		sectorSiteMap.put("over_per_9", "0");
    		sectorSiteMap.put("over_per_10", "0");
    		
    		sectorSiteMap.put("over_per_11", "0");
    		sectorSiteMap.put("over_per_12", "0");
    		sectorSiteMap.put("over_per_13", "0");
    		sectorSiteMap.put("over_per_14", "0");
    		sectorSiteMap.put("over_per_15", "0");
    		sectorSiteMap.put("over_per_16", "0");
    		sectorSiteMap.put("over_per_17", "0");
    		sectorSiteMap.put("over_per_18", "0");
    		sectorSiteMap.put("over_per_19", "0");
    		sectorSiteMap.put("over_per_20", "0");
    		
    		sectorSiteMap.put("over_per_21", "0");
    		sectorSiteMap.put("over_per_22", "0");
    		sectorSiteMap.put("over_per_23", "0");
    		sectorSiteMap.put("over_per_24", "0");
    		sectorSiteMap.put("over_per_25", "0");
    		sectorSiteMap.put("over_per_26", "0");
    		sectorSiteMap.put("over_per_27", "0");
    		sectorSiteMap.put("over_per_28", "0");
    		sectorSiteMap.put("over_per_29", "0");
    		sectorSiteMap.put("over_per_30", "0");    		
        	
        	for( int k = 0; k < teamList.size(); k++) {
        		if( sSectorNo.equals(teamList.get(k).get("team_sector").toString()) ) {
        			sector_over_per_1 += Float.parseFloat(teamList.get(k).get("over_per_1").toString());
        			sector_over_per_2 += Float.parseFloat(teamList.get(k).get("over_per_2").toString());
        			sector_over_per_3 += Float.parseFloat(teamList.get(k).get("over_per_3").toString());
        			sector_over_per_4 += Float.parseFloat(teamList.get(k).get("over_per_4").toString());
        			sector_over_per_5 += Float.parseFloat(teamList.get(k).get("over_per_5").toString());
        			sector_over_per_6 += Float.parseFloat(teamList.get(k).get("over_per_6").toString());
        			sector_over_per_7 += Float.parseFloat(teamList.get(k).get("over_per_7").toString());
        			sector_over_per_8 += Float.parseFloat(teamList.get(k).get("over_per_8").toString());
        			sector_over_per_9 += Float.parseFloat(teamList.get(k).get("over_per_9").toString());
        			sector_over_per_10 += Float.parseFloat(teamList.get(k).get("over_per_10").toString());
        			
        			sector_over_per_11 += Float.parseFloat(teamList.get(k).get("over_per_11").toString());
        			sector_over_per_12 += Float.parseFloat(teamList.get(k).get("over_per_12").toString());
        			sector_over_per_13 += Float.parseFloat(teamList.get(k).get("over_per_13").toString());
        			sector_over_per_14 += Float.parseFloat(teamList.get(k).get("over_per_14").toString());
        			sector_over_per_15 += Float.parseFloat(teamList.get(k).get("over_per_15").toString());
        			sector_over_per_16 += Float.parseFloat(teamList.get(k).get("over_per_16").toString());
        			sector_over_per_17 += Float.parseFloat(teamList.get(k).get("over_per_17").toString());
        			sector_over_per_18 += Float.parseFloat(teamList.get(k).get("over_per_18").toString());
        			sector_over_per_19 += Float.parseFloat(teamList.get(k).get("over_per_19").toString());
        			sector_over_per_20 += Float.parseFloat(teamList.get(k).get("over_per_20").toString());
        			
        			sector_over_per_21 += Float.parseFloat(teamList.get(k).get("over_per_21").toString());
        			sector_over_per_22 += Float.parseFloat(teamList.get(k).get("over_per_22").toString());
        			sector_over_per_23 += Float.parseFloat(teamList.get(k).get("over_per_23").toString());
        			sector_over_per_24 += Float.parseFloat(teamList.get(k).get("over_per_24").toString());
        			sector_over_per_25 += Float.parseFloat(teamList.get(k).get("over_per_25").toString());
        			sector_over_per_26 += Float.parseFloat(teamList.get(k).get("over_per_26").toString());
        			sector_over_per_27 += Float.parseFloat(teamList.get(k).get("over_per_27").toString());
        			sector_over_per_28 += Float.parseFloat(teamList.get(k).get("over_per_28").toString());
        			sector_over_per_29 += Float.parseFloat(teamList.get(k).get("over_per_29").toString());
        			sector_over_per_30 += Float.parseFloat(teamList.get(k).get("over_per_30").toString());
        			sector_div++;
        		}       		
        		
        	}
        	
        	if( sector_div > 0 ) {
	        	sectorSiteMap.put("over_per_1", Math.round(sector_over_per_1 / sector_div));
	        	sectorSiteMap.put("over_per_2", Math.round(sector_over_per_2 / sector_div));
	        	sectorSiteMap.put("over_per_3", Math.round(sector_over_per_3 / sector_div));
	        	sectorSiteMap.put("over_per_4", Math.round(sector_over_per_4 / sector_div));
	        	sectorSiteMap.put("over_per_5", Math.round(sector_over_per_5 / sector_div));
	        	sectorSiteMap.put("over_per_6", Math.round(sector_over_per_6 / sector_div));
	        	sectorSiteMap.put("over_per_7", Math.round(sector_over_per_7 / sector_div));
	        	sectorSiteMap.put("over_per_8", Math.round(sector_over_per_8 / sector_div));
	        	sectorSiteMap.put("over_per_9", Math.round(sector_over_per_9 / sector_div));
	        	sectorSiteMap.put("over_per_10", Math.round(sector_over_per_10 / sector_div));
	        	
	        	sectorSiteMap.put("over_per_11", Math.round(sector_over_per_11 / sector_div));
	        	sectorSiteMap.put("over_per_12", Math.round(sector_over_per_12 / sector_div));
	        	sectorSiteMap.put("over_per_13", Math.round(sector_over_per_13 / sector_div));
	        	sectorSiteMap.put("over_per_14", Math.round(sector_over_per_14 / sector_div));
	        	sectorSiteMap.put("over_per_15", Math.round(sector_over_per_15 / sector_div));
	        	sectorSiteMap.put("over_per_16", Math.round(sector_over_per_16 / sector_div));
	        	sectorSiteMap.put("over_per_17", Math.round(sector_over_per_17 / sector_div));
	        	sectorSiteMap.put("over_per_18", Math.round(sector_over_per_18 / sector_div));
	        	sectorSiteMap.put("over_per_19", Math.round(sector_over_per_19 / sector_div));
	        	sectorSiteMap.put("over_per_20", Math.round(sector_over_per_20 / sector_div));
	        	
	        	sectorSiteMap.put("over_per_21", Math.round(sector_over_per_21 / sector_div));
	        	sectorSiteMap.put("over_per_22", Math.round(sector_over_per_22 / sector_div));
	        	sectorSiteMap.put("over_per_23", Math.round(sector_over_per_23 / sector_div));
	        	sectorSiteMap.put("over_per_24", Math.round(sector_over_per_24 / sector_div));
	        	sectorSiteMap.put("over_per_25", Math.round(sector_over_per_25 / sector_div));
	        	sectorSiteMap.put("over_per_26", Math.round(sector_over_per_26 / sector_div));
	        	sectorSiteMap.put("over_per_27", Math.round(sector_over_per_27 / sector_div));
	        	sectorSiteMap.put("over_per_28", Math.round(sector_over_per_28 / sector_div));
	        	sectorSiteMap.put("over_per_29", Math.round(sector_over_per_29 / sector_div));
	        	sectorSiteMap.put("over_per_30", Math.round(sector_over_per_30 / sector_div));
        	}
        	
        	//센터 결과목록에 추가
        	sectorList.add(i, sectorSiteMap);
        	
        	//합계값 초기화
        	sector_over_per_1 = 0;
            sector_over_per_2 = 0;
            sector_over_per_3 = 0;
            sector_over_per_4 = 0;
            sector_over_per_5 = 0;
            sector_over_per_6 = 0;
            sector_over_per_7 = 0;
            sector_over_per_8 = 0;
            sector_over_per_9 = 0;
            sector_over_per_10 = 0;
            sector_over_per_11 = 0;
            sector_over_per_12 = 0;
            sector_over_per_13 = 0;
            sector_over_per_14 = 0;
            sector_over_per_15 = 0;
            sector_over_per_16 = 0;
            sector_over_per_17 = 0;
            sector_over_per_18 = 0;
            sector_over_per_19 = 0;
            sector_over_per_20 = 0;
            sector_over_per_21 = 0;
            sector_over_per_22 = 0;
            sector_over_per_23 = 0;
            sector_over_per_24 = 0;
            sector_over_per_25 = 0;
            sector_over_per_26 = 0;
            sector_over_per_27 = 0;
            sector_over_per_28 = 0;
            sector_over_per_29 = 0;
            sector_over_per_30 = 0;        	
            sector_div = 0;
        }
        
        //부문별 초과율 목록 끝
        
        //CommonUtils.printMap(paramMap);
        
        model.addAttribute("memberList", memberList);
        model.addAttribute("teamList", teamList);
        model.addAttribute("centerList", centerList);
        model.addAttribute("sectorList", sectorList);
        model.addAttribute("stdBgnde", stdBgnde);
        model.addAttribute("viewType", viewType);        
        
        if( "N".equals(excelYN) ) {
        	return "top_statistics/site_report_daily_all";
        }else{
        	if( "sector".equals(viewType) ) {
        		return "top_statistics/site_report_daily_sector_excel";
        	}else if( "center".equals(viewType) ) {
        		return "top_statistics/site_report_daily_center_excel";
        	}else if( "team".equals(viewType) ) {
        		return "top_statistics/site_report_daily_team_excel";
        	}else {
        		return "top_statistics/site_report_daily_member_excel";
        	}
        }
	}
	
	/**
	 * 실시간 현장보고서 현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/getSiteReportAll")
	public String getSiteReportAll(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= getSiteReportAll =======");
		//별도 세션 체크 필요없음
		
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        //CommonUtils.printMap(paramMap);
        
        String sToday = DateUtil.getTodayString("yyyy-MM-dd");    	
        String sStartYear = DateUtil.getStartYearDay(sToday);
        String sEndYear = DateUtil.getEndYearDay(sToday);

        paramMap.put("start_date", sStartYear);
        paramMap.put("end_date", sEndYear);
        
        try {
    		String textDate = DateUtil.getTextDateFormat(sStartYear);
    		model.addAttribute("start_date", textDate);
		} catch (Exception e) {
			logger.error("parseError : "+e.getMessage());
		}
        
        //개인별 현장보고서 제출 현황
        List<Map<String,Object>> memberSiteResult = sqlSession.selectList("MisRegTmMapper.selectSiteReportMemberList",paramMap);
        model.addAttribute("memberSiteResult", memberSiteResult);
        
        //팀으로 조회한 전체 보고서 목록
        List<Map<String,Object>> teamSiteAllList = sqlSession.selectList("MisRegTmMapper.selectSiteReportTeamListAll",paramMap);
        
        //팀별 현장보고서 제출 현황            	
    	List<Map<String,Object>> teamSiteResult = new ArrayList<>();	//팀기준 현장보고서 제출 팝업데이터    	
    	List<Map<String,Object>> teamInfoList = sqlSession.selectList("TopLoginMapper.selectTeamListAuthSearchFor1", paramMap);
    	    	
    	String tempTeamId = "";
		String tempTeamname = "";
		String tempCenterName = "";
		
		int nTempSuimCnt = 0;					//30일내 수임건수			
		int nTempSub3OverCnt = 0;				//3일초과 현장보고서 결재			
		int nTempNot3OverCnt = 0;				//3일초과 현장보고서 미결재			
		int nOverPer = 0;							//초과비율(3영업일초과건수 / 전체수임건)
    	
    	int nIndex = 0;
		
		for(int i=0; i < teamInfoList.size(); i++) {
			
			Map<String,Object> teamSiteMap = new HashMap<>();						//for 문내에서 Map 사용시 밖에서 선언하면 안됨.				
			tempTeamId = teamInfoList.get(i).get("teamId").toString();
			tempTeamname = teamInfoList.get(i).get("teamName").toString();
			tempCenterName = teamInfoList.get(i).get("centerName").toString();			
			
			teamSiteMap.put("team_id", tempTeamId);
			teamSiteMap.put("team_name", tempTeamname);
			teamSiteMap.put("center_name", tempCenterName);
			teamSiteMap.put("suim_cnt", "0");
			teamSiteMap.put("sub_3_in_cnt", "0");
			teamSiteMap.put("sub_3_over_cnt", "0");
			teamSiteMap.put("not_3_in_cnt", "0");
			teamSiteMap.put("not_3_over_cnt", "0");
			teamSiteMap.put("over_per", "0");
			teamSiteMap.put("not_30_over_cnt", "0");
			teamSiteMap.put("end_average_cnt", "0");
			
			//System.out.println(teamInfoList.get(i).get("teamId").toString()+" : "+teamInfoList.get(i).get("teamName").toString());
			
			for(int k=0; k < teamSiteAllList.size(); k++) {
				if( tempTeamId.equals(teamSiteAllList.get(k).get("team_id").toString()) ) {						
					teamSiteMap.put("suim_cnt", teamSiteAllList.get(k).get("suim_cnt").toString());
					teamSiteMap.put("sub_3_in_cnt", teamSiteAllList.get(k).get("sub_3_in_cnt").toString());
					teamSiteMap.put("sub_3_over_cnt", teamSiteAllList.get(k).get("sub_3_over_cnt").toString());
					teamSiteMap.put("not_3_in_cnt", teamSiteAllList.get(k).get("not_3_in_cnt").toString());
					teamSiteMap.put("not_3_over_cnt", teamSiteAllList.get(k).get("not_3_over_cnt").toString());						
					teamSiteMap.put("not_30_over_cnt", teamSiteAllList.get(k).get("not_30_over_cnt").toString());
					teamSiteMap.put("end_average_cnt", teamSiteAllList.get(k).get("end_average_cnt").toString());
					//퍼센트 계산
					nTempSuimCnt = Integer.parseInt(teamSiteAllList.get(k).get("suim_cnt").toString());
					nTempSub3OverCnt = Integer.parseInt(teamSiteAllList.get(k).get("sub_3_over_cnt").toString());
					nTempNot3OverCnt = Integer.parseInt(teamSiteAllList.get(k).get("not_3_over_cnt").toString());
					if( nTempSuimCnt > 0) {
						nOverPer = ((nTempSub3OverCnt+nTempNot3OverCnt) * 100) / nTempSuimCnt;
					}else {
						nOverPer = 0;
					}						
					teamSiteMap.put("over_per", String.valueOf(nOverPer));						
				}
			}
			
			//조회 대상 수(수임0, 1개월 미재출건 0)가 전부 0이 아닌경우
			//if( "0".equals(teamSiteMap.get("suim_cnt").toString() ) && "0".equals(teamSiteMap.get("not_30_over_cnt").toString() ) ) {
			if( "0".equals(teamSiteMap.get("suim_cnt").toString() ) && "0".equals(teamSiteMap.get("not_30_over_cnt").toString() ) && "0".equals(teamSiteMap.get("end_average_cnt").toString() ) ) {
				//
			}else {
				teamSiteResult.add(nIndex, teamSiteMap);
				nIndex++;
			}
		}
        
		model.addAttribute("teamSiteResult", teamSiteResult);
        
		//센터별 현장보고서 제출 현황            	
    	List<Map<String,Object>> centerSiteResult = new ArrayList<>();				//센터기준 현장보고서 제출 팝업데이터    	
    	List<Map<String,Object>> centerInfoList = sqlSession.selectList("TopLoginMapper.selectCenterListFor1");
    	
    	String sCenterNo = "";
    	String sCenterName = "";
    	
    	int sum_suim_cnt = 0;
    	int sum_sub_3_in_cnt = 0;
    	int sum_sub_3_over_cnt = 0;
    	int sum_not_3_in_cnt = 0;
    	int sum_not_3_over_cnt = 0;
    	int sum_not_30_over_cnt = 0;    
    	int sum_end_average_cnt = 0;
    	
    	int teamCnt = 0;
    	
    	for(int i=0; i < centerInfoList.size(); i++) {
    		
    		Map<String,Object> centerSiteMap = new HashMap<>();						//for 문내에서 Map 사용시 밖에서 선언하면 안됨.				
    		sCenterNo = centerInfoList.get(i).get("center_no").toString();
    		sCenterName = centerInfoList.get(i).get("center_name").toString();				
			
    		centerSiteMap.put("team_center", sCenterNo);
    		centerSiteMap.put("center_name", sCenterName);
    		centerSiteMap.put("suim_cnt", "0");
    		centerSiteMap.put("sub_3_in_cnt", "0");
    		centerSiteMap.put("sub_3_over_cnt", "0");
    		centerSiteMap.put("not_3_in_cnt", "0");
    		centerSiteMap.put("not_3_over_cnt", "0");
    		centerSiteMap.put("over_per", "0");
    		centerSiteMap.put("not_30_over_cnt", "0");
    		centerSiteMap.put("end_average_cnt", "0");
    		
    		for(int k=0; k < teamSiteAllList.size(); k++) {
				if( sCenterNo.equals(teamSiteAllList.get(k).get("team_center").toString()) ) {
					sum_suim_cnt += Integer.parseInt(teamSiteAllList.get(k).get("suim_cnt").toString());
					sum_sub_3_in_cnt += Integer.parseInt(teamSiteAllList.get(k).get("sub_3_in_cnt").toString());
					sum_sub_3_over_cnt += Integer.parseInt(teamSiteAllList.get(k).get("sub_3_over_cnt").toString());
					sum_not_3_in_cnt += Integer.parseInt(teamSiteAllList.get(k).get("not_3_in_cnt").toString());
					sum_not_3_over_cnt += Integer.parseInt(teamSiteAllList.get(k).get("not_3_over_cnt").toString());
					sum_not_30_over_cnt += Integer.parseInt(teamSiteAllList.get(k).get("not_30_over_cnt").toString());
					sum_end_average_cnt += Integer.parseInt(teamSiteAllList.get(k).get("end_average_cnt").toString());
					teamCnt++;
				}					
			}
    		centerSiteMap.put("suim_cnt", sum_suim_cnt);
    		centerSiteMap.put("sub_3_in_cnt", sum_sub_3_in_cnt);
    		centerSiteMap.put("sub_3_over_cnt", sum_sub_3_over_cnt);
    		centerSiteMap.put("not_3_in_cnt", sum_not_3_in_cnt);
    		centerSiteMap.put("not_3_over_cnt", sum_not_3_over_cnt);
    		centerSiteMap.put("not_30_over_cnt", sum_not_30_over_cnt);
    		
    		if( teamCnt > 0 ) {
    			centerSiteMap.put("end_average_cnt", sum_end_average_cnt / teamCnt);
    		}else {
    			centerSiteMap.put("end_average_cnt", 0);
    		}
    		
    		if( sum_suim_cnt > 0 ) {
    			nOverPer = ((sum_sub_3_over_cnt + sum_not_3_over_cnt) * 100) / sum_suim_cnt;
    		}else{
    			nOverPer = 0;
    		}
    		
    		centerSiteMap.put("over_per", nOverPer);        		
    		
			centerSiteResult.add(i, centerSiteMap);
			
			//합계값 초기화
			sum_suim_cnt = 0;
        	sum_sub_3_in_cnt = 0;
        	sum_sub_3_over_cnt = 0;
        	sum_not_3_in_cnt = 0;
        	sum_not_3_over_cnt = 0;
        	sum_not_30_over_cnt = 0;
        	sum_end_average_cnt = 0;
        	nOverPer = 0;
        	teamCnt = 0;
    	}
    	
    	model.addAttribute("centerSiteResult", centerSiteResult);
    	
    	//부문별 현장보고서 제출현황
    	List<Map<String,Object>> sectorSiteResult = new ArrayList<>();				//부문기준 현장보고서 제출 팝업데이터    	
    	List<Map<String,Object>> sectorInfoList = sqlSession.selectList("TopLoginMapper.selectSectorListFor1");
    	
    	String sSectorNo = "";
    	String sSectorName = "";
    	
    	int sector_sum_suim_cnt = 0;
    	int sector_sum_sub_3_in_cnt = 0;
    	int sector_sum_sub_3_over_cnt = 0;
    	int sector_sum_not_3_in_cnt = 0;
    	int sector_sum_not_3_over_cnt = 0;
    	int sector_sum_not_30_over_cnt = 0;
    	int sector_sum_end_average_cnt = 0;
    	int sector_nOverPer = 0;
    	int sector_teamCnt = 0;
    	
    	for(int i=0; i < sectorInfoList.size(); i++) {
    		
    		Map<String,Object> sectorSiteMap = new HashMap<>();						//for 문내에서 Map 사용시 밖에서 선언하면 안됨.				
    		sSectorNo = sectorInfoList.get(i).get("team_sector").toString();
    		sSectorName = sectorInfoList.get(i).get("sector_name").toString();				
			
    		sectorSiteMap.put("team_sector", sSectorNo);
    		sectorSiteMap.put("sector_name", sSectorName);
    		sectorSiteMap.put("suim_cnt", "0");
    		sectorSiteMap.put("sub_3_in_cnt", "0");
    		sectorSiteMap.put("sub_3_over_cnt", "0");
    		sectorSiteMap.put("not_3_in_cnt", "0");
    		sectorSiteMap.put("not_3_over_cnt", "0");
    		sectorSiteMap.put("over_per", "0");
    		sectorSiteMap.put("not_30_over_cnt", "0");
    		sectorSiteMap.put("end_average_cnt", "0");
    		
    		for(int k=0; k < teamSiteAllList.size(); k++) {
				if( sSectorNo.equals(teamSiteAllList.get(k).get("team_sector").toString()) ) {
					sector_sum_suim_cnt += Integer.parseInt(teamSiteAllList.get(k).get("suim_cnt").toString());
					sector_sum_sub_3_in_cnt += Integer.parseInt(teamSiteAllList.get(k).get("sub_3_in_cnt").toString());
					sector_sum_sub_3_over_cnt += Integer.parseInt(teamSiteAllList.get(k).get("sub_3_over_cnt").toString());
					sector_sum_not_3_in_cnt += Integer.parseInt(teamSiteAllList.get(k).get("not_3_in_cnt").toString());
					sector_sum_not_3_over_cnt += Integer.parseInt(teamSiteAllList.get(k).get("not_3_over_cnt").toString());
					sector_sum_not_30_over_cnt += Integer.parseInt(teamSiteAllList.get(k).get("not_30_over_cnt").toString());
					sector_sum_end_average_cnt += Integer.parseInt(teamSiteAllList.get(k).get("end_average_cnt").toString());
					sector_teamCnt++;
				}					
			}
    		
    		sectorSiteMap.put("suim_cnt", sector_sum_suim_cnt);
    		sectorSiteMap.put("sub_3_in_cnt", sector_sum_sub_3_in_cnt);
    		sectorSiteMap.put("sub_3_over_cnt", sector_sum_sub_3_over_cnt);
    		sectorSiteMap.put("not_3_in_cnt", sector_sum_not_3_in_cnt);
    		sectorSiteMap.put("not_3_over_cnt", sector_sum_not_3_over_cnt);
    		sectorSiteMap.put("not_30_over_cnt", sector_sum_not_30_over_cnt);
    		
    		if( sector_teamCnt > 0 ) {
    			sectorSiteMap.put("end_average_cnt", sector_sum_end_average_cnt / sector_teamCnt);
    		}else {
    			sectorSiteMap.put("end_average_cnt", 0);
    		}
    		
    		if( sector_sum_suim_cnt > 0 ) {
    			sector_nOverPer = ((sector_sum_sub_3_over_cnt + sector_sum_not_3_over_cnt) * 100) / sector_sum_suim_cnt;
    		}else{
    			sector_nOverPer = 0;
    		}
    		
    		sectorSiteMap.put("over_per", sector_nOverPer);        		
    		
			sectorSiteResult.add(i, sectorSiteMap);
			
			//합계값 초기화
			sector_sum_suim_cnt = 0;
			sector_sum_sub_3_in_cnt = 0;
			sector_sum_sub_3_over_cnt = 0;
			sector_sum_not_3_in_cnt = 0;
			sector_sum_not_3_over_cnt = 0;
			sector_sum_not_30_over_cnt = 0;
			sector_sum_end_average_cnt = 0;
        	sector_nOverPer = 0;
        	sector_teamCnt = 0;
    	}
    	
    	model.addAttribute("sectorSiteResult", sectorSiteResult);
    	
        
        return "top_statistics/site_report_all";
	}	

	@RequestMapping(value = "/getMisRegTm")
	public String getMisRegTm(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= getMisRegTm =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			logger.info("getMisRegTm - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 현재 일자 세팅
        //===============================================
        String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));  //기준일자 시작일
        String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));  //기준일자 종료일
        
        String sViewType = String.valueOf(paramMap.get("viewType"));
        
        if( sViewType == null ) {
        	sViewType = "team";
        }

        if ("".equals(stdBgnde)){
            stdBgnde = DateUtil.getStartMonthDay();
            stdEndde = DateUtil.getEndMonthDay();

            stdBgnde = DateUtil.getDateFormat(stdBgnde,"-");
            stdEndde = DateUtil.getDateFormat(stdEndde,"-");

            paramMap.put("stdBgnde",stdBgnde);
            paramMap.put("stdEndde",stdEndde);
            paramMap.put("excelYN", "N");

            //=============================================
            // 수임 농작물 적부 기본값 세팅
            //=============================================
            paramMap.put("basicYN", "Y");
            paramMap.put("primYN", "Y");

        }
        

        //===============================================
        // 필요 날짜 SET
        //===============================================
        String bgnDe = stdBgnde.replace("-","");
        String endDe = DateUtil.addDate(stdEndde.replace("-",""),1);
        String bgnYearDe = (Integer.parseInt(endDe.substring(0,4)) - 1)  + "1216";
        String endYearDe = endDe.substring(0,4) + "1216";

        paramMap.put("bgnDe", bgnDe);
        paramMap.put("endDe", endDe);
        paramMap.put("bgnYearDe", bgnYearDe);
        paramMap.put("endYearDe", endYearDe);
        
		StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", bgnDe);
		nowVO.setBasicYN( String.valueOf(paramMap.get("basicYN")) );
		nowVO.setPrimYN( String.valueOf(paramMap.get("primYN")) );
		
 		List<MisRegTmVO> getMisRegTm1 = sqlSession.selectList("MisRegTmMapper.getMisRegTm1", nowVO);
 		
 		//1종 서면심사 팀 통계를 별도로 처리하기위한 기능 추가 시작 by top3009
 		String sChk_written = "0";			//서면심사팀 여부
 		
 		MisRegTmVO getMisRegTm1Temp = new MisRegTmVO();		//1종 서면심사팀용 값을 셋팅하기위한 임시 Bean
 		
 		for(int i=0; i < getMisRegTm1.size(); i++) {
 			sChk_written = getMisRegTm1.get(i).getTeam_written();
 			
 			if( "1".equals(sChk_written) ) {
 				nowVO.setTeam_id(getMisRegTm1.get(i).getTeam_id());
 				//System.out.println("team_id="+nowVO.getTeam_id()+" : "+nowVO.getMonBefore0()); 				
 				getMisRegTm1Temp = sqlSession.selectOne("MisRegTmMapper.getMisRegWrittenTm1", nowVO);
 				getMisRegTm1.get(i).setReg_1(getMisRegTm1Temp.getReg_1());
 				getMisRegTm1.get(i).setReg_2(getMisRegTm1Temp.getReg_2());
 				getMisRegTm1.get(i).setReg_3(getMisRegTm1Temp.getReg_3());
 				getMisRegTm1.get(i).setReg_4(getMisRegTm1Temp.getReg_4());
 				getMisRegTm1.get(i).setReg_5(getMisRegTm1Temp.getReg_5());
 				getMisRegTm1.get(i).setReg_6(getMisRegTm1Temp.getReg_6());
 				getMisRegTm1.get(i).setReg_7(getMisRegTm1Temp.getReg_7());
 				getMisRegTm1.get(i).setReg_8(getMisRegTm1Temp.getReg_8());
 				getMisRegTm1.get(i).setReg_9(getMisRegTm1Temp.getReg_9());
 				getMisRegTm1.get(i).setReg_10(getMisRegTm1Temp.getReg_10());
 				getMisRegTm1.get(i).setReg_11(getMisRegTm1Temp.getReg_11());
 				getMisRegTm1.get(i).setReg_12(getMisRegTm1Temp.getReg_12());
 				
 				getMisRegTm1.get(i).setReg_wc_1(getMisRegTm1Temp.getReg_wc_1());
 				getMisRegTm1.get(i).setReg_wc_2(getMisRegTm1Temp.getReg_wc_2());
 				getMisRegTm1.get(i).setReg_wc_3(getMisRegTm1Temp.getReg_wc_3());
 				getMisRegTm1.get(i).setReg_wc_4(getMisRegTm1Temp.getReg_wc_4());
 				getMisRegTm1.get(i).setReg_wc_5(getMisRegTm1Temp.getReg_wc_5());
 				getMisRegTm1.get(i).setReg_wc_6(getMisRegTm1Temp.getReg_wc_6());
 				getMisRegTm1.get(i).setReg_wc_7(getMisRegTm1Temp.getReg_wc_7());
 				getMisRegTm1.get(i).setReg_wc_8(getMisRegTm1Temp.getReg_wc_8());
 				getMisRegTm1.get(i).setReg_wc_9(getMisRegTm1Temp.getReg_wc_9());
 				getMisRegTm1.get(i).setReg_wc_10(getMisRegTm1Temp.getReg_wc_10());
 				getMisRegTm1.get(i).setReg_wc_11(getMisRegTm1Temp.getReg_wc_11());
 				getMisRegTm1.get(i).setReg_wc_12(getMisRegTm1Temp.getReg_wc_12());
 				
 				getMisRegTm1.get(i).setCls_1(getMisRegTm1Temp.getCls_1());
 				getMisRegTm1.get(i).setCls_2(getMisRegTm1Temp.getCls_2());
 				getMisRegTm1.get(i).setCls_3(getMisRegTm1Temp.getCls_3());
 				getMisRegTm1.get(i).setCls_4(getMisRegTm1Temp.getCls_4());
 				getMisRegTm1.get(i).setCls_5(getMisRegTm1Temp.getCls_5());
 				getMisRegTm1.get(i).setCls_6(getMisRegTm1Temp.getCls_6());
 				getMisRegTm1.get(i).setCls_7(getMisRegTm1Temp.getCls_7());
 				getMisRegTm1.get(i).setCls_8(getMisRegTm1Temp.getCls_8());
 				getMisRegTm1.get(i).setCls_9(getMisRegTm1Temp.getCls_9());
 				getMisRegTm1.get(i).setCls_10(getMisRegTm1Temp.getCls_10());
 				getMisRegTm1.get(i).setCls_11(getMisRegTm1Temp.getCls_11());
 				getMisRegTm1.get(i).setCls_12(getMisRegTm1Temp.getCls_12());
 				
 				getMisRegTm1.get(i).setCls_wc_1(getMisRegTm1Temp.getCls_wc_1());
 				getMisRegTm1.get(i).setCls_wc_2(getMisRegTm1Temp.getCls_wc_2());
 				getMisRegTm1.get(i).setCls_wc_3(getMisRegTm1Temp.getCls_wc_3());
 				getMisRegTm1.get(i).setCls_wc_4(getMisRegTm1Temp.getCls_wc_4());
 				getMisRegTm1.get(i).setCls_wc_5(getMisRegTm1Temp.getCls_wc_5());
 				getMisRegTm1.get(i).setCls_wc_6(getMisRegTm1Temp.getCls_wc_6());
 				getMisRegTm1.get(i).setCls_wc_7(getMisRegTm1Temp.getCls_wc_7());
 				getMisRegTm1.get(i).setCls_wc_8(getMisRegTm1Temp.getCls_wc_8());
 				getMisRegTm1.get(i).setCls_wc_9(getMisRegTm1Temp.getCls_wc_9());
 				getMisRegTm1.get(i).setCls_wc_10(getMisRegTm1Temp.getCls_wc_10());
 				getMisRegTm1.get(i).setCls_wc_11(getMisRegTm1Temp.getCls_wc_11());
 				getMisRegTm1.get(i).setCls_wc_12(getMisRegTm1Temp.getCls_wc_12());
 			} 			
 			
 		} 		
 		//1종 서면심사 팀 통계를 별도로 처리하기위한 기능 추가 끝 by top3009
 		
		model.addAttribute("getMisRegTm1",getMisRegTm1);

		List<MisRegTmVO> getMisRegTm4 = sqlSession.selectList("MisRegTmMapper.getMisRegTm4", nowVO);
		model.addAttribute("getMisRegTm4",getMisRegTm4);

		model.addAttribute("nowVO", nowVO);
		
		//부문별 추가 시작 by top3009		
		/** 팀 부문 선택을 위한 부문 명부로드 2019.07.08 by top3009*/
		SysAdmCodeDicVO codeVO = new SysAdmCodeDicVO();      
		codeVO.setTbl_nm("top_tm_bsc");
		codeVO.setCol_nm("team_sector");
		List<SysAdmCodeDicVO> teamSectorList = service.codeList(codeVO);
		
		long sum_reg_12 = 0;
		long sum_reg_11 = 0;
		long sum_reg_10 = 0;
		long sum_reg_9 = 0;
		long sum_reg_8 = 0;
		long sum_reg_7 = 0;
		long sum_reg_6 = 0;
		long sum_reg_5 = 0;
		long sum_reg_4 = 0;
		long sum_reg_3 = 0;
		long sum_reg_2 = 0;
		long sum_reg_1 = 0;
		
		long sum_reg_wc_12 = 0;
		long sum_reg_wc_11 = 0;
		long sum_reg_wc_10 = 0;
		long sum_reg_wc_9 = 0;
		long sum_reg_wc_8 = 0;
		long sum_reg_wc_7 = 0;
		long sum_reg_wc_6 = 0;
		long sum_reg_wc_5 = 0;
		long sum_reg_wc_4 = 0;
		long sum_reg_wc_3 = 0;
		long sum_reg_wc_2 = 0;
		long sum_reg_wc_1 = 0;
		
		long sum_cls_12 = 0;
		long sum_cls_11 = 0;
		long sum_cls_10 = 0;
		long sum_cls_9 = 0;
		long sum_cls_8 = 0;
		long sum_cls_7 = 0;
		long sum_cls_6 = 0;
		long sum_cls_5 = 0;
		long sum_cls_4 = 0;
		long sum_cls_3 = 0;
		long sum_cls_2 = 0;
		long sum_cls_1 = 0;
		
		long sum_cls_wc_12 = 0;
		long sum_cls_wc_11 = 0;
		long sum_cls_wc_10 = 0;
		long sum_cls_wc_9 = 0;
		long sum_cls_wc_8 = 0;
		long sum_cls_wc_7 = 0;
		long sum_cls_wc_6 = 0;
		long sum_cls_wc_5 = 0;
		long sum_cls_wc_4 = 0;
		long sum_cls_wc_3 = 0;
		long sum_cls_wc_2 = 0;
		long sum_cls_wc_1 = 0;
		
		String sSector = ""; 
		String sSector_val = "";
		String sSector_flag = "";
		
		int nSector_member_cnt = 0;				//부문별 직원수
		
		List<MisRegTmVO> TeamSectorListVO = new ArrayList<MisRegTmVO>();			//부문별 목록에 뿌려줄 리스트 생성		
		
		//부문별 합산계산 시작
		for(int i=0; i < teamSectorList.size(); i++) {
			
			MisRegTmVO sectorBean = new MisRegTmVO();			//리스트에 넣어줄 객체 생성
			
			sSector = teamSectorList.get(i).getCol_cd();
			sSector_val = teamSectorList.get(i).getCol_val();			
			sectorBean.setTeam_sector(sSector);
			sectorBean.setTeam_sector_val(sSector_val);
			
			//팀목록에서 가져온 카운트를 체크해서 넣어준다.
			for(int k=0; k < getMisRegTm1.size(); k++) {				
				sSector_flag = getMisRegTm1.get(k).getTeam_sector();
				//if(sSector.equals(sSector_flag) && !"0".equals(sSector)){				//team_sector 가 0이아니고, 같은경우만 합산한다.					
				if(sSector.equals(sSector_flag)){
					
					nSector_member_cnt += getMisRegTm1.get(k).getMember_cnt();
					
					sum_reg_12 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_12());					
					sum_reg_11 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_11());
					sum_reg_10 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_10());
					sum_reg_9 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_9());
					sum_reg_8 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_8());
					sum_reg_7 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_7());
					sum_reg_6 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_6());
					sum_reg_5 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_5());
					sum_reg_4 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_4());
					sum_reg_3 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_3());
					sum_reg_2 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_2());
					sum_reg_1 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_1());
					
					sum_reg_wc_12 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_wc_12());					
					sum_reg_wc_11 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_wc_11());
					sum_reg_wc_10 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_wc_10());
					sum_reg_wc_9 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_wc_9());
					sum_reg_wc_8 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_wc_8());
					sum_reg_wc_7 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_wc_7());
					sum_reg_wc_6 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_wc_6());
					sum_reg_wc_5 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_wc_5());
					sum_reg_wc_4 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_wc_4());
					sum_reg_wc_3 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_wc_3());
					sum_reg_wc_2 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_wc_2());
					sum_reg_wc_1 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_wc_1());
					
					sum_cls_12 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_12());
					sum_cls_11 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_11());
					sum_cls_10 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_10());
					sum_cls_9 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_9());
					sum_cls_8 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_8());
					sum_cls_7 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_7());
					sum_cls_6 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_6());
					sum_cls_5 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_5());
					sum_cls_4 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_4());
					sum_cls_3 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_3());
					sum_cls_2 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_2());
					sum_cls_1 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_1());
					
					sum_cls_wc_12 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_wc_12());
					sum_cls_wc_11 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_wc_11());
					sum_cls_wc_10 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_wc_10());
					sum_cls_wc_9 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_wc_9());
					sum_cls_wc_8 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_wc_8());
					sum_cls_wc_7 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_wc_7());
					sum_cls_wc_6 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_wc_6());
					sum_cls_wc_5 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_wc_5());
					sum_cls_wc_4 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_wc_4());
					sum_cls_wc_3 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_wc_3());
					sum_cls_wc_2 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_wc_2());
					sum_cls_wc_1 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_wc_1());					
					
					//if ("2".equals(sSector)) {
						//System.out.println(k + " : " + sSector_val + " : " + getMisRegTm1.get(k).getTeam_name() + " : "
								//+ WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_wc_12()) + " : " + sum_cls_wc_12+ " : "
								//+ WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_wc_11()) + " : " + sum_cls_wc_11);
					//}
					 
				}
			}
			
			sectorBean.setMember_cnt(nSector_member_cnt);
			
			sectorBean.setReg_1(Long.toString(sum_reg_1));
			sectorBean.setReg_2(Long.toString(sum_reg_2));
			sectorBean.setReg_3(Long.toString(sum_reg_3));
			sectorBean.setReg_4(Long.toString(sum_reg_4));
			sectorBean.setReg_5(Long.toString(sum_reg_5));
			sectorBean.setReg_6(Long.toString(sum_reg_6));
			sectorBean.setReg_7(Long.toString(sum_reg_7));
			sectorBean.setReg_8(Long.toString(sum_reg_8));
			sectorBean.setReg_9(Long.toString(sum_reg_9));
			sectorBean.setReg_10(Long.toString(sum_reg_10));
			sectorBean.setReg_11(Long.toString(sum_reg_11));
			sectorBean.setReg_12(Long.toString(sum_reg_12));
			
			sectorBean.setReg_wc_1(Long.toString(sum_reg_wc_1));
			sectorBean.setReg_wc_2(Long.toString(sum_reg_wc_2));
			sectorBean.setReg_wc_3(Long.toString(sum_reg_wc_3));
			sectorBean.setReg_wc_4(Long.toString(sum_reg_wc_4));
			sectorBean.setReg_wc_5(Long.toString(sum_reg_wc_5));
			sectorBean.setReg_wc_6(Long.toString(sum_reg_wc_6));
			sectorBean.setReg_wc_7(Long.toString(sum_reg_wc_7));
			sectorBean.setReg_wc_8(Long.toString(sum_reg_wc_8));
			sectorBean.setReg_wc_9(Long.toString(sum_reg_wc_9));
			sectorBean.setReg_wc_10(Long.toString(sum_reg_wc_10));
			sectorBean.setReg_wc_11(Long.toString(sum_reg_wc_11));
			sectorBean.setReg_wc_12(Long.toString(sum_reg_wc_12));
			
			sectorBean.setCls_1(Long.toString(sum_cls_1));
			sectorBean.setCls_2(Long.toString(sum_cls_2));
			sectorBean.setCls_3(Long.toString(sum_cls_3));
			sectorBean.setCls_4(Long.toString(sum_cls_4));
			sectorBean.setCls_5(Long.toString(sum_cls_5));
			sectorBean.setCls_6(Long.toString(sum_cls_6));
			sectorBean.setCls_7(Long.toString(sum_cls_7));
			sectorBean.setCls_8(Long.toString(sum_cls_8));
			sectorBean.setCls_9(Long.toString(sum_cls_9));
			sectorBean.setCls_10(Long.toString(sum_cls_10));
			sectorBean.setCls_11(Long.toString(sum_cls_11));
			sectorBean.setCls_12(Long.toString(sum_cls_12));
			
			sectorBean.setCls_wc_1(Long.toString(sum_cls_wc_1));
			sectorBean.setCls_wc_2(Long.toString(sum_cls_wc_2));
			sectorBean.setCls_wc_3(Long.toString(sum_cls_wc_3));
			sectorBean.setCls_wc_4(Long.toString(sum_cls_wc_4));
			sectorBean.setCls_wc_5(Long.toString(sum_cls_wc_5));
			sectorBean.setCls_wc_6(Long.toString(sum_cls_wc_6));
			sectorBean.setCls_wc_7(Long.toString(sum_cls_wc_7));
			sectorBean.setCls_wc_8(Long.toString(sum_cls_wc_8));
			sectorBean.setCls_wc_9(Long.toString(sum_cls_wc_9));
			sectorBean.setCls_wc_10(Long.toString(sum_cls_wc_10));
			sectorBean.setCls_wc_11(Long.toString(sum_cls_wc_11));
			sectorBean.setCls_wc_12(Long.toString(sum_cls_wc_12));
			
			
			//서면심사 부문 표시 여부 확인
			long sum_sector_all = sum_reg_wc_12 + sum_reg_wc_11 + sum_reg_wc_10 + sum_reg_wc_9
					+ sum_reg_wc_8 + sum_reg_wc_7 + sum_reg_wc_6 + sum_reg_wc_5
					+ sum_reg_wc_4 + sum_reg_wc_3 + sum_reg_wc_2 + sum_reg_wc_1
					+ sum_cls_wc_12 + sum_cls_wc_11 + sum_cls_wc_10 + sum_cls_wc_9
					+ sum_cls_wc_8 + sum_cls_wc_7 + sum_cls_wc_6 + sum_cls_wc_5
					+ sum_cls_wc_4 + sum_cls_wc_3 + sum_cls_wc_2 + sum_cls_wc_1;
		
			if( sum_sector_all == 0) {
				sectorBean.setWc_sector_flag("0");
			}else{
				sectorBean.setWc_sector_flag("1");
			}

			TeamSectorListVO.add(i, sectorBean);
			
			//변수 초기화
			sum_reg_12 = 0;
			sum_reg_11 = 0;
			sum_reg_10 = 0;
			sum_reg_9 = 0;
			sum_reg_8 = 0;
			sum_reg_7 = 0;
			sum_reg_6 = 0;
			sum_reg_5 = 0;
			sum_reg_4 = 0;
			sum_reg_3 = 0;
			sum_reg_2 = 0;
			sum_reg_1 = 0;
			
			sum_reg_wc_12 = 0;
			sum_reg_wc_11 = 0;
			sum_reg_wc_10 = 0;
			sum_reg_wc_9 = 0;
			sum_reg_wc_8 = 0;
			sum_reg_wc_7 = 0;
			sum_reg_wc_6 = 0;
			sum_reg_wc_5 = 0;
			sum_reg_wc_4 = 0;
			sum_reg_wc_3 = 0;
			sum_reg_wc_2 = 0;
			sum_reg_wc_1 = 0;
			
			sum_cls_12 = 0;
			sum_cls_11 = 0;
			sum_cls_10 = 0;
			sum_cls_9 = 0;
			sum_cls_8 = 0;
			sum_cls_7 = 0;
			sum_cls_6 = 0;
			sum_cls_5 = 0;
			sum_cls_4 = 0;
			sum_cls_3 = 0;
			sum_cls_2 = 0;
			sum_cls_1 = 0;
			
			sum_cls_wc_12 = 0;
			sum_cls_wc_11 = 0;
			sum_cls_wc_10 = 0;
			sum_cls_wc_9 = 0;
			sum_cls_wc_8 = 0;
			sum_cls_wc_7 = 0;
			sum_cls_wc_6 = 0;
			sum_cls_wc_5 = 0;
			sum_cls_wc_4 = 0;
			sum_cls_wc_3 = 0;
			sum_cls_wc_2 = 0;
			sum_cls_wc_1 = 0;
			
			nSector_member_cnt = 0;
		}		
		
		model.addAttribute("TeamSectorListVO", TeamSectorListVO);		
		//1종 부문별 추가 끝 by top3009
		
		
		//4종 부문별 목록 시작		
		List<MisRegTmVO> TeamSector4ListVO = new ArrayList<MisRegTmVO>();			//4종 부문별 목록에 뿌려줄 리스트 생성
		
		//부문별 합산계산 시작
		for(int i=0; i < teamSectorList.size(); i++) {
			
			MisRegTmVO sector4Bean = new MisRegTmVO();			//리스트에 넣어줄 객체 생성
			
			sSector = teamSectorList.get(i).getCol_cd();
			sSector_val = teamSectorList.get(i).getCol_val();			
			sector4Bean.setTeam_sector(sSector);
			sector4Bean.setTeam_sector_val(sSector_val);
			
			//팀목록에서 가져온 카운트를 체크해서 넣어준다.
			for(int k=0; k < getMisRegTm4.size(); k++) {				
				sSector_flag = getMisRegTm4.get(k).getTeam_sector();
				
				if(sSector.equals(sSector_flag)){
					
					nSector_member_cnt += getMisRegTm4.get(k).getMember_cnt();
					
					sum_reg_12 += WebUtil.parseStringToLong(getMisRegTm4.get(k).getReg_12());					
					sum_reg_11 +=  WebUtil.parseStringToLong(getMisRegTm4.get(k).getReg_11());
					sum_reg_10 +=  WebUtil.parseStringToLong(getMisRegTm4.get(k).getReg_10());
					sum_reg_9 +=  WebUtil.parseStringToLong(getMisRegTm4.get(k).getReg_9());
					sum_reg_8 +=  WebUtil.parseStringToLong(getMisRegTm4.get(k).getReg_8());
					sum_reg_7 +=  WebUtil.parseStringToLong(getMisRegTm4.get(k).getReg_7());
					sum_reg_6 +=  WebUtil.parseStringToLong(getMisRegTm4.get(k).getReg_6());
					sum_reg_5 +=  WebUtil.parseStringToLong(getMisRegTm4.get(k).getReg_5());
					sum_reg_4 +=  WebUtil.parseStringToLong(getMisRegTm4.get(k).getReg_4());
					sum_reg_3 +=  WebUtil.parseStringToLong(getMisRegTm4.get(k).getReg_3());
					sum_reg_2 +=  WebUtil.parseStringToLong(getMisRegTm4.get(k).getReg_2());
					sum_reg_1 +=  WebUtil.parseStringToLong(getMisRegTm4.get(k).getReg_1());
										
					sum_cls_12 += WebUtil.parseStringToLong(getMisRegTm4.get(k).getCls_12());
					sum_cls_11 += WebUtil.parseStringToLong(getMisRegTm4.get(k).getCls_11());
					sum_cls_10 += WebUtil.parseStringToLong(getMisRegTm4.get(k).getCls_10());
					sum_cls_9 += WebUtil.parseStringToLong(getMisRegTm4.get(k).getCls_9());
					sum_cls_8 += WebUtil.parseStringToLong(getMisRegTm4.get(k).getCls_8());
					sum_cls_7 += WebUtil.parseStringToLong(getMisRegTm4.get(k).getCls_7());
					sum_cls_6 += WebUtil.parseStringToLong(getMisRegTm4.get(k).getCls_6());
					sum_cls_5 += WebUtil.parseStringToLong(getMisRegTm4.get(k).getCls_5());
					sum_cls_4 += WebUtil.parseStringToLong(getMisRegTm4.get(k).getCls_4());
					sum_cls_3 += WebUtil.parseStringToLong(getMisRegTm4.get(k).getCls_3());
					sum_cls_2 += WebUtil.parseStringToLong(getMisRegTm4.get(k).getCls_2());
					sum_cls_1 += WebUtil.parseStringToLong(getMisRegTm4.get(k).getCls_1());
					
					//System.out.println(sSector_val+" : " +sum_reg_12);
					//System.out.println(sSector+" : " +sum_cls_12);
					
				}
			}
			
			//System.out.println(sSector_val+" : " +sum_reg_12);
			//System.out.println(sSector+" : " +sum_cls_12);
			
			sector4Bean.setMember_cnt(nSector_member_cnt);
			
			sector4Bean.setReg_1(Long.toString(sum_reg_1));
			sector4Bean.setReg_2(Long.toString(sum_reg_2));
			sector4Bean.setReg_3(Long.toString(sum_reg_3));
			sector4Bean.setReg_4(Long.toString(sum_reg_4));
			sector4Bean.setReg_5(Long.toString(sum_reg_5));
			sector4Bean.setReg_6(Long.toString(sum_reg_6));
			sector4Bean.setReg_7(Long.toString(sum_reg_7));
			sector4Bean.setReg_8(Long.toString(sum_reg_8));
			sector4Bean.setReg_9(Long.toString(sum_reg_9));
			sector4Bean.setReg_10(Long.toString(sum_reg_10));
			sector4Bean.setReg_11(Long.toString(sum_reg_11));
			sector4Bean.setReg_12(Long.toString(sum_reg_12));
						
			sector4Bean.setCls_1(Long.toString(sum_cls_1));
			sector4Bean.setCls_2(Long.toString(sum_cls_2));
			sector4Bean.setCls_3(Long.toString(sum_cls_3));
			sector4Bean.setCls_4(Long.toString(sum_cls_4));
			sector4Bean.setCls_5(Long.toString(sum_cls_5));
			sector4Bean.setCls_6(Long.toString(sum_cls_6));
			sector4Bean.setCls_7(Long.toString(sum_cls_7));
			sector4Bean.setCls_8(Long.toString(sum_cls_8));
			sector4Bean.setCls_9(Long.toString(sum_cls_9));
			sector4Bean.setCls_10(Long.toString(sum_cls_10));
			sector4Bean.setCls_11(Long.toString(sum_cls_11));
			sector4Bean.setCls_12(Long.toString(sum_cls_12));
			
			TeamSector4ListVO.add(i, sector4Bean);
			
			//변수 초기화
			sum_reg_12 = 0;
			sum_reg_11 = 0;
			sum_reg_10 = 0;
			sum_reg_9 = 0;
			sum_reg_8 = 0;
			sum_reg_7 = 0;
			sum_reg_6 = 0;
			sum_reg_5 = 0;
			sum_reg_4 = 0;
			sum_reg_3 = 0;
			sum_reg_2 = 0;
			sum_reg_1 = 0;
			
			sum_cls_12 = 0;
			sum_cls_11 = 0;
			sum_cls_10 = 0;
			sum_cls_9 = 0;
			sum_cls_8 = 0;
			sum_cls_7 = 0;
			sum_cls_6 = 0;
			sum_cls_5 = 0;
			sum_cls_4 = 0;
			sum_cls_3 = 0;
			sum_cls_2 = 0;
			sum_cls_1 = 0;
			
			nSector_member_cnt = 0;
		}
		
		model.addAttribute("TeamSector4ListVO", TeamSector4ListVO);	
		//4종 부문별 목록 끝
		
		//물보험 센터별 추가 시작 by top3009		
		/** 팀 센터 선택을 위한 부문 명부로드 2019.07.15 by top3009*/		      
		codeVO.setTbl_nm("top_tm_bsc");
		codeVO.setCol_nm("team_center");
		List<SysAdmCodeDicVO> teamCenterList = service.codeList(codeVO);
		
		long sum_center_reg_12 = 0;
		long sum_center_reg_11 = 0;
		long sum_center_reg_10 = 0;
		long sum_center_reg_9 = 0;
		long sum_center_reg_8 = 0;
		long sum_center_reg_7 = 0;
		long sum_center_reg_6 = 0;
		long sum_center_reg_5 = 0;
		long sum_center_reg_4 = 0;
		long sum_center_reg_3 = 0;
		long sum_center_reg_2 = 0;
		long sum_center_reg_1 = 0;
		
		long sum_center_wc_reg_12 = 0;
		long sum_center_wc_reg_11 = 0;
		long sum_center_wc_reg_10 = 0;
		long sum_center_wc_reg_9 = 0;
		long sum_center_wc_reg_8 = 0;
		long sum_center_wc_reg_7 = 0;
		long sum_center_wc_reg_6 = 0;
		long sum_center_wc_reg_5 = 0;
		long sum_center_wc_reg_4 = 0;
		long sum_center_wc_reg_3 = 0;
		long sum_center_wc_reg_2 = 0;
		long sum_center_wc_reg_1 = 0;

		long sum_center_cls_12 = 0;
		long sum_center_cls_11 = 0;
		long sum_center_cls_10 = 0;
		long sum_center_cls_9 = 0;
		long sum_center_cls_8 = 0;
		long sum_center_cls_7 = 0;
		long sum_center_cls_6 = 0;
		long sum_center_cls_5 = 0;
		long sum_center_cls_4 = 0;
		long sum_center_cls_3 = 0;
		long sum_center_cls_2 = 0;
		long sum_center_cls_1 = 0;
		
		long sum_center_wc_cls_12 = 0;
		long sum_center_wc_cls_11 = 0;
		long sum_center_wc_cls_10 = 0;
		long sum_center_wc_cls_9 = 0;
		long sum_center_wc_cls_8 = 0;
		long sum_center_wc_cls_7 = 0;
		long sum_center_wc_cls_6 = 0;
		long sum_center_wc_cls_5 = 0;
		long sum_center_wc_cls_4 = 0;
		long sum_center_wc_cls_3 = 0;
		long sum_center_wc_cls_2 = 0;
		long sum_center_wc_cls_1 = 0;

		String sCenter = ""; 
		String sCenter_val = "";
		String sCenter_flag = "";
		
		int nCenter_member_cnt = 0;
		
		List<MisRegTmVO> TeamCenterListVO = new ArrayList<MisRegTmVO>();			//센터별 목록에 뿌려줄 리스트 생성
		
		//센터별 합산계산 시작
		for(int i=0; i < teamCenterList.size(); i++) {
			
			MisRegTmVO centerBean = new MisRegTmVO();			//리스트에 넣어줄 객체 생성
			
			sCenter = teamCenterList.get(i).getCol_cd();
			sCenter_val = teamCenterList.get(i).getCol_val();			
			centerBean.setTeam_center(sCenter);
			centerBean.setTeam_center_val(sCenter_val);
			
			//System.out.println("sCenter="+sCenter+" : sCenter_val="+sCenter_val);			
			
			//팀목록에서 가져온 카운트를 체크해서 넣어준다.
			for(int k=0; k < getMisRegTm1.size(); k++) {				
				sCenter_flag = getMisRegTm1.get(k).getTeam_center();
				
				//System.out.println("sCenter_flag="+sCenter_flag);
				
				//if(sCenter.equals(sCenter_flag) && !"0".equals(sCenter)){				//team_center 가 0이아니고, 같은경우만 합산한다.
				if(sCenter.equals(sCenter_flag)){				//team_center 가 0이아니고, 같은경우만 합산한다.					
					//System.out.println(sCenter_val+"에 합산 : "+getMisRegTm1.get(k).getTeam_name());
					
					nCenter_member_cnt += getMisRegTm1.get(k).getMember_cnt();
					
					sum_center_reg_12 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_12());					
					sum_center_reg_11 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_11());
					sum_center_reg_10 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_10());
					sum_center_reg_9 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_9());
					sum_center_reg_8 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_8());
					sum_center_reg_7 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_7());
					sum_center_reg_6 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_6());
					sum_center_reg_5 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_5());
					sum_center_reg_4 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_4());
					sum_center_reg_3 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_3());
					sum_center_reg_2 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_2());
					sum_center_reg_1 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_1());
					
					sum_center_wc_reg_12 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_wc_12());					
					sum_center_wc_reg_11 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_wc_11());
					sum_center_wc_reg_10 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_wc_10());
					sum_center_wc_reg_9 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_wc_9());
					sum_center_wc_reg_8 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_wc_8());
					sum_center_wc_reg_7 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_wc_7());
					sum_center_wc_reg_6 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_wc_6());
					sum_center_wc_reg_5 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_wc_5());
					sum_center_wc_reg_4 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_wc_4());
					sum_center_wc_reg_3 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_wc_3());
					sum_center_wc_reg_2 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_wc_2());
					sum_center_wc_reg_1 +=  WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_wc_1());
					
					sum_center_cls_12 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_12());
					sum_center_cls_11 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_11());
					sum_center_cls_10 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_10());
					sum_center_cls_9 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_9());
					sum_center_cls_8 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_8());
					sum_center_cls_7 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_7());
					sum_center_cls_6 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_6());
					sum_center_cls_5 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_5());
					sum_center_cls_4 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_4());
					sum_center_cls_3 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_3());
					sum_center_cls_2 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_2());
					sum_center_cls_1 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_1());
					
					sum_center_wc_cls_12 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_wc_12());
					sum_center_wc_cls_11 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_wc_11());
					sum_center_wc_cls_10 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_wc_10());
					sum_center_wc_cls_9 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_wc_9());
					sum_center_wc_cls_8 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_wc_8());
					sum_center_wc_cls_7 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_wc_7());
					sum_center_wc_cls_6 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_wc_6());
					sum_center_wc_cls_5 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_wc_5());
					sum_center_wc_cls_4 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_wc_4());
					sum_center_wc_cls_3 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_wc_3());
					sum_center_wc_cls_2 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_wc_2());
					sum_center_wc_cls_1 += WebUtil.parseStringToLong(getMisRegTm1.get(k).getCls_wc_1());
										
					/*
					 * if ("11".equals(sCenter)) { System.out.println(k + " : " + sCenter_val +
					 * " : " + getMisRegTm1.get(k).getTeam_name() + " : " +
					 * WebUtil.parseStringToLong(getMisRegTm1.get(k).getReg_12()) + " : " +
					 * sum_center_reg_12); }
					 */ 
				}
			}
			
			centerBean.setMember_cnt(nCenter_member_cnt);
			
			centerBean.setReg_1(Long.toString(sum_center_reg_1));
			centerBean.setReg_2(Long.toString(sum_center_reg_2));
			centerBean.setReg_3(Long.toString(sum_center_reg_3));
			centerBean.setReg_4(Long.toString(sum_center_reg_4));
			centerBean.setReg_5(Long.toString(sum_center_reg_5));
			centerBean.setReg_6(Long.toString(sum_center_reg_6));
			centerBean.setReg_7(Long.toString(sum_center_reg_7));
			centerBean.setReg_8(Long.toString(sum_center_reg_8));
			centerBean.setReg_9(Long.toString(sum_center_reg_9));
			centerBean.setReg_10(Long.toString(sum_center_reg_10));
			centerBean.setReg_11(Long.toString(sum_center_reg_11));
			centerBean.setReg_12(Long.toString(sum_center_reg_12));
			
			centerBean.setReg_wc_1(Long.toString(sum_center_wc_reg_1));
			centerBean.setReg_wc_2(Long.toString(sum_center_wc_reg_2));
			centerBean.setReg_wc_3(Long.toString(sum_center_wc_reg_3));
			centerBean.setReg_wc_4(Long.toString(sum_center_wc_reg_4));
			centerBean.setReg_wc_5(Long.toString(sum_center_wc_reg_5));
			centerBean.setReg_wc_6(Long.toString(sum_center_wc_reg_6));
			centerBean.setReg_wc_7(Long.toString(sum_center_wc_reg_7));
			centerBean.setReg_wc_8(Long.toString(sum_center_wc_reg_8));
			centerBean.setReg_wc_9(Long.toString(sum_center_wc_reg_9));
			centerBean.setReg_wc_10(Long.toString(sum_center_wc_reg_10));
			centerBean.setReg_wc_11(Long.toString(sum_center_wc_reg_11));
			centerBean.setReg_wc_12(Long.toString(sum_center_wc_reg_12));
			
			centerBean.setCls_1(Long.toString(sum_center_cls_1));
			centerBean.setCls_2(Long.toString(sum_center_cls_2));
			centerBean.setCls_3(Long.toString(sum_center_cls_3));
			centerBean.setCls_4(Long.toString(sum_center_cls_4));
			centerBean.setCls_5(Long.toString(sum_center_cls_5));
			centerBean.setCls_6(Long.toString(sum_center_cls_6));
			centerBean.setCls_7(Long.toString(sum_center_cls_7));
			centerBean.setCls_8(Long.toString(sum_center_cls_8));
			centerBean.setCls_9(Long.toString(sum_center_cls_9));
			centerBean.setCls_10(Long.toString(sum_center_cls_10));
			centerBean.setCls_11(Long.toString(sum_center_cls_11));
			centerBean.setCls_12(Long.toString(sum_center_cls_12));
			
			centerBean.setCls_wc_1(Long.toString(sum_center_wc_cls_1));
			centerBean.setCls_wc_2(Long.toString(sum_center_wc_cls_2));
			centerBean.setCls_wc_3(Long.toString(sum_center_wc_cls_3));
			centerBean.setCls_wc_4(Long.toString(sum_center_wc_cls_4));
			centerBean.setCls_wc_5(Long.toString(sum_center_wc_cls_5));
			centerBean.setCls_wc_6(Long.toString(sum_center_wc_cls_6));
			centerBean.setCls_wc_7(Long.toString(sum_center_wc_cls_7));
			centerBean.setCls_wc_8(Long.toString(sum_center_wc_cls_8));
			centerBean.setCls_wc_9(Long.toString(sum_center_wc_cls_9));
			centerBean.setCls_wc_10(Long.toString(sum_center_wc_cls_10));
			centerBean.setCls_wc_11(Long.toString(sum_center_wc_cls_11));
			centerBean.setCls_wc_12(Long.toString(sum_center_wc_cls_12));
			
			//서면심사 센터 표시 여부 확인
			long sum_center_all = sum_center_wc_reg_12 + sum_center_wc_reg_11 + sum_center_wc_reg_10 + sum_center_wc_reg_9
					+ sum_center_wc_reg_8 + sum_center_wc_reg_7 + sum_center_wc_reg_6 + sum_center_wc_reg_5
					+ sum_center_wc_reg_4 + sum_center_wc_reg_3 + sum_center_wc_reg_2 + sum_center_wc_reg_1
					+ sum_center_wc_cls_12 + sum_center_wc_cls_11 + sum_center_wc_cls_10 + sum_center_wc_cls_9
					+ sum_center_wc_cls_8 + sum_center_wc_cls_7 + sum_center_wc_cls_6 + sum_center_wc_cls_5
					+ sum_center_wc_cls_4 + sum_center_wc_cls_3 + sum_center_wc_cls_2 + sum_center_wc_cls_1;
		
			if( sum_center_all == 0) {
				centerBean.setWc_center_flag("0");
			}else{
				centerBean.setWc_center_flag("1");
			}
			

			TeamCenterListVO.add(i, centerBean);
			
			//변수 초기화
			sCenter_flag = "";
			sum_center_reg_12 = 0;
			sum_center_reg_11 = 0;
			sum_center_reg_10 = 0;
			sum_center_reg_9 = 0;
			sum_center_reg_8 = 0;
			sum_center_reg_7 = 0;
			sum_center_reg_6 = 0;
			sum_center_reg_5 = 0;
			sum_center_reg_4 = 0;
			sum_center_reg_3 = 0;
			sum_center_reg_2 = 0;
			sum_center_reg_1 = 0;
			
			sum_center_wc_reg_12 = 0;
			sum_center_wc_reg_11 = 0;
			sum_center_wc_reg_10 = 0;
			sum_center_wc_reg_9 = 0;
			sum_center_wc_reg_8 = 0;
			sum_center_wc_reg_7 = 0;
			sum_center_wc_reg_6 = 0;
			sum_center_wc_reg_5 = 0;
			sum_center_wc_reg_4 = 0;
			sum_center_wc_reg_3 = 0;
			sum_center_wc_reg_2 = 0;
			sum_center_wc_reg_1 = 0;
			
			sum_center_cls_12 = 0;
			sum_center_cls_11 = 0;
			sum_center_cls_10 = 0;
			sum_center_cls_9 = 0;
			sum_center_cls_8 = 0;
			sum_center_cls_7 = 0;
			sum_center_cls_6 = 0;
			sum_center_cls_5 = 0;
			sum_center_cls_4 = 0;
			sum_center_cls_3 = 0;
			sum_center_cls_2 = 0;
			sum_center_cls_1 = 0;
			
			sum_center_wc_cls_12 = 0;
			sum_center_wc_cls_11 = 0;
			sum_center_wc_cls_10 = 0;
			sum_center_wc_cls_9 = 0;
			sum_center_wc_cls_8 = 0;
			sum_center_wc_cls_7 = 0;
			sum_center_wc_cls_6 = 0;
			sum_center_wc_cls_5 = 0;
			sum_center_wc_cls_4 = 0;
			sum_center_wc_cls_3 = 0;
			sum_center_wc_cls_2 = 0;
			sum_center_wc_cls_1 = 0;
			
			nCenter_member_cnt = 0;
		}
		
		
		model.addAttribute("TeamCenterListVO", TeamCenterListVO);
		//물보험 센터별 추가 끝
		
		//4종 (인보험) 센터별 추가 시작
		List<MisRegTmVO> TeamCenter4ListVO = new ArrayList<MisRegTmVO>();			//센터별 목록에 뿌려줄 리스트 생성
		
		//센터별 합산계산 시작
		for(int i=0; i < teamCenterList.size(); i++) {
			
			MisRegTmVO center4Bean = new MisRegTmVO();			//리스트에 넣어줄 객체 생성
			
			sCenter = teamCenterList.get(i).getCol_cd();
			sCenter_val = teamCenterList.get(i).getCol_val();			
			center4Bean.setTeam_center(sCenter);
			center4Bean.setTeam_center_val(sCenter_val);			
			
			//팀목록에서 가져온 카운트를 체크해서 넣어준다.
			for(int k=0; k < getMisRegTm4.size(); k++) {				
				sCenter_flag = getMisRegTm4.get(k).getTeam_center();

				if(sCenter.equals(sCenter_flag)){				//team_center 가 0이아니고, 같은경우만 합산한다.
					
					nCenter_member_cnt += getMisRegTm4.get(k).getMember_cnt();
					
					sum_center_reg_12 += WebUtil.parseStringToLong(getMisRegTm4.get(k).getReg_12());					
					sum_center_reg_11 +=  WebUtil.parseStringToLong(getMisRegTm4.get(k).getReg_11());
					sum_center_reg_10 +=  WebUtil.parseStringToLong(getMisRegTm4.get(k).getReg_10());
					sum_center_reg_9 +=  WebUtil.parseStringToLong(getMisRegTm4.get(k).getReg_9());
					sum_center_reg_8 +=  WebUtil.parseStringToLong(getMisRegTm4.get(k).getReg_8());
					sum_center_reg_7 +=  WebUtil.parseStringToLong(getMisRegTm4.get(k).getReg_7());
					sum_center_reg_6 +=  WebUtil.parseStringToLong(getMisRegTm4.get(k).getReg_6());
					sum_center_reg_5 +=  WebUtil.parseStringToLong(getMisRegTm4.get(k).getReg_5());
					sum_center_reg_4 +=  WebUtil.parseStringToLong(getMisRegTm4.get(k).getReg_4());
					sum_center_reg_3 +=  WebUtil.parseStringToLong(getMisRegTm4.get(k).getReg_3());
					sum_center_reg_2 +=  WebUtil.parseStringToLong(getMisRegTm4.get(k).getReg_2());
					sum_center_reg_1 +=  WebUtil.parseStringToLong(getMisRegTm4.get(k).getReg_1());
										
					sum_center_cls_12 += WebUtil.parseStringToLong(getMisRegTm4.get(k).getCls_12());
					sum_center_cls_11 += WebUtil.parseStringToLong(getMisRegTm4.get(k).getCls_11());
					sum_center_cls_10 += WebUtil.parseStringToLong(getMisRegTm4.get(k).getCls_10());
					sum_center_cls_9 += WebUtil.parseStringToLong(getMisRegTm4.get(k).getCls_9());
					sum_center_cls_8 += WebUtil.parseStringToLong(getMisRegTm4.get(k).getCls_8());
					sum_center_cls_7 += WebUtil.parseStringToLong(getMisRegTm4.get(k).getCls_7());
					sum_center_cls_6 += WebUtil.parseStringToLong(getMisRegTm4.get(k).getCls_6());
					sum_center_cls_5 += WebUtil.parseStringToLong(getMisRegTm4.get(k).getCls_5());
					sum_center_cls_4 += WebUtil.parseStringToLong(getMisRegTm4.get(k).getCls_4());
					sum_center_cls_3 += WebUtil.parseStringToLong(getMisRegTm4.get(k).getCls_3());
					sum_center_cls_2 += WebUtil.parseStringToLong(getMisRegTm4.get(k).getCls_2());
					sum_center_cls_1 += WebUtil.parseStringToLong(getMisRegTm4.get(k).getCls_1());
					 
				}
			}
			
			center4Bean.setMember_cnt(nCenter_member_cnt);
			
			center4Bean.setReg_1(Long.toString(sum_center_reg_1));
			center4Bean.setReg_2(Long.toString(sum_center_reg_2));
			center4Bean.setReg_3(Long.toString(sum_center_reg_3));
			center4Bean.setReg_4(Long.toString(sum_center_reg_4));
			center4Bean.setReg_5(Long.toString(sum_center_reg_5));
			center4Bean.setReg_6(Long.toString(sum_center_reg_6));
			center4Bean.setReg_7(Long.toString(sum_center_reg_7));
			center4Bean.setReg_8(Long.toString(sum_center_reg_8));
			center4Bean.setReg_9(Long.toString(sum_center_reg_9));
			center4Bean.setReg_10(Long.toString(sum_center_reg_10));
			center4Bean.setReg_11(Long.toString(sum_center_reg_11));
			center4Bean.setReg_12(Long.toString(sum_center_reg_12));
			
			center4Bean.setCls_1(Long.toString(sum_center_cls_1));
			center4Bean.setCls_2(Long.toString(sum_center_cls_2));
			center4Bean.setCls_3(Long.toString(sum_center_cls_3));
			center4Bean.setCls_4(Long.toString(sum_center_cls_4));
			center4Bean.setCls_5(Long.toString(sum_center_cls_5));
			center4Bean.setCls_6(Long.toString(sum_center_cls_6));
			center4Bean.setCls_7(Long.toString(sum_center_cls_7));
			center4Bean.setCls_8(Long.toString(sum_center_cls_8));
			center4Bean.setCls_9(Long.toString(sum_center_cls_9));
			center4Bean.setCls_10(Long.toString(sum_center_cls_10));
			center4Bean.setCls_11(Long.toString(sum_center_cls_11));
			center4Bean.setCls_12(Long.toString(sum_center_cls_12));
			
			TeamCenter4ListVO.add(i, center4Bean);
			
			//변수 초기화
			sCenter_flag = "";
			sum_center_reg_12 = 0;
			sum_center_reg_11 = 0;
			sum_center_reg_10 = 0;
			sum_center_reg_9 = 0;
			sum_center_reg_8 = 0;
			sum_center_reg_7 = 0;
			sum_center_reg_6 = 0;
			sum_center_reg_5 = 0;
			sum_center_reg_4 = 0;
			sum_center_reg_3 = 0;
			sum_center_reg_2 = 0;
			sum_center_reg_1 = 0;
						
			sum_center_cls_12 = 0;
			sum_center_cls_11 = 0;
			sum_center_cls_10 = 0;
			sum_center_cls_9 = 0;
			sum_center_cls_8 = 0;
			sum_center_cls_7 = 0;
			sum_center_cls_6 = 0;
			sum_center_cls_5 = 0;
			sum_center_cls_4 = 0;
			sum_center_cls_3 = 0;
			sum_center_cls_2 = 0;
			sum_center_cls_1 = 0;	
			
			nCenter_member_cnt = 0;
		}
		
		
		model.addAttribute("TeamCenter4ListVO", TeamCenter4ListVO);
		//센터별 추가 끝	
		
		//4종 (인모험) 센터별 추가 끝
		

        model.addAttribute("srchArg",paramMap);
        model.addAttribute("sViewType", sViewType);
//		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_reg_tm";
	}//getMisRegTm
	

	@RequestMapping(value = "/getMisRegTmMbr")
	public String getMisRegTmMbr(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= getMisRegTmMbr =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			logger.info("getMisRegTmMbr - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String teamId = String.valueOf(paramMap.get("team_id"));
        String teamName = String.valueOf(paramMap.get("team_name"));
        String teamType = String.valueOf(paramMap.get("team_type"));
        
        paramMap.put("team_id",teamId);
        paramMap.put("team_name",teamName);
        paramMap.put("team_type",teamType);
        
        //===============================================
        // 현재 일자 세팅
        //===============================================
        String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));  //기준일자 시작일
        String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));  //기준일자 종료일

        if ("".equals(stdBgnde)){
            stdBgnde = DateUtil.getStartMonthDay();
            stdEndde = DateUtil.getEndMonthDay();

            stdBgnde = DateUtil.getDateFormat(stdBgnde,"-");
            stdEndde = DateUtil.getDateFormat(stdEndde,"-");

            paramMap.put("stdBgnde",stdBgnde);
            paramMap.put("stdEndde",stdEndde);
            paramMap.put("excelYN", "N");

            //=============================================
            // 수임 농작물 적부 기본값 세팅
            //=============================================
            paramMap.put("basicYN", "Y");
            paramMap.put("primYN", "Y");
        }
        

        //===============================================
        // 필요 날짜 SET
        //===============================================
        String bgnDe = stdBgnde.replace("-","");
        String endDe = DateUtil.addDate(stdEndde.replace("-",""),1);
        String bgnYearDe = (Integer.parseInt(endDe.substring(0,4)) - 1)  + "1216";
        String endYearDe = endDe.substring(0,4) + "1216";

        paramMap.put("bgnDe", bgnDe);
        paramMap.put("endDe", endDe);
        paramMap.put("bgnYearDe", bgnYearDe);
        paramMap.put("endYearDe", endYearDe);		
        
        
//		String tmpNow_to = "";
//		if(inVO.getViewToDate() == null || inVO.getViewToDate().equals("")){
//			DateFormat tmpFormat = new SimpleDateFormat("yyyy-MM-16");
//			Date tmpToday = new Date();
//			tmpNow_to = tmpFormat.format(tmpToday);
//		}else{
//			tmpNow_to = inVO.getViewToDate();
//		}
//		inVO.setViewToDate(tmpNow_to);
        
        
		StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", bgnDe);
		nowVO.setBasicYN( String.valueOf(paramMap.get("basicYN")) );
		nowVO.setPrimYN( String.valueOf(paramMap.get("primYN")) );
		nowVO.setTeam_id(teamId);

		
		List<MisRegTmVO> getMisRegTmMbr1 = sqlSession.selectList("MisRegTmMbrMapper.getMisRegTmMbr1", nowVO);
		
		MisRegTmVO getMisRegTmMbr1Temp = new MisRegTmVO();
		
		for(int i=0; i < getMisRegTmMbr1.size(); i++) {
			//1종 서면심사인경우만 별도처리
			if("1".equals(getMisRegTmMbr1.get(i).getTeam_written().toString())) {
				//System.out.println("team_id="+getMisRegTmMbr1.get(i).getTeam_id()+" : "+getMisRegTmMbr1.get(i).getUser_no());
				nowVO.setUser_no(getMisRegTmMbr1.get(i).getUser_no());
				getMisRegTmMbr1Temp = sqlSession.selectOne("MisRegTmMbrMapper.getMisRegWrittenTmMbr1", nowVO);
				getMisRegTmMbr1.get(i).setReg_1(getMisRegTmMbr1Temp.getReg_1());
				getMisRegTmMbr1.get(i).setReg_2(getMisRegTmMbr1Temp.getReg_2());
				getMisRegTmMbr1.get(i).setReg_3(getMisRegTmMbr1Temp.getReg_3());
				getMisRegTmMbr1.get(i).setReg_4(getMisRegTmMbr1Temp.getReg_4());
				getMisRegTmMbr1.get(i).setReg_5(getMisRegTmMbr1Temp.getReg_5());
				getMisRegTmMbr1.get(i).setReg_6(getMisRegTmMbr1Temp.getReg_6());
				getMisRegTmMbr1.get(i).setReg_7(getMisRegTmMbr1Temp.getReg_7());
				getMisRegTmMbr1.get(i).setReg_8(getMisRegTmMbr1Temp.getReg_8());
				getMisRegTmMbr1.get(i).setReg_9(getMisRegTmMbr1Temp.getReg_9());
				getMisRegTmMbr1.get(i).setReg_10(getMisRegTmMbr1Temp.getReg_10());
				getMisRegTmMbr1.get(i).setReg_11(getMisRegTmMbr1Temp.getReg_11());
				getMisRegTmMbr1.get(i).setReg_12(getMisRegTmMbr1Temp.getReg_12());
				
				getMisRegTmMbr1.get(i).setCls_1(getMisRegTmMbr1Temp.getCls_1());
				getMisRegTmMbr1.get(i).setCls_2(getMisRegTmMbr1Temp.getCls_2());
				getMisRegTmMbr1.get(i).setCls_3(getMisRegTmMbr1Temp.getCls_3());
				getMisRegTmMbr1.get(i).setCls_4(getMisRegTmMbr1Temp.getCls_4());
				getMisRegTmMbr1.get(i).setCls_5(getMisRegTmMbr1Temp.getCls_5());
				getMisRegTmMbr1.get(i).setCls_6(getMisRegTmMbr1Temp.getCls_6());
				getMisRegTmMbr1.get(i).setCls_7(getMisRegTmMbr1Temp.getCls_7());
				getMisRegTmMbr1.get(i).setCls_8(getMisRegTmMbr1Temp.getCls_8());
				getMisRegTmMbr1.get(i).setCls_9(getMisRegTmMbr1Temp.getCls_9());
				getMisRegTmMbr1.get(i).setCls_10(getMisRegTmMbr1Temp.getCls_10());
				getMisRegTmMbr1.get(i).setCls_11(getMisRegTmMbr1Temp.getCls_11());
				getMisRegTmMbr1.get(i).setCls_12(getMisRegTmMbr1Temp.getCls_12());				
			}
		}		
		model.addAttribute("getMisRegTmMbr1",getMisRegTmMbr1);
		
		/*
		List<String> getMisTmMbrList = sqlSession.selectList("MisTmBscMbrMapper.getMisTmMbrList", inVO);
		List<MisRegTmVO> getMisRegTmMbr1 = null;
		
		if(getMisTmMbrList.size() > 0){
			getMisRegTmMbr1 = new ArrayList<MisRegTmVO>();
		}
		
		for(int i = 0; i < getMisTmMbrList.size(); i++){
			nowVO.setUser_no(getMisTmMbrList.get(i));
			MisRegTmVO tmpVO = sqlSession.selectOne("MisRegTmMbrMapper.getMisRegTmMbr1", nowVO);
			getMisRegTmMbr1.add(tmpVO);
		}
		
		if(getMisRegTmMbr1 != null){
			model.addAttribute("getMisRegTmMbr1",getMisRegTmMbr1);
		}
		*/
		
		model.addAttribute("nowVO", nowVO);

        model.addAttribute("srchArg",paramMap);
//		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_reg_tm_mbr";
	}//getMisRegTmMbr

	@RequestMapping(value = "/getMisRegTmPtnr")
	public String getMisRegTmPtnr(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= getMisRegTmPtnr =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			logger.info("getMisRegTmPtnr - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String teamId = String.valueOf(paramMap.get("team_id"));
        String teamName = String.valueOf(paramMap.get("team_name"));
        String teamType = String.valueOf(paramMap.get("team_type"));
        
        paramMap.put("team_id",teamId);
        paramMap.put("team_name",teamName);
        paramMap.put("team_type",teamType);
        
        //===============================================
        // 현재 일자 세팅
        //===============================================
        String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));  //기준일자 시작일
        String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));  //기준일자 종료일

        if ("".equals(stdBgnde)){
            stdBgnde = DateUtil.getStartMonthDay();
            stdEndde = DateUtil.getEndMonthDay();

            stdBgnde = DateUtil.getDateFormat(stdBgnde,"-");
            stdEndde = DateUtil.getDateFormat(stdEndde,"-");

            paramMap.put("stdBgnde",stdBgnde);
            paramMap.put("stdEndde",stdEndde);
            paramMap.put("excelYN", "N");

            //=============================================
            // 수임 농작물 적부 기본값 세팅
            //=============================================
            paramMap.put("basicYN", "Y");
            paramMap.put("primYN", "Y");
        }
        

        //===============================================
        // 필요 날짜 SET
        //===============================================
        String bgnDe = stdBgnde.replace("-","");
        String endDe = DateUtil.addDate(stdEndde.replace("-",""),1);
        String bgnYearDe = (Integer.parseInt(endDe.substring(0,4)) - 1)  + "1216";
        String endYearDe = endDe.substring(0,4) + "1216";

        paramMap.put("bgnDe", bgnDe);
        paramMap.put("endDe", endDe);
        paramMap.put("bgnYearDe", bgnYearDe);
        paramMap.put("endYearDe", endYearDe);				
		
/*
		String tmpNow_to = "";
		if(inVO.getViewToDate() == null || inVO.getViewToDate().equals("")){
			DateFormat tmpFormat = new SimpleDateFormat("yyyy-MM-16");
			Date tmpToday = new Date();
			tmpNow_to = tmpFormat.format(tmpToday);
		}else{
			tmpNow_to = inVO.getViewToDate();
		}
		inVO.setViewToDate(tmpNow_to);
*/
        
		StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", bgnDe);
		nowVO.setBasicYN( String.valueOf(paramMap.get("basicYN")) );
		nowVO.setPrimYN( String.valueOf(paramMap.get("primYN")) );
		nowVO.setTeam_id(teamId);
        
		List<MisRegTmVO> getMisRegTmPtnr1 = sqlSession.selectList("MisRegTmPtnrMapper.getMisRegTmPtnr1", nowVO);
		model.addAttribute("getMisRegTmPtnr1",getMisRegTmPtnr1);

		List<MisRegTmVO> getMisRegTmPtnr4 = sqlSession.selectList("MisRegTmPtnrMapper.getMisRegTmPtnr4", nowVO);
		model.addAttribute("getMisRegTmPtnr4",getMisRegTmPtnr4);

		model.addAttribute("nowVO", nowVO);
		
        model.addAttribute("srchArg",paramMap);
//		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_reg_tm_ptnr";
	}

}//class
