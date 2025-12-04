package kr.co.toplac.topteam;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import kr.co.toplac.cmm.service.CodeDicService;
import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.sysadm.SysAdmCodeDicVO;
import kr.co.toplac.topindividual.TopMbrDocVO;
import kr.co.toplac.topvaction.LeaveCode;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;
import kr.co.toplac.util.cmm.WebUtil;
import kr.co.toplac.util.etc.SplitPhoneNo;
import kr.co.toplac.util.file.GetImageBase64;



@Controller
public class PopMbrDtlController {
	
    private static final Logger logger = LoggerFactory.getLogger(PopMbrDtlController.class);
    private static final String UPLOAD_PATH_MMS = "/home/hosting_users/toplac/www/ls_data/member_mms/";
    //private static final String UPLOAD_PATH_MMS = "/Users/kohyeonseok/devroot/91.devUpload/toplac/hosting_users/toplac/www/ls_data/member_mms/";
    
    private static final String UPLOAD_PATH_CAREER = "/home/hosting_users/toplac/www/ls_data/member_career/";
    //private static final String UPLOAD_PATH_CAREER = "d:/home/hosting_users/toplac/www/ls_data/member_career/";
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private CodeDicService service;
	
	/**
	 * 인사관리(자격현황) : 직원별 목록 불러오기 Ajax
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "insaCertiMemberExcel")
	public String insaCertiMemberExcel(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= insaCertiMemberExcel =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
		List<Map<String,Object>> certiMemberList = sqlSession.selectList("TopMbrDtlMapper.selectInsaCertiMemberListSearch", paramMap);
		
		int manager_cnt = 0;
		int certi_cnt = 0;
		String temp_user_no = "";
		String temp_manager_info_text = "";
		String temp_etc_contnet = "";
		String temp_certi_class = "";
		
		for(int i=0; i < certiMemberList.size(); i++) {
			manager_cnt = Integer.parseInt(certiMemberList.get(i).get("certi_manager_cnt").toString());
			
			temp_manager_info_text = "";		//초기화
			temp_etc_contnet = "";				//초기화
			
			if( manager_cnt > 1 ) {			//담당손해사정사가 두명 이상인경우
				
				temp_user_no = String.valueOf(certiMemberList.get(i).get("user_no"));
				List<Map<String,Object>> certiManagerList = sqlSession.selectList("TopMbrDtlMapper.selectCertiManagerInfoByUserNo", temp_user_no);
				
				for( int k=0; k < certiManagerList.size(); k++ ) {						
					if( k == (certiManagerList.size()-1) ) {
						temp_manager_info_text += String.valueOf(certiManagerList.get(k).get("manager_info_text"));
					}else{						
						temp_manager_info_text += String.valueOf(certiManagerList.get(k).get("manager_info_text")) + "<br style='mso-data-placement:same-cell;'>";
					}
				}				
				certiMemberList.get(i).put("manager_info_text", temp_manager_info_text);								
			}
			
			certi_cnt = Integer.parseInt(certiMemberList.get(i).get("certi_cnt").toString());
			
			if( certi_cnt > 1) {					//자격증이 두개 이상인경우
				
				temp_user_no = String.valueOf(certiMemberList.get(i).get("user_no"));
				List<Map<String,Object>> certiInfoList = sqlSession.selectList("TopMbrDtlMapper.selectCertiInfoTextByUserNo", temp_user_no);
				
				temp_etc_contnet += "총 등록번호 : "+certi_cnt+"개<br style='mso-data-placement:same-cell;'>";
				
				for( int k=0; k < certiInfoList.size(); k++ ) {
					
					temp_certi_class = String.valueOf(certiInfoList.get(k).get("certi_class"));
					
					if( "2".endsWith(temp_certi_class) ) {
						temp_etc_contnet += "손해사정사 등록번호 : ";
					}else{
						temp_etc_contnet += "보조인 등록번호 : ";
					}
					
					if( k == (certiInfoList.size()-1) ) {
						temp_etc_contnet += String.valueOf(certiInfoList.get(k).get("certi_info_text"));
					}else{						
						temp_etc_contnet += String.valueOf(certiInfoList.get(k).get("certi_info_text")) + "<br style='mso-data-placement:same-cell;'>";
					}
				}				
				certiMemberList.get(i).put("etc_content", temp_etc_contnet);
				
			}else{
				certiMemberList.get(i).put("etc_content", "");
			}
			
		}		
		
		model.addAttribute("certiMemberList",certiMemberList);				
		
		return "top_team/top_insa_certi_member_list_excel";
	}
	
	/**
	 * 인사관리(자격현황) : 직원별 목록 불러오기 Ajax
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "insaCertiMemberAjax")
	public String insaCertiMemberAjax(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= insaCertiMemberAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
		List<Map<String,Object>> certiMemberList = sqlSession.selectList("TopMbrDtlMapper.selectInsaCertiMemberListSearch", paramMap);
		
		model.addAttribute("certiMemberList",certiMemberList);
		model.addAttribute("srchParam",paramMap);		
		
		return "top_team/top_insa_certi_member_list";
	}
	
	/**
	 * 인사관리(자격현황)
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "topInsaCertiMain")
	public String topInsaCertiMain(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= topInsaCertiMain =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_14().equals("0") && mbrAuthVo.getMbr_pms_15().equals("0"))){
			logger.info("topInsaStatMain - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		String viewType = request.getParameter("viewType") != null ? request.getParameter("viewType") : "memberTab";			//종구분
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		/*검색에 사용될 팀목록 추출*/
		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
		
		model.addAttribute("teamList", teamList);		
		model.addAttribute("viewType", viewType);
		model.addAttribute("srchParam",paramMap);
		
