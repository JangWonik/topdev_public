package kr.co.toplac.util.rpt;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.topmain.MainLeftSuimVO;
import kr.co.toplac.topstatistics.service.WorkloadService;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.WebUtil;

/*
*********************************************************
* Program ID	: MainLeftUtil
* Program Name	: 
* Description	: 
* Author		: 
* Date			: 
*********************************************************
*/
@Component
public class MainLeftUtil {

	private static final Logger logger = LoggerFactory.getLogger(MainLeftUtil.class);

	@Autowired
	WorkloadService workloadService;
	
	/*
	*********************************************************
	* Method ID		: 
	* Method Name	: 
	* Description	: 
	* Author		: 
	* Date			: 
	*********************************************************
	*/
	public void mainLeftMySuimState(SqlSession sqlSession, Model model, String user_no){
		
		logger.info("======= mainLeftMySuimState =======");
		
		MainLeftSuimVO mainLeftMySuimVO = new MainLeftSuimVO();

        ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = servletRequestAttribute.getRequest().getSession(true);

        String curTime = DateUtil.getTodayString("yyyyMMddHHmmss");
        String orgTime = (String)session.getAttribute("LEFT_STATISTC_PERSON_TIME");
        TopMbrBscVO topMbrBscVO = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();

        logger.info("DIF_DATETIME:["+DateUtil.getDiffSecondCount(orgTime, curTime)+"]["+topMbrBscVO.getUser_no()+"]");
        
        
        if (orgTime == null || DateUtil.getDiffSecondCount(orgTime, curTime) > 120){
/*
            mainLeftMySuimVO.setSuimTotalCnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suimTotalCnt", user_no));
            mainLeftMySuimVO.setSuimState0Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suimState0Cnt", user_no));
            mainLeftMySuimVO.setSiteCnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.siteCnt", user_no));
            mainLeftMySuimVO.setInterimCnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.interimCnt", user_no));
            mainLeftMySuimVO.setInterimCnt2((String)sqlSession.selectOne("MyMainLeftUtilMapper.interimCnt2", user_no));
            mainLeftMySuimVO.setSuimState1Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suimState1Cnt", user_no));
            mainLeftMySuimVO.setSuimState11Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suimState11Cnt", user_no));
            mainLeftMySuimVO.setaIACnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.aIACnt", user_no));
            mainLeftMySuimVO.setSuimState2Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suimState2Cnt", user_no));
            mainLeftMySuimVO.setSuimState3Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suimState3Cnt", user_no));

            mainLeftMySuimVO.setcHelpState0Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.cHelpState0Cnt", user_no));
            mainLeftMySuimVO.setcHelpState1Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.cHelpState1Cnt", user_no));
            mainLeftMySuimVO.setcHelpState2Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.cHelpState2Cnt", user_no));
            mainLeftMySuimVO.setcHelpState3Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.cHelpState3Cnt", user_no));

            mainLeftMySuimVO.setaHelpState0Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.aHelpState0Cnt", user_no));
            mainLeftMySuimVO.setaHelpState1Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.aHelpState1Cnt", user_no));
            mainLeftMySuimVO.setaHelpState2Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.aHelpState2Cnt", user_no));
            mainLeftMySuimVO.setaHelpState3Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.aHelpState3Cnt", user_no));

            mainLeftMySuimVO.setSuit10TotalCnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suit10TotalCnt", user_no));
            mainLeftMySuimVO.setSuit10State0Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suit10State0Cnt", user_no));
            mainLeftMySuimVO.setSuit10State1Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suit10State1Cnt", user_no));
            mainLeftMySuimVO.setSuit10State11Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suit10State11Cnt", user_no));
            mainLeftMySuimVO.setSuit10State2Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suit10State2Cnt", user_no));
            mainLeftMySuimVO.setSuit10State3Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suit10State3Cnt", user_no));
            mainLeftMySuimVO.setSuit12TotalCnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suit12TotalCnt", user_no));
            mainLeftMySuimVO.setSuit12State0Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suit12State0Cnt", user_no));
            mainLeftMySuimVO.setSuit12State1Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suit12State1Cnt", user_no));
            mainLeftMySuimVO.setSuit12State11Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suit12State11Cnt", user_no));
            mainLeftMySuimVO.setSuit12State2Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suit12State2Cnt", user_no));
            mainLeftMySuimVO.setSuit12State3Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suit12State3Cnt", user_no));
            mainLeftMySuimVO.setSuit17TotalCnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suit17TotalCnt", user_no));
            mainLeftMySuimVO.setSuit17State0Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suit17State0Cnt", user_no));
            mainLeftMySuimVO.setSuit17State1Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suit17State1Cnt", user_no));
            mainLeftMySuimVO.setSuit17State11Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suit17State11Cnt", user_no));
            mainLeftMySuimVO.setSuit17State2Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suit17State2Cnt", user_no));
            mainLeftMySuimVO.setSuit17State3Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suit17State3Cnt", user_no));
            mainLeftMySuimVO.setSuit18TotalCnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suit18TotalCnt", user_no));
            mainLeftMySuimVO.setSuit18State0Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suit18State0Cnt", user_no));
            mainLeftMySuimVO.setSuit18State1Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suit18State1Cnt", user_no));
            mainLeftMySuimVO.setSuit18State11Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suit18State11Cnt", user_no));
            mainLeftMySuimVO.setSuit18State2Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suit18State2Cnt", user_no));
            mainLeftMySuimVO.setSuit18State3Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.suit18State3Cnt", user_no));
            mainLeftMySuimVO.setPrimTotalCnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.primTotalCnt", user_no));
            mainLeftMySuimVO.setPrimState0Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.primState0Cnt", user_no));
            mainLeftMySuimVO.setPrimState1Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.primState1Cnt", user_no));
            mainLeftMySuimVO.setPrimState11Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.primState11Cnt", user_no));
            mainLeftMySuimVO.setPrimState2Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.primState2Cnt", user_no));
            mainLeftMySuimVO.setPrimState3Cnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.primState3Cnt", user_no));
*/

	       
        	Map<String,Object> workloadMap = workloadService.myWorkloadSimple(); 
        	
    		if (workloadMap != null){
    			String purposeWorkload = String.valueOf(workloadMap.get("purpose_workload"));
    			String calcWorkload = String.valueOf(workloadMap.get("calc_workload"));
    			String rankWorkload = String.valueOf(workloadMap.get("rank_workload"));
    			String workloadCnt = String.valueOf(workloadMap.get("workloadCnt"));
    			
    			mainLeftMySuimVO.setPurposeWorkload(purposeWorkload );
    			mainLeftMySuimVO.setCalcWorkload(calcWorkload );
    			mainLeftMySuimVO.setRankWorkload(rankWorkload );
    			mainLeftMySuimVO.setWorkloadCnt(workloadCnt );
    		}else{
    			mainLeftMySuimVO.setPurposeWorkload("0");
    			mainLeftMySuimVO.setCalcWorkload("0");
    			mainLeftMySuimVO.setRankWorkload("0");
    			mainLeftMySuimVO.setWorkloadCnt("0");
    		}
        	
    		
            //========================================================
            //  왼쪽 통계 새로 작성 2017-08-23
            //========================================================
//            StopWatch stopWatch = new StopWatch();
//            stopWatch.start("LEFT_PERSON_STATISTIC_TIME");

            Map<String, Object> resultMap = sqlSession.selectOne("MyMainLeftUtilMapper.selectLeftPersonStatistic", user_no);

//            stopWatch.stop();
//            System.out.println(stopWatch.prettyPrint());

            if (resultMap != null){
                mainLeftMySuimVO.setSuimTotalCnt(String.valueOf(resultMap.get("cnt01")));
                mainLeftMySuimVO.setSuimState0Cnt(String.valueOf(resultMap.get("cnt02")));

                mainLeftMySuimVO.setSiteCnt(String.valueOf(resultMap.get("cnt46")));
                mainLeftMySuimVO.setInterimCnt(String.valueOf(resultMap.get("cnt47")));
                mainLeftMySuimVO.setInterimCnt2(String.valueOf(resultMap.get("cnt48")));

                mainLeftMySuimVO.setSuimState1Cnt(String.valueOf(resultMap.get("cnt03")));
                mainLeftMySuimVO.setSuimState2Cnt(String.valueOf(resultMap.get("cnt04")));
                mainLeftMySuimVO.setSuimState3Cnt(String.valueOf(resultMap.get("cnt05")));
                mainLeftMySuimVO.setSuimState11Cnt(String.valueOf(resultMap.get("cnt06")));
                mainLeftMySuimVO.setaIACnt(String.valueOf(resultMap.get("cnt07")));

                mainLeftMySuimVO.setcHelpState0Cnt(String.valueOf(resultMap.get("cnt08")));
                mainLeftMySuimVO.setcHelpState1Cnt(String.valueOf(resultMap.get("cnt09")));
                mainLeftMySuimVO.setcHelpState2Cnt(String.valueOf(resultMap.get("cnt10")));
                mainLeftMySuimVO.setcHelpState3Cnt(String.valueOf(resultMap.get("cnt11")));

                mainLeftMySuimVO.setaHelpState0Cnt(String.valueOf(resultMap.get("cnt12")));
                mainLeftMySuimVO.setaHelpState1Cnt(String.valueOf(resultMap.get("cnt13")));
                mainLeftMySuimVO.setaHelpState2Cnt(String.valueOf(resultMap.get("cnt14")));
                mainLeftMySuimVO.setaHelpState3Cnt(String.valueOf(resultMap.get("cnt15")));

                mainLeftMySuimVO.setSuit10TotalCnt(String.valueOf(resultMap.get("cnt16")));
                mainLeftMySuimVO.setSuit10State0Cnt(String.valueOf(resultMap.get("cnt17")));
                mainLeftMySuimVO.setSuit10State1Cnt(String.valueOf(resultMap.get("cnt18")));
                mainLeftMySuimVO.setSuit10State2Cnt(String.valueOf(resultMap.get("cnt19")));
                mainLeftMySuimVO.setSuit10State3Cnt(String.valueOf(resultMap.get("cnt20")));
                mainLeftMySuimVO.setSuit10State11Cnt(String.valueOf(resultMap.get("cnt21")));

                mainLeftMySuimVO.setSuit12TotalCnt(String.valueOf(resultMap.get("cnt22")));
                mainLeftMySuimVO.setSuit12State0Cnt(String.valueOf(resultMap.get("cnt23")));
                mainLeftMySuimVO.setSuit12State1Cnt(String.valueOf(resultMap.get("cnt24")));
                mainLeftMySuimVO.setSuit12State2Cnt(String.valueOf(resultMap.get("cnt25")));
                mainLeftMySuimVO.setSuit12State3Cnt(String.valueOf(resultMap.get("cnt26")));
                mainLeftMySuimVO.setSuit12State11Cnt(String.valueOf(resultMap.get("cnt27")));

                mainLeftMySuimVO.setSuit17TotalCnt(String.valueOf(resultMap.get("cnt28")));
                mainLeftMySuimVO.setSuit17State0Cnt(String.valueOf(resultMap.get("cnt29")));
                mainLeftMySuimVO.setSuit17State1Cnt(String.valueOf(resultMap.get("cnt30")));
                mainLeftMySuimVO.setSuit17State2Cnt(String.valueOf(resultMap.get("cnt31")));
                mainLeftMySuimVO.setSuit17State3Cnt(String.valueOf(resultMap.get("cnt32")));
                mainLeftMySuimVO.setSuit17State11Cnt(String.valueOf(resultMap.get("cnt33")));

                mainLeftMySuimVO.setSuit18TotalCnt(String.valueOf(resultMap.get("cnt34")));
                mainLeftMySuimVO.setSuit18State0Cnt(String.valueOf(resultMap.get("cnt35")));
                mainLeftMySuimVO.setSuit18State1Cnt(String.valueOf(resultMap.get("cnt36")));
                mainLeftMySuimVO.setSuit18State2Cnt(String.valueOf(resultMap.get("cnt37")));
                mainLeftMySuimVO.setSuit18State3Cnt(String.valueOf(resultMap.get("cnt38")));
                mainLeftMySuimVO.setSuit18State11Cnt(String.valueOf(resultMap.get("cnt39")));

                mainLeftMySuimVO.setPrimTotalCnt(String.valueOf(resultMap.get("cnt40")));
                mainLeftMySuimVO.setPrimState0Cnt(String.valueOf(resultMap.get("cnt41")));
                mainLeftMySuimVO.setPrimState1Cnt(String.valueOf(resultMap.get("cnt42")));
                mainLeftMySuimVO.setPrimState2Cnt(String.valueOf(resultMap.get("cnt43")));
                mainLeftMySuimVO.setPrimState3Cnt(String.valueOf(resultMap.get("cnt44")));
                mainLeftMySuimVO.setPrimState11Cnt(String.valueOf(resultMap.get("cnt45")));
                
                mainLeftMySuimVO.setDutyCostAppCnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.dutyCostAppCnt"));
                mainLeftMySuimVO.setDutyCostDepCnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.dutyCostDepCnt"));
                mainLeftMySuimVO.setRptAlarmCnt(String.valueOf(resultMap.get("cnt49")));
                
                mainLeftMySuimVO.setRptMbrchgOutCnt( (String)sqlSession.selectOne("MyMainLeftUtilMapper.rptMbrChgOutCnt",user_no) );
                mainLeftMySuimVO.setRptMbrchgInCnt( (String)sqlSession.selectOne("MyMainLeftUtilMapper.rptMbrChgInCnt",user_no) );
                mainLeftMySuimVO.setDutyCostDepCnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.dutyCostDepCnt"));
                
                mainLeftMySuimVO.setLectureRoomCnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.getLectureRoomState0Cnt"));
                
                mainLeftMySuimVO.setSite3DayCnt(String.valueOf(resultMap.get("cnt50")));
                mainLeftMySuimVO.setSiteOverCnt(String.valueOf(resultMap.get("cnt51")));
                mainLeftMySuimVO.setInterim5DayCnt(String.valueOf(resultMap.get("cnt52")));
                mainLeftMySuimVO.setInterimOverCnt(String.valueOf(resultMap.get("cnt53")));
                
                
            }else{

                mainLeftMySuimVO.setSuimTotalCnt("0");
                mainLeftMySuimVO.setSuimState0Cnt("0");

                mainLeftMySuimVO.setSiteCnt("0");
                mainLeftMySuimVO.setInterimCnt("0");
                mainLeftMySuimVO.setInterimCnt2("0");

                mainLeftMySuimVO.setSuimState1Cnt("0");
                mainLeftMySuimVO.setSuimState2Cnt("0");
                mainLeftMySuimVO.setSuimState3Cnt("0");
                mainLeftMySuimVO.setSuimState11Cnt("0");
                mainLeftMySuimVO.setaIACnt("0");

                mainLeftMySuimVO.setcHelpState0Cnt("0");
                mainLeftMySuimVO.setcHelpState1Cnt("0");
                mainLeftMySuimVO.setcHelpState2Cnt("0");
                mainLeftMySuimVO.setcHelpState3Cnt("0");

                mainLeftMySuimVO.setaHelpState0Cnt("0");
                mainLeftMySuimVO.setaHelpState1Cnt("0");
                mainLeftMySuimVO.setaHelpState2Cnt("0");
                mainLeftMySuimVO.setaHelpState3Cnt("0");

                mainLeftMySuimVO.setSuit10TotalCnt("0");
                mainLeftMySuimVO.setSuit10State0Cnt("0");
                mainLeftMySuimVO.setSuit10State1Cnt("0");
                mainLeftMySuimVO.setSuit10State2Cnt("0");
                mainLeftMySuimVO.setSuit10State3Cnt("0");
                mainLeftMySuimVO.setSuit10State11Cnt("0");

                mainLeftMySuimVO.setSuit12TotalCnt("0");
                mainLeftMySuimVO.setSuit12State0Cnt("0");
                mainLeftMySuimVO.setSuit12State1Cnt("0");
                mainLeftMySuimVO.setSuit12State2Cnt("0");
                mainLeftMySuimVO.setSuit12State3Cnt("0");
                mainLeftMySuimVO.setSuit12State11Cnt("0");

                mainLeftMySuimVO.setSuit17TotalCnt("0");
                mainLeftMySuimVO.setSuit17State0Cnt("0");
                mainLeftMySuimVO.setSuit17State1Cnt("0");
                mainLeftMySuimVO.setSuit17State2Cnt("0");
                mainLeftMySuimVO.setSuit17State3Cnt("0");
                mainLeftMySuimVO.setSuit17State11Cnt("0");

                mainLeftMySuimVO.setSuit18TotalCnt("0");
                mainLeftMySuimVO.setSuit18State0Cnt("0");
                mainLeftMySuimVO.setSuit18State1Cnt("0");
                mainLeftMySuimVO.setSuit18State2Cnt("0");
                mainLeftMySuimVO.setSuit18State3Cnt("0");
                mainLeftMySuimVO.setSuit18State11Cnt("0");

                mainLeftMySuimVO.setPrimTotalCnt("0");
                mainLeftMySuimVO.setPrimState0Cnt("0");
                mainLeftMySuimVO.setPrimState1Cnt("0");
                mainLeftMySuimVO.setPrimState2Cnt("0");
                mainLeftMySuimVO.setPrimState3Cnt("0");
                mainLeftMySuimVO.setPrimState11Cnt("0");
                
                mainLeftMySuimVO.setDutyCostAppCnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.dutyCostAppCnt"));
                mainLeftMySuimVO.setDutyCostDepCnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.dutyCostDepCnt"));
                
                mainLeftMySuimVO.setRptAlarmCnt("0");
                
                mainLeftMySuimVO.setRptMbrchgOutCnt( (String)sqlSession.selectOne("MyMainLeftUtilMapper.rptMbrChgOutCnt",user_no) );
                mainLeftMySuimVO.setRptMbrchgInCnt( (String)sqlSession.selectOne("MyMainLeftUtilMapper.rptMbrChgInCnt",user_no) );
                
                mainLeftMySuimVO.setLectureRoomCnt((String)sqlSession.selectOne("MyMainLeftUtilMapper.getLectureRoomState0Cnt"));
                
                mainLeftMySuimVO.setSite3DayCnt("0");
                mainLeftMySuimVO.setSiteOverCnt("0");
                mainLeftMySuimVO.setInterim5DayCnt("0");
                mainLeftMySuimVO.setInterimOverCnt("0");
            }

            session.setAttribute("LEFT_STATISTC_PERSON_TIME", curTime);
            session.setAttribute("LEFT_PERSON_SUIM_VO", mainLeftMySuimVO);

            logger.info("LEFT_PERSON_SUIM_VO LOAD["+topMbrBscVO.getUser_no()+"]");

        }else{
            mainLeftMySuimVO = (MainLeftSuimVO)session.getAttribute("LEFT_PERSON_SUIM_VO");
            logger.info("LEFT_PERSON_SUIM_VO SESSION["+topMbrBscVO.getUser_no()+"]");
        }
        
        //현장보고서 권한 추가
        TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
        TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
        
        String team_type = mbrVo.getTeam_type();
        
        String sitePopAuth = "0";
        String mbr_pms_38 = mbrAuthVo.getMbr_pms_38().toString();
        String work_type_cd = mbrVo.getWork_type_cd().toString();
		
		if("4".equals(team_type)) {			//인보험은 현장보고서 팝업사용 안함
			sitePopAuth = "0";
		}else{										//물보험 및 본사만 사용여부를 체크한다.
			if( "1".equals(mbr_pms_38) || "2".equals(work_type_cd)) {			//현장보고서 팝업 전체 사용권한 또는 1종 부문장										
				sitePopAuth = "1";				//총괄화면권한					
			}else if( "14".equals(work_type_cd) ){			//1종 센터장				 
				sitePopAuth = "2";				//센터장화면					
			}else{														//1종 팀장이거나 개인조회 대상자
				//담당 관리 부서체크 박스 권한이 있는 경우 1종 팀장권한과 같이 처리한다.
				String sAuthTeam23 = "";

				sAuthTeam23 = sqlSession.selectOne("TopLoginMapper.selectTeamListAuth23", user_no);
				
				if(!"".equals(sAuthTeam23) && !"|".equals(sAuthTeam23)) {		//팀조회권한이있는경우만 처리한다.
					sitePopAuth = "3";
				}else{								//담당관리부서 체크박스권한이 없는경우 >> 개인조사자
					//최근 30일내 수임건이 있는지 체크 (수임건이 없으면 팝업을 사용하지 않는다.)
					int nSuim30 = sqlSession.selectOne("TopLoginMapper.selectSuimCnt30", user_no);
					if( nSuim30 > 0) {
						sitePopAuth = "4";			//현장보고서 개인 팝업 사용하는 경우
					}else {
						sitePopAuth = "0";			//최근 30일내 수임건이 없으면 팝업을 사용하지 않는다.
					}						
				}
			}				
		}
        
        model.addAttribute("sitePopAuth",sitePopAuth);

        model.addAttribute("mainLeftMySuimVO", mainLeftMySuimVO);
        
	}//end of mainLeftMySuimState
	
	
	public void mainLeftTmSuimState(SqlSession sqlSession, Model model, String team_id, String user_no){
		logger.info("======= mainLeftTmSuimState =======");
        MainLeftSuimVO mainLeftTmSuimVO = new MainLeftSuimVO();
        
        Map<String, String> paramMap = new HashMap<>();

        ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = servletRequestAttribute.getRequest().getSession(true);

        String curTime = DateUtil.getTodayString("yyyyMMddHHmmss");

        String orgTime = (String)session.getAttribute("LEFT_STATISTC_TEAM_TIME");

        logger.info("DIF_DATETIME:["+DateUtil.getDiffSecondCount(orgTime, curTime)+"]");
        
        //신규휴가결재 건수 확인 추가 by oniku        
        TopMbrAuthVO mbrAuthVo = sqlSession.selectOne("TopLoginMapper.getAuth", user_no);

        //최종 확인 권한을 가지고 있는 경우
        String sChk = mbrAuthVo.getMbr_pms_28_v();
                
        paramMap.put("team_id", team_id);
        paramMap.put("user_no", user_no);        
        
        int vacationLastChkCnt = 0;				//최종확인해야하는 휴가건수
        int vacationApprovalCnt = 0;				//접속자가 결재해야하는 휴가건수
        
        int leaveLastChkCnt = 0;				//최종확인해야하는 휴직건수
        int leaveApprovalCnt = 0;				//접속자가 결재해야하는 휴직건수
        
        //최종 확인 권한이 있는 사람만 갯수를 구한다
        if("1".equals(sChk)){
        	//휴가 결재요청 건수 구한다. 1차 결재 완료로 변경
        	//vacationLastChkCnt = sqlSession.selectOne("topVacationMapper.selectApprovalListLastCnt", paramMap);
        	//휴직 결재요청 건수 구한다.
        	leaveLastChkCnt = sqlSession.selectOne("topVacationMapper.selectApprovalListLeaveLastCnt", paramMap);        	
        }
        //최종휴가대상건수 1차결재 완료로 변경
        //mainLeftTmSuimVO.setVacationLastChkCnt(String.valueOf(vacationLastChkCnt));
      	//최종휴직대상건수
        mainLeftTmSuimVO.setLeaveLastChkCnt(String.valueOf(leaveLastChkCnt));
        
        //결재휴가대상건수
        vacationApprovalCnt = sqlSession.selectOne("topVacationMapper.selectApprovalListCnt", paramMap);
        mainLeftTmSuimVO.setVacationApprovalCnt(String.valueOf(vacationApprovalCnt));
      	//결재휴직대상건수
        leaveApprovalCnt = sqlSession.selectOne("topVacationMapper.selectApprovalListLeaveCnt", paramMap);
        mainLeftTmSuimVO.setLeaveApprovalCnt(String.valueOf(leaveApprovalCnt));
        
        //전산 권한 결재대기 건수 시작
        String approval_auth = mbrAuthVo.getMbr_pms_30().toString();
        
        int approval_cnt = 0;
        
        if( "0".equals(approval_auth) ) {
        	mainLeftTmSuimVO.setApprovalCnt("0");
        }else{
        	paramMap.put("approval_auth", approval_auth);
        	approval_cnt = sqlSession.selectOne("BoardHelpDeskMapper.selectApprovalResultCnt", paramMap);
        	mainLeftTmSuimVO.setApprovalCnt(String.valueOf(approval_cnt));
        }
        //전산 권한 결재대기 건수 끝
        

        if (orgTime == null || DateUtil.getDiffSecondCount(orgTime, curTime) > 120){

            /*
            String LeftTmSuimStateTeamId = sqlSession.selectOne("TmMainLeftUtilMapper.getAdmin23TeamId",user_no);

            String rptCancelTeamAuth = sqlSession.selectOne("TmMainLeftUtilMapper.getAdmin7TeamId",user_no);


            List<String> teamId = new ArrayList<String>();
            if (!LeftTmSuimStateTeamId.equals("") && !LeftTmSuimStateTeamId.equals(null)){
                if (LeftTmSuimStateTeamId.charAt(0) == '|'){
                    LeftTmSuimStateTeamId = LeftTmSuimStateTeamId.substring(1);
                }
            }
            String[] tmpTeam = LeftTmSuimStateTeamId.split("\\|");
            teamId.add(team_id);
            for(int i=0; i < tmpTeam.length ; i++){
                teamId.add(tmpTeam[i]);
            }

            List<String> rptCancelTeamId = new ArrayList<String>();
            if (!rptCancelTeamAuth.equals("") && !rptCancelTeamAuth.equals(null)){
                if (rptCancelTeamAuth.charAt(0) == '|'){
                    rptCancelTeamAuth = rptCancelTeamAuth.substring(1);
                }
            }
            String[] tmpTeam2 = rptCancelTeamAuth.split("\\|");
            rptCancelTeamId.add(team_id);
            for(int i=0; i < tmpTeam2.length ; i++){
                rptCancelTeamId.add(tmpTeam2[i]);
            }


            mainLeftTmSuimVO.setSuimTotalCnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suimTotalCnt", team_id));
            mainLeftTmSuimVO.setSuimState0Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suimState0Cnt", team_id));
            mainLeftTmSuimVO.setSiteCnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.siteCnt", team_id));
            mainLeftTmSuimVO.setInterimCnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.interimCnt", team_id));
            mainLeftTmSuimVO.setSuimState1Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suimState1Cnt", team_id));
            mainLeftTmSuimVO.setSuimState11Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suimState11Cnt", team_id));
            mainLeftTmSuimVO.setaIACnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.aIACnt", team_id));
            mainLeftTmSuimVO.setaIACntState1AllTm((String)sqlSession.selectOne("TmMainLeftUtilMapper.aIACntState1AllTm", team_id));
            mainLeftTmSuimVO.setaIACntState11AllTm((String)sqlSession.selectOne("TmMainLeftUtilMapper.aIACntState11AllTm", team_id));
            mainLeftTmSuimVO.setaIACntAllTm((String)sqlSession.selectOne("TmMainLeftUtilMapper.aIACntAllTm", team_id));
            mainLeftTmSuimVO.setSuimState2Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suimState2Cnt", team_id));
            mainLeftTmSuimVO.setSuimState3Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suimState3Cnt", team_id));
            mainLeftTmSuimVO.setSuimNoUserCnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suimNoUserCnt", team_id));
            mainLeftTmSuimVO.setcHelpState0Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.cHelpState0Cnt", team_id));
            mainLeftTmSuimVO.setcHelpState1Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.cHelpState1Cnt", team_id));
            mainLeftTmSuimVO.setcHelpState2Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.cHelpState2Cnt", team_id));
            mainLeftTmSuimVO.setcHelpState3Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.cHelpState3Cnt", team_id));
            mainLeftTmSuimVO.setaHelpState0Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.aHelpState0Cnt", team_id));
            mainLeftTmSuimVO.setaHelpState1Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.aHelpState1Cnt", team_id));
            mainLeftTmSuimVO.setaHelpState2Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.aHelpState2Cnt", team_id));
            mainLeftTmSuimVO.setaHelpState3Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.aHelpState3Cnt", team_id));

            mainLeftTmSuimVO.setSuit10TotalCnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suit10TotalCnt", team_id));
            mainLeftTmSuimVO.setSuit10State0Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suit10State0Cnt", team_id));
            mainLeftTmSuimVO.setSuit10State1Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suit10State1Cnt", team_id));
            mainLeftTmSuimVO.setSuit10State11Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suit10State11Cnt", team_id));
            mainLeftTmSuimVO.setSuit10State2Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suit10State2Cnt", team_id));
            mainLeftTmSuimVO.setSuit10State3Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suit10State3Cnt", team_id));
            mainLeftTmSuimVO.setSuit12TotalCnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suit12TotalCnt", team_id));
            mainLeftTmSuimVO.setSuit12State0Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suit12State0Cnt", team_id));
            mainLeftTmSuimVO.setSuit12State1Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suit12State1Cnt", team_id));
            mainLeftTmSuimVO.setSuit12State11Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suit12State11Cnt", team_id));
            mainLeftTmSuimVO.setSuit12State2Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suit12State2Cnt", team_id));
            mainLeftTmSuimVO.setSuit12State3Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suit12State3Cnt", team_id));
            mainLeftTmSuimVO.setSuit17TotalCnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suit17TotalCnt", team_id));
            mainLeftTmSuimVO.setSuit17State0Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suit17State0Cnt", team_id));
            mainLeftTmSuimVO.setSuit17State1Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suit17State1Cnt", team_id));
            mainLeftTmSuimVO.setSuit17State11Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suit17State11Cnt", team_id));
            mainLeftTmSuimVO.setSuit17State2Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suit17State2Cnt", team_id));
            mainLeftTmSuimVO.setSuit17State3Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suit17State3Cnt", team_id));
            mainLeftTmSuimVO.setSuit18TotalCnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suit18TotalCnt", team_id));
            mainLeftTmSuimVO.setSuit18State0Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suit18State0Cnt", team_id));
            mainLeftTmSuimVO.setSuit18State1Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suit18State1Cnt", team_id));
            mainLeftTmSuimVO.setSuit18State11Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suit18State11Cnt", team_id));
            mainLeftTmSuimVO.setSuit18State2Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suit18State2Cnt", team_id));
            mainLeftTmSuimVO.setSuit18State3Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.suit18State3Cnt", team_id));

            mainLeftTmSuimVO.setSuit10State1CntAllTm((String)sqlSession.selectOne("TmMainLeftUtilMapper.suit10State1CntAllTm", team_id));
            mainLeftTmSuimVO.setSuit12State1CntAllTm((String)sqlSession.selectOne("TmMainLeftUtilMapper.suit12State1CntAllTm", team_id));
            mainLeftTmSuimVO.setSuit17State1CntAllTm((String)sqlSession.selectOne("TmMainLeftUtilMapper.suit17State1CntAllTm", team_id));
            mainLeftTmSuimVO.setSuit18State1CntAllTm((String)sqlSession.selectOne("TmMainLeftUtilMapper.suit18State1CntAllTm", team_id));

            mainLeftTmSuimVO.setPrimTotalCnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.primTotalCnt", team_id));
            mainLeftTmSuimVO.setPrimState0Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.primState0Cnt", team_id));
            mainLeftTmSuimVO.setPrimState1Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.primState1Cnt", team_id));
            mainLeftTmSuimVO.setPrimState11Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.primState11Cnt", team_id));
            mainLeftTmSuimVO.setPrimState2Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.primState2Cnt", team_id));
            mainLeftTmSuimVO.setPrimState3Cnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.primState3Cnt", team_id));

            mainLeftTmSuimVO.setPtnr19State0CntAllTm((String)sqlSession.selectOne("TmMainLeftUtilMapper.ptnr19State0CntAllTm", team_id));
            mainLeftTmSuimVO.setPtnr19State1CntAllTm((String)sqlSession.selectOne("TmMainLeftUtilMapper.ptnr19State1CntAllTm", team_id));
            mainLeftTmSuimVO.setPtnr27State0CntAllTm((String)sqlSession.selectOne("TmMainLeftUtilMapper.ptnr27State0CntAllTm", team_id));
            mainLeftTmSuimVO.setPtnr27State1CntAllTm((String)sqlSession.selectOne("TmMainLeftUtilMapper.ptnr27State1CntAllTm", team_id));
            mainLeftTmSuimVO.setPtnr26State0CntAllTm((String)sqlSession.selectOne("TmMainLeftUtilMapper.ptnr26State0CntAllTm", team_id));
            mainLeftTmSuimVO.setPtnr26State1CntAllTm((String)sqlSession.selectOne("TmMainLeftUtilMapper.ptnr26State1CntAllTm", team_id));
            mainLeftTmSuimVO.setPtnr29State0CntAllTm((String)sqlSession.selectOne("TmMainLeftUtilMapper.ptnr29State0CntAllTm", team_id));
            mainLeftTmSuimVO.setPtnr29State1CntAllTm((String)sqlSession.selectOne("TmMainLeftUtilMapper.ptnr29State1CntAllTm", team_id));

            mainLeftTmSuimVO.setReqHelpDesk((String)sqlSession.selectOne("TmMainLeftUtilMapper.reqHelpDesk", team_id));
            mainLeftTmSuimVO.setReqEmpCert((String)sqlSession.selectOne("TmMainLeftUtilMapper.reqEmpCert", team_id));
            mainLeftTmSuimVO.setDayoffStateCnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.dayoffStateCnt", team_id));
            mainLeftTmSuimVO.setDayoffStateMainCnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.dayoffStateMainCnt"));
            mainLeftTmSuimVO.setDayoffFinalCnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.dayoffFinalCnt"));

            mainLeftTmSuimVO.setRptCancelReqCnt((String)sqlSession.selectOne("TmMainLeftUtilMapper.rptCancelCnt", rptCancelTeamId));
            */

            //========================================================
            //  왼쪽 통계 새로 작성 2017-08-23
            //========================================================
            
            //paramMap.put("team_id", team_id);
            //paramMap.put("user_no", user_no);

//            StopWatch stopWatch = new StopWatch();
//            stopWatch.start("LEFT_TEAM_STATISTIC_TIME");
            
            TopMbrBscVO mbrVo= (TopMbrBscVO) session.getAttribute("mbrVo_Session");
            paramMap.put("workType", mbrVo.getWork_type_cd());
            Map<String,Object> vacationMap = sqlSession.selectOne("TmMainLeftUtilMapper.selectLeftVacationCnt", paramMap);
            if (vacationMap != null){
            	mainLeftTmSuimVO.setVacationTeamCnt(String.valueOf(vacationMap.get("vacationTeamCnt")));
            	mainLeftTmSuimVO.setVacation1Cnt(String.valueOf(vacationMap.get("vacation1Cnt")));
            	mainLeftTmSuimVO.setVacation4Cnt(String.valueOf(vacationMap.get("vacation4Cnt")));
            }else{
            	mainLeftTmSuimVO.setVacationTeamCnt("0");
            	mainLeftTmSuimVO.setVacation1Cnt("0");
            	mainLeftTmSuimVO.setVacation4Cnt("0");
            }            

            Map<String, Object> resultMap = sqlSession.selectOne("TmMainLeftUtilMapper.selectLeftTeamStatistic", paramMap);

//            stopWatch.stop();
//            System.out.println(stopWatch.prettyPrint());

            if (resultMap != null){
                mainLeftTmSuimVO.setSuimTotalCnt(String.valueOf(resultMap.get("cnt01")));
                mainLeftTmSuimVO.setSuimState0Cnt(String.valueOf(resultMap.get("cnt02")));
                mainLeftTmSuimVO.setSuimState1Cnt(String.valueOf(resultMap.get("cnt03")));
                mainLeftTmSuimVO.setSuimState2Cnt(String.valueOf(resultMap.get("cnt04")));
                mainLeftTmSuimVO.setSuimState3Cnt(String.valueOf(resultMap.get("cnt05")));
                mainLeftTmSuimVO.setSuimState11Cnt(String.valueOf(resultMap.get("cnt06")));
                mainLeftTmSuimVO.setaIACnt(String.valueOf(resultMap.get("cnt07")));
                mainLeftTmSuimVO.setSuimNoUserCnt(String.valueOf(resultMap.get("cnt08")));
                mainLeftTmSuimVO.setaIACntState1AllTm(String.valueOf(resultMap.get("cnt09")));
                mainLeftTmSuimVO.setaIACntState11AllTm(String.valueOf(resultMap.get("cnt10")));
                mainLeftTmSuimVO.setaIACntAllTm(String.valueOf(resultMap.get("cnt11")));
                mainLeftTmSuimVO.setSiteCnt(String.valueOf(resultMap.get("cnt12")));
                mainLeftTmSuimVO.setInterimCnt(String.valueOf(resultMap.get("cnt13")));

                mainLeftTmSuimVO.setcHelpState0Cnt(String.valueOf(resultMap.get("cnt14")));
                mainLeftTmSuimVO.setcHelpState1Cnt(String.valueOf(resultMap.get("cnt15")));
                mainLeftTmSuimVO.setcHelpState2Cnt(String.valueOf(resultMap.get("cnt16")));
                mainLeftTmSuimVO.setcHelpState3Cnt(String.valueOf(resultMap.get("cnt17")));
                mainLeftTmSuimVO.setaHelpState0Cnt(String.valueOf(resultMap.get("cnt18")));
                mainLeftTmSuimVO.setaHelpState1Cnt(String.valueOf(resultMap.get("cnt19")));
                mainLeftTmSuimVO.setaHelpState2Cnt(String.valueOf(resultMap.get("cnt20")));
                mainLeftTmSuimVO.setaHelpState3Cnt(String.valueOf(resultMap.get("cnt21")));

                mainLeftTmSuimVO.setSuit10TotalCnt(String.valueOf(resultMap.get("cnt22")));
                mainLeftTmSuimVO.setSuit10State0Cnt(String.valueOf(resultMap.get("cnt23")));
                mainLeftTmSuimVO.setSuit10State1Cnt(String.valueOf(resultMap.get("cnt24")));
                mainLeftTmSuimVO.setSuit10State2Cnt(String.valueOf(resultMap.get("cnt25")));
                mainLeftTmSuimVO.setSuit10State3Cnt(String.valueOf(resultMap.get("cnt26")));
                mainLeftTmSuimVO.setSuit10State11Cnt(String.valueOf(resultMap.get("cnt27")));


                mainLeftTmSuimVO.setSuit12TotalCnt(String.valueOf(resultMap.get("cnt28")));
                mainLeftTmSuimVO.setSuit12State0Cnt(String.valueOf(resultMap.get("cnt29")));
                mainLeftTmSuimVO.setSuit12State1Cnt(String.valueOf(resultMap.get("cnt30")));
                mainLeftTmSuimVO.setSuit12State2Cnt(String.valueOf(resultMap.get("cnt31")));
                mainLeftTmSuimVO.setSuit12State3Cnt(String.valueOf(resultMap.get("cnt32")));
                mainLeftTmSuimVO.setSuit12State11Cnt(String.valueOf(resultMap.get("cnt33")));

                mainLeftTmSuimVO.setSuit17TotalCnt(String.valueOf(resultMap.get("cnt34")));
                mainLeftTmSuimVO.setSuit17State0Cnt(String.valueOf(resultMap.get("cnt35")));
                mainLeftTmSuimVO.setSuit17State1Cnt(String.valueOf(resultMap.get("cnt36")));
                mainLeftTmSuimVO.setSuit17State2Cnt(String.valueOf(resultMap.get("cnt37")));
                mainLeftTmSuimVO.setSuit17State3Cnt(String.valueOf(resultMap.get("cnt38")));
                mainLeftTmSuimVO.setSuit17State11Cnt(String.valueOf(resultMap.get("cnt39")));

                mainLeftTmSuimVO.setSuit18TotalCnt(String.valueOf(resultMap.get("cnt40")));
                mainLeftTmSuimVO.setSuit18State0Cnt(String.valueOf(resultMap.get("cnt41")));
                mainLeftTmSuimVO.setSuit18State1Cnt(String.valueOf(resultMap.get("cnt42")));
                mainLeftTmSuimVO.setSuit18State2Cnt(String.valueOf(resultMap.get("cnt43")));
                mainLeftTmSuimVO.setSuit18State3Cnt(String.valueOf(resultMap.get("cnt44")));
                mainLeftTmSuimVO.setSuit18State11Cnt(String.valueOf(resultMap.get("cnt45")));

                mainLeftTmSuimVO.setSuit10State1CntAllTm(String.valueOf(resultMap.get("cnt46")));
                mainLeftTmSuimVO.setSuit12State1CntAllTm(String.valueOf(resultMap.get("cnt47")));
                mainLeftTmSuimVO.setSuit17State1CntAllTm(String.valueOf(resultMap.get("cnt48")));
                mainLeftTmSuimVO.setSuit18State1CntAllTm(String.valueOf(resultMap.get("cnt49")));

                mainLeftTmSuimVO.setPrimTotalCnt(String.valueOf(resultMap.get("cnt50")));
                mainLeftTmSuimVO.setPrimState0Cnt(String.valueOf(resultMap.get("cnt51")));
                mainLeftTmSuimVO.setPrimState1Cnt(String.valueOf(resultMap.get("cnt52")));
                mainLeftTmSuimVO.setPrimState2Cnt(String.valueOf(resultMap.get("cnt53")));
                mainLeftTmSuimVO.setPrimState3Cnt(String.valueOf(resultMap.get("cnt54")));
                mainLeftTmSuimVO.setPrimState11Cnt(String.valueOf(resultMap.get("cnt55")));

                mainLeftTmSuimVO.setPtnr19State0CntAllTm(String.valueOf(resultMap.get("cnt56")));
                mainLeftTmSuimVO.setPtnr19State1CntAllTm(String.valueOf(resultMap.get("cnt57")));
                mainLeftTmSuimVO.setPtnr26State0CntAllTm(String.valueOf(resultMap.get("cnt58")));
                mainLeftTmSuimVO.setPtnr26State1CntAllTm(String.valueOf(resultMap.get("cnt59")));
                mainLeftTmSuimVO.setPtnr27State0CntAllTm(String.valueOf(resultMap.get("cnt60")));
                mainLeftTmSuimVO.setPtnr27State1CntAllTm(String.valueOf(resultMap.get("cnt61")));
                mainLeftTmSuimVO.setPtnr29State0CntAllTm(String.valueOf(resultMap.get("cnt62")));
                mainLeftTmSuimVO.setPtnr29State1CntAllTm(String.valueOf(resultMap.get("cnt63")));

                mainLeftTmSuimVO.setReqHelpDesk(String.valueOf(resultMap.get("cnt64")));
                mainLeftTmSuimVO.setReqEmpCert(String.valueOf(resultMap.get("cnt65")));

                mainLeftTmSuimVO.setDayoffStateCnt(String.valueOf(resultMap.get("cnt66")));
                mainLeftTmSuimVO.setDayoffStateMainCnt(String.valueOf(resultMap.get("cnt67")));
                mainLeftTmSuimVO.setDayoffFinalCnt(String.valueOf(resultMap.get("cnt68")));

                mainLeftTmSuimVO.setRptCancelReqCnt(String.valueOf(resultMap.get("cnt69")));
                
                mainLeftTmSuimVO.setRptAlarmCnt(String.valueOf(resultMap.get("cnt70")));
                
                mainLeftTmSuimVO.setSite3DayCnt(String.valueOf(resultMap.get("cnt71")));
                mainLeftTmSuimVO.setSiteOverCnt(String.valueOf(resultMap.get("cnt72")));
                mainLeftTmSuimVO.setInterim5DayCnt(String.valueOf(resultMap.get("cnt73")));
                mainLeftTmSuimVO.setInterimOverCnt(String.valueOf(resultMap.get("cnt74")));                
                
                mainLeftTmSuimVO.setQuickApprovalCnt(String.valueOf(resultMap.get("cnt75")));		//빠른결재건수 by top3009
                mainLeftTmSuimVO.setSiteApprovalCnt(String.valueOf(resultMap.get("cnt76")));
                mainLeftTmSuimVO.setRptCancelApproval(String.valueOf(resultMap.get("cnt77")));
                
            }else{            	

                mainLeftTmSuimVO.setSuimTotalCnt("0");
                mainLeftTmSuimVO.setSuimState0Cnt("0");
                mainLeftTmSuimVO.setSuimState1Cnt("0");
                mainLeftTmSuimVO.setSuimState2Cnt("0");
                mainLeftTmSuimVO.setSuimState3Cnt("0");
                mainLeftTmSuimVO.setSuimState11Cnt("0");
                mainLeftTmSuimVO.setaIACnt("0");
                mainLeftTmSuimVO.setSuimNoUserCnt("0");
                mainLeftTmSuimVO.setaIACntState1AllTm("0");
                mainLeftTmSuimVO.setaIACntState11AllTm("0");
                mainLeftTmSuimVO.setaIACntAllTm("0");
                mainLeftTmSuimVO.setSiteCnt("0");
                mainLeftTmSuimVO.setInterimCnt("0");

                mainLeftTmSuimVO.setcHelpState0Cnt("0");
                mainLeftTmSuimVO.setcHelpState1Cnt("0");
                mainLeftTmSuimVO.setcHelpState2Cnt("0");
                mainLeftTmSuimVO.setcHelpState3Cnt("0");
                mainLeftTmSuimVO.setaHelpState0Cnt("0");
                mainLeftTmSuimVO.setaHelpState1Cnt("0");
                mainLeftTmSuimVO.setaHelpState2Cnt("0");
                mainLeftTmSuimVO.setaHelpState3Cnt("0");

                mainLeftTmSuimVO.setSuit10TotalCnt("0");
                mainLeftTmSuimVO.setSuit10State0Cnt("0");
                mainLeftTmSuimVO.setSuit10State1Cnt("0");
                mainLeftTmSuimVO.setSuit10State2Cnt("0");
                mainLeftTmSuimVO.setSuit10State3Cnt("0");
                mainLeftTmSuimVO.setSuit10State11Cnt("0");


                mainLeftTmSuimVO.setSuit12TotalCnt("0");
                mainLeftTmSuimVO.setSuit12State0Cnt("0");
                mainLeftTmSuimVO.setSuit12State1Cnt("0");
                mainLeftTmSuimVO.setSuit12State2Cnt("0");
                mainLeftTmSuimVO.setSuit12State3Cnt("0");
                mainLeftTmSuimVO.setSuit12State11Cnt("0");

                mainLeftTmSuimVO.setSuit17TotalCnt("0");
                mainLeftTmSuimVO.setSuit17State0Cnt("0");
                mainLeftTmSuimVO.setSuit17State1Cnt("0");
                mainLeftTmSuimVO.setSuit17State2Cnt("0");
                mainLeftTmSuimVO.setSuit17State3Cnt("0");
                mainLeftTmSuimVO.setSuit17State11Cnt("0");

                mainLeftTmSuimVO.setSuit18TotalCnt("0");
                mainLeftTmSuimVO.setSuit18State0Cnt("0");
                mainLeftTmSuimVO.setSuit18State1Cnt("0");
                mainLeftTmSuimVO.setSuit18State2Cnt("0");
                mainLeftTmSuimVO.setSuit18State3Cnt("0");
                mainLeftTmSuimVO.setSuit18State11Cnt("0");

                mainLeftTmSuimVO.setSuit10State1CntAllTm("0");
                mainLeftTmSuimVO.setSuit12State1CntAllTm("0");
                mainLeftTmSuimVO.setSuit17State1CntAllTm("0");
                mainLeftTmSuimVO.setSuit18State1CntAllTm("0");

                mainLeftTmSuimVO.setPrimTotalCnt("0");
                mainLeftTmSuimVO.setPrimState0Cnt("0");
                mainLeftTmSuimVO.setPrimState1Cnt("0");
                mainLeftTmSuimVO.setPrimState2Cnt("0");
                mainLeftTmSuimVO.setPrimState3Cnt("0");
                mainLeftTmSuimVO.setPrimState11Cnt("0");

                mainLeftTmSuimVO.setPtnr19State0CntAllTm("0");
                mainLeftTmSuimVO.setPtnr19State1CntAllTm("0");
                mainLeftTmSuimVO.setPtnr26State0CntAllTm("0");
                mainLeftTmSuimVO.setPtnr26State1CntAllTm("0");
                mainLeftTmSuimVO.setPtnr27State0CntAllTm("0");
                mainLeftTmSuimVO.setPtnr27State1CntAllTm("0");
                mainLeftTmSuimVO.setPtnr29State0CntAllTm("0");
                mainLeftTmSuimVO.setPtnr29State1CntAllTm("0");

                mainLeftTmSuimVO.setReqHelpDesk("0");
                mainLeftTmSuimVO.setReqEmpCert("0");

                mainLeftTmSuimVO.setDayoffStateCnt("0");
                mainLeftTmSuimVO.setDayoffStateMainCnt("0");
                mainLeftTmSuimVO.setDayoffFinalCnt("0");

                mainLeftTmSuimVO.setRptCancelReqCnt("0");
                mainLeftTmSuimVO.setRptAlarmCnt("0");
                
                mainLeftTmSuimVO.setSite3DayCnt("0");
                mainLeftTmSuimVO.setSiteOverCnt("0");
                mainLeftTmSuimVO.setInterim5DayCnt("0");
                mainLeftTmSuimVO.setInterimOverCnt("0");
                
                mainLeftTmSuimVO.setQuickApprovalCnt("0");		//빠른결재건수 by top3009
                mainLeftTmSuimVO.setRptCancelApproval("0");	//위임취소결재대상건 by top3009 (20240725)
            }
                        
            //센터장은 재계산을 한다.
            if("14".equals(mbrVo.getWork_type_cd())) {    			
    			int nTempCenterCnt = 0;
    			int nTempCenterNoUserCnt = 0;
    			
    			//팀 상신건 재계산
    			nTempCenterCnt = sqlSession.selectOne("TopLoginMapper.getCenterIdByState1Cnt", mbrVo.getCenter_team_id());
    			mainLeftTmSuimVO.setSuimState1Cnt(String.valueOf(nTempCenterCnt));
    			
    			//팀 미배당건 재계산
    			nTempCenterNoUserCnt = sqlSession.selectOne("TopLoginMapper.getCenterIdByNoUserCnt", mbrVo.getCenter_team_id());    			
    			mainLeftTmSuimVO.setSuimNoUserCnt(String.valueOf(nTempCenterNoUserCnt));
    		}

            /* 겸직 목록 추출*/
    		List<Map<String, Object>> subJobList = sqlSession.selectList("TopMbrDtlMapper.selectSubjobList",paramMap);
    		
    		int subCnt = 0;
    		int subTotalCnt = 0;
    		
    		for(int i=0; i < subJobList.size(); i++) {    			
    			paramMap.put("sub_team_id", subJobList.get(i).get("teamIdMain").toString());
    			subCnt = sqlSession.selectOne("TmMainLeftUtilMapper.selectSubTeamApprovalCnt", paramMap);
    			subTotalCnt += subCnt;    			
    		}
    		
    		//겸직 부서 결재요청건 셋팅
    		mainLeftTmSuimVO.setSubTeamApprovalCnt(subTotalCnt);
    		
            session.setAttribute("LEFT_STATISTC_TEAM_TIME", curTime);
            session.setAttribute("LEFT_TEAM_SUIM_VO", mainLeftTmSuimVO);

            logger.info("LEFT_TEAM_SUIM_VO LOAD");

        }else{
            mainLeftTmSuimVO = (MainLeftSuimVO)session.getAttribute("LEFT_TEAM_SUIM_VO");
            logger.info("LEFT_TEAM_SUIM_VO SESSION");

        }
        
        try {
        
	        //현장보고서 겸직자 결재팀 체크 시작. 20211228  by top3009
	        String sLsApprovalSite = "";			//겸직자 결재팀
	        sLsApprovalSite = sqlSession.selectOne("PopMbrAuth2DtlMapper.getLsApprovalSite", user_no);        
	        sLsApprovalSite = WebUtil.makeInsqlString(sLsApprovalSite,"\\|");
	        
	        if( !"".equals(sLsApprovalSite) ) {			//체크된 팀이 있는 경우만 처리한다.        	
	        	int nApprovalSiteCnt = 0;
	        	paramMap.put("approval_team", sLsApprovalSite);
	        	nApprovalSiteCnt = sqlSession.selectOne("TmMainLeftUtilMapper.selectApprovalSiteCnt",paramMap);
	        	
	        	mainLeftTmSuimVO.setSiteApprovalCnt(String.valueOf(nApprovalSiteCnt));
	        	//겸직자용 결재 메뉴로 센터 팝업창으로 보여야 함. 20211228 by top3009
	        	model.addAttribute("approvalSiteExcept", "1");        	
	        }
	        //현장보고서 겸직자 결재팀 체크 끝
        
        	//교육결재요청건 확인 시작
            int nLectureApproval = 0;        
            int nLectureApprovalChk = Integer.parseInt(mbrAuthVo.getMbr_pms_36().toString());        
            
            if( nLectureApprovalChk > 0 ) {
            	paramMap.put("ap_state", "10");
            	nLectureApproval = sqlSession.selectOne("LectureMapper.selectLectureApprovalListCnt",paramMap);
            }        
            mainLeftTmSuimVO.setnLectureApproval(nLectureApproval);
            
            //교육결재요청건 확인 끝
		} catch (Exception e) {
			logger.error("mainLeftTmSuimState Error : nLectureApproval is Null OR nApprovalSiteCnt is Null");
			e.printStackTrace();
		}finally {
			model.addAttribute("mainLeftTmSuimVO", mainLeftTmSuimVO);
		}
        
        //model.addAttribute("mainLeftTmSuimVO", mainLeftTmSuimVO);

	}//end of mainLeftTmSuimState

}//end of class
