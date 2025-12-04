package kr.co.toplac.sysadm;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;

@Controller
public class TopPms2LogController {

	private static final Logger logger = LoggerFactory.getLogger(TopPms2LogController.class);

	@Autowired
	SqlSession sqlSession;

	@RequestMapping(value = "topPms2LogExcel", method = RequestMethod.GET)
	public String topPms2LogExcel(Model model, HttpSession session, HttpServletResponse response, String toDate, String fromDate) {
		logger.info("======= topPms2LogExcel =======");
		
		HashMap<String,String> map = new HashMap<String,String>();
		if (toDate != "" && toDate != null ){
			map.put("toDate", toDate);
		}else{
			map.put("toDate", ""+0);
		}
		if (fromDate != "" && fromDate != null ){
			map.put("fromDate", fromDate);
		}else{
			map.put("fromDate", ""+0);
		}
		
		
		
		List<TopMbrAuthVO> authList = sqlSession.selectList("PmsLogListMapper.pms2LogList",map);
		
		for(int i=0; i < authList.size(); i++){
			TopMbrAuthVO tmpvo = authList.get(i);
			System.out.println("admin2 : " +tmpvo.getLs_admin2());
			
		}
		
		String fileName = "권한2변경로그.xls";
		try {
			fileName = java.net.URLEncoder.encode(fileName,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.setHeader("Content-Disposition", "attachment;filename="+fileName);
		response.setHeader("Content-Type", "application/vnd.ms-xls");
		response.setHeader("Content-Description", "JSP Generated Data");
		response.setHeader("Content-Transfer-Encoding", "binary");
		
		return "sys_adm/top_pms2_log_excel";			
	}
	
	
	@RequestMapping(value = "topPms2LogList", method = RequestMethod.GET)
	public String topPms2LogList(Model model, HttpSession session, String toDate, String fromDate) {
		
		return "sys_adm/top_pms2_log_mng";	
	}

}//end of class
