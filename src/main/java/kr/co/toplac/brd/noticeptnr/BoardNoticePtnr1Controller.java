/*
*********************************************************
* Program ID	: BoardNoticePtnr1Controller
* Program Name	: BoardNoticePtnr1Controller
* Description	: 보험사공지(1종)
* Author		: 
* Date			: 2016.06.11.
*********************************************************
*/
package kr.co.toplac.brd.noticeptnr;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
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
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import kr.co.toplac.brd.common.BoardFileUtil;
import kr.co.toplac.brd.common.BoardFileVO;
import kr.co.toplac.brd.common.BoardMemoViewVO;
import kr.co.toplac.brd.common.BoardPageUtil;
import kr.co.toplac.brd.common.BoardSearchVO;
import kr.co.toplac.brd.common.BoardVO;
import kr.co.toplac.cmm.service.CodeDicService;
import kr.co.toplac.sysadm.SysAdmCodeDicVO;
import kr.co.toplac.topptnr.TopPtnrBscVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.PaginationInfo;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;
import kr.co.toplac.util.rpt.MainLeftUtil;

@Controller
public class BoardNoticePtnr1Controller {

	private static final Logger logger = LoggerFactory.getLogger(BoardNoticePtnr1Controller.class);

	@Autowired
	SqlSession sqlSession;

	@Autowired
	MainLeftUtil mlu;
	
	@Autowired
	private CodeDicService CodeDicService;
	
	/**
	 * 4종 분류관리
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/insu4TemplistCategory")
	public String insu4TemplistCategory(Model model, HttpServletRequest request, HttpSession session) {
		
		logger.info("======= insu4TemplistCategory =======");
		
		return "top_template/template_list4_category";
	}
	
	
	/**
	 * 4종 인보험 자료실
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/insu4Templist")
	public String insu4Templist(Model model, HttpServletRequest request, HttpSession session) {
		
		logger.info("======= insu4Templist =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_34().equals("0"))){
			logger.info("insu4Templist - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		/*세션 유효 검사 종료*/		
		//CommonUtils.printMap(paramMap);

