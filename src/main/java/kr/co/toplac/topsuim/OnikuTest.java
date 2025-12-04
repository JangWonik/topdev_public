package kr.co.toplac.topsuim;

import java.io.File;
import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.filefilter.TrueFileFilter;
import org.apache.ibatis.session.SqlSession;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.toplac.topstatistics.service.WorkloadService;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topvaction.VacationInfoBean;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.RequestUtil;

@Controller
public class OnikuTest {

	/**
	 * 테스트용 프로그램 입니다.
	 * @param args
	 */	
	
	private static final Logger logger = LoggerFactory.getLogger(WorkloadService.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	SchedulerFactoryBean schedulerBean;
	
	/**
	 * 특정보험사의 보고서 데이터를 업데이트 한다. (
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="OnikuUpdateHeadAsta")
	public String OnikuUpdateHeadAsta(HttpServletRequest request, Model model, HttpSession session){
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		String sUserNo = mbrVo.getUser_no();
		
		if(!"1786".equals(sUserNo) ){
			logger.info("OnikuUpdateHeadAsta - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		
		logger.info("======== OnikuWorkloadCheck ========");
		
		//work_rank 수동 업데이트 (1년에 한번씩 업데이트)
		/**
		List<Map<String, Object>> workRankMember = sqlSession.selectList("SuimSchedule.selectWorkRankMemberListTempName");
		
		String sTempUserNo = "";
		String sTempUserName = "";
		String sTempWorkRank = "";				//임시직위명
		String sTempWorkRankCode = "";		//직위코드 (sysadm_codedic 내 top_mbr_bsc, work_rank)
		
		Map<String,Object> updateMap = new HashMap<String,Object>();
		
		for(int i=0; i < workRankMember.size(); i++) {
			sTempUserNo = String.valueOf(workRankMember.get(i).get("user_no"));
			sTempUserName = String.valueOf(workRankMember.get(i).get("user_name"));
			sTempWorkRank = String.valueOf(workRankMember.get(i).get("work_rank"));
			sTempWorkRankCode = sqlSession.selectOne("SuimSchedule.selectWorkRankCodeByColVal", sTempWorkRank);
			
			System.out.println(sTempUserName+" : "+sTempUserNo + " : "+sTempWorkRank+" : "+sTempWorkRankCode);
			
			updateMap.put("user_no", sTempUserNo);
			updateMap.put("work_rank", sTempWorkRankCode);
			
			sqlSession.update("SuimSchedule.updateWorkRankByTopMbrBsc", updateMap);
			
		}
		**/
				
		//교육과정 자동등록 (전직원대상)
		//List<Map<String,Object>> eduMember = sqlSession.selectList("SuimSchedule.selectEduMemberListTemp");
		
		/**
		Map<String,Object> paramMap = new HashMap<String,Object>();
		
		//임시테이블(별도직원용:이름으로 검색)
		List<Map<String,Object>> eduMember = sqlSession.selectList("SuimSchedule.selectEduMemberListTempName");
		
		String sTmpUserNo = "";
		String sTmpTeamId = "";
		String sUserName = "";
		
		for( int i = 0; i < eduMember.size(); i++ ) {
			sTmpUserNo = eduMember.get(i).get("user_no").toString();
			sTmpTeamId = eduMember.get(i).get("team_id_main").toString();
			sUserName = eduMember.get(i).get("user_name").toString();
			
			logger.info(i+" : "+sUserName+" : "+sTmpUserNo +" : "+sTmpTeamId);
			paramMap.put("user_no", sTmpUserNo);
			paramMap.put("team_id", sTmpTeamId);			
			
			sqlSession.insert("SuimSchedule.insertEduMemberApprovalTemp", paramMap);
		}		
		**/
		
		/** 현대해상 결재수수료 관련 임시 작업용
		List<Map<String, Object>> tempList = sqlSession.selectList("SuimSchedule.selectApprovalCollaboListTemp");		
		
		String sTempAcceptNo = "";
		String sTempSuimRptNo = "";
		int nTemp = 0;
		
		for( int i=0; i < tempList.size(); i++ ) {
			sTempSuimRptNo = String.valueOf(tempList.get(i).get("suim_rpt_no"));
			sTempAcceptNo = String.valueOf(tempList.get(i).get("suim_accept_no"));
			nTemp = sqlSession.selectOne("SuimSchedule.selectApprovalCollaboListTempCnt", sTempSuimRptNo);
			if( nTemp > 1) {
				logger.info(i+" : "+sTempAcceptNo+" : "+sTempSuimRptNo);
			}
		}
		**/
		
		/** 보고서 내 보험사 세부코드와 계약기간 구분 마이그래이션 시작 **/
		/**
		Map<String,Object> paramMap = new HashMap<String,Object>();
				
		String sPtnrId = "";
		String sPtnrIdSub = "";
		String sPeriodFlag = "";
		
		String sSuimAcceptNo = "";
		String sPtnrIdNm = "";
		String sPtnrIdSubNm = "";
		String sPeriodFlagNm = "";
		
		//대상 보고서 목록을 불러온다.		
		List<Map<String,Object>> migReportList = sqlSession.selectList("SuimSchedule.selectMigReportList");
		
		for( int i=0; i < migReportList.size(); i++ ) {
			sSuimAcceptNo = String.valueOf(migReportList.get(i).get("suim_accept_no"));
			sPtnrIdNm = String.valueOf(migReportList.get(i).get("ptnr_id_nm"));
			sPtnrIdSubNm = String.valueOf(migReportList.get(i).get("ptnr_id_sub_nm"));
			sPeriodFlagNm = String.valueOf(migReportList.get(i).get("period_flag_nm"));
			
			//장기,일반 구분
			if( "장기".equals(sPeriodFlagNm) ) {
				sPeriodFlag = "1";	
			}else if( "일반".equals(sPeriodFlagNm) ) {
				sPeriodFlag = "2";
			}else {
				sPeriodFlag = "0";
			}
			
			//보험사 명으로 보험사 코드 불러오기
			sPtnrId = sqlSession.selectOne("SuimSchedule.selectPtnrIdByPtnrName", sPtnrIdNm);
			
			//보험사 세부코드 값을 가져오기
			paramMap.put("ptnr_id", sPtnrId);
			paramMap.put("ptnr_id_sub_nm", sPtnrIdSubNm);
			sPtnrIdSub = sqlSession.selectOne("SuimSchedule.selectPtnrIdSubBySystemAdm", paramMap);			
			
			//System.out.println( i +" : "+sSuimAcceptNo+" : "+sPtnrIdNm+" : "+ sPtnrId +" : "+sPtnrIdSubNm+" : "+sPtnrIdSub+" : "+sPeriodFlagNm+" : "+sPeriodFlag);
			
			System.out.println(i+" : "+sSuimAcceptNo+" : "+sPtnrIdSub+" : "+sPeriodFlag);
			
			//보고서 세부코드, 계약기간 갱신
			paramMap.put("suim_accept_no", sSuimAcceptNo);
			paramMap.put("ptnr_id_sub", sPtnrIdSub);
			paramMap.put("period_flag", sPeriodFlag);
			
			sqlSession.update("SuimSchedule.updateMigReportByPtnrIdSub", paramMap);
			
		}		
		**/
		/** 보고서 내 보험사 세부코드와 계약기간 구분 마이그래이션 끝 **/
		
		
		/** 보험사 부서와 보험사 담당자 부서명이 동기화 프로그램 시작 **/
		/**
		Map<String,Object> paramMap = new HashMap<String,Object>();
		
		List<Map<String,Object>> ptnrMbrBscList = sqlSession.selectList("SuimSchedule.selectTopPtnrMbrBscList");
		
		
		String sUserName = "";
		String sPtnrMbrNo = "";
		String sPtnrDeptId = "";
		String sPtnrDeptNm = "";
		String sRealDeptNm = "";
		
		for( int i=0; i < ptnrMbrBscList.size(); i++ ) {
			
			sPtnrMbrNo = String.valueOf(ptnrMbrBscList.get(i).get("ptnr_mbr_no"));
			sUserName = String.valueOf(ptnrMbrBscList.get(i).get("ptnr_mbr_nm"));
			sPtnrDeptId = String.valueOf(ptnrMbrBscList.get(i).get("ptnr_dept_id"));
			sPtnrDeptNm = String.valueOf(ptnrMbrBscList.get(i).get("ptnr_tm_nm"));
			
			sRealDeptNm = sqlSession.selectOne("SuimSchedule.selectTopPtnrDeptBscByDeptNm", sPtnrDeptId);
			
			if( !"".equals(sRealDeptNm) ) {
				if( !sPtnrDeptNm.equals(sRealDeptNm) ) {
					System.out.println(i + " : "+ sUserName + " : " + sPtnrMbrNo + " : "+ sPtnrDeptNm + " : "+sRealDeptNm);
					
					paramMap.put("ptnr_mbr_no", sPtnrMbrNo);
					paramMap.put("ptnr_tm_nm", sRealDeptNm);
					
					//sqlSession.update("SuimSchedule.updateTopPtnrMbrBscByPtnrTmNm", paramMap);
					
				}
			}
		}
		**/
		/** 보험사 부서와 보험사 담당자 부서명이 동기화 프로그램 끝 **/
		
		/** 손해사정사 마이그래이션 시작 **/
		/*
		Map<String,Object> paramMap = new HashMap<String,Object>();
		
		//보험사 코드 (9:롯데, 18: 삼성, 17:흥국, AXA:23, ABL:41)
		paramMap.put("ptnr_id", "41");
		
		List<Map<String, Object>> migCertiReportList = sqlSession.selectList("TopMbrDtlMapper.selectMigPtnrByCertiInfoList", paramMap);
		
		String tempEkey = "";
		String certiStateVal = "";
		String workPhone = "";
		String workPhoneNew = "";		
		
		for( int i=0; i < migCertiReportList.size(); i++) {
			tempEkey = String.valueOf(migCertiReportList.get(i).get("ekey"));
			certiStateVal = String.valueOf(migCertiReportList.get(i).get("certi_state_val"));
			workPhone = String.valueOf(migCertiReportList.get(i).get("work_phone"));
			workPhoneNew = String.valueOf(migCertiReportList.get(i).get("work_phone_new"));
			
			//System.out.println( i +" : "+tempEkey+" : "+certiStateVal+" : "+workPhone+" : "+workPhoneNew);
			
			if("담당자".equals(certiStateVal)) {
				System.out.println( i +" : "+tempEkey+" : "+certiStateVal+" : "+workPhone+" : "+workPhoneNew);
				paramMap.put("ekey", tempEkey);
				paramMap.put("certi_state_val", "손해사정사");
				paramMap.put("work_phone", workPhoneNew);
				sqlSession.update("TopMbrDtlMapper.updateMigPtnrByCertiInfo", paramMap);				
			}
		}
		*/		
		/** 손해사정사 마이그래이션 끝 **/
		
		/** 장비 마이그래이션 시작 **/
		/**
		Map<String,Object> paramMap = new HashMap<String,Object>();
		
		//임시테이블(별도직원용:이름으로 검색)
		List<Map<String,Object>> equipMemberList = sqlSession.selectList("SuimSchedule.selectEquipmentMigByUserName");
		
		String sUserName = "";		
		String sEquipUser = "";
		String sCpuInfo = "";
		String sMemorySize = "";
		int nRet = 0;
		
		for( int i = 0; i < equipMemberList.size(); i++ ) {
			
			sUserName = String.valueOf(equipMemberList.get(i).get("user_name"));
			sEquipUser = String.valueOf(equipMemberList.get(i).get("user_no"));
			sCpuInfo = String.valueOf(equipMemberList.get(i).get("col_cd"));
			sMemorySize = String.valueOf(equipMemberList.get(i).get("memory_size"));
			
			paramMap.put("user_no", sEquipUser);
			paramMap.put("cpu_info", sCpuInfo);
			paramMap.put("memory_size", sMemorySize);
			
			nRet = sqlSession.update("SuimSchedule.updateEquipmentMigByUserName", paramMap);
			
			if( nRet > 0) {
				System.out.println( i +" : "+ nRet +"개 갱신 : " + sUserName+ " : "+sEquipUser+" : "+sCpuInfo+" : "+sMemorySize);
			}else{
				System.out.println( i + " : 장비없음 : " + sUserName+ " : "+sEquipUser+" : "+sCpuInfo+" : "+sMemorySize);
			}
		}
		**/
		/** 장비 마이그래이션 끝 **/
		
		/** 연차 동기화 관련 작업
		Map<String,Object> paramMap = new HashMap<String,Object>();		
		Map<String,Object> logParamMap = new HashMap<String,Object>();
		
		//연차재계산 작업 시작
		//계산날짜
		//String sToday = "2022-01-06";
		
		//기준일 이후 마이그래이션
		String sTargetDate = "2019-12-25";		//기준일
		
		//대상자 사번
		//String sTargetUserNo = "2073";					//김혜림 : 2099, 김가을 : 2104, 김희문 : 2339, 은준태 : 2062, 권진석 : 2509, 전관용 : 2083, 김예린이 : 2084, 김태형 : 2073
		
		String sTargetUserNo = "";
		String sTargetUserName = "";
		String sTargetJoinDate = "";
		
		//마이그래이선 직원 명단 (근무자 이면서 2020년 1월 1일 이후 입사자)
		List<Map<String, Object>> targetUserList = sqlSession.selectList("SuimSchedule.selectTopMbrBscByJoinDate", sTargetDate);
		
		for( int j = 0; j < targetUserList.size(); j++ ) {
			sTargetUserNo = targetUserList.get(j).get("user_no").toString();
			sTargetUserName = targetUserList.get(j).get("user_name").toString();
			sTargetJoinDate =  targetUserList.get(j).get("join_date_fmt").toString();
			
			int nChk = sqlSession.selectOne("SuimSchedule.selectTopVacationSyncCountByUserno", sTargetUserNo);
			
			if( nChk == 0 ) {
				System.out.println( "동기화 시작 : "+ sTargetUserNo +  " : "+sTargetUserName+" : "+sTargetJoinDate );
				
				//연차 동기화 시작
				List<Map<String, Object>> vacationUseList = sqlSession.selectList("topVacationMapper.selectVacationUseListByUserNo",sTargetUserNo);
				
				//입사일자
				String sJoinDate = sqlSession.selectOne("topVacationMapper.selectUserJoinDate", sTargetUserNo);
				
				//연차 테이블 변수
				String sSerialNo = "";			//연차 키
				String sStartDate = "";			//기준 시작일
				String sEndDate = "";			//기준 종료일
				Double dAnnualSet = 0.0;		//기존 연차할당일
				Double dAnnualUse = 0.0;	//기존 연차사용일
				
				Double dNextAnnual = 0.0;	//이월연차
				int nTempAnnualSet = 0;
				
				for( int i = 0; i < vacationUseList.size(); i++) {
					
					//휴가사용 테이블 변수
					String sInfoSerialNo = "";		//휴가키
					Double dUseCount = 0.0;		//휴가사용일
					Double dSumUseCount = 0.0;	//휴가사용합계
					
					sSerialNo = vacationUseList.get(i).get("serial_no").toString();
					sStartDate = vacationUseList.get(i).get("annual_start_date").toString();
					sEndDate = vacationUseList.get(i).get("annual_end_date").toString();
					
					nTempAnnualSet = DateUtil.nCalYearVacation(sJoinDate, sStartDate);
					
					//연차를 입사일 기준으로 계산
					if( nTempAnnualSet == 0 ) {
						dAnnualSet = Double.valueOf(vacationUseList.get(i).get("annual_set").toString());
					}else{
						dAnnualSet = (double)nTempAnnualSet;
					}
					
					dAnnualUse = Double.valueOf(vacationUseList.get(i).get("annual_use").toString());
					
					paramMap.put("user_no", sTargetUserNo);
					paramMap.put("annual_start_date", sStartDate);
					paramMap.put("annual_end_date", sEndDate);
					
					if( dNextAnnual < 0 ) {		//선연차 쓴 경우 총사용 값에 미리 더 해준다.  
						dSumUseCount = (dNextAnnual * -1);
					}else if( dNextAnnual > 0 ) {		//연차가 남은경우 할당량에 이월해준다.
						dAnnualSet += dNextAnnual;
					}			
					
					//System.out.println(sStartDate+" 연차할당 : "+dAnnualSet);
					
					//해당 연차에 사용한 휴가목록을 가져온다.
					List<Map<String, Object>> vacationInfoList = sqlSession.selectList("topVacationMapper.selectVacationInfoListByUserNoToDate", paramMap);
					
					for( int k = 0; k < vacationInfoList.size(); k++ ) {
						sInfoSerialNo = vacationInfoList.get(k).get("serial_no").toString();
						dUseCount = Double.parseDouble(vacationInfoList.get(k).get("use_count").toString());
						dSumUseCount += dUseCount;				
						//System.out.println( k+" : "+sInfoSerialNo + " : "+dUseCount +" : "+dSumUseCount);
						
						//선연차 플래그 갱신 (연차할당 보다 사용수가 크면 선연차로 표시)
						if( dAnnualSet < dSumUseCount ) {
							sqlSession.update("topVacationMapper.updateVacationInfoNextUseBy1",sInfoSerialNo);					
						}else {
							sqlSession.update("topVacationMapper.updateVacationInfoNextUseBy0",sInfoSerialNo);
						}				
					}
					
					paramMap.put("serial_no", sSerialNo);			
					
					//이월연차 = 할당연차 - 사용연차
					dNextAnnual = dAnnualSet - dSumUseCount;
						
					//연차사용 수 갱신
					paramMap.put("annual_set", dAnnualSet);
					paramMap.put("annual_use", dSumUseCount);
					paramMap.put("vacation_use", dSumUseCount);
						
					sqlSession.update("topVacationMapper.updateVacationUseBySync",paramMap);
						
				}				
				//연차 동기화 끝				
				
				//작업완료자는 동기화 완료로그에 넣는다.
				logParamMap.put("user_no", sTargetUserNo);
				logParamMap.put("user_name", sTargetUserName);
				logParamMap.put("join_date", sTargetJoinDate);
				sqlSession.insert("SuimSchedule.insertTopVacationSyncInfo",logParamMap);
				
				System.out.println( "동기화 완료 : "+ sTargetUserNo +  " : "+sTargetUserName+" : "+sTargetJoinDate );
				
			}else{
				System.out.println( "작업완료자 : "+sTargetUserName );
			}
			
		}
		
		**/
		
		/**
		//담당 손해사정사 정보입력 시작
		Map<String,Object> paramMap = new HashMap<String,Object>();
		
		List<Map<String, Object>> migCertiManagerList = sqlSession.selectList("TopMbrDtlMapper.selectMigTempCertiManagerList");
		
		String sTempUserNo = "";
		String sCkey1 = "";
		String sCkey2 = "";
		String sManager1 = "";
		String sManager2 = "";
		
		System.out.println("############################# 시작 #############################");
		
		for( int i = 0; i < migCertiManagerList.size(); i++ ) {
			sTempUserNo = String.valueOf(migCertiManagerList.get(i).get("user_no"));
			sManager1 = String.valueOf(migCertiManagerList.get(i).get("manager_1"));
			sManager2 = String.valueOf(migCertiManagerList.get(i).get("manager_2"));	
			
			sCkey1 = sqlSession.selectOne("TopMbrDtlMapper.selectMigCertiManagerCkeyByUserName",sManager1);
			
			paramMap.put("user_no", sTempUserNo);			
			paramMap.put("ckey", sCkey1);			
			sqlSession.insert("TopMbrUdtMapper.insertCertiManagerInfo", paramMap);
			
			if( !"null".endsWith(sManager2) ) {
				sCkey2 = sqlSession.selectOne("TopMbrDtlMapper.selectMigCertiManagerCkeyByUserName",sManager2);
				paramMap.put("ckey", sCkey2);				
				sqlSession.insert("TopMbrUdtMapper.insertCertiManagerInfo", paramMap);
				
			}
			CommonUtils.printMap(paramMap);
		}
		
		System.out.println("############################# 끝 #############################");
		//담당 손해사정사 정보입력 끝
		**/
		
		/**
		//손해사정사 정보 입력 시작
		Map<String,Object> paramMap = new HashMap<String,Object>();
		
		//손해사정사 마이그래이션 테이블 데이터를 가져온다. 
		List<Map<String, Object>> migCertiMemberList = sqlSession.selectList("TopMbrDtlMapper.selectMigTempCertiMemberList");
			
		String sMigUserNo = "";
		String sUserName = "";
		String sCertiClass = "";
		String sCertiState = "";		//top_mbr_bsc 의 certi_state
		String sCertiType = "";
		String sCertiNumber = "";
		int nCntCertiNum = 0;			//등록번호 중복체크
		
		for( int i = 0; i < migCertiMemberList.size(); i++ ) {
			sMigUserNo = String.valueOf(migCertiMemberList.get(i).get("user_no"));
			sUserName = String.valueOf(migCertiMemberList.get(i).get("user_name"));
			sCertiClass = String.valueOf(migCertiMemberList.get(i).get("certi_class"));
			sCertiType = String.valueOf(migCertiMemberList.get(i).get("certi_type"));
			sCertiNumber = String.valueOf(migCertiMemberList.get(i).get("certi_number"));
			
			//사번이 존재하는 경우만 처리한다.
			if( !"null".equals(sMigUserNo) ) {
				paramMap.put("user_no", sMigUserNo);
				
				if( "2".equals(sCertiClass) ) {
					sCertiState = "4"; 
				}else{
					sCertiState = sCertiClass;
				}
				paramMap.put("certi_state", sCertiState);
				
				sqlSession.update("TopMbrDtlMapper.updateTopMbrBscCertiStateByUserNo",paramMap);
				
				//기 등록번호가 있는지 확인한다.
				paramMap.put("certi_number", sCertiNumber);
				nCntCertiNum = sqlSession.selectOne("TopMbrDtlMapper.selectMigCertiNumberChk", paramMap);
				
				if( nCntCertiNum == 0 ) {			//등록된 등록번호가 없는 경우만 추가한다.
					
					paramMap.put("certi_class", sCertiClass);
					paramMap.put("certi_type", sCertiType);
					
					//CommonUtils.printMap(paramMap);
					sqlSession.insert("TopMbrDtlMapper.insertMigCertiInfo", paramMap);
					
					System.out.println("등록 : "+sUserName+" : "+sCertiClass+" : "+sCertiType+" : "+sCertiNumber);
					
				}
				
			}
			
		}
		
		//손해사정사 정보 입력 끝
		**/
		
		/*
		List<Map<String, Object>> vacationUseList = sqlSession.selectList("topVacationMapper.selectVacationUseListByUserNo",sTargetUserNo);
		
		//입사일자
		String sJoinDate = sqlSession.selectOne("topVacationMapper.selectUserJoinDate", sTargetUserNo);
		
		//연차 테이블 변수
		String sSerialNo = "";			//연차 키
		String sStartDate = "";			//기준 시작일
		String sEndDate = "";			//기준 종료일
		Double dAnnualSet = 0.0;		//기존 연차할당일
		Double dAnnualUse = 0.0;	//기존 연차사용일
		
		Double dNextAnnual = 0.0;	//이월연차
		int nTempAnnualSet = 0;
		
		for( int i = 0; i < vacationUseList.size(); i++) {
			
			//휴가사용 테이블 변수
			String sInfoSerialNo = "";		//휴가키
			Double dUseCount = 0.0;		//휴가사용일
			Double dSumUseCount = 0.0;	//휴가사용합계
			
			sSerialNo = vacationUseList.get(i).get("serial_no").toString();
			sStartDate = vacationUseList.get(i).get("annual_start_date").toString();
			sEndDate = vacationUseList.get(i).get("annual_end_date").toString();
			
			nTempAnnualSet = DateUtil.nCalYearVacation(sJoinDate, sStartDate);
			
			//연차를 입사일 기준으로 계산
			if( nTempAnnualSet == 0 ) {
				dAnnualSet = Double.valueOf(vacationUseList.get(i).get("annual_set").toString());
			}else{
				dAnnualSet = (double)nTempAnnualSet;
			}
			
			dAnnualUse = Double.valueOf(vacationUseList.get(i).get("annual_use").toString());
			
			paramMap.put("user_no", sTargetUserNo);
			paramMap.put("annual_start_date", sStartDate);
			paramMap.put("annual_end_date", sEndDate);
			
			if( dNextAnnual < 0 ) {		//선연차 쓴 경우 총사용 값에 미리 더 해준다.  
				dSumUseCount = (dNextAnnual * -1);
			}else if( dNextAnnual > 0 ) {		//연차가 남은경우 할당량에 이월해준다.
				dAnnualSet += dNextAnnual;
			}			
			
			System.out.println(sStartDate+" 연차할당 : "+dAnnualSet);
			
			//해당 연차에 사용한 휴가목록을 가져온다.
			List<Map<String, Object>> vacationInfoList = sqlSession.selectList("topVacationMapper.selectVacationInfoListByUserNoToDate", paramMap);
			
			for( int k = 0; k < vacationInfoList.size(); k++ ) {
				sInfoSerialNo = vacationInfoList.get(k).get("serial_no").toString();
				dUseCount = Double.parseDouble(vacationInfoList.get(k).get("use_count").toString());
				dSumUseCount += dUseCount;				
				//System.out.println( k+" : "+sInfoSerialNo + " : "+dUseCount +" : "+dSumUseCount);
				
				//선연차 플래그 갱신 (연차할당 보다 사용수가 크면 선연차로 표시)
				if( dAnnualSet < dSumUseCount ) {
					sqlSession.update("topVacationMapper.updateVacationInfoNextUseBy1",sInfoSerialNo);					
				}else {
					sqlSession.update("topVacationMapper.updateVacationInfoNextUseBy0",sInfoSerialNo);
				}				
			}
			
			paramMap.put("serial_no", sSerialNo);			
			
			//이월연차 = 할당연차 - 사용연차
			dNextAnnual = dAnnualSet - dSumUseCount;
				
			//연차사용 수 갱신
			paramMap.put("annual_set", dAnnualSet);
			paramMap.put("annual_use", dSumUseCount);
			paramMap.put("vacation_use", dSumUseCount);
				
			sqlSession.update("topVacationMapper.updateVacationUseBySync",paramMap);
				
		}
		*/
		//연차재계산 작업 끝 
		
		//한화생명 개인정보(7일 마이그래이션 시작)
		/**
		List<Map<String,Object>> hanHwaSuimRptNo = sqlSession.selectList("SuimSchedule.selectHanHwaSuimRptNoTemp");
		
		Map<String,Object> paramMap = new HashMap<String,Object>();
		
		String sSuimRptNo = "";
		String sAccRptNo = "";
		
		logger.info("Start : "+hanHwaSuimRptNo.size()+" Update ~");
		
		for( int i=0; i < hanHwaSuimRptNo.size(); i++ ) {
			sAccRptNo = hanHwaSuimRptNo.get(i).get("suim_accept_no").toString();
			sSuimRptNo = hanHwaSuimRptNo.get(i).get("suim_rpt_no").toString();
			
			paramMap.put("suim_rpt_no", sSuimRptNo);
			
			sqlSession.update("SuimSchedule.updateHanhwaPersonInfoDel",paramMap);
			
			logger.info(sSuimRptNo+" : "+sAccRptNo);
		}
		
		logger.info("End : "+hanHwaSuimRptNo.size()+" Update ~");
		**/		
		//한화생명 개인정보(7일 마이그래이션 끝)
		
		//삼성화재 개인정보(5일 마이그래이션 시작)
		/**
		List<Map<String,Object>> samsungSuimRptNo = sqlSession.selectList("SuimSchedule.selectSamsungSuimRptNoTemp");
		
		Map<String,Object> paramMap = new HashMap<String,Object>();
		
		String sSuimRptNo = "";
		String sAccRptNo = "";
		
		logger.info("Start : "+samsungSuimRptNo.size()+" Update ~");
		
		for( int i=0; i < samsungSuimRptNo.size(); i++ ) {
			sAccRptNo = samsungSuimRptNo.get(i).get("suim_accept_no").toString();
			sSuimRptNo = samsungSuimRptNo.get(i).get("suim_rpt_no").toString();
			
			paramMap.put("suim_rpt_no", sSuimRptNo);
			
			sqlSession.update("SuimSchedule.updateSamsungPersonInfoDel",paramMap);
			
			logger.info(sSuimRptNo+" : "+sAccRptNo);
		}
		
		logger.info("End : "+samsungSuimRptNo.size()+" Update ~");
		**/
		//삼성화재 개인정보(5일 마이그래이션 끝)
		
		
		//임시테이블 tmp_rpt_head_site 의 접수번호 목록을 불러온다.
		/**
		
		List<Map<String,Object>> temSuimRptNo = sqlSession.selectList("SuimSchedule.selectSuimRptNoTemp");
		
		Map<String,Object> paramMap = new HashMap<String,Object>(); 
		
		String sSuimRptNo = "";
		String sAccRptNo = "";
		int nSiteDate = 0;
		
		int nUpdate = 0;
		int nPass = 0;
		
		for(int i=0; i < temSuimRptNo.size(); i++) {
			sAccRptNo = temSuimRptNo.get(i).get("acc_num").toString();
			sSuimRptNo = temSuimRptNo.get(i).get("suim_rpt_no").toString();			
			
			//현장보고서 등록일자를 가져온다. (단, 파일등록일이 있는경우만.)
			nSiteDate = sqlSession.selectOne("SuimSchedule.selectSuimRptNoSiteDate", sSuimRptNo);
			
			if( nSiteDate > 0 ) {
				paramMap.put("suim_rpt_no", sSuimRptNo);
				paramMap.put("site_rpt_aprv_date", nSiteDate);
				paramMap.put("acc_num", sAccRptNo);
				sqlSession.update("SuimSchedule.updateSuimRptNoUpdateSiteDate",paramMap);
				
				//임시테이블에 플래그 갱신
				sqlSession.update("SuimSchedule.updateSuimRptNoUpdateTemp",paramMap);
				
				logger.info("Update : "+sAccRptNo + " : " + sSuimRptNo + " : "+nSiteDate);
				nUpdate++;				
			}else{
				logger.info("Pass : "+sAccRptNo + " : " + sSuimRptNo);
				nPass++;
			}
			
		}
		
		logger.info("Update : "+nUpdate);
		logger.info("Pass : "+nPass);
		
		/**
		
		List<Map<String,Object>> emptyRptNo = sqlSession.selectList("SuimSchedule.selectSuimRptNoWorkloadEmpty");
		
		logger.info(" emptyRptNo size: "+emptyRptNo.size());
		
		String sSuimRptNo = "";
		int nWorkType = 0; 
		for(int i=0; i < emptyRptNo.size(); i++) {
			sSuimRptNo = emptyRptNo.get(i).get("suim_rpt_no").toString();
			nWorkType = sqlSession.selectOne("SuimSchedule.selectSuimRptHeadLogWorkloadType",sSuimRptNo);
			if( nWorkType > 0 ) {
				System.out.println( "로그있는 보고서 : "+sSuimRptNo +" : 있음");
			}else{
				System.out.println( "로그없는 보고서 : "+sSuimRptNo +" : 없음");
			}
		}
		**/
		
		/**
		//보고서 종결상태이면서 현장보고서 결재정보가 없는경우 갱신 시작
		List<Map<String,Object>> endRptNo = sqlSession.selectList("SuimSchedule.selectSuimRptSiteEndReport");
		String sSuimRptNo = "";		
		String sRegDate = "";
		
		Map<String,Object> tempMap = new HashMap<>();
		
		logger.info("============ Start EndReport Update ("+ endRptNo.size() +")==============");
		
		int nUpdate = 0;
		int nPass = 0;
		
		for( int i=0; i < endRptNo.size(); i++){
			sSuimRptNo = endRptNo.get(i).get("suim_rpt_no").toString();
			//등록된 현장보고서가 있는지 확인한다.
			sRegDate = sqlSession.selectOne("SuimSchedule.selectSuimRptSiteRegDate",sSuimRptNo);
			
			if( "0".equals(sRegDate) ){
				logger.info(i+" : "+sSuimRptNo + " : Pass");
				nPass++;
			}else{
				logger.info(i+" : "+sSuimRptNo + " : Update");
				tempMap.put("suim_rpt_no", sSuimRptNo);
				tempMap.put("site_rpt_aprv_date", sRegDate);
				sqlSession.update("SuimSchedule.updateSuimRptNoEndReport",tempMap);
				nUpdate++;
			}
		}
		
		logger.info("전체 : "+endRptNo.size()+" 갱신 : "+nUpdate+" 패스 : "+nPass);
		
		logger.info("============ End EndReport Update ("+ endRptNo.size() +")==============");
		
		//보고서 종결상태이면서 현장보고서 결재정보가 없는경우 갱신 끝
		 **/
		
		/**
		//종결상태이면서 종결시점 보험사와 종결시점 팀명이 없는 보고서 suim_rpt_no 값을 가져온다.
		List<Map<String,Object>> suimRptNo = sqlSession.selectList("SuimSchedule.selectSuimRptNoEndReport");
		
		String sSuimRptNo = "";
		
		int nCnt = 0;
		
		for( int i = 0; i < suimRptNo.size(); i++) {
			sSuimRptNo = suimRptNo.get(i).get("suim_rpt_no").toString();
			sqlSession.update("SuimSchedule.updateSuimRptNoEndPtnrInfo",sSuimRptNo);
			logger.info("update End Info :"+sSuimRptNo);
			nCnt++;
		}
		
		logger.info("======= OnikuUpdateHead End Info ("+nCnt+") =======");
		
		//종결상태이면서 종결시점 보험사와 종결시점 팀명이 없는 농작물 보고서 suim_rpt_no 값을 가져온다.
		List<Map<String,Object>> bizSuimRptNo = sqlSession.selectList("SuimSchedule.selectSuimRptNoBizEndReport");
		
		String sBizSuimRptNo = "";
		
		int nBizCnt = 0;
		
		for( int i = 0; i < bizSuimRptNo.size(); i++) {
			sBizSuimRptNo = bizSuimRptNo.get(i).get("suim_rpt_no").toString();
			sqlSession.update("SuimSchedule.updateSuimRptNoBizEndPtnrInfo",sBizSuimRptNo);
			logger.info("update Biz End Info :"+sBizSuimRptNo);
			nBizCnt++;
		}
		
		logger.info("======= OnikuUpdateHead Biz End Info ("+nBizCnt+") =======");
		**/
		
		/**
		String sPtnr_id = "26";			//보험사 id (26: 새마을금고)
		String sSuim_rpt_no = "";		//임시수임번호
		
		List<Map<String,Object>> suimRptNo = sqlSession.selectList("SuimSchedule.selectSuimRptNoUpdateChk", sPtnr_id);
		
		for(int i=0; i < suimRptNo.size(); i++) {
			System.out.println("suimRptNo : "+suimRptNo.get(i).get("suim_rpt_no").toString());
			sSuim_rpt_no = suimRptNo.get(i).get("suim_rpt_no").toString();			
			sqlSession.update("SuimSchedule.updateSuimRptNoUpdateAsta",sSuim_rpt_no);			
		}
		**/		
		return "topMainIndex"; 
	}
	
