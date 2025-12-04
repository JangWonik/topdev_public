package kr.co.toplac.util.etc;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

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
public class ZipCodePop {

	@Autowired
	private SqlSession sqlSession;

	private static final Logger logger = LoggerFactory.getLogger(ZipCodePop.class);

	@RequestMapping(value = "zipcodePop", method = RequestMethod.GET)
	public String zipcodePop(Model model, HttpSession session) {
		return "util_etc/zipcode_pop";

	}//zipcodePop
	
	@RequestMapping(value = "zipcodeSearch", method = RequestMethod.POST)
	public void zipcodeSearch(HttpServletResponse response, HttpSession session, String searchStr) {
		logger.info("zipcodeSearch");
		
		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		List<ZipCodeVO> addr = sqlSession.selectList("ZipCodeSearch.addrSearch",searchStr);
		JSONArray arr = new JSONArray();
		for(int i=0; i < addr.size(); i++){
			ZipCodeVO oneAddr = addr.get(i);
			JSONObject obj = new JSONObject();
			obj.put("addr1", oneAddr.getAddr1());
			obj.put("zipcode", oneAddr.getZipcode());
			arr.add(obj);
		}
		String jsonStr = arr.toString();
		out.print(jsonStr);
		out.close();
	}//zipcodePop
	

}//end of class
