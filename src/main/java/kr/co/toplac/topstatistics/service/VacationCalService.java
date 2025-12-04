package kr.co.toplac.topstatistics.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.toplac.topvaction.VacationInfoBean;
import kr.co.toplac.topvaction.VacationUseBean;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.mail.Sendmail;

@Service
public class VacationCalService {
	
	private static final Logger logger = LoggerFactory.getLogger(WorkloadService.class);

    @Autowired
    SqlSession sqlSession;
    
    /**
     * 일별 연차계산 스케줄러 4종
     */
    
    public void updateVacationAnnual4(){
    	logger.info("============updateVacationAnnual 4=========");
    	
    	VacationUseBean vacationUseBean;
    	
    	String sToday = DateUtil.getTodayString("yyyy-MM-dd");		//오늘 날짜
    	
    	//String sToday = "2022-04-03";		//오늘 날짜
    	
    	//String sExemptDay = "2019-11-11";					//연차사용 면제날짜

    	String nowYear = sToday.substring(0, 4);							//년
		String nowMonth = sToday.substring(5, 7);							//월
		String nowDay = sToday.substring(8, 10);							//일		
		
		Map<String, Object> paramMap = new HashMap<String, Object>();		
		
		//근무중인 4종 사용자 목록을 가져온다.		
		List<VacationInfoBean> userInfoList = sqlSession.selectList("topVacationMapper.testVacatioinMemberList4",paramMap);		
		
		String sJoin_date = "";			//입사일자
		int nUser_no = 0;				//사번
		String sUser_name = "";		//이름
		double annual_set = 0;		//연월차 할당수
		double annual_use = 0;		//연차 사용수
		double total_vacation_use = 0;		//총 휴가 사용일
		int nBaseYear = 0;			//기준연도
		int nTemp = 0;				//임시카운트
		
		double before_annual_set = 0;		//기존연차수
		
		String annual_start_date = "";
		String annual_end_date = "";
		
		String sJoin_nowYear = "";		//체크년으로 변경된 입사일자
		String sJoin_baseYear = "";		//기준년도 기준 입사일자
		double over_year_set = 0;		//이월연차
		
		for(int i=0; i < userInfoList.size(); i++) {
			
			//변수초기화
			annual_use = 0;
			
			nUser_no = userInfoList.get(i).getUser_no();
			sJoin_date = userInfoList.get(i).getJoin_date();
			sUser_name = userInfoList.get(i).getUser_name();
			
			//오늘 기준으로 입사날짜가 1년 미만인지 체크
			if( DateUtil.chkYear(sJoin_date, sToday) ) {		//1년 이상				
				
				//오늘 날짜 기준으로 입사날짜가 이전과 이후로 처리한다.
				sJoin_nowYear = nowYear+sJoin_date.substring(4,10);
				
				int nChk = DateUtil.compareDate(sJoin_nowYear, sToday);
				
				if( nChk < 0 ) {				//입사일기준날짜가 체크날짜를 지나지 않은 경우 
					nBaseYear = Integer.parseInt(nowYear) - 1;
				}else {
					nBaseYear = Integer.parseInt(nowYear);
				}
				
				//System.out.println("연차처리 대상자 : "+sUser_name+ " : "+ sJoin_date +" : "+nBaseYear);				
				//System.out.println("sJoin_monthdate="+sJoin_nowYear+" : "+sToday+" : "+nChk + " : "+nBaseYear);
				
				//기존에 연차등록 값이 있는 지 확인한다.
				paramMap.put("user_no", nUser_no);
				paramMap.put("base_year", nBaseYear);
				
				try {
					nTemp = sqlSession.selectOne("topVacationMapper.vacationBaseYearUseCnt", paramMap);
				} catch (Exception e) {
					nTemp = 0;
				}
				
				if( nTemp == 0 ) {				//연차를 신규로 등록해준다.
					
					annual_set = DateUtil.nCalYearVacation(sJoin_date, sToday);					
					
					//이월연차를 가져온다.
					over_year_set = calLastOverset(nUser_no, nBaseYear, sJoin_date, sToday);
					
					//이월연차가 음수(차감)이면 연차 셋팅값에서 차감하지 않는다 추가되는경우만 셋팅하고 차감은 사용값으로 처리한다. by top3009					
					if( over_year_set > 0 ) {
						annual_set = annual_set + over_year_set;
					}else if( over_year_set < 0 ){		//이월연차가 음수이면 이번년도 사용연차 수를 늘려준다.
						annual_use = over_year_set * -1;
					}
					
					//System.out.println("월차 > 연차 신규등록: "+sJoin_date+ " : "+ sUser_name +" : "+annual_set+" : "+over_year_set);
					
					//연차사용내역을 계산한다.
					sJoin_baseYear = String.valueOf(nBaseYear)+sJoin_date.substring(4, 10);
					
					//연차 사용 시작일과 종료일 계산
					annual_start_date = sJoin_baseYear;
					annual_end_date = DateUtil.addDateNew(sJoin_baseYear, 365);					
					
					//전체휴가 사용내역 계산 (연차+공무휴가)
					//extra_vacation_use = sqlSession.selectOne("topVacationMapper.selectVacationTotalUseExtraCount", paramMap);					
					//total_vacation_use = extra_vacation_use + annual_use;
					total_vacation_use = annual_use;
					
					//insert 할 값 설정					
					paramMap.put("annual_set", annual_set);
					paramMap.put("annual_use", annual_use);
					paramMap.put("annual_start_date", annual_start_date);
					paramMap.put("annual_end_date", annual_end_date);
					paramMap.put("vacation_use", total_vacation_use);
					paramMap.put("base_date", nBaseYear+"-01-01");
					paramMap.put("base_year", nBaseYear);
					
					sqlSession.insert("topVacationMapper.InsertScheduleVacationUse", paramMap);
					
					//로그 : 등록정보 추가
					paramMap.put("user_name", sUser_name);
					paramMap.put("db_action", "insert");
					paramMap.put("annual_set_type", "basic4");
					sqlSession.insert("topVacationMapper.InsertVacationLog", paramMap);
					
				}else{								//기존등록 연차가 있는 경우
					//System.out.println("기존연차 등록되어 있음 : "+sUser_name);
				}				
				
			}else{					//1년 미만 월차계산				
				nBaseYear = Integer.parseInt(sJoin_date.substring(0, 4));
				
				//기존에 연차등록 값이 있는 지 확인한다.
				paramMap.put("user_no", nUser_no);
				paramMap.put("base_year", nBaseYear);		
				
				try {
					nTemp = sqlSession.selectOne("topVacationMapper.vacationBaseYearUseCnt", paramMap);
				} catch (Exception e) {
					nTemp = 0;
				}				
				
				if( nTemp == 0 ) {		//신입사원의 기본 연차정보를 등록한다.
					
					//System.out.println("월차계산 등록대상자 : "+sUser_name+" : "+sJoin_date+" : "+ sToday);
					
					//연차 사용 시작일과 종료일 계산
					annual_start_date = sJoin_date;
					annual_end_date = DateUtil.addDateNew(sJoin_date, 365);
					
					//insert 할 값 설정					
					paramMap.put("annual_set", 0);
					paramMap.put("annual_use", 0);

					//4종은 휴가사용을 0으로 해준다. >> 오류 공휴일은 빼주어야함.					
					paramMap.put("annual_start_date", annual_start_date);
					paramMap.put("annual_end_date", annual_end_date);
					//4종은 휴가사용을 0으로 해준다.
					//paramMap.put("vacation_use", total_vacation_use);
					
					paramMap.put("vacation_use", 0);
					paramMap.put("base_date", nBaseYear+"-01-01");
					paramMap.put("base_year", nBaseYear);
					
					//System.out.println("월차계산 추가 : "+sJoin_date+" : "+ sToday+ " : "+sUser_name);					
					//System.out.println("annual_set="+annual_set);
					//System.out.println("annual_use="+annual_use);
					//System.out.println("exempt_use="+exempt_use);
					//System.out.println("annual_start_date="+annual_start_date);
					//System.out.println("annual_end_date="+annual_end_date);
					//System.out.println("vacation_use="+total_vacation_use);					 					
					
					sqlSession.insert("topVacationMapper.InsertScheduleVacationUse", paramMap);
					
					//사용안함.
					//sqlSession.update("topVacationMapper.vacationUpdateAnnualAll", paramMap);
					
					//로그 : 등록정보 추가
					paramMap.put("user_name", sUser_name);
					paramMap.put("db_action", "insert");
					paramMap.put("annual_set_type", "month4");
					sqlSession.insert("topVacationMapper.InsertVacationLog", paramMap);
					
				}else{					
					//System.out.println("월차계산 갱신대상자 : "+sUser_name+" : "+sJoin_date+" : "+ sToday);
					//해당일자 기준 월차를 계산한다.
					annual_set = DateUtil.nCalMonthVacation(sJoin_date, sToday);		//현재시점의 월차
										
					//기존 연차할당수를 가져온다.
					before_annual_set = sqlSession.selectOne("topVacationMapper.vacationBeforeAnnualSet", paramMap);
										
					//System.out.println("Today annual_set = "+annual_set);
					//System.out.println("Today before_annual_set = "+before_annual_set);
					
					if( annual_set != before_annual_set ) {						//연차할당량에 변경이 있는 경우만 업데이트 한다.												
						paramMap.put("annual_set", annual_set);						
						sqlSession.update("topVacationMapper.vacationUpdateAnnualSet", paramMap);
						
						//갱신로그 추가
						paramMap.put("user_name", sUser_name);
						paramMap.put("db_action", "update");
						paramMap.put("annual_set_type", "month4");
						sqlSession.insert("topVacationMapper.InsertVacationLog", paramMap);
					}
				}				
			}			
		}
		    	
    }
    
