package kr.co.toplac.topstatistics;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;

/*
*********************************************************
* Program ID	: MisRegPtnrController
* Program Name	: 
* Description	: 
* Author		: leedongik
* Date			: 2015.12.30.
* Update		: 
*********************************************************
*/
@Controller
public class MisRegPtnrController {

	private static final Logger logger = LoggerFactory.getLogger(MisRegTmController.class);

	@Autowired
	private SqlSession sqlSession;
	
	
	
	// =====================
	//  보험사별 - 수임현황
	// =====================
	@RequestMapping(value = "/MisRegPtnr")
	public String MisRegPtnr(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {
		logger.info("======= MisRegPtnr =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String teamType = String.valueOf(paramMap.get("team_type"));
        
        paramMap.put("team_type",teamType);
        
        //===============================================
        // 현재 일자 세팅
        //===============================================
        String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));  //기준일자 시작일
        String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));  //기준일자 종료일

        if ("".equals(stdBgnde)){
            stdBgnde = DateUtil.getStartMonthDay();
            stdEndde = DateUtil.getEndMonthDay();

            stdBgnde = DateUtil.getDateFormat(stdBgnde,"-");
            stdEndde = DateUtil.getDateFormat(stdEndde,"-");

            paramMap.put("stdBgnde",stdBgnde);
            paramMap.put("stdEndde",stdEndde);
            paramMap.put("excelYN", "N");

            //=============================================
            // 수임 농작물 적부 기본값 세팅
            //=============================================
            paramMap.put("basicYN", "Y");
            paramMap.put("primYN", "Y");
        }
        
        //===============================================
        // 필요 날짜 SET
        //===============================================
        String bgnDe = stdBgnde.replace("-","");
        String endDe = DateUtil.addDate(stdEndde.replace("-",""),1);
        String bgnYearDe = (Integer.parseInt(endDe.substring(0,4)) - 1)  + "1216";
        String endYearDe = endDe.substring(0,4) + "1216";

        paramMap.put("bgnDe", bgnDe);
        paramMap.put("endDe", endDe);
        paramMap.put("bgnYearDe", bgnYearDe);
        paramMap.put("endYearDe", endYearDe);
				
        StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", endDe);
        nowVO.setBasicYN( String.valueOf(paramMap.get("basicYN")) );
        nowVO.setPrimYN( String.valueOf(paramMap.get("primYN")) );

		//List<MisRegTmVO> MisRegPtnr1 = sqlSession.selectList("MisRegPtnrMapper.MisRegPtnr1", nowVO);
		//model.addAttribute("MisRegPtnr1",MisRegPtnr1);
        
        //물보험 조사 별도 통계
        List<MisRegTmVO> MisRegPtnr1Main = sqlSession.selectList("MisRegPtnrMapper.MisRegPtnr1Main", nowVO);
		model.addAttribute("MisRegPtnr1Main",MisRegPtnr1Main);
		
		//물보험 심사 별도 통계 시작
		List<MisRegTmVO> MisRegPtnr1Written = sqlSession.selectList("MisRegPtnrMapper.MisRegPtnr1Written", nowVO);
		
		//서면심사 팀에 지정된 보험사 목록을 불러온다. (ptnr_id = 0은 제외)
        List<Map<String,Object>> writtenPtnrIdList = sqlSession.selectList("MisPtnrBsc.selectWrittenPtnrIdList"); 
        
        //보험사(심사)임시Map
        MisRegTmVO writtenPtnrMap = new MisRegTmVO();
        
        String sPtnrId = "";				//보고서 내 보험사코드
        String sPtnrIdChk = "";			//별도로 카운트해야하는 보험사 코드
        
        for(int i=0; i < MisRegPtnr1Written.size(); i++) {        	
        	//보고서에서 추출된 보험사코드
        	sPtnrId = StringUtil.null2blank(MisRegPtnr1Written.get(i).getPtnr_id());
        	
        	for(int k=0; k < writtenPtnrIdList.size(); k++) {        		
        		sPtnrIdChk = String.valueOf(writtenPtnrIdList.get(k).get("ptnr_id"));			//별도계산할 보험사 코드
        		
        		//보고서의 보험사코드와 별도 심사 건수 등록보험사의경우는 건수를 다시 가져온다.
        		if( sPtnrId.equals(sPtnrIdChk) ) {
        			
        			//재쿼리할 보험사 Id를 셋팅한다.
        			nowVO.setPtnr_id(sPtnrId);
        			
        			writtenPtnrMap = sqlSession.selectOne("MisRegPtnrMapper.MisRegPtnr1WrittenExtra", nowVO);
        			
        			MisRegPtnr1Written.get(i).setReg_12(writtenPtnrMap.getReg_12());
        			MisRegPtnr1Written.get(i).setReg_11(writtenPtnrMap.getReg_11());
        			MisRegPtnr1Written.get(i).setReg_10(writtenPtnrMap.getReg_10());
        			MisRegPtnr1Written.get(i).setReg_9(writtenPtnrMap.getReg_9());
        			MisRegPtnr1Written.get(i).setReg_8(writtenPtnrMap.getReg_8());
        			MisRegPtnr1Written.get(i).setReg_7(writtenPtnrMap.getReg_7());
        			MisRegPtnr1Written.get(i).setReg_6(writtenPtnrMap.getReg_6());
        			MisRegPtnr1Written.get(i).setReg_5(writtenPtnrMap.getReg_5());
        			MisRegPtnr1Written.get(i).setReg_4(writtenPtnrMap.getReg_4());
        			MisRegPtnr1Written.get(i).setReg_3(writtenPtnrMap.getReg_3());
        			MisRegPtnr1Written.get(i).setReg_2(writtenPtnrMap.getReg_2());
        			MisRegPtnr1Written.get(i).setReg_1(writtenPtnrMap.getReg_1());
        			
        			MisRegPtnr1Written.get(i).setCls_12(writtenPtnrMap.getCls_12());
        			MisRegPtnr1Written.get(i).setCls_11(writtenPtnrMap.getCls_11());
        			MisRegPtnr1Written.get(i).setCls_10(writtenPtnrMap.getCls_10());
        			MisRegPtnr1Written.get(i).setCls_9(writtenPtnrMap.getCls_9());
        			MisRegPtnr1Written.get(i).setCls_8(writtenPtnrMap.getCls_8());
        			MisRegPtnr1Written.get(i).setCls_7(writtenPtnrMap.getCls_7());
        			MisRegPtnr1Written.get(i).setCls_6(writtenPtnrMap.getCls_6());
        			MisRegPtnr1Written.get(i).setCls_5(writtenPtnrMap.getCls_5());
        			MisRegPtnr1Written.get(i).setCls_4(writtenPtnrMap.getCls_4());
        			MisRegPtnr1Written.get(i).setCls_3(writtenPtnrMap.getCls_3());
        			MisRegPtnr1Written.get(i).setCls_2(writtenPtnrMap.getCls_2());
        			MisRegPtnr1Written.get(i).setCls_1(writtenPtnrMap.getCls_1());
        		}
        	}
        } 
		
		
		model.addAttribute("MisRegPtnr1Written",MisRegPtnr1Written);		
		//물보험 심사 별도 통계 끝		

		List<MisRegTmVO> MisRegPtnr4 = sqlSession.selectList("MisRegPtnrMapper.MisRegPtnr4", nowVO);
		model.addAttribute("MisRegPtnr4",MisRegPtnr4);

		model.addAttribute("nowVO", nowVO);