	/**
	 * nilink 녹음파일 마이그래이션 프로그램
	 */
	/*
	@RequestMapping(value="nilinkMigProgess")
	public String nilinkMigProgess( HttpServletRequest request, Model model, HttpSession session ) {
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		String sUserNo = mbrVo.getUser_no();
		
		if(!"1786".equals(sUserNo) ){
			logger.info("OnikuUpdateHeadAsta - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		
		logger.info("============ NilinkMig Start =========");				
		
		//폴더 기본 저장 경로    	
    	String sFullPath = "";
		
		//운영경로
    	//String sPath = "/home/hosting_users/toplac/www/nilink";
    	
    	//테스트경로    	
    	String sPath = "D:\\home"+File.separator+"hosting_users"+File.separator+"toplac"+File.separator+"www"+File.separator+"nilink";
    	
    	String sFolder = "";
    	
    	//폴더경로 시작
    	//날짜 형식
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");

		Calendar cal = Calendar.getInstance();
		
		//종료날짜: 금일-1일 셋팅
		//실행 조건이 특정일로부터 금일의 하루전까지 출력
		//만약 현재날짜라면 cal.add(Calendar.DATE, 1); 해줘야 함
		
		String nowDay = dateFormat.format(cal.getTime());		

		//시작 날짜 셋팅
		cal.set ( 2022, 3, 12 );
		//cal.set ( 2021, 8, 1 );

		//while 비교를 위한 날짜 선언
		String nextDay = "";

		while(!nowDay.equals(nextDay)){
			//System.out.println(dateFormat.format(cal.getTime()));
			
			//데이터 읽어올 날짜 (2020.1.1 부터)
			sFolder = dateFormat.format(cal.getTime());
			
			//sFullPath = sPath+File.separator+sFolder;
			sFullPath = sPath+"/"+sFolder;
	    	
	    	//파일명
	    	String orgFile = "";
	    	String orgFullName = "";
	    	long orgFileSize = 0;
	    	String sType = "";
	    	String sSend = "";
	    	String sReceive = "";
	    	String sDate = "";
	    	String sTime = "";
	    	int nCnt = 0;
	    	String [] divList = {};
	    	
	    	int addCnt = 0;
	    	
	    	Map<String,Object> tmpMap = new HashMap<>();
	    	
	    	try {
	    		//해당 폴더 아래 파일 목록을 불러온다.
		    	for (File info : FileUtils.listFiles(new File(sFullPath), TrueFileFilter.INSTANCE, TrueFileFilter.INSTANCE)) {
		    		orgFile = info.getName();
		    		orgFullName = info.getAbsolutePath();	    		
		    		orgFileSize = info.length();    		
		    		
		    		nCnt = sqlSession.selectOne("TopMbrDtlMapper.countNilinkRecordFileName", orgFile);

		    		//기존에 등록된 파일이 없는경우 추가해준다.
		    		if( nCnt == 0 ) {
		    			divList = orgFile.split("-");
		        		sType = divList[0];
		        		sSend = divList[1];
		        		sReceive = divList[2];
		        		sDate = divList[3];
		        		sTime = divList[4];
		        		
		        		tmpMap.put("rtype", sType);
		        		tmpMap.put("send_num", sSend);
		        		tmpMap.put("receive_num", sReceive);
		        		tmpMap.put("folder_date", sDate);
		        		tmpMap.put("record_time", sTime);
		        		tmpMap.put("file_name", orgFile);
		        		tmpMap.put("full_path", orgFullName.replace("D:\\home\\hosting_users\\toplac\\www\\nilink\\", "/home/hosting_users/toplac/www/nilink/").replace("\\", "/"));
		        		tmpMap.put("file_size", orgFileSize);        		
		        		
		        		sqlSession.insert("TopMbrDtlMapper.insertNilinkRecord", tmpMap);
		        		
		        		addCnt++;
		        		
		        		System.out.println("full_path : "+tmpMap.get("full_path").toString());
		    		}
		    		
		        }
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}	    	
	    	
	    	logger.info("insert Data : "+addCnt);

			cal.add(Calendar.DATE, 1); //하루하루 더해준다.
			nextDay = dateFormat.format(cal.getTime()); //비교를 위한 값 셋팅

		}
    	
		
		logger.info("============ NilinkMig End =========");
		
		return "topMainIndex"; 
		
	}	
	*/
	
