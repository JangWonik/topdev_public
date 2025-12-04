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
public class WorkTeamController {
	
	private static final Logger logger = LoggerFactory.getLogger(WorkTeamController.class);

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
	@RequestMapping(value = "/work_team", method = RequestMethod.GET)
	public String workTeam(Model model, HttpServletRequest request, WorkTeamViewVO vo2, String ig_id, String rid) {
		String viewName = workTeamPost(model, request, vo2, rid);
		return viewName;
	}

	@RequestMapping(value = "/work_team", method = RequestMethod.POST)
	public String workTeamPost(Model model, HttpServletRequest request, WorkTeamViewVO vo2, String rid) {

		//날짜만들기 시작
		String fromdate = vo2.getViewFromDate();
		String todate = vo2.getViewToDate();
		Calendar today = Calendar.getInstance();
		int dateInt = today.get(Calendar.DATE);
		int monthInt = today.get(Calendar.MONTH) + 1;
		int yearInt = today.get(Calendar.YEAR);
		/*int year = today.get(Calendar.DATE);
		int month = monthInt;
		int day = dateInt;*/
		if(todate == null || "".equals(todate)){
			if(monthInt == 13){
				monthInt = 1;
				yearInt++;
			}
			todate = "" + yearInt + "-" + ((monthInt < 10)? "0"+monthInt : monthInt) + "-" + ((dateInt < 10)? "0" +dateInt : dateInt);
		}
		
		String year = todate.substring(0, 4);
		String month = todate.substring(5, 7);
		
		
		//int fromAccumYear = Integer.parseInt(fromdate.substring(0, 4));
		//int fromAccumMonth = Integer.parseInt(fromdate.substring(5, 7));
		//int toAccumYear = Integer.parseInt(todate.substring(0, 4));
		/*if(fromAccumMonth < 12){
			fromAccumYear--;
		}
		String fromYear = fromAccumYear + "12" + "16";
		String toYear = toAccumYear + "12" + "16";*/
		//String e_todate = "";
		//e_todate = todate.substring(0, 4) + todate.substring(4, 6) + (Integer.parseInt(todate.substring(6, 8)) + 1);
		/*if(month > 12){
			year = year+1;
			month = month - 12;
		}else if(month < 10){
			todate = year + "0" + month + day;
			e_todate = year + "0" + month + (day+1);
		}else if(day < 10){
			todate = year + month + "0" + day;
			e_todate = year + month + "0" + (day+1);
		}*/
		
		
		model.addAttribute("year",year);
		model.addAttribute("month",month);
		model.addAttribute("todate",todate);
		//model.addAttribute("e_todate",e_todate);


        System.out.println("fromdate:["+fromdate+"]");
        System.out.println("todate:["+todate+"]");

        //날짜만들기 종료
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fromdate", fromdate);
		map.put("todate", todate);
		//map.put("e_todate", e_todate);
		
		model.addAttribute("dateInt", dateInt);
		model.addAttribute("monthInt", monthInt);
		model.addAttribute("fromdate", fromdate);
		model.addAttribute("todate", todate);
		//model.addAttribute("toAccumYear", toAccumYear);
		model.addAttribute("toMonthInt", todate.substring(5, 7));
		
				
		//1종 변수 설정
		int k1s_per = 0;
		int k1s_rid_reg = 0;
		int k1s_rid_end = 0;
		int k1s_rid_10m = 0;
		int k1s_rid_10m_ps = 0;
		int k1s_rid_10p = 0;
		int k1s_rid_10p_ps = 0;
		int k1s_rid_20p = 0;
		int k1s_rid_20p_ps = 0;
		int k1s_rid_30p = 0;
		int k1s_rid_30p_ps = 0;
		int k1s_rid_60p = 0;
		int k1s_rid_60p_ps = 0;
		int k1s_rid_90p = 0;
		int k1s_rid_90p_ps = 0;
		int k1s_rid_120p = 0;
		int k1s_rid_120p_ps = 0;
		int k1s_rid_sum = 0;
		int k1s_rid_sum_ps = 0;
		int k1s_rid_avr = 0;
		int k1s_rid_sum_p = 0;
		int k1s_rid_sum_r = 0;
		int u_cnt = 0;
		//String t_cnt = "";
		
		
		//1종 소계 변수 선언 종료
		
		
			List<WorkTeamVO> W_T1List = new ArrayList<WorkTeamVO>();
			W_T1List = sqlSession.selectList("WorkTeamMapper.Work_T1", map);
			
			
				
			List<WorkTeamVO> Work_T1List = new ArrayList<WorkTeamVO>();
				for(int i = 0; i < W_T1List.size(); i++){
					WorkTeamVO work_T1VO = W_T1List.get(i);
					String tmpTI = work_T1VO.getTeam_id();
					//String u_cnt = work_T1VO.getNo();
					//String t_cnt = work_T1VO.getT_cnt();
					map.put("tmpTI", tmpTI);
					//1종 log 조회 Start
					WorkTeamVO Work_1List = sqlSession.selectOne("WorkTeamMapper.Work_T1List", map);
					//1종 log 조회 End

                    System.out.println("======================>>1");

                    Work_1List.setTeam_id(work_T1VO.getTeam_id());
					Work_1List.setTeam_name(work_T1VO.getTeam_name());
					//Work_1List.setU_cnt(work_T1VO.getU_cnt());
                    System.out.println("======================>>2-1");
					u_cnt += Integer.parseInt(Work_1List.getU_cnt());
                    System.out.println("======================>>2-2");
					k1s_per += Integer.parseInt(Work_1List.getPer());
                    System.out.println("======================>>2-3");
					k1s_rid_end += Integer.parseInt(Work_1List.getRid_end());
                    System.out.println("======================>>2-4");
					k1s_rid_10m += Integer.parseInt(Work_1List.getRid_10m());
                    System.out.println("======================>>2-5");
					k1s_rid_10m_ps += Double.parseDouble(Work_1List.getRid_10m_ps());
                    System.out.println("======================>>2-6");
					k1s_rid_10p += Integer.parseInt(Work_1List.getRid_10p());
                    System.out.println("======================>>2-7");
					k1s_rid_10p_ps += Double.parseDouble(Work_1List.getRid_10p_ps());
                    System.out.println("======================>>2-8");
					k1s_rid_20p += Integer.parseInt(Work_1List.getRid_20p());
                    System.out.println("======================>>2-9");
					k1s_rid_20p_ps += Double.parseDouble(Work_1List.getRid_20p_ps());
                    System.out.println("======================>>2-10");
					k1s_rid_30p += Integer.parseInt(Work_1List.getRid_30p());
                    System.out.println("======================>>2-11");
					k1s_rid_30p_ps += Double.parseDouble(Work_1List.getRid_30p_ps());
                    System.out.println("======================>>2-12");
					k1s_rid_60p += Integer.parseInt(Work_1List.getRid_60p());
                    System.out.println("======================>>2-13");
					k1s_rid_60p_ps += Double.parseDouble(Work_1List.getRid_60p_ps());
                    System.out.println("======================>>2-14");
					k1s_rid_90p += Integer.parseInt(Work_1List.getRid_90p());
                    System.out.println("======================>>2-15");
					k1s_rid_90p_ps += Double.parseDouble(Work_1List.getRid_90p_ps());
                    System.out.println("======================>>2-16");
					k1s_rid_120p += Integer.parseInt(Work_1List.getRid_120p());
                    System.out.println("======================>>2-17");
					k1s_rid_120p_ps += Double.parseDouble(Work_1List.getRid_120p_ps());
                    System.out.println("======================>>2-18");
					k1s_rid_sum += Integer.parseInt(Work_1List.getRid_sum());
                    System.out.println("======================>>2-19");
					k1s_rid_sum_p += Integer.parseInt(Work_1List.getRid_sum_p());
                    System.out.println("======================>>2-20");
					k1s_rid_sum_r += Integer.parseInt(Work_1List.getRid_sum_r());
                    System.out.println("======================>>2-21");
					//k1s_rid_sum_ps += Double.parseDouble(Work_1List.getRid_sum_ps());
                    System.out.println("======================>>2-22");
					//k1s_rid_avr += Integer.parseInt(Work_1List.getRid_avr());
                    System.out.println("======================>>2-23");


					Work_T1List.add(Work_1List);
					}

                System.out.println("======================>>3");
				
				WorkTeamVO work_sum1VO = new WorkTeamVO();
				
				work_sum1VO.setSum_per(""+(k1s_per));
				work_sum1VO.setSum_u_cnt(""+(u_cnt));
				work_sum1VO.setSum_rid_end(""+(k1s_rid_end));
				work_sum1VO.setSum_rid_10m(""+(k1s_rid_10m));
				work_sum1VO.setSum_rid_10m_ps(""+((k1s_rid_10m_ps)/(W_T1List.size())));
				work_sum1VO.setSum_rid_10p(""+(k1s_rid_10p));
				work_sum1VO.setSum_rid_10p_ps(""+((k1s_rid_10p_ps)/(W_T1List.size())));
				work_sum1VO.setSum_rid_20p(""+(k1s_rid_20p));
				work_sum1VO.setSum_rid_20p_ps(""+((k1s_rid_20p_ps)/(W_T1List.size())));
				work_sum1VO.setSum_rid_30p(""+(k1s_rid_30p));
				work_sum1VO.setSum_rid_30p_ps(""+((k1s_rid_30p_ps)/(W_T1List.size())));
				work_sum1VO.setSum_rid_60p(""+(k1s_rid_60p));
				work_sum1VO.setSum_rid_60p_ps(""+((k1s_rid_60p_ps)/(W_T1List.size())));
				work_sum1VO.setSum_rid_90p(""+(k1s_rid_90p));
				work_sum1VO.setSum_rid_90p_ps(""+((k1s_rid_90p_ps)/(W_T1List.size())));
				work_sum1VO.setSum_rid_120p(""+(k1s_rid_120p));
				work_sum1VO.setSum_rid_120p_ps(""+((k1s_rid_120p_ps)/(W_T1List.size())));
				work_sum1VO.setSum_rid_sum(""+(k1s_rid_sum));
				work_sum1VO.setSum_rid_sum_ps(""+(k1s_rid_sum_ps));
				//work_sum1VO.setSum_rid_avr(""+(k1s_rid_avr));

		        //work_sum1VO.setSum_rid_sum_p(""+(k1s_rid_sum_p));
				//work_sum1VO.setSum_rid_sum_r(""+(k1s_rid_sum_r));
				
				
				model.addAttribute("Work_T1List", Work_T1List);
				model.addAttribute("work_sum1", work_sum1VO);
				
				//4종 변수 설정
				int k4s_per = 0;
				int k4s_rid_reg = 0;
				int k4s_rid_end = 0;
				int k4s_rid_10m = 0;
				int k4s_rid_10m_ps = 0;
				int k4s_rid_10p = 0;
				int k4s_rid_10p_ps = 0;
				int k4s_rid_20p = 0;
				int k4s_rid_20p_ps = 0;
				int k4s_rid_30p = 0;
				int k4s_rid_30p_ps = 0;
				int k4s_rid_60p = 0;
				int k4s_rid_60p_ps = 0;
				int k4s_rid_90p = 0;
				int k4s_rid_90p_ps = 0;
				int k4s_rid_120p = 0;
				int k4s_rid_120p_ps = 0;
				int k4s_rid_sum = 0;
				int k4s_rid_sum_ps = 0;
				int k4s_rid_avr = 0;
				int k4s_rid_sum_p = 0;
				int k4s_rid_sum_r = 0;
				int u_cnt4 = 0;
				
				List<WorkTeamVO> W_T4List = new ArrayList<WorkTeamVO>();
				W_T4List = sqlSession.selectList("WorkTeamMapper.Work_T4", map);
				
				List<WorkTeamVO> Work_T4List = new ArrayList<WorkTeamVO>();
					for(int i = 0; i < W_T4List.size(); i++){
						WorkTeamVO work_T4VO = W_T4List.get(i);
						
						String tmpTI4 = work_T4VO.getTeam_id();
						//String u_cnt4 = work_T4VO.getNo();
						//String t_cnt4 = work_T4VO.getT_cnt();
						map.put("tmpTI4", tmpTI4);
						//1종 log 조회 Start
						WorkTeamVO Work_4List = sqlSession.selectOne("WorkTeamMapper.Work_T4List", map);
						//1종 log 조회 End
						//Work_1List.setU_cnt(work_T1VO.getU_cnt());
						Work_4List.setTeam_id(work_T4VO.getTeam_id());
						Work_4List.setTeam_name(work_T4VO.getTeam_name());
						//Work_1List.setU_cnt(work_T1VO.getU_cnt());
						u_cnt4 += Integer.parseInt(Work_4List.getU_cnt());
						k4s_per += Integer.parseInt(Work_4List.getPer());
						k4s_rid_end += Integer.parseInt(Work_4List.getRid_end());
						k4s_rid_10m += Integer.parseInt(Work_4List.getRid_10m());
						k4s_rid_10m_ps += Double.parseDouble(Work_4List.getRid_10m_ps());
						k4s_rid_10p += Integer.parseInt(Work_4List.getRid_10p());
						k4s_rid_10p_ps += Double.parseDouble(Work_4List.getRid_10p_ps());
						k4s_rid_20p += Integer.parseInt(Work_4List.getRid_20p());
						k4s_rid_20p_ps += Double.parseDouble(Work_4List.getRid_20p_ps());
						k4s_rid_30p += Integer.parseInt(Work_4List.getRid_30p());
						k4s_rid_30p_ps += Double.parseDouble(Work_4List.getRid_30p_ps());
						k4s_rid_60p += Integer.parseInt(Work_4List.getRid_60p());
						k4s_rid_60p_ps += Double.parseDouble(Work_4List.getRid_60p_ps());
						k4s_rid_90p += Integer.parseInt(Work_4List.getRid_90p());
						k4s_rid_90p_ps += Double.parseDouble(Work_4List.getRid_90p_ps());
						k4s_rid_120p += Integer.parseInt(Work_4List.getRid_120p());
						k4s_rid_120p_ps += Double.parseDouble(Work_4List.getRid_120p_ps());
						k4s_rid_sum += Integer.parseInt(Work_4List.getRid_sum());

                        //k4s_rid_sum_p += Integer.parseInt(Work_4List.getRid_sum_p());
						//k4s_rid_sum_r += Integer.parseInt(Work_4List.getRid_sum_r());
						
						//k1s_rid_sum_ps += Double.parseDouble(Work_1List.getRid_sum_ps());
						//k1s_rid_avr += Integer.parseInt(Work_1List.getRid_avr());
						Work_T4List.add(Work_4List);
						}
					
					
					
					WorkTeamVO work_sum4VO = new WorkTeamVO();
					
					work_sum4VO.setSum_per(""+(k4s_per));
					//work_sum1VO.setSum_u_cnt(""+(u_cnt));
					work_sum4VO.setSum_u_cnt(""+(u_cnt4));
					work_sum4VO.setSum_rid_end(""+(k4s_rid_end));
					work_sum4VO.setSum_rid_10m(""+(k4s_rid_10m));
					work_sum4VO.setSum_rid_10m_ps(""+((k4s_rid_10m_ps)/(W_T4List.size())));
					work_sum4VO.setSum_rid_10p(""+(k4s_rid_10p));
					work_sum4VO.setSum_rid_10p_ps(""+((k4s_rid_10p_ps)/(W_T4List.size())));
					work_sum4VO.setSum_rid_20p(""+(k4s_rid_20p));
					work_sum4VO.setSum_rid_20p_ps(""+((k4s_rid_20p_ps)/(W_T4List.size())));
					work_sum4VO.setSum_rid_30p(""+(k4s_rid_30p));
					work_sum4VO.setSum_rid_30p_ps(""+((k4s_rid_30p_ps)/(W_T4List.size())));
					work_sum4VO.setSum_rid_60p(""+(k4s_rid_60p));
					work_sum4VO.setSum_rid_60p_ps(""+((k4s_rid_60p_ps)/(W_T4List.size())));
					work_sum4VO.setSum_rid_90p(""+(k4s_rid_90p));
					work_sum4VO.setSum_rid_90p_ps(""+((k4s_rid_90p_ps)/(W_T4List.size())));
					work_sum4VO.setSum_rid_120p(""+(k4s_rid_120p));
					work_sum4VO.setSum_rid_120p_ps(""+((k4s_rid_120p_ps)/(W_T4List.size())));
					work_sum4VO.setSum_rid_sum(""+(k4s_rid_sum));
					work_sum4VO.setSum_rid_sum_ps(""+(k4s_rid_sum_ps));
					//work_sum4VO.setSum_rid_avr(""+(k4s_rid_avr));
					work_sum4VO.setSum_rid_sum_p(""+(k4s_rid_sum_p));
					work_sum4VO.setSum_rid_sum_r(""+(k4s_rid_sum_r));
				
					WorkTeamVO work_sum14VO = new WorkTeamVO();
					work_sum14VO.setSum_per(""+(k1s_per + k4s_per));
					work_sum14VO.setSum_u_cnt(""+(u_cnt + u_cnt4));
					work_sum14VO.setSum_rid_end(""+(k1s_rid_end + k4s_rid_end));
					work_sum14VO.setSum_rid_10m(""+(k1s_rid_10m + k4s_rid_10m));
					work_sum14VO.setSum_rid_10m_ps(""+(((k1s_rid_10m_ps)/(W_T1List.size())) + ((k4s_rid_10m_ps)/(W_T4List.size())))/2);
					work_sum14VO.setSum_rid_10p(""+(k1s_rid_10p + k4s_rid_10p));
					work_sum14VO.setSum_rid_10p_ps(""+(((k1s_rid_10p_ps)/(W_T1List.size())) + ((k4s_rid_10p_ps)/(W_T4List.size())))/2);
					work_sum14VO.setSum_rid_20p(""+(k1s_rid_20p + k4s_rid_20p));
					work_sum14VO.setSum_rid_20p_ps(""+(((k1s_rid_20p_ps)/(W_T1List.size())) + ((k4s_rid_20p_ps)/(W_T4List.size())))/2);
					work_sum14VO.setSum_rid_30p(""+(k1s_rid_30p + k4s_rid_30p));
					work_sum14VO.setSum_rid_30p_ps(""+(((k1s_rid_30p_ps)/(W_T1List.size())) + ((k4s_rid_30p_ps)/(W_T4List.size())))/2);
					work_sum14VO.setSum_rid_60p(""+(k1s_rid_60p + k4s_rid_60p));
					work_sum14VO.setSum_rid_60p_ps(""+(((k1s_rid_60p_ps)/(W_T1List.size())) + ((k4s_rid_60p_ps)/(W_T4List.size())))/2);
					work_sum14VO.setSum_rid_90p(""+(k1s_rid_90p + k4s_rid_90p));
					work_sum14VO.setSum_rid_90p_ps(""+(((k1s_rid_90p_ps)/(W_T1List.size())) + ((k4s_rid_90p_ps)/(W_T4List.size())))/2);
					work_sum14VO.setSum_rid_120p(""+(k1s_rid_120p + k4s_rid_120p));
					work_sum14VO.setSum_rid_120p_ps(""+(((k1s_rid_120p_ps)/(W_T1List.size())) + ((k4s_rid_120p_ps)/(W_T4List.size())))/2);
					work_sum14VO.setSum_rid_sum(""+(k1s_rid_sum + k4s_rid_sum));
					work_sum14VO.setSum_rid_sum_ps(""+(k1s_rid_sum_ps + k4s_rid_sum_ps));
					work_sum14VO.setSum_rid_sum_p(""+(k1s_rid_sum_p + k4s_rid_sum_p));
					work_sum14VO.setSum_rid_sum_r(""+(k1s_rid_sum_r + k4s_rid_sum_r));
						
					
					model.addAttribute("Work_T4List", Work_T4List);
					model.addAttribute("work_sum4", work_sum4VO);
					model.addAttribute("work_sum14", work_sum14VO);
				model.addAttribute("vo2", vo2);
				//model.addAttribute("accept_sum14", accept_sum14VO);
				//model.addAttribute("Accept_T4List", Accept_T4List);
				model.addAttribute("pgid", "work_team");

		return "ls_log/log_index";
	}

	
	
	/*@RequestMapping(value = "/accept_team_excel", method = RequestMethod.POST)
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
	}*/

}
