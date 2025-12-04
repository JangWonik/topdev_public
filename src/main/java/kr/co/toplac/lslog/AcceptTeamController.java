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

/*
*********************************************************
* Program ID	: LogTeamController // 영문 프로그램 이름 (파일 이름 가능)
* Program Name	: // 국문 프로그램 이름 (파일 이름 가능)
* Description	: // 간략한 설명
* Author		: rojaiho // 개발자 이름
* Date			: 2015.12.30.// 최초 작성일
* Update		: // 수정일 + 수정 요청자(있는 경우) + 수정 내용
*********************************************************
*/
@Controller
public class AcceptTeamController {
	
	private static final Logger logger = LoggerFactory.getLogger(RegIgMonthController.class);

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
	@RequestMapping(value = "/accept_team", method = RequestMethod.GET)
	public String acceptTeam(Model model, HttpServletRequest request, AcceptTeamViewVO vo2, String ig_id, String rid) {
		String viewName = acceptTeamPost(model, request, vo2, rid);
		return viewName;
	}

	@RequestMapping(value = "/accept_team", method = RequestMethod.POST)
	public String acceptTeamPost(Model model, HttpServletRequest request, AcceptTeamViewVO vo2, String rid) {
		
		//날짜만들기 시작
		String fromdate = vo2.getViewFromDate();
		String todate = vo2.getViewToDate();
		Calendar today = Calendar.getInstance();
		int dateInt = today.get(Calendar.DATE);
		int monthInt = today.get(Calendar.MONTH) + 1;
		int yearInt = today.get(Calendar.YEAR);
		int fromDateInt = 16, fromMonthInt = 0, fromYearInt = yearInt;
		int toDateInt = 16, toMonthInt = 0, toYearInt = yearInt;
		if(fromdate == null || "".equals(fromdate)){
			if(dateInt < 16){
				fromMonthInt = monthInt - 2;
			}else if(dateInt >= 16){
				fromMonthInt = monthInt - 1;
			}
			if(fromMonthInt == 0){
				fromMonthInt = 12;
				fromYearInt--;
			}
			fromdate = "" + fromYearInt +"-"+ ((fromMonthInt < 10)? "0"+fromMonthInt : fromMonthInt) +"-"+ fromDateInt;
		}
		if(todate == null || "".equals(todate)){
			if(dateInt < 16){
				toMonthInt = monthInt - 1;
			}else if(dateInt >= 16){
				toMonthInt = monthInt;
			}
			if(toMonthInt == 13){
				toMonthInt = 1;
				toYearInt++;
			}
			todate = "" + toYearInt +"-"+ ((toMonthInt < 10)? "0"+toMonthInt : toMonthInt) +"-"+ toDateInt;
		}
		
		int fromAccumYear = Integer.parseInt(fromdate.substring(0, 4));
		int fromAccumMonth = Integer.parseInt(fromdate.substring(5, 7));
		int toAccumYear = Integer.parseInt(todate.substring(0, 4));
		if(fromAccumMonth < 12){
			fromAccumYear--;
		}
		String fromYear = fromAccumYear + "12" + "16";
		String toYear = toAccumYear + "12" + "16";
		int year = Integer.parseInt(todate.substring(0, 4));
		int month = Integer.parseInt(todate.substring(5, 7));
		int day = dateInt;
		int s_year = 0;
		String tmpYdayF = "";
		String tmpYdayT = "";
		String tmpMdayF = "";
		String tmpMdayT = "";

		if(month > 12){
			year = year+1;
			month = month - 12;
		}
		if(month >= 12 & day >= 16){
			s_year = year;	
		}else{
			s_year = year -1;
		}
		
		if(month < 10 & day < 10){
			tmpYdayF = s_year +"12" + "16";
			tmpYdayT = year + "0" + month + "0" + (day+1);
			tmpMdayF = year +"0" + (month-1) + "0" + day;
			tmpMdayT = year + "0" + month + "0" + (day+1);
		}else if(month < 10){
			tmpYdayF = s_year +"12" + "16";
			tmpYdayT = year + "0" + month + (day+1);
			tmpMdayF = year +"0" + (month-1) + day;
			tmpMdayT = year + "0" + month + (day+1);
		}else if(day < 10){
			tmpYdayF = s_year +"12" + "16";
			tmpYdayT = year + month + "0" + (day+1);
			tmpMdayF = year + (month-1) + "0" + day;
			tmpMdayT = year + month + "0" + (day+1);
		}
		
		
		model.addAttribute("year",year);
		model.addAttribute("month",month);
		model.addAttribute("tmpYdayF",tmpYdayF);
		model.addAttribute("tmpYdayT",tmpYdayT);
		model.addAttribute("tmpMdayF",tmpMdayF);
		model.addAttribute("tmpMdayT",tmpMdayT);
		
		
		//날짜만들기 종료
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fromdate", fromdate);
		map.put("todate", todate);
		map.put("fromYear", fromYear);
		map.put("toYear", toYear);
		map.put("tmpYdayF", tmpYdayF);
		map.put("tmpYdayT", tmpYdayT);
		map.put("tmpMdayF", tmpMdayF);
		map.put("tmpMdayT", tmpMdayT);
		
		model.addAttribute("tmpYdayF", tmpYdayF);
		model.addAttribute("tmpYdayT", tmpYdayT);
		model.addAttribute("tmpMdayF", tmpMdayF);
		model.addAttribute("tmpMdayT", tmpMdayT);
		model.addAttribute("dateInt", dateInt);
		model.addAttribute("monthInt", monthInt);
		model.addAttribute("fromdate", fromdate);
		model.addAttribute("todate", todate);
		model.addAttribute("fromYear", fromYear);
		model.addAttribute("toYear", toYear);
		model.addAttribute("toAccumYear", toAccumYear);
		model.addAttribute("toMonthInt", todate.substring(5, 7));
		
		//일자 사이즈 구하기
		
				List<AcceptTeamVO> dayList = new ArrayList<AcceptTeamVO>();
				dayList = sqlSession.selectList("AcceptTeamMapper.day_list", map);
		
				int dayListSize = dayList.size();
				model.addAttribute("dayListSize", dayListSize);
				
				
		
		int s_day = 0;
		int s_month = 0;
		String s_tmpFday = "";
		String s_tmpTday = "";
				
		for(int i=1; i<=dayListSize; i++){
			s_day =  day + i;
			if(s_day > dayListSize){
				s_day = s_day - dayListSize;
				s_month = month;
			}else{
				s_month = month-1;
			}
			if(s_month < 10){
				s_tmpFday = ""+ year + "0" + (s_month-1) + s_day;
				s_tmpTday = ""+ year + "0" + s_month + (s_day+1);
			}
			if(s_day < 10){
				s_tmpFday = ""+ year + (s_month-1) + "0" + s_day;
				s_tmpTday = ""+ year + s_month + "0" + (s_day+1);
			}
			
		}
		
		map.put("s_tmpFday", s_tmpFday);
		map.put("s_tmpTday", s_tmpTday);
		
				
		//1종 변수 설정
		String ig_id = "";
		String k1s_rid = "";
		String reg_date = "";
		int k1s_rid_m = 0;
		int k1s_rid_y = 0;
		int k1s_rid_sum_y = 0;
		int k1s_rid_mi = 0;
		int k1s_rid_sum = 0;
		int k1s_rid1 = 0;
		int k1s_rid2 = 0;
		int k1s_rid3 = 0;
		int k1s_rid4 = 0;
		int k1s_rid5 = 0;
		int k1s_rid6 = 0;
		int k1s_rid7 = 0;
		int k1s_rid8 = 0;
		int k1s_rid9 = 0;
		int k1s_rid10 = 0;
		int k1s_rid11 = 0;
		int k1s_rid12 = 0;
		int k1s_rid13 = 0;
		int k1s_rid14 = 0;
		int k1s_rid15 = 0;
		int k1s_rid16 = 0;
		int k1s_rid17 = 0;
		int k1s_rid18 = 0;
		int k1s_rid19 = 0;
		int k1s_rid20 = 0;
		int k1s_rid21 = 0;
		int k1s_rid22 = 0;
		int k1s_rid23 = 0;
		int k1s_rid24 = 0;
		int k1s_rid25 = 0;
		int k1s_rid26 = 0;
		int k1s_rid27 = 0;
		int k1s_rid28 = 0;
		int k1s_rid29 = 0;
		int k1s_rid30 = 0;
		int k1s_rid31 = 0;
		//1종 소계 변수 선언 종료
		
		
			List<AcceptTeamVO> A_T1List = new ArrayList<AcceptTeamVO>();
			A_T1List = sqlSession.selectList("AcceptTeamMapper.Accept_T1");
				
			List<AcceptTeamVO> Accept_T1List = new ArrayList<AcceptTeamVO>();
			
				for(int i = 0; i < A_T1List.size(); i++){
					AcceptTeamVO accept_T1VO = A_T1List.get(i);
					String tmpTI = accept_T1VO.getTeam_id();
					
					map.put("tmpTI", tmpTI);
					//1종 log 조회 Start
					AcceptTeamVO Accept_1List = sqlSession.selectOne("AcceptTeamMapper.Accept_T1List", map);
					//1종 log 조회 End
					Accept_1List.setTeam_id(accept_T1VO.getTeam_id());
					Accept_1List.setTeam_name(accept_T1VO.getTeam_name());
					k1s_rid_sum += Integer.parseInt(Accept_1List.getRid_sum());
					k1s_rid_sum_y += Integer.parseInt(Accept_1List.getRid_sum_y());
					k1s_rid_m += Integer.parseInt(Accept_1List.getRid_m());
					k1s_rid_y += Integer.parseInt(Accept_1List.getRid_y());
					k1s_rid_mi += Integer.parseInt(Accept_1List.getRid_mi());
					k1s_rid1 += Integer.parseInt(Accept_1List.getRid1());
					k1s_rid2 += Integer.parseInt(Accept_1List.getRid2());
					k1s_rid3 += Integer.parseInt(Accept_1List.getRid3());
					k1s_rid4 += Integer.parseInt(Accept_1List.getRid4());
					k1s_rid5 += Integer.parseInt(Accept_1List.getRid5());
					k1s_rid6 += Integer.parseInt(Accept_1List.getRid6());
					k1s_rid7 += Integer.parseInt(Accept_1List.getRid7());
					k1s_rid8 += Integer.parseInt(Accept_1List.getRid8());
					k1s_rid9 += Integer.parseInt(Accept_1List.getRid9());
					k1s_rid10 += Integer.parseInt(Accept_1List.getRid10());
					k1s_rid11 += Integer.parseInt(Accept_1List.getRid11());
					k1s_rid12 += Integer.parseInt(Accept_1List.getRid12());
					k1s_rid13 += Integer.parseInt(Accept_1List.getRid13());
					k1s_rid14 += Integer.parseInt(Accept_1List.getRid14());
					k1s_rid15 += Integer.parseInt(Accept_1List.getRid15());
					k1s_rid16 += Integer.parseInt(Accept_1List.getRid16());
					k1s_rid17 += Integer.parseInt(Accept_1List.getRid17());
					k1s_rid18 += Integer.parseInt(Accept_1List.getRid18());
					k1s_rid19 += Integer.parseInt(Accept_1List.getRid19());
					k1s_rid20 += Integer.parseInt(Accept_1List.getRid20());
					k1s_rid21 += Integer.parseInt(Accept_1List.getRid21());
					k1s_rid22 += Integer.parseInt(Accept_1List.getRid22());
					k1s_rid23 += Integer.parseInt(Accept_1List.getRid23());
					k1s_rid24 += Integer.parseInt(Accept_1List.getRid24());
					k1s_rid25 += Integer.parseInt(Accept_1List.getRid25());
					k1s_rid26 += Integer.parseInt(Accept_1List.getRid26());
					k1s_rid27 += Integer.parseInt(Accept_1List.getRid27());
					k1s_rid28 += Integer.parseInt(Accept_1List.getRid28());
					k1s_rid29 += Integer.parseInt(Accept_1List.getRid29());
					k1s_rid30 += Integer.parseInt(Accept_1List.getRid30());
					k1s_rid31 += Integer.parseInt(Accept_1List.getRid31());
					Accept_T1List.add(Accept_1List);
					}
				
				
				AcceptTeamVO accept_sum1VO = new AcceptTeamVO();
				accept_sum1VO.setSum_rid1(""+(k1s_rid1));
				accept_sum1VO.setSum_rid2(""+(k1s_rid2));
				accept_sum1VO.setSum_rid3(""+(k1s_rid3));
				accept_sum1VO.setSum_rid4(""+(k1s_rid4));
				accept_sum1VO.setSum_rid5(""+(k1s_rid5));
				accept_sum1VO.setSum_rid6(""+(k1s_rid6));
				accept_sum1VO.setSum_rid7(""+(k1s_rid7));
				accept_sum1VO.setSum_rid8(""+(k1s_rid8));
				accept_sum1VO.setSum_rid9(""+(k1s_rid9));
				accept_sum1VO.setSum_rid10(""+(k1s_rid10));
				accept_sum1VO.setSum_rid11(""+(k1s_rid11));
				accept_sum1VO.setSum_rid12(""+(k1s_rid12));
				accept_sum1VO.setSum_rid13(""+(k1s_rid13));
				accept_sum1VO.setSum_rid14(""+(k1s_rid14));
				accept_sum1VO.setSum_rid15(""+(k1s_rid15));
				accept_sum1VO.setSum_rid16(""+(k1s_rid16));
				accept_sum1VO.setSum_rid17(""+(k1s_rid17));
				accept_sum1VO.setSum_rid18(""+(k1s_rid18));
				accept_sum1VO.setSum_rid19(""+(k1s_rid19));
				accept_sum1VO.setSum_rid20(""+(k1s_rid20));
				accept_sum1VO.setSum_rid21(""+(k1s_rid21));
				accept_sum1VO.setSum_rid22(""+(k1s_rid22));
				accept_sum1VO.setSum_rid23(""+(k1s_rid23));
				accept_sum1VO.setSum_rid24(""+(k1s_rid24));
				accept_sum1VO.setSum_rid25(""+(k1s_rid25));
				accept_sum1VO.setSum_rid26(""+(k1s_rid26));
				accept_sum1VO.setSum_rid27(""+(k1s_rid27));
				accept_sum1VO.setSum_rid28(""+(k1s_rid28));
				accept_sum1VO.setSum_rid29(""+(k1s_rid29));
				accept_sum1VO.setSum_rid30(""+(k1s_rid30));
				accept_sum1VO.setSum_rid31(""+(k1s_rid31));
				accept_sum1VO.setSum_rid_sum(""+(k1s_rid_sum));
				accept_sum1VO.setSum_rid_sum_y(""+(k1s_rid_sum_y));
				accept_sum1VO.setSum_rid_m(""+(k1s_rid_m));
				accept_sum1VO.setSum_rid_y(""+(k1s_rid_y));	
				accept_sum1VO.setSum_rid_mi(""+(k1s_rid_mi));
				
				model.addAttribute("Accept_T1List", Accept_T1List);
				model.addAttribute("accept_sum1", accept_sum1VO);
				
				//4종 변수 설정
				int k4s_rid1 = 0;
				int k4s_rid2 = 0;
				int k4s_rid3 = 0;
				int k4s_rid4 = 0;
				int k4s_rid5 = 0;
				int k4s_rid6 = 0;
				int k4s_rid7 = 0;
				int k4s_rid8 = 0;
				int k4s_rid9 = 0;
				int k4s_rid10 = 0;
				int k4s_rid11 = 0;
				int k4s_rid12 = 0;
				int k4s_rid13 = 0;
				int k4s_rid14 = 0;
				int k4s_rid15 = 0;
				int k4s_rid16 = 0;
				int k4s_rid17 = 0;
				int k4s_rid18 = 0;
				int k4s_rid19 = 0;
				int k4s_rid20 = 0;
				int k4s_rid21 = 0;
				int k4s_rid22 = 0;
				int k4s_rid23 = 0;
				int k4s_rid24 = 0;
				int k4s_rid25 = 0;
				int k4s_rid26 = 0;
				int k4s_rid27 = 0;
				int k4s_rid28 = 0;
				int k4s_rid29 = 0;
				int k4s_rid30 = 0;
				int k4s_rid31 = 0;
				int k4s_rid_sum = 0;
				int k4s_rid_sum_y = 0;
				int k4s_rid_m = 0;
				int k4s_rid_y = 0;
				int k4s_rid_mi = 0;
				//4종 변수 설정 종료
				
				List<AcceptTeamVO> A_T4List = new ArrayList<AcceptTeamVO>();
				A_T4List = sqlSession.selectList("AcceptTeamMapper.Accept_T4");
					
				List<AcceptTeamVO> Accept_T4List = new ArrayList<AcceptTeamVO>();
				
					for(int i = 0; i < A_T4List.size(); i++){
						AcceptTeamVO accept_T4VO = A_T4List.get(i);
						String tmpTI4 = accept_T4VO.getTeam_id();
						
						map.put("tmpTI4", tmpTI4);
						//4종 log 조회 Start
						AcceptTeamVO Accept_4List = sqlSession.selectOne("AcceptTeamMapper.Accept_T4List", map);
						//4종 log 조회 End
						Accept_4List.setTeam_id(accept_T4VO.getTeam_id());
						Accept_4List.setTeam_name(accept_T4VO.getTeam_name());
						k4s_rid_sum += Integer.parseInt(Accept_4List.getRid_sum());
						k4s_rid_sum_y += Integer.parseInt(Accept_4List.getRid_sum_y());
						k4s_rid_m += Integer.parseInt(Accept_4List.getRid_m());
						k4s_rid_y += Integer.parseInt(Accept_4List.getRid_y());
						k4s_rid_mi += Integer.parseInt(Accept_4List.getRid_mi());
						k4s_rid1 += Integer.parseInt(Accept_4List.getRid1());
						k4s_rid2 += Integer.parseInt(Accept_4List.getRid2());
						k4s_rid3 += Integer.parseInt(Accept_4List.getRid3());
						k4s_rid4 += Integer.parseInt(Accept_4List.getRid4());
						k4s_rid5 += Integer.parseInt(Accept_4List.getRid5());
						k4s_rid6 += Integer.parseInt(Accept_4List.getRid6());
						k4s_rid7 += Integer.parseInt(Accept_4List.getRid7());
						k4s_rid8 += Integer.parseInt(Accept_4List.getRid8());
						k4s_rid9 += Integer.parseInt(Accept_4List.getRid9());
						k4s_rid10 += Integer.parseInt(Accept_4List.getRid10());
						k4s_rid11 += Integer.parseInt(Accept_4List.getRid11());
						k4s_rid12 += Integer.parseInt(Accept_4List.getRid12());
						k4s_rid13 += Integer.parseInt(Accept_4List.getRid13());
						k4s_rid14 += Integer.parseInt(Accept_4List.getRid14());
						k4s_rid15 += Integer.parseInt(Accept_4List.getRid15());
						k4s_rid16 += Integer.parseInt(Accept_4List.getRid16());
						k4s_rid17 += Integer.parseInt(Accept_4List.getRid17());
						k4s_rid18 += Integer.parseInt(Accept_4List.getRid18());
						k4s_rid19 += Integer.parseInt(Accept_4List.getRid19());
						k4s_rid20 += Integer.parseInt(Accept_4List.getRid20());
						k4s_rid21 += Integer.parseInt(Accept_4List.getRid21());
						k4s_rid22 += Integer.parseInt(Accept_4List.getRid22());
						k4s_rid23 += Integer.parseInt(Accept_4List.getRid23());
						k4s_rid24 += Integer.parseInt(Accept_4List.getRid24());
						k4s_rid25 += Integer.parseInt(Accept_4List.getRid25());
						k4s_rid26 += Integer.parseInt(Accept_4List.getRid26());
						k4s_rid27 += Integer.parseInt(Accept_4List.getRid27());
						k4s_rid28 += Integer.parseInt(Accept_4List.getRid28());
						k4s_rid29 += Integer.parseInt(Accept_4List.getRid29());
						k4s_rid30 += Integer.parseInt(Accept_4List.getRid30());
						k4s_rid31 += Integer.parseInt(Accept_4List.getRid31());
						Accept_T4List.add(Accept_4List);
						}
					
					
					AcceptTeamVO accept_sum4VO = new AcceptTeamVO();
					accept_sum4VO.setSum_rid1(""+(k4s_rid1));
					accept_sum4VO.setSum_rid2(""+(k4s_rid2));
					accept_sum4VO.setSum_rid3(""+(k4s_rid3));
					accept_sum4VO.setSum_rid4(""+(k4s_rid4));
					accept_sum4VO.setSum_rid5(""+(k4s_rid5));
					accept_sum4VO.setSum_rid6(""+(k4s_rid6));
					accept_sum4VO.setSum_rid7(""+(k4s_rid7));
					accept_sum4VO.setSum_rid8(""+(k4s_rid8));
					accept_sum4VO.setSum_rid9(""+(k4s_rid9));
					accept_sum4VO.setSum_rid10(""+(k4s_rid10));
					accept_sum4VO.setSum_rid11(""+(k4s_rid11));
					accept_sum4VO.setSum_rid12(""+(k4s_rid12));
					accept_sum4VO.setSum_rid13(""+(k4s_rid13));
					accept_sum4VO.setSum_rid14(""+(k4s_rid14));
					accept_sum4VO.setSum_rid15(""+(k4s_rid15));
					accept_sum4VO.setSum_rid16(""+(k4s_rid16));
					accept_sum4VO.setSum_rid17(""+(k4s_rid17));
					accept_sum4VO.setSum_rid18(""+(k4s_rid18));
					accept_sum4VO.setSum_rid19(""+(k4s_rid19));
					accept_sum4VO.setSum_rid20(""+(k4s_rid20));
					accept_sum4VO.setSum_rid21(""+(k4s_rid21));
					accept_sum4VO.setSum_rid22(""+(k4s_rid22));
					accept_sum4VO.setSum_rid23(""+(k4s_rid23));
					accept_sum4VO.setSum_rid24(""+(k4s_rid24));
					accept_sum4VO.setSum_rid25(""+(k4s_rid25));
					accept_sum4VO.setSum_rid26(""+(k4s_rid26));
					accept_sum4VO.setSum_rid27(""+(k4s_rid27));
					accept_sum4VO.setSum_rid28(""+(k4s_rid28));
					accept_sum4VO.setSum_rid29(""+(k4s_rid29));
					accept_sum4VO.setSum_rid30(""+(k4s_rid30));
					accept_sum4VO.setSum_rid31(""+(k4s_rid31));
					accept_sum4VO.setSum_rid_sum(""+(k4s_rid_sum));
					accept_sum4VO.setSum_rid_sum_y(""+(k4s_rid_sum_y));
					accept_sum4VO.setSum_rid_m(""+(k4s_rid_m));
					accept_sum4VO.setSum_rid_y(""+(k4s_rid_y));	
					accept_sum4VO.setSum_rid_mi(""+(k4s_rid_mi));
				
					AcceptTeamVO accept_sum14VO = new AcceptTeamVO();
					accept_sum14VO.setSum_rid1(""+(k1s_rid1 + k4s_rid1));
					accept_sum14VO.setSum_rid2(""+(k1s_rid2 + k4s_rid2));
					accept_sum14VO.setSum_rid3(""+(k1s_rid3 + k4s_rid3));
					accept_sum14VO.setSum_rid4(""+(k1s_rid4 + k4s_rid4));
					accept_sum14VO.setSum_rid5(""+(k1s_rid5 + k4s_rid5));
					accept_sum14VO.setSum_rid6(""+(k1s_rid6 + k4s_rid6));
					accept_sum14VO.setSum_rid7(""+(k1s_rid7 + k4s_rid7));
					accept_sum14VO.setSum_rid8(""+(k1s_rid8 + k4s_rid8));
					accept_sum14VO.setSum_rid9(""+(k1s_rid9 + k4s_rid9));
					accept_sum14VO.setSum_rid10(""+(k1s_rid10 + k4s_rid10));
					accept_sum14VO.setSum_rid11(""+(k1s_rid11 + k4s_rid11));
					accept_sum14VO.setSum_rid12(""+(k1s_rid12 + k4s_rid12));
					accept_sum14VO.setSum_rid13(""+(k1s_rid13 + k4s_rid13));
					accept_sum14VO.setSum_rid14(""+(k1s_rid14 + k4s_rid14));
					accept_sum14VO.setSum_rid15(""+(k1s_rid15 + k4s_rid15));
					accept_sum14VO.setSum_rid16(""+(k1s_rid16 + k4s_rid16));
					accept_sum14VO.setSum_rid17(""+(k1s_rid17 + k4s_rid17));
					accept_sum14VO.setSum_rid18(""+(k1s_rid18 + k4s_rid18));
					accept_sum14VO.setSum_rid19(""+(k1s_rid19 + k4s_rid19));
					accept_sum14VO.setSum_rid20(""+(k1s_rid20 + k4s_rid20));
					accept_sum14VO.setSum_rid21(""+(k1s_rid21 + k4s_rid21));
					accept_sum14VO.setSum_rid22(""+(k1s_rid22 + k4s_rid22));
					accept_sum14VO.setSum_rid23(""+(k1s_rid23 + k4s_rid23));
					accept_sum14VO.setSum_rid24(""+(k1s_rid24 + k4s_rid24));
					accept_sum14VO.setSum_rid25(""+(k1s_rid25 + k4s_rid25));
					accept_sum14VO.setSum_rid26(""+(k1s_rid26 + k4s_rid26));
					accept_sum14VO.setSum_rid27(""+(k1s_rid27 + k4s_rid27));
					accept_sum14VO.setSum_rid28(""+(k1s_rid28 + k4s_rid28));
					accept_sum14VO.setSum_rid29(""+(k1s_rid29 + k4s_rid29));
					accept_sum14VO.setSum_rid30(""+(k1s_rid30 + k4s_rid30));
					accept_sum14VO.setSum_rid31(""+(k1s_rid31 + k4s_rid31));
					accept_sum14VO.setSum_rid_sum(""+(k1s_rid_sum + k4s_rid_sum));
					accept_sum14VO.setSum_rid_sum_y(""+(k1s_rid_sum_y + k4s_rid_sum_y));
					accept_sum14VO.setSum_rid_m(""+(k1s_rid_m + k4s_rid_m));
					accept_sum14VO.setSum_rid_y(""+(k1s_rid_y + k4s_rid_y));	
					accept_sum14VO.setSum_rid_mi(""+(k1s_rid_mi + k4s_rid_mi));	
					
				model.addAttribute("vo2", vo2);
				model.addAttribute("accept_sum4", accept_sum4VO);
				model.addAttribute("accept_sum14", accept_sum14VO);
				model.addAttribute("Accept_T4List", Accept_T4List);
				model.addAttribute("pgid", "accept_team");

		return "ls_log/log_index";
	}

	
	
	@RequestMapping(value = "/accept_team_excel", method = RequestMethod.POST)
	public void acceptTeamExcel(Model model, HttpServletRequest request, HttpServletResponse response, String hidtab) {
		//String nowDate=DateUtil.getDate("yyyyMMddHHmmss");

		
		response.setCharacterEncoding("euc-kr");
		response.setHeader("Content-Disposition","attachment;filename=accept_team_excel.xls");
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
