package kr.co.toplac.sysadm;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import kr.co.toplac.cmm.service.CodeDicService;
import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.topgeneral.EmpNmlstVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.PaginationInfo;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;
import kr.co.toplac.util.file.GetImageBase64;

@Controller
public class ItMgmtController {

	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private CodeDicService CodeDicService;

	private static final Logger logger = LoggerFactory.getLogger(ItMgmtController.class);
	
	@RequestMapping(value="/getItMemoInfo")
    public String getItMemoInfo(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getItMemoInfo =========");
    	    	
    	String sUrl = "top_team/tm_mng_memo_ajax";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	// 검색결과 가져오기
    	List<Map<String, Object>> memoList = sqlSession.selectList("ItMgmtMapper.selectItMemoInfoByFkey",paramMap);
    	
    	model.addAttribute("memoList", memoList);
    	
    	return sUrl;
    }
	
	/**
	 * IT(관리자용) 메모 Action
	 * param : action = I, U, D
	 * 
	 */	
	@RequestMapping(value="/memoItAction")
    @ResponseBody
    public int memoItAction(HttpServletRequest request, Model model) {
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//action : I(추가), U(업데이트)
		String sAction = paramMap.get("action").toString();
		
		logger.info("======= memoItAction : "+ sAction +" =======");
				
    	int nCnt = 0;    	
    	
    	if( "I".equals(sAction) ) {				//메모추가
    		nCnt = sqlSession.insert("ItMgmtMapper.insertItMemo", paramMap);
    	}else if("U".equals(sAction)) {		//메모수정
    		nCnt = sqlSession.update("ItMgmtMapper.updateItMemo", paramMap);
    	}else if("D".equals(sAction) ) {		//메모삭제
    		nCnt = sqlSession.delete("ItMgmtMapper.deleteItMemo", paramMap);
    	}
    	
    	return nCnt; 
	}
	
	/**
	 * 장비정보 동기화 (관리자용).. 사용시 주의
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/equipment_team_sync", method = RequestMethod.POST)
	@ResponseBody
	public int equipment_team_sync(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= equipment_team_sync =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("equipment_team_sync - no permession user_no : "+mbrVo.getUser_no());			
			return -1;
		}
		
		int nCnt = 0;
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		int nSerial_no = 0;
		int nUser_no = 0;
		int nTeam_id = 0;
		
		int nTeam_id_loc = 0;
		
		//공용 미등록 및 삭제되지 않은 장비목록을 가져온다.
		List<EquipmentBean> equipmentList = sqlSession.selectList("ItMgmtMapper.selectEquipmentListExcept", paramMap);		//장비목록
		
		for(int i=0; i < equipmentList.size(); i++) {
			nSerial_no = equipmentList.get(i).getSerial_no();
			nUser_no = equipmentList.get(i).getUser_no();
			nTeam_id = equipmentList.get(i).getTeam_id();			
			nTeam_id_loc = sqlSession.selectOne("ItMgmtMapper.selectMemberTeamLoc", nUser_no);
			if(nTeam_id != nTeam_id_loc) {
				//System.out.println(nSerial_no+" : "+nUser_no+" : "+nTeam_id+" : "+nTeam_id_loc);
				paramMap.put("serial_no", nSerial_no);
				paramMap.put("team_id_loc", nTeam_id_loc);
				nCnt = sqlSession.update("ItMgmtMapper.updateEquipmentTeamSync", paramMap);
			}
		}		
		
		return nCnt;
	}
	
	@RequestMapping(value = "/card_label_print", method = RequestMethod.POST)	
	public String card_label_print(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= card_label_print =======");				
		
		//===============================================
        //	로그 정보
        //===============================================
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("equipment_action - no permession user_no : "+mbrVo.getUser_no());			
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		List<Map<String, Object>> label_list = sqlSession.selectList("ItMgmtMapper.selectCardLabelList", paramMap);
		
		String sCardType = "";		
		String sUserNo = "";
		String dbpath = "";
		String fileType = "";

		GetImageBase64 imageUtil = new GetImageBase64();
		
		for( int i = 0; i < label_list.size(); i++ ) {
			sCardType = String.valueOf(label_list.get(i).get("card_type"));			
			
			//0인 경우(정상)인 경우만 이미지를 불러온다.
			if( "0".equals(sCardType) ) {
								
				sUserNo = String.valueOf(label_list.get(i).get("user_no"));
				
				TopMbrBscVO memberVo = sqlSession.selectOne("TopMbrDtlMapper.mbrinfo", sUserNo);				
				
				if( "0".equals(sUserNo) ) {						//사용자 정보가 없는 경우
					label_list.get(i).put("imageBase64", "nothing");
				}else if( (memberVo.getPicture() != null ) ){
					try {
						if(!memberVo.getPicture().equals("")){
							
							dbpath = "/home/hosting_users/toplac/www/ls_data/member/"+memberVo.getPicture();
							fileType = dbpath.substring(dbpath.lastIndexOf(".")+1, dbpath.length());
	
							File fd = new File(dbpath);							
							
							if (fd.exists()){								
								label_list.get(i).put("imageBase64", imageUtil.imageBase64Small(dbpath, fileType));
							}else {
								label_list.get(i).put("imageBase64", "nothing");
							}
						}
					}catch(Exception e) {							//예외발생시 사진없음으로 처리
						System.out.println("imageBase64 Error : "+e);
						label_list.get(i).put("imageBase64", "nothing");
					}
				}else{			//사진없음
					label_list.get(i).put("imageBase64", "nothing");
				}				
			}else if( "1".equals(sCardType) ){		//임시
				label_list.get(i).put("imageBase64", "temp");
			}else{			//2인 경우 공용
				label_list.get(i).put("imageBase64", "public");
			}
		}		
		
		model.addAttribute("label_list", label_list);
		
		String downType = String.valueOf(paramMap.get("label_down_type"));		
		
		if( "excel".equals(downType) ) {
			return "/sys_adm/card_label_down_excel";
		}else{
			return "/sys_adm/card_label_print";
		}
		
	}
	
	/**
	 * 카드정보 가져오기
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/get_card_info", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> get_card_info(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= get_card_info =======");
		
		Map<String,Object> returnMap = new HashMap<>();		
		
		String ckey = request.getParameter("ckey") != null ? request.getParameter("ckey") : "";
		
		CardBean cardInfo = sqlSession.selectOne("ItMgmtMapper.selectCardOne", ckey);		//카드정보
		
		//최종 수정일이 없으면 오늘 날짜로 넣는다.
		String sModDate = cardInfo.getMod_date();
		
		if( "".equals(sModDate) ) {
			sModDate = DateUtil.getTodayString("yyyy-MM-dd");
			cardInfo.setMod_date(sModDate);
		}
		
		returnMap.put("ckey", cardInfo.getCkey());
		returnMap.put("user_no", cardInfo.getUser_no());
		returnMap.put("team_id", cardInfo.getTeam_id());
		returnMap.put("card_type", cardInfo.getCard_type());
		returnMap.put("card_state", cardInfo.getCard_state());
		returnMap.put("card_zone", cardInfo.getCard_zone());
		returnMap.put("reg_date", cardInfo.getReg_date());
		returnMap.put("mod_date", cardInfo.getMod_date());
		returnMap.put("card_number", cardInfo.getCard_number());
		returnMap.put("card_memo", cardInfo.getCard_memo());		
		returnMap.put("is_del", cardInfo.getIs_del());
		returnMap.put("del_date", cardInfo.getDel_date());
		returnMap.put("card_uid", cardInfo.getCard_uid());
		returnMap.put("card_serial_no", cardInfo.getCard_serial_no());
		
		return returnMap;
	}
	
	@RequestMapping(value = "/get_equipment_info", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> get_equipment_info(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= get_equipment_info =======");
		
		Map<String,Object> returnMap = new HashMap<>();		
		
		String serial_no = request.getParameter("serial_no") != null ? request.getParameter("serial_no") : "";
		
		EquipmentBean equipmentInfo = sqlSession.selectOne("ItMgmtMapper.selectEquipmentOne", serial_no);		//장비정보
		
		returnMap.put("serial_no", equipmentInfo.getSerial_no());
		returnMap.put("user_no", equipmentInfo.getUser_no());
		returnMap.put("team_id", equipmentInfo.getTeam_id());
		returnMap.put("eq_type", equipmentInfo.getEq_type());
		returnMap.put("eq_state", equipmentInfo.getEq_state());
		returnMap.put("reg_date", equipmentInfo.getReg_date());
		returnMap.put("close_date", equipmentInfo.getClose_date());
		returnMap.put("eq_no", equipmentInfo.getEq_no());
		returnMap.put("eq_memo", equipmentInfo.getEq_memo());
		returnMap.put("eq_price", equipmentInfo.getEq_price());
		returnMap.put("is_del", equipmentInfo.getIs_del());
		returnMap.put("del_date", equipmentInfo.getDel_date());
		returnMap.put("cpu_info", equipmentInfo.getCpu_info());
		returnMap.put("memory_size", equipmentInfo.getMemory_size());
		
		return returnMap;
	}
	
	@RequestMapping(value = "/equipment_label_print", method = RequestMethod.POST)	
	public String equipment_label_print(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= equipment_label_print =======");				
		
		//===============================================
        //	로그 정보
        //===============================================
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("equipment_action - no permession user_no : "+mbrVo.getUser_no());			
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
		List<Map<String, Object>> label_list = sqlSession.selectList("ItMgmtMapper.selectEquipmentLabelList", paramMap);
		
		model.addAttribute("label_list", label_list);
		model.addAttribute("chk_date", String.valueOf(paramMap.get("label_chk_date")));
		model.addAttribute("chk_memo", String.valueOf(paramMap.get("label_memo_chk")));
		
		String downType = String.valueOf(paramMap.get("label_down_type"));		
		
		if( "excel".equals(downType) ) {
			return "/sys_adm/equipment_label_down_excel";
		}else{
			return "/sys_adm/equipment_label_print";
		}
		
	}
	
	@RequestMapping(value = "/equipment_action_all", method = RequestMethod.POST)
	@ResponseBody
	public int equipment_action_all(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= equipment_action_all =======");
		
		//===============================================
        //	로그 정보
        //===============================================
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("equipment_action - no permession user_no : "+mbrVo.getUser_no());			
			return -1;
		}
		
		String sLog_user_no = mbrVo.getUser_no();
		String sLog_ip = "";
		String sLog_action = "";
		String sLog_content = "";
		
		/*ip 얻기 시작*/
		HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		sLog_ip = req.getHeader("X-FORWARDED-FOR");
		
		if (sLog_ip == null){
			sLog_ip = req.getRemoteAddr(); 
		}
		/*ip 얻기 끝*/
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        sLog_content = RequestUtil.conversionMap(paramMap);
        
        paramMap.put("log_ip", sLog_ip);						//로그등록자 아이피
        paramMap.put("log_user_no", sLog_user_no);		//로그등록자 사번
        
        //리턴플래그		(0:에러)
        int nRet = 0;
        
        String action = paramMap.get("action").toString();
        String serial_no = paramMap.get("serial_no").toString();
        String team_id = paramMap.get("team_id").toString();
        
        //사용중인 팀, 사용자 이름 가져오기        
        String user_name = "";        
        String team_name = "";
        
        //사용중인 팀, 사용자 이름 가져오기
        if( "9999".equals(team_id)) {
        	team_name = "서버실";
        }else {
        	team_name = sqlSession.selectOne("ItMgmtMapper.selectTeamName", team_id);
        }
        
        paramMap.put("action", action);
        paramMap.put("serial_no", serial_no);
        
        //로그셋팅을 위한 serial_no 배열
        String [] sSerial_no = serial_no.split(",");
                        
        if( "AU".equals(action) ){			//일괄 수정        	
    		//장비일괄수정
        	paramMap.put("team_id", team_id);
        	nRet = sqlSession.update("ItMgmtMapper.updateEquipmentAll", paramMap);
        	
        	sLog_action = "Update";
        	
        	for(int i=0; i < sSerial_no.length; i++) {
        		serial_no = sSerial_no[i];
        		paramMap.put("serial_no", serial_no);
        		paramMap.put("log_action", sLog_action);
        		paramMap.put("log_content", sLog_content);						//등록내용
        		paramMap.put("team_name", team_name);
        		paramMap.put("user_name", user_name);
        		
        		sqlSession.insert("ItMgmtMapper.insertEquipmentLog", paramMap);
        	}
        	
        	 	
        }else if( "AC".equals(action) ) {		//일괄 폐기        	
        	//장비일괄폐기
        	paramMap.put("eq_state", 9);   //폐기코드     	
        	nRet = sqlSession.update("ItMgmtMapper.updateEquipmentAll", paramMap);
        	
        	sLog_action = "Close";
        	
        	for(int i=0; i < sSerial_no.length; i++) {
        		serial_no = sSerial_no[i];
        		paramMap.put("serial_no", serial_no);
        		paramMap.put("log_action", sLog_action);
        		paramMap.put("log_content", sLog_content);						//등록내용
        		paramMap.put("team_name", team_name);
        		paramMap.put("user_name", user_name);
        		
        		sqlSession.insert("ItMgmtMapper.insertEquipmentLog", paramMap);
        	}
        	
        }else if( "AD".equals(action) ) {		//일괄 삭제
        	
        	//장비일괄삭제 플래그로 처리      (is_del = 1, del_date = now() )  	     	
        	//nRet = sqlSession.delete("ItMgmtMapper.deleteEquipmentAll", paramMap);        	        	
        	nRet = sqlSession.update("ItMgmtMapper.updateEquipmentAll", paramMap);
        	
        	sLog_action = "Delete";
        	
        	for(int i=0; i < sSerial_no.length; i++) {
        		serial_no = sSerial_no[i];
        		paramMap.put("serial_no", serial_no);
        		paramMap.put("log_action", sLog_action);
        		paramMap.put("log_content", sLog_content);						//등록내용
        		paramMap.put("team_name", team_name);
        		paramMap.put("user_name", user_name);
        		
        		sqlSession.insert("ItMgmtMapper.insertEquipmentLog", paramMap);
        	}
        	
        }
        
