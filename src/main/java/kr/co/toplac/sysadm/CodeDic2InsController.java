package kr.co.toplac.sysadm;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.memo.MemoUtilViewVO;
import kr.co.toplac.util.memo.TopRptMemoVO;

@Controller
public class CodeDic2InsController {

	@Autowired
	private SqlSession sqlSession;

	private static final Logger logger = LoggerFactory.getLogger(CodeDic2InsController.class);

	@RequestMapping(value = "/sysAdmCode", method = RequestMethod.GET)
	public String sysAdmCode(Model model, HttpSession session, CodeDic2InsViewVO inVO) {

		logger.info("===== sysAdmCode =====");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("sysAdmCode - no permession user_no : "+mbrVo.getUser_no());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		List<String> allTableList = sqlSession.selectList("CodeDic2Mapper.allTableList");
		model.addAttribute("allTableList", allTableList);

		if(inVO.getSelectUserTable() != null && !inVO.getSelectUserTable().equals("")){
			List<String> allColumnList = sqlSession.selectList("CodeDic2Mapper.allColumnList", inVO);
			model.addAttribute("allColumnList", allColumnList);

			List<SysAdmCodeDic2VO> codeDicList = null;
			if(inVO.getSelectCodeTable() != null && !inVO.getSelectCodeTable().equals("") && inVO.getSelectCodeTable().equals("sysadm_codedic")){
				codeDicList = sqlSession.selectList("CodeDic2Mapper.codeDicList1", inVO);
			}else if(inVO.getSelectCodeTable() != null && !inVO.getSelectCodeTable().equals("") && inVO.getSelectCodeTable().equals("sysadm_codedic2")){
				codeDicList = sqlSession.selectList("CodeDic2Mapper.codeDicList2", inVO);
			}
			model.addAttribute("codeDicList", codeDicList);
		}

		model.addAttribute("selectCodeTable", inVO.getSelectCodeTable());
		model.addAttribute("selectUserTable", inVO.getSelectUserTable());
		model.addAttribute("selectColumn", inVO.getSelectColumn());

		return "sys_adm/code_dic2_ins";
	}//sysAdmCode

	@RequestMapping(value = "codeWrite", method = RequestMethod.POST)
	public void codeWrite(HttpServletResponse response, CodeDic2InsViewVO inVO) {

		logger.info("===== codeWrite =====");

		int result = 0;
		if(inVO.getSelectCodeTable() != null && !inVO.getSelectCodeTable().equals("") && inVO.getSelectCodeTable().equals("sysadm_codedic")){
			result = sqlSession.insert("CodeDic2Mapper.codeWrite1", inVO);
		}else if(inVO.getSelectCodeTable() != null && !inVO.getSelectCodeTable().equals("") && inVO.getSelectCodeTable().equals("sysadm_codedic2")){
			result = sqlSession.insert("CodeDic2Mapper.codeWrite2", inVO);
		}

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

	}//codeWrite

	@RequestMapping(value = "codeDelete", method = RequestMethod.POST)
	public void codeDelete(HttpServletResponse response, CodeDic2InsViewVO inVO) {

		logger.info("===== codeDelete =====");

		int result = 0;
		if(inVO.getSelectCodeTable() != null && !inVO.getSelectCodeTable().equals("") && inVO.getSelectCodeTable().equals("sysadm_codedic")){
			result = sqlSession.delete("CodeDic2Mapper.codeDelete1", inVO);
		}else if(inVO.getSelectCodeTable() != null && !inVO.getSelectCodeTable().equals("") && inVO.getSelectCodeTable().equals("sysadm_codedic2")){
			result = sqlSession.delete("CodeDic2Mapper.codeDelete2", inVO);
		}

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

	}//codeDelete

}//end of class
