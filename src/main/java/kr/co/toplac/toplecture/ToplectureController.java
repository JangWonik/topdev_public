package kr.co.toplac.toplecture;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.toplac.brd.common.BoardPageUtil;
import kr.co.toplac.brd.common.BoardSearchVO;
import kr.co.toplac.brd.common.BoardVO;
import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.topstatistics.StatisticsIndexController;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.PaginationInfo;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;

@Controller
public class ToplectureController {
	
	private static final Logger logger = LoggerFactory.getLogger(StatisticsIndexController.class);

	@Autowired
	private SqlSession sqlSession;

	/**
	 * 동영상 교육 관리 프로그램
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/TopLecture")
	public String TopLecture(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= TopLecture =======");
		
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		TopMbrBscVO mbrVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		/** 세션체크 */
		if( mbrVo == null || "".equals(mbrVo.getUser_no() )) {
			logger.info("TopLecture - no user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login"; 
		}
		
		String user_no = mbrVo.getUser_no().toString();
		
		//CommonUtils.printMap(paramMap);
		
		paramMap.put("user_no", user_no);
		paramMap.put("ap_state", 11);				//결재완료된 건에 대한 교육 목록만 물러온다.
		
		//메뉴 카운트
		int nAll_cnt = 0;				//결재 완료된 전체교육과정 수
		int nIng_cnt = 0;				//진행중인 교육과정수
		int nDone_cnt = 0;			//교육완료한 교육과정수
		int nEnd_cnt = 0;			//종료(교육기간이 만료된) 교육과정수
		float allProgressPer = 0;		//개인 전체 진행율
		int processEndFlag = 0; 	//과정완료여부
		
		//교육내역 목록불러오기 제외
		//List<Map<String, Object>> myLectureList = sqlSession.selectList("LectureMapper.selectFrontLectureProgress",paramMap);
		
		nAll_cnt = sqlSession.selectOne("LectureMapper.selectFrontLectureProcessAllCnt",paramMap);
		nEnd_cnt = sqlSession.selectOne("LectureMapper.selectFrontLectureProcessEndCnt",paramMap);		
		
		//수강과정 목록불러오기
		List<Map<String, Object>> myLectureProcessListAll = sqlSession.selectList("LectureMapper.selectFrontLectureProcessListPkeyAll",paramMap);
		
		String sPkey = "";
    	String sProgressPer = "0";
    	
    	for( int i = 0; i < myLectureProcessListAll.size(); i++) {
    		sPkey = myLectureProcessListAll.get(i).get("pkey").toString();
    		paramMap.put("pkey", sPkey);    		
    		sProgressPer = sqlSession.selectOne("LectureMapper.selectLectureProcessToProgressCal", paramMap);
    		//완료여부(quiz 추가로 인해 체크항목 추가) 확인
    		processEndFlag = sqlSession.selectOne("LectureMapper.selectLectureProcessToProgressEnd", paramMap);
    		
    		if( Float.parseFloat(sProgressPer) >= 99 && processEndFlag == 0 ) {
    			nDone_cnt++;
    		}else {
    			nIng_cnt++;
    		}
    		allProgressPer += Float.parseFloat(sProgressPer);
    		
    		//myLectureProcessList.get(i).put("progress_per", sProgressPer);
    	}
    	
    	allProgressPer = allProgressPer / myLectureProcessListAll.size();
    	
    	if( Float.isNaN(allProgressPer) ) {
    		allProgressPer = 0;
    	}else {
    		allProgressPer = Math.round(allProgressPer);
    	}    		
    	
    	//System.out.println("allProgressPer : "+allProgressPer);
    	
    	//수강신청 가능 목록 불러오기
    	List<Map<String,Object>> myLectureApplyList = sqlSession.selectList("LectureMapper.selectFrontLectureApplyUser", paramMap);
    	
    	//나의 회차통계정보 가져오기
    	Map<String,Object> MyDetailInfo = sqlSession.selectOne("LectureMapper.selectLectureMyinfoTotal", paramMap);
    	
    	//나의 공개강의실 정보 가져오기
    	List<Map<String,Object>> myLectureOpenList = sqlSession.selectList("LectureMapper.selectFrontLectureOpenUser", paramMap);    	

    	model.addAttribute("allCnt", nAll_cnt);
    	model.addAttribute("ingCnt", nIng_cnt);
    	model.addAttribute("doneCnt", nDone_cnt);
    	model.addAttribute("endCnt", nEnd_cnt);
    	model.addAttribute("allProgressPer", allProgressPer);
		model.addAttribute("myLectureApplyList", myLectureApplyList);
		model.addAttribute("myLectureOpenList", myLectureOpenList);
		model.addAttribute("MyDetailInfo", MyDetailInfo);
		
		return "top_lecture/lecture_index";
	}
	
	/**
	 * 사용자 수강신청
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/lectureUserApplyList")
	public String lectureUserApplyList(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= lectureUserApplyList =======");		
		
		TopMbrBscVO mbrVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String tabView = request.getParameter("tabView") != null ? request.getParameter("tabView") : "1";
		
		/** 세션체크 */
		if( mbrVo == null || "".equals(mbrVo.getUser_no() )) {
			logger.info("TopLecture - no user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login"; 
		}
		
		model.addAttribute("tabView", tabView);
		
		return "top_lecture/lecture_user_apply_list";
	}
	
	/**
	 * 관리자 교육 결재 목록
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/lectureManagerApprovalList")
	public String lectureManagerApprovalList(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= lectureManagerApprovalList =======");
		
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		TopMbrBscVO mbrVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		/** 세션체크 */
		if( mbrVo == null || "".equals(mbrVo.getUser_no() )) {
			logger.info("TopLecture - no user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login"; 
		}				
		
		return "top_lecture/lecture_manage_approval_list";
	}
	
	/**
	 * 관리자 교육통계 목록
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/lectureManagerStatisticsList")
	public String lectureManagerStatisticsList(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= lectureManagerStatisticsList =======");
		
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		TopMbrBscVO mbrVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		/** 세션체크 */
		if( mbrVo == null || "".equals(mbrVo.getUser_no() )) {
			logger.info("TopLecture - no user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login"; 
		}
		
		//검색에 사용 되는 팀 목록 SELECT
		List<TopTmBscVO> teamList = sqlSession.selectList("topVacationMapper.teamListForSearchVacation",paramMap);
		
		model.addAttribute("teamList", teamList);		//검색한 팀 아이디
		
		return "top_lecture/lecture_manage_statistics_list";
	}
	
	/**
	 * 공개교육 관리
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/lectureOpenManager", method = RequestMethod.POST)
	public String lectureOpenManager(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= lectureOpenManager =======");
		
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		TopMbrBscVO mbrVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		/** 세션체크 */
		if( mbrVo == null || "".equals(mbrVo.getUser_no() )) {
			logger.info("TopLecture - no user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login"; 
		}
		
		//selCategoryList (등록되어있는 카테고리 목록 불러오기)
		List<Map<String, Object>> categoryList = sqlSession.selectList("LectureMapper.selectLectureCategory",paramMap);
    	
    	model.addAttribute("selCategoryList", categoryList);
		
		//return "top_lecture/lecture_manage_list";
    	return "top_lecture/lecture_open_manage_list";
	}
	
	/**
	 * 교육 관리자 목록
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/lectureManagerList", method = RequestMethod.POST)
	public String lectureManagerList(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= lectureManagerList =======");
		
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		TopMbrBscVO mbrVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		/** 세션체크 */
		if( mbrVo == null || "".equals(mbrVo.getUser_no() )) {
			logger.info("TopLecture - no user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login"; 
		}
		
		//selCategoryList (등록되어있는 카테고리 목록 불러오기)
		List<Map<String, Object>> categoryList = sqlSession.selectList("LectureMapper.selectLectureCategory",paramMap);
    	
    	model.addAttribute("selCategoryList", categoryList);
		
		return "top_lecture/lecture_manage_list";
	}
	
	/**
	 * 교육분류관리 데이터 Action
	 * param : action = I, U, D
	 * 
	 */	
	@RequestMapping(value="/lectureCategoryAction")
    @ResponseBody
    public int lectureCategoryAction(HttpServletRequest request, Model model) {
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//action : I(추가), U(업데이트)
		String sAction = paramMap.get("action").toString();
		
		logger.info("======= lectureCategoryAction : "+ sAction +" =======");
				
    	int nCnt = 0;
    	
    	//CommonUtils.printMap(paramMap);
    	
    	if( "I".equals(sAction) ) {
    		nCnt = sqlSession.insert("LectureMapper.insertLectureCategory", paramMap);
    	}else if("U".equals(sAction)) {
    		nCnt = sqlSession.update("LectureMapper.updateLectureCategory", paramMap);
    	}else if("D".equals(sAction) ) {
    		//해당카테고리로 교육과정이 등록된게 있으면 isdel 만 1로 업데이트 한다.
    		//카테로리 교육과정체크 필요
    		
    		//해당카테고리로 교육과정이 등록된게 없으면 delete 처리한다.
    		nCnt = sqlSession.delete("LectureMapper.deleteLectureCategory", paramMap);
    	}
    	
    	return nCnt; 
	}
	
	/**
     * 교육결재대상 목록 가져오기
     * @param request
     * @param model
     * @return
     */    
    @RequestMapping(value="/getLectureApprovalList")
    public String getLectureApprovalList(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getLectureApprovalList =========");

    	String sUrl = "top_lecture/lecture_approval_manage_ajax";    	
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	//===============================================
    	// 페이지 관련 변수 선언
    	//===============================================
    	int sizePerPage = 18;       // 한페이지당 보여줄 글 갯수
    	int sizePerBlock = 10;      // 페이지당 보여줄 블럭 갯수
    	int currentPage = 0;        // 현재 페이지
    	int limitPage = 0;          // sql limit

    	//===============================================
    	// 현재 페이지 세팅
    	//===============================================
    	String pageIdx = StringUtil.null2blank((String)paramMap.get("pageIdx"));        

    	if("".equals(pageIdx)){
    	    currentPage = 0;
    	    limitPage = 0;
    	}else{
    	    currentPage = (Integer.parseInt(pageIdx) - 1);
    	    limitPage = ((Integer.parseInt(pageIdx) - 1) * sizePerPage);
    	}
    	paramMap.put("sizePerPage", sizePerPage);
    	paramMap.put("limitPage", limitPage);
    	
    	//view_type == all 일 경우 별도처리한다.
    	String view_type = request.getParameter("view_type") != null ? request.getParameter("view_type") : "";
    	
    	// 검색결과 가져오기
    	List<Map<String, Object>> approvalList = sqlSession.selectList("LectureMapper.selectLectureApprovalList",paramMap);
    	
    	int approvalListCnt = sqlSession.selectOne("LectureMapper.selectLectureApprovalListCnt",paramMap);
    	
    	model.addAttribute("approvalList", approvalList);
    	model.addAttribute("view_type", view_type);
    	
    	//===============================================
    	// 뷰단 데이터 세팅
    	//===============================================
    	PaginationInfo pageInfo = new PaginationInfo();			
    	pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
    	pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
    	pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
    	pageInfo.setTotalRecordCount(approvalListCnt);   				// 총 글 갯수        

    	model.addAttribute("approvalListCnt", approvalListCnt);
    	model.addAttribute("pageInfo", pageInfo);
    	
    	int topNum = 0;			//목록 최상위 인덱스
    	
    	topNum = approvalListCnt - limitPage;
    	model.addAttribute("topNum", topNum);
    	
    	//CommonUtils.printMap(paramMap);    	
    	
    	return sUrl;
    }
	