		return nRet;		
	}
	
	/**
	 * 카드 정보 추가 수정
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */	
	@RequestMapping(value = "/card_action", method = RequestMethod.POST)
	@ResponseBody
	public int card_action(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= card_action =======");
		
		//===============================================
        //	로그 정보
        //===============================================
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("equipment_action - no permession user_no : "+mbrVo.getUser_no());			
			return -1;
		}
		
		String sLog_user_no = mbrVo.getUser_no();
		String sLog_ip = "";
		String sLog_action = "";
		String sLog_content = "";
		
		/*ip 얻기 시작*/
		HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		sLog_ip = req.getHeader("X-FORWARDED-FOR");
		
		if (sLog_ip == null){
			sLog_ip = req.getRemoteAddr(); 
		}
		/*ip 얻기 끝*/
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        sLog_content = RequestUtil.conversionMap(paramMap);
        
        paramMap.put("log_ip", sLog_ip);						//로그등록자 아이피
        paramMap.put("log_user_no", sLog_user_no);		//로그등록자 사번
        
        //리턴플래그		(0:에러, 1:성공, 9:장비일련번호 중복)
        int nRet = 0;
        
        String action = paramMap.get("action").toString();        
        
        String team_id = paramMap.get("team_id").toString();
        String user_no = paramMap.get("user_no").toString();
        
        String team_name = "";
        String user_name = "";
        
        
        //사용중인 팀, 사용자 이름 가져오기
        if( "9999".equals(team_id)) {
        	team_name = "미지정";
        }else {
        	team_name = sqlSession.selectOne("ItMgmtMapper.selectTeamName", paramMap.get("team_id").toString());
        }
        
        if( "0".equals(user_no) ) {
        	user_name = "미등록";
        }else if( "99999".equals(user_no) ){
        	user_name = "공용";
        }else {
        	user_name = sqlSession.selectOne("ItMgmtMapper.selectUserName", paramMap.get("user_no").toString());
        }        
        
        int nChk = 0;
        
    	//카드번호 중복체크
    	nChk = sqlSession.selectOne("ItMgmtMapper.selectCardNumberChk", paramMap);
        
        if( "I".equals(action) ){        	
        	if( nChk > 0) {
        		nRet = 9;        		
        	}else {
        		//카드 등록
        		nRet = sqlSession.insert("ItMgmtMapper.insertCard", paramMap);
        		sLog_action = "Insert";
        		
        		//로그등록        		
        		paramMap.put("ckey", paramMap.get("ckey"));		//등록된 카드 ckey       		
        		paramMap.put("log_action", sLog_action);							//Insert
        		paramMap.put("log_content", sLog_content);						//등록내용
        		paramMap.put("user_name", user_name);
        		paramMap.put("team_name", team_name);
        		
        		sqlSession.insert("ItMgmtMapper.insertCardLog", paramMap);
        		
        	}
        }else if( "U".equals(action) ) {
        	if( nChk > 1) {			//자기자신외 다른 장비에 동일 등록번호가 있는 경우
        		nRet = 9;        		
        	}else {
        		//카드 수정
    			nRet = sqlSession.update("ItMgmtMapper.updateCard", paramMap);
    			sLog_action = "Update";
    			
    			paramMap.put("ckey", paramMap.get("ckey"));		//등록된 카드 ckey        		
        		paramMap.put("log_action", sLog_action);							//Update
        		paramMap.put("log_content", sLog_content);						//수정내용
        		paramMap.put("user_name", user_name);
        		paramMap.put("team_name", team_name);
        		
        		sqlSession.insert("ItMgmtMapper.insertCardLog", paramMap);
    			
    			nRet = 2;    			
        	}
        }else if( "D".equals(action) ) {		//카드삭제
        	//카드 수정
			nRet = sqlSession.update("ItMgmtMapper.updateDelCard", paramMap);
			sLog_action = "Delete";
			
			paramMap.put("ckey", paramMap.get("ckey"));		//등록된 카드 ckey        		
    		paramMap.put("log_action", sLog_action);							//Update
    		paramMap.put("log_content", sLog_content);						//수정내용
    		paramMap.put("user_name", user_name);
    		paramMap.put("team_name", team_name);
    		
    		sqlSession.insert("ItMgmtMapper.insertCardLog", paramMap);
			
			nRet = 3;
        }else {
        	nRet = -1;
        }
        
		return nRet;		
	}
	
	@RequestMapping(value = "/equipment_action", method = RequestMethod.POST)
	@ResponseBody
	public int equipment_action(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= equipment_action =======");
		
		//===============================================
        //	로그 정보
        //===============================================
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("equipment_action - no permession user_no : "+mbrVo.getUser_no());			
			return -1;
		}
		
		String sLog_user_no = mbrVo.getUser_no();
		String sLog_ip = "";
		String sLog_action = "";
		String sLog_content = "";
		
		/*ip 얻기 시작*/
		HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		sLog_ip = req.getHeader("X-FORWARDED-FOR");
		
		if (sLog_ip == null){
			sLog_ip = req.getRemoteAddr(); 
		}
		/*ip 얻기 끝*/
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        sLog_content = RequestUtil.conversionMap(paramMap);
        
        paramMap.put("log_ip", sLog_ip);						//로그등록자 아이피
        paramMap.put("log_user_no", sLog_user_no);		//로그등록자 사번
        
        //리턴플래그		(0:에러, 1:성공, 9:장비일련번호 중복)
        int nRet = 0;
        
        String action = paramMap.get("action").toString();
        String eq_no = paramMap.get("eq_no").toString();			//장비 일련번호 (중복되면 안됨)
        
        String team_id = paramMap.get("team_id").toString();
        String user_no = paramMap.get("user_no").toString();
        
        String team_name = "";
        String user_name = "";
        
        
        //사용중인 팀, 사용자 이름 가져오기
        if( "9999".equals(team_id)) {
        	team_name = "서버실";
        }else {
        	team_name = sqlSession.selectOne("ItMgmtMapper.selectTeamName", paramMap.get("team_id").toString());
        }
        
        if( "0".equals(user_no) ) {
        	user_name = "미등록";
        }else {
        	user_name = sqlSession.selectOne("ItMgmtMapper.selectUserName", paramMap.get("user_no").toString());
        }        
        
        int nChk = 0;
        
        //장비일련번호 중복 체크        	
    	nChk = sqlSession.selectOne("ItMgmtMapper.selectEqnoChk", paramMap);
        
        if( "I".equals(action) ){        	
        	if( nChk > 0) {
        		nRet = 9;        		
        	}else {
        		//장비등록        		
        		nRet = sqlSession.insert("ItMgmtMapper.insertEquipment", paramMap);
        		sLog_action = "Insert";
        		
        		paramMap.put("serial_no", paramMap.get("serial_no"));		//등록된 장비 serial_no        		
        		paramMap.put("log_action", sLog_action);							//Insert
        		paramMap.put("log_content", sLog_content);						//등록내용
        		paramMap.put("user_name", user_name);
        		paramMap.put("team_name", team_name);
        		
        		sqlSession.insert("ItMgmtMapper.insertEquipmentLog", paramMap);
        		
        	}
        }else if( "U".equals(action) ) {
        	if( nChk > 1) {			//자기자신외 다른 장비에 동일 등록번호가 있는 경우
        		nRet = 9;        		
        	}else {
        		//장비수정
    			nRet = sqlSession.update("ItMgmtMapper.updateEquipment", paramMap);    			
    			sLog_action = "Update";
    			
    			paramMap.put("serial_no", paramMap.get("serial_no"));		//등록된 장비 serial_no        		
        		paramMap.put("log_action", sLog_action);							//Update
        		paramMap.put("log_content", sLog_content);						//수정내용
        		paramMap.put("user_name", user_name);
        		paramMap.put("team_name", team_name);
        		
        		sqlSession.insert("ItMgmtMapper.insertEquipmentLog", paramMap);
    			
    			nRet = 2;    			
        	}
        }else {
        	nRet = -1;
        }
        
		return nRet;		
	}
	
	@RequestMapping(value = "/card_manage_summary")
	public String card_manage_summary(Model model, HttpSession session, HttpServletRequest request) {
		String sUrl = "";
		
		logger.info("======= card_manage_summary =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		//탭타입		
		String viewType = request.getParameter("viewType") != null ? request.getParameter("viewType") : "Total";			//종구분
		
		//엑셀다운로드 여부
		String doTotalExcelDown = request.getParameter("doTotalExcelDown") != null ? request.getParameter("doTotalExcelDown") : "";			//종구분
		
		//사업부 별(1,4, 기타) 카드 카운트
		Map<String, Object> cardSummary1Map = sqlSession.selectOne("ItMgmtMapper.selectCardSummary1Info");		
		Map<String, Object> cardSummary4Map = sqlSession.selectOne("ItMgmtMapper.selectCardSummary4Info");		
		Map<String, Object> cardSummary9Map = sqlSession.selectOne("ItMgmtMapper.selectCardSummary9Info");
		
		model.addAttribute("viewType", viewType);
		
		model.addAttribute("cardSummary1Map", cardSummary1Map);
		model.addAttribute("cardSummary4Map", cardSummary4Map);
		model.addAttribute("cardSummary9Map", cardSummary9Map);
		
		if("1".equals(doTotalExcelDown)) {
			sUrl = "/sys_adm/card_manage_summary_excel";
		}else {
			sUrl = "/sys_adm/card_manage_summary";
		}
		
		return sUrl;
	}
	
	
	/**
	 * 장비정보 요약
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	
	@RequestMapping(value = "/equipment_manage_summary")
	public String equipment_manage_summary(Model model, HttpSession session, HttpServletRequest request) {
		String sUrl = "";
		
		logger.info("======= equipment_manage_summary =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		//탭타입		
		String viewType = request.getParameter("viewType") != null ? request.getParameter("viewType") : "Total";			//종구분
		
		//엑셀다운로드 여부
		String doTotalExcelDown = request.getParameter("doTotalExcelDown") != null ? request.getParameter("doTotalExcelDown") : "";			//종구분
		
		/**
		 * 직원인원 계산시작
		 */
		List<EmpNmlstVO> worktype_cnt = sqlSession.selectList("EmpNmlstTmListMapper.countWorkType");
		
		for (int i = 0; i < worktype_cnt.size(); i++) {
			worktype_cnt.get(i).getCnt();
		}
				
		/*팀현황 TAB 시작*/
		/*본사 사업부 조회시작*/
		List<EmpNmlstVO> teamList_head = sqlSession.selectList("EmpNmlstTmListMapper.getAllTeam");
		
		for (int i = 0; i < teamList_head.size(); i++) {
			if(teamList_head.get(i).getCnt().equals("0")){
				teamList_head.get(i).setCnt("-");
			}
		}
		/*본사 사업부 조회종료*/
		/*1종 사업부 조회시작*/
		List<EmpNmlstVO> teamList_1 = sqlSession.selectList("EmpNmlstTmListMapper.getTeam1");
		
		for (int i = 0; i < teamList_1.size(); i++) {
			if(teamList_1.get(i).getCnt().equals("0")){
				teamList_1.get(i).setCnt("-");
			}
			
		}
		/*1종 사업부 조회종료*/
		/*4종 사업부 조회시작*/
		List<EmpNmlstVO> teamList_4 = sqlSession.selectList("EmpNmlstTmListMapper.getTeam4");
		
		for (int i = 0; i < teamList_4.size(); i++) {
			if(teamList_4.get(i).getCnt().equals("0")){
				teamList_4.get(i).setCnt("-");
			}
		}
		/*4종 사업부 조회종료*/
		
		String countWorkTotal = sqlSession.selectOne("EmpNmlstTmListMapper.countAllWorkMember");
		
		model.addAttribute("worktype_cnt",worktype_cnt);
		model.addAttribute("teamList_head",teamList_head);
		model.addAttribute("teamList_1",teamList_1);
		model.addAttribute("teamList_4",teamList_4);
		model.addAttribute("countWorkTotal",countWorkTotal);		
		
		/**
		 * 직원인원 계산 끝 
		 */
		
		// 장비종류 SELECT
        SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();
        codeVo.setTbl_nm("top_equipment");
        codeVo.setCol_nm("eq_type");
        List<SysAdmCodeDicVO> eqTypeList = CodeDicService.codeList(codeVo);
        
        
        // 장비상태 SELECT
        codeVo.setTbl_nm("top_equipment");
        codeVo.setCol_nm("eq_state");
        List<SysAdmCodeDicVO> eqStateList = CodeDicService.codeList(codeVo);
        
        // 통계 배열        
        int nCnt = 0;
        
        List<EquipmentSummaryBean> eqSummary = sqlSession.selectList("ItMgmtMapper.selectEquipmentTypeCode");		//장비목록
        
        for(int i=0; i < eqSummary.size(); i++) {        	
        	//System.out.println(eqSummary.get(i).getCol_cd()+" : "+eqSummary.get(i).getCol_val());
        	
        	for(int k=0; k < eqStateList.size(); k++) {
        		
        		paramMap.put("eq_type", eqSummary.get(i).getCol_cd());
        		paramMap.put("eq_state", eqStateList.get(k).getCol_cd());
        		nCnt =  sqlSession.selectOne("ItMgmtMapper.selectEquipmentTypeCnt", paramMap);
        		
        		if( k == 0 ) {		//미회수
        			eqSummary.get(i).setEq_uncollect_cnt(nCnt);
        		}else if( k == 1 ) {		//사용중
        			eqSummary.get(i).setEq_use_cnt(nCnt);
        		}else if( k == 2 ) {		//고장
        			eqSummary.get(i).setEq_break_cnt(nCnt);
        		}else if( k == 3 ) {		//보류
        			eqSummary.get(i).setEq_hold_cnt(nCnt);
        		}else if( k == 4 ) {		//대기
        			eqSummary.get(i).setEq_wait_cnt(nCnt);
        		}else if( k == 5 ) {		//폐기
        			eqSummary.get(i).setEq_close_cnt(nCnt);
        		}
        	}
        }        
        
        model.addAttribute("eqTypeList", eqTypeList);
        model.addAttribute("eqStateList", eqStateList);
        
        model.addAttribute("eqSummary", eqSummary);        
        
		model.addAttribute("viewType", viewType);
		
		if("1".equals(doTotalExcelDown)) {
			sUrl = "/sys_adm/equipment_manage_summary_excel";
		}else {
			sUrl = "/sys_adm/equipment_manage_summary";
		}
		
		return sUrl;
	}
	
	/**
	 * 장비관리목록 조회 (인사팀용)
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/equipment_manage_list_view")
	public String equipment_manage_list_view(Model model, HttpSession session, HttpServletRequest request) {
		String sUrl = "";
		
		logger.info("======= equipment_manage_list_view =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		//탭타입		
		String viewType = request.getParameter("viewType") != null ? request.getParameter("viewType") : "Total";			//종구분
		
		//엑셀다운로드 여부
		String doExcelDown = request.getParameter("doExcelDown") != null ? request.getParameter("doExcelDown") : "";			//종구분
						
		//검색용 파라미터		
		String srchGubunMain = request.getParameter("srchGubunMain") != null ? request.getParameter("srchGubunMain") : "9";			//종구분
		String srchEqTypeMain = request.getParameter("srchEqTypeMain") != null ? request.getParameter("srchEqTypeMain") : "0";			//장비종류
		String tmSearchMain = request.getParameter("tmSearchMain") != null ? request.getParameter("tmSearchMain") : "";					//부서명
		String srchEqStateMain = request.getParameter("srchEqStateMain") != null ? request.getParameter("srchEqStateMain") : "0";		//장비상태
		String srchUserNoMain = request.getParameter("srchUserNoMain") != null ? request.getParameter("srchUserNoMain") : "";		//사번
		String srchEqNoMain = request.getParameter("srchEqNoMain") != null ? request.getParameter("srchEqNoMain") : "";		//장비일련번호
		
		String regSdate = request.getParameter("regSdate") != null ? request.getParameter("regSdate") : "";		//등록 시작일
		String regEdate = request.getParameter("regEdate") != null ? request.getParameter("regEdate") : "";		//등록 종료일
		String closeSdate = request.getParameter("closeSdate") != null ? request.getParameter("closeSdate") : "";		//폐기 시작일
		String closeEdate = request.getParameter("closeEdate") != null ? request.getParameter("closeEdate") : "";		//폐기 종료일
		
		//정렬기준 파라미터
		String regdate_order_set = request.getParameter("regdate_order_set") != null ? request.getParameter("regdate_order_set") : "";		//등록기준 정렬
		String name_order_set = request.getParameter("name_order_set") != null ? request.getParameter("name_order_set") : "";		//등록기준 정렬
		String team_order_set = request.getParameter("team_order_set") != null ? request.getParameter("team_order_set") : "";		//등록기준 정렬
		
		//삭제 장비 체크
		String del_view_val = request.getParameter("del_view_val") != null ? request.getParameter("del_view_val") : "0";		//삭제장비 보여주기 (0:안보임, 1:보임)		
		
		//String sQueryOrder = "order by GA.reg_date desc";
		//기본은 직원명부와 동일하기 정렬 by top3009
		String sQueryOrder = "ORDER BY  GA.team_group_order DESC, GA.team_order DESC, new_work_order, GA.work_level DESC, GA.work_rank DESC, GA.join_date, GA.user_name DESC";		
		
		if( !"".equals(regdate_order_set)) {
			if( "asc".equals(regdate_order_set) ) {
				sQueryOrder = "order by GA.reg_date";
			}else{
				sQueryOrder = "order by GA.reg_date desc";
			}
		}
		
		if( !"".equals(name_order_set)) {
			if( "asc".equals(name_order_set) ) {
				sQueryOrder = "order by GA.user_name";
			}else{
				sQueryOrder = "order by GA.user_name desc";
			}
		}
		
		if( !"".equals(team_order_set)) {
			if( "asc".equals(team_order_set) ) {
				sQueryOrder = "order by GA.team_name";
			}else{
				sQueryOrder = "order by GA.team_name desc";
			}
		}	
		
		//System.out.println("sQueryOrder="+sQueryOrder);
		
		paramMap.put("srchGubunMain", srchGubunMain);
		paramMap.put("tmSearchMain", tmSearchMain);
		paramMap.put("srchEqTypeMain", srchEqTypeMain);
		paramMap.put("srchEqStateMain", srchEqStateMain);
		paramMap.put("srchUserNoMain", srchUserNoMain);
		paramMap.put("srchEqNoMain", srchEqNoMain);
		
		paramMap.put("regSdate", regSdate);		
		paramMap.put("regEdate", regEdate);
		paramMap.put("closeSdate", closeSdate);
		paramMap.put("closeEdate", closeEdate);
		
		paramMap.put("del_view_val", del_view_val);
		
		paramMap.put("sQueryOrder", sQueryOrder);
		
		List<EquipmentBean> equipmentList = sqlSession.selectList("ItMgmtMapper.selectEquipmentList", paramMap);		//장비목록		
		//int equipmentCnt = sqlSession.selectOne("ItMgmtMapper.selectEquipmentListCnt", paramMap);							//조회된 장비 건수
		
		//model.addAttribute("equipmentCnt", equipmentCnt);		//조회된 장비 건수
		
		long total_price = 0;
		
		for( int i=0; i < equipmentList.size(); i++ ) {
			total_price += equipmentList.get(i).getEq_price();
		}
		
		model.addAttribute("equipmentList", equipmentList);
		model.addAttribute("total_price", total_price);
		model.addAttribute("del_view_val", del_view_val);		
		
		model.addAttribute("viewType", viewType);
		
		//System.out.println("doExcelDown="+doExcelDown);
		
		if("1".equals(doExcelDown)) {
			sUrl = "/sys_adm/equipment_manage_list_excel";
		}else {
			sUrl = "/sys_adm/equipment_manage_list_view";
		}
				
		return sUrl;
	}
	
	/**
	 * 장비관리목록
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/equipment_manage_list")
	public String equipment_manage_list(Model model, HttpSession session, HttpServletRequest request) {
		String sUrl = "";
		
		logger.info("======= equipment_manage_list =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		//탭타입		
		String viewType = request.getParameter("viewType") != null ? request.getParameter("viewType") : "Total";			//종구분
		
		//엑셀다운로드 여부
		String doExcelDown = request.getParameter("doExcelDown") != null ? request.getParameter("doExcelDown") : "";			//종구분
						
		//검색용 파라미터		
		String srchGubunMain = request.getParameter("srchGubunMain") != null ? request.getParameter("srchGubunMain") : "9";			//종구분
		String srchEqTypeMain = request.getParameter("srchEqTypeMain") != null ? request.getParameter("srchEqTypeMain") : "0";			//장비종류
		String tmSearchMain = request.getParameter("tmSearchMain") != null ? request.getParameter("tmSearchMain") : "";					//부서명
		String srchEqStateMain = request.getParameter("srchEqStateMain") != null ? request.getParameter("srchEqStateMain") : "0";		//장비상태
		String srchUserNoMain = request.getParameter("srchUserNoMain") != null ? request.getParameter("srchUserNoMain") : "";		//사번
		String srchEqNoMain = request.getParameter("srchEqNoMain") != null ? request.getParameter("srchEqNoMain") : "";		//장비일련번호
		
		String regSdate = request.getParameter("regSdate") != null ? request.getParameter("regSdate") : "";		//등록 시작일
		String regEdate = request.getParameter("regEdate") != null ? request.getParameter("regEdate") : "";		//등록 종료일		
		String closeSdate = request.getParameter("closeSdate") != null ? request.getParameter("closeSdate") : "";		//폐기 시작일
		String closeEdate = request.getParameter("closeEdate") != null ? request.getParameter("closeEdate") : "";		//폐기 종료일
		
		//정렬기준 파라미터
		String regdate_order_set = request.getParameter("regdate_order_set") != null ? request.getParameter("regdate_order_set") : "";		//등록기준 정렬
		String name_order_set = request.getParameter("name_order_set") != null ? request.getParameter("name_order_set") : "";		//등록기준 정렬
		String team_order_set = request.getParameter("team_order_set") != null ? request.getParameter("team_order_set") : "";		//등록기준 정렬
		
		//삭제 장비 체크
		String del_view_val = request.getParameter("del_view_val") != null ? request.getParameter("del_view_val") : "0";		//삭제장비 보여주기 (0:안보임, 1:보임)
		
		//퇴사자 장비 체크
		String out_view_val = request.getParameter("out_view_val") != null ? request.getParameter("out_view_val") : "0";		//퇴사자 장비 보여주기 (0:안보임, 1:보임)
		
		String srchCpuInfo = request.getParameter("srchCpuInfo") != null ? request.getParameter("srchCpuInfo") : "";			//cpu 종류		
		String srchMemorySizeStart = request.getParameter("srchMemorySizeStart") != null ? request.getParameter("srchMemorySizeStart") : "";			//메모리 시작크기
		String srchMemorySizeEnd = request.getParameter("srchMemorySizeEnd") != null ? request.getParameter("srchMemorySizeEnd") : "";			//메모리 제한크기
		
		//System.out.println("del_view_val List="+del_view_val);
		//System.out.println("regdate_order_set="+regdate_order_set);
		//System.out.println("name_order_set="+name_order_set);
		//System.out.println("team_order_set="+team_order_set);
		
		//String sQueryOrder = "order by GA.reg_date desc";
		//기본은 직원명부와 동일하기 정렬 by top3009
		String sQueryOrder = "ORDER BY  GA.team_group_order DESC, GA.team_order DESC, new_work_order, GA.work_level DESC, GA.work_rank DESC, GA.join_date, GA.user_name DESC";
				
		if( !"".equals(regdate_order_set)) {
			if( "asc".equals(regdate_order_set) ) {
				sQueryOrder = "order by GA.reg_date";
			}else{
				sQueryOrder = "order by GA.reg_date desc";
			}
		}
		
		if( !"".equals(name_order_set)) {
			if( "asc".equals(name_order_set) ) {
				sQueryOrder = "order by GA.user_name";
			}else{
				sQueryOrder = "order by GA.user_name desc";
			}
		}
		
		if( !"".equals(team_order_set)) {
			if( "asc".equals(team_order_set) ) {
				sQueryOrder = "order by GA.team_name";
			}else{
				sQueryOrder = "order by GA.team_name desc";
			}
		}	
		
		//System.out.println("sQueryOrder="+sQueryOrder);
		
		paramMap.put("srchGubunMain", srchGubunMain);
		paramMap.put("tmSearchMain", tmSearchMain);
		paramMap.put("srchEqTypeMain", srchEqTypeMain);
		paramMap.put("srchEqStateMain", srchEqStateMain);
		paramMap.put("srchUserNoMain", srchUserNoMain);
		paramMap.put("srchEqNoMain", srchEqNoMain);
		
		paramMap.put("regSdate", regSdate);		
		paramMap.put("regEdate", regEdate);
		
		paramMap.put("closeSdate", closeSdate);
		paramMap.put("closeEdate", closeEdate);
		
		paramMap.put("srchCpuInfo", srchCpuInfo);
		paramMap.put("srchMemorySizeStart", srchMemorySizeStart);
		paramMap.put("srchMemorySizeEnd", srchMemorySizeEnd);
		
		paramMap.put("del_view_val", del_view_val);
		
		paramMap.put("out_view_val", out_view_val);
		
		paramMap.put("sQueryOrder", sQueryOrder);
		
		List<EquipmentBean> equipmentList = sqlSession.selectList("ItMgmtMapper.selectEquipmentList", paramMap);		//장비목록		
		//int equipmentCnt = sqlSession.selectOne("ItMgmtMapper.selectEquipmentListCnt", paramMap);							//조회된 장비 건수
		
		//model.addAttribute("equipmentCnt", equipmentCnt);		//조회된 장비 건수		
		
		long total_price = 0;
		
		for( int i=0; i < equipmentList.size(); i++ ) {
			total_price += equipmentList.get(i).getEq_price();
		}
		
		model.addAttribute("equipmentList", equipmentList);
		model.addAttribute("total_price", total_price);		
		model.addAttribute("del_view_val", del_view_val);		
		model.addAttribute("out_view_val", out_view_val);
		
		model.addAttribute("viewType", viewType);
		
		//System.out.println("doExcelDown="+doExcelDown);
		
		if("1".equals(doExcelDown)) {
			sUrl = "/sys_adm/equipment_manage_list_excel";
		}else {
			sUrl = "/sys_adm/equipment_manage_list";
		}
				
		return sUrl;
	}
	
	/**
	 * 계약서 종류관리 추가 수정 삭제
	 * param : action = I, U, D
	 * 
	 */	
	@RequestMapping(value="/contractCodeAction")
    @ResponseBody
    public int contractCodeAction(HttpServletRequest request, Model model, HttpSession session, MultipartFile attath_file) {
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
				
		//action : I(추가), U(업데이트)
		String sAction = paramMap.get("action").toString();
		
		logger.info("======= contractCodeAction : "+ sAction +" =======");
				
    	int nCnt = 0;
    	
    	//CommonUtils.printMap(paramMap);
    	
    	if( "I".equals(sAction) ) {
    		nCnt = sqlSession.insert("ItMgmtMapper.insertContractCode", paramMap);  		
    	}else if( "U".equals(sAction) ) {
    		nCnt = sqlSession.update("ItMgmtMapper.updateContractCode", paramMap);
    	}else if("D".equals(sAction) ) {    		
    		nCnt = sqlSession.delete("ItMgmtMapper.deleteContractCode", paramMap);
    	}
    	
    	return nCnt; 
	}
	
	/**
	 * 계약서 지점구분 메인
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/contract_area_list")
	public String contract_area_list(Model model, HttpSession session, HttpServletRequest request) {
		
		String sUrl = "/sys_adm/contract_area_list";
				
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		//탭타입
		String viewType = request.getParameter("viewType") != null ? request.getParameter("viewType") : "cArea";			//종구분
		
		model.addAttribute("viewType", viewType);
		model.addAttribute("srchParam",paramMap);
		
		return sUrl;
	}
	
	/**
	 * 게약관리 메인	
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/contract_main_list")
	public String contract_main_list(Model model, HttpSession session, HttpServletRequest request) {
		
		String sUrl = "/sys_adm/contract_main_list";
				
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		//탭타입
		String viewType = request.getParameter("viewType") != null ? request.getParameter("viewType") : "cMain";
		
		//검색할 선택상자
		//계약서 조회 권한 체크
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
		
		//권한 : 1:1종, 4:4종, 5: 전체조회, 9 : 관리자
		String sContractAuth = mbrAuthVo.getMbr_pms_37().toString();
		
		//계약서 종류 가져오기
		//paramMap.put("is_del", "0");		//사용안함 제외		
		paramMap.put("code_type", "c_type");			//계약서 종류 (기존 등록된 계약건 조회를 위해 사용안하는 상태값도 가져온다.)
		List<Map<String, Object>> srchConTypeList = sqlSession.selectList("ItMgmtMapper.selectContractCode",paramMap);
		paramMap.put("code_type", "c_area");			//지점 종류
		List<Map<String, Object>> srchConAreaList = sqlSession.selectList("ItMgmtMapper.selectContractCode",paramMap);
		
		model.addAttribute("srchConTypeList",srchConTypeList);
		model.addAttribute("srchConAreaList",srchConAreaList);
		model.addAttribute("sContractAuth",sContractAuth);
		
		model.addAttribute("viewType", viewType);
		model.addAttribute("srchParam",paramMap);
		
		return sUrl;
	}
	
	/**
	 * 계약서 첨부파일 다운로드
	 * @param request (tkey)
	 * @param response
	 */
	@RequestMapping(value = "contractFiledown")
    public void contractFiledown(HttpServletRequest request, HttpServletResponse response){
    	
		logger.info("======= contractFiledown =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		
		Map<String, Object> contractFile = sqlSession.selectOne("ItMgmtMapper.getContractFileInfo", paramMap);

		String origFilename = contractFile.get("file_org_name").toString();
    	String encFilename = contractFile.get("file_enc_name").toString();
    	String file_path = contractFile.get("file_path").toString();    	
    	
		try {
			origFilename = java.net.URLEncoder.encode(origFilename,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		response.setHeader("Content-Disposition","attachment;filename="+origFilename);
		
    	String fullPath = file_path+File.separator+encFilename;
		
		ServletOutputStream sout;
		
		try {
			sout = response.getOutputStream();
			FileInputStream fin = new FileInputStream(fullPath);
			byte[] buf = new byte[1024];
			int size=0;
			while((size=fin.read(buf,0,1024))!=-1){
				sout.write(buf,0,size);
			}
			sout.flush();
			fin.close();
			sout.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
	
	/**
     * 계약서 정보 수정하기 Modal
     */
    @RequestMapping(value="/contractEditModal")
    public String contractEditModal(HttpServletRequest request, Model model) {
    	
    	logger.info("========= contractEditModal =========");
    	
    	String sUrl = "sys_adm/contract_main_edit_modal";
    	
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		    	
    	String tkey = paramMap.get("tkey").toString();    	
    	
    	//CommonUtils.printMap(paramMap);
    	
    	//계약서 조회 권한 체크
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
		
		//권한 : 1:1종, 4:4종, 5: 전체조회, 9 : 관리자
		String sContractAuth = mbrAuthVo.getMbr_pms_37().toString();
		
		//계약서 종류 가져오기
		paramMap.put("is_del", "0");		//사용안함 제외		
		paramMap.put("code_type", "c_type");			//계약서 종류
		List<Map<String, Object>> conTypeList = sqlSession.selectList("ItMgmtMapper.selectContractCode",paramMap);
		paramMap.put("code_type", "c_area");			//지점 종류
		List<Map<String, Object>> conAreaList = sqlSession.selectList("ItMgmtMapper.selectContractCode",paramMap);
    	
    	Map<String, Object> contractEditMap = sqlSession.selectOne("ItMgmtMapper.getContractDetailInfo", paramMap);
    	
    	List<Map<String, Object>> contractFileList = sqlSession.selectList("ItMgmtMapper.getContractFileList", paramMap);
    	
    	model.addAttribute("conTypeList",conTypeList);
    	model.addAttribute("conAreaList",conAreaList);
    	model.addAttribute("sContractAuth",sContractAuth);
    	model.addAttribute("contractEditMap",contractEditMap);
    	model.addAttribute("contractFileList", contractFileList);
    	return sUrl;
    }
	
	/**
     * 계약서 정보 상세보기 Modal
     */
    @RequestMapping(value="/contractDetailModal")
    public String contractDetailModal(HttpServletRequest request, Model model) {
    	
    	logger.info("========= contractDetailModal =========");
    	
    	String sUrl = "sys_adm/contract_main_detail_modal";
    	
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
    	Map<String, Object> contractMap = sqlSession.selectOne("ItMgmtMapper.getContractDetailInfo", paramMap);
    	
    	List<Map<String, Object>> contractFileList = sqlSession.selectList("ItMgmtMapper.getContractFileList", paramMap);
    	
    	model.addAttribute("contractMap",contractMap);
    	model.addAttribute("contractFileList", contractFileList);
    	return sUrl;
    }
    
    /**
     * 계약 목록 엑셀다운로드
     * @param request
     * @param model
     * @return
     */    
    @RequestMapping(value="/getContractSearchListExcel")
    public String getContractSearchListExcel(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getContractSearchListExcel =========");

    	String sUrl = "sys_adm/contract_main_list_excel";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	//CommonUtils.printMap(paramMap);
    	    	    	
    	// 검색결과 가져오기
    	List<Map<String, Object>> contractListExcel = sqlSession.selectList("ItMgmtMapper.selectContractListExcel",paramMap);
    	
    	model.addAttribute("contractListExcel", contractListExcel);
    	
    	return sUrl;
    }
	
	/**
     * 계약 목록 가져오기
     * @param request
     * @param model
     * @return
     */    
    @RequestMapping(value="/getContractMainList")
    public String getContractMainList(HttpServletRequest request, Model model) {
    	
    	logger.info("========= getContractMainList =========");

    	String sUrl = "sys_adm/contract_main_list_ajax";
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	//===============================================
    	// 페이지 관련 변수 선언
    	//===============================================
    	int sizePerPage = 20;       // 한페이지당 보여줄 글 갯수
    	int sizePerBlock = 10;      // 페이지당 보여줄 블럭 갯수
    	int currentPage = 0;        // 현재 페이지
    	int limitPage = 0;          // sql limit

    	//===============================================
    	// 현재 페이지 세팅
    	//===============================================
    	String pageIdx = StringUtil.null2blank((String)paramMap.get("pageIdx"));        

    	if("".equals(pageIdx)){
    	    currentPage = 0;
    	    limitPage = 0;
    	}else{
    	    currentPage = (Integer.parseInt(pageIdx) - 1);
    	    limitPage = ((Integer.parseInt(pageIdx) - 1) * sizePerPage);
    	}
    	paramMap.put("sizePerPage", sizePerPage);
    	paramMap.put("limitPage", limitPage);
    	
    	// 검색결과 가져오기
    	List<Map<String, Object>> contractListSearch = sqlSession.selectList("ItMgmtMapper.selectContractListSearch",paramMap);
    	
    	// 검색결과 갯수
    	int contractListSearchCnt = sqlSession.selectOne("ItMgmtMapper.selectContractListSearchCnt",paramMap);
    	
    	//===============================================
    	// 뷰단 데이터 세팅
    	//===============================================
    	PaginationInfo pageInfo = new PaginationInfo();			
    	pageInfo.setRecordCountPerPage(sizePerPage);           		 	// 한페이지당 보여줄 글 갯수
    	pageInfo.setPageSize(sizePerBlock);                    			// 페이지 리스트 에 보여줄 불럭 갯수
    	pageInfo.setCurrentPageNo(currentPage + 1);             		// index 가 0 부터 시작 해서 플러스 1해줌
    	pageInfo.setTotalRecordCount(contractListSearchCnt);   				// 총 글 갯수    	
    	
    	model.addAttribute("contractListSearch", contractListSearch);
    	model.addAttribute("contractListSearchCnt", contractListSearchCnt);    	
    	
    	//CommonUtils.printMap(paramMap);
    	
    	model.addAttribute("pageInfo", pageInfo);
    	
    	int topNum = 0;			//목록 최상위 인덱스
    	
    	topNum = contractListSearchCnt - limitPage;
    	model.addAttribute("topNum", topNum);
    	
    	//CommonUtils.printMap(paramMap);
    	
    	return sUrl;
    }
	
	/**
	 * 계약서 종류 메인
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/contract_type_list")
	public String contract_type_list(Model model, HttpSession session, HttpServletRequest request) {
		
		String sUrl = "/sys_adm/contract_type_list";
				
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		//탭타입
		String viewType = request.getParameter("viewType") != null ? request.getParameter("viewType") : "ctype";			//종구분
		
		model.addAttribute("viewType", viewType);
		model.addAttribute("srchParam",paramMap);
		
		return sUrl;
	}
	
	/**
	 * 지점 구분 정보 가져오기
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getContractArea")
	public String getContractArea(Model model, HttpSession session, HttpServletRequest request) {
		
		String sUrl = "/sys_adm/contract_area_list_ajax";
				
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		paramMap.put("code_type", "c_area");
		
		//CommonUtils.printMap(paramMap);
		
		List<Map<String, Object>> contractAreaList = sqlSession.selectList("ItMgmtMapper.selectContractCode", paramMap);
		
		model.addAttribute("contractAreaList", contractAreaList);
		
		return sUrl;
	}
	
	/**
	 * 계약서 종류 정보 가져오기
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getContractType")
	public String getContractType(Model model, HttpSession session, HttpServletRequest request) {
		
		String sUrl = "/sys_adm/contract_type_list_ajax";
				
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		paramMap.put("code_type", "c_type");
		
		//CommonUtils.printMap(paramMap);
		
		List<Map<String, Object>> contractTypeList = sqlSession.selectList("ItMgmtMapper.selectContractCode", paramMap);
		
		model.addAttribute("contractTypeList", contractTypeList);
		
		return sUrl;
	}
	
	
	@RequestMapping(value = "/contract_manage_index")
	public String contract_manage_index(Model model, HttpSession session, HttpServletRequest request) {
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		//권한
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
		
		//권한 : 1:1종, 4:4종, 5: 전체조회, 9 : 관리자
		String sContractAuth = mbrAuthVo.getMbr_pms_37().toString();
		
		//String sUrl = "/sys_adm/equipment_manage_main_view";
		String sUrl = "/sys_adm/contract_manage_index";
				
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		//탭타입		
		String viewType = request.getParameter("viewType") != null ? request.getParameter("viewType") : "list";			//탭구분
		
		model.addAttribute("viewType", viewType);
		model.addAttribute("srchParam",paramMap);
		
		return sUrl;
	}
	
	/**
	 * 관리자 기준 분기별 직원 성과급 스케줄러 목록 엑셀 다운로드
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/schBonusMemberQuarterListExcel")
	public String schBonusMemberQuarterListExcel(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= schBonusMemberQuarterListExcel =======");
		
		String sUrl = "/sys_adm/sch_bonus_member_quarter_list_excel";
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
		List<Map<String, Object>> memberList = sqlSession.selectList("ItMgmtMapper.selectSchBonusMemberQuarterListSearch", paramMap);
		
		model.addAttribute("memberList", memberList);
		
		return sUrl;
	}
	
	/**
	 * 팀 기준 분기별 성과급 스케줄러 목록 엑셀 다운로드
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/schBonusTeamQuarterListExcel")
	public String schBonusTeamQuarterListExcel(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= schBonusTeamQuarterListExcel =======");
		
		String sUrl = "/sys_adm/sch_bonus_team_quarter_list_excel";
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
		List<Map<String, Object>> memberList = sqlSession.selectList("ItMgmtMapper.selectSchBonusTeamQuarterListSearch", paramMap);
		
		model.addAttribute("memberList", memberList);
		
		return sUrl;
	}
	
	/**
	 * 팀 기준 성과급 스케줄러 목록 엑셀 다운로드
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/schBonusTeamListExcel")
	public String schBonusTeamListExcel(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= schBonusTeamListExcel =======");
		
		String sUrl = "/sys_adm/sch_bonus_team_list_excel";
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
		List<Map<String, Object>> memberList = sqlSession.selectList("ItMgmtMapper.selectSchBonusTeamListSearch", paramMap);
		
		model.addAttribute("memberList", memberList);
		
		return sUrl;
	}
	
	/**
	 * 개인기준 성과급 연간 스케줄러 목록 엑셀 다운로드
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/schBonusYearListExcel")
	public String schBonusYearListExcel(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= schBonusYearListExcel =======");
		
		String sUrl = "/sys_adm/sch_bonus_year_list_excel";
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
		List<Map<String, Object>> memberList = sqlSession.selectList("ItMgmtMapper.selectSchBonusListYearSearch", paramMap);
		
		model.addAttribute("memberList", memberList);
		
		return sUrl;
	}
	
	/**
	 * 개인기준 성과급 분기 스케줄러 목록 엑셀 다운로드
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/schBonusListExcel")
	public String schBonusListExcel(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= schBonusListExcel =======");
		
		String sUrl = "/sys_adm/sch_bonus_list_excel";
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
		List<Map<String, Object>> memberList = sqlSession.selectList("ItMgmtMapper.selectSchBonusListSearch", paramMap);
		
		model.addAttribute("memberList", memberList);
		
		return sUrl;
	}
	
	/**
	 * 팀 기준 분기별 스케줄러 정보 수정
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/updateSchTeamQuarterInfoAction")
    @ResponseBody
    public int updateSchTeamQuarterInfoAction(HttpServletRequest request, Model model) {
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//action : I(추가), U(업데이트)
		String sAction = String.valueOf(paramMap.get("actionFlag"));
		
		logger.info("======= updateSchTeamQuarterInfoAction : "+ sAction +" =======");
				
    	int nCnt = 0;    	
    	
    	if( "U".equals(sAction) ) {
    		nCnt = sqlSession.update("ItMgmtMapper.updateSchBonusTeamQuarterInfoBySkey", paramMap);
    	}    	
    	
    	return nCnt; 
	}
	
	@RequestMapping(value="/updateBonusManagerInfoActionCal")
    @ResponseBody
    public Map<String, Object> updateBonusManagerInfoActionCal(HttpServletRequest request, Model model) {
		
		Map<String, Object> returnMap = new HashMap<>();
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//action : I(추가), U(업데이트)
		int nCnt = 0;
		String sAction = String.valueOf(paramMap.get("actionFlag"));
		String sMkey = String.valueOf(paramMap.get("editMkey"));
		String sDate = String.valueOf(paramMap.get("editSDate"));					//실적계산 시작일자 (입사일에 따라 변경될수 있음)
		String sOrgSdate = String.valueOf(paramMap.get("editSDate"));			//모달 창에 입력한 시작일자
		String eDate = String.valueOf(paramMap.get("editEDate"));
		
		logger.info("======= updateBonusManagerInfoActionCal : "+ sAction +" =======");
		
		paramMap.put("mkey", sMkey);
				
		Map<String, Object> infoMap = sqlSession.selectOne("ItMgmtMapper.selectBonusManagerInfoByMkey", paramMap);
		
		String sUserName = String.valueOf(infoMap.get("manager_name"));
		String sUserNo = String.valueOf(infoMap.get("manager_no"));
		
		//수정해야 할 데이터 계산 시작
		int nBasicAmtSum = 0;		//실적합계 ( 기본료 합계 = 일반보고서 본인담당건 - 공동수행 지급 + 공동 수행 수령 + 농작물 실적) : bonus_pay
		
		double dWorkday = 0;					//실적계산용 근무일 (workday_cnt)		
		double dWorkdayInterval = 0;		//기준일 (workday_interval)
		int nWorkdayPer = 0;					//근무율 퍼센트 (workday_per)
		
		double dWorkload_target = 0;			//환산목표건수 (workload_target)
    	double dWorkload_cnt = 0;				//개인 실적건수 (workload_cnt)
    	double dWorkload_per = 0;				//개인 기준업무량 달성율 (workload_per)
    	String sCalWorkloadSum = "";			//개인 기준업무량 합산값
    	double workload_cnt_temp = 0;			//개인 기준업무량 음수체크값    	
    	int nTargetCnt = 0;							//연간 목표건수 
    	
    	String sWorkSdate = String.valueOf(infoMap.get("work_sdate"));    	
    	
    	int nChkWork = 0;			//실적계산 시작일 체크    	
    	nChkWork = DateUtil.compareDate(sDate, sWorkSdate);    	
    	
    	if( nChkWork > 0 ) {						//시작 기준일보다 실적 시작일이 이후 인경우 실적 시작일 기준으로 계산한다. 
    		sDate = sWorkSdate;
    	}
    	
    	nChkWork = DateUtil.compareDate(eDate, sWorkSdate);
    	
    	if( nChkWork > 0 ) {						//실적 시작일이 종료기준일보다 이후 인경우 실적계산용 근무일을 0으로 처리한다.
    		dWorkday = 0;
    	}else if( DateUtil.compareDate(sDate, sWorkSdate) > 0 && nChkWork <= 0 ) {			//실적 시작일이 모달 입력창 시작일과 종료일 사이에 있는경우
    		dWorkday = DateUtil.getDiffDayCountNew(sWorkSdate, eDate)+1;
    	}else{
    		dWorkday = DateUtil.getDiffDayCountNew(sDate, eDate)+1;
    	}
    	
    	//근무일, 목표일, 근무율은 실적기준일 기준으로 재계산한다.
    	dWorkdayInterval = DateUtil.getDiffDayCountNew(sDate, eDate)+1;			//근무기준일이나 근무일은 실적과 상관없으므로 모달창 기준으로 계산한다.
    	
    	if( dWorkdayInterval < 0 ) {
    		dWorkdayInterval = 0;
    	}
    	
		//dWorkdayOrg = dWorkdayInterval;        	
    	nWorkdayPer = 100;
    	
    	//휴직 처리 시작
    	
    	int nWorkChk = 0;							//기간 내 휴직 체크변수
    	double dCalSum = 0;						//기간 내 휴직일자 합산값
    	String workSdate = "";						//기간 내 휴직 시작일
    	String workEdate = "";						//기간 내 휴직 종료일
    	String calSdate = "";						//휴직계산 시작일
    	String calEdate = "";						//휴직계산 종료일
    	
    	String remakeSdate = "";					//재계산 시작기준일
    	String remakeEdate = "";					//재계산 종료기준일
    	
    	Map<String, Object> workMap = new HashMap<>();    	
		workMap.put("sDate", sDate);
		workMap.put("eDate", eDate);
		workMap.put("user_no", sUserNo);		
    	
    	List<Map<String, Object>> workList = sqlSession.selectList("SuimSchedule.SchBonusWorkListByReverse", workMap);
    	
    	nWorkChk = workList.size();    	

    	if( nWorkChk == 0 ) {					//휴직이 없는 경우(기준일과 근무일이 동일하고 근무율을 100%)
    		dWorkday = dWorkdayInterval;
    		
    		if( dWorkday < 0 ) {
    			nWorkdayPer = 0;
    		}else {
    			nWorkdayPer = 100;
    		}
    	}else{										//기간중 휴직이 있는 경우
    		
    		int nChk = 0;
    		dCalSum = 0;		//휴직일 합계값 초기화
    		
    		remakeSdate = sDate;
    		remakeEdate = eDate;    		
    		
    		for( int r=0; r < workList.size(); r++) {
    			workSdate = String.valueOf(workList.get(r).get("work_sdate"));
    			workEdate = String.valueOf(workList.get(r).get("work_edate"));
    			
    			//휴직 시작일계산
    			nChk = DateUtil.compareDate(remakeSdate, workSdate);
    			
    			if( nChk > 0 ) {					//휴직일자가 실적시작일 이후 인 경우
    				calSdate = workSdate;
    			}else{
    				calSdate = remakeSdate;
    			}
    			
    			//휴직 종료일 계산
    			nChk = DateUtil.compareDate(remakeEdate, workEdate);
    			
    			if( nChk > 0 ) {		//휴직종료날짜가 실적종료일 이후인경우
    				calEdate = remakeEdate;    						
    			}else{
    				calEdate = workEdate;
    			}
    			
    			dCalSum += DateUtil.getDiffDayCountNew(calSdate, calEdate)+1;    					
    		}
    		
    		dWorkday = dWorkdayInterval - dCalSum;			//근무일 (기준근무일 - 휴직일 합계) 계산 끝
    		
    		if( dWorkday < 1) {									//근무일이 없는경우
    			dWorkday = 0;
    			nWorkdayPer = 0;
    		}else{
    			nWorkdayPer = (int) Math.round( dWorkday / dWorkdayInterval * 100 );
    		}
    	}    	
    	//휴직 처리 끝    	
    	
		//dWorkdayInterval = DateUtil.getDiffDayCountNew(sOrgSdate, eDate)+1;			//근무기준일이나 근무일은 실적과 상관없으므로 모달창 기준으로 계산한다.
		//dWorkdayOrg = dWorkdayInterval;        	
    	//nWorkdayPer = 100;
    	//근무일 목표일 
    	
		//기준업무량 목표건 시작
    	
    	String sWorkJob = String.valueOf(infoMap.get("work_job"));
    	String sBaseYear = String.valueOf(infoMap.get("base_year"));
		String sJobCodeFull = "workload_job_code_"+sBaseYear;
    	
		workMap.put("base_year", sBaseYear);
		workMap.put("work_job", sWorkJob);
		workMap.put("job_code_full", sJobCodeFull);    			
		
		nTargetCnt = sqlSession.selectOne("SuimSchedule.selectWorkTargetByWorkjob", workMap);
		
		int nYearDays = 365;				//윤년계산으로 인해 날짜수 변수처리
		nYearDays = DateUtil.getYearToDays(sBaseYear);
		
		if( nTargetCnt > 0 && dWorkday > 0 ) {			//연간 목표건수가 있는 경우 일할 계산한다.
			//기준업무량 환산용 목표건 설정 yearEa
			workMap.put("yearEa", nTargetCnt);
			
			dWorkload_target = Double.parseDouble(String.valueOf(nTargetCnt));
			dWorkload_target = (dWorkload_target * dWorkday) / nYearDays;
			dWorkload_target = (Math.round(dWorkload_target * 1000) / 1000.000);
		}else{
			dWorkload_target = 0;
		}
		//기준업무량 목표건 끝
		
		//기준업무량 실적 시작		
		
		workMap.put("sDate", sDate);
		workMap.put("eDate", eDate);
		workMap.put("user_no", sUserNo);
		
		sCalWorkloadSum = sqlSession.selectOne("SuimSchedule.schWorkloadEaAllQuarter", workMap);
		
		workload_cnt_temp = Double.parseDouble(sCalWorkloadSum);
		
		if( workload_cnt_temp < 0 ) {
			sCalWorkloadSum = "0";
		}
		
		dWorkload_cnt = Double.parseDouble(sCalWorkloadSum);    			
		//기준업무량 실적 끝
		
		//기준업무량 달성율 시작
		if( dWorkload_target > 0 &&  dWorkload_cnt > 0) {			//기준값과 실적값이 존재하는 경우만 계산한다.
			dWorkload_per = (dWorkload_cnt * 100) / dWorkload_target;
			dWorkload_per = (Math.round(dWorkload_per * 10000) / 10000.0000);		//달성율(소숫점4자리)
		}else{
			dWorkload_per = 0;
		}
		//기준업무량 달성율 끝
		
		//실적 계산
		nBasicAmtSum = sqlSession.selectOne("SuimSchedule.schBonusPayAllQuarter", workMap);
		
		//갱신할 정보 Map
		infoMap.put("sdate", sOrgSdate);
		infoMap.put("edate", eDate);
		
		//infoMap.put("workday_cnt", dWorkdayOrg);
		
		infoMap.put("workday_cnt", dWorkday);						//실적 근무일 기준으로 재계산
		infoMap.put("workday_interval", dWorkdayInterval);
		infoMap.put("workday_per", nWorkdayPer);
		
		infoMap.put("workload_target", dWorkload_target);
		infoMap.put("workload_cnt", dWorkload_cnt);
		infoMap.put("workload_per", dWorkload_per);
		
		infoMap.put("bonus_pay", nBasicAmtSum);
		
    	//CommonUtils.printMap(infoMap);
    	
    	if( "U".equals(sAction) ) {    		
    		nCnt = sqlSession.update("ItMgmtMapper.updateBonusManagerInfoByMkey", infoMap);
    	}
    	
    	returnMap.put("mkey", sMkey);
    	returnMap.put("manager_name", sUserName);
    	returnMap.put("result", nCnt);
    	
    	return returnMap; 
	}
	
	/**
	 * 팀 기준 스케줄러 정보 수정
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/updateSchTeamInfoAction")
    @ResponseBody
    public int updateSchTeamInfoAction(HttpServletRequest request, Model model) {
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//action : I(추가), U(업데이트)
		String sAction = String.valueOf(paramMap.get("actionFlag"));
		
		logger.info("======= updateSchTeamInfoAction : "+ sAction +" =======");
				
    	int nCnt = 0;    	
    	
    	if( "U".equals(sAction) ) {
    		nCnt = sqlSession.update("ItMgmtMapper.updateSchBonusTeamInfoBySkey", paramMap);
    	}    	
    	
    	return nCnt; 
	}
	
	/**
	 * 개인기준 연간 스케줄러 정보 수정
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/updateSchYearInfoAction")
    @ResponseBody
    public int updateSchYearInfoAction(HttpServletRequest request, Model model) {
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//action : I(추가), U(업데이트)
		String sAction = String.valueOf(paramMap.get("actionFlag"));
		
		logger.info("======= updateSchYearInfoAction : "+ sAction +" =======");
				
    	int nCnt = 0;    	
    	
    	if( "U".equals(sAction) ) {
    		nCnt = sqlSession.update("ItMgmtMapper.updateSchBonusYearInfoBySkey", paramMap);
    	}    	
    	
    	return nCnt; 
	}
	
	/**
	 * 개인기준 분기 스케줄러 정보 수정
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/updateSchInfoAction")
    @ResponseBody
    public int updateSchInfoAction(HttpServletRequest request, Model model) {
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//action : I(추가), U(업데이트)
		String sAction = String.valueOf(paramMap.get("actionFlag"));
		
		logger.info("======= updateSchInfoAction : "+ sAction +" =======");
				
    	int nCnt = 0;    	
    	
    	if( "U".equals(sAction) ) {
    		nCnt = sqlSession.update("ItMgmtMapper.updateSchBonusInfoBySkey", paramMap);
    	}    	
    	
    	return nCnt; 
	}
	
	@RequestMapping(value = "schUpdateTeamQuarterModal")
	public String schUpdateTeamQuarterModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= schUpdateTeamQuarterModal =======");
						
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);		
		
		Map<String, Object> schInfoMap = sqlSession.selectOne("ItMgmtMapper.selectSchBonusTeamQuarterInfoBySkey", paramMap);
		
		model.addAttribute("schInfoMap", schInfoMap);
		
		return "/sys_adm/sch_bonus_team_quarter_list_modal";
	}
	
	@RequestMapping(value = "bonusMemberQuarterInfoModal")
	public String bonusMemberQuarterInfoModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= bonusMemberQuarterInfoModal =======");
						
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);		
		
		Map<String, Object> memberInfoMap = sqlSession.selectOne("ItMgmtMapper.selectBonusMemberInfoBySkey",paramMap);
		
		model.addAttribute("memberInfoMap", memberInfoMap);		
		
		return "/sys_adm/sch_bonus_member_quarter_info_modal";
	}
	
	@RequestMapping(value = "modifyBonusManagerQuarterInfoModal")
	public String modifyBonusManagerQuarterInfoModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= modifyBonusManagerQuarterInfoModal =======");
						
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);		
		
		Map<String, Object> managerInfoMap = sqlSession.selectOne("ItMgmtMapper.selectBonusManagerInfoByMkey",paramMap);
		
		//해당 팀으로의 발령일자 가져오기
		String sAppointDateFmt = sqlSession.selectOne("ItMgmtMapper.selectBonusManagerInfoByAppointDate", managerInfoMap);
		
		managerInfoMap.put("appointDateFmt", sAppointDateFmt);
		
		model.addAttribute("managerInfoMap", managerInfoMap);		
		
		return "/sys_adm/sch_bonus_manager_quarter_info_modal";
	}
	
	
	@RequestMapping(value = "schUpdateTeamModal")
	public String schUpdateTeamModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= schUpdateTeamModal =======");
						
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);		
		
		Map<String, Object> schInfoMap = sqlSession.selectOne("ItMgmtMapper.selectSchBonusTeamInfoBySkey", paramMap);
		
		model.addAttribute("schInfoMap", schInfoMap);
		
		return "/sys_adm/sch_bonus_team_list_modal";
	}
	
	@RequestMapping(value = "schUpdateModal")
	public String schUpdateModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= schUpdateModal =======");
						
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);		
		
		Map<String, Object> schInfoMap = sqlSession.selectOne("ItMgmtMapper.selectSchBonusInfoBySkey", paramMap);
		
		model.addAttribute("schInfoMap", schInfoMap);
		
		return "/sys_adm/sch_bonus_list_modal";
	}
	
	@RequestMapping(value = "schUpdateYearModal")
	public String schUpdateYearModal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= schUpdateYearModal =======");
						
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);		
		
		Map<String, Object> schInfoMap = sqlSession.selectOne("ItMgmtMapper.selectSchBonusYearInfoBySkey", paramMap);
		
		model.addAttribute("schInfoMap", schInfoMap);
		
		return "/sys_adm/sch_bonus_list_year_modal";
	}
	
	/*
	 * 분기별 팀(센터)장 설정 목록 엑셀다운로드
	 */
	@RequestMapping(value = "/schBonusManagerListByExcel")
	public String schBonusManagerListByExcel(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= schBonusManagerListByExcel =======");

		String sUrl = "/sys_adm/sch_bonus_manager_list_quarter_excel";
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String sViewType = String.valueOf(paramMap.get("viewType"));
		String sQuarterFlag = String.valueOf(paramMap.get("srchQuarterFlag"));
		
		List<Map<String, Object>> managerList = sqlSession.selectList("ItMgmtMapper.selectSchBonusManagerListQuarterSearch", paramMap);
		
		model.addAttribute("managerList", managerList);
		model.addAttribute("viewType", sViewType);
		model.addAttribute("quarterFlag", sQuarterFlag);
		
		return sUrl;
	}
	
	/*
	 * 분기별 팀(센터)장 설정 목록 가져오기
	 */
	@RequestMapping(value = "/getSchBonusManagerListByQuarterAjax")
	public String getSchBonusManagerListByQuarterAjax(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= getSchBonusManagerListByQuarterAjax =======");		

		String sUrl = "/sys_adm/sch_bonus_manager_list_quarter_ajax";
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		List<Map<String, Object>> managerList = sqlSession.selectList("ItMgmtMapper.selectSchBonusManagerListQuarterSearch", paramMap);
		
		model.addAttribute("managerList", managerList);
		
		return sUrl;
	}	
	
	/*
	 * 관리자 기준 분기별 직원 성과급 스케줄러 목록 가져오기 Ajax
	 */
	@RequestMapping(value = "/getSchBonusMemberQuarterListAjax")
	public String getSchBonusMemberQuarterListAjax(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= getSchBonusMemberQuarterListAjax =======");
		
		String sUrl = "/sys_adm/sch_bonus_member_quarter_list_ajax";
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		

		List<Map<String, Object>> memberList = sqlSession.selectList("ItMgmtMapper.selectSchBonusMemberQuarterListSearch", paramMap);
		
		model.addAttribute("memberList", memberList);
		
		return sUrl;
	}
	
	/*
	 * 팀 기준 분기별 성과급 스케줄러 목록 가져오기 Ajax
	 */
	@RequestMapping(value = "/getSchBonusTeamQuarterListAjax")
	public String getSchBonusTeamQuarterListAjax(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= getSchBonusTeamQuarterListAjax =======");
		
		String sUrl = "/sys_adm/sch_bonus_team_quarter_list_ajax";
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
		List<Map<String, Object>> memberList = sqlSession.selectList("ItMgmtMapper.selectSchBonusTeamQuarterListSearch", paramMap);
		
		model.addAttribute("memberList", memberList);
		
		return sUrl;
	}
	
	/*
	 * 팀 기준 성과급 스케줄러 목록 가져오기 Ajax
	 */
	@RequestMapping(value = "/getSchBonusTeamListAjax")
	public String getSchBonusTeamListAjax(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= getSchBonusTeamListAjax =======");
		
		String sUrl = "/sys_adm/sch_bonus_team_list_ajax";
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
		List<Map<String, Object>> memberList = sqlSession.selectList("ItMgmtMapper.selectSchBonusTeamListSearch", paramMap);
		
		model.addAttribute("memberList", memberList);
		
		return sUrl;
	}
	
	/*
	 * 개인기준 성과급 분기 스케줄러 목록 가져오기 Ajax
	 */
	@RequestMapping(value = "/getSchBonusListAjax")
	public String getSchBonusListAjax(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= getSchBonusListAjax =======");
		
		String sUrl = "/sys_adm/sch_bonus_list_ajax";
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
		List<Map<String, Object>> memberList = sqlSession.selectList("ItMgmtMapper.selectSchBonusListSearch", paramMap);
		
		model.addAttribute("memberList", memberList);
		
		return sUrl;
	}
	
	/*
	 * 개인기준 성과급 연간 스케줄러 목록 가져오기 Ajax
	 */
	@RequestMapping(value = "/getSchBonusListYearAjax")
	public String getSchBonusListYearAjax(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= getSchBonusListYearAjax =======");
		
		String sUrl = "/sys_adm/sch_bonus_list_year_ajax";
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
		//연간기준 스케줄러
		List<Map<String, Object>> memberList = sqlSession.selectList("ItMgmtMapper.selectSchBonusListYearSearch", paramMap);
		
		model.addAttribute("memberList", memberList);
		
		return sUrl;
	}
	
	/**
	 * 성과급 직원별 년간 목표 추가
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/insertBonusMemberTargetVal", method = RequestMethod.POST)
	public int insertBonusMemberTargetVal(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("==== insertBonusMemberTargetVal ==== ");
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
        int uptCnt = sqlSession.insert("ItMgmtMapper.insertMemberTargetVal",paramMap);
        
		return uptCnt;		
	}
	
	/**
	 * 성과급 직원별 년간 목표 수정
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/updateBonusMemberTargetVal", method = RequestMethod.POST)
	public int updateBonusMemberTargetVal(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("==== updateBonusMemberTargetVal ==== ");
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
        int uptCnt = sqlSession.update("ItMgmtMapper.updateMemberTargetVal",paramMap);
        
		return uptCnt;		
	}
	
	/**
	 * 직원별 성과급 조회 상태값 수정
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/updateBonusMemberState", method = RequestMethod.POST)
	public int updateBonusMemberState(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("==== updateBonusMemberState ==== ");
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
        int uptCnt = sqlSession.update("ItMgmtMapper.updateMemberBonusState",paramMap);
        
		return uptCnt;		
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/deleteBonusManagerQuarterInfo", method = RequestMethod.POST)
	public int deleteBonusManagerQuarterInfo(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("==== deleteBonusManagerQuarterInfo ==== ");
		
		int nRet = 0;
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String mkey = String.valueOf(paramMap.get("mkey"));
		
		nRet = sqlSession.delete("ItMgmtMapper.deleteBonusManagerInfoByQuarter", mkey);
		
		return nRet;
	}
	
	/** 
	 * 팀(센터)장 내 구성원 실적 계산 수동 스케줄러 실행
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/doSchBonusQuarterMemberCal", method = RequestMethod.POST)
	public Map<String, Object> doSchBonusQuarterMemberCal(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("==== doSchBonusQuarterMemberCal ==== ");
		
		Map<String, Object> returnMap = new HashMap<>();
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        //기준일자
        String sToday = DateUtil.getTodayString("yyyy-MM-dd");		//오늘 날짜(시스템에서 실행되는 날짜)
    	String sBaseDate = DateUtil.addDateNew(sToday, -1);			//어제 날짜(보고서 정산날짜)
    	String sBaseYear = DateUtil.getBaseYear(sBaseDate);			//기준년도    	
    	
    	//기준연도 분기별 팀(센터)장 목록을 불러온다.
    	paramMap.put("base_year", sBaseYear);
    	List<Map<String, Object>> managerList = sqlSession.selectList("ItMgmtMapper.selectSchBonusManagerListQuarterSearchByBaseYear", paramMap);    	
    	
    	//등록된 팀(센터)장 갱신 시작
    	String sMkey = "";
    	String sDate = "";
    	String eDate = "";
    	String sManagerName = "";
    	String sManagerNo = "";
    	
    	int nManagerUpdateCnt = 0;
    	
    	for(int m=0; m < managerList.size(); m++) {
    		
    		sMkey = String.valueOf(managerList.get(m).get("mkey"));
    		sDate = String.valueOf(managerList.get(m).get("sdate_fmt"));
    		eDate = String.valueOf(managerList.get(m).get("edate_fmt"));
    		sManagerName = String.valueOf(managerList.get(m).get("manager_name"));
    		sManagerNo = String.valueOf(managerList.get(m).get("manager_no"));
    		
    		paramMap.put("mkey", sMkey);
			
    		Map<String, Object> infoMap = sqlSession.selectOne("ItMgmtMapper.selectBonusManagerInfoByMkey", paramMap);
    		
    		String sUserName = String.valueOf(infoMap.get("manager_name"));
    		String sUserNo = String.valueOf(infoMap.get("manager_no"));
    		
    		//수정해야 할 데이터 계산 시작
    		int nBasicAmtSum = 0;		//실적합계 ( 기본료 합계 = 일반보고서 본인담당건 - 공동수행 지급 + 공동 수행 수령 + 농작물 실적) : bonus_pay
    		
    		double dWorkday = 0;					//실적계산용 근무일 (workday_cnt)		
    		double dWorkdayInterval = 0;		//기준일 (workday_interval)
    		int nWorkdayPer = 0;					//근무율 퍼센트 (workday_per)
    		
    		double dWorkload_target = 0;			//환산목표건수 (workload_target)
        	double dWorkload_cnt = 0;				//개인 실적건수 (workload_cnt)
        	double dWorkload_per = 0;				//개인 기준업무량 달성율 (workload_per)
        	String sCalWorkloadSum = "";			//개인 기준업무량 합산값
        	double workload_cnt_temp = 0;			//개인 기준업무량 음수체크값    	
        	int nTargetCnt = 0;							//연간 목표건수 
        	
        	String sWorkSdate = String.valueOf(infoMap.get("work_sdate"));    	
        	
        	int nChkWork = 0;			//실적계산 시작일 체크    	
        	nChkWork = DateUtil.compareDate(sDate, sWorkSdate);    	
        	
        	if( nChkWork > 0 ) {						//시작 기준일보다 실적 시작일이 이후 인경우 실적 시작일 기준으로 계산한다. 
        		sDate = sWorkSdate;
        	}
        	
        	nChkWork = DateUtil.compareDate(eDate, sWorkSdate);
        	
        	if( nChkWork > 0 ) {						//실적 시작일이 종료기준일보다 이후 인경우 실적계산용 근무일을 0으로 처리한다.
        		dWorkday = 0;
        	}else if( DateUtil.compareDate(sDate, sWorkSdate) > 0 && nChkWork <= 0 ) {			//실적 시작일이 모달 입력창 시작일과 종료일 사이에 있는경우
        		dWorkday = DateUtil.getDiffDayCountNew(sWorkSdate, eDate)+1;
        	}else{
        		dWorkday = DateUtil.getDiffDayCountNew(sDate, eDate)+1;
        	}
        	
        	//근무일, 목표일, 근무율은 실적기준일 기준으로 재계산한다.
        	dWorkdayInterval = DateUtil.getDiffDayCountNew(sDate, eDate)+1;			//근무기준일이나 근무일은 실적과 상관없으므로 모달창 기준으로 계산한다.
        	
        	if( dWorkdayInterval < 0 ) {
        		dWorkdayInterval = 0;
        	}
        	
    		//dWorkdayOrg = dWorkdayInterval;        	
        	nWorkdayPer = 100;
        	
        	//휴직 처리 시작
        	
        	int nWorkChk = 0;							//기간 내 휴직 체크변수
        	double dCalSum = 0;						//기간 내 휴직일자 합산값
        	String workSdate = "";						//기간 내 휴직 시작일
        	String workEdate = "";						//기간 내 휴직 종료일
        	String calSdate = "";						//휴직계산 시작일
        	String calEdate = "";						//휴직계산 종료일
        	
        	String remakeSdate = "";					//재계산 시작기준일
        	String remakeEdate = "";					//재계산 종료기준일
        	
        	Map<String, Object> workMap = new HashMap<>();    	
    		workMap.put("sDate", sDate);
    		workMap.put("eDate", eDate);
    		workMap.put("user_no", sUserNo);		
        	
        	List<Map<String, Object>> workList = sqlSession.selectList("SuimSchedule.SchBonusWorkListByReverse", workMap);
        	
        	nWorkChk = workList.size();    	

        	if( nWorkChk == 0 ) {					//휴직이 없는 경우(기준일과 근무일이 동일하고 근무율을 100%)
        		dWorkday = dWorkdayInterval;
        		
        		if( dWorkday < 0 ) {
        			nWorkdayPer = 0;
        		}else {
        			nWorkdayPer = 100;
        		}
        	}else{										//기간중 휴직이 있는 경우
        		
        		int nChk = 0;
        		dCalSum = 0;		//휴직일 합계값 초기화
        		
        		remakeSdate = sDate;
        		remakeEdate = eDate;    		
        		
        		for( int r=0; r < workList.size(); r++) {
        			workSdate = String.valueOf(workList.get(r).get("work_sdate"));
        			workEdate = String.valueOf(workList.get(r).get("work_edate"));
        			
        			//휴직 시작일계산
        			nChk = DateUtil.compareDate(remakeSdate, workSdate);
        			
        			if( nChk > 0 ) {					//휴직일자가 실적시작일 이후 인 경우
        				calSdate = workSdate;
        			}else{
        				calSdate = remakeSdate;
        			}
        			
        			//휴직 종료일 계산
        			nChk = DateUtil.compareDate(remakeEdate, workEdate);
        			
        			if( nChk > 0 ) {		//휴직종료날짜가 실적종료일 이후인경우
        				calEdate = remakeEdate;    						
        			}else{
        				calEdate = workEdate;
        			}
        			
        			dCalSum += DateUtil.getDiffDayCountNew(calSdate, calEdate)+1;    					
        		}
        		
        		dWorkday = dWorkdayInterval - dCalSum;			//근무일 (기준근무일 - 휴직일 합계) 계산 끝
        		
        		if( dWorkday < 1) {									//근무일이 없는경우
        			dWorkday = 0;
        			nWorkdayPer = 0;
        		}else{
        			nWorkdayPer = (int) Math.round( dWorkday / dWorkdayInterval * 100 );
        		}
        	}    	
        	//휴직 처리 끝    	
        	
    		//dWorkdayInterval = DateUtil.getDiffDayCountNew(sOrgSdate, eDate)+1;			//근무기준일이나 근무일은 실적과 상관없으므로 모달창 기준으로 계산한다.
    		//dWorkdayOrg = dWorkdayInterval;        	
        	//nWorkdayPer = 100;
        	//근무일 목표일 
        	
    		//기준업무량 목표건 시작
        	
        	String sWorkJob = String.valueOf(infoMap.get("work_job"));
        	sBaseYear = String.valueOf(infoMap.get("base_year"));
    		String sJobCodeFull = "workload_job_code_"+sBaseYear;
        	
    		workMap.put("base_year", sBaseYear);
    		workMap.put("work_job", sWorkJob);
    		workMap.put("job_code_full", sJobCodeFull);    			
    		
    		nTargetCnt = sqlSession.selectOne("SuimSchedule.selectWorkTargetByWorkjob", workMap);
    		
    		int nYearDays = 365;				//윤년계산으로 인해 날짜수 변수처리        	
        	nYearDays = DateUtil.getYearToDays(sBaseYear);
    		
    		if( nTargetCnt > 0 && dWorkday > 0 ) {			//연간 목표건수가 있는 경우 일할 계산한다.
    			//기준업무량 환산용 목표건 설정 yearEa
    			workMap.put("yearEa", nTargetCnt);
    			
    			dWorkload_target = Double.parseDouble(String.valueOf(nTargetCnt));
    			dWorkload_target = (dWorkload_target * dWorkday) / nYearDays;
    			dWorkload_target = (Math.round(dWorkload_target * 1000) / 1000.000);
    		}else{
    			dWorkload_target = 0;
    		}
    		//기준업무량 목표건 끝
    		
    		//기준업무량 실적 시작		
    		
    		workMap.put("sDate", sDate);
    		workMap.put("eDate", eDate);
    		workMap.put("user_no", sUserNo);
    		
    		sCalWorkloadSum = sqlSession.selectOne("SuimSchedule.schWorkloadEaAllQuarter", workMap);
    		
    		workload_cnt_temp = Double.parseDouble(sCalWorkloadSum);
    		
    		if( workload_cnt_temp < 0 ) {
    			sCalWorkloadSum = "0";
    		}
    		
    		dWorkload_cnt = Double.parseDouble(sCalWorkloadSum);    			
    		//기준업무량 실적 끝
    		
    		//기준업무량 달성율 시작
    		if( dWorkload_target > 0 &&  dWorkload_cnt > 0) {			//기준값과 실적값이 존재하는 경우만 계산한다.
    			dWorkload_per = (dWorkload_cnt * 100) / dWorkload_target;
    			dWorkload_per = (Math.round(dWorkload_per * 10000) / 10000.0000);		//달성율(소숫점4자리)
    		}else{
    			dWorkload_per = 0;
    		}
    		//기준업무량 달성율 끝
    		
    		//실적 계산
    		nBasicAmtSum = sqlSession.selectOne("SuimSchedule.schBonusPayAllQuarter", workMap);
    		
    		//갱신할 정보 Map
    		infoMap.put("sdate", sDate);
    		infoMap.put("edate", eDate);
    		
    		//infoMap.put("workday_cnt", dWorkdayOrg);
    		
    		infoMap.put("workday_cnt", dWorkday);						//실적 근무일 기준으로 재계산
    		infoMap.put("workday_interval", dWorkdayInterval);
    		infoMap.put("workday_per", nWorkdayPer);
    		
    		infoMap.put("workload_target", dWorkload_target);
    		infoMap.put("workload_cnt", dWorkload_cnt);
    		infoMap.put("workload_per", dWorkload_per);
    		
    		infoMap.put("bonus_pay", nBasicAmtSum);
    		
        	//CommonUtils.printMap(infoMap);
        	  		
        	sqlSession.update("ItMgmtMapper.updateBonusManagerInfoByMkey", infoMap);
        	
        	nManagerUpdateCnt++;
    	}    	
    	//등록된 팀(센터)장 갱신 끝
    	    	
    	
    	String sTeamId = "";			//팀장 팀 아이디
    	String sTeamCenter = "";    	//센터장 센터 아이디
    	String sWorkType = "";			//팀장,센터장(3 : 팀장, 14 : 센터장)
    	String sQuarterFlag = "";		//분기 구분    	
    	String sSdate = "";				//관리자 시작일자
    	String sEdate = "";				//관리자 종료일자
    	String sMemberSdate = "";	//팀원 실적시작일자
    	String sMemberEdate = "";	//팀원 실적종료일자
    	String sMemberUserNo = "";	//팀원 사번
    	String sMemberUserName = "";	//팀원 이름
    	String sMemberWorkJob = "";	//기준업무량 재계산시 workjob
    	String sJobCodeFull = "workload_job_code_"+sBaseYear;
    	
    	int nChkSdate = 0;
    	
    	//실적 재계산시 사용할 변수 시작
    	int nBasicAmtSum = 0;		//실적합계 ( 기본료 합계 = 일반보고서 본인담당건 - 공동수행 지급 + 공동 수행 수령 + 농작물 실적) : bonus_pay		
		double dWorkday = 0;					//실적계산용 근무일 (workday_cnt)
		double dWorkdayOrg = 0;				//모달창 입력된 시작종료일자 근무일
		double dWorkdayInterval = 0;		//기준일 (workday_interval)
		int nWorkdayPer = 0;					//근무율 퍼센트 (workday_per)
		
		double dWorkload_target = 0;			//환산목표건수 (workload_target)
    	double dWorkload_cnt = 0;				//개인 실적건수 (workload_cnt)
    	double dWorkload_per = 0;				//개인 기준업무량 달성율 (workload_per)
    	String sCalWorkloadSum = "";			//개인 기준업무량 합산값
    	double workload_cnt_temp = 0;			//개인 기준업무량 음수체크값    	
    	int nTargetCnt = 0;							//연간 목표건수
    	
    	String remakeSdate = "";					//재계산 시작기준일
    	String remakeEdate = "";					//재계산 종료기준일
    	
    	int nWorkChk = 0;							//기간 내 휴직 체크변수
    	double dCalSum = 0;						//기간 내 휴직일자 합산값
    	String workSdate = "";						//기간 내 휴직 시작일
    	String workEdate = "";						//기간 내 휴직 종료일
    	String calSdate = "";						//휴직계산 시작일
    	String calEdate = "";						//휴직계산 종료일    	
    	//실적 재계산시 사용할 변수 끝
    	
    	//스케줄러 등록시 중복체크
    	int nDupChk = 0;
    	int nInsertCnt = 0;							//등록된 데이터 수
    	
    	//관리자 발령일자
    	String sApDate = "";
    	
        for( int i=0; i < managerList.size(); i++ ) {
        	Map<String,Object> managerMap = managerList.get(i);        	
        	//CommonUtils.printMap(ManagerMap);
        	//기준(정산)일자 추가
        	managerMap.put("base_date", sBaseDate);
        	sManagerNo = String.valueOf(managerList.get(i).get("manager_no"));
        	sManagerName = String.valueOf(managerList.get(i).get("manager_name"));
        	sTeamId = String.valueOf(managerList.get(i).get("team_id"));
        	sTeamCenter = String.valueOf(managerList.get(i).get("team_center"));
        	sWorkType = String.valueOf(managerList.get(i).get("work_type"));        	
        	sQuarterFlag = String.valueOf(managerList.get(i).get("quarter_flag"));        	
        	sSdate = String.valueOf(managerList.get(i).get("sdate_fmt"));
        	sEdate = String.valueOf(managerList.get(i).get("edate_fmt"));
        	sApDate = sqlSession.selectOne("ItMgmtMapper.selectBonusManagerInfoByAppointDate", managerList.get(i));
        	managerMap.put("ap_date_fmt", sApDate);
        	
        	List<Map<String, Object>> memberList = sqlSession.selectList("ItMgmtMapper.selectSchBonusMemberListQuarterByTeamId",managerMap);
        	        	
    		for( int k=0; k < memberList.size(); k++) {    			
    			Map<String, Object> memberMap = memberList.get(k);
    			//관리자 사번,이름을 넣어준다.
    			memberMap.put("manager_no", sManagerNo);
    			memberMap.put("manager_name", sManagerName);
    			
    			//관리자(팀장,센터장)의 시작일자와 팀원의 시작 일자가 동일한지 체크한다.
    			sMemberSdate = String.valueOf(memberList.get(k).get("sdate_fmt"));    			
    			sMemberEdate = String.valueOf(memberList.get(k).get("edate_fmt"));
    			sMemberUserNo = String.valueOf(memberList.get(k).get("user_no"));
    			sMemberUserName = String.valueOf(memberList.get(k).get("user_name"));
    			sMemberWorkJob = String.valueOf(memberList.get(k).get("work_job"));
    			
    			//nChkSdate = DateUtil.compareDate(sMemberSdate, sSdate);
    			//팀장 실적 시작일에서 발령일로 변경
    			nChkSdate = DateUtil.compareDate(sMemberSdate, sApDate);
    			   			
    			if( nChkSdate > 0 ) {				//팀원 실적 시작일보다 팀장의 발령일이 이후인경우
    				//System.out.println("팀장시작일 : "+sApDate + " : "+sManagerNo);
    				//System.out.println("팀원시작일 : "+sMemberSdate);
    				//System.out.println("재계산인원 : "+sMemberUserName+" : "+sQuarterFlag+" 분기 "+sApDate+" ~ "+sMemberEdate);
    				//여기들어오는 인원은 실적 재계산해야함.(oniku)
    				
    				//remakeSdate = sSdate;
    				remakeSdate = sApDate;
    				remakeEdate = sMemberEdate;
    				
    				Map<String, Object> workMap = new HashMap<>();
    				workMap.put("sDate", remakeSdate);
    				workMap.put("eDate", remakeEdate);
    				workMap.put("user_no", sMemberUserNo);
    				workMap.put("base_year", sBaseYear);
    				    				
    				//dWorkdayInterval = DateUtil.getDiffDayCountNew(sSdate, sMemberEdate)+1;			//목표일 계산 끝
    				dWorkdayInterval = DateUtil.getDiffDayCountNew(sApDate, sMemberEdate)+1;			//목표일 계산 끝
    				
    				//휴직 처리시작
    				List<Map<String, Object>> workList = sqlSession.selectList("SuimSchedule.SchBonusWorkList", workMap);

    				nWorkChk = workList.size();

    				if( nWorkChk == 0 ) {					//휴직이 없는 경우(기준일과 근무일이 동일하고 근무율을 100%)
    					dWorkday = dWorkdayInterval;
    					nWorkdayPer = 100;
    				}else{										//기간중 휴직이 있는 경우
    					
    					int nChk = 0;
    					dCalSum = 0;		//휴직일 합계값 초기화
    					
    					for( int r=0; r < workList.size(); r++) {
    						workSdate = String.valueOf(workList.get(r).get("work_sdate"));
    						workEdate = String.valueOf(workList.get(r).get("work_edate"));
    						
    						//휴직 시작일계산
    						nChk = DateUtil.compareDate(remakeSdate, workSdate);
    						
    						if( nChk > 0 ) {					//휴직일자가 실적시작일 이후 인 경우
    							calSdate = workSdate;
    						}else{
    							calSdate = remakeSdate;
    						}
    						
    						//휴직 종료일 계산
    						nChk = DateUtil.compareDate(remakeEdate, workEdate);
    						
    						if( nChk > 0 ) {		//휴직종료날짜가 실적종료일 이후인경우
    							calEdate = remakeEdate;    						
    						}else{
    							calEdate = workEdate;
    						}
    						
    						dCalSum += DateUtil.getDiffDayCountNew(calSdate, calEdate)+1;    					
    					}
    					
    					dWorkday = dWorkdayInterval - dCalSum;			//근무일 (기준근무일 - 휴직일 합계) 계산 끝
    					
    					if( dWorkday < 1) {									//근무일이 없는경우
    						dWorkday = 0;
    						nWorkdayPer = 0;
    					}else{
    						nWorkdayPer = (int) Math.round( dWorkday / dWorkdayInterval * 100 );
    					}
    				}
    				//휴직 처리 끝
    				
    				//기준업무량 목표건 시작    				
    				workMap.put("work_job", sMemberWorkJob);
    				workMap.put("job_code_full", sJobCodeFull);    			

    				nTargetCnt = sqlSession.selectOne("SuimSchedule.selectWorkTargetByWorkjob", workMap);
    				
    				int nYearDays = 365;				//윤년계산으로 인해 날짜수 변수처리    		    	
    		    	nYearDays = DateUtil.getYearToDays(sBaseYear);

    				if( nTargetCnt > 0 && dWorkday > 0 ) {			//연간 목표건수가 있는 경우 일할 계산한다.
    					//기준업무량 환산용 목표건 설정 yearEa
    					workMap.put("yearEa", nTargetCnt);
    					
    					dWorkload_target = Double.parseDouble(String.valueOf(nTargetCnt));
    					dWorkload_target = (dWorkload_target * dWorkday) / nYearDays;
    					dWorkload_target = (Math.round(dWorkload_target * 1000) / 1000.000);
    				}else{
    					dWorkload_target = 0;
    				}    			    			
    				//기준업무량 목표건 끝

    				//기준업무량 실적 시작
    				sCalWorkloadSum = sqlSession.selectOne("SuimSchedule.schWorkloadEaAllQuarter", workMap);

    				workload_cnt_temp = Double.parseDouble(sCalWorkloadSum);

    				if( workload_cnt_temp < 0 ) {
    					sCalWorkloadSum = "0";
    				}

    				dWorkload_cnt = Double.parseDouble(sCalWorkloadSum);    			
    				//기준업무량 실적 끝

    				//기준업무량 달성율 시작
    				if( dWorkload_target > 0 &&  dWorkload_cnt > 0) {			//기준값과 실적값이 존재하는 경우만 계산한다.
    					dWorkload_per = (dWorkload_cnt * 100) / dWorkload_target;
    					dWorkload_per = (Math.round(dWorkload_per * 10000) / 10000.0000);		//달성율(소숫점4자리)
    				}else{
    					dWorkload_per = 0;
    				}
    				//기준업무량 달성율 끝
    				
    				//실적 재계산
    				nBasicAmtSum = sqlSession.selectOne("SuimSchedule.schBonusPayAllQuarter", workMap);
    				
    				//수정된 값으로 memberMap 에 넣어준다.
    				memberMap.put("sdate_fmt", remakeSdate);								//시작일자 수정
    				memberMap.put("workday_interval", (int)dWorkdayInterval);			//목표일
    				memberMap.put("workday_cnt", (int)dWorkday);							//근무일
    				memberMap.put("workday_per", nWorkdayPer);							//근무율    				
    				memberMap.put("workload_target", dWorkload_target);				//기준업무량 목표건
    				memberMap.put("workload_cnt", dWorkload_cnt);						//기준업무량 실적건
    				memberMap.put("workload_per", dWorkload_per);						//기준업무량 달성율
    				memberMap.put("bonus_pay", nBasicAmtSum);							//실적
    				
    				//CommonUtils.printMap(memberMap);
    			}    			
    			
    			//해당일자에 등록된 데이터가 있는지 확인한다.
    			nDupChk = sqlSession.selectOne("ItMgmtMapper.countSchBonusMemberListQuarterByManagerNo", memberMap);
    					
    			//미등록된 직원 실적을 등록한다.
    			if( nDupChk == 0 ) {
    				sqlSession.insert("ItMgmtMapper.insertSchBonusMemberListQuarterByManagerNo", memberMap);
    				nInsertCnt++;
    			}
    			//if( "672".equals(sManagerNo) || "2987".equals(sManagerNo) ) {			//테스트 계정( 672 : 박근홍, 2987 : 최영진, 356 : 이동진 (센터장) )
    			//if( "356".equals(sManagerNo) ) {			//테스트 계정( 672 : 박근홍, 2987 : 최영진, 356 : 이동진 (센터장) )
    				//CommonUtils.printMap(memberMap);
    			//}
    		}        	
        }
		
        returnMap.put("result", nInsertCnt);
        returnMap.put("manager", nManagerUpdateCnt);
        
        return returnMap; 
	}
	
	@ResponseBody
	@RequestMapping(value = "/getBonusManagerQuarterInfo", method = RequestMethod.POST)
	public Map<String, Object> getBonusManagerQuarterInfo(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("==== getBonusManagerQuarterInfo ==== ");
		
		Map<String, Object> returnMap = new HashMap<>();
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        String sToday = DateUtil.getTodayString("yyyy-MM-dd");		//오늘 날짜(시스템에서 실행되는 날짜)
    	String sBaseDate = DateUtil.addDateNew(sToday, -1);			//어제 날짜(보고서 정산날짜)        
        
        String sBaseYear = String.valueOf(paramMap.get("base_year"));
        String sQuarterFlag = String.valueOf(paramMap.get("quarter_flag"));
        String sViewType = String.valueOf(paramMap.get("view_type"));				//Team : 팀장, Center : 센터장
        
        //분기 생성 맵
        Map<String, Object> makeMap = DateUtil.makeQuarterDateMap(sBaseYear, sQuarterFlag);
        
        //분기 시작, 종료일자
        String sDate = String.valueOf(makeMap.get("sDate"));		//분기 시작일자
        String eDate = String.valueOf(makeMap.get("eDate"));		//분기 종료일자
        
        //년도 시작, 종료일자
        String sYearSdate = DateUtil.getStartYearDay(sDate);
        String sYearEdate = DateUtil.getEndYearDay(sDate);
        
        //System.out.println("sViewtype : "+sViewType);
        //System.out.println("sDate : "+sDate);
        //System.out.println("eDate : "+eDate);
        //System.out.println("sYearSdate : "+sYearSdate);
        //System.out.println("sYearEdate : "+sYearEdate);
        
        //년도의 시작, 종료일자 기준으로 퇴사자 포함 팀장 또는 센터장 목록을 불러온다.
        
        paramMap.put("sDate", sDate);
        paramMap.put("eDate", eDate);
        paramMap.put("yearSdate", sYearSdate);
        paramMap.put("yearEdate", sYearEdate);
        
        //base_date : 기준일자가 분기종료일자보다 이후인경우 종료일자를 base_date로 넣어준다.
        int nBaseCnk = DateUtil.compareDate(eDate, sBaseDate);
        
        if( nBaseCnk < 0 ) {
        	paramMap.put("base_date", sBaseDate);
        }else{
        	paramMap.put("base_date", eDate);
        }        
        
        //CommonUtils.printMap(paramMap);        
		String sWorkJob = "";					//기준업무량 코드
		String sJobCodeFull = "workload_job_code_"+sBaseYear;
		int nTargetCnt = 0;		//연간 목표건수
		double dWorkload_target = 0;			//환산목표건수
    	double dWorkload_cnt = 0;				//개인 실적건수 (기간별)
    	double dWorkload_per = 0;				//개인 기준업무량 달성율
    	String sCalWorkloadSum = "";			//개인 기준업무량 합산값
    	double workload_cnt_temp = 0;			//개인 기준업무량 음수체크값
		
    	double dWorkday = 0;					//근무일
    	double dWorkdayInterval = 0;		//기준일    	
    	
		dWorkdayInterval = DateUtil.getDiffDayCountNew(sDate, eDate)+1;				//기준일 (같은날이 0일이므로 1을 더한다)
		dWorkday = dWorkdayInterval;					//기본값은 전체 근무일을 근무한것으로 처리함
		
		//팀장 기본 설정은 분기 전체로 한다. (분기 시작, 종료일)
		paramMap.put("workday_cnt", dWorkdayInterval);
		paramMap.put("workday_interval", dWorkdayInterval);
		paramMap.put("workday_per", "100");
		
		String sUserNo = "";
		int nBasicAmtSum = 0;		//실적합계 ( 기본료 합계 = 일반보고서 본인담당건 - 공동수행 지급 + 공동 수행 수령 + 농작물 실적)
				
		int nDupCnt = 0;
		int nInsertCnt = 0;			//추가된 사용자 수
		
		int nYearDays = 365;				//윤년계산으로 인해 날짜수 변수처리    	
    	nYearDays = DateUtil.getYearToDays(sBaseYear);
		
        List<Map<String, Object>> managerList = sqlSession.selectList("ItMgmtMapper.selectBonusManagerListByQuarter", paramMap);
        
        for( int i = 0; i < managerList.size(); i++ ) {        	
        	
        	//기준업무량 목표건 시작
        	Map<String, Object> workMap = new HashMap<>();
        	
        	sUserNo = String.valueOf(managerList.get(i).get("manager_no"));
			sWorkJob = String.valueOf(managerList.get(i).get("work_job"));
			
			//실적계산을 위한 변수
			workMap.put("user_no", sUserNo);
			workMap.put("work_job", sWorkJob);
			workMap.put("job_code_full", sJobCodeFull);
			workMap.put("base_year", sBaseYear);
			workMap.put("sDate", String.valueOf(managerList.get(i).get("sdate")));
			workMap.put("eDate", String.valueOf(managerList.get(i).get("edate")));			
			
			nTargetCnt = sqlSession.selectOne("SuimSchedule.selectWorkTargetByWorkjob", workMap);
			
			if( nTargetCnt > 0 && dWorkday > 0 ) {			//연간 목표건수가 있는 경우 일할 계산한다.
				//기준업무량 환산용 목표건 설정 yearEa
				workMap.put("yearEa", nTargetCnt);
				
				dWorkload_target = Double.parseDouble(String.valueOf(nTargetCnt));
				dWorkload_target = (dWorkload_target * dWorkday) / nYearDays;
				dWorkload_target = (Math.round(dWorkload_target * 1000) / 1000.000);
			}else{
				dWorkload_target = 0;
			}    			    			
			//기준업무량 목표건 끝
			
			//기준업무량 실적 시작
			sCalWorkloadSum = sqlSession.selectOne("SuimSchedule.schWorkloadEaAllQuarter", workMap);
			
			workload_cnt_temp = Double.parseDouble(sCalWorkloadSum);
			
			if( workload_cnt_temp < 0 ) {
				sCalWorkloadSum = "0";
			}
			
			dWorkload_cnt = Double.parseDouble(sCalWorkloadSum);    			
			//기준업무량 실적 끝
			
			//기준업무량 달성율 시작
			if( dWorkload_target > 0 &&  dWorkload_cnt > 0) {			//기준값과 실적값이 존재하는 경우만 계산한다.
				dWorkload_per = (dWorkload_cnt * 100) / dWorkload_target;
				dWorkload_per = (Math.round(dWorkload_per * 10000) / 10000.0000);		//달성율(소숫점4자리)
			}else{
				dWorkload_per = 0;
			}
			//기준업무량 달성율 끝
			
        	managerList.get(i).put("workload_target", dWorkload_target);        	
			managerList.get(i).put("workload_cnt", dWorkload_cnt);
			managerList.get(i).put("workload_per", dWorkload_per);
			
			nBasicAmtSum = sqlSession.selectOne("SuimSchedule.schBonusPayAllQuarter", workMap);			
			managerList.get(i).put("bonus_pay", nBasicAmtSum);
			
        	Map<String, Object> memberMap = managerList.get(i);
        	//CommonUtils.printMap(memberMap);
        	
        	//중복체크 (기준년도, 분기, 관리자 사번)
        	nDupCnt = sqlSession.selectOne("ItMgmtMapper.countBonusManagerListByQuarter", memberMap);
        	
        	//중복이 아닌경우만 추가한다.
        	if( nDupCnt == 0 ) {
        		sqlSession.insert("ItMgmtMapper.insertBonusManagerInfoByQuarter", memberMap);
        		nInsertCnt++;
        	}
        }
        
        //int nInsertCnt = sqlSession.insert("ItMgmtMapper.insertBonusManagerListByQuarter", managerList);
        
        returnMap.put("result", "success");
        returnMap.put("insertCnt", nInsertCnt);
        
		return returnMap;		
	}
	
	/**
	 * 성과급 신입/경력 설정값 수정
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/updateBonusCareerState", method = RequestMethod.POST)
	public int updateBonusCareerState(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("==== updateBonusCareerState ==== ");
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
        int uptCnt = sqlSession.update("ItMgmtMapper.updateCareerBonusState",paramMap);
        
		return uptCnt;		
	}
	
	/**
	 * 관리자 성과급 조회 상태값 수정
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/updateBonusManagerState", method = RequestMethod.POST)
	public int updateBonusManagerState(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("==== updateBonusManagerState ==== ");
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
        int uptCnt = sqlSession.update("ItMgmtMapper.updateManagerBonusState",paramMap);
        
		return uptCnt;		
	}
	
	/**
	 * 직원별 년간 목표건수 목록 조회
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getBonusMemberYearListAjax")
	public String getBonusMemberBaseYearListAjax(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= getBonusMemberYearListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		

		List<Map<String, Object>> memberList = sqlSession.selectList("ItMgmtMapper.selectBonusYearMemberListSearch", paramMap);
		
		model.addAttribute("memberList", memberList);
		
		return "/sys_adm/bonus_member_year_list_ajax";
	}
	
	/**
	 * 직원별 성과급 설정 목록 조회
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getBonusMemberStatusListAjax")
	public String getBonusMemberStatusListAjax(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= getBonusMemberStatusListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		

		List<Map<String, Object>> memberList = sqlSession.selectList("ItMgmtMapper.selectBonusStatusMemberListSearch", paramMap);
		
		model.addAttribute("memberList", memberList);
		
		return "/sys_adm/bonus_member_status_list_ajax";
	}
	
	/**
	 * 신입/경력 성과급 설정 목록 조회
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getBonusCareerStatusListAjax")
	public String getBonusCareerStatusListAjax(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= getBonusCareerStatusListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		List<Map<String, Object>> careerList = sqlSession.selectList("ItMgmtMapper.selectBonusStatusCareerListSearch", paramMap);
		
		model.addAttribute("careerList", careerList);
		
		return "/sys_adm/bonus_career_status_list_ajax";
	}
	
	/**
	 * 관리자 성과급 설정 목록 조회
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getBonusManagerStatusListAjax")
	public String getBonusManagerStatusListAjax(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= getBonusManagerStatusListAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		List<Map<String, Object>> managerList = sqlSession.selectList("ItMgmtMapper.selectBonusStatusManagerListSearch", paramMap);
		
		model.addAttribute("managerList", managerList);
		
		return "/sys_adm/bonus_manager_status_list_ajax";
	}
	
	/*
	 * 직원별 년간 목표조회 및 수정
	 */
	@RequestMapping(value = "/bonusMemberYearTarget")
	public String bonusMemberYearTarget(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= bonusMemberYearTarget =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("schBonusLogList - no permession user_no : "+mbrVo.getUser_no());
			session.invalidate();
			return "top_login/top_login";
		}				
		
		//검색할 센터목록
    	List<Map<String, Object>> centerList = sqlSession.selectList("ItMgmtMapper.selectCenterList");
    	model.addAttribute("centerList",centerList);
    	
    	//검색할 팀목록
		List<Map<String, Object>> teamList = sqlSession.selectList("ItMgmtMapper.selectTeamList");		
		model.addAttribute("teamList",teamList);
		
		return "/sys_adm/bonus_member_year_target_main";
	}
	
	/*
	 * 직원별 성과급 조회 설정
	 */
	@RequestMapping(value = "/bonusMemberStatus")
	public String bonusMemberStatus(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= bonusMemberStatus =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("schBonusLogList - no permession user_no : "+mbrVo.getUser_no());
			session.invalidate();
			return "top_login/top_login";
		}		
		
		//탭타입		
		String viewType = request.getParameter("viewType") != null ? request.getParameter("viewType") : "Member";			//종구분		
		model.addAttribute("viewType", viewType);		
		
		//검색할 센터목록
    	List<Map<String, Object>> centerList = sqlSession.selectList("ItMgmtMapper.selectCenterList");
    	model.addAttribute("centerList",centerList);
    	
    	//검색할 팀목록
		List<Map<String, Object>> teamList = sqlSession.selectList("ItMgmtMapper.selectTeamList");		
		model.addAttribute("teamList",teamList);
		
		return "/sys_adm/bonus_member_status_main";
	}
	
	/*
	 * (인사) 팀 기준 분기별 성과급 스케줄러 Log 조회
	 */
	@RequestMapping(value = "/schBonusTeamQuarterLogListView")
	public String schBonusTeamQuarterLogListView(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= schBonusTeamQuarterLogListView =======");
				
		String sUrl = "/sys_adm/sch_bonus_team_quarter_main_view";
		
		//검색 기준날짜는 기본 어제날짜로 설정
		String sToday = DateUtil.getTodayString("yyyy-MM-dd");		//오늘 날짜(시스템에서 실행되는 날짜)
    	String sBaseDate = DateUtil.addDateNew(sToday, -1);			//어제 날짜(보고서 정산날짜)
    	model.addAttribute("baseDate",sBaseDate);
    	
    	//검색할 부문목록
    	List<Map<String, Object>> sectorList = sqlSession.selectList("ItMgmtMapper.selectSectorList");
    	model.addAttribute("sectorList",sectorList);
		
    	//검색할 센터목록
    	List<Map<String, Object>> centerList = sqlSession.selectList("ItMgmtMapper.selectCenterList");
    	model.addAttribute("centerList",centerList);
    	
    	//검색할 팀목록
		List<Map<String, Object>> teamList = sqlSession.selectList("ItMgmtMapper.selectTeamList");		
		model.addAttribute("teamList",teamList);
		
		return sUrl;
	}
	
	/**
	 * 분기별 팀(센터)장 설정
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/schBonusManagerQuarterSetup")
	public String schBonusManagerQuarterSetup(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= schBonusManagerQuarterSetup =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("schBonusLogList - no permession user_no : "+mbrVo.getUser_no());
			session.invalidate();
			return "top_login/top_login";
		}
		
		String sUrl = "/sys_adm/sch_bonus_manager_quarter_setup_main";
		
		//검색할 부문목록
    	List<Map<String, Object>> sectorList = sqlSession.selectList("ItMgmtMapper.selectSectorList");
    	model.addAttribute("sectorList",sectorList);
		
    	//검색할 센터목록
    	List<Map<String, Object>> centerList = sqlSession.selectList("ItMgmtMapper.selectCenterList");
    	model.addAttribute("centerList",centerList);
    	
    	//검색할 팀목록
		List<Map<String, Object>> teamList = sqlSession.selectList("ItMgmtMapper.selectTeamList");		
		model.addAttribute("teamList",teamList);		
		
		return sUrl;
	}
	
	/*
	 * 팀(센터)장 기준 성과급 스케줄러 조회
	 */
	@RequestMapping(value = "/schBonusManagerQuarterLogList")
	public String schBonusManagerQuarterLogList(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= schBonusManagerQuarterLogList =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("schBonusLogList - no permession user_no : "+mbrVo.getUser_no());
			session.invalidate();
			return "top_login/top_login";
		}

		String sUrl = "/sys_adm/sch_bonus_manager_quarter_main";
		
		//검색 기준날짜는 기본 어제날짜로 설정
		String sToday = DateUtil.getTodayString("yyyy-MM-dd");		//오늘 날짜(시스템에서 실행되는 날짜)
    	String sBaseDate = DateUtil.addDateNew(sToday, -1);			//어제 날짜(보고서 정산날짜)
    	model.addAttribute("baseDate",sBaseDate);
    	
    	//검색할 부문목록
    	List<Map<String, Object>> sectorList = sqlSession.selectList("ItMgmtMapper.selectSectorList");
    	model.addAttribute("sectorList",sectorList);
		
    	//검색할 센터목록
    	List<Map<String, Object>> centerList = sqlSession.selectList("ItMgmtMapper.selectCenterList");
    	model.addAttribute("centerList",centerList);
    	
    	//검색할 팀목록
		List<Map<String, Object>> teamList = sqlSession.selectList("ItMgmtMapper.selectTeamList");		
		model.addAttribute("teamList",teamList);
		
		return sUrl;
	}
	
	/*
	 * 팀 기준 분기별 성과급 스케줄러 Log 조회
	 */
	@RequestMapping(value = "/schBonusTeamQuarterLogList")
	public String schBonusTeamQuarterLogList(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= schBonusTeamQuarterLogList =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("schBonusLogList - no permession user_no : "+mbrVo.getUser_no());
			session.invalidate();
			return "top_login/top_login";
		}
		
		String sUrl = "/sys_adm/sch_bonus_team_quarter_main";
		
		//검색 기준날짜는 기본 어제날짜로 설정
		String sToday = DateUtil.getTodayString("yyyy-MM-dd");		//오늘 날짜(시스템에서 실행되는 날짜)
    	String sBaseDate = DateUtil.addDateNew(sToday, -1);			//어제 날짜(보고서 정산날짜)
    	model.addAttribute("baseDate",sBaseDate);
    	
    	//검색할 부문목록
    	List<Map<String, Object>> sectorList = sqlSession.selectList("ItMgmtMapper.selectSectorList");
    	model.addAttribute("sectorList",sectorList);
		
    	//검색할 센터목록
    	List<Map<String, Object>> centerList = sqlSession.selectList("ItMgmtMapper.selectCenterList");
    	model.addAttribute("centerList",centerList);
    	
    	//검색할 팀목록
		List<Map<String, Object>> teamList = sqlSession.selectList("ItMgmtMapper.selectTeamList");		
		model.addAttribute("teamList",teamList);
		
		return sUrl;
	}
	
	/*
	 * (인사) 팀 기준 성과급 스케줄러 Log 조회
	 */
	@RequestMapping(value = "/schBonusTeamLogListView")
	public String schBonusTeamLogListView(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= schBonusTeamLogListView =======");
		
		String sUrl = "/sys_adm/sch_bonus_team_main_view";
		
		//검색 기준날짜는 기본 어제날짜로 설정
		String sToday = DateUtil.getTodayString("yyyy-MM-dd");		//오늘 날짜(시스템에서 실행되는 날짜)
    	String sBaseDate = DateUtil.addDateNew(sToday, -1);			//어제 날짜(보고서 정산날짜)
    	model.addAttribute("baseDate",sBaseDate);
    	
    	//검색할 부문목록
    	List<Map<String, Object>> sectorList = sqlSession.selectList("ItMgmtMapper.selectSectorList");
    	model.addAttribute("sectorList",sectorList);
		
    	//검색할 센터목록
    	List<Map<String, Object>> centerList = sqlSession.selectList("ItMgmtMapper.selectCenterList");
    	model.addAttribute("centerList",centerList);
    	
    	//검색할 팀목록
		List<Map<String, Object>> teamList = sqlSession.selectList("ItMgmtMapper.selectTeamList");		
		model.addAttribute("teamList",teamList);
		
		return sUrl;
	}
	
	/*
	 * 팀 기준 성과급 스케줄러 Log 조회
	 */
	@RequestMapping(value = "/schBonusTeamLogList")
	public String schBonusTeamLogList(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= schBonusTeamLogList =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("schBonusLogList - no permession user_no : "+mbrVo.getUser_no());
			session.invalidate();
			return "top_login/top_login";
		}
		
		String sUrl = "/sys_adm/sch_bonus_team_main";
		
		//검색 기준날짜는 기본 어제날짜로 설정
		String sToday = DateUtil.getTodayString("yyyy-MM-dd");		//오늘 날짜(시스템에서 실행되는 날짜)
    	String sBaseDate = DateUtil.addDateNew(sToday, -1);			//어제 날짜(보고서 정산날짜)
    	model.addAttribute("baseDate",sBaseDate);
    	
    	//검색할 부문목록
    	List<Map<String, Object>> sectorList = sqlSession.selectList("ItMgmtMapper.selectSectorList");
    	model.addAttribute("sectorList",sectorList);
		
    	//검색할 센터목록
    	List<Map<String, Object>> centerList = sqlSession.selectList("ItMgmtMapper.selectCenterList");
    	model.addAttribute("centerList",centerList);
    	
    	//검색할 팀목록
		List<Map<String, Object>> teamList = sqlSession.selectList("ItMgmtMapper.selectTeamList");		
		model.addAttribute("teamList",teamList);
		
		return sUrl;
	}
	
	/*
	 * (인사) 개인기준 성과급 스케줄러 Log 조회
	 */
	@RequestMapping(value = "/schBonusLogListView")
	public String schBonusLogListView(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= schBonusLogListView =======");
		
		String sUrl = "/sys_adm/sch_bonus_main_view";
		
		//검색 기준날짜는 기본 어제날짜로 설정
		String sToday = DateUtil.getTodayString("yyyy-MM-dd");		//오늘 날짜(시스템에서 실행되는 날짜)
    	String sBaseDate = DateUtil.addDateNew(sToday, -1);			//어제 날짜(보고서 정산날짜)
    	model.addAttribute("baseDate",sBaseDate);
    	
    	//검색할 부문목록
    	List<Map<String, Object>> sectorList = sqlSession.selectList("ItMgmtMapper.selectSectorList");
    	model.addAttribute("sectorList",sectorList);
		
    	//검색할 센터목록
    	List<Map<String, Object>> centerList = sqlSession.selectList("ItMgmtMapper.selectCenterList");
    	model.addAttribute("centerList",centerList);
    	
    	//검색할 팀목록
		List<Map<String, Object>> teamList = sqlSession.selectList("ItMgmtMapper.selectTeamList");		
		model.addAttribute("teamList",teamList);
		
		return sUrl;
	}
	
	/*
	 * 개인기준 성과급 분기 스케줄러 조회
	 */
	@RequestMapping(value = "/schBonusLogList")
	public String schBonusLogList(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= schBonusLogList =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("schBonusLogList - no permession user_no : "+mbrVo.getUser_no());
			session.invalidate();
			return "top_login/top_login";
		}
		
		String sUrl = "/sys_adm/sch_bonus_main";
		
		//검색 기준날짜는 기본 어제날짜로 설정
		String sToday = DateUtil.getTodayString("yyyy-MM-dd");		//오늘 날짜(시스템에서 실행되는 날짜)
    	String sBaseDate = DateUtil.addDateNew(sToday, -1);			//어제 날짜(보고서 정산날짜)
    	model.addAttribute("baseDate",sBaseDate);
    	
    	//검색할 부문목록
    	List<Map<String, Object>> sectorList = sqlSession.selectList("ItMgmtMapper.selectSectorList");
    	model.addAttribute("sectorList",sectorList);
		
    	//검색할 센터목록
    	List<Map<String, Object>> centerList = sqlSession.selectList("ItMgmtMapper.selectCenterList");
    	model.addAttribute("centerList",centerList);
    	
    	//검색할 팀목록
		List<Map<String, Object>> teamList = sqlSession.selectList("ItMgmtMapper.selectTeamList");		
		model.addAttribute("teamList",teamList);
		
		return sUrl;
	}
	
	/*
	 * 개인기준 성과급 연간 스케줄러 조회
	 */
	@RequestMapping(value = "/schBonusYearLogList")
	public String schBonusYearLogList(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= schBonusYearLogList =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("schBonusLogList - no permession user_no : "+mbrVo.getUser_no());
			session.invalidate();
			return "top_login/top_login";
		}
		
		//String sUrl = "/sys_adm/sch_bonus_main";
		String sUrl = "/sys_adm/sch_bonus_year_main";
		
		//검색 기준날짜는 기본 어제날짜로 설정
		String sToday = DateUtil.getTodayString("yyyy-MM-dd");		//오늘 날짜(시스템에서 실행되는 날짜)
    	String sBaseDate = DateUtil.addDateNew(sToday, -1);			//어제 날짜(보고서 정산날짜)
    	model.addAttribute("baseDate",sBaseDate);
    	
    	//검색할 부문목록
    	List<Map<String, Object>> sectorList = sqlSession.selectList("ItMgmtMapper.selectSectorList");
    	model.addAttribute("sectorList",sectorList);
		
    	//검색할 센터목록
    	List<Map<String, Object>> centerList = sqlSession.selectList("ItMgmtMapper.selectCenterList");
    	model.addAttribute("centerList",centerList);
    	
    	//검색할 팀목록
		List<Map<String, Object>> teamList = sqlSession.selectList("ItMgmtMapper.selectTeamList");		
		model.addAttribute("teamList",teamList);
		
		return sUrl;
	}
	
	
	/**
	 * 장비관리보기 메인 (인사팀용)
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/equipment_manage_main_view")
	public String equipment_manage_main_view(Model model, HttpSession session, HttpServletRequest request) {
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		String sUrl = "/sys_adm/equipment_manage_main_view";
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		//탭타입		
		String viewType = request.getParameter("viewType") != null ? request.getParameter("viewType") : "Total";			//종구분		
		
		//검색용 파라미터		
		String srchGubunMain = request.getParameter("srchGubunMain") != null ? request.getParameter("srchGubunMain") : "9";			//종구분
		String srchEqTypeMain = request.getParameter("srchEqTypeMain") != null ? request.getParameter("srchEqTypeMain") : "0";			//장비종류
		String tmSearchMain = request.getParameter("tmSearchMain") != null ? request.getParameter("tmSearchMain") : "";					//부서명
		String srchEqStateMain = request.getParameter("srchEqStateMain") != null ? request.getParameter("srchEqStateMain") : "0";		//장비상태
		String srchUserNoMain = request.getParameter("srchUserNoMain") != null ? request.getParameter("srchUserNoMain") : "";		//사번
		String srchEqNoMain = request.getParameter("srchEqNoMain") != null ? request.getParameter("srchEqNoMain") : "";		//장비일련번호
		
		String regSdate = request.getParameter("regSdate") != null ? request.getParameter("regSdate") : "";		//등록 시작일
		String regEdate = request.getParameter("regEdate") != null ? request.getParameter("regEdate") : "";		//등록 종료일
		String closeSdate = request.getParameter("closeSdate") != null ? request.getParameter("closeSdate") : "";		//폐기 시작일
		String closeEdate = request.getParameter("closeEdate") != null ? request.getParameter("closeEdate") : "";		//폐기 종료일
		
		//정렬기준 파라미터
		String regdate_order_set = request.getParameter("regdate_order_set") != null ? request.getParameter("regdate_order_set") : "";		//등록기준 정렬
		String name_order_set = request.getParameter("name_order_set") != null ? request.getParameter("name_order_set") : "";		//등록기준 정렬
		String team_order_set = request.getParameter("team_order_set") != null ? request.getParameter("team_order_set") : "";		//등록기준 정렬
		
		//삭제 장비 체크
		String del_view_val = request.getParameter("del_view_val") != null ? request.getParameter("del_view_val") : "0";		//삭제장비 보여주기 (0:안보임, 1:보임)
		
		String srchCpuInfo = request.getParameter("srchCpuInfo") != null ? request.getParameter("srchCpuInfo") : "";			//cpu 종류		
		String srchMemorySizeStart = request.getParameter("srchMemorySizeStart") != null ? request.getParameter("srchMemorySizeStart") : "";			//메모리 시작크기
		String srchMemorySizeEnd = request.getParameter("srchMemorySizeEnd") != null ? request.getParameter("srchMemorySizeEnd") : "";			//메모리 제한크기
		
		// 검색용데이터 셋팅
		// 직원리스트 가져오기
		List<TopTmBscVO> memberList = sqlSession.selectList("StatisticBasic.selectTopMemberList", paramMap);
		List<Map<String, Object>> teamList = sqlSession.selectList("ItMgmtMapper.selectTeamList");
		
		// 장비종류 SELECT
        SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();
        codeVo.setTbl_nm("top_equipment");
        codeVo.setCol_nm("eq_type");
        List<SysAdmCodeDicVO> eqTypeList = CodeDicService.codeList(codeVo);
        
        // 장비상태 SELECT
        codeVo.setTbl_nm("top_equipment");
        codeVo.setCol_nm("eq_state");
        List<SysAdmCodeDicVO> eqStateList = CodeDicService.codeList(codeVo);
        
        // CPU 종류 SELECT
        codeVo.setTbl_nm("top_equipment");
        codeVo.setCol_nm("cpu_info");
        List<SysAdmCodeDicVO> cpuInfoList = CodeDicService.codeList(codeVo);
        
        model.addAttribute("memberList",memberList);
		model.addAttribute("teamList",teamList);
		model.addAttribute("eqTypeList",eqTypeList);
		model.addAttribute("eqStateList",eqStateList);
		model.addAttribute("cpuInfoList",cpuInfoList);
		
		// 검색데이터 model
		model.addAttribute("srchGubunMain",srchGubunMain);
		model.addAttribute("srchEqTypeMain",srchEqTypeMain);
		model.addAttribute("tmSearchMain",tmSearchMain);
		model.addAttribute("srchEqStateMain",srchEqStateMain);
		model.addAttribute("srchUserNoMain",srchUserNoMain);
		model.addAttribute("srchEqNoMain",srchEqNoMain);
		model.addAttribute("regSdate",regSdate);
		model.addAttribute("regEdate",regEdate);
		model.addAttribute("closeSdate",closeSdate);
		model.addAttribute("closeEdate",closeEdate);
		
		model.addAttribute("srchCpuInfo", srchCpuInfo);
		model.addAttribute("srchMemorySizeStart", srchMemorySizeStart);
		model.addAttribute("srchMemorySizeEnd", srchMemorySizeEnd);
		
		// 정렬데이터 model
		model.addAttribute("regdate_order_set",regdate_order_set);
		model.addAttribute("name_order_set",name_order_set);
		model.addAttribute("team_order_set",team_order_set);
		
		// 삭제장비 보여주기
		model.addAttribute("del_view_val", del_view_val);
		
		// ViewType
		model.addAttribute("viewType", viewType);
		
		return sUrl;
	}
	
	
	/**
	 * 카드 관리 목록
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/card_manage_list")
	public String card_manage_list(Model model, HttpSession session, HttpServletRequest request) {
		
		String sUrl = "";
		
		logger.info("======= card_manage_list =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
				
		//탭타입		
		String viewType = request.getParameter("viewType") != null ? request.getParameter("viewType") : "Total";			//종구분
		
		//엑셀다운로드 여부
		String doExcelDown = request.getParameter("doExcelDown") != null ? request.getParameter("doExcelDown") : "";			//종구분
						
		//검색용 파라미터		
		String srchGubunMain = request.getParameter("srchGubunMain") != null ? request.getParameter("srchGubunMain") : "9";			//종구분
		String srchCardTypeMain = request.getParameter("srchCardTypeMain") != null ? request.getParameter("srchCardTypeMain") : "";			//카드종류 (0:정상, 1:임시)
		String tmSearchMain = request.getParameter("tmSearchMain") != null ? request.getParameter("tmSearchMain") : "";					//부서명
		String srchCardStateMain = request.getParameter("srchCardStateMain") != null ? request.getParameter("srchCardStateMain") : "";		//카드상태 (0:미사용,1:사용중,2:폐기,3:분실,4:기타)
		String srchUserNoMain = request.getParameter("srchUserNoMain") != null ? request.getParameter("srchUserNoMain") : "";		//사번
		String srchCardNoMain = request.getParameter("srchCardNoMain") != null ? request.getParameter("srchCardNoMain") : "";		//카드번호
		String srchCardZoneMain = request.getParameter("srchCardZoneMain") != null ? request.getParameter("srchCardZoneMain") : "";		//카드 사용지역
		
		String regSdate = request.getParameter("regSdate") != null ? request.getParameter("regSdate") : "";		//등록 시작일
		String regEdate = request.getParameter("regEdate") != null ? request.getParameter("regEdate") : "";		//등록 종료일
		String modSdate = request.getParameter("modSdate") != null ? request.getParameter("modSdate") : "";		//수정 시작일
		String modEdate = request.getParameter("modEdate") != null ? request.getParameter("modEdate") : "";		//수정 종료일
		
		//정렬기준 파라미터
		String regdate_order_set = request.getParameter("regdate_order_set") != null ? request.getParameter("regdate_order_set") : "";		//등록기준 정렬
		String name_order_set = request.getParameter("name_order_set") != null ? request.getParameter("name_order_set") : "";		//이름기준 정렬
		String team_order_set = request.getParameter("team_order_set") != null ? request.getParameter("team_order_set") : "";		//팀이름 정렬
		
		//삭제 장비 체크
		String del_view_val = request.getParameter("del_view_val") != null ? request.getParameter("del_view_val") : "0";		//삭제카드 보여주기 (0:안보임, 1:보임)
		
		//퇴사자 장비 체크
		String out_view_val = request.getParameter("out_view_val") != null ? request.getParameter("out_view_val") : "0";		//퇴사자 카드 보여주기 (0:안보임, 1:보임)
		
		//카드별칭, 카드메모 검색추가
		String srchCardMemoMain = request.getParameter("srchCardMemoMain") != null ? request.getParameter("srchCardMemoMain") : "";		//카드메모
		String srchCardUidMain = request.getParameter("srchCardUidMain") != null ? request.getParameter("srchCardUidMain") : "";		//카드별칭
		String srchCardSerialNo = request.getParameter("srchCardSerialNo") != null ? request.getParameter("srchCardSerialNo") : "";		//카드씨리얼번호
		
		//System.out.println("del_view_val List="+del_view_val);
		//System.out.println("regdate_order_set="+regdate_order_set);
		//System.out.println("name_order_set="+name_order_set);
		//System.out.println("team_order_set="+team_order_set);
		
		//String sQueryOrder = "order by GA.reg_date desc";
		//기본은 직원명부와 동일하기 정렬 by top3009
		String sQueryOrder = "ORDER BY  GA.team_group_order DESC, GA.team_order DESC, new_work_order, GA.work_level DESC, GA.work_rank DESC, GA.join_date, GA.user_name DESC";
				
		if( !"".equals(regdate_order_set)) {
			if( "asc".equals(regdate_order_set) ) {
				sQueryOrder = "order by GA.reg_date";
			}else{
				sQueryOrder = "order by GA.reg_date desc";
			}
		}
		
		if( !"".equals(name_order_set)) {
			if( "asc".equals(name_order_set) ) {
				sQueryOrder = "order by GA.user_name";
			}else{
				sQueryOrder = "order by GA.user_name desc";
			}
		}
		
		if( !"".equals(team_order_set)) {
			if( "asc".equals(team_order_set) ) {
				sQueryOrder = "order by GA.team_name";
			}else{
				sQueryOrder = "order by GA.team_name desc";
			}
		}	
		
		//System.out.println("sQueryOrder="+sQueryOrder);
		
		paramMap.put("srchGubunMain", srchGubunMain);
		paramMap.put("tmSearchMain", tmSearchMain);
		paramMap.put("srchCardTypeMain", srchCardTypeMain);
		paramMap.put("srchCardStateMain", srchCardStateMain);
		paramMap.put("srchCardZoneMain", srchCardZoneMain);
		paramMap.put("srchUserNoMain", srchUserNoMain);
		paramMap.put("srchCardNoMain", srchCardNoMain);
		paramMap.put("srchCardMemoMain", srchCardMemoMain);
		paramMap.put("srchCardUidMain", srchCardUidMain);
		paramMap.put("srchCardSerialNo", srchCardSerialNo);
		
		paramMap.put("regSdate", regSdate);		
		paramMap.put("regEdate", regEdate);
		paramMap.put("modSdate", modSdate);		
		paramMap.put("modEdate", modEdate);
		
		paramMap.put("del_view_val", del_view_val);
		
		paramMap.put("out_view_val", out_view_val);
		
		paramMap.put("sQueryOrder", sQueryOrder);
		
		//List<EquipmentBean> equipmentList = sqlSession.selectList("ItMgmtMapper.selectEquipmentList", paramMap);		//장비목록
		
		//CommonUtils.printMap(paramMap);
		
		//기본 검색 결과가 안나오는 상태로 유지하기 위한 Refere 체크 (card_manage_main)
		String sReferer = request.getHeader("Referer");		
		List<CardBean> cardList = new ArrayList<>();
		
		//카드관리 페이지에서 접근한 경우만 검색 결과를 보여준다.
		if( sReferer.contains("card_manage_main") ) {
			cardList = sqlSession.selectList("ItMgmtMapper.selectCardList", paramMap);		//카드목록
		}
		
		//List<CardBean> cardList = sqlSession.selectList("ItMgmtMapper.selectCardList", paramMap);		//카드목록
		
		
		//int equipmentCnt = sqlSession.selectOne("ItMgmtMapper.selectEquipmentListCnt", paramMap);							//조회된 장비 건수
		
		//model.addAttribute("equipmentCnt", equipmentCnt);		//조회된 장비 건수
		
		model.addAttribute("cardList", cardList);
				
		model.addAttribute("del_view_val", del_view_val);
		
		model.addAttribute("out_view_val", out_view_val);
		
		model.addAttribute("viewType", viewType);
		
		//System.out.println("doExcelDown="+doExcelDown);
		
		if("1".equals(doExcelDown)) {
			sUrl = "/sys_adm/card_manage_list_excel";
		}else {
			sUrl = "/sys_adm/card_manage_list";
		}
				
		return sUrl;
	}
	
	
	/**
	 * 카드관리 메인
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/card_manage_main")
	public String card_manage_main(Model model, HttpSession session, HttpServletRequest request) {
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("card_manage_main - no permession user_no : "+mbrVo.getUser_no());
			session.invalidate();
			return "top_login/top_login";
		}		
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		//탭타입		
		String viewType = request.getParameter("viewType") != null ? request.getParameter("viewType") : "Total";			//종구분		
		
		//검색용 파라미터		
		String srchGubunMain = request.getParameter("srchGubunMain") != null ? request.getParameter("srchGubunMain") : "9";			//종구분
		String srchCardTypeMain = request.getParameter("srchCardTypeMain") != null ? request.getParameter("srchCardTypeMain") : "";			//카드종류 (0:정상, 1:임시)
		String tmSearchMain = request.getParameter("tmSearchMain") != null ? request.getParameter("tmSearchMain") : "";					//부서명
		String srchCardStateMain = request.getParameter("srchCardStateMain") != null ? request.getParameter("srchCardStateMain") : "";		//카드상태 (0:미사용,1:사용중,2:폐기,3:분실,4:기타)
		String srchUserNoMain = request.getParameter("srchUserNoMain") != null ? request.getParameter("srchUserNoMain") : "";		//사번
		String srchCardNoMain = request.getParameter("srchCardNoMain") != null ? request.getParameter("srchCardNoMain") : "";		//카드번호
		String srchCardZoneMain = request.getParameter("srchCardZoneMain") != null ? request.getParameter("srchCardZoneMain") : "";		//카드사용지역
		
		String regSdate = request.getParameter("regSdate") != null ? request.getParameter("regSdate") : "";		//등록 시작일
		String regEdate = request.getParameter("regEdate") != null ? request.getParameter("regEdate") : "";		//등록 종료일
		String modSdate = request.getParameter("modSdate") != null ? request.getParameter("modSdate") : "";		//수정 시작일
		String modEdate = request.getParameter("modEdate") != null ? request.getParameter("modEdate") : "";		//수정 종료일
		
		//정렬기준 파라미터
		String regdate_order_set = request.getParameter("regdate_order_set") != null ? request.getParameter("regdate_order_set") : "";		//등록기준 정렬
		String name_order_set = request.getParameter("name_order_set") != null ? request.getParameter("name_order_set") : "";		//이름기준 정렬
		String team_order_set = request.getParameter("team_order_set") != null ? request.getParameter("team_order_set") : "";		//팀이름 정렬
		
		//삭제 장비 체크
		String del_view_val = request.getParameter("del_view_val") != null ? request.getParameter("del_view_val") : "0";		//삭제카드 보여주기 (0:안보임, 1:보임)
		
		//퇴사자 장비 체크
		String out_view_val = request.getParameter("out_view_val") != null ? request.getParameter("out_view_val") : "0";		//퇴사자 카드 보여주기 (0:안보임, 1:보임)
		
		//카드별칭, 카드메모 검색추가
		String srchCardMemoMain = request.getParameter("srchCardMemoMain") != null ? request.getParameter("srchCardMemoMain") : "";		//카드메모
		String srchCardUidMain = request.getParameter("srchCardUidMain") != null ? request.getParameter("srchCardUidMain") : "";		//카드별칭
		String srchCardSerialNo = request.getParameter("srchCardSerialNo") != null ? request.getParameter("srchCardSerialNo") : "";		//카드씨리얼
		
		// 검색용데이터 셋팅
		List<TopTmBscVO> memberList = sqlSession.selectList("StatisticBasic.selectTopMemberList", paramMap);
		// 퇴사자를 포함한 직원리스트 가져오기
		//List<TopTmBscVO> memberList = sqlSession.selectList("ItMgmtMapper.selectTopMemberListAll", paramMap);
		List<Map<String, Object>> teamList = sqlSession.selectList("ItMgmtMapper.selectTeamList");
		
		//카드조건 검색
        SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();
        
        //카드 종류
        codeVo.setTbl_nm("top_card");
        codeVo.setCol_nm("card_type");
        List<SysAdmCodeDicVO> cardTypeList = CodeDicService.codeList(codeVo);        
        
        //카드 상태
        codeVo.setCol_nm("card_state");
        List<SysAdmCodeDicVO> cardStateList = CodeDicService.codeList(codeVo);
        
        //카드 사용지역
        codeVo.setCol_nm("card_zone");
        List<SysAdmCodeDicVO> cardZoneList = CodeDicService.codeList(codeVo);
        
        model.addAttribute("memberList",memberList);
		model.addAttribute("teamList",teamList);
		model.addAttribute("cardTypeList",cardTypeList);
		model.addAttribute("cardStateList",cardStateList);
		model.addAttribute("cardZoneList",cardZoneList);
		
		// 검색데이터 model
		model.addAttribute("srchGubunMain",srchGubunMain);
		model.addAttribute("srchCardTypeMain",srchCardTypeMain);
		model.addAttribute("tmSearchMain",tmSearchMain);
		model.addAttribute("srchCardStateMain",srchCardStateMain);
		model.addAttribute("srchUserNoMain",srchUserNoMain);
		model.addAttribute("srchCardNoMain",srchCardNoMain);
		model.addAttribute("srchCardZoneMain",srchCardZoneMain);
		model.addAttribute("regSdate",regSdate);
		model.addAttribute("regEdate",regEdate);
		model.addAttribute("modSdate",modSdate);
		model.addAttribute("modEdate",modEdate);
		model.addAttribute("srchCardMemoMain",srchCardMemoMain);
		model.addAttribute("srchCardUidMain",srchCardUidMain);
		model.addAttribute("srchCardSerialNo",srchCardSerialNo);		
		
		// 정렬데이터 model
		model.addAttribute("regdate_order_set",regdate_order_set);
		model.addAttribute("name_order_set",name_order_set);
		model.addAttribute("team_order_set",team_order_set);
		
		// 삭제장비 보여주기
		model.addAttribute("del_view_val", del_view_val);
		
		// 퇴사자 장비 보여주기
		model.addAttribute("out_view_val", out_view_val);
		
		// ViewType
		model.addAttribute("viewType", viewType);				
		
		return "/sys_adm/card_manage_main";
	}
	
	/**
	 * 장비관리 통계
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/equipment_manage_stat")
	public String equipment_manage_stat(Model model, HttpSession session, HttpServletRequest request) {
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("equipment_manage_stat - no permession user_no : "+mbrVo.getUser_no());
			session.invalidate();
			return "top_login/top_login";
		}
		
		logger.info("======= equipment_manage_stat =======");
		
		String selDate = request.getParameter("selDate") != null ? request.getParameter("selDate") : "";			//조회 일자
		
		if( "".equals(selDate) ) {
			selDate = DateUtil.getTodayString("yyyy-MM-dd");
		}
		
		model.addAttribute("selDate", selDate);
		
		return "/sys_adm/equipment_manage_stat";
	}
	
	/**
	 * 부서별 장비 목록
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/equipment_manage_stat_team")
	public String equipment_manage_stat_team(Model model, HttpSession session, HttpServletRequest request) {
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("equipment_manage_stat - no permession user_no : "+mbrVo.getUser_no());
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		logger.info("======= equipment_manage_stat_team =======");
		
		//조회일자
		String selDate = request.getParameter("selDate") != null ? request.getParameter("selDate") : "";			//조회 일자
		String excelSelDate = request.getParameter("excelSelDate") != null ? request.getParameter("excelSelDate") : "";			//엑셀 다운로드 조회 일자
		
		//엑셀다운로드 여부
		String doExcelDown = request.getParameter("doExcelDown") != null ? request.getParameter("doExcelDown") : "";			//종구분
				
		//본사사업부
		List<Map<String, Object>> teamList_0;
		
		//1종사업부
		List<Map<String, Object>> teamList_1;
		
		//4종사업부
		List<Map<String, Object>> teamList_4;
		
		String sToday = DateUtil.getTodayString("yyyy-MM-dd");		
		
		if( "".equals(selDate)  ) {		//입력값이 없으면 오늘로 한다.
			selDate = sToday;
		}
		
		//엑셀다운로드 인 경우 날짜처리
		if( "1".equals(doExcelDown) ) {			
			if( "".equals(excelSelDate) ) {
				selDate = sToday;
			}else {
				selDate = excelSelDate;
			}			
		}
		
		int nChkDate = DateUtil.compareDate(sToday, selDate);
		
		if( nChkDate < 0 ) {						//조회 기준일이 이전 날짜인경우 (과거 데이터) .. 작업중임.
			
			paramMap.put("selDate", selDate);
			
			paramMap.put("team_type", "0");			
			teamList_0 = sqlSession.selectList("ItMgmtMapper.getTeamListByTypeToDate", paramMap);
			
			paramMap.put("team_type", "1");
			teamList_1 = sqlSession.selectList("ItMgmtMapper.getTeamListByTypeToDate", paramMap);
			
			paramMap.put("team_type", "4");
			teamList_4 = sqlSession.selectList("ItMgmtMapper.getTeamListByTypeToDate", paramMap);
			
		}else{										//조회 기준일이 오늘 (지정날짜가 미래 날짜인 경우)
			teamList_0 = sqlSession.selectList("ItMgmtMapper.getTeamListByType", "0");
			
			teamList_1 = sqlSession.selectList("ItMgmtMapper.getTeamListByType", "1");
			
			teamList_4 = sqlSession.selectList("ItMgmtMapper.getTeamListByType", "4");
		}
		
		//System.out.println( teamList_0.size()+" : "+ teamList_1.size()+" : "+ teamList_4.size() );
		
		model.addAttribute("teamList_0", teamList_0);
		model.addAttribute("teamList_1", teamList_1);
		model.addAttribute("teamList_4", teamList_4);
		model.addAttribute("selDate", selDate);
		
		if("1".equals(doExcelDown)) {
			return "/sys_adm/equipment_manage_stat_team_excel";
		}else {
			return "/sys_adm/equipment_manage_stat_team";
		}
	}
	
	
	
	/**
	 * 장비관리메인
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/equipment_manage_main")
	public String equipment_manage_main(Model model, HttpSession session, HttpServletRequest request) {
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("equipment_manage_main - no permession user_no : "+mbrVo.getUser_no());
			session.invalidate();
			return "top_login/top_login";
		}
		
		String sUrl = "/sys_adm/equipment_manage_main";
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		//탭타입		
		String viewType = request.getParameter("viewType") != null ? request.getParameter("viewType") : "Total";			//종구분		
		
		//검색용 파라미터		
		String srchGubunMain = request.getParameter("srchGubunMain") != null ? request.getParameter("srchGubunMain") : "9";			//종구분
		String srchEqTypeMain = request.getParameter("srchEqTypeMain") != null ? request.getParameter("srchEqTypeMain") : "0";			//장비종류
		String tmSearchMain = request.getParameter("tmSearchMain") != null ? request.getParameter("tmSearchMain") : "";					//부서명
		String srchEqStateMain = request.getParameter("srchEqStateMain") != null ? request.getParameter("srchEqStateMain") : "0";		//장비상태
		String srchUserNoMain = request.getParameter("srchUserNoMain") != null ? request.getParameter("srchUserNoMain") : "";		//사번
		String srchEqNoMain = request.getParameter("srchEqNoMain") != null ? request.getParameter("srchEqNoMain") : "";		//장비일련번호
		
		String regSdate = request.getParameter("regSdate") != null ? request.getParameter("regSdate") : "";		//등록 시작일
		String regEdate = request.getParameter("regEdate") != null ? request.getParameter("regEdate") : "";		//등록 종료일
		String closeSdate = request.getParameter("closeSdate") != null ? request.getParameter("closeSdate") : "";		//폐기 시작일
		String closeEdate = request.getParameter("closeEdate") != null ? request.getParameter("closeEdate") : "";		//폐기 종료일
		
		//정렬기준 파라미터
		String regdate_order_set = request.getParameter("regdate_order_set") != null ? request.getParameter("regdate_order_set") : "";		//등록기준 정렬
		String name_order_set = request.getParameter("name_order_set") != null ? request.getParameter("name_order_set") : "";		//등록기준 정렬
		String team_order_set = request.getParameter("team_order_set") != null ? request.getParameter("team_order_set") : "";		//등록기준 정렬
		
		//삭제 장비 체크
		String del_view_val = request.getParameter("del_view_val") != null ? request.getParameter("del_view_val") : "0";		//삭제장비 보여주기 (0:안보임, 1:보임)
		
		//퇴사자 장비 체크
		String out_view_val = request.getParameter("out_view_val") != null ? request.getParameter("out_view_val") : "0";		//퇴사자 장비 보여주기 (0:안보임, 1:보임)
		
		String srchCpuInfo = request.getParameter("srchCpuInfo") != null ? request.getParameter("srchCpuInfo") : "";			//cpu 종류		
		String srchMemorySizeStart = request.getParameter("srchMemorySizeStart") != null ? request.getParameter("srchMemorySizeStart") : "";			//메모리 시작크기
		String srchMemorySizeEnd = request.getParameter("srchMemorySizeEnd") != null ? request.getParameter("srchMemorySizeEnd") : "";			//메모리 제한크기
		
		// 검색용데이터 셋팅
		List<TopTmBscVO> memberList = sqlSession.selectList("StatisticBasic.selectTopMemberList", paramMap);
		// 퇴사자를 포함한 직원리스트 가져오기
		//List<TopTmBscVO> memberList = sqlSession.selectList("ItMgmtMapper.selectTopMemberListAll", paramMap);
		List<Map<String, Object>> teamList = sqlSession.selectList("ItMgmtMapper.selectTeamList");
		
		// 장비종류 SELECT
        SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();
        codeVo.setTbl_nm("top_equipment");
        codeVo.setCol_nm("eq_type");
        List<SysAdmCodeDicVO> eqTypeList = CodeDicService.codeList(codeVo);
        
        // 장비상태 SELECT
        codeVo.setTbl_nm("top_equipment");
        codeVo.setCol_nm("eq_state");
        List<SysAdmCodeDicVO> eqStateList = CodeDicService.codeList(codeVo);
        
        // CPU 종류 SELECT
        codeVo.setTbl_nm("top_equipment");
        codeVo.setCol_nm("cpu_info");
        List<SysAdmCodeDicVO> cpuInfoList = CodeDicService.codeList(codeVo);
        
        model.addAttribute("memberList",memberList);
		model.addAttribute("teamList",teamList);
		model.addAttribute("eqTypeList",eqTypeList);
		model.addAttribute("eqStateList",eqStateList);
		model.addAttribute("cpuInfoList", cpuInfoList);
		
		// 검색데이터 model
		model.addAttribute("srchGubunMain",srchGubunMain);
		model.addAttribute("srchEqTypeMain",srchEqTypeMain);
		model.addAttribute("tmSearchMain",tmSearchMain);
		model.addAttribute("srchEqStateMain",srchEqStateMain);
		model.addAttribute("srchUserNoMain",srchUserNoMain);
		model.addAttribute("srchEqNoMain",srchEqNoMain);
		model.addAttribute("regSdate",regSdate);
		model.addAttribute("regEdate",regEdate);
		model.addAttribute("closeSdate",closeSdate);
		model.addAttribute("closeEdate",closeEdate);
		
		model.addAttribute("srchCpuInfo", srchCpuInfo);
		model.addAttribute("srchMemorySizeStart", srchMemorySizeStart);
		model.addAttribute("srchMemorySizeEnd", srchMemorySizeEnd);
		
		// 정렬데이터 model
		model.addAttribute("regdate_order_set",regdate_order_set);
		model.addAttribute("name_order_set",name_order_set);
		model.addAttribute("team_order_set",team_order_set);
		
		// 삭제장비 보여주기
		model.addAttribute("del_view_val", del_view_val);
		
		// 퇴사자 장비 보여주기
		model.addAttribute("out_view_val", out_view_val);
		
		// ViewType
		model.addAttribute("viewType", viewType);
		
		return sUrl;
	}
	
	/**
	 * 카드 정보 보기
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "card_manage_modal_detail")
	public String card_manage_modal_detail(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= card_manage_modal_detail =======");
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		String ckey = request.getParameter("ckey") != null ? request.getParameter("ckey") : "";		
		
		CardBean cardView = sqlSession.selectOne("ItMgmtMapper.selectCardOne", ckey);
		
		List<CardLogBean> cardLogList = sqlSession.selectList("ItMgmtMapper.selectCardLogList", ckey);		//카드로그정보
		
		GetImageBase64 imageUtil = new GetImageBase64();
		
		//카드 사용자의 증명사진 이미지 추출
		int card_user_no = cardView.getUser_no();
		
		if( card_user_no > 0 ) {			//카드 소유자 정보가 있는 경우
			
			String userNo = String.valueOf(card_user_no);			
			
			TopMbrBscVO memberVo = sqlSession.selectOne("TopMbrDtlMapper.mbrinfo", userNo);					
			
			try {
				/* 이미지 시작 */
				if( (memberVo.getPicture() != null ) ){
					if(!memberVo.getPicture().equals("")){
						
						String dbpath = "/home/hosting_users/toplac/www/ls_data/member/"+memberVo.getPicture();
						String fileType = dbpath.substring(dbpath.lastIndexOf(".")+1, dbpath.length());

						File fd = new File(dbpath);
						if (fd.exists()){
							model.addAttribute("imageBase64", imageUtil.imageBase64Small(dbpath, fileType));
						}
					}
				}

			} catch (Exception e) {
				model.addAttribute("imageBase64", null);		//이미지 없음
			}
			
		}
		
		model.addAttribute("cardView",cardView);
		model.addAttribute("cardlogList",cardLogList);
		
		return "/sys_adm/card_manage_modal_detail";
	}
	
	
	@RequestMapping(value = "equipment_manage_trouble_modal_detail")
	public String equipment_manage_trouble_modal_detail(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("======= equipment_manage_trouble_modal_detail =======");
		
		List<Map<String,Object>> trubleEqList = sqlSession.selectList("ItMgmtMapper.selectEquipmentTroubleList");		
	    
		model.addAttribute("trubleEqList", trubleEqList);
		
		return "/sys_adm/equipment_manage_trouble_modal_detail";
	}
	
	@RequestMapping(value = "equipment_manage_modal_detail")
	public String equipment_manage_modal_detail(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= equipment_manage_modal_detail =======");
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		String serial_no = request.getParameter("serial_no") != null ? request.getParameter("serial_no") : "";
		
		EquipmentBean equipmentView = sqlSession.selectOne("ItMgmtMapper.selectEquipmentOne", serial_no);		//장비정보
		
		List<EquipmentLogBean> equipmentlogList = sqlSession.selectList("ItMgmtMapper.selectEquipmentLogList", serial_no);		//장비정보
		
		model.addAttribute("equipmentView",equipmentView);
		model.addAttribute("equipmentlogList",equipmentlogList);
		
		return "/sys_adm/equipment_manage_modal_detail";
	}

	/**
	 * 계약정보 추가, 수정, 삭제
	 * @param request
	 * @param model
	 * @param session
	 * @param attath_file
	 * @return
	 */
	@RequestMapping(value="/contractMainAction")
    @ResponseBody
    public int contractMainAction(HttpServletRequest request, Model model, HttpSession session, MultipartFile attath_file) {
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		String reg_user_no = mbrVo.getUser_no();			//등록자 사번
		
		//사용자 아이피 체크
		HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String reg_ip = req.getHeader("X-FORWARDED-FOR");
		if ( reg_ip == null ) {
			reg_ip = req.getRemoteAddr();
		}
		
		String log_tkey = request.getParameter("tkey") != null ? request.getParameter("tkey") : "";
		
		paramMap.put("reg_ip", reg_ip);
		paramMap.put("user_no", reg_user_no);
		paramMap.put("reg_user_no", reg_user_no);			//로그 등록용 아이디
		
		//action : I(추가), U(업데이트)
		String sAction = paramMap.get("action").toString();		
		
		logger.info("======= contractMainAction : "+ sAction +" =======");
		
		//로그등록용 플래그
		paramMap.put("action_flag", sAction);
		
		//파일 추가 시작
		String orgFileName = "";
		String fileExt = "";
		String encFileName = "";
		
		//파일임시변수
		String sFile_path	=	"";
		String sFile_name = "";
		String sFullPath = "";						
		//파일 추가 끝
		
		//운영
		String fullPath = "/home" + File.separator + "hosting_users" + File.separator + "toplac"
				+ File.separator + "www" + File.separator + "ls_data" + File.separator + "contract";

		//개발 경로
		//String fullPath = "D:\\home" + File.separator + "hosting_users" + File.separator + "toplac"
				//+ File.separator + "www" + File.separator + "ls_data" + File.separator + "contract";
				
    	int nCnt = 0;
    	String sTkey = "";			//추가시 생성된 tkey
    	int nFileCnt = 0;
    	
    	if( "I".equals(sAction) ) {
    		
    		nCnt = sqlSession.insert("ItMgmtMapper.insertContractTemplate", paramMap);
    		
    		sTkey = paramMap.get("tkey").toString();
    		
    		paramMap.put("tkey", sTkey);
    		
    		if ( attath_file != null ){		//첨부파일이 있는 경우 처리
    			orgFileName = attath_file.getOriginalFilename();							//원본 파일명
    			fileExt = FilenameUtils.getExtension(orgFileName);						//파일 확장자
    			encFileName = UUID.randomUUID().toString().replaceAll("-", "") +"."+fileExt;	//암호화 파일명
    			
    			paramMap.put("file_path", fullPath);
    			paramMap.put("file_org_name", orgFileName);
    			paramMap.put("file_enc_name", encFileName);
    			
    			try {
    				File file = new File(fullPath,encFileName);
    				if(!file.exists()){
    					file.mkdirs();
    				}
    				attath_file.transferTo(file);
    				
    			} catch (IOException e) {
    				e.printStackTrace();
    			}    			
    			
    			//최초 파일을 등록한다.
    			sqlSession.insert("ItMgmtMapper.insertContractTemplateFile", paramMap);  
    			
    			nFileCnt = 1;
    		}
    		
    		paramMap.put("file_cnt", nFileCnt);
    		
    		sqlSession.update("ItMgmtMapper.updateContractTemplateFileNum", paramMap);    		
    		
    		//등록인경우 최종등록된 tkey 값을 가져와서 넣어준다.
    		log_tkey = sTkey;
    		
    	}else if( "U".equals(sAction) ) {
    		
    		//파일 갯수를 가져온다.
    		nFileCnt = sqlSession.selectOne("ItMgmtMapper.getContractFileCnt", paramMap);
    		
    		paramMap.put("file_cnt", nFileCnt);
    		
    		nCnt = sqlSession.update("ItMgmtMapper.updateContractTemplate", paramMap);    		    		
    		
    	}else if("D".equals(sAction) ) {			//추가작업 필요
    		
    		//파일부터 삭제 한다.
    		//Map<String, Object> DelFileMap = sqlSession.selectOne("ItMgmtMapper.getContractFileInfo", paramMap);
    		List<Map<String,Object>> DelFileList = sqlSession.selectList("ItMgmtMapper.getContractFileList", paramMap);
    		
    		for( int i = 0; i < DelFileList.size(); i++) {
    			sFile_path = DelFileList.get(i).get("file_path").toString();
    			sFile_name = DelFileList.get(i).get("file_enc_name").toString();
    			sFullPath = sFile_path + File.separator + sFile_name;
    			
    			if( !"".equals(sFile_name) ) {
        			File f = new File(sFullPath);
        			f.delete();
        		}    			
    		}    		
    		//계약서 첨부파일 목록 삭제
    		nCnt = sqlSession.delete("ItMgmtMapper.deleteContractFile", paramMap);    		
    		
    		//계약서 정보 삭제
    		nCnt = sqlSession.delete("ItMgmtMapper.deleteContractInfo", paramMap);
    	}else if( "DF".equals(sAction) ) {			//파일만 삭제하는 경우
    		//파일부터 삭제 한다.
    		Map<String, Object> DelFileMap = sqlSession.selectOne("ItMgmtMapper.getContractFileInfo", paramMap);
    		
    		if( DelFileMap.get("file_path") != null ) {
    			sFile_path = DelFileMap.get("file_path").toString();
        		sFile_name = DelFileMap.get("file_enc_name").toString();        		
        		sFullPath = sFile_path + File.separator + sFile_name; 
        		
        		if( !"".equals(sFile_name) ) {
        			File f = new File(sFullPath);
        			f.delete();
        		}
    		}
    		
    		//파일 테이블 삭제
    		nCnt = sqlSession.delete("ItMgmtMapper.delContractFileDel", paramMap);
    		
    		//파일 갯수를 가져온다.
    		nFileCnt = sqlSession.selectOne("ItMgmtMapper.getContractFileCnt", paramMap);
    		
    		paramMap.put("file_cnt", nFileCnt);
    		
    		//DB의 첨부파일 정보만 삭제(갱신)한다.
    		nCnt = sqlSession.update("ItMgmtMapper.updateContractTemplateFileNum", paramMap);
    		
    	}else if( "DA".equals(sAction)) {		//첨부파일 추가 (수정시)
    		
    		orgFileName = attath_file.getOriginalFilename();							//원본 파일명
			fileExt = FilenameUtils.getExtension(orgFileName);						//파일 확장자
			encFileName = UUID.randomUUID().toString().replaceAll("-", "") +"."+fileExt;	//암호화 파일명
			
			paramMap.put("file_path", fullPath);
			paramMap.put("file_org_name", orgFileName);
			paramMap.put("file_enc_name", encFileName);
			
			try {
				File file = new File(fullPath,encFileName);
				if(!file.exists()){
					file.mkdirs();
				}
				attath_file.transferTo(file);
				
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			//최초 파일을 등록한다.
			sqlSession.insert("ItMgmtMapper.insertContractTemplateFile", paramMap);
			
			//계약서 내 파일 갯수를 새로가져와서 계약서 첨부파일 갯수를 갱신해준다.
    		nFileCnt = sqlSession.selectOne("ItMgmtMapper.getContractFileCnt", paramMap);    		
    		paramMap.put("file_cnt", nFileCnt);
    		
    		nCnt = sqlSession.update("ItMgmtMapper.updateContractTemplateFileNum", paramMap);
    	}
    	
    	//로그를 등록한다.    	
    	String reg_content = RequestUtil.conversionMap(paramMap);
    	paramMap.put("reg_content", reg_content);
    	paramMap.put("tkey", log_tkey);
    	
    	sqlSession.insert("ItMgmtMapper.insertContractTemplateLog", paramMap);    	
    	
    	return nCnt; 
	}
	
	/**
	 * 계약서 등록 수정 관리 모달 창
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "contract_main_modal")
	public String contract_main_modal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= contract_main_modal =======");
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
		//계약서 조회 권한 체크
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
		
		//권한 : 1:1종, 4:4종, 5: 전체조회, 9 : 관리자
		String sContractAuth = mbrAuthVo.getMbr_pms_37().toString();
		
		//계약서 종류 가져오기
		paramMap.put("is_del", "0");		//사용안함 제외		
		paramMap.put("code_type", "c_type");			//계약서 종류
		List<Map<String, Object>> conTypeList = sqlSession.selectList("ItMgmtMapper.selectContractCode",paramMap);
		paramMap.put("code_type", "c_area");			//지점 종류
		List<Map<String, Object>> conAreaList = sqlSession.selectList("ItMgmtMapper.selectContractCode",paramMap);
		
		model.addAttribute("conTypeList",conTypeList);
		model.addAttribute("conAreaList",conAreaList);
		model.addAttribute("sContractAuth", sContractAuth);

		return "/sys_adm/contract_main_modal";
	}
	
	/**
	 * 카드 모달창 가져오기
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "card_manage_modal")
	public String card_manage_modal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= card_manage_modal =======");
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);		
		// 직원리스트 가져오기
		List<TopTmBscVO> memberList = sqlSession.selectList("StatisticBasic.selectTopMemberList", paramMap);
		List<Map<String, Object>> teamList = sqlSession.selectList("ItMgmtMapper.selectTeamList");
		
		// 카드종류
        SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();
        codeVo.setTbl_nm("top_card");
        codeVo.setCol_nm("card_type");
        List<SysAdmCodeDicVO> cardTypeList = CodeDicService.codeList(codeVo);
        
        // 카드상태        
        codeVo.setCol_nm("card_state");
        List<SysAdmCodeDicVO> cardStateList = CodeDicService.codeList(codeVo);
        
        // 카드 사용지점
        codeVo.setCol_nm("card_zone");
        List<SysAdmCodeDicVO> cardZoneList = CodeDicService.codeList(codeVo);
				
		model.addAttribute("memberList",memberList);
		model.addAttribute("teamList",teamList);
		model.addAttribute("cardTypeList",cardTypeList);
		model.addAttribute("cardStateList",cardStateList);
		model.addAttribute("cardZoneList",cardZoneList);
		
		return "/sys_adm/card_manage_modal";
	}
	
	@RequestMapping(value = "equipment_manage_modal")
	public String equipment_manage_modal(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= equipment_manage_modal =======");
	    //===============================================
	    //	파라미터 체크
	    //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);		
		// 직원리스트 가져오기
		List<TopTmBscVO> memberList = sqlSession.selectList("StatisticBasic.selectTopMemberList", paramMap);
		List<Map<String, Object>> teamList = sqlSession.selectList("ItMgmtMapper.selectTeamList");
		
		// 장비종류 SELECT
        SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();
        codeVo.setTbl_nm("top_equipment");
        codeVo.setCol_nm("eq_type");
        List<SysAdmCodeDicVO> eqTypeList = CodeDicService.codeList(codeVo);
        
        // 장비상태 SELECT
        codeVo.setTbl_nm("top_equipment");
        codeVo.setCol_nm("eq_state");
        List<SysAdmCodeDicVO> eqStateList = CodeDicService.codeList(codeVo);
        
        // CPU 종류 SELECT
        codeVo.setTbl_nm("top_equipment");
        codeVo.setCol_nm("cpu_info");
        List<SysAdmCodeDicVO> cpuInfoList = CodeDicService.codeList(codeVo);
				
		model.addAttribute("memberList",memberList);
		model.addAttribute("teamList",teamList);
		model.addAttribute("eqTypeList",eqTypeList);
		model.addAttribute("eqStateList",eqStateList);
		model.addAttribute("cpuInfoList",cpuInfoList);
		
		return "/sys_adm/equipment_manage_modal";
	}
	
	/**
	 * 보고서 협조건 의뢰인 수정 목록 가져오기 Ajax
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "sysRptHelpManageAjax")
	public String sysRptHelpManageAjax(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= sysRptHelpManageAjax =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);		
		
		List<Map<String,Object>> rptList = sqlSession.selectList("ItMgmtMapper.selectRptHelpManageList", paramMap);
    	model.addAttribute("rptList",rptList);
    	
    	//재직중인 직원의 목록을 물러온다.
		List<Map<String, Object>> userList = sqlSession.selectList("StatisticBasic.selectTopMemberList");		
		model.addAttribute("userList", userList);

		return "/sys_adm/top_rpt_help_manage_list_ajax";
	}
	
	@RequestMapping(value = "sysRptCloseDateUpdateAjax")
	public String sysRptCloseDateUpdateAjax(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= sysRptCloseDateUpdateAjax =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);		
		
		List<Map<String,Object>> rptList = sqlSession.selectList("ItMgmtMapper.selectRptCloseDate", paramMap);
    	model.addAttribute("rptList",rptList);
		
		return "/sys_adm/top_rpt_head_close_date_list_ajax";
	}
	
	/**
	 * 적부 워드 전환 권한자 목록 가져오기 Ajax
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "topSuitWordAuthListAjax")
	public String topSuitWordAuthListAjax(Model model, HttpServletRequest request, HttpSession session) throws Exception {
		logger.info("======= topSuitWordAuthListAjax =======");
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);		
		
		List<Map<String,Object>> authMemberList = sqlSession.selectList("ItMgmtMapper.selectTopSuitWordAuthMemberList", paramMap);
    	model.addAttribute("authMemberList",authMemberList);
		
		return "/sys_adm/top_suit_word_auth_list_ajax";
	}
	
	/**
	 * 적부 워드전환 권한 관리
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/sysSuitWorkAuthMain")
	public String sysSuitWorkAuthMain(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("==== sysSuitWorkAuthMain ==== ");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("sysRptCloseDateUpdate - no permession user_no : "+mbrVo.getUser_no());
			session.invalidate();
			return "top_login/top_login";
		}
		
		//재직중인 직원의 목록을 물러온다.
		List<Map<String, Object>> userList = sqlSession.selectList("StatisticBasic.selectTopMemberList");
		
		model.addAttribute("userList", userList);
		
		return "/sys_adm/top_suit_word_auth_main";
	}
	
	/**
	 * 보고서 협조건 수정 삭제 기능 by top3009
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/sysRptHelpManageMain")
	public String sysRptHelpManageMain(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("==== sysRptHelpManageMain ==== ");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("sysRptHelpManageMain - no permession user_no : "+mbrVo.getUser_no());
			session.invalidate();
			return "top_login/top_login";
		}
		
		return "/sys_adm/top_rpt_help_manage_list";
	}
	
	/**
	 * 종결일 수정 개선 by top3009
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/sysRptCloseDateUpdate")
	public String sysRptCloseDateUpdate(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("==== sysRptCloseDateUpdate ==== ");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("sysRptCloseDateUpdate - no permession user_no : "+mbrVo.getUser_no());
			session.invalidate();
			return "top_login/top_login";
		}
		
		return "/sys_adm/top_rpt_head_close_date_list";
	}	
		
	@RequestMapping(value = "/rpt_close_date_update", method = RequestMethod.GET)
	public String rpt_close_date_update(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("==== sysadm - rpt_close_date_update ==== ");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("PcMgmt rpt_close_date_update - no permession user_no : "+mbrVo.getUser_no());
			session.invalidate();
			return "top_login/top_login";
		}
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
        if ( paramMap.get("suim_accept_no") != null ) {
        	List<Map<String,Object>> rptList = sqlSession.selectList("ItMgmtMapper.selectRptCloseDate", paramMap);
        	model.addAttribute("rptList",rptList);
        }
        
		return "/sys_adm/pc_mgmt_rpt_close_date_update";
	}
	
	/**
	 * 적부 워드전환 권한 체크
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/suitWorkAuthChk", method = RequestMethod.POST)
	@ResponseBody
	public int suitWorkAuthChk(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("==== suitWorkAuthChk ==== ");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request); 
		
		String suimRptState = String.valueOf(paramMap.get("suim_rpt_state"));				//결재상태		
		
        int nResult = 0;
        
        TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
        
        String sUserNo = mbrVo.getUser_no();
        
        if( "2".equals(suimRptState) ) {
        	
        	nResult = sqlSession.selectOne("ItMgmtMapper.countTopSuitWordAuth", sUserNo);
        	
        	if( nResult > 0 ) {			//종결상태이지만 전환 권한이 있는경우
        		nResult = 1;
        	}else{							//종결상태로 권한이 없어 전환이 불가함
        		nResult = 9;
        	}
        	
        }else{
        	nResult = 1;					//종결상태가 아니면 전환이 가능함
        }        
        
        return nResult;
	}
	
	/**
	 * 적부 워드전환 권한 관리 Action
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/suitWorkAuthAction", method = RequestMethod.POST)
	@ResponseBody
	public int suitWorkAuthAction(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("==== suitWorkAuthAction ==== ");
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);        
        
        String sActionFlag = String.valueOf(paramMap.get("action_flag")); 
        String sUserNo = String.valueOf(paramMap.get("user_no"));
		
        int nResult = 0;
        int nDupChk = 0;
        
        if( sActionFlag.equals("I") ) {					//신규등록
        	//중복 체크
        	nDupChk = sqlSession.selectOne("ItMgmtMapper.countTopSuitWordAuth", sUserNo);
        	
        	if( nDupChk == 0 ) {
        		nResult = sqlSession.insert("ItMgmtMapper.insertTopSuitWordAuth", paramMap);        		
        	}else {
        		nResult = 9;
        	}        	
        }else if( sActionFlag.equals("D") ) {			//대상자 삭제
        	nResult = sqlSession.delete("ItMgmtMapper.deleteTopSuitWordAuth", paramMap);
        }
        
        return nResult;
	}
	
	/**
	 * 협조건 의뢰인 정보 갱신 / 삭제
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/rptHelpUserAction", method = RequestMethod.POST)
	@ResponseBody
	public int rptHelpUserAction(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("==== sysadm - rptHelpUserAction ==== ");
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);        
        
        String sActionFlag = String.valueOf(paramMap.get("action_flag"));
        String updateTeamId = "";
        
        int uptCnt = 0;
        
        if( "U".equals(sActionFlag) ) {
        	
        	updateTeamId = sqlSession.selectOne("ItMgmtMapper.selectTeamIdByUserNo", paramMap);
        	paramMap.put("edit_team_id", updateTeamId);
        	
        	uptCnt = sqlSession.update("ItMgmtMapper.updateRptHelpClientInfo", paramMap);
        }
        
        if( "D".equals(sActionFlag) ) {
        	uptCnt = sqlSession.delete("ItMgmtMapper.deleteRptHelpClientInfo", paramMap);
        }
        
		return uptCnt;
		
	}
	
	@RequestMapping(value = "/update_rpt_close_date", method = RequestMethod.POST)
	@ResponseBody
	public int update_rpt_close_date(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("==== sysadm - update_rpt_close_date ==== ");
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
        int uptCnt = sqlSession.update("ItMgmtMapper.updateRptCloseDate",paramMap);
        
		return uptCnt;
		
	}
	
	/** 
	 * 기존 카드 서버 데이터 마이그래에션 top_card_sync 테이블에 excel insert 후 작업
	 * @param request
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value="MigTopCardSync")
	public String MigTopCardSync(HttpServletRequest request, Model model, HttpSession session){
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		String sUserNo = mbrVo.getUser_no();
		
		if(!"1786".equals(sUserNo) ){
			logger.info("MigTopCardSync - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		
		logger.info("======== MigTopCardSync ========");		
		
		//동기화할 카드 목록을 불러온다.		
		List<Map<String, Object>> syncCardList = sqlSession.selectList("ItMgmtMapper.selectSyncCardList");
		String syncUserName = "";		//사용자 소유자 명
		String syncCardNumber = "";		//카드번호		
		int nChk = 0;		//카드 중복체크
		String realName = "";				//임시표시가 제거된 실제 이름
		int nCardType = 0;					//카드 상태(0:정상, 1:임시)
		int nChkMember = 0;				//인사정보 존재유무
		String insaState = "";				//퇴사여부
		String syncCardSerialNo = "";		//카드 시리얼번호
		
		for(int i=0; i < syncCardList.size(); i++) {
			syncUserName = syncCardList.get(i).get("user_name").toString();
			syncCardNumber = syncCardList.get(i).get("card_number").toString();
			syncCardSerialNo = syncCardList.get(i).get("card_serial_no").toString();
			
			nChk = sqlSession.selectOne("ItMgmtMapper.selectSyncCardChk", syncCardNumber);			//동기화할 카드 번호를 가지고 기존에 등록된 카드가 있는지 확인한다.
			
			if( nChk == 0 ) {			//기존에 등록된 카드가 없는 경우 추가한다.
				
				//카드정보에 등록할 최종 Map
				Map<String, Object> cardMap = new HashMap<String, Object>();
				//Map<String, Object> resultMap = new HashMap<String, Object>();
				
				//이름에 "(임시)"가 포함되어있는지 확인한다.
				if( syncUserName.contains("(임시)") ) {
					realName = syncUserName.replace("(임시)", "");
					nCardType = 1;		//임시
				}else{
					realName = syncUserName;
					nCardType = 0;		//정상
				}
				
				//인사정보에 동일한 직원명이 있는지 확인한다.
				nChkMember = sqlSession.selectOne("ItMgmtMapper.selectInsaCardChk",realName);
				
				if( nChkMember == 1 ) {			//한명이 존재하는 경우
					
					cardMap = sqlSession.selectOne("ItMgmtMapper.selectInsaCardInfo", realName);
					
					//System.out.println("정상등록 : "+realName + " : "+String.valueOf(cardMap.get("user_no")));
					
					//cardMap.put("user_no", String.valueOf(resultMap.get("user_no")));
					//cardMap.put("team_id", String.valueOf(resultMap.get("team_id")));
					
					insaState = String.valueOf(cardMap.get("user_state"));
					
					if( "1".equals(insaState) ) {			//카드 소유자가 퇴사자인 경우
						cardMap.put("card_state", 9);			//퇴사자 카드는 기타로 분류해 둔다.
					}else{
						cardMap.put("card_state", 1);			//사용중
					}
					
					
				}else if( nChkMember > 1 ) {	//동명이인 (수동확인 필요)
					System.out.println("동명이인 체크 : "+realName);
					cardMap.put("user_no", 0);
					cardMap.put("team_id", 0);					
					cardMap.put("card_state", 9);		//기타
				}else{									//인사정보없음 (카드만 등록)
					System.out.println("인사정보없음 체크 : "+realName);
					cardMap.put("user_no", 0);
					cardMap.put("team_id", 0);
					cardMap.put("card_state", 0);		//미사용
				}				
				
				cardMap.put("card_number", syncCardNumber);				
				cardMap.put("card_type", nCardType);
				cardMap.put("card_serial_no", syncCardSerialNo);
				//cardMap.put("card_zone", "2");			//카드지역:대구(2)
				
				//System.out.println( syncUserName +" : "+ cardMap.get("team_id").toString() + " : "+syncCardNumber + " : " +nChk+ " : " + realName + " : "+ nCardType+" : "+ syncCardSerialNo);
				//마이그래이션시 아래 insert 주석제거
				//sqlSession.insert("ItMgmtMapper.insertMigCardInfo",cardMap);				
			}
			
		}
		
	
		return "/sys_adm/card_manage_main";
	}
	
}//end of class
