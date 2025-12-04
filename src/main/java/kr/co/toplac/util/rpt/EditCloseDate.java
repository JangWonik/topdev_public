package kr.co.toplac.util.rpt;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
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

import kr.co.toplac.topgeneral.TopPtnrMbrBscVO;
import kr.co.toplac.topptnr.TopPtnrBscVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;

@Controller
public class EditCloseDate {

	@Autowired
	private SqlSession sqlSession;

	private static final Logger logger = LoggerFactory.getLogger(EditCloseDate.class);

	@RequestMapping(value = "incEditCloseDate", method = RequestMethod.POST)
	public void incEditCloseDate(HttpServletRequest request, HttpSession session, HttpServletResponse response
			, String gbNo, String smNo, String editCloseDate) {

		logger.info("======= incEditCloseDate =======");

		HashMap<String,String> map = new HashMap<String, String>();	
		map.put("gbNo", gbNo);
		map.put("smNo", smNo);
		map.put("editCloseDate", editCloseDate);
		map.put("userNo", (String) session.getAttribute("user_no_Session"));
		map.put("userIp", request.getRemoteAddr());

		int result = 0;
		result = sqlSession.update("EditCloseDateMapper.incEditCloseDate", map);
		if(result > 0){
			if(gbNo.equals("1")){
				sqlSession.insert("InsertRptLogMapper.insRptBscMap", map);
			}else if(gbNo.equals("2")){
				sqlSession.insert("InsertRptLogMapper.insPrimBizRptBscMap", map);
			}
		}

		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		if(result > 0){
			out.print(result);
		}
		out.close();

	}//incEditCloseDate

}//end of class
