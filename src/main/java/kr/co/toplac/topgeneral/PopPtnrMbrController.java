package kr.co.toplac.topgeneral;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

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

import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.topptnr.TopPtnrBscVO;
import kr.co.toplac.topptnr.TopPtnrDeptBscVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.etc.Damo;

/*
*********************************************************
* Program ID	: PopPtnrMbr
* Program Name	: PopPtnrMbr
* Description	: 해당보험사 멤버 추가, 수정, 삭제
* Author		: 이동익
* Date			: 2016.04.28.
*********************************************************
*/
@Controller
public class PopPtnrMbrController {
	
private static final Logger logger = LoggerFactory.getLogger(PopPtnrMbrController.class);
	
	@Autowired
	private SqlSession sqlSession;

	/*
	*********************************************************
	* Program ID	: PopPtnrMbr
	* Program Name	: PopPtnrMbr
	* Description	: 해당보험사 멤사 추가
	* Author		: 이동익
	* Date			: 2016.04.28.
	*********************************************************
	*/
	@RequestMapping(value = "popPtnrAdd", method = RequestMethod.GET)
	public String popPtnrAdd(Model model, HttpServletResponse response, String ptnr_id, HttpSession session) {
		logger.info("popPtnrAdd");
		
		
//		List<TopPtnrBscVO> ptnrList = sqlSession.selectList("PopPtnrMbrMapper.getPtnrList", ptnr_id);
//		model.addAttribute("ptnrList", ptnrList);

		TopPtnrBscVO ptnrInfo = sqlSession.selectOne("PopPtnrMbrMapper.getPtnrInfo",ptnr_id);
		List<TopPtnrDeptBscVO> ptnrDeptList = sqlSession.selectList("PopPtnrMbrMapper.getThisDept", ptnr_id);
		
		model.addAttribute("ptnrDeptList", ptnrDeptList);
		model.addAttribute("ptnrInfo", ptnrInfo);
		
		return "top_general/pop_ptnr_add";
	}
	
	
	
	
	@RequestMapping(value = "popPtnrAddOK", method = RequestMethod.POST)
	public void popPtnrAddOK(TopPtnrMbrBscVO insertVO, HttpServletResponse response, HttpServletRequest request, HttpSession session) {
		logger.info("popPtnrAddOK");

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		Damo damo = new Damo();
		if (insertVO.getPtnr_mbr_hp() != null || insertVO.getPtnr_mbr_hp() != ""){
			insertVO.setPtnr_mbr_hp( damo.encodeDamo(insertVO.getPtnr_mbr_hp()) );
		}	
		if (insertVO.getPtnr_mbr_office_tel() != null || insertVO.getPtnr_mbr_office_tel() != ""){
			insertVO.setPtnr_mbr_office_tel( damo.encodeDamo(insertVO.getPtnr_mbr_office_tel()) );
		}	
		if (insertVO.getPtnr_mbr_office_fax() != null || insertVO.getPtnr_mbr_office_fax() != ""){
			insertVO.setPtnr_mbr_office_fax( damo.encodeDamo(insertVO.getPtnr_mbr_office_fax()) );
		}	
		if (insertVO.getPtnr_mbr_office_email() != null || insertVO.getPtnr_mbr_office_email() != ""){
			insertVO.setPtnr_mbr_office_email( damo.encodeDamo(insertVO.getPtnr_mbr_office_email()) );
		}
		
		//보험사 담당자 로그 추가 시작 	by top3009 
		String sAction = "I";				//I : 추가		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		String manager_no = mbrVo.getUser_no();			//사번
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		paramMap.put("action_flag", sAction);
		//paramMap.put("ptnr_mbr_no", insertVO.getPtnr_mbr_no());
		paramMap.put("manager_no", manager_no);
		
		//sqlSession.insert("PopPtnrMbrMapper.insertPtnrMbrLog", paramMap);
		//보험사 담당자 로그 추가 끝
		
		//보험사 담당자 정보 추가
		int PtnrMbr = sqlSession.insert("PopPtnrMbrMapper.insertPtnrMbr", insertVO);
		
		String maxPtnrMbrNo = sqlSession.selectOne("PopPtnrMbrMapper.selectPtnrMbrMax");
		
		//등록된 보험사 담당자 사번을 넣어준다.
		paramMap.put("ptnr_mbr_no", maxPtnrMbrNo);
		sqlSession.insert("PopPtnrMbrMapper.insertPtnrMbrLog", paramMap);		

		out.print(PtnrMbr);
		out.close();
	}
	
