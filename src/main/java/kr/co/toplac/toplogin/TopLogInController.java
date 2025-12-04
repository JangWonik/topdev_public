package kr.co.toplac.toplogin;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URI;
import java.nio.charset.Charset;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.converter.FormHttpMessageConverter;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.util.UriComponentsBuilder;

import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.sysadm.TopDivPopupVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;
import kr.co.toplac.util.enc.EncryptUtil;

@Controller
public class TopLogInController {
	

	@Autowired
	private SqlSession sqlSession;
	
	private static final Logger logger = LoggerFactory.getLogger(TopLogInController.class);
	
	/*로그인 페이지 호출 => TopMainController 의 루트 경로로 변경  */
	/*@RequestMapping(value = "loginPage", method = RequestMethod.GET)
	public String loginPage(Model model) {
		
		logger.info("TOP Login");

		return "top_login/top_login";
	}*/
	
	//user_no DB 체크
	@RequestMapping(value = "loginIdChk", method = RequestMethod.POST)
	public void loginIdChk(Model model, String resid_no, HttpSession session, HttpServletResponse response, String residNoForTwoChannel, String channelSel) {
		logger.info("TOP ID CHK");
		
		String jumin_no1 = resid_no.substring(0,6);
		String jumin_no2 = resid_no.substring(6,resid_no.length());
		
		HashMap<String,String> juminMap = new HashMap<String,String>();
		juminMap.put("jumin_no1", jumin_no1);
		juminMap.put("jumin_no2", jumin_no2);
		String user_no = sqlSession.selectOne("TopLoginMapper.chkMbr", juminMap);
		
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		//System.out.println("user_no : " +user_no);
		if(user_no == null) user_no = "0";
		
		//사용자 사번으로 세션을 인증전까지 생성하지 않는다 by top3009
		//session.setAttribute("cert_user_no", user_no);
		//System.out.println("sess_user : "+session.getAttribute("cert_user_no"));
 		out.print(user_no);
	}
	
