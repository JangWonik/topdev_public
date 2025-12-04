package kr.co.toplac.topstatistics;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.topstatistics.StatisticsNowVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;

/*
*********************************************************
* Program ID	: MisEndTmController
* Program Name	: 
* Description	: 
* Author		: leedongik
* Date			: 2015.12.30.
* Update		: 20180827, 일반, 농작물 분리 (lds)
*********************************************************
*/
@Controller
public class MisEndTmController {

	private static final Logger logger = LoggerFactory.getLogger(MisEndTmController.class);

	@Autowired
	private SqlSession sqlSession;

	//팀별 절대건수
	@RequestMapping(value = "/MisEndTm")
	public String MisEndTm(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= MisEndTm =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			
			session.invalidate();
			return "top_login/top_login";
		}
		
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

        //StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", bgnDe);          
        
        StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", endDe);
        nowVO.setBasicYN( String.valueOf(paramMap.get("basicYN")) );
        nowVO.setPrimYN( String.valueOf(paramMap.get("primYN")) );
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
		*/
		

		List<MisEndTmVO> MisEndTm1 = sqlSession.selectList("MisEndTmMapper.MisEndTm1", nowVO);
		
		//1종 서면심사 팀 통계를 별도로 처리하기위한 기능 추가 시작 by top3009
		String sChk_written = "0";			//서면심사팀 여부
		
		MisEndTmVO MisEndTm1Temp = new MisEndTmVO();			//1종 서면심사팀용 값을 셋팅하기위한 임시 Bean
		
		for( int i=0; i < MisEndTm1.size(); i++) {
			sChk_written = MisEndTm1.get(i).getTeam_written();			
			
			//서면심사 팀인경우 통계값을 별도로 가져온다.			
			if( "1".equals(sChk_written) ) {
				nowVO.setTeam_id(MisEndTm1.get(i).getTeam_id());
				//System.out.println("team_id="+nowVO.getTeam_id()+" : "+nowVO.getMonBefore0());
				
				MisEndTm1Temp = sqlSession.selectOne("MisEndTmMapper.MisEndWrittenTm1", nowVO);
				
				MisEndTm1.get(i).setEnd_rid(MisEndTm1Temp.getEnd_rid());
				MisEndTm1.get(i).setEnd_rid2(MisEndTm1Temp.getEnd_rid2());
				MisEndTm1.get(i).setEnd_rid3(MisEndTm1Temp.getEnd_rid3());
				MisEndTm1.get(i).setEnd_rid4(MisEndTm1Temp.getEnd_rid4());
				MisEndTm1.get(i).setEnd_rid5(MisEndTm1Temp.getEnd_rid5());
				MisEndTm1.get(i).setEnd_rid6(MisEndTm1Temp.getEnd_rid6());
				MisEndTm1.get(i).setEnd_rid7(MisEndTm1Temp.getEnd_rid7());
				MisEndTm1.get(i).setEnd_rid8(MisEndTm1Temp.getEnd_rid8());
				MisEndTm1.get(i).setEnd_rid9(MisEndTm1Temp.getEnd_rid9());
				MisEndTm1.get(i).setEnd_rid10(MisEndTm1Temp.getEnd_rid10());
				MisEndTm1.get(i).setEnd_rid11(MisEndTm1Temp.getEnd_rid11());
				MisEndTm1.get(i).setEnd_rid12(MisEndTm1Temp.getEnd_rid12());
			}
		}		
		//1종 서면심사 팀 통계를 별도로 처리하기위한 기능 추가 끝 by top3009
		
		
		model.addAttribute("MisEndTm1",MisEndTm1);
		
		List<MisEndTmVO> MisEndTm4 = sqlSession.selectList("MisEndTmMapper.MisEndTm4", nowVO);
		model.addAttribute("MisEndTm4",MisEndTm4);

		model.addAttribute("nowVO", nowVO);