	/**
     * 교육분류관리 목록 불러오기
     * @param request
     * @param model
     * @return
     */    
    @RequestMapping(value="/getLectureCategory")
    public String getLectureCategory(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getLectureCategory =========");
    	    	
    	String sUrl = "top_lecture/lecture_category_manage_list_ajax";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	// 검색결과 가져오기
    	List<Map<String, Object>> categoryList = sqlSession.selectList("LectureMapper.selectLectureCategory",paramMap);
    	
    	model.addAttribute("categoryList", categoryList);
    	
    	return sUrl;
    }
    
    /**
	 * 교육과정관리 데이터 Action
	 * param : action = I, U, D
	 * 
	 */	
	@RequestMapping(value="/lectureProcessAction")
    @ResponseBody
    public int lectureProcessAction(HttpServletRequest request, Model model, HttpSession session) {
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		String reg_user_no = mbrVo.getUser_no();			//등록자 사번
		
		paramMap.put("reg_user_no", reg_user_no);
		
		//action : I(추가), U(업데이트)
		String sAction = paramMap.get("action").toString();
		
		logger.info("======= lectureProcessAction : "+ sAction +" =======");
				
    	int nCnt = 0;
    	
    	//CommonUtils.printMap(paramMap);
    	
    	if( "I".equals(sAction) ) {
    		nCnt = sqlSession.insert("LectureMapper.insertLectureProcess", paramMap);
    	}else if( "U".equals(sAction) ) {
    		nCnt = sqlSession.update("LectureMapper.updateLectureProcess", paramMap);
    	}else if("D".equals(sAction) ) {
    		//해당 과정에 관계테이블을 삭제한다.
    		sqlSession.delete("LectureMapper.deleteLectureRelationPkey", paramMap);
    		
    		nCnt = sqlSession.delete("LectureMapper.deleteLectureProcess", paramMap);
    	}
    	
    	return nCnt; 
	}
	
	/**
	 * 공개강의 정보 가져오기
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getLectureOpenInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> getLectureOpenInfo(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= getLectureOpenInfo =======");
		
		Map<String,Object> returnMap = new HashMap<String, Object>();
		
		String okey = request.getParameter("okey") != null ? request.getParameter("okey") : "";		
		
		Map<String, Object> lectureOpenMap = sqlSession.selectOne("LectureMapper.selectLectureOpenOne",okey);
				
		returnMap.put("okey", String.valueOf(lectureOpenMap.get("okey")));
		returnMap.put("team_type", String.valueOf(lectureOpenMap.get("team_type")));
		returnMap.put("ckey", String.valueOf(lectureOpenMap.get("ckey")));
		returnMap.put("subject", String.valueOf(lectureOpenMap.get("subject")));
		returnMap.put("introduce", String.valueOf(lectureOpenMap.get("introduce")));
		returnMap.put("manager_name", String.valueOf(lectureOpenMap.get("manager_name")));
		returnMap.put("link_path", String.valueOf(lectureOpenMap.get("link_path")));
		returnMap.put("file_org_name", String.valueOf(lectureOpenMap.get("file_org_name")));
		
		return returnMap;
	}
    
	@RequestMapping(value="/lectureOpenAction")
    @ResponseBody
    public int lectureOpenAction(HttpServletRequest request, Model model, HttpSession session, MultipartFile attach_file) {
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		String reg_user_no = mbrVo.getUser_no();			//등록자 사번
		
		paramMap.put("reg_user_no", reg_user_no);
		
		//action : I(추가), U(업데이트)
		String sAction = paramMap.get("action").toString();
		
		logger.info("======= lectureOpenAction : "+ sAction +" =======");
		
		//파일 추가 시작
		String orgFileName = "";
		String fileExt = "";
		String encFileName = "";

		if ( attach_file != null ){		//첨부파일이 있는 경우 처리
			orgFileName = attach_file.getOriginalFilename();							//원본 파일명
			fileExt = FilenameUtils.getExtension(orgFileName);						//파일 확장자
			encFileName = UUID.randomUUID().toString().replaceAll("-", "") +"."+fileExt;	//암호화 파일명
			
			//운영
			String fullPath = "/home" + File.separator + "hosting_users" + File.separator + "toplac"
					+ File.separator + "www" + File.separator + "ls_data" + File.separator + "lecture";

			//개발 경로
			//String fullPath = "D:\\home" + File.separator + "hosting_users" + File.separator + "toplac"
					//+ File.separator + "www" + File.separator + "ls_data" + File.separator + "lecture";						
			
			paramMap.put("file_path", fullPath);			
			paramMap.put("file_org_name", orgFileName);
			paramMap.put("file_enc_name", encFileName);
			
			try {
				File file = new File(fullPath,encFileName);
				if(!file.exists()){
					file.mkdirs();
				}
				attach_file.transferTo(file);
				
			} catch (IOException e) {
				e.printStackTrace();
			}				
		}		
		//파일 추가 끝
				
    	int nCnt = 0;
    	
    	//CommonUtils.printMap(paramMap);
    	
    	if( "I".equals(sAction) ) {
    		nCnt = sqlSession.insert("LectureMapper.insertLectureOpenInfo", paramMap);
    	}else if( "U".equals(sAction) ) {
    		nCnt = sqlSession.update("LectureMapper.updateLectureOpenInfo", paramMap);
    	}else if("D".equals(sAction) ) {
    		
    		//파일부터 삭제 한다.
    		Map<Object, String> DelFileMap = sqlSession.selectOne("LectureMapper.selectLectureOpenOne",paramMap);    		
    		String sFile_path = String.valueOf(DelFileMap.get("file_path"));
    		String sFile_name = String.valueOf(DelFileMap.get("file_enc_name"));
    		String sFullPath = sFile_path + File.separator + sFile_name; 
    		
    		if( !"null".equals(sFile_name) && !"".equals(sFile_name) ) {
    			File f = new File(sFullPath);
    			f.delete();
    		}
    		
    		//공개교육정보를 DB에서 삭제한다.
    		nCnt = sqlSession.delete("LectureMapper.deleteLectureOpenInfo", paramMap);
    	}else if( "DF".equals(sAction) ) {			//파일만 삭제하는 경우
    		//파일부터 삭제 한다.
    		Map<Object, String> DelFileMap = sqlSession.selectOne("LectureMapper.selectLectureOpenOne",paramMap);    		
    		String sFile_path = DelFileMap.get("file_path").toString();
    		String sFile_name = DelFileMap.get("file_enc_name").toString();
    		String sFullPath = sFile_path + File.separator + sFile_name; 
    		
    		if( !"".equals(sFile_name) ) {
    			File f = new File(sFullPath);
    			f.delete();
    		}
    		
    		//DB정보를 삭제한다.
    		nCnt = sqlSession.update("LectureMapper.updateLectureOpenFile", paramMap);
    		
    	}
    	
    	return nCnt;
    	
	}
	
	
    /**
	 * 교육정보관리 데이터 Action
	 * param : action = I, U, D
	 * 
	 */	
	@RequestMapping(value="/lectureInfoAction")
    @ResponseBody
    public int lectureInfoAction(HttpServletRequest request, Model model, HttpSession session, MultipartFile attath_file) {
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		String reg_user_no = mbrVo.getUser_no();			//등록자 사번
		
		paramMap.put("reg_user_no", reg_user_no);
		
		//action : I(추가), U(업데이트)
		String sAction = paramMap.get("action").toString();
		
		logger.info("======= lectureInfoAction : "+ sAction +" =======");
		
		//파일 추가 시작
		String orgFileName = "";
		String fileExt = "";
		String encFileName = "";

		if ( attath_file != null ){		//첨부파일이 있는 경우 처리
			orgFileName = attath_file.getOriginalFilename();							//원본 파일명
			fileExt = FilenameUtils.getExtension(orgFileName);						//파일 확장자
			encFileName = UUID.randomUUID().toString().replaceAll("-", "") +"."+fileExt;	//암호화 파일명
			
			//운영
			String fullPath = "/home" + File.separator + "hosting_users" + File.separator + "toplac"
					+ File.separator + "www" + File.separator + "ls_data" + File.separator + "lecture";

			//개발 경로
			//String fullPath = "D:\\home" + File.separator + "hosting_users" + File.separator + "toplac"
					//+ File.separator + "www" + File.separator + "ls_data" + File.separator + "lecture";						
			
			paramMap.put("file_path", fullPath);			
			paramMap.put("file_org_name", orgFileName);
			paramMap.put("file_enc_name", encFileName);
			
			try {
				File file = new File(fullPath,encFileName);
				if(!file.exists()){
					file.mkdirs();
				}
				attath_file.transferTo(file);
				
			} catch (IOException e) {
				e.printStackTrace();
			}				
		}		
		//파일 추가 끝
				
    	int nCnt = 0;
    	
    	//CommonUtils.printMap(paramMap);
    	
    	if( "I".equals(sAction) ) {
    		nCnt = sqlSession.insert("LectureMapper.insertLectureInfo", paramMap);
    	}else if( "U".equals(sAction) ) {
    		nCnt = sqlSession.update("LectureMapper.updateLectureInfo", paramMap);
    	}else if("D".equals(sAction) ) {
    		//해당 교육가 속한 과정내 관계정보도 삭제한다.
    		sqlSession.delete("LectureMapper.deleteLectureRelationEkey", paramMap);
    		
    		//파일부터 삭제 한다.
    		Map<Object, String> DelFileMap = sqlSession.selectOne("LectureMapper.selectLectureInfoOne",paramMap);    		
    		String sFile_path = DelFileMap.get("file_path").toString();
    		String sFile_name = DelFileMap.get("file_enc_name").toString();
    		String sFullPath = sFile_path + File.separator + sFile_name; 
    		
    		if( !"".equals(sFile_name) ) {
    			File f = new File(sFullPath);
    			f.delete();
    		}
    		
    		//해당교육로 교육과정이 등록된게 없으면 delete 처리한다.
    		nCnt = sqlSession.delete("LectureMapper.deleteLectureInfo", paramMap);
    	}else if( "DF".equals(sAction) ) {			//파일만 삭제하는 경우
    		//파일부터 삭제 한다.
    		Map<Object, String> DelFileMap = sqlSession.selectOne("LectureMapper.selectLectureInfoOne",paramMap);    		
    		String sFile_path = DelFileMap.get("file_path").toString();
    		String sFile_name = DelFileMap.get("file_enc_name").toString();
    		String sFullPath = sFile_path + File.separator + sFile_name; 
    		
    		if( !"".equals(sFile_name) ) {
    			File f = new File(sFullPath);
    			f.delete();
    		}
    		
    		//DB정보를 삭제한다.
    		nCnt = sqlSession.update("LectureMapper.updateLectureInfoFile", paramMap);
    		
    	}
    	
    	return nCnt; 
	}
	