	//연차계산 스케줄러 수동 실행
	@RequestMapping(value="VacationScheduleAction")
	@ResponseBody
	public String VacationScheduleAction(HttpServletRequest request, Model model){
		
		logger.info("======= VacationScheduleAction =======");
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sAuthkey = paramMap.get("authkey").toString();
		String sRet = "";		
		
		if("9".equals(sAuthkey)) {
			//스케줄러 실행
			try {
				JobKey jobKey = new JobKey("updateVacationJob");
				Scheduler scheduler = schedulerBean.getScheduler();
				scheduler.triggerJob(jobKey);
				sRet = "success";
			} catch (Exception e) {
				e.printStackTrace();
				sRet = "fail";
			}			
		}else {
			sRet = "no auth";
		}		
		return sRet;
	}		
	
	//2019.10.30 변경
	@RequestMapping(value = "VacationTest4")
	public String getVacationTest4(HttpServletRequest request, Model model){
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sExceldown = request.getParameter("sExceldown");
		
		//신규 날짜 선택시 적용변수
		String selectYear = String.valueOf(paramMap.get("selectYear"));
		String selectMonth = String.valueOf(paramMap.get("selectMonth"));
		String selectDay = String.valueOf(paramMap.get("selectDay"));
		
		String sBase_date = "";
		
		if( "null".equals(selectYear) || "null".equals(selectMonth) || "null".equals(selectDay) ) {			
			//sBase_date = DateUtil.getTodayString("yyyy-MM-dd");
			sBase_date = DateUtil.getTodayString("2019-11-11");			//2019년 11월 11일로 기준일변경
			selectYear = sBase_date.substring(0, 4);
			selectMonth = sBase_date.substring(5, 7);
			selectDay = sBase_date.substring(8, 10);
		}else {			
			sBase_date = selectYear+"-"+DateUtil.getFormatMonth(selectMonth)+"-"+DateUtil.getFormatMonth(selectDay);
		}
		
		//System.out.println("sBase_date="+sBase_date);
		
		//System.out.println("selectYear="+selectYear);
		//System.out.println("selectMonth="+selectMonth);
		//System.out.println("selectDay="+selectDay);
		
		paramMap.put("authLevel", "3");
		
		//근무중인 사용자 목록을 가져온다.		
		List<VacationInfoBean> userInfoList = sqlSession.selectList("topVacationMapper.testVacatioinMemberList4",paramMap);
		
		//신규변수 추가
		double n2018Yearset = 0;			//2018년 발생연차
		double n2018holiday = 0;			//2018년 대체사용연차(공휴일)
		double n2018_vacation_work_use = 0;		//2018년 사용연차
		double n2018Extraset = 0;				//2018년 잔여연차
		double n2018Overset = 0;				//2018년 이월연차
		
		double nTotalYearset = 0;			//연차이월분 포함 사용가능 연차
		double n2019Extraset = 0;				//2019년 잔여연차
		
		int user_no = 0;				//사번
		String user_id = "";			//아이디
		String sJoin_date = "";		//입사일자
		double nIn_365 = 0;				//기본 년월차
		double n2019holiday = 0;				//공휴일 차감 연차
		double org_year_cal = 0;			//사용가능연차		
		
		for(int i=0; i < userInfoList.size(); i++) {
			user_no = userInfoList.get(i).getUser_no();
			user_id = userInfoList.get(i).getUser_id();	
			sJoin_date = userInfoList.get(i).getJoin_date();
			
			String s2018Join_date = "2018-"+sJoin_date.substring(5, 10);
			String s2019Join_date = "2019-"+sJoin_date.substring(5, 10);			
			
			//월차인지 연차인지 체크한다.
			if( DateUtil.chkYear(sJoin_date, sBase_date) ) {		//1년 이상				
			//if( DateUtil.chkYear(sJoin_date, "2019-12-31") ) {		//1년 이상
				//System.out.println("입사일 : "+sJoin_date +" 체크날 : "+sBase_date+" : 년차로처리");
				
				nIn_365 = getCalVacation(sBase_date, sJoin_date);
								
				//nIn_365 = getCalVacation("2019-12-31", sJoin_date);
				userInfoList.get(i).setnYearset(nIn_365);		//통합데이터로 변경
				
			}else {		//1년 미만
				//System.out.println("입사일 : "+sJoin_date +" 체크날 : "+sBase_date+" : 월차로처리");				
				
				//2019년 11월 1일 기준으로는 1년 미만이지만 2019년 12월 31일 기준 1년이상인 사람은 2019년 연차를 별도로 계산해준다.
				if( DateUtil.chkYear(sJoin_date, "2019-12-31") ) {		//2019년 12월 31일 이전 입사자
					userInfoList.get(i).setnYearset(15);		//2019년 연차지정
				}else {
					//1년 이내 입사자는 월차로 계산한다. (2019년 입사자)
					nIn_365 = nCalMonthVacation(sJoin_date, sBase_date);		//입사일, 기준일로 월차계산
					//nIn_365 = nCalMonthVacation(sJoin_date, "2019-12-31");		//입사일, 기준일로 월차계산
					userInfoList.get(i).setnYearset(nIn_365);		//2019년 연차지정
				}				
				
			}
			
			//2018년 연차계산 (2017년 11월 1일 이전 입사자만 해당한다.)			
			
			if( !DateUtil.chkYear(sJoin_date, "2019-12-31") ){
				userInfoList.get(i).setN2018Yearset(0);
				userInfoList.get(i).setN2018Holiday(0);
				userInfoList.get(i).setN2018_vacation_work_use(0);
				userInfoList.get(i).setN2018Extraset(0);
				userInfoList.get(i).setN2018Overset(0);
			}else{
				
				if( DateUtil.chkYear(sJoin_date, "2018-12-31") ) {		//2018년 월차로 계산해야하는 사람					
					n2018Yearset = getCalVacation(s2018Join_date, sJoin_date);
					userInfoList.get(i).setN2018Yearset(n2018Yearset);
				}else {					
					n2018Yearset = calMonthday(s2019Join_date,sJoin_date);				
					userInfoList.get(i).setN2018Yearset(n2018Yearset);					
				}
				
				//DB에 등록된 연차대체휴가 수를 가져온다.
				paramMap.put("user_no", user_no);
				paramMap.put("sdate", s2018Join_date);
				paramMap.put("edate", s2019Join_date);				
				
				n2018holiday = sqlSession.selectOne("topVacationMapper.selectHoildayUseCount",paramMap);
				//n2018holiday = chk2019holiday(s2019Join_date,s2018Join_date);				
				userInfoList.get(i).setN2018Holiday(n2018holiday);
				
				//2018년 연차사용수
				paramMap.put("user_no", user_no);
				paramMap.put("sdate", s2018Join_date);
				paramMap.put("edate", s2019Join_date);
				
				n2018_vacation_work_use = sqlSession.selectOne("topVacationMapper.selectVacationUseCount",paramMap);
				userInfoList.get(i).setN2018_vacation_work_use(n2018_vacation_work_use);
				
				//2018년 잔여연차 계산
				n2018Extraset = n2018Yearset - n2018holiday - n2018_vacation_work_use;			
				userInfoList.get(i).setN2018Extraset(n2018Extraset);
				
				if( n2018Extraset < 0 ) {
					userInfoList.get(i).setN2018Overset(0);
					n2018Overset = 0;
				}else {
					userInfoList.get(i).setN2018Overset(n2018Extraset);
					n2018Overset = n2018Extraset;
				}			
				
			}
			
			//이월분으로 포함한 연차 셋팅
			nTotalYearset = nIn_365 + n2018Overset;
			userInfoList.get(i).setnTotalYearset(nTotalYearset);

			//DB에 등록된 2019년 공휴일 연차대체휴가 수를 가져온다.
			paramMap.put("user_no", user_no);
			paramMap.put("sdate", s2019Join_date);
			paramMap.put("edate", sBase_date);					//12월 말까지인 경우는 2019년 12월 31일로 입력				
			
			n2019holiday = sqlSession.selectOne("topVacationMapper.selectHoildayUseCount",paramMap);
			//n2019holiday = chk2019holiday(sBase_date,s2019Join_date);
			
			userInfoList.get(i).setnHoliday(n2019holiday);

			//2019년 현재까지 사용한 휴가수			
			paramMap.put("user_no", user_no);
			paramMap.put("sdate", s2019Join_date);
			paramMap.put("edate", sBase_date);
			
			Double vacationUseCnt = sqlSession.selectOne("topVacationMapper.selectVacationUseCount",paramMap);
			
			//4종은 2019년 입사일 이후 실제사용 휴가는 0으로 만들어준다.
			vacationUseCnt = 0.0;
			userInfoList.get(i).setN2019_vacation_work_use(vacationUseCnt);
			
			//실제 사용가능한 연차
			org_year_cal = nIn_365 - n2019holiday - vacationUseCnt;
			userInfoList.get(i).setOrg_year_cal(org_year_cal);
			
			//2019년 잔여연차
			n2019Extraset = nTotalYearset - n2019holiday - vacationUseCnt;
			
			if( n2019Extraset < 0 ) {
				n2019Extraset = 0;
			}
			
			userInfoList.get(i).setN2019Extraset(n2019Extraset);
		}	

		model.addAttribute("selectYear",selectYear);
		model.addAttribute("selectMonth",selectMonth);
		model.addAttribute("selectDay",selectDay);
		model.addAttribute("userInfoList", userInfoList);
		
		if("1".equals(sExceldown)){
			return "util_etc/vacation_test4_excel";
		}else {
			return "util_etc/vacation_test4";
		}
	}
	
