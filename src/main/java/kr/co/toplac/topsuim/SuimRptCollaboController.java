package kr.co.toplac.topsuim;

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

import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.cmm.CommonUtils;

@Controller
public class SuimRptCollaboController {
	
private static final Logger logger = LoggerFactory.getLogger(SuimRptCollaboController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	/*
	 * ***************************************
	 * Method ID : addCollaboOk
	 * Method Name :  addCollaboOk
	 * Description : 공동수행자 입력
	 * 
	 * Author : 이선형
	 * Date : 20160615
	 * ***************************************
	 * */
	@RequestMapping(value = "addCollaboOk", method = RequestMethod.POST)
	public void addCollaboOk(Model model, HttpSession session, SuimRptCollaboVO suimRptCollaboVo, HttpServletResponse response) {
		
		logger.info("addCollaboOk");
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		
		PrintWriter out = null;
		
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		String nextserialNo = sqlSession.selectOne("SuimRptCollaboMapper.getNextCollaboSerial");
		
		int result = sqlSession.insert("SuimRptCollaboMapper.insCollabo", suimRptCollaboVo);

		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		
		/*보고서 기본 정보 수정 성공 시*/	
		if(result > 0){
			
			obj.put("serialNo", nextserialNo);
			obj.put("userId", suimRptCollaboVo.getUserId());
			obj.put("shareTeamId", suimRptCollaboVo.getShareTeamId());
			obj.put("userName", suimRptCollaboVo.getUserName());
			obj.put("collaboPp", suimRptCollaboVo.getCollaboPp());
			
			arr.add(obj);
			
			String jsonStr = arr.toString();
			out.print(jsonStr);
		}else{
			out.print(0);
		}
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : delCollaboOk
	 * Method Name :  delCollaboOk
	 * Description : 공동수행자 삭제
	 * 
	 * Author : 이선형
	 * Date : 20160615
	 * ***************************************
	 * */
	@RequestMapping(value = "delCollaboOk", method = RequestMethod.POST)
	public void delCollaboOk(Model model, HttpSession session, String serialNo, PrintWriter out, HttpServletResponse response) {
		
		logger.info("delCollaboOk");
		
		int result = sqlSession.delete("SuimRptCollaboMapper.delCollabo", serialNo);

		out.print(result);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID 	: actionCollabo
	 * Method Name 	: actionCollabo
	 * Description 	: 공동수행자 action (1종 새로 작성) 
	 * Author 		: LDS
	 * Date 		: 20180410
	 * ***************************************
	 * */	
	
	@RequestMapping(value = "actionCollabo", method = RequestMethod.POST)
	public String InsertCollabo(Model model, HttpSession session, SuimRptCollaboVO suimRptCollaboVo, String action, String suimRptType1,  HttpServletResponse response) {
		
		logger.info("actionCollabo : " + suimRptCollaboVo.getSuimRptNo());
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		Map<String,Object> paramMap = new HashMap<>();
		Map<String,Object> authMap = new HashMap<>();
		
		paramMap.put("user_no_session", String.valueOf(mbrVo.getUser_no()));
		paramMap.put("suim_rpt_no", suimRptCollaboVo.getSuimRptNo());
		
		if ("C".equals(action)){
			sqlSession.insert("SuimRptCollaboMapper.insertCollaboNew",suimRptCollaboVo);
		}else if("D".equals(action)){
			sqlSession.delete("SuimRptCollaboMapper.deleteCollaboNew",suimRptCollaboVo.getSerialNo());
		}
		
		List<SuimRptCollaboVO> collaboList =  sqlSession.selectList("SuimRptCollaboMapper.selectCollaboNew",suimRptCollaboVo.getSuimRptNo());
		
		model.addAttribute("collaboList",collaboList);
		model.addAttribute("suimRptType1",suimRptType1);
		
		//추가 수정 권한 체크 (오류 수정용) by top3009
		authMap = sqlSession.selectOne("SuimBookDtlMapper.getSuimBookDtlEditAuth", paramMap);
		
		model.addAttribute("authMap", authMap);
		
		return "top_suim/ajax/suim_rpt_bsc_end_collabo";
	}
	
	/**
	 * 보고서에 포한된 결재 수수료 정보 삭제
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "deleteCollaboApSerialNo", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> deleteCollaboApSerialNo(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		String serial_no = request.getParameter("serial_no") != null ? request.getParameter("serial_no") : "";
		
		logger.info("deleteCollaboApSerialNo : "+serial_no);		
		
		Map<String,Object> returnMap = new HashMap<String,Object>();
				
		if( serial_no != "" ) {
			//top_rpt_invoice 의 amt_total 값에서 차감한다.
			Map<String,Object> calResult = sqlSession.selectOne("SuimRptCollaboMapper.selectCollaboApprovalInfoBySerialNo", serial_no);
			
			//CommonUtils.printMap(calResult);			
			
			sqlSession.update("SuimRptCollaboMapper.updateTopInvoiceTotalAmtByRptInvoiceNo", calResult);
			
			sqlSession.delete("SuimRptCollaboMapper.deleteCollaboApprovalInfo", serial_no);
			
			returnMap.put("result", "success");
		}else{
			returnMap.put("result", "empty");
		}
		
		return returnMap;
	}
	
	/**
	 * 보고서에 포함된 결재 수수료가 있는지 체크하는 Ajax
	 * @param model
	 * @param session
	 * @param suimRptCollaboVo
	 * @param action
	 * @param suimRptType1
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "getCollaboApSerialNo", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> getCollaboApSerialNo(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		String suim_rpt_no = request.getParameter("suim_rpt_no") != null ? request.getParameter("suim_rpt_no") : "";
		
		logger.info("getCollaboApSerialNo : "+suim_rpt_no);		
		
		Map<String,Object> returnMap = new HashMap<String,Object>();
		
		int nCnt = 0;
		String sSerialNo = "";
		String maxSerialNo = "";
		
		if( suim_rpt_no != "" ) {			
			nCnt = sqlSession.selectOne("SuimRptCollaboMapper.selectCollaboApprovalCnt", suim_rpt_no);
			
			if( nCnt == 1 ) {			//결재수수료 정보가 있는 경우만 처리한다.
				sSerialNo = sqlSession.selectOne("SuimRptCollaboMapper.selectCollaboApprovalSerialNo",suim_rpt_no);
				returnMap.put("serialNo", sSerialNo);
				returnMap.put("result", "success");				
			}else if( nCnt > 1 ) {					//결재 수수료 정보가 2개 이상인 경우 한개의 데이터만 제외하고 삭제한다.
				Map<String,Object> paramMap = new HashMap<>();
				//중복데이터 중 가장 큰 serial_no 을 가져온다.
				maxSerialNo = sqlSession.selectOne("SuimRptCollaboMapper.selectCollaboApprovalMaxSerialNo",suim_rpt_no);
				paramMap.put("suim_rpt_no", suim_rpt_no);
				paramMap.put("serial_no", maxSerialNo);
				//중복데이터중 가장 큰 데이터를 한개를 제외하고 삭제한다.
				sqlSession.delete("SuimRptCollaboMapper.deleteCollaboApprovalDupSerialNo", paramMap);
				
				sSerialNo = sqlSession.selectOne("SuimRptCollaboMapper.selectCollaboApprovalSerialNo",suim_rpt_no);
				returnMap.put("serialNo", sSerialNo);
				returnMap.put("result", "success");
			}else{
				returnMap.put("result", "empty");
			}			
		}else{
			returnMap.put("result", "empty");
		}
		
		return returnMap;
	}
	
	/*
	 * ***************************************
	 * Method ID 	: validCollabo
	 * Method Name 	: validCollabo
	 * Description 	: 공동수행자 추가 유효성체크
	 * Author 		: LDS
	 * Date 		: 20180523
	 * ***************************************
	 * */	
	
	@RequestMapping(value = "validCollabo", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> validCollabo(Model model, HttpSession session, SuimRptCollaboVO suimRptCollaboVo, String action, String suimRptType1,  HttpServletResponse response) {
		logger.info("validCollabo : " + suimRptCollaboVo.getSuimRptNo());

		Map<String,Object> collaboMap = new HashMap<String,Object>();
		collaboMap = sqlSession.selectOne("SuimRptCollaboMapper.selectCollaboForValid",suimRptCollaboVo.getSuimRptNo());
		
		int amtBasic = Integer.parseInt(String.valueOf(collaboMap.get("amtBasic")));
		int amtDaily = Integer.parseInt(String.valueOf(collaboMap.get("amtDaily")));  
		int amtTraffic = Integer.parseInt(String.valueOf(collaboMap.get("amtTraffic"))); 
		
		int collaboBasic = Integer.parseInt(String.valueOf(collaboMap.get("collaboBasic"))); 
		int collaboDaily = Integer.parseInt(String.valueOf(collaboMap.get("collaboDaily"))); 
		int collaboTraffic = Integer.parseInt(String.valueOf(collaboMap.get("collaboTraffic"))); 
		//int thisBasic = (int) (amtBasic * Integer.parseInt(suimRptCollaboVo.getCollaboPp()) * 0.01);
		int thisBasic = (int) (suimRptCollaboVo.getCollaboPriceType().equals("0") ? ( (int) (amtBasic * Integer.parseInt(suimRptCollaboVo.getCollaboPrice()) * 0.01) ) : Integer.parseInt(suimRptCollaboVo.getCollaboDaily()));		
		int thisDaily = (int) (suimRptCollaboVo.getCollaboDailyType().equals("0") ? ( (int) (amtDaily * Integer.parseInt(suimRptCollaboVo.getCollaboDaily()) * 0.01) ) : Integer.parseInt(suimRptCollaboVo.getCollaboDaily()));
		int thisTraffic = Integer.parseInt(suimRptCollaboVo.getCollaboTraffic());
		
		int sumCollaboBasic = thisBasic + collaboBasic;
		int sumCollaboDaily = thisDaily + collaboDaily;
		int sumCollaboTraffic = thisTraffic + collaboTraffic;
		
		collaboMap.put("collaboBasic", sumCollaboBasic);
		collaboMap.put("collaboDaily", sumCollaboDaily);
		collaboMap.put("collaboTraffic", sumCollaboTraffic);
		
		collaboMap.put("validBasic", 0);
		collaboMap.put("validDaily", 0);
		collaboMap.put("validTraffic", 0);
		
		if ( amtBasic < sumCollaboBasic ){
			collaboMap.put("validBasic", 1);
		}
		
		if ( amtDaily < sumCollaboDaily ){
			collaboMap.put("validDaily", 1);
		}
		
		if ( amtTraffic < sumCollaboTraffic ){
			collaboMap.put("validTraffic", 1);
		}
		
		return collaboMap;
	}
	
	
	
	
	@RequestMapping(value = "invoicePrintPage", method = RequestMethod.GET)
	public String invoicePrintPage(Model model, HttpSession session, String suimRptNo, String type2) {
		
		logger.info("invoicePrintPage");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		/*보고서 기본 정보*/
		SuimRptInvVO rptInvInfoVo = sqlSession.selectOne("rptInvoiceBscMapper.getRptInvList", suimRptNo);
		model.addAttribute("rptInvInfoVo", rptInvInfoVo);
		
		/*Print 공통 정보 추출 시작*/
		TopTmBscVO topTmBscVo = sqlSession.selectOne("SuimRptBodyMapper.topTmInfoForBody", rptInvInfoVo.getTeam_id());
		TopMbrBscVO mbrVoForBody = sqlSession.selectOne("SuimRptBodyMapper.mbrinfo", rptInvInfoVo.getUser_no());
		
		//현대해상이고 질병상해가 아닌 경우 결재 수수료 항목 정보를 가져온다.
		String sPtnrId = rptInvInfoVo.getPtnr_id();
		String sSuimRptType1 = rptInvInfoVo.getSuim_rpt_type1();
		String sSuimRptNo = rptInvInfoVo.getSuim_rpt_no();
		
		if( "14".equals(sPtnrId) && !"3".equals(sSuimRptType1) && !"4".equals(sSuimRptType1) ) {			
			SuimRptCollaboVO collaboApprovalVO = new SuimRptCollaboVO();
			
			//기존 결재수수료 입력 건이 있는지 체크한다.
			int nCnt = sqlSession.selectOne("SuimRptCollaboMapper.selectCollaboApprovalCnt", sSuimRptNo);
			
			if( nCnt == 1 ) {
				collaboApprovalVO = sqlSession.selectOne("SuimRptCollaboMapper.selectCollaboApproval",sSuimRptNo);					
			}
			
			model.addAttribute("collaboApprovalVO", collaboApprovalVO);
			
			//재직중인 직원의 목록을 물러온다.
			List<Map<String, Object>> approvalUserList = sqlSession.selectList("StatisticBasic.selectTopMemberList");		
			model.addAttribute("approvalUserList", approvalUserList);
		}
		
		model.addAttribute("topTmBscVo", topTmBscVo);
		model.addAttribute("mbrVoForBody", mbrVoForBody);
		
		/*보고서의 팀정보 추출*/
		/*TopTmBscVO teamVo = sqlSession.selectOne("SagoBscMapper.getRptTeamForSago", rptInvInfoVo.getTeam_id());
		model.addAttribute("teamVo", teamVo);*/
		
		return "top_suim/suim_rpt_bsc_inv_print";
		 
	}
	
}
