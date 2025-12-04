package kr.co.toplac.cmm.service;

import java.util.List;

/**
 * Created by kohyeonseok on 2017. 3. 20..
 */
public interface UserSessionService {
    /**
     * 인증된 사용자객체를 VO형식으로 가져온다.
     * @return Object - 사용자 ValueObject
     */
    public Object getAuthenticatedUser(String sesseionKey);

    /**
     * 인증된 사용자의 권한 정보를 가져온다.
     * 예) [ROLE_ADMIN, ROLE_USER, ROLE_A, ROLE_B, ROLE_RESTRICTED, IS_AUTHENTICATED_FULLY, IS_AUTHENTICATED_REMEMBERED, IS_AUTHENTICATED_ANONYMOUSLY]
     * @return List - 사용자 권한정보 목록
     */
    public Object getAuthorities(String sessionKey);

    /**
     * 인증된 사용자 여부를 체크한다.
     * @return Boolean - 인증된 사용자 여부(TRUE / FALSE)
     */
    public Boolean isAuthenticated(String sessionKey);
}
