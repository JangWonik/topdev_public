package kr.co.toplac.topptnr;

import java.io.File;
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
public class PtnrStatListController {
	
	private static final Logger logger = LoggerFactory.getLogger(PtnrStatListController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	/*
	 * ***************************************
	 * Method ID : topPtrMng
	 * Method Name :  topPtrMng
	 * Description : 파트너사 목록 관리
	 * 번호 1 : 보험사 + 보험사 입금 은행 목록 추출
	 * Author : 이선형
	 * Date : 20160425
	 * ***************************************
	 * */
	@RequestMapping(value = "topPtrMng", method = RequestMethod.GET)
	public String topPtrMng(Model model, HttpSession session, String fromPage) {
		
		logger.info("======= topPtrMng =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_9().equals("0") ){
			
			logger.info("topPtrMng - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}

		/*번호 1*/
		List<TopPtnrBscVO> ptnrtList = sqlSession.selectList("PtnrListMapper.ptnrlist");
		
		GetImageBase64 getImage  = new  GetImageBase64();
		
		/*이미지 시작*/
		String dbpath = "";
		String fileType = "";
		
		for (int i = 0; i < ptnrtList.size(); i++) {
			
			/*통계여부 On/Off 문자열 바꾸기*/ 
			if(ptnrtList.get(i).getStatistics_yn().equals("0")){
				ptnrtList.get(i).setStatistics_yn("Off");
			}else{
				ptnrtList.get(i).setStatistics_yn("On");
			}
			
			/*통계심사표시여부 On/Off 문자열 바꾸기*/ 
			if(ptnrtList.get(i).getStatistics_written_yn().equals("0")){
				ptnrtList.get(i).setStatistics_written_yn("Off");
			}else{
				ptnrtList.get(i).setStatistics_written_yn("On");
			}

			/*입금은행에서 은행 문자열 없애기 :  화면상에 글자가 많아 복잡해 보임*/
			ptnrtList.get(i).setBank_title(ptnrtList.get(i).getBank_title().replaceAll("은행", ""));
			
			if(!ptnrtList.get(i).getPtnr_img_small().equals("")){
				/*출력 이미지 경로와 파일 타입 추출*/
				dbpath = "/home/hosting_users/toplac/www/ls_data/ig/small/"+ptnrtList.get(i).getPtnr_img_small();
				fileType = dbpath.substring(dbpath.lastIndexOf(".")+1, dbpath.length());
				
				/*보험사 각 VO 에 이미지 스트림 세팅*/
                File fd = new File(dbpath);
                if (fd.exists()) {
                    ptnrtList.get(i).setImgStream_s(getImage.imageBase64Small(dbpath, fileType));
                }
			}
			
		}
		
		model.addAttribute("fromPage",fromPage);
		model.addAttribute("ptnrtList",ptnrtList);
		
		return "top_partner/top_ptnr_mng_list";
	}

}
