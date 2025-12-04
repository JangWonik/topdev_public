package kr.co.toplac.topstatistics.service;


import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sun.org.apache.xpath.internal.operations.Bool;

import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.StringUtil;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by lds on 2018. 2. 7..
 */
@Service
public class WorkloadService {
    private static final Logger logger = LoggerFactory.getLogger(WorkloadService.class);

    @Autowired
    SqlSession sqlSession;

    /**
     * 
     * 평가기준 달성도 (개인)
     * - top_main_left, workloadMemberPop
     * 
     */
    public Map<String,Object> myWorkloadSimple(){
    	
        //===============================================
        //	세션 데이터 확인
        //===============================================
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
    	String userNo = mbrVo.getUser_no();
    	String centerName = mbrVo.getCenter_name();
    	String teamName = mbrVo.getTeam_name();
    	
    	Map<String,Object> paramMap = new HashMap<>();
    	
        //========================================================
        //  기준일 생성 (요약표의 경우 반드시 당해년도 1년치)
        //========================================================  	
    	Map<String,Object> yearMap = this.setYearDate(null);
    	String startDate = String.valueOf(yearMap.get("yearStartDate"));
    	String endDate = String.valueOf(yearMap.get("yearEndDate"));
    	
    	String nowYear = startDate+" ~ "+endDate;
    	
    	//System.out.println("test111111="+startDate+" : "+endDate);
       	
    	List<String> teamList = new ArrayList();
    	List<String> userList = new ArrayList();
    	userList.add(userNo);
    	
    	paramMap.put("userNo", userNo);
    	paramMap.put("mbrTeamId", "");
    	paramMap.put("mbrTeamGroupOrder", "");
    	paramMap.put("teamList", teamList);
    	
    	paramMap.put("startDate", startDate);
    	paramMap.put("endDate", endDate);
    	
    	paramMap.put("gubun", "member");
    	paramMap.put("type", 3);
    	paramMap.put("basicYN","Y");
    	paramMap.put("primYN","Y");
    	
    	
    	Map<String,Object> returnMap = null;
    	List<Map<String,Object>> returnList = workloadStatistics(userList, paramMap);
    	
    	if (returnList.size() > 0){
    		int workloadCnt = sqlSession.selectOne("StatisticWorkloadMapper.selectWorkloadRankCnt"); //백분위 환산을 위한 대상 CNT
    		returnList.get(0).put("workloadCnt", workloadCnt);
    		returnList.get(0).put("mbrCenterName", centerName);
    		returnList.get(0).put("mbrTeamName", teamName);
    		returnList.get(0).put("nowYear", nowYear);    		
    		returnMap = returnList.get(0); 
    	}
    	
    	/**
    	 * 2019.06.14 월별요약을 위한 기간 추가설정
    	 */
    	startDate = DateUtil.getStartMonthDay();		//월시작일
    	startDate = startDate.substring(0,4)+"-"+startDate.substring(4,6)+"-"+startDate.substring(6,8);
    	
    	endDate = DateUtil.getEndMonthDay();			//월종료일
    	endDate = endDate.substring(0,4)+"-"+endDate.substring(4,6)+"-"+endDate.substring(6,8);
    	
    	//테스트
    	//startDate = "2019-01-16"; 
    	//endDate =	"2019-02-15";
    	
    	//System.out.println("test22222="+startDate+" : "+endDate);
    	
    	paramMap.put("startDate", startDate);
    	paramMap.put("endDate", endDate);
    	
    	List<Map<String,Object>> monthList = workloadStatistics(userList, paramMap);
    	
    	String m_purpose_workload = "";
    	String m_calc_workload = "";
    	String nowMonth = startDate+" ~ "+endDate;
    	
    	if(monthList.size() > 0) {
    		m_purpose_workload = monthList.get(0).get("purpose_workload").toString();
    		m_calc_workload = monthList.get(0).get("calc_workload").toString();
    		returnList.get(0).put("m_purpose_workload", m_purpose_workload);		//월 목표로 수정해야함.
    		returnList.get(0).put("m_calc_workload", m_calc_workload);
    		returnList.get(0).put("nowMonth", nowMonth);
    	}
    	
    	//System.out.println("m_purpose_workload="+m_purpose_workload);
    	//System.out.println("m_calc_workload="+m_calc_workload);
    	
		return returnMap;
    	
    }
    