    public void sendEmailToVacation() {
    	logger.info("============ sendEmailToVacation =========");
    	
    	String sToday = DateUtil.getTodayString("yyyy-MM-dd");		//오늘 날짜
    	
    	List<Map<String, Object>> vacationLogList = sqlSession.selectList("topVacationMapper.SelectVacationLogByRegDate",sToday);    	
    	
    	Sendmail sendmail = new Sendmail();
    	
    	String sFromName = "휴가알리미";    	
    	String sFromAddress = "webcontract@toplac.co.kr";
    	String sToAddress = "top3009@toplac.co.kr";
    	String sSubject = "["+sToday+"] 연차발생알림";
    	String sContent = "";
    	String sDbAction = "";
    	String sAnnualType = "";
    	String sAnnualTypeVal = "";
    	
    	sContent += "<table style='border-collapse:collapse;width:800px;font-size:12px;font-weight:bold;letter-spacing:1px;' border='1'>";
    	sContent += "<tr>";
		sContent += "<th height='30' style='text-align: center;' bgcolor='#EFF5FB'>로그번호</th>"
				+ "<th height='30' style='text-align: center;' bgcolor='#EFF5FB'>사번</th>"
				+ "<th height='30' style='text-align: center;' bgcolor='#EFF5FB'>이름</th>"
				+ "<th height='30' style='text-align: center;' bgcolor='#EFF5FB'>상태</th>"
				+ "<th height='30' style='text-align: center;' bgcolor='#EFF5FB'>발생연(월)차</th>"
				+ "<th height='30' style='text-align: center;' bgcolor='#EFF5FB'>생성방법</th>"
				+ "<th height='30' style='text-align: center;' bgcolor='#EFF5FB'>기준년도</th>";
		sContent += "</tr>";		
    	
    	for( int i=0; i < vacationLogList.size(); i++ ) {
    		
    		sDbAction = String.valueOf(vacationLogList.get(i).get("db_action"));
    		
    		if( "insert".equals(sDbAction) ) {
    			sDbAction = "연차";
    		}else if( "update".equals(sDbAction) ) {
    			sDbAction = "월차";
    		}else{
    			sDbAction = "-";
    		}
    		
    		sAnnualType = String.valueOf(vacationLogList.get(i).get("annual_set_type"));
    		
    		if( "month".equals(sAnnualType) ) {
    			sAnnualTypeVal = "기타휴직으로 월차생성";
    		}else if( "ratio".equals(sAnnualType) ) {
    			sAnnualTypeVal = "휴직으로 비율연차생성";
    		}else if( "default_month".equals(sAnnualType) ) {
    			sAnnualTypeVal = "1년 미만자 월차생성";
    		}else if( "basic4".equals(sAnnualType) ) {
    			sAnnualTypeVal = "4종 연차생성";
    		}else if( "month4".equals(sAnnualType) ) {
    			sAnnualTypeVal = "4종 월차생성";
    		}else{
    			sAnnualTypeVal = "기존 연차 생성";
    		}
    		
    		sContent += "<tr>";
    		sContent += "<td height='30' style='text-align: center;'>"+String.valueOf(vacationLogList.get(i).get("serial_no"))+"</td>";
    		sContent += "<td height='30' style='text-align: center;'>"+String.valueOf(vacationLogList.get(i).get("user_no"))+"</td>";
    		sContent += "<td height='30' style='text-align: center;'>"+String.valueOf(vacationLogList.get(i).get("user_name"))+"</td>";
    		sContent += "<td height='30' style='text-align: center;'>"+sDbAction+"</td>";
    		sContent += "<td height='30' style='text-align: center;'>"+String.valueOf(vacationLogList.get(i).get("annual_set"))+"</td>";
    		sContent += "<td height='30' style='text-align: center;'>"+sAnnualTypeVal+"</td>";
    		sContent += "<td height='30' style='text-align: center;'>"+String.valueOf(vacationLogList.get(i).get("base_year"))+"</td>";
    		sContent += "</tr>";
    	}
    	
    	sContent += "</table>";
    	
		try {
			//알림메일 발송
			sendmail.sendContract( sFromName, sFromAddress, sToAddress, sSubject, sContent, "", "" );								
			logger.info("Vacation Sendmail Submit : "+sToAddress);
		} catch (Exception e) {
			System.out.println("Vacation Sendmail Error : "+e.getMessage());
		}
    }
    
