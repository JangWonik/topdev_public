package kr.co.toplac.util.mbr;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.toplac.topgeneral.TopPtnrMbrBscVO;
import kr.co.toplac.topptnr.TopPtnrBscVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.etc.Damo;

@Controller
public class SuimPtnrMbrPop {

	@Autowired
	private SqlSession sqlSession;

	private static final Logger logger = LoggerFactory.getLogger(SuimPtnrMbrPop.class);

	@RequestMapping(value = "/suimPtnrMbrPop", method = RequestMethod.GET)
	public String suimPtnrMbrPop(Model model, HttpSession session, HttpServletRequest request
			, SuimTmMbrPopViewVO inVO) {

		logger.info("======= suimPtnrMbrPop =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || mbrVo.getUser_no() == null || mbrVo.getUser_no().trim() == ""){
			logger.info("suimPtnrMbrPop - no permissions user " + request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		
		String ptnr_id = inVO.getPtnrNo();
		model.addAttribute("ptnrNo", ptnr_id);
		model.addAttribute("gbNo", inVO.getGbNo());//1:수임,2:농작물
		model.addAttribute("smNo", inVO.getSmNo());
		model.addAttribute("ptnrDeptNo",inVO.getPtnrDeptNo());
		

		/*검색에 사용될 파트너목록 추출*/
		List<TopPtnrBscVO> ptnrList = sqlSession.selectList("RptInvListMapper.ptnrListForSearch");
		model.addAttribute("ptnrList", ptnrList);

		List<TopPtnrMbrBscVO> ptnrMbrList= sqlSession.selectList("TopPtnrDtlMapper.getptnrMbrList", ptnr_id);
		
		Damo damo = new Damo();
		String tmpStr = "";
		for(int i=0; i<ptnrMbrList.size(); i++){
			if ( !ptnrMbrList.get(i).getPtnr_mbr_office_tel().equals("") ){
				tmpStr = ptnrMbrList.get(i).getPtnr_mbr_office_tel();
				tmpStr = damo.decodeDamo(tmpStr);
				ptnrMbrList.get(i).setPtnr_mbr_office_tel(tmpStr);
			}else{
				ptnrMbrList.get(i).setPtnr_mbr_office_tel("미등록");
			}
			ptnrMbrList.get(i).getPtnr_mbr_office_tel();
		}
		
		model.addAttribute("ptnrMbrList", ptnrMbrList);

		return "util_mbr/sm_ptnr_mbr_pop";
	}//suimPtnrMbrPop

	/*사원 검색 동작*/
	@RequestMapping(value = "suimPtnrMbrPopSearch", method = RequestMethod.POST)
	public void suimPtnrMbrPopSearch(String ptnr, String gb, String str, HttpServletResponse response) {

		logger.info("======= suimPtnrMbrPopSearch =======");

		HashMap<String, String> queryMap = new HashMap<String, String>();
		queryMap.put("ptnrSrc", ptnr);
		queryMap.put("ptnrGb", gb);
		
		Damo damo = new Damo();
		String srcWordENC = damo.encodeDamo(str);
		queryMap.put("srcWordDEC", str);
		queryMap.put("srcWordENC", srcWordENC);
		
		List<TopPtnrMbrBscVO> searchMemberList = sqlSession.selectList("SuimPtnrMbrPopMapper.suimPtnrMbrPopSearch", queryMap);
		JSONArray arr = new JSONArray();
		for(int i=0; i < searchMemberList.size(); i++){
			TopPtnrMbrBscVO tmpvo = searchMemberList.get(i);
			tmpvo.setPtnr_mbr_office_tel(damo.decodeDamo(tmpvo.getPtnr_mbr_office_tel())); 
			
			JSONObject obj = new JSONObject();
			obj.put("ptnr_nick", tmpvo.getPtnr_nick());
			obj.put("ptnr_tm_nm", tmpvo.getPtnr_tm_nm());
			obj.put("ptnr_tm2_nm", tmpvo.getPtnr_tm2_nm());
			obj.put("ptnr_mbr_position_nm", tmpvo.getPtnr_mbr_position_nm());
			obj.put("ptnr_mbr_nm", tmpvo.getPtnr_mbr_nm());
			obj.put("ptnr_mbr_no", tmpvo.getPtnr_mbr_no());
			obj.put("ptnr_id", tmpvo.getPtnr_id());
			obj.put("ptnr_dept_id", tmpvo.getPtnr_dept_id());
			obj.put("ptnr_mbr_office_tel", tmpvo.getPtnr_mbr_office_tel());
			obj.put("ptnr_dept_nm", tmpvo.getPtnr_dept_nm());			//팀이름 top_ptnr_dept_bsc 에서 가져온값으로 셋팅 by top3009
			arr.add(obj);
		}
		String jsonStr = arr.toString();

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		out.print(jsonStr);
		out.close();
	}//suimPtnrMbrPopSearch

	@RequestMapping(value = "suimPtnrMbrChg", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> suimPtnrMbrChg(HttpServletRequest request, HttpSession session, HttpServletResponse response, SuimTmMbrPopViewVO inVO) {

		logger.info("======= suimPtnrMbrChg =======");
		
		Map<String,Object> returnMap = new HashMap<String,Object>();
		
		int result = sqlSession.update("SuimPtnrMbrPopMapper.suimPtnrMbrChg", inVO);
		
		if (!"0".equals(inVO.getSmsFlag())){
			returnMap = sqlSession.selectOne("SuimPtnrMbrPopMapper.selectPtnrMbrSmsInfo",inVO.getSmNo());
		}
		
		/*** 삼성 적부는 로그를 남기지 않음 ***/
		String gbNo = inVO.getGbNo(), smNo = inVO.getSmNo();
		if(result > 0 && !gbNo.equals("318") ){
			HashMap<String,String> map = new HashMap<String, String>();	
			map.put("smNo", smNo);
			map.put("userNo", (String) session.getAttribute("user_no_Session"));
			map.put("userIp", request.getRemoteAddr());
			
			if(gbNo.equals("1")){
				sqlSession.insert("InsertRptLogMapper.insRptBscMap", map);
			}else if(gbNo.equals("2")){
				sqlSession.insert("InsertRptLogMapper.insPrimBizRptBscMap", map);
			}
			
		}else{
			returnMap.put("result","9999");
			
		}
		
		return returnMap;
		

	}//suimPtnrMbrChg

}//end of class
