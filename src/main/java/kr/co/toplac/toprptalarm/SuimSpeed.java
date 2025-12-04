package kr.co.toplac.toprptalarm;

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
import kr.co.toplac.toprptalarm.SuimSpeedVO;
import kr.co.toplac.topsuim.SuimRptCompositeVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.PaginationInfo;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;
import kr.co.toplac.util.etc.Damo;



/*
*********************************************************
* Program ID	: SuimSpeed
* Program Name	: 스피드 수임건 관리  
* Description	: 컨트롤러 간소화
* Author		: lds
* Date			: 2017.06.29
*********************************************************
*/
@Service
public class SuimSpeed{
	
	@Autowired
	private SqlSession sqlSession;
	
    @Autowired
    private CodeDicService service;
	
	private static final Logger logger = LoggerFactory.getLogger(SuimSpeed.class);

	/*
	*********************************************************
	* Method ID		: SuimSpeedList
	* Method Name	: 서면심사 미결건리스트 
	* Description	: 페이지 모듈화
	* Author		: lds
	* Date			: 2017.06.29
	*********************************************************
	*/
	public HashMap<String, Object> SuimSpeedList(Map<String,Object> paramMap, String gubun){
		logger.info("======= SuimSpeedList =======");
		
	    //===============================================
	    //	권한체크
	    //===============================================
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
		List<SuimSpeedVO> speedList = null;
		long count = 0;
		
		if ("excel".equals(gubun)){
			speedList =  sqlSession.selectList("RptAlarmMapper.getSuimSpeedExcel",paramMap);
		}else{
			speedList =  sqlSession.selectList("RptAlarmMapper.getSuimSpeed",paramMap);
			count =  sqlSession.selectOne("RptAlarmMapper.getSuimSpeedCnt",paramMap);
		}
		
		Damo damo = new Damo(); //디아모 암호화 적용 클래스 생성
		for(int i=0; i < speedList.size() ;i++){
			//계약자 전화번호 암호화
			if ( speedList.get(i).getPolicyholderTel() != null && speedList.get(i).getPolicyholderTel() != ""){
				speedList.get(i).setPolicyholderTel( damo.decodeDamo(speedList.get(i).getPolicyholderTel()) );
			}else{
				speedList.get(i).setPolicyholderTel("전화번호 미입력");
			}
			
			//피보험자 전화번호 암호화
			if ( speedList.get(i).getBeneficiaryTel() != null && speedList.get(i).getBeneficiaryTel() != ""){
				speedList.get(i).setBeneficiaryTel( damo.decodeDamo(speedList.get(i).getBeneficiaryTel()) );
			}else{
				speedList.get(i).setBeneficiaryTel("전화번호 미입력");
			}
			
			//피해자 전화번호 암호화
			if ( speedList.get(i).getDamagedTel() != null && speedList.get(i).getDamagedTel() != ""){
				speedList.get(i).setDamagedTel( damo.decodeDamo(speedList.get(i).getDamagedTel()) );
			}else{
				speedList.get(i).setDamagedTel("전화번호 미입력");
			}
			
			if ( (speedList.get(i).getAccidentNo() != null && speedList.get(i).getAccidentNo() != "")
				  && speedList.get(i).getAccidentNo().length() >= 5){
				String accidentNo1 = speedList.get(i).getAccidentNo().substring(0,4);
				String accidentNo2 = speedList.get(i).getAccidentNo().substring(4);
				
				speedList.get(i).setAccidentNo1(accidentNo1);
				speedList.get(i).setAccidentNo2(accidentNo2);
			}
		}
		
        //코드 리스트 가져오기
        SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();
        codeVo.setTbl_nm("top_rpt_head");
        codeVo.setCol_nm("speed_type");
        List<SysAdmCodeDicVO> speedCodeList = service.codeList(codeVo);
        
        //탑 부서 호출
		List<TopTmBscVO> topTeamList = sqlSession.selectList("SuimRegInsMapper.topTeamList");
        
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("speedList",speedList);
		resultMap.put("speedListCnt",count);
		
        resultMap.put("speedCodeList",speedCodeList);
        resultMap.put("topTeamList", topTeamList);
        
		return resultMap;
	}
	
	
	
	
	/*
	*********************************************************
	* Method ID		: SuimSpeedExcelList
	* Method Name	: 보고서 알림 excel 리스트
	* Description	: 
	* Author		: lds
	* Date			: 2017.09.13
	*********************************************************
	*/
	public HashMap<String, Object> SuimSpeedExcelList(Map<String,Object> paramMap){
		logger.info("======= SuimSpeedList =======");
		
	    //===============================================
	    //	권한체크
	    //===============================================
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
		List<SuimSpeedVO> speedList = null;
		speedList =  sqlSession.selectList("RptAlarmMapper.getSuimSpeedExcel",paramMap);
		
		Damo damo = new Damo(); //디아모 암호화 적용 클래스 생성
		for(int i=0; i < speedList.size() ;i++){
			//계약자 전화번호 암호화
			if ( speedList.get(i).getPolicyholderTel() != null && speedList.get(i).getPolicyholderTel() != ""){
				speedList.get(i).setPolicyholderTel( damo.decodeDamo(speedList.get(i).getPolicyholderTel()) );
			}else{
				speedList.get(i).setPolicyholderTel("전화번호 미입력");
			}
			
			//피보험자 전화번호 암호화
			if ( speedList.get(i).getBeneficiaryTel() != null && speedList.get(i).getBeneficiaryTel() != ""){
				speedList.get(i).setBeneficiaryTel( damo.decodeDamo(speedList.get(i).getBeneficiaryTel()) );
			}else{
				speedList.get(i).setBeneficiaryTel("전화번호 미입력");
			}
			
			//피해자 전화번호 암호화
			if ( speedList.get(i).getDamagedTel() != null && speedList.get(i).getDamagedTel() != ""){
				speedList.get(i).setDamagedTel( damo.decodeDamo(speedList.get(i).getDamagedTel()) );
			}else{
				speedList.get(i).setDamagedTel("전화번호 미입력");
			}
			
			if ( (speedList.get(i).getAccidentNo() != null && speedList.get(i).getAccidentNo() != "")
				  && speedList.get(i).getAccidentNo().length() > 5){
				String accidentNo1 = speedList.get(i).getAccidentNo().substring(0,4);
				String accidentNo2 = speedList.get(i).getAccidentNo().substring(5);
				
				speedList.get(i).setAccidentNo1(accidentNo1);
				speedList.get(i).setAccidentNo2(accidentNo2);
			}
		}
		
        
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("speedList",speedList);
        
		return resultMap;
	}
	
	
}


