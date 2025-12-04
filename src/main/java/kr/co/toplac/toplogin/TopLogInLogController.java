/*
*********************************************************
* Program ID	: 
* Program Name	: 
* Description	: 
* Author		: 
* Date			: 
*********************************************************
*/
package kr.co.toplac.toplogin;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.toplac.brd.common.BoardPageUtil;
import kr.co.toplac.brd.common.BoardSearchVO;
import kr.co.toplac.brd.common.BoardVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.page.PageUtilityBasic;

@Controller
public class TopLogInLogController {

	private static final Logger logger = LoggerFactory.getLogger(TopLogInLogController.class);

	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value="/dupManagerAction")
	@ResponseBody
	public int dupManagerAction(HttpServletRequest request, Model model, HttpSession session) {
		
		int nRet = 0;				
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sAction = paramMap.get("p_action").toString();
		String sUserNo = paramMap.get("user_no").toString();
		
		if( "U".equals(sAction) ) {
			nRet = sqlSession.update("TopLoginMapper.updateDupListSearch",sUserNo);
		}else if( "D".equals(sAction) ) {
			nRet = sqlSession.delete("TopLoginMapper.deleteDupListSearch",sUserNo);
		}else if( "ALL".equals(sAction) ) {
			nRet = sqlSession.update("TopLoginMapper.updateLogoutDupAll");
		}
		
		return nRet;		
	}
	
	
	@RequestMapping(value = "/dupListAjax", method = RequestMethod.POST)
	public String dupListAjax(Model model, HttpServletRequest request, HttpSession session) {
		logger.info("======= dupListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String srchUserName = paramMap.get("srchUserName").toString();
		
		List<Map<String,Object>> userDupList = sqlSession.selectList("TopLoginMapper.selectDupListSearch",paramMap);
				
		model.addAttribute("userDupList", userDupList);
		model.addAttribute("srchUserName", srchUserName);				
		
		return "top_login/top_dup_login_log_list_ajax";
	}

	/*
	*********************************************************
	* Program ID	: 
	* Program Name	: 
	* Description	:  
	* Author		: 
	* Date			: 
	*********************************************************
	*/
	@RequestMapping(value = "topLogInLogList", method = RequestMethod.GET)
	public String topLogInLogList(Model model, HttpSession session, TopLogInLogCompositeVO inVO, String reqPgNo) {

		logger.info("======= topLogInLogList =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("topSysAdmAprvUser - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		/*검색에 사용될 팀목록 추출*/
		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
		model.addAttribute("teamList", teamList);

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("mbrNo", inVO.getMbrNo());

		PageUtilityBasic pageUtil = new PageUtilityBasic();
		List<TopLogInLogCompositeVO> getLogInLogList 
		= (List<TopLogInLogCompositeVO>) pageUtil.pageBasic1Search(1, sqlSession, "TopLogInLog.getLogInLogList", reqPgNo, model, "topLogInLogList", map);

		model.addAttribute("getLogInLogList", getLogInLogList);
		model.addAttribute("mbrNo",inVO.getMbrNo());
		model.addAttribute("mbrNm",inVO.getMbrNm());

		return "top_login/top_login_log_list";
	}//topLogInLogList

	@RequestMapping(value = "/topLogInLog_Excel", method = RequestMethod.GET)
	public String logTeamExcel(Model model, HttpSession session, TopLogInLogCompositeVO inVO, String reqPgNo) {
		//String nowDate=DateUtil.getDate("yyyyMMddHHmmss");

		logger.info("======= topLogInLog_Excel =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("topSysAdmAprvUser - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("mbrNo", inVO.getMbrNo());

		List<TopLogInLogCompositeVO> getLogInLogListExcel = sqlSession.selectList("TopLogInLog.getLogInLogListExcel", map);

		model.addAttribute("getLogInLogListExcel", getLogInLogListExcel);
		model.addAttribute("mbrNo",inVO.getMbrNo());
		model.addAttribute("mbrNm",inVO.getMbrNm());

		return "top_login/top_login_log_list_excel";
	}//topLogInLog_Excel

	
	
    /**
     * 중복 로그인 페이지 URL Mapping
     * @param request
     * @param reqPgNo 페이지수
     * @return view Page
     */
	@RequestMapping(value = "topDupLogInLogList", method = RequestMethod.GET)
	public String topDupLogInLogList(Model model, HttpSession session, TopLogInLogCompositeVO inVO, String reqPgNo) {

		logger.info("======= topDupLogInLogList =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("topSysAdmAprvUser - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		/*검색에 사용될 팀목록 추출*/
		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
		model.addAttribute("teamList", teamList);

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("mbrNo", inVO.getMbrNo());

		PageUtilityBasic pageUtil = new PageUtilityBasic();
		List<TopLogInLogCompositeVO> getLogInLogList 
		= (List<TopLogInLogCompositeVO>) pageUtil.pageBasic1Search(1, sqlSession, "TopLogInLog.getDupLogInLogList", reqPgNo, model, "getDupLogInLogList", map);

		model.addAttribute("getLogInLogList", getLogInLogList);
		model.addAttribute("mbrNo",inVO.getMbrNo());
		model.addAttribute("mbrNm",inVO.getMbrNm());

		return "top_login/top_dup_login_log_list";
	}//topDupLogInLogList
	
    /**
     * 중복 로그인 사용자 로그아웃 요청 ajax
     * @param data (JSON, user_no)
     * @return resultMap
     */
	
	@RequestMapping(value = "topDupLogout", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> topDupLogout(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response) {

		logger.info("======= topDupLogout =======");
		Map<String, String> resultMap = new HashMap<String, String>();
		String resultMsg = "";

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("topSysAdmAprvUser - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			resultMsg = "fail";
			resultMap.put("resultMsg", resultMsg);
		    response.setContentType("text/plain");
		    response.setCharacterEncoding("UTF-8");
		    
			return resultMap;
		}
		
		/* 로그아웃 요청 DB반영 */
		String reqUserId = request.getParameter("user_id");
		int result = sqlSession.update("TopLoginMapper.udtLogoutDup", reqUserId);
		
		if (result == 0) {
			resultMsg = "fail";
		}else {
			resultMsg = "success";
		}
		
		resultMap.put("resultMsg", resultMsg);
	    response.setContentType("text/plain");
	    response.setCharacterEncoding("UTF-8");
		return resultMap;
	}//topDupLogInLogList
	
	
    /**
     * 중복 로그인된 사용자 검색 요청 
     * @param searchStr(사원
     * @return void
     */
	@RequestMapping(value = "topDupLoginSearch", method = RequestMethod.POST)
	public void empNmlstSearch(String ustat, String tid, String searchStr, String gid, HttpServletResponse response) {

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		HashMap<String, String> queryMap = new HashMap<String, String>();
		queryMap.put("searchStr", searchStr);
		/*
		queryMap.put("ustat", ustat);
		queryMap.put("tid", tid);
		queryMap.put("gid", gid);

*/
//		List<TopMbrBscVO> searchMemberList1 = sqlSession.selectList("EmpNmlstTmListMapper.searchEmpList", queryMap);
		List<TopMbrBscVO> searchMemberList = sqlSession.selectList("TopLogInLog.getDupLoginSearchByUserName", queryMap);
		
		JSONArray arr = new JSONArray();
		for(int i=0; i < searchMemberList.size(); i++){
			TopMbrBscVO tmpvo = searchMemberList.get(i);
			JSONObject obj = new JSONObject();
			obj.put("rownum", tmpvo.getRownum());
			obj.put("user_no", tmpvo.getUser_no());
			obj.put("user_name", tmpvo.getUser_name());
			obj.put("user_id", tmpvo.getUser_id());
			obj.put("team_id_main", tmpvo.getTeam_id_main());
			obj.put("team_name", tmpvo.getTeam_name());
			obj.put("work_type", tmpvo.getWork_type());
			obj.put("work_level", tmpvo.getWork_level());
			obj.put("user_state", tmpvo.getUser_state());
			obj.put("handphone", tmpvo.getHandphone());
			obj.put("office_tel", tmpvo.getOffice_tel());
			obj.put("office_fax", tmpvo.getOffice_fax());
			
			obj.put("team_id_loc", tmpvo.getTeam_id_loc());
			
			arr.add(obj);
		}
		String jsonStr = arr.toString();
		out.print(jsonStr);
		out.close();
	}//topMemberSearch
	
}//end of class