	@RequestMapping(value = "VacationTest4bk")
	public String getVacationTest4bk(HttpServletRequest request, Model model){
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sExceldown = request.getParameter("sExceldown");
		
		//신규 날짜 선택시 적용변수
		String selectYear = String.valueOf(paramMap.get("selectYear"));
		String selectMonth = String.valueOf(paramMap.get("selectMonth"));
		String selectDay = String.valueOf(paramMap.get("selectDay"));
		
		String sBase_date = "";
		
		if( "null".equals(selectYear) || "null".equals(selectMonth) || "null".equals(selectDay) ) {			
			//sBase_date = DateUtil.getTodayString("yyyy-MM-dd");
			sBase_date = DateUtil.getTodayString("2019-11-11");			//2019년 11월 11일로 기준일변경
			selectYear = sBase_date.substring(0, 4);
			selectMonth = sBase_date.substring(5, 7);
			selectDay = sBase_date.substring(8, 10);
		}else {			
			sBase_date = selectYear+"-"+DateUtil.getFormatMonth(selectMonth)+"-"+DateUtil.getFormatMonth(selectDay);
		}		
		
		paramMap.put("authLevel", "3");
		
		//근무중인 사용자 목록을 가져온다.		
		List<VacationInfoBean> userInfoList = sqlSession.selectList("topVacationMapper.testVacatioinMemberList4",paramMap);
		
		//4종용 신규변수 추가 ** 표시있는 변수만 사용한다.
		double n2018Yearset = 0;			//2019년 1월1일 이후 발생연차 ** 
		
		double n2018holiday = 0;			//2018년 대체사용연차(공휴일)
		
		double n2018_vacation_work_use = 0;		//2019년 1월 1일 부터 2019년 12월 31일까지 사용연차 **
		double n2018Extraset = 0;				//2019년 잔여연차 **
		
		double n2018Overset = 0;				//2019년 이월연차 **
		
		double nTotalYearset = 0;			//연차이월분 포함 사용가능 연차
		double n2019Extraset = 0;				//2019년 잔여연차
		
		int user_no = 0;				//사번
		String user_id = "";			//아이디
		String sJoin_date = "";		//입사일자
		double nIn_365 = 0;				//기본 년월차
		double n2019holiday = 0;				//공휴일 차감 연차
		double org_year_cal = 0;			//사용가능연차		
		
		for(int i=0; i < userInfoList.size(); i++) {
			user_no = userInfoList.get(i).getUser_no();
			user_id = userInfoList.get(i).getUser_id();	
			sJoin_date = userInfoList.get(i).getJoin_date();
			
			String s2018Join_date = "2018-"+sJoin_date.substring(5, 10);
			String s2019Join_date = "2019-"+sJoin_date.substring(5, 10);
			
			//월차인지 연차인지 체크한다.
			if( DateUtil.chkYear(sJoin_date, sBase_date) ) {		//1년 이상
				nIn_365 = getCalVacation(sBase_date, sJoin_date);				
				userInfoList.get(i).setnYearset(nIn_365);		//통합데이터로 변경
				
			}else {		//1년 미만
				//1년 이내 입사자는 월차로 계산한다.
				nIn_365 = nCalMonthVacation(sJoin_date, sBase_date);		//입사일, 기준일로 월차계산
				userInfoList.get(i).setnYearset(nIn_365);		//통합데이터로 변경
			}
			
			//2018년 연차계산 (2017년 11월 1일 이전 입사자만 해당한다.)
			
			if( DateUtil.chkYear(sJoin_date, "2020-01-01") ) {				
				//n2018Yearset = getCalVacation(s2018Join_date, sJoin_date);				
				userInfoList.get(i).setN2018Yearset(11);		//2019년 1월1일 이전 입사자는 11일				
				
				//DB에 등록된 연차대체휴가 수를 가져온다.
				paramMap.put("user_no", user_no);
				paramMap.put("sdate", s2018Join_date);
				paramMap.put("edate", s2019Join_date);				
				
				n2018holiday = sqlSession.selectOne("topVacationMapper.selectHoildayUseCount",paramMap);				
				userInfoList.get(i).setN2018Holiday(n2018holiday);
				
				//2019년 연차사용수
				paramMap.put("user_no", user_no);
				paramMap.put("sdate", "2019-01-01");
				paramMap.put("edate", "2019-12-31");
				
				n2018_vacation_work_use = sqlSession.selectOne("topVacationMapper.selectVacationUseCount",paramMap);
				userInfoList.get(i).setN2018_vacation_work_use(n2018_vacation_work_use);
				
				//2019년 잔여연차
				n2018Extraset = 11 - n2018_vacation_work_use; 			
				userInfoList.get(i).setN2018Extraset(n2018Extraset);
				
				if( n2018Extraset < 0 ) {
					userInfoList.get(i).setN2018Overset(0);
					n2018Overset = 0;
				}else {
					userInfoList.get(i).setN2018Overset(n2018Extraset);
					n2018Overset = n2018Extraset;
				}			
				
			}else {				
				//2019년 이후 입사자는 11에서 입사월을 뺀다.
				n2018Yearset = 11 - Integer.parseInt(sJoin_date.substring(5, 7));
				userInfoList.get(i).setN2018Yearset(n2018Yearset);
				
				//2019년 연차사용수
				paramMap.put("user_no", user_no);
				paramMap.put("sdate", "2019-01-01");
				paramMap.put("edate", "2019-12-31");
				
				n2018_vacation_work_use = sqlSession.selectOne("topVacationMapper.selectVacationUseCount",paramMap);
				userInfoList.get(i).setN2018_vacation_work_use(n2018_vacation_work_use);
				
				//2019년 잔여연차
				n2018Extraset = n2018Yearset - n2018_vacation_work_use; 			
				userInfoList.get(i).setN2018Extraset(n2018Extraset);
				
				userInfoList.get(i).setN2018Holiday(0);
				
				//2019년 이월 연차
				if( n2018Extraset < 0 ) {
					userInfoList.get(i).setN2018Overset(0);
					n2018Overset = 0;
				}else {
					userInfoList.get(i).setN2018Overset(n2018Extraset);
					n2018Overset = n2018Extraset;
				}
			}
			
			//이월분으로 포함한 연차 셋팅
			nTotalYearset = nIn_365 + n2018Overset;
			userInfoList.get(i).setnTotalYearset(nTotalYearset);			
			
			//DB에 등록된 2019년 공휴일 연차대체휴가 수를 가져온다.
			paramMap.put("user_no", user_no);
			paramMap.put("sdate", s2019Join_date);
			paramMap.put("edate", sBase_date);					//12월 말까지인 경우는 2019년 12월 31일로 입력				
			
			n2019holiday = sqlSession.selectOne("topVacationMapper.selectHoildayUseCount",paramMap);
			//n2019holiday = chk2019holiday(sBase_date,s2019Join_date);			
			userInfoList.get(i).setnHoliday(n2019holiday);

			//2019년 현재까지 사용한 휴가수			
			paramMap.put("user_no", user_no);
			paramMap.put("sdate", s2019Join_date);
			paramMap.put("edate", sBase_date);
			
			//Double vacationUseCnt = sqlSession.selectOne("topVacationMapper.selectVacationUseCount",paramMap);
			//userInfoList.get(i).setN2019_vacation_work_use(vacationUseCnt);
			Double vacationUseCnt = 0.0;
			userInfoList.get(i).setN2019_vacation_work_use(vacationUseCnt);		//4종은 앞에서 차감했으므로 빼지않음
			
			//실제 사용가능한 연차
			org_year_cal = nIn_365 - n2019holiday - vacationUseCnt;
			userInfoList.get(i).setOrg_year_cal(org_year_cal);
			
			//2019년 잔여연차
			if( nIn_365 < n2019holiday ) {
				n2019Extraset = n2018Overset;
			}else {
				n2019Extraset = nTotalYearset - n2019holiday - vacationUseCnt;
			}			
			userInfoList.get(i).setN2019Extraset(n2019Extraset);
		}	

		model.addAttribute("selectYear",selectYear);
		model.addAttribute("selectMonth",selectMonth);
		model.addAttribute("selectDay",selectDay);
		model.addAttribute("userInfoList", userInfoList);
		
		if("1".equals(sExceldown)){
			return "util_etc/vacation_test4_excel";
		}else {
			return "util_etc/vacation_test4";
		}
	}
	
