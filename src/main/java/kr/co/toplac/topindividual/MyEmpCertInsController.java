package kr.co.toplac.topindividual;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.topteam.TopCertVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;

@Controller
public class MyEmpCertInsController {
	
	private static final Logger logger = LoggerFactory.getLogger(MyEmpCertInsController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "myCertIns", method = RequestMethod.GET)
	public String myCertIns(Model model, HttpSession session) {
		
		String user_no = "";
		
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || session.getAttribute("user_no_Session") ==null){
			logger.info("myCertIns - no session ");
			session.invalidate();
			return "top_login/top_login";
		}
		
		user_no = (String) session.getAttribute("user_no_Session");
		
		TopMbrBscVO myInfoVo = sqlSession.selectOne("MyEmpCertIns.getMyInfo", user_no);
		
		/*현재날짜계산 + 2 */
		Calendar cal = Calendar.getInstance();    
		cal.setTime(new Date());    
		cal.add(Calendar.DATE, 2);    
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
		String dayAfter = df.format(cal.getTime());    
		
		model.addAttribute("myInfoVo", myInfoVo);
		model.addAttribute("dayAfter", dayAfter);
		
		return "top_individual/my_emp_cert_ins";
	}
	
	@RequestMapping(value = "myCertInsTb", method = RequestMethod.POST)
	public void myCertInsTb(Model model, PrintWriter out, TopCertVO certVo) {
		
		int result = sqlSession.insert("MyEmpCertIns.insNewCert", certVo);
		
		out.print(result);
		
	}
}