        model.addAttribute("srchArg",paramMap);
//		model.addAttribute("inVO", inVO);		

		return "top_statistics/mis_end_tm";
	}
	
	
	
	//팀별 순수 피
	@RequestMapping(value = "/MisEndTmAssess")
	public String MisEndTmAssess(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= MisEndTmAssess =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			
			session.invalidate();
			return "top_login/top_login";
		}
		
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

        //StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", bgnDe);
        StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", endDe);
        nowVO.setBasicYN( String.valueOf(paramMap.get("basicYN")) );
        nowVO.setPrimYN( String.valueOf(paramMap.get("primYN")) );
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
		

		List<MisEndTmVO> MisEndTmAssess1 = sqlSession.selectList("MisEndTmMapper.MisEndTmAssess1", nowVO);
		model.addAttribute("MisEndTmAssess1",MisEndTmAssess1);
		
		List<MisEndTmVO> MisEndTmAssess4 = sqlSession.selectList("MisEndTmMapper.MisEndTmAssess4", nowVO);
		model.addAttribute("MisEndTmAssess4",MisEndTmAssess4);


		model.addAttribute("nowVO", nowVO);

		model.addAttribute("srchArg",paramMap);
//		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_end_tm_assess";
	}
	
	
	//팀별 일비
	@RequestMapping(value = "/MisEndTmTime")
	public String MisEndTmTime(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= MisEndTmTime =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			
			session.invalidate();
			return "top_login/top_login";
		}
		
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

        //StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", bgnDe);
        StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", endDe);
        nowVO.setBasicYN( String.valueOf(paramMap.get("basicYN")) );
        nowVO.setPrimYN( String.valueOf(paramMap.get("primYN")) );
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
		
		List<MisEndTmVO> MisEndTmTime1 = sqlSession.selectList("MisEndTmMapper.MisEndTmTime1", nowVO);
		model.addAttribute("MisEndTmTime1",MisEndTmTime1);
		
		List<MisEndTmVO> MisEndTmTime4 = sqlSession.selectList("MisEndTmMapper.MisEndTmTime4", nowVO);
		model.addAttribute("MisEndTmTime4",MisEndTmTime4);


		model.addAttribute("nowVO", nowVO);

		model.addAttribute("srchArg",paramMap);
//		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_end_tm_time";
	}
	
	
	//팀별 교통비
	@RequestMapping(value = "/MisEndTmTraffic")
	public String MisEndTmTraffic(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= MisEndTmTraffic =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			
			session.invalidate();
			return "top_login/top_login";
		}

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

        //StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", bgnDe);
        StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", endDe);
        nowVO.setBasicYN( String.valueOf(paramMap.get("basicYN")) );
        nowVO.setPrimYN( String.valueOf(paramMap.get("primYN")) );
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

		List<MisEndTmVO> MisEndTmTraffic1 = sqlSession.selectList("MisEndTmMapper.MisEndTmTraffic1", nowVO);
		model.addAttribute("MisEndTmTraffic1",MisEndTmTraffic1);
		
		List<MisEndTmVO> MisEndTmTraffic4 = sqlSession.selectList("MisEndTmMapper.MisEndTmTraffic4", nowVO);
		model.addAttribute("MisEndTmTraffic4",MisEndTmTraffic4);

		model.addAttribute("nowVO", nowVO);

		model.addAttribute("srchArg",paramMap);
//		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_end_tm_traffic";
	}
	
	
	//팀별 자문료 기타
	@RequestMapping(value = "/MisEndTmQr")
	public String MisEndTmQr(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= MisEndTmQr =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			
			session.invalidate();
			return "top_login/top_login";
		}

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

        //StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", bgnDe);
        StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", endDe);
        nowVO.setBasicYN( String.valueOf(paramMap.get("basicYN")) );
        nowVO.setPrimYN( String.valueOf(paramMap.get("primYN")) );
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

		List<MisEndTmVO> MisEndTmQr1 = sqlSession.selectList("MisEndTmMapper.MisEndTmQr1", nowVO);
		model.addAttribute("MisEndTmQr1",MisEndTmQr1);
		
		List<MisEndTmVO> MisEndTmQr4 = sqlSession.selectList("MisEndTmMapper.MisEndTmQr4", nowVO);
		model.addAttribute("MisEndTmQr4",MisEndTmQr4);


		model.addAttribute("nowVO", nowVO);

		model.addAttribute("srchArg",paramMap);