//		model.addAttribute("inVO", inVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/mis_reg_ptnr";
	}
	
	
	// ============================
	//  보험사별 - 수임현황 - 팀별
	// ============================
	@RequestMapping(value = "/MisRegPtnrTm")
	public String getMisRegTm(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= getMisRegTm =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			logger.info("getMisRegTm - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		//검색 로그 남기기 시작 (20240109)
		String sUserNo = mbrVo.getUser_no();		
		String sUserName = mbrVo.getUser_name();
		String sIp = mbrVo.getUser_ip();
		String sLogPage = "수임현황";

		Map<String, Object> logMap = new HashMap<String, Object>();

		logMap.put("user_no", sUserNo);
		logMap.put("user_name", sUserName);
		logMap.put("user_ip", sIp);
		logMap.put("search_page", sLogPage);

		sqlSession.insert("SaveLogMapper.insertTopSearchLog",logMap);
		//검색 로그 남기기 끝 (20240109)

        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String teamId = String.valueOf(paramMap.get("team_id"));
        String teamName = String.valueOf(paramMap.get("team_name"));
        String teamType = String.valueOf(paramMap.get("team_type"));
        
        paramMap.put("team_id",teamId);
        paramMap.put("team_name",teamName);
        paramMap.put("team_type",teamType);
        
        //===============================================
        // 현재 일자 세팅
        //===============================================
        String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));  //기준일자 시작일
        String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));  //기준일자 종료일

        if ("".equals(stdBgnde)){
            stdBgnde = DateUtil.getStartMonthDay();
            stdEndde = DateUtil.getEndMonthDay();

            stdBgnde = DateUtil.getDateFormat(stdBgnde,"-");
            stdEndde = DateUtil.getDateFormat(stdEndde,"-");

            paramMap.put("stdBgnde",stdBgnde);
            paramMap.put("stdEndde",stdEndde);
            paramMap.put("excelYN", "N");

            //=============================================
            // 수임 농작물 적부 기본값 세팅
            //=============================================
            paramMap.put("basicYN", "Y");
            paramMap.put("primYN", "Y");
        }
        

        //===============================================
        // 필요 날짜 SET
        //===============================================
        String bgnDe = stdBgnde.replace("-","");
        String endDe = DateUtil.addDate(stdEndde.replace("-",""),1);
        String bgnYearDe = (Integer.parseInt(endDe.substring(0,4)) - 1)  + "1216";
        String endYearDe = endDe.substring(0,4) + "1216";

        paramMap.put("bgnDe", bgnDe);
        paramMap.put("endDe", endDe);
        paramMap.put("bgnYearDe", bgnYearDe);
        paramMap.put("endYearDe", endYearDe);
		
		
        StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", endDe);
        nowVO.setBasicYN( String.valueOf(paramMap.get("basicYN")) );
        nowVO.setPrimYN( String.valueOf(paramMap.get("primYN")) );
		nowVO.setPtnr_id(inVO.getPtnr_id());
		nowVO.setPtnr_nick(inVO.getPtnr_nick());
		
		/*
		String tmpNow_to = "";
		if(inVO.getViewToDate() == null || inVO.getViewToDate().equals("")){
			DateFormat tmpFormat = new SimpleDateFormat("yyyy-MM-16");
			Date tmpToday = new Date();
			tmpNow_to = tmpFormat.format(tmpToday);
		}else{
			tmpNow_to = inVO.getViewToDate();
		}
		inVO.setViewToDate(tmpNow_to);
		StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", tmpNow_to);
		nowVO.setTeam_id(inVO.getTeam_id());
		*/
		
		
