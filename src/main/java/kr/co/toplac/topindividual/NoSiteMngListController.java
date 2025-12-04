/*
*********************************************************
* Program ID	: PrimbizSuimListController
* Program Name	: PrimbizSuimListController
* Description	: 농작물 수임대장 리스트
* Author		: 
* Date			: 2016.06.09.
*********************************************************
*/
package kr.co.toplac.topindividual;

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

import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.cmm.DateUtil;

@Controller
public class NoSiteMngListController {

    private static final Logger logger = LoggerFactory.getLogger(NoSiteMngListController.class);

    @Autowired
    private SqlSession sqlSession;

    /*
    *********************************************************
    * Program ID	: noSiteMngListPop
    * Program Name	: noSiteMngListPop
    * Description	: 현장 중간 미보고 목록
    * Author		:
    * Date			: 2016.10.07.
    *********************************************************
    */
    @RequestMapping(value = "noSiteMngListPop", method = RequestMethod.GET)
    public String noSiteMngListPop(Model model, HttpSession session, HttpServletRequest request) {

        logger.info("======= noSiteMngListPop =======");
        TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
        int workTypeCode = Integer.parseInt(mbrVo.getWork_type_cd());
        int userNo = Integer.parseInt(mbrVo.getUser_no());
        
        if(workTypeCode != 1 && workTypeCode != 2 && workTypeCode != 3 && workTypeCode != 6 && workTypeCode != 7 && workTypeCode != 14 && workTypeCode != 15 ){
            if (userNo != 966 && userNo != 215 && userNo != 1117 && userNo !=882 && userNo !=670 && userNo != 975 && userNo != 1786 ) { //백다혜사원 추가 17.04.18
                logger.info("noSiteMngTmListPop - no permession user_no : "+request.getRemoteAddr());
                session.invalidate();
                return "top_login/top_login";
            }
        }


//        if(mbrVo == null || (workTypeCode != 1 && workTypeCode != 2 && workTypeCode != 3
//                && workTypeCode != 6 && workTypeCode != 7)){
//            logger.info("myNoSiteListPop - no permession user_no : "+request.getRemoteAddr());
//            session.invalidate();
//            return "top_login/top_login";
//        }

        /*
        List<NoSiteMngCpstVO> noSiteMngList = null;
        noSiteMngList = sqlSession.selectList("NoSiteMngListMapper.getNoSiteMngList");
        for(int i = 0; i < noSiteMngList.size(); i++){
            NoSiteMngCpstVO tmpVO = noSiteMngList.get(i);
            tmpVO.setInterim2Cnt((String)sqlSession.selectOne("NoSiteMngListMapper.getNoSiteMngListOneInterim2CntByTeam", tmpVO.getTeam_id()));
        }
        */
        
        Date today = new Date();
        DateFormat dayFormat = new SimpleDateFormat("ddHH");
        String nowDay = dayFormat.format(today);//String형으로 변환

		String LeftTmSuimStateTeamId = sqlSession.selectOne("TmMainLeftUtilMapper.getAdmin23TeamId",mbrVo.getUser_no());
		
		List<String> teamId = new ArrayList<String>();
		if (!LeftTmSuimStateTeamId.equals("") && LeftTmSuimStateTeamId != null){
			if (LeftTmSuimStateTeamId.charAt(0) == '|'){
				LeftTmSuimStateTeamId = LeftTmSuimStateTeamId.substring(1);
			}
		}
		String[] tmpTeam = LeftTmSuimStateTeamId.split("\\|");
		teamId.add(mbrVo.getTeam_id_main());
		for(int i=0; i < tmpTeam.length ; i++){
			teamId.add(tmpTeam[i]);
		}
		
		//근무일기준(공유일체크) 3일전 기준날짜
        String sBeforeWorkDay = DateUtil.getChkDateTo3Workdays(sqlSession, "");		//오늘기준        
        
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("user_no",mbrVo.getUser_no());
        paramMap.put("work_type",mbrVo.getWork_type_cd());
        paramMap.put("team_id",mbrVo.getTeam_id_main());
        paramMap.put("now_day",nowDay);
        paramMap.put("teamId",teamId);
        paramMap.put("before_workday", sBeforeWorkDay);
        
        List<Map<String,Object>> noSiteMngList = null;
        noSiteMngList = sqlSession.selectList("NoSiteMngListMapper.getNoSiteMngList2", paramMap);

        model.addAttribute("noSiteMngList", noSiteMngList);

        return "top_individual/no_site_mng_pop";
    }//noSiteMngListPop

