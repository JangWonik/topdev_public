package kr.co.toplac.topgeneral;

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

import kr.co.toplac.topmain.MainLeftSuimVO;
import kr.co.toplac.topptnr.TopPtnrBscVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.etc.Damo;
import kr.co.toplac.util.file.GetImageBase64;
import kr.co.toplac.util.rpt.MainLeftUtil;

/*
*********************************************************
* Program ID	: TopPtnrDtl
* Program Name	: TopPtnrDtl
* Description	: 해당보험사 상세리스트 출력
* Author		: 이동익
* Date			: 2016.04.26.
*********************************************************
*/
@Controller
public class TopPtnrDtlController {
	
private static final Logger logger = LoggerFactory.getLogger(TopPtnrDtlController.class);
	
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	MainLeftUtil mlu;

	/*
	*********************************************************
	* Program ID	: `
	* Program Name	: TopPtnrDtl
	* Description	: 해당보험사 상세리스트 출력
	* Author		: 이동익
	* Date			: 2016.04.26.
	*********************************************************
	*/
	@RequestMapping(value = "topPtnrDTL", method = RequestMethod.GET)
	public String topPtnrDTL(Model model, HttpSession session, HttpServletResponse response
			, TopPtnrBscVO ptnrlistVO, TopPtnrMbrBscVO ptnrmbrlistVO, String ptnr_id) {

		logger.info("======= topPtnrDTL =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		//해당 보험사 상세보기 추출 시작
		TopPtnrBscVO ptnrDtl= sqlSession.selectOne("TopPtnrDtlMapper.getPtnrDtl", ptnrlistVO);
		//해당 보험사 상세보기 추출 종료
		//해당 보험사 사진 시작
		GetImageBase64 getImageObject  = new  GetImageBase64();
		if(ptnrDtl.getPtnr_img_big() != null && !ptnrDtl.getPtnr_img_big().equals("")){
			String dbpath = "/home/hosting_users/toplac/www/ls_data/ig/large/"+ptnrDtl.getPtnr_img_big();
			String fileType = dbpath.substring(dbpath.lastIndexOf(".")+1, dbpath.length());
			if ("jpg".equalsIgnoreCase(fileType) || "jpeg".equalsIgnoreCase( fileType) 
					|| "gif".equalsIgnoreCase( fileType) || "png".equalsIgnoreCase( fileType)){
				String imageBase64 = getImageObject.imageBase64Small(dbpath, fileType);
				ptnrDtl.setPtnr_img_big(imageBase64);
			}
		}//if
		//해당 보험사 사진 종료

		List<TopPtnrMbrBscVO> ptnrMbrList= sqlSession.selectList("TopPtnrDtlMapper.getptnrMbrList", ptnrmbrlistVO);
		Damo damo = new Damo();
		for(int i=0; i < ptnrMbrList.size() ; i++){
			if (ptnrMbrList.get(i).getPtnr_mbr_hp() != null || ptnrMbrList.get(i).getPtnr_mbr_hp() != ""){
				ptnrMbrList.get(i).setPtnr_mbr_hp( damo.decodeDamo(ptnrMbrList.get(i).getPtnr_mbr_hp()) );
			}	
			if (ptnrMbrList.get(i).getPtnr_mbr_office_tel() != null || ptnrMbrList.get(i).getPtnr_mbr_office_tel() != ""){
				ptnrMbrList.get(i).setPtnr_mbr_office_tel( damo.decodeDamo(ptnrMbrList.get(i).getPtnr_mbr_office_tel()) );
			}	
			if (ptnrMbrList.get(i).getPtnr_mbr_office_fax() != null || ptnrMbrList.get(i).getPtnr_mbr_office_fax() != ""){
				ptnrMbrList.get(i).setPtnr_mbr_office_fax( damo.decodeDamo(ptnrMbrList.get(i).getPtnr_mbr_office_fax()) );
			}	
			if (ptnrMbrList.get(i).getPtnr_mbr_office_email() != null || ptnrMbrList.get(i).getPtnr_mbr_office_email() != ""){
				ptnrMbrList.get(i).setPtnr_mbr_office_email( damo.decodeDamo(ptnrMbrList.get(i).getPtnr_mbr_office_email()) );
			}	
		}
		
		
		model.addAttribute("ptnr_id", ptnr_id);
		model.addAttribute("ptnrDtl", ptnrDtl);
		model.addAttribute("ptnrMbrList", ptnrMbrList);
		
		return "top_general/top_ptnr_dtl";
	}

}