    /**
     * 일별 연차계산 스케줄러 1종
     */
    
    public void updateVacationAnnual(){
    	logger.info("============updateVacationAnnual 1=========");
    	
    	String sToday = DateUtil.getTodayString("yyyy-MM-dd");		//오늘 날짜
    	
    	//String sToday = "2022-04-03";		//오늘 날짜

    	String nowYear = sToday.substring(0, 4);							//년
		String nowMonth = sToday.substring(5, 7);							//월
		String nowDay = sToday.substring(8, 10);							//일
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		//근무중인 본사 1종 사용자 목록을 가져온다.		
		List<VacationInfoBean> userInfoList = sqlSession.selectList("topVacationMapper.testVacatioinMemberList1",paramMap);
		
		String sJoin_date = "";			//입사일자
		int nUser_no = 0;				//사번
		String sUser_name = "";		//이름
		double annual_set = 0;		//연월차 할당수
		double annual_use = 0;		//연차 사용수
		//double exempt_use = 0;			//면제계산연차사용 수		
		
		//double extra_vacation_use = 0;		//연차, 공휴일 휴가를 제외한 휴가사용일수
		double total_vacation_use = 0;		//총 휴가 사용일
		int nBaseYear = 0;			//기준연도
		int nTemp = 0;				//임시카운트
		
		double before_annual_set = 0;		//기존연차수
		
		String annual_start_date = "";
		String annual_end_date = "";
		
		String sJoin_nowYear = "";		//체크년으로 변경된 입사일자
		String sJoin_baseYear = "";		//기준년도 기준 입사일자
		double over_year_set = 0;		//이월연차
		
		String vacation_work_sdate = "";		//근무율(휴직일) 계산을 위한 시작일자
		String vacation_work_edate = "";		//근무율(휴직일) 계산을 위한 종료일자
		
		String annual_set_type = "basic";				//연차생성 타입 (basic : 기본, ratio : 비율로 생성, month: 월차방식)
		
		int nChk = 0;
		
		for(int i=0; i < userInfoList.size(); i++) {
			
			//변수초기화
			annual_use = 0;
			annual_set_type = "basic";
			
			nUser_no = userInfoList.get(i).getUser_no();
			sJoin_date = userInfoList.get(i).getJoin_date();
			sUser_name = userInfoList.get(i).getUser_name();
			
			//오늘 기준으로 입사날짜가 1년 미만인지 체크
			if( DateUtil.chkYear(sJoin_date, sToday) ) {		//1년 이상
				//System.out.println("연차 : "+sJoin_date+ " : "+ sUser_name );
				
				//오늘 날짜 기준으로 입사날짜가 이전과 이후로 처리한다.
				sJoin_nowYear = nowYear+sJoin_date.substring(4,10);
				
				nChk = DateUtil.compareDate(sJoin_nowYear, sToday);
				
				if( nChk < 0 ) {				//입사일기준날짜가 체크날짜를 지나지 않은 경우 
					nBaseYear = Integer.parseInt(nowYear) - 1;					
				}else {
					nBaseYear = Integer.parseInt(nowYear);
				}
				
				//휴직체크용 연차시작일자
				vacation_work_sdate = String.valueOf(nBaseYear-1)+sJoin_date.substring(4,10);
				vacation_work_edate = String.valueOf(nBaseYear)+sJoin_date.substring(4,10);
				vacation_work_edate = DateUtil.addDateNew(vacation_work_edate, -1);
				
				//System.out.println("user_join_date : "+sJoin_date);
				//System.out.println("vacation_work_date : "+vacation_work_sdate+" ~ "+vacation_work_edate);
				
				//기존에 연차등록 값이 있는 지 확인한다.
				paramMap.put("user_no", nUser_no);
				paramMap.put("base_year", nBaseYear);
				
				//휴직처리를 위한 변수 추가
				paramMap.put("user_join_date", sJoin_date);								//입사일
				paramMap.put("vacation_work_sdate", vacation_work_sdate);		//휴직조회 연차시작일
				paramMap.put("vacation_work_edate", vacation_work_edate);		//휴직조회 연차종료일				
				
				//CommonUtils.printMap(paramMap);
				
				try {
					nTemp = sqlSession.selectOne("topVacationMapper.vacationBaseYearUseCnt", paramMap);
				} catch (Exception e) {
					nTemp = 0;
				}
				
				//휴직일자 계산 시작
				
				//연차생성 기준연도의 근무율을 계산하기 위한 시작일자 종료일자 설정
				String work_sdate_fmt = "";			//기타휴직 시작일자
				String work_edate_fmt = "";			//기타휴직 종료일자
				String cal_sdate = "";					//계산할 휴직시작일자
				String cal_edate = "";					//계산할 휴직종료일자
				double nLeaveDay = 0;				//휴직기간	
				double nTotalDay = 0;					//기준근무일 (1년)
				double nWorkDay = 0;					//근무일 (기준근무일 - 휴직기간)
				double workPer = 0;						//근무율 (근무일 / 기준근무일 * 100)				
				
				//기타휴직으로 인한 연차계산 시작 (leave_type = 9001)
				List<Map<String, Object>> leaveList = sqlSession.selectList("topVacationMapper.selectLeaveDayFor9001",paramMap);					
									
				if( leaveList.size() > 0 ) {		//연차기간내 기타 휴직이 있는경우만 처리한다.					
					
					//직원의 연간 근무일수를 가져온다. 
					nTotalDay = DateUtil.getBetweenWorkDateToCount(vacation_work_sdate, vacation_work_edate, sqlSession);
					
					for( int k=0; k < leaveList.size(); k++ ) {
						work_sdate_fmt = String.valueOf(leaveList.get(k).get("work_sdate_fmt"));
						work_edate_fmt = String.valueOf(leaveList.get(k).get("work_edate_fmt"));
						if(DateUtil.compareDate(vacation_work_sdate , work_sdate_fmt) < 0) {			//휴직일이 연차기간 시작일 이전이면 연차시작일을 계산시작일로 한다.
							cal_sdate = vacation_work_sdate;
						}else{
							cal_sdate = work_sdate_fmt;
						}
						
						if( DateUtil.compareDate(vacation_work_edate, work_edate_fmt) < 0 ) {
							cal_edate =  work_edate_fmt;
						}else{
							cal_edate = vacation_work_edate;
						}
						
						nLeaveDay += DateUtil.getBetweenWorkDateToCount(cal_sdate, cal_edate, sqlSession);							
					}
					
					nWorkDay = nTotalDay - nLeaveDay;
					
					workPer = (nWorkDay / nTotalDay) * 100;
					workPer = Math.round(workPer);
					
					if( workPer < 80 ) {			//근무율이 80%미만이으로 월차로 처리한다.
						annual_set_type = "month";
					}else{							//근무율이 80%이상으로 일반연차생성단계로 넘어간다.
						annual_set_type = "basic";
					}
					
				}
				//기타휴직으로 인한 연차계산 끝 (leave_type = 9001)
				
				//가족돌봄, 상해/질병휴직으로 인한 연차계산 시작 (leave_type = 2001,4001)
				
				//가족돌봄, 상해/질병휴직 설정내역 (leave_type = 2001,4001)
				List<Map<String, Object>> familyLeaveList = sqlSession.selectList("topVacationMapper.selectLeaveDayFor2001",paramMap);
				
				if( familyLeaveList.size() > 0 ) {		//연차기간내 기타 휴직이 있는경우만 처리한다.
					
					//직원의 연간 근무일수를 가져온다. 
					nTotalDay = DateUtil.getBetweenWorkDateToCount(vacation_work_sdate, vacation_work_edate, sqlSession);
					
					for( int f=0; f < familyLeaveList.size(); f++ ) {						
						work_sdate_fmt = String.valueOf(familyLeaveList.get(f).get("work_sdate_fmt"));
						work_edate_fmt = String.valueOf(familyLeaveList.get(f).get("work_edate_fmt"));
						if(DateUtil.compareDate(vacation_work_sdate , work_sdate_fmt) < 0) {			//휴직일이 연차기간 시작일 이전이면 연차시작일을 계산시작일로 한다.
							cal_sdate = vacation_work_sdate;
						}else{
							cal_sdate = work_sdate_fmt;
						}
						
						if( DateUtil.compareDate(vacation_work_edate, work_edate_fmt) < 0 ) {
							cal_edate =  work_edate_fmt;
						}else{
							cal_edate = vacation_work_edate;
						}
						nLeaveDay += DateUtil.getBetweenWorkDateToCount(cal_sdate, cal_edate, sqlSession);						
					}
					
					nWorkDay = nTotalDay - nLeaveDay;
					
					workPer = (nWorkDay / nTotalDay) * 100;
					workPer = Math.round(workPer);
					
					if( workPer < 80 ) {			//근무율이 80%미만이으로 근무율로 연차를 생성한다.
						annual_set_type = "ratio";
					}else{							//근무율이 80%이상으로 일반연차생성단계로 넘어간다.
						annual_set_type = "basic";
					}
				}				
				//가족돌봄, 상해/질병휴직으로 인한 연차계산 끝
									
				//휴직일자 계산 끝
				
				if( nTemp == 0 ) {				//연차를 신규로 등록해준다.
					
					//System.out.println("신규연차 추가 : "+sUser_name+" : "+annual_set_type);
					
					if( "month".equals(annual_set_type) ) {					//월차생성방식 (지난연도 기타휴직으로인한 근무율 80%미만)						
						annual_set = DateUtil.nCalMonthVacation(vacation_work_edate, sToday);		//연차 계산 종료일로부터 오늘날짜의 월차 생성						
					}else if( "ratio".equals(annual_set_type) ) {			//근무율곱한 생성방식 (지난연도 상해질병, 가족돌봄 휴직으로인한 근무율 80%미만)
						annual_set = DateUtil.nCalYearVacation(sJoin_date, sToday);
						annual_set = Math.round((annual_set * workPer) / 100);
					}else{																//기본 연차 계산방식 (지난연도의 근무율이 80%이상인 경우 일반적인 연차생성)
						annual_set = DateUtil.nCalYearVacation(sJoin_date, sToday);
					}					
					
					//이월연차를 가져온다.
					over_year_set = calLastOverset(nUser_no, nBaseYear, sJoin_date, sToday);					
					
					//이월연차가 음수가 아닌경우만 연차할당에 더한다. by top3009 20200122
					if( over_year_set > 0 ) {
						annual_set = annual_set + over_year_set;
					}else if( over_year_set < 0 ){		//이월연차가 음수이면 이번년도 사용연차 수를 늘려준다.
						annual_use = over_year_set * -1;
					}
					
					//연차사용내역을 계산한다.
					sJoin_baseYear = String.valueOf(nBaseYear)+sJoin_date.substring(4, 10);
					
					//연차 사용 시작일과 종료일 계산
					annual_start_date = sJoin_baseYear;
					annual_end_date = DateUtil.addDateNew(sJoin_baseYear, 365);					
					
					//전체휴가 사용내역 계산 (연차+공무휴가)
					total_vacation_use = annual_use;
					
					//insert 할 값 설정					
					paramMap.put("annual_set", annual_set);
					paramMap.put("annual_use", annual_use);
					paramMap.put("annual_start_date", annual_start_date);
					paramMap.put("annual_end_date", annual_end_date);
					paramMap.put("vacation_use", total_vacation_use);
					paramMap.put("base_date", nBaseYear+"-01-01");
					paramMap.put("base_year", nBaseYear);
					
					sqlSession.insert("topVacationMapper.InsertScheduleVacationUse", paramMap);
					
					//로그 : 등록정보 추가
					paramMap.put("user_name", sUser_name);
					paramMap.put("db_action", "insert");
					paramMap.put("annual_set_type", annual_set_type);
					sqlSession.insert("topVacationMapper.InsertVacationLog", paramMap);
					
				}else if( nTemp == 1 && "month".equals(annual_set_type) ) {			//해당 연도의 연차는 존재하나 기타 휴직일이 80%이상으로 월차로 계산하는 경우
					
					//System.out.println("기타휴직으로 월차갱신 : "+sUser_name+" : "+annual_set_type);
					
					//오늘 날짜 기준으로 입사날짜가 이전과 이후로 처리한다.
					sJoin_nowYear = nowYear+sJoin_date.substring(4,10);
					
					nChk = DateUtil.compareDate(sJoin_nowYear, sToday);
					
					if( nChk < 0 ) {				//입사일기준날짜가 체크날짜를 지나지 않은 경우 
						nBaseYear = Integer.parseInt(nowYear) - 1;					
					}else {
						nBaseYear = Integer.parseInt(nowYear);
					}
					
					//휴직체크용 연차시작일자
					vacation_work_sdate = String.valueOf(nBaseYear-1)+sJoin_date.substring(4,10);
					vacation_work_edate = String.valueOf(nBaseYear)+sJoin_date.substring(4,10);
					vacation_work_edate = DateUtil.addDateNew(vacation_work_edate, -1);
					
					annual_set = DateUtil.nCalMonthVacation(vacation_work_edate, sToday);		//현재시점의 월차
					
					//이월연차를 가져온다.
					over_year_set = calLastOverset(nUser_no, nBaseYear, sJoin_date, sToday);
					
					//이월연차가 음수가 아닌경우만 연차할당에 더한다. by top3009 20200122
					if( over_year_set > 0 ) {
						annual_set = annual_set + over_year_set;
					}else if( over_year_set < 0 ){		//이월연차가 음수이면 이번년도 사용연차 수를 늘려준다.
						annual_use = over_year_set * -1;
					}					
					
					//기존 연차할당수를 가져온다.
					before_annual_set = sqlSession.selectOne("topVacationMapper.vacationBeforeAnnualSet", paramMap);
					
					if( annual_set != before_annual_set ) {						//연차할당량에 변경이 있는 경우만 업데이트 한다.												
						paramMap.put("annual_set", annual_set);						
						sqlSession.update("topVacationMapper.vacationUpdateAnnualSet", paramMap);
						
						//갱신로그 추가
						paramMap.put("user_name", sUser_name);
						paramMap.put("db_action", "update");	
						paramMap.put("annual_set_type", annual_set_type);
						sqlSession.insert("topVacationMapper.InsertVacationLog", paramMap);
					}
					
				}else if( nTemp == 1 && "ratio".equals(annual_set_type) ){				//근무율로 곱한 생성방식 (지난연도 상해질병, 가족돌봄 휴직으로인한 근무율 80%미만)
					
					//System.out.println("돌봄연차 갱신 : "+sUser_name+" : "+annual_set_type);
					
					annual_set = DateUtil.nCalYearVacation(sJoin_date, sToday);
					annual_set = Math.round((annual_set * workPer) / 100);
					
					//이월연차를 가져온다.
					over_year_set = calLastOverset(nUser_no, nBaseYear, sJoin_date, sToday);					
					
					//이월연차가 음수가 아닌경우만 연차할당에 더한다. by top3009 20200122
					if( over_year_set > 0 ) {
						annual_set = annual_set + over_year_set;
					}else if( over_year_set < 0 ){		//이월연차가 음수이면 이번년도 사용연차 수를 늘려준다.
						annual_use = over_year_set * -1;
					}
					
					//기존 연차할당수를 가져온다.
					before_annual_set = sqlSession.selectOne("topVacationMapper.vacationBeforeAnnualSet", paramMap);
					
					if( annual_set != before_annual_set ) {						//연차할당량에 변경이 있는 경우만 업데이트 한다.												
						paramMap.put("annual_set", annual_set);						
						sqlSession.update("topVacationMapper.vacationUpdateAnnualSet", paramMap);
						
						//갱신로그 추가
						paramMap.put("user_name", sUser_name);
						paramMap.put("db_action", "update");		
						paramMap.put("annual_set_type", annual_set_type);
						sqlSession.insert("topVacationMapper.InsertVacationLog", paramMap);
					}
					
					//System.out.println("기존연차 비율계산 변동사항 체크 : "+sUser_name+" : "+annual_set_type+" : "+annual_set+" : "+before_annual_set);
				
				}else if( nTemp == 1 && "basic".equals(annual_set_type) ){				//기존 연차가 등록되어있으며 기존 방식인경우 (변경사항 체크)
					
					//System.out.println("기존연차 갱신 : "+sUser_name+" : "+annual_set_type);
					
					annual_set = DateUtil.nCalYearVacation(sJoin_date, sToday);
					
					//이월연차를 가져온다.
					over_year_set = calLastOverset(nUser_no, nBaseYear, sJoin_date, sToday);					
					
					//이월연차가 음수가 아닌경우만 연차할당에 더한다. by top3009 20200122
					if( over_year_set > 0 ) {
						annual_set = annual_set + over_year_set;
					}else if( over_year_set < 0 ){		//이월연차가 음수이면 이번년도 사용연차 수를 늘려준다.
						annual_use = over_year_set * -1;
					}
					
					//기존 연차할당수를 가져온다.
					before_annual_set = sqlSession.selectOne("topVacationMapper.vacationBeforeAnnualSet", paramMap);
					
					if( annual_set != before_annual_set ) {						//연차할당량에 변경이 있는 경우만 업데이트 한다.												
						paramMap.put("annual_set", annual_set);						
						sqlSession.update("topVacationMapper.vacationUpdateAnnualSet", paramMap);
						
						//갱신로그 추가
						paramMap.put("user_name", sUser_name);
						paramMap.put("db_action", "update");		
						paramMap.put("annual_set_type", annual_set_type);
						sqlSession.insert("topVacationMapper.InsertVacationLog", paramMap);
					}
					
					//System.out.println("기존연차 등록 변동사항 체크 : "+sUser_name+" : "+annual_set_type+" : "+annual_set+" : "+before_annual_set);
					
				}else {
					//System.out.println("아무작업 안함 패스 : "+sUser_name+" : "+annual_set_type+" : "+nTemp);
				}				
				
			}else{					//1년 미만 월차계산
				
				nBaseYear = Integer.parseInt(sJoin_date.substring(0, 4));
				
				//기존에 연차등록 값이 있는 지 확인한다.				
				paramMap.put("user_no", nUser_no);
				paramMap.put("base_year", nBaseYear);
				
				annual_set_type = "default_month";				//1년 미만자로 월차처리되는 경우
				paramMap.put("annual_set_type", annual_set_type);
				
				try {
					nTemp = sqlSession.selectOne("topVacationMapper.vacationBaseYearUseCnt", paramMap);
				} catch (Exception e) {
					nTemp = 0;
				}
				
				if( nTemp == 0 ) {

					annual_set = DateUtil.nCalMonthVacation(sJoin_date, sToday);		//현재시점의 월차
					
					sJoin_baseYear = String.valueOf(nBaseYear)+sJoin_date.substring(4, 10);
										
					paramMap.put("sdate", sJoin_date);		//연(월차)계산시작일
					paramMap.put("edate", sToday);			//오늘날짜

					annual_use = sqlSession.selectOne("topVacationMapper.selectVacationTotalUseCount", paramMap);
					
					//연차 사용 시작일과 종료일 계산
					annual_start_date = sJoin_date;
					annual_end_date = DateUtil.addDateNew(sJoin_date, 365);
					
					//전체휴가 사용내역 계산 (연차+공무휴가)
					total_vacation_use = annual_use;
					
					//insert 할 값 설정					
					paramMap.put("annual_set", annual_set);
					paramMap.put("annual_use", annual_use);
					paramMap.put("annual_start_date", annual_start_date);
					paramMap.put("annual_end_date", annual_end_date);
					paramMap.put("vacation_use", total_vacation_use);
					paramMap.put("base_date", nBaseYear+"-01-01");
					paramMap.put("base_year", nBaseYear);									
					
					sqlSession.insert("topVacationMapper.InsertScheduleVacationUse", paramMap);
					
					//로그 : 등록정보 추가
					paramMap.put("user_name", sUser_name);
					paramMap.put("db_action", "insert");
					sqlSession.insert("topVacationMapper.InsertVacationLog", paramMap);
					
				}else{			//월차계산 갱신					
					annual_set = DateUtil.nCalMonthVacation(sJoin_date, sToday);		//현재시점의 월차					
					
					//기존 연차할당수를 가져온다.
					before_annual_set = sqlSession.selectOne("topVacationMapper.vacationBeforeAnnualSet", paramMap);
					
					if( annual_set != before_annual_set ) {						//연차할당량에 변경이 있는 경우만 업데이트 한다.												
						paramMap.put("annual_set", annual_set);						
						sqlSession.update("topVacationMapper.vacationUpdateAnnualSet", paramMap);
						
						//갱신로그 추가
						paramMap.put("user_name", sUser_name);
						paramMap.put("db_action", "update");						
						sqlSession.insert("topVacationMapper.InsertVacationLog", paramMap);
					}
				}
				
			}			
		}
		    	
    }
    
