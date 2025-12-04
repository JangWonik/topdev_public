package kr.co.toplac.topsuim;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URI;
import java.nio.charset.Charset;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.FormHttpMessageConverter;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.util.UriComponentsBuilder;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import kr.co.toplac.cmm.service.BitlyShortUrlService;
import kr.co.toplac.cmm.service.CodeDicService;
import kr.co.toplac.cmm.service.S3Service;
import kr.co.toplac.sysadm.SysAdmCodeDicVO;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;
import kr.co.toplac.util.etc.Damo;
import kr.co.toplac.util.etc.SplitPhoneNo;
import kr.co.toplac.util.file.FileUpload;
import kr.co.toplac.util.mail.Sendmail;

/**
 * Created by lds on 2018.11.23
 * 수임대장 - 손해사정서 교부
 */
@Controller
public class SuimRptBscReportIssueController {
    private static final Logger logger = LoggerFactory.getLogger(SuimRptBscReportIssueController.class);


    @Autowired
    private SqlSession sqlSession;
    
    @Autowired
    private CodeDicService service;
    
    /**
     * 보고서 수임번호로 손해사정서 교부동의서가 갯수 확인
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/getCountTopRptIssueFileBySuimRptNo")
    @ResponseBody
    public int getCountTopRptIssueFileBySuimRptNo(HttpServletRequest request, Model model) {
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String sSuimRptNo = String.valueOf(paramMap.get("suim_rpt_no"));
    	
    	logger.info("======== getCountTopRptIssueFileBySuimRptNo ("+sSuimRptNo+") ========");
    	
    	int retCnt = sqlSession.selectOne("RptIssueMapper.getTopRptIssueFileCountBySuimRptNo", sSuimRptNo);    	
    	
    	return retCnt;
    }
    
    /**
     * 인보험 기본 손해사정서
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/reportIssueMainPi")
    public String reportIssueMainPi(HttpServletRequest request, Model model){

    	logger.info("======== reportIssueMainPi ========");
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String suim_rpt_type1 = request.getParameter("suim_rpt_type1");
        String ptnr_mbr_nm = request.getParameter("ptnr_mbr_nm");
        String cmd = StringUtil.null2blank(request.getParameter("cmd"));
        //===============================================
        // 비즈니스 로직
        //===============================================
        
        int nRptCnt = sqlSession.selectOne("RptIssueMapper.selectRptIssueCnt", paramMap);

        if (nRptCnt == 0){
            sqlSession.insert("RptIssueMapper.insertRptIssueForExist", paramMap);
        }
        
        //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);

        //담당팀 기본정보 가져오기
        paramMap.put("team_id", rptIssueMain.get("teamId"));
        Map<String, Object> reportTeamInfo = sqlSession.selectOne("SuimReportMapper.selectSuimReportTeam", paramMap);

        //조사자 정보
        paramMap.put("user_no", rptIssueMain.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
        
        //세부정보 가져오기
        SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);

        //================================================================
        //  손해사정서 교부 기본정보
        //================================================================
        // 손해사정서 교부 기본정보가 있는지 확인 없으면 기본입력
        //Map<String, Object> rptIssueisExist = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        List<Map<String, Object>> rptIssueSendList = sqlSession.selectList("RptIssueMapper.selectRptIssueSend", paramMap);
        
        String sTemp = "";		//임시메시지키
        String sRet = "";			//임시상태리턴값
        String dCode = "";		//임시코드
        String dMessage = "";	//임시메시지
        String dErrinfo = "";
        String dUflag = "";
        String chkRet = "";
        
        //발송된 메시지 상태값 확인
        for( Map<String, Object > params : rptIssueSendList) {
        	if( params.get("sendState").toString().equals("2") ) {			//대기중인 상태
        		//대기중인 메시지 키로 kakao 에 상태값을 읽어온다.
        		sTemp = params.get("msgid").toString();        		
        		sRet = sendKakaoResult(sTemp);
        		chkRet = sRet.substring(0, 4);
        		
        		if( sRet.equals("M000") || sRet.equals("K000") || sRet.equals("R000") ) {		//발송 성공
        			//발송 상태값을 발송 완료로 바꾸어 준다.        			
        			paramMap.put("msgid", sTemp);
        			paramMap.put("send_state", 1);
        			sqlSession.update("RptIssueMapper.updateRptIssueSendMagStateOk",paramMap);
        		}else if( chkRet.equals("M001")  ){			//대기중 인경우
        			try {
        				dCode = sRet.substring(0,1);
            			dMessage = sRet.substring(1,4);
            			
            			//에러 코드를 bizm_error 테이블에서 가져온다.
            			paramMap.put("ecode", dCode);
            			paramMap.put("emessage", dMessage);
            			
            			Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            			
            			dErrinfo = errorMsg.get("errinfo").toString();
            			dUflag = errorMsg.get("uflag").toString();

            			if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            				params.put("stateMsg", dErrinfo);
            			}else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            				params.put("stateMsg", sRet);
            			}
					} catch (Exception e) {
						params.put("stateMsg", "전송대기중 입니다.");
					}        			        			       			
        		}else {			//실패한 경우
        			//발송 상태값을 발송 실패로 바꾸어 준다.
        			//System.out.println("oniku실패체크 : "+sTemp+" : "+chkRet);        			
        			paramMap.put("msgid", sTemp);
        			paramMap.put("send_state", 0);
        			sqlSession.update("RptIssueMapper.updateRptIssueSendMagStateOk",paramMap);
        			
        			try {        				
        				dCode = sRet.substring(0,1);
            			dMessage = sRet.substring(1,4);
            			
            			//에러 코드를 bizm_error 테이블에서 가져온다.
            			paramMap.put("ecode", dCode);
            			paramMap.put("emessage", dMessage);
            			
            			Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            			
            			dErrinfo = errorMsg.get("errinfo").toString();
            			dUflag = errorMsg.get("uflag").toString();

            			if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            				params.put("stateMsg", dErrinfo);
            			}else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            				params.put("stateMsg", sRet);
            			}
					} catch (Exception e) {
						params.put("stateMsg", "발송실패");
					} 
        		}
        	}else if( params.get("sendState").toString().equals("0") ){
        		try {
        			//실패한 메시지 키로 kakao 에 상태값을 읽어온다.
            		sTemp = params.get("msgid").toString();
            		sRet = sendKakaoResult(sTemp);
            		
            		if( sRet.equals("M000") || sRet.equals("K000") || sRet.equals("R000") ) {		//발송 성공
            			//발송 상태값을 발송 완료로 바꾸어 준다.        			
            			paramMap.put("msgid", sTemp);
            			paramMap.put("send_state", 1);
            			sqlSession.update("RptIssueMapper.updateRptIssueSendMagStateOk",paramMap);
            		}else if( sRet.equals("M001") ){
            			params.put("stateMsg", "전송대기중 입니다.");            			
            		}else if( sRet.startsWith("E110") || sRet.equals(" ") ){
            			params.put("stateMsg", "잠시 기다려주세요.");
            		}else {
            			dCode = sRet.substring(0,1);
            			dMessage = sRet.substring(1,4);
            			
            			//에러 코드를 bizm_error 테이블에서 가져온다.
            			paramMap.put("ecode", dCode);
            			paramMap.put("emessage", dMessage);
            			
            			Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            			
            			dErrinfo = errorMsg.get("errinfo").toString();
            			dUflag = errorMsg.get("uflag").toString();

            			if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            				params.put("stateMsg", dErrinfo);
            			}else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            				params.put("stateMsg", sRet);
            			}            			
            		}
				} catch (Exception e) {
					params.put("stateMsg", "발송결과 확인중 입니다.");
				}        		
        	}
        }
        
        //담당자 자격증(손해사정사) 정보 List 만들기 시작
        List<Map<String, Object>> certiReportUser = null;					//보고서 하단에 들어갈 담당자 정보 List
        List<Map<String, Object>> certiManagerReportUser = null;		//담당손해사정사 목록

        //System.out.println(":::::::::::: certiReportUser : "+String.valueOf(paramMap.get("user_no")));

        String sUserNo = String.valueOf(paramMap.get("user_no"));

        //기 종결건은 담당손해사정사가 별도 저장되어있음 (top_rpt_certi_end) 저장된 손해사정사 정보가 별도로 있는지 체크
        int nEndCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiEndCnt",paramMap);

        if( nEndCnt == 0 ) {			//정보가 없는 경우 실시간으로 가져온다.
        	
        	if( !"0".equals(sUserNo) ) {		//0은 미배당건        	
        	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiMemberInfo", paramMap);
        	
        	int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
        	
        	nCertiManagerCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiManagerCnt", paramMap);
        	
	        	if( nCertiManagerCnt > 0 ) {			//담당손해사정사가 있는 경우
	        		certiManagerReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiManagerList", paramMap);
	        		for( int i=0; i < certiManagerReportUser.size(); i++) {
	        			certiReportUser.add(certiManagerReportUser.get(i));		//보고서 하단에 들어갈 담당자 정보에 담당손해사정서를 추가한다.
	        		}
	        	}
            }
        	
        }else{								//정보가 있는 경우 top_rpt_certi_end 테이블에서 불러온다.
        	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiEndInfo", paramMap);
        }

        model.addAttribute("certiReportUser", certiReportUser);
        //담당자 자격증(손해사정사) 정보 List 만들기 끝
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("rptIssueMain", rptIssueMain);
        model.addAttribute("reportTeamInfo", reportTeamInfo);
        model.addAttribute("reportInvgUser", reportInvgUser);
        
        //model.addAttribute("rptIssue", rptIssue);
        model.addAttribute("rptIssueSendList", rptIssueSendList);
        
        model.addAttribute("suim_rpt_type1", suim_rpt_type1);
        model.addAttribute("ptnr_mbr_nm", ptnr_mbr_nm);
        model.addAttribute("suimVO", suimVo);
        
        boolean sendChk = false;		//손해 사정서 발송 플래그 (발송한 건이 한건이상있는 경우 true)        
        
        for( Map<String, Object> map : rptIssueSendList ) {        	
        	for( Map.Entry<String, Object> entry : map.entrySet() ) {
        		if( entry.getKey().equals("sendState") ) {
        			if( entry.getValue().toString().equals("1") ) {		//발송완료건으로 처리        				
        				sendChk = true;
        				break;
        			}
        		}
        	}        		
        }        
        
        //System.out.println("sendChk="+sendChk);
        //해당건에 대한 발송여부를 파라미터 추가
        model.addAttribute("sendChk", sendChk);		// true : 발송완료, false : 발송건 없음
                
        //DB 에 저장된 작성일자가 없으면 시스템 시간으로 넣어주고 DB 에 값이 있으면 그값으로 넣어준다. by top3009
        if( rptIssue.get("writeDate") == null ) {
        	String sNow = DateUtil.getTodayString();
            sNow = DateUtil.getDateFormat(sNow, "-");
            model.addAttribute("nowdate", sNow);
        }else {
        	model.addAttribute("nowdate", rptIssue.get("writeDate").toString());
        }        
        //DB 에 저장된 작성일자가 없으면 시스템 시간으로 넣어주고 DB 에 값이 있으면 그값으로 넣어준다. by oniku
        
        //today 시간설정 시작
        Calendar cal = Calendar.getInstance();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
        String sToday = df.format(cal.getTime());
        
        model.addAttribute("sToday", sToday);		//현재시간 추가
        //today 시간설정 끝
        
        //워드 또는 출력시에도 보냈는지 여부 체크
        if( !sendChk ) {		//보내지 않았을때는 오늘 날짜로 셋팅
        	rptIssue.put("writeDateFmt", sToday);
        }
        
        model.addAttribute("rptIssue", rptIssue);
                
        //출력인경우 Ajax 로 가져오는 부분을 Control에서 불러온다.
        if( "word".equals(cmd) || "print".equals(cmd) || "report".equals(cmd) ) {        	
        	Map<String, Object> lawEtcContentMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawContentInfo", paramMap);
        	model.addAttribute("lawEtcContentInfo", lawEtcContentMap);
        	
        	Map<String, Object> lawReasonMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawReasonInfo", paramMap);
        	model.addAttribute("lawReasonInfo", lawReasonMap);

        	Map<String, Object> lawSelContentMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawSelInfo", paramMap);
        	model.addAttribute("lawSelContentInfo", lawSelContentMap);
        }        
        
        String retURL = "top_suim_reportissue/rpt_issue_main_pi";

        if ("word".equals(cmd)){
            retURL = "top_suim_reportissue/rpt_issue_main_pi_word";
        }else if("print".equals(cmd)){
            retURL = "top_suim_reportissue/rpt_issue_main_pi_print";
        }else if("report".equals(cmd)) {
        	retURL = "top_suim_reportissue/rpt_issue_main_pi_report";
        }

        System.out.println("retURL:["+retURL+"]");

        return retURL;
    }

    /**
     * 메리츠 손해사정서 
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/reportIssueMeritz")
    public String reportIssueMeritz(HttpServletRequest request, Model model){

    	logger.info("======== reportIssueMeritz ========");
        //===============================================
        //	파라미터 체크
        //===============================================
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String suim_rpt_type1 = request.getParameter("suim_rpt_type1");
        String ptnr_mbr_nm = request.getParameter("ptnr_mbr_nm");
        String cmd = StringUtil.null2blank(request.getParameter("cmd"));
        //===============================================
        // 비즈니스 로직
        //===============================================
        
        //손해사정서가 없는 경우 체크
        int nRptCnt = sqlSession.selectOne("RptIssueMapper.selectRptIssueCnt", paramMap);

        if (nRptCnt == 0){
        	sqlSession.insert("RptIssueMapper.insertRptIssueForExist", paramMap);
        }
        
        //기본정보 가져오기 (메리츠용)
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBscMeritz", paramMap);

        //담당팀 기본정보 가져오기
        paramMap.put("team_id", rptIssueMain.get("teamId"));
        Map<String, Object> reportTeamInfo = sqlSession.selectOne("SuimReportMapper.selectSuimReportTeam", paramMap);

        //조사자 정보
        paramMap.put("user_no", rptIssueMain.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
        
        //세부정보 가져오기
        SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);
        
        //================================================================
        //  손해사정서 교부 기본정보
        //================================================================
        // 손해사정서 교부 기본정보가 있는지 확인 없으면 기본입력
        //Map<String, Object> rptIssueisExist = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        List<Map<String, Object>> rptIssueSendList = sqlSession.selectList("RptIssueMapper.selectRptIssueSend", paramMap);
        
        String sTemp = "";		//임시메시지키
        String sRet = "";			//임시상태리턴값
        String dCode = "";		//임시코드
        String dMessage = "";	//임시메시지
        String dErrinfo = "";
        String dUflag = "";
        String chkRet = "";
        
        //발송된 메시지 상태값 확인
        for( Map<String, Object > params : rptIssueSendList) {
        	if( params.get("sendState").toString().equals("2") ) {			//대기중인 상태
        		//대기중인 메시지 키로 kakao 에 상태값을 읽어온다.
        		sTemp = params.get("msgid").toString();        		
        		sRet = sendKakaoResult(sTemp);
        		chkRet = sRet.substring(0, 4);
        		
        		if( sRet.equals("M000") || sRet.equals("K000") || sRet.equals("R000") ) {		//발송 성공
        			//발송 상태값을 발송 완료로 바꾸어 준다.        			
        			paramMap.put("msgid", sTemp);
        			paramMap.put("send_state", 1);
        			sqlSession.update("RptIssueMapper.updateRptIssueSendMagStateOk",paramMap);
        		}else if( chkRet.equals("M001")  ){			//대기중 인경우
        			try {
        				dCode = sRet.substring(0,1);
            			dMessage = sRet.substring(1,4);
            			
            			//에러 코드를 bizm_error 테이블에서 가져온다.
            			paramMap.put("ecode", dCode);
            			paramMap.put("emessage", dMessage);
            			
            			Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            			
            			dErrinfo = errorMsg.get("errinfo").toString();
            			dUflag = errorMsg.get("uflag").toString();

            			if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            				params.put("stateMsg", dErrinfo);
            			}else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            				params.put("stateMsg", sRet);
            			}
					} catch (Exception e) {
						params.put("stateMsg", "전송대기중 입니다.");
					}        			        			       			
        		}else {			//실패한 경우
        			//발송 상태값을 발송 실패로 바꾸어 준다.
        			//System.out.println("oniku실패체크 : "+sTemp+" : "+chkRet);        			
        			paramMap.put("msgid", sTemp);
        			paramMap.put("send_state", 0);
        			sqlSession.update("RptIssueMapper.updateRptIssueSendMagStateOk",paramMap);
        			
        			try {        				
        				dCode = sRet.substring(0,1);
            			dMessage = sRet.substring(1,4);
            			
            			//에러 코드를 bizm_error 테이블에서 가져온다.
            			paramMap.put("ecode", dCode);
            			paramMap.put("emessage", dMessage);
            			
            			Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            			
            			dErrinfo = errorMsg.get("errinfo").toString();
            			dUflag = errorMsg.get("uflag").toString();

            			if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            				params.put("stateMsg", dErrinfo);
            			}else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            				params.put("stateMsg", sRet);
            			}
					} catch (Exception e) {
						params.put("stateMsg", "발송실패");
					} 
        		}
        	}else if( params.get("sendState").toString().equals("0") ){
        		try {
        			//실패한 메시지 키로 kakao 에 상태값을 읽어온다.
            		sTemp = params.get("msgid").toString();
            		sRet = sendKakaoResult(sTemp);
            		
            		if( sRet.equals("M000") || sRet.equals("K000") || sRet.equals("R000") ) {		//발송 성공
            			//발송 상태값을 발송 완료로 바꾸어 준다.        			
            			paramMap.put("msgid", sTemp);
            			paramMap.put("send_state", 1);
            			sqlSession.update("RptIssueMapper.updateRptIssueSendMagStateOk",paramMap);
            		}else if( sRet.equals("M001") ){
            			params.put("stateMsg", "전송대기중 입니다.");            			
            		}else if( sRet.startsWith("E110") || sRet.equals(" ") ){
            			params.put("stateMsg", "잠시 기다려주세요.");
            		}else {
            			dCode = sRet.substring(0,1);
            			dMessage = sRet.substring(1,4);
            			
            			//에러 코드를 bizm_error 테이블에서 가져온다.
            			paramMap.put("ecode", dCode);
            			paramMap.put("emessage", dMessage);
            			
            			Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            			
            			dErrinfo = errorMsg.get("errinfo").toString();
            			dUflag = errorMsg.get("uflag").toString();

            			if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            				params.put("stateMsg", dErrinfo);
            			}else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            				params.put("stateMsg", sRet);
            			}            			
            		}
				} catch (Exception e) {
					params.put("stateMsg", "발송결과 확인중 입니다.");
				}        		
        	}
        }
        
        //담당자 자격증(손해사정사) 정보 List 만들기 시작
        List<Map<String, Object>> certiReportUser = new ArrayList<Map<String, Object>>();					//보고서 하단에 들어갈 담당자 정보 List
        List<Map<String, Object>> certiManagerReportUser = new ArrayList<Map<String, Object>>();		//담당손해사정사 목록
        
        //System.out.println(":::::::::::: certiReportUser : "+String.valueOf(paramMap.get("user_no")));
        
        String sUserNo = String.valueOf(paramMap.get("user_no"));
        
        //기 종결건은 담당손해사정사가 별도 저장되어있음 (top_rpt_certi_end) 저장된 손해사정사 정보가 별도로 있는지 체크
        int nEndCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiEndCnt",paramMap);
        
        if( nEndCnt == 0 ) {			//정보가 없는 경우 실시간으로 가져온다.
        	
        	if( !"0".equals(sUserNo) ) {		//0은 미배당건        	
            	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiMemberInfo", paramMap);
            	
            	int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
            	
            	nCertiManagerCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiManagerCnt", paramMap);
            	
            	//System.out.println("nCertiManagerCnt : "+nCertiManagerCnt);
            	
            	if( nCertiManagerCnt > 0 ) {			//담당손해사정사가 있는 경우
            		certiManagerReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiManagerList", paramMap);
            		for( int i=0; i < certiManagerReportUser.size(); i++) {
            			certiReportUser.add(certiManagerReportUser.get(i));		//보고서 하단에 들어갈 담당자 정보에 담당손해사정서를 추가한다.
            		}
            	}
            }
        	
        }else{								//정보가 있는 경우 top_rpt_certi_end 테이블에서 불러온다.
        	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiEndInfo", paramMap);
        }
        
        //담당자가 손해사정사인 경우 데이터 복제 (메리츠는 최소 조사자와 손해사정사가 나와야한다.)
        if( certiReportUser.size() == 1 ) {        	
        	certiReportUser.add(certiReportUser.get(0));
        }
        
        //if( certiReportUser != null ) {
        	//for( int k=0;  k < certiReportUser.size(); k++ ) {
            	//CommonUtils.printMap(certiReportUser.get(k));
            //}
        //}
        
        model.addAttribute("certiReportUser", certiReportUser);
        //담당자 자격증(손해사정사) 정보 List 만들기 끝
        
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("rptIssueMain", rptIssueMain);
        model.addAttribute("reportTeamInfo", reportTeamInfo);
        model.addAttribute("reportInvgUser", reportInvgUser);
        
        //model.addAttribute("rptIssue", rptIssue);
        model.addAttribute("rptIssueSendList", rptIssueSendList);
        
        model.addAttribute("suim_rpt_type1", suim_rpt_type1);
        model.addAttribute("ptnr_mbr_nm", ptnr_mbr_nm);
        model.addAttribute("suimVO", suimVo);
        
        boolean sendChk = false;		//손해 사정서 발송 플래그 (발송한 건이 한건이상있는 경우 true)        
        
        for( Map<String, Object> map : rptIssueSendList ) {        	
        	for( Map.Entry<String, Object> entry : map.entrySet() ) {
        		if( entry.getKey().equals("sendState") ) {
        			if( entry.getValue().toString().equals("1") ) {		//발송완료건으로 처리        				
        				sendChk = true;
        				break;
        			}
        		}
        	}        		
        }        
        
        //System.out.println("sendChk="+sendChk);
        //해당건에 대한 발송여부를 파라미터 추가
        model.addAttribute("sendChk", sendChk);		// true : 발송완료, false : 발송건 없음
                
        //DB 에 저장된 작성일자가 없으면 시스템 시간으로 넣어주고 DB 에 값이 있으면 그값으로 넣어준다. by top3009
        if( rptIssue.get("writeDate") == null ) {
        	String sNow = DateUtil.getTodayString();
            sNow = DateUtil.getDateFormat(sNow, "-");
            model.addAttribute("nowdate", sNow);
        }else {
        	model.addAttribute("nowdate", rptIssue.get("writeDate").toString());
        }        
        //DB 에 저장된 작성일자가 없으면 시스템 시간으로 넣어주고 DB 에 값이 있으면 그값으로 넣어준다. by oniku
        
        //today 시간설정 시작
        Calendar cal = Calendar.getInstance();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
        String sToday = df.format(cal.getTime());
        
        model.addAttribute("sToday", sToday);		//현재시간 추가
        //today 시간설정 끝
        
        //워드 또는 출력시에도 보냈는지 여부 체크
        if( !sendChk ) {		//보내지 않았을때는 오늘 날짜로 셋팅
        	rptIssue.put("writeDateFmt", sToday);
        }
        
        model.addAttribute("rptIssue", rptIssue);
        
        //출력인경우 Ajax 로 가져오는 부분을 Control에서 불러온다.
        if( "word".equals(cmd) || "print".equals(cmd) || "report".equals(cmd) ) {        	
        	Map<String, Object> lawEtcContentMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawContentInfo", paramMap);
        	model.addAttribute("lawEtcContentInfo", lawEtcContentMap);
        	
        	Map<String, Object> lawReasonMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawReasonInfo", paramMap);
        	model.addAttribute("lawReasonInfo", lawReasonMap);

        	Map<String, Object> lawSelContentMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawSelInfo", paramMap);
        	model.addAttribute("lawSelContentInfo", lawSelContentMap);
        	
        	//메리츠 담보목록 정보 가져오기
        	List<Map<String, Object>> coverageInfoList = sqlSession.selectList("RptIssueMapper.selectReportMeritzCoverageInfo", paramMap);
        	model.addAttribute("coverageInfoList", coverageInfoList);
        }
        
        String retURL = "top_suim_reportissue/rpt_issue_meritz";

        if ("word".equals(cmd)){
            retURL = "top_suim_reportissue/rpt_issue_meritz_word";
        }else if("print".equals(cmd)){
            retURL = "top_suim_reportissue/rpt_issue_meritz_print";
        }else if("report".equals(cmd)) {
        	retURL = "top_suim_reportissue/rpt_issue_meritz_report";
        }

        System.out.println("retURL:["+retURL+"]");

        return retURL;
    }
        
    
    @RequestMapping(value = "/reportIssueAbl")
    public String reportIssueAbl(HttpServletRequest request, Model model){

    	logger.info("======== reportIssueAbl ========");
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String suim_rpt_type1 = request.getParameter("suim_rpt_type1");
        String ptnr_mbr_nm = request.getParameter("ptnr_mbr_nm");
        String cmd = StringUtil.null2blank(request.getParameter("cmd"));
        //===============================================
        // 비즈니스 로직
        //===============================================
        
        int nRptCnt = sqlSession.selectOne("RptIssueMapper.selectRptIssueCnt", paramMap);
        
        //if (rptIssueisExist == null){
        if (nRptCnt == 0){
            sqlSession.insert("RptIssueMapper.insertRptIssueForExist", paramMap);
        }
        
        //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);

        //담당팀 기본정보 가져오기
        paramMap.put("team_id", rptIssueMain.get("teamId"));
        Map<String, Object> reportTeamInfo = sqlSession.selectOne("SuimReportMapper.selectSuimReportTeam", paramMap);

        //조사자 정보
        paramMap.put("user_no", rptIssueMain.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
        
        //세부정보 가져오기
        SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);

        //================================================================
        //  손해사정서 교부 기본정보
        //================================================================
        // 손해사정서 교부 기본정보가 있는지 확인 없으면 기본입력
        //Map<String, Object> rptIssueisExist = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        List<Map<String, Object>> rptIssueSendList = sqlSession.selectList("RptIssueMapper.selectRptIssueSend", paramMap);
        
        String sTemp = "";		//임시메시지키
        String sRet = "";			//임시상태리턴값
        String dCode = "";		//임시코드
        String dMessage = "";	//임시메시지
        String dErrinfo = "";
        String dUflag = "";
        String chkRet = "";
        
        //발송된 메시지 상태값 확인
        for( Map<String, Object > params : rptIssueSendList) {
        	if( params.get("sendState").toString().equals("2") ) {			//대기중인 상태
        		//대기중인 메시지 키로 kakao 에 상태값을 읽어온다.
        		sTemp = params.get("msgid").toString();        		
        		sRet = sendKakaoResult(sTemp);
        		chkRet = sRet.substring(0, 4);
        		
        		if( sRet.equals("M000") || sRet.equals("K000") || sRet.equals("R000") ) {		//발송 성공
        			//발송 상태값을 발송 완료로 바꾸어 준다.        			
        			paramMap.put("msgid", sTemp);
        			paramMap.put("send_state", 1);
        			sqlSession.update("RptIssueMapper.updateRptIssueSendMagStateOk",paramMap);
        		}else if( chkRet.equals("M001")  ){			//대기중 인경우
        			try {
        				dCode = sRet.substring(0,1);
            			dMessage = sRet.substring(1,4);
            			
            			//에러 코드를 bizm_error 테이블에서 가져온다.
            			paramMap.put("ecode", dCode);
            			paramMap.put("emessage", dMessage);
            			
            			Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            			
            			dErrinfo = errorMsg.get("errinfo").toString();
            			dUflag = errorMsg.get("uflag").toString();

            			if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            				params.put("stateMsg", dErrinfo);
            			}else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            				params.put("stateMsg", sRet);
            			}
					} catch (Exception e) {
						params.put("stateMsg", "전송대기중 입니다.");
					}        			        			       			
        		}else {			//실패한 경우
        			//발송 상태값을 발송 실패로 바꾸어 준다.
        			//System.out.println("oniku실패체크 : "+sTemp+" : "+chkRet);        			
        			paramMap.put("msgid", sTemp);
        			paramMap.put("send_state", 0);
        			sqlSession.update("RptIssueMapper.updateRptIssueSendMagStateOk",paramMap);
        			
        			try {        				
        				dCode = sRet.substring(0,1);
            			dMessage = sRet.substring(1,4);
            			
            			//에러 코드를 bizm_error 테이블에서 가져온다.
            			paramMap.put("ecode", dCode);
            			paramMap.put("emessage", dMessage);
            			
            			Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            			
            			dErrinfo = errorMsg.get("errinfo").toString();
            			dUflag = errorMsg.get("uflag").toString();

            			if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            				params.put("stateMsg", dErrinfo);
            			}else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            				params.put("stateMsg", sRet);
            			}
					} catch (Exception e) {
						params.put("stateMsg", "발송실패");
					} 
        		}
        	}else if( params.get("sendState").toString().equals("0") ){
        		try {
        			//실패한 메시지 키로 kakao 에 상태값을 읽어온다.
            		sTemp = params.get("msgid").toString();
            		sRet = sendKakaoResult(sTemp);
            		
            		if( sRet.equals("M000") || sRet.equals("K000") || sRet.equals("R000") ) {		//발송 성공
            			//발송 상태값을 발송 완료로 바꾸어 준다.        			
            			paramMap.put("msgid", sTemp);
            			paramMap.put("send_state", 1);
            			sqlSession.update("RptIssueMapper.updateRptIssueSendMagStateOk",paramMap);
            		}else if( sRet.equals("M001") ){
            			params.put("stateMsg", "전송대기중 입니다.");            			
            		}else if( sRet.startsWith("E110") || sRet.equals(" ") ){
            			params.put("stateMsg", "잠시 기다려주세요.");
            		}else {
            			dCode = sRet.substring(0,1);
            			dMessage = sRet.substring(1,4);
            			
            			//에러 코드를 bizm_error 테이블에서 가져온다.
            			paramMap.put("ecode", dCode);
            			paramMap.put("emessage", dMessage);
            			
            			Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            			
            			dErrinfo = errorMsg.get("errinfo").toString();
            			dUflag = errorMsg.get("uflag").toString();

            			if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            				params.put("stateMsg", dErrinfo);
            			}else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            				params.put("stateMsg", sRet);
            			}            			
            		}
				} catch (Exception e) {
					params.put("stateMsg", "발송결과 확인중 입니다.");
				}        		
        	}
        }
        
        //담당자 자격증(손해사정사) 정보 List 만들기 시작
        List<Map<String, Object>> certiReportUser = null;					//보고서 하단에 들어갈 담당자 정보 List
        List<Map<String, Object>> certiManagerReportUser = null;		//담당손해사정사 목록

        //System.out.println(":::::::::::: certiReportUser : "+String.valueOf(paramMap.get("user_no")));

        String sUserNo = String.valueOf(paramMap.get("user_no"));

        //기 종결건은 담당손해사정사가 별도 저장되어있음 (top_rpt_certi_end) 저장된 손해사정사 정보가 별도로 있는지 체크
        int nEndCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiEndCnt",paramMap);

        if( nEndCnt == 0 ) {			//정보가 없는 경우 실시간으로 가져온다.
        	
        	if( !"0".equals(sUserNo) ) {		//0은 미배당건        	
        	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiMemberInfo", paramMap);
        	
        	int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
        	
        	nCertiManagerCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiManagerCnt", paramMap);
        	
        	if( nCertiManagerCnt > 0 ) {			//담당손해사정사가 있는 경우
        		certiManagerReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiManagerList", paramMap);
        		for( int i=0; i < certiManagerReportUser.size(); i++) {
        			certiReportUser.add(certiManagerReportUser.get(i));		//보고서 하단에 들어갈 담당자 정보에 담당손해사정서를 추가한다.
        		}
        	}
            }
        	
        }else{								//정보가 있는 경우 top_rpt_certi_end 테이블에서 불러온다.
        	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiEndInfo", paramMap);
        }

        model.addAttribute("certiReportUser", certiReportUser);
        //담당자 자격증(손해사정사) 정보 List 만들기 끝
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("rptIssueMain", rptIssueMain);
        model.addAttribute("reportTeamInfo", reportTeamInfo);
        model.addAttribute("reportInvgUser", reportInvgUser);
        
        //model.addAttribute("rptIssue", rptIssue);
        model.addAttribute("rptIssueSendList", rptIssueSendList);
        
        model.addAttribute("suim_rpt_type1", suim_rpt_type1);
        model.addAttribute("ptnr_mbr_nm", ptnr_mbr_nm);
        model.addAttribute("suimVO", suimVo);
        
        boolean sendChk = false;		//손해 사정서 발송 플래그 (발송한 건이 한건이상있는 경우 true)        
        
        for( Map<String, Object> map : rptIssueSendList ) {        	
        	for( Map.Entry<String, Object> entry : map.entrySet() ) {
        		if( entry.getKey().equals("sendState") ) {
        			if( entry.getValue().toString().equals("1") ) {		//발송완료건으로 처리        				
        				sendChk = true;
        				break;
        			}
        		}
        	}        		
        }        
        
        //System.out.println("sendChk="+sendChk);
        //해당건에 대한 발송여부를 파라미터 추가
        model.addAttribute("sendChk", sendChk);		// true : 발송완료, false : 발송건 없음
                
        //DB 에 저장된 작성일자가 없으면 시스템 시간으로 넣어주고 DB 에 값이 있으면 그값으로 넣어준다. by top3009
        if( rptIssue.get("writeDate") == null ) {
        	String sNow = DateUtil.getTodayString();
            sNow = DateUtil.getDateFormat(sNow, "-");
            model.addAttribute("nowdate", sNow);
        }else {
        	model.addAttribute("nowdate", rptIssue.get("writeDate").toString());
        }        
        //DB 에 저장된 작성일자가 없으면 시스템 시간으로 넣어주고 DB 에 값이 있으면 그값으로 넣어준다. by oniku
        
        //today 시간설정 시작
        Calendar cal = Calendar.getInstance();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
        String sToday = df.format(cal.getTime());
        
        model.addAttribute("sToday", sToday);		//현재시간 추가
        //today 시간설정 끝
        
        //워드 또는 출력시에도 보냈는지 여부 체크
        if( !sendChk ) {		//보내지 않았을때는 오늘 날짜로 셋팅
        	rptIssue.put("writeDateFmt", sToday);
        }
        
        model.addAttribute("rptIssue", rptIssue);
        
        String retURL = "top_suim_reportissue/rpt_issue_abl_main";

        if ("word".equals(cmd)){
            retURL = "top_suim_reportissue/rpt_issue_main_abl_word";
        }else if("print".equals(cmd)){
            retURL = "top_suim_reportissue/rpt_issue_main_abl_print";
        }else if("report".equals(cmd)) {
        	retURL = "top_suim_reportissue/rpt_issue_main_abl_report";
        }

        System.out.println("retURL:["+retURL+"]");

        return retURL;
    }
    
    @RequestMapping(value = "/reportIssueMain")
    public String reportIssueMain(HttpServletRequest request, Model model){

    	logger.info("======== reportIssueMain ========");
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String suim_rpt_type1 = request.getParameter("suim_rpt_type1");
        String ptnr_mbr_nm = request.getParameter("ptnr_mbr_nm");
        String cmd = StringUtil.null2blank(request.getParameter("cmd"));
        //===============================================
        // 비즈니스 로직
        //===============================================
        
        int nRptCnt = sqlSession.selectOne("RptIssueMapper.selectRptIssueCnt", paramMap);
        
        //if (rptIssueisExist == null){
        if (nRptCnt == 0){
            sqlSession.insert("RptIssueMapper.insertRptIssueForExist", paramMap);
        }
        
        //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);

        //담당팀 기본정보 가져오기
        paramMap.put("team_id", rptIssueMain.get("teamId"));
        Map<String, Object> reportTeamInfo = sqlSession.selectOne("SuimReportMapper.selectSuimReportTeam", paramMap);

        //조사자 정보
        paramMap.put("user_no", rptIssueMain.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
        
        //세부정보 가져오기
        SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);

        //================================================================
        //  손해사정서 교부 기본정보
        //================================================================
        // 손해사정서 교부 기본정보가 있는지 확인 없으면 기본입력
        //Map<String, Object> rptIssueisExist = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        List<Map<String, Object>> rptIssueSendList = sqlSession.selectList("RptIssueMapper.selectRptIssueSend", paramMap);
        
        String sTemp = "";		//임시메시지키
        String sRet = "";			//임시상태리턴값
        String dCode = "";		//임시코드
        String dMessage = "";	//임시메시지
        String dErrinfo = "";
        String dUflag = "";
        String chkRet = "";
        
        //발송된 메시지 상태값 확인
        for( Map<String, Object > params : rptIssueSendList) {
        	if( params.get("sendState").toString().equals("2") ) {			//대기중인 상태
        		//대기중인 메시지 키로 kakao 에 상태값을 읽어온다.
        		sTemp = params.get("msgid").toString();        		
        		sRet = sendKakaoResult(sTemp);
        		chkRet = sRet.substring(0, 4);
        		
        		if( sRet.equals("M000") || sRet.equals("K000") || sRet.equals("R000") ) {		//발송 성공
        			//발송 상태값을 발송 완료로 바꾸어 준다.        			
        			paramMap.put("msgid", sTemp);
        			paramMap.put("send_state", 1);
        			sqlSession.update("RptIssueMapper.updateRptIssueSendMagStateOk",paramMap);
        		}else if( chkRet.equals("M001")  ){			//대기중 인경우
        			try {
        				dCode = sRet.substring(0,1);
            			dMessage = sRet.substring(1,4);
            			
            			//에러 코드를 bizm_error 테이블에서 가져온다.
            			paramMap.put("ecode", dCode);
            			paramMap.put("emessage", dMessage);
            			
            			Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            			
            			dErrinfo = errorMsg.get("errinfo").toString();
            			dUflag = errorMsg.get("uflag").toString();

            			if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            				params.put("stateMsg", dErrinfo);
            			}else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            				params.put("stateMsg", sRet);
            			}
					} catch (Exception e) {
						params.put("stateMsg", "전송대기중 입니다.");
					}        			        			       			
        		}else {			//실패한 경우
        			//발송 상태값을 발송 실패로 바꾸어 준다.
        			//System.out.println("oniku실패체크 : "+sTemp+" : "+chkRet);        			
        			paramMap.put("msgid", sTemp);
        			paramMap.put("send_state", 0);
        			sqlSession.update("RptIssueMapper.updateRptIssueSendMagStateOk",paramMap);
        			
        			try {        				
        				dCode = sRet.substring(0,1);
            			dMessage = sRet.substring(1,4);
            			
            			//에러 코드를 bizm_error 테이블에서 가져온다.
            			paramMap.put("ecode", dCode);
            			paramMap.put("emessage", dMessage);
            			
            			Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            			
            			dErrinfo = errorMsg.get("errinfo").toString();
            			dUflag = errorMsg.get("uflag").toString();

            			if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            				params.put("stateMsg", dErrinfo);
            			}else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            				params.put("stateMsg", sRet);
            			}
					} catch (Exception e) {
						params.put("stateMsg", "발송실패");
					} 
        		}
        	}else if( params.get("sendState").toString().equals("0") ){
        		try {
        			//실패한 메시지 키로 kakao 에 상태값을 읽어온다.
            		sTemp = params.get("msgid").toString();
            		sRet = sendKakaoResult(sTemp);
            		
            		if( sRet.equals("M000") || sRet.equals("K000") || sRet.equals("R000") ) {		//발송 성공
            			//발송 상태값을 발송 완료로 바꾸어 준다.        			
            			paramMap.put("msgid", sTemp);
            			paramMap.put("send_state", 1);
            			sqlSession.update("RptIssueMapper.updateRptIssueSendMagStateOk",paramMap);
            		}else if( sRet.equals("M001") ){
            			params.put("stateMsg", "전송대기중 입니다.");            			
            		}else if( sRet.startsWith("E110") || sRet.equals(" ") ){
            			params.put("stateMsg", "잠시 기다려주세요.");
            		}else {
            			dCode = sRet.substring(0,1);
            			dMessage = sRet.substring(1,4);
            			
            			//에러 코드를 bizm_error 테이블에서 가져온다.
            			paramMap.put("ecode", dCode);
            			paramMap.put("emessage", dMessage);
            			
            			Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            			
            			dErrinfo = errorMsg.get("errinfo").toString();
            			dUflag = errorMsg.get("uflag").toString();

            			if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            				params.put("stateMsg", dErrinfo);
            			}else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            				params.put("stateMsg", sRet);
            			}            			
            		}
				} catch (Exception e) {
					params.put("stateMsg", "발송결과 확인중 입니다.");
				}        		
        	}
        }
        
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("rptIssueMain", rptIssueMain);
        model.addAttribute("reportTeamInfo", reportTeamInfo);
        model.addAttribute("reportInvgUser", reportInvgUser);
        
        //model.addAttribute("rptIssue", rptIssue);
        model.addAttribute("rptIssueSendList", rptIssueSendList);
        
        model.addAttribute("suim_rpt_type1", suim_rpt_type1);
        model.addAttribute("ptnr_mbr_nm", ptnr_mbr_nm);
        model.addAttribute("suimVO", suimVo);
        
        boolean sendChk = false;		//손해 사정서 발송 플래그 (발송한 건이 한건이상있는 경우 true)        
        
        for( Map<String, Object> map : rptIssueSendList ) {        	
        	for( Map.Entry<String, Object> entry : map.entrySet() ) {
        		if( entry.getKey().equals("sendState") ) {
        			if( entry.getValue().toString().equals("1") ) {		//발송완료건으로 처리        				
        				sendChk = true;
        				break;
        			}
        		}
        	}        		
        }        
        
        //System.out.println("sendChk="+sendChk);
        //해당건에 대한 발송여부를 파라미터 추가
        model.addAttribute("sendChk", sendChk);		// true : 발송완료, false : 발송건 없음
                
        //DB 에 저장된 작성일자가 없으면 시스템 시간으로 넣어주고 DB 에 값이 있으면 그값으로 넣어준다. by top3009
        if( rptIssue.get("writeDate") == null ) {
        	String sNow = DateUtil.getTodayString();
            sNow = DateUtil.getDateFormat(sNow, "-");
            model.addAttribute("nowdate", sNow);
        }else {
        	model.addAttribute("nowdate", rptIssue.get("writeDate").toString());
        }        
        //DB 에 저장된 작성일자가 없으면 시스템 시간으로 넣어주고 DB 에 값이 있으면 그값으로 넣어준다. by oniku
        
        //today 시간설정 시작
        Calendar cal = Calendar.getInstance();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
        String sToday = df.format(cal.getTime());
        
        model.addAttribute("sToday", sToday);		//현재시간 추가
        //today 시간설정 끝
        
        //워드 또는 출력시에도 보냈는지 여부 체크
        if( !sendChk ) {		//보내지 않았을때는 오늘 날짜로 셋팅
        	rptIssue.put("writeDateFmt", sToday);
        }
        
        model.addAttribute("rptIssue", rptIssue);
        
        String retURL = "top_suim_reportissue/rpt_issue_main";

        if ("word".equals(cmd)){
            retURL = "top_suim_reportissue/rpt_issue_main_word";
        }else if("print".equals(cmd)){
            retURL = "top_suim_reportissue/rpt_issue_main_print";
        }else if("report".equals(cmd)) {
        	retURL = "top_suim_reportissue/rpt_issue_main_report";
        }

        System.out.println("retURL:["+retURL+"]");

        return retURL;
    }
    
    /**
     * 이메일 발송방식 기본 손해사정서
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/reportIssueEmailMain")
    public String reportIssueEmailMain(HttpServletRequest request, Model model){

    	logger.info("======== reportIssueEmailMain ========");
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        String cmd = StringUtil.null2blank(request.getParameter("cmd"));
        
        int nRptCnt = sqlSession.selectOne("RptIssueMapper.selectRptIssueCnt", paramMap);
        
        //if (rptIssueisExist == null){
        if (nRptCnt == 0){
        	sqlSession.insert("RptIssueMapper.insertRptIssueForExist", paramMap);
        	//logger.info("insertRptIssueForExist=======이슈테이블에 추가====");
        }
        
        String retURL = "top_suim_reportissue/rpt_issue_email_main";

        if ("word".equals(cmd)){
            //retURL = "top_suim_reportissue/rpt_issue_main_new_word";
        }else if("print".equals(cmd)){
            //retURL = "top_suim_reportissue/rpt_issue_main_new_print";
        }else if("report".equals(cmd)) {
        	//retURL = "top_suim_reportissue/rpt_issue_main_new_report";
        }

        System.out.println("retURL:["+retURL+"]");

        return retURL;
    }
    
    /**
     * 신규 기본 손해사정서
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/reportIssueMainNew")
    public String reportIssueMainNew(HttpServletRequest request, Model model){

    	logger.info("======== reportIssueMainNew ========");
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String suim_rpt_type1 = request.getParameter("suim_rpt_type1");
        String ptnr_mbr_nm = request.getParameter("ptnr_mbr_nm");
        String cmd = StringUtil.null2blank(request.getParameter("cmd"));
        //===============================================
        // 비즈니스 로직
        //===============================================
        
        //손해사정서가 없는 경우 체크
        int nRptCnt = sqlSession.selectOne("RptIssueMapper.selectRptIssueCnt", paramMap);

        if (nRptCnt == 0){
        	sqlSession.insert("RptIssueMapper.insertRptIssueForExist", paramMap);
        }
        
        //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);

        //담당팀 기본정보 가져오기
        paramMap.put("team_id", rptIssueMain.get("teamId"));
        Map<String, Object> reportTeamInfo = sqlSession.selectOne("SuimReportMapper.selectSuimReportTeam", paramMap);

        //조사자 정보
        paramMap.put("user_no", rptIssueMain.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
        
        //세부정보 가져오기
        SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);
        
        //================================================================
        //  손해사정서 교부 기본정보
        //================================================================
        // 손해사정서 교부 기본정보가 있는지 확인 없으면 기본입력
        //Map<String, Object> rptIssueisExist = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        List<Map<String, Object>> rptIssueSendList = sqlSession.selectList("RptIssueMapper.selectRptIssueSend", paramMap);
        
        String sTemp = "";		//임시메시지키
        String sRet = "";			//임시상태리턴값
        String dCode = "";		//임시코드
        String dMessage = "";	//임시메시지
        String dErrinfo = "";
        String dUflag = "";
        String chkRet = "";
        
        //발송된 메시지 상태값 확인
        for( Map<String, Object > params : rptIssueSendList) {
        	if( params.get("sendState").toString().equals("2") ) {			//대기중인 상태
        		//대기중인 메시지 키로 kakao 에 상태값을 읽어온다.
        		sTemp = params.get("msgid").toString();        		
        		sRet = sendKakaoResult(sTemp);
        		chkRet = sRet.substring(0, 4);
        		
        		if( sRet.equals("M000") || sRet.equals("K000") || sRet.equals("R000") ) {		//발송 성공
        			//발송 상태값을 발송 완료로 바꾸어 준다.        			
        			paramMap.put("msgid", sTemp);
        			paramMap.put("send_state", 1);
        			sqlSession.update("RptIssueMapper.updateRptIssueSendMagStateOk",paramMap);
        		}else if( chkRet.equals("M001")  ){			//대기중 인경우
        			try {
        				dCode = sRet.substring(0,1);
            			dMessage = sRet.substring(1,4);
            			
            			//에러 코드를 bizm_error 테이블에서 가져온다.
            			paramMap.put("ecode", dCode);
            			paramMap.put("emessage", dMessage);
            			
            			Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            			
            			dErrinfo = errorMsg.get("errinfo").toString();
            			dUflag = errorMsg.get("uflag").toString();

            			if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            				params.put("stateMsg", dErrinfo);
            			}else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            				params.put("stateMsg", sRet);
            			}
					} catch (Exception e) {
						params.put("stateMsg", "전송대기중 입니다.");
					}        			        			       			
        		}else {			//실패한 경우
        			//발송 상태값을 발송 실패로 바꾸어 준다.
        			//System.out.println("oniku실패체크 : "+sTemp+" : "+chkRet);        			
        			paramMap.put("msgid", sTemp);
        			paramMap.put("send_state", 0);
        			sqlSession.update("RptIssueMapper.updateRptIssueSendMagStateOk",paramMap);
        			
        			try {        				
        				dCode = sRet.substring(0,1);
            			dMessage = sRet.substring(1,4);
            			
            			//에러 코드를 bizm_error 테이블에서 가져온다.
            			paramMap.put("ecode", dCode);
            			paramMap.put("emessage", dMessage);
            			
            			Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            			
            			dErrinfo = errorMsg.get("errinfo").toString();
            			dUflag = errorMsg.get("uflag").toString();

            			if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            				params.put("stateMsg", dErrinfo);
            			}else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            				params.put("stateMsg", sRet);
            			}
					} catch (Exception e) {
						params.put("stateMsg", "발송실패");
					} 
        		}
        	}else if( params.get("sendState").toString().equals("0") ){
        		try {
        			//실패한 메시지 키로 kakao 에 상태값을 읽어온다.
            		sTemp = params.get("msgid").toString();
            		sRet = sendKakaoResult(sTemp);
            		
            		if( sRet.equals("M000") || sRet.equals("K000") || sRet.equals("R000") ) {		//발송 성공
            			//발송 상태값을 발송 완료로 바꾸어 준다.        			
            			paramMap.put("msgid", sTemp);
            			paramMap.put("send_state", 1);
            			sqlSession.update("RptIssueMapper.updateRptIssueSendMagStateOk",paramMap);
            		}else if( sRet.equals("M001") ){
            			params.put("stateMsg", "전송대기중 입니다.");            			
            		}else if( sRet.startsWith("E110") || sRet.equals(" ") ){
            			params.put("stateMsg", "잠시 기다려주세요.");
            		}else {
            			dCode = sRet.substring(0,1);
            			dMessage = sRet.substring(1,4);
            			
            			//에러 코드를 bizm_error 테이블에서 가져온다.
            			paramMap.put("ecode", dCode);
            			paramMap.put("emessage", dMessage);
            			
            			Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            			
            			dErrinfo = errorMsg.get("errinfo").toString();
            			dUflag = errorMsg.get("uflag").toString();

            			if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            				params.put("stateMsg", dErrinfo);
            			}else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            				params.put("stateMsg", sRet);
            			}            			
            		}
				} catch (Exception e) {
					params.put("stateMsg", "발송결과 확인중 입니다.");
				}        		
        	}
        }
        
        //담당자 자격증(손해사정사) 정보 List 만들기 시작
        List<Map<String, Object>> certiReportUser = null;					//보고서 하단에 들어갈 담당자 정보 List
        List<Map<String, Object>> certiManagerReportUser = null;		//담당손해사정사 목록
        
        //System.out.println(":::::::::::: certiReportUser : "+String.valueOf(paramMap.get("user_no")));
        
        String sUserNo = String.valueOf(paramMap.get("user_no"));
        
        //기 종결건은 담당손해사정사가 별도 저장되어있음 (top_rpt_certi_end) 저장된 손해사정사 정보가 별도로 있는지 체크
        int nEndCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiEndCnt",paramMap);
        
        if( nEndCnt == 0 ) {			//정보가 없는 경우 실시간으로 가져온다.
        	
        	if( !"0".equals(sUserNo) ) {		//0은 미배당건        	
            	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiMemberInfo", paramMap);
            	
            	int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
            	
            	nCertiManagerCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiManagerCnt", paramMap);
            	
            	//System.out.println("nCertiManagerCnt : "+nCertiManagerCnt);
            	
            	if( nCertiManagerCnt > 0 ) {			//담당손해사정사가 있는 경우
            		certiManagerReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiManagerList", paramMap);
            		for( int i=0; i < certiManagerReportUser.size(); i++) {
            			certiReportUser.add(certiManagerReportUser.get(i));		//보고서 하단에 들어갈 담당자 정보에 담당손해사정서를 추가한다.
            		}
            	}
            }
        	
        }else{								//정보가 있는 경우 top_rpt_certi_end 테이블에서 불러온다.
        	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiEndInfo", paramMap);
        }
        
        //if( certiReportUser != null ) {
        	//for( int k=0;  k < certiReportUser.size(); k++ ) {
            	//CommonUtils.printMap(certiReportUser.get(k));
            //}
        //}
        
        model.addAttribute("certiReportUser", certiReportUser);
        //담당자 자격증(손해사정사) 정보 List 만들기 끝
        
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("rptIssueMain", rptIssueMain);
        model.addAttribute("reportTeamInfo", reportTeamInfo);
        model.addAttribute("reportInvgUser", reportInvgUser);
        
        //model.addAttribute("rptIssue", rptIssue);
        model.addAttribute("rptIssueSendList", rptIssueSendList);
        
        model.addAttribute("suim_rpt_type1", suim_rpt_type1);
        model.addAttribute("ptnr_mbr_nm", ptnr_mbr_nm);
        model.addAttribute("suimVO", suimVo);
        
        boolean sendChk = false;		//손해 사정서 발송 플래그 (발송한 건이 한건이상있는 경우 true)        
        
        for( Map<String, Object> map : rptIssueSendList ) {        	
        	for( Map.Entry<String, Object> entry : map.entrySet() ) {
        		if( entry.getKey().equals("sendState") ) {
        			if( entry.getValue().toString().equals("1") ) {		//발송완료건으로 처리        				
        				sendChk = true;
        				break;
        			}
        		}
        	}        		
        }        
        
        //System.out.println("sendChk="+sendChk);
        //해당건에 대한 발송여부를 파라미터 추가
        model.addAttribute("sendChk", sendChk);		// true : 발송완료, false : 발송건 없음
                
        //DB 에 저장된 작성일자가 없으면 시스템 시간으로 넣어주고 DB 에 값이 있으면 그값으로 넣어준다. by top3009
        if( rptIssue.get("writeDate") == null ) {
        	String sNow = DateUtil.getTodayString();
            sNow = DateUtil.getDateFormat(sNow, "-");
            model.addAttribute("nowdate", sNow);
        }else {
        	model.addAttribute("nowdate", rptIssue.get("writeDate").toString());
        }        
        //DB 에 저장된 작성일자가 없으면 시스템 시간으로 넣어주고 DB 에 값이 있으면 그값으로 넣어준다. by oniku
        
        //today 시간설정 시작
        Calendar cal = Calendar.getInstance();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
        String sToday = df.format(cal.getTime());
        
        model.addAttribute("sToday", sToday);		//현재시간 추가
        //today 시간설정 끝
        
        //워드 또는 출력시에도 보냈는지 여부 체크
        if( !sendChk ) {		//보내지 않았을때는 오늘 날짜로 셋팅
        	rptIssue.put("writeDateFmt", sToday);
        }
        
        model.addAttribute("rptIssue", rptIssue);
        
        //출력인경우 Ajax 로 가져오는 부분을 Control에서 불러온다.
        if( "word".equals(cmd) || "print".equals(cmd) || "report".equals(cmd) ) {        	
        	Map<String, Object> lawEtcContentMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawContentInfo", paramMap);
        	model.addAttribute("lawEtcContentInfo", lawEtcContentMap);
        	
        	Map<String, Object> lawReasonMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawReasonInfo", paramMap);
        	model.addAttribute("lawReasonInfo", lawReasonMap);

        	Map<String, Object> lawSelContentMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawSelInfo", paramMap);
        	model.addAttribute("lawSelContentInfo", lawSelContentMap);
        }
        
        String retURL = "top_suim_reportissue/rpt_issue_main_new";

        if ("word".equals(cmd)){
            retURL = "top_suim_reportissue/rpt_issue_main_new_word";
        }else if("print".equals(cmd)){
            retURL = "top_suim_reportissue/rpt_issue_main_new_print";
        }else if("report".equals(cmd)) {
        	retURL = "top_suim_reportissue/rpt_issue_main_new_report";
        }

        System.out.println("retURL:["+retURL+"]");

        return retURL;
    }
    
    /*
	 * ***************************************
	 * Method ID : rptIssueFileDel
	 * Method Name :  rptIssueFileDel
	 * Description : 손해사정서 동의서 원본 파일 삭제
	 * 번호 1 : 
	 * Author : 장원익
	 * Date : 20160621
	 * ***************************************
	 * */
	@RequestMapping(value = "rptIssueFileDel", method = RequestMethod.POST)
	public void rptIssueFileDel(String serialNo, PrintWriter out) {
		
		logger.info("rptIssueFileDel");
		
		//String path = "D:/home/hosting_users/toplac/www"+sqlSession.selectOne("SuimBookUdtMapper.getRptIssueFilePathForDel", serialNo);
		String path = "/home/hosting_users/toplac/www"+sqlSession.selectOne("SuimBookUdtMapper.getRptIssueFilePathForDel", serialNo);
		
		String fileforder = path.substring(0, path.lastIndexOf("/"));
		
		int result = 0;
		
		//파일 삭제 시작
		if(!fileforder.equals("")){
			
			File file = new File(path);
			File dir = new File(fileforder);
			file.delete();
			dir.delete();
			
			result = 1;
		}
		//파일 삭제 종료
		
		sqlSession.selectOne("SuimBookUdtMapper.delRptIssueFile", serialNo);
		
		out.print(result);
		out.close();
	}
	
	@RequestMapping(value = "/reportIssueHeungkukJemul")
    public String reportIssueHeungkukJemul(HttpServletRequest request, Model model, HttpSession session){

    	logger.info("======== reportIssueHeungkukJemul ========");
        //===============================================
        //	파라미터 체크
        //===============================================
    	
    	String cmd = StringUtil.null2blank(request.getParameter("cmd"));
    	String sCtype = request.getParameter("ctype");				//보험타입구분 ( C: 재물보험, B: 배상책임보험, I:인보험 )    	
    	
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        
        int nRptCnt = sqlSession.selectOne("RptIssueMapper.selectRptIssueCnt", paramMap);
        
        //if (rptIssueisExist == null){
        if (nRptCnt == 0){
        	sqlSession.insert("RptIssueMapper.insertRptIssueForExist", paramMap);
        	//logger.info("insertRptIssueForExist=======이슈테이블에 추가====");
        }
                
        //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);

        //담당팀 기본정보 가져오기
        paramMap.put("team_id", rptIssueMain.get("teamId"));
        Map<String, Object> reportTeamInfo = sqlSession.selectOne("SuimReportMapper.selectSuimReportTeam", paramMap);

        //조사자 정보
        paramMap.put("user_no", rptIssueMain.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
        
        //세부정보가져오기
        //SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", suim_rpt_no);
        SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);
        
        //출력시 계약자 피보험자 이름 두번째 글자 '*' 처리        
        String sHiddenPolicyNm = suimVo.getPolicyholder_nm().toString();
        String sHiddenBenefitNm = suimVo.getBeneficiary_nm().toString();        

        if( !sHiddenPolicyNm.equals("") ) {        	
        	if( sHiddenPolicyNm.length() == 1 ) {
        		sHiddenPolicyNm = "*";
        	}else {
        		sHiddenPolicyNm = sHiddenPolicyNm.replace(sHiddenPolicyNm.charAt(1),'*');
        	}        	        	
        }else {
        	sHiddenPolicyNm = "";
        }

        if( !sHiddenBenefitNm.equals("") ) {
        	if( sHiddenBenefitNm.length() == 1 ) {
        		sHiddenBenefitNm = "*";
        	}else {
        		sHiddenBenefitNm = sHiddenBenefitNm.replace(sHiddenBenefitNm.charAt(1),'*');
        	}        	
        }else {
        	sHiddenBenefitNm = "";
        }
        
        //================================================================
        //  손해사정서 교부 기본정보
        //================================================================
        // 손해사정서 교부 기본정보가 있는지 확인 없으면 기본입력
        //Map<String, Object> rptIssueisExist = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        List<Map<String, Object>> rptIssueSendList = sqlSession.selectList("RptIssueMapper.selectRptIssueSend", paramMap);
        
        String sTemp = "";		//임시메시지키
        String sRet = "";			//임시상태리턴값
        String dCode = "";		//임시코드
        String dMessage = "";	//임시메시지
        String dErrinfo = "";
        String dUflag = "";
        String chkRet = "";
        
        //발송된 메시지 상태값 확인
        for( Map<String, Object > params : rptIssueSendList) {
        	if( params.get("sendState").toString().equals("2") ) {			//대기중인 상태
        		//대기중인 메시지 키로 kakao 에 상태값을 읽어온다.
        		sTemp = params.get("msgid").toString();        		
        		sRet = sendKakaoResult(sTemp);
        		chkRet = sRet.substring(0, 4);
        		
        		if( sRet.equals("M000") || sRet.equals("K000") || sRet.equals("R000") ) {		//발송 성공
        			//발송 상태값을 발송 완료로 바꾸어 준다.        			
        			paramMap.put("msgid", sTemp);
        			paramMap.put("send_state", 1);
        			sqlSession.update("RptIssueMapper.updateRptIssueSendMagStateOk",paramMap);
        		}else if( chkRet.equals("M001")  ){			//대기중 인경우
        			try {
        				dCode = sRet.substring(0,1);
            			dMessage = sRet.substring(1,4);
            			
            			//에러 코드를 bizm_error 테이블에서 가져온다.
            			paramMap.put("ecode", dCode);
            			paramMap.put("emessage", dMessage);
            			
            			Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            			
            			dErrinfo = errorMsg.get("errinfo").toString();
            			dUflag = errorMsg.get("uflag").toString();

            			if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            				params.put("stateMsg", dErrinfo);
            			}else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            				params.put("stateMsg", sRet);
            			}
					} catch (Exception e) {
						params.put("stateMsg", "전송대기중 입니다.");
					}        			        			       			
        		}else {			//실패한 경우
        			//발송 상태값을 발송 실패로 바꾸어 준다.
        			//System.out.println("oniku실패체크 : "+sTemp+" : "+chkRet);        			
        			paramMap.put("msgid", sTemp);
        			paramMap.put("send_state", 0);
        			sqlSession.update("RptIssueMapper.updateRptIssueSendMagStateOk",paramMap);
        			
        			try {        				
        				dCode = sRet.substring(0,1);
            			dMessage = sRet.substring(1,4);
            			
            			//에러 코드를 bizm_error 테이블에서 가져온다.
            			paramMap.put("ecode", dCode);
            			paramMap.put("emessage", dMessage);
            			
            			Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            			
            			dErrinfo = errorMsg.get("errinfo").toString();
            			dUflag = errorMsg.get("uflag").toString();

            			if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            				params.put("stateMsg", dErrinfo);
            			}else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            				params.put("stateMsg", sRet);
            			}
					} catch (Exception e) {
						params.put("stateMsg", "발송실패");
					} 
        		}
        	}else if( params.get("sendState").toString().equals("0") ){
        		try {
        			//실패한 메시지 키로 kakao 에 상태값을 읽어온다.
            		sTemp = params.get("msgid").toString();
            		sRet = sendKakaoResult(sTemp);
            		
            		if( sRet.equals("M000") || sRet.equals("K000") || sRet.equals("R000") ) {		//발송 성공
            			//발송 상태값을 발송 완료로 바꾸어 준다.        			
            			paramMap.put("msgid", sTemp);
            			paramMap.put("send_state", 1);
            			sqlSession.update("RptIssueMapper.updateRptIssueSendMagStateOk",paramMap);
            		}else if( sRet.equals("M001") ){
            			params.put("stateMsg", "전송대기중 입니다.");            			
            		}else if( sRet.startsWith("E110") || sRet.equals(" ") ){
            			params.put("stateMsg", "잠시 기다려주세요.");
            		}else {
            			dCode = sRet.substring(0,1);
            			dMessage = sRet.substring(1,4);
            			
            			//에러 코드를 bizm_error 테이블에서 가져온다.
            			paramMap.put("ecode", dCode);
            			paramMap.put("emessage", dMessage);
            			
            			Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            			
            			dErrinfo = errorMsg.get("errinfo").toString();
            			dUflag = errorMsg.get("uflag").toString();

            			if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            				params.put("stateMsg", dErrinfo);
            			}else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            				params.put("stateMsg", sRet);
            			}            			
            		}
				} catch (Exception e) {
					params.put("stateMsg", "발송결과 확인중 입니다.");
				}        		
        	}
        }        
        
        List<Map<String, Object>> rptIssueContList = sqlSession.selectList("RptIssueMapper.selectRptIssueContLotte", paramMap);
        
        //총괄표 정보 가져오기
        List<Map<String, Object>> rptIssueSummaryList = sqlSession.selectList("RptIssueMapper.selectRptIssueSummaryLotte", paramMap);
        
        int rowSpan = rptIssueContList.size();
        
        if( rptIssue.get("writeDate") == null ) {
        	String sNow = DateUtil.getTodayString();
            sNow = DateUtil.getDateFormat(sNow, "-");
            model.addAttribute("nowdate", sNow);
        }else {
        	model.addAttribute("nowdate", rptIssue.get("writeDate").toString());
        }
        
        //today 시간설정 시작
        Calendar cal = Calendar.getInstance();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
        String sToday = df.format(cal.getTime());
        
        model.addAttribute("sToday", sToday);		//현재시간 추가
        //today 시간설정 끝
        
        //담당자 자격증(손해사정사) 정보 List 만들기 시작
        List<Map<String, Object>> certiReportUser = null;					//보고서 하단에 들어갈 담당자 정보 List
        List<Map<String, Object>> certiManagerReportUser = null;		//담당손해사정사 목록

        //System.out.println(":::::::::::: certiReportUser : "+String.valueOf(paramMap.get("user_no")));

        String sUserNo = String.valueOf(paramMap.get("user_no"));

        //기 종결건은 담당손해사정사가 별도 저장되어있음 (top_rpt_certi_end) 저장된 손해사정사 정보가 별도로 있는지 체크
        int nEndCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiEndCnt",paramMap);

        if( nEndCnt == 0 ) {			//정보가 없는 경우 실시간으로 가져온다.
        	
        	if( !"0".equals(sUserNo) ) {		//0은 미배당건        	
        	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiMemberInfo", paramMap);
        	
        	int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
        	
        	nCertiManagerCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiManagerCnt", paramMap);
        	
        	if( nCertiManagerCnt > 0 ) {			//담당손해사정사가 있는 경우
        		certiManagerReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiManagerList", paramMap);
        		for( int i=0; i < certiManagerReportUser.size(); i++) {
        			certiReportUser.add(certiManagerReportUser.get(i));		//보고서 하단에 들어갈 담당자 정보에 담당손해사정서를 추가한다.
        		}
        	}
            }
        	
        }else{								//정보가 있는 경우 top_rpt_certi_end 테이블에서 불러온다.
        	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiEndInfo", paramMap);
        }
        
        model.addAttribute("certiReportUser", certiReportUser);
        //담당자 자격증(손해사정사) 정보 List 만들기 끝
        
        /**
         * view페이지 셋팅
         */
        model.addAttribute("rptIssueMain", rptIssueMain);
        model.addAttribute("suimVO",suimVo);
        model.addAttribute("reportInvgUser", reportInvgUser);
        model.addAttribute("rptIssue", rptIssue);									//수임주소지로 인한 추가.
        model.addAttribute("rptIssueContList", rptIssueContList);				//보험목적물 추가.        
        model.addAttribute("cont_edit_type", paramMap.get("cont_edit_type"));		//ajax 에 보여줄 모드
        model.addAttribute("suim_rpt_no",paramMap.get("suim_rpt_no"));
        model.addAttribute("rowSpan", rowSpan);							//표에 들어가 rowSpan
        model.addAttribute("rptIssueSummaryList", rptIssueSummaryList);
        model.addAttribute("rptIssueSendList",rptIssueSendList);				//발송결과 목록
        model.addAttribute("sHiddenPolicyNm", sHiddenPolicyNm);			//계약자 두번째글자 가려진 이름
        model.addAttribute("sHiddenBenefitNm", sHiddenBenefitNm);		//피보험자 두번째글자 가려진 이름

        //합계값 셋팅
        long sum_joinPrice = 0;
        long sum_insuPrice = 0;
        long sum_lossPrice = 0;
        long sum_remainPrice = 0;
        long sum_responPrice = 0;        
        long sum_compLimitPrice = 0;
        long sum_compResponPrice = 0;      
        long sum_selfOptPrice = 0;
        long sum_netLossPrice = 0;
        long sum_lossCompPrice = 0;
        long sum_billPrice = 0;
        long sum_payPrice = 0;

        //합계 계산 로직 추가 by top3009        
        for( int i=0; i < rptIssueSummaryList.size(); i++ ) {
        	sum_joinPrice += Long.parseLong(rptIssueSummaryList.get(i).get("joinPrice").toString());
        	sum_insuPrice += Long.parseLong(rptIssueSummaryList.get(i).get("insuPrice").toString());
        	sum_lossPrice += Long.parseLong(rptIssueSummaryList.get(i).get("lossPrice").toString());
        	sum_remainPrice += Long.parseLong(rptIssueSummaryList.get(i).get("remainPrice").toString());
        	sum_responPrice += Long.parseLong(rptIssueSummaryList.get(i).get("responPrice").toString());
        	sum_netLossPrice += Long.parseLong(rptIssueSummaryList.get(i).get("netLossPrice").toString());		//삼성추가        	
        	sum_compLimitPrice += Long.parseLong(rptIssueSummaryList.get(i).get("compLimitPrice").toString());
        	sum_compResponPrice += Long.parseLong(rptIssueSummaryList.get(i).get("compResponPrice").toString());
        	sum_selfOptPrice += Long.parseLong(rptIssueSummaryList.get(i).get("selfOptPrice").toString());
        	sum_lossCompPrice += Long.parseLong(rptIssueSummaryList.get(i).get("lossCompPrice").toString());		//삼성추가
        	sum_billPrice += Long.parseLong(rptIssueSummaryList.get(i).get("billPrice").toString());		//삼성추가
        	sum_payPrice += Long.parseLong(rptIssueSummaryList.get(i).get("payPrice").toString());		//삼성추가        	
        }        

        model.addAttribute("sum_joinPrice", sum_joinPrice);
        model.addAttribute("sum_insuPrice", sum_insuPrice);
        model.addAttribute("sum_lossPrice", sum_lossPrice);
        model.addAttribute("sum_remainPrice", sum_remainPrice);
        model.addAttribute("sum_responPrice", sum_responPrice);
        model.addAttribute("sum_netLossPrice", sum_netLossPrice);
        model.addAttribute("sum_compLimitPrice", sum_compLimitPrice);
        model.addAttribute("sum_compResponPrice", sum_compResponPrice);
        model.addAttribute("sum_selfOptPrice", sum_selfOptPrice);
        model.addAttribute("sum_lossCompPrice", sum_lossCompPrice);
        model.addAttribute("sum_billPrice", sum_billPrice);
        model.addAttribute("sum_payPrice", sum_payPrice);
        
        //문서 타입지정
        model.addAttribute("ctype",sCtype);				//보험타입구분 ( C: 재물보험, B: 배상책임보험, I: 인보험 )
        
        String retURL = "top_suim_reportissue/rpt_issue_heungkuk_jemul";		//이동할 페이지
        
        if ("word".equals(cmd)){
            retURL = "top_suim_reportissue/rpt_issue_heungkuk_word";
        }else if("print".equals(cmd)){
            retURL = "top_suim_reportissue/rpt_issue_heungkuk_print";
        }else if("report".equals(cmd)) {
        	retURL = "top_suim_reportissue/rpt_issue_lotte_report";
        }
        
        System.out.println("retURL:["+retURL+"]");

        return retURL;
        
    }
	
	/**
	 * 악사손해보험 손해사정서 추가
	 * @param request
	 * @param model
	 * @param session
	 * @return
	 */
	
	@RequestMapping(value = "/reportIssueAxa")
    public String reportIssueAxa(HttpServletRequest request, Model model, HttpSession session){

    	logger.info("======== reportIssueAxa ========");
        //===============================================
        //	파라미터 체크
        //===============================================
    	
    	String cmd = StringUtil.null2blank(request.getParameter("cmd"));
    	String sCtype = request.getParameter("ctype");				//보험타입구분 ( C: 재물보험, B: 배상책임보험 )    	
    	
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        
        int nRptCnt = sqlSession.selectOne("RptIssueMapper.selectRptIssueCnt", paramMap);
        
        //if (rptIssueisExist == null){
        if (nRptCnt == 0){ 
        	sqlSession.insert("RptIssueMapper.insertRptIssueForExist", paramMap);
        	//logger.info("insertRptIssueForExist=======이슈테이블에 추가====");
        }
                
        //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);

        //담당팀 기본정보 가져오기
        paramMap.put("team_id", rptIssueMain.get("teamId"));
        Map<String, Object> reportTeamInfo = sqlSession.selectOne("SuimReportMapper.selectSuimReportTeam", paramMap);

        //조사자 정보
        paramMap.put("user_no", rptIssueMain.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
        
        //세부정보가져오기
        SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);
        
        //출력시 계약자 피보험자 이름 두번째 글자 '*' 처리        
        String sHiddenPolicyNm = suimVo.getPolicyholder_nm().toString();
        String sHiddenBenefitNm = suimVo.getBeneficiary_nm().toString();        

        if( !sHiddenPolicyNm.equals("") ) {        	
        	if( sHiddenPolicyNm.length() == 1 ) {
        		sHiddenPolicyNm = "*";
        	}else {
        		sHiddenPolicyNm = sHiddenPolicyNm.replace(sHiddenPolicyNm.charAt(1),'*');
        	}        	        	
        }else {
        	sHiddenPolicyNm = "";
        }

        if( !sHiddenBenefitNm.equals("") ) {
        	if( sHiddenBenefitNm.length() == 1 ) {
        		sHiddenBenefitNm = "*";
        	}else {
        		sHiddenBenefitNm = sHiddenBenefitNm.replace(sHiddenBenefitNm.charAt(1),'*');
        	}        	
        }else {
        	sHiddenBenefitNm = "";
        }
        
        //================================================================
        //  손해사정서 교부 기본정보
        //================================================================
        // 손해사정서 교부 기본정보가 있는지 확인 없으면 기본입력
        //Map<String, Object> rptIssueisExist = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        List<Map<String, Object>> rptIssueSendList = sqlSession.selectList("RptIssueMapper.selectRptIssueSend", paramMap);
        
        String sTemp = "";		//임시메시지키
        String sRet = "";			//임시상태리턴값
        String dCode = "";		//임시코드
        String dMessage = "";	//임시메시지
        String dErrinfo = "";
        String dUflag = "";
        String chkRet = "";
        
        //발송된 메시지 상태값 확인
        for( Map<String, Object > params : rptIssueSendList) {
        	if( params.get("sendState").toString().equals("2") ) {			//대기중인 상태
        		//대기중인 메시지 키로 kakao 에 상태값을 읽어온다.
        		sTemp = params.get("msgid").toString();        		
        		sRet = sendKakaoResult(sTemp);
        		chkRet = sRet.substring(0, 4);
        		
        		if( sRet.equals("M000") || sRet.equals("K000") || sRet.equals("R000") ) {		//발송 성공
        			//발송 상태값을 발송 완료로 바꾸어 준다.        			
        			paramMap.put("msgid", sTemp);
        			paramMap.put("send_state", 1);
        			sqlSession.update("RptIssueMapper.updateRptIssueSendMagStateOk",paramMap);
        		}else if( chkRet.equals("M001")  ){			//대기중 인경우
        			try {
        				dCode = sRet.substring(0,1);
            			dMessage = sRet.substring(1,4);
            			
            			//에러 코드를 bizm_error 테이블에서 가져온다.
            			paramMap.put("ecode", dCode);
            			paramMap.put("emessage", dMessage);
            			
            			Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            			
            			dErrinfo = errorMsg.get("errinfo").toString();
            			dUflag = errorMsg.get("uflag").toString();

            			if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            				params.put("stateMsg", dErrinfo);
            			}else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            				params.put("stateMsg", sRet);
            			}
					} catch (Exception e) {
						params.put("stateMsg", "전송대기중 입니다.");
					}        			        			       			
        		}else {			//실패한 경우
        			//발송 상태값을 발송 실패로 바꾸어 준다.
        			//System.out.println("oniku실패체크 : "+sTemp+" : "+chkRet);        			
        			paramMap.put("msgid", sTemp);
        			paramMap.put("send_state", 0);
        			sqlSession.update("RptIssueMapper.updateRptIssueSendMagStateOk",paramMap);
        			
        			try {        				
        				dCode = sRet.substring(0,1);
            			dMessage = sRet.substring(1,4);
            			
            			//에러 코드를 bizm_error 테이블에서 가져온다.
            			paramMap.put("ecode", dCode);
            			paramMap.put("emessage", dMessage);
            			
            			Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            			
            			dErrinfo = errorMsg.get("errinfo").toString();
            			dUflag = errorMsg.get("uflag").toString();

            			if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            				params.put("stateMsg", dErrinfo);
            			}else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            				params.put("stateMsg", sRet);
            			}
					} catch (Exception e) {
						params.put("stateMsg", "발송실패");
					} 
        		}
        	}else if( params.get("sendState").toString().equals("0") ){
        		try {
        			//실패한 메시지 키로 kakao 에 상태값을 읽어온다.
            		sTemp = params.get("msgid").toString();
            		sRet = sendKakaoResult(sTemp);
            		
            		if( sRet.equals("M000") || sRet.equals("K000") || sRet.equals("R000") ) {		//발송 성공
            			//발송 상태값을 발송 완료로 바꾸어 준다.        			
            			paramMap.put("msgid", sTemp);
            			paramMap.put("send_state", 1);
            			sqlSession.update("RptIssueMapper.updateRptIssueSendMagStateOk",paramMap);
            		}else if( sRet.equals("M001") ){
            			params.put("stateMsg", "전송대기중 입니다.");            			
            		}else if( sRet.startsWith("E110") || sRet.equals(" ") ){
            			params.put("stateMsg", "잠시 기다려주세요.");
            		}else {
            			dCode = sRet.substring(0,1);
            			dMessage = sRet.substring(1,4);
            			
            			//에러 코드를 bizm_error 테이블에서 가져온다.
            			paramMap.put("ecode", dCode);
            			paramMap.put("emessage", dMessage);
            			
            			Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            			
            			dErrinfo = errorMsg.get("errinfo").toString();
            			dUflag = errorMsg.get("uflag").toString();

            			if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            				params.put("stateMsg", dErrinfo);
            			}else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            				params.put("stateMsg", sRet);
            			}            			
            		}
				} catch (Exception e) {
					params.put("stateMsg", "발송결과 확인중 입니다.");
				}        		
        	}
        }        
        
        List<Map<String, Object>> rptIssueContList = sqlSession.selectList("RptIssueMapper.selectRptIssueContLotte", paramMap);
        
        //총괄표 정보 가져오기
        List<Map<String, Object>> rptIssueSummaryList = sqlSession.selectList("RptIssueMapper.selectRptIssueSummaryLotte", paramMap);
        
        int rowSpan = rptIssueContList.size();
        
        if( rptIssue.get("writeDate") == null ) {
        	String sNow = DateUtil.getTodayString();
            sNow = DateUtil.getDateFormat(sNow, "-");
            model.addAttribute("nowdate", sNow);
        }else {
        	model.addAttribute("nowdate", rptIssue.get("writeDate").toString());
        }
        
        //today 시간설정 시작
        Calendar cal = Calendar.getInstance();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
        String sToday = df.format(cal.getTime());
        
        model.addAttribute("sToday", sToday);		//현재시간 추가
        //today 시간설정 끝
        
        //담당자 자격증(손해사정사) 정보 List 만들기 시작
        List<Map<String, Object>> certiReportUser = null;					//보고서 하단에 들어갈 담당자 정보 List
        List<Map<String, Object>> certiManagerReportUser = null;		//담당손해사정사 목록

        //System.out.println(":::::::::::: certiReportUser : "+String.valueOf(paramMap.get("user_no")));

        String sUserNo = String.valueOf(paramMap.get("user_no"));

        //기 종결건은 담당손해사정사가 별도 저장되어있음 (top_rpt_certi_end) 저장된 손해사정사 정보가 별도로 있는지 체크
        int nEndCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiEndCnt",paramMap);

        if( nEndCnt == 0 ) {			//정보가 없는 경우 실시간으로 가져온다.
        	
        	if( !"0".equals(sUserNo) ) {		//0은 미배당건        	
        	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiMemberInfo", paramMap);
        	
        	int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
        	
        	nCertiManagerCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiManagerCnt", paramMap);
        	
        	if( nCertiManagerCnt > 0 ) {			//담당손해사정사가 있는 경우
        		certiManagerReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiManagerList", paramMap);
        		for( int i=0; i < certiManagerReportUser.size(); i++) {
        			certiReportUser.add(certiManagerReportUser.get(i));		//보고서 하단에 들어갈 담당자 정보에 담당손해사정서를 추가한다.
        		}
        	}
            }
        	
        }else{								//정보가 있는 경우 top_rpt_certi_end 테이블에서 불러온다.
        	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiEndInfo", paramMap);
        }

        model.addAttribute("certiReportUser", certiReportUser);
        //담당자 자격증(손해사정사) 정보 List 만들기 끝
        
        /**
         * view페이지 셋팅
         */
        model.addAttribute("rptIssueMain", rptIssueMain);
        model.addAttribute("suimVO",suimVo);
        model.addAttribute("reportInvgUser", reportInvgUser);
        model.addAttribute("rptIssue", rptIssue);									//수임주소지로 인한 추가.
        model.addAttribute("rptIssueContList", rptIssueContList);				//보험목적물 추가.        
        model.addAttribute("cont_edit_type", paramMap.get("cont_edit_type"));		//ajax 에 보여줄 모드
        model.addAttribute("suim_rpt_no",paramMap.get("suim_rpt_no"));
        model.addAttribute("rowSpan", rowSpan);							//표에 들어가 rowSpan
        model.addAttribute("rptIssueSummaryList", rptIssueSummaryList);
        model.addAttribute("rptIssueSendList",rptIssueSendList);				//발송결과 목록
        model.addAttribute("sHiddenPolicyNm", sHiddenPolicyNm);			//계약자 두번째글자 가려진 이름
        model.addAttribute("sHiddenBenefitNm", sHiddenBenefitNm);		//피보험자 두번째글자 가려진 이름
        
        //문서 타입지정
        model.addAttribute("ctype",sCtype);				//보험타입구분 ( C: 재물보험, B: 배상책임보험, I: 인보험 )
        
        String retURL = "top_suim_reportissue/rpt_issue_axa";		//이동할 페이지
        
        if ("word".equals(cmd)){
            //retURL = "top_suim_reportissue/rpt_issue_samsung_word";
            retURL = "top_suim_reportissue/rpt_issue_axa_word";
        }else if("print".equals(cmd)){
            //retURL = "top_suim_reportissue/rpt_issue_samsung_print";
            retURL = "top_suim_reportissue/rpt_issue_axa_print";
        }else if("report".equals(cmd)) {
        	retURL = "top_suim_reportissue/rpt_issue_lotte_report";
        }
        
        System.out.println("retURL:["+retURL+"]");

        return retURL;
        
    }
    
    @RequestMapping(value = "/reportIssueSamsungJemul")
    public String reportIssueSamsungJemul(HttpServletRequest request, Model model, HttpSession session){

    	logger.info("======== reportIssueSamsungJemul ========");
        //===============================================
        //	파라미터 체크
        //===============================================
    	
    	String cmd = StringUtil.null2blank(request.getParameter("cmd"));
    	String sCtype = request.getParameter("ctype");				//보험타입구분 ( C: 재물보험, B: 배상책임보험 )    	
    	
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        
        int nRptCnt = sqlSession.selectOne("RptIssueMapper.selectRptIssueCnt", paramMap);
        
        //if (rptIssueisExist == null){
        if (nRptCnt == 0){
        	sqlSession.insert("RptIssueMapper.insertRptIssueForExist", paramMap);
        	//logger.info("insertRptIssueForExist=======이슈테이블에 추가====");
        }
                
        //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);

        //담당팀 기본정보 가져오기
        paramMap.put("team_id", rptIssueMain.get("teamId"));
        Map<String, Object> reportTeamInfo = sqlSession.selectOne("SuimReportMapper.selectSuimReportTeam", paramMap);

        //조사자 정보
        paramMap.put("user_no", rptIssueMain.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
        
        //세부정보가져오기
        //SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", suim_rpt_no);
        SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);
        
        //출력시 계약자 피보험자 이름 두번째 글자 '*' 처리        
        String sHiddenPolicyNm = suimVo.getPolicyholder_nm().toString();
        String sHiddenBenefitNm = suimVo.getBeneficiary_nm().toString();        

        if( !sHiddenPolicyNm.equals("") ) {        	
        	if( sHiddenPolicyNm.length() == 1 ) {
        		sHiddenPolicyNm = "*";
        	}else {
        		sHiddenPolicyNm = sHiddenPolicyNm.replace(sHiddenPolicyNm.charAt(1),'*');
        	}        	        	
        }else {
        	sHiddenPolicyNm = "";
        }

        if( !sHiddenBenefitNm.equals("") ) {
        	if( sHiddenBenefitNm.length() == 1 ) {
        		sHiddenBenefitNm = "*";
        	}else {
        		sHiddenBenefitNm = sHiddenBenefitNm.replace(sHiddenBenefitNm.charAt(1),'*');
        	}        	
        }else {
        	sHiddenBenefitNm = "";
        }
        
        //================================================================
        //  손해사정서 교부 기본정보
        //================================================================
        // 손해사정서 교부 기본정보가 있는지 확인 없으면 기본입력
        //Map<String, Object> rptIssueisExist = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        List<Map<String, Object>> rptIssueSendList = sqlSession.selectList("RptIssueMapper.selectRptIssueSend", paramMap);
        
        String sTemp = "";		//임시메시지키
        String sRet = "";			//임시상태리턴값
        String dCode = "";		//임시코드
        String dMessage = "";	//임시메시지
        String dErrinfo = "";
        String dUflag = "";
        String chkRet = "";
        
        //발송된 메시지 상태값 확인
        for( Map<String, Object > params : rptIssueSendList) {
        	if( params.get("sendState").toString().equals("2") ) {			//대기중인 상태
        		//대기중인 메시지 키로 kakao 에 상태값을 읽어온다.
        		sTemp = params.get("msgid").toString();        		
        		sRet = sendKakaoResult(sTemp);
        		chkRet = sRet.substring(0, 4);
        		
        		if( sRet.equals("M000") || sRet.equals("K000") || sRet.equals("R000") ) {		//발송 성공
        			//발송 상태값을 발송 완료로 바꾸어 준다.        			
        			paramMap.put("msgid", sTemp);
        			paramMap.put("send_state", 1);
        			sqlSession.update("RptIssueMapper.updateRptIssueSendMagStateOk",paramMap);
        		}else if( chkRet.equals("M001")  ){			//대기중 인경우
        			try {
        				dCode = sRet.substring(0,1);
            			dMessage = sRet.substring(1,4);
            			
            			//에러 코드를 bizm_error 테이블에서 가져온다.
            			paramMap.put("ecode", dCode);
            			paramMap.put("emessage", dMessage);
            			
            			Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            			
            			dErrinfo = errorMsg.get("errinfo").toString();
            			dUflag = errorMsg.get("uflag").toString();

            			if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            				params.put("stateMsg", dErrinfo);
            			}else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            				params.put("stateMsg", sRet);
            			}
					} catch (Exception e) {
						params.put("stateMsg", "전송대기중 입니다.");
					}        			        			       			
        		}else {			//실패한 경우
        			//발송 상태값을 발송 실패로 바꾸어 준다.
        			//System.out.println("oniku실패체크 : "+sTemp+" : "+chkRet);        			
        			paramMap.put("msgid", sTemp);
        			paramMap.put("send_state", 0);
        			sqlSession.update("RptIssueMapper.updateRptIssueSendMagStateOk",paramMap);
        			
        			try {        				
        				dCode = sRet.substring(0,1);
            			dMessage = sRet.substring(1,4);
            			
            			//에러 코드를 bizm_error 테이블에서 가져온다.
            			paramMap.put("ecode", dCode);
            			paramMap.put("emessage", dMessage);
            			
            			Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            			
            			dErrinfo = errorMsg.get("errinfo").toString();
            			dUflag = errorMsg.get("uflag").toString();

            			if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            				params.put("stateMsg", dErrinfo);
            			}else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            				params.put("stateMsg", sRet);
            			}
					} catch (Exception e) {
						params.put("stateMsg", "발송실패");
					} 
        		}
        	}else if( params.get("sendState").toString().equals("0") ){
        		try {
        			//실패한 메시지 키로 kakao 에 상태값을 읽어온다.
            		sTemp = params.get("msgid").toString();
            		sRet = sendKakaoResult(sTemp);
            		
            		if( sRet.equals("M000") || sRet.equals("K000") || sRet.equals("R000") ) {		//발송 성공
            			//발송 상태값을 발송 완료로 바꾸어 준다.        			
            			paramMap.put("msgid", sTemp);
            			paramMap.put("send_state", 1);
            			sqlSession.update("RptIssueMapper.updateRptIssueSendMagStateOk",paramMap);
            		}else if( sRet.equals("M001") ){
            			params.put("stateMsg", "전송대기중 입니다.");            			
            		}else if( sRet.startsWith("E110") || sRet.equals(" ") ){
            			params.put("stateMsg", "잠시 기다려주세요.");
            		}else {
            			dCode = sRet.substring(0,1);
            			dMessage = sRet.substring(1,4);
            			
            			//에러 코드를 bizm_error 테이블에서 가져온다.
            			paramMap.put("ecode", dCode);
            			paramMap.put("emessage", dMessage);
            			
            			Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            			
            			dErrinfo = errorMsg.get("errinfo").toString();
            			dUflag = errorMsg.get("uflag").toString();

            			if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            				params.put("stateMsg", dErrinfo);
            			}else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            				params.put("stateMsg", sRet);
            			}            			
            		}
				} catch (Exception e) {
					params.put("stateMsg", "발송결과 확인중 입니다.");
				}        		
        	}
        }        
        
        List<Map<String, Object>> rptIssueContList = sqlSession.selectList("RptIssueMapper.selectRptIssueContLotte", paramMap);
        
        //총괄표 정보 가져오기
        List<Map<String, Object>> rptIssueSummaryList = sqlSession.selectList("RptIssueMapper.selectRptIssueSummaryLotte", paramMap);
        
        int rowSpan = rptIssueContList.size();
        
        if( rptIssue.get("writeDate") == null ) {
        	String sNow = DateUtil.getTodayString();
            sNow = DateUtil.getDateFormat(sNow, "-");
            model.addAttribute("nowdate", sNow);
        }else {
        	model.addAttribute("nowdate", rptIssue.get("writeDate").toString());
        }
        
        //today 시간설정 시작
        Calendar cal = Calendar.getInstance();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
        String sToday = df.format(cal.getTime());
        
        model.addAttribute("sToday", sToday);		//현재시간 추가
        //today 시간설정 끝
        
        /**
         * view페이지 셋팅
         */
        model.addAttribute("rptIssueMain", rptIssueMain);
        model.addAttribute("suimVO",suimVo);
        model.addAttribute("reportInvgUser", reportInvgUser);
        model.addAttribute("rptIssue", rptIssue);									//수임주소지로 인한 추가.
        model.addAttribute("rptIssueContList", rptIssueContList);				//보험목적물 추가.        
        model.addAttribute("cont_edit_type", paramMap.get("cont_edit_type"));		//ajax 에 보여줄 모드
        model.addAttribute("suim_rpt_no",paramMap.get("suim_rpt_no"));
        model.addAttribute("rowSpan", rowSpan);							//표에 들어가 rowSpan
        model.addAttribute("rptIssueSummaryList", rptIssueSummaryList);
        model.addAttribute("rptIssueSendList",rptIssueSendList);				//발송결과 목록
        model.addAttribute("sHiddenPolicyNm", sHiddenPolicyNm);			//계약자 두번째글자 가려진 이름
        model.addAttribute("sHiddenBenefitNm", sHiddenBenefitNm);		//피보험자 두번째글자 가려진 이름

        //합계값 셋팅
        long sum_joinPrice = 0;
        long sum_insuPrice = 0;
        long sum_lossPrice = 0;
        long sum_remainPrice = 0;
        long sum_responPrice = 0;        
        long sum_compLimitPrice = 0;
        long sum_compResponPrice = 0;      
        long sum_selfOptPrice = 0;
        long sum_netLossPrice = 0;
        long sum_lossCompPrice = 0;
        long sum_billPrice = 0;
        long sum_payPrice = 0;

        //합계 계산 로직 추가 by top3009        
        for( int i=0; i < rptIssueSummaryList.size(); i++ ) {
        	sum_joinPrice += Long.parseLong(rptIssueSummaryList.get(i).get("joinPrice").toString());
        	sum_insuPrice += Long.parseLong(rptIssueSummaryList.get(i).get("insuPrice").toString());
        	sum_lossPrice += Long.parseLong(rptIssueSummaryList.get(i).get("lossPrice").toString());
        	sum_remainPrice += Long.parseLong(rptIssueSummaryList.get(i).get("remainPrice").toString());
        	sum_responPrice += Long.parseLong(rptIssueSummaryList.get(i).get("responPrice").toString());
        	sum_netLossPrice += Long.parseLong(rptIssueSummaryList.get(i).get("netLossPrice").toString());		//삼성추가        	
        	sum_compLimitPrice += Long.parseLong(rptIssueSummaryList.get(i).get("compLimitPrice").toString());
        	sum_compResponPrice += Long.parseLong(rptIssueSummaryList.get(i).get("compResponPrice").toString());
        	sum_selfOptPrice += Long.parseLong(rptIssueSummaryList.get(i).get("selfOptPrice").toString());
        	sum_lossCompPrice += Long.parseLong(rptIssueSummaryList.get(i).get("lossCompPrice").toString());		//삼성추가
        	sum_billPrice += Long.parseLong(rptIssueSummaryList.get(i).get("billPrice").toString());		//삼성추가
        	sum_payPrice += Long.parseLong(rptIssueSummaryList.get(i).get("payPrice").toString());		//삼성추가        	
        }        

        model.addAttribute("sum_joinPrice", sum_joinPrice);
        model.addAttribute("sum_insuPrice", sum_insuPrice);
        model.addAttribute("sum_lossPrice", sum_lossPrice);
        model.addAttribute("sum_remainPrice", sum_remainPrice);
        model.addAttribute("sum_responPrice", sum_responPrice);
        model.addAttribute("sum_netLossPrice", sum_netLossPrice);
        model.addAttribute("sum_compLimitPrice", sum_compLimitPrice);
        model.addAttribute("sum_compResponPrice", sum_compResponPrice);
        model.addAttribute("sum_selfOptPrice", sum_selfOptPrice);
        model.addAttribute("sum_lossCompPrice", sum_lossCompPrice);
        model.addAttribute("sum_billPrice", sum_billPrice);
        model.addAttribute("sum_payPrice", sum_payPrice);
        
        //문서 타입지정
        model.addAttribute("ctype",sCtype);				//보험타입구분 ( C: 재물보험, B: 배상책임보험, I: 인보험 )
        
        //삼성 손해사정사 정보추가 by top3009 (2023-05-18)
        //담당자 자격증(손해사정사) 정보 List 만들기 시작
		List<Map<String, Object>> certiReportUser = null;					//보고서 하단에 들어갈 담당자 정보 List
		List<Map<String, Object>> certiManagerReportUser = null;		//담당손해사정사 목록
		
		//System.out.println(":::::::::::: certiReportUser : "+String.valueOf(paramMap.get("user_no")));
		
		String sUserNo = String.valueOf(paramMap.get("user_no"));
		
		//기 종결건은 담당손해사정사가 별도 저장되어있음 (top_rpt_certi_end) 저장된 손해사정사 정보가 별도로 있는지 체크
		int nEndCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiEndCnt",paramMap);
		
		if( nEndCnt == 0 ) {			//정보가 없는 경우 실시간으로 가져온다.
		
		if( !"0".equals(sUserNo) ) {		//0은 미배당건        	
		certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiMemberInfo", paramMap);
		
		int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
		
		nCertiManagerCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiManagerCnt", paramMap);
		
		if( nCertiManagerCnt > 0 ) {			//담당손해사정사가 있는 경우
			certiManagerReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiManagerList", paramMap);
				for( int i=0; i < certiManagerReportUser.size(); i++) {
					certiReportUser.add(certiManagerReportUser.get(i));		//보고서 하단에 들어갈 담당자 정보에 담당손해사정서를 추가한다.
				}
		  	}
		}
		  	
		}else{								//정보가 있는 경우 top_rpt_certi_end 테이블에서 불러온다.
			certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiEndInfo", paramMap);
		}
		
		/*
		if( certiReportUser != null ) {
			for( int k=0;  k < certiReportUser.size(); k++ ) {
				CommonUtils.printMap(certiReportUser.get(k));
			}
		}
		*/
		
		model.addAttribute("certiReportUser", certiReportUser);
		//담당자 자격증(손해사정사) 정보 List 만들기 끝        
        
        String retURL = "top_suim_reportissue/rpt_issue_samsung_jemul";		//이동할 페이지
        
        if ("word".equals(cmd)){
            retURL = "top_suim_reportissue/rpt_issue_samsung_word";
        }else if("print".equals(cmd)){
            retURL = "top_suim_reportissue/rpt_issue_samsung_print";
        }else if("report".equals(cmd)) {
        	retURL = "top_suim_reportissue/rpt_issue_lotte_report";
        }
        
        System.out.println("retURL:["+retURL+"]");

        return retURL;
        
    }
    
    @RequestMapping(value = "/reportIssueLotteJemul")
    public String reportIssueLotteJemul(HttpServletRequest request, Model model, HttpSession session){

    	logger.info("======== reportIssueLotteJemul ========");
        //===============================================
        //	파라미터 체크
        //===============================================
    	
    	String cmd = StringUtil.null2blank(request.getParameter("cmd"));
    	String ptnr_mbr_nm = request.getParameter("ptnr_mbr_nm");
    	String sCtype = request.getParameter("ctype");				//보험타입구분 ( C: 재물보험, B: 배상책임보험 )
    	
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        //===============================================
        // 비즈니스 로직
        //===============================================
        
        int nRptCnt = sqlSession.selectOne("RptIssueMapper.selectRptIssueCnt", paramMap);
        
        //if (rptIssueisExist == null){
        if (nRptCnt == 0){
        	sqlSession.insert("RptIssueMapper.insertRptIssueForExist", paramMap);
        	//logger.info("insertRptIssueForExist=======이슈테이블에 추가====");
        }
                
        //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);

        //담당팀 기본정보 가져오기
        paramMap.put("team_id", rptIssueMain.get("teamId"));
        Map<String, Object> reportTeamInfo = sqlSession.selectOne("SuimReportMapper.selectSuimReportTeam", paramMap);

        //조사자 정보
        paramMap.put("user_no", rptIssueMain.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
        
        //세부정보가져오기
        //SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", suim_rpt_no);
        SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);
        
        //ctype 이 없는 경우 계약사항이나 총괄표에 저장된 값이 있는지 확인한다.
    	if( sCtype.equals("") ) {
    		sCtype = sqlSession.selectOne("RptIssueMapper.selectRptIssueCtype", paramMap);
    		
    		if( sCtype == null ) {		//DB 에도 없으면 재물으로 처리
        		sCtype = "C";
        	}
    	}    	
        
        //================================================================
        //  손해사정서 교부 기본정보
        //================================================================
        // 손해사정서 교부 기본정보가 있는지 확인 없으면 기본입력
        //Map<String, Object> rptIssueisExist = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        //출력시 계약자 피보험자 이름 두번째 글자 '*' 처리        
        String sHiddenPolicyNm = suimVo.getPolicyholder_nm().toString();
        String sHiddenBenefitNm = suimVo.getBeneficiary_nm().toString();        
        
        if( !sHiddenPolicyNm.equals("") ) {        	
        	if( sHiddenPolicyNm.length() == 1 ) {
        		sHiddenPolicyNm = "*";
        	}else {
        		sHiddenPolicyNm = sHiddenPolicyNm.replace(sHiddenPolicyNm.charAt(1),'*');
        	}        	        	
        }else {
        	sHiddenPolicyNm = "";
        }

        if( !sHiddenBenefitNm.equals("") ) {
        	if( sHiddenBenefitNm.length() == 1 ) {
        		sHiddenBenefitNm = "*";
        	}else {
        		sHiddenBenefitNm = sHiddenBenefitNm.replace(sHiddenBenefitNm.charAt(1),'*');
        	}        	
        }else {
        	sHiddenBenefitNm = "";
        }        
        
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        List<Map<String, Object>> rptIssueSendList = sqlSession.selectList("RptIssueMapper.selectRptIssueSend", paramMap);
        
        String sTemp = "";		//임시메시지키
        String sRet = "";			//임시상태리턴값
        String dCode = "";		//임시코드
        String dMessage = "";	//임시메시지
        String dErrinfo = "";
        String dUflag = "";
        String chkRet = "";
        
        //발송된 메시지 상태값 확인
        for( Map<String, Object > params : rptIssueSendList) {
        	if( params.get("sendState").toString().equals("2") ) {			//대기중인 상태
        		//대기중인 메시지 키로 kakao 에 상태값을 읽어온다.
        		sTemp = params.get("msgid").toString();        		
        		sRet = sendKakaoResult(sTemp);
        		chkRet = sRet.substring(0, 4);
        		
        		if( sRet.equals("M000") || sRet.equals("K000") || sRet.equals("R000") ) {		//발송 성공
        			//발송 상태값을 발송 완료로 바꾸어 준다.        			
        			paramMap.put("msgid", sTemp);
        			paramMap.put("send_state", 1);
        			sqlSession.update("RptIssueMapper.updateRptIssueSendMagStateOk",paramMap);
        		}else if( chkRet.equals("M001")  ){			//대기중 인경우
        			try {
        				dCode = sRet.substring(0,1);
            			dMessage = sRet.substring(1,4);
            			
            			//에러 코드를 bizm_error 테이블에서 가져온다.
            			paramMap.put("ecode", dCode);
            			paramMap.put("emessage", dMessage);
            			
            			Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            			
            			dErrinfo = errorMsg.get("errinfo").toString();
            			dUflag = errorMsg.get("uflag").toString();

            			if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            				params.put("stateMsg", dErrinfo);
            			}else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            				params.put("stateMsg", sRet);
            			}
					} catch (Exception e) {
						params.put("stateMsg", "전송대기중 입니다.");
					}        			        			       			
        		}else {			//실패한 경우
        			//발송 상태값을 발송 실패로 바꾸어 준다.
        			//System.out.println("oniku실패체크 : "+sTemp+" : "+chkRet);        			
        			paramMap.put("msgid", sTemp);
        			paramMap.put("send_state", 0);
        			sqlSession.update("RptIssueMapper.updateRptIssueSendMagStateOk",paramMap);
        			
        			try {        				
        				dCode = sRet.substring(0,1);
            			dMessage = sRet.substring(1,4);
            			
            			//에러 코드를 bizm_error 테이블에서 가져온다.
            			paramMap.put("ecode", dCode);
            			paramMap.put("emessage", dMessage);
            			
            			Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            			
            			dErrinfo = errorMsg.get("errinfo").toString();
            			dUflag = errorMsg.get("uflag").toString();

            			if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            				params.put("stateMsg", dErrinfo);
            			}else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            				params.put("stateMsg", sRet);
            			}
					} catch (Exception e) {
						params.put("stateMsg", "발송실패");
					} 
        		}
        	}else if( params.get("sendState").toString().equals("0") ){
        		try {
        			//실패한 메시지 키로 kakao 에 상태값을 읽어온다.
            		sTemp = params.get("msgid").toString();
            		sRet = sendKakaoResult(sTemp);
            		
            		if( sRet.equals("M000") || sRet.equals("K000") || sRet.equals("R000") ) {		//발송 성공
            			//발송 상태값을 발송 완료로 바꾸어 준다.        			
            			paramMap.put("msgid", sTemp);
            			paramMap.put("send_state", 1);
            			sqlSession.update("RptIssueMapper.updateRptIssueSendMagStateOk",paramMap);
            		}else if( sRet.equals("M001") ){
            			params.put("stateMsg", "전송대기중 입니다.");            			
            		}else if( sRet.startsWith("E110") || sRet.equals(" ") ){
            			params.put("stateMsg", "잠시 기다려주세요.");
            		}else {
            			dCode = sRet.substring(0,1);
            			dMessage = sRet.substring(1,4);
            			
            			//에러 코드를 bizm_error 테이블에서 가져온다.
            			paramMap.put("ecode", dCode);
            			paramMap.put("emessage", dMessage);
            			
            			Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            			
            			dErrinfo = errorMsg.get("errinfo").toString();
            			dUflag = errorMsg.get("uflag").toString();

            			if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            				params.put("stateMsg", dErrinfo);
            			}else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            				params.put("stateMsg", sRet);
            			}            			
            		}
				} catch (Exception e) {
					params.put("stateMsg", "발송결과 확인중 입니다.");
				}        		
        	}
        }        
        
        List<Map<String, Object>> rptIssueContList = sqlSession.selectList("RptIssueMapper.selectRptIssueContLotte", paramMap);
        
        //총괄표 정보 가져오기
        List<Map<String, Object>> rptIssueSummaryList = sqlSession.selectList("RptIssueMapper.selectRptIssueSummaryLotte", paramMap);
        
        int rowSpan = rptIssueContList.size();
        
        if( rptIssue.get("writeDate") == null ) {
        	String sNow = DateUtil.getTodayString();
            sNow = DateUtil.getDateFormat(sNow, "-");
            model.addAttribute("nowdate", sNow);
        }else {
        	model.addAttribute("nowdate", rptIssue.get("writeDate").toString());
        }
        
        //today 시간설정 시작
        Calendar cal = Calendar.getInstance();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
        String sToday = df.format(cal.getTime());
        
        model.addAttribute("sToday", sToday);		//현재시간 추가
        //today 시간설정 끝
        
        /**
         * view페이지 셋팅
         */
        model.addAttribute("rptIssueMain", rptIssueMain);
        model.addAttribute("suimVO",suimVo);
        model.addAttribute("reportInvgUser", reportInvgUser);
        model.addAttribute("rptIssue", rptIssue);									//수임주소지로 인한 추가.
        model.addAttribute("rptIssueContList", rptIssueContList);				//보험목적물 추가.        
        model.addAttribute("cont_edit_type", paramMap.get("cont_edit_type"));		//ajax 에 보여줄 모드
        model.addAttribute("suim_rpt_no",paramMap.get("suim_rpt_no"));
        model.addAttribute("rowSpan", rowSpan);							//표에 들어가 rowSpan
        model.addAttribute("rptIssueSummaryList", rptIssueSummaryList);
        model.addAttribute("rptIssueSendList",rptIssueSendList);				//발송결과 목록
        model.addAttribute("sHiddenPolicyNm", sHiddenPolicyNm);			//계약자 두번째글자 가려진 이름
        model.addAttribute("sHiddenBenefitNm", sHiddenBenefitNm);		//피보험자 두번째글자 가려진 이름
        
      //합계값 셋팅
        long sum_joinPrice = 0;
        long sum_insuPrice = 0;
        long sum_lossPrice = 0;
        long sum_remainPrice = 0;
        long sum_responPrice = 0;        
        long sum_compLimitPrice = 0;
        long sum_compResponPrice = 0;      
        long sum_selfOptPrice = 0;
        
        //합계 계산 로직 추가 by top3009        
        for( int i=0; i < rptIssueSummaryList.size(); i++ ) {
        	sum_joinPrice += Long.parseLong(rptIssueSummaryList.get(i).get("joinPrice").toString());
        	sum_insuPrice += Long.parseLong(rptIssueSummaryList.get(i).get("insuPrice").toString());
        	sum_lossPrice += Long.parseLong(rptIssueSummaryList.get(i).get("lossPrice").toString());
        	sum_remainPrice += Long.parseLong(rptIssueSummaryList.get(i).get("remainPrice").toString());
        	sum_responPrice += Long.parseLong(rptIssueSummaryList.get(i).get("responPrice").toString());
        	sum_compLimitPrice += Long.parseLong(rptIssueSummaryList.get(i).get("compLimitPrice").toString());
        	sum_compResponPrice += Long.parseLong(rptIssueSummaryList.get(i).get("compResponPrice").toString());
        	sum_selfOptPrice += Long.parseLong(rptIssueSummaryList.get(i).get("selfOptPrice").toString());        	
        }        

        model.addAttribute("sum_joinPrice", sum_joinPrice);
        model.addAttribute("sum_insuPrice", sum_insuPrice);
        model.addAttribute("sum_lossPrice", sum_lossPrice);
        model.addAttribute("sum_remainPrice", sum_remainPrice);
        model.addAttribute("sum_responPrice", sum_responPrice);
        model.addAttribute("sum_compLimitPrice", sum_compLimitPrice);
        model.addAttribute("sum_compResponPrice", sum_compResponPrice);
        model.addAttribute("sum_selfOptPrice", sum_selfOptPrice);
        
        //롯데 손해사정사 정보추가 by top3009 (2023-05-16)
        //담당자 자격증(손해사정사) 정보 List 만들기 시작
        List<Map<String, Object>> certiReportUser = null;					//보고서 하단에 들어갈 담당자 정보 List
        List<Map<String, Object>> certiManagerReportUser = null;		//담당손해사정사 목록
        
        //System.out.println(":::::::::::: certiReportUser : "+String.valueOf(paramMap.get("user_no")));
        
        String sUserNo = String.valueOf(paramMap.get("user_no"));
        
        //기 종결건은 담당손해사정사가 별도 저장되어있음 (top_rpt_certi_end) 저장된 손해사정사 정보가 별도로 있는지 체크
        int nEndCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiEndCnt",paramMap);
        
        if( nEndCnt == 0 ) {			//정보가 없는 경우 실시간으로 가져온다.
        	
        	if( !"0".equals(sUserNo) ) {		//0은 미배당건        	
            	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiMemberInfo", paramMap);
            	
            	int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
            	
            	nCertiManagerCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiManagerCnt", paramMap);
            	
            	if( nCertiManagerCnt > 0 ) {			//담당손해사정사가 있는 경우
            		certiManagerReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiManagerList", paramMap);
            		for( int i=0; i < certiManagerReportUser.size(); i++) {
            			certiReportUser.add(certiManagerReportUser.get(i));		//보고서 하단에 들어갈 담당자 정보에 담당손해사정서를 추가한다.
            		}
            	}
            }
        	
        }else{								//정보가 있는 경우 top_rpt_certi_end 테이블에서 불러온다.
        	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiEndInfo", paramMap);
        }
        
        /*
        if( certiReportUser != null ) {
        	for( int k=0;  k < certiReportUser.size(); k++ ) {
            	CommonUtils.printMap(certiReportUser.get(k));
            }
        }
        */
        
        model.addAttribute("certiReportUser", certiReportUser);
        //담당자 자격증(손해사정사) 정보 List 만들기 끝
        
        
        //문서 타입지정
        model.addAttribute("ctype",sCtype);				//보험타입구분 ( C: 재물보험, B: 배상책임보험 )
        model.addAttribute("ptnr_mbr_nm", ptnr_mbr_nm);
        
        String retURL = "top_suim_reportissue/rpt_issue_lotte_jemul";		//이동할 페이지
        
        if ("word".equals(cmd)){
            retURL = "top_suim_reportissue/rpt_issue_lotte_word";
        }else if("print".equals(cmd)){
            retURL = "top_suim_reportissue/rpt_issue_lotte_print";
        }else if("report".equals(cmd)) {
        	retURL = "top_suim_reportissue/rpt_issue_lotte_report";
        }
        
        System.out.println("retURL:["+retURL+"]");

        return retURL;
        
    }
    
    @RequestMapping(value="/reportIssueAxaSummaryUpdate")
    @ResponseBody
    public int reportIssueAxaSummaryUpdate(HttpServletRequest request, Model model) {
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String amt_insu_payment = request.getParameter("amt_insu_payment") != null ? request.getParameter("amt_insu_payment") : "";    	
    	
    	
    	if(!"".equals(amt_insu_payment)) {
    		amt_insu_payment = amt_insu_payment.replaceAll(",", "");
    	}
    	    	
    	int udtCnt = 0;
    	
    	//top_rpt_issue 갱신
    	paramMap.put("amt_insu_payment", amt_insu_payment); 
    	
    	//top_rpt_body 갱신    	    	
    	udtCnt = sqlSession.update("RptIssueMapper.updateRptBodyAxaSummary", paramMap);
    	
    	
    	udtCnt = sqlSession.update("RptIssueMapper.updateRptIssueAxaSummary", paramMap);
        
    	
    	logger.info("======== reportIssueAxaSummaryUpdate ("+udtCnt+") ========");
    	
    	return udtCnt;
    }
    
    @RequestMapping(value="/reportIssueAxaUpdate")
    @ResponseBody
    public int reportIssueAxaUpdate(HttpServletRequest request, Model model) {
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String insu_term = "";
    	String sdate = request.getParameter("sdate") != null ? request.getParameter("sdate") : "";
    	String edate = request.getParameter("edate") != null ? request.getParameter("edate") : "";
    	
    	String amt_self_pay = request.getParameter("amt_self_pay") != null ? request.getParameter("amt_self_pay") : "";    	
    	String amt_compensation_limit = request.getParameter("amt_compensation_limit") != null ? request.getParameter("amt_compensation_limit") : "";
    	
    	String addr_rptUdt_1 = request.getParameter("addr_rptUdt_1") != null ? request.getParameter("addr_rptUdt_1") : "";
    	String postcode_rptUdt = request.getParameter("postcode_rptUdt") != null ? request.getParameter("postcode_rptUdt") : "";
    	
    	if(!"".equals(sdate) && !"".equals(edate)) {
    		insu_term = sdate+"~"+edate;
    	}else{
    		insu_term = sdate+edate;
    	}
    	
    	if(!"".equals(amt_self_pay)) {
    		amt_self_pay = amt_self_pay.replaceAll(",", "");
    	}
    	
    	if(!"".equals(amt_compensation_limit)) {
    		amt_compensation_limit = amt_compensation_limit.replaceAll(",", "");
    	}
    	
    	int udtCnt = 0;    	
    	
    	/**
        System.out.println(paramMap.get("suim_rpt_no").toString() + " : "
        		+paramMap.get("policy_no").toString()+ " : "
        		+paramMap.get("sdate").toString()+ " : "
        		+paramMap.get("edate").toString()+ " : "
				+paramMap.get("guarantee_title").toString()+ " : "
				+paramMap.get("amt_self_pay").toString()+ " : "
				+paramMap.get("amt_compensation_limit").toString()+ " : "
				+paramMap.get("accident_no").toString()+ " : "
				+paramMap.get("policyholder_nm").toString()+ " : "
				+paramMap.get("beneficiary_nm").toString()+ " : "
				+paramMap.get("addr_rptUdt_1").toString()+ " : "
				+paramMap.get("suim_address").toString()+ " : ");
		**/
    	
    	//top_rpt_issue 갱신
    	paramMap.put("suim_zipcode", postcode_rptUdt);
    	paramMap.put("suim_address", addr_rptUdt_1);
    	udtCnt = sqlSession.update("RptIssueMapper.updateRptIssueZipcode", paramMap); 
        
    	//top_rpt_body 갱신
    	paramMap.put("insu_term", insu_term);
    	paramMap.put("amt_self_pay", amt_self_pay);
    	paramMap.put("amt_compensation_limit", amt_compensation_limit);    	
    	udtCnt = sqlSession.update("RptIssueMapper.updateRptBodyAxa", paramMap);
    	
    	//top_rpt_head 갱신
    	udtCnt = sqlSession.update("RptIssueMapper.updateRptHeadAxa", paramMap);
    	
    	logger.info("======== reportIssueAxaUpdate ("+udtCnt+") ========");
    	
    	return udtCnt;
    }
    
    @RequestMapping(value="/reportIssueSamsungJemulUpdate")
    @ResponseBody
    public int reportIssueSamsungJemulUpldate(HttpServletRequest request, Model model) {
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);    	  	
    	
    	//zipcode 하고 address 을 갱신한다.    	
    	int udtCnt = sqlSession.update("RptIssueMapper.updateRptIssueZipcode", paramMap);    	
    	
    	//insuturm (보험기간)을 갱신한다.
    	udtCnt = sqlSession.update("RptIssueMapper.updateRptIssueTerm", paramMap);
    	logger.info("======== reportIssueSamsungJemulUpdate ("+udtCnt+") ========");
    	
    	return udtCnt;
    }
    
    @RequestMapping(value="/reportIssueLotteJemulUpdate")
    @ResponseBody
    public int reportIssueLotteJemulUpldate(HttpServletRequest request, Model model) {
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String [] sTemp = request.getParameterValues("contList");
    	String suim_rpt_no = request.getParameter("suim_rpt_no");
    	    	
    	String sConCate = "";
    	String sConContent = "";
    	int nIdx = 0;
    	
    	//보험목적물 삭제
    	if( sTemp.length > 0 ) {
    		sqlSession.delete("RptIssueMapper.deleteRptIssueContLotte",paramMap);
    	}
    	
    	for(int i=0; i < sTemp.length; i++) {
    		nIdx = sTemp[i].indexOf("|");    		
    		sConCate = sTemp[i].substring(0, nIdx);
    		sConContent = sTemp[i].substring(nIdx+1);
    		paramMap.put("cont_cate", sConCate);
    		paramMap.put("cont_content", sConContent);
    		sqlSession.insert("RptIssueMapper.insertRptIssueContLotte", paramMap);
    		//System.out.println("삭제하고 추가한다. "+suim_rpt_no+" : "+sConCate+" : "+sConContent);
    	}    	
    	
    	//zipcode 하고 address 을 갱신한다.    	
    	int udtCnt = sqlSession.update("RptIssueMapper.updateRptIssueZipcode", paramMap);    	
    	
    	//insuturm (보험기간)을 갱신한다.
    	udtCnt = sqlSession.update("RptIssueMapper.updateRptIssueTerm", paramMap);
    	logger.info("======== reportIssueLotteJemulUpdate ("+udtCnt+") ========");
    	
    	return udtCnt;
    }
    
    @RequestMapping(value="/reportIssueSamsungRemarkUpdate")
    @ResponseBody
    public int reportIssueSamsungRemarkUpdate(HttpServletRequest request, Model model) {
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);    	
    	
    	String sCtype = request.getParameter("ctype");								//손해사정서 종류
    	
    	//비고내용을 업데이트 한다.
    	int udtCnt = sqlSession.update("RptIssueMapper.updateRptIssueRemark", paramMap);
    	logger.info("======== reportIssueLotteRemarkUpdate ("+udtCnt+") ========");
    	
    	return udtCnt;
    }
    
    @RequestMapping(value="/reportIssueSamsungSummaryUpdate")
    @ResponseBody
    public int reportIssueSamsungSummaryUpdate(HttpServletRequest request, Model model) {
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String [] sTemp = request.getParameterValues("summaryList");			//총괄표에서 넘어온 배열
    	String [] splTemp = null;					//배열처리 임시변수
    	
    	String sCtype = request.getParameter("ctype");								//손해사정서 종류
    	
    	String sSummary_cate = "";				//목적물
    	String sJoin_price = "";						//가입금액
    	String sInsu_price = "";					//보험가액
    	String sLoss_price = "";					//손해액
    	String sRemain_price = "";				//잔존물
    	String sRespon_price = "";				//약관상지급금액
    	String sComp_limit_price = "";			//보상한도액
    	String sComp_respon_price = "";		//배상책임액
    	String sSelf_opt_price = "";				//자기부담금
    	String sNet_loss_price = "";				//순손해액
    	String sLoss_comp_price = "";			//손해배상금
    	String sBill_price = "";						//청구금액
    	String sPay_price = "";						//지급금액
    	String sException_val = "";				//제외사유
    	   	
    	//배열 처리 해야함..
    	if( sCtype.equals("C") && sTemp.length > 0 ){					//재물보험인경우 분리
    		//추가하기전에 삭제 한다.
    		sqlSession.update("RptIssueMapper.deleteRptIssueSummaryNumLotteTotal", paramMap);
    		
    		for(int i=0; i < sTemp.length; i++) {
    			
    			splTemp = sTemp[i].split("\\|");
    			sSummary_cate = splTemp[0];
    			sJoin_price = splTemp[1];
    			sInsu_price = splTemp[2];
    			sLoss_price = splTemp[3];
    			sRemain_price = splTemp[4];
    			sNet_loss_price = splTemp[5];
    			
    			paramMap.put("summary_cate", sSummary_cate);
    			paramMap.put("join_price", StringUtil.removeComma(sJoin_price));
    			paramMap.put("insu_price", StringUtil.removeComma(sInsu_price));
    			paramMap.put("loss_price", StringUtil.removeComma(sLoss_price));
    			paramMap.put("remain_price", StringUtil.removeComma(sRemain_price));
    			paramMap.put("net_loss_price", StringUtil.removeComma(sNet_loss_price));
    			
    			sqlSession.update("RptIssueMapper.insertRptSummary", paramMap);
    			
    		}    		
    	}else if( sCtype.equals("B") && sTemp.length > 0 ) {		//배상보험의 경우

    		sqlSession.update("RptIssueMapper.deleteRptIssueSummaryNumLotteTotal", paramMap);
    		
    		for(int i=0; i < sTemp.length; i++) {
    			
    			splTemp = sTemp[i].split("\\|");
    			sSummary_cate = splTemp[0];
    			sComp_limit_price = splTemp[1];
    			sLoss_price = splTemp[2];
    			sLoss_comp_price = splTemp[3];
    			sSelf_opt_price = splTemp[4];
    			
    			paramMap.put("summary_cate", sSummary_cate);
    			paramMap.put("comp_limit_price", StringUtil.removeComma(sComp_limit_price));
    			paramMap.put("loss_price", StringUtil.removeComma(sLoss_price));
    			paramMap.put("loss_comp_price", StringUtil.removeComma(sLoss_comp_price));    			
    			paramMap.put("self_opt_price", StringUtil.removeComma(sSelf_opt_price));
    			
    			//특수기호 처리
    			sqlSession.update("RptIssueMapper.insertRptSummary", paramMap);
    			
    		}
    		
    	}else if( sCtype.equals("I") && sTemp.length > 0 ){					//재물보험인경우 분리
    		//추가하기전에 삭제 한다.
    		sqlSession.update("RptIssueMapper.deleteRptIssueSummaryNumLotteTotal", paramMap);
    		
    		for(int i=0; i < sTemp.length; i++) {
    			
    			splTemp = sTemp[i].split("\\|");
    			
    			//System.out.println("oniku 01:: "+ splTemp[0]+ " : "+splTemp[1]+" : "+splTemp[2]+ " : "+ splTemp[3] + " : "+splTemp[4]);
    			
    			sSummary_cate = splTemp[0];
    			sJoin_price = splTemp[1];
    			sBill_price = splTemp[2];
    			sPay_price = splTemp[3];
    			sException_val = splTemp[4];
    			
    			paramMap.put("summary_cate", sSummary_cate);
    			paramMap.put("join_price", StringUtil.removeComma(sJoin_price));
    			paramMap.put("bill_price", StringUtil.removeComma(sBill_price));
    			paramMap.put("pay_price", StringUtil.removeComma(sPay_price));
    			paramMap.put("exception_val", sException_val);
    			
    			sqlSession.update("RptIssueMapper.insertRptSummary", paramMap);
    			
    		}    		
    	}
    	
    	//자기부담금 단위와 금액을 업데이트 한다.    	
    	//int udtCnt = sqlSession.update("RptIssueMapper.updateRptBodySelfpay", paramMap);    	
    	
    	//비고내용을 업데이트 한다.
    	int udtCnt = sqlSession.update("RptIssueMapper.updateRptIssueRemark", paramMap);
    	logger.info("======== reportIssueSamsungSummaryUpdate ("+udtCnt+") ========");
    	
    	return udtCnt;
    }
    
    @RequestMapping(value="/reportIssueHeungkukSummaryUpdate")
    @ResponseBody
    public int reportIssueHeungkukSummaryUpdate(HttpServletRequest request, Model model) {
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String [] sTemp = request.getParameterValues("summaryList");			//총괄표에서 넘어온 배열
    	String [] splTemp = null;					//배열처리 임시변수
    	
    	String sCtype = request.getParameter("ctype");								//손해사정서 종류
    	
    	String sSummary_cate = "";				//목적물
    	String sJoin_price = "";						//가입금액
    	String sInsu_price = "";					//보험가액
    	String sLoss_price = "";					//손해액
    	String sRemain_price = "";				//잔존물
    	String sRespon_price = "";				//약관상지급금액
    	String sComp_limit_price = "";			//보상한도액
    	String sComp_respon_price = "";		//배상책임액
    	String sSelf_opt_price = "";				//자기부담금
    	String sNet_loss_price = "";				//순손해액
    	String sLoss_comp_price = "";			//손해배상금
    	String sBill_price = "";						//청구금액
    	String sPay_price = "";						//지급금액
    	String sException_val = "";				//제외사유
    	String sInsu_nm = "";						//개별증권번호(흥국사용)
    	   	
    	//배열 처리 해야함..
    	if( sCtype.equals("C") && sTemp.length > 0 ){					//재물보험인경우 분리
    		//추가하기전에 삭제 한다.
    		sqlSession.update("RptIssueMapper.deleteRptIssueSummaryNumLotteTotal", paramMap);
    		
    		for(int i=0; i < sTemp.length; i++) {
    			
    			splTemp = sTemp[i].split("\\|");
    			sSummary_cate = splTemp[0];
    			sJoin_price = splTemp[1];
    			sInsu_price = splTemp[2];
    			sLoss_price = splTemp[3];
    			sRemain_price = splTemp[4];
    			sPay_price = splTemp[5];
    			
    			paramMap.put("summary_cate", sSummary_cate);
    			paramMap.put("join_price", StringUtil.removeComma(sJoin_price));
    			paramMap.put("insu_price", StringUtil.removeComma(sInsu_price));
    			paramMap.put("loss_price", StringUtil.removeComma(sLoss_price));
    			paramMap.put("remain_price", StringUtil.removeComma(sRemain_price));
    			paramMap.put("pay_price", StringUtil.removeComma(sPay_price));
    			
    			sqlSession.update("RptIssueMapper.insertRptSummary", paramMap);
    			
    		}    		
    	}else if( sCtype.equals("B") && sTemp.length > 0 ) {		//배상보험의 경우

    		sqlSession.update("RptIssueMapper.deleteRptIssueSummaryNumLotteTotal", paramMap);
    		
    		for(int i=0; i < sTemp.length; i++) {
    			
    			splTemp = sTemp[i].split("\\|");
    			sSummary_cate = splTemp[0];
    			sComp_limit_price = splTemp[1];
    			sLoss_price = splTemp[2];
    			sNet_loss_price = splTemp[3];
    			sPay_price = splTemp[4];
    			sException_val = splTemp[5];
    			
    			paramMap.put("summary_cate", sSummary_cate);
    			paramMap.put("comp_limit_price", StringUtil.removeComma(sComp_limit_price));
    			paramMap.put("loss_price", StringUtil.removeComma(sLoss_price));
    			paramMap.put("net_loss_price", StringUtil.removeComma(sNet_loss_price));    			
    			paramMap.put("pay_price", StringUtil.removeComma(sPay_price));
    			paramMap.put("exception_val", sException_val);
    			
    			//특수기호 처리
    			sqlSession.update("RptIssueMapper.insertRptSummary", paramMap);
    			
    		}
    		
    	}else if( sCtype.equals("I") && sTemp.length > 0 ){					//재물보험인경우 분리
    		//추가하기전에 삭제 한다.
    		sqlSession.update("RptIssueMapper.deleteRptIssueSummaryNumLotteTotal", paramMap);
    		
    		for(int i=0; i < sTemp.length; i++) {
    			
    			splTemp = sTemp[i].split("\\|");
    			
    			//System.out.println("oniku 01:: "+ splTemp[0]+ " : "+splTemp[1]+" : "+splTemp[2]+ " : "+ splTemp[3] + " : "+splTemp[4]+ " : "+splTemp[5]);
    			sInsu_nm = splTemp[0];
    			sSummary_cate = splTemp[1];
    			sJoin_price = splTemp[2];
    			sBill_price = splTemp[3];
    			sPay_price = splTemp[4];
    			sException_val = splTemp[5];
    			
    			paramMap.put("insu_nm", sInsu_nm);
    			paramMap.put("summary_cate", sSummary_cate);
    			paramMap.put("join_price", StringUtil.removeComma(sJoin_price));
    			paramMap.put("bill_price", StringUtil.removeComma(sBill_price));
    			paramMap.put("pay_price", StringUtil.removeComma(sPay_price));
    			paramMap.put("exception_val", sException_val);
    			
    			sqlSession.update("RptIssueMapper.insertRptSummary", paramMap);
    			
    		}    		
    	}
    	
    	//자기부담금 단위와 금액을 업데이트 한다.    	
    	//int udtCnt = sqlSession.update("RptIssueMapper.updateRptBodySelfpay", paramMap);    	
    	
    	//비고내용을 업데이트 한다.
    	int udtCnt = sqlSession.update("RptIssueMapper.updateRptIssueRemark", paramMap);
    	logger.info("======== reportIssueLotteSummaryUpdate ("+udtCnt+") ========");
    	
    	return udtCnt;
    }
    
    @RequestMapping(value="/reportIssueMeritzCoverageUpdate")
    @ResponseBody
    public int reportIssueMeritzCoverageUpdate(HttpServletRequest request, Model model) {
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String [] sTemp = request.getParameterValues("coverageList");			//담보명에서 넘어온 배열
    	String [] splTemp = null;					//배열처리 임시변수
    	
    	String sCoverageNm= "";					//담보명
    	String sJoinPrice = "";						//가입금액
    	String sBillPrice = "";						//청구금액
    	
    	if( sTemp.length > 0 ){
    		//추가하기전에 삭제 한다.
    		sqlSession.update("RptIssueMapper.deleteRptIssueMeritzCoverageInfoTotal", paramMap);
    		
    		for(int i=0; i < sTemp.length; i++) {
    			
    			splTemp = sTemp[i].split("\\|");
    			sCoverageNm = splTemp[0];
    			sJoinPrice = splTemp[1];
    			sBillPrice = splTemp[2];    			
    			
    			paramMap.put("coverage_nm", sCoverageNm);
    			paramMap.put("join_price", StringUtil.removeComma(sJoinPrice));
    			paramMap.put("bill_price", StringUtil.removeComma(sBillPrice));

    			sqlSession.update("RptIssueMapper.insertRptMeritzCoverageInfo", paramMap);
    			
    		}    		
    	}    	
    	
    	//업데이트 숫자를 return 한다.
    	int udtCnt = sTemp.length;
    	logger.info("======== reportIssueMeritzCoverageUpdate ("+udtCnt+") ========");
    	
    	return udtCnt;
    }
    
    
    @RequestMapping(value="/reportIssueLotteSummaryUpdate")
    @ResponseBody
    public int reportIssueLotteSummaryUpdate(HttpServletRequest request, Model model) {
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String [] sTemp = request.getParameterValues("summaryList");			//총괄표에서 넘어온 배열
    	String [] splTemp = null;					//배열처리 임시변수
    	
    	String sCtype = request.getParameter("ctype");								//손해사정서 종류
    	
    	String sSummary_cate = "";				//목적물
    	String sJoin_price = "";						//가입금액
    	String sInsu_price = "";					//보험가액
    	String sLoss_price = "";					//손해액
    	String sRemain_price = "";				//잔존물
    	String sRespon_price = "";				//약관상지급금액
    	String sComp_limit_price = "";			//보상한도액
    	String sComp_respon_price = "";		//배상책임액
    	String sSelf_opt_price = "";				//자기부담금
    	   	
    	//배열 처리 해야함..
    	if( sCtype.equals("C") && sTemp.length > 0 ){					//재물보험인경우 분리
    		//추가하기전에 삭제 한다.
    		sqlSession.update("RptIssueMapper.deleteRptIssueSummaryNumLotteTotal", paramMap);
    		
    		for(int i=0; i < sTemp.length; i++) {
    			
    			splTemp = sTemp[i].split("\\|");
    			sSummary_cate = splTemp[0];
    			sJoin_price = splTemp[1];
    			sInsu_price = splTemp[2];
    			sLoss_price = splTemp[3];
    			sRemain_price = splTemp[4];
    			sRespon_price = splTemp[5];
    			
    			paramMap.put("summary_cate", sSummary_cate);
    			paramMap.put("join_price", StringUtil.removeComma(sJoin_price));
    			paramMap.put("insu_price", StringUtil.removeComma(sInsu_price));
    			paramMap.put("loss_price", StringUtil.removeComma(sLoss_price));
    			paramMap.put("remain_price", StringUtil.removeComma(sRemain_price));
    			paramMap.put("respon_price", StringUtil.removeComma(sRespon_price));
    			
    			sqlSession.update("RptIssueMapper.insertRptSummary", paramMap);
    			
    		}    		
    	}else if( sCtype.equals("B") && sTemp.length > 0 ) {		//배상보험의 경우
    		//추가하기전에 삭제 한다.
    		//중복저장문제 해결필요!!
    		sqlSession.update("RptIssueMapper.deleteRptIssueSummaryNumLotteTotal", paramMap);
    		
    		for(int i=0; i < sTemp.length; i++) {
    			
    			splTemp = sTemp[i].split("\\|");
    			sSummary_cate = splTemp[0];
    			sComp_limit_price = splTemp[1];
    			sComp_respon_price = splTemp[2];
    			sSelf_opt_price = splTemp[3];
    			sRespon_price = splTemp[4];
    			
    			paramMap.put("summary_cate", sSummary_cate);
    			paramMap.put("comp_limit_price", StringUtil.removeComma(sComp_limit_price));
    			paramMap.put("comp_respon_price", StringUtil.removeComma(sComp_respon_price));
    			paramMap.put("self_opt_price", StringUtil.removeComma(sSelf_opt_price));    			
    			paramMap.put("respon_price", StringUtil.removeComma(sRespon_price));
    			
    			//System.out.println(sSummary_cate+" : "+sComp_limit_price+ " : "+sComp_respon_price+ " : "+sSelf_opt_price+ " : "+sRespon_price);
    			//특수기호 처리
    			sqlSession.update("RptIssueMapper.insertRptSummary", paramMap);
    			
    		}
    		
    	}else if( sCtype.equals("T") && sTemp.length > 0 ){					//재물보험인경우 분리
    		//추가하기전에 삭제 한다.
    		sqlSession.update("RptIssueMapper.deleteRptIssueSummaryNumLotteTotal", paramMap);
    		
    		for(int i=0; i < sTemp.length; i++) {
    			
    			splTemp = sTemp[i].split("\\|");
    			sSummary_cate = splTemp[0];
    			sJoin_price = splTemp[1];
    			sInsu_price = splTemp[2];
    			sLoss_price = splTemp[3];
    			sSelf_opt_price = splTemp[4];
    			sRespon_price = splTemp[5];
    			
    			paramMap.put("summary_cate", sSummary_cate);
    			paramMap.put("join_price", StringUtil.removeComma(sJoin_price));
    			paramMap.put("insu_price", StringUtil.removeComma(sInsu_price));
    			paramMap.put("loss_price", StringUtil.removeComma(sLoss_price));
    			paramMap.put("self_opt_price", StringUtil.removeComma(sSelf_opt_price));
    			paramMap.put("respon_price", StringUtil.removeComma(sRespon_price));
    			
    			sqlSession.update("RptIssueMapper.insertRptSummary", paramMap);
    			
    		}    		
    	}
    	
    	//자기부담금 단위와 금액을 업데이트 한다.    	
    	//int udtCnt = sqlSession.update("RptIssueMapper.updateRptBodySelfpay", paramMap);    	
    	
    	//비고내용을 업데이트 한다.
    	int udtCnt = sqlSession.update("RptIssueMapper.updateRptIssueRemark", paramMap);
    	logger.info("======== reportIssueLotteSummaryUpdate ("+udtCnt+") ========");
    	
    	return udtCnt;
    }
    
    @RequestMapping(value="/reportIssueLotteJemulDelete")
    @ResponseBody
    public int reportIssueLotteJemulDelete(HttpServletRequest request, Model model) {
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	    	
		/*
		 * String suim_rpt_no = request.getParameter("suim_rpt_no"); String cont_no =
		 * request.getParameter("cont_no");
		 */
    	    	
    	
    	int delCnt = sqlSession.delete("RptIssueMapper.deleteRptIssueContNumLotte",paramMap);
    	
    	logger.info("======== reportIssueLotteJemulDelete ("+delCnt+") ========");
    	
    	return delCnt;
    }
    
    @RequestMapping(value="/reportIssueMeritzCoverageInfoDelete")
    @ResponseBody
    public int reportIssueMeritzCoverageInfoDelete(HttpServletRequest request, Model model) {
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);    	

    	int delCnt = sqlSession.delete("RptIssueMapper.deleteRptIssueMeritzCoverageNum",paramMap);
    	
    	logger.info("======== reportIssueMeritzCoverageInfoDelete ("+delCnt+") ========");
    	
    	return delCnt;
    }
    
    @RequestMapping(value="/reportIssueLotteSummaryDelete")
    @ResponseBody
    public int reportIssueLotteSummaryDelete(HttpServletRequest request, Model model) {
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	int delCnt = sqlSession.delete("RptIssueMapper.deleteRptIssueSummaryNumLotte",paramMap);
    	
    	logger.info("======== reportIssueLotteSummaryDelete ("+delCnt+") ========");
    	
    	return delCnt;
    }
    
    @RequestMapping(value="/reportIssueLotteSendDelete")
    @ResponseBody
    public int reportIssueLotteSendDelete(HttpServletRequest request, Model model) {
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	int delCnt = 0;
    	
    	//첨부파일 여부를 확인해서 파일이 있으면 삭제 후 목록을 삭제한다.    	
    	String sSerialNo = "";
    	String sFilePath = "";
    	sSerialNo = String.valueOf(paramMap.get("serial_no"));
    	sFilePath = sqlSession.selectOne("SuimBookUdtMapper.getRptIssueFileEmailAttachForDown", sSerialNo);
    	
    	if( sFilePath != null ) {    		
    		File file = new File(sFilePath);
    		if(file.exists()) {
    			//파일 삭제 여기부터    			
    			file.delete();
    		}    		
    	}
    	
    	delCnt = sqlSession.delete("RptIssueMapper.deleteRptIssueSend",paramMap);
    	
    	logger.info("======== reportIssueLotteSendDelete ("+delCnt+") ========");
    	
    	return delCnt;
    }
    
    @RequestMapping(value = "/ajax/ajax_samsung_jemul_remark")			//특이사항 목록 가져오기 방식으로 수정 by top3009
    public String reportIssueSamsungJemulRemark(HttpServletRequest request, Model model){		    	

    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String sCtype = request.getParameter("ctype");				//보험타입구분 ( C: 재물보험, B: 배상책임보험 )
    	        
        //비고 추가.
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
                
    	/**
         * view페이지 셋팅
         */        
        model.addAttribute("rptIssue",rptIssue);        
        model.addAttribute("ctype",sCtype);				//보험타입구분 ( C: 재물보험, B: 배상책임보험, I: 인보험 )        
    	model.addAttribute("remark_edit_type", paramMap.get("remark_edit_type"));		//ajax 에 보여줄 모드
    	model.addAttribute("suim_rpt_no",paramMap.get("suim_rpt_no"));
    	
    	String sUrl = "top_suim_reportissue/ajax/ajax_samsung_jemul_remark";
    	
    	return sUrl;
    }
    
    @RequestMapping(value = "/ajax/ajax_samsung_jemul_summary")			//총괄표 목록 가져오기 방식으로 수정 by top3009
    public String reportIssueSamsungJemulSummary(HttpServletRequest request, Model model){		    	
    	
    	//top_rpt_issue_cont_lotte 테이블에서 등록된 보험목적물 정보를 가져온다.
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String sCtype = request.getParameter("ctype");				//보험타입구분 ( C: 재물보험, B: 배상책임보험 )
    	
    	//기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);  		//자기부담금정보추가      
                
        //세부정보가져오기
        SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);
        
        //비고 추가.
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        //총괄표 정보 가져오기
        List<Map<String, Object>> rptIssueSummaryList = sqlSession.selectList("RptIssueMapper.selectRptIssueSummaryLotte", paramMap);
    	
        int rowSpan = rptIssueSummaryList.size();
        
    	/**
         * view페이지 셋팅
         */
        model.addAttribute("rptIssueMain", rptIssueMain);
        model.addAttribute("suimVO",suimVo);
        model.addAttribute("rptIssue",rptIssue);
        model.addAttribute("rptIssueSummaryList", rptIssueSummaryList);
        model.addAttribute("ctype",sCtype);				//보험타입구분 ( C: 재물보험, B: 배상책임보험, I: 인보험 )
        
        //합계값 셋팅
        long sum_joinPrice = 0;
        long sum_insuPrice = 0;
        long sum_lossPrice = 0;
        long sum_remainPrice = 0;
        long sum_responPrice = 0;        
        long sum_compLimitPrice = 0;
        long sum_compResponPrice = 0;      
        long sum_selfOptPrice = 0;
        long sum_netLossPrice = 0;
        long sum_lossCompPrice = 0;
        long sum_billPrice = 0;
        long sum_payPrice = 0;
        
        //합계 계산 로직 추가 by top3009        
        for( int i=0; i < rptIssueSummaryList.size(); i++ ) {
        	sum_joinPrice += Long.parseLong(rptIssueSummaryList.get(i).get("joinPrice").toString());
        	sum_insuPrice += Long.parseLong(rptIssueSummaryList.get(i).get("insuPrice").toString());
        	sum_lossPrice += Long.parseLong(rptIssueSummaryList.get(i).get("lossPrice").toString());
        	sum_remainPrice += Long.parseLong(rptIssueSummaryList.get(i).get("remainPrice").toString());
        	sum_responPrice += Long.parseLong(rptIssueSummaryList.get(i).get("responPrice").toString());
        	sum_netLossPrice += Long.parseLong(rptIssueSummaryList.get(i).get("netLossPrice").toString());		//삼성추가        	
        	sum_compLimitPrice += Long.parseLong(rptIssueSummaryList.get(i).get("compLimitPrice").toString());
        	sum_compResponPrice += Long.parseLong(rptIssueSummaryList.get(i).get("compResponPrice").toString());
        	sum_selfOptPrice += Long.parseLong(rptIssueSummaryList.get(i).get("selfOptPrice").toString());
        	sum_lossCompPrice += Long.parseLong(rptIssueSummaryList.get(i).get("lossCompPrice").toString());		//삼성추가
        	sum_billPrice += Long.parseLong(rptIssueSummaryList.get(i).get("billPrice").toString());		//삼성추가
        	sum_payPrice += Long.parseLong(rptIssueSummaryList.get(i).get("payPrice").toString());		//삼성추가        	
        }        

        model.addAttribute("sum_joinPrice", sum_joinPrice);
        model.addAttribute("sum_insuPrice", sum_insuPrice);
        model.addAttribute("sum_lossPrice", sum_lossPrice);
        model.addAttribute("sum_remainPrice", sum_remainPrice);
        model.addAttribute("sum_responPrice", sum_responPrice);
        model.addAttribute("sum_netLossPrice", sum_netLossPrice);
        model.addAttribute("sum_compLimitPrice", sum_compLimitPrice);
        model.addAttribute("sum_compResponPrice", sum_compResponPrice);
        model.addAttribute("sum_selfOptPrice", sum_selfOptPrice);
        model.addAttribute("sum_lossCompPrice", sum_lossCompPrice);
        model.addAttribute("sum_billPrice", sum_billPrice);
        model.addAttribute("sum_payPrice", sum_payPrice);
    	
    	model.addAttribute("summary_edit_type", paramMap.get("summary_edit_type"));		//ajax 에 보여줄 모드
    	model.addAttribute("suim_rpt_no",paramMap.get("suim_rpt_no"));
    	model.addAttribute("rowSpan", rowSpan);
    	
    	String sUrl = "top_suim_reportissue/ajax/ajax_samsung_jemul_summary";
    	
    	return sUrl;
    }
    
    @RequestMapping(value = "/ajax/ajax_heungkuk_jemul_summary")			//흥국생명 총괄표 목록 by top3009
    public String reportIssueHeungkukJemulSummary(HttpServletRequest request, Model model){		    	
    	
    	//top_rpt_issue_cont_lotte 테이블에서 등록된 보험목적물 정보를 가져온다.
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String sCtype = request.getParameter("ctype");				//보험타입구분 ( C: 재물보험, B: 배상책임보험 )
    	
    	//기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);  		//자기부담금정보추가      
                
        //세부정보가져오기
        SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);
        
        //비고 추가.
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        //총괄표 정보 가져오기
        List<Map<String, Object>> rptIssueSummaryList = sqlSession.selectList("RptIssueMapper.selectRptIssueSummaryLotte", paramMap);
    	
        int rowSpan = rptIssueSummaryList.size();
        
    	/**
         * view페이지 셋팅
         */
        model.addAttribute("rptIssueMain", rptIssueMain);
        model.addAttribute("suimVO",suimVo);
        model.addAttribute("rptIssue",rptIssue);
        model.addAttribute("rptIssueSummaryList", rptIssueSummaryList);
        model.addAttribute("ctype",sCtype);				//보험타입구분 ( C: 재물보험, B: 배상책임보험, I: 인보험 )
        
        //합계값 셋팅
        long sum_joinPrice = 0;
        long sum_insuPrice = 0;
        long sum_lossPrice = 0;
        long sum_remainPrice = 0;
        long sum_responPrice = 0;        
        long sum_compLimitPrice = 0;
        long sum_compResponPrice = 0;      
        long sum_selfOptPrice = 0;
        long sum_netLossPrice = 0;
        long sum_lossCompPrice = 0;
        long sum_billPrice = 0;
        long sum_payPrice = 0;
        
        //합계 계산 로직 추가 by top3009        
        for( int i=0; i < rptIssueSummaryList.size(); i++ ) {
        	sum_joinPrice += Long.parseLong(rptIssueSummaryList.get(i).get("joinPrice").toString());
        	sum_insuPrice += Long.parseLong(rptIssueSummaryList.get(i).get("insuPrice").toString());
        	sum_lossPrice += Long.parseLong(rptIssueSummaryList.get(i).get("lossPrice").toString());
        	sum_remainPrice += Long.parseLong(rptIssueSummaryList.get(i).get("remainPrice").toString());
        	sum_responPrice += Long.parseLong(rptIssueSummaryList.get(i).get("responPrice").toString());
        	sum_netLossPrice += Long.parseLong(rptIssueSummaryList.get(i).get("netLossPrice").toString());		//삼성추가        	
        	sum_compLimitPrice += Long.parseLong(rptIssueSummaryList.get(i).get("compLimitPrice").toString());
        	sum_compResponPrice += Long.parseLong(rptIssueSummaryList.get(i).get("compResponPrice").toString());
        	sum_selfOptPrice += Long.parseLong(rptIssueSummaryList.get(i).get("selfOptPrice").toString());
        	sum_lossCompPrice += Long.parseLong(rptIssueSummaryList.get(i).get("lossCompPrice").toString());		//삼성추가
        	sum_billPrice += Long.parseLong(rptIssueSummaryList.get(i).get("billPrice").toString());		//삼성추가
        	sum_payPrice += Long.parseLong(rptIssueSummaryList.get(i).get("payPrice").toString());		//삼성추가        	
        }        

        model.addAttribute("sum_joinPrice", sum_joinPrice);
        model.addAttribute("sum_insuPrice", sum_insuPrice);
        model.addAttribute("sum_lossPrice", sum_lossPrice);
        model.addAttribute("sum_remainPrice", sum_remainPrice);
        model.addAttribute("sum_responPrice", sum_responPrice);
        model.addAttribute("sum_netLossPrice", sum_netLossPrice);
        model.addAttribute("sum_compLimitPrice", sum_compLimitPrice);
        model.addAttribute("sum_compResponPrice", sum_compResponPrice);
        model.addAttribute("sum_selfOptPrice", sum_selfOptPrice);
        model.addAttribute("sum_lossCompPrice", sum_lossCompPrice);
        model.addAttribute("sum_billPrice", sum_billPrice);
        model.addAttribute("sum_payPrice", sum_payPrice);
    	
    	model.addAttribute("summary_edit_type", paramMap.get("summary_edit_type"));		//ajax 에 보여줄 모드
    	model.addAttribute("suim_rpt_no",paramMap.get("suim_rpt_no"));
    	model.addAttribute("rowSpan", rowSpan);
    	
    	String sUrl = "top_suim_reportissue/ajax/ajax_heungkuk_jemul_summary";
    	
    	return sUrl;
    }
    
    @RequestMapping(value = "/ajax/ajax_lotte_jemul_summary")			//총괄표 목록 가져오기 방식으로 수정 by top3009
    public String reportIssueLotteJemulSummary(HttpServletRequest request, Model model){		    	
    	
    	//top_rpt_issue_cont_lotte 테이블에서 등록된 보험목적물 정보를 가져온다.
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String sCtype = request.getParameter("ctype");				//보험타입구분 ( C: 재물보험, B: 배상책임보험 )
    	
    	//기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);  		//자기부담금정보추가      
                
        //세부정보가져오기
        SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);
        
        //비고 추가.
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        //총괄표 정보 가져오기
        List<Map<String, Object>> rptIssueSummaryList = sqlSession.selectList("RptIssueMapper.selectRptIssueSummaryLotte", paramMap);
    	
        int rowSpan = rptIssueSummaryList.size();
        
    	/**
         * view페이지 셋팅
         */
        model.addAttribute("rptIssueMain", rptIssueMain);
        model.addAttribute("suimVO",suimVo);
        model.addAttribute("rptIssue",rptIssue);
        model.addAttribute("rptIssueSummaryList", rptIssueSummaryList);
        model.addAttribute("ctype",sCtype);				//보험타입구분 ( C: 재물보험, B: 배상책임보험 )
        
        //합계값 셋팅
        long sum_joinPrice = 0;
        long sum_insuPrice = 0;
        long sum_lossPrice = 0;
        long sum_remainPrice = 0;
        long sum_responPrice = 0;        
        long sum_compLimitPrice = 0;
        long sum_compResponPrice = 0;      
        long sum_selfOptPrice = 0;
        
        //합계 계산 로직 추가 by top3009        
        for( int i=0; i < rptIssueSummaryList.size(); i++ ) {
        	sum_joinPrice += Long.parseLong(rptIssueSummaryList.get(i).get("joinPrice").toString());
        	sum_insuPrice += Long.parseLong(rptIssueSummaryList.get(i).get("insuPrice").toString());
        	sum_lossPrice += Long.parseLong(rptIssueSummaryList.get(i).get("lossPrice").toString());
        	sum_remainPrice += Long.parseLong(rptIssueSummaryList.get(i).get("remainPrice").toString());
        	sum_responPrice += Long.parseLong(rptIssueSummaryList.get(i).get("responPrice").toString());
        	sum_compLimitPrice += Long.parseLong(rptIssueSummaryList.get(i).get("compLimitPrice").toString());
        	sum_compResponPrice += Long.parseLong(rptIssueSummaryList.get(i).get("compResponPrice").toString());
        	sum_selfOptPrice += Long.parseLong(rptIssueSummaryList.get(i).get("selfOptPrice").toString());        	
        }        

        model.addAttribute("sum_joinPrice", sum_joinPrice);
        model.addAttribute("sum_insuPrice", sum_insuPrice);
        model.addAttribute("sum_lossPrice", sum_lossPrice);
        model.addAttribute("sum_remainPrice", sum_remainPrice);
        model.addAttribute("sum_responPrice", sum_responPrice);
        model.addAttribute("sum_compLimitPrice", sum_compLimitPrice);
        model.addAttribute("sum_compResponPrice", sum_compResponPrice);
        model.addAttribute("sum_selfOptPrice", sum_selfOptPrice);
    	
    	model.addAttribute("summary_edit_type", paramMap.get("summary_edit_type"));		//ajax 에 보여줄 모드
    	model.addAttribute("suim_rpt_no",paramMap.get("suim_rpt_no"));
    	model.addAttribute("rowSpan", rowSpan);
    	
    	String sUrl = "top_suim_reportissue/ajax/ajax_lotte_jemul_summary";
    	
    	return sUrl;
    }
    
    /**
     * 악사손해보험 계약사항 가져오기
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/ajax/ajax_axa_summary")			//총괄표 목록 가져오기 방식으로 수정 by top3009
    public String reportIssueAxaSummary(HttpServletRequest request, Model model){		    	
    	
    	logger.info("============ ajax_axa_summary ===========");
    	
    	//top_rpt_issue_cont_lotte 테이블에서 등록된 보험목적물 정보를 가져온다.
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String sCtype = request.getParameter("ctype");				//보험타입구분 ( C: 재물보험, B: 배상책임보험 )
    	
    	//Axa 손해보험용 총괄표 정보가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportAxaSummary", paramMap);        
       
    	/**
         * view페이지 셋팅
         */
        model.addAttribute("rptIssueMain", rptIssueMain);
        
        model.addAttribute("summary_edit_type", paramMap.get("summary_edit_type"));		//ajax 에 보여줄 모드    	
    	model.addAttribute("suim_rpt_no",paramMap.get("suim_rpt_no"));    	
    	model.addAttribute("ctype",sCtype);				//보험타입구분 ( C: 재물보험, B: 배상책임보험 )
    	
    	//logger.info("rptIssueContList Size="+rptIssueContList.size()+" : "+paramMap.get("cont_edit_type")+" : "+paramMap.get("suim_rpt_no"));
    	
    	String sUrl = "top_suim_reportissue/ajax/ajax_axa_summary";
    	
    	return sUrl;
    }
    
    /**
     * 악사손해보험 계약사항 가져오기
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/ajax/ajax_axa")			//계약사항 목록 가져오기 방식으로 수정 by top3009
    public String reportIssueAxa(HttpServletRequest request, Model model){		    	
    	
    	//top_rpt_issue_cont_lotte 테이블에서 등록된 보험목적물 정보를 가져온다.
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String sCtype = request.getParameter("ctype");				//보험타입구분 ( C: 재물보험, B: 배상책임보험 )
    	
    	//기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);        

        //조사자 정보
        paramMap.put("user_no", rptIssueMain.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
        
        //세부정보가져오기
        SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);
        
        //수임주소지로 추가.
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
    	//계약사항 보험목적물 정보 가져오기
    	List<Map<String, Object>> rptIssueContList = sqlSession.selectList("RptIssueMapper.selectRptIssueContLotte", paramMap);
    	
    	int rowSpan = rptIssueContList.size();    	
    	
    	/**
         * view페이지 셋팅
         */
        model.addAttribute("rptIssueMain", rptIssueMain);
        model.addAttribute("suimVO",suimVo);
        model.addAttribute("reportInvgUser", reportInvgUser);
        model.addAttribute("rptIssue", rptIssue);									//수임주소지로 인한 추가.                        
    	
    	model.addAttribute("cont_edit_type", paramMap.get("cont_edit_type"));		//ajax 에 보여줄 모드
    	model.addAttribute("suim_rpt_no",paramMap.get("suim_rpt_no"));
    	model.addAttribute("rowSpan", rowSpan);							//표에 들어가 rowSpan
    	model.addAttribute("rptIssueContList", rptIssueContList);							//보험목적물 리스트
    	model.addAttribute("ctype",sCtype);				//보험타입구분 ( C: 재물보험, B: 배상책임보험 )
    	
    	//logger.info("rptIssueContList Size="+rptIssueContList.size()+" : "+paramMap.get("cont_edit_type")+" : "+paramMap.get("suim_rpt_no"));
    	
    	//String sUrl = "top_suim_reportissue/ajax/ajax_samsung_jemul";
    	String sUrl = "top_suim_reportissue/ajax/ajax_axa";
    	
    	return sUrl;
    }
    
    @RequestMapping(value = "/ajax/ajax_samsung_jemul")			//계약사항 목록 가져오기 방식으로 수정 by top3009
    public String reportIssueSamsungJemul(HttpServletRequest request, Model model){		    	
    	
    	//top_rpt_issue_cont_lotte 테이블에서 등록된 보험목적물 정보를 가져온다.
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String sCtype = request.getParameter("ctype");				//보험타입구분 ( C: 재물보험, B: 배상책임보험 )
    	
    	//기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);        

        //조사자 정보
        paramMap.put("user_no", rptIssueMain.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
        
        //세부정보가져오기
        SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);
        
        //수임주소지로 추가.
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
    	//계약사항 보험목적물 정보 가져오기
    	List<Map<String, Object>> rptIssueContList = sqlSession.selectList("RptIssueMapper.selectRptIssueContLotte", paramMap);
    	
    	int rowSpan = rptIssueContList.size();    	
    	
    	/**
         * view페이지 셋팅
         */
        model.addAttribute("rptIssueMain", rptIssueMain);
        model.addAttribute("suimVO",suimVo);
        model.addAttribute("reportInvgUser", reportInvgUser);
        model.addAttribute("rptIssue", rptIssue);									//수임주소지로 인한 추가.                        
    	
    	model.addAttribute("cont_edit_type", paramMap.get("cont_edit_type"));		//ajax 에 보여줄 모드
    	model.addAttribute("suim_rpt_no",paramMap.get("suim_rpt_no"));
    	model.addAttribute("rowSpan", rowSpan);							//표에 들어가 rowSpan
    	model.addAttribute("rptIssueContList", rptIssueContList);							//보험목적물 리스트
    	model.addAttribute("ctype",sCtype);				//보험타입구분 ( C: 재물보험, B: 배상책임보험 )
    	
    	//logger.info("rptIssueContList Size="+rptIssueContList.size()+" : "+paramMap.get("cont_edit_type")+" : "+paramMap.get("suim_rpt_no"));
    	
    	String sUrl = "top_suim_reportissue/ajax/ajax_samsung_jemul";
    	
    	return sUrl;
    }
    
    @RequestMapping(value = "/ajax/ajax_lotte_jemul")			//계약사항 목록 가져오기 방식으로 수정 by top3009
    public String reportIssueLotteJemul(HttpServletRequest request, Model model){		    	
    	
    	//top_rpt_issue_cont_lotte 테이블에서 등록된 보험목적물 정보를 가져온다.
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String sCtype = request.getParameter("ctype");				//보험타입구분 ( C: 재물보험, B: 배상책임보험 )
    	
    	//기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);        

        //조사자 정보
        paramMap.put("user_no", rptIssueMain.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
        
        //세부정보가져오기
        SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);
        
        //수임주소지로 추가.
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
    	//계약사항 보험목적물 정보 가져오기
    	List<Map<String, Object>> rptIssueContList = sqlSession.selectList("RptIssueMapper.selectRptIssueContLotte", paramMap);
    	
    	int rowSpan = rptIssueContList.size();    	
    	
    	/**
         * view페이지 셋팅
         */
        model.addAttribute("rptIssueMain", rptIssueMain);
        model.addAttribute("suimVO",suimVo);
        model.addAttribute("reportInvgUser", reportInvgUser);
        model.addAttribute("rptIssue", rptIssue);									//수임주소지로 인한 추가.                        
    	
    	model.addAttribute("cont_edit_type", paramMap.get("cont_edit_type"));		//ajax 에 보여줄 모드
    	model.addAttribute("suim_rpt_no",paramMap.get("suim_rpt_no"));
    	model.addAttribute("rowSpan", rowSpan);							//표에 들어가 rowSpan
    	model.addAttribute("rptIssueContList", rptIssueContList);							//보험목적물 리스트
    	model.addAttribute("ctype",sCtype);				//보험타입구분 ( C: 재물보험, B: 배상책임보험 )
    	
    	//logger.info("rptIssueContList Size="+rptIssueContList.size()+" : "+paramMap.get("cont_edit_type")+" : "+paramMap.get("suim_rpt_no"));
    	
    	String sUrl = "top_suim_reportissue/ajax/ajax_lotte_jemul";
    	
    	return sUrl;
    }
    
    /**
     * 이메일 발송용 손해사정서 발송페이지
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/ajax/ajax_email_send")
    public String reportIssueEmailSend(HttpServletRequest request, Model model){    	
    	
    	logger.info("======== reportIssueEmailSend ========");
    	
    	//top_rpt_issue_cont_lotte 테이블에서 등록된 보험목적물 정보를 가져온다.
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	//today 시간설정 시작
        Calendar cal = Calendar.getInstance();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
        String sToday = df.format(cal.getTime());
        
        List<Map<String, Object>> rptIssueSendList = sqlSession.selectList("RptIssueMapper.selectRptIssueSend", paramMap);
        SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);
        
        /*손해사정서 교부동의서 시작*/
        List<SuimRptOrgFileVO> rptIssueFileList  = sqlSession.selectList("SuimBookDtlMapper.rptIssueFileList", suimVo.getSuim_rpt_no());
        model.addAttribute("rptIssueFileList", rptIssueFileList);
        /*손해사정서 교부동의서 끝*/
        
    	model.addAttribute("rptIssueSendList", rptIssueSendList);
    	model.addAttribute("send_edit_type", request.getParameter("send_edit_type"));		//ajax 에 보여줄 모드
    	model.addAttribute("sToday", sToday);
    	model.addAttribute("suimVO",suimVo);
    	
    	String sUrl = "top_suim_reportissue/ajax/ajax_email_send";
    	
    	return sUrl;
    }
    
    @RequestMapping(value = "/ajax/ajax_lotte_send")			//손해사정서 발송페이지 분리
    public String reportIssueLotteJemulSend(HttpServletRequest request, Model model){    	
    	
    	//top_rpt_issue_cont_lotte 테이블에서 등록된 보험목적물 정보를 가져온다.
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	//today 시간설정 시작
        Calendar cal = Calendar.getInstance();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
        String sToday = df.format(cal.getTime());
        
        List<Map<String, Object>> rptIssueSendList = sqlSession.selectList("RptIssueMapper.selectRptIssueSend", paramMap);
        SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);
        
        /*손해사정서 교부동의서 시작*/
        List<SuimRptOrgFileVO> rptIssueFileList  = sqlSession.selectList("SuimBookDtlMapper.rptIssueFileList", suimVo.getSuim_rpt_no());
        model.addAttribute("rptIssueFileList", rptIssueFileList);
        /*손해사정서 교부동의서 끝*/
        
    	model.addAttribute("rptIssueSendList", rptIssueSendList);
    	model.addAttribute("send_edit_type", request.getParameter("send_edit_type"));		//ajax 에 보여줄 모드
    	model.addAttribute("sToday", sToday);
    	model.addAttribute("suimVO",suimVo);
    	
    	String sUrl = "top_suim_reportissue/ajax/ajax_lotte_send";
    	
    	return sUrl;
    }
    
	/*
	 * @RequestMapping(value = "/ajax/ajax_lotte_sendlist") //손해사정서 발송페이지 목록 public
	 * String reportIssueLotteJemulSendlist(HttpServletRequest request, Model
	 * model){
	 * 
	 * //top_rpt_issue_cont_lotte 테이블에서 등록된 보험목적물 정보를 가져온다. Map<String, Object>
	 * paramMap = RequestUtil.getParameterMap(request);
	 * 
	 * SuimRptCompositeVO suimVo =
	 * sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);
	 * 
	 * Map<String, Object> rptIssueSend =
	 * sqlSession.selectOne("RptIssueMapper.selectRptIssueSend", paramMap);
	 * 
	 * model.addAttribute("send_edit_type", request.getParameter("send_edit_type"));
	 * //ajax 에 보여줄 모드 model.addAttribute("rptIssueSend", rptIssueSend);
	 * model.addAttribute("suimVO",suimVo);
	 * 
	 * String sUrl = "top_suim_reportissue/ajax/ajax_lotte_sendlist";
	 * 
	 * return sUrl; }
	 */
    
    @RequestMapping(value = "/ajax/ajax_lotte_write")			//날짜 직접변경페이지 분리
    public String reportIssueLotteJemulWrite(HttpServletRequest request, Model model){
    	
    	//top_rpt_issue_cont_lotte 테이블에서 등록된 보험목적물 정보를 가져온다.
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
    	
    	//DB 에 저장된 작성일자가 없으면 시스템 시간으로 넣어주고 DB 에 값이 있으면 그값으로 넣어준다. by top3009
    	if( rptIssue.get("writeDate") == null ) {
    		String sNow = DateUtil.getTodayString();
    	    sNow = DateUtil.getDateFormat(sNow, "-");
    	    model.addAttribute("nowdate", sNow);
    	}else {
    		model.addAttribute("nowdate", rptIssue.get("writeDate").toString());
    	}        
    	//DB 에 저장된 작성일자가 없으면 시스템 시간으로 넣어주고 DB 에 값이 있으면 그값으로 넣어준다. by oniku
    	
    	model.addAttribute("write_edit_type", request.getParameter("write_edit_type"));		//ajax 에 보여줄 모드    	    	
    	
    	String sUrl = "top_suim_reportissue/ajax/ajax_lotte_write";
    	
    	return sUrl;
    }
    
    @RequestMapping(value = "/ajax/ajax_samsung_write")			//날짜 직접변경페이지 분리
    public String reportIssueSamsungJemulWrite(HttpServletRequest request, Model model){
    	
    	//top_rpt_issue_cont_lotte 테이블에서 등록된 보험목적물 정보를 가져온다.
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
    	
    	//DB 에 저장된 작성일자가 없으면 시스템 시간으로 넣어주고 DB 에 값이 있으면 그값으로 넣어준다. by top3009
    	if( rptIssue.get("writeDate") == null ) {
    		String sNow = DateUtil.getTodayString();
    	    sNow = DateUtil.getDateFormat(sNow, "-");
    	    model.addAttribute("nowdate", sNow);
    	}else {
    		model.addAttribute("nowdate", rptIssue.get("writeDate").toString());
    	}        
    	//DB 에 저장된 작성일자가 없으면 시스템 시간으로 넣어주고 DB 에 값이 있으면 그값으로 넣어준다. by oniku
    	
    	model.addAttribute("write_edit_type", request.getParameter("write_edit_type"));		//ajax 에 보여줄 모드    	    	
    	
    	String sUrl = "top_suim_reportissue/ajax/ajax_samsung_write";
    	
    	return sUrl;
    }
    
    @RequestMapping(value = "/ajax/ajax_lotte_jemul_acc")			//계약사항 목록 가져오기 방식으로 수정 by top3009
    public String reportIssueLotteJemulAcc(HttpServletRequest request, Model model){		    	
    	
    	//top_rpt_issue_cont_lotte 테이블에서 등록된 보험목적물 정보를 가져온다.
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String sCtype = request.getParameter("ctype");				//보험타입구분 ( C: 재물보험, B: 배상책임보험 )
    	
        
        //세부정보가져오기
        SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);
        
        //top_rpt_issue 데이터 가져오기
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
    	
    	/**
         * view페이지 셋팅
         */        
        model.addAttribute("suimVO",suimVo);
        model.addAttribute("rptIssue", rptIssue);
    	
    	model.addAttribute("acc_edit_type", paramMap.get("acc_edit_type"));		//ajax 에 보여줄 모드
    	model.addAttribute("suim_rpt_no",paramMap.get("suim_rpt_no"));    	    	
    	model.addAttribute("ctype",sCtype);				//보험타입구분 ( C: 재물보험, B: 배상책임보험 )    	
    	
    	String sUrl = "top_suim_reportissue/ajax/ajax_lotte_jemul_acc";
    	
    	return sUrl;
    }
    
    /**
     * 악사 손해보험 사고사항 
     * @param request
     * @param model
     * @return
     */    
    @RequestMapping(value = "/ajax/ajax_axa_acc")			//사고사항 목록 가져오기 방식으로 수정 by top3009
    public String reportIssueAxaAcc(HttpServletRequest request, Model model){		    	
    	
    	//top_rpt_issue_cont_lotte 테이블에서 등록된 보험목적물 정보를 가져온다.
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String sCtype = request.getParameter("ctype");				//보험타입구분 ( C: 재물보험, B: 배상책임보험 )    	
        
        //세부정보가져오기
        SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);
        
        //top_rpt_issue 데이터 가져오기
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
    	
    	/**
         * view페이지 셋팅
         */        
        model.addAttribute("suimVO",suimVo);
        model.addAttribute("rptIssue", rptIssue);
    	
    	model.addAttribute("acc_edit_type", paramMap.get("acc_edit_type"));		//ajax 에 보여줄 모드
    	model.addAttribute("suim_rpt_no",paramMap.get("suim_rpt_no"));    	    	
    	model.addAttribute("ctype",sCtype);				//보험타입구분 ( C: 재물보험, B: 배상책임보험 )    	
    	
    	String sUrl = "top_suim_reportissue/ajax/ajax_axa_acc";
    	
    	return sUrl;
    }
    
    @RequestMapping(value = "/ajax/ajax_samsung_jemul_acc")			//계약사항 목록 가져오기 방식으로 수정 by top3009
    public String reportIssueSamsungJemulAcc(HttpServletRequest request, Model model){		    	
    	
    	//top_rpt_issue_cont_lotte 테이블에서 등록된 보험목적물 정보를 가져온다.
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String sCtype = request.getParameter("ctype");				//보험타입구분 ( C: 재물보험, B: 배상책임보험 )    	
        
        //세부정보가져오기
        SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);
        
        //top_rpt_issue 데이터 가져오기
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
    	
    	/**
         * view페이지 셋팅
         */        
        model.addAttribute("suimVO",suimVo);
        model.addAttribute("rptIssue", rptIssue);
    	
    	model.addAttribute("acc_edit_type", paramMap.get("acc_edit_type"));		//ajax 에 보여줄 모드
    	model.addAttribute("suim_rpt_no",paramMap.get("suim_rpt_no"));    	    	
    	model.addAttribute("ctype",sCtype);				//보험타입구분 ( C: 재물보험, B: 배상책임보험 )    	
    	
    	String sUrl = "top_suim_reportissue/ajax/ajax_samsung_jemul_acc";
    	
    	return sUrl;
    }
    
    @RequestMapping(value = "/ajax/ajax_heungkuk_jemul_acc")			//계약사항 목록 가져오기 방식으로 수정 by top3009
    public String reportIssueHeungkukJemulAcc(HttpServletRequest request, Model model){		    	
    	
    	//top_rpt_issue_cont_lotte 테이블에서 등록된 보험목적물 정보를 가져온다.
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String sCtype = request.getParameter("ctype");				//보험타입구분 ( C: 재물보험, B: 배상책임보험 )    	
        
        //세부정보가져오기
        SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);
        
        //top_rpt_issue 데이터 가져오기
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
    	
    	/**
         * view페이지 셋팅
         */        
        model.addAttribute("suimVO",suimVo);
        model.addAttribute("rptIssue", rptIssue);
    	
    	model.addAttribute("acc_edit_type", paramMap.get("acc_edit_type"));		//ajax 에 보여줄 모드
    	model.addAttribute("suim_rpt_no",paramMap.get("suim_rpt_no"));    	    	
    	model.addAttribute("ctype",sCtype);				//보험타입구분 ( C: 재물보험, B: 배상책임보험 )    	
    	
    	String sUrl = "top_suim_reportissue/ajax/ajax_heungkuk_jemul_acc";
    	
    	return sUrl;
    }
    
    @RequestMapping(value = "/rptissue_write_date_update")
    @ResponseBody
    public int rptissue_write_date_update(HttpServletRequest request, Model model){
    	logger.info("======== rptissue_write_date_update ========");
        
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        //기본정보 업데이트
        int udtCnt = sqlSession.update("RptIssueMapper.updateRptIssueWriteDate", paramMap);

        return udtCnt;
    }
    
    @RequestMapping(value = "/rptissue_ctype_update")
    @ResponseBody
    public int rptissue_ctype_update(HttpServletRequest request, Model model){
    	
    	logger.info("======== rptissue_ctype_update ========");
        
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        //기본정보 업데이트
        int udtCnt = sqlSession.update("RptIssueMapper.updateRptIssueContCtype", paramMap);
        udtCnt = sqlSession.update("RptIssueMapper.updateRptIssueSummaryCtype", paramMap);
    	
    	return udtCnt;
    }
    
    @RequestMapping(value = "/rptissue_acc_update")
    @ResponseBody
    public int rptissue_acc_update(HttpServletRequest request, Model model){
        
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        int udtCnt = 0;
        
        //사고날짜와 피해자 수정
        udtCnt = sqlSession.update("RptIssueMapper.updateRptIssueAccidentHead", paramMap);
        
        //사고주소 수정
        udtCnt = sqlSession.update("RptIssueMapper.updateRptIssueAccidentBodyAddr", paramMap);

        //사고내용 수정
        udtCnt = sqlSession.update("RptIssueMapper.updateInsuContent", paramMap);        
        
        logger.info("======== rptissue_acc_update ("+udtCnt+")========");

        return udtCnt;
    }
    
    
    @RequestMapping(value = "/rptissue_contract_update")
    public String rptissue_contract_update(HttpServletRequest request, Model model){
    	logger.info("======== rptissue_contract_update ========");
        
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        //인보험 분리를 위한 suim_rpt_type1 파라미터 추가
        String suim_rpt_type1 = request.getParameter("suim_rpt_type1") != null ? request.getParameter("suim_rpt_type1") : "";

        //===============================================
        // 비즈니스 로직
        //===============================================
        //기본정보 업데이트
        sqlSession.update("RptIssueMapper.updateRptIssueContract", paramMap);

        //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("rptIssueMain", rptIssueMain);
        model.addAttribute("suim_rpt_type1",suim_rpt_type1);
        
        return "top_suim_reportissue/ajax/print_contract";
    }
    
    /**
     * 메리츠 손해사정서 수임정보가져오기
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/getIssueSuimInfoMeritz")
    public String getIssueSuimInfoMeritz(HttpServletRequest request, Model model){
    	
    	logger.info("======== getIssueSuimInfoMeritz ========");
        
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        String suim_edit_type = String.valueOf(paramMap.get("suim_edit_type"));        
        
        //메리츠 수임정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportMeritzSuimInfo", paramMap);

        model.addAttribute("rptIssueMain", rptIssueMain);
        model.addAttribute("suim_edit_type", suim_edit_type);

        return "top_suim_reportissue/ajax/ajax_meritz_suim";
    }
    
    @RequestMapping(value = "/getIssueWriteDateMeritz")
    public String getIssueWriteDateMeritz(HttpServletRequest request, Model model){
    	
    	logger.info("======== getIssueWriteDateMeritz ========");
        
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        String suim_rpt_no = String.valueOf(paramMap.get("suim_rpt_no"));
        String write_edit_type = String.valueOf(paramMap.get("write_edit_type"));      
        
        String sWriteDate = "";
        
        Map<String,Object> writeDateMap = sqlSession.selectOne("RptIssueMapper.selectReportMeritzWriteDate", paramMap);
        
        sWriteDate = String.valueOf(writeDateMap.get("writeDateFmt"));        
        
        model.addAttribute("suim_rpt_no", suim_rpt_no);
        model.addAttribute("write_date", sWriteDate);
        model.addAttribute("write_edit_type", write_edit_type);

        return "top_suim_reportissue/ajax/ajax_meritz_write_day";
    }
    
    @RequestMapping(value = "/getIssueCoverageInfoMeritz")
    public String getIssueCoverageInfoMeritz(HttpServletRequest request, Model model){
    	
    	logger.info("======== getIssueCoverageInfoMeritz ========");
        
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        String suim_rpt_no = String.valueOf(paramMap.get("suim_rpt_no"));
        String coverage_edit_type = String.valueOf(paramMap.get("coverage_edit_type"));      
        
        //메리츠 담보정보 가져오기        
        List<Map<String, Object>> coverageInfoList = sqlSession.selectList("RptIssueMapper.selectReportMeritzCoverageInfo", paramMap);
        
        int rowSpan = coverageInfoList.size();

        model.addAttribute("rowSpan", rowSpan);
        model.addAttribute("suim_rpt_no", suim_rpt_no);
        model.addAttribute("coverageInfoList", coverageInfoList);
        model.addAttribute("coverage_edit_type", coverage_edit_type);

        return "top_suim_reportissue/ajax/ajax_meritz_coverage";
    }
    
    @RequestMapping(value = "/getIssueContractMeritz")
    public String getIssueContractMeritz(HttpServletRequest request, Model model){
    	
    	logger.info("======== getIssueContractMeritz ========");
        
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        String contract_edit_type = String.valueOf(paramMap.get("contract_edit_type"));        
        
        //메리츠 계약정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportMeritzContract", paramMap);

        model.addAttribute("rptIssueMain", rptIssueMain);
        model.addAttribute("contract_edit_type", contract_edit_type);

        return "top_suim_reportissue/ajax/ajax_meritz_contract";
    }    
    
    
    /**
     * 신규 기본보고서 계약사항 수정
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/rptissue_contract_new_update")
    public String rptissue_contract_new_update(HttpServletRequest request, Model model){
    	logger.info("======== rptissue_contract_new_update ========");
        
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        Damo damo = new Damo(); //디아모 암호화
        
        //인보험 분리를 위한 suim_rpt_type1 파라미터 추가
        String suim_rpt_type1 = request.getParameter("suim_rpt_type1") != null ? request.getParameter("suim_rpt_type1") : "";

        //===============================================
        // 비즈니스 로직
        //===============================================
        
        //보험계약사항에 계약자, 피보험자 정보 추가에 따른 수정
        String sOrgPol_tel = String.valueOf(paramMap.get("policyholder_tel"));
        String sOrgBen_tel = String.valueOf(paramMap.get("beneficiary_tel"));        
        
        //값이 있는경우 암호화 한다.
        if( !"".equals(sOrgPol_tel) ) {        	
        	paramMap.put("policyholder_tel", damo.encodeDamo(sOrgPol_tel));
        }
        
        if( !"".equals(sOrgBen_tel) ) {        	
        	paramMap.put("beneficiary_tel", damo.encodeDamo(sOrgBen_tel));
        }
        
        //기본정보 업데이트 (top_rpt_body)
        sqlSession.update("RptIssueMapper.updateRptIssueContract", paramMap);
        
        //기본정보 수정 (top_rpt_head 의 policyholder_nm, beneficiary_nm)
        sqlSession.update("RptIssueMapper.updateRptHeadAxa", paramMap);

        //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);
        
        //손해사정서 계약자, 피보험자 핸드폰 번호 시작
        SplitPhoneNo telSplit = new  SplitPhoneNo();
        String strDec = "";
        
        /*계약자 핸드폰*/        
        String sPolicyholder_tel = String.valueOf(rptIssueMain.get("policyholderTel"));        
        
        if( !"".equals(sPolicyholder_tel) ){        	
        	strDec = damo.decodeDamo(sPolicyholder_tel);        	
        	sPolicyholder_tel = strDec;
        	telSplit.splitPhoneNo(model, sPolicyholder_tel, "-", "policyholder_tel");	
        }else{
        	model.addAttribute("policyholder_tel_1", "");
        	model.addAttribute("policyholder_tel_2", "");
        	model.addAttribute("policyholder_tel_3", "");
        }
        /*피보험자 핸드폰*/
        String sBeneficiary_tel = String.valueOf(rptIssueMain.get("beneficiaryTel"));
        
        if( !"".equals(sBeneficiary_tel) ){
        	strDec = damo.decodeDamo(sBeneficiary_tel);
        	sBeneficiary_tel = strDec;
        	telSplit.splitPhoneNo(model, sBeneficiary_tel, "-", "beneficiary_tel");			
        }else{
        	model.addAttribute("beneficiary_tel_1", "");
        	model.addAttribute("beneficiary_tel_2", "");
        	model.addAttribute("beneficiary_tel_3", "");        	
        }        
        //손해사정서 계약자, 피보험자 핸드폰 번호 끝        
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("rptIssueMain", rptIssueMain);
        model.addAttribute("suim_rpt_type1",suim_rpt_type1);        

        return "top_suim_reportissue/ajax/print_contract_new";
    }
    
    /**
     * 메리츠 수임정보 갱신
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/updateMeritzSuimInfo")
    @ResponseBody
    public int updateMeritzSuimInfo(HttpServletRequest request, Model model){
    	
    	logger.info("======== updateMeritzSuimInfo ========");        

        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);        

        int udtCnt = sqlSession.update("RptIssueMapper.updateRptIssueMeritzSuimInfo", paramMap);

        return udtCnt;
    }
    
    /**
     * 메리츠 작성일자 정보 갱신
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/updateMeritzWriteDateInfo")
    @ResponseBody
    public int updateMeritzWriteDateInfo(HttpServletRequest request, Model model){
    	
    	logger.info("======== updateMeritzWriteDateInfo ========");        

        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        int udtCnt = sqlSession.update("RptIssueMapper.updateRptIssueMeritzWriteDate", paramMap);

        return udtCnt;
    }
    
    /**
     * 메리츠 계약사항 갱신
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/updateMeritzContractInfo")
    @ResponseBody
    public int updateMeritzContractInfo(HttpServletRequest request, Model model){
    	
    	logger.info("======== updateMeritzContractInfo ========");        

        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);        
        
        String insu_sdate = String.valueOf(paramMap.get("insu_term"));
        String insu_edate = String.valueOf(paramMap.get("insu_term_end"));
        
        String sInsuTerm = "";
        
        //계약기간의 시작 종료기간이 있는 경우 넣어준다.
        if( !"".equals(insu_sdate) || !"".equals(insu_edate)) {        	
        	sInsuTerm = insu_sdate +"~"+insu_edate;
        	paramMap.put("insu_term", sInsuTerm);
        }else{
        	paramMap.put("insu_term", "");
        }        

        int udtCnt = sqlSession.update("RptIssueMapper.updateRptIssueMeritzContractInfo", paramMap);        

        return udtCnt;        
    }
    
    
    /**
     * 손해액 및 보험금 사정에 크게 영향을 미친 사항 수정
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/updateLawReason")
    @ResponseBody
    public int updateLawReason(HttpServletRequest request, Model model){
    	logger.info("======== updateLawReason ========");
        
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);        

        //===============================================
        // 비즈니스 로직
        //===============================================
        //기본정보 업데이트
        int udtCnt = sqlSession.update("RptIssueMapper.updateRptIssueReason", paramMap);

        return udtCnt;
    }
    
    /**
     * 손해사정 시 적용된 관계 법규 및 약관 수정
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/updateLawSelContent")
    @ResponseBody
    public int updateLawSelContent(HttpServletRequest request, Model model){
    	logger.info("======== updateLawSelContent ========");
        
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);        

        //===============================================
        // 비즈니스 로직
        //===============================================
        //기본정보 업데이트
        int udtCnt = sqlSession.update("RptIssueMapper.updateRptIssueLawSel", paramMap);

        return udtCnt;
    }
    
    /**
     * 손해사정 시 적용된 관계 법규 및 약관 수정
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/updateLawEtcContent")
    @ResponseBody
    public int updateLawEtcContent(HttpServletRequest request, Model model){
    	logger.info("======== updateLawEtcContent ========");
        
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);        

        //===============================================
        // 비즈니스 로직
        //===============================================
        //기본정보 업데이트
        int udtCnt = sqlSession.update("RptIssueMapper.updateRptIssueLawContent", paramMap);

        return udtCnt;
    }
    
    /**
     * 손해사정시  적용된 관계 법규 및 약관 불러오기
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/getLawEtcContent")
    public String getLawEtcContent(HttpServletRequest request, Model model){
    	
    	logger.info("======== getLawEtcContent ========");
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String lawEtcContentFlag = request.getParameter("lawEtcContentFlag") != null ? request.getParameter("lawEtcContentFlag") : "view";    	
    	
    	Map<String, Object> lawEtcContentMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawContentInfo", paramMap);
    	
    	model.addAttribute("viewType", lawEtcContentFlag);
    	model.addAttribute("lawEtcContentInfo", lawEtcContentMap);
    	
    	return "top_suim_reportissue/ajax/law_etc_content";
    }
    
    /**
     * 손해사정시  적용된 관계 법규 및 약관 불러오기
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/getLawSelContent")
    public String getLawSelContent(HttpServletRequest request, Model model){
    	
    	logger.info("======== getLawSelContent ========");
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String lawSelContentFlag = request.getParameter("lawSelContentFlag") != null ? request.getParameter("lawSelContentFlag") : "view";
    	
    	Map<String, Object> lawSelContentMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawSelInfo", paramMap);
    	
    	model.addAttribute("viewType", lawSelContentFlag);
    	model.addAttribute("lawSelContentInfo", lawSelContentMap);
    	
    	return "top_suim_reportissue/ajax/law_sel_content";
    }
    
    /**
     * 손해사정시  적용된 관계 법규 및 약관 불러오기
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/getLawReason")
    public String getLawReason(HttpServletRequest request, Model model){
    	
    	logger.info("======== getLawReason ========");
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);    	
    	
    	String lawReasonFlag = request.getParameter("lawReasonFlag") != null ? request.getParameter("lawReasonFlag") : "view";
    	
    	Map<String, Object> lawReasonMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawReasonInfo", paramMap);
    	
    	model.addAttribute("viewType", lawReasonFlag);
    	model.addAttribute("lawReasonInfo", lawReasonMap);
    	
    	return "top_suim_reportissue/ajax/law_reason_content";
    }
    
    @RequestMapping(value = "/rptissue_accident_update")
    public String rptissue_accident_update(HttpServletRequest request, Model model){
    	logger.info("======== rptissue_accident_update ========");
        
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        //System.out.println(paramMap);

        //===============================================
        // 비즈니스 로직
        //===============================================        
        
        //기본정보 업데이트 : 손해사정서 수정시에는 보고서의 사고내용과 시간은 변경안함 by top3009
        sqlSession.update("RptIssueMapper.updateRptIssueAccidentHead", paramMap);
        //sqlSession.update("RptIssueMapper.updateRptIssueAccidentBody", paramMap);
        sqlSession.update("RptIssueMapper.updateInsuContent", paramMap);

        
        //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("rptIssueMain", rptIssueMain);
        model.addAttribute("rptIssue", rptIssue);
        
        return "top_suim_reportissue/ajax/print_accident";
    }
    
    @RequestMapping(value = "/rptissue_meritz_accident_update")
    public String rptissue_meritz_accident_update(HttpServletRequest request, Model model){
    	logger.info("======== rptissue_meritz_accident_update ========");
        
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        //기본정보 업데이트 : 손해사정서 수정시에는 보고서의 사고내용과 시간은 변경안함 by top3009
        sqlSession.update("RptIssueMapper.updateRptIssueAccidentHead", paramMap);

        sqlSession.update("RptIssueMapper.updateInsuContent", paramMap);
        
        //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("rptIssueMain", rptIssueMain);
        model.addAttribute("rptIssue", rptIssue);
        
        return "top_suim_reportissue/ajax/ajax_meritz_print_accident";
    }
    
    @RequestMapping(value = "/rptissue_abl_comment_update")
    public String rptissue_abl_comment_update(HttpServletRequest request, Model model){
    	logger.info("======== rptissue_abl_comment_update ========");
        
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String suimRptType1 = request.getParameter("suim_rpt_type1");

        //===============================================
        // 비즈니스 로직
        //===============================================
        //손해사정서교부 정보 업데이트
        sqlSession.update("RptIssueMapper.updateRptIssueAblComment", paramMap);

        
        //손해사정서교부 정보 가져오기
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("rptIssue", rptIssue);        

        String url ="top_suim_reportissue/ajax/print_abl_comment";       
        
        return url;
    }

    @RequestMapping(value = "/rptissue_law_update")
    public String rptissue_law_update(HttpServletRequest request, Model model){
    	logger.info("======== rptissue_law_update ========");
        
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String suimRptType1 = request.getParameter("suim_rpt_type1");

        //===============================================
        // 비즈니스 로직
        //===============================================
        //손해사정서교부 정보 업데이트
        sqlSession.update("RptIssueMapper.updateRptIssueLaw", paramMap);

        
        //손해사정서교부 정보 가져오기
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("rptIssue", rptIssue);
        
/*        String url ="top_suim_reportissue/ajax/print_law_other";*/
        String url ="top_suim_reportissue/ajax/print_law";        
        
        if ( !"2".equals(suimRptType1) && !"3".equals(suimRptType1) && !"4".equals(suimRptType1) ){
        	url ="top_suim_reportissue/ajax/print_law"; 
    	}
        
        return url;
    }
    
 
    @RequestMapping(value = "/rptissue_basis_update")
    public String rptissue_basis_update(HttpServletRequest request, Model model){
    	logger.info("======== rptissue_basis_update ========");
        
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        //손해사정서교부 정보 업데이트
        sqlSession.update("RptIssueMapper.updateRptIssueBasis", paramMap);

        
        //손해사정서교부 정보 가져오기
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("rptIssue", rptIssue);
        
        return "top_suim_reportissue/ajax/print_basis";
    }
    
    @RequestMapping(value = "/rptissue_insupayment_update")
    public String rptissue_insupament_update(HttpServletRequest request, Model model){
    	logger.info("======== rptissue_insupayment_update ========");
        
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        //손해사정서교부 정보 업데이트
        
        //String amt_insu_payment_disable = paramMap.get("amt_insu_payment_disable").toString();
        
    	sqlSession.update("RptIssueMapper.updateRptIssueAmtInsuPaymentDisable", paramMap);
    	sqlSession.update("RptIssueMapper.updateRptIssueInsupayment", paramMap);        
        
        //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("rptIssueMain", rptIssueMain);
        
        return "top_suim_reportissue/ajax/print_insupayment";
    }    
    
    
    @RequestMapping(value = "/rptissue_comment_update")
    public String rptissue_comment_update(HttpServletRequest request, Model model){
    	logger.info("======== rptissue_comment_update ========");
        
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        //손해사정서교부 정보 업데이트
        sqlSession.update("RptIssueMapper.updateRptIssueComment", paramMap);

        
        //손해사정서교부 정보 가져오기
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("rptIssue", rptIssue);
        
        return "top_suim_reportissue/ajax/print_comment";
    }    
/*    @RequestMapping(value = "/insu_content")
    public String insu_content(HttpServletRequest request, Model model){
    	logger.info("======== insu_content ========");
        
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        //손해사정서교부 정보 업데이트
        sqlSession.update("RptIssueMapper.updateInsuContent", paramMap);

        
        //손해사정서교부 정보 가져오기
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("rptIssue", rptIssue);
        
        return "top_suim_reportissue/ajax/print_accident";
    }  */      
    
    @RequestMapping(value = "/rptissue_law_modal")
    public String rptissue_law_modal(HttpServletRequest request, Model model){
    	logger.info("======== rptissue_law_modal ========");
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String gubun = "liability";
//        String gubun = request.getParameter("gubun");
        
        //===============================================
        // 비즈니스 로직
        //===============================================
        SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();
        List<SysAdmCodeDicVO> itemList = null;
        codeVo.setTbl_nm("top_rpt_issue");
        
        if ("liability".equals(gubun)){
        	codeVo.setCol_nm("reparation_liability_reason");
        	itemList = service.codeList2(codeVo);
        }
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("itemList",itemList);
        
        
        return "top_suim_reportissue/rpt_issue_law_modal";
    }
    
    
    @RequestMapping(value = "/rptissue_stb_option_select")
    @ResponseBody
    public List<SysAdmCodeDicVO> rptissue_stb_option_select(HttpServletRequest request, Model model, String gubun){
    	
        SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();
        codeVo.setTbl_nm("top_rpt_issue");
        if ("liability".equals(gubun)){
        	codeVo.setCol_nm("reparation_liability_reason");
        	
        	
        }else if ("insupayment".equals(gubun)){
        	codeVo.setCol_nm("insu_payment_reason");
        	
        	
        }
        
        List<SysAdmCodeDicVO> optionList = service.codeList(codeVo);
    	
    	
    	return optionList;
    }
    
    /**
     * 이메일 첨부발송용 손해사정서 발송 
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_Issue_send_action_mobile")
    @ResponseBody
    public int report_Issue_send_action_mobile(HttpServletRequest request, Model model, MultipartRequest requestFile) throws IOException {
    	
    	logger.info("======== report_Issue_send_action_mobile ========");
    	
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        int nRet = 0;
        
        String sTarget = request.getParameter("send_target");
        String suimRptNo = request.getParameter("suim_rpt_no");
        
        Date today = new Date();
		DateFormat timeForNaming = new SimpleDateFormat("yyyyMMddHHmmss");
		String sigan = timeForNaming.format(today);//String형으로 변환
		String year = sigan.substring(0, 4);
		String month = sigan.substring(4, 6);
		String day = sigan.substring(6, 8);
		
        //파일 업로드 경로		
  		String uppath = "/home/hosting_users/toplac/www/top_issue_report/"+year+"/"+month+"/"+day+"/"+suimRptNo+"/";		
  		long fileMaxSize = 5 * 1024 * 1024;				//5Mbype로 제한
  		
  		String fileName = "";				//원본파일명
  		String replaceName = "";			//암호화파일명
        
        //파일 체크 시작
        MultipartFile file = requestFile.getFile("mobile_attach_file");
        
        int isSecure = 0;		//파일 암호화 상태 여부 (0:평문, 1:암호화파일)
        int passSecure = 0;		//비밀번호 암호화 여부 (0:평문, 1:비밀번호 암호화)
		
        if( file.isEmpty() ) {			//파일이 없는경우
			nRet = 999;
		}else if( file.getSize() > fileMaxSize ) {			//파일이 5Mbyte가 넘는 경우
			nRet = 9999;
		}else{														//파일 용량 체크 완료
			//파일 정보 암호화
			String secuMsg = "This document is protected by ShadowCube Tech. & Policies.";		
			String sContent = new String(file.getBytes()).substring(0,100);
			
			if( sContent.contains(secuMsg) ) {
				isSecure = 1;
			}else{
				isSecure = 0;
			}
			
			//모바일 발송시 비밀번호 설정된 평문 파일만 첨부가능
			passSecure = CommonUtils.checkEncryptFile(file);
			
			if( isSecure == 1 ) {			//암호화된 파일로 첨부불가
				nRet = 9;
			}else if( passSecure == 0 ){
				nRet = 999999;				//비밀번호 미설정 파일로 첨부 불가
			}else{
				fileName = file.getOriginalFilename();			
				String fileType = fileName.substring(fileName.lastIndexOf("."), fileName.length());
				//암호화 된 8자리 값 생성
				String uid = UUID.randomUUID().toString().replaceAll("-", "").substring(0, 8);
				
				replaceName =  uid + fileType;  //파일 이름의 중복을 막기 위해서 이름을 재설정합니다.
				
				//System.out.println("orgFileName : "+fileName);
				//System.out.println("fileType : "+fileType);
				//System.out.println("encFileName : "+replaceName);				
				
				File dir = new File(uppath);
				if(!dir.exists()){
					dir.mkdirs();
				}

				try {
					FileUpload.fileUpload(file, uppath, replaceName);			
				} catch (IOException e) {
					nRet = 99999;
					e.printStackTrace();
				}
				
				paramMap.put("file_path", uppath);
		        paramMap.put("org_file_name", fileName);
		        paramMap.put("enc_file_name", replaceName);
		        
		        //CommonUtils.printMap(paramMap);
		        
		    	//교부대상자 구분대상자 추가(6:계약자+피보험자, 15:피보험자+보험청구권자, 16:계약자+피보험자+보험청구권자)에 따른 수정
		    	if( sTarget.equals("6") ) {		//계약자+피보험자
		    		paramMap.put("send_target", 1);
		    		sqlSession.insert("RptIssueMapper.insertRptIssueSendMobileAttach",paramMap);
		    		paramMap.put("send_target", 5);
		    		sqlSession.insert("RptIssueMapper.insertRptIssueSendMobileAttach",paramMap);
		    	}else if(sTarget.equals("15")) {
		    		paramMap.put("send_target", 5);
		    		sqlSession.insert("RptIssueMapper.insertRptIssueSendMobileAttach",paramMap);
		    		paramMap.put("send_target", 10);
		    		sqlSession.insert("RptIssueMapper.insertRptIssueSendMobileAttach",paramMap);
		    	}else if(sTarget.equals("16")){
		    		paramMap.put("send_target", 1);
		    		sqlSession.insert("RptIssueMapper.insertRptIssueSendMobileAttach",paramMap);
		    		paramMap.put("send_target", 5);
		    		sqlSession.insert("RptIssueMapper.insertRptIssueSendMobileAttach",paramMap);
		    		paramMap.put("send_target", 10);
		    		sqlSession.insert("RptIssueMapper.insertRptIssueSendMobileAttach",paramMap);
		    	}else {
		    		nRet = sqlSession.insert("RptIssueMapper.insertRptIssueSendMobileAttach",paramMap);		//첨부파일 이메일 발송 방식
		    	}		    	
				
			}
		}
        
    	return nRet;
    }    
    
    /**
     * 이메일 첨부발송용 손해사정서 발송 
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_Issue_send_action_email")
    @ResponseBody
    public int report_Issue_send_action_email(HttpServletRequest request, Model model, MultipartRequest requestFile) throws IOException {
    	
    	logger.info("======== report_Issue_send_action_email ========");
    	
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        int nRet = 0;
        
        String sTarget = request.getParameter("send_target");
        String suimRptNo = request.getParameter("suim_rpt_no");
        
        Date today = new Date();
		DateFormat timeForNaming = new SimpleDateFormat("yyyyMMddHHmmss");
		String sigan = timeForNaming.format(today);//String형으로 변환
		String year = sigan.substring(0, 4);
		String month = sigan.substring(4, 6);
		String day = sigan.substring(6, 8);
		
        //파일 업로드 경로		
  		String uppath = "/home/hosting_users/toplac/www/top_issue_report/"+year+"/"+month+"/"+day+"/"+suimRptNo+"/";		
  		long fileMaxSize = 5 * 1024 * 1024;				//5Mbype로 제한
  		
  		String fileName = "";				//원본파일명
  		String replaceName = "";			//암호화파일명
        
        //파일 체크 시작
        MultipartFile file = requestFile.getFile("email_attach_file");
        
        int isSecure = 0;		//파일 암호화 상태 여부 (0:평문, 1:암호화파일)
        int passSecure = 0;		//비밀번호 암호화 여부 (0:평문, 1:비밀번호 암호화)
		
        if( file.isEmpty() ) {			//파일이 없는경우
			nRet = 999;
		}else if( file.getSize() > fileMaxSize ) {			//파일이 5Mbyte가 넘는 경우
			nRet = 9999;
		}else{														//파일 용량 체크 완료
			//파일 정보 암호화
			String secuMsg = "This document is protected by ShadowCube Tech. & Policies.";		
			String sContent = new String(file.getBytes()).substring(0,100);
			
			if( sContent.contains(secuMsg) ) {
				isSecure = 1;
			}else{
				isSecure = 0;
			}
			
			passSecure = CommonUtils.checkEncryptFile(file);
			
			if( isSecure == 1 ) {			//암호화된파일로 첨부 불가
				nRet = 9;
			}else if( passSecure == 0 ) {
				nRet = 999999;				//비밀번호 미설정 파일로 첨부 불가
			}else{
				fileName = file.getOriginalFilename();			
				String fileType = fileName.substring(fileName.lastIndexOf("."), fileName.length());
				//암호화 된 8자리 값 생성
				String uid = UUID.randomUUID().toString().replaceAll("-", "").substring(0, 8);
				
				replaceName =  uid + fileType;  //파일 이름의 중복을 막기 위해서 이름을 재설정합니다.
				
				//System.out.println("orgFileName : "+fileName);
				//System.out.println("fileType : "+fileType);
				//System.out.println("encFileName : "+replaceName);
				
				if( !fileType.toUpperCase().equals(".PDF") ) {			//확장자가 pdf가 아닌 경우
					nRet = 99;
				}else{
					File dir = new File(uppath);
					if(!dir.exists()){
						dir.mkdirs();
					}

					try {
						FileUpload.fileUpload(file, uppath, replaceName);			
					} catch (IOException e) {
						nRet = 99999;
						e.printStackTrace();
					}
					
					paramMap.put("file_path", uppath);
			        paramMap.put("org_file_name", fileName);
			        paramMap.put("enc_file_name", replaceName);
			        
			        //CommonUtils.printMap(paramMap);

			    	//교부대상자 구분대상자 추가(6:계약자+피보험자, 15:피보험자+보험청구권자, 16:계약자+피보험자+보험청구권자)에 따른 수정
			    	if( sTarget.equals("6") ) {		//계약자+피보험자
			    		paramMap.put("send_target", 1);
			    		sqlSession.insert("RptIssueMapper.insertRptIssueSendEmailAttach",paramMap);
			    		paramMap.put("send_target", 5);
			    		sqlSession.insert("RptIssueMapper.insertRptIssueSendEmailAttach",paramMap);
			    	}else if(sTarget.equals("15")) {
			    		paramMap.put("send_target", 5);
			    		sqlSession.insert("RptIssueMapper.insertRptIssueSendEmailAttach",paramMap);
			    		paramMap.put("send_target", 10);
			    		sqlSession.insert("RptIssueMapper.insertRptIssueSendEmailAttach",paramMap);
			    	}else if(sTarget.equals("16")){
			    		paramMap.put("send_target", 1);
			    		sqlSession.insert("RptIssueMapper.insertRptIssueSendEmailAttach",paramMap);
			    		paramMap.put("send_target", 5);
			    		sqlSession.insert("RptIssueMapper.insertRptIssueSendEmailAttach",paramMap);
			    		paramMap.put("send_target", 10);
			    		sqlSession.insert("RptIssueMapper.insertRptIssueSendEmailAttach",paramMap);
			    	}else {
			    		//sqlSession.insert("RptIssueMapper.insertRptIssueSendLotte",paramMap);
			    		nRet = sqlSession.insert("RptIssueMapper.insertRptIssueSendEmailAttach",paramMap);		//첨부파일 이메일 발송 방식
			    	}
				}
			}
		}
        
    	return nRet;
    }
    
    
    @RequestMapping(value = "/report_Issue_send_action_lotte")
    @ResponseBody
    public int report_Issue_send_action_lotte(HttpServletRequest request, Model model){
    	logger.info("======== report_Issue_send_action ========");
    	
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);      
        String type= request.getParameter("type");
        
        int nRet = 0;
        
        String sTarget = request.getParameter("send_target");
        
        //System.out.println("complete_flag="+request.getParameter("complete_flag"));
        
        //손해사정서교부 정보 추가
        if ("C".equals(type)){        	
        	//교부대상자 구분대상자 추가(6:계약자+피보험자, 15:피보험자+보험청구권자, 16:계약자+피보험자+보험청구권자)에 따른 수정
        	if( sTarget.equals("6") ) {		//계약자+피보험자
        		paramMap.put("send_target", 1);
        		sqlSession.insert("RptIssueMapper.insertRptIssueSendLotte",paramMap);
        		paramMap.put("send_target", 5);
        		sqlSession.insert("RptIssueMapper.insertRptIssueSendLotte",paramMap);
        	}else if(sTarget.equals("15")) {
        		paramMap.put("send_target", 5);
        		sqlSession.insert("RptIssueMapper.insertRptIssueSendLotte",paramMap);
        		paramMap.put("send_target", 10);
        		sqlSession.insert("RptIssueMapper.insertRptIssueSendLotte",paramMap);
        	}else if(sTarget.equals("16")){
        		paramMap.put("send_target", 1);
        		sqlSession.insert("RptIssueMapper.insertRptIssueSendLotte",paramMap);
        		paramMap.put("send_target", 5);
        		sqlSession.insert("RptIssueMapper.insertRptIssueSendLotte",paramMap);
        		paramMap.put("send_target", 10);
        		sqlSession.insert("RptIssueMapper.insertRptIssueSendLotte",paramMap);
        	}else {
        		sqlSession.insert("RptIssueMapper.insertRptIssueSendLotte",paramMap);
        	}    		
        }            	
    	return nRet;
    }
    
    @RequestMapping(value = "/report_Issue_send_action")
    public String report_Issue_send_action(HttpServletRequest request, Model model){
    	logger.info("======== report_Issue_send_action ========");
    	
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);      
        String type= request.getParameter("type");
        
        //===============================================
        // 비즈니스 로직
        //===============================================
        //손해사정서교부 정보 업데이트
        if ("C".equals(type)){
    		sqlSession.insert("RptIssueMapper.insertRptIssueSend",paramMap);
        }else if ("D".equals(type)){
        	sqlSession.insert("RptIssueMapper.deleteRptIssueSend",paramMap);
        }else if ("U".equals(type)){
        	sqlSession.insert("RptIssueMapper.updateRptIssueSend",paramMap);
        }
        
        List<Map<String, Object>> rptIssueSendList = sqlSession.selectList("RptIssueMapper.selectRptIssueSend", paramMap);
        
        
    	model.addAttribute("rptIssueSendList",rptIssueSendList);
    	
    	return "top_suim_reportissue/ajax/print_issue_send";
    }
    
    @RequestMapping(value = "/report_Issue_send_axa_msg")
    @ResponseBody
    public Map<String, Object> report_Issue_send_axa_msg(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        Map<String, Object> resultMap = new HashMap<String,Object>();
        
        paramMap.put("ctype", request.getParameter("ctype"));
        
        String responseMsg = sendAxaKaKaoTalk(paramMap);        
    	
        JsonArray jsonArr = new JsonParser().parse(responseMsg).getAsJsonArray();
        JsonObject obj = (JsonObject) jsonArr.get(0);
        String code = obj.get("code").getAsString();
        String retMessage= obj.get("message").getAsString();
        JsonObject sData = (JsonObject)obj.get("data").getAsJsonObject();       
        
        //kakao 에서 받은 msgid 값을 저장한다.
        String sMsgid = sData.get("msgid").toString().replace("\"", "");
        
        //메시지 발송 상태값을 대기상태로 넣어준다.
        paramMap.put("send_state", 2);
        paramMap.put("msgid", sMsgid);        
                
        resultMap.put("RETURN_CODE", retMessage);
        
        if ("success".equals(code)){			//K(카카오),M(SMS)
        	//resultMap.put("RESULT_CODE", "0001");
        	//resultMap.put("RESULT_MSG", "카카오톡(문자) 발송에 성공 하였습니다..");
        	
        	if( retMessage.charAt(0) == 'K' ) {
        		resultMap.put("RESULT_MSG", "카카오톡 발송요청 하였습니다..");
        	}else if( retMessage.charAt(0) == 'M' ) {
        		resultMap.put("RESULT_MSG", "SMS 발송요청 하였습니다..");
        	}else {
        		resultMap.put("RESULT_MSG", "카카오톡(문자) 발송요청 하였습니다..");
        	}
        	
        	Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
    		String tel1 = String.valueOf(sendMap.get("tel1"));
    		String tel2 = String.valueOf(sendMap.get("tel2"));
    		String tel3 = String.valueOf(sendMap.get("tel3"));    		
    		
    		paramMap.put("tel1", tel1);
    		paramMap.put("tel2", tel2);
    		paramMap.put("tel3", tel3);
        	
        	//sqlSession.update("RptIssueMapper.updateRptIssueSendMagOk",paramMap);
    		
    		//같은 번호로 등록되어있는 경우 한건발송으로 다 처리된것으로 한다.
        	sqlSession.update("RptIssueMapper.updateRptIssueSendMagOkTel",paramMap);
        	
        }else{		//실패한 경우 분기        	
        	String dCode = retMessage.substring(0,1);
        	String dMessage = retMessage.substring(1,4);
        	//String dDesc = "";		//영문에러코드
        	String dErrinfo = "";		//국문에러설명
        	String dUflag = "";		//사용자에게 어떤 정보를 보여줄것인지 표시 (1: errinfo, 0:desc로 표시)
        	
        	//에러 코드를 bizm_error 테이블에서 가져온다.
        	paramMap.put("ecode", dCode);
        	paramMap.put("emessage", dMessage);
            Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            
            //dDesc = errorMsg.get("edesc").toString();
            dErrinfo = errorMsg.get("errinfo").toString();
            dUflag = errorMsg.get("uflag").toString();
            resultMap.put("RESULT_CHK", "fail");
            
            if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            	resultMap.put("RESULT_MSG", "카카오톡(문자) 발송에 실패 하였습니다.\n"+dErrinfo);
            }else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            	resultMap.put("RESULT_MSG", "카카오톡(문자) 발송에 실패 하였습니다.\nIT정보보호파트에 문의 바랍니다.\n"+retMessage);
            }
        }
        	
    	return resultMap;
    }
    
    @RequestMapping(value = "/report_Issue_send_samsung_msg")
    @ResponseBody
    public Map<String, Object> report_Issue_send_samsung_msg(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        Map<String, Object> resultMap = new HashMap<String,Object>();
        
        paramMap.put("ctype", request.getParameter("ctype"));
        
        String responseMsg = sendSamsungKaKaoTalk(paramMap);        
    	
        JsonArray jsonArr = new JsonParser().parse(responseMsg).getAsJsonArray();
        JsonObject obj = (JsonObject) jsonArr.get(0);
        String code = obj.get("code").getAsString();
        String retMessage= obj.get("message").getAsString();
        JsonObject sData = (JsonObject)obj.get("data").getAsJsonObject();       
        
        //kakao 에서 받은 msgid 값을 저장한다.
        String sMsgid = sData.get("msgid").toString().replace("\"", "");
        
        //메시지 발송 상태값을 대기상태로 넣어준다.
        paramMap.put("send_state", 2);
        paramMap.put("msgid", sMsgid);        
                
        resultMap.put("RETURN_CODE", retMessage);
        
        if ("success".equals(code)){			//K(카카오),M(SMS)
        	//resultMap.put("RESULT_CODE", "0001");
        	//resultMap.put("RESULT_MSG", "카카오톡(문자) 발송에 성공 하였습니다..");
        	
        	if( retMessage.charAt(0) == 'K' ) {
        		resultMap.put("RESULT_MSG", "카카오톡 발송요청 하였습니다..");
        	}else if( retMessage.charAt(0) == 'M' ) {
        		resultMap.put("RESULT_MSG", "SMS 발송요청 하였습니다..");
        	}else {
        		resultMap.put("RESULT_MSG", "카카오톡(문자) 발송요청 하였습니다..");
        	}
        	
        	Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
    		String tel1 = String.valueOf(sendMap.get("tel1"));
    		String tel2 = String.valueOf(sendMap.get("tel2"));
    		String tel3 = String.valueOf(sendMap.get("tel3"));    		
    		
    		paramMap.put("tel1", tel1);
    		paramMap.put("tel2", tel2);
    		paramMap.put("tel3", tel3);
        	
        	//sqlSession.update("RptIssueMapper.updateRptIssueSendMagOk",paramMap);
    		
    		//같은 번호로 등록되어있는 경우 한건발송으로 다 처리된것으로 한다.
        	sqlSession.update("RptIssueMapper.updateRptIssueSendMagOkTel",paramMap);
        	
        }else{		//실패한 경우 분기        	
        	String dCode = retMessage.substring(0,1);
        	String dMessage = retMessage.substring(1,4);
        	//String dDesc = "";		//영문에러코드
        	String dErrinfo = "";		//국문에러설명
        	String dUflag = "";		//사용자에게 어떤 정보를 보여줄것인지 표시 (1: errinfo, 0:desc로 표시)
        	
        	//에러 코드를 bizm_error 테이블에서 가져온다.
        	paramMap.put("ecode", dCode);
        	paramMap.put("emessage", dMessage);
            Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            
            //dDesc = errorMsg.get("edesc").toString();
            dErrinfo = errorMsg.get("errinfo").toString();
            dUflag = errorMsg.get("uflag").toString();
            resultMap.put("RESULT_CHK", "fail");
            
            if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            	resultMap.put("RESULT_MSG", "카카오톡(문자) 발송에 실패 하였습니다.\n"+dErrinfo);
            }else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            	resultMap.put("RESULT_MSG", "카카오톡(문자) 발송에 실패 하였습니다.\nIT정보보호파트에 문의 바랍니다.\n"+retMessage);
            }
        }
        	
    	return resultMap;
    }
    
    @RequestMapping(value = "/report_Issue_send_heungkuk_msg")
    @ResponseBody
    public Map<String, Object> report_Issue_send_heungkuk_msg(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        Map<String, Object> resultMap = new HashMap<String,Object>();
        
        paramMap.put("ctype", request.getParameter("ctype"));
        
        String responseMsg = sendHeungkukKaKaoTalk(paramMap);      		//흥국생명용 메시지 생성  
    	
        JsonArray jsonArr = new JsonParser().parse(responseMsg).getAsJsonArray();
        JsonObject obj = (JsonObject) jsonArr.get(0);
        String code = obj.get("code").getAsString();
        String retMessage= obj.get("message").getAsString();
        JsonObject sData = (JsonObject)obj.get("data").getAsJsonObject();       
        
        //kakao 에서 받은 msgid 값을 저장한다.
        String sMsgid = sData.get("msgid").toString().replace("\"", "");
        
        //메시지 발송 상태값을 대기상태로 넣어준다.
        paramMap.put("send_state", 2);
        paramMap.put("msgid", sMsgid);        
                
        resultMap.put("RETURN_CODE", retMessage);
        
        if ("success".equals(code)){			//K(카카오),M(SMS)
        	
        	if( retMessage.charAt(0) == 'K' ) {
        		resultMap.put("RESULT_MSG", "카카오톡 발송요청 하였습니다..");
        	}else if( retMessage.charAt(0) == 'M' ) {
        		resultMap.put("RESULT_MSG", "SMS 발송요청 하였습니다..");
        	}else {
        		resultMap.put("RESULT_MSG", "카카오톡(문자) 발송요청 하였습니다..");
        	}
        	
        	Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
    		String tel1 = String.valueOf(sendMap.get("tel1"));
    		String tel2 = String.valueOf(sendMap.get("tel2"));
    		String tel3 = String.valueOf(sendMap.get("tel3"));    		
    		
    		paramMap.put("tel1", tel1);
    		paramMap.put("tel2", tel2);
    		paramMap.put("tel3", tel3);
        	
        	//sqlSession.update("RptIssueMapper.updateRptIssueSendMagOk",paramMap);
    		
    		//같은 번호로 등록되어있는 경우 한건발송으로 다 처리된것으로 한다.
        	sqlSession.update("RptIssueMapper.updateRptIssueSendMagOkTel",paramMap);
        	
        }else{		//실패한 경우 분기        	
        	String dCode = retMessage.substring(0,1);
        	String dMessage = retMessage.substring(1,4);
        	//String dDesc = "";		//영문에러코드
        	String dErrinfo = "";		//국문에러설명
        	String dUflag = "";		//사용자에게 어떤 정보를 보여줄것인지 표시 (1: errinfo, 0:desc로 표시)
        	
        	//에러 코드를 bizm_error 테이블에서 가져온다.
        	paramMap.put("ecode", dCode);
        	paramMap.put("emessage", dMessage);
            Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            
            //dDesc = errorMsg.get("edesc").toString();
            dErrinfo = errorMsg.get("errinfo").toString();
            dUflag = errorMsg.get("uflag").toString();
            resultMap.put("RESULT_CHK", "fail");
            
            if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            	resultMap.put("RESULT_MSG", "카카오톡(문자) 발송에 실패 하였습니다.\n"+dErrinfo);
            }else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            	resultMap.put("RESULT_MSG", "카카오톡(문자) 발송에 실패 하였습니다.\nIT정보보호파트에 문의 바랍니다.\n"+retMessage);
            }
        }
        	
    	return resultMap;
    }
    
    @RequestMapping(value = "/report_Issue_send_lotte_msg")
    @ResponseBody
    public Map<String, Object> report_Issue_send_lotte_msg(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        Map<String, Object> resultMap = new HashMap<String,Object>();
        
        paramMap.put("ctype", request.getParameter("ctype"));
        
        String responseMsg = sendLotteKaKaoTalk(paramMap);        
    	
        JsonArray jsonArr = new JsonParser().parse(responseMsg).getAsJsonArray();
        JsonObject obj = (JsonObject) jsonArr.get(0);
        String code = obj.get("code").getAsString();
        String retMessage= obj.get("message").getAsString();
        JsonObject sData = (JsonObject)obj.get("data").getAsJsonObject();       
        
        //kakao 에서 받은 msgid 값을 저장한다.
        String sMsgid = sData.get("msgid").toString().replace("\"", "");
        
        //메시지 발송 상태값을 대기상태로 넣어준다.
        paramMap.put("send_state", 2);
        paramMap.put("msgid", sMsgid);        
                
        resultMap.put("RETURN_CODE", retMessage);
        
        if ("success".equals(code)){			//K(카카오),M(SMS)
        	//resultMap.put("RESULT_CODE", "0001");
        	//resultMap.put("RESULT_MSG", "카카오톡(문자) 발송에 성공 하였습니다..");
        	
        	if( retMessage.charAt(0) == 'K' ) {
        		resultMap.put("RESULT_MSG", "카카오톡 발송요청 하였습니다..");
        	}else if( retMessage.charAt(0) == 'M' ) {
        		resultMap.put("RESULT_MSG", "SMS 발송요청 하였습니다..");
        	}else {
        		resultMap.put("RESULT_MSG", "카카오톡(문자) 발송요청 하였습니다..");
        	}
        	
        	Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
    		String tel1 = String.valueOf(sendMap.get("tel1"));
    		String tel2 = String.valueOf(sendMap.get("tel2"));
    		String tel3 = String.valueOf(sendMap.get("tel3"));    		
    		
    		paramMap.put("tel1", tel1);
    		paramMap.put("tel2", tel2);
    		paramMap.put("tel3", tel3);
        	
        	//sqlSession.update("RptIssueMapper.updateRptIssueSendMagOk",paramMap);
    		
    		//같은 번호로 등록되어있는 경우 한건발송으로 다 처리된것으로 한다.
        	sqlSession.update("RptIssueMapper.updateRptIssueSendMagOkTel",paramMap);
        	
        }else{		//실패한 경우 분기        	
        	String dCode = retMessage.substring(0,1);
        	String dMessage = retMessage.substring(1,4);
        	//String dDesc = "";		//영문에러코드
        	String dErrinfo = "";		//국문에러설명
        	String dUflag = "";		//사용자에게 어떤 정보를 보여줄것인지 표시 (1: errinfo, 0:desc로 표시)
        	
        	//에러 코드를 bizm_error 테이블에서 가져온다.
        	paramMap.put("ecode", dCode);
        	paramMap.put("emessage", dMessage);
            Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            
            //dDesc = errorMsg.get("edesc").toString();
            dErrinfo = errorMsg.get("errinfo").toString();
            dUflag = errorMsg.get("uflag").toString();
            resultMap.put("RESULT_CHK", "fail");
            
            if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            	resultMap.put("RESULT_MSG", "카카오톡(문자) 발송에 실패 하였습니다.\n"+dErrinfo);
            }else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            	resultMap.put("RESULT_MSG", "카카오톡(문자) 발송에 실패 하였습니다.\nIT정보보호파트에 문의 바랍니다.\n"+retMessage);
            }
        }
        	
    	return resultMap;
    }
    
    @RequestMapping(value = "/report_Issue_send_abl_msg")
    @ResponseBody
    public Map<String, Object> report_Issue_send_abl_msg(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        Map<String, Object> resultMap = new HashMap<String,Object>();
                
        String responseMsg = sendKaKaoAblTalk(paramMap);        
    	
        JsonArray jsonArr = new JsonParser().parse(responseMsg).getAsJsonArray();
        JsonObject obj = (JsonObject) jsonArr.get(0);
        String code = obj.get("code").getAsString();
        String retMessage= obj.get("message").getAsString();
        JsonObject sData = (JsonObject)obj.get("data").getAsJsonObject();       
        
        //kakao 에서 받은 msgid 값을 저장한다.
        String sMsgid = sData.get("msgid").toString().replace("\"", "");
        
        //메시지 발송 상태값을 대기상태로 넣어준다.
        paramMap.put("send_state", 2);
        paramMap.put("msgid", sMsgid);        
                
        resultMap.put("RETURN_CODE", retMessage);
        
        if ("success".equals(code)){			//K(카카오),M(SMS)
        	
        	if( retMessage.charAt(0) == 'K' ) {
        		resultMap.put("RESULT_MSG", "카카오톡 발송요청 하였습니다..");
        	}else if( retMessage.charAt(0) == 'M' ) {
        		resultMap.put("RESULT_MSG", "SMS 발송요청 하였습니다..");
        	}else {
        		resultMap.put("RESULT_MSG", "카카오톡(문자) 발송요청 하였습니다..");
        	}
        	
        	Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
    		String tel1 = String.valueOf(sendMap.get("tel1"));
    		String tel2 = String.valueOf(sendMap.get("tel2"));
    		String tel3 = String.valueOf(sendMap.get("tel3"));    		
    		
    		paramMap.put("tel1", tel1);
    		paramMap.put("tel2", tel2);
    		paramMap.put("tel3", tel3);
        	
        	//sqlSession.update("RptIssueMapper.updateRptIssueSendMagOk",paramMap);
    		
    		//같은 번호로 등록되어있는 경우 한건발송으로 다 처리된것으로 한다.
        	sqlSession.update("RptIssueMapper.updateRptIssueSendMagOkTel",paramMap);
        	
        }else{		//실패한 경우 분기        	
        	String dCode = retMessage.substring(0,1);
        	String dMessage = retMessage.substring(1,4);
        	//String dDesc = "";		//영문에러코드
        	String dErrinfo = "";		//국문에러설명
        	String dUflag = "";		//사용자에게 어떤 정보를 보여줄것인지 표시 (1: errinfo, 0:desc로 표시)
        	
        	//에러 코드를 bizm_error 테이블에서 가져온다.
        	paramMap.put("ecode", dCode);
        	paramMap.put("emessage", dMessage);
            Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);            

            dErrinfo = errorMsg.get("errinfo").toString();
            dUflag = errorMsg.get("uflag").toString();
            resultMap.put("RESULT_CHK", "fail");
            
            if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            	resultMap.put("RESULT_MSG", "카카오톡(문자) 발송에 실패 하였습니다.\n"+dErrinfo);
            }else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            	resultMap.put("RESULT_MSG", "카카오톡(문자) 발송에 실패 하였습니다.\nIT정보보호파트에 문의 바랍니다.\n"+retMessage);
            }
        }
        	
    	return resultMap;
    }
    
    
    /**
     * 인보험용 문자발송 컨트롤러
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_Issue_send_pi_msg")
    @ResponseBody
    public Map<String, Object> report_Issue_send_pi_msg(HttpServletRequest request, Model model){
    	
    	logger.info("======== report_Issue_send_pi_msg ========");
    	
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        Map<String, Object> resultMap = new HashMap<String,Object>();
                
        String responseMsg = sendKaKaoPiTalk(paramMap);        
    	
        JsonArray jsonArr = new JsonParser().parse(responseMsg).getAsJsonArray();
        JsonObject obj = (JsonObject) jsonArr.get(0);
        String code = obj.get("code").getAsString();
        String retMessage= obj.get("message").getAsString();
        JsonObject sData = (JsonObject)obj.get("data").getAsJsonObject();       
        
        //kakao 에서 받은 msgid 값을 저장한다.
        String sMsgid = sData.get("msgid").toString().replace("\"", "");
        
        //메시지 발송 상태값을 대기상태로 넣어준다.
        paramMap.put("send_state", 2);
        paramMap.put("msgid", sMsgid);        
                
        resultMap.put("RETURN_CODE", retMessage);
        
        if ("success".equals(code)){			//K(카카오),M(SMS)
        	//resultMap.put("RESULT_CODE", "0001");
        	//resultMap.put("RESULT_MSG", "카카오톡(문자) 발송에 성공 하였습니다..");
        	
        	if( retMessage.charAt(0) == 'K' ) {
        		resultMap.put("RESULT_MSG", "카카오톡 발송요청 하였습니다..");
        	}else if( retMessage.charAt(0) == 'M' ) {
        		resultMap.put("RESULT_MSG", "SMS 발송요청 하였습니다..");
        	}else {
        		resultMap.put("RESULT_MSG", "카카오톡(문자) 발송요청 하였습니다..");
        	}
        	
        	Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
    		String tel1 = String.valueOf(sendMap.get("tel1"));
    		String tel2 = String.valueOf(sendMap.get("tel2"));
    		String tel3 = String.valueOf(sendMap.get("tel3"));    		
    		
    		paramMap.put("tel1", tel1);
    		paramMap.put("tel2", tel2);
    		paramMap.put("tel3", tel3);
        	
        	//sqlSession.update("RptIssueMapper.updateRptIssueSendMagOk",paramMap);
    		
    		//같은 번호로 등록되어있는 경우 한건발송으로 다 처리된것으로 한다.
        	sqlSession.update("RptIssueMapper.updateRptIssueSendMagOkTel",paramMap);
        	
        }else{		//실패한 경우 분기        	
        	String dCode = retMessage.substring(0,1);
        	String dMessage = retMessage.substring(1,4);
        	//String dDesc = "";		//영문에러코드
        	String dErrinfo = "";		//국문에러설명
        	String dUflag = "";		//사용자에게 어떤 정보를 보여줄것인지 표시 (1: errinfo, 0:desc로 표시)
        	
        	//에러 코드를 bizm_error 테이블에서 가져온다.
        	paramMap.put("ecode", dCode);
        	paramMap.put("emessage", dMessage);
            Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            
            //dDesc = errorMsg.get("edesc").toString();
            dErrinfo = errorMsg.get("errinfo").toString();
            dUflag = errorMsg.get("uflag").toString();
            resultMap.put("RESULT_CHK", "fail");
            
            if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            	resultMap.put("RESULT_MSG", "카카오톡(문자) 발송에 실패 하였습니다.\n"+dErrinfo);
            }else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            	resultMap.put("RESULT_MSG", "카카오톡(문자) 발송에 실패 하였습니다.\nIT정보보호파트에 문의 바랍니다.\n"+retMessage);
            }
        }
        	
    	return resultMap;
    }
    
    /**
     * 롯데손해 손해사정서 이메일 발송
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_Issue_send_lotte_email")
    @ResponseBody
    public Map<String, Object> report_Issue_send_lotte_email(HttpServletRequest request, Model model){
    	//===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        Map<String, Object> resultMap = new HashMap<String,Object>();
        
      //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        //계약자 정보가져오기
        SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);
        
        //보험목적물 계약정보 가져오기
        List<Map<String, Object>> rptIssueContList = sqlSession.selectList("RptIssueMapper.selectRptIssueContLotte", paramMap);
        
        //총괄표 정보 가져오기
        List<Map<String, Object>> rptIssueSummaryList = sqlSession.selectList("RptIssueMapper.selectRptIssueSummaryLotte", paramMap);
        
        String sCtypeName = "";
        
        String sCtype = paramMap.get("ctype").toString();		//보험타입 (C:재물보험, B:배상보험, T:여행자보험)
        if( sCtype.equals("C") ) {
        	sCtypeName = "보험목적물";
        }else {
        	sCtypeName = "계약약관";
        }
        
        //세부계약사항 메시지 만들기
        String sContContent = ""; 
        if( rptIssueContList.size() > 0 ) {
        	for(int i=0; i < rptIssueContList.size(); i++) {
        		Map<String, Object>map = rptIssueContList.get(i);
        		sContContent += map.get("contCate").toString()+" : "+map.get("contContent").toString()+"\n";
        	}
        }else {
        	sContContent = "내용없음\n";
        }
        
        //총괄표 세부사항 메시지 만들기
        String sSummaryContent = "";
        
        //합계계산하기
        long sum_joinPrice = 0;
        long sum_insuPrice = 0;
        long sum_lossPrice = 0;
        long sum_remainPrice = 0;
        long sum_responPrice = 0;        
        long sum_compLimitPrice = 0;
        long sum_compResponPrice = 0;      
        long sum_selfOptPrice = 0;
        long sum_netLossPrice = 0;
        long sum_lossCompPrice = 0;
        long sum_billPrice = 0;
        long sum_payPrice = 0;

        //합계 계산 로직 추가 by top3009        
        for( int i=0; i < rptIssueSummaryList.size(); i++ ) {
        	sum_joinPrice += Long.parseLong(rptIssueSummaryList.get(i).get("joinPrice").toString());
        	sum_insuPrice += Long.parseLong(rptIssueSummaryList.get(i).get("insuPrice").toString());
        	sum_lossPrice += Long.parseLong(rptIssueSummaryList.get(i).get("lossPrice").toString());
        	sum_remainPrice += Long.parseLong(rptIssueSummaryList.get(i).get("remainPrice").toString());
        	sum_responPrice += Long.parseLong(rptIssueSummaryList.get(i).get("responPrice").toString());
        	sum_netLossPrice += Long.parseLong(rptIssueSummaryList.get(i).get("netLossPrice").toString());		//삼성추가        	
        	sum_compLimitPrice += Long.parseLong(rptIssueSummaryList.get(i).get("compLimitPrice").toString());
        	sum_compResponPrice += Long.parseLong(rptIssueSummaryList.get(i).get("compResponPrice").toString());
        	sum_selfOptPrice += Long.parseLong(rptIssueSummaryList.get(i).get("selfOptPrice").toString());
        	sum_lossCompPrice += Long.parseLong(rptIssueSummaryList.get(i).get("lossCompPrice").toString());		//삼성추가
        	sum_billPrice += Long.parseLong(rptIssueSummaryList.get(i).get("billPrice").toString());		//삼성추가
        	sum_payPrice += Long.parseLong(rptIssueSummaryList.get(i).get("payPrice").toString());		//삼성추가        	
        }
        
        int nColspan = 6;
        
        if( sCtype.equals("C") ) {
        	if( rptIssueSummaryList.size() > 0 ) {
        		
        		nColspan = 5;
        		
        		sSummaryContent += "<tr>"
						+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>목적물</td>"
						+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>가입금액</td>"
						+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>보험가액</td>"
						+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>손해액</td>"
						+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>잔존물</td>"
						+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>약관상<br/>지급책임액</td>"
						+ "</tr>";
        		
            	for(int k=0; k < rptIssueSummaryList.size(); k++) {
            		Map<String, Object>smap = rptIssueSummaryList.get(k);            		
            		
            		sSummaryContent += "<tr>"
							+ "<td height='30' style='text-align: center;'>"+smap.get("summaryCate").toString()+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("joinPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("insuPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("lossPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("remainPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("responPrice").toString())+"</td>"
							+ "</tr>";
            		
            	}
            }else {
            	sSummaryContent += "<td height='30' colspan='6' style='text-align: center;'>내용없음</td>";
            }
        	
        	sSummaryContent += "<tr>"
					+ "<td height='30' style='text-align: center;font-weight:bold;'>합계</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_joinPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_insuPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_lossPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_remainPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_responPrice)+"</td>"
					+ "</tr>";        	
        	sSummaryContent += "<tr>"
					+ "<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>자기부담금</td>"
					+ "<td height='30' colspan='5' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(rptIssueMain.get("amtSelfPay").toString())+"</td>"
					+ "</tr>";
        	
        	//비고 null 처리
        	if( rptIssue.get("remarkVal") != null ) {
        		sSummaryContent += "<tr>"
    					+ "<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>비고</td>"
    					+ "<td height='30' colspan='5' style='text-align: left;padding-left:5px;font-weight:bold;'>"+rptIssue.get("remarkVal")+"</td>"
    					+ "</tr>";
        	}else {
        		sSummaryContent += "<tr>"
    					+ "<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>비고</td>"
    					+ "<td height='30' colspan='5' style='text-align: left;padding-left:5px;font-weight:bold;'> - </td>"
    					+ "</tr>";
        	}        	
        	
        }else if( sCtype.equals("B") ) {
        	
        	nColspan = 4;
        	
        	sSummaryContent += "<tr>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>구분</td>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>보상한도액</td>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>배상책임액</td>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>자기부담금</td>"					
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>약관상<br/>지급책임액</td>"
					+ "</tr>";
        	
        	if( rptIssueSummaryList.size() > 0 ) {
            	for(int k=0; k < rptIssueSummaryList.size(); k++) {
            		Map<String, Object>smap = rptIssueSummaryList.get(k);
            		
            		sSummaryContent += "<tr>"
							+ "<td height='30' style='text-align: center;'>"+smap.get("summaryCate").toString()+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("compLimitPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("compResponPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("selfOptPrice").toString())+"</td>"							
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("responPrice").toString())+"</td>"
							+ "</tr>";
            	}
            }else {
            	sSummaryContent += "<td height='30' colspan='5' style='text-align: center;'>내용없음</td>";
            }
        	
        	sSummaryContent += "<tr>"
					+ "<td height='30' style='text-align: center;font-weight:bold;'>합계</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_compLimitPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_compResponPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_selfOptPrice)+"</td>"					
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_responPrice)+"</td>"
					+ "</tr>";        	        
        	//비고 null 처리
        	if( rptIssue.get("remarkVal") != null ) {
        		sSummaryContent += "<tr>"
    					+ "<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>비고</td>"
    					+ "<td height='30' colspan='4' style='text-align: left;padding-left:5px;font-weight:bold;'>"+rptIssue.get("remarkVal")+"</td>"
    					+ "</tr>";
        	}else {
        		sSummaryContent += "<tr>"
    					+ "<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>비고</td>"
    					+ "<td height='30' colspan='4' style='text-align: left;padding-left:5px;font-weight:bold;'> - </td>"
    					+ "</tr>";
        	}
        }else if( sCtype.equals("T") ){
        	
        	nColspan = 5;
        	
        	sSummaryContent += "<tr>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>품목</td>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>가입금액</td>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>보험가액</td>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>손해액</td>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>자기부담금</td>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>약관상<br/>지급책임액</td>"
					+ "</tr>";
        	
        	if( rptIssueSummaryList.size() > 0 ) {
            	for(int k=0; k < rptIssueSummaryList.size(); k++) {
            		Map<String, Object>smap = rptIssueSummaryList.get(k);
            		
            		sSummaryContent += "<tr>"
							+ "<td height='30' style='text-align: center;'>"+smap.get("summaryCate").toString()+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("joinPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("insuPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("lossPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("selfOptPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("responPrice").toString())+"</td>"
							+ "</tr>";
            	}
            }else {
            	sSummaryContent += "<td height='30' colspan='6' style='text-align: center;'>내용없음</td>";
            }
        	
        	sSummaryContent += "<tr>"
					+ "<td height='30' style='text-align: center;font-weight:bold;'>합계</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_joinPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_insuPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_lossPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_selfOptPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_responPrice)+"</td>"
					+ "</tr>";
        	      
        	//비고 null 처리
        	if( rptIssue.get("remarkVal") != null ) {
        		sSummaryContent += "<tr>"
    					+ "<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>비고</td>"
    					+ "<td height='30' colspan='5' style='text-align: left;padding-left:5px;font-weight:bold;'>"+rptIssue.get("remarkVal")+"</td>"
    					+ "</tr>";
        	}else {
        		sSummaryContent += "<tr>"
    					+ "<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>비고</td>"
    					+ "<td height='30' colspan='5' style='text-align: left;padding-left:5px;font-weight:bold;'> - </td>"
    					+ "</tr>";
        	}
        }else {
        	sSummaryContent += "<td height='30' colspan='6' style='text-align: center;'>내용없음</td>";
        }

        //조사자 정보
        paramMap.put("user_no", rptIssueMain.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
		
		String suimAcceptNo 				= String.valueOf(rptIssueMain.get("suimAcceptNo"));
		String accidentNo 					= String.valueOf(rptIssueMain.get("accidentNo"));
		
		String insuranceNm 					= String.valueOf(rptIssueMain.get("insuranceNm"));
		String insuTerm 					= String.valueOf(rptIssueMain.get("insuTerm"));
		//자기부담금 단위, 자기부담금액
		String amtSelfPayUnit 				= String.valueOf(rptIssueMain.get("amtSelfPayUnit"));
		//int amtSelfPay 						= Integer.parseInt(String.valueOf(rptIssueMain.get("amtSelfPay")));				
		long amtSelfPay 						= Long.parseLong(String.valueOf(rptIssueMain.get("amtSelfPay")));
		String accidentDate5 				= String.valueOf(rptIssueMain.get("accidentDate5"));
		
		String insuContent 			        = String.valueOf(rptIssue.get("insuContent"));		
		//int amtInsuPayment 					= Integer.parseInt(String.valueOf(rptIssueMain.get("amtInsuPayment")));		
		long amtInsuPayment 					= Long.parseLong(String.valueOf(rptIssueMain.get("amtInsuPayment")));
		
		String userName 					= String.valueOf(reportInvgUser.get("userName"));
		String disWorkLevel 				= String.valueOf(reportInvgUser.get("disWorkLevel"));
		String handphone 					= String.valueOf(reportInvgUser.get("handphone"));
		String from_email 				= String.valueOf(reportInvgUser.get("email"));
		
		//발송할 email 정보
        Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
        String sToAddress = String.valueOf(sendMap.get("email"));
		
		//롯데 메시지 입력부
		
		//증권번호
		String sPolicyNo = String.valueOf(rptIssueMain.get("policyNo"));
		
		//소재지
		String sSuimAddress = String.valueOf(rptIssue.get("suimAddress")).replace("null", "");
		
		//전송시 계약자 피보험자 이름 두번째 글자 '*' 처리        
		String sHiddenPolicyNm = suimVo.getPolicyholder_nm().toString();
		String sHiddenBenefitNm = suimVo.getBeneficiary_nm().toString();

		if( !sHiddenPolicyNm.equals("") ) {        	
			if( sHiddenPolicyNm.length() == 1 ) {
				sHiddenPolicyNm = "*";
			}else {
				sHiddenPolicyNm = sHiddenPolicyNm.replace(sHiddenPolicyNm.charAt(1),'*');
			}        	        	
		}else {
			sHiddenPolicyNm = "";
		}

		if( !sHiddenBenefitNm.equals("") ) {
			if( sHiddenBenefitNm.length() == 1 ) {
				sHiddenBenefitNm = "*";
			}else {
				sHiddenBenefitNm = sHiddenBenefitNm.replace(sHiddenBenefitNm.charAt(1),'*');
			}        	
		}else {
			sHiddenBenefitNm = "";
		}
		
		//사고장소 
		//String investigate_addr1 = suimVo.getInvestigate_addr1().toString();		
		String investigate_addr1 = String.valueOf(suimVo.getInvestigate_addr1());		//null 처리
		//String investigate_addr2 = suimVo.getInvestigate_addr2().toString();
		String sAccPlace = "";
		
		if( !investigate_addr1.equals("") ) {
			sAccPlace = investigate_addr1; 
		}else{
			sAccPlace = "사고장소정보 미노출";
		}
		
		//직급이 수습인 경우 외부발송시 사원으로 변경
		String SendDisWorkLevel = "";
		if("수습".equals(disWorkLevel)) {
			SendDisWorkLevel = "사원";
		}else{
			SendDisWorkLevel = disWorkLevel;
		}
		
		//담당자 자격증(손해사정사) 정보 List 만들기 시작
		String sUserNo = String.valueOf(rptIssueMain.get("userNo"));
		List<Map<String, Object>> certiReportUser = null;					//보고서 하단에 들어갈 담당자 정보 List
		List<Map<String, Object>> certiManagerReportUser = null;		//담당손해사정사 목록

		//기 종결건은 담당손해사정사가 별도 저장되어있음 (top_rpt_certi_end) 저장된 손해사정사 정보가 별도로 있는지 체크
		int nEndCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiEndCnt",paramMap);

		if( nEndCnt == 0 ) {			//정보가 없는 경우 실시간으로 가져온다.
			
			if( !"0".equals(sUserNo) ) {		//0은 미배당건        	
			certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiMemberInfo", paramMap);
			
			int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
			
			nCertiManagerCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiManagerCnt", paramMap);
			
			if( nCertiManagerCnt > 0 ) {			//담당손해사정사가 있는 경우
				certiManagerReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiManagerList", paramMap);
				for( int i=0; i < certiManagerReportUser.size(); i++) {
					certiReportUser.add(certiManagerReportUser.get(i));		//보고서 하단에 들어갈 담당자 정보에 담당손해사정서를 추가한다.
				}
			}
		    }
			
		}else{								//정보가 있는 경우 top_rpt_certi_end 테이블에서 불러온다.
			certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiEndInfo", paramMap);
		}

		String sCertiMemberText = "";

		if( certiReportUser == null ) {			//미배상건
			sCertiMemberText = "	<tr>" +
						"		<td height='30' colspan='4' style='text-align: left; padding-left: 10px;'>미배당건으로 담당자 정보가 없습니다.</td>" + 
						"	</tr>" + 
						"	<tr>";
		}else{
			for( int i=0; i < certiReportUser.size(); i++) {
				sCertiMemberText +="	<tr>" +
						"<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>"+String.valueOf(certiReportUser.get(i).get("certi_state_val"))+"</td>" + 
						"<td height='30' style='text-align: left; padding-left: 10px;' colspan='4'>"+String.valueOf(certiReportUser.get(i).get("user_name"))+" (직인생략) "+
						 "(&#9742; "+String.valueOf(certiReportUser.get(i).get("work_phone"))+")</td>" + 
				"	</tr>"+        				
				"   <tr>"+
					"<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>등록번호</td>" + 
						"<td height='30' style='text-align: left; padding-left: 10px;' colspan='4'>"+String.valueOf(certiReportUser.get(i).get("certi_number"))+"</td>" +
				"	</tr>";
			}
		}
		//담당자 자격증(손해사정사) 정보 List 만들기 끝
		//손해사정서 양식 변경에 따라 항목 추가 끝
		
		
		int nColspanAll = nColspan+1;
		
		//이메일 내용 시작
		String sSubject = "[접수번호 : "+suimAcceptNo+"] 보험업법 제189조 소정의 규정에 의거하여 아래와 같이 손해사정서를 안내합니다.";
		
		String sContent = "<table style='border-collapse:collapse;width:800px;font-size:12px;font-weight:bold;letter-spacing:1px;' border='1'>" +
				"	<tr>" + 
				"		<td height='30' colspan='"+nColspanAll+"' style='text-align: center;' bgcolor='#EFF5FB'>보험업법 제189조 소정의 규정에 의거하여 아래와 같이 손해사정서를 안내합니다.</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>Report No</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' colspan='"+nColspan+"'><font color='blue'>"+suimAcceptNo+"</font></td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>손해사정</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' colspan='"+nColspan+"'>[사고번호 : "+accidentNo+"]</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='"+nColspanAll+"' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>1. 계약사항</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>가. 보험종목 / 증권번호</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' colspan='"+nColspan+"'>"+insuranceNm+" / "+sPolicyNo+"</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>나. 계약자 / 피보험자</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' colspan='"+nColspan+"'>"+sHiddenPolicyNm+" / "+sHiddenBenefitNm+"</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>다. 소재지</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' colspan='"+nColspan+"'>"+sSuimAddress+"</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>라. 보험기간</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' colspan='"+nColspan+"'>"+insuTerm+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>마. "+sCtypeName+"</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' colspan='"+nColspan+"'>"+sContContent+"</td>" + 
				"	</tr>" +				
				
				"	<tr>" + 
				"		<td height='30' colspan='"+nColspanAll+"' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>2. 사고사항</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>가. 사고일자</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' colspan='"+nColspan+"'>"+accidentDate5+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>나. 사고장소</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' colspan='"+nColspan+"'>"+sAccPlace+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>다. 사고내용</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' colspan='"+nColspan+"'>"+insuContent+"</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='"+nColspanAll+"' style='text-align: left; padding-left: 10px;border-bottom:0px;' bgcolor='#EFF5FB'>3. 총괄표 (단위:원)</td>" +
				"	</tr>" +
		
				sSummaryContent +
				
				"	<tr>" + 
				"		<td height='30' colspan='"+nColspanAll+"' style='text-align: left; padding-left: 10px;'>※ 상기와 같이 손해액이 산정되었음을 안내드리며, 보험회사의 검토과정상 일부 금액의 변동이 있을 수 있습니다.</td>" +
				"	</tr>";
				
				sContent += sCertiMemberText +
				
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>대표이사</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' colspan='"+nColspan+"'>전태옥 (직인생략)</td>" + 
				"	</tr>" +				
				"</table>";
		//이메일 내용 끝
		
		String sFromName = "탑손해사정";
		String sFromAddress = from_email;
		String sRet = "";
		
		Sendmail sendmail = new Sendmail();
		try {
			//알림메일 발송
			sRet = sendmail.send( sFromName, sFromAddress, sToAddress, sSubject, sContent, "", "" );								
			logger.info("Sendmail Lotte Issue Send : "+sToAddress +" : "+ suimAcceptNo);
		} catch (Exception e) {
			System.out.println("Sendmail Lotte Issue Send Error: "+e.getMessage());
			resultMap.put("RESULT_MSG", "Email Send Error :" + e.getMessage());
		}
		
		if( "Success".equals(sRet) ) {		//메일 발송 성공시 발송정보를 저장하고 갱신한다.
			//발송성공 시 발송상태값을 변경한다.
			paramMap.put("send_content", sContent);
			sqlSession.update("RptIssueMapper.updateRptIssueSendEmailOk",paramMap);			
			
			paramMap.put("email", sToAddress);
			//같은 이메일주소로 등록되어있는 경우 한건발송으로 다 처리된것으로 한다.
        	sqlSession.update("RptIssueMapper.updateRptIssueSendMagOkEmail",paramMap);
		}
        
        resultMap.put("RESULT_MSG", sRet);
        
        return resultMap;
    }
    
    /**
     * 삼섬생명 손해사정서 이메일 발송
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_Issue_send_samsung_email")
    @ResponseBody
    public Map<String, Object> report_Issue_send_samsung_email(HttpServletRequest request, Model model){
    	    	
    	logger.info("======== report_Issue_send_samsung_email ========");
    	
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        Map<String, Object> resultMap = new HashMap<String,Object>();
        
      //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        //계약자 정보가져오기
        SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);
        
        //보험목적물 계약정보 가져오기
        List<Map<String, Object>> rptIssueContList = sqlSession.selectList("RptIssueMapper.selectRptIssueContLotte", paramMap);
        
        //총괄표 정보 가져오기
        List<Map<String, Object>> rptIssueSummaryList = sqlSession.selectList("RptIssueMapper.selectRptIssueSummaryLotte", paramMap);
        
        String sCtypeName = "";
        
        String sCtype = paramMap.get("ctype").toString();		//보험타입 (C:재물보험, B:배상보험, I:인보험)
        if( sCtype.equals("C") ) {
        	sCtypeName = "보험목적물";
        }else {
        	sCtypeName = "계약약관";
        }
        
        //조사자 정보
        paramMap.put("user_no", rptIssueMain.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
		
		String suimAcceptNo 				= String.valueOf(rptIssueMain.get("suimAcceptNo"));
		String accidentNo 					= String.valueOf(rptIssueMain.get("accidentNo"));
		
		String insuranceNm 					= String.valueOf(rptIssueMain.get("insuranceNm"));
		String insuTerm 					= String.valueOf(rptIssueMain.get("insuTerm"));
		//자기부담금 단위, 자기부담금액
		String amtSelfPayUnit 				= String.valueOf(rptIssueMain.get("amtSelfPayUnit"));				
		long amtSelfPay 						= Long.parseLong(String.valueOf(rptIssueMain.get("amtSelfPay")));
		String accidentDate5 				= String.valueOf(rptIssueMain.get("accidentDate5"));
		
		String insuContent 			        = String.valueOf(rptIssue.get("insuContent"));				
		long amtInsuPayment 					= Long.parseLong(String.valueOf(rptIssueMain.get("amtInsuPayment")));
		
		String userName 					= String.valueOf(reportInvgUser.get("userName"));
		String disWorkLevel 				= String.valueOf(reportInvgUser.get("disWorkLevel"));
		String handphone 					= String.valueOf(reportInvgUser.get("handphone"));
		String from_email 				= String.valueOf(reportInvgUser.get("email"));
		
		//발송할 email 정보
        Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
        String sToAddress = String.valueOf(sendMap.get("email"));
        
        //총괄표 세부사항 메시지 만들기
        String sSummaryContent = "";
        
        //합계계산하기
        long sum_joinPrice = 0;
        long sum_insuPrice = 0;
        long sum_lossPrice = 0;
        long sum_remainPrice = 0;
        long sum_responPrice = 0;        
        long sum_compLimitPrice = 0;
        long sum_compResponPrice = 0;      
        long sum_selfOptPrice = 0;
        long sum_netLossPrice = 0;
        long sum_lossCompPrice = 0;
        long sum_billPrice = 0;
        long sum_payPrice = 0;

        //합계 계산 로직 추가 by top3009        
        for( int i=0; i < rptIssueSummaryList.size(); i++ ) {
        	sum_joinPrice += Long.parseLong(rptIssueSummaryList.get(i).get("joinPrice").toString());
        	sum_insuPrice += Long.parseLong(rptIssueSummaryList.get(i).get("insuPrice").toString());
        	sum_lossPrice += Long.parseLong(rptIssueSummaryList.get(i).get("lossPrice").toString());
        	sum_remainPrice += Long.parseLong(rptIssueSummaryList.get(i).get("remainPrice").toString());
        	sum_responPrice += Long.parseLong(rptIssueSummaryList.get(i).get("responPrice").toString());
        	sum_netLossPrice += Long.parseLong(rptIssueSummaryList.get(i).get("netLossPrice").toString());		//삼성추가        	
        	sum_compLimitPrice += Long.parseLong(rptIssueSummaryList.get(i).get("compLimitPrice").toString());
        	sum_compResponPrice += Long.parseLong(rptIssueSummaryList.get(i).get("compResponPrice").toString());
        	sum_selfOptPrice += Long.parseLong(rptIssueSummaryList.get(i).get("selfOptPrice").toString());
        	sum_lossCompPrice += Long.parseLong(rptIssueSummaryList.get(i).get("lossCompPrice").toString());		//삼성추가
        	sum_billPrice += Long.parseLong(rptIssueSummaryList.get(i).get("billPrice").toString());		//삼성추가
        	sum_payPrice += Long.parseLong(rptIssueSummaryList.get(i).get("payPrice").toString());		//삼성추가        	
        }
        
        int nColspan = 6;
        
        if( sCtype.equals("C") ) {
        	
        	nColspan = 5;
        	
        	sSummaryContent += "<tr>"
        								+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>목적물</td>"
        								+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>보험가입금액</td>"
        								+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>보험가액</td>"
        								+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>손해액</td>"
        								+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>잔존물</td>"
        								+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>순손해액</td>"
        								+ "</tr>";
        	
        	if( rptIssueSummaryList.size() > 0 ) {
            	for(int k=0; k < rptIssueSummaryList.size(); k++) {
            		Map<String, Object>smap = rptIssueSummaryList.get(k);
            		sSummaryContent += "<tr>"
							+ "<td height='30' style='text-align: center;'>"+smap.get("summaryCate").toString()+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("joinPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("insuPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("lossPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("remainPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("netLossPrice").toString())+"</td>"
							+ "</tr>";
            	}
            }else {
            	sSummaryContent += "<td height='30' colspan='6' style='text-align: center;'>내용없음</td>";            	
            }
        	
        	sSummaryContent += "<tr>"
					+ "<td height='30' style='text-align: center;font-weight:bold;'>합계</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_joinPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_insuPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_lossPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_remainPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_netLossPrice)+"</td>"
					+ "</tr>";
        	sSummaryContent += "<tr>"
					+ "<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>자기부담금</td>"
					+ "<td height='30' colspan='5' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(rptIssueMain.get("amtSelfPay").toString())+"</td>"
					+ "</tr>";
        }else if( sCtype.equals("B") ) {
        	
        	nColspan = 4;
        	
        	sSummaryContent += "<tr>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>목적물</td>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>보상한도액</td>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>손해액</td>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>손해배상금</td>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>자기부담금</td>"					
					+ "</tr>";
        	
        	if( rptIssueSummaryList.size() > 0 ) {
            	for(int k=0; k < rptIssueSummaryList.size(); k++) {
            		Map<String, Object>smap = rptIssueSummaryList.get(k);
            		
            		sSummaryContent += "<tr>"
							+ "<td height='30' style='text-align: center;'>"+smap.get("summaryCate").toString()+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("compLimitPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("lossPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("lossCompPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("selfOptPrice").toString())+"</td>"							
							+ "</tr>";				 
            	}
            }else {
            	sSummaryContent += "<td height='30' colspan='5' style='text-align: center;'>내용없음</td>";
            }
        	
        	sSummaryContent += "<tr>"
					+ "<td height='30' style='text-align: center;font-weight:bold;'>합계</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_compLimitPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_lossPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_lossCompPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_selfOptPrice)+"</td>"					
					+ "</tr>";
        }else if( sCtype.equals("I") ){
        	
        	nColspan = 4;
        	
        	sSummaryContent += "<tr>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>목적물</td>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>가입금액</td>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>청구금액</td>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>지급금액</td>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>제외사유</td>"					
					+ "</tr>";
        	
        	if( rptIssueSummaryList.size() > 0 ) {
            	for(int k=0; k < rptIssueSummaryList.size(); k++) {
            		Map<String, Object>smap = rptIssueSummaryList.get(k);
            		
            		sSummaryContent += "<tr>"
							+ "<td height='30' style='text-align: center;'>"+smap.get("summaryCate").toString()+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("joinPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("billPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("payPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: left;padding-left:5px;'>"+StringUtil.toMoneyString(smap.get("exceptionVal").toString())+"</td>"							
							+ "</tr>";            		
            	}
            }else {
            	sSummaryContent += "<td height='30' colspan='5' style='text-align: center;'>내용없음</td>";
            }
        	
        	sSummaryContent += "<tr>"
					+ "<td height='30' style='text-align: center;font-weight:bold;'>합계</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_joinPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_billPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_payPrice)+"</td>"
					+ "<td height='30'></td>"					
					+ "</tr>";        	
        }else {
        	sSummaryContent += "<td height='30' colspan='5' style='text-align: center;'>내용없음</td>";
        }        
        
        //특이사항 처리
        //비고 null 처리
        String sSpecialContent = "";
        
    	if( rptIssue.get("remarkVal") != null ) {
    		sSpecialContent = rptIssue.get("remarkVal").toString();
    	}else {
    		sSpecialContent = "-";
    	}
		
		//증권번호
		String sPolicyNo = String.valueOf(rptIssueMain.get("policyNo"));
		
		//소재지
		String sSuimAddress = String.valueOf(rptIssue.get("suimAddress")).replace("null", "");
		
		//전송시 계약자 피보험자 이름 두번째 글자 '*' 처리        
		String sHiddenPolicyNm = suimVo.getPolicyholder_nm().toString();
		String sHiddenBenefitNm = suimVo.getBeneficiary_nm().toString();

		if( !sHiddenPolicyNm.equals("") ) {        	
			if( sHiddenPolicyNm.length() == 1 ) {
				sHiddenPolicyNm = "*";
			}else {
				sHiddenPolicyNm = sHiddenPolicyNm.replace(sHiddenPolicyNm.charAt(1),'*');
			}        	        	
		}else {
			sHiddenPolicyNm = "";
		}

		if( !sHiddenBenefitNm.equals("") ) {
			if( sHiddenBenefitNm.length() == 1 ) {
				sHiddenBenefitNm = "*";
			}else {
				sHiddenBenefitNm = sHiddenBenefitNm.replace(sHiddenBenefitNm.charAt(1),'*');
			}        	
		}else {
			sHiddenBenefitNm = "";
		}		
		
		//사고장소
		String investigate_addr1 = String.valueOf(suimVo.getInvestigate_addr1());		//null 처리		
		String investigate_addr2 = String.valueOf(suimVo.getInvestigate_addr2());		//null 처리
		String sAccPlace = "";
		
		if( !investigate_addr1.equals("") ) {
			sAccPlace = investigate_addr1; 
		}else if( !investigate_addr2.equals("") ){
			sAccPlace = investigate_addr2;
		}else{
			sAccPlace = "사고장소정보 미노출";
		}
		
		//담당자 자격증(손해사정사) 정보 List 만들기 시작
		String sUserNo = String.valueOf(rptIssueMain.get("userNo"));
		List<Map<String, Object>> certiReportUser = null;					//보고서 하단에 들어갈 담당자 정보 List
		List<Map<String, Object>> certiManagerReportUser = null;		//담당손해사정사 목록

		//기 종결건은 담당손해사정사가 별도 저장되어있음 (top_rpt_certi_end) 저장된 손해사정사 정보가 별도로 있는지 체크
		int nEndCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiEndCnt",paramMap);

		if( nEndCnt == 0 ) {			//정보가 없는 경우 실시간으로 가져온다.
			
			if( !"0".equals(sUserNo) ) {		//0은 미배당건        	
			certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiMemberInfo", paramMap);
			
			int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
			
			nCertiManagerCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiManagerCnt", paramMap);
			
			if( nCertiManagerCnt > 0 ) {			//담당손해사정사가 있는 경우
				certiManagerReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiManagerList", paramMap);
				for( int i=0; i < certiManagerReportUser.size(); i++) {
					certiReportUser.add(certiManagerReportUser.get(i));		//보고서 하단에 들어갈 담당자 정보에 담당손해사정서를 추가한다.
				}
			}
		    }
			
		}else{								//정보가 있는 경우 top_rpt_certi_end 테이블에서 불러온다.
			certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiEndInfo", paramMap);
		}

		String sCertiMemberText = "";

		if( certiReportUser == null ) {			//미배상건
			sCertiMemberText = "	<tr>" +
						"		<td height='30' colspan='4' style='text-align: left; padding-left: 10px;'>미배당건으로 담당자 정보가 없습니다.</td>" + 
						"	</tr>" + 
						"	<tr>";
		}else{
			for( int i=0; i < certiReportUser.size(); i++) {
				sCertiMemberText +="	<tr>" +
						"<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>"+String.valueOf(certiReportUser.get(i).get("certi_state_val"))+"</td>" + 
						"<td height='30' style='text-align: left; padding-left: 10px;' colspan='4'>"+String.valueOf(certiReportUser.get(i).get("user_name"))+" (직인생략) "+
						 "(&#9742; "+String.valueOf(certiReportUser.get(i).get("work_phone"))+")</td>" + 
				"	</tr>"+        				
				"   <tr>"+
					"<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>등록번호</td>" + 
						"<td height='30' style='text-align: left; padding-left: 10px;' colspan='4'>"+String.valueOf(certiReportUser.get(i).get("certi_number"))+"</td>" +
				"	</tr>";
			}
		}
		//담당자 자격증(손해사정사) 정보 List 만들기 끝
		
		int nColspanAll = nColspan+1;
        
        //이메일 내용 시작
		String sSubject = "[접수번호 : "+suimAcceptNo+"] 보험업법 제189조 소정의 규정에 의거하여 아래와 같이 손해사정서를 안내합니다.";
		
		String sContent = "<table style='border-collapse:collapse;width:800px;font-size:12px;font-weight:bold;letter-spacing:1px;' border='1'>" +
				"	<tr>" + 
				"		<td height='30' colspan='"+nColspanAll+"' style='text-align: center;' bgcolor='#EFF5FB'>보험업법 제189조 소정의 규정에 의거하여 아래와 같이 손해사정서를 안내합니다.</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>Report No</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' colspan='"+nColspan+"'><font color='blue'>"+suimAcceptNo+"</font></td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>손해사정</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' colspan='"+nColspan+"'>[사고번호 : "+accidentNo+"]</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='"+nColspanAll+"' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>1. 계약사항</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>가. 보험종목</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' colspan='"+nColspan+"'>"+insuranceNm+"</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>나. 증권번호</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' colspan='"+nColspan+"'>"+sPolicyNo+"</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>다. 계약자</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' colspan='"+nColspan+"'>"+sHiddenPolicyNm+"</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>라. 피보험자</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' colspan='"+nColspan+"'>"+sHiddenBenefitNm+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>마. 소재지</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' colspan='"+nColspan+"'>"+sSuimAddress+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>바. 보험기간</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' colspan='"+nColspan+"'>"+insuTerm+"</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='"+nColspanAll+"' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>2. 사고사항</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>가. 사고일자</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' colspan='"+nColspan+"'>"+accidentDate5+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>나. 사고장소</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' colspan='"+nColspan+"'>"+sAccPlace+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='50' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>다. 사고내용</td>" + 
				"		<td height='50' style='text-align: left; padding-left: 10px;' colspan='"+nColspan+"'>"+insuContent+"</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='"+nColspanAll+"' style='text-align: left; padding-left: 10px;border-bottom:0px;' bgcolor='#EFF5FB'>3. 총괄표 (단위:원)</td>" +
				"	</tr>" +
		
				sSummaryContent +		
		
				"	<tr>" + 
				"		<td height='30' colspan='"+nColspanAll+"' style='text-align: left; padding-left: 10px;border-top:0px;' bgcolor='#EFF5FB'>4. 특이사항</td>" +
				"	</tr>" +
				"	<tr>" +
				"		<td height='30' colspan='"+nColspanAll+"' style='text-align: left; padding-left: 10px;'>"+sSpecialContent+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>담당자</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' colspan='"+nColspan+"'>"+userName+"</td>" + 
				"	</tr>";
		
				sContent += sCertiMemberText +
						
				//"	<tr>" + 
				//"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>대표손해사정사</td>" + 
				//"		<td height='30' style='text-align: left; padding-left: 10px;' colspan='"+nColspan+"'>윤경수 (직인생략)</td>" + 
				//"	</tr>" +				
				
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>대표이사</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' colspan='"+nColspan+"'>전태옥 (직인생략)</td>" + 
				"	</tr>" +
				"	<tr>" +
				"<td height='50' colspan='"+nColspanAll+"' style='text-align: left; padding-left: 10px;'>" +
				"※ 본 손해사정서는 보험업법 제188조에 근거한 손해사정사의 의견으로 보험업법 제189조에 따라 발송하는 서식이며 보험사의 최종의사결과에 따라 달라질 수 있음을 양지해 주시기 바랍니다."+
				"</td></tr></table>";
		//이메일 내용 끝
		
		String sFromName = "탑손해사정";
		String sFromAddress = from_email;
		String sRet = "";
		
		Sendmail sendmail = new Sendmail();
		try {
			//알림메일 발송
			sRet = sendmail.send( sFromName, sFromAddress, sToAddress, sSubject, sContent, "", "" );								
			logger.info("Sendmail Samsung Issue Send : "+sToAddress +" : "+ suimAcceptNo);
		} catch (Exception e) {
			System.out.println("Sendmail Samsung Issue Send Error: "+e.getMessage());
			resultMap.put("RESULT_MSG", "Email Send Error :" + e.getMessage());
		}
		
		if( "Success".equals(sRet) ) {		//메일 발송 성공시 발송정보를 저장하고 갱신한다.
			//발송성공 시 발송상태값을 변경한다.
			paramMap.put("send_content", sContent);
			sqlSession.update("RptIssueMapper.updateRptIssueSendEmailOk",paramMap);			
			
			paramMap.put("email", sToAddress);
			//같은 이메일주소로 등록되어있는 경우 한건발송으로 다 처리된것으로 한다.
        	sqlSession.update("RptIssueMapper.updateRptIssueSendMagOkEmail",paramMap);
		}
        
        resultMap.put("RESULT_MSG", sRet);
        	
    	return resultMap;
    }
    
    /**
     * 인보험 손해사정서 기본 이메일 발송
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_Issue_send_pi_email")
    @ResponseBody
    public Map<String, Object> report_Issue_send_pi_email(HttpServletRequest request, Model model){
    	
    	logger.info("======== report_Issue_send_pi_email ========");
    	
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        Map<String, Object> resultMap = new HashMap<String,Object>();
        
        //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);

        //조사자 정보
        paramMap.put("user_no", rptIssueMain.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
        
        //발송할 email 정보
        Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
        String sToAddress = String.valueOf(sendMap.get("email"));
                
        String suimRptType1 				= String.valueOf(rptIssueMain.get("suimRptType1"));	//템플릿 구분용
		
		String suimAcceptNo 				= String.valueOf(rptIssueMain.get("suimAcceptNo"));
		String accidentNo 					= String.valueOf(rptIssueMain.get("accidentNo"));
		String ptnrName 					= String.valueOf(rptIssueMain.get("ptnrName"));
		String insuranceNm 					= String.valueOf(rptIssueMain.get("insuranceNm"));
		String insuTerm 					= String.valueOf(rptIssueMain.get("insuTerm"));
		String insuCondition				= String.valueOf(rptIssueMain.get("insuCondition"));
		String amtSelfPayUnit 				= String.valueOf(rptIssueMain.get("amtSelfPayUnit"));
		long amtSelfPay 						= Long.parseLong(String.valueOf(rptIssueMain.get("amtSelfPay")));
		String selfPayFlag 					= String.valueOf(rptIssueMain.get("selfPayFlag"));
		String amtCompensationLimitUnit		= String.valueOf(rptIssueMain.get("amtCompensationLimitUnit"));
		long amtCompensationLimit			= Long.parseLong(String.valueOf(rptIssueMain.get("amtCompensationLimit")));
		String compensationLimitFlag 		= String.valueOf(rptIssueMain.get("compensationLimitFlag"));
		String accidentDate5 				= String.valueOf(rptIssueMain.get("accidentDate5"));
		String accidentFacts 				= String.valueOf(rptIssueMain.get("accidentFacts"));
		
		String reparationLiabilityType 		= String.valueOf(rptIssue.get("reparationLiabilityType"));
		String reparationLiabilityReason 	= String.valueOf(rptIssue.get("reparationLiabilityReason"));
		String insuPaymentType 				= String.valueOf(rptIssue.get("insuPaymentType"));
		String insuPaymentReason 			= String.valueOf(rptIssue.get("insuPaymentReason"));
		String insuContent 			        = String.valueOf(rptIssue.get("insuContent"));

		String paymentBasis 				= String.valueOf(rptIssue.get("paymentBasis"));
		long amtInsuPayment 					= Long.parseLong(String.valueOf(rptIssueMain.get("amtInsuPayment")));
		String amtInsuPaymentDisable		= String.valueOf(rptIssueMain.get("amtInsuPaymentDisable"));					//지급보험금 협의금액에 따름으로 표시
		
		String rptissueComment 				= String.valueOf(rptIssue.get("rptissueComment"));
		
		String userName 					= String.valueOf(reportInvgUser.get("userName"));
		String disWorkLevel 				= String.valueOf(reportInvgUser.get("disWorkLevel"));
		String handphone 					= String.valueOf(reportInvgUser.get("handphone"));
		String from_email = String.valueOf(reportInvgUser.get("email"));

		String reparationLiability ="";
		if("1".equals(reparationLiabilityType)){
			reparationLiability = "부책";
		}else{
			reparationLiability = "면책";
		}		
		String insuPayment ="";
		if("1".equals(insuPaymentType)){
			insuPayment = "부책";
		}else{
			insuPayment = "면책";
		}
		
		//직급이 수습인 경우 외부발송시 사원으로 변경
		String SendDisWorkLevel = "";
		if("수습".equals(disWorkLevel)) {
			SendDisWorkLevel = "사원";
		}else{
			SendDisWorkLevel = disWorkLevel;
		}
		
		//손해사정서 양식 변경에 따라 항목 추가 시작
		String regDateFmt = String.valueOf(rptIssueMain.get("regDate"));		//수임일
		
		String policyholderNm = String.valueOf(rptIssueMain.get("policyholderNm"));		//계약자
		String beneficiaryNm = String.valueOf(rptIssueMain.get("beneficiaryNm"));			//피보험자
		
        Map<String, Object> lawEtcContentMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawContentInfo", paramMap);
        model.addAttribute("lawEtcContentInfo", lawEtcContentMap);
        
        String lawSubject = String.valueOf(lawEtcContentMap.get("law_subject"));			//관련법규
        String lawEtc = String.valueOf(lawEtcContentMap.get("law_etc"));						//관련약관


        Map<String, Object> lawReasonMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawReasonInfo", paramMap);
        model.addAttribute("lawReasonInfo", lawReasonMap);


        Map<String, Object> lawSelContentMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawSelInfo", paramMap);
        model.addAttribute("lawSelContentInfo", lawSelContentMap);
        
        String reparationLiabilityReasonEtc = String.valueOf(lawSelContentMap.get("reparation_liability_reason_etc"));		//책임범위
        
        if( "2".equals(reparationLiabilityReasonEtc) ) {
        	reparationLiabilityReasonEtc = "동 약관 보상하지 않는 손해";
        }else if( "1".equals(reparationLiabilityReasonEtc) ) {
        	reparationLiabilityReasonEtc = "동 약관 보상하는 손해";
        }else{
        	reparationLiabilityReasonEtc = "-";
        }		
		
		//담당자 자격증(손해사정사) 정보 List 만들기 시작
		String sUserNo = String.valueOf(rptIssueMain.get("userNo"));
		List<Map<String, Object>> certiReportUser = null;					//보고서 하단에 들어갈 담당자 정보 List
		List<Map<String, Object>> certiManagerReportUser = null;		//담당손해사정사 목록

		//기 종결건은 담당손해사정사가 별도 저장되어있음 (top_rpt_certi_end) 저장된 손해사정사 정보가 별도로 있는지 체크
		int nEndCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiEndCnt",paramMap);

		if( nEndCnt == 0 ) {			//정보가 없는 경우 실시간으로 가져온다.
			
			if( !"0".equals(sUserNo) ) {		//0은 미배당건        	
			certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiMemberInfo", paramMap);
			
			int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
			
			nCertiManagerCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiManagerCnt", paramMap);
			
			if( nCertiManagerCnt > 0 ) {			//담당손해사정사가 있는 경우
				certiManagerReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiManagerList", paramMap);
				for( int i=0; i < certiManagerReportUser.size(); i++) {
					certiReportUser.add(certiManagerReportUser.get(i));		//보고서 하단에 들어갈 담당자 정보에 담당손해사정서를 추가한다.
				}
			}
		    }
			
		}else{								//정보가 있는 경우 top_rpt_certi_end 테이블에서 불러온다.
			certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiEndInfo", paramMap);
		}

		String sCertiMemberText = "";

		if( certiReportUser == null ) {			//미배상건
			sCertiMemberText = "	<tr>" +
						"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;'>미배당건으로 담당자 정보가 없습니다.</td>" + 
						"	</tr>" + 
						"	<tr>";
		}else{
			for( int i=0; i < certiReportUser.size(); i++) {
				sCertiMemberText +="	<tr>" +
						"<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>"+String.valueOf(certiReportUser.get(i).get("certi_state_val"))+"</td>" + 
						"<td height='30' style='text-align: left; padding-left: 10px;'>"+String.valueOf(certiReportUser.get(i).get("user_name"))+" (직인생략) "+
						 "(&#9742; "+String.valueOf(certiReportUser.get(i).get("work_phone"))+")</td>" + 
				"	</tr>"+        				
				"   <tr>"+
					"<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>등록번호</td>" + 
						"<td height='30' style='text-align: left; padding-left: 10px;'>"+String.valueOf(certiReportUser.get(i).get("certi_number"))+"</td>" +
				"	</tr>";
			}
		}
		//담당자 자격증(손해사정사) 정보 List 만들기 끝
		
		//이메일 내용 시작
		String sSubject = "[접수번호 : "+suimAcceptNo+"] 보험업법 제189조 소정의 규정에 의거하여 아래와 같이 손해사정서를 안내합니다.";
		
		String sContent = "<table style='border-collapse:collapse;width:800px;font-size:12px;font-weight:bold;letter-spacing:1px;' border='1'>" +
		
				"<colgroup><col style='width:30%'><col style='width:70%'></colgroup>"+
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: center;' bgcolor='#EFF5FB'>보험업법 제189조 소정의 규정에 의거하여 아래와 같이 손해사정서를 안내합니다.</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>Report No</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'><font color='blue'>"+suimAcceptNo+"</font></td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>손해사정</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>[사고번호 : "+accidentNo+"]</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>1. 보험계약사항</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>가. 보험사명</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+ptnrName+"</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>나. 보험종목</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+insuranceNm+"</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>다. 보험기간</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+insuTerm+"</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>라. 담보내용</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+insuCondition+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>마. 가입금액</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+amtCompensationLimitUnit+" "+String.format("%,d",amtCompensationLimit)+"</td>" + 
				"	</tr>" +				
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>2. 사고사항</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>가. 사고일자</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+accidentDate5+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>나. 사고내용</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+insuContent+"</td>" + 
				"	</tr>" +
		
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>3. 손해사정 시 적용된 관계 법규 및 약관</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>가. 관련법규</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+lawSubject+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>나. 관련약관</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+lawEtc+"</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>4. 약관상 보험자 지급책임의 범위</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>가. 지급책임</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+reparationLiability+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>나. 책임범위</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+reparationLiabilityReasonEtc+"</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>5. 손해액 및 보험금 사정에 크게 영향을 미친 사항</td>" +
				"	</tr>" +
				"	<tr>" +
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;'>"+reparationLiabilityReason+"</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>6. 지급보험금</td>" +
				"	</tr>";

				if("1".equals(amtInsuPaymentDisable)) {
					sContent += "	<tr><td height='30' colspan='2' style='text-align: left; padding-left: 10px;'>단체 사고의 경우 개별 안내 금액에 따름</td></tr>";
				}else {
					sContent += "	<tr>" +
										"	<td height='30' colspan='2' style='text-align: left; padding-left: 10px;'>￦"+String.format("%,d",amtInsuPayment)+"</td>" + 
										"</tr>";
				}
				
				sContent += sCertiMemberText +
				
				//"	<tr>" + 
				//"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>담당자</td>" + 
				//"		<td height='30' style='text-align: left; padding-left: 10px;'>"+SendDisWorkLevel+" "+userName+"  (연락처 : "+handphone+")</td>" + 
				//"	</tr>" + 
				//"	<tr>" + 
				//"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>대표손해사정사</td>" + 
				//"		<td height='30' style='text-align: left; padding-left: 10px;'>윤경수 (직인생략)</td>" + 
				//"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>대표이사</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>전태옥 (직인생략)</td>" + 
				"	</tr>" +
				"	<tr>" +
				"<td height='50' colspan='2' style='text-align: left; padding-left: 10px;'>" +
				"※ 본 손해사정서는 보험업법 제188조에 근거한 손해사정사의 의견으로 보험업법 제189조에 따라 발송하는 서식이며 보험사의 최종의사결과에 따라 달라질 수 있음을 양지해 주시기 바랍니다."+
				"</td></tr></table>";
		//이메일 내용 끝
		
		String sFromName = "탑손해사정";
		String sFromAddress = from_email;
		String sRet = "";
		
		Sendmail sendmail = new Sendmail();
		try {
			//알림메일 발송
			sRet = sendmail.send( sFromName, sFromAddress, sToAddress, sSubject, sContent, "", "" );								
			logger.info("Sendmail Issue Pi Send : "+sToAddress +" : "+ suimAcceptNo);
		} catch (Exception e) {
			System.out.println("Sendmail Issue Pi Send Error: "+e.getMessage());
			resultMap.put("RESULT_MSG", "Email Pi Send Error :" + e.getMessage());
		}
		
		if( "Success".equals(sRet) ) {		//메일 발송 성공시 발송정보를 저장하고 갱신한다.
			//발송성공 시 발송상태값을 변경한다.
			paramMap.put("send_content", sContent);
			sqlSession.update("RptIssueMapper.updateRptIssueSendEmailOk",paramMap);			
			
			paramMap.put("email", sToAddress);
			//같은 이메일주소로 등록되어있는 경우 한건발송으로 다 처리된것으로 한다.
        	sqlSession.update("RptIssueMapper.updateRptIssueSendMagOkEmail",paramMap);
		}
        
        resultMap.put("RESULT_MSG", sRet);
        
        return resultMap;
    }
    
    /**
     * 손해사정서 Abl 이메일 발송
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_Issue_send_abl_email")
    @ResponseBody
    public Map<String, Object> report_Issue_send_abl_email(HttpServletRequest request, Model model){
    	
    	logger.info("======== report_Issue_send_abl_email ========");
    	
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        Map<String, Object> resultMap = new HashMap<String,Object>();
        
      	//기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);

        //조사자 정보
        paramMap.put("user_no", rptIssueMain.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
        
        //발송할 email 정보
        Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
        String sToAddress = String.valueOf(sendMap.get("email"));        
        
        String suimRptType1 				= String.valueOf(rptIssueMain.get("suimRptType1"));	//템플릿 구분용
		
		String suimAcceptNo 				= String.valueOf(rptIssueMain.get("suimAcceptNo"));
		String accidentNo 					= String.valueOf(rptIssueMain.get("accidentNo"));
		String ptnrName 					= String.valueOf(rptIssueMain.get("ptnrName"));
		String insuranceNm 					= String.valueOf(rptIssueMain.get("insuranceNm"));
		String insuTerm 					= String.valueOf(rptIssueMain.get("insuTerm"));
		String insuCondition				= String.valueOf(rptIssueMain.get("insuCondition"));
		String amtSelfPayUnit 				= String.valueOf(rptIssueMain.get("amtSelfPayUnit"));		
		long amtSelfPay 						= Long.parseLong(String.valueOf(rptIssueMain.get("amtSelfPay")));
		String selfPayFlag 					= String.valueOf(rptIssueMain.get("selfPayFlag"));
		String amtCompensationLimitUnit		= String.valueOf(rptIssueMain.get("amtCompensationLimitUnit"));
		long amtCompensationLimit			= Long.parseLong(String.valueOf(rptIssueMain.get("amtCompensationLimit")));
		String compensationLimitFlag 		= String.valueOf(rptIssueMain.get("compensationLimitFlag"));
		String accidentDate5 				= String.valueOf(rptIssueMain.get("accidentDate5"));
		String accidentFacts 				= String.valueOf(rptIssueMain.get("accidentFacts"));
		
		String reparationLiabilityType 		= String.valueOf(rptIssue.get("reparationLiabilityType"));
		String reparationLiabilityReason 	= String.valueOf(rptIssue.get("reparationLiabilityReason"));
		String insuPaymentType 				= String.valueOf(rptIssue.get("insuPaymentType"));
		String insuPaymentReason 			= String.valueOf(rptIssue.get("insuPaymentReason"));
		String insuContent 			        = String.valueOf(rptIssue.get("insuContent"));

		String paymentBasis 				= String.valueOf(rptIssue.get("paymentBasis"));
		long amtInsuPayment 					= Long.parseLong(String.valueOf(rptIssueMain.get("amtInsuPayment")));
		
		String rptissueComment 				= String.valueOf(rptIssue.get("rptissueComment"));
		
		String userName 					= String.valueOf(reportInvgUser.get("userName"));
		String disWorkLevel 				= String.valueOf(reportInvgUser.get("disWorkLevel"));
		String handphone 					= String.valueOf(reportInvgUser.get("handphone"));
		String from_email 				= String.valueOf(reportInvgUser.get("email"));
		
		String report_comment = String.valueOf(rptIssue.get("reportComment")).replace("null", "");		//ABL 용 추가
		String report_reference = String.valueOf(rptIssue.get("reportReference")).replace("null", "");		//ABL 용 추가

		String reparationLiability ="";
		if("1".equals(reparationLiabilityType)){
			reparationLiability = "부책";
		}else{
			reparationLiability = "면책";
		}		
		String insuPayment ="";
		if("1".equals(insuPaymentType)){
			insuPayment = "부책";
		}else{
			insuPayment = "면책";
		}
		
		//직급이 수습인 경우 외부발송시 사원으로 변경
		String SendDisWorkLevel = "";
		if("수습".equals(disWorkLevel)) {
			SendDisWorkLevel = "사원";
		}else{
			SendDisWorkLevel = disWorkLevel;
		}
		
		//담당자 자격증(손해사정사) 정보 List 만들기 시작
		String sUserNo = String.valueOf(rptIssueMain.get("userNo"));
        List<Map<String, Object>> certiReportUser = null;					//보고서 하단에 들어갈 담당자 정보 List
        List<Map<String, Object>> certiManagerReportUser = null;		//담당손해사정사 목록
        
        //기 종결건은 담당손해사정사가 별도 저장되어있음 (top_rpt_certi_end) 저장된 손해사정사 정보가 별도로 있는지 체크
        int nEndCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiEndCnt",paramMap);
        
        if( nEndCnt == 0 ) {			//정보가 없는 경우 실시간으로 가져온다.
        	
        	if( !"0".equals(sUserNo) ) {		//0은 미배당건        	
            	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiMemberInfo", paramMap);
            	
            	int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
            	
            	nCertiManagerCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiManagerCnt", paramMap);
            	
            	if( nCertiManagerCnt > 0 ) {			//담당손해사정사가 있는 경우
            		certiManagerReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiManagerList", paramMap);
            		for( int i=0; i < certiManagerReportUser.size(); i++) {
            			certiReportUser.add(certiManagerReportUser.get(i));		//보고서 하단에 들어갈 담당자 정보에 담당손해사정서를 추가한다.
            		}
            	}
            }
        	
        }else{								//정보가 있는 경우 top_rpt_certi_end 테이블에서 불러온다.
        	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiEndInfo", paramMap);
        }
        
        String sCertiMemberText = "";
        
        if( certiReportUser == null ) {			//미배상건
        	sCertiMemberText = "	<tr>" +
					"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;'>미배당건으로 담당자 정보가 없습니다.</td>" + 
					"	</tr>" + 
					"	<tr>";
        }else{
        	for( int i=0; i < certiReportUser.size(); i++) {
        		sCertiMemberText +="	<tr>" +
        				"<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>"+String.valueOf(certiReportUser.get(i).get("certi_state_val"))+"</td>" + 
        				"<td height='30' style='text-align: left; padding-left: 10px;'>"+String.valueOf(certiReportUser.get(i).get("user_name"))+" (직인생략) "+
        				 "(&#9742; "+String.valueOf(certiReportUser.get(i).get("work_phone"))+")</td>" + 
        		"	</tr>"+        				
        		"   <tr>"+
	        		"<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>등록번호</td>" + 
					"<td height='30' style='text-align: left; padding-left: 10px;'>"+String.valueOf(certiReportUser.get(i).get("certi_number"))+"</td>" +
        		"	</tr>";
        	}
        }        
		//담당자 자격증(손해사정사) 정보 List 만들기 끝
        
        //이메일 내용 시작
		String sSubject = "[접수번호 : "+suimAcceptNo+"] 보험업법 제189조 소정의 규정에 의거하여 아래와 같이 손해사정서를 안내합니다.";
		
		String sContent = "<table style='border-collapse:collapse;width:800px;font-size:12px;font-weight:bold;letter-spacing:1px;' border='1'>" +
		
				"<colgroup><col style='width:30%'><col style='width:70%'></colgroup>"+
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: center;' bgcolor='#EFF5FB'>보험업법 제189조 소정의 규정에 의거하여 아래와 같이 손해사정서를 안내합니다.</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>Report No</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'><font color='blue'>"+suimAcceptNo+"</font></td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>손해사정</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>[사고번호 : "+accidentNo+"]</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>1. 보험계약사항</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>가. 보험사명</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+ptnrName+"</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>나. 보험종목</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+insuranceNm+"</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>다. 보험기간</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+insuTerm+"</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>라. 담보내용</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+insuCondition+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>마. 가입금액</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+amtCompensationLimitUnit+" "+String.format("%,d",amtCompensationLimit)+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>바. 자기부담금</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+amtSelfPayUnit+" "+String.format("%,d",amtSelfPay)+"</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>2. 사고사항</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>가. 사고일자</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+accidentDate5+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>나. 사고내용</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+insuContent+"</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>3. 손해사정의견</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>가. 손해사정 의견</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+report_comment+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>나. 관련 참고사항</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+report_reference+"</td>" + 
				"	</tr>";
		
				sContent += sCertiMemberText +
				
				//"	<tr>" + 
				//"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>담당자</td>" + 
				//"		<td height='30' style='text-align: left; padding-left: 10px;'>"+SendDisWorkLevel+" "+userName+"  (연락처 : "+handphone+")</td>" + 
				//"	</tr>" +				
				//"	<tr>" + 
				//"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>대표손해사정사</td>" + 
				//"		<td height='30' style='text-align: left; padding-left: 10px;'>윤경수 (직인생략)</td>" + 
				//"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>대표이사</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>전태옥 (직인생략)</td>" + 
				"	</tr>" +
				"	<tr>" +
				"<td height='50' colspan='2' style='text-align: left; padding-left: 10px;'>" +
				"※ 본 손해사정서는 보험업법 제188조에 근거한 손해사정사의 의견으로 보험업법 제189조에 따라 발송하는 서식이며 보험사의 최종의사결과에 따라 달라질 수 있음을 양지해 주시기 바랍니다."+
				"</td></tr></table>";
		//이메일 내용 끝
		
		String sFromName = "탑손해사정";
		String sFromAddress = from_email;
		String sRet = "";
		
		Sendmail sendmail = new Sendmail();
		try {
			//알림메일 발송
			sRet = sendmail.send( sFromName, sFromAddress, sToAddress, sSubject, sContent, "", "" );								
			logger.info("Sendmail Issue Send : "+sToAddress +" : "+ suimAcceptNo);
		} catch (Exception e) {
			System.out.println("Sendmail Issue Send Error: "+e.getMessage());
			resultMap.put("RESULT_MSG", "Email Send Error :" + e.getMessage());
		}
		
		if( "Success".equals(sRet) ) {		//메일 발송 성공시 발송정보를 저장하고 갱신한다.
			//발송성공 시 발송상태값을 변경한다.
			paramMap.put("send_content", sContent);
			sqlSession.update("RptIssueMapper.updateRptIssueSendEmailOk",paramMap);			
			
			paramMap.put("email", sToAddress);
			//같은 이메일주소로 등록되어있는 경우 한건발송으로 다 처리된것으로 한다.
        	sqlSession.update("RptIssueMapper.updateRptIssueSendMagOkEmail",paramMap);
		}
        
        resultMap.put("RESULT_MSG", sRet);
        	
    	return resultMap;
    }
    
    /**
     * 손해사정서 악사 이메일 발송
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_Issue_send_axa_email")
    @ResponseBody
    public Map<String, Object> report_Issue_send_axa_email(HttpServletRequest request, Model model){
    	
    	logger.info("======== report_Issue_send_axa_email ========");
    	
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        Map<String, Object> resultMap = new HashMap<String,Object>();
        
        //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);

        //조사자 정보
        paramMap.put("user_no", rptIssueMain.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
        
        //발송할 email 정보
        Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
        String sToAddress = String.valueOf(sendMap.get("email"));
        
        //계약자 정보가져오기
	    SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);
        
        //Msg에 넣을 정보
        //증권번호
  		String sPolicyNo = String.valueOf(rptIssueMain.get("policyNo"));
  		
  		//소재지
  		String sSuimAddress = String.valueOf(rptIssue.get("suimAddress")).replace("null", "");
        String suimAcceptNo = String.valueOf(rptIssueMain.get("suimAcceptNo"));
		String accidentNo = String.valueOf(rptIssueMain.get("accidentNo"));
		String ptnrName = String.valueOf(rptIssueMain.get("ptnrName"));
		String insuranceNm = String.valueOf(rptIssueMain.get("insuranceNm"));
		String insuTerm = String.valueOf(rptIssueMain.get("insuTerm"));
		String insuCondition = String.valueOf(rptIssueMain.get("insuCondition"));
		String amtSelfPayUnit = String.valueOf(rptIssueMain.get("amtSelfPayUnit"));
		String amtCompensationLimitUnit = String.valueOf(rptIssueMain.get("amtCompensationLimitUnit"));
		long amtCompensationLimit = Long.parseLong(String.valueOf(rptIssueMain.get("amtCompensationLimit")));
		long amtSelfPay = Long.parseLong(String.valueOf(rptIssueMain.get("amtSelfPay")));
		String accidentDate5 = String.valueOf(rptIssueMain.get("accidentDate5"));
		String insuContent = String.valueOf(rptIssue.get("insuContent"));		
		String reparationLiabilityReason = String.valueOf(rptIssue.get("reparationLiabilityReason"));
		String insuPaymentType = String.valueOf(rptIssue.get("insuPaymentType"));
		String guaranteeTitle = String.valueOf(rptIssueMain.get("guaranteeTitle")).replace("null", "");
		String damagedNm					= String.valueOf(suimVo.getDamaged_nm()).replace("null", "");
		String insuSequence 			        = String.valueOf(rptIssue.get("insuSequence")).replace("null", "");
		
		//약관면책여부
		String LiabilityType = "";		
		//지급보험금
		String InsuPayment = "";		
		//지급처
		String PaymentPlace = "";
		
		String reparationLiabilityType 				= String.valueOf(rptIssueMain.get("reparationLiabilityType"));
		String amtInsuPaymentDisable 				= String.valueOf(rptIssueMain.get("amtInsuPaymentDisable"));
		String amtInsuPayment 				= String.valueOf(rptIssueMain.get("amtInsuPayment"));
		String paymentPlace 				= String.valueOf(rptIssueMain.get("paymentPlace"));
		
		if("1".equals(reparationLiabilityType)) {
			LiabilityType = "부책";
		}else if("2".equals(reparationLiabilityType)) {
			LiabilityType = "면책";
		}else {
			LiabilityType =" - ";
		}
		
		if("1".equals(amtInsuPaymentDisable)) {
			InsuPayment = "단체 사고의 경우 개별 안내 금액에 따름";
		}else {
			InsuPayment = StringUtil.toMoneyString(amtInsuPayment)+" 원";
		}
		
		if("1".equals(paymentPlace)) {
			PaymentPlace = "피보험자";
		}else if("2".equals(paymentPlace)) {
			PaymentPlace = "피해자";
		}else{
			PaymentPlace = " - ";
		}
		
		String userName	= String.valueOf(reportInvgUser.get("userName"));
		String disWorkLevel	= String.valueOf(reportInvgUser.get("disWorkLevel"));
		String handphone = String.valueOf(reportInvgUser.get("handphone"));
		String from_email = String.valueOf(reportInvgUser.get("email"));
		
		//전송시 계약자 피보험자 이름 두번째 글자 '*' 처리        
		String sHiddenPolicyNm = suimVo.getPolicyholder_nm().toString();
		String sHiddenBenefitNm = suimVo.getBeneficiary_nm().toString();
		String sHiddendamagedNm = damagedNm;
	
		if( !sHiddenPolicyNm.equals("") ) {        	
			if( sHiddenPolicyNm.length() == 1 ) {
				sHiddenPolicyNm = "*";
			}else {
				sHiddenPolicyNm = sHiddenPolicyNm.replace(sHiddenPolicyNm.charAt(1),'*');
			}        	        	
		}else {
			sHiddenPolicyNm = "";
		}
	
		if( !sHiddenBenefitNm.equals("") ) {
			if( sHiddenBenefitNm.length() == 1 ) {
				sHiddenBenefitNm = "*";
			}else {
				sHiddenBenefitNm = sHiddenBenefitNm.replace(sHiddenBenefitNm.charAt(1),'*');
			}        	
		}else {
			sHiddenBenefitNm = "";
		}
		
		if( !sHiddendamagedNm.equals("") ) {
			if( sHiddendamagedNm.length() == 1 ) {
				sHiddendamagedNm = "*";
			}else {
				sHiddendamagedNm = sHiddendamagedNm.replace(sHiddendamagedNm.charAt(1),'*');
			}        	
		}else {
			sHiddendamagedNm = "";
		}
		
		String reparationLiability ="";
		if("1".equals(reparationLiabilityType)){
			reparationLiability = "부책";
		}else{
			reparationLiability = "면책";
		}		
		String insuPayment ="";
		if("1".equals(insuPaymentType)){
			insuPayment = "부책";
		}else{
			insuPayment = "면책";
		}
		
		//직급이 수습인 경우 외부발송시 사원으로 변경
		String SendDisWorkLevel = "";
		if("수습".equals(disWorkLevel)) {
			SendDisWorkLevel = "사원";
		}else{
			SendDisWorkLevel = disWorkLevel;
		}
		
		//사고장소
		String investigate_addr1 = String.valueOf(suimVo.getInvestigate_addr1());		//null 처리		
		String investigate_addr2 = String.valueOf(suimVo.getInvestigate_addr2());		//null 처리
		
		String sAccPlace = "";
		
		if( !investigate_addr1.equals("") ) {
			sAccPlace = investigate_addr1; 
		}else if( !investigate_addr2.equals("") ){
			sAccPlace = investigate_addr2;
		}else{
			sAccPlace = "사고장소정보 미노출";
		}
		
		//담당자 자격증(손해사정사) 정보 List 만들기 시작
		String sUserNo = String.valueOf(rptIssueMain.get("userNo"));
		List<Map<String, Object>> certiReportUser = null;					//보고서 하단에 들어갈 담당자 정보 List
		List<Map<String, Object>> certiManagerReportUser = null;		//담당손해사정사 목록

		//기 종결건은 담당손해사정사가 별도 저장되어있음 (top_rpt_certi_end) 저장된 손해사정사 정보가 별도로 있는지 체크
		int nEndCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiEndCnt",paramMap);

		if( nEndCnt == 0 ) {			//정보가 없는 경우 실시간으로 가져온다.
			
			if( !"0".equals(sUserNo) ) {		//0은 미배당건        	
			certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiMemberInfo", paramMap);
			
			int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
			
			nCertiManagerCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiManagerCnt", paramMap);
			
			if( nCertiManagerCnt > 0 ) {			//담당손해사정사가 있는 경우
				certiManagerReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiManagerList", paramMap);
				for( int i=0; i < certiManagerReportUser.size(); i++) {
					certiReportUser.add(certiManagerReportUser.get(i));		//보고서 하단에 들어갈 담당자 정보에 담당손해사정서를 추가한다.
				}
			}
		    }
			
		}else{								//정보가 있는 경우 top_rpt_certi_end 테이블에서 불러온다.
			certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiEndInfo", paramMap);
		}

		String sCertiMemberText = "";

		if( certiReportUser == null ) {			//미배상건
			sCertiMemberText = "	<tr>" +
						"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;'>미배당건으로 담당자 정보가 없습니다.</td>" + 
						"	</tr>" + 
						"	<tr>";
		}else{
			for( int i=0; i < certiReportUser.size(); i++) {
				sCertiMemberText +="	<tr>" +
						"<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>"+String.valueOf(certiReportUser.get(i).get("certi_state_val"))+"</td>" + 
						"<td height='30' style='text-align: left; padding-left: 10px;' >"+String.valueOf(certiReportUser.get(i).get("user_name"))+" (직인생략) "+
						 "(&#9742; "+String.valueOf(certiReportUser.get(i).get("work_phone"))+")</td>" + 
				"	</tr>"+        				
				"   <tr>"+
					"<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>등록번호</td>" + 
						"<td height='30' style='text-align: left; padding-left: 10px;' >"+String.valueOf(certiReportUser.get(i).get("certi_number"))+"</td>" +
				"	</tr>";
			}
		}
		//담당자 자격증(손해사정사) 정보 List 만들기 끝
        
        //이메일 내용 시작
		String sSubject = "[접수번호 : "+suimAcceptNo+"] 보험업법 제189조 소정의 규정에 의거하여 아래와 같이 손해사정서를 안내합니다.";
		
		String sContent = "<table style='border-collapse:collapse;width:800px;font-size:12px;font-weight:bold;letter-spacing:1px;' border='1'>" +
		
				"<colgroup><col style='width:30%'><col style='width:70%'></colgroup>"+
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: center;' bgcolor='#EFF5FB'>보험업법 제189조 소정의 규정에 의거하여 아래와 같이 손해사정서를 안내합니다.</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>Report No</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'><font color='blue'>"+suimAcceptNo+"</font></td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>손해사정</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>[사고번호 : "+accidentNo+"]</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>1. 계약사항</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>가. 증권번호</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+sPolicyNo+"</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>나. 보험기간</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+insuTerm+"</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>다. 담보명</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+guaranteeTitle+"</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>라. 가입금액(보상한도액)</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+StringUtil.toMoneyString(amtSelfPay)+" 원</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>마. 자기부담금</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+StringUtil.toMoneyString(amtCompensationLimit)+" 원</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>바. 계약자 / 피보험자</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+sHiddenPolicyNm+" / "+sHiddenBenefitNm+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>사. 소재지(목적물)</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+sSuimAddress+"</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>2. 사고사항</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>가. 사고일시</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+accidentDate5+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>나. 사고장소</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+sAccPlace+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>다. 사고원인</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+insuContent+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>라. 사고경위</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+insuSequence+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>마. 피해자(피해물)</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+sHiddendamagedNm+"</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>3. 총괄표</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>가. 약관상면부책여부</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+LiabilityType+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>나. 지급보험금</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+InsuPayment+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>다. 지급처</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+PaymentPlace+"</td>" + 
				"	</tr>" ;
				
				sContent += sCertiMemberText +
				
				//"	<tr>" + 
				//"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>담당자</td>" + 
				//"		<td height='30' style='text-align: left; padding-left: 10px;'>"+userName+"</td>" + 
				//"	</tr>" + 
				//"	<tr>" + 
				//"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>대표손해사정사</td>" + 
				//"		<td height='30' style='text-align: left; padding-left: 10px;'>윤경수 (직인생략)</td>" + 
				//"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>대표이사</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>전태옥 (직인생략)</td>" + 
				"	</tr></table>";				
		//이메일 내용 끝
		
		String sFromName = "탑손해사정";
		String sFromAddress = from_email;
		String sRet = "";
		
		Sendmail sendmail = new Sendmail();
		try {
			//알림메일 발송
			sRet = sendmail.send( sFromName, sFromAddress, sToAddress, sSubject, sContent, "", "" );								
			logger.info("Sendmail Issue Axa Send : "+sToAddress +" : "+ suimAcceptNo);
		} catch (Exception e) {
			System.out.println("Sendmail Issue Axa Send Error: "+e.getMessage());
			resultMap.put("RESULT_MSG", "Email Axa Send Error :" + e.getMessage());
		}
		
		if( "Success".equals(sRet) ) {		//메일 발송 성공시 발송정보를 저장하고 갱신한다.
			//발송성공 시 발송상태값을 변경한다.
			paramMap.put("send_content", sContent);
			sqlSession.update("RptIssueMapper.updateRptIssueSendEmailOk",paramMap);			
			
			paramMap.put("email", sToAddress);
			//같은 이메일주소로 등록되어있는 경우 한건발송으로 다 처리된것으로 한다.
        	sqlSession.update("RptIssueMapper.updateRptIssueSendMagOkEmail",paramMap);
		}
        
        resultMap.put("RESULT_MSG", sRet);
        	
    	return resultMap;
    }
    
    /**
     * 손해사정서 흥국 이메일 발송
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_Issue_send_heungkuk_email")
    @ResponseBody
    public Map<String, Object> report_Issue_send_heungkuk_email(HttpServletRequest request, Model model){
    	    	
    	logger.info("======== report_Issue_send_heungkuk_email ========");
    	
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        Map<String, Object> resultMap = new HashMap<String,Object>();
        
      //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        //계약자 정보가져오기
        SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);
        
        //보험목적물 계약정보 가져오기
        List<Map<String, Object>> rptIssueContList = sqlSession.selectList("RptIssueMapper.selectRptIssueContLotte", paramMap);
        
        //총괄표 정보 가져오기
        List<Map<String, Object>> rptIssueSummaryList = sqlSession.selectList("RptIssueMapper.selectRptIssueSummaryLotte", paramMap);
        
        String sCtypeName = "";
        
        String sCtype = paramMap.get("ctype").toString();		//보험타입 (C:재물보험, B:배상보험, I:인보험)
        if( sCtype.equals("C") ) {
        	sCtypeName = "보험목적물";
        }else {
        	sCtypeName = "계약약관";
        }
        
        //조사자 정보
        paramMap.put("user_no", rptIssueMain.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
        
        //발송할 email 정보
        Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
        String sToAddress = String.valueOf(sendMap.get("email"));
        
        //Msg에 넣을 정보
        String suimAcceptNo 				= String.valueOf(rptIssueMain.get("suimAcceptNo"));
		String accidentNo 					= String.valueOf(rptIssueMain.get("accidentNo"));
		
		String insuranceNm 					= String.valueOf(rptIssueMain.get("insuranceNm"));
		String insuTerm 					= String.valueOf(rptIssueMain.get("insuTerm"));
		//자기부담금 단위, 자기부담금액
		String amtSelfPayUnit 				= String.valueOf(rptIssueMain.get("amtSelfPayUnit"));
		//int amtSelfPay 						= Integer.parseInt(String.valueOf(rptIssueMain.get("amtSelfPay")));				
		long amtSelfPay 						= Long.parseLong(String.valueOf(rptIssueMain.get("amtSelfPay")));
		String accidentDate5 				= String.valueOf(rptIssueMain.get("accidentDate5"));
		
		String insuContent 			        = String.valueOf(rptIssue.get("insuContent"));		
		//int amtInsuPayment 					= Integer.parseInt(String.valueOf(rptIssueMain.get("amtInsuPayment")));		
		long amtInsuPayment 					= Long.parseLong(String.valueOf(rptIssueMain.get("amtInsuPayment")));
		
		String userName 					= String.valueOf(reportInvgUser.get("userName"));
		String disWorkLevel 				= String.valueOf(reportInvgUser.get("disWorkLevel"));
		String handphone 					= String.valueOf(reportInvgUser.get("handphone"));
		String from_email = String.valueOf(reportInvgUser.get("email"));
		
		//총괄표 세부사항 메시지 만들기
        String sSummaryContent = "";
        
        //합계계산하기
        long sum_joinPrice = 0;
        long sum_insuPrice = 0;
        long sum_lossPrice = 0;
        long sum_remainPrice = 0;
        long sum_responPrice = 0;        
        long sum_compLimitPrice = 0;
        long sum_compResponPrice = 0;      
        long sum_selfOptPrice = 0;
        long sum_netLossPrice = 0;
        long sum_lossCompPrice = 0;
        long sum_billPrice = 0;
        long sum_payPrice = 0;

        //합계 계산 로직 추가 by top3009        
        for( int i=0; i < rptIssueSummaryList.size(); i++ ) {
        	sum_joinPrice += Long.parseLong(rptIssueSummaryList.get(i).get("joinPrice").toString());
        	sum_insuPrice += Long.parseLong(rptIssueSummaryList.get(i).get("insuPrice").toString());
        	sum_lossPrice += Long.parseLong(rptIssueSummaryList.get(i).get("lossPrice").toString());
        	sum_remainPrice += Long.parseLong(rptIssueSummaryList.get(i).get("remainPrice").toString());
        	sum_responPrice += Long.parseLong(rptIssueSummaryList.get(i).get("responPrice").toString());
        	sum_netLossPrice += Long.parseLong(rptIssueSummaryList.get(i).get("netLossPrice").toString());		//삼성추가        	
        	sum_compLimitPrice += Long.parseLong(rptIssueSummaryList.get(i).get("compLimitPrice").toString());
        	sum_compResponPrice += Long.parseLong(rptIssueSummaryList.get(i).get("compResponPrice").toString());
        	sum_selfOptPrice += Long.parseLong(rptIssueSummaryList.get(i).get("selfOptPrice").toString());
        	sum_lossCompPrice += Long.parseLong(rptIssueSummaryList.get(i).get("lossCompPrice").toString());		//삼성추가
        	sum_billPrice += Long.parseLong(rptIssueSummaryList.get(i).get("billPrice").toString());		//삼성추가
        	sum_payPrice += Long.parseLong(rptIssueSummaryList.get(i).get("payPrice").toString());		//삼성추가        	
        }
        
        if( sCtype.equals("C") ) {
        	if( rptIssueSummaryList.size() > 0 ) {
        		
        		sSummaryContent += "<tr>"
						+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>목적물</td>"
						+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>보험가입금액</td>"
						+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>보험가액</td>"
						+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>손해액</td>"
						+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>잔존물</td>"
						+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>지급보험금</td>"
						+ "</tr>";
        		
            	for(int k=0; k < rptIssueSummaryList.size(); k++) {
            		
            		Map<String, Object>smap = rptIssueSummaryList.get(k);
            		
            		sSummaryContent += "<tr>"
							+ "<td height='30' style='text-align: center;'>"+smap.get("summaryCate").toString()+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("joinPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("insuPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("lossPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("remainPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("payPrice").toString())+"</td>"
							+ "</tr>";
            	}
            }else {
            	sSummaryContent += "<td height='30' colspan='6' style='text-align: center;'>내용없음</td>";
            }
        	
        	sSummaryContent += "<tr>"
					+ "<td height='30' style='text-align: center;font-weight:bold;'>합계</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_joinPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_insuPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_lossPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_remainPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_payPrice)+"</td>"
					+ "</tr>";
        	
        	sSummaryContent += "<tr>"
					+ "<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>자기부담금</td>"
					+ "<td height='30' colspan='5' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(rptIssueMain.get("amtSelfPay").toString())+"</td>"
					+ "</tr>";
        	
        }else if( sCtype.equals("B") ) {
        	
        	sSummaryContent += "<tr>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>목적물</td>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>보상한도액</td>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>손해액</td>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>공제금액</td>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>지급보험금</td>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>비고</td>"
					+ "</tr>";
        	
        	if( rptIssueSummaryList.size() > 0 ) {
            	for(int k=0; k < rptIssueSummaryList.size(); k++) {
            		Map<String, Object>smap = rptIssueSummaryList.get(k);
            		
            		sSummaryContent += "<tr>"
							+ "<td height='30' style='text-align: center;'>"+smap.get("summaryCate").toString()+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("compLimitPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("lossPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("netLossPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("payPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: left;padding-left:5px;'>"+smap.get("exceptionVal").toString()+"</td>"
							+ "</tr>";
            	}
            }else {
            	sSummaryContent += "<td height='30' colspan='6' style='text-align: center;'>내용없음</td>";
            }
        	
        	sSummaryContent += "<tr>"
					+ "<td height='30' style='text-align: center;font-weight:bold;'>합계</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_compLimitPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_lossPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_netLossPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_payPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'></td>"
					+ "</tr>";
        	
        }else if( sCtype.equals("I") ){
        	
        	sSummaryContent += "<tr>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>증권번호</td>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>담보명</td>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>가입금액</td>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>청구금액</td>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>지급금액</td>"
					+ "<td height='30' style='text-align: center;' bgcolor='#EFF5FB'>비고</td>"
					+ "</tr>";
        	
        	if( rptIssueSummaryList.size() > 0 ) {
            	for(int k=0; k < rptIssueSummaryList.size(); k++) {
            		Map<String, Object>smap = rptIssueSummaryList.get(k);
            		
            		sSummaryContent += "<tr>"
							+ "<td height='30' style='text-align: center;'>"+smap.get("insuNm").toString()+"</td>"
							+ "<td height='30' style='text-align: center;'>"+smap.get("summaryCate").toString()+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("joinPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("billPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: right;padding-right:5px;'>"+StringUtil.toMoneyString(smap.get("payPrice").toString())+"</td>"
							+ "<td height='30' style='text-align: left;padding-left:5px;'>"+smap.get("exceptionVal").toString()+"</td>"
							+ "</tr>";            			
            	}
            }else {
            	sSummaryContent += "<td height='30' colspan='6' style='text-align: center;'>내용없음</td>";
            }
        	
        	sSummaryContent += "<tr>"
					+ "<td height='30' style='text-align: center;font-weight:bold;'>합계</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'></td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_joinPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_billPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'>"+StringUtil.toMoneyString(sum_payPrice)+"</td>"
					+ "<td height='30' style='text-align: right;padding-right:5px;font-weight:bold;'></td>"
					+ "</tr>";
        	
        }else {
        	sSummaryContent += "<td height='30' colspan='6' style='text-align: center;'>내용없음</td>";
        }
        
        //특이사항 처리
        //비고 null 처리
        String sSpecialContent = "";
        
    	if( rptIssue.get("remarkVal") != null ) {
    		sSpecialContent = rptIssue.get("remarkVal").toString();
    	}else {
    		sSpecialContent = "-";
    	}
		
		//증권번호
		String sPolicyNo = String.valueOf(rptIssueMain.get("policyNo"));
		
		//소재지
		String sSuimAddress = String.valueOf(rptIssue.get("suimAddress")).replace("null", "");
		
		//전송시 계약자 피보험자 이름 두번째 글자 '*' 처리        
		String sHiddenPolicyNm = suimVo.getPolicyholder_nm().toString();
		String sHiddenBenefitNm = suimVo.getBeneficiary_nm().toString();

		if( !sHiddenPolicyNm.equals("") ) {        	
			if( sHiddenPolicyNm.length() == 1 ) {
				sHiddenPolicyNm = "*";
			}else {
				sHiddenPolicyNm = sHiddenPolicyNm.replace(sHiddenPolicyNm.charAt(1),'*');
			}        	        	
		}else {
			sHiddenPolicyNm = "";
		}

		if( !sHiddenBenefitNm.equals("") ) {
			if( sHiddenBenefitNm.length() == 1 ) {
				sHiddenBenefitNm = "*";
			}else {
				sHiddenBenefitNm = sHiddenBenefitNm.replace(sHiddenBenefitNm.charAt(1),'*');
			}        	
		}else {
			sHiddenBenefitNm = "";
		}		
		
		//사고장소
		String investigate_addr1 = String.valueOf(suimVo.getInvestigate_addr1());		//null 처리
		String investigate_addr2 = String.valueOf(suimVo.getInvestigate_addr2());		//null 처리
		String sAccPlace = "";
		
		if( !investigate_addr1.equals("") ) {
			sAccPlace = investigate_addr1; 
		}else if( !investigate_addr2.equals("") ){
			sAccPlace = investigate_addr2;
		}else{
			sAccPlace = "사고장소정보 미노출";
		}
		
		//담당자 자격증(손해사정사) 정보 List 만들기 시작
		String sUserNo = String.valueOf(rptIssueMain.get("userNo"));
		List<Map<String, Object>> certiReportUser = null;					//보고서 하단에 들어갈 담당자 정보 List
		List<Map<String, Object>> certiManagerReportUser = null;		//담당손해사정사 목록

		//기 종결건은 담당손해사정사가 별도 저장되어있음 (top_rpt_certi_end) 저장된 손해사정사 정보가 별도로 있는지 체크
		int nEndCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiEndCnt",paramMap);

		if( nEndCnt == 0 ) {			//정보가 없는 경우 실시간으로 가져온다.
			
			if( !"0".equals(sUserNo) ) {		//0은 미배당건        	
			certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiMemberInfo", paramMap);
			
			int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
			
			nCertiManagerCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiManagerCnt", paramMap);
			
			if( nCertiManagerCnt > 0 ) {			//담당손해사정사가 있는 경우
				certiManagerReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiManagerList", paramMap);
				for( int i=0; i < certiManagerReportUser.size(); i++) {
					certiReportUser.add(certiManagerReportUser.get(i));		//보고서 하단에 들어갈 담당자 정보에 담당손해사정서를 추가한다.
				}
			}
		    }
			
		}else{								//정보가 있는 경우 top_rpt_certi_end 테이블에서 불러온다.
			certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiEndInfo", paramMap);
		}

		String sCertiMemberText = "";

		if( certiReportUser == null ) {			//미배상건
			sCertiMemberText = "	<tr>" +
						"		<td height='30' colspan='5' style='text-align: left; padding-left: 10px;'>미배당건으로 담당자 정보가 없습니다.</td>" + 
						"	</tr>" + 
						"	<tr>";
		}else{
			for( int i=0; i < certiReportUser.size(); i++) {
				sCertiMemberText +="	<tr>" +
						"<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>"+String.valueOf(certiReportUser.get(i).get("certi_state_val"))+"</td>" + 
						"<td height='30' style='text-align: left; padding-left: 10px;' colspan='5'>"+String.valueOf(certiReportUser.get(i).get("user_name"))+" (직인생략) "+
						 "(&#9742; "+String.valueOf(certiReportUser.get(i).get("work_phone"))+")</td>" + 
				"	</tr>"+        				
				"   <tr>"+
					"<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>등록번호</td>" + 
						"<td height='30' style='text-align: left; padding-left: 10px;' colspan='5'>"+String.valueOf(certiReportUser.get(i).get("certi_number"))+"</td>" +
				"	</tr>";
			}
		}
		//담당자 자격증(손해사정사) 정보 List 만들기 끝
        
        //이메일 내용 시작
		String sSubject = "[접수번호 : "+suimAcceptNo+"] 보험업법 제189조 소정의 규정에 의거하여 아래와 같이 손해사정서를 안내합니다.";
		
		String sContent = "<table style='border-collapse:collapse;width:800px;font-size:12px;font-weight:bold;letter-spacing:1px;' border='1'>" +
				"	<tr>" + 
				"		<td height='30' colspan='6' style='text-align: center;' bgcolor='#EFF5FB'>보험업법 제189조 소정의 규정에 의거하여 아래와 같이 손해사정서를 안내합니다.</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>Report No</td>" + 
				"		<td height='30' colspan='5' style='text-align: left; padding-left: 10px;'><font color='blue'>"+suimAcceptNo+"</font></td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>손해사정</td>" + 
				"		<td height='30' colspan='5' style='text-align: left; padding-left: 10px;'>[사고번호 : "+accidentNo+"]</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='6' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>1. 계약사항</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>가. 보험종목</td>" + 
				"		<td height='30' colspan='5' style='text-align: left; padding-left: 10px;'>"+insuranceNm+"</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>나. 증권번호</td>" + 
				"		<td height='30' colspan='5' style='text-align: left; padding-left: 10px;'>"+sPolicyNo+"</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>다. 계약자</td>" + 
				"		<td height='30' colspan='5' style='text-align: left; padding-left: 10px;'>"+sHiddenPolicyNm+"</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>라. 피보험자</td>" + 
				"		<td height='30' colspan='5' style='text-align: left; padding-left: 10px;'>"+sHiddenBenefitNm+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>마. 소재지</td>" + 
				"		<td height='30' colspan='5' style='text-align: left; padding-left: 10px;'>"+StringUtil.null2blank(sSuimAddress.replace("null", ""))+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>바. 보험기간</td>" + 
				"		<td height='30' colspan='5' style='text-align: left; padding-left: 10px;'>"+insuTerm+"</td>" + 
				"	</tr>"+		
				"	<tr>" +
				"		<td height='30' colspan='6' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>2. 사고사항</td>" +
				"	</tr>";
		
		if("I".equals(sCtype)) {
			sContent += "	<tr>" + 
					"		<td height='30' style='font-size:11px; text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>가. 사고(진료)일시</td>" + 
					"		<td height='30' colspan='5' style='text-align: left; padding-left: 10px;'>"+accidentDate5+"</td>" + 
					"	</tr>" +
					"	<tr>" + 
					"		<td height='30' style='font-size:11px; text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>나. 사고(진단)내용</td>" + 
					"		<td height='30' colspan='5' style='text-align: left; padding-left: 10px;'>"+insuContent+"</td>" + 
					"	</tr>";
		}else {
			sContent += "	<tr>" + 
					"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>가. 사고일자</td>" + 
					"		<td height='30' colspan='5' style='text-align: left; padding-left: 10px;'>"+accidentDate5+"</td>" + 
					"	</tr>" +
					"	<tr>" + 
					"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>나. 사고장소</td>" + 
					"		<td height='30' colspan='5' style='text-align: left; padding-left: 10px;'>"+StringUtil.null2blank(sAccPlace.replace("null", ""))+"</td>" + 
					"	</tr>" +
					"	<tr>" + 
					"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>다. 사고내용</td>" + 
					"		<td height='30' colspan='5' style='text-align: left; padding-left: 10px;'>"+insuContent+"</td>" + 
					"	</tr>";
		} 
		sContent += "	<tr>" + 
				"		<td height='30' colspan='6' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>3. 총괄표 (단위:원)</td>" +
				"	</tr>" +		
				sSummaryContent;
		
		if("I".equals(sCtype)) {
			sContent += "	<tr>" + 
					"		<td height='30' colspan='6' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>4. 확인사항</td>" +
					"   </tr>" +
					"   <tr>" +
					"		<td height='30' colspan='6' style='text-align: left; padding-left: 10px;'>"+sSpecialContent+"</td>" + 
					"	</tr>";
		}else{
			sContent += "	<tr>" +		
					"		<td height='30' colspan='6' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>4. 특이사항</td>" +
					"   </tr>" +
					"   <tr>" +
					"		<td height='30' colspan='6' style='text-align: left; padding-left: 10px;'>"+sSpecialContent+"</td>" +					
					"	</tr>";
		}				
		
		sContent += "	<tr>" + 
					"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>담당자</td>" + 
					"		<td height='30' colspan='5' style='text-align: left; padding-left: 10px;'>"+userName+"</td>" + 
					"	</tr>";
					
					sContent += sCertiMemberText +
					
					//"	<tr>" + 
					//"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>대표손해사정사</td>" + 
					//"		<td height='30' colspan='5' style='text-align: left; padding-left: 10px;'>윤경수 (직인생략)</td>" + 
					//"	</tr>" +
					"	<tr>" + 
					"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>대표이사</td>" + 
					"		<td height='30' colspan='5' style='text-align: left; padding-left: 10px;'>전태옥 (직인생략)</td>" + 
					"	</tr></table>";						
		//이메일 내용 끝
		
		String sFromName = "탑손해사정";
		String sFromAddress = from_email;
		String sRet = "";
		
		Sendmail sendmail = new Sendmail();
		try {
			//알림메일 발송
			sRet = sendmail.send( sFromName, sFromAddress, sToAddress, sSubject, sContent, "", "" );								
			logger.info("Sendmail Issue Heungkuk Send : "+sToAddress +" : "+ suimAcceptNo);
		} catch (Exception e) {
			System.out.println("Sendmail Issue Heungkuk Send Error: "+e.getMessage());
			resultMap.put("RESULT_MSG", "Email Heungkuk Send Error :" + e.getMessage());
		}
		
		if( "Success".equals(sRet) ) {		//메일 발송 성공시 발송정보를 저장하고 갱신한다.
			//발송성공 시 발송상태값을 변경한다.
			paramMap.put("send_content", sContent);
			sqlSession.update("RptIssueMapper.updateRptIssueSendEmailOk",paramMap);			
			
			paramMap.put("email", sToAddress);
			//같은 이메일주소로 등록되어있는 경우 한건발송으로 다 처리된것으로 한다.
        	sqlSession.update("RptIssueMapper.updateRptIssueSendMagOkEmail",paramMap);
		}
        
        resultMap.put("RESULT_MSG", sRet);
        	
    	return resultMap;
    }
    
    /**
     * 손해사정서 기본 이메일 발송
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_Issue_send_email")
    @ResponseBody
    public Map<String, Object> report_Issue_send_email(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        Map<String, Object> resultMap = new HashMap<String,Object>();
        
        //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);

        //조사자 정보
        paramMap.put("user_no", rptIssueMain.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
        
        //발송할 email 정보
        Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
        String sToAddress = String.valueOf(sendMap.get("email"));
        
        //Msg에 넣을 정보
        String suimAcceptNo = String.valueOf(rptIssueMain.get("suimAcceptNo"));
		String accidentNo = String.valueOf(rptIssueMain.get("accidentNo"));
		String ptnrName = String.valueOf(rptIssueMain.get("ptnrName"));
		String insuranceNm = String.valueOf(rptIssueMain.get("insuranceNm"));
		String insuTerm = String.valueOf(rptIssueMain.get("insuTerm"));
		String insuCondition = String.valueOf(rptIssueMain.get("insuCondition"));
		String amtSelfPayUnit = String.valueOf(rptIssueMain.get("amtSelfPayUnit"));
		String amtCompensationLimitUnit = String.valueOf(rptIssueMain.get("amtCompensationLimitUnit"));
		long amtCompensationLimit = Long.parseLong(String.valueOf(rptIssueMain.get("amtCompensationLimit")));
		long amtSelfPay = Long.parseLong(String.valueOf(rptIssueMain.get("amtSelfPay")));
		String accidentDate5 = String.valueOf(rptIssueMain.get("accidentDate5"));
		String insuContent = String.valueOf(rptIssue.get("insuContent"));
		String reparationLiabilityType = String.valueOf(rptIssue.get("reparationLiabilityType"));
		String reparationLiabilityReason = String.valueOf(rptIssue.get("reparationLiabilityReason"));
		String insuPaymentType = String.valueOf(rptIssue.get("insuPaymentType"));
		String amtInsuPaymentDisable	= String.valueOf(rptIssueMain.get("amtInsuPaymentDisable"));					//지급보험금 협의금액에 따름으로 표시
		long amtInsuPayment = Long.parseLong(String.valueOf(rptIssueMain.get("amtInsuPayment")));
		
		String userName	= String.valueOf(reportInvgUser.get("userName"));
		String disWorkLevel	= String.valueOf(reportInvgUser.get("disWorkLevel"));
		String handphone = String.valueOf(reportInvgUser.get("handphone"));
		String from_email = String.valueOf(reportInvgUser.get("email"));
		
		String reparationLiability ="";
		if("1".equals(reparationLiabilityType)){
			reparationLiability = "부책";
		}else{
			reparationLiability = "면책";
		}		
		String insuPayment ="";
		if("1".equals(insuPaymentType)){
			insuPayment = "부책";
		}else{
			insuPayment = "면책";
		}
		
		//직급이 수습인 경우 외부발송시 사원으로 변경
		String SendDisWorkLevel = "";
		if("수습".equals(disWorkLevel)) {
			SendDisWorkLevel = "사원";
		}else{
			SendDisWorkLevel = disWorkLevel;
		}
        
        //이메일 내용 시작
		String sSubject = "[접수번호 : "+suimAcceptNo+"] 보험업법 제189조 소정의 규정에 의거하여 아래와 같이 손해사정서를 안내합니다.";
		
		String sContent = "<table style='border-collapse:collapse;width:800px;font-size:12px;font-weight:bold;letter-spacing:1px;' border='1'>" +
		
				"<colgroup><col style='width:30%'><col style='width:70%'></colgroup>"+
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: center;' bgcolor='#EFF5FB'>보험업법 제189조 소정의 규정에 의거하여 아래와 같이 손해사정서를 안내합니다.</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>Report No</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'><font color='blue'>"+suimAcceptNo+"</font></td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>손해사정</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>[사고번호 : "+accidentNo+"]</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>1. 보험계약사항</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>가. 보험사명</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+ptnrName+"</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>나. 보험종목</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+insuranceNm+"</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>다. 보험기간</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+insuTerm+"</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>라. 담보내용</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+insuCondition+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>마. 가입금액</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+amtCompensationLimitUnit+" "+String.format("%,d",amtCompensationLimit)+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>바. 자기부담금</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+amtSelfPayUnit+" "+String.format("%,d",amtSelfPay)+"</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>2. 사고사항</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>가. 사고일자</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+accidentDate5+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>나. 사고내용</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+insuContent+"</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>3. 손해액 및 보험금 사정에 크게 영향을 미친 사항</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>"+reparationLiability+"</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+reparationLiabilityReason+"</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>4. 지급보험금</td>" +
				"	</tr>"; 
		if("1".equals(amtInsuPaymentDisable)) {
			sContent += "	<tr><td height='30' colspan='2' style='text-align: left; padding-left: 10px;'>단체 사고의 경우 개별 안내 금액에 따름</td></tr>";
		}else {
			sContent += "	<tr>" +
								"	<td height='30' colspan='2' style='text-align: left; padding-left: 10px;'>￦"+String.format("%,d",amtInsuPayment)+"</td>" + 
								"</tr>";
		}
		sContent += "	<tr>" + 
						"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>담당자</td>" + 
						"		<td height='30' style='text-align: left; padding-left: 10px;'>"+SendDisWorkLevel+" "+userName+"  (연락처 : "+handphone+")</td>" + 
						"	</tr>" + 
						"	<tr>" + 
						"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>대표손해사정사</td>" + 
						"		<td height='30' style='text-align: left; padding-left: 10px;'>윤경수 (직인생략)</td>" + 
						"	</tr>" +
						"	<tr>" + 
						"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>대표이사</td>" + 
						"		<td height='30' style='text-align: left; padding-left: 10px;'>전태옥 (직인생략)</td>" + 
						"	</tr>" +
						"	<tr>" +
						"<td height='30' colspan='2' style='text-align: left; padding-left: 10px;'>" +
						"※ 본 손해사정서는 보험업법 제188조에 근거한 손해사정사의 의견으로 보험업법 제189조에 따라 발송하는 서식이며 보험사의 최종의사결과에 따라 달라질 수 있음을 양지해 주시기 바랍니다."+
						"</td></tr></table>";
		//이메일 내용 끝
		
		String sFromName = "탑손해사정";
		String sFromAddress = from_email;
		String sRet = "";
		
		Sendmail sendmail = new Sendmail();
		try {
			//알림메일 발송
			sRet = sendmail.send( sFromName, sFromAddress, sToAddress, sSubject, sContent, "", "" );								
			logger.info("Sendmail Issue Send : "+sToAddress +" : "+ suimAcceptNo);
		} catch (Exception e) {
			System.out.println("Sendmail Issue Send Error: "+e.getMessage());
			resultMap.put("RESULT_MSG", "Email Send Error :" + e.getMessage());
		}
		
		if( "Success".equals(sRet) ) {		//메일 발송 성공시 발송정보를 저장하고 갱신한다.
			//발송성공 시 발송상태값을 변경한다.
			paramMap.put("send_content", sContent);
			sqlSession.update("RptIssueMapper.updateRptIssueSendEmailOk",paramMap);			
			
			paramMap.put("email", sToAddress);
			//같은 이메일주소로 등록되어있는 경우 한건발송으로 다 처리된것으로 한다.
        	sqlSession.update("RptIssueMapper.updateRptIssueSendMagOkEmail",paramMap);
		}
        
        resultMap.put("RESULT_MSG", sRet);
        	
    	return resultMap;
    }
        
    /**
     * 첨부파일을 통한 이메일 발송
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_Issue_send_email_attach")
    @ResponseBody
    public Map<String, Object> report_Issue_send_email_attach(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        Map<String, Object> resultMap = new HashMap<String,Object>();
        
        //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);

        //조사자 정보
        paramMap.put("user_no", rptIssueMain.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
        
        //발송할 email 정보
        Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
        String sToAddress = String.valueOf(sendMap.get("email"));
        
        //Msg에 넣을 정보
        String suimAcceptNo = String.valueOf(rptIssueMain.get("suimAcceptNo"));
		String accidentNo = String.valueOf(rptIssueMain.get("accidentNo"));				
		String from_email = String.valueOf(reportInvgUser.get("email"));
		String attachFilePath = String.valueOf(sendMap.get("filePath"));
		String attachFileName = String.valueOf(sendMap.get("orgFileName"));
		
        //이메일 내용 시작
		String sSubject = "[접수번호 : "+suimAcceptNo+"] 손해사정서 교부 ("+rptIssueMain.get("ptnrName")+")";
		
		String sContent = "<table style='border-collapse:collapse;width:840px;height:200px;font-size:14px;font-weight:bold;letter-spacing:2px;' border='0'>" +		
				
				"	<tr>" + 
				"		<td height='40' style='text-align: left; padding-left: 10px;'>보험금 청구 건에 대하여 보험업법 및 기타 법령에 의거하여 손해사정을 완료하고 그 결과를 손해사정서로<br/>"
						+ " 작성하여 별첨과 같이 교부합니다.<br/><br/>"
						+ "< 별첨 손해사정서 파일 암호 안내 ><br/>"
						+ "1. 개인 : 주민등록번호 앞 6자리<br/>"
						+ "2. 사업자 : 사업자등록번호 10자리<br/><br/>"
							+ "※ 본 손해사정 내용은 현재까지 발생 또는 확인된 사실 및 근거자료(입증자료, 진술서 등)에 근거한 것입니다.<br/>" +
							"   향후 이와 다른 사실이 확인되거나 기타 사정변경이 발생하는 등 손해사정 당시 예기치 못한 사항과<br/>" + 
							"   관련하여서는 이 손해사정 결과를 유보합니다"
						+ "</td>" +
				"	</tr></table>";
		//이메일 내용 끝
		
		String sFromName = "탑손해사정";
		String sFromAddress = from_email;
		String sRet = "";
		
		Sendmail sendmail = new Sendmail();
		
		//System.out.println("attachFilePath : "+attachFilePath);
		//System.out.println("attachFileName : "+attachFileName);
		
		try {
			//알림메일 발송
			sRet = sendmail.send( sFromName, sFromAddress, sToAddress, sSubject, sContent, attachFilePath, attachFileName );								
			logger.info("Sendmail Issue Send : "+sToAddress +" : "+ suimAcceptNo);
		} catch (Exception e) {
			System.out.println("Sendmail Issue Send Error: "+e.getMessage());
			resultMap.put("RESULT_MSG", "Email Send Error :" + e.getMessage());
		}
		
		if( "Success".equals(sRet) ) {		//메일 발송 성공시 발송정보를 저장하고 갱신한다.
			//발송성공 시 발송상태값을 변경한다.
			paramMap.put("send_content", sContent);
			sqlSession.update("RptIssueMapper.updateRptIssueSendEmailOk",paramMap);			
			
			paramMap.put("email", sToAddress);
			//같은 이메일주소로 등록되어있는 경우 한건발송으로 다 처리된것으로 한다.
        	sqlSession.update("RptIssueMapper.updateRptIssueSendMagOkEmail",paramMap);
		}
        
        resultMap.put("RESULT_MSG", sRet);
        	
    	return resultMap;
    }
    
    /**
     * 메리츠 손해사정서 이메일 발송
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_Issue_send_meritz_email")
    @ResponseBody
    public Map<String, Object> report_Issue_send_meritz_email(HttpServletRequest request, Model model){
    	
    	logger.info("======== report_Issue_send_meritz_email ========");
    	
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        Map<String, Object> resultMap = new HashMap<String,Object>();
        
        //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBscMeritz", paramMap);
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        String sUserNo = String.valueOf(rptIssueMain.get("userNo"));			//조사자 사번

        //조사자 정보
        paramMap.put("user_no",sUserNo);
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
        
        //발송할 email 정보
        Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
        String sToAddress = String.valueOf(sendMap.get("email"));
        
        //Msg에 넣을 정보
        String suimAcceptNo = String.valueOf(rptIssueMain.get("suimAcceptNo"));
		String accidentNo = String.valueOf(rptIssueMain.get("accidentNo"));
		String ptnrName = String.valueOf(rptIssueMain.get("ptnrName"));
		String insuranceNm = String.valueOf(rptIssueMain.get("insuranceNm"));
		String insuTerm = String.valueOf(rptIssueMain.get("insuTerm"));
		String insuCondition = String.valueOf(rptIssueMain.get("insuCondition"));
		String amtSelfPayUnit = String.valueOf(rptIssueMain.get("amtSelfPayUnit"));
		String amtCompensationLimitUnit = String.valueOf(rptIssueMain.get("amtCompensationLimitUnit"));
		long amtCompensationLimit = Long.parseLong(String.valueOf(rptIssueMain.get("amtCompensationLimit")));
		long amtSelfPay = Long.parseLong(String.valueOf(rptIssueMain.get("amtSelfPay")));
		String accidentDate5 = String.valueOf(rptIssueMain.get("accidentDate5"));
		String insuContent = String.valueOf(rptIssue.get("insuContent"));		
		String reparationLiabilityType = String.valueOf(rptIssue.get("reparationLiabilityType"));
		String reparationLiabilityReason = String.valueOf(rptIssue.get("reparationLiabilityReason"));
		String insuPaymentType = String.valueOf(rptIssue.get("insuPaymentType"));
		String amtInsuPaymentDisable	= String.valueOf(rptIssueMain.get("amtInsuPaymentDisable"));					//지급보험금 협의금액에 따름으로 표시
		long amtInsuPayment = Long.parseLong(String.valueOf(rptIssueMain.get("amtInsuPayment")));
		
		//메리츠용 변수 시작
		String meritzAcceptNo = String.valueOf(rptIssueMain.get("meritzAcceptNo"));
		String regDate = String.valueOf(rptIssueMain.get("regDate"));
		String meritzCloseDateFmt = String.valueOf(rptIssueMain.get("meritzCloseDateFmt"));
		String meritzSuimContent = String.valueOf(rptIssueMain.get("meritzSuimContent"));
		String sPolicyNo = String.valueOf(rptIssueMain.get("policyNo"));
		String sMeritzBeneficiary = String.valueOf(rptIssueMain.get("meritzBeneficiary"));
		
		String sWriteDate = "";
	        
		Map<String,Object> writeDateMap = sqlSession.selectOne("RptIssueMapper.selectReportMeritzWriteDate", paramMap);
		
		sWriteDate = String.valueOf(writeDateMap.get("writeDateFmt"));
		
		//메리츠용 담보정보		
		List<Map<String, Object>> coverageInfoList = sqlSession.selectList("RptIssueMapper.selectReportMeritzCoverageInfo", paramMap);		
		//메리츠용 변수 끝
		
		String userName	= String.valueOf(reportInvgUser.get("userName"));
		String disWorkLevel	= String.valueOf(reportInvgUser.get("disWorkLevel"));
		String handphone = String.valueOf(reportInvgUser.get("handphone"));
		String from_email = String.valueOf(reportInvgUser.get("email"));
		
		String reparationLiability ="";
		if( "1".equals(reparationLiabilityType) ){
			reparationLiability = "부책";
		}else if( "2".equals(reparationLiabilityType) ) {
			reparationLiability = "면책";
		}else{
			reparationLiability = "-";
		}
		
		String insuPayment ="";
		if("1".equals(insuPaymentType)){
			insuPayment = "부책";
		}else{
			insuPayment = "면책";
		}
		
		//직급이 수습인 경우 외부발송시 사원으로 변경
		String SendDisWorkLevel = "";
		if("수습".equals(disWorkLevel)) {
			SendDisWorkLevel = "사원";
		}else{
			SendDisWorkLevel = disWorkLevel;
		}
		
		//손해사정서 양식 변경에 따라 항목 추가 시작
		String regDateFmt = String.valueOf(rptIssueMain.get("regDate"));		//수임일
		
		String policyholderNm = String.valueOf(rptIssueMain.get("policyholderNm"));		//계약자
		String beneficiaryNm = String.valueOf(rptIssueMain.get("beneficiaryNm"));			//피보험자
		
        Map<String, Object> lawEtcContentMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawContentInfo", paramMap);
        model.addAttribute("lawEtcContentInfo", lawEtcContentMap);
        
        String lawSubject = String.valueOf(lawEtcContentMap.get("law_subject"));			//관련법규
        String lawEtc = String.valueOf(lawEtcContentMap.get("law_etc"));						//관련약관


        Map<String, Object> lawReasonMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawReasonInfo", paramMap);
        model.addAttribute("lawReasonInfo", lawReasonMap);


        Map<String, Object> lawSelContentMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawSelInfo", paramMap);
        model.addAttribute("lawSelContentInfo", lawSelContentMap);
        
        String reparationLiabilityReasonEtc = String.valueOf(lawSelContentMap.get("reparation_liability_reason_etc"));		//책임범위
        
        if( "2".equals(reparationLiabilityReasonEtc) ) {
        	reparationLiabilityReasonEtc = "동 약관 보상하지 않는 손해";
        }else if( "1".equals(reparationLiabilityReasonEtc) ) {
        	reparationLiabilityReasonEtc = "동 약관 보상하는 손해";
        }else{
        	reparationLiabilityReasonEtc = "-";
        }
        
      	//담당자 자격증(손해사정사) 정보 List 만들기 시작
        List<Map<String, Object>> certiReportUser = null;					//보고서 하단에 들어갈 담당자 정보 List
        List<Map<String, Object>> certiManagerReportUser = null;		//담당손해사정사 목록
        
        //기 종결건은 담당손해사정사가 별도 저장되어있음 (top_rpt_certi_end) 저장된 손해사정사 정보가 별도로 있는지 체크
        int nEndCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiEndCnt",paramMap);
        
        if( nEndCnt == 0 ) {			//정보가 없는 경우 실시간으로 가져온다.
        	
        	if( !"0".equals(sUserNo) ) {		//0은 미배당건        	
            	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiMemberInfo", paramMap);
            	
            	int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
            	
            	nCertiManagerCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiManagerCnt", paramMap);
            	
            	if( nCertiManagerCnt > 0 ) {			//담당손해사정사가 있는 경우
            		certiManagerReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiManagerList", paramMap);
            		for( int i=0; i < certiManagerReportUser.size(); i++) {
            			certiReportUser.add(certiManagerReportUser.get(i));		//보고서 하단에 들어갈 담당자 정보에 담당손해사정서를 추가한다.
            		}
            	}
            }
        	
        }else{								//정보가 있는 경우 top_rpt_certi_end 테이블에서 불러온다.
        	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiEndInfo", paramMap);
        }
        
        //담당자가 손해사정사인 경우 데이터 복제 (메리츠는 최소 조사자와 손해사정사가 나와야한다.)
        if( certiReportUser.size() == 1 ) {        	
        	certiReportUser.add(certiReportUser.get(0));
        }
        
        String sCertiMemberText = "";
        String sCertiStatValTemp = "";
        
        if( certiReportUser == null ) {			//미배상건
        	sCertiMemberText = "	<tr>" +
					"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;'>미배당건으로 담당자 정보가 없습니다.</td>" + 
					"	</tr>" + 
					"	<tr>";
        }else{
        	for( int i=0; i < certiReportUser.size(); i++) {
        		
        		if( i == 0 ) {
        			sCertiStatValTemp = "조사자";
        		}else{
        			sCertiStatValTemp = String.valueOf(certiReportUser.get(i).get("certi_state_val"));
        		}
        		
        		sCertiMemberText +="	<tr>" +
        				"<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>"+sCertiStatValTemp+"</td>" + 
        				"<td height='30' style='text-align: left; padding-left: 10px;'>"+String.valueOf(certiReportUser.get(i).get("user_name"))+" (직인생략)</td>" + 
        		"	</tr>"+        				
        		"   <tr>"+
	        		"<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>등록번호</td>" + 
					"<td height='30' style='text-align: left; padding-left: 10px;'>"+String.valueOf(certiReportUser.get(i).get("certi_number"))+"</td>" +
        		"	</tr>"+
        		"   <tr>"+
        		"<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>연락처</td>" + 
				"<td height='30' style='text-align: left; padding-left: 10px;'>&#9742;"+String.valueOf(certiReportUser.get(i).get("work_phone"))+"</td>" +
    		"	</tr>";
        	}
        }
        
		//담당자 자격증(손해사정사) 정보 List 만들기 끝
		//손해사정서 양식 변경에 따라 항목 추가 끝
        
        String sCoverageInfoText = "";
        
        
        //메리츠 담보정보 시작
        if( coverageInfoList.size() == 0 ) {
        	sCoverageInfoText = "	<tr>" +
					"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;'>담보정보가 없습니다.</td>" + 
					"	</tr>" + 
					"	<tr>";
        }else{
        	for(int i=0; i < coverageInfoList.size(); i++) {
        		sCoverageInfoText += "	<tr>" +
            			"<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>("+(i+1)+")담보명</td>" +
            			"<td height='30' style='text-align: left; padding-left: 10px;' >"+coverageInfoList.get(i).get("coverageNm")+"</td>" +
            			"	<tr>"+
            			"	<tr>" +
            			"<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>("+(i+1)+")가입금액</td>" +
            			"<td height='30' style='text-align: left; padding-left: 10px;' >"+String.format("%,d", coverageInfoList.get(i).get("joinPrice"))+"</td>" +
            			"	<tr>"+
            			"	<tr>" +
            			"<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>("+(i+1)+")청구금액</td>" +
            			"<td height='30' style='text-align: left; padding-left: 10px;' >"+String.format("%,d", coverageInfoList.get(i).get("billPrice"))+"</td>" +
            			"	<tr>";            			
        	}
        }
        //메리츠 담보정보 끝
        
        //이메일 내용 시작
String sSubject = "[접수번호 : "+suimAcceptNo+"] 보험업법 제189조 소정의 규정에 의거하여 아래와 같이 손해사정서를 안내합니다.";
		
		String sContent = "<table style='border-collapse:collapse;width:800px;font-size:12px;font-weight:bold;letter-spacing:1px;' border='1'>" +
		
				"<colgroup><col style='width:30%'><col style='width:70%'></colgroup>"+
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: center;' bgcolor='#EFF5FB'>보험업법 제189조 소정의 규정에 의거하여 아래와 같이 손해사정서를 안내합니다.</td>" +
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>1. 수임정보</td>" +
				"	</tr>" +				
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>가. 접수번호</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'><font color='blue'>"+meritzAcceptNo+"</font></td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>나. 수임일자</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+regDateFmt+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>다. 종결일자</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+meritzCloseDateFmt+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>라. 수임내용</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+meritzSuimContent+"</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>2. 계약사항</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>가. 증권번호</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+sPolicyNo+"</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>나. 상품명</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+insuranceNm+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>다. 계약자</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+policyholderNm+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>라. 피보험자</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+beneficiaryNm+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>마. 수익자</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+sMeritzBeneficiary+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>바. 보험기간</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+insuTerm+"</td>" + 
				"	</tr>" +
				sCoverageInfoText+	
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>3. 사고 및 손해조사내용</td>" +
				"	</tr>" +				
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>가. 사고내용</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+insuContent+"</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>4. 손해사정 시 적용된 관계 법규 및 약관</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>가. 관련법규</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+lawSubject+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>나. 관련약관</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+lawEtc+"</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>5. 약관상 보험자 지급책임의 범위</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>가. 지급책임</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+reparationLiability+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>나. 책임범위</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+reparationLiabilityReasonEtc+"</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>6. 그 밖에 손해액 및 보험금 사정에 크게 영향을 미친 사항</td>" +
				"	</tr>" +
				"	<tr>" +
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;'>"+reparationLiabilityReason+"</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='60' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>민감정보가 포함된 내용은 피보험자의 동의가 있을 경우에만 제공됩니다.<br/>상기 손해사정결과는 보험금 최종심사 결과와 상이할 수 있습니다.</td>" +
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>작성일자</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+sWriteDate+"</td>" + 
				"	</tr>" ;				
		
		sContent += sCertiMemberText +
						"	<tr>" + 
						"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>대표이사</td>" + 
						"		<td height='30' style='text-align: left; padding-left: 10px;'>전태옥 (직인생략)</td>" + 
						"	</tr>" +
						"	<tr>" +
						"<td height='60' colspan='2' style='text-align: left; padding-left: 10px;'>" +
						"※ 본 손해사정서는 보험업법 제188조에 근거한 손해사정사의 의견으로 보험업법 제189조에 따라 발송하는 서식이며 보험사의 최종의사결과에 따라 달라질 수 있음을 양지해 주시기 바랍니다."+
						"</td></tr></table>";
		//이메일 내용 끝
		
		String sFromName = "탑손해사정";
		String sFromAddress = from_email;
		String sRet = "";
		
		Sendmail sendmail = new Sendmail();
		try {
			//알림메일 발송
			sRet = sendmail.send( sFromName, sFromAddress, sToAddress, sSubject, sContent, "", "" );								
			logger.info("Sendmail Issue Send : "+sToAddress +" : "+ suimAcceptNo);
		} catch (Exception e) {
			System.out.println("Sendmail Issue Send Error: "+e.getMessage());
			resultMap.put("RESULT_MSG", "Email Send Error :" + e.getMessage());
		}
		
		if( "Success".equals(sRet) ) {		//메일 발송 성공시 발송정보를 저장하고 갱신한다.
			//발송성공 시 발송상태값을 변경한다.
			paramMap.put("send_content", sContent);
			sqlSession.update("RptIssueMapper.updateRptIssueSendEmailOk",paramMap);			
			
			paramMap.put("email", sToAddress);
			//같은 이메일주소로 등록되어있는 경우 한건발송으로 다 처리된것으로 한다.
        	sqlSession.update("RptIssueMapper.updateRptIssueSendMagOkEmail",paramMap);
		}
        
        resultMap.put("RESULT_MSG", sRet);
        	
    	return resultMap;
    }
    
    
    /**
     * 손해사정서 기본 이메일 발송 (양식 변경에 따른 신규)
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_Issue_send_new_email")
    @ResponseBody
    public Map<String, Object> report_Issue_send_new_email(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        Map<String, Object> resultMap = new HashMap<String,Object>();
        
        //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        String sUserNo = String.valueOf(rptIssueMain.get("userNo"));			//조사자 사번

        //조사자 정보
        paramMap.put("user_no",sUserNo);
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
        
        //발송할 email 정보
        Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
        String sToAddress = String.valueOf(sendMap.get("email"));
        
        //Msg에 넣을 정보
        String suimAcceptNo = String.valueOf(rptIssueMain.get("suimAcceptNo"));
		String accidentNo = String.valueOf(rptIssueMain.get("accidentNo"));
		String ptnrName = String.valueOf(rptIssueMain.get("ptnrName"));
		String insuranceNm = String.valueOf(rptIssueMain.get("insuranceNm"));
		String insuTerm = String.valueOf(rptIssueMain.get("insuTerm"));
		String insuCondition = String.valueOf(rptIssueMain.get("insuCondition"));
		String amtSelfPayUnit = String.valueOf(rptIssueMain.get("amtSelfPayUnit"));
		String amtCompensationLimitUnit = String.valueOf(rptIssueMain.get("amtCompensationLimitUnit"));
		long amtCompensationLimit = Long.parseLong(String.valueOf(rptIssueMain.get("amtCompensationLimit")));
		long amtSelfPay = Long.parseLong(String.valueOf(rptIssueMain.get("amtSelfPay")));
		String accidentDate5 = String.valueOf(rptIssueMain.get("accidentDate5"));
		String insuContent = String.valueOf(rptIssue.get("insuContent"));
		String reparationLiabilityType = String.valueOf(rptIssue.get("reparationLiabilityType"));
		String reparationLiabilityReason = String.valueOf(rptIssue.get("reparationLiabilityReason"));
		String insuPaymentType = String.valueOf(rptIssue.get("insuPaymentType"));
		String amtInsuPaymentDisable	= String.valueOf(rptIssueMain.get("amtInsuPaymentDisable"));					//지급보험금 협의금액에 따름으로 표시
		long amtInsuPayment = Long.parseLong(String.valueOf(rptIssueMain.get("amtInsuPayment")));
		
		String userName	= String.valueOf(reportInvgUser.get("userName"));
		String disWorkLevel	= String.valueOf(reportInvgUser.get("disWorkLevel"));
		String handphone = String.valueOf(reportInvgUser.get("handphone"));
		String from_email = String.valueOf(reportInvgUser.get("email"));
		
		String reparationLiability ="";
		if( "1".equals(reparationLiabilityType) ){
			reparationLiability = "부책";
		}else if( "2".equals(reparationLiabilityType) ) {
			reparationLiability = "면책";
		}else{
			reparationLiability = "-";
		}
		
		String insuPayment ="";
		if("1".equals(insuPaymentType)){
			insuPayment = "부책";
		}else{
			insuPayment = "면책";
		}
		
		//직급이 수습인 경우 외부발송시 사원으로 변경
		String SendDisWorkLevel = "";
		if("수습".equals(disWorkLevel)) {
			SendDisWorkLevel = "사원";
		}else{
			SendDisWorkLevel = disWorkLevel;
		}
		
		//손해사정서 양식 변경에 따라 항목 추가 시작
		String regDateFmt = String.valueOf(rptIssueMain.get("regDate"));		//수임일
		
		String policyholderNm = String.valueOf(rptIssueMain.get("policyholderNm"));		//계약자
		String beneficiaryNm = String.valueOf(rptIssueMain.get("beneficiaryNm"));			//피보험자
		
        Map<String, Object> lawEtcContentMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawContentInfo", paramMap);
        model.addAttribute("lawEtcContentInfo", lawEtcContentMap);
        
        String lawSubject = String.valueOf(lawEtcContentMap.get("law_subject"));			//관련법규
        String lawEtc = String.valueOf(lawEtcContentMap.get("law_etc"));						//관련약관


        Map<String, Object> lawReasonMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawReasonInfo", paramMap);
        model.addAttribute("lawReasonInfo", lawReasonMap);


        Map<String, Object> lawSelContentMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawSelInfo", paramMap);
        model.addAttribute("lawSelContentInfo", lawSelContentMap);
        
        String reparationLiabilityReasonEtc = String.valueOf(lawSelContentMap.get("reparation_liability_reason_etc"));		//책임범위
        
        if( "2".equals(reparationLiabilityReasonEtc) ) {
        	reparationLiabilityReasonEtc = "동 약관 보상하지 않는 손해";
        }else if( "1".equals(reparationLiabilityReasonEtc) ) {
        	reparationLiabilityReasonEtc = "동 약관 보상하는 손해";
        }else{
        	reparationLiabilityReasonEtc = "-";
        }
        
      	//담당자 자격증(손해사정사) 정보 List 만들기 시작
        List<Map<String, Object>> certiReportUser = null;					//보고서 하단에 들어갈 담당자 정보 List
        List<Map<String, Object>> certiManagerReportUser = null;		//담당손해사정사 목록
        
        //기 종결건은 담당손해사정사가 별도 저장되어있음 (top_rpt_certi_end) 저장된 손해사정사 정보가 별도로 있는지 체크
        int nEndCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiEndCnt",paramMap);
        
        if( nEndCnt == 0 ) {			//정보가 없는 경우 실시간으로 가져온다.
        	
        	if( !"0".equals(sUserNo) ) {		//0은 미배당건        	
            	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiMemberInfo", paramMap);
            	
            	int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
            	
            	nCertiManagerCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiManagerCnt", paramMap);
            	
            	if( nCertiManagerCnt > 0 ) {			//담당손해사정사가 있는 경우
            		certiManagerReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiManagerList", paramMap);
            		for( int i=0; i < certiManagerReportUser.size(); i++) {
            			certiReportUser.add(certiManagerReportUser.get(i));		//보고서 하단에 들어갈 담당자 정보에 담당손해사정서를 추가한다.
            		}
            	}
            }
        	
        }else{								//정보가 있는 경우 top_rpt_certi_end 테이블에서 불러온다.
        	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiEndInfo", paramMap);
        }
        
        String sCertiMemberText = "";
        
        if( certiReportUser == null ) {			//미배상건
        	sCertiMemberText = "	<tr>" +
					"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;'>미배당건으로 담당자 정보가 없습니다.</td>" + 
					"	</tr>" + 
					"	<tr>";
        }else{
        	for( int i=0; i < certiReportUser.size(); i++) {
        		sCertiMemberText +="	<tr>" +
        				"<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>"+String.valueOf(certiReportUser.get(i).get("certi_state_val"))+"</td>" + 
        				"<td height='30' style='text-align: left; padding-left: 10px;'>"+String.valueOf(certiReportUser.get(i).get("user_name"))+" (직인생략) "+
        				 "(&#9742; "+String.valueOf(certiReportUser.get(i).get("work_phone"))+")</td>" + 
        		"	</tr>"+        				
        		"   <tr>"+
	        		"<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>등록번호</td>" + 
					"<td height='30' style='text-align: left; padding-left: 10px;'>"+String.valueOf(certiReportUser.get(i).get("certi_number"))+"</td>" +
        		"	</tr>";
        	}
        }
        
		//담당자 자격증(손해사정사) 정보 List 만들기 끝
		//손해사정서 양식 변경에 따라 항목 추가 끝
        
        //이메일 내용 시작
		String sSubject = "[접수번호 : "+suimAcceptNo+"] 보험업법 제189조 소정의 규정에 의거하여 아래와 같이 손해사정서를 안내합니다.";
		
		String sContent = "<table style='border-collapse:collapse;width:800px;font-size:12px;font-weight:bold;letter-spacing:1px;' border='1'>" +
		
				"<colgroup><col style='width:30%'><col style='width:70%'></colgroup>"+
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: center;' bgcolor='#EFF5FB'>보험업법 제189조 소정의 규정에 의거하여 아래와 같이 손해사정서를 안내합니다.</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>Report No</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'><font color='blue'>"+suimAcceptNo+"</font></td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>손해사정</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>[사고번호 : "+accidentNo+"]</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>수임일자</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+regDateFmt+"</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>1. 보험계약사항</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>가. 보험사명</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+ptnrName+"</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>나. 보험종목</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+insuranceNm+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>다. 계약자</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+policyholderNm+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>라. 피보험자</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+beneficiaryNm+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>마. 보험기간</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+insuTerm+"</td>" + 
				"	</tr>" + 
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>바. 담보내용</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+insuCondition+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>사. 가입금액</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+amtCompensationLimitUnit+" "+String.format("%,d",amtCompensationLimit)+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>아. 자기부담금</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+amtSelfPayUnit+" "+String.format("%,d",amtSelfPay)+"</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>2. 사고사항</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>가. 사고일자</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+accidentDate5+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>나. 사고내용</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+insuContent+"</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>3. 손해사정 시 적용된 관계 법규 및 약관</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>가. 관련법규</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+lawSubject+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>나. 관련약관</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+lawEtc+"</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>4. 약관상 보험자 지급책임의 범위</td>" +
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>가. 지급책임</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+reparationLiability+"</td>" + 
				"	</tr>" +
				"	<tr>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>나. 책임범위</td>" + 
				"		<td height='30' style='text-align: left; padding-left: 10px;'>"+reparationLiabilityReasonEtc+"</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>5. 손해액 및 보험금 사정에 크게 영향을 미친 사항</td>" +
				"	</tr>" +
				"	<tr>" +
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;'>"+reparationLiabilityReason+"</td>" + 
				"	</tr>" +
				
				"	<tr>" + 
				"		<td height='30' colspan='2' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>6. 지급보험금</td>" +
				"	</tr>"; 
		if("1".equals(amtInsuPaymentDisable)) {
			sContent += "	<tr><td height='30' colspan='2' style='text-align: left; padding-left: 10px;'>단체 사고의 경우 개별 안내 금액에 따름</td></tr>";
		}else {
			sContent += "	<tr>" +
								"	<td height='30' colspan='2' style='text-align: left; padding-left: 10px;'>￦"+String.format("%,d",amtInsuPayment)+"</td>" + 
								"</tr>";
		}
		
		sContent += sCertiMemberText +
						"	<tr>" + 
						"		<td height='30' style='text-align: left; padding-left: 10px;' bgcolor='#EFF5FB'>대표이사</td>" + 
						"		<td height='30' style='text-align: left; padding-left: 10px;'>전태옥 (직인생략)</td>" + 
						"	</tr>" +
						"	<tr>" +
						"<td height='30' colspan='2' style='text-align: left; padding-left: 10px;'>" +
						"※ 본 손해사정서는 보험업법 제188조에 근거한 손해사정사의 의견으로 보험업법 제189조에 따라 발송하는 서식이며 보험사의 최종의사결과에 따라 달라질 수 있음을 양지해 주시기 바랍니다."+
						"</td></tr></table>";
		//이메일 내용 끝
		
		String sFromName = "탑손해사정";
		String sFromAddress = from_email;
		String sRet = "";
		
		Sendmail sendmail = new Sendmail();
		try {
			//알림메일 발송
			sRet = sendmail.send( sFromName, sFromAddress, sToAddress, sSubject, sContent, "", "" );								
			logger.info("Sendmail Issue Send : "+sToAddress +" : "+ suimAcceptNo);
		} catch (Exception e) {
			System.out.println("Sendmail Issue Send Error: "+e.getMessage());
			resultMap.put("RESULT_MSG", "Email Send Error :" + e.getMessage());
		}
		
		if( "Success".equals(sRet) ) {		//메일 발송 성공시 발송정보를 저장하고 갱신한다.
			//발송성공 시 발송상태값을 변경한다.
			paramMap.put("send_content", sContent);
			sqlSession.update("RptIssueMapper.updateRptIssueSendEmailOk",paramMap);			
			
			paramMap.put("email", sToAddress);
			//같은 이메일주소로 등록되어있는 경우 한건발송으로 다 처리된것으로 한다.
        	sqlSession.update("RptIssueMapper.updateRptIssueSendMagOkEmail",paramMap);
		}
        
        resultMap.put("RESULT_MSG", sRet);
        	
    	return resultMap;
    }
    
    @RequestMapping(value = "/report_Issue_send_msg")
    @ResponseBody
    public Map<String, Object> report_Issue_send_msg(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        Map<String, Object> resultMap = new HashMap<String,Object>();
                
        String responseMsg = sendKaKaoTalk(paramMap);        
    	
        JsonArray jsonArr = new JsonParser().parse(responseMsg).getAsJsonArray();
        JsonObject obj = (JsonObject) jsonArr.get(0);
        String code = obj.get("code").getAsString();
        String retMessage= obj.get("message").getAsString();
        JsonObject sData = (JsonObject)obj.get("data").getAsJsonObject();       
        
        //kakao 에서 받은 msgid 값을 저장한다.
        String sMsgid = sData.get("msgid").toString().replace("\"", "");
        
        //메시지 발송 상태값을 대기상태로 넣어준다.
        paramMap.put("send_state", 2);
        paramMap.put("msgid", sMsgid);        
                
        resultMap.put("RETURN_CODE", retMessage);
        
        if ("success".equals(code)){			//K(카카오),M(SMS)
        	//resultMap.put("RESULT_CODE", "0001");
        	//resultMap.put("RESULT_MSG", "카카오톡(문자) 발송에 성공 하였습니다..");
        	
        	if( retMessage.charAt(0) == 'K' ) {
        		resultMap.put("RESULT_MSG", "카카오톡 발송요청 하였습니다..");
        	}else if( retMessage.charAt(0) == 'M' ) {
        		resultMap.put("RESULT_MSG", "SMS 발송요청 하였습니다..");
        	}else {
        		resultMap.put("RESULT_MSG", "카카오톡(문자) 발송요청 하였습니다..");
        	}
        	
        	Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
    		String tel1 = String.valueOf(sendMap.get("tel1"));
    		String tel2 = String.valueOf(sendMap.get("tel2"));
    		String tel3 = String.valueOf(sendMap.get("tel3"));
    		String sContent = String.valueOf(sendMap.get("sendContent"));
    		
    		paramMap.put("tel1", tel1);
    		paramMap.put("tel2", tel2);
    		paramMap.put("tel3", tel3);    		
    		paramMap.put("send_content", sContent);
        	
        	//sqlSession.update("RptIssueMapper.updateRptIssueSendMagOk",paramMap);
    		
    		//같은 번호로 등록되어있는 경우 한건발송으로 다 처리된것으로 한다.
        	sqlSession.update("RptIssueMapper.updateRptIssueSendMagOkTel",paramMap);
        	
        }else{		//실패한 경우 분기        	
        	String dCode = retMessage.substring(0,1);
        	String dMessage = retMessage.substring(1,4);
        	//String dDesc = "";		//영문에러코드
        	String dErrinfo = "";		//국문에러설명
        	String dUflag = "";		//사용자에게 어떤 정보를 보여줄것인지 표시 (1: errinfo, 0:desc로 표시)
        	
        	//에러 코드를 bizm_error 테이블에서 가져온다.
        	paramMap.put("ecode", dCode);
        	paramMap.put("emessage", dMessage);
            Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            
            //dDesc = errorMsg.get("edesc").toString();
            dErrinfo = errorMsg.get("errinfo").toString();
            dUflag = errorMsg.get("uflag").toString();
            resultMap.put("RESULT_CHK", "fail");
            
            if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            	resultMap.put("RESULT_MSG", "카카오톡(문자) 발송에 실패 하였습니다.\n"+dErrinfo);
            }else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            	resultMap.put("RESULT_MSG", "카카오톡(문자) 발송에 실패 하였습니다.\nIT정보보호파트에 문의 바랍니다.\n"+retMessage);
            }
        }
        	
    	return resultMap;
    }
    
    /**
     * 메리츠 손해사정서 카카오톡 발송
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_Issue_send_meritz_msg")
    @ResponseBody
    public Map<String, Object> report_Issue_send_meritz_msg(HttpServletRequest request, Model model){
    	
    	logger.info("======== report_Issue_send_meritz_msg ========");

        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        Map<String, Object> resultMap = new HashMap<String,Object>();                

        String responseMsg = sendKaKaoTalkMeritz(paramMap);			//메리츠용 카카오톡발송
    	
        JsonArray jsonArr = new JsonParser().parse(responseMsg).getAsJsonArray();
        JsonObject obj = (JsonObject) jsonArr.get(0);
        String code = obj.get("code").getAsString();
        String retMessage= obj.get("message").getAsString();
        JsonObject sData = (JsonObject)obj.get("data").getAsJsonObject();       
        
        //kakao 에서 받은 msgid 값을 저장한다.
        String sMsgid = sData.get("msgid").toString().replace("\"", "");
        
        //메시지 발송 상태값을 대기상태로 넣어준다.
        paramMap.put("send_state", 2);
        paramMap.put("msgid", sMsgid);        
                
        resultMap.put("RETURN_CODE", retMessage);
        
        if ("success".equals(code)){			//K(카카오),M(SMS)
        	//resultMap.put("RESULT_CODE", "0001");
        	//resultMap.put("RESULT_MSG", "카카오톡(문자) 발송에 성공 하였습니다..");
        	
        	if( retMessage.charAt(0) == 'K' ) {
        		resultMap.put("RESULT_MSG", "카카오톡 발송요청 하였습니다..");
        	}else if( retMessage.charAt(0) == 'M' ) {
        		resultMap.put("RESULT_MSG", "SMS 발송요청 하였습니다..");
        	}else {
        		resultMap.put("RESULT_MSG", "카카오톡(문자) 발송요청 하였습니다..");
        	}
        	
        	Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
    		String tel1 = String.valueOf(sendMap.get("tel1"));
    		String tel2 = String.valueOf(sendMap.get("tel2"));
    		String tel3 = String.valueOf(sendMap.get("tel3"));
    		String sContent = String.valueOf(sendMap.get("sendContent"));
    		
    		paramMap.put("tel1", tel1);
    		paramMap.put("tel2", tel2);
    		paramMap.put("tel3", tel3);    		
    		paramMap.put("send_content", sContent);
        	
        	//sqlSession.update("RptIssueMapper.updateRptIssueSendMagOk",paramMap);
    		
    		//같은 번호로 등록되어있는 경우 한건발송으로 다 처리된것으로 한다.
        	sqlSession.update("RptIssueMapper.updateRptIssueSendMagOkTel",paramMap);
        	
        }else{		//실패한 경우 분기        	
        	String dCode = retMessage.substring(0,1);
        	String dMessage = retMessage.substring(1,4);
        	//String dDesc = "";		//영문에러코드
        	String dErrinfo = "";		//국문에러설명
        	String dUflag = "";		//사용자에게 어떤 정보를 보여줄것인지 표시 (1: errinfo, 0:desc로 표시)
        	
        	//에러 코드를 bizm_error 테이블에서 가져온다.
        	paramMap.put("ecode", dCode);
        	paramMap.put("emessage", dMessage);
            Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            
            //dDesc = errorMsg.get("edesc").toString();
            dErrinfo = errorMsg.get("errinfo").toString();
            dUflag = errorMsg.get("uflag").toString();
            resultMap.put("RESULT_CHK", "fail");
            
            if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            	resultMap.put("RESULT_MSG", "카카오톡(문자) 발송에 실패 하였습니다.\n"+dErrinfo);
            }else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            	resultMap.put("RESULT_MSG", "카카오톡(문자) 발송에 실패 하였습니다.\nIT정보보호파트에 문의 바랍니다.\n"+retMessage);
            }
        }
        	
    	return resultMap;
    }
    
    /**
     * 손해사정서 네이버 클라우드 서버를 이용한 첨부파일 링크방식 카카오톡 발송(신규) 
     * @param request
     * @param model
     * @return
     */
    @Autowired
    private S3Service s3Service;			//Naver Cloud Object Storage (S3 호환) 서비스
    
    @Autowired
    private BitlyShortUrlService bitlyService;		//bitlyShortUrl 서비스
    
    @RequestMapping(value = "/report_Issue_send_new_attach")
    @ResponseBody
    public Map<String, Object> report_Issue_send_new_attach(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        Map<String, Object> resultMap = new HashMap<String,Object>();
        
        //CommonUtils.printMap(paramMap);
        //발송정보를 가져온다.
        Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForAttach",paramMap);
        
        String filePath = String.valueOf(sendMap.get("filePath"));        
        String sOrgFileName = String.valueOf(sendMap.get("orgFileName"));
        String sEncFileName = String.valueOf(sendMap.get("encFileName"));        
        
        String sFolderName = filePath.replace("/home/hosting_users/toplac/www/", "");		//폴더의 서버경로 제거
        //String sFullFilePath = filePath+File.separator+sEncFileName;
        String sFullFilePath = filePath+sEncFileName;
        
        try {
        	//서버내 파일을 네이버 Object Storage 에 업로드 한다.
            //업로드할 폴더 생성
        	s3Service.createFolder(sFolderName);
        	//파일을 업로드하고 다운로드 URL을 받는다.
        	String sLongUrl = s3Service.uploadFileAndGetUrl(sFolderName, sFullFilePath, 1440 * 6); // 6일 (안내문구에는 발송일로부터 5일로 안내)
        	//생성된 긴 URL을 짧은 URL로 바꾼다. (제거)
        	String sShortUrl = bitlyService.shortenUrl(sLongUrl);
        	
        	//System.out.println("sLongUrl : "+sLongUrl);
        	//System.out.println("sShortUrl : "+sShortUrl);
        	
        	//생성된 longUrl, ShortUrl을 DB에 갱신한다.
        	paramMap.put("send_content", sLongUrl);			//send_content 에 longUrl을 저장(발송시에는 사용하지 않는다.)
        	paramMap.put("short_url", sShortUrl);				//발송시 사용될 보고서 링크 url
        	
        	sqlSession.update("RptIssueMapper.updateTopRptIssueSendByShortUrl", paramMap);
        	
        	//생성된 ShortUrl을 가지고 카카오톡을 발송시작
        	String responseMsg = sendKaKaoTalkAttach(paramMap);
        	
        	JsonArray jsonArr = new JsonParser().parse(responseMsg).getAsJsonArray();
            JsonObject obj = (JsonObject) jsonArr.get(0);
            String code = obj.get("code").getAsString();
            String retMessage= obj.get("message").getAsString();
            JsonObject sData = (JsonObject)obj.get("data").getAsJsonObject();       
            
            //kakao 에서 받은 msgid 값을 저장한다.
            String sMsgid = sData.get("msgid").toString().replace("\"", "");
            
            //메시지 발송 상태값을 대기상태로 넣어준다.
            paramMap.put("send_state", 2);
            paramMap.put("msgid", sMsgid);        
                    
            resultMap.put("RETURN_CODE", retMessage);
        	
            if ("success".equals(code)){			//K(카카오),M(SMS)
            	//resultMap.put("RESULT_CODE", "0001");
            	//resultMap.put("RESULT_MSG", "카카오톡(문자) 발송에 성공 하였습니다..");
            	
            	if( retMessage.charAt(0) == 'K' ) {
            		//resultMap.put("RESULT_MSG", "카카오톡 발송요청 하였습니다.");
            		resultMap.put("RESULT_MSG", "손해사정서 교부 요청하였습니다.");
            	}else if( retMessage.charAt(0) == 'M' ) {
            		//resultMap.put("RESULT_MSG", "SMS 발송요청 하였습니다.");
            		resultMap.put("RESULT_MSG", "손해사정서 교부 요청하였습니다.");
            	}else {
            		//resultMap.put("RESULT_MSG", "카카오톡(문자) 발송요청 하였습니다.");
            		resultMap.put("RESULT_MSG", "손해사정서 교부 요청하였습니다.");
            	}
            	
            	//Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
        		String tel1 = String.valueOf(sendMap.get("tel1"));
        		String tel2 = String.valueOf(sendMap.get("tel2"));
        		String tel3 = String.valueOf(sendMap.get("tel3"));        		
        		
        		paramMap.put("tel1", tel1);
        		paramMap.put("tel2", tel2);
        		paramMap.put("tel3", tel3);
        		
        		//같은 번호로 등록되어있는 경우 한건발송으로 다 처리된것으로 한다.
            	sqlSession.update("RptIssueMapper.updateRptIssueSendMagOkTelAttach",paramMap);
            	
            }else{		//실패한 경우 분기        	
            	String dCode = retMessage.substring(0,1);
            	String dMessage = retMessage.substring(1,4);
            	//String dDesc = "";		//영문에러코드
            	String dErrinfo = "";		//국문에러설명
            	String dUflag = "";		//사용자에게 어떤 정보를 보여줄것인지 표시 (1: errinfo, 0:desc로 표시)
            	
            	//에러 코드를 bizm_error 테이블에서 가져온다.
            	paramMap.put("ecode", dCode);
            	paramMap.put("emessage", dMessage);
                Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
                
                //dDesc = errorMsg.get("edesc").toString();
                dErrinfo = errorMsg.get("errinfo").toString();
                dUflag = errorMsg.get("uflag").toString();
                resultMap.put("RESULT_CHK", "fail");
                
                if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
                	resultMap.put("RESULT_MSG", "카카오톡(문자) 발송에 실패 하였습니다.\n"+dErrinfo);
                }else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
                	resultMap.put("RESULT_MSG", "카카오톡(문자) 발송에 실패 하였습니다.\nIT정보보호파트에 문의 바랍니다.\n"+retMessage);
                }
            }            
            //생성된 ShortUrl을 가지고 카카오톡을 발송 끝
            
		} catch (Exception e) {
			resultMap.put("RESULT_MSG", "에러발생 : "+e+"\nIT정보보호파트로 문의바랍니다.");
		}
        
        //resultMap.put("RESULT_MSG", "현재 작업중입니다..");
        
    	return resultMap;
    }
    
    /**
     * 첨부파일 링크를 이용한 카카오톡 발송 (shortUrl)
     * @param paramMap
     * @return
     */
    public String sendKaKaoTalkAttach(Map<String,Object> paramMap){
		
		logger.info("======== sendKaKaoTalkAttach ========");
		
        //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);
        //Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
		String suimAcceptNo 				= String.valueOf(rptIssueMain.get("suimAcceptNo"));
		String accidentNo 					= String.valueOf(rptIssueMain.get("accidentNo"));
		String ptnrName 					= String.valueOf(rptIssueMain.get("ptnrName"));		
		String sShortUrl = String.valueOf(paramMap.get("short_url"));
		String sLongUrl = String.valueOf(paramMap.get("send_content"));
		
		String tmplId = "";

		//tmplId = "toplac20";
		//tmplId = "toplac_mobile";			//신규 코드
		//tmplId = "toplac_mobile_link_button_01";			//개발템플릿
		//tmplId = "toplac_mobile_link_button";			//운영템플릿
		//tmplId = "toplac_mobile_link_button_real";			//운영템플릿 수정1
		tmplId = "toplac_report_defalut";			//운영템플릿 toplac_report		
		
		String msg = "[접수번호 : "+suimAcceptNo+"] 손해사정서 교부 ("+ptnrName+")\n";
		msg += "\n";
		msg += "보험금 청구 건에 대하여 보험업법 및 기타 법령에 의거하여 손해사정을 완료하고 그 결과를 손해사정서로 작성하여 별첨과 같이 교부합니다.\n";
		msg += "\n";
		msg += "<별첨 손해사정서 파일 암호 안내>\n";
		msg += "\n";
		msg += "1. 개인 : 주민등록번호 앞 6자리\n";
		msg += "\n";
		msg += "2. 사업자 : 사업자등록번호 10자리\n";
		msg += "\n";
		msg += "별첨파일(클릭) : "+sShortUrl+"\n";
		msg += "\n";
		msg += "※ 이 파일은 수신일로부터 5일간 다운로드 가능합니다.\n";
		msg += "\n";
		msg += "※ 본 손해사정 내용은 현재까지 발생 또는 확인된 사실 및 근거자료(입증자료, 진술서 등)에 근거한 것입니다.\n";
		msg += "향후 이와 다른 사실이 확인되거나 기타 사정변경이 발생하는 등 손해사정 당시 예기치 못한 사항과\n";
		msg += "관련하여서는 이 손해사정 결과를 유보합니다.\n";

		//System.out.println(msg);
		
		//카카오(문자)발송한 내역을 DB에 저장한다.		
		//paramMap.put("send_content", msg);
		
		//sqlSession.update("RptIssueMapper.updateRptIssueSendContent",paramMap);
		
		Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
		String tel1 = String.valueOf(sendMap.get("tel1"));
		String tel2 = String.valueOf(sendMap.get("tel2"));
		String tel3 = String.valueOf(sendMap.get("tel3"));
		String phn = "82"+tel1.substring(1)+tel2+tel3;
		
		RestTemplate restTemplate = new RestTemplate();
		// RestTemplate 에 MessageConverter 세팅
	    List<HttpMessageConverter<?>> converters = new ArrayList<HttpMessageConverter<?>>();
	    converters.add(new FormHttpMessageConverter());
	    converters.add(new StringHttpMessageConverter(Charset.forName("UTF-8")));
		
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.add("Accept", "application/json");
		httpHeaders.add("Content-type", "application/json");
		httpHeaders.add("userid", "toplac"); 	//손해사정서 발송용 계정(userId > userid) 변경
		
//		String msg = "[카카오뮤직] 회원가입 안내\n일이삼사오육칠팔구십님, 카카오뮤직 회원이 되신 것을 환영합니다.\n\n▶신규 가입 회원 혜택\n1개월 무료 스트리밍 서비스 제공\n카카오톡 이모티콘 증정";
		
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		obj.put("message_type", "at");
		obj.put("phn", phn);
		//obj.put("profile", "22e9cd927d652e02daca5dc631170e021f02ae51");	//기존 toplac
		obj.put("profile", "2c2f288c7a4766ec6551e2fd721e59beca19206f");	//손해사정서 발송용 toplac_report
		obj.put("tmplId", tmplId);
		obj.put("msg", msg);

		obj.put("smsKind", "L");
		obj.put("msgSms", msg);
		obj.put("smsSender", "0260774600");

		obj.put("smsLmsTit", "탑손해사정주식회사");
		obj.put("reserveDt", "00000000000000");

		//메시지 길이가 930자 이상인경우 SMS 로 전환하여 발송
		int msgLength = msg.length();
		if( msgLength > 930 ) {
			obj.put("smsOnly", "Y");
		}
		
		//손해사정서 버튼추가 시작
		JSONObject buttons = new JSONObject();

		JSONObject button1 = new JSONObject();
		button1.put("name", "손해사정서 조회하기");
		button1.put("type", "WL");
		button1.put("url_mobile", sLongUrl);
		button1.put("url_pc", sLongUrl);

		// 버튼을 obj에 직접 추가
		obj.put("button1", button1);
		//button.put("url_mobile", sShortUrl);			// 모바일에서 열릴 URL
		//button.put("url_pc", sShortUrl);					// PC에서 열릴 URL (선택사항, 동일 URL)		
		//손해사정서 버튼추가 끝
		
		arr.add(obj);
		
		HttpEntity entity = new HttpEntity(arr, httpHeaders);
		
		//System.out.println(tmplId);
		
//		URI uri = UriComponentsBuilder.fromHttpUrl("https://dev-alimtalk-api.bizmsg.kr:1443/v2/sender/send")
//				.build().toUri();	//테스트
		URI uri = UriComponentsBuilder.fromHttpUrl("https://alimtalk-api.bizmsg.kr/v2/sender/send")
				.build().toUri();
				
		
		String responseEntity = restTemplate.postForObject(uri, entity, String.class);
		logger.info(responseEntity);
		
		return responseEntity;
	}
    
    /**
     * 일반 손해사정서 (신규) 카카오톡 발송
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/report_Issue_send_new_msg")
    @ResponseBody
    public Map<String, Object> report_Issue_send_new_msg(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        Map<String, Object> resultMap = new HashMap<String,Object>();
                
        String responseMsg = sendKaKaoTalkNew(paramMap);        
    	
        JsonArray jsonArr = new JsonParser().parse(responseMsg).getAsJsonArray();
        JsonObject obj = (JsonObject) jsonArr.get(0);
        String code = obj.get("code").getAsString();
        String retMessage= obj.get("message").getAsString();
        JsonObject sData = (JsonObject)obj.get("data").getAsJsonObject();       
        
        //kakao 에서 받은 msgid 값을 저장한다.
        String sMsgid = sData.get("msgid").toString().replace("\"", "");
        
        //메시지 발송 상태값을 대기상태로 넣어준다.
        paramMap.put("send_state", 2);
        paramMap.put("msgid", sMsgid);        
                
        resultMap.put("RETURN_CODE", retMessage);
        
        if ("success".equals(code)){			//K(카카오),M(SMS)
        	//resultMap.put("RESULT_CODE", "0001");
        	//resultMap.put("RESULT_MSG", "카카오톡(문자) 발송에 성공 하였습니다..");
        	
        	if( retMessage.charAt(0) == 'K' ) {
        		resultMap.put("RESULT_MSG", "카카오톡 발송요청 하였습니다..");
        	}else if( retMessage.charAt(0) == 'M' ) {
        		resultMap.put("RESULT_MSG", "SMS 발송요청 하였습니다..");
        	}else {
        		resultMap.put("RESULT_MSG", "카카오톡(문자) 발송요청 하였습니다..");
        	}
        	
        	Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
    		String tel1 = String.valueOf(sendMap.get("tel1"));
    		String tel2 = String.valueOf(sendMap.get("tel2"));
    		String tel3 = String.valueOf(sendMap.get("tel3"));
    		String sContent = String.valueOf(sendMap.get("sendContent"));
    		
    		paramMap.put("tel1", tel1);
    		paramMap.put("tel2", tel2);
    		paramMap.put("tel3", tel3);    		
    		paramMap.put("send_content", sContent);
        	
        	//sqlSession.update("RptIssueMapper.updateRptIssueSendMagOk",paramMap);
    		
    		//같은 번호로 등록되어있는 경우 한건발송으로 다 처리된것으로 한다.
        	sqlSession.update("RptIssueMapper.updateRptIssueSendMagOkTel",paramMap);
        	
        }else{		//실패한 경우 분기        	
        	String dCode = retMessage.substring(0,1);
        	String dMessage = retMessage.substring(1,4);
        	//String dDesc = "";		//영문에러코드
        	String dErrinfo = "";		//국문에러설명
        	String dUflag = "";		//사용자에게 어떤 정보를 보여줄것인지 표시 (1: errinfo, 0:desc로 표시)
        	
        	//에러 코드를 bizm_error 테이블에서 가져온다.
        	paramMap.put("ecode", dCode);
        	paramMap.put("emessage", dMessage);
            Map<String, Object> errorMsg = sqlSession.selectOne("RptIssueMapper.selectBizmError", paramMap);
            
            //dDesc = errorMsg.get("edesc").toString();
            dErrinfo = errorMsg.get("errinfo").toString();
            dUflag = errorMsg.get("uflag").toString();
            resultMap.put("RESULT_CHK", "fail");
            
            if( dUflag.equals("1") ){		//사용자가 확인이 가능한 에러문구
            	resultMap.put("RESULT_MSG", "카카오톡(문자) 발송에 실패 하였습니다.\n"+dErrinfo);
            }else {            					//사용자가 이해할수 없는 경우 에러와 영문코드를 보여준다.
            	resultMap.put("RESULT_MSG", "카카오톡(문자) 발송에 실패 하였습니다.\nIT정보보호파트에 문의 바랍니다.\n"+retMessage);
            }
        }
        	
    	return resultMap;
    }
    
    public String sendLotteKaKaoTalk(Map<String,Object> paramMap){				//롯데발송용
    	
    	logger.info("======== sendLotteKaKaoTalk ========");
		
        //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        //계약자 정보가져오기
        SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);
        
        //보험목적물 계약정보 가져오기
        List<Map<String, Object>> rptIssueContList = sqlSession.selectList("RptIssueMapper.selectRptIssueContLotte", paramMap);
        
        //총괄표 정보 가져오기
        List<Map<String, Object>> rptIssueSummaryList = sqlSession.selectList("RptIssueMapper.selectRptIssueSummaryLotte", paramMap);
        
        String sCtypeName = "";
        
        String sCtype = paramMap.get("ctype").toString();		//보험타입 (C:재물보험, B:배상보험, T:여행자보험)
        if( sCtype.equals("C") ) {
        	sCtypeName = "보험목적물";
        }else {
        	sCtypeName = "계약약관";
        }
        
        //세부계약사항 메시지 만들기
        String sContContent = ""; 
        if( rptIssueContList.size() > 0 ) {
        	for(int i=0; i < rptIssueContList.size(); i++) {
        		Map<String, Object>map = rptIssueContList.get(i);
        		sContContent += map.get("contCate").toString()+" : "+map.get("contContent").toString()+"\n";
        	}
        }else {
        	sContContent = "내용없음\n";
        }
        
        //총괄표 세부사항 메시지 만들기
        String sSummaryContent = "";
        
        //합계계산하기
        long sum_joinPrice = 0;
        long sum_insuPrice = 0;
        long sum_lossPrice = 0;
        long sum_remainPrice = 0;
        long sum_responPrice = 0;        
        long sum_compLimitPrice = 0;
        long sum_compResponPrice = 0;      
        long sum_selfOptPrice = 0;
        long sum_netLossPrice = 0;
        long sum_lossCompPrice = 0;
        long sum_billPrice = 0;
        long sum_payPrice = 0;

        //합계 계산 로직 추가 by top3009        
        for( int i=0; i < rptIssueSummaryList.size(); i++ ) {
        	sum_joinPrice += Long.parseLong(rptIssueSummaryList.get(i).get("joinPrice").toString());
        	sum_insuPrice += Long.parseLong(rptIssueSummaryList.get(i).get("insuPrice").toString());
        	sum_lossPrice += Long.parseLong(rptIssueSummaryList.get(i).get("lossPrice").toString());
        	sum_remainPrice += Long.parseLong(rptIssueSummaryList.get(i).get("remainPrice").toString());
        	sum_responPrice += Long.parseLong(rptIssueSummaryList.get(i).get("responPrice").toString());
        	sum_netLossPrice += Long.parseLong(rptIssueSummaryList.get(i).get("netLossPrice").toString());		//삼성추가        	
        	sum_compLimitPrice += Long.parseLong(rptIssueSummaryList.get(i).get("compLimitPrice").toString());
        	sum_compResponPrice += Long.parseLong(rptIssueSummaryList.get(i).get("compResponPrice").toString());
        	sum_selfOptPrice += Long.parseLong(rptIssueSummaryList.get(i).get("selfOptPrice").toString());
        	sum_lossCompPrice += Long.parseLong(rptIssueSummaryList.get(i).get("lossCompPrice").toString());		//삼성추가
        	sum_billPrice += Long.parseLong(rptIssueSummaryList.get(i).get("billPrice").toString());		//삼성추가
        	sum_payPrice += Long.parseLong(rptIssueSummaryList.get(i).get("payPrice").toString());		//삼성추가        	
        }
        
        if( sCtype.equals("C") ) {
        	if( rptIssueSummaryList.size() > 0 ) {
            	for(int k=0; k < rptIssueSummaryList.size(); k++) {
            		Map<String, Object>smap = rptIssueSummaryList.get(k);
    				sSummaryContent += "목적물(" + smap.get("summaryCate").toString() + ") : 가입금액("
    						+ StringUtil.toMoneyString(smap.get("joinPrice").toString()) + ") 보험가액(" + StringUtil.toMoneyString(smap.get("insuPrice").toString()) + ") 손해액("
    						+ StringUtil.toMoneyString(smap.get("lossPrice").toString()) + ") 잔존물("+ StringUtil.toMoneyString(smap.get("remainPrice").toString()) +") 약관상지급책임액("+ StringUtil.toMoneyString(smap.get("responPrice").toString()) +"),\n";
            	}
            }else {
            	sSummaryContent = "내용없음\n";
            }
        	sSummaryContent += "합계 : 가입금액("+StringUtil.toMoneyString(sum_joinPrice)+") 보험가액("+StringUtil.toMoneyString(sum_insuPrice)+") 손해액("+StringUtil.toMoneyString(sum_lossPrice)+") 잔존물("+StringUtil.toMoneyString(sum_remainPrice)+") 약관상지급책임액("+StringUtil.toMoneyString(sum_responPrice)+")\n";
        	sSummaryContent += "자기부담금 : "+StringUtil.toMoneyString(rptIssueMain.get("amtSelfPay").toString())+"\n";
        	//비고 null 처리
        	if( rptIssue.get("remarkVal") != null ) {
        		sSummaryContent += "비고 : "+rptIssue.get("remarkVal")+"\n";
        	}else {
        		sSummaryContent += "비고 : -";
        	}        	
        	
        }else if( sCtype.equals("B") ) {
        	if( rptIssueSummaryList.size() > 0 ) {
            	for(int k=0; k < rptIssueSummaryList.size(); k++) {
            		Map<String, Object>smap = rptIssueSummaryList.get(k);
    				sSummaryContent += "목적물(" + smap.get("summaryCate").toString() + ") : 보상한도액("
    						+ StringUtil.toMoneyString(smap.get("compLimitPrice").toString()) + ") 배상책임액(" + StringUtil.toMoneyString(smap.get("compResponPrice").toString()) + ") 자기부담금("
    						+ StringUtil.toMoneyString(smap.get("selfOptPrice").toString()) + ") 약관상지급책임액("+ StringUtil.toMoneyString(smap.get("responPrice").toString()) +"),\n";
            	}
            }else {
            	sSummaryContent = "내용없음\n";
            }
        	sSummaryContent += "합계 : 보상한도액("+StringUtil.toMoneyString(sum_compLimitPrice)+") 배상책입액("+StringUtil.toMoneyString(sum_compResponPrice)+") 자기부담금("+StringUtil.toMoneyString(sum_selfOptPrice)+") 약관상지급책임액("+StringUtil.toMoneyString(sum_responPrice)+")\n";        
        	//비고 null 처리
        	if( rptIssue.get("remarkVal") != null ) {
        		sSummaryContent += "비고 : "+rptIssue.get("remarkVal")+"\n";
        	}else {
        		sSummaryContent += "비고 : -";
        	}
        }else if( sCtype.equals("T") ){
        	if( rptIssueSummaryList.size() > 0 ) {
            	for(int k=0; k < rptIssueSummaryList.size(); k++) {
            		Map<String, Object>smap = rptIssueSummaryList.get(k);
    				sSummaryContent += "목적물(" + smap.get("summaryCate").toString() + ") : 가입금액("
    						+ StringUtil.toMoneyString(smap.get("joinPrice").toString()) + ") 보험가액(" + StringUtil.toMoneyString(smap.get("insuPrice").toString()) + ") 손해액("
    						+ StringUtil.toMoneyString(smap.get("lossPrice").toString()) + ") 자기부담금("+ StringUtil.toMoneyString(smap.get("selfOptPrice").toString()) +") 약관상지급책임액("+ StringUtil.toMoneyString(smap.get("responPrice").toString()) +"),\n";
            	}
            }else {
            	sSummaryContent = "내용없음\n";
            }
        	sSummaryContent += "합계 : 가입금액("+StringUtil.toMoneyString(sum_joinPrice)+") 보험가액("+StringUtil.toMoneyString(sum_insuPrice)+") 손해액("+StringUtil.toMoneyString(sum_lossPrice)+") 자기부담금("+StringUtil.toMoneyString(sum_selfOptPrice)+") 약관상지급책임액("+StringUtil.toMoneyString(sum_responPrice)+")\n";      
        	//비고 null 처리
        	if( rptIssue.get("remarkVal") != null ) {
        		sSummaryContent += "비고 : "+rptIssue.get("remarkVal")+"\n";
        	}else {
        		sSummaryContent += "비고 : -";
        	}
        }else {
        	sSummaryContent = "내용없음\n";
        }

        //조사자 정보
        paramMap.put("user_no", rptIssueMain.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
		
		String suimAcceptNo 				= String.valueOf(rptIssueMain.get("suimAcceptNo"));
		String accidentNo 					= String.valueOf(rptIssueMain.get("accidentNo"));
		
		String insuranceNm 					= String.valueOf(rptIssueMain.get("insuranceNm"));
		String insuTerm 					= String.valueOf(rptIssueMain.get("insuTerm"));
		//자기부담금 단위, 자기부담금액
		String amtSelfPayUnit 				= String.valueOf(rptIssueMain.get("amtSelfPayUnit"));
		//int amtSelfPay 						= Integer.parseInt(String.valueOf(rptIssueMain.get("amtSelfPay")));				
		long amtSelfPay 						= Long.parseLong(String.valueOf(rptIssueMain.get("amtSelfPay")));
		String accidentDate5 				= String.valueOf(rptIssueMain.get("accidentDate5"));
		
		String insuContent 			        = String.valueOf(rptIssue.get("insuContent"));		
		//int amtInsuPayment 					= Integer.parseInt(String.valueOf(rptIssueMain.get("amtInsuPayment")));		
		long amtInsuPayment 					= Long.parseLong(String.valueOf(rptIssueMain.get("amtInsuPayment")));
		
		String userName 					= String.valueOf(reportInvgUser.get("userName"));
		String disWorkLevel 				= String.valueOf(reportInvgUser.get("disWorkLevel"));
		String handphone 					= String.valueOf(reportInvgUser.get("handphone"));
		
		//롯데 메시지 입력부
		
		//증권번호
		String sPolicyNo = String.valueOf(rptIssueMain.get("policyNo"));
		
		//소재지
		String sSuimAddress = String.valueOf(rptIssue.get("suimAddress")).replace("null", "");
		
		//전송시 계약자 피보험자 이름 두번째 글자 '*' 처리        
		String sHiddenPolicyNm = suimVo.getPolicyholder_nm().toString();
		String sHiddenBenefitNm = suimVo.getBeneficiary_nm().toString();

		if( !sHiddenPolicyNm.equals("") ) {        	
			if( sHiddenPolicyNm.length() == 1 ) {
				sHiddenPolicyNm = "*";
			}else {
				sHiddenPolicyNm = sHiddenPolicyNm.replace(sHiddenPolicyNm.charAt(1),'*');
			}        	        	
		}else {
			sHiddenPolicyNm = "";
		}

		if( !sHiddenBenefitNm.equals("") ) {
			if( sHiddenBenefitNm.length() == 1 ) {
				sHiddenBenefitNm = "*";
			}else {
				sHiddenBenefitNm = sHiddenBenefitNm.replace(sHiddenBenefitNm.charAt(1),'*');
			}        	
		}else {
			sHiddenBenefitNm = "";
		}
		
		//사고장소 
		//String investigate_addr1 = suimVo.getInvestigate_addr1().toString();		
		String investigate_addr1 = String.valueOf(suimVo.getInvestigate_addr1());		//null 처리
		//String investigate_addr2 = suimVo.getInvestigate_addr2().toString();
		String sAccPlace = "";
		
		if( !investigate_addr1.equals("") ) {
			sAccPlace = investigate_addr1; 
		}else{
			sAccPlace = "사고장소정보 미노출";
		}

		String tmplId = "";		
			tmplId = "toplac151";			//발송 템플릿 변경으로 인한 수정 by top3009 (2023-05-17)
			//tmplId = "toplac15";
			//tmplId = "toplac09";
		
		//직급이 수습인 경우 외부발송시 사원으로 변경
		String SendDisWorkLevel = "";
		if("수습".equals(disWorkLevel)) {
			SendDisWorkLevel = "사원";
		}else{
			SendDisWorkLevel = disWorkLevel;
		}
		
		//손해사정서 양식 변경에 따라 항목 추가 시작 (2023-05-17)
		//담당자 자격증(손해사정사) 정보 List 만들기 시작		
		String sUserNo = String.valueOf(rptIssueMain.get("userNo"));		
		List<Map<String, Object>> certiReportUser = null;					//보고서 하단에 들어갈 담당자 정보 List
		List<Map<String, Object>> certiManagerReportUser = null;		//담당손해사정사 목록

		//기 종결건은 담당손해사정사가 별도 저장되어있음 (top_rpt_certi_end) 저장된 손해사정사 정보가 별도로 있는지 체크
		int nEndCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiEndCnt",paramMap);
		
		if( nEndCnt == 0 ) {			//정보가 없는 경우 실시간으로 가져온다.
			
			if( !"0".equals(sUserNo) ) {		//0은 미배당건        	
			certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiMemberInfo", paramMap);
			
			int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
			
			nCertiManagerCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiManagerCnt", paramMap);
			
			if( nCertiManagerCnt > 0 ) {			//담당손해사정사가 있는 경우
				certiManagerReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiManagerList", paramMap);
				for( int i=0; i < certiManagerReportUser.size(); i++) {
					certiReportUser.add(certiManagerReportUser.get(i));		//보고서 하단에 들어갈 담당자 정보에 담당손해사정서를 추가한다.
				}
			}
		    }
			
		}else{								//정보가 있는 경우 top_rpt_certi_end 테이블에서 불러온다.
			certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiEndInfo", paramMap);
		}

		String sCertiMemberText = "";

		if( certiReportUser == null ) {			//미배상건
			sCertiMemberText = "미배당건으로 담당자 정보가 없습니다.";
		}else{
			for( int i=0; i < certiReportUser.size(); i++) {
				sCertiMemberText += String.valueOf(certiReportUser.get(i).get("certi_state_val"))+" : "+String.valueOf(certiReportUser.get(i).get("user_name"))+" (직인생략)\n"+
					"(연락처 : "+String.valueOf(certiReportUser.get(i).get("work_phone"))+")\n"+"등록번호 : " +String.valueOf(certiReportUser.get(i).get("certi_number"))+"\n\n";
			}
		}
		//담당자 자격증(손해사정사) 정보 List 만들기 끝
		//손해사정서 양식 변경에 따라 항목 추가 끝		
			
		String msg = "보험업법 제189조 소정의 규정에 의거하여 아래와 같이 손해사정서를 안내합니다.\n";
		msg += "\n";
		msg += "Report No. : "+suimAcceptNo+"\n";
		msg += "\n";
		msg += "손해사정[사고번호 : "+accidentNo+"]\n";
		msg += "\n";
		msg += "1. 계약사항\n";
		msg += "가. 보험종목 / 증권번호 : "+insuranceNm+" / "+sPolicyNo+"\n";
		msg += "나. 계약자 / 피보험자 : "+sHiddenPolicyNm+" / "+sHiddenBenefitNm+"\n";
		msg += "다. 소재지 : "+sSuimAddress+"\n";
		msg += "라. 보험기간 : "+insuTerm+"\n";
		msg += "마. "+sCtypeName+"\n";
		msg += sContContent+"\n";
		
		msg += "2. 사고사항\n";
		msg += "가. 사고일자 : "+accidentDate5+"\n";
		msg += "나. 사고장소 : "+sAccPlace+"\n";
		msg += "다. 사고내용 : "+insuContent+"\n";
		msg += "\n";		

		msg += "3. 총괄표 (단위:원)\n";	
		msg += sSummaryContent+"\n";
		msg += "※ 상기와 같이 손해액이 산정되었음을 안내드리며, 보험회사의 검토과정상 일부 금액의 변동이 있을 수 있습니다.\n";
		msg += "\n";
		msg += sCertiMemberText;
		//msg += "담당자 : "+SendDisWorkLevel+" "+userName+"  (연락처 : "+handphone+")\n";			
		//msg += "대표손해사정사 : 윤경수(직인생략)\n";
		msg += "\n";
		msg += "탑손해사정주식회사\n";		
		//msg += "대표이사 사장 전태옥(직인생략)\n";
		msg += "대표이사 전태옥(직인생략)\n";	
		
		//카카오(문자)발송한 내역을 DB에 저장한다.		
		paramMap.put("send_content", msg);
		
		sqlSession.update("RptIssueMapper.updateRptIssueSendContent",paramMap); 
		
		Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
		String tel1 = String.valueOf(sendMap.get("tel1"));
		String tel2 = String.valueOf(sendMap.get("tel2"));
		String tel3 = String.valueOf(sendMap.get("tel3"));
		String phn = "82"+tel1.substring(1)+tel2+tel3;
		
		RestTemplate restTemplate = new RestTemplate();
		// RestTemplate 에 MessageConverter 세팅
	    List<HttpMessageConverter<?>> converters = new ArrayList<HttpMessageConverter<?>>();
	    converters.add(new FormHttpMessageConverter());
	    converters.add(new StringHttpMessageConverter(Charset.forName("UTF-8")));
		
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.add("Accept", "application/json");
		httpHeaders.add("Content-type", "application/json");
		httpHeaders.add("userId", "toplac"); //실제
		
		
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		obj.put("message_type", "at");
		obj.put("phn", phn);
		obj.put("profile", "22e9cd927d652e02daca5dc631170e021f02ae51");	//실제
		obj.put("tmplId", tmplId);
		obj.put("msg", msg);

		obj.put("smsKind", "L");
		obj.put("msgSms", msg);
		obj.put("smsSender", "0260774600");

		obj.put("smsLmsTit", "탑손해사정주식회사");
		obj.put("reserveDt", "00000000000000");
		
		//메시지 길이가 930자 이상인경우 SMS 로 전환하여 발송
		int msgLength = msg.length();
		if( msgLength > 930 ) {
			obj.put("smsOnly", "Y");
		}
		
		arr.add(obj);
		
		HttpEntity entity = new HttpEntity(arr, httpHeaders);
		
		System.out.println(tmplId);
		
		URI uri = UriComponentsBuilder.fromHttpUrl("https://alimtalk-api.bizmsg.kr/v2/sender/send")
				.build().toUri();
				
		
		String responseEntity = restTemplate.postForObject(uri, entity, String.class);
		logger.info(responseEntity);
		
		return responseEntity;
	}
    
    public String sendHeungkukKaKaoTalk(Map<String,Object> paramMap){				//흥국생명 발송용
		
    	logger.info("======== sendHeungkukKaKaoTalk ========");
    	
        //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        //계약자 정보가져오기
        SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);
        
        //보험목적물 계약정보 가져오기
        List<Map<String, Object>> rptIssueContList = sqlSession.selectList("RptIssueMapper.selectRptIssueContLotte", paramMap);
        
        //총괄표 정보 가져오기
        List<Map<String, Object>> rptIssueSummaryList = sqlSession.selectList("RptIssueMapper.selectRptIssueSummaryLotte", paramMap);
        
        String sCtypeName = "";
        
        String sCtype = paramMap.get("ctype").toString();		//보험타입 (C:재물보험, B:배상보험, I:인보험)
        if( sCtype.equals("C") ) {
        	sCtypeName = "보험목적물";
        }else {
        	sCtypeName = "계약약관";
        }
        
        //조사자 정보
        paramMap.put("user_no", rptIssueMain.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
		
		String suimAcceptNo 				= String.valueOf(rptIssueMain.get("suimAcceptNo"));
		String accidentNo 					= String.valueOf(rptIssueMain.get("accidentNo"));
		
		String insuranceNm 					= String.valueOf(rptIssueMain.get("insuranceNm"));
		String insuTerm 					= String.valueOf(rptIssueMain.get("insuTerm"));
		//자기부담금 단위, 자기부담금액
		String amtSelfPayUnit 				= String.valueOf(rptIssueMain.get("amtSelfPayUnit"));
		//int amtSelfPay 						= Integer.parseInt(String.valueOf(rptIssueMain.get("amtSelfPay")));				
		long amtSelfPay 						= Long.parseLong(String.valueOf(rptIssueMain.get("amtSelfPay")));
		String accidentDate5 				= String.valueOf(rptIssueMain.get("accidentDate5"));
		
		String insuContent 			        = String.valueOf(rptIssue.get("insuContent"));		
		//int amtInsuPayment 					= Integer.parseInt(String.valueOf(rptIssueMain.get("amtInsuPayment")));		
		long amtInsuPayment 					= Long.parseLong(String.valueOf(rptIssueMain.get("amtInsuPayment")));
		
		String userName 					= String.valueOf(reportInvgUser.get("userName"));
		String disWorkLevel 				= String.valueOf(reportInvgUser.get("disWorkLevel"));
		String handphone 					= String.valueOf(reportInvgUser.get("handphone"));
        
        //총괄표 세부사항 메시지 만들기
        String sSummaryContent = "";
        
        //합계계산하기
        long sum_joinPrice = 0;
        long sum_insuPrice = 0;
        long sum_lossPrice = 0;
        long sum_remainPrice = 0;
        long sum_responPrice = 0;        
        long sum_compLimitPrice = 0;
        long sum_compResponPrice = 0;      
        long sum_selfOptPrice = 0;
        long sum_netLossPrice = 0;
        long sum_lossCompPrice = 0;
        long sum_billPrice = 0;
        long sum_payPrice = 0;

        //합계 계산 로직 추가 by top3009        
        for( int i=0; i < rptIssueSummaryList.size(); i++ ) {
        	sum_joinPrice += Long.parseLong(rptIssueSummaryList.get(i).get("joinPrice").toString());
        	sum_insuPrice += Long.parseLong(rptIssueSummaryList.get(i).get("insuPrice").toString());
        	sum_lossPrice += Long.parseLong(rptIssueSummaryList.get(i).get("lossPrice").toString());
        	sum_remainPrice += Long.parseLong(rptIssueSummaryList.get(i).get("remainPrice").toString());
        	sum_responPrice += Long.parseLong(rptIssueSummaryList.get(i).get("responPrice").toString());
        	sum_netLossPrice += Long.parseLong(rptIssueSummaryList.get(i).get("netLossPrice").toString());		//삼성추가        	
        	sum_compLimitPrice += Long.parseLong(rptIssueSummaryList.get(i).get("compLimitPrice").toString());
        	sum_compResponPrice += Long.parseLong(rptIssueSummaryList.get(i).get("compResponPrice").toString());
        	sum_selfOptPrice += Long.parseLong(rptIssueSummaryList.get(i).get("selfOptPrice").toString());
        	sum_lossCompPrice += Long.parseLong(rptIssueSummaryList.get(i).get("lossCompPrice").toString());		//삼성추가
        	sum_billPrice += Long.parseLong(rptIssueSummaryList.get(i).get("billPrice").toString());		//삼성추가
        	sum_payPrice += Long.parseLong(rptIssueSummaryList.get(i).get("payPrice").toString());		//삼성추가        	
        }
        
        if( sCtype.equals("C") ) {
        	if( rptIssueSummaryList.size() > 0 ) {
            	for(int k=0; k < rptIssueSummaryList.size(); k++) {
            		Map<String, Object>smap = rptIssueSummaryList.get(k);
    				sSummaryContent += "목적물(" + smap.get("summaryCate").toString() + ") : 보험가입금액("
    						+ StringUtil.toMoneyString(smap.get("joinPrice").toString()) + ") 보험가액(" + StringUtil.toMoneyString(smap.get("insuPrice").toString()) + ") 손해액("
    						+ StringUtil.toMoneyString(smap.get("lossPrice").toString()) + ") 잔존물("+ StringUtil.toMoneyString(smap.get("remainPrice").toString()) +") 지급보험금("+ StringUtil.toMoneyString(smap.get("payPrice").toString()) +"),\n";
            	}
            }else {
            	sSummaryContent = "내용없음\n";
            }
        	sSummaryContent += "합계 : 보험가입금액("+StringUtil.toMoneyString(sum_joinPrice)+") 보험가액("+StringUtil.toMoneyString(sum_insuPrice)+") 손해액("+StringUtil.toMoneyString(sum_lossPrice)+") 잔존물("+StringUtil.toMoneyString(sum_remainPrice)+") 지급보험금("+StringUtil.toMoneyString(sum_payPrice)+")\n";
        	sSummaryContent += "자기부담금 : "+StringUtil.toMoneyString(rptIssueMain.get("amtSelfPay").toString())+"\n";
        	
        }else if( sCtype.equals("B") ) {
        	if( rptIssueSummaryList.size() > 0 ) {
            	for(int k=0; k < rptIssueSummaryList.size(); k++) {
            		Map<String, Object>smap = rptIssueSummaryList.get(k);
    				sSummaryContent += "목적물(" + smap.get("summaryCate").toString() + ") : 보상한도액("
    						+ StringUtil.toMoneyString(smap.get("compLimitPrice").toString()) + ") 손해액(" + StringUtil.toMoneyString(smap.get("lossPrice").toString()) + ") 공제금액("
    						+ StringUtil.toMoneyString(smap.get("netLossPrice").toString()) + ") 지급보험금("+ StringUtil.toMoneyString(smap.get("payPrice").toString()) +") 비고("+ smap.get("exceptionVal").toString() +"),\n";
            	}
            }else {
            	sSummaryContent = "내용없음\n";
            }
        	sSummaryContent += "합계 : 보상한도액("+StringUtil.toMoneyString(sum_compLimitPrice)+") 손해액("+StringUtil.toMoneyString(sum_lossPrice)+") 공제금액("+StringUtil.toMoneyString(sum_netLossPrice)+") 지급보험금("+StringUtil.toMoneyString(sum_payPrice)+")\n";        
        	
        }else if( sCtype.equals("I") ){
        	if( rptIssueSummaryList.size() > 0 ) {
            	for(int k=0; k < rptIssueSummaryList.size(); k++) {
            		Map<String, Object>smap = rptIssueSummaryList.get(k);
    				sSummaryContent += "증권번호("+smap.get("insuNm")+") 담보명(" + smap.get("summaryCate").toString() + ") : 가입금액("
    						+ StringUtil.toMoneyString(smap.get("joinPrice").toString()) + ") 청구금액(" + StringUtil.toMoneyString(smap.get("billPrice").toString()) + ") 지급금액("
    						+ StringUtil.toMoneyString(smap.get("payPrice").toString()) + ") 비고("+ smap.get("exceptionVal").toString() +"),\n";
            	}
            }else {
            	sSummaryContent = "내용없음\n";
            }
        	sSummaryContent += "합계 : 가입금액("+StringUtil.toMoneyString(sum_joinPrice)+") 청구금액("+StringUtil.toMoneyString(sum_billPrice)+") 지급금액("+StringUtil.toMoneyString(sum_payPrice)+")\n";      
        	
        }else {
        	sSummaryContent = "내용없음\n";
        }
        
        //특이사항 처리
        //비고 null 처리
        String sSpecialContent = "";
        
    	if( rptIssue.get("remarkVal") != null ) {
    		sSpecialContent = rptIssue.get("remarkVal").toString();
    	}else {
    		sSpecialContent = "-";
    	}
		
		//증권번호
		String sPolicyNo = String.valueOf(rptIssueMain.get("policyNo"));
		
		//소재지
		String sSuimAddress = String.valueOf(rptIssue.get("suimAddress"));
		
		//전송시 계약자 피보험자 이름 두번째 글자 '*' 처리        
		String sHiddenPolicyNm = suimVo.getPolicyholder_nm().toString();
		String sHiddenBenefitNm = suimVo.getBeneficiary_nm().toString();

		if( !sHiddenPolicyNm.equals("") ) {        	
			if( sHiddenPolicyNm.length() == 1 ) {
				sHiddenPolicyNm = "*";
			}else {
				sHiddenPolicyNm = sHiddenPolicyNm.replace(sHiddenPolicyNm.charAt(1),'*');
			}        	        	
		}else {
			sHiddenPolicyNm = "";
		}

		if( !sHiddenBenefitNm.equals("") ) {
			if( sHiddenBenefitNm.length() == 1 ) {
				sHiddenBenefitNm = "*";
			}else {
				sHiddenBenefitNm = sHiddenBenefitNm.replace(sHiddenBenefitNm.charAt(1),'*');
			}        	
		}else {
			sHiddenBenefitNm = "";
		}		
		
		//사고장소
		String investigate_addr1 = String.valueOf(suimVo.getInvestigate_addr1());		//null 처리
		String investigate_addr2 = String.valueOf(suimVo.getInvestigate_addr2());		//null 처리
		String sAccPlace = "";
		
		if( !investigate_addr1.equals("") ) {
			sAccPlace = investigate_addr1; 
		}else if( !investigate_addr2.equals("") ){
			sAccPlace = investigate_addr2;
		}else{
			sAccPlace = "사고장소정보 미노출";
		}
		
		//담당자 자격증(손해사정사) 정보 List 만들기 시작
        String sUserNo = String.valueOf(rptIssueMain.get("userNo"));
        List<Map<String, Object>> certiReportUser = null;					//보고서 하단에 들어갈 담당자 정보 List
        List<Map<String, Object>> certiManagerReportUser = null;		//담당손해사정사 목록
        
        //기 종결건은 담당손해사정사가 별도 저장되어있음 (top_rpt_certi_end) 저장된 손해사정사 정보가 별도로 있는지 체크
        int nEndCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiEndCnt",paramMap);
        
        if( nEndCnt == 0 ) {			//정보가 없는 경우 실시간으로 가져온다.
        	
        	if( !"0".equals(sUserNo) ) {		//0은 미배당건        	
            	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiMemberInfo", paramMap);
            	
            	int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
            	
            	nCertiManagerCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiManagerCnt", paramMap);
            	
            	if( nCertiManagerCnt > 0 ) {			//담당손해사정사가 있는 경우
            		certiManagerReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiManagerList", paramMap);
            		for( int i=0; i < certiManagerReportUser.size(); i++) {
            			certiReportUser.add(certiManagerReportUser.get(i));		//보고서 하단에 들어갈 담당자 정보에 담당손해사정서를 추가한다.
            		}
            	}
            }
        	
        }else{								//정보가 있는 경우 top_rpt_certi_end 테이블에서 불러온다.
        	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiEndInfo", paramMap);
        }
        
        String sCertiMemberText = "";
        
        if( certiReportUser == null ) {			//미배상건
        	sCertiMemberText = "미배당건으로 담당자 정보가 없습니다.";
        }else{
        	for( int i=0; i < certiReportUser.size(); i++) {
        		sCertiMemberText += String.valueOf(certiReportUser.get(i).get("certi_state_val"))+" : "+String.valueOf(certiReportUser.get(i).get("user_name"))+" (직인생략)\n"+
        			"(연락처 : "+String.valueOf(certiReportUser.get(i).get("work_phone"))+")\n"+"등록번호 : " +String.valueOf(certiReportUser.get(i).get("certi_number"))+"\n\n";
        	}
        }        
		//담당자 자격증(손해사정사) 정보 List 만들기 끝

		String tmplId = "";
		
		if(sCtype.equals("I")){
			//tmplId = "toplac11";			//흥국생명 인보험 코드
			//tmplId = "toplac17";			//흥국생명 인보험 코드
			tmplId = "toplac171";			//흥국생명 인보험 코드
		}else {
			//tmplId = "toplac10";			//흥국생명 재물, 배상코드
			//tmplId = "toplac16";			//흥국생명 재물, 배상코드
			tmplId = "toplac161";			//흥국생명 재물, 배상코드
		}							
		
		String msg = "보험업법 제189조 소정의 규정에 의거하여 아래와 같이 손해사정서를 안내합니다.\n";
		msg += "\n";
		msg += "Report No. : "+suimAcceptNo+"\n";
		msg += "\n";
		msg += "손해사정[사고번호 : "+accidentNo+"]\n";
		msg += "\n";
		msg += "1. 계약사항\n";
		msg += "가. 보험종목 : "+insuranceNm+"\n";
		msg += "나. 증권번호 : "+sPolicyNo+"\n";
		msg += "다. 계약자 : "+sHiddenPolicyNm+"\n";
		msg += "라. 피보험자 : "+sHiddenBenefitNm+"\n";
		msg += "마. 소재지 : "+StringUtil.null2blank(sSuimAddress.replace("null", ""))+"\n";
		msg += "바. 보험기간 : "+insuTerm+"\n";
		msg += "\n";
		
		if(sCtype.equals("I")){
			msg += "2. 사고사항\n";
			msg += "가. 사고(진료)일시 : "+accidentDate5+"\n";			
			msg += "나. 사고(진단)내용 : "+insuContent+"\n";
			msg += "\n";
		}else {
			msg += "2. 사고사항\n";
			msg += "가. 사고일자 : "+accidentDate5+"\n";
			msg += "나. 사고장소 : "+StringUtil.null2blank(sAccPlace.replace("null", ""))+"\n";
			msg += "다. 사고내용 : "+insuContent+"\n";
			msg += "\n";
		}

		msg += "3. 총괄표 (단위:원)\n";	
		msg += sSummaryContent+"\n";		
		
		if(sCtype.equals("I")){
			msg += "4. 확인사항\n";
			msg += sSpecialContent+"\n";
			msg += "\n";
		}else {
			msg += "4. 특이사항\n";
			msg += sSpecialContent+"\n";
			msg += "\n";
		}		
		
		msg += sCertiMemberText;
		
		//msg += "담당자 : "+userName+"\n";
		//msg += "대표손해사정사 : 윤경수(직인생략)\n";
		msg += "\n";
		msg += "탑손해사정주식회사\n";		
		msg += "대표이사 전태옥(직인생략)\n";

		//카카오(문자)발송한 내역을 DB에 저장한다.		
		paramMap.put("send_content", msg);

		sqlSession.update("RptIssueMapper.updateRptIssueSendContent",paramMap);
		
		Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
		String tel1 = String.valueOf(sendMap.get("tel1"));
		String tel2 = String.valueOf(sendMap.get("tel2"));
		String tel3 = String.valueOf(sendMap.get("tel3"));
		String phn = "82"+tel1.substring(1)+tel2+tel3;
		
		RestTemplate restTemplate = new RestTemplate();
		// RestTemplate 에 MessageConverter 세팅
	    List<HttpMessageConverter<?>> converters = new ArrayList<HttpMessageConverter<?>>();
	    converters.add(new FormHttpMessageConverter());
	    converters.add(new StringHttpMessageConverter(Charset.forName("UTF-8")));
		
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.add("Accept", "application/json");
		httpHeaders.add("Content-type", "application/json");
		httpHeaders.add("userId", "toplac"); //실제
		
		
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		obj.put("message_type", "at");
		obj.put("phn", phn);
		obj.put("profile", "22e9cd927d652e02daca5dc631170e021f02ae51");	//실제
		obj.put("tmplId", tmplId);
		obj.put("msg", msg);

		obj.put("smsKind", "L");
		obj.put("msgSms", msg);
		obj.put("smsSender", "0260774600");

		obj.put("smsLmsTit", "탑손해사정주식회사");
		obj.put("reserveDt", "00000000000000");
		
		//메시지 길이가 930자 이상인경우 SMS 로 전환하여 발송
		int msgLength = msg.length();
		if( msgLength > 930 ) {
			obj.put("smsOnly", "Y");
		}
		
		arr.add(obj);
		
		HttpEntity entity = new HttpEntity(arr, httpHeaders);
		
		//System.out.println(tmplId);
		
		URI uri = UriComponentsBuilder.fromHttpUrl("https://alimtalk-api.bizmsg.kr/v2/sender/send")
				.build().toUri();
				
		
		String responseEntity = restTemplate.postForObject(uri, entity, String.class);
		logger.info(responseEntity);
		
		return responseEntity;
	}

	public String sendAxaKaKaoTalk(Map<String,Object> paramMap){				//악사발송용
		
		logger.info("======== sendAxaKaKaoTalk ========");
		
	    //기본정보 가져오기
	    Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);
	    Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
	    
	    //계약자 정보가져오기
	    SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);
	    
	    //보험목적물 계약정보 가져오기
	    List<Map<String, Object>> rptIssueContList = sqlSession.selectList("RptIssueMapper.selectRptIssueContLotte", paramMap);
	    
	    //총괄표 정보 가져오기
	    List<Map<String, Object>> rptIssueSummaryList = sqlSession.selectList("RptIssueMapper.selectRptIssueSummaryLotte", paramMap);
	    
	    String sCtypeName = "";
	    
	    String sCtype = paramMap.get("ctype").toString();		//보험타입 (C:재물보험, B:배상보험, I:인보험)
	    if( sCtype.equals("C") ) {
	    	sCtypeName = "보험목적물";
	    }else {
	    	sCtypeName = "계약약관";
	    }
	    
	    //조사자 정보
	    paramMap.put("user_no", rptIssueMain.get("userNo"));
	    Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
		
		String suimAcceptNo 				= String.valueOf(rptIssueMain.get("suimAcceptNo"));
		String accidentNo 					= String.valueOf(rptIssueMain.get("accidentNo"));
		String damagedNm					= String.valueOf(suimVo.getDamaged_nm());
		
		String insuranceNm 					= String.valueOf(rptIssueMain.get("insuranceNm"));
		String insuTerm 					= String.valueOf(rptIssueMain.get("insuTerm"));
		//자기부담금 단위, 자기부담금액
		String amtSelfPayUnit 				= String.valueOf(rptIssueMain.get("amtSelfPayUnit"));
		//int amtSelfPay 						= Integer.parseInt(String.valueOf(rptIssueMain.get("amtSelfPay")));				
		long amtSelfPay 						= Long.parseLong(String.valueOf(rptIssueMain.get("amtSelfPay")));
		String accidentDate5 				= String.valueOf(rptIssueMain.get("accidentDate5"));
		
		String insuContent 			        = String.valueOf(rptIssue.get("insuContent"));
		String insuSequence 			        = String.valueOf(rptIssue.get("insuSequence"));
		
		String userName 					= String.valueOf(reportInvgUser.get("userName"));
		String disWorkLevel 				= String.valueOf(reportInvgUser.get("disWorkLevel"));
		String handphone 					= String.valueOf(reportInvgUser.get("handphone"));
		
		String guaranteeTitle = String.valueOf(rptIssueMain.get("guaranteeTitle"));
		String amtCompensationLimit = String.valueOf(rptIssueMain.get("amtCompensationLimit"));
		
		//약관면책여부
		String LiabilityType = "";		
		//지급보험금
		String InsuPayment = "";		
		//지급처
		String PaymentPlace = "";
		
		String reparationLiabilityType 				= String.valueOf(rptIssueMain.get("reparationLiabilityType"));
		String amtInsuPaymentDisable 				= String.valueOf(rptIssueMain.get("amtInsuPaymentDisable"));
		String amtInsuPayment 				= String.valueOf(rptIssueMain.get("amtInsuPayment"));
		String paymentPlace 				= String.valueOf(rptIssueMain.get("paymentPlace"));
		
		if("1".equals(reparationLiabilityType)) {
			LiabilityType = "부책";
		}else if("2".equals(reparationLiabilityType)) {
			LiabilityType = "면책";
		}else {
			LiabilityType =" - ";
		}
		
		if("1".equals(amtInsuPaymentDisable)) {
			InsuPayment = "단체 사고의 경우 개별 안내 금액에 따름";
		}else {
			InsuPayment = StringUtil.toMoneyString(amtInsuPayment)+" 원";
		}
		
		if("1".equals(paymentPlace)) {
			PaymentPlace = "피보험자";
		}else if("2".equals(paymentPlace)) {
			PaymentPlace = "피해자";
		}else{
			PaymentPlace = " - ";
		}
		
		//증권번호
		String sPolicyNo = String.valueOf(rptIssueMain.get("policyNo"));
		
		//소재지
		String sSuimAddress = String.valueOf(rptIssue.get("suimAddress")).replace("null", "");
		
		//전송시 계약자 피보험자 이름 두번째 글자 '*' 처리        
		String sHiddenPolicyNm = suimVo.getPolicyholder_nm().toString();
		String sHiddenBenefitNm = suimVo.getBeneficiary_nm().toString();
		String sHiddendamagedNm = damagedNm;
	
		if( !sHiddenPolicyNm.equals("") ) {        	
			if( sHiddenPolicyNm.length() == 1 ) {
				sHiddenPolicyNm = "*";
			}else {
				sHiddenPolicyNm = sHiddenPolicyNm.replace(sHiddenPolicyNm.charAt(1),'*');
			}        	        	
		}else {
			sHiddenPolicyNm = "";
		}
	
		if( !sHiddenBenefitNm.equals("") ) {
			if( sHiddenBenefitNm.length() == 1 ) {
				sHiddenBenefitNm = "*";
			}else {
				sHiddenBenefitNm = sHiddenBenefitNm.replace(sHiddenBenefitNm.charAt(1),'*');
			}        	
		}else {
			sHiddenBenefitNm = "";
		}
		
		if( !sHiddendamagedNm.equals("") ) {
			if( sHiddendamagedNm.length() == 1 ) {
				sHiddendamagedNm = "*";
			}else {
				sHiddendamagedNm = sHiddendamagedNm.replace(sHiddendamagedNm.charAt(1),'*');
			}        	
		}else {
			sHiddendamagedNm = "";
		}
		
		//사고장소 
		//String investigate_addr1 = suimVo.getInvestigate_addr1().toString();
		String investigate_addr1 = String.valueOf(suimVo.getInvestigate_addr1());		//null 처리		
		//String investigate_addr2 = suimVo.getInvestigate_addr2().toString();
		String investigate_addr2 = String.valueOf(suimVo.getInvestigate_addr2());		//null 처리
		String sAccPlace = "";
		
		if( !investigate_addr1.equals("") ) {
			sAccPlace = investigate_addr1; 
		}else if( !investigate_addr2.equals("") ){
			sAccPlace = investigate_addr2;
		}else{
			sAccPlace = "사고장소정보 미노출";
		}
		
		//담당자 자격증(손해사정사) 정보 List 만들기 시작
		String sUserNo = String.valueOf(rptIssueMain.get("userNo"));
		List<Map<String, Object>> certiReportUser = null;					//보고서 하단에 들어갈 담당자 정보 List
		List<Map<String, Object>> certiManagerReportUser = null;		//담당손해사정사 목록

		//기 종결건은 담당손해사정사가 별도 저장되어있음 (top_rpt_certi_end) 저장된 손해사정사 정보가 별도로 있는지 체크
		int nEndCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiEndCnt",paramMap);

		if( nEndCnt == 0 ) {			//정보가 없는 경우 실시간으로 가져온다.
			
			if( !"0".equals(sUserNo) ) {		//0은 미배당건        	
			certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiMemberInfo", paramMap);
			
			int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
			
			nCertiManagerCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiManagerCnt", paramMap);
			
			if( nCertiManagerCnt > 0 ) {			//담당손해사정사가 있는 경우
				certiManagerReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiManagerList", paramMap);
				for( int i=0; i < certiManagerReportUser.size(); i++) {
					certiReportUser.add(certiManagerReportUser.get(i));		//보고서 하단에 들어갈 담당자 정보에 담당손해사정서를 추가한다.
				}
			}
		    }
			
		}else{								//정보가 있는 경우 top_rpt_certi_end 테이블에서 불러온다.
			certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiEndInfo", paramMap);
		}

		String sCertiMemberText = "";

		if( certiReportUser == null ) {			//미배상건
			sCertiMemberText = "미배당건으로 담당자 정보가 없습니다.";
		}else{
			for( int i=0; i < certiReportUser.size(); i++) {
				sCertiMemberText += String.valueOf(certiReportUser.get(i).get("certi_state_val"))+" : "+String.valueOf(certiReportUser.get(i).get("user_name"))+" (직인생략)\n"+
					"(연락처 : "+String.valueOf(certiReportUser.get(i).get("work_phone"))+")\n"+"등록번호 : " +String.valueOf(certiReportUser.get(i).get("certi_number"))+"\n\n";
			}
		}

		//담당자 자격증(손해사정사) 정보 List 만들기 끝
	
		String tmplId = "";			
			//tmplId = "toplac19";			//악사탬플릿 코드
			tmplId = "toplac191";			//악사탬플릿 코드
		
		String msg = "보험업법 제189조 소정의 규정에 의거하여 아래와 같이 손해사정서를 안내합니다.\n";
		msg += "\n";
		msg += "Report No. : "+suimAcceptNo+"\n";
		msg += "\n";
		msg += "손해사정[사고번호 : "+accidentNo+"]\n";
		msg += "\n";
		msg += "1. 계약사항\n";
		msg += "가. 증권번호 : "+sPolicyNo+"\n";
		msg += "나. 보험기간 : "+insuTerm+"\n";
		msg += "다. 담보명 : "+guaranteeTitle+"\n";
		msg += "라. 가입금액(보상한도액) : "+StringUtil.toMoneyString(amtSelfPay)+" 원\n";
		msg += "마. 자기부담금 : "+StringUtil.toMoneyString(amtCompensationLimit)+" 원\n";
		msg += "바. 계약자/피보험자 : "+sHiddenPolicyNm+"/"+sHiddenBenefitNm+"\n";
		msg += "사. 소재지(목적물) : "+sSuimAddress+"\n";	
		msg += "\n";
				
		msg += "2. 사고사항\n";
		
		msg += "가. 사고일시 : "+accidentDate5+"\n";
		msg += "나. 사고장소 : "+sAccPlace+"\n";
		msg += "다. 사고원인 : "+insuContent+"\n";
		msg += "라. 사고경위 : "+insuSequence+"\n";
		msg += "마. 피해자(피해물) : "+sHiddendamagedNm+"\n";
		msg += "\n";
		
		msg += "3. 총괄표\n";
		msg += "가. 약관상면부책여부 : "+LiabilityType+"\n";
		msg += "나. 지급보험금 : "+InsuPayment+"\n";
		msg += "다. 지급처 : "+PaymentPlace+"\n";
		msg += "\n";
		
		msg += sCertiMemberText;
		
		//msg += "담당자 : "+disWorkLevel+" "+userName+"  (연락처 : "+handphone+")\n";
		//msg += "담당자 : "+userName+"\n";
		//msg += "대표손해사정사 : 윤경수(직인생략)\n";
		msg += "\n";
		msg += "탑손해사정주식회사\n";		
		//msg += "대표이사 사장 전태옥(직인생략)\n";		
		msg += "대표이사 전태옥(직인생략)\n";	
		
		//카카오(문자)발송한 내역을 DB에 저장한다.		
		paramMap.put("send_content", msg);

		sqlSession.update("RptIssueMapper.updateRptIssueSendContent",paramMap);
		
		Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
		String tel1 = String.valueOf(sendMap.get("tel1"));
		String tel2 = String.valueOf(sendMap.get("tel2"));
		String tel3 = String.valueOf(sendMap.get("tel3"));
		String phn = "82"+tel1.substring(1)+tel2+tel3;
		
		RestTemplate restTemplate = new RestTemplate();
		// RestTemplate 에 MessageConverter 세팅
	    List<HttpMessageConverter<?>> converters = new ArrayList<HttpMessageConverter<?>>();
	    converters.add(new FormHttpMessageConverter());
	    converters.add(new StringHttpMessageConverter(Charset.forName("UTF-8")));
		
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.add("Accept", "application/json");
		httpHeaders.add("Content-type", "application/json");
		httpHeaders.add("userId", "toplac"); //실제
		
		
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		obj.put("message_type", "at");
		obj.put("phn", phn);
		obj.put("profile", "22e9cd927d652e02daca5dc631170e021f02ae51");	//실제
		obj.put("tmplId", tmplId);
		obj.put("msg", msg);
	
		obj.put("smsKind", "L");
		obj.put("msgSms", msg);
		obj.put("smsSender", "0260774600");
	
		obj.put("smsLmsTit", "탑손해사정주식회사");
		obj.put("reserveDt", "00000000000000");
		
		//메시지 길이가 930자 이상인경우 SMS 로 전환하여 발송
		int msgLength = msg.length();
		if( msgLength > 930 ) {
			obj.put("smsOnly", "Y");
		}
		
		arr.add(obj);
		
		HttpEntity entity = new HttpEntity(arr, httpHeaders);
		
		//System.out.println(tmplId);
		
		URI uri = UriComponentsBuilder.fromHttpUrl("https://alimtalk-api.bizmsg.kr/v2/sender/send")
				.build().toUri();
				
		
		String responseEntity = restTemplate.postForObject(uri, entity, String.class);
		logger.info(responseEntity);
		
		return responseEntity;
	}
    
    public String sendSamsungKaKaoTalk(Map<String,Object> paramMap){				//삼성발송용
    	
    	logger.info("======== sendSamsungKaKaoTalk ========");
		
        //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);
        
        //계약자 정보가져오기
        SuimRptCompositeVO suimVo = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtl", paramMap);
        
        //보험목적물 계약정보 가져오기
        List<Map<String, Object>> rptIssueContList = sqlSession.selectList("RptIssueMapper.selectRptIssueContLotte", paramMap);
        
        //총괄표 정보 가져오기
        List<Map<String, Object>> rptIssueSummaryList = sqlSession.selectList("RptIssueMapper.selectRptIssueSummaryLotte", paramMap);
        
        String sCtypeName = "";
        
        String sCtype = paramMap.get("ctype").toString();		//보험타입 (C:재물보험, B:배상보험, I:인보험)
        if( sCtype.equals("C") ) {
        	sCtypeName = "보험목적물";
        }else {
        	sCtypeName = "계약약관";
        }
        
        //조사자 정보
        paramMap.put("user_no", rptIssueMain.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
		
		String suimAcceptNo 				= String.valueOf(rptIssueMain.get("suimAcceptNo"));
		String accidentNo 					= String.valueOf(rptIssueMain.get("accidentNo"));
		
		String insuranceNm 					= String.valueOf(rptIssueMain.get("insuranceNm"));
		String insuTerm 					= String.valueOf(rptIssueMain.get("insuTerm"));
		//자기부담금 단위, 자기부담금액
		String amtSelfPayUnit 				= String.valueOf(rptIssueMain.get("amtSelfPayUnit"));
		//int amtSelfPay 						= Integer.parseInt(String.valueOf(rptIssueMain.get("amtSelfPay")));				
		long amtSelfPay 						= Long.parseLong(String.valueOf(rptIssueMain.get("amtSelfPay")));
		String accidentDate5 				= StringUtil.null2blank(String.valueOf(rptIssueMain.get("accidentDate5")));
		
		String insuContent 			        = String.valueOf(rptIssue.get("insuContent"));		
		//int amtInsuPayment 					= Integer.parseInt(String.valueOf(rptIssueMain.get("amtInsuPayment")));		
		long amtInsuPayment 					= Long.parseLong(String.valueOf(rptIssueMain.get("amtInsuPayment")));
		
		String userName 					= String.valueOf(reportInvgUser.get("userName"));
		String disWorkLevel 				= String.valueOf(reportInvgUser.get("disWorkLevel"));
		String handphone 					= String.valueOf(reportInvgUser.get("handphone"));
        
        //총괄표 세부사항 메시지 만들기
        String sSummaryContent = "";        
        
        //합계계산하기
        long sum_joinPrice = 0;
        long sum_insuPrice = 0;
        long sum_lossPrice = 0;
        long sum_remainPrice = 0;
        long sum_responPrice = 0;        
        long sum_compLimitPrice = 0;
        long sum_compResponPrice = 0;      
        long sum_selfOptPrice = 0;
        long sum_netLossPrice = 0;
        long sum_lossCompPrice = 0;
        long sum_billPrice = 0;
        long sum_payPrice = 0;

        //합계 계산 로직 추가 by top3009        
        for( int i=0; i < rptIssueSummaryList.size(); i++ ) {
        	sum_joinPrice += Long.parseLong(rptIssueSummaryList.get(i).get("joinPrice").toString());
        	sum_insuPrice += Long.parseLong(rptIssueSummaryList.get(i).get("insuPrice").toString());
        	sum_lossPrice += Long.parseLong(rptIssueSummaryList.get(i).get("lossPrice").toString());
        	sum_remainPrice += Long.parseLong(rptIssueSummaryList.get(i).get("remainPrice").toString());
        	sum_responPrice += Long.parseLong(rptIssueSummaryList.get(i).get("responPrice").toString());
        	sum_netLossPrice += Long.parseLong(rptIssueSummaryList.get(i).get("netLossPrice").toString());		//삼성추가        	
        	sum_compLimitPrice += Long.parseLong(rptIssueSummaryList.get(i).get("compLimitPrice").toString());
        	sum_compResponPrice += Long.parseLong(rptIssueSummaryList.get(i).get("compResponPrice").toString());
        	sum_selfOptPrice += Long.parseLong(rptIssueSummaryList.get(i).get("selfOptPrice").toString());
        	sum_lossCompPrice += Long.parseLong(rptIssueSummaryList.get(i).get("lossCompPrice").toString());		//삼성추가
        	sum_billPrice += Long.parseLong(rptIssueSummaryList.get(i).get("billPrice").toString());		//삼성추가
        	sum_payPrice += Long.parseLong(rptIssueSummaryList.get(i).get("payPrice").toString());		//삼성추가        	
        }
        
        if( sCtype.equals("C") ) {
        	if( rptIssueSummaryList.size() > 0 ) {
            	for(int k=0; k < rptIssueSummaryList.size(); k++) {
            		Map<String, Object>smap = rptIssueSummaryList.get(k);
    				sSummaryContent += "목적물(" + smap.get("summaryCate").toString() + ") : 보험가입금액("
    						+ StringUtil.toMoneyString(smap.get("joinPrice").toString()) + ") 보험가액(" + StringUtil.toMoneyString(smap.get("insuPrice").toString()) + ") 손해액("
    						+ StringUtil.toMoneyString(smap.get("lossPrice").toString()) + ") 잔존물("+ StringUtil.toMoneyString(smap.get("remainPrice").toString()) +") 순손해액("+ StringUtil.toMoneyString(smap.get("netLossPrice").toString()) +"),\n";
            	}
            }else {
            	sSummaryContent = "내용없음\n";
            }
        	sSummaryContent += "합계 : 보험가입금액("+StringUtil.toMoneyString(sum_joinPrice)+") 보험가액("+StringUtil.toMoneyString(sum_insuPrice)+") 손해액("+StringUtil.toMoneyString(sum_lossPrice)+") 잔존물("+StringUtil.toMoneyString(sum_remainPrice)+") 순손해액("+StringUtil.toMoneyString(sum_netLossPrice)+")\n";
        	sSummaryContent += "자기부담금 : "+StringUtil.toMoneyString(rptIssueMain.get("amtSelfPay").toString())+"\n";
        	
        }else if( sCtype.equals("B") ) {
        	if( rptIssueSummaryList.size() > 0 ) {
            	for(int k=0; k < rptIssueSummaryList.size(); k++) {
            		Map<String, Object>smap = rptIssueSummaryList.get(k);
    				sSummaryContent += "목적물(" + smap.get("summaryCate").toString() + ") : 보상한도액("
    						+ StringUtil.toMoneyString(smap.get("compLimitPrice").toString()) + ") 손해액(" + StringUtil.toMoneyString(smap.get("lossPrice").toString()) + ") 손해배상금("
    						+ StringUtil.toMoneyString(smap.get("lossCompPrice").toString()) + ") 자기부담금("+ StringUtil.toMoneyString(smap.get("selfOptPrice").toString()) +"),\n";
            	}
            }else {
            	sSummaryContent = "내용없음\n";
            }
        	sSummaryContent += "합계 : 보상한도액("+StringUtil.toMoneyString(sum_compLimitPrice)+") 손해액("+StringUtil.toMoneyString(sum_lossPrice)+") 손해배상금("+StringUtil.toMoneyString(sum_lossCompPrice)+") 자기부담금("+StringUtil.toMoneyString(sum_selfOptPrice)+")\n";        
        	
        }else if( sCtype.equals("I") ){
        	if( rptIssueSummaryList.size() > 0 ) {
            	for(int k=0; k < rptIssueSummaryList.size(); k++) {
            		Map<String, Object>smap = rptIssueSummaryList.get(k);
    				sSummaryContent += "목적물(" + smap.get("summaryCate").toString() + ") : 가입금액("
    						+ StringUtil.toMoneyString(smap.get("joinPrice").toString()) + ") 청구금액(" + StringUtil.toMoneyString(smap.get("billPrice").toString()) + ") 지급금액("
    						+ StringUtil.toMoneyString(smap.get("payPrice").toString()) + ") 제외사유("+ smap.get("exceptionVal").toString() +"),\n";
            	}
            }else {
            	sSummaryContent = "내용없음\n";
            }
        	sSummaryContent += "합계 : 가입금액("+StringUtil.toMoneyString(sum_joinPrice)+") 청구금액("+StringUtil.toMoneyString(sum_billPrice)+") 지급금액("+StringUtil.toMoneyString(sum_payPrice)+")\n";      
        	
        }else {
        	sSummaryContent = "내용없음\n";
        }
        
        //특이사항 처리
      //비고 null 처리
        String sSpecialContent = "";
        
    	if( rptIssue.get("remarkVal") != null ) {
    		sSpecialContent = rptIssue.get("remarkVal").toString();
    	}else {
    		sSpecialContent = "-";
    	}
		
		//증권번호
		String sPolicyNo = String.valueOf(rptIssueMain.get("policyNo"));
		
		//소재지
		String sSuimAddress = String.valueOf(rptIssue.get("suimAddress")).replace("null", "");
		
		//전송시 계약자 피보험자 이름 두번째 글자 '*' 처리        
		String sHiddenPolicyNm = suimVo.getPolicyholder_nm().toString();
		String sHiddenBenefitNm = suimVo.getBeneficiary_nm().toString();

		if( !sHiddenPolicyNm.equals("") ) {        	
			if( sHiddenPolicyNm.length() == 1 ) {
				sHiddenPolicyNm = "*";
			}else {
				sHiddenPolicyNm = sHiddenPolicyNm.replace(sHiddenPolicyNm.charAt(1),'*');
			}        	        	
		}else {
			sHiddenPolicyNm = "";
		}

		if( !sHiddenBenefitNm.equals("") ) {
			if( sHiddenBenefitNm.length() == 1 ) {
				sHiddenBenefitNm = "*";
			}else {
				sHiddenBenefitNm = sHiddenBenefitNm.replace(sHiddenBenefitNm.charAt(1),'*');
			}        	
		}else {
			sHiddenBenefitNm = "";
		}		
		
		//사고장소 
		//String investigate_addr1 = suimVo.getInvestigate_addr1().toString();
		String investigate_addr1 = String.valueOf(suimVo.getInvestigate_addr1());		//null 처리		
		//String investigate_addr2 = suimVo.getInvestigate_addr2().toString();
		String investigate_addr2 = String.valueOf(suimVo.getInvestigate_addr2());		//null 처리
		String sAccPlace = "";
		
		if( !investigate_addr1.equals("") ) {
			sAccPlace = investigate_addr1; 
		}else if( !investigate_addr2.equals("") ){
			sAccPlace = investigate_addr2;
		}else{
			sAccPlace = "사고장소정보 미노출";
		}
		
		//손해사정서 양식 변경에 따른 수정 시작
		String regDateFmt = String.valueOf(rptIssueMain.get("regDate"));		//수임일
		String policyholderNm = String.valueOf(rptIssueMain.get("policyholderNm"));		//계약자
		String beneficiaryNm = String.valueOf(rptIssueMain.get("beneficiaryNm"));			//피보험자
		        
        Map<String, Object> lawEtcContentMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawContentInfo", paramMap);        
        
        String lawSubject = String.valueOf(lawEtcContentMap.get("law_subject"));			//관련법규
        String lawEtc = String.valueOf(lawEtcContentMap.get("law_etc"));						//관련약관

        Map<String, Object> lawReasonMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawReasonInfo", paramMap);
        Map<String, Object> lawSelContentMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawSelInfo", paramMap);        
        
        String reparationLiabilityReasonEtc = String.valueOf(lawSelContentMap.get("reparation_liability_reason_etc"));		//책임범위
        
        if( "2".equals(reparationLiabilityReasonEtc) ) {
        	reparationLiabilityReasonEtc = "동 약관 보상하지 않는 손해";
        }else if( "1".equals(reparationLiabilityReasonEtc) ) {
        	reparationLiabilityReasonEtc = "동 약관 보상하는 손해";
        }else{
        	reparationLiabilityReasonEtc = "-";
        }
        //손해사정서 양식 변경에 따른 수정 끝        
        
      	//담당자 자격증(손해사정사) 정보 List 만들기 시작
        String sUserNo = String.valueOf(rptIssueMain.get("userNo"));
        List<Map<String, Object>> certiReportUser = null;					//보고서 하단에 들어갈 담당자 정보 List
        List<Map<String, Object>> certiManagerReportUser = null;		//담당손해사정사 목록
        
        //기 종결건은 담당손해사정사가 별도 저장되어있음 (top_rpt_certi_end) 저장된 손해사정사 정보가 별도로 있는지 체크
        int nEndCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiEndCnt",paramMap);
        
        if( nEndCnt == 0 ) {			//정보가 없는 경우 실시간으로 가져온다.
        	
        	if( !"0".equals(sUserNo) ) {		//0은 미배당건        	
            	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiMemberInfo", paramMap);
            	
            	int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
            	
            	nCertiManagerCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiManagerCnt", paramMap);
            	
            	if( nCertiManagerCnt > 0 ) {			//담당손해사정사가 있는 경우
            		certiManagerReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiManagerList", paramMap);
            		for( int i=0; i < certiManagerReportUser.size(); i++) {
            			certiReportUser.add(certiManagerReportUser.get(i));		//보고서 하단에 들어갈 담당자 정보에 담당손해사정서를 추가한다.
            		}
            	}
            }
        	
        }else{								//정보가 있는 경우 top_rpt_certi_end 테이블에서 불러온다.
        	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiEndInfo", paramMap);
        }
        
        String sCertiMemberText = "";
        
        if( certiReportUser == null ) {			//미배상건
        	sCertiMemberText = "미배당건으로 담당자 정보가 없습니다.";
        }else{
        	for( int i=0; i < certiReportUser.size(); i++) {
        		sCertiMemberText += String.valueOf(certiReportUser.get(i).get("certi_state_val"))+" : "+String.valueOf(certiReportUser.get(i).get("user_name"))+" (직인생략)\n"+
        			"(연락처 : "+String.valueOf(certiReportUser.get(i).get("work_phone"))+")\n"+"등록번호 : " +String.valueOf(certiReportUser.get(i).get("certi_number"))+"\n\n";
        	}
        }
        
		//담당자 자격증(손해사정사) 정보 List 만들기 끝
		//손해사정서 양식 변경에 따라 항목 추가 끝
		

		String tmplId = "";
			//tmplId = "toplac10";			//삼성탬플릿 코드
			//tmplId = "toplac16";			//삼성탬플릿 코드
			tmplId = "toplac161";			//삼성탬플릿 코드
		
		String msg = "보험업법 제189조 소정의 규정에 의거하여 아래와 같이 손해사정서를 안내합니다.\n";
		msg += "\n";
		msg += "Report No. : "+suimAcceptNo+"\n";
		msg += "\n";
		msg += "손해사정[사고번호 : "+accidentNo+"]\n";
		msg += "\n";
		msg += "1. 계약사항\n";
		msg += "가. 보험종목 : "+insuranceNm+"\n";
		msg += "나. 증권번호 : "+sPolicyNo+"\n";
		msg += "다. 계약자 : "+sHiddenPolicyNm+"\n";
		msg += "라. 피보험자 : "+sHiddenBenefitNm+"\n";
		msg += "마. 소재지 : "+sSuimAddress+"\n";
		msg += "바. 보험기간 : "+insuTerm+"\n";
		msg += "\n";
				
		msg += "2. 사고사항\n";
		msg += "가. 사고일자 : "+accidentDate5+"\n";
		msg += "나. 사고장소 : "+sAccPlace+"\n";
		msg += "다. 사고내용 : "+insuContent+"\n";
		msg += "\n";		

		msg += "3. 총괄표 (단위:원)\n";	
		msg += sSummaryContent+"\n";		
		
		msg += "4. 특이사항\n";
		msg += sSpecialContent+"\n";
		msg += "\n";
		
		msg += sCertiMemberText;
		//msg += "담당자 : "+disWorkLevel+" "+userName+"  (연락처 : "+handphone+")\n";
		//msg += "담당자 : "+userName+"\n";
		//msg += "대표손해사정사 : 윤경수(직인생략)\n";
		msg += "\n";
		msg += "탑손해사정주식회사\n";		
		//msg += "대표이사 사장 전태옥(직인생략)\n";		
		msg += "대표이사 전태옥(직인생략)\n";

		//System.out.println(msg);
		
		//카카오(문자)발송한 내역을 DB에 저장한다.		
		paramMap.put("send_content", msg);
		
		sqlSession.update("RptIssueMapper.updateRptIssueSendContent",paramMap);
		
		Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
		String tel1 = String.valueOf(sendMap.get("tel1"));
		String tel2 = String.valueOf(sendMap.get("tel2"));
		String tel3 = String.valueOf(sendMap.get("tel3"));
		String phn = "82"+tel1.substring(1)+tel2+tel3;
		
		RestTemplate restTemplate = new RestTemplate();
		// RestTemplate 에 MessageConverter 세팅
	    List<HttpMessageConverter<?>> converters = new ArrayList<HttpMessageConverter<?>>();
	    converters.add(new FormHttpMessageConverter());
	    converters.add(new StringHttpMessageConverter(Charset.forName("UTF-8")));
		
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.add("Accept", "application/json");
		httpHeaders.add("Content-type", "application/json");
		httpHeaders.add("userId", "toplac"); //실제
		
		
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		obj.put("message_type", "at");
		obj.put("phn", phn);
		obj.put("profile", "22e9cd927d652e02daca5dc631170e021f02ae51");	//실제
		obj.put("tmplId", tmplId);
		obj.put("msg", msg);

		obj.put("smsKind", "L");
		obj.put("msgSms", msg);
		obj.put("smsSender", "0260774600");

		obj.put("smsLmsTit", "탑손해사정주식회사");
		obj.put("reserveDt", "00000000000000");
		
		//메시지 길이가 930자 이상인경우 SMS 로 전환하여 발송
		int msgLength = msg.length();
		if( msgLength > 930 ) {
			obj.put("smsOnly", "Y");
		}
		
		arr.add(obj);
		
		HttpEntity entity = new HttpEntity(arr, httpHeaders);
		
		//System.out.println(tmplId);
		
		URI uri = UriComponentsBuilder.fromHttpUrl("https://alimtalk-api.bizmsg.kr/v2/sender/send")
				.build().toUri();
				
		
		String responseEntity = restTemplate.postForObject(uri, entity, String.class);
		logger.info(responseEntity);
		
		return responseEntity;
	}    
        
	public String sendKaKaoTalk(Map<String,Object> paramMap){
		
		logger.info("======== sendKaKaoTalk ========");
				
        //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);

        //조사자 정보
        paramMap.put("user_no", rptIssueMain.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
        
        
        String suimRptType1 				= String.valueOf(rptIssueMain.get("suimRptType1"));	//템플릿 구분용
		
		String suimAcceptNo 				= String.valueOf(rptIssueMain.get("suimAcceptNo"));
		String accidentNo 					= String.valueOf(rptIssueMain.get("accidentNo"));
		String ptnrName 					= String.valueOf(rptIssueMain.get("ptnrName"));
		String insuranceNm 					= String.valueOf(rptIssueMain.get("insuranceNm"));
		String insuTerm 					= String.valueOf(rptIssueMain.get("insuTerm"));
		String insuCondition				= String.valueOf(rptIssueMain.get("insuCondition"));
		String amtSelfPayUnit 				= String.valueOf(rptIssueMain.get("amtSelfPayUnit"));
		//int amtSelfPay 						= Integer.parseInt(String.valueOf(rptIssueMain.get("amtSelfPay")));
		long amtSelfPay 						= Long.parseLong(String.valueOf(rptIssueMain.get("amtSelfPay")));
		String selfPayFlag 					= String.valueOf(rptIssueMain.get("selfPayFlag"));
		String amtCompensationLimitUnit		= String.valueOf(rptIssueMain.get("amtCompensationLimitUnit"));
		//int amtCompensationLimit 			= Integer.parseInt(String.valueOf(rptIssueMain.get("amtCompensationLimit")));		
		long amtCompensationLimit			= Long.parseLong(String.valueOf(rptIssueMain.get("amtCompensationLimit")));
		String compensationLimitFlag 		= String.valueOf(rptIssueMain.get("compensationLimitFlag"));
		String accidentDate5 				= String.valueOf(rptIssueMain.get("accidentDate5"));
		String accidentFacts 				= String.valueOf(rptIssueMain.get("accidentFacts"));
		
		String reparationLiabilityType 		= String.valueOf(rptIssue.get("reparationLiabilityType"));
		String reparationLiabilityReason 	= String.valueOf(rptIssue.get("reparationLiabilityReason"));
		String insuPaymentType 				= String.valueOf(rptIssue.get("insuPaymentType"));
		String insuPaymentReason 			= String.valueOf(rptIssue.get("insuPaymentReason"));
		String insuContent 			        = String.valueOf(rptIssue.get("insuContent"));

		String paymentBasis 				= String.valueOf(rptIssue.get("paymentBasis"));
		//int amtInsuPayment 					= Integer.parseInt(String.valueOf(rptIssueMain.get("amtInsuPayment")));
		long amtInsuPayment 					= Long.parseLong(String.valueOf(rptIssueMain.get("amtInsuPayment")));
		String amtInsuPaymentDisable		= String.valueOf(rptIssueMain.get("amtInsuPaymentDisable"));					//지급보험금 협의금액에 따름으로 표시
		
		String rptissueComment 				= String.valueOf(rptIssue.get("rptissueComment"));
		
		String userName 					= String.valueOf(reportInvgUser.get("userName"));
		String disWorkLevel 				= String.valueOf(reportInvgUser.get("disWorkLevel"));
		String handphone 					= String.valueOf(reportInvgUser.get("handphone"));

		String reparationLiability ="";
		if("1".equals(reparationLiabilityType)){
			reparationLiability = "부책";
		}else{
			reparationLiability = "면책";
		}		
		String insuPayment ="";
		if("1".equals(insuPaymentType)){
			insuPayment = "부책";
		}else{
			insuPayment = "면책";
		}		
		
/*		String tmplId = "";
		if ("3".equals(suimRptType1) || "4".equals(suimRptType1)){
			tmplId = "toplac03";
		}else if(("2".equals(suimRptType1))){
			tmplId = "toplac02";
		}else{
			tmplId = "toplac01";
		}*/
		String tmplId = "";

			//tmplId = "toplac08";
			tmplId = "toplac13";
		
		//직급이 수습인 경우 외부발송시 사원으로 변경
		String SendDisWorkLevel = "";
		if("수습".equals(disWorkLevel)) {
			SendDisWorkLevel = "사원";
		}else{
			SendDisWorkLevel = disWorkLevel;
		}		
		
		String msg = "보험업법 제189조 소정의 규정에 의거하여 아래와 같이 손해사정서를 안내합니다.\n";
		msg += "\n";
		msg += "Report No. : "+suimAcceptNo+"\n";
		msg += "\n";
		msg += "손해사정[사고번호 : "+accidentNo+"]\n";
		msg += "\n";
		msg += "1. 보험계약사항\n";
		msg += "가. 보험사명 : "+ptnrName+"\n";
		msg += "나. 보험종목 : "+insuranceNm+"\n";
		msg += "다. 보험기간 : "+insuTerm+"\n";
		msg += "라. 담보내용 : "+insuCondition+"\n";
		msg += "마. 가입금액 : "+amtCompensationLimitUnit+" "+String.format("%,d",amtCompensationLimit)+"\n";
		msg += "바. 자기부담금 : "+amtSelfPayUnit+" "+String.format("%,d",amtSelfPay)+"\n";		
		//msg += "마. 가입금액 : #{\\123,456,789}\n";		//카톡관련 수정
		//msg += "바. 자기부담금 : #{\\20,000,000}\n";		//카톡관련 수정
/*		msg += "마. 가입금액 : "+amtSelfPayUnit+" "+String.format("%,d",amtSelfPay)+"("+selfPayFlag+")\n";
		msg += "바. 자기부담금 : "+amtCompensationLimitUnit+" "+String.format("%,d",amtCompensationLimit)+"("+compensationLimitFlag+")\n";	*/	
		msg += "\n";
		msg += "2. 사고사항\n";
		msg += "가. 사고일자 : "+accidentDate5+"\n";
		msg += "나. 사고내용 : "+insuContent+"\n";
		msg += "\n";
		
/*		if ("toplac01".equals(tmplId) ){
			msg += "3. 관계법규 및 보험약관\n";		
			msg += "가. 손해배상책임 근거11111\n";
			msg += reparationLiability+" / "+reparationLiabilityReason+"\n";
			msg += "나. 보험금 지급책임 근거22222\n";
			msg += insuPayment+" / "+insuPaymentReason+"\n";
			msg += "\n";
		}else{
			msg += "3. 보험금 지급책임 근거\n";
			msg += insuPayment+" / "+insuPaymentReason+"\n";			
			msg += "\n";
		}*/
		msg += "3. 손해액 및 보험금 사정에 크게 영향을 미친 사항\n";		
		msg += reparationLiability+" / "+reparationLiabilityReason+"\n";
		msg += "\n";
				
/*		msg += "4. 손해액 및 보험금 사정에 관한 중요 근거\n";				
		msg += paymentBasis+"\n";
		msg += "\n";	*/	
		
/*		if (!"toplac03".equals(tmplId)){
			msg += "5. 지급보험금\n";				
			msg += "￦ "+String.format("%,d",amtInsuPayment)+"\n";		
			msg += "\n";		
			msg += "6. 기타사항\n";				
			msg += rptissueComment+"\n";		
			msg += "\n";
		}*/
		msg += "4. 지급보험금\n";						
		if("1".equals(amtInsuPaymentDisable)) {
			//msg += "별도 협의에 따름\n";
			msg += "단체 사고의 경우 개별 안내 금액에 따름\n";
		}else {
			msg += "￦"+String.format("%,d",amtInsuPayment)+"\n";
		}
		//msg += "\\ "+String.format("%,d",amtInsuPayment)+"\n";		//카톡관련 수정
		msg += "\n";	
		
/*		msg += "상기 내용에 대해 문의사항이 있을 경우 처리담당자에게 연락하여 주시기 바랍니다.\n";*/
/*		msg += "\n";*/
		msg += "담당자 : "+SendDisWorkLevel+" "+userName+"  (연락처 : "+handphone+")\n";			
		msg += "대표손해사정사 : 윤경수(직인생략)\n";
		msg += "\n";
		msg += "탑손해사정주식회사\n";		
		//msg += "대표이사 사장 전태옥(직인생략)\n";
		msg += "대표이사 전태옥(직인생략)\n";
		msg += "\n";		
		msg += "※본 손해사정서는 보험업법 제188조에 근거한 손해사정사의 의견으로 보험업법 제189조에 따라 발송하는 서식이며 보험사의 최종의사결과에 따라 달라질 수 있음을 양지해 주시기 바랍니다.\n";

		//System.out.println(msg);
		
		/*
		System.out.println("suimAcceptNo : "+suimAcceptNo);
		System.out.println("accidentNo : "+accidentNo);
		System.out.println("insuranceNm : "+insuranceNm);
		System.out.println("insuTerm : "+insuTerm);
		System.out.println("insuCondition : "+insuCondition);
		System.out.println("amtSelfPayUnit : "+amtSelfPayUnit);
		System.out.println("amtSelfPay : "+amtSelfPay);
		System.out.println("selfPayFlag : "+selfPayFlag);
		System.out.println("amtCompensationLimitUnit : "+amtCompensationLimitUnit);
		System.out.println("amtCompensationLimit : "+amtCompensationLimit);
		System.out.println("compensationLimitFlag : "+compensationLimitFlag);
		System.out.println("accidentDate1 : "+accidentDate1);
		System.out.println("accidentFacts : "+accidentFacts);
		System.out.println("reparationLiabilityType : "+reparationLiabilityType);
		
		System.out.println("reparationLiabilityReason : "+reparationLiabilityReason);
		System.out.println("insuPaymentType : "+insuPaymentType);
		System.out.println("insuPaymentReason : "+insuPaymentReason);
		System.out.println("paymentBasis : "+paymentBasis);
		System.out.println("amtInsuPayment : "+amtInsuPayment);
		System.out.println("rptissueComment : "+rptissueComment);
		System.out.println("userName : "+userName);
		System.out.println("disWorkLevel : "+disWorkLevel);
		System.out.println("handphone : "+handphone);
		*/
		
		//카카오(문자)발송한 내역을 DB에 저장한다.		
		paramMap.put("send_content", msg);
		
		sqlSession.update("RptIssueMapper.updateRptIssueSendContent",paramMap);
		
		Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
		String tel1 = String.valueOf(sendMap.get("tel1"));
		String tel2 = String.valueOf(sendMap.get("tel2"));
		String tel3 = String.valueOf(sendMap.get("tel3"));
		String phn = "82"+tel1.substring(1)+tel2+tel3;
		
		RestTemplate restTemplate = new RestTemplate();
		// RestTemplate 에 MessageConverter 세팅
	    List<HttpMessageConverter<?>> converters = new ArrayList<HttpMessageConverter<?>>();
	    converters.add(new FormHttpMessageConverter());
	    converters.add(new StringHttpMessageConverter(Charset.forName("UTF-8")));
		
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.add("Accept", "application/json");
		httpHeaders.add("Content-type", "application/json");
//		httpHeaders.add("userId", "PREPAY_USER"); //테스트
		httpHeaders.add("userId", "toplac"); //실제
		
//		String msg = "[카카오뮤직] 회원가입 안내\n일이삼사오육칠팔구십님, 카카오뮤직 회원이 되신 것을 환영합니다.\n\n▶신규 가입 회원 혜택\n1개월 무료 스트리밍 서비스 제공\n카카오톡 이모티콘 증정";
		
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		obj.put("message_type", "at");
		obj.put("phn", phn);
//		obj.put("profile", "89823b83f2182b1e229c2e95e21cf5e6301eed98");	//테스트
		obj.put("profile", "22e9cd927d652e02daca5dc631170e021f02ae51");	//실제
		obj.put("tmplId", tmplId);
		obj.put("msg", msg);

		obj.put("smsKind", "L");
		obj.put("msgSms", msg);
		obj.put("smsSender", "0260774600");

		obj.put("smsLmsTit", "탑손해사정주식회사");
		obj.put("reserveDt", "00000000000000");

		//메시지 길이가 930자 이상인경우 SMS 로 전환하여 발송
		int msgLength = msg.length();
		if( msgLength > 930 ) {
			obj.put("smsOnly", "Y");
		}
		
		arr.add(obj);
		
		HttpEntity entity = new HttpEntity(arr, httpHeaders);
		
		//System.out.println(tmplId);
		
//		URI uri = UriComponentsBuilder.fromHttpUrl("https://dev-alimtalk-api.bizmsg.kr:1443/v2/sender/send")
//				.build().toUri();	//테스트
		URI uri = UriComponentsBuilder.fromHttpUrl("https://alimtalk-api.bizmsg.kr/v2/sender/send")
				.build().toUri();
				
		
		String responseEntity = restTemplate.postForObject(uri, entity, String.class);
		logger.info(responseEntity);
		
		return responseEntity;
	}
		
	/**
	 * 
	 * @param paramMap
	 * @return
	 */
	public String sendKaKaoTalkMeritz(Map<String,Object> paramMap){
		
		logger.info("======== sendKaKaoTalkMeritz ========");
		
        //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBscMeritz", paramMap);
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);

        //조사자 정보
        String sUserNo = String.valueOf(rptIssueMain.get("userNo"));
        paramMap.put("user_no", sUserNo);
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);        
        
        String suimRptType1 				= String.valueOf(rptIssueMain.get("suimRptType1"));	//템플릿 구분용
		
		String suimAcceptNo 				= String.valueOf(rptIssueMain.get("suimAcceptNo"));
		String accidentNo 					= String.valueOf(rptIssueMain.get("accidentNo"));
		String ptnrName 					= String.valueOf(rptIssueMain.get("ptnrName"));
		String insuranceNm 					= String.valueOf(rptIssueMain.get("insuranceNm"));
		String insuTerm 					= String.valueOf(rptIssueMain.get("insuTerm"));
		String insuCondition				= String.valueOf(rptIssueMain.get("insuCondition"));
		String amtSelfPayUnit 				= String.valueOf(rptIssueMain.get("amtSelfPayUnit"));
		long amtSelfPay 						= Long.parseLong(String.valueOf(rptIssueMain.get("amtSelfPay")));
		String selfPayFlag 					= String.valueOf(rptIssueMain.get("selfPayFlag"));
		String amtCompensationLimitUnit		= String.valueOf(rptIssueMain.get("amtCompensationLimitUnit"));		
		long amtCompensationLimit			= Long.parseLong(String.valueOf(rptIssueMain.get("amtCompensationLimit")));
		String compensationLimitFlag 		= String.valueOf(rptIssueMain.get("compensationLimitFlag"));
		String accidentDate5 				= String.valueOf(rptIssueMain.get("accidentDate5"));
		String accidentFacts 				= String.valueOf(rptIssueMain.get("accidentFacts"));
		
		String reparationLiabilityType 		= String.valueOf(rptIssue.get("reparationLiabilityType"));
		String reparationLiabilityReason 	= String.valueOf(rptIssue.get("reparationLiabilityReason"));
		String insuPaymentType 				= String.valueOf(rptIssue.get("insuPaymentType"));
		String insuPaymentReason 			= String.valueOf(rptIssue.get("insuPaymentReason"));
		String insuContent 			        = String.valueOf(rptIssue.get("insuContent"));

		String paymentBasis 				= String.valueOf(rptIssue.get("paymentBasis"));
		long amtInsuPayment 					= Long.parseLong(String.valueOf(rptIssueMain.get("amtInsuPayment")));
		String amtInsuPaymentDisable		= String.valueOf(rptIssueMain.get("amtInsuPaymentDisable"));					//지급보험금 협의금액에 따름으로 표시
		
		String rptissueComment 				= String.valueOf(rptIssue.get("rptissueComment"));
		
		String userName 					= String.valueOf(reportInvgUser.get("userName"));
		String disWorkLevel 				= String.valueOf(reportInvgUser.get("disWorkLevel"));
		String handphone 					= String.valueOf(reportInvgUser.get("handphone"));
		
		//메리츠용 변수 시작
		String meritzAcceptNo = String.valueOf(rptIssueMain.get("meritzAcceptNo"));
		String regDate = String.valueOf(rptIssueMain.get("regDate"));
		String meritzCloseDateFmt = String.valueOf(rptIssueMain.get("meritzCloseDateFmt"));
		String meritzSuimContent = String.valueOf(rptIssueMain.get("meritzSuimContent"));
		String sPolicyNo = String.valueOf(rptIssueMain.get("policyNo"));
		String sMeritzBeneficiary = String.valueOf(rptIssueMain.get("meritzBeneficiary"));
		
		String sWriteDate = "";
	        
		Map<String,Object> writeDateMap = sqlSession.selectOne("RptIssueMapper.selectReportMeritzWriteDate", paramMap);
		
		sWriteDate = String.valueOf(writeDateMap.get("writeDateFmt"));
		
		List<Map<String, Object>> coverageInfoList = null;		//메리츠용 담보정보
		coverageInfoList = sqlSession.selectList("RptIssueMapper.selectReportMeritzCoverageInfo", paramMap);
		String sCoverageInfoListTxt = "";
		
		if( coverageInfoList.size() == 0 ) {
			sCoverageInfoListTxt = "";
		}else{
			for( int i=0; i < coverageInfoList.size(); i++) {
				sCoverageInfoListTxt += "담보명 : "+coverageInfoList.get(i).get("coverageNm")+", 가입금액 : "+String.format("%,d", coverageInfoList.get(i).get("joinPrice"))+", 청구금액 : "+String.format("%,d", coverageInfoList.get(i).get("billPrice"))+"\n";
			}
		}

		String reparationLiability ="";
		if("1".equals(reparationLiabilityType)){
			reparationLiability = "부책";
		}else{
			reparationLiability = "면책";
		}		
		String insuPayment ="";
		if("1".equals(insuPaymentType)){
			insuPayment = "부책";
		}else{
			insuPayment = "면책";
		}
		
		//손해사정서 양식 변경에 따른 수정 시작
		String regDateFmt = String.valueOf(rptIssueMain.get("regDate"));		//수임일
		String policyholderNm = String.valueOf(rptIssueMain.get("policyholderNm"));		//계약자
		String beneficiaryNm = String.valueOf(rptIssueMain.get("beneficiaryNm"));			//피보험자
		        
        Map<String, Object> lawEtcContentMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawContentInfo", paramMap);        
        
        String lawSubject = String.valueOf(lawEtcContentMap.get("law_subject"));			//관련법규
        String lawEtc = String.valueOf(lawEtcContentMap.get("law_etc"));						//관련약관

        Map<String, Object> lawReasonMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawReasonInfo", paramMap);
        Map<String, Object> lawSelContentMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawSelInfo", paramMap);        
        
        String reparationLiabilityReasonEtc = String.valueOf(lawSelContentMap.get("reparation_liability_reason_etc"));		//책임범위
        
        if( "2".equals(reparationLiabilityReasonEtc) ) {
        	reparationLiabilityReasonEtc = "동 약관 보상하지 않는 손해";
        }else if( "1".equals(reparationLiabilityReasonEtc) ) {
        	reparationLiabilityReasonEtc = "동 약관 보상하는 손해";
        }else{
        	reparationLiabilityReasonEtc = "-";
        }
        
      	//담당자 자격증(손해사정사) 정보 List 만들기 시작
        List<Map<String, Object>> certiReportUser = null;					//보고서 하단에 들어갈 담당자 정보 List
        List<Map<String, Object>> certiManagerReportUser = null;		//담당손해사정사 목록
        
        //기 종결건은 담당손해사정사가 별도 저장되어있음 (top_rpt_certi_end) 저장된 손해사정사 정보가 별도로 있는지 체크
        int nEndCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiEndCnt",paramMap);
        
        if( nEndCnt == 0 ) {			//정보가 없는 경우 실시간으로 가져온다.
        	
        	if( !"0".equals(sUserNo) ) {		//0은 미배당건        	
            	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiMemberInfo", paramMap);
            	
            	int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
            	
            	nCertiManagerCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiManagerCnt", paramMap);
            	
            	if( nCertiManagerCnt > 0 ) {			//담당손해사정사가 있는 경우
            		certiManagerReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiManagerList", paramMap);
            		for( int i=0; i < certiManagerReportUser.size(); i++) {
            			certiReportUser.add(certiManagerReportUser.get(i));		//보고서 하단에 들어갈 담당자 정보에 담당손해사정서를 추가한다.
            		}
            	}
            }
        	
        }else{								//정보가 있는 경우 top_rpt_certi_end 테이블에서 불러온다.
        	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiEndInfo", paramMap);
        }
        
        //담당자가 손해사정사인 경우 데이터 복제 (메리츠는 최소 조사자와 손해사정사가 나와야한다.)
        if( certiReportUser.size() == 1 ) {        	
        	certiReportUser.add(certiReportUser.get(0));
        }
        
        String sCertiMemberText = "";
        String sCertiStatValTemp = "";
        
        if( certiReportUser == null ) {			//미배상건
        	sCertiMemberText = "미배당건으로 담당자 정보가 없습니다.";
        }else{
        	for( int i=0; i < certiReportUser.size(); i++) {
        		/*sCertiMemberText += String.valueOf(certiReportUser.get(i).get("certi_state_val"))+" : "+String.valueOf(certiReportUser.get(i).get("user_name"))+" (직인생략)\n"+
        			"(연락처 : "+String.valueOf(certiReportUser.get(i).get("work_phone"))+")\n"+"등록번호 : " +String.valueOf(certiReportUser.get(i).get("certi_number"))+"\n\n";*/
        		
        		if( i == 0 ) {
        			sCertiStatValTemp = "조사자";
        		}else{
        			sCertiStatValTemp = String.valueOf(certiReportUser.get(i).get("certi_state_val"));
        		}
        		
				sCertiMemberText +=  sCertiStatValTemp+ " : "
						+ String.valueOf(certiReportUser.get(i).get("user_name")) + " (직인생략)" + ", 등록번호 : "
						+ String.valueOf(certiReportUser.get(i).get("certi_number")) + ", 연락처 : "
						+ String.valueOf(certiReportUser.get(i).get("work_phone")) + "\n";
        		
        	}
        }
        
		//담당자 자격증(손해사정사) 정보 List 만들기 끝
		//손해사정서 양식 변경에 따라 항목 추가 끝		

		String tmplId = "";

			tmplId = "toplac211";			//메리츠코드
		
		//직급이 수습인 경우 외부발송시 사원으로 변경
		String SendDisWorkLevel = "";
		if("수습".equals(disWorkLevel)) {
			SendDisWorkLevel = "사원";
		}else{
			SendDisWorkLevel = disWorkLevel;
		}		
		
		String msg = "보험업법 제189조 소정의 규정에 의거하여 아래와 같이 손해사정서를 안내합니다.\n";
		msg += "\n";		
		msg += "1. 수임정보\n";
		msg += "가. 접수번호 : "+meritzAcceptNo+"\n";
		msg += "나. 수임일자 : "+regDate+"\n";
		msg += "다. 종결일자 : "+meritzCloseDateFmt+"\n";
		msg += "라. 수임내용 : "+meritzSuimContent+"\n";
		msg += "\n";
		msg += "2. 계약사항\n";
		msg += "가. 증권번호 : "+sPolicyNo+"\n";
		msg += "나. 상품명 : "+insuranceNm+"\n";
		msg += "다. 계약자 : "+policyholderNm+"\n";
		msg += "라. 피보험자 : "+beneficiaryNm+"\n";
		msg += "마. 수익자 : "+sMeritzBeneficiary+"\n";
		msg += "바. 보험기간 : "+insuTerm+"\n";		
		//담보명
		msg +=sCoverageInfoListTxt;
		msg += "\n";
		
		msg += "3. 사고 및 손해조사내용\n";
		msg += insuContent+"\n";
		msg += "\n";
		
		msg += "4. 손해사정 시 적용된 관계 법규 및 약관\n";
		msg += "가. 관련법규 : "+lawSubject+"\n";
		msg += "나. 관련약관 : "+lawEtc+"\n";
		msg += "\n";
		
		msg += "5. 약관상 보험자 지급책임의 범위\n";
		msg += "가. 지급책임 : "+reparationLiability+"\n";
		msg += "나. 책임범위 : "+reparationLiabilityReasonEtc+"\n";
		msg += "\n";
		
		msg += "6. 그 밖에 손해액 및 보험금 사정에 크게 영향을 미친 사항\n";
		msg += reparationLiabilityReason+"\n";
		msg += "\n";
		
		msg += "민감정보가 포함된 내용은 피보험자의 동의가 있을 경우에만 제공됩니다.\n";
		msg += "상기 손해사정결과는 보험금 최종심사 결과와 상이할 수 있습니다.\n";
		msg += "\n";
		
		msg += "작성일자 : "+sWriteDate;
		msg += "\n";
		msg += "\n";
		
		msg += sCertiMemberText;
		
		msg += "\n";
		msg += "탑손해사정주식회사\n";		

		msg += "대표이사 전태옥(직인생략)\n";		

		//System.out.println(msg);
		
		/*
		System.out.println("suimAcceptNo : "+suimAcceptNo);
		System.out.println("accidentNo : "+accidentNo);
		System.out.println("insuranceNm : "+insuranceNm);
		System.out.println("insuTerm : "+insuTerm);
		System.out.println("insuCondition : "+insuCondition);
		System.out.println("amtSelfPayUnit : "+amtSelfPayUnit);
		System.out.println("amtSelfPay : "+amtSelfPay);
		System.out.println("selfPayFlag : "+selfPayFlag);
		System.out.println("amtCompensationLimitUnit : "+amtCompensationLimitUnit);
		System.out.println("amtCompensationLimit : "+amtCompensationLimit);
		System.out.println("compensationLimitFlag : "+compensationLimitFlag);
		System.out.println("accidentDate1 : "+accidentDate1);
		System.out.println("accidentFacts : "+accidentFacts);
		System.out.println("reparationLiabilityType : "+reparationLiabilityType);
		
		System.out.println("reparationLiabilityReason : "+reparationLiabilityReason);
		System.out.println("insuPaymentType : "+insuPaymentType);
		System.out.println("insuPaymentReason : "+insuPaymentReason);
		System.out.println("paymentBasis : "+paymentBasis);
		System.out.println("amtInsuPayment : "+amtInsuPayment);
		System.out.println("rptissueComment : "+rptissueComment);
		System.out.println("userName : "+userName);
		System.out.println("disWorkLevel : "+disWorkLevel);
		System.out.println("handphone : "+handphone);
		*/
		
		//카카오(문자)발송한 내역을 DB에 저장한다.		
		paramMap.put("send_content", msg);
		
		sqlSession.update("RptIssueMapper.updateRptIssueSendContent",paramMap);
		
		Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
		String tel1 = String.valueOf(sendMap.get("tel1"));
		String tel2 = String.valueOf(sendMap.get("tel2"));
		String tel3 = String.valueOf(sendMap.get("tel3"));
		String phn = "82"+tel1.substring(1)+tel2+tel3;
		
		RestTemplate restTemplate = new RestTemplate();
		// RestTemplate 에 MessageConverter 세팅
	    List<HttpMessageConverter<?>> converters = new ArrayList<HttpMessageConverter<?>>();
	    converters.add(new FormHttpMessageConverter());
	    converters.add(new StringHttpMessageConverter(Charset.forName("UTF-8")));
		
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.add("Accept", "application/json");
		httpHeaders.add("Content-type", "application/json");
//		httpHeaders.add("userId", "PREPAY_USER"); //테스트
		httpHeaders.add("userId", "toplac"); //실제
		
//		String msg = "[카카오뮤직] 회원가입 안내\n일이삼사오육칠팔구십님, 카카오뮤직 회원이 되신 것을 환영합니다.\n\n▶신규 가입 회원 혜택\n1개월 무료 스트리밍 서비스 제공\n카카오톡 이모티콘 증정";
		
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		obj.put("message_type", "at");
		obj.put("phn", phn);
//		obj.put("profile", "89823b83f2182b1e229c2e95e21cf5e6301eed98");	//테스트
		obj.put("profile", "22e9cd927d652e02daca5dc631170e021f02ae51");	//실제
		obj.put("tmplId", tmplId);
		obj.put("msg", msg);

		obj.put("smsKind", "L");
		obj.put("msgSms", msg);
		obj.put("smsSender", "0260774600");

		obj.put("smsLmsTit", "탑손해사정주식회사");
		obj.put("reserveDt", "00000000000000");

		//메시지 길이가 930자 이상인경우 SMS 로 전환하여 발송
		int msgLength = msg.length();
		if( msgLength > 930 ) {
			obj.put("smsOnly", "Y");
		}
		
		arr.add(obj);
		
		HttpEntity entity = new HttpEntity(arr, httpHeaders);
		
		//System.out.println(tmplId);
		
//		URI uri = UriComponentsBuilder.fromHttpUrl("https://dev-alimtalk-api.bizmsg.kr:1443/v2/sender/send")
//				.build().toUri();	//테스트
		URI uri = UriComponentsBuilder.fromHttpUrl("https://alimtalk-api.bizmsg.kr/v2/sender/send")
				.build().toUri();
				
		
		String responseEntity = restTemplate.postForObject(uri, entity, String.class);
		logger.info(responseEntity);
		
		return responseEntity;
	}
	
	/**
	 * 신규 카카오 톡 발송기능 by top3009
	 * @param paramMap
	 * @return
	 */
	public String sendKaKaoTalkNew(Map<String,Object> paramMap){
		
		logger.info("======== sendKaKaoTalkNew ========");
		
        //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);

        //조사자 정보
        String sUserNo = String.valueOf(rptIssueMain.get("userNo"));
        paramMap.put("user_no", sUserNo);
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);        
        
        String suimRptType1 				= String.valueOf(rptIssueMain.get("suimRptType1"));	//템플릿 구분용
		
		String suimAcceptNo 				= String.valueOf(rptIssueMain.get("suimAcceptNo"));
		String accidentNo 					= String.valueOf(rptIssueMain.get("accidentNo"));
		String ptnrName 					= String.valueOf(rptIssueMain.get("ptnrName"));
		String insuranceNm 					= String.valueOf(rptIssueMain.get("insuranceNm"));
		String insuTerm 					= String.valueOf(rptIssueMain.get("insuTerm"));
		String insuCondition				= String.valueOf(rptIssueMain.get("insuCondition"));
		String amtSelfPayUnit 				= String.valueOf(rptIssueMain.get("amtSelfPayUnit"));
		long amtSelfPay 						= Long.parseLong(String.valueOf(rptIssueMain.get("amtSelfPay")));
		String selfPayFlag 					= String.valueOf(rptIssueMain.get("selfPayFlag"));
		String amtCompensationLimitUnit		= String.valueOf(rptIssueMain.get("amtCompensationLimitUnit"));		
		long amtCompensationLimit			= Long.parseLong(String.valueOf(rptIssueMain.get("amtCompensationLimit")));
		String compensationLimitFlag 		= String.valueOf(rptIssueMain.get("compensationLimitFlag"));
		String accidentDate5 				= String.valueOf(rptIssueMain.get("accidentDate5"));
		String accidentFacts 				= String.valueOf(rptIssueMain.get("accidentFacts"));
		
		String reparationLiabilityType 		= String.valueOf(rptIssue.get("reparationLiabilityType"));
		String reparationLiabilityReason 	= String.valueOf(rptIssue.get("reparationLiabilityReason"));
		String insuPaymentType 				= String.valueOf(rptIssue.get("insuPaymentType"));
		String insuPaymentReason 			= String.valueOf(rptIssue.get("insuPaymentReason"));
		String insuContent 			        = String.valueOf(rptIssue.get("insuContent"));

		String paymentBasis 				= String.valueOf(rptIssue.get("paymentBasis"));
		long amtInsuPayment 					= Long.parseLong(String.valueOf(rptIssueMain.get("amtInsuPayment")));
		String amtInsuPaymentDisable		= String.valueOf(rptIssueMain.get("amtInsuPaymentDisable"));					//지급보험금 협의금액에 따름으로 표시
		
		String rptissueComment 				= String.valueOf(rptIssue.get("rptissueComment"));
		
		String userName 					= String.valueOf(reportInvgUser.get("userName"));
		String disWorkLevel 				= String.valueOf(reportInvgUser.get("disWorkLevel"));
		String handphone 					= String.valueOf(reportInvgUser.get("handphone"));

		String reparationLiability ="";
		if("1".equals(reparationLiabilityType)){
			reparationLiability = "부책";
		}else{
			reparationLiability = "면책";
		}		
		String insuPayment ="";
		if("1".equals(insuPaymentType)){
			insuPayment = "부책";
		}else{
			insuPayment = "면책";
		}
		
		//손해사정서 양식 변경에 따른 수정 시작
		String regDateFmt = String.valueOf(rptIssueMain.get("regDate"));		//수임일
		String policyholderNm = String.valueOf(rptIssueMain.get("policyholderNm"));		//계약자
		String beneficiaryNm = String.valueOf(rptIssueMain.get("beneficiaryNm"));			//피보험자
		        
        Map<String, Object> lawEtcContentMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawContentInfo", paramMap);        
        
        String lawSubject = String.valueOf(lawEtcContentMap.get("law_subject"));			//관련법규
        String lawEtc = String.valueOf(lawEtcContentMap.get("law_etc"));						//관련약관

        Map<String, Object> lawReasonMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawReasonInfo", paramMap);
        Map<String, Object> lawSelContentMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawSelInfo", paramMap);        
        
        String reparationLiabilityReasonEtc = String.valueOf(lawSelContentMap.get("reparation_liability_reason_etc"));		//책임범위
        
        if( "2".equals(reparationLiabilityReasonEtc) ) {
        	reparationLiabilityReasonEtc = "동 약관 보상하지 않는 손해";
        }else if( "1".equals(reparationLiabilityReasonEtc) ) {
        	reparationLiabilityReasonEtc = "동 약관 보상하는 손해";
        }else{
        	reparationLiabilityReasonEtc = "-";
        }
        
      	//담당자 자격증(손해사정사) 정보 List 만들기 시작
        List<Map<String, Object>> certiReportUser = null;					//보고서 하단에 들어갈 담당자 정보 List
        List<Map<String, Object>> certiManagerReportUser = null;		//담당손해사정사 목록
        
        //기 종결건은 담당손해사정사가 별도 저장되어있음 (top_rpt_certi_end) 저장된 손해사정사 정보가 별도로 있는지 체크
        int nEndCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiEndCnt",paramMap);
        
        if( nEndCnt == 0 ) {			//정보가 없는 경우 실시간으로 가져온다.
        	
        	if( !"0".equals(sUserNo) ) {		//0은 미배당건        	
            	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiMemberInfo", paramMap);
            	
            	int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
            	
            	nCertiManagerCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiManagerCnt", paramMap);
            	
            	if( nCertiManagerCnt > 0 ) {			//담당손해사정사가 있는 경우
            		certiManagerReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiManagerList", paramMap);
            		for( int i=0; i < certiManagerReportUser.size(); i++) {
            			certiReportUser.add(certiManagerReportUser.get(i));		//보고서 하단에 들어갈 담당자 정보에 담당손해사정서를 추가한다.
            		}
            	}
            }
        	
        }else{								//정보가 있는 경우 top_rpt_certi_end 테이블에서 불러온다.
        	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiEndInfo", paramMap);
        }
        
        String sCertiMemberText = "";
        
        if( certiReportUser == null ) {			//미배상건
        	sCertiMemberText = "미배당건으로 담당자 정보가 없습니다.";
        }else{
        	for( int i=0; i < certiReportUser.size(); i++) {
        		sCertiMemberText += String.valueOf(certiReportUser.get(i).get("certi_state_val"))+" : "+String.valueOf(certiReportUser.get(i).get("user_name"))+" (직인생략)\n"+
        			"(연락처 : "+String.valueOf(certiReportUser.get(i).get("work_phone"))+")\n"+"등록번호 : " +String.valueOf(certiReportUser.get(i).get("certi_number"))+"\n\n";
        	}
        }
        
		//담당자 자격증(손해사정사) 정보 List 만들기 끝
		//손해사정서 양식 변경에 따라 항목 추가 끝		

		String tmplId = "";

			//tmplId = "toplac13";
			tmplId = "toplac20";			//신규 코드
		
		//직급이 수습인 경우 외부발송시 사원으로 변경
		String SendDisWorkLevel = "";
		if("수습".equals(disWorkLevel)) {
			SendDisWorkLevel = "사원";
		}else{
			SendDisWorkLevel = disWorkLevel;
		}		
		
		String msg = "보험업법 제189조 소정의 규정에 의거하여 아래와 같이 손해사정서를 안내합니다.\n";
		msg += "\n";
		msg += "Report No. : "+suimAcceptNo+"\n";
		msg += "\n";
		msg += "손해사정[사고번호 : "+accidentNo+"]\n";
		msg += "\n";
		msg += "수임일자 : "+regDateFmt+"\n";
		msg += "\n";
		msg += "1. 보험계약사항\n";
		msg += "가. 보험사명 : "+ptnrName+"\n";
		msg += "나. 보험종목 : "+insuranceNm+"\n";		
		msg += "다. 계약자 : "+policyholderNm+"\n";
		msg += "라. 피보험자 : "+beneficiaryNm+"\n";		
		msg += "마. 보험기간 : "+insuTerm+"\n";
		msg += "바. 담보내용 : "+insuCondition+"\n";
		msg += "사. 가입금액 : "+amtCompensationLimitUnit+" "+String.format("%,d",amtCompensationLimit)+"\n";
		msg += "아. 자기부담금 : "+amtSelfPayUnit+" "+String.format("%,d",amtSelfPay)+"\n";
		msg += "\n";
		
		msg += "2. 사고사항\n";
		msg += "가. 사고일자 : "+accidentDate5+"\n";
		msg += "나. 사고내용 : "+insuContent+"\n";
		msg += "\n";
		
		msg += "3. 손해사정 시 적용된 관계 법규 및 약관\n";
		msg += "가. 관련법규 : "+lawSubject+"\n";
		msg += "나. 관련약관 : "+lawEtc+"\n";
		msg += "\n";
		
		msg += "4. 약관상 보험자 지급책임의 범위\n";
		msg += "가. 지급책임 : "+reparationLiability+"\n";
		msg += "나. 책임범위 : "+reparationLiabilityReasonEtc+"\n";
		msg += "\n";
		
		msg += "5. 손해액 및 보험금 사정에 크게 영향을 미친 사항\n";
		msg += reparationLiabilityReason+"\n";		
		msg += "\n";			

		msg += "6. 지급보험금\n";						
		if("1".equals(amtInsuPaymentDisable)) {
			msg += "단체 사고의 경우 개별 안내 금액에 따름\n";
		}else {
			msg += "￦"+String.format("%,d",amtInsuPayment)+"\n";
		}
		msg += "\n";
		
		msg += sCertiMemberText;

		//msg += "담당자 : "+SendDisWorkLevel+" "+userName+"  (연락처 : "+handphone+")\n";			
		//msg += "대표손해사정사 : 윤경수(직인생략)\n";
		
		msg += "\n";
		msg += "탑손해사정주식회사\n";		

		msg += "대표이사 전태옥(직인생략)\n";
		msg += "\n";		
		msg += "※본 손해사정서는 보험업법 제188조에 근거한 손해사정사의 의견으로 보험업법 제189조에 따라 발송하는 서식이며 보험사의 최종의사결과에 따라 달라질 수 있음을 양지해 주시기 바랍니다.\n";

		//System.out.println(msg);
		
		/*
		System.out.println("suimAcceptNo : "+suimAcceptNo);
		System.out.println("accidentNo : "+accidentNo);
		System.out.println("insuranceNm : "+insuranceNm);
		System.out.println("insuTerm : "+insuTerm);
		System.out.println("insuCondition : "+insuCondition);
		System.out.println("amtSelfPayUnit : "+amtSelfPayUnit);
		System.out.println("amtSelfPay : "+amtSelfPay);
		System.out.println("selfPayFlag : "+selfPayFlag);
		System.out.println("amtCompensationLimitUnit : "+amtCompensationLimitUnit);
		System.out.println("amtCompensationLimit : "+amtCompensationLimit);
		System.out.println("compensationLimitFlag : "+compensationLimitFlag);
		System.out.println("accidentDate1 : "+accidentDate1);
		System.out.println("accidentFacts : "+accidentFacts);
		System.out.println("reparationLiabilityType : "+reparationLiabilityType);
		
		System.out.println("reparationLiabilityReason : "+reparationLiabilityReason);
		System.out.println("insuPaymentType : "+insuPaymentType);
		System.out.println("insuPaymentReason : "+insuPaymentReason);
		System.out.println("paymentBasis : "+paymentBasis);
		System.out.println("amtInsuPayment : "+amtInsuPayment);
		System.out.println("rptissueComment : "+rptissueComment);
		System.out.println("userName : "+userName);
		System.out.println("disWorkLevel : "+disWorkLevel);
		System.out.println("handphone : "+handphone);
		*/
		
		//카카오(문자)발송한 내역을 DB에 저장한다.		
		paramMap.put("send_content", msg);
		
		sqlSession.update("RptIssueMapper.updateRptIssueSendContent",paramMap);
		
		Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
		String tel1 = String.valueOf(sendMap.get("tel1"));
		String tel2 = String.valueOf(sendMap.get("tel2"));
		String tel3 = String.valueOf(sendMap.get("tel3"));
		String phn = "82"+tel1.substring(1)+tel2+tel3;
		
		RestTemplate restTemplate = new RestTemplate();
		// RestTemplate 에 MessageConverter 세팅
	    List<HttpMessageConverter<?>> converters = new ArrayList<HttpMessageConverter<?>>();
	    converters.add(new FormHttpMessageConverter());
	    converters.add(new StringHttpMessageConverter(Charset.forName("UTF-8")));
		
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.add("Accept", "application/json");
		httpHeaders.add("Content-type", "application/json");
//		httpHeaders.add("userId", "PREPAY_USER"); //테스트
		httpHeaders.add("userId", "toplac"); //실제
		
//		String msg = "[카카오뮤직] 회원가입 안내\n일이삼사오육칠팔구십님, 카카오뮤직 회원이 되신 것을 환영합니다.\n\n▶신규 가입 회원 혜택\n1개월 무료 스트리밍 서비스 제공\n카카오톡 이모티콘 증정";
		
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		obj.put("message_type", "at");
		obj.put("phn", phn);
//		obj.put("profile", "89823b83f2182b1e229c2e95e21cf5e6301eed98");	//테스트
		obj.put("profile", "22e9cd927d652e02daca5dc631170e021f02ae51");	//실제
		obj.put("tmplId", tmplId);
		obj.put("msg", msg);

		obj.put("smsKind", "L");
		obj.put("msgSms", msg);
		obj.put("smsSender", "0260774600");

		obj.put("smsLmsTit", "탑손해사정주식회사");
		obj.put("reserveDt", "00000000000000");

		//메시지 길이가 930자 이상인경우 SMS 로 전환하여 발송
		int msgLength = msg.length();
		if( msgLength > 930 ) {
			obj.put("smsOnly", "Y");
		}
		
		arr.add(obj);
		
		HttpEntity entity = new HttpEntity(arr, httpHeaders);
		
		//System.out.println(tmplId);
		
//		URI uri = UriComponentsBuilder.fromHttpUrl("https://dev-alimtalk-api.bizmsg.kr:1443/v2/sender/send")
//				.build().toUri();	//테스트
		URI uri = UriComponentsBuilder.fromHttpUrl("https://alimtalk-api.bizmsg.kr/v2/sender/send")
				.build().toUri();
				
		
		String responseEntity = restTemplate.postForObject(uri, entity, String.class);
		logger.info(responseEntity);
		
		return responseEntity;
	}
	
	public String sendKaKaoPiTalk(Map<String,Object> paramMap){
		
		logger.info("======== sendKaKaoPiTalk ========");
		
        //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);

        //조사자 정보
        String sUserNo = String.valueOf(rptIssueMain.get("userNo"));
        paramMap.put("user_no", rptIssueMain.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
                
        String suimRptType1 				= String.valueOf(rptIssueMain.get("suimRptType1"));	//템플릿 구분용
		
		String suimAcceptNo 				= String.valueOf(rptIssueMain.get("suimAcceptNo"));
		String accidentNo 					= String.valueOf(rptIssueMain.get("accidentNo"));
		String ptnrName 					= String.valueOf(rptIssueMain.get("ptnrName"));
		String insuranceNm 					= String.valueOf(rptIssueMain.get("insuranceNm"));
		String insuTerm 					= String.valueOf(rptIssueMain.get("insuTerm"));
		String insuCondition				= String.valueOf(rptIssueMain.get("insuCondition"));
		String amtSelfPayUnit 				= String.valueOf(rptIssueMain.get("amtSelfPayUnit"));
		long amtSelfPay 						= Long.parseLong(String.valueOf(rptIssueMain.get("amtSelfPay")));
		String selfPayFlag 					= String.valueOf(rptIssueMain.get("selfPayFlag"));
		String amtCompensationLimitUnit		= String.valueOf(rptIssueMain.get("amtCompensationLimitUnit"));
		long amtCompensationLimit			= Long.parseLong(String.valueOf(rptIssueMain.get("amtCompensationLimit")));
		String compensationLimitFlag 		= String.valueOf(rptIssueMain.get("compensationLimitFlag"));
		String accidentDate5 				= String.valueOf(rptIssueMain.get("accidentDate5"));
		String accidentFacts 				= String.valueOf(rptIssueMain.get("accidentFacts"));
		
		String reparationLiabilityType 		= String.valueOf(rptIssue.get("reparationLiabilityType"));
		String reparationLiabilityReason 	= String.valueOf(rptIssue.get("reparationLiabilityReason"));
		String insuPaymentType 				= String.valueOf(rptIssue.get("insuPaymentType"));
		String insuPaymentReason 			= String.valueOf(rptIssue.get("insuPaymentReason"));
		String insuContent 			        = String.valueOf(rptIssue.get("insuContent"));

		String paymentBasis 				= String.valueOf(rptIssue.get("paymentBasis"));
		long amtInsuPayment 					= Long.parseLong(String.valueOf(rptIssueMain.get("amtInsuPayment")));
		String amtInsuPaymentDisable		= String.valueOf(rptIssueMain.get("amtInsuPaymentDisable"));					//지급보험금 협의금액에 따름으로 표시
		
		String rptissueComment 				= String.valueOf(rptIssue.get("rptissueComment"));
		
		String userName 					= String.valueOf(reportInvgUser.get("userName"));
		String disWorkLevel 				= String.valueOf(reportInvgUser.get("disWorkLevel"));
		String handphone 					= String.valueOf(reportInvgUser.get("handphone"));

		String reparationLiability ="";
		if("1".equals(reparationLiabilityType)){
			reparationLiability = "부책";
		}else{
			reparationLiability = "면책";
		}		
		String insuPayment ="";
		if("1".equals(insuPaymentType)){
			insuPayment = "부책";
		}else{
			insuPayment = "면책";
		}
		
		//손해사정서 양식 변경에 따른 수정 시작
		String regDateFmt = String.valueOf(rptIssueMain.get("regDate"));		//수임일
		String policyholderNm = String.valueOf(rptIssueMain.get("policyholderNm"));		//계약자
		String beneficiaryNm = String.valueOf(rptIssueMain.get("beneficiaryNm"));			//피보험자
		        
        Map<String, Object> lawEtcContentMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawContentInfo", paramMap);        
        
        String lawSubject = String.valueOf(lawEtcContentMap.get("law_subject"));			//관련법규
        String lawEtc = String.valueOf(lawEtcContentMap.get("law_etc"));						//관련약관

        Map<String, Object> lawReasonMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawReasonInfo", paramMap);
        Map<String, Object> lawSelContentMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueLawSelInfo", paramMap);        
        
        String reparationLiabilityReasonEtc = String.valueOf(lawSelContentMap.get("reparation_liability_reason_etc"));		//책임범위
        
        if( "2".equals(reparationLiabilityReasonEtc) ) {
        	reparationLiabilityReasonEtc = "동 약관 보상하지 않는 손해";
        }else if( "1".equals(reparationLiabilityReasonEtc) ) {
        	reparationLiabilityReasonEtc = "동 약관 보상하는 손해";
        }else{
        	reparationLiabilityReasonEtc = "-";
        }
        
      	//담당자 자격증(손해사정사) 정보 List 만들기 시작
        List<Map<String, Object>> certiReportUser = null;					//보고서 하단에 들어갈 담당자 정보 List
        List<Map<String, Object>> certiManagerReportUser = null;		//담당손해사정사 목록
        
        //기 종결건은 담당손해사정사가 별도 저장되어있음 (top_rpt_certi_end) 저장된 손해사정사 정보가 별도로 있는지 체크
        int nEndCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiEndCnt",paramMap);
        
        if( nEndCnt == 0 ) {			//정보가 없는 경우 실시간으로 가져온다.
        	
        	if( !"0".equals(sUserNo) ) {		//0은 미배당건        	
            	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiMemberInfo", paramMap);
            	
            	int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
            	
            	nCertiManagerCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiManagerCnt", paramMap);
            	
            	if( nCertiManagerCnt > 0 ) {			//담당손해사정사가 있는 경우
            		certiManagerReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiManagerList", paramMap);
            		for( int i=0; i < certiManagerReportUser.size(); i++) {
            			certiReportUser.add(certiManagerReportUser.get(i));		//보고서 하단에 들어갈 담당자 정보에 담당손해사정서를 추가한다.
            		}
            	}
            }
        	
        }else{								//정보가 있는 경우 top_rpt_certi_end 테이블에서 불러온다.
        	certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiEndInfo", paramMap);
        }

		String sCertiMemberText = "";

		if( certiReportUser == null ) {			//미배상건
			sCertiMemberText = "미배당건으로 담당자 정보가 없습니다.";
		}else{
			for( int i=0; i < certiReportUser.size(); i++) {
				sCertiMemberText += String.valueOf(certiReportUser.get(i).get("certi_state_val"))+" : "+String.valueOf(certiReportUser.get(i).get("user_name"))+" (직인생략)\n"+
					"(연락처 : "+String.valueOf(certiReportUser.get(i).get("work_phone"))+")\n"+"등록번호 : " +String.valueOf(certiReportUser.get(i).get("certi_number"))+"\n\n";
			}
		}
		//담당자 자격증(손해사정사) 정보 List 만들기 끝

		String tmplId = "";

		//tmplId = "toplac18";
		//tmplId = "toplac181";
		//tmplId = "toplac1811";			//20250715 신규 수정 템플릿
		tmplId = "toplac1812";			//20250716 신규 수정 템플릿
		
		//직급이 수습인 경우 외부발송시 사원으로 변경
		String SendDisWorkLevel = "";
		if("수습".equals(disWorkLevel)) {
			SendDisWorkLevel = "사원";
		}else{
			SendDisWorkLevel = disWorkLevel;
		}
		
		String msg = "보험업법 제189조 소정의 규정에 의거하여 아래와 같이 손해사정서를 안내합니다.\n";
		msg += "\n";
		msg += "Report No. : "+suimAcceptNo+"\n";
		msg += "\n";
		msg += "손해사정[사고번호 : "+accidentNo+"]\n";
		msg += "\n";
		msg += "1. 보험계약사항\n";
		msg += "가. 보험사명 : "+ptnrName+"\n";
		msg += "나. 보험종목 : "+insuranceNm+"\n";
		msg += "다. 보험기간 : "+insuTerm+"\n";
		msg += "라. 담보내용 : "+insuCondition+"\n";
		msg += "마. 가입금액 : "+amtCompensationLimitUnit+" "+String.format("%,d",amtCompensationLimit)+"\n";
		//msg += "바. 자기부담금 : "+amtSelfPayUnit+" "+String.format("%,d",amtSelfPay)+"\n";			
		msg += "\n";
		msg += "2. 사고사항\n";
		msg += "가. 사고일자 : "+accidentDate5+"\n";
		msg += "나. 사고내용 : "+insuContent+"\n";
		msg += "\n";
		
		msg += "3. 손해사정 시 적용된 관계 법규 및 약관\n";
		msg += "가. 관련법규 : "+lawSubject+"\n";
		msg += "나. 관련약관 : "+lawEtc+"\n";
		msg += "\n";
		
		msg += "4. 약관상 보험자 지급책임의 범위\n";
		msg += "가. 지급책임 : "+reparationLiability+"\n";
		msg += "나. 책임범위 : "+reparationLiabilityReasonEtc+"\n";
		msg += "\n";
		
		msg += "5. 손해액 및 보험금 사정에 크게 영향을 미친 사항\n";
		msg += reparationLiabilityReason+"\n";		
		msg += "\n";			

		msg += "6. 지급보험금\n";						
		if("1".equals(amtInsuPaymentDisable)) {
			msg += "단체 사고의 경우 개별 안내 금액에 따름\n";
		}else {
			msg += "￦"+String.format("%,d",amtInsuPayment)+"\n";
		}
		msg += "\n";
		
		msg += sCertiMemberText;

		//msg += "담당자 : "+SendDisWorkLevel+" "+userName+"  (연락처 : "+handphone+")\n";			
		//msg += "대표손해사정사 : 윤경수(직인생략)\n";
		msg += "\n";
		msg += "탑손해사정주식회사\n";		

		msg += "대표이사 전태옥(직인생략)\n";
		msg += "\n";		
		msg += "※본 손해사정서는 보험업법 제188조에 근거한 손해사정사의 의견으로 보험업법 제189조에 따라 발송하는 서식이며 보험사의 최종의사결과에 따라 달라질 수 있음을 양지해 주시기 바랍니다.\n";
		
		//카카오(문자)발송한 내역을 DB에 저장한다.		
		paramMap.put("send_content", msg);
		
		sqlSession.update("RptIssueMapper.updateRptIssueSendContent",paramMap);
		
		Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
		String tel1 = String.valueOf(sendMap.get("tel1"));
		String tel2 = String.valueOf(sendMap.get("tel2"));
		String tel3 = String.valueOf(sendMap.get("tel3"));
		String phn = "82"+tel1.substring(1)+tel2+tel3;
		
		RestTemplate restTemplate = new RestTemplate();
		// RestTemplate 에 MessageConverter 세팅
	    List<HttpMessageConverter<?>> converters = new ArrayList<HttpMessageConverter<?>>();
	    converters.add(new FormHttpMessageConverter());
	    converters.add(new StringHttpMessageConverter(Charset.forName("UTF-8")));
		
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.add("Accept", "application/json");
		httpHeaders.add("Content-type", "application/json");
		httpHeaders.add("userId", "toplac"); //실제
		
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		obj.put("message_type", "at");
		obj.put("phn", phn);
		obj.put("profile", "22e9cd927d652e02daca5dc631170e021f02ae51");
		obj.put("tmplId", tmplId);
		obj.put("msg", msg);

		obj.put("smsKind", "L");
		obj.put("msgSms", msg);
		obj.put("smsSender", "0260774600");

		obj.put("smsLmsTit", "탑손해사정주식회사");
		obj.put("reserveDt", "00000000000000");
		
		//메시지 길이가 930자 이상인경우 SMS 로 전환하여 발송
		int msgLength = msg.length();
		if( msgLength > 930 ) {
			obj.put("smsOnly", "Y");
		}
		
		arr.add(obj);
		
		HttpEntity entity = new HttpEntity(arr, httpHeaders);

		URI uri = UriComponentsBuilder.fromHttpUrl("https://alimtalk-api.bizmsg.kr/v2/sender/send")
				.build().toUri();
				
		
		String responseEntity = restTemplate.postForObject(uri, entity, String.class);
		logger.info(responseEntity);
		
		return responseEntity;
	}
	
	public String sendKaKaoAblTalk(Map<String,Object> paramMap){
		
		logger.info("======== sendKaKaoAblTalk ========");
		
        //기본정보 가져오기
        Map<String, Object> rptIssueMain = sqlSession.selectOne("RptIssueMapper.selectReportBsc", paramMap);
        Map<String, Object> rptIssue = sqlSession.selectOne("RptIssueMapper.selectRptIssue", paramMap);

        //조사자 정보
        paramMap.put("user_no", rptIssueMain.get("userNo"));
        Map<String, Object> reportInvgUser = sqlSession.selectOne("SuimReportMapper.selectUserInfo", paramMap);
        
        
        String suimRptType1 				= String.valueOf(rptIssueMain.get("suimRptType1"));	//템플릿 구분용
		
		String suimAcceptNo 				= String.valueOf(rptIssueMain.get("suimAcceptNo"));
		String accidentNo 					= String.valueOf(rptIssueMain.get("accidentNo"));
		String ptnrName 					= String.valueOf(rptIssueMain.get("ptnrName"));
		String insuranceNm 					= String.valueOf(rptIssueMain.get("insuranceNm"));
		String insuTerm 					= String.valueOf(rptIssueMain.get("insuTerm"));
		String insuCondition				= String.valueOf(rptIssueMain.get("insuCondition"));
		String amtSelfPayUnit 				= String.valueOf(rptIssueMain.get("amtSelfPayUnit"));		
		long amtSelfPay 						= Long.parseLong(String.valueOf(rptIssueMain.get("amtSelfPay")));
		String selfPayFlag 					= String.valueOf(rptIssueMain.get("selfPayFlag"));
		String amtCompensationLimitUnit		= String.valueOf(rptIssueMain.get("amtCompensationLimitUnit"));
		long amtCompensationLimit			= Long.parseLong(String.valueOf(rptIssueMain.get("amtCompensationLimit")));
		String compensationLimitFlag 		= String.valueOf(rptIssueMain.get("compensationLimitFlag"));
		String accidentDate5 				= String.valueOf(rptIssueMain.get("accidentDate5"));
		String accidentFacts 				= String.valueOf(rptIssueMain.get("accidentFacts"));
		
		String reparationLiabilityType 		= String.valueOf(rptIssue.get("reparationLiabilityType"));
		String reparationLiabilityReason 	= String.valueOf(rptIssue.get("reparationLiabilityReason"));
		String insuPaymentType 				= String.valueOf(rptIssue.get("insuPaymentType"));
		String insuPaymentReason 			= String.valueOf(rptIssue.get("insuPaymentReason"));
		String insuContent 			        = String.valueOf(rptIssue.get("insuContent"));

		String paymentBasis 				= String.valueOf(rptIssue.get("paymentBasis"));
		long amtInsuPayment 					= Long.parseLong(String.valueOf(rptIssueMain.get("amtInsuPayment")));
		
		String rptissueComment 				= String.valueOf(rptIssue.get("rptissueComment"));
		
		String userName 					= String.valueOf(reportInvgUser.get("userName"));
		String disWorkLevel 				= String.valueOf(reportInvgUser.get("disWorkLevel"));
		String handphone 					= String.valueOf(reportInvgUser.get("handphone"));
		
		String report_comment = String.valueOf(rptIssue.get("reportComment")).replace("<br/>", "");		//ABL 용 추가
		String report_reference = String.valueOf(rptIssue.get("reportReference")).replace("<br/>", "");		//ABL 용 추가

		String reparationLiability ="";
		if("1".equals(reparationLiabilityType)){
			reparationLiability = "부책";
		}else{
			reparationLiability = "면책";
		}		
		String insuPayment ="";
		if("1".equals(insuPaymentType)){
			insuPayment = "부책";
		}else{
			insuPayment = "면책";
		}		

		String tmplId = "";

			//tmplId = "toplac12";
			//tmplId = "toplac14";
			tmplId = "toplac141";
		
		//직급이 수습인 경우 외부발송시 사원으로 변경
		String SendDisWorkLevel = "";
		if("수습".equals(disWorkLevel)) {
			SendDisWorkLevel = "사원";
		}else{
			SendDisWorkLevel = disWorkLevel;
		}
		
		//담당자 자격증(손해사정사) 정보 List 만들기 시작
		String sUserNo = String.valueOf(rptIssueMain.get("userNo"));
		List<Map<String, Object>> certiReportUser = null;					//보고서 하단에 들어갈 담당자 정보 List
		List<Map<String, Object>> certiManagerReportUser = null;		//담당손해사정사 목록

		//기 종결건은 담당손해사정사가 별도 저장되어있음 (top_rpt_certi_end) 저장된 손해사정사 정보가 별도로 있는지 체크
		int nEndCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiEndCnt",paramMap);

		if( nEndCnt == 0 ) {			//정보가 없는 경우 실시간으로 가져온다.
			
			if( !"0".equals(sUserNo) ) {		//0은 미배당건        	
			certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiMemberInfo", paramMap);
			
			int nCertiManagerCnt = 0;		//담당 손해사정사인원 수
			
			nCertiManagerCnt = sqlSession.selectOne("RptIssueMapper.selectReportCertiManagerCnt", paramMap);
			
			if( nCertiManagerCnt > 0 ) {			//담당손해사정사가 있는 경우
				certiManagerReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiManagerList", paramMap);
				for( int i=0; i < certiManagerReportUser.size(); i++) {
					certiReportUser.add(certiManagerReportUser.get(i));		//보고서 하단에 들어갈 담당자 정보에 담당손해사정서를 추가한다.
				}
			}
		    }
			
		}else{								//정보가 있는 경우 top_rpt_certi_end 테이블에서 불러온다.
			certiReportUser = sqlSession.selectList("RptIssueMapper.selectReportCertiEndInfo", paramMap);
		}

		String sCertiMemberText = "";

		if( certiReportUser == null ) {			//미배상건
			sCertiMemberText = "미배당건으로 담당자 정보가 없습니다.";
		}else{
			for( int i=0; i < certiReportUser.size(); i++) {
				sCertiMemberText += String.valueOf(certiReportUser.get(i).get("certi_state_val"))+" : "+String.valueOf(certiReportUser.get(i).get("user_name"))+" (직인생략)\n"+
					"(연락처 : "+String.valueOf(certiReportUser.get(i).get("work_phone"))+")\n"+"등록번호 : " +String.valueOf(certiReportUser.get(i).get("certi_number"))+"\n\n";
			}
		}
		//담당자 자격증(손해사정사) 정보 List 만들기 끝
		
		String msg = "보험업법 제189조 소정의 규정에 의거하여 아래와 같이 손해사정서를 안내합니다.\n";
		msg += "\n";
		msg += "Report No. : "+suimAcceptNo+"\n";
		msg += "\n";
		msg += "손해사정[사고번호 : "+accidentNo+"]\n";
		msg += "\n";
		msg += "1. 보험계약사항\n";
		msg += "가. 보험사명 : "+ptnrName+"\n";
		msg += "나. 보험종목 : "+insuranceNm+"\n";
		msg += "다. 보험기간 : "+insuTerm+"\n";
		msg += "라. 담보내용 : "+insuCondition+"\n";
		msg += "마. 가입금액 : "+amtCompensationLimitUnit+" "+String.format("%,d",amtCompensationLimit)+"\n";
		msg += "바. 자기부담금 : "+amtSelfPayUnit+" "+String.format("%,d",amtSelfPay)+"\n";			
		msg += "\n";
		msg += "2. 사고사항\n";
		msg += "가. 사고일자 : "+accidentDate5+"\n";
		msg += "나. 사고내용 : "+insuContent+"\n";
		msg += "\n";		
		msg += "3. 손해사정의견\n";		
		msg += "가. 손해사정 의견 : "+report_comment+"\n";
		msg += "나. 관련 참고사항 : "+report_reference+"\n";
		msg += "\n";
		
		msg += sCertiMemberText;
		//msg += "담당자 : "+SendDisWorkLevel+" "+userName+"  (연락처 : "+handphone+")\n";			
		//msg += "대표손해사정사 : 윤경수(직인생략)\n";
		
		msg += "\n";
		msg += "탑손해사정주식회사\n";		
		msg += "대표이사 전태옥(직인생략)\n";
		//msg += "대표이사 사장 전태옥(직인생략)\n";
		msg += "\n";		
		msg += "※본 손해사정서는 보험업법 제188조에 근거한 손해사정사의 의견으로 보험업법 제189조에 따라 발송하는 서식이며 보험사의 최종의사결과에 따라 달라질 수 있음을 양지해 주시기 바랍니다.\n";

		//카카오(문자)발송한 내역을 DB에 저장한다.		
		paramMap.put("send_content", msg);
		
		sqlSession.update("RptIssueMapper.updateRptIssueSendContent",paramMap);		
		
		Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);
		String tel1 = String.valueOf(sendMap.get("tel1"));
		String tel2 = String.valueOf(sendMap.get("tel2"));
		String tel3 = String.valueOf(sendMap.get("tel3"));
		String phn = "82"+tel1.substring(1)+tel2+tel3;
		
		RestTemplate restTemplate = new RestTemplate();
		// RestTemplate 에 MessageConverter 세팅
	    List<HttpMessageConverter<?>> converters = new ArrayList<HttpMessageConverter<?>>();
	    converters.add(new FormHttpMessageConverter());
	    converters.add(new StringHttpMessageConverter(Charset.forName("UTF-8")));
		
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.add("Accept", "application/json");
		httpHeaders.add("Content-type", "application/json");
//		httpHeaders.add("userId", "PREPAY_USER"); //테스트
		httpHeaders.add("userId", "toplac"); //실제
		
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		obj.put("message_type", "at");
		obj.put("phn", phn);
//		obj.put("profile", "89823b83f2182b1e229c2e95e21cf5e6301eed98");	//테스트
		obj.put("profile", "22e9cd927d652e02daca5dc631170e021f02ae51");	//실제
		obj.put("tmplId", tmplId);
		obj.put("msg", msg);

		obj.put("smsKind", "L");
		obj.put("msgSms", msg);
		obj.put("smsSender", "0260774600");

		obj.put("smsLmsTit", "탑손해사정주식회사");
		obj.put("reserveDt", "00000000000000");
		
		//메시지 길이가 930자 이상인경우 SMS 로 전환하여 발송
		int msgLength = msg.length();
		if( msgLength > 930 ) {
			obj.put("smsOnly", "Y");
		}
		
		arr.add(obj);
		
		HttpEntity entity = new HttpEntity(arr, httpHeaders);
		
		//System.out.println(tmplId);
		
//		URI uri = UriComponentsBuilder.fromHttpUrl("https://dev-alimtalk-api.bizmsg.kr:1443/v2/sender/send")
//				.build().toUri();	//테스트
		URI uri = UriComponentsBuilder.fromHttpUrl("https://alimtalk-api.bizmsg.kr/v2/sender/send")
				.build().toUri();
				
		
		String responseEntity = restTemplate.postForObject(uri, entity, String.class);
		logger.info(responseEntity);
		
		return responseEntity;
	}
    
	
	//문자메시지 전송결과 확인 by top3009	
    public String sendKakaoResult( String sMsgid ) { 			//param : SMS 발송시 사용한 msgid    	
    	String rMsg = "";		//상태값 조회결과
    	
    	//Header 셋팅
    	HttpHeaders httpHeaders = new HttpHeaders();		
		httpHeaders.add("userId", "toplac"); //실제
		
		String sProfile = "22e9cd927d652e02daca5dc631170e021f02ae51";
		
		URI uri = UriComponentsBuilder.fromHttpUrl("https://alimtalk-api.bizmsg.kr/v2/sender/report").queryParam("profile", sProfile).queryParam("msgid", sMsgid).build().toUri();		
		
    	ResponseEntity<String> response = new RestTemplate().exchange(uri, HttpMethod.GET, new HttpEntity(httpHeaders), String.class);
    	
    	rMsg = response.getBody();
    	
    	JsonParser jsonParser = new JsonParser();    	
    	JsonObject jsonObject = (JsonObject) jsonParser.parse(rMsg);
    	
    	rMsg = jsonObject.get("message").toString();				//json의 메시지 값
    	
    	rMsg = rMsg.replace("\"","");
    	
		/*
		 * JsonArray jsonArr = new JsonParser().parse(rMsg).getAsJsonArray(); JsonObject
		 * obj = (JsonObject) jsonArr.get(0); rMsg = obj.get("message").getAsString();
		 * 
		 * System.out.println("rMsg="+rMsg);
		 */
    	
    	return rMsg;
    }
        
    //발송 메시지 상태 체크 테스트 코드 by top3009
		
	/*
	 * public static void main(String[] args) { System.out.println("SMS Send Chk");
	 * 
	 * SuimRptBscReportIssueController test = new SuimRptBscReportIssueController();
	 * 
	 * String sRet = test.sendKakaoResult("WEB20190207132502784323");
	 * 
	 * System.out.println("sRet="+sRet); }
	 */
    
	/*
	 * //스플릿 테스트 public static void main(String[] args) { String sTemp =
	 * "기계|1000|2000|500|100|100"; String [] sRet = sTemp.split("\\|"); for(int i=0;
	 * i< sRet.length; i++) { System.out.println(i+" : "+sRet[i]); } }
	 */
}
