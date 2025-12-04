
	/*
	 * ***************************************
	 * Program ID : SysAdmController.java
	 * Program Name : 시스템 코드 
	 * Author : 이선형
	 * Date : 20160404
	 * ***************************************
	 * */

package kr.co.toplac.sysadm;

import java.io.IOException;
import java.io.PrintWriter;
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
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.RequestUtil;

@Controller
public class CodeDicInsController {
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final Logger logger = LoggerFactory.getLogger(CodeDicInsController.class);
	
	
	/**
	 * 재경팀 세금계산서 자동등록 프로그램
	 * @param model
	 * @param session
	 * @param popupVO
	 * @return
	 */
	@RequestMapping(value = "taxCalInvoice", method = RequestMethod.GET)
	public String taxCalInvoice( Model model, HttpSession session, HttpServletRequest request ) {
		
		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("topSysAdmCode - no permession user_no : "+mbrVo.getUser_no());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 끝*/
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		List <Map<String, Object>> taxCalList = sqlSession.selectList("CodeDicInsMapper.selectTopRptInvoiceTaxList", paramMap);
		
		model.addAttribute("taxCalList", taxCalList);
		
		return "sys_adm/tax_cal_invoice_list";
	}
	
	@RequestMapping(value = "taxCalInvoiceProcess", method = RequestMethod.POST)
	public String taxCalInvoiceProcess( Model model, HttpSession session, HttpServletRequest request) {
		
		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("topSysAdmCode - no permession user_no : "+mbrVo.getUser_no());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 끝*/
		
		//추가 수정 삭제 확인
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sSuim_rpt_no = "";
		String sSuim_accept_no = "";
		String sPublish_amount = "";
		
		List <Map<String, Object>> taxCalList = sqlSession.selectList("CodeDicInsMapper.selectTopRptInvoiceTaxList", paramMap);
		
		try {
			
			System.out.println("================== Start =====================");
			
			for( int i=0; i < taxCalList.size(); i++ ) {
				
				sSuim_accept_no = taxCalList.get(i).get("suim_accept_no").toString();
				sPublish_amount = taxCalList.get(i).get("publish_amount").toString();
				
				sSuim_rpt_no = sqlSession.selectOne("CodeDicInsMapper.selSuimNoAcc",sSuim_accept_no);			
								
				taxCalList.get(i).put("suim_rpt_no", sSuim_rpt_no);
				
				//기존에 등록된 세금계산서 정보가 있으면 삭제한
				sqlSession.delete("CodeDicInsMapper.delInvoiceTaxTmp", sSuim_rpt_no);				
				
				//CommonUtils.printMap(taxCalList.get(i));
				//세금계산서 테이블에 Insert
				sqlSession.insert("CodeDicInsMapper.insertInvoiceTaxTmp", taxCalList.get(i));				
				
				//입금금액이 없는경우를 제외하고는 작업완료로 갱신한다.
				if( "0".equals(sPublish_amount) ) {
					sqlSession.update("CodeDicInsMapper.updateInvoiceJobCon", sSuim_rpt_no);
				}else{
					sqlSession.update("CodeDicInsMapper.updateInvoiceJobEnd", sSuim_rpt_no);
				}
				
				//작업완료 표시를 한다.
				sqlSession.update("CodeDicInsMapper.updateInvoiceTmpEnd", sSuim_accept_no);
				
				System.out.println(sSuim_accept_no +" : "+sSuim_rpt_no);
				
			}
			
			System.out.println("================== End =====================");
			
		} catch (Exception e) {
			System.out.println("Error : "+e+" : "+sSuim_accept_no);
		}
		
		return "sys_adm/tax_cal_invoice_result";
	}
	
	
	/**
	 * div 팝업관리 관리자 기능 추가
	 * @param model
	 * @param tname
	 * @param cname
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "divPopupManager", method = RequestMethod.GET)
	public String divPopupManager( Model model, HttpSession session, TopDivPopupVO popupVO ) {
		
		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("topSysAdmCode - no permession user_no : "+mbrVo.getUser_no());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 끝*/
		