    /**
     * 이월연차 계산함수 시스템 오픈후 (작년도 사용량을 계산할 필요가 없음)
     * @param nUserno : 사번, nBaseYear : 기준년도  
     * @return
     */
    public double calLastOverset( int nUserNo, int nBaseYear, String sJoin_date, String sToday) {
    	
    	Map<String, Object> paramMap = new HashMap<String, Object>();
    	    	
    	double dRet = 0;
    	int nLastYear = nBaseYear - 1;    	
    	
    	//1년전 할당 연차와 사용연차를 DB 에서 가져온다.
    	double last_annual_set = 0;
    	double last_annual_use = 0;
    	
    	paramMap.put("user_no", nUserNo);
    	paramMap.put("base_year", nLastYear);
    	
    	VacationUseBean useBean = sqlSession.selectOne("topVacationMapper.vacationBaseYearUseList", paramMap);
    	
    	if( useBean == null ) {			//작년도 연차정보없는 경우
    		dRet = 0;
    	}else{
    		//작년도 연차정보가 있는경우
    		last_annual_set = useBean.getAnnual_set();
    		last_annual_use = useBean.getAnnual_use();
    		dRet = last_annual_set - 	last_annual_use;
    	}    	
    	
    	//System.out.println("이월연차계산 : "+nUserNo+ " : "+nBaseYear+" : "+sJoin_date+" : "+last_annual_set+ " : "+last_annual_use+ " : "+dRet);
    	
    	return dRet;
    }
    
