package kr.co.toplac.topstatistics.service;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StatisticsBasicService {
    private static final Logger logger = LoggerFactory.getLogger(WorkloadService.class);

    @Autowired
    SqlSession sqlSession;
    
    
    /**
     * New 기본통계의 미결 건수 카운팅을 위한 배치
     */
    public void insertRptPendingCntMonthly(){
    	sqlSession.insert("StatisticBasic.insertSuimPendingCnt");
    	sqlSession.insert("StatisticBasic.insertPrimBizPendingCnt");
    	 
    	
    }
}
