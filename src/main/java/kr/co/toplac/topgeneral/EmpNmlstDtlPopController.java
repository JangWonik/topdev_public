package kr.co.toplac.topgeneral;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.util.file.GetImageBase64;

@Controller
public class EmpNmlstDtlPopController {
	
private static final Logger logger = LoggerFactory.getLogger(EmpNmlstDtlPopController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/PopEmpNmlstDtl", method = RequestMethod.GET)
	public String empNmlstDtl(Model model, String user_no) {
		logger.info("PopEmpNmlstDtlController ???- PopEmpNmlstEmpDtl");
		
		//직원 상세보기 시작
		List<EmpNmlstDtlPopVO> member_Dtl = sqlSession.selectList("PopEmpNmlstDtlMapper.getMember_Dtl", user_no);
		
		model.addAttribute("member_Dtl", member_Dtl);
		//직원 상세보기 종료//

		//직원 사진 시작
		EmpNmlstDtlPopVO memberVo = member_Dtl.get(0);
		if(memberVo.getPicture() != null && !memberVo.getPicture().equals("")){
			String dbpath = "/home/hosting_users/toplac/www/ls_data/member/"+memberVo.getPicture();

            File fd = new File(dbpath);
            if (fd.exists()){
                String fileType = dbpath.substring(dbpath.lastIndexOf(".")+1, dbpath.length());

                if ("jpg".equalsIgnoreCase(fileType) || "jpeg".equalsIgnoreCase( fileType)
                        || "gif".equalsIgnoreCase( fileType) || "png".equalsIgnoreCase( fileType)){
                    GetImageBase64 getImageObject = new GetImageBase64();
                    String imageBase64 = getImageObject.imageBase64Small(dbpath, fileType);
                    model.addAttribute("imageBase64", imageBase64);
                }
            }
		}
		//직원 사진 종료
		
		/* 겸직 목록 추출*/
		List<Map<String, Object>> subJobList = sqlSession.selectList("PopEmpNmlstDtlMapper.getMember_Dtl_sub",user_no);
		model.addAttribute("subJobList", subJobList);

		return "top_general/emp_nmlst_dtl_pop";
	}
}
