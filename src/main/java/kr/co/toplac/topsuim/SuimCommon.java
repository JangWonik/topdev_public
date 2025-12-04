package kr.co.toplac.topsuim;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.topteam.TopMbrBscVO;



/*
*********************************************************
* Program ID	: SuimCommon
* Program Name	: SuimCommon
* Description	: 수임 공통 모듈 분리
* Author		: lds
* Date			: 2017.08.02
*********************************************************
*/

public class SuimCommon {
	
	private static final Logger logger = LoggerFactory.getLogger(SuimCommon.class);
	
	/*
	 * ***************************************
	 * Method ID   : insSuimRptLog
	 * Method Name : insSuimRptLog
	 * Description : 일반수임 로그 삽입
	 * Author : 임대성
	 * Date : 170802
	 * ***************************************
	 * */
    public void insSuimRptLog(SqlSession sqlSession, String action, String suim_rpt_no){
    	logger.info("insSuimRptLog");
    	
    	//세션정보
    	TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
    	
    	/*로그 남기기 시작*/
    	Map<String,Object> paramMap = new HashMap<String,Object>();
    	paramMap.put("suim_rpt_no", suim_rpt_no);
    	paramMap.put("user_no_session", mbrVo.getUser_no());
    	
    	SuimRptCompositeVO suimVoAfterUdt = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);
    	
    	SuimLogVO logVo = new SuimLogVO();
    	
    	logVo.setSuimRptNo(suim_rpt_no);
    	logVo.setSuimRptType1(suimVoAfterUdt.getSuimRptType1());
    	
    	if(suimVoAfterUdt.getSuimRptType1().equals("14")){
    		logVo.setSpeedType(suimVoAfterUdt.getSpeedType());			
    	}else{
    		logVo.setSpeedType("0");
    	}
    	
    	/*ip 얻기 시작*/
    	HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
    	
    	String ip = req.getHeader("X-FORWARDED-FOR");
    	
    	if (ip == null){
    		ip = req.getRemoteAddr(); 
    	}
    	/*ip 얻기 끝*/
    	logVo.setSuimRptType1Close12(suimVoAfterUdt.getSuimRptType1Close12());
    	logVo.setSuimRptType1Close34(suimVoAfterUdt.getSuimRptType1Close34());
    	logVo.setMoralFlag(suimVoAfterUdt.getMoralFlag());
    	logVo.setRegDate(suimVoAfterUdt.getReg_date());
    	logVo.setSuimCancelDate(suimVoAfterUdt.getSuimCancelDate());
    	logVo.setSuimRptAprvDate(suimVoAfterUdt.getSuimRptAprvDate());
    	logVo.setCloseDate(suimVoAfterUdt.getCloseDate());
    	
    	if(action.equals("report_del")){
    		
    		Calendar cal = Calendar.getInstance();    
    		cal.setTime(new Date());    
    		
    		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
    		String today = df.format(cal.getTime());
    		
    		logVo.setDelDate(today);
    	}else{
    		logVo.setDelDate("1970-01-01");
    	}
    	
    	
    	logVo.setSuimRptState(suimVoAfterUdt.getSuimRptState());
    	logVo.setLockFlag(suimVoAfterUdt.getLockFlag());;
    	logVo.setMinwonFlag(suimVoAfterUdt.getMinwonFlag());
    	logVo.setLogIp(ip);
    	logVo.setLogUserNo( mbrVo.getUser_no() );
    	logVo.setAction(action);
    	
    	logVo.setTeam_id(suimVoAfterUdt.getTeam_id());
    	logVo.setUser_no(suimVoAfterUdt.getUser_no());
    	logVo.setPtnr_id(suimVoAfterUdt.getPtnr_id());
    	logVo.setPtnr_dept_id(suimVoAfterUdt.getPtnr_dept_id());
    	logVo.setPtnr_mbr_no(suimVoAfterUdt.getPtnr_mbr_no());
    	logVo.setOnestopMbrNo(suimVoAfterUdt.getOnestopMbrNo());
    	logVo.setOnestopTeamId(suimVoAfterUdt.getOnestopTeamId());
    	logVo.setWorkloadType(suimVoAfterUdt.getWorkloadType());
    	logVo.setWorkloadEa(suimVoAfterUdt.getWorkloadEa());

    	logVo.setPtnrAssignGubun(suimVoAfterUdt.getPtnrAssignGubun());
    	logVo.setPtnrDetailGubun(suimVoAfterUdt.getPtnrDetailGubun());
    	
    	
    	
		sqlSession.insert("SuimBookUdtMapper.suimLogForAction", logVo);			
    }
	
	
}