	@RequestMapping(value="/getLectureOpenListAjax")
    public String getLectureOpenListAjax(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getLectureOpenListAjax =========");
    	    	
    	String sUrl = "top_lecture/lecture_open_manage_list_ajax";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	List<Map<String, Object>> openList = sqlSession.selectList("LectureMapper.selectLectureOpenInfo",paramMap);
    	model.addAttribute("openList", openList);    	
    	
    	return sUrl;
    }
    
    /**
     * 교육정보관리 목록 불러오기
     * @param request
     * @param model
     * @return
     */    
    @RequestMapping(value="/getLectureInfo")
    public String getLectureInfo(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getLectureInfo =========");
    	    	
    	String sUrl = "top_lecture/lecture_info_manage_list_ajax";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	// 검색결과 가져오기
    	List<Map<String, Object>> infoList = sqlSession.selectList("LectureMapper.selectLectureInfo",paramMap);
    	model.addAttribute("infoList", infoList);
    	
    	return sUrl;
    }
    
    /**
     * 과정별 교육 통계 엑셀다운로드
     */
    @RequestMapping(value="/getLectureStatisticsProcessExcel")
    public String getLectureStatisticsProcessExcel(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getLectureStatisticsProcessExcel =========");
    	
    	String sUrl = "top_lecture/lecture_statistics_process_excel";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String exelLectureType = request.getParameter("exelLectureType") != null ? request.getParameter("exelLectureType") : "9";
    	String exelPgubun = request.getParameter("exelPgubun") != null ? request.getParameter("exelPgubun") : "";
    	String exelPtitle = request.getParameter("exelPtitle") != null ? request.getParameter("exelPtitle") : "";
    	String exel_pro_show_date = request.getParameter("exel_pro_show_date") != null ? request.getParameter("exel_pro_show_date") : "";
    	
    	paramMap.put("srchLectureType", exelLectureType);
    	paramMap.put("srchPgubun", exelPgubun);
    	paramMap.put("srchPtitle", exelPtitle);
    	paramMap.put("srch_pro_show_date", exel_pro_show_date);
    	    	
    	//CommonUtils.printMap(paramMap);
    	
    	//과정불러오기
    	List<Map<String, Object>> processList = sqlSession.selectList("LectureMapper.selectLectureProcessSearch", paramMap);
    	    	
    	//계산을 위한 임시 변수
    	String tempPkey = "";
    	List<Map<String, Object>> tempList;    
    	
    	//결재완료된 신청과 과정목록
    	for(int i=0; i<processList.size(); i++) {
    		tempPkey = processList.get(i).get("pkey").toString();
    		paramMap.put("pkey", tempPkey);
    		
    		//결재완료된 직원목록을 가져온다.    		
    		tempList = sqlSession.selectList("LectureMapper.selectLectureApprovalEndProcessList", paramMap);
    		
    		int nIng = 0;		//진행중인 과정수
        	int nEnd = 0;		//완료된 과정수    	
        	String sProcessPer = "0";		//과정 진도율
        	float fProcessPer = 0;			//과정 진도율(정수형)
        	float fTotalProcessPer = 0;		//완료율
        	
        	int processEndFlag = 0; 	//과정완료여부
        	
        	if( tempList.size() > 0 ) {
        		
        		for( int k=0; k < tempList.size(); k++ ) {
        			paramMap.put("user_no", tempList.get(k).get("user_no").toString());
        			sProcessPer = sqlSession.selectOne("LectureMapper.selectLectureProcessToProgressCal", paramMap);
        			
        			//완료여부(quiz 추가로 인해 체크항목 추가) 확인
        			processEndFlag = sqlSession.selectOne("LectureMapper.selectLectureProcessToProgressEnd", paramMap);
        			
        			fProcessPer = Float.parseFloat(sProcessPer);
        			if( fProcessPer > 99 && processEndFlag == 0 ) {		//진행완료
        				nEnd++;
        			}else {							//진행중
        				nIng++;
        			}
        		}        		
        		
        	}else{
        		processList.get(i).put("ing_cnt", 0);
        		processList.get(i).put("end_cnt", 0);
        	}       	
        	processList.get(i).put("ing_cnt", nIng);
        	processList.get(i).put("end_cnt", nEnd);
        	
        	//완료율 계산
    		if( nEnd > 0 ) {
    			fTotalProcessPer = nEnd * 100 / tempList.size();
    			processList.get(i).put("end_per", fTotalProcessPer);
    		}else{
    			processList.get(i).put("end_per", 0);
    		}
    	}    	
    	    	
    	model.addAttribute("srchParam",paramMap);
    	model.addAttribute("processList", processList);
    	return sUrl;
    }
    
    /**
     * 과정별 교육 통계 불러오기
     */
    @RequestMapping(value="/getLectureStatisticsProcess")
    public String getLectureStatisticsProcess(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getLectureStatisticsProcess =========");
    	
    	String sUrl = "top_lecture/lecture_statistics_process_ajax";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	//CommonUtils.printMap(paramMap);
    	
    	//과정불러오기
    	List<Map<String, Object>> processList = sqlSession.selectList("LectureMapper.selectLectureProcessSearch", paramMap);
    	    	
    	//계산을 위한 임시 변수
    	String tempPkey = "";
    	List<Map<String, Object>> tempList;    
    	
    	//결재완료된 신청과 과정목록
    	for(int i=0; i<processList.size(); i++) {
    		tempPkey = processList.get(i).get("pkey").toString();
    		paramMap.put("pkey", tempPkey);
    		
    		//결재완료된 직원목록을 가져온다.    		
    		tempList = sqlSession.selectList("LectureMapper.selectLectureApprovalEndProcessList", paramMap);
    		
    		int nIng = 0;		//진행중인 과정수
        	int nEnd = 0;		//완료된 과정수    	
        	String sProcessPer = "0";		//과정 진도율
        	float fProcessPer = 0;			//과정 진도율(정수형)
        	float fTotalProcessPer = 0;		//완료율
        	int processEndFlag = 0;
        	
        	if( tempList.size() > 0 ) {
        		
        		for( int k=0; k < tempList.size(); k++ ) {
        			paramMap.put("user_no", tempList.get(k).get("user_no").toString());
        			sProcessPer = sqlSession.selectOne("LectureMapper.selectLectureProcessToProgressCal", paramMap);
        			fProcessPer = Float.parseFloat(sProcessPer);
        			
        			//완료여부(quiz 추가로 인해 체크항목 추가) 확인
        			processEndFlag = sqlSession.selectOne("LectureMapper.selectLectureProcessToProgressEnd", paramMap);
        			
        			if( fProcessPer > 99 && processEndFlag == 0 ) {		//진행완료
        				nEnd++;
        			}else {							//진행중
        				nIng++;
        			}
        		}        		
        		
        	}else{
        		processList.get(i).put("ing_cnt", 0);
        		processList.get(i).put("end_cnt", 0);
        	}       	
        	processList.get(i).put("ing_cnt", nIng);
        	processList.get(i).put("end_cnt", nEnd);
        	
        	//완료율 계산
    		if( nEnd > 0 ) {
    			fTotalProcessPer = nEnd * 100 / tempList.size();
    			processList.get(i).put("end_per", fTotalProcessPer);
    		}else{
    			processList.get(i).put("end_per", 0);
    		}
    	}    	
    	    	
    	model.addAttribute("srchParam",paramMap);
    	model.addAttribute("processList", processList);
    	return sUrl;
    }
    
    /**
     * 개인별 교육 통계 엑셀파일 다운로드
     */
    @RequestMapping(value="/getLectureStatisticsPersonExcel")
    public String getLectureStatisticsPersonExcel(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getLectureStatisticsPersonExcel =========");
    	
    	String sUrl = "top_lecture/lecture_statistics_person_excel";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	String exelShowDate = request.getParameter("exelShowDate") != null ? request.getParameter("exelShowDate") : "";
    	String exelUserName = request.getParameter("exelUserName") != null ? request.getParameter("exelUserName") : "";
    	String exelTeamId = request.getParameter("exelTeamId") != null ? request.getParameter("exelTeamId") : "0";
    	String exelGubun = request.getParameter("exelGubun") != null ? request.getParameter("exelGubun") : "5";
    	
    	paramMap.put("srchShowDate", exelShowDate);
    	paramMap.put("srchUserName", exelUserName);
    	paramMap.put("srchTeamId", exelTeamId);
    	paramMap.put("srchGubun", exelGubun);
    	
    	//CommonUtils.printMap(paramMap);
    	
    	int processEndFlag = 0;
    	
    	//근무자 불러오기
    	List<Map<String, Object>> personList = sqlSession.selectList("LectureMapper.selectLecturePersonList",paramMap);    	
    	
    	//진행중, 진행완료구하기    	
    	for(int i=0; i < personList.size(); i++) {
    		
    		int nIng = 0;		//진행중인 과정수
        	int nEnd = 0;		//완료된 과정수    	
        	String sProcessPer = "0";		//과정 진도율
        	float fProcessPer = 0;			//과정 진도율(정수형)
        	float fTotalProcessPer = 0;		//완료율
    	
    		paramMap.put("user_no", personList.get(i).get("user_no").toString());    		
    		List<Map<String, Object>> pkeyList = sqlSession.selectList("LectureMapper.selectLectureApprovalEndPersonList", paramMap);
    		
    		if( pkeyList.size() > 0 ) {			//결재완료된 교육수가 있는 경우만 계산한다.
        		for( int k=0; k < pkeyList.size(); k++ ) {
        			paramMap.put("pkey", pkeyList.get(k).get("pkey").toString());
        			sProcessPer = sqlSession.selectOne("LectureMapper.selectLectureProcessToProgressCal", paramMap);        			
        			//완료여부(quiz 추가로 인해 체크항목 추가) 확인
        			processEndFlag = sqlSession.selectOne("LectureMapper.selectLectureProcessToProgressEnd", paramMap);
        			
        			fProcessPer = Float.parseFloat(sProcessPer);
        			if( fProcessPer > 99 && processEndFlag == 0 ) {		//진행완료
        				nEnd++;
        			}else {							//진행중
        				nIng++;
        			}
        		}
        		personList.get(i).put("ing_cnt", nIng);
        		personList.get(i).put("end_cnt", nEnd);
        	}else{
        		personList.get(i).put("ing_cnt", 0);
        		personList.get(i).put("end_cnt", 0);
        	}
    		
    		//완료율 계산
    		if( nEnd > 0 ) {
    			fTotalProcessPer = nEnd * 100 / pkeyList.size();
    			personList.get(i).put("end_per", fTotalProcessPer);
    		}else{
    			personList.get(i).put("end_per", 0);
    		}
    		
    	}
    	
    	model.addAttribute("srchParam",paramMap);
    	model.addAttribute("personList", personList);    	
    	
    	return sUrl;
    }
    
