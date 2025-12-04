package kr.co.toplac.topptnr;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class PtnrDeptInsController {
	
	private static final Logger logger = LoggerFactory.getLogger(PtnrDeptInsController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	/*
	 * ***************************************
	 * Method ID : ptnrDeptIns
	 * Method Name :  ptnrDeptIns
	 * Description : 파트너사 부서 목록 관리
	 * 번호 1 : 파트너사 부서 입력
	 * Author : 이선형
	 * Date : 20160427
	 * ***************************************
	 * */
	@RequestMapping(value = "ptnrDeptIns", method = RequestMethod.POST)
	public void ptnrDeptPage(Model model, HttpSession session, TopPtnrDeptBscVO deptVo, PrintWriter out) {
		
		logger.info("ptnrDeptIns");
		
		/*번호 1*/
		int result = sqlSession.insert("PtnrDeptInsMapper.deptIns", deptVo);
		
		out.print(result);
	}
}