    /*
     *  평가기준 달성도 계산
     */
    public List<Map<String,Object>> workloadStatistics(List<String> userList, Map<String,Object> paramMap) {
        //========================================================
    	//	반환 데이터 
    	//	해당 발령내용에 부합하는 목표 및 실적을 
    	//	개인별 팀별 센터별 분류하여 합계내여 반환
        //========================================================
    	String gubun = String.valueOf(paramMap.get("gubun"));    	
    	String type = String.valueOf(paramMap.get("type"));
    	String extra = String.valueOf(paramMap.get("extra"));
    	String basicYN = String.valueOf(paramMap.get("basicYN"));
    	String primYN = String.valueOf(paramMap.get("primYN"));
    	
    	String mbrTeamId = String.valueOf(paramMap.get("mbrTeamId"));   
    	String mbrTeamGroupOrder = String.valueOf(paramMap.get("mbrTeamGroupOrder"));   
    	String paramTeamId = StringUtil.null2blank((String) paramMap.get("teamId"));
    	String paramTeamGroupOrder = StringUtil.null2blank((String) paramMap.get("teamGroupOrder"));
    	
    	List<String> teamList = (List<String>) paramMap.get("teamList");
    	teamList.add(mbrTeamId);
    	
    	List<Map<String,Object>> workloadList =new ArrayList<>();
		List<Map<String,Object>> tmpList = new ArrayList<>();
		
    	for(String userNo : userList){
    		List<Map<String,Object>> memberList = new ArrayList<>();
    		List<Map<String,Object>> userWorkloadList = new ArrayList<>();
    		Map<String,Object> userMap = new HashMap<>();
    		userMap.put("userNo", userNo);
    		userMap.put("startDate", paramMap.get("startDate"));
    		userMap.put("endDate", paramMap.get("endDate"));
    		
    		userMap = setWorkloadStdDate(userMap);
    		memberList.add(userMap);
		
        	List<Map<String,Object>> jobList = WorkloadCalc(memberList, teamList, gubun);
        	paramMap.put("jobList", jobList);
        	paramMap.put("jobListSize",jobList.size());
        	paramMap.put("basicYN", basicYN);
        	paramMap.put("primYN", primYN);
        	
        	String endDate = String.valueOf(paramMap.get("endDate"));
	    	int year = Integer.parseInt(endDate.split("-")[0]);
	    	int month = Integer.parseInt(endDate.split("-")[1]);
	    	int day = Integer.parseInt(endDate.split("-")[2]);
	    	
			if (month == 12 && day > 15){
				++year;
			}
			paramMap.put("year", year);
        	
        	userWorkloadList = sqlSession.selectList("StatisticWorkloadMapper.selectMyWorkLoadSumStatistics",paramMap); 
        	
            //========================================================
            //  개인별 발령에 따른 기준업무량 적용부분 조정
        	//  type == 3(개인별)일 경우, teamId가 있으면 해당 팀의 내용만 적용
        	//  type == 2(팀별)일 경우, teamGroupOrder가 있으면 
            //========================================================
        	for(Map<String,Object> userWorkloadMap : userWorkloadList){
        		String currTeamId = String.valueOf(userWorkloadMap.get("teamId")); 
        		String currTeamGroupOrder = String.valueOf(userWorkloadMap.get("teamGroupOrder"));
        		if ("adm".equals(gubun)){
        			if ( ("3".equals(type) && !"".equals(paramTeamId)) ){
        				if (paramTeamId.equals(currTeamId)){
        					tmpList.add(userWorkloadMap);
        				}
        			}else if( ("2".equals(type) && !"".equals(paramTeamGroupOrder)) ){
        				if (paramTeamGroupOrder.equals(currTeamGroupOrder)){
        					tmpList.add(userWorkloadMap);
        				}
        			}else{
        				tmpList.add(userWorkloadMap);
        			}
        			
        		}else if("center".equals(gubun)){
        			if ("3".equals(type) && !"".equals(paramTeamId)){
        				if (paramTeamId.equals(currTeamId)){
        					tmpList.add(userWorkloadMap);
        				}
        			}else{
        				if ("1".equals(extra)){
        					if( ("2".equals(type) && !"".equals(paramTeamGroupOrder)) ){
                				if (paramTeamGroupOrder.equals(currTeamGroupOrder)){
                					tmpList.add(userWorkloadMap);
                				}
        					}else{
        						tmpList.add(userWorkloadMap);
        					}
        				}else{
        					if (mbrTeamGroupOrder.equals(currTeamGroupOrder)){
        						tmpList.add(userWorkloadMap);
        					}
        				}
        			}
        		}else if("team".equals(gubun)){
        			if ("3".equals(type) && !"".equals(paramTeamId)){
        				if (paramTeamId.equals(currTeamId)){
        					tmpList.add(userWorkloadMap);
        				}
        			}else{
        				if (mbrTeamId.equals(currTeamId)){
        					tmpList.add(userWorkloadMap);
        				}
        			}
        		}else if ("member".equals(gubun)){
        			tmpList.add(userWorkloadMap);
        		}
        	}
    	}
    	
    	if ( "3".equals(type) ){
    		workloadList = tmpList;
    		List<Map<String,Object>> rankList = sqlSession.selectList("StatisticWorkloadMapper.selectWorkloadRank", paramMap);
    		for(Map<String,Object> workload : workloadList){
    			for(Map<String,Object> rank : rankList){
    				String workloadUserNo = String.valueOf(workload.get("userNo"));
    				String rankUserNo = String.valueOf(rank.get("userNo"));
    				if (workloadUserNo.equals(rankUserNo)){
    					workload.put("rank_workload", rank.get("rank"));
    					workload.put("rankListSize", rankList.size());
    				}
    			}
    		}
    	}else{
        	Map<String,Object> tmpMap = new HashMap<String,Object>();
        	tmpMap.put("userList",tmpList);
        	tmpMap.put("gubun",gubun);
        	tmpMap.put("type", type);
        	workloadList = sqlSession.selectList("StatisticWorkloadMapper.selectTeamWorkLoadSumStatistics",tmpMap);
    	}
    	
    	return workloadList;
    }
    
    
    /*
     * 기준업무량 계산을 위한 기준일 생성
     * 
     */
    public Map<String,Object> setWorkloadStdDate(Map<String,Object> paramMap) {
    	
	    //========================================================
	    //  파라미터 세팅
	    //======================================================== 
    	try {
    		
        	String gubun = String.valueOf(paramMap.get("gubun")); //직원 정보 추출 과정에서 리셋됨
	    	String startDate = String.valueOf(paramMap.get("startDate"));
	    	String endDate = String.valueOf(paramMap.get("endDate"));
	    	
	    	Map<String,Object> yearMap = this.setYearDate(startDate);
	    	String yearStartDate = String.valueOf(yearMap.get("yearStartDate"));
	    	String yearEndDate = String.valueOf(yearMap.get("yearEndDate"));
	    	
	        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	        
	        Date sDate = format.parse(startDate);
	        Date eDate = format.parse(endDate);
	        Date ysDate = format.parse(yearStartDate);
	        Date yeDate = format.parse(yearEndDate);
	        
	        //년단위 시작일 ~ 년단위 종료일의 날짜 차이 - 목표건수 계산용
	  	  	long calDate = yeDate.getTime() - ysDate.getTime() + 86400000; 
	    	long purposeYearPeriod = Math.abs( calDate / (24*60*60*1000) );
	    	
	    	int year = Integer.parseInt(endDate.split("-")[0]);
	    	int month = Integer.parseInt(endDate.split("-")[1]);
	    	int day = Integer.parseInt(endDate.split("-")[2]);
	    	
			if (month == 12 && day > 15){
				++year;
			}
			paramMap.put("year", year);
		    //========================================================
		    //  직원 정보 추출
		    //========================================================			
			paramMap = sqlSession.selectOne("StatisticWorkloadMapper.selectMbrInfo",paramMap);			
			
		    //========================================================
		    //  기준일 생성 - 입사일/퇴사일/면수습일 반영
		    //========================================================
			String joinDate = String.valueOf(paramMap.get("joinDate"));
			String outDate = String.valueOf(paramMap.get("outDate"));
			String probationDate = String.valueOf(paramMap.get("probationDate"));
			
			
			Date jDate = format.parse(joinDate);
			Date oDate;
			Date pDate = format.parse(probationDate);
			if ( "1970-01-01".equals(outDate) ){
				outDate = yearEndDate;
			}
			oDate = format.parse(outDate); 
			
			//입사일 > 검색 시작일
			if (jDate.after(sDate)){ 
				startDate = joinDate;
			}
			
			
			//면수습일 > 검색 시작일 (2023-03-23 : 면수습일 조건 제거 by top3009)
			//if (pDate.after(sDate)){
				//startDate = probationDate;
			//}
			
			
			//퇴사일 < 검색 시작일
			if (oDate.before(eDate)){
				endDate = outDate;
			}
			
			
			// 목표건수 기준일 생성
			// 입사일 > 년도 시작일
			if (jDate.after(ysDate)){ 
				yearStartDate = joinDate;
			}
			
			
			// 면수습일 > 년도 시작일 (2023-03-23 : 면수습일 조건 제거 by top3009)			
			//if (pDate.after(ysDate)){ 
				//yearStartDate = probationDate;
			//}
			
			
			// 퇴사일 < 년도 종료일			
			if (oDate.before(yeDate)){
				yearEndDate = outDate;
			}
			paramMap.put("startDate", startDate);
			paramMap.put("endDate", endDate);
			paramMap.put("outDate", outDate);
			paramMap.put("probationDate", probationDate);
			
			paramMap.put("yearStartDate", yearStartDate);
			paramMap.put("yearEndDate", yearEndDate);
			
			paramMap.put("gubun", gubun);
			paramMap.put("year", year);
			
			paramMap.put("purposeYearPeriod", purposeYearPeriod);
			
			
    	} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
	    }
    	
