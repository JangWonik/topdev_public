package kr.co.toplac.topstatistics.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.toplac.util.cmm.DateUtil;

@Service
public class SiteDailyService {
	

	private static final Logger logger = LoggerFactory.getLogger(WorkloadService.class);

    @Autowired
    SqlSession sqlSession;
    
    public void syncProcess() {
    	//logger.info("SiteDailyService Start");
    	
    	int nMchk = 0;		//개인 통계 데이터 등록여부 확인
    	int nTchk = 0;			//팀 통계 데이터 등록여부 확인
    	
    	//오늘날짜 셋팅
    	String sToday = DateUtil.getTodayString("yyyy-MM-dd");		//오늘 날짜    	
    	
    	nMchk = sqlSession.selectOne("SuimSchedule.selectTopSiteMemberChk", sToday);
    	
    	if( nMchk == 0 ) {			//해당일에 등록된 현장보고서 개인정보가 없으면 등록한다.
    		List<Map<String,Object>> memberList = sqlSession.selectList("SuimSchedule.selectTopSiteMemberListAll");		//개인 통계    		
    		sqlSession.insert("SuimSchedule.insertTopSiteMember", memberList);
    		
    	}
    	
    	nTchk = sqlSession.selectOne("SuimSchedule.selectTopSiteTeamChk", sToday);
    	
    	if( nTchk == 0 ) {
    		List<Map<String,Object>> teamList = sqlSession.selectList("SuimSchedule.selectTopSiteTeamListAll");				//팀통계
    		sqlSession.insert("SuimSchedule.insertTopSiteTeam", teamList);
    	}
    	
    	Date nowDate = new Date(System.currentTimeMillis());
    	
    	logger.info("SiteDailyService End : "+nowDate);
    }
}