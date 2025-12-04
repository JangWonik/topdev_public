package kr.co.toplac.topteam;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class PopMbrAuth2DtlController {
	
private static final Logger logger = LoggerFactory.getLogger(PopMbrAuth2DtlController.class);
	
	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value = "popMbrAuth2Dtl", method = RequestMethod.GET)
	public String popMbrAuth2Dtl(Model model, HttpSession session, HttpServletRequest request
			, String user_no) {

		logger.info("======= popMbrAuth2Dtl =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("popMbrAuth2Dtl - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		List<TopTmBscVO> authTeamlist0 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist0", user_no);
		model.addAttribute("authTeamlist0",authTeamlist0);
		List<TopTmBscVO> authTeamlist1 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist1", user_no);
		model.addAttribute("authTeamlist1",authTeamlist1);
		List<TopTmBscVO> authTeamlist4 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist4", user_no);
		model.addAttribute("authTeamlist4",authTeamlist4);

		List<TopTmBscVO> authTeamlist0LsAdmin7 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist0LsAdmin7", user_no);
		model.addAttribute("authTeamlist0LsAdmin7",authTeamlist0LsAdmin7);
		List<TopTmBscVO> authTeamlist1LsAdmin7 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist1LsAdmin7", user_no);
		model.addAttribute("authTeamlist1LsAdmin7",authTeamlist1LsAdmin7);
		List<TopTmBscVO> authTeamlist4LsAdmin7 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist4LsAdmin7", user_no);
		model.addAttribute("authTeamlist4LsAdmin7",authTeamlist4LsAdmin7);

		List<TopTmBscVO> authTeamlist0LsAdmin9 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist0LsAdmin9", user_no);
		model.addAttribute("authTeamlist0LsAdmin9",authTeamlist0LsAdmin9);
		List<TopTmBscVO> authTeamlist1LsAdmin9 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist1LsAdmin9", user_no);
		model.addAttribute("authTeamlist1LsAdmin9",authTeamlist1LsAdmin9);
		List<TopTmBscVO> authTeamlist4LsAdmin9 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist4LsAdmin9", user_no);
		model.addAttribute("authTeamlist4LsAdmin9",authTeamlist4LsAdmin9);

		List<TopTmBscVO> authTeamlist0LsAdmin10 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist0LsAdmin10", user_no);
		model.addAttribute("authTeamlist0LsAdmin10",authTeamlist0LsAdmin10);
		List<TopTmBscVO> authTeamlist1LsAdmin10 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist1LsAdmin10", user_no);
		model.addAttribute("authTeamlist1LsAdmin10",authTeamlist1LsAdmin10);
		List<TopTmBscVO> authTeamlist4LsAdmin10 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist4LsAdmin10", user_no);
		model.addAttribute("authTeamlist4LsAdmin10",authTeamlist4LsAdmin10);

		List<TopTmBscVO> authTeamlist0LsAdmin11 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist0LsAdmin11", user_no);
		model.addAttribute("authTeamlist0LsAdmin11",authTeamlist0LsAdmin11);
		List<TopTmBscVO> authTeamlist1LsAdmin11 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist1LsAdmin11", user_no);
		model.addAttribute("authTeamlist1LsAdmin11",authTeamlist1LsAdmin11);
		List<TopTmBscVO> authTeamlist4LsAdmin11 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist4LsAdmin11", user_no);
		model.addAttribute("authTeamlist4LsAdmin11",authTeamlist4LsAdmin11);
		
		List<TopTmBscVO> authTeamlist0LsAdmin22 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist0LsAdmin22", user_no);
		model.addAttribute("authTeamlist0LsAdmin22",authTeamlist0LsAdmin22);
		List<TopTmBscVO> authTeamlist1LsAdmin22 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist1LsAdmin22", user_no);
		model.addAttribute("authTeamlist1LsAdmin22",authTeamlist1LsAdmin22);
		List<TopTmBscVO> authTeamlist4LsAdmin22 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist4LsAdmin22", user_no);
		model.addAttribute("authTeamlist4LsAdmin22",authTeamlist4LsAdmin22);
		
		List<TopTmBscVO> authTeamlist0LsAdmin23 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist0LsAdmin23", user_no);
		model.addAttribute("authTeamlist0LsAdmin23",authTeamlist0LsAdmin23);
		List<TopTmBscVO> authTeamlist1LsAdmin23 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist1LsAdmin23", user_no);
		model.addAttribute("authTeamlist1LsAdmin23",authTeamlist1LsAdmin23);
		List<TopTmBscVO> authTeamlist4LsAdmin23 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist4LsAdmin23", user_no);
		model.addAttribute("authTeamlist4LsAdmin23",authTeamlist4LsAdmin23);
		
		List<TopTmBscVO> authTeamlist0LsAdmin24 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist0LsAdmin24", user_no);
		model.addAttribute("authTeamlist0LsAdmin24",authTeamlist0LsAdmin24);
		List<TopTmBscVO> authTeamlist1LsAdmin24 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist1LsAdmin24", user_no);
		model.addAttribute("authTeamlist1LsAdmin24",authTeamlist1LsAdmin24);
		List<TopTmBscVO> authTeamlist4LsAdmin24 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist4LsAdmin24", user_no);
		model.addAttribute("authTeamlist4LsAdmin24",authTeamlist4LsAdmin24);
		
		List<TopTmBscVO> authTeamlist0LsAdminQuick = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist0LsAdminQuick", user_no);
		model.addAttribute("authTeamlist0LsAdminQuick",authTeamlist0LsAdminQuick);
		List<TopTmBscVO> authTeamlist1LsAdminQuick = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist1LsAdminQuick", user_no);
		model.addAttribute("authTeamlist1LsAdminQuick",authTeamlist1LsAdminQuick);
		List<TopTmBscVO> authTeamlist4LsAdminQuick = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist4LsAdminQuick", user_no);
		model.addAttribute("authTeamlist4LsAdminQuick",authTeamlist4LsAdminQuick);
		
		//휴가 1차 결재권한
		List<TopTmBscVO> authTeamlist0LsAdminVacation1 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist0LsAdminVacation1", user_no);
		model.addAttribute("authTeamlist0LsAdminVacation1",authTeamlist0LsAdminVacation1);
		List<TopTmBscVO> authTeamlist1LsAdminVacation1 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist1LsAdminVacation1", user_no);
		model.addAttribute("authTeamlist1LsAdminVacation1",authTeamlist1LsAdminVacation1);
		List<TopTmBscVO> authTeamlist4LsAdminVacation1 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist4LsAdminVacation1", user_no);		
		model.addAttribute("authTeamlist4LsAdminVacation1",authTeamlist4LsAdminVacation1);
		
		//휴가 2차 결재권한
		List<TopTmBscVO> authTeamlist0LsAdminVacation2 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist0LsAdminVacation2", user_no);
		model.addAttribute("authTeamlist0LsAdminVacation2",authTeamlist0LsAdminVacation2);
		List<TopTmBscVO> authTeamlist1LsAdminVacation2 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist1LsAdminVacation2", user_no);
		model.addAttribute("authTeamlist1LsAdminVacation2",authTeamlist1LsAdminVacation2);
		List<TopTmBscVO> authTeamlist4LsAdminVacation2 = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist4LsAdminVacation2", user_no);		
		model.addAttribute("authTeamlist4LsAdminVacation2",authTeamlist4LsAdminVacation2);
		
		//손해사정서 미교부 팀 팝업조회권한
		List<TopTmBscVO> authTeamlist0LsAdminNoSend = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist0LsAdminNoSend", user_no);
		model.addAttribute("authTeamlist0LsAdminNoSend",authTeamlist0LsAdminNoSend);
		List<TopTmBscVO> authTeamlist1LsAdminNoSend = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist1LsAdminNoSend", user_no);
		model.addAttribute("authTeamlist1LsAdminNoSend",authTeamlist1LsAdminNoSend);
		List<TopTmBscVO> authTeamlist4LsAdminNoSend = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist4LsAdminNoSend", user_no);		
		model.addAttribute("authTeamlist4LsAdminNoSend",authTeamlist4LsAdminNoSend);
		
		//현장보고서 겸직자 결재팀 설정
		List<TopTmBscVO> authTeamlist0LsApprovalSite = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist0LsApprovalSite", user_no);
		model.addAttribute("authTeamlist0LsApprovalSite",authTeamlist0LsApprovalSite);
		List<TopTmBscVO> authTeamlist1LsApprovalSite = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist1LsApprovalSite", user_no);
		model.addAttribute("authTeamlist1LsApprovalSite",authTeamlist1LsApprovalSite);
		List<TopTmBscVO> authTeamlist4LsApprovalSite = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamlist4LsApprovalSite", user_no);		
		model.addAttribute("authTeamlist4LsApprovalSite",authTeamlist4LsApprovalSite);
		
		//오늘 휴가자 조회팀 설정
		List<TopTmBscVO> authTeamList0LsTodayVacation = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamList0LsTodayVacation", user_no);
		model.addAttribute("authTeamList0LsTodayVacation",authTeamList0LsTodayVacation);
		List<TopTmBscVO> authTeamList1LsTodayVacation = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamList1LsTodayVacation", user_no);
		model.addAttribute("authTeamList1LsTodayVacation",authTeamList1LsTodayVacation);
		List<TopTmBscVO> authTeamList4LsTodayVacation = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamList4LsTodayVacation", user_no);
		model.addAttribute("authTeamList4LsTodayVacation",authTeamList4LsTodayVacation);
		
		//보고서 위임취소 결재권한 설정
		List<TopTmBscVO> authTeamList0RptCancelApproval = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamList0RptCancelApproval", user_no);
		model.addAttribute("authTeamList0RptCancelApproval",authTeamList0RptCancelApproval);
		List<TopTmBscVO> authTeamList1RptCancelApproval = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamList1RptCancelApproval", user_no);
		model.addAttribute("authTeamList1RptCancelApproval",authTeamList1RptCancelApproval);
		List<TopTmBscVO> authTeamList4RptCancelApproval = sqlSession.selectList("PopMbrAuth2DtlMapper.authTeamList4RptCancelApproval", user_no);
		model.addAttribute("authTeamList4RptCancelApproval",authTeamList4RptCancelApproval);

		model.addAttribute("user_no",user_no);

		return "top_team/pop_mbr_auth2_dtl";
	}//popMbrAuth2Dtl

	@RequestMapping(value = "popMbrAuth2DtlIns", method = RequestMethod.POST)
	public String popMbrAuth2DtlIns(Model model, HttpSession session, HttpServletRequest request
			, String user_no, String[] cb_rpt_edit) {

		logger.info("======= popMbrAuth2DtlIns =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		//if(mbrVo == null || !(mbrVo.getUser_state().equals("9"))){
		if(mbrVo == null || !(mbrVo.getUser_state().equals("9") || mbrVo.getUser_no().equals("62") )){
			logger.info("popMbrAuth2DtlIns - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		String tmpTxt = "|";
		int  tmpLength = 0;
		if (cb_rpt_edit != null){
			tmpLength = cb_rpt_edit.length;
		}
		
		for(int i = 0; i < tmpLength; i++){
			tmpTxt = tmpTxt + cb_rpt_edit[i] + "|";
		}

		HashMap<String,String> map = new HashMap<String, String>();	
		map.put("user_no", user_no);
		map.put("tmpTxt", tmpTxt);
		map.put("edit_user_no", mbrVo.getUser_no());

		int selectResult = 0;
		selectResult = sqlSession.selectOne("PopMbrAuth2DtlMapper.getLsAdminCnt", user_no);

		int result = 0;
		if(selectResult > 0){
			result = sqlSession.update("PopMbrAuth2DtlMapper.udtMbrAuth2Dtl", map);
		}else{
			result = sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuth2Dtl", map);
		}

		if(result > 0){
			sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuth2DtlLog", map);
		}

		return "redirect:/popMbrAuth2Dtl?user_no="+user_no+"#00";
	}//popMbrAuth2DtlIns

	@RequestMapping(value = "popMbrAuth2DtlLsAdmin7Ins", method = RequestMethod.POST)
	public String popMbrAuth2DtlLsAdmin7Ins(Model model, HttpSession session, HttpServletRequest request
			, String user_no, String[] cb_ls_admin7) {

		logger.info("======= popMbrAuth2DtlLsAdmin7Ins =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		//if(mbrVo == null || !(mbrVo.getUser_state().equals("9"))){
		if(mbrVo == null || !(mbrVo.getUser_state().equals("9") || mbrVo.getUser_no().equals("62") )){
			logger.info("popMbrAuth2DtlLsAdmin7Ins - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		String tmpTxt = "|";
		
		int  tmpLength = 0;
		if (cb_ls_admin7 != null){
			tmpLength = cb_ls_admin7.length;
		}
		
		for(int i = 0; i < tmpLength; i++){
			tmpTxt = tmpTxt + cb_ls_admin7[i] + "|";
		}
		

		HashMap<String,String> map = new HashMap<String, String>();	
		map.put("user_no", user_no);
		map.put("tmpTxt", tmpTxt);
		map.put("edit_user_no", mbrVo.getUser_no());

		int selectResult = 0;
		selectResult = sqlSession.selectOne("PopMbrAuth2DtlMapper.getLsAdminCnt", user_no);

		int result = 0;
		if(selectResult > 0){
			result = sqlSession.update("PopMbrAuth2DtlMapper.udtMbrAuth2DtlLsAdmin7", map);
		}else{
			result = sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuth2DtlLsAdmin7", map);
		}

		if(result > 0){
			sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuth2DtlLog", map);
		}

		return "redirect:/popMbrAuth2Dtl?user_no="+user_no+"#01";
	}//popMbrAuth2DtlLsAdmin7Ins

	@RequestMapping(value = "popMbrAuth2DtlLsAdmin9Ins", method = RequestMethod.POST)
	public String popMbrAuth2DtlLsAdmin9Ins(Model model, HttpSession session, HttpServletRequest request
			, String user_no, String[] cb_ls_admin9) {

		logger.info("======= popMbrAuth2DtlLsAdmin9Ins =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		//if(mbrVo == null || !(mbrVo.getUser_state().equals("9"))){
		if(mbrVo == null || !(mbrVo.getUser_state().equals("9") || mbrVo.getUser_no().equals("62") )){
			logger.info("popMbrAuth2DtlLsAdmin9Ins - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		String tmpTxt = "|";
		int  tmpLength = 0;
		if (cb_ls_admin9 != null){
			tmpLength = cb_ls_admin9.length;
		}
		
		for(int i = 0; i < tmpLength; i++){
			tmpTxt = tmpTxt + cb_ls_admin9[i] + "|";
		}
		
		
		

		HashMap<String,String> map = new HashMap<String, String>();	
		map.put("user_no", user_no);
		map.put("tmpTxt", tmpTxt);
		map.put("edit_user_no", mbrVo.getUser_no());

		int selectResult = 0;
		selectResult = sqlSession.selectOne("PopMbrAuth2DtlMapper.getLsAdminCnt", user_no);

		int result = 0;
		if(selectResult > 0){
			result = sqlSession.update("PopMbrAuth2DtlMapper.udtMbrAuth2DtlLsAdmin9", map);
		}else{
			result = sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuth2DtlLsAdmin9", map);
		}

		if(result > 0){
			sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuth2DtlLog", map);
		}

		return "redirect:/popMbrAuth2Dtl?user_no="+user_no+"#02";
	}//popMbrAuth2DtlLsAdmin9Ins

	@RequestMapping(value = "popMbrAuth2DtlLsAdmin10Ins", method = RequestMethod.POST)
	public String popMbrAuth2DtlLsAdmin10Ins(Model model, HttpSession session, HttpServletRequest request
			, String user_no, String[] cb_ls_admin10) {

		logger.info("======= popMbrAuth2DtlLsAdmin10Ins =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		//if(mbrVo == null || !(mbrVo.getUser_state().equals("9"))){
		if(mbrVo == null || !(mbrVo.getUser_state().equals("9") || mbrVo.getUser_no().equals("62") )){
			logger.info("popMbrAuth2DtlLsAdmin10Ins - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		String tmpTxt = "|";
		int  tmpLength = 0;
		if (cb_ls_admin10 != null){
			tmpLength = cb_ls_admin10.length;
		}
		
		for(int i = 0; i < tmpLength; i++){
			tmpTxt = tmpTxt + cb_ls_admin10[i] + "|";
		}
		
		
		

		HashMap<String,String> map = new HashMap<String, String>();	
		map.put("user_no", user_no);
		map.put("tmpTxt", tmpTxt);
		map.put("edit_user_no", mbrVo.getUser_no());

		int selectResult = 0;
		selectResult = sqlSession.selectOne("PopMbrAuth2DtlMapper.getLsAdminCnt", user_no);

		int result = 0;
		if(selectResult > 0){
			result = sqlSession.update("PopMbrAuth2DtlMapper.udtMbrAuth2DtlLsAdmin10", map);
		}else{
			result = sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuth2DtlLsAdmin10", map);
		}

		if(result > 0){
			sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuth2DtlLog", map);
		}

		return "redirect:/popMbrAuth2Dtl?user_no="+user_no+"#03";
	}//popMbrAuth2DtlLsAdmin10Ins

	@RequestMapping(value = "popMbrAuth2DtlLsAdmin11Ins", method = RequestMethod.POST)
	public String popMbrAuth2DtlLsAdmin11Ins(Model model, HttpSession session, HttpServletRequest request
			, String user_no, String[] cb_ls_admin11) {

		logger.info("======= popMbrAuth2DtlLsAdmin11Ins =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		//if(mbrVo == null || !(mbrVo.getUser_state().equals("9"))){
		if(mbrVo == null || !(mbrVo.getUser_state().equals("9") || mbrVo.getUser_no().equals("62") )){
			logger.info("popMbrAuth2DtlLsAdmin11Ins - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		String tmpTxt = "|";
		int  tmpLength = 0;
		if (cb_ls_admin11 != null){
			tmpLength = cb_ls_admin11.length;
		}
		
		for(int i = 0; i < tmpLength; i++){
			tmpTxt = tmpTxt + cb_ls_admin11[i] + "|";
		}

		HashMap<String,String> map = new HashMap<String, String>();	
		map.put("user_no", user_no);
		map.put("tmpTxt", tmpTxt);
		map.put("edit_user_no", mbrVo.getUser_no());

		int selectResult = 0;
		selectResult = sqlSession.selectOne("PopMbrAuth2DtlMapper.getLsAdminCnt", user_no);

		int result = 0;
		if(selectResult > 0){
			result = sqlSession.update("PopMbrAuth2DtlMapper.udtMbrAuth2DtlLsAdmin11", map);
		}else{
			result = sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuth2DtlLsAdmin11", map);
		}

		if(result > 0){
			sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuth2DtlLog", map);
		}

		return "redirect:/popMbrAuth2Dtl?user_no="+user_no+"#04";
	}//popMbrAuth2DtlLsAdmin11Ins

	
	@RequestMapping(value = "popMbrAuth2DtlLsAdmin22Ins", method = RequestMethod.POST)
	public String popMbrAuth2DtlLsAdmin22Ins(Model model, HttpSession session, HttpServletRequest request
			, String user_no, String[] cb_ls_admin22) {

		logger.info("======= popMbrAuth2DtlLsAdmin22Ins =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		//if(mbrVo == null || !(mbrVo.getUser_state().equals("9"))){
		if(mbrVo == null || !(mbrVo.getUser_state().equals("9") || mbrVo.getUser_no().equals("62") )){
			logger.info("popMbrAuth2DtlLsAdmin22Ins - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		String tmpTxt = "|";
		int  tmpLength = 0;
		if (cb_ls_admin22 != null){
			tmpLength = cb_ls_admin22.length;
		}
		
		for(int i = 0; i < tmpLength; i++){
			tmpTxt = tmpTxt + cb_ls_admin22[i] + "|";
		}

		HashMap<String,String> map = new HashMap<String, String>();	
		map.put("user_no", user_no);
		map.put("tmpTxt", tmpTxt);
		map.put("edit_user_no", mbrVo.getUser_no());

		int selectResult = 0;
		selectResult = sqlSession.selectOne("PopMbrAuth2DtlMapper.getLsAdminCnt", user_no);

		int result = 0;
		if(selectResult > 0){
			result = sqlSession.update("PopMbrAuth2DtlMapper.udtMbrAuth2DtlLsAdmin22", map);
		}else{
			result = sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuth2DtlLsAdmin22", map);
		}

		if(result > 0){
			sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuth2DtlLog", map);
		}

		return "redirect:/popMbrAuth2Dtl?user_no="+user_no+"#05";
	}//popMbrAuth2DtlLsAdmin22Ins
	
	
	@RequestMapping(value = "popMbrAuth2DtlLsAdmin23Ins", method = RequestMethod.POST)
	public String popMbrAuth2DtlLsAdmin23Ins(Model model, HttpSession session, HttpServletRequest request
			, String user_no, String[] cb_ls_admin23) {

		logger.info("======= popMbrAuth2DtlLsAdmin23Ins =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		//if(mbrVo == null || !(mbrVo.getUser_state().equals("9"))){
		if(mbrVo == null || !(mbrVo.getUser_state().equals("9") || mbrVo.getUser_no().equals("62") )){
			logger.info("popMbrAuth2DtlLsAdmin23Ins - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		String tmpTxt = "|";
		int  tmpLength = 0;
		if (cb_ls_admin23 != null){
			tmpLength = cb_ls_admin23.length;
		}
		
		for(int i = 0; i < tmpLength; i++){
			tmpTxt = tmpTxt + cb_ls_admin23[i] + "|";
		}

		HashMap<String,String> map = new HashMap<String, String>();	
		map.put("user_no", user_no);
		map.put("tmpTxt", tmpTxt);
		map.put("edit_user_no", mbrVo.getUser_no());

		int selectResult = 0;
		selectResult = sqlSession.selectOne("PopMbrAuth2DtlMapper.getLsAdminCnt", user_no);

		int result = 0;
		if(selectResult > 0){
			result = sqlSession.update("PopMbrAuth2DtlMapper.udtMbrAuth2DtlLsAdmin23", map);
		}else{
			result = sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuth2DtlLsAdmin23", map);
		}

		if(result > 0){
			sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuth2DtlLog", map);
		}

		return "redirect:/popMbrAuth2Dtl?user_no="+user_no+"#06";
	}//popMbrAuth2DtlLsAdmin23Ins
	
	@RequestMapping(value = "popMbrAuth2DtlLsAdmin24Ins", method = RequestMethod.POST)
	public String popMbrAuth2DtlLsAdmin24Ins(Model model, HttpSession session, HttpServletRequest request
			, String user_no, String[] cb_ls_admin24) {

		logger.info("======= popMbrAuth2DtlLsAdmin24Ins =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		//if(mbrVo == null || !(mbrVo.getUser_state().equals("9"))){
		if(mbrVo == null || !(mbrVo.getUser_state().equals("9") || mbrVo.getUser_no().equals("62") )){
			logger.info("popMbrAuth2DtlLsAdmin24Ins - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		String tmpTxt = "|";
		int  tmpLength = 0;
		if (cb_ls_admin24 != null){
			tmpLength = cb_ls_admin24.length;
		}
		
		for(int i = 0; i < tmpLength; i++){
			tmpTxt = tmpTxt + cb_ls_admin24[i] + "|";
		}

		HashMap<String,String> map = new HashMap<String, String>();	
		map.put("user_no", user_no);
		map.put("tmpTxt", tmpTxt);
		map.put("edit_user_no", mbrVo.getUser_no());

		int selectResult = 0;
		selectResult = sqlSession.selectOne("PopMbrAuth2DtlMapper.getLsAdminCnt", user_no);

		int result = 0;
		if(selectResult > 0){
			result = sqlSession.update("PopMbrAuth2DtlMapper.udtMbrAuth2DtlLsAdmin24", map);
		}else{
			result = sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuth2DtlLsAdmin24", map);
		}

		if(result > 0){
			sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuth2DtlLog", map);
		}

		return "redirect:/popMbrAuth2Dtl?user_no="+user_no+"#07";
	}//popMbrAuth2DtlLsAdmin23Ins
	
	@RequestMapping(value = "popMbrAuth2DtlLsAdminQuickIns", method = RequestMethod.POST)
	public String popMbrAuth2DtlLsAdminQuickIns(Model model, HttpSession session, HttpServletRequest request
			, String user_no, String[] cb_ls_admin_quick) {

		logger.info("======= popMbrAuth2DtlLsAdminQuickIns =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		//if(mbrVo == null || !(mbrVo.getUser_state().equals("9"))){
		if(mbrVo == null || !(mbrVo.getUser_state().equals("9") || mbrVo.getUser_no().equals("62") )){
			logger.info("popMbrAuth2DtlLsAdminQuickIns - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		String tmpTxt = "|";
		int  tmpLength = 0;
		if (cb_ls_admin_quick != null){
			tmpLength = cb_ls_admin_quick.length;
		}
		
		for(int i = 0; i < tmpLength; i++){
			tmpTxt = tmpTxt + cb_ls_admin_quick[i] + "|";
		}

		HashMap<String,String> map = new HashMap<String, String>();	
		map.put("user_no", user_no);
		map.put("tmpTxt", tmpTxt);
		map.put("edit_user_no", mbrVo.getUser_no());

		int selectResult = 0;
		selectResult = sqlSession.selectOne("PopMbrAuth2DtlMapper.getLsAdminCnt", user_no);

		int result = 0;
		if(selectResult > 0){
			result = sqlSession.update("PopMbrAuth2DtlMapper.udtMbrAuthDtlLsAdminQuick", map);
		}else{
			result = sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuthDtlLsAdminQuick", map);
		}

		if(result > 0){
			sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuth2DtlLog", map);
		}

		return "redirect:/popMbrAuth2Dtl?user_no="+user_no+"#08";
	}//popMbrAuth2DtlLsAdmin23Ins
	
	@RequestMapping(value = "popMbrAuth2DtlLsAdminVacation1Ins", method = RequestMethod.POST)
	public String popMbrAuth2DtlLsAdminVacation1Ins(Model model, HttpSession session, HttpServletRequest request
			, String user_no, String[] cb_ls_admin_vacation1) {

		logger.info("======= popMbrAuth2DtlLsAdminVacation1Ins =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		//if(mbrVo == null || !(mbrVo.getUser_state().equals("9"))){
		if(mbrVo == null || !(mbrVo.getUser_state().equals("9") || mbrVo.getUser_no().equals("62") )){
			logger.info("popMbrAuth2DtlLsAdminVacation1Ins - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		String tmpTxt = "|";
		int  tmpLength = 0;
		if (cb_ls_admin_vacation1 != null){
			tmpLength = cb_ls_admin_vacation1.length;
		}
		
		for(int i = 0; i < tmpLength; i++){
			tmpTxt = tmpTxt + cb_ls_admin_vacation1[i] + "|";
		}

		HashMap<String,String> map = new HashMap<String, String>();	
		map.put("user_no", user_no);
		map.put("tmpTxt", tmpTxt);
		map.put("edit_user_no", mbrVo.getUser_no());

		int selectResult = 0;
		selectResult = sqlSession.selectOne("PopMbrAuth2DtlMapper.getLsAdminCnt", user_no);

		int result = 0;
		if(selectResult > 0){
			result = sqlSession.update("PopMbrAuth2DtlMapper.udtMbrAuthDtlLsAdminVacation1", map);
		}else{
			result = sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuthDtlLsAdminVacation1", map);
		}

		if(result > 0){
			sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuth2DtlLog", map);
		}

		return "redirect:/popMbrAuth2Dtl?user_no="+user_no+"#09";
	}//popMbrAuth2DtlLsAdminVacation1Ins
	
	@RequestMapping(value = "popMbrAuth2DtlLsAdminNoSendIns", method = RequestMethod.POST)
	public String popMbrAuth2DtlLsAdminNoSendIns(Model model, HttpSession session, HttpServletRequest request
			, String user_no, String[] cb_ls_admin_nosend) {

		logger.info("======= popMbrAuth2DtlLsAdminNoSendIns =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

		if(mbrVo == null || !(mbrVo.getUser_state().equals("9") || mbrVo.getUser_no().equals("62") )){
			logger.info("popMbrAuth2DtlLsAdminNoSendIns - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		String tmpTxt = "|";
		int  tmpLength = 0;
		if (cb_ls_admin_nosend != null){
			tmpLength = cb_ls_admin_nosend.length;
		}
		
		for(int i = 0; i < tmpLength; i++){
			tmpTxt = tmpTxt + cb_ls_admin_nosend[i] + "|";
		}

		HashMap<String,String> map = new HashMap<String, String>();	
		map.put("user_no", user_no);
		map.put("tmpTxt", tmpTxt);
		map.put("edit_user_no", mbrVo.getUser_no());

		int selectResult = 0;
		selectResult = sqlSession.selectOne("PopMbrAuth2DtlMapper.getLsAdminCnt", user_no);

		int result = 0;
		if(selectResult > 0){
			result = sqlSession.update("PopMbrAuth2DtlMapper.udtMbrAuthDtlLsAdminNoSend", map);
		}else{
			result = sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuthDtlLsAdminNoSend", map);
		}

		if(result > 0){
			sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuth2DtlLog", map);
		}

		return "redirect:/popMbrAuth2Dtl?user_no="+user_no+"#10";
	}//popMbrAuth2DtlLsAdminNoSendIns
	
	@RequestMapping(value = "popMbrAuth2DtlLsApprovalSiteIns", method = RequestMethod.POST)
	public String popMbrAuth2DtlLsApprovalSiteIns(Model model, HttpSession session, HttpServletRequest request
			, String user_no, String[] cb_ls_approval_site) {

		logger.info("======= popMbrAuth2DtlLsApprovalSiteIns =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

		if(mbrVo == null || !(mbrVo.getUser_state().equals("9") || mbrVo.getUser_no().equals("62") )){
			logger.info("popMbrAuth2DtlLsApprovalSiteIns - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		String tmpTxt = "|";
		int  tmpLength = 0;
		if (cb_ls_approval_site != null){
			tmpLength = cb_ls_approval_site.length;
		}
		
		for(int i = 0; i < tmpLength; i++){
			tmpTxt = tmpTxt + cb_ls_approval_site[i] + "|";
		}

		HashMap<String,String> map = new HashMap<String, String>();	
		map.put("user_no", user_no);
		map.put("tmpTxt", tmpTxt);
		map.put("edit_user_no", mbrVo.getUser_no());

		int selectResult = 0;
		selectResult = sqlSession.selectOne("PopMbrAuth2DtlMapper.getLsAdminCnt", user_no);

		int result = 0;
		if(selectResult > 0){
			result = sqlSession.update("PopMbrAuth2DtlMapper.udtMbrAuth2DtlLsApprovalSite", map);
		}else{
			result = sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuth2DtlLsApprovalSite", map);
		}

		if(result > 0){
			sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuth2DtlLog", map);
		}

		return "redirect:/popMbrAuth2Dtl?user_no="+user_no+"#11";
	}//popMbrAuth2DtlLsAdminNoSendIns
	
	@RequestMapping(value = "popMbrAuth2DtlLsTodayVacationIns", method = RequestMethod.POST)
	public String popMbrAuth2DtlLsTodayVacationIns(Model model, HttpSession session, HttpServletRequest request
			, String user_no, String[] cb_ls_today_vacation) {

		logger.info("======= popMbrAuth2DtlLsTodayVacationIns =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

		if(mbrVo == null || !(mbrVo.getUser_state().equals("9") || mbrVo.getUser_no().equals("62") )){
			logger.info("popMbrAuth2DtlLsTodayVacationIns - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		String tmpTxt = "|";
		int  tmpLength = 0;
		if (cb_ls_today_vacation != null){
			tmpLength = cb_ls_today_vacation.length;
		}
		
		for(int i = 0; i < tmpLength; i++){
			tmpTxt = tmpTxt + cb_ls_today_vacation[i] + "|";
		}

		HashMap<String,String> map = new HashMap<String, String>();	
		map.put("user_no", user_no);
		map.put("tmpTxt", tmpTxt);
		map.put("edit_user_no", mbrVo.getUser_no());

		int selectResult = 0;
		selectResult = sqlSession.selectOne("PopMbrAuth2DtlMapper.getLsAdminCnt", user_no);

		int result = 0;
		if(selectResult > 0){
			result = sqlSession.update("PopMbrAuth2DtlMapper.udtMbrAuth2DtlLsTodayVacation", map);
		}else{
			result = sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuth2DtlLsTodayVacation", map);
		}

		if(result > 0){
			sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuth2DtlLog", map);
		}

		return "redirect:/popMbrAuth2Dtl?user_no="+user_no+"#12";
	}//popMbrAuth2DtlLsTodayVacationIns
	
	
	@RequestMapping(value = "popMbrAuth2DtlLsRptCancelApprovalIns", method = RequestMethod.POST)
	public String popMbrAuth2DtlLsRptCancelApprovalIns(Model model, HttpSession session, HttpServletRequest request
			, String user_no, String[] cb_ls_rpt_cancel_approval) {

		logger.info("======= popMbrAuth2DtlLsRptCancelApprovalIns =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

		if(mbrVo == null || !(mbrVo.getUser_state().equals("9") || mbrVo.getUser_no().equals("62") )){
			logger.info("popMbrAuth2DtlLsRptCancelApprovalIns - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		String tmpTxt = "|";
		int  tmpLength = 0;
		if (cb_ls_rpt_cancel_approval != null){
			tmpLength = cb_ls_rpt_cancel_approval.length;
		}
		
		for(int i = 0; i < tmpLength; i++){
			tmpTxt = tmpTxt + cb_ls_rpt_cancel_approval[i] + "|";
		}

		HashMap<String,String> map = new HashMap<String, String>();	
		map.put("user_no", user_no);
		map.put("tmpTxt", tmpTxt);
		map.put("edit_user_no", mbrVo.getUser_no());

		int selectResult = 0;
		selectResult = sqlSession.selectOne("PopMbrAuth2DtlMapper.getLsAdminCnt", user_no);

		int result = 0;
		if(selectResult > 0){
			result = sqlSession.update("PopMbrAuth2DtlMapper.udtMbrAuth2DtlLsRptCancelApproval", map);
		}else{
			result = sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuth2DtlLsTodayVacation", map);
		}

		if(result > 0){
			sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuth2DtlLog", map);
		}

		return "redirect:/popMbrAuth2Dtl?user_no="+user_no+"#13";
	}//popMbrAuth2DtlLsRptCancelApprovalIns
	
	@RequestMapping(value = "popMbrAuth2DtlLsAdminVacation2Ins", method = RequestMethod.POST)
	public String popMbrAuth2DtlLsAdminVacation2Ins(Model model, HttpSession session, HttpServletRequest request
			, String user_no, String[] cb_ls_admin_vacation2) {

		logger.info("======= popMbrAuth2DtlLsAdminVacation2Ins =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		//if(mbrVo == null || !(mbrVo.getUser_state().equals("9"))){
		if(mbrVo == null || !(mbrVo.getUser_state().equals("9") || mbrVo.getUser_no().equals("62") )){
			logger.info("popMbrAuth2DtlLsAdminVacation2Ins - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		String tmpTxt = "|";
		int  tmpLength = 0;
		if (cb_ls_admin_vacation2 != null){
			tmpLength = cb_ls_admin_vacation2.length;
		}
		
		for(int i = 0; i < tmpLength; i++){
			tmpTxt = tmpTxt + cb_ls_admin_vacation2[i] + "|";
		}

		HashMap<String,String> map = new HashMap<String, String>();	
		map.put("user_no", user_no);
		map.put("tmpTxt", tmpTxt);
		map.put("edit_user_no", mbrVo.getUser_no());

		int selectResult = 0;
		selectResult = sqlSession.selectOne("PopMbrAuth2DtlMapper.getLsAdminCnt", user_no);

		int result = 0;
		if(selectResult > 0){
			result = sqlSession.update("PopMbrAuth2DtlMapper.udtMbrAuthDtlLsAdminVacation2", map);
		}else{
			result = sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuthDtlLsAdminVacation2", map);
		}

		if(result > 0){
			sqlSession.insert("PopMbrAuth2DtlMapper.insMbrAuth2DtlLog", map);
		}

		return "redirect:/popMbrAuth2Dtl?user_no="+user_no;
	}//popMbrAuth2DtlLsAdminVacation2Ins
}//end of class
