package kr.co.toplac.sysadm;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.memo.MemoUtilViewVO;
import kr.co.toplac.util.memo.TopRptMemoVO;

@Controller
public class CloseRptPrintController {

	@Autowired
	private SqlSession sqlSession;

	private static final Logger logger = LoggerFactory.getLogger(CloseRptPrintController.class);

	@RequestMapping(value = "closeRptMgmt")
	public String closeRptPrint(HttpServletResponse response, HttpServletRequest request, Model model) {
		logger.info("closeRptPrint");
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        List<Map<String,Object>> ptnrList = sqlSession.selectList("CloseRptMgmtMapper.selectPtnrList");
        
        model.addAttribute("ptnrList", ptnrList);
		return "sys_adm/top_close_rpt_mgmt";
	}
	
	@RequestMapping(value = "delFileReport")
	public String delFileReport(HttpServletResponse response, HttpServletRequest request, Model model) {
		logger.info("delFileReport");
		
		//today 시간설정 시작
        Calendar cal = Calendar.getInstance();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
        String sToday = df.format(cal.getTime());
        
        model.addAttribute("sToday", sToday);		//현재시간 추가
        //today 시간설정 끝        
		return "sys_adm/del_file_report";
	}
	
	@RequestMapping(value = "delFileReportList")
	public String delFileReportList(HttpServletResponse response, HttpServletRequest request, Model model) {
		logger.info("delFileReport");
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        List<Map<String,Object>> teamList = sqlSession.selectList("CloseRptMgmtMapper.selectTeamList");
        List<Map<String,Object>> memberList = sqlSession.selectList("CloseRptMgmtMapper.selectMemberList");
        
        model.addAttribute("writer", request.getParameter("writer"));
        model.addAttribute("writeDate", request.getParameter("writeDate"));
        model.addAttribute("tempSel", request.getParameter("tempSel"));
        model.addAttribute("teamList", teamList);
        model.addAttribute("memberList", memberList);        
		return "sys_adm/del_file_report_list";
	}
	
	@RequestMapping(value = "closeRptPrintWord")
	public String closeRptPrintWord(HttpServletResponse response, HttpServletRequest request, Model model) {
		logger.info("closeRptPrintWord");
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);        
        List<Map<String,Object>> rptList = sqlSession.selectList("CloseRptMgmtMapper.selectCloseRptList",paramMap);
        
        List<Map<String,Object>> emailList = sqlSession.selectList("CloseRptMgmtMapper.selectCloseRptListEmail",paramMap);
        
        //이메일 대상자 리스트에서 팀장 또는 센터장을 뽑아온다.
        String sTeam_id = "";
        for(int i=0; i < emailList.size(); i++){
        	Map<String,Object> map = emailList.get(i);
        	sTeam_id = map.get("team_id").toString();        	
        	//팀아이디로 가장 상위 담당자를 뽑아온다.
        	paramMap.put("team_id", sTeam_id);        	
        	Map<String,Object> userInfo = sqlSession.selectOne("CloseRptMgmtMapper.selectMbrCenterUser",paramMap);
        	emailList.get(i).put("toEmail", userInfo.get("user_email"));
        	emailList.get(i).put("toName", userInfo.get("user_name"));
        }
        
        model.addAttribute("rptList",rptList);
        model.addAttribute("emailList",emailList);
		return "sys_adm/top_close_rpt_word";
	}//	

}//end of class