	@RequestMapping(value = "VacationTest")
	public String getVacationTest(HttpServletRequest request, Model model){
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sExceldown = request.getParameter("sExceldown");
		
		//신규 날짜 선택시 적용변수
		String selectYear = String.valueOf(paramMap.get("selectYear"));
		String selectMonth = String.valueOf(paramMap.get("selectMonth"));
		String selectDay = String.valueOf(paramMap.get("selectDay"));
		
		String sBase_date = "";
		
		if( "null".equals(selectYear) || "null".equals(selectMonth) || "null".equals(selectDay) ) {			
			//sBase_date = DateUtil.getTodayString("yyyy-MM-dd");
			sBase_date = DateUtil.getTodayString("2019-11-11");			//2019년 11월 11일로 기준일변경
			selectYear = sBase_date.substring(0, 4);
			selectMonth = sBase_date.substring(5, 7);
			selectDay = sBase_date.substring(8, 10);
		}else {			
			sBase_date = selectYear+"-"+DateUtil.getFormatMonth(selectMonth)+"-"+DateUtil.getFormatMonth(selectDay);
		}
		
		//System.out.println("sBase_date="+sBase_date);
		
		//System.out.println("selectYear="+selectYear);
		//System.out.println("selectMonth="+selectMonth);
		//System.out.println("selectDay="+selectDay);
		
		paramMap.put("authLevel", "3");
		
		//근무중인 사용자 목록을 가져온다.		
		List<VacationInfoBean> userInfoList = sqlSession.selectList("topVacationMapper.testVacatioinMemberList1",paramMap);
		
		//신규변수 추가
		double n2018Yearset = 0;			//2018년 발생연차
		double n2018holiday = 0;			//2018년 대체사용연차(공휴일)
		double n2018_vacation_work_use = 0;		//2018년 사용연차
		double n2018Extraset = 0;				//2018년 잔여연차
		double n2018Overset = 0;				//2018년 이월연차
		
		double nTotalYearset = 0;			//연차이월분 포함 사용가능 연차
		double n2019Extraset = 0;				//2019년 잔여연차
		
		int user_no = 0;				//사번
		String user_id = "";			//아이디
		String sJoin_date = "";		//입사일자
		double nIn_365 = 0;				//기본 년월차
		double n2019holiday = 0;				//공휴일 차감 연차
		double org_year_cal = 0;			//사용가능연차		
		
		for(int i=0; i < userInfoList.size(); i++) {
			user_no = userInfoList.get(i).getUser_no();
			user_id = userInfoList.get(i).getUser_id();	
			sJoin_date = userInfoList.get(i).getJoin_date();
			
			String s2018Join_date = "2018-"+sJoin_date.substring(5, 10);
			String s2019Join_date = "2019-"+sJoin_date.substring(5, 10);			
			
			//월차인지 연차인지 체크한다.
			if( DateUtil.chkYear(sJoin_date, sBase_date) ) {		//1년 이상				
			//if( DateUtil.chkYear(sJoin_date, "2019-12-31") ) {		//1년 이상
				//System.out.println("입사일 : "+sJoin_date +" 체크날 : "+sBase_date+" : 년차로처리");
				
				nIn_365 = getCalVacation(sBase_date, sJoin_date);
								
				//nIn_365 = getCalVacation("2019-12-31", sJoin_date);
				userInfoList.get(i).setnYearset(nIn_365);		//통합데이터로 변경
				
			}else {		//1년 미만
				//System.out.println("입사일 : "+sJoin_date +" 체크날 : "+sBase_date+" : 월차로처리");				
				
				//2019년 11월 1일 기준으로는 1년 미만이지만 2019년 12월 31일 기준 1년이상인 사람은 2019년 연차를 별도로 계산해준다.
				if( DateUtil.chkYear(sJoin_date, "2019-12-31") ) {		//2019년 12월 31일 이전 입사자
					userInfoList.get(i).setnYearset(15);		//2019년 연차지정
				}else {
					//1년 이내 입사자는 월차로 계산한다. (2019년 입사자)
					nIn_365 = nCalMonthVacation(sJoin_date, sBase_date);		//입사일, 기준일로 월차계산
					//nIn_365 = nCalMonthVacation(sJoin_date, "2019-12-31");		//입사일, 기준일로 월차계산
					userInfoList.get(i).setnYearset(nIn_365);		//2019년 연차지정
				}				
				
			}
			
			//2018년 연차계산 (2017년 11월 1일 이전 입사자만 해당한다.)			
			
			if( !DateUtil.chkYear(sJoin_date, "2019-12-31") ){
				userInfoList.get(i).setN2018Yearset(0);
				userInfoList.get(i).setN2018Holiday(0);
				userInfoList.get(i).setN2018_vacation_work_use(0);
				userInfoList.get(i).setN2018Extraset(0);
				userInfoList.get(i).setN2018Overset(0);
			}else{
				
				if( DateUtil.chkYear(sJoin_date, "2018-12-31") ) {		//2018년 월차로 계산해야하는 사람					
					n2018Yearset = getCalVacation(s2018Join_date, sJoin_date);
					userInfoList.get(i).setN2018Yearset(n2018Yearset);
				}else {					
					n2018Yearset = calMonthday(s2019Join_date,sJoin_date);				
					userInfoList.get(i).setN2018Yearset(n2018Yearset);					
				}
				
				//DB에 등록된 연차대체휴가 수를 가져온다.
				paramMap.put("user_no", user_no);
				paramMap.put("sdate", s2018Join_date);
				paramMap.put("edate", s2019Join_date);				
				
				n2018holiday = sqlSession.selectOne("topVacationMapper.selectHoildayUseCount",paramMap);
				//n2018holiday = chk2019holiday(s2019Join_date,s2018Join_date);				
				userInfoList.get(i).setN2018Holiday(n2018holiday);
				
				//2018년 연차사용수
				paramMap.put("user_no", user_no);
				paramMap.put("sdate", s2018Join_date);
				paramMap.put("edate", s2019Join_date);
				
				n2018_vacation_work_use = sqlSession.selectOne("topVacationMapper.selectVacationUseCount",paramMap);
				userInfoList.get(i).setN2018_vacation_work_use(n2018_vacation_work_use);
				
				//2018년 잔여연차 계산
				n2018Extraset = n2018Yearset - n2018holiday - n2018_vacation_work_use;			
				userInfoList.get(i).setN2018Extraset(n2018Extraset);
				
				if( n2018Extraset < 0 ) {
					userInfoList.get(i).setN2018Overset(0);
					n2018Overset = 0;
				}else {
					userInfoList.get(i).setN2018Overset(n2018Extraset);
					n2018Overset = n2018Extraset;
				}			
				
			}
			
			//이월분으로 포함한 연차 셋팅
			nTotalYearset = nIn_365 + n2018Overset;
			userInfoList.get(i).setnTotalYearset(nTotalYearset);

			//DB에 등록된 2019년 공휴일 연차대체휴가 수를 가져온다.
			paramMap.put("user_no", user_no);
			paramMap.put("sdate", s2019Join_date);
			paramMap.put("edate", sBase_date);					//12월 말까지인 경우는 2019년 12월 31일로 입력				
			
			n2019holiday = sqlSession.selectOne("topVacationMapper.selectHoildayUseCount",paramMap);
			//n2019holiday = chk2019holiday(sBase_date,s2019Join_date);
			
			userInfoList.get(i).setnHoliday(n2019holiday);

			//2019년 현재까지 사용한 휴가수			
			paramMap.put("user_no", user_no);
			paramMap.put("sdate", s2019Join_date);
			paramMap.put("edate", sBase_date);
			
			Double vacationUseCnt = sqlSession.selectOne("topVacationMapper.selectVacationUseCount",paramMap);
			userInfoList.get(i).setN2019_vacation_work_use(vacationUseCnt);
			
			//실제 사용가능한 연차
			org_year_cal = nIn_365 - n2019holiday - vacationUseCnt;
			userInfoList.get(i).setOrg_year_cal(org_year_cal);
			
			//2019년 잔여연차
			n2019Extraset = nTotalYearset - n2019holiday - vacationUseCnt;
			
			if( n2019Extraset < 0 ) {
				n2019Extraset = 0;
			}
			
			userInfoList.get(i).setN2019Extraset(n2019Extraset);
		}	

		model.addAttribute("selectYear",selectYear);
		model.addAttribute("selectMonth",selectMonth);
		model.addAttribute("selectDay",selectDay);
		model.addAttribute("userInfoList", userInfoList);
		
		if("1".equals(sExceldown)){
			return "util_etc/vacation_test_excel";
		}else {
			return "util_etc/vacation_test";
		}
	}
	