    /**
     * 개인별 교육 통계 불러오기
     */
    @RequestMapping(value="/getLectureStatisticsPerson")
    public String getLectureStatisticsPerson(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getLectureStatisticsPerson =========");
    	
    	String sUrl = "top_lecture/lecture_statistics_person_ajax";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	//CommonUtils.printMap(paramMap);
    	
    	//근무자 불러오기
    	List<Map<String, Object>> personList = sqlSession.selectList("LectureMapper.selectLecturePersonList",paramMap);    	
    	
    	//진행중, 진행완료구하기    	
    	for(int i=0; i < personList.size(); i++) {
    		
    		int nIng = 0;		//진행중인 과정수
        	int nEnd = 0;		//완료된 과정수    	
        	String sProcessPer = "0";		//과정 진도율
        	float fProcessPer = 0;			//과정 진도율(정수형)
        	float fTotalProcessPer = 0;		//완료율
        	
        	int processEndFlag = 0;		//과정완료 여부
    	
    		paramMap.put("user_no", personList.get(i).get("user_no").toString());    		
    		List<Map<String, Object>> pkeyList = sqlSession.selectList("LectureMapper.selectLectureApprovalEndPersonList", paramMap);
    		
    		if( pkeyList.size() > 0 ) {			//결재완료된 교육수가 있는 경우만 계산한다.
        		for( int k=0; k < pkeyList.size(); k++ ) {
        			paramMap.put("pkey", pkeyList.get(k).get("pkey").toString());
        			sProcessPer = sqlSession.selectOne("LectureMapper.selectLectureProcessToProgressCal", paramMap);
        			fProcessPer = Float.parseFloat(sProcessPer);
        			
        			//완료여부(quiz 추가로 인해 체크항목 추가) 확인
        			processEndFlag = sqlSession.selectOne("LectureMapper.selectLectureProcessToProgressEnd", paramMap);
        			
        			if( fProcessPer > 99 && processEndFlag == 0 ) {		//진행완료
        				nEnd++;
        			}else {							//진행중
        				nIng++;
        			}
        		}
        		personList.get(i).put("ing_cnt", nIng);
        		personList.get(i).put("end_cnt", nEnd);
        	}else{
        		personList.get(i).put("ing_cnt", 0);
        		personList.get(i).put("end_cnt", 0);
        	}
    		
    		//완료율 계산
    		if( nEnd > 0 ) {
    			fTotalProcessPer = nEnd * 100 / pkeyList.size();
    			personList.get(i).put("end_per", fTotalProcessPer);
    		}else{
    			personList.get(i).put("end_per", 0);
    		}
    		
    	}
    	
    	model.addAttribute("srchParam",paramMap);
    	model.addAttribute("personList", personList);    	
    	
    	return sUrl;
    }
    
    /**
     * 교육신청가능 목록 불러오기
     * @param request
     * @param model
     * @return
     */    
    @RequestMapping(value="/getLectureRoomUser")
    public String getLectureRoomUser(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getLectureRoomUser =========");
    	
    	TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		
		String user_no = mbrVo.getUser_no();			//교육생 사번

    	String sUrl = "top_lecture/lecture_user_list_ajax";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	paramMap.put("user_no", user_no);
    	
    	// 결재완료된 교육과정 목록 가져오기
    	paramMap.put("ap_state", 11);			//결재상태가 결재완료
    	
    	//CommonUtils.printMap(paramMap);
    	
    	List<Map<String, Object>> showUserList = sqlSession.selectList("LectureMapper.selectLectureRoomUser",paramMap);
    	
    	String sPkey = "";
    	String sProgressPer = "0";
    	String sTotalTime = "";
    	
    	for( int i = 0; i < showUserList.size(); i++) {
    		sPkey = showUserList.get(i).get("pkey").toString();
    		paramMap.put("pkey", sPkey);    		
    		sProgressPer = sqlSession.selectOne("LectureMapper.selectLectureProcessToProgressCal", paramMap);
    		showUserList.get(i).put("progress_per", sProgressPer);
    		sTotalTime = sqlSession.selectOne("LectureMapper.selectLectureProcessTotalTime", paramMap);
    		showUserList.get(i).put("total_time_fmt", sTotalTime);
    	}
    	
    	model.addAttribute("showUserList", showUserList);    	
    	
    	return sUrl;
    }
    
    /**
     * 교육신청가능 목록 불러오기
     * @param request
     * @param model
     * @return
     */    
    @RequestMapping(value="/getLectureProcessUser")
    public String getLectureProcessUser(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getLectureProcessUser =========");
    	
    	TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		
		String user_no = mbrVo.getUser_no();			//등록자 사번
    	    	
    	String sUrl = "top_lecture/lecture_process_user_list_ajax";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	paramMap.put("user_no", user_no);
    	
    	String sPkey = "";
    	String sTotalTime = "";
    	
    	// 검색결과 가져오기
    	List<Map<String, Object>> processUserList = sqlSession.selectList("LectureMapper.selectLectureProcessUser",paramMap);
    	
    	for( int i = 0; i < processUserList.size(); i++) {
    		sPkey = processUserList.get(i).get("pkey").toString();
    		paramMap.put("pkey", sPkey);
    		sTotalTime = sqlSession.selectOne("LectureMapper.selectLectureProcessTotalTime", paramMap);
    		processUserList.get(i).put("total_time_fmt", sTotalTime);
    	}
    	
    	model.addAttribute("processUserList", processUserList);
    	
    	return sUrl;
    }
    
    /**
     * 교육과정 목록 불러오기
     * @param request
     * @param model
     * @return
     */    
    @RequestMapping(value="/getLectureProcess")
    public String getLectureProcess(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getLectureProcess =========");
    	    	
    	String sUrl = "top_lecture/lecture_process_manage_list_ajax";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	// 검색결과 가져오기
    	List<Map<String, Object>> processList = sqlSession.selectList("LectureMapper.selectLectureProcess",paramMap);
    	model.addAttribute("processList", processList);
    	
    	//selCategoryList (등록되어있는 카테고리 목록 불러오기)
    	List<Map<String, Object>> categoryList = sqlSession.selectList("LectureMapper.selectLectureCategory",paramMap);    	   	
    	model.addAttribute("selCategoryList", categoryList);
    	
    	return sUrl;
    }
    
    /**
     * 수강신청 결재하기 Modal
     */
    @RequestMapping(value="/lectureApprovalManagerModal")
    public String lectureApprovalManagerModal(HttpServletRequest request, Model model) {
    	
    	logger.info("========= lectureApprovalManagerModal =========");

    	String sUrl = "top_lecture/lecture_approval_manage_modal";
    	
    	TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();		
		String user_no = mbrVo.getUser_no();			//등록자 사번
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String view_type = request.getParameter("view_type") != null ? request.getParameter("view_type") : "";
		
		paramMap.put("user_no", user_no);
    	
    	//CommonUtils.printMap(paramMap);
    	
    	//수강신청 정보
    	Map<String, Object> processInfo = sqlSession.selectOne("LectureMapper.selectLectureApprovalManageOne",paramMap);
    	    	
    	//교육과정 pkey
    	paramMap.put("pkey", processInfo.get("pkey"));    	
    	model.addAttribute("processInfo", processInfo);
    	
    	//교육과정 내 교육목록 가져오기
    	List<Map<String, Object>> processLectureList = sqlSession.selectList("LectureMapper.selectProcessLectureInfo",paramMap);
    	model.addAttribute("processLectureList", processLectureList);
    	
    	model.addAttribute("view_type", view_type);
    	
    	return sUrl;
    }
    
