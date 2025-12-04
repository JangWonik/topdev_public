package kr.co.toplac.topteam;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletOutputStream;
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

import kr.co.toplac.topindividual.TopMbrDocVO;
import kr.co.toplac.topmain.MainLeftSuimVO;
import kr.co.toplac.util.page.PageUtilityBasic;

@Controller
public class EmpDocListController {
private static final Logger logger = LoggerFactory.getLogger(EmpDocListController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	/*
	 * ***************************************
	 * Method ID : topDocMng
	 * Method Name :  topDocMng
	 * Description : 품의서 관리 전체 리스트 추출
	 * 
	 * Author : 임대성
	 * Date : 20161118
	 * ***************************************
	 * */
	@RequestMapping(value = "topDocMng", method = RequestMethod.GET)
	public String topCertMng(Model model, String reqPgNo, String fromMainLeftStr, HttpSession session){
		
		logger.info("======= topDocMng =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_16().equals("0")){
			logger.info("topCertMng - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
//		
		List<TopMbrDocVO> docList = sqlSession.selectList("EmpDocList.getEmpDocList");
		model.addAttribute("docList", docList);
//		
//		///검색
//		/* 팀목록 추출*/
		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
		model.addAttribute("teamList", teamList);

		return "top_team/emp_doc_list";
	}
	
	/*사원 검색 동작*/
	@RequestMapping(value = "docMemberSearch", method = RequestMethod.POST)
	public void docMemberSearch(String ustat, String tid, String searchStr, String gid, HttpServletResponse response) {

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		HashMap<String, String> queryMap = new HashMap<String, String>();
		queryMap.put("ustat", ustat);
		queryMap.put("tid", tid);
		queryMap.put("searchStr", searchStr);
		queryMap.put("gid", gid);

		List<TopMbrBscVO> searchMemberList = sqlSession.selectList("MbrStatListMapper.searchMemberList", queryMap);
		JSONArray arr = new JSONArray();
		for(int i=0; i < searchMemberList.size(); i++){
			TopMbrBscVO tmpvo = searchMemberList.get(i);
			JSONObject obj = new JSONObject();
			obj.put("rownum", tmpvo.getRownum());
			obj.put("user_no", tmpvo.getUser_no());
			obj.put("user_name", tmpvo.getUser_name());
			obj.put("user_id", tmpvo.getUser_id());
			obj.put("team_name", tmpvo.getTeam_name());
			obj.put("work_type", tmpvo.getWork_type());
			obj.put("work_level", tmpvo.getWork_level());
			obj.put("user_state", tmpvo.getUser_state());
			obj.put("join_date", tmpvo.getJoin_date());
			obj.put("out_date", tmpvo.getOut_date());
			arr.add(obj);
		}
		String jsonStr = arr.toString();
		out.print(jsonStr);
		out.close();

	}//topMemberSearch
	
}