	/**
	 * 핸드폰 인증번호 유효성 체크
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping("/loginIdAuthChk")
    @ResponseBody
    public  Map<String, Object> loginIdAuthChk(HttpServletRequest request){
		
		logger.info("========= loginIdAuthChk =========");
        
        Map<String, Object> resultMap = new HashMap<>();
        //===============================================
        //	파라미터 체크
        //===============================================
        
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String user_no = StringUtil.null2blank(request.getParameter("user_no"));
        String auth_no = StringUtil.null2blank(request.getParameter("auth_no"));
        
        if ("".equals(user_no) || "".equals(auth_no)){
        	resultMap.put("RSLT_CODE", "999");
            return resultMap;
        }        
        
        int nCnt = sqlSession.selectOne("TopLoginMapper.chkMbrByMobileAuth", paramMap);
        
        if( nCnt == 0 ) {
        	resultMap.put("RSLT_CODE", "111");          //입력 값 틀림
        }else{
        	resultMap.put("RSLT_CODE", "000");			//정상처리            
        }
        
        return resultMap;
    }
    
    @RequestMapping("/loginIdPwChk")
    @ResponseBody
    public Map<String, Object> loginIdPwChk(HttpServletRequest request, HttpSession session){
        
        Map<String, Object> resultMap = new HashMap<>();
        //===============================================
        //	파라미터 체크
        //===============================================
        
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String userId = StringUtil.null2blank(request.getParameter("user_id"));
        String userPw = StringUtil.null2blank(request.getParameter("user_pw"));
        
        if ("".equals(userId) || "".equals(userPw)){
            resultMap.put("RSLT_CODE", "999");
            return resultMap;
        }
        
        //===============================================
        //	비즈니스 로직 체크
        //===============================================
        Map<String, Object> userInfo = sqlSession.selectOne("TopLoginMapper.chkMbrByUserId", paramMap);
        
        // 사용자가 있는지 체크
        if (userInfo == null){
            resultMap.put("RSLT_CODE", "999");
            return resultMap;
        }
        
        //핸드폰 인증을위해 핸드폰 정보 셋팅
        String sUserNo = String.valueOf(userInfo.get("userNo"));
        String sMobile = userInfo.get("handphone").toString();
        String sUserName = userInfo.get("userName").toString();
        String sAuthNo = "";
        String responseMsg = "";   
        
        String isPass = userInfo.get("isPass").toString();
        
        //===============================================
        // 비밀번호가 같은지, 5회이상 틀렸는지 체크
        //===============================================
        userPw = EncryptUtil.getEncryptSHA256(userPw);
        //System.out.println("userPw:["+userPw+"]");
        
        String dUserPw = String.valueOf(userInfo.get("userPwd"));
        String invalidCntStr = String.valueOf(userInfo.get("invalidPwdCnt"));
        int invalidCnt = Integer.parseInt(invalidCntStr);
        
        if ( invalidCnt < 5 ){
        	if (!userPw.equals(dUserPw)){
        		invalidCnt = invalidCnt+1;
        		sqlSession.update("TopLoginMapper.udtInvalidPwdCnt",userId);
        		
    			resultMap.put("INVALID_PWD_CNT", invalidCnt);
    			resultMap.put("RSLT_CODE", "901");
        		return resultMap;
        	}
        }else{
        	resultMap.put("RSLT_CODE", "905");
        	//비밀번호 초기화를 위해 사번과 이름을 넣어준다.
        	resultMap.put("RSLT_USER_NO", sUserNo);
        	resultMap.put("RSLT_USER_NAME",sUserName);
        	resultMap.put("RSLT_MOBILE_NO", sMobile);
        	return resultMap;
        }
        
        //===============================================
        // 비밀번호 변경기간이 90일이 지났는지 체크
        //===============================================
        Long pwdChgCnt = (Long) userInfo.get("pwdChgCnt"); 
        if (pwdChgCnt >= 90){
        	resultMap.put("RSLT_CODE", "910");
        	resultMap.put("USER_NO", sUserNo );
        	resultMap.put("RSLT_RESID_NO", String.valueOf(userInfo.get("juminNo")));
        	return resultMap;
        }
        
        //핸드폰 정보가 없는 경우
        if( "0".equals(sMobile)) {
        	resultMap.put("RSLT_CODE", "911");
    		return resultMap;
        }else if( "1".equals(isPass) ) {			//2차인증 사용안하는 경우 (바로 로그인 처리) // by  oniku
        	resultMap.put("RSLT_CODE", "777");
        	session.setAttribute("cert_user_no", sUserNo);        	
    		return resultMap;    		
        }else{
        	sAuthNo = CommonUtils.numberGen(6, 1);		//중복허용된 6자리 난수 생성
        	//System.out.println( "nAuthNo : "+sAuthNo );
        	
        	//기존등록키가 있다면 삭제한다.
        	sqlSession.delete("TopLoginMapper.deleteMobileAuth", sUserNo);
        	
        	//신규인증정보를 추가한다.
        	paramMap.put("user_no", sUserNo);
        	paramMap.put("auth_no", sAuthNo);
        	paramMap.put("user_name", sUserName);
        	paramMap.put("mobile", sMobile);
        	//CommonUtils.printMap(paramMap);
        	sqlSession.insert("TopLoginMapper.insertMobileAuth", paramMap);
        	
        	//인증번호 발송 (테스트 시 제외)
        	responseMsg = sendLoginKaKaoTalk(paramMap);
        	//logger.info("sendLoginKaKaoTalk : "+ responseMsg);
        	
        }
        
        //사용자 사번으로 세션을 인증전까지 생성하지 않는다 by top3009
        //session.setAttribute("cert_user_no", String.valueOf(userInfo.get("userNo")));
        
        resultMap.put("RSLT_CODE", "0");
        resultMap.put("RSLT_RESID_NO", String.valueOf(userInfo.get("juminNo")));
        resultMap.put("RSLT_MOBILE_NO", sMobile);
        resultMap.put("RSLT_USER_NO", sUserNo);
        resultMap.put("RSLT_USER_NAME",sUserName);
        resultMap.put("RSLT_SEND_RESLUT", responseMsg);
        return resultMap;
    }
    
    /**
     * 비밀번호 초기화 Modal
     */
    @RequestMapping(value="/loginPassResetModal")
    public String loginPassResetModal(HttpServletRequest request, Model model) {
    	
    	logger.info("========= loginPassResetModal =========");
    	    	
    	String sUrl = "top_login/login_pass_reset_modal";
    			
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
    	model.addAttribute("user_no", paramMap.get("user_no").toString());    	
    	model.addAttribute("user_name", paramMap.get("user_name").toString());
    	model.addAttribute("user_mobile", paramMap.get("user_mobile").toString());
    	 	
    	return sUrl;
    }
    
