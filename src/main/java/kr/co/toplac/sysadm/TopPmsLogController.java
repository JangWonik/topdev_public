package kr.co.toplac.sysadm;

import java.io.UnsupportedEncodingException;
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

import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.RequestUtil;

@Controller
public class TopPmsLogController {

	private static final Logger logger = LoggerFactory.getLogger(TopPmsLogController.class);

	@Autowired
	SqlSession sqlSession;
	
	/**
	 * 보고서 활동(결제, 종결 외 ) 로그조회 Ajax
	 * @param model
	 * @param session
	 * @param toDate
	 * @param fromDate
	 * @return
	 */
	@RequestMapping(value = "topReportLogListAjax", method = RequestMethod.POST)
	public String topReportLogListAjax(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("==================== topReportLogListAjax ====================");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String excelDown = String.valueOf(paramMap.get("excelDown"));
		
		//보고서 활동로그 조회
		List<Map<String, Object>> reportLogList = sqlSession.selectList("PmsLogListMapper.reportLogListSearch", paramMap);
		
		model.addAttribute("reportLogList", reportLogList);		
		model.addAttribute("srchParam", paramMap);
		
		if( "1".equals(excelDown) ) {
			return "sys_adm/top_report_log_list_excel";			//엑셀다운
		}else {
			return "sys_adm/top_report_log_list_ajax";				//목록불러오기
		}
				
	}
	
	/**
	 * 보고서 활동(결제, 종결 외 ) 로그조회
	 * @param model
	 * @param session
	 * @param toDate
	 * @param fromDate
	 * @return
	 */
	@RequestMapping(value = "topReportLogList", method = RequestMethod.GET)
	public String topReportLogList(HttpServletRequest request, Model model, HttpSession session) {
		
		logger.info("==================== topReportLogList ====================");		
		
		return "sys_adm/top_report_log_list";
		
	}

	@RequestMapping(value = "topPmsLogList", method = RequestMethod.GET)
	public String topPmsLogList(Model model, HttpSession session, String toDate, String fromDate) {
		
		logger.info("topPmsLogList");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9")){
			logger.info("topPmsLogList - no permession user_no : "+mbrVo.getUser_no());
			session.invalidate();
			return "top_login/top_login";
		}
		
		HashMap<String,String> map = new HashMap<String,String>();
		if (toDate != "" && toDate != null ){
			map.put("toDate", toDate);
		}else{
			map.put("toDate", ""+0);
		}
		if (fromDate != "" && fromDate != null ){
			map.put("fromDate", fromDate);
		}else{
			map.put("fromDate", ""+0);
		}
		
		List<TopMbrAuthVO> authList = sqlSession.selectList("PmsLogListMapper.pmsLogList",map);
		
