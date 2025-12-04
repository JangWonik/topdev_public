package kr.co.toplac.topteam;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletOutputStream;
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

@Controller
public class PopMbrDocListController {
	
private static final Logger logger = LoggerFactory.getLogger(PopMbrDocListController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "mbrDocStateChange", method = RequestMethod.POST)
	public void mbrDocStateChange(int serial_no, String flag, HttpServletResponse response, HttpSession session, PrintWriter out, Model model) {
		logger.info("=========mbrDocStateChange=========");
		int result = 0;
		
		if (flag.equals("delete")){ // 삭제처리
			result = sqlSession.update("PopMbrDocList.uptMbrDocDelete",serial_no);
			if (result == 1){
				result = 2; //삭제 성공
			}else{
				result = 9; //실패
			}
			
//		}else{ // 삭제요청처리 취소
//			result = sqlSession.update("MyDocList.uptDelRequsetCancel",serial_no);
//			if (result == 1){
//				result = 3; //삭제요청 취소 성공
//			}else{
//				result = 9; //실패
//			}
		}
		
		/**Log 생성**/
		HashMap<String,String> map = new HashMap<String, String>();	
		String user_no = (String) session.getAttribute("user_no_Session");
		map.put("userNo", user_no);
		map.put("docNo", ""+serial_no);
		sqlSession.update("PopMbrDocList.insMbrDocLogDelete",map);
		
		out.println(result);
	}
	
	@RequestMapping(value = "mbrDocFileDownload", method = RequestMethod.GET)
	public void docFileDownload(HttpServletResponse response, String fname, String path, String dstate, HttpSession session) throws IOException{
		logger.info("========mbrDocFileDownload========");
		
		String serialNo = fname.substring(0,fname.lastIndexOf("."));
		
		if ( !dstate.equals("8") ){ //삭제요청건 다운로드시 Confirm 안되게 변경
			int result = sqlSession.update("PopMbrDocList.uptMbrDocConfirm",serialNo);
		}
		
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
		map.put("docNo", ""+serialNo);
		sqlSession.update("PopMbrDocList.insMbrDocLogDown",map);

	}
}