    /**
     * 교육과정 별 통계 상세보기 Modal
     */
    @RequestMapping(value="/lectureProcessStatisticsModal")
    public String lectureProcessStatisticsModal(HttpServletRequest request, Model model) {
    	
    	logger.info("========= lectureProcessStatisticsModal =========");
    	
    	String sUrl = "top_lecture/lecture_process_statistics_modal";
    	
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		    	
    	String pkey = paramMap.get("pkey").toString();
    	String type_flag = paramMap.get("type_flag").toString();
    	
    	//CommonUtils.printMap(paramMap);
    	
    	//Map<String, Object> ProcessMap = new HashMap<>();
    	
    	//모달창에 보여줄 인원 목록
    	List<Map<String,Object>> detailMemberList = new ArrayList<>();
    	
    	//교육대상자 임시목록(교육중, 교육완료 구분전)
    	List<Map<String,Object>> tempMemberList = new ArrayList<>();
    	
    	Map<String, Object> ProcessMap = sqlSession.selectOne("LectureMapper.selectLectureProcessOne", paramMap);
    	
    	String sProcessPer = "0";		//과정 진도율
    	float fProcessPer = 0;			//과정 진도율(실수형)
    	int processEndFlag = 0;		//완료되지 않은 과정수 (Quiz완료여부체크)
    	
    	String sEndDate = "";			//수료일자
    	
    	ProcessMap.put("type_flag", type_flag);
    	
    	if( "AP".equals(type_flag) ) {
    		ProcessMap.put("process_state", "교육신청한 인원");
    		
    		//신청중인 쿼리
    		detailMemberList = sqlSession.selectList("LectureMapper.selectLectureApprovalMemberListAll", paramMap);
    		//신청한 모든 직원의 진도율
    		for(int i=0; i < detailMemberList.size(); i++) {
    			paramMap.put("user_no", detailMemberList.get(i).get("user_no").toString());
    			sProcessPer = sqlSession.selectOne("LectureMapper.selectLectureProcessToProgressCal", paramMap);    			
    			detailMemberList.get(i).put("sProcessPer",sProcessPer);
    			
    			//종료일자 항목추가    			
    			sEndDate = sqlSession.selectOne("LectureMapper.selectLectureProgressEndDate", paramMap);
    			
    			fProcessPer = Float.parseFloat(sProcessPer);
    			
    			if( fProcessPer > 99  ) {
    				detailMemberList.get(i).put("sEndDate",sEndDate);
    			}else{
    				detailMemberList.get(i).put("sEndDate",'-');
    			}
    			
    		}
    	}else {
    		//교육대상자목록을 불러온다.
    		tempMemberList = sqlSession.selectList("LectureMapper.selectLectureApprovalMemberList", paramMap);    		
    		
    		if( "ING".equals(type_flag) ){
    			ProcessMap.put("process_state", "교육중인 인원");
    			for(int k=0; k < tempMemberList.size(); k++) {
    				paramMap.put("user_no", tempMemberList.get(k).get("user_no").toString());
    				sProcessPer = sqlSession.selectOne("LectureMapper.selectLectureProcessToProgressCal", paramMap);
    				tempMemberList.get(k).put("sProcessPer",sProcessPer);    				
    				fProcessPer = Float.parseFloat(sProcessPer);
    				
    				//완료여부(quiz 추가로 인해 체크항목 추가) 확인
    				processEndFlag = sqlSession.selectOne("LectureMapper.selectLectureProcessToProgressEnd", paramMap);
    				
    				if( fProcessPer < 99 || processEndFlag > 0 ) {		//진도율 99% 미만
    					detailMemberList.add(tempMemberList.get(k));
    				}
    				
    				//종료일자 항목추가 진도율 99%이상인 경우만 처리    				
        			sEndDate = sqlSession.selectOne("LectureMapper.selectLectureProgressEndDate", paramMap);        			
    				
    				if( fProcessPer > 99  ) {
    					tempMemberList.get(k).put("sEndDate",sEndDate);
        			}else{
        				tempMemberList.get(k).put("sEndDate","-");
        			}
    				
    			}
    			
    		}else if( "DONE".equals(type_flag) ){
    			ProcessMap.put("process_state", "교육완료한 인원");
    			
    			for(int k=0; k < tempMemberList.size(); k++) {
    				paramMap.put("user_no", tempMemberList.get(k).get("user_no").toString());    				
    				sProcessPer = sqlSession.selectOne("LectureMapper.selectLectureProcessToProgressCal", paramMap);
    				tempMemberList.get(k).put("sProcessPer",sProcessPer);    				
    				fProcessPer = Float.parseFloat(sProcessPer);
    				
    				//완료여부(quiz 추가로 인해 체크항목 추가) 확인
    				processEndFlag = sqlSession.selectOne("LectureMapper.selectLectureProcessToProgressEnd", paramMap);
    				
    				if( fProcessPer >= 99 && processEndFlag == 0 ) {		//진도율 99% 이상은 완료
    					detailMemberList.add(tempMemberList.get(k));
    				}
    				
    				//종료일자 항목추가    				
        			sEndDate = sqlSession.selectOne("LectureMapper.selectLectureProgressEndDate", paramMap);        			
    				
    				if( fProcessPer > 99  ) {
    					tempMemberList.get(k).put("sEndDate",sEndDate);
        			}else{
        				tempMemberList.get(k).put("sEndDate","-");
        			}
    				
    			}    			
    		}
    	}    	
    	
    	model.addAttribute("ProcessMap",ProcessMap);
    	model.addAttribute("detailMemberList",detailMemberList);    	    	
    	return sUrl;
    }    
    
    /**
     * 개인별 통계 상세보기 Modal
     */
    @RequestMapping(value="/lecturePersonStatisticsModal")
    public String lecturePersonStatisticsModal(HttpServletRequest request, Model model) {
    	
    	logger.info("========= lecturePersonStatisticsModal =========");
    	    	
    	//String sUrl = "top_lecture/lecture_show_user_modal";
    	String sUrl = "top_lecture/lecture_person_statistics_modal";
    	
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		    	
    	String user_no = paramMap.get("user_no").toString();
    	String type_flag = paramMap.get("type_flag").toString();
    	
    	//모달창에 보여줄 직원명과 상태값
    	String user_name = "";
    	String process_state = "";
    	
    	//모달창에 보여줄 목록
    	List<Map<String,Object>> detailPersonList = new ArrayList<>();
    	
    	String sProcessPer = "0";		//과정 진도율
    	float fProcessPer = 0;			//과정 진도율(실수형)
    	int processEndFlag = 0;

    	//신청중인 상태 값 가져오기
    	if( "AP".equals(type_flag) ) {    		
    		detailPersonList = sqlSession.selectList("LectureMapper.selectLectureApprovalPersonList", paramMap);
    		user_name = detailPersonList.get(0).get("user_name").toString();
    		process_state = "교육과정 신청중";
    	}else{
    		List<Map<String, Object>> pkeyList = sqlSession.selectList("LectureMapper.selectLectureApprovalEndPersonList", paramMap);
    		
    		user_name = pkeyList.get(0).get("user_name").toString();
    		
    		String sEndDate = "";
    		
    		if( "ING".equals(type_flag) ) {		//진행중인 교육    			
    			process_state = "교육과정 진행중";
    			for( int k=0; k < pkeyList.size(); k++ ) {    				    				
        			paramMap.put("pkey", pkeyList.get(k).get("pkey").toString());
        			sProcessPer = sqlSession.selectOne("LectureMapper.selectLectureProcessToProgressCal", paramMap);
        			fProcessPer = Float.parseFloat(sProcessPer);
        			
        			//종료일자 항목추가    			
        			sEndDate = sqlSession.selectOne("LectureMapper.selectLectureProgressEndDate", paramMap);
        			
        			if( fProcessPer > 99  ) {
        				pkeyList.get(k).put("sEndDate",sEndDate);
        			}else{
        				pkeyList.get(k).put("sEndDate",'-');
        			}
        			
        			//완료여부(quiz 추가로 인해 체크항목 추가) 확인
        			processEndFlag = sqlSession.selectOne("LectureMapper.selectLectureProcessToProgressEnd", paramMap);
        			
        			if( fProcessPer < 99 || processEndFlag > 0 ) {		//진행율 99% 이하
        				pkeyList.get(k).put("sProcessPer", sProcessPer);
        				detailPersonList.add(pkeyList.get(k));        				
        			}
        			
        		}
    		}else{			//진행완료
    			process_state = "교육과정 진행완료";    		
    			for( int k=0; k < pkeyList.size(); k++ ) {
        			paramMap.put("pkey", pkeyList.get(k).get("pkey").toString());        			
        			sProcessPer = sqlSession.selectOne("LectureMapper.selectLectureProcessToProgressCal", paramMap);
        			fProcessPer = Float.parseFloat(sProcessPer);
        			
        			//종료일자 항목추가    			
        			sEndDate = sqlSession.selectOne("LectureMapper.selectLectureProgressEndDate", paramMap);
        			
        			if( fProcessPer > 99  ) {
        				pkeyList.get(k).put("sEndDate",sEndDate);
        			}else{
        				pkeyList.get(k).put("sEndDate",'-');
        			}
        			
        			//완료여부(quiz 추가로 인해 체크항목 추가) 확인
        			processEndFlag = sqlSession.selectOne("LectureMapper.selectLectureProcessToProgressEnd", paramMap);
        			
        			if( fProcessPer > 99 && processEndFlag == 0 ) {		//진도율 99% 이상
        				pkeyList.get(k).put("sProcessPer", sProcessPer);
        				detailPersonList.add(pkeyList.get(k));
        			}
        		}
    		}
    	}
    	    	
    	model.addAttribute("user_name", user_name);
    	model.addAttribute("process_state", process_state);
    	model.addAttribute("detailPersonList", detailPersonList);
    	
    	return sUrl;
    }
    
    /**
     * 교육과정 확인하기 Modal
     */
    @RequestMapping(value="/lectureShowUserModal")
    public String lectureShowUserModal(HttpServletRequest request, Model model) {
    	
    	logger.info("========= lectureShowUserModal =========");
    	    	
    	String sUrl = "top_lecture/lecture_show_user_modal";
    	
    	TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();		
		String user_no = mbrVo.getUser_no();			//시청자 사번		
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		paramMap.put("user_no", user_no);
    	
    	//CommonUtils.printMap(paramMap);    	
    	
    	Map<String, Object> processInfo = sqlSession.selectOne("LectureMapper.selectLectureProcessOne",paramMap);
    	model.addAttribute("processInfo", processInfo);
    	
    	//총교육시간 가져오기
    	String sTotalTime = "";    	
    	sTotalTime = sqlSession.selectOne("LectureMapper.selectLectureProcessTotalTime", paramMap);    	
    	model.addAttribute("total_time_fmt", sTotalTime);
    	
    	//교육과정 내 교육목록 가져오기
    	List<Map<String, Object>> processLectureList = sqlSession.selectList("LectureMapper.selectProcessLectureInfo",paramMap);
    	model.addAttribute("processLectureList", processLectureList);
    	 	
    	return sUrl;
    }
    
    
    /**
     * 교육 테스트 목록 불러오기
     * @param model
     * @param session
     * @param request
     * @return
     */
    @RequestMapping(value = "/getLectureQuizList")
	public String getLectureQuizList(Model model, HttpSession session, HttpServletRequest request) {
		
    	logger.info("======= getLectureQuizList =======");
    	
		String sUrl = "top_lecture/lecture_quiz_manage_list";
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		List<Map<String, Object>> lectureQuizList = sqlSession.selectList("LectureMapper.selectLectureQuizList", paramMap);
		
		model.addAttribute("lectureQuizList", lectureQuizList);
		
		return sUrl;
	}
    
