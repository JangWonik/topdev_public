package kr.co.toplac.topsuim;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

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

import kr.co.toplac.topsuit.SuimSuit_10VO;
import kr.co.toplac.util.etc.Damo;
import kr.co.toplac.util.page.PageUtilityBasic;

@Controller
public class SuimRptHelpController {
	
private static final Logger logger = LoggerFactory.getLogger(SuimRptHelpController.class);
	
	@Autowired
	private SqlSession sqlSession;
	

	/*
	 * ***************************************
	 * Method ID : helpRptIns
	 * Method Name :  helpRptIns
	 * Description : 협조건 입력 
	 * 
	 * Author : 이선형
	 * Date : 20160526
	 * ***************************************
	 * */
	@RequestMapping(value = "helpRptIns", method = RequestMethod.POST)
	public void helpRptIns(Model model, HttpSession session, SuimRptHelpBscVO helpViewVo , HttpServletResponse response) {
		
		logger.info("=========== helpRptIns ===========");
		
		/*번호 1*/
		int result = sqlSession.insert("HelpBscMapper.rptHelpIns", helpViewVo );
		String justInsSerial = sqlSession.selectOne("HelpBscMapper.getJustIns", helpViewVo.getSuimRptNo());
		SuimRptHelpBscVO justInsVo = sqlSession.selectOne("HelpBscMapper.getJustInsVo",justInsSerial);

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		
		PrintWriter out = null;
		
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		JSONArray arr = new JSONArray();
		
		JSONObject obj = new JSONObject();
		
		if(justInsVo.getHelpState().equals("0")){
			justInsVo.setHelpState("대기");
		}else if(justInsVo.getHelpState().equals("1")){
			justInsVo.setHelpState("진행");
		}else if(justInsVo.getHelpState().equals("2")){
			justInsVo.setHelpState("완료요청");
		}else if(justInsVo.getHelpState().equals("3")){
			justInsVo.setHelpState("완료");
		}

		if(result >0){
			
			obj.put("regDate", justInsVo.getRegDate());
			obj.put("clientMbr", justInsVo.getClientMbr());
			obj.put("helpState", justInsVo.getHelpState());
			obj.put("priceTotal", justInsVo.getPriceTotal());
			obj.put("endDate", justInsVo.getEndDate());
			obj.put("serialNo", justInsVo.getSerialNo());
			obj.put("acceptTmId", justInsVo.getAcceptTmId());
			obj.put("acceptTm", justInsVo.getAcceptTm());
			obj.put("helpResult", justInsVo.getHelpResult());
			obj.put("clientTm", justInsVo.getClientTm());
			obj.put("trafficFee", justInsVo.getTrafficFee());
			obj.put("chartFee", justInsVo.getChartFee());
			obj.put("priceTotal", justInsVo.getPriceTotal());
			
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
	 * Method ID : rptHelpGetTopMbrList
	 * Method Name :  rptHelpGetTopMbrList
	 * Description : 협조건 상세 보기 시 표출 할 수임팀 인원 목록
	 * 
	 * 번호 1 :  
	 * Author : 이선형
	 * Date : 20160527
	 * ***************************************
	 * */
	@RequestMapping(value = "rptHelpGetTopMbrList", method = RequestMethod.POST)
	public void rptHelpGetTopMbrList(Model model, HttpSession session, String acceptTm, String serialNo, HttpServletResponse response) {
	
		logger.info("rptHelpGetTopMbrList");
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		
		PrintWriter out = null;
		
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		String acceptId = sqlSession.selectOne("HelpBscMapper.getAcceptMbr", serialNo); 
		
		/*해당 팀의 인원 추출*/
		List<SuimRptHelpAcceptMbrVO>  mbrList = sqlSession.selectList("HelpBscMapper.getAcceptMbrList",acceptTm);
		
		JSONArray arr = new JSONArray();
		for(int i=0; i < mbrList.size(); i++){
			
			SuimRptHelpAcceptMbrVO mbrVo = mbrList.get(i);
			
			JSONObject obj = new JSONObject();
			
			obj.put("user_no", mbrVo.getUser_no());
			obj.put("user_name", mbrVo.getUser_name());
			obj.put("accpetId", acceptId);

			arr.add(obj);
		}
		
		String jsonStr = arr.toString();
		out.print(jsonStr);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : helpRptUdt
	 * Method Name :  helpRptUdt
	 * Description : 협조건 상세 보기 후 업데이트
	 * 
	 * 번호 1 :  
	 * Author : 이선형
	 * Date : 20160530
	 * ***************************************
	 * */
	@RequestMapping(value = "helpRptUdt", method = RequestMethod.POST)
	public void helpRptUdt(Model model, HttpSession session, SuimRptHelpBscVO suimRptHelpBscVo , HttpServletResponse response) {
	
		logger.info("helpRptUdt");
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		
		PrintWriter out = null;
		
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		int result = sqlSession.update("HelpBscMapper.uptHelpOne", suimRptHelpBscVo); 
		
		if(result > 0){

			SuimRptHelpBscVO suimRptHelpBscVoUdt = sqlSession.selectOne("HelpBscMapper.getUdtedHelp", suimRptHelpBscVo.getSerialNo());
			
			if(suimRptHelpBscVoUdt.getHelpState().equals("0")){
				suimRptHelpBscVoUdt.setHelpState("대기");
			}else if(suimRptHelpBscVoUdt.getHelpState().equals("1")){
				suimRptHelpBscVoUdt.setHelpState("진행");
			}else if(suimRptHelpBscVoUdt.getHelpState().equals("2")){
				suimRptHelpBscVoUdt.setHelpState("완료요청");
			}else if(suimRptHelpBscVoUdt.getHelpState().equals("3")){
				suimRptHelpBscVoUdt.setHelpState("완료");
			}
			
			JSONArray arr = new JSONArray();
			
			JSONObject obj = new JSONObject();
			
			obj.put("serialNo", suimRptHelpBscVo.getSerialNo());
			obj.put("acceptMbr", suimRptHelpBscVoUdt.getAcceptMbr());
			obj.put("priceTotal", suimRptHelpBscVoUdt.getPriceTotal());
			obj.put("helpState", suimRptHelpBscVoUdt.getHelpState());
			
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
	 * Method ID : helpBookList
	 * Method Name :  helpBookList
	 * Description : 협조건 대장 
	 * 
	 * 번호 1 :  
	 * Author : 이선형
	 * Date : 20160530
	 * ***************************************
	 * */
	@RequestMapping(value = "helpBookList", method = RequestMethod.GET)
	public String helpBookList(Model model, HttpSession session, SuimRptHelpBscVO suimRptHelpBscVo, String reqPgNo, String srchSuimAcceptNo) {
	
		logger.info("=============== helpBookList ==============");
		
		//List<SuimRptHelpBscVO> suimRptHelpBscList= sqlSession.selectList("HelpBscMapper.getHelpListForBookList");
		
		PageUtilityBasic pageUtil = new PageUtilityBasic();
		
//		List<SuimRptHelpBscVO> suimRptHelpBscList
//		= (List<SuimRptHelpBscVO>) pageUtil.pageBasic1(1, sqlSession, "HelpBscMapper.getHelpListForBookList", reqPgNo, model, "helpBookList");			
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("user_no_session", (String)(session.getAttribute("user_no_Session")) );
		map.put("srchSuimAcceptNo", srchSuimAcceptNo);
		List<SuimRptHelpBscVO> suimRptHelpBscList
		= (List<SuimRptHelpBscVO>) pageUtil.pageBasic1Search(1, sqlSession, "HelpBscMapper.getHelpListForBookList", reqPgNo, model, "helpBookList", map);

		int rowNum = sqlSession.selectOne("HelpBscMapper.cntRpt");
		
		if(reqPgNo == null || reqPgNo.equals("")){
			reqPgNo = "1";
		}
		
		int j=0;
		for (int i = rowNum-(18*(Integer.parseInt(reqPgNo)-1)) ; i > (rowNum-(18*(Integer.parseInt(reqPgNo)-1)) - suimRptHelpBscList.size() ); i--) {
			
			suimRptHelpBscList.get(j).setROWNUM(Integer.toString(i));
			
			if( suimRptHelpBscList.get(j).getHelpState().equals("0")){
				suimRptHelpBscList.get(j).setHelpState("대기");
			}else if(suimRptHelpBscList.get(j).getHelpState().equals("1")){
				suimRptHelpBscList.get(j).setHelpState("진행");
			}else if(suimRptHelpBscList.get(j).getHelpState().equals("2")){
				suimRptHelpBscList.get(j).setHelpState("완료요청");
			}else if(suimRptHelpBscList.get(j).getHelpState().equals("3")){
				suimRptHelpBscList.get(j).setHelpState("완료");
			}
			
			j++;
			
		}
		
		model.addAttribute("helpBookList", suimRptHelpBscList);
		model.addAttribute("srchSuimAcceptNo", srchSuimAcceptNo);
		
		return "top_suim/suim_book_help_list";	
	}
	
	
	/*
	 * ***************************************
	 * Method ID : helpRptBscDtl
	 * Method Name :  helpRptBscDtl
	 * Description : 협조건 상세 팝업 
	 * 
	 * 번호 1 :  
	 * Author : 이선형
	 * Date : 20160531
	 * ***************************************
	 * */
	@RequestMapping(value = "helpRptBscDtl", method = RequestMethod.GET)
	public String helpRptBscDtl(Model model, HttpSession session, String serialNo) {
	
		logger.info("helpRptBscDtl");
		
		HashMap<String,String> map = new HashMap<String,String>();
		
		map.put("serialNo", serialNo);
		map.put("user_no_session", (String)(session.getAttribute("user_no_Session")) );
		String acceptId = sqlSession.selectOne("HelpBscMapper.getAcceptMbrForDtl", map);
		
		if(!acceptId.equals("0")){
			map.put("acceptId", acceptId);
		}else{
			map.put("acceptId", "");
		}
		
		SuimRptHelpCompositeVO suimRptHelpBscVo= sqlSession.selectOne("HelpBscMapper.getHelpOneForDtl",map);
		
		Damo damo = new Damo();
		if (suimRptHelpBscVo.getPolicyholderTel() != null && !suimRptHelpBscVo.getPolicyholderTel().equals("")){
			suimRptHelpBscVo.setPolicyholderTel(damo.decodeDamo(suimRptHelpBscVo.getPolicyholderTel()));
		}
		if (suimRptHelpBscVo.getBeneficiaryTel() != null && !suimRptHelpBscVo.getBeneficiaryTel().equals("")){
			suimRptHelpBscVo.setBeneficiaryTel(damo.decodeDamo(suimRptHelpBscVo.getBeneficiaryTel()));
		}
		
		if( suimRptHelpBscVo.getHelpState().equals("0")){
			suimRptHelpBscVo.setHelpState("대기");
		}else if(suimRptHelpBscVo.getHelpState().equals("1")){
			suimRptHelpBscVo.setHelpState("진행");
		}else if(suimRptHelpBscVo.getHelpState().equals("2")){
			suimRptHelpBscVo.setHelpState("완료요청");
		}else if(suimRptHelpBscVo.getHelpState().equals("3")){
			suimRptHelpBscVo.setHelpState("완료");
		}
		
		if(suimRptHelpBscVo.getHelpFile() != null){
			if(!suimRptHelpBscVo.getHelpFile().equals("")){
				suimRptHelpBscVo.setHelpFile(suimRptHelpBscVo.getHelpFile().substring(suimRptHelpBscVo.getHelpFile().lastIndexOf("/")+1));
			}
		}
		
		/** 종결 후 수정 **/
		HashMap<String,String> lsAdminMap =  new HashMap<String,String>();
		lsAdminMap.put("user_no", ""+session.getAttribute("user_no_Session"));
		lsAdminMap.put("team_id1", suimRptHelpBscVo.getClientTmId());
		lsAdminMap.put("team_id2", suimRptHelpBscVo.getAcceptTmId());
		
		String ls_admin22 = sqlSession.selectOne("SuimBookDtlMapper.getEndModAuthHelp", lsAdminMap);
		model.addAttribute("endModFlag",ls_admin22);
		
		
		/*해당 팀의 인원 추출*/
		List<SuimRptHelpAcceptMbrVO>  mbrList = sqlSession.selectList("HelpBscMapper.getAcceptMbrList",suimRptHelpBscVo.getAcceptTmId());
		model.addAttribute("mbrList", mbrList);
		
		/*의뢰인 전화번호*/
		String clientPhone  = sqlSession.selectOne("HelpBscMapper.getClientPhone", suimRptHelpBscVo.getClientMbrId());
		model.addAttribute("clientPhone", clientPhone);
		
		model.addAttribute("helpVo", suimRptHelpBscVo);
		
		return "top_suim/suim_rpt_help_dtl";	
	}
	
	
	/*
	 * ***************************************
	 * Method ID : helpRptDel
	 * Method Name :  helpRptDel
	 * Description : 협조건 상세 팝업에서 건 삭제 
	 * 
	 * 번호 1 :  
	 * Author : 이선형
	 * Date : 20160531
	 * ***************************************
	 * */
	@RequestMapping(value = "helpRptDel", method = RequestMethod.POST)
	public void helpRptDel(String serialNo, PrintWriter out) {
	
		logger.info("helpRptDel");
		
		int result = sqlSession.delete("HelpBscMapper.delHelpOneForDtl",serialNo);
		
		out.print(result);
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : helpDone
	 * Method Name :  helpDone
	 * Description : 협조건 완료
	 * 
	 * 번호 1 :  
	 * Author : 이선형
	 * Date : 20160622
	 * ***************************************
	 * */
	@RequestMapping(value = "helpDone", method = RequestMethod.POST)
	public void helpDone(String serialNo, PrintWriter out) {
	
		logger.info("helpDone");
		
		int result = sqlSession.update("HelpBscMapper.helpDone",serialNo);
		
		out.print(result);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : helpReturn
	 * Method Name :  helpReturn
	 * Description : 협조건 완료 취소
	 * 
	 * Author : 임대성
	 * Date : 2017-01-24
	 * ***************************************
	 * */
	@RequestMapping(value = "helpReturn", method = RequestMethod.POST)
	public void helpReturn(String serialNo, PrintWriter out) {
		logger.info("helpReturn");
		
		int result = sqlSession.update("HelpBscMapper.helpReturn",serialNo);
		
		out.print(result);
		out.close();
	}	

	/*
	 * ***************************************
	 * Method ID : helpCancel
	 * Method Name :  helpCancel
	 * Description : 완료요청 - > 진행 변경
	 * 
	 * Author : 임대성
	 * Date : 20180913
	 * ***************************************
	 * */
	@RequestMapping(value = "helpCancel", method = RequestMethod.POST)
	public void helpCancel(SuimRptHelpBscVO suimRptHelpBscVo, PrintWriter out) {
		logger.info("helpReturn");
		
//		int result = sqlSession.update("HelpBscMapper.uptHelpOne", suimRptHelpBscVo); 
		int result = sqlSession.update("HelpBscMapper.helpCancel",suimRptHelpBscVo.getSerialNo());
		
		out.print(result);
		out.close();
	}	
	
	/*
	 * ***************************************
	 * Method ID : helpConfirm
	 * Method Name :  helpConfirm
	 * Description : 대기 -> 완료로 변경
	 * 
	 * Author : 임대성
	 * Date : 2017-01-24
	 * ***************************************
	 * */
	@RequestMapping(value = "helpConfirm", method = RequestMethod.POST)
	public void helpConfirm(SuimRptHelpBscVO suimRptHelpBscVo, PrintWriter out) {
		logger.info("helpReturn");
		
		int result = sqlSession.update("HelpBscMapper.uptHelpOne", suimRptHelpBscVo); 
		result = sqlSession.update("HelpBscMapper.helpConfirm",suimRptHelpBscVo.getSerialNo());
		
		out.print(result);
		out.close();
	}	
	
	
	
	/*
	 * ***************************************
	 * Method ID : helpDone
	 * Method Name :  helpDone
	 * Description : 협조건 완료
	 * 
	 * 번호 1 :  
	 * Author : 이선형
	 * Date : 20160622
	 * ***************************************
	 * */
	@RequestMapping(value = "helpFileDel", method = RequestMethod.POST)
	public void helpFileDel(String serialNo, String suimRptNo, PrintWriter out) {
	
		logger.info("helpFileDel");
		
		String path = "/home/hosting_users/toplac/www"+sqlSession.selectOne("HelpBscMapper.helpFilePathForDown", serialNo);
		String fileFolder = path.substring(path.lastIndexOf("/")+1);
		
		
		int result = 0;
		
		//파일 삭제 시작
		if(!fileFolder.equals("")){
			
			File file = new File(path);
			File dir = new File(fileFolder);
			file.delete();
			dir.delete();
			
			result = 1;
		}
		//파일 삭제 종료
		
		sqlSession.update("HelpBscMapper.delRptHelpFile", serialNo);
		
		out.print(result);
		out.close();
	}
}
