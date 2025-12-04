package kr.co.toplac.cmm.util;

import kr.co.toplac.cmm.service.UserSessionService;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

public class SessionUtil {

	static UserSessionService userSessionService;

	public UserSessionService getUserDetailsService() {
		return userSessionService;
	}

	public void setUserSessionService(UserSessionService userSessionService) {
		SessionUtil.userSessionService = userSessionService;
	}
	
	/**
	 * 인증된 사용자객체를 VO형식으로 가져온다.
	 * @return Object - 사용자 ValueObject
	 */
	public static Object getAuthenticatedUser() {
		return userSessionService.getAuthenticatedUser("mbrVo_Session");
	}

	/**
	 * 인증된 사용자의 권한 정보를 가져온다.
	 *
	 * @return List - 사용자 권한정보 목록
	 */
	public static Object getAuthorities() {
		return userSessionService.getAuthorities("mbrAuthVo_Session");
	}

	/**
	 * 인증된 사용자 여부를 체크한다.
	 * @return Boolean - 인증된 사용자 여부(TRUE / FALSE)
	 */
	public static Boolean isAuthenticatedUser() {
		return userSessionService.isAuthenticated("mbrVo_Session");
	}	

	
    /**
     * attribute 설정 method
     *
     * @param String  attribute key name
     * @param Object  attribute obj
     * @return void
     */
    public static void setAttribute(String name, Object object) {
        RequestContextHolder.getRequestAttributes().setAttribute(name, object, RequestAttributes.SCOPE_SESSION);
    }
    
    /**
     * attribute 값을 가져 오기 위한 method
     *
     * @param String  attribute key name
     * @return Object attribute obj
     */    
    public static Object getAttribute(String name) {
        return (Object) RequestContextHolder.getRequestAttributes().getAttribute(name, RequestAttributes.SCOPE_SESSION);
    }    
    
    /**
     * 설정한 attribute 삭제
     *
     * @param String  attribute key name
     * @return void
     */
    public static void removeAttribute(String name) {
        RequestContextHolder.getRequestAttributes().removeAttribute(name, RequestAttributes.SCOPE_SESSION);
    }
    
    /**
     * session id
     *
     * @param void
     * @return String SessionId 값
     */
    public static String getSessionId() {
        return RequestContextHolder.getRequestAttributes().getSessionId();
    }

	/**
	 * error message 설정 method
	 *
	 * @param String  ErrorMessage
	 * @return void
	 */
	public static void setMessage(String message) throws RuntimeException {
		try {
			setAttribute("sERRORMSG",message);
		}catch (Exception e){
			throw new RuntimeException(e.getMessage());
		}
	}
	
}
