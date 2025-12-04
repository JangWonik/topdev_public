package kr.co.toplac.topstatistics;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.cmm.service.CodeDicService;
import kr.co.toplac.sysadm.SysAdmCodeDicVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.WebUtil;

/*
*********************************************************
* Program ID	: LogMemberController
* Program Name	: 
* Description	: 
* Author		: leedongik
* Date			: 2015.12.30.
* Update		: 
*********************************************************
*/
@Controller
public class MisAllotTmController {

	private static final Logger logger = LoggerFactory.getLogger(MisAllotTmController.class);

	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private CodeDicService service;
	
	/**
	 * 센터별 일일 배당 현황 (센터 > 보험사별 모달창)
	 * @param request
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/openCenterByPtnrModal")
	public String openCenterByPtnrModal(HttpServletRequest request, Model model, HttpSession session) {
		logger.info("======= openCenterByPtnrModal =======");
        //===============================================
        //	파라미터 체크
        //===============================================
		
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        String center_name = String.valueOf(paramMap.get("center_name"));
        String team_center = String.valueOf(paramMap.get("team_center"));
        
        DateFormat tmpFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date tmpToday = new Date();
		String tmpNow_to = tmpFormat.format(tmpToday);
		
		String today = DateUtil.getTodayString();
		String bgnDe = DateUtil.addDate(today,-30);
		String endDe = DateUtil.addDate(today,1);
		String bgnYearDe = (Integer.parseInt(endDe.substring(0,4)) - 1)  + "1216";
		String endYearDe = endDe.substring(0,4) + "1216";
		
		paramMap.put("bgnDe", bgnDe);
		paramMap.put("endDe", endDe);
		paramMap.put("bgnYearDe", bgnYearDe);
		paramMap.put("endYearDe", endYearDe);		
		
		//월의 시작과 종료 (오늘날짜기준으로 실적월 시작, 종료일을 설정한다.)
		String sMonthSdate = DateUtil.getStartMonthDate(today);
		String sMonthEdate = DateUtil.getEndMonthDate(today);
		
		//System.out.println("당월종결날짜 : "+sMonthSdate+" : "+sMonthEdate);
		
		StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics30DaysDate", tmpNow_to);
                
        //팀별 보험사 수임실적
        //List<Map<String, Object>> ptnrTeamList = sqlSession.selectList("MisAllotTmMbrMapper.selectMisAllotTeamList", paramMap);
        //model.addAttribute("ptnrTeamList", ptnrTeamList);		
		
		//CommonUtils.printMap(paramMap);
		
		//List<Map<String, Object>> ptnrIdSubList = sqlSession.selectList("MisAllotTmMbrMapper.selectMisAllotPtnrList", nowVO);
		nowVO.setBgnDe(sMonthSdate);
		nowVO.setEndDe(sMonthEdate);
		nowVO.setTeam_center(team_center);
		nowVO.setBgnYearDe(bgnYearDe);
		nowVO.setEndYearDe(endYearDe);
		
        List<Map<String, Object>> centerPtnrList = sqlSession.selectList("MisAllotTmMbrMapper.selectMisAllotPtnrListByCenter", nowVO);
        model.addAttribute("centerPtnrList", centerPtnrList);
        
        
        //for( int i=0; i < centerPtnrList.size(); i++ ) {
        	//CommonUtils.printMap(centerPtnrList.get(i));
        //}        
        //1종 조사 센터목록
        
        model.addAttribute("nowVO", nowVO);
        model.addAttribute("centerName", center_name);
        
        //return "top_statistics/mis_allot_ptnr_modal";
        return "top_statistics/mis_allot_center_modal";
	}
		
	/**
	 * 보험사별 일일 배당 현황 (보험사 > 센터 모달창)
	 * @param request
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/openPtnrByCenterModal")
	public String openPtnrByCenterModal(HttpServletRequest request, Model model, HttpSession session) {
		
		logger.info("======= openPtnrByCenterModal =======");
        //===============================================
        //	파라미터 체크
        //===============================================
		
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        String ptnr_name = String.valueOf(paramMap.get("ptnr_name"));
        
        DateFormat tmpFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date tmpToday = new Date();
		String tmpNow_to = tmpFormat.format(tmpToday);
		
		String today = DateUtil.getTodayString();
		String bgnDe = DateUtil.addDate(today,-30);
		String endDe = DateUtil.addDate(today,1);
		String bgnYearDe = (Integer.parseInt(endDe.substring(0,4)) - 1)  + "1216";
		String endYearDe = endDe.substring(0,4) + "1216";
		
		paramMap.put("bgnDe", bgnDe);
		paramMap.put("endDe", endDe);
		paramMap.put("bgnYearDe", bgnYearDe);
		paramMap.put("endYearDe", endYearDe);		
		
		//월의 시작과 종료 (오늘날짜기준으로 실적월 시작, 종료일을 설정한다.)
		String sMonthSdate = DateUtil.getStartMonthDate(today);
		String sMonthEdate = DateUtil.getEndMonthDate(today);
		
		//System.out.println("당월종결날짜 : "+sMonthSdate+" : "+sMonthEdate);
		
		StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics30DaysDate", tmpNow_to);
                
        //팀별 보험사 수임실적
        //List<Map<String, Object>> ptnrTeamList = sqlSession.selectList("MisAllotTmMbrMapper.selectMisAllotTeamList", paramMap);
        //model.addAttribute("ptnrTeamList", ptnrTeamList);
		paramMap.put("sMonthSdate", sMonthSdate);
		paramMap.put("sMonthEdate", sMonthEdate);		
		
        //센터별 보험사 수임실정
        List<Map<String, Object>> ptnrCenterList = sqlSession.selectList("MisAllotTmMbrMapper.selectMisAllotCenterList", paramMap);
        model.addAttribute("ptnrCenterList", ptnrCenterList);
        
        /*
        for( int i=0; i < ptnrCenterList.size(); i++ ) {
        	CommonUtils.printMap(ptnrCenterList.get(i));
        }
        */
        //1종 조사 센터목록
        
        model.addAttribute("nowVO", nowVO);
        model.addAttribute("ptnrNickName", ptnr_name);
        
        return "top_statistics/mis_allot_ptnr_modal";
	}
	
	/**
	 * 전체 센터별 일일배당목록 Ajax
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/misAllotCenterAjax")
	public String misAllotCenterAjax(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {
		
		logger.info("======= misAllotCenterAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		
		DateFormat tmpFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date tmpToday = new Date();
		String tmpNow_to = tmpFormat.format(tmpToday);

		inVO.setViewToDate(tmpNow_to);
		StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics30DaysDate", tmpNow_to);
		StatisticsNowVO nowVO2 = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate");
		nowVO.setNow_from(nowVO2.getNow_from());
		nowVO.setNow_to(nowVO2.getNow_to());
		nowVO.setYear_from(nowVO2.getYear_from());
		nowVO.setYear_to(nowVO2.getYear_to());
		
		//================================================
		// 필요 날짜 세팅
		//================================================
		String today = DateUtil.getTodayString();
		String bgnDe = DateUtil.addDate(today,-30);
		String endDe = DateUtil.addDate(today,1);
		String bgnYearDe = (Integer.parseInt(endDe.substring(0,4)) - 1)  + "1216";
		String endYearDe = endDe.substring(0,4) + "1216";
		
		paramMap.put("bgnDe", bgnDe);
		paramMap.put("endDe", endDe);
		paramMap.put("bgnYearDe", bgnYearDe);
		paramMap.put("endYearDe", endYearDe);
		paramMap.put("now_from", nowVO2.getNow_from());
		paramMap.put("now_to", nowVO2.getNow_to());
		
		//농작물 쿼리 추가로인한 셋팅
		nowVO.setBgnYearDe(bgnYearDe);
		nowVO.setEndYearDe(endYearDe);
		nowVO.setBgnDe(bgnDe);
		nowVO.setEndDe(endDe);
		
		List<MisRegTmVO> getMisAllotTm1 = sqlSession.selectList("MisAllotTmMapper.newGetMisAllotTm1", nowVO);
		
		//서면심사 팀 계산값 저장용 임시 Map
		Map<String, Object> written_team;
		
		//농작물 팀 계산값 저장용 임시 Map
		Map<String, Object> prim_team;
		
		//보고서에 농작물 보고서 카운트를 추가하기위한 임시 변수
		int nRegY = 0;
		int nClsY = 0;
		int nClsM = 0;
		int nRegMi = 0;		
		int nReg30=0;
		int nReg29=0;
		int nReg28=0;
		int nReg27=0;
		int nReg26=0;
		int nReg25=0;
		int nReg24=0;
		int nReg23=0;
		int nReg22=0;
		int nReg21=0;
		int nReg20=0;
		int nReg19=0;
		int nReg18=0;
		int nReg17=0;
		int nReg16=0;
		int nReg15=0;
		int nReg14=0;
		int nReg13=0;
		int nReg12=0;
		int nReg11=0;
		int nReg10=0;
		int nReg09=0;
		int nReg08=0;
		int nReg07=0;
		int nReg06=0;
		int nReg05=0;
		int nReg04=0;
		int nReg03=0;
		int nReg02=0;
		int nReg01=0;
		int nReg00=0;
		
		int nDay30=0;
		int nDay29=0;
		int nDay28=0;
		int nDay27=0;
		int nDay26=0;
		int nDay25=0;
		int nDay24=0;
		int nDay23=0;
		int nDay22=0;
		int nDay21=0;
		int nDay20=0;
		int nDay19=0;
		int nDay18=0;
		int nDay17=0;
		int nDay16=0;
		int nDay15=0;
		int nDay14=0;
		int nDay13=0;
		int nDay12=0;
		int nDay11=0;
		int nDay10=0;
		int nDay09=0;
		int nDay08=0;
		int nDay07=0;
		int nDay06=0;
		int nDay05=0;
		int nDay04=0;
		int nDay03=0;
		int nDay02=0;
		int nDay01=0;
		int nDay00=0;
		
		String sChk_writtenteam = "0";
		
		for(int i=0; i < getMisAllotTm1.size(); i++) {
			sChk_writtenteam = getMisAllotTm1.get(i).getTeam_written().toString();
			
			//서면심사팀인 경우만 재계산해준다.
			if("1".equals(sChk_writtenteam)) {
				
				paramMap.put("team_id", getMisAllotTm1.get(i).getTeam_id());
				
				written_team = sqlSession.selectOne("MisAllotTmMbrMapper.selectMisAllotTmTeam1WrittenList", paramMap);
				//서면심사 팀별 년간 수임, 종결
				getMisAllotTm1.get(i).setReg_y(written_team.get("regY").toString());
				getMisAllotTm1.get(i).setCls_y(written_team.get("clsY").toString());				
				
				//서면심사 팀별 월간 종결
				getMisAllotTm1.get(i).setCls_m(written_team.get("clsM").toString());
				
				//서면심사 팀별 미결
				getMisAllotTm1.get(i).setReg_mi(written_team.get("regMi").toString());
				
				//서면심사 팀별 일일 수임
				getMisAllotTm1.get(i).setReg_00(written_team.get("reg31").toString());
				getMisAllotTm1.get(i).setReg_01(written_team.get("reg30").toString());
				getMisAllotTm1.get(i).setReg_02(written_team.get("reg29").toString());
				getMisAllotTm1.get(i).setReg_03(written_team.get("reg28").toString());
				getMisAllotTm1.get(i).setReg_04(written_team.get("reg27").toString());
				getMisAllotTm1.get(i).setReg_05(written_team.get("reg26").toString());
				getMisAllotTm1.get(i).setReg_06(written_team.get("reg25").toString());
				getMisAllotTm1.get(i).setReg_07(written_team.get("reg24").toString());
				getMisAllotTm1.get(i).setReg_08(written_team.get("reg23").toString());
				getMisAllotTm1.get(i).setReg_09(written_team.get("reg22").toString());
				getMisAllotTm1.get(i).setReg_10(written_team.get("reg21").toString());
				getMisAllotTm1.get(i).setReg_11(written_team.get("reg20").toString());
				getMisAllotTm1.get(i).setReg_12(written_team.get("reg19").toString());
				getMisAllotTm1.get(i).setReg_13(written_team.get("reg18").toString());
				getMisAllotTm1.get(i).setReg_14(written_team.get("reg17").toString());
				getMisAllotTm1.get(i).setReg_15(written_team.get("reg16").toString());
				getMisAllotTm1.get(i).setReg_16(written_team.get("reg15").toString());
				getMisAllotTm1.get(i).setReg_17(written_team.get("reg14").toString());
				getMisAllotTm1.get(i).setReg_18(written_team.get("reg13").toString());
				getMisAllotTm1.get(i).setReg_19(written_team.get("reg12").toString());
				getMisAllotTm1.get(i).setReg_20(written_team.get("reg11").toString());
				getMisAllotTm1.get(i).setReg_21(written_team.get("reg10").toString());
				getMisAllotTm1.get(i).setReg_22(written_team.get("reg09").toString());
				getMisAllotTm1.get(i).setReg_23(written_team.get("reg08").toString());
				getMisAllotTm1.get(i).setReg_24(written_team.get("reg07").toString());
				getMisAllotTm1.get(i).setReg_25(written_team.get("reg06").toString());
				getMisAllotTm1.get(i).setReg_26(written_team.get("reg05").toString());
				getMisAllotTm1.get(i).setReg_27(written_team.get("reg04").toString());
				getMisAllotTm1.get(i).setReg_28(written_team.get("reg03").toString());
				getMisAllotTm1.get(i).setReg_29(written_team.get("reg02").toString());
				
				//서면심사 팀별 일일 종결
				getMisAllotTm1.get(i).setDay_00(written_team.get("day31").toString());
				getMisAllotTm1.get(i).setDay_01(written_team.get("day30").toString());
				getMisAllotTm1.get(i).setDay_02(written_team.get("day29").toString());
				getMisAllotTm1.get(i).setDay_03(written_team.get("day28").toString());
				getMisAllotTm1.get(i).setDay_04(written_team.get("day27").toString());
				getMisAllotTm1.get(i).setDay_05(written_team.get("day26").toString());
				getMisAllotTm1.get(i).setDay_06(written_team.get("day25").toString());
				getMisAllotTm1.get(i).setDay_07(written_team.get("day24").toString());
				getMisAllotTm1.get(i).setDay_08(written_team.get("day23").toString());
				getMisAllotTm1.get(i).setDay_09(written_team.get("day22").toString());
				getMisAllotTm1.get(i).setDay_10(written_team.get("day21").toString());
				getMisAllotTm1.get(i).setDay_11(written_team.get("day20").toString());
				getMisAllotTm1.get(i).setDay_12(written_team.get("day19").toString());
				getMisAllotTm1.get(i).setDay_13(written_team.get("day18").toString());
				getMisAllotTm1.get(i).setDay_14(written_team.get("day17").toString());
				getMisAllotTm1.get(i).setDay_15(written_team.get("day16").toString());
				getMisAllotTm1.get(i).setDay_16(written_team.get("day15").toString());
				getMisAllotTm1.get(i).setDay_17(written_team.get("day14").toString());
				getMisAllotTm1.get(i).setDay_18(written_team.get("day13").toString());
				getMisAllotTm1.get(i).setDay_19(written_team.get("day12").toString());
				getMisAllotTm1.get(i).setDay_20(written_team.get("day11").toString());
				getMisAllotTm1.get(i).setDay_21(written_team.get("day10").toString());
				getMisAllotTm1.get(i).setDay_22(written_team.get("day09").toString());
				getMisAllotTm1.get(i).setDay_23(written_team.get("day08").toString());
				getMisAllotTm1.get(i).setDay_24(written_team.get("day07").toString());
				getMisAllotTm1.get(i).setDay_25(written_team.get("day06").toString());
				getMisAllotTm1.get(i).setDay_26(written_team.get("day05").toString());
				getMisAllotTm1.get(i).setDay_27(written_team.get("day04").toString());
				getMisAllotTm1.get(i).setDay_28(written_team.get("day03").toString());
				getMisAllotTm1.get(i).setDay_29(written_team.get("day02").toString());
			}else{				//서면심사가 아닌경우 농작물 카운트를 더해준다.
				String sTeam_id = getMisAllotTm1.get(i).getTeam_id();
				
				nowVO.setTeam_id(sTeam_id);
				
				//농작물의 일일배당 현황 데이터를 가져온다.				
				prim_team = sqlSession.selectOne("MisAllotTmMbrMapper.selectMisAllotTmTeam1PrimList", nowVO);
				
				//농작물 팀별 일일 수임				
				nReg30 = Integer.parseInt( getMisAllotTm1.get(i).getReg_30().toString() ) + Integer.parseInt( prim_team.get("reg30").toString() );
				nReg29 = Integer.parseInt( getMisAllotTm1.get(i).getReg_29().toString() ) + Integer.parseInt( prim_team.get("reg29").toString() );
				nReg28 = Integer.parseInt( getMisAllotTm1.get(i).getReg_28().toString() ) + Integer.parseInt( prim_team.get("reg28").toString() );
				nReg27 = Integer.parseInt( getMisAllotTm1.get(i).getReg_27().toString() ) + Integer.parseInt( prim_team.get("reg27").toString() );
				nReg26 = Integer.parseInt( getMisAllotTm1.get(i).getReg_26().toString() ) + Integer.parseInt( prim_team.get("reg26").toString() );
				nReg25 = Integer.parseInt( getMisAllotTm1.get(i).getReg_25().toString() ) + Integer.parseInt( prim_team.get("reg25").toString() );
				nReg24 = Integer.parseInt( getMisAllotTm1.get(i).getReg_24().toString() ) + Integer.parseInt( prim_team.get("reg24").toString() );
				nReg23 = Integer.parseInt( getMisAllotTm1.get(i).getReg_23().toString() ) + Integer.parseInt( prim_team.get("reg23").toString() );
				nReg22 = Integer.parseInt( getMisAllotTm1.get(i).getReg_22().toString() ) + Integer.parseInt( prim_team.get("reg22").toString() );
				nReg21 = Integer.parseInt( getMisAllotTm1.get(i).getReg_21().toString() ) + Integer.parseInt( prim_team.get("reg21").toString() );
				nReg20 = Integer.parseInt( getMisAllotTm1.get(i).getReg_20().toString() ) + Integer.parseInt( prim_team.get("reg20").toString() );
				nReg19 = Integer.parseInt( getMisAllotTm1.get(i).getReg_19().toString() ) + Integer.parseInt( prim_team.get("reg19").toString() );
				nReg18 = Integer.parseInt( getMisAllotTm1.get(i).getReg_18().toString() ) + Integer.parseInt( prim_team.get("reg18").toString() );
				nReg17 = Integer.parseInt( getMisAllotTm1.get(i).getReg_17().toString() ) + Integer.parseInt( prim_team.get("reg17").toString() );
				nReg16 = Integer.parseInt( getMisAllotTm1.get(i).getReg_16().toString() ) + Integer.parseInt( prim_team.get("reg16").toString() );
				nReg15 = Integer.parseInt( getMisAllotTm1.get(i).getReg_15().toString() ) + Integer.parseInt( prim_team.get("reg15").toString() );
				nReg14 = Integer.parseInt( getMisAllotTm1.get(i).getReg_14().toString() ) + Integer.parseInt( prim_team.get("reg14").toString() );
				nReg13 = Integer.parseInt( getMisAllotTm1.get(i).getReg_13().toString() ) + Integer.parseInt( prim_team.get("reg13").toString() );
				nReg12 = Integer.parseInt( getMisAllotTm1.get(i).getReg_12().toString() ) + Integer.parseInt( prim_team.get("reg12").toString() );
				nReg11 = Integer.parseInt( getMisAllotTm1.get(i).getReg_11().toString() ) + Integer.parseInt( prim_team.get("reg11").toString() );
				nReg10 = Integer.parseInt( getMisAllotTm1.get(i).getReg_10().toString() ) + Integer.parseInt( prim_team.get("reg10").toString() );
				nReg09 = Integer.parseInt( getMisAllotTm1.get(i).getReg_09().toString() ) + Integer.parseInt( prim_team.get("reg09").toString() );
				nReg08 = Integer.parseInt( getMisAllotTm1.get(i).getReg_08().toString() ) + Integer.parseInt( prim_team.get("reg08").toString() );
				nReg07 = Integer.parseInt( getMisAllotTm1.get(i).getReg_07().toString() ) + Integer.parseInt( prim_team.get("reg07").toString() );
				nReg06 = Integer.parseInt( getMisAllotTm1.get(i).getReg_06().toString() ) + Integer.parseInt( prim_team.get("reg06").toString() );
				nReg05 = Integer.parseInt( getMisAllotTm1.get(i).getReg_05().toString() ) + Integer.parseInt( prim_team.get("reg05").toString() );
				nReg04 = Integer.parseInt( getMisAllotTm1.get(i).getReg_04().toString() ) + Integer.parseInt( prim_team.get("reg04").toString() );
				nReg03 = Integer.parseInt( getMisAllotTm1.get(i).getReg_03().toString() ) + Integer.parseInt( prim_team.get("reg03").toString() );
				nReg02 = Integer.parseInt( getMisAllotTm1.get(i).getReg_02().toString() ) + Integer.parseInt( prim_team.get("reg02").toString() );
				nReg01 = Integer.parseInt( getMisAllotTm1.get(i).getReg_01().toString() ) + Integer.parseInt( prim_team.get("reg01").toString() );
				nReg00 = Integer.parseInt( getMisAllotTm1.get(i).getReg_00().toString() ) + Integer.parseInt( prim_team.get("reg00").toString() );

				nDay30 = Integer.parseInt( getMisAllotTm1.get(i).getDay_30().toString() ) + Integer.parseInt( prim_team.get("day30").toString() );
				nDay29 = Integer.parseInt( getMisAllotTm1.get(i).getDay_29().toString() ) + Integer.parseInt( prim_team.get("day29").toString() );
				nDay28 = Integer.parseInt( getMisAllotTm1.get(i).getDay_28().toString() ) + Integer.parseInt( prim_team.get("day28").toString() );
				nDay27 = Integer.parseInt( getMisAllotTm1.get(i).getDay_27().toString() ) + Integer.parseInt( prim_team.get("day27").toString() );
				nDay26 = Integer.parseInt( getMisAllotTm1.get(i).getDay_26().toString() ) + Integer.parseInt( prim_team.get("day26").toString() );
				nDay25 = Integer.parseInt( getMisAllotTm1.get(i).getDay_25().toString() ) + Integer.parseInt( prim_team.get("day25").toString() );
				nDay24 = Integer.parseInt( getMisAllotTm1.get(i).getDay_24().toString() ) + Integer.parseInt( prim_team.get("day24").toString() );
				nDay23 = Integer.parseInt( getMisAllotTm1.get(i).getDay_23().toString() ) + Integer.parseInt( prim_team.get("day23").toString() );
				nDay22 = Integer.parseInt( getMisAllotTm1.get(i).getDay_22().toString() ) + Integer.parseInt( prim_team.get("day22").toString() );
				nDay21 = Integer.parseInt( getMisAllotTm1.get(i).getDay_21().toString() ) + Integer.parseInt( prim_team.get("day21").toString() );
				nDay20 = Integer.parseInt( getMisAllotTm1.get(i).getDay_20().toString() ) + Integer.parseInt( prim_team.get("day20").toString() );
				nDay19 = Integer.parseInt( getMisAllotTm1.get(i).getDay_19().toString() ) + Integer.parseInt( prim_team.get("day19").toString() );
				nDay18 = Integer.parseInt( getMisAllotTm1.get(i).getDay_18().toString() ) + Integer.parseInt( prim_team.get("day18").toString() );
				nDay17 = Integer.parseInt( getMisAllotTm1.get(i).getDay_17().toString() ) + Integer.parseInt( prim_team.get("day17").toString() );
				nDay16 = Integer.parseInt( getMisAllotTm1.get(i).getDay_16().toString() ) + Integer.parseInt( prim_team.get("day16").toString() );
				nDay15 = Integer.parseInt( getMisAllotTm1.get(i).getDay_15().toString() ) + Integer.parseInt( prim_team.get("day15").toString() );
				nDay14 = Integer.parseInt( getMisAllotTm1.get(i).getDay_14().toString() ) + Integer.parseInt( prim_team.get("day14").toString() );
				nDay13 = Integer.parseInt( getMisAllotTm1.get(i).getDay_13().toString() ) + Integer.parseInt( prim_team.get("day13").toString() );
				nDay12 = Integer.parseInt( getMisAllotTm1.get(i).getDay_12().toString() ) + Integer.parseInt( prim_team.get("day12").toString() );
				nDay11 = Integer.parseInt( getMisAllotTm1.get(i).getDay_11().toString() ) + Integer.parseInt( prim_team.get("day11").toString() );
				nDay10 = Integer.parseInt( getMisAllotTm1.get(i).getDay_10().toString() ) + Integer.parseInt( prim_team.get("day10").toString() );
				nDay09 = Integer.parseInt( getMisAllotTm1.get(i).getDay_09().toString() ) + Integer.parseInt( prim_team.get("day09").toString() );
				nDay08 = Integer.parseInt( getMisAllotTm1.get(i).getDay_08().toString() ) + Integer.parseInt( prim_team.get("day08").toString() );
				nDay07 = Integer.parseInt( getMisAllotTm1.get(i).getDay_07().toString() ) + Integer.parseInt( prim_team.get("day07").toString() );
				nDay06 = Integer.parseInt( getMisAllotTm1.get(i).getDay_06().toString() ) + Integer.parseInt( prim_team.get("day06").toString() );
				nDay05 = Integer.parseInt( getMisAllotTm1.get(i).getDay_05().toString() ) + Integer.parseInt( prim_team.get("day05").toString() );
				nDay04 = Integer.parseInt( getMisAllotTm1.get(i).getDay_04().toString() ) + Integer.parseInt( prim_team.get("day04").toString() );
				nDay03 = Integer.parseInt( getMisAllotTm1.get(i).getDay_03().toString() ) + Integer.parseInt( prim_team.get("day03").toString() );
				nDay02 = Integer.parseInt( getMisAllotTm1.get(i).getDay_02().toString() ) + Integer.parseInt( prim_team.get("day02").toString() );
				nDay01 = Integer.parseInt( getMisAllotTm1.get(i).getDay_01().toString() ) + Integer.parseInt( prim_team.get("day01").toString() );
				nDay00 = Integer.parseInt( getMisAllotTm1.get(i).getDay_00().toString() ) + Integer.parseInt( prim_team.get("day00").toString() );
				
				getMisAllotTm1.get(i).setReg_30(String.valueOf(nReg30));
				getMisAllotTm1.get(i).setReg_29(String.valueOf(nReg29));
				getMisAllotTm1.get(i).setReg_28(String.valueOf(nReg28));
				getMisAllotTm1.get(i).setReg_27(String.valueOf(nReg27));
				getMisAllotTm1.get(i).setReg_26(String.valueOf(nReg26));
				getMisAllotTm1.get(i).setReg_25(String.valueOf(nReg25));
				getMisAllotTm1.get(i).setReg_24(String.valueOf(nReg24));
				getMisAllotTm1.get(i).setReg_23(String.valueOf(nReg23));
				getMisAllotTm1.get(i).setReg_22(String.valueOf(nReg22));
				getMisAllotTm1.get(i).setReg_21(String.valueOf(nReg21));
				getMisAllotTm1.get(i).setReg_20(String.valueOf(nReg20));
				getMisAllotTm1.get(i).setReg_19(String.valueOf(nReg19));
				getMisAllotTm1.get(i).setReg_18(String.valueOf(nReg18));
				getMisAllotTm1.get(i).setReg_17(String.valueOf(nReg17));
				getMisAllotTm1.get(i).setReg_16(String.valueOf(nReg16));
				getMisAllotTm1.get(i).setReg_15(String.valueOf(nReg15));
				getMisAllotTm1.get(i).setReg_14(String.valueOf(nReg14));
				getMisAllotTm1.get(i).setReg_13(String.valueOf(nReg13));
				getMisAllotTm1.get(i).setReg_12(String.valueOf(nReg12));
				getMisAllotTm1.get(i).setReg_11(String.valueOf(nReg11));
				getMisAllotTm1.get(i).setReg_10(String.valueOf(nReg10));
				getMisAllotTm1.get(i).setReg_09(String.valueOf(nReg09));
				getMisAllotTm1.get(i).setReg_08(String.valueOf(nReg08));
				getMisAllotTm1.get(i).setReg_07(String.valueOf(nReg07));
				getMisAllotTm1.get(i).setReg_06(String.valueOf(nReg06));
				getMisAllotTm1.get(i).setReg_05(String.valueOf(nReg05));
				getMisAllotTm1.get(i).setReg_04(String.valueOf(nReg04));
				getMisAllotTm1.get(i).setReg_03(String.valueOf(nReg03));
				getMisAllotTm1.get(i).setReg_02(String.valueOf(nReg02));
				getMisAllotTm1.get(i).setReg_01(String.valueOf(nReg01));
				getMisAllotTm1.get(i).setReg_00(String.valueOf(nReg00));
				
				getMisAllotTm1.get(i).setDay_30(String.valueOf(nDay30));
				getMisAllotTm1.get(i).setDay_29(String.valueOf(nDay29));
				getMisAllotTm1.get(i).setDay_28(String.valueOf(nDay28));
				getMisAllotTm1.get(i).setDay_27(String.valueOf(nDay27));
				getMisAllotTm1.get(i).setDay_26(String.valueOf(nDay26));
				getMisAllotTm1.get(i).setDay_25(String.valueOf(nDay25));
				getMisAllotTm1.get(i).setDay_24(String.valueOf(nDay24));
				getMisAllotTm1.get(i).setDay_23(String.valueOf(nDay23));
				getMisAllotTm1.get(i).setDay_22(String.valueOf(nDay22));
				getMisAllotTm1.get(i).setDay_21(String.valueOf(nDay21));
				getMisAllotTm1.get(i).setDay_20(String.valueOf(nDay20));
				getMisAllotTm1.get(i).setDay_19(String.valueOf(nDay19));
				getMisAllotTm1.get(i).setDay_18(String.valueOf(nDay18));
				getMisAllotTm1.get(i).setDay_17(String.valueOf(nDay17));
				getMisAllotTm1.get(i).setDay_16(String.valueOf(nDay16));
				getMisAllotTm1.get(i).setDay_15(String.valueOf(nDay15));
				getMisAllotTm1.get(i).setDay_14(String.valueOf(nDay14));
				getMisAllotTm1.get(i).setDay_13(String.valueOf(nDay13));
				getMisAllotTm1.get(i).setDay_12(String.valueOf(nDay12));
				getMisAllotTm1.get(i).setDay_11(String.valueOf(nDay11));
				getMisAllotTm1.get(i).setDay_10(String.valueOf(nDay10));
				getMisAllotTm1.get(i).setDay_09(String.valueOf(nDay09));
				getMisAllotTm1.get(i).setDay_08(String.valueOf(nDay08));
				getMisAllotTm1.get(i).setDay_07(String.valueOf(nDay07));
				getMisAllotTm1.get(i).setDay_06(String.valueOf(nDay06));
				getMisAllotTm1.get(i).setDay_05(String.valueOf(nDay05));
				getMisAllotTm1.get(i).setDay_04(String.valueOf(nDay04));
				getMisAllotTm1.get(i).setDay_03(String.valueOf(nDay03));
				getMisAllotTm1.get(i).setDay_02(String.valueOf(nDay02));
				getMisAllotTm1.get(i).setDay_01(String.valueOf(nDay01));
				getMisAllotTm1.get(i).setDay_00(String.valueOf(nDay00));				
				
				//농작물 팀별 년간 수임, 종결				
				nRegY = Integer.parseInt( getMisAllotTm1.get(i).getReg_y().toString() ) + Integer.parseInt( prim_team.get("regY").toString() );
				getMisAllotTm1.get(i).setReg_y(String.valueOf(nRegY));
				nClsY = Integer.parseInt( getMisAllotTm1.get(i).getCls_y().toString()) + Integer.parseInt( prim_team.get("clsY").toString() );
				getMisAllotTm1.get(i).setCls_y(String.valueOf(nClsY));				
				
				//농작물 팀별 월간 종결
				nClsM = Integer.parseInt( getMisAllotTm1.get(i).getCls_m().toString() ) + Integer.parseInt( prim_team.get("clsM").toString() );				
				getMisAllotTm1.get(i).setCls_m(String.valueOf(nClsM));
				
				//농작물 팀별 미결
				nRegMi = Integer.parseInt( getMisAllotTm1.get(i).getReg_mi().toString() ) + Integer.parseInt( prim_team.get("regMi").toString() );
				getMisAllotTm1.get(i).setReg_mi(String.valueOf(nRegMi));				
			}
		}		
		
		List<MisRegTmVO> getMisAllotTm4 = sqlSession.selectList("MisAllotTmMapper.newGetMisAllotTm4", nowVO);
		
		
		/** 팀 센터 선택을 위한 부문 명부로드 2019.07.08 by top3009*/
		SysAdmCodeDicVO codeVO = new SysAdmCodeDicVO();
		codeVO.setTbl_nm("top_tm_bsc");
		codeVO.setCol_nm("team_center");
		List<SysAdmCodeDicVO> teamCenterList = service.codeList(codeVO);
		
		long sum_reg_center_00 = 0;
		long sum_reg_center_01 = 0;
		long sum_reg_center_02 = 0;
		long sum_reg_center_03 = 0;
		long sum_reg_center_04 = 0;
		long sum_reg_center_05 = 0;
		long sum_reg_center_06 = 0;
		long sum_reg_center_07 = 0;
		long sum_reg_center_08 = 0;
		long sum_reg_center_09 = 0;
		long sum_reg_center_10 = 0;
		long sum_reg_center_11 = 0;
		long sum_reg_center_12 = 0;
		long sum_reg_center_13 = 0;
		long sum_reg_center_14 = 0;
		long sum_reg_center_15 = 0;
		long sum_reg_center_16 = 0;
		long sum_reg_center_17 = 0;
		long sum_reg_center_18 = 0;
		long sum_reg_center_19 = 0;
		long sum_reg_center_20 = 0;
		long sum_reg_center_21 = 0;
		long sum_reg_center_22 = 0;
		long sum_reg_center_23 = 0;
		long sum_reg_center_24 = 0;
		long sum_reg_center_25 = 0;
		long sum_reg_center_26 = 0;
		long sum_reg_center_27 = 0;
		long sum_reg_center_28 = 0;
		long sum_reg_center_29 = 0;
		long sum_reg_center_30 = 0;
		
		long sum_reg_center_wc_00 = 0;
		long sum_reg_center_wc_01 = 0;
		long sum_reg_center_wc_02 = 0;
		long sum_reg_center_wc_03 = 0;
		long sum_reg_center_wc_04 = 0;
		long sum_reg_center_wc_05 = 0;
		long sum_reg_center_wc_06 = 0;
		long sum_reg_center_wc_07 = 0;
		long sum_reg_center_wc_08 = 0;
		long sum_reg_center_wc_09 = 0;
		long sum_reg_center_wc_10 = 0;
		long sum_reg_center_wc_11 = 0;
		long sum_reg_center_wc_12 = 0;
		long sum_reg_center_wc_13 = 0;
		long sum_reg_center_wc_14 = 0;
		long sum_reg_center_wc_15 = 0;
		long sum_reg_center_wc_16 = 0;
		long sum_reg_center_wc_17 = 0;
		long sum_reg_center_wc_18 = 0;
		long sum_reg_center_wc_19 = 0;
		long sum_reg_center_wc_20 = 0;
		long sum_reg_center_wc_21 = 0;
		long sum_reg_center_wc_22 = 0;
		long sum_reg_center_wc_23 = 0;
		long sum_reg_center_wc_24 = 0;
		long sum_reg_center_wc_25 = 0;
		long sum_reg_center_wc_26 = 0;
		long sum_reg_center_wc_27 = 0;
		long sum_reg_center_wc_28 = 0;
		long sum_reg_center_wc_29 = 0;
		long sum_reg_center_wc_30 = 0;
		
		long sum_day_center_00 = 0;
		long sum_day_center_01 = 0;
		long sum_day_center_02 = 0;
		long sum_day_center_03 = 0;
		long sum_day_center_04 = 0;
		long sum_day_center_05 = 0;
		long sum_day_center_06 = 0;
		long sum_day_center_07 = 0;
		long sum_day_center_08 = 0;
		long sum_day_center_09 = 0;
		long sum_day_center_10 = 0;
		long sum_day_center_11 = 0;
		long sum_day_center_12 = 0;
		long sum_day_center_13 = 0;
		long sum_day_center_14 = 0;
		long sum_day_center_15 = 0;
		long sum_day_center_16 = 0;
		long sum_day_center_17 = 0;
		long sum_day_center_18 = 0;
		long sum_day_center_19 = 0;
		long sum_day_center_20 = 0;
		long sum_day_center_21 = 0;
		long sum_day_center_22 = 0;
		long sum_day_center_23 = 0;
		long sum_day_center_24 = 0;
		long sum_day_center_25 = 0;
		long sum_day_center_26 = 0;
		long sum_day_center_27 = 0;
		long sum_day_center_28 = 0;
		long sum_day_center_29 = 0;
		long sum_day_center_30 = 0;
		
		long sum_day_center_wc_00 = 0;
		long sum_day_center_wc_01 = 0;
		long sum_day_center_wc_02 = 0;
		long sum_day_center_wc_03 = 0;
		long sum_day_center_wc_04 = 0;
		long sum_day_center_wc_05 = 0;
		long sum_day_center_wc_06 = 0;
		long sum_day_center_wc_07 = 0;
		long sum_day_center_wc_08 = 0;
		long sum_day_center_wc_09 = 0;
		long sum_day_center_wc_10 = 0;
		long sum_day_center_wc_11 = 0;
		long sum_day_center_wc_12 = 0;
		long sum_day_center_wc_13 = 0;
		long sum_day_center_wc_14 = 0;
		long sum_day_center_wc_15 = 0;
		long sum_day_center_wc_16 = 0;
		long sum_day_center_wc_17 = 0;
		long sum_day_center_wc_18 = 0;
		long sum_day_center_wc_19 = 0;
		long sum_day_center_wc_20 = 0;
		long sum_day_center_wc_21 = 0;
		long sum_day_center_wc_22 = 0;
		long sum_day_center_wc_23 = 0;
		long sum_day_center_wc_24 = 0;
		long sum_day_center_wc_25 = 0;
		long sum_day_center_wc_26 = 0;
		long sum_day_center_wc_27 = 0;
		long sum_day_center_wc_28 = 0;
		long sum_day_center_wc_29 = 0;
		long sum_day_center_wc_30 = 0;

		long sum_reg_center_y = 0;
		long sum_reg_center_mi = 0;		
		long sum_cls_center_y = 0;	
		long sum_cls_center_m = 0;
		
		long sum_reg_center_wc_y = 0;
		long sum_reg_center_wc_mi = 0;		
		long sum_cls_center_wc_y = 0;	
		long sum_cls_center_wc_m = 0;
		
		String sCenter = ""; 
		String sCenter_val = "";
		String sCenter_flag = "";		
		
		int center_member_cnt = 0;
		
		List<MisRegTmVO> TeamCenterListVO = new ArrayList<MisRegTmVO>();			//부문별 목록에 뿌려줄 리스트 생성
		
		//센터별 합산계산 시작
		for(int i=0; i < teamCenterList.size(); i++) {
			
			MisRegTmVO centerBean = new MisRegTmVO();			//리스트에 넣어줄 객체 생성
			
			sCenter = teamCenterList.get(i).getCol_cd();
			sCenter_val = teamCenterList.get(i).getCol_val();			
			centerBean.setTeam_center(sCenter);
			centerBean.setTeam_center_val(sCenter_val);
			
			//팀목록에서 가져온 카운트를 체크해서 넣어준다.
			for(int k=0; k < getMisAllotTm1.size(); k++) {				
				sCenter_flag = getMisAllotTm1.get(k).getTeam_center();
				if(sCenter.equals(sCenter_flag) && !"0".equals(sCenter)){				//team_center 가 0이아니고, 같은경우만 합산한다.
					
					center_member_cnt += getMisAllotTm1.get(k).getMember_cnt();
					
					sum_reg_center_00 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_00());
					sum_reg_center_01 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_01());
					sum_reg_center_02 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_02());
					sum_reg_center_03 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_03());
					sum_reg_center_04 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_04());
					sum_reg_center_05 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_05());
					sum_reg_center_06 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_06());
					sum_reg_center_07 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_07());
					sum_reg_center_08 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_08());
					sum_reg_center_09 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_09());
					sum_reg_center_10 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_10());
					sum_reg_center_11 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_11());
					sum_reg_center_12 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_12());
					sum_reg_center_13 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_13());
					sum_reg_center_14 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_14());
					sum_reg_center_15 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_15());
					sum_reg_center_16 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_16());
					sum_reg_center_17 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_17());
					sum_reg_center_18 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_18());
					sum_reg_center_19 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_19());
					sum_reg_center_20 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_20());
					sum_reg_center_21 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_21());
					sum_reg_center_22 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_22());
					sum_reg_center_23 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_23());
					sum_reg_center_24 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_24());
					sum_reg_center_25 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_25());
					sum_reg_center_26 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_26());
					sum_reg_center_27 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_27());
					sum_reg_center_28 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_28());
					sum_reg_center_29 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_29());
					sum_reg_center_30 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_30());
					
					sum_reg_center_wc_00 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_00());
					sum_reg_center_wc_01 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_01());
					sum_reg_center_wc_02 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_02());
					sum_reg_center_wc_03 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_03());
					sum_reg_center_wc_04 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_04());
					sum_reg_center_wc_05 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_05());
					sum_reg_center_wc_06 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_06());
					sum_reg_center_wc_07 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_07());
					sum_reg_center_wc_08 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_08());
					sum_reg_center_wc_09 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_09());
					sum_reg_center_wc_10 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_10());
					sum_reg_center_wc_11 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_11());
					sum_reg_center_wc_12 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_12());
					sum_reg_center_wc_13 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_13());
					sum_reg_center_wc_14 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_14());
					sum_reg_center_wc_15 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_15());
					sum_reg_center_wc_16 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_16());
					sum_reg_center_wc_17 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_17());
					sum_reg_center_wc_18 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_18());
					sum_reg_center_wc_19 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_19());
					sum_reg_center_wc_20 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_20());
					sum_reg_center_wc_21 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_21());
					sum_reg_center_wc_22 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_22());
					sum_reg_center_wc_23 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_23());
					sum_reg_center_wc_24 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_24());
					sum_reg_center_wc_25 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_25());
					sum_reg_center_wc_26 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_26());
					sum_reg_center_wc_27 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_27());
					sum_reg_center_wc_28 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_28());
					sum_reg_center_wc_29 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_29());
					sum_reg_center_wc_30 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_30());
					
					sum_day_center_00 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_00());
					sum_day_center_01 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_01());
					sum_day_center_02 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_02());
					sum_day_center_03 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_03());
					sum_day_center_04 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_04());
					sum_day_center_05 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_05());
					sum_day_center_06 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_06());
					sum_day_center_07 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_07());
					sum_day_center_08 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_08());
					sum_day_center_09 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_09());
					sum_day_center_10 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_10());
					sum_day_center_11 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_11());
					sum_day_center_12 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_12());
					sum_day_center_13 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_13());
					sum_day_center_14 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_14());
					sum_day_center_15 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_15());
					sum_day_center_16 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_16());
					sum_day_center_17 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_17());
					sum_day_center_18 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_18());
					sum_day_center_19 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_19());
					sum_day_center_20 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_20());
					sum_day_center_21 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_21());
					sum_day_center_22 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_22());
					sum_day_center_23 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_23());
					sum_day_center_24 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_24());
					sum_day_center_25 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_25());
					sum_day_center_26 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_26());
					sum_day_center_27 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_27());
					sum_day_center_28 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_28());
					sum_day_center_29 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_29());
					sum_day_center_30 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_30());
					
					sum_day_center_wc_00 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_00());
					sum_day_center_wc_01 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_01());
					sum_day_center_wc_02 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_02());
					sum_day_center_wc_03 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_03());
					sum_day_center_wc_04 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_04());
					sum_day_center_wc_05 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_05());
					sum_day_center_wc_06 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_06());
					sum_day_center_wc_07 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_07());
					sum_day_center_wc_08 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_08());
					sum_day_center_wc_09 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_09());
					sum_day_center_wc_10 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_10());
					sum_day_center_wc_11 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_11());
					sum_day_center_wc_12 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_12());
					sum_day_center_wc_13 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_13());
					sum_day_center_wc_14 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_14());
					sum_day_center_wc_15 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_15());
					sum_day_center_wc_16 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_16());
					sum_day_center_wc_17 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_17());
					sum_day_center_wc_18 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_18());
					sum_day_center_wc_19 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_19());
					sum_day_center_wc_20 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_20());
					sum_day_center_wc_21 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_21());
					sum_day_center_wc_22 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_22());
					sum_day_center_wc_23 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_23());
					sum_day_center_wc_24 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_24());
					sum_day_center_wc_25 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_25());
					sum_day_center_wc_26 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_26());
					sum_day_center_wc_27 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_27());
					sum_day_center_wc_28 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_28());
					sum_day_center_wc_29 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_29());
					sum_day_center_wc_30 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_30());
					
					sum_reg_center_y += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_y());
					sum_reg_center_mi += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_mi());
					
					sum_cls_center_y += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getCls_y());
					sum_cls_center_m += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getCls_m());
					
					sum_reg_center_wc_y += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_y());
					sum_reg_center_wc_mi += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_mi());
					
					sum_cls_center_wc_y += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getCls_wc_y());
					sum_cls_center_wc_m += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getCls_wc_m());
										
				}
			}
			
			centerBean.setMember_cnt(center_member_cnt);
			centerBean.setReg_00(Long.toString(sum_reg_center_00));
			centerBean.setReg_01(Long.toString(sum_reg_center_01));
			centerBean.setReg_02(Long.toString(sum_reg_center_02));
			centerBean.setReg_03(Long.toString(sum_reg_center_03));
			centerBean.setReg_04(Long.toString(sum_reg_center_04));
			centerBean.setReg_05(Long.toString(sum_reg_center_05));
			centerBean.setReg_06(Long.toString(sum_reg_center_06));
			centerBean.setReg_07(Long.toString(sum_reg_center_07));
			centerBean.setReg_08(Long.toString(sum_reg_center_08));
			centerBean.setReg_09(Long.toString(sum_reg_center_09));
			centerBean.setReg_10(Long.toString(sum_reg_center_10));
			centerBean.setReg_11(Long.toString(sum_reg_center_11));
			centerBean.setReg_12(Long.toString(sum_reg_center_12));
			centerBean.setReg_13(Long.toString(sum_reg_center_13));
			centerBean.setReg_14(Long.toString(sum_reg_center_14));
			centerBean.setReg_15(Long.toString(sum_reg_center_15));
			centerBean.setReg_16(Long.toString(sum_reg_center_16));
			centerBean.setReg_17(Long.toString(sum_reg_center_17));
			centerBean.setReg_18(Long.toString(sum_reg_center_18));
			centerBean.setReg_19(Long.toString(sum_reg_center_19));
			centerBean.setReg_20(Long.toString(sum_reg_center_20));
			centerBean.setReg_21(Long.toString(sum_reg_center_21));
			centerBean.setReg_22(Long.toString(sum_reg_center_22));
			centerBean.setReg_23(Long.toString(sum_reg_center_23));
			centerBean.setReg_24(Long.toString(sum_reg_center_24));
			centerBean.setReg_25(Long.toString(sum_reg_center_25));
			centerBean.setReg_26(Long.toString(sum_reg_center_26));
			centerBean.setReg_27(Long.toString(sum_reg_center_27));
			centerBean.setReg_28(Long.toString(sum_reg_center_28));
			centerBean.setReg_29(Long.toString(sum_reg_center_29));
			centerBean.setReg_30(Long.toString(sum_reg_center_30));
			
			centerBean.setReg_wc_00(Long.toString(sum_reg_center_wc_00));
			centerBean.setReg_wc_01(Long.toString(sum_reg_center_wc_01));
			centerBean.setReg_wc_02(Long.toString(sum_reg_center_wc_02));
			centerBean.setReg_wc_03(Long.toString(sum_reg_center_wc_03));
			centerBean.setReg_wc_04(Long.toString(sum_reg_center_wc_04));
			centerBean.setReg_wc_05(Long.toString(sum_reg_center_wc_05));
			centerBean.setReg_wc_06(Long.toString(sum_reg_center_wc_06));
			centerBean.setReg_wc_07(Long.toString(sum_reg_center_wc_07));
			centerBean.setReg_wc_08(Long.toString(sum_reg_center_wc_08));
			centerBean.setReg_wc_09(Long.toString(sum_reg_center_wc_09));
			centerBean.setReg_wc_10(Long.toString(sum_reg_center_wc_10));
			centerBean.setReg_wc_11(Long.toString(sum_reg_center_wc_11));
			centerBean.setReg_wc_12(Long.toString(sum_reg_center_wc_12));
			centerBean.setReg_wc_13(Long.toString(sum_reg_center_wc_13));
			centerBean.setReg_wc_14(Long.toString(sum_reg_center_wc_14));
			centerBean.setReg_wc_15(Long.toString(sum_reg_center_wc_15));
			centerBean.setReg_wc_16(Long.toString(sum_reg_center_wc_16));
			centerBean.setReg_wc_17(Long.toString(sum_reg_center_wc_17));
			centerBean.setReg_wc_18(Long.toString(sum_reg_center_wc_18));
			centerBean.setReg_wc_19(Long.toString(sum_reg_center_wc_19));
			centerBean.setReg_wc_20(Long.toString(sum_reg_center_wc_20));
			centerBean.setReg_wc_21(Long.toString(sum_reg_center_wc_21));
			centerBean.setReg_wc_22(Long.toString(sum_reg_center_wc_22));
			centerBean.setReg_wc_23(Long.toString(sum_reg_center_wc_23));
			centerBean.setReg_wc_24(Long.toString(sum_reg_center_wc_24));
			centerBean.setReg_wc_25(Long.toString(sum_reg_center_wc_25));
			centerBean.setReg_wc_26(Long.toString(sum_reg_center_wc_26));
			centerBean.setReg_wc_27(Long.toString(sum_reg_center_wc_27));
			centerBean.setReg_wc_28(Long.toString(sum_reg_center_wc_28));
			centerBean.setReg_wc_29(Long.toString(sum_reg_center_wc_29));
			centerBean.setReg_wc_30(Long.toString(sum_reg_center_wc_30));
			
			centerBean.setDay_00(Long.toString(sum_day_center_00));
			centerBean.setDay_01(Long.toString(sum_day_center_01));
			centerBean.setDay_02(Long.toString(sum_day_center_02));
			centerBean.setDay_03(Long.toString(sum_day_center_03));
			centerBean.setDay_04(Long.toString(sum_day_center_04));
			centerBean.setDay_05(Long.toString(sum_day_center_05));
			centerBean.setDay_06(Long.toString(sum_day_center_06));
			centerBean.setDay_07(Long.toString(sum_day_center_07));
			centerBean.setDay_08(Long.toString(sum_day_center_08));
			centerBean.setDay_09(Long.toString(sum_day_center_09));
			centerBean.setDay_10(Long.toString(sum_day_center_10));
			centerBean.setDay_11(Long.toString(sum_day_center_11));
			centerBean.setDay_12(Long.toString(sum_day_center_12));
			centerBean.setDay_13(Long.toString(sum_day_center_13));
			centerBean.setDay_14(Long.toString(sum_day_center_14));
			centerBean.setDay_15(Long.toString(sum_day_center_15));
			centerBean.setDay_16(Long.toString(sum_day_center_16));
			centerBean.setDay_17(Long.toString(sum_day_center_17));
			centerBean.setDay_18(Long.toString(sum_day_center_18));
			centerBean.setDay_19(Long.toString(sum_day_center_19));
			centerBean.setDay_20(Long.toString(sum_day_center_20));
			centerBean.setDay_21(Long.toString(sum_day_center_21));
			centerBean.setDay_22(Long.toString(sum_day_center_22));
			centerBean.setDay_23(Long.toString(sum_day_center_23));
			centerBean.setDay_24(Long.toString(sum_day_center_24));
			centerBean.setDay_25(Long.toString(sum_day_center_25));
			centerBean.setDay_26(Long.toString(sum_day_center_26));
			centerBean.setDay_27(Long.toString(sum_day_center_27));
			centerBean.setDay_28(Long.toString(sum_day_center_28));
			centerBean.setDay_29(Long.toString(sum_day_center_29));
			centerBean.setDay_30(Long.toString(sum_day_center_30));
			
			centerBean.setDay_wc_00(Long.toString(sum_day_center_wc_00));
			centerBean.setDay_wc_01(Long.toString(sum_day_center_wc_01));
			centerBean.setDay_wc_02(Long.toString(sum_day_center_wc_02));
			centerBean.setDay_wc_03(Long.toString(sum_day_center_wc_03));
			centerBean.setDay_wc_04(Long.toString(sum_day_center_wc_04));
			centerBean.setDay_wc_05(Long.toString(sum_day_center_wc_05));
			centerBean.setDay_wc_06(Long.toString(sum_day_center_wc_06));
			centerBean.setDay_wc_07(Long.toString(sum_day_center_wc_07));
			centerBean.setDay_wc_08(Long.toString(sum_day_center_wc_08));
			centerBean.setDay_wc_09(Long.toString(sum_day_center_wc_09));
			centerBean.setDay_wc_10(Long.toString(sum_day_center_wc_10));
			centerBean.setDay_wc_11(Long.toString(sum_day_center_wc_11));
			centerBean.setDay_wc_12(Long.toString(sum_day_center_wc_12));
			centerBean.setDay_wc_13(Long.toString(sum_day_center_wc_13));
			centerBean.setDay_wc_14(Long.toString(sum_day_center_wc_14));
			centerBean.setDay_wc_15(Long.toString(sum_day_center_wc_15));
			centerBean.setDay_wc_16(Long.toString(sum_day_center_wc_16));
			centerBean.setDay_wc_17(Long.toString(sum_day_center_wc_17));
			centerBean.setDay_wc_18(Long.toString(sum_day_center_wc_18));
			centerBean.setDay_wc_19(Long.toString(sum_day_center_wc_19));
			centerBean.setDay_wc_20(Long.toString(sum_day_center_wc_20));
			centerBean.setDay_wc_21(Long.toString(sum_day_center_wc_21));
			centerBean.setDay_wc_22(Long.toString(sum_day_center_wc_22));
			centerBean.setDay_wc_23(Long.toString(sum_day_center_wc_23));
			centerBean.setDay_wc_24(Long.toString(sum_day_center_wc_24));
			centerBean.setDay_wc_25(Long.toString(sum_day_center_wc_25));
			centerBean.setDay_wc_26(Long.toString(sum_day_center_wc_26));
			centerBean.setDay_wc_27(Long.toString(sum_day_center_wc_27));
			centerBean.setDay_wc_28(Long.toString(sum_day_center_wc_28));
			centerBean.setDay_wc_29(Long.toString(sum_day_center_wc_29));
			centerBean.setDay_wc_30(Long.toString(sum_day_center_wc_30));
			
			centerBean.setReg_y(Long.toString(sum_reg_center_y));
			centerBean.setReg_mi(Long.toString(sum_reg_center_mi));
			centerBean.setCls_y(Long.toString(sum_cls_center_y));
			centerBean.setCls_m(Long.toString(sum_cls_center_m));
			
			centerBean.setReg_wc_y(Long.toString(sum_reg_center_wc_y));
			centerBean.setReg_wc_mi(Long.toString(sum_reg_center_wc_mi));
			centerBean.setCls_wc_y(Long.toString(sum_cls_center_wc_y));
			centerBean.setCls_wc_m(Long.toString(sum_cls_center_wc_m));
			
			//서면심사 부문 표시 여부 확인
			long sum_center_all = sum_reg_center_wc_00 + sum_reg_center_wc_01 + sum_reg_center_wc_02 + sum_reg_center_wc_03 + sum_reg_center_wc_04
					+ sum_reg_center_wc_05 + sum_reg_center_wc_06 + sum_reg_center_wc_07 + sum_reg_center_wc_08 + sum_reg_center_wc_09 + sum_reg_center_wc_10
					+ sum_reg_center_wc_11 + sum_reg_center_wc_12 + sum_reg_center_wc_13 + sum_reg_center_wc_14 + sum_reg_center_wc_15 + sum_reg_center_wc_16
					+ sum_reg_center_wc_17 + sum_reg_center_wc_18 + sum_reg_center_wc_19 + sum_reg_center_wc_20 + sum_reg_center_wc_21 + sum_reg_center_wc_22
					+ sum_reg_center_wc_23 + sum_reg_center_wc_24 + sum_reg_center_wc_25 + sum_reg_center_wc_26 + sum_reg_center_wc_27 + sum_reg_center_wc_28
					+ sum_reg_center_wc_29 + sum_reg_center_wc_30 + sum_day_center_wc_00 + sum_day_center_wc_01 + sum_day_center_wc_02 + sum_day_center_wc_03
					+ sum_day_center_wc_04 + sum_day_center_wc_05 + sum_day_center_wc_06 + sum_day_center_wc_07 + sum_day_center_wc_08 + sum_day_center_wc_09
					+ sum_day_center_wc_10 + sum_day_center_wc_11 + sum_day_center_wc_12 + sum_day_center_wc_13 + sum_day_center_wc_14 + sum_day_center_wc_15
					+ sum_day_center_wc_16 + sum_day_center_wc_17 + sum_day_center_wc_18 + sum_day_center_wc_19 + sum_day_center_wc_20 + sum_day_center_wc_21
					+ sum_day_center_wc_22 + sum_day_center_wc_23 + sum_day_center_wc_24 + sum_day_center_wc_25 + sum_day_center_wc_26 + sum_day_center_wc_27
					+ sum_day_center_wc_28 + sum_day_center_wc_29 + sum_day_center_wc_30;
		
			if( sum_center_all == 0) {
				centerBean.setWc_center_flag("0");
			}else{
				centerBean.setWc_center_flag("1");
			}
			
			TeamCenterListVO.add(i, centerBean);
			
			//변수초기화
			center_member_cnt = 0;
			sum_reg_center_00 = 0;
			sum_reg_center_01 = 0;
			sum_reg_center_02 = 0;
			sum_reg_center_03 = 0;
			sum_reg_center_04 = 0;
			sum_reg_center_05 = 0;
			sum_reg_center_06 = 0;
			sum_reg_center_07 = 0;
			sum_reg_center_08 = 0;
			sum_reg_center_09 = 0;
			sum_reg_center_10 = 0;
			sum_reg_center_11 = 0;
			sum_reg_center_12 = 0;
			sum_reg_center_13 = 0;
			sum_reg_center_14 = 0;
			sum_reg_center_15 = 0;
			sum_reg_center_16 = 0;
			sum_reg_center_17 = 0;
			sum_reg_center_18 = 0;
			sum_reg_center_19 = 0;
			sum_reg_center_20 = 0;
			sum_reg_center_21 = 0;
			sum_reg_center_22 = 0;
			sum_reg_center_23 = 0;
			sum_reg_center_24 = 0;
			sum_reg_center_25 = 0;
			sum_reg_center_26 = 0;
			sum_reg_center_27 = 0;
			sum_reg_center_28 = 0;
			sum_reg_center_29 = 0;
			sum_reg_center_30 = 0;
			
			sum_reg_center_wc_00 = 0;
			sum_reg_center_wc_01 = 0;
			sum_reg_center_wc_02 = 0;
			sum_reg_center_wc_03 = 0;
			sum_reg_center_wc_04 = 0;
			sum_reg_center_wc_05 = 0;
			sum_reg_center_wc_06 = 0;
			sum_reg_center_wc_07 = 0;
			sum_reg_center_wc_08 = 0;
			sum_reg_center_wc_09 = 0;
			sum_reg_center_wc_10 = 0;
			sum_reg_center_wc_11 = 0;
			sum_reg_center_wc_12 = 0;
			sum_reg_center_wc_13 = 0;
			sum_reg_center_wc_14 = 0;
			sum_reg_center_wc_15 = 0;
			sum_reg_center_wc_16 = 0;
			sum_reg_center_wc_17 = 0;
			sum_reg_center_wc_18 = 0;
			sum_reg_center_wc_19 = 0;
			sum_reg_center_wc_20 = 0;
			sum_reg_center_wc_21 = 0;
			sum_reg_center_wc_22 = 0;
			sum_reg_center_wc_23 = 0;
			sum_reg_center_wc_24 = 0;
			sum_reg_center_wc_25 = 0;
			sum_reg_center_wc_26 = 0;
			sum_reg_center_wc_27 = 0;
			sum_reg_center_wc_28 = 0;
			sum_reg_center_wc_29 = 0;
			sum_reg_center_wc_30 = 0;
			
			sum_day_center_00 = 0;
			sum_day_center_01 = 0;
			sum_day_center_02 = 0;
			sum_day_center_03 = 0;
			sum_day_center_04 = 0;
			sum_day_center_05 = 0;
			sum_day_center_06 = 0;
			sum_day_center_07 = 0;
			sum_day_center_08 = 0;
			sum_day_center_09 = 0;
			sum_day_center_10 = 0;
			sum_day_center_11 = 0;
			sum_day_center_12 = 0;
			sum_day_center_13 = 0;
			sum_day_center_14 = 0;
			sum_day_center_15 = 0;
			sum_day_center_16 = 0;
			sum_day_center_17 = 0;
			sum_day_center_18 = 0;
			sum_day_center_19 = 0;
			sum_day_center_20 = 0;
			sum_day_center_21 = 0;
			sum_day_center_22 = 0;
			sum_day_center_23 = 0;
			sum_day_center_24 = 0;
			sum_day_center_25 = 0;
			sum_day_center_26 = 0;
			sum_day_center_27 = 0;
			sum_day_center_28 = 0;
			sum_day_center_29 = 0;
			sum_day_center_30 = 0;
			
			sum_day_center_wc_00 = 0;
			sum_day_center_wc_01 = 0;
			sum_day_center_wc_02 = 0;
			sum_day_center_wc_03 = 0;
			sum_day_center_wc_04 = 0;
			sum_day_center_wc_05 = 0;
			sum_day_center_wc_06 = 0;
			sum_day_center_wc_07 = 0;
			sum_day_center_wc_08 = 0;
			sum_day_center_wc_09 = 0;
			sum_day_center_wc_10 = 0;
			sum_day_center_wc_11 = 0;
			sum_day_center_wc_12 = 0;
			sum_day_center_wc_13 = 0;
			sum_day_center_wc_14 = 0;
			sum_day_center_wc_15 = 0;
			sum_day_center_wc_16 = 0;
			sum_day_center_wc_17 = 0;
			sum_day_center_wc_18 = 0;
			sum_day_center_wc_19 = 0;
			sum_day_center_wc_20 = 0;
			sum_day_center_wc_21 = 0;
			sum_day_center_wc_22 = 0;
			sum_day_center_wc_23 = 0;
			sum_day_center_wc_24 = 0;
			sum_day_center_wc_25 = 0;
			sum_day_center_wc_26 = 0;
			sum_day_center_wc_27 = 0;
			sum_day_center_wc_28 = 0;
			sum_day_center_wc_29 = 0;
			sum_day_center_wc_30 = 0;

			sum_reg_center_y = 0;
			sum_reg_center_mi = 0;		
			sum_cls_center_y = 0;	
			sum_cls_center_m = 0;
			
			sum_reg_center_wc_y = 0;
			sum_reg_center_wc_mi = 0;		
			sum_cls_center_wc_y = 0;	
			sum_cls_center_wc_m = 0;
		}
		
		model.addAttribute("TeamCenterListVO", TeamCenterListVO);
		//센터별 추가 끝 by top3009

		//4종 센터별 추가 시작		
		List<MisRegTmVO> TeamCenter4ListVO = new ArrayList<MisRegTmVO>();			//부문별 목록에 뿌려줄 리스트 생성
		
		//부문별 합산계산 시작
		for(int i=0; i < teamCenterList.size(); i++) {
			
			MisRegTmVO center4Bean = new MisRegTmVO();			//리스트에 넣어줄 객체 생성
			
			sCenter = teamCenterList.get(i).getCol_cd();
			sCenter_val = teamCenterList.get(i).getCol_val();			
			center4Bean.setTeam_center(sCenter);
			center4Bean.setTeam_center_val(sCenter_val);
			
			//팀목록에서 가져온 카운트를 체크해서 넣어준다.
			for(int k=0; k < getMisAllotTm4.size(); k++) {				
				sCenter_flag = getMisAllotTm4.get(k).getTeam_center();
				if(sCenter.equals(sCenter_flag)){				//team_center 가 0이아니고, 같은경우만 합산한다.
					
					center_member_cnt += getMisAllotTm4.get(k).getMember_cnt();					
					sum_reg_center_00 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_00());
					sum_reg_center_01 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_01());
					sum_reg_center_02 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_02());
					sum_reg_center_03 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_03());
					sum_reg_center_04 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_04());
					sum_reg_center_05 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_05());
					sum_reg_center_06 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_06());
					sum_reg_center_07 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_07());
					sum_reg_center_08 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_08());
					sum_reg_center_09 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_09());
					sum_reg_center_10 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_10());
					sum_reg_center_11 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_11());
					sum_reg_center_12 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_12());
					sum_reg_center_13 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_13());
					sum_reg_center_14 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_14());
					sum_reg_center_15 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_15());
					sum_reg_center_16 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_16());
					sum_reg_center_17 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_17());
					sum_reg_center_18 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_18());
					sum_reg_center_19 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_19());
					sum_reg_center_20 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_20());
					sum_reg_center_21 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_21());
					sum_reg_center_22 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_22());
					sum_reg_center_23 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_23());
					sum_reg_center_24 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_24());
					sum_reg_center_25 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_25());
					sum_reg_center_26 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_26());
					sum_reg_center_27 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_27());
					sum_reg_center_28 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_28());
					sum_reg_center_29 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_29());
					sum_reg_center_30 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_30());
										
					sum_day_center_00 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_00());
					sum_day_center_01 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_01());
					sum_day_center_02 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_02());
					sum_day_center_03 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_03());
					sum_day_center_04 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_04());
					sum_day_center_05 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_05());
					sum_day_center_06 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_06());
					sum_day_center_07 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_07());
					sum_day_center_08 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_08());
					sum_day_center_09 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_09());
					sum_day_center_10 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_10());
					sum_day_center_11 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_11());
					sum_day_center_12 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_12());
					sum_day_center_13 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_13());
					sum_day_center_14 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_14());
					sum_day_center_15 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_15());
					sum_day_center_16 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_16());
					sum_day_center_17 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_17());
					sum_day_center_18 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_18());
					sum_day_center_19 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_19());
					sum_day_center_20 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_20());
					sum_day_center_21 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_21());
					sum_day_center_22 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_22());
					sum_day_center_23 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_23());
					sum_day_center_24 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_24());
					sum_day_center_25 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_25());
					sum_day_center_26 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_26());
					sum_day_center_27 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_27());
					sum_day_center_28 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_28());
					sum_day_center_29 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_29());
					sum_day_center_30 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_30());
										
					sum_reg_center_y += WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_y());
					sum_reg_center_mi += WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_mi());
					
					sum_cls_center_y += WebUtil.parseStringToLong(getMisAllotTm4.get(k).getCls_y());
					sum_cls_center_m += WebUtil.parseStringToLong(getMisAllotTm4.get(k).getCls_m());
										
				}
			}
			
			center4Bean.setMember_cnt(center_member_cnt);
			center4Bean.setReg_00(Long.toString(sum_reg_center_00));
			center4Bean.setReg_01(Long.toString(sum_reg_center_01));
			center4Bean.setReg_02(Long.toString(sum_reg_center_02));
			center4Bean.setReg_03(Long.toString(sum_reg_center_03));
			center4Bean.setReg_04(Long.toString(sum_reg_center_04));
			center4Bean.setReg_05(Long.toString(sum_reg_center_05));
			center4Bean.setReg_06(Long.toString(sum_reg_center_06));
			center4Bean.setReg_07(Long.toString(sum_reg_center_07));
			center4Bean.setReg_08(Long.toString(sum_reg_center_08));
			center4Bean.setReg_09(Long.toString(sum_reg_center_09));
			center4Bean.setReg_10(Long.toString(sum_reg_center_10));
			center4Bean.setReg_11(Long.toString(sum_reg_center_11));
			center4Bean.setReg_12(Long.toString(sum_reg_center_12));
			center4Bean.setReg_13(Long.toString(sum_reg_center_13));
			center4Bean.setReg_14(Long.toString(sum_reg_center_14));
			center4Bean.setReg_15(Long.toString(sum_reg_center_15));
			center4Bean.setReg_16(Long.toString(sum_reg_center_16));
			center4Bean.setReg_17(Long.toString(sum_reg_center_17));
			center4Bean.setReg_18(Long.toString(sum_reg_center_18));
			center4Bean.setReg_19(Long.toString(sum_reg_center_19));
			center4Bean.setReg_20(Long.toString(sum_reg_center_20));
			center4Bean.setReg_21(Long.toString(sum_reg_center_21));
			center4Bean.setReg_22(Long.toString(sum_reg_center_22));
			center4Bean.setReg_23(Long.toString(sum_reg_center_23));
			center4Bean.setReg_24(Long.toString(sum_reg_center_24));
			center4Bean.setReg_25(Long.toString(sum_reg_center_25));
			center4Bean.setReg_26(Long.toString(sum_reg_center_26));
			center4Bean.setReg_27(Long.toString(sum_reg_center_27));
			center4Bean.setReg_28(Long.toString(sum_reg_center_28));
			center4Bean.setReg_29(Long.toString(sum_reg_center_29));
			center4Bean.setReg_30(Long.toString(sum_reg_center_30));
						
			center4Bean.setDay_00(Long.toString(sum_day_center_00));
			center4Bean.setDay_01(Long.toString(sum_day_center_01));
			center4Bean.setDay_02(Long.toString(sum_day_center_02));
			center4Bean.setDay_03(Long.toString(sum_day_center_03));
			center4Bean.setDay_04(Long.toString(sum_day_center_04));
			center4Bean.setDay_05(Long.toString(sum_day_center_05));
			center4Bean.setDay_06(Long.toString(sum_day_center_06));
			center4Bean.setDay_07(Long.toString(sum_day_center_07));
			center4Bean.setDay_08(Long.toString(sum_day_center_08));
			center4Bean.setDay_09(Long.toString(sum_day_center_09));
			center4Bean.setDay_10(Long.toString(sum_day_center_10));
			center4Bean.setDay_11(Long.toString(sum_day_center_11));
			center4Bean.setDay_12(Long.toString(sum_day_center_12));
			center4Bean.setDay_13(Long.toString(sum_day_center_13));
			center4Bean.setDay_14(Long.toString(sum_day_center_14));
			center4Bean.setDay_15(Long.toString(sum_day_center_15));
			center4Bean.setDay_16(Long.toString(sum_day_center_16));
			center4Bean.setDay_17(Long.toString(sum_day_center_17));
			center4Bean.setDay_18(Long.toString(sum_day_center_18));
			center4Bean.setDay_19(Long.toString(sum_day_center_19));
			center4Bean.setDay_20(Long.toString(sum_day_center_20));
			center4Bean.setDay_21(Long.toString(sum_day_center_21));
			center4Bean.setDay_22(Long.toString(sum_day_center_22));
			center4Bean.setDay_23(Long.toString(sum_day_center_23));
			center4Bean.setDay_24(Long.toString(sum_day_center_24));
			center4Bean.setDay_25(Long.toString(sum_day_center_25));
			center4Bean.setDay_26(Long.toString(sum_day_center_26));
			center4Bean.setDay_27(Long.toString(sum_day_center_27));
			center4Bean.setDay_28(Long.toString(sum_day_center_28));
			center4Bean.setDay_29(Long.toString(sum_day_center_29));
			center4Bean.setDay_30(Long.toString(sum_day_center_30));			
			
			center4Bean.setReg_y(Long.toString(sum_reg_center_y));
			center4Bean.setReg_mi(Long.toString(sum_reg_center_mi));
			center4Bean.setCls_y(Long.toString(sum_cls_center_y));
			center4Bean.setCls_m(Long.toString(sum_cls_center_m));
			
			TeamCenter4ListVO.add(i, center4Bean);
			
			//변수초기화
			center_member_cnt = 0;
			sum_reg_center_00 = 0;
			sum_reg_center_01 = 0;
			sum_reg_center_02 = 0;
			sum_reg_center_03 = 0;
			sum_reg_center_04 = 0;
			sum_reg_center_05 = 0;
			sum_reg_center_06 = 0;
			sum_reg_center_07 = 0;
			sum_reg_center_08 = 0;
			sum_reg_center_09 = 0;
			sum_reg_center_10 = 0;
			sum_reg_center_11 = 0;
			sum_reg_center_12 = 0;
			sum_reg_center_13 = 0;
			sum_reg_center_14 = 0;
			sum_reg_center_15 = 0;
			sum_reg_center_16 = 0;
			sum_reg_center_17 = 0;
			sum_reg_center_18 = 0;
			sum_reg_center_19 = 0;
			sum_reg_center_20 = 0;
			sum_reg_center_21 = 0;
			sum_reg_center_22 = 0;
			sum_reg_center_23 = 0;
			sum_reg_center_24 = 0;
			sum_reg_center_25 = 0;
			sum_reg_center_26 = 0;
			sum_reg_center_27 = 0;
			sum_reg_center_28 = 0;
			sum_reg_center_29 = 0;
			sum_reg_center_30 = 0;
						
			sum_day_center_00 = 0;
			sum_day_center_01 = 0;
			sum_day_center_02 = 0;
			sum_day_center_03 = 0;
			sum_day_center_04 = 0;
			sum_day_center_05 = 0;
			sum_day_center_06 = 0;
			sum_day_center_07 = 0;
			sum_day_center_08 = 0;
			sum_day_center_09 = 0;
			sum_day_center_10 = 0;
			sum_day_center_11 = 0;
			sum_day_center_12 = 0;
			sum_day_center_13 = 0;
			sum_day_center_14 = 0;
			sum_day_center_15 = 0;
			sum_day_center_16 = 0;
			sum_day_center_17 = 0;
			sum_day_center_18 = 0;
			sum_day_center_19 = 0;
			sum_day_center_20 = 0;
			sum_day_center_21 = 0;
			sum_day_center_22 = 0;
			sum_day_center_23 = 0;
			sum_day_center_24 = 0;
			sum_day_center_25 = 0;
			sum_day_center_26 = 0;
			sum_day_center_27 = 0;
			sum_day_center_28 = 0;
			sum_day_center_29 = 0;
			sum_day_center_30 = 0;
			
			sum_reg_center_y = 0;
			sum_reg_center_mi = 0;		
			sum_cls_center_y = 0;	
			sum_cls_center_m = 0;			
		}
		
		model.addAttribute("TeamCenter4ListVO", TeamCenter4ListVO);		
		//4종 센터별 추가 끝		
		
		model.addAttribute("nowVO",nowVO);
		
		return "/top_statistics/mis_allot_center_ajax";
	}
	
	/**
	 * 전체 부문별 일일배당목록 Ajax
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/misAllotSectorAjax")
	public String misAllotSectorAjax(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {
		
		logger.info("======= misAllotSectorAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		
		DateFormat tmpFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date tmpToday = new Date();
		String tmpNow_to = tmpFormat.format(tmpToday);

		inVO.setViewToDate(tmpNow_to);
		StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics30DaysDate", tmpNow_to);
		StatisticsNowVO nowVO2 = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate");
		nowVO.setNow_from(nowVO2.getNow_from());
		nowVO.setNow_to(nowVO2.getNow_to());
		nowVO.setYear_from(nowVO2.getYear_from());
		nowVO.setYear_to(nowVO2.getYear_to());
		
		//================================================
		// 필요 날짜 세팅
		//================================================
		String today = DateUtil.getTodayString();
		String bgnDe = DateUtil.addDate(today,-30);
		String endDe = DateUtil.addDate(today,1);
		String bgnYearDe = (Integer.parseInt(endDe.substring(0,4)) - 1)  + "1216";
		String endYearDe = endDe.substring(0,4) + "1216";
		
		paramMap.put("bgnDe", bgnDe);
		paramMap.put("endDe", endDe);
		paramMap.put("bgnYearDe", bgnYearDe);
		paramMap.put("endYearDe", endYearDe);
		paramMap.put("now_from", nowVO2.getNow_from());
		paramMap.put("now_to", nowVO2.getNow_to());
		
		//농작물 쿼리 추가로인한 셋팅
		nowVO.setBgnYearDe(bgnYearDe);
		nowVO.setEndYearDe(endYearDe);
		nowVO.setBgnDe(bgnDe);
		nowVO.setEndDe(endDe);
		
		List<MisRegTmVO> getMisAllotTm1 = sqlSession.selectList("MisAllotTmMapper.newGetMisAllotTm1", nowVO);
		
		//서면심사 팀 계산값 저장용 임시 Map
		Map<String, Object> written_team;
		
		//농작물 팀 계산값 저장용 임시 Map
		Map<String, Object> prim_team;
		
		//보고서에 농작물 보고서 카운트를 추가하기위한 임시 변수
		int nRegY = 0;
		int nClsY = 0;
		int nClsM = 0;
		int nRegMi = 0;		
		int nReg30=0;
		int nReg29=0;
		int nReg28=0;
		int nReg27=0;
		int nReg26=0;
		int nReg25=0;
		int nReg24=0;
		int nReg23=0;
		int nReg22=0;
		int nReg21=0;
		int nReg20=0;
		int nReg19=0;
		int nReg18=0;
		int nReg17=0;
		int nReg16=0;
		int nReg15=0;
		int nReg14=0;
		int nReg13=0;
		int nReg12=0;
		int nReg11=0;
		int nReg10=0;
		int nReg09=0;
		int nReg08=0;
		int nReg07=0;
		int nReg06=0;
		int nReg05=0;
		int nReg04=0;
		int nReg03=0;
		int nReg02=0;
		int nReg01=0;
		int nReg00=0;
		
		int nDay30=0;
		int nDay29=0;
		int nDay28=0;
		int nDay27=0;
		int nDay26=0;
		int nDay25=0;
		int nDay24=0;
		int nDay23=0;
		int nDay22=0;
		int nDay21=0;
		int nDay20=0;
		int nDay19=0;
		int nDay18=0;
		int nDay17=0;
		int nDay16=0;
		int nDay15=0;
		int nDay14=0;
		int nDay13=0;
		int nDay12=0;
		int nDay11=0;
		int nDay10=0;
		int nDay09=0;
		int nDay08=0;
		int nDay07=0;
		int nDay06=0;
		int nDay05=0;
		int nDay04=0;
		int nDay03=0;
		int nDay02=0;
		int nDay01=0;
		int nDay00=0;
		
		String sChk_writtenteam = "0";
		
		for(int i=0; i < getMisAllotTm1.size(); i++) {
			sChk_writtenteam = getMisAllotTm1.get(i).getTeam_written().toString();
			
			//서면심사팀인 경우만 재계산해준다.
			if("1".equals(sChk_writtenteam)) {
				
				paramMap.put("team_id", getMisAllotTm1.get(i).getTeam_id());
				
				written_team = sqlSession.selectOne("MisAllotTmMbrMapper.selectMisAllotTmTeam1WrittenList", paramMap);
				//서면심사 팀별 년간 수임, 종결
				getMisAllotTm1.get(i).setReg_y(written_team.get("regY").toString());
				getMisAllotTm1.get(i).setCls_y(written_team.get("clsY").toString());				
				
				//서면심사 팀별 월간 종결
				getMisAllotTm1.get(i).setCls_m(written_team.get("clsM").toString());
				
				//서면심사 팀별 미결
				getMisAllotTm1.get(i).setReg_mi(written_team.get("regMi").toString());
				
				//서면심사 팀별 일일 수임
				getMisAllotTm1.get(i).setReg_00(written_team.get("reg31").toString());
				getMisAllotTm1.get(i).setReg_01(written_team.get("reg30").toString());
				getMisAllotTm1.get(i).setReg_02(written_team.get("reg29").toString());
				getMisAllotTm1.get(i).setReg_03(written_team.get("reg28").toString());
				getMisAllotTm1.get(i).setReg_04(written_team.get("reg27").toString());
				getMisAllotTm1.get(i).setReg_05(written_team.get("reg26").toString());
				getMisAllotTm1.get(i).setReg_06(written_team.get("reg25").toString());
				getMisAllotTm1.get(i).setReg_07(written_team.get("reg24").toString());
				getMisAllotTm1.get(i).setReg_08(written_team.get("reg23").toString());
				getMisAllotTm1.get(i).setReg_09(written_team.get("reg22").toString());
				getMisAllotTm1.get(i).setReg_10(written_team.get("reg21").toString());
				getMisAllotTm1.get(i).setReg_11(written_team.get("reg20").toString());
				getMisAllotTm1.get(i).setReg_12(written_team.get("reg19").toString());
				getMisAllotTm1.get(i).setReg_13(written_team.get("reg18").toString());
				getMisAllotTm1.get(i).setReg_14(written_team.get("reg17").toString());
				getMisAllotTm1.get(i).setReg_15(written_team.get("reg16").toString());
				getMisAllotTm1.get(i).setReg_16(written_team.get("reg15").toString());
				getMisAllotTm1.get(i).setReg_17(written_team.get("reg14").toString());
				getMisAllotTm1.get(i).setReg_18(written_team.get("reg13").toString());
				getMisAllotTm1.get(i).setReg_19(written_team.get("reg12").toString());
				getMisAllotTm1.get(i).setReg_20(written_team.get("reg11").toString());
				getMisAllotTm1.get(i).setReg_21(written_team.get("reg10").toString());
				getMisAllotTm1.get(i).setReg_22(written_team.get("reg09").toString());
				getMisAllotTm1.get(i).setReg_23(written_team.get("reg08").toString());
				getMisAllotTm1.get(i).setReg_24(written_team.get("reg07").toString());
				getMisAllotTm1.get(i).setReg_25(written_team.get("reg06").toString());
				getMisAllotTm1.get(i).setReg_26(written_team.get("reg05").toString());
				getMisAllotTm1.get(i).setReg_27(written_team.get("reg04").toString());
				getMisAllotTm1.get(i).setReg_28(written_team.get("reg03").toString());
				getMisAllotTm1.get(i).setReg_29(written_team.get("reg02").toString());
				
				//서면심사 팀별 일일 종결
				getMisAllotTm1.get(i).setDay_00(written_team.get("day31").toString());
				getMisAllotTm1.get(i).setDay_01(written_team.get("day30").toString());
				getMisAllotTm1.get(i).setDay_02(written_team.get("day29").toString());
				getMisAllotTm1.get(i).setDay_03(written_team.get("day28").toString());
				getMisAllotTm1.get(i).setDay_04(written_team.get("day27").toString());
				getMisAllotTm1.get(i).setDay_05(written_team.get("day26").toString());
				getMisAllotTm1.get(i).setDay_06(written_team.get("day25").toString());
				getMisAllotTm1.get(i).setDay_07(written_team.get("day24").toString());
				getMisAllotTm1.get(i).setDay_08(written_team.get("day23").toString());
				getMisAllotTm1.get(i).setDay_09(written_team.get("day22").toString());
				getMisAllotTm1.get(i).setDay_10(written_team.get("day21").toString());
				getMisAllotTm1.get(i).setDay_11(written_team.get("day20").toString());
				getMisAllotTm1.get(i).setDay_12(written_team.get("day19").toString());
				getMisAllotTm1.get(i).setDay_13(written_team.get("day18").toString());
				getMisAllotTm1.get(i).setDay_14(written_team.get("day17").toString());
				getMisAllotTm1.get(i).setDay_15(written_team.get("day16").toString());
				getMisAllotTm1.get(i).setDay_16(written_team.get("day15").toString());
				getMisAllotTm1.get(i).setDay_17(written_team.get("day14").toString());
				getMisAllotTm1.get(i).setDay_18(written_team.get("day13").toString());
				getMisAllotTm1.get(i).setDay_19(written_team.get("day12").toString());
				getMisAllotTm1.get(i).setDay_20(written_team.get("day11").toString());
				getMisAllotTm1.get(i).setDay_21(written_team.get("day10").toString());
				getMisAllotTm1.get(i).setDay_22(written_team.get("day09").toString());
				getMisAllotTm1.get(i).setDay_23(written_team.get("day08").toString());
				getMisAllotTm1.get(i).setDay_24(written_team.get("day07").toString());
				getMisAllotTm1.get(i).setDay_25(written_team.get("day06").toString());
				getMisAllotTm1.get(i).setDay_26(written_team.get("day05").toString());
				getMisAllotTm1.get(i).setDay_27(written_team.get("day04").toString());
				getMisAllotTm1.get(i).setDay_28(written_team.get("day03").toString());
				getMisAllotTm1.get(i).setDay_29(written_team.get("day02").toString());
			}else{				//서면심사가 아닌경우 농작물 카운트를 더해준다.
				String sTeam_id = getMisAllotTm1.get(i).getTeam_id();
				
				nowVO.setTeam_id(sTeam_id);
				
				//농작물의 일일배당 현황 데이터를 가져온다.				
				prim_team = sqlSession.selectOne("MisAllotTmMbrMapper.selectMisAllotTmTeam1PrimList", nowVO);
				
				//농작물 팀별 일일 수임				
				nReg30 = Integer.parseInt( getMisAllotTm1.get(i).getReg_30().toString() ) + Integer.parseInt( prim_team.get("reg30").toString() );
				nReg29 = Integer.parseInt( getMisAllotTm1.get(i).getReg_29().toString() ) + Integer.parseInt( prim_team.get("reg29").toString() );
				nReg28 = Integer.parseInt( getMisAllotTm1.get(i).getReg_28().toString() ) + Integer.parseInt( prim_team.get("reg28").toString() );
				nReg27 = Integer.parseInt( getMisAllotTm1.get(i).getReg_27().toString() ) + Integer.parseInt( prim_team.get("reg27").toString() );
				nReg26 = Integer.parseInt( getMisAllotTm1.get(i).getReg_26().toString() ) + Integer.parseInt( prim_team.get("reg26").toString() );
				nReg25 = Integer.parseInt( getMisAllotTm1.get(i).getReg_25().toString() ) + Integer.parseInt( prim_team.get("reg25").toString() );
				nReg24 = Integer.parseInt( getMisAllotTm1.get(i).getReg_24().toString() ) + Integer.parseInt( prim_team.get("reg24").toString() );
				nReg23 = Integer.parseInt( getMisAllotTm1.get(i).getReg_23().toString() ) + Integer.parseInt( prim_team.get("reg23").toString() );
				nReg22 = Integer.parseInt( getMisAllotTm1.get(i).getReg_22().toString() ) + Integer.parseInt( prim_team.get("reg22").toString() );
				nReg21 = Integer.parseInt( getMisAllotTm1.get(i).getReg_21().toString() ) + Integer.parseInt( prim_team.get("reg21").toString() );
				nReg20 = Integer.parseInt( getMisAllotTm1.get(i).getReg_20().toString() ) + Integer.parseInt( prim_team.get("reg20").toString() );
				nReg19 = Integer.parseInt( getMisAllotTm1.get(i).getReg_19().toString() ) + Integer.parseInt( prim_team.get("reg19").toString() );
				nReg18 = Integer.parseInt( getMisAllotTm1.get(i).getReg_18().toString() ) + Integer.parseInt( prim_team.get("reg18").toString() );
				nReg17 = Integer.parseInt( getMisAllotTm1.get(i).getReg_17().toString() ) + Integer.parseInt( prim_team.get("reg17").toString() );
				nReg16 = Integer.parseInt( getMisAllotTm1.get(i).getReg_16().toString() ) + Integer.parseInt( prim_team.get("reg16").toString() );
				nReg15 = Integer.parseInt( getMisAllotTm1.get(i).getReg_15().toString() ) + Integer.parseInt( prim_team.get("reg15").toString() );
				nReg14 = Integer.parseInt( getMisAllotTm1.get(i).getReg_14().toString() ) + Integer.parseInt( prim_team.get("reg14").toString() );
				nReg13 = Integer.parseInt( getMisAllotTm1.get(i).getReg_13().toString() ) + Integer.parseInt( prim_team.get("reg13").toString() );
				nReg12 = Integer.parseInt( getMisAllotTm1.get(i).getReg_12().toString() ) + Integer.parseInt( prim_team.get("reg12").toString() );
				nReg11 = Integer.parseInt( getMisAllotTm1.get(i).getReg_11().toString() ) + Integer.parseInt( prim_team.get("reg11").toString() );
				nReg10 = Integer.parseInt( getMisAllotTm1.get(i).getReg_10().toString() ) + Integer.parseInt( prim_team.get("reg10").toString() );
				nReg09 = Integer.parseInt( getMisAllotTm1.get(i).getReg_09().toString() ) + Integer.parseInt( prim_team.get("reg09").toString() );
				nReg08 = Integer.parseInt( getMisAllotTm1.get(i).getReg_08().toString() ) + Integer.parseInt( prim_team.get("reg08").toString() );
				nReg07 = Integer.parseInt( getMisAllotTm1.get(i).getReg_07().toString() ) + Integer.parseInt( prim_team.get("reg07").toString() );
				nReg06 = Integer.parseInt( getMisAllotTm1.get(i).getReg_06().toString() ) + Integer.parseInt( prim_team.get("reg06").toString() );
				nReg05 = Integer.parseInt( getMisAllotTm1.get(i).getReg_05().toString() ) + Integer.parseInt( prim_team.get("reg05").toString() );
				nReg04 = Integer.parseInt( getMisAllotTm1.get(i).getReg_04().toString() ) + Integer.parseInt( prim_team.get("reg04").toString() );
				nReg03 = Integer.parseInt( getMisAllotTm1.get(i).getReg_03().toString() ) + Integer.parseInt( prim_team.get("reg03").toString() );
				nReg02 = Integer.parseInt( getMisAllotTm1.get(i).getReg_02().toString() ) + Integer.parseInt( prim_team.get("reg02").toString() );
				nReg01 = Integer.parseInt( getMisAllotTm1.get(i).getReg_01().toString() ) + Integer.parseInt( prim_team.get("reg01").toString() );
				nReg00 = Integer.parseInt( getMisAllotTm1.get(i).getReg_00().toString() ) + Integer.parseInt( prim_team.get("reg00").toString() );

				nDay30 = Integer.parseInt( getMisAllotTm1.get(i).getDay_30().toString() ) + Integer.parseInt( prim_team.get("day30").toString() );
				nDay29 = Integer.parseInt( getMisAllotTm1.get(i).getDay_29().toString() ) + Integer.parseInt( prim_team.get("day29").toString() );
				nDay28 = Integer.parseInt( getMisAllotTm1.get(i).getDay_28().toString() ) + Integer.parseInt( prim_team.get("day28").toString() );
				nDay27 = Integer.parseInt( getMisAllotTm1.get(i).getDay_27().toString() ) + Integer.parseInt( prim_team.get("day27").toString() );
				nDay26 = Integer.parseInt( getMisAllotTm1.get(i).getDay_26().toString() ) + Integer.parseInt( prim_team.get("day26").toString() );
				nDay25 = Integer.parseInt( getMisAllotTm1.get(i).getDay_25().toString() ) + Integer.parseInt( prim_team.get("day25").toString() );
				nDay24 = Integer.parseInt( getMisAllotTm1.get(i).getDay_24().toString() ) + Integer.parseInt( prim_team.get("day24").toString() );
				nDay23 = Integer.parseInt( getMisAllotTm1.get(i).getDay_23().toString() ) + Integer.parseInt( prim_team.get("day23").toString() );
				nDay22 = Integer.parseInt( getMisAllotTm1.get(i).getDay_22().toString() ) + Integer.parseInt( prim_team.get("day22").toString() );
				nDay21 = Integer.parseInt( getMisAllotTm1.get(i).getDay_21().toString() ) + Integer.parseInt( prim_team.get("day21").toString() );
				nDay20 = Integer.parseInt( getMisAllotTm1.get(i).getDay_20().toString() ) + Integer.parseInt( prim_team.get("day20").toString() );
				nDay19 = Integer.parseInt( getMisAllotTm1.get(i).getDay_19().toString() ) + Integer.parseInt( prim_team.get("day19").toString() );
				nDay18 = Integer.parseInt( getMisAllotTm1.get(i).getDay_18().toString() ) + Integer.parseInt( prim_team.get("day18").toString() );
				nDay17 = Integer.parseInt( getMisAllotTm1.get(i).getDay_17().toString() ) + Integer.parseInt( prim_team.get("day17").toString() );
				nDay16 = Integer.parseInt( getMisAllotTm1.get(i).getDay_16().toString() ) + Integer.parseInt( prim_team.get("day16").toString() );
				nDay15 = Integer.parseInt( getMisAllotTm1.get(i).getDay_15().toString() ) + Integer.parseInt( prim_team.get("day15").toString() );
				nDay14 = Integer.parseInt( getMisAllotTm1.get(i).getDay_14().toString() ) + Integer.parseInt( prim_team.get("day14").toString() );
				nDay13 = Integer.parseInt( getMisAllotTm1.get(i).getDay_13().toString() ) + Integer.parseInt( prim_team.get("day13").toString() );
				nDay12 = Integer.parseInt( getMisAllotTm1.get(i).getDay_12().toString() ) + Integer.parseInt( prim_team.get("day12").toString() );
				nDay11 = Integer.parseInt( getMisAllotTm1.get(i).getDay_11().toString() ) + Integer.parseInt( prim_team.get("day11").toString() );
				nDay10 = Integer.parseInt( getMisAllotTm1.get(i).getDay_10().toString() ) + Integer.parseInt( prim_team.get("day10").toString() );
				nDay09 = Integer.parseInt( getMisAllotTm1.get(i).getDay_09().toString() ) + Integer.parseInt( prim_team.get("day09").toString() );
				nDay08 = Integer.parseInt( getMisAllotTm1.get(i).getDay_08().toString() ) + Integer.parseInt( prim_team.get("day08").toString() );
				nDay07 = Integer.parseInt( getMisAllotTm1.get(i).getDay_07().toString() ) + Integer.parseInt( prim_team.get("day07").toString() );
				nDay06 = Integer.parseInt( getMisAllotTm1.get(i).getDay_06().toString() ) + Integer.parseInt( prim_team.get("day06").toString() );
				nDay05 = Integer.parseInt( getMisAllotTm1.get(i).getDay_05().toString() ) + Integer.parseInt( prim_team.get("day05").toString() );
				nDay04 = Integer.parseInt( getMisAllotTm1.get(i).getDay_04().toString() ) + Integer.parseInt( prim_team.get("day04").toString() );
				nDay03 = Integer.parseInt( getMisAllotTm1.get(i).getDay_03().toString() ) + Integer.parseInt( prim_team.get("day03").toString() );
				nDay02 = Integer.parseInt( getMisAllotTm1.get(i).getDay_02().toString() ) + Integer.parseInt( prim_team.get("day02").toString() );
				nDay01 = Integer.parseInt( getMisAllotTm1.get(i).getDay_01().toString() ) + Integer.parseInt( prim_team.get("day01").toString() );
				nDay00 = Integer.parseInt( getMisAllotTm1.get(i).getDay_00().toString() ) + Integer.parseInt( prim_team.get("day00").toString() );
				
				getMisAllotTm1.get(i).setReg_30(String.valueOf(nReg30));
				getMisAllotTm1.get(i).setReg_29(String.valueOf(nReg29));
				getMisAllotTm1.get(i).setReg_28(String.valueOf(nReg28));
				getMisAllotTm1.get(i).setReg_27(String.valueOf(nReg27));
				getMisAllotTm1.get(i).setReg_26(String.valueOf(nReg26));
				getMisAllotTm1.get(i).setReg_25(String.valueOf(nReg25));
				getMisAllotTm1.get(i).setReg_24(String.valueOf(nReg24));
				getMisAllotTm1.get(i).setReg_23(String.valueOf(nReg23));
				getMisAllotTm1.get(i).setReg_22(String.valueOf(nReg22));
				getMisAllotTm1.get(i).setReg_21(String.valueOf(nReg21));
				getMisAllotTm1.get(i).setReg_20(String.valueOf(nReg20));
				getMisAllotTm1.get(i).setReg_19(String.valueOf(nReg19));
				getMisAllotTm1.get(i).setReg_18(String.valueOf(nReg18));
				getMisAllotTm1.get(i).setReg_17(String.valueOf(nReg17));
				getMisAllotTm1.get(i).setReg_16(String.valueOf(nReg16));
				getMisAllotTm1.get(i).setReg_15(String.valueOf(nReg15));
				getMisAllotTm1.get(i).setReg_14(String.valueOf(nReg14));
				getMisAllotTm1.get(i).setReg_13(String.valueOf(nReg13));
				getMisAllotTm1.get(i).setReg_12(String.valueOf(nReg12));
				getMisAllotTm1.get(i).setReg_11(String.valueOf(nReg11));
				getMisAllotTm1.get(i).setReg_10(String.valueOf(nReg10));
				getMisAllotTm1.get(i).setReg_09(String.valueOf(nReg09));
				getMisAllotTm1.get(i).setReg_08(String.valueOf(nReg08));
				getMisAllotTm1.get(i).setReg_07(String.valueOf(nReg07));
				getMisAllotTm1.get(i).setReg_06(String.valueOf(nReg06));
				getMisAllotTm1.get(i).setReg_05(String.valueOf(nReg05));
				getMisAllotTm1.get(i).setReg_04(String.valueOf(nReg04));
				getMisAllotTm1.get(i).setReg_03(String.valueOf(nReg03));
				getMisAllotTm1.get(i).setReg_02(String.valueOf(nReg02));
				getMisAllotTm1.get(i).setReg_01(String.valueOf(nReg01));
				getMisAllotTm1.get(i).setReg_00(String.valueOf(nReg00));
				
				getMisAllotTm1.get(i).setDay_30(String.valueOf(nDay30));
				getMisAllotTm1.get(i).setDay_29(String.valueOf(nDay29));
				getMisAllotTm1.get(i).setDay_28(String.valueOf(nDay28));
				getMisAllotTm1.get(i).setDay_27(String.valueOf(nDay27));
				getMisAllotTm1.get(i).setDay_26(String.valueOf(nDay26));
				getMisAllotTm1.get(i).setDay_25(String.valueOf(nDay25));
				getMisAllotTm1.get(i).setDay_24(String.valueOf(nDay24));
				getMisAllotTm1.get(i).setDay_23(String.valueOf(nDay23));
				getMisAllotTm1.get(i).setDay_22(String.valueOf(nDay22));
				getMisAllotTm1.get(i).setDay_21(String.valueOf(nDay21));
				getMisAllotTm1.get(i).setDay_20(String.valueOf(nDay20));
				getMisAllotTm1.get(i).setDay_19(String.valueOf(nDay19));
				getMisAllotTm1.get(i).setDay_18(String.valueOf(nDay18));
				getMisAllotTm1.get(i).setDay_17(String.valueOf(nDay17));
				getMisAllotTm1.get(i).setDay_16(String.valueOf(nDay16));
				getMisAllotTm1.get(i).setDay_15(String.valueOf(nDay15));
				getMisAllotTm1.get(i).setDay_14(String.valueOf(nDay14));
				getMisAllotTm1.get(i).setDay_13(String.valueOf(nDay13));
				getMisAllotTm1.get(i).setDay_12(String.valueOf(nDay12));
				getMisAllotTm1.get(i).setDay_11(String.valueOf(nDay11));
				getMisAllotTm1.get(i).setDay_10(String.valueOf(nDay10));
				getMisAllotTm1.get(i).setDay_09(String.valueOf(nDay09));
				getMisAllotTm1.get(i).setDay_08(String.valueOf(nDay08));
				getMisAllotTm1.get(i).setDay_07(String.valueOf(nDay07));
				getMisAllotTm1.get(i).setDay_06(String.valueOf(nDay06));
				getMisAllotTm1.get(i).setDay_05(String.valueOf(nDay05));
				getMisAllotTm1.get(i).setDay_04(String.valueOf(nDay04));
				getMisAllotTm1.get(i).setDay_03(String.valueOf(nDay03));
				getMisAllotTm1.get(i).setDay_02(String.valueOf(nDay02));
				getMisAllotTm1.get(i).setDay_01(String.valueOf(nDay01));
				getMisAllotTm1.get(i).setDay_00(String.valueOf(nDay00));				
				
				//농작물 팀별 년간 수임, 종결				
				nRegY = Integer.parseInt( getMisAllotTm1.get(i).getReg_y().toString() ) + Integer.parseInt( prim_team.get("regY").toString() );
				getMisAllotTm1.get(i).setReg_y(String.valueOf(nRegY));
				nClsY = Integer.parseInt( getMisAllotTm1.get(i).getCls_y().toString()) + Integer.parseInt( prim_team.get("clsY").toString() );
				getMisAllotTm1.get(i).setCls_y(String.valueOf(nClsY));				
				
				//농작물 팀별 월간 종결
				nClsM = Integer.parseInt( getMisAllotTm1.get(i).getCls_m().toString() ) + Integer.parseInt( prim_team.get("clsM").toString() );				
				getMisAllotTm1.get(i).setCls_m(String.valueOf(nClsM));
				
				//농작물 팀별 미결
				nRegMi = Integer.parseInt( getMisAllotTm1.get(i).getReg_mi().toString() ) + Integer.parseInt( prim_team.get("regMi").toString() );
				getMisAllotTm1.get(i).setReg_mi(String.valueOf(nRegMi));				
			}
		}		
		
		List<MisRegTmVO> getMisAllotTm4 = sqlSession.selectList("MisAllotTmMapper.newGetMisAllotTm4", nowVO);
				
		//부문별 추가 시작 by top3009		
		/** 팀 부문 선택을 위한 부문 명부로드 2019.07.08 by top3009*/
		SysAdmCodeDicVO codeVO = new SysAdmCodeDicVO();      
		codeVO.setTbl_nm("top_tm_bsc");
		codeVO.setCol_nm("team_sector");
		List<SysAdmCodeDicVO> teamSectorList = service.codeList(codeVO);
		
		String sSector = ""; 
		String sSector_val = "";
		String sSector_flag = "";
		
		long sum_reg_00 = 0;
		long sum_reg_01 = 0;
		long sum_reg_02 = 0;
		long sum_reg_03 = 0;
		long sum_reg_04 = 0;
		long sum_reg_05 = 0;
		long sum_reg_06 = 0;
		long sum_reg_07 = 0;
		long sum_reg_08 = 0;
		long sum_reg_09 = 0;
		long sum_reg_10 = 0;
		long sum_reg_11 = 0;
		long sum_reg_12 = 0;
		long sum_reg_13 = 0;
		long sum_reg_14 = 0;
		long sum_reg_15 = 0;
		long sum_reg_16 = 0;
		long sum_reg_17 = 0;
		long sum_reg_18 = 0;
		long sum_reg_19 = 0;
		long sum_reg_20 = 0;
		long sum_reg_21 = 0;
		long sum_reg_22 = 0;
		long sum_reg_23 = 0;
		long sum_reg_24 = 0;
		long sum_reg_25 = 0;
		long sum_reg_26 = 0;
		long sum_reg_27 = 0;
		long sum_reg_28 = 0;
		long sum_reg_29 = 0;
		long sum_reg_30 = 0;
		
		long sum_reg_wc_00 = 0;
		long sum_reg_wc_01 = 0;
		long sum_reg_wc_02 = 0;
		long sum_reg_wc_03 = 0;
		long sum_reg_wc_04 = 0;
		long sum_reg_wc_05 = 0;
		long sum_reg_wc_06 = 0;
		long sum_reg_wc_07 = 0;
		long sum_reg_wc_08 = 0;
		long sum_reg_wc_09 = 0;
		long sum_reg_wc_10 = 0;
		long sum_reg_wc_11 = 0;
		long sum_reg_wc_12 = 0;
		long sum_reg_wc_13 = 0;
		long sum_reg_wc_14 = 0;
		long sum_reg_wc_15 = 0;
		long sum_reg_wc_16 = 0;
		long sum_reg_wc_17 = 0;
		long sum_reg_wc_18 = 0;
		long sum_reg_wc_19 = 0;
		long sum_reg_wc_20 = 0;
		long sum_reg_wc_21 = 0;
		long sum_reg_wc_22 = 0;
		long sum_reg_wc_23 = 0;
		long sum_reg_wc_24 = 0;
		long sum_reg_wc_25 = 0;
		long sum_reg_wc_26 = 0;
		long sum_reg_wc_27 = 0;
		long sum_reg_wc_28 = 0;
		long sum_reg_wc_29 = 0;
		long sum_reg_wc_30 = 0;
		
		long sum_day_00 = 0;
		long sum_day_01 = 0;
		long sum_day_02 = 0;
		long sum_day_03 = 0;
		long sum_day_04 = 0;
		long sum_day_05 = 0;
		long sum_day_06 = 0;
		long sum_day_07 = 0;
		long sum_day_08 = 0;
		long sum_day_09 = 0;
		long sum_day_10 = 0;
		long sum_day_11 = 0;
		long sum_day_12 = 0;
		long sum_day_13 = 0;
		long sum_day_14 = 0;
		long sum_day_15 = 0;
		long sum_day_16 = 0;
		long sum_day_17 = 0;
		long sum_day_18 = 0;
		long sum_day_19 = 0;
		long sum_day_20 = 0;
		long sum_day_21 = 0;
		long sum_day_22 = 0;
		long sum_day_23 = 0;
		long sum_day_24 = 0;
		long sum_day_25 = 0;
		long sum_day_26 = 0;
		long sum_day_27 = 0;
		long sum_day_28 = 0;
		long sum_day_29 = 0;
		long sum_day_30 = 0;
		
		long sum_day_wc_00 = 0;
		long sum_day_wc_01 = 0;
		long sum_day_wc_02 = 0;
		long sum_day_wc_03 = 0;
		long sum_day_wc_04 = 0;
		long sum_day_wc_05 = 0;
		long sum_day_wc_06 = 0;
		long sum_day_wc_07 = 0;
		long sum_day_wc_08 = 0;
		long sum_day_wc_09 = 0;
		long sum_day_wc_10 = 0;
		long sum_day_wc_11 = 0;
		long sum_day_wc_12 = 0;
		long sum_day_wc_13 = 0;
		long sum_day_wc_14 = 0;
		long sum_day_wc_15 = 0;
		long sum_day_wc_16 = 0;
		long sum_day_wc_17 = 0;
		long sum_day_wc_18 = 0;
		long sum_day_wc_19 = 0;
		long sum_day_wc_20 = 0;
		long sum_day_wc_21 = 0;
		long sum_day_wc_22 = 0;
		long sum_day_wc_23 = 0;
		long sum_day_wc_24 = 0;
		long sum_day_wc_25 = 0;
		long sum_day_wc_26 = 0;
		long sum_day_wc_27 = 0;
		long sum_day_wc_28 = 0;
		long sum_day_wc_29 = 0;
		long sum_day_wc_30 = 0;

		long sum_reg_y = 0;
		long sum_reg_mi = 0;		
		long sum_cls_y = 0;	
		long sum_cls_m = 0;
		
		long sum_reg_wc_y = 0;
		long sum_reg_wc_mi = 0;		
		long sum_cls_wc_y = 0;	
		long sum_cls_wc_m = 0;
		
		int sector_member_cnt = 0;		//부문별 인원수
		
		List<MisRegTmVO> TeamSectorListVO = new ArrayList<MisRegTmVO>();			//부문별 목록에 뿌려줄 리스트 생성
		
		//부문별 합산계산 시작
		for(int i=0; i < teamSectorList.size(); i++) {
			
			MisRegTmVO sectorBean = new MisRegTmVO();			//리스트에 넣어줄 객체 생성
			
			sSector = teamSectorList.get(i).getCol_cd();
			sSector_val = teamSectorList.get(i).getCol_val();			
			sectorBean.setTeam_sector(sSector);
			sectorBean.setTeam_sector_val(sSector_val);
			
			//팀목록에서 가져온 카운트를 체크해서 넣어준다.
			for(int k=0; k < getMisAllotTm1.size(); k++) {				
				sSector_flag = getMisAllotTm1.get(k).getTeam_sector();
				//if(sSector.equals(sSector_flag) && !"9".equals(sSector)){				//team_sector 가 0이아니고, 같은경우만 합산한다.
				if(sSector.equals(sSector_flag)){				//team_sector 가 0이아니고, 같은경우만 합산한다.
					
					sector_member_cnt += getMisAllotTm1.get(k).getMember_cnt(); 
					sum_reg_00 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_00());
					sum_reg_01 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_01());
					sum_reg_02 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_02());
					sum_reg_03 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_03());
					sum_reg_04 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_04());
					sum_reg_05 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_05());
					sum_reg_06 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_06());
					sum_reg_07 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_07());
					sum_reg_08 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_08());
					sum_reg_09 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_09());
					sum_reg_10 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_10());
					sum_reg_11 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_11());
					sum_reg_12 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_12());
					sum_reg_13 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_13());
					sum_reg_14 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_14());
					sum_reg_15 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_15());
					sum_reg_16 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_16());
					sum_reg_17 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_17());
					sum_reg_18 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_18());
					sum_reg_19 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_19());
					sum_reg_20 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_20());
					sum_reg_21 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_21());
					sum_reg_22 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_22());
					sum_reg_23 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_23());
					sum_reg_24 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_24());
					sum_reg_25 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_25());
					sum_reg_26 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_26());
					sum_reg_27 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_27());
					sum_reg_28 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_28());
					sum_reg_29 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_29());
					sum_reg_30 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_30());
					
					sum_reg_wc_00 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_00());
					sum_reg_wc_01 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_01());
					sum_reg_wc_02 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_02());
					sum_reg_wc_03 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_03());
					sum_reg_wc_04 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_04());
					sum_reg_wc_05 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_05());
					sum_reg_wc_06 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_06());
					sum_reg_wc_07 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_07());
					sum_reg_wc_08 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_08());
					sum_reg_wc_09 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_09());
					sum_reg_wc_10 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_10());
					sum_reg_wc_11 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_11());
					sum_reg_wc_12 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_12());
					sum_reg_wc_13 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_13());
					sum_reg_wc_14 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_14());
					sum_reg_wc_15 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_15());
					sum_reg_wc_16 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_16());
					sum_reg_wc_17 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_17());
					sum_reg_wc_18 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_18());
					sum_reg_wc_19 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_19());
					sum_reg_wc_20 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_20());
					sum_reg_wc_21 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_21());
					sum_reg_wc_22 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_22());
					sum_reg_wc_23 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_23());
					sum_reg_wc_24 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_24());
					sum_reg_wc_25 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_25());
					sum_reg_wc_26 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_26());
					sum_reg_wc_27 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_27());
					sum_reg_wc_28 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_28());
					sum_reg_wc_29 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_29());
					sum_reg_wc_30 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_30());
					
					sum_day_00 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_00());
					sum_day_01 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_01());
					sum_day_02 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_02());
					sum_day_03 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_03());
					sum_day_04 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_04());
					sum_day_05 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_05());
					sum_day_06 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_06());
					sum_day_07 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_07());
					sum_day_08 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_08());
					sum_day_09 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_09());
					sum_day_10 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_10());
					sum_day_11 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_11());
					sum_day_12 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_12());
					sum_day_13 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_13());
					sum_day_14 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_14());
					sum_day_15 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_15());
					sum_day_16 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_16());
					sum_day_17 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_17());
					sum_day_18 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_18());
					sum_day_19 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_19());
					sum_day_20 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_20());
					sum_day_21 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_21());
					sum_day_22 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_22());
					sum_day_23 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_23());
					sum_day_24 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_24());
					sum_day_25 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_25());
					sum_day_26 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_26());
					sum_day_27 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_27());
					sum_day_28 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_28());
					sum_day_29 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_29());
					sum_day_30 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_30());
					
					sum_day_wc_00 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_00());
					sum_day_wc_01 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_01());
					sum_day_wc_02 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_02());
					sum_day_wc_03 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_03());
					sum_day_wc_04 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_04());
					sum_day_wc_05 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_05());
					sum_day_wc_06 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_06());
					sum_day_wc_07 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_07());
					sum_day_wc_08 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_08());
					sum_day_wc_09 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_09());
					sum_day_wc_10 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_10());
					sum_day_wc_11 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_11());
					sum_day_wc_12 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_12());
					sum_day_wc_13 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_13());
					sum_day_wc_14 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_14());
					sum_day_wc_15 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_15());
					sum_day_wc_16 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_16());
					sum_day_wc_17 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_17());
					sum_day_wc_18 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_18());
					sum_day_wc_19 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_19());
					sum_day_wc_20 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_20());
					sum_day_wc_21 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_21());
					sum_day_wc_22 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_22());
					sum_day_wc_23 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_23());
					sum_day_wc_24 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_24());
					sum_day_wc_25 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_25());
					sum_day_wc_26 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_26());
					sum_day_wc_27 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_27());
					sum_day_wc_28 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_28());
					sum_day_wc_29 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_29());
					sum_day_wc_30 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_30());
					
					sum_reg_y += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_y());
					sum_reg_mi += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_mi());
					
					sum_cls_y += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getCls_y());
					sum_cls_m += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getCls_m());
					
					sum_reg_wc_y += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_y());
					sum_reg_wc_mi += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_mi());
					
					sum_cls_wc_y += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getCls_wc_y());
					sum_cls_wc_m += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getCls_wc_m());
										
				}
			}
			
			sectorBean.setMember_cnt(sector_member_cnt);
			sectorBean.setReg_00(Long.toString(sum_reg_00));
			sectorBean.setReg_01(Long.toString(sum_reg_01));
			sectorBean.setReg_02(Long.toString(sum_reg_02));
			sectorBean.setReg_03(Long.toString(sum_reg_03));
			sectorBean.setReg_04(Long.toString(sum_reg_04));
			sectorBean.setReg_05(Long.toString(sum_reg_05));
			sectorBean.setReg_06(Long.toString(sum_reg_06));
			sectorBean.setReg_07(Long.toString(sum_reg_07));
			sectorBean.setReg_08(Long.toString(sum_reg_08));
			sectorBean.setReg_09(Long.toString(sum_reg_09));
			sectorBean.setReg_10(Long.toString(sum_reg_10));
			sectorBean.setReg_11(Long.toString(sum_reg_11));
			sectorBean.setReg_12(Long.toString(sum_reg_12));
			sectorBean.setReg_13(Long.toString(sum_reg_13));
			sectorBean.setReg_14(Long.toString(sum_reg_14));
			sectorBean.setReg_15(Long.toString(sum_reg_15));
			sectorBean.setReg_16(Long.toString(sum_reg_16));
			sectorBean.setReg_17(Long.toString(sum_reg_17));
			sectorBean.setReg_18(Long.toString(sum_reg_18));
			sectorBean.setReg_19(Long.toString(sum_reg_19));
			sectorBean.setReg_20(Long.toString(sum_reg_20));
			sectorBean.setReg_21(Long.toString(sum_reg_21));
			sectorBean.setReg_22(Long.toString(sum_reg_22));
			sectorBean.setReg_23(Long.toString(sum_reg_23));
			sectorBean.setReg_24(Long.toString(sum_reg_24));
			sectorBean.setReg_25(Long.toString(sum_reg_25));
			sectorBean.setReg_26(Long.toString(sum_reg_26));
			sectorBean.setReg_27(Long.toString(sum_reg_27));
			sectorBean.setReg_28(Long.toString(sum_reg_28));
			sectorBean.setReg_29(Long.toString(sum_reg_29));
			sectorBean.setReg_30(Long.toString(sum_reg_30));
			
			sectorBean.setReg_wc_00(Long.toString(sum_reg_wc_00));
			sectorBean.setReg_wc_01(Long.toString(sum_reg_wc_01));
			sectorBean.setReg_wc_02(Long.toString(sum_reg_wc_02));
			sectorBean.setReg_wc_03(Long.toString(sum_reg_wc_03));
			sectorBean.setReg_wc_04(Long.toString(sum_reg_wc_04));
			sectorBean.setReg_wc_05(Long.toString(sum_reg_wc_05));
			sectorBean.setReg_wc_06(Long.toString(sum_reg_wc_06));
			sectorBean.setReg_wc_07(Long.toString(sum_reg_wc_07));
			sectorBean.setReg_wc_08(Long.toString(sum_reg_wc_08));
			sectorBean.setReg_wc_09(Long.toString(sum_reg_wc_09));
			sectorBean.setReg_wc_10(Long.toString(sum_reg_wc_10));
			sectorBean.setReg_wc_11(Long.toString(sum_reg_wc_11));
			sectorBean.setReg_wc_12(Long.toString(sum_reg_wc_12));
			sectorBean.setReg_wc_13(Long.toString(sum_reg_wc_13));
			sectorBean.setReg_wc_14(Long.toString(sum_reg_wc_14));
			sectorBean.setReg_wc_15(Long.toString(sum_reg_wc_15));
			sectorBean.setReg_wc_16(Long.toString(sum_reg_wc_16));
			sectorBean.setReg_wc_17(Long.toString(sum_reg_wc_17));
			sectorBean.setReg_wc_18(Long.toString(sum_reg_wc_18));
			sectorBean.setReg_wc_19(Long.toString(sum_reg_wc_19));
			sectorBean.setReg_wc_20(Long.toString(sum_reg_wc_20));
			sectorBean.setReg_wc_21(Long.toString(sum_reg_wc_21));
			sectorBean.setReg_wc_22(Long.toString(sum_reg_wc_22));
			sectorBean.setReg_wc_23(Long.toString(sum_reg_wc_23));
			sectorBean.setReg_wc_24(Long.toString(sum_reg_wc_24));
			sectorBean.setReg_wc_25(Long.toString(sum_reg_wc_25));
			sectorBean.setReg_wc_26(Long.toString(sum_reg_wc_26));
			sectorBean.setReg_wc_27(Long.toString(sum_reg_wc_27));
			sectorBean.setReg_wc_28(Long.toString(sum_reg_wc_28));
			sectorBean.setReg_wc_29(Long.toString(sum_reg_wc_29));
			sectorBean.setReg_wc_30(Long.toString(sum_reg_wc_30));
			
			sectorBean.setDay_00(Long.toString(sum_day_00));
			sectorBean.setDay_01(Long.toString(sum_day_01));
			sectorBean.setDay_02(Long.toString(sum_day_02));
			sectorBean.setDay_03(Long.toString(sum_day_03));
			sectorBean.setDay_04(Long.toString(sum_day_04));
			sectorBean.setDay_05(Long.toString(sum_day_05));
			sectorBean.setDay_06(Long.toString(sum_day_06));
			sectorBean.setDay_07(Long.toString(sum_day_07));
			sectorBean.setDay_08(Long.toString(sum_day_08));
			sectorBean.setDay_09(Long.toString(sum_day_09));
			sectorBean.setDay_10(Long.toString(sum_day_10));
			sectorBean.setDay_11(Long.toString(sum_day_11));
			sectorBean.setDay_12(Long.toString(sum_day_12));
			sectorBean.setDay_13(Long.toString(sum_day_13));
			sectorBean.setDay_14(Long.toString(sum_day_14));
			sectorBean.setDay_15(Long.toString(sum_day_15));
			sectorBean.setDay_16(Long.toString(sum_day_16));
			sectorBean.setDay_17(Long.toString(sum_day_17));
			sectorBean.setDay_18(Long.toString(sum_day_18));
			sectorBean.setDay_19(Long.toString(sum_day_19));
			sectorBean.setDay_20(Long.toString(sum_day_20));
			sectorBean.setDay_21(Long.toString(sum_day_21));
			sectorBean.setDay_22(Long.toString(sum_day_22));
			sectorBean.setDay_23(Long.toString(sum_day_23));
			sectorBean.setDay_24(Long.toString(sum_day_24));
			sectorBean.setDay_25(Long.toString(sum_day_25));
			sectorBean.setDay_26(Long.toString(sum_day_26));
			sectorBean.setDay_27(Long.toString(sum_day_27));
			sectorBean.setDay_28(Long.toString(sum_day_28));
			sectorBean.setDay_29(Long.toString(sum_day_29));
			sectorBean.setDay_30(Long.toString(sum_day_30));
			
			sectorBean.setDay_wc_00(Long.toString(sum_day_wc_00));
			sectorBean.setDay_wc_01(Long.toString(sum_day_wc_01));
			sectorBean.setDay_wc_02(Long.toString(sum_day_wc_02));
			sectorBean.setDay_wc_03(Long.toString(sum_day_wc_03));
			sectorBean.setDay_wc_04(Long.toString(sum_day_wc_04));
			sectorBean.setDay_wc_05(Long.toString(sum_day_wc_05));
			sectorBean.setDay_wc_06(Long.toString(sum_day_wc_06));
			sectorBean.setDay_wc_07(Long.toString(sum_day_wc_07));
			sectorBean.setDay_wc_08(Long.toString(sum_day_wc_08));
			sectorBean.setDay_wc_09(Long.toString(sum_day_wc_09));
			sectorBean.setDay_wc_10(Long.toString(sum_day_wc_10));
			sectorBean.setDay_wc_11(Long.toString(sum_day_wc_11));
			sectorBean.setDay_wc_12(Long.toString(sum_day_wc_12));
			sectorBean.setDay_wc_13(Long.toString(sum_day_wc_13));
			sectorBean.setDay_wc_14(Long.toString(sum_day_wc_14));
			sectorBean.setDay_wc_15(Long.toString(sum_day_wc_15));
			sectorBean.setDay_wc_16(Long.toString(sum_day_wc_16));
			sectorBean.setDay_wc_17(Long.toString(sum_day_wc_17));
			sectorBean.setDay_wc_18(Long.toString(sum_day_wc_18));
			sectorBean.setDay_wc_19(Long.toString(sum_day_wc_19));
			sectorBean.setDay_wc_20(Long.toString(sum_day_wc_20));
			sectorBean.setDay_wc_21(Long.toString(sum_day_wc_21));
			sectorBean.setDay_wc_22(Long.toString(sum_day_wc_22));
			sectorBean.setDay_wc_23(Long.toString(sum_day_wc_23));
			sectorBean.setDay_wc_24(Long.toString(sum_day_wc_24));
			sectorBean.setDay_wc_25(Long.toString(sum_day_wc_25));
			sectorBean.setDay_wc_26(Long.toString(sum_day_wc_26));
			sectorBean.setDay_wc_27(Long.toString(sum_day_wc_27));
			sectorBean.setDay_wc_28(Long.toString(sum_day_wc_28));
			sectorBean.setDay_wc_29(Long.toString(sum_day_wc_29));
			sectorBean.setDay_wc_30(Long.toString(sum_day_wc_30));
			
			sectorBean.setReg_y(Long.toString(sum_reg_y));
			sectorBean.setReg_mi(Long.toString(sum_reg_mi));
			sectorBean.setCls_y(Long.toString(sum_cls_y));
			sectorBean.setCls_m(Long.toString(sum_cls_m));
			
			sectorBean.setReg_wc_y(Long.toString(sum_reg_wc_y));
			sectorBean.setReg_wc_mi(Long.toString(sum_reg_wc_mi));
			sectorBean.setCls_wc_y(Long.toString(sum_cls_wc_y));
			sectorBean.setCls_wc_m(Long.toString(sum_cls_wc_m));
			
			//서면심사 부문 표시 여부 확인
			long sum_sector_all = sum_reg_wc_00 + sum_reg_wc_01 + sum_reg_wc_02 + sum_reg_wc_03 + sum_reg_wc_04
					+ sum_reg_wc_05 + sum_reg_wc_06 + sum_reg_wc_07 + sum_reg_wc_08 + sum_reg_wc_09 + sum_reg_wc_10
					+ sum_reg_wc_11 + sum_reg_wc_12 + sum_reg_wc_13 + sum_reg_wc_14 + sum_reg_wc_15 + sum_reg_wc_16
					+ sum_reg_wc_17 + sum_reg_wc_18 + sum_reg_wc_19 + sum_reg_wc_20 + sum_reg_wc_21 + sum_reg_wc_22
					+ sum_reg_wc_23 + sum_reg_wc_24 + sum_reg_wc_25 + sum_reg_wc_26 + sum_reg_wc_27 + sum_reg_wc_28
					+ sum_reg_wc_29 + sum_reg_wc_30 + sum_day_wc_00 + sum_day_wc_01 + sum_day_wc_02 + sum_day_wc_03
					+ sum_day_wc_04 + sum_day_wc_05 + sum_day_wc_06 + sum_day_wc_07 + sum_day_wc_08 + sum_day_wc_09
					+ sum_day_wc_10 + sum_day_wc_11 + sum_day_wc_12 + sum_day_wc_13 + sum_day_wc_14 + sum_day_wc_15
					+ sum_day_wc_16 + sum_day_wc_17 + sum_day_wc_18 + sum_day_wc_19 + sum_day_wc_20 + sum_day_wc_21
					+ sum_day_wc_22 + sum_day_wc_23 + sum_day_wc_24 + sum_day_wc_25 + sum_day_wc_26 + sum_day_wc_27
					+ sum_day_wc_28 + sum_day_wc_29 + sum_day_wc_30;
		
			if( sum_sector_all == 0) {
				sectorBean.setWc_sector_flag("0");
			}else{
				sectorBean.setWc_sector_flag("1");
			}			
			
			TeamSectorListVO.add(i, sectorBean);
			
			//변수초기화
			sector_member_cnt = 0;
			sum_reg_00 = 0;
			sum_reg_01 = 0;
			sum_reg_02 = 0;
			sum_reg_03 = 0;
			sum_reg_04 = 0;
			sum_reg_05 = 0;
			sum_reg_06 = 0;
			sum_reg_07 = 0;
			sum_reg_08 = 0;
			sum_reg_09 = 0;
			sum_reg_10 = 0;
			sum_reg_11 = 0;
			sum_reg_12 = 0;
			sum_reg_13 = 0;
			sum_reg_14 = 0;
			sum_reg_15 = 0;
			sum_reg_16 = 0;
			sum_reg_17 = 0;
			sum_reg_18 = 0;
			sum_reg_19 = 0;
			sum_reg_20 = 0;
			sum_reg_21 = 0;
			sum_reg_22 = 0;
			sum_reg_23 = 0;
			sum_reg_24 = 0;
			sum_reg_25 = 0;
			sum_reg_26 = 0;
			sum_reg_27 = 0;
			sum_reg_28 = 0;
			sum_reg_29 = 0;
			sum_reg_30 = 0;
			
			sum_reg_wc_00 = 0;
			sum_reg_wc_01 = 0;
			sum_reg_wc_02 = 0;
			sum_reg_wc_03 = 0;
			sum_reg_wc_04 = 0;
			sum_reg_wc_05 = 0;
			sum_reg_wc_06 = 0;
			sum_reg_wc_07 = 0;
			sum_reg_wc_08 = 0;
			sum_reg_wc_09 = 0;
			sum_reg_wc_10 = 0;
			sum_reg_wc_11 = 0;
			sum_reg_wc_12 = 0;
			sum_reg_wc_13 = 0;
			sum_reg_wc_14 = 0;
			sum_reg_wc_15 = 0;
			sum_reg_wc_16 = 0;
			sum_reg_wc_17 = 0;
			sum_reg_wc_18 = 0;
			sum_reg_wc_19 = 0;
			sum_reg_wc_20 = 0;
			sum_reg_wc_21 = 0;
			sum_reg_wc_22 = 0;
			sum_reg_wc_23 = 0;
			sum_reg_wc_24 = 0;
			sum_reg_wc_25 = 0;
			sum_reg_wc_26 = 0;
			sum_reg_wc_27 = 0;
			sum_reg_wc_28 = 0;
			sum_reg_wc_29 = 0;
			sum_reg_wc_30 = 0;
			
			sum_day_00 = 0;
			sum_day_01 = 0;
			sum_day_02 = 0;
			sum_day_03 = 0;
			sum_day_04 = 0;
			sum_day_05 = 0;
			sum_day_06 = 0;
			sum_day_07 = 0;
			sum_day_08 = 0;
			sum_day_09 = 0;
			sum_day_10 = 0;
			sum_day_11 = 0;
			sum_day_12 = 0;
			sum_day_13 = 0;
			sum_day_14 = 0;
			sum_day_15 = 0;
			sum_day_16 = 0;
			sum_day_17 = 0;
			sum_day_18 = 0;
			sum_day_19 = 0;
			sum_day_20 = 0;
			sum_day_21 = 0;
			sum_day_22 = 0;
			sum_day_23 = 0;
			sum_day_24 = 0;
			sum_day_25 = 0;
			sum_day_26 = 0;
			sum_day_27 = 0;
			sum_day_28 = 0;
			sum_day_29 = 0;
			sum_day_30 = 0;
			
			sum_day_wc_00 = 0;
			sum_day_wc_01 = 0;
			sum_day_wc_02 = 0;
			sum_day_wc_03 = 0;
			sum_day_wc_04 = 0;
			sum_day_wc_05 = 0;
			sum_day_wc_06 = 0;
			sum_day_wc_07 = 0;
			sum_day_wc_08 = 0;
			sum_day_wc_09 = 0;
			sum_day_wc_10 = 0;
			sum_day_wc_11 = 0;
			sum_day_wc_12 = 0;
			sum_day_wc_13 = 0;
			sum_day_wc_14 = 0;
			sum_day_wc_15 = 0;
			sum_day_wc_16 = 0;
			sum_day_wc_17 = 0;
			sum_day_wc_18 = 0;
			sum_day_wc_19 = 0;
			sum_day_wc_20 = 0;
			sum_day_wc_21 = 0;
			sum_day_wc_22 = 0;
			sum_day_wc_23 = 0;
			sum_day_wc_24 = 0;
			sum_day_wc_25 = 0;
			sum_day_wc_26 = 0;
			sum_day_wc_27 = 0;
			sum_day_wc_28 = 0;
			sum_day_wc_29 = 0;
			sum_day_wc_30 = 0;

			sum_reg_y = 0;			
			sum_reg_mi = 0;		
			sum_cls_y = 0;	
			sum_cls_m = 0;
			
			sum_reg_wc_y = 0;			
			sum_reg_wc_mi = 0;		
			sum_cls_wc_y = 0;	
			sum_cls_wc_m = 0;
		}
		
		model.addAttribute("TeamSectorListVO", TeamSectorListVO);

		//부문별 추가 끝 by top3009
		
		//4종 부분별 추가 시작
		List<MisRegTmVO> TeamSector4ListVO = new ArrayList<MisRegTmVO>();			//부문별 목록에 뿌려줄 리스트 생성
		
		//부문별 합산계산 시작
		for(int i=0; i < teamSectorList.size(); i++) {
			
			MisRegTmVO sector4Bean = new MisRegTmVO();			//리스트에 넣어줄 객체 생성
			
			sSector = teamSectorList.get(i).getCol_cd();
			sSector_val = teamSectorList.get(i).getCol_val();			
			sector4Bean.setTeam_sector(sSector);
			sector4Bean.setTeam_sector_val(sSector_val);
			
			//팀목록에서 가져온 카운트를 체크해서 넣어준다.
			for(int k=0; k < getMisAllotTm4.size(); k++) {
				sSector_flag = getMisAllotTm4.get(k).getTeam_sector();
				if(sSector.equals(sSector_flag)){				//team_sector 가 0이아니고, 같은경우만 합산한다.					
					sector_member_cnt += getMisAllotTm4.get(k).getMember_cnt(); 
					sum_reg_00 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_00());
					sum_reg_01 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_01());
					sum_reg_02 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_02());
					sum_reg_03 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_03());
					sum_reg_04 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_04());
					sum_reg_05 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_05());
					sum_reg_06 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_06());
					sum_reg_07 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_07());
					sum_reg_08 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_08());
					sum_reg_09 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_09());
					sum_reg_10 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_10());
					sum_reg_11 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_11());
					sum_reg_12 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_12());
					sum_reg_13 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_13());
					sum_reg_14 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_14());
					sum_reg_15 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_15());
					sum_reg_16 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_16());
					sum_reg_17 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_17());
					sum_reg_18 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_18());
					sum_reg_19 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_19());
					sum_reg_20 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_20());
					sum_reg_21 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_21());
					sum_reg_22 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_22());
					sum_reg_23 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_23());
					sum_reg_24 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_24());
					sum_reg_25 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_25());
					sum_reg_26 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_26());
					sum_reg_27 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_27());
					sum_reg_28 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_28());
					sum_reg_29 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_29());
					sum_reg_30 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_30());
															
					sum_day_00 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_00());
					sum_day_01 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_01());
					sum_day_02 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_02());
					sum_day_03 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_03());
					sum_day_04 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_04());
					sum_day_05 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_05());
					sum_day_06 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_06());
					sum_day_07 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_07());
					sum_day_08 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_08());
					sum_day_09 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_09());
					sum_day_10 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_10());
					sum_day_11 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_11());
					sum_day_12 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_12());
					sum_day_13 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_13());
					sum_day_14 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_14());
					sum_day_15 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_15());
					sum_day_16 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_16());
					sum_day_17 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_17());
					sum_day_18 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_18());
					sum_day_19 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_19());
					sum_day_20 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_20());
					sum_day_21 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_21());
					sum_day_22 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_22());
					sum_day_23 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_23());
					sum_day_24 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_24());
					sum_day_25 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_25());
					sum_day_26 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_26());
					sum_day_27 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_27());
					sum_day_28 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_28());
					sum_day_29 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_29());
					sum_day_30 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_30());
					
					sum_reg_y += WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_y());
					sum_reg_mi += WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_mi());
					
					sum_cls_y += WebUtil.parseStringToLong(getMisAllotTm4.get(k).getCls_y());
					sum_cls_m += WebUtil.parseStringToLong(getMisAllotTm4.get(k).getCls_m());					
				}
			}
			
			sector4Bean.setMember_cnt(sector_member_cnt);			
			sector4Bean.setReg_00(Long.toString(sum_reg_00));
			sector4Bean.setReg_01(Long.toString(sum_reg_01));
			sector4Bean.setReg_02(Long.toString(sum_reg_02));
			sector4Bean.setReg_03(Long.toString(sum_reg_03));
			sector4Bean.setReg_04(Long.toString(sum_reg_04));
			sector4Bean.setReg_05(Long.toString(sum_reg_05));
			sector4Bean.setReg_06(Long.toString(sum_reg_06));
			sector4Bean.setReg_07(Long.toString(sum_reg_07));
			sector4Bean.setReg_08(Long.toString(sum_reg_08));
			sector4Bean.setReg_09(Long.toString(sum_reg_09));
			sector4Bean.setReg_10(Long.toString(sum_reg_10));
			sector4Bean.setReg_11(Long.toString(sum_reg_11));
			sector4Bean.setReg_12(Long.toString(sum_reg_12));
			sector4Bean.setReg_13(Long.toString(sum_reg_13));
			sector4Bean.setReg_14(Long.toString(sum_reg_14));
			sector4Bean.setReg_15(Long.toString(sum_reg_15));
			sector4Bean.setReg_16(Long.toString(sum_reg_16));
			sector4Bean.setReg_17(Long.toString(sum_reg_17));
			sector4Bean.setReg_18(Long.toString(sum_reg_18));
			sector4Bean.setReg_19(Long.toString(sum_reg_19));
			sector4Bean.setReg_20(Long.toString(sum_reg_20));
			sector4Bean.setReg_21(Long.toString(sum_reg_21));
			sector4Bean.setReg_22(Long.toString(sum_reg_22));
			sector4Bean.setReg_23(Long.toString(sum_reg_23));
			sector4Bean.setReg_24(Long.toString(sum_reg_24));
			sector4Bean.setReg_25(Long.toString(sum_reg_25));
			sector4Bean.setReg_26(Long.toString(sum_reg_26));
			sector4Bean.setReg_27(Long.toString(sum_reg_27));
			sector4Bean.setReg_28(Long.toString(sum_reg_28));
			sector4Bean.setReg_29(Long.toString(sum_reg_29));
			sector4Bean.setReg_30(Long.toString(sum_reg_30));
			
			sector4Bean.setDay_00(Long.toString(sum_day_00));
			sector4Bean.setDay_01(Long.toString(sum_day_01));
			sector4Bean.setDay_02(Long.toString(sum_day_02));
			sector4Bean.setDay_03(Long.toString(sum_day_03));
			sector4Bean.setDay_04(Long.toString(sum_day_04));
			sector4Bean.setDay_05(Long.toString(sum_day_05));
			sector4Bean.setDay_06(Long.toString(sum_day_06));
			sector4Bean.setDay_07(Long.toString(sum_day_07));
			sector4Bean.setDay_08(Long.toString(sum_day_08));
			sector4Bean.setDay_09(Long.toString(sum_day_09));
			sector4Bean.setDay_10(Long.toString(sum_day_10));
			sector4Bean.setDay_11(Long.toString(sum_day_11));
			sector4Bean.setDay_12(Long.toString(sum_day_12));
			sector4Bean.setDay_13(Long.toString(sum_day_13));
			sector4Bean.setDay_14(Long.toString(sum_day_14));
			sector4Bean.setDay_15(Long.toString(sum_day_15));
			sector4Bean.setDay_16(Long.toString(sum_day_16));
			sector4Bean.setDay_17(Long.toString(sum_day_17));
			sector4Bean.setDay_18(Long.toString(sum_day_18));
			sector4Bean.setDay_19(Long.toString(sum_day_19));
			sector4Bean.setDay_20(Long.toString(sum_day_20));
			sector4Bean.setDay_21(Long.toString(sum_day_21));
			sector4Bean.setDay_22(Long.toString(sum_day_22));
			sector4Bean.setDay_23(Long.toString(sum_day_23));
			sector4Bean.setDay_24(Long.toString(sum_day_24));
			sector4Bean.setDay_25(Long.toString(sum_day_25));
			sector4Bean.setDay_26(Long.toString(sum_day_26));
			sector4Bean.setDay_27(Long.toString(sum_day_27));
			sector4Bean.setDay_28(Long.toString(sum_day_28));
			sector4Bean.setDay_29(Long.toString(sum_day_29));
			sector4Bean.setDay_30(Long.toString(sum_day_30));
			
			sector4Bean.setReg_y(Long.toString(sum_reg_y));
			sector4Bean.setReg_mi(Long.toString(sum_reg_mi));
			sector4Bean.setCls_y(Long.toString(sum_cls_y));
			sector4Bean.setCls_m(Long.toString(sum_cls_m));
			
			TeamSector4ListVO.add(i, sector4Bean);
			
			//변수초기화
			sector_member_cnt = 0;
			sum_reg_00 = 0;
			sum_reg_01 = 0;
			sum_reg_02 = 0;
			sum_reg_03 = 0;
			sum_reg_04 = 0;
			sum_reg_05 = 0;
			sum_reg_06 = 0;
			sum_reg_07 = 0;
			sum_reg_08 = 0;
			sum_reg_09 = 0;
			sum_reg_10 = 0;
			sum_reg_11 = 0;
			sum_reg_12 = 0;
			sum_reg_13 = 0;
			sum_reg_14 = 0;
			sum_reg_15 = 0;
			sum_reg_16 = 0;
			sum_reg_17 = 0;
			sum_reg_18 = 0;
			sum_reg_19 = 0;
			sum_reg_20 = 0;
			sum_reg_21 = 0;
			sum_reg_22 = 0;
			sum_reg_23 = 0;
			sum_reg_24 = 0;
			sum_reg_25 = 0;
			sum_reg_26 = 0;
			sum_reg_27 = 0;
			sum_reg_28 = 0;
			sum_reg_29 = 0;
			sum_reg_30 = 0;
									
			sum_day_00 = 0;
			sum_day_01 = 0;
			sum_day_02 = 0;
			sum_day_03 = 0;
			sum_day_04 = 0;
			sum_day_05 = 0;
			sum_day_06 = 0;
			sum_day_07 = 0;
			sum_day_08 = 0;
			sum_day_09 = 0;
			sum_day_10 = 0;
			sum_day_11 = 0;
			sum_day_12 = 0;
			sum_day_13 = 0;
			sum_day_14 = 0;
			sum_day_15 = 0;
			sum_day_16 = 0;
			sum_day_17 = 0;
			sum_day_18 = 0;
			sum_day_19 = 0;
			sum_day_20 = 0;
			sum_day_21 = 0;
			sum_day_22 = 0;
			sum_day_23 = 0;
			sum_day_24 = 0;
			sum_day_25 = 0;
			sum_day_26 = 0;
			sum_day_27 = 0;
			sum_day_28 = 0;
			sum_day_29 = 0;
			sum_day_30 = 0;
						
			sum_reg_y = 0;			
			sum_reg_mi = 0;		
			sum_cls_y = 0;	
			sum_cls_m = 0;
			
		}
		
		model.addAttribute("TeamSector4ListVO", TeamSector4ListVO);		
		//4종 부분별 추가 끝
		
		model.addAttribute("nowVO",nowVO);
		
		return "/top_statistics/mis_allot_sector_ajax";
	}
	
	/**
	 * 전체 팀별 일일배당목록 Ajax
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/misAllotTmAjax")
	public String misAllotTmAjax(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {
		
		logger.info("======= misAllotTmAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		
		DateFormat tmpFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date tmpToday = new Date();
		String tmpNow_to = tmpFormat.format(tmpToday);

		inVO.setViewToDate(tmpNow_to);
		StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics30DaysDate", tmpNow_to);
		StatisticsNowVO nowVO2 = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate");
		nowVO.setNow_from(nowVO2.getNow_from());
		nowVO.setNow_to(nowVO2.getNow_to());
		nowVO.setYear_from(nowVO2.getYear_from());
		nowVO.setYear_to(nowVO2.getYear_to());
		
		//================================================
		// 필요 날짜 세팅
		//================================================
		String today = DateUtil.getTodayString();
		String bgnDe = DateUtil.addDate(today,-30);
		String endDe = DateUtil.addDate(today,1);
		String bgnYearDe = (Integer.parseInt(endDe.substring(0,4)) - 1)  + "1216";
		String endYearDe = endDe.substring(0,4) + "1216";
		
		paramMap.put("bgnDe", bgnDe);
		paramMap.put("endDe", endDe);
		paramMap.put("bgnYearDe", bgnYearDe);
		paramMap.put("endYearDe", endYearDe);
		paramMap.put("now_from", nowVO2.getNow_from());
		paramMap.put("now_to", nowVO2.getNow_to());
		
		//농작물 쿼리 추가로인한 셋팅
		nowVO.setBgnYearDe(bgnYearDe);
		nowVO.setEndYearDe(endYearDe);
		nowVO.setBgnDe(bgnDe);
		nowVO.setEndDe(endDe);
		
		List<MisRegTmVO> getMisAllotTm1 = sqlSession.selectList("MisAllotTmMapper.newGetMisAllotTm1", nowVO);
		
		//서면심사 팀 계산값 저장용 임시 Map
		Map<String, Object> written_team;
		
		//농작물 팀 계산값 저장용 임시 Map
		Map<String, Object> prim_team;
		
		//보고서에 농작물 보고서 카운트를 추가하기위한 임시 변수
		int nRegY = 0;
		int nClsY = 0;
		int nClsM = 0;
		int nRegMi = 0;		
		int nReg30=0;
		int nReg29=0;
		int nReg28=0;
		int nReg27=0;
		int nReg26=0;
		int nReg25=0;
		int nReg24=0;
		int nReg23=0;
		int nReg22=0;
		int nReg21=0;
		int nReg20=0;
		int nReg19=0;
		int nReg18=0;
		int nReg17=0;
		int nReg16=0;
		int nReg15=0;
		int nReg14=0;
		int nReg13=0;
		int nReg12=0;
		int nReg11=0;
		int nReg10=0;
		int nReg09=0;
		int nReg08=0;
		int nReg07=0;
		int nReg06=0;
		int nReg05=0;
		int nReg04=0;
		int nReg03=0;
		int nReg02=0;
		int nReg01=0;
		int nReg00=0;
		
		int nDay30=0;
		int nDay29=0;
		int nDay28=0;
		int nDay27=0;
		int nDay26=0;
		int nDay25=0;
		int nDay24=0;
		int nDay23=0;
		int nDay22=0;
		int nDay21=0;
		int nDay20=0;
		int nDay19=0;
		int nDay18=0;
		int nDay17=0;
		int nDay16=0;
		int nDay15=0;
		int nDay14=0;
		int nDay13=0;
		int nDay12=0;
		int nDay11=0;
		int nDay10=0;
		int nDay09=0;
		int nDay08=0;
		int nDay07=0;
		int nDay06=0;
		int nDay05=0;
		int nDay04=0;
		int nDay03=0;
		int nDay02=0;
		int nDay01=0;
		int nDay00=0;
		
		String sChk_writtenteam = "0";
		
		for(int i=0; i < getMisAllotTm1.size(); i++) {
			sChk_writtenteam = getMisAllotTm1.get(i).getTeam_written().toString();
			
			//서면심사팀인 경우만 재계산해준다.
			if("1".equals(sChk_writtenteam)) {
				
				paramMap.put("team_id", getMisAllotTm1.get(i).getTeam_id());
				
				written_team = sqlSession.selectOne("MisAllotTmMbrMapper.selectMisAllotTmTeam1WrittenList", paramMap);
				//서면심사 팀별 년간 수임, 종결
				getMisAllotTm1.get(i).setReg_y(written_team.get("regY").toString());
				getMisAllotTm1.get(i).setCls_y(written_team.get("clsY").toString());				
				
				//서면심사 팀별 월간 종결
				getMisAllotTm1.get(i).setCls_m(written_team.get("clsM").toString());
				
				//서면심사 팀별 미결
				getMisAllotTm1.get(i).setReg_mi(written_team.get("regMi").toString());
				
				//서면심사 팀별 일일 수임
				getMisAllotTm1.get(i).setReg_00(written_team.get("reg31").toString());
				getMisAllotTm1.get(i).setReg_01(written_team.get("reg30").toString());
				getMisAllotTm1.get(i).setReg_02(written_team.get("reg29").toString());
				getMisAllotTm1.get(i).setReg_03(written_team.get("reg28").toString());
				getMisAllotTm1.get(i).setReg_04(written_team.get("reg27").toString());
				getMisAllotTm1.get(i).setReg_05(written_team.get("reg26").toString());
				getMisAllotTm1.get(i).setReg_06(written_team.get("reg25").toString());
				getMisAllotTm1.get(i).setReg_07(written_team.get("reg24").toString());
				getMisAllotTm1.get(i).setReg_08(written_team.get("reg23").toString());
				getMisAllotTm1.get(i).setReg_09(written_team.get("reg22").toString());
				getMisAllotTm1.get(i).setReg_10(written_team.get("reg21").toString());
				getMisAllotTm1.get(i).setReg_11(written_team.get("reg20").toString());
				getMisAllotTm1.get(i).setReg_12(written_team.get("reg19").toString());
				getMisAllotTm1.get(i).setReg_13(written_team.get("reg18").toString());
				getMisAllotTm1.get(i).setReg_14(written_team.get("reg17").toString());
				getMisAllotTm1.get(i).setReg_15(written_team.get("reg16").toString());
				getMisAllotTm1.get(i).setReg_16(written_team.get("reg15").toString());
				getMisAllotTm1.get(i).setReg_17(written_team.get("reg14").toString());
				getMisAllotTm1.get(i).setReg_18(written_team.get("reg13").toString());
				getMisAllotTm1.get(i).setReg_19(written_team.get("reg12").toString());
				getMisAllotTm1.get(i).setReg_20(written_team.get("reg11").toString());
				getMisAllotTm1.get(i).setReg_21(written_team.get("reg10").toString());
				getMisAllotTm1.get(i).setReg_22(written_team.get("reg09").toString());
				getMisAllotTm1.get(i).setReg_23(written_team.get("reg08").toString());
				getMisAllotTm1.get(i).setReg_24(written_team.get("reg07").toString());
				getMisAllotTm1.get(i).setReg_25(written_team.get("reg06").toString());
				getMisAllotTm1.get(i).setReg_26(written_team.get("reg05").toString());
				getMisAllotTm1.get(i).setReg_27(written_team.get("reg04").toString());
				getMisAllotTm1.get(i).setReg_28(written_team.get("reg03").toString());
				getMisAllotTm1.get(i).setReg_29(written_team.get("reg02").toString());
				
				//서면심사 팀별 일일 종결
				getMisAllotTm1.get(i).setDay_00(written_team.get("day31").toString());
				getMisAllotTm1.get(i).setDay_01(written_team.get("day30").toString());
				getMisAllotTm1.get(i).setDay_02(written_team.get("day29").toString());
				getMisAllotTm1.get(i).setDay_03(written_team.get("day28").toString());
				getMisAllotTm1.get(i).setDay_04(written_team.get("day27").toString());
				getMisAllotTm1.get(i).setDay_05(written_team.get("day26").toString());
				getMisAllotTm1.get(i).setDay_06(written_team.get("day25").toString());
				getMisAllotTm1.get(i).setDay_07(written_team.get("day24").toString());
				getMisAllotTm1.get(i).setDay_08(written_team.get("day23").toString());
				getMisAllotTm1.get(i).setDay_09(written_team.get("day22").toString());
				getMisAllotTm1.get(i).setDay_10(written_team.get("day21").toString());
				getMisAllotTm1.get(i).setDay_11(written_team.get("day20").toString());
				getMisAllotTm1.get(i).setDay_12(written_team.get("day19").toString());
				getMisAllotTm1.get(i).setDay_13(written_team.get("day18").toString());
				getMisAllotTm1.get(i).setDay_14(written_team.get("day17").toString());
				getMisAllotTm1.get(i).setDay_15(written_team.get("day16").toString());
				getMisAllotTm1.get(i).setDay_16(written_team.get("day15").toString());
				getMisAllotTm1.get(i).setDay_17(written_team.get("day14").toString());
				getMisAllotTm1.get(i).setDay_18(written_team.get("day13").toString());
				getMisAllotTm1.get(i).setDay_19(written_team.get("day12").toString());
				getMisAllotTm1.get(i).setDay_20(written_team.get("day11").toString());
				getMisAllotTm1.get(i).setDay_21(written_team.get("day10").toString());
				getMisAllotTm1.get(i).setDay_22(written_team.get("day09").toString());
				getMisAllotTm1.get(i).setDay_23(written_team.get("day08").toString());
				getMisAllotTm1.get(i).setDay_24(written_team.get("day07").toString());
				getMisAllotTm1.get(i).setDay_25(written_team.get("day06").toString());
				getMisAllotTm1.get(i).setDay_26(written_team.get("day05").toString());
				getMisAllotTm1.get(i).setDay_27(written_team.get("day04").toString());
				getMisAllotTm1.get(i).setDay_28(written_team.get("day03").toString());
				getMisAllotTm1.get(i).setDay_29(written_team.get("day02").toString());
			}else{				//서면심사가 아닌경우 농작물 카운트를 더해준다.
				String sTeam_id = getMisAllotTm1.get(i).getTeam_id();
				
				nowVO.setTeam_id(sTeam_id);
				
				//농작물의 일일배당 현황 데이터를 가져온다.				
				prim_team = sqlSession.selectOne("MisAllotTmMbrMapper.selectMisAllotTmTeam1PrimList", nowVO);
				
				//농작물 팀별 일일 수임				
				nReg30 = Integer.parseInt( getMisAllotTm1.get(i).getReg_30().toString() ) + Integer.parseInt( prim_team.get("reg30").toString() );
				nReg29 = Integer.parseInt( getMisAllotTm1.get(i).getReg_29().toString() ) + Integer.parseInt( prim_team.get("reg29").toString() );
				nReg28 = Integer.parseInt( getMisAllotTm1.get(i).getReg_28().toString() ) + Integer.parseInt( prim_team.get("reg28").toString() );
				nReg27 = Integer.parseInt( getMisAllotTm1.get(i).getReg_27().toString() ) + Integer.parseInt( prim_team.get("reg27").toString() );
				nReg26 = Integer.parseInt( getMisAllotTm1.get(i).getReg_26().toString() ) + Integer.parseInt( prim_team.get("reg26").toString() );
				nReg25 = Integer.parseInt( getMisAllotTm1.get(i).getReg_25().toString() ) + Integer.parseInt( prim_team.get("reg25").toString() );
				nReg24 = Integer.parseInt( getMisAllotTm1.get(i).getReg_24().toString() ) + Integer.parseInt( prim_team.get("reg24").toString() );
				nReg23 = Integer.parseInt( getMisAllotTm1.get(i).getReg_23().toString() ) + Integer.parseInt( prim_team.get("reg23").toString() );
				nReg22 = Integer.parseInt( getMisAllotTm1.get(i).getReg_22().toString() ) + Integer.parseInt( prim_team.get("reg22").toString() );
				nReg21 = Integer.parseInt( getMisAllotTm1.get(i).getReg_21().toString() ) + Integer.parseInt( prim_team.get("reg21").toString() );
				nReg20 = Integer.parseInt( getMisAllotTm1.get(i).getReg_20().toString() ) + Integer.parseInt( prim_team.get("reg20").toString() );
				nReg19 = Integer.parseInt( getMisAllotTm1.get(i).getReg_19().toString() ) + Integer.parseInt( prim_team.get("reg19").toString() );
				nReg18 = Integer.parseInt( getMisAllotTm1.get(i).getReg_18().toString() ) + Integer.parseInt( prim_team.get("reg18").toString() );
				nReg17 = Integer.parseInt( getMisAllotTm1.get(i).getReg_17().toString() ) + Integer.parseInt( prim_team.get("reg17").toString() );
				nReg16 = Integer.parseInt( getMisAllotTm1.get(i).getReg_16().toString() ) + Integer.parseInt( prim_team.get("reg16").toString() );
				nReg15 = Integer.parseInt( getMisAllotTm1.get(i).getReg_15().toString() ) + Integer.parseInt( prim_team.get("reg15").toString() );
				nReg14 = Integer.parseInt( getMisAllotTm1.get(i).getReg_14().toString() ) + Integer.parseInt( prim_team.get("reg14").toString() );
				nReg13 = Integer.parseInt( getMisAllotTm1.get(i).getReg_13().toString() ) + Integer.parseInt( prim_team.get("reg13").toString() );
				nReg12 = Integer.parseInt( getMisAllotTm1.get(i).getReg_12().toString() ) + Integer.parseInt( prim_team.get("reg12").toString() );
				nReg11 = Integer.parseInt( getMisAllotTm1.get(i).getReg_11().toString() ) + Integer.parseInt( prim_team.get("reg11").toString() );
				nReg10 = Integer.parseInt( getMisAllotTm1.get(i).getReg_10().toString() ) + Integer.parseInt( prim_team.get("reg10").toString() );
				nReg09 = Integer.parseInt( getMisAllotTm1.get(i).getReg_09().toString() ) + Integer.parseInt( prim_team.get("reg09").toString() );
				nReg08 = Integer.parseInt( getMisAllotTm1.get(i).getReg_08().toString() ) + Integer.parseInt( prim_team.get("reg08").toString() );
				nReg07 = Integer.parseInt( getMisAllotTm1.get(i).getReg_07().toString() ) + Integer.parseInt( prim_team.get("reg07").toString() );
				nReg06 = Integer.parseInt( getMisAllotTm1.get(i).getReg_06().toString() ) + Integer.parseInt( prim_team.get("reg06").toString() );
				nReg05 = Integer.parseInt( getMisAllotTm1.get(i).getReg_05().toString() ) + Integer.parseInt( prim_team.get("reg05").toString() );
				nReg04 = Integer.parseInt( getMisAllotTm1.get(i).getReg_04().toString() ) + Integer.parseInt( prim_team.get("reg04").toString() );
				nReg03 = Integer.parseInt( getMisAllotTm1.get(i).getReg_03().toString() ) + Integer.parseInt( prim_team.get("reg03").toString() );
				nReg02 = Integer.parseInt( getMisAllotTm1.get(i).getReg_02().toString() ) + Integer.parseInt( prim_team.get("reg02").toString() );
				nReg01 = Integer.parseInt( getMisAllotTm1.get(i).getReg_01().toString() ) + Integer.parseInt( prim_team.get("reg01").toString() );
				nReg00 = Integer.parseInt( getMisAllotTm1.get(i).getReg_00().toString() ) + Integer.parseInt( prim_team.get("reg00").toString() );

				nDay30 = Integer.parseInt( getMisAllotTm1.get(i).getDay_30().toString() ) + Integer.parseInt( prim_team.get("day30").toString() );
				nDay29 = Integer.parseInt( getMisAllotTm1.get(i).getDay_29().toString() ) + Integer.parseInt( prim_team.get("day29").toString() );
				nDay28 = Integer.parseInt( getMisAllotTm1.get(i).getDay_28().toString() ) + Integer.parseInt( prim_team.get("day28").toString() );
				nDay27 = Integer.parseInt( getMisAllotTm1.get(i).getDay_27().toString() ) + Integer.parseInt( prim_team.get("day27").toString() );
				nDay26 = Integer.parseInt( getMisAllotTm1.get(i).getDay_26().toString() ) + Integer.parseInt( prim_team.get("day26").toString() );
				nDay25 = Integer.parseInt( getMisAllotTm1.get(i).getDay_25().toString() ) + Integer.parseInt( prim_team.get("day25").toString() );
				nDay24 = Integer.parseInt( getMisAllotTm1.get(i).getDay_24().toString() ) + Integer.parseInt( prim_team.get("day24").toString() );
				nDay23 = Integer.parseInt( getMisAllotTm1.get(i).getDay_23().toString() ) + Integer.parseInt( prim_team.get("day23").toString() );
				nDay22 = Integer.parseInt( getMisAllotTm1.get(i).getDay_22().toString() ) + Integer.parseInt( prim_team.get("day22").toString() );
				nDay21 = Integer.parseInt( getMisAllotTm1.get(i).getDay_21().toString() ) + Integer.parseInt( prim_team.get("day21").toString() );
				nDay20 = Integer.parseInt( getMisAllotTm1.get(i).getDay_20().toString() ) + Integer.parseInt( prim_team.get("day20").toString() );
				nDay19 = Integer.parseInt( getMisAllotTm1.get(i).getDay_19().toString() ) + Integer.parseInt( prim_team.get("day19").toString() );
				nDay18 = Integer.parseInt( getMisAllotTm1.get(i).getDay_18().toString() ) + Integer.parseInt( prim_team.get("day18").toString() );
				nDay17 = Integer.parseInt( getMisAllotTm1.get(i).getDay_17().toString() ) + Integer.parseInt( prim_team.get("day17").toString() );
				nDay16 = Integer.parseInt( getMisAllotTm1.get(i).getDay_16().toString() ) + Integer.parseInt( prim_team.get("day16").toString() );
				nDay15 = Integer.parseInt( getMisAllotTm1.get(i).getDay_15().toString() ) + Integer.parseInt( prim_team.get("day15").toString() );
				nDay14 = Integer.parseInt( getMisAllotTm1.get(i).getDay_14().toString() ) + Integer.parseInt( prim_team.get("day14").toString() );
				nDay13 = Integer.parseInt( getMisAllotTm1.get(i).getDay_13().toString() ) + Integer.parseInt( prim_team.get("day13").toString() );
				nDay12 = Integer.parseInt( getMisAllotTm1.get(i).getDay_12().toString() ) + Integer.parseInt( prim_team.get("day12").toString() );
				nDay11 = Integer.parseInt( getMisAllotTm1.get(i).getDay_11().toString() ) + Integer.parseInt( prim_team.get("day11").toString() );
				nDay10 = Integer.parseInt( getMisAllotTm1.get(i).getDay_10().toString() ) + Integer.parseInt( prim_team.get("day10").toString() );
				nDay09 = Integer.parseInt( getMisAllotTm1.get(i).getDay_09().toString() ) + Integer.parseInt( prim_team.get("day09").toString() );
				nDay08 = Integer.parseInt( getMisAllotTm1.get(i).getDay_08().toString() ) + Integer.parseInt( prim_team.get("day08").toString() );
				nDay07 = Integer.parseInt( getMisAllotTm1.get(i).getDay_07().toString() ) + Integer.parseInt( prim_team.get("day07").toString() );
				nDay06 = Integer.parseInt( getMisAllotTm1.get(i).getDay_06().toString() ) + Integer.parseInt( prim_team.get("day06").toString() );
				nDay05 = Integer.parseInt( getMisAllotTm1.get(i).getDay_05().toString() ) + Integer.parseInt( prim_team.get("day05").toString() );
				nDay04 = Integer.parseInt( getMisAllotTm1.get(i).getDay_04().toString() ) + Integer.parseInt( prim_team.get("day04").toString() );
				nDay03 = Integer.parseInt( getMisAllotTm1.get(i).getDay_03().toString() ) + Integer.parseInt( prim_team.get("day03").toString() );
				nDay02 = Integer.parseInt( getMisAllotTm1.get(i).getDay_02().toString() ) + Integer.parseInt( prim_team.get("day02").toString() );
				nDay01 = Integer.parseInt( getMisAllotTm1.get(i).getDay_01().toString() ) + Integer.parseInt( prim_team.get("day01").toString() );
				nDay00 = Integer.parseInt( getMisAllotTm1.get(i).getDay_00().toString() ) + Integer.parseInt( prim_team.get("day00").toString() );
				
				getMisAllotTm1.get(i).setReg_30(String.valueOf(nReg30));
				getMisAllotTm1.get(i).setReg_29(String.valueOf(nReg29));
				getMisAllotTm1.get(i).setReg_28(String.valueOf(nReg28));
				getMisAllotTm1.get(i).setReg_27(String.valueOf(nReg27));
				getMisAllotTm1.get(i).setReg_26(String.valueOf(nReg26));
				getMisAllotTm1.get(i).setReg_25(String.valueOf(nReg25));
				getMisAllotTm1.get(i).setReg_24(String.valueOf(nReg24));
				getMisAllotTm1.get(i).setReg_23(String.valueOf(nReg23));
				getMisAllotTm1.get(i).setReg_22(String.valueOf(nReg22));
				getMisAllotTm1.get(i).setReg_21(String.valueOf(nReg21));
				getMisAllotTm1.get(i).setReg_20(String.valueOf(nReg20));
				getMisAllotTm1.get(i).setReg_19(String.valueOf(nReg19));
				getMisAllotTm1.get(i).setReg_18(String.valueOf(nReg18));
				getMisAllotTm1.get(i).setReg_17(String.valueOf(nReg17));
				getMisAllotTm1.get(i).setReg_16(String.valueOf(nReg16));
				getMisAllotTm1.get(i).setReg_15(String.valueOf(nReg15));
				getMisAllotTm1.get(i).setReg_14(String.valueOf(nReg14));
				getMisAllotTm1.get(i).setReg_13(String.valueOf(nReg13));
				getMisAllotTm1.get(i).setReg_12(String.valueOf(nReg12));
				getMisAllotTm1.get(i).setReg_11(String.valueOf(nReg11));
				getMisAllotTm1.get(i).setReg_10(String.valueOf(nReg10));
				getMisAllotTm1.get(i).setReg_09(String.valueOf(nReg09));
				getMisAllotTm1.get(i).setReg_08(String.valueOf(nReg08));
				getMisAllotTm1.get(i).setReg_07(String.valueOf(nReg07));
				getMisAllotTm1.get(i).setReg_06(String.valueOf(nReg06));
				getMisAllotTm1.get(i).setReg_05(String.valueOf(nReg05));
				getMisAllotTm1.get(i).setReg_04(String.valueOf(nReg04));
				getMisAllotTm1.get(i).setReg_03(String.valueOf(nReg03));
				getMisAllotTm1.get(i).setReg_02(String.valueOf(nReg02));
				getMisAllotTm1.get(i).setReg_01(String.valueOf(nReg01));
				getMisAllotTm1.get(i).setReg_00(String.valueOf(nReg00));
				
				getMisAllotTm1.get(i).setDay_30(String.valueOf(nDay30));
				getMisAllotTm1.get(i).setDay_29(String.valueOf(nDay29));
				getMisAllotTm1.get(i).setDay_28(String.valueOf(nDay28));
				getMisAllotTm1.get(i).setDay_27(String.valueOf(nDay27));
				getMisAllotTm1.get(i).setDay_26(String.valueOf(nDay26));
				getMisAllotTm1.get(i).setDay_25(String.valueOf(nDay25));
				getMisAllotTm1.get(i).setDay_24(String.valueOf(nDay24));
				getMisAllotTm1.get(i).setDay_23(String.valueOf(nDay23));
				getMisAllotTm1.get(i).setDay_22(String.valueOf(nDay22));
				getMisAllotTm1.get(i).setDay_21(String.valueOf(nDay21));
				getMisAllotTm1.get(i).setDay_20(String.valueOf(nDay20));
				getMisAllotTm1.get(i).setDay_19(String.valueOf(nDay19));
				getMisAllotTm1.get(i).setDay_18(String.valueOf(nDay18));
				getMisAllotTm1.get(i).setDay_17(String.valueOf(nDay17));
				getMisAllotTm1.get(i).setDay_16(String.valueOf(nDay16));
				getMisAllotTm1.get(i).setDay_15(String.valueOf(nDay15));
				getMisAllotTm1.get(i).setDay_14(String.valueOf(nDay14));
				getMisAllotTm1.get(i).setDay_13(String.valueOf(nDay13));
				getMisAllotTm1.get(i).setDay_12(String.valueOf(nDay12));
				getMisAllotTm1.get(i).setDay_11(String.valueOf(nDay11));
				getMisAllotTm1.get(i).setDay_10(String.valueOf(nDay10));
				getMisAllotTm1.get(i).setDay_09(String.valueOf(nDay09));
				getMisAllotTm1.get(i).setDay_08(String.valueOf(nDay08));
				getMisAllotTm1.get(i).setDay_07(String.valueOf(nDay07));
				getMisAllotTm1.get(i).setDay_06(String.valueOf(nDay06));
				getMisAllotTm1.get(i).setDay_05(String.valueOf(nDay05));
				getMisAllotTm1.get(i).setDay_04(String.valueOf(nDay04));
				getMisAllotTm1.get(i).setDay_03(String.valueOf(nDay03));
				getMisAllotTm1.get(i).setDay_02(String.valueOf(nDay02));
				getMisAllotTm1.get(i).setDay_01(String.valueOf(nDay01));
				getMisAllotTm1.get(i).setDay_00(String.valueOf(nDay00));				
				
				//농작물 팀별 년간 수임, 종결				
				nRegY = Integer.parseInt( getMisAllotTm1.get(i).getReg_y().toString() ) + Integer.parseInt( prim_team.get("regY").toString() );
				getMisAllotTm1.get(i).setReg_y(String.valueOf(nRegY));
				nClsY = Integer.parseInt( getMisAllotTm1.get(i).getCls_y().toString()) + Integer.parseInt( prim_team.get("clsY").toString() );
				getMisAllotTm1.get(i).setCls_y(String.valueOf(nClsY));				
				
				//농작물 팀별 월간 종결
				nClsM = Integer.parseInt( getMisAllotTm1.get(i).getCls_m().toString() ) + Integer.parseInt( prim_team.get("clsM").toString() );				
				getMisAllotTm1.get(i).setCls_m(String.valueOf(nClsM));
				
				//농작물 팀별 미결
				nRegMi = Integer.parseInt( getMisAllotTm1.get(i).getReg_mi().toString() ) + Integer.parseInt( prim_team.get("regMi").toString() );
				getMisAllotTm1.get(i).setReg_mi(String.valueOf(nRegMi));				
			}
		}
		
		model.addAttribute("getMisAllotTm1",getMisAllotTm1);
		List<MisRegTmVO> getMisAllotTm4 = sqlSession.selectList("MisAllotTmMapper.newGetMisAllotTm4", nowVO);
		model.addAttribute("getMisAllotTm4",getMisAllotTm4);
		
		model.addAttribute("nowVO",nowVO);
		
		return "/top_statistics/mis_allot_tm_ajax";
	}
	
	/**
	 * 전체 보험사별 일일배당목록 Ajax
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/misAllotPtnrNewAjax")
	public String misAllotPtnrNewAjax(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {
		
		logger.info("======= misAllotPtnrNewAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		
		DateFormat tmpFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date tmpToday = new Date();
		String tmpNow_to = tmpFormat.format(tmpToday);

		inVO.setViewToDate(tmpNow_to);
		StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics30DaysDate", tmpNow_to);
		StatisticsNowVO nowVO2 = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate");
		nowVO.setNow_from(nowVO2.getNow_from());
		nowVO.setNow_to(nowVO2.getNow_to());
		nowVO.setYear_from(nowVO2.getYear_from());
		nowVO.setYear_to(nowVO2.getYear_to());
		
		//================================================
		// 필요 날짜 세팅
		//================================================
		String today = DateUtil.getTodayString();
		String bgnDe = DateUtil.addDate(today,-30);
		String endDe = DateUtil.addDate(today,1);
		String bgnYearDe = (Integer.parseInt(endDe.substring(0,4)) - 1)  + "1216";
		String endYearDe = endDe.substring(0,4) + "1216";
		
		paramMap.put("bgnDe", bgnDe);
		paramMap.put("endDe", endDe);
		paramMap.put("bgnYearDe", bgnYearDe);
		paramMap.put("endYearDe", endYearDe);
		paramMap.put("now_from", nowVO2.getNow_from());
		paramMap.put("now_to", nowVO2.getNow_to());
		
		//농작물 쿼리 추가로인한 셋팅
		nowVO.setBgnYearDe(bgnYearDe);
		nowVO.setEndYearDe(endYearDe);
		nowVO.setBgnDe(bgnDe);
		nowVO.setEndDe(endDe);
		
		//물보험 조사		
		nowVO.setDiv_type("5");
		List<Map<String, Object>> ptnrIdSubList = sqlSession.selectList("MisAllotTmMbrMapper.selectMisAllotPtnrListNew", nowVO);
		model.addAttribute("ptnrIdSubList", ptnrIdSubList);
		
		//물보험 좌측 Type rowspan 구하기
		String sBeforeId = "";
		String sPtnrId = "";
		int nRowCnt = 0;
		int nLeftRowCnt = 0;
		int nLeftRowCnt_10 = 0;
		int nLeftRowCnt_15 = 0;
		
		for( int i=0; i < ptnrIdSubList.size(); i++ ) {			
			sPtnrId = String.valueOf(ptnrIdSubList.get(i).get("ptnrId"));
			nRowCnt = Integer.parseInt(String.valueOf(ptnrIdSubList.get(i).get("rowCnt")));			
			
			if( !sBeforeId.equals(sPtnrId) && nRowCnt > 1 ) {			//보험사 아이디가 다르면서 소계가 존재하는경우 증가
				nLeftRowCnt++;
			}
			sBeforeId = sPtnrId;			
		}		
		nLeftRowCnt = nLeftRowCnt + ptnrIdSubList.size();		
		model.addAttribute("leftRow", nLeftRowCnt);
		
		//물보험 심사
		nowVO.setDiv_type("10");
		List<Map<String, Object>> ptnrIdSubList_10 = sqlSession.selectList("MisAllotTmMbrMapper.selectMisAllotPtnrListNew", nowVO);
		model.addAttribute("ptnrIdSubList_10", ptnrIdSubList_10);
		
		for( int i=0; i < ptnrIdSubList_10.size(); i++ ) {			
			sPtnrId = String.valueOf(ptnrIdSubList_10.get(i).get("ptnrId"));
			nRowCnt = Integer.parseInt(String.valueOf(ptnrIdSubList_10.get(i).get("rowCnt")));			
			
			if( !sBeforeId.equals(sPtnrId) && nRowCnt > 1 ) {			//보험사 아이디가 다르면서 소계가 존재하는경우 증가
				nLeftRowCnt_10++;
			}
			sBeforeId = sPtnrId;
		}		
		nLeftRowCnt_10 = nLeftRowCnt_10 + ptnrIdSubList_10.size();		
		model.addAttribute("leftRow_10", nLeftRowCnt_10);
		
		//물보험 기타		
		nowVO.setDiv_type("15");
		List<Map<String, Object>> ptnrIdSubList_15 = sqlSession.selectList("MisAllotTmMbrMapper.selectMisAllotPtnrListNew", nowVO);
		model.addAttribute("ptnrIdSubList_15", ptnrIdSubList_15);
		
		for( int i=0; i < ptnrIdSubList_15.size(); i++ ) {			
			sPtnrId = String.valueOf(ptnrIdSubList_15.get(i).get("ptnrId"));
			nRowCnt = Integer.parseInt(String.valueOf(ptnrIdSubList_15.get(i).get("rowCnt")));			
			
			if( !sBeforeId.equals(sPtnrId) && nRowCnt > 1 ) {			//보험사 아이디가 다르면서 소계가 존재하는경우 증가
				nLeftRowCnt_15++;
			}
			sBeforeId = sPtnrId;
		}		
		nLeftRowCnt_15 = nLeftRowCnt_15 + ptnrIdSubList_15.size();		
		model.addAttribute("leftRow_15", nLeftRowCnt_15);
		
		//System.out.println( nLeftRowCnt + " : "+nLeftRowCnt_10+" : "+nLeftRowCnt_15);
		
		//보험사 상세구분 수임통계 끝
		
		model.addAttribute("nowVO",nowVO);
		
		return "/top_statistics/mis_allot_ptnr_new_ajax";
		
	}
	
	/**
	 * 전체 보험사별 일일배당목록 Ajax
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/misAllotPtnrAjax")
	public String misAllotPtnrAjax(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {
		
		logger.info("======= misAllotPtnrAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		
		DateFormat tmpFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date tmpToday = new Date();
		String tmpNow_to = tmpFormat.format(tmpToday);

		inVO.setViewToDate(tmpNow_to);
		StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics30DaysDate", tmpNow_to);
		StatisticsNowVO nowVO2 = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate");
		nowVO.setNow_from(nowVO2.getNow_from());
		nowVO.setNow_to(nowVO2.getNow_to());
		nowVO.setYear_from(nowVO2.getYear_from());
		nowVO.setYear_to(nowVO2.getYear_to());
		
		//================================================
		// 필요 날짜 세팅
		//================================================
		String today = DateUtil.getTodayString();
		String bgnDe = DateUtil.addDate(today,-30);
		String endDe = DateUtil.addDate(today,1);
		String bgnYearDe = (Integer.parseInt(endDe.substring(0,4)) - 1)  + "1216";
		String endYearDe = endDe.substring(0,4) + "1216";
		
		paramMap.put("bgnDe", bgnDe);
		paramMap.put("endDe", endDe);
		paramMap.put("bgnYearDe", bgnYearDe);
		paramMap.put("endYearDe", endYearDe);
		paramMap.put("now_from", nowVO2.getNow_from());
		paramMap.put("now_to", nowVO2.getNow_to());
		
		//농작물 쿼리 추가로인한 셋팅
		nowVO.setBgnYearDe(bgnYearDe);
		nowVO.setEndYearDe(endYearDe);
		nowVO.setBgnDe(bgnDe);
		nowVO.setEndDe(endDe);
		
		//보험사 상세구분 수임통계 시작
		List<Map<String, Object>> ptnrIdSubList = sqlSession.selectList("MisAllotTmMbrMapper.selectMisAllotPtnrList", nowVO);
		model.addAttribute("ptnrIdSubList", ptnrIdSubList);		
		//보험사 상세구분 수임통계 끝
		
		model.addAttribute("nowVO",nowVO);
		
		return "/top_statistics/mis_allot_ptnr_ajax";
		
	}
	
	/**
	 * 전체 개인별 일일배당목록 Ajax
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/misAllotTmMbrAjax")
	public String misAllotTmMbrAjax(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {
		
		logger.info("======= misAllotTmMbrAjax =======");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//CommonUtils.printMap(paramMap);
		
		DateFormat tmpFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date tmpToday = new Date();
		String tmpNow_to = tmpFormat.format(tmpToday);

		inVO.setViewToDate(tmpNow_to);
		StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics30DaysDate", tmpNow_to);
		StatisticsNowVO nowVO2 = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate");
		nowVO.setNow_from(nowVO2.getNow_from());
		nowVO.setNow_to(nowVO2.getNow_to());
		nowVO.setYear_from(nowVO2.getYear_from());
		nowVO.setYear_to(nowVO2.getYear_to());
		
		//================================================
		// 필요 날짜 세팅
		//================================================
		String today = DateUtil.getTodayString();
		String bgnDe = DateUtil.addDate(today,-30);
		String endDe = DateUtil.addDate(today,1);
		String bgnYearDe = (Integer.parseInt(endDe.substring(0,4)) - 1)  + "1216";
		String endYearDe = endDe.substring(0,4) + "1216";
		
		paramMap.put("bgnDe", bgnDe);
		paramMap.put("endDe", endDe);
		paramMap.put("bgnYearDe", bgnYearDe);
		paramMap.put("endYearDe", endYearDe);
		paramMap.put("now_from", nowVO2.getNow_from());
		paramMap.put("now_to", nowVO2.getNow_to());
		
		//농작물 쿼리 추가로인한 셋팅
		nowVO.setBgnYearDe(bgnYearDe);
		nowVO.setEndYearDe(endYearDe);
		nowVO.setBgnDe(bgnDe);
		nowVO.setEndDe(endDe);
		
		List<Map<String, Object>> memList = sqlSession.selectList("MisAllotTmMbrMapper.selectMisAllotTmMbr1List", paramMap);
		
		String nTemp_UserNo = "";
		String sChk_written = "0";
		
		Map<String, Object> written_member;
		
		//농작물 팀 계산값 저장용 임시 Map
		Map<String, Object> prim_user;
		
		//보고서에 농작물 보고서 카운트를 추가하기위한 임시 변수
		int nRegY = 0;
		int nClsY = 0;
		int nClsM = 0;
		int nRegMi = 0;		
		int nReg30=0;
		int nReg29=0;
		int nReg28=0;
		int nReg27=0;
		int nReg26=0;
		int nReg25=0;
		int nReg24=0;
		int nReg23=0;
		int nReg22=0;
		int nReg21=0;
		int nReg20=0;
		int nReg19=0;
		int nReg18=0;
		int nReg17=0;
		int nReg16=0;
		int nReg15=0;
		int nReg14=0;
		int nReg13=0;
		int nReg12=0;
		int nReg11=0;
		int nReg10=0;
		int nReg09=0;
		int nReg08=0;
		int nReg07=0;
		int nReg06=0;
		int nReg05=0;
		int nReg04=0;
		int nReg03=0;
		int nReg02=0;
		int nReg01=0;
		int nReg00=0;
		
		int nDay30=0;
		int nDay29=0;
		int nDay28=0;
		int nDay27=0;
		int nDay26=0;
		int nDay25=0;
		int nDay24=0;
		int nDay23=0;
		int nDay22=0;
		int nDay21=0;
		int nDay20=0;
		int nDay19=0;
		int nDay18=0;
		int nDay17=0;
		int nDay16=0;
		int nDay15=0;
		int nDay14=0;
		int nDay13=0;
		int nDay12=0;
		int nDay11=0;
		int nDay10=0;
		int nDay09=0;
		int nDay08=0;
		int nDay07=0;
		int nDay06=0;
		int nDay05=0;
		int nDay04=0;
		int nDay03=0;
		int nDay02=0;
		int nDay01=0;
		int nDay00=0;
		
		for( int i=0; i < memList.size(); i++){
			sChk_written = memList.get(i).get("teamWritten").toString();
			//서면심사팀에 속해있는경우만 별도로 계산해서 넣어준다.
			if("1".equals(sChk_written)) {
				
				paramMap.put("user_no", memList.get(i).get("userNo"));
				written_member = sqlSession.selectOne("MisAllotTmMbrMapper.selectMisAllotTmMbr1WrittenList", paramMap);
				//서면심사 미결
				memList.get(i).put("pendingCnt", written_member.get("pendingCnt").toString());
				
				//서면심사 년간 수임, 종결
				memList.get(i).put("regYearCnt", written_member.get("regYearCnt").toString());
				memList.get(i).put("clsYearCnt", written_member.get("clsYearCnt").toString());
				
				//서면심사 당월 종결
				memList.get(i).put("clsMonthCnt", written_member.get("clsMonthCnt").toString());				
				
				//서면심사 수임
				memList.get(i).put("reg02", written_member.get("reg02").toString());
				memList.get(i).put("reg03", written_member.get("reg03").toString());
				memList.get(i).put("reg04", written_member.get("reg04").toString());
				memList.get(i).put("reg05", written_member.get("reg05").toString());
				memList.get(i).put("reg06", written_member.get("reg06").toString());
				memList.get(i).put("reg07", written_member.get("reg07").toString());
				memList.get(i).put("reg08", written_member.get("reg08").toString());				
				memList.get(i).put("reg09", written_member.get("reg09").toString());
				memList.get(i).put("reg10", written_member.get("reg10").toString());
				memList.get(i).put("reg11", written_member.get("reg11").toString());
				memList.get(i).put("reg12", written_member.get("reg12").toString());
				memList.get(i).put("reg13", written_member.get("reg13").toString());
				memList.get(i).put("reg14", written_member.get("reg14").toString());
				memList.get(i).put("reg15", written_member.get("reg15").toString());
				memList.get(i).put("reg16", written_member.get("reg16").toString());
				memList.get(i).put("reg17", written_member.get("reg17").toString());
				memList.get(i).put("reg18", written_member.get("reg18").toString());
				memList.get(i).put("reg19", written_member.get("reg19").toString());
				memList.get(i).put("reg20", written_member.get("reg20").toString());
				memList.get(i).put("reg21", written_member.get("reg21").toString());
				memList.get(i).put("reg22", written_member.get("reg22").toString());
				memList.get(i).put("reg23", written_member.get("reg23").toString());
				memList.get(i).put("reg24", written_member.get("reg24").toString());
				memList.get(i).put("reg25", written_member.get("reg25").toString());
				memList.get(i).put("reg26", written_member.get("reg26").toString());
				memList.get(i).put("reg27", written_member.get("reg27").toString());
				memList.get(i).put("reg28", written_member.get("reg28").toString());
				memList.get(i).put("reg29", written_member.get("reg29").toString());
				memList.get(i).put("reg30", written_member.get("reg30").toString());
				memList.get(i).put("reg31", written_member.get("reg31").toString());
				
				//서면심사 종결
				memList.get(i).put("day02", written_member.get("day02").toString());
				memList.get(i).put("day03", written_member.get("day03").toString());
				memList.get(i).put("day04", written_member.get("day04").toString());
				memList.get(i).put("day05", written_member.get("day05").toString());
				memList.get(i).put("day06", written_member.get("day06").toString());
				memList.get(i).put("day07", written_member.get("day07").toString());
				memList.get(i).put("day08", written_member.get("day08").toString());				
				memList.get(i).put("day09", written_member.get("day09").toString());
				memList.get(i).put("day10", written_member.get("day10").toString());
				memList.get(i).put("day11", written_member.get("day11").toString());
				memList.get(i).put("day12", written_member.get("day12").toString());
				memList.get(i).put("day13", written_member.get("day13").toString());
				memList.get(i).put("day14", written_member.get("day14").toString());
				memList.get(i).put("day15", written_member.get("day15").toString());
				memList.get(i).put("day16", written_member.get("day16").toString());
				memList.get(i).put("day17", written_member.get("day17").toString());
				memList.get(i).put("day18", written_member.get("day18").toString());
				memList.get(i).put("day19", written_member.get("day19").toString());
				memList.get(i).put("day20", written_member.get("day20").toString());
				memList.get(i).put("day21", written_member.get("day21").toString());
				memList.get(i).put("day22", written_member.get("day22").toString());
				memList.get(i).put("day23", written_member.get("day23").toString());
				memList.get(i).put("day24", written_member.get("day24").toString());
				memList.get(i).put("day25", written_member.get("day25").toString());
				memList.get(i).put("day26", written_member.get("day26").toString());
				memList.get(i).put("day27", written_member.get("day27").toString());
				memList.get(i).put("day28", written_member.get("day28").toString());
				memList.get(i).put("day29", written_member.get("day29").toString());
				memList.get(i).put("day30", written_member.get("day30").toString());
				memList.get(i).put("day31", written_member.get("day31").toString());				
			}else{
				nTemp_UserNo = memList.get(i).get("userNo").toString();
				
				nowVO.setUser_no(nTemp_UserNo);
				
				//농작물의 일일배당 현황 데이터를 가져온다.				
				prim_user = sqlSession.selectOne("MisAllotTmMbrMapper.selectMisAllotTmTeam1PrimUserList", nowVO);
				
				//농작물 팀별 일일 수임				
				nReg30 = Integer.parseInt( memList.get(i).get("reg01").toString() ) + Integer.parseInt( prim_user.get("reg30").toString() );
				nReg29 = Integer.parseInt( memList.get(i).get("reg02").toString() ) + Integer.parseInt( prim_user.get("reg29").toString() );
				nReg28 = Integer.parseInt( memList.get(i).get("reg03").toString() ) + Integer.parseInt( prim_user.get("reg28").toString() );
				nReg27 = Integer.parseInt( memList.get(i).get("reg04").toString() ) + Integer.parseInt( prim_user.get("reg27").toString() );
				nReg26 = Integer.parseInt( memList.get(i).get("reg05").toString() ) + Integer.parseInt( prim_user.get("reg26").toString() );
				nReg25 = Integer.parseInt( memList.get(i).get("reg06").toString() ) + Integer.parseInt( prim_user.get("reg25").toString() );
				nReg24 = Integer.parseInt( memList.get(i).get("reg07").toString() ) + Integer.parseInt( prim_user.get("reg24").toString() );
				nReg23 = Integer.parseInt( memList.get(i).get("reg08").toString() ) + Integer.parseInt( prim_user.get("reg23").toString() );
				nReg22 = Integer.parseInt( memList.get(i).get("reg09").toString() ) + Integer.parseInt( prim_user.get("reg22").toString() );
				nReg21 = Integer.parseInt( memList.get(i).get("reg10").toString() ) + Integer.parseInt( prim_user.get("reg21").toString() );
				nReg20 = Integer.parseInt( memList.get(i).get("reg11").toString() ) + Integer.parseInt( prim_user.get("reg20").toString() );
				nReg19 = Integer.parseInt( memList.get(i).get("reg12").toString() ) + Integer.parseInt( prim_user.get("reg19").toString() );
				nReg18 = Integer.parseInt( memList.get(i).get("reg13").toString() ) + Integer.parseInt( prim_user.get("reg18").toString() );
				nReg17 = Integer.parseInt( memList.get(i).get("reg14").toString() ) + Integer.parseInt( prim_user.get("reg17").toString() );
				nReg16 = Integer.parseInt( memList.get(i).get("reg15").toString() ) + Integer.parseInt( prim_user.get("reg16").toString() );
				nReg15 = Integer.parseInt( memList.get(i).get("reg16").toString() ) + Integer.parseInt( prim_user.get("reg15").toString() );
				nReg14 = Integer.parseInt( memList.get(i).get("reg17").toString() ) + Integer.parseInt( prim_user.get("reg14").toString() );
				nReg13 = Integer.parseInt( memList.get(i).get("reg18").toString() ) + Integer.parseInt( prim_user.get("reg13").toString() );
				nReg12 = Integer.parseInt( memList.get(i).get("reg19").toString() ) + Integer.parseInt( prim_user.get("reg12").toString() );
				nReg11 = Integer.parseInt( memList.get(i).get("reg20").toString() ) + Integer.parseInt( prim_user.get("reg11").toString() );
				nReg10 = Integer.parseInt( memList.get(i).get("reg21").toString() ) + Integer.parseInt( prim_user.get("reg10").toString() );
				nReg09 = Integer.parseInt( memList.get(i).get("reg22").toString() ) + Integer.parseInt( prim_user.get("reg09").toString() );
				nReg08 = Integer.parseInt( memList.get(i).get("reg23").toString() ) + Integer.parseInt( prim_user.get("reg08").toString() );
				nReg07 = Integer.parseInt( memList.get(i).get("reg24").toString() ) + Integer.parseInt( prim_user.get("reg07").toString() );
				nReg06 = Integer.parseInt( memList.get(i).get("reg25").toString() ) + Integer.parseInt( prim_user.get("reg06").toString() );
				nReg05 = Integer.parseInt( memList.get(i).get("reg26").toString() ) + Integer.parseInt( prim_user.get("reg05").toString() );
				nReg04 = Integer.parseInt( memList.get(i).get("reg27").toString() ) + Integer.parseInt( prim_user.get("reg04").toString() );
				nReg03 = Integer.parseInt( memList.get(i).get("reg28").toString() ) + Integer.parseInt( prim_user.get("reg03").toString() );
				nReg02 = Integer.parseInt( memList.get(i).get("reg29").toString() ) + Integer.parseInt( prim_user.get("reg02").toString() );
				nReg01 = Integer.parseInt( memList.get(i).get("reg30").toString() ) + Integer.parseInt( prim_user.get("reg01").toString() );
				nReg00 = Integer.parseInt( memList.get(i).get("reg31").toString() ) + Integer.parseInt( prim_user.get("reg00").toString() );

				nDay30 = Integer.parseInt( memList.get(i).get("day01").toString() ) + Integer.parseInt( prim_user.get("day30").toString() );
				nDay29 = Integer.parseInt( memList.get(i).get("day02").toString() ) + Integer.parseInt( prim_user.get("day29").toString() );
				nDay28 = Integer.parseInt( memList.get(i).get("day03").toString() ) + Integer.parseInt( prim_user.get("day28").toString() );
				nDay27 = Integer.parseInt( memList.get(i).get("day04").toString() ) + Integer.parseInt( prim_user.get("day27").toString() );
				nDay26 = Integer.parseInt( memList.get(i).get("day05").toString() ) + Integer.parseInt( prim_user.get("day26").toString() );
				nDay25 = Integer.parseInt( memList.get(i).get("day06").toString() ) + Integer.parseInt( prim_user.get("day25").toString() );
				nDay24 = Integer.parseInt( memList.get(i).get("day07").toString() ) + Integer.parseInt( prim_user.get("day24").toString() );
				nDay23 = Integer.parseInt( memList.get(i).get("day08").toString() ) + Integer.parseInt( prim_user.get("day23").toString() );
				nDay22 = Integer.parseInt( memList.get(i).get("day09").toString() ) + Integer.parseInt( prim_user.get("day22").toString() );
				nDay21 = Integer.parseInt( memList.get(i).get("day10").toString() ) + Integer.parseInt( prim_user.get("day21").toString() );
				nDay20 = Integer.parseInt( memList.get(i).get("day11").toString() ) + Integer.parseInt( prim_user.get("day20").toString() );
				nDay19 = Integer.parseInt( memList.get(i).get("day12").toString() ) + Integer.parseInt( prim_user.get("day19").toString() );
				nDay18 = Integer.parseInt( memList.get(i).get("day13").toString() ) + Integer.parseInt( prim_user.get("day18").toString() );
				nDay17 = Integer.parseInt( memList.get(i).get("day14").toString() ) + Integer.parseInt( prim_user.get("day17").toString() );
				nDay16 = Integer.parseInt( memList.get(i).get("day15").toString() ) + Integer.parseInt( prim_user.get("day16").toString() );
				nDay15 = Integer.parseInt( memList.get(i).get("day16").toString() ) + Integer.parseInt( prim_user.get("day15").toString() );
				nDay14 = Integer.parseInt( memList.get(i).get("day17").toString() ) + Integer.parseInt( prim_user.get("day14").toString() );
				nDay13 = Integer.parseInt( memList.get(i).get("day18").toString() ) + Integer.parseInt( prim_user.get("day13").toString() );
				nDay12 = Integer.parseInt( memList.get(i).get("day19").toString() ) + Integer.parseInt( prim_user.get("day12").toString() );
				nDay11 = Integer.parseInt( memList.get(i).get("day20").toString() ) + Integer.parseInt( prim_user.get("day11").toString() );
				nDay10 = Integer.parseInt( memList.get(i).get("day21").toString() ) + Integer.parseInt( prim_user.get("day10").toString() );
				nDay09 = Integer.parseInt( memList.get(i).get("day22").toString() ) + Integer.parseInt( prim_user.get("day09").toString() );
				nDay08 = Integer.parseInt( memList.get(i).get("day23").toString() ) + Integer.parseInt( prim_user.get("day08").toString() );
				nDay07 = Integer.parseInt( memList.get(i).get("day24").toString() ) + Integer.parseInt( prim_user.get("day07").toString() );
				nDay06 = Integer.parseInt( memList.get(i).get("day25").toString() ) + Integer.parseInt( prim_user.get("day06").toString() );
				nDay05 = Integer.parseInt( memList.get(i).get("day26").toString() ) + Integer.parseInt( prim_user.get("day05").toString() );
				nDay04 = Integer.parseInt( memList.get(i).get("day27").toString() ) + Integer.parseInt( prim_user.get("day04").toString() );
				nDay03 = Integer.parseInt( memList.get(i).get("day28").toString() ) + Integer.parseInt( prim_user.get("day03").toString() );
				nDay02 = Integer.parseInt( memList.get(i).get("day29").toString() ) + Integer.parseInt( prim_user.get("day02").toString() );
				nDay01 = Integer.parseInt( memList.get(i).get("day30").toString() ) + Integer.parseInt( prim_user.get("day01").toString() );
				nDay00 = Integer.parseInt( memList.get(i).get("day31").toString() ) + Integer.parseInt( prim_user.get("day00").toString() );
				
				memList.get(i).put("reg01", nReg30);				
				memList.get(i).put("reg02", nReg29);
				memList.get(i).put("reg03", nReg28);
				memList.get(i).put("reg04", nReg27);
				memList.get(i).put("reg05", nReg26);
				memList.get(i).put("reg06", nReg25);
				memList.get(i).put("reg07", nReg24);
				memList.get(i).put("reg08", nReg23);
				memList.get(i).put("reg09", nReg22);
				memList.get(i).put("reg10", nReg21);
				memList.get(i).put("reg11", nReg20);
				memList.get(i).put("reg12", nReg19);
				memList.get(i).put("reg13", nReg18);
				memList.get(i).put("reg14", nReg17);
				memList.get(i).put("reg15", nReg16);
				memList.get(i).put("reg16", nReg15);
				memList.get(i).put("reg17", nReg14);
				memList.get(i).put("reg18", nReg13);
				memList.get(i).put("reg19", nReg12);
				memList.get(i).put("reg20", nReg11);
				memList.get(i).put("reg21", nReg10);
				memList.get(i).put("reg22", nReg09);
				memList.get(i).put("reg23", nReg08);
				memList.get(i).put("reg24", nReg07);
				memList.get(i).put("reg25", nReg06);
				memList.get(i).put("reg26", nReg05);
				memList.get(i).put("reg27", nReg04);
				memList.get(i).put("reg28", nReg03);
				memList.get(i).put("reg29", nReg02);
				memList.get(i).put("reg30", nReg01);
				memList.get(i).put("reg31", nReg00);				
				
				memList.get(i).put("day01", nDay30);				
				memList.get(i).put("day02", nDay29);
				memList.get(i).put("day03", nDay28);
				memList.get(i).put("day04", nDay27);
				memList.get(i).put("day05", nDay26);
				memList.get(i).put("day06", nDay25);
				memList.get(i).put("day07", nDay24);
				memList.get(i).put("day08", nDay23);
				memList.get(i).put("day09", nDay22);
				memList.get(i).put("day10", nDay21);
				memList.get(i).put("day11", nDay20);
				memList.get(i).put("day12", nDay19);
				memList.get(i).put("day13", nDay18);
				memList.get(i).put("day14", nDay17);
				memList.get(i).put("day15", nDay16);
				memList.get(i).put("day16", nDay15);
				memList.get(i).put("day17", nDay14);
				memList.get(i).put("day18", nDay13);
				memList.get(i).put("day19", nDay12);
				memList.get(i).put("day20", nDay11);
				memList.get(i).put("day21", nDay10);
				memList.get(i).put("day22", nDay09);
				memList.get(i).put("day23", nDay08);
				memList.get(i).put("day24", nDay07);
				memList.get(i).put("day25", nDay06);
				memList.get(i).put("day26", nDay05);
				memList.get(i).put("day27", nDay04);
				memList.get(i).put("day28", nDay03);
				memList.get(i).put("day29", nDay02);
				memList.get(i).put("day30", nDay01);
				memList.get(i).put("day31", nDay00);				
				
				//농작물 미결
				nRegMi = Integer.parseInt( memList.get(i).get("pendingCnt").toString() ) + Integer.parseInt( prim_user.get("regMi").toString() );				
				
				//농작물 팀별 년간 수임, 종결				
				nRegY = Integer.parseInt( memList.get(i).get("regYearCnt").toString() ) + Integer.parseInt( prim_user.get("regY").toString() );				
				nClsY = Integer.parseInt( memList.get(i).get("clsYearCnt").toString() ) + Integer.parseInt( prim_user.get("clsY").toString() );
				
				//농작물 당월종결
				nClsM = Integer.parseInt( memList.get(i).get("clsMonthCnt").toString() ) + Integer.parseInt( prim_user.get("clsM").toString() );
				
				memList.get(i).put("pendingCnt", nRegMi);
				memList.get(i).put("regYearCnt", nRegY);
				memList.get(i).put("clsYearCnt", nClsY);
				memList.get(i).put("clsMonthCnt", nClsM);
				
			}
		}
		
		model.addAttribute("nowVO", nowVO);
		model.addAttribute("memList",memList);
		
		return "/top_statistics/mis_allot_tm_mbr_ajax";
	}
	
	/**
	 * 일일배당 현황 신규 방식 적용 Ajax Tab 호출방식
	 * @param model
	 * @param session
	 * @param request
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/getMisAllotTmNew")
	public String getMisAllotTmNew(Model model, HttpSession session, HttpServletRequest request, MisTmBscViewVO inVO) {
		
		logger.info("======= getMisAllotTmNew =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			logger.info("getMisAllotTm - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		//검색 로그 남기기 시작 (20240109)
		String sUserNo = mbrVo.getUser_no();		
		String sUserName = mbrVo.getUser_name();
		String sIp = mbrVo.getUser_ip();
		String sLogPage = "일일배당현황(신규)";

		Map<String, Object> logMap = new HashMap<String, Object>();

		logMap.put("user_no", sUserNo);
		logMap.put("user_name", sUserName);
		logMap.put("user_ip", sIp);
		logMap.put("search_page", sLogPage);

		sqlSession.insert("SaveLogMapper.insertTopSearchLog",logMap);
		//검색 로그 남기기 끝 (20240109)
		
		String tabMenu = request.getParameter("tabMenu") != null ? request.getParameter("tabMenu") : "member";		//탭 기본은 member
		
		DateFormat tmpFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date tmpToday = new Date();
		String tmpNow_to = tmpFormat.format(tmpToday);

		inVO.setViewToDate(tmpNow_to);
		StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics30DaysDate", tmpNow_to);
		StatisticsNowVO nowVO2 = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate");
		nowVO.setNow_from(nowVO2.getNow_from());
		nowVO.setNow_to(nowVO2.getNow_to());
		nowVO.setYear_from(nowVO2.getYear_from());
		nowVO.setYear_to(nowVO2.getYear_to());
		
		model.addAttribute("nowVO", nowVO);
		model.addAttribute("inVO", inVO);		
		model.addAttribute("tabMenu", tabMenu);
		
		return "top_statistics/mis_allot_main";
	}

	@RequestMapping(value = "/getMisAllotTm", method = RequestMethod.GET)
	public String getMisAllotTm(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= getMisAllotTm =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			logger.info("getMisAllotTm - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		
		//검색 로그 남기기 시작 (20240109)
		String sUserNo = mbrVo.getUser_no();		
		String sUserName = mbrVo.getUser_name();
		String sIp = mbrVo.getUser_ip();
		String sLogPage = "일일배당현황(기존방식)";

		Map<String, Object> logMap = new HashMap<String, Object>();

		logMap.put("user_no", sUserNo);
		logMap.put("user_name", sUserName);
		logMap.put("user_ip", sIp);
		logMap.put("search_page", sLogPage);

		sqlSession.insert("SaveLogMapper.insertTopSearchLog",logMap);
		//검색 로그 남기기 끝 (20240109)

		DateFormat tmpFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date tmpToday = new Date();
		String tmpNow_to = tmpFormat.format(tmpToday);

		inVO.setViewToDate(tmpNow_to);
		StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics30DaysDate", tmpNow_to);
		StatisticsNowVO nowVO2 = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate");
		nowVO.setNow_from(nowVO2.getNow_from());
		nowVO.setNow_to(nowVO2.getNow_to());
		nowVO.setYear_from(nowVO2.getYear_from());
		nowVO.setYear_to(nowVO2.getYear_to());
		
		//================================================
		// 필요 날짜 세팅
		//================================================
		String today = DateUtil.getTodayString();
		String bgnDe = DateUtil.addDate(today,-30);
		String endDe = DateUtil.addDate(today,1);
		String bgnYearDe = (Integer.parseInt(endDe.substring(0,4)) - 1)  + "1216";
		String endYearDe = endDe.substring(0,4) + "1216";
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("bgnDe", bgnDe);
		paramMap.put("endDe", endDe);
		paramMap.put("bgnYearDe", bgnYearDe);
		paramMap.put("endYearDe", endYearDe);
		paramMap.put("now_from", nowVO2.getNow_from());
		paramMap.put("now_to", nowVO2.getNow_to());
		
		//농작물 쿼리 추가로인한 셋팅
		nowVO.setBgnYearDe(bgnYearDe);
		nowVO.setEndYearDe(endYearDe);
		nowVO.setBgnDe(bgnDe);
		nowVO.setEndDe(endDe);
		
		//System.out.println("bgnYearDe="+bgnYearDe);
		//System.out.println("endYearDe="+endYearDe);		
		//System.out.println("bgnDe="+bgnDe);
		//System.out.println("endDe="+endDe);
		
		//System.out.println("now_from="+nowVO2.getNow_from());
		//System.out.println("now_to="+nowVO2.getNow_to());		
		
		List<MisRegTmVO> getMisAllotTm1 = sqlSession.selectList("MisAllotTmMapper.newGetMisAllotTm1", nowVO);
		
		//서면심사 팀 계산값 저장용 임시 Map
		Map<String, Object> written_team;
		
		//농작물 팀 계산값 저장용 임시 Map
		Map<String, Object> prim_team;
		
		//보고서에 농작물 보고서 카운트를 추가하기위한 임시 변수
		int nRegY = 0;
		int nClsY = 0;
		int nClsM = 0;
		int nRegMi = 0;		
		int nReg30=0;
		int nReg29=0;
		int nReg28=0;
		int nReg27=0;
		int nReg26=0;
		int nReg25=0;
		int nReg24=0;
		int nReg23=0;
		int nReg22=0;
		int nReg21=0;
		int nReg20=0;
		int nReg19=0;
		int nReg18=0;
		int nReg17=0;
		int nReg16=0;
		int nReg15=0;
		int nReg14=0;
		int nReg13=0;
		int nReg12=0;
		int nReg11=0;
		int nReg10=0;
		int nReg09=0;
		int nReg08=0;
		int nReg07=0;
		int nReg06=0;
		int nReg05=0;
		int nReg04=0;
		int nReg03=0;
		int nReg02=0;
		int nReg01=0;
		int nReg00=0;
		
		int nDay30=0;
		int nDay29=0;
		int nDay28=0;
		int nDay27=0;
		int nDay26=0;
		int nDay25=0;
		int nDay24=0;
		int nDay23=0;
		int nDay22=0;
		int nDay21=0;
		int nDay20=0;
		int nDay19=0;
		int nDay18=0;
		int nDay17=0;
		int nDay16=0;
		int nDay15=0;
		int nDay14=0;
		int nDay13=0;
		int nDay12=0;
		int nDay11=0;
		int nDay10=0;
		int nDay09=0;
		int nDay08=0;
		int nDay07=0;
		int nDay06=0;
		int nDay05=0;
		int nDay04=0;
		int nDay03=0;
		int nDay02=0;
		int nDay01=0;
		int nDay00=0;
		
		String sChk_writtenteam = "0";
		
		for(int i=0; i < getMisAllotTm1.size(); i++) {
			sChk_writtenteam = getMisAllotTm1.get(i).getTeam_written().toString();
			
			//서면심사팀인 경우만 재계산해준다.
			if("1".equals(sChk_writtenteam)) {
				//System.out.println("written_team : "+getMisAllotTm1.get(i).getTeam_name()+" : "+getMisAllotTm1.get(i).getTeam_id());
				paramMap.put("team_id", getMisAllotTm1.get(i).getTeam_id());
				
				written_team = sqlSession.selectOne("MisAllotTmMbrMapper.selectMisAllotTmTeam1WrittenList", paramMap);
				//서면심사 팀별 년간 수임, 종결
				getMisAllotTm1.get(i).setReg_y(written_team.get("regY").toString());
				getMisAllotTm1.get(i).setCls_y(written_team.get("clsY").toString());				
				
				//서면심사 팀별 월간 종결
				getMisAllotTm1.get(i).setCls_m(written_team.get("clsM").toString());
				
				//서면심사 팀별 미결
				getMisAllotTm1.get(i).setReg_mi(written_team.get("regMi").toString());
				
				//서면심사 팀별 일일 수임
				getMisAllotTm1.get(i).setReg_00(written_team.get("reg31").toString());
				getMisAllotTm1.get(i).setReg_01(written_team.get("reg30").toString());
				getMisAllotTm1.get(i).setReg_02(written_team.get("reg29").toString());
				getMisAllotTm1.get(i).setReg_03(written_team.get("reg28").toString());
				getMisAllotTm1.get(i).setReg_04(written_team.get("reg27").toString());
				getMisAllotTm1.get(i).setReg_05(written_team.get("reg26").toString());
				getMisAllotTm1.get(i).setReg_06(written_team.get("reg25").toString());
				getMisAllotTm1.get(i).setReg_07(written_team.get("reg24").toString());
				getMisAllotTm1.get(i).setReg_08(written_team.get("reg23").toString());
				getMisAllotTm1.get(i).setReg_09(written_team.get("reg22").toString());
				getMisAllotTm1.get(i).setReg_10(written_team.get("reg21").toString());
				getMisAllotTm1.get(i).setReg_11(written_team.get("reg20").toString());
				getMisAllotTm1.get(i).setReg_12(written_team.get("reg19").toString());
				getMisAllotTm1.get(i).setReg_13(written_team.get("reg18").toString());
				getMisAllotTm1.get(i).setReg_14(written_team.get("reg17").toString());
				getMisAllotTm1.get(i).setReg_15(written_team.get("reg16").toString());
				getMisAllotTm1.get(i).setReg_16(written_team.get("reg15").toString());
				getMisAllotTm1.get(i).setReg_17(written_team.get("reg14").toString());
				getMisAllotTm1.get(i).setReg_18(written_team.get("reg13").toString());
				getMisAllotTm1.get(i).setReg_19(written_team.get("reg12").toString());
				getMisAllotTm1.get(i).setReg_20(written_team.get("reg11").toString());
				getMisAllotTm1.get(i).setReg_21(written_team.get("reg10").toString());
				getMisAllotTm1.get(i).setReg_22(written_team.get("reg09").toString());
				getMisAllotTm1.get(i).setReg_23(written_team.get("reg08").toString());
				getMisAllotTm1.get(i).setReg_24(written_team.get("reg07").toString());
				getMisAllotTm1.get(i).setReg_25(written_team.get("reg06").toString());
				getMisAllotTm1.get(i).setReg_26(written_team.get("reg05").toString());
				getMisAllotTm1.get(i).setReg_27(written_team.get("reg04").toString());
				getMisAllotTm1.get(i).setReg_28(written_team.get("reg03").toString());
				getMisAllotTm1.get(i).setReg_29(written_team.get("reg02").toString());
				
				//서면심사 팀별 일일 종결
				getMisAllotTm1.get(i).setDay_00(written_team.get("day31").toString());
				getMisAllotTm1.get(i).setDay_01(written_team.get("day30").toString());
				getMisAllotTm1.get(i).setDay_02(written_team.get("day29").toString());
				getMisAllotTm1.get(i).setDay_03(written_team.get("day28").toString());
				getMisAllotTm1.get(i).setDay_04(written_team.get("day27").toString());
				getMisAllotTm1.get(i).setDay_05(written_team.get("day26").toString());
				getMisAllotTm1.get(i).setDay_06(written_team.get("day25").toString());
				getMisAllotTm1.get(i).setDay_07(written_team.get("day24").toString());
				getMisAllotTm1.get(i).setDay_08(written_team.get("day23").toString());
				getMisAllotTm1.get(i).setDay_09(written_team.get("day22").toString());
				getMisAllotTm1.get(i).setDay_10(written_team.get("day21").toString());
				getMisAllotTm1.get(i).setDay_11(written_team.get("day20").toString());
				getMisAllotTm1.get(i).setDay_12(written_team.get("day19").toString());
				getMisAllotTm1.get(i).setDay_13(written_team.get("day18").toString());
				getMisAllotTm1.get(i).setDay_14(written_team.get("day17").toString());
				getMisAllotTm1.get(i).setDay_15(written_team.get("day16").toString());
				getMisAllotTm1.get(i).setDay_16(written_team.get("day15").toString());
				getMisAllotTm1.get(i).setDay_17(written_team.get("day14").toString());
				getMisAllotTm1.get(i).setDay_18(written_team.get("day13").toString());
				getMisAllotTm1.get(i).setDay_19(written_team.get("day12").toString());
				getMisAllotTm1.get(i).setDay_20(written_team.get("day11").toString());
				getMisAllotTm1.get(i).setDay_21(written_team.get("day10").toString());
				getMisAllotTm1.get(i).setDay_22(written_team.get("day09").toString());
				getMisAllotTm1.get(i).setDay_23(written_team.get("day08").toString());
				getMisAllotTm1.get(i).setDay_24(written_team.get("day07").toString());
				getMisAllotTm1.get(i).setDay_25(written_team.get("day06").toString());
				getMisAllotTm1.get(i).setDay_26(written_team.get("day05").toString());
				getMisAllotTm1.get(i).setDay_27(written_team.get("day04").toString());
				getMisAllotTm1.get(i).setDay_28(written_team.get("day03").toString());
				getMisAllotTm1.get(i).setDay_29(written_team.get("day02").toString());
			}else{				//서면심사가 아닌경우 농작물 카운트를 더해준다.
				String sTeam_id = getMisAllotTm1.get(i).getTeam_id();
				
				nowVO.setTeam_id(sTeam_id);
				
				//농작물의 일일배당 현황 데이터를 가져온다.				
				prim_team = sqlSession.selectOne("MisAllotTmMbrMapper.selectMisAllotTmTeam1PrimList", nowVO);
				
				//농작물 팀별 일일 수임				
				nReg30 = Integer.parseInt( getMisAllotTm1.get(i).getReg_30().toString() ) + Integer.parseInt( prim_team.get("reg30").toString() );
				nReg29 = Integer.parseInt( getMisAllotTm1.get(i).getReg_29().toString() ) + Integer.parseInt( prim_team.get("reg29").toString() );
				nReg28 = Integer.parseInt( getMisAllotTm1.get(i).getReg_28().toString() ) + Integer.parseInt( prim_team.get("reg28").toString() );
				nReg27 = Integer.parseInt( getMisAllotTm1.get(i).getReg_27().toString() ) + Integer.parseInt( prim_team.get("reg27").toString() );
				nReg26 = Integer.parseInt( getMisAllotTm1.get(i).getReg_26().toString() ) + Integer.parseInt( prim_team.get("reg26").toString() );
				nReg25 = Integer.parseInt( getMisAllotTm1.get(i).getReg_25().toString() ) + Integer.parseInt( prim_team.get("reg25").toString() );
				nReg24 = Integer.parseInt( getMisAllotTm1.get(i).getReg_24().toString() ) + Integer.parseInt( prim_team.get("reg24").toString() );
				nReg23 = Integer.parseInt( getMisAllotTm1.get(i).getReg_23().toString() ) + Integer.parseInt( prim_team.get("reg23").toString() );
				nReg22 = Integer.parseInt( getMisAllotTm1.get(i).getReg_22().toString() ) + Integer.parseInt( prim_team.get("reg22").toString() );
				nReg21 = Integer.parseInt( getMisAllotTm1.get(i).getReg_21().toString() ) + Integer.parseInt( prim_team.get("reg21").toString() );
				nReg20 = Integer.parseInt( getMisAllotTm1.get(i).getReg_20().toString() ) + Integer.parseInt( prim_team.get("reg20").toString() );
				nReg19 = Integer.parseInt( getMisAllotTm1.get(i).getReg_19().toString() ) + Integer.parseInt( prim_team.get("reg19").toString() );
				nReg18 = Integer.parseInt( getMisAllotTm1.get(i).getReg_18().toString() ) + Integer.parseInt( prim_team.get("reg18").toString() );
				nReg17 = Integer.parseInt( getMisAllotTm1.get(i).getReg_17().toString() ) + Integer.parseInt( prim_team.get("reg17").toString() );
				nReg16 = Integer.parseInt( getMisAllotTm1.get(i).getReg_16().toString() ) + Integer.parseInt( prim_team.get("reg16").toString() );
				nReg15 = Integer.parseInt( getMisAllotTm1.get(i).getReg_15().toString() ) + Integer.parseInt( prim_team.get("reg15").toString() );
				nReg14 = Integer.parseInt( getMisAllotTm1.get(i).getReg_14().toString() ) + Integer.parseInt( prim_team.get("reg14").toString() );
				nReg13 = Integer.parseInt( getMisAllotTm1.get(i).getReg_13().toString() ) + Integer.parseInt( prim_team.get("reg13").toString() );
				nReg12 = Integer.parseInt( getMisAllotTm1.get(i).getReg_12().toString() ) + Integer.parseInt( prim_team.get("reg12").toString() );
				nReg11 = Integer.parseInt( getMisAllotTm1.get(i).getReg_11().toString() ) + Integer.parseInt( prim_team.get("reg11").toString() );
				nReg10 = Integer.parseInt( getMisAllotTm1.get(i).getReg_10().toString() ) + Integer.parseInt( prim_team.get("reg10").toString() );
				nReg09 = Integer.parseInt( getMisAllotTm1.get(i).getReg_09().toString() ) + Integer.parseInt( prim_team.get("reg09").toString() );
				nReg08 = Integer.parseInt( getMisAllotTm1.get(i).getReg_08().toString() ) + Integer.parseInt( prim_team.get("reg08").toString() );
				nReg07 = Integer.parseInt( getMisAllotTm1.get(i).getReg_07().toString() ) + Integer.parseInt( prim_team.get("reg07").toString() );
				nReg06 = Integer.parseInt( getMisAllotTm1.get(i).getReg_06().toString() ) + Integer.parseInt( prim_team.get("reg06").toString() );
				nReg05 = Integer.parseInt( getMisAllotTm1.get(i).getReg_05().toString() ) + Integer.parseInt( prim_team.get("reg05").toString() );
				nReg04 = Integer.parseInt( getMisAllotTm1.get(i).getReg_04().toString() ) + Integer.parseInt( prim_team.get("reg04").toString() );
				nReg03 = Integer.parseInt( getMisAllotTm1.get(i).getReg_03().toString() ) + Integer.parseInt( prim_team.get("reg03").toString() );
				nReg02 = Integer.parseInt( getMisAllotTm1.get(i).getReg_02().toString() ) + Integer.parseInt( prim_team.get("reg02").toString() );
				nReg01 = Integer.parseInt( getMisAllotTm1.get(i).getReg_01().toString() ) + Integer.parseInt( prim_team.get("reg01").toString() );
				nReg00 = Integer.parseInt( getMisAllotTm1.get(i).getReg_00().toString() ) + Integer.parseInt( prim_team.get("reg00").toString() );

				nDay30 = Integer.parseInt( getMisAllotTm1.get(i).getDay_30().toString() ) + Integer.parseInt( prim_team.get("day30").toString() );
				nDay29 = Integer.parseInt( getMisAllotTm1.get(i).getDay_29().toString() ) + Integer.parseInt( prim_team.get("day29").toString() );
				nDay28 = Integer.parseInt( getMisAllotTm1.get(i).getDay_28().toString() ) + Integer.parseInt( prim_team.get("day28").toString() );
				nDay27 = Integer.parseInt( getMisAllotTm1.get(i).getDay_27().toString() ) + Integer.parseInt( prim_team.get("day27").toString() );
				nDay26 = Integer.parseInt( getMisAllotTm1.get(i).getDay_26().toString() ) + Integer.parseInt( prim_team.get("day26").toString() );
				nDay25 = Integer.parseInt( getMisAllotTm1.get(i).getDay_25().toString() ) + Integer.parseInt( prim_team.get("day25").toString() );
				nDay24 = Integer.parseInt( getMisAllotTm1.get(i).getDay_24().toString() ) + Integer.parseInt( prim_team.get("day24").toString() );
				nDay23 = Integer.parseInt( getMisAllotTm1.get(i).getDay_23().toString() ) + Integer.parseInt( prim_team.get("day23").toString() );
				nDay22 = Integer.parseInt( getMisAllotTm1.get(i).getDay_22().toString() ) + Integer.parseInt( prim_team.get("day22").toString() );
				nDay21 = Integer.parseInt( getMisAllotTm1.get(i).getDay_21().toString() ) + Integer.parseInt( prim_team.get("day21").toString() );
				nDay20 = Integer.parseInt( getMisAllotTm1.get(i).getDay_20().toString() ) + Integer.parseInt( prim_team.get("day20").toString() );
				nDay19 = Integer.parseInt( getMisAllotTm1.get(i).getDay_19().toString() ) + Integer.parseInt( prim_team.get("day19").toString() );
				nDay18 = Integer.parseInt( getMisAllotTm1.get(i).getDay_18().toString() ) + Integer.parseInt( prim_team.get("day18").toString() );
				nDay17 = Integer.parseInt( getMisAllotTm1.get(i).getDay_17().toString() ) + Integer.parseInt( prim_team.get("day17").toString() );
				nDay16 = Integer.parseInt( getMisAllotTm1.get(i).getDay_16().toString() ) + Integer.parseInt( prim_team.get("day16").toString() );
				nDay15 = Integer.parseInt( getMisAllotTm1.get(i).getDay_15().toString() ) + Integer.parseInt( prim_team.get("day15").toString() );
				nDay14 = Integer.parseInt( getMisAllotTm1.get(i).getDay_14().toString() ) + Integer.parseInt( prim_team.get("day14").toString() );
				nDay13 = Integer.parseInt( getMisAllotTm1.get(i).getDay_13().toString() ) + Integer.parseInt( prim_team.get("day13").toString() );
				nDay12 = Integer.parseInt( getMisAllotTm1.get(i).getDay_12().toString() ) + Integer.parseInt( prim_team.get("day12").toString() );
				nDay11 = Integer.parseInt( getMisAllotTm1.get(i).getDay_11().toString() ) + Integer.parseInt( prim_team.get("day11").toString() );
				nDay10 = Integer.parseInt( getMisAllotTm1.get(i).getDay_10().toString() ) + Integer.parseInt( prim_team.get("day10").toString() );
				nDay09 = Integer.parseInt( getMisAllotTm1.get(i).getDay_09().toString() ) + Integer.parseInt( prim_team.get("day09").toString() );
				nDay08 = Integer.parseInt( getMisAllotTm1.get(i).getDay_08().toString() ) + Integer.parseInt( prim_team.get("day08").toString() );
				nDay07 = Integer.parseInt( getMisAllotTm1.get(i).getDay_07().toString() ) + Integer.parseInt( prim_team.get("day07").toString() );
				nDay06 = Integer.parseInt( getMisAllotTm1.get(i).getDay_06().toString() ) + Integer.parseInt( prim_team.get("day06").toString() );
				nDay05 = Integer.parseInt( getMisAllotTm1.get(i).getDay_05().toString() ) + Integer.parseInt( prim_team.get("day05").toString() );
				nDay04 = Integer.parseInt( getMisAllotTm1.get(i).getDay_04().toString() ) + Integer.parseInt( prim_team.get("day04").toString() );
				nDay03 = Integer.parseInt( getMisAllotTm1.get(i).getDay_03().toString() ) + Integer.parseInt( prim_team.get("day03").toString() );
				nDay02 = Integer.parseInt( getMisAllotTm1.get(i).getDay_02().toString() ) + Integer.parseInt( prim_team.get("day02").toString() );
				nDay01 = Integer.parseInt( getMisAllotTm1.get(i).getDay_01().toString() ) + Integer.parseInt( prim_team.get("day01").toString() );
				nDay00 = Integer.parseInt( getMisAllotTm1.get(i).getDay_00().toString() ) + Integer.parseInt( prim_team.get("day00").toString() );
				
				getMisAllotTm1.get(i).setReg_30(String.valueOf(nReg30));
				getMisAllotTm1.get(i).setReg_29(String.valueOf(nReg29));
				getMisAllotTm1.get(i).setReg_28(String.valueOf(nReg28));
				getMisAllotTm1.get(i).setReg_27(String.valueOf(nReg27));
				getMisAllotTm1.get(i).setReg_26(String.valueOf(nReg26));
				getMisAllotTm1.get(i).setReg_25(String.valueOf(nReg25));
				getMisAllotTm1.get(i).setReg_24(String.valueOf(nReg24));
				getMisAllotTm1.get(i).setReg_23(String.valueOf(nReg23));
				getMisAllotTm1.get(i).setReg_22(String.valueOf(nReg22));
				getMisAllotTm1.get(i).setReg_21(String.valueOf(nReg21));
				getMisAllotTm1.get(i).setReg_20(String.valueOf(nReg20));
				getMisAllotTm1.get(i).setReg_19(String.valueOf(nReg19));
				getMisAllotTm1.get(i).setReg_18(String.valueOf(nReg18));
				getMisAllotTm1.get(i).setReg_17(String.valueOf(nReg17));
				getMisAllotTm1.get(i).setReg_16(String.valueOf(nReg16));
				getMisAllotTm1.get(i).setReg_15(String.valueOf(nReg15));
				getMisAllotTm1.get(i).setReg_14(String.valueOf(nReg14));
				getMisAllotTm1.get(i).setReg_13(String.valueOf(nReg13));
				getMisAllotTm1.get(i).setReg_12(String.valueOf(nReg12));
				getMisAllotTm1.get(i).setReg_11(String.valueOf(nReg11));
				getMisAllotTm1.get(i).setReg_10(String.valueOf(nReg10));
				getMisAllotTm1.get(i).setReg_09(String.valueOf(nReg09));
				getMisAllotTm1.get(i).setReg_08(String.valueOf(nReg08));
				getMisAllotTm1.get(i).setReg_07(String.valueOf(nReg07));
				getMisAllotTm1.get(i).setReg_06(String.valueOf(nReg06));
				getMisAllotTm1.get(i).setReg_05(String.valueOf(nReg05));
				getMisAllotTm1.get(i).setReg_04(String.valueOf(nReg04));
				getMisAllotTm1.get(i).setReg_03(String.valueOf(nReg03));
				getMisAllotTm1.get(i).setReg_02(String.valueOf(nReg02));
				getMisAllotTm1.get(i).setReg_01(String.valueOf(nReg01));
				getMisAllotTm1.get(i).setReg_00(String.valueOf(nReg00));
				
				getMisAllotTm1.get(i).setDay_30(String.valueOf(nDay30));
				getMisAllotTm1.get(i).setDay_29(String.valueOf(nDay29));
				getMisAllotTm1.get(i).setDay_28(String.valueOf(nDay28));
				getMisAllotTm1.get(i).setDay_27(String.valueOf(nDay27));
				getMisAllotTm1.get(i).setDay_26(String.valueOf(nDay26));
				getMisAllotTm1.get(i).setDay_25(String.valueOf(nDay25));
				getMisAllotTm1.get(i).setDay_24(String.valueOf(nDay24));
				getMisAllotTm1.get(i).setDay_23(String.valueOf(nDay23));
				getMisAllotTm1.get(i).setDay_22(String.valueOf(nDay22));
				getMisAllotTm1.get(i).setDay_21(String.valueOf(nDay21));
				getMisAllotTm1.get(i).setDay_20(String.valueOf(nDay20));
				getMisAllotTm1.get(i).setDay_19(String.valueOf(nDay19));
				getMisAllotTm1.get(i).setDay_18(String.valueOf(nDay18));
				getMisAllotTm1.get(i).setDay_17(String.valueOf(nDay17));
				getMisAllotTm1.get(i).setDay_16(String.valueOf(nDay16));
				getMisAllotTm1.get(i).setDay_15(String.valueOf(nDay15));
				getMisAllotTm1.get(i).setDay_14(String.valueOf(nDay14));
				getMisAllotTm1.get(i).setDay_13(String.valueOf(nDay13));
				getMisAllotTm1.get(i).setDay_12(String.valueOf(nDay12));
				getMisAllotTm1.get(i).setDay_11(String.valueOf(nDay11));
				getMisAllotTm1.get(i).setDay_10(String.valueOf(nDay10));
				getMisAllotTm1.get(i).setDay_09(String.valueOf(nDay09));
				getMisAllotTm1.get(i).setDay_08(String.valueOf(nDay08));
				getMisAllotTm1.get(i).setDay_07(String.valueOf(nDay07));
				getMisAllotTm1.get(i).setDay_06(String.valueOf(nDay06));
				getMisAllotTm1.get(i).setDay_05(String.valueOf(nDay05));
				getMisAllotTm1.get(i).setDay_04(String.valueOf(nDay04));
				getMisAllotTm1.get(i).setDay_03(String.valueOf(nDay03));
				getMisAllotTm1.get(i).setDay_02(String.valueOf(nDay02));
				getMisAllotTm1.get(i).setDay_01(String.valueOf(nDay01));
				getMisAllotTm1.get(i).setDay_00(String.valueOf(nDay00));				
				
				//농작물 팀별 년간 수임, 종결				
				nRegY = Integer.parseInt( getMisAllotTm1.get(i).getReg_y().toString() ) + Integer.parseInt( prim_team.get("regY").toString() );
				getMisAllotTm1.get(i).setReg_y(String.valueOf(nRegY));
				nClsY = Integer.parseInt( getMisAllotTm1.get(i).getCls_y().toString()) + Integer.parseInt( prim_team.get("clsY").toString() );
				getMisAllotTm1.get(i).setCls_y(String.valueOf(nClsY));				
				
				//농작물 팀별 월간 종결
				nClsM = Integer.parseInt( getMisAllotTm1.get(i).getCls_m().toString() ) + Integer.parseInt( prim_team.get("clsM").toString() );				
				getMisAllotTm1.get(i).setCls_m(String.valueOf(nClsM));
				
				//농작물 팀별 미결
				nRegMi = Integer.parseInt( getMisAllotTm1.get(i).getReg_mi().toString() ) + Integer.parseInt( prim_team.get("regMi").toString() );
				getMisAllotTm1.get(i).setReg_mi(String.valueOf(nRegMi));				
			}
		}
		
		model.addAttribute("getMisAllotTm1",getMisAllotTm1);
		List<MisRegTmVO> getMisAllotTm4 = sqlSession.selectList("MisAllotTmMapper.newGetMisAllotTm4", nowVO);
		model.addAttribute("getMisAllotTm4",getMisAllotTm4);
		
		//부문별 추가 시작 by top3009		
		/** 팀 부문 선택을 위한 부문 명부로드 2019.07.08 by top3009*/
		SysAdmCodeDicVO codeVO = new SysAdmCodeDicVO();      
		codeVO.setTbl_nm("top_tm_bsc");
		codeVO.setCol_nm("team_sector");
		List<SysAdmCodeDicVO> teamSectorList = service.codeList(codeVO);
		
		long sum_reg_00 = 0;
		long sum_reg_01 = 0;
		long sum_reg_02 = 0;
		long sum_reg_03 = 0;
		long sum_reg_04 = 0;
		long sum_reg_05 = 0;
		long sum_reg_06 = 0;
		long sum_reg_07 = 0;
		long sum_reg_08 = 0;
		long sum_reg_09 = 0;
		long sum_reg_10 = 0;
		long sum_reg_11 = 0;
		long sum_reg_12 = 0;
		long sum_reg_13 = 0;
		long sum_reg_14 = 0;
		long sum_reg_15 = 0;
		long sum_reg_16 = 0;
		long sum_reg_17 = 0;
		long sum_reg_18 = 0;
		long sum_reg_19 = 0;
		long sum_reg_20 = 0;
		long sum_reg_21 = 0;
		long sum_reg_22 = 0;
		long sum_reg_23 = 0;
		long sum_reg_24 = 0;
		long sum_reg_25 = 0;
		long sum_reg_26 = 0;
		long sum_reg_27 = 0;
		long sum_reg_28 = 0;
		long sum_reg_29 = 0;
		long sum_reg_30 = 0;
		
		long sum_reg_wc_00 = 0;
		long sum_reg_wc_01 = 0;
		long sum_reg_wc_02 = 0;
		long sum_reg_wc_03 = 0;
		long sum_reg_wc_04 = 0;
		long sum_reg_wc_05 = 0;
		long sum_reg_wc_06 = 0;
		long sum_reg_wc_07 = 0;
		long sum_reg_wc_08 = 0;
		long sum_reg_wc_09 = 0;
		long sum_reg_wc_10 = 0;
		long sum_reg_wc_11 = 0;
		long sum_reg_wc_12 = 0;
		long sum_reg_wc_13 = 0;
		long sum_reg_wc_14 = 0;
		long sum_reg_wc_15 = 0;
		long sum_reg_wc_16 = 0;
		long sum_reg_wc_17 = 0;
		long sum_reg_wc_18 = 0;
		long sum_reg_wc_19 = 0;
		long sum_reg_wc_20 = 0;
		long sum_reg_wc_21 = 0;
		long sum_reg_wc_22 = 0;
		long sum_reg_wc_23 = 0;
		long sum_reg_wc_24 = 0;
		long sum_reg_wc_25 = 0;
		long sum_reg_wc_26 = 0;
		long sum_reg_wc_27 = 0;
		long sum_reg_wc_28 = 0;
		long sum_reg_wc_29 = 0;
		long sum_reg_wc_30 = 0;
		
		long sum_day_00 = 0;
		long sum_day_01 = 0;
		long sum_day_02 = 0;
		long sum_day_03 = 0;
		long sum_day_04 = 0;
		long sum_day_05 = 0;
		long sum_day_06 = 0;
		long sum_day_07 = 0;
		long sum_day_08 = 0;
		long sum_day_09 = 0;
		long sum_day_10 = 0;
		long sum_day_11 = 0;
		long sum_day_12 = 0;
		long sum_day_13 = 0;
		long sum_day_14 = 0;
		long sum_day_15 = 0;
		long sum_day_16 = 0;
		long sum_day_17 = 0;
		long sum_day_18 = 0;
		long sum_day_19 = 0;
		long sum_day_20 = 0;
		long sum_day_21 = 0;
		long sum_day_22 = 0;
		long sum_day_23 = 0;
		long sum_day_24 = 0;
		long sum_day_25 = 0;
		long sum_day_26 = 0;
		long sum_day_27 = 0;
		long sum_day_28 = 0;
		long sum_day_29 = 0;
		long sum_day_30 = 0;
		
		long sum_day_wc_00 = 0;
		long sum_day_wc_01 = 0;
		long sum_day_wc_02 = 0;
		long sum_day_wc_03 = 0;
		long sum_day_wc_04 = 0;
		long sum_day_wc_05 = 0;
		long sum_day_wc_06 = 0;
		long sum_day_wc_07 = 0;
		long sum_day_wc_08 = 0;
		long sum_day_wc_09 = 0;
		long sum_day_wc_10 = 0;
		long sum_day_wc_11 = 0;
		long sum_day_wc_12 = 0;
		long sum_day_wc_13 = 0;
		long sum_day_wc_14 = 0;
		long sum_day_wc_15 = 0;
		long sum_day_wc_16 = 0;
		long sum_day_wc_17 = 0;
		long sum_day_wc_18 = 0;
		long sum_day_wc_19 = 0;
		long sum_day_wc_20 = 0;
		long sum_day_wc_21 = 0;
		long sum_day_wc_22 = 0;
		long sum_day_wc_23 = 0;
		long sum_day_wc_24 = 0;
		long sum_day_wc_25 = 0;
		long sum_day_wc_26 = 0;
		long sum_day_wc_27 = 0;
		long sum_day_wc_28 = 0;
		long sum_day_wc_29 = 0;
		long sum_day_wc_30 = 0;

		long sum_reg_y = 0;
		long sum_reg_mi = 0;		
		long sum_cls_y = 0;	
		long sum_cls_m = 0;
		
		long sum_reg_wc_y = 0;
		long sum_reg_wc_mi = 0;		
		long sum_cls_wc_y = 0;	
		long sum_cls_wc_m = 0;
		
		String sSector = ""; 
		String sSector_val = "";
		String sSector_flag = "";	
		
		int sector_member_cnt = 0;		//부문별 인원수
		
		List<MisRegTmVO> TeamSectorListVO = new ArrayList<MisRegTmVO>();			//부문별 목록에 뿌려줄 리스트 생성
		
		//부문별 합산계산 시작
		for(int i=0; i < teamSectorList.size(); i++) {
			
			MisRegTmVO sectorBean = new MisRegTmVO();			//리스트에 넣어줄 객체 생성
			
			sSector = teamSectorList.get(i).getCol_cd();
			sSector_val = teamSectorList.get(i).getCol_val();			
			sectorBean.setTeam_sector(sSector);
			sectorBean.setTeam_sector_val(sSector_val);
			
			//팀목록에서 가져온 카운트를 체크해서 넣어준다.
			for(int k=0; k < getMisAllotTm1.size(); k++) {				
				sSector_flag = getMisAllotTm1.get(k).getTeam_sector();
				//if(sSector.equals(sSector_flag) && !"9".equals(sSector)){				//team_sector 가 0이아니고, 같은경우만 합산한다.
				if(sSector.equals(sSector_flag)){				//team_sector 가 0이아니고, 같은경우만 합산한다.
					
					sector_member_cnt += getMisAllotTm1.get(k).getMember_cnt(); 
					sum_reg_00 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_00());
					sum_reg_01 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_01());
					sum_reg_02 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_02());
					sum_reg_03 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_03());
					sum_reg_04 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_04());
					sum_reg_05 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_05());
					sum_reg_06 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_06());
					sum_reg_07 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_07());
					sum_reg_08 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_08());
					sum_reg_09 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_09());
					sum_reg_10 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_10());
					sum_reg_11 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_11());
					sum_reg_12 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_12());
					sum_reg_13 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_13());
					sum_reg_14 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_14());
					sum_reg_15 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_15());
					sum_reg_16 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_16());
					sum_reg_17 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_17());
					sum_reg_18 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_18());
					sum_reg_19 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_19());
					sum_reg_20 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_20());
					sum_reg_21 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_21());
					sum_reg_22 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_22());
					sum_reg_23 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_23());
					sum_reg_24 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_24());
					sum_reg_25 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_25());
					sum_reg_26 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_26());
					sum_reg_27 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_27());
					sum_reg_28 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_28());
					sum_reg_29 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_29());
					sum_reg_30 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_30());
					
					sum_reg_wc_00 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_00());
					sum_reg_wc_01 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_01());
					sum_reg_wc_02 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_02());
					sum_reg_wc_03 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_03());
					sum_reg_wc_04 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_04());
					sum_reg_wc_05 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_05());
					sum_reg_wc_06 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_06());
					sum_reg_wc_07 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_07());
					sum_reg_wc_08 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_08());
					sum_reg_wc_09 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_09());
					sum_reg_wc_10 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_10());
					sum_reg_wc_11 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_11());
					sum_reg_wc_12 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_12());
					sum_reg_wc_13 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_13());
					sum_reg_wc_14 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_14());
					sum_reg_wc_15 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_15());
					sum_reg_wc_16 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_16());
					sum_reg_wc_17 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_17());
					sum_reg_wc_18 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_18());
					sum_reg_wc_19 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_19());
					sum_reg_wc_20 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_20());
					sum_reg_wc_21 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_21());
					sum_reg_wc_22 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_22());
					sum_reg_wc_23 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_23());
					sum_reg_wc_24 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_24());
					sum_reg_wc_25 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_25());
					sum_reg_wc_26 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_26());
					sum_reg_wc_27 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_27());
					sum_reg_wc_28 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_28());
					sum_reg_wc_29 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_29());
					sum_reg_wc_30 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_30());
					
					sum_day_00 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_00());
					sum_day_01 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_01());
					sum_day_02 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_02());
					sum_day_03 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_03());
					sum_day_04 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_04());
					sum_day_05 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_05());
					sum_day_06 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_06());
					sum_day_07 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_07());
					sum_day_08 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_08());
					sum_day_09 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_09());
					sum_day_10 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_10());
					sum_day_11 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_11());
					sum_day_12 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_12());
					sum_day_13 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_13());
					sum_day_14 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_14());
					sum_day_15 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_15());
					sum_day_16 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_16());
					sum_day_17 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_17());
					sum_day_18 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_18());
					sum_day_19 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_19());
					sum_day_20 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_20());
					sum_day_21 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_21());
					sum_day_22 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_22());
					sum_day_23 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_23());
					sum_day_24 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_24());
					sum_day_25 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_25());
					sum_day_26 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_26());
					sum_day_27 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_27());
					sum_day_28 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_28());
					sum_day_29 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_29());
					sum_day_30 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_30());
					
					sum_day_wc_00 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_00());
					sum_day_wc_01 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_01());
					sum_day_wc_02 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_02());
					sum_day_wc_03 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_03());
					sum_day_wc_04 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_04());
					sum_day_wc_05 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_05());
					sum_day_wc_06 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_06());
					sum_day_wc_07 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_07());
					sum_day_wc_08 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_08());
					sum_day_wc_09 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_09());
					sum_day_wc_10 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_10());
					sum_day_wc_11 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_11());
					sum_day_wc_12 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_12());
					sum_day_wc_13 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_13());
					sum_day_wc_14 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_14());
					sum_day_wc_15 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_15());
					sum_day_wc_16 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_16());
					sum_day_wc_17 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_17());
					sum_day_wc_18 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_18());
					sum_day_wc_19 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_19());
					sum_day_wc_20 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_20());
					sum_day_wc_21 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_21());
					sum_day_wc_22 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_22());
					sum_day_wc_23 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_23());
					sum_day_wc_24 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_24());
					sum_day_wc_25 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_25());
					sum_day_wc_26 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_26());
					sum_day_wc_27 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_27());
					sum_day_wc_28 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_28());
					sum_day_wc_29 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_29());
					sum_day_wc_30 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_30());
					
					sum_reg_y += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_y());
					sum_reg_mi += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_mi());
					
					sum_cls_y += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getCls_y());
					sum_cls_m += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getCls_m());
					
					sum_reg_wc_y += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_y());
					sum_reg_wc_mi += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_mi());
					
					sum_cls_wc_y += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getCls_wc_y());
					sum_cls_wc_m += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getCls_wc_m());
										
				}
			}
			
			sectorBean.setMember_cnt(sector_member_cnt);
			sectorBean.setReg_00(Long.toString(sum_reg_00));
			sectorBean.setReg_01(Long.toString(sum_reg_01));
			sectorBean.setReg_02(Long.toString(sum_reg_02));
			sectorBean.setReg_03(Long.toString(sum_reg_03));
			sectorBean.setReg_04(Long.toString(sum_reg_04));
			sectorBean.setReg_05(Long.toString(sum_reg_05));
			sectorBean.setReg_06(Long.toString(sum_reg_06));
			sectorBean.setReg_07(Long.toString(sum_reg_07));
			sectorBean.setReg_08(Long.toString(sum_reg_08));
			sectorBean.setReg_09(Long.toString(sum_reg_09));
			sectorBean.setReg_10(Long.toString(sum_reg_10));
			sectorBean.setReg_11(Long.toString(sum_reg_11));
			sectorBean.setReg_12(Long.toString(sum_reg_12));
			sectorBean.setReg_13(Long.toString(sum_reg_13));
			sectorBean.setReg_14(Long.toString(sum_reg_14));
			sectorBean.setReg_15(Long.toString(sum_reg_15));
			sectorBean.setReg_16(Long.toString(sum_reg_16));
			sectorBean.setReg_17(Long.toString(sum_reg_17));
			sectorBean.setReg_18(Long.toString(sum_reg_18));
			sectorBean.setReg_19(Long.toString(sum_reg_19));
			sectorBean.setReg_20(Long.toString(sum_reg_20));
			sectorBean.setReg_21(Long.toString(sum_reg_21));
			sectorBean.setReg_22(Long.toString(sum_reg_22));
			sectorBean.setReg_23(Long.toString(sum_reg_23));
			sectorBean.setReg_24(Long.toString(sum_reg_24));
			sectorBean.setReg_25(Long.toString(sum_reg_25));
			sectorBean.setReg_26(Long.toString(sum_reg_26));
			sectorBean.setReg_27(Long.toString(sum_reg_27));
			sectorBean.setReg_28(Long.toString(sum_reg_28));
			sectorBean.setReg_29(Long.toString(sum_reg_29));
			sectorBean.setReg_30(Long.toString(sum_reg_30));
			
			sectorBean.setReg_wc_00(Long.toString(sum_reg_wc_00));
			sectorBean.setReg_wc_01(Long.toString(sum_reg_wc_01));
			sectorBean.setReg_wc_02(Long.toString(sum_reg_wc_02));
			sectorBean.setReg_wc_03(Long.toString(sum_reg_wc_03));
			sectorBean.setReg_wc_04(Long.toString(sum_reg_wc_04));
			sectorBean.setReg_wc_05(Long.toString(sum_reg_wc_05));
			sectorBean.setReg_wc_06(Long.toString(sum_reg_wc_06));
			sectorBean.setReg_wc_07(Long.toString(sum_reg_wc_07));
			sectorBean.setReg_wc_08(Long.toString(sum_reg_wc_08));
			sectorBean.setReg_wc_09(Long.toString(sum_reg_wc_09));
			sectorBean.setReg_wc_10(Long.toString(sum_reg_wc_10));
			sectorBean.setReg_wc_11(Long.toString(sum_reg_wc_11));
			sectorBean.setReg_wc_12(Long.toString(sum_reg_wc_12));
			sectorBean.setReg_wc_13(Long.toString(sum_reg_wc_13));
			sectorBean.setReg_wc_14(Long.toString(sum_reg_wc_14));
			sectorBean.setReg_wc_15(Long.toString(sum_reg_wc_15));
			sectorBean.setReg_wc_16(Long.toString(sum_reg_wc_16));
			sectorBean.setReg_wc_17(Long.toString(sum_reg_wc_17));
			sectorBean.setReg_wc_18(Long.toString(sum_reg_wc_18));
			sectorBean.setReg_wc_19(Long.toString(sum_reg_wc_19));
			sectorBean.setReg_wc_20(Long.toString(sum_reg_wc_20));
			sectorBean.setReg_wc_21(Long.toString(sum_reg_wc_21));
			sectorBean.setReg_wc_22(Long.toString(sum_reg_wc_22));
			sectorBean.setReg_wc_23(Long.toString(sum_reg_wc_23));
			sectorBean.setReg_wc_24(Long.toString(sum_reg_wc_24));
			sectorBean.setReg_wc_25(Long.toString(sum_reg_wc_25));
			sectorBean.setReg_wc_26(Long.toString(sum_reg_wc_26));
			sectorBean.setReg_wc_27(Long.toString(sum_reg_wc_27));
			sectorBean.setReg_wc_28(Long.toString(sum_reg_wc_28));
			sectorBean.setReg_wc_29(Long.toString(sum_reg_wc_29));
			sectorBean.setReg_wc_30(Long.toString(sum_reg_wc_30));
			
			sectorBean.setDay_00(Long.toString(sum_day_00));
			sectorBean.setDay_01(Long.toString(sum_day_01));
			sectorBean.setDay_02(Long.toString(sum_day_02));
			sectorBean.setDay_03(Long.toString(sum_day_03));
			sectorBean.setDay_04(Long.toString(sum_day_04));
			sectorBean.setDay_05(Long.toString(sum_day_05));
			sectorBean.setDay_06(Long.toString(sum_day_06));
			sectorBean.setDay_07(Long.toString(sum_day_07));
			sectorBean.setDay_08(Long.toString(sum_day_08));
			sectorBean.setDay_09(Long.toString(sum_day_09));
			sectorBean.setDay_10(Long.toString(sum_day_10));
			sectorBean.setDay_11(Long.toString(sum_day_11));
			sectorBean.setDay_12(Long.toString(sum_day_12));
			sectorBean.setDay_13(Long.toString(sum_day_13));
			sectorBean.setDay_14(Long.toString(sum_day_14));
			sectorBean.setDay_15(Long.toString(sum_day_15));
			sectorBean.setDay_16(Long.toString(sum_day_16));
			sectorBean.setDay_17(Long.toString(sum_day_17));
			sectorBean.setDay_18(Long.toString(sum_day_18));
			sectorBean.setDay_19(Long.toString(sum_day_19));
			sectorBean.setDay_20(Long.toString(sum_day_20));
			sectorBean.setDay_21(Long.toString(sum_day_21));
			sectorBean.setDay_22(Long.toString(sum_day_22));
			sectorBean.setDay_23(Long.toString(sum_day_23));
			sectorBean.setDay_24(Long.toString(sum_day_24));
			sectorBean.setDay_25(Long.toString(sum_day_25));
			sectorBean.setDay_26(Long.toString(sum_day_26));
			sectorBean.setDay_27(Long.toString(sum_day_27));
			sectorBean.setDay_28(Long.toString(sum_day_28));
			sectorBean.setDay_29(Long.toString(sum_day_29));
			sectorBean.setDay_30(Long.toString(sum_day_30));
			
			sectorBean.setDay_wc_00(Long.toString(sum_day_wc_00));
			sectorBean.setDay_wc_01(Long.toString(sum_day_wc_01));
			sectorBean.setDay_wc_02(Long.toString(sum_day_wc_02));
			sectorBean.setDay_wc_03(Long.toString(sum_day_wc_03));
			sectorBean.setDay_wc_04(Long.toString(sum_day_wc_04));
			sectorBean.setDay_wc_05(Long.toString(sum_day_wc_05));
			sectorBean.setDay_wc_06(Long.toString(sum_day_wc_06));
			sectorBean.setDay_wc_07(Long.toString(sum_day_wc_07));
			sectorBean.setDay_wc_08(Long.toString(sum_day_wc_08));
			sectorBean.setDay_wc_09(Long.toString(sum_day_wc_09));
			sectorBean.setDay_wc_10(Long.toString(sum_day_wc_10));
			sectorBean.setDay_wc_11(Long.toString(sum_day_wc_11));
			sectorBean.setDay_wc_12(Long.toString(sum_day_wc_12));
			sectorBean.setDay_wc_13(Long.toString(sum_day_wc_13));
			sectorBean.setDay_wc_14(Long.toString(sum_day_wc_14));
			sectorBean.setDay_wc_15(Long.toString(sum_day_wc_15));
			sectorBean.setDay_wc_16(Long.toString(sum_day_wc_16));
			sectorBean.setDay_wc_17(Long.toString(sum_day_wc_17));
			sectorBean.setDay_wc_18(Long.toString(sum_day_wc_18));
			sectorBean.setDay_wc_19(Long.toString(sum_day_wc_19));
			sectorBean.setDay_wc_20(Long.toString(sum_day_wc_20));
			sectorBean.setDay_wc_21(Long.toString(sum_day_wc_21));
			sectorBean.setDay_wc_22(Long.toString(sum_day_wc_22));
			sectorBean.setDay_wc_23(Long.toString(sum_day_wc_23));
			sectorBean.setDay_wc_24(Long.toString(sum_day_wc_24));
			sectorBean.setDay_wc_25(Long.toString(sum_day_wc_25));
			sectorBean.setDay_wc_26(Long.toString(sum_day_wc_26));
			sectorBean.setDay_wc_27(Long.toString(sum_day_wc_27));
			sectorBean.setDay_wc_28(Long.toString(sum_day_wc_28));
			sectorBean.setDay_wc_29(Long.toString(sum_day_wc_29));
			sectorBean.setDay_wc_30(Long.toString(sum_day_wc_30));
			
			sectorBean.setReg_y(Long.toString(sum_reg_y));
			sectorBean.setReg_mi(Long.toString(sum_reg_mi));
			sectorBean.setCls_y(Long.toString(sum_cls_y));
			sectorBean.setCls_m(Long.toString(sum_cls_m));
			
			sectorBean.setReg_wc_y(Long.toString(sum_reg_wc_y));
			sectorBean.setReg_wc_mi(Long.toString(sum_reg_wc_mi));
			sectorBean.setCls_wc_y(Long.toString(sum_cls_wc_y));
			sectorBean.setCls_wc_m(Long.toString(sum_cls_wc_m));
			
			//서면심사 부문 표시 여부 확인
			long sum_sector_all = sum_reg_wc_00 + sum_reg_wc_01 + sum_reg_wc_02 + sum_reg_wc_03 + sum_reg_wc_04
					+ sum_reg_wc_05 + sum_reg_wc_06 + sum_reg_wc_07 + sum_reg_wc_08 + sum_reg_wc_09 + sum_reg_wc_10
					+ sum_reg_wc_11 + sum_reg_wc_12 + sum_reg_wc_13 + sum_reg_wc_14 + sum_reg_wc_15 + sum_reg_wc_16
					+ sum_reg_wc_17 + sum_reg_wc_18 + sum_reg_wc_19 + sum_reg_wc_20 + sum_reg_wc_21 + sum_reg_wc_22
					+ sum_reg_wc_23 + sum_reg_wc_24 + sum_reg_wc_25 + sum_reg_wc_26 + sum_reg_wc_27 + sum_reg_wc_28
					+ sum_reg_wc_29 + sum_reg_wc_30 + sum_day_wc_00 + sum_day_wc_01 + sum_day_wc_02 + sum_day_wc_03
					+ sum_day_wc_04 + sum_day_wc_05 + sum_day_wc_06 + sum_day_wc_07 + sum_day_wc_08 + sum_day_wc_09
					+ sum_day_wc_10 + sum_day_wc_11 + sum_day_wc_12 + sum_day_wc_13 + sum_day_wc_14 + sum_day_wc_15
					+ sum_day_wc_16 + sum_day_wc_17 + sum_day_wc_18 + sum_day_wc_19 + sum_day_wc_20 + sum_day_wc_21
					+ sum_day_wc_22 + sum_day_wc_23 + sum_day_wc_24 + sum_day_wc_25 + sum_day_wc_26 + sum_day_wc_27
					+ sum_day_wc_28 + sum_day_wc_29 + sum_day_wc_30;
		
			if( sum_sector_all == 0) {
				sectorBean.setWc_sector_flag("0");
			}else{
				sectorBean.setWc_sector_flag("1");
			}			
			
			TeamSectorListVO.add(i, sectorBean);
			
			//변수초기화
			sector_member_cnt = 0;
			sum_reg_00 = 0;
			sum_reg_01 = 0;
			sum_reg_02 = 0;
			sum_reg_03 = 0;
			sum_reg_04 = 0;
			sum_reg_05 = 0;
			sum_reg_06 = 0;
			sum_reg_07 = 0;
			sum_reg_08 = 0;
			sum_reg_09 = 0;
			sum_reg_10 = 0;
			sum_reg_11 = 0;
			sum_reg_12 = 0;
			sum_reg_13 = 0;
			sum_reg_14 = 0;
			sum_reg_15 = 0;
			sum_reg_16 = 0;
			sum_reg_17 = 0;
			sum_reg_18 = 0;
			sum_reg_19 = 0;
			sum_reg_20 = 0;
			sum_reg_21 = 0;
			sum_reg_22 = 0;
			sum_reg_23 = 0;
			sum_reg_24 = 0;
			sum_reg_25 = 0;
			sum_reg_26 = 0;
			sum_reg_27 = 0;
			sum_reg_28 = 0;
			sum_reg_29 = 0;
			sum_reg_30 = 0;
			
			sum_reg_wc_00 = 0;
			sum_reg_wc_01 = 0;
			sum_reg_wc_02 = 0;
			sum_reg_wc_03 = 0;
			sum_reg_wc_04 = 0;
			sum_reg_wc_05 = 0;
			sum_reg_wc_06 = 0;
			sum_reg_wc_07 = 0;
			sum_reg_wc_08 = 0;
			sum_reg_wc_09 = 0;
			sum_reg_wc_10 = 0;
			sum_reg_wc_11 = 0;
			sum_reg_wc_12 = 0;
			sum_reg_wc_13 = 0;
			sum_reg_wc_14 = 0;
			sum_reg_wc_15 = 0;
			sum_reg_wc_16 = 0;
			sum_reg_wc_17 = 0;
			sum_reg_wc_18 = 0;
			sum_reg_wc_19 = 0;
			sum_reg_wc_20 = 0;
			sum_reg_wc_21 = 0;
			sum_reg_wc_22 = 0;
			sum_reg_wc_23 = 0;
			sum_reg_wc_24 = 0;
			sum_reg_wc_25 = 0;
			sum_reg_wc_26 = 0;
			sum_reg_wc_27 = 0;
			sum_reg_wc_28 = 0;
			sum_reg_wc_29 = 0;
			sum_reg_wc_30 = 0;
			
			sum_day_00 = 0;
			sum_day_01 = 0;
			sum_day_02 = 0;
			sum_day_03 = 0;
			sum_day_04 = 0;
			sum_day_05 = 0;
			sum_day_06 = 0;
			sum_day_07 = 0;
			sum_day_08 = 0;
			sum_day_09 = 0;
			sum_day_10 = 0;
			sum_day_11 = 0;
			sum_day_12 = 0;
			sum_day_13 = 0;
			sum_day_14 = 0;
			sum_day_15 = 0;
			sum_day_16 = 0;
			sum_day_17 = 0;
			sum_day_18 = 0;
			sum_day_19 = 0;
			sum_day_20 = 0;
			sum_day_21 = 0;
			sum_day_22 = 0;
			sum_day_23 = 0;
			sum_day_24 = 0;
			sum_day_25 = 0;
			sum_day_26 = 0;
			sum_day_27 = 0;
			sum_day_28 = 0;
			sum_day_29 = 0;
			sum_day_30 = 0;
			
			sum_day_wc_00 = 0;
			sum_day_wc_01 = 0;
			sum_day_wc_02 = 0;
			sum_day_wc_03 = 0;
			sum_day_wc_04 = 0;
			sum_day_wc_05 = 0;
			sum_day_wc_06 = 0;
			sum_day_wc_07 = 0;
			sum_day_wc_08 = 0;
			sum_day_wc_09 = 0;
			sum_day_wc_10 = 0;
			sum_day_wc_11 = 0;
			sum_day_wc_12 = 0;
			sum_day_wc_13 = 0;
			sum_day_wc_14 = 0;
			sum_day_wc_15 = 0;
			sum_day_wc_16 = 0;
			sum_day_wc_17 = 0;
			sum_day_wc_18 = 0;
			sum_day_wc_19 = 0;
			sum_day_wc_20 = 0;
			sum_day_wc_21 = 0;
			sum_day_wc_22 = 0;
			sum_day_wc_23 = 0;
			sum_day_wc_24 = 0;
			sum_day_wc_25 = 0;
			sum_day_wc_26 = 0;
			sum_day_wc_27 = 0;
			sum_day_wc_28 = 0;
			sum_day_wc_29 = 0;
			sum_day_wc_30 = 0;

			sum_reg_y = 0;			
			sum_reg_mi = 0;		
			sum_cls_y = 0;	
			sum_cls_m = 0;
			
			sum_reg_wc_y = 0;			
			sum_reg_wc_mi = 0;		
			sum_cls_wc_y = 0;	
			sum_cls_wc_m = 0;
		}
		
		model.addAttribute("TeamSectorListVO", TeamSectorListVO);

		//부문별 추가 끝 by top3009
		
		//4종 부분별 추가 시작
		List<MisRegTmVO> TeamSector4ListVO = new ArrayList<MisRegTmVO>();			//부문별 목록에 뿌려줄 리스트 생성
		
		//부문별 합산계산 시작
		for(int i=0; i < teamSectorList.size(); i++) {
			
			MisRegTmVO sector4Bean = new MisRegTmVO();			//리스트에 넣어줄 객체 생성
			
			sSector = teamSectorList.get(i).getCol_cd();
			sSector_val = teamSectorList.get(i).getCol_val();			
			sector4Bean.setTeam_sector(sSector);
			sector4Bean.setTeam_sector_val(sSector_val);
			
			//팀목록에서 가져온 카운트를 체크해서 넣어준다.
			for(int k=0; k < getMisAllotTm4.size(); k++) {
				sSector_flag = getMisAllotTm4.get(k).getTeam_sector();
				if(sSector.equals(sSector_flag)){				//team_sector 가 0이아니고, 같은경우만 합산한다.					
					sector_member_cnt += getMisAllotTm4.get(k).getMember_cnt(); 
					sum_reg_00 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_00());
					sum_reg_01 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_01());
					sum_reg_02 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_02());
					sum_reg_03 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_03());
					sum_reg_04 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_04());
					sum_reg_05 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_05());
					sum_reg_06 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_06());
					sum_reg_07 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_07());
					sum_reg_08 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_08());
					sum_reg_09 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_09());
					sum_reg_10 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_10());
					sum_reg_11 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_11());
					sum_reg_12 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_12());
					sum_reg_13 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_13());
					sum_reg_14 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_14());
					sum_reg_15 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_15());
					sum_reg_16 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_16());
					sum_reg_17 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_17());
					sum_reg_18 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_18());
					sum_reg_19 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_19());
					sum_reg_20 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_20());
					sum_reg_21 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_21());
					sum_reg_22 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_22());
					sum_reg_23 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_23());
					sum_reg_24 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_24());
					sum_reg_25 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_25());
					sum_reg_26 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_26());
					sum_reg_27 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_27());
					sum_reg_28 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_28());
					sum_reg_29 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_29());
					sum_reg_30 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_30());
															
					sum_day_00 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_00());
					sum_day_01 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_01());
					sum_day_02 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_02());
					sum_day_03 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_03());
					sum_day_04 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_04());
					sum_day_05 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_05());
					sum_day_06 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_06());
					sum_day_07 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_07());
					sum_day_08 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_08());
					sum_day_09 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_09());
					sum_day_10 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_10());
					sum_day_11 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_11());
					sum_day_12 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_12());
					sum_day_13 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_13());
					sum_day_14 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_14());
					sum_day_15 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_15());
					sum_day_16 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_16());
					sum_day_17 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_17());
					sum_day_18 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_18());
					sum_day_19 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_19());
					sum_day_20 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_20());
					sum_day_21 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_21());
					sum_day_22 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_22());
					sum_day_23 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_23());
					sum_day_24 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_24());
					sum_day_25 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_25());
					sum_day_26 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_26());
					sum_day_27 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_27());
					sum_day_28 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_28());
					sum_day_29 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_29());
					sum_day_30 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_30());
					
					sum_reg_y += WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_y());
					sum_reg_mi += WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_mi());
					
					sum_cls_y += WebUtil.parseStringToLong(getMisAllotTm4.get(k).getCls_y());
					sum_cls_m += WebUtil.parseStringToLong(getMisAllotTm4.get(k).getCls_m());					
				}
			}
			
			sector4Bean.setMember_cnt(sector_member_cnt);			
			sector4Bean.setReg_00(Long.toString(sum_reg_00));
			sector4Bean.setReg_01(Long.toString(sum_reg_01));
			sector4Bean.setReg_02(Long.toString(sum_reg_02));
			sector4Bean.setReg_03(Long.toString(sum_reg_03));
			sector4Bean.setReg_04(Long.toString(sum_reg_04));
			sector4Bean.setReg_05(Long.toString(sum_reg_05));
			sector4Bean.setReg_06(Long.toString(sum_reg_06));
			sector4Bean.setReg_07(Long.toString(sum_reg_07));
			sector4Bean.setReg_08(Long.toString(sum_reg_08));
			sector4Bean.setReg_09(Long.toString(sum_reg_09));
			sector4Bean.setReg_10(Long.toString(sum_reg_10));
			sector4Bean.setReg_11(Long.toString(sum_reg_11));
			sector4Bean.setReg_12(Long.toString(sum_reg_12));
			sector4Bean.setReg_13(Long.toString(sum_reg_13));
			sector4Bean.setReg_14(Long.toString(sum_reg_14));
			sector4Bean.setReg_15(Long.toString(sum_reg_15));
			sector4Bean.setReg_16(Long.toString(sum_reg_16));
			sector4Bean.setReg_17(Long.toString(sum_reg_17));
			sector4Bean.setReg_18(Long.toString(sum_reg_18));
			sector4Bean.setReg_19(Long.toString(sum_reg_19));
			sector4Bean.setReg_20(Long.toString(sum_reg_20));
			sector4Bean.setReg_21(Long.toString(sum_reg_21));
			sector4Bean.setReg_22(Long.toString(sum_reg_22));
			sector4Bean.setReg_23(Long.toString(sum_reg_23));
			sector4Bean.setReg_24(Long.toString(sum_reg_24));
			sector4Bean.setReg_25(Long.toString(sum_reg_25));
			sector4Bean.setReg_26(Long.toString(sum_reg_26));
			sector4Bean.setReg_27(Long.toString(sum_reg_27));
			sector4Bean.setReg_28(Long.toString(sum_reg_28));
			sector4Bean.setReg_29(Long.toString(sum_reg_29));
			sector4Bean.setReg_30(Long.toString(sum_reg_30));
			
			sector4Bean.setDay_00(Long.toString(sum_day_00));
			sector4Bean.setDay_01(Long.toString(sum_day_01));
			sector4Bean.setDay_02(Long.toString(sum_day_02));
			sector4Bean.setDay_03(Long.toString(sum_day_03));
			sector4Bean.setDay_04(Long.toString(sum_day_04));
			sector4Bean.setDay_05(Long.toString(sum_day_05));
			sector4Bean.setDay_06(Long.toString(sum_day_06));
			sector4Bean.setDay_07(Long.toString(sum_day_07));
			sector4Bean.setDay_08(Long.toString(sum_day_08));
			sector4Bean.setDay_09(Long.toString(sum_day_09));
			sector4Bean.setDay_10(Long.toString(sum_day_10));
			sector4Bean.setDay_11(Long.toString(sum_day_11));
			sector4Bean.setDay_12(Long.toString(sum_day_12));
			sector4Bean.setDay_13(Long.toString(sum_day_13));
			sector4Bean.setDay_14(Long.toString(sum_day_14));
			sector4Bean.setDay_15(Long.toString(sum_day_15));
			sector4Bean.setDay_16(Long.toString(sum_day_16));
			sector4Bean.setDay_17(Long.toString(sum_day_17));
			sector4Bean.setDay_18(Long.toString(sum_day_18));
			sector4Bean.setDay_19(Long.toString(sum_day_19));
			sector4Bean.setDay_20(Long.toString(sum_day_20));
			sector4Bean.setDay_21(Long.toString(sum_day_21));
			sector4Bean.setDay_22(Long.toString(sum_day_22));
			sector4Bean.setDay_23(Long.toString(sum_day_23));
			sector4Bean.setDay_24(Long.toString(sum_day_24));
			sector4Bean.setDay_25(Long.toString(sum_day_25));
			sector4Bean.setDay_26(Long.toString(sum_day_26));
			sector4Bean.setDay_27(Long.toString(sum_day_27));
			sector4Bean.setDay_28(Long.toString(sum_day_28));
			sector4Bean.setDay_29(Long.toString(sum_day_29));
			sector4Bean.setDay_30(Long.toString(sum_day_30));
			
			sector4Bean.setReg_y(Long.toString(sum_reg_y));
			sector4Bean.setReg_mi(Long.toString(sum_reg_mi));
			sector4Bean.setCls_y(Long.toString(sum_cls_y));
			sector4Bean.setCls_m(Long.toString(sum_cls_m));
			
			TeamSector4ListVO.add(i, sector4Bean);
			
			//변수초기화
			sector_member_cnt = 0;
			sum_reg_00 = 0;
			sum_reg_01 = 0;
			sum_reg_02 = 0;
			sum_reg_03 = 0;
			sum_reg_04 = 0;
			sum_reg_05 = 0;
			sum_reg_06 = 0;
			sum_reg_07 = 0;
			sum_reg_08 = 0;
			sum_reg_09 = 0;
			sum_reg_10 = 0;
			sum_reg_11 = 0;
			sum_reg_12 = 0;
			sum_reg_13 = 0;
			sum_reg_14 = 0;
			sum_reg_15 = 0;
			sum_reg_16 = 0;
			sum_reg_17 = 0;
			sum_reg_18 = 0;
			sum_reg_19 = 0;
			sum_reg_20 = 0;
			sum_reg_21 = 0;
			sum_reg_22 = 0;
			sum_reg_23 = 0;
			sum_reg_24 = 0;
			sum_reg_25 = 0;
			sum_reg_26 = 0;
			sum_reg_27 = 0;
			sum_reg_28 = 0;
			sum_reg_29 = 0;
			sum_reg_30 = 0;
									
			sum_day_00 = 0;
			sum_day_01 = 0;
			sum_day_02 = 0;
			sum_day_03 = 0;
			sum_day_04 = 0;
			sum_day_05 = 0;
			sum_day_06 = 0;
			sum_day_07 = 0;
			sum_day_08 = 0;
			sum_day_09 = 0;
			sum_day_10 = 0;
			sum_day_11 = 0;
			sum_day_12 = 0;
			sum_day_13 = 0;
			sum_day_14 = 0;
			sum_day_15 = 0;
			sum_day_16 = 0;
			sum_day_17 = 0;
			sum_day_18 = 0;
			sum_day_19 = 0;
			sum_day_20 = 0;
			sum_day_21 = 0;
			sum_day_22 = 0;
			sum_day_23 = 0;
			sum_day_24 = 0;
			sum_day_25 = 0;
			sum_day_26 = 0;
			sum_day_27 = 0;
			sum_day_28 = 0;
			sum_day_29 = 0;
			sum_day_30 = 0;
						
			sum_reg_y = 0;			
			sum_reg_mi = 0;		
			sum_cls_y = 0;	
			sum_cls_m = 0;
			
		}
		
		model.addAttribute("TeamSector4ListVO", TeamSector4ListVO);		
		//4종 부분별 추가 끝
		
		
		/** 팀 부문 선택을 위한 부문 명부로드 2019.07.08 by top3009*/		      
		codeVO.setTbl_nm("top_tm_bsc");
		codeVO.setCol_nm("team_center");
		List<SysAdmCodeDicVO> teamCenterList = service.codeList(codeVO);
		
		long sum_reg_center_00 = 0;
		long sum_reg_center_01 = 0;
		long sum_reg_center_02 = 0;
		long sum_reg_center_03 = 0;
		long sum_reg_center_04 = 0;
		long sum_reg_center_05 = 0;
		long sum_reg_center_06 = 0;
		long sum_reg_center_07 = 0;
		long sum_reg_center_08 = 0;
		long sum_reg_center_09 = 0;
		long sum_reg_center_10 = 0;
		long sum_reg_center_11 = 0;
		long sum_reg_center_12 = 0;
		long sum_reg_center_13 = 0;
		long sum_reg_center_14 = 0;
		long sum_reg_center_15 = 0;
		long sum_reg_center_16 = 0;
		long sum_reg_center_17 = 0;
		long sum_reg_center_18 = 0;
		long sum_reg_center_19 = 0;
		long sum_reg_center_20 = 0;
		long sum_reg_center_21 = 0;
		long sum_reg_center_22 = 0;
		long sum_reg_center_23 = 0;
		long sum_reg_center_24 = 0;
		long sum_reg_center_25 = 0;
		long sum_reg_center_26 = 0;
		long sum_reg_center_27 = 0;
		long sum_reg_center_28 = 0;
		long sum_reg_center_29 = 0;
		long sum_reg_center_30 = 0;
		
		long sum_reg_center_wc_00 = 0;
		long sum_reg_center_wc_01 = 0;
		long sum_reg_center_wc_02 = 0;
		long sum_reg_center_wc_03 = 0;
		long sum_reg_center_wc_04 = 0;
		long sum_reg_center_wc_05 = 0;
		long sum_reg_center_wc_06 = 0;
		long sum_reg_center_wc_07 = 0;
		long sum_reg_center_wc_08 = 0;
		long sum_reg_center_wc_09 = 0;
		long sum_reg_center_wc_10 = 0;
		long sum_reg_center_wc_11 = 0;
		long sum_reg_center_wc_12 = 0;
		long sum_reg_center_wc_13 = 0;
		long sum_reg_center_wc_14 = 0;
		long sum_reg_center_wc_15 = 0;
		long sum_reg_center_wc_16 = 0;
		long sum_reg_center_wc_17 = 0;
		long sum_reg_center_wc_18 = 0;
		long sum_reg_center_wc_19 = 0;
		long sum_reg_center_wc_20 = 0;
		long sum_reg_center_wc_21 = 0;
		long sum_reg_center_wc_22 = 0;
		long sum_reg_center_wc_23 = 0;
		long sum_reg_center_wc_24 = 0;
		long sum_reg_center_wc_25 = 0;
		long sum_reg_center_wc_26 = 0;
		long sum_reg_center_wc_27 = 0;
		long sum_reg_center_wc_28 = 0;
		long sum_reg_center_wc_29 = 0;
		long sum_reg_center_wc_30 = 0;
		
		long sum_day_center_00 = 0;
		long sum_day_center_01 = 0;
		long sum_day_center_02 = 0;
		long sum_day_center_03 = 0;
		long sum_day_center_04 = 0;
		long sum_day_center_05 = 0;
		long sum_day_center_06 = 0;
		long sum_day_center_07 = 0;
		long sum_day_center_08 = 0;
		long sum_day_center_09 = 0;
		long sum_day_center_10 = 0;
		long sum_day_center_11 = 0;
		long sum_day_center_12 = 0;
		long sum_day_center_13 = 0;
		long sum_day_center_14 = 0;
		long sum_day_center_15 = 0;
		long sum_day_center_16 = 0;
		long sum_day_center_17 = 0;
		long sum_day_center_18 = 0;
		long sum_day_center_19 = 0;
		long sum_day_center_20 = 0;
		long sum_day_center_21 = 0;
		long sum_day_center_22 = 0;
		long sum_day_center_23 = 0;
		long sum_day_center_24 = 0;
		long sum_day_center_25 = 0;
		long sum_day_center_26 = 0;
		long sum_day_center_27 = 0;
		long sum_day_center_28 = 0;
		long sum_day_center_29 = 0;
		long sum_day_center_30 = 0;
		
		long sum_day_center_wc_00 = 0;
		long sum_day_center_wc_01 = 0;
		long sum_day_center_wc_02 = 0;
		long sum_day_center_wc_03 = 0;
		long sum_day_center_wc_04 = 0;
		long sum_day_center_wc_05 = 0;
		long sum_day_center_wc_06 = 0;
		long sum_day_center_wc_07 = 0;
		long sum_day_center_wc_08 = 0;
		long sum_day_center_wc_09 = 0;
		long sum_day_center_wc_10 = 0;
		long sum_day_center_wc_11 = 0;
		long sum_day_center_wc_12 = 0;
		long sum_day_center_wc_13 = 0;
		long sum_day_center_wc_14 = 0;
		long sum_day_center_wc_15 = 0;
		long sum_day_center_wc_16 = 0;
		long sum_day_center_wc_17 = 0;
		long sum_day_center_wc_18 = 0;
		long sum_day_center_wc_19 = 0;
		long sum_day_center_wc_20 = 0;
		long sum_day_center_wc_21 = 0;
		long sum_day_center_wc_22 = 0;
		long sum_day_center_wc_23 = 0;
		long sum_day_center_wc_24 = 0;
		long sum_day_center_wc_25 = 0;
		long sum_day_center_wc_26 = 0;
		long sum_day_center_wc_27 = 0;
		long sum_day_center_wc_28 = 0;
		long sum_day_center_wc_29 = 0;
		long sum_day_center_wc_30 = 0;

		long sum_reg_center_y = 0;
		long sum_reg_center_mi = 0;		
		long sum_cls_center_y = 0;	
		long sum_cls_center_m = 0;
		
		long sum_reg_center_wc_y = 0;
		long sum_reg_center_wc_mi = 0;		
		long sum_cls_center_wc_y = 0;	
		long sum_cls_center_wc_m = 0;
		
		String sCenter = ""; 
		String sCenter_val = "";
		String sCenter_flag = "";		
		
		int center_member_cnt = 0;
		
		List<MisRegTmVO> TeamCenterListVO = new ArrayList<MisRegTmVO>();			//부문별 목록에 뿌려줄 리스트 생성
		
		//부문별 합산계산 시작
		for(int i=0; i < teamCenterList.size(); i++) {
			
			MisRegTmVO centerBean = new MisRegTmVO();			//리스트에 넣어줄 객체 생성
			
			sCenter = teamCenterList.get(i).getCol_cd();
			sCenter_val = teamCenterList.get(i).getCol_val();			
			centerBean.setTeam_center(sCenter);
			centerBean.setTeam_center_val(sCenter_val);
			
			//팀목록에서 가져온 카운트를 체크해서 넣어준다.
			for(int k=0; k < getMisAllotTm1.size(); k++) {				
				sCenter_flag = getMisAllotTm1.get(k).getTeam_center();
				if(sCenter.equals(sCenter_flag) && !"0".equals(sCenter)){				//team_center 가 0이아니고, 같은경우만 합산한다.
					
					center_member_cnt += getMisAllotTm1.get(k).getMember_cnt();
					
					sum_reg_center_00 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_00());
					sum_reg_center_01 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_01());
					sum_reg_center_02 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_02());
					sum_reg_center_03 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_03());
					sum_reg_center_04 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_04());
					sum_reg_center_05 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_05());
					sum_reg_center_06 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_06());
					sum_reg_center_07 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_07());
					sum_reg_center_08 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_08());
					sum_reg_center_09 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_09());
					sum_reg_center_10 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_10());
					sum_reg_center_11 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_11());
					sum_reg_center_12 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_12());
					sum_reg_center_13 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_13());
					sum_reg_center_14 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_14());
					sum_reg_center_15 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_15());
					sum_reg_center_16 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_16());
					sum_reg_center_17 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_17());
					sum_reg_center_18 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_18());
					sum_reg_center_19 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_19());
					sum_reg_center_20 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_20());
					sum_reg_center_21 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_21());
					sum_reg_center_22 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_22());
					sum_reg_center_23 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_23());
					sum_reg_center_24 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_24());
					sum_reg_center_25 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_25());
					sum_reg_center_26 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_26());
					sum_reg_center_27 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_27());
					sum_reg_center_28 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_28());
					sum_reg_center_29 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_29());
					sum_reg_center_30 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_30());
					
					sum_reg_center_wc_00 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_00());
					sum_reg_center_wc_01 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_01());
					sum_reg_center_wc_02 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_02());
					sum_reg_center_wc_03 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_03());
					sum_reg_center_wc_04 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_04());
					sum_reg_center_wc_05 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_05());
					sum_reg_center_wc_06 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_06());
					sum_reg_center_wc_07 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_07());
					sum_reg_center_wc_08 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_08());
					sum_reg_center_wc_09 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_09());
					sum_reg_center_wc_10 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_10());
					sum_reg_center_wc_11 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_11());
					sum_reg_center_wc_12 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_12());
					sum_reg_center_wc_13 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_13());
					sum_reg_center_wc_14 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_14());
					sum_reg_center_wc_15 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_15());
					sum_reg_center_wc_16 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_16());
					sum_reg_center_wc_17 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_17());
					sum_reg_center_wc_18 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_18());
					sum_reg_center_wc_19 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_19());
					sum_reg_center_wc_20 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_20());
					sum_reg_center_wc_21 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_21());
					sum_reg_center_wc_22 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_22());
					sum_reg_center_wc_23 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_23());
					sum_reg_center_wc_24 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_24());
					sum_reg_center_wc_25 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_25());
					sum_reg_center_wc_26 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_26());
					sum_reg_center_wc_27 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_27());
					sum_reg_center_wc_28 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_28());
					sum_reg_center_wc_29 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_29());
					sum_reg_center_wc_30 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_30());
					
					sum_day_center_00 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_00());
					sum_day_center_01 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_01());
					sum_day_center_02 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_02());
					sum_day_center_03 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_03());
					sum_day_center_04 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_04());
					sum_day_center_05 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_05());
					sum_day_center_06 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_06());
					sum_day_center_07 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_07());
					sum_day_center_08 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_08());
					sum_day_center_09 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_09());
					sum_day_center_10 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_10());
					sum_day_center_11 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_11());
					sum_day_center_12 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_12());
					sum_day_center_13 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_13());
					sum_day_center_14 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_14());
					sum_day_center_15 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_15());
					sum_day_center_16 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_16());
					sum_day_center_17 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_17());
					sum_day_center_18 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_18());
					sum_day_center_19 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_19());
					sum_day_center_20 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_20());
					sum_day_center_21 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_21());
					sum_day_center_22 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_22());
					sum_day_center_23 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_23());
					sum_day_center_24 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_24());
					sum_day_center_25 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_25());
					sum_day_center_26 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_26());
					sum_day_center_27 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_27());
					sum_day_center_28 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_28());
					sum_day_center_29 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_29());
					sum_day_center_30 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_30());
					
					sum_day_center_wc_00 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_00());
					sum_day_center_wc_01 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_01());
					sum_day_center_wc_02 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_02());
					sum_day_center_wc_03 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_03());
					sum_day_center_wc_04 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_04());
					sum_day_center_wc_05 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_05());
					sum_day_center_wc_06 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_06());
					sum_day_center_wc_07 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_07());
					sum_day_center_wc_08 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_08());
					sum_day_center_wc_09 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_09());
					sum_day_center_wc_10 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_10());
					sum_day_center_wc_11 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_11());
					sum_day_center_wc_12 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_12());
					sum_day_center_wc_13 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_13());
					sum_day_center_wc_14 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_14());
					sum_day_center_wc_15 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_15());
					sum_day_center_wc_16 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_16());
					sum_day_center_wc_17 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_17());
					sum_day_center_wc_18 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_18());
					sum_day_center_wc_19 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_19());
					sum_day_center_wc_20 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_20());
					sum_day_center_wc_21 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_21());
					sum_day_center_wc_22 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_22());
					sum_day_center_wc_23 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_23());
					sum_day_center_wc_24 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_24());
					sum_day_center_wc_25 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_25());
					sum_day_center_wc_26 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_26());
					sum_day_center_wc_27 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_27());
					sum_day_center_wc_28 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_28());
					sum_day_center_wc_29 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_29());
					sum_day_center_wc_30 +=  WebUtil.parseStringToLong(getMisAllotTm1.get(k).getDay_wc_30());
					
					sum_reg_center_y += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_y());
					sum_reg_center_mi += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_mi());
					
					sum_cls_center_y += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getCls_y());
					sum_cls_center_m += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getCls_m());
					
					sum_reg_center_wc_y += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_y());
					sum_reg_center_wc_mi += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getReg_wc_mi());
					
					sum_cls_center_wc_y += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getCls_wc_y());
					sum_cls_center_wc_m += WebUtil.parseStringToLong(getMisAllotTm1.get(k).getCls_wc_m());
										
				}
			}
			
			centerBean.setMember_cnt(center_member_cnt);
			centerBean.setReg_00(Long.toString(sum_reg_center_00));
			centerBean.setReg_01(Long.toString(sum_reg_center_01));
			centerBean.setReg_02(Long.toString(sum_reg_center_02));
			centerBean.setReg_03(Long.toString(sum_reg_center_03));
			centerBean.setReg_04(Long.toString(sum_reg_center_04));
			centerBean.setReg_05(Long.toString(sum_reg_center_05));
			centerBean.setReg_06(Long.toString(sum_reg_center_06));
			centerBean.setReg_07(Long.toString(sum_reg_center_07));
			centerBean.setReg_08(Long.toString(sum_reg_center_08));
			centerBean.setReg_09(Long.toString(sum_reg_center_09));
			centerBean.setReg_10(Long.toString(sum_reg_center_10));
			centerBean.setReg_11(Long.toString(sum_reg_center_11));
			centerBean.setReg_12(Long.toString(sum_reg_center_12));
			centerBean.setReg_13(Long.toString(sum_reg_center_13));
			centerBean.setReg_14(Long.toString(sum_reg_center_14));
			centerBean.setReg_15(Long.toString(sum_reg_center_15));
			centerBean.setReg_16(Long.toString(sum_reg_center_16));
			centerBean.setReg_17(Long.toString(sum_reg_center_17));
			centerBean.setReg_18(Long.toString(sum_reg_center_18));
			centerBean.setReg_19(Long.toString(sum_reg_center_19));
			centerBean.setReg_20(Long.toString(sum_reg_center_20));
			centerBean.setReg_21(Long.toString(sum_reg_center_21));
			centerBean.setReg_22(Long.toString(sum_reg_center_22));
			centerBean.setReg_23(Long.toString(sum_reg_center_23));
			centerBean.setReg_24(Long.toString(sum_reg_center_24));
			centerBean.setReg_25(Long.toString(sum_reg_center_25));
			centerBean.setReg_26(Long.toString(sum_reg_center_26));
			centerBean.setReg_27(Long.toString(sum_reg_center_27));
			centerBean.setReg_28(Long.toString(sum_reg_center_28));
			centerBean.setReg_29(Long.toString(sum_reg_center_29));
			centerBean.setReg_30(Long.toString(sum_reg_center_30));
			
			centerBean.setReg_wc_00(Long.toString(sum_reg_center_wc_00));
			centerBean.setReg_wc_01(Long.toString(sum_reg_center_wc_01));
			centerBean.setReg_wc_02(Long.toString(sum_reg_center_wc_02));
			centerBean.setReg_wc_03(Long.toString(sum_reg_center_wc_03));
			centerBean.setReg_wc_04(Long.toString(sum_reg_center_wc_04));
			centerBean.setReg_wc_05(Long.toString(sum_reg_center_wc_05));
			centerBean.setReg_wc_06(Long.toString(sum_reg_center_wc_06));
			centerBean.setReg_wc_07(Long.toString(sum_reg_center_wc_07));
			centerBean.setReg_wc_08(Long.toString(sum_reg_center_wc_08));
			centerBean.setReg_wc_09(Long.toString(sum_reg_center_wc_09));
			centerBean.setReg_wc_10(Long.toString(sum_reg_center_wc_10));
			centerBean.setReg_wc_11(Long.toString(sum_reg_center_wc_11));
			centerBean.setReg_wc_12(Long.toString(sum_reg_center_wc_12));
			centerBean.setReg_wc_13(Long.toString(sum_reg_center_wc_13));
			centerBean.setReg_wc_14(Long.toString(sum_reg_center_wc_14));
			centerBean.setReg_wc_15(Long.toString(sum_reg_center_wc_15));
			centerBean.setReg_wc_16(Long.toString(sum_reg_center_wc_16));
			centerBean.setReg_wc_17(Long.toString(sum_reg_center_wc_17));
			centerBean.setReg_wc_18(Long.toString(sum_reg_center_wc_18));
			centerBean.setReg_wc_19(Long.toString(sum_reg_center_wc_19));
			centerBean.setReg_wc_20(Long.toString(sum_reg_center_wc_20));
			centerBean.setReg_wc_21(Long.toString(sum_reg_center_wc_21));
			centerBean.setReg_wc_22(Long.toString(sum_reg_center_wc_22));
			centerBean.setReg_wc_23(Long.toString(sum_reg_center_wc_23));
			centerBean.setReg_wc_24(Long.toString(sum_reg_center_wc_24));
			centerBean.setReg_wc_25(Long.toString(sum_reg_center_wc_25));
			centerBean.setReg_wc_26(Long.toString(sum_reg_center_wc_26));
			centerBean.setReg_wc_27(Long.toString(sum_reg_center_wc_27));
			centerBean.setReg_wc_28(Long.toString(sum_reg_center_wc_28));
			centerBean.setReg_wc_29(Long.toString(sum_reg_center_wc_29));
			centerBean.setReg_wc_30(Long.toString(sum_reg_center_wc_30));
			
			centerBean.setDay_00(Long.toString(sum_day_center_00));
			centerBean.setDay_01(Long.toString(sum_day_center_01));
			centerBean.setDay_02(Long.toString(sum_day_center_02));
			centerBean.setDay_03(Long.toString(sum_day_center_03));
			centerBean.setDay_04(Long.toString(sum_day_center_04));
			centerBean.setDay_05(Long.toString(sum_day_center_05));
			centerBean.setDay_06(Long.toString(sum_day_center_06));
			centerBean.setDay_07(Long.toString(sum_day_center_07));
			centerBean.setDay_08(Long.toString(sum_day_center_08));
			centerBean.setDay_09(Long.toString(sum_day_center_09));
			centerBean.setDay_10(Long.toString(sum_day_center_10));
			centerBean.setDay_11(Long.toString(sum_day_center_11));
			centerBean.setDay_12(Long.toString(sum_day_center_12));
			centerBean.setDay_13(Long.toString(sum_day_center_13));
			centerBean.setDay_14(Long.toString(sum_day_center_14));
			centerBean.setDay_15(Long.toString(sum_day_center_15));
			centerBean.setDay_16(Long.toString(sum_day_center_16));
			centerBean.setDay_17(Long.toString(sum_day_center_17));
			centerBean.setDay_18(Long.toString(sum_day_center_18));
			centerBean.setDay_19(Long.toString(sum_day_center_19));
			centerBean.setDay_20(Long.toString(sum_day_center_20));
			centerBean.setDay_21(Long.toString(sum_day_center_21));
			centerBean.setDay_22(Long.toString(sum_day_center_22));
			centerBean.setDay_23(Long.toString(sum_day_center_23));
			centerBean.setDay_24(Long.toString(sum_day_center_24));
			centerBean.setDay_25(Long.toString(sum_day_center_25));
			centerBean.setDay_26(Long.toString(sum_day_center_26));
			centerBean.setDay_27(Long.toString(sum_day_center_27));
			centerBean.setDay_28(Long.toString(sum_day_center_28));
			centerBean.setDay_29(Long.toString(sum_day_center_29));
			centerBean.setDay_30(Long.toString(sum_day_center_30));
			
			centerBean.setDay_wc_00(Long.toString(sum_day_center_wc_00));
			centerBean.setDay_wc_01(Long.toString(sum_day_center_wc_01));
			centerBean.setDay_wc_02(Long.toString(sum_day_center_wc_02));
			centerBean.setDay_wc_03(Long.toString(sum_day_center_wc_03));
			centerBean.setDay_wc_04(Long.toString(sum_day_center_wc_04));
			centerBean.setDay_wc_05(Long.toString(sum_day_center_wc_05));
			centerBean.setDay_wc_06(Long.toString(sum_day_center_wc_06));
			centerBean.setDay_wc_07(Long.toString(sum_day_center_wc_07));
			centerBean.setDay_wc_08(Long.toString(sum_day_center_wc_08));
			centerBean.setDay_wc_09(Long.toString(sum_day_center_wc_09));
			centerBean.setDay_wc_10(Long.toString(sum_day_center_wc_10));
			centerBean.setDay_wc_11(Long.toString(sum_day_center_wc_11));
			centerBean.setDay_wc_12(Long.toString(sum_day_center_wc_12));
			centerBean.setDay_wc_13(Long.toString(sum_day_center_wc_13));
			centerBean.setDay_wc_14(Long.toString(sum_day_center_wc_14));
			centerBean.setDay_wc_15(Long.toString(sum_day_center_wc_15));
			centerBean.setDay_wc_16(Long.toString(sum_day_center_wc_16));
			centerBean.setDay_wc_17(Long.toString(sum_day_center_wc_17));
			centerBean.setDay_wc_18(Long.toString(sum_day_center_wc_18));
			centerBean.setDay_wc_19(Long.toString(sum_day_center_wc_19));
			centerBean.setDay_wc_20(Long.toString(sum_day_center_wc_20));
			centerBean.setDay_wc_21(Long.toString(sum_day_center_wc_21));
			centerBean.setDay_wc_22(Long.toString(sum_day_center_wc_22));
			centerBean.setDay_wc_23(Long.toString(sum_day_center_wc_23));
			centerBean.setDay_wc_24(Long.toString(sum_day_center_wc_24));
			centerBean.setDay_wc_25(Long.toString(sum_day_center_wc_25));
			centerBean.setDay_wc_26(Long.toString(sum_day_center_wc_26));
			centerBean.setDay_wc_27(Long.toString(sum_day_center_wc_27));
			centerBean.setDay_wc_28(Long.toString(sum_day_center_wc_28));
			centerBean.setDay_wc_29(Long.toString(sum_day_center_wc_29));
			centerBean.setDay_wc_30(Long.toString(sum_day_center_wc_30));
			
			centerBean.setReg_y(Long.toString(sum_reg_center_y));
			centerBean.setReg_mi(Long.toString(sum_reg_center_mi));
			centerBean.setCls_y(Long.toString(sum_cls_center_y));
			centerBean.setCls_m(Long.toString(sum_cls_center_m));
			
			centerBean.setReg_wc_y(Long.toString(sum_reg_center_wc_y));
			centerBean.setReg_wc_mi(Long.toString(sum_reg_center_wc_mi));
			centerBean.setCls_wc_y(Long.toString(sum_cls_center_wc_y));
			centerBean.setCls_wc_m(Long.toString(sum_cls_center_wc_m));
			
			//서면심사 부문 표시 여부 확인
			long sum_center_all = sum_reg_center_wc_00 + sum_reg_center_wc_01 + sum_reg_center_wc_02 + sum_reg_center_wc_03 + sum_reg_center_wc_04
					+ sum_reg_center_wc_05 + sum_reg_center_wc_06 + sum_reg_center_wc_07 + sum_reg_center_wc_08 + sum_reg_center_wc_09 + sum_reg_center_wc_10
					+ sum_reg_center_wc_11 + sum_reg_center_wc_12 + sum_reg_center_wc_13 + sum_reg_center_wc_14 + sum_reg_center_wc_15 + sum_reg_center_wc_16
					+ sum_reg_center_wc_17 + sum_reg_center_wc_18 + sum_reg_center_wc_19 + sum_reg_center_wc_20 + sum_reg_center_wc_21 + sum_reg_center_wc_22
					+ sum_reg_center_wc_23 + sum_reg_center_wc_24 + sum_reg_center_wc_25 + sum_reg_center_wc_26 + sum_reg_center_wc_27 + sum_reg_center_wc_28
					+ sum_reg_center_wc_29 + sum_reg_center_wc_30 + sum_day_center_wc_00 + sum_day_center_wc_01 + sum_day_center_wc_02 + sum_day_center_wc_03
					+ sum_day_center_wc_04 + sum_day_center_wc_05 + sum_day_center_wc_06 + sum_day_center_wc_07 + sum_day_center_wc_08 + sum_day_center_wc_09
					+ sum_day_center_wc_10 + sum_day_center_wc_11 + sum_day_center_wc_12 + sum_day_center_wc_13 + sum_day_center_wc_14 + sum_day_center_wc_15
					+ sum_day_center_wc_16 + sum_day_center_wc_17 + sum_day_center_wc_18 + sum_day_center_wc_19 + sum_day_center_wc_20 + sum_day_center_wc_21
					+ sum_day_center_wc_22 + sum_day_center_wc_23 + sum_day_center_wc_24 + sum_day_center_wc_25 + sum_day_center_wc_26 + sum_day_center_wc_27
					+ sum_day_center_wc_28 + sum_day_center_wc_29 + sum_day_center_wc_30;
		
			if( sum_center_all == 0) {
				centerBean.setWc_center_flag("0");
			}else{
				centerBean.setWc_center_flag("1");
			}
			
			TeamCenterListVO.add(i, centerBean);
			
			//변수초기화
			center_member_cnt = 0;
			sum_reg_center_00 = 0;
			sum_reg_center_01 = 0;
			sum_reg_center_02 = 0;
			sum_reg_center_03 = 0;
			sum_reg_center_04 = 0;
			sum_reg_center_05 = 0;
			sum_reg_center_06 = 0;
			sum_reg_center_07 = 0;
			sum_reg_center_08 = 0;
			sum_reg_center_09 = 0;
			sum_reg_center_10 = 0;
			sum_reg_center_11 = 0;
			sum_reg_center_12 = 0;
			sum_reg_center_13 = 0;
			sum_reg_center_14 = 0;
			sum_reg_center_15 = 0;
			sum_reg_center_16 = 0;
			sum_reg_center_17 = 0;
			sum_reg_center_18 = 0;
			sum_reg_center_19 = 0;
			sum_reg_center_20 = 0;
			sum_reg_center_21 = 0;
			sum_reg_center_22 = 0;
			sum_reg_center_23 = 0;
			sum_reg_center_24 = 0;
			sum_reg_center_25 = 0;
			sum_reg_center_26 = 0;
			sum_reg_center_27 = 0;
			sum_reg_center_28 = 0;
			sum_reg_center_29 = 0;
			sum_reg_center_30 = 0;
			
			sum_reg_center_wc_00 = 0;
			sum_reg_center_wc_01 = 0;
			sum_reg_center_wc_02 = 0;
			sum_reg_center_wc_03 = 0;
			sum_reg_center_wc_04 = 0;
			sum_reg_center_wc_05 = 0;
			sum_reg_center_wc_06 = 0;
			sum_reg_center_wc_07 = 0;
			sum_reg_center_wc_08 = 0;
			sum_reg_center_wc_09 = 0;
			sum_reg_center_wc_10 = 0;
			sum_reg_center_wc_11 = 0;
			sum_reg_center_wc_12 = 0;
			sum_reg_center_wc_13 = 0;
			sum_reg_center_wc_14 = 0;
			sum_reg_center_wc_15 = 0;
			sum_reg_center_wc_16 = 0;
			sum_reg_center_wc_17 = 0;
			sum_reg_center_wc_18 = 0;
			sum_reg_center_wc_19 = 0;
			sum_reg_center_wc_20 = 0;
			sum_reg_center_wc_21 = 0;
			sum_reg_center_wc_22 = 0;
			sum_reg_center_wc_23 = 0;
			sum_reg_center_wc_24 = 0;
			sum_reg_center_wc_25 = 0;
			sum_reg_center_wc_26 = 0;
			sum_reg_center_wc_27 = 0;
			sum_reg_center_wc_28 = 0;
			sum_reg_center_wc_29 = 0;
			sum_reg_center_wc_30 = 0;
			
			sum_day_center_00 = 0;
			sum_day_center_01 = 0;
			sum_day_center_02 = 0;
			sum_day_center_03 = 0;
			sum_day_center_04 = 0;
			sum_day_center_05 = 0;
			sum_day_center_06 = 0;
			sum_day_center_07 = 0;
			sum_day_center_08 = 0;
			sum_day_center_09 = 0;
			sum_day_center_10 = 0;
			sum_day_center_11 = 0;
			sum_day_center_12 = 0;
			sum_day_center_13 = 0;
			sum_day_center_14 = 0;
			sum_day_center_15 = 0;
			sum_day_center_16 = 0;
			sum_day_center_17 = 0;
			sum_day_center_18 = 0;
			sum_day_center_19 = 0;
			sum_day_center_20 = 0;
			sum_day_center_21 = 0;
			sum_day_center_22 = 0;
			sum_day_center_23 = 0;
			sum_day_center_24 = 0;
			sum_day_center_25 = 0;
			sum_day_center_26 = 0;
			sum_day_center_27 = 0;
			sum_day_center_28 = 0;
			sum_day_center_29 = 0;
			sum_day_center_30 = 0;
			
			sum_day_center_wc_00 = 0;
			sum_day_center_wc_01 = 0;
			sum_day_center_wc_02 = 0;
			sum_day_center_wc_03 = 0;
			sum_day_center_wc_04 = 0;
			sum_day_center_wc_05 = 0;
			sum_day_center_wc_06 = 0;
			sum_day_center_wc_07 = 0;
			sum_day_center_wc_08 = 0;
			sum_day_center_wc_09 = 0;
			sum_day_center_wc_10 = 0;
			sum_day_center_wc_11 = 0;
			sum_day_center_wc_12 = 0;
			sum_day_center_wc_13 = 0;
			sum_day_center_wc_14 = 0;
			sum_day_center_wc_15 = 0;
			sum_day_center_wc_16 = 0;
			sum_day_center_wc_17 = 0;
			sum_day_center_wc_18 = 0;
			sum_day_center_wc_19 = 0;
			sum_day_center_wc_20 = 0;
			sum_day_center_wc_21 = 0;
			sum_day_center_wc_22 = 0;
			sum_day_center_wc_23 = 0;
			sum_day_center_wc_24 = 0;
			sum_day_center_wc_25 = 0;
			sum_day_center_wc_26 = 0;
			sum_day_center_wc_27 = 0;
			sum_day_center_wc_28 = 0;
			sum_day_center_wc_29 = 0;
			sum_day_center_wc_30 = 0;

			sum_reg_center_y = 0;
			sum_reg_center_mi = 0;		
			sum_cls_center_y = 0;	
			sum_cls_center_m = 0;
			
			sum_reg_center_wc_y = 0;
			sum_reg_center_wc_mi = 0;		
			sum_cls_center_wc_y = 0;	
			sum_cls_center_wc_m = 0;
		}
		
		model.addAttribute("TeamCenterListVO", TeamCenterListVO);
		//센터별 추가 끝 by top3009
		
		//4종 센터별 추가 시작		
		List<MisRegTmVO> TeamCenter4ListVO = new ArrayList<MisRegTmVO>();			//부문별 목록에 뿌려줄 리스트 생성
		
		//부문별 합산계산 시작
		for(int i=0; i < teamCenterList.size(); i++) {
			
			MisRegTmVO center4Bean = new MisRegTmVO();			//리스트에 넣어줄 객체 생성
			
			sCenter = teamCenterList.get(i).getCol_cd();
			sCenter_val = teamCenterList.get(i).getCol_val();			
			center4Bean.setTeam_center(sCenter);
			center4Bean.setTeam_center_val(sCenter_val);
			
			//팀목록에서 가져온 카운트를 체크해서 넣어준다.
			for(int k=0; k < getMisAllotTm4.size(); k++) {				
				sCenter_flag = getMisAllotTm4.get(k).getTeam_center();
				if(sCenter.equals(sCenter_flag)){				//team_center 가 0이아니고, 같은경우만 합산한다.
					
					center_member_cnt += getMisAllotTm4.get(k).getMember_cnt();					
					sum_reg_center_00 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_00());
					sum_reg_center_01 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_01());
					sum_reg_center_02 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_02());
					sum_reg_center_03 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_03());
					sum_reg_center_04 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_04());
					sum_reg_center_05 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_05());
					sum_reg_center_06 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_06());
					sum_reg_center_07 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_07());
					sum_reg_center_08 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_08());
					sum_reg_center_09 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_09());
					sum_reg_center_10 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_10());
					sum_reg_center_11 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_11());
					sum_reg_center_12 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_12());
					sum_reg_center_13 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_13());
					sum_reg_center_14 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_14());
					sum_reg_center_15 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_15());
					sum_reg_center_16 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_16());
					sum_reg_center_17 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_17());
					sum_reg_center_18 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_18());
					sum_reg_center_19 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_19());
					sum_reg_center_20 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_20());
					sum_reg_center_21 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_21());
					sum_reg_center_22 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_22());
					sum_reg_center_23 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_23());
					sum_reg_center_24 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_24());
					sum_reg_center_25 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_25());
					sum_reg_center_26 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_26());
					sum_reg_center_27 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_27());
					sum_reg_center_28 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_28());
					sum_reg_center_29 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_29());
					sum_reg_center_30 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_30());
										
					sum_day_center_00 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_00());
					sum_day_center_01 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_01());
					sum_day_center_02 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_02());
					sum_day_center_03 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_03());
					sum_day_center_04 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_04());
					sum_day_center_05 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_05());
					sum_day_center_06 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_06());
					sum_day_center_07 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_07());
					sum_day_center_08 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_08());
					sum_day_center_09 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_09());
					sum_day_center_10 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_10());
					sum_day_center_11 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_11());
					sum_day_center_12 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_12());
					sum_day_center_13 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_13());
					sum_day_center_14 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_14());
					sum_day_center_15 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_15());
					sum_day_center_16 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_16());
					sum_day_center_17 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_17());
					sum_day_center_18 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_18());
					sum_day_center_19 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_19());
					sum_day_center_20 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_20());
					sum_day_center_21 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_21());
					sum_day_center_22 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_22());
					sum_day_center_23 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_23());
					sum_day_center_24 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_24());
					sum_day_center_25 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_25());
					sum_day_center_26 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_26());
					sum_day_center_27 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_27());
					sum_day_center_28 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_28());
					sum_day_center_29 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_29());
					sum_day_center_30 +=  WebUtil.parseStringToLong(getMisAllotTm4.get(k).getDay_30());
										
					sum_reg_center_y += WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_y());
					sum_reg_center_mi += WebUtil.parseStringToLong(getMisAllotTm4.get(k).getReg_mi());
					
					sum_cls_center_y += WebUtil.parseStringToLong(getMisAllotTm4.get(k).getCls_y());
					sum_cls_center_m += WebUtil.parseStringToLong(getMisAllotTm4.get(k).getCls_m());
										
				}
			}
			
			center4Bean.setMember_cnt(center_member_cnt);
			center4Bean.setReg_00(Long.toString(sum_reg_center_00));
			center4Bean.setReg_01(Long.toString(sum_reg_center_01));
			center4Bean.setReg_02(Long.toString(sum_reg_center_02));
			center4Bean.setReg_03(Long.toString(sum_reg_center_03));
			center4Bean.setReg_04(Long.toString(sum_reg_center_04));
			center4Bean.setReg_05(Long.toString(sum_reg_center_05));
			center4Bean.setReg_06(Long.toString(sum_reg_center_06));
			center4Bean.setReg_07(Long.toString(sum_reg_center_07));
			center4Bean.setReg_08(Long.toString(sum_reg_center_08));
			center4Bean.setReg_09(Long.toString(sum_reg_center_09));
			center4Bean.setReg_10(Long.toString(sum_reg_center_10));
			center4Bean.setReg_11(Long.toString(sum_reg_center_11));
			center4Bean.setReg_12(Long.toString(sum_reg_center_12));
			center4Bean.setReg_13(Long.toString(sum_reg_center_13));
			center4Bean.setReg_14(Long.toString(sum_reg_center_14));
			center4Bean.setReg_15(Long.toString(sum_reg_center_15));
			center4Bean.setReg_16(Long.toString(sum_reg_center_16));
			center4Bean.setReg_17(Long.toString(sum_reg_center_17));
			center4Bean.setReg_18(Long.toString(sum_reg_center_18));
			center4Bean.setReg_19(Long.toString(sum_reg_center_19));
			center4Bean.setReg_20(Long.toString(sum_reg_center_20));
			center4Bean.setReg_21(Long.toString(sum_reg_center_21));
			center4Bean.setReg_22(Long.toString(sum_reg_center_22));
			center4Bean.setReg_23(Long.toString(sum_reg_center_23));
			center4Bean.setReg_24(Long.toString(sum_reg_center_24));
			center4Bean.setReg_25(Long.toString(sum_reg_center_25));
			center4Bean.setReg_26(Long.toString(sum_reg_center_26));
			center4Bean.setReg_27(Long.toString(sum_reg_center_27));
			center4Bean.setReg_28(Long.toString(sum_reg_center_28));
			center4Bean.setReg_29(Long.toString(sum_reg_center_29));
			center4Bean.setReg_30(Long.toString(sum_reg_center_30));
						
			center4Bean.setDay_00(Long.toString(sum_day_center_00));
			center4Bean.setDay_01(Long.toString(sum_day_center_01));
			center4Bean.setDay_02(Long.toString(sum_day_center_02));
			center4Bean.setDay_03(Long.toString(sum_day_center_03));
			center4Bean.setDay_04(Long.toString(sum_day_center_04));
			center4Bean.setDay_05(Long.toString(sum_day_center_05));
			center4Bean.setDay_06(Long.toString(sum_day_center_06));
			center4Bean.setDay_07(Long.toString(sum_day_center_07));
			center4Bean.setDay_08(Long.toString(sum_day_center_08));
			center4Bean.setDay_09(Long.toString(sum_day_center_09));
			center4Bean.setDay_10(Long.toString(sum_day_center_10));
			center4Bean.setDay_11(Long.toString(sum_day_center_11));
			center4Bean.setDay_12(Long.toString(sum_day_center_12));
			center4Bean.setDay_13(Long.toString(sum_day_center_13));
			center4Bean.setDay_14(Long.toString(sum_day_center_14));
			center4Bean.setDay_15(Long.toString(sum_day_center_15));
			center4Bean.setDay_16(Long.toString(sum_day_center_16));
			center4Bean.setDay_17(Long.toString(sum_day_center_17));
			center4Bean.setDay_18(Long.toString(sum_day_center_18));
			center4Bean.setDay_19(Long.toString(sum_day_center_19));
			center4Bean.setDay_20(Long.toString(sum_day_center_20));
			center4Bean.setDay_21(Long.toString(sum_day_center_21));
			center4Bean.setDay_22(Long.toString(sum_day_center_22));
			center4Bean.setDay_23(Long.toString(sum_day_center_23));
			center4Bean.setDay_24(Long.toString(sum_day_center_24));
			center4Bean.setDay_25(Long.toString(sum_day_center_25));
			center4Bean.setDay_26(Long.toString(sum_day_center_26));
			center4Bean.setDay_27(Long.toString(sum_day_center_27));
			center4Bean.setDay_28(Long.toString(sum_day_center_28));
			center4Bean.setDay_29(Long.toString(sum_day_center_29));
			center4Bean.setDay_30(Long.toString(sum_day_center_30));			
			
			center4Bean.setReg_y(Long.toString(sum_reg_center_y));
			center4Bean.setReg_mi(Long.toString(sum_reg_center_mi));
			center4Bean.setCls_y(Long.toString(sum_cls_center_y));
			center4Bean.setCls_m(Long.toString(sum_cls_center_m));
			
			TeamCenter4ListVO.add(i, center4Bean);
			
			//변수초기화
			center_member_cnt = 0;
			sum_reg_center_00 = 0;
			sum_reg_center_01 = 0;
			sum_reg_center_02 = 0;
			sum_reg_center_03 = 0;
			sum_reg_center_04 = 0;
			sum_reg_center_05 = 0;
			sum_reg_center_06 = 0;
			sum_reg_center_07 = 0;
			sum_reg_center_08 = 0;
			sum_reg_center_09 = 0;
			sum_reg_center_10 = 0;
			sum_reg_center_11 = 0;
			sum_reg_center_12 = 0;
			sum_reg_center_13 = 0;
			sum_reg_center_14 = 0;
			sum_reg_center_15 = 0;
			sum_reg_center_16 = 0;
			sum_reg_center_17 = 0;
			sum_reg_center_18 = 0;
			sum_reg_center_19 = 0;
			sum_reg_center_20 = 0;
			sum_reg_center_21 = 0;
			sum_reg_center_22 = 0;
			sum_reg_center_23 = 0;
			sum_reg_center_24 = 0;
			sum_reg_center_25 = 0;
			sum_reg_center_26 = 0;
			sum_reg_center_27 = 0;
			sum_reg_center_28 = 0;
			sum_reg_center_29 = 0;
			sum_reg_center_30 = 0;
						
			sum_day_center_00 = 0;
			sum_day_center_01 = 0;
			sum_day_center_02 = 0;
			sum_day_center_03 = 0;
			sum_day_center_04 = 0;
			sum_day_center_05 = 0;
			sum_day_center_06 = 0;
			sum_day_center_07 = 0;
			sum_day_center_08 = 0;
			sum_day_center_09 = 0;
			sum_day_center_10 = 0;
			sum_day_center_11 = 0;
			sum_day_center_12 = 0;
			sum_day_center_13 = 0;
			sum_day_center_14 = 0;
			sum_day_center_15 = 0;
			sum_day_center_16 = 0;
			sum_day_center_17 = 0;
			sum_day_center_18 = 0;
			sum_day_center_19 = 0;
			sum_day_center_20 = 0;
			sum_day_center_21 = 0;
			sum_day_center_22 = 0;
			sum_day_center_23 = 0;
			sum_day_center_24 = 0;
			sum_day_center_25 = 0;
			sum_day_center_26 = 0;
			sum_day_center_27 = 0;
			sum_day_center_28 = 0;
			sum_day_center_29 = 0;
			sum_day_center_30 = 0;
			
			sum_reg_center_y = 0;
			sum_reg_center_mi = 0;		
			sum_cls_center_y = 0;	
			sum_cls_center_m = 0;			
		}
		
		model.addAttribute("TeamCenter4ListVO", TeamCenter4ListVO);		
		//4종 센터별 추가 끝
			

		List<Map<String, Object>> memList = sqlSession.selectList("MisAllotTmMbrMapper.selectMisAllotTmMbr1List", paramMap);
		
		String nTemp_UserNo = "";
		String nTemp_UserName = "";
		
		String sChk_written = "0";
		
		Map<String, Object> written_member;
		
		//농작물 팀 계산값 저장용 임시 Map
		Map<String, Object> prim_user;
		
		for( int i=0; i < memList.size(); i++){
			sChk_written = memList.get(i).get("teamWritten").toString();
			//서면심사팀에 속해있는경우만 별도로 계산해서 넣어준다.
			if("1".equals(sChk_written)) {
				//System.out.println(memList.get(i).get("userName").toString()+" : "+memList.get(i).get("userNo").toString());
				paramMap.put("user_no", memList.get(i).get("userNo"));
				written_member = sqlSession.selectOne("MisAllotTmMbrMapper.selectMisAllotTmMbr1WrittenList", paramMap);
				//서면심사 미결
				memList.get(i).put("pendingCnt", written_member.get("pendingCnt").toString());
				
				//서면심사 년간 수임, 종결
				memList.get(i).put("regYearCnt", written_member.get("regYearCnt").toString());
				memList.get(i).put("clsYearCnt", written_member.get("clsYearCnt").toString());
				
				//서면심사 당월 종결
				memList.get(i).put("clsMonthCnt", written_member.get("clsMonthCnt").toString());				
				
				//서면심사 수임
				memList.get(i).put("reg02", written_member.get("reg02").toString());
				memList.get(i).put("reg03", written_member.get("reg03").toString());
				memList.get(i).put("reg04", written_member.get("reg04").toString());
				memList.get(i).put("reg05", written_member.get("reg05").toString());
				memList.get(i).put("reg06", written_member.get("reg06").toString());
				memList.get(i).put("reg07", written_member.get("reg07").toString());
				memList.get(i).put("reg08", written_member.get("reg08").toString());				
				memList.get(i).put("reg09", written_member.get("reg09").toString());
				memList.get(i).put("reg10", written_member.get("reg10").toString());
				memList.get(i).put("reg11", written_member.get("reg11").toString());
				memList.get(i).put("reg12", written_member.get("reg12").toString());
				memList.get(i).put("reg13", written_member.get("reg13").toString());
				memList.get(i).put("reg14", written_member.get("reg14").toString());
				memList.get(i).put("reg15", written_member.get("reg15").toString());
				memList.get(i).put("reg16", written_member.get("reg16").toString());
				memList.get(i).put("reg17", written_member.get("reg17").toString());
				memList.get(i).put("reg18", written_member.get("reg18").toString());
				memList.get(i).put("reg19", written_member.get("reg19").toString());
				memList.get(i).put("reg20", written_member.get("reg20").toString());
				memList.get(i).put("reg21", written_member.get("reg21").toString());
				memList.get(i).put("reg22", written_member.get("reg22").toString());
				memList.get(i).put("reg23", written_member.get("reg23").toString());
				memList.get(i).put("reg24", written_member.get("reg24").toString());
				memList.get(i).put("reg25", written_member.get("reg25").toString());
				memList.get(i).put("reg26", written_member.get("reg26").toString());
				memList.get(i).put("reg27", written_member.get("reg27").toString());
				memList.get(i).put("reg28", written_member.get("reg28").toString());
				memList.get(i).put("reg29", written_member.get("reg29").toString());
				memList.get(i).put("reg30", written_member.get("reg30").toString());
				memList.get(i).put("reg31", written_member.get("reg31").toString());
				
				//서면심사 종결
				memList.get(i).put("day02", written_member.get("day02").toString());
				memList.get(i).put("day03", written_member.get("day03").toString());
				memList.get(i).put("day04", written_member.get("day04").toString());
				memList.get(i).put("day05", written_member.get("day05").toString());
				memList.get(i).put("day06", written_member.get("day06").toString());
				memList.get(i).put("day07", written_member.get("day07").toString());
				memList.get(i).put("day08", written_member.get("day08").toString());				
				memList.get(i).put("day09", written_member.get("day09").toString());
				memList.get(i).put("day10", written_member.get("day10").toString());
				memList.get(i).put("day11", written_member.get("day11").toString());
				memList.get(i).put("day12", written_member.get("day12").toString());
				memList.get(i).put("day13", written_member.get("day13").toString());
				memList.get(i).put("day14", written_member.get("day14").toString());
				memList.get(i).put("day15", written_member.get("day15").toString());
				memList.get(i).put("day16", written_member.get("day16").toString());
				memList.get(i).put("day17", written_member.get("day17").toString());
				memList.get(i).put("day18", written_member.get("day18").toString());
				memList.get(i).put("day19", written_member.get("day19").toString());
				memList.get(i).put("day20", written_member.get("day20").toString());
				memList.get(i).put("day21", written_member.get("day21").toString());
				memList.get(i).put("day22", written_member.get("day22").toString());
				memList.get(i).put("day23", written_member.get("day23").toString());
				memList.get(i).put("day24", written_member.get("day24").toString());
				memList.get(i).put("day25", written_member.get("day25").toString());
				memList.get(i).put("day26", written_member.get("day26").toString());
				memList.get(i).put("day27", written_member.get("day27").toString());
				memList.get(i).put("day28", written_member.get("day28").toString());
				memList.get(i).put("day29", written_member.get("day29").toString());
				memList.get(i).put("day30", written_member.get("day30").toString());
				memList.get(i).put("day31", written_member.get("day31").toString());				
			}else{
				nTemp_UserNo = memList.get(i).get("userNo").toString();
				
				nowVO.setUser_no(nTemp_UserNo);
				
				//농작물의 일일배당 현황 데이터를 가져온다.				
				prim_user = sqlSession.selectOne("MisAllotTmMbrMapper.selectMisAllotTmTeam1PrimUserList", nowVO);
				
				//농작물 팀별 일일 수임				
				nReg30 = Integer.parseInt( memList.get(i).get("reg01").toString() ) + Integer.parseInt( prim_user.get("reg30").toString() );
				nReg29 = Integer.parseInt( memList.get(i).get("reg02").toString() ) + Integer.parseInt( prim_user.get("reg29").toString() );
				nReg28 = Integer.parseInt( memList.get(i).get("reg03").toString() ) + Integer.parseInt( prim_user.get("reg28").toString() );
				nReg27 = Integer.parseInt( memList.get(i).get("reg04").toString() ) + Integer.parseInt( prim_user.get("reg27").toString() );
				nReg26 = Integer.parseInt( memList.get(i).get("reg05").toString() ) + Integer.parseInt( prim_user.get("reg26").toString() );
				nReg25 = Integer.parseInt( memList.get(i).get("reg06").toString() ) + Integer.parseInt( prim_user.get("reg25").toString() );
				nReg24 = Integer.parseInt( memList.get(i).get("reg07").toString() ) + Integer.parseInt( prim_user.get("reg24").toString() );
				nReg23 = Integer.parseInt( memList.get(i).get("reg08").toString() ) + Integer.parseInt( prim_user.get("reg23").toString() );
				nReg22 = Integer.parseInt( memList.get(i).get("reg09").toString() ) + Integer.parseInt( prim_user.get("reg22").toString() );
				nReg21 = Integer.parseInt( memList.get(i).get("reg10").toString() ) + Integer.parseInt( prim_user.get("reg21").toString() );
				nReg20 = Integer.parseInt( memList.get(i).get("reg11").toString() ) + Integer.parseInt( prim_user.get("reg20").toString() );
				nReg19 = Integer.parseInt( memList.get(i).get("reg12").toString() ) + Integer.parseInt( prim_user.get("reg19").toString() );
				nReg18 = Integer.parseInt( memList.get(i).get("reg13").toString() ) + Integer.parseInt( prim_user.get("reg18").toString() );
				nReg17 = Integer.parseInt( memList.get(i).get("reg14").toString() ) + Integer.parseInt( prim_user.get("reg17").toString() );
				nReg16 = Integer.parseInt( memList.get(i).get("reg15").toString() ) + Integer.parseInt( prim_user.get("reg16").toString() );
				nReg15 = Integer.parseInt( memList.get(i).get("reg16").toString() ) + Integer.parseInt( prim_user.get("reg15").toString() );
				nReg14 = Integer.parseInt( memList.get(i).get("reg17").toString() ) + Integer.parseInt( prim_user.get("reg14").toString() );
				nReg13 = Integer.parseInt( memList.get(i).get("reg18").toString() ) + Integer.parseInt( prim_user.get("reg13").toString() );
				nReg12 = Integer.parseInt( memList.get(i).get("reg19").toString() ) + Integer.parseInt( prim_user.get("reg12").toString() );
				nReg11 = Integer.parseInt( memList.get(i).get("reg20").toString() ) + Integer.parseInt( prim_user.get("reg11").toString() );
				nReg10 = Integer.parseInt( memList.get(i).get("reg21").toString() ) + Integer.parseInt( prim_user.get("reg10").toString() );
				nReg09 = Integer.parseInt( memList.get(i).get("reg22").toString() ) + Integer.parseInt( prim_user.get("reg09").toString() );
				nReg08 = Integer.parseInt( memList.get(i).get("reg23").toString() ) + Integer.parseInt( prim_user.get("reg08").toString() );
				nReg07 = Integer.parseInt( memList.get(i).get("reg24").toString() ) + Integer.parseInt( prim_user.get("reg07").toString() );
				nReg06 = Integer.parseInt( memList.get(i).get("reg25").toString() ) + Integer.parseInt( prim_user.get("reg06").toString() );
				nReg05 = Integer.parseInt( memList.get(i).get("reg26").toString() ) + Integer.parseInt( prim_user.get("reg05").toString() );
				nReg04 = Integer.parseInt( memList.get(i).get("reg27").toString() ) + Integer.parseInt( prim_user.get("reg04").toString() );
				nReg03 = Integer.parseInt( memList.get(i).get("reg28").toString() ) + Integer.parseInt( prim_user.get("reg03").toString() );
				nReg02 = Integer.parseInt( memList.get(i).get("reg29").toString() ) + Integer.parseInt( prim_user.get("reg02").toString() );
				nReg01 = Integer.parseInt( memList.get(i).get("reg30").toString() ) + Integer.parseInt( prim_user.get("reg01").toString() );
				nReg00 = Integer.parseInt( memList.get(i).get("reg31").toString() ) + Integer.parseInt( prim_user.get("reg00").toString() );

				nDay30 = Integer.parseInt( memList.get(i).get("day01").toString() ) + Integer.parseInt( prim_user.get("day30").toString() );
				nDay29 = Integer.parseInt( memList.get(i).get("day02").toString() ) + Integer.parseInt( prim_user.get("day29").toString() );
				nDay28 = Integer.parseInt( memList.get(i).get("day03").toString() ) + Integer.parseInt( prim_user.get("day28").toString() );
				nDay27 = Integer.parseInt( memList.get(i).get("day04").toString() ) + Integer.parseInt( prim_user.get("day27").toString() );
				nDay26 = Integer.parseInt( memList.get(i).get("day05").toString() ) + Integer.parseInt( prim_user.get("day26").toString() );
				nDay25 = Integer.parseInt( memList.get(i).get("day06").toString() ) + Integer.parseInt( prim_user.get("day25").toString() );
				nDay24 = Integer.parseInt( memList.get(i).get("day07").toString() ) + Integer.parseInt( prim_user.get("day24").toString() );
				nDay23 = Integer.parseInt( memList.get(i).get("day08").toString() ) + Integer.parseInt( prim_user.get("day23").toString() );
				nDay22 = Integer.parseInt( memList.get(i).get("day09").toString() ) + Integer.parseInt( prim_user.get("day22").toString() );
				nDay21 = Integer.parseInt( memList.get(i).get("day10").toString() ) + Integer.parseInt( prim_user.get("day21").toString() );
				nDay20 = Integer.parseInt( memList.get(i).get("day11").toString() ) + Integer.parseInt( prim_user.get("day20").toString() );
				nDay19 = Integer.parseInt( memList.get(i).get("day12").toString() ) + Integer.parseInt( prim_user.get("day19").toString() );
				nDay18 = Integer.parseInt( memList.get(i).get("day13").toString() ) + Integer.parseInt( prim_user.get("day18").toString() );
				nDay17 = Integer.parseInt( memList.get(i).get("day14").toString() ) + Integer.parseInt( prim_user.get("day17").toString() );
				nDay16 = Integer.parseInt( memList.get(i).get("day15").toString() ) + Integer.parseInt( prim_user.get("day16").toString() );
				nDay15 = Integer.parseInt( memList.get(i).get("day16").toString() ) + Integer.parseInt( prim_user.get("day15").toString() );
				nDay14 = Integer.parseInt( memList.get(i).get("day17").toString() ) + Integer.parseInt( prim_user.get("day14").toString() );
				nDay13 = Integer.parseInt( memList.get(i).get("day18").toString() ) + Integer.parseInt( prim_user.get("day13").toString() );
				nDay12 = Integer.parseInt( memList.get(i).get("day19").toString() ) + Integer.parseInt( prim_user.get("day12").toString() );
				nDay11 = Integer.parseInt( memList.get(i).get("day20").toString() ) + Integer.parseInt( prim_user.get("day11").toString() );
				nDay10 = Integer.parseInt( memList.get(i).get("day21").toString() ) + Integer.parseInt( prim_user.get("day10").toString() );
				nDay09 = Integer.parseInt( memList.get(i).get("day22").toString() ) + Integer.parseInt( prim_user.get("day09").toString() );
				nDay08 = Integer.parseInt( memList.get(i).get("day23").toString() ) + Integer.parseInt( prim_user.get("day08").toString() );
				nDay07 = Integer.parseInt( memList.get(i).get("day24").toString() ) + Integer.parseInt( prim_user.get("day07").toString() );
				nDay06 = Integer.parseInt( memList.get(i).get("day25").toString() ) + Integer.parseInt( prim_user.get("day06").toString() );
				nDay05 = Integer.parseInt( memList.get(i).get("day26").toString() ) + Integer.parseInt( prim_user.get("day05").toString() );
				nDay04 = Integer.parseInt( memList.get(i).get("day27").toString() ) + Integer.parseInt( prim_user.get("day04").toString() );
				nDay03 = Integer.parseInt( memList.get(i).get("day28").toString() ) + Integer.parseInt( prim_user.get("day03").toString() );
				nDay02 = Integer.parseInt( memList.get(i).get("day29").toString() ) + Integer.parseInt( prim_user.get("day02").toString() );
				nDay01 = Integer.parseInt( memList.get(i).get("day30").toString() ) + Integer.parseInt( prim_user.get("day01").toString() );
				nDay00 = Integer.parseInt( memList.get(i).get("day31").toString() ) + Integer.parseInt( prim_user.get("day00").toString() );
				
				memList.get(i).put("reg01", nReg30);				
				memList.get(i).put("reg02", nReg29);
				memList.get(i).put("reg03", nReg28);
				memList.get(i).put("reg04", nReg27);
				memList.get(i).put("reg05", nReg26);
				memList.get(i).put("reg06", nReg25);
				memList.get(i).put("reg07", nReg24);
				memList.get(i).put("reg08", nReg23);
				memList.get(i).put("reg09", nReg22);
				memList.get(i).put("reg10", nReg21);
				memList.get(i).put("reg11", nReg20);
				memList.get(i).put("reg12", nReg19);
				memList.get(i).put("reg13", nReg18);
				memList.get(i).put("reg14", nReg17);
				memList.get(i).put("reg15", nReg16);
				memList.get(i).put("reg16", nReg15);
				memList.get(i).put("reg17", nReg14);
				memList.get(i).put("reg18", nReg13);
				memList.get(i).put("reg19", nReg12);
				memList.get(i).put("reg20", nReg11);
				memList.get(i).put("reg21", nReg10);
				memList.get(i).put("reg22", nReg09);
				memList.get(i).put("reg23", nReg08);
				memList.get(i).put("reg24", nReg07);
				memList.get(i).put("reg25", nReg06);
				memList.get(i).put("reg26", nReg05);
				memList.get(i).put("reg27", nReg04);
				memList.get(i).put("reg28", nReg03);
				memList.get(i).put("reg29", nReg02);
				memList.get(i).put("reg30", nReg01);
				memList.get(i).put("reg31", nReg00);				
				
				memList.get(i).put("day01", nDay30);				
				memList.get(i).put("day02", nDay29);
				memList.get(i).put("day03", nDay28);
				memList.get(i).put("day04", nDay27);
				memList.get(i).put("day05", nDay26);
				memList.get(i).put("day06", nDay25);
				memList.get(i).put("day07", nDay24);
				memList.get(i).put("day08", nDay23);
				memList.get(i).put("day09", nDay22);
				memList.get(i).put("day10", nDay21);
				memList.get(i).put("day11", nDay20);
				memList.get(i).put("day12", nDay19);
				memList.get(i).put("day13", nDay18);
				memList.get(i).put("day14", nDay17);
				memList.get(i).put("day15", nDay16);
				memList.get(i).put("day16", nDay15);
				memList.get(i).put("day17", nDay14);
				memList.get(i).put("day18", nDay13);
				memList.get(i).put("day19", nDay12);
				memList.get(i).put("day20", nDay11);
				memList.get(i).put("day21", nDay10);
				memList.get(i).put("day22", nDay09);
				memList.get(i).put("day23", nDay08);
				memList.get(i).put("day24", nDay07);
				memList.get(i).put("day25", nDay06);
				memList.get(i).put("day26", nDay05);
				memList.get(i).put("day27", nDay04);
				memList.get(i).put("day28", nDay03);
				memList.get(i).put("day29", nDay02);
				memList.get(i).put("day30", nDay01);
				memList.get(i).put("day31", nDay00);				
				
				//농작물 미결
				nRegMi = Integer.parseInt( memList.get(i).get("pendingCnt").toString() ) + Integer.parseInt( prim_user.get("regMi").toString() );				
				
				//농작물 팀별 년간 수임, 종결				
				nRegY = Integer.parseInt( memList.get(i).get("regYearCnt").toString() ) + Integer.parseInt( prim_user.get("regY").toString() );				
				nClsY = Integer.parseInt( memList.get(i).get("clsYearCnt").toString() ) + Integer.parseInt( prim_user.get("clsY").toString() );
				
				//농작물 당월종결
				nClsM = Integer.parseInt( memList.get(i).get("clsMonthCnt").toString() ) + Integer.parseInt( prim_user.get("clsM").toString() );
				
				memList.get(i).put("pendingCnt", nRegMi);
				memList.get(i).put("regYearCnt", nRegY);
				memList.get(i).put("clsYearCnt", nClsY);
				memList.get(i).put("clsMonthCnt", nClsM);
				
			}
		}
		
		//년도의 시작과 종료
		//System.out.println("년도 : "+nowVO.getBgnYearDe()+" : "+nowVO.getEndYearDe());
		
		//월의 시작과 종료 (오늘날짜기준으로 실적월 시작, 종료일을 설정한다.)
		String sMonthSdate = DateUtil.getStartMonthDate(today);
		String sMonthEdate = DateUtil.getEndMonthDate(today);
		
		//System.out.println("당월종결날짜 : "+sMonthSdate+" : "+sMonthEdate);
		
		nowVO.setBgnDe(sMonthSdate);
		nowVO.setEndDe(sMonthEdate);
		
		//보험사 상세구분 수임통계 시작
		List<Map<String, Object>> ptnrIdSubList = sqlSession.selectList("MisAllotTmMbrMapper.selectMisAllotPtnrList", nowVO);
		model.addAttribute("ptnrIdSubList", ptnrIdSubList);		
		//보험사 상세구분 수임통계 끝
		
		model.addAttribute("memList",memList);
		model.addAttribute("nowVO", nowVO);
		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_allot_tm";
	}//getMisAllotTm

	@RequestMapping(value = "/getMisAllotTmMbr", method = RequestMethod.GET)
	public String getMisAllotTmMbr(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= getMisAllotTmMbr =======");
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		if(mbrAuthVo == null || (mbrAuthVo.getMbr_pms_21().equals("0"))){
			logger.info("getMisAllotTmMbr - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		List<TopTmBscVO> teamList = sqlSession.selectList("MbrStatListMapper.teamListForSearch");
		model.addAttribute("teamList", teamList);

		DateFormat tmpFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date tmpToday = new Date();
		String tmpNow_to = tmpFormat.format(tmpToday);

		inVO.setViewToDate(tmpNow_to);
		StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statistics30DaysDate", tmpNow_to);
		StatisticsNowVO nowVO2 = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate");
		nowVO.setNow_from(nowVO2.getNow_from());
		nowVO.setNow_to(nowVO2.getNow_to());
		nowVO.setYear_from(nowVO2.getYear_from());
		nowVO.setYear_to(nowVO2.getYear_to());
		nowVO.setTeam_id(inVO.getTeam_id());

        //================================================
        // 필요 날짜 세팅
        //================================================
        String today = DateUtil.getTodayString();
        String bgnDe = DateUtil.addDate(today,-30);
        String endDe = DateUtil.addDate(today,1);
        String bgnYearDe = (Integer.parseInt(endDe.substring(0,4)) - 1)  + "1216";
        String endYearDe = endDe.substring(0,4) + "1216";
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("bgnDe", bgnDe);
        paramMap.put("endDe", endDe);
        paramMap.put("bgnYearDe", bgnYearDe);
        paramMap.put("endYearDe", endYearDe);
		paramMap.put("now_from", nowVO2.getNow_from());
		paramMap.put("now_to", nowVO2.getNow_to());
        
        //기존 주석처리
		
		//팀의 개인별 일일배당현황
		String sTeam_id = request.getParameter("team_id") != null ? request.getParameter("team_id") : "0";		
		
		String sChk_written = "0";
		
		sChk_written = sqlSession.selectOne("MisEndTmMapper.chkWrittenTeam", sTeam_id);
		
		List<MisRegTmVO> getMisAllotTmMbr1 = null;
		
		if( "0".equals(sChk_written) ) {
			getMisAllotTmMbr1 = sqlSession.selectList("MisAllotTmMbrMapper.newGetMisAllotTmMbr1", nowVO);
		}else{		//서면심사인경우 직원목록을 따로 가져온다.
			getMisAllotTmMbr1 = sqlSession.selectList("MisAllotTmMbrMapper.newGetMisAllotTmMbr1Written", nowVO);
			
			Map<String, Object> written_member;
			
			for( int i=0; i < getMisAllotTmMbr1.size(); i++){
				//sChk_written = memList.get(i).get("teamWritten").toString();
				//서면심사팀에 속해있는경우만 별도로 계산해서 넣어준다.
				if("1".equals(sChk_written)) {
					//System.out.println(getMisAllotTmMbr1.get(i).getUser_name()+" : "+getMisAllotTmMbr1.get(i).getUser_no());
					paramMap.put("user_no", getMisAllotTmMbr1.get(i).getUser_no());
					written_member = sqlSession.selectOne("MisAllotTmMbrMapper.selectMisAllotTmMbr1WrittenList", paramMap);
					//서면심사 미결
					getMisAllotTmMbr1.get(i).setReg_mi(written_member.get("pendingCnt").toString());				
					
					//서면심사 년간 수임, 종결
					getMisAllotTmMbr1.get(i).setReg_y(written_member.get("regYearCnt").toString());
					getMisAllotTmMbr1.get(i).setCls_y(written_member.get("clsYearCnt").toString());
					
					//서면심사 당월 종결
					getMisAllotTmMbr1.get(i).setCls_m(written_member.get("clsMonthCnt").toString());
					
					//서면심사 수임
					//오늘날짜부터 과거로 시작
					getMisAllotTmMbr1.get(i).setReg_00(written_member.get("reg31").toString());
					getMisAllotTmMbr1.get(i).setReg_01(written_member.get("reg30").toString());
					getMisAllotTmMbr1.get(i).setReg_02(written_member.get("reg29").toString());
					getMisAllotTmMbr1.get(i).setReg_03(written_member.get("reg28").toString());
					getMisAllotTmMbr1.get(i).setReg_04(written_member.get("reg27").toString());
					getMisAllotTmMbr1.get(i).setReg_05(written_member.get("reg26").toString());
					getMisAllotTmMbr1.get(i).setReg_06(written_member.get("reg25").toString());
					getMisAllotTmMbr1.get(i).setReg_07(written_member.get("reg24").toString());
					getMisAllotTmMbr1.get(i).setReg_08(written_member.get("reg23").toString());
					getMisAllotTmMbr1.get(i).setReg_09(written_member.get("reg22").toString());
					getMisAllotTmMbr1.get(i).setReg_10(written_member.get("reg21").toString());
					getMisAllotTmMbr1.get(i).setReg_11(written_member.get("reg20").toString());
					getMisAllotTmMbr1.get(i).setReg_12(written_member.get("reg19").toString());
					getMisAllotTmMbr1.get(i).setReg_13(written_member.get("reg18").toString());
					getMisAllotTmMbr1.get(i).setReg_14(written_member.get("reg17").toString());
					getMisAllotTmMbr1.get(i).setReg_15(written_member.get("reg16").toString());
					getMisAllotTmMbr1.get(i).setReg_16(written_member.get("reg15").toString());
					getMisAllotTmMbr1.get(i).setReg_17(written_member.get("reg14").toString());
					getMisAllotTmMbr1.get(i).setReg_18(written_member.get("reg13").toString());
					getMisAllotTmMbr1.get(i).setReg_19(written_member.get("reg12").toString());
					getMisAllotTmMbr1.get(i).setReg_20(written_member.get("reg11").toString());
					getMisAllotTmMbr1.get(i).setReg_21(written_member.get("reg10").toString());
					getMisAllotTmMbr1.get(i).setReg_22(written_member.get("reg09").toString());
					getMisAllotTmMbr1.get(i).setReg_23(written_member.get("reg08").toString());
					getMisAllotTmMbr1.get(i).setReg_24(written_member.get("reg07").toString());
					getMisAllotTmMbr1.get(i).setReg_25(written_member.get("reg06").toString());
					getMisAllotTmMbr1.get(i).setReg_26(written_member.get("reg05").toString());
					getMisAllotTmMbr1.get(i).setReg_27(written_member.get("reg04").toString());
					getMisAllotTmMbr1.get(i).setReg_28(written_member.get("reg03").toString());
					getMisAllotTmMbr1.get(i).setReg_29(written_member.get("reg02").toString());				
					
					//서면심사 종결
					getMisAllotTmMbr1.get(i).setDay_00(written_member.get("day31").toString());
					getMisAllotTmMbr1.get(i).setDay_01(written_member.get("day30").toString());
					getMisAllotTmMbr1.get(i).setDay_02(written_member.get("day29").toString());
					getMisAllotTmMbr1.get(i).setDay_03(written_member.get("day28").toString());
					getMisAllotTmMbr1.get(i).setDay_04(written_member.get("day27").toString());
					getMisAllotTmMbr1.get(i).setDay_05(written_member.get("day26").toString());
					getMisAllotTmMbr1.get(i).setDay_06(written_member.get("day25").toString());
					getMisAllotTmMbr1.get(i).setDay_07(written_member.get("day24").toString());
					getMisAllotTmMbr1.get(i).setDay_08(written_member.get("day23").toString());
					getMisAllotTmMbr1.get(i).setDay_09(written_member.get("day22").toString());
					getMisAllotTmMbr1.get(i).setDay_10(written_member.get("day21").toString());
					getMisAllotTmMbr1.get(i).setDay_11(written_member.get("day20").toString());
					getMisAllotTmMbr1.get(i).setDay_12(written_member.get("day19").toString());
					getMisAllotTmMbr1.get(i).setDay_13(written_member.get("day18").toString());
					getMisAllotTmMbr1.get(i).setDay_14(written_member.get("day17").toString());
					getMisAllotTmMbr1.get(i).setDay_15(written_member.get("day16").toString());
					getMisAllotTmMbr1.get(i).setDay_16(written_member.get("day15").toString());
					getMisAllotTmMbr1.get(i).setDay_17(written_member.get("day14").toString());
					getMisAllotTmMbr1.get(i).setDay_18(written_member.get("day13").toString());
					getMisAllotTmMbr1.get(i).setDay_19(written_member.get("day12").toString());
					getMisAllotTmMbr1.get(i).setDay_20(written_member.get("day11").toString());
					getMisAllotTmMbr1.get(i).setDay_21(written_member.get("day10").toString());
					getMisAllotTmMbr1.get(i).setDay_22(written_member.get("day09").toString());
					getMisAllotTmMbr1.get(i).setDay_23(written_member.get("day08").toString());
					getMisAllotTmMbr1.get(i).setDay_24(written_member.get("day07").toString());
					getMisAllotTmMbr1.get(i).setDay_25(written_member.get("day06").toString());
					getMisAllotTmMbr1.get(i).setDay_26(written_member.get("day05").toString());
					getMisAllotTmMbr1.get(i).setDay_27(written_member.get("day04").toString());
					getMisAllotTmMbr1.get(i).setDay_28(written_member.get("day03").toString());
					getMisAllotTmMbr1.get(i).setDay_29(written_member.get("day02").toString());			
				}
			}
		}
        
		model.addAttribute("getMisAllotTmMbr1",getMisAllotTmMbr1);

		model.addAttribute("nowVO", nowVO);

		model.addAttribute("inVO", inVO);

		return "top_statistics/mis_allot_tm_mbr";
	}//getMisAllotTmMbr

}//class