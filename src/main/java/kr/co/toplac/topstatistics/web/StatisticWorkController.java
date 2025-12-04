package kr.co.toplac.topstatistics.web;

import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

/**
 * Created by kohyeonseok on 2017. 3. 15..
 */
@Controller
public class StatisticWorkController {

    private static final Logger logger = LoggerFactory.getLogger(StatisticWorkController.class);

    @Autowired
    private SqlSession sqlSession;

    /**
     * 팁별 업무처리현황 통계
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/statistics_work_team_list")
    public String workTeamList(HttpServletRequest request, Model model) throws Exception {
        //===============================================
        //	권한체크
        //===============================================
        //TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
        TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();

        if (!"1".equals(mbrAuthVo.getMbr_pms_21())){
            return "redirect:/";
        }

        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 현재 일자 세팅
        //===============================================
        String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));  //기준일자

        if ("".equals(stdBgnde)){
            stdBgnde = DateUtil.getTodayString("yyyy-MM-dd");
            paramMap.put("stdBgnde",stdBgnde);
        }

        //===============================================
        // 필요 날짜 SET
        //===============================================
        String bgnDe = stdBgnde.replace("-","");
        String endDe = DateUtil.addDate(bgnDe, 1);
        paramMap.put("bgnDe", bgnDe);
        paramMap.put("endDe", endDe);

        //===============================================
        // 비즈니스 로직 호출
        //===============================================
        List<Map<String, Object>> workTeamList1 = sqlSession.selectList("StatisticWork.selectWorkTeamList1", paramMap);
        List<Map<String, Object>> workTeamList4 = sqlSession.selectList("StatisticWork.selectWorkTeamList4", paramMap);

        Long unixTime = DateUtil.getUnixTimeStamp(endDe);

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("workTeamList1",workTeamList1);
        model.addAttribute("workTeamList4",workTeamList4);
        model.addAttribute("unixTime", unixTime);
        model.addAttribute("srchArg",paramMap);

        return "top_statistics/statistics_work_team_list";
    }

    /**
     * 개인별 업무처리현황 통계
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/statistics_work_member_list")
    public String workMemberList(HttpServletRequest request, Model model) throws Exception {
        //===============================================
        //	권한체크
        //===============================================
        TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();

        if (!"1".equals(mbrAuthVo.getMbr_pms_21())){
            return "redirect:/";
        }

        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 현재 일자 세팅
        //===============================================
        String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));  //기준일자
        String teamType = StringUtil.null2blank(request.getParameter("team_type"));  //1종 4종 구분
        String teamId = StringUtil.null2blank(request.getParameter("team_id"));  //팀 아이디

        if ("".equals(stdBgnde)){
            stdBgnde = DateUtil.getTodayString("yyyy-MM-dd");
            paramMap.put("stdBgnde",stdBgnde);
        }

        if ("".equals(teamId) || "".equals(teamType)){
            return "redirect:/";
        }

        //===============================================
        // 필요 날짜 SET
        //===============================================
        String bgnDe = stdBgnde.replace("-","");
        String endDe = DateUtil.addDate(bgnDe, 1);
        paramMap.put("bgnDe", bgnDe);
        paramMap.put("endDe", endDe);

        //===============================================
        // 비즈니스 로직 호출
        //===============================================
        TopTmBscVO teamVo = sqlSession.selectOne("TmMngDtlMapper.selectOneTeam", teamId);

        List<Map<String, Object>> workMemberList = null;
        if ("1".equals(teamType)){
            workMemberList = sqlSession.selectList("StatisticWork.selectWorkMemberList1", paramMap);
        }else{
            workMemberList = sqlSession.selectList("StatisticWork.selectWorkMemberList4", paramMap);
        }

        Long unixTime = DateUtil.getUnixTimeStamp(endDe);

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("teamVo", teamVo);
        model.addAttribute("workMemberList",workMemberList);
        model.addAttribute("unixTime", unixTime);
        model.addAttribute("srchArg",paramMap);

        return "top_statistics/statistics_work_member_list";
    }

    /**
     * 업무처리현황 엑셀 다운로드
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/statistics_work_list_excel", method = RequestMethod.POST)
    public String workTeamListExcel(HttpServletRequest request, HttpServletResponse response){
        //===============================================
        //	권한체크
        //===============================================
        TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();

        if (!"1".equals(mbrAuthVo.getMbr_pms_21())){
            return "redirect:/";
        }


        String excelHtml = StringUtil.null2blank(request.getParameter("excelHtml"));  //엑셀 표시 부분
        String gubun = StringUtil.null2blank(request.getParameter("gubun"));  //팀 멤버 구분

        response.reset();
        //response.setCharacterEncoding("euc-kr");
        response.setContentType("application/vnd.ms-excel; charset=UTF-8");
        response.setHeader("Content-Disposition","attachment;filename=work_"+gubun+"_statistic.xls");
        response.setHeader("Content-Description", "JSP Generated Data");
        PrintWriter out = null;
        try {
            out = response.getWriter();
        } catch (IOException e) {
            e.printStackTrace();
        }
        out.println(excelHtml);

        return null;
    }

    /**
     * 팀별 청구 내역 통계
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/statistics_result_team_list")
    public String resultTeamList(HttpServletRequest request, Model model) throws Exception {
        //===============================================
        //	권한체크
        //===============================================
        //TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
        TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();

        if (!"1".equals(mbrAuthVo.getMbr_pms_21())){
            return "redirect:/";
        }

        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

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

//        System.out.println("bgnDe:["+bgnDe+"]");
//        System.out.println("endDe:["+endDe+"]");
//        System.out.println("bgnYearDe:["+bgnYearDe+"]");
//        System.out.println("endYearDe:["+endYearDe+"]");

        //===============================================
        // 비즈니스 로직 호출
        //===============================================
        List<Map<String, Object>> teamList = sqlSession.selectList("StatisticWork.selectResultTeamList", paramMap);

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("teamList",teamList);
        model.addAttribute("srchArg",paramMap);

        return "top_statistics/statistics_result_team_list";
    }


    /**
     * 개인별 청구내역 통계
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/statistics_result_member_list")
    public String resultMemberList(HttpServletRequest request, Model model) throws Exception {
        //===============================================
        //	권한체크
        //===============================================
        TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
        if (!"1".equals(mbrAuthVo.getMbr_pms_21())){
            return "redirect:/";
        }

        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 현재 일자 세팅
        //===============================================
        String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));  //기준일자 시작일
        String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));  //기준일자 종료일
        String teamId = StringUtil.null2blank(request.getParameter("team_id"));  //팀 아이디

        if ("".equals(stdBgnde)){
            stdBgnde = DateUtil.getStartMonthDay();
            stdEndde = DateUtil.getEndMonthDay();

            stdBgnde = DateUtil.getDateFormat(stdBgnde,"-");
            stdEndde = DateUtil.getDateFormat(stdEndde,"-");

            paramMap.put("stdBgnde",stdBgnde);
            paramMap.put("stdEndde",stdEndde);
        }

        if ("".equals(teamId)){
            return "redirect:/";
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

        //===============================================
        // 비즈니스 로직 호출
        //===============================================

        TopTmBscVO teamVo = sqlSession.selectOne("TmMngDtlMapper.selectOneTeam", teamId);

        List<Map<String, Object>> memberList = sqlSession.selectList("StatisticWork.selectResultMemberList", paramMap);;

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("teamVo", teamVo);
        model.addAttribute("memberList",memberList);
        model.addAttribute("srchArg",paramMap);

        return "top_statistics/statistics_result_member_list";
    }

    /**
     * 업무처리현황 엑셀 다운로드
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/statistics_result_list_excel", method = RequestMethod.POST)
    public String resultListExcel(HttpServletRequest request, HttpServletResponse response){
        //===============================================
        //	권한체크
        //===============================================
        TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();

        if (!"1".equals(mbrAuthVo.getMbr_pms_21())){
            return "redirect:/";
        }


        String excelHtml = StringUtil.null2blank(request.getParameter("excelHtml"));  //엑셀 표시 부분
        String gubun = StringUtil.null2blank(request.getParameter("gubun"));  //팀 멤버 구분

        response.reset();
        //response.setCharacterEncoding("euc-kr");
        response.setContentType("application/vnd.ms-excel; charset=UTF-8");
        response.setHeader("Content-Disposition","attachment;filename=result_"+gubun+"_statistic.xls");
        response.setHeader("Content-Description", "JSP Generated Data");
        PrintWriter out = null;
        try {
            out = response.getWriter();
        } catch (IOException e) {
            e.printStackTrace();
        }
        out.println(excelHtml);

        return null;
    }

    /**
     * 팀별 정산 내역 통계
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/statistics_calc_team_list")
    public String calcTeamList(HttpServletRequest request, Model model) throws Exception {
        //===============================================
        //	권한체크
        //===============================================
        //TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
        TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();

        if (!"1".equals(mbrAuthVo.getMbr_pms_21())){
            return "redirect:/";
        }

        //System.out.println("stdBgnde:["+DateUtil.getStartMonthDay()+"]");
        //System.out.println("stdEndde:["+DateUtil.getEndMonthDay()+"]");


        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

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

        System.out.println("bgnDe:["+bgnDe+"]");
        System.out.println("endDe:["+endDe+"]");
        System.out.println("bgnYearDe:["+bgnYearDe+"]");
        System.out.println("endYearDe:["+endYearDe+"]");

        //===============================================
        // 비즈니스 로직 호출
        //===============================================
        //List<Map<String, Object>> workTeamList1 = sqlSession.selectList("StatisticWork.selectWorkTeamList1", paramMap);
        //List<Map<String, Object>> workTeamList4 = sqlSession.selectList("StatisticWork.selectWorkTeamList4", paramMap);

        //Long unixTime = DateUtil.getUnixTimeStamp(endDe);

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        //model.addAttribute("workTeamList1",workTeamList1);
        //model.addAttribute("workTeamList4",workTeamList4);
        //model.addAttribute("unixTime", unixTime);
        model.addAttribute("srchArg",paramMap);

        return "top_statistics/statistics_calc_team_list";
    }


    /**
     * 개인별 정산내역 통계
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/statistics_calc_member_list")
    public String calcMemberList(HttpServletRequest request, Model model) throws Exception {
        //===============================================
        //	권한체크
        //===============================================
        TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();

        if (!"1".equals(mbrAuthVo.getMbr_pms_21())){
            return "redirect:/";
        }

        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

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

        System.out.println("bgnDe:["+bgnDe+"]");
        System.out.println("endDe:["+endDe+"]");
        System.out.println("bgnYearDe:["+bgnYearDe+"]");
        System.out.println("endYearDe:["+endYearDe+"]");

        /*
        //===============================================
        // 비즈니스 로직 호출
        //===============================================

        TopTmBscVO teamVo = sqlSession.selectOne("TmMngDtlMapper.selectOneTeam", teamId);

        List<Map<String, Object>> workMemberList = null;
        if ("1".equals(teamType)){
            workMemberList = sqlSession.selectList("StatisticWork.selectWorkMemberList1", paramMap);
        }else{
            workMemberList = sqlSession.selectList("StatisticWork.selectWorkMemberList4", paramMap);
        }

        Long unixTime = DateUtil.getUnixTimeStamp(endDe);

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("teamVo", teamVo);
        model.addAttribute("workMemberList",workMemberList);
        model.addAttribute("unixTime", unixTime);
        */
        model.addAttribute("srchArg",paramMap);

        return "top_statistics/statistics_calc_member_list";
    }

}
