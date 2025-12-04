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
import kr.co.toplac.util.file.GetImageBase64;

@Controller
public class PtnrStatUdtController {
	
private static final Logger logger = LoggerFactory.getLogger(PtnrStatUdtController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	/*
	 * ***************************************
	 * Method ID : topPtrUdt
	 * Method Name :  topPtrUdt
	 * Description : 파트너사 정보 수정
	 * 
	 * Author : 이선형
	 * Date : 20160425
	 * ***************************************
	 * */
	@RequestMapping(value = "topPtrUdt", method = RequestMethod.GET)
	public String topPtrUdt(Model model, HttpSession session, String id) {

		logger.info("======= topPtrUdt =======");
		/*세션 검사*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_9().equals("0") ){
			
			logger.info("topPtrUdt - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		TopPtnrBscVO ptnrVo =  sqlSession.selectOne("PtnrMngUdtMapper.getPtnrOne", id);
		
		/*이미지 유팅 객체 얻기*/
		GetImageBase64 imageUtil  = new GetImageBase64();
		
		/*작은 사진 시작*/
		if( (ptnrVo.getPtnr_img_small()  != null ) ){
			if(!ptnrVo.getPtnr_img_small().equals("")){
				
//				String dbpath = "/partnerimages/"+ptnrVo.getPtnr_img_small();
				String dbpath = "/home/hosting_users/toplac/www/ls_data/ig/small/"+ptnrVo.getPtnr_img_small();
				
				String fileType = dbpath.substring(dbpath.lastIndexOf(".")+1, dbpath.length());
				
				if(!ptnrVo.getPtnr_img_small().equals("")){
					ptnrVo.setImgStream_s(imageUtil.imageBase64Small(dbpath, fileType));
				}
			}
		}
		
		/*큰 사진 시작*/
		if( (ptnrVo.getPtnr_img_big()  != null ) ){
			if(!ptnrVo.getPtnr_img_big().equals("")){
				
//				String dbpath = "/partnerimages/"+ptnrVo.getPtnr_img_big();
				String dbpath = "/home/hosting_users/toplac/www/ls_data/ig/large/"+ptnrVo.getPtnr_img_big();
				String fileType = dbpath.substring(dbpath.lastIndexOf(".")+1, dbpath.length());
				
				if(!ptnrVo.getPtnr_img_big().equals("")){
					ptnrVo.setImgStream_b(imageUtil.imageBase64Small(dbpath, fileType));
				}
			}
		}
		//
		
		model.addAttribute("ptnrVo", ptnrVo);
		
		return "top_partner/top_ptnr_mng_udt";
	}
	
	/*
	 * ***************************************
	 * Method ID : ptnrUdt
	 * Method Name :  ptnrUdt
	 * Description : 파트너사 정보 테이블 업데이트
	 * 
	 * Author : 이선형
	 * Date : 20160426
	 * ***************************************
	 * */
	@RequestMapping(value = "ptnrUdt", method = RequestMethod.POST)
	public void ptnrUdt(Model model, HttpSession session, String id, TopPtnrBscVO ptnrViewVo, PrintWriter out) {
		
		if( (ptnrViewVo.getPtnr_sms1() == null)){
			ptnrViewVo.setPtnr_sms1("0");
		}else{
			ptnrViewVo.setPtnr_sms1("1");
		}
		
		if( (ptnrViewVo.getPtnr_sms2() == null)){
			ptnrViewVo.setPtnr_sms2("0");
		}else{
			ptnrViewVo.setPtnr_sms2("1");
		}
		
		if( (ptnrViewVo.getPtnr_sms3() == null)){
			ptnrViewVo.setPtnr_sms3("0");
		}else{
			ptnrViewVo.setPtnr_sms3("1");
		}
		
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
		
		int result = sqlSession.update("PtnrMngUdtMapper.updateOne", ptnrViewVo);
		
		out.print(result);

	}
	
	/*
	 * ***************************************
	 * Method ID : ptnrDel
	 * Method Name :  ptnrDel
	 * Description : 파트너사 정보 테이블 업데이트
	 * 번호 1 :  업데이트 후 표출할 탭을 정하기 위해, 업데이트 성공 시 ptnr_type을 전달 한다.
	 * Author : 이선형
	 * Date : 20160426
	 * ***************************************
	 * */
	@RequestMapping(value = "ptnrDel", method = RequestMethod.POST)
	public void ptnrDel(Model model,String ptnr_id, String ptnr_type,PrintWriter out) {
		
		int result = sqlSession.update("PtnrMngUdtMapper.delOne", ptnr_id);
		
		/*번호 1*/
		if(result >0){
			out.print(ptnr_type);			
		}else{
			out.print(1);
		}

	}
}
