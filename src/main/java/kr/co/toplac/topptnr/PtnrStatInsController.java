package kr.co.toplac.topptnr;

import java.io.PrintWriter;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.topmain.MainLeftSuimVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;

@Controller
public class PtnrStatInsController {
	
private static final Logger logger = LoggerFactory.getLogger(PtnrStatInsController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	/*
	 * ***************************************
	 * Method ID : ptnrAddPage
	 * Method Name :  ptnrAddPage
	 * Description : 파트너사 추가 화면 호출
	 * 번호 1 :  최대 order 값에 50을 더해 권고 ptnr_order 를 화면에 전달
	 * Author : 이선형
	 * Date : 20160426
	 * ***************************************
	 * */
	@RequestMapping(value = "ptnrAddPage", method = RequestMethod.GET)
	public String ptnrAddPage(Model model, HttpSession session, String level, String type, String gOrder, String order) {
		
		logger.info("======= ptnrAddPage =======");
		/*세션 검사*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_9().equals("0") ){
			
			logger.info("ptnrAddPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		model.addAttribute("ptnr_level", Integer.parseInt(level)+1);
		model.addAttribute("ptnr_type", type);
		model.addAttribute("ptnr_group_order", gOrder);
		
		/*번호 1*/
		String latestOrder = sqlSession.selectOne("PtnrMngAddMapper.getLatestOrder", gOrder);
		model.addAttribute("ptnr_order", Integer.parseInt(latestOrder) +50);
		
		return "top_partner/top_ptnr_mng_ins";
	}
	
	
	/*
	 * ***************************************
	 * Method ID : ptnrAdd
	 * Method Name :  ptnrAdd
	 * Description : 파트너사 추가 등록
	 * 
	 * Author : 이선형
	 * Date : 20160426
	 * ***************************************
	 * */
	@RequestMapping(value = "ptnrAdd", method = RequestMethod.POST)
	public void ptnrAdd(Model model, TopPtnrBscVO ptnrViewVo, PrintWriter out) {
		
		/*보험사 값 미전달 시*/
		if( (ptnrViewVo.getPtnr_sms1() == null)){
			ptnrViewVo.setPtnr_sms1("0");
		}else{
			ptnrViewVo.setPtnr_sms1("1");
		}
		
		/*조사자 값 미전달 시*/
		if( (ptnrViewVo.getPtnr_sms2() == null)){
			ptnrViewVo.setPtnr_sms2("0");
		}else{
			ptnrViewVo.setPtnr_sms2("1");
		}
		
		/*피보험자 값 미전달 시*/
		if( (ptnrViewVo.getPtnr_sms3() == null)){
			ptnrViewVo.setPtnr_sms3("0");
		}else{
			ptnrViewVo.setPtnr_sms3("1");
		}
		
		/*계약적부 여부 값 세팅*/
		if(ptnrViewVo.getSuitability_yn() == null){
			ptnrViewVo.setSuitability_yn("0");
		}else{
			ptnrViewVo.setSuitability_yn("1");
		}
		
		/*수수료 1,2 값 빈 값일 경우 값 0 세팅*/
		if(ptnrViewVo.getSuitability_yn().equals("0")){
			ptnrViewVo.setSuitability_fee1("0");
			ptnrViewVo.setSuitability_fee2("0");
		}else{
			if(ptnrViewVo.getSuitability_fee1().equals("")){
				ptnrViewVo.setSuitability_fee1("0");
			}
			if(ptnrViewVo.getSuitability_fee2().equals("")){
				ptnrViewVo.setSuitability_fee2("0");
			}
		}
		
		/*신규 보험사 DB 입력*/
		int result = sqlSession.insert("PtnrMngAddMapper.insPartner", ptnrViewVo);
		
		String sLevel = ptnrViewVo.getPtnr_level();
		String sStatistics_yn = ptnrViewVo.getStatistics_yn();
		String sPtnrId = ptnrViewVo.getPtnr_id();		
		
		//통계 포함되는 보험사의 경우 통계용 정렬순서를 입력해준다.
		if( "1".equals(sLevel) && "1".equals(sStatistics_yn) ) {
			//정렬최대값을 불러온다.
			int nMaxOrder = sqlSession.selectOne("PtnrMngAddMapper.selectPtnrOrderMaxCount");
			
			ptnrViewVo.setStatistics_order(nMaxOrder);
			sqlSession.update("PtnrMngAddMapper.updatePartnerOrder", ptnrViewVo);
			
		}
		
		out.print(result);

	}
	
	/*코드 입력 화면 만들 시 중복 체크*/
	@RequestMapping(value = "ptnrIdCheck", method = RequestMethod.POST)
	public void ptnrIdCheck(Model model, HttpSession session, String ptnr_id, PrintWriter out) {
		
		String checkId = sqlSession.selectOne("PtnrMngAddMapper.checkId",ptnr_id);
		
		out.print(checkId);
	}
	
}
