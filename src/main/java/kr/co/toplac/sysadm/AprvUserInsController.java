package kr.co.toplac.sysadm;

import java.io.IOException;
import java.io.PrintWriter;
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

import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;

@Controller
public class AprvUserInsController {

	@Autowired
	private SqlSession sqlSession;

	private static final Logger logger = LoggerFactory.getLogger(AprvUserInsController.class);

	@RequestMapping(value = "/topSysAdmAprvUser", method = RequestMethod.GET)
	public String topSysAdmAprvUser(Model model, HttpSession session) {
		
		logger.info("======= topSysAdmAprvUser =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("topSysAdmAprvUser - no permession user_no : "+mbrVo.getUser_no());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		/*검색에 사용될 팀목록 추출*/
		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
		model.addAttribute("teamList", teamList);

		/*검색에 사용될 팀목록 추출*/
		List<SysAdmCodeDicVO> taskCodeList = sqlSession.selectList("AprvUserMapper.taskCodeList");
		model.addAttribute("taskCodeList", taskCodeList);

		return "sys_adm/aprv_user_ins";
	}//sampleMemoPan

	@RequestMapping(value = "aprvUserIns", method = RequestMethod.POST)
	public void aprvUserIns(HttpServletRequest request, HttpServletResponse response, HttpSession session, AprvUserInsViewVO inVO) {
		
		logger.info("======= aprvUserIns =======");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		inVO.setRegUser(mbrAuthVo.getUser_no());
		inVO.setRegIp(request.getRemoteAddr());

		int result = 0;
		result = sqlSession.insert("AprvUserMapper.aprvUserIns", inVO);

		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		if(result > 0){
			SysAdmAprvUserVO oneData = sqlSession.selectOne("AprvUserMapper.selectOneAprvUser", inVO);
			JSONArray arr = new JSONArray();
			JSONObject obj = new JSONObject();
			obj.put("serialNo", oneData.getSerial_no());
			obj.put("teamId", oneData.getTeam_id());
			obj.put("teamNm", oneData.getTeam_nm());
			obj.put("taskCode", oneData.getTask_code());
			obj.put("taskCodeNm", oneData.getTask_code_nm());
			obj.put("aprvUserNo", oneData.getAprv_user_no());
			obj.put("aprvUserNm", oneData.getAprv_user_nm());
			obj.put("regReason", oneData.getReg_reason());
			obj.put("regDate", oneData.getReg_date());
			obj.put("regDateFmt", oneData.getReg_date_fmt());
			obj.put("regIp", oneData.getReg_ip());
			obj.put("regUserNo", oneData.getReg_user_no());
			obj.put("regUserNm", oneData.getReg_user_nm());
			obj.put("delReason", oneData.getDel_reason());
			obj.put("delDate", oneData.getDel_date());
			obj.put("delDateFmt", oneData.getDel_date_fmt());
			obj.put("delIp", oneData.getDel_ip());
			obj.put("delUserNo", oneData.getDel_user_no());
			obj.put("delUserNm", oneData.getDel_user_nm());
			arr.add(obj);
			String jsonStr = arr.toString();
			out.print(jsonStr);
			out.close();
		}

	}//aprvUserIns

	@RequestMapping(value = "aprvUserList", method = RequestMethod.POST)
	public void aprvUserList(HttpServletResponse response, AprvUserInsViewVO inVO) {

		logger.info("======= aprvUserList =======");

		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		List<SysAdmAprvUserVO> aprvUserList = sqlSession.selectList("AprvUserMapper.aprvUserList", inVO);
		JSONArray arr = new JSONArray();
		for(int i=0; i < aprvUserList.size(); i++){
			SysAdmAprvUserVO oneData = aprvUserList.get(i);
			JSONObject obj = new JSONObject();
			obj.put("serialNo", oneData.getSerial_no());
			obj.put("teamId", oneData.getTeam_id());
			obj.put("teamNm", oneData.getTeam_nm());
			obj.put("taskCode", oneData.getTask_code());
			obj.put("taskCodeNm", oneData.getTask_code_nm());
			obj.put("aprvUserNo", oneData.getAprv_user_no());
			obj.put("aprvUserNm", oneData.getAprv_user_nm());
			obj.put("regReason", oneData.getReg_reason());
			obj.put("regDate", oneData.getReg_date());
			obj.put("regDateFmt", oneData.getReg_date_fmt());
			obj.put("regIp", oneData.getReg_ip());
			obj.put("regUserNo", oneData.getReg_user_no());
			obj.put("regUserNm", oneData.getReg_user_nm());
			obj.put("delReason", oneData.getDel_reason());
			obj.put("delDate", oneData.getDel_date());
			obj.put("delDateFmt", oneData.getDel_date_fmt());
			obj.put("delIp", oneData.getDel_ip());
			obj.put("delUserNo", oneData.getDel_user_no());
			obj.put("delUserNm", oneData.getDel_user_nm());
			arr.add(obj);
		}
		String jsonStr = arr.toString();
		out.print(jsonStr);
		out.close();

	}//aprvUserList

	@RequestMapping(value = "deleteAprvUser", method = RequestMethod.POST)
	public void restoreHolidayUpdate(HttpServletRequest request, HttpSession session, HttpServletResponse response
			, AprvUserInsViewVO inVO) {

		logger.info("======= deleteAprvUser =======");

		inVO.setRegUser((String) session.getAttribute("user_no_Session"));
		inVO.setRegIp(request.getRemoteAddr());

		int result = 0;
		result = sqlSession.update("AprvUserMapper.deleteAprvUser", inVO);

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

	}//deleteAprvUser

}//end of class
