package kr.co.toplac.topindividual;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.topteam.TopMbrAppointVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopMbrCareerVO;
import kr.co.toplac.topteam.TopMbrEducationVO;
import kr.co.toplac.topteam.TopMbrFamilyVO;
import kr.co.toplac.topteam.TopMbrSgnVO;
import kr.co.toplac.topteam.TopMbrViewVO;
import kr.co.toplac.topteam.TopMbrWorkVO;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.enc.EncryptUtil;
import kr.co.toplac.util.etc.SecurityUtil;
import kr.co.toplac.util.etc.SplitPhoneNo;
import kr.co.toplac.util.file.GetImageBase64;
import kr.co.toplac.util.rpt.MainLeftUtil;

@Controller
public class MyInfoUdtController {
	
	private static final Logger logger = LoggerFactory.getLogger(MyInfoUdtController.class);
    private static final String UPLOAD_PATH_MMS = "/home/hosting_users/toplac/www/ls_data/member_mms/";
    //private static final String UPLOAD_PATH_MMS = "/Users/kohyeonseok/devroot/91.devUpload/toplac/hosting_users/toplac/www/ls_data/member_mms/";
	
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	MainLeftUtil mlu;

	/**내 정보 화면 호출 **/
	@RequestMapping(value = "myInfo", method = RequestMethod.GET)
	public String myinfo(Model model, HttpSession session, String fromPage, HttpServletRequest request) {
		
		String user_no = "";
		
		logger.info("======= myInfo =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(session.getAttribute("user_no_Session") ==null ){
			logger.info("myinfo - no session ");
			session.invalidate();
			return "top_login/top_login";
		}

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		GetImageBase64 imageUtil = new GetImageBase64();
		
		user_no = (String) session.getAttribute("user_no_Session");
		
		TopMbrBscVO memberVo = sqlSession.selectOne("MyInfoUdtMapper.myinfo", user_no);
		
		TopMbrSgnVO signVo = sqlSession.selectOne("MyInfoUdtMapper.membersign",user_no);

		SplitPhoneNo splitPhoneNo = new SplitPhoneNo();
		//자택 전화번호
		if( (memberVo.getHome_tel() != null) && (!memberVo.getHome_tel().equals("")) ){
			splitPhoneNo.splitPhoneNo(model, memberVo.getHome_tel(), "-", "home_tel");
		}
		//회사 전화번호
		if((memberVo.getOffice_tel() != null) && (!memberVo.getOffice_tel().equals(""))){
			splitPhoneNo.splitPhoneNo(model, memberVo.getOffice_tel(), "-", "officetel");
		}
		//팩스 번호
		if((memberVo.getOffice_fax() != null) && (!memberVo.getOffice_fax().equals(""))){
			splitPhoneNo.splitPhoneNo(model, memberVo.getOffice_fax(), "-", "officefax");
		}
		//핸드폰 번호
		if((memberVo.getHandphone() != null) && (!memberVo.getHandphone().equals(""))){
			splitPhoneNo.splitPhoneNo(model, memberVo.getHandphone(), "-", "handphone");
		}

		/* 이미지 시작 */
		if( (memberVo.getPicture() != null ) ){
			if(!memberVo.getPicture().equals("")){
				String dbpath = "/home/hosting_users/toplac/www/ls_data/member/"+memberVo.getPicture();
				String fileType = dbpath.substring(dbpath.lastIndexOf(".")+1, dbpath.length());
				
				model.addAttribute("imageBase64", imageUtil.imageBase64Small(dbpath, fileType));
			}
		}

		//=====================================================
		//  MMS 이미지
		//=====================================================
		try {
			
			if (memberVo.getMmsPicture() != null && !"".equals(memberVo.getMmsPicture())){
	            String dbpath = UPLOAD_PATH_MMS + memberVo.getMmsPicture();
	            String fileType = dbpath.substring(dbpath.lastIndexOf(".")+1, dbpath.length());
	            model.addAttribute("mmsImageBase64", imageUtil.imageBase64Small(dbpath, fileType));
	        }else{
	            model.addAttribute("mmsImageBase64", "");
	        }
			
		}catch (Exception e) {
			logger.error("MMS Image Error : "+user_no);
			model.addAttribute("mmsImageBase64", "");
		}

		if(signVo != null){
			
			String dbpath = "";
			String fileType = "";
			
			dbpath = "/home/hosting_users/toplac/www/ls_data/member_sign/"+user_no+"/"+signVo.getUser_sign();
			
			fileType = dbpath.substring(dbpath.lastIndexOf(".")+1, dbpath.length());
			
//			signVo.setSign_buffer(imageUtil.getOneImgeBase64(dbpath, fileType));
			model.addAttribute("signImg",dbpath);
			
		}
		
		if(fromPage !=  null){
			if(fromPage.equals("login")){
				model.addAttribute("fromPage", "login");
			}			
		}
		
		//email_pwd 복호화
		String encEmailPwd = memberVo.getEmail_pwd();		
		String decEmailPwd = SecurityUtil.aesDecrypt(encEmailPwd, "");
		

		model.addAttribute("signVo", signVo);
		model.addAttribute("memberVo", memberVo);		
		model.addAttribute("page", "myinfo");
		//복호화된 이메일 비밀번호
		model.addAttribute("email_pwd", decEmailPwd);
		
		//발령사항
		List<TopMbrAppointVO> getMbrAppoint = sqlSession.selectList("PopMbrAppointMapper.getMbrAppoint",user_no); 
		model.addAttribute("getMbrAppoint",getMbrAppoint);
		
		//진급사항
		List<TopMbrAppointVO> getMbrPosition = sqlSession.selectList("PopMbrAppointMapper.getMbrPosition",user_no);
		model.addAttribute("getMbrPosition",getMbrPosition);
		
		//상/벌 사항
		List<Map<String,Object>> getAwardList = sqlSession.selectList("PopMbrAppointMapper.getMbrAward",user_no);
		model.addAttribute("getAwardList",getAwardList);
		
		//휴직사항
		List<TopMbrWorkVO> getMbrWork = sqlSession.selectList("PopMbrAppointMapper.getMbrWork",user_no);
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//휴직 날짜 자동계산		
		String sDate = "";
		String eDate = "";
		String old_sDate = "";
		String old_eDate = "";
		int nInterval = 0;
		int nWorkInterval = 0;
		int diffDayCnt = 0;
		int eventDayCnt = 0;
		
		for(int i=0; i < getMbrWork.size(); i++) {
			sDate = getMbrWork.get(i).getWork_sdate_fmt();
			old_sDate = sDate.replaceAll("-", "");
			
			eDate = getMbrWork.get(i).getWork_edate_fmt();
			
			if(eDate == null || "".equals(eDate)){
				eDate = DateUtil.getTodayString("yyyy-MM-dd");
				old_eDate = DateUtil.getTodayString();
			}else{				
				old_eDate = eDate.replaceAll("-", "");
			}
			
			nInterval = DateUtil.getDiffDayCountNew(sDate, eDate)+1;				//신청일포함되므로 +1
			getMbrWork.get(i).setLeave_interval(String.valueOf(nInterval));						
			
			diffDayCnt = DateUtil.getDiffDayCountNotWeekend(old_sDate, old_eDate);
			
			paramMap.put("vacationStartDate", old_sDate);
			paramMap.put("vacationEndDate", old_eDate);
			
			eventDayCnt = sqlSession.selectOne("topVacationMapper.selectEventDayCnt",paramMap);			
			nWorkInterval = diffDayCnt - eventDayCnt;
			
			getMbrWork.get(i).setWork_interval(String.valueOf(nWorkInterval));					//소정근로일수			
		}		
		
		model.addAttribute("getMbrWork",getMbrWork);
		
		//경력사항
		List<TopMbrCareerVO> getMbrCareer = sqlSession.selectList("PopMbrCareerMapper.getMbrCareer",user_no);
		model.addAttribute("getMbrCareer",getMbrCareer);
		
		//경력 근속누계
		TopMbrCareerVO getMbrCareerSum = sqlSession.selectOne("PopMbrCareerMapper.getMbrCareerSum",user_no);
		model.addAttribute("getMbrCareerSum",getMbrCareerSum);
		
		TopMbrCareerVO getMbrCareerConstructSum = sqlSession.selectOne("PopMbrCareerMapper.getMbrCareerConstructSum",user_no);
		model.addAttribute("getMbrCareerConstructSum",getMbrCareerConstructSum);
		
		TopMbrCareerVO getMbrCareerGeneralSum = sqlSession.selectOne("PopMbrCareerMapper.getMbrCareerGeneralSum",user_no);
		model.addAttribute("getMbrCareerGeneralSum",getMbrCareerGeneralSum);		
		
		List<Map<String, Object>> getMbrCareerCst = sqlSession.selectList("PopMbrCareerMapper.getMbrCareerConstruct",user_no);
		model.addAttribute("getMbrCareerCst", getMbrCareerCst);
		
		List<Map<String, Object>> getMbrCareerGnl = sqlSession.selectList("PopMbrCareerMapper.getMbrCareerGeneral",user_no);
		model.addAttribute("getMbrCareerGnl", getMbrCareerGnl);
		
		//자격증 사항
		List<TopMbrCareerVO> getMbrLicense = sqlSession.selectList("PopMbrCareerMapper.getMbrLicense",user_no);
		model.addAttribute("getMbrLicense",getMbrLicense);
		
		//교육 및 강의이력
		List<TopMbrEducationVO> getMbrEducation = sqlSession.selectList("PopMbrEducationMapper.getMbrEducation",user_no);
		model.addAttribute("getMbrEducation",getMbrEducation);
		
		List<TopMbrEducationVO> getMbrClass = sqlSession.selectList("PopMbrEducationMapper.getMbrClass",user_no);
		model.addAttribute("getMbrClass",getMbrClass);
		
		TopMbrEducationVO getMbrClassTimeSum = sqlSession.selectOne("PopMbrEducationMapper.getMbrClassTimeSum",user_no);
		model.addAttribute("getMbrClassTimeSum",getMbrClassTimeSum);
				
		//학력 및 가족관계
		List<TopMbrFamilyVO> getMbrFamily = sqlSession.selectList("PopMbrFamilyMapper.getMbrFamily",user_no);
		model.addAttribute("getMbrFamily",getMbrFamily);
		
		List<Map<String, Object>> academiclist = sqlSession.selectList("PopMbrFamilyMapper.memberAcademicList",user_no);
		model.addAttribute("academiclist",academiclist);

		List<Map<String, Object>> fileList = sqlSession.selectList("PopMbrFamilyMapper.memberCareerFileList",user_no);
		model.addAttribute("fileList", fileList);

		return "top_individual/my_info_udt";
	}

