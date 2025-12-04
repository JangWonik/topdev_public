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
public class ContractTeamController {
	
	private static final Logger logger = LoggerFactory.getLogger(ContractTeamController.class);

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
	@RequestMapping(value = "/contract_team", method = RequestMethod.GET)
	public String contractTeam(Model model, HttpServletRequest request, ContractTeamViewVO vo2, String ig_id, String rid) {
		String viewName = contractTeamPost(model, request, vo2, rid);
		return viewName;
	}

	@RequestMapping(value = "/contract_team", method = RequestMethod.POST)
	public String contractTeamPost(Model model, HttpServletRequest request, ContractTeamViewVO vo2, String rid) {

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
		todate = (todate.substring(0, 4)) +"-"+ ((s_todate < 9)? "0" + (s_todate+1) : (s_todate+1)) +"-"+ (todate.substring(8, 10));
		}
		
		if(fromdate == null || "".equals(fromdate)){
			if(monthInt == 0){
				monthInt = 12;
				yearInt--;
			}
			fromdate = "" + yearInt +"-"+ ((monthInt < 10)? "0"+monthInt : monthInt) +"-"+ "0" + toDateInt;
			//fromyeardate = "" + yearInt +"-"+ ((monthInt < 10)? "0"+monthInt : monthInt) +"-"+ "0" + toDateInt;
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
		map.put("fromYear", fromYear);
		map.put("toYear", toYear);
		
		
		model.addAttribute("fromYear", fromYear);
		model.addAttribute("toYear", toYear);
		model.addAttribute("dateInt", dateInt);
		model.addAttribute("monthInt", monthInt);
		model.addAttribute("fromdate", fromdate);
		model.addAttribute("todate", todate);
		model.addAttribute("toAccumYear", toAccumYear);
		model.addAttribute("toMonthInt", toMonthInt);
		
		//1종 변수 설정
		int k1s_reg_m = 0;
		int k1s_reg_y = 0;
		int k1s_endok_m = 0;
		int k1s_endok_y = 0;
		int k1s_endno_m = 0;
		int k1s_endno_y = 0;
		int k1s_end_sum_m = 0;
		int k1s_end_sum_y = 0;
		int k1s_rid_mi = 0;
		int k1s_price_g = 0;
		int k1s_price_f = 0;
		int k1s_price_sum = 0;
		//1종 소계 변수 선언 종료
		
			List<ContractTeamVO> ConS_T1List = new ArrayList<ContractTeamVO>();
			ConS_T1List = sqlSession.selectList("ContractTeamMapper.ConS_T1", map);
			
			List<ContractTeamVO> ConS_1List = new ArrayList<ContractTeamVO>();
				for(int i = 0; i < ConS_T1List.size(); i++){
					ContractTeamVO ConS_T1VO = ConS_T1List.get(i);
					String tmpTI = ConS_T1VO.getTeam_id();
					map.put("tmpTI", tmpTI);
					//1종 log 조회 Start
					ContractTeamVO ConS_List = sqlSession.selectOne("ContractTeamMapper.ConS_T1List", map);
					//1종 log 조회 End
					
					ConS_List.setTeam_id(ConS_T1VO.getTeam_id());
					ConS_List.setTeam_name(ConS_T1VO.getTeam_name());
					k1s_reg_m += Integer.parseInt(ConS_List.getReg_m());
					k1s_reg_y += Integer.parseInt(ConS_List.getReg_y());
					k1s_endok_m += Integer.parseInt(ConS_List.getEndok_m());
					k1s_endok_y += Double.parseDouble(ConS_List.getEndok_y());
					k1s_endno_m += Integer.parseInt(ConS_List.getEndno_m());
					k1s_endno_y += Double.parseDouble(ConS_List.getEndno_y());
					k1s_end_sum_m += Integer.parseInt(ConS_List.getEnd_sum_m());
					k1s_end_sum_y += Double.parseDouble(ConS_List.getEnd_sum_y());
					k1s_rid_mi += Integer.parseInt(ConS_List.getRid_mi());
					k1s_price_g += Double.parseDouble(ConS_List.getPrice_g());
					k1s_price_f += Double.parseDouble(ConS_List.getPrice_f());
					k1s_price_sum += Double.parseDouble(ConS_List.getPrice_sum());
					
					ConS_1List.add(ConS_List);
					}
				
				//1종 데이터 합계 구하기 시작
				ContractTeamVO ConS_sum1VO = new ContractTeamVO();
				ConS_sum1VO.setSum_reg_m(""+(k1s_reg_m));
				ConS_sum1VO.setSum_reg_y(""+(k1s_reg_y));
				ConS_sum1VO.setSum_endok_m(""+(k1s_endok_m));
				ConS_sum1VO.setSum_endok_y(""+(k1s_endok_y));
				ConS_sum1VO.setSum_endno_m(""+(k1s_endno_m));
				ConS_sum1VO.setSum_endno_y(""+(k1s_endno_y));
				ConS_sum1VO.setSum_end_sum_m(""+(k1s_end_sum_m));
				ConS_sum1VO.setSum_end_sum_y(""+(k1s_end_sum_y));
				ConS_sum1VO.setSum_rid_mi(""+(k1s_rid_mi));
				ConS_sum1VO.setSum_price_g(""+(k1s_price_g));
				ConS_sum1VO.setSum_price_f(""+(k1s_price_f));
				ConS_sum1VO.setSum_price_sum(""+(k1s_price_sum));
				//1종 데이터 합계 구하기 종료
				
				model.addAttribute("ConS_1List", ConS_1List);
				model.addAttribute("ConS_sum1", ConS_sum1VO);
				
				//4종 변수 설정
				int k4s_reg_m = 0;
				int k4s_reg_y = 0;
				int k4s_endok_m = 0;
				int k4s_endok_y = 0;
				int k4s_endno_m = 0;
				int k4s_endno_y = 0;
				int k4s_end_sum_m = 0;
				int k4s_end_sum_y = 0;
				int k4s_rid_mi = 0;
				int k4s_price_g = 0;
				int k4s_price_f = 0;
				int k4s_price_sum = 0;
				//4종 소계 변수 선언 종료
				
					List<ContractTeamVO> ConS_T4List = new ArrayList<ContractTeamVO>();
					ConS_T4List = sqlSession.selectList("ContractTeamMapper.ConS_T4", map);
					
					List<ContractTeamVO> ConS_4List = new ArrayList<ContractTeamVO>();
						for(int i = 0; i < ConS_T4List.size(); i++){
							ContractTeamVO ConS_T4VO = ConS_T4List.get(i);
							String tmpTI4 = ConS_T4VO.getTeam_id();
							map.put("tmpTI4", tmpTI4);
							//4종 log 조회 Start
							ContractTeamVO ConS_List4 = sqlSession.selectOne("ContractTeamMapper.ConS_T4List", map);
							//4종 log 조회 End
							
							ConS_List4.setTeam_id(ConS_T4VO.getTeam_id());
							ConS_List4.setTeam_name(ConS_T4VO.getTeam_name());
							k4s_reg_m += Integer.parseInt(ConS_List4.getReg_m());
							k4s_reg_y += Integer.parseInt(ConS_List4.getReg_y());
							k4s_endok_m += Integer.parseInt(ConS_List4.getEndok_m());
							k4s_endok_y += Double.parseDouble(ConS_List4.getEndok_y());
							k4s_endno_m += Integer.parseInt(ConS_List4.getEndno_m());
							k4s_endno_y += Double.parseDouble(ConS_List4.getEndno_y());
							k4s_end_sum_m += Integer.parseInt(ConS_List4.getEnd_sum_m());
							k4s_end_sum_y += Double.parseDouble(ConS_List4.getEnd_sum_y());
							k4s_rid_mi += Integer.parseInt(ConS_List4.getRid_mi());
							k4s_price_g += Double.parseDouble(ConS_List4.getPrice_g());
							k4s_price_f += Double.parseDouble(ConS_List4.getPrice_f());
							k4s_price_sum += Double.parseDouble(ConS_List4.getPrice_sum());
							
							ConS_4List.add(ConS_List4);
							}
						
						//4종 데이터 합계 구하기 시작
						ContractTeamVO ConS_sum4VO = new ContractTeamVO();
						ConS_sum4VO.setSum_reg_m(""+(k4s_reg_m));
						ConS_sum4VO.setSum_reg_y(""+(k4s_reg_y));
						ConS_sum4VO.setSum_endok_m(""+(k4s_endok_m));
						ConS_sum4VO.setSum_endok_y(""+(k4s_endok_y));
						ConS_sum4VO.setSum_endno_m(""+(k4s_endno_m));
						ConS_sum4VO.setSum_endno_y(""+(k4s_endno_y));
						ConS_sum4VO.setSum_end_sum_m(""+(k4s_end_sum_m));
						ConS_sum4VO.setSum_end_sum_y(""+(k4s_end_sum_y));
						ConS_sum4VO.setSum_rid_mi(""+(k4s_rid_mi));
						ConS_sum4VO.setSum_price_g(""+(k4s_price_g));
						ConS_sum4VO.setSum_price_f(""+(k4s_price_f));
						ConS_sum4VO.setSum_price_sum(""+(k4s_price_sum));
						//4종 데이터 합계 구하기 종료
						
						model.addAttribute("ConS_4List", ConS_4List);
						model.addAttribute("ConS_sum4", ConS_sum4VO);
						
						//1,4종 데이터 합계 구하기 시작
						ContractTeamVO ConS_sum14VO = new ContractTeamVO();
						ConS_sum14VO.setSum_reg_m(""+(k1s_reg_m + k4s_reg_m));
						ConS_sum14VO.setSum_reg_y(""+(k1s_reg_y + k4s_reg_y));
						ConS_sum14VO.setSum_endok_m(""+(k1s_endok_m + k4s_endok_m));
						ConS_sum14VO.setSum_endok_y(""+(k1s_endok_y + k4s_endok_y));
						ConS_sum14VO.setSum_endno_m(""+(k1s_endno_m + k4s_endno_m));
						ConS_sum14VO.setSum_endno_y(""+(k1s_endno_y + k4s_endno_y));
						ConS_sum14VO.setSum_end_sum_m(""+(k1s_end_sum_m + k4s_end_sum_m));
						ConS_sum14VO.setSum_end_sum_y(""+(k1s_end_sum_y + k4s_end_sum_y));
						ConS_sum14VO.setSum_rid_mi(""+(k1s_rid_mi + k4s_rid_mi));
						ConS_sum14VO.setSum_price_g(""+(k1s_price_g + k4s_price_g));
						ConS_sum14VO.setSum_price_f(""+(k1s_price_f + k4s_price_f));
						ConS_sum14VO.setSum_price_sum(""+(k1s_price_sum + k4s_price_sum));
						//1,4종 데이터 합계 구하기 종료
					
				model.addAttribute("vo2", vo2);
				model.addAttribute("ConS_sum14", ConS_sum14VO);
				model.addAttribute("pgid", "contract_team");

		return "ls_log/log_index";
	}

	
	@RequestMapping(value = "/contract_team_excel", method = RequestMethod.POST)
	public void contractTeamExcel(Model model, HttpServletRequest request, HttpServletResponse response, String hidtab) {
		
		response.setCharacterEncoding("euc-kr");
		response.setHeader("Content-Disposition","attachment;filename=contract_team_excel_.xls");
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