    /** 
     * 퀴즈 풀기 사용자 페이지
     * @param model
     * @param request
     * @param session
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "lecture_quiz_user_modal")
	public String lecture_quiz_user_modal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
    
		logger.info("======= lecture_quiz_user_modal =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String, Object> quizMap = sqlSession.selectOne("LectureMapper.selectLectureQuizQrderOne", paramMap);		
		
		int next_quiz_cnt = Integer.parseInt(quizMap.get("next_cnt").toString());
		int now_quiz_ord = Integer.parseInt(quizMap.get("reg_ord").toString());
		
		//다음 문제가 있는경우 reg_ord를 한개 증가시켜준다.
		if( next_quiz_cnt > 0 ) {
			quizMap.put("next_ord", now_quiz_ord+1);
		}else{
			quizMap.put("next_ord", 0);
		}
				
		model.addAttribute("quizMap",quizMap);
		
		return "/top_lecture/lecture_quiz_user_modal";
		
    }
	
    
    @RequestMapping(value = "lecture_quiz_manage_modal_detail")
	public String lecture_quiz_manage_modal_detail(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= lecture_quiz_manage_modal_detail =======");
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		
		logger.info("======= lecture_quiz_manage_modal_detail =======");
		
		String qkey = request.getParameter("qkey") != null ? request.getParameter("qkey") : "";		
		
		Map<String, Object> quizMap = sqlSession.selectOne("LectureMapper.selectLectureQuizOne", qkey);
		
		model.addAttribute("quizMap",quizMap);		
		
		return "/top_lecture/lecture_quiz_manage_modal_detail";
	}
    
    @RequestMapping(value = "/get_lecture_quiz_info", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> get_lecture_quiz_info(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= get_lecture_quiz_info =======");
		
		Map<String,Object> returnMap = new HashMap<>();		
		
		String qkey = request.getParameter("qkey") != null ? request.getParameter("qkey") : "";		
		
		Map<String, Object> quizMap = sqlSession.selectOne("LectureMapper.selectLectureQuizOne", qkey);
		
		returnMap.put("qkey", quizMap.get("qkey").toString());
		returnMap.put("title", quizMap.get("title").toString());
		returnMap.put("question", quizMap.get("question").toString());
		returnMap.put("ex1", quizMap.get("ex1").toString());
		returnMap.put("ex2", quizMap.get("ex2").toString());
		returnMap.put("ex3", quizMap.get("ex3").toString());
		returnMap.put("ex4", quizMap.get("ex4").toString());
		returnMap.put("ex5", quizMap.get("ex5").toString());
		returnMap.put("answer", quizMap.get("answer").toString());
		returnMap.put("comment", quizMap.get("comment").toString());
		returnMap.put("is_use", quizMap.get("is_use").toString());		
		
		return returnMap;
	}
    
    @RequestMapping(value = "/lecture_quiz_end", method = RequestMethod.POST)
	@ResponseBody
	public int lecture_quiz_end(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= lecture_quiz_end =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();		
		String user_no = mbrVo.getUser_no();			//교육완료자 사번
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		paramMap.put("user_no", user_no);		
		
		//리턴플래그
        int nRet = 0;        
        
        //해당 주제 완료
        nRet = sqlSession.update("LectureMapper.updateLectureProgressInfoQuizEnd",paramMap);        
        
        return nRet;		
    }
    
    @RequestMapping(value = "/lecture_quiz_action", method = RequestMethod.POST)
	@ResponseBody
	public int lecture_quiz_action(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= lecture_quiz_action =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//리턴플래그		(0:에러, 1:등록, 2:수정)
        int nRet = 0;        
        
        String sAction = paramMap.get("action").toString();
        
        //등록
        if( "I".equals(sAction) ) {
        	nRet = sqlSession.insert("LectureMapper.insertLectureQuiz", paramMap);
        }else if( "U".equals(sAction) ){
        	sqlSession.update("LectureMapper.updateLectureQuiz",paramMap);
        	nRet = 2;
        }else if( "D".equals(sAction) ) {
        	sqlSession.delete("LectureMapper.deleteLectureQuiz", paramMap);        	
        	nRet = 9;
        }        
        
        return nRet;		
    }
    
    /**
     * 교육과정 프론트 페이지 정보 가져오기 
     */
    @RequestMapping(value="/getProcessListFront")
    public String getProcessListFront(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getProcessListFront =========");
    	    	
    	String sUrl = "top_lecture/lecture_index_process_ajax";
    	
    	TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();		
		String user_no = mbrVo.getUser_no();			//등록자 사번		
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		paramMap.put("user_no", user_no);		
    	
    	String ptype = request.getParameter("ptype") != null ? request.getParameter("ptype") : "";
    	String ap_state = request.getParameter("ap_state") != null ? request.getParameter("ap_state") : "";
    	
    	paramMap.put("ap_state", 11);
    	
    	//수강과정 목록불러오기
    	List<Map<String, Object>> myLectureProcessListOrg = sqlSession.selectList("LectureMapper.selectFrontLectureProcessList",paramMap);    	    	
		List<Map<String, Object>> myLectureProcessList = new ArrayList<>();
		Map<String, Object> myLectureProcessMap = new HashMap<String, Object>();
		
		String sPkey = "";
    	String sProgressPer = "0";
    	int processEndFlag = 0; 	//과정완료여부
    	
    	for( int i = 0; i < myLectureProcessListOrg.size(); i++) {
    		sPkey = myLectureProcessListOrg.get(i).get("pkey").toString();
    		paramMap.put("pkey", sPkey);    		
    		sProgressPer = sqlSession.selectOne("LectureMapper.selectLectureProcessToProgressCal", paramMap);
    		myLectureProcessListOrg.get(i).put("progress_per", sProgressPer);
    		
    		//완료여부(quiz 추가로 인해 체크항목 추가) 확인
    		processEndFlag = sqlSession.selectOne("LectureMapper.selectLectureProcessToProgressEnd", paramMap);
    		    		
        	if( "Done".equals(ptype) ) {			//교육완료인 경우만 리스트에 넣는다.
        		if( Float.parseFloat(sProgressPer) >= 99 && processEndFlag == 0 ) {
        			myLectureProcessMap = sqlSession.selectOne("LectureMapper.selectFrontLectureProcessInfo",paramMap);
        			myLectureProcessMap.put("progress_per", 100.0);
        			myLectureProcessMap.put("ing_flag", 0);
        			myLectureProcessList.add(myLectureProcessMap);        			
        		}
        	}else if( "Ing".equals(ptype) ) {		//교육진행 중인 경우만 리스트에 넣는다.
        		if( Float.parseFloat(sProgressPer) < 99 || processEndFlag > 0 ) {
        			myLectureProcessMap = sqlSession.selectOne("LectureMapper.selectFrontLectureProcessInfo",paramMap);
        			myLectureProcessMap.put("progress_per", sProgressPer);
        			myLectureProcessMap.put("ing_flag", processEndFlag);
        			myLectureProcessList.add(myLectureProcessMap);
        		}
        	}else {					//전체 또는 종료인경우는 진행율과 상관없이 목록에 넣는다.
        		//myLectureProcessList = myLectureProcessListOrg;
        		myLectureProcessMap = sqlSession.selectOne("LectureMapper.selectFrontLectureProcessInfo",paramMap);
    			myLectureProcessMap.put("progress_per", sProgressPer);
    			myLectureProcessMap.put("ing_flag", processEndFlag);
    			myLectureProcessList.add(myLectureProcessMap);
        	}
    	}
    	
    	model.addAttribute("myLectureProcessList", myLectureProcessList);
    	model.addAttribute("ptype",ptype);
    	    	
    	return sUrl;
    }
    
    /**
     * 공개 강의실 조회자 로그
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/openLectureLogModal")
    public String openLectureLogModal(HttpServletRequest request, Model model) {
    	
    	logger.info("========= openLectureLogModal =========");

    	String sUrl = "top_lecture/lecture_open_log_modal";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	List<Map<String, Object>> openLectureLogList = sqlSession.selectList("LectureMapper.selectLectureOpenLogList", paramMap);
    	model.addAttribute("openLectureLogList", openLectureLogList);
    	
    	return sUrl;
    }
    
    /**
     * 공개 강의실 정보 확인하기 Modal
     */
    @RequestMapping(value="/openLectureUserModal")
    public String openLectureUserModal(HttpServletRequest request, Model model) {
    	
    	logger.info("========= openLectureUserModal =========");
    	    	
    	//String sUrl = "top_lecture/lecture_process_user_modal";
    	String sUrl = "top_lecture/lecture_open_user_modal";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	Map<String, Object> openLectureMap = sqlSession.selectOne("LectureMapper.selectLectureOpenOne", paramMap);
    	model.addAttribute("openLectureMap", openLectureMap);
    	
    	return sUrl;
    }
    
    /**
     * 교육과정 확인하기 Modal
     */
    @RequestMapping(value="/lectureProcessUserModal")
    public String lectureProcessUserModal(HttpServletRequest request, Model model) {
    	
    	logger.info("========= lectureProcessUserModal =========");
    	    	
    	String sUrl = "top_lecture/lecture_process_user_modal";
    	
    	TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();		
		String user_no = mbrVo.getUser_no();			//등록자 사번		
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		paramMap.put("user_no", user_no);
    	
    	String view_type = request.getParameter("view_type") != null ? request.getParameter("view_type") : "";
    	String ap_state = request.getParameter("ap_state") != null ? request.getParameter("ap_state") : "";
    	
    	Map<String, Object> processInfo;
    	
    	if( "info".equals(view_type) || "add".equals(view_type)) {
    		processInfo = sqlSession.selectOne("LectureMapper.selectLectureProcessOne",paramMap);
    		model.addAttribute("processInfo", processInfo);
    	}else if( "view".equals(view_type) ) {
    		processInfo = sqlSession.selectOne("LectureMapper.selectLectureProcessApOne",paramMap);
    		model.addAttribute("processInfo", processInfo);
    	}
    	
    	String sTotalTime = "";    	
    	sTotalTime = sqlSession.selectOne("LectureMapper.selectLectureProcessTotalTime", paramMap);    	
    	model.addAttribute("total_time_fmt", sTotalTime);    	
    	
    	//교육과정 내 교육목록 가져오기
    	List<Map<String, Object>> processLectureList = sqlSession.selectList("LectureMapper.selectProcessLectureInfo",paramMap);
    	model.addAttribute("processLectureList", processLectureList);
    	
    	//모달창 보기타입
    	model.addAttribute("view_type", view_type);
    	
    	//현재 결재상태
    	model.addAttribute("ap_state", ap_state);    	
    	return sUrl;
    }
    
