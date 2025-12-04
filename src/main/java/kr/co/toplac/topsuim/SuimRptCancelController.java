package kr.co.toplac.topsuim;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.cmm.RequestUtil;

@Controller
public class SuimRptCancelController {
	
private static final Logger logger = LoggerFactory.getLogger(SuimRptCancelController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
  	/*
  	 * ***************************************
  	 * Method ID   : insRptCancel
  	 * Method Name : insRptCancel
  	 * Description : 위임취소 프로세스 - 위임취소 신청 (요청자 : 김두현 차장)
  	 * Author : 임대성
  	 * Date : 170728
  	 * ***************************************
  	 * */   
    @RequestMapping(value = "insRptCancel", method = RequestMethod.POST)
  	public String insRptCancel(HttpServletRequest request, HttpSession session, Model model){
    	logger.info("======== insRptCancel ========");
    	
		//===============================================
        //	파라미터 체크
    	//===============================================
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

    	
    	//===============================================
    	//	권한체크
    	//===============================================
    	TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
    	//TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) Sessio`nUtil.getAuthorities();
    	paramMap.put("userNo", mbrVo.getUser_no());
  		  
    	//===============================================
    	//	비즈니스 로직
    	//===============================================
    	String suimRptNo = (String) paramMap.get("rptCancelSuimRptNo");
    	String primRptNo = (String) paramMap.get("rptCancelPrimRptNo");
    	String processChk = (String) paramMap.get("processChk");
    	
    	//suimRptNo 값이 top_rpt_cancel 테이블에 존재하는지 체크후 존재하면 update 형태로 바꾸어야함.
    	
    	int chkCnt = 0;		//기존 위임취소 갯수    	
    	int insCnt = 0;		//신규 위임취소 갯수
    	
    	chkCnt = sqlSession.selectOne("SuimRptCancelMapper.getRptCancelCnt",paramMap);    	
    	
    	if( chkCnt == 0 ) {    		
    		insCnt = sqlSession.insert("SuimRptCancelMapper.insRptCancel",paramMap);
    	}else {    		
    		insCnt = sqlSession.update("SuimRptCancelMapper.upadateRptCancel",paramMap);
    	}		 
    	
    	if (insCnt == 1){
    		//위임취소 신청 시, 수임 상태를 31로 변경
    		paramMap.put("suimRptState", "31");
    		sqlSession.update("SuimRptCancelMapper.udtRptStateCancel",paramMap);
    		
    		//수임 및 농작물건 LOG 작성
    		if ( processChk.equals("1") ){
    			SuimCommon SuimCommon = new SuimCommon();
        		SuimCommon.insSuimRptLog(sqlSession,"cancel_request", suimRptNo);
    		}else if( processChk.equals("2") ){
    			HashMap<String,String> map = new HashMap<String, String>();	
    			map.put("smNo", primRptNo);
    			map.put("userNo", mbrVo.getUser_no());
    			map.put("userIp", request.getRemoteAddr());
    			sqlSession.insert("InsertRptLogMapper.insPrimBizRptBscMap", map);
    		}
		}
	    	
    	if ( processChk.equals("1") ){
	    	return "redirect:/suimRptBscDtl?suim_rpt_no="+suimRptNo;
    	}else{
    		return "redirect:/primBizRptDtl?suim_rpt_no="+primRptNo;
    	}
    }   
    
  	/*
  	 * ***************************************
  	 * Method ID   : udtRptCancel
  	 * Method Name : udtRptCancel
  	 * Description : 위임취소 프로세스 - 위임취소 내용 수정 (요청자 : 김두현 차장)
  	 * Author : 임대성
  	 * Date : 170728
  	 * ***************************************
  	 * */    
    @RequestMapping(value = "udtRptCancel", method = RequestMethod.POST)
  	public String udtRptCancel(HttpServletRequest request, Model model){
    	logger.info("======== udtRptCancel ========");
    	
		//===============================================
        //	파라미터 체크
    	//===============================================
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

    	//===============================================
    	//	권한체크
    	//===============================================
    	TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
    	//TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) Sessio`nUtil.getAuthorities();

    	//===============================================
    	//	비즈니스 로직
    	//===============================================
    	String suimRptNo = (String) paramMap.get("rptCancelSuimRptNo");
    	String primRptNo = (String) paramMap.get("rptCancelPrimRptNo");
    	String processChk = (String) paramMap.get("processChk");
    	
    	int udtCnt = sqlSession.update("SuimRptCancelMapper.udtRptCancel",paramMap);
          
    	if ( processChk.equals("1") ){
	    	return "redirect:/suimRptBscDtl?suim_rpt_no="+suimRptNo;
    	}else{
    		return "redirect:/primBizRptDtl?suim_rpt_no="+primRptNo;
    	}
    } 
    
    
  	/*
  	 * ***************************************
  	 * Method ID   : delRptCancel
  	 * Method Name : delRptCancel
  	 * Description : 위임취소 프로세스 - 위임취소신청 취소 (요청자 : 김두현 차장)
  	 * Author : 임대성
  	 * Date : 170728
  	 * ***************************************
  	 * */     
    @RequestMapping(value = "delRptCancel", method = RequestMethod.POST)
  	public String delRptCancel(HttpServletRequest request, HttpSession session, Model model){
    	logger.info("======== delRptCancel ========");
    	
		//===============================================
        //	파라미터 체크
    	//===============================================
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

    	//===============================================
    	//	권한체크
    	//===============================================
    	TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
    	//TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) Sessio`nUtil.getAuthorities();

    	//===============================================
    	//	비즈니스 로직
    	//===============================================
    	String suimRptNo = (String) paramMap.get("rptCancelSuimRptNo");
    	String primRptNo = (String) paramMap.get("rptCancelPrimRptNo");
    	String processChk = (String) paramMap.get("processChk");
    	
    	paramMap.put("cancelFlag", "4");
    	
    	//실제로 삭제 하지않으며, del_date에 날짜를 입력하는 방식으로 UPDATE
    	int uptCnt = sqlSession.update("SuimRptCancelMapper.delRptCancel",paramMap);
    	if (uptCnt == 1){
    		//위임취소신청을 취소 할 시, 수임 상태를 미결로 변경
    		paramMap.put("suimRptState", "0");
    		sqlSession.update("SuimRptCancelMapper.udtRptStateCancel",paramMap);
    		
    		//수임 및 농작물건 LOG 작성
    		if ( processChk.equals("1") ){
    			SuimCommon SuimCommon = new SuimCommon();
        		SuimCommon.insSuimRptLog(sqlSession,"cancel_request", suimRptNo);
    		}else if( processChk.equals("2") ){
    			HashMap<String,String> map = new HashMap<String, String>();	
    			map.put("smNo", primRptNo);
    			map.put("userNo", (String) session.getAttribute("user_no_Session"));
    			map.put("userIp", request.getRemoteAddr());
    			sqlSession.insert("InsertRptLogMapper.insPrimBizRptBscMap", map);
    		}
		}
    	
    	if ( processChk.equals("1") ){
	    	return "redirect:/suimRptBscDtl?suim_rpt_no="+suimRptNo;
    	}else{
    		return "redirect:/primBizRptDtl?suim_rpt_no="+primRptNo;
    	}
    }  

  	/*
  	 * ***************************************
  	 * Method ID   : approvRptCancel
  	 * Method Name : approvRptCancel
  	 * Description : 위임취소 프로세스 - 위임취소신청 결재 (요청자 : 김두현 차장)
  	 * Author : 임대성
  	 * Date : 170728
  	 * ***************************************
  	 * */     
    @RequestMapping(value = "approvRptCancel", method = RequestMethod.POST)
  	public String approvRptCancel(HttpServletRequest request, Model model){
    	logger.info("======== approvRptCancel ========");
    	
		//===============================================
        //	파라미터 체크
    	//===============================================
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

    	//===============================================
    	//	권한체크
    	//===============================================
    	TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
    	//TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) Sessio`nUtil.getAuthorities();

    	//===============================================
    	//	비즈니스 로직
    	//===============================================
    	String suimRptNo = (String) paramMap.get("rptCancelSuimRptNo");
    	String primRptNo = (String) paramMap.get("rptCancelPrimRptNo");
    	String processChk = (String) paramMap.get("processChk");
    	String viewGubun = (String) paramMap.get("viewGubun");
    	
    	paramMap.put("userNo", mbrVo.getUser_no());
    	paramMap.put("cancelFlag", "1");
    	
    	
    	int uptCnt = sqlSession.update("SuimRptCancelMapper.approvRptCancel",paramMap);
    	if (uptCnt == 1){
    		//결재하여 수임상태 변경
    		paramMap.put("suimRptState", "3");
    		sqlSession.update("SuimRptCancelMapper.udtRptStateCancel",paramMap);
    		
    		//수임 및 농작물건 LOG 작성
    		if ( processChk.equals("1") ){
    			SuimCommon SuimCommon = new SuimCommon();
        		SuimCommon.insSuimRptLog(sqlSession,"cancel", suimRptNo);
    		}else if( processChk.equals("2") ){
    			HashMap<String,String> map = new HashMap<String, String>();	
    			map.put("smNo", primRptNo);
    			map.put("userNo", mbrVo.getUser_no());
    			map.put("userIp", request.getRemoteAddr());
    			sqlSession.insert("InsertRptLogMapper.insPrimBizRptBscMap", map);
    		}
		}
    	
    	if ( processChk.equals("1") && !viewGubun.equals("approvList") ){
	    	return "redirect:/suimRptBscDtl?suim_rpt_no="+suimRptNo;
    	}else if ( processChk.equals("2") && !viewGubun.equals("approvList") ){
    		return "redirect:/primBizRptDtl?suim_rpt_no="+primRptNo;
    	}else{
    		return "redirect:/rptCancelApprovList";
    	}
    }  
 
    
  	/*
  	 * ***************************************
  	 * Method ID   : returnRptCancel
  	 * Method Name : returnRptCancel
  	 * Description : 위임취소 프로세스 - 위임취소신청 반려 (요청자 : 김두현 차장)
  	 * Author : 임대성
  	 * Date : 170802
  	 * ***************************************
  	 * */     
    @RequestMapping(value = "returnRptCancel", method = RequestMethod.POST)
  	public String returnRptCancel(HttpServletRequest request, Model model){
    	logger.info("======== returnRptCancel ========");
    	
		//===============================================
        //	파라미터 체크
    	//===============================================
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

    	//===============================================
    	//	권한체크
    	//===============================================
    	TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
    	//TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) Sessio`nUtil.getAuthorities();

    	//===============================================
    	//	비즈니스 로직
    	//===============================================
    	String suimRptNo = (String) paramMap.get("rptCancelSuimRptNo");
    	String primRptNo = (String) paramMap.get("rptCancelPrimRptNo");
    	String processChk = (String) paramMap.get("processChk");
    	String viewGubun = (String) paramMap.get("viewGubun");
    	
    	paramMap.put("userNo", mbrVo.getUser_no());
    	paramMap.put("cancelFlag", "2");
    	
    	int uptCnt = sqlSession.update("SuimRptCancelMapper.returnRptCancel",paramMap);
    	if (uptCnt == 1){
    		//위임취소신청을 취소 할 시, 수임 상태를 미결로 변경
    		paramMap.put("suimRptState", "0");
    		sqlSession.update("SuimRptCancelMapper.udtRptStateCancel",paramMap);
    		
    		//수임 및 농작물건 LOG 작성
    		if ( processChk.equals("1") ){
    			SuimCommon SuimCommon = new SuimCommon();
        		SuimCommon.insSuimRptLog(sqlSession,"cancel_request", suimRptNo);
    		}else if( processChk.equals("2") ){
    			HashMap<String,String> map = new HashMap<String, String>();	
    			map.put("smNo", primRptNo);
    			map.put("userNo", mbrVo.getUser_no());
    			map.put("userIp", request.getRemoteAddr());
    			sqlSession.insert("InsertRptLogMapper.insPrimBizRptBscMap", map);
    		}
		}
    	
    	if ( processChk.equals("1") && !viewGubun.equals("approvList") ){
	    	return "redirect:/suimRptBscDtl?suim_rpt_no="+suimRptNo;
    	}else if ( processChk.equals("2") && !viewGubun.equals("approvList") ){
    		return "redirect:/primBizRptDtl?suim_rpt_no="+primRptNo;
    	}else{
    		return "redirect:/rptCancelApprovList";
    	}
    }
	
    
    
  	/*
  	 * ***************************************
  	 * Method ID   : restoreRptCancel
  	 * Method Name : restoreRptCancel
  	 * Description : 위임취소 프로세스 - 위임취소 되돌리기 (요청자 : 김두현 차장)
  	 * Author : 임대성
  	 * Date : 170802
  	 * ***************************************
  	 * */     
    @RequestMapping(value = "restoreRptCancel", method = RequestMethod.POST)
  	public String restoreRptCancel(HttpServletRequest request, Model model){
    	logger.info("======== restoreRptCancel ========");
    	
		//===============================================
        //	파라미터 체크
    	//===============================================
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

    	//===============================================
    	//	권한체크
    	//===============================================
    	TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
    	//TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) Sessio`nUtil.getAuthorities();

    	//===============================================
    	//	비즈니스 로직
    	//===============================================
    	String suimRptNo = (String) paramMap.get("rptCancelSuimRptNo");
    	String primRptNo = (String) paramMap.get("rptCancelPrimRptNo");
    	String processChk = (String) paramMap.get("processChk");
    	
    	paramMap.put("userNo", mbrVo.getUser_no());
    	paramMap.put("cancelFlag", "3");
    	System.out.println("되돌리기!!");
    	int uptCnt = sqlSession.update("SuimRptCancelMapper.restoreRptCancel",paramMap);
    	System.out.println("uptCnt : " + uptCnt);
    	//기존의 위임취소건들이 작동하지 않으므로, udtCnt 조건 제거
		//위임취소신청을 취소 할 시, 수임 상태를 미결로 변경
		paramMap.put("suimRptState", "0");
		sqlSession.update("SuimRptCancelMapper.udtRptStateCancel",paramMap);
		
		//수임 및 농작물건 LOG 작성
		if ( processChk.equals("1") ){
			SuimCommon SuimCommon = new SuimCommon();
    		SuimCommon.insSuimRptLog(sqlSession,"cancel_request", suimRptNo);
		}else if( processChk.equals("2") ){
			HashMap<String,String> map = new HashMap<String, String>();	
			map.put("smNo", primRptNo);
			map.put("userNo", mbrVo.getUser_no());
			map.put("userIp", request.getRemoteAddr());
			sqlSession.insert("InsertRptLogMapper.insPrimBizRptBscMap", map);
		}
    	
    	if ( processChk.equals("1") ){
	    	return "redirect:/suimRptBscDtl?suim_rpt_no="+suimRptNo;
    	}else{
    		return "redirect:/primBizRptDtl?suim_rpt_no="+primRptNo;
    	}
    }
    
    
    
 	/*
  	 * ***************************************
  	 * Method ID   : rptCancelApprovList
  	 * Method Name : rptCancelApprovList
  	 * Description : 위임취소 프로세스 - 신청 목록 리스트 페이지 (요청자 : 김두현 차장)
  	 * Author : 임대성
  	 * Date : 170802
  	 * ***************************************
  	 * */     
    @RequestMapping(value = "rptCancelApprovList")
  	public String rptCancelApprovList(HttpServletRequest request, Model model){
    	logger.info("======== rptCancelApprovList ========");
    	
		//===============================================
        //	파라미터 체크
    	//===============================================
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

    	//===============================================
    	//	권한체크
    	//===============================================
    	TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
    	//TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) Sessio`nUtil.getAuthorities();
    		
    	//===============================================
    	//	비즈니스 로직
    	//===============================================
    	
    	model.addAttribute("viewGubun","approvList");
    	
    	//기존 종결권한에서 위임취소결재권한 있는 팀목록으로 기능 변경 by top3009 (20240731)
		//String rptCancelTeamAuth = sqlSession.selectOne("TmMainLeftUtilMapper.getAdmin7TeamId",mbrVo.getUser_no());
		String rptCancelTeamAuth = sqlSession.selectOne("TmMainLeftUtilMapper.getRptCancelApprovalTeamId",mbrVo.getUser_no());
		
		List<String> rptCancelTeamId = new ArrayList<String>();
		if (!rptCancelTeamAuth.equals("") && !rptCancelTeamAuth.equals(null)){
			if (rptCancelTeamAuth.charAt(0) == '|'){
				rptCancelTeamAuth = rptCancelTeamAuth.substring(1);
			}	
		}
		String[] tmpTeam = rptCancelTeamAuth.split("\\|");
		rptCancelTeamId.add(mbrVo.getTeam_id_main());
		for(int i=0; i < tmpTeam.length ; i++){
			rptCancelTeamId.add(tmpTeam[i]);
		}
    	
    	List<SuimRptCompositeVO> suimRptCancelApprovList = sqlSession.selectList("SuimRptCancelMapper.getSuimRptCancelApprovList",rptCancelTeamId);
    	List<SuimRptCompositeVO> primRptCancelApprovList = sqlSession.selectList("SuimRptCancelMapper.getPrimRptCancelApprovList",rptCancelTeamId);
    	
    	model.addAttribute("suimRptCancelApprovList",suimRptCancelApprovList);
    	model.addAttribute("primRptCancelApprovList",primRptCancelApprovList);
    	
    	return "top_suim/suim_rpt_cancel_approv_list";
    }
    
}
