package kr.co.toplac.topteam;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class PopMbrEvalController {
	
	private static final Logger logger = LoggerFactory.getLogger(PopMbrEvalController.class);
	
	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value = "insertMemberEvaluation", method = RequestMethod.POST)
	public void insertMemberEvaluation(TopMbrEvalVO insertVO, HttpServletResponse response) {
		logger.info("insertMemberEvaluation");

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		int successCnt = 0;
		if(insertVO.getCnt()==null||insertVO.getCnt().equals("")||insertVO.getCnt().equals("0")){
			successCnt = sqlSession.insert("PopMbrEvalMapper.insertMemberEvaluation", insertVO);
		}else{
			successCnt = sqlSession.insert("PopMbrEvalMapper.updateMemberEvaluation", insertVO);
		}

		out.print(successCnt);
		out.close();

	}//topMemberSearch

}
