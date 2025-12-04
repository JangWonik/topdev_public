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
* Program ID	: MisEndPtnrController
* Program Name	: 
* Description	: 
* Author		: leedongik
* Date			: 2015.12.30.
* Update		: 
*********************************************************
*/

@Controller
public class MisEndPtnrController {

	private static final Logger logger = LoggerFactory.getLogger(MisRegTmController.class);

	@Autowired
	private SqlSession sqlSession;
	
	/**
	 * 보험사 팀 내 직원별 실적 총합계 현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatMemberEntire")
	public String ptnrStatMemberEntire(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatMemberEntire =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		String sPtnrId = String.valueOf(paramMap.get("ptnr_id"));
		String sPtnrName = sqlSession.selectOne("MisEndPtnrMapper.selectPtnrNameByPtnrId",sPtnrId);
		
		String sTeamCenter = String.valueOf(paramMap.get("team_center"));
		String sCenterName = sqlSession.selectOne("MisEndPtnrMapper.selectCenterNameByTeamCenter",sTeamCenter);
		
		String sTeamId = String.valueOf(paramMap.get("team_id"));
		String sTeamName = sqlSession.selectOne("MisEndPtnrMapper.selectTeamNameByTeamId",sTeamId);		
				
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        nowVO.setPtnr_id(sPtnrId);
        nowVO.setTeam_center(sTeamCenter);
        nowVO.setTeam_id(sTeamId);
        List<Map<String, Object>> ptnrStatEntireList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberEntire", nowVO);		
        model.addAttribute("ptnrStatEntireList",ptnrStatEntireList);
        //물보험 조사 통계 좌측 row 계산
        int nLeftRow = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberEndLeftRow",nowVO);
        model.addAttribute("leftRow",nLeftRow);        
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatEntireList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberEntire", nowVO);
        model.addAttribute("ptnrStatEntireList_10",ptnrStatEntireList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRow_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberEndLeftRow",nowVO);
        model.addAttribute("leftRow_10",nLeftRow_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatEntireList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberEntire", nowVO);
        model.addAttribute("ptnrStatEntireList_15",ptnrStatEntireList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRow_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberEndLeftRow",nowVO);
        model.addAttribute("leftRow_15",nLeftRow_15);

        //for( int i=0; i < ptnrStatRegList.size(); i++ ) {
			//CommonUtils.printMap(ptnrStatRegList.get(i));
		//}
        
        model.addAttribute("ptnrName", sPtnrName);
        model.addAttribute("centerName", sCenterName);
        model.addAttribute("teamName", sTeamName);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_member_entire";
	}
	
	/**
	 * 보험사 팀 내 직원별 실적 자문료+기타 현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatMemberEtc")
	public String ptnrStatMemberEtc(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatMemberEtc =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		String sPtnrId = String.valueOf(paramMap.get("ptnr_id"));
		String sPtnrName = sqlSession.selectOne("MisEndPtnrMapper.selectPtnrNameByPtnrId",sPtnrId);
		
		String sTeamCenter = String.valueOf(paramMap.get("team_center"));
		String sCenterName = sqlSession.selectOne("MisEndPtnrMapper.selectCenterNameByTeamCenter",sTeamCenter);
		
		String sTeamId = String.valueOf(paramMap.get("team_id"));
		String sTeamName = sqlSession.selectOne("MisEndPtnrMapper.selectTeamNameByTeamId",sTeamId);		
				
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        nowVO.setPtnr_id(sPtnrId);
        nowVO.setTeam_center(sTeamCenter);
        nowVO.setTeam_id(sTeamId);
        List<Map<String, Object>> ptnrStatEtcList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberEtc", nowVO);		
        model.addAttribute("ptnrStatEtcList",ptnrStatEtcList);
        //물보험 조사 통계 좌측 row 계산
        int nLeftRow = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberEndLeftRow",nowVO);
        model.addAttribute("leftRow",nLeftRow);        
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatEtcList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberEtc", nowVO);
        model.addAttribute("ptnrStatEtcList_10",ptnrStatEtcList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRow_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberEndLeftRow",nowVO);
        model.addAttribute("leftRow_10",nLeftRow_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatEtcList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberEtc", nowVO);
        model.addAttribute("ptnrStatEtcList_15",ptnrStatEtcList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRow_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberEndLeftRow",nowVO);
        model.addAttribute("leftRow_15",nLeftRow_15);

        //for( int i=0; i < ptnrStatRegList.size(); i++ ) {
			//CommonUtils.printMap(ptnrStatRegList.get(i));
		//}
        
        model.addAttribute("ptnrName", sPtnrName);
        model.addAttribute("centerName", sCenterName);
        model.addAttribute("teamName", sTeamName);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_member_etc";
	}
	
	/**
	 * 보험사 팀 내 직원별 실적 교통비현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatMemberTraffic")
	public String ptnrStatMemberTraffic(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatMemberTraffic =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		String sPtnrId = String.valueOf(paramMap.get("ptnr_id"));
		String sPtnrName = sqlSession.selectOne("MisEndPtnrMapper.selectPtnrNameByPtnrId",sPtnrId);
		
		String sTeamCenter = String.valueOf(paramMap.get("team_center"));
		String sCenterName = sqlSession.selectOne("MisEndPtnrMapper.selectCenterNameByTeamCenter",sTeamCenter);
		
		String sTeamId = String.valueOf(paramMap.get("team_id"));
		String sTeamName = sqlSession.selectOne("MisEndPtnrMapper.selectTeamNameByTeamId",sTeamId);		
				
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        nowVO.setPtnr_id(sPtnrId);
        nowVO.setTeam_center(sTeamCenter);
        nowVO.setTeam_id(sTeamId);
        List<Map<String, Object>> ptnrStatTrafficList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberTraffic", nowVO);		
        model.addAttribute("ptnrStatTrafficList",ptnrStatTrafficList);
        //물보험 조사 통계 좌측 row 계산
        int nLeftRow = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberEndLeftRow",nowVO);
        model.addAttribute("leftRow",nLeftRow);        
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatTrafficList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberTraffic", nowVO);
        model.addAttribute("ptnrStatTrafficList_10",ptnrStatTrafficList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRow_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberEndLeftRow",nowVO);
        model.addAttribute("leftRow_10",nLeftRow_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatTrafficList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberTraffic", nowVO);
        model.addAttribute("ptnrStatTrafficList_15",ptnrStatTrafficList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRow_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberEndLeftRow",nowVO);
        model.addAttribute("leftRow_15",nLeftRow_15);

        //for( int i=0; i < ptnrStatRegList.size(); i++ ) {
			//CommonUtils.printMap(ptnrStatRegList.get(i));
		//}
        
        model.addAttribute("ptnrName", sPtnrName);
        model.addAttribute("centerName", sCenterName);
        model.addAttribute("teamName", sTeamName);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_member_traffic";
	}
	
	/**
	 * 보험사 팀 내 직원별 실적 건당 일비 현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatMemberCntTime")
	public String ptnrStatMemberCntTime(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatMemberCntTime =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		String sPtnrId = String.valueOf(paramMap.get("ptnr_id"));
		String sPtnrName = sqlSession.selectOne("MisEndPtnrMapper.selectPtnrNameByPtnrId",sPtnrId);
		
		String sTeamCenter = String.valueOf(paramMap.get("team_center"));
		String sCenterName = sqlSession.selectOne("MisEndPtnrMapper.selectCenterNameByTeamCenter",sTeamCenter);
		
		String sTeamId = String.valueOf(paramMap.get("team_id"));
		String sTeamName = sqlSession.selectOne("MisEndPtnrMapper.selectTeamNameByTeamId",sTeamId);		
				
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        nowVO.setPtnr_id(sPtnrId);
        nowVO.setTeam_center(sTeamCenter);
        nowVO.setTeam_id(sTeamId);
        List<Map<String, Object>> ptnrStatCntTimeList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberCntTime", nowVO);		
        model.addAttribute("ptnrStatCntTimeList",ptnrStatCntTimeList);
        //물보험 조사 통계 좌측 row 계산
        int nLeftRow = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberEndLeftRow",nowVO);
        model.addAttribute("leftRow",nLeftRow);        
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatCntTimeList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberCntTime", nowVO);
        model.addAttribute("ptnrStatCntTimeList_10",ptnrStatCntTimeList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRow_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberEndLeftRow",nowVO);
        model.addAttribute("leftRow_10",nLeftRow_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatCntTimeList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberCntTime", nowVO);
        model.addAttribute("ptnrStatCntTimeList_15",ptnrStatCntTimeList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRow_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberEndLeftRow",nowVO);
        model.addAttribute("leftRow_15",nLeftRow_15);

        //for( int i=0; i < ptnrStatRegList.size(); i++ ) {
			//CommonUtils.printMap(ptnrStatRegList.get(i));
		//}
        
        model.addAttribute("ptnrName", sPtnrName);
        model.addAttribute("centerName", sCenterName);
        model.addAttribute("teamName", sTeamName);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_member_cnt_time";
	}
	
	/**
	 * 보험사 팀 내 직원별 실적 일비현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatMemberTime")
	public String ptnrStatMemberTime(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatMemberTime =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		String sPtnrId = String.valueOf(paramMap.get("ptnr_id"));
		String sPtnrName = sqlSession.selectOne("MisEndPtnrMapper.selectPtnrNameByPtnrId",sPtnrId);
		
		String sTeamCenter = String.valueOf(paramMap.get("team_center"));
		String sCenterName = sqlSession.selectOne("MisEndPtnrMapper.selectCenterNameByTeamCenter",sTeamCenter);
		
		String sTeamId = String.valueOf(paramMap.get("team_id"));
		String sTeamName = sqlSession.selectOne("MisEndPtnrMapper.selectTeamNameByTeamId",sTeamId);		
				
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        nowVO.setPtnr_id(sPtnrId);
        nowVO.setTeam_center(sTeamCenter);
        nowVO.setTeam_id(sTeamId);
        List<Map<String, Object>> ptnrStatTimeList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberTime", nowVO);		
        model.addAttribute("ptnrStatTimeList",ptnrStatTimeList);
        //물보험 조사 통계 좌측 row 계산
        int nLeftRow = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberEndLeftRow",nowVO);
        model.addAttribute("leftRow",nLeftRow);        
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatTimeList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberTime", nowVO);
        model.addAttribute("ptnrStatTimeList_10",ptnrStatTimeList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRow_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberEndLeftRow",nowVO);
        model.addAttribute("leftRow_10",nLeftRow_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatTimeList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberTime", nowVO);
        model.addAttribute("ptnrStatTimeList_15",ptnrStatTimeList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRow_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberEndLeftRow",nowVO);
        model.addAttribute("leftRow_15",nLeftRow_15);

        //for( int i=0; i < ptnrStatRegList.size(); i++ ) {
			//CommonUtils.printMap(ptnrStatRegList.get(i));
		//}
        
        model.addAttribute("ptnrName", sPtnrName);
        model.addAttribute("centerName", sCenterName);
        model.addAttribute("teamName", sTeamName);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_member_time";
	}
	
	/**
	 * 보험사 팀 내 직원별 실적 건당 순수피 현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatMemberCntFee")
	public String ptnrStatMemberCntFee(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatMemberCntFee =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		String sPtnrId = String.valueOf(paramMap.get("ptnr_id"));
		String sPtnrName = sqlSession.selectOne("MisEndPtnrMapper.selectPtnrNameByPtnrId",sPtnrId);
		
		String sTeamCenter = String.valueOf(paramMap.get("team_center"));
		String sCenterName = sqlSession.selectOne("MisEndPtnrMapper.selectCenterNameByTeamCenter",sTeamCenter);
		
		String sTeamId = String.valueOf(paramMap.get("team_id"));
		String sTeamName = sqlSession.selectOne("MisEndPtnrMapper.selectTeamNameByTeamId",sTeamId);		
				
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        nowVO.setPtnr_id(sPtnrId);
        nowVO.setTeam_center(sTeamCenter);
        nowVO.setTeam_id(sTeamId);
        List<Map<String, Object>> ptnrStatCntFeeList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberCntFee", nowVO);		
        model.addAttribute("ptnrStatCntFeeList",ptnrStatCntFeeList);
        //물보험 조사 통계 좌측 row 계산
        int nLeftRow = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberEndLeftRow",nowVO);
        model.addAttribute("leftRow",nLeftRow);        
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatCntFeeList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberCntFee", nowVO);
        model.addAttribute("ptnrStatCntFeeList_10",ptnrStatCntFeeList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRow_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberEndLeftRow",nowVO);
        model.addAttribute("leftRow_10",nLeftRow_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatCntFeeList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberCntFee", nowVO);
        model.addAttribute("ptnrStatCntFeeList_15",ptnrStatCntFeeList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRow_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberEndLeftRow",nowVO);
        model.addAttribute("leftRow_15",nLeftRow_15);

        //for( int i=0; i < ptnrStatRegList.size(); i++ ) {
			//CommonUtils.printMap(ptnrStatRegList.get(i));
		//}
        
        model.addAttribute("ptnrName", sPtnrName);
        model.addAttribute("centerName", sCenterName);
        model.addAttribute("teamName", sTeamName);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_member_cnt_fee";
	}
	
	/**
	 * 보험사 팀 내 직원별 실적 순수피(Fee)현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatMemberFee")
	public String ptnrStatMemberFee(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatMemberFee =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		String sPtnrId = String.valueOf(paramMap.get("ptnr_id"));
		String sPtnrName = sqlSession.selectOne("MisEndPtnrMapper.selectPtnrNameByPtnrId",sPtnrId);
		
		String sTeamCenter = String.valueOf(paramMap.get("team_center"));
		String sCenterName = sqlSession.selectOne("MisEndPtnrMapper.selectCenterNameByTeamCenter",sTeamCenter);
		
		String sTeamId = String.valueOf(paramMap.get("team_id"));
		String sTeamName = sqlSession.selectOne("MisEndPtnrMapper.selectTeamNameByTeamId",sTeamId);		
				
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        nowVO.setPtnr_id(sPtnrId);
        nowVO.setTeam_center(sTeamCenter);
        nowVO.setTeam_id(sTeamId);
        List<Map<String, Object>> ptnrStatFeeList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberFee", nowVO);		
        model.addAttribute("ptnrStatFeeList",ptnrStatFeeList);
        //물보험 조사 통계 좌측 row 계산
        int nLeftRow = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberEndLeftRow",nowVO);
        model.addAttribute("leftRow",nLeftRow);        
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatFeeList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberFee", nowVO);
        model.addAttribute("ptnrStatFeeList_10",ptnrStatFeeList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRow_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberEndLeftRow",nowVO);
        model.addAttribute("leftRow_10",nLeftRow_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatFeeList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberFee", nowVO);
        model.addAttribute("ptnrStatFeeList_15",ptnrStatFeeList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRow_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberEndLeftRow",nowVO);
        model.addAttribute("leftRow_15",nLeftRow_15);

        //for( int i=0; i < ptnrStatRegList.size(); i++ ) {
			//CommonUtils.printMap(ptnrStatRegList.get(i));
		//}
        
        model.addAttribute("ptnrName", sPtnrName);
        model.addAttribute("centerName", sCenterName);
        model.addAttribute("teamName", sTeamName);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_member_fee";
	}
	
	/**
	 * 보험사 팀 내 직원별 실적 종결현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatMemberEnd")
	public String ptnrStatMemberEnd(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatMemberEnd =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		String sPtnrId = String.valueOf(paramMap.get("ptnr_id"));
		String sPtnrName = sqlSession.selectOne("MisEndPtnrMapper.selectPtnrNameByPtnrId",sPtnrId);
		
		String sTeamCenter = String.valueOf(paramMap.get("team_center"));
		String sCenterName = sqlSession.selectOne("MisEndPtnrMapper.selectCenterNameByTeamCenter",sTeamCenter);
		
		String sTeamId = String.valueOf(paramMap.get("team_id"));
		String sTeamName = sqlSession.selectOne("MisEndPtnrMapper.selectTeamNameByTeamId",sTeamId);		
				
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        nowVO.setPtnr_id(sPtnrId);
        nowVO.setTeam_center(sTeamCenter);
        nowVO.setTeam_id(sTeamId);
        List<Map<String, Object>> ptnrStatEndList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberEnd", nowVO);		
        model.addAttribute("ptnrStatEndList",ptnrStatEndList);
        //물보험 조사 통계 좌측 row 계산
        int nLeftRow = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberEndLeftRow",nowVO);
        model.addAttribute("leftRow",nLeftRow);        
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatEndList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberEnd", nowVO);
        model.addAttribute("ptnrStatEndList_10",ptnrStatEndList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRow_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberEndLeftRow",nowVO);
        model.addAttribute("leftRow_10",nLeftRow_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatEndList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberEnd", nowVO);
        model.addAttribute("ptnrStatEndList_15",ptnrStatEndList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRow_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberEndLeftRow",nowVO);
        model.addAttribute("leftRow_15",nLeftRow_15);

        //for( int i=0; i < ptnrStatRegList.size(); i++ ) {
			//CommonUtils.printMap(ptnrStatRegList.get(i));
		//}
        
        model.addAttribute("ptnrName", sPtnrName);
        model.addAttribute("centerName", sCenterName);
        model.addAttribute("teamName", sTeamName);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_member_end";
	}
	
	/**
	 * 보험사 팀 내 직원별 실적 수임현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatMemberMain")
	public String ptnrStatMemberMain(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatMemberMain =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		String sPtnrId = String.valueOf(paramMap.get("ptnr_id"));
		String sPtnrName = sqlSession.selectOne("MisEndPtnrMapper.selectPtnrNameByPtnrId",sPtnrId);
		
		String sTeamCenter = String.valueOf(paramMap.get("team_center"));
		String sCenterName = sqlSession.selectOne("MisEndPtnrMapper.selectCenterNameByTeamCenter",sTeamCenter);
		
		String sTeamId = String.valueOf(paramMap.get("team_id"));
		String sTeamName = sqlSession.selectOne("MisEndPtnrMapper.selectTeamNameByTeamId",sTeamId);		
				
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        nowVO.setPtnr_id(sPtnrId);
        nowVO.setTeam_center(sTeamCenter);
        nowVO.setTeam_id(sTeamId);
        List<Map<String, Object>> ptnrStatRegList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberReg", nowVO);		
        model.addAttribute("ptnrStatRegList",ptnrStatRegList);
        //물보험 조사 통계 좌측 row 계산
        int nLeftRow = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberRegLeftRow",nowVO);
        model.addAttribute("leftRow",nLeftRow);        
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatRegList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberReg", nowVO);
        model.addAttribute("ptnrStatRegList_10",ptnrStatRegList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRow_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberRegLeftRow",nowVO);
        model.addAttribute("leftRow_10",nLeftRow_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatRegList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberReg", nowVO);
        model.addAttribute("ptnrStatRegList_15",ptnrStatRegList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRow_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberRegLeftRow",nowVO);
        model.addAttribute("leftRow_15",nLeftRow_15);

        //for( int i=0; i < ptnrStatRegList.size(); i++ ) {
			//CommonUtils.printMap(ptnrStatRegList.get(i));
		//}
        
        model.addAttribute("ptnrName", sPtnrName);
        model.addAttribute("centerName", sCenterName);
        model.addAttribute("teamName", sTeamName);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_member_main";
	}
	
	/**
	 * 보험사 센터 내 팀별 총합계 일비 현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatTeamEntire")
	public String ptnrStatTeamEntire(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatTeamEntire =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		String sPtnrId = String.valueOf(paramMap.get("ptnr_id"));
		String sPtnrName = sqlSession.selectOne("MisEndPtnrMapper.selectPtnrNameByPtnrId",sPtnrId);
		
		String sTeamCenter = String.valueOf(paramMap.get("team_center"));
		String sCenterName = sqlSession.selectOne("MisEndPtnrMapper.selectCenterNameByTeamCenter",sTeamCenter);
				
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        nowVO.setPtnr_id(sPtnrId);
        nowVO.setTeam_center(sTeamCenter);
        
        List<Map<String, Object>> ptnrStatEntireList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamEntire", nowVO);		
        model.addAttribute("ptnrStatEntireList",ptnrStatEntireList);
        //물보험 조사 통계 좌측 row 계산
        int nLeftRow = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamEndLeftRow",nowVO);
        model.addAttribute("leftRow",nLeftRow);        
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatEntireList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamEntire", nowVO);
        model.addAttribute("ptnrStatEntireList_10",ptnrStatEntireList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRow_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamEndLeftRow",nowVO);
        model.addAttribute("leftRow_10",nLeftRow_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatEntireList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamEntire", nowVO);
        model.addAttribute("ptnrStatEntireList_15",ptnrStatEntireList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRow_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamEndLeftRow",nowVO);
        model.addAttribute("leftRow_15",nLeftRow_15);

        //for( int i=0; i < ptnrStatRegList_15.size(); i++ ) {
			//CommonUtils.printMap(ptnrStatRegList_15.get(i));
		//}        
        
        model.addAttribute("ptnrName", sPtnrName);
        model.addAttribute("centerName", sCenterName);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_team_entire";
	}
	
	/**
	 * 보험사 센터 내 팀별 실적 일비 현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatTeamEtc")
	public String ptnrStatTeamEtc(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatTeamEtc =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		String sPtnrId = String.valueOf(paramMap.get("ptnr_id"));
		String sPtnrName = sqlSession.selectOne("MisEndPtnrMapper.selectPtnrNameByPtnrId",sPtnrId);
		
		String sTeamCenter = String.valueOf(paramMap.get("team_center"));
		String sCenterName = sqlSession.selectOne("MisEndPtnrMapper.selectCenterNameByTeamCenter",sTeamCenter);
				
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        nowVO.setPtnr_id(sPtnrId);
        nowVO.setTeam_center(sTeamCenter);
        
        List<Map<String, Object>> ptnrStatEtcList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamEtc", nowVO);		
        model.addAttribute("ptnrStatEtcList",ptnrStatEtcList);
        //물보험 조사 통계 좌측 row 계산
        int nLeftRow = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamEndLeftRow",nowVO);
        model.addAttribute("leftRow",nLeftRow);        
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatEtcList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamEtc", nowVO);
        model.addAttribute("ptnrStatEtcList_10",ptnrStatEtcList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRow_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamEndLeftRow",nowVO);
        model.addAttribute("leftRow_10",nLeftRow_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatEtcList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamEtc", nowVO);
        model.addAttribute("ptnrStatEtcList_15",ptnrStatEtcList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRow_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamEndLeftRow",nowVO);
        model.addAttribute("leftRow_15",nLeftRow_15);

        //for( int i=0; i < ptnrStatRegList_15.size(); i++ ) {
			//CommonUtils.printMap(ptnrStatRegList_15.get(i));
		//}        
        
        model.addAttribute("ptnrName", sPtnrName);
        model.addAttribute("centerName", sCenterName);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_team_etc";
	}
	
	/**
	 * 보험사 센터 내 팀별 실적 일비 현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatTeamTraffic")
	public String ptnrStatTeamTraffic(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatTeamTraffic =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		String sPtnrId = String.valueOf(paramMap.get("ptnr_id"));
		String sPtnrName = sqlSession.selectOne("MisEndPtnrMapper.selectPtnrNameByPtnrId",sPtnrId);
		
		String sTeamCenter = String.valueOf(paramMap.get("team_center"));
		String sCenterName = sqlSession.selectOne("MisEndPtnrMapper.selectCenterNameByTeamCenter",sTeamCenter);
				
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        nowVO.setPtnr_id(sPtnrId);
        nowVO.setTeam_center(sTeamCenter);
        
        List<Map<String, Object>> ptnrStatTrafficList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamTraffic", nowVO);		
        model.addAttribute("ptnrStatTrafficList",ptnrStatTrafficList);
        //물보험 조사 통계 좌측 row 계산
        int nLeftRow = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamEndLeftRow",nowVO);
        model.addAttribute("leftRow",nLeftRow);        
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatTrafficList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamTraffic", nowVO);
        model.addAttribute("ptnrStatTrafficList_10",ptnrStatTrafficList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRow_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamEndLeftRow",nowVO);
        model.addAttribute("leftRow_10",nLeftRow_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatTrafficList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamTraffic", nowVO);
        model.addAttribute("ptnrStatTrafficList_15",ptnrStatTrafficList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRow_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamEndLeftRow",nowVO);
        model.addAttribute("leftRow_15",nLeftRow_15);

        //for( int i=0; i < ptnrStatRegList_15.size(); i++ ) {
			//CommonUtils.printMap(ptnrStatRegList_15.get(i));
		//}        
        
        model.addAttribute("ptnrName", sPtnrName);
        model.addAttribute("centerName", sCenterName);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_team_traffic";
	}
	
	/**
	 * 보험사 센터 내 팀별 실적 건당 일비 현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatTeamCntTime")
	public String ptnrStatTeamCntTime(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatTeamCntTime =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		String sPtnrId = String.valueOf(paramMap.get("ptnr_id"));
		String sPtnrName = sqlSession.selectOne("MisEndPtnrMapper.selectPtnrNameByPtnrId",sPtnrId);
		
		String sTeamCenter = String.valueOf(paramMap.get("team_center"));
		String sCenterName = sqlSession.selectOne("MisEndPtnrMapper.selectCenterNameByTeamCenter",sTeamCenter);
				
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        nowVO.setPtnr_id(sPtnrId);
        nowVO.setTeam_center(sTeamCenter);
        
        List<Map<String, Object>> ptnrStatCntTimeList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamCntTime", nowVO);		
        model.addAttribute("ptnrStatCntTimeList",ptnrStatCntTimeList);
        //물보험 조사 통계 좌측 row 계산
        int nLeftRow = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamEndLeftRow",nowVO);
        model.addAttribute("leftRow",nLeftRow);        
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatCntTimeList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamCntTime", nowVO);
        model.addAttribute("ptnrStatCntTimeList_10",ptnrStatCntTimeList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRow_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamEndLeftRow",nowVO);
        model.addAttribute("leftRow_10",nLeftRow_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatCntTimeList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamCntTime", nowVO);
        model.addAttribute("ptnrStatCntTimeList_15",ptnrStatCntTimeList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRow_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamEndLeftRow",nowVO);
        model.addAttribute("leftRow_15",nLeftRow_15);

        //for( int i=0; i < ptnrStatRegList_15.size(); i++ ) {
			//CommonUtils.printMap(ptnrStatRegList_15.get(i));
		//}        
        
        model.addAttribute("ptnrName", sPtnrName);
        model.addAttribute("centerName", sCenterName);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_team_cnt_time";
	}
	
	/**
	 * 보험사 센터 내 팀별 실적 일비 현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatTeamTime")
	public String ptnrStatTeamTime(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatTeamTime =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		String sPtnrId = String.valueOf(paramMap.get("ptnr_id"));
		String sPtnrName = sqlSession.selectOne("MisEndPtnrMapper.selectPtnrNameByPtnrId",sPtnrId);
		
		String sTeamCenter = String.valueOf(paramMap.get("team_center"));
		String sCenterName = sqlSession.selectOne("MisEndPtnrMapper.selectCenterNameByTeamCenter",sTeamCenter);
				
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        nowVO.setPtnr_id(sPtnrId);
        nowVO.setTeam_center(sTeamCenter);
        
        List<Map<String, Object>> ptnrStatTimeList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamTime", nowVO);		
        model.addAttribute("ptnrStatTimeList",ptnrStatTimeList);
        //물보험 조사 통계 좌측 row 계산
        int nLeftRow = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamEndLeftRow",nowVO);
        model.addAttribute("leftRow",nLeftRow);        
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatTimeList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamTime", nowVO);
        model.addAttribute("ptnrStatTimeList_10",ptnrStatTimeList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRow_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamEndLeftRow",nowVO);
        model.addAttribute("leftRow_10",nLeftRow_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatTimeList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamTime", nowVO);
        model.addAttribute("ptnrStatTimeList_15",ptnrStatTimeList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRow_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamEndLeftRow",nowVO);
        model.addAttribute("leftRow_15",nLeftRow_15);

        //for( int i=0; i < ptnrStatRegList_15.size(); i++ ) {
			//CommonUtils.printMap(ptnrStatRegList_15.get(i));
		//}        
        
        model.addAttribute("ptnrName", sPtnrName);
        model.addAttribute("centerName", sCenterName);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_team_time";
	}
	
	/**
	 * 보험사 센터 내 팀별 실적 건당 순수피 현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatTeamCntFee")
	public String ptnrStatTeamCntFee(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatTeamCntFee =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		String sPtnrId = String.valueOf(paramMap.get("ptnr_id"));
		String sPtnrName = sqlSession.selectOne("MisEndPtnrMapper.selectPtnrNameByPtnrId",sPtnrId);
		
		String sTeamCenter = String.valueOf(paramMap.get("team_center"));
		String sCenterName = sqlSession.selectOne("MisEndPtnrMapper.selectCenterNameByTeamCenter",sTeamCenter);
				
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        nowVO.setPtnr_id(sPtnrId);
        nowVO.setTeam_center(sTeamCenter);
        
        List<Map<String, Object>> ptnrStatCntFeeList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamCntFee", nowVO);		
        model.addAttribute("ptnrStatCntFeeList",ptnrStatCntFeeList);
        //물보험 조사 통계 좌측 row 계산
        int nLeftRow = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamEndLeftRow",nowVO);
        model.addAttribute("leftRow",nLeftRow);        
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatCntFeeList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamCntFee", nowVO);
        model.addAttribute("ptnrStatCntFeeList_10",ptnrStatCntFeeList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRow_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamEndLeftRow",nowVO);
        model.addAttribute("leftRow_10",nLeftRow_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatCntFeeList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamCntFee", nowVO);
        model.addAttribute("ptnrStatCntFeeList_15",ptnrStatCntFeeList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRow_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamEndLeftRow",nowVO);
        model.addAttribute("leftRow_15",nLeftRow_15);

        //for( int i=0; i < ptnrStatRegList_15.size(); i++ ) {
			//CommonUtils.printMap(ptnrStatRegList_15.get(i));
		//}        
        
        model.addAttribute("ptnrName", sPtnrName);
        model.addAttribute("centerName", sCenterName);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_team_cnt_fee";
	}
	
	/**
	 * 보험사 센터 내 팀별 실적 순수피 현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatTeamFee")
	public String ptnrStatTeamFee(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatTeamFee =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		String sPtnrId = String.valueOf(paramMap.get("ptnr_id"));
		String sPtnrName = sqlSession.selectOne("MisEndPtnrMapper.selectPtnrNameByPtnrId",sPtnrId);
		
		String sTeamCenter = String.valueOf(paramMap.get("team_center"));
		String sCenterName = sqlSession.selectOne("MisEndPtnrMapper.selectCenterNameByTeamCenter",sTeamCenter);
				
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        nowVO.setPtnr_id(sPtnrId);
        nowVO.setTeam_center(sTeamCenter);
        
        List<Map<String, Object>> ptnrStatFeeList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamFee", nowVO);		
        model.addAttribute("ptnrStatFeeList",ptnrStatFeeList);
        //물보험 조사 통계 좌측 row 계산
        int nLeftRow = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamEndLeftRow",nowVO);
        model.addAttribute("leftRow",nLeftRow);        
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatFeeList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamFee", nowVO);
        model.addAttribute("ptnrStatFeeList_10",ptnrStatFeeList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRow_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamEndLeftRow",nowVO);
        model.addAttribute("leftRow_10",nLeftRow_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatFeeList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamFee", nowVO);
        model.addAttribute("ptnrStatFeeList_15",ptnrStatFeeList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRow_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamEndLeftRow",nowVO);
        model.addAttribute("leftRow_15",nLeftRow_15);

        //for( int i=0; i < ptnrStatRegList_15.size(); i++ ) {
			//CommonUtils.printMap(ptnrStatRegList_15.get(i));
		//}        
        
        model.addAttribute("ptnrName", sPtnrName);
        model.addAttribute("centerName", sCenterName);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_team_fee";
	}
	
	/**
	 * 보험사 센터 내 팀별 실적 종결현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatTeamEnd")
	public String ptnrStatTeamEnd(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatTeamEnd =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		String sPtnrId = String.valueOf(paramMap.get("ptnr_id"));
		String sPtnrName = sqlSession.selectOne("MisEndPtnrMapper.selectPtnrNameByPtnrId",sPtnrId);
		
		String sTeamCenter = String.valueOf(paramMap.get("team_center"));
		String sCenterName = sqlSession.selectOne("MisEndPtnrMapper.selectCenterNameByTeamCenter",sTeamCenter);
				
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        nowVO.setPtnr_id(sPtnrId);
        nowVO.setTeam_center(sTeamCenter);
        
        List<Map<String, Object>> ptnrStatEndList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamEnd", nowVO);		
        model.addAttribute("ptnrStatEndList",ptnrStatEndList);
        //물보험 조사 통계 좌측 row 계산
        int nLeftRow = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamEndLeftRow",nowVO);
        model.addAttribute("leftRow",nLeftRow);        
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatEndList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamEnd", nowVO);
        model.addAttribute("ptnrStatEndList_10",ptnrStatEndList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRow_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamEndLeftRow",nowVO);
        model.addAttribute("leftRow_10",nLeftRow_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatEndList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamEnd", nowVO);
        model.addAttribute("ptnrStatEndList_15",ptnrStatEndList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRow_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamEndLeftRow",nowVO);
        model.addAttribute("leftRow_15",nLeftRow_15);

        //for( int i=0; i < ptnrStatRegList_15.size(); i++ ) {
			//CommonUtils.printMap(ptnrStatRegList_15.get(i));
		//}        
        
        model.addAttribute("ptnrName", sPtnrName);
        model.addAttribute("centerName", sCenterName);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_team_end";
	}
	
	/**
	 * 보험사 센터 내 팀별 실적 수임현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatTeamMain")
	public String ptnrStatTeamMain(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatTeamMain =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		String sPtnrId = String.valueOf(paramMap.get("ptnr_id"));
		String sPtnrName = sqlSession.selectOne("MisEndPtnrMapper.selectPtnrNameByPtnrId",sPtnrId);
		
		String sTeamCenter = String.valueOf(paramMap.get("team_center"));
		String sCenterName = sqlSession.selectOne("MisEndPtnrMapper.selectCenterNameByTeamCenter",sTeamCenter);
				
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        nowVO.setPtnr_id(sPtnrId);
        nowVO.setTeam_center(sTeamCenter);
        List<Map<String, Object>> ptnrStatRegList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamReg", nowVO);		
        model.addAttribute("ptnrStatRegList",ptnrStatRegList);
        //물보험 조사 통계 좌측 row 계산
        int nLeftRow = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamRegLeftRow",nowVO);
        model.addAttribute("leftRow",nLeftRow);        
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatRegList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamReg", nowVO);
        model.addAttribute("ptnrStatRegList_10",ptnrStatRegList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRow_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamRegLeftRow",nowVO);
        model.addAttribute("leftRow_10",nLeftRow_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatRegList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamReg", nowVO);
        model.addAttribute("ptnrStatRegList_15",ptnrStatRegList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRow_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamRegLeftRow",nowVO);
        model.addAttribute("leftRow_15",nLeftRow_15);

        //for( int i=0; i < ptnrStatRegList.size(); i++ ) {
			//CommonUtils.printMap(ptnrStatRegList.get(i));
		//}
        
        model.addAttribute("ptnrName", sPtnrName);
        model.addAttribute("centerName", sCenterName);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_team_main";
	}
	
	/**
	 * 보험사 센터별 실적 전체합계 현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatCenterEntire")
	public String ptnrStatCenterEntire(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatCenterEntire =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		String sPtnrId = String.valueOf(paramMap.get("ptnr_id"));
		String sPtnrName = sqlSession.selectOne("MisEndPtnrMapper.selectPtnrNameByPtnrId",sPtnrId);
				
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //센터 전체 목록 시작
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        nowVO.setPtnr_id(sPtnrId);
        
        List<Map<String, Object>> ptnrStatEntireList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCenterEntire", nowVO);		
        model.addAttribute("ptnrStatEntireList",ptnrStatEntireList);
        //물보험 조사 통계 좌측 row 계산
        int nLeftRow = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatCenterEndLeftRow",nowVO);
        model.addAttribute("leftRow",nLeftRow);        
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatEntireList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCenterEntire", nowVO);
        model.addAttribute("ptnrStatEntireList_10",ptnrStatEntireList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRow_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatCenterEndLeftRow",nowVO);
        model.addAttribute("leftRow_10",nLeftRow_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatEntireList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCenterEntire", nowVO);
        model.addAttribute("ptnrStatEntireList_15",ptnrStatEntireList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRow_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatCenterEndLeftRow",nowVO);
        model.addAttribute("leftRow_15",nLeftRow_15);
        //센터 전체 목록 끝
        
        //보험사 팀별(전체) 실적 시작
        nowVO.setDiv_type("5");
        List<Map<String, Object>> ptnrStatTeamAllEntireList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamAllEntire", nowVO);		
        model.addAttribute("ptnrStatTeamAllEntireList",ptnrStatTeamAllEntireList);        
        
        //물보험 팀별 조사 통계 좌측 row 계산
        int nLeftRowTeamAll = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamAllEndLeftRow",nowVO);
        model.addAttribute("leftRowTeamAll",nLeftRowTeamAll);
        
        //물보험 팀별 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatTeamAllEntireList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamAllEntire", nowVO);
        model.addAttribute("ptnrStatTeamAllEntireList_10",ptnrStatTeamAllEntireList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRowTeamAll_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamAllEndLeftRow",nowVO);
        model.addAttribute("leftRowTeamAll_10",nLeftRowTeamAll_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatTeamAllEntireList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamAllEntire", nowVO);
        model.addAttribute("ptnrStatTeamAllEntireList_15",ptnrStatTeamAllEntireList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRowTeamAll_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamAllEndLeftRow",nowVO);
        model.addAttribute("leftRowTeamAll_15",nLeftRowTeamAll_15);
        
        model.addAttribute("ptnrName", sPtnrName);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_center_entire";
	}
	
	/**
	 * 보험사 센터별 실적 자문료+기타 현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatCenterEtc")
	public String ptnrStatCenterEtc(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatCenterEtc =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		String sPtnrId = String.valueOf(paramMap.get("ptnr_id"));
		String sPtnrName = sqlSession.selectOne("MisEndPtnrMapper.selectPtnrNameByPtnrId",sPtnrId);
				
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //센터 전체 목록 시작
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        nowVO.setPtnr_id(sPtnrId);
        
        List<Map<String, Object>> ptnrStatEtcList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCenterEtc", nowVO);		
        model.addAttribute("ptnrStatEtcList",ptnrStatEtcList);
        //물보험 조사 통계 좌측 row 계산
        int nLeftRow = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatCenterEndLeftRow",nowVO);
        model.addAttribute("leftRow",nLeftRow);        
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatEtcList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCenterEtc", nowVO);
        model.addAttribute("ptnrStatEtcList_10",ptnrStatEtcList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRow_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatCenterEndLeftRow",nowVO);
        model.addAttribute("leftRow_10",nLeftRow_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatEtcList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCenterEtc", nowVO);
        model.addAttribute("ptnrStatEtcList_15",ptnrStatEtcList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRow_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatCenterEndLeftRow",nowVO);
        model.addAttribute("leftRow_15",nLeftRow_15);
        //센터 전체 목록 끝
        
        //보험사 팀별(전체) 실적 시작
        nowVO.setDiv_type("5");
        List<Map<String, Object>> ptnrStatTeamAllEtcList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamAllEtc", nowVO);		
        model.addAttribute("ptnrStatTeamAllEtcList",ptnrStatTeamAllEtcList);        
        
        //물보험 팀별 조사 통계 좌측 row 계산
        int nLeftRowTeamAll = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamAllEndLeftRow",nowVO);
        model.addAttribute("leftRowTeamAll",nLeftRowTeamAll);
        
        //물보험 팀별 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatTeamAllEtcList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamAllEtc", nowVO);
        model.addAttribute("ptnrStatTeamAllEtcList_10",ptnrStatTeamAllEtcList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRowTeamAll_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamAllEndLeftRow",nowVO);
        model.addAttribute("leftRowTeamAll_10",nLeftRowTeamAll_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatTeamAllEtcList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamAllEtc", nowVO);
        model.addAttribute("ptnrStatTeamAllEtcList_15",ptnrStatTeamAllEtcList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRowTeamAll_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamAllEndLeftRow",nowVO);
        model.addAttribute("leftRowTeamAll_15",nLeftRowTeamAll_15);
        
        model.addAttribute("ptnrName", sPtnrName);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_center_etc";
	}
	
	/**
	 * 보험사 센터별 실적 교통비 현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatCenterTraffic")
	public String ptnrStatCenterTraffic(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatCenterTraffic =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		String sPtnrId = String.valueOf(paramMap.get("ptnr_id"));
		String sPtnrName = sqlSession.selectOne("MisEndPtnrMapper.selectPtnrNameByPtnrId",sPtnrId);
				
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //센터 전체 목록 시작
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        nowVO.setPtnr_id(sPtnrId);
        
        List<Map<String, Object>> ptnrStatTrafficList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCenterTraffic", nowVO);		
        model.addAttribute("ptnrStatTrafficList",ptnrStatTrafficList);
        //물보험 조사 통계 좌측 row 계산
        int nLeftRow = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatCenterEndLeftRow",nowVO);
        model.addAttribute("leftRow",nLeftRow);        
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatTrafficList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCenterTraffic", nowVO);
        model.addAttribute("ptnrStatTrafficList_10",ptnrStatTrafficList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRow_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatCenterEndLeftRow",nowVO);
        model.addAttribute("leftRow_10",nLeftRow_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatTrafficList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCenterTraffic", nowVO);
        model.addAttribute("ptnrStatTrafficList_15",ptnrStatTrafficList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRow_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatCenterEndLeftRow",nowVO);
        model.addAttribute("leftRow_15",nLeftRow_15);
        //센터 전체 목록 끝
        
        //보험사 팀별(전체) 실적 시작
        nowVO.setDiv_type("5");
        List<Map<String, Object>> ptnrStatTeamAllTrafficList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamAllTraffic", nowVO);		
        model.addAttribute("ptnrStatTeamAllTrafficList",ptnrStatTeamAllTrafficList);        
        
        //물보험 팀별 조사 통계 좌측 row 계산
        int nLeftRowTeamAll = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamAllEndLeftRow",nowVO);
        model.addAttribute("leftRowTeamAll",nLeftRowTeamAll);
        
        //물보험 팀별 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatTeamAllTrafficList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamAllTraffic", nowVO);
        model.addAttribute("ptnrStatTeamAllTrafficList_10",ptnrStatTeamAllTrafficList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRowTeamAll_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamAllEndLeftRow",nowVO);
        model.addAttribute("leftRowTeamAll_10",nLeftRowTeamAll_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatTeamAllTrafficList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamAllTraffic", nowVO);
        model.addAttribute("ptnrStatTeamAllTrafficList_15",ptnrStatTeamAllTrafficList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRowTeamAll_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamAllEndLeftRow",nowVO);
        model.addAttribute("leftRowTeamAll_15",nLeftRowTeamAll_15);
        //보험사 팀별(전체) 실적 시작        
        
        model.addAttribute("ptnrName", sPtnrName);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_center_traffic";
	}
	
	/**
	 * 보험사 센터별 실적 건당 일비현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatCenterCntTime")
	public String ptnrStatCenterCntTime(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatCenterCntTime =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		String sPtnrId = String.valueOf(paramMap.get("ptnr_id"));
		String sPtnrName = sqlSession.selectOne("MisEndPtnrMapper.selectPtnrNameByPtnrId",sPtnrId);
				
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //센터 전체 목록 시작
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        nowVO.setPtnr_id(sPtnrId);
        
        List<Map<String, Object>> ptnrStatCntTimeList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCenterCntTime", nowVO);		
        model.addAttribute("ptnrStatCntTimeList",ptnrStatCntTimeList);
        //물보험 조사 통계 좌측 row 계산
        int nLeftRow = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatCenterEndLeftRow",nowVO);
        model.addAttribute("leftRow",nLeftRow);        
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatCntTimeList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCenterCntTime", nowVO);
        model.addAttribute("ptnrStatCntTimeList_10",ptnrStatCntTimeList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRow_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatCenterEndLeftRow",nowVO);
        model.addAttribute("leftRow_10",nLeftRow_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatCntTimeList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCenterCntTime", nowVO);
        model.addAttribute("ptnrStatCntTimeList_15",ptnrStatCntTimeList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRow_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatCenterEndLeftRow",nowVO);
        model.addAttribute("leftRow_15",nLeftRow_15);
        //센터 전체 목록 끝
        
      //보험사 팀별(전체) 실적 시작
        nowVO.setDiv_type("5");
        List<Map<String, Object>> ptnrStatTeamAllCntTimeList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamAllCntTime", nowVO);		
        model.addAttribute("ptnrStatTeamAllCntTimeList",ptnrStatTeamAllCntTimeList);        
        
        //물보험 팀별 조사 통계 좌측 row 계산
        int nLeftRowTeamAll = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamAllEndLeftRow",nowVO);
        model.addAttribute("leftRowTeamAll",nLeftRowTeamAll);
        
        //물보험 팀별 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatTeamAllCntTimeList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamAllCntTime", nowVO);
        model.addAttribute("ptnrStatTeamAllCntTimeList_10",ptnrStatTeamAllCntTimeList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRowTeamAll_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamAllEndLeftRow",nowVO);
        model.addAttribute("leftRowTeamAll_10",nLeftRowTeamAll_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatTeamAllCntTimeList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamAllCntTime", nowVO);
        model.addAttribute("ptnrStatTeamAllCntTimeList_15",ptnrStatTeamAllCntTimeList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRowTeamAll_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamAllEndLeftRow",nowVO);
        model.addAttribute("leftRowTeamAll_15",nLeftRowTeamAll_15);        
        
        model.addAttribute("ptnrName", sPtnrName);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_center_cnt_time";
	}
	
	/**
	 * 보험사 센터별 실적 일비현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatCenterTime")
	public String ptnrStatCenterTime(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatCenterTime =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		String sPtnrId = String.valueOf(paramMap.get("ptnr_id"));
		String sPtnrName = sqlSession.selectOne("MisEndPtnrMapper.selectPtnrNameByPtnrId",sPtnrId);
				
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
      	//센터 전체 목록 시작
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        nowVO.setPtnr_id(sPtnrId);
        
        List<Map<String, Object>> ptnrStatTimeList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCenterTime", nowVO);		
        model.addAttribute("ptnrStatTimeList",ptnrStatTimeList);
        //물보험 조사 통계 좌측 row 계산
        int nLeftRow = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatCenterEndLeftRow",nowVO);
        model.addAttribute("leftRow",nLeftRow);        
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatTimeList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCenterTime", nowVO);
        model.addAttribute("ptnrStatTimeList_10",ptnrStatTimeList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRow_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatCenterEndLeftRow",nowVO);
        model.addAttribute("leftRow_10",nLeftRow_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatTimeList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCenterTime", nowVO);
        model.addAttribute("ptnrStatTimeList_15",ptnrStatTimeList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRow_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatCenterEndLeftRow",nowVO);
        model.addAttribute("leftRow_15",nLeftRow_15);
        //센터 전체 목록 끝
        
        //보험사 팀별(전체) 실적 시작
        nowVO.setDiv_type("5");
        List<Map<String, Object>> ptnrStatTeamAllTimeList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamAllTime", nowVO);		
        model.addAttribute("ptnrStatTeamAllTimeList",ptnrStatTeamAllTimeList);        
        
        //물보험 팀별 조사 통계 좌측 row 계산
        int nLeftRowTeamAll = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamAllEndLeftRow",nowVO);
        model.addAttribute("leftRowTeamAll",nLeftRowTeamAll);
        
        //물보험 팀별 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatTeamAllTimeList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamAllTime", nowVO);
        model.addAttribute("ptnrStatTeamAllTimeList_10",ptnrStatTeamAllTimeList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRowTeamAll_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamAllEndLeftRow",nowVO);
        model.addAttribute("leftRowTeamAll_10",nLeftRowTeamAll_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatTeamAllTimeList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamAllTime", nowVO);
        model.addAttribute("ptnrStatTeamAllTimeList_15",ptnrStatTeamAllTimeList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRowTeamAll_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamAllEndLeftRow",nowVO);
        model.addAttribute("leftRowTeamAll_15",nLeftRowTeamAll_15);
                
        
        model.addAttribute("ptnrName", sPtnrName);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_center_time";
	}
	
	/**
	 * 보험사 센터별 실적 건당 순수피 현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatCenterCntFee")
	public String ptnrStatCenterCntFee(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatCenterCntFee =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		String sPtnrId = String.valueOf(paramMap.get("ptnr_id"));
		String sPtnrName = sqlSession.selectOne("MisEndPtnrMapper.selectPtnrNameByPtnrId",sPtnrId);
				
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //센터 전체 목록 시작
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        nowVO.setPtnr_id(sPtnrId);
        
        List<Map<String, Object>> ptnrStatCntFeeList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCenterCntFee", nowVO);		
        model.addAttribute("ptnrStatCntFeeList",ptnrStatCntFeeList);
        //물보험 조사 통계 좌측 row 계산
        int nLeftRow = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatCenterEndLeftRow",nowVO);
        model.addAttribute("leftRow",nLeftRow);        
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatCntFeeList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCenterCntFee", nowVO);
        model.addAttribute("ptnrStatCntFeeList_10",ptnrStatCntFeeList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRow_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatCenterEndLeftRow",nowVO);
        model.addAttribute("leftRow_10",nLeftRow_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatCntFeeList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCenterCntFee", nowVO);
        model.addAttribute("ptnrStatCntFeeList_15",ptnrStatCntFeeList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRow_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatCenterEndLeftRow",nowVO);
        model.addAttribute("leftRow_15",nLeftRow_15);
        //센터 전체 목록 끝
        
        //보험사 팀별(전체) 실적 시작
        nowVO.setDiv_type("5");
        List<Map<String, Object>> ptnrStatTeamAllCntFeeList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamAllCntFee", nowVO);		
        model.addAttribute("ptnrStatTeamAllCntFeeList",ptnrStatTeamAllCntFeeList);        
        
        //물보험 팀별 조사 통계 좌측 row 계산
        int nLeftRowTeamAll = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamAllEndLeftRow",nowVO);
        model.addAttribute("leftRowTeamAll",nLeftRowTeamAll);
        
        //물보험 팀별 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatTeamAllCntFeeList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamAllCntFee", nowVO);
        model.addAttribute("ptnrStatTeamAllCntFeeList_10",ptnrStatTeamAllCntFeeList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRowTeamAll_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamAllEndLeftRow",nowVO);
        model.addAttribute("leftRowTeamAll_10",nLeftRowTeamAll_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatTeamAllCntFeeList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamAllCntFee", nowVO);
        model.addAttribute("ptnrStatTeamAllCntFeeList_15",ptnrStatTeamAllCntFeeList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRowTeamAll_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamAllEndLeftRow",nowVO);
        model.addAttribute("leftRowTeamAll_15",nLeftRowTeamAll_15);
        
        
        model.addAttribute("ptnrName", sPtnrName);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_center_cnt_fee";
	}
	
	/**
	 * 보험사 센터별 실적 종결현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatCenterFee")
	public String ptnrStatCenterFee(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatCenterFee =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		String sPtnrId = String.valueOf(paramMap.get("ptnr_id"));
		String sPtnrName = sqlSession.selectOne("MisEndPtnrMapper.selectPtnrNameByPtnrId",sPtnrId);
				
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //센터 전체 목록 시작
        //물보험 조사 통계        
        nowVO.setDiv_type("5");
        nowVO.setPtnr_id(sPtnrId);
        
        List<Map<String, Object>> ptnrStatFeeList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCenterFee", nowVO);		
        model.addAttribute("ptnrStatFeeList",ptnrStatFeeList);
        //물보험 조사 통계 좌측 row 계산
        int nLeftRow = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatCenterEndLeftRow",nowVO);
        model.addAttribute("leftRow",nLeftRow);        
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatFeeList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCenterFee", nowVO);
        model.addAttribute("ptnrStatFeeList_10",ptnrStatFeeList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRow_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatCenterEndLeftRow",nowVO);
        model.addAttribute("leftRow_10",nLeftRow_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatFeeList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCenterFee", nowVO);
        model.addAttribute("ptnrStatFeeList_15",ptnrStatFeeList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRow_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatCenterEndLeftRow",nowVO);
        model.addAttribute("leftRow_15",nLeftRow_15);
        //센터 전체 목록 끝
        
        //보험사 팀별(전체) 실적 시작
        nowVO.setDiv_type("5");
        List<Map<String, Object>> ptnrStatTeamAllFeeList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamAllFee", nowVO);		
        model.addAttribute("ptnrStatTeamAllFeeList",ptnrStatTeamAllFeeList);        
        
        //물보험 팀별 조사 통계 좌측 row 계산
        int nLeftRowTeamAll = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamAllEndLeftRow",nowVO);
        model.addAttribute("leftRowTeamAll",nLeftRowTeamAll);
        
        //물보험 팀별 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatTeamAllFeeList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamAllFee", nowVO);
        model.addAttribute("ptnrStatTeamAllFeeList_10",ptnrStatTeamAllFeeList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRowTeamAll_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamAllEndLeftRow",nowVO);
        model.addAttribute("leftRowTeamAll_10",nLeftRowTeamAll_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatTeamAllFeeList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamAllFee", nowVO);
        model.addAttribute("ptnrStatTeamAllFeeList_15",ptnrStatTeamAllFeeList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRowTeamAll_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamAllEndLeftRow",nowVO);
        model.addAttribute("leftRowTeamAll_15",nLeftRowTeamAll_15); 

        
        model.addAttribute("ptnrName", sPtnrName);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_center_fee";
	}
	
	/**
	 * 보험사 센터별 실적 종결현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatCenterEnd")
	public String ptnrStatCenterEnd(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatCenterEnd =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		String sPtnrId = String.valueOf(paramMap.get("ptnr_id"));
		String sPtnrName = sqlSession.selectOne("MisEndPtnrMapper.selectPtnrNameByPtnrId",sPtnrId);
				
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //센터 전체 목록 시작        
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        nowVO.setPtnr_id(sPtnrId);
        
        List<Map<String, Object>> ptnrStatEndList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCenterEnd", nowVO);		
        model.addAttribute("ptnrStatEndList",ptnrStatEndList);
        //물보험 조사 통계 좌측 row 계산
        int nLeftRow = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatCenterEndLeftRow",nowVO);
        model.addAttribute("leftRow",nLeftRow);        
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatEndList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCenterEnd", nowVO);
        model.addAttribute("ptnrStatEndList_10",ptnrStatEndList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRow_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatCenterEndLeftRow",nowVO);
        model.addAttribute("leftRow_10",nLeftRow_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatEndList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCenterEnd", nowVO);
        model.addAttribute("ptnrStatEndList_15",ptnrStatEndList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRow_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatCenterEndLeftRow",nowVO);
        model.addAttribute("leftRow_15",nLeftRow_15);
        //센터 전체 목록 끝
        
        //보험사 팀별(전체) 실적 시작
        nowVO.setDiv_type("5");
        List<Map<String, Object>> ptnrStatTeamAllEndList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamAllEnd", nowVO);		
        model.addAttribute("ptnrStatTeamAllEndList",ptnrStatTeamAllEndList);        
        
        //물보험 팀별 조사 통계 좌측 row 계산
        int nLeftRowTeamAll = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamAllEndLeftRow",nowVO);
        model.addAttribute("leftRowTeamAll",nLeftRowTeamAll);
        
        //물보험 팀별 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatTeamAllEndList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamAllEnd", nowVO);
        model.addAttribute("ptnrStatTeamAllEndList_10",ptnrStatTeamAllEndList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRowTeamAll_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamAllEndLeftRow",nowVO);
        model.addAttribute("leftRowTeamAll_10",nLeftRowTeamAll_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatTeamAllEndList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamAllEnd", nowVO);
        model.addAttribute("ptnrStatTeamAllEndList_15",ptnrStatTeamAllEndList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRowTeamAll_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamAllEndLeftRow",nowVO);
        model.addAttribute("leftRowTeamAll_15",nLeftRowTeamAll_15);
        
        //보험사 개인별(전체) 실적 시작
        nowVO.setDiv_type("5");
        List<Map<String, Object>> ptnrStatMemberAllEndList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberAllEnd", nowVO);		
        model.addAttribute("ptnrStatMemberAllEndList",ptnrStatMemberAllEndList);        
        
        //물보험 개인별 조사 통계 좌측 row 계산
        int nLeftRowMemberAll = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberAllEndLeftRow",nowVO);
        model.addAttribute("leftRowMemberAll",nLeftRowMemberAll);
        
        //물보험 개인별 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatMemberAllEndList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberAllEnd", nowVO);
        model.addAttribute("ptnrStatMemberAllEndList_10",ptnrStatMemberAllEndList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRowMemberAll_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberAllEndLeftRow",nowVO);
        model.addAttribute("leftRowMemberAll_10",nLeftRowMemberAll_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatMemberAllEndList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberAllEnd", nowVO);
        model.addAttribute("ptnrStatMemberAllEndList_15",ptnrStatMemberAllEndList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRowMemberAll_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberAllEndLeftRow",nowVO);
        model.addAttribute("leftRowMemberAll_15",nLeftRowMemberAll_15);
        //보험사 개인별(전체) 실적 끝                
        
        model.addAttribute("ptnrName", sPtnrName);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_center_end";
	}
	
	/**
	 * 보험사 센터별 실적 수임현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatCenterMain")
	public String ptnrStatCenterMain(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatCenterMain =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		String sPtnrId = String.valueOf(paramMap.get("ptnr_id"));
		String sPtnrName = sqlSession.selectOne("MisEndPtnrMapper.selectPtnrNameByPtnrId",sPtnrId);
				
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        nowVO.setPtnr_id(sPtnrId);
        
        //보험사 센터별 실적시작
        List<Map<String, Object>> ptnrStatRegList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCenterReg", nowVO);		
        model.addAttribute("ptnrStatRegList",ptnrStatRegList);
        //물보험 센터별 조사 통계 좌측 row 계산
        int nLeftRow = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatCenterRegLeftRow",nowVO);
        model.addAttribute("leftRow",nLeftRow);        
        
        //물보험 센터별 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatRegList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCenterReg", nowVO);
        model.addAttribute("ptnrStatRegList_10",ptnrStatRegList_10);
        //물보험 센터별 심사 통계 좌측 row 계산
        int nLeftRow_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatCenterRegLeftRow",nowVO);
        model.addAttribute("leftRow_10",nLeftRow_10);
        
        //물보험 센터별 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatRegList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCenterReg", nowVO);
        model.addAttribute("ptnrStatRegList_15",ptnrStatRegList_15);
        //물보험 센터별 기타 통계 좌측 row 계산
        int nLeftRow_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatCenterRegLeftRow",nowVO);
        model.addAttribute("leftRow_15",nLeftRow_15);        
        //보험사 센터별 실적 끝        

        
        //보험사 팀별(전체) 실적 시작
        nowVO.setDiv_type("5");
        List<Map<String, Object>> ptnrStatTeamAllRegList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamAllReg", nowVO);		
        model.addAttribute("ptnrStatTeamAllRegList",ptnrStatTeamAllRegList);        
        
        //물보험 팀별 조사 통계 좌측 row 계산
        int nLeftRowTeamAll = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamAllRegLeftRow",nowVO);
        model.addAttribute("leftRowTeamAll",nLeftRowTeamAll);
        
        //물보험 팀별 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatTeamAllRegList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamAllReg", nowVO);
        model.addAttribute("ptnrStatTeamAllRegList_10",ptnrStatTeamAllRegList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRowTeamAll_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamAllRegLeftRow",nowVO);
        model.addAttribute("leftRowTeamAll_10",nLeftRowTeamAll_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatTeamAllRegList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTeamAllReg", nowVO);
        model.addAttribute("ptnrStatTeamAllRegList_15",ptnrStatTeamAllRegList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRowTeamAll_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatTeamAllRegLeftRow",nowVO);
        model.addAttribute("leftRowTeamAll_15",nLeftRowTeamAll_15);
        //보험사 팀별(전체) 실적 끝
                
        //보험사 개인별(전체) 실적 시작
        /**
        nowVO.setDiv_type("5");
        List<Map<String, Object>> ptnrStatMemberAllRegList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberAllReg", nowVO);		
        model.addAttribute("ptnrStatMemberAllRegList",ptnrStatMemberAllRegList);        
        
        //물보험 개인별 조사 통계 좌측 row 계산
        int nLeftRowMemberAll = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberAllRegLeftRow",nowVO);
        model.addAttribute("leftRowMemberAll",nLeftRowMemberAll);        
        
        //물보험 개인별 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatMemberAllRegList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberAllReg", nowVO);
        model.addAttribute("ptnrStatMemberAllRegList_10",ptnrStatMemberAllRegList_10);
        //물보험 심사 통계 좌측 row 계산
        int nLeftRowMemberAll_10 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberAllRegLeftRow",nowVO);
        model.addAttribute("leftRowMemberAll_10",nLeftRowMemberAll_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatMemberAllRegList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatMemberAllReg", nowVO);
        model.addAttribute("ptnrStatMemberAllRegList_15",ptnrStatMemberAllRegList_15);
        //물보험 기타 통계 좌측 row 계산
        int nLeftRowMemberAll_15 = sqlSession.selectOne("MisEndPtnrMapper.PtnrStatMemberAllRegLeftRow",nowVO);
        model.addAttribute("leftRowMemberAll_15",nLeftRowMemberAll_15);
        **/
        //보험사 개인별(전체) 실적 끝
        
