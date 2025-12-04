package kr.co.toplac.toprptmbrchg;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.toprptmbrchg.service.RptMbrchgService;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.PaginationInfo;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class RptMbrchgController {

private static final Logger logger = LoggerFactory.getLogger(RptMbrchgController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private RptMbrchgService RptMbrchgService;

	/*
	*********************************************************
	* Program ID	: rptMbrchgList
	* Program Name	: rptMbrchgList
	* Description	: 보고서 담당자변경(이내첩) 조회
	* Author		: 임대성
	* Date			: 2017.09.27
	*********************************************************
	*/
	@RequestMapping(value = "rptMbrchgList")
	public String rptMbrchgList(Model model, HttpServletRequest request, HttpSession session) {
		logger.info("======= rptMbrchgList =======");
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		paramNull2Blank(paramMap);
		
		//System.out.println("tabCode : " +paramMap.get("code"));
		
	    //===============================================
	    //	권한체크
	    //===============================================
	    //TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	    TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
		
	    String tmpFlag = (String) paramMap.get("flag");
	    String pms25 = mbrAuthVo.getMbr_pms_25();
	    if( "1".equals(pms25) || "2".equals(pms25) || "3".equals(pms25) || "4".equals(pms25)){
	    	switch(pms25){
	    		case "1":
	    			if ( !tmpFlag.equals("user") ) return "redirect:/";
	    			break;
	    		case "2":
	    			if ( !tmpFlag.equals("team") ) return "redirect:/";
	    			break;
	    		case "3":
	    			if ( !tmpFlag.equals("center") ) return "redirect:/";
	    			break;
	    		case "4":
	    			if ( !tmpFlag.equals("admin") ) return "redirect:/";
	    			break;	    			
	    	}
	    }else{
	    	return "redirect:/";
	    }
	    
	    
	    
        //===============================================
        // 페이지 관련 변수 선언
        //===============================================
        int sizePerPage = 500;       // 한페이지당 보여줄 글 갯수
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
        
        HashMap<String,Object> returnMap = RptMbrchgService.rptMbrchgList(paramMap,"view");

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        PaginationInfo pageInfo = new PaginationInfo();			
        pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
        pageInfo.setPageSize(sizePerBlock);                    			 //페이지 리스트 에 보여줄 불럭 갯수
        pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
        pageInfo.setTotalRecordCount((long) returnMap.get("rptMbrchgListCnt"));    // 총 글 갯수        	   
        
	    
        model.addAttribute("rptMbrchgList",returnMap.get("rptMbrchgList"));
        model.addAttribute("rptMbrchgListCnt",returnMap.get("rptMbrchgListCnt"));

        model.addAttribute("topTeamList",returnMap.get("topTeamList"));
        model.addAttribute("pmsTeamList",returnMap.get("pmsTeamList"));
        model.addAttribute("mbrchgReasonList",returnMap.get("mbrchgReasonList"));
        
        model.addAttribute("pageInfo",pageInfo);
        
        model.addAttribute("srchParam",paramMap);
	    
		return "top_rpt_mbrchg/rpt_mbrchg_main";
	}
	
	/*
	*********************************************************
	* Program ID	: getRptMbrchgListTab
	* Program Name	: getRptMbrchgListTab
	* Description	: 보고서 담당자변경(이내첩) 조회 - AJAX TAB 변경 LIST
	* Author		: 임대성
	* Date			: 2017.10.12
	*********************************************************
	*/
	@RequestMapping(value = "getRptMbrchgListTab")
	public String getRptMbrchgListTab(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.info("======= getRptMbrchgListTab =======");
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		paramNull2Blank(paramMap);
		
		String tabCode = String.valueOf( paramMap.get("code") );
		
	    //===============================================
	    //	권한체크
	    //===============================================
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	    TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
		
	    String tmpFlag = (String) paramMap.get("flag");
	    String pms25 = mbrAuthVo.getMbr_pms_25();
	    if( "1".equals(pms25) || "2".equals(pms25) || "3".equals(pms25) || "4".equals(pms25) ){
	    	switch(pms25){
	    		case "1":
	    			if ( !tmpFlag.equals("user") ) return "redirect:/";
	    			break;
	    		case "2":
	    			if ( !tmpFlag.equals("team") ) return "redirect:/";
	    			break;
	    		case "3":
	    			if ( !tmpFlag.equals("center") ) return "redirect:/";
	    			break;
	    		case "4":
	    			if ( !tmpFlag.equals("admin") ) return "redirect:/";
	    			break;	    			
	    	}
	    }else{
	    	return "redirect:/";
	    }
	    
	       //===============================================
        // 페이지 관련 변수 선언
        //===============================================
        int sizePerPage = 500;       // 한페이지당 보여줄 글 갯수
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
        

        HashMap<String,Object> returnMap = RptMbrchgService.rptMbrchgList(paramMap,"view");
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        PaginationInfo pageInfo = new PaginationInfo();			
        pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
        pageInfo.setPageSize(sizePerBlock);                    			 //페이지 리스트 에 보여줄 불럭 갯수
        pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
        pageInfo.setTotalRecordCount((long) returnMap.get("rptMbrchgListCnt"));    // 총 글 갯수        	 
	    
	    
        model.addAttribute("rptMbrchgList",returnMap.get("rptMbrchgList"));
        model.addAttribute("rptMbrchgListCnt",returnMap.get("rptMbrchgListCnt"));
        
        model.addAttribute("topTeamList",returnMap.get("topTeamList"));
        model.addAttribute("pageInfo",pageInfo);
        
	    model.addAttribute("srchParam",paramMap);
	    
	    if ("0".equals(tabCode)){
	    	return "top_rpt_mbrchg/rpt_mbrchg_list";
	    }else if("3".equals(tabCode)){
	    	return "top_rpt_mbrchg/ajax/rpt_mbrchg_log_list_ajax";
	    }else{
	    	return "top_rpt_mbrchg/ajax/rpt_mbrchg_list_ajax";
	    }	
	}
	
	
	/*
	*********************************************************
	* Program ID	: rptMbrchgOut
	* Program Name	: rptMbrchgOut
	* Description	: 보고서 담당자변경 이첩 신청
	* Author		: 임대성
	* Date			: 2017.10.11
	*********************************************************
	*/
	@RequestMapping(value = "rptMbrchgOut")
	@ResponseBody
	public HashMap<String,Object> rptMbrchgOut(Model model, HttpServletRequest request, HttpSession session) {
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);

		String[] outRptArr = request.getParameterValues("outRpt");
		paramMap.put("outRpt", outRptArr);
		
		HashMap<String,Object> returnMap = RptMbrchgService.rptMbrchgOut(paramMap);
		
		return returnMap;
	}

	
	/*
	*********************************************************
	* Program ID	: rptMbrchgOutCancel
	* Program Name	: rptMbrchgOutCancel
	* Description	: 보고서 담당자변경 이첩 회수
	* Author		: 임대성
	* Date			: 2017.10.16
	*********************************************************
	*/
	@RequestMapping(value = "rptMbrchgOutCancel")
	@ResponseBody
	public HashMap<String,Object> rptMbrchgOutCancel(Model model, HttpServletRequest request, HttpSession session) {
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);

		String[] serialNo = request.getParameterValues("serialNo");
		
		paramMap.put("serialNo", serialNo);
		
		HashMap<String,Object> returnMap = RptMbrchgService.rptMbrchgOutCancel(paramMap);
		
		return returnMap;
	}

	
	/*
	*********************************************************
	* Program ID	: rptMbrchgOutCancel
	* Program Name	: rptMbrchgOutCancel
	* Description	: 보고서 담당자변경 이첩 회수
	* Author		: 임대성
	* Date			: 2017.10.16
	*********************************************************
	*/
	@RequestMapping(value = "rptMbrchgIn")
	@ResponseBody
	public HashMap<String,Object> rptMbrchgIn(Model model, HttpServletRequest request, HttpSession session) {
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);

		String[] serialNo = request.getParameterValues("serialNo");
		String[] suimRptNo = request.getParameterValues("suimRptNo");
		paramMap.put("serialNo", serialNo);
		paramMap.put("suimRptNo", suimRptNo);
		
		
		HashMap<String,Object> returnMap = RptMbrchgService.rptMbrchgIn(paramMap);
		
		return returnMap;
	}
	
	
	
	
	/*
	*********************************************************
	* Method ID		: rptMbrchgListExcelDown
	* Method Name	: rptMbrchgListExcelDown
	* Description	: 보고서 이첩 EXCEL 다운로드
	* Author		: lds
	* Date			: 2017.10.23
	*********************************************************
	*/
	@RequestMapping(value = "rptMbrchgListExcelDown") 
	public String rptMbrchgListExcelDown(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {	
		logger.info("======= rptMbrchgListExcelDown =======");
	    //===============================================
	    //	파라미터 체크
	    //===============================================
	    Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		//파라미터 초기화
		paramMap = paramNull2Blank(paramMap);
		
	    //===============================================
	    //	권한체크
	    //===============================================
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	    //TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
	    
        String menuFlag = String.valueOf( paramMap.get("flag") );
        
        //파일명 생성 부분
        String fileNameUser = "";
        switch( menuFlag ){
        	case "user" 	: fileNameUser = mbrVo.getUser_name(); break;
        	case "team" 	: fileNameUser = mbrVo.getTeam_name(); break;
        	case "center" 	: fileNameUser = "센터장"; break;
        	case "admin" 	: fileNameUser = "관리자"; break;
        }
        
        Calendar cal = Calendar.getInstance();
        String year,month,date = "";
        year  =  String.valueOf( cal.get(Calendar.YEAR) );
        month =  String.valueOf( (cal.get(Calendar.MONTH) + 1) );
        if (month.length() ==1) {
        	month = "0" + month;
        }
        date  = String.valueOf( cal.get(Calendar.DATE) );
        if (date.length() ==1) {
        	date = "0" + date;
        }  
        
        String fileName = fileNameUser+"_보고서이첩_"+year+month+date+".xls";
		try {
			fileName = java.net.URLEncoder.encode(fileName,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		response.setHeader("Content-Disposition", "attachment;filename="+fileName);
		response.setHeader("Content-Type", "application/vnd.ms-xls");
		response.setHeader("Content-Description", "JSP Generated Data");
		response.setHeader("Content-Transfer-Encoding", "binary");
		
	    HashMap<String,Object> returnMap = RptMbrchgService.rptMbrchgList(paramMap,"excel"); //이첩은 페이지네이션이 없으므로.. VIEW/EXCEL구분 없음
	    
        model.addAttribute("rptMbrchgList",returnMap.get("rptMbrchgList"));
		
//		model.addAttribute("srchParam",paramMap);
		
		return "top_rpt_mbrchg/rpt_mbrchg_list_excel";
	}
	
	
	
	
	private Map<String,Object> paramNull2Blank(Map<String,Object> paramMap){

		String srchAcceptNo = StringUtil.null2blank( (String) paramMap.get("srchAcceptNo") );
		String srchAccidentNo = StringUtil.null2blank( (String) paramMap.get("srchAccidentNo") );
		String srchPolicyNm = StringUtil.null2blank( (String) paramMap.get("srchPolicyNm") );
		String suimStartDate = StringUtil.null2blank( (String) paramMap.get("suimStartDate") );
		String suimEndDate = StringUtil.null2blank( (String) paramMap.get("suimEndDate") );
		String chgStartDate = StringUtil.null2blank( (String) paramMap.get("chgStartDate") );
		String chgEndDate = StringUtil.null2blank( (String) paramMap.get("chgEndDate") );		
		String srchTmId = StringUtil.null2blank( (String) paramMap.get("srchTmId") );
		String srchUserNm = StringUtil.null2blank( (String) paramMap.get("srchUserNm") );
		
        if ("".equals(suimStartDate)) paramMap.put("suimStartDate", suimStartDate);
        if ("".equals(suimEndDate)) paramMap.put("suimEndDate", suimEndDate);
        if ("".equals(chgStartDate)) paramMap.put("chgStartDate", chgStartDate);
        if ("".equals(chgEndDate)) paramMap.put("chgEndDate", chgEndDate);
        
        if ("".equals(srchAcceptNo)) paramMap.put("srchAcceptNo", srchAcceptNo);
        if ("".equals(srchAccidentNo)) paramMap.put("srchAccidentNo", srchAccidentNo);
        if ("".equals(srchUserNm)) paramMap.put("srchUserNm", srchUserNm);
        if ("".equals(srchPolicyNm)) paramMap.put("srchPolicyNm", srchPolicyNm);
        if ("".equals(srchTmId)) paramMap.put("srchTmId", srchTmId);
        
		return paramMap;
	}
	
}
