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
public class RegIgMonthController {
	
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
	@RequestMapping(value = "/reg_ig_month", method = RequestMethod.GET)
	public String regIgMonth(Model model, HttpServletRequest request, RegIgViewVO vo2, String ig_id, String rid, int year, int month) {
		String viewName = regIgMonthPost(model, request, vo2, rid, year, month);
		return viewName;
	}

	@RequestMapping(value = "/reg_ig_month", method = RequestMethod.POST)
	public String regIgMonthPost(Model model, HttpServletRequest request, RegIgViewVO vo2, String rid, int year, int month) {
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
		
		String tmpFmonth = "";
		String tmpTmonth = "";
		if(month == 1){
			tmpFmonth = "" + (year-1) +"-"+ 12 +"-"+ 16;
			tmpTmonth = "" + year +"-"+ ((month < 10)? "0"+month : month) +"-"+ 16;
		}
		else if(month == 12){
			tmpFmonth = "" + year +"-"+ 12 +"-"+ 16;
			tmpTmonth = "" + (year+1) +"-"+ "0" + 1 +"-"+ 16;
		}
		
		model.addAttribute("year",year);
		model.addAttribute("month",month);
		
		//날짜만들기 종료
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fromdate", fromdate);
		map.put("todate", todate);
		map.put("fromYear", fromYear);
		map.put("toYear", toYear);
		map.put("tmpFmonth", tmpFmonth);
		map.put("tmpTmonth", tmpTmonth);
		
		model.addAttribute("monthInt", monthInt);
		model.addAttribute("fromdate", fromdate);
		model.addAttribute("todate", todate);
		model.addAttribute("fromYear", fromYear);
		model.addAttribute("toYear", toYear);
		model.addAttribute("toAccumYear", toAccumYear);
		model.addAttribute("toMonthInt", todate.substring(5, 7));
		model.addAttribute("tmpFmonth",tmpFmonth);
		model.addAttribute("tmpTmonth",tmpTmonth);
		
		//일자 사이즈 구하기
				List<RegIgVO> dayList = new ArrayList<RegIgVO>();
				dayList = sqlSession.selectList("RegIgMonthMapper.day_list", map);
		
				int dayListSize = dayList.size();
				model.addAttribute("dayListSize", dayListSize);
				
				//1종 변수 설정
				String ig_id = "";
				String k4s_rid = "";
				String reg_date = "";
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
				int k1s_end_sum = 0;
				int k1s_end1 = 0;
				int k1s_end2 = 0;
				int k1s_end3 = 0;
				int k1s_end4 = 0;
				int k1s_end5 = 0;
				int k1s_end6 = 0;
				int k1s_end7 = 0;
				int k1s_end8 = 0;
				int k1s_end9 = 0;
				int k1s_end10 = 0;
				int k1s_end11 = 0;
				int k1s_end12 = 0;
				int k1s_end13 = 0;
				int k1s_end14 = 0;
				int k1s_end15 = 0;
				int k1s_end16 = 0;
				int k1s_end17 = 0;
				int k1s_end18 = 0;
				int k1s_end19 = 0;
				int k1s_end20 = 0;
				int k1s_end21 = 0;
				int k1s_end22 = 0;
				int k1s_end23 = 0;
				int k1s_end24 = 0;
				int k1s_end25 = 0;
				int k1s_end26 = 0;
				int k1s_end27 = 0;
				int k1s_end28 = 0;
				int k1s_end29 = 0;
				int k1s_end30 = 0;
				int k1s_end31 = 0;
				//1종 소계 변수 선언 종료
				
				
					List<RegIgMonthVO> R_M1List = new ArrayList<RegIgMonthVO>();
					R_M1List = sqlSession.selectList("RegIgMonthMapper.R_M1");
						
					List<RegIgMonthVO> Reg_M1List = new ArrayList<RegIgMonthVO>();
					List<RegIgMonthVO> End_M1List = new ArrayList<RegIgMonthVO>();
					
						for(int i = 0; i < R_M1List.size(); i++){
							RegIgMonthVO R_M1VO = R_M1List.get(i);
							String tmpIg = R_M1VO.getIg_id();
							
							map.put("tmpIg", tmpIg);
							//1종 log 조회 Start
							RegIgMonthVO RM_1List = sqlSession.selectOne("RegIgMonthMapper.R_M1List", map);
							//1종 log 조회 End
							RM_1List.setIg_id(R_M1VO.getIg_id());
							RM_1List.setIg_nick(R_M1VO.getIg_nick());
							k1s_rid_sum += Integer.parseInt(RM_1List.getRid_sum());
							k1s_rid1 += Integer.parseInt(RM_1List.getRid1());
							k1s_rid2 += Integer.parseInt(RM_1List.getRid2());
							k1s_rid3 += Integer.parseInt(RM_1List.getRid3());
							k1s_rid4 += Integer.parseInt(RM_1List.getRid4());
							k1s_rid5 += Integer.parseInt(RM_1List.getRid5());
							k1s_rid6 += Integer.parseInt(RM_1List.getRid6());
							k1s_rid7 += Integer.parseInt(RM_1List.getRid7());
							k1s_rid8 += Integer.parseInt(RM_1List.getRid8());
							k1s_rid9 += Integer.parseInt(RM_1List.getRid9());
							k1s_rid10 += Integer.parseInt(RM_1List.getRid10());
							k1s_rid11 += Integer.parseInt(RM_1List.getRid11());
							k1s_rid12 += Integer.parseInt(RM_1List.getRid12());
							k1s_rid13 += Integer.parseInt(RM_1List.getRid13());
							k1s_rid14 += Integer.parseInt(RM_1List.getRid14());
							k1s_rid15 += Integer.parseInt(RM_1List.getRid15());
							k1s_rid16 += Integer.parseInt(RM_1List.getRid16());
							k1s_rid17 += Integer.parseInt(RM_1List.getRid17());
							k1s_rid18 += Integer.parseInt(RM_1List.getRid18());
							k1s_rid19 += Integer.parseInt(RM_1List.getRid19());
							k1s_rid20 += Integer.parseInt(RM_1List.getRid20());
							k1s_rid21 += Integer.parseInt(RM_1List.getRid21());
							k1s_rid22 += Integer.parseInt(RM_1List.getRid22());
							k1s_rid23 += Integer.parseInt(RM_1List.getRid23());
							k1s_rid24 += Integer.parseInt(RM_1List.getRid24());
							k1s_rid25 += Integer.parseInt(RM_1List.getRid25());
							k1s_rid26 += Integer.parseInt(RM_1List.getRid26());
							k1s_rid27 += Integer.parseInt(RM_1List.getRid27());
							k1s_rid28 += Integer.parseInt(RM_1List.getRid28());
							k1s_rid29 += Integer.parseInt(RM_1List.getRid29());
							k1s_rid30 += Integer.parseInt(RM_1List.getRid30());
							k1s_rid31 += Integer.parseInt(RM_1List.getRid31());
							Reg_M1List.add(RM_1List);
								
							RegIgMonthVO EM_1List = sqlSession.selectOne("RegIgMonthMapper.E_M1List", map);
							k1s_end_sum += Integer.parseInt(EM_1List.getEnd_sum());
							k1s_end1 += Integer.parseInt(EM_1List.getEnd1());
							k1s_end2 += Integer.parseInt(EM_1List.getEnd2());
							k1s_end3 += Integer.parseInt(EM_1List.getEnd3());
							k1s_end4 += Integer.parseInt(EM_1List.getEnd4());
							k1s_end5 += Integer.parseInt(EM_1List.getEnd5());
							k1s_end6 += Integer.parseInt(EM_1List.getEnd6());
							k1s_end7 += Integer.parseInt(EM_1List.getEnd7());
							k1s_end8 += Integer.parseInt(EM_1List.getEnd8());
							k1s_end9 += Integer.parseInt(EM_1List.getEnd9());
							k1s_end10 += Integer.parseInt(EM_1List.getEnd10());
							k1s_end11 += Integer.parseInt(EM_1List.getEnd11());
							k1s_end12 += Integer.parseInt(EM_1List.getEnd12());
							k1s_end13 += Integer.parseInt(EM_1List.getEnd13());
							k1s_end14 += Integer.parseInt(EM_1List.getEnd14());
							k1s_end15 += Integer.parseInt(EM_1List.getEnd15());
							k1s_end16 += Integer.parseInt(EM_1List.getEnd16());
							k1s_end17 += Integer.parseInt(EM_1List.getEnd17());
							k1s_end18 += Integer.parseInt(EM_1List.getEnd18());
							k1s_end19 += Integer.parseInt(EM_1List.getEnd19());
							k1s_end20 += Integer.parseInt(EM_1List.getEnd20());
							k1s_end21 += Integer.parseInt(EM_1List.getEnd21());
							k1s_end22 += Integer.parseInt(EM_1List.getEnd22());
							k1s_end23 += Integer.parseInt(EM_1List.getEnd23());
							k1s_end24 += Integer.parseInt(EM_1List.getEnd24());
							k1s_end25 += Integer.parseInt(EM_1List.getEnd25());
							k1s_end26 += Integer.parseInt(EM_1List.getEnd26());
							k1s_end27 += Integer.parseInt(EM_1List.getEnd17());
							k1s_end28 += Integer.parseInt(EM_1List.getEnd28());
							k1s_end29 += Integer.parseInt(EM_1List.getEnd29());
							k1s_end30 += Integer.parseInt(EM_1List.getEnd30());
							k1s_end31 += Integer.parseInt(EM_1List.getEnd31());
							End_M1List.add(EM_1List);
							}
						
							//1종 합계 구하기 시작
							RegIgMonthVO regend_sum1VO = new RegIgMonthVO();
							regend_sum1VO.setSum_rid1(""+(k1s_rid1));
							regend_sum1VO.setSum_rid2(""+(k1s_rid2));
							regend_sum1VO.setSum_rid3(""+(k1s_rid3));
							regend_sum1VO.setSum_rid4(""+(k1s_rid4));
							regend_sum1VO.setSum_rid5(""+(k1s_rid5));
							regend_sum1VO.setSum_rid6(""+(k1s_rid6));
							regend_sum1VO.setSum_rid7(""+(k1s_rid7));
							regend_sum1VO.setSum_rid8(""+(k1s_rid8));
							regend_sum1VO.setSum_rid9(""+(k1s_rid9));
							regend_sum1VO.setSum_rid10(""+(k1s_rid10));
							regend_sum1VO.setSum_rid11(""+(k1s_rid11));
							regend_sum1VO.setSum_rid12(""+(k1s_rid12));
							regend_sum1VO.setSum_rid13(""+(k1s_rid13));
							regend_sum1VO.setSum_rid14(""+(k1s_rid14));
							regend_sum1VO.setSum_rid15(""+(k1s_rid15));
							regend_sum1VO.setSum_rid16(""+(k1s_rid16));
							regend_sum1VO.setSum_rid17(""+(k1s_rid17));
							regend_sum1VO.setSum_rid18(""+(k1s_rid18));
							regend_sum1VO.setSum_rid19(""+(k1s_rid19));
							regend_sum1VO.setSum_rid20(""+(k1s_rid20));
							regend_sum1VO.setSum_rid21(""+(k1s_rid21));
							regend_sum1VO.setSum_rid22(""+(k1s_rid22));
							regend_sum1VO.setSum_rid23(""+(k1s_rid23));
							regend_sum1VO.setSum_rid24(""+(k1s_rid24));
							regend_sum1VO.setSum_rid25(""+(k1s_rid25));
							regend_sum1VO.setSum_rid26(""+(k1s_rid26));
							regend_sum1VO.setSum_rid27(""+(k1s_rid27));
							regend_sum1VO.setSum_rid28(""+(k1s_rid28));
							regend_sum1VO.setSum_rid29(""+(k1s_rid29));
							regend_sum1VO.setSum_rid30(""+(k1s_rid30));
							regend_sum1VO.setSum_rid31(""+(k1s_rid31));
							regend_sum1VO.setSum_rid_sum(""+k1s_rid_sum);
							
							regend_sum1VO.setSum_end1(""+(k1s_end1));
							regend_sum1VO.setSum_end2(""+(k1s_end2));
							regend_sum1VO.setSum_end3(""+(k1s_end3));
							regend_sum1VO.setSum_end4(""+(k1s_end4));
							regend_sum1VO.setSum_end5(""+(k1s_end5));
							regend_sum1VO.setSum_end6(""+(k1s_end6));
							regend_sum1VO.setSum_end7(""+(k1s_end7));
							regend_sum1VO.setSum_end8(""+(k1s_end8));
							regend_sum1VO.setSum_end9(""+(k1s_end9));
							regend_sum1VO.setSum_end10(""+(k1s_end10));
							regend_sum1VO.setSum_end11(""+(k1s_end11));
							regend_sum1VO.setSum_end12(""+(k1s_end12));
							regend_sum1VO.setSum_end13(""+(k1s_end13));
							regend_sum1VO.setSum_end14(""+(k1s_end14));
							regend_sum1VO.setSum_end15(""+(k1s_end15));
							regend_sum1VO.setSum_end16(""+(k1s_end16));
							regend_sum1VO.setSum_end17(""+(k1s_end17));
							regend_sum1VO.setSum_end18(""+(k1s_end18));
							regend_sum1VO.setSum_end19(""+(k1s_end19));
							regend_sum1VO.setSum_end20(""+(k1s_end20));
							regend_sum1VO.setSum_end21(""+(k1s_end21));
							regend_sum1VO.setSum_end22(""+(k1s_end22));
							regend_sum1VO.setSum_end23(""+(k1s_end23));
							regend_sum1VO.setSum_end24(""+(k1s_end24));
							regend_sum1VO.setSum_end25(""+(k1s_end25));
							regend_sum1VO.setSum_end26(""+(k1s_end26));
							regend_sum1VO.setSum_end27(""+(k1s_end27));
							regend_sum1VO.setSum_end28(""+(k1s_end28));
							regend_sum1VO.setSum_end29(""+(k1s_end29));
							regend_sum1VO.setSum_end30(""+(k1s_end30));
							regend_sum1VO.setSum_end31(""+(k1s_end31));
							regend_sum1VO.setSum_end_sum(""+k1s_end_sum);
							//1종 합계 구하기 종료
							
							model.addAttribute("Reg_M1List", Reg_M1List);
							model.addAttribute("End_M1List", End_M1List);
							model.addAttribute("regend_sum1", regend_sum1VO);
				
				//4종 변수 설정
				int k4s_rid_sum = 0;
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
				int k4s_end_sum = 0;
				int k4s_end1 = 0;
				int k4s_end2 = 0;
				int k4s_end3 = 0;
				int k4s_end4 = 0;
				int k4s_end5 = 0;
				int k4s_end6 = 0;
				int k4s_end7 = 0;
				int k4s_end8 = 0;
				int k4s_end9 = 0;
				int k4s_end10 = 0;
				int k4s_end11 = 0;
				int k4s_end12 = 0;
				int k4s_end13 = 0;
				int k4s_end14 = 0;
				int k4s_end15 = 0;
				int k4s_end16 = 0;
				int k4s_end17 = 0;
				int k4s_end18 = 0;
				int k4s_end19 = 0;
				int k4s_end20 = 0;
				int k4s_end21 = 0;
				int k4s_end22 = 0;
				int k4s_end23 = 0;
				int k4s_end24 = 0;
				int k4s_end25 = 0;
				int k4s_end26 = 0;
				int k4s_end27 = 0;
				int k4s_end28 = 0;
				int k4s_end29 = 0;
				int k4s_end30 = 0;
				int k4s_end31 = 0;
				//4종 소계 변수 선언 종료
				
				
					List<RegIgMonthVO> R_M4List = new ArrayList<RegIgMonthVO>();
					R_M4List = sqlSession.selectList("RegIgMonthMapper.R_M4");
						
					List<RegIgMonthVO> Reg_M4List = new ArrayList<RegIgMonthVO>();
					List<RegIgMonthVO> End_M4List = new ArrayList<RegIgMonthVO>();
					
						for(int i = 0; i < R_M4List.size(); i++){
							RegIgMonthVO R_M4VO = R_M4List.get(i);
							String tmpIg4 = R_M4VO.getIg_id();
							
							map.put("tmpIg4", tmpIg4);
							//4종 log 조회 Start
							RegIgMonthVO RM_4List = sqlSession.selectOne("RegIgMonthMapper.R_M4List", map);
							//4종 log 조회 End
							RM_4List.setIg_id(R_M4VO.getIg_id());
							RM_4List.setIg_nick(R_M4VO.getIg_nick());
							k4s_rid_sum += Integer.parseInt(RM_4List.getRid_sum());
							k4s_rid1 += Integer.parseInt(RM_4List.getRid1());
							k4s_rid2 += Integer.parseInt(RM_4List.getRid2());
							k4s_rid3 += Integer.parseInt(RM_4List.getRid3());
							k4s_rid4 += Integer.parseInt(RM_4List.getRid4());
							k4s_rid5 += Integer.parseInt(RM_4List.getRid5());
							k4s_rid6 += Integer.parseInt(RM_4List.getRid6());
							k4s_rid7 += Integer.parseInt(RM_4List.getRid7());
							k4s_rid8 += Integer.parseInt(RM_4List.getRid8());
							k4s_rid9 += Integer.parseInt(RM_4List.getRid9());
							k4s_rid10 += Integer.parseInt(RM_4List.getRid10());
							k4s_rid11 += Integer.parseInt(RM_4List.getRid11());
							k4s_rid12 += Integer.parseInt(RM_4List.getRid12());
							k4s_rid13 += Integer.parseInt(RM_4List.getRid13());
							k4s_rid14 += Integer.parseInt(RM_4List.getRid14());
							k4s_rid15 += Integer.parseInt(RM_4List.getRid15());
							k4s_rid16 += Integer.parseInt(RM_4List.getRid16());
							k4s_rid17 += Integer.parseInt(RM_4List.getRid17());
							k4s_rid18 += Integer.parseInt(RM_4List.getRid18());
							k4s_rid19 += Integer.parseInt(RM_4List.getRid19());
							k4s_rid20 += Integer.parseInt(RM_4List.getRid20());
							k4s_rid21 += Integer.parseInt(RM_4List.getRid21());
							k4s_rid22 += Integer.parseInt(RM_4List.getRid22());
							k4s_rid23 += Integer.parseInt(RM_4List.getRid23());
							k4s_rid24 += Integer.parseInt(RM_4List.getRid24());
							k4s_rid25 += Integer.parseInt(RM_4List.getRid25());
							k4s_rid26 += Integer.parseInt(RM_4List.getRid26());
							k4s_rid27 += Integer.parseInt(RM_4List.getRid27());
							k4s_rid28 += Integer.parseInt(RM_4List.getRid28());
							k4s_rid29 += Integer.parseInt(RM_4List.getRid29());
							k4s_rid30 += Integer.parseInt(RM_4List.getRid30());
							k4s_rid31 += Integer.parseInt(RM_4List.getRid31());
							Reg_M4List.add(RM_4List);
								
							RegIgMonthVO EM_4List = sqlSession.selectOne("RegIgMonthMapper.E_M4List", map);
							k4s_end_sum += Integer.parseInt(EM_4List.getEnd_sum());
							k4s_end1 += Integer.parseInt(EM_4List.getEnd1());
							k4s_end2 += Integer.parseInt(EM_4List.getEnd2());
							k4s_end3 += Integer.parseInt(EM_4List.getEnd3());
							k4s_end4 += Integer.parseInt(EM_4List.getEnd4());
							k4s_end5 += Integer.parseInt(EM_4List.getEnd5());
							k4s_end6 += Integer.parseInt(EM_4List.getEnd6());
							k4s_end7 += Integer.parseInt(EM_4List.getEnd7());
							k4s_end8 += Integer.parseInt(EM_4List.getEnd8());
							k4s_end9 += Integer.parseInt(EM_4List.getEnd9());
							k4s_end10 += Integer.parseInt(EM_4List.getEnd10());
							k4s_end11 += Integer.parseInt(EM_4List.getEnd11());
							k4s_end12 += Integer.parseInt(EM_4List.getEnd12());
							k4s_end13 += Integer.parseInt(EM_4List.getEnd13());
							k4s_end14 += Integer.parseInt(EM_4List.getEnd14());
							k4s_end15 += Integer.parseInt(EM_4List.getEnd15());
							k4s_end16 += Integer.parseInt(EM_4List.getEnd16());
							k4s_end17 += Integer.parseInt(EM_4List.getEnd17());
							k4s_end18 += Integer.parseInt(EM_4List.getEnd18());
							k4s_end19 += Integer.parseInt(EM_4List.getEnd19());
							k4s_end20 += Integer.parseInt(EM_4List.getEnd20());
							k4s_end21 += Integer.parseInt(EM_4List.getEnd21());
							k4s_end22 += Integer.parseInt(EM_4List.getEnd22());
							k4s_end23 += Integer.parseInt(EM_4List.getEnd23());
							k4s_end24 += Integer.parseInt(EM_4List.getEnd24());
							k4s_end25 += Integer.parseInt(EM_4List.getEnd25());
							k4s_end26 += Integer.parseInt(EM_4List.getEnd26());
							k4s_end27 += Integer.parseInt(EM_4List.getEnd17());
							k4s_end28 += Integer.parseInt(EM_4List.getEnd28());
							k4s_end29 += Integer.parseInt(EM_4List.getEnd29());
							k4s_end30 += Integer.parseInt(EM_4List.getEnd30());
							k4s_end31 += Integer.parseInt(EM_4List.getEnd31());
							End_M4List.add(EM_4List);
							}
						
							//4종 합계 구하기 시작
							RegIgMonthVO regend_sum4VO = new RegIgMonthVO();
							regend_sum4VO.setSum_rid1(""+(k4s_rid1));
							regend_sum4VO.setSum_rid2(""+(k4s_rid2));
							regend_sum4VO.setSum_rid3(""+(k4s_rid3));
							regend_sum4VO.setSum_rid4(""+(k4s_rid4));
							regend_sum4VO.setSum_rid5(""+(k4s_rid5));
							regend_sum4VO.setSum_rid6(""+(k4s_rid6));
							regend_sum4VO.setSum_rid7(""+(k4s_rid7));
							regend_sum4VO.setSum_rid8(""+(k4s_rid8));
							regend_sum4VO.setSum_rid9(""+(k4s_rid9));
							regend_sum4VO.setSum_rid10(""+(k4s_rid10));
							regend_sum4VO.setSum_rid11(""+(k4s_rid11));
							regend_sum4VO.setSum_rid12(""+(k4s_rid12));
							regend_sum4VO.setSum_rid13(""+(k4s_rid13));
							regend_sum4VO.setSum_rid14(""+(k4s_rid14));
							regend_sum4VO.setSum_rid15(""+(k4s_rid15));
							regend_sum4VO.setSum_rid16(""+(k4s_rid16));
							regend_sum4VO.setSum_rid17(""+(k4s_rid17));
							regend_sum4VO.setSum_rid18(""+(k4s_rid18));
							regend_sum4VO.setSum_rid19(""+(k4s_rid19));
							regend_sum4VO.setSum_rid20(""+(k4s_rid20));
							regend_sum4VO.setSum_rid21(""+(k4s_rid21));
							regend_sum4VO.setSum_rid22(""+(k4s_rid22));
							regend_sum4VO.setSum_rid23(""+(k4s_rid23));
							regend_sum4VO.setSum_rid24(""+(k4s_rid24));
							regend_sum4VO.setSum_rid25(""+(k4s_rid25));
							regend_sum4VO.setSum_rid26(""+(k4s_rid26));
							regend_sum4VO.setSum_rid27(""+(k4s_rid27));
							regend_sum4VO.setSum_rid28(""+(k4s_rid28));
							regend_sum4VO.setSum_rid29(""+(k4s_rid29));
							regend_sum4VO.setSum_rid30(""+(k4s_rid30));
							regend_sum4VO.setSum_rid31(""+(k4s_rid31));
							regend_sum4VO.setSum_rid_sum(""+k4s_rid_sum);
							
							RegIgMonthVO endm_sum4VO = new RegIgMonthVO();
							regend_sum4VO.setSum_end1(""+(k4s_end1));
							regend_sum4VO.setSum_end2(""+(k4s_end2));
							regend_sum4VO.setSum_end3(""+(k4s_end3));
							regend_sum4VO.setSum_end4(""+(k4s_end4));
							regend_sum4VO.setSum_end5(""+(k4s_end5));
							regend_sum4VO.setSum_end6(""+(k4s_end6));
							regend_sum4VO.setSum_end7(""+(k4s_end7));
							regend_sum4VO.setSum_end8(""+(k4s_end8));
							regend_sum4VO.setSum_end9(""+(k4s_end9));
							regend_sum4VO.setSum_end10(""+(k4s_end10));
							regend_sum4VO.setSum_end11(""+(k4s_end11));
							regend_sum4VO.setSum_end12(""+(k4s_end12));
							regend_sum4VO.setSum_end13(""+(k4s_end13));
							regend_sum4VO.setSum_end14(""+(k4s_end14));
							regend_sum4VO.setSum_end15(""+(k4s_end15));
							regend_sum4VO.setSum_end16(""+(k4s_end16));
							regend_sum4VO.setSum_end17(""+(k4s_end17));
							regend_sum4VO.setSum_end18(""+(k4s_end18));
							regend_sum4VO.setSum_end19(""+(k4s_end19));
							regend_sum4VO.setSum_end20(""+(k4s_end20));
							regend_sum4VO.setSum_end21(""+(k4s_end21));
							regend_sum4VO.setSum_end22(""+(k4s_end22));
							regend_sum4VO.setSum_end23(""+(k4s_end23));
							regend_sum4VO.setSum_end24(""+(k4s_end24));
							regend_sum4VO.setSum_end25(""+(k4s_end25));
							regend_sum4VO.setSum_end26(""+(k4s_end26));
							regend_sum4VO.setSum_end27(""+(k4s_end27));
							regend_sum4VO.setSum_end28(""+(k4s_end28));
							regend_sum4VO.setSum_end29(""+(k4s_end29));
							regend_sum4VO.setSum_end30(""+(k4s_end30));
							regend_sum4VO.setSum_end31(""+(k4s_end31));
							regend_sum4VO.setSum_end_sum(""+k4s_end_sum);
							//4종 합계 구하기 종료
							
							model.addAttribute("Reg_M4List", Reg_M4List);
							model.addAttribute("End_M4List", End_M4List);
							model.addAttribute("regend_sum4", regend_sum4VO);
							
							//1,4종 합계 구하기 시작
							RegIgMonthVO regend_sum14VO = new RegIgMonthVO();
							regend_sum14VO.setSum_rid1(""+(k1s_rid1 + k4s_rid1));
							regend_sum14VO.setSum_rid2(""+(k1s_rid2 + k4s_rid2));
							regend_sum14VO.setSum_rid3(""+(k1s_rid3 + k4s_rid3));
							regend_sum14VO.setSum_rid4(""+(k1s_rid4 + k4s_rid4));
							regend_sum14VO.setSum_rid5(""+(k1s_rid5 + k4s_rid5));
							regend_sum14VO.setSum_rid6(""+(k1s_rid6 + k4s_rid6));
							regend_sum14VO.setSum_rid7(""+(k1s_rid7 + k4s_rid7));
							regend_sum14VO.setSum_rid8(""+(k1s_rid8 + k4s_rid8));
							regend_sum14VO.setSum_rid9(""+(k1s_rid9 + k4s_rid9));
							regend_sum14VO.setSum_rid10(""+(k1s_rid10 + k4s_rid10));
							regend_sum14VO.setSum_rid11(""+(k1s_rid11 + k4s_rid11));
							regend_sum14VO.setSum_rid12(""+(k1s_rid12 + k4s_rid12));
							regend_sum14VO.setSum_rid13(""+(k1s_rid13 + k4s_rid13));
							regend_sum14VO.setSum_rid14(""+(k1s_rid14 + k4s_rid14));
							regend_sum14VO.setSum_rid15(""+(k1s_rid15 + k4s_rid15));
							regend_sum14VO.setSum_rid16(""+(k1s_rid16 + k4s_rid16));
							regend_sum14VO.setSum_rid17(""+(k1s_rid17 + k4s_rid17));
							regend_sum14VO.setSum_rid18(""+(k1s_rid18 + k4s_rid18));
							regend_sum14VO.setSum_rid19(""+(k1s_rid19 + k4s_rid19));
							regend_sum14VO.setSum_rid20(""+(k1s_rid20 + k4s_rid20));
							regend_sum14VO.setSum_rid21(""+(k1s_rid21 + k4s_rid21));
							regend_sum14VO.setSum_rid22(""+(k1s_rid22 + k4s_rid22));
							regend_sum14VO.setSum_rid23(""+(k1s_rid23 + k4s_rid23));
							regend_sum14VO.setSum_rid24(""+(k1s_rid24 + k4s_rid24));
							regend_sum14VO.setSum_rid25(""+(k1s_rid25 + k4s_rid25));
							regend_sum14VO.setSum_rid26(""+(k1s_rid26 + k4s_rid26));
							regend_sum14VO.setSum_rid27(""+(k1s_rid27 + k4s_rid27));
							regend_sum14VO.setSum_rid28(""+(k1s_rid28 + k4s_rid28));
							regend_sum14VO.setSum_rid29(""+(k1s_rid29 + k4s_rid29));
							regend_sum14VO.setSum_rid30(""+(k1s_rid30 + k4s_rid30));
							regend_sum14VO.setSum_rid31(""+(k1s_rid31 + k4s_rid31));
							regend_sum14VO.setSum_rid_sum(""+(k1s_rid_sum + k4s_rid_sum));
							
							regend_sum14VO.setSum_end1(""+(k1s_end1 + k4s_end1));
							regend_sum14VO.setSum_end2(""+(k1s_end2 + k4s_end2));
							regend_sum14VO.setSum_end3(""+(k1s_end3 + k4s_end3));
							regend_sum14VO.setSum_end4(""+(k1s_end4 + k4s_end4));
							regend_sum14VO.setSum_end5(""+(k1s_end5 + k4s_end5));
							regend_sum14VO.setSum_end6(""+(k1s_end6 + k4s_end6));
							regend_sum14VO.setSum_end7(""+(k1s_end7 + k4s_end7));
							regend_sum14VO.setSum_end8(""+(k1s_end8 + k4s_end8));
							regend_sum14VO.setSum_end9(""+(k1s_end9 + k4s_end9));
							regend_sum14VO.setSum_end10(""+(k1s_end10 + k4s_end10));
							regend_sum14VO.setSum_end11(""+(k1s_end11 + k4s_end11));
							regend_sum14VO.setSum_end12(""+(k1s_end12 + k4s_end12));
							regend_sum14VO.setSum_end13(""+(k1s_end13 + k4s_end13));
							regend_sum14VO.setSum_end14(""+(k1s_end14 + k4s_end14));
							regend_sum14VO.setSum_end15(""+(k1s_end15 + k4s_end15));
							regend_sum14VO.setSum_end16(""+(k1s_end16 + k4s_end16));
							regend_sum14VO.setSum_end17(""+(k1s_end17 + k4s_end17));
							regend_sum14VO.setSum_end18(""+(k1s_end18 + k4s_end18));
							regend_sum14VO.setSum_end19(""+(k1s_end19 + k4s_end19));
							regend_sum14VO.setSum_end20(""+(k1s_end20 + k4s_end20));
							regend_sum14VO.setSum_end21(""+(k1s_end21 + k4s_end21));
							regend_sum14VO.setSum_end22(""+(k1s_end22 + k4s_end22));
							regend_sum14VO.setSum_end23(""+(k1s_end23 + k4s_end23));
							regend_sum14VO.setSum_end24(""+(k1s_end24 + k4s_end24));
							regend_sum14VO.setSum_end25(""+(k1s_end25 + k4s_end25));
							regend_sum14VO.setSum_end26(""+(k1s_end26 + k4s_end26));
							regend_sum14VO.setSum_end27(""+(k1s_end27 + k4s_end27));
							regend_sum14VO.setSum_end28(""+(k1s_end28 + k4s_end28));
							regend_sum14VO.setSum_end29(""+(k1s_end29 + k4s_end29));
							regend_sum14VO.setSum_end30(""+(k1s_end30 + k4s_end30));
							regend_sum14VO.setSum_end31(""+(k1s_end31 + k4s_end31));
							regend_sum14VO.setSum_end_sum(""+(k1s_end_sum + k4s_end_sum));
							//1,4종 합계 구하기 종료
							
						model.addAttribute("vo2", vo2);
						model.addAttribute("regend_sum14", regend_sum14VO);
						model.addAttribute("pgid", "reg_ig_month");

		return "ls_log/log_index";
	}

	private int Regcnt(int i) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	/*@RequestMapping(value = "/reg_ig_excel", method = RequestMethod.POST)
	public void logTeamExcel(Model model, HttpServletRequest request, HttpServletResponse response, String hidtab) {
		//String nowDate=DateUtil.getDate("yyyyMMddHHmmss");

		
		response.setCharacterEncoding("euc-kr");
		response.setHeader("Content-Disposition","attachment;filename=reg_ig_excel_.xls");
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
