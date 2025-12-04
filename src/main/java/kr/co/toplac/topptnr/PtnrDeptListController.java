package kr.co.toplac.topptnr;

import java.util.List;

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
public class PtnrDeptListController {
	
	private static final Logger logger = LoggerFactory.getLogger(PtnrDeptListController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	/*
	 * ***************************************
	 * Method ID : ptnrDeptPage
	 * Method Name :  ptnrDeptPage
	 * Description : 파트너사 부서 목록 관리
	 * 번호 1 : 파트너사 부서 목록 추출
	 * Author : 이선형
	 * Date : 20160427
	 * ***************************************
	 * */
	@RequestMapping(value = "ptnrDeptPage", method = RequestMethod.GET)
	public String ptnrDeptPage(Model model, HttpSession session, String type, String ptnr_id) {
		
		logger.info("======= ptnrDeptPage =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_9().equals("0") ){
			
			logger.info("ptnrDeptPage - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		GetImageBase64 imageUtil = new GetImageBase64();
		
		/*번호 1*/
		List<TopPtnrDeptBscVO> ptnrtDeptList = sqlSession.selectList("PtnrDeptListMapper.ptnrDeptList",ptnr_id);
		TopPtnrBscVO ptnrVo = sqlSession.selectOne("PtnrDeptListMapper.ptnrInfo", ptnr_id);
		
		/*이미지 시작*/
		String dbpath = "";
		String fileType = "";
		
		if(!ptnrVo.getPtnr_img_big().equals("")){
			/*출력 이미지 경로와 파일 타입 추출*/
			dbpath = "/home/hosting_users/toplac/www/ls_data/ig/large/"+ptnrVo.getPtnr_img_big();
			fileType = dbpath.substring(dbpath.lastIndexOf(".")+1, dbpath.length());
			
			/*보험사 각 VO 에 이미지 스트림 세팅*/ 
			ptnrVo.setImgStream_b(imageUtil.imageBase64Small(dbpath, fileType));
		}
	
		model.addAttribute("ptnrtDeptList",ptnrtDeptList);
		model.addAttribute("ptnrVo",ptnrVo);
		
		return "top_partner/top_ptnr_dept_list";
	}

}