    /**
     * 교육주제 테스트 구성하기 Modal
     */
    @RequestMapping(value="/lectureQuizRelationModal")
    public String lectureQuizRelationModal(HttpServletRequest request, Model model) {
    	
    	logger.info("========= lectureQuizRelationModal =========");

    	String sUrl = "top_lecture/lecture_quiz_relation_modal";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	//선택한 주제정보 가져오기
    	Map<String, Object> lectureInfo = sqlSession.selectOne("LectureMapper.selectLectureInfoOne",paramMap);
    	model.addAttribute("lectureInfo", lectureInfo);
    	
    	//기존 주제에 등록되어있는 테스트목록(등록된 테스트가 없으면 빈값으로 가져온다.)
    	String notInQkeys = "";
    	notInQkeys = sqlSession.selectOne("LectureMapper.selectLectureInfoQuizExtra",paramMap);    	
    	paramMap.put("notInQkeys", notInQkeys);
    	
    	//전체 교육목록 가져오기
    	List<Map<String, Object>> lectureQuizList = sqlSession.selectList("LectureMapper.selectLectureQuizList",paramMap);
    	model.addAttribute("lectureQuizList", lectureQuizList);
    	
    	//교육주제 내 테스트목록 가져오기
    	List<Map<String, Object>> lectureRelationQuizList = sqlSession.selectList("LectureMapper.selectLectureInfoToQuiz",paramMap);
    	model.addAttribute("lectureRelationQuizList", lectureRelationQuizList);
    	
    	return sUrl;
    }    
    
    /**
     * 교육과정 구성하기 Modal
     */
    @RequestMapping(value="/lectureProcessModal")
    public String lectureProcessModal(HttpServletRequest request, Model model) {
    	
    	logger.info("========= lectureProcessModal =========");
    	    	
    	String sUrl = "top_lecture/lecture_process_modal";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	//CommonUtils.printMap(paramMap);
    	//선택한 과정정보 가져오기
    	Map<String, Object> processInfo = sqlSession.selectOne("LectureMapper.selectLectureProcessOne",paramMap);
    	model.addAttribute("processInfo", processInfo);
    	
    	//기존 과정에 등록되어있는 교육목록(등록된 교육가 없으면 빈값으로 가져온다.)
    	String notInEkeys = "";
    	notInEkeys = sqlSession.selectOne("LectureMapper.selectProcessLectureInfoExtra",paramMap);    	
    	paramMap.put("notInEkeys", notInEkeys);
    	
    	//전체 교육목록 가져오기 (기존에 등록되어 있는 교육는 제외하고 가져오도록 수정할것....)
    	List<Map<String, Object>> lectureList = sqlSession.selectList("LectureMapper.selectLectureInfo",paramMap);
    	model.addAttribute("lectureList", lectureList);
    	
    	//교육과정 내 교육목록 가져오기
    	List<Map<String, Object>> processLectureList = sqlSession.selectList("LectureMapper.selectProcessLectureInfo",paramMap);
    	model.addAttribute("processLectureList", processLectureList);
    	
    	return sUrl;
    }
    
    /**
	 * 교육과정 내부 구성 데이터 Action
	 * param : action = I, U, D
	 * 
	 */	
	@RequestMapping(value="/lectureRelationQuizAction")
    @ResponseBody
    public int lectureRelationQuizAction(HttpServletRequest request, Model model, HttpSession session) {
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
		//action : I(추가), U(업데이트)
		String sEkey = paramMap.get("ekey").toString();
		paramMap.put("ekey", sEkey);
		
		logger.info("======= lectureRelationQuizAction : "+ sEkey +" =======");
				
    	int nCnt = 0;
    	
    	//CommonUtils.printMap(paramMap);
    	
    	String [] targetLectureInfoList = request.getParameterValues("targetLectureInfoList[]");
    	
    	//기존에 등록된 관계테이블 삭제
    	nCnt = sqlSession.delete("LectureMapper.deleteLectureRelationQuizEkey", paramMap);
    	
    	if( targetLectureInfoList != null ) {
    		for( int i=0; i < targetLectureInfoList.length; i++) {    		
        		paramMap.put("qkey", targetLectureInfoList[i]);
        		paramMap.put("reg_ord", i);							//정렬순서는 넘어온 배열순서로 넣어준다.    		
        		nCnt = sqlSession.insert("LectureMapper.insertLectureQuizRelation", paramMap);
        	}    		
    	}
    	return nCnt; 
	}
    
    /**
	 * 교육과정 내부 구성 데이터 Action
	 * param : action = I, U, D
	 * 
	 */	
	@RequestMapping(value="/lectureRelationAction")
    @ResponseBody
    public int lectureRelationAction(HttpServletRequest request, Model model, HttpSession session) {
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
		//action : I(추가), U(업데이트)
		String sPkey = paramMap.get("pkey").toString();
		paramMap.put("pkey", sPkey);
		
		logger.info("======= lectureRelationAction : "+ sPkey +" =======");
				
    	int nCnt = 0;
    	
    	//CommonUtils.printMap(paramMap);
    	
    	String [] targetLectureList = request.getParameterValues("targetLectureList[]");
    	
    	//기존에 등록된 관계테이블 삭제
    	nCnt = sqlSession.delete("LectureMapper.deleteLectureRelationPkey", paramMap);
    	
    	if( targetLectureList != null ) {
    		for( int i=0; i < targetLectureList.length; i++) {    		
        		paramMap.put("ekey", targetLectureList[i]);
        		paramMap.put("reg_ord", i);							//정렬순서는 넘어온 배열순서로 넣어준다.    		
        		nCnt = sqlSession.insert("LectureMapper.insertLectureRelation", paramMap);
        	}    		
    	}
    	return nCnt; 
	}
	
	/**
	 * 사용자수강신청 Action
	 * param : action_type = apply, cancel
	 * 
	 */	
	@RequestMapping(value="/lectureUserAction")
    @ResponseBody
    public int lectureUserAction(HttpServletRequest request, Model model, HttpSession session) {
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		
		String user_no = mbrVo.getUser_no();			//신청자 사번
		String team_id = mbrVo.getTeam_id_main();		//신청자 팀아이디
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		paramMap.put("user_no", user_no);
		paramMap.put("team_id", team_id);
		
		//action : I(추가), U(업데이트)
		String action_type = paramMap.get("action_type").toString();		
		
		logger.info("======= lectureUserAction : "+ action_type +" =======");
				
    	int nCnt = 0;
    	
    	//CommonUtils.printMap(paramMap);
    	
    	if( "apply".equals(action_type) ){
    		paramMap.put("ap_state", "10");			//결재 상태 : 결재대기
    		nCnt = sqlSession.insert("LectureMapper.insertLectureUserAppoval", paramMap);
    	}else if( "cancel".equals(action_type) ) {
    		//paramMap.put("ap_state", "99");			//결재 상태 : 신청 취소 (신청취소시 결재정보를 삭제로 처리)
    		//nCnt = sqlSession.update("LectureMapper.updateLectureUserAppovalCancel", paramMap);
    		nCnt = sqlSession.delete("LectureMapper.deleteLectureUserApprovalCancel", paramMap);    		
    	}
    	
    	return nCnt; 
	}
	
	/**
	 * 관리자 수강신청결재 Action
	 * param : action_type = confirm, reject
	 * 
	 */	
	@RequestMapping(value="/lectureManagerAction")
    @ResponseBody
    public Map<String, Object> lectureManagerAction(HttpServletRequest request, Model model, HttpSession session) {
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		
		String user_no = mbrVo.getUser_no();			//결재자사번		
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String, Object> returnMap = new HashMap<>();
		
		paramMap.put("ap_user_no", user_no);		
		
		//action : I(추가), U(업데이트)
		String action_type = paramMap.get("action_type").toString();		
		
		logger.info("======= lectureManagerAction : "+ action_type +" =======");
		
    	//CommonUtils.printMap(paramMap);    	

    	if( "confirm".equals(action_type) ) {
    		paramMap.put("ap_state", "11");			//결재 상태 : 결재승인
    		sqlSession.update("LectureMapper.updateLectureManagerAppoval", paramMap);
    	}else if( "reject".equals(action_type) ) {
    		paramMap.put("ap_state", "12");			//결재 상태 : 결재반려
    		sqlSession.update("LectureMapper.updateLectureManagerAppoval", paramMap);
    	}else if( "cancel".equals(action_type) ) {
    		paramMap.put("ap_state", "10");			//결재 상태 : 결재대기
    		sqlSession.update("LectureMapper.updateLectureManagerAppoval", paramMap);
    	}
    	
    	returnMap.put("action_type", action_type);    	
    	
    	return returnMap; 
	}
	