	/*
	*********************************************************
	* Program ID	: PopPtnrMbr
	* Program Name	: PopPtnrMbr
	* Description	: 해당보험사 멤버 수정
	* Author		: 이동익
	* Date			: 2016.04.28.
	*********************************************************
	*/
	@RequestMapping(value = "popPtnrUdt", method = RequestMethod.GET)
	public String popPtnrUdt(Model model, HttpServletResponse response, String ptnr_mbr_no) {
		logger.info("popPtnrUdt");
		

		
		TopPtnrMbrBscVO ptnrMbr = sqlSession.selectOne("PopPtnrMbrMapper.getPtnrMbr", ptnr_mbr_no);
		
		List<TopPtnrDeptBscVO> ptnrDeptList = sqlSession.selectList("PopPtnrMbrMapper.getThisDept", ptnrMbr.getPtnr_id());
		
		Damo damo = new Damo();
		if (ptnrMbr.getPtnr_mbr_hp() != null || ptnrMbr.getPtnr_mbr_hp() != ""){
			ptnrMbr.setPtnr_mbr_hp( damo.decodeDamo(ptnrMbr.getPtnr_mbr_hp()) );
		}	
		if (ptnrMbr.getPtnr_mbr_office_tel() != null || ptnrMbr.getPtnr_mbr_office_tel() != ""){
			ptnrMbr.setPtnr_mbr_office_tel( damo.decodeDamo(ptnrMbr.getPtnr_mbr_office_tel()) );
		}	
		if (ptnrMbr.getPtnr_mbr_office_fax() != null || ptnrMbr.getPtnr_mbr_office_fax() != ""){
			ptnrMbr.setPtnr_mbr_office_fax( damo.decodeDamo(ptnrMbr.getPtnr_mbr_office_fax()) );
		}	
		if (ptnrMbr.getPtnr_mbr_office_email() != null || ptnrMbr.getPtnr_mbr_office_email() != ""){
			ptnrMbr.setPtnr_mbr_office_email( damo.decodeDamo(ptnrMbr.getPtnr_mbr_office_email()) );
		}	
		
		model.addAttribute("ptnrDeptList", ptnrDeptList);
		model.addAttribute("ptnrMbr", ptnrMbr);
		
		return "top_general/pop_ptnr_udt";
	}

	@RequestMapping(value = "popPtnrUdtOK", method = RequestMethod.POST)
	public void popPtnrUdtOK(TopPtnrMbrBscVO updateVO, HttpServletResponse response, HttpServletRequest request, HttpSession session) {
		logger.info("popPtnrUdtOK");

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		Damo damo = new Damo();
		if (updateVO.getPtnr_mbr_hp() != null || updateVO.getPtnr_mbr_hp() != ""){
			updateVO.setPtnr_mbr_hp( damo.encodeDamo(updateVO.getPtnr_mbr_hp()) );
		}	
		if (updateVO.getPtnr_mbr_office_tel() != null || updateVO.getPtnr_mbr_office_tel() != ""){
			updateVO.setPtnr_mbr_office_tel( damo.encodeDamo(updateVO.getPtnr_mbr_office_tel()) );
		}	
		if (updateVO.getPtnr_mbr_office_fax() != null || updateVO.getPtnr_mbr_office_fax() != ""){
			updateVO.setPtnr_mbr_office_fax( damo.encodeDamo(updateVO.getPtnr_mbr_office_fax()) );
		}	
		if (updateVO.getPtnr_mbr_office_email() != null || updateVO.getPtnr_mbr_office_email() != ""){
			updateVO.setPtnr_mbr_office_email( damo.encodeDamo(updateVO.getPtnr_mbr_office_email()) );
		}	
		
		//보험사 담당자 로그 추가 시작 	by top3009 
		String sAction = "U";				//U : 수정		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		String manager_no = mbrVo.getUser_no();			//사번
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		paramMap.put("action_flag", sAction);
		paramMap.put("ptnr_mbr_no", updateVO.getPtnr_mbr_no());
		paramMap.put("manager_no", manager_no);
		
		sqlSession.insert("PopPtnrMbrMapper.insertPtnrMbrLog", paramMap);
		//보험사 담당자 로그 추가 끝
		
		int PtnrMbrUdt = sqlSession.update("PopPtnrMbrMapper.updatePtnrMbr", updateVO);
		
		out.print(PtnrMbrUdt);
		out.close();
	}
	
	/*
	*********************************************************
	* Program ID	: PopPtnrMbr
	* Program Name	: PopPtnrMbr
	* Description	: 해당보험사 멤버 삭제
	* Author		: 이동익
	* Date			: 2016.04.28.
	*********************************************************
	*/
	@RequestMapping(value = "popPtnrDelOK", method = RequestMethod.POST)
	public void popPtnrDelOK(TopPtnrMbrBscVO delVO, HttpServletResponse response, HttpServletRequest request, HttpSession session) {
		logger.info("popPtnrDelOK");
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		//해당 보험사 맴버 삭제시 delete 하지 않고 del_flag 만 업데이트 한다. (보고서와 연계키문제) by top3009
		
		//int PtnrMbrDel = sqlSession.delete("PopPtnrMbrMapper.delPtnrMbr", delVO);
		
		//보험사 담당자 로그 추가 시작 	by top3009 
		String sAction = "D";				//D : 삭제		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		String manager_no = mbrVo.getUser_no();			//사번
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		paramMap.put("action_flag", sAction);
		paramMap.put("ptnr_mbr_no", delVO.getPtnr_mbr_no());
		paramMap.put("manager_no", manager_no);
		
		sqlSession.insert("PopPtnrMbrMapper.insertPtnrMbrLog", paramMap);
		//보험사 담당자 로그 추가 끝
		
		int PtnrMbrDel = sqlSession.update("PopPtnrMbrMapper.updateDelflagPtnrMbr", delVO);
		 
		out.print(PtnrMbrDel);
		out.close();
	}

}