	@RequestMapping(value = "VacationTestBk")
	public String getVacationTestBk(HttpServletRequest request, Model model){
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

		String sSel_year = request.getParameter("sSel_year");
		String sExceldown = request.getParameter("sExceldown");
		
		//신규 날짜 선택시 적용변수
		String selectYear = String.valueOf(paramMap.get("selectYear"));
		String selectMonth = String.valueOf(paramMap.get("selectMonth"));
		String selectDay = String.valueOf(paramMap.get("selectDay"));
		
		String sBase_date = "";
		
		if( "null".equals(selectYear) || "null".equals(selectMonth) || "null".equals(selectDay) ) {			
			sBase_date = DateUtil.getTodayString("yyyy-MM-dd");
			selectYear = sBase_date.substring(0, 4);
			selectMonth = sBase_date.substring(5, 7);
			selectDay = sBase_date.substring(8, 10);
		}else {			
			sBase_date = selectYear+"-"+DateUtil.getFormatMonth(selectMonth)+"-"+DateUtil.getFormatMonth(selectDay);
		}
		//System.out.println("sExceldown="+sExceldown);
		
		if(sSel_year == null) {
			//sSel_year = "2019";
			sSel_year = "2020";
		}
		
		paramMap.put("authLevel", "3");
		paramMap.put("srchYear", sSel_year);
		//근무중인 사용자 목록을 가져온다.		
		List<VacationInfoBean> userInfoList = sqlSession.selectList("topVacationMapper.testVacatioinMemberList",paramMap);
		
		//if("2019".equals(sSel_year)) {		//2019년
			//sBase_date = "2019-01-01";
		//}else {
			//sBase_date = "2020-01-01";
		//}
		
		//System.out.println("size="+userInfoList.size());
		
		int user_no = 0;
		String sJoin_date = "";		
		SimpleDateFormat sFormat = new SimpleDateFormat("yyyy-MM-dd",Locale.KOREA); 
		
		Date now = new Date();
		
		String sToday = "";			//기준일
		if("2019".equals(sSel_year)) {
			sToday = sFormat.format(now);
		}else {
			sToday = "2020-01-01";
		}
		
		//System.out.println("sToday="+sToday);
		
		double nYear = 0;		//연차
		double nIn_365 = 0;	//1년이내 입사자 체크 후 연차계산결과
		double nCalMonth = 0;	//월차발생일수
		int n2019holiday = 0;		//2019년 기본차감 연차수
		String user_id = "";
		String user_name = "";
		double nBaseYear = 0;
		String out_2019_month = "";			//1년 이상 입사자 임시 입사일자(2019년도 기준)
		double n2019_work = 0;
		
		double org_year_cal = 0;				//마이너스를 포함한 연차환산 변수
		double upper_year_cal = 0;			//마이너스인경우 0으로 처리한 연차환산 변수
		String work_date = "";					//2019년 사용한 휴가일수를 계산하기위한 날짜 변수
		int nWorkday = 0;						//입사일기준으로 1년 기준 근무일수 계산값
		
		for(int i=0; i < userInfoList.size(); i++) {
			user_no = userInfoList.get(i).getUser_no();
			user_id = userInfoList.get(i).getUser_id();	
			sJoin_date = userInfoList.get(i).getJoin_date();
			
			//1. 조회기준일 sToday 기준으로 1년이내 입사자인지 체크한다.
			nIn_365 = get365CheckVal(sToday,sJoin_date);
			
			//System.out.println(userInfoList.get(i).getUser_name()+" : "+nIn_365);			
			
			//0이면 1년 이내 입사자가 아님 
			if(nIn_365 == 0){
				userInfoList.get(i).setIn_365(0);
				//1년 이상 입사자 인경우 연차에 따른 기본 연차 발생변수 생성				
				nBaseYear = getCalVacation(sToday,sJoin_date);
				
				userInfoList.get(i).setnYearset(nBaseYear);		//통합데이터로 변경
				
				//2019년으로 변환된 근무일수 계산
				out_2019_month = "2019"+sJoin_date.substring(4);
				
				//1년이상입사자는 2019년으로 변경된 날짜를 사용한다.
				work_date = out_2019_month; 
				
				n2019_work = get365CheckVal(sToday,out_2019_month,nBaseYear);
				
				userInfoList.get(i).setnWorkset(n2019_work);		//통합데이터로 변경
				
				n2019holiday = chk2019holiday(sToday,out_2019_month);				

				userInfoList.get(i).setnHoliday(n2019holiday);		//통합데이터로 변경
				
				org_year_cal = n2019_work - n2019holiday;
				
				if( org_year_cal < 0) {
					upper_year_cal = 0;
				}else {
					upper_year_cal = org_year_cal;
				}
				
				nWorkday = nCalWorkday(sJoin_date, sToday);
				userInfoList.get(i).setnWorkday_year(nWorkday);				
				
			}else{		//1년이내 입사자
				//1년 이내 입사자는 월차로 계산한다.
				nIn_365 = nCalMonthVacation(sJoin_date, sToday);		//입사일, 기준일로 월차계산
				userInfoList.get(i).setnYearset(nIn_365);		//통합데이터로 변경
				
				//월차 발생일수 체크
				nCalMonth = calMonthday(sToday,sJoin_date);
				userInfoList.get(i).setnWorkset(nCalMonth);			//통합데이터로 변경
				
				//2019년 기본차감 연차계산
				n2019holiday = chk2019holiday(sToday,sJoin_date);
				userInfoList.get(i).setnHoliday(n2019holiday);			//통합데이터로 변경
								
				//1년이내 입사자는 입사일자를 기준으로 사용한다.
				work_date = sJoin_date;
				
				org_year_cal = nCalMonth - n2019holiday;
				if( org_year_cal < 0) {
					upper_year_cal = 0;
				}else {
					upper_year_cal = org_year_cal;
				}
				
				nWorkday = nCalWorkday(sJoin_date, sToday);
				userInfoList.get(i).setnWorkday_year(nWorkday);
				//System.out.println("user_name="+userInfoList.get(i).getUser_name()+" : "+n2019holiday+ " : "+sJoin_date+" ~ "+sToday);
			}			
			paramMap.put("user_no", user_no);
			paramMap.put("base_date", sBase_date);
			paramMap.put("annual_set", nYear);
			
			int nChk = sqlSession.selectOne("topVacationMapper.testVacationYearChk",paramMap);
			
			//연차 이월 ( 올해 마이너스 인 경우 0으로 처리 )			
			userInfoList.get(i).setUpper_year_cal(upper_year_cal);
			
			//연차 이월 ( 올해 마이너스 값대로 계산)
			userInfoList.get(i).setOrg_year_cal(org_year_cal);
			
			//2019년 현재까지 사용한 휴가수
			paramMap.put("userNo", user_no);
			paramMap.put("year", 2019);
			paramMap.put("work_date", work_date);
			Double vacationUseCnt = sqlSession.selectOne("topVacationMapper.selectVacationInworkUseCnt",paramMap);
			
			if (vacationUseCnt == null){
				vacationUseCnt = 0.0;
			}
			
			//2019년 전체사용 연차수
			Double UseCnt_2019 = sqlSession.selectOne("topVacationMapper.selectVacationTotalUseCnt",paramMap);
			if (UseCnt_2019 == null){
				UseCnt_2019 = 0.0;
			}						
			
			userInfoList.get(i).setN2019_vacation_use(UseCnt_2019);
			userInfoList.get(i).setN2019_vacation_work_use(vacationUseCnt);
			
			if( nChk == 1) {		//연차 업데이트
				//int nResult = sqlSession.update("topVacationMapper.testVacationYearUpdate",paramMap);				
				
			}else {					//기본연차정보 추가
				//sqlSession.insert("topVacationMapper.testVacationYearInsert",paramMap);
			}			
		}		
		
		//model.addAttribute("selYear",sSel_year);
		model.addAttribute("selectYear",selectYear);
		model.addAttribute("selectMonth",selectMonth);
		model.addAttribute("selectDay",selectDay);
		model.addAttribute("userInfoList", userInfoList);
		
		if("1".equals(sExceldown)){
			return "util_etc/vacation_test_excel";
		}else {
			return "util_etc/vacation_test";
		}
	}
	
