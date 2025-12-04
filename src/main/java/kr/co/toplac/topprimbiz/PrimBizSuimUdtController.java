package kr.co.toplac.topprimbiz;

import java.io.File;
import java.io.PrintWriter;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class PrimBizSuimUdtController {

private static final Logger logger = LoggerFactory.getLogger(PrimBizSuimUdtController.class);
	
	@Autowired
	private SqlSession sqlSession;

	/*
	 * ***************************************
	 * Method ID : rptOrgFileDel
	 * Method Name :  rptOrgFileDel
	 * Description : 보고서 원본 파일 삭제
	 * 번호 1 : 
	 * Author : 이선형
	 * Date : 20160621
	 * ***************************************
	 * */
	@RequestMapping(value = "primBizRptOrgFileDel", method = RequestMethod.POST)
	public void primBizRptOrgFileDel(String serialNo, PrintWriter out) {
		
		logger.info("primBizRptOrgFileDel");
		
		String path = "/home/hosting_users/toplac/www"+sqlSession.selectOne("PrimBizSuimUdtMapper.getPrimBizRptOrgFilePathForDel", serialNo);
		
		String fileforder = path.substring(0, path.lastIndexOf("/"));
		
		int result = 0;
		
		//파일 삭제 시작
		if(!fileforder.equals("")){
			
			File file = new File(path);
			File dir = new File(fileforder);
			file.delete();
			dir.delete();
			
			result = 1;
		}
		//파일 삭제 종료
		
		sqlSession.selectOne("PrimBizSuimUdtMapper.delPrimBizRptOrgFile", serialNo);
		
		out.print(result);
	}

}
