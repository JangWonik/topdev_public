package kr.co.toplac.cmm.interceptor;

import kr.co.toplac.topteam.TopMbrBscVO;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by kohyeonseok on 2017. 3. 16..
 */
public class UserLoginInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        try {

            //System.out.println("URL:["+request.getRequestURI()+"]");
            //User 세션key를 가진 정보가 널일경우 로그인페이지로 이동
            //LoginVO loginVO = (LoginVO)SessionUtil.getAuthenticatedUser();
            //TopMbrBscVO loginVO = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
            TopMbrBscVO loginVO = (TopMbrBscVO)RequestContextHolder.getRequestAttributes().getAttribute("mbrVo_Session", RequestAttributes.SCOPE_SESSION);

            if (loginVO == null) {

                String ajaxCall = (String) request.getHeader("AJAX");

                if ("true".equals(ajaxCall)){
                    response.sendError(901);
                }else{
                    String returnURI = request.getRequestURI();
                    response.sendRedirect("/top_login");
                }

                return false;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        //User 세션key 존재시 통과
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        super.postHandle(request, response, handler, modelAndView);
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        super.afterCompletion(request, response, handler, ex);
    }
}
