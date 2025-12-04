package kr.co.toplac.sysadm.service;

import kr.co.toplac.util.cmm.DateUtil;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.List;
import java.util.Map;

/**
 * Created by kohyeonseok on 2017. 3. 9..
 */
@Service
public class RptPrivateDelService {
    private static final Logger logger = LoggerFactory.getLogger(RptPrivateDelService.class);

    @Autowired
    SqlSession sqlSession;

    /**
     * 종결 보고서 기간이 지난 데이터에서 개인정보관련 데이터를 삭제한다.
     */
    public void deletePrivateInfoBatch(){


        //==================================================
        // 1. 사고처리 과정표 삭제 (2019.12.13 삭제 제외 by top3009)
        //==================================================
        //sqlSession.delete("SuimSchedule.deleteTopRptCtrl");

        //==================================================
        // 2. 중간보고서 , 현장 보고서 처리 시작
        //==================================================
        // 중간 현장 보고서 이미지 리스트를 가져온다.
        List<Map<String, Object>> SiteInterimImgList = sqlSession.selectList("SuimSchedule.selectSiteInterimImgList");

        // 중간 현장 보고서 이미지 파일 하드에서 삭제한다.
        deleteRptFile(SiteInterimImgList);

        // 중간 현장 보고서 이미지 데이터 삭제
        sqlSession.delete("SuimSchedule.deleteTopRptSiteImg");

        // 중간 현장 보고서 첨부파일 리스트를 가져온다.
        List<Map<String, Object>> SiteInterimFileList = sqlSession.selectList("SuimSchedule.selectSiteInterimFileList");

        // 중간 현장 보고서 첨부 파일 하드에서 삭제한다.
        deleteRptFile(SiteInterimFileList);

        // 중간 현장 보고서 기본 데이터 삭제 (2020.02.18 삭제 제외 by top3009)
        //sqlSession.delete("SuimSchedule.deleteTopRptSiteInterim");

        //==================================================
        // 3. 현재진행사항 삭제
        //==================================================
        sqlSession.delete("SuimSchedule.deleteTopRptNow");

        //==================================================
        // 4. 나도한마디 삭제
        //==================================================
        //sqlSession.delete("SuimSchedule.deleteTopRptMemo");
        //
        //  - 2017.06.20 백다혜 사원 요청으로 인한 주석처리
        //  위임취소의 경우, 보험사 PRM에서 위임취소 처리가 되지 않은 경우도 있음
        //  따라서 나도한마디에 위임취소 사유 등이 적혀있는데 삭제가 되버리면 추적이 불가하여, 삭제하지 않도록 조치

        //==================================================
        // 5. 보고서 기본 첨부 파일 삭제
        //==================================================
        // 보고서 기본 첨부 파일 리스트를 가져온다.
        List<Map<String, Object>> topRptFileList = sqlSession.selectList("SuimSchedule.selectTopRptFileList");

        // 보고서 기본 첨부 파일 하드에서 삭제
        deleteRptFile(topRptFileList);

        // 보고서 기본 첨부 파일 데이터 삭제
        sqlSession.delete("SuimSchedule.deleteTopRptFile");

        //==================================================
        // 6. 인보험 보고서 삭제
        //==================================================
        //보고서 1 삭제
        sqlSession.delete("SuimSchedule.deleteTopRptPrint1_2");
        sqlSession.delete("SuimSchedule.deleteTopRptPrint1_5");
        sqlSession.delete("SuimSchedule.deleteTopRptPrint1_6_1");
        sqlSession.delete("SuimSchedule.deleteTopRptPrint1_6_2");
        sqlSession.delete("SuimSchedule.deleteTopRptPrint1_8");
        sqlSession.delete("SuimSchedule.deleteTopRptPrint1");

        //보고서 6 삭제
        sqlSession.delete("SuimSchedule.deleteTopRptPrint6");

        //보고서 9 삭제
        sqlSession.delete("SuimSchedule.deleteTopRptPrint9_5_1");
        sqlSession.delete("SuimSchedule.deleteTopRptPrint9_5_2");
        sqlSession.delete("SuimSchedule.deleteTopRptPrint9_6");
        sqlSession.delete("SuimSchedule.deleteTopRptPrint9_8");
        sqlSession.delete("SuimSchedule.deleteTopRptPrint9");

        //보고서 16 삭제
        sqlSession.delete("SuimSchedule.deleteTopRptPrint16_3");
        sqlSession.delete("SuimSchedule.deleteTopRptPrint16_4");
        sqlSession.delete("SuimSchedule.deleteTopRptPrint16");

        //보고서 17 삭제
        sqlSession.delete("SuimSchedule.deleteTopRptPrint17_2");
        sqlSession.delete("SuimSchedule.deleteTopRptPrint17_4");
        sqlSession.delete("SuimSchedule.deleteTopRptPrint17_7");
        sqlSession.delete("SuimSchedule.deleteTopRptPrint17_13");
        sqlSession.delete("SuimSchedule.deleteTopRptPrint17");

        //보고서 1700 삭제
        sqlSession.delete("SuimSchedule.deleteTopRptPrint1700_7");
        sqlSession.delete("SuimSchedule.deleteTopRptPrint1700");

        //==================================================
        // 7. 보고서 기본 개인정보 관련 데이터 갱신
        //==================================================
        //로그파일 입력
        sqlSession.insert("SuimSchedule.insertDailyScheduleLogSuim");
        
      	//삼성개인정보(5일 삭제>마스킹으로 변경. 20210520)
        sqlSession.update("SuimSchedule.updateTopRptHeadBodyPrivateInfo5SamSung");

        //보고서 개인정보 삭제 업데이트
        sqlSession.update("SuimSchedule.updateTopRptHeadBodyPrivateInfo");
        
        //삼성개인정보(180일 (6개월) 삭제 > 피해자외 이름정보 삭제. 20210520)
        sqlSession.update("SuimSchedule.updateTopRptHeadBodyPrivateInfo180SamSung");
        
        //보험사가 새마을(26) 또는 한화손해(12)인 경우 *로 처리한다. ( 롯데 손해보험 * 처리 20251124 추가 )
        sqlSession.update("SuimSchedule.updateTopRptHeadBodyPrivateInfo_asta");
        
        //보험사가 한화손해(12)인 경우 사고내용을 삭제한다. (보험사 요청사항 : 2023-09-15)
        //sqlSession.update("SuimSchedule.updateTopRptHeadBodyPrivateInfoHanWhaByAccidentInfo");

        //==================================================
        // 8. 삼성 적부 개인정보 관련 데이터 갱신
        //==================================================
        // 매달 24일 이후에만 실행한다.
        String day = DateUtil.getTodayString("dd");
        int dayInt = Integer.parseInt(day);

        if (dayInt > 24) {
            // 삼성적부 기본 첨부 파일 리스트를 가져온다.
            List<Map<String, Object>> topContFileList = sqlSession.selectList("SuimSchedule.selectTopContractFileList");

            // 삼성적부 기본 첨부 파일 하드에서 삭제
            deleteRptFile(topContFileList);

            // 삼성적부 기본 첨부 파일 데이터 삭제
            sqlSession.delete("SuimSchedule.deleteTopContractFile");
            
            // 삼성적부 문자발송 데이터 삭제 (20240610)
            sqlSession.delete("SuimSchedule.deleteTopContractSms");

            // 로그파일 입력
            sqlSession.insert("SuimSchedule.insertDailyScheduleLogJukbu");

            // 삼성적부 기본 보고서 개인정보 삭제
            sqlSession.update("SuimSchedule.updateTopContractPrivateInfo");

        }
                
        //로그인시 핸드폰 인증시간이 지난 데이터 삭제 by top3009
        sqlSession.delete("SuimSchedule.deleteMobileAuthSchedule");

    }

