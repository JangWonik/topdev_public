/*
*********************************************************
* Program ID	: PrimbizSuimListController
* Program Name	: PrimbizSuimListController
* Description	: 농작물 수임대장 리스트
* Author		: 
* Date			: 2016.06.09.
*********************************************************
*/
package kr.co.toplac.topindividual;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletOutputStream;
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

import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.topteam.TopMbrBscVO;

@Controller
public class BoardMemSalController {

	private static final Logger logger = LoggerFactory.getLogger(BoardMemSalController.class);

	@Autowired
	private SqlSession sqlSession;

	/*
	*********************************************************
	* Program ID	: BoardMemSalList
	* Program Name	: BoardMemSalList
	* Description	: 임직원 연봉협상용 직원명부
	* Author		: LDS
	* Date			: 2016.12.20
	*********************************************************
	*/
	@RequestMapping(value = "BoardMemSalList", method = RequestMethod.GET)
	public String BoardMemSalList(HttpSession session, HttpServletResponse response, Model model, String tab) {
		logger.info("BoardMemSalList");
		
		//=================================================================
		//	권한체크
		//=================================================================
		TopMbrBscVO mbrVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();
		//${mbrVo_Session.user_no == 6 || mbrVo_Session.user_no == 966 || mbrVo_Session.user_no == 670 || mbrVo_Session.user_no == 1117 || mbrVo_Session.user_no == 215}
		if(!"6".equals(mbrVo.getUser_no()) && !"966".equals(mbrVo.getUser_no()) && !"670".equals(mbrVo.getUser_no()) && !"215".equals(mbrVo.getUser_no())){
			return "redirect:/";
		}
		
		
		List<BoardMemSalVO> kind1MemList = sqlSession.selectList("BoardSalListMapper.kind1MemList");
		model.addAttribute("kind1MemList",kind1MemList);
		
		List<BoardMemSalVO> AprvMemList = sqlSession.selectList("BoardSalListMapper.AprvMemList");
		
		model.addAttribute("AprvMemList",AprvMemList);
		
		List<BoardMemSalVO> unAprvMemList = sqlSession.selectList("BoardSalListMapper.unAprvMemList");
		model.addAttribute("unAprvMemList",unAprvMemList);
		
		List<BoardMemSalVO> internMemList = sqlSession.selectList("BoardSalListMapper.internMemList");
		model.addAttribute("internMemList",internMemList);
		
		
		model.addAttribute("tab", tab);
		
		return "top_individual/board_sal_list";
		
	}//BoardMemSalList
	
	/*
	*********************************************************
	* Program ID	: udtSalary
	* Program Name	: udtSalary
	* Description	: 직원 연봉 업데이트
	* Author		: LDS
	* Date			: 2016.12.20
	*********************************************************
	*/
	@RequestMapping(value = "udtSalary", method = RequestMethod.POST)
	public void udtSalary(PrintWriter out, BoardMemSalVO salVo) {
		logger.info("udtSalary");
		
		int result = sqlSession.update("BoardSalListMapper.udtSalary",salVo);
		
		out.print(result);
		
	}//BoardMemSalList
	
	
	
	/*
	*********************************************************
	* Program ID	: popBoardSalDetail
	* Program Name	: popBoardSalDetail
	* Description	: 임직원 연봉협상용 직원명부 - 직원상세
	* Author		: LDS
	* Date			: 2016.12.20
	*********************************************************
	*/
	@RequestMapping(value = "popBoardSalDetail", method = RequestMethod.GET)
	public String popBoardSalDetail(HttpSession session, HttpServletResponse response, Model model, String user_no) {
		logger.info("popBoardSalDetail");
		BoardMemSalVO kind1MemDetail = sqlSession.selectOne("BoardSalListMapper.kind1MemDetail",user_no);
		
		/*** 3개년 연봉 셀렉트 ***/
		List<BoardMemSalVO> bef3YearSal = sqlSession.selectList("MemberSalAprvMapper.getBef3YearSal",user_no);
		
		
		model.addAttribute("bef3YearSal",bef3YearSal);
		model.addAttribute("kind1MemDetail",kind1MemDetail);
		return "top_individual/board_sal_dtl_pop";
	}//popBoardSalDetail
	
	/*
	*********************************************************
	* Program ID	: salaryAprv
	* Program Name	: salaryAprv
	* Description	: 연봉책정 승인페이지
	* Author		: LDS
	* Date			: 2016.12.20
	*********************************************************
	*/
	@RequestMapping(value = "salaryAprv", method = RequestMethod.POST)
	public void salaryAprv(HttpSession session, HttpServletResponse response, Model model, BoardMemSalVO salVo, String sal_amt_flag) {
		logger.info("salaryAprv");
		salVo.setReg_user_no(""+session.getAttribute("user_no_Session"));

		if ( !sal_amt_flag.equals("") ){
			sqlSession.update("BoardSalListMapper.udtSalary",salVo);
		}else{
			sqlSession.insert("BoardSalListMapper.insAprvSalary",salVo);
		}
	}//popBoardSalDetail
	
	@RequestMapping(value = "udtFinalBoardAprv", method = RequestMethod.POST)
	public void udtFinalBoardAprv(HttpSession session, String user_no, String flag, HttpServletResponse response) {
		logger.info("udtFinalBoardAprv");
		
		System.out.println(user_no);
		
		int result = 0;
		if( flag.equals("all")){
			System.out.println("3333");
			result = sqlSession.update("BoardSalListMapper.udtFinalBoardAprvAll");
		}else{
			System.out.println("2222");
			result = sqlSession.update("BoardSalListMapper.udtFinalBoardAprv",user_no);
		}
		
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
	}
	
	@RequestMapping(value = "insInternSal", method = RequestMethod.POST)
	public void insInternSal(HttpSession session, BoardMemSalVO salVo, HttpServletResponse response) {
		
//		salVo.setAgree_user_no( (String)session.getAttribute("user_no_Session") );
		salVo.setReg_user_no((String)session.getAttribute("user_no_Session"));
		
		int result = sqlSession.insert("BoardSalListMapper.insInternSalary",salVo);
		
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
	}
	
	
	
}
