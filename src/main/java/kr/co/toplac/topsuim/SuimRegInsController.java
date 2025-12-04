package kr.co.toplac.topsuim;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import kr.co.toplac.cmm.service.CodeDicService;
import kr.co.toplac.sysadm.SysAdmCodeDicVO;
import kr.co.toplac.topgeneral.TopPtnrMbrBscVO;
import kr.co.toplac.topptnr.TopPtnrBscVO;
import kr.co.toplac.topptnr.TopPtnrDeptBscVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;
import kr.co.toplac.util.etc.Damo;

@Controller
public class SuimRegInsController {
	
private static final Logger logger = LoggerFactory.getLogger(SuimRegInsController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private CodeDicService CodeDicService; 
	
	/*
	 * ***************************************
	 * Method ID : topSuimPage
	 * Method Name :  topSuimPage
	 * Description : 보고서 수임 등록 메인 화면 호출
	 * 
	 * 번호 1 :  
	 * Author : 이선형
	 * Date : 20160503
	 * ***************************************
	 * */
	@RequestMapping(value = "topSuimPage", method = RequestMethod.GET)
	public String topSuimPage(Model model, HttpSession session) {
		
		logger.info("topSuimPage");
		
		/*세션 검사*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		/* 탑 팀목록 추출*/
		List<TopTmBscVO> topTeamList = sqlSession.selectList("SuimRegInsMapper.topTeamList");
		model.addAttribute("topTeamList", topTeamList);
		
		/*보험사 목록 추출*/
		List<TopPtnrBscVO> ptnrList = sqlSession.selectList("SuimRegInsMapper.ptnrList");
		model.addAttribute("ptnrList", ptnrList);
		
		/*검색 화면 초기에 목록화 할  수임건 추출*/
		List<TopRptHeadVO> suimBookList = sqlSession.selectList("SuimRegInsMapper.getSuimBookList");
		model.addAttribute("suimBookList", suimBookList);
		
		
		//기준업무량 년도 분리 20181204 김두현차장님 요청
		//12월 15일은 다음해로 처리
		Calendar cal = Calendar.getInstance();    
		cal.setTime(new Date());    		
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
		String today = df.format(cal.getTime());
//		String today = "2018-12-16";
		
		
		int year = Integer.parseInt(today.split("-")[0]);
		int month = Integer.parseInt(today.split("-")[1]);
		int day = Integer.parseInt(today.split("-")[2]);
		
		if (month == 12 && day > 15){
			++year;
		}
		//기준 업무량 코드 
        SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();
        codeVo.setTbl_nm("top_rpt_head");
        codeVo.setCol_nm("workload_type_"+year);
        List<SysAdmCodeDicVO> workloadTypeList = CodeDicService.codeList2(codeVo);
        model.addAttribute("workloadTypeList", workloadTypeList);
        
		
		return "top_suim/suim_main_ins";
	}
	
	/*
	 * ***************************************
	 * Method ID : topMbrForSelectedTeam
	 * Method Name :  topMbrForSelectedTeam
	 * Description : 보고서 수임 등록 탑팀 선택시 직원 목록 호출
	 * 
	 * 번호 1 :  
	 * Author : 이선형
	 * Date : 20160504
	 * ***************************************
	 * */
	@RequestMapping(value = "topMbrForSelectedTeam", method = RequestMethod.POST)
	public void topMbrForSelectedTeam(Model model, HttpSession session, String team_id, HttpServletResponse response) {

		logger.info("topMbrForSelectedTeam");

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");

		PrintWriter out = null;

		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		/*해당 팀의 인원 추출*/
		List<TopMbrBscVO>  mbrList = sqlSession.selectList("SuimRegInsMapper.getThisTeamMbr",team_id);

		JSONArray arr = new JSONArray();
		for(int i=0; i < mbrList.size(); i++){

			TopMbrBscVO mbrVo = mbrList.get(i);
			
			JSONObject obj = new JSONObject();

			obj.put("user_no", mbrVo.getUser_no());
			obj.put("user_name", mbrVo.getUser_name());
			obj.put("team_id", mbrVo.getTeam_id_main());
			
			
			arr.add(obj);
		}

		String jsonStr = arr.toString();
		out.print(jsonStr);
		out.close();
	}
	
	@RequestMapping(value = "getAcceptNoInfoByAcc", method = RequestMethod.POST,  produces="application/text; charset=utf8")
	@ResponseBody
	public String getAcceptNoInfoByAcc(Model model, HttpSession session, String ptnr_id, HttpServletResponse response, HttpServletRequest request) {
		
		String sAcceptNo = "";
		
		logger.info("======= getAcceptNoInfoByAcc =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sSuimRptType1 = String.valueOf(paramMap.get("suim_rpt_type1"));
				
		if( "5".equals(sSuimRptType1) ) {				//농작물인경우
			sAcceptNo = sqlSession.selectOne("SuimRegInsMapper.selectPrimAcceptNoByPolicyNo",paramMap);
		}else{													//기본보고서 체크
			sAcceptNo = sqlSession.selectOne("SuimRegInsMapper.selectAcceptNoByPolicyNo",paramMap);
		}
		
		return sAcceptNo;		
	}
	
	@RequestMapping(value = "getPeriodFlagInfo", method = RequestMethod.POST,  produces="application/text; charset=utf8")
	@ResponseBody
	public String getPeriodFlagInfo(Model model, HttpSession session, String ptnr_id, HttpServletResponse response, HttpServletRequest request) {
		
		logger.info("======= getPeriodFlagInfo =======");
		
		String resultVal = "";		
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);		
		
		//보험사 계약기간 설정값 가져오기
		int nChk = 0;
		
		String sPeriodFlag = String.valueOf(paramMap.get("period_flag"));
		
		nChk = sqlSession.selectOne("SuimRegInsMapper.getPeriodFlagInfoCount", paramMap);
		
		if( nChk == 0 ) {
			resultVal += "<input type='radio' name='periodFlag' id='periodFlag0' value='0' checked /> 없음";
			resultVal += "<input type='hidden' name='periodFlagChk' id='periodFlagChk' value='0'/>";
		}else{
			
			if( "1".equals(sPeriodFlag) ) {
				resultVal += "<input type='radio' name='periodFlag' id='periodFlag0' value='0' /> 없음 ";
				resultVal += "<input type='radio' name='periodFlag' id='periodFlag1' value='1' checked /> 장기 ";
				resultVal += "<input type='radio' name='periodFlag' id='periodFlag2' value='2' /> 일반 ";
				resultVal += "<input type='hidden' name='periodFlagChk' id='periodFlagChk' value='1'/>";
			}else if( "2".equals(sPeriodFlag) ) {
				resultVal += "<input type='radio' name='periodFlag' id='periodFlag0' value='0' /> 없음 ";
				resultVal += "<input type='radio' name='periodFlag' id='periodFlag1' value='1' /> 장기 ";
				resultVal += "<input type='radio' name='periodFlag' id='periodFlag2' value='2' checked /> 일반 ";
				resultVal += "<input type='hidden' name='periodFlagChk' id='periodFlagChk' value='1'/>";
			}else {
				resultVal += "<input type='radio' name='periodFlag' id='periodFlag0' value='0' checked /> 없음 ";
				resultVal += "<input type='radio' name='periodFlag' id='periodFlag1' value='1' /> 장기 ";
				resultVal += "<input type='radio' name='periodFlag' id='periodFlag2' value='2' /> 일반 ";
				resultVal += "<input type='hidden' name='periodFlagChk' id='periodFlagChk' value='1'/>";
			}			
		}		
        return resultVal; 
	}

	/**
	 * 보험사 세부 구분사항 가져오기
	 * @param model
	 * @param session
	 * @param ptnr_id
	 * @param suimGubun
	 * @param response
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "getPtnrIdSubInfo", method = RequestMethod.POST,  produces="application/text; charset=utf8")
	@ResponseBody
	public String getPtnrIdSubInfo(Model model, HttpSession session, String ptnr_id, HttpServletResponse response, HttpServletRequest request) {
		
		logger.info("======= getPtnrIdSubInfo =======");
		
		String resultVal = "";		
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		paramMap.put("tbl_nm", "top_rpt_head");
		paramMap.put("col_nm","ptnr_id_sub");
		paramMap.put("col_cd1", ptnr_id);
		
		//보험사 세부코드 불러오기
		List<Map<String,Object>> ptnrIdSub = sqlSession.selectList("SuimRegInsMapper.getPtnrIdSubInfo", paramMap);
		
		int col_cd2 = 0;
		String col_val = "";
		
		if( ptnrIdSub.size() > 1 ) {		//세부코드가 2개 이상 인 경우
			
			for( int i=0; i < ptnrIdSub.size(); i++) {
				col_cd2 = Math.round((Float)ptnrIdSub.get(i).get("col_cd2"));
				col_val = String.valueOf(ptnrIdSub.get(i).get("col_val"));
				if( i == 0 ) {
					resultVal += "<input type='radio' name='ptnrIdSub' id='ptnrIdSub'"+col_cd2+" value='"+col_cd2+"' checked onclick='fnClickPtnrSub();' /> "+col_val;
				}else {
					resultVal += "&nbsp;<input type='radio' name='ptnrIdSub' id='ptnrIdSub'"+col_cd2+" value='"+col_cd2+"' onclick='fnClickPtnrSub();' /> "+col_val;
				}				
			}
			
		}else{									//세부코드가 1개이거나 없는경우
			resultVal = "<input type='radio' name='ptnrIdSub' id='ptnrIdSub0' value='0' checked /> 본체";
		}
		
        return resultVal; 
	}
	
	/*
	 * ***************************************
	 * Method ID : getPtnrMbrInfo
	 * Method Name :  getPtnrMbrInfo
	 * Description : 보험사 선택시 보험사 직원 정보 SELECT - AJAX
	 * Author : 임대성
	 * Modifier : 
	 * Date : 20170717
	 * ***************************************
	 * */
	@RequestMapping(value = "getPtnrMbrInfo", method = RequestMethod.POST)
	@ResponseBody //해당 메소드의 반환값이 HTTP response body에 바인딩
	public Map<String, Object> getPtnrMbrInfo(Model model, HttpSession session, String ptnr_id, String suimGubun, HttpServletResponse response, HttpServletRequest request) {
		logger.info("======= getPtnrMbrInfo_AJAX =======");
		
		//===============================================
	    //	결과 맵 생성
	    //===============================================
		Map<String,Object> resultMap = new HashMap<String,Object>();

		//===============================================
	    //	보험사 직원 목록 호출
	    //===============================================
		Map<String,Object> paramMap = new HashMap<String,Object>();
		
		List<String> list = new ArrayList<String>();
		//서면심사이면서, 보험사가 메리츠 일 경우
		if ( suimGubun.equals("14") && "16".equals(ptnr_id) ){
			String[] ptnrMbrNo = request.getParameterValues("ptnrMbrNo[]");
			for(int i=0 ; i < ptnrMbrNo.length ; i++){
				list.add(ptnrMbrNo[i]);
			}
		}
		
		paramMap.put("ptnrId",ptnr_id);
		paramMap.put("ptnrMbrNo", list);
		
		
		List<TopPtnrMbrBscVO> ptnrMbrInfo = sqlSession.selectList("SuimRegInsMapper.getPtnrMbrInfo",paramMap);
		resultMap.put("list", ptnrMbrInfo);
		
		
        //===============================================
        //	비즈니스 로직
        //===============================================
        try {
//        	resultMap.put("resultData", 0000);
        } catch (Exception e){
//        	resultMap.put("resultData", 1111);
            e.printStackTrace();
        }

        return resultMap; 
	}	
	
	
	/*
	 * ***************************************
	 * Method ID : topPtnrMbrForSelectedDept
	 * Method Name :  topPtnrMbrForSelectedDept
	 * Description : 보험사 선택시 보험사 담당자 setting - AJAX - 170801 로직변경으로 인해 미사용
	 * 
	 * 번호 1 :  
	 * Author : 이선형
	 * Modifier : 임대성
	 * Date : 20160504
	 * MOD Date : 20161124
	 * ***************************************
	 * */
	@RequestMapping(value = "topPtnrMbrForSelectedDept", method = RequestMethod.POST)
	public void topPtnrMbrForSelectedDept(Model model, HttpSession session, String ptnr_id, HttpServletResponse response) {
	
		logger.info("topPtnrMbrForSelectedDept");
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		
		PrintWriter out = null;
		
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		/*해당 팀의 인원 추출*/
		List<TopPtnrMbrBscVO>  depMemtList = sqlSession.selectList("SuimRegInsMapper.getThisDeptMbr",ptnr_id);
		
		JSONArray arr = new JSONArray();
		for(int i=0; i < depMemtList.size(); i++){
			
			TopPtnrMbrBscVO deptMemVo = depMemtList.get(i);
			
			JSONObject obj = new JSONObject();
			obj.put("ptnr_mbr_no", deptMemVo.getPtnr_mbr_no());
			obj.put("ptnr_mbr_nm", deptMemVo.getPtnr_mbr_nm());

			arr.add(obj);
		}
		
		String jsonStr = arr.toString();
		out.print(jsonStr);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : topPtnrDeptForSelectedPtnr
	 * Method Name :  topPtnrDeptForSelectedPtnr
	 * Description : 보험사 담당자 선택 시, 담당부서 setting - AJAX
	 * 
	 * 번호 1 :  
	 * Author : 이선형
	 * Modifier : 임대성
	 * Date : 20160504
	 * MOD Date : 20161124
	 * ***************************************
	 * */
	@RequestMapping(value = "topPtnrDeptForSelectedPtnr", method = RequestMethod.POST)
	public void topPtnrDeptForSelectedPtnr(Model model, HttpSession session, String ptnr_mbr_no, HttpServletResponse response) {

		logger.info("topPtnrDeptForSelectedPtnr");
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		
		PrintWriter out = null;
		
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		/*해당 팀의 인원 추출*/
		TopPtnrDeptBscVO deptList = sqlSession.selectOne("SuimRegInsMapper.getThisDept", ptnr_mbr_no);
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
			
		obj.put("ptnr_dept_nm", deptList.getPtnr_dept_nm());
		obj.put("ptnr_dept_id", deptList.getPtnr_dept_id());
		if (deptList.getPtnr_tm2_nm() != null && !deptList.getPtnr_tm2_nm().equals("")){
			obj.put("ptnr_tm2_nm", deptList.getPtnr_tm2_nm());
		}
		arr.add(obj);
		
		String jsonStr = arr.toString();
		out.print(jsonStr);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : searchSuimReg
	 * Method Name :  searchSuimReg
	 * Description : 보고서 수임 등록 탑팀 선택시 직원 목록 호출
	 * 
	 * 번호 1 :  
	 * Author : 이선형
	 * Date : 20160509
	 * ***************************************
	 * */
	@RequestMapping(value = "searchSuimReg", method = RequestMethod.POST)
	public void searchSuimReg(Model model, HttpSession session, String accept_no, HttpServletResponse response) {
	
		logger.info("searchSuimReg");
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		
		PrintWriter out = null;
		
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		/*검색 화면 초기에 목록화 할  수임건 추출*/
		List<TopRptHeadVO> srcSuimBookList = sqlSession.selectList("SuimRegInsMapper.getSearchSuimBookList",accept_no);
		
		JSONArray arr = new JSONArray();
		for(int i=0; i < srcSuimBookList.size(); i++){
			
			TopRptHeadVO srcSuimVo = srcSuimBookList.get(i);
			
			JSONObject obj = new JSONObject();
			
			obj.put("ROWNUM", srcSuimVo.getROWNUM());
			obj.put("ptnr_mbr_nm", srcSuimVo.getPtnr_mbr_nm());
			obj.put("ptnr_nick", srcSuimVo.getPtnr_nick());
			obj.put("accept_no", srcSuimVo.getSuim_accept_no());
			obj.put("suim_rpt_type1_nm", srcSuimVo.getSuim_rpt_type1_nm());
			obj.put("suim_rpt_type1", srcSuimVo.getSuim_rpt_type1());
			obj.put("team_name", srcSuimVo.getTeam_name());
			obj.put("accident_date", srcSuimVo.getAccident_date_fmt());
			obj.put("reg_date", srcSuimVo.getReg_date_fmt());
			obj.put("ptnr_dept_nm", srcSuimVo.getPtnr_dept_nm());
			obj.put("rpt_no", srcSuimVo.getSuim_rpt_no());
			obj.put("teamId", srcSuimVo.getTeam_id());
			obj.put("userNo", srcSuimVo.getUser_no());
			obj.put("ptnrId", srcSuimVo.getPtnr_id());
			obj.put("ptnrDeptId", srcSuimVo.getPtnr_dept_id());
			obj.put("ptnrMbrId", srcSuimVo.getPtnr_mbr_no());

			arr.add(obj);
		}
		
		String jsonStr = arr.toString();
		out.print(jsonStr);
		out.close();
	}
	
	/**
	 * 계약자와 사고일자로 보고서 중복등록여부 체크
	 * @param model
	 * @param session
	 * @param accNo
	 * @param response
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "checkConNmAccDateForHead", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> checkConNmAccDateForHead(Model model, HttpSession session, HttpServletResponse response, HttpServletRequest request) {
		
		logger.info("======= checkConNmAccDateForHead =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		int resultCnt = 0;
		String sSuimAccNo = "";
		String sMsg = "";
		
		//계약자와 사고일자로 보고서 갯수 체크
		resultCnt = sqlSession.selectOne("SuimRegInsMapper.policyNmAccDateForHeadCnt", paramMap);
				
		//1개 이상일때 접수번호를 가져온다.
		if( resultCnt > 0 ){
			sSuimAccNo = sqlSession.selectOne("SuimRegInsMapper.policyNmAccDateForHeadAccNo", paramMap);
			
			if( resultCnt == 1 ) {
				sMsg = "이미 동일 사고일자 접수건 (접수번호 : "+sSuimAccNo+")이 존재합니다.";
			}else{
				resultCnt--;			//1개 감소
				sMsg = "이미 동일 사고일자 접수건 (접수번호 : "+sSuimAccNo+")외 "+resultCnt+"건이 존재합니다.";
			}			
			resultMap.put("msg", sMsg);
		}else{
			resultMap.put("msg", sMsg);
		}		
		
		return resultMap;
		
	}
	
	/**
	 * 일반 보고서 사고번호 중복 체크, 다수의 보고서 체크방식으로 개선
	 * @param accNo
	 * @param out
	 */	
	@RequestMapping(value = "checkAccNoForHeadIns", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> checkAccNoForHeadIns(Model model, HttpSession session, String accNo, HttpServletResponse response, HttpServletRequest request) {
		
		logger.info("======= checkAccNoForHeadIns =======");
		
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		int resultCnt = 0;
		String sSuimAccNo = "";
		String sMsg = "";
		
		//동일 사고번호의 보고서 갯수 체크		
		resultCnt = sqlSession.selectOne("SuimRegInsMapper.existAccNoForHeadInsCnt", accNo);
		
		//1개 이상일때 접수번호를 가져온다.
		if( resultCnt > 0 ){
			sSuimAccNo = sqlSession.selectOne("SuimRegInsMapper.existAccNoForHeadIns", accNo);
			
			if( resultCnt == 1 ) {
				sMsg = "이미 동일 사고번호 접수건 (접수번호 : "+sSuimAccNo+")이 존재합니다.";
			}else{
				resultCnt--;			//1개 감소
				sMsg = "이미 동일 사고번호 접수건 (접수번호 : "+sSuimAccNo+")외 "+resultCnt+"건이 존재합니다.";
			}			
			resultMap.put("msg", sMsg);
		}else{
			resultMap.put("msg", sMsg);
		}
		return resultMap;		
	}
	
	/*
	 * ***************************************
	 * Method ID : checkAccNoForSpeedIns
	 * Method Name :  checkAccNoForSpeedIns
	 * Description : 스피드 접수/종결 등록 시 사고번호 중복 조회
	 * 
	 * 번호 1 :  
	 * Author : 이선형
	 * Date : 20160715
	 * ***************************************
	 * */
	@RequestMapping(value = "checkAccNoForSpeedIns", method = RequestMethod.POST)
	public void checkAccNoForSpeedIns(String accNo, PrintWriter out) {
	
		logger.info("checkAccNoForSpeedIns");

		/*검색 화면 초기에 목록화 할  수임건 추출*/
		int result = sqlSession.selectOne("SuimRegInsMapper.existAccNoForSpeedIns", accNo);	

		out.print(result);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : suimAdd
	 * Method Name :  suimAdd
	 * Description : 수임 등록 
	 * 번호 1 : 수임 head 데이터 입력
	 * 번호 2 : 수임 body 데이터 입력
	 * 번호 3 : 인보이스 생성
	 * 번호 4 : 수임 로그 입력 - 20160623
	 * Author : 이선형
	 * Date : 20160504
	 * ***************************************
	 * */
	@RequestMapping(value = "suimAdd", method = RequestMethod.POST)
	public String suimAdd(Model model, HttpSession session, SuimRegInsViewVO suimInsViewVo, HttpServletResponse response, HttpServletRequest request, String popSuimDtl) {
		
		logger.info("suimAdd");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		//===============================================
        //	파라미터 체크
    	//===============================================		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
		//로그VO 생성
		SuimLogVO logVo = new SuimLogVO();
		
		//보험사 세부코드 추가
		if( suimInsViewVo.getPtnrIdSub() == null ) {
			suimInsViewVo.setPtnrIdSub("0");
		}else{
			suimInsViewVo.setPtnrIdSub(suimInsViewVo.getPtnrIdSub());
		}
		
		//보험사 계약기간 코드 추가
		if( suimInsViewVo.getPeriodFlag() == null ) {
			suimInsViewVo.setPeriodFlag("0");
		}else{
			suimInsViewVo.setPeriodFlag(suimInsViewVo.getPeriodFlag());
		}
		
		//수임등록자 추가 by top3009
		suimInsViewVo.setRegistrant(mbrVo.getUser_no());
		
		suimInsViewVo.setPendncyTrgetAt(suimInsViewVo.getPendncyTrgetAt());
		
		suimInsViewVo.setSuimRptType1( suimInsViewVo.getGubun_rpt1() );
		suimInsViewVo.setSuimRptType2( suimInsViewVo.getGubun_rpt2() );
		
		suimInsViewVo.setTeamId( suimInsViewVo.getTopTeamId() );
		suimInsViewVo.setUserNo( suimInsViewVo.getTopMbr() );
		
//		,teamId           		:$("#topTeamId option:selected").val() // 탑 팀
//		,userNo           		:$("#topMbr option:selected").val()  // 탑 직원
		
		suimInsViewVo.setPtnrId( suimInsViewVo.getPtnrId() );
		suimInsViewVo.setPtnrDeptId( suimInsViewVo.getPtnrDeptId() );
		suimInsViewVo.setPtnrMbrNo( suimInsViewVo.getPtnrDeptMbr() );
		
		
		suimInsViewVo.setPolicyholderNm( suimInsViewVo.getConName() );
		suimInsViewVo.setBeneficiaryNm( suimInsViewVo.getInsName() );
		suimInsViewVo.setDamagedNm( suimInsViewVo.getInsItem() );
		
		suimInsViewVo.setAccidentDate( suimInsViewVo.getSago_time() );
		suimInsViewVo.setRegDate( suimInsViewVo.getSuim_time() );
		suimInsViewVo.setAccidentNo( suimInsViewVo.getAccNo() );
		suimInsViewVo.setPolicyNo( suimInsViewVo.getConNo() );
		suimInsViewVo.setInsuranceNm( suimInsViewVo.getAccType() );
		
		if( !suimInsViewVo.getConPhone1().equals("") || !suimInsViewVo.getConPhone2().equals("") || !suimInsViewVo.getConPhone3().equals("")){
			suimInsViewVo.setPolicyholderTel( suimInsViewVo.getConPhone1() +"-"+ suimInsViewVo.getConPhone2()  +"-"+  suimInsViewVo.getConPhone3() );
		}
		
		if( !suimInsViewVo.getInsPhone1().equals("") || !suimInsViewVo.getInsPhone2().equals("") || !suimInsViewVo.getInsPhone3().equals("")){
			suimInsViewVo.setBeneficiaryTel( suimInsViewVo.getInsPhone1() +"-"+ suimInsViewVo.getInsPhone2()  +"-"+  suimInsViewVo.getInsPhone3() );
		}
		
		if( !suimInsViewVo.getInsItemPhone1().equals("") || !suimInsViewVo.getInsItemPhone2().equals("") || !suimInsViewVo.getInsItemPhone3().equals("")){
			suimInsViewVo.setDamagedTel( suimInsViewVo.getInsItemPhone1() +"-"+ suimInsViewVo.getInsItemPhone2()  +"-"+  suimInsViewVo.getInsItemPhone3() );
		}		
		
		suimInsViewVo.setAccidentFacts( suimInsViewVo.getAccContent() );
		suimInsViewVo.setInvestigatePostcode( suimInsViewVo.getPostcode1() );

		suimInsViewVo.setInvestigateAddr2( suimInsViewVo.getAddr_1st_1() );
		
        //2017.05.25 khs 등록시 추정손해액 삭제
		//suimInsViewVo.setDamagedAmtEstimated( suimInsViewVo.getEstLoss().replaceAll(",", "") );
		//suimInsViewVo.setCommissionEstimated( suimInsViewVo.getEstFee().replaceAll(",", "") );
		
		suimInsViewVo.setSuimRptType1Close12( suimInsViewVo.getSuimRptType1Close12() );
		
		suimInsViewVo.setReportEa( suimInsViewVo.getReportEa() );
		suimInsViewVo.setAmtInsuPayment( suimInsViewVo.getAmtInsuPayment() );
		suimInsViewVo.setAmtBasic( suimInsViewVo.getAmtBasic() );
		suimInsViewVo.setSpeedType( suimInsViewVo.getSpeed_type() );
		
		if ( "null".equals(  String.valueOf(paramMap.get("workload_type")) ) ){
			suimInsViewVo.setWorkloadType("0");
			logVo.setWorkloadType("0");
			suimInsViewVo.setWorkloadEa("0");
			logVo.setWorkloadEa("0");
		}else{
			suimInsViewVo.setWorkloadType( (String) paramMap.get("workload_type") );
			logVo.setWorkloadType( (String) paramMap.get("workload_type") );
			suimInsViewVo.setWorkloadEa( (String) paramMap.get("workload_ea") );
			logVo.setWorkloadEa( (String) paramMap.get("workload_ea") );
		}
		
		
//		suimRptType1         	:$("input:radio[name='gubun_rpt1']:checked").val() //수임종류
//		,suimRptType2         	:$("input:radio[name='gubun_rpt2']:checked").val() //보고서 종류
//		,teamId           		:$("#topTeamId option:selected").val() // 탑 팀
//		,userNo           		:$("#topMbr option:selected").val()  // 탑 직원
//		,ptnrId       			:$("#ptnrId option:selected").val()  // 보험사 id
//		,ptnrDeptId    			:$("#ptnrDeptId").val() //보험사 부서 id
		
//		,ptnrMbrNo     			:$("#ptnrDeptMbr option:selected").val() // 보험사 직원 id
//		,policyholderNm 		:$("#conName").val() // 계약자 이름
//		,beneficiaryNm      	:$("#insName").val() // 피보험자 이름
//		,damagedNm        		:$("#insItem").val() // 피해자 / 물
//		,accidentDate    		:$("#sago_time").val() // 사고일
//		,regDate    			:$("#suim_time").val() // 수임일
//		,accidentNo  			:$("#accNo").val() // 사고번호
//		,policyNo   			:$("#conNo").val() // 증권번호
//		,insuranceNm   			:$("#accType").val() // 보험 종목
//		,policyholderTel   		:$("#conPhone1").val()+"-"+$("#conPhone2").val()+"-"+$("#conPhone3").val() //계약자 폰
//		,beneficiaryTel   		:$("#insPhone1").val()+"-"+$("#insPhone2").val()+"-"+$("#insPhone3").val() // 피보험자 폰
//		,damagedTel 			:$("#insItemPhone1").val()+"-"+$("#insItemPhone2").val()+"-"+$("#insItemPhone3").val() // 물 폰
//		,accidentFacts 			:$("#accContent").val() // 사고 내용
//		,investigatePostcode 	:$("#postcode1").val() // 조사지역 우편번호
//		,investigateAddr1 		:$("#addr_1st").val() // 조사지역 주소1
//		,investigateAddr2 		:$("#addr_1st_1").val() //조사지역 주소2
//		,damagedAmtEstimated    :removeCommaFunc($("#estLoss").val()) // 추정 손해액 
//		,commissionEstimated 	:removeCommaFunc($("#estFee").val())  // 추정 수수료
//		,suimRptType1Close12	:$("#suimRptType1Close12 option:selected").val() // 스피드 심사일 : 종결구분
//		,reportEa				:$("#reportEa").val() //스피드심사 : 평가건수
//		,amtInsuPayment			:$("#amtInsuPayment").val() //스피드심사 : 지급 보험금
//		,amtBasic				:$("#amtBasic").val() //스피드심사 : 청구수수료 = 기본보수
//		,speedType				:$("input:radio[name='speed_type']:checked").val()
		
		String team_id = suimInsViewVo.getTeamId();
		String suimCode = "";
		
		boolean speedChk = suimInsViewVo.getSuimRptType1().equals("14");	
		/*수임 코드*/
		if(!suimInsViewVo.getSuimRptType1().equals("5")){
			/*해당 팀의 수임코드*/
			//서면심사 코드 변경으로 인해 수정 by top3009
			if(suimInsViewVo.getSuimRptType1().equals("14") || suimInsViewVo.getSuimRptType1().equals("15") || suimInsViewVo.getSuimRptType1().equals("16") || suimInsViewVo.getSuimRptType1().equals("17")){
				suimCode = "TL";
			}else{
				suimCode = sqlSession.selectOne("SuimRegInsMapper.getScode",team_id );		
			}
		}else{
			/*농작물의 경우 고정된 수임코드를 입력함 : TLETC*/
			suimCode = "TLETC";
		}
		
		/*날짜 계산*/
		Calendar cal = Calendar.getInstance();    
		cal.setTime(new Date());    
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
		String suimDay = df.format(cal.getTime());  
		
		/*접수번호 앞자리의 연도 YY + 월 MM*/
		String suimYear = suimDay.substring(2, 4);
		String suimMonth = suimDay.substring(5, 7);
		
		String thisSuimCodeFront = "";
		String maxSuimNo = "";
		
/* //notUse-2016.11.02.rjh
		if(!suimInsViewVo.getSuimRptType1().equals("5")){
			thisSuimCodeFront = suimCode+suimYear+suimMonth;			
			//입력될 보고서의 접수번호 뒷자리 = 보고서 현재 '접수번호 앞자리' 로 검색되는 보고서의 총 개수 +1
			maxSuimNo = sqlSession.selectOne("SuimRegInsMapper.getMaxNo", thisSuimCodeFront);
		}else{
			//농작물 접수번호 뒷자리
			thisSuimCodeFront = "TLETC"+suimYear;
			maxSuimNo = sqlSession.selectOne("SuimRegInsMapper.getMaxNoForNsc", thisSuimCodeFront);
		}
		if(maxSuimNo == null || maxSuimNo.equals("")){
			maxSuimNo = "0001";
		}else{
			//접수번호 뒷자리 만들기
			maxSuimNo = SuimRegInsController.makeFourNumberWithZero(maxSuimNo);
		}
*/
		HashMap<String, String> mapForAcceptSeqNo = new HashMap<String, String>();
		mapForAcceptSeqNo.put("suim_accept_seq_no", "");
		if(!suimInsViewVo.getSuimRptType1().equals("5")){
			thisSuimCodeFront = suimCode+suimYear+suimMonth;			
			/*입력될 보고서의 접수번호 뒷자리 = 보고서 현재 '접수번호 앞자리' 로 검색되는 보고서의 총 개수 +1*/  
			sqlSession.update("SuimRegInsMapper.getSuimAcceptSeqNo", mapForAcceptSeqNo);
			maxSuimNo = mapForAcceptSeqNo.get("suim_accept_seq_no");
		}else{
			/*농작물 접수번호 뒷자리*/
			thisSuimCodeFront = "TLETC"+suimYear;
			sqlSession.update("SuimRegInsMapper.getPrimbizAcceptSeqNo", mapForAcceptSeqNo);
			maxSuimNo = mapForAcceptSeqNo.get("suim_accept_seq_no");
		}
		/*접수번호 뒷자리 만들기*/
		maxSuimNo = makeFourNumberWithZero(maxSuimNo);

		/*전화번호 빈칸 입력 시 구분자 없애기*/
		/*
		if(!suimInsViewVo.getSuimRptType1().equals("14")){
			if(suimInsViewVo.getDamagedTel().equals("--")){
				suimInsViewVo.setDamagedTel("");
			}
			if(suimInsViewVo.getBeneficiaryTel().equals("--")){
				suimInsViewVo.setBeneficiaryTel("");
			}
			if(suimInsViewVo.getPolicyholderTel().equals("--")){
				suimInsViewVo.setPolicyholderTel("");
			}			
		}
		*/
		
		
		/**** 디아모 암호화 ****/
		Damo damo = new Damo();
		
		/* 농작물의 경우 month 는 제외하고 접수번호 생성 */
		/* 농작물의 경우 사고장소가 암호화 되어 생성 */
		if(!suimInsViewVo.getSuimRptType1().equals("5")){
			suimInsViewVo.setSuimAcceptNo(suimCode+suimYear+suimMonth+"-"+maxSuimNo);		
			if( suimInsViewVo.getAddr_1st() != null && !suimInsViewVo.getAddr_1st().equals("")){
				suimInsViewVo.setInvestigateAddr1( suimInsViewVo.getAddr_1st() );
			}			
		}else{
			suimInsViewVo.setSuimAcceptNo(suimCode+suimYear+"-"+maxSuimNo);
			//농작물은 주소 암호화
			if( suimInsViewVo.getAddr_1st() != null && !suimInsViewVo.getAddr_1st().equals("")){
				suimInsViewVo.setInvestigateAddr1( damo.encodeDamo(suimInsViewVo.getAddr_1st()) );
			}
		}
		
		int resultHead = 0;
		int resultBody = 0;
		int resultInv = 0;
		

		
		if ( suimInsViewVo.getPolicyholderTel() != null && !suimInsViewVo.getPolicyholderTel().equals("") ){
			suimInsViewVo.setPolicyholderTel(damo.encodeDamo(suimInsViewVo.getPolicyholderTel()));
		}
		
		if ( suimInsViewVo.getBeneficiaryTel() != null && !suimInsViewVo.getBeneficiaryTel().equals("") ){
			suimInsViewVo.setBeneficiaryTel(damo.encodeDamo(suimInsViewVo.getBeneficiaryTel()));
		}
		
		if ( suimInsViewVo.getDamagedTel() != null && !suimInsViewVo.getDamagedTel().equals("") ){
			suimInsViewVo.setDamagedTel(damo.encodeDamo(suimInsViewVo.getDamagedTel()));
		}
		
		/*일반 수임건 등록 시작*/
		if(!suimInsViewVo.getSuimRptType1().equals("5")){

			/*번호 1 : 스피드 심사종결, 농작물이 아닌 일반 건들*/
			if(!speedChk){
				resultHead = sqlSession.insert("SuimRegInsMapper.suimInsHead1", suimInsViewVo);
				
				String suim_rpt_no = sqlSession.selectOne("SuimRegInsMapper.getSuimRptNo", suimInsViewVo.getSuimAcceptNo());
				suimInsViewVo.setSuimRptNo(suim_rpt_no);
				model.addAttribute("SuimRptNo",suim_rpt_no);
				
				
				/*추정 손해액, 추정 수수료 미입력시 0 으로 세팅*/
                // 추정 손해액 추정 수수료 삭제로인한 주석처리
				/*
				if(suimInsViewVo.getCommissionEstimated()==null || suimInsViewVo.getCommissionEstimated().equals("")){
					suimInsViewVo.setCommissionEstimated("0");
				}

				if(suimInsViewVo.getDamagedAmtEstimated()==null || suimInsViewVo.getDamagedAmtEstimated().equals("")){
					suimInsViewVo.setDamagedAmtEstimated("0");
				}
                */

                if (suimInsViewVo.getAmtInsuPayment() == null || suimInsViewVo.getAmtInsuPayment().equals("")){
					suimInsViewVo.setAmtInsuPayment("0");
				}

				/*번호 2*/
				resultBody = sqlSession.insert("SuimRegInsMapper.suimInsBody1", suimInsViewVo);
				
				/*번호 3*/
				resultInv = sqlSession.insert("SuimRegInsMapper.suimInsInvoice", suimInsViewVo.getSuimRptNo());							
			}else{
				/*스피드 심사 종결*/
				
				/*
				//======== 스피드 종결 번호==========
				String endCode = sqlSession.selectOne("SuimRegInsMapper.getEcode",team_id );
				String searchStr = endCode+suimYear;
				thisSuimCodeFront = suimCode+suimYear+suimMonth;	
				//입력될 보고서의 접수번호 뒷자리 = 보고서 현재 '접수번호 앞자리' 로 검색되는 보고서의 총 개수 +1  
				sqlSession.update("SuimRegInsMapper.getSuimEndSeqNo", mapForAcceptSeqNo);
				String SpeedClose = mapForAcceptSeqNo.get("suim_close_seq_no2");
				suimInsViewVo.setSuimCloseNo(searchStr+"-"+makeFourNumberWithZero(SpeedClose));
				//======== 스피드 종결 번호==========
				 */
				
				//스피드 원스탑 체크 추가 - 170811, 최중찬대리님 요청 by.lds
				suimInsViewVo.setSpeed_onestop((String) paramMap.get("chkSpeedOnestop"));
				
				resultHead = sqlSession.insert("SuimRegInsMapper.suimInsSpeedHead1", suimInsViewVo);
				
				//selectKey 활용으로 변경 171227, by.lds
				String suim_rpt_no = suimInsViewVo.getSuimRptNo();
				//String suim_rpt_no = sqlSession.selectOne("SuimRegInsMapper.getSuimRptNo", suimInsViewVo.getSuimAcceptNo());
				
				suimInsViewVo.setSuimRptNo(suim_rpt_no);
				model.addAttribute("SuimRptNo",suim_rpt_no);
				
				/*추정 손해액, 추정 수수료 미입력시 0 으로 세팅*/
				/*
                if(suimInsViewVo.getCommissionEstimated()==null || suimInsViewVo.getCommissionEstimated().equals("")){
					suimInsViewVo.setCommissionEstimated("0");
				}
				
				if(suimInsViewVo.getDamagedAmtEstimated()==null || suimInsViewVo.getDamagedAmtEstimated().equals("")){
					suimInsViewVo.setDamagedAmtEstimated("0");
					
				}
				*/

				if (suimInsViewVo.getAmtInsuPayment() == null || suimInsViewVo.getAmtInsuPayment().equals("")){
					suimInsViewVo.setAmtInsuPayment("0");
				}

				/*번호 2*/
				resultBody = sqlSession.insert("SuimRegInsMapper.suimInsSpeedBody1", suimInsViewVo);
				
				/*번호 3*/
				resultInv = sqlSession.insert("SuimRegInsMapper.suimInsSpeedInvoice", suimInsViewVo);
			}
		}else{
		
		/*농작물 수임건 등록 시작*/
			resultHead = sqlSession.insert("SuimRegInsMapper.suimInsHead1ForNsc", suimInsViewVo);
			
			String suim_rpt_no = sqlSession.selectOne("SuimRegInsMapper.getSuimRptNoForNsc", suimInsViewVo.getSuimAcceptNo());
			suimInsViewVo.setSuimRptNo(suim_rpt_no);
			model.addAttribute("SuimRptNo",suim_rpt_no);
			
			/*추정 손해액, 추정 수수료 미입력시 0 으로 세팅*/
			/*
            if(suimInsViewVo.getCommissionEstimated()==null || suimInsViewVo.getCommissionEstimated().equals("")){
				suimInsViewVo.setCommissionEstimated("0");
			}
			
			if(suimInsViewVo.getDamagedAmtEstimated()==null || suimInsViewVo.getDamagedAmtEstimated().equals("")){
				suimInsViewVo.setDamagedAmtEstimated("0");
			}
			*/
			resultBody = sqlSession.insert("SuimRegInsMapper.suimInsBody1ForNsc", suimInsViewVo);
			
			resultInv = sqlSession.insert("SuimRegInsMapper.suimInsInvoiceForNsc", suimInsViewVo.getSuimRptNo());				
			
		}
		
		logVo.setSuimRptNo(suimInsViewVo.getSuimRptNo());
		logVo.setSuimRptType1(suimInsViewVo.getSuimRptType1());
		
		//서면심사 메뉴분류로인한 수정 by top3009		
		if(suimInsViewVo.getSuimRptType1().equals("14") || suimInsViewVo.getSuimRptType1().equals("15") || suimInsViewVo.getSuimRptType1().equals("16") || suimInsViewVo.getSuimRptType1().equals("17")){
			logVo.setSpeedType(suimInsViewVo.getSpeedType());			
		}else{
			logVo.setSpeedType("0");
		}
		
		/*ip 얻기 시작*/
		HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		String ip = req.getHeader("X-FORWARDED-FOR");
		
		if (ip == null){
			ip = req.getRemoteAddr(); 
		}
		/*ip 얻기 끝*/

		logVo.setRegDate(suimInsViewVo.getRegDate());
		logVo.setSuimRptState("0");
		logVo.setLockFlag("0");;
		logVo.setMinwonFlag("0");
		logVo.setLogIp(ip);
		logVo.setLogUserNo((String)session.getAttribute("user_no_Session"));
		
		//보고서 팀아이디와 최초 담당자지정 by top3009
		logVo.setUser_no( suimInsViewVo.getTopMbr() );
		logVo.setTeam_id( suimInsViewVo.getTopTeamId() );
		
		int resultLog = sqlSession.insert("SuimRegInsMapper.suimInsLog", logVo);
		/*번호 4 끝*/
		
//		int result = 0;
//		
//		if( (resultHead >0) && (resultBody >0) && (resultInv > 0) && (resultLog > 0)){
//			result = 1;
//		}
		
		/* 탑 팀목록 추출*/
		List<TopTmBscVO> topTeamList = sqlSession.selectList("SuimRegInsMapper.topTeamList");
		model.addAttribute("topTeamList", topTeamList);
		
		/*보험사 목록 추출*/
		List<TopPtnrBscVO> ptnrList = sqlSession.selectList("SuimRegInsMapper.ptnrList");
		model.addAttribute("ptnrList", ptnrList);
		
		return "redirect:/topSuimPage";
		
//		out.print(result);
//		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : makeFourNumberWithZero
	 * Method Name :  makeFourNumberWithZero
	 * Description : 0을 포함한 4자리 숫자로 채움
	 * 
	 * 번호 1 :  
	 * Author : 이선형
	 * Date : 20160614
	 * ***************************************
	 * */

	public static String makeFourNumberWithZero(String maxSuimNo) {
		if(maxSuimNo.length() == 1){
			maxSuimNo = "000"+maxSuimNo;
		}else if(maxSuimNo.length() == 2){
			maxSuimNo = "00"+maxSuimNo;
		}else if(maxSuimNo.length() == 3){
			maxSuimNo = "0"+maxSuimNo;
		}
		return maxSuimNo;
	}
	
	
	/*
	 * ***************************************
	 * Method ID : dataFromSearchTab
	 * Method Name :  dataFromSearchTab
	 * Description : 
	 * 
	 * Author : 이선형
	 * Date : 20160510
	 * ***************************************
	 * */
	@RequestMapping(value = "dataFromSearchTab", method = RequestMethod.POST)
	public void dataFromSearchTab(Model model, HttpSession session, String rpt_no, HttpServletResponse response) {
	
		logger.info("dataFromSearchTab");
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		
		PrintWriter out = null;
		
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		/*검색 화면에서 선택한 건 추출*/
		TopRptHeadAndBodyVO srcSuimBookOne = sqlSession.selectOne("SuimRegInsMapper.getSearchSuimOne",rpt_no);
		
		JSONArray arr = new JSONArray();
		
		JSONObject obj = new JSONObject();
		
		obj.put("suimRptType1", srcSuimBookOne.getSuim_rpt_type1());
		obj.put("suimRptType2", srcSuimBookOne.getSuim_rpt_type2());
		obj.put("teamId", srcSuimBookOne.getTeam_id());
		obj.put("userNo", srcSuimBookOne.getUser_no());
		obj.put("ptnrId", srcSuimBookOne.getPtnr_id());
		obj.put("ptnrDeptId", srcSuimBookOne.getPtnr_dept_id());
		obj.put("ptnrMbrNo", srcSuimBookOne.getPtnr_mbr_no());
		obj.put("policyholderNm", srcSuimBookOne.getPolicyholder_nm());
		obj.put("beneficiaryNm", srcSuimBookOne.getBeneficiary_nm());
		obj.put("damagedNm", srcSuimBookOne.getDamaged_nm());
		obj.put("accidentDate", srcSuimBookOne.getAccident_date_fmt());
		obj.put("regDate", srcSuimBookOne.getReg_date_fmt());
		
		obj.put("accidentNo", srcSuimBookOne.getAccident_no());
		obj.put("policyNo", srcSuimBookOne.getPolicy_no());
		obj.put("insuranceNm", srcSuimBookOne.getInsurance_nm());
		obj.put("policyholderTel", StringUtil.null2blank(srcSuimBookOne.getPolicyholder_tel()));
		obj.put("beneficiaryTel", StringUtil.null2blank(srcSuimBookOne.getBeneficiary_tel()));
		obj.put("damagedTel", StringUtil.null2blank(srcSuimBookOne.getDamaged_tel()));
		obj.put("accidentFacts", srcSuimBookOne.getAccident_facts());
		obj.put("investigatePostcode", srcSuimBookOne.getInvestigate_postcode());
		obj.put("investigateAddr1", srcSuimBookOne.getInvestigate_addr1());
		obj.put("investigateAddr2", srcSuimBookOne.getInvestigate_addr2());
		obj.put("damagedAmtEstimated", srcSuimBookOne.getAmt_estimated_damage());
		obj.put("commissionEstimated", srcSuimBookOne.getCommission_estimated());
		
		obj.put("ptnrIdSub", srcSuimBookOne.getPtnr_id_sub());
		obj.put("periodFlag", srcSuimBookOne.getPeriod_flag());

		arr.add(obj);
		
		String jsonStr = arr.toString();
		out.print(jsonStr);
		out.close();
	}
	
	
	/*
	*********************************************************
	* Program ID	: getWorkloadEaGubun
	* Program Name	: getWorkloadEaGubun
	* Description	: 기준업무량 종결건수 값 불러오기 
	* Author		: 임대성
	* Date			: 2018.02.02
	*********************************************************
	*/
	@RequestMapping(value = "getWorkloadEaGubun", method = RequestMethod.POST)
	@ResponseBody 
	public Map<String, Object> getWorkloadEaGubun(Model model, HttpSession session, HttpServletResponse response, HttpServletRequest request) {
		logger.info("======= getWorkloadEaGubun_ajax =======");
		
		//===============================================
	    //	결과 맵 생성
	    //===============================================
        String retirePendingFlag = request.getParameter("retirePendingFlag") != null ? request.getParameter("retirePendingFlag") : "";
        String workloadTypeVal = request.getParameter("workloadTypeVal") != null ? request.getParameter("workloadTypeVal") : "";		
		
		Map<String,Object> resultMap = new HashMap<String,Object>();

		//12월 15일은 다음해로 처리
		Calendar cal = Calendar.getInstance();    
		cal.setTime(new Date());    		
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
		String today = df.format(cal.getTime());
//		String today = "2018-12-16";
		
		int year = Integer.parseInt(today.split("-")[0]);
		int month = Integer.parseInt(today.split("-")[1]);
		int day = Integer.parseInt(today.split("-")[2]);
		
		if (month == 12 && day > 15){
			++year;
		}
		
		//===============================================
	    //	종결건수 불러오기
	    //===============================================
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
        SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();
        codeVo.setTbl_nm("top_rpt_head");
        codeVo.setCol_nm("workload_ea_"+year);
        codeVo.setCol_cd1( (String) paramMap.get("col_cd1") );
        codeVo.setCol_cd2( (String) paramMap.get("col_cd2") );
        
        SysAdmCodeDicVO workloadEa = CodeDicService.selectCode2Value(codeVo);
        
        //퇴사자(휴직자) 미결 처리를 위한 조건 추가        
        if( "1".equals(retirePendingFlag) && !"99".equals(workloadTypeVal)) {
        	Double workloadEaVal = 0.0;
            
            if( workloadEa != null ) {
            	workloadEaVal = Double.parseDouble(String.valueOf(workloadEa.getCol_val()));            	
            	workloadEaVal = workloadEaVal * 1.5;            	
            	workloadEaVal = Math.round(workloadEaVal * 1000) / 1000.0;        	
            }
            
            resultMap.put("workloadEa", workloadEaVal);
        }else{			//퇴직자(휴직자) 미결 처리가 아닌 경우
        	resultMap.put("workloadEa", workloadEa.getCol_val());
        }        
		
        return resultMap; 
	}	
	
	
	
	
}