	/**
	 * 1년 이상입사자 근무일수 기준 연차계산
	 * @param sBasicdate
	 * @param sJoindate
	 * @param nPoint
	 * @return
	 */
	
	public double get365CheckVal(String sBasicdate, String sJoindate, double nPoint) {
		double nRet = 0;
		double nCal = 0;
		
		nRet = DateUtil.getDiffDayCountNew(sJoindate, sBasicdate);		//입사일로부터 오늘까지 날짜를 계산한다.		
		
		nCal = nPoint * nRet / 365;
		nCal = Math.ceil(nCal);
		nRet = nCal;
		
		if(nRet < 0) {
			nRet = 0.0;
		}
		
		return nRet;		
	}
	
	
	/**
	 * 기준일, 입사일자를 넣어 1년이내 입사자인지 체크후 1년이내 입사자는 연차를 계산한다.
	 * 입사일자가 1년이 넘어가는 경우 0을 리턴한다.
	 * @return	연차발생일수, 입사일자가 1년이상인경우는 0이 리턴된다.
	 */
	public double get365CheckVal(String sBasicdate, String sJoindate) {
		double nRet = 0;
		double nCal = 0;
		
		nRet = DateUtil.getDiffDayCountNew(sJoindate, sBasicdate);		//입사일로부터 오늘까지 날짜를 계산한다.
		
		if( nRet < 365 ) {
			//1년 이내 입사자로 연차를 계산한다.
			//1년 이내 입사자로 월차로 계산한다.
			nCal = 12 * nRet / 365;
			nCal = Math.ceil(nCal);
			nRet = nCal;
		}else {
			nRet = 0;
		}
		
		return nRet;		
	}
	