    /* 수임 lock flag 업데이트 */
    public void updateLockFlagBatch(){
        //수임 기본정보
        sqlSession.update("SuimSchedule.updateTopReptHeadLockFlag");

        //농작물
        sqlSession.update("SuimSchedule.updateTopPrimeBizReptHeadLockFlag");

        //삼성적부
        sqlSession.update("SuimSchedule.updateTopContractLockFlag");

        //KB적부
        sqlSession.update("SuimSchedule.updateTopSuitability10LockFlag");

        //한화적부
        sqlSession.update("SuimSchedule.updateTopSuitability12LockFlag");

        //흥국 적부
        sqlSession.update("SuimSchedule.updateTopSuitability17LockFlag");
    }


    private void deleteRptFile(List<Map<String, Object>> fileList) {

        String realSvrPath = "/home/hosting_users/toplac/www";

        for (int i = 0; i < fileList.size(); i++){

            Map<String, Object> item = fileList.get(i);
            String filePath = String.valueOf(item.get("filePath"));
            String folderPath = String.valueOf(item.get("folderPath"));

            String realFilePath = realSvrPath + filePath;
            String realFolderPath = realSvrPath + folderPath;


            //System.out.println("FILE_PATH : ["+realFilePath+"]");
            //System.out.println("FOLDER_PATH : ["+realFolderPath+"]");

            if(!folderPath.equals("")){
                File file = new File(realFilePath);
                File dir = new File(realFolderPath);
                file.delete();
                dir.delete();
            }
        }
    }
}