	/**내 정보 수정 **/
	@RequestMapping(value = "myInfoEdite", method = RequestMethod.POST)
	public void myinfoEdite(TopMbrViewVO topMemberViewVo, HttpSession session, HttpServletResponse response) {
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

		TopMbrBscVO topMemberVo = new TopMbrBscVO(); 

		if(topMemberViewVo.getHome_address() !=""){
			topMemberVo.setHome_address(topMemberViewVo.getHome_address());
		}
		
		if(topMemberViewVo.getUser_no() != ""){
			topMemberVo.setUser_no(topMemberViewVo.getUser_no());
		}
		
		//자택 전화번호
		if( (topMemberViewVo.getHome_tel_1() != "") &&
			(topMemberViewVo.getHome_tel_2() != "") &&	
			(topMemberViewVo.getHome_tel_3() != "")	
		  ){
			
			String home_tel = 
					topMemberViewVo.getHome_tel_1() +"-"+
					topMemberViewVo.getHome_tel_2() +"-"+
					topMemberViewVo.getHome_tel_3() ;
			
			topMemberVo.setHome_tel(home_tel);
		}
		
		//핸드폰 번호
		if( (topMemberViewVo.getHandphone_1() != "") &&
			(topMemberViewVo.getHandphone_2() != "") &&	
			(topMemberViewVo.getHandphone_3() != "")	
		  ){
			
			String handphone = 
					topMemberViewVo.getHandphone_1() +"-"+
					topMemberViewVo.getHandphone_2() +"-"+
					topMemberViewVo.getHandphone_3() ;
			
			topMemberVo.setHandphone(handphone);
		}
		
		//직통 번호
		if( (topMemberViewVo.getOfficetel_1()!= "") &&
			(topMemberViewVo.getOfficetel_2() != "") &&	
			(topMemberViewVo.getOfficetel_3() != "")	
		  ){
			
			String office_tel = 
					topMemberViewVo.getOfficetel_1() +"-"+
					topMemberViewVo.getOfficetel_2() +"-"+
					topMemberViewVo.getOfficetel_3() ;
			
			topMemberVo.setOffice_tel(office_tel);
		}
		
		//팩스 번호
		if( (topMemberViewVo.getOfficefax_1() != "") &&
			(topMemberViewVo.getOfficefax_2() != "") &&	
			(topMemberViewVo.getOfficefax_3() != "")	
		  ){
			
			String office_fax = 
					topMemberViewVo.getOfficefax_1() +"-"+
					topMemberViewVo.getOfficefax_2() +"-"+
					topMemberViewVo.getOfficefax_3() ;
			
			topMemberVo.setOffice_fax(office_fax);
		}
		
		if(topMemberViewVo.getComment() != ""){
			topMemberVo.setComment(topMemberViewVo.getComment());
		}
		
		//Topmail 비밀번호
		if(topMemberViewVo.getEmail_pwd() != ""){
			//AES256으로 암호화
			String encEmailPwd = SecurityUtil.aesEncrypt(topMemberViewVo.getEmail_pwd(), "");			
			topMemberVo.setEmail_pwd(encEmailPwd);
			
			//Session 내 이메일 패스워드 업데이트 (재로그인 필요없음) by top3009
			mbrVo.setEmail_pwd(encEmailPwd);			
		}
		
		int result = sqlSession.update("MyInfoUdtMapper.myinfoedite", topMemberVo);

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		out.print(result);
		out.close();
	}//public void myinfoEdite