	/**
	 * 입사일이 1년 이내 인 경우 2019년 차감되는 기본 연차사용일을 계산한다
	 * @param sBasicdate
	 * @param sJoindate
	 * @return
	 */
	public int chk2019holiday(String sBasicdate, String sJoindate) {
		int nRet = 0;
		boolean bFlag = false;
		
		//2018년 2019년 기념일 배열
		//String[] holidays = { "2019-01-01", "2019-02-04", "2019-02-05","2019-02-06", "2019-03-01", "2019-05-06", "2019-06-06",
				//"2019-08-15", "2019-09-12", "2019-09-13","2019-10-03","2019-10-09","2019-12-25"};
		
		//2018년 공휴일과 2018년 공휴일을 모두 넣는다.
		String[] holidays = { "2018-01-01", "2018-02-15", "2018-02-16", "2018-03-01", "2018-05-07", "2018-05-22", "2018-06-06", "2018-01-13",
				"2018-08-15", "2018-09-24", "2018-09-25", "2018-09-26", "2018-10-03", "2018-10-09", "2018-12-25",
				"2019-01-01", "2019-02-04", "2019-02-05","2019-02-06", "2019-03-01", "2019-05-06", "2019-06-06",
				"2019-08-15", "2019-09-12", "2019-09-13","2019-10-03","2019-10-09","2019-12-25"};
		
		for(int i=0; i < holidays.length; i++) {
			bFlag = DateUtil.getValidDate(sJoindate,sBasicdate,holidays[i]);
			if(bFlag) {
				nRet++;
			}
		}		
		return nRet;		
	}
	
	
	/**
	 * 월차 생성계산 (2017년 5월 31일 이후 입사자는 계산한다.
	 * @param sBasicdate 기준종료일
	 * @param sMonsdate 월차계산 시작일 ex) 2019-01-03
	 * @return
	 */
	public double calMonthday(String sBasicdate, String sMonsdate) {
		double monthRet = 0;
		
		monthRet = DateUtil.getDiffDayCountNew(sMonsdate, sBasicdate);		//월차계산 시작일로부터 기준일까지 날짜를 계산한다.
		
		//System.out.println("before_monthRet="+monthRet);
		
		monthRet = Math.floor(monthRet / 30);		//30으로 나누어 내림처리한다.
		
		//System.out.println("after_monthRet="+monthRet);
		
		if(monthRet == 12) {
			monthRet = 11;
		}
		
		return monthRet;		
	}	
	
	
	/*
	 * public static void main(String[] args) {
	 * 
	 * double test = 0.0; OnikuTest ot = new OnikuTest(); test =
	 * ot.calMonthday("2018-11-01", "2018-01-22");
	 * 
	 * System.out.println("test="+test);
	 * 
	 * }
	 */
	
	/*
	 * public static void main(String[] args) { String sBasicdate = "2020-01-01";
	 * String sJoindate = "2019-04-01";
	 * 
	 * OnikuTest Ot = new OnikuTest();
	 * 
	 * //double nRet = Ot.getCalVacation(sBasicdate, sJoindate); double nRet =
	 * Ot.calMonthday(sBasicdate, sJoindate);
	 * System.out.println(sJoindate+" : "+sBasicdate+" : "+nRet); }
	 */
	 
	
	/**
	 * 기존 연차 차감 함수
	 * @param sBasicdate
	 * @param sJoindate
	 * @return
	 */
	public double getCalVacation(String sBasicdate, String sJoindate){			//입사일자를 가지고 연차를 계산한다. 
		double nRet = 0;
		double nCal = 0;
		
		nRet = DateUtil.getDiffDayCountNew(sJoindate, sBasicdate);		//입사일로부터 오늘까지 날짜를 계산한다.
				
		if(nRet < 365) {		//1년 이내 입사자
			
			//15 * 근무일수 / 365 (올림)
			
			//2020년도기준
			nCal = 15 * nRet / 365;
			nCal = Math.ceil(nCal);
			
			//2019년기준
			/*
			 * nCal = nRet / 30; if(nCal >= 12) { nCal = 11; }else { nCal =
			 * Math.floor(nCal); }
			 */
		}else{						
			nCal = nRet / 365;		//1년 이상 입사자는 년으로 나눈다.
			
			if( nCal <= 3){
				nCal = 15;
			}else if( nCal > 3 && nCal <= 5) {
				nCal = 16;
			}else if( nCal > 5 && nCal <= 7) {
				nCal = 17;
			}else if( nCal > 7 && nCal <= 9) {
				nCal = 18;
			}else if( nCal > 9 && nCal <= 11) {
				nCal = 19;
			}else if( nCal > 11 && nCal <= 13) {
				nCal = 20;
			}else if( nCal > 13 && nCal <= 15) {
				nCal = 21;
			}else if( nCal > 15 && nCal <= 17) {
				nCal = 22;
			}else if( nCal > 17 && nCal <= 19) {
				nCal = 23;
			}else if( nCal > 19 && nCal <= 21) {
				nCal = 24;
			}else if( nCal > 21) {
				nCal = 25;
			}			
		}
		
		return nCal;		
	}
		
	@RequestMapping(value = "OnikuTest", method = RequestMethod.GET)
	public void getTest(HttpServletRequest request, Model model){
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
			
		List<Map<String, Object>> addrList = sqlSession.selectList("RptIssueMapper.selectRtpBody", paramMap);				
		System.out.println("nRet="+addrList.size());
		String sSuimNo = "";
		String addr1 = "";
		String addr2 = "";
		String uTemp = "";
		String pTemp = "";
		int i = 0;
		int updateChk = 0;
		int passChk = 0;
		File uFile = new File("C:\\Users\\HOME\\Desktop\\updateList.txt");
		File pFile = new File("C:\\Users\\HOME\\Desktop\\passList.txt");
		
		String sAccNo = "";		//사고번호
		String sTeam = "";		//팀이름
		String sUserNm = "";		//담당자이름		
		
		int nTemp = 0;
		
		for( Map<String, Object > params : addrList) {			
			sSuimNo = String.valueOf(params.get("suimRptNo"));
			addr1 = String.valueOf(params.get("investigateAddr1"));
			addr2 = String.valueOf(params.get("investigateAddr2"));
			sAccNo = String.valueOf(params.get("suimAcceptNo"));
			sTeam = String.valueOf(params.get("teamId"));
			sUserNm = String.valueOf(params.get("userNm"));
			if( addr2 == null || addr2.equals("") || addr2.equals("null")) {		//뒷주소가 없으면 통과
				passChk++;
				//System.out.println(i+" 통과 : "+sSuimNo+ " : "+addr1+" : "+addr2);
				pTemp = sSuimNo+ " : "+addr1+" : "+addr2+"\n";
				try {
					//FileWriter fw = new FileWriter(pFile,true);
					//fw.write(pTemp);
					//fw.close();
				} catch (Exception e) {
					//e.printStackTrace();
				}				
			}else if( !(addr2 == null || addr2.equals("") || addr2.equals("null")) ) {
				if( addr1 == null || addr1.equals("") ) {
					updateChk++;
					//System.out.println(i+" 업데이트 : "+sSuimNo+ " : "+addr1+" : "+addr2);
					//uTemp = sSuimNo+ " : "+addr1+" : "+addr2+"\n";
					uTemp = sAccNo+ " : "+sTeam+" : "+sUserNm+" : "+addr1+" : "+addr2+"\n";
					//업데이트 실행
					paramMap.put("update_addr", addr2);
        			paramMap.put("suim_rpt_no", sSuimNo);
        			//실제 업데이트 하지 않음
        			//nTemp = sqlSession.update("RptIssueMapper.updateRptBodyAddress",paramMap);
        			if( nTemp == 1) {
        				System.out.println(i+" 업데이트 : "+sSuimNo+ " : "+addr1+" : "+addr2);
        			}
        			
					try {
						FileWriter fw2 = new FileWriter(uFile,true);
						fw2.write(uTemp);
						fw2.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}else {
				System.out.println(i+" 예외항목 : "+sSuimNo+ " : "+addr1+" : "+addr2);
			}
			//System.out.println(i+" : "+sSuimNo+ " : "+addr1+" : "+addr2);
			i++;
		}		
		System.out.println("통과:"+passChk+" / "+"업데이트 : "+updateChk);
	}
	
	//입사일 기준 1년 미만 일 때만 계산
	public int nCalMonthVacation( String sJoindate, String sBasicdate) {
		int nRet = 0;
		
		//계산할 날짜의 월,일을 쪼갠다.
		String [] sJoinTemp = sJoindate.split("-");
		String [] sBaseTemp = sBasicdate.split("-");
		
		int nJoinYear = Integer.parseInt(sJoinTemp[0]);
		int nJoinMonth = Integer.parseInt(sJoinTemp[1]);
		int nJoinDay = Integer.parseInt(sJoinTemp[2]);
		
		int nBaseYear = Integer.parseInt(sBaseTemp[0]);
		int nBaseMonth = Integer.parseInt(sBaseTemp[1]);
		int nBaseDay = Integer.parseInt(sBaseTemp[2]);
		
		//년도차이가 발생하면 기준 월에 11를 다한다.
		if( nJoinYear < nBaseYear ) {
			nBaseMonth += 12;
		}
		
		//일자가 기준일보다 작은경우 (한달을 못채운경우 월차에서 1을 뺀다.)
		if( nBaseDay < nJoinDay) {
			nBaseMonth -= 1;
		}
		
		nRet = nBaseMonth - nJoinMonth;
		
		return nRet;
	}
	
	//입사일기준으로 몇일 근무했는지 계산
	public int nCalWorkday( String sJoindate, String sBasicdate) {
		int nRet = 0;
		
		//계산할 날짜의 월,일을 쪼갠다.		
		String [] sBaseTemp = sBasicdate.split("-");
		
		String sBaseYear = sBaseTemp[0];
		sJoindate = sBaseYear+sJoindate.substring(4);
		
		//System.out.println("sBasicdate="+sBasicdate);
		//System.out.println("sJoindate="+sJoindate);
		
		nRet = DateUtil.getDiffDayCountNew(sBasicdate, sJoindate);		//입사일로부터 오늘까지 날짜를 계산한다.
		
		return nRet;
	}
	
	
	 //public static void main(String[] args) {
		 
		// Double sTemp = 32.550;
		// String sRet = String.valueOf(Math.floor(sTemp*100)/100);
		 
		// System.out.println("sRet : "+sRet);
		
		 // String sJoindate = "2019-04-05";
		 // String sBasicdate = "2020-01-01";
	  
		//  OnikuTest ot = new OnikuTest();
	  
		//  int nCal = ot.nCalWorkday(sJoindate,sBasicdate);
	  
		//  System.out.println("nCal="+nCal);
	//}
	 
}