		//좌측메뉴용
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());
		
		//팀타입 조회 권한
		String authTeamType = mbrAuthVo.getMbr_pms_34().toString();
		
		//서식종류가져오기
		SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();		
		codeVo.setTbl_nm("top_insu_template4");
		codeVo.setCol_nm("category_id");
		
		List<SysAdmCodeDicVO> categoryTypeList = CodeDicService.codeList(codeVo);
		model.addAttribute("categoryListForSearch", categoryTypeList);
		
		//팀타입 조회권한
		model.addAttribute("authTeamType", authTeamType);		
		model.addAttribute("searchParam", paramMap);		

		return "top_template/template_list4";
	}
	
	/**
	 * 교육자료 다운로드
	 * @param request (tkey)
	 * @param response
	 */
	@RequestMapping(value = "eduClassFiledown")
    public void eduClassFiledown(HttpServletRequest request, HttpServletResponse response){
    	
		logger.info("======= eduClassFiledown =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		EduClassBean eduClassInfo = sqlSession.selectOne("BoardNoticePtnr1Mapper.getEduClassInfo", paramMap);
		
		String origFilename = eduClassInfo.getReport_name();			//다운로드될 파일명    	
    	String file_path = eduClassInfo.getReport_path();				//다운로드될 파일경로
    	    	
		try {
			origFilename = java.net.URLEncoder.encode(origFilename,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		response.setHeader("Content-Disposition","attachment;filename="+origFilename);
		
    	String fullPath = file_path;
		
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
	
	/**
	 * 교육자료 등록
	 * @param model
	 * @param request
	 * @param session 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "actionEduClassNew")
	@ResponseBody
	public Map<String,Object> actionEduClassNew(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= actionEduClassNew =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String,Object> returnMap = new HashMap<>();		
		
		int nRet = 0;
		
		String team_type = request.getParameter("team_type") != null ? request.getParameter("team_type") : "";
		String category_id = request.getParameter("category_id") != null ? request.getParameter("category_id") : "";
		String user_no = request.getParameter("user_no") != null ? request.getParameter("user_no") : "";		
		String file_path = request.getParameter("file_path") != null ? request.getParameter("file_path") : "";
		String file_name = request.getParameter("file_name") != null ? request.getParameter("file_name") : "";
		String teacher_name = request.getParameter("teacher_name") != null ? request.getParameter("teacher_name") : "";		 
		
		String action = request.getParameter("action") != null ? request.getParameter("action") : "";
		
		//운영
		// String fullPath = "/home" + File.separator + "hosting_users" + File.separator
		// + "toplac" + File.separator + "www" + File.separator + "edu_class" + File.separator + file_path;
		
		
		//개발
		//String fullPath = "D:\\home" + File.separator + "hosting_users" + File.separator + "toplac" + File.separator
		//		+ "www" + File.separator + "edu_class" + File.separator + file_path;
		
		//paramMap.put("file_path", fullPath);
		paramMap.put("file_path", file_path);
		
		if( "C".equals(action) ) {		//교육자료 정보등록			
			//DB 에 추가한다.			
			nRet = sqlSession.insert("BoardNoticePtnr1Mapper.insertEduClass", paramMap);
			
		}
		
		if( nRet == 1) {
			returnMap.put("result", 1);
		}else if( nRet == 91 ) {
			returnMap.put("result", 91);
		}
		
		return returnMap;			
	}
	
	/**
	 * 교육목록 가져오기
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/eduClassListAjax", method = RequestMethod.POST)
	public String eduClassListAjax(Model model, HttpServletRequest request, HttpSession session) {
		logger.info("======= eduClassListAjax =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		
		int eduClassListCnt = sqlSession.selectOne("BoardNoticePtnr1Mapper.eduClassListCnt", paramMap);
		List<EduClassBean> eduClassList = sqlSession.selectList("BoardNoticePtnr1Mapper.eduClassList", paramMap);
		
		//===============================================
		// 페이지 관련 변수 선언
		//===============================================
		int sizePerPage = 20;       // 한페이지당 보여줄 글 갯수
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
		
		//페이징
		PaginationInfo pageInfo = new PaginationInfo();			
		pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
		pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
		pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
		pageInfo.setTotalRecordCount(eduClassListCnt);   				// 총 글 갯수		
		model.addAttribute("pageInfo", pageInfo);
		
		model.addAttribute("eduClassList", eduClassList);
		model.addAttribute("eduClassListCnt", eduClassListCnt);
		
		return "top_educlass/educlass_list_ajax";
	}
	
	@RequestMapping(value = "/eduClassView", method = RequestMethod.POST) 
	public String eduClassView(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws UnsupportedEncodingException, IOException {
		
		logger.info("======= eduClassView =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		
		String ekey = request.getParameter("ekey") != null ? request.getParameter("ekey") : "";
		String user_no = mbrVo.getUser_no();
		
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_36().equals("0"))){
			logger.info("eduClassView - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}		
		/*세션 유효 검사 종료*/
		
		Map<String,Object> eduInfo = sqlSession.selectOne("BoardNoticePtnr1Mapper.eduClassInfo", ekey);
		
		String sFilePath = eduInfo.get("file_path").toString();
		
		//CommonUtils.printMap(paramMap);
		
		model.addAttribute("eduInfo", eduInfo);
		
		return "top_educlass/educlass_view";		
	}
	
	@RequestMapping(value = "/eduClass")
	public String eduClass(Model model, HttpServletRequest request, HttpSession session) {
		
		logger.info("======= eduClass =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_36().equals("0"))){
			logger.info("eduClass - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		/*세션 유효 검사 종료*/
		
		//CommonUtils.printMap(paramMap);

		//좌측메뉴용
		//mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		//mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());
		
		//팀타입 조회 권한
		String authTeamType = mbrAuthVo.getMbr_pms_36().toString();
		
		//서식종류가져오기
		SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();		
		codeVo.setTbl_nm("top_edu_class");
		codeVo.setCol_nm("category_id");
		
		List<SysAdmCodeDicVO> categoryTypeList = CodeDicService.codeList(codeVo);
		model.addAttribute("categoryListForSearch", categoryTypeList);
		
		//팀타입 조회권한
		model.addAttribute("authTeamType", authTeamType);		
		model.addAttribute("searchParam", paramMap);		

		return "top_educlass/educlass_list";
	}
	
	@RequestMapping(value = "/insuTemplist")
	public String insuTemplist(Model model, HttpServletRequest request, HttpSession session) {
		
		logger.info("======= insuTemplist =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_31().equals("0"))){
			logger.info("noticePtnr1Board - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		/*세션 유효 검사 종료*/
		
		//CommonUtils.printMap(paramMap);

		//좌측메뉴용
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());
		
		//팀타입 조회 권한
		String authTeamType = mbrAuthVo.getMbr_pms_31().toString();
		
		//보험사 목록 가져오기		
		List<TopPtnrBscVO> ptnrListForSearch = sqlSession.selectList("RptInvListMapper.ptnrListForSearch");
		
		model.addAttribute("ptnrListForSearch", ptnrListForSearch);
		
		//서식종류가져오기
		SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();		
		codeVo.setTbl_nm("top_insu_template");
		codeVo.setCol_nm("category_id");
		
		List<SysAdmCodeDicVO> categoryTypeList = CodeDicService.codeList(codeVo);
		model.addAttribute("categoryListForSearch", categoryTypeList);
		
		//안내문구 종류가져오기		
		codeVo.setCol_nm("nofile_content");
		List<SysAdmCodeDicVO> noFileContentListForSearch = CodeDicService.codeList(codeVo);
		model.addAttribute("noFileContentListForSearch", noFileContentListForSearch);		
		
		//팀타입 조회권한
		model.addAttribute("authTeamType", authTeamType);		
		model.addAttribute("searchParam", paramMap);		

		return "top_template/template_list";
	}
	
	/**
	 * 인보험 자료실 자료분류 목록 가져오기
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/templateCategoryList4Ajax", method = RequestMethod.POST)
	public String templateCategoryList4Ajax(Model model, HttpServletRequest request, HttpSession session) {
		logger.info("======= templateCategoryList4Ajax =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);		
		
		//List<InsuTemplateBean> templateList = sqlSession.selectList("BoardNoticePtnr1Mapper.insuTemplateList4", paramMap);		
		List<Map<String,Object>> templateCategoryList = sqlSession.selectList("BoardNoticePtnr1Mapper.insuTemplateCategoryList4", paramMap);
		
		model.addAttribute("templateCategoryList", templateCategoryList);		
		
		return "top_template/template_list4_category_ajax";
	}
	
	/**
	 * 인보험 자료실 서식목록 가져오기
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/templateList4Ajax", method = RequestMethod.POST)
	public String templateList4Ajax(Model model, HttpServletRequest request, HttpSession session) {
		logger.info("======= templateList4Ajax =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);		
		
		int templateListCnt = sqlSession.selectOne("BoardNoticePtnr1Mapper.insuTemplateListCnt4", paramMap);
		List<InsuTemplateBean> templateList = sqlSession.selectList("BoardNoticePtnr1Mapper.insuTemplateList4", paramMap);
		
		//===============================================
		// 페이지 관련 변수 선언
		//===============================================
		int sizePerPage = 20;       // 한페이지당 보여줄 글 갯수
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
		
		//페이징
		PaginationInfo pageInfo = new PaginationInfo();			
		pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
		pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
		pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
		pageInfo.setTotalRecordCount(templateListCnt);   				// 총 글 갯수		
		model.addAttribute("pageInfo", pageInfo);
		
		model.addAttribute("templateList", templateList);
		model.addAttribute("templateListCnt", templateListCnt);
		
		return "top_template/template_list4_ajax";
	}
	
	/**
	 * 서식목록 가져오기
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/templateListAjax", method = RequestMethod.POST)
	public String templateListAjax(Model model, HttpServletRequest request, HttpSession session) {
		logger.info("======= templateListAjax =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		
		//List<TopPtnrBscVO> ptnrBoardlist = sqlSession.selectList("BoardNoticePtnr1Mapper.ptnrBoardlist");
		
		int templateListCnt = sqlSession.selectOne("BoardNoticePtnr1Mapper.insuTemplateListCnt", paramMap);
		List<InsuTemplateBean> templateList = sqlSession.selectList("BoardNoticePtnr1Mapper.insuTemplateList", paramMap);		
		//List<Map<String, Object>> templateList = sqlSession.selectList("BoardNoticePtnr1Mapper.insuTemplateList", paramMap);
		
		//===============================================
		// 페이지 관련 변수 선언
		//===============================================
		int sizePerPage = 20;       // 한페이지당 보여줄 글 갯수
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
		
		//페이징
		PaginationInfo pageInfo = new PaginationInfo();			
		pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
		pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
		pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
		pageInfo.setTotalRecordCount(templateListCnt);   				// 총 글 갯수		
		model.addAttribute("pageInfo", pageInfo);
		
		model.addAttribute("templateList", templateList);
		model.addAttribute("templateListCnt", templateListCnt);
		
		return "top_template/template_list_ajax";
	}
	
	@RequestMapping(value = "actionTemplate4CategoryModNew")
	@ResponseBody
	public Map<String,Object> actionTemplate4CategoryModNew(Model model, HttpServletRequest request, HttpSession session, MultipartFile templateFile) throws Exception {
		
		logger.info("======= actionTemplate4CategoryModNew =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String,Object> returnMap = new HashMap<>();		
		
		paramMap.put("col_cd", paramMap.get("category_cd").toString());
		paramMap.put("col_val", paramMap.get("category_name").toString());

		sqlSession.insert("BoardNoticePtnr1Mapper.updateInsuTemplate4Category",paramMap);
		
		returnMap.put("result", 1);
		
		return returnMap;			
	}
	
	@RequestMapping(value = "actionTemplate4CategoryNew")
	@ResponseBody
	public Map<String,Object> actionTemplate4CategoryNew(Model model, HttpServletRequest request, HttpSession session, MultipartFile templateFile) throws Exception {
		
		logger.info("======= actionTemplate4CategoryNew =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String,Object> returnMap = new HashMap<>();
		
		//CommonUtils.printMap(paramMap);
		
		//현재 분류코드 중 가장 큰값을 가져온다.
		int max_col_cd = sqlSession.selectOne("BoardNoticePtnr1Mapper.insuTemplateCategoryMaxCnt4");
		paramMap.put("col_cd", max_col_cd+1);
		paramMap.put("col_val", paramMap.get("category_name").toString());
		
		sqlSession.insert("BoardNoticePtnr1Mapper.insertInsuTemplate4Category",paramMap);
		
		returnMap.put("result", 1);
		
		return returnMap;			
	}
	
	/**
	 * 4종자료실 서식등록
	 * @param model
	 * @param request
	 * @param session
	 * @param templateFile
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "actionTemplate4New")
	@ResponseBody
	public Map<String,Object> actionTemplate4New(Model model, HttpServletRequest request, HttpSession session, MultipartFile templateFile) throws Exception {
		
		logger.info("======= actionTemplate4New =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String,Object> returnMap = new HashMap<>();
		
		int nRet = 0;
		
		String team_type = request.getParameter("team_type") != null ? request.getParameter("team_type") : "";		
		String category_type = request.getParameter("category_type") != null ? request.getParameter("category_type") : "";
		String user_no = request.getParameter("user_no") != null ? request.getParameter("user_no") : "";		 
		
		String action = request.getParameter("action") != null ? request.getParameter("action") : "";
		
		//운영
		String fullPath = "/home" + File.separator + "hosting_users" + File.separator + "toplac" + File.separator
				+ "www" + File.separator + "ls_data" + File.separator + "insu_template4";		
		
		//개발
		//String fullPath = "D:\\home" + File.separator + "hosting_users" + File.separator + "toplac" + File.separator + "www" + File.separator + "ls_data" + File.separator + "insu_template4";
		
		paramMap.put("file_path", fullPath);
		
		if( "C".equals(action) ) {		//서식등록
			
			//서식 파일 처리시작
			String orgFileName = "";
			String fileExt = "";
			String encFileName = "";			//서버에 저장될 파일명
			
			if ( templateFile != null ){		//첨부파일이 있는 경우 처리
				orgFileName = templateFile.getOriginalFilename();							//원본 파일명
				fileExt = FilenameUtils.getExtension(orgFileName);						//파일 확장자
				encFileName = UUID.randomUUID().toString().replaceAll("-", "") +"."+fileExt;	//암호화 파일명
				
				paramMap.put("template_org_file", orgFileName);
				paramMap.put("template_enc_file", encFileName);					
				
				try {
					File file = new File(fullPath,encFileName);
					if(!file.exists()){
						file.mkdirs();
					}
					templateFile.transferTo(file);					
					
				} catch (IOException e) {
					nRet = 91;
					e.printStackTrace();						
				}				
			}
			//서식 파일 처리끝
			
			//입력될값
			//System.out.println("log : "+user_no+" : "+team_type+" : "+category_type+ " : "+fullPath+" : "+encFileName+" : "+orgFileName);
			
			//DB 에 추가한다.
			//파라미터 확인
			//CommonUtils.printMap(paramMap);
			nRet = sqlSession.insert("BoardNoticePtnr1Mapper.insertInsuTemplate4", paramMap);
			
		}
		
		if( nRet == 1) {
			returnMap.put("result", 1);
		}else if( nRet == 91 ) {
			returnMap.put("result", 91);
		}
		
		return returnMap;			
	}
	
	/**
	 * 서식등록
	 * @param model
	 * @param request
	 * @param session
	 * @param templateFile
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "actionTemplateNew")
	@ResponseBody
	public Map<String,Object> actionTemplateNew(Model model, HttpServletRequest request, HttpSession session, MultipartFile templateFile) throws Exception {
		
		logger.info("======= actionTemplateNew =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String,Object> returnMap = new HashMap<>();
		
		int nRet = 0;
		
		String team_type = request.getParameter("team_type") != null ? request.getParameter("team_type") : "";
		String ptnr_type = request.getParameter("ptnr_type") != null ? request.getParameter("ptnr_type") : "";
		String category_type = request.getParameter("category_type") != null ? request.getParameter("category_type") : "";
		String user_no = request.getParameter("user_no") != null ? request.getParameter("user_no") : "";
		String nofile_content = request.getParameter("nofile_content") != null ? request.getParameter("nofile_content") : ""; 
		
		String action = request.getParameter("action") != null ? request.getParameter("action") : "";
		
		//운영
		String fullPath = "/home" + File.separator + "hosting_users" + File.separator + "toplac"
				+ File.separator + "www" + File.separator + "ls_data" + File.separator + "insu_template";
		
		
		//개발
		/*String fullPath = "D:\\home" + File.separator + "hosting_users" + File.separator + "toplac"
				+ File.separator + "www" + File.separator + "ls_data" + File.separator + "insu_template";
		*/
		
		
		paramMap.put("file_path", fullPath);
		
		if( "C".equals(action) ) {		//서식등록
			
			//서식 파일 처리시작
			String orgFileName = "";
			String fileExt = "";
			String encFileName = "";			//서버에 저장될 파일명
			
			if ( templateFile != null ){		//첨부파일이 있는 경우 처리
				orgFileName = templateFile.getOriginalFilename();							//원본 파일명
				fileExt = FilenameUtils.getExtension(orgFileName);						//파일 확장자
				encFileName = UUID.randomUUID().toString().replaceAll("-", "") +"."+fileExt;	//암호화 파일명
				
				paramMap.put("template_org_file", orgFileName);
				paramMap.put("template_enc_file", encFileName);					
				
				try {
					File file = new File(fullPath,encFileName);
					if(!file.exists()){
						file.mkdirs();
					}
					templateFile.transferTo(file);					
					
				} catch (IOException e) {
					nRet = 91;
					e.printStackTrace();						
				}				
			}
			//서식 파일 처리끝
			
			//입력될값
			//System.out.println("log : "+user_no+" : "+team_type+" : "+ptnr_type+" : "+category_type+ " : "+fullPath+" : "+encFileName+" : "+orgFileName);
			
			//DB 에 추가한다.
			//파라미터 확인
			//CommonUtils.printMap(paramMap);
			nRet = sqlSession.insert("BoardNoticePtnr1Mapper.insertInsuTemplate", paramMap);
			
		}
		
		if( nRet == 1) {
			returnMap.put("result", 1);
		}else if( nRet == 91 ) {
			returnMap.put("result", 91);
		}
		
		return returnMap;			
	}
	
	/**
	 * 인보험자료실 다운로드
	 * @param request (tkey)
	 * @param response
	 */
	@RequestMapping(value = "insuTemplate4Filedown")
    public void insuTemplate4Filedown(HttpServletRequest request, HttpServletResponse response){
    	
		logger.info("======= insuTemplate4Filedown =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		InsuTemplateBean insuTemplate = sqlSession.selectOne("BoardNoticePtnr1Mapper.getInsuTemplateInfo4", paramMap);

		String origFilename = insuTemplate.getTemplate_org_file();
    	String encFilename = insuTemplate.getTemplate_enc_file();
    	String file_path = insuTemplate.getFile_path();
    	
    	
		try {
			origFilename = java.net.URLEncoder.encode(origFilename,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		response.setHeader("Content-Disposition","attachment;filename="+origFilename);
		
    	String fullPath = file_path+File.separator+encFilename;
		
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
	
	/**
	 * 보험사 서식 다운로드
	 * @param request (tkey)
	 * @param response
	 */
	@RequestMapping(value = "insuTemplateFiledown")
    public void insuTemplateFiledown(HttpServletRequest request, HttpServletResponse response){
    	
		logger.info("======= insuTemplateFiledown =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		InsuTemplateBean insuTemplate = sqlSession.selectOne("BoardNoticePtnr1Mapper.getInsuTemplateInfo", paramMap);

		String origFilename = insuTemplate.getTemplate_org_file();
    	String encFilename = insuTemplate.getTemplate_enc_file();
    	String file_path = insuTemplate.getFile_path();
    	
    	
		try {
			origFilename = java.net.URLEncoder.encode(origFilename,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		response.setHeader("Content-Disposition","attachment;filename="+origFilename);
		
    	String fullPath = file_path+File.separator+encFilename;
		
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
	
	/**
	 * 인보험 자료 분류정보를 삭제한다.
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "actionDelCategoryList4")
	@ResponseBody
	public int actionDelCategoryList4(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= actionDelCategoryList4 =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		int nCnt = 0;
		
		nCnt = sqlSession.delete("BoardNoticePtnr1Mapper.delTemplate4Category", paramMap);
		
		return nCnt;
	}
	
	/**
	 * 인보험 자료 분류내 자료 갯수를 리턴한다.
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "getCategoryList4Cnt")
	@ResponseBody
	public int getCategoryList4Cnt(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= getCategoryList4Cnt =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		int nCnt = 0;
		
		nCnt = sqlSession.selectOne("BoardNoticePtnr1Mapper.getCategoryList4Cnt", paramMap);
		
		return nCnt;
	}
	
	
	/**
	 * 인보험 자료 삭제
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "actionTemplate4Del")
	@ResponseBody
	public int actionTemplate4Del(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= actionTemplate4Del =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		int nCnt = 0;
		
		InsuTemplateBean insuTemplate = sqlSession.selectOne("BoardNoticePtnr1Mapper.getInsuTemplateInfo4", paramMap);
		
		if (insuTemplate != null){			

	    	String encFilename = insuTemplate.getTemplate_enc_file();
	    	String filePath = insuTemplate.getFile_path();
	    	
	    	String fullPath = filePath+File.separator+encFilename;	    		    	
			
			File file = new File(fullPath);
			if(file.exists() == true){
				file.delete();
			}
			
			nCnt = sqlSession.delete("BoardNoticePtnr1Mapper.deleteInsuTemplateInfo4", paramMap);
		}
		
		return nCnt;
	}
	
	@RequestMapping(value = "actionTemplateDel")
	@ResponseBody
	public int actionTemplateDel(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= actionTemplateDel =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		int nCnt = 0;
		
		InsuTemplateBean insuTemplate = sqlSession.selectOne("BoardNoticePtnr1Mapper.getInsuTemplateInfo", paramMap);
		
		if (insuTemplate != null){			

	    	String encFilename = insuTemplate.getTemplate_enc_file();
	    	String filePath = insuTemplate.getFile_path();
	    	
	    	String fullPath = filePath+File.separator+encFilename;	    		    	
			
			File file = new File(fullPath);
			if(file.exists() == true){
				file.delete();
			}
			
			nCnt = sqlSession.delete("BoardNoticePtnr1Mapper.deleteInsuTemplateInfo", paramMap);
		}
		
		return nCnt;
	}
	

	@RequestMapping(value = "/noticePtnr1Board", method = RequestMethod.GET)
	public String noticePtnr1Board(Model model, HttpSession session) {
		logger.info("======= noticePtnr1Board =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_11().equals("0"))){
			logger.info("noticePtnr1Board - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		List<TopPtnrBscVO> ptnrBoardlist = sqlSession.selectList("BoardNoticePtnr1Mapper.ptnrBoardlist");

		model.addAttribute("ptnrBoardlist",ptnrBoardlist);

		return "brd_notice_ptnr1/board_ptnr_notice";
	}//noticePtnr1Board

	@RequestMapping(value = "/noticePtnr1BoardList", method = RequestMethod.GET)
	public String noticePtnr1BoardList(Model model, HttpSession session
			, String boardWriteSuccess, String boardUpdateSuccess, BoardSearchVO searchVO) {
		logger.info("======= noticePtnr1BoardList =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_11().equals("0"))){
			logger.info("noticePtnr1BoardList - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		BoardPageUtil pageUtil = new BoardPageUtil();
		List<BoardVO> boardList
		= (List<BoardVO>) pageUtil.boardPageSearch1(1, sqlSession, "BoardNoticePtnr1Mapper.boardList", searchVO, model, "noticePtnr1BoardList");

		model.addAttribute("boardList", boardList);
		model.addAttribute("boardWriteSuccess", boardWriteSuccess);
		model.addAttribute("boardUpdateSuccess", boardUpdateSuccess);
		model.addAttribute("searchVO", searchVO);

		String insu = searchVO.getInsu();
		String insuNm = sqlSession.selectOne("BoardNoticePtnr1Mapper.getInsuNm", insu);
		model.addAttribute("insuNm", insuNm);

		return "brd_notice_ptnr1/board_list";
	}//noticePtnr1BoardList

	@RequestMapping(value = "/noticePtnr1BoardWriteForm", method = RequestMethod.GET)
	public String noticePtnr1BoardWriteForm(Model model, HttpSession session, String insu) {
		logger.info("======= noticePtnr1BoardWriteForm =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_11().equals("0"))){
			logger.info("noticePtnr1BoardWriteForm - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		String insuNm = sqlSession.selectOne("BoardNoticePtnr1Mapper.getInsuNm", insu);
		model.addAttribute("insu", insu);
		model.addAttribute("insuNm", insuNm);

		return "brd_notice_ptnr1/board_write_form";
	}//noticePtnr1BoardWriteForm

	@RequestMapping(value = "/noticePtnr1BoardWrite", method = RequestMethod.POST)
	public String noticePtnr1BoardWrite(Model model, HttpSession session, HttpServletRequest request, MultipartRequest multipartRequest, BoardVO inVO) {
		logger.info("======= noticePtnr1BoardWrite =======");

		/*******게시글 부분 시작*******/
		int result = 0;
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		inVO.setUser_no(mbrAuthVo.getUser_no());
		inVO.setReg_ip(request.getRemoteAddr());
		result = sqlSession.insert("BoardNoticePtnr1Mapper.boardWrite", inVO);
		/*******게시글 부분 종료*******/
		/*******첨부 파일 부분 시작*******/
		BoardFileUtil bfcu = new BoardFileUtil();
		String boardNo = "", path = "/home/hosting_users/toplac/www/wp_board/upload/noticePtnr1/";
		int file_flag = 0;
		if(result > 0){
			boardNo = sqlSession.selectOne("BoardNoticePtnr1Mapper.getBoardNo", inVO);
			path = path+boardNo+"/";
			file_flag = bfcu.fileUploadProcessor(multipartRequest, boardNo, path, sqlSession, "BoardNoticePtnr1Mapper.boardFileWrite");
		}//if(result > 0)
		/*******첨부 파일 부분 종료*******/
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 시작*******/
		String ckStrPath = null;
		ckStrPath = bfcu.mvCKFileDirTmpToReal(inVO.getContents(), "noticePtnr1", boardNo);

		if(ckStrPath != null){
			bfcu.deleteDir(ckStrPath);//임시 폴더 내부 자료 및 임시 폴더 삭제

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", boardNo);
			map.put("oldStr", ckStrPath);//임시 폴더 경로
			map.put("newStr", "/home/hosting_users/toplac/www/wp_board/data/noticePtnr1/"+boardNo+"/");//정식 폴더 경로
			sqlSession.update("BoardNoticePtnr1Mapper.updateCKPath", map);//게시글 내부의 임시 폴더 경로를 정식 폴더 경로로 바꾸기
		}
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 종료*******/

		if(result < 1 || (file_flag < 1)){//게시글 입력 실패 또는 첨부파일 저장 실패
			model.addAttribute("boardWriteFailVO", inVO);
			return "brd_notice_ptnr1/board_write_form";
		}
		//(게시글 입력 완료 && 첨부파일이 없음) 또는 (게시글 입력 완료 && 첨부파일 저장 성공)
		return "redirect:/noticePtnr1BoardList?insu="+inVO.getPtnr_id()+"&boardWriteSuccess=1";
	}//noticePtnr1BoardWrite

	@RequestMapping(value = "/noticePtnr1BoardDetail", method = RequestMethod.GET)
	public String noticePtnr1BoardDetail(Model model, HttpSession session, String boardNo, String reqPgNo, BoardSearchVO searchVO) {
		logger.info("======= noticePtnr1BoardDetail =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_11().equals("0"))){
			logger.info("noticePtnr1BoardDetail - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		if(!boardNo.equals(session.getAttribute("brd_no_Session"))){
			sqlSession.update("BoardNoticePtnr1Mapper.boardAddCnt", boardNo);
		}
		session.setAttribute("brd_no_Session", boardNo);

		BoardVO boardDetail = sqlSession.selectOne("BoardNoticePtnr1Mapper.boardDetail", boardNo);
		model.addAttribute("boardDetail", boardDetail);

		List<BoardFileVO> boardFileList = sqlSession.selectList("BoardNoticePtnr1Mapper.boardFileList", boardNo);
		model.addAttribute("boardFileList", boardFileList);

		model.addAttribute("reqPgNo", reqPgNo);
		model.addAttribute("searchVO", searchVO);

		return "brd_notice_ptnr1/board_detail";
	}//noticePtnr1BoardDetail

	@RequestMapping(value = "noticePtnr1BoardDelete", method = RequestMethod.POST)
	public void noticePtnr1BoardDelete(HttpServletResponse response, String boardNo) {
		logger.info("======= noticePtnr1BoardDelete =======");

		int result = 0;
		result = sqlSession.delete("BoardNoticePtnr1Mapper.boardDelete", boardNo);

		int file_flag = 0;
		int file_result = 0;
		if(result > 0){
			BoardFileUtil bfcu = new BoardFileUtil();
			bfcu.deleteDir("/home/hosting_users/toplac/www/wp_board/data/noticePtnr1/"+boardNo+"/");

			file_flag = bfcu.deleteDirReturnFlag("/home/hosting_users/toplac/www/wp_board/upload/noticePtnr1/"+boardNo+"/");

			file_result = sqlSession.delete("BoardNoticePtnr1Mapper.boardFilesDelete", boardNo);

			BoardMemoViewVO memoViewVO = new BoardMemoViewVO();
			memoViewVO.setLinkNo(boardNo);
			memoViewVO.setTargetStr("noticePtnr1");
			sqlSession.delete("BoardMemoMapper.boardMemoDeleteByFK", memoViewVO);
		}

		int outMsg = 1;
		if(result < 1 || (file_flag > 0 && file_result < 1)){//게시글 입력 실패 또는 첨부파일 삭제 실패
			outMsg = 0;
		}
		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		if(outMsg > 0){
			out.print(outMsg);
		}
		out.close();

	}//noticePtnr1BoardDelete

	@RequestMapping(value = "/noticePtnr1BoardUpdateForm", method = RequestMethod.GET)
	public String noticePtnr1BoardUpdateForm(Model model, HttpSession session, String boardNo, String reqPgNo, BoardSearchVO searchVO) {
		logger.info("======= noticePtnr1BoardUpdateForm =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_11().equals("0"))){
			logger.info("noticePtnr1BoardUpdateForm - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		BoardVO boardDetail = sqlSession.selectOne("BoardNoticePtnr1Mapper.boardDetail", boardNo);
		model.addAttribute("boardDetail", boardDetail);

		List<BoardFileVO> boardFileList = sqlSession.selectList("BoardNoticePtnr1Mapper.boardFileList", boardNo);
		model.addAttribute("boardFileList", boardFileList);

		model.addAttribute("reqPgNo", reqPgNo);
		model.addAttribute("searchVO", searchVO);

		return "brd_notice_ptnr1/board_update_form";
	}//noticePtnr1BoardUpdateForm

	@RequestMapping(value = "noticePtnr1BoardFileDelete", method = RequestMethod.POST)
	public void noticePtnr1BoardFileDelete(HttpServletResponse response, String fileNo, String filePath, String fileName) {
		logger.info("======= noticePtnr1BoardFileDelete =======");

		BoardFileVO tmpBoardFreeFileVO = sqlSession.selectOne("BoardNoticePtnr1Mapper.noticePtnr1FileOneSelect", fileNo);
		filePath = "/home/hosting_users/toplac/www"+tmpBoardFreeFileVO.getFile_path();
		fileName = tmpBoardFreeFileVO.getFile_name();

		File DeleteTarget = new File(filePath+fileName);
		DeleteTarget.delete();

		File DeleteTargetPath = new File(filePath);
		File tmpFileArr [] = DeleteTargetPath.listFiles();
		if(tmpFileArr == null || tmpFileArr.length < 1){
			DeleteTargetPath.delete();
		}
		DeleteTarget.delete();

		int file_result = 0;
		file_result = sqlSession.delete("BoardNoticePtnr1Mapper.boardFileDelete", fileNo);

		int outMsg = 1;
		if(file_result < 1){//첨부파일 삭제 실패
			outMsg = 0;
		}

		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		if(outMsg > 0){
			out.print(outMsg);
		}
		out.close();

	}//noticePtnr1BoardFileDelete

	@RequestMapping(value = "/noticePtnr1BoardUpdate", method = RequestMethod.POST)
	public String noticePtnr1BoardUpdate(Model model, HttpSession session, HttpServletRequest request, MultipartRequest multipartRequest
			, BoardVO inVO, BoardSearchVO searchVO) {
		logger.info("======= noticePtnr1BoardUpdate =======");

		/*******게시글 부분 시작*******/
		int result = 0;
		result = sqlSession.update("BoardNoticePtnr1Mapper.boardUpdate", inVO);
		/*******게시글 부분 종료*******/
		/*******첨부 파일 부분 시작*******/
		BoardFileUtil bfcu = new BoardFileUtil();
		String boardNo = "", path = "/home/hosting_users/toplac/www/wp_board/upload/noticePtnr1/";
		int file_flag = 0;
		if(result > 0){
			boardNo = inVO.getBoard_no();
			path = path+boardNo+"/";
			file_flag = bfcu.fileUploadProcessor(multipartRequest, boardNo, path, sqlSession, "BoardNoticePtnr1Mapper.boardFileWrite");
		}//if(result > 0)
		/*******첨부 파일 부분 종료*******/
		/*******게시글에서 수정 전 CKEDITOR 이미지 URL 분리 부분 시작*******/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		String userNo = mbrAuthVo.getUser_no();

		String beforeUpdateCKPath = null;
		beforeUpdateCKPath = bfcu.mvCKFileDirRealToTmp(inVO.getContents(), userNo);

		if(beforeUpdateCKPath != null){
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", boardNo);
			map.put("oldStr", beforeUpdateCKPath);//정식 폴더 경로
			map.put("newStr", "/home/hosting_users/toplac/www/wp_board/data/ckeditor_tmp/"+userNo+"/");//임시 폴더 경로
			sqlSession.update("BoardNoticePtnr1Mapper.updateCKPath", map);//게시글 내부의 정식 폴더 경로를 임시 폴더 경로로 바꾸기

			inVO.setContents(inVO.getContents().replaceAll(beforeUpdateCKPath, "/home/hosting_users/toplac/www/wp_board/data/ckeditor_tmp/"+userNo+"/"));
		}
		bfcu.deleteDir("/home/hosting_users/toplac/www/wp_board/data/noticePtnr1/"+boardNo+"/");//정식 폴더 내부 자료 및 정식 폴더 삭제
		/*******게시글에서 수정 전 CKEDITOR 이미지 URL 분리 부분 종료*******/
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 시작*******/
		String ckStrPath = null;
		ckStrPath = bfcu.mvCKFileDirTmpToReal(inVO.getContents(), "noticePtnr1", boardNo);

		if(ckStrPath != null){
			bfcu.deleteDir(ckStrPath);//임시 폴더 내부 자료 및 임시 폴더 삭제

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", boardNo);
			map.put("oldStr", ckStrPath);//임시 폴더 경로
			map.put("newStr", "/home/hosting_users/toplac/www/wp_board/data/noticePtnr1/"+boardNo+"/");//정식 폴더 경로
			sqlSession.update("BoardNoticePtnr1Mapper.updateCKPath", map);//게시글 내부의 임시 폴더 경로를 정식 폴더 경로로 바꾸기
		}
		/*******게시글에서 CKEDITOR 이미지 URL 분리 부분 종료*******/

		if(result < 1 || (file_flag < 1)){//게시글 입력 실패 또는 첨부파일 저장 실패
			List<BoardFileVO> boardFileList = sqlSession.selectList("BoardNoticePtnr1Mapper.boardFileList", boardNo);
			model.addAttribute("boardFileList", boardFileList);
			model.addAttribute("boardUpdateFailFlag", 1);
			model.addAttribute("boardDetail", inVO);
			return "brd_notice_ptnr1/board_update_form";
		}
		//(게시글 입력 완료 && 첨부파일이 없음) 또는 (게시글 입력 완료 && 첨부파일 저장 성공)
		return "redirect:/noticePtnr1BoardList?updateSuccess=1"
		+"&insu="+inVO.getPtnr_id()
		+"&boardSrcType="+searchVO.getBoardSrcType()
		+"&boardSrcWord="+searchVO.getBoardSrcWord()
		+"&reqPgNo="+searchVO.getReqPgNo();
	}//noticePtnrBoardUpdate

	@RequestMapping(value = "/noticePtnr1BoardPrint", method = RequestMethod.GET)
	public String noticePtnr1BoardPrint(Model model, HttpSession session, String boardNo) {
		logger.info("======= noticePtnr1BoardPrint =======");

		/*세션 유효 검사 시작*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_11().equals("0"))){
			logger.info("noticePtnr1BoardPrint - no permession user_no : "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		BoardVO boardDetail = sqlSession.selectOne("BoardNoticePtnr1Mapper.boardDetail", boardNo);
		model.addAttribute("boardDetail", boardDetail);

		return "brd_common/board_print_pop";
	}//noticePtnr1BoardPrint

	@RequestMapping(value = "noticePtnr1ReWrite", method = RequestMethod.POST)
	public void noticePtnr1ReWrite(HttpServletResponse response, String boardNo) {
		logger.info("======= noticePtnr1ReWrite =======");

		BoardVO boardDetail = sqlSession.selectOne("BoardNoticePtnr1Mapper.boardDetail", boardNo);

		int result = 0;
		result = sqlSession.insert("BoardNoticePtnr1Mapper.boardWrite2", boardDetail);

		if(result > 0){
			String newBoardNo = sqlSession.selectOne("BoardNoticePtnr1Mapper.getBoardNo", boardDetail);

			File attachFileDir = new File("/home/hosting_users/toplac/www/wp_board/upload/noticePtnr1/"+boardNo+"/");
			if(attachFileDir.exists()){
				File attachFileDir2 = new File("/home/hosting_users/toplac/www/wp_board/upload/noticePtnr1/"+newBoardNo+"/");
				attachFileDir.renameTo(attachFileDir2);
			}
			File ckFileDir = new File("/home/hosting_users/toplac/www/wp_board/data/noticePtnr1/"+boardNo+"/");
			if(ckFileDir.exists()){
				File ckFileDir2 = new File("/home/hosting_users/toplac/www/wp_board/data/noticePtnr1/"+newBoardNo+"/");
				ckFileDir.renameTo(ckFileDir2);
			}

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", boardNo);
			map.put("newBoardNo", newBoardNo);
			map.put("attachFileDir", "/"+boardNo+"/");
			map.put("attachFileDir2", "/"+newBoardNo+"/");
			map.put("ckFileDir", "/home/hosting_users/toplac/www/wp_board/data/noticePtnr1/"+boardNo+"/");
			map.put("ckFileDir2", "/home/hosting_users/toplac/www/wp_board/data/noticePtnr1/"+newBoardNo+"/");

			sqlSession.update("BoardNoticePtnr1Mapper.updateCKPath2", map);
			sqlSession.update("BoardNoticePtnr1Mapper.updateBoardFiles", map);
			sqlSession.update("BoardNoticePtnr1Mapper.updateBoardMemos", map);
			sqlSession.delete("BoardNoticePtnr1Mapper.boardDelete", boardNo);
		}

		int outMsg = 1;
		if(result < 1){//실패
			outMsg = 0;
		}
		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		if(outMsg > 0){
			out.print(outMsg);
		}
		out.close();

	}//noticePtnr1ReWrite
	
	
	@RequestMapping(value = "/suimIssueMobilePopAjax", method = RequestMethod.POST)
	public String suimIssueMobilePopAjax(Model model, HttpSession session, HttpServletRequest request ) {
		logger.info("======= suimIssueMobilePopAjax =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);

		model.addAttribute("sendMap", sendMap);
		
		return "/top_suim/ajax/suim_issue_mobile_pop_modal";
	}
	
	@RequestMapping(value = "/suimIssueEmailPopAjax", method = RequestMethod.POST)
	public String suimIssueEmailPopAjax(Model model, HttpSession session, HttpServletRequest request ) {
		logger.info("======= suimIssueEmailPopAjax =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		Map<String,Object> sendMap = sqlSession.selectOne("RptIssueMapper.selectRptIssueSendForMsg",paramMap);

		model.addAttribute("sendMap", sendMap);

		return "/top_suim/ajax/suim_issue_email_pop_modal";
	}
	
	@RequestMapping(value = "/suimPtnrNoticePopAjax", method = RequestMethod.POST)
	public String suimPtnrNoticePopAjax(Model model, HttpSession session, HttpServletRequest request
			, String type, String id) {
		logger.info("======= suimPtnrNoticePopAjax =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || mbrVo.getUser_no() == ""){
			logger.info("suimPtnrNoticePop - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		BoardVO boardDetail = null;
		if(type.equals("3") || type.equals("4")){
			boardDetail = sqlSession.selectOne("BoardNoticePtnr4Mapper.suim4PtnrNoticePop", id);
		}else{
			boardDetail = sqlSession.selectOne("BoardNoticePtnr1Mapper.suim1PtnrNoticePop", id);
		}

		model.addAttribute("boardDetail", boardDetail);
		return "brd_notice_ptnr1/suim_ptnr_notice_pop_modal";
	}

	@RequestMapping(value = "/suimPtnrNoticePop", method = RequestMethod.GET)
	public String suimPtnrNoticePop(Model model, HttpSession session, HttpServletRequest request
			, String type, String id) {
		logger.info("======= suimPtnrNoticePop =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || mbrVo.getUser_no() == ""){
			logger.info("suimPtnrNoticePop - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		BoardVO boardDetail = null;
		if(type.equals("3") || type.equals("4")){
			boardDetail = sqlSession.selectOne("BoardNoticePtnr4Mapper.suim4PtnrNoticePop", id);
		}else{
			boardDetail = sqlSession.selectOne("BoardNoticePtnr1Mapper.suim1PtnrNoticePop", id);
		}

		model.addAttribute("boardDetail", boardDetail);
		return "brd_notice_ptnr1/suim_ptnr_notice_pop";
	}//suimPtnrNoticePop

}//end of class
