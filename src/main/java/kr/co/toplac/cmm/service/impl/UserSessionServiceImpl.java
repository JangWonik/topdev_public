package kr.co.toplac.cmm.service.impl;

import kr.co.toplac.cmm.service.UserSessionService;
import kr.co.toplac.topteam.TopMbrBscVO;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by kohyeonseok on 2017. 3. 20..
 */
public class UserSessionServiceImpl implements UserSessionService {

    @Override
    public Object getAuthenticatedUser(String sessionKey) {

        if (RequestContextHolder.getRequestAttributes() == null) {
            return null;
        }

        return RequestContextHolder.getRequestAttributes().getAttribute(sessionKey, RequestAttributes.SCOPE_SESSION);
    }


    @Override
    public Object getAuthorities(String sessionKey) {

        if (RequestContextHolder.getRequestAttributes() == null) {
            return null;
        }

        return RequestContextHolder.getRequestAttributes().getAttribute(sessionKey, RequestAttributes.SCOPE_SESSION);
    }




    @Override
    public Boolean isAuthenticated(String sessionKey) {

        if (RequestContextHolder.getRequestAttributes() == null) {
            return false;
        } else {

            if (RequestContextHolder.getRequestAttributes().getAttribute(sessionKey, RequestAttributes.SCOPE_SESSION) == null) {
                return false;
            } else {
                return true;
            }
        }

    }
}
