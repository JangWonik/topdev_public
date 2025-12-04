package kr.co.toplac.topsuim;

import java.io.IOException;
import java.io.PrintWriter;
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

import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;

@Controller
public class SuimRptSagoController {
	
private static final Logger logger = LoggerFactory.getLogger(SuimRptSagoController.class);
	
	@Autowired
	private SqlSession sqlSession;
	

	/*
	 * ***************************************
	 * Method ID : sagoRptIns
	 * Method Name :  sagoRptIns
	 * Description : 사고처리 과정표 입력 
	 * 
	 * Author : 이선형
	 * Date : 20160524
	 * ***************************************
	 * */
	@RequestMapping(value = "sagoRptIns", method = RequestMethod.POST)
	public void sagoRptIns(Model model, HttpSession session, SuimRptSagoBscVO sagoViewVo, PrintWriter out) {
		
		logger.info("sagoRptIns");
		
		/*번호 1*/
		int result = sqlSession.insert("SagoBscMapper.rptSagoIns", sagoViewVo );
		
		String topRptSagoNo = sqlSession.selectOne("SagoBscMapper.getLatestSagoNo", sagoViewVo.getSuimRptNo());
		
		if(result > 0){
			out.print(topRptSagoNo);			
		}else{
			out.print(0);
		}
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : sagoRptIns16
	 * Method Name :  sagoRptIns16
	 * Description : 사고처리 과정표 : 인보험 16 입력 
	 * 
	 * Author : 이선형
	 * Date : 20160722
	 * ***************************************
	 * */
	@RequestMapping(value = "sagoRptIns16", method = RequestMethod.POST)
	public void sagoRptIns16(SuimRptSagoBsc16VO sago16ViewVo, PrintWriter out) {
		
		logger.info("sagoRptIns16");
		
		/*번호 1*/
		int result = sqlSession.insert("SagoBscMapper.rptSagoIns16", sago16ViewVo );
		
		String topRptSagoNo = sqlSession.selectOne("SagoBscMapper.getLatestSago16No", sago16ViewVo.getSuimRptNo());
		
		if(result > 0){
			out.print(topRptSagoNo);			
		}else{
			out.print(0);
		}
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : sagoRptUdt
	 * Method Name :  sagoRptUdt
	 * Description : 사고처리 과정표 수정 
	 * 번호 1 : 테이블 수정
	 * Author : 이선형
	 * Date : 20160524
	 * ***************************************
	 * */
	@RequestMapping(value = "sagoRptUdt", method = RequestMethod.POST)
	public void sagoRptUdt(Model model, HttpSession session, SuimRptSagoBscVO sagoViewVo, HttpServletResponse response) {
		
		logger.info("sagoRptUdt");
		
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
		
		/*번호 1*/
		int result = sqlSession.update("SagoBscMapper.rptSagoUdt", sagoViewVo );
		SuimRptSagoBscVO resultVo = sqlSession.selectOne("SagoBscMapper.getSagoOne",sagoViewVo.getSagoNo() );

		if(result >0){
			
			obj.put("regDate", resultVo.getRegDate());
			obj.put("item", resultVo.getItem());
			obj.put("content", resultVo.getContent());
			obj.put("sagoNo", resultVo.getSagoNo());
			
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
	 * Method ID : sagoRptUdt16
	 * Method Name :  sagoRptUdt16
	 * Description : 사고처리 과정표 : 인보험 16 수정 
	 * 번호 1 : 테이블 수정
	 * Author : 이선형
	 * Date : 20160722
	 * ***************************************
	 * */
	@RequestMapping(value = "sagoRptUdt16", method = RequestMethod.POST)
	public void sagoRptUdt16( SuimRptSagoBsc16VO sagoView16Vo, HttpServletResponse response,PrintWriter out) {
		
		logger.info("sagoRptUdt16");
		
		/*번호 1*/
		int result = sqlSession.update("SagoBscMapper.rptSagoUdt16", sagoView16Vo );
		//SuimRptSagoBscVO resultVo = sqlSession.selectOne("SagoBscMapper.getSagoOne16",sagoView16Vo.getSerialNo() );
		
		out.print(result);			
		out.close();
	}
	
	
	/*
	 * ***************************************
	 * Method ID : sagoRptDel
	 * Method Name :  sagoRptDel
	 * Description : 사고처리 과정표 삭제
	 * 번호 1 : 테이블 수정
	 * Author : 이선형
	 * Date : 20160524
	 * ***************************************
	 * */
	@RequestMapping(value = "sagoRptDel", method = RequestMethod.POST)
	public void sagoRptDel(Model model, HttpSession session, SuimRptSagoBscVO sagoViewVo, PrintWriter out) {
		
		logger.info("sagoRptDel");
	
		/*번호 1*/
		int result = sqlSession.update("SagoBscMapper.rptSagoDel", sagoViewVo.getSagoNo() );

		out.print(result);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : sagoRptDel16
	 * Method Name :  sagoRptDel16
	 * Description : 사고처리 과정표 : 인보험 16 삭제
	 * 번호 1 : 테이블 수정
	 * Author : 이선형
	 * Date : 20160722
	 * ***************************************
	 * */
	@RequestMapping(value = "sagoRptDel16", method = RequestMethod.POST)
	public void sagoRptDel16(SuimRptSagoBsc16VO sagoView16Vo, PrintWriter out) {
		
		logger.info("sagoRptDel16");
	
		/*번호 1*/
		int result = sqlSession.update("SagoBscMapper.rptSagoDel16", sagoView16Vo.getSerialNo() );

		out.print(result);
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : sagoPrintPage
	 * Method Name :  sagoPrintPage
	 * Description : 보고서 상세 화면에서 사고처리 과정표 인쇄 버튼 동작
	 * 
	 * 번호 1 :  
	 * Author : 이선형
	 * Date : 20160525
	 * ***************************************
	 * */
	@RequestMapping(value = "sagoPrintPage", method = RequestMethod.GET)
	public String sagoPrintPage(Model model, HttpSession session, String suimRptNo, String type2) {
		
		logger.info("sagoPrintPage");
		
		/*세션 검사*/
		/*TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_1().equals("0") ){
			
			logger.info("topSuimPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}*/
		
		/*보고서 기본 정보*/
		SuimRptCompositeVO rptInfoVo = sqlSession.selectOne("SagoBscMapper.getRptOneForSago", suimRptNo);
		model.addAttribute("rptInfoVo", rptInfoVo);
		
		/*보고서의 팀정보 추출*/
		TopTmBscVO teamVo = sqlSession.selectOne("SagoBscMapper.getRptTeamForSago", rptInfoVo.getTeam_id());
		model.addAttribute("teamVo", teamVo);
		
		/*보고서 담당자(탑) 정보 추출*/
		TopMbrBscVO mbrVo = sqlSession.selectOne("SagoBscMapper.getMbrInfoForSago", rptInfoVo.getUser_no());
		model.addAttribute("mbrVo", mbrVo);
		
		String suim_rpt_no = suimRptNo;
		
		if(type2.equals("16")){
			List<SuimRptSagoBsc16VO> sagoList  = sqlSession.selectList("SagoBscMapper.getSagoList16", suim_rpt_no);
			
			for (int i = 0; i < sagoList.size(); i++) {
				sagoList.get(i).setControlMemo(sagoList.get(i).getControlMemo().replaceAll("<br>", "\r\n").replaceAll("&nbsp;", "\u0020"));
			}
			model.addAttribute("sagoList", sagoList);
		}else{
			List<SuimRptSagoBscVO> sagoList = sqlSession.selectList("SagoBscMapper.getSagoListForPrint", suimRptNo);
			model.addAttribute("sagoList", sagoList);			
			
		}
		 if(!type2.equals("16")){
			 return "top_suim/suim_rpt_bsc_sago_print";
			 
		 }else{
			 return "top_suim/suim_rpt_bsc_sago_print_16";
		 }
	}
	
}