	    return paramMap;
    }
    
    /*
     * 기준업무량 계산을 위한 직무반영 시작일, 종료일 계산
     * 
     */
    public List<Map<String,Object>> WorkloadCalc(List<Map<String,Object>> memberList, List<String> teamList, String gubun){
    	
		List<Map<String,Object>> jobList = new ArrayList<>();
		
		//검색일 반영을 위한 Map
		Map<String,String> workDateMap = new HashMap<>();
		workDateMap.put("sFlag","N");	//검색 시작일 반영 Flag 값
		workDateMap.put("eFlag","N");	//검색 종료일 반영 Flag 값
		
    	for(Map<String,Object> userMap : memberList){
    		
            //========================================================
            //	발령 내용을 기반으로 직무시작일-직무종료일 추출
            //========================================================		
    		String userNo = String.valueOf(userMap.get("userNo"));
    		
    		List<HashMap<String,Object>> myWorkJobMap = sqlSession.selectList("StatisticWorkloadMapper.selectMemberWorkJob",userMap);
    		String jobCd,yearEa,teamId ="";
    		
    		String startDate = String.valueOf(userMap.get("startDate"));
    		String endDate = String.valueOf(userMap.get("endDate"));
    		
    		String yearStartDate = String.valueOf(userMap.get("yearStartDate"));
    		String yearEndDate = String.valueOf(userMap.get("yearEndDate"));
    		
    		String outDate = String.valueOf(userMap.get("outDate")); //퇴직일
    		String probationDate = String.valueOf(userMap.get("probationDate")); //면수습일
    		
    		String purposeYearPeriod = String.valueOf(userMap.get("purposeYearPeriod")); //목표건 계산을 위한 값
    		
    		workDateMap.put("startDate",startDate);
    		workDateMap.put("endDate",endDate);
    		workDateMap.put("probationDate",probationDate);
    		
    		if ( myWorkJobMap.size() > 1){
    			for (int i=0; i < myWorkJobMap.size(); i++){
    				HashMap<String,Object> jobMap = new HashMap<>();
    				
    				if ( !"".equals(myWorkJobMap.get(i).get("workJob")) ){
    					jobCd = String.valueOf( myWorkJobMap.get(i).get("workJob") );
    					yearEa = String.valueOf( myWorkJobMap.get(i).get("yearEa") );
    					teamId = String.valueOf( myWorkJobMap.get(i).get("appointTeamId") );
    				}else{
    					jobCd = String.valueOf( myWorkJobMap.get(i+1).get("workJob") );
    					yearEa = String.valueOf( myWorkJobMap.get(i+1).get("yearEa") );
    					teamId = String.valueOf( myWorkJobMap.get(i+1).get("appointTeamId") );
    				}
    				
    				jobMap.put("userNo", userNo );
    				jobMap.put("jobCd", jobCd);
    				jobMap.put("yearEa", yearEa);
    				jobMap.put("teamId", teamId);
    				
    				String perposeStartDate, perposeEndDate = "";
					String wsDateStr, weDateStr, psDateStr, peDateStr;
    				
    				if ( i == 0 ){
    					wsDateStr = yearStartDate;
    					//발령일 기준 발령 전날의 하루전으로 계산해야 발령일자의 실적이 중복되지 않는다. (예 : 4월1일 발령시 발령전 종료일은 3월 31일로 처리)
    					//weDateStr = String.valueOf(myWorkJobMap.get(i+1).get("workJobDate"));
    					weDateStr = DateUtil.addDateNew(String.valueOf(myWorkJobMap.get(i+1).get("workJobDate")), -1);
    					psDateStr = yearStartDate;
    					peDateStr = String.valueOf(myWorkJobMap.get(i+1).get("workJobDate"));
    				}else if (i+1 == myWorkJobMap.size() ){
    					wsDateStr = String.valueOf(myWorkJobMap.get(i).get("workJobDate"));
    					weDateStr = yearEndDate;
    					psDateStr = String.valueOf(myWorkJobMap.get(i).get("workJobDate"));
    					peDateStr = outDate;
    				}else{
    					wsDateStr = String.valueOf(myWorkJobMap.get(i).get("workJobDate"));
    					weDateStr =  String.valueOf(myWorkJobMap.get(i+1).get("workJobDate"));
    					psDateStr = String.valueOf(myWorkJobMap.get(i).get("workJobDate"));
    					peDateStr = String.valueOf(myWorkJobMap.get(i+1).get("workJobDate"));
    				}
    				
					workDateMap.put("wsDateStr", wsDateStr);
					workDateMap.put("weDateStr", weDateStr);
					workDateMap.put("psDateStr", psDateStr);
					workDateMap.put("peDateStr", peDateStr);
					
					workDateMap = setWorkDate(workDateMap);
    				
    				jobMap.put("workStartDate", workDateMap.get("workStartDate"));
    				jobMap.put("workEndDate", workDateMap.get("workEndDate"));
    				
    				jobMap.put("perposeStartDate", workDateMap.get("perposeStartDate"));
    				jobMap.put("perposeEndDate", workDateMap.get("perposeEndDate"));
//	    				
    				jobMap.put("purposeYearPeriod",purposeYearPeriod);
    				
    				if (!wsDateStr.equals(weDateStr)){
    					jobList.add(jobMap);
    				}
    			}
    		}else{
    			
    			HashMap<String,Object> jobMap = new HashMap<>();
    			jobMap.put("userNo", userNo);
    			
    			
				workDateMap.put("wsDateStr", yearStartDate);
				workDateMap.put("weDateStr", yearEndDate);
				workDateMap.put("psDateStr", yearStartDate);
				workDateMap.put("peDateStr", yearEndDate);
				
				workDateMap = setWorkDate(workDateMap);
    			
				
				jobMap.put("workStartDate", workDateMap.get("workStartDate"));
				jobMap.put("workEndDate", workDateMap.get("workEndDate"));
				jobMap.put("perposeStartDate", workDateMap.get("perposeStartDate"));
				jobMap.put("perposeEndDate", workDateMap.get("perposeEndDate"));
				jobMap.put("purposeYearPeriod",purposeYearPeriod);
				
				/* 당해년도 입사 - 면수습자들 면수습일 미적용으로 인해 수정 주석 */
				jobMap.put("workStartDate", startDate);
				jobMap.put("workEndDate", endDate);
    			jobMap.put("perposeStartDate", yearStartDate);
    			jobMap.put("perposeEndDate", yearEndDate);
				jobMap.put("purposeYearPeriod",purposeYearPeriod);
    			
    			jobMap.put("jobCd", userMap.get("mbrWorkJob"));
    			jobMap.put("yearEa", userMap.get("mbrYearEa"));
    			jobMap.put("teamId", userMap.get("mbrTeamId"));
    			
    			
				//String wsDate = String.valueOf(jobMap.get("workStateDate"));
				//String weDate = String.valueOf(jobMap.get("workEndDate"));
				//if (!wsDate.equals(weDate)){
				//	jobList.add(jobMap);
				//}
				
				jobList.add(jobMap);
    		} 
    	}
		return jobList;
    }
    
    
    /**
     * 년단위 기준일 생성
     * @return YearMap
     */
    public Map<String,Object> setYearDate(String baseDate){
    	
    	
    	String startDate,endDate = "";
    	int nowYear,nowMonth,nowDay;
    	if (baseDate == null || "".equals(baseDate)){
    		Calendar calendar = Calendar.getInstance();
         	nowYear = calendar.get(Calendar.YEAR);
    		nowMonth = calendar.get(Calendar.MONTH)+1;
    		nowDay = calendar.get(Calendar.DAY_OF_MONTH);
    	}else{
    		String[] tmpDate = baseDate.split("-");
    		nowYear = Integer.parseInt(tmpDate[0]);
    		nowMonth = Integer.parseInt(tmpDate[1]);
    		nowDay = Integer.parseInt(tmpDate[2]);
    	}
    	  
    	if ( nowMonth == 12  && nowDay > 15 ){
    		startDate = nowYear + "-12-16";
    		endDate = nowYear+1 +"-12-15"; 
    	}else{
    		startDate = nowYear-1 + "-12-16";
    		endDate = nowYear +"-12-15"; 
    	}
    	
    	Map<String,Object> yearMap = new HashMap<>();
    	yearMap.put("yearStartDate",startDate);
    	yearMap.put("yearEndDate",endDate);
    	
    	return yearMap;
    }
    
    
    /*
     * 해당 날짜 기준으로 검색 가능하도록 직무일에 검색일 반영
     * startDateStr : 검색 시작일
     * endDateStr	: 검색 종료일
     * wsDateStr	: 직무 시작일
     * weDateStr	: 직무 종료일
     * psDateStr	: 목표건수 기준 시작일
     * peDateStr	: 목표건수 기준 종료일
     * sFlag		: 검색 시작일 반영 구분 값
     * eFlag		: 검색 종료일 반영 구분 값
     */
    public Map<String,String> setWorkDate(Map<String,String> paramMap){
		
    	String startDateStr = paramMap.get("startDate");
    	String endDateStr = paramMap.get("endDate");
    	String probationDateStr = paramMap.get("probationDate");
    	
    	String wsDateStr = paramMap.get("wsDateStr"); 
    	String weDateStr = paramMap.get("weDateStr");
    	String psDateStr = paramMap.get("psDateStr");
    	String peDateStr = paramMap.get("peDateStr");
    	
    	String sFlag = paramMap.get("sFlag");
    	String eFlag = paramMap.get("eFlag");
		String workStartDate , workEndDate = "";
		String perposeStartDate , perposeEndDate = "";
		
    	
    	try {
	    	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	    	Date sDate, eDate, pDate, wsDate, weDate, psDate, peDate;
	    	
			sDate = format.parse(startDateStr);
	    	eDate = format.parse(endDateStr);
	    	pDate = format.parse(probationDateStr);
	    	
			wsDate = format.parse(wsDateStr);
			weDate = format.parse(weDateStr);
			
			psDate = format.parse(psDateStr);
			peDate = format.parse(peDateStr);
			
			
			/* 직무 시작일 계산 */
			if ( wsDate.equals(weDate) || sDate.after(weDate) ||"Y".equals(eFlag) ){
				workStartDate = "1970-01-01";
				workEndDate = "1970-01-01";								
			}else{
				if ( weDate.after(eDate) && "N".equals(eFlag) ){
					workEndDate = endDateStr;
					eFlag = "Y";
				}else{
					workEndDate = weDateStr;
				}
				
				if ( (weDate.after(sDate) || weDate.equals(sDate))  && "N".equals(sFlag) ){
					workStartDate = startDateStr;
					sFlag = "Y";
				}else{
					workStartDate = wsDateStr;
				}
			}
			
			/* 면수습 체크로직 제거 by top3009 (2023-04-18)
			if (pDate.after(wsDate) && pDate.before(weDate) && !wsDate.equals(weDate)){
				workStartDate = probationDateStr;
			}
			*/
			
			
			
			if (!psDate.equals(peDate)){
				/* 면수습 체크로직 제거 by top3009 (2023-04-18)
				if (pDate.after(psDate) && pDate.before(peDate)){
					perposeStartDate = probationDateStr;
				}else{
					perposeStartDate = psDateStr;
				}
				*/
				perposeStartDate = psDateStr;
			}else{
				perposeStartDate = psDateStr;
			}
			perposeEndDate = peDateStr;
			
			paramMap.put("workStartDate", workStartDate);
			paramMap.put("workEndDate", workEndDate);
			
			paramMap.put("perposeStartDate", perposeStartDate);
			paramMap.put("perposeEndDate", perposeEndDate);
			
			
			paramMap.put("sFlag", sFlag);
			paramMap.put("eFlag", eFlag);
			
			
	    } catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	return paramMap;
    	
    }
    
    
    /**
     * 기준업무량 백분위 계산을 위하여 매일 00:00에 배치
     */
    public void insertWorkloadDaily(){
    	
        //========================================================
        //  기준일 생성 (당해년도 1년치)
        //========================================================  	
    	Map<String,Object> yearMap = this.setYearDate(null);
    	String startDate = String.valueOf(yearMap.get("yearStartDate"));
    	String endDate = String.valueOf(yearMap.get("yearEndDate"));
  	  	
  	  	Map<String,Object> paramMap = new HashMap<String,Object>();
        paramMap.put("yearStartDate",  startDate);
        paramMap.put("yearEndDate", endDate);
        paramMap.put("startDate",  startDate);
        paramMap.put("endDate", endDate);
        
        paramMap.put("gubun", "member");
        paramMap.put("basicYN", "Y");
        paramMap.put("primYN", "Y");
        
        List<String> userList = null;
        List<String> teamList = new ArrayList<>();
        paramMap.put("teamList", teamList);
        userList =  sqlSession.selectList("StatisticWorkloadMapper.selectPickTeamOrMember",paramMap);    
    	
		//기준업무량 년도 구분
		Calendar cal = Calendar.getInstance();    
		cal.setTime(new Date());    		
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
		String today = df.format(cal.getTime());
//		String today = "2018-12-16";
		
		int year = Integer.parseInt(today.split("-")[0]);
		int month = Integer.parseInt(today.split("-")[1]);
		int day = Integer.parseInt(today.split("-")[2]);
		
		if (month == 12 && day > 15){
			++year;
		}
        paramMap.put("year", year);
        //========================================================
        //  반환 데이터 - 팀의 기준업무량 합계
        //========================================================
    	List<Map<String,Object>> workloadList =new ArrayList<>();
        
   		for(String userNo : userList){
    		Map<String,Object> userMap = new HashMap<>();
    		userMap.put("userNo", userNo);
    		userMap.put("startDate", paramMap.get("startDate"));
    		userMap.put("endDate", paramMap.get("endDate"));
    		
    		userMap = setWorkloadStdDate(userMap);
        	
        	List<Map<String,Object>> memberList = new ArrayList<>();
        	teamList = (List<String>) paramMap.get("teamList");
        	memberList.add(userMap);
        	
        	List<Map<String,Object>> jobList = WorkloadCalc(memberList,teamList,"person");
        	paramMap.put("jobList", jobList);
        	paramMap.put("jobListSize", jobList.size());
        	
        	Map<String,Object> tmpMap = new HashMap<>();
       	 	paramMap.put("userNo", userNo);
       	 	
       	 	tmpMap = sqlSession.selectOne("StatisticWorkloadMapper.selectMyWorkLoadSumStatistics",paramMap);
       	 	sqlSession.insert("StatisticWorkloadMapper.insertWorkloadDaily",tmpMap);
       	 	
       	 	//백분위 계산을 위한 임시 테이블
       	 	//운영서버에서 배치가 2번돌아서 임시로 막음
       	 	//int cnt = sqlSession.selectOne("StatisticWorkloadMapper.selectWorkloadDupChk",userNo);
       	 	//if (cnt == 0){
	       	// 	sqlSession.insert("StatisticWorkloadMapper.insertWorkloadDaily",tmpMap);
       	 	//}
       	 	
       	 	//Out of resources when opening file './toplac/top_rpt_body.MYD'
       	 	//위 에러 발생하여 우선 for돌려놈
       	 	workloadList.add(tmpMap);
        }
		
   		//RANK 수정 부분
		List<Map<String,Object>> rankList = sqlSession.selectList("StatisticWorkloadMapper.selectWorkloadRank", paramMap);
		for(Map<String,Object> rank : rankList){
			sqlSession.update("StatisticWorkloadMapper.updateWorkloadRank",rank);
		}
		
    	
    }
    
    
    
    
    

}