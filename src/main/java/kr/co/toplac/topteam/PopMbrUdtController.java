package kr.co.toplac.topteam;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.nio.charset.Charset;
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
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.converter.FormHttpMessageConverter;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.KakaoSendUtil;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.enc.EncryptUtil;

/*
 * ***************************************
 * Method ID : PopMbrUdtController
 * Method Name :  popMbrUdt
 * Description : 직원 상세보기 에서 정보 수정
 * 번호 1 - 상세정보 업데이트
 * 번호 2 - 로그 정보 인서트
 * 
 * Author : 이선형
 * Date : 20160411
 * ***************************************
 * */

@Controller
public class PopMbrUdtController {

	private static final Logger logger = LoggerFactory.getLogger(PopMbrUdtController.class);

	@Autowired
	private SqlSession sqlSession;
	
	/**
	 * 담당 손해사정사로 등록된 직원 수 (담당손해사정사 정보 삭제 전 체크)
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping("/getCertiManageMemberCnt")
    @ResponseBody
    public int getCertiManageMemberCnt(HttpServletRequest request, HttpSession session){
		
		logger.info("======= getCertiManageMemberCnt =======");
		
		int resultCnt = 0;
		
    	String ckey = request.getParameter("ckey") != null ? request.getParameter("ckey") : "";
    	
    	if( !"".equals(ckey) ) {
    		resultCnt = sqlSession.selectOne("TopMbrDtlMapper.countCertiManageMember", ckey);
    	}    	
		
		return resultCnt;
	}
    
	/**
	 * 보조인 정보 추가, 수정, 삭제하기
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping("/actionCertiSubManageData")
    @ResponseBody
    public int actionCertiSubManageData(HttpServletRequest request, HttpSession session){
		
		int resultCnt = 0;
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sAction = String.valueOf(paramMap.get("action_flag"));
		String sCkey = String.valueOf(paramMap.get("ckey"));
		String sUserNo = String.valueOf(paramMap.get("user_no"));		
		
		int dupChk = 0;
		String sCertiState = "0";
		
		if( "Add".equals(sAction) ) {
			logger.info("======= actionCertiSubManageData : " +sAction+ " : "+sUserNo+" =======");
			
			//자격증 번호 중복체크
			dupChk = sqlSession.selectOne("TopMbrDtlMapper.dupCertiNumberChk", paramMap);
			
			if( dupChk > 0 ) {
				resultCnt = 9;								//자격증 등록번호 중복
			}else{				
				resultCnt = sqlSession.insert("TopMbrUdtMapper.insertCertiInfo", paramMap);				
			}
			
		}else if( "Del".equals(sAction) ) {
			
			logger.info("======= actionCertiSubManageData : " +sAction+" : "+sUserNo+ " : "+sCkey+" =======");
			
			resultCnt = sqlSession.update("TopMbrDtlMapper.delUpdateCertiManageInfo", sCkey );
		}else if( "Update".equals(sAction) ) {
			
			logger.info("======= actionCertiSubManageData : " +sAction+" : "+sUserNo+ " : "+sCkey+" =======");			
							
			resultCnt = sqlSession.update("TopMbrUdtMapper.updateCertiSubInfo", paramMap);				
			
		}
		
		//인사정보 내 자격증 상태값 체크 (1:보조인, 4:손해사정사, 6:손해사정사+보조인)
		sCertiState = sqlSession.selectOne("TopMbrUdtMapper.selectCertiStateByTopMbrCerti",sUserNo);				
		
		//해당 사용자의 인사 정보를 자격증상태값을 가지고 갱신한다.
		paramMap.put("certi_state", sCertiState);		
		sqlSession.update("TopMbrUdtMapper.updateTopMbrBscCertiState", paramMap);		
		
		return resultCnt;
		
	}
	
	
	
	/**
	 * 손해사정사 정보 추가, 수정, 삭제하기
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping("/actionCertiManageData")
    @ResponseBody
    public int actionCertiManageData(HttpServletRequest request, HttpSession session){
		
		int resultCnt = 0;
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sAction = String.valueOf(paramMap.get("action_flag"));
		String sCkey = String.valueOf(paramMap.get("ckey"));
		String sUserNo = String.valueOf(paramMap.get("user_no"));
		
		//CommonUtils.printMap(paramMap);
		
		logger.info("======= actionCertiManageData : " +sAction+ " : "+sCkey+" =======");		
		
		int dupChk = 0;
		String sCertiState = "0";
		
		if( "Delete".equals(sAction) ) {			//손해사정사 정보만 삭제
			//resultCnt = sqlSession.delete("TopMbrDtlMapper.deleteCertiManageInfo", sCkey );
			//실제 삭제에서 플래그 업데이트 방식으로 변경 (20250623)
			resultCnt = sqlSession.update("TopMbrDtlMapper.delUpdateCertiManageInfo", sCkey );
			//손해사정사 삭제 시 top_mbr_bsc (인사테이블 certi_state = 0 미설정상태로 변경)
			sqlSession.update("TopMbrDtlMapper.updateCertiStateClearByTopMbrBsc", sUserNo);
			
		}else if( "DeleteAll".equals(sAction) ) {			//손해사정사 및 담당손해사정 관계테이블 삭제
			//관계 테이블 삭제
			//resultCnt = sqlSession.delete("TopMbrDtlMapper.deleteCertiManageInfoRelation", sCkey );
			//실제 삭제에서 플래그 업데이트 방식으로 변경 (20250623)
			resultCnt = sqlSession.update("TopMbrDtlMapper.delUpdateCertiManageInfoRelation", sCkey );
			//손해사정사 정보 삭제
			//resultCnt = sqlSession.delete("TopMbrDtlMapper.deleteCertiManageInfo", sCkey );
			//실제 삭제에서 플래그 업데이트 방식으로 변경 (20250623)
			resultCnt = sqlSession.update("TopMbrDtlMapper.delUpdateCertiManageInfo", sCkey );
			
			//손해사정사 삭제 시 top_mbr_bsc (인사테이블 certi_state = 0 미설정상태로 변경)
			sqlSession.update("TopMbrDtlMapper.updateCertiStateClearByTopMbrBsc", sUserNo);
		}else{
			if( "Add".equals(sAction) ) {			//추가
				
				//손해사정번호 중복체크
				dupChk = sqlSession.selectOne("TopMbrDtlMapper.dupCertiNumberChk", paramMap);
				
				if( dupChk > 0 ) {
					resultCnt = 9;								//손해사정사 등록번호 중복
				}else{				
					resultCnt = sqlSession.insert("TopMbrUdtMapper.insertCertiInfo", paramMap);					
				}
			}else if( "Update".equals(sAction) ) {		//수정				
				resultCnt = sqlSession.update("TopMbrUdtMapper.updateCertiInfo", paramMap);
			}			
		}
		
		//인사정보 내 자격증 상태값 체크 (1:보조인, 4:손해사정사, 6:손해사정사+보조인)
		sCertiState = sqlSession.selectOne("TopMbrUdtMapper.selectCertiStateByTopMbrCerti",sUserNo);				
		
		//해당 사용자의 인사 정보를 자격증상태값을 가지고 갱신한다.
		paramMap.put("certi_state", sCertiState);
		sqlSession.update("TopMbrUdtMapper.updateTopMbrBscCertiState", paramMap);
		
		return resultCnt;
	}
	
	@RequestMapping(value = "/topCertiSubManagerListAjax", method = RequestMethod.POST)
	public String topCertiSubManagerListAjax(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= topCertiSubManagerListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sUserNo = String.valueOf(paramMap.get("user_no"));
		
		//해당 직원의 보조인 정보를 가져온다.
		List<Map<String, Object>> certiSubMemberList = sqlSession.selectList("TopMbrDtlMapper.selectCertiSubInfoByUserno", sUserNo);
		model.addAttribute("certiSubMemberList", certiSubMemberList);
		
		//보조인 등록보종목록
		List<Map<String, Object>> srchCertiTypeList = sqlSession.selectList("TopMbrDtlMapper.selectSubCertiTypeList");
		model.addAttribute("srchCertiTypeList",srchCertiTypeList);
		
		return "top_team/top_insa_certi_sub_manage_modal_ajax";
	}
	
	@RequestMapping(value = "/topCertiManagerListAjax", method = RequestMethod.POST)
	public String topCertiManagerListAjax(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= topCertiManagerListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		paramMap.put("srchCertiClass", 2);		//손해사정사만 불러온다.
		
		//손해사정사 등록목록
		List<Map<String,Object>> certiMemberList = sqlSession.selectList("TopMbrDtlMapper.selectCertiManageListByCertiClass", paramMap);
		
		//업무용 전화번호 분리작업 시작
		String workPhone1 = "";
		String workPhone2 = "";
		String workPhone3 = "";
		String sTempWorkPhone = "";
		
		for( int i = 0; i < certiMemberList.size(); i++ ) {
			
			sTempWorkPhone = certiMemberList.get(i).get("work_phone").toString();
			
			if( !"".equals(sTempWorkPhone) ) {		//업무연락처(지점대표번호)가 있는 경우만 처리한다.	
				String [] workPhone = sTempWorkPhone.split("-");				
				
				if( workPhone.length == 1 ) {
					workPhone1 = workPhone[0];
					workPhone2 = "";
					workPhone3 = "";
				}else if( workPhone.length == 2 ) {
					workPhone1 = workPhone[0];
					workPhone2 = workPhone[1];
					workPhone3 = "";
				}else if( workPhone.length == 3 ){
					workPhone1 = workPhone[0];
					workPhone2 = workPhone[1];
					workPhone3 = workPhone[2];
				}else{
					workPhone1 = "";
					workPhone2 = "";
					workPhone3 = "";
				}
				
				certiMemberList.get(i).put("work_phone1", workPhone1);
				certiMemberList.get(i).put("work_phone2", workPhone2);
				certiMemberList.get(i).put("work_phone3", workPhone3);
			}else{
				certiMemberList.get(i).put("work_phone1", "");
				certiMemberList.get(i).put("work_phone2", "");
				certiMemberList.get(i).put("work_phone3", "");
			}
			
		}
		//업무용 전화번호 분리작업 끝
		
		//손해사정사용 등록보종목록
		List<Map<String, Object>> srchCertiTypeList = sqlSession.selectList("TopMbrDtlMapper.selectMainCertiTypeList");
				
		model.addAttribute("certiMemberList",certiMemberList);
		model.addAttribute("srchCertiTypeList",srchCertiTypeList);
		model.addAttribute("srchParam",paramMap);
		
		return "top_team/top_insa_certi_manage_modal_ajax";
	}
	
	/**
	 * 손해사정사 보조인 명단 다운로드
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/doCertiSubInfoDown", method = RequestMethod.POST)
	public String doCertiSubInfoDown(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		
		logger.info("======= doCertiSubInfoDown =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sCkey = String.valueOf(paramMap.get("ckey"));
		String sUserName = String.valueOf(paramMap.get("user_name"));
		
		Date dateToday = new Date();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");//오늘날자구하기
		
		String today = df.format(dateToday);
		
		String fileName = "";
		String title = "";
		
		if( sUserName.equals("") ){
			fileName = "보조인명단_"+today+".xls";
			title = "보조인명단_"+today+".xls";
		}else{
			fileName = sUserName+"_보조인명단_"+today+".xls";
			title = sUserName+"_보조인명단_"+today+".xls";
		}
		
		try {
			fileName = java.net.URLEncoder.encode(fileName,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
						
		List<Map<String, Object>> certiSubMemberList = sqlSession.selectList("TopMbrDtlMapper.selectCertiSubMemberListByCkey", sCkey);
		
		model.addAttribute("user_name", sUserName);
		model.addAttribute("certiSubMemberList", certiSubMemberList);
				
		response.setHeader("Content-Disposition", "attachment;filename="+fileName);
		response.setHeader("Content-Type", "application/vnd.ms-xls");
		response.setHeader("Content-Description", "JSP Generated Data");
		response.setHeader("Content-Transfer-Encoding", "binary");
		
		return "top_team/top_insa_certi_manage_submember_excel";
	}
	
	/**
	 * 손해사정사 삭제 모달 창
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getCertiManagerDeleteInfoList", method = RequestMethod.POST)
	public String getCertiManagerDeleteInfoList(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= getCertiManagerDeleteInfoList =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sCkey = String.valueOf(paramMap.get("ckey"));		
		
		Map<String, Object> certiInfoMap = sqlSession.selectOne("TopMbrDtlMapper.selectCertiInfoByCkey", sCkey);
		
		//삭제 할 담당 손해사정사에 등록된 보조인 목록
		List<Map<String, Object>> certiSubMemberList = sqlSession.selectList("TopMbrDtlMapper.selectCertiSubMemberListByCkey", sCkey);		
				
		model.addAttribute("certiInfoMap", certiInfoMap);
		model.addAttribute("certiSubMemberList", certiSubMemberList);
		model.addAttribute("srchParam",paramMap);
		
		return "top_team/top_insa_certi_manage_delete_modal";
	}
		
	/**
	 * 보조인 등록정보 관리 Modal
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getCertiSubManagerInfoList", method = RequestMethod.POST)
	public String getCertiSubManagerInfoList(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= getCertiSubManagerInfoList =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
				
		String sUserNo = String.valueOf(paramMap.get("user_no"));
		
		//직원 기본정보 가져오기
		TopMbrBscVO memberVo = sqlSession.selectOne("TopMbrDtlMapper.mbrinfo", sUserNo);
		model.addAttribute("memberVo",memberVo);
		
		//보조인 등록보종목록
		List<Map<String, Object>> srchCertiSubTypeList = sqlSession.selectList("TopMbrDtlMapper.selectSubCertiTypeList");
		model.addAttribute("srchCertiSubTypeList", srchCertiSubTypeList);
		
		
		
		
		/*
		paramMap.put("srchCertiClass", 2);		//손해사정사만 불러온다.
		
		//재직중(퇴사자포함)이면서 손해사정사 등록 가능 대상자 (보조인등록자 제외)
		List<Map<String, Object>> srchUserNoList = sqlSession.selectList("TopMbrDtlMapper.selectCertiManageUserNoList", paramMap);
		
		//손해사정사용 등록보종목록
		List<Map<String, Object>> srchCertiTypeList = sqlSession.selectList("TopMbrDtlMapper.selectMainCertiTypeList");
		
		model.addAttribute("srchUserNoList", srchUserNoList);
		model.addAttribute("srchCertiTypeList", srchCertiTypeList);
		model.addAttribute("srchParam",paramMap);
		*/
		return "top_team/top_insa_certi_sub_manage_modal";
	}
	
	/**
	 * 손해사정사 관리 모달 창
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getCertiManagerInfoList", method = RequestMethod.POST)
	public String getCertiManagerInfoList(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= getCertiManagerInfoList =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		paramMap.put("srchCertiClass", 2);		//손해사정사만 불러온다.
		
		//재직중(퇴사자포함)이면서 손해사정사 등록 가능 대상자 (보조인등록자 제외)
		List<Map<String, Object>> srchUserNoList = sqlSession.selectList("TopMbrDtlMapper.selectCertiManageUserNoList", paramMap);
		
		//손해사정사용 등록보종목록
		List<Map<String, Object>> srchCertiTypeList = sqlSession.selectList("TopMbrDtlMapper.selectMainCertiTypeList");
		
		//손해사정사 등록목록
		//List<Map<String,Object>> certiMemberList = sqlSession.selectList("TopMbrDtlMapper.selectCertiManageListByCertiClass", paramMap);		
		//model.addAttribute("certiMemberList",certiMemberList);
		
		model.addAttribute("srchUserNoList", srchUserNoList);
		model.addAttribute("srchCertiTypeList", srchCertiTypeList);
		model.addAttribute("srchParam",paramMap);
		
		return "top_team/top_insa_certi_manage_modal";
	}

	/* 사원 세부 내용 수정 */
	@RequestMapping(value = "popMbrUdt", method = RequestMethod.POST)
	public void popMbrUdt(Model model, String user_no, PrintWriter out, TopMbrViewVO memberViewVo,
			HttpServletRequest request) {
		
//		System.out.println("user_no : " + memberViewVo.getUser_no() );
//		System.out.println("user_id : " + memberViewVo.getUser_id() );
//		System.out.println("Home_address: " + memberViewVo.getHome_address() );
//		
//		System.out.println("team_id_main: " + memberViewVo.getTeam_id_main() );
//		System.out.println("team_id_loc: " + memberViewVo.getTeam_id_loc() );
//		System.out.println("join_date: " + memberViewVo.getJoin_date() );
//		System.out.println("out_date: " + memberViewVo.getOut_date() );
//		System.out.println("probation_date: " + memberViewVo.getProbation_date() );
//		System.out.println("user_state: " + memberViewVo.getUser_state() );
//		System.out.println("curr_user_state: " + memberViewVo.getCurr_user_state());
//		
//		System.out.println("job_memo: " + memberViewVo.getJob_memo() );
//		
//		System.out.println("workLevel: " + memberViewVo.getWorkLevel() );
//		System.out.println("workRank: " + memberViewVo.getWorkRank() );
//		System.out.println("workType: " + memberViewVo.getWorkType() );
//		System.out.println("workJob : " + memberViewVo.getWorkJob() );
//		
//		System.out.println("home_tel_1 : " + memberViewVo.getHome_tel_1() );
//		System.out.println("home_tel_2 : " + memberViewVo.getHome_tel_2() );
//		System.out.println("home_tel_3 : " + memberViewVo.getHome_tel_3() );
//		
//		System.out.println("officetel_1 : " + memberViewVo.getOfficetel_1() );
//		System.out.println("officetel_2 : " + memberViewVo.getOfficetel_2() );
//		System.out.println("officetel_3 : " + memberViewVo.getOfficetel_3() );
//		
//		System.out.println("officefax_1 : " + memberViewVo.getOfficefax_1() );
//		System.out.println("officefax_2 : " + memberViewVo.getOfficefax_2() );
//		System.out.println("officefax_3 : " + memberViewVo.getOfficefax_3() );
//		
//		System.out.println("handphone_1 : " + memberViewVo.getHandphone_1() );
//		System.out.println("handphone_2 : " + memberViewVo.getHandphone_2() );
//		System.out.println("handphone_3 : " + memberViewVo.getHandphone_3() );
//		
//		System.out.println("comment : " + memberViewVo.getComment() );
//		System.out.println("insa_memo : " + memberViewVo.getInsa_memo() );
//		System.out.println("insa_memo_only : " + memberViewVo.getInsa_memo_only() );
//		System.out.println("email : " + memberViewVo.getEmail() );

		TopMbrBscVO memberVo = new TopMbrBscVO();
		if (memberViewVo.getHome_address() != "") {
			memberVo.setHome_address(memberViewVo.getHome_address());
		}

		if (memberViewVo.getTeam_id_main() != "") {
			memberVo.setTeam_id_main(memberViewVo.getTeam_id_main());
			;
		}

		if (memberViewVo.getJoin_date() != "") {
			memberVo.setJoin_date(memberViewVo.getJoin_date());
		}

		if (memberViewVo.getCTDay() != "") {
			memberVo.setCTDay(memberViewVo.getCTDay());
		}

		if (memberViewVo.getOut_date() != "") {
			memberVo.setOut_date(memberViewVo.getOut_date());
		}

		if (memberViewVo.getProbation_date() != "") {
			memberVo.setProbation_date(memberViewVo.getProbation_date());
		}

		if ("9".equals(memberViewVo.getCurr_user_state()) && "0".equals(memberViewVo.getUser_state())) {
			memberVo.setUser_state("9");
		} else {
			memberVo.setUser_state(memberViewVo.getUser_state());
		}

		if (memberViewVo.getUser_no() != "") {
			memberVo.setUser_no(memberViewVo.getUser_no());
		}

		// 자택 전화번호
		if ((memberViewVo.getHome_tel_1() != "") && (memberViewVo.getHome_tel_2() != "")
				&& (memberViewVo.getHome_tel_3() != "")) {

			String home_tel = memberViewVo.getHome_tel_1() + "-" + memberViewVo.getHome_tel_2() + "-"
					+ memberViewVo.getHome_tel_3();

			memberVo.setHome_tel(home_tel);
		}

		// 핸드폰 번호
		if ((memberViewVo.getHandphone_1() != "") && (memberViewVo.getHandphone_2() != "")
				&& (memberViewVo.getHandphone_3() != "")) {

			String handphone = memberViewVo.getHandphone_1() + "-" + memberViewVo.getHandphone_2() + "-"
					+ memberViewVo.getHandphone_3();

			memberVo.setHandphone(handphone);
		}

		// 직통 번호
		if ((memberViewVo.getOfficetel_1() != "") && (memberViewVo.getOfficetel_2() != "")
				&& (memberViewVo.getOfficetel_3() != "")) {

			String office_tel = memberViewVo.getOfficetel_1() + "-" + memberViewVo.getOfficetel_2() + "-"
					+ memberViewVo.getOfficetel_3();

			memberVo.setOffice_tel(office_tel);
		}

		// 팩스 번호
		if ((memberViewVo.getOfficefax_1() != "") && (memberViewVo.getOfficefax_2() != "")
				&& (memberViewVo.getOfficefax_3() != "")) {

			String office_fax = memberViewVo.getOfficefax_1() + "-" + memberViewVo.getOfficefax_2() + "-"
					+ memberViewVo.getOfficefax_3();

			memberVo.setOffice_fax(office_fax);
		}

		if (memberViewVo.getComment() != "") {
			memberVo.setComment(memberViewVo.getComment());
		}

		if (memberViewVo.getJob_memo() != "") {
			memberVo.setJob_memo(memberViewVo.getJob_memo());
		} else {
			memberVo.setJob_memo("");
		}

		if (memberViewVo.getJob_memo() != "") {
			memberVo.setJob_memo(memberViewVo.getJob_memo());
		} else {
			memberVo.setJob_memo("");
		}

//		System.out.println("insa_memo:["+memberViewVo.getInsa_memo()+"]");
//        System.out.println("insa_memo_only:["+memberViewVo.getInsa_memo_only()+"]");

		if (memberViewVo.getInsa_memo() != null) {
			memberVo.setMemo(memberViewVo.getInsa_memo());
		}

		if (memberViewVo.getInsa_memo_only() != null) {
			memberVo.setInsa_memo_only(memberViewVo.getInsa_memo_only());
		}

		if (memberViewVo.getTeam_id_loc() != "") {
			memberVo.setTeam_id_loc(memberViewVo.getTeam_id_loc());
		} else {
			memberVo.setTeam_id_loc("");
		}

		if (memberViewVo.getEmail() != "") {
			memberVo.setEmail(memberViewVo.getEmail());
		} else {
			memberVo.setEmail("");
		}

		if (memberViewVo.getWorkLevel() != "") {
			memberVo.setWork_level(memberViewVo.getWorkLevel());
		} else {
			memberVo.setWork_level("");
		}

		if (memberViewVo.getWorkType() != "") {
			memberVo.setWork_type(memberViewVo.getWorkType());
		} else {
			memberVo.setWork_type("");
		}

		if (memberViewVo.getWorkRank() != "") {
			memberVo.setWork_rank(memberViewVo.getWorkRank());
		} else {
			memberVo.setWork_rank("");
		}

		if (memberViewVo.getWorkJob() != "") {
			memberVo.setWork_job(memberViewVo.getWorkJob());
		} else {
			memberVo.setWork_job("");
		}
		
		if(memberViewVo.getIs_pass() != "") {
			memberVo.setIs_pass(memberViewVo.getIs_pass());
		} else {
			memberVo.setIs_pass("");
		}
		
		if(memberViewVo.getExp_agree() != "") {
			memberVo.setExp_agree(memberViewVo.getExp_agree());			
		} else {
			memberVo.setExp_agree("");
		}
		
		if(memberViewVo.getBonus_career_state() != "") {
			memberVo.setBonus_career_state(memberViewVo.getBonus_career_state());			
		}else {
			memberVo.setBonus_career_state("0");
		}
		
		if(memberViewVo.getPerson_zone() != "") {
			memberVo.setPerson_zone(memberViewVo.getPerson_zone());
		}else {
			memberVo.setPerson_zone("0");
		}
		
		memberVo.setLog_memo("사원 정보 수정");

		// 겸직추가.
		String[] sTemp = request.getParameterValues("subJob"); // 겸직추가.
		String[] splTemp = null; // 배열처리 임시변수
		String sub_team_id_main = ""; // 겸직팀
		String sub_work_type = ""; // 겸직직책

		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

		if (sTemp != null && sTemp.length > 0) {
			paramMap.put("user_no", user_no);
			sqlSession.update("TopMbrUdtMapper.deleteTopSubjob", paramMap);			

			for (int i = 0; i < sTemp.length; i++) {
				splTemp = sTemp[i].split("\\|");
				sub_team_id_main = splTemp[0];
				sub_work_type = splTemp[1];

				//System.out.println("Insert : "+splTemp[0]+" : "+splTemp[1]);

				if (!("0".equals(sub_team_id_main) || "0".equals(sub_work_type) || "undefined".equals(sub_team_id_main)
						|| "undefined".equals(sub_work_type))) {
					paramMap.put("sub_team_id_main", sub_team_id_main);
					paramMap.put("sub_work_type", sub_work_type);
					sqlSession.update("TopMbrUdtMapper.insertTopSubjob", paramMap);
				}
			}
		}
		
		//보조인 정보의 자격상태 
		String certi_state_sub = String.valueOf(paramMap.get("certi_state_sub"));		
		
		//인사정보에 세팅될 certi_state 값		
		memberVo.setCerti_state(certi_state_sub);
		
		
		//손해사정사 자격정보 등록시작
		/**
		String certi_state_main = String.valueOf(paramMap.get("certi_state_main"));
		
		if( "1".equals(certi_state_main) ) {			//손해사정사 자격증정보가 있는경우 보조인 자격정보는 삭제한다.
			
			memberVo.setCerti_state("4");				//top_mbr_bsc의 certi_state를 4로 갱신한다.
			
			String[] sCertiTemp = request.getParameterValues("certiList");		// 손해사정사 자격정보 배열
			String[] splCertiTemp = null; 													// 배열처리 임시변수			
			String certi_type = ""; 							//임시 자격종류			
			String certi_number = "";						//임시 자격증번호
			
			if (sCertiTemp != null && sCertiTemp.length > 0) {				
				
				//기존 자격정보를 삭제한다.
				sqlSession.update("TopMbrUdtMapper.deleteCertiInfoMainByUserNo", paramMap);			

				for (int i = 0; i < sCertiTemp.length; i++) {
					splCertiTemp = sCertiTemp[i].split("\\|");
					certi_type = splCertiTemp[0];
					certi_number = splCertiTemp[1];

					//System.out.println("Insert : "+splCertiTemp[0]+" : "+splCertiTemp[1]);

					if (!("0".equals(certi_type) || "".equals(certi_number) || "undefined".equals(certi_type) )) {
						paramMap.put("certi_class", "2");				//손해사정사
						paramMap.put("certi_type", certi_type);
						paramMap.put("certi_number", certi_number);
						sqlSession.update("TopMbrUdtMapper.insertCertiInfo", paramMap);
					}
				}
			}
		}else{				//손해사정사 자격정보를 삭제한다.
			sqlSession.update("TopMbrUdtMapper.deleteCertiInfoMainByUserNo", paramMap);
		}
				
		//손해사정사 자격정보 등록 끝
		
		**/
		
		//담당 손해사정사 등록 시작		
		//기존 등록된 담당 손해사정사 등록 정보를 삭제한다.
		sqlSession.delete("TopMbrUdtMapper.deleteCertiManangerByUserNo", paramMap);
		
		String certi_manager_type = paramMap.get("certi_manager_search").getClass().getSimpleName();		
		
		if( "String[]".equals(certi_manager_type) ) {		//담당 손해사정사 정보가 배열로 넘어온 경우
			
			String [] certi_manager_search = (String[]) paramMap.get("certi_manager_search");
			
			for( int i=0; i < certi_manager_search.length; i++ ) {		//두 개 이상인 경우
				paramMap.put("ckey", certi_manager_search[i]);
				sqlSession.insert("TopMbrUdtMapper.insertCertiManagerInfo", paramMap);
			}
			
		}else{					//한개 이거나 없는 경우
			String certi_manager_search = String.valueOf(paramMap.get("certi_manager_search"));
			if( !"".equals(certi_manager_search) ) {			//한 개만 선택 된 경우
				paramMap.put("ckey", certi_manager_search);
				sqlSession.insert("TopMbrUdtMapper.insertCertiManagerInfo", paramMap);
			}
		}			
		//담당 손해사정사 등록 끝		
		
		//연차수동설정 기능제거

		// System.out.println("annual_set="+paramMap.get("annual_set"));
		/*
		 * double dAnnual_set =
		 * Double.parseDouble(paramMap.get("annual_set").toString());
		 * 
		 * 조회시점 할당된 연차가져오기 Calendar cal = Calendar.getInstance(); int year =
		 * cal.get(Calendar.YEAR); String sBasedate = Integer.toString(year)+"-01-01";
		 * //조회대상년도
		 * 
		 * paramMap.put("base_date", sBasedate); paramMap.put("user_no", user_no);
		 * 
		 * VacationUseBean vacationUseList =
		 * sqlSession.selectOne("topVacationMapper.vacationUseList",paramMap);
		 * 
		 * //연차할당건수가 없는 경우는 top_vacation_use 테이블에 추가한다. if( vacationUseList == null ) {
		 * paramMap.put("annual_set", dAnnual_set); //초기화 paramMap.put("annual_use", 0);
		 * paramMap.put("vacation_apply", 0); paramMap.put("vacation_use", 0);
		 * sqlSession.insert("topVacationMapper.insertVacationUse",paramMap);
		 * //System.out.println("연차추가할당 :"+user_no+" : "+dAnnual_set); }else {
		 * paramMap.put("annual_set", dAnnual_set);
		 * sqlSession.update("topVacationMapper.updateVacationUse",paramMap);
		 * //System.out.println("연차갱신할당 :"+user_no+" : "+dAnnual_set); }
		 */

		// ==========================================================
		// 퇴사일경우 권한 초기화
		// ==========================================================
		if ("1".equals(memberVo.getUser_state())) {
			sqlSession.update("TopMbrUdtMapper.initializeDataProcessAuthority", memberVo);
			sqlSession.update("TopMbrUdtMapper.initializeReportAuthority", memberVo);
			
			//퇴사일 경우 보조인 등록여부를 초기화(미등록)한다.	(원래 값으로 둔다)
			//memberVo.setCerti_state("0");
			//퇴사일 경우 손해사정사 정보를 삭제한다. (퇴사일경우에도 삭제하지 않는다)
			//sqlSession.update("TopMbrUdtMapper.deleteCertiInfoMainByUserNo", paramMap);
			
			memberVo.setLog_memo("퇴사 [" + memberViewVo.getUser_id() + "]");
		}

		int result_mbrudt = sqlSession.update("TopMbrUdtMapper.mbrdtludt", memberVo);
		int result_mbrlog = sqlSession.update("TopMbrUdtMapper.mbrinslog", memberVo);
		if ((result_mbrlog == 1) && (result_mbrudt == 1)) {
			out.print(1);
		} else {
			out.print(0);
		}
	}
	
	public String sendPwRefleshKaKaoTalk(Map<String,Object> paramMap){				//로그인 인증 번호 발송

    	String tmplId = "toplacReflesh";			//패스워드 초기화 템플릿 코드
    	
    	String sMobile = paramMap.get("mobile").toString();
    	String sUserName = paramMap.get("user_name").toString();
    	String refleshPw = paramMap.get("refleshPw").toString();
    	
    	String phn = "82"+sMobile.substring(1);
    	
    	RestTemplate restTemplate = new RestTemplate();
    	
		// RestTemplate 에 MessageConverter 세팅
	    List<HttpMessageConverter<?>> converters = new ArrayList<HttpMessageConverter<?>>();
	    converters.add(new FormHttpMessageConverter());
	    converters.add(new StringHttpMessageConverter(Charset.forName("UTF-8")));
		
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.add("Accept", "application/json");
		httpHeaders.add("Content-type", "application/json");
		httpHeaders.add("userId", "toplac"); //실제
				
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		
		String msg = sUserName+"님 비밀번호 초기화 안내입니다.\n";
		msg += "\n";
		msg += "초기화 비밀번호 : "+refleshPw+"\n";
		msg += "\n";
		msg += "로그인후 비밀번호를 변경해주세요.";
		
		obj.put("message_type", "at");
		obj.put("phn", phn);
		obj.put("profile", "22e9cd927d652e02daca5dc631170e021f02ae51");	//실제
		obj.put("tmplId", tmplId);
		obj.put("msg", msg);
	
		obj.put("smsKind", "L");
		obj.put("msgSms", msg);
		obj.put("smsSender", "0260774600");
	
		obj.put("smsLmsTit", "탑손해사정주식회사");
		obj.put("reserveDt", "00000000000000");
		
		arr.add(obj);
    	
    	HttpEntity entity = new HttpEntity(arr, httpHeaders);
		URI uri = UriComponentsBuilder.fromHttpUrl("https://alimtalk-api.bizmsg.kr/v2/sender/send").build().toUri();    	
    	String responseEntity = restTemplate.postForObject(uri, entity, String.class);
		logger.info(responseEntity);
		
		return responseEntity;
    }
	
	/**
	 * 로그인 5회 실패시 직원이 자체 초기화 
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping("/refleshPwKakaoSelf")
    @ResponseBody
    public Map<String, Object> refleshPwKakaoSelf(HttpServletRequest request, HttpSession session){
                        
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);        
        Map<String, Object> resultMap = new HashMap<>();
        
        String responseMsg = "";			//카카오 발송 결과로그
        
        String refleshPw = CommonUtils.numberGen(6, 1);		//중복허용된 6자리 난수 생성 (임시 비밀번호)
        
        paramMap.put("refleshPw", refleshPw);        
        paramMap.put("tempPw", EncryptUtil.getEncryptSHA256(refleshPw));        
        
        //DB에 신규 비밀번호로 갱신
        
        int nRet = sqlSession.update("TopMbrUdtMapper.initializePw", paramMap);
        
        if( nRet == 1 ) {			//갱신 된 경우만 카카오로 발송
        	
        	//인증번호 발송 (테스트 시 제외)
        	responseMsg = sendPwRefleshKaKaoTalk(paramMap);
        	
        	JsonArray jsonArr = new JsonParser().parse(responseMsg).getAsJsonArray();
            JsonObject obj = (JsonObject) jsonArr.get(0);
            String code = obj.get("code").getAsString();
            String retMessage= obj.get("message").getAsString();
            JsonObject sData = (JsonObject)obj.get("data").getAsJsonObject();
            
            //IT정보보호파트 담당자에게 비밀번호 초기화 알림 시작
            String sUserName = paramMap.get("user_name").toString();
            String smsContents = "";
            String receiveNo = "";
    		smsContents +="[전산지원완료]\n";
    		smsContents +="신청자 : "+sUserName+"\n";
    		smsContents +="제목 : 로그인 5회 실패로 비밀번호 초기화\n";
    		smsContents +="담당자 : 인트라넷 (IT정보보호파트)\n";
    		smsContents +="조치내용 : "+sUserName+"님이 로그인 5회 실패로 비밀번호 초기화실시";
    		
    		//태그제거
    		smsContents = smsContents.replaceAll("<br />", "\n");
    		smsContents = smsContents.replaceAll("&nbsp;", " ");
    		smsContents = smsContents.replaceAll("<(/)?([a-zA-Z]*)(\\\\s[a-zA-Z]*=[^>]*)?(\\\\s)*(/)?>", "");

    		int smsType = 2;				//신청완료
    		
    		List<Map<String,Object>> receiveList = sqlSession.selectList("BoardHelpDeskMapper.selectItHandphoneList");		
    		String senderNo = "0260774600";
    		
    		//IT정보보호파트 담당자에게 발송
    		for( int i=0; i < receiveList.size(); i++ ) {
    			receiveNo = receiveList.get(i).get("handphone").toString();
    			receiveNo = receiveNo.replaceAll("-", "");
    			KakaoSendUtil.sendKakaoTalkByIt(senderNo, receiveNo, smsContents, smsType);    			
    		}            
            //IT정보보호파트 담당자에게 비밀번호 초기화 알림 끝            
            
            if ("success".equals(code)){			//K(카카오),M(SMS)
            	if( retMessage.charAt(0) == 'K' ) {
            		resultMap.put("RSLT_CODE", "K");
            	}else if( retMessage.charAt(0) == 'M' ) {
            		resultMap.put("RSLT_CODE", "M");
            	}else{
            		resultMap.put("RSLT_CODE", "L");
            	}
            }else{
            	resultMap.put("RSLT_CODE", "Message Send Fail Error");
            }
        }else{
        	resultMap.put("RSLT_CODE", "DB Update Fail Error");
        }
        
        return resultMap;
	}
	
	/**
	 * 신규 비밀번호초기화 (관리자용)
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping("/refleshPwKakao")
    @ResponseBody
    public Map<String, Object> refleshPwKakao(HttpServletRequest request, HttpSession session){
                        
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);        
        Map<String, Object> resultMap = new HashMap<>();
        
        String responseMsg = "";			//카카오 발송 결과로그
        
        String refleshPw = CommonUtils.numberGen(6, 1);		//중복허용된 6자리 난수 생성 (임시 비밀번호)
        
        paramMap.put("refleshPw", refleshPw);        
        paramMap.put("tempPw", EncryptUtil.getEncryptSHA256(refleshPw));        
        
        //DB에 신규 비밀번호로 갱신
        
        int nRet = sqlSession.update("TopMbrUdtMapper.initializePw", paramMap);
        
        if( nRet == 1 ) {			//갱신 된 경우만 카카오로 발송
        	
        	//인증번호 발송 (테스트 시 제외)
        	responseMsg = sendPwRefleshKaKaoTalk(paramMap);
        	
        	JsonArray jsonArr = new JsonParser().parse(responseMsg).getAsJsonArray();
            JsonObject obj = (JsonObject) jsonArr.get(0);
            String code = obj.get("code").getAsString();
            String retMessage= obj.get("message").getAsString();
            JsonObject sData = (JsonObject)obj.get("data").getAsJsonObject();
        	
            if ("success".equals(code)){			//K(카카오),M(SMS)
            	if( retMessage.charAt(0) == 'K' ) {
            		resultMap.put("RSLT_CODE", "K");
            	}else if( retMessage.charAt(0) == 'M' ) {
            		resultMap.put("RSLT_CODE", "M");
            	}else{
            		resultMap.put("RSLT_CODE", "L");
            	}
            }else{
            	resultMap.put("RSLT_CODE", "Message Send Fail Error");
            }
        }else{
        	resultMap.put("RSLT_CODE", "DB Update Fail Error");
        }
        
        return resultMap;
	}

	/* 비밀번호 초기화 */
	@RequestMapping(value = "initializePw", method = RequestMethod.POST)
	public void initializePw(PrintWriter out, String user_no) {
		logger.info("initializePw");

		Calendar temp = Calendar.getInstance();

		int hh = temp.get(Calendar.HOUR_OF_DAY);
		int mm = temp.get(Calendar.MINUTE);
		int ss = temp.get(Calendar.SECOND);
		
		String tempPw = Integer.toString(hh) + Integer.toString(mm) + Integer.toString(ss);

		HashMap<String, String> map = new HashMap<String, String>();

		map.put("user_no", user_no);
		map.put("tempPw", EncryptUtil.getEncryptSHA256(tempPw));

		int result = sqlSession.update("TopMbrUdtMapper.initializePw", map);

		if (result > 0) {
			out.print(tempPw);
		} else {
			out.print(0);
		}

		out.close();

	}// initializePw

}
