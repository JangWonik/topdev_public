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

@Controller
public class SuitabilityMemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(SuitabilityMemberController.class);

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
	@RequestMapping(value = "/suitability_member", method = RequestMethod.GET)
	public String suitabilityMember(Model model, HttpServletRequest request, SuitabilityMemberViewVO vo2, String team_id, String team_name) {
		String viewName = suitabilityMemberPost(model, request, vo2, team_id, team_name);
		return viewName;
	}

	@RequestMapping(value = "/suitability_member", method = RequestMethod.POST)
	public String suitabilityMemberPost(Model model, HttpServletRequest request, SuitabilityMemberViewVO vo2, String team_id, String team_name) {

		//날짜만들기 시작
		String fromdate = vo2.getViewFromDate();
		String todate = vo2.getViewToDate();
		Calendar today = Calendar.getInstance();
		int dateInt = today.get(Calendar.DATE);
		int monthInt = today.get(Calendar.MONTH) + 1;
		int yearInt = today.get(Calendar.YEAR);
		int toDateInt = 1;
		
		if(fromdate != null){
		int s_fromdate = Integer.parseInt(fromdate.substring(5, 7));	
		fromdate = (fromdate.substring(0, 4)) +"-"+ ((s_fromdate < 10)? "0" + s_fromdate : s_fromdate) +"-"+ (fromdate.substring(8, 10));
		}
		
		if(todate != null){
		int s_todate = Integer.parseInt(todate.substring(5, 7));
		int s_fromdate = Integer.parseInt(fromdate.substring(5, 7));
		if(s_todate == s_fromdate){
			todate = (todate.substring(0, 4)) +"-"+ ((s_todate < 9)? "0" + (s_todate+1) : (s_todate+1)) +"-"+ (todate.substring(8, 10));
		}else{
			todate = (todate.substring(0, 4)) +"-"+ ((s_todate < 9)? "0" + s_todate : s_todate) +"-"+ (todate.substring(8, 10));
			}
		}
		
		if(fromdate == null || "".equals(fromdate)){
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
		}
		
		
		String year = todate.substring(0, 4);
		String month = todate.substring(5, 7);
		
		int fromAccumYear = Integer.parseInt(fromdate.substring(0, 4));
		int fromAccumMonth = Integer.parseInt(fromdate.substring(5, 7));
		int toAccumYear = Integer.parseInt(todate.substring(0, 4));
		if(fromAccumMonth < 13){
			fromAccumYear--;
		}
		String fromYear = fromAccumYear + "12" + "16";
		String toYear = toAccumYear + "12" + "16";
		int toMonthInt = (Integer.parseInt(month) -1);
		if(toMonthInt == 0){
			toMonthInt = 12;
		}
		
		model.addAttribute("year",year);
		model.addAttribute("month",month);
		model.addAttribute("todate",todate);
		
		
		
		//날짜만들기 종료
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fromdate", fromdate);
		map.put("todate", todate);
		map.put("tmpTI", team_id);
		map.put("fromYear", fromYear);
		map.put("toYear", toYear);
		
		
		model.addAttribute("fromYear", fromYear);
		model.addAttribute("toYear", toYear);
		model.addAttribute("team_id", team_id);
		model.addAttribute("team_name", team_name);
		model.addAttribute("dateInt", dateInt);
		model.addAttribute("monthInt", monthInt);
		model.addAttribute("fromdate", fromdate);
		model.addAttribute("todate", todate);
		model.addAttribute("toAccumYear", toAccumYear);
		model.addAttribute("toMonthInt", toMonthInt);
		
				
		//1종 변수 설정
		int mb_reg_m = 0;
		int mb_reg_y = 0;
		int mb_endok_m = 0;
		int mb_endok_y = 0;
		int mb_endno_m = 0;
		int mb_endno_y = 0;
		int mb_end_sum_m = 0;
		int mb_end_sum_y = 0;
		int mb_rid_mi = 0;
		int mb_price_g = 0;
		int mb_price_f = 0;
		int mb_price_sum = 0;
		//1종 소계 변수 선언 종료
		
			List<SuitabilityMemberVO> Suit_selList = new ArrayList<SuitabilityMemberVO>();
			Suit_selList = sqlSession.selectList("SuitabilityMemberMapper.Suit_M", map);
			
			List<SuitabilityMemberVO> Suit_MList = new ArrayList<SuitabilityMemberVO>();
				for(int i = 0; i < Suit_selList.size(); i++){
					SuitabilityMemberVO Suit_MVO = Suit_selList.get(i);
					String tmpUI = Suit_MVO.getUser_id();
					map.put("tmpUI", tmpUI);
					//log 조회 Start
					SuitabilityMemberVO Suit_List = sqlSession.selectOne("SuitabilityMemberMapper.Suit_MList", map);
					//log 조회 End
					
					Suit_List.setUser_id(Suit_MVO.getUser_id());
					Suit_List.setName(Suit_MVO.getName());
					mb_reg_m += Integer.parseInt(Suit_List.getReg_m());
					mb_reg_y += Integer.parseInt(Suit_List.getReg_y());
					mb_endok_m += Integer.parseInt(Suit_List.getEndok_m());
					mb_endok_y += Double.parseDouble(Suit_List.getEndok_y());
					mb_endno_m += Integer.parseInt(Suit_List.getEndno_m());
					mb_endno_y += Double.parseDouble(Suit_List.getEndno_y());
					mb_end_sum_m += Integer.parseInt(Suit_List.getEnd_sum_m());
					mb_end_sum_y += Double.parseDouble(Suit_List.getEnd_sum_y());
					mb_rid_mi += Integer.parseInt(Suit_List.getRid_mi());
					mb_price_g += Double.parseDouble(Suit_List.getPrice_g());
					mb_price_f += Integer.parseInt(Suit_List.getPrice_f());
					mb_price_sum += Double.parseDouble(Suit_List.getPrice_sum());
					
					Suit_MList.add(Suit_List);
					}
				
				//데이터 합계 구하기 시작
				SuitabilityMemberVO Suit_MsumVO = new SuitabilityMemberVO();
				Suit_MsumVO.setSum_reg_m(""+(mb_reg_m));
				Suit_MsumVO.setSum_reg_y(""+(mb_reg_y));
				Suit_MsumVO.setSum_endok_m(""+(mb_endok_m));
				Suit_MsumVO.setSum_endok_y(""+(mb_endok_y));
				Suit_MsumVO.setSum_endno_m(""+(mb_endno_m));
				Suit_MsumVO.setSum_endno_y(""+(mb_endno_y));
				Suit_MsumVO.setSum_end_sum_m(""+(mb_end_sum_m));
				Suit_MsumVO.setSum_end_sum_y(""+(mb_end_sum_y));
				Suit_MsumVO.setSum_rid_mi(""+(mb_rid_mi));
				Suit_MsumVO.setSum_price_g(""+(mb_price_g));
				Suit_MsumVO.setSum_price_f(""+(mb_price_f));
				Suit_MsumVO.setSum_price_sum(""+(mb_price_sum));
				//데이터 합계 구하기 종료
				
				model.addAttribute("Suit_MList", Suit_MList);
				model.addAttribute("Suit_Msum", Suit_MsumVO);
				
				
					
					
				model.addAttribute("vo2", vo2);
				model.addAttribute("pgid", "suitability_member");

		return "ls_log/log_index";
	}

	
	
	@RequestMapping(value = "/suitability_member_excel", method = RequestMethod.POST)
	public void suitabilityMemberExcel(Model model, HttpServletRequest request, HttpServletResponse response, String hidtab) {
		
		response.setCharacterEncoding("euc-kr");
		response.setHeader("Content-Disposition","attachment;filename=suitability_member_excel.xls");
	    response.setHeader("Content-Description", "JSP Generated Data");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		out.println(hidtab);
	}

}
