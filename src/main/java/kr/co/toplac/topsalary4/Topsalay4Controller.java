package kr.co.toplac.topsalary4;

import java.io.IOException;
import java.io.PrintWriter;
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

import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.topstatistics.StatisticsIndexController;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;

@Controller
public class Topsalay4Controller {
	
	private static final Logger logger = LoggerFactory.getLogger(StatisticsIndexController.class);

	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "updateTopMbrSalary4Part", method = RequestMethod.POST)
	@ResponseBody 
	public Map<String, Object> updateTopMbrSalary4Part(Model model, HttpSession session, HttpServletResponse response, HttpServletRequest request) {
		logger.info("======= updateTopMbrSalary4Part =======");		
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		int nCnt = 0;
		
		nCnt = sqlSession.selectOne("Salary4Mapper.chkInsuForPart", paramMap);
		
		//해당 보험사의 직무가 존재하는지 체크한다.
		if( nCnt == 0 ) {
			resultMap.put("result", "Empty");
		}else{
			sqlSession.update("Salary4Mapper.updateTopMbrSalary4Part", paramMap);
			resultMap.put("result", "Success");
		}
		
        return resultMap; 
	}
	
	/** 
	 * 직무 목록 가져오기
	 * @param model
	 * @param session
	 * @param team_id
	 * @param response
	 */
	@RequestMapping(value = "getSalaryPartList", method = RequestMethod.POST)
	public void getSalaryPartInfoList(Model model, HttpSession session, String ikey, HttpServletResponse response) {

		logger.info("getSalaryPartList");

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");

		PrintWriter out = null;

		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		/*해당 보험사의 직무 추출*/
		List<Map<String, Object>> selPartList = sqlSession.selectList("Salary4Mapper.selectInsuPartListSel", ikey);
		
		JSONArray arr = new JSONArray();
		for(int i=0; i < selPartList.size(); i++){
			
			JSONObject obj = new JSONObject();

			obj.put("pkey", String.valueOf(selPartList.get(i).get("pkey")));
			obj.put("part_name", String.valueOf(selPartList.get(i).get("part_name")));
			obj.put("ikey", String.valueOf(selPartList.get(i).get("ikey")));			
			
			arr.add(obj);
		}

		String jsonStr = arr.toString();
		out.print(jsonStr);
		out.close();		
	}
	
	@RequestMapping(value = "/salary_incentive_insu_company_action", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> salary_incentive_insu_company_action(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= salary_incentive_insu_company_action =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();	
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		paramMap.put("reg_user_no",String.valueOf(mbrVo.getUser_no()));
		
		Map<String, Object> returnMap = new HashMap<>();
		
		String sAction_flag = String.valueOf(paramMap.get("action_flag"));
		
		int nCnt = 0;		//중복체크용 임시 플래그
		
		if( "I".equals(sAction_flag) ) {					
			//추가 전에 기존에 등록된 보험사 인지 확인한다. (동일한 보험사명 불가)
			nCnt = sqlSession.selectOne("Salary4Mapper.selectSalaryInsuExceptCnt", paramMap);
			
			if( nCnt == 0 ) {
				sqlSession.insert("Salary4Mapper.insertSalaryInsuCompany", paramMap);
				returnMap.put("result", "Insert");
			}else {
				returnMap.put("result", "Dup");
			}
		}
		
		if( "U".equals(sAction_flag) ) {
			//수정전에 동일한 이름으로 다른 보험사 등록건이 존재하는지 체크한다.			
			nCnt = sqlSession.selectOne("Salary4Mapper.selectSalaryInsuExceptModCnt", paramMap);
			
			if( nCnt == 0 ) {
				sqlSession.update("Salary4Mapper.updateSalaryInsuCompany", paramMap);
				returnMap.put("result", "Update");
			}else {
				returnMap.put("result", "Dup");
			}
		}
		
		if( "D".equals(sAction_flag) ) {
			sqlSession.update("Salary4Mapper.deleteSalaryInsuCompany", paramMap);
			returnMap.put("result", "Delete");
		}
		
		return returnMap; 
	}
	
	/**
	 * 성과급 설정 보험사 정보 불러오기
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/salaryInsuListAjax", method = RequestMethod.POST)
	public String salaryInsuListAjax(Model model, HttpServletRequest request, HttpSession session) {
		logger.info("======= salaryInsuListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		

		List<Map<String, Object>> insuList = sqlSession.selectList("Salary4Mapper.selectInsuCompanyList", paramMap);
		
		model.addAttribute("insuList",insuList);		
		model.addAttribute("srchParam", paramMap);
		
		return "top_salary_4/salary_incentive_insu_manage_ajax";
	}
	
	/**
	 * 예외자 목록 불러오기
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/salaryExceptListAjax", method = RequestMethod.POST)
	public String salaryExceptListAjax(Model model, HttpServletRequest request, HttpSession session) {
		logger.info("======= salaryExceptListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		List<Map<String, Object>> exceptList = sqlSession.selectList("Salary4Mapper.selectExceptMemberList", paramMap);
		
		model.addAttribute("exceptList",exceptList);
		
		return "top_salary_4/salary_except_manage_ajax";
	}
	
	/**
	 * 예외자 설정 추가 삭제
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/salary_except_member_action", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> salary_except_member_action(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= salary_except_member_action =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();	
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		paramMap.put("reg_user_no",String.valueOf(mbrVo.getUser_no()));
		
		Map<String, Object> returnMap = new HashMap<>();
		
		String sAction_flag = String.valueOf(paramMap.get("action_flag"));
		
		//예외자 추가
		if( "I".equals(sAction_flag) ) {
			int nCnt = 0;			
			//추가 전에 기존에 등록된 사용자 인지 확인한다.
			nCnt = sqlSession.selectOne("Salary4Mapper.selectSalaryExceptCnt", paramMap);
			
			if( nCnt == 0 ) {				
				sqlSession.insert("Salary4Mapper.insertSalaryExceptMember", paramMap);
				returnMap.put("result", "Insert");
			}else{
				returnMap.put("result", "Dup");
			}
			
		}else if( "D".equals(sAction_flag) ) {
			
			sqlSession.delete("Salary4Mapper.deleteSalaryExceptMember", paramMap);
			returnMap.put("result", "Delete");
		}
		
		return returnMap; 
	}	
	
	@RequestMapping(value = "updateLeaveMonthMember", method = RequestMethod.POST)
	@ResponseBody 
	public Map<String, Object> updateLeaveMonthMember(Model model, HttpSession session, HttpServletResponse response, HttpServletRequest request) {
		logger.info("======= updateLeaveMonthMember =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		Map<String,Object> resultMap = new HashMap<String,Object>();		
		
		paramMap.put("reg_user_no",String.valueOf(mbrVo.getUser_no()));
		
		//기존 등록된 휴직정보는 삭제한다.
		sqlSession.delete("Salary4Mapper.deleteMemberLeaveMonth", paramMap);
		
		//새로운 휴직 정보를 등록한다.		
		sqlSession.insert("Salary4Mapper.insertMemberLeaveMonth", paramMap);
		
		resultMap.put("result", "Success");
		
        return resultMap; 
	}
	
	@RequestMapping(value = "updateCareerMonthMember", method = RequestMethod.POST)
	@ResponseBody 
	public Map<String, Object> updateCareerMonthMember(Model model, HttpSession session, HttpServletResponse response, HttpServletRequest request) {
		logger.info("======= updateCareerMonthMember =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		Map<String,Object> resultMap = new HashMap<String,Object>();		
		
		paramMap.put("reg_user_no",String.valueOf(mbrVo.getUser_no()));
		
		//기존 등록된 경력은 삭제한다.
		sqlSession.delete("Salary4Mapper.deleteMemeberCareerMonth", paramMap);
		
		//새로운 경력 정보를 등록한다.
		sqlSession.insert("Salary4Mapper.insertMemeberCareerMonth", paramMap);
		
		resultMap.put("result", "Success");
		
        return resultMap; 
	}
	
	/**
	 * 팀장설정정보 불러오기
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/memberManagerListAjax", method = RequestMethod.POST)
	public String memberManagerListAjax(Model model, HttpServletRequest request, HttpSession session) {
		logger.info("======= memberManagerListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
		List<Map<String, Object>> userManagerList = sqlSession.selectList("Salary4Mapper.selectMemberManagerList", paramMap);
		
		model.addAttribute("userManagerList", userManagerList);

		return "top_salary_4/salary_member_manager_list_ajax";
	}
	
	/**
	 * 연봉설정 정보 가져오기
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/memberAnnualListAjax", method = RequestMethod.POST)
	public String memberAnnualListAjax(Model model, HttpServletRequest request, HttpSession session) {
		logger.info("======= memberAnnualListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
		List<Map<String, Object>> userAnnualList = sqlSession.selectList("Salary4Mapper.selectMemberAnnualList", paramMap);
		
		model.addAttribute("userAnnualList", userAnnualList);

		return "top_salary_4/salary_member_annual_list_ajax";
	}
	
	/**
	 * 인보험 직원정보(직무설정) 가져오기
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/salaryPartMemberListAjax", method = RequestMethod.POST)
	public String salaryPartMemberListAjax(Model model, HttpServletRequest request, HttpSession session) {
		logger.info("======= salaryPartMemberListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//예외자 명단 가져오기
		String sExceptMember = "";
		
		sExceptMember = sqlSession.selectOne("Salary4Mapper.selectSalaryExceptMemberInfoOne");
		
		paramMap.put("except_user_no", sExceptMember);
		
		List<Map<String, Object>> partMemberList = sqlSession.selectList("Salary4Mapper.selectSalary4PartMemberList", paramMap);
		
		model.addAttribute("partMemberList", partMemberList);
		
		//설정용 보험사 목록 불러오기		
		List<Map<String, Object>> selInsuList = sqlSession.selectList("Salary4Mapper.selectInsuCompanyListSel", paramMap);
		model.addAttribute("selInsuList", selInsuList);
		
		//설정용 직무 목록 불러오기
		List<Map<String, Object>> selPartList = sqlSession.selectList("Salary4Mapper.selectPartListSel", paramMap);
		model.addAttribute("selPartList", selPartList);
		
		model.addAttribute("srchParam",paramMap);
		
		return "top_salary_4/salary_part_member_list_ajax";
	}
	
	
	@RequestMapping(value = "/salesResultMemberListAjax", method = RequestMethod.POST)
	public String salesResultMemberListAjax(Model model, HttpServletRequest request, HttpSession session) {
		logger.info("======= salesResultMemberListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		
		paramMap.put("sales_date", String.valueOf(paramMap.get("result_sales_date")));
		
		List<Map<String,Object>> resultMemberList = sqlSession.selectList("Salary4Mapper.selectSalesConfirmList", paramMap);
		
		model.addAttribute("resultMemberList", resultMemberList);
		
		return "top_salary_4/salary_sales_regist_result_list_ajax";
	}
	/**
	 * 성과급 실적등록 목록 불러오기
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/salesMemberListAjax", method = RequestMethod.POST)
	public String salesMemberListAjax(Model model, HttpServletRequest request, HttpSession session) {
		logger.info("======= salesMemberListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		
		String sales_date = String.valueOf(paramMap.get("sales_date"));
		
		//예외자 명단 가져오기
		String sExceptMember = "";		
		sExceptMember = sqlSession.selectOne("Salary4Mapper.selectSalaryExceptMemberInfoOne");		
		paramMap.put("except_user_no", sExceptMember);
		
		List<Map<String, Object>> salesMemberList = sqlSession.selectList("Salary4Mapper.selectSalary4SalesMemberList", paramMap);
		
		String tempWorkMonth = "";
		int nChk = 0;		//실적등록여부 체크
		
		for( int i=0; i < salesMemberList.size(); i++ ) {
			tempWorkMonth = DateUtil.parseMonthToYear(String.valueOf(salesMemberList.get(i).get("total_work_month")));
			salesMemberList.get(i).put("total_work_month_txt", tempWorkMonth);			
			
			Map<String, Object> tempMap = new HashMap<>();
			
			paramMap.put("user_no", String.valueOf(salesMemberList.get(i).get("user_no")));
			
			nChk = sqlSession.selectOne("Salary4Mapper.selectSalary4SalsePayChk",paramMap);
			
			if( nChk == 1 ) {
				tempMap = sqlSession.selectOne("Salary4Mapper.selectSalary4SalsePayOne",paramMap);
				salesMemberList.get(i).put("loss_rate", String.valueOf(tempMap.get("loss_rate")));
				salesMemberList.get(i).put("minwon_cnt", String.valueOf(tempMap.get("minwon_cnt")));
				salesMemberList.get(i).put("part_pay", String.valueOf(tempMap.get("part_pay")));
				salesMemberList.get(i).put("sum_etc_pay", String.valueOf(tempMap.get("sum_etc_pay")));
				salesMemberList.get(i).put("sum_sales_pay", String.valueOf(tempMap.get("sum_sales_pay")));
				salesMemberList.get(i).put("sales_flag", 1);				//실정 미등록 : 0, 등록 : 1
				salesMemberList.get(i).put("skey", String.valueOf(tempMap.get("skey")));
			}else{
				salesMemberList.get(i).put("loss_rate", 0);
				salesMemberList.get(i).put("minwon_cnt", 0);
				salesMemberList.get(i).put("part_pay", 0);
				salesMemberList.get(i).put("sum_etc_pay", 0);
				salesMemberList.get(i).put("sum_sales_pay", 0);
				salesMemberList.get(i).put("sales_flag", 0);				//실정 미등록 : 0, 등록 : 1				
			}
			
		}
		
		model.addAttribute("salesMemberList",salesMemberList);		
		
		return "top_salary_4/salary_sales_regist_list_ajax";
	}
	
	@RequestMapping(value = "confirmSalary4BasePayCancel", method = RequestMethod.POST)
	@ResponseBody 
	public Map<String, Object> confirmSalary4BasePayCancel(Model model, HttpSession session, HttpServletResponse response, HttpServletRequest request) {
		logger.info("======= confirmSalary4BasePayCancel =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		//CommonUtils.printMap(paramMap);
		
		sqlSession.delete("Salary4Mapper.deleteBasePayCancel", paramMap);
		
		return resultMap;
	}
	
	/**
	 * 직원 개인의 월별 기본급 확정(추가,수정)
	 * @param model
	 * @param session
	 * @param response
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "confirmSalary4BasePayPerson", method = RequestMethod.POST)
	@ResponseBody 
	public Map<String, Object> confirmSalary4BasePayPerson(Model model, HttpSession session, HttpServletResponse response, HttpServletRequest request) {
		logger.info("======= confirmSalary4BasePayPerson =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		String base_sdate = String.valueOf(paramMap.get("base_sdate"));		//급여계산 기준 시작일
		String base_edate = String.valueOf(paramMap.get("base_edate"));		//급여계산 기준 종료일(근속, 경력의 기준은 종료일기준으로 계산한다)		
		
		//정산일자를 계산한다.
		String sales_date = base_edate.substring(0,8)+DateUtil.getMonthEndDay(base_edate);
		
		String user_no = String.valueOf(paramMap.get("user_no"));
		String team_id = String.valueOf(paramMap.get("team_id"));
		String work_level = String.valueOf(paramMap.get("work_level"));
		String join_date_fmt = String.valueOf(paramMap.get("join_date_fmt"));
		String work_month =  String.valueOf(paramMap.get("work_month"));
		String career_month =  String.valueOf(paramMap.get("career_month"));
		String leave_month =  String.valueOf(paramMap.get("leave_month"));
		String pay_flag =  String.valueOf(paramMap.get("pay_flag"));		
		String career_pay =  String.valueOf(paramMap.get("career_pay")).replaceAll(",", "");
		String work_pay =  String.valueOf(paramMap.get("work_pay")).replaceAll(",", "");
		String manager_pay =  String.valueOf(paramMap.get("manager_pay")).replaceAll(",", "");
		String base_total_pay =  String.valueOf(paramMap.get("base_total_pay")).replaceAll(",", "");
		
		if( "Annual".equals(pay_flag) ) {
			pay_flag = "1";
		}else {
			pay_flag = "0";
		}
		
		Map<String,Object> calBaseMap = new HashMap<String,Object>();			
		calBaseMap.put("user_no", user_no);
		calBaseMap.put("team_id", team_id);
		calBaseMap.put("work_level", work_level);
		calBaseMap.put("join_date_fmt", join_date_fmt);
		calBaseMap.put("work_month", work_month);
		calBaseMap.put("career_month", career_month);
		calBaseMap.put("leave_month", leave_month);
		calBaseMap.put("pay_flag", pay_flag);
		calBaseMap.put("career_pay", career_pay);
		calBaseMap.put("work_pay", work_pay);
		calBaseMap.put("manager_pay", manager_pay);
		calBaseMap.put("base_total_pay", base_total_pay);
		calBaseMap.put("sales_date", sales_date);
		calBaseMap.put("reg_user_no", String.valueOf(mbrVo.getUser_no()));
		
		//추가할것인지 수정할것인지 체크
		int nChk = sqlSession.selectOne("Salary4Mapper.selectSalaryCountBasePay",calBaseMap);
		
		if( nChk > 0 ) {		//갱신				
			sqlSession.update("Salary4Mapper.updateSalaryBasePay",calBaseMap);
			resultMap.put("result", "U");
		}else{					//등록
			sqlSession.insert("Salary4Mapper.insertSalaryBasePay",calBaseMap);
			resultMap.put("result", "I");
		}
		
		return resultMap;
	}
	
	/**
	 * 성과급(실적)등록
	 * @param model
	 * @param session
	 * @param response
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "confirmSalary4IncentivePay", method = RequestMethod.POST)
	@ResponseBody 
	public Map<String, Object> confirmSalary4IncentivePay(Model model, HttpSession session, HttpServletResponse response, HttpServletRequest request) {
		logger.info("======= confirmSalary4IncentivePay =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		Map<String,Object> resultMap = new HashMap<String,Object>();		
		Map<String,Object> updateMap = new HashMap<String,Object>(); //DB갱신용 Map
		
		String action_flag = String.valueOf(paramMap.get("action_flag"));		//I:추가, U:수정, D:삭제
		String chk_sdate = String.valueOf(paramMap.get("cal_chk_sdate"));		//급여계산 기준 시작일
		String chk_edate = String.valueOf(paramMap.get("cal_chk_edate"));		//급여계산 기준 종료일(근속, 경력의 기준은 종료일기준으로 계산한다)
		String sales_date = String.valueOf(paramMap.get("cal_sales_date"));		//정산일자
				
		updateMap.put("user_no", String.valueOf(paramMap.get("user_no_val")));
		updateMap.put("loss_rate", String.valueOf(paramMap.get("loss_rate")));
		updateMap.put("minwon_cnt", String.valueOf(paramMap.get("minwon_cnt")));
		updateMap.put("part_pay", String.valueOf(paramMap.get("cal_part_pay")));
		updateMap.put("self_option_pay", String.valueOf(paramMap.get("self_option_pay")).replaceAll(",", ""));
		updateMap.put("job_option_pay", String.valueOf(paramMap.get("job_option_pay")).replaceAll(",", ""));
		updateMap.put("etc1_option_pay", String.valueOf(paramMap.get("etc1_option_pay")).replaceAll(",", ""));
		updateMap.put("etc2_option_pay", String.valueOf(paramMap.get("etc2_option_pay")).replaceAll(",", ""));
		updateMap.put("result_cnt", String.valueOf(paramMap.get("result_count")).replaceAll(",", ""));
		updateMap.put("result_sales", String.valueOf(paramMap.get("result_sales")).replaceAll(",", ""));
		updateMap.put("cal_result_sales", String.valueOf(paramMap.get("cal_result_sales")).replaceAll(",", ""));
		updateMap.put("sum_sales_pay", String.valueOf(paramMap.get("total_sales_amount_val")).replaceAll(",", ""));
		updateMap.put("cal_reason_text", String.valueOf(paramMap.get("result_info_text_val")));
		updateMap.put("etc_memo", String.valueOf(paramMap.get("etc_memo")));
		updateMap.put("chk_sdate", String.valueOf(paramMap.get("cal_chk_sdate")));
		updateMap.put("chk_edate", String.valueOf(paramMap.get("cal_chk_edate")));
		updateMap.put("sales_date", String.valueOf(paramMap.get("cal_sales_date")));
		updateMap.put("reg_user_no", String.valueOf(mbrVo.getUser_no()));
		updateMap.put("skey", String.valueOf(paramMap.get("skey_val")));
		
		if( "I".equals(action_flag) ) {			//추가
			sqlSession.insert("Salary4Mapper.insertSalaryIncentivePay",updateMap);
			resultMap.put("result", "Insert");
		}else if( "U".equals(action_flag) ) {
			sqlSession.update("Salary4Mapper.updateSalaryIncentivePay",updateMap);
			resultMap.put("result", "Update");
		}else if( "D".equals(action_flag) ) {
			sqlSession.delete("Salary4Mapper.deleteSalaryIncentivePay", updateMap);
			resultMap.put("result", "Delete");
		}
		
		return resultMap;
	}
	
	/**
	 * 월별 기본급 확정 프로세스
	 * @param model
	 * @param session
	 * @param response
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "confirmSalary4BasePay", method = RequestMethod.POST)
	@ResponseBody 
	public Map<String, Object> confirmSalary4BasePay(Model model, HttpSession session, HttpServletResponse response, HttpServletRequest request) {
		logger.info("======= confirmSalary4BasePay =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		String base_sdate = String.valueOf(paramMap.get("base_sdate"));		//급여계산 기준 시작일
		String base_edate = String.valueOf(paramMap.get("base_edate"));		//급여계산 기준 종료일(근속, 경력의 기준은 종료일기준으로 계산한다)		
		
		//정산일자를 계산한다.
		String sales_date = base_edate.substring(0,8)+DateUtil.getMonthEndDay(base_edate);
		
		//연봉제 기본급 목록 계산과 동일한 로직시작
		//기본급 설정정보 가져오기
		Map<String, Object> salarySetupInfo = sqlSession.selectOne("Salary4Mapper.selectSalarySetupInfoSearch", base_edate);
		
		int nIntern_pay = 0;
		int nIntern_pay_1 = 0;
		int nIntern_pay_2 = 0;
		int nIntern_pay_3 = 0;
		
		int nCareer_pay_1 = 0;
		int nCareer_pay_2 = 0;
		int nCareer_pay_3 = 0;
		int nCareer_pay_4 = 0;
		
		int nConti_pay_1 = 0;
		int nConti_pay_2 = 0;
		int nConti_pay_3 = 0;
		int nConti_pay_4 = 0;
		
		int nManager_pay = 0;
		
		//기본급 최대허용액
		int nMax_pay = 0;		
		
		nIntern_pay = Integer.parseInt(String.valueOf(salarySetupInfo.get("intern_pay")));
		nIntern_pay_1 = Integer.parseInt(String.valueOf(salarySetupInfo.get("intern_pay_1")));
		nIntern_pay_2 = Integer.parseInt(String.valueOf(salarySetupInfo.get("intern_pay_2")));
		nIntern_pay_3 = Integer.parseInt(String.valueOf(salarySetupInfo.get("intern_pay_3")));
		
		nCareer_pay_1 = Integer.parseInt(String.valueOf(salarySetupInfo.get("career_pay_1")));
		nCareer_pay_2 = Integer.parseInt(String.valueOf(salarySetupInfo.get("career_pay_2")));
		nCareer_pay_3 = Integer.parseInt(String.valueOf(salarySetupInfo.get("career_pay_3")));
		nCareer_pay_4 = Integer.parseInt(String.valueOf(salarySetupInfo.get("career_pay_4")));
		
		nConti_pay_1 = Integer.parseInt(String.valueOf(salarySetupInfo.get("conti_pay_1")));
		nConti_pay_2 = Integer.parseInt(String.valueOf(salarySetupInfo.get("conti_pay_2")));
		nConti_pay_3 = Integer.parseInt(String.valueOf(salarySetupInfo.get("conti_pay_3")));
		nConti_pay_4 = Integer.parseInt(String.valueOf(salarySetupInfo.get("conti_pay_4")));
		
		nManager_pay = Integer.parseInt(String.valueOf(salarySetupInfo.get("manager_pay")));
		nMax_pay = Integer.parseInt(String.valueOf(salarySetupInfo.get("max_pay")));
		
		//예외자 명단 가져오기
		String sExceptMember = "";
		
		sExceptMember = sqlSession.selectOne("Salary4Mapper.selectSalaryExceptMemberInfoOne");
		
		paramMap.put("except_user_no", sExceptMember);
		
		//정산일자 추가
		paramMap.put("sales_date", sales_date);
		
		List<Map<String, Object>> memberList = sqlSession.selectList("Salary4Mapper.selectSalary4MemberList", paramMap);
				
		String sWorkDateVal = "";				//입사일 이후 근무월 표시
		String sCareerDateVal = "";				//과거 경력일 표시
		String sLeaveDateVal = "";				//무급 휴직일 표시
		String sTempMonth = "";
		
		int nTotalBasePay = 0;						//기본급 합계
		int nCareerPay = 0;		//경력급여합
		int nWorkPay = 0;		//근속수당합
		int nManagerPay = 0;	//개인별 팀장수당
		
		String sJoinDate = "";						//입사일자
		
		int nWorkMonth = 0;
		int nCareerMonth = 0;
		int nLeaveMonth = 0;						//무급휴직일수
		int nTotalMonth = 0;
		
		for(int i=0; i < memberList.size(); i++) {
			//경력 및 근속연수 계산 시작
			sTempMonth = memberList.get(i).get("work_month").toString();
			nWorkMonth = Integer.parseInt(sTempMonth);					//근속월수 
			sWorkDateVal = DateUtil.parseMonthToYear(sTempMonth);
			memberList.get(i).put("work_month_val", sWorkDateVal);
			
			sTempMonth = memberList.get(i).get("career_month").toString();
			nCareerMonth = Integer.parseInt(sTempMonth);				//경력월수
			sCareerDateVal = DateUtil.parseMonthToYear(sTempMonth);
			memberList.get(i).put("career_month_val", sCareerDateVal);
			
			sTempMonth = memberList.get(i).get("leave_month").toString();
			nLeaveMonth = Integer.parseInt(sTempMonth);				//휴직월수
			sLeaveDateVal = DateUtil.parseMonthToYear(sTempMonth);
			memberList.get(i).put("leave_month_val", sLeaveDateVal);
			
			nTotalMonth = nWorkMonth + nCareerMonth - nLeaveMonth;
			//총 경력 월수계산
			//System.out.println(memberList.get(i).get("user_name").toString()+" : "+ nTotalMonth +"="+ nWorkMonth + "+" + nCareerMonth);
			//경력 및 근속연수 계산 끝
			
			//입사일자
			sJoinDate = String.valueOf(memberList.get(i).get("join_date_fmt"));
			
			nTotalBasePay = 0;
			
			//급여 타입 분류 (payFlag = 0:월급제, 1:연봉제)
			String payFlag = "0";
			
			//검색기간의 한 달 일수
			int nFullMonthDay = DateUtil.getDiffDayCountNew(base_sdate, base_edate)+1;			
			
			//기본급 계산 시작
			//수습직원 여부 체크
			if( "5".equals(String.valueOf(memberList.get(i).get("work_level"))) ) {
				//입사일자 기준 한달 초과 여부확인
				if( DateUtil.compareDate(base_sdate, sJoinDate) == 1 ) {			//입사일자가 급여정산 시작일 이후인 경우
					nTotalBasePay = nIntern_pay * (DateUtil.getDiffDayCountNew( sJoinDate, base_edate )+1) / nFullMonthDay;					
				}else{
					nTotalBasePay = nIntern_pay;
				}
				
				//수습직원은 기본급 외 0원
				memberList.get(i).put("total_career_pay", nTotalBasePay);
				memberList.get(i).put("total_work_pay", 0);
				memberList.get(i).put("manager_pay", 0);
			}else{			//수습직원이 아닌 경우 (연봉직원 향후 별도처리)
				
				//경력급여계산(1,2,3,4년차)
				if( nTotalMonth < 12 ) {
					nCareerPay = nCareer_pay_1;
				}else if( nTotalMonth >= 12 && nTotalMonth < 24) {
					nCareerPay = nCareer_pay_2;
				}else if( nTotalMonth >= 24 && nTotalMonth < 36 ) {
					nCareerPay = nCareer_pay_3;
				}else if( nTotalMonth >= 36 ){
					nCareerPay = nCareer_pay_4;
				}
				
				if( DateUtil.compareDate(base_sdate, sJoinDate) == 1 ) {			//입사일자가 급여정산 시작일 이후 (일할계산해야함)					
					nCareerPay = Math.round(nCareerPay * (DateUtil.getDiffDayCountNew( sJoinDate, base_edate )+1) / nFullMonthDay);					
				}
				
				//기본급(근속+경력기간) 확정
				memberList.get(i).put("total_career_pay", nCareerPay);
				
				//근속수당 계산
				if( nWorkMonth < 12 ) {
					nWorkPay = 0;
				}else if( nWorkMonth >= 12 && nWorkMonth < 24) {
					nWorkPay = nConti_pay_1;
				}else if( nWorkMonth >= 24 && nWorkMonth < 36 ) {
					nWorkPay = nConti_pay_2;
				}else if( nWorkMonth >= 26 && nWorkMonth < 48 ) {
					nWorkPay = nConti_pay_3;
				}else if( nWorkMonth >= 48 ){
					nWorkPay = nConti_pay_4;
				}
				
				//근속수당 확정
				memberList.get(i).put("total_work_pay", nWorkPay);
				
				//기본급합계에 기본급+근속수당으로 합산
				nTotalBasePay = nCareerPay + nWorkPay;				
				
				//팀장 수당 계산시작
				paramMap.put("user_no", String.valueOf(memberList.get(i).get("user_no")));				
				
				int nCnt = sqlSession.selectOne("Salary4Mapper.selectMemberManagerCnt", paramMap);				
				
				if( nCnt == 1 ) {
					Map<String, Object> ManagerDateMap = sqlSession.selectOne("Salary4Mapper.selectMemberManagerDate", paramMap);
					String manager_sdate = String.valueOf(ManagerDateMap.get("manager_sdate_fmt"));
					String manager_edate = String.valueOf(ManagerDateMap.get("manager_edate_fmt"));					
					
					//팀장기간이 조회기간보다 큰 경우
					if( DateUtil.compareDate(base_sdate, manager_sdate) <= 0 && DateUtil.compareDate(base_edate, manager_edate) == 1 ) {
						//기본 팀장수당을 할당
						nManagerPay = nManager_pay;
					}else if( DateUtil.compareDate(base_sdate, manager_sdate) <= 0 &&  DateUtil.compareDate(base_edate, manager_edate) <= 0 ) {
						nManagerPay = Math.round(nManager_pay * (DateUtil.getDiffDayCountNew( base_sdate, manager_edate )+1) / nFullMonthDay );
					}else if( DateUtil.compareDate(base_sdate, manager_sdate) == 1 && DateUtil.compareDate(base_edate, manager_edate) == 1 ) {
						//System.out.println("팀장시작기간은 조회기간보다 이후이고 종료기간도 조회기간보다 느린경우 : "+(DateUtil.getDiffDayCountNew( manager_sdate, base_edate )+1));
						nManagerPay = Math.round(nManager_pay * (DateUtil.getDiffDayCountNew( manager_sdate, base_edate )+1) / nFullMonthDay );
					}else if( DateUtil.compareDate(base_sdate, manager_sdate) == 1 && DateUtil.compareDate(base_edate, manager_edate) <= 0 ) {
						//System.out.println("팀장 기간이 조회기간 안에 포함되는 경우 : "+(DateUtil.getDiffDayCountNew( manager_sdate, manager_edate )+1));
						nManagerPay = Math.round(nManager_pay * (DateUtil.getDiffDayCountNew( manager_sdate, manager_edate )+1) / nFullMonthDay );
					}else{
						//System.out.println("예외인경우");
						nManagerPay = 0;
					}					
				}else{
					nManagerPay = 0;
				}
				
				memberList.get(i).put("manager_pay", nManagerPay);
				//팀장 수당계산 끝
				
				//기본급 합계값에 팀장수당을 추가한다.
				nTotalBasePay += nManagerPay;
			}
			
			//기본급이 최대 허용치를 넘는지 확인해서 넘는경우 최대액으로 설정
			if( nMax_pay < nTotalBasePay ) {
				nTotalBasePay = nMax_pay;
			}
			
			memberList.get(i).put("base_total_pay", nTotalBasePay);
			//기본급 계산 끝
			
			//연봉제 계산시작
			//등록된 연봉제 정보가 있는지 확인한다.
			int nAnnualChk = 0;
			
			paramMap.put("user_no", String.valueOf(memberList.get(i).get("user_no")));

			nAnnualChk = sqlSession.selectOne("Salary4Mapper.selectSalaryAnnualMemberCnt", paramMap);
			
			if( nAnnualChk > 0 ) {			//연봉제 정보가 있는경우만 재계산한다. (급여정산기간중 1개 또는 2개가 있을수 있음)
				
				payFlag = "1";				//연봉제 직원			
				
				List<Map<String, Object>> annualInfoList = sqlSession.selectList("Salary4Mapper.selectSalaryMemberAnnualListSearch", paramMap);
				
				String sAnnualSdate = "";		//연봉계약 시작일(임시)
				String sAnnualEdate = "";		//연봉계약 종료일(임시)
				String sAnnualSdate_sub = "";		//연봉계약 시작일(임시)
				String sAnnualEdate_sub = "";		//연봉계약 종료일(임시)
				int nAnnualPay = 0;				//연봉액 (임시)
				int nAnnualPay_sub = 0;		//연봉액 (임시), 신규연봉계약액
				
				int nTempPay0 = 0;				//임시 합계 0
				int nTempPay1 = 0;				//임시 합계 1
				
				if( nAnnualChk == 1 ) {				//연봉계약기간에 급여산정기간이 1개 포함된경우
					sAnnualSdate = String.valueOf(annualInfoList.get(0).get("annual_sdate_fmt"));
					sAnnualEdate = String.valueOf(annualInfoList.get(0).get("annual_edate_fmt"));
					nAnnualPay = (int)annualInfoList.get(0).get("annual_pay");
					
					//계약기간이 급여산정 시작일보자 이전(같은날 포함) 이고, 급여산정 종료일보다 이후(같은날 포함)
					if( DateUtil.compareDate( base_sdate, sAnnualSdate) <= 0 && DateUtil.compareDate(base_edate, sAnnualEdate) >= 0 ) {
						//기본급을 연봉의 1/12 로 계산한다. (기본급, 기본급 합계는 동일하게 처리한다. 1개월 완전 연봉제인경우 수당은 0원으로 처리)
						nCareerPay = Math.round(nAnnualPay / 12);
						nTotalBasePay = nCareerPay;
						
					//계약기간이 급여산정 시작일보다 이전(같은날 포함) 이고, 급여산정 종료일보다는 이전인 경우	
					}else if( DateUtil.compareDate( base_sdate, sAnnualSdate) <= 0 && DateUtil.compareDate(base_edate, sAnnualEdate) < 0 ) {					
						//연봉을 일할계산
						nTempPay0 = nAnnualPay * ( DateUtil.getDiffDayCountNew( base_sdate, sAnnualEdate )+1 ) / (nFullMonthDay * 12);
						//기본급을 일할계산
						nTempPay1 = nTotalBasePay * DateUtil.getDiffDayCountNew( sAnnualEdate, base_edate ) / nFullMonthDay;					
						
						nTotalBasePay = Math.round(nTempPay0 + nTempPay1);
						nCareerPay = nTotalBasePay;
						
					//계약기간이 급여산정 시작일 이후이고, 급여산정 종료일보다 이후(같은날 포함)
					}else if( DateUtil.compareDate( base_sdate, sAnnualSdate) > 0 && DateUtil.compareDate(base_edate, sAnnualEdate) >= 0) {
						//연봉을 일할계산
						nTempPay0 = nAnnualPay * ( DateUtil.getDiffDayCountNew( sAnnualSdate, base_edate )+1 ) / (nFullMonthDay * 12);					
						//기본급을 일할계산
						nTempPay1 = nTotalBasePay * DateUtil.getDiffDayCountNew( base_sdate, sAnnualSdate ) / nFullMonthDay;
						
						nTotalBasePay = Math.round(nTempPay0 + nTempPay1);
						nCareerPay = nTotalBasePay;					
					}
					
				}else if( nAnnualChk == 2 ) {		//연봉계약기간에 급여산정기간이 2개 포함된경우 (산정기간에 연봉계약일이 있는 경우.. 연봉제로 갱신하는 경우)
										
					//이전계약내역
					sAnnualSdate = String.valueOf(annualInfoList.get(0).get("annual_sdate_fmt"));
					sAnnualEdate = String.valueOf(annualInfoList.get(0).get("annual_edate_fmt"));
					nAnnualPay = (int)annualInfoList.get(0).get("annual_pay");
					
					//후기계약내역
					//이전계약내역
					sAnnualSdate_sub = String.valueOf(annualInfoList.get(1).get("annual_sdate_fmt"));
					sAnnualEdate_sub = String.valueOf(annualInfoList.get(1).get("annual_edate_fmt"));
					nAnnualPay_sub = (int)annualInfoList.get(1).get("annual_pay");									
					
					nTempPay0 = nAnnualPay * ( DateUtil.getDiffDayCountNew( base_sdate, sAnnualEdate )+1 ) / (nFullMonthDay * 12);
					
					nTempPay1 = nAnnualPay_sub * ( DateUtil.getDiffDayCountNew( sAnnualSdate_sub, base_edate )+1 ) / (nFullMonthDay * 12);
					
					nTotalBasePay = Math.round(nTempPay0 + nTempPay1);
					nCareerPay = nTotalBasePay;				
				}
				
				memberList.get(i).put("total_career_pay", nCareerPay);		//근속수당
				memberList.get(i).put("base_total_pay", nTotalBasePay);	//기본급 합계
				memberList.get(i).put("total_work_pay", 0);			//근속수당					
				memberList.get(i).put("manager_pay", 0);			//팀장 수당	
				
			}			
			//연봉제 계산 끝
			
			//급여방식 셋팅(플래그)
			//top_salary_4_base 추가시에는 pay_flag 가 0:월급제, 1:연봉제로 등록됨
			memberList.get(i).put("pay_flag", payFlag);			
		}				
		//연봉제 기본급 목록 계산과 동일한 로직 끝
		
		//top_salary_4_base 에 입력 시작		
		//조회 기준 : user_no, sales_date		
		int nChk = 0;			//추가 갱신여부 체크
		int nUpdateCnt = 0;		//갱신 수
		int nInsertCnt = 0;		//추가 수
		
		for( int k=0; k < memberList.size(); k++) {
			//업데이트용 맵
			Map<String,Object> calBaseMap = new HashMap<String,Object>();			
			calBaseMap.put("user_no", String.valueOf(memberList.get(k).get("user_no")));
			calBaseMap.put("team_id", String.valueOf(memberList.get(k).get("team_id")));
			calBaseMap.put("work_level", String.valueOf(memberList.get(k).get("work_level")));
			calBaseMap.put("join_date_fmt", String.valueOf(memberList.get(k).get("join_date_fmt")));
			calBaseMap.put("work_month", String.valueOf(memberList.get(k).get("work_month")));
			calBaseMap.put("career_month", String.valueOf(memberList.get(k).get("career_month")));
			calBaseMap.put("leave_month", String.valueOf(memberList.get(k).get("leave_month")));
			calBaseMap.put("pay_flag", String.valueOf(memberList.get(k).get("pay_flag")));
			calBaseMap.put("career_pay", String.valueOf(memberList.get(k).get("total_career_pay")));
			calBaseMap.put("work_pay", String.valueOf(memberList.get(k).get("total_work_pay")));
			calBaseMap.put("manager_pay", String.valueOf(memberList.get(k).get("manager_pay")));
			calBaseMap.put("base_total_pay", String.valueOf(memberList.get(k).get("base_total_pay")));
			calBaseMap.put("sales_date", sales_date);
			calBaseMap.put("reg_user_no", String.valueOf(mbrVo.getUser_no()));
			
			nChk = sqlSession.selectOne("Salary4Mapper.selectSalaryCountBasePay",calBaseMap);
			
			if( nChk > 0 ) {		//갱신				
				sqlSession.update("Salary4Mapper.updateSalaryBasePay",calBaseMap);
				nUpdateCnt++;
			}else{					//등록
				sqlSession.insert("Salary4Mapper.insertSalaryBasePay",calBaseMap);
				nInsertCnt++;
			}
			
		}		
		
		//top_salary_4_base 에 입력 끝
		resultMap.put("insertCnt", nInsertCnt);
		resultMap.put("updateCnt", nUpdateCnt);
		
        return resultMap; 
	}
	
	/**
	 * 기본급 확정목록 가져오기
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/salaryConfirmListAjax", method = RequestMethod.POST)
	public String salaryConfirmListAjax(Model model, HttpServletRequest request, HttpSession session) {
		logger.info("======= salaryConfirmListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String base_sdate = String.valueOf(paramMap.get("base_sdate_confirm"));		//급여계산 기준 시작일
		String base_edate = String.valueOf(paramMap.get("base_edate_confirm"));		//급여계산 기준 종료일(근속, 경력의 기준은 종료일기준으로 계산한다)
		
		String sales_date = base_edate.substring(0,8)+DateUtil.getMonthEndDay(base_edate);
		
		paramMap.put("sales_date", sales_date);
		
		//기본급 확정목록을 정산일 기준으로 불러온다.
		List<Map<String, Object>> confirmList = sqlSession.selectList("Salary4Mapper.selectBaseConfirmList", paramMap);
		
		model.addAttribute("confirmList", confirmList);
		
		//CommonUtils.printMap(paramMap);
		
		return "top_salary_4/salary_confirm_list_ajax";
	}
	
	/**
	 * 급여 통합조회 상세모기 모달
	 * @param request
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/salaryMasterDetailModal")
	public String salaryMasterDetailModal(HttpServletRequest request, Model model, HttpSession session) {
		logger.info("======= salaryMasterDetailModal =======");
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        //CommonUtils.printMap(paramMap);
        
        //상세보기 Map
        Map<String, Object> userMap = new HashMap<>();
        
        //기본정보 및 기본급 정보 셋팅
        userMap = sqlSession.selectOne("Salary4Mapper.selectSalaryInsaForBaseOne", paramMap);
        
        //총 경력표시
        String total_work_month_text = DateUtil.parseMonthToYear(String.valueOf(userMap.get("total_work_month")));        
        userMap.put("total_work_month_text", total_work_month_text);
         
        //년차표시
        int nTotalWorkYear = Integer.parseInt(String.valueOf(userMap.get("total_work_year")));
        
        if( nTotalWorkYear == 4) {
        	userMap.put("total_work_year_text", nTotalWorkYear+"년차 이상");
        }else{
        	userMap.put("total_work_year_text", nTotalWorkYear+"년차");
        }
        
        //경력일수
        String work_month_text = DateUtil.parseMonthToYear(String.valueOf(userMap.get("work_month")));        
        userMap.put("work_month_text", work_month_text);
        
        //근속일수
        String career_month_text = DateUtil.parseMonthToYear(String.valueOf(userMap.get("career_month")));        
        userMap.put("career_month_text", career_month_text);
        
        //휴직일수
        String leave_month_text = DateUtil.parseMonthToYear(String.valueOf(userMap.get("leave_month")));        
        userMap.put("leave_month_text", leave_month_text);
        
        String pkey = String.valueOf(userMap.get("salary_4_part"));
        
        //성과급 환경 정보 시작
        Map<String, Object> partMap = new HashMap<>();
        
        if( "0".equals(pkey) ) {			//pkey 가 0이면 직무 미지정으로 처리
        	//초기화 정보로 넣어준다.
        	userMap.put("unit_sales", 0);
            userMap.put("loss_rate", 0);
            userMap.put("base_count", 0);
            userMap.put("base_sales", 0);
            userMap.put("insu_type",0);
            userMap.put("count_chk_point_1", 0);
    		userMap.put("count_chk_point_2", 0);
    		userMap.put("count_chk_point_3", 0);
    		userMap.put("sales_chk_point_1", 0);
    		userMap.put("sales_chk_point_2", 0);
    		userMap.put("sales_chk_point_3", 0);
    		userMap.put("payout_rate_1", 0);
    		userMap.put("payout_rate_2", 0);
    		userMap.put("payout_rate_3", 0);
    		userMap.put("payout_rate_4", 0);
    		userMap.put("fail_rate", 0);
        }else{
        	partMap = sqlSession.selectOne("Salary4Mapper.selectSalaryPartInfoOne", pkey);
    		
    		//건당금액
            userMap.put("unit_sales", StringUtil.toMoneyString(Integer.parseInt(String.valueOf(partMap.get("unit_sales")))));
    		//기준 손감율
            userMap.put("loss_rate", String.valueOf(partMap.get("loss_rate")));
    		//(최소)기본건수
            userMap.put("base_count", StringUtil.toMoneyString(Integer.parseInt(String.valueOf(partMap.get("base_count")))));
    		//(최소)기본매출액
            userMap.put("base_sales", StringUtil.toMoneyString(Integer.parseInt(String.valueOf(partMap.get("base_sales")))));
    		
    		//구간안내 기준변수
    		//건수기준
    		String sCountChkPoint1 = "";
    		String sCountChkPoint2 = "";
    		String sCountChkPoint3 = "";		
    		
    		//매출액기준
    		String sSalesChkPoint1 = "";
    		String sSalesChkPoint2 = "";
    		String sSalesChkPoint3 = "";
    		
    		//소속된 직무정보로 건수 / 매출액 의 기준을 확인한다.
    		String insu_type = String.valueOf(partMap.get("incentive_type"));
    		
    		userMap.put("insu_type",insu_type);			//1:종결건, 2:매출액
    		
    		String work_year_flag = String.valueOf(userMap.get("total_work_year"));
    		
    		//구간기준	(1~4년차)
    		if( "2".equals(work_year_flag) ){			//2년차
    			sCountChkPoint1 = String.valueOf(partMap.get("count_chk_point_2_1"));
    			sCountChkPoint2 = String.valueOf(partMap.get("count_chk_point_2_2"));
    			sCountChkPoint3 = String.valueOf(partMap.get("count_chk_point_2_3"));
    			
    			sSalesChkPoint1 = String.valueOf(partMap.get("sales_chk_point_2_1"));
    			sSalesChkPoint2 = String.valueOf(partMap.get("sales_chk_point_2_2"));
    			sSalesChkPoint3 = String.valueOf(partMap.get("sales_chk_point_2_3"));
    		}else if( "3".equals(work_year_flag) ){	//3년차
    			sCountChkPoint1 = String.valueOf(partMap.get("count_chk_point_3_1"));
    			sCountChkPoint2 = String.valueOf(partMap.get("count_chk_point_3_2"));
    			sCountChkPoint3 = String.valueOf(partMap.get("count_chk_point_3_3"));
    			
    			sSalesChkPoint1 = String.valueOf(partMap.get("sales_chk_point_3_1"));
    			sSalesChkPoint2 = String.valueOf(partMap.get("sales_chk_point_3_2"));
    			sSalesChkPoint3 = String.valueOf(partMap.get("sales_chk_point_3_3"));
    		}else if( "4".equals(work_year_flag) ){	//4년차
    			sCountChkPoint1 = String.valueOf(partMap.get("count_chk_point_4_1"));
    			sCountChkPoint2 = String.valueOf(partMap.get("count_chk_point_4_2"));
    			sCountChkPoint3 = String.valueOf(partMap.get("count_chk_point_4_3"));
    			
    			sSalesChkPoint1 = String.valueOf(partMap.get("sales_chk_point_4_1"));
    			sSalesChkPoint2 = String.valueOf(partMap.get("sales_chk_point_4_2"));
    			sSalesChkPoint3 = String.valueOf(partMap.get("sales_chk_point_4_3"));
    		}else{												//1년차
    			sCountChkPoint1 = String.valueOf(partMap.get("count_chk_point_1_1"));
    			sCountChkPoint2 = String.valueOf(partMap.get("count_chk_point_1_2"));
    			sCountChkPoint3 = String.valueOf(partMap.get("count_chk_point_1_3"));
    			
    			sSalesChkPoint1 = String.valueOf(partMap.get("sales_chk_point_1_1"));
    			sSalesChkPoint2 = String.valueOf(partMap.get("sales_chk_point_1_2"));
    			sSalesChkPoint3 = String.valueOf(partMap.get("sales_chk_point_1_3"));
    		}
    		
    		//구간 값 Set (최소 값에 증분값만큼 추가해서 넣어준다.)		
    		int nBaseCount = Integer.parseInt(String.valueOf(partMap.get("base_count")));
    		int nBaseSales = Integer.parseInt(String.valueOf(partMap.get("base_sales")));		

    		sCountChkPoint1 = StringUtil.toMoneyString( ( nBaseCount + Integer.parseInt(sCountChkPoint1) ) );
    		sCountChkPoint2 = StringUtil.toMoneyString( ( nBaseCount + Integer.parseInt(sCountChkPoint2) ) );
    		sCountChkPoint3 = StringUtil.toMoneyString( ( nBaseCount + Integer.parseInt(sCountChkPoint3) ) );		
    		
    		sSalesChkPoint1 = StringUtil.toMoneyString( ( nBaseSales + Integer.parseInt(sSalesChkPoint1) ) );
    		sSalesChkPoint2 = StringUtil.toMoneyString( ( nBaseSales + Integer.parseInt(sSalesChkPoint2) ) );
    		sSalesChkPoint3 = StringUtil.toMoneyString( ( nBaseSales + Integer.parseInt(sSalesChkPoint3) ) );
    		
    		userMap.put("count_chk_point_1", sCountChkPoint1 );
    		userMap.put("count_chk_point_2", sCountChkPoint2 );
    		userMap.put("count_chk_point_3", sCountChkPoint3 );
    		userMap.put("sales_chk_point_1", sSalesChkPoint1 );
    		userMap.put("sales_chk_point_2", sSalesChkPoint2 );
    		userMap.put("sales_chk_point_3", sSalesChkPoint3 );
    		
    		//지급율 Set
    		userMap.put("payout_rate_1", String.valueOf(partMap.get("payout_rate_1")));
    		userMap.put("payout_rate_2", String.valueOf(partMap.get("payout_rate_2")));
    		userMap.put("payout_rate_3", String.valueOf(partMap.get("payout_rate_3")));
    		userMap.put("payout_rate_4", String.valueOf(partMap.get("payout_rate_4")));
    		
    		//손감미달성시
    		userMap.put("fail_rate", String.valueOf(partMap.get("fail_rate")));
        }
		
        //성과급 환경 정보 끝
		
		//성과급 실적 가져오기 시작
		
		int nSalesCnt = sqlSession.selectOne("Salary4Mapper.selectSalarySalesInfoOneSearchCnt", paramMap);
		
		if( nSalesCnt == 1 ) {
			Map<String, Object> salesMap = sqlSession.selectOne("Salary4Mapper.selectSalarySalesInfoOneSearch", paramMap);
			
			userMap.put("self_option_pay", StringUtil.toMoneyString(String.valueOf(salesMap.get("self_option_pay"))));
			userMap.put("job_option_pay", StringUtil.toMoneyString(String.valueOf(salesMap.get("job_option_pay"))));
			userMap.put("etc1_option_pay", StringUtil.toMoneyString(String.valueOf(salesMap.get("etc1_option_pay"))));
			userMap.put("etc2_option_pay", StringUtil.toMoneyString(String.valueOf(salesMap.get("etc2_option_pay"))));
			userMap.put("etc_memo", String.valueOf(salesMap.get("etc_memo")).replaceAll("\n", "<br/>"));
			userMap.put("update_loss_rate", String.valueOf(salesMap.get("loss_rate")));
			userMap.put("minwon_cnt", String.valueOf(salesMap.get("minwon_cnt")));
			userMap.put("result_count", String.valueOf(salesMap.get("result_cnt")));
			userMap.put("result_sales", String.valueOf(salesMap.get("result_sales")));
			userMap.put("cal_result_sales", StringUtil.toMoneyString(String.valueOf(salesMap.get("cal_result_sales"))));
			userMap.put("cal_reason_text", String.valueOf(salesMap.get("cal_reason_text")));			
			userMap.put("sum_sales_pay", String.valueOf(salesMap.get("sum_sales_pay")));	
		}else {
			userMap.put("self_option_pay", 0);
			userMap.put("job_option_pay", 0);
			userMap.put("etc1_option_pay", 0);
			userMap.put("etc2_option_pay", 0);
			userMap.put("etc_memo", "");
			userMap.put("user_loss_rate", 0);
			userMap.put("minwon_cnt", 0);
			userMap.put("result_count", 0);
			userMap.put("result_sales", 0);
			userMap.put("cal_result_sales", 0);
			userMap.put("cal_reason_text", 0);			
			userMap.put("sum_sales_pay", 0);
		}	
        //성과급 실적 가져오기 끝        
        
        userMap.put("user_no", String.valueOf(paramMap.get("user_no")));
        userMap.put("sales_date", String.valueOf(paramMap.get("sales_date")));
        userMap.put("base_sdate", String.valueOf(paramMap.get("base_sdate")));
        userMap.put("base_edate", String.valueOf(paramMap.get("base_edate")));
        userMap.put("chk_sdate", String.valueOf(paramMap.get("chk_sdate")));
        userMap.put("chk_edate", String.valueOf(paramMap.get("chk_edate")));
        
		model.addAttribute("userMap", userMap);
        
		return "top_salary_4/salary_master_person_detail_modal";
	}
	
	/**
	 * 급여통합조회 엑셀 다운로드
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/salaryMasterListExcel", method = RequestMethod.POST)
	public String salaryMasterListExcel(Model model, HttpServletRequest request, HttpSession session) {
		logger.info("======= salaryMasterListExcel =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String base_sdate = String.valueOf(paramMap.get("base_sdate"));		//급여계산 기준 시작일
		String base_edate = String.valueOf(paramMap.get("base_edate"));		//급여계산 기준 종료일(근속, 경력의 기준은 종료일기준으로 계산한다)
		
		String sales_date = base_edate.substring(0,8)+DateUtil.getMonthEndDay(base_edate);		
		
		//예외자 명단 가져오기
		String sExceptMember = "";
		
		sExceptMember = sqlSession.selectOne("Salary4Mapper.selectSalaryExceptMemberInfoOne");
		
		paramMap.put("except_user_no", sExceptMember);
		
		paramMap.put("sales_date", sales_date);
		
		List<Map<String, Object>> masterList = sqlSession.selectList("Salary4Mapper.selectSalary4MasterList", paramMap);
		
		String total_work_month_txt = "";
		String work_month_txt = "";
		String career_month_txt = "";
		String leave_month_txt = "";
		String etc_memo_temp = "";
		
		for( int i=0; i < masterList.size(); i++ ) {
			total_work_month_txt = String.valueOf(masterList.get(i).get("total_work_month"));
			if( total_work_month_txt != null ) {
				total_work_month_txt = DateUtil.parseMonthToYear(total_work_month_txt);
			}else{
				total_work_month_txt = "0개월";
			}
			
			work_month_txt = String.valueOf(masterList.get(i).get("work_month"));
			if( work_month_txt != null ) {
				work_month_txt = DateUtil.parseMonthToYear(work_month_txt);
			}else{
				work_month_txt = "0개월";
			}
			
			career_month_txt = String.valueOf(masterList.get(i).get("career_month"));
			if( career_month_txt != null ) {
				career_month_txt = DateUtil.parseMonthToYear(career_month_txt);
			}else{
				career_month_txt = "0개월";
			}
			
			leave_month_txt = String.valueOf(masterList.get(i).get("leave_month"));
			if( leave_month_txt != null ) {
				leave_month_txt = DateUtil.parseMonthToYear(leave_month_txt);
			}else{
				leave_month_txt = "0개월";
			}
			
			masterList.get(i).put("total_work_month_txt", total_work_month_txt);
			masterList.get(i).put("work_month_txt", work_month_txt);
			masterList.get(i).put("career_month_txt", career_month_txt);
			masterList.get(i).put("leave_month_txt", leave_month_txt);
			
			//비고 값 수정
			etc_memo_temp = String.valueOf(masterList.get(i).get("etc_memo"));
			masterList.get(i).put("etc_memo", etc_memo_temp.replaceAll("\n", "<br/>"));
			//returnMap.put("etc_memo", String.valueOf(salesMap.get("etc_memo")).replaceAll("\n", "<br/>"));
		}
		
		model.addAttribute("masterList", masterList);
		model.addAttribute("sales_date", sales_date);
		
		return "top_salary_4/salary_master_person_list_excel";
	}
	
	/**
	 * 급여통합조회 목록 불러오기
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/salaryMasterListAjax", method = RequestMethod.POST)
	public String salaryMasterListAjax(Model model, HttpServletRequest request, HttpSession session) {
		logger.info("======= salaryMasterListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String base_sdate = String.valueOf(paramMap.get("base_sdate"));		//급여계산 기준 시작일
		String base_edate = String.valueOf(paramMap.get("base_edate"));		//급여계산 기준 종료일(근속, 경력의 기준은 종료일기준으로 계산한다)
		
		String sales_date = base_edate.substring(0,8)+DateUtil.getMonthEndDay(base_edate);
		
		//CommonUtils.printMap(paramMap);
		
		//예외자 명단 가져오기
		String sExceptMember = "";
		
		sExceptMember = sqlSession.selectOne("Salary4Mapper.selectSalaryExceptMemberInfoOne");
		
		paramMap.put("except_user_no", sExceptMember);
		
		paramMap.put("sales_date", sales_date);
		
		List<Map<String, Object>> masterList = sqlSession.selectList("Salary4Mapper.selectSalary4MasterList", paramMap);
		
		String total_work_month_txt = "";
		
		for( int i=0; i < masterList.size(); i++ ) {
			total_work_month_txt = String.valueOf(masterList.get(i).get("total_work_month"));
			if( total_work_month_txt != null ) {
				total_work_month_txt = DateUtil.parseMonthToYear(total_work_month_txt);
			}else{
				total_work_month_txt = "0개월";
			}
			masterList.get(i).put("total_work_month_txt", total_work_month_txt);
		}
		
		model.addAttribute("masterList", masterList);
		
		return "top_salary_4/salary_master_person_list_ajax";
	}
	
	/**
	 * 인보험 직원목록 가져오기
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/salaryMemberListAjax", method = RequestMethod.POST)
	public String salaryMemberListAjax(Model model, HttpServletRequest request, HttpSession session) {
		logger.info("======= salaryMemberListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String base_sdate = String.valueOf(paramMap.get("base_sdate"));		//급여계산 기준 시작일
		String base_edate = String.valueOf(paramMap.get("base_edate"));		//급여계산 기준 종료일(근속, 경력의 기준은 종료일기준으로 계산한다)
		
		String sales_date = base_edate.substring(0,8)+DateUtil.getMonthEndDay(base_edate);
		
		//기본급 설정정보 가져오기
		Map<String, Object> salarySetupInfo = sqlSession.selectOne("Salary4Mapper.selectSalarySetupInfoSearch", base_edate);
		
		int nIntern_pay = 0;
		int nIntern_pay_1 = 0;
		int nIntern_pay_2 = 0;
		int nIntern_pay_3 = 0;
		
		int nCareer_pay_1 = 0;
		int nCareer_pay_2 = 0;
		int nCareer_pay_3 = 0;
		int nCareer_pay_4 = 0;
		
		int nConti_pay_1 = 0;
		int nConti_pay_2 = 0;
		int nConti_pay_3 = 0;
		int nConti_pay_4 = 0;
		
		int nManager_pay = 0;
		
		//기본급 최대허용액
		int nMax_pay = 0;		
		
		nIntern_pay = Integer.parseInt(String.valueOf(salarySetupInfo.get("intern_pay")));
		nIntern_pay_1 = Integer.parseInt(String.valueOf(salarySetupInfo.get("intern_pay_1")));
		nIntern_pay_2 = Integer.parseInt(String.valueOf(salarySetupInfo.get("intern_pay_2")));
		nIntern_pay_3 = Integer.parseInt(String.valueOf(salarySetupInfo.get("intern_pay_3")));
		
		nCareer_pay_1 = Integer.parseInt(String.valueOf(salarySetupInfo.get("career_pay_1")));
		nCareer_pay_2 = Integer.parseInt(String.valueOf(salarySetupInfo.get("career_pay_2")));
		nCareer_pay_3 = Integer.parseInt(String.valueOf(salarySetupInfo.get("career_pay_3")));
		nCareer_pay_4 = Integer.parseInt(String.valueOf(salarySetupInfo.get("career_pay_4")));
		
		nConti_pay_1 = Integer.parseInt(String.valueOf(salarySetupInfo.get("conti_pay_1")));
		nConti_pay_2 = Integer.parseInt(String.valueOf(salarySetupInfo.get("conti_pay_2")));
		nConti_pay_3 = Integer.parseInt(String.valueOf(salarySetupInfo.get("conti_pay_3")));
		nConti_pay_4 = Integer.parseInt(String.valueOf(salarySetupInfo.get("conti_pay_4")));
		
		nManager_pay = Integer.parseInt(String.valueOf(salarySetupInfo.get("manager_pay")));
		nMax_pay = Integer.parseInt(String.valueOf(salarySetupInfo.get("max_pay")));
		
		//예외자 명단 가져오기
		String sExceptMember = "";
		
		sExceptMember = sqlSession.selectOne("Salary4Mapper.selectSalaryExceptMemberInfoOne");
		
		paramMap.put("except_user_no", sExceptMember);
		
		paramMap.put("sales_date", sales_date);
		
		List<Map<String, Object>> memberList = sqlSession.selectList("Salary4Mapper.selectSalary4MemberList", paramMap);
				
		String sWorkDateVal = "";				//입사일 이후 근무월 표시
		String sCareerDateVal = "";				//과거 경력일 표시
		String sLeaveDateVal = "";				//무급 휴직일 표시
		String sTempMonth = "";
		
		int nTotalBasePay = 0;						//기본급 합계
		int nCareerPay = 0;		//경력급여합
		int nWorkPay = 0;		//근속수당합
		int nManagerPay = 0;	//개인별 팀장수당
		
		String sJoinDate = "";						//입사일자
		
		int nWorkMonth = 0;
		int nCareerMonth = 0;
		int nLeaveMonth = 0;						//무급휴직일수
		int nTotalMonth = 0;
		
		int nFixChk = 0;								//해당월 기본급 확정여부
		
		for(int i=0; i < memberList.size(); i++) {
			//경력 및 근속연수 계산 시작
			sTempMonth = memberList.get(i).get("work_month").toString();
			nWorkMonth = Integer.parseInt(sTempMonth);					//근속월수 
			sWorkDateVal = DateUtil.parseMonthToYear(sTempMonth);
			memberList.get(i).put("work_month_val", sWorkDateVal);
			
			sTempMonth = memberList.get(i).get("career_month").toString();
			nCareerMonth = Integer.parseInt(sTempMonth);				//경력월수
			sCareerDateVal = DateUtil.parseMonthToYear(sTempMonth);
			memberList.get(i).put("career_month_val", sCareerDateVal);
			
			sTempMonth = memberList.get(i).get("leave_month").toString();
			nLeaveMonth = Integer.parseInt(sTempMonth);				//휴직월수
			sLeaveDateVal = DateUtil.parseMonthToYear(sTempMonth);
			memberList.get(i).put("leave_month_val", sLeaveDateVal);
			
			nTotalMonth = nWorkMonth + nCareerMonth - nLeaveMonth;
			//총 경력 월수계산
			//System.out.println(memberList.get(i).get("user_name").toString()+" : "+ nTotalMonth +"="+ nWorkMonth + "+" + nCareerMonth);
			//경력 및 근속연수 계산 끝
			
			//입사일자
			sJoinDate = String.valueOf(memberList.get(i).get("join_date_fmt"));
			
			nTotalBasePay = 0;
			
			//급여 타입 분류 (payFlag = Intern : 수습, Month : 월급, Annual : 연봉제)
			String payFlag = "";
			
			//검색기간의 한 달 일수
			int nFullMonthDay = DateUtil.getDiffDayCountNew(base_sdate, base_edate)+1;			
			
			//기본급 계산 시작
			//수습직원 여부 체크
			if( "5".equals(String.valueOf(memberList.get(i).get("work_level"))) ) {
				//입사일자 기준 한달 초과 여부확인
				if( DateUtil.compareDate(base_sdate, sJoinDate) == 1 ) {			//입사일자가 급여정산 시작일 이후인 경우
					nTotalBasePay = nIntern_pay * (DateUtil.getDiffDayCountNew( sJoinDate, base_edate )+1) / nFullMonthDay;					
				}else{
					nTotalBasePay = nIntern_pay;
				}
				
				//수습직원은 기본급 외 0원
				memberList.get(i).put("total_career_pay", nTotalBasePay);
				memberList.get(i).put("total_work_pay", 0);
				memberList.get(i).put("manager_pay", 0);
			}else{			//수습직원이 아닌 경우 (연봉직원 향후 별도처리)
				
				//경력급여계산(1,2,3,4년차)
				if( nTotalMonth < 12 ) {
					nCareerPay = nCareer_pay_1;
				}else if( nTotalMonth >= 12 && nTotalMonth < 24) {
					nCareerPay = nCareer_pay_2;
				}else if( nTotalMonth >= 24 && nTotalMonth < 36 ) {
					nCareerPay = nCareer_pay_3;
				}else if( nTotalMonth >= 36 ){
					nCareerPay = nCareer_pay_4;
				}
				
				if( DateUtil.compareDate(base_sdate, sJoinDate) == 1 ) {			//입사일자가 급여정산 시작일 이후 (일할계산해야함)					
					nCareerPay = Math.round(nCareerPay * (DateUtil.getDiffDayCountNew( sJoinDate, base_edate )+1) / nFullMonthDay);					
				}
				
				//기본급(근속+경력기간) 확정
				memberList.get(i).put("total_career_pay", nCareerPay);
				
				//근속수당 계산
				if( nWorkMonth < 12 ) {
					nWorkPay = 0;
				}else if( nWorkMonth >= 12 && nWorkMonth < 24) {
					nWorkPay = nConti_pay_1;
				}else if( nWorkMonth >= 24 && nWorkMonth < 36 ) {
					nWorkPay = nConti_pay_2;
				}else if( nWorkMonth >= 26 && nWorkMonth < 48 ) {
					nWorkPay = nConti_pay_3;
				}else if( nWorkMonth >= 48 ){
					nWorkPay = nConti_pay_4;
				}
				
				//근속수당 확정
				memberList.get(i).put("total_work_pay", nWorkPay);
				
				//기본급합계에 기본급+근속수당으로 합산
				nTotalBasePay = nCareerPay + nWorkPay;				
				
				//팀장 수당 계산시작
				paramMap.put("user_no", String.valueOf(memberList.get(i).get("user_no")));				
				
				int nCnt = sqlSession.selectOne("Salary4Mapper.selectMemberManagerCnt", paramMap);				
				
				if( nCnt == 1 ) {
					Map<String, Object> ManagerDateMap = sqlSession.selectOne("Salary4Mapper.selectMemberManagerDate", paramMap);
					String manager_sdate = String.valueOf(ManagerDateMap.get("manager_sdate_fmt"));
					String manager_edate = String.valueOf(ManagerDateMap.get("manager_edate_fmt"));					
					
					//팀장기간이 조회기간보다 큰 경우
					if( DateUtil.compareDate(base_sdate, manager_sdate) <= 0 && DateUtil.compareDate(base_edate, manager_edate) == 1 ) {
						//기본 팀장수당을 할당
						nManagerPay = nManager_pay;
					}else if( DateUtil.compareDate(base_sdate, manager_sdate) <= 0 &&  DateUtil.compareDate(base_edate, manager_edate) <= 0 ) {
						nManagerPay = Math.round(nManager_pay * (DateUtil.getDiffDayCountNew( base_sdate, manager_edate )+1) / nFullMonthDay );
					}else if( DateUtil.compareDate(base_sdate, manager_sdate) == 1 && DateUtil.compareDate(base_edate, manager_edate) == 1 ) {
						//System.out.println("팀장시작기간은 조회기간보다 이후이고 종료기간도 조회기간보다 느린경우 : "+(DateUtil.getDiffDayCountNew( manager_sdate, base_edate )+1));
						nManagerPay = Math.round(nManager_pay * (DateUtil.getDiffDayCountNew( manager_sdate, base_edate )+1) / nFullMonthDay );
					}else if( DateUtil.compareDate(base_sdate, manager_sdate) == 1 && DateUtil.compareDate(base_edate, manager_edate) <= 0 ) {
						//System.out.println("팀장 기간이 조회기간 안에 포함되는 경우 : "+(DateUtil.getDiffDayCountNew( manager_sdate, manager_edate )+1));
						nManagerPay = Math.round(nManager_pay * (DateUtil.getDiffDayCountNew( manager_sdate, manager_edate )+1) / nFullMonthDay );
					}else{
						//System.out.println("예외인경우");
						nManagerPay = 0;
					}					
				}else{
					nManagerPay = 0;
				}
				
				memberList.get(i).put("manager_pay", nManagerPay);
				//팀장 수당계산 끝
				
				//기본급 합계값에 팀장수당을 추가한다.
				nTotalBasePay += nManagerPay;
			}
			
			//기본급이 최대 허용치를 넘는지 확인해서 넘는경우 최대액으로 설정
			if( nMax_pay < nTotalBasePay ) {
				nTotalBasePay = nMax_pay;
			}
			
			memberList.get(i).put("base_total_pay", nTotalBasePay);
			//기본급 계산 끝
			
			//연봉제 계산시작
			//등록된 연봉제 정보가 있는지 확인한다.
			int nAnnualChk = 0;
			
			paramMap.put("user_no", String.valueOf(memberList.get(i).get("user_no")));

			nAnnualChk = sqlSession.selectOne("Salary4Mapper.selectSalaryAnnualMemberCnt", paramMap);
			
			if( nAnnualChk > 0 ) {			//연봉제 정보가 있는경우만 재계산한다. (급여정산기간중 1개 또는 2개가 있을수 있음)
				
				payFlag = "Annual";				//연봉제 직원			
				
				List<Map<String, Object>> annualInfoList = sqlSession.selectList("Salary4Mapper.selectSalaryMemberAnnualListSearch", paramMap);
				
				String sAnnualSdate = "";		//연봉계약 시작일(임시)
				String sAnnualEdate = "";		//연봉계약 종료일(임시)
				String sAnnualSdate_sub = "";		//연봉계약 시작일(임시)
				String sAnnualEdate_sub = "";		//연봉계약 종료일(임시)
				int nAnnualPay = 0;				//연봉액 (임시)
				int nAnnualPay_sub = 0;		//연봉액 (임시), 신규연봉계약액
				
				int nTempPay0 = 0;				//임시 합계 0
				int nTempPay1 = 0;				//임시 합계 1
				
				if( nAnnualChk == 1 ) {				//연봉계약기간에 급여산정기간이 1개 포함된경우
					sAnnualSdate = String.valueOf(annualInfoList.get(0).get("annual_sdate_fmt"));
					sAnnualEdate = String.valueOf(annualInfoList.get(0).get("annual_edate_fmt"));
					nAnnualPay = (int)annualInfoList.get(0).get("annual_pay");
					
					//계약기간이 급여산정 시작일보자 이전(같은날 포함) 이고, 급여산정 종료일보다 이후(같은날 포함)
					if( DateUtil.compareDate( base_sdate, sAnnualSdate) <= 0 && DateUtil.compareDate(base_edate, sAnnualEdate) >= 0 ) {
						//기본급을 연봉의 1/12 로 계산한다. (기본급, 기본급 합계는 동일하게 처리한다. 1개월 완전 연봉제인경우 수당은 0원으로 처리)
						nCareerPay = Math.round(nAnnualPay / 12);
						nTotalBasePay = nCareerPay;
						
					//계약기간이 급여산정 시작일보다 이전(같은날 포함) 이고, 급여산정 종료일보다는 이전인 경우	
					}else if( DateUtil.compareDate( base_sdate, sAnnualSdate) <= 0 && DateUtil.compareDate(base_edate, sAnnualEdate) < 0 ) {					
						//연봉을 일할계산
						nTempPay0 = nAnnualPay * ( DateUtil.getDiffDayCountNew( base_sdate, sAnnualEdate )+1 ) / (nFullMonthDay * 12);
						//기본급을 일할계산
						nTempPay1 = nTotalBasePay * DateUtil.getDiffDayCountNew( sAnnualEdate, base_edate ) / nFullMonthDay;					
						
						nTotalBasePay = Math.round(nTempPay0 + nTempPay1);
						nCareerPay = nTotalBasePay;
						
					//계약기간이 급여산정 시작일 이후이고, 급여산정 종료일보다 이후(같은날 포함)
					}else if( DateUtil.compareDate( base_sdate, sAnnualSdate) > 0 && DateUtil.compareDate(base_edate, sAnnualEdate) >= 0) {
						//연봉을 일할계산
						nTempPay0 = nAnnualPay * ( DateUtil.getDiffDayCountNew( sAnnualSdate, base_edate )+1 ) / (nFullMonthDay * 12);					
						//기본급을 일할계산
						nTempPay1 = nTotalBasePay * DateUtil.getDiffDayCountNew( base_sdate, sAnnualSdate ) / nFullMonthDay;
						
						nTotalBasePay = Math.round(nTempPay0 + nTempPay1);
						nCareerPay = nTotalBasePay;					
					}
					
				}else if( nAnnualChk == 2 ) {		//연봉계약기간에 급여산정기간이 2개 포함된경우 (산정기간에 연봉계약일이 있는 경우.. 연봉제로 갱신하는 경우)
										
					//이전계약내역
					sAnnualSdate = String.valueOf(annualInfoList.get(0).get("annual_sdate_fmt"));
					sAnnualEdate = String.valueOf(annualInfoList.get(0).get("annual_edate_fmt"));
					nAnnualPay = (int)annualInfoList.get(0).get("annual_pay");
					
					//후기계약내역
					//이전계약내역
					sAnnualSdate_sub = String.valueOf(annualInfoList.get(1).get("annual_sdate_fmt"));
					sAnnualEdate_sub = String.valueOf(annualInfoList.get(1).get("annual_edate_fmt"));
					nAnnualPay_sub = (int)annualInfoList.get(1).get("annual_pay");									
					
					nTempPay0 = nAnnualPay * ( DateUtil.getDiffDayCountNew( base_sdate, sAnnualEdate )+1 ) / (nFullMonthDay * 12);
					
					nTempPay1 = nAnnualPay_sub * ( DateUtil.getDiffDayCountNew( sAnnualSdate_sub, base_edate )+1 ) / (nFullMonthDay * 12);
					
					nTotalBasePay = Math.round(nTempPay0 + nTempPay1);
					nCareerPay = nTotalBasePay;				
				}
				
				memberList.get(i).put("total_career_pay", nCareerPay);		//근속수당
				memberList.get(i).put("base_total_pay", nTotalBasePay);	//기본급 합계
				memberList.get(i).put("total_work_pay", 0);			//근속수당					
				memberList.get(i).put("manager_pay", 0);			//팀장 수당	
				
			}			
			//연봉제 계산 끝
			
			//급여방식 셋팅(플래그)
			memberList.get(i).put("pay_flag", payFlag);
			
			//급여방식 표시값		
			if( "Annual".equals(payFlag) ) {
				memberList.get(i).put("pay_flag_val", "연봉제");
			}else{
				memberList.get(i).put("pay_flag_val", "월급제");
			}
			
			//해당월 기본급 확정 플래그
			Map<String, Object> calBaseMap = new HashMap<>();
			calBaseMap.put("user_no", String.valueOf(memberList.get(i).get("user_no")));
			calBaseMap.put("sales_date", sales_date);
			nFixChk = sqlSession.selectOne("Salary4Mapper.selectSalaryCountBasePay",calBaseMap);			
			memberList.get(i).put("fix_flag", nFixChk);			
		}
				
		model.addAttribute("memberList", memberList);
		model.addAttribute("srchParam",paramMap);
		
		return "top_salary_4/salary_team_member_list_ajax";
	}
	
	/**
	 * 직원별 실적등록 메인
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/salarySalesRegistList", method = RequestMethod.POST)
	public String salarySalesRegistList(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= salarySalesRegistList =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//기준일자(오늘날짜)
		String sToday = DateUtil.getTodayString("yyyyMMdd");		
		
		//실적기준 일자시작 (전달의 1일 부터 말일까지 구하기 시작. 표시용)
		String chk_sdate = DateUtil.addMonthNew(sToday, -1);		//전달구하기
		chk_sdate = chk_sdate.substring(0,7)+"-01";
		
		String chk_edate = DateUtil.getMonthEndDay(chk_sdate);
		chk_edate = chk_sdate.substring(0,7)+"-"+chk_edate;
		//실적기준 일자 끝
		
		paramMap.put("chk_sdate", chk_sdate);
		paramMap.put("chk_edate", chk_edate);
		
		//정산일자(해당월의 마지막날)
		String sales_date = DateUtil.getMonthEndDay(sToday);
		sales_date = DateUtil.getTodayString("yyyy-MM")+"-"+sales_date;
		
		paramMap.put("sales_date", sales_date);
		
		//검색대상 인보험 팀목록을 가져온다.
		List<TopTmBscVO> teamList = sqlSession.selectList("Salary4Mapper.team4SearchList",paramMap);		
		model.addAttribute("teamList", teamList);
		
		//기본급 초기 검색설정은 재직중으로 선택
		paramMap.put("srchUserState", 0);
		
		//직무설정 초기 검색설정은 재직중으로 선택
		paramMap.put("srchPartUserState", 0);
		
		model.addAttribute("srchParam", paramMap);

		return "top_salary_4/salary_sales_regist";
	}
	
	@RequestMapping(value = "/salaryMasterList", method = RequestMethod.POST)
	public String salaryMasterList(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= salaryMasterList =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//기본급 기준일자 시작, 종료일
		String base_sdate = "";
		String base_edate = "";
		String sToday = DateUtil.getTodayString("yyyy-MM-dd");
		
		base_sdate = DateUtil.getBeforeMonthSalary4(sToday);
		base_edate = sToday.substring(0, 7)+"-20";
		
		//정산일자
		String sales_date = base_edate.substring(0,8)+DateUtil.getMonthEndDay(base_edate);
		
		//성과급 기준일자
		String chk_sdate = base_sdate.substring(0,7)+"-01";		
		String chk_edate = DateUtil.getMonthEndDay(chk_sdate);
		chk_edate = chk_sdate.substring(0,7)+"-"+chk_edate;		
		
		//검색대상 인보험 팀목록을 가져온다.
		List<TopTmBscVO> teamList = sqlSession.selectList("Salary4Mapper.team4SearchList",paramMap);		
		model.addAttribute("teamList", teamList);
		
		//검색대상 보험사(직무확인용)목록을 가져온다.		
		List<Map<String, Object>> selInsuList = sqlSession.selectList("Salary4Mapper.selectInsuCompanyListSel", paramMap);
		model.addAttribute("selInsuList", selInsuList);
		
		//기본급 초기 검색설정은 재직중으로 선택
		paramMap.put("srchUserState", 0);
		
		//직무설정 초기 검색설정은 재직중으로 선택
		paramMap.put("srchPartUserState", 0);
		
		//기본급,성과급, 정산 기준일 넣는다.
		paramMap.put("base_sdate", base_sdate);
		paramMap.put("base_edate", base_edate);
		paramMap.put("chk_sdate", chk_sdate);
		paramMap.put("chk_edate", chk_edate);
		paramMap.put("sales_date", sales_date);
		
		model.addAttribute("srchParam", paramMap);
		
		/** 세션체크 */
		if( mbrVo == null || "".equals(mbrVo.getUser_no() )) {
			logger.info("salaryMasterList - no user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login"; 
		}
		
		return "top_salary_4/salary_master_list";
	}
	
	/**
	 * 인보험 직원 목록 메인
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/salaryMemberList", method = RequestMethod.POST)
	public String salaryMemberList(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= salaryMemberList =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//검색 기준일자 시작, 종료일
		String base_sdate = "";
		String base_edate = "";
		String sToday = DateUtil.getTodayString("yyyy-MM-dd");
		
		base_sdate = DateUtil.getBeforeMonthSalary4(sToday);
		base_edate = sToday.substring(0, 7)+"-20";		
		//System.out.println(base_sdate + " : "+base_edate);
		
		//검색대상 인보험 팀목록을 가져온다.
		List<TopTmBscVO> teamList = sqlSession.selectList("Salary4Mapper.team4SearchList",paramMap);
		
		model.addAttribute("teamList", teamList);
		
		//기본급 초기 검색설정은 재직중으로 선택
		paramMap.put("srchUserState", 0);
		
		//직무설정 초기 검색설정은 재직중으로 선택
		paramMap.put("srchPartUserState", 0);
		
		//검색 기준일을 오늘 기준으로 넣는다.
		paramMap.put("base_sdate", base_sdate);
		paramMap.put("base_edate", base_edate);
		
		model.addAttribute("srchParam", paramMap);
		
		/** 세션체크 */
		if( mbrVo == null || "".equals(mbrVo.getUser_no() )) {
			logger.info("salaryMemberList - no user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login"; 
		}
		
		return "top_salary_4/salary_member_list";
	}
	
	/**
	 * 직급 설정 등록, 수정, 삭제
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/salary_part_action", method = RequestMethod.POST)
	@ResponseBody
	public int salary_part_action(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= salary_part_action =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();		
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		paramMap.put("reg_user_no",String.valueOf(mbrVo.getUser_no()));
		
		//리턴플래그		(0:에러, 1:등록, 2:수정)
        int nRet = 0;
        
        String sAction = paramMap.get("action").toString();
        
        //등록
        if( "I".equals(sAction) ) {
        	nRet = sqlSession.insert("Salary4Mapper.insertSalaryPartInfo", paramMap);
        }else if( "U".equals(sAction) ){
        	sqlSession.update("Salary4Mapper.updateSalaryPartInfo",paramMap);
        	nRet = 2;
        }else if( "D".equals(sAction) ) {
        	sqlSession.update("Salary4Mapper.deleteSalaryPartInfo", paramMap);        	
        	nRet = 9;
        }
        return nRet;		
    }
	
	/**
	 * 기본급 설정 등록, 수정, 삭제
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/salary_action", method = RequestMethod.POST)
	@ResponseBody
	public int salary_action(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= salary_action =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();		
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		paramMap.put("reg_user_no",String.valueOf(mbrVo.getUser_no()));
		
		//리턴플래그		(0:에러, 1:등록, 2:수정)
        int nRet = 0;
        
        String sAction = paramMap.get("action").toString();        
        
        //등록
        if( "I".equals(sAction) ) {
        	nRet = sqlSession.insert("Salary4Mapper.insertSalarySetInfo", paramMap);
        }else if( "U".equals(sAction) ){
        	sqlSession.update("Salary4Mapper.updateSalarySetInfo",paramMap);
        	nRet = 2;
        }else if( "D".equals(sAction) ) {
        	sqlSession.update("Salary4Mapper.deleteSalarySetInfo", paramMap);        	
        	nRet = 9;
        }
        
        return nRet;		
    }
	
	/**
     * 성과급 직물 설정 목록 불러오기
     * @param model
     * @param session
     * @param request
     * @return
     */
    @RequestMapping(value = "/getSalaryPartInfoList")
	public String getSalaryPartInfoList(Model model, HttpSession session, HttpServletRequest request) {
		
    	logger.info("======= getSalaryPartInfoList =======");
    	
		String sUrl = "top_salary_4/salary_incentive_part_manage_list_ajax";
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);		
		
		List<Map<String, Object>> salaryPartInfoList = sqlSession.selectList("Salary4Mapper.selectSalaryPartInfoList", paramMap);
		
		model.addAttribute("salaryPartInfoList", salaryPartInfoList);
		
		//기존에 등록된 보험사를 불러온다. (사용중인 보험사만)		
		paramMap.put("is_use", 0);		
		List<Map<String, Object>> insuCompanyList = sqlSession.selectList("Salary4Mapper.selectInsuCompanyList", paramMap);

		model.addAttribute("insuCompanyList", insuCompanyList);
		
		return sUrl;
	}
	
	/**
     * 기본급 설정 목록 불러오기
     * @param model
     * @param session
     * @param request
     * @return
     */
    @RequestMapping(value = "/getSalarySetupInfoList")
	public String getSalarySetupInfoList(Model model, HttpSession session, HttpServletRequest request) {
		
    	logger.info("======= getSalarySetupInfoList =======");
    	
    	//String sUrl = "top_lecture/lecture_quiz_manage_list";
		String sUrl = "top_salary_4/salary_setup_manage_list_ajax";
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		List<Map<String, Object>> salarySetupInfoList = sqlSession.selectList("Salary4Mapper.selectSalarySetupInfoList", paramMap);
		
		model.addAttribute("salarySetupInfoList", salarySetupInfoList);
		
		return sUrl;
	}
    
    @RequestMapping(value = "/salary_annual_option_action", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> salary_annual_option_action(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= salary_annual_option_action =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();	
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		paramMap.put("reg_user_no",String.valueOf(mbrVo.getUser_no()));
		
		Map<String, Object> returnMap = new HashMap<>();
		
		String sAction_flag = String.valueOf(paramMap.get("action_flag"));
		
		int nChk = 0;			//중복일정 체크		
		
		if( "I".equals(sAction_flag) ) {		//연봉설정추가
			
			String sAnuual_sdate = String.valueOf(paramMap.get("annual_sdate"));
			String sAnnual_edate = "";		
			
			//입력되는 계약시작일로 부터 1년 후의 하루 전날 날짜로 셋팅한다. (365일로 계산하는 경우 366일 경우 문제됨)
			sAnnual_edate = DateUtil.beforeYear(sAnuual_sdate, -1);
			sAnnual_edate = DateUtil.addDateNew(sAnnual_edate, -1);
			
			paramMap.put("annual_edate", sAnnual_edate);
			
			//기존의 연봉계약과 동일한 건이 있는지 확인한다.
			nChk = sqlSession.selectOne("Salary4Mapper.selectBeforeAnnualCnt",paramMap);
			
			//중복이 없는경우는 계약정보를 추가한다.
			if( nChk == 0 ) {
				sqlSession.insert("Salary4Mapper.insertSalaryAnnualInfo",paramMap);
				returnMap.put("result", "Insert");
			}else{
				returnMap.put("result", "Dup");
			}			
		}else if( "U".equals(sAction_flag) ) {			//연봉설정 수정
			//기존의 연봉계약과 동일한 건이 있는지 확인한다.
			nChk = sqlSession.selectOne("Salary4Mapper.selectBeforeAnnualCnt",paramMap);
			
			//중복이 없는경우는 계약정보를 추가한다.
			if( nChk == 0 ) {
				sqlSession.insert("Salary4Mapper.updateSalaryAnnualInfo",paramMap);
				returnMap.put("result", "Update");
			}else{
				returnMap.put("result", "Dup");
			}			
		}else if( "D".equals(sAction_flag) ) {		//연봉정보 삭제
			sqlSession.delete("Salary4Mapper.deleteSalaryAnnualInfo",paramMap);
			returnMap.put("result", "Delete");
		}		
		
		return returnMap;
    }
        
    /**
     * 직원 팀장 설정 기간 저장,수정
     * @param model
     * @param request
     * @param session
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/salary_manager_option_action", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> salary_manager_option_action(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= salary_manager_option_action =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();	
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		paramMap.put("reg_user_no",String.valueOf(mbrVo.getUser_no()));
		
		Map<String, Object> returnMap = new HashMap<>();
		
		String sAction_flag = String.valueOf(paramMap.get("action_flag"));
		
		int nChk = 0;			//중복일정 체크
				
		if( "I".equals(sAction_flag) ) {		//팀장설정 추가
			//기존의 팀장 설정기간과 중복이 되는지 확인한다.
			nChk = sqlSession.selectOne("Salary4Mapper.selectBeforeManagerCnt",paramMap);
			
			//중복이 없는경우는 설정값을 추가한다.
			if( nChk == 0 ) {
				sqlSession.insert("Salary4Mapper.insertSalaryManagerInfo",paramMap);
				returnMap.put("result", "Insert");
			}else {
				returnMap.put("result", "Dup");
			}			
		}else if( "U".equals(sAction_flag) ) {
			//기존의 팀장 설정기간과 중복이 되는지 확인한다.
			nChk = sqlSession.selectOne("Salary4Mapper.selectBeforeManagerCnt",paramMap);
			
			//중복이 없는경우는 설정값을 추가한다.
			if( nChk == 0 ) {
				sqlSession.update("Salary4Mapper.updateSalaryManagerInfo",paramMap);
				returnMap.put("result", "Update");
			}else {
				returnMap.put("result", "Dup");
			}			
		}else if( "D".equals(sAction_flag) ) {		//팀장설정 삭제
			sqlSession.delete("Salary4Mapper.deleteSalaryManagerInfo",paramMap);
			returnMap.put("result", "Delete");
		}
		
		return returnMap;
    }
    
    /**
     * 기본급 설정정보 json 으로 가져오기
     * @param model
     * @param request
     * @param session
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/get_salary_member_detail", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> get_salary_member_detail(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= get_salary_member_detail =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String base_sdate = String.valueOf(paramMap.get("base_sdate"));
		String base_edate = String.valueOf(paramMap.get("base_edate"));
		
		//CommonUtils.printMap(paramMap);
		
		//기본급 설정정보 가져오기
		Map<String, Object> salarySetupInfo = sqlSession.selectOne("Salary4Mapper.selectSalarySetupInfoSearch", base_edate);
		
		int nIntern_pay = 0;
		int nIntern_pay_1 = 0;
		int nIntern_pay_2 = 0;
		int nIntern_pay_3 = 0;
		
		int nCareer_pay_1 = 0;
		int nCareer_pay_2 = 0;
		int nCareer_pay_3 = 0;
		int nCareer_pay_4 = 0;
		
		int nConti_pay_1 = 0;
		int nConti_pay_2 = 0;
		int nConti_pay_3 = 0;
		int nConti_pay_4 = 0;
		
		int nManager_pay = 0;
		
		//기본급 최대허용액
		int nMax_pay = 0;
		
		nIntern_pay = Integer.parseInt(String.valueOf(salarySetupInfo.get("intern_pay")));
		nIntern_pay_1 = Integer.parseInt(String.valueOf(salarySetupInfo.get("intern_pay_1")));
		nIntern_pay_2 = Integer.parseInt(String.valueOf(salarySetupInfo.get("intern_pay_2")));
		nIntern_pay_3 = Integer.parseInt(String.valueOf(salarySetupInfo.get("intern_pay_3")));
		
		nCareer_pay_1 = Integer.parseInt(String.valueOf(salarySetupInfo.get("career_pay_1")));
		nCareer_pay_2 = Integer.parseInt(String.valueOf(salarySetupInfo.get("career_pay_2")));
		nCareer_pay_3 = Integer.parseInt(String.valueOf(salarySetupInfo.get("career_pay_3")));
		nCareer_pay_4 = Integer.parseInt(String.valueOf(salarySetupInfo.get("career_pay_4")));
		
		nConti_pay_1 = Integer.parseInt(String.valueOf(salarySetupInfo.get("conti_pay_1")));
		nConti_pay_2 = Integer.parseInt(String.valueOf(salarySetupInfo.get("conti_pay_2")));
		nConti_pay_3 = Integer.parseInt(String.valueOf(salarySetupInfo.get("conti_pay_3")));
		nConti_pay_4 = Integer.parseInt(String.valueOf(salarySetupInfo.get("conti_pay_4")));
		
		nManager_pay = Integer.parseInt(String.valueOf(salarySetupInfo.get("manager_pay")));
		nMax_pay = Integer.parseInt(String.valueOf(salarySetupInfo.get("max_pay")));		
				
		Map<String, Object> salaryUserMap = sqlSession.selectOne("Salary4Mapper.selectSalary4MemberDetailOne", paramMap);
		
		String sWorkDateVal = "";				//입사일 이후 근무월 표시
		String sCareerDateVal = "";				//과거 경력일 표시
		String sLeaveDateVal = "";				//무급휴직일 표시
		String sTempMonth = "";
		
		int nTotalBasePay = 0;						//기본급 합계
		
		String sJoinDate = "";						//입사일자
		
		int nWorkMonth = 0;
		int nCareerMonth = 0;
		int nLeaveMonth = 0;					//무급휴직일수(월)
		int nTotalMonth = 0;
		
		//경력 및 근속연수 계산 시작
		sTempMonth = String.valueOf(salaryUserMap.get("work_month"));
		nWorkMonth = Integer.parseInt(sTempMonth);				//근속월수 
		sWorkDateVal = DateUtil.parseMonthToYear(sTempMonth);
		salaryUserMap.put("work_month_val", sWorkDateVal);		
		
		sTempMonth = String.valueOf(salaryUserMap.get("career_month"));
		nCareerMonth = Integer.parseInt(sTempMonth);				//경력월수
		sCareerDateVal = DateUtil.parseMonthToYear(sTempMonth);
		salaryUserMap.put("career_month_val", sCareerDateVal);
		
		sTempMonth = String.valueOf(salaryUserMap.get("leave_month"));
		nLeaveMonth = Integer.parseInt(sTempMonth);				//휴직월수
		sLeaveDateVal = DateUtil.parseMonthToYear(sTempMonth);
		salaryUserMap.put("leave_month_val", sLeaveDateVal);
		
		nTotalMonth = nWorkMonth + nCareerMonth - nLeaveMonth;
		
		//입사일자
		sJoinDate = String.valueOf(salaryUserMap.get("join_date_fmt"));		
		
		int nCareerPay = 0;		//경력급여합
		int nWorkPay = 0;		//근속수당합
		
		//급여 타입 분류 (payFlag = Intern : 수습, Month : 월급, Annual : 연봉제)
		String payFlag = "";
		
		//검색기간의 한 달 일수
		int nFullMonthDay = DateUtil.getDiffDayCountNew(base_sdate, base_edate)+1;
			
		//기본급 계산 시작
		//수습직원 여부 체크
		if( "5".equals(String.valueOf(salaryUserMap.get("work_level"))) ) {
			
			payFlag = "Intern";
			
			//입사일자 기준 한달 초과 여부확인
			if( DateUtil.compareDate(base_sdate, sJoinDate) == 1 ) {			//입사일자가 급여정산 시작일 이후면 일할계산							
				nTotalBasePay = nIntern_pay * (DateUtil.getDiffDayCountNew( sJoinDate, base_edate )+1) / nFullMonthDay;				
			}else {
				nTotalBasePay = nIntern_pay;
			}
			//수습직원은 경력급여와 기본급이 동일하게 계산됨
			salaryUserMap.put("total_career_pay", StringUtil.toMoneyString(nTotalBasePay));
			//수습직원은 근속수당없음
			salaryUserMap.put("total_work_pay", 0);
			//수습직원은 팀장수당 없음
			salaryUserMap.put("manager_pay", 0);
			
		}else{			//수습직원이 아닌 월급제 직원의 경우
			
			payFlag = "Month";
			
			//경력급여계산(1,2,3,4년차)
			if( nTotalMonth < 12 ) {
				nCareerPay = nCareer_pay_1;
			}else if( nTotalMonth >= 12 && nTotalMonth < 24) {
				nCareerPay = nCareer_pay_2;
			}else if( nTotalMonth >= 24 && nTotalMonth < 36 ) {
				nCareerPay = nCareer_pay_3;
			}else if( nTotalMonth >= 36 ){
				nCareerPay = nCareer_pay_4;
			}
			
			if( DateUtil.compareDate(base_sdate, sJoinDate) == 1 ) {			//입사일자가 급여정산 시작일 이후 (일할계산해야함)
				nCareerPay = Math.round(nCareerPay * (DateUtil.getDiffDayCountNew( sJoinDate, base_edate )+1) / nFullMonthDay);					
			}
			
			//기본급(근속+경력기간) 확정
			salaryUserMap.put("total_career_pay", StringUtil.toMoneyString(nCareerPay));
			
			//근속수당 추가(1,2,3,4년 이상)
			if( nWorkMonth < 12 ) {
				nWorkPay = 0;
			}else if( nWorkMonth >= 12 && nWorkMonth < 24) {
				nWorkPay = nConti_pay_1;
			}else if( nWorkMonth >= 24 && nWorkMonth < 36 ) {
				nWorkPay = nConti_pay_2;
			}else if( nWorkMonth >= 26 && nWorkMonth < 48 ) {
				nWorkPay = nConti_pay_3;
			}else if( nWorkMonth >= 48 ){
				nWorkPay = nConti_pay_4;
			}
			
			//근속수당 확정
			salaryUserMap.put("total_work_pay", StringUtil.toMoneyString(nWorkPay));
			
			//기본급합계에 기본급+근속수당으로 합산
			nTotalBasePay = nCareerPay + nWorkPay;
			
			//팀장 수당 계산시작
			int nCnt = sqlSession.selectOne("Salary4Mapper.selectMemberManagerCnt", paramMap);
			if( nCnt == 1 ) {
				Map<String, Object> ManagerDateMap = sqlSession.selectOne("Salary4Mapper.selectMemberManagerDate", paramMap);
				String manager_sdate = String.valueOf(ManagerDateMap.get("manager_sdate_fmt"));
				String manager_edate = String.valueOf(ManagerDateMap.get("manager_edate_fmt"));				
				
				//팀장기간이 조회기간보다 큰 경우
				if( DateUtil.compareDate(base_sdate, manager_sdate) <= 0 && DateUtil.compareDate(base_edate, manager_edate) == 1 ) {
					//기본 팀장수당을 할당
				}else if( DateUtil.compareDate(base_sdate, manager_sdate) <= 0 &&  DateUtil.compareDate(base_edate, manager_edate) <= 0 ) {
					//System.out.println("팀장시작기간은 조회기간보다 먼저지만 종료기간은 조회기간보다 빠른경우 : "+(DateUtil.getDiffDayCountNew( base_sdate, manager_edate )+1)+" : "+(nFullMonthDay));
					nManager_pay = Math.round(nManager_pay * (DateUtil.getDiffDayCountNew( base_sdate, manager_edate )+1) / nFullMonthDay );
				}else if( DateUtil.compareDate(base_sdate, manager_sdate) == 1 && DateUtil.compareDate(base_edate, manager_edate) == 1 ) {
					//System.out.println("팀장시작기간은 조회기간보다 이후이고 종료기간도 조회기간보다 느린경우 : "+(DateUtil.getDiffDayCountNew( manager_sdate, base_edate )+1));
					nManager_pay = Math.round(nManager_pay * (DateUtil.getDiffDayCountNew( manager_sdate, base_edate )+1) / nFullMonthDay );
				}else if( DateUtil.compareDate(base_sdate, manager_sdate) == 1 && DateUtil.compareDate(base_edate, manager_edate) <= 0 ) {
					//System.out.println("팀장 기간이 조회기간 안에 포함되는 경우 : "+(DateUtil.getDiffDayCountNew( manager_sdate, manager_edate )+1));
					nManager_pay = Math.round(nManager_pay * (DateUtil.getDiffDayCountNew( manager_sdate, manager_edate )+1) / nFullMonthDay );
				}else{
					//System.out.println("예외인경우");
					nManager_pay = 0;
				}				
			}else{
				nManager_pay = 0;
			}
			salaryUserMap.put("manager_pay", StringUtil.toMoneyString(nManager_pay));			
			//팀장 수당계산 끝
			
			//기본급 합계값에 팀장수당을 추가한다.
			nTotalBasePay += nManager_pay;
			
			//기본급이 최대 허용치를 넘는지 확인해서 넘는경우 최대액으로 설정
			if( nMax_pay < nTotalBasePay ) {
				nTotalBasePay = nMax_pay;
			}
			
		}		
		
		//기본급 합계셋팅
		salaryUserMap.put("base_total_pay", StringUtil.toMoneyString(nTotalBasePay));
		//기본급 계산 끝
		
		//연봉제 계산시작
		//등록된 연봉제 정보가 있는지 확인한다.
		int nAnnualChk = 0;
		
		nAnnualChk = sqlSession.selectOne("Salary4Mapper.selectSalaryAnnualMemberCnt", paramMap);
		
		if( nAnnualChk > 0 ) {			//연봉제 정보가 있는경우만 재계산한다. (급여정산기간중 1개 또는 2개가 있을수 있음)
			
			payFlag = "Annual";				//연봉제 직원			
			
			List<Map<String, Object>> annualInfoList = sqlSession.selectList("Salary4Mapper.selectSalaryMemberAnnualListSearch", paramMap);
			
			String sAnnualSdate = "";		//연봉계약 시작일(임시)
			String sAnnualEdate = "";		//연봉계약 종료일(임시)
			String sAnnualSdate_sub = "";		//연봉계약 시작일(임시)
			String sAnnualEdate_sub = "";		//연봉계약 종료일(임시)
			int nAnnualPay = 0;				//연봉액 (임시)
			int nAnnualPay_sub = 0;		//연봉액 (임시), 신규연봉계약액
			
			int nTempPay0 = 0;				//임시 합계 0
			int nTempPay1 = 0;				//임시 합계 1
			
			if( nAnnualChk == 1 ) {				//연봉계약기간에 급여산정기간이 1개 포함된경우
				sAnnualSdate = String.valueOf(annualInfoList.get(0).get("annual_sdate_fmt"));
				sAnnualEdate = String.valueOf(annualInfoList.get(0).get("annual_edate_fmt"));
				nAnnualPay = (int)annualInfoList.get(0).get("annual_pay");
				
				//System.out.println("연봉제 1개");
				//System.out.println("base_date : "+base_sdate+" : "+base_edate);
				//System.out.println("annual_info : "+sAnnualSdate+" : "+sAnnualEdate + " : "+nAnnualPay);
				
				//계약기간이 급여산정 시작일보자 이전(같은날 포함) 이고, 급여산정 종료일보다 이후(같은날 포함)
				if( DateUtil.compareDate( base_sdate, sAnnualSdate) <= 0 && DateUtil.compareDate(base_edate, sAnnualEdate) >= 0 ) {
					//기본급을 연봉의 1/12 로 계산한다. (기본급, 기본급 합계는 동일하게 처리한다. 1개월 완전 연봉제인경우 수당은 0원으로 처리)
					nCareerPay = Math.round(nAnnualPay / 12);
					nTotalBasePay = nCareerPay;
					
				//계약기간이 급여산정 시작일보다 이전(같은날 포함) 이고, 급여산정 종료일보다는 이전인 경우	
				}else if( DateUtil.compareDate( base_sdate, sAnnualSdate) <= 0 && DateUtil.compareDate(base_edate, sAnnualEdate) < 0 ) {					
					//연봉을 일할계산
					nTempPay0 = nAnnualPay * ( DateUtil.getDiffDayCountNew( base_sdate, sAnnualEdate )+1 ) / (nFullMonthDay * 12);
					//기본급을 일할계산
					nTempPay1 = nTotalBasePay * DateUtil.getDiffDayCountNew( sAnnualEdate, base_edate ) / nFullMonthDay;					
					
					nTotalBasePay = Math.round(nTempPay0 + nTempPay1);
					nCareerPay = nTotalBasePay;
					
				//계약기간이 급여산정 시작일 이후이고, 급여산정 종료일보다 이후(같은날 포함)
				}else if( DateUtil.compareDate( base_sdate, sAnnualSdate) > 0 && DateUtil.compareDate(base_edate, sAnnualEdate) >= 0) {
					//연봉을 일할계산
					nTempPay0 = nAnnualPay * ( DateUtil.getDiffDayCountNew( sAnnualSdate, base_edate )+1 ) / (nFullMonthDay * 12);					
					//기본급을 일할계산
					nTempPay1 = nTotalBasePay * DateUtil.getDiffDayCountNew( base_sdate, sAnnualSdate ) / nFullMonthDay;
					
					nTotalBasePay = Math.round(nTempPay0 + nTempPay1);
					nCareerPay = nTotalBasePay;					
				}
				
			}else if( nAnnualChk == 2 ) {		//연봉계약기간에 급여산정기간이 2개 포함된경우 (산정기간에 연봉계약일이 있는 경우.. 연봉제로 갱신하는 경우)
				
				//System.out.println("연봉제 2개");
				
				//이전계약내역
				sAnnualSdate = String.valueOf(annualInfoList.get(0).get("annual_sdate_fmt"));
				sAnnualEdate = String.valueOf(annualInfoList.get(0).get("annual_edate_fmt"));
				nAnnualPay = (int)annualInfoList.get(0).get("annual_pay");
				
				//후기계약내역
				//이전계약내역
				sAnnualSdate_sub = String.valueOf(annualInfoList.get(1).get("annual_sdate_fmt"));
				sAnnualEdate_sub = String.valueOf(annualInfoList.get(1).get("annual_edate_fmt"));
				nAnnualPay_sub = (int)annualInfoList.get(1).get("annual_pay");
				
				//System.out.println("annual_info before : "+sAnnualSdate+" : "+sAnnualEdate + " : "+nAnnualPay);
				//System.out.println("annual_info after : "+sAnnualSdate_sub+" : "+sAnnualEdate_sub + " : "+nAnnualPay_sub);				
				
				nTempPay0 = nAnnualPay * ( DateUtil.getDiffDayCountNew( base_sdate, sAnnualEdate )+1 ) / (nFullMonthDay * 12);
				
				//System.out.println("이전 연봉 = "+nAnnualPay+" * "+( DateUtil.getDiffDayCountNew( base_sdate, sAnnualEdate )+1 )+" / ("+ nFullMonthDay +" * "+ 12+")");
				
				nTempPay1 = nAnnualPay_sub * ( DateUtil.getDiffDayCountNew( sAnnualSdate_sub, base_edate )+1 ) / (nFullMonthDay * 12);
				
				//System.out.println("다음 연봉 = "+nAnnualPay_sub+" * "+( DateUtil.getDiffDayCountNew( sAnnualSdate_sub, base_edate )+1 )+" / ("+ nFullMonthDay +" * "+ 12+")");
				
				nTotalBasePay = Math.round(nTempPay0 + nTempPay1);
				nCareerPay = nTotalBasePay;				
			}
			
			salaryUserMap.put("total_career_pay", StringUtil.toMoneyString(nCareerPay));		//근속수당
			salaryUserMap.put("base_total_pay", StringUtil.toMoneyString(nTotalBasePay));	//기본급 합계
			salaryUserMap.put("total_work_pay", 0);			//근속수당					
			salaryUserMap.put("manager_pay", 0);			//팀장 수당	
			
		}		
		//연봉제 계산끝
				
		salaryUserMap.put("base_sdate", base_sdate);
		salaryUserMap.put("base_edate", base_edate);
		
		//급여방식 셋팅(플래그)
		salaryUserMap.put("pay_flag", payFlag);
		
		//급여방식 표시값		
		if( "Annual".equals(payFlag) ) {
			salaryUserMap.put("pay_flag_val", "연봉제");
		}else{
			salaryUserMap.put("pay_flag_val", "월급제");
		}
		
		return salaryUserMap;
    }
    
    /** 
     * 직원 성과급 계산 Ajax    
     * @param model
     * @param request
     * @param session
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/get_sales_calculation", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> get_sales_calculation(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= get_sales_calculation =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String,Object> returnMap = new HashMap<>();
		
		String cal_insu_type = request.getParameter("cal_insu_type") != null ? request.getParameter("cal_insu_type") : "1";			//1:종결건수, 2:매출액 기준
		String cal_loss_rate = request.getParameter("cal_loss_rate") != null ? request.getParameter("cal_loss_rate") : "0";				//손감기준
		String cal_unit_sales = request.getParameter("cal_unit_sales") != null ? request.getParameter("cal_unit_sales") : "0";			//건당 매출단가
		String cal_base_sales = request.getParameter("cal_base_sales") != null ? request.getParameter("cal_base_sales") : "0";		//기준매출액(최소)
		String cal_base_count = request.getParameter("cal_base_count") != null ? request.getParameter("cal_base_count") : "0";		//기준건수(최소)
		String cal_sector_interval_1 = request.getParameter("cal_sector_interval_1") != null ? request.getParameter("cal_sector_interval_1") : "0";		//1구간 기준
		String cal_sector_interval_2 = request.getParameter("cal_sector_interval_2") != null ? request.getParameter("cal_sector_interval_2") : "0";		//2구간 기준
		String cal_sector_interval_3 = request.getParameter("cal_sector_interval_3") != null ? request.getParameter("cal_sector_interval_3") : "0";		//3구간 기준
		String cal_payout_rate_1 = request.getParameter("cal_payout_rate_1") != null ? request.getParameter("cal_payout_rate_1") : "0";		//1구간 비율(%)
		String cal_payout_rate_2 = request.getParameter("cal_payout_rate_2") != null ? request.getParameter("cal_payout_rate_2") : "0";		//2구간 비율(%)
		String cal_payout_rate_3 = request.getParameter("cal_payout_rate_3") != null ? request.getParameter("cal_payout_rate_3") : "0";		//3구간 비율(%)
		String cal_payout_rate_4 = request.getParameter("cal_payout_rate_4") != null ? request.getParameter("cal_payout_rate_4") : "0";		//4구간 비율(%)
		String cal_fail_rate = request.getParameter("cal_fail_rate") != null ? request.getParameter("cal_fail_rate") : "0";		//손감미만 또는 민원발생 비율(%)
		
		String loss_rate = request.getParameter("loss_rate") != null ? request.getParameter("loss_rate") : "0";								//발생 손감율
		String minwon_cnt = request.getParameter("minwon_cnt") != null ? request.getParameter("minwon_cnt") : "0";					//민원건수
		String result_sales = request.getParameter("result_sales") != null ? request.getParameter("result_sales") : "0";					//발생 매출액
		String result_count = request.getParameter("result_count") != null ? request.getParameter("result_count") : "0";					//발생 종결건
		String self_option_pay = request.getParameter("self_option_pay") != null ? request.getParameter("self_option_pay") : "0";	//본인부담시상비
		String job_option_pay = request.getParameter("job_option_pay") != null ? request.getParameter("job_option_pay") : "0";		//직업변경시상비
		String etc1_option_pay = request.getParameter("etc1_option_pay") != null ? request.getParameter("etc1_option_pay") : "0";	//기타1시상비
		String etc2_option_pay = request.getParameter("etc2_option_pay") != null ? request.getParameter("etc2_option_pay") : "0";	//기타2시상비
		
		int nTotalSalesAmount = 0;				//성과급 합계		
		
		int nBaseCnt = 0;
		nBaseCnt = Integer.parseInt(cal_base_count.replaceAll(",", ""));		//기준건수
		
		int nBaseSales = 0;
		nBaseSales = Integer.parseInt(cal_base_sales.replaceAll(",", ""));		//기준(최소) 매출액
		
		int nUnitSales = 0;
		nUnitSales = Integer.parseInt(cal_unit_sales.replaceAll(",", ""));		//건당 매출단가
		
		float fCalLossRate = 0;
		fCalLossRate = Float.parseFloat(cal_loss_rate);								//기준손감율
		
		float fLossRate = 0;
		fLossRate = Float.parseFloat(loss_rate);										//입력 손감율
		
		int nMinwonCnt = 0;
		nMinwonCnt = Integer.parseInt(minwon_cnt);									//입력 민원건수
		
		//구간기준
		int nSectorInterval1 = Integer.parseInt(cal_sector_interval_1.replaceAll(",", ""));
		int nSectorInterval2 = Integer.parseInt(cal_sector_interval_2.replaceAll(",", ""));
		int nSectorInterval3 = Integer.parseInt(cal_sector_interval_3.replaceAll(",", ""));		
		
		//구간비율
		int nPayoutRate1 = Integer.parseInt(cal_payout_rate_1);
		int nPayoutRate2 = Integer.parseInt(cal_payout_rate_2);
		int nPayoutRate3 = Integer.parseInt(cal_payout_rate_3);
		int nPayoutRate4 = Integer.parseInt(cal_payout_rate_4);
		int nFailRate = Integer.parseInt(cal_fail_rate);
		
		int nResultCnt = 0;			//입력건수
		int nResultSales = 0;		//입력매출액		
		int nCalResultSales = 0;	//직원 발생 매출액
		
		String result_info_text = "";			//결과페이지에 보여줄 정보		
		
		if( "1".equals(cal_insu_type) ){				//종결건수 기준 계산시작			
			nResultCnt = Integer.parseInt(result_count.replaceAll(",", ""));		//입력건수			
			nTotalSalesAmount = (nResultCnt * nUnitSales) - nBaseSales ;
			nCalResultSales = nResultCnt * nUnitSales;			//직원발생 매출액
			
			if( nResultCnt > nBaseCnt && nTotalSalesAmount > 0 ) {		//기준치 미달 또는 기본매출액보다 성과가 적은 경우제외
				
				//민원이 있거나 손감율을 도달하지 못한경우 1구간으로 계산
				if( (fCalLossRate > fLossRate) || ( nMinwonCnt > 0 ) ) {					
					result_info_text = "손감 미만 또는 민원발생";
					nTotalSalesAmount = Math.round(nTotalSalesAmount * nFailRate / 100);
				}else{
					//구간 체크
					if( nResultCnt <= nSectorInterval1) {
						result_info_text = "1구간";
						nTotalSalesAmount = Math.round(nTotalSalesAmount * nPayoutRate1 / 100); 
					}else if( nSectorInterval1 < nResultCnt && nResultCnt <= nSectorInterval2  ) {
						result_info_text = "2구간";
						nTotalSalesAmount = Math.round(nTotalSalesAmount * nPayoutRate2 / 100);
					}else if( nSectorInterval2 < nResultCnt && nResultCnt <= nSectorInterval3 ){
						result_info_text = "3구간";
						nTotalSalesAmount = Math.round(nTotalSalesAmount * nPayoutRate3 / 100);
					}else if( nSectorInterval3 < nResultCnt ) {
						result_info_text = "4구간";
						nTotalSalesAmount = Math.round(nTotalSalesAmount * nPayoutRate4 / 100);
					}else {				
						result_info_text = "예외발생";
						nTotalSalesAmount = 0;
					}
				}
			}else{						//최소건수를 초과하지 못한경우 구간 성과급 없음
				result_info_text = "(최소)기본 건수 미만";				
				nTotalSalesAmount = 0;
			}			
			
		}else if( "2".equals(cal_insu_type) ){		//매출액 기준 계산시작			
			nResultSales = Integer.parseInt(result_sales.replaceAll(",", ""));		//입력매출액
			nTotalSalesAmount = nResultSales - nBaseSales ;
			nCalResultSales = nResultSales;					//직원 발생매출액
			
			if( nTotalSalesAmount > 0 ) {			//기준치 미달 또는 기본매출액보다 성과가 적은 경우제외				
				//민원이 있거나 손감율을 도달하지 못한경우 1구간으로 계산
				if( (fCalLossRate > fLossRate) || ( nMinwonCnt > 0 ) ) {
					result_info_text = "손감 미만 또는 민원발생";
					nTotalSalesAmount = Math.round(nTotalSalesAmount * nFailRate / 100);
				}else{
					//구간 체크
					if( nResultSales <= nSectorInterval1) {
						result_info_text = "1구간";
						nTotalSalesAmount = Math.round(nTotalSalesAmount * nPayoutRate1 / 100); 
					}else if( nSectorInterval1 < nResultSales && nResultSales <= nSectorInterval2  ) {
						result_info_text = "2구간";
						nTotalSalesAmount = Math.round(nTotalSalesAmount * nPayoutRate2 / 100);
					}else if( nSectorInterval2 < nResultSales && nResultSales <= nSectorInterval3 ){
						result_info_text = "3구간";
						nTotalSalesAmount = Math.round(nTotalSalesAmount * nPayoutRate3 / 100);
					}else if( nSectorInterval3 < nResultSales ) {
						result_info_text = "4구간";
						nTotalSalesAmount = Math.round(nTotalSalesAmount * nPayoutRate4 / 100);
					}else {				
						result_info_text = "예외발생";
						nTotalSalesAmount = 0;
					}
				}
				
			}else{
				result_info_text = "(최소)기본 매출액 미만";				
				nTotalSalesAmount = 0;
			}
			
		}
		
		//직원 발생 매출액
		returnMap.put("cal_result_sales", nCalResultSales);
		
		//시상금 추가 계산
		int nSelfOptionPay = Integer.parseInt(self_option_pay.replaceAll(",", ""));
		int nJobOptionPay = Integer.parseInt(job_option_pay.replaceAll(",", ""));
		int nEtc1OptionPay = Integer.parseInt(etc1_option_pay.replaceAll(",", ""));
		int nEtc2OptionPay = Integer.parseInt(etc2_option_pay.replaceAll(",", ""));
		
		//구간 성과급
		returnMap.put("part_pay", nTotalSalesAmount);
		
		//성과급+옵션비
		nTotalSalesAmount = nTotalSalesAmount + nSelfOptionPay + nJobOptionPay + nEtc1OptionPay + nEtc2OptionPay;
		
		String sResultCal = StringUtil.toMoneyString(nTotalSalesAmount);
		
		//성과급 계산 결과
		returnMap.put("total_sales_amount", sResultCal);
		
		//계산결과 정보추가
		returnMap.put("result_info_text", result_info_text);
		
		//CommonUtils.printMap(paramMap);
		
		return returnMap;
    }
    
    /**
     * 직원 성과급 실적 결과 조회
     * @param model
     * @param request
     * @param session
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/get_sales_member_result_detail", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> get_sales_member_result_detail(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= get_sales_member_result_detail =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String,Object> returnMap = new HashMap<>();
		
		String user_no = request.getParameter("user_no") != null ? request.getParameter("user_no") : "";
		String sales_date = request.getParameter("sales_date") != null ? request.getParameter("sales_date") : "";
		String chk_edate = request.getParameter("chk_edate") != null ? request.getParameter("chk_edate") : "";
		String pkey = request.getParameter("pkey") != null ? request.getParameter("pkey") : "";
		String skey = request.getParameter("skey") != null ? request.getParameter("skey") : "";
				
		//직원 기본정보 및 총 경력일수 가져오기 (이전 보험사경력 + 현 경력 - 휴직개월수)
		Map<String, Object> insaMap = sqlSession.selectOne("Salary4Mapper.selectCalTotalWorkMonth", paramMap);
		
		int nTotalWorkMonth = Integer.parseInt(insaMap.get("total_work_month").toString());
		
		String work_year_flag = "0";				//년차분류
		
		if( 12 <= nTotalWorkMonth && nTotalWorkMonth < 24) {					//2년차
			work_year_flag = "2";
		}else if( 24 <= nTotalWorkMonth && nTotalWorkMonth < 36 ) {		//3년차
			work_year_flag = "3";
		}else if( 36 <= nTotalWorkMonth ){												//4년차 이상
			work_year_flag = "4";
		}else{																						//1년차
			work_year_flag = "1";
		}
		
		//경력 및 연차 표시
		String total_work_month_text = "";
		
		if( "4".equals(work_year_flag) ) {
			total_work_month_text = DateUtil.parseMonthToYear(String.valueOf(insaMap.get("total_work_month")))+" ("+work_year_flag+" 년차 이상)";
		}else {
			total_work_month_text = DateUtil.parseMonthToYear(String.valueOf(insaMap.get("total_work_month")))+" ("+work_year_flag+" 년차)";
		}
		
		returnMap.put("user_no", String.valueOf(insaMap.get("user_no")));
		returnMap.put("user_name", String.valueOf(insaMap.get("user_name")));
		returnMap.put("team_name", String.valueOf(insaMap.get("team_name")));
		returnMap.put("salary_4_insu_nm", String.valueOf(insaMap.get("salary_4_insu_nm")));
		returnMap.put("salary_4_part_nm", String.valueOf(insaMap.get("salary_4_part_nm")));
		returnMap.put("total_work_month_text", total_work_month_text);
		
		Map<String, Object> partMap = sqlSession.selectOne("Salary4Mapper.selectSalaryPartInfoOne", pkey);
		
		//건당금액
		returnMap.put("unit_sales", StringUtil.toMoneyString(Integer.parseInt(String.valueOf(partMap.get("unit_sales")))));
		//기준 손감율
		returnMap.put("loss_rate", String.valueOf(partMap.get("loss_rate")));
		//(최소)기본건수
		returnMap.put("base_count", StringUtil.toMoneyString(Integer.parseInt(String.valueOf(partMap.get("base_count")))));
		//(최소)기본매출액
		returnMap.put("base_sales", StringUtil.toMoneyString(Integer.parseInt(String.valueOf(partMap.get("base_sales")))));
		
		//구간안내 기준변수
		//건수기준
		String sCountChkPoint1 = "";
		String sCountChkPoint2 = "";
		String sCountChkPoint3 = "";		
		
		//매출액기준
		String sSalesChkPoint1 = "";
		String sSalesChkPoint2 = "";
		String sSalesChkPoint3 = "";
		
		//소속된 직무정보로 건수 / 매출액 의 기준을 확인한다.
		String insu_type = String.valueOf(partMap.get("incentive_type"));
		
		returnMap.put("insu_type",insu_type);			//1:종결건, 2:매출액
		
		//구간기준	(1~4년차)
		if( "2".equals(work_year_flag) ){			//2년차
			sCountChkPoint1 = String.valueOf(partMap.get("count_chk_point_2_1"));
			sCountChkPoint2 = String.valueOf(partMap.get("count_chk_point_2_2"));
			sCountChkPoint3 = String.valueOf(partMap.get("count_chk_point_2_3"));
			
			sSalesChkPoint1 = String.valueOf(partMap.get("sales_chk_point_2_1"));
			sSalesChkPoint2 = String.valueOf(partMap.get("sales_chk_point_2_2"));
			sSalesChkPoint3 = String.valueOf(partMap.get("sales_chk_point_2_3"));
		}else if( "3".equals(work_year_flag) ){	//3년차
			sCountChkPoint1 = String.valueOf(partMap.get("count_chk_point_3_1"));
			sCountChkPoint2 = String.valueOf(partMap.get("count_chk_point_3_2"));
			sCountChkPoint3 = String.valueOf(partMap.get("count_chk_point_3_3"));
			
			sSalesChkPoint1 = String.valueOf(partMap.get("sales_chk_point_3_1"));
			sSalesChkPoint2 = String.valueOf(partMap.get("sales_chk_point_3_2"));
			sSalesChkPoint3 = String.valueOf(partMap.get("sales_chk_point_3_3"));
		}else if( "4".equals(work_year_flag) ){	//4년차
			sCountChkPoint1 = String.valueOf(partMap.get("count_chk_point_4_1"));
			sCountChkPoint2 = String.valueOf(partMap.get("count_chk_point_4_2"));
			sCountChkPoint3 = String.valueOf(partMap.get("count_chk_point_4_3"));
			
			sSalesChkPoint1 = String.valueOf(partMap.get("sales_chk_point_4_1"));
			sSalesChkPoint2 = String.valueOf(partMap.get("sales_chk_point_4_2"));
			sSalesChkPoint3 = String.valueOf(partMap.get("sales_chk_point_4_3"));
		}else{												//1년차
			sCountChkPoint1 = String.valueOf(partMap.get("count_chk_point_1_1"));
			sCountChkPoint2 = String.valueOf(partMap.get("count_chk_point_1_2"));
			sCountChkPoint3 = String.valueOf(partMap.get("count_chk_point_1_3"));
			
			sSalesChkPoint1 = String.valueOf(partMap.get("sales_chk_point_1_1"));
			sSalesChkPoint2 = String.valueOf(partMap.get("sales_chk_point_1_2"));
			sSalesChkPoint3 = String.valueOf(partMap.get("sales_chk_point_1_3"));
		}
		
		//구간 값 Set (최소 값에 증분값만큼 추가해서 넣어준다.)		
		int nBaseCount = Integer.parseInt(String.valueOf(partMap.get("base_count")));
		int nBaseSales = Integer.parseInt(String.valueOf(partMap.get("base_sales")));		

		sCountChkPoint1 = StringUtil.toMoneyString( ( nBaseCount + Integer.parseInt(sCountChkPoint1) ) );
		sCountChkPoint2 = StringUtil.toMoneyString( ( nBaseCount + Integer.parseInt(sCountChkPoint2) ) );
		sCountChkPoint3 = StringUtil.toMoneyString( ( nBaseCount + Integer.parseInt(sCountChkPoint3) ) );		
		
		sSalesChkPoint1 = StringUtil.toMoneyString( ( nBaseSales + Integer.parseInt(sSalesChkPoint1) ) );
		sSalesChkPoint2 = StringUtil.toMoneyString( ( nBaseSales + Integer.parseInt(sSalesChkPoint2) ) );
		sSalesChkPoint3 = StringUtil.toMoneyString( ( nBaseSales + Integer.parseInt(sSalesChkPoint3) ) );
		
		returnMap.put("count_chk_point_1", sCountChkPoint1 );
		returnMap.put("count_chk_point_2", sCountChkPoint2 );
		returnMap.put("count_chk_point_3", sCountChkPoint3 );
		returnMap.put("sales_chk_point_1", sSalesChkPoint1 );
		returnMap.put("sales_chk_point_2", sSalesChkPoint2 );
		returnMap.put("sales_chk_point_3", sSalesChkPoint3 );
		
		//지급율 Set
		returnMap.put("payout_rate_1", String.valueOf(partMap.get("payout_rate_1")));
		returnMap.put("payout_rate_2", String.valueOf(partMap.get("payout_rate_2")));
		returnMap.put("payout_rate_3", String.valueOf(partMap.get("payout_rate_3")));
		returnMap.put("payout_rate_4", String.valueOf(partMap.get("payout_rate_4")));
		
		//손감미달성시
		returnMap.put("fail_rate", String.valueOf(partMap.get("fail_rate")));
		
		
		//수정인 경우 skey 를 가지고 정보를 넣어준다.
		if( !"".equals(skey) ) {
			Map<String, Object> salesMap = sqlSession.selectOne("Salary4Mapper.selectSalarySalesInfoOne", skey);
			returnMap.put("self_option_pay", StringUtil.toMoneyString(String.valueOf(salesMap.get("self_option_pay"))));
			returnMap.put("job_option_pay", StringUtil.toMoneyString(String.valueOf(salesMap.get("job_option_pay"))));
			returnMap.put("etc1_option_pay", StringUtil.toMoneyString(String.valueOf(salesMap.get("etc1_option_pay"))));
			returnMap.put("etc2_option_pay", StringUtil.toMoneyString(String.valueOf(salesMap.get("etc2_option_pay"))));
			returnMap.put("etc_memo", String.valueOf(salesMap.get("etc_memo")).replaceAll("\n", "<br/>"));
			returnMap.put("update_loss_rate", String.valueOf(salesMap.get("loss_rate")));
			returnMap.put("minwon_cnt", String.valueOf(salesMap.get("minwon_cnt")));
			returnMap.put("result_count", String.valueOf(salesMap.get("result_cnt")));
			returnMap.put("result_sales", String.valueOf(salesMap.get("result_sales")));
			returnMap.put("cal_result_sales", StringUtil.toMoneyString(String.valueOf(salesMap.get("cal_result_sales"))));
			returnMap.put("cal_reason_text", String.valueOf(salesMap.get("cal_reason_text")));			
			returnMap.put("sum_sales_pay", StringUtil.toMoneyString(String.valueOf(salesMap.get("sum_sales_pay"))));			
			returnMap.put("skey", skey);
		}
		
		return returnMap;
    }
    
    /**
     * 직원 성과급 설정정보(보험사, 직급, 연차) 불러오기
     * @param model
     * @param request
     * @param session
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/get_sales_member_info", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> get_sales_member_info(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= get_sales_member_info =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		Map<String,Object> returnMap = new HashMap<>();
		
		//CommonUtils.printMap(paramMap);
		
		String user_no = request.getParameter("user_no") != null ? request.getParameter("user_no") : "";
		String sales_date = request.getParameter("sales_date") != null ? request.getParameter("sales_date") : "";
		String chk_edate = request.getParameter("chk_edate") != null ? request.getParameter("chk_edate") : "";
		String pkey = request.getParameter("pkey") != null ? request.getParameter("pkey") : "";
		String skey = request.getParameter("skey") != null ? request.getParameter("skey") : "";
		
		//직원 기본정보 및 총 경력일수 가져오기 (이전 보험사경력 + 현 경력 - 휴직개월수)
		Map<String, Object> insaMap = sqlSession.selectOne("Salary4Mapper.selectCalTotalWorkMonth", paramMap);
		
		int nTotalWorkMonth = Integer.parseInt(insaMap.get("total_work_month").toString());
		
		String work_year_flag = "0";				//년차분류
		
		if( 12 <= nTotalWorkMonth && nTotalWorkMonth < 24) {					//2년차
			work_year_flag = "2";
		}else if( 24 <= nTotalWorkMonth && nTotalWorkMonth < 36 ) {		//3년차
			work_year_flag = "3";
		}else if( 36 <= nTotalWorkMonth ){												//4년차 이상
			work_year_flag = "4";
		}else{																						//1년차
			work_year_flag = "1";
		}
		
		//경력 및 연차 표시
		String total_work_month_text = "";
		
		if( "4".equals(work_year_flag) ) {
			total_work_month_text = DateUtil.parseMonthToYear(String.valueOf(insaMap.get("total_work_month")))+" ("+work_year_flag+" 년차 이상)";
		}else {
			total_work_month_text = DateUtil.parseMonthToYear(String.valueOf(insaMap.get("total_work_month")))+" ("+work_year_flag+" 년차)";
		}
		
		returnMap.put("user_no", String.valueOf(insaMap.get("user_no")));
		returnMap.put("user_name", String.valueOf(insaMap.get("user_name")));
		returnMap.put("team_name", String.valueOf(insaMap.get("team_name")));
		returnMap.put("salary_4_insu_nm", String.valueOf(insaMap.get("salary_4_insu_nm")));
		returnMap.put("salary_4_part_nm", String.valueOf(insaMap.get("salary_4_part_nm")));
		returnMap.put("total_work_month_text", total_work_month_text);
		
		Map<String, Object> partMap = sqlSession.selectOne("Salary4Mapper.selectSalaryPartInfoOne", pkey);
		
		//건당금액
		returnMap.put("unit_sales", StringUtil.toMoneyString(Integer.parseInt(String.valueOf(partMap.get("unit_sales")))));
		//기준 손감율
		returnMap.put("loss_rate", String.valueOf(partMap.get("loss_rate")));
		//(최소)기본건수
		returnMap.put("base_count", StringUtil.toMoneyString(Integer.parseInt(String.valueOf(partMap.get("base_count")))));
		//(최소)기본매출액
		returnMap.put("base_sales", StringUtil.toMoneyString(Integer.parseInt(String.valueOf(partMap.get("base_sales")))));
		
		//구간안내 기준변수
		//건수기준
		String sCountChkPoint1 = "";
		String sCountChkPoint2 = "";
		String sCountChkPoint3 = "";		
		
		//매출액기준
		String sSalesChkPoint1 = "";
		String sSalesChkPoint2 = "";
		String sSalesChkPoint3 = "";
		
		//소속된 직무정보로 건수 / 매출액 의 기준을 확인한다.
		String insu_type = String.valueOf(partMap.get("incentive_type"));
		
		returnMap.put("insu_type",insu_type);			//1:종결건, 2:매출액
		
		//구간기준	(1~4년차)
		if( "2".equals(work_year_flag) ){			//2년차
			sCountChkPoint1 = String.valueOf(partMap.get("count_chk_point_2_1"));
			sCountChkPoint2 = String.valueOf(partMap.get("count_chk_point_2_2"));
			sCountChkPoint3 = String.valueOf(partMap.get("count_chk_point_2_3"));
			
			sSalesChkPoint1 = String.valueOf(partMap.get("sales_chk_point_2_1"));
			sSalesChkPoint2 = String.valueOf(partMap.get("sales_chk_point_2_2"));
			sSalesChkPoint3 = String.valueOf(partMap.get("sales_chk_point_2_3"));
		}else if( "3".equals(work_year_flag) ){	//3년차
			sCountChkPoint1 = String.valueOf(partMap.get("count_chk_point_3_1"));
			sCountChkPoint2 = String.valueOf(partMap.get("count_chk_point_3_2"));
			sCountChkPoint3 = String.valueOf(partMap.get("count_chk_point_3_3"));
			
			sSalesChkPoint1 = String.valueOf(partMap.get("sales_chk_point_3_1"));
			sSalesChkPoint2 = String.valueOf(partMap.get("sales_chk_point_3_2"));
			sSalesChkPoint3 = String.valueOf(partMap.get("sales_chk_point_3_3"));
		}else if( "4".equals(work_year_flag) ){	//4년차
			sCountChkPoint1 = String.valueOf(partMap.get("count_chk_point_4_1"));
			sCountChkPoint2 = String.valueOf(partMap.get("count_chk_point_4_2"));
			sCountChkPoint3 = String.valueOf(partMap.get("count_chk_point_4_3"));
			
			sSalesChkPoint1 = String.valueOf(partMap.get("sales_chk_point_4_1"));
			sSalesChkPoint2 = String.valueOf(partMap.get("sales_chk_point_4_2"));
			sSalesChkPoint3 = String.valueOf(partMap.get("sales_chk_point_4_3"));
		}else{												//1년차
			sCountChkPoint1 = String.valueOf(partMap.get("count_chk_point_1_1"));
			sCountChkPoint2 = String.valueOf(partMap.get("count_chk_point_1_2"));
			sCountChkPoint3 = String.valueOf(partMap.get("count_chk_point_1_3"));
			
			sSalesChkPoint1 = String.valueOf(partMap.get("sales_chk_point_1_1"));
			sSalesChkPoint2 = String.valueOf(partMap.get("sales_chk_point_1_2"));
			sSalesChkPoint3 = String.valueOf(partMap.get("sales_chk_point_1_3"));
		}
		
		//구간 값 Set (최소 값에 증분값만큼 추가해서 넣어준다.)		
		int nBaseCount = Integer.parseInt(String.valueOf(partMap.get("base_count")));
		int nBaseSales = Integer.parseInt(String.valueOf(partMap.get("base_sales")));		

		sCountChkPoint1 = StringUtil.toMoneyString( ( nBaseCount + Integer.parseInt(sCountChkPoint1) ) );
		sCountChkPoint2 = StringUtil.toMoneyString( ( nBaseCount + Integer.parseInt(sCountChkPoint2) ) );
		sCountChkPoint3 = StringUtil.toMoneyString( ( nBaseCount + Integer.parseInt(sCountChkPoint3) ) );		
		
		sSalesChkPoint1 = StringUtil.toMoneyString( ( nBaseSales + Integer.parseInt(sSalesChkPoint1) ) );
		sSalesChkPoint2 = StringUtil.toMoneyString( ( nBaseSales + Integer.parseInt(sSalesChkPoint2) ) );
		sSalesChkPoint3 = StringUtil.toMoneyString( ( nBaseSales + Integer.parseInt(sSalesChkPoint3) ) );
		
		returnMap.put("count_chk_point_1", sCountChkPoint1 );
		returnMap.put("count_chk_point_2", sCountChkPoint2 );
		returnMap.put("count_chk_point_3", sCountChkPoint3 );
		returnMap.put("sales_chk_point_1", sSalesChkPoint1 );
		returnMap.put("sales_chk_point_2", sSalesChkPoint2 );
		returnMap.put("sales_chk_point_3", sSalesChkPoint3 );
		
		//지급율 Set
		returnMap.put("payout_rate_1", String.valueOf(partMap.get("payout_rate_1")));
		returnMap.put("payout_rate_2", String.valueOf(partMap.get("payout_rate_2")));
		returnMap.put("payout_rate_3", String.valueOf(partMap.get("payout_rate_3")));
		returnMap.put("payout_rate_4", String.valueOf(partMap.get("payout_rate_4")));
		
		//손감미달성시
		returnMap.put("fail_rate", String.valueOf(partMap.get("fail_rate")));
		
		
		//수정인 경우 skey 를 가지고 정보를 넣어준다.
		if( !"".equals(skey) ) {
			Map<String, Object> salesMap = sqlSession.selectOne("Salary4Mapper.selectSalarySalesInfoOne", skey);
			returnMap.put("self_option_pay", String.valueOf(salesMap.get("self_option_pay")));
			returnMap.put("job_option_pay", String.valueOf(salesMap.get("job_option_pay")));
			returnMap.put("etc1_option_pay", String.valueOf(salesMap.get("etc1_option_pay")));
			returnMap.put("etc2_option_pay", String.valueOf(salesMap.get("etc2_option_pay")));
			returnMap.put("etc_memo", String.valueOf(salesMap.get("etc_memo")));
			returnMap.put("update_loss_rate", String.valueOf(salesMap.get("loss_rate")));
			returnMap.put("minwon_cnt", String.valueOf(salesMap.get("minwon_cnt")));
			returnMap.put("result_count", String.valueOf(salesMap.get("result_cnt")));
			returnMap.put("result_sales", String.valueOf(salesMap.get("result_sales")));
			returnMap.put("skey", skey);
		}
		
		/* partMap 전체
		returnMap.put("pkey", String.valueOf(partMap.get("pkey")));
		returnMap.put("ikey", String.valueOf(partMap.get("ikey")));
		returnMap.put("part_name", String.valueOf(partMap.get("part_name")));
		returnMap.put("unit_sales", String.valueOf(partMap.get("unit_sales")));
		returnMap.put("loss_rate", String.valueOf(partMap.get("loss_rate")));
		returnMap.put("incentive_type", String.valueOf(partMap.get("incentive_type")));
		returnMap.put("base_count", String.valueOf(partMap.get("base_count")));
		returnMap.put("base_sales", String.valueOf(partMap.get("base_sales")));
		returnMap.put("payout_rate_1", String.valueOf(partMap.get("payout_rate_1")));
		returnMap.put("payout_rate_2", String.valueOf(partMap.get("payout_rate_2")));
		returnMap.put("payout_rate_3", String.valueOf(partMap.get("payout_rate_3")));
		returnMap.put("payout_rate_4", String.valueOf(partMap.get("payout_rate_4")));
		
		returnMap.put("count_chk_point_1_1", String.valueOf(partMap.get("count_chk_point_1_1")));
		returnMap.put("count_chk_point_1_2", String.valueOf(partMap.get("count_chk_point_1_2")));
		returnMap.put("count_chk_point_1_3", String.valueOf(partMap.get("count_chk_point_1_3")));
		returnMap.put("count_chk_point_2_1", String.valueOf(partMap.get("count_chk_point_2_1")));
		returnMap.put("count_chk_point_2_2", String.valueOf(partMap.get("count_chk_point_2_2")));
		returnMap.put("count_chk_point_2_3", String.valueOf(partMap.get("count_chk_point_2_3")));
		returnMap.put("count_chk_point_3_1", String.valueOf(partMap.get("count_chk_point_3_1")));
		returnMap.put("count_chk_point_3_2", String.valueOf(partMap.get("count_chk_point_3_2")));
		returnMap.put("count_chk_point_3_3", String.valueOf(partMap.get("count_chk_point_3_3")));
		returnMap.put("count_chk_point_4_1", String.valueOf(partMap.get("count_chk_point_4_1")));
		returnMap.put("count_chk_point_4_2", String.valueOf(partMap.get("count_chk_point_4_2")));
		returnMap.put("count_chk_point_4_3", String.valueOf(partMap.get("count_chk_point_4_3")));
		
		returnMap.put("sales_chk_point_1_1", String.valueOf(partMap.get("sales_chk_point_1_1")));
		returnMap.put("sales_chk_point_1_2", String.valueOf(partMap.get("sales_chk_point_1_2")));
		returnMap.put("sales_chk_point_1_3", String.valueOf(partMap.get("sales_chk_point_1_3")));
		returnMap.put("sales_chk_point_2_1", String.valueOf(partMap.get("sales_chk_point_2_1")));
		returnMap.put("sales_chk_point_2_2", String.valueOf(partMap.get("sales_chk_point_2_2")));
		returnMap.put("sales_chk_point_2_3", String.valueOf(partMap.get("sales_chk_point_2_3")));
		returnMap.put("sales_chk_point_3_1", String.valueOf(partMap.get("sales_chk_point_3_1")));
		returnMap.put("sales_chk_point_3_2", String.valueOf(partMap.get("sales_chk_point_3_2")));
		returnMap.put("sales_chk_point_3_3", String.valueOf(partMap.get("sales_chk_point_3_3")));
		returnMap.put("sales_chk_point_4_1", String.valueOf(partMap.get("sales_chk_point_4_1")));
		returnMap.put("sales_chk_point_4_2", String.valueOf(partMap.get("sales_chk_point_4_2")));
		returnMap.put("sales_chk_point_4_3", String.valueOf(partMap.get("sales_chk_point_4_3")));
		
		returnMap.put("fail_rate", String.valueOf(partMap.get("fail_rate")));
		returnMap.put("is_use", String.valueOf(partMap.get("is_use")));
		returnMap.put("insu_name", String.valueOf(partMap.get("insu_name")));	
		*/
		
		return returnMap;
    }
    
    /**
     * 성과급 설정정보를 JSON 으로 가져오기
     * @param model
     * @param request
     * @param session
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/get_salary_part_info", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> get_salary_part_info(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= get_salary_part_info =======");
		
		Map<String,Object> returnMap = new HashMap<>();		
		
		String pkey = request.getParameter("pkey") != null ? request.getParameter("pkey") : "";		
		
		Map<String, Object> partMap = sqlSession.selectOne("Salary4Mapper.selectSalaryPartInfoOne", pkey);
		
		returnMap.put("pkey", String.valueOf(partMap.get("pkey")));
		returnMap.put("ikey", String.valueOf(partMap.get("ikey")));
		returnMap.put("part_name", String.valueOf(partMap.get("part_name")));
		returnMap.put("unit_sales", String.valueOf(partMap.get("unit_sales")));
		returnMap.put("loss_rate", String.valueOf(partMap.get("loss_rate")));
		returnMap.put("incentive_type", String.valueOf(partMap.get("incentive_type")));
		returnMap.put("base_count", String.valueOf(partMap.get("base_count")));
		returnMap.put("base_sales", String.valueOf(partMap.get("base_sales")));
		returnMap.put("payout_rate_1", String.valueOf(partMap.get("payout_rate_1")));
		returnMap.put("payout_rate_2", String.valueOf(partMap.get("payout_rate_2")));
		returnMap.put("payout_rate_3", String.valueOf(partMap.get("payout_rate_3")));
		returnMap.put("payout_rate_4", String.valueOf(partMap.get("payout_rate_4")));
		
		returnMap.put("count_chk_point_1_1", String.valueOf(partMap.get("count_chk_point_1_1")));
		returnMap.put("count_chk_point_1_2", String.valueOf(partMap.get("count_chk_point_1_2")));
		returnMap.put("count_chk_point_1_3", String.valueOf(partMap.get("count_chk_point_1_3")));
		returnMap.put("count_chk_point_2_1", String.valueOf(partMap.get("count_chk_point_2_1")));
		returnMap.put("count_chk_point_2_2", String.valueOf(partMap.get("count_chk_point_2_2")));
		returnMap.put("count_chk_point_2_3", String.valueOf(partMap.get("count_chk_point_2_3")));
		returnMap.put("count_chk_point_3_1", String.valueOf(partMap.get("count_chk_point_3_1")));
		returnMap.put("count_chk_point_3_2", String.valueOf(partMap.get("count_chk_point_3_2")));
		returnMap.put("count_chk_point_3_3", String.valueOf(partMap.get("count_chk_point_3_3")));
		returnMap.put("count_chk_point_4_1", String.valueOf(partMap.get("count_chk_point_4_1")));
		returnMap.put("count_chk_point_4_2", String.valueOf(partMap.get("count_chk_point_4_2")));
		returnMap.put("count_chk_point_4_3", String.valueOf(partMap.get("count_chk_point_4_3")));
		
		returnMap.put("sales_chk_point_1_1", String.valueOf(partMap.get("sales_chk_point_1_1")));
		returnMap.put("sales_chk_point_1_2", String.valueOf(partMap.get("sales_chk_point_1_2")));
		returnMap.put("sales_chk_point_1_3", String.valueOf(partMap.get("sales_chk_point_1_3")));
		returnMap.put("sales_chk_point_2_1", String.valueOf(partMap.get("sales_chk_point_2_1")));
		returnMap.put("sales_chk_point_2_2", String.valueOf(partMap.get("sales_chk_point_2_2")));
		returnMap.put("sales_chk_point_2_3", String.valueOf(partMap.get("sales_chk_point_2_3")));
		returnMap.put("sales_chk_point_3_1", String.valueOf(partMap.get("sales_chk_point_3_1")));
		returnMap.put("sales_chk_point_3_2", String.valueOf(partMap.get("sales_chk_point_3_2")));
		returnMap.put("sales_chk_point_3_3", String.valueOf(partMap.get("sales_chk_point_3_3")));
		returnMap.put("sales_chk_point_4_1", String.valueOf(partMap.get("sales_chk_point_4_1")));
		returnMap.put("sales_chk_point_4_2", String.valueOf(partMap.get("sales_chk_point_4_2")));
		returnMap.put("sales_chk_point_4_3", String.valueOf(partMap.get("sales_chk_point_4_3")));
		
		returnMap.put("fail_rate", String.valueOf(partMap.get("fail_rate")));
		returnMap.put("is_use", String.valueOf(partMap.get("is_use")));
		returnMap.put("insu_name", String.valueOf(partMap.get("insu_name")));		
		
		return returnMap;
	}
    
    /**
     * 기본급 설정정보 json 으로 가져오기
     * @param model
     * @param request
     * @param session
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/get_salary_setup_info", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> get_salary_setup_info(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= get_salary_setup_info =======");
		
		Map<String,Object> returnMap = new HashMap<>();		
		
		String skey = request.getParameter("skey") != null ? request.getParameter("skey") : "";		
		
		Map<String, Object> salaryMap = sqlSession.selectOne("Salary4Mapper.selectSalarySetupInfoOne", skey);
		
		returnMap.put("skey", String.valueOf(salaryMap.get("skey")));
		returnMap.put("salary_subject", String.valueOf(salaryMap.get("salary_subject")));
		returnMap.put("term_sdate", String.valueOf(salaryMap.get("term_sdate")));
		returnMap.put("term_sdate_fmt", String.valueOf(salaryMap.get("term_sdate_fmt")));		
		returnMap.put("term_edate", String.valueOf(salaryMap.get("term_edate")));
		returnMap.put("term_edate_fmt", String.valueOf(salaryMap.get("term_edate_fmt")));
		
		returnMap.put("intern_pay", String.valueOf(salaryMap.get("intern_pay")));
		returnMap.put("intern_pay_1", String.valueOf(salaryMap.get("intern_pay_1")));
		returnMap.put("intern_pay_2", String.valueOf(salaryMap.get("intern_pay_2")));
		returnMap.put("intern_pay_3", String.valueOf(salaryMap.get("intern_pay_3")));
		
		returnMap.put("career_pay_1", String.valueOf(salaryMap.get("career_pay_1")));
		returnMap.put("career_pay_2", String.valueOf(salaryMap.get("career_pay_2")));
		returnMap.put("career_pay_3", String.valueOf(salaryMap.get("career_pay_3")));
		returnMap.put("career_pay_4", String.valueOf(salaryMap.get("career_pay_4")));
		
		returnMap.put("conti_pay_1", String.valueOf(salaryMap.get("conti_pay_1")));
		returnMap.put("conti_pay_2", String.valueOf(salaryMap.get("conti_pay_2")));
		returnMap.put("conti_pay_3", String.valueOf(salaryMap.get("conti_pay_3")));
		returnMap.put("conti_pay_4", String.valueOf(salaryMap.get("conti_pay_4")));
		
		returnMap.put("manager_pay", String.valueOf(salaryMap.get("manager_pay")));
		returnMap.put("max_pay", String.valueOf(salaryMap.get("max_pay")));
		returnMap.put("is_use", String.valueOf(salaryMap.get("is_use")));
		
		return returnMap;
	}
    
    /**
     * 기본급 설정관리 상세보기
     * @param model
     * @param request
     * @param session
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "salary_setup_manage_modal_detail")
	public String salary_setup_manage_modal_detail(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= salary_setup_manage_modal_detail =======");
		
		String skey = request.getParameter("skey") != null ? request.getParameter("skey") : "";
		
		Map<String, Object> salarySetupInfoMap = sqlSession.selectOne("Salary4Mapper.selectSalarySetupInfoOne", skey);
		
		model.addAttribute("salarySetupInfoMap",salarySetupInfoMap);		

		return "/top_salary_4/salary_setup_manage_modal_detail";
	}
    
    /**
	 * 관리자 급여 성과급 정보설정 메인
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/salaryIncentiveManagerList")
	public String salaryIncentiveManagerList(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= salaryIncentiveManagerList =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		/** 세션체크 */
		if( mbrVo == null || "".equals(mbrVo.getUser_no() )) {
			logger.info("salaryManagerList - no user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login"; 
		}
		
		//기존에 등록된 보험사를 불러온다. (사용중인 보험사만)		
		paramMap.put("is_use", 0);		
		List<Map<String, Object>> insuCompanyList = sqlSession.selectList("Salary4Mapper.selectInsuCompanyList", paramMap);
		
		model.addAttribute("insuCompanyList", insuCompanyList);
		
		//예외자 설정을 위한 인보험 직원 목록
		//List<Map<String, Object>> srchMemberList = sqlSession.selectList("Salary4Mapper.selectSalary4ExceptMemberList", paramMap);
		//model.addAttribute("srchMemberList", srchMemberList);
		
		//return "top_salary_4/salary_manage_list";
		return "top_salary_4/salary_incentive_manage_list";
	}
	
	/**
	 * 관리자 급여 기본정보설정 메인
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/salaryManagerList", method = RequestMethod.POST)
	public String salaryManagerList(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= salaryManagerList =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		/** 세션체크 */
		if( mbrVo == null || "".equals(mbrVo.getUser_no() )) {
			logger.info("salaryManagerList - no user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login"; 
		}		
		
		//예외자 설정을 위한 인보험 직원 목록
		List<Map<String, Object>> srchMemberList = sqlSession.selectList("Salary4Mapper.selectSalary4ExceptMemberList", paramMap);
		model.addAttribute("srchMemberList", srchMemberList);
		
		return "top_salary_4/salary_manage_list";
	}
	
	/**
	 * 인보험 급여관리 메인
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/TopSalay4Main")
	public String TopSalay4Main(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= TopSalay4Main =======");
		
		//TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		TopMbrBscVO mbrVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//메뉴 접근자 사번
		String accUserNo = String.valueOf(mbrVo.getUser_no());
		
		//메뉴 접근자 아이피
		HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();		
		String accIp = req.getHeader("X-FORWARDED-FOR");
		
		if(accIp == null){
			accIp = req.getRemoteAddr(); 
		}
		
		paramMap.put("acc_user_no", accUserNo);
		paramMap.put("acc_ip", accIp);
		paramMap.put("action_flag", "view");
		
		//접근자 정보 insert
		sqlSession.insert("Salary4Mapper.insertSalaryAccLog",paramMap);		
		
		//CommonUtils.printMap(paramMap);
		
		logger.info("accUserNo : "+accUserNo+" : "+accIp);
		
		/** 세션체크 */
		if( mbrVo == null || "".equals(mbrVo.getUser_no() )) {
			logger.info("TopSalay4Main - no user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login"; 
		}
		
		return "top_salary_4/salary_index";
	}
	
}
