package kr.co.toplac.toprptmbrchg.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.cmm.service.CodeDicService;
import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.sysadm.SysAdmCodeDicVO;
import kr.co.toplac.toprptmbrchg.RptMbrchgVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.PaginationInfo;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;
import kr.co.toplac.util.etc.Damo;



/*
*********************************************************
* Program ID	: rptMbrChgService
* Program Name	: rptMbrChgService
* Description	: 이내첩대장 service
* Author		: lds
* Date			: 2017.09.27
*********************************************************
*/
@Service
public class RptMbrchgService{
	
	@Autowired
	private SqlSession sqlSession;
	
    @Autowired
    private CodeDicService service;
	
	private static final Logger logger = LoggerFactory.getLogger(RptMbrchgService.class);

	/*
	*********************************************************
	* Method ID		: rptMbrChgList
	* Method Name	: rptMbrChgList
	* Description	: 보고서 담당자 변경 LIST SELECT
	* Author		: lds
	* Date			: 2017.09.27
	*********************************************************
	*/
	public HashMap<String, Object> rptMbrchgList(Map<String,Object> paramMap, String gubun){
		logger.info("======= rptMbrChgList =======");
		
	    //===============================================
	    //	권한체크
	    //===============================================ㄴ
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		
	    String user_nm = mbrVo.getUser_name();
		String user_no = mbrVo.getUser_no();
		String team_id = mbrVo.getTeam_id_main();

		paramMap.put("user_no", user_no);
		paramMap.put("user_nm", user_nm);
		paramMap.put("team_id", team_id);
        
        //===============================================
        // LIST SELECT 및 DATA처리
        //===============================================
		List<RptMbrchgVO> rptMbrchgList = null;
		long count = 0;
		
		if ("excel".equals(gubun)){
			rptMbrchgList =  sqlSession.selectList("RptMbrchgMapper.getMbrchgListExcel",paramMap);
		}else{
			rptMbrchgList =  sqlSession.selectList("RptMbrchgMapper.getMbrchgList",paramMap);
			count = sqlSession.selectOne("RptMbrchgMapper.getMbrchgListCnt",paramMap);
		}

		
		Damo damo = new Damo(); //디아모 암호화 적용 클래스 생성
		for(int i=0; i < rptMbrchgList.size() ;i++){
			
			if ( (rptMbrchgList.get(i).getAccidentNo() != null && rptMbrchgList.get(i).getAccidentNo() != "")
				  && rptMbrchgList.get(i).getAccidentNo().length() >= 5){
				String accidentNo1 = rptMbrchgList.get(i).getAccidentNo().substring(0,4);
				String accidentNo2 = rptMbrchgList.get(i).getAccidentNo().substring(4);
				
				rptMbrchgList.get(i).setAccidentNo1(accidentNo1);
				rptMbrchgList.get(i).setAccidentNo2(accidentNo2);
			}
		}
        
		//권한별 팀목록 추출
		List<TopTmBscVO> topTeamList = sqlSession.selectList("SuimRegInsMapper.topTeamList",paramMap);
				
        //권한별 팀목록 추출
		List<TopTmBscVO> pmsTeamList = sqlSession.selectList("RptMbrchgMapper.pmsTeamList",paramMap);
		
        //코드 리스트 가져오기
        SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();
        codeVo.setTbl_nm("top_rpt_mbrchg");
        codeVo.setCol_nm("mbrchg_reason");
        List<SysAdmCodeDicVO> mbrchgReasonList = service.codeList(codeVo);

        
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("rptMbrchgList",rptMbrchgList);
		resultMap.put("rptMbrchgListCnt",count);
		resultMap.put("mbrchgReasonList",mbrchgReasonList);
		
        resultMap.put("pmsTeamList", pmsTeamList);
        resultMap.put("topTeamList", topTeamList);
		return resultMap;
	}
	
