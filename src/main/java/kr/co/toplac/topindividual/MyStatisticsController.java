package kr.co.toplac.topindividual;

import java.util.ArrayList;
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

import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.lslog.LogMember2VO;
import kr.co.toplac.topstatistics.MisTmBscViewVO;
import kr.co.toplac.topstatistics.StatisticsNowVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;

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
public class MyStatisticsController {

	private static final Logger logger = LoggerFactory.getLogger(MyStatisticsController.class);

	@Autowired
	private SqlSession sqlSession;

	   /**
     * 나의 통계..
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/myStatistics")
    public String myStatistics(HttpServletRequest request, Model model) throws Exception {
        //===============================================
        //	권한체크
        //===============================================
    	TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
//        TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
//        if (!"1".equals(mbrAuthVo.getMbr_pms_21())){
//            return "redirect:/";
//        }

        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 현재 일자 세팅
        //===============================================
        String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));  //기준일자 시작일
        String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));  //기준일자 종료일
        String teamId = mbrVo.getTeam_id_main();
        String userNo = mbrVo.getUser_no();
        String excelYN = StringUtil.null2blank(request.getParameter("excelYN"));  //엑셀다운 여부

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
            paramMap.put("basicYN","Y");
            paramMap.put("primYN","N");
            paramMap.put("contractYN","N");

        }
        
        paramMap.put("user_no", userNo);
        paramMap.put("team_id", teamId);

//        if ("".equals(teamId) || "".equals(userNo)){
//            return "redirect:/";
//        }

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

        //===============================================
        // 비즈니스 로직 호출
        //===============================================
        TopTmBscVO teamVo = sqlSession.selectOne("TmMngDtlMapper.selectOneTeam", teamId);
        Map<String, Object> memberVo = sqlSession.selectOne("StatisticBasic.selectStatisticMember", paramMap);
        List<Map<String, Object>> memberList = sqlSession.selectList("StatisticBasic.selectStatisticMemberList", paramMap);
        
        //사용자별 년 목표량        
        int year = Integer.parseInt(bgnDe.substring(0, 4));
        int month = Integer.parseInt(bgnDe.substring(4, 6));
        int day = Integer.parseInt(bgnDe.substring(6,8));
        
        if (month == 12 && day > 15){
    		++year;
    	}        
        
    	paramMap.put("year", year);
        
        String yearEa = sqlSession.selectOne("StatisticBasic.selectPersonYearEa",paramMap);        
                
        if( yearEa == null || yearEa.equals("") ) {		//값이 null 인경우 최종 발령팀 기준으로 가져온다.
        	yearEa = sqlSession.selectOne("StatisticBasic.selectPersonYearEaNull",paramMap);
        }
        
		/*
		 * System.out.println("bgnDe="+bgnDe+" : endDe="+endDe);
		 * System.out.println("bgnYearDe="+bgnYearDe+" : endYearDe="+endYearDe);
		 * System.out.println("yearEa="+yearEa);
		 */
        //년간 업무목표량
        paramMap.put("yearEa", yearEa);

        //상세리스트 및 미수금 리스트
        List<Map<String, Object>> detailList = sqlSession.selectList("StatisticBasic.selectDetailList", paramMap);
        List<Map<String, Object>> detailPersonStandardList = sqlSession.selectList("StatisticBasic.selectDetailPersonStandardList", paramMap);
        List<Map<String, Object>> detailOutAmtList = sqlSession.selectList("StatisticBasic.selectDetailOutAmtList", paramMap);

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("teamVo", teamVo);
        model.addAttribute("memberVo", memberVo);
        model.addAttribute("memberList",memberList);

        model.addAttribute("detailList",detailList);
        model.addAttribute("detailPersonStandardList",detailPersonStandardList);
        model.addAttribute("detailOutAmtList",detailOutAmtList);

        model.addAttribute("srchArg",paramMap);

        String retURL = "top_individual/my_statistics";