    /*
    *********************************************************
    * Program ID	: noSiteMngTmListPop
    * Program Name	: noSiteMngTmListPop
    * Description	: 현장 중간 미보고 팀원 목록
    * Author		:
    * Date			: 2016.10.07.
    *********************************************************
    */
    @RequestMapping(value = "noSiteMngTmListPop", method = RequestMethod.GET)
    public String noSiteMngTmListPop(Model model, HttpSession session, HttpServletRequest request
            , String tmNo) {

        logger.info("======= noSiteMngTmListPop =======");
        TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
        int workTypeCode = Integer.parseInt(mbrVo.getWork_type_cd());
        int userNo = Integer.parseInt(mbrVo.getUser_no());

        if (mbrVo == null) {
            logger.info("noSiteMngTmListPop - no permession user_no : "+request.getRemoteAddr());
            session.invalidate();
            return "top_login/top_login";
        }

        if(workTypeCode != 1 && workTypeCode != 2 && workTypeCode != 3 && workTypeCode != 6 && workTypeCode != 7 && workTypeCode != 14 && workTypeCode != 15 ){
            if (userNo != 966 && userNo != 215 && userNo != 1117 && userNo !=882 && userNo !=670 && userNo != 975 && userNo != 1786 ) {
                logger.info("noSiteMngTmListPop - no permession user_no : "+request.getRemoteAddr());
                session.invalidate();
                return "top_login/top_login";
            }
        }


//        if(mbrVo == null || (workTypeCode != 1 && workTypeCode != 2 && workTypeCode != 3
//                             && workTypeCode != 6 && workTypeCode != 7) ){
//            logger.info("noSiteMngTmListPop - no permession user_no : "+request.getRemoteAddr());
//            session.invalidate();
//            return "top_login/top_login";
//        }

        /*
        List<NoSiteMngCpstVO> noSiteMngTmList = null;

        noSiteMngTmList = sqlSession.selectList("NoSiteMngListMapper.getNoSiteMngTmList", tmNo);
        for(int i = 0; i < noSiteMngTmList.size(); i++){
            NoSiteMngCpstVO tmpVO = noSiteMngTmList.get(i);
            tmpVO.setInterim2Cnt((String)sqlSession.selectOne("NoSiteMngListMapper.getNoSiteMngTmListOneInterim2CntByUser", tmpVO.getUser_no()));
        }
        */
        
        Date today = new Date();
        DateFormat dayFormat = new SimpleDateFormat("ddHH");
        String nowDay = dayFormat.format(today);//String형으로 변환
        
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("user_no",mbrVo.getUser_no());
        paramMap.put("work_type",mbrVo.getWork_type_cd());
        paramMap.put("team_id",tmNo);
        paramMap.put("now_day",nowDay);
        
        List<Map<String, Object>> noSiteMngTmList = null;

        noSiteMngTmList = sqlSession.selectList("NoSiteMngListMapper.getNoSiteMngTmList2", paramMap);

        model.addAttribute("noSiteMngTmList", noSiteMngTmList);

        return "top_individual/no_site_mng_tm_pop";
    }//noSiteMngTmListPop

    /*
    *********************************************************
    * Program ID	: kind4MiMngListPop
    * Program Name	: kind4MiMngListPop
    * Description	: 4종 목록
    * Author		:
    * Date			: 2016.10.07.
    *********************************************************
    */
    
    @RequestMapping(value = "kind4MiMngListPop", method = RequestMethod.GET)
    public String kind4MiMngListPop(Model model, HttpSession session, HttpServletRequest request) {

        logger.info("======= kind4MiMngListPop =======");
        TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
        int workTypeCode = Integer.parseInt(mbrVo.getWork_type_cd());
        int userState = Integer.parseInt(mbrVo.getUser_state());
        if(mbrVo == null || (workTypeCode != 1 && workTypeCode != 2 && workTypeCode != 3
                && workTypeCode != 6 && workTypeCode != 7 && workTypeCode != 14 && workTypeCode != 15 && userState != 9 )){
            logger.info("kind4MiMngListPop - no permession user_no : "+request.getRemoteAddr());
            session.invalidate();
            return "top_login/top_login";
        }

        List<NoSiteMngCpstVO> kind4MiMngList = null;
        kind4MiMngList = sqlSession.selectList("NoSiteMngListMapper.getKind4MiMngList");
        model.addAttribute("kind4MiMngList", kind4MiMngList);

        return "top_individual/kind4_mi_mng_pop";
    }//kind4MiMngListPop

}//end of class
