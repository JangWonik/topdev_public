package kr.co.toplac.brd.common;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.topteam.TopMbrAuthVO;

@Controller
public class BoardMemoController {

	@Autowired
	private SqlSession sqlSession;

	private static final Logger logger = LoggerFactory.getLogger(BoardMemoController.class);

	@RequestMapping(value = "boardMemoList", method = RequestMethod.POST)
	public void boardMemoList(HttpServletResponse response, BoardMemoViewVO inVO) {

		logger.info("boardMemoList");

		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		List<BoardMemoVO> memoList = sqlSession.selectList("BoardMemoMapper.boardMemoList", inVO);
		JSONArray arr = new JSONArray();
		for(int i=0; i < memoList.size(); i++){
			BoardMemoVO oneMemo = memoList.get(i);
			JSONObject obj = new JSONObject();
			obj.put("targetStr", inVO.getTargetStr());
			obj.put("memoNo", oneMemo.getMemo_no());
			obj.put("linkNo", oneMemo.getFk_no());
			obj.put("userNo", oneMemo.getUser_no());
			obj.put("userNm", oneMemo.getUser_nm());
			obj.put("mContents", oneMemo.getMemo());
			obj.put("regIp", oneMemo.getReg_ip());
			obj.put("regDate", oneMemo.getReg_date());
			arr.add(obj);
		}
		String jsonStr = arr.toString();
		out.print(jsonStr);
		out.close();

	}//boardMemoList

	@RequestMapping(value = "boardMemoWrite", method = RequestMethod.POST)
	public void boardMemoWrite(HttpServletRequest request, HttpServletResponse response, HttpSession session, BoardMemoViewVO inVO) {
		
		logger.info("boardMemoWrite");

		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		inVO.setUserNo(mbrAuthVo.getUser_no());
		inVO.setRegIp(request.getRemoteAddr());
		inVO.setmContents(inVO.getmContents().replace("\n", "<br>"));

		int result = 0;
		result = sqlSession.insert("BoardMemoMapper.boardMemoWrite", inVO);

		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		if(result > 0){
			BoardMemoVO oneMemo = sqlSession.selectOne("BoardMemoMapper.oneBoardMemo", inVO);
			JSONArray arr = new JSONArray();
			JSONObject obj = new JSONObject();
			obj.put("targetStr", inVO.getTargetStr());
			obj.put("memoNo", oneMemo.getMemo_no());
			obj.put("linkNo", oneMemo.getFk_no());
			obj.put("userNo", oneMemo.getUser_no());
			obj.put("userNm", oneMemo.getUser_nm());
			obj.put("mContents", oneMemo.getMemo());
			obj.put("regIp", oneMemo.getReg_ip());
			obj.put("regDate", oneMemo.getReg_date());
			arr.add(obj);
			String jsonStr = arr.toString();
			out.print(jsonStr);
		}
		out.close();

	}//boardMemoWrite

	@RequestMapping(value = "boardMemoDelete", method = RequestMethod.POST)
	public void boardMemoDelete(HttpServletResponse response, BoardMemoViewVO inVO) {
		
		logger.info("boardMemoDelete");

		int result = 0;
		result = sqlSession.delete("BoardMemoMapper.boardMemoDelete", inVO);

		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		if(result > 0){
			out.print(result);
		}
		out.close();

	}//boardMemoDelete

	@RequestMapping(value = "boardMemoUpdate", method = RequestMethod.POST)
	public void boardMemoUpdate(HttpServletResponse response, BoardMemoViewVO inVO) {
		
		logger.info("boardMemoUpdate");

		inVO.setmContents(inVO.getmContents().replace("\n", "<br>"));

		int result = 0;
		result = sqlSession.update("BoardMemoMapper.boardMemoUpdate", inVO);

		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		if(result > 0){
			out.print(result);
		}
		out.close();

	}//boardMemoUpdate

}//end of class
