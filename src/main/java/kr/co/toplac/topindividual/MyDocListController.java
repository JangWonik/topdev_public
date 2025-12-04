package kr.co.toplac.topindividual;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletOutputStream;
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

import kr.co.toplac.topmain.MainLeftSuimVO;
import kr.co.toplac.topsuim.TopRptLogFileVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.rpt.MainLeftUtil;


@Controller
public class MyDocListController {
	
private static final Logger logger = LoggerFactory.getLogger(MyDocListController.class);
	
	@Autowired
	private SqlSession sqlSession;
	

	@Autowired
	MainLeftUtil mlu;
	/*
	 * ***************************************
	 * Method ID : myDocList
	 * Method Name :  myDocList
	 * Description : 나의품의서(인사서류) 목록 추출 
	 * Author : 임대성
	 * Date : 20161115
	 * ***************************************
	 * */
	@RequestMapping(value = "myDocList", method = RequestMethod.GET)
	public String myDocList(Model model, HttpSession session, HttpServletRequest request) {
		logger.info("======= myDocList =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || mbrVo.getUser_no() == ""){
			logger.info("topPtnrMbrSearchPg - no permissions user " + request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		
		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());
		
		String user_no = (String) session.getAttribute("user_no_Session");
		
		/*** list 생성 ***/
		List<TopMbrDocVO> myDocList =  sqlSession.selectList("MyDocList.getMyDocList",user_no);
		
		model.addAttribute("myDocList", myDocList);
		model.addAttribute("user_no", user_no);
		
		return "top_individual/my_doc_list";
	}

	@RequestMapping(value = "docFileDownload", method = RequestMethod.GET)
	public void docFileDownload(HttpServletResponse response, HttpSession session, String fname, String path, String docno) throws IOException{
		logger.info("fileDownload");
		
		String fullPath = "/home/hosting_users/toplac/www"+path+fname;
		
		response.setHeader("Content-Disposition","attachment;filename="+fname);

		ServletOutputStream sout = response.getOutputStream();
		FileInputStream fin = new FileInputStream(fullPath);
		
		byte[] buf = new byte[1024];
		int size=0;
		while((size=fin.read(buf,0,1024))!=-1){
			sout.write(buf,0,size);
		}
		sout.flush();
		fin.close();
		sout.close();
		
		/**Log 생성**/
		HashMap<String,String> map = new HashMap<String, String>();	
		String user_no = (String) session.getAttribute("user_no_Session");
		map.put("userNo", user_no);
		map.put("docNo", docno);
		sqlSession.insert("MyDocList.insMbrDocLogDown",map);
	}
	
	@RequestMapping(value = "delRequest", method = RequestMethod.POST)
	public void delRequest(HttpServletResponse response, HttpSession session, PrintWriter out, int serial_no, String flag) throws IOException{
		logger.info("=========delRequest=========");
		
		int result = 0;
		
		/**Log 생성**/
		HashMap<String,String> map = new HashMap<String, String>();	
		String user_no = (String) session.getAttribute("user_no_Session");
		map.put("userNo", user_no);
		map.put("docNo", ""+serial_no);
		
		if (flag.equals("del")){ // 삭제요청처리
			result = sqlSession.update("MyDocList.uptDelRequset",serial_no);
			if (result == 1){
				sqlSession.insert("MyDocList.insMbrDocLogDelReqest",map);//삭제요청 로그 작성
				result = 2; //삭제요청 성공
			}else{
				result = 9; //실패
			}
			
		}else{ // 삭제요청처리 취소
			result = sqlSession.update("MyDocList.uptDelRequsetCancel",serial_no);
			if (result == 1){
				sqlSession.insert("MyDocList.insMbrDocLogDelRecovery",map);//삭제요청 취소 로그 작성
				result = 3; //삭제요청 취소 성공
			}else{
				result = 9; //실패
			}
		}
		out.println(result);
	}
	
}
	
	