    /**
     * 인증번호 입력하기 Modal
     */
    @RequestMapping(value="/loginAuthUserModal")
    public String loginAuthUserModal(HttpServletRequest request, Model model) {
    	
    	logger.info("========= loginAuthUserModal =========");
    	    	
    	String sUrl = "top_login/login_auth_user_modal";
    			
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
    	//CommonUtils.printMap(paramMap);
    	
    	model.addAttribute("user_no", paramMap.get("user_no").toString());
    	model.addAttribute("resid_no", paramMap.get("resid_no").toString());
    	model.addAttribute("user_name", paramMap.get("user_name").toString());
    	 	
    	return sUrl;
    }
    
    /**
     * 핸드폰 인증번호 발송 by top3009 
     * 
     */
    public String sendLoginKaKaoTalk(Map<String,Object> paramMap){				//로그인 인증 번호 발송
    	
    	String tmplId = "toplacAuth";			//로그인 인증 템플릿 코드
    	
    	String sMobile = paramMap.get("mobile").toString();
    	String sUserName = paramMap.get("user_name").toString();
    	String sAuthNo = paramMap.get("auth_no").toString();
    	
    	String phn = "82"+sMobile.substring(1);
    	
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
		
		String msg = sUserName+"님 반갑습니다.\n";
		msg += "\n";
		msg += "인증번호 : "+sAuthNo+"\n";
		msg += "\n";
		msg += "인증번호를 입력해주세요.";
		
		//System.out.println(msg);
		
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
		
		arr.add(obj);
    	
    	HttpEntity entity = new HttpEntity(arr, httpHeaders);
		URI uri = UriComponentsBuilder.fromHttpUrl("https://alimtalk-api.bizmsg.kr/v2/sender/send").build().toUri();    	
    	String responseEntity = restTemplate.postForObject(uri, entity, String.class);
		logger.info(responseEntity);
		
		return responseEntity;
    }
	
	/*주민 번호 입력 후 검증 동작*/
	@RequestMapping(value = "Main", method = RequestMethod.POST)
	public String loginProcess(Model model, String resid_no, HttpSession session, String residNoForTwoChannel, String channelSel) {
		
		logger.info("TOP Login Process");
		
		//if(channelSel.equals("2")){
			//resid_no = residNoForTwoChannel;
		//}
		
		/*새로 고침으로 들어 올 경우 세션 유효 시 로그인 체크 안함 */
		if(session.getAttribute("mbrVo_Session") == null){
			if(resid_no.length() == 13){
//				if(resid_no.length() == 2){
				
				String jumin_no1 = resid_no.substring(0,6);
				String jumin_no2 = resid_no.substring(6,resid_no.length());
//				String jumin_no1 = resid_no.substring(0,1);
//				String jumin_no2 = resid_no.substring(1,resid_no.length());
				
				
				HashMap<String,String> juminMap = new HashMap<String,String>();
				juminMap.put("jumin_no1", jumin_no1);
				juminMap.put("jumin_no2", jumin_no2);
//				juminMap.put("jumin_no2", EncryptUtil.getEncryptSHA256(jumin_no2));
				
				String user_no = sqlSession.selectOne("TopLoginMapper.chkMbr", juminMap);
				
				if( (user_no != null) && (user_no != "") ){
					/* 공인인증 모듈 호출 */
					session.setAttribute("cert_user_no", user_no);
					return "redirect:/succLogin";//공인인증서 수정
					//return "util_nice/TopNiceCert";
				}else{
					/*로그인 페이지로 이동 : 검출된 유저번호 없음 */
					model.addAttribute("loginFail", "loginFail");
					return "top_login/top_login";
				} // end else		
			}else{
				/*로그인 페이지로 이동 : 주민번호 자리수 불만족*/
				model.addAttribute("loginFail", "loginFail");
				return "top_login/top_login";
			} //end else
		}else{
			/*새로고침으 들어올 경우*/
//			return "top_main/top_main_index";
			return "redirect:/topMainIndex";				
		}
	}
	
	
	/* 공인인증서 검증 실패 */
	@RequestMapping(value = "failLogin", method = RequestMethod.GET)
	public String failLogin(Model model, HttpSession session) {
		model.addAttribute("loginFail", "loginFail");
		return "top_login/top_login";
	}
	
