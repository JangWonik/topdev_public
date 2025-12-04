package kr.co.toplac.util.sms;

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

import kr.co.toplac.sysadm.SysAdmCodeDicVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;

@Controller
public class GroupSMSController {
	
private static final Logger logger = LoggerFactory.getLogger(GroupSMSController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/groupSMSForm", method = RequestMethod.GET)
	public String groupSMSForm(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= groupSMSForm =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("groupSMSForm - no permession : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		String fromHpNo = sqlSession.selectOne("SimpleSMSMapper.getLogInUserHpNo", mbrVo);
		model.addAttribute("fromHpNo", fromHpNo.replaceAll("-", ""));

		/*검색에 사용될 팀목록 추출*/
//		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");//파트팀 제외
		List<TopTmBscVO> teamList = sqlSession.selectList("EmpCertList.teamListForSearch");//파트팀 포함
		
		model.addAttribute("teamList", teamList);

		/*검색에 사용될 work level 목록 추출*/
		List<SysAdmCodeDicVO> workLevelList = sqlSession.selectList("GroupSMSMapper.getWorkLevelList");
		model.addAttribute("workLevelList",workLevelList);

		return "util_sms/group_sms_form";
	}//groupSMSForm

	/*사원 검색 동작*/
	@RequestMapping(value = "smsEmpSearch", method = RequestMethod.POST)
	public void smsEmpSearch(String tid, String gid, String wid, String oid, String srchUserNm, HttpServletResponse response) {

		logger.info("======= smsEmpSearch =======");

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		HashMap<String, String> queryMap = new HashMap<String, String>();
		queryMap.put("tid", tid);
		queryMap.put("gid", gid);
		queryMap.put("wid", wid);
		queryMap.put("oid", oid);
		queryMap.put("srchUserNm", srchUserNm);
		

		List<TopMbrBscVO> searchMemberList = sqlSession.selectList("GroupSMSMapper.smsEmpSearch", queryMap);
		JSONArray arr = new JSONArray();
		for(int i=0; i < searchMemberList.size(); i++){
			TopMbrBscVO tmpvo = searchMemberList.get(i);
			JSONObject obj = new JSONObject();
			obj.put("user_no", tmpvo.getUser_no());
			obj.put("user_name", tmpvo.getUser_name());
			obj.put("user_id", tmpvo.getUser_id());
			obj.put("team_name", tmpvo.getTeam_name());
			obj.put("work_type", tmpvo.getWork_type());
			obj.put("work_level", tmpvo.getWork_level());
			obj.put("user_state", tmpvo.getUser_state());
			obj.put("handphone", tmpvo.getHandphone());
			obj.put("office_tel", tmpvo.getOffice_tel());
			arr.add(obj);
		}
		String jsonStr = arr.toString();
		out.print(jsonStr);
		out.close();
	}//smsEmpSearch

}
