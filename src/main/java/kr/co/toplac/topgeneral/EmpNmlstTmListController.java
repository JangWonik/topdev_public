package kr.co.toplac.topgeneral;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.rpt.MainLeftUtil;

@Controller
public class EmpNmlstTmListController {
	
	private static final Logger logger = LoggerFactory.getLogger(EmpNmlstTmListController.class);
	
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	MainLeftUtil mlu;
	
	@RequestMapping(value = "/empNmlstTmList", method = RequestMethod.GET)
	public String empNmlstTmList(Model model, HttpSession session) {

		logger.info("======= empNmlstTmList =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		List<EmpNmlstVO> worktype_cnt = sqlSession.selectList("EmpNmlstTmListMapper.countWorkType");
		for (int i = 0; i < worktype_cnt.size(); i++) {
			worktype_cnt.get(i).getCnt();
		}
				
		/*팀현황 TAB 시작*/
		/*본사 사업부 조회시작*/
		List<EmpNmlstVO> teamList_head = sqlSession.selectList("EmpNmlstTmListMapper.getAllTeam");
		
		for (int i = 0; i < teamList_head.size(); i++) {
			if(teamList_head.get(i).getCnt().equals("0")){
				teamList_head.get(i).setCnt("-");
			}
		}
		/*본사 사업부 조회종료*/
		/*1종 사업부 조회시작*/
		List<EmpNmlstVO> teamList_1 = sqlSession.selectList("EmpNmlstTmListMapper.getTeam1");
		
		for (int i = 0; i < teamList_1.size(); i++) {
			if(teamList_1.get(i).getCnt().equals("0")){
				teamList_1.get(i).setCnt("-");
			}
			
		}
		/*1종 사업부 조회종료*/
		/*4종 사업부 조회시작*/
		List<EmpNmlstVO> teamList_4 = sqlSession.selectList("EmpNmlstTmListMapper.getTeam4");
		
		for (int i = 0; i < teamList_4.size(); i++) {
			if(teamList_4.get(i).getCnt().equals("0")){
				teamList_4.get(i).setCnt("-");
			}
		}
		/*4종 사업부 조회종료*/
		
		String countWorkTotal = sqlSession.selectOne("EmpNmlstTmListMapper.countAllWorkMember");
		//String countPendingTotal = sqlSession.selectOne("TopTeamMapper.countAllPendingMember");
		//String countRetireTotal = sqlSession.selectOne("TopTeamMapper.countAllRetireMember");
		model.addAttribute("worktype_cnt",worktype_cnt);
		model.addAttribute("teamList_head",teamList_head);
		model.addAttribute("teamList_1",teamList_1);
		model.addAttribute("teamList_4",teamList_4);
		//model.addAttribute("worktype1_cnt",worktype1_cnt);

		model.addAttribute("countWorkTotal",countWorkTotal);
		//model.addAttribute("countPendingTotal",countPendingTotal);
		//model.addAttribute("countRetireTotal",countRetireTotal);
		/*팀현황 TAB 끝*/

		/*검색에 사용될 팀목록 추출*/
		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
		model.addAttribute("teamList", teamList);
		
		//1종 부분, 센터, 팀(실무팀, 지원팀) 시작
		List<Map<String, Object>> sectorList1 = sqlSession.selectList("EmpNmlstTmListMapper.sectorList","1");
		List<Map<String, Object>> centerList1 = sqlSession.selectList("EmpNmlstTmListMapper.centerList","1");
		List<Map<String, Object>> partBy1List1 = sqlSession.selectList("EmpNmlstTmListMapper.partByList1","1");
		List<Map<String, Object>> partBy2List1 = sqlSession.selectList("EmpNmlstTmListMapper.partByList1","2");
		
		model.addAttribute("sectorList1",sectorList1);
		model.addAttribute("centerList1",centerList1);
		model.addAttribute("partBy1List1",partBy1List1);
		model.addAttribute("partBy2List1",partBy2List1);		
		//1종 부분, 센터, 팀(실무팀, 지원팀) 끝
		
		//4종 부분, 센터, 팀(실무팀, 지원팀) 시작
		List<Map<String, Object>> sectorList4 = sqlSession.selectList("EmpNmlstTmListMapper.sectorList","4");
		List<Map<String, Object>> centerList4 = sqlSession.selectList("EmpNmlstTmListMapper.centerList","4");
		List<Map<String, Object>> partBy1List4 = sqlSession.selectList("EmpNmlstTmListMapper.partByList4","1");
		List<Map<String, Object>> partBy2List4 = sqlSession.selectList("EmpNmlstTmListMapper.partByList4","2");
		
		model.addAttribute("sectorList4",sectorList4);
		model.addAttribute("centerList4",centerList4);
		model.addAttribute("partBy1List4",partBy1List4);
		model.addAttribute("partBy2List4",partBy2List4);		
		//4종 부분, 센터, 팀(실무팀, 지원팀) 끝

		return "top_general/emp_nmlst_tm_list";
	}//end of empNmlstTmList
	
	/*사원 검색 동작*/
	@RequestMapping(value = "empNmlstSearch", method = RequestMethod.POST)
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
		queryMap.put("ustat", ustat);
		queryMap.put("tid", tid);
		queryMap.put("searchStr", searchStr);
		queryMap.put("gid", gid);

		List<TopMbrBscVO> searchMemberList = sqlSession.selectList("EmpNmlstTmListMapper.searchEmpList", queryMap);
		JSONArray arr = new JSONArray();
		for(int i=0; i < searchMemberList.size(); i++){
			TopMbrBscVO tmpvo = searchMemberList.get(i);
			JSONObject obj = new JSONObject();
			obj.put("rownum", tmpvo.getRownum());
			obj.put("user_no", tmpvo.getUser_no());
			obj.put("user_name", tmpvo.getUser_name());
			obj.put("user_id", tmpvo.getUser_id());
			obj.put("team_id_main", tmpvo.getTeam_id_main());
			obj.put("center_name", tmpvo.getCenter_name());
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
	
	@RequestMapping(value = "MemberTelExcel", method = RequestMethod.GET)
	public String memberTelExcel(Model model, HttpSession session, String gubun, HttpServletResponse response) {
		logger.info("======= MemberTelExcel =======");
		List<EmpNmlstVO> groupCount = sqlSession.selectList("EmpNmlstTmListMapper.getGroupCount");		
		
		/*팀현황 TAB 시작*/
		/*본사 사업부 조회시작*/
		List<EmpNmlstVO> teamList_head = sqlSession.selectList("EmpNmlstTmListMapper.getAllTeamExcel");
		
		for (int i = 0; i < teamList_head.size(); i++) {
			//순수한 팀인원 수만 계산한다. by top3009
			teamList_head.get(i).setMember_cnt(teamList_head.get(i).getCnt());
			for (int j = 0; j < groupCount.size(); j++) {
				if (teamList_head.get(i).getTeam_id().equals(groupCount.get(j).getTeam_id()) ){
					int tmp = Integer.parseInt(teamList_head.get(i).getCnt()) + Integer.parseInt(groupCount.get(j).getCnt());
					teamList_head.get(i).setCnt(""+tmp);
				}
			}
		}
		/*본사 사업부 조회종료*/
		
		/*1종 사업부 조회시작*/
		List<EmpNmlstVO> teamList_1 = sqlSession.selectList("EmpNmlstTmListMapper.getTeam1Excel");
		
		for (int i = 0; i < teamList_1.size(); i++) {
			//순수한 팀인원 수만 계산한다. by top3009
			teamList_1.get(i).setMember_cnt(teamList_1.get(i).getCnt());			
			for (int j = 0; j < groupCount.size(); j++) {
				if (teamList_1.get(i).getTeam_id().equals(groupCount.get(j).getTeam_id()) ){					
					int tmp = Integer.parseInt(teamList_1.get(i).getCnt()) + Integer.parseInt(groupCount.get(j).getCnt());
					teamList_1.get(i).setCnt(""+tmp);
				}
			}
		}
		/*1종 사업부 조회종료*/
		
		/*4종 사업부 조회시작*/
		List<EmpNmlstVO> teamList_4 = sqlSession.selectList("EmpNmlstTmListMapper.getTeam4Excel");
		
		for (int i = 0; i < teamList_4.size(); i++) {
			//순수한 팀인원 수만 계산한다. by top3009
			teamList_4.get(i).setMember_cnt(teamList_4.get(i).getCnt());
			for (int j = 0; j < groupCount.size(); j++) {
				if (teamList_4.get(i).getTeam_id().equals(groupCount.get(j).getTeam_id()) ){
					int tmp = Integer.parseInt(teamList_4.get(i).getCnt()) + Integer.parseInt(groupCount.get(j).getCnt());
					teamList_4.get(i).setCnt(""+tmp);
				}
			}
		}
		/*4종 사업부 조회종료*/
		
		List<EmpNmlstExcelVO> memberList = sqlSession.selectList("EmpNmlstTmListMapper.getAllMemberForExcel");
		
		Date dateToday = new Date();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");//오늘날자구하기
		
		String today = df.format(dateToday);
		
		model.addAttribute("teamList_head",teamList_head);
		model.addAttribute("teamList_1",teamList_1);
		model.addAttribute("teamList_4",teamList_4);
		model.addAttribute("memberList",memberList); 
		model.addAttribute("today", today);
		model.addAttribute("gubun", gubun);
		
		
		String fileName = "";
		if( gubun.equals("all") ){
			fileName = "직원주소록.xls";
		}else if( gubun.equals("kind0") ){
			fileName = "본사사업부_직원주소록.xls";
		}else if( gubun.equals("kind1") ){
			fileName = "1종사업부_직원주소록.xls";
		}else if( gubun.equals("kind4") ){
			fileName = "4종사업부_직원주소록.xls";
		}
		
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
		
		return "top_general/emp_nmlst_tm_excel";
	}


}//end of class
