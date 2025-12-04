package kr.co.toplac.util.memo;

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

import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.cmm.DateUtil;

@Controller
public class MemoUtilityBasic {

	@Autowired
	private SqlSession sqlSession;

	private static final Logger logger = LoggerFactory.getLogger(MemoUtilityBasic.class);
	
	@RequestMapping(value="sampleInsaOniku")
	public String sampleInsaOniku(HttpServletRequest request, Model model, HttpSession session){
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		String sUserNo = mbrVo.getUser_no();
		
		if(!"1786".equals(sUserNo) ){
			logger.info("OnikuUpdateHeadAsta - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		
		logger.info("======= sampleInsaOniku =======");
				
		//물보험 명단
		List<Map<String,Object>> memberList = sqlSession.selectList("SuimSchedule.selectMemberListBy1Temp");
		
		String tempUserNo = "";
		
		//경력정보 Map
		Map<String,Object> carreerMap = new HashMap<String,Object>();		
		
		//보험사 경력가져오기
		for( int i=0; i < memberList.size(); i++) {
			tempUserNo = String.valueOf(memberList.get(i).get("user_no"));
			carreerMap = sqlSession.selectOne("SuimSchedule.getMbrCareerMax",tempUserNo);
			memberList.get(i).put("career_corporate_name", carreerMap.get("career_corporate_name"));
			memberList.get(i).put("career_date", carreerMap.get("career_date"));
			memberList.get(i).put("career_date_val", DateUtil.parseMonthToYear(String.valueOf(carreerMap.get("career_date"))));
		}
		
		model.addAttribute("memberList", memberList);
		
		return "/util_etc/oniku_test";
	}

	@RequestMapping(value = "/sampleMemoPan", method = RequestMethod.GET)
	public String sampleMemoPan(Model model, HttpSession session) {

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null){
			logger.info("memoWrite - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		logger.info("sampleMemoPan");

		return "util_memo/sample_memo_pan";
	}//sampleMemoPan

	@RequestMapping(value = "memoList", method = RequestMethod.POST)
	public void memoList(HttpServletResponse response, MemoUtilViewVO inVO) {
		
		logger.info("memoList");

		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		List<TopRptMemoVO> memoList = sqlSession.selectList("MemoUtilMapper.memoList", inVO);
		JSONArray arr = new JSONArray();
		for(int i=0; i < memoList.size(); i++){
			TopRptMemoVO oneMemo = memoList.get(i);
			JSONObject obj = new JSONObject();
			obj.put("targetStr", inVO.getTargetStr());
			obj.put("memoNo", oneMemo.getMemo_no());
			obj.put("linkNo", oneMemo.getFk_no());
			obj.put("userNo", oneMemo.getUser_no());
			obj.put("userNm", oneMemo.getUser_nm());
			obj.put("mContents", oneMemo.getMemo());
			obj.put("regIp", oneMemo.getReg_ip());
			obj.put("regDate", oneMemo.getReg_date());
			arr.add(obj);
		}
		String jsonStr = arr.toString();
		out.print(jsonStr);
		out.close();

	}//memoList

	@RequestMapping(value = "memoWrite", method = RequestMethod.POST)
	public void memoWrite(HttpServletRequest request, HttpServletResponse response, HttpSession session, MemoUtilViewVO inVO) {
		
		logger.info("memoWrite");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		inVO.setUserNo(mbrAuthVo.getUser_no());
		inVO.setRegIp(request.getRemoteAddr());
		inVO.setmContents(inVO.getmContents().replace("\n", "<br>"));

		int result = 0;
		result = sqlSession.insert("MemoUtilMapper.memoWrite", inVO);

		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		if(result > 0){
			TopRptMemoVO oneMemo = sqlSession.selectOne("MemoUtilMapper.oneMemo", inVO);
			JSONArray arr = new JSONArray();
			JSONObject obj = new JSONObject();
			obj.put("targetStr", inVO.getTargetStr());
			obj.put("memoNo", oneMemo.getMemo_no());
			obj.put("linkNo", oneMemo.getFk_no());
			obj.put("userNo", oneMemo.getUser_no());
			obj.put("userNm", oneMemo.getUser_nm());
			obj.put("mContents", oneMemo.getMemo());
			obj.put("regIp", oneMemo.getReg_ip());
			obj.put("regDate", oneMemo.getReg_date());
			arr.add(obj);
			String jsonStr = arr.toString();
			out.print(jsonStr);
		}
		out.close();

	}//memoWrite

	@RequestMapping(value = "memoDelete", method = RequestMethod.POST)
	public void memoDelete(HttpServletResponse response, MemoUtilViewVO inVO) {
		
		logger.info("memoDelete");

		int result = 0;
		result = sqlSession.delete("MemoUtilMapper.memoDelete", inVO);

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

	}//memoDelete

	@RequestMapping(value = "memoUpdate", method = RequestMethod.POST)
	public void memoUpdate(HttpServletResponse response, MemoUtilViewVO inVO) {
		
		logger.info("memoUpdate");

		inVO.setmContents(inVO.getmContents().replace("\n", "<br>"));

		int result = 0;
		result = sqlSession.update("MemoUtilMapper.memoUpdate", inVO);

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

	}//memoUpdate

}//end of class