//		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_end_tm_qr";
	}
	
	//팀별 합계
	@RequestMapping(value = "/MisEndTmTotal")
	public String MisEndTmTotal(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= MisEndTmTotal =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			
			session.invalidate();
			return "top_login/top_login";
		}

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

        //StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", bgnDe);
        StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", endDe);
        nowVO.setBasicYN( String.valueOf(paramMap.get("basicYN")) );
        nowVO.setPrimYN( String.valueOf(paramMap.get("primYN")) );
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

		List<MisEndTmVO> MisEndTmTotal1 = sqlSession.selectList("MisEndTmMapper.MisEndTmTotal1", nowVO);
		model.addAttribute("MisEndTmTotal1",MisEndTmTotal1);
		
		List<MisEndTmVO> MisEndTmTotal4 = sqlSession.selectList("MisEndTmMapper.MisEndTmTotal4", nowVO);
		model.addAttribute("MisEndTmTotal4",MisEndTmTotal4);


		model.addAttribute("nowVO", nowVO);

		model.addAttribute("srchArg",paramMap);
//		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_end_tm_total";
	}
	
	
	
	
	
	
	
	
	//개인별
	@RequestMapping(value = "/MisEndTmMbr")
	public String MisEndTmMbr(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= MisEndTmMbr =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			
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

        //StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", bgnDe);
        StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", endDe);
        nowVO.setBasicYN( String.valueOf(paramMap.get("basicYN")) );
        nowVO.setPrimYN( String.valueOf(paramMap.get("primYN")) );
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
		nowVO.setPtnr_id(inVO.getPtnr_id());
		String ptnr_nick = inVO.getPtnr_nick();
		model.addAttribute("ptnr_nick",ptnr_nick);
		String ptnr_id = inVO.getPtnr_id();
		model.addAttribute("ptnr_id",ptnr_id);
		*/
        
        List<MisEndTmVO> MisEndTmMbr = sqlSession.selectList("MisEndTmMapper.MisEndTmMbr", nowVO);
        
        MisEndTmVO MisEndTmMbrTemp = new MisEndTmVO();
        
        for(int i = 0; i < MisEndTmMbr.size(); i++) {
        	//1종 서면심사인경우만 별도처리
        	if( "1".equals(MisEndTmMbr.get(i).getTeam_written().toString()) ){        		
        		nowVO.setUser_no(MisEndTmMbr.get(i).getUser_no());        		
        		MisEndTmMbrTemp = sqlSession.selectOne("MisEndTmMapper.MisEndWrittenTmMbr", nowVO);
        		MisEndTmMbr.get(i).setEnd_rid(MisEndTmMbrTemp.getEnd_rid());
        		MisEndTmMbr.get(i).setEnd_rid2(MisEndTmMbrTemp.getEnd_rid2());
        		MisEndTmMbr.get(i).setEnd_rid3(MisEndTmMbrTemp.getEnd_rid3());
        		MisEndTmMbr.get(i).setEnd_rid4(MisEndTmMbrTemp.getEnd_rid4());
        		MisEndTmMbr.get(i).setEnd_rid5(MisEndTmMbrTemp.getEnd_rid5());
        		MisEndTmMbr.get(i).setEnd_rid6(MisEndTmMbrTemp.getEnd_rid6());
        		MisEndTmMbr.get(i).setEnd_rid7(MisEndTmMbrTemp.getEnd_rid7());
        		MisEndTmMbr.get(i).setEnd_rid8(MisEndTmMbrTemp.getEnd_rid8());
        		MisEndTmMbr.get(i).setEnd_rid9(MisEndTmMbrTemp.getEnd_rid9());
        		MisEndTmMbr.get(i).setEnd_rid10(MisEndTmMbrTemp.getEnd_rid10());
        		MisEndTmMbr.get(i).setEnd_rid11(MisEndTmMbrTemp.getEnd_rid11());
        		MisEndTmMbr.get(i).setEnd_rid12(MisEndTmMbrTemp.getEnd_rid12());
        	}
        	
        }
        
		
		model.addAttribute("MisEndTmMbr",MisEndTmMbr);

		model.addAttribute("nowVO", nowVO);
		
        model.addAttribute("srchArg",paramMap);
//		model.addAttribute("inVO", inVO);	
		

		return "top_statistics/mis_end_tm_mbr";
	}
