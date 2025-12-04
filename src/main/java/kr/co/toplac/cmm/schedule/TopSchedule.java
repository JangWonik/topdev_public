package kr.co.toplac.cmm.schedule;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.toplac.sysadm.service.RptPrivateDelService;
import kr.co.toplac.topstatistics.service.BonusDailyMemberQuarterService;
import kr.co.toplac.topstatistics.service.BonusDailyService;
import kr.co.toplac.topstatistics.service.BonusDailyTeamQuarterService;
import kr.co.toplac.topstatistics.service.BonusDailyTeamService;
import kr.co.toplac.topstatistics.service.BonusDailyYearService;
import kr.co.toplac.topstatistics.service.NilinkSyncService;
import kr.co.toplac.topstatistics.service.SiteDailyService;
import kr.co.toplac.topstatistics.service.StatisticsBasicService;
import kr.co.toplac.topstatistics.service.TeamCountService;
import kr.co.toplac.topstatistics.service.VacationCalService;
import kr.co.toplac.topstatistics.service.WorkloadService;

/**
 * Created by kohyeonseok on 2017. 3. 8..
 */
@Service
public class TopSchedule {

    @Autowired
    RptPrivateDelService service;

    @Autowired
    WorkloadService workloadService;
    
    @Autowired
    StatisticsBasicService statisticsBasicService;
    
    @Autowired
    VacationCalService vacationUpdateService;
    
    @Autowired
    SiteDailyService siteDailyService;
    
    @Autowired
    BonusDailyMemberQuarterService bonusDailyMemberQuarterService;
    
    @Autowired
    BonusDailyService bonusDailyService;
    
    @Autowired
    BonusDailyYearService bonusDailyYearService;
    
    @Autowired
    BonusDailyTeamService bonusDailyTeamService;
    
    @Autowired
    BonusDailyTeamQuarterService bonusDailyTeamQuarterService;
    
    @Autowired
    NilinkSyncService nilinkSyncService;
        
    @Autowired
    TeamCountService teamCountService;
    
    public void deleteReportPersonalInfo() throws Exception {

        service.deletePrivateInfoBatch();

        System.out.println("SCHEDULE_BATCH COMPLETE!");

    }
 
    public void updateLockFlag() throws Exception {

        service.updateLockFlagBatch();

        System.out.println("SCHEDULE_BATCH UPDATE LOCK_FLAG COMPLETE!");

    }
    
    public void insertWorkloadRank() throws Exception {

    	workloadService.insertWorkloadDaily();

        System.out.println("SCHEDULE_BATCH INSERT WORKLOAD_DAYILY COMPLETE!");

    }
    
    public void insertRptPendingCnt() throws Exception {

    	statisticsBasicService.insertRptPendingCntMonthly();

        System.out.println("SCHEDULE_BATCH INSERT RPT_PENDING_CNT COMPLETE!");

    }
    
    public void updateVacationJob() throws Exception{
    	
    	//연차발생 스케줄링 서비스 by top3009
    	vacationUpdateService.updateVacationAnnual();
    	System.out.println("SCHEDULE_BATCH UPDATE 1Team VACATION COMPLETE!");
    	    	
    	vacationUpdateService.updateVacationAnnual4();
    	System.out.println("SCHEDULE_BATCH UPDATE 4Team VACATION COMPLETE!");
    	
    	//업데이트 내역 email 발송 (개발기에 업데이트시 주석처리해야함) 
    	//vacationUpdateService.sendEmailToVacation();
		 
    }
    
    public void bonusDailyMemberQuarterJob() throws Exception{
    	//관리자 기준 소속 직원 실적 계산 스케줄러 by top3009
    	bonusDailyMemberQuarterService.syncProcess(); 	
    	System.out.println("BONUS_DAILY_MEMBER_QUARTER COMPLETE!");
    }
    
    public void bonusDailyYearJob() throws Exception{
    	//성과급 개인 연간 스케줄러 by top3009
    	bonusDailyYearService.syncProcess();    	
    	System.out.println("BONUS_DAILY_YEAR COMPLETE!");
    }
    
    public void bonusDailyJob() throws Exception{
    	//성과급 관련 스케줄러 by top3009
    	bonusDailyService.syncProcess();    	
    	System.out.println("BONUS_DAILY COMPLETE!");
    }
    
    public void bonusDailyTeamJob() throws Exception{
    	//관리자 성과급 관련 스케줄러 by top3009
    	bonusDailyTeamService.syncProcess(); 	
    	System.out.println("BONUS_DAILY_TEAM COMPLETE!");
    }
    
    public void bonusDailyTeamQuarterJob() throws Exception{
    	//관리자 성과급 관련 분기기준 스케줄러 by top3009
    	bonusDailyTeamQuarterService.syncProcess(); 	
    	System.out.println("BONUS_DAILY_TEAM_QUARTER COMPLETE!");
    }
    
    public void siteDailyJob() throws Exception{
    	//현장보고서 통계자료 적재 스케줄러 by top3009
    	siteDailyService.syncProcess();    	
    	System.out.println("SITE_DAILY COMPLETE!");
    }
    
    public void syncNilinkJob() throws Exception{
    	//nilink sync 스케줄러 by top3009
    	nilinkSyncService.syncProcess();    	
    	System.out.println("NILINK SYNC COMPLETE!");    	
    	
    }
    
    public void updateTeamCountJob() throws Exception{
    	//1일 팀인원수 카운트 서비스 by top3009
    	teamCountService.updateTeamCnt();
    	
    	System.out.println("SCHEDULE_BATCH UPDATE TEAMCOUNT COMPLETE!");     	
    }
    
    public void updateTeamEquipmentJob() throws Exception{
    	//일별 팀 장비 갯수 수집 서비스 by top3009
    	teamCountService.updateTeamEquipmentCnt();
    	
    	System.out.println("SCHEDULE_BATCH UPDATE TEAM EQUIPMENT COUNT COMPLETE!");     	
    }
    
}
