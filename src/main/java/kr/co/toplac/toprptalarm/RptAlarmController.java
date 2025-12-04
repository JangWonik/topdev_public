package kr.co.toplac.toprptalarm;

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
public class RptAlarmController {

private static final Logger logger = LoggerFactory.getLogger(RptAlarmController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private SuimSpeed speedSuim;

	/*
	*********************************************************
	* Program ID	: speedMngList
	* Program Name	: speedMngList
	* Description	: 서면 보고서 알림
	* Author		: 임대성
	* Date			: 2017.06.29.
	*********************************************************
	*/
	@RequestMapping(value = "speedMngList")
	public String mySuimSpeedList(Model model, HttpServletRequest request, HttpSession session) {
		logger.info("======= speedMngList =======");
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		//파라미터 초기화
		paramMap = paramNull2Blank(paramMap);
		
	    //===============================================
	    //	권한체크
	    //===============================================
	    //TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	    TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
		
	    String tmpFlag = (String) paramMap.get("flag");
	    String pms24 = mbrAuthVo.getMbr_pms_24();
	    if( "1".equals(pms24) || "2".equals(pms24) || "3".equals(pms24) ){
	    	switch(pms24){
	    		case "1":
	    			if ( !tmpFlag.equals("user") ){
	    				return "redirect:/";
	    			}
	    			break;
	    		case "2":
	    			if ( !(tmpFlag.equals("user") || tmpFlag.equals("team")) ){
	    				return "redirect:/";
	    			}
	    			break;
	    		case "3":
	    			if ( !tmpFlag.equals("admin") ){
	    				return "redirect:/";
	    			}
	    			break;
	    	}
	    }else{
	    	return "redirect:/";
	    }
	    
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
        
        HashMap<String,Object> returnMap = speedSuim.SuimSpeedList(paramMap,"view");

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        PaginationInfo pageInfo = new PaginationInfo();			
        pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
        pageInfo.setPageSize(sizePerBlock);                    			 //페이지 리스트 에 보여줄 불럭 갯수
        pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
        pageInfo.setTotalRecordCount((long) returnMap.get("speedListCnt"));    // 총 글 갯수        
		
        
		model.addAttribute("speedList",returnMap.get("speedList"));
		model.addAttribute("speedCodeList",returnMap.get("speedCodeList"));
		model.addAttribute("topTeamList",returnMap.get("topTeamList"));
		model.addAttribute("pageInfo",pageInfo);
		
		model.addAttribute("srchParam",paramMap);
		
		return "top_rpt_alarm/speed_mng_main";
	}
	
	/*
	*********************************************************
	* Program ID	: getSpeedMngListTab
	* Program Name	: getSpeedMngListTab
	* Description	: 서면 미결 관리(개인) - AJAX TAB 변경 LIST
	* Author		: 임대성
	* Date			: 2017.08.25
	*********************************************************
	*/
	@RequestMapping(value = "getSpeedMngListTab")
	public String getSpeedMngListTab(Model model, HttpServletRequest request, HttpSession session) {
		logger.info("======= getSpeedMngListTab =======");
		
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		//파라미터 초기화
		paramMap = paramNull2Blank(paramMap);	
		
	    //===============================================
	    //	권한체크
	    //===============================================
	    //TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	    TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
		
	    String tmpFlag = (String) paramMap.get("flag");
	    String pms24 = mbrAuthVo.getMbr_pms_24();
	    if( "1".equals(pms24) || "2".equals(pms24) || "3".equals(pms24) ){
	    	switch(pms24){
	    		case "1":
	    			if ( !tmpFlag.equals("user") ){
	    				return "redirect:/";
	    			}
	    			break;
	    		case "2":
	    			if ( !(tmpFlag.equals("user") || tmpFlag.equals("team")) ){
	    				return "redirect:/";
	    			}
	    			break;
	    		case "3":
	    			if ( !tmpFlag.equals("admin") ){
	    				return "redirect:/";
	    			}
	    			break;
	    	}
	    }else{
	    	return "redirect:/";
	    }
		
		
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
        
        HashMap<String,Object> returnMap = speedSuim.SuimSpeedList(paramMap,"view");

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        PaginationInfo pageInfo = new PaginationInfo();			
        pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
        pageInfo.setPageSize(sizePerBlock);                    			 //페이지 리스트 에 보여줄 불럭 갯수
        pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
        pageInfo.setTotalRecordCount((long) returnMap.get("speedListCnt"));    // 총 글 갯수        
		
		model.addAttribute("speedList",returnMap.get("speedList"));
		model.addAttribute("speedCodeList",returnMap.get("speedCodeList"));
		model.addAttribute("pageInfo",pageInfo);
		
		model.addAttribute("srchParam",paramMap);
		
		return "top_rpt_alarm/speed_mng_list";
	}	
	
	
	/*
	*********************************************************
	* Program ID	: getRptAlarmList
	* Program Name	: getRptAlarmList
	* Description	: 보고서 알림 SELECT(수임건 별도)
	* Author		: 임대성
	* Date			: 2017.08.16.
	*********************************************************
	*/
	@RequestMapping(value = "getRptAlarmList", method = RequestMethod.POST)
	public String getRptAlarmList(Model model, HttpServletRequest request, HttpSession session) {
		logger.info("======= getRptAlarmList =======");
		
	    //===============================================
	    //	파라미터 체크
	    //===============================================
	    Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

	    //===============================================
	    //	권한체크
	    //===============================================
	    //TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	    //TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
	    
        //===============================================
        //	비즈니스 로직
        //===============================================
        try {
        	List<RptAlarmVO> alarmList = sqlSession.selectList("RptAlarmMapper.getRptAlarmList",paramMap);
        	
        	ArrayList<Integer> tmpList = new ArrayList<>();
        	for(int i=0; i <alarmList.size() ;i++){
        		tmpList.add( Integer.parseInt(alarmList.get(i).getSerialNo()) );
        	}
        	
        	int maxSerialNo = 0;
        	if(tmpList.size() > 0){
        		maxSerialNo = Collections.max(tmpList);
        	}
        	
        	model.addAttribute("maxSerialNo", maxSerialNo);
        	model.addAttribute("alarmList", alarmList);
        } catch (Exception e){
            e.printStackTrace();
        }
        

        return "top_rpt_alarm/ajax/rpt_alarm_list";
	}
	
	/*
	*********************************************************
	* Program ID	: insRptAlarm
	* Program Name	: insRptAlarm
	* Description	: 보고서 알림 등록
	* Author		: 임대성
	* Date			: 2017.08.17.
	*********************************************************
	*/
	@RequestMapping(value = "insRptAlarm")
	@ResponseBody
	public Map<String,Object> insRptAlarm(Model model, HttpServletRequest request, HttpSession session) {
		logger.info("======= insRptAlarm =======");
		
		//===============================================
	    //	결과 맵 생성
	    //===============================================
	    Map<String,Object> resultMap = new HashMap<String,Object>();

	    //===============================================
	    //	파라미터 체크
	    //===============================================
	    Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

	    //===============================================
	    //	권한체크
	    //===============================================
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	    //TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
	    paramMap.put("userNo", mbrVo.getUser_no());
	    
	    
        //===============================================
        //	비즈니스 로직
        //===============================================
        try {
        	sqlSession.insert("RptAlarmMapper.insRptAlarm",paramMap);
            resultMap.put("result", "0000");
        } catch (Exception e){
            resultMap.put("result","1010");
            e.printStackTrace();
        }

        return resultMap; 
	}
		
	/*
	*********************************************************
	* Program ID	: udtRptAlarm
	* Program Name	: udtRptAlarm
	* Description	: 보고서 알림 내용 수정(comment만)
	* Author		: 임대성
	* Date			: 2017.08.21.
	*********************************************************
	*/
	@RequestMapping(value = "udtRptAlarm")
	@ResponseBody
	public Map<String,Object> udtRptAlarm(Model model, HttpServletRequest request, HttpSession session) {
		logger.info("======= udtRptAlarm =======");
		
		//===============================================
	    //	결과 맵 생성
	    //===============================================
	    Map<String,Object> resultMap = new HashMap<String,Object>();

	    //===============================================
	    //	파라미터 체크
	    //===============================================
	    Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

	    //===============================================
	    //	권한체크
	    //===============================================
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	    //TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
	    paramMap.put("userNo", mbrVo.getUser_no());
	    
	    
        //===============================================
        //	비즈니스 로직
        //===============================================
        try {
        	sqlSession.update("RptAlarmMapper.udtRptAlarm",paramMap);
            resultMap.put("result", "0000");
        } catch (Exception e){
            resultMap.put("result","1010");
            e.printStackTrace();
        }

        return resultMap; 
	}	

	/*
	*********************************************************
	* Program ID	: udtRptAlarmConfirm
	* Program Name	: udtRptAlarmConfirm
	* Description	: 보고서 알림 완료
	* Author		: 임대성
	* Date			: 2017.08.22.
	*********************************************************
	*/
	@RequestMapping(value = "udtRptAlarmConfirm")
	@ResponseBody
	public Map<String,Object> udtRptAlarmConfirm(Model model, HttpServletRequest request, HttpSession session) {
		logger.info("======= udtRptAlarmConfirm =======");
		
		//===============================================
	    //	결과 맵 생성
	    //===============================================
	    Map<String,Object> resultMap = new HashMap<String,Object>();
	
	    //===============================================
	    //	파라미터 체크
	    //===============================================
	    Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
	
	    //===============================================
	    //	권한체크
	    //===============================================
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	    //TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
	    paramMap.put("userNo", mbrVo.getUser_no());
	    
	    
	    //===============================================
	    //	비즈니스 로직
	    //===============================================
	    try {
	    	paramMap.put("suimRptNo","");
	    	sqlSession.update("RptAlarmMapper.udtRptAlarmConfirm",paramMap);
	    	
	        resultMap.put("result", "0000");
	        
	    } catch (Exception e){
	        resultMap.put("result","1010");
	        e.printStackTrace();
	    }
	
	    return resultMap; 
	}		
		
	
	/*
	*********************************************************
	* Method ID		: udtSpeedMngCode
	* Method Name	: udtSpeedMngCode
	* Description	: 서면심사 미결 코드 UPDATE
	* Author		: lds
	* Date			: 2017.07.06
	*********************************************************
	*/
	@RequestMapping(value = "udtSpeedComment")
	@ResponseBody //해당 메소드의 반환값이 HTTP response body에 바인딩
	public Map<String, Object> udtSpeedComment(Model model, HttpServletRequest request) {	
		logger.info("======= udtSpeedComment_AJAX =======");
		
		//===============================================
	    //	결과 맵 생성
	    //===============================================
	    Map<String,Object> resultMap = new HashMap<String,Object>();

	    //===============================================
	    //	파라미터 체크
	    //===============================================
	    Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

	    //===============================================
	    //	권한체크
	    //===============================================
	    //TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
	    //TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
	    
	    
        //===============================================
        //	비즈니스 로직
        //===============================================
        try {
        	sqlSession.update("RptAlarmMapper.udtSpeedComment",paramMap);
            resultMap.put("result", "0000");
//            resultMap.put("retData", paramMap);
        } catch (Exception e){
            resultMap.put("result","1010");
            e.printStackTrace();
        }

        return resultMap; 
	}
		
	
	
	/*
	*********************************************************
	* Method ID		: speedMngListExcelDown
	* Method Name	: speedMngListExcelDown
	* Description	: speedMngListExcelDown
	* Author		: lds
	* Date			: 2017.09.13
	*********************************************************
	*/
	@RequestMapping(value = "speedMngListExcelDown") 
	public String speedMngListExcelDown(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {	
		logger.info("======= speedMngListExcelDown =======");
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
	    
        HashMap<String,Object> returnMap = speedSuim.SuimSpeedList(paramMap,"excel");

        String menuFlag = String.valueOf( paramMap.get("flag") );
        String fileNameUser = "";
        
        switch( menuFlag ){
        	case "user" : fileNameUser = mbrVo.getUser_name(); break;
        	case "team" : fileNameUser = mbrVo.getTeam_name(); break;
        	case "admin" : fileNameUser = "관리자"; break;
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

		
        String fileName = fileNameUser+"_보고서알림_"+year+month+date+".xls";
		
		try {
			fileName = java.net.URLEncoder.encode(fileName,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		
		response.setHeader("Content-Disposition", "attachment;filename="+fileName);
		response.setHeader("Content-Type", "application/vnd.ms-xls");
		response.setHeader("Content-Description", "JSP Generated Data");
		response.setHeader("Content-Transfer-Encoding", "binary");
		
		model.addAttribute("speedList",returnMap.get("speedList"));
		
		model.addAttribute("srchParam",paramMap);
		
		return "top_rpt_alarm/speed_mng_list_excel";
	}
	
	
	
	private Map<String,Object> paramNull2Blank(Map<String,Object> paramMap){
		
		
		String suimStartDate = StringUtil.null2blank( (String) paramMap.get("suimStartDate") );
		String suimEndDate = StringUtil.null2blank( (String) paramMap.get("suimEndDate") );
		String alarmStartDate = StringUtil.null2blank( (String) paramMap.get("alarmStartDate") );
		String alarmEndDate = StringUtil.null2blank( (String) paramMap.get("alarmEndDate") );
		String speedType = StringUtil.null2blank( (String) paramMap.get("speedType") );
		String rptState = StringUtil.null2blank( (String) paramMap.get("rptState") );
		String srchAcceptNo = StringUtil.null2blank( (String) paramMap.get("srchAcceptNo") );
		String srchAccidentNo = StringUtil.null2blank( (String) paramMap.get("srchAccidentNo") );
		String srchPolicyNo = StringUtil.null2blank( (String) paramMap.get("srchPolicyNo") );
		String srchUserNm = StringUtil.null2blank( (String) paramMap.get("srchUserNm") );
		String srchPolicyNm = StringUtil.null2blank( (String) paramMap.get("srchPolicyNm") );
		String srchAlarm = StringUtil.null2blank( (String) paramMap.get("srchAlarm") );
		String srchMemo = StringUtil.null2blank( (String) paramMap.get("srchMemo") );
		String srchTmId = StringUtil.null2blank( (String) paramMap.get("srchTmId") );
		
		
        if ("".equals(suimStartDate)) paramMap.put("suimStartDate", suimStartDate);
        if ("".equals(suimEndDate)) paramMap.put("suimEndDate", suimEndDate);
        if ("".equals(alarmStartDate)) paramMap.put("alarmStartDate", alarmStartDate);
        if ("".equals(alarmEndDate)) paramMap.put("alarmEndDate", alarmEndDate);
        if ("".equals(speedType)) paramMap.put("speedType", speedType);
        if ("".equals(rptState)) paramMap.put("rptState", rptState);
        if ("".equals(srchAcceptNo)) paramMap.put("srchAcceptNo", srchAcceptNo);
        if ("".equals(srchAccidentNo)) paramMap.put("srchAccidentNo", srchAccidentNo);
        if ("".equals(srchPolicyNo)) paramMap.put("srchPolicyNo", srchPolicyNo);
        if ("".equals(srchUserNm)) paramMap.put("srchUserNm", srchUserNm);
        if ("".equals(srchPolicyNm)) paramMap.put("srchPolicyNm", srchPolicyNm);
        if ("".equals(srchAlarm)) paramMap.put("srchAlarm", srchAlarm);
        if ("".equals(srchMemo)) paramMap.put("srchMemo", srchMemo);
        if ("".equals(srchTmId)) paramMap.put("srchTmId", srchTmId);
        
        
		return paramMap;
	}
	
	
	
	
	
}
