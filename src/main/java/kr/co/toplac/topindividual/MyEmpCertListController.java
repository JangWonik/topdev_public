package kr.co.toplac.topindividual;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
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

import kr.co.toplac.brd.common.BoardFileVO;
import kr.co.toplac.topteam.NilinkRecordVO;
import kr.co.toplac.topteam.TopCertVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.PaginationInfo;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;
import kr.co.toplac.util.page.PageUtilityBasic;
import kr.co.toplac.util.rpt.MainLeftUtil;

@Controller
public class MyEmpCertListController {
	
private static final Logger logger = LoggerFactory.getLogger(MyEmpCertListController.class);
	
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	MainLeftUtil mlu;
	
	/**
	 * 통화내역 다운로드
	 * @param response
	 * @param fileNo
	 * @throws IOException
	 */
	
	@RequestMapping(value = "/nilinkRecordDownload", method = RequestMethod.POST)
	 public void nilinkRecordDownload(HttpServletResponse response, HttpSession session, String downKey)
			 throws IOException{
		logger.info("======= nilinkRecordDownload =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		
		String sAuth = mbrAuthVo.getMbr_pms_35();
		
		//권한 및 로그인 여부 체크
		if(mbrAuthVo == null || session.getAttribute("user_no_Session") ==null || "0".equals(sAuth)){
			logger.info("nilinkRecordDownload - no session OR no Auth");
			session.invalidate();			
		}else{
			String sFilePath = sqlSession.selectOne("MyEmpCertList.selectNilinkFilePath", downKey);
			
			String sFileName = sqlSession.selectOne("MyEmpCertList.selectNilinkFileName", downKey);

			response.setHeader("Content-Disposition","attachment;filename="+sFileName);

			ServletOutputStream sout = response.getOutputStream();
			FileInputStream fin = new FileInputStream(sFilePath);

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
	
	/**
	 * 로그인 기록 엑셀다운로드
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "loginLogListExcel")
	public String loginLogListExcel(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= loginLogListExcel =======");				
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String srchSdate = request.getParameter("srchSdate") != null ? request.getParameter("srchSdate") : DateUtil.getTodayString("yyyy-MM-dd");		
		String srchEdate = request.getParameter("srchEdate") != null ? request.getParameter("srchEdate") : DateUtil.getTodayString("yyyy-MM-dd");
		
		//검색전 파라미터 셋팅
		paramMap.put("srchSdate", srchSdate);
		
		srchEdate = DateUtil.addDateNew(srchEdate, 1);
		paramMap.put("srchEdate", srchEdate);
		
		List<Map<String, Object>> loginLogList = sqlSession.selectList("MyEmpCertList.selectLoginLogListExcel", paramMap);		
				
		model.addAttribute("loginLogList",loginLogList);
		
		//검색종료날짜는 하루 빼고 넘겨준다.
		srchEdate = DateUtil.addDateNew(srchEdate, -1);
		paramMap.put("srchEdate", srchEdate);
		model.addAttribute("srchParam",paramMap);		

		return "top_individual/login_log_list_excel";
	}
	
	/**
	 * 검색 및 통계 조회 로그 (특정사용자에게만 오픈)
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "searchLogList")
	public String searchLogList(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= searchLogList =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");		
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		/* 팀목록 추출*/
		List<Map<String,Object>> searchPageList = sqlSession.selectList("SaveLogMapper.selectTopSearchLogTypeBySearchPage");
		model.addAttribute("searchPageList", searchPageList);
		
		String srchSdate = request.getParameter("srchSdate") != null ? request.getParameter("srchSdate") : DateUtil.getTodayString("yyyy-MM-dd");		
		String srchEdate = request.getParameter("srchEdate") != null ? request.getParameter("srchEdate") : DateUtil.getTodayString("yyyy-MM-dd");
		
		//===============================================
		// 페이지 관련 변수 선언
		//===============================================
		int sizePerPage = 13;       // 한페이지당 보여줄 글 갯수
		int sizePerBlock = 10;      // 페이지당 보여줄 블럭 갯수
		int currentPage = 0;        // 현재 페이지
		int limitPage = 0;          // sql limit

		//===============================================
		// 현재 페이지 세팅
		//===============================================
		String pageIdx = StringUtil.null2blank((String)paramMap.get("pageIdxSearch"));				
		
		if("".equals(pageIdx)){
		    currentPage = 0;
		    limitPage = 0;
		}else{
		    currentPage = (Integer.parseInt(pageIdx) - 1);
		    limitPage = ((Integer.parseInt(pageIdx) - 1) * sizePerPage);
		}
		paramMap.put("sizePerPage", sizePerPage);
		paramMap.put("limitPage", limitPage);
		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());
		
		//검색전 파라미터 셋팅
		paramMap.put("srchSdate", srchSdate);
		
		srchEdate = DateUtil.addDateNew(srchEdate, 1);
		paramMap.put("srchEdate", srchEdate);		
		
		List<Map<String, Object>> searchLogList = sqlSession.selectList("SaveLogMapper.selectTopSearchLogList", paramMap);		

		int totalCnt = sqlSession.selectOne("SaveLogMapper.selectTopSearchLogListCnt", paramMap);
		
		PaginationInfo pageInfo = new PaginationInfo();			
		pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
		pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
		pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
		pageInfo.setTotalRecordCount(totalCnt);   				// 총 글 갯수
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageInfo", pageInfo);		
		model.addAttribute("searchLogList",searchLogList);
		
		//검색종료날짜는 하루 빼고 넘겨준다.
		srchEdate = DateUtil.addDateNew(srchEdate, -1);
		paramMap.put("srchEdate", srchEdate);
		model.addAttribute("srchParam",paramMap);		

		return "top_individual/search_log_list";
	}
	
	/**
	 * 로그인 기록 조회 (특정사용자에게만 오픈)
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "loginLogList")
	public String loginLogList(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= loginLogList =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		//TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		
		//String sAuth = mbrAuthVo.getMbr_pms_35();
		
		//권한 및 로그인 여부 체크
		/*
		if(mbrAuthVo == null || session.getAttribute("user_no_Session") ==null || "0".equals(sAuth)){
			logger.info("nilinkRecordList - no session OR no Auth");
			session.invalidate();
			return "top_login/top_login";
		}
		*/
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String srchSdate = request.getParameter("srchSdate") != null ? request.getParameter("srchSdate") : DateUtil.getTodayString("yyyy-MM-dd");		
		String srchEdate = request.getParameter("srchEdate") != null ? request.getParameter("srchEdate") : DateUtil.getTodayString("yyyy-MM-dd");
		
		//===============================================
		// 페이지 관련 변수 선언
		//===============================================
		int sizePerPage = 13;       // 한페이지당 보여줄 글 갯수
		int sizePerBlock = 10;      // 페이지당 보여줄 블럭 갯수
		int currentPage = 0;        // 현재 페이지
		int limitPage = 0;          // sql limit

		//===============================================
		// 현재 페이지 세팅
		//===============================================
		String pageIdx = StringUtil.null2blank((String)paramMap.get("pageIdxLogin"));				
		
		if("".equals(pageIdx)){
		    currentPage = 0;
		    limitPage = 0;
		}else{
		    currentPage = (Integer.parseInt(pageIdx) - 1);
		    limitPage = ((Integer.parseInt(pageIdx) - 1) * sizePerPage);
		}
		paramMap.put("sizePerPage", sizePerPage);
		paramMap.put("limitPage", limitPage);
		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());
		
