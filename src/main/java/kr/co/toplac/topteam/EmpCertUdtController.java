package kr.co.toplac.topteam;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class EmpCertUdtController {
	
	private static final Logger logger = LoggerFactory.getLogger(MbrStatListController.class);

	@Autowired
	private SqlSession sqlSession;
	
	/*
	 * ***************************************
	 * Method ID : CertUdt
	 * Method Name :  CertUdt
	 * Description : 재직증명 관리 에서 수정 팝업창 Controller
	 * 번호 1 - 직원정보 테이블 추출
	 * 번호 2 - 재직증명서 테이블 추출
	 * 
	 * Author : 이선형
	 * Date : 20160412
	 * ***************************************
	 * */
	@RequestMapping(value = "CertUdt", method = RequestMethod.GET)
	public String CertUdt(Model model, String serial_no, String user_no, HttpSession session) {

		/*번호 1*/
		TopMbrBscVO InfoVo = sqlSession.selectOne("EmpCertUdt.getInfo", user_no);
		
		/*번호 2*/
		TopCertVO CertForUdt = sqlSession.selectOne("EmpCertUdt.certForUdt", serial_no);
		
		model.addAttribute("InfoVo", InfoVo);
		model.addAttribute("CertForUdt", CertForUdt);
		
		return "top_team/emp_cert_udt";
	}
	
	
	/*
	 * ***************************************
	 * Method ID : CertUdtTb
	 * Method Name :  CertUdtTb
	 * Description : 재직증명 관리 개별(팝업에서) 수정
	 * 
	 * Author : 이선형
	 * Date : 20160414
	 * ***************************************
	 * */
	@RequestMapping(value = "CertUdtTb", method = RequestMethod.POST)
	public void CertUdtTb(Model model, PrintWriter out, TopCertVO certVo) {

		int result = sqlSession.update("EmpCertUdt.udtCert",certVo);
		
		out.print(result);
		
	}
	
	
	/**************************************재직증명 일괄 수정 시작****************************************/
	
	/*
	 * ***************************************
	 * Method ID : CertUdtTbApp
	 * Method Name :  CertUdtTbApp
	 * Description : 재직증명 관리 에서 일괄 승인
	 * 번호 1 - 재직증명서  상태값을 2로 업데이트
	 * 
	 * Author : 이선형
	 * Date : 20160412
	 * ***************************************
	 * */
	@RequestMapping(value = "CertUdtTbApp", method = RequestMethod.POST)
	public void CertUdtTbApp(Model model, PrintWriter out, TopCertVO certVo, @RequestParam(value="checkArray[]") List<String> arrayParams) {
		
		int result = 0;
		
		/*번호 1*/
		for (int i = 0; i < arrayParams.size(); i++) {
			
			sqlSession.update("EmpCertUdt.udtCertApp",arrayParams.get(i));
			result++;
		}
		
		if(result == arrayParams.size()){
			out.print(1);	
		}else{
			out.print(0);
		}
		
	}
	
	/*
	 * ***************************************
	 * Method ID : CertUdtTbDen
	 * Method Name :  CertUdtTbDen
	 * Description : 재직증명 관리 에서 일괄 반려
	 * 번호 1 - 재직증명서  상태값을 3로 업데이트
	 * 
	 * Author : 이선형
	 * Date : 20160412
	 * ***************************************
	 * */
	@RequestMapping(value = "CertUdtTbDen", method = RequestMethod.POST)
	public void CertUdtTbDen(Model model, PrintWriter out, TopCertVO certVo, @RequestParam(value="checkArray[]") List<String> arrayParams) {
		
		int result = 0;
		
		/*번호 1*/
		for (int i = 0; i < arrayParams.size(); i++) {
			
			sqlSession.update("EmpCertUdt.udtCertDen",arrayParams.get(i));
			result++;
		}
		
		if(result == arrayParams.size()){
			out.print(1);	
		}else{
			out.print(0);
		}
		
	}
	
	/**************************************재직증명 일괄 수정 끝****************************************/
}