//	
	@RequestMapping(value = "/MisEndTmMbrAssess")
	public String MisEndTmMbrAssess(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= MisEndTmMbrAssess =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			
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

        //StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", bgnDe);
        StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", endDe);
        nowVO.setBasicYN( String.valueOf(paramMap.get("basicYN")) );
        nowVO.setPrimYN( String.valueOf(paramMap.get("primYN")) );
        nowVO.setTeam_id(teamId);			
        nowVO.setTeam_type(teamType);			

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
		nowVO.setPtnr_id(inVO.getPtnr_id());
		String ptnr_nick = inVO.getPtnr_nick();
		model.addAttribute("ptnr_nick",ptnr_nick);
		String ptnr_id = inVO.getPtnr_id();
		model.addAttribute("ptnr_id",ptnr_id);
	 	*/
        
        
    	List<MisEndTmVO> MisEndTmMbrAssess = sqlSession.selectList("MisEndTmMapper.MisEndTmMbrAssess", nowVO);
        model.addAttribute("MisEndTmMbrAssess",MisEndTmMbrAssess);
		

		model.addAttribute("nowVO", nowVO);

        model.addAttribute("srchArg",paramMap);
//		model.addAttribute("inVO", inVO);	

		return "top_statistics/mis_end_tm_mbr_assess";
	}
