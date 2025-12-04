package kr.co.toplac.topptnr;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
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
public class PtnrDeptUdtController {
	
	private static final Logger logger = LoggerFactory.getLogger(PtnrDeptUdtController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	/*
	 * ***************************************
	 * Method ID : ptnrDeptDel
	 * Method Name :  ptnrDeptDel
	 * Description : 파트너사 부서 삭제 ( 업데이트  : del_state )
	 * 번호 1 : 파트너사 부서 삭제 상태값 변경
	 * Author : 이선형
	 * Date : 20160428
	 * ***************************************
	 * */
	@RequestMapping(value = "ptnrDeptDel", method = RequestMethod.POST)
	public void ptnrDeptDel(Model model, HttpSession session, String ptnr_dept_id, PrintWriter out) {
		
		logger.info("ptnrDeptDel");
		
		/*번호 1*/
		int result = sqlSession.update("PtnrDeptUdtMapper.deptDel", ptnr_dept_id);
		
		out.print(result);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : ptnrDeptUdt
	 * Method Name :  ptnrDeptUdt
	 * Description : 파트너사 부서 수정 
	 * 번호 1 : 파트너사 부서 데이터 변경
	 * Author : 이선형
	 * Date : 20160428
	 * ***************************************
	 * */
	@RequestMapping(value = "ptnrDeptUdt", method = RequestMethod.POST)
	public void ptnrDeptUdt(Model model, HttpSession session, TopPtnrDeptBscVO deptViewVo, HttpServletResponse response) {
		
		logger.info("ptnrDeptUdt");
		
		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	      
	    PrintWriter out = null;
	    
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		/*번호 1*/
		sqlSession.update("PtnrDeptUdtMapper.deptUdt", deptViewVo);
		
		//보험사 부서 정보가 수정되면 소속 직원들의 보험사 top_ptnr_mbr_bsc 내 ptnt_tm_nm 값도 같이 갱신해 주어야 한다.
		//20230713		
		sqlSession.update("PtnrDeptUdtMapper.syncTopPtnrMbrBscByPtnrTmNm",deptViewVo);
		
		JSONArray arr = new JSONArray();

		JSONObject obj = new JSONObject();
		
		obj.put("ptnr_id", deptViewVo.getPtnr_id());
		obj.put("ptnr_dept_id", deptViewVo.getPtnr_dept_id());
		obj.put("ptnr_dept_nm", deptViewVo.getPtnr_dept_nm());
		obj.put("ptnr_dept_office_postcode", deptViewVo.getPtnr_dept_office_postcode());
		obj.put("ptnr_dept_office_addr1", deptViewVo.getPtnr_dept_office_addr1());
		obj.put("ptnr_dept_office_addr2", deptViewVo.getPtnr_dept_office_addr2());
		obj.put("ptnr_dept_office_tel", deptViewVo.getPtnr_dept_office_tel());
		obj.put("ptnr_dept_office_fax", deptViewVo.getPtnr_dept_office_fax());
		
		
		arr.add(obj);

		String jsonStr = arr.toString();
		out.print(jsonStr);
		out.close();
	}

}
