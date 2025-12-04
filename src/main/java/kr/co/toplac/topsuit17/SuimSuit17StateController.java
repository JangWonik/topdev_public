/*
*********************************************************
* Program ID	: PrimbizSuimListController
* Program Name	: PrimbizSuimListController
* Description	: 농작물 수임대장 리스트
* Author		: 
* Date			: 2016.06.09.
*********************************************************
*/
package kr.co.toplac.topsuit17;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

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

import kr.co.toplac.sysadm.SysAdmCodeDicVO;
import kr.co.toplac.topprimbiz.TopPrimBizRptCompositeVO;
import kr.co.toplac.topprimbizinv.TopPrimBizInvCompositeVO;
import kr.co.toplac.topsuit17.SuimSuit_17VO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;

@Controller
public class SuimSuit17StateController {

	private static final Logger logger = LoggerFactory.getLogger(SuimSuit17StateController.class);

	@Autowired
	private SqlSession sqlSession;

	/*
	*********************************************************
	* Program ID	: suimSuit17List
	* Program Name	: suimSuit17List
	* Description	: 적부(흥국) 리스트
	* Author		: 
	* Date			: 2016.09.01.
	*********************************************************
	*/
	
	
	@RequestMapping(value = "actionSuimSuit17ReportOk", method = RequestMethod.POST)
	public void actionSuimSuit17ReportOk(Model model,String action, HttpSession session, HttpServletResponse response, String suimRptNo, SuimSuit_17VO dtlVO) {
	
		logger.info("actionSuimSuit17ReportOk");
		
		/*로그인 유저의 세션 정보 추출 시작*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		model.addAttribute("mbrAuthSessionVo", mbrAuthVo);
		/*로그인 유저의 세션 정보 추출 끝*/
		
		/* 보고서 정보 추출*/
		SuimSuit_17VO getSuimSuit17DtlBsc = sqlSession.selectOne("SuimSuit17DtlMapper.getSuimSuit17DtlBsc", dtlVO);
		model.addAttribute("getSuimSuit17DtlBsc", getSuimSuit17DtlBsc);	
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		if(action.equals("submit")){
			
					
					int suimSuit17RptActionRptSubmit = sqlSession.update("SuimSuit17StateMapper.suimSuit17RptActionRptSubmit",suimRptNo);
					
					int result = 0;
					if(suimSuit17RptActionRptSubmit > 0){
						
						result = 1;
				}
					
					out.print(result);
			}
		
		//결재 취소하기
		else if(action.equals("submit_x")){
			int suimSuit17RptActionSangsinCancel = sqlSession.update("SuimSuit17StateMapper.suimSuit17RptActionSangsinCancel",suimRptNo);
			int result = 0;
			if(suimSuit17RptActionSangsinCancel > 0){
				
				result = 1;
			}
			
			out.print(result);
			
		}
		
		//결재 반려하기
		else if(action.equals("returnRpt")){
			
			int primBizRptActionRptReturn = sqlSession.update("SuimSuit17StateMapper.suimSuit17RptActionRptReturn", suimRptNo);
			int result = 0;
			if(primBizRptActionRptReturn > 0){
				
				result = 1;
			}
			
			out.print(result);
		}
		
		//결재 반려 재결재 하기
		else if(action.equals("return_x")){

			int primBizRptActionRptReturnCancel = sqlSession.update("SuimSuit17StateMapper.suimSuit17RptActionRptReturnCancel", suimRptNo);
			int result = 0;
			if(primBizRptActionRptReturnCancel > 0){
				
				result = 1;
			}
			
			out.print(result);
		}
		
		//종결 취소하기
		else if(action.equals("submit_e_x")){
			

			int suimSuit17RptActionEndedCancel = sqlSession.update("SuimSuit17StateMapper.suimSuit17RptActionEndedCancel", suimRptNo);
			
			int result = 0;
			if(suimSuit17RptActionEndedCancel > 0){
				
				result = 1;
			}
			
			out.print(result);
		}
		
		// 위임취소하기
		else if(action.equals("cancel")){ 

			int suimSuit17RptActionCancel = sqlSession.update("SuimSuit17StateMapper.suimSuit17RptActionCancel",suimRptNo);
			int result = 0;
			if(suimSuit17RptActionCancel > 0){
				
				result = 1;
			}
			
			out.print(result);

		}
		// 위임 취소를 취소하기	
		else if(action.equals("cancel_x")){ 

			int suimSuit17RptActionCancelX = sqlSession.update("SuimSuit17StateMapper.suimSuit17RptActionCancelX",suimRptNo);
			
			int result = 0;
			if(suimSuit17RptActionCancelX > 0){
				
				result = 1;
			}
			
			out.print(result);
		
		
		// 보고서 삭제하기
		}else if(action.equals("report_del")){

			int suimSuit17RptActionDel = sqlSession.update("SuimSuit17StateMapper.suimSuit17RptActionDel",suimRptNo);
			
			int result = 0;
			if(suimSuit17RptActionDel > 0) {
				
				result = 1;
			}
			
			out.print(result);
		
		//종결하기 일반
		}else if(action.equals("end")){ 
								
			/*현재날짜계산*/
			Calendar cal = Calendar.getInstance();    
			cal.setTime(new Date());    
			DateFormat df = new SimpleDateFormat("yyyyMMdd"); 
			DateFormat dfToday = new SimpleDateFormat("yyyy-MM-dd"); 
			String closeToday = dfToday.format(cal.getTime());
			String today = df.format(cal.getTime());
			String thisYearMonth = today.substring(2, 6);

			/*이 보고서의 현재 종결No 앞자리 구하기 TJE + 연도 2자리 + 월 2자리*/
			String nextRptCloseNoStr = "";
			HashMap<String, String> mapForAcceptSeqNo = new HashMap<String, String>();
			mapForAcceptSeqNo.put("suim_accept_seq_no", "");
			sqlSession.update("SuimSuit17StateMapper.getNowResultNo", mapForAcceptSeqNo);
			nextRptCloseNoStr = mapForAcceptSeqNo.get("suim_accept_seq_no");
			for(int i = nextRptCloseNoStr.length(); i < 4; i++){
				nextRptCloseNoStr = "0"+nextRptCloseNoStr;
			}
			/*차기 종결 번호 구하기 시작*//*
			String searchStr = "TJE"+thisYearMonth;
			HashMap<String, String> tmpMap = new HashMap<String, String>();
			tmpMap.put("searchStr", searchStr);
			if(getSuimSuit17DtlBsc.getTeamId().equals("6") || getSuimSuit17DtlBsc.getTeamId().equals("8") || getSuimSuit17DtlBsc.getTeamId().equals("9") || getSuimSuit17DtlBsc.getTeamId().equals("10")
					|| getSuimSuit17DtlBsc.getTeamId().equals("11")|| getSuimSuit17DtlBsc.getTeamId().equals("13")|| getSuimSuit17DtlBsc.getTeamId().equals("24")|| getSuimSuit17DtlBsc.getTeamId().equals("38")
					|| getSuimSuit17DtlBsc.getTeamId().equals("39")|| getSuimSuit17DtlBsc.getTeamId().equals("40")|| getSuimSuit17DtlBsc.getTeamId().equals("44")|| getSuimSuit17DtlBsc.getTeamId().equals("43")){
				String maxResultNo = sqlSession.selectOne("SuimSuit17StateMapper.getNowResultNo1",tmpMap);
				//String maxResultNo = sqlSession.selectOne("PrimBizSuimDtlMapper.getNowResultNo1",searchStr); 
				if(maxResultNo == null || maxResultNo == ""){
					maxResultNo = "0";
				}
				nextRptCloseNoStr = nextRptCloseNoStr(maxResultNo);
			}else if(getSuimSuit17DtlBsc.getTeamId().equals("12") || getSuimSuit17DtlBsc.getTeamId().equals("14") || getSuimSuit17DtlBsc.getTeamId().equals("27") 	){
				String maxResultNo = sqlSession.selectOne("SuimSuit17StateMapper.getNowResultNo2",tmpMap); 
				if(maxResultNo == null){
					maxResultNo = "0";
				}
				nextRptCloseNoStr = nextRptCloseNoStr(maxResultNo);
			}else{
				HashMap<String,String> map = new HashMap<String,String>();
				map.put("team_id", getSuimSuit17DtlBsc.getTeamId());
				map.put("searchStr", searchStr);
				String maxResultNo = sqlSession.selectOne("SuimSuit17StateMapper.getNowResultNo3",map); 
				if(maxResultNo == null){
					maxResultNo = "0";
				}
				nextRptCloseNoStr = nextRptCloseNoStr(maxResultNo);
			}
			*//*차기 종결 번호 구하기 끝*/

			String nextCloseNo = "TJE"+thisYearMonth+"-"+nextRptCloseNoStr;
			HashMap<String,String> map = new HashMap<String,String>();
			map.put("suimRptNo", suimRptNo);
			map.put("nextCloseNo", nextCloseNo);
			
			/*String closeDate = "";
			
			if(getSuimSuit17DtlBsc.getCloseDate() != null){
				if(!getSuimSuit17DtlBsc.getCloseDate().equals("1970-01-01")){
					closeDate = getSuimSuit17DtlBsc.getCloseDate();
			}else if(getSuimSuit17DtlBsc.getCloseDate() != null || getSuimSuit17DtlBsc.getCloseDate() == '0'){
					closeDate = closeToday;
				}
			}else{
				closeDate = closeToday;
			}
			map.put("closeDate", closeDate);*/
			
			/*보고서 정보 종결 업데이트*/
			int rptActionRptEnd = sqlSession.update("SuimSuit17StateMapper.rptActionRptEnd", map);
			int result = 0;
			if(rptActionRptEnd > 0) {
				
				result = 1;
			}
			
			out.print(result);
		}
			
		
		
	}

	/*결재하기 동작 중 다음 종결 No 구하기*/ 
	/*현재종결No 의 최신값에 +1 한 값으로 다음 종결No 구함 : nextRptCloseNoStr*/
/*
	private String nextRptCloseNoStr(String maxResultNo) {
		int nextRptCloseNo = 0;
		if(maxResultNo.split("-").length ==2){
			String nowRptCloseNo = maxResultNo.split("-")[1];
			nextRptCloseNo = Integer.parseInt(nowRptCloseNo)+1;					
		}else{
			nextRptCloseNo = 1;
		}
		String nextRptCloseNoStr = Integer.toString(nextRptCloseNo);
		if(nextRptCloseNoStr.length() == 1){
			nextRptCloseNoStr = "000"+nextRptCloseNoStr;
		}else if(nextRptCloseNoStr.length() == 2){
			nextRptCloseNoStr = "00"+nextRptCloseNoStr;
		}else if(nextRptCloseNoStr.length() == 3){
			nextRptCloseNoStr = "0"+nextRptCloseNoStr;
		}
		return nextRptCloseNoStr;
	}
*/

}//end of class