	/* 별도의 인증이 필요없이 바로 로그인 처리 */	
	@RequestMapping(value = "succLoginByPass")
	public String succLoginByPass( Model model, HttpSession session, HttpServletRequest request) {		

		String user_no = (String)session.getAttribute("cert_user_no");
		
		if( user_no == null ) {
			logger.info("succLoginByPass Error : no Session");
			session.invalidate();
			return "top_login/top_login";
		}
		
		/*멤버 정보 추출*/
		TopMbrBscVO mbrVo = sqlSession.selectOne("TopLoginMapper.getMbr", user_no);		
		
		//1종 센터장인 경우 소속센터 아이디를 추가해준다.
		if( "14".equals(mbrVo.getWork_type_cd()) ) {			
			String team_group_order = mbrVo.getTeam_group_order();
			String temp_center_id = sqlSession.selectOne("TopLoginMapper.getCenterIdByTeamGroupOrder", team_group_order);			
			mbrVo.setCenter_team_id(temp_center_id);			
		}
		
		//비밀번호 오입력 초기화
		sqlSession.update("TopLoginMapper.udtInvalidPwdCntZero",user_no);
		
		/*이전 비밀번호 변경일로부터 현재까지 일수 계산 : 90일이 지나면 로그인 후 알람 주기*/
		long timeDiffer = 0;
		String timeDifferForPwAlert = "0";
		if(mbrVo.getPwd_date() != null){
			
			Date beginDate = null;
			Date endDate = null;
			
			Calendar cal = Calendar.getInstance();    
			cal.setTime(new Date());    		
			
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
			String today = df.format(cal.getTime());
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			
			try {
				endDate = formatter.parse(today);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			try {
				beginDate = formatter.parse(mbrVo.getPwd_date());
			} catch (ParseException e) {
				e.printStackTrace();
			}						

			timeDiffer = (endDate.getTime() - beginDate.getTime())/(24*3600*1000);
			timeDifferForPwAlert = Long.toString(timeDiffer);
		}

		/*각종 정보 셋팅 : mbrVo
		 * 사원 user_no
		 * 사원 아이디
		 * 사원 이름
		 * 사원 팀코드
		 * 사원 직위한글명
		 * 사원 직위 코드
		 * 사원 직책 한글명
		 * 사원 직책 코드
		 * 사원 입사일
		 * 사원 이메일
		 * 사원 재직상태
		 * */
		//로그인 아이피 정보 세션에추가 20200529 by top3009
		/*ip 얻기 시작*/
		HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();		
		String ip = req.getHeader("X-FORWARDED-FOR");
		
		if (ip == null){
			ip = req.getRemoteAddr(); 
		}
		
		mbrVo.setUser_ip(ip);
		
		session.setAttribute("title_Session", "탑손해사정 주식회사");
		session.setAttribute("mbrVo_Session", mbrVo);
		session.setAttribute("user_no_Session", mbrVo.getUser_no());
		
		/*권한 정보 셋팅 : mbrAuthVo*/
		TopMbrAuthVO mbrAuthVo = sqlSession.selectOne("TopLoginMapper.getAuth", user_no);
		
		session.setAttribute("mbrAuthVo_Session", mbrAuthVo); // 사원 권한 정보 세션 입력
		
		HashMap<String,String> logMap = new HashMap<String,String>();
		logMap.put("user_no", user_no);
		logMap.put("ip", ip);
		
		/*출입 로그 저장*/
		int logInsResult = sqlSession.insert("TopLoginMapper.insLoginLog", logMap);
		
		/*로그 입력 완료 시 메인 페이지 호출*/
		if(logInsResult > 0){
		}

		return "redirect:/topMainIndex?fromLogInPage=1&timeDifferForPwAlert="+timeDifferForPwAlert+"&firstLogin=0";
	}
	
	/* 공인인증서 검증 성공 후 메인화면 호출 */
	@RequestMapping(value = "succLogin")
	public String succLogin(Model model, HttpSession session, String juminNo, HttpServletRequest request) {
		/*ip 얻기 시작*/
		HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		String ip = req.getHeader("X-FORWARDED-FOR");
		
		String user_no = (String) session.getAttribute("cert_user_no");
		
		if( user_no == null ) {
			String EncodeData = request.getParameter("EncodeData") != null ? request.getParameter("EncodeData") : "";
			
			if( EncodeData == null || "".equals(EncodeData) ) {
				logger.info("succLogin Error : no Session");
				session.invalidate();
				return "top_login/top_login";
			}else {			    
				String jumin_no1 = EncodeData.substring(0,6);
				String jumin_no2 = EncodeData.substring(6,13);		
				
				HashMap<String,String> juminMap = new HashMap<String,String>();
				juminMap.put("jumin_no1", jumin_no1);
				juminMap.put("jumin_no2", jumin_no2);
				
				user_no = sqlSession.selectOne("TopLoginMapper.chkMbr", juminMap);
				
				session.setAttribute("cert_user_no", user_no);
			}
		}
		
		if (ip == null){
			ip = req.getRemoteAddr(); 
		}
		/*ip 얻기 끝*/
		//String user_no = (String) session.getAttribute("cert_user_no");		
		
		if( user_no == null ) {
			logger.info("succLogin Error : no Session");
			session.invalidate();
			return "top_login/top_login";
		}
		
//		String jumin_no1 = juminNo.substring(0,6);
//		String jumin_no2 = juminNo.substring(6,juminNo.length());
		
//		HashMap<String,String> juminMap = new HashMap<String,String>();
//		juminMap.put("jumin_no1", jumin_no1);
//		juminMap.put("jumin_no2", jumin_no2);
//		String user_no = sqlSession.selectOne("TopLoginMapper.chkMbr", juminMap);		
		
		//중복 로그인 체크
		List<TopLogInDuplicationVO> loginDup =  sqlSession.selectList("TopLoginMapper.chkLoginDup", user_no);
		
		int loginState = 0;
		String dupIp = "";
		
		if ( !loginDup.isEmpty() ){
			loginState = loginDup.get(0).getLogin_state();
			dupIp = loginDup.get(0).getIp_addr();
		}
		String firstLogin = "0";
		if ( (loginState == 0) ){//DB에 값이 없으면
			firstLogin = "1";
			HashMap<String,String> dupMap = new HashMap<String,String>();
			dupMap.put("userNo", user_no);
			dupMap.put("ip", ip);
			dupMap.put("loginState", "1");
			
			//로그인시 user_no 를 보안 세션 cert_user_no 로 가져오지 못하는경우 이중로그인 테이블에 넣지 않는다.
			if( user_no != null ) {
				sqlSession.insert("TopLoginMapper.insLoginDup",dupMap);
			}
				
		}else if (loginState == 1){//DB가 로그인 상태이면
			
			if (dupIp.equals(ip)){
				HashMap<String,String> dupMap = new HashMap<String,String>();
				dupMap.put("userNo", user_no);
				dupMap.put("ipAddr", ip);
				sqlSession.update("TopLoginMapper.udtLoginDup",dupMap);
			}else{
				/*로그인 페이지로 이동 : 검출된 유저번호 없음 */
				model.addAttribute("loginFail", "duplication");
				return "top_login/top_login";
			}
		
		}else if (loginState == 2){//DB가 로그아웃 상태이면
			firstLogin = "1";
			HashMap<String,String> dupMap = new HashMap<String,String>();
			dupMap.put("userNo", user_no);
			dupMap.put("ipAddr", ip);
			sqlSession.update("TopLoginMapper.udtLoginDup",dupMap);
		}

		/*멤버 정보 추출*/
		TopMbrBscVO mbrVo = sqlSession.selectOne("TopLoginMapper.getMbr", user_no);
		
		//1종 센터장인 경우 소속센터 아이디를 추가해준다.
		if( "14".equals(mbrVo.getWork_type_cd()) ) {			
			String team_group_order = mbrVo.getTeam_group_order();
			String temp_center_id = sqlSession.selectOne("TopLoginMapper.getCenterIdByTeamGroupOrder", team_group_order);			
			mbrVo.setCenter_team_id(temp_center_id);			
		}		
		
		//비밀번호 오입력 초기화
		sqlSession.update("TopLoginMapper.udtInvalidPwdCntZero",user_no);
		
		/*이전 비밀번호 변경일로부터 현재까지 일수 계산 : 90일이 지나면 로그인 후 알람 주기*/
		long timeDiffer = 0;
		String timeDifferForPwAlert = "0";
		if(mbrVo.getPwd_date() != null){
			
			Date beginDate = null;
			Date endDate = null;
			
			Calendar cal = Calendar.getInstance();    
			cal.setTime(new Date());    		
			
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
			String today = df.format(cal.getTime());
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			
			try {
				endDate = formatter.parse(today);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			try {
				beginDate = formatter.parse(mbrVo.getPwd_date());
			} catch (ParseException e) {
				e.printStackTrace();
			}						

			timeDiffer = (endDate.getTime() - beginDate.getTime())/(24*3600*1000);
			timeDifferForPwAlert = Long.toString(timeDiffer);
		}

		/*각종 정보 셋팅 : mbrVo
		 * 사원 user_no
		 * 사원 아이디
		 * 사원 이름
		 * 사원 팀코드
		 * 사원 직위한글명
		 * 사원 직위 코드
		 * 사원 직책 한글명
		 * 사원 직책 코드
		 * 사원 입사일
		 * 사원 이메일
		 * 사원 재직상태
		 * */
		//로그인 아이피 정보 세션에추가 20200529 by top3009
		mbrVo.setUser_ip(ip);
		
		session.setAttribute("title_Session", "탑손해사정 주식회사");
		session.setAttribute("mbrVo_Session", mbrVo);
		session.setAttribute("user_no_Session", mbrVo.getUser_no());
		
		/*권한 정보 셋팅 : mbrAuthVo*/
		TopMbrAuthVO mbrAuthVo = sqlSession.selectOne("TopLoginMapper.getAuth", user_no);
		
		session.setAttribute("mbrAuthVo_Session", mbrAuthVo); // 사원 권한 정보 세션 입력
		
		HashMap<String,String> logMap = new HashMap<String,String>();
		logMap.put("user_no", user_no);
		logMap.put("ip", ip);
		
		/*출입 로그 저장*/
		int logInsResult = sqlSession.insert("TopLoginMapper.insLoginLog", logMap);
		
		//사용한 모바일 인증키 삭제
		sqlSession.delete("TopLoginMapper.deleteMobileAuth",user_no);

		return "redirect:/topMainIndex?fromLogInPage=1&timeDifferForPwAlert="+timeDifferForPwAlert+"&firstLogin="+firstLogin;
	}

	/*패스워드 검증 입력 후 검증 동작*/
	@RequestMapping(value = "loginPassWordCheck", method = RequestMethod.POST)
	public void loginPassWordCheck(String residNoForTwoChannel, String passWdForTwoChannel, String topIdForTwoChannel, HttpSession session, PrintWriter out) {
		
		logger.info("loginPassWordCheck");
		
		/*새로 고침으로 들어 올 경우 세션 유효 시 로그인 체크 안함 */
		if(session.getAttribute("user_no_Session") == null){

			//if(resid_no.length() == 13){
			if(residNoForTwoChannel.length() == 2){
				
				//String jumin_no1 = resid_no.substring(0,6);
				//String jumin_no2 = resid_no.substring(6,resid_no.length());
				String jumin_no1 = residNoForTwoChannel.substring(0,1);
				String jumin_no2 = residNoForTwoChannel.substring(1,residNoForTwoChannel.length());
				
				
				HashMap<String,String> juminMap = new HashMap<String,String>();
				juminMap.put("jumin_no1", jumin_no1);
				juminMap.put("jumin_no2", EncryptUtil.getEncryptSHA256(jumin_no2));
				juminMap.put("topId", topIdForTwoChannel);
				juminMap.put("passWord", EncryptUtil.getEncryptSHA256(passWdForTwoChannel));
				
				int userExist = sqlSession.selectOne("TopLoginMapper.chkMbrForFirstStep", juminMap);
				
				if(userExist > 0){
					out.print(1);
				}else{
					/*검출된 유저번호 없음 : 주민번호 or 패스워드 오류 */	
					out.print(0);
				}
			}
		}
		
	}

	@RequestMapping(value = "top_login")
	public String login(Model model){
		
		//로그인 전 팝업 사용을 체크한다.		
		TopDivPopupVO popupVO = new TopDivPopupVO();
		
		//사용여부 (is_use = 1:로그인 전)
		popupVO.setIs_use("1");
		
		Calendar cal = Calendar.getInstance() ;
		
		//week_flag (요일 : 일, 월, 화..토, 1 ~ 7)		
		int nWeekflag = cal.DAY_OF_WEEK - 1;
		int nDay = cal.get(cal.DATE);		
		
		popupVO.setWeek_flag(nWeekflag);
		
		//month_flag (오늘 날짜)
		popupVO.setMonth_flag(nDay);
		
		//현시점에 해당하는 팝업만 가져오기
		List<TopDivPopupVO> divPopupList = sqlSession.selectList("CodeDicInsMapper.selectDivPopupListChk", popupVO);
		
		model.addAttribute("divPopupList", divPopupList);
		
		return "top_login/top_login";
	}
}
