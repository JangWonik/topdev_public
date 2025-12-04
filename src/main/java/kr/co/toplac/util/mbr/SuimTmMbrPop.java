package kr.co.toplac.util.mbr;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
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

import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;

@Controller
public class SuimTmMbrPop {

	@Autowired
	private SqlSession sqlSession;

	private static final Logger logger = LoggerFactory.getLogger(SuimTmMbrPop.class);

	@RequestMapping(value = "/suimTmMbrPop", method = RequestMethod.GET)
	public String suimTmMbrPop(Model model, HttpSession session, HttpServletRequest request
			, SuimTmMbrPopViewVO inVO) {

		logger.info("======= suimTmMbrPop =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || mbrVo.getUser_no() == null || mbrVo.getUser_no().trim() == ""){
			logger.info("suimPtnrMbrPop - no permissions user " + request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		model.addAttribute("gbNo", inVO.getGbNo());//1:수임,2:농작물,3:적부,5:원스탑(318:삼성,317:흥국,312:한화,310:KB)
		model.addAttribute("smNo", inVO.getSmNo());
		model.addAttribute("tmNo", inVO.getTmNo());
		
		if ( !inVO.getGbNo().equals("4") ){
			SuimTmMbrPopSMSVO smsVO = sqlSession.selectOne("SuimTmMbrPopMapper.suimTmMbrSMSYN", inVO);
			model.addAttribute("ptnrSMS1", smsVO.getPtnr_sms1());
			model.addAttribute("ptnrSMS2", smsVO.getPtnr_sms2());
			model.addAttribute("ptnrSMS3", smsVO.getPtnr_sms3());
		}
		
		/*검색에 사용될 팀목록 추출*/
		List<TopTmBscVO> tmList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
		model.addAttribute("teamList", tmList);

		HashMap<String, String> queryMap = new HashMap<String, String>();
		queryMap.put("ustat", "0");
		queryMap.put("tid", inVO.getTmNo());
		queryMap.put("searchStr", "");
		queryMap.put("gid", "0");
		List<TopMbrBscVO> tmMbrList = sqlSession.selectList("EmpNmlstTmListMapper.searchEmpList", queryMap);
		model.addAttribute("tmMbrList", tmMbrList);

		return "util_mbr/sm_tm_mbr_pop";
	}//suimTmMbrPop

	@RequestMapping(value = "suimTmMbrChg", method = RequestMethod.POST)
	public void suimTmMbrChg(HttpServletRequest request, HttpSession session, HttpServletResponse response
			, SuimTmMbrPopViewVO inVO) {

		logger.info("======= suimTmMbrChg =======");

		int result = 0;
		
		if( !inVO.getGbNo().equals("4") ){
			sqlSession.insert("SuimTmMbrPopMapper.insertRptUserLog", inVO);
			result = sqlSession.update("SuimTmMbrPopMapper.suimTmMbrChg", inVO);
		}else{
			result = sqlSession.update("SuimTmMbrPopMapper.helpTmMbrChg", inVO);
		}

		String jsonStr = "";
		
		String gbNo = inVO.getGbNo(), smNo = inVO.getSmNo();
		if(result > 0 && !gbNo.equals("4")){
			HashMap<String,String> map = new HashMap<String, String>();	
			map.put("smNo", smNo);
			map.put("userNo", (String) session.getAttribute("user_no_Session"));
			map.put("userIp", request.getRemoteAddr());
			
			if(gbNo.equals("1") || gbNo.equals("5")){
				sqlSession.insert("InsertRptLogMapper.insRptBscMap", map);
			}else if(gbNo.equals("2")){
				sqlSession.insert("InsertRptLogMapper.insPrimBizRptBscMap", map);
			}

			if(gbNo.equals("1") || gbNo.equals("2")){
				SuimTmMbrPopSMSVO smsVO = sqlSession.selectOne("SuimTmMbrPopMapper.suimTmMbrChgSMS", inVO);
				if(smsVO.getPtnr_sms2().equals("1")){
					String msg = smsVO.getPtnr_sms2_msg();
					msg = msg.replace("[ig]", smsVO.getPtnr_nm());
					msg = msg.replace("[insured]", smsVO.getBeneficiary_nm());
					if ( smsVO.getPtnr_mbr_nm() != null && smsVO.getPtnr_mbr_nm() != ""){
						msg = msg.replace("[igm]", smsVO.getPtnr_mbr_nm());
					}else{
						msg = msg.replace("[igm]", "미정");
					}
					
					JSONArray arr = new JSONArray();
					JSONObject obj = new JSONObject();
					obj.put("hp", smsVO.getHandphone());
					obj.put("msg", msg);
					arr.add(obj);
					jsonStr = arr.toString();
				}
			}
		}
		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		if(result > 0 && jsonStr.length() > 0){
			out.print(jsonStr);
		}else if(result > 0 && !gbNo.equals("1") && !gbNo.equals("2")){
			out.print(result);
		}
		out.close();

	}//suimTmMbrChg

}//end of class