		/* 팀목록 추출*/
		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
		model.addAttribute("teamList", teamList);
		
		//검색전 파라미터 셋팅
		paramMap.put("srchSdate", srchSdate);
		
		srchEdate = DateUtil.addDateNew(srchEdate, 1);
		paramMap.put("srchEdate", srchEdate);
		
		List<Map<String, Object>> loginLogList = sqlSession.selectList("MyEmpCertList.selectLoginLogList", paramMap);		

		int totalCnt = sqlSession.selectOne("MyEmpCertList.selectLoginLogListCnt", paramMap);
		
		PaginationInfo pageInfo = new PaginationInfo();			
		pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
		pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
		pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
		pageInfo.setTotalRecordCount(totalCnt);   				// 총 글 갯수
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageInfo", pageInfo);		
		model.addAttribute("loginLogList",loginLogList);
		
		//검색종료날짜는 하루 빼고 넘겨준다.
		srchEdate = DateUtil.addDateNew(srchEdate, -1);
		paramMap.put("srchEdate", srchEdate);
		model.addAttribute("srchParam",paramMap);		

		return "top_individual/login_log_list";
	}	
	
	/**
	 * Nilink 통화목록 확인
	 * post, get 둘다허용
	 * @param model
	 * @param reqPgNo
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "nilinkRecordList")
	public String nilinkRecordList(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= nilinkRecordList =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		
		String sAuth = mbrAuthVo.getMbr_pms_35();
		
		//권한 및 로그인 여부 체크
		if(mbrAuthVo == null || session.getAttribute("user_no_Session") ==null || "0".equals(sAuth)){
			logger.info("nilinkRecordList - no session OR no Auth");
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//===============================================
		// 페이지 관련 변수 선언
		//===============================================
		int sizePerPage = 13;       // 한페이지당 보여줄 글 갯수
		int sizePerBlock = 10;      // 페이지당 보여줄 블럭 갯수
		int currentPage = 0;        // 현재 페이지
		int limitPage = 0;          // sql limit

		//===============================================
		// 현재 페이지 세팅
		//===============================================
		String pageIdx = StringUtil.null2blank((String)paramMap.get("pageIdxNilink"));				
		
		if("".equals(pageIdx)){
		    currentPage = 0;
		    limitPage = 0;
		}else{
		    currentPage = (Integer.parseInt(pageIdx) - 1);
		    limitPage = ((Integer.parseInt(pageIdx) - 1) * sizePerPage);
		}
		paramMap.put("sizePerPage", sizePerPage);
		paramMap.put("limitPage", limitPage);
		
		String user_no = "";
		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		user_no = (String) session.getAttribute("user_no_Session");
		
		String tail_office = "";
		
		//일반 사용자인 경우
		if("1".equals(sAuth)){			
			tail_office = sqlSession.selectOne("MyEmpCertList.myOfficeNoTail", user_no);
			paramMap.put("tail_office", tail_office);
		}
		
		List<NilinkRecordVO> nilinkRecordVo = sqlSession.selectList("MyEmpCertList.selectNilinkRecordList", paramMap);
		
		int totalCnt = sqlSession.selectOne("MyEmpCertList.selectNilinkRecordListCnt", paramMap);
		
		PaginationInfo pageInfo = new PaginationInfo();			
		pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
		pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
		pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
		pageInfo.setTotalRecordCount(totalCnt);   				// 총 글 갯수
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageInfo", pageInfo);		
		model.addAttribute("nilinkList",nilinkRecordVo);
		model.addAttribute("paramMap",paramMap);
				
		return "top_individual/nilink_record_list";
	}
	
	
	/*
	 * ***************************************
	 * Method ID : myCertList
	 * Method Name :  myCertList
	 * Description : 본인 재직 증명서 목록 추출 
	 * 
	 * Author : 이선형
	 * Date : 20160418
	 * ***************************************
	 * */
	@RequestMapping(value = "myCertList", method = RequestMethod.GET)
	public String myCertList(Model model, String reqPgNo, HttpSession session) {
		
		String user_no = "";
		
		logger.info("======= myCertList =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || session.getAttribute("user_no_Session") ==null){
			logger.info("myCertList - no session ");
			session.invalidate();
			return "top_login/top_login";
		}

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		user_no = (String) session.getAttribute("user_no_Session");
		
		/*List<TopCertVO> myCertList = sqlSession.selectList("MyEmpCertList.myCertList", user_no);*/

		PageUtilityBasic pageUtil = new PageUtilityBasic();
		
		@SuppressWarnings("unchecked")
		List<TopCertVO> myCertList = (List<TopCertVO>) pageUtil.pageBasicPop1(1, sqlSession, "MyEmpCertList.myCertList", reqPgNo, model, "myCertList",user_no);
		
		for (int i = 0; i < myCertList.size(); i++) {
			if(myCertList.get(i).getIssue_state().equals("0")){
				myCertList.get(i).setIssue_state("신청");
			}else if(myCertList.get(i).getIssue_state().equals("1")){
				myCertList.get(i).setIssue_state("취소");
			}else if(myCertList.get(i).getIssue_state().equals("2")){
				myCertList.get(i).setIssue_state("승인");
			}else if(myCertList.get(i).getIssue_state().equals("3")){
				myCertList.get(i).setIssue_state("반려");
			}  
		}
		
		model.addAttribute("fromMyCertList", "fromMyCertList");
		model.addAttribute("user_no", user_no);
		model.addAttribute("myCertList",myCertList);
		
		return "top_individual/my_emp_cert_list";
	}
	
	/*
	 * ***************************************
	 * Method ID : myCertPrint
	 * Method Name :  myCertPrint
	 * Description : 선택 재직 증명서 출력 
	 * 
	 * Author : 이선형
	 * Date : 20160418
	 * ***************************************
	 * */
	@RequestMapping(value = "myCertPrint", method = RequestMethod.GET)
	public String myCertPrint(Model model, String serial_no) {
		
		TopCertVO certPrintVo = sqlSession.selectOne("MyEmpCertList.myCertPrint", serial_no);
		
		String id = "";
		String year = "";
		if( (certPrintVo.getJumin_no1() != null) && (certPrintVo.getJumin_no2() != null) ){
//			id = certPrintVo.getJumin_no1()+"-"+certPrintVo.getJumin_no2();
//			certPrintVo.setJumin_no1(id);
			
			//주민등록번호에서 생년월일로 변경 180725
			if ("1".equals(certPrintVo.getJumin_no2().substring(0,1)) || "2".equals(certPrintVo.getJumin_no2().substring(0,1))){
				year = "19";
			}else{
				year = "20";
			}
			
			String birthDay = year+certPrintVo.getJumin_no1().substring(0, 2)+"년 "+certPrintVo.getJumin_no1().substring(2, 4)+"월 "+certPrintVo.getJumin_no1().substring(4)+"일";
			certPrintVo.setBirthDay(birthDay);
		}
		
		model.addAttribute("certPrintVo", certPrintVo);
		
		return "top_individual/my_emp_cert_print";
	}
	
	
	
}