        model.addAttribute("ptnrName", sPtnrName);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_center_main";
	}

	/**
	 * 보험사 부서별 실적현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatMain")
	public String ptnrStatMain(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatMain =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");

		//검색 로그 남기기 시작 (20240109)
		String sUserNo = mbrVo.getUser_no();		
		String sUserName = mbrVo.getUser_name();
		String sIp = mbrVo.getUser_ip();
		String sLogPage = "보험사별통계(부서별실적현황)";

		Map<String, Object> logMap = new HashMap<String, Object>();

		logMap.put("user_no", sUserNo);
		logMap.put("user_name", sUserName);
		logMap.put("user_ip", sIp);
		logMap.put("search_page", sLogPage);

		sqlSession.insert("SaveLogMapper.insertTopSearchLog",logMap);
		//검색 로그 남기기 끝 (20240109)
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //검색 항목 끝
        //좌측 rowspan 열 계산하기 (전체보험사 + 상세코드가 존재하는경우 소계 row 추가)
        int nLeftRowCnt = sqlSession.selectOne("MisEndPtnrMapper.ptnrLeftRowCnt");
        
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        List<Map<String, Object>> ptnrStatRegList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatReg", nowVO);		
        model.addAttribute("ptnrStatRegList",ptnrStatRegList);
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatRegList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatReg", nowVO);
        model.addAttribute("ptnrStatRegList_10",ptnrStatRegList_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatRegList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatReg", nowVO);
        model.addAttribute("ptnrStatRegList_15",ptnrStatRegList_15);
        
		//for( int i=0; i < ptnrStatRegList_15.size(); i++ ) {
			//CommonUtils.printMap(ptnrStatRegList_15.get(i));
		//}
		
        model.addAttribute("rowCnt",nLeftRowCnt);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_main";
	}
	
	/**
	 * 보험사 부서별 총합계(총 청구비용) 조회
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatEntire")
	public String ptnrStatEntire(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatEntire =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //검색 항목 끝
        //좌측 rowspan 열 계산하기 (전체보험사 + 상세코드가 존재하는경우 소계 row 추가)
        int nLeftRowCnt = sqlSession.selectOne("MisEndPtnrMapper.ptnrLeftRowCnt");
        
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        List<Map<String, Object>> ptnrStatEntireList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatEntire", nowVO);		
        model.addAttribute("ptnrStatEntireList",ptnrStatEntireList);
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatEntireList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatEntire", nowVO);
        model.addAttribute("ptnrStatEntireList_10",ptnrStatEntireList_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatEntireList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatEntire", nowVO);
        model.addAttribute("ptnrStatEntireList_15",ptnrStatEntireList_15);
        
		//for( int i=0; i < ptnrStatRegList_15.size(); i++ ) {
			//CommonUtils.printMap(ptnrStatRegList_15.get(i));
		//}
		
        model.addAttribute("rowCnt",nLeftRowCnt);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_entire";
	}
	
	/**
	 * 보험사 부서별 자문료+기타 조회
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatEtc")
	public String ptnrStatEtc(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatEtc =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //검색 항목 끝
        //좌측 rowspan 열 계산하기 (전체보험사 + 상세코드가 존재하는경우 소계 row 추가)
        int nLeftRowCnt = sqlSession.selectOne("MisEndPtnrMapper.ptnrLeftRowCnt");
        
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        List<Map<String, Object>> ptnrStatEtcList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatEtc", nowVO);		
        model.addAttribute("ptnrStatEtcList",ptnrStatEtcList);
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatEtcList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatEtc", nowVO);
        model.addAttribute("ptnrStatEtcList_10",ptnrStatEtcList_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatEtcList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatEtc", nowVO);
        model.addAttribute("ptnrStatEtcList_15",ptnrStatEtcList_15);
        
		//for( int i=0; i < ptnrStatRegList_15.size(); i++ ) {
			//CommonUtils.printMap(ptnrStatRegList_15.get(i));
		//}
		
        model.addAttribute("rowCnt",nLeftRowCnt);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_etc";
	}
	
	/**
	 * 보험사 부서별 교통비 조회
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatTraffic")
	public String ptnrStatTraffic(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatTraffic =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //검색 항목 끝
        //좌측 rowspan 열 계산하기 (전체보험사 + 상세코드가 존재하는경우 소계 row 추가)
        int nLeftRowCnt = sqlSession.selectOne("MisEndPtnrMapper.ptnrLeftRowCnt");
        
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        List<Map<String, Object>> ptnrStatTrafficList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTraffic", nowVO);		
        model.addAttribute("ptnrStatTrafficList",ptnrStatTrafficList);
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatTrafficList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTraffic", nowVO);
        model.addAttribute("ptnrStatTrafficList_10",ptnrStatTrafficList_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatTrafficList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTraffic", nowVO);
        model.addAttribute("ptnrStatTrafficList_15",ptnrStatTrafficList_15);
        
		//for( int i=0; i < ptnrStatRegList_15.size(); i++ ) {
			//CommonUtils.printMap(ptnrStatRegList_15.get(i));
		//}
		
        model.addAttribute("rowCnt",nLeftRowCnt);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_traffic";
	}
	
	/**
	 * 보험사 부서별 건당 일비 조회
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatCntTime")
	public String ptnrStatCntTime(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatCntTime =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //검색 항목 끝
        //좌측 rowspan 열 계산하기 (전체보험사 + 상세코드가 존재하는경우 소계 row 추가)
        int nLeftRowCnt = sqlSession.selectOne("MisEndPtnrMapper.ptnrLeftRowCnt");
        
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        List<Map<String, Object>> ptnrStatCntTimeList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCntTime", nowVO);		
        model.addAttribute("ptnrStatCntTimeList",ptnrStatCntTimeList);
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatCntTimeList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCntTime", nowVO);
        model.addAttribute("ptnrStatCntTimeList_10",ptnrStatCntTimeList_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatCntTimeList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCntTime", nowVO);
        model.addAttribute("ptnrStatCntTimeList_15",ptnrStatCntTimeList_15);
        
		//for( int i=0; i < ptnrStatRegList_15.size(); i++ ) {
			//CommonUtils.printMap(ptnrStatRegList_15.get(i));
		//}
		
        model.addAttribute("rowCnt",nLeftRowCnt);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_cnt_time";
	}
	
	/**
	 * 보험사 부서별 일비 조회
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatTime")
	public String ptnrStatTime(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatTime =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //검색 항목 끝
        //좌측 rowspan 열 계산하기 (전체보험사 + 상세코드가 존재하는경우 소계 row 추가)
        int nLeftRowCnt = sqlSession.selectOne("MisEndPtnrMapper.ptnrLeftRowCnt");
        
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        List<Map<String, Object>> ptnrStatTimeList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTime", nowVO);		
        model.addAttribute("ptnrStatTimeList",ptnrStatTimeList);
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatTimeList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTime", nowVO);
        model.addAttribute("ptnrStatTimeList_10",ptnrStatTimeList_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatTimeList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatTime", nowVO);
        model.addAttribute("ptnrStatTimeList_15",ptnrStatTimeList_15);
        
		//for( int i=0; i < ptnrStatRegList_15.size(); i++ ) {
			//CommonUtils.printMap(ptnrStatRegList_15.get(i));
		//}
		
        model.addAttribute("rowCnt",nLeftRowCnt);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_time";
	}
	
	/**
	 * 보험사 별 건당 순수피
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatCntFee")
	public String ptnrStatCntFee(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatCntFee =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //검색 항목 끝
        //좌측 rowspan 열 계산하기 (전체보험사 + 상세코드가 존재하는경우 소계 row 추가)
        int nLeftRowCnt = sqlSession.selectOne("MisEndPtnrMapper.ptnrLeftRowCnt");
        
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        List<Map<String, Object>> ptnrStatCntFeeList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCntFee", nowVO);        
        model.addAttribute("ptnrStatCntFeeList",ptnrStatCntFeeList);
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatCntFeeList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCntFee", nowVO);        
        model.addAttribute("ptnrStatCntFeeList_10",ptnrStatCntFeeList_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatCntFeeList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatCntFee", nowVO);
        model.addAttribute("ptnrStatCntFeeList_15",ptnrStatCntFeeList_15);
        
		//for( int i=0; i < ptnrStatRegList_15.size(); i++ ) {
			//CommonUtils.printMap(ptnrStatRegList_15.get(i));
		//}
		
        model.addAttribute("rowCnt",nLeftRowCnt);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_cnt_fee";
	}
	
	/**
	 * 보험사 부서별 순수피 조회
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatFee")
	public String ptnrStatFee(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatFee =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //검색 항목 끝
        //좌측 rowspan 열 계산하기 (전체보험사 + 상세코드가 존재하는경우 소계 row 추가)
        int nLeftRowCnt = sqlSession.selectOne("MisEndPtnrMapper.ptnrLeftRowCnt");
        
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        List<Map<String, Object>> ptnrStatFeeList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatFee", nowVO);		
        model.addAttribute("ptnrStatFeeList",ptnrStatFeeList);
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatFeeList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatFee", nowVO);
        model.addAttribute("ptnrStatFeeList_10",ptnrStatFeeList_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatFeeList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatFee", nowVO);
        model.addAttribute("ptnrStatFeeList_15",ptnrStatFeeList_15);
        
		//for( int i=0; i < ptnrStatRegList_15.size(); i++ ) {
			//CommonUtils.printMap(ptnrStatRegList_15.get(i));
		//}
		
        model.addAttribute("rowCnt",nLeftRowCnt);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_fee";
	}
	
	/**
	 * 보험사 부서별 종결현황
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/ptnrStatEnd")
	public String ptnrStatEnd(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {

		logger.info("======= ptnrStatEnd =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			session.invalidate();
			return "top_login/top_login";
		}
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		
		//검색 항목 시작
		String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));		//기준일자 시작일
		String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));		//기준일자 종료일

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
		
        //검색 항목 끝
        //좌측 rowspan 열 계산하기 (전체보험사 + 상세코드가 존재하는경우 소계 row 추가)
        int nLeftRowCnt = sqlSession.selectOne("MisEndPtnrMapper.ptnrLeftRowCnt");
        
        //물보험 조사 통계
        nowVO.setDiv_type("5");
        List<Map<String, Object>> ptnrStatEndList = sqlSession.selectList("MisEndPtnrMapper.PtnrStatEnd", nowVO);		
        model.addAttribute("ptnrStatEndList",ptnrStatEndList);
        
        //물보험 심사 통계
        nowVO.setDiv_type("10");
        List<Map<String, Object>> ptnrStatEndList_10 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatEnd", nowVO);
        model.addAttribute("ptnrStatEndList_10",ptnrStatEndList_10);
        
        //물보험 기타 통계
        nowVO.setDiv_type("15");
        List<Map<String, Object>> ptnrStatEndList_15 = sqlSession.selectList("MisEndPtnrMapper.PtnrStatEnd", nowVO);
        model.addAttribute("ptnrStatEndList_15",ptnrStatEndList_15);
        
		//for( int i=0; i < ptnrStatRegList_15.size(); i++ ) {
			//CommonUtils.printMap(ptnrStatRegList_15.get(i));
		//}
		
        model.addAttribute("rowCnt",nLeftRowCnt);
        model.addAttribute("nowVO", nowVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/ptnr_stat_end";
	}
	
	// =============================================
	// 보험사별 - 종결현황 - 절대건수 (보험사 기준)
	// =============================================
	@RequestMapping(value = "/MisEndPtnr")
	public String MisEndPtnr(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= MisEndPtnr =======");
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
        
        paramMap.put("team_id",teamId);
        
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
        nowVO.setTeam_id(teamId);
        
		//List<MisEndTmVO> MisEndPtnr1 = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnr1", nowVO);
		//model.addAttribute("MisEndPtnr1",MisEndPtnr1);
        
        //물보험 조사 별도 통계
        List<MisEndTmVO> MisEndPtnr1Main = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnr1Main", nowVO);
		model.addAttribute("MisEndPtnr1Main",MisEndPtnr1Main);
		
		//물보험 심사 별도 통계 시작
		List<MisEndTmVO> MisEndPtnr1Written = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnr1Written", nowVO);
		
		//서면심사 팀에 지정된 보험사 목록을 불러온다. (ptnr_id = 0은 제외)
        List<Map<String,Object>> writtenPtnrIdList = sqlSession.selectList("MisPtnrBsc.selectWrittenPtnrIdList"); 
        
        //보험사(심사)임시Map
        MisEndTmVO writtenPtnrMap = new MisEndTmVO();
        
        String sPtnrId = "";				//보고서 내 보험사코드
        String sPtnrIdChk = "";			//별도로 카운트해야하는 보험사 코드
        
        for(int i=0; i < MisEndPtnr1Written.size(); i++) {        	
        	//보고서에서 추출된 보험사코드
        	sPtnrId = StringUtil.null2blank(MisEndPtnr1Written.get(i).getPtnr_id());
        	
        	for(int k=0; k < writtenPtnrIdList.size(); k++) {        		
        		sPtnrIdChk = String.valueOf(writtenPtnrIdList.get(k).get("ptnr_id"));			//별도계산할 보험사 코드
        		
        		//보고서의 보험사코드와 별도 심사 건수 등록보험사의경우는 건수를 다시 가져온다.
        		if( sPtnrId.equals(sPtnrIdChk) ) {
        			
        			//재쿼리할 보험사 Id를 셋팅한다.
        			nowVO.setPtnr_id(sPtnrId);
        			
        			writtenPtnrMap = sqlSession.selectOne("MisEndPtnrMapper.MisEndPtnr1WrittenExtra", nowVO);
        			
        			MisEndPtnr1Written.get(i).setEnd_rid12(writtenPtnrMap.getCls_12());
        			MisEndPtnr1Written.get(i).setEnd_rid11(writtenPtnrMap.getCls_11());
        			MisEndPtnr1Written.get(i).setEnd_rid10(writtenPtnrMap.getCls_10());
        			MisEndPtnr1Written.get(i).setEnd_rid9(writtenPtnrMap.getCls_9());
        			MisEndPtnr1Written.get(i).setEnd_rid8(writtenPtnrMap.getCls_8());
        			MisEndPtnr1Written.get(i).setEnd_rid7(writtenPtnrMap.getCls_7());
        			MisEndPtnr1Written.get(i).setEnd_rid6(writtenPtnrMap.getCls_6());
        			MisEndPtnr1Written.get(i).setEnd_rid5(writtenPtnrMap.getCls_5());
        			MisEndPtnr1Written.get(i).setEnd_rid4(writtenPtnrMap.getCls_4());
        			MisEndPtnr1Written.get(i).setEnd_rid3(writtenPtnrMap.getCls_3());
        			MisEndPtnr1Written.get(i).setEnd_rid2(writtenPtnrMap.getCls_2());
        			MisEndPtnr1Written.get(i).setEnd_rid(writtenPtnrMap.getCls_1());
        		}
        	}
        }        
		
		model.addAttribute("MisEndPtnr1Written",MisEndPtnr1Written);		
		//물보험 심사 별도 통계 끝
		
		List<MisEndTmVO> MisEndPtnr4 = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnr4", nowVO);
		model.addAttribute("MisEndPtnr4",MisEndPtnr4);

		model.addAttribute("nowVO", nowVO);

		//model.addAttribute("inVO", inVO);
		model.addAttribute("srchArg", paramMap);
		

		return "top_statistics/mis_end_ptnr";
	}
	
	
	// =============================================
	// 보험사별 - 종결현황 - 순수 피 (보험사 기준)
	// =============================================	
	@RequestMapping(value = "/MisEndPtnrAssess")
	public String MisEndPtnrAssess(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= MisEndPtnrAssess =======");
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
        
        paramMap.put("team_id",teamId);
        
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
        nowVO.setTeam_id(teamId);
        
		//List<MisEndTmVO> MisEndPtnrAssess1 = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrAssess1", nowVO);
		//model.addAttribute("MisEndPtnrAssess1",MisEndPtnrAssess1);
		
        //물보험 조사 별도 통계
		List<MisEndTmVO> MisEndPtnrAssess1Main = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrAssess1Main", nowVO);
		model.addAttribute("MisEndPtnrAssess1Main",MisEndPtnrAssess1Main);
		
		//물보험 심사 별도 통계
		List<MisEndTmVO> MisEndPtnrAssess1Written = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrAssess1Written", nowVO);
		model.addAttribute("MisEndPtnrAssess1Written",MisEndPtnrAssess1Written);
		
		List<MisEndTmVO> MisEndPtnrAssess4 = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrAssess4", nowVO);
		model.addAttribute("MisEndPtnrAssess4",MisEndPtnrAssess4);


		model.addAttribute("nowVO", nowVO);

		//model.addAttribute("inVO", inVO);
		model.addAttribute("srchArg", paramMap);
		

		return "top_statistics/mis_end_ptnr_assess";
	}
	
	
	// =============================================
	// 보험사별 - 종결현황 - 일비 (보험사 기준)
	// =============================================
	@RequestMapping(value = "/MisEndPtnrTime")
	public String MisEndPtnrTime(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= MisEndPtnrTime =======");
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
        
        paramMap.put("team_id",teamId);
        
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
        nowVO.setTeam_id(teamId);        
        
		//List<MisEndTmVO> MisEndPtnrTime1 = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrTime1", nowVO);
		//model.addAttribute("MisEndPtnrTime1",MisEndPtnrTime1);
		
        //물보험 조사 별도 통계
		List<MisEndTmVO> MisEndPtnrTime1Main = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrTime1Main", nowVO);
		model.addAttribute("MisEndPtnrTime1Main",MisEndPtnrTime1Main);
		
		//물보험 심사 별도 통계
		List<MisEndTmVO> MisEndPtnrTime1Written = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrTime1Written", nowVO);
		model.addAttribute("MisEndPtnrTime1Written",MisEndPtnrTime1Written);
		
		List<MisEndTmVO> MisEndPtnrTime4 = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrTime4", nowVO);
		model.addAttribute("MisEndPtnrTime4",MisEndPtnrTime4);


		model.addAttribute("nowVO", nowVO);

		//model.addAttribute("inVO", inVO);
		model.addAttribute("srchArg", paramMap);
		
		return "top_statistics/mis_end_ptnr_time";
	}
	
	// =============================================
	// 보험사별 - 종결현황 - 교통비 (보험사 기준)
	// =============================================
	@RequestMapping(value = "/MisEndPtnrTraffic")
	public String MisEndPtnrTraffic(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= MisEndPtnrTraffic =======");
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
        paramMap.put("team_id",teamId);
        
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
        nowVO.setTeam_id(teamId);
        
		//List<MisEndTmVO> MisEndPtnrTraffic1 = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrTraffic1", nowVO);
		//model.addAttribute("MisEndPtnrTraffic1",MisEndPtnrTraffic1);
		
        //물보험 조사 통계
		List<MisEndTmVO> MisEndPtnrTraffic1Main = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrTraffic1Main", nowVO);
		model.addAttribute("MisEndPtnrTraffic1Main",MisEndPtnrTraffic1Main);
		
		//물보험 심사 통계
		List<MisEndTmVO> MisEndPtnrTraffic1Written = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrTraffic1Written", nowVO);
		model.addAttribute("MisEndPtnrTraffic1Written",MisEndPtnrTraffic1Written);
		
		List<MisEndTmVO> MisEndPtnrTraffic4 = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrTraffic4", nowVO);
		model.addAttribute("MisEndPtnrTraffic4",MisEndPtnrTraffic4);


		model.addAttribute("nowVO", nowVO);

		//model.addAttribute("inVO", inVO);
		model.addAttribute("srchArg", paramMap);
		

		return "top_statistics/mis_end_ptnr_traffic";
	}
	
	
	// =============================================
	// 보험사별 - 종결현황 - 자문료+기타 (보험사 기준)
	// =============================================
	@RequestMapping(value = "/MisEndPtnrQr")
	public String MisEndPtnrQr(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= MisEndPtnrQr =======");
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
        
        paramMap.put("team_id",teamId);
        
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
        nowVO.setTeam_id(teamId);
        
		//List<MisEndTmVO> MisEndPtnrQr1 = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrQr1", nowVO);
		//model.addAttribute("MisEndPtnrQr1",MisEndPtnrQr1);
		
        //물보험 조사 통계
		List<MisEndTmVO> MisEndPtnrQr1Main = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrQr1Main", nowVO);
		model.addAttribute("MisEndPtnrQr1Main",MisEndPtnrQr1Main);
		
		//물보험 심사 통계
		List<MisEndTmVO> MisEndPtnrQr1Written = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrQr1Written", nowVO);
		model.addAttribute("MisEndPtnrQr1Written",MisEndPtnrQr1Written);
		
		List<MisEndTmVO> MisEndPtnrQr4 = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrQr4", nowVO);
		model.addAttribute("MisEndPtnrQr4",MisEndPtnrQr4);


		model.addAttribute("nowVO", nowVO);
		//model.addAttribute("inVO", inVO);
		model.addAttribute("srchArg", paramMap);
		

		return "top_statistics/mis_end_ptnr_qr";
	}
	
	// =============================================
	// 보험사별 - 종결현황 - 총합계 (보험사 기준)
	// =============================================
	@RequestMapping(value = "/MisEndPtnrTotal")
	public String MisEndPtnrTotal(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= MisEndPtnrTotal =======");
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
        
        paramMap.put("team_id",teamId);
        
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
        nowVO.setTeam_id(teamId);
        
		//List<MisEndTmVO> MisEndPtnrTotal1 = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrTotal1", nowVO);
		//model.addAttribute("MisEndPtnrTotal1",MisEndPtnrTotal1);
		
        //물보험 조사 통계
		List<MisEndTmVO> MisEndPtnrTotal1Main = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrTotal1Main", nowVO);
		model.addAttribute("MisEndPtnrTotal1Main",MisEndPtnrTotal1Main);
		
		//물보험 심사 통계
		List<MisEndTmVO> MisEndPtnrTotal1Written = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrTotal1Written", nowVO);
		model.addAttribute("MisEndPtnrTotal1Written",MisEndPtnrTotal1Written);
		
		List<MisEndTmVO> MisEndPtnrTotal4 = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrTotal4", nowVO);
		model.addAttribute("MisEndPtnrTotal4",MisEndPtnrTotal4);


		model.addAttribute("nowVO", nowVO);

		//model.addAttribute("inVO", inVO);
		model.addAttribute("srchArg", paramMap);
		
		return "top_statistics/mis_end_ptnr_total";
	}	
	
	// =============================================
	// 보험사별 - 종결현황 - 절대건수 (팀 기준)
	// =============================================
	@RequestMapping(value = "/MisEndPtnrTm")
	public String MisEndPtnrTm(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= MisEndPtnrTm =======");
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
        String ptnrId = String.valueOf(paramMap.get("ptnr_id"));
        
        paramMap.put("team_id",teamId);
        paramMap.put("ptnr_id",ptnrId);
        
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
        nowVO.setTeam_id(teamId);
        nowVO.setPtnr_id(ptnrId);
        
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
        
		List<MisEndTmVO> MisEndPtnrTm1 = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrTm1", nowVO);
		model.addAttribute("MisEndPtnrTm1",MisEndPtnrTm1);
		
		List<MisEndTmVO> MisEndPtnrTm4 = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrTm4", nowVO);
		model.addAttribute("MisEndPtnrTm4",MisEndPtnrTm4);


		model.addAttribute("nowVO", nowVO);

		//model.addAttribute("inVO", inVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/mis_end_ptnr_tm";
	}
	
	
	// =============================================
	// 보험사별 - 종결현황 - 순수피 (팀 기준)
	// =============================================
	@RequestMapping(value = "/MisEndPtnrTmAssess")
	public String MisEndPtnrTmAssess(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= MisEndPtnrTmAssess =======");
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
        String ptnrId = String.valueOf(paramMap.get("ptnr_id"));
        
        paramMap.put("team_id",teamId);
        paramMap.put("ptnr_id",ptnrId);
        
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
        nowVO.setTeam_id(teamId);
        nowVO.setPtnr_id(ptnrId);
        
		
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
		

		List<MisEndTmVO> MisEndPtnrTmAssess1 = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrTmAssess1", nowVO);
		model.addAttribute("MisEndPtnrTmAssess1",MisEndPtnrTmAssess1);
		
		List<MisEndTmVO> MisEndPtnrTmAssess4 = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrTmAssess4", nowVO);
		model.addAttribute("MisEndPtnrTmAssess4",MisEndPtnrTmAssess4);


		model.addAttribute("nowVO", nowVO);

		//model.addAttribute("inVO", inVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/mis_end_ptnr_tm_assess";
	}
	
	// =============================================
	// 보험사별 - 종결현황 - 일비 (팀 기준)
	// =============================================
	@RequestMapping(value = "/MisEndPtnrTmTime")
	public String MisEndPtnrTmTime(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= MisEndPtnrTmTime =======");
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
        String ptnrId = String.valueOf(paramMap.get("ptnr_id"));
        
        paramMap.put("team_id",teamId);
        paramMap.put("ptnr_id",ptnrId);
        
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
        nowVO.setTeam_id(teamId);
        nowVO.setPtnr_id(ptnrId);
		
		
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


		List<MisEndTmVO> MisEndPtnrTmTime1 = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrTmTime1", nowVO);
		model.addAttribute("MisEndPtnrTmTime1",MisEndPtnrTmTime1);
		
		List<MisEndTmVO> MisEndPtnrTmTime4 = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrTmTime4", nowVO);
		model.addAttribute("MisEndPtnrTmTime4",MisEndPtnrTmTime4);


		model.addAttribute("nowVO", nowVO);

		//model.addAttribute("inVO", inVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/mis_end_ptnr_tm_time";
	}
	
	// =============================================
	// 보험사별 - 종결현황 - 교통비 (팀 기준)
	// =============================================
	@RequestMapping(value = "/MisEndPtnrTmTraffic")
	public String MisEndPtnrTmTraffic(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= MisEndPtnrTmTraffic =======");
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
        String ptnrId = String.valueOf(paramMap.get("ptnr_id"));
        
        paramMap.put("team_id",teamId);
        paramMap.put("ptnr_id",ptnrId);
        
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
        nowVO.setTeam_id(teamId);
        nowVO.setPtnr_id(ptnrId);
        
		
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

		List<MisEndTmVO> MisEndPtnrTmTraffic1 = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrTmTraffic1", nowVO);
		model.addAttribute("MisEndPtnrTmTraffic1",MisEndPtnrTmTraffic1);
		
		List<MisEndTmVO> MisEndPtnrTmTraffic4 = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrTmTraffic4", nowVO);
		model.addAttribute("MisEndPtnrTmTraffic4",MisEndPtnrTmTraffic4);


		model.addAttribute("nowVO", nowVO);

		//model.addAttribute("inVO", inVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/mis_end_ptnr_tm_traffic";
	}
	
	// =============================================
	// 보험사별 - 종결현황 - 자문료+기타 (팀 기준)
	// =============================================
	@RequestMapping(value = "/MisEndPtnrTmQr")
	public String MisEndPtnrTmQr(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= MisEndPtnrTmQr =======");
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
        String ptnrId = String.valueOf(paramMap.get("ptnr_id"));
        
        paramMap.put("team_id",teamId);
        paramMap.put("ptnr_id",ptnrId);
        
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
        nowVO.setTeam_id(teamId);
        nowVO.setPtnr_id(ptnrId);
        		

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
		
		List<MisEndTmVO> MisEndPtnrTmQr1 = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrTmQr1", nowVO);
		model.addAttribute("MisEndPtnrTmQr1",MisEndPtnrTmQr1);
		
		List<MisEndTmVO> MisEndPtnrTmQr4 = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrTmQr4", nowVO);
		model.addAttribute("MisEndPtnrTmQr4",MisEndPtnrTmQr4);


		model.addAttribute("nowVO", nowVO);
		
		//model.addAttribute("inVO", inVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/mis_end_ptnr_tm_qr";
	}
	
	// =============================================
	// 보험사별 - 종결현황 - 총합계 (팀 기준)
	// =============================================
	@RequestMapping(value = "/MisEndPtnrTmTotal")
	public String MisEndPtnrTmTotal(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= MisEndPtnrTmTotal =======");
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
        String ptnrId = String.valueOf(paramMap.get("ptnr_id"));
        
        paramMap.put("team_id",teamId);
        paramMap.put("ptnr_id",ptnrId);
        
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
        nowVO.setTeam_id(teamId);
        nowVO.setPtnr_id(ptnrId);
        
		
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
		
		
		
		List<MisEndTmVO> MisEndPtnrTmTotal1 = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrTmTotal1", nowVO);
		model.addAttribute("MisEndPtnrTmTotal1",MisEndPtnrTmTotal1);
		
		List<MisEndTmVO> MisEndPtnrTmTotal4 = sqlSession.selectList("MisEndPtnrMapper.MisEndPtnrTmTotal4", nowVO);
		model.addAttribute("MisEndPtnrTmTotal4",MisEndPtnrTmTotal4);


		model.addAttribute("nowVO", nowVO);

		//model.addAttribute("inVO", inVO);
		model.addAttribute("srchArg", paramMap);

		return "top_statistics/mis_end_ptnr_tm_total";
	}

}//class