		for(int i=0; i < authList.size(); i++){
			TopMbrAuthVO tmpvo = authList.get(i);
			
			/*보고서 접수(수임)*/
			if(tmpvo.getMbr_pms_1().equals("0")){
				tmpvo.setMbr_pms_1("X");
			}else{
				tmpvo.setMbr_pms_1("O");
			}
			
			/*보고서 열람*/
			/* 권한2가 생기면서 not used */
//			if( tmpvo.getMbr_pms_2().equals("0")){
//				tmpvo.setMbr_pms_2("X");
//			}else{
//				tmpvo.setMbr_pms_2("O");
//			}
			
			/*보고서 삭제*/
			if(tmpvo.getMbr_pms_3().equals("0")){
				tmpvo.setMbr_pms_3("X");
			}else{
				tmpvo.setMbr_pms_3("O");
			}
			
			/*보고서 종결(결재) 취소*/
			if(tmpvo.getMbr_pms_4().equals("0")){
				tmpvo.setMbr_pms_4("X");
			}else{
				tmpvo.setMbr_pms_4("O");
			}
			
			/*보고서 잠금 해제*/
			if(tmpvo.getMbr_pms_5().equals("0")){
				tmpvo.setMbr_pms_5("X");
			}else{
				tmpvo.setMbr_pms_5("O");
			}
			
			/*조사 보고서 엑셀 다운*/
			if(tmpvo.getMbr_pms_6().equals("0")){
				tmpvo.setMbr_pms_6("X");
			}else if(tmpvo.getMbr_pms_6().equals("1")){
				tmpvo.setMbr_pms_6("팀");
			}else if(tmpvo.getMbr_pms_6().equals("2")){
				tmpvo.setMbr_pms_6("지역본부");
			}else if(tmpvo.getMbr_pms_6().equals("3")){
				tmpvo.setMbr_pms_6("업종");
			}else if(tmpvo.getMbr_pms_6().equals("4")){
				tmpvo.setMbr_pms_6("전체");
			}
			
			/*총무 경리 열람*/
			if(tmpvo.getMbr_pms_7().equals("0")){
				tmpvo.setMbr_pms_7("X");
			}else if(tmpvo.getMbr_pms_7().equals("1")){
				tmpvo.setMbr_pms_7("팀");
			}else if(tmpvo.getMbr_pms_7().equals("2")){
				tmpvo.setMbr_pms_7("지역본부");
			}else if(tmpvo.getMbr_pms_7().equals("3")){
				tmpvo.setMbr_pms_7("업종");
			}else if(tmpvo.getMbr_pms_7().equals("4")){
				tmpvo.setMbr_pms_7("전체");
			}
			
			/*총무 경리 수정*/
			if(tmpvo.getMbr_pms_8().equals("0")){
				tmpvo.setMbr_pms_8("X");
			}else{
				tmpvo.setMbr_pms_8("O");
			}
			
			/*보험사 정보 수정*/
			if(tmpvo.getMbr_pms_9().equals("0")){
				tmpvo.setMbr_pms_9("X");
			}else{
				tmpvo.setMbr_pms_9("O");
			}
			
			/*관련 업체 엑셀 다운*/
			if(tmpvo.getMbr_pms_10().equals("0")){
				tmpvo.setMbr_pms_10("X");
			}else{
				tmpvo.setMbr_pms_10("O");
			}
			
			/*보험사 공지 관리(1종)*/
			if(tmpvo.getMbr_pms_11().equals("0")){
				tmpvo.setMbr_pms_11("X");
			}else{
				tmpvo.setMbr_pms_11("O");
			}
			
			/*보험사 공지 관리(4종)*/
			if(tmpvo.getMbr_pms_12().equals("0")){
				tmpvo.setMbr_pms_12("X");
			}else{
				tmpvo.setMbr_pms_12("O");
			}
			
			/*팀관리*/
			if(tmpvo.getMbr_pms_13().equals("0")){
				tmpvo.setMbr_pms_13("X");
			}else{
				tmpvo.setMbr_pms_13("O");
			}
			
			/*인사 기록*/
			if(tmpvo.getMbr_pms_14().equals("0")){
				tmpvo.setMbr_pms_14("X");
			}else{
				tmpvo.setMbr_pms_14("O");
			}
			
			/*인사 평가 관리 권한*/
			if(tmpvo.getMbr_pms_15().equals("0")){
				tmpvo.setMbr_pms_15("X");
			}else{
				tmpvo.setMbr_pms_15("O");
			}
			
			/*재직 증명서 승인*/
			if(tmpvo.getMbr_pms_16().equals("0")){
				tmpvo.setMbr_pms_16("X");
			}else{
				tmpvo.setMbr_pms_16("O");
			}
			
			/*경비 내역 결재 & 취소*/
			if(tmpvo.getMbr_pms_17().equals("0")){
				tmpvo.setMbr_pms_17("X");
			}else{
				tmpvo.setMbr_pms_17("O");
			}
			
			/*경비 승인 결재 & 취소*/
			if(tmpvo.getMbr_pms_18().equals("0")){
				tmpvo.setMbr_pms_18("X");
			}else{
				tmpvo.setMbr_pms_18("O");
			}
			
			/*적부 워드전환*/
			if(tmpvo.getMbr_pms_19().equals("0")){
				tmpvo.setMbr_pms_19("X");
			}else{
				tmpvo.setMbr_pms_19("O");
			}
			
			/*응답 전문*/
			if(tmpvo.getMbr_pms_20().equals("0")){
				tmpvo.setMbr_pms_20("X");
			}else{
				tmpvo.setMbr_pms_20("O");
			}
			
			/*통계*/
			if(tmpvo.getMbr_pms_21().equals("0")){
				tmpvo.setMbr_pms_21("X");
			}else{
				tmpvo.setMbr_pms_21("O");
			}
		}
		model.addAttribute("pmsList",authList);
		