//	
	@RequestMapping(value = "/MisEndTmMbrTime")
	public String MisEndTmMbrTime(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= MisEndTmMbrTime =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			
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

        //StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", bgnDe);
        StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", endDe);
        nowVO.setBasicYN( String.valueOf(paramMap.get("basicYN")) );
        nowVO.setPrimYN( String.valueOf(paramMap.get("primYN")) );
        nowVO.setTeam_id(teamId);			
        nowVO.setTeam_type(teamType);			
        
		
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
		nowVO.setPtnr_id(inVO.getPtnr_id());
		String ptnr_nick = inVO.getPtnr_nick();
		model.addAttribute("ptnr_nick",ptnr_nick);
		String ptnr_id = inVO.getPtnr_id();
		model.addAttribute("ptnr_id",ptnr_id);
		*/
		
		List<MisEndTmVO> MisEndTmMbrTime = sqlSession.selectList("MisEndTmMapper.MisEndTmMbrTime", nowVO);
		model.addAttribute("MisEndTmMbrTime",MisEndTmMbrTime);
		
//		List<MisEndTmVO> MisEndPtnrTmTime4 = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrTmTime4", nowVO);
//		model.addAttribute("MisEndPtnrTmTime4",MisEndPtnrTmTime4);


		model.addAttribute("nowVO", nowVO);

        model.addAttribute("srchArg",paramMap);
//		model.addAttribute("inVO", inVO);	

		return "top_statistics/mis_end_tm_mbr_time";
	}
	
	
	@RequestMapping(value = "/MisEndTmMbrTraffic")
	public String MisEndTmMbrTraffic(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= MisEndTmMbrTraffic =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			
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

        //StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", bgnDe);
        StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", endDe);
        nowVO.setBasicYN( String.valueOf(paramMap.get("basicYN")) );
        nowVO.setPrimYN( String.valueOf(paramMap.get("primYN")) );
        nowVO.setTeam_id(teamId);			
        nowVO.setTeam_type(teamType);			
		
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
		nowVO.setPtnr_id(inVO.getPtnr_id());
		String ptnr_nick = inVO.getPtnr_nick();
		model.addAttribute("ptnr_nick",ptnr_nick);
		String ptnr_id = inVO.getPtnr_id();
		model.addAttribute("ptnr_id",ptnr_id);
*/
        
		List<MisEndTmVO> MisEndTmMbrTraffic = sqlSession.selectList("MisEndTmMapper.MisEndTmMbrTraffic", nowVO);
		model.addAttribute("MisEndTmMbrTraffic",MisEndTmMbrTraffic);
		
//		List<MisEndTmVO> MisEndPtnrTmTraffic4 = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrTmTraffic4", nowVO);
//		model.addAttribute("MisEndPtnrTmTraffic4",MisEndPtnrTmTraffic4);


		model.addAttribute("nowVO", nowVO);

        model.addAttribute("srchArg",paramMap);
//		model.addAttribute("inVO", inVO);	

		return "top_statistics/mis_end_tm_mbr_traffic";
	}
	
	@RequestMapping(value = "/MisEndTmMbrQr")
	public String MisEndTmMbrQr(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= MisEndTmMbrQr =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			
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

        //StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", bgnDe);
        StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", endDe);
        nowVO.setBasicYN( String.valueOf(paramMap.get("basicYN")) );
        nowVO.setPrimYN( String.valueOf(paramMap.get("primYN")) );
        nowVO.setTeam_id(teamId);		
        nowVO.setTeam_type(teamType);		
        
		
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
		nowVO.setPtnr_id(inVO.getPtnr_id());
		String ptnr_nick = inVO.getPtnr_nick();
		model.addAttribute("ptnr_nick",ptnr_nick);
		String ptnr_id = inVO.getPtnr_id();
		model.addAttribute("ptnr_id",ptnr_id);
*/
		
		List<MisEndTmVO> MisEndTmMbrQr = sqlSession.selectList("MisEndTmMapper.MisEndTmMbrQr", nowVO);
		model.addAttribute("MisEndTmMbrQr",MisEndTmMbrQr);
		
		model.addAttribute("nowVO", nowVO);

        model.addAttribute("srchArg",paramMap);
//		model.addAttribute("inVO", inVO);	

		return "top_statistics/mis_end_tm_mbr_qr";
	}
	
	@RequestMapping(value = "/MisEndTmMbrTotal")
	public String MisEndTmMbrTotal(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= MisEndTmMbrTotal =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			
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

        //StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", bgnDe);
        StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics1YearDate", endDe);
        nowVO.setBasicYN( String.valueOf(paramMap.get("basicYN")) );
        nowVO.setPrimYN( String.valueOf(paramMap.get("primYN")) );
        nowVO.setTeam_id(teamId);			
        nowVO.setTeam_type(teamType);					
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
		nowVO.setPtnr_id(inVO.getPtnr_id());
		String ptnr_nick = inVO.getPtnr_nick();
		model.addAttribute("ptnr_nick",ptnr_nick);
		String ptnr_id = inVO.getPtnr_id();
		model.addAttribute("ptnr_id",ptnr_id);
*/
		List<MisEndTmVO> MisEndTmMbrTotal = sqlSession.selectList("MisEndTmMapper.MisEndTmMbrTotal", nowVO);
		model.addAttribute("MisEndTmMbrTotal",MisEndTmMbrTotal);
		


		model.addAttribute("nowVO", nowVO);

        model.addAttribute("srchArg",paramMap);
//		model.addAttribute("inVO", inVO);	

		return "top_statistics/mis_end_tm_mbr_total";
	}

}//class