	/*
	*********************************************************
	* Method ID		: rptMbrchgOut
	* Method Name	: rptMbrchgOut
	* Description	: 보고서 담당자 변경 (이첩 INSERT)
	* Author		: lds
	* Date			: 2017.10.12
	*********************************************************
	*/
	public HashMap<String, Object> rptMbrchgOut(Map<String,Object> paramMap){
		logger.info("======= rptMbrchgOut - SERVICE =======");
		
	    //===============================================
	    //	권한체크
	    //===============================================ㄴ
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		String user_no = mbrVo.getUser_no();
		paramMap.put("sessUserNo", user_no);
		
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		
		//===============================================
		// 이첩 INSERT
		//===============================================
		paramMap.put("mbrchgReason", paramMap.get("mbrchgReason"));
		paramMap.put("toUserNo", paramMap.get("toUserNo"));
		paramMap.put("toTeamId", paramMap.get("toTeamId"));
		
		String[] tmpArr =  (String[]) paramMap.get("outRpt");
		
		try {
			for(String str : tmpArr){
				String[] tmpStr = str.split("-");
				String suimRptNo = tmpStr[0];
				String fromUserNo = tmpStr[1];
				String fromTeamId = tmpStr[2];
				paramMap.put("suimRptNo", suimRptNo);
				paramMap.put("fromUserNo", fromUserNo);
				paramMap.put("fromTeamId", fromTeamId);
				
				sqlSession.insert("RptMbrchgMapper.insRptOut",paramMap);
			}
			resultMap.put("result", "0000");
		} catch (Exception e){
            resultMap.put("result","1010");
            e.printStackTrace();
        }
		
		return resultMap;
        
	}
	
	
	/*
	*********************************************************
	* Method ID		: rptMbrchgOutCancel
	* Method Name	: rptMbrchgOutCancel
	* Description	: 보고서 담당자 변경 (이첩 회수)
	* Author		: lds
	* Date			: 2017.10.12
	*********************************************************
	*/
	public HashMap<String, Object> rptMbrchgOutCancel(Map<String,Object> paramMap){
		logger.info("======= rptMbrchgOutCancel - SERVICE =======");
		
	    //===============================================
	    //	권한체크
	    //===============================================ㄴ
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		
		//===============================================
		// 이첩 회수 UPDATE 
		//===============================================
		String[] tmpArr =  (String[]) paramMap.get("serialNo");
		
		try {
			for(String str : tmpArr){
				paramMap.put("serialNo",str);
				sqlSession.update("RptMbrchgMapper.udtRptOutCancel",paramMap);
			}
			resultMap.put("result", "0000");
		} catch (Exception e){
            resultMap.put("result","1010");
            e.printStackTrace();
        }
		
		return resultMap;
        
	}	
	
	
	/*
	*********************************************************
	* Method ID		: rptMbrchgIn
	* Method Name	: rptMbrchgIn
	* Description	: 보고서 담당자 변경 (내첩)
	* Author		: lds
	* Date			: 2017.10.17
	*********************************************************
	*/
	public HashMap<String, Object> rptMbrchgIn(Map<String,Object> paramMap){
		logger.info("======= rptMbrchgIn - SERVICE =======");
		
	    //===============================================
	    //	권한체크
	    //===============================================ㄴ
	    TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
		
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		
		//===============================================
		//	내첩 UPDATE
		//===============================================
		String[] arrSerialNo =  (String[]) paramMap.get("serialNo");
		String[] arrSuimRptNo = (String[]) paramMap.get("suimRptNo");
		int arrLength = arrSerialNo.length;
		
		paramMap.put("sessTeamId",mbrVo.getTeam_id_main());
		paramMap.put("sessUserNo",mbrVo.getUser_no());
		
		
		try {
			for(int i=0; i < arrLength ;i++){
				paramMap.put("serialNo",arrSerialNo[i]);
				paramMap.put("suimRptNo",arrSuimRptNo[i]);
				
				sqlSession.update("RptMbrchgMapper.udtRptIn",paramMap);
				sqlSession.update("RptMbrchgMapper.udtRptHeadUser",paramMap);
			}
			resultMap.put("result", "0000");
		} catch (Exception e){
            resultMap.put("result","1010");
            e.printStackTrace();
        }
		
		return resultMap;
        
	}		
}


