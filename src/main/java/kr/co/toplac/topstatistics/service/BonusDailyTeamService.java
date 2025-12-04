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

@Service
public class BonusDailyTeamService {
	
	private static final Logger logger = LoggerFactory.getLogger(WorkloadService.class);

    @Autowired
    SqlSession sqlSession;
	
	public void syncProcess() {
		//오늘날짜 셋팅
    	String sToday = DateUtil.getTodayString("yyyy-MM-dd");		//오늘 날짜(시스템에서 실행되는 날짜)
    	String sBaseDate = DateUtil.addDateNew(sToday, -1);			//어제 날짜(보고서 정산날짜)
    	String sBaseYear = DateUtil.getBaseYear(sBaseDate);			//기준년도
    	String sStartYearDate = DateUtil.getStartYearDay(sBaseDate);		//오늘 기준  시작 일자(년도 시작일자)
    	
    	logger.info("BonusDailyTeamService Start : "+sBaseDate +" : "+sStartYearDate);
    	
    	//해당일자에 등록된 성과급 정보가 있는지 확인한다. (중복등록방지)
    	int nSchTeamChk = 0;
    	nSchTeamChk = sqlSession.selectOne("SuimSchedule.selectSchBonusTeamDailyChk", sBaseDate);
    	
    	int nYearDays = 365;				//윤년계산으로 인해 날짜수 변수처리
    	
    	nYearDays = DateUtil.getYearToDays(sBaseYear);    	
    	
    	if( nSchTeamChk == 0 ) {		//등록된 성과급 정보가 없는 경우에 실행한다.
    		
    		//물보험 재직자 목록을 불러온다.
    		Map<String,Object> setupMap = new HashMap<>();    		
    		Map<String,Object> apMap = new HashMap<>();
    		
    		setupMap.put("base_date", sBaseDate);
    		setupMap.put("start_year_date", sStartYearDate);
    		
    		List<Map<String, Object>> memberList = sqlSession.selectList("SuimSchedule.SchBonusTeamMemberListAll",setupMap);
    		
    		//신입, 경력직 여부에 따라 입사일자(실적 기준 시작일자)를 넣어준다.
    		String sSdate = "";						//실적계산 시작일자
    		String sEdate = "";						//실적계산 종료일자
    		String sUserNo = "";					//임시사번
    		
    		int nApChk = 0;								//기간 내 발령여부체크
    		
    		for(int i=0; i < memberList.size(); i++) {
    			
    			//기준년도 추가
    			memberList.get(i).put("base_year", sBaseYear);
    			
    			sUserNo = String.valueOf(memberList.get(i).get("user_no"));
    			sSdate = String.valueOf(memberList.get(i).get("sdate"));
    			sEdate = String.valueOf(memberList.get(i).get("edate"));    			
    			
    			if( DateUtil.compareDate(sStartYearDate,sSdate) < 1 ) {			//시작일자가 년도 시작일자보다 이전 인 경우
    				memberList.get(i).put("sdate", sStartYearDate);
    				sSdate = String.valueOf(memberList.get(i).get("sdate"));
    			}
    			
    		}
    		
    		//기본 직원 목록 정보를 스케줄러에 넣어준다.
    		sqlSession.insert("SuimSchedule.insertSchBonusTeamMemberBasicList",memberList);    		
    		
    		//직원 발령 처리시작
    		//해당 일자의 스케줄러 목록을 불러온다.
    		List<Map<String, Object>> schMemberList = sqlSession.selectList("SuimSchedule.selectSchTeamMemberListByBaseDate", sBaseDate);
    		
    		String sSkey = "";			//작업후 삭제할 임시 키
    		
    		for( int k=0; k < schMemberList.size(); k++ ) {
    			sSkey = String.valueOf(schMemberList.get(k).get("skey"));
    			sUserNo = String.valueOf(schMemberList.get(k).get("user_no"));
    			sSdate = String.valueOf(schMemberList.get(k).get("sdate"));
    			sEdate = String.valueOf(schMemberList.get(k).get("edate"));    			
    			
    			setupMap.put("user_no", sUserNo);
    			setupMap.put("sdate", sSdate);
    			setupMap.put("edate", sEdate);
    			
    			//기간 내 발령이 있는지 체크한다.    			    			
    			nApChk = sqlSession.selectOne("SuimSchedule.SchBonusTeamApCount", setupMap);
    			
    			String sAppointDate = "";			//임시 발령일자 변수
    			
    			if( nApChk > 0 ) {			//발령이 있는경우 처리시작
    				
    				List<Map<String, Object>> memberApList = sqlSession.selectList("SuimSchedule.SchBonusTeamMemberApList",setupMap);
    				
					for( int r=0; r < memberApList.size(); r++ ) {
						
						//기본연도, 기준일자 설정
						memberApList.get(r).put("base_year", sBaseYear);
						memberApList.get(r).put("base_date", sBaseDate);						
					
    					sAppointDate = String.valueOf(memberApList.get(r).get("appoint_date_fmt"));
    					
    					setupMap.put("appoint_date", sAppointDate);
    					
    					sEdate = sqlSession.selectOne("SuimSchedule.SchBonusTeamMemberApNextEdate", setupMap);
    					
    					if( "".equals(sEdate) ) {										//기간 내 마지막 발령일자
    						memberApList.get(r).put("edate", sBaseDate);
    					}else{
    						memberApList.get(r).put("edate", sEdate);
    					}
    					
    					apMap = memberApList.get(r);    					   					

    				}
					//발령 정보를 스케줄러에 넣어준다.					
		    		sqlSession.insert("SuimSchedule.insertSchBonusTeamMemberBasicList",memberApList);
		    		
		    		//발령 처리 한 기존등록된 대상자 정보를 삭제한다.
	    			sqlSession.delete("SuimSchedule.deleteSchBonusTeamMemberBySkey", sSkey);	    			
    			}    			
    		}
    		//발령 실적 제외 데이터 를 삭제한다. (실적종료일자가 시작일자 이전 인 경우:퇴사자, 실적 당일 발령자)
    		sqlSession.delete("SuimSchedule.deleteSchBonusTeamMemberByReverseDay", sBaseDate);
    		//직원 발령 처리 끝
    		
    		//휴직, 실적 처리 시작
    		//발령 처리 후 해당 일자의 스케줄러 목록을 불러온다.
    		List<Map<String, Object>> workMemberList = sqlSession.selectList("SuimSchedule.selectSchTeamMemberListByBaseDate", sBaseDate);
    		
    		Map<String, Object> workMap = new HashMap<>();    		
    		    
    		double dWorkday = 0;					//근무일
    		double dWorkdayInterval = 0;		//기준일
    		int nWorkdayPer = 0;			//근무율 퍼센트
    		String sDate = "";				//실적 시작일
    		String eDate = "";				//실적 종료일
    		int nWorkChk = 0;				//기준일 기간 내 휴직 수
    		
    		String workSdate = "";		//휴직 시작일
        	String workEdate = "";		//휴직 종료일
        	String calSdate = "";		//계산할 날짜 시작일
        	String calEdate = "";		//계산할 날짜 종료일
        	double dCalSum = 0;				//기간에 휴직일 합계값
        	
        	String sWorkJob = "";		//목표 기준업무량을 가져오기위한 work_job
        	String sJobCodeFull = "workload_job_code_"+sBaseYear;
        	int nTargetCnt = 0;		//연간 목표건수  
        	double dWorkload_target = 0;			//환산목표건수
        	double dWorkload_cnt = 0;				//개인 실적건수 (기간별)
        	double dWorkload_per = 0;				//개인 기준업무량 달성율
        	String sCalWorkloadSum = "";			//개인 기준업무량 합산값
        	double workload_cnt_temp = 0;			//개인 기준업무량 음수체크값
        	
        	int nBasicAmtSum = 0;		//실적합계 ( 기본료 합계 = 일반보고서 본인담당건 - 공동수행 지급 + 공동 수행 수령 + 농작물 실적)
        	
    		for(int i=0; i < workMemberList.size(); i++) {
    			
    			sSkey = String.valueOf(workMemberList.get(i).get("skey"));
    			sUserNo = String.valueOf(workMemberList.get(i).get("user_no"));
    			sDate = String.valueOf(workMemberList.get(i).get("sdate"));
    			eDate = String.valueOf(workMemberList.get(i).get("edate"));
    			
    			dWorkdayInterval = DateUtil.getDiffDayCountNew(sDate, eDate)+1;				//기준일 (같은날이 0일이므로 1을 더한다)    			
    			
    			workMap.put("skey", sSkey);
    			workMap.put("user_no", sUserNo);
    			workMap.put("sDate", sDate);
    			workMap.put("eDate", eDate);
    			workMap.put("base_year", sBaseYear);
    			
    			//휴직일자를 가져온다.
    			List<Map<String, Object>> workList = sqlSession.selectList("SuimSchedule.SchBonusWorkList", workMap);
    			
    			nWorkChk = workList.size();
    			
    			if( nWorkChk == 0 ) {					//휴직이 없는 경우(기준일과 근무일이 동일하고 근무율을 100%)
    				dWorkday = dWorkdayInterval;
    				nWorkdayPer = 100;
    			}else{										//기간중 휴직이 있는 경우
    				
    				int nChk = 0;
    				dCalSum = 0;		//휴직일 합계값 초기화
    				
    				for( int k=0; k < workList.size(); k++) {
    					workSdate = String.valueOf(workList.get(k).get("work_sdate"));
    					workEdate = String.valueOf(workList.get(k).get("work_edate"));
    					
    					//휴직 시작일계산
    					nChk = DateUtil.compareDate(sDate, workSdate);
    					
    					if( nChk > 0 ) {					//휴직일자가 실적시작일 이후 인 경우
    						calSdate = workSdate;
    					}else{
    						calSdate = sDate;
    					}
    					
    					//휴직 종료일 계산
    					nChk = DateUtil.compareDate(eDate, workEdate);
    					
    					if( nChk > 0 ) {		//휴직종료날짜가 실적종료일 이후인경우
    						calEdate = eDate;    						
    					}else{
    						calEdate = workEdate;
    					}
    					
    					dCalSum += DateUtil.getDiffDayCountNew(calSdate, calEdate)+1;    					
    				}
    				
    				dWorkday = dWorkdayInterval - dCalSum;			//근무일 (기준근무일 - 휴직일 합계)
    				
    				if( dWorkday < 1) {									//근무일이 없는경우
    					dWorkday = 0;
    					nWorkdayPer = 0;
    				}else{
    					nWorkdayPer = (int) Math.round( dWorkday / dWorkdayInterval * 100 );
    				}
    			}
    			
    			workMap.put("workday_cnt", (int)dWorkday);
    			workMap.put("workday_interval", (int)dWorkdayInterval);
    			workMap.put("workday_per", nWorkdayPer);
    			
    			//System.out.println(i + " : "+sSkey+" : "+sUserNo+" : "+dWorkday + " : "+dWorkdayInterval+" : "+nWorkdayPer);
    			//휴직 처리끝
    			
    			//기준업무량 목표건 시작
    			sWorkJob = String.valueOf(workMemberList.get(i).get("work_job"));
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
    			sCalWorkloadSum = sqlSession.selectOne("SuimSchedule.schWorkloadEaAll", workMap);
    			
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
    			
    			workMap.put("workload_target", dWorkload_target);				//기준업무량 목표건
    			workMap.put("workload_cnt", dWorkload_cnt);						//기준업무량 실적건
    			workMap.put("workload_per", dWorkload_per);						//기준업무량 달성율
    			
    			//특정 기간 기본급 계산 시작
    			nBasicAmtSum = sqlSession.selectOne("SuimSchedule.schBonusPayAll", workMap);
    			
    			workMap.put("bonus_pay", nBasicAmtSum);    			
    			//특정 기간 기본급 계산 끝
    			
    			sqlSession.update("SuimSchedule.updateSchBonusWorkList", workMap);
    			
    		}    		
    		//휴직, 실적 처리 끝
    		
    		//디버깅
    		/*
    		Map<String,Object> logMap = new HashMap<>();
    		for( int j=0; j < memberList.size(); j++) {
    			logMap = memberList.get(j);
    			CommonUtils.printMap(logMap);
    		}
    		*/
    		
    	}else{
    		logger.info("BonusTeamDaily Duplicated Error : "+sBaseDate);
    	}
    	
    	logger.info("BonusTeamDaily End : "+sBaseDate);
    	
	}

}