	/**
	 * 공개 강의실 보기(시청)페이지
	 * @param model
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 * @throws UnsupportedEncodingException
	 * @throws IOException
	 */
	@RequestMapping(value = "/lectureOpenClassView", method = RequestMethod.POST) 
	public String lectureOpenClassView(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws UnsupportedEncodingException, IOException {
		
		logger.info("======= lectureOpenClassView =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");		
		
		Map<String, Object> openInfo = sqlSession.selectOne("LectureMapper.selectLectureOpenOne", paramMap);
		model.addAttribute("openInfo", openInfo);
		
		//조회로그 등록 시작
		String logCenterName = mbrVo.getCenter_name();
		String logTeamName = mbrVo.getTeam_name();
		String logTeamId = mbrVo.getTeam_id_main();
		String logUserName = mbrVo.getUser_name();
		String logUserNo = mbrVo.getUser_no();
		String logUserIp = mbrVo.getUser_ip();
		String logOkey = paramMap.get("okey").toString();
		
		Map<String, Object> logMap = new HashMap<>();
		
		logMap.put("okey", logOkey);
		logMap.put("user_no", logUserNo);
		logMap.put("user_name", logUserName);
		logMap.put("team_id", logTeamId);
		logMap.put("team_name", logTeamName);
		logMap.put("center_name", logCenterName);
		logMap.put("user_ip", logUserIp);		
		
		int nLogChk = 0;
		
		nLogChk = sqlSession.selectOne("LectureMapper.countLectureOpenLog", logMap);
		
		//이미 등록된 로그정보가 없는 경우만 로그로 등록한다.
		if( nLogChk == 0 ) {
			sqlSession.insert("LectureMapper.insertLectureOpenLog", logMap);
		}		
		//System.out.println( logCenterName+" : "+logTeamName+" : "+logTeamId+" : "+logUserName+" : "+logUserNo+" : "+logUserIp);		
		//조회로그 등록 끝
		
		return "top_lecture/lecture_open_class_view";
	}
	
	/**
	 * 2분 미리보기 모달 창
	 * @param model
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 * @throws UnsupportedEncodingException
	 * @throws IOException
	 */
	
	@RequestMapping(value = "/lectureClassPreView", method = RequestMethod.POST) 
	public String lectureClassPreView(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws UnsupportedEncodingException, IOException {
		
		logger.info("======= lectureClassPreView =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		Map<String, Object> eduInfo = sqlSession.selectOne("LectureMapper.selectLectureInfoOne", paramMap);
		
		model.addAttribute("eduInfo", eduInfo);		

		return "top_lecture/lecture_class_preview";
	}
	
	/**
	 * 관리자용 강의 보기(풀영상)
	 * @param model
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 * @throws UnsupportedEncodingException
	 * @throws IOException
	 */	
	@RequestMapping(value = "/lectureClassManagerView", method = RequestMethod.POST) 
	public String lectureClassManagerView(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws UnsupportedEncodingException, IOException {
		
		logger.info("======= lectureClassManagerView =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		Map<String, Object> eduInfo = sqlSession.selectOne("LectureMapper.selectLectureInfoOne", paramMap);
				
		model.addAttribute("eduInfo", eduInfo);
				
		return "top_lecture/lecture_class_manage_view";
	}
	
	@RequestMapping(value = "/lectureClassView", method = RequestMethod.POST) 
	public String lectureClassView(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws UnsupportedEncodingException, IOException {
		
		logger.info("======= lectureClassView =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");		
		
		String ekey = request.getParameter("ekey") != null ? request.getParameter("ekey") : "";
		String user_no = mbrVo.getUser_no();			//시청자 사번
		
		Map<String, Object> eduInfo = sqlSession.selectOne("LectureMapper.selectLectureInfoOne", paramMap);
		
		//교육 할당 시간(초)
		int time_second = Integer.parseInt(eduInfo.get("time_second").toString());
		
		//진도율 정보 시작
		paramMap.put("user_no", user_no);
		
		//기존 진도율 정보가 있는지 확인한다.		
		int nChk_progress = sqlSession.selectOne("LectureMapper.selectLectureProgressChk", paramMap);
		
		float progressPer = 0;
		
		//진도율이 없는 경우 초기화하여 입력해준다.
		if( nChk_progress == 0 ) {
			sqlSession.insert("LectureMapper.insertLectureProgressInfo",paramMap);			
		}
		
		Map<String, Object> eduProgress = sqlSession.selectOne("LectureMapper.selectLectureProgressOne", paramMap);
				
		//진도율 정보 끝		
		int view_second = 0;
		
		view_second = Integer.parseInt(eduProgress.get("view_second").toString());
		
		if( view_second > 0 ){
			progressPer = view_second * 100 / time_second;			
		}
		
		//주제 완료 후 풀어야할 quiz 가 있는지 확인한다.				
		int nQchk = sqlSession.selectOne("LectureMapper.selectLectureQuizChk", ekey);
		
		model.addAttribute("quizCnt", nQchk);
		model.addAttribute("eduInfo", eduInfo);
		model.addAttribute("eduProgress", eduProgress);
		model.addAttribute("progress_per", progressPer);
		
		return "top_lecture/lecture_class_view";
	}
	
	@RequestMapping(value="/updateLectureProgress")
    @ResponseBody
    public Map<String, Object> updateLectureProgress(HttpServletRequest request, Model model, HttpSession session) {
		
		logger.info("======= updateLectureProgress =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String, Object> returnMap = new HashMap<>();
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		String user_no = mbrVo.getUser_no();			//시청자 사번
		
		float progressPer = 0;
		
		paramMap.put("user_no", user_no);
		
		int lecture_time = Integer.parseInt(paramMap.get("lecture_time").toString());					//기준교육시간		
		int result_second = Integer.parseInt(paramMap.get("view_second").toString()) + 5;			//진행된 교육시간 (5초씩 증가)
		
		String ekey = paramMap.get("ekey").toString();
		
		//주제 완료 후 풀어야할 quiz 가 있는지 확인한다.				
		int nQchk = sqlSession.selectOne("LectureMapper.selectLectureQuizChk", ekey);
		
		if( lecture_time * 0.99 < result_second ) {		//교육시간을 다 채운 경우 완료로처리하고 교육시간과 동일 하게 갱신한다.
			
			//강의 종료시간이 존재하는지 체크한다. (존재하는 경우는 퀴즈까지 완료한 상태)
			String sEndLecture = sqlSession.selectOne("LectureMapper.selectLectureEndDateChk",paramMap);			
			
			if( nQchk > 0 && "ING".equals(sEndLecture)) {
				paramMap.put("end_flag", 1);			//문제를 풀고난 후 완료로 바꾸어야하므로 진행상태로 처리한다.
			}else{
				paramMap.put("end_flag", 2);			//완료상태로 변경
			}			
			paramMap.put("view_second", lecture_time);		//교육할당시간과 동일하게 변경			
			sqlSession.update("LectureMapper.updateLectureProgressInfo",paramMap);
			
			progressPer = 100;
			
		}else{
			paramMap.put("end_flag", 1);			//진행중인 상태로 변경
			paramMap.put("view_second", result_second);		//교육할당시간과 동일하게 변경			
			sqlSession.update("LectureMapper.updateLectureProgressInfo",paramMap);
			
			progressPer = result_second * 100 / lecture_time;			
		}
		
		returnMap.put("quiz_cnt", nQchk);
		returnMap.put("result_second", result_second);
		returnMap.put("progress_per", progressPer);
		
		return returnMap;
	}
	
	/**
	 * 공개 강의실 목록
	 * @param model
	 * @param session
	 * @param request
	 * @param boardWriteSuccess
	 * @param boardUpdateSuccess
	 * @param searchVO
	 * @return
	 */
	@RequestMapping(value = "/lectureOpenList", method = RequestMethod.GET)
	public String lectureOpenList(Model model, HttpSession session, HttpServletRequest request, BoardSearchVO searchVO) {
		logger.info("======= lectureOpenList =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("lectureOpenList - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String teamType = request.getParameter("teamType") != null ? request.getParameter("teamType") : "";
		String categoryType = request.getParameter("categoryType") != null ? request.getParameter("categoryType") : "";
		String srchSubject = request.getParameter("srchSubject") != null ? request.getParameter("srchSubject") : "";
		
		//검색 분류 조건
		searchVO.setTeamType(teamType);					//교육구분
		searchVO.setCategoryType(categoryType);			//교육분류
		searchVO.setSubjectSearch(srchSubject);			//강의명
		
		//selCategoryList (등록되어있는 카테고리 목록 불러오기)
		List<Map<String, Object>> categoryList = sqlSession.selectList("LectureMapper.selectLectureCategory",paramMap);    	
    	model.addAttribute("selCategoryList", categoryList);
		
		model.addAttribute("searchVO", searchVO);
		
		//return "brd_lecture_data/board_list";
		return "/top_lecture/lecture_open_class_list";
	}
	
	@RequestMapping(value = "/lectureOpenListAjax", method = RequestMethod.POST)
	public String lectureOpenListAjax(Model model, HttpServletRequest request, HttpSession session, BoardSearchVO searchVO) {
		logger.info("======= lectureOpenListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String teamType = request.getParameter("teamType") != null ? request.getParameter("teamType") : "";
		String categoryType = request.getParameter("categoryType") != null ? request.getParameter("categoryType") : "";
		String srchSubject = request.getParameter("srchSubject") != null ? request.getParameter("srchSubject") : "";
		
		//검색 분류 조건
		searchVO.setTeamType(teamType.replace("null", ""));					//교육구분
		searchVO.setCategoryType(categoryType.replace("null", ""));			//교육분류
		searchVO.setSubjectSearch(srchSubject.replace("null", ""));			//강의명
		
		BoardPageUtil pageUtil = new BoardPageUtil();
		
		List<BoardVO> boardList = (List<BoardVO>) pageUtil.boardPageSearch1(1, sqlSession, "LectureMapper.lectureOpenClassList", searchVO, model, "lectureOpenClassList");		
		int boardListCnt = sqlSession.selectOne("LectureMapper.lectureOpenClassListCnt", searchVO);

		model.addAttribute("boardList", boardList);
		model.addAttribute("boardListCnt", boardListCnt);
		model.addAttribute("reqPgNo", paramMap.get("reqPgNo"));		
		model.addAttribute("searchVO", searchVO);		
		
		return "top_lecture/lecture_open_class_list_ajax";
		
	}
	
	/**
	 * 공개교육 첨부파일 다운로드 
	 * @param okey
	 * @param session
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value = "oOpenFileDownload", method = RequestMethod.GET)
	 public void oOpenFileDownload(String okey, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws IOException{
		logger.info("======= oOpenFileDownload ("+okey+")=======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);		

		Map<String, Object> eduInfo = sqlSession.selectOne("LectureMapper.selectLectureOpenOne", paramMap);
		
		String sFile_path = eduInfo.get("file_path").toString();
		String sFile_org_name = eduInfo.get("file_org_name").toString(); 
		String sFile_enc_name = eduInfo.get("file_enc_name").toString();
		String downFileName = "";
		
		try {
			//다운로드 파일명 재설정(파일명만 나오게)
			downFileName = java.net.URLEncoder.encode(sFile_org_name,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		response.setHeader("Content-Disposition","attachment;filename="+downFileName);
		
		String fullPath = sFile_path + File.separator + sFile_enc_name;		
		
		ServletOutputStream sout = response.getOutputStream();
		FileInputStream fin = new FileInputStream(fullPath);
		
		byte[] buf = new byte[1024];
		int size=0;
		while((size=fin.read(buf,0,1024))!=-1){
			sout.write(buf,0,size);
		}
		sout.flush();
		fin.close();
		sout.close();		
	}
	
	/**
	 * ekey 를 이용해서 교육자료를 다운로드한다.
	 * @param ekey
	 * @param session
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	
	@RequestMapping(value = "eInfoFileDownload", method = RequestMethod.GET)
	 public void fileDownload(String ekey, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws IOException{
		logger.info("======= eInfoFileDownload ("+ekey+")=======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		Map<String, Object> eduInfo = sqlSession.selectOne("LectureMapper.selectLectureInfoOne", paramMap);
		
		String sFile_path = eduInfo.get("file_path").toString();
		String sFile_org_name = eduInfo.get("file_org_name").toString(); 
		String sFile_enc_name = eduInfo.get("file_enc_name").toString();
		String downFileName = "";
		
		try {
			//다운로드 파일명 재설정(파일명만 나오게)
			downFileName = java.net.URLEncoder.encode(sFile_org_name,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		response.setHeader("Content-Disposition","attachment;filename="+downFileName);
		
		String fullPath = sFile_path + File.separator + sFile_enc_name;		
		
		ServletOutputStream sout = response.getOutputStream();
		FileInputStream fin = new FileInputStream(fullPath);
		
		byte[] buf = new byte[1024];
		int size=0;
		while((size=fin.read(buf,0,1024))!=-1){
			sout.write(buf,0,size);
		}
		sout.flush();
		fin.close();
		sout.close();
		
	}	
}