        if ("Y".equals(excelYN)){
            retURL = "top_individual/my_statistics_excel";
        }

        return retURL;
    }

	
	/*
	 * 180608 공동수행 변경에 따라 미사용 처리.
	 * NEW 기본통계의 화면 가져옴
	 * 
	@RequestMapping(value = "/myStatistics", method = RequestMethod.GET)
	public String myStatistics(Model model, HttpSession session, HttpServletRequest request
			, MisTmBscViewVO inVO) {

		logger.info("======= myStatistics =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || mbrVo.getUser_no() == ""){
			logger.info("myStatistics - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		if(inVO.getViewFromDate() == null || inVO.getViewFromDate().equals("")){
			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate");
			inVO.setViewFromDate(nowVO.getNow_from());
			inVO.setViewToDate(nowVO.getNow_to());
			inVO.setViewFromYear(nowVO.getYear_from());
			inVO.setViewToYear(nowVO.getYear_to());
			inVO.setUser_no(mbrVo.getUser_no());
			inVO.setUser_name(mbrVo.getUser_name());
		}else{
			StatisticsNowVO nowVO = sqlSession.selectOne("StatisticsNowMapper.statisticsNowDate2", inVO);
			inVO.setViewFromYear(nowVO.getYear_from());
			inVO.setViewToYear(nowVO.getYear_to());
		}



		List<LogMember2VO> getMisTmBscMbr2141 = sqlSession.selectList("MyStatisticsMapper.getMyStatistics141", inVO);
		model.addAttribute("getMisTmBscMbr2141", getMisTmBscMbr2141);

		List<LogMember2VO> getMisTmBscMbr2142 = sqlSession.selectList("MyStatisticsMapper.getMyStatistics142", inVO);
		model.addAttribute("getMisTmBscMbr2142", getMisTmBscMbr2142);
		
		List<LogMember2VO> getMisTmBscMbr2Mi = sqlSession.selectList("MyStatisticsMapper.getMyStatisticsMi", inVO);
		model.addAttribute("getMisTmBscMbr2Mi", getMisTmBscMbr2Mi);

		

		List<LogMember2VO> getMisTmBscMbr2Prim1 = sqlSession.selectList("MyStatisticsMapper.getMyStatisticsPrim1", inVO);
		model.addAttribute("getMisTmBscMbr2Prim1", getMisTmBscMbr2Prim1);

		List<LogMember2VO> getMisTmBscMbr2Prim2 = sqlSession.selectList("MyStatisticsMapper.getMyStatisticsPrim2", inVO);
		model.addAttribute("getMisTmBscMbr2Prim2", getMisTmBscMbr2Prim2);

		List<LogMember2VO> getMisTmBscMbr2MiPrim = sqlSession.selectList("MyStatisticsMapper.getMyStatisticsMiPrim", inVO);
		model.addAttribute("getMisTmBscMbr2MiPrim", getMisTmBscMbr2MiPrim);



		List<LogMember2VO> getMisTmBscMbr2PrimContract1 = sqlSession.selectList("MyStatisticsMapper.getMyStatisticsPrimContract1", inVO);
		model.addAttribute("getMisTmBscMbr2PrimContract1", getMisTmBscMbr2PrimContract1);

		List<LogMember2VO> getMisTmBscMbr2PrimContract2 = sqlSession.selectList("MyStatisticsMapper.getMyStatisticsPrimContract2", inVO);
		model.addAttribute("getMisTmBscMbr2PrimContract2", getMisTmBscMbr2PrimContract2);

		List<LogMember2VO> getMisTmBscMbr2MiPrimContract = sqlSession.selectList("MyStatisticsMapper.getMyStatisticsMiPrimContract", inVO);
		model.addAttribute("getMisTmBscMbr2MiPrimContract", getMisTmBscMbr2MiPrimContract);



		model.addAttribute("inVO", inVO);

		return "top_individual/my_statistics";
	}//myStatistics
	
	**/
}//class
