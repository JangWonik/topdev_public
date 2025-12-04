package kr.co.toplac.topstatistics.web;

import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.topstatistics.service.WorkloadService;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by lds on 2018.03. 05..
 */
@Controller
public class StatisticWorkloadController {

    private static final Logger logger = LoggerFactory.getLogger(StatisticWorkloadController.class);

    @Autowired
    private SqlSession sqlSession;
    
	@Autowired
	WorkloadService workloadService;
    
    /*
     *********************************************************
     * Program ID	: workloadMemberPop
     * Program Name	: workloadMemberPop
     * Description	: 평가기준 달성도 관리 팝업(개인)
     * Author		: LDS
     * Date			: 2018.03.05
     *********************************************************
     */
     @RequestMapping(value = "workloadMemberPop", method = RequestMethod.GET)
     public String workloadMemberPop(Model model, HttpSession session, HttpServletRequest request) {
         logger.info("======= workloadMemberPop =======");
         
         Map<String,Object> workloadMap = workloadService.myWorkloadSimple();
         model.addAttribute("workloadMap", workloadMap);
         
         return "top_statistics/workload/pop_workload_member";
     }
     
     
     /*
      *********************************************************
      * Program ID		: workloadStatistics
      * Program Name	: workloadStatistics
      * Description		: 평가기준 달성도 관리 통계
      * Author			: LDS
      * Date			: 2018.03.06
      *********************************************************
      */
      @RequestMapping(value = "workloadStatistics")
      public String workloadStatistics(Model model, HttpServletRequest request, HttpSession session) {
    	  //===============================================
          // 권한체크
          //===============================================
          TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
//          if ( !"3".equals(mbrVo.getWork_type_cd()) && !"4".equals(mbrVo.getWork_type_cd()) && !"14".equals(mbrVo.getWork_type_cd())  ){
//        	  return "redirect:/";
//          }
          
          //===============================================
	      // 파라미터 체크
	      //===============================================
	      Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
	
	      //===============================================
          // 현재 일자 세팅
          //===============================================
          String startDate = StringUtil.null2blank(request.getParameter("startDate"));  //기준일자 시작일
          String endDate = StringUtil.null2blank(request.getParameter("endDate"));  	//기준일자 종료일
          
          String gubun = StringUtil.null2blank(request.getParameter("gubun"));  		//메뉴 접근 구분 adm, center, team, member
          String type = StringUtil.null2blank(request.getParameter("type"));  			//출력 레벨 구분 1:센터, 2:팀, 3:개인
          String extra = StringUtil.null2blank(request.getParameter("extra"));  		//총괄 구분
          
          String basicYN = StringUtil.null2blank(request.getParameter("basicYN"));  			
          String primYN = StringUtil.null2blank(request.getParameter("primYN"));  			
          
          String excelYN = StringUtil.null2blank(request.getParameter("excelYN"));  	//엑셀다운 여부
          
          String orderKey = StringUtil.null2blank(request.getParameter("orderKey"));  		//조회 컬럼 (purpose,calc,rate,rank)
          String orderDirection = StringUtil.null2blank(request.getParameter("orderDirection"));  	//조회 방향 (asc, desc)
          if ("".equals(orderDirection)) paramMap.put("orderDirection","desc");
          

		  //검색 로그 남기기 시작 (20240109)
		  String sUserNo = mbrVo.getUser_no();		
		  String sUserName = mbrVo.getUser_name();
		  String sIp = mbrVo.getUser_ip();
		  String sLogPage = "";
		  
		  if("member".equals(gubun) && "3".equals(type) ){
			  sLogPage = "평가기준달성도(개인)";
		  }else if("adm".equals(gubun) &&  "2".equals(type)){
			  sLogPage = "평가기준달성도(팀)";
		  }else if("adm".equals(gubun) &&  "3".equals(type)){
			  sLogPage = "평가기준달성도(센터)";
		  }else{
			  sLogPage = "평가기준달성도(개인)";
		  }
		
		  Map<String, Object> logMap = new HashMap<String, Object>();
		
		  logMap.put("user_no", sUserNo);
		  logMap.put("user_name", sUserName);
		  logMap.put("user_ip", sIp);
		  logMap.put("search_page", sLogPage);
		
		  sqlSession.insert("SaveLogMapper.insertTopSearchLog",logMap);
		  //검색 로그 남기기 끝 (20240109)
          
          
          Map<String,Object> yearMap = workloadService.setYearDate(startDate); //년단위 기준일 생성
          
          if ("".equals(startDate)){
        	  startDate = String.valueOf(yearMap.get("yearStartDate"));
        	  endDate = String.valueOf(yearMap.get("yearEndDate")); 
          }
          	
          
          //=============================================
          // 수임 농작물 적부 기본값 세팅
          //=============================================
          if ("".equals(basicYN)){
              paramMap.put("basicYN","Y");
          }
          
          if ("".equals(primYN)){
        	  paramMap.put("primYN","Y");
          }
          
          paramMap.put("startDate", startDate);
          paramMap.put("endDate", endDate);
          
          paramMap.put("yearStartDate", String.valueOf(yearMap.get("yearStartDate")));
          paramMap.put("yearEndDate", String.valueOf(yearMap.get("yearEndDate")));
			          
          paramMap.put("mbrTeamId", mbrVo.getTeam_id_main());
          paramMap.put("mbrTeamGroupOrder", mbrVo.getTeam_group_order());
          
          List<String> teamList, userList = null;
          
          //===============================================
          // 검색 범위 설정
          //===============================================
          
          //팀 
          if ("team".equals(gubun)){
    		  teamList = new ArrayList<>();
    		  paramMap.put("teamList", teamList);
    		  userList =  sqlSession.selectList("StatisticWorkloadMapper.selectPickTeamOrMember",paramMap);
          //센터
          }else if ("center".equals(gubun)){
    		  if ("3".equals(type)){
    			  teamList = new ArrayList<>();
    			  paramMap.put("teamList",teamList);
    			  paramMap.put("teamId", request.getParameter("teamId"));
    			  userList = sqlSession.selectList("StatisticWorkloadMapper.selectPickTeamOrMember",paramMap);
    		  }else{
    			  paramMap.put("selectType","team");
    			  teamList = sqlSession.selectList("StatisticWorkloadMapper.selectPickTeamOrMember",paramMap);
    			  paramMap.put("teamList",teamList);
    			  
    			  paramMap.put("selectType","member");
    			  userList = sqlSession.selectList("StatisticWorkloadMapper.selectPickTeamOrMember",paramMap);
    		  }
          //개인별
          }else if ("member".equals(gubun)){
              teamList = new ArrayList<>();
              paramMap.put("teamList", teamList);
              userList =  sqlSession.selectList("StatisticWorkloadMapper.selectPickTeamOrMember",paramMap);              
              
          //관리자
          }else if("adm".equals(gubun)){
        	  String teamId = StringUtil.null2blank(request.getParameter("teamId"));
        	  String teamGroupOrder = StringUtil.null2blank(request.getParameter("teamGroupOrder"));
        	  
        	  if ("3".equals(type)){
        		  teamList = new ArrayList<>();
        		  paramMap.put("teamList",teamList);
        		  paramMap.put("teamId", teamId);
        		  userList =  sqlSession.selectList("StatisticWorkloadMapper.selectPickTeamOrMember",paramMap);
        	  }else if("2".equals(type) && !"".equals(teamGroupOrder)){
        		  paramMap.put("teamGroupOrder", teamGroupOrder);
        		  paramMap.put("selectType", "team");
        		  teamList = sqlSession.selectList("StatisticWorkloadMapper.selectPickTeamOrMember",paramMap);
        		  paramMap.put("teamList",teamList);
        		  
        		  paramMap.put("selectType", "member");
        		  userList =  sqlSession.selectList("StatisticWorkloadMapper.selectPickTeamOrMember",paramMap);
        	  }else{
        		  /*
        		  teamList = null;
        		  paramMap.put("teamList",teamList);
        		  */
        		  paramMap.put("selectType", "team");
        		  teamList = sqlSession.selectList("StatisticWorkloadMapper.selectPickTeamOrMember",paramMap);
        		  paramMap.put("teamList", teamList);
        		  
        		  paramMap.put("selectType", "member");
        		  userList = sqlSession.selectList("StatisticWorkloadMapper.selectPickTeamOrMember",paramMap);
        	  }
          }
          /*
          teamList = new ArrayList<>();
          userList = new ArrayList<>();
          */
          
          List<Map<String,Object>> workloadList = workloadService.workloadStatistics(userList, paramMap);
          
          if ("purpose".equals(orderKey)){
        	  MapComparator comp = new MapComparator("purpose_workload",orderDirection);
        	  Collections.sort(workloadList,comp);
          }else if("calc".equals(orderKey)){
        	  MapComparator comp = new MapComparator("calc_workload",orderDirection);
        	  Collections.sort(workloadList,comp);        	  
          }else if("rate".equals(orderKey)){
        	  MapComparator comp = new MapComparator("rank_workload",orderDirection);
        	  Collections.sort(workloadList,comp);
          }else if("rank".equals(orderKey)){
        	  MapComparator comp = new MapComparator("rank_workload",orderDirection);
        	  Collections.sort(workloadList,comp);
          }
          
          
          model.addAttribute("teamName",mbrVo.getTeam_name()); 
          model.addAttribute("workloadList", workloadList);
          model.addAttribute("srchArg",paramMap);

          String retURL = "top_statistics/workload/statistics_workload_team_list";  

          if ("Y".equals(excelYN)){
              retURL = "top_statistics/workload/statistics_workload_team_excel";
          }
          
          return retURL;
      }
      
      class MapComparator implements Comparator<Map<String,Object>> {
    	  private final String key;
    	  private final String order;
    	  
    	  public MapComparator(String key, String order){
    		  this.key = key;
    		  this.order = order;
    	  }
    	  
          @Override
          public int compare(Map<String,Object> map1, Map<String,Object> map2) {
        	  int result;
        	  
        	  double map1Value = Double.parseDouble(""+map1.get(key));
        	  double map2Value = Double.parseDouble(""+map2.get(key));
        	  
        	  if ("desc".equals(order)){
        		  if (map2Value > map1Value){
        			  result = 1;
        		  }else if (map2Value < map1Value){
        			  result = -1;
        		  }else{
        			  result = 0;
        		  }
        	  }else{
        		  if (map1Value > map2Value){
        			  result = 1;
        		  }else if (map1Value < map2Value){
        			  result = -1;
        		  }else{
        			  result = 0;
        		  }
        	  }
              return result;
          }
       
      }



}