	/**내 비밀번호 수정 **/
	@RequestMapping(value = "myPwEdite", method = RequestMethod.POST)
	public void myPwEdite(String user_no, String user_pwNow, String user_pwNew, PrintWriter out) {
		logger.info("======= myPwEdite - 내 비밀번호 수정 =======");
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("user_no", user_no);
		map.put("user_pwd", EncryptUtil.getEncryptSHA256(user_pwNow));
		map.put("user_pwNew", EncryptUtil.getEncryptSHA256(user_pwNew));
		
		String sUser_pwd_old = "";		//기존 패스워드 값
		String sUser_pwd_1 = "";		//변경전 1회 패스워드 값
		
		int checkMbr = sqlSession.selectOne("MyInfoUdtMapper.checkMbrForPwdEdite", map);		
		
		if(checkMbr > 0){			
			//기존 패스워드가 일치한 경우 과거 변경전 2회 까지 동일한 비밀번호가 있는지 체크한다. by top3009
			
			int oldCheckMbr = sqlSession.selectOne("MyInfoUdtMapper.checkMbrForOldPwd", map);			
			
			if( oldCheckMbr > 0 ){
				out.print(3);		//기존에 사용한 패스워드임.				
			}else {
				//int result = sqlSession.update("MyInfoUdtMapper.myPwEdite", map);
				HashMap<String,Object> pwdMap = sqlSession.selectOne("MyInfoUdtMapper.selOldUserPwd", map);
				sUser_pwd_old = pwdMap.get("user_pwd").toString();
				sUser_pwd_1 = pwdMap.get("user_pwd_1").toString();
				map.put("sUser_pwd_old", sUser_pwd_old);
				map.put("sUser_pwd_1", sUser_pwd_1);
				
				int result = sqlSession.update("MyInfoUdtMapper.myPwEditeNew", map);
				
				sqlSession.insert("MyInfoUdtMapper.insertMbrBscLogForPwd",user_no);
				
				if(result > 0){
					out.print(1); // 변경 성공				
				}else{
					out.print(0); // 변경 실패
				}
			}			
			
		}else{
			out.print(2); // 현재 비밀번호 불일치
		}

		out.close();
	}//public void myPwEdite
}//end of class
