package kr.co.toplac.topgeneral;

import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.toplac.brd.noticeptnr.InsuTemplateBean;
import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.topptnr.TopPtnrBscVO;
import kr.co.toplac.topptnr.TopPtnrDeptBscVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.PaginationInfo;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;
import kr.co.toplac.util.etc.Damo;
import kr.co.toplac.util.file.GetImageBase64;
import kr.co.toplac.util.rpt.MainLeftUtil;

@Controller
public class TopPtnrListController {
	
	private static final Logger logger = LoggerFactory.getLogger(TopPtnrListController.class);
	
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	MainLeftUtil mlu;
	
	
	@RequestMapping(value = "topPtnrCompanyListAjax")
	public String topPtnrCompanyListAjax(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= topPtnrCompanyListAjax =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
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
		String pageIdxCompanySearch = StringUtil.null2blank((String)paramMap.get("pageIdxCompanySearch"));
		
		if("".equals(pageIdxCompanySearch)){
		    currentPage = 0;
		    limitPage = 0;
		}else{
		    currentPage = (Integer.parseInt(pageIdxCompanySearch) - 1);
		    limitPage = ((Integer.parseInt(pageIdxCompanySearch) - 1) * sizePerPage);
		}
		paramMap.put("sizePerPage", sizePerPage);
		paramMap.put("limitPage", limitPage);	
		
		//보험사 직원목록
		List<TopPtnrBscVO> searchCompanyList = sqlSession.selectList("TopPtnrListMapper.getPtnrListSearch", paramMap);
		
		model.addAttribute("searchCompanyList", searchCompanyList);		
		
		int searchCompanyCnt = sqlSession.selectOne("TopPtnrListMapper.getPtnrListSearchCnt", paramMap);		
		
		PaginationInfo pageInfo = new PaginationInfo();			
		pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
		pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
		pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
		pageInfo.setTotalRecordCount(searchCompanyCnt);   				// 총 글 갯수
		model.addAttribute("pageInfo", pageInfo);
		
		return "top_general/top_ptnr_company_list_ajax";
	}
	
	/*
	 * 담당직원 정보 등록, 갱신, 삭제
	 */
	@RequestMapping(value = "/actionMemberSave", method = RequestMethod.POST)
	@ResponseBody
	public int actionMemberSave(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= actionMemberSave =======");
		
		int nRet = 0;
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();		
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String manager_no = mbrVo.getUser_no();			//작업자 사번
		paramMap.put("manager_no", manager_no);		
		
		String sAction = String.valueOf(paramMap.get("action_flag"));			//추가(I), 수정, 삭제
		
		
		if( "D".equals(sAction) ) {			//삭제인 경우는 암호화처리 하지 않는다.			
			nRet = sqlSession.update("PopPtnrMbrMapper.updatePtnrMbrInfoDel", paramMap);			
		}else{
			Damo damo = new Damo();
			String sPtnrMbrHp = String.valueOf(paramMap.get("ptnr_mbr_hp"));
			String sPtnrMbrOfficeTel = String.valueOf(paramMap.get("ptnr_mbr_office_tel"));
			String sPtnrMbrOfficeFax = String.valueOf(paramMap.get("ptnr_mbr_office_fax"));
			String sPtnrMbrOfficeEmail = String.valueOf(paramMap.get("ptnr_mbr_office_email"));
			
			if (sPtnrMbrHp != null || sPtnrMbrHp != ""){
				paramMap.put( "ptnr_mbr_hp", damo.encodeDamo(sPtnrMbrHp) );
			}	
			if (sPtnrMbrOfficeTel != null || sPtnrMbrOfficeTel != ""){
				paramMap.put( "ptnr_mbr_office_tel", damo.encodeDamo(sPtnrMbrOfficeTel) );
			}	
			if (sPtnrMbrOfficeFax != null || sPtnrMbrOfficeFax != ""){
				paramMap.put( "ptnr_mbr_office_fax", damo.encodeDamo(sPtnrMbrOfficeFax) );
			}	
			if (sPtnrMbrOfficeEmail != null || sPtnrMbrOfficeEmail != ""){
				paramMap.put( "ptnr_mbr_office_email", damo.encodeDamo(sPtnrMbrOfficeEmail) );
			}			
			
			if( "I".equals(sAction) ) {		//보험사 담당자 정보 추가
				
				nRet = sqlSession.insert("PopPtnrMbrMapper.insertPtnrMbrInfo", paramMap);				
				String maxPtnrMbrNo = sqlSession.selectOne("PopPtnrMbrMapper.selectPtnrMbrMax");				
				//로그등록을 위해 등록된 보험사 담당자 사번을 넣어준다.
				paramMap.put("ptnr_mbr_no", maxPtnrMbrNo);				
				
			}
			
			if( "U".equals(sAction) ) {		//보험사 담당자 정보 수정
				nRet = sqlSession.update("PopPtnrMbrMapper.updatePtnrMbrInfo", paramMap);
			}
			
		}
        
		//로그등록
		sqlSession.insert("PopPtnrMbrMapper.insertPtnrMbrLog", paramMap);        
        
		return nRet;		
	}
	