		return "top_team/top_insa_certi_main";
	}
	
	
	/*사원 세부 내용 팝업 lsh 20160406 오후 퇴근 전 추가 */
	@RequestMapping(value = "popMemberDetail", method = RequestMethod.GET)
	public String popMemberDetail(Model model, String user_no, String presentPage, HttpSession session) {

		TopMbrBscVO memberVo = sqlSession.selectOne("TopMbrDtlMapper.mbrinfo", user_no);
		
		TopMbrSgnVO signVo = sqlSession.selectOne("MyInfoUdtMapper.membersign",user_no);
		
		//요청에 의해 주민등록번호 마스킹 해제. 170202LDS
//		if(memberVo.getJumin_no2().length() >= 1){
//			String ju2 = memberVo.getJumin_no2();
//			memberVo.setJumin_no2(ju2.substring(0,1)+"******");
//		}
		
		GetImageBase64 imageUtil = new GetImageBase64();

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

		if(memberVo.getUser_state().equals("근무중")){
			memberVo.setUser_state("0");
			memberVo.setOut_date("");
		}else if(memberVo.getUser_state().equals("발령대기")){
			memberVo.setUser_state("2");
		}else if(memberVo.getUser_state().equals("퇴사")){
			memberVo.setUser_state("1");
		}else if(memberVo.getUser_state().equals("근무중SA")){
			memberVo.setUser_state("9");
		}
		
		/* 이미지 시작 */
		if( (memberVo.getPicture() != null ) ){
			if(!memberVo.getPicture().equals("")){
				
				String dbpath = "/home/hosting_users/toplac/www/ls_data/member/"+memberVo.getPicture();
				String fileType = dbpath.substring(dbpath.lastIndexOf(".")+1, dbpath.length());

				File fd = new File(dbpath);
				if (fd.exists()){
					model.addAttribute("imageBase64", imageUtil.imageBase64Small(dbpath, fileType));
				}
			}
		}

		//=====================================================
		//  MMS 이미지
		//=====================================================
		if (memberVo.getMmsPicture() != null && !"".equals(memberVo.getMmsPicture())){
			String dbpath = UPLOAD_PATH_MMS + memberVo.getMmsPicture();
			String fileType = dbpath.substring(dbpath.lastIndexOf(".")+1, dbpath.length());
			model.addAttribute("mmsImageBase64", imageUtil.imageBase64Small(dbpath, fileType));
		}else{
			model.addAttribute("mmsImageBase64", "");
		}

		
		/*사인 시작*/
		if(signVo != null){
			
//			String dbpath = "";
//			String fileType = "";
				
			String dbpath = "/home/hosting_users/toplac/www/ls_data/member_sign/"+signVo.getUser_no()+"/"+signVo.getUser_sign();
			String fileType = dbpath.substring(dbpath.lastIndexOf(".")+1, dbpath.length());

//			signVo.setSign_buffer(imageUtil.getOneImgeBase64(dbpath, fileType));
			model.addAttribute("signImg",dbpath);
		}
		
		
		
		/* 팀목록 추출*/
//		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch"); //파트팀 제외
		List<TopTmBscVO> teamList = sqlSession.selectList("EmpCertList.teamListForSearch");	//파트팀 포함
		
		model.addAttribute("teamList", teamList);
		
		/* 직위 목록 추출*/
		List<SysAdmCodeDicVO> workLevelList = sqlSession.selectList("TopMbrDtlMapper.workLevelList");
		model.addAttribute("workLevelList", workLevelList);
        
		/* 직책 목록 추출*/
		List<SysAdmCodeDicVO> workTypeList = sqlSession.selectList("TopMbrDtlMapper.workTypeList");
		model.addAttribute("workTypeList", workTypeList);
		
		/* 직급*/
		SysAdmCodeDicVO codeVO = new SysAdmCodeDicVO();      
		codeVO.setTbl_nm("top_mbr_bsc");
		codeVO.setCol_nm("work_rank");
		List<SysAdmCodeDicVO> workRankList = service.codeList(codeVO);
		model.addAttribute("workRankList", workRankList);
		
		
		/* 직무*/
		codeVO.setTbl_nm("top_mbr_bsc");
		codeVO.setCol_nm("work_job");
		List<SysAdmCodeDicVO> workJobList = service.codeList2(codeVO);
		model.addAttribute("workJobList", workJobList);
		
		
//        SysAdmCodeDic2VO PositionVo1 = new SysAdmCodeDic2VO();
//        SysAdmCodeDic2VO PositionVo4  = new SysAdmCodeDic2VO();
//        
//        PositionVo1.setTbl_nm("top_mbr_bsc");
//        PositionVo1.setCol_nm("position");
//        PositionVo1.setCol_cd1("1");
//        
//        PositionVo4.setTbl_nm("top_mbr_bsc");
//        PositionVo4.setCol_nm("position");
//        PositionVo4.setCol_cd1("4");
//        
//        List<SysAdmCodeDic2VO> position1 = service.codeList3(PositionVo1);
//        List<SysAdmCodeDic2VO> position4 = service.codeList3(PositionVo4);
        
		/* 직무코드 */
//        SysAdmCodeDic2VO codePositionVo1 = new SysAdmCodeDic2VO();
//        SysAdmCodeDic2VO codePositionVo4 = new SysAdmCodeDic2VO();
//        codePositionVo1.setTbl_nm("top_mbr_bsc");
//        codePositionVo1.setCol_nm("position_code");
//        codePositionVo1.setCol_cd1("1");
//        
//        codePositionVo4.setTbl_nm("top_mbr_bsc");
//        codePositionVo4.setCol_nm("position_code");
//        codePositionVo4.setCol_cd1("4");       
//        
//        List<SysAdmCodeDic2VO> positionCode1 = service.codeList3(codePositionVo1);
//        List<SysAdmCodeDic2VO> positionCode4 = service.codeList3(codePositionVo4);
//        model.addAttribute("positionCode1", positionCode1);
//        model.addAttribute("positionCode4", positionCode4);
        
        
		model.addAttribute("memberVo", memberVo);
		model.addAttribute("signVo", signVo);
		
//		model.addAttribute("position1", position1);
//		model.addAttribute("position4", position4);
		
		/* 인사 평가 */	
		TopMbrAuthVO tmpAuthSessionVO = (TopMbrAuthVO)session.getAttribute("mbrAuthVo_Session");
		if(tmpAuthSessionVO.getMbr_pms_15().equals("1")){
			/* 인사 평가 년도 추출 */	
			Calendar today = Calendar.getInstance();
			int yearInt = today.get(Calendar.YEAR);
			model.addAttribute("yearInt", yearInt);
			String tmpYear = Integer.toString(yearInt);

			/* 인사 평가 항목 추출 */	
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("tmpYear", tmpYear);
			map.put("user_no", user_no);
			TopMbrEvalVO insaEvalVO = sqlSession.selectOne("PopMbrEvalMapper.insaEvalVO", map);
			model.addAttribute("insaEvalVO", insaEvalVO);	

			/* 인사 평가 목록 추출 */	
			List<TopMbrEvalVO> selEvalList = new ArrayList<TopMbrEvalVO>();
			selEvalList = sqlSession.selectList("PopMbrEvalListMapper.selEvalList", map);
			model.addAttribute("selEvalList", selEvalList);
		}
		
		//발령사항
		List<TopMbrAppointVO> getMbrAppoint = sqlSession.selectList("PopMbrAppointMapper.getMbrAppoint",user_no); 
		model.addAttribute("getMbrAppoint",getMbrAppoint);
		
		//진급사항
		List<TopMbrAppointVO> getMbrPosition = sqlSession.selectList("PopMbrAppointMapper.getMbrPosition",user_no);
		model.addAttribute("getMbrPosition",getMbrPosition);
		
		
		List<TopMbrCareerVO> getMbrCareer = sqlSession.selectList("PopMbrCareerMapper.getMbrCareer",user_no);
		model.addAttribute("getMbrCareer",getMbrCareer);
		
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
		
		List<TopMbrCareerVO> getMbrLicense = sqlSession.selectList("PopMbrCareerMapper.getMbrLicense",user_no);
		model.addAttribute("getMbrLicense",getMbrLicense);
		
		
		
		List<TopMbrEducationVO> getMbrEducation = sqlSession.selectList("PopMbrEducationMapper.getMbrEducation",user_no);
		model.addAttribute("getMbrEducation",getMbrEducation);
		
		List<TopMbrEducationVO> getMbrClass = sqlSession.selectList("PopMbrEducationMapper.getMbrClass",user_no);
		model.addAttribute("getMbrClass",getMbrClass);
		
		TopMbrEducationVO getMbrClassTimeSum = sqlSession.selectOne("PopMbrEducationMapper.getMbrClassTimeSum",user_no);
		model.addAttribute("getMbrClassTimeSum",getMbrClassTimeSum);
		
		
		
		List<TopMbrFamilyVO> getMbrFamily = sqlSession.selectList("PopMbrFamilyMapper.getMbrFamily",user_no);
		model.addAttribute("getMbrFamily",getMbrFamily);
		
		List<Map<String, Object>> academiclist = sqlSession.selectList("PopMbrFamilyMapper.memberAcademicList",user_no);
		model.addAttribute("academiclist",academiclist);

		List<Map<String, Object>> fileList = sqlSession.selectList("PopMbrFamilyMapper.memberCareerFileList",user_no);
		model.addAttribute("fileList", fileList);		
		
		//탭관리
		model.addAttribute("presentPage",presentPage);

		return "top_team/mbr_mng_dtl_pop";
	}
	
	
	@RequestMapping(value = "popMemberDtlImgDel", method = RequestMethod.POST)
	public void popMemberDtlImgDel(Model model, String user_no, PrintWriter out) {
		logger.info("popMemberDtlImgDel");
		int result = sqlSession.update("TopMbrDtlMapper.delMemIng",user_no);
		
		out.print(result);
		
	}
	
	@RequestMapping(value = "popMemberAppointAddOK", method = RequestMethod.POST)
	public void popMemberAppointAddOK(HttpSession session, HttpServletResponse response
			, TopMbrAppointVO inVO) {

		logger.info("======= popMemberAppointAddOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		int intMemberAppointAdd = 0;
		//로그인 유저의 해당월 경비내역 추가하기
		intMemberAppointAdd = sqlSession.insert("PopMbrAppointMapper.insMemberAppoint", inVO);
		if(intMemberAppointAdd == 0){
			out.print("오류가 발생하였습니다.\nIT지원파트로 문의하세요.");
			out.close();
			return;
		}

		out.print("완료 되었습니다.");
		out.close();
	}//myCostInsNewAddOK
	
	@RequestMapping(value = "popMemberAppointUdtOK", method = RequestMethod.POST)
	public void popMemberAppointUdtOK(HttpSession session, HttpServletResponse response
			, TopMbrAppointVO inVO) {

		logger.info("======= popMemberAppointUdtOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

//		StatisticsNowVO nowVO = sqlSession.selectOne("MyCostInsNewMapper.getMyCostInsNewDate", inVO);

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}


		int intMemberAppointUdt = 0;
		//로그인 유저의 해당월 경비내역 추가하기
		intMemberAppointUdt = sqlSession.insert("PopMbrAppointMapper.udtMemberAppoint", inVO);
		if(intMemberAppointUdt == 0){
			out.print("오류가 발생하였습니다.\nIT지원파트로 문의하세요.");
			out.close();
			return;
		}

		out.print("완료 되었습니다.");
		out.close();
	}//myCostInsNewAddOK
	
	
	
	//삭제 예정
	@RequestMapping(value = "popMemberAppointDelOK", method = RequestMethod.POST)
	public void popMemberAppointDelOK(HttpSession session, HttpServletResponse response
			, TopMbrAppointVO inVO) {

		logger.info("======= popMemberAppointDelOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

//		StatisticsNowVO nowVO = sqlSession.selectOne("MyCostInsNewMapper.getMyCostInsNewDate", inVO);

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}


		int intMemberAppointDel = 0;
		//로그인 유저의 해당월 경비내역 추가하기
		intMemberAppointDel = sqlSession.insert("PopMbrAppointMapper.delMemberAppoint", inVO);
		if(intMemberAppointDel == 0){
			out.print("오류가 발생하였습니다.\nIT지원파트로 문의하세요.");
			out.close();
			return;
		}

		out.print("완료 되었습니다.");
		out.close();
	}//myCostInsNewAddOK
	
	
	@RequestMapping(value = "popMemberPositionAddOK", method = RequestMethod.POST)
	public void popMemberPositionAddOK(HttpSession session, HttpServletResponse response
			, TopMbrAppointVO inVO) {

		logger.info("======= popMemberPositionAddOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

//		StatisticsNowVO nowVO = sqlSession.selectOne("MyCostInsNewMapper.getMyCostInsNewDate", inVO);

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}


		int intMemberPositionAdd = 0;
		//로그인 유저의 해당월 경비내역 추가하기
		intMemberPositionAdd = sqlSession.insert("PopMbrAppointMapper.insMemberPosition", inVO);
		if(intMemberPositionAdd == 0){
			out.print("오류가 발생하였습니다.\nIT지원파트로 문의하세요.");
			out.close();
			return;
		}

		out.print("완료 되었습니다.");
		out.close();
	}//myCostInsNewAddOK
	
	@RequestMapping(value = "popMemberPositionUdtOK", method = RequestMethod.POST)
	public void popMemberPositionUdtOK(HttpSession session, HttpServletResponse response
			, TopMbrAppointVO inVO) {

		logger.info("======= popMemberPositionUdtOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

//		StatisticsNowVO nowVO = sqlSession.selectOne("MyCostInsNewMapper.getMyCostInsNewDate", inVO);

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}


		int intMemberPositionUdt = 0;
		//로그인 유저의 해당월 경비내역 추가하기
		intMemberPositionUdt = sqlSession.insert("PopMbrAppointMapper.udtMemberPosition", inVO);
		if(intMemberPositionUdt == 0){
			out.print("오류가 발생하였습니다.\nIT지원파트로 문의하세요.");
			out.close();
			return;
		}

		out.print("완료 되었습니다.");
		out.close();
	}//myCostInsNewAddOK
	
	@RequestMapping(value = "popMemberPositionDelOK", method = RequestMethod.POST)
	public void popMemberPositionDelOK(HttpSession session, HttpServletResponse response
			, TopMbrAppointVO inVO) {

		logger.info("======= popMemberPositionDelOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

//		StatisticsNowVO nowVO = sqlSession.selectOne("MyCostInsNewMapper.getMyCostInsNewDate", inVO);

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}


		int intMemberPositionDel = 0;

		intMemberPositionDel = sqlSession.insert("PopMbrAppointMapper.delMemberPosition", inVO);
		if(intMemberPositionDel == 0){
			out.print("오류가 발생하였습니다.\nIT지원파트로 문의하세요.");
			out.close();
			return;
		}

		out.print("완료 되었습니다.");
		out.close();
	}//myCostInsNewAddOK
	
	@RequestMapping(value = "popMemberCareerAddOK", method = RequestMethod.POST)
	public void popMemberCareerAddOK(HttpSession session, HttpServletResponse response
			, TopMbrCareerVO inVO) {

		logger.info("======= popMemberCareerAddOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

//		StatisticsNowVO nowVO = sqlSession.selectOne("MyCostInsNewMapper.getMyCostInsNewDate", inVO);

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		if(inVO.getCareer_year().equals(null) || inVO.getCareer_year().equals("")){
			inVO.setCareer_year("0");
		}
		if(inVO.getCareer_month().equals(null) || inVO.getCareer_month().equals("")){
			inVO.setCareer_month("0");
		}


		int intMemberCareerAdd = 0;

		intMemberCareerAdd = sqlSession.insert("PopMbrCareerMapper.insMemberCareer", inVO);
		if(intMemberCareerAdd == 0){
			out.print("오류가 발생하였습니다.\nIT지원파트로 문의하세요.");
			out.close();
			return;
		}

        String userNo = String.valueOf(inVO.getUser_no());
        this.insertMbrLog(userNo, "carrer", "C");

		out.print("완료 되었습니다.");
		out.close();
	}//myCostInsNewAddOK
	
	@RequestMapping(value = "popMemberCareerCstAddOK", method = RequestMethod.POST)
	public void popMemberCareerCstAddOK(HttpSession session, HttpServletResponse response
			, TopMbrCareerVO inVO) {

		logger.info("======= popMemberCareerCstAddOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		if(inVO.getCareer_year().equals(null) || inVO.getCareer_year().equals("")){
			inVO.setCareer_year("0");
		}
		if(inVO.getCareer_month().equals(null) || inVO.getCareer_month().equals("")){
			inVO.setCareer_month("0");
		}


		int intMemberCareerAdd = 0;

		intMemberCareerAdd = sqlSession.insert("PopMbrCareerMapper.insMemberCareerConstruct", inVO);
		if(intMemberCareerAdd == 0){
			out.print("오류가 발생하였습니다.\nIT지원파트로 문의하세요.");
			out.close();
			return;
		}

        String userNo = String.valueOf(inVO.getUser_no());
        this.insertMbrLog(userNo, "carrercst", "C");		

		out.print("완료 되었습니다.");
		out.close();
	}//myCostInsNewAddOK	
	
	@RequestMapping(value = "popMemberCareerGnlAddOK", method = RequestMethod.POST)
	public void popMemberCareerGnlAddOK(HttpSession session, HttpServletResponse response
			, TopMbrCareerVO inVO) {

		logger.info("======= popMemberCareerGnlAddOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		if(inVO.getCareer_year().equals(null) || inVO.getCareer_year().equals("")){
			inVO.setCareer_year("0");
		}
		if(inVO.getCareer_month().equals(null) || inVO.getCareer_month().equals("")){
			inVO.setCareer_month("0");
		}


		int intMemberCareerAdd = 0;

		intMemberCareerAdd = sqlSession.insert("PopMbrCareerMapper.insMemberCareerGeneral", inVO);
		if(intMemberCareerAdd == 0){
			out.print("오류가 발생하였습니다.\nIT지원파트로 문의하세요.");
			out.close();
			return;
		}

        String userNo = String.valueOf(inVO.getUser_no());
        this.insertMbrLog(userNo, "carrergnl", "C");		
        
        
		out.print("완료 되었습니다.");
		out.close();
	}//myCostInsNewAddOK		
	
	@RequestMapping(value = "popMemberCareerUdtOK", method = RequestMethod.POST)
	public void popMemberCareerUdtOK(HttpSession session, HttpServletResponse response
			, TopMbrCareerVO inVO) {

		logger.info("======= popMemberCareerUdtOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

//		StatisticsNowVO nowVO = sqlSession.selectOne("MyCostInsNewMapper.getMyCostInsNewDate", inVO);

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		if(inVO.getCareer_year().equals(null) || inVO.getCareer_year().equals("")){
			inVO.setCareer_year("0");
		}
		if(inVO.getCareer_month().equals(null) || inVO.getCareer_month().equals("")){
			inVO.setCareer_month("0");
		}

		int intMemberCareerUdt = 0;
		//로그인 유저의 해당월 경비내역 추가하기
		intMemberCareerUdt = sqlSession.insert("PopMbrCareerMapper.udtMemberCareer", inVO);
		if(intMemberCareerUdt == 0){
			out.print("오류가 발생하였습니다.\nIT지원파트로 문의하세요.");
			out.close();
			return;
		}
		
        String userNo = String.valueOf(inVO.getUser_no());
        this.insertMbrLog(userNo, "carrer", "U");
        

		out.print("완료 되었습니다.");
		out.close();
	}
	
	@RequestMapping(value = "popMemberCareerCstUdtOK", method = RequestMethod.POST)
	public void popMemberCareerCstUdtOK(HttpSession session, HttpServletResponse response
			, TopMbrCareerVO inVO) {

		logger.info("======= popMemberCareerCstUdtOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		if(inVO.getCareer_year().equals(null) || inVO.getCareer_year().equals("")){
			inVO.setCareer_year("0");
		}
		if(inVO.getCareer_month().equals(null) || inVO.getCareer_month().equals("")){
			inVO.setCareer_month("0");
		}

		int intMemberCareerUdt = 0;
		//로그인 유저의 해당월 경비내역 추가하기
		intMemberCareerUdt = sqlSession.insert("PopMbrCareerMapper.udtMemberConstructCareer", inVO);
		if(intMemberCareerUdt == 0){
			out.print("오류가 발생하였습니다.\nIT지원파트로 문의하세요.");
			out.close();
			return;
		}

        String userNo = String.valueOf(inVO.getUser_no());
        this.insertMbrLog(userNo, "carrercst", "U");		
        
		out.print("완료 되었습니다.");
		out.close();
	}
		
	@RequestMapping(value = "popMemberCareerGnlUdtOK", method = RequestMethod.POST)
	public void popMemberCareerGnlUdtOK(HttpSession session, HttpServletResponse response
			, TopMbrCareerVO inVO) {

		logger.info("======= popMemberCareerGnlUdtOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

//		StatisticsNowVO nowVO = sqlSession.selectOne("MyCostInsNewMapper.getMyCostInsNewDate", inVO);

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		if(inVO.getCareer_year().equals(null) || inVO.getCareer_year().equals("")){
			inVO.setCareer_year("0");
		}
		if(inVO.getCareer_month().equals(null) || inVO.getCareer_month().equals("")){
			inVO.setCareer_month("0");
		}

		int intMemberCareerUdt = 0;
		//로그인 유저의 해당월 경비내역 추가하기
		intMemberCareerUdt = sqlSession.insert("PopMbrCareerMapper.udtMemberGeneralCareer", inVO);
		if(intMemberCareerUdt == 0){
			out.print("오류가 발생하였습니다.\nIT지원파트로 문의하세요.");
			out.close();
			return;
		}
		
        String userNo = String.valueOf(inVO.getUser_no());
        this.insertMbrLog(userNo, "carrergnl", "U");		

		out.print("완료 되었습니다.");
		out.close();
	}
		
	
	@RequestMapping(value = "popMemberCareerDelOK", method = RequestMethod.POST)
	public void popMemberCareerDelOK(HttpSession session, HttpServletResponse response
			, TopMbrCareerVO inVO) {

		logger.info("======= popMemberCareerDelOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}


		int intMemberCareerDel = 0;

		intMemberCareerDel = sqlSession.insert("PopMbrCareerMapper.delMemberCareer", inVO);
		if(intMemberCareerDel == 0){
			out.print("오류가 발생하였습니다.\nIT지원파트로 문의하세요.");
			out.close();
			return;
		}
		
        String userNo = String.valueOf(inVO.getUser_no());
        this.insertMbrLog(userNo, "carrer", "D");		

		out.print("완료 되었습니다.");
		out.close();
	}
	
	@RequestMapping(value = "popMemberCareerCstDelOK", method = RequestMethod.POST)
	public void popMemberCareerCstDelOK(HttpSession session, HttpServletResponse response
			, TopMbrCareerVO inVO) {

		logger.info("======= popMemberCareerCstDelOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}


		int intMemberCareerDel = 0;

		intMemberCareerDel = sqlSession.insert("PopMbrCareerMapper.delMemberConstructCareer", inVO);
		if(intMemberCareerDel == 0){
			out.print("오류가 발생하였습니다.\nIT지원파트로 문의하세요.");
			out.close();
			return;
		}
		
        String userNo = String.valueOf(inVO.getUser_no());
        this.insertMbrLog(userNo, "carrercst", "D");	

		out.print("완료 되었습니다.");
		out.close();
	}	
	
	@RequestMapping(value = "popMemberCareerGnlDelOK", method = RequestMethod.POST)
	public void popMemberCareerGnlDelOK(HttpSession session, HttpServletResponse response
			, TopMbrCareerVO inVO) {

		logger.info("======= popMemberCareerGnlDelOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}


		int intMemberCareerDel = 0;

		intMemberCareerDel = sqlSession.insert("PopMbrCareerMapper.delMemberGeneralCareer", inVO);
		if(intMemberCareerDel == 0){
			out.print("오류가 발생하였습니다.\nIT지원파트로 문의하세요.");
			out.close();
			return;
		}
		
        String userNo = String.valueOf(inVO.getUser_no());
        this.insertMbrLog(userNo, "carrergnl", "D");	

		out.print("완료 되었습니다.");
		out.close();
	}		
	
	@RequestMapping(value = "popMemberLicenseAddOK", method = RequestMethod.POST)
	public void popMemberLicenseAddOK(HttpSession session, HttpServletResponse response
			, TopMbrCareerVO inVO) {

		logger.info("======= popMemberLicenseAddOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

//		StatisticsNowVO nowVO = sqlSession.selectOne("MyCostInsNewMapper.getMyCostInsNewDate", inVO);

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}


		int intMemberLicenseAdd = 0;

		intMemberLicenseAdd = sqlSession.insert("PopMbrCareerMapper.insMemberLicense", inVO);
		if(intMemberLicenseAdd == 0){
			out.print("오류가 발생하였습니다.\nIT지원파트로 문의하세요.");
			out.close();
			return;
		}
		
        String userNo = String.valueOf(inVO.getUser_no());
        this.insertMbrLog(userNo, "license", "C");
        
		out.print("완료 되었습니다.");
		out.close();
	}//myCostInsNewAddOK
	
	@RequestMapping(value = "popMemberLicenseUdtOK", method = RequestMethod.POST)
	public void popMemberLicenseUdtOK(HttpSession session, HttpServletResponse response
			, TopMbrCareerVO inVO) {

		logger.info("======= popMemberLicenseUdtOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

//		StatisticsNowVO nowVO = sqlSession.selectOne("MyCostInsNewMapper.getMyCostInsNewDate", inVO);

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}


		int intMemberLicenseUdt = 0;
		intMemberLicenseUdt = sqlSession.insert("PopMbrCareerMapper.udtMemberLicense", inVO);
		if(intMemberLicenseUdt == 0){
			out.print("오류가 발생하였습니다.\nIT지원파트로 문의하세요.");
			out.close();
			return;
		}
		
        String userNo = String.valueOf(inVO.getUser_no());
        this.insertMbrLog(userNo, "license", "U");

		out.print("완료 되었습니다.");
		out.close();
	}//myCostInsNewAddOK
	
	@RequestMapping(value = "popMemberLicenseDelOK", method = RequestMethod.POST)
	public void popMemberLicenseDelOK(HttpSession session, HttpServletResponse response
			, TopMbrCareerVO inVO) {

		logger.info("======= popMemberLicenseDelOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

//		StatisticsNowVO nowVO = sqlSession.selectOne("MyCostInsNewMapper.getMyCostInsNewDate", inVO);

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}


		int intMemberLicenseDel = 0;

		intMemberLicenseDel = sqlSession.insert("PopMbrCareerMapper.delMemberLicense", inVO);
		if(intMemberLicenseDel == 0){
			out.print("오류가 발생하였습니다.\nIT지원파트로 문의하세요.");
			out.close();
			return;
		}

        String userNo = String.valueOf(inVO.getUser_no());
        this.insertMbrLog(userNo, "license", "D");
		
		out.print("완료 되었습니다.");
		out.close();
	}//myCostInsNewAddOK
	
	//자격증 업로드
	@RequestMapping(value = "/popMemberLicenseUpload", method = RequestMethod.POST)
	public String popMemberLicenseUpload(HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {
        //===============================================
        //	파라미터 체크
        //===============================================
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        //===============================================
        //첨부파일 처리
        //===============================================
//		String fileNo = paramMap.get("file_no").toString();
//		String dateFrm = DateUtil.getTodayString("yyyyMM");
		String user_no = paramMap.get("user_no").toString();
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		
		String svrPath = UPLOAD_PATH_CAREER;
		String dbPath = user_no + "/";
		
		String savwPath = svrPath + dbPath;
		List<Map<String, String>> saveFileList = uploadFileSaves(multipartRequest, savwPath);
		
		for (Map<String, String> fileMap : saveFileList){
			fileMap.put("user_no", user_no);
			fileMap.put("reg_user_no", mbrVo.getUser_no());
			fileMap.put("streFilePath", fileMap.get("streFilePath").toString().replaceAll(svrPath, ""));
			sqlSession.insert("PopMbrFamilyMapper.insertFile",fileMap);
		}
		
		return "redirect:/popMemberDetail?user_no=" + user_no + "&presentPage=career";
	}	
	
	 private List<Map<String, String>> uploadFileSaves(MultipartRequest multipartRequest, String savwPath) throws Exception {

	        int fileKey = 0;

	        File dir = new File(savwPath);

	        if(!dir.exists() || !dir.isDirectory()){
	            System.out.println("exists!!!!!!!!===============");
	            dir.mkdirs();
	        }

	        List<Map<String, String>> resultList = new ArrayList<Map<String, String>>();

	        String filePath = "";
	        Iterator<String> files = multipartRequest.getFileNames();

	        while (files.hasNext()){
	            String upFileKey = files.next();
	            MultipartFile mFile = multipartRequest.getFile(upFileKey);

	            String orignlFileNm = mFile.getOriginalFilename();
	            //======================================
	            // 원 파일명이 없는 경우 처리
	            // (첨부가 되지 않은 input file type)
	            //======================================
	            if ("".equals(orignlFileNm)) {
	                continue;
	            }

	            //String streFileNm = DateUtil.getTimeStamp() + fileKey;
	            String streFileNm = StringUtil.getRandomUUID() + fileKey;

	            if (!"".equals(orignlFileNm)) {
	                filePath = savwPath + File.separator + streFileNm;
	                mFile.transferTo(new File(WebUtil.filePathBlackList(filePath)));
	            }

	            Map<String, String> resultMap = new HashMap<>();
	            resultMap.put("streFilePath", savwPath);
	            resultMap.put("streFileNm", streFileNm);
	            resultMap.put("orignlFileNm", orignlFileNm);

	            resultList.add(resultMap);

//	            System.out.println("orignlfileNm:["+orignlFileNm+"]");
//	            System.out.println("streFileNm:["+streFileNm+"]");
//	            System.out.println("streFilePath:["+savwPath+"]");

	            fileKey++;

	        }
	        return resultList;
	    }

	 @RequestMapping(value = "/popMemberLicenseFileDel")
	    public @ResponseBody
	    Map<String, Object> faqFileDelete(HttpServletRequest request, Model model){
	        //===============================================
	        //	파라미터 체크
	        //===============================================
	        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

	        paramMap.put("Authorize", "T");

	        //===============================================
	        //	권한체크
	        //===============================================
	        //TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();

	        //if (!"9".equals(mbrVo.getUser_state())){
	           //paramMap.put("Authorize", "F");
	           //return paramMap;
	        //}

	        //===============================================
	        // 비즈니스 로직
	        //===============================================
	        //이미 있는지 체크
	        Map<String, String> faqFile = sqlSession.selectOne("PopMbrFamilyMapper.selectFile", paramMap);

	        	if(faqFile != null){
		            sqlSession.delete("PopMbrFamilyMapper.deleteFile", paramMap);
		            //파일 삭제 처리
		            String svrPath = UPLOAD_PATH_CAREER;
		            String dbPath = faqFile.get("streFilePath");
		            String streFileNm = faqFile.get("streFileNm");
		            String filePath = svrPath + dbPath + streFileNm;
		            File file = new File(filePath);
		            file.delete();
	
		            paramMap.put("Result", "success");
		        }else{
		            paramMap.put("Result", "fail");
		        }
	        
	        //===============================================
	        // 뷰단 데이터 세팅
	        //===============================================
	        
	        return paramMap;
	    }
	
	 
	    @RequestMapping("/popMemberLicenseFiledown")
	    public void faqFileDown(HttpServletRequest request, HttpServletResponse response) throws Exception {
	        //===============================================
	        //	파라미터 체크
	        //===============================================
	        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
	        String file_no= StringUtil.null2blank(request.getParameter("file_no"));
	        
	        Map<String, String> resutMap = sqlSession.selectOne("PopMbrFamilyMapper.selectFile", paramMap);

	        if (resutMap != null){

	            String svrPath = UPLOAD_PATH_CAREER;
	            String dbPath = resutMap.get("streFilePath");

	            String streFilePath = svrPath + dbPath;
	            File uFile = new File(streFilePath, resutMap.get("streFileNm"));

	            String mimetype = "application/x-msdownload";

	            response.setContentType(mimetype);
	            response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(resutMap.get("orignlFileNm"), "utf-8") + "\"");

	            BufferedInputStream in = null;
	            BufferedOutputStream out = null;

	            try {
	                in = new BufferedInputStream(new FileInputStream(uFile));
	                out = new BufferedOutputStream(response.getOutputStream());

	                FileCopyUtils.copy(in, out);
	                out.flush();
	            } catch (IOException ex) {
	                ex.printStackTrace();
	            } finally {
	                in.close();
	                out.close();
	            }



	        }else{
	            response.setCharacterEncoding("utf-8");
	            System.out.println("파일없을때 ......");
	            response.setContentType("text/html;charset=utf-8");

	            PrintWriter printwriter = response.getWriter();

	            printwriter.println("<html>");
	            printwriter.println("<br><br><br><h2>파일을 찾을수 없습니다.</h2>");
	            printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
	            printwriter.println("<br><br><br>&copy; webAccess");
	            printwriter.println("</html>");

	            printwriter.flush();
	            printwriter.close();
	        }

	    }
	 
	@RequestMapping(value = "popMemberEducationAddOK", method = RequestMethod.POST)
	public void popMemberEducationAddOK(HttpSession session, HttpServletResponse response
			, TopMbrEducationVO inVO) {

		logger.info("======= popMemberEducationAddOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

//		StatisticsNowVO nowVO = sqlSession.selectOne("MyCostInsNewMapper.getMyCostInsNewDate", inVO);

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}


		int intMemberEducationAdd = 0;

		intMemberEducationAdd = sqlSession.insert("PopMbrEducationMapper.insMemberEducation", inVO);
		if(intMemberEducationAdd == 0){
			out.print("오류가 발생하였습니다.\nIT지원파트로 문의하세요.");
			out.close();
			return;
		}
		
        String userNo = String.valueOf(inVO.getUser_no());
        this.insertMbrLog(userNo, "education", "C");
        
        
		out.print("완료 되었습니다.");
		out.close();
	}//myCostInsNewAddOK
	
	
	@RequestMapping(value = "popMemberEducationUdtOK", method = RequestMethod.POST)
	public void popMemberEducationUdtOK(HttpSession session, HttpServletResponse response
			, TopMbrEducationVO inVO) {

		logger.info("======= popMemberEducationUdtOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

//		StatisticsNowVO nowVO = sqlSession.selectOne("MyCostInsNewMapper.getMyCostInsNewDate", inVO);

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}


		int intMemberEducationUdt = 0;
		intMemberEducationUdt = sqlSession.insert("PopMbrEducationMapper.udtMemberEducation", inVO);
		if(intMemberEducationUdt == 0){
			out.print("오류가 발생하였습니다.\nIT지원파트로 문의하세요.");
			out.close();
			return;
		}
        String userNo = String.valueOf(inVO.getUser_no());
        this.insertMbrLog(userNo, "education", "U");
		
		out.print("완료 되었습니다.");
		out.close();
	}//myCostInsNewAddOK
	
	@RequestMapping(value = "popMemberEducationDelOK", method = RequestMethod.POST)
	public void popMemberEducationDelOK(HttpSession session, HttpServletResponse response
			, TopMbrEducationVO inVO) {

		logger.info("======= popMemberEducationDelOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

//		StatisticsNowVO nowVO = sqlSession.selectOne("MyCostInsNewMapper.getMyCostInsNewDate", inVO);

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}


		int intMemberEducationDel = 0;

		intMemberEducationDel = sqlSession.insert("PopMbrEducationMapper.delMemberEducation", inVO);
		if(intMemberEducationDel == 0){
			out.print("오류가 발생하였습니다.\nIT지원파트로 문의하세요.");
			out.close();
			return;
		}
		
        String userNo = String.valueOf(inVO.getUser_no());
        this.insertMbrLog(userNo, "education", "D");

		out.print("완료 되었습니다.");
		out.close();
	}//myCostInsNewAddOK
	
	@RequestMapping(value = "popMemberClassAddOK", method = RequestMethod.POST)
	public void popMemberClassAddOK(HttpSession session, HttpServletResponse response
			, TopMbrEducationVO inVO) {

		logger.info("======= popMemberClassAddOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

//		StatisticsNowVO nowVO = sqlSession.selectOne("MyCostInsNewMapper.getMyCostInsNewDate", inVO);

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}


		int intMemberClassAdd = 0;

		intMemberClassAdd = sqlSession.insert("PopMbrEducationMapper.insMemberClass", inVO);
		if(intMemberClassAdd == 0){
			out.print("오류가 발생하였습니다.\nIT지원파트로 문의하세요.");
			out.close();
			return;
		}
        String userNo = String.valueOf(inVO.getUser_no());
        this.insertMbrLog(userNo, "class", "C");
		
		
		out.print("완료 되었습니다.");
		out.close();
	}//myCostInsNewAddOK
	
	@RequestMapping(value = "popMemberClassUdtOK", method = RequestMethod.POST)
	public void popMemberClassUdtOK(HttpSession session, HttpServletResponse response
			, TopMbrEducationVO inVO) {

		logger.info("======= myCostInsNewAddOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

//		StatisticsNowVO nowVO = sqlSession.selectOne("MyCostInsNewMapper.getMyCostInsNewDate", inVO);

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}


		int intMemberClassUdt = 0;
		//로그인 유저의 해당월 경비내역 추가하기
		intMemberClassUdt = sqlSession.insert("PopMbrEducationMapper.udtMemberClass", inVO);
		if(intMemberClassUdt == 0){
			out.print("오류가 발생하였습니다.\nIT지원파트로 문의하세요.");
			out.close();
			return;
		}
		
        String userNo = String.valueOf(inVO.getUser_no());
        this.insertMbrLog(userNo, "class", "U");

		out.print("완료 되었습니다.");
		out.close();
	}//myCostInsNewAddOK
	
	@RequestMapping(value = "popMemberClassDelOK", method = RequestMethod.POST)
	public void popMemberClassDelOK(HttpSession session, HttpServletResponse response
			, TopMbrEducationVO inVO) {

		logger.info("======= myCostInsNewAddOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

//		StatisticsNowVO nowVO = sqlSession.selectOne("MyCostInsNewMapper.getMyCostInsNewDate", inVO);

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}


		int intMemberClassDel = 0;

		intMemberClassDel = sqlSession.insert("PopMbrEducationMapper.delMemberClass", inVO);
		if(intMemberClassDel == 0){
			out.print("오류가 발생하였습니다.\nIT지원파트로 문의하세요.");
			out.close();
			return;
		}
		
        String userNo = String.valueOf(inVO.getUser_no());
        this.insertMbrLog(userNo, "class", "D");

		out.print("완료 되었습니다.");
		out.close();
	}//myCostInsNewAddOK
	
	@RequestMapping(value = "popMemberFamilyAddOK", method = RequestMethod.POST)
	public void popMemberFamilyAddOK(HttpSession session, HttpServletResponse response
			, TopMbrFamilyVO inVO) {

		logger.info("======= myCostInsNewAddOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

//		StatisticsNowVO nowVO = sqlSession.selectOne("MyCostInsNewMapper.getMyCostInsNewDate", inVO);

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}


		int intMemberFamilyAdd = 0;

		intMemberFamilyAdd = sqlSession.insert("PopMbrFamilyMapper.insMemberFamily", inVO);
		if(intMemberFamilyAdd == 0){
			out.print("오류가 발생하였습니다.\nIT지원파트로 문의하세요.");
			out.close();
			return;
		}
        String userNo = String.valueOf(inVO.getUser_no());
        this.insertMbrLog(userNo, "family", "C");
		
		
		out.print("완료 되었습니다.");
		out.close();
	}//myCostInsNewAddOK
	
	@RequestMapping(value = "popMemberFamilyUdtOK", method = RequestMethod.POST)
	public void popMemberFamilyUdtOK(HttpSession session, HttpServletResponse response, TopMbrFamilyVO inVO) {

		logger.info("======= myCostInsNewAddOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

//		StatisticsNowVO nowVO = sqlSession.selectOne("MyCostInsNewMapper.getMyCostInsNewDate", inVO);

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}


		int intMemberFamilyUdt = 0;
		
		intMemberFamilyUdt = sqlSession.insert("PopMbrFamilyMapper.udtMemberFamily", inVO);
		if(intMemberFamilyUdt == 0){
			out.print("오류가 발생하였습니다.\nIT지원파트로 문의하세요.");
			out.close();
			return;
		}

        String userNo = String.valueOf(inVO.getUser_no());
        this.insertMbrLog(userNo, "family", "U");
		
		out.print("완료 되었습니다.");
		out.close();
	}//myCostInsNewAddOK
	
	@RequestMapping(value = "popMemberFamilyDelOK", method = RequestMethod.POST)
	public void popMemberFamilyDelOK(HttpSession session, HttpServletResponse response
			, TopMbrFamilyVO inVO) {

		logger.info("======= myCostInsNewAddOK =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

//		StatisticsNowVO nowVO = sqlSession.selectOne("MyCostInsNewMapper.getMyCostInsNewDate", inVO);

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}


		int intMemberFamilyDel = 0;

		intMemberFamilyDel = sqlSession.insert("PopMbrFamilyMapper.delMemberFamily", inVO);
		if(intMemberFamilyDel == 0){
			out.print("오류가 발생하였습니다.\nIT지원파트로 문의하세요.");
			out.close();
			return;
		}
		
        String userNo = String.valueOf(inVO.getUser_no());
        this.insertMbrLog(userNo, "family", "D");

		out.print("완료 되었습니다.");
		out.close();
	}//myCostInsNewAddOK
	
	@RequestMapping(value = "/popMemberAcademicAddOK", method = RequestMethod.POST)
    public @ResponseBody Map<String, Object> popMemberAcademicAddOK(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        paramMap.put("RSLTCODE", "0");
        
        TopMbrBscVO mbrBscVO = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();
        
        paramMap.put("reg_user_no", mbrBscVO.getUser_no());
        
        //===============================================
        //	비즈니스 로직
        //===============================================
		sqlSession.insert("PopMbrFamilyMapper.memberAcademicInsert", paramMap);
		
        String userNo = String.valueOf(paramMap.get("user_no"));
        this.insertMbrLog(userNo, "academic", "C");
		
        return paramMap;
    }
	
	@RequestMapping(value = "/popMemberAcademicModifyOK", method = RequestMethod.POST)
    public @ResponseBody Map<String, Object> popMemberAcademicModifyOK(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================

        paramMap.put("RSLTCODE", "0");
        
        TopMbrBscVO mbrBscVO = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();
        
        paramMap.put("modifyUserNo", mbrBscVO.getUser_no());
        
        
        
        //===============================================
        //	비즈니스 로직
        //===============================================
		sqlSession.update("PopMbrFamilyMapper.memberAcademicUpdate", paramMap);
		
        String userNo = String.valueOf(paramMap.get("user_no"));
        this.insertMbrLog(userNo, "academic", "U");
		
        return paramMap;
    }	

	@RequestMapping(value = "/popMemberAcadmicDel",method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> popMemberAcademicDel(HttpServletRequest request){
		//===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        //===============================================
        // 비즈니스 로직
        //===============================================
//        paramMap.put("RSLTCODE", "0");
        
        sqlSession.delete("PopMbrFamilyMapper.memberAcademicDelete", paramMap);
        
        String userNo = String.valueOf(paramMap.get("user_no"));
        this.insertMbrLog(userNo, "academic", "D");
        
		return paramMap;
	}
	
	/**
	 * 상/벌 추가, 수정, 삭제
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "mbrAwardAction", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> mbrAwardAction(HttpServletRequest request, MultipartFile awardFile){
		
		logger.info("======= mbrAwardAction =======");
		
		//===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);        
        
        String action_flag = request.getParameter("action_flag") != null ? request.getParameter("action_flag") : "";			//C:추가, U:수정, D:삭제
        
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
        String reg_user_no = mbrVo.getUser_no();
        
        paramMap.put("reg_user_no", reg_user_no);
        
        int succCnt = 0;
        
        //운영
		String fullPath = "/home" + File.separator + "hosting_users" + File.separator + "toplac"+ File.separator + "www" + File.separator + "ls_data" + File.separator + "award_file";

		//개발
		//String fullPath = "C:\\home" + File.separator + "hosting_users" + File.separator + "toplac"+ File.separator + "www" + File.separator + "ls_data" + File.separator + "award_file";
        
        if( "C".equals(action_flag) ) {
        	
        	String orgFileName = "";
			String fileExt = "";
			String encFileName = "";
			
			if ( awardFile != null ){		//첨부파일이 있는 경우 처리
				orgFileName = awardFile.getOriginalFilename();							//원본 파일명
				fileExt = FilenameUtils.getExtension(orgFileName);						//파일 확장자
				encFileName = UUID.randomUUID().toString().replaceAll("-", "") +"."+fileExt;	//암호화 파일명						
				
				paramMap.put("award_org_file", orgFileName);
				paramMap.put("award_enc_file", encFileName);
				
				try {
					File file = new File(fullPath,encFileName);
					if(!file.exists()){
						file.mkdirs();
					}
					awardFile.transferTo(file);
					
				} catch (IOException e) {
					e.printStackTrace();
				}				
			}
        	
        	succCnt = sqlSession.insert("PopMbrAppointMapper.insMbrAward",paramMap);
        }else if( "U".equals(action_flag) ){
        	
        	String orgFileName = "";
			String fileExt = "";
			String encFileName = "";
			
			if ( awardFile != null ){		//수정 할 첨부파일이 있는 경우 처리
				orgFileName = awardFile.getOriginalFilename();							//원본 파일명
				fileExt = FilenameUtils.getExtension(orgFileName);						//파일 확장자
				encFileName = UUID.randomUUID().toString().replaceAll("-", "") +"."+fileExt;	//암호화 파일명						
				
				paramMap.put("award_org_file", orgFileName);
				paramMap.put("award_enc_file", encFileName);
				
				try {
					File file = new File(fullPath,encFileName);
					if(!file.exists()){
						file.mkdirs();
					}
					awardFile.transferTo(file);
					
				} catch (IOException e) {
					e.printStackTrace();
				}				
			}        	
        	
        	succCnt = sqlSession.update("PopMbrAppointMapper.udtMbrAward",paramMap);
		}else if( "D".equals(action_flag) ) {
			//삭제 시 첨부파일이 있으면 먼저 삭제한다.
			Map<String,Object> awardFileDel = sqlSession.selectOne("PopMbrAppointMapper.getMbrAwardFile", paramMap);
        	String encFilename = String.valueOf(awardFileDel.get("award_enc_file"));        	
        	String delFilePath = fullPath +File.separator+ encFilename;
        	
        	File dfile = new File(delFilePath);
        	
        	if(dfile.exists() == true){
        		dfile.delete();
			}			
			
        	succCnt = sqlSession.delete("PopMbrAppointMapper.delMbrAward", paramMap);
        }else if( "FD".equals(action_flag) ) {
        	Map<String,Object> awardFileDel = sqlSession.selectOne("PopMbrAppointMapper.getMbrAwardFile", paramMap);
        	String encFilename = String.valueOf(awardFileDel.get("award_enc_file"));        	
        	String delFilePath = fullPath +File.separator+ encFilename;
        	
        	File dfile = new File(delFilePath);
        	
        	if(dfile.exists() == true){
        		dfile.delete();
			}
        	
        	succCnt = sqlSession.update("PopMbrAppointMapper.udtMbrAwardFile",paramMap);
        }
        
        //===============================================
        //	LOG INSERT
        //===============================================
        String userNo = String.valueOf(paramMap.get("user_no"));
        this.insertMbrLog(userNo, "award", action_flag);        
        
        //===============================================
        //	RETURN MAP 생성
        //===============================================
        Map<String,Object> returnMap = new HashMap<>();
        returnMap.put("succCnt", succCnt);        
        
		return returnMap;
	}	
	
	/**
	 * 발령사항, 진급사항, 휴직사항 action
	 * 180219 by. lds 
	 * modify by top3009
	 */
	
	@RequestMapping(value = "MbrAppointAction", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> MbrAppointAction(HttpServletRequest request){
		
		logger.info("======= MbrAppointAction =======");
		
		//===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String action = (String) paramMap.get("action");
        String type = (String) paramMap.get("type");
        
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
        String log_user_no = mbrVo.getUser_no();
        
        int succCnt = 0;
        int nChkLeave = 0;		//최종휴복직상태 값 (1:휴직, 0,2 :재직(복직))        
	    
        //발령사항
        if ("appoint".equals(type)){
	        if ("C".equals(action)){
	        	succCnt = sqlSession.insert("PopMbrAppointMapper.insMbrAppoint",paramMap);
	        	//발령사항 입력 시, 유저 정보 자동으로 변경(부서, 직위, 직급, 직책, 직무) 
	        	if (succCnt == 1){
	        		//부서와 현재 위치가 다를 경우, 현재 위치만 변경함
	        		HashMap<String,Object> mbrMap = sqlSession.selectOne("PopMbrAppointMapper.getMbrTeamId",paramMap);
	        		if ( !String.valueOf(mbrMap.get("teamIdMain")).equals(String.valueOf(mbrMap.get("teamIdLoc"))) ){
	        			paramMap.put("teamDiff", "1");
	        		}
	        		sqlSession.update("PopMbrAppointMapper.udtMbrBscFromAppoint",paramMap);
	        	}
	        }else if ("U".equals(action)){
	        	succCnt = sqlSession.update("PopMbrAppointMapper.udtMbrAppoint",paramMap);
	        }else if ("D".equals(action)){
	        	succCnt = sqlSession.delete("PopMbrAppointMapper.delMbrAppoint",paramMap);
	        }
	        
	    //진급사항
        }else if ("position".equals(type)){
	        if ("C".equals(action)){
	        	succCnt = sqlSession.insert("PopMbrAppointMapper.insMbrPosition",paramMap);
	        	
	        	if ( "면수습".equals(paramMap.get("positionComment")) ) {
	        		paramMap.put("probationFlag", "1");
	        	}
	        	sqlSession.update("PopMbrAppointMapper.udtMbrBscProbationDate",paramMap);
	        }else if ("U".equals(action)){
	        	succCnt = sqlSession.update("PopMbrAppointMapper.udtMbrPosition",paramMap);
	        	
	        	if ( "면수습".equals(paramMap.get("positionComment")) ) {
	        		paramMap.put("probationFlag", "1");
	        	}
	        	sqlSession.update("PopMbrAppointMapper.udtMbrBscProbationDate",paramMap);
	        }else if ("D".equals(action)){
	        	succCnt = sqlSession.delete("PopMbrAppointMapper.delMbrPosition",paramMap);
	        }
        }
        
        //휴직사항 by oniku
        else if( "work".equals(type) ){        	
        	paramMap.put("reg_user_no", log_user_no);
        	
        	if ("C".equals(action)){
        		succCnt = sqlSession.insert("PopMbrAppointMapper.insMbrWork",paramMap);
        	}else if("U".equals(action)) {        		
        		succCnt = sqlSession.update("PopMbrAppointMapper.udtMbrWork",paramMap);
        	}else if("D".equals(action)) {
        		succCnt = sqlSession.delete("PopMbrAppointMapper.delMbrWork",paramMap);
        	}
        	
        }
        
        //육아근로기간단축사항 by oniku
        else if( "care".equals(type) ){        	
        	paramMap.put("reg_user_no", log_user_no);        	
        	
        	if ("C".equals(action)){
        		succCnt = sqlSession.insert("PopMbrAppointMapper.insMbrCare",paramMap);
        	}else if("U".equals(action)) {        		
        		succCnt = sqlSession.update("PopMbrAppointMapper.udtMbrCare",paramMap);
        	}else if("D".equals(action)) {
        		succCnt = sqlSession.delete("PopMbrAppointMapper.delMbrCare",paramMap);
        	}
        	
        }
        
        //===============================================
        //	LOG INSERT
        //===============================================
        String userNo = String.valueOf(paramMap.get("userNo"));
        this.insertMbrLog(userNo, type, action);
        
        
        //===============================================
        //	RETURN MAP 생성
        //===============================================
        Map<String,Object> returnMap = new HashMap<>();
        returnMap.put("succCnt", succCnt);
        
		return returnMap;
	}
		
	
    //===============================================
    //	인사관리 재작성 (180802)
    //===============================================
	@RequestMapping(value = "popMbrDetail")
	public String popMbrDetail(Model model, HttpSession session, HttpServletRequest request) {
		logger.info("======= popMbrDetail =======");
		//===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String userNo = (String) paramMap.get("user_no");	
        String tabGubun = StringUtil.null2blank(request.getParameter("tabGubun"));	
        
        model.addAttribute("userNo", userNo);
        model.addAttribute("tabGubun", tabGubun);
        
        /* 직원의 담당 손해사정사 정보*/
		String userCkeys = sqlSession.selectOne("TopMbrDtlMapper.selectCertiManagerCkeysByUserNo",userNo);
		model.addAttribute("userCkeys",userCkeys);
		
		return "top_team/pop_mbr_detail_main";
	}
	
	
	@RequestMapping(value = "popMbrDetailInfo")
	public String popMbrDetailInfo(Model model, HttpSession session, HttpServletRequest request) {
		logger.info("======= popMbrDetailInfo =======");
		//===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String userNo = (String) paramMap.get("userNo");		
        
		TopMbrBscVO memberVo = sqlSession.selectOne("TopMbrDtlMapper.mbrinfo", userNo);
		
		TopMbrSgnVO signVo = sqlSession.selectOne("MyInfoUdtMapper.membersign",userNo);
		
		//요청에 의해 주민등록번호 마스킹 해제. 170202LDS
//		if(memberVo.getJumin_no2().length() >= 1){
//			String ju2 = memberVo.getJumin_no2();
//			memberVo.setJumin_no2(ju2.substring(0,1)+"******");
//		}
		
		GetImageBase64 imageUtil = new GetImageBase64();

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

		if(memberVo.getUser_state().equals("근무중")){
			memberVo.setUser_state("0");
			memberVo.setOut_date("");
		}else if(memberVo.getUser_state().equals("발령대기")){
			memberVo.setUser_state("2");
		}else if(memberVo.getUser_state().equals("퇴사")){
			memberVo.setUser_state("1");
		}else if(memberVo.getUser_state().equals("근무중SA")){
			memberVo.setUser_state("9");
		}else if(memberVo.getUser_state().equals("휴직중")) {
			memberVo.setUser_state("3");
		}
		
		try {
			/* 이미지 시작 */
			if( (memberVo.getPicture() != null ) ){
				if(!memberVo.getPicture().equals("")){
					
					String dbpath = "/home/hosting_users/toplac/www/ls_data/member/"+memberVo.getPicture();
					String fileType = dbpath.substring(dbpath.lastIndexOf(".")+1, dbpath.length());

					File fd = new File(dbpath);
					if (fd.exists()){
						model.addAttribute("imageBase64", imageUtil.imageBase64Small(dbpath, fileType));
					}
				}
			}

			//=====================================================
			//  MMS 이미지
			//=====================================================
			if (memberVo.getMmsPicture() != null && !"".equals(memberVo.getMmsPicture())){
				String dbpath = UPLOAD_PATH_MMS + memberVo.getMmsPicture();
				String fileType = dbpath.substring(dbpath.lastIndexOf(".")+1, dbpath.length());
				model.addAttribute("mmsImageBase64", imageUtil.imageBase64Small(dbpath, fileType));
			}else{
				model.addAttribute("mmsImageBase64", "");
			}

			/*사인 시작*/
			if(signVo != null){
					
				String dbpath = "/home/hosting_users/toplac/www/ls_data/member_sign/"+signVo.getUser_no()+"/"+signVo.getUser_sign();
				String fileType = dbpath.substring(dbpath.lastIndexOf(".")+1, dbpath.length());

				model.addAttribute("signImg",dbpath);
			}
		} catch (Exception e) {
			System.out.println("Secure Image Or Empty Image Error 001 !! User_no : "+ userNo +" : "+e);
		}		
       
		
		/* 팀목록 추출*/
//		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch"); //파트팀 제외
		List<TopTmBscVO> teamList = sqlSession.selectList("EmpCertList.teamListForSearch");	//파트팀 포함
		
		model.addAttribute("teamList", teamList);
		
		/* 직위 목록 추출*/
		List<SysAdmCodeDicVO> workLevelList = sqlSession.selectList("TopMbrDtlMapper.workLevelList");
		model.addAttribute("workLevelList", workLevelList);
        
		/* 직책 목록 추출*/
		List<SysAdmCodeDicVO> workTypeList = sqlSession.selectList("TopMbrDtlMapper.workTypeList");
		model.addAttribute("workTypeList", workTypeList);
		
		/* 겸직 목록 추출*/
		List<Map<String, Object>> subJobList = sqlSession.selectList("TopMbrDtlMapper.selectSubjobList",paramMap);
		model.addAttribute("subJobList", subJobList);
		
		/* 직급*/
		SysAdmCodeDicVO codeVO = new SysAdmCodeDicVO();      
		codeVO.setTbl_nm("top_mbr_bsc");
		codeVO.setCol_nm("work_rank");
		List<SysAdmCodeDicVO> workRankList = service.codeList(codeVO);
		model.addAttribute("workRankList", workRankList);
		
		/* 직무*/
		codeVO.setTbl_nm("top_mbr_bsc");
		codeVO.setCol_nm("work_job");
		List<SysAdmCodeDicVO> workJobList = service.codeList2(codeVO);
		model.addAttribute("workJobList", workJobList);
		
		/* 손해사정사 종류 */
		List<Map<String, Object>> mainCertiTypeList = sqlSession.selectList("TopMbrDtlMapper.selectMainCertiTypeList");
		model.addAttribute("mainCertiTypeList", mainCertiTypeList);
		
		/* 보조인 종류 */
		List<Map<String, Object>> subCertiTypeList = sqlSession.selectList("TopMbrDtlMapper.selectSubCertiTypeList");
		model.addAttribute("subCertiTypeList", subCertiTypeList);
		
		//certi_state 가 4인 경우 (손해사정사 인 경우 top_mbr_certi 의 ckey를 가져온다.)
		String sUserCkey = sqlSession.selectOne("TopMbrDtlMapper.selectCkeyCertInfoByUserno", userNo);
		model.addAttribute("userCertCkey", sUserCkey);			//손해사정사(top_mbr_certi) 키 정보가 없으면 userCertCkey = ""; 
				
		/* 직원의 손해사정사 정보 */
		List<Map<String, Object>>userCertiInfoList = sqlSession.selectList("TopMbrDtlMapper.selectCertiInfoByUserno", userNo);
		model.addAttribute("userCertiInfoList",userCertiInfoList);
		
		/* 직원의 보조인 정보 */
		List<Map<String, Object>>userCertiSubInfoList = sqlSession.selectList("TopMbrDtlMapper.selectCertiSubInfoByUserno", userNo);
		model.addAttribute("userCertiSubInfoList",userCertiSubInfoList);
		
		/* 담당 손해사정사 목록 */
		List<Map<String, Object>> certiManagerList = sqlSession.selectList("TopMbrDtlMapper.selectCertiManagerList", paramMap);
		model.addAttribute("certiManagerList",certiManagerList);
		
		/* 직원의 담당 손해사정사 정보*/
		//String userCkeys = sqlSession.selectOne("TopMbrDtlMapper.selectCertiManagerCkeysByUserNo",userNo);
		//model.addAttribute("userCkeys",userCkeys);
		
		//직원 현재지역 설정목록 불러오기 시작
		SysAdmCodeDicVO zoneVO = new SysAdmCodeDicVO();      
		zoneVO.setTbl_nm("top_mbr_bsc");
		zoneVO.setCol_nm("person_zone");
		List<SysAdmCodeDicVO> zoneList = service.codeList(zoneVO);
		model.addAttribute("zoneList", zoneList);
		//직원 현재지역 설정목록 불러오기 끝
		
		model.addAttribute("memberVo", memberVo);
		model.addAttribute("signVo", signVo);		
		
		return "top_team/pop_mbr_detail_info";
	}
	
	@Value("#{dataSourceSpied.url}")
	String sDbUrl;
	
	@RequestMapping(value = "popMbrDetailAuthIns")
	public String popMbrDetailAuthIns(Model model, HttpSession session, HttpServletRequest request) {		
		
		logger.info("======= popMbrDetailAuthIns =======");
		//===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String userNo = (String) paramMap.get("userNo");
        
        Map<String,Object> mbrAuth = sqlSession.selectOne("PopMbrAuthIns.selectMbrAuth", userNo);
        
        //DB명가져오기
        String sDbName = "";        
        
        if( !"".equals(sDbUrl) ) {
        	//sDbName = StringUtil.getTailSubstring(sDbUrl, "/");
        	sDbName = StringUtil.getStringBetweenRev2(sDbUrl, "/", "?");        	
        }else{
        	sDbName = "toplac";
        }
        
        paramMap.put("dbName", sDbName);
        
        int pmsLength = sqlSession.selectOne("PopMbrAuthIns.selectPmsLength",paramMap);        
        
        model.addAttribute("mbrAuth",mbrAuth);
        model.addAttribute("pmsLength",pmsLength);
        
        return "top_team/pop_mbr_auth_ins";
	}
	
		
	@RequestMapping(value = "updateMbrAuth")
	public String updateMbrAuth(Model model, HttpSession session, HttpServletRequest request) {
		logger.info("======= updateMbrAuth =======");
		//===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
		//===============================================
        //	세션 체크
        //===============================================
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
        
        String tabGubun = String.valueOf(paramMap.get("tabGubun"));
        String userNo = String.valueOf(paramMap.get("userNo"));
    	String sessUserNo = mbrVo.getUser_no();
        
    	paramMap.put("sessUserNo", sessUserNo);
        sqlSession.update("PopMbrAuthIns.updateMbrAuth",paramMap);
		sqlSession.insert("PopMbrAuthIns.insertMbrAuthLog", paramMap);
		
        return "redirect:/popMbrDetail?user_no="+userNo+"&tabGubun="+tabGubun; 
	}
		
	
	@RequestMapping(value = "popMbrDetailAuthLog")
	public String popMbrDetailAuthLog(Model model, HttpSession session, HttpServletRequest request) {
		logger.info("======= popMbrDetailAuthLog =======");
		//===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String userNo = (String) paramMap.get("userNo");
        
        List<TopMbrAuthVO> mbrAuthLogList = sqlSession.selectList("PopMbrAuthList.selectMbrAuthLogList", userNo);
        model.addAttribute("mbrAuthLogList",mbrAuthLogList);
        
        return "top_team/pop_mbr_auth_log";
	}	
	
	@RequestMapping(value = "popMbrDetailAppointList")
	public String popMbrDetailAppointList(Model model, HttpSession session, HttpServletRequest request) {
		logger.info("======= popMbrDetailAppointList =======");
		//===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String userNo = (String) paramMap.get("userNo");
        
		/* 팀목록 추출*/
//		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch"); //파트팀 제외
		List<TopTmBscVO> teamList = sqlSession.selectList("EmpCertList.teamListForSearch");	//파트팀 포함
		
		model.addAttribute("teamList", teamList);
		
		/* 직위 목록 추출*/
		List<SysAdmCodeDicVO> workLevelList = sqlSession.selectList("TopMbrDtlMapper.workLevelList");
		model.addAttribute("workLevelList", workLevelList);
        
		/* 직책 목록 추출*/
		List<SysAdmCodeDicVO> workTypeList = sqlSession.selectList("TopMbrDtlMapper.workTypeList");
		model.addAttribute("workTypeList", workTypeList);
		
		/* 직급*/
		SysAdmCodeDicVO codeVO = new SysAdmCodeDicVO();      
		codeVO.setTbl_nm("top_mbr_bsc");
		codeVO.setCol_nm("work_rank");
		List<SysAdmCodeDicVO> workRankList = service.codeList(codeVO);
		model.addAttribute("workRankList", workRankList);
		
		/* 직무*/
		codeVO.setTbl_nm("top_mbr_bsc");
		codeVO.setCol_nm("work_job");
		List<SysAdmCodeDicVO> workJobList = service.codeList2(codeVO);
		model.addAttribute("workJobList", workJobList);
		
		/* 휴직유형코드*/
		List<LeaveCode> workCodeList = sqlSession.selectList("topVacationMapper.selectLeaveCodeListManager",paramMap);
		model.addAttribute("workList", workCodeList);		
        
		//발령사항
		List<TopMbrAppointVO> getMbrAppoint = sqlSession.selectList("PopMbrAppointMapper.getMbrAppoint",userNo); 
		model.addAttribute("getMbrAppoint",getMbrAppoint);
		
		//진급사항
		List<TopMbrAppointVO> getMbrPosition = sqlSession.selectList("PopMbrAppointMapper.getMbrPosition",userNo);
		model.addAttribute("getMbrPosition",getMbrPosition);
		
		//상/벌 사항
		List<Map<String,Object>> getAwardList = sqlSession.selectList("PopMbrAppointMapper.getMbrAward",userNo);
		model.addAttribute("getAwardList",getAwardList);
		
		//휴직사항
		List<TopMbrWorkVO> getMbrWork = sqlSession.selectList("PopMbrAppointMapper.getMbrWork",userNo);
		
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
		
		//육아근로기간단축
		List<Map<String, Object>> getMbrCare = sqlSession.selectList("PopMbrAppointMapper.getMbrCare",userNo);
		
		for(int i=0; i < getMbrCare.size(); i++) {
			sDate = String.valueOf(getMbrCare.get(i).get("care_sdate_fmt"));
			old_sDate = sDate.replaceAll("-", "");
			
			eDate = String.valueOf(getMbrCare.get(i).get("care_edate_fmt"));
			old_eDate = eDate.replaceAll("-", "");
			
			diffDayCnt = DateUtil.getDiffDayCountNotWeekend(old_sDate, old_eDate);
			
			paramMap.put("vacationStartDate", old_sDate);
			paramMap.put("vacationEndDate", old_eDate);
			
			eventDayCnt = sqlSession.selectOne("topVacationMapper.selectEventDayCnt",paramMap);			
			nWorkInterval = diffDayCnt - eventDayCnt;
			
			getMbrCare.get(i).put("care_work_interval", nWorkInterval);			
		}		
		
		model.addAttribute("getMbrCare",getMbrCare);
        
        return "top_team/pop_mbr_appoint_list";
		
	}
	
	/**
	 * 신규 상벌 파일 다운로드 by top3009
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "awardFileDown")
    public void awardFileDown(HttpServletRequest request, HttpServletResponse response){
    	
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);		
				
		Map<String,Object> awardFile = sqlSession.selectOne("PopMbrAppointMapper.getMbrAwardFile", paramMap);

		String orgFilename = String.valueOf(awardFile.get("award_org_file"));
		String encFilename = String.valueOf(awardFile.get("award_enc_file"));
    	
		try {
			orgFilename = java.net.URLEncoder.encode(orgFilename,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		response.setHeader("Content-Disposition","attachment;filename="+orgFilename);
    	
    	//운영
		String uploadPath = "/home" + File.separator + "hosting_users" + File.separator + "toplac"
				+ File.separator + "www" + File.separator + "ls_data" + File.separator + "award_file"+File.separator;
		
    	String fullPath = uploadPath + encFilename;
		
		ServletOutputStream sout;
		
		try {
			sout = response.getOutputStream();
			FileInputStream fin = new FileInputStream(fullPath);
			byte[] buf = new byte[1024];
			int size=0;
			while((size=fin.read(buf,0,1024))!=-1){
				sout.write(buf,0,size);
			}
			sout.flush();
			fin.close();
			sout.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
	
	@RequestMapping(value = "popMbrDetailCareerList")
	public String popMbrDetailCareerList(Model model, HttpSession session, HttpServletRequest request) {
		logger.info("======= popMbrDetailCareerList =======");
		//===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String userNo = (String) paramMap.get("userNo");
        
		List<TopMbrCareerVO> getMbrCareer = sqlSession.selectList("PopMbrCareerMapper.getMbrCareer",userNo);
		model.addAttribute("getMbrCareer",getMbrCareer);
		
		TopMbrCareerVO getMbrCareerSum = sqlSession.selectOne("PopMbrCareerMapper.getMbrCareerSum",userNo);
		model.addAttribute("getMbrCareerSum",getMbrCareerSum);
		
		TopMbrCareerVO getMbrCareerConstructSum = sqlSession.selectOne("PopMbrCareerMapper.getMbrCareerConstructSum",userNo);
		model.addAttribute("getMbrCareerConstructSum",getMbrCareerConstructSum);
		
		TopMbrCareerVO getMbrCareerGeneralSum = sqlSession.selectOne("PopMbrCareerMapper.getMbrCareerGeneralSum",userNo);
		model.addAttribute("getMbrCareerGeneralSum",getMbrCareerGeneralSum);		
		
		List<Map<String, Object>> getMbrCareerCst = sqlSession.selectList("PopMbrCareerMapper.getMbrCareerConstruct",userNo);
		model.addAttribute("getMbrCareerCst", getMbrCareerCst);
		
		List<Map<String, Object>> getMbrCareerGnl = sqlSession.selectList("PopMbrCareerMapper.getMbrCareerGeneral",userNo);
		model.addAttribute("getMbrCareerGnl", getMbrCareerGnl);
		
		List<TopMbrCareerVO> getMbrLicense = sqlSession.selectList("PopMbrCareerMapper.getMbrLicense",userNo);
		model.addAttribute("getMbrLicense",getMbrLicense);
		
		List<Map<String, Object>> fileList = sqlSession.selectList("PopMbrFamilyMapper.memberCareerFileList",userNo);
		model.addAttribute("fileList", fileList);
		
        return "top_team/pop_mbr_career_list";
		
	}	
		
	@RequestMapping(value = "popMbrDetailEducationList")
	public String popMbrDetailEducationList(Model model, HttpSession session, HttpServletRequest request) {
		logger.info("======= popMbrDetailEducationList =======");
		//===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String userNo = (String) paramMap.get("userNo");
        
		List<TopMbrEducationVO> getMbrEducation = sqlSession.selectList("PopMbrEducationMapper.getMbrEducation",userNo);
		model.addAttribute("getMbrEducation",getMbrEducation);
		
		List<TopMbrEducationVO> getMbrClass = sqlSession.selectList("PopMbrEducationMapper.getMbrClass",userNo);
		model.addAttribute("getMbrClass",getMbrClass);
		
		TopMbrEducationVO getMbrClassTimeSum = sqlSession.selectOne("PopMbrEducationMapper.getMbrClassTimeSum",userNo);
		model.addAttribute("getMbrClassTimeSum",getMbrClassTimeSum);
		
        return "top_team/pop_mbr_education_list";
		
	}	
	
	@RequestMapping(value = "popMbrDetailFamilyList")
	public String popMbrDetailFamilyList(Model model, HttpSession session, HttpServletRequest request) {
		logger.info("======= popMbrDetailFamilyList =======");
		//===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String userNo = (String) paramMap.get("userNo");
        
		List<TopMbrFamilyVO> getMbrFamily = sqlSession.selectList("PopMbrFamilyMapper.getMbrFamily",userNo);
		model.addAttribute("getMbrFamily",getMbrFamily);
		
		List<Map<String, Object>> academiclist = sqlSession.selectList("PopMbrFamilyMapper.memberAcademicList",userNo);
		model.addAttribute("academiclist",academiclist);
		
        return "top_team/pop_mbr_family_list";
		
	}	
	
	@RequestMapping(value = "popMbrDetailDocList")
	public String popMbrDetailDocList(Model model, HttpSession session, HttpServletRequest request) {
		logger.info("======= popMbrDetailDocList =======");
		//===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String userNo = (String) paramMap.get("userNo");
        
		/* 품의서 관리 */
		List<TopMbrDocVO> mbrDocVO = sqlSession.selectList("PopMbrDocList.getMbrDocList",userNo);
		model.addAttribute("mbrDocList",mbrDocVO);
		
        return "top_team/pop_mbr_doc_list";
		
	}	
		
	
	public void insertMbrLog(String user_no, String gubun, String action){
		logger.info("======= insertMbrLog =======");
        //===============================================
        //	권한체크
        //===============================================
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
        String log_user_no = mbrVo.getUser_no();
        
        Map<String,Object> logMap = new HashMap<String,Object>();
        
        logMap.put("user_no", user_no);
        logMap.put("gubun", gubun);
        logMap.put("action", action);
        logMap.put("log_user_no", log_user_no);
        
        sqlSession.insert("TopMbrDtlMapper.insertMbrMgmtLog",logMap);
		
	}
		
			
	
	

}//end of class