//		List<MisRegTmVO> MisRegPtnrTm1 = sqlSession.selectList("MisRegPtnrTmMapper.MisRegPtnrTm1", nowVO);
		List<MisRegTmVO> MisRegPtnrTm1 = sqlSession.selectList("MisRegPtnrTmMapper.selectMisRegPtnrTm1", nowVO);
		model.addAttribute("MisRegPtnrTm1",MisRegPtnrTm1);

//		List<MisRegTmVO> MisRegPtnrTm4 = sqlSession.selectList("MisRegPtnrTmMapper.MisRegPtnrTm4", nowVO);
		List<MisRegTmVO> MisRegPtnrTm4 = sqlSession.selectList("MisRegPtnrTmMapper.selectMisRegPtnrTm4", nowVO);
		model.addAttribute("MisRegPtnrTm4",MisRegPtnrTm4);

		model.addAttribute("nowVO", nowVO);

//		model.addAttribute("inVO", inVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/mis_reg_ptnr_tm";
	}

	// ==================================
	//  보험사별 - 수임현황 - 팀별 - 팀원
	// ==================================
	@RequestMapping(value = "/MisRegPtnrTmMbr")
	public String MisRegPtnrTmMbr(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= MisRegPtnrTmMbr =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			logger.info("MisRegPtnrTmMbr - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String teamId = String.valueOf(paramMap.get("team_id"));
        String teamType = String.valueOf(paramMap.get("team_type"));
        
        paramMap.put("team_id",teamId);
        paramMap.put("team_type",teamType);
        
        //===============================================
        // 현재 일자 세팅
        //===============================================
        String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));  //기준일자 시작일
        String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));  //기준일자 종료일

        if ("".equals(stdBgnde)){
            stdBgnde = DateUtil.getStartMonthDay();
            stdEndde = DateUtil.getEndMonthDay();

            stdBgnde = DateUtil.getDateFormat(stdBgnde,"-");
            stdEndde = DateUtil.getDateFormat(stdEndde,"-");

            paramMap.put("stdBgnde",stdBgnde);
            paramMap.put("stdEndde",stdEndde);
            paramMap.put("excelYN", "N");

            //=============================================
            // 수임 농작물 적부 기본값 세팅
            //=============================================
            paramMap.put("basicYN", "Y");
            paramMap.put("primYN", "Y");
        }
        

        //===============================================
        // 필요 날짜 SET
        //===============================================
        String bgnDe = stdBgnde.replace("-","");
        String endDe = DateUtil.addDate(stdEndde.replace("-",""),1);
        String bgnYearDe = (Integer.parseInt(endDe.substring(0,4)) - 1)  + "1216";
        String endYearDe = endDe.substring(0,4) + "1216";

        paramMap.put("bgnDe", bgnDe);
        paramMap.put("endDe", endDe);
        paramMap.put("bgnYearDe", bgnYearDe);
        paramMap.put("endYearDe", endYearDe);
		
		
        StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", endDe);
        nowVO.setBasicYN( String.valueOf(paramMap.get("basicYN")) );
        nowVO.setPrimYN( String.valueOf(paramMap.get("primYN")) );
		nowVO.setPtnr_id(inVO.getPtnr_id());
		nowVO.setPtnr_nick(inVO.getPtnr_nick());
		nowVO.setTeam_type(teamType);
		nowVO.setTeam_id(teamId);
		
		/*
		String tmpNow_to = "";
		if(inVO.getViewToDate() == null || inVO.getViewToDate().equals("")){
			DateFormat tmpFormat = new SimpleDateFormat("yyyy-MM-16");
			Date tmpToday = new Date();
			tmpNow_to = tmpFormat.format(tmpToday);
		}else{
			tmpNow_to = inVO.getViewToDate();
		}
		inVO.setViewToDate(tmpNow_to);
		StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", tmpNow_to);
		nowVO.setTeam_id(inVO.getTeam_id());
		*/
		
