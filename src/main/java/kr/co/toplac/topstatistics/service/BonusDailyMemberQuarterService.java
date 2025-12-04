package kr.co.toplac.topstatistics.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.RequestUtil;

@Service
public class BonusDailyMemberQuarterService {

	private static final Logger logger = LoggerFactory.getLogger(WorkloadService.class);

    @Autowired
    SqlSession sqlSession;
	
	public void syncProcess() {
		
		logger.info("==== BonusDailyMemberQuarterService ==== ");

        Map<String, Object> paramMap = new HashMap<>();
        
        //기준일자
        String sToday = DateUtil.getTodayString("yyyy-MM-dd");		//오늘 날짜(시스템에서 실행되는 날짜)
    	String sBaseDate = DateUtil.addDateNew(sToday, -1);			//어제 날짜(보고서 정산날짜)
    	String sBaseYear = DateUtil.getBaseYear(sBaseDate);			//기준년도
    	
    	int nYearDays = 365;				//윤년계산으로 인해 날짜수 변수처리
    	
    	nYearDays = DateUtil.getYearToDays(sBaseYear);
    	
    	//기준연도 분기별 팀(센터)장 목록을 불러온다.
    	paramMap.put("base_year", sBaseYear);
    	List<Map<String, Object>> managerList = sqlSession.selectList("ItMgmtMapper.selectSchBonusManagerListQuarterSearchByBaseYear", paramMap);    	
    	
    	//등록된 팀(센터)장 갱신 시작
    	String sMkey = "";
    	String sDate = "";
    	String eDate = "";
    	String sManagerName = "";
    	String sManagerNo = "";
    	
    	int nManagerUpdateCnt = 0;
    	
    	for(int m=0; m < managerList.size(); m++) {
    		
    		sMkey = String.valueOf(managerList.get(m).get("mkey"));
    		sDate = String.valueOf(managerList.get(m).get("sdate_fmt"));
    		eDate = String.valueOf(managerList.get(m).get("edate_fmt"));
    		sManagerName = String.valueOf(managerList.get(m).get("manager_name"));
    		sManagerNo = String.valueOf(managerList.get(m).get("manager_no"));
    		
    		paramMap.put("mkey", sMkey);
			
    		Map<String, Object> infoMap = sqlSession.selectOne("ItMgmtMapper.selectBonusManagerInfoByMkey", paramMap);
    		
    		String sUserName = String.valueOf(infoMap.get("manager_name"));
    		String sUserNo = String.valueOf(infoMap.get("manager_no"));
    		
    		//수정해야 할 데이터 계산 시작
    		int nBasicAmtSum = 0;		//실적합계 ( 기본료 합계 = 일반보고서 본인담당건 - 공동수행 지급 + 공동 수행 수령 + 농작물 실적) : bonus_pay
    		
    		double dWorkday = 0;					//실적계산용 근무일 (workday_cnt)		
    		double dWorkdayInterval = 0;		//기준일 (workday_interval)
    		int nWorkdayPer = 0;					//근무율 퍼센트 (workday_per)
    		
    		double dWorkload_target = 0;			//환산목표건수 (workload_target)
        	double dWorkload_cnt = 0;				//개인 실적건수 (workload_cnt)
        	double dWorkload_per = 0;				//개인 기준업무량 달성율 (workload_per)
        	String sCalWorkloadSum = "";			//개인 기준업무량 합산값
        	double workload_cnt_temp = 0;			//개인 기준업무량 음수체크값    	
        	int nTargetCnt = 0;							//연간 목표건수 
        	
        	String sWorkSdate = String.valueOf(infoMap.get("work_sdate"));    	
        	
        	int nChkWork = 0;			//실적계산 시작일 체크    	
        	nChkWork = DateUtil.compareDate(sDate, sWorkSdate);    	
        	
        	if( nChkWork > 0 ) {						//시작 기준일보다 실적 시작일이 이후 인경우 실적 시작일 기준으로 계산한다. 
        		sDate = sWorkSdate;
        	}
        	
        	nChkWork = DateUtil.compareDate(eDate, sWorkSdate);
        	
        	if( nChkWork > 0 ) {						//실적 시작일이 종료기준일보다 이후 인경우 실적계산용 근무일을 0으로 처리한다.
        		dWorkday = 0;
        	}else if( DateUtil.compareDate(sDate, sWorkSdate) > 0 && nChkWork <= 0 ) {			//실적 시작일이 모달 입력창 시작일과 종료일 사이에 있는경우
        		dWorkday = DateUtil.getDiffDayCountNew(sWorkSdate, eDate)+1;
        	}else{
        		dWorkday = DateUtil.getDiffDayCountNew(sDate, eDate)+1;
        	}
        	
        	//근무일, 목표일, 근무율은 실적기준일 기준으로 재계산한다.
        	dWorkdayInterval = DateUtil.getDiffDayCountNew(sDate, eDate)+1;			//근무기준일이나 근무일은 실적과 상관없으므로 모달창 기준으로 계산한다.
        	
        	if( dWorkdayInterval < 0 ) {
        		dWorkdayInterval = 0;
        	}
        	
    		//dWorkdayOrg = dWorkdayInterval;        	
        	nWorkdayPer = 100;
        	
        	//휴직 처리 시작
        	
        	int nWorkChk = 0;							//기간 내 휴직 체크변수
        	double dCalSum = 0;						//기간 내 휴직일자 합산값
        	String workSdate = "";						//기간 내 휴직 시작일
        	String workEdate = "";						//기간 내 휴직 종료일
        	String calSdate = "";						//휴직계산 시작일
        	String calEdate = "";						//휴직계산 종료일
        	
        	String remakeSdate = "";					//재계산 시작기준일
        	String remakeEdate = "";					//재계산 종료기준일
        	
        	Map<String, Object> workMap = new HashMap<>();    	
    		workMap.put("sDate", sDate);
    		workMap.put("eDate", eDate);
    		workMap.put("user_no", sUserNo);		
        	
        	List<Map<String, Object>> workList = sqlSession.selectList("SuimSchedule.SchBonusWorkListByReverse", workMap);
        	
        	nWorkChk = workList.size();    	

        	if( nWorkChk == 0 ) {					//휴직이 없는 경우(기준일과 근무일이 동일하고 근무율을 100%)
        		dWorkday = dWorkdayInterval;
        		
        		if( dWorkday < 0 ) {
        			nWorkdayPer = 0;
        		}else {
        			nWorkdayPer = 100;
        		}
        	}else{										//기간중 휴직이 있는 경우
        		
        		int nChk = 0;
        		dCalSum = 0;		//휴직일 합계값 초기화
        		
        		remakeSdate = sDate;
        		remakeEdate = eDate;    		
        		
        		for( int r=0; r < workList.size(); r++) {
        			workSdate = String.valueOf(workList.get(r).get("work_sdate"));
        			workEdate = String.valueOf(workList.get(r).get("work_edate"));
        			
        			//휴직 시작일계산
        			nChk = DateUtil.compareDate(remakeSdate, workSdate);
        			
        			if( nChk > 0 ) {					//휴직일자가 실적시작일 이후 인 경우
        				calSdate = workSdate;
        			}else{
        				calSdate = remakeSdate;
        			}
        			
        			//휴직 종료일 계산
        			nChk = DateUtil.compareDate(remakeEdate, workEdate);
        			
        			if( nChk > 0 ) {		//휴직종료날짜가 실적종료일 이후인경우
        				calEdate = remakeEdate;    						
        			}else{
        				calEdate = workEdate;
        			}
        			
        			dCalSum += DateUtil.getDiffDayCountNew(calSdate, calEdate)+1;    					
        		}
        		
        		dWorkday = dWorkdayInterval - dCalSum;			//근무일 (기준근무일 - 휴직일 합계) 계산 끝
        		
        		if( dWorkday < 1) {									//근무일이 없는경우
        			dWorkday = 0;
        			nWorkdayPer = 0;
        		}else{
        			nWorkdayPer = (int) Math.round( dWorkday / dWorkdayInterval * 100 );
        		}
        	}    	
        	//휴직 처리 끝 
        	
    		//기준업무량 목표건 시작        	
        	String sWorkJob = String.valueOf(infoMap.get("work_job"));
        	sBaseYear = String.valueOf(infoMap.get("base_year"));
    		String sJobCodeFull = "workload_job_code_"+sBaseYear;
        	
    		workMap.put("base_year", sBaseYear);
    		workMap.put("work_job", sWorkJob);
    		workMap.put("job_code_full", sJobCodeFull);    			
    		
    		nTargetCnt = sqlSession.selectOne("SuimSchedule.selectWorkTargetByWorkjob", workMap);
    		
    		if( nTargetCnt > 0 && dWorkday > 0 ) {			//연간 목표건수가 있는 경우 일할 계산한다.
    			//기준업무량 환산용 목표건 설정 yearEa
    			workMap.put("yearEa", nTargetCnt);
    			
    			dWorkload_target = Double.parseDouble(String.valueOf(nTargetCnt));
    			dWorkload_target = (dWorkload_target * dWorkday) / nYearDays;
    			dWorkload_target = (Math.round(dWorkload_target * 1000) / 1000.000);
    		}else{
    			dWorkload_target = 0;
    		}
    		//기준업무량 목표건 끝
    		
    		//기준업무량 실적 시작		
    		
    		workMap.put("sDate", sDate);
    		workMap.put("eDate", eDate);
    		workMap.put("user_no", sUserNo);
    		
    		sCalWorkloadSum = sqlSession.selectOne("SuimSchedule.schWorkloadEaAllQuarter", workMap);
    		
    		workload_cnt_temp = Double.parseDouble(sCalWorkloadSum);
    		
    		if( workload_cnt_temp < 0 ) {
    			sCalWorkloadSum = "0";
    		}
    		
    		dWorkload_cnt = Double.parseDouble(sCalWorkloadSum);    			
    		//기준업무량 실적 끝
    		
    		//기준업무량 달성율 시작
    		if( dWorkload_target > 0 &&  dWorkload_cnt > 0) {			//기준값과 실적값이 존재하는 경우만 계산한다.
    			dWorkload_per = (dWorkload_cnt * 100) / dWorkload_target;
    			dWorkload_per = (Math.round(dWorkload_per * 10000) / 10000.0000);		//달성율(소숫점4자리)
    		}else{
    			dWorkload_per = 0;
    		}
    		//기준업무량 달성율 끝
    		
    		//실적 계산
    		nBasicAmtSum = sqlSession.selectOne("SuimSchedule.schBonusPayAllQuarter", workMap);
    		
    		//갱신할 정보 Map
    		infoMap.put("sdate", sDate);
    		infoMap.put("edate", eDate);
    		
    		//infoMap.put("workday_cnt", dWorkdayOrg);
    		
    		infoMap.put("workday_cnt", dWorkday);						//실적 근무일 기준으로 재계산
    		infoMap.put("workday_interval", dWorkdayInterval);
    		infoMap.put("workday_per", nWorkdayPer);
    		
    		infoMap.put("workload_target", dWorkload_target);
    		infoMap.put("workload_cnt", dWorkload_cnt);
    		infoMap.put("workload_per", dWorkload_per);
    		
    		infoMap.put("bonus_pay", nBasicAmtSum);
    		
        	//CommonUtils.printMap(infoMap);
        	  		
        	sqlSession.update("ItMgmtMapper.updateBonusManagerInfoByMkey", infoMap);
        	
        	nManagerUpdateCnt++;
    	}    	
    	//등록된 팀(센터)장 갱신 끝
    	    	
    	
    	String sTeamId = "";			//팀장 팀 아이디
    	String sTeamCenter = "";    	//센터장 센터 아이디
    	String sWorkType = "";			//팀장,센터장(3 : 팀장, 14 : 센터장)
    	String sQuarterFlag = "";		//분기 구분    	
    	String sSdate = "";				//관리자 시작일자
    	String sEdate = "";				//관리자 종료일자
    	String sMemberSdate = "";	//팀원 실적시작일자
    	String sMemberEdate = "";	//팀원 실적종료일자
    	String sMemberUserNo = "";	//팀원 사번
    	String sMemberUserName = "";	//팀원 이름
    	String sMemberWorkJob = "";	//기준업무량 재계산시 workjob
    	String sJobCodeFull = "workload_job_code_"+sBaseYear;
    	
    	int nChkSdate = 0;
    	
    	//실적 재계산시 사용할 변수 시작
    	int nBasicAmtSum = 0;		//실적합계 ( 기본료 합계 = 일반보고서 본인담당건 - 공동수행 지급 + 공동 수행 수령 + 농작물 실적) : bonus_pay		
		double dWorkday = 0;					//실적계산용 근무일 (workday_cnt)
		double dWorkdayOrg = 0;				//모달창 입력된 시작종료일자 근무일
		double dWorkdayInterval = 0;		//기준일 (workday_interval)
		int nWorkdayPer = 0;					//근무율 퍼센트 (workday_per)
		
		double dWorkload_target = 0;			//환산목표건수 (workload_target)
    	double dWorkload_cnt = 0;				//개인 실적건수 (workload_cnt)
    	double dWorkload_per = 0;				//개인 기준업무량 달성율 (workload_per)
    	String sCalWorkloadSum = "";			//개인 기준업무량 합산값
    	double workload_cnt_temp = 0;			//개인 기준업무량 음수체크값    	
    	int nTargetCnt = 0;							//연간 목표건수
    	
    	String remakeSdate = "";					//재계산 시작기준일
    	String remakeEdate = "";					//재계산 종료기준일
    	
    	int nWorkChk = 0;							//기간 내 휴직 체크변수
    	double dCalSum = 0;						//기간 내 휴직일자 합산값
    	String workSdate = "";						//기간 내 휴직 시작일
    	String workEdate = "";						//기간 내 휴직 종료일
    	String calSdate = "";						//휴직계산 시작일
    	String calEdate = "";						//휴직계산 종료일    	
    	//실적 재계산시 사용할 변수 끝
    	
    	//스케줄러 등록시 중복체크
    	int nDupChk = 0;
    	int nInsertCnt = 0;							//등록된 데이터 수
    	
    	//관리자 발령일자
    	String sApDate = "";
    	
        for( int i=0; i < managerList.size(); i++ ) {
        	Map<String,Object> managerMap = managerList.get(i);        	
        	//CommonUtils.printMap(ManagerMap);
        	//기준(정산)일자 추가
        	managerMap.put("base_date", sBaseDate);
        	sManagerNo = String.valueOf(managerList.get(i).get("manager_no"));
        	sManagerName = String.valueOf(managerList.get(i).get("manager_name"));
        	sTeamId = String.valueOf(managerList.get(i).get("team_id"));
        	sTeamCenter = String.valueOf(managerList.get(i).get("team_center"));
        	sWorkType = String.valueOf(managerList.get(i).get("work_type"));        	
        	sQuarterFlag = String.valueOf(managerList.get(i).get("quarter_flag"));        	
        	sSdate = String.valueOf(managerList.get(i).get("sdate_fmt"));
        	sEdate = String.valueOf(managerList.get(i).get("edate_fmt"));
        	sApDate = sqlSession.selectOne("ItMgmtMapper.selectBonusManagerInfoByAppointDate", managerList.get(i));
        	managerMap.put("ap_date_fmt", sApDate);
        	
        	List<Map<String, Object>> memberList = sqlSession.selectList("ItMgmtMapper.selectSchBonusMemberListQuarterByTeamId",managerMap);
        	        	
    		for( int k=0; k < memberList.size(); k++) {    			
    			Map<String, Object> memberMap = memberList.get(k);
    			//관리자 사번,이름을 넣어준다.
    			memberMap.put("manager_no", sManagerNo);
    			memberMap.put("manager_name", sManagerName);
    			
    			//관리자(팀장,센터장)의 시작일자와 팀원의 시작 일자가 동일한지 체크한다.
    			sMemberSdate = String.valueOf(memberList.get(k).get("sdate_fmt"));
    			sMemberEdate = String.valueOf(memberList.get(k).get("edate_fmt"));
    			sMemberUserNo = String.valueOf(memberList.get(k).get("user_no"));
    			sMemberUserName = String.valueOf(memberList.get(k).get("user_name"));
    			sMemberWorkJob = String.valueOf(memberList.get(k).get("work_job"));
    			
    			//nChkSdate = DateUtil.compareDate(sMemberSdate, sSdate);
    			//팀장 실적 시작일에서 발령일로 변경
    			nChkSdate = DateUtil.compareDate(sMemberSdate, sApDate);    			
    			   			
    			if( nChkSdate > 0 ) {				//팀원 실적 시작일보다 팀장의 시작일이 이후인경우
    				
    				//remakeSdate = sSdate;
    				remakeSdate = sApDate;    				
    				remakeEdate = sMemberEdate;
    				
    				Map<String, Object> workMap = new HashMap<>();
    				workMap.put("sDate", remakeSdate);
    				workMap.put("eDate", remakeEdate);
    				workMap.put("user_no", sMemberUserNo);
    				workMap.put("base_year", sBaseYear);
    				
    				//dWorkdayInterval = DateUtil.getDiffDayCountNew(sSdate, sMemberEdate)+1;			//목표일 계산 끝
    				dWorkdayInterval = DateUtil.getDiffDayCountNew(sApDate, sMemberEdate)+1;			//목표일 계산 끝
    				
    				//휴직 처리시작
    				List<Map<String, Object>> workList = sqlSession.selectList("SuimSchedule.SchBonusWorkList", workMap);

    				nWorkChk = workList.size();

    				if( nWorkChk == 0 ) {					//휴직이 없는 경우(기준일과 근무일이 동일하고 근무율을 100%)
    					dWorkday = dWorkdayInterval;
    					nWorkdayPer = 100;
    				}else{										//기간중 휴직이 있는 경우
    					
    					int nChk = 0;
    					dCalSum = 0;		//휴직일 합계값 초기화
    					
    					for( int r=0; r < workList.size(); r++) {
    						workSdate = String.valueOf(workList.get(r).get("work_sdate"));
    						workEdate = String.valueOf(workList.get(r).get("work_edate"));
    						
    						//휴직 시작일계산
    						nChk = DateUtil.compareDate(remakeSdate, workSdate);
    						
    						if( nChk > 0 ) {					//휴직일자가 실적시작일 이후 인 경우
    							calSdate = workSdate;
    						}else{
    							calSdate = remakeSdate;
    						}
    						
    						//휴직 종료일 계산
    						nChk = DateUtil.compareDate(remakeEdate, workEdate);
    						
    						if( nChk > 0 ) {		//휴직종료날짜가 실적종료일 이후인경우
    							calEdate = remakeEdate;    						
    						}else{
    							calEdate = workEdate;
    						}
    						
    						dCalSum += DateUtil.getDiffDayCountNew(calSdate, calEdate)+1;    					
    					}
    					
    					dWorkday = dWorkdayInterval - dCalSum;			//근무일 (기준근무일 - 휴직일 합계) 계산 끝
    					
    					if( dWorkday < 1) {									//근무일이 없는경우
    						dWorkday = 0;
    						nWorkdayPer = 0;
    					}else{
    						nWorkdayPer = (int) Math.round( dWorkday / dWorkdayInterval * 100 );
    					}
    				}
    				//휴직 처리 끝
    				
    				//기준업무량 목표건 시작    				
    				workMap.put("work_job", sMemberWorkJob);
    				workMap.put("job_code_full", sJobCodeFull);    			

    				nTargetCnt = sqlSession.selectOne("SuimSchedule.selectWorkTargetByWorkjob", workMap);

    				if( nTargetCnt > 0 && dWorkday > 0 ) {			//연간 목표건수가 있는 경우 일할 계산한다.
    					//기준업무량 환산용 목표건 설정 yearEa
    					workMap.put("yearEa", nTargetCnt);
    					
    					dWorkload_target = Double.parseDouble(String.valueOf(nTargetCnt));
    					dWorkload_target = (dWorkload_target * dWorkday) / nYearDays;
    					dWorkload_target = (Math.round(dWorkload_target * 1000) / 1000.000);
    				}else{
    					dWorkload_target = 0;
    				}    			    			
    				//기준업무량 목표건 끝

    				//기준업무량 실적 시작
    				sCalWorkloadSum = sqlSession.selectOne("SuimSchedule.schWorkloadEaAllQuarter", workMap);

    				workload_cnt_temp = Double.parseDouble(sCalWorkloadSum);

    				if( workload_cnt_temp < 0 ) {
    					sCalWorkloadSum = "0";
    				}

    				dWorkload_cnt = Double.parseDouble(sCalWorkloadSum);    			
    				//기준업무량 실적 끝

    				//기준업무량 달성율 시작
    				if( dWorkload_target > 0 &&  dWorkload_cnt > 0) {			//기준값과 실적값이 존재하는 경우만 계산한다.
    					dWorkload_per = (dWorkload_cnt * 100) / dWorkload_target;
    					dWorkload_per = (Math.round(dWorkload_per * 10000) / 10000.0000);		//달성율(소숫점4자리)
    				}else{
    					dWorkload_per = 0;
    				}
    				//기준업무량 달성율 끝
    				
    				//실적 재계산
    				nBasicAmtSum = sqlSession.selectOne("SuimSchedule.schBonusPayAllQuarter", workMap);
    				
    				//수정된 값으로 memberMap 에 넣어준다.
    				memberMap.put("sdate_fmt", remakeSdate);								//시작일자 수정
    				memberMap.put("workday_interval", (int)dWorkdayInterval);			//목표일
    				memberMap.put("workday_cnt", (int)dWorkday);							//근무일
    				memberMap.put("workday_per", nWorkdayPer);							//근무율    				
    				memberMap.put("workload_target", dWorkload_target);				//기준업무량 목표건
    				memberMap.put("workload_cnt", dWorkload_cnt);						//기준업무량 실적건
    				memberMap.put("workload_per", dWorkload_per);						//기준업무량 달성율
    				memberMap.put("bonus_pay", nBasicAmtSum);							//실적
    				
    				//CommonUtils.printMap(memberMap);
    			}    			
    			
    			//해당일자에 등록된 데이터가 있는지 확인한다.
    			nDupChk = sqlSession.selectOne("ItMgmtMapper.countSchBonusMemberListQuarterByManagerNo", memberMap);
    					
    			//미등록된 직원 실적을 등록한다.
    			if( nDupChk == 0 ) {
    				sqlSession.insert("ItMgmtMapper.insertSchBonusMemberListQuarterByManagerNo", memberMap);
    				nInsertCnt++;
    			}    			
    		}        	
        }
    	
    	logger.info("BonusMemberQuarterDaily End : "+sBaseDate+" Manager Sync :"+nManagerUpdateCnt+" Member Update : "+nInsertCnt);
		
	}
}
