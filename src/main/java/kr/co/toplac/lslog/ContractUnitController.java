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
public class ContractUnitController {
	
	private static final Logger logger = LoggerFactory.getLogger(ContractUnitController.class);

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
	@RequestMapping(value = "/contract_unit", method = RequestMethod.GET)
	public String contractUnit(Model model, HttpServletRequest request, ContractUnitViewVO vo2, String ig_id, String rid) {
		String viewName = contractUnitPost(model, request, vo2, rid);
		return viewName;
	}

	@RequestMapping(value = "/contract_unit", method = RequestMethod.POST)
	public String contractUnitPost(Model model, HttpServletRequest request, ContractUnitViewVO vo2, String rid) {

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
		
		if(fromAccumMonth < 12){
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
		
		model.addAttribute("dateInt", dateInt);
		model.addAttribute("monthInt", monthInt);
		model.addAttribute("fromdate", fromdate);
		model.addAttribute("todate", todate);
		model.addAttribute("toAccumYear", toAccumYear);
		model.addAttribute("toMonthInt", toMonthInt);
		
		//1종 변수 설정
		int U_reg_m = 0;
		int U_reg_y = 0;
		int U_endok_m = 0;
		int U_endok_y = 0;
		int U_endno_m = 0;
		int U_endno_y = 0;
		int U_end_sum_m = 0;
		int U_end_sum_y = 0;
		int U_rid_mi = 0;
		int U_price_g = 0;
		int U_price_f = 0;
		int U_price_sum = 0;
		String U_team_name = "";
		String U_name = "";
		//1종 소계 변수 선언 종료
		
			List<ContractUnitVO> ConS_UList = new ArrayList<ContractUnitVO>();
			ConS_UList = sqlSession.selectList("ContractUnitMapper.ConS_U", map);
			
			List<ContractUnitVO> ConS_UrList = new ArrayList<ContractUnitVO>();
				for(int i = 0; i < ConS_UList.size(); i++){
					ContractUnitVO ConS_UVO = ConS_UList.get(i);
					String tmpUI = ConS_UVO.getUser_id();
					String tmpTI = ConS_UVO.getTeam_id();
					map.put("tmpUI", tmpUI);
					map.put("tmpTI", tmpTI);
					//log 조회 Start
					ContractUnitVO ConS_List = sqlSession.selectOne("ContractUnitMapper.ConS_UList", map);
					//log 조회 End
					
					ConS_List.setUser_id(ConS_UVO.getUser_id());
					ConS_List.setTeam_id(ConS_UVO.getTeam_id());
					ConS_List.setTeam_name(ConS_UVO.getTeam_name());
					ConS_List.setName(ConS_UVO.getName());
					U_reg_m += Integer.parseInt(ConS_List.getReg_m());
					U_reg_y += Integer.parseInt(ConS_List.getReg_y());
					U_endok_m += Integer.parseInt(ConS_List.getEndok_m());
					U_endok_y += Double.parseDouble(ConS_List.getEndok_y());
					U_endno_m += Integer.parseInt(ConS_List.getEndno_m());
					U_endno_y += Double.parseDouble(ConS_List.getEndno_y());
					U_end_sum_m += Integer.parseInt(ConS_List.getEnd_sum_m());
					U_end_sum_y += Double.parseDouble(ConS_List.getEnd_sum_y());
					U_rid_mi += Integer.parseInt(ConS_List.getRid_mi());
					U_price_g += Double.parseDouble(ConS_List.getPrice_g());
					U_price_f += Double.parseDouble(ConS_List.getPrice_f());
					U_price_sum += Double.parseDouble(ConS_List.getPrice_sum());
					
					ConS_UrList.add(ConS_List);
					}
				
				//데이터 합계 구하기 시작
				ContractUnitVO ConS_UsumVO = new ContractUnitVO();
				ConS_UsumVO.setSum_reg_m(""+(U_reg_m));
				ConS_UsumVO.setSum_reg_y(""+(U_reg_y));
				ConS_UsumVO.setSum_endok_m(""+(U_endok_m));
				ConS_UsumVO.setSum_endok_y(""+(U_endok_y));
				ConS_UsumVO.setSum_endno_m(""+(U_endno_m));
				ConS_UsumVO.setSum_endno_y(""+(U_endno_y));
				ConS_UsumVO.setSum_end_sum_m(""+(U_end_sum_m));
				ConS_UsumVO.setSum_end_sum_y(""+(U_end_sum_y));
				ConS_UsumVO.setSum_rid_mi(""+(U_rid_mi));
				ConS_UsumVO.setSum_price_g(""+(U_price_g));
				ConS_UsumVO.setSum_price_f(""+(U_price_f));
				ConS_UsumVO.setSum_price_sum(""+(U_price_sum));
				//데이터 합계 구하기 종료
				
				model.addAttribute("ConS_UrList", ConS_UrList);
				model.addAttribute("ConS_Usum", ConS_UsumVO);
						
				model.addAttribute("vo2", vo2);
				model.addAttribute("pgid", "contract_unit");

		return "ls_log/log_index";
	}

	@RequestMapping(value = "/contract_unit_excel", method = RequestMethod.POST)
	public void contractTeamExcel(Model model, HttpServletRequest request, HttpServletResponse response, String hidtab) {
		
		response.setCharacterEncoding("euc-kr");
		response.setHeader("Content-Disposition","attachment;filename=contract_team_excel.xls");
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
