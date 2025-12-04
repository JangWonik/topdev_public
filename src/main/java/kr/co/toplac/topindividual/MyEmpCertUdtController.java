package kr.co.toplac.topindividual;

import java.io.PrintWriter;

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
public class MyEmpCertUdtController {
	
	private static final Logger logger = LoggerFactory.getLogger(MyEmpCertUdtController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	/*
	 * ***************************************
	 * Method ID : myCertUdt
	 * Method Name :  myCertUdt
	 * Description : 취소할 재직 증명서 정보 추출
	 * 
	 * Author : 이선형
	 * Date : 20160418
	 * ***************************************
	 * */
	@RequestMapping(value = "myCertUdt", method = RequestMethod.GET)
	public String myCertUdt(Model model, String serial_no, HttpSession session) {
		
		String user_no = "";
		
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(session.getAttribute("user_no_Session") ==null ||mbrAuthVo == null){
			logger.info("myCertUdt - no session ");
			session.invalidate();
			return "top_login/top_login";
		}
		
		user_no = (String) session.getAttribute("user_no_Session");
		
		TopMbrBscVO myInfoVo = sqlSession.selectOne("MyEmpCertUdt.getMyInfo", user_no);
		TopCertVO myCertForUdt = sqlSession.selectOne("MyEmpCertUdt.certForUdt", serial_no);
		
		model.addAttribute("myInfoVo", myInfoVo);
		model.addAttribute("myCertForUdt", myCertForUdt);
		
		return "top_individual/my_emp_cert_udt";
	}
	
	/*
	 * ***************************************
	 * Method ID : myCertUdtTb
	 * Method Name :  myCertUdtTb
	 * Description : 선택 재직 증명서 취소 처리
	 * 
	 * Author : 이선형
	 * Date : 20160418
	 * ***************************************
	 * */
	@RequestMapping(value = "myCertUdtTb", method = RequestMethod.POST)
	public void myCertUdtTb(Model model, PrintWriter out, TopCertVO certVo) {

		int result = sqlSession.update("MyEmpCertUdt.udtMyCert",certVo);
		
		out.print(result);
		
	}
}