		return "sys_adm/top_pms_log_mng";			
		
	}
	
	@RequestMapping(value = "topPmsLogExcel", method = RequestMethod.GET)
	public String memberTelExcel(Model model, HttpSession session, HttpServletResponse response, String toDate, String fromDate) {
		logger.info("======= topPmsLogExcel =======");
		
		HashMap<String,String> map = new HashMap<String,String>();
		if (toDate != "" && toDate != null ){
			map.put("toDate", toDate);
		}else{
			map.put("toDate", ""+0);
		}
		if (fromDate != "" && fromDate != null ){
			map.put("fromDate", fromDate);
		}else{
			map.put("fromDate", ""+0);
		}
		
		List<TopMbrAuthVO> authList = sqlSession.selectList("PmsLogListMapper.pmsLogList",map);
		
		for(int i=0; i < authList.size(); i++){
			TopMbrAuthVO tmpvo = authList.get(i);
			
			/*보고서 접수(수임)*/
			if(tmpvo.getMbr_pms_1().equals("0")){
				tmpvo.setMbr_pms_1("X");
			}else{
				tmpvo.setMbr_pms_1("O");
			}
			
			/*보고서 열람*/
			/* 권한2가 생기면서 not used */
//			if( tmpvo.getMbr_pms_2().equals("0")){
//				tmpvo.setMbr_pms_2("X");
//			}else{
//				tmpvo.setMbr_pms_2("O");
//			}
			
			/*보고서 삭제*/
			if(tmpvo.getMbr_pms_3().equals("0")){
				tmpvo.setMbr_pms_3("X");
			}else{
				tmpvo.setMbr_pms_3("O");
			}
			
			/*보고서 종결(결재) 취소*/
			if(tmpvo.getMbr_pms_4().equals("0")){
				tmpvo.setMbr_pms_4("X");
			}else{
				tmpvo.setMbr_pms_4("O");
			}
			
			/*보고서 잠금 해제*/
			if(tmpvo.getMbr_pms_5().equals("0")){
				tmpvo.setMbr_pms_5("X");
			}else{
				tmpvo.setMbr_pms_5("O");
			}
			
			/*조사 보고서 엑셀 다운*/
			if(tmpvo.getMbr_pms_6().equals("0")){
				tmpvo.setMbr_pms_6("X");
			}else if(tmpvo.getMbr_pms_6().equals("1")){
				tmpvo.setMbr_pms_6("팀");
			}else if(tmpvo.getMbr_pms_6().equals("2")){
				tmpvo.setMbr_pms_6("지역본부");
			}else if(tmpvo.getMbr_pms_6().equals("3")){
				tmpvo.setMbr_pms_6("업종");
			}else if(tmpvo.getMbr_pms_6().equals("4")){
				tmpvo.setMbr_pms_6("전체");
			}
			
			/*총무 경리 열람*/
			if(tmpvo.getMbr_pms_7().equals("0")){
				tmpvo.setMbr_pms_7("X");
			}else if(tmpvo.getMbr_pms_7().equals("1")){
				tmpvo.setMbr_pms_7("팀");
			}else if(tmpvo.getMbr_pms_7().equals("2")){
				tmpvo.setMbr_pms_7("지역본부");
			}else if(tmpvo.getMbr_pms_7().equals("3")){
				tmpvo.setMbr_pms_7("업종");
			}else if(tmpvo.getMbr_pms_7().equals("4")){
				tmpvo.setMbr_pms_7("전체");
			}
			
			/*총무 경리 수정*/
			if(tmpvo.getMbr_pms_8().equals("0")){
				tmpvo.setMbr_pms_8("X");
			}else{
				tmpvo.setMbr_pms_8("O");
			}
			
			/*보험사 정보 수정*/
			if(tmpvo.getMbr_pms_9().equals("0")){
				tmpvo.setMbr_pms_9("X");
			}else{
				tmpvo.setMbr_pms_9("O");
			}
			
			/*관련 업체 엑셀 다운*/
			if(tmpvo.getMbr_pms_10().equals("0")){
				tmpvo.setMbr_pms_10("X");
			}else{
				tmpvo.setMbr_pms_10("O");
			}
			
			/*보험사 공지 관리(1종)*/
			if(tmpvo.getMbr_pms_11().equals("0")){
				tmpvo.setMbr_pms_11("X");
			}else{
				tmpvo.setMbr_pms_11("O");
			}
			
			/*보험사 공지 관리(4종)*/
			if(tmpvo.getMbr_pms_12().equals("0")){
				tmpvo.setMbr_pms_12("X");
			}else{
				tmpvo.setMbr_pms_12("O");
			}
			
			/*팀관리*/
			if(tmpvo.getMbr_pms_13().equals("0")){
				tmpvo.setMbr_pms_13("X");
			}else{
				tmpvo.setMbr_pms_13("O");
			}
			
			/*인사 기록*/
			if(tmpvo.getMbr_pms_14().equals("0")){
				tmpvo.setMbr_pms_14("X");
			}else{
				tmpvo.setMbr_pms_14("O");
			}
			
			/*인사 평가 관리 권한*/
			if(tmpvo.getMbr_pms_15().equals("0")){
				tmpvo.setMbr_pms_15("X");
			}else{
				tmpvo.setMbr_pms_15("O");
			}
			
			/*재직 증명서 승인*/
			if(tmpvo.getMbr_pms_16().equals("0")){
				tmpvo.setMbr_pms_16("X");
			}else{
				tmpvo.setMbr_pms_16("O");
			}
			
			/*경비 내역 결재 & 취소*/
			if(tmpvo.getMbr_pms_17().equals("0")){
				tmpvo.setMbr_pms_17("X");
			}else{
				tmpvo.setMbr_pms_17("O");
			}
			
			/*경비 승인 결재 & 취소*/
			if(tmpvo.getMbr_pms_18().equals("0")){
				tmpvo.setMbr_pms_18("X");
			}else{
				tmpvo.setMbr_pms_18("O");
			}
			
			/*적부 워드전환*/
			if(tmpvo.getMbr_pms_19().equals("0")){
				tmpvo.setMbr_pms_19("X");
			}else{
				tmpvo.setMbr_pms_19("O");
			}
			
			/*응답 전문*/
			if(tmpvo.getMbr_pms_20().equals("0")){
				tmpvo.setMbr_pms_20("X");
			}else{
				tmpvo.setMbr_pms_20("O");
			}
			
			/*통계*/
			if(tmpvo.getMbr_pms_21().equals("0")){
				tmpvo.setMbr_pms_21("X");
			}else{
				tmpvo.setMbr_pms_21("O");
			}
		}
		model.addAttribute("pmsList",authList);		
		
		String fileName = "권한변경로그.xls";
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
		
		return "sys_adm/top_pms_log_excel";			
	}

}//end of class