    /**
     * 이월연차 계산함수 오픈전 사용함수
     * @param nUserno : 사번, nBaseYear : 기준년도  
     * @return
     */
    public double calLastOversetBk( int nUserNo, int nBaseYear, String sJoin_date, String sToday) {
    	
    	Map<String, Object> paramMap = new HashMap<String, Object>();
    	
    	double dRet = 0;
    	String sLastday = String.valueOf(nBaseYear - 1 )+sToday.substring(4, 10);
    	String sLastJoindate = String.valueOf(nBaseYear - 1 )+sJoin_date.substring(4, 10);			//1년전 기준 입사일자
    	String sNowJoindate = String.valueOf(nBaseYear)+sJoin_date.substring(4, 10);			//올해 기준 입사일자
    	
    	//기준년의 1년전 할당 연차를 계산한다.
    	int last_annual_set = DateUtil.nCalYearVacation(sJoin_date, sLastday);
    	double last_annual_use = 0;
    	double annual_result = 0;
    	
    	if( last_annual_set == 0 ) {		//작년연차가 없는 경우 0으로 처리한다.
    		dRet = 0;
    	}else {									//작년연차가 있는경우 계산한다.
    		//기준년의 1년전 연차 사용량을 계산한다.    		
    		paramMap.put("user_no", nUserNo);
    		paramMap.put("sdate", sLastJoindate);		//조회시작 기준일
			paramMap.put("edate", sNowJoindate);			//조회종료 기준일
			
			//System.out.println("sLastJoindate="+sLastJoindate);
			//System.out.println("sNowJoindate="+sNowJoindate);
			
			//전체 연차 사용내역 계산
			last_annual_use = sqlSession.selectOne("topVacationMapper.selectVacationTotalUseCount", paramMap);
			
			//System.out.println("이월연차계산 : "+last_annual_set+" - "+ last_annual_use + " = "+annual_result);
    	}
    	
    	annual_result = last_annual_set - last_annual_use;
    	
    	
    	if( nBaseYear < 2020 ) {
    		if( annual_result > 0 ) {
        		dRet = annual_result;
        	}else {					//2019년도까지 음수면 이월연차는 0으로 처리
        		dRet = 0;
        	}
    	}else{
    		dRet = annual_result;
    	}    	
    	
    	//System.out.println("이월연차계산 : "+nUserNo+ " : "+nBaseYear+" : "+sJoin_date+" : "+last_annual_set+ " : "+last_annual_use+ " : "+dRet);
    	
    	return dRet;
    }
    
