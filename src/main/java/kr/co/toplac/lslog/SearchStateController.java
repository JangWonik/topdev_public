package kr.co.toplac.lslog;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.topptnr.TopPtnrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;

@Controller
public class SearchStateController {
	
	private static final Logger logger = LoggerFactory.getLogger(SearchStateController.class);

	@Autowired
	private SqlSession sqlSession;

	/*
	*********************************************************
	* Method ID		: // 영문 메소드 이름
	* Method Name	: // 국문 메소드 이름
	* Description	: // 간략한 설명
	* Author		: // 개발자 이름
	* Date			: // 최초 작성일
	* Update		: // 수정일 + 수정 요청자(있는 경우) + 수정 내용
	*********************************************************
	*/
	@RequestMapping(value = "/search_state", method = RequestMethod.GET)
	public String search_state(Model model, HttpServletRequest request, SearchStateVO vo2, String rid, String tid, String pid) {
		String viewName = search_statePost(model, request, vo2, rid, tid, pid);
		return viewName;
	}

	@RequestMapping(value = "/search_state", method = RequestMethod.POST)
	public String search_statePost(Model model, HttpServletRequest request, SearchStateVO vo2, String rid, String tid, String pid) {
		
		/*검색에 사용될 팀목록 추출*/
		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
		model.addAttribute("teamList", teamList);

		/*보험사 목록 추출*/
		List<TopPtnrBscVO> ptnrList = sqlSession.selectList("SuimRegInsMapper.ptnrList");
		model.addAttribute("ptnrList", ptnrList);
		//날짜만들기 시작
		String fromdate = vo2.getViewFromDate();
		String todate = vo2.getViewToDate();
		Calendar today = Calendar.getInstance();
		int dateInt = today.get(Calendar.DATE);
		int monthInt = today.get(Calendar.MONTH) + 1;
		int yearInt = today.get(Calendar.YEAR);
		int toDateInt = 1;
		
		model.addAttribute("tid", tid);
		model.addAttribute("pid", pid);
		/*if(fromdate != null){
		int s_fromdate = Integer.parseInt(fromdate.substring(5, 7));	
		fromdate = (fromdate.substring(0, 4)) +"-"+ ((s_fromdate < 10)? "0" + s_fromdate : s_fromdate) +"-"+ (fromdate.substring(8, 10));
		}
		
		if(todate != null){
		int s_todate = Integer.parseInt(todate.substring(5, 7));
		todate = (todate.substring(0, 4)) +"-"+ ((s_todate < 9)? "0" + (s_todate+1) : (s_todate+1)) +"-"+ (todate.substring(8, 10));
		}*/
		
		/*if(fromdate == null || "".equals(fromdate)){
			if(monthInt == 0){
				monthInt = 12;
				yearInt--;
			}
			fromdate = "" + yearInt +"-"+ ((monthInt < 10)? "0"+monthInt : monthInt) +"-"+ "0" + toDateInt;
		}
		if(todate == null || "".equals(todate)){
			if(monthInt == 13){
				monthInt = 1;
				yearInt++;
			}
			todate = "" + yearInt + "-" + ((monthInt < 10)? "0"+(monthInt+1) : (monthInt+1)) + "-" + ((dateInt < 10)? "0" +toDateInt : "0" + toDateInt);
		}*/
		
		
		/*String year = todate.substring(0, 4);
		String month = todate.substring(5, 7);*/
		
		/*int fromAccumYear = Integer.parseInt(fromdate.substring(0, 4));
		int fromAccumMonth = Integer.parseInt(fromdate.substring(5, 7));
		int toAccumYear = Integer.parseInt(todate.substring(0, 4));
		if(fromAccumMonth < 13){
			fromAccumYear--;
		}
		String fromYear = fromAccumYear + "12" + "16";
		String toYear = toAccumYear + "12" + "16";*/
		/*int toMonthInt = (Integer.parseInt(month) -1);
		if(toMonthInt == 0){
			toMonthInt = 12;
		}
		
		model.addAttribute("year",year);
		model.addAttribute("month",month);*/
		model.addAttribute("todate",todate);
		
		
		
		//날짜만들기 종료
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fromdate", fromdate);
		map.put("todate", todate);
		map.put("tid", tid);
		map.put("pid", pid);
		/*map.put("fromYear", fromYear);
		map.put("toYear", toYear);
		
		
		model.addAttribute("fromYear", fromYear);
		model.addAttribute("toYear", toYear);*/
		model.addAttribute("dateInt", dateInt);
		model.addAttribute("monthInt", monthInt);
		model.addAttribute("fromdate", fromdate);
		model.addAttribute("todate", todate);
		//model.addAttribute("toAccumYear", toAccumYear);
		//model.addAttribute("toMonthInt", toMonthInt);
		
		System.out.println(fromdate + ":from");
		System.out.println(todate + ":to");
				
		//1종 변수 설정
		int rpt_reg = 0;
		int rpt_sub = 0;
		int rpt_end = 0;
		int rpt_cancel_return = 0;
		int rpt_law = 0;
		int rpt_notend = 0;
		int k1s_price_sum = 0;
		//1종 소계 변수 선언 종료
		
		/*int team_rpt_reg = 0;
		int team_rpt_sub = 0;
		int team_rpt_end = 0;
		int team_rpt_cancel_return = 0;
		int team_rpt_law = 0;
		int team_rpt_notend = 0;
			
			SearchStateVO rpt_List = sqlSession.selectOne("SearchStateMapper.rpt_List", map);
			model.addAttribute("rpt_List" , rpt_List);
			
			
			List<SearchStateVO> teamRptList = new ArrayList<SearchStateVO>();
			int intForkind1 = 0;

			for(int i = 0; i < teamList.size(); i++, intForkind1++){
				TopTmBscVO TeamVO = teamList.get(i);
				String tmpTeamid = TeamVO.getTeam_id();
				map.put("tmpTeamid", tmpTeamid);
				
				//1종 log 조회 Start
				SearchStateVO selTeamRptList = sqlSession.selectOne("SearchStateMapper.selTeamRptList", map);
				//1종 log 조회 End

				System.out.println(TeamVO.getTeam_name());
				//selTeamRptList.setTeam_id(TeamVO.getTeam_id());
				selTeamRptList.setTeam_name(TeamVO.getTeam_name());
				team_rpt_reg += Integer.parseInt(selTeamRptList.getRpt_reg());
				team_rpt_sub += Integer.parseInt(selTeamRptList.getRpt_sub());
				team_rpt_end += Integer.parseInt(selTeamRptList.getRpt_end());
				team_rpt_cancel_return += Integer.parseInt(selTeamRptList.getRpt_cancel_return());
				team_rpt_law += Integer.parseInt(selTeamRptList.getRpt_law());
				team_rpt_notend += Integer.parseInt(selTeamRptList.getRpt_notend());
				teamRptList.add(selTeamRptList);
				
			}
			model.addAttribute("teamRptList", teamRptList);*/
				
				/*//1종 합계 구하기 시작
				Suitability12TeamVO Suit12_sum1VO = new Suitability12TeamVO();
				Suit12_sum1VO.setSum_reg_m(""+(k1s_reg_m));
				Suit12_sum1VO.setSum_reg_y(""+(k1s_reg_y));
				Suit12_sum1VO.setSum_endok_m(""+(k1s_endok_m));
				Suit12_sum1VO.setSum_endok_y(""+(k1s_endok_y));
				Suit12_sum1VO.setSum_endno_m(""+(k1s_endno_m));
				Suit12_sum1VO.setSum_endno_y(""+(k1s_endno_y));
				Suit12_sum1VO.setSum_end_sum_m(""+(k1s_end_sum_m));
				Suit12_sum1VO.setSum_end_sum_y(""+(k1s_end_sum_y));
				Suit12_sum1VO.setSum_rid_mi(""+(k1s_rid_mi));
				Suit12_sum1VO.setSum_price_g(""+(k1s_price_g));
				Suit12_sum1VO.setSum_price_f(""+(k1s_price_f));
				Suit12_sum1VO.setSum_price_sum(""+(k1s_price_sum));*/
				//1종 합계 구하기 종료
		
				/*model.addAttribute("Suit12_1List", Suit12_1List);
				model.addAttribute("Suit12_sum1", Suit12_sum1VO);*/
				
			SearchStateVO rpt_List = sqlSession.selectOne("SearchStateMapper.rpt_List", map);
			model.addAttribute("rpt_List" , rpt_List);
			
			SearchStateVO selTeamPtnrRptList = sqlSession.selectOne("SearchStateMapper.selTeamPtnrRptList", map);
			model.addAttribute("selTeamPtnrRptList" , selTeamPtnrRptList);
		
			List <SearchStateVO> selPtnrRptList = sqlSession.selectList("SearchStateMapper.selPtnrRptList", map);
			model.addAttribute("selPtnrRptList", selPtnrRptList);
			
			List <SearchStateVO> selTeamRptList = sqlSession.selectList("SearchStateMapper.selTeamRptList", map);
			model.addAttribute("selTeamRptList", selTeamRptList);		
			
			model.addAttribute("vo2", vo2);
			model.addAttribute("pgid", "search_state");

		return "ls_log/log_index";
	}

	
	/*@RequestMapping(value = "/suitability12_team_excel", method = RequestMethod.POST)
	public void suitability12TeamExcel(Model model, HttpServletRequest request, HttpServletResponse response, String hidtab) {
		//String nowDate=DateUtil.getDate("yyyyMMddHHmmss");

		
		response.setCharacterEncoding("euc-kr");
		response.setHeader("Content-Disposition","attachment;filename=suitability12_team_excel.xls");
	    response.setHeader("Content-Description", "JSP Generated Data");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		out.println(hidtab);
	}*/

}