//		List<MisRegTmVO> MisRegTmMbr1 = sqlSession.selectList("MisRegPtnrTmMbrMapper.MisRegPtnrTmMbr1", nowVO);
		List<MisRegTmVO> MisRegTmMbr1 = sqlSession.selectList("MisRegPtnrTmMbrMapper.selectMisRegPtnrTmMbr", nowVO);
		
		
		
		model.addAttribute("MisRegTmMbr1",MisRegTmMbr1);

		model.addAttribute("nowVO", nowVO);

//		model.addAttribute("inVO", inVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/mis_reg_ptnr_tm_mbr";
	}
	
	
	


	/*
	*********************************************************
	* Program ID	: MisBscPtnr
	* Program Name	: MisBscPtnr
	* Description	: 보험사별 기본통계
	* Author		: 임대성
	* Date			: 2017.03.13.
	* Update		: 
	*********************************************************
	*/
	@RequestMapping(value = "/MisBscPtnr")
	public String MisRegPtnrBsc(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {
		logger.info("======= MisBscPtnr =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			logger.info("MisBscPtnr - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

		//검색 로그 남기기 시작 (20240109)
		String sUserNo = mbrVo.getUser_no();		
		String sUserName = mbrVo.getUser_name();
		String sIp = mbrVo.getUser_ip();
		String sLogPage = "보험사별통계(기본통계)";

		Map<String, Object> logMap = new HashMap<String, Object>();

		logMap.put("user_no", sUserNo);
		logMap.put("user_name", sUserName);
		logMap.put("user_ip", sIp);
		logMap.put("search_page", sLogPage);

		sqlSession.insert("SaveLogMapper.insertTopSearchLog",logMap);
		//검색 로그 남기기 끝 (20240109)
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String teamId = String.valueOf(paramMap.get("team_id"));
        String teamName = String.valueOf(paramMap.get("team_name"));
        String teamType = String.valueOf(paramMap.get("team_type"));
        
        paramMap.put("team_id",teamId);
        paramMap.put("team_name",teamName);
        paramMap.put("team_type",teamType);
        
        //===============================================
        // 현재 일자 세팅
        //===============================================
        String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));  //기준일자 시작일
        String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));  //기준일자 종료일

        if ("".equals(stdBgnde)){
            stdBgnde = DateUtil.getStartMonthDay();
            stdEndde = DateUtil.getEndMonthDay();

            stdBgnde = DateUtil.getDateFormat(stdBgnde,"-");
            stdEndde = DateUtil.getDateFormat(stdEndde,"-");

            paramMap.put("stdBgnde",stdBgnde);
            paramMap.put("stdEndde",stdEndde);
            paramMap.put("excelYN", "N");

            //=============================================
            // 수임 농작물 적부 기본값 세팅
            //=============================================
            paramMap.put("basicYN", "Y");
            paramMap.put("primYN", "Y");
        }
        

        //===============================================
        // 필요 날짜 SET
        //===============================================
        String bgnDe = stdBgnde.replace("-","");
        String endDe = DateUtil.addDate(stdEndde.replace("-",""),1);
        String bgnYearDe = (Integer.parseInt(endDe.substring(0,4)) - 1)  + "1216";
        String endYearDe = endDe.substring(0,4) + "1216";

        paramMap.put("bgnDe", bgnDe);
        paramMap.put("endDe", endDe);
        paramMap.put("bgnYearDe", bgnYearDe);
        paramMap.put("endYearDe", endYearDe);
		
		//1종 보험사별 기본정보
        //List<MisPtnrBscVO> MisBscPtnr1 = sqlSession.selectList("MisPtnrBsc.getMisPtnrBsc1", inVO);
        
        //List<MisPtnrBscVO> MisBscPtnr1 = sqlSession.selectList("MisPtnrBsc.selectMisPtnrBsc1", paramMap);
        
        //1종 조사자 통계정보로 분리
        List<MisPtnrBscVO> MisBscPtnr1Main = sqlSession.selectList("MisPtnrBsc.selectMisPtnrBsc1Main", paramMap);
        
        model.addAttribute("MisBscPtnr1Main",MisBscPtnr1Main);
        
        //1종 보험사(심사) 통계정보가져오기
        List<MisPtnrBscVO> MisBscPtnr1Written = sqlSession.selectList("MisPtnrBsc.selectMisPtnrBsc1Written", paramMap);
        
        //별도 심사 보험사계산 시작
        
        //서면심사 팀에 지정된 보험사 목록을 불러온다. (ptnr_id = 0은 제외)
        List<Map<String,Object>> writtenPtnrIdList = sqlSession.selectList("MisPtnrBsc.selectWrittenPtnrIdList"); 
        
        //보험사(심사)임시Map
        Map<String,Object> writtenPtnrMap = new HashMap<String, Object>();
        
        String sPtnrId = "";				//보고서 내 보험사코드
        String sPtnrIdChk = "";			//별도로 카운트해야하는 보험사 코드
        
        for(int i=0; i < MisBscPtnr1Written.size(); i++) {        	
        	//보고서에서 추출된 보험사코드
        	sPtnrId = StringUtil.null2blank(MisBscPtnr1Written.get(i).getPtnr_id());
        	
        	for(int k=0; k < writtenPtnrIdList.size(); k++) {        		
        		sPtnrIdChk = String.valueOf(writtenPtnrIdList.get(k).get("ptnr_id"));			//별도계산할 보험사 코드
        		
        		//보고서의 보험사코드와 별도 심사 건수 등록보험사의경우는 건수를 다시 가져온다.
        		if( sPtnrId.equals(sPtnrIdChk) ) {
        			//심사용 수임, 종결 미결 건수 재등록        			
        			writtenPtnrMap = getPtnrWrittenListSum(sPtnrId,bgnDe,endDe);        			
        			MisBscPtnr1Written.get(i).setSuim_m(String.valueOf(writtenPtnrMap.get("sumSuimCnt")));
        			MisBscPtnr1Written.get(i).setSuim_y(String.valueOf(writtenPtnrMap.get("sumYearSuimCnt")));
        			MisBscPtnr1Written.get(i).setClose_m(String.valueOf(writtenPtnrMap.get("sumEndCnt")));
        			MisBscPtnr1Written.get(i).setClose_y(String.valueOf(writtenPtnrMap.get("sumYearEndCnt")));
        			MisBscPtnr1Written.get(i).setSuim_mi(String.valueOf(writtenPtnrMap.get("sumUnsolveCnt")));        			
        		}
        	}
        }
        
        model.addAttribute("MisBscPtnr1Written",MisBscPtnr1Written);
        //별도 심사 보험사계산 끝
		
		//4종 보험사별 기본정보
		//List<MisPtnrBscVO> MisBscPtnr4 = sqlSession.selectList("MisPtnrBsc.getMisPtnrBsc4", inVO);
        List<MisPtnrBscVO> MisBscPtnr4 = sqlSession.selectList("MisPtnrBsc.selectMisPtnrBsc4", paramMap);
        
		//model.addAttribute("MisBscPtnr1",MisBscPtnr1);
		model.addAttribute("MisBscPtnr4",MisBscPtnr4);
		
		