    /**
     * 일별 연차를 업데이트 해주기 위한 스케줄러  기존 백업용
     */
    public void updateVacationAnnualBk(){    	
    	//근무중인 모든 직원의 목록을 가져온다.
    	logger.info("============updateVacationAnnualBk=========");
    	
    	String sBaseDate = DateUtil.getTodayString("yyyy-MM-dd");		//오늘 날짜
    	String [] sBaseTemp = sBaseDate.split("-");
    	int nBaseYear = Integer.parseInt(sBaseTemp[0]);					//기준년도(오늘)
    	
    	String sJoinDate = ""; 			//입사일자    	
    	
    	int nMonCal = 0;			//월차발생 수
    	int nHoliday = 0; 		//공휴일수
    	double nYearCal = 0;			//년차발생 수
    	double nUseCal = 0;			//실사용휴가수
    	double nTotalCal = 0;			//최종 남은 연차
    	String sUser_no = "";			//사번
    	int nChk = 0;				//기존 정보 체크    	
    	
    	Map<String, Object> paramMap = new HashMap<String, Object>();
    	
    	List<Map<String, Object>> vacationMemberList = sqlSession.selectList("StatisticBasic.selectVacationMemberList");
    	for(int i = 0; i < vacationMemberList.size(); i++) {
    		
    		sJoinDate = vacationMemberList.get(i).get("joinDate").toString();
    		sUser_no = vacationMemberList.get(i).get("userNo").toString();
    		
    		//기준년도 셋팅
    		paramMap.put("base_year", nBaseYear);
    		paramMap.put("user_no", sUser_no);
    		paramMap.put("join_date", sJoinDate);
    		paramMap.put("base_date", sBaseDate);
    		
    		if( DateUtil.chkYear(sJoinDate, sBaseDate) ) {		//1년 이상
    			nYearCal = DateUtil.nCalYearVacation(sJoinDate, sBaseDate);
    			//logger.info("Year MemberList : "+nYearCal+" : "+vacationMemberList.get(i).get("userNo").toString()+" : "+vacationMemberList.get(i).get("joinDate").toString());
    			//현재날짜 기준으로 입사월일이 이전인지 이후인지 체크한다.
    			
    			
    		}else {						//1년 미만 (월차계산)    			
    			nMonCal = DateUtil.nCalMonthVacation(sJoinDate, sBaseDate);    			
    			//공휴일 확인 사용연차로 이관..
    			//nHoliday = DateUtil.chkHoliday(sJoinDate, sBaseDate);
    			
    			nUseCal = sqlSession.selectOne("StatisticBasic.sumVacationUse", paramMap);
    			
    			//logger.info("Month MemberList : "+nMonCal+" : "+ nHoliday +" : "+nUseCal+" : "+vacationMemberList.get(i).get("userNo").toString()+" : "+vacationMemberList.get(i).get("joinDate").toString());
    			
    			nTotalCal = nMonCal - nUseCal;
    			if( nTotalCal > 0 ) {
    				logger.info("sUser_no(+) :"+sUser_no+" : "+nTotalCal);    				
    			}else {
    				//logger.info("sUser_no(-) :"+sUser_no+" : "+nTotalCal);
    			}
    			
    			//연차 테이블에 업데이트
    			//기준년도로 셋팅된 값이 있는지 확인 (기존값이 존재하면 1, 없으면 0)
    			nChk = sqlSession.selectOne("StatisticBasic.chkVacationUse", paramMap);
    			//logger.info("chk : "+nChk);
    			if( nChk == 0 ) {		//기존 년도의 등록값이 없으므로 최초 insert 할때 해당년도 연차 수외 사용일수 신청일수등을 계산해서 넣어주어야함 (초기값셋팅) 
    				logger.info("insert~~");    				
    			}else {					//기존 등록값이 있으므로 update
    				//logger.info("update~~");
    			}
    		}
    		    		
    	}
    	
    }
    
}
