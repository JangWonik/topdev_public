package kr.co.toplac.topteam;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletOutputStream;
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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import kr.co.toplac.sysadm.SysAdmCodeDicVO;
import kr.co.toplac.topindividual.MyDocInsController;
import kr.co.toplac.topindividual.TopMbrDocVO;
import kr.co.toplac.util.file.FileUpload;

@Controller
public class PopMbrDocInsController {
	
private static final Logger logger = LoggerFactory.getLogger(MyDocInsController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	/*
	 * ***************************************
	 * Method ID : myDocInsForm
	 * Method Name :  myDocInsForm
	 * Description : 나의품의서(인사서류) 서류 추가 페이지
	 * Author : 임대성
	 * Date : 20161115
	 * ***************************************
	 * */
	@RequestMapping(value = "mbrDocInsForm", method = RequestMethod.GET)
	public String mbrDocInsForm(Model model, HttpSession session, HttpServletRequest request, String user_no, String reg_user_no) {
		logger.info("======= mbrDocInsForm =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || mbrVo.getUser_no() == ""){
			logger.info("topPtnrMbrSearchPg - no permissions user " + request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		
		/****** docType 세팅 ******/
		List<SysAdmCodeDicVO> docClass = sqlSession.selectList("MyDocIns.getMyDocType");
		model.addAttribute("docClass", docClass);
		model.addAttribute("user_no", user_no);
		model.addAttribute("reg_user_no", reg_user_no);
		
		return "top_team/pop_mbr_doc_ins";
	}
	
	
	@RequestMapping(value = "mbrDocInsert")
	public void mbrDocInsert(Model model, PrintWriter out, MultipartRequest request, TopMbrDocVO docVo, int reg_user_no) {
		logger.info("======= mbrDocInsert =======");
		int user_no = docVo.getUser_no();
		
		/** 파일 업로드 **/
		MultipartFile file = request.getFile("file");
		String origFileName = file.getOriginalFilename(); //원본 파일명
		String fileType = origFileName.substring(origFileName.lastIndexOf(".")); //파일 확장자
		int nextMyDocSerial = sqlSession.selectOne("PopMbrDocIns.nextMyDocSerial"); //파일명을 serial_no로 변경하기 위해 받아옴
		String replaceName =  nextMyDocSerial+ fileType;  //파일 이름의 중복을 막기 위해서 이름을 재설정합니다.
		
		String uppath = "/home/hosting_users/toplac/www/ls_data/unit_doc/"+user_no+"/";
		localUploadFunc(file,uppath,replaceName);
		/** 파일 업로드 끝 **/
		
		uppath = "/ls_data/unit_doc/"+user_no+"/";
		docVo.setFile_path(uppath);
		docVo.setFile_name(replaceName);
		docVo.setReg_user_no(reg_user_no);
		
		int result = sqlSession.insert("PopMbrDocIns.insMbrDoc",docVo);
		out.println(result);
		
		
		/**Log 생성**/
		HashMap<String,String> map = new HashMap<String, String>();	
		map.put("userNo", ""+reg_user_no);
		map.put("docNo", ""+nextMyDocSerial);
		sqlSession.update("PopMbrDocIns.insMbrDocLogInsert",map);
		
	}
	
	//실제 파일 업로드 함수
	public void localUploadFunc(MultipartFile file, String uppath, String replaceName){
		File dir = new File(uppath);		

		if(!dir.exists()){
			dir.mkdirs();
		}

		try {
			FileUpload.fileUpload(file, uppath, replaceName);					
		} catch (IOException e) {
			e.printStackTrace();
		}
	}//localUploadFunc
}
