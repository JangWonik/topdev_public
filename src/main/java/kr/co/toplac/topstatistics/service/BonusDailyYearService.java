package kr.co.toplac.topstatistics.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.toplac.util.cmm.DateUtil;

@Service
public class BonusDailyYearService {	

	private static final Logger logger = LoggerFactory.getLogger(WorkloadService.class);

    @Autowired
    SqlSession sqlSession;
    
    public void syncProcess() {
    	
    	//오늘날짜 셋팅
    	String sToday = DateUtil.getTodayString("yyyy-MM-dd");		//오늘 날짜(시스템에서 실행되는 날짜)
    	String sBaseDate = DateUtil.addDateNew(sToday, -1);			//어제 날짜(보고서 정산날짜)
    	
    	logger.info("BonusDailyYearService Start : "+sBaseDate);
    	
    	//날짜 설정 맵
    	Map<String, Object> setupMap = new HashMap<String, Object>();
    	
    	String sDate = DateUtil.getStartYearDay(sBaseDate);					//연도 시작일
    	//String eDate = sBaseDate;					//연도 종료일 (조회일자)
    	String eDate = sToday;					//연도 종료일 (조회일자)
    	String sBaseYear = DateUtil.getBaseYear(sBaseDate);		//기준년도

    	//기준날짜 셋팅
    	setupMap.put("base_date", sBaseDate);
    	setupMap.put("sDate", sDate);
    	setupMap.put("eDate", eDate);
    	setupMap.put("sBaseYear", sBaseYear);    	
    	    	
    	int nSchChk = 0;
    	double dWorkDayAll = 0;		//근무 기준일
    	double dWorkDay = 0;			//직원 근무일
    	
    	/*
    	System.out.println("sToday : "+sToday);
    	System.out.println("sBaseDate : "+sBaseDate);
    	System.out.println("sDate : "+sDate);
    	System.out.println("eDate : "+eDate);
    	System.out.println("sBaseYear : "+sBaseYear);
    	*/    	
    	
    	dWorkDayAll = DateUtil.getDiffDayCountNew(sDate, sBaseDate)+1;			//기간근무일 (같은날을 0일로 시작하므로 1을 더한다)    	
    	
    	//해당일자에 등록된 개인 연간 성과급 정보가 있는지 확인한다. (중복등록방지)
    	nSchChk = sqlSession.selectOne("SuimSchedule.selectSchBonusYearDailyChk", sBaseDate);
    	
    	//휴직 계산을 위한 변수
    	String workSdate = "";		//휴직 시작일
    	String workEdate = "";		//휴직 종료일
    	String calSdate = "";		//계산할 날짜 시작일
    	String calEdate = "";		//계산할 날짜 시작일
    	String sUserNo = "";		//임시 사번정보
    	String sJoinDate = "";		//입사일자
    	double dCalSum = 0;				//기간에 휴직일 합계값
    	int nWorkPer = 0;			//근무율 퍼센트
    	int nBasicAmtSum = 0;		//실적합계 ( 기본료 합계 = 일반보고서 본인담당건 - 공동수행 지급 + 공동 수행 수령 + 농작물 실적)    	
    	
    	int nChk = 0; 
    	int nWnt = 0;					//기준업무량 임시카운터
    	double purpose_workload = 0;			//목표건 임시카운터
    	double cal_workload = 0;					//기준업무량 임시카운터
    	double workload_per = 0;					//기준업무량 달성율 변수
    	String sCalWorkloadSum = "";			//개인 기준업무량 합산값 
    	
    	String sWorkJob = "";		//목표 기준업무량을 가져오기위한 work_job
    	String sJobCodeFull = "workload_job_code_"+sBaseYear;
    	String sTargetVal = "";		//연간 목표건수
    	String sTargetCnt = "";		//연간 목표건수(코드유무확인용)
    	int nTargetCnt = 0;			//연간 목표건 등록 건수    	
    	double temp_workday_cnt = 0;		//직원 근무일 임시변수
    	double workload_cnt_temp = 0;		//기준업무량 음수체크용 임시 변수
    	
    	int nYearDays = 365;				//윤년계산으로 인해 날짜수 변수처리
    	
    	nYearDays = DateUtil.getYearToDays(sBaseYear);
    	
    	if( nSchChk == 0 ) {		//성과급 스케줄러에 등록되지 않은경우만 작업한다.
    		
    		//1종 대상자의 목록을 불러온다.
    		List<Map<String, Object>> memberList = sqlSession.selectList("SuimSchedule.SchBonusMemberListAll");
    		
    		for(int i=0; i < memberList.size(); i++) {
    			sUserNo = String.valueOf(memberList.get(i).get("user_no"));
    			setupMap.put("user_no", sUserNo);
    			    			
    			//기준업무량 목표 추가 시작 (top_workload_target)
    			sWorkJob = String.valueOf(memberList.get(i).get("work_job"));
    			setupMap.put("work_job", sWorkJob);
    			setupMap.put("job_code_full", sJobCodeFull);
    			setupMap.put("base_year", sBaseYear);
    			
    			sTargetCnt = sqlSession.selectOne("SuimSchedule.countSysadmCodedicByJobcode", setupMap);
    			
    			if( "0".equals(sTargetCnt) ) {		//직무에 목표건이 없는 경우
    				sTargetVal = "0";
    			}else{
    				//기준업무량 환산값을 위한 직원 연간 목표량 셋팅    				
    				sTargetVal = sqlSession.selectOne("SuimSchedule.selectSysadmCodedicByJobcode", setupMap);
    				setupMap.put("yearEa", sTargetVal);
    			}    			
    			
    			//기준년도 목표업무량 정보가 있는지 체크해서 없으면 추가한다. ( 사번, 기준연도)
    			nTargetCnt = sqlSession.selectOne("SuimSchedule.countWorkloadTargetInfo", setupMap);
    			
    			//연간 목표 설정값이 없는 경우만 추가해 준다.
    			if( nTargetCnt == 0 ) {
    				setupMap.put("target_val", sTargetVal);
    				sqlSession.insert("ItMgmtMapper.insertMemberTargetVal",setupMap);
    			}
    			//기준업무량 목표 추가 끝    			
    			
    			List<Map<String, Object>> workList = sqlSession.selectList("SuimSchedule.SchBonusWorkList", setupMap);
    			
    			//기간근무일, 기준년도, 분기표시는 모든 직원이 동일하다.
    			memberList.get(i).put("workday_interval", (int)dWorkDayAll);
    			memberList.get(i).put("base_year", sBaseYear);    			 
    			memberList.get(i).put("base_date", sBaseDate);
    			
    			//특정 기간 기본급 계산 시작
    			nBasicAmtSum = sqlSession.selectOne("SuimSchedule.schBonusPayAll", setupMap);
    			
    			memberList.get(i).put("bonus_pay", nBasicAmtSum);
    			//특정 기간 기본급 계산 끝
    			
    			//근무율 계산 시작
    			//입사일자가 기준 근무일 시작일 이후인경우 별도 계산해야함 (수습직원)
    			sJoinDate = String.valueOf(memberList.get(i).get("join_date_fmt"));
    			
    			nChk = DateUtil.compareDate(sDate, sJoinDate);					//입사일자와 연간 시작 기준일 비교
    			    			
    			if( nChk > 0 ) { 																	//입사일자가 연간 시작 기준일 이후인 경우 별도계산(최근 입사자) 
    				dWorkDay = DateUtil.getDiffDayCountNew(sJoinDate, sBaseDate)+1;			//입사일자로 부터 기준일자 (근무일수)
    				nWorkPer = (int) Math.round( dWorkDay / dWorkDayAll * 100 );
    				memberList.get(i).put("workday_per", nWorkPer);
					memberList.get(i).put("workday_cnt", (int)dWorkDay);    				
    			}else	if( nChk < 1 && workList.size() == 0 ) {		//입사일자가 연간시작 기준이 이전이면서 해당기간에 휴직일이 없는경우 (근무율을 100으로 넣어준다)
    				memberList.get(i).put("workday_per", "100");    					
    				memberList.get(i).put("workday_cnt", (int)dWorkDayAll);			//휴직일이 없으므로 기준일과 근무일을 똑같이 넣어준다.
    			}else{									//휴직이 1개이상 존재하는 경우
    				dCalSum = 0;		//휴직일 합계값 초기화
    				dWorkDay = 0;	//근무일수 초기화
    				
    				for( int k=0; k < workList.size(); k++) {
    					workSdate = String.valueOf(workList.get(k).get("work_sdate"));
    					workEdate = String.valueOf(workList.get(k).get("work_edate"));
    					
    					//휴직 시작일계산
    					nChk = DateUtil.compareDate(sDate, workSdate);
    					
    					if( nChk > 0 ) {		//휴직일자가 분기 기준일 이후 인 경우
    						calSdate = workSdate;
    					}else{
    						calSdate = sDate;
    					}
    					
    					//휴직 종료일 계산
    					nChk = DateUtil.compareDate(sBaseDate, workEdate);
    					
    					if( nChk > 0 ) {		//휴직종료날짜가 오늘날짜 이후인경우
    						calEdate = sBaseDate;    						
    					}else{
    						calEdate = workEdate;
    					}
    					
    					dCalSum += DateUtil.getDiffDayCountNew(calSdate, calEdate)+1;
    					
    				}
    				    				
    				dWorkDay = dWorkDayAll - dCalSum;			//근무일 (기준근무일 - 휴직일)   
    				
    				if( dWorkDay < 1) {									//근무일이 없는경우
    					memberList.get(i).put("workday_per", "0");
    					memberList.get(i).put("workday_cnt", "0");
    				}else{					
    					nWorkPer = (int) Math.round( dWorkDay / dWorkDayAll * 100 );
    					memberList.get(i).put("workday_per", nWorkPer);
    					memberList.get(i).put("workday_cnt", (int)dWorkDay);
    				}    				
    			}
    			//근무율 계산 끝
    			
    			//기준업무량 목표, 실적, 달성율 시작
    			//기준업무량 목표 시작    			
    			temp_workday_cnt = Double.parseDouble(String.valueOf(memberList.get(i).get("workday_cnt")));    			
    			
    			nTargetCnt = sqlSession.selectOne("SuimSchedule.countWorkloadTargetInfo", setupMap);
    			
    			if( "0".equals(sTargetCnt) ) {								//직무에 목표 건 정보가 없는 경우 0으로 셋팅
    				memberList.get(i).put("workload_target", "0");
    			}else{
    				sTargetVal = sqlSession.selectOne("SuimSchedule.selectWorkloadTargetInfo", setupMap);
    				
    				//기준업무량 환산값을 위한 직원 연간 목표량 셋팅
    				setupMap.put("yearEa", sTargetVal);
    				
    				purpose_workload = Double.parseDouble(String.valueOf(sTargetVal));
    				purpose_workload = (purpose_workload * temp_workday_cnt) / nYearDays ;		//목표도 일할 계산해서 소숫점 3째자리까시 표시
    				purpose_workload = (Math.round(purpose_workload * 1000) / 1000.000);
    				
    				memberList.get(i).put("workload_target", purpose_workload);
    			}    			
    			//기준업무량 목표 끝
    			
    			//기준업무량 실적 시작
    			//특정 기간 기준업 무량 계산
    			sCalWorkloadSum = sqlSession.selectOne("SuimSchedule.schWorkloadEaAll", setupMap);
    			
    			workload_cnt_temp = Double.parseDouble(sCalWorkloadSum);
    			
    			if( workload_cnt_temp < 0 ) {
    				sCalWorkloadSum = "0";
    			}
    			
    			memberList.get(i).put("workload_cnt", sCalWorkloadSum);
    			
    			cal_workload = Double.parseDouble(sCalWorkloadSum);
    			//기준업무량 실적 끝
    			
    			//달성율 계산시작
    			if( purpose_workload > 0 &&  cal_workload > 0) {			//기준값과 실적값이 존재하는 경우만 계산한다.
    				workload_per = (cal_workload * 100) / purpose_workload;
    			}else{
    				workload_per = 0;
    			}
    			
    			workload_per = (Math.round(workload_per * 10000) / 10000.0000);		//달성율(소숫점4자리)			
    			memberList.get(i).put("workload_per", workload_per);    			    			    			
    			//달성율 계산 끝
    			
    			/*
    			if( "787".equals(sUserNo) ) {
    				System.out.println("사번 : "+sUserNo);
    				System.out.println("1년 목표 : "+sTargetVal);
    				System.out.println("근무일 : "+temp_workday_cnt);
    				System.out.println("workload_target : "+purpose_workload);
    				System.out.println("workload_cnt : "+sCalWorkloadSum);
    				System.out.println("workload_per : "+workload_per);
    				System.out.println("sdate : "+setupMap.get("sDate"));
    				System.out.println("edate : "+setupMap.get("eDate"));    				
    			}
    			*/
    			
    			//기준업무량 목표, 실적, 달성율 끝
    		}
    		
    		//스케줄러 입력 시작 (작업 완료 후 테스트)
    		sqlSession.insert("SuimSchedule.insertSchBonusYearDaily", memberList);
    		//스케줄러 입력 끝
    		
    		//근무율 디버깅
    		/*
    		int nDebug = 0;
    		for( int j=0; j < memberList.size(); j++) {
    			nDebug = Integer.parseInt(String.valueOf(memberList.get(j).get("bonus_pay")));
    			
    			if( nDebug > 0 ) {
    				CommonUtils.printMap(memberList.get(j));
    			}
    		}
    		*/	
    		
    		
    	}else{
    		logger.info("BonusYearDaily Duplicated Error : "+sBaseDate);
    	}
    	
    	logger.info("BonusYearDailyService End : "+sBaseDate);
    }
}