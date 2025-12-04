package kr.co.toplac.topteam;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
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

import kr.co.toplac.cmm.service.CodeDicService;
import kr.co.toplac.sysadm.SysAdmCodeDicVO;
import kr.co.toplac.util.rpt.MainLeftUtil;

@Controller
public class TmMngDtlController {

	private static final Logger logger = LoggerFactory.getLogger(TmMngDtlController.class);
	
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	MainLeftUtil mlu;
	
	@Autowired
	private CodeDicService service;

	@RequestMapping(value = "teamamd", method = RequestMethod.GET)
	public String teamamd(Model model, String action,String team_id,String order, String parent, String tt, HttpSession session, HttpServletRequest request) {
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_13().equals("0")){
			logger.info("teamamd - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		
		//탭 선택
		String selTab  = request.getParameter("selTab") != null ? request.getParameter("selTab") : "0";
		
		mlu.mainLeftMySuimState(sqlSession, model, mbrVo.getUser_no());
		mlu.mainLeftTmSuimState(sqlSession, model, mbrVo.getTeam_id_main(), mbrVo.getUser_no());

		/** 팀장선택을 위한 직원명부로드 **/
		List<TopMbrBscVO> AllMember = sqlSession.selectList("TmMngDtlMapper.getAllMember");
		model.addAttribute("AllMember",AllMember);
		
		/** 팀 부문 선택을 위한 부문 명부로드 2019.07.08 by top3009*/
		SysAdmCodeDicVO codeVO = new SysAdmCodeDicVO();      
		codeVO.setTbl_nm("top_tm_bsc");
		codeVO.setCol_nm("team_sector");
		List<SysAdmCodeDicVO> teamSectorList = service.codeList(codeVO);
		model.addAttribute("teamSectorList", teamSectorList);
		
		/** 팀 센터 선택을 위한 부문 명부로드 2019.07.12 by top3009*/		      
		codeVO.setTbl_nm("top_tm_bsc");
		codeVO.setCol_nm("team_center");
		List<SysAdmCodeDicVO> teamCenterList = service.codeList(codeVO);
		model.addAttribute("teamCenterList", teamCenterList);
		
		TopTmBscVO teamVO = new TopTmBscVO();
		if(action.equals("modify") && (team_id != null)){
			
			teamVO = sqlSession.selectOne("TmMngDtlMapper.selectOneTeam", team_id);
			int memberCnt = sqlSession.selectOne("TmMngDtlMapper.countMemberNum", team_id);
			
			List<TopMbrBscVO> currentTmMng= sqlSession.selectList("TmMngDtlMapper.getTeamManager",team_id);
			model.addAttribute("currentTmMng",currentTmMng);
			
			model.addAttribute("memberCnt",memberCnt);
			model.addAttribute("team_id",team_id);
			model.addAttribute("teamVO",teamVO);
			
		}else if(action.equals("add")){
			
			model.addAttribute("parent",parent);
			model.addAttribute("order",order);
		}
		
		//서면심사용 보험사목록 불러오기
		List<Map<String, Object>> writtenPtnrIdList = sqlSession.selectList("MisPtnrBsc.selectWrittenPtnrInfo");
		model.addAttribute("writtenPtnrIdList", writtenPtnrIdList);
		
		model.addAttribute("action",action);
		model.addAttribute("tt",tt);
		model.addAttribute("page","amd");
		
		//팀 보험사 지정용 보험사 목록 가져오기(통계 보험사 목록과 동일)
		List<Map<String, Object>> teamPtnrList = sqlSession.selectList("MisPtnrBsc.selectTeamPtnrList");
		model.addAttribute("teamPtnrList", teamPtnrList);
		
		//팀 지역설정용 목록 불러오기
		SysAdmCodeDicVO zoneVO = new SysAdmCodeDicVO();      
		zoneVO.setTbl_nm("top_tm_bsc");
		zoneVO.setCol_nm("team_zone");
		List<SysAdmCodeDicVO> zoneList = service.codeList(zoneVO);
		model.addAttribute("zoneList", zoneList);
		
		//탭 선택 추가
		model.addAttribute("selTab", selTab);
		
		return "top_team/tm_mng_dtl";
	}
	
	@RequestMapping(value = "teamamdOk", method = RequestMethod.POST)
	public String teamamdOk(String action, Model model,TopTmBscVO teamParam, HttpServletRequest request) {
		
		try {
			
			//탭 선택
			String selTab  = request.getParameter("selTab") != null ? request.getParameter("selTab") : "0";
			
			int result =0;
			
			//메모 처리용 Map
			Map<String, Object> paramMap = new HashMap<String, Object>();
			
			paramMap.put("category_type", "1");			//팀 관리 코드
			
			if(action.equals("add")){				
				result = sqlSession.insert("TmMngDtlMapper.newTeam", teamParam);
				
			}else if(action.equals("modify")){
				result = sqlSession.update("TmMngDtlMapper.updateTeam", teamParam);
				//기존 팀아이디와 수정 팀아이디가 바뀌는 경우 체크				
				
				if( !teamParam.getTeam_id().equals(teamParam.getOriginTeamCode()) ) {				
					
					//팀아이디가 수정되는 경우 Memo 의 fkey를 갱신해주어야 한다.					
					paramMap.put("new_fkey", teamParam.getTeam_id());
					paramMap.put("org_fkey", teamParam.getOriginTeamCode());					
					sqlSession.update("ItMgmtMapper.updateItMemoByFkey", paramMap);
				}

			}else if(action.equals("delete")){
				result = sqlSession.delete("TmMngDtlMapper.delTeam", teamParam.getTeam_id());
				
				//팀이 삭제되는 경우 Memo 도 삭제해줘야 한다.
				paramMap.put("fkey", teamParam.getTeam_id());
				sqlSession.delete("ItMgmtMapper.deleteItMemoByFkey", paramMap);
			}
			
			model.addAttribute("result",result);
			model.addAttribute("action",action);
			
			//탭 선택 추가
			model.addAttribute("selTab", selTab);
			
		} catch (Exception e) {
			System.out.println("teamamdOk Error : "+e.getMessage());
		}
		
		
		return "top_team/tm_mng_dtl_ok";
	}
	
	@RequestMapping(value = "idcheck", method = RequestMethod.POST)
	public void idCheck(String team_id, HttpServletResponse response){
	    
		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	      
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
			
		String teamName = sqlSession.selectOne("TmMngDtlMapper.idCheck", team_id);
		
		out.print(teamName);
		out.close();
	}

}
