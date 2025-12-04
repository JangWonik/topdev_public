package kr.co.toplac.topstatistics.service;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.filefilter.TrueFileFilter;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import kr.co.toplac.util.cmm.DateUtil;

@Service
public class NilinkSyncService {
	private static final Logger logger = LoggerFactory.getLogger(WorkloadService.class);

    @Autowired
    SqlSession sqlSession;
    
    /**
     * 동기화 서비스 (1일 1회 동기화 전날의 녹음 파일을 DB에 동기화 한다.)     * 
     */
    
    public void syncProcess() {
    	logger.info("============ NilinkSync Start =========");
    	
    	//폴더 기본 저장 경로
    	
    	String sFullPath = "";
    	
    	//운영경로
    	String sPath = "/home/hosting_users/toplac/www/nilink";
    	
    	//테스트경로    	
    	//String sPath = "D:\\home"+File.separator+"hosting_users"+File.separator+"toplac"+File.separator+"www"+File.separator+"nilink";
    	
    	//하루전 백업데이터 경로의 파일을 읽어온다.
    	String sFolder = DateUtil.addDate(DateUtil.getTodayString(), -1);
    	//날짜 수동입력
    	//String sFolder = "20200824";
    	
    	sFullPath = sPath+File.separator+sFolder;
    	
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
    	
    	//해당 폴더 아래 파일 목록을 불러온다.
    	for (File info : FileUtils.listFiles(new File(sFullPath), TrueFileFilter.INSTANCE, TrueFileFilter.INSTANCE)) {
    		orgFile = info.getName();
    		orgFullName = info.getAbsolutePath();
    		orgFileSize = info.length();    		
    		
    		nCnt = sqlSession.selectOne("TopMbrDtlMapper.countNilinkRecordFileName", orgFile);
    		
    		//로컬 마이그래이션시 사용
    		//orgFullName = orgFullName.replace("D:\\home\\hosting_users\\toplac\\www\\nilink\\20221213\\", "/home/hosting_users/toplac/www/nilink/20221213/");

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
        		tmpMap.put("full_path", orgFullName);
        		tmpMap.put("file_size", orgFileSize);        		
        		
        		sqlSession.insert("TopMbrDtlMapper.insertNilinkRecord", tmpMap);
        		
        		addCnt++;
    		}
    		
        }
    	logger.info("insert Data : "+addCnt);
    	logger.info("============ NilinkSync End =========");
    }
}
