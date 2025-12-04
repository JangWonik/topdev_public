package kr.co.toplac.topprimbiz;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.cmm.RequestUtil;

@Controller
public class PrimBizRptDtlStateController {

	private static final Logger logger = LoggerFactory.getLogger(PrimBizRptDtlStateController.class);

	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value = "primBizRptStateChgUnLock", method = RequestMethod.POST)
	public void primBizRptStateChgUnLock(HttpServletRequest request, HttpSession session, HttpServletResponse response
			, String suimRptNo) {

		logger.info("======= primBizRptStateChgUnLock =======");

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		/*Session Check Start*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_5().equals("0")){
			logger.info("primBizRptStateChgUnLock - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			out.print(0);
			out.close();
		}
		/*Session Check End*/

		int result = 0;
		result = sqlSession.update("PrimBizRptStateMapper.primBizRptStateChgUnLock", suimRptNo);
		if(result > 0){
			HashMap<String,String> map = new HashMap<String, String>();	
			map.put("smNo", suimRptNo);
			map.put("userNo", (String) session.getAttribute("user_no_Session"));
			map.put("userIp", request.getRemoteAddr());
			sqlSession.insert("InsertRptLogMapper.insPrimBizRptBscMap", map);
		}

		out.print(result);
		out.close();

	}//primBizRptStateChgUnLock

	@RequestMapping(value = "primBizRptStateChgSubmit", method = RequestMethod.POST)
	public void primBizRptStateChgSubmit(HttpServletRequest request, HttpSession session, HttpServletResponse response
			, String suimRptNo) {

		logger.info("======= primBizRptStateChgSubmit =======");

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		/*Session Check Start*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null){
			logger.info("primBizRptStateChgSubmit - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			out.print(9);//9:permission Error
			out.close();
		}
		/*Session Check End*/

		HashMap<String,String> map = new HashMap<String, String>();	
		map.put("smNo", suimRptNo);
		map.put("userNo", (String) session.getAttribute("user_no_Session"));
		map.put("userIp", request.getRemoteAddr());

		int shaCnt = 0, insShaRst = 0;
		double invAndShaCompare = 0.0;
		shaCnt = sqlSession.selectOne("PrimBizRptStateMapper.getPrimBizInvShaCnt", suimRptNo);
		if(shaCnt == 0){
			insShaRst = sqlSession.insert("PrimBizRptStateMapper.insPrimBizInvShaForSubmit", suimRptNo);
			if(insShaRst > 0){
				map.put("regType", "1");
				sqlSession.insert("PrimBizRptStateMapper.insPrimBizInvShaLogForSubmit", map);
			}
		}else{
			invAndShaCompare = sqlSession.selectOne("PrimBizRptStateMapper.getPrimBizInvAndShaCompare", suimRptNo);
			if(invAndShaCompare != 0.0){
				out.print(2);//2:invAndSha Error
				out.close();
				return;
			}
		}

		int result = 0;
		result = sqlSession.update("PrimBizRptStateMapper.primBizRptStateChgSubmit", suimRptNo);
		if(result > 0){
			sqlSession.insert("InsertRptLogMapper.insPrimBizRptBscMap", map);
		}

		out.print(result);//0:fail,1:success,2:invAndSha Error,9:permission Error
		out.close();

	}//primBizRptStateChgSubmit

	@RequestMapping(value = "primBizRptStateChgSubmitX", method = RequestMethod.POST)
	public void primBizRptStateChgSubmitX(HttpServletRequest request, HttpSession session, HttpServletResponse response
			, String suimRptNo) {

		logger.info("======= primBizRptStateChgSubmitX =======");

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		/*Session Check Start*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null){
			logger.info("primBizRptStateChgSubmit - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			out.print(0);
			out.close();
		}
		/*Session Check End*/

		int result = 0;
		result = sqlSession.update("PrimBizRptStateMapper.primBizRptStateChgSubmitX", suimRptNo);
		if(result > 0){
			HashMap<String,String> map = new HashMap<String, String>();	
			map.put("smNo", suimRptNo);
			map.put("userNo", (String) session.getAttribute("user_no_Session"));
			map.put("userIp", request.getRemoteAddr());
			sqlSession.insert("InsertRptLogMapper.insPrimBizRptBscMap", map);
		}

		out.print(result);
		out.close();

	}//primBizRptStateChgSubmitX

	@RequestMapping(value = "primBizRptStateChgReturn", method = RequestMethod.POST)
	public void primBizRptStateChgReturn(HttpServletRequest request, HttpSession session, HttpServletResponse response
			, String suimRptNo) {

		logger.info("======= primBizRptStateChgReturn =======");

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		/*Session Check Start*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null){
			logger.info("primBizRptStateChgReturn - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			out.print(0);
			out.close();
		}
		/*Session Check End*/

		int result = 0;
		result = sqlSession.update("PrimBizRptStateMapper.primBizRptStateChgReturn", suimRptNo);
		if(result > 0){
			HashMap<String,String> map = new HashMap<String, String>();	
			map.put("smNo", suimRptNo);
			map.put("userNo", (String) session.getAttribute("user_no_Session"));
			map.put("userIp", request.getRemoteAddr());
			sqlSession.insert("InsertRptLogMapper.insPrimBizRptBscMap", map);
		}

		out.print(result);
		out.close();

	}//primBizRptStateChgReturn

	@RequestMapping(value = "primBizRptStateChgReturnX", method = RequestMethod.POST)
	public void primBizRptStateChgReturnX(HttpServletRequest request, HttpSession session, HttpServletResponse response
			, String suimRptNo) {

		logger.info("======= primBizRptStateChgReturnX =======");

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		/*Session Check Start*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null){
			logger.info("primBizRptStateChgReturnX - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			out.print(0);
			out.close();
		}
		/*Session Check End*/

		int result = 0;
		result = sqlSession.update("PrimBizRptStateMapper.primBizRptStateChgReturnX", suimRptNo);
		if(result > 0){
			HashMap<String,String> map = new HashMap<String, String>();	
			map.put("smNo", suimRptNo);
			map.put("userNo", (String) session.getAttribute("user_no_Session"));
			map.put("userIp", request.getRemoteAddr());
			sqlSession.insert("InsertRptLogMapper.insPrimBizRptBscMap", map);
		}

		out.print(result);
		out.close();

	}//primBizRptStateChgReturnX

	@RequestMapping(value = "primBizRptStateChgClose", method = RequestMethod.POST)
	public void primBizRptStateChgClose(HttpServletRequest request, HttpSession session, HttpServletResponse response
			, String suimRptNo) {

		logger.info("======= primBizRptStateChgClose =======");

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		/*Session Check Start*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null){
			logger.info("primBizRptStateChgClose - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			out.print(0);
			out.close();
		}
		/*Session Check End*/

		String closeCntStr = "";
		HashMap<String, String> mapForAcceptSeqNo = new HashMap<String, String>();
		mapForAcceptSeqNo.put("suim_accept_seq_no", "");
		sqlSession.update("SuimRegInsMapper.getSuimAcceptSeqNo", mapForAcceptSeqNo);
		closeCntStr = mapForAcceptSeqNo.get("suim_accept_seq_no");
		for(int i = closeCntStr.length(); i < 4; i++){
			closeCntStr = "0"+closeCntStr;
		}

		HashMap<String,String> map = new HashMap<String, String>();	
		map.put("smNo", suimRptNo);
		map.put("userNo", (String) session.getAttribute("user_no_Session"));
		map.put("userIp", request.getRemoteAddr());

		int result = 0;
		map.put("closeCntStr", closeCntStr);
		result = sqlSession.update("PrimBizRptStateMapper.primBizRptStateChgClose", map);
		if(result > 0){
			sqlSession.insert("InsertRptLogMapper.insPrimBizRptBscMap", map);
		}

		out.print(result);
		out.close();

	}//primBizRptStateChgClose

	@RequestMapping(value = "primBizRptStateChgCloseX", method = RequestMethod.POST)
	public void primBizRptStateChgCloseX(HttpServletRequest request, HttpSession session, HttpServletResponse response
			, String suimRptNo) {

		logger.info("======= primBizRptStateChgCloseX =======");

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		/*Session Check Start*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null){
			logger.info("primBizRptStateChgCloseX - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			out.print(0);
			out.close();
		}
		/*Session Check End*/

		int result = 0;
		result = sqlSession.update("PrimBizRptStateMapper.primBizRptStateChgCloseX", suimRptNo);
		if(result > 0){
			HashMap<String,String> map = new HashMap<String, String>();	
			map.put("smNo", suimRptNo);
			map.put("userNo", (String) session.getAttribute("user_no_Session"));
			map.put("userIp", request.getRemoteAddr());
			sqlSession.insert("InsertRptLogMapper.insPrimBizRptBscMap", map);
		}

		out.print(result);
		out.close();

	}//primBizRptStateChgCloseX

	@RequestMapping(value = "primBizRptStateChgCancel", method = RequestMethod.POST)
	public void primBizRptStateChgCancel(HttpServletRequest request, HttpSession session, HttpServletResponse response
			, String suimRptNo) {

		logger.info("======= primBizRptStateChgCancel =======");

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		/*Session Check Start*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_3().equals("0")){
			logger.info("primBizRptStateChgDel - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			out.print(0);
			out.close();
		}
		/*Session Check End*/

		int result = 0;
		result = sqlSession.update("PrimBizRptStateMapper.primBizRptStateChgCancel", suimRptNo);
		if(result > 0){
			HashMap<String,String> map = new HashMap<String, String>();	
			map.put("smNo", suimRptNo);
			map.put("userNo", (String) session.getAttribute("user_no_Session"));
			map.put("userIp", request.getRemoteAddr());
			sqlSession.insert("InsertRptLogMapper.insPrimBizRptBscMap", map);
		}

		out.print(result);
		out.close();

	}//primBizRptStateChgCancel

	@RequestMapping(value = "primBizRptStateChgCancelX", method = RequestMethod.POST)
	public void primBizRptStateChgCancelX(HttpServletRequest request, HttpSession session, HttpServletResponse response
			, String suimRptNo) {

		logger.info("======= primBizRptStateChgCancelX =======");

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		/*Session Check Start*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_3().equals("0")){
			logger.info("primBizRptStateChgCancelX - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			out.print(0);
			out.close();
		}
		/*Session Check End*/

		int result = 0;
		result = sqlSession.update("PrimBizRptStateMapper.primBizRptStateChgCancelX", suimRptNo);
		if(result > 0){
			HashMap<String,String> map = new HashMap<String, String>();	
			map.put("smNo", suimRptNo);
			map.put("userNo", (String) session.getAttribute("user_no_Session"));
			map.put("userIp", request.getRemoteAddr());
			sqlSession.insert("InsertRptLogMapper.insPrimBizRptBscMap", map);
		}

		out.print(result);
		out.close();

	}//primBizRptStateChgCancelX

	@RequestMapping(value = "primBizRptStateChgDel", method = RequestMethod.POST)
	public void primBizRptStateChgDel(HttpServletRequest request, HttpSession session, HttpServletResponse response
			, String suimRptNo) {

		logger.info("======= primBizRptStateChgDel =======");

		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		/*Session Check Start*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || mbrAuthVo.getMbr_pms_3().equals("0")){
			logger.info("primBizRptStateChgDel - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			out.print(0);
			out.close();
		}
		/*Session Check End*/

		int result = 0;
		result = sqlSession.update("PrimBizRptStateMapper.primBizRptStateChgDel", suimRptNo);
		if(result > 0){
			HashMap<String,String> map = new HashMap<String, String>();	
			map.put("smNo", suimRptNo);
			map.put("userNo", (String) session.getAttribute("user_no_Session"));
			map.put("userIp", request.getRemoteAddr());
			sqlSession.insert("InsertRptLogMapper.insPrimBizRptBscMap", map);
		}

		out.print(result);
		out.close();

	}//primBizRptStateChgDel
	
	
	/**
	 * 단독 조사 결재올리기
	 * 180124 by.lds 
	 * 
	 */
	@RequestMapping(value = "primBizRptSingleSubmit", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> primBizRptSingleSubmit(HttpServletRequest request, HttpSession session, HttpServletResponse response, TopPrimBizRptCompositeVO inVO){
		
		//===============================================
        //	파라미터 체크 및 ResultMap 생성
    	//===============================================
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	Map<String, Object> resultMap = new HashMap<>();
    	
		String suimRptNo = (String) paramMap.get("suim_rpt_no"); 
		
    	//===============================================
    	//	권한체크
    	//===============================================
    	TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
    	//TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
    	inVO.setShare_team_id(mbrVo.getTeam_id_main());
    	inVO.setShare_user_no(mbrVo.getUser_no());		
		
		//공동조사자 입력
		int successCnt = 0;
		successCnt = sqlSession.insert("PrimBizRptDtlUdtMapper.insertPrimBizShare", inVO);
		if(successCnt > 0){
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("serial_no", inVO.getSerial_no());
			map.put("reg_user_no", (String) session.getAttribute("user_no_Session"));
			map.put("reg_type", "1");
			sqlSession.insert("PrimBizRptDtlUdtMapper.insPrimBizInvShareLogByMap", map);
		}else{
			//공동 조사자 입력 실패
			resultMap.put("result", "9001");
			return resultMap;
		}
		
		
		//결재 상태 변경 
		HashMap<String,String> map = new HashMap<String, String>();	
		map.put("smNo", suimRptNo);
		map.put("userNo", (String) session.getAttribute("user_no_Session"));
		map.put("userIp", request.getRemoteAddr());

		int shaCnt = 0, insShaRst = 0;
		double invAndShaCompare = 0.0;
		shaCnt = sqlSession.selectOne("PrimBizRptStateMapper.getPrimBizInvShaCnt", suimRptNo);
		if(shaCnt == 0){
			insShaRst = sqlSession.insert("PrimBizRptStateMapper.insPrimBizInvShaForSubmit", suimRptNo);
			if(insShaRst > 0){
				map.put("regType", "1");
				sqlSession.insert("PrimBizRptStateMapper.insPrimBizInvShaLogForSubmit", map);
			}
		}else{
			invAndShaCompare = sqlSession.selectOne("PrimBizRptStateMapper.getPrimBizInvAndShaCompare", suimRptNo);
			if(invAndShaCompare != 0.0){
				resultMap.put("result", "9002");
				return resultMap;
			}
		}

		int result = 0;
		result = sqlSession.update("PrimBizRptStateMapper.primBizRptStateChgSubmit", suimRptNo);
		if(result > 0){
			sqlSession.insert("InsertRptLogMapper.insPrimBizRptBscMap", map);
			resultMap.put("result", "0000");
		}
		
		return resultMap;
	}
			

}//end of class