	/*
	 * 보험사 부서정보 불러오기
	 */
	@RequestMapping(value = "getPtnrDeptInfoAjax", method = RequestMethod.POST)
	@ResponseBody //해당 메소드의 반환값이 HTTP response body에 바인딩
	public Map<String, Object> getPtnrDeptInfoAjax(Model model,String ptnr_id, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= getPtnrDeptInfoAjax =======");
		
		//===============================================
	    //	결과 맵 생성
	    //===============================================
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		List<TopPtnrDeptBscVO> ptnrDeptList = sqlSession.selectList("PopPtnrMbrMapper.getThisDeptOrd",ptnr_id);
		
		resultMap.put("list", ptnrDeptList);		
		
        return resultMap; 
	}
	
	/**
	 * 보험사 양식 목록 모달
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "ptnrTemplateDetailModal")
	public String ptnrTemplateDetailModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= ptnrTemplateDetailModal =======");
						
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		List<InsuTemplateBean> templateList = sqlSession.selectList("TopPtnrListMapper.insuTemplateList", paramMap);		
		
		model.addAttribute("templateList", templateList);
		
		return "top_general/top_ptnr_company_template_detail_modal";
	}
	
	/**
	 * 관련업체 회사정보 모달창 불러오기
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "ptnrCompanyDetailModal")
	public String ptnrCompanyDetailModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= ptnrCompanyDetailModal =======");
						
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);		
		
		TopPtnrBscVO ptnrCompanyInfo = sqlSession.selectOne("TopPtnrListMapper.getPtnrListSearchOne", paramMap);
		
		model.addAttribute("ptnrCompanyInfo", ptnrCompanyInfo);
		
		return "top_general/top_ptnr_company_detail_modal";
	}
	
	@RequestMapping(value = "ptnrMemberDetailModal")
	public String ptnrMemberDetailModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= ptnrMemberDetailModal =======");
		
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();		
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();		
						
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String ptnr_mbr_no = String.valueOf(paramMap.get("ptnr_mbr_no"));		//보험사 직원번호
		String sViewType = String.valueOf(paramMap.get("view_type"));			//상세보기 여부 플래그
		
		//보험사 목록
		List<TopPtnrBscVO> ptnrListForSearch = sqlSession.selectList("RptInvListMapper.ptnrListForSearch");
		model.addAttribute("ptnrListForSearch", ptnrListForSearch);
		
		if( !"add".equals(sViewType) ) {	//조회 수정인경우 데이터를 불러온다.
			
			TopPtnrMbrBscVO ptnrMemberInfo = sqlSession.selectOne("SuimPtnrMbrPopMapper.suimPtnrMbrInfoOne", paramMap);
			
			Damo damo = new Damo();
			if (ptnrMemberInfo.getPtnr_mbr_hp() != null || ptnrMemberInfo.getPtnr_mbr_hp() != ""){
				ptnrMemberInfo.setPtnr_mbr_hp( damo.decodeDamo(ptnrMemberInfo.getPtnr_mbr_hp()) );
			}	
			if (ptnrMemberInfo.getPtnr_mbr_office_tel() != null || ptnrMemberInfo.getPtnr_mbr_office_tel() != ""){
				ptnrMemberInfo.setPtnr_mbr_office_tel( damo.decodeDamo(ptnrMemberInfo.getPtnr_mbr_office_tel()) );
			}	
			if (ptnrMemberInfo.getPtnr_mbr_office_fax() != null || ptnrMemberInfo.getPtnr_mbr_office_fax() != ""){
				ptnrMemberInfo.setPtnr_mbr_office_fax( damo.decodeDamo(ptnrMemberInfo.getPtnr_mbr_office_fax()) );
			}	
			if (ptnrMemberInfo.getPtnr_mbr_office_email() != null || ptnrMemberInfo.getPtnr_mbr_office_email() != ""){
				ptnrMemberInfo.setPtnr_mbr_office_email( damo.decodeDamo(ptnrMemberInfo.getPtnr_mbr_office_email()) );
			}		
			
			model.addAttribute("ptnrMemberInfo", ptnrMemberInfo);
			
			if( "edit".equals(sViewType) ) {				//수정인경우 해당 보험사의 부서정보를 불러온다.
				List<TopPtnrDeptBscVO> ptnrDeptList = sqlSession.selectList("PopPtnrMbrMapper.getThisDeptOrd",ptnrMemberInfo.getPtnr_id());
				model.addAttribute("ptnrDeptList", ptnrDeptList);
			}
		}
		
		model.addAttribute("view_type", sViewType);
		
		return "top_general/top_ptnr_member_detail_modal";
	}
	
	/**
	 * 관련업체 직원목록 불러오기
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "topPtnrMemberListAjax")
	public String topPtnrMemberListAjax(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= topPtnrMemberListAjax =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
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
		String pageIdxSearch = StringUtil.null2blank((String)paramMap.get("pageIdxSearch"));
		
		if("".equals(pageIdxSearch)){
		    currentPage = 0;
		    limitPage = 0;
		}else{
		    currentPage = (Integer.parseInt(pageIdxSearch) - 1);
		    limitPage = ((Integer.parseInt(pageIdxSearch) - 1) * sizePerPage);
		}
		paramMap.put("sizePerPage", sizePerPage);
		paramMap.put("limitPage", limitPage);
		
		Damo damo = new Damo();
		
		String srchPtnrMbrTel = String.valueOf(paramMap.get("srchPtnrMbrTel"));		
				
		//전화번호는 검색시 암호화 해서 조회한다.
		if( !"null".equals(srchPtnrMbrTel) && !"".equals(srchPtnrMbrTel)) {
			String encodeSrchPtnrMbrTel = damo.encodeDamo(srchPtnrMbrTel);			
			paramMap.put("srchPtnrMbrTel", encodeSrchPtnrMbrTel);
		}
		
		//보험사 직원목록
		List<TopPtnrMbrBscVO> searchMemberList = sqlSession.selectList("SuimPtnrMbrPopMapper.suimPtnrMbrListSearch", paramMap);
		
		String tmpStr = "";
		for(int i=0; i < searchMemberList.size() ;i++){
			tmpStr = damo.decodeDamo( searchMemberList.get(i).getPtnr_mbr_hp() );
			searchMemberList.get(i).setPtnr_mbr_hp(tmpStr);
			
			tmpStr = damo.decodeDamo( searchMemberList.get(i).getPtnr_mbr_office_tel() );
			searchMemberList.get(i).setPtnr_mbr_office_tel(tmpStr);
			
			tmpStr = damo.decodeDamo( searchMemberList.get(i).getPtnr_mbr_office_fax() );
			searchMemberList.get(i).setPtnr_mbr_office_fax(tmpStr);
			
			tmpStr = damo.decodeDamo( searchMemberList.get(i).getPtnr_mbr_office_email() );
			searchMemberList.get(i).setPtnr_mbr_office_email(tmpStr);
		}
		
		model.addAttribute("searchMemberList", searchMemberList);		
		
		int ptnrMemberCnt = sqlSession.selectOne("SuimPtnrMbrPopMapper.suimPtnrMbrListSearchCnt", paramMap);		
		
		PaginationInfo pageInfo = new PaginationInfo();			
		pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
		pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
		pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
		pageInfo.setTotalRecordCount(ptnrMemberCnt);   				// 총 글 갯수
		model.addAttribute("pageInfo", pageInfo);
		
		return "top_general/top_ptnr_member_list_ajax";
	}
	
	/**
	 * 보험사별 계약기간 설정
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "ptnrPeriodSetup")
	public String ptnrPeriodSetup(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= ptnrPeriodSetup =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || mbrVo.getUser_no() == ""){
			logger.info("topPtnrList - no permissions user " + request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		
		//검색 대상 보험사 목록
		List<TopPtnrBscVO> ptnrList = sqlSession.selectList("RptInvListMapper.ptnrListForSearch");
		
		model.addAttribute("ptnrList", ptnrList);

		return "/sys_adm/suim_rpt_period_setup_main";
	}
	
	/**
	 * 보고서 코드 분류 관리 (물보험 조사, 심사, 기타 기준설정)
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "suimRptTypeSetup")
	public String suimRptTypeSetup(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= suimRptTypeSetup =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || mbrVo.getUser_no() == ""){
			logger.info("topPtnrList - no permissions user " + request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		
		return "/sys_adm/suim_rpt_type_setup_main";
	}
	
	@ResponseBody
	@RequestMapping(value = "/updateSuimPeriodFlagVal", method = RequestMethod.POST)
	public int updateSuimPeriodFlagVal(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("==== updateSuimPeriodFlagVal ==== ");
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        int uptCnt = 0;
        int nChkCnt = 0;		//기존테이블 확인
        
        nChkCnt = sqlSession.selectOne("ItMgmtMapper.countSuimPeriodSearch", paramMap);
        
        if( nChkCnt == 1 ) {			//존재하는 경우 수정
        	uptCnt = sqlSession.update("ItMgmtMapper.updateSuimPeriod",paramMap);
        }else if( nChkCnt == 0 ) {	//없는 경우 추가  
        	uptCnt = sqlSession.insert("ItMgmtMapper.insertSuimPeriod", paramMap);
        }else{								//2개 이상인경우 삭제 후 새로 생성
        	uptCnt = sqlSession.delete("ItMgmtMapper.deleteSuimPeriod", paramMap);
        	uptCnt = sqlSession.insert("ItMgmtMapper.insertSuimPeriod", paramMap);
        }
        
		return uptCnt;		
	}	
	
	/**
	 * 보고서 코드 분류 값 갱신
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/updateSuimTypeCodeVal", method = RequestMethod.POST)
	public int updateSuimTypeCodeVal(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("==== updateSuimTypeCodeVal ==== ");
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);        
        
        int uptCnt = 0;
        int nChkCnt = 0;		//기존테이블 확인
        
        nChkCnt = sqlSession.selectOne("ItMgmtMapper.countSuimTypeSearch", paramMap);
        
        if( nChkCnt == 1 ) {			//존재하는 경우 수정
        	uptCnt = sqlSession.update("ItMgmtMapper.updateSuimType",paramMap);
        }else if( nChkCnt == 0 ) {	//없는 경우 추가  
        	uptCnt = sqlSession.insert("ItMgmtMapper.insertSuimType", paramMap);
        }else{								//2개 이상인경우 삭제 후 새로 생성
        	uptCnt = sqlSession.delete("ItMgmtMapper.deleteSuimType", paramMap);
        	uptCnt = sqlSession.insert("ItMgmtMapper.insertSuimType", paramMap);
        }        
        
		return uptCnt;		
	}
		
	/**
	 * 보험사 계약기간관리 목록 불러오기
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getSuimRptPeriodListAjax")
	public String getSuimRptPeriodListAjax(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= getSuimRptPeriodListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

		List<Map<String, Object>> periodList = sqlSession.selectList("ItMgmtMapper.selectSuimRptPeriodListSearch", paramMap);
		
		model.addAttribute("periodList", periodList);
		
		return "/sys_adm/suim_rpt_period_setup_list_ajax";
	}
	
	/**
	 * 보고서 코드 분류 관리 목록 불러오기
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getSuimRptTypeCodeListAjax")
	public String getSuimRptTypeCodeListAjax(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= getSuimRptTypeCodeListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
		List<Map<String, Object>> codeList = sqlSession.selectList("ItMgmtMapper.selectSuimRptTypeCodeListSearch", paramMap);
		
		model.addAttribute("codeList", codeList);
		
		return "/sys_adm/suim_rpt_type_setup_list_ajax";
	}
	
	/**
	 * 관련업체(보험사) 통계정렬순서 수정
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "topPtnrListOrder")
	public String topPtnrListOrder(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= topPtnrListOrder =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || mbrVo.getUser_no() == ""){
			logger.info("topPtnrList - no permissions user " + request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		model.addAttribute("srchParam", paramMap);
		
		return "top_general/top_ptnr_order_main";
	}
	
	/**
	 * 관련업체(보험사) 통계정렬순서 목록 불러오기
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "topPtnrListOrderAjax")
	public String topPtnrListOrderAjax(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= topPtnrListOrderAjax =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);		
		
		List<Map<String, Object>> orderCompanyList = sqlSession.selectList("TopPtnrListMapper.getPtnrOrderListAll", paramMap);
		
		model.addAttribute("companyList", orderCompanyList);
		model.addAttribute("srchParam", paramMap);

		return "top_general/top_ptnr_order_list_ajax";
	}
	
	@RequestMapping(value="topPtnrListOrderAction")
    @ResponseBody
    public int topPtnrListOrderAction(HttpServletRequest request, Model model) {
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sAction = request.getParameter("action") != null ? request.getParameter("action") : "";
		
		logger.info("======= topPtnrListOrderAction "+ sAction +"=======");		
		
    	int nCnt = 0;
    	
    	int nOrgNum = 0;
		int nTargetNum = 0;
		
		String sOrgPtnrId = "";
		String sTargetPtnrId = "";
		
		nOrgNum = Integer.parseInt(String.valueOf(paramMap.get("statistics_order")));
		sOrgPtnrId = String.valueOf(paramMap.get("ptnr_id"));
    	
    	if( "Up".equals(sAction) ) {		//순서를 한단계 상승    		
    		
    		//한단계상위 보험사의 정보를 가져온다.
    		Map<String, Object> upPtnrInfo = sqlSession.selectOne("TopPtnrListMapper.selectOrderUpPtnrInfo",paramMap);
    		
    		nTargetNum = Integer.parseInt(String.valueOf(upPtnrInfo.get("statistics_order")));
    		sTargetPtnrId = String.valueOf(upPtnrInfo.get("ptnr_id"));
    		
    		//기존 보험사 순서정보를 갱신한다.
    		paramMap.put("upPtnrId", sOrgPtnrId);
    		paramMap.put("upOrderNum", nTargetNum);
    		
    		nCnt = sqlSession.update("TopPtnrListMapper.updateOrderPtnrInfo",paramMap);
    		
    		//타겟 보험사 순서정보를 갱신한다.    		
    		paramMap.put("upPtnrId", sTargetPtnrId);
    		paramMap.put("upOrderNum", nOrgNum);
    		
    		nCnt = sqlSession.update("TopPtnrListMapper.updateOrderPtnrInfo",paramMap);
    		
    	}else if( "Down".equals(sAction) ) {	//한단계 하락
    		
    		//한단계하위 보험사의 정보를 가져온다.
    		Map<String, Object> downPtnrInfo = sqlSession.selectOne("TopPtnrListMapper.selectOrderDownPtnrInfo",paramMap);
    		
    		nTargetNum = Integer.parseInt(String.valueOf(downPtnrInfo.get("statistics_order")));
    		sTargetPtnrId = String.valueOf(downPtnrInfo.get("ptnr_id"));
    		    		
    		//기존 보험사 순서정보를 갱신한다.
    		paramMap.put("upPtnrId", sOrgPtnrId);
    		paramMap.put("upOrderNum", nTargetNum);
    		
    		nCnt = sqlSession.update("TopPtnrListMapper.updateOrderPtnrInfo",paramMap);
    		
    		//타겟 보험사 순서정보를 갱신한다.    		
    		paramMap.put("upPtnrId", sTargetPtnrId);
    		paramMap.put("upOrderNum", nOrgNum);
    		
    		nCnt = sqlSession.update("TopPtnrListMapper.updateOrderPtnrInfo",paramMap);
    		
    	}
    	
    	return nCnt;
    }
	
	/*
	 * 관련업체(신규)
	 */
	@RequestMapping(value = "topPtnrListNew")
	public String topPtnrListNew(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= topPtnrListNew =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || mbrVo.getUser_no() == ""){
			logger.info("topPtnrList - no permissions user " + request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		//보험사 목록
		List<TopPtnrBscVO> ptnrListForSearch = sqlSession.selectList("RptInvListMapper.ptnrListForSearch");
		model.addAttribute("ptnrListForSearch", ptnrListForSearch);
		
		return "top_general/top_ptnr_list_main";
	}
	
	@RequestMapping(value = "topPtnrList", method = RequestMethod.GET)
	public String topPtnrList(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response
			, String ptnrSrc, String ptnrGb, String srcWord) {
		
		logger.info("======= topPtnrList =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || mbrVo.getUser_no() == ""){
			logger.info("topPtnrList - no permissions user " + request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		
		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());
		
		GetImageBase64 getImageObject  = new  GetImageBase64();
		
		List<TopPtnrBscVO> ptnrList = sqlSession.selectList("TopPtnrListMapper.getPtnrList");
		for (int i = 0; i < ptnrList.size(); i++){
			TopPtnrBscVO tmpVO = ptnrList.get(i);
			if(tmpVO.getPtnr_img_small() != null && !tmpVO.getPtnr_img_small().equals("")){
				String dbpath = "/home/hosting_users/toplac/www/ls_data/ig/small/"+tmpVO.getPtnr_img_small();
				String fileType = dbpath.substring(dbpath.lastIndexOf(".")+1, dbpath.length());
				if ("jpg".equalsIgnoreCase(fileType) || "jpeg".equalsIgnoreCase( fileType) || "gif".equalsIgnoreCase( fileType) || "png".equalsIgnoreCase( fileType)){
					
					String imageBase64 = getImageObject.imageBase64Small(dbpath, fileType);
					
					tmpVO.setPtnr_img_small(imageBase64);
				}
			}
		}
		List<TopPtnrBscVO> ptnrList2 = sqlSession.selectList("TopPtnrListMapper.getPtnrList2");
		for (int i = 0; i < ptnrList2.size(); i++){
			TopPtnrBscVO tmpVO = ptnrList2.get(i);
			if(tmpVO.getPtnr_img_small() != null && !tmpVO.getPtnr_img_small().equals("")){
				String dbpath = "/home/hosting_users/toplac/www/ls_data/ig/small/"+tmpVO.getPtnr_img_small();
				String fileType = dbpath.substring(dbpath.lastIndexOf(".")+1, dbpath.length());
				if ("jpg".equalsIgnoreCase(fileType) || "jpeg".equalsIgnoreCase( fileType) || "gif".equalsIgnoreCase( fileType) || "png".equalsIgnoreCase( fileType)){
					String imageBase64 = getImageObject.imageBase64Small(dbpath, fileType);
					tmpVO.setPtnr_img_small(imageBase64);
				}
			}
		}
		List<TopPtnrBscVO> ptnrList3 = sqlSession.selectList("TopPtnrListMapper.getPtnrList3");
		for (int i = 0; i < ptnrList3.size(); i++){
			TopPtnrBscVO tmpVO = ptnrList3.get(i);
			if(tmpVO.getPtnr_img_small() != null && !tmpVO.getPtnr_img_small().equals("")){
				String dbpath = "/home/hosting_users/toplac/www/ls_data/ig/small/"+tmpVO.getPtnr_img_small();
				String fileType = dbpath.substring(dbpath.lastIndexOf(".")+1, dbpath.length());
				if ("jpg".equalsIgnoreCase(fileType) || "jpeg".equalsIgnoreCase( fileType) || "gif".equalsIgnoreCase( fileType) || "png".equalsIgnoreCase( fileType)){
					String imageBase64 = getImageObject.imageBase64Small(dbpath, fileType);
					tmpVO.setPtnr_img_small(imageBase64);
				}
			}
		}
		List<TopPtnrBscVO> ptnrList4 = sqlSession.selectList("TopPtnrListMapper.getPtnrList4");
		for (int i = 0; i < ptnrList4.size(); i++){
			TopPtnrBscVO tmpVO = ptnrList4.get(i);
			if(tmpVO.getPtnr_img_small() != null && !tmpVO.getPtnr_img_small().equals("")){
				String dbpath = "/home/hosting_users/toplac/www/ls_data/ig/small/"+tmpVO.getPtnr_img_small();
				String fileType = dbpath.substring(dbpath.lastIndexOf(".")+1, dbpath.length());
				if ("jpg".equalsIgnoreCase(fileType) || "jpeg".equalsIgnoreCase( fileType) || "gif".equalsIgnoreCase( fileType) || "png".equalsIgnoreCase( fileType)){
					String imageBase64 = getImageObject.imageBase64Small(dbpath, fileType);
					tmpVO.setPtnr_img_small(imageBase64);
				}
			}
		}
		List<TopPtnrBscVO> ptnrList5 = sqlSession.selectList("TopPtnrListMapper.getPtnrList5");
		for (int i = 0; i < ptnrList5.size(); i++){
			TopPtnrBscVO tmpVO = ptnrList5.get(i);
			if(tmpVO.getPtnr_img_small() != null && !tmpVO.getPtnr_img_small().equals("")){
				String dbpath = "/home/hosting_users/toplac/www/ls_data/ig/small/"+tmpVO.getPtnr_img_small();
				String fileType = dbpath.substring(dbpath.lastIndexOf(".")+1, dbpath.length());
				if ("jpg".equalsIgnoreCase(fileType) || "jpeg".equalsIgnoreCase( fileType) || "gif".equalsIgnoreCase( fileType) || "png".equalsIgnoreCase( fileType)){
					String imageBase64 = getImageObject.imageBase64Small(dbpath, fileType);
					tmpVO.setPtnr_img_small(imageBase64);
				}
			}
		}
		model.addAttribute("ptnrList", ptnrList);
		model.addAttribute("ptnrList2", ptnrList2);
		model.addAttribute("ptnrList3", ptnrList3);
		model.addAttribute("ptnrList4", ptnrList4);
		model.addAttribute("ptnrList5", ptnrList5);
		
		List<TopPtnrBscVO> ptnrListForSearch = sqlSession.selectList("RptInvListMapper.ptnrListForSearch");
		model.addAttribute("ptnrListForSearch", ptnrListForSearch);
		
		if(ptnrSrc != null){
			HashMap<String, String> queryMap = new HashMap<String, String>();
			Damo damo = new Damo();
			String srcWordENC = damo.encodeDamo(srcWord);
			
			queryMap.put("ptnrSrc", ptnrSrc);
			queryMap.put("ptnrGb", ptnrGb);
			queryMap.put("srcWordDEC", srcWord);
			queryMap.put("srcWordENC", srcWordENC);
			
			List<TopPtnrMbrBscVO> searchMemberList = sqlSession.selectList("SuimPtnrMbrPopMapper.suimPtnrMbrPopSearch", queryMap);
			String tmpStr = "";
			for(int i=0; i < searchMemberList.size() ;i++){
				tmpStr = damo.decodeDamo( searchMemberList.get(i).getPtnr_mbr_hp() );
				searchMemberList.get(i).setPtnr_mbr_hp(tmpStr);
				
				tmpStr = damo.decodeDamo( searchMemberList.get(i).getPtnr_mbr_office_tel() );
				searchMemberList.get(i).setPtnr_mbr_office_tel(tmpStr);
				
				tmpStr = damo.decodeDamo( searchMemberList.get(i).getPtnr_mbr_office_fax() );
				searchMemberList.get(i).setPtnr_mbr_office_fax(tmpStr);
				
				tmpStr = damo.decodeDamo( searchMemberList.get(i).getPtnr_mbr_office_email() );
				searchMemberList.get(i).setPtnr_mbr_office_email(tmpStr);
			}
			
			model.addAttribute("ptnrMbrList", searchMemberList);
			
			model.addAttribute("ptnrSrc", ptnrSrc);
			model.addAttribute("ptnrGb", ptnrGb);
			model.addAttribute("srcWord", srcWord);
		}
		return "top_general/top_ptnr_list";
	}
	
	/*엑셀 다운로드*/
	@RequestMapping(value = "excelPtnrMember", method = RequestMethod.GET)
	public String excelTopMemeber(Model model, HttpSession session, HttpServletRequest request, String gubun, HttpServletResponse response) {
		logger.info("======= excelTopMemeber =======");
		
		List<TopPtnrMbrBscVO> ptnrList = sqlSession.selectList("TopPtnrListMapper.topPtnrListExcel",gubun);
		
		/***** 기준일자 세팅 *****/
		Date dateToday = new Date();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");//오늘날자구하기
		String today = df.format(dateToday);
		
		/***** 암호화 필드 복호화 *****/
		Damo damo = new Damo();
		for(int i=0; i < ptnrList.size() ;i++){
			if (ptnrList.get(i).getPtnr_mbr_hp() != null && !ptnrList.get(i).getPtnr_mbr_hp().equals("")){
				String tmpStr = damo.decodeDamo(ptnrList.get(i).getPtnr_mbr_hp());
				ptnrList.get(i).setPtnr_mbr_hp(tmpStr);
			}
			if (ptnrList.get(i).getPtnr_mbr_office_tel() != null && !ptnrList.get(i).getPtnr_mbr_office_tel().equals("")){
				String tmpStr = damo.decodeDamo(ptnrList.get(i).getPtnr_mbr_office_tel());
				ptnrList.get(i).setPtnr_mbr_office_tel(tmpStr);
			}
			if (ptnrList.get(i).getPtnr_mbr_office_fax() != null && !ptnrList.get(i).getPtnr_mbr_office_fax().equals("")){
				String tmpStr = damo.decodeDamo(ptnrList.get(i).getPtnr_mbr_office_fax());
				ptnrList.get(i).setPtnr_mbr_office_fax(tmpStr);
			}
			if (ptnrList.get(i).getPtnr_mbr_office_email() != null && !ptnrList.get(i).getPtnr_mbr_office_email().equals("")){
				String tmpStr = damo.decodeDamo(ptnrList.get(i).getPtnr_mbr_office_email());
				ptnrList.get(i).setPtnr_mbr_office_email(tmpStr);
			}
			
			if (ptnrList.get(i).getPtnr_mbr_work_type().equals("0")){
				ptnrList.get(i).setPtnr_mbr_work_type("1,4종 겸직");
			}else if (ptnrList.get(i).getPtnr_mbr_work_type().equals("1")){
				ptnrList.get(i).setPtnr_mbr_work_type("1종");
			}else if (ptnrList.get(i).getPtnr_mbr_work_type().equals("4")){
				ptnrList.get(i).setPtnr_mbr_work_type("4종");
			}
		}
		
		model.addAttribute("today",today);
		model.addAttribute("ptnrList",ptnrList);
		model.addAttribute("ptnrListCnt",ptnrList.size());
		
		
		
		String fileName = "";
		if( gubun.equals("all") ){
			fileName = "관련업체_직원명단.xls";
			model.addAttribute("title","관련업체 직원명단");
		}else{
			fileName = ptnrList.get(0).getPtnr_nick()+"_직원명단.xls";
			model.addAttribute("title",ptnrList.get(0).getPtnr_nick()+" 직원명단");
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
		
		return "top_general/top_ptnr_list_excel";
	}

}
