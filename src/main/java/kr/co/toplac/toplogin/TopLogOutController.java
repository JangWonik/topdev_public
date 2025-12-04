package kr.co.toplac.toplogin;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class TopLogOutController {
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final Logger logger = LoggerFactory.getLogger(TopLogOutController.class);
	
	/*로그아웃 처리*/
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String logoutProcess(HttpSession session) {
		
		logger.info("TOP Logout");
		String userNo = (String) session.getAttribute("user_no_Session");
		sqlSession.update("TopLoginMapper.udtLogoutDup",userNo);
		
		session.invalidate();

		return "top_login/top_login";
	}
}