//		model.addAttribute("inVO", inVO);
		model.addAttribute("srchArg", paramMap);
		
		
		return "top_statistics/mis_ptnr_bsc";
	}
	
	/**
	 * 보험사별 서면심사 수임, 종결, 미결건수 가져오기
	 * @param sPtnrId : 대상 보험사 아이디
	 * @param sDate : 합산 시작일
	 * @param eDate : 합산 종료일
	 * @return Map
	 */
	public Map<String,Object> getPtnrWrittenListSum(String sPtnrId, String sDate, String eDate) {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("ptnr_id", sPtnrId);		
		paramMap.put("sdate", sDate);
		paramMap.put("edate", eDate);
		
		List<Map<String, Object>> calList;
		
		paramMap.put("base_date", DateUtil.addDate(DateUtil.getTodayString(), 1));
				
		calList = sqlSession.selectList("StatisticBasic.selectSumPtnrWrittenList", paramMap);
		resultMap.put("sumSuimCnt", calList.get(0).get("suimCnt"));
		resultMap.put("sumEndCnt", calList.get(0).get("endCnt"));
		resultMap.put("sumUnsolveCnt", calList.get(0).get("unsolveCnt"));		
		
		String beforeSmonth = DateUtil.getBeforeStartMonthDate(sDate);		//지난달 시작일자
		String beforeEmonth = DateUtil.getBeforeStartMonthDate(eDate);		//지난달 종료일자
		
		paramMap.put("sdate", beforeSmonth);
		paramMap.put("edate", beforeEmonth);
		
		paramMap.put("base_date", beforeEmonth);
		
		//오늘 날짜보다 전달의 기준날짜가 큰경우는 0으로 처리한다.
		String sToday = DateUtil.getTodayString();
		
		if( Integer.parseInt(sToday) < Integer.parseInt(beforeEmonth) ) {			
			resultMap.put("sumBeforeUnsolveCnt", 0);			//지난달 미결건수
		}else{			
			calList = sqlSession.selectList("StatisticBasic.selectSumPtnrWrittenList", paramMap);			
			resultMap.put("sumBeforeUnsolveCnt", calList.get(0).get("unsolveCnt"));			//지난달 미결건수
		}		
		
		//년도 정보 가져오기
		String bgnYearDe = (Integer.parseInt(eDate.substring(0, 4)) - 1) + "1216";
		String endYearDe = eDate.substring(0, 4) + "1216";
		
		paramMap.put("sdate", bgnYearDe);
		paramMap.put("edate", endYearDe);
		
		calList = sqlSession.selectList("StatisticBasic.selectSumPtnrWrittenList", paramMap);			
		resultMap.put("sumYearSuimCnt", calList.get(0).get("suimCnt"));			//년누계처리건수
		resultMap.put("sumYearEndCnt", calList.get(0).get("endCnt"));				//년누계절대건수				
		
		return resultMap;
	}
	
}//class
