package kr.co.toplac.topteam;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
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

import kr.co.toplac.topmain.MainLeftSuimVO;
import kr.co.toplac.util.page.PageUtilityBasic;
import kr.co.toplac.util.rpt.MainLeftUtil;

@Controller
public class EmpCertListController {
private static final Logger logger = LoggerFactory.getLogger(EmpCertListController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	MainLeftUtil mlu;

	/*
	 * ***************************************
	 * Method ID : topCertMng
	 * Method Name :  topCertMng
	 * Description : 재직증명 관리 전체 리스트 추출
	 * 번호 1 - 재직증명서 전체 목록 테이블 추출
	 * 
	 * Author : 이선형
	 * Date : 20160412
	 * ***************************************
	 * */
	@RequestMapping(value = "topCertMng", method = RequestMethod.GET)
	public String topCertMng(Model model, String reqPgNo, String fromMainLeftStr, HttpSession session){

		logger.info("======= topCertMng =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_16().equals("0")){
			logger.info("topCertMng - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		
//		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
//		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		/*번호 1*/
		/*List<TopCertVO> CertList = sqlSession.selectList("EmpCertList.CertList");*/
		
		PageUtilityBasic pageUtil = new PageUtilityBasic();
		
		@SuppressWarnings("unchecked")
		List<TopCertVO> CertList = (List<TopCertVO>) pageUtil.pageBasicPop1(1, sqlSession, "EmpCertList.CertList", reqPgNo, model, "topCertMng","");
			
		
		
		for (int i = 0; i < CertList.size(); i++) {
			if(CertList.get(i).getIssue_state().equals("0")){
				CertList.get(i).setIssue_state("신청");
			}else if(CertList.get(i).getIssue_state().equals("1")){
				CertList.get(i).setIssue_state("취소");
			}else if(CertList.get(i).getIssue_state().equals("2")){
				CertList.get(i).setIssue_state("승인");
			}else if(CertList.get(i).getIssue_state().equals("3")){
				CertList.get(i).setIssue_state("반려");
			}  
		}
		
		/*검색에 사용될 팀목록 추출*/
		List<TopTmBscVO> teamList = sqlSession.selectList("EmpCertList.teamListForSearch");
		model.addAttribute("teamList", teamList);
		
		model.addAttribute("fromCertList","fromCertList");
		model.addAttribute("CertList",CertList);
		model.addAttribute("fromMainLeftStr",fromMainLeftStr);

		return "top_team/emp_cert_list";
	}
	
	/*재직증명서 검색 동작*/
	@RequestMapping(value = "certSearch", method = RequestMethod.POST)
	public void certSearch(String issue_state, String searchStr,String gid,String tid, HttpServletResponse response) {
		
		logger.info("======= certSearch =======");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		HashMap<String, String> queryMap = new HashMap<String, String>();
		queryMap.put("issue_state", issue_state);
		queryMap.put("searchStr", searchStr);
		queryMap.put("tid", tid);
		queryMap.put("gid", gid);

		List<TopCertVO> searchCertList = sqlSession.selectList("EmpCertList.searchCertList", queryMap);
		
		for (int i = 0; i < searchCertList.size(); i++) {
			if(searchCertList.get(i).getIssue_state().equals("0")){
				searchCertList.get(i).setIssue_state("신청");
			}else if(searchCertList.get(i).getIssue_state().equals("1")){
				searchCertList.get(i).setIssue_state("취소");
			}else if(searchCertList.get(i).getIssue_state().equals("2")){
				searchCertList.get(i).setIssue_state("승인");
			}else if(searchCertList.get(i).getIssue_state().equals("3")){
				searchCertList.get(i).setIssue_state("반려");
			}  
		}
		
		JSONArray arr = new JSONArray();
		for(int i=0; i < searchCertList.size(); i++){
			TopCertVO certvo = searchCertList.get(i);
			JSONObject obj = new JSONObject();
			obj.put("ROWNUM", certvo.getROWNUM());
			obj.put("user_name", certvo.getUser_name());
			obj.put("user_no", certvo.getUser_no());
			obj.put("work_level", certvo.getWork_level());
			obj.put("team_name", certvo.getTeam_name());
			obj.put("center_name", certvo.getCenter_name());
			obj.put("reg_date", certvo.getReg_date());
			obj.put("issue_reason", certvo.getIssue_reason());
			obj.put("expiry_date", certvo.getExpiry_date());
			obj.put("join_date", certvo.getJoin_date());
			obj.put("out_date", certvo.getIssue_state());
			obj.put("serial_no", certvo.getSerial_no());
			obj.put("issue_state", certvo.getIssue_state());
			
			arr.add(obj);
		}
		String jsonStr = arr.toString();
		out.print(jsonStr);
		out.close();

	}//certSearch

	
}