		/* 팝업목록 List 가져오기*/
		//팝업목록 가져오기
		List<TopDivPopupVO> divPopupList = sqlSession.selectList("CodeDicInsMapper.selectDivPopupList", popupVO);
		
		//System.out.println("divPopupList="+divPopupList.size());
		
		//팝업목록 셋팅
		model.addAttribute("divPopupList",divPopupList);
		
		return "sys_adm/div_popup_list";
	}
	
	/**
	 * div 팝업 등록
	 * @param model
	 * @param tname
	 * @param cname
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "divPopupAction", method = RequestMethod.POST)
	public String divPopupAction( Model model, HttpSession session, HttpServletRequest request, TopDivPopupVO popupVO ) {
		
		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("topSysAdmCode - no permession user_no : "+mbrVo.getUser_no());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 끝*/
		
		//추가 수정 삭제 확인
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
		String sActionType = String.valueOf(paramMap.get("actionType"));
		String sPopup_no = String.valueOf(paramMap.get("popup_no"));
		
		//System.out.println("sActionType="+sActionType+ " : sPopup_no ="+ sPopup_no);
				
		//사용자 아이피 체크
		HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null) {
			ip = req.getRemoteAddr();
		}		
		popupVO.setReg_ip(ip);
				
		//테스트
		//System.out.println("popupVO="+popupVO.getRepeat_flag()+" : "+popupVO.getWeek_flag()+" : "+popupVO.getPopup_height()+" : "+popupVO.getPopup_width());
		
		String sUrl = "sys_adm/div_popup_list";			//값이 없으면 리스트 페이지로 간다.
		
		if( "addForm".equals(sActionType) ) {			//입력 폼으로 이동
			sUrl = "sys_adm/div_popup_addform";
			model.addAttribute("actionType", "addForm");
			
		}else if("add".equals(sActionType)) {			//팝업등록
			//팝업 등록 시작
			sqlSession.insert("CodeDicInsMapper.insertDivPopup", popupVO);
			
		}else if("modForm".equals(sActionType)) {		//팝업 수정폼으로 이동
			sUrl = "sys_adm/div_popup_modform";			
			TopDivPopupVO popupData = sqlSession.selectOne("CodeDicInsMapper.selectDivPopup", popupVO);
			
			model.addAttribute("popupData",popupData);
			model.addAttribute("actionType", "modForm");
		}else if("mod".equals(sActionType)) {		//팝업 수정
			//팝업 수정 시작						
			sqlSession.update("CodeDicInsMapper.updateDivPopup", popupVO);
		}else if("del".equals(sActionType)) {
			sqlSession.delete("CodeDicInsMapper.deleteDivPopup", popupVO);
		}
		
		//System.out.println("sUrl="+sUrl);
		
		/* 팝업목록 List 가져오기*/
		//팝업목록 가져오기
		List<TopDivPopupVO> divPopupList = sqlSession.selectList("CodeDicInsMapper.selectDivPopupList", popupVO);
		
		//System.out.println("divPopupList="+divPopupList.size());		
		//팝업목록 셋팅
		model.addAttribute("divPopupList",divPopupList);
		
		return sUrl;
	}
	
	/*
	 * ***************************************
	 * Method ID : topSysAdmCode
	 * Method Name : 시스템 코드 관리 초기 화면 호출 
	 * Description : 
	 * 번호 1 - 테이블명 전달 받을 시 컬럼이름에 따른 코드 목록 추출
	 * 번호 2 - 테이블명, 컬럼명 둘 다 전달 받을 시 컬럼명에 해당하는 코드 목록만 추출
	 * 번호 3 - 화면 초기 표시 시 테이블명 목록만(중복제거) 셀렉트 박스에 표출 
	 * Author : 이선형
	 * Date : 20160404
	 * ***************************************
	 * */
	@RequestMapping(value = "topSysAdmCode", method = RequestMethod.GET)
	public String topSysAdmCode( Model model, String tname, String cname, HttpSession session) {
		
		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("topSysAdmCode - no permession user_no : "+mbrVo.getUser_no());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 시작*/
		
		/*번호 1*/
		if(tname != null){
			if(!tname.equals("")){
				
				/*코드테이블명 별 목록*/
				List<SysAdmCodeDicVO> tblOneList = sqlSession.selectList("CodeDicInsMapper.tblOneList",tname);
				model.addAttribute("tblOneList",tblOneList);
				model.addAttribute("tblNameTitle",tname);
				
				/*코드컬럼명 목록*/
				List<SysAdmCodeDicVO> colnmList = sqlSession.selectList("CodeDicInsMapper.colnmlist",tname);
				model.addAttribute("colnmList",colnmList);
			}			
		}
		
		/*번호 2*/
		if((cname != null) && (tname != null)){
			if((!cname.equals("")) && (!tname.equals(""))){
				
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("cname", cname);
				map.put("tname", tname);
				
				List<SysAdmCodeDicVO> codeList = sqlSession.selectList("CodeDicInsMapper.codeList",map);
				
				model.addAttribute("tblOneList",codeList);
				model.addAttribute("tblNameTitle",tname);
				model.addAttribute("colNameTitle",cname);
			}
		}
		
		/*번호 3*/
		List<SysAdmCodeDicVO> tblnmList = sqlSession.selectList("CodeDicInsMapper.tblnmlist");
		
		model.addAttribute("tblnmList",tblnmList);
		model.addAttribute("page","topSysAdmCode");
		return "sys_adm/code_dic_ins";
	}
	
	/*
	 * ***************************************
	 * Method ID : addSysAdmCode
	 * Method Name : 시스템 코드 관리 - 코드 추가 
	 * Description : 
	 * 번호 1 - 컬럼 값이 한글을 포함하므로 인코딩
	 * 번호 2 - 화면에 동적 태그 추가를 위한 문자열 전달. 구분자 '-' 로 각 값을 구분함
	 * 번호 3 - 
	 * 
	 * 	         결과 0 : 화면에서 전달받은 컬럼코드가 빈 값일 경우
	 * 	         결과 newCode : 새 코드 입력 성공 시 입력정보 전달
	 *        결과 2 : 중복검사에서 검출된 경우
	 *          
	 * Author : 이선형
	 * Date : 20160404
	 * ***************************************
	 * */
	@RequestMapping(value = "addSysAdmCode", method = RequestMethod.POST)
	public void addSysAdmCode( Model model, SysAdmCodeDicVO CodeVo, HttpServletResponse response) {
		
		/*번호 1*/
		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	    
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		/*번호 2*/
		String newCode = CodeVo.getTbl_nm()+"-"+CodeVo.getCol_nm()+"-"+CodeVo.getCol_cd()+"-"+CodeVo.getCol_val();
		
		/*번호 3*/
		if(!CodeVo.getCol_cd().equals("")){
			
			int checkExist = sqlSession.selectOne("CodeDicInsMapper.checkExist", CodeVo);
			
			int	result =0;
			
			if(checkExist <1){
				result = sqlSession.insert("CodeDicInsMapper.addAysAdmCode", CodeVo);
				
				if(result == 1){
					out.print(newCode);			
				}
			}else{
				out.print(2);
			}
		}else{
			out.print(0);
		}
		out.close();
	}
	
	/*
	 * ***************************************
	 * Method ID : delSysAdmCode
	 * Method Name : 시스템 코드 관리 - 코드 삭제 상태값 변경 
	 * Description : 삭제 버튼 동작으로 코드의 del_state 값을 1로 변경한다.        
	 * Author : 이선형
	 * Date : 20160404
	 * ***************************************
	 * */
	@RequestMapping(value = "delSysAdmCode", method = RequestMethod.GET)
	public String delSysAdmCode( Model model, String tname, String cname, String ccode) {
		
		HashMap<String, String> map = new HashMap<String, String>();
		
		map.put("tbl_nm", tname);
		map.put("col_nm", cname);
		map.put("col_cd", ccode);
		
		int result = sqlSession.update("CodeDicInsMapper.deleteSysAdm", map);
		
		model.addAttribute("tname",tname);
		model.addAttribute("cname",cname);
		model.addAttribute("result",result);
		
		return "sys_adm/code_dic_ins_ok";
	}
}
