package kr.co.toplac.rptin;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.topsuim.SuimRptBody1_13467VO;
import kr.co.toplac.util.cmm.DateUtil;



/*
*********************************************************
* Program ID	: SuimPrint1001
* Program Name	: 4종 일반 - 단순보고서  
* Description	: 컨트롤러 간소화
* Author		: lds
* Date			: 2017.02.15
*********************************************************
*/

public class SuimPrint1001 {
	@Autowired
	private SqlSession sqlSession;
	
	private static final Logger logger = LoggerFactory.getLogger(SuimPrint1001.class);
	/*
	*********************************************************
	* Method ID		: SuimPrint1001
	* Method Name	: 기본 작업
	* Description	: 페이지 모듈화
	* Author		: lds
	* Date			: 2017.02.17
	*********************************************************
	*/
	
	public void SuimPrint1001_print1(SqlSession sqlSession, Model model ,String suim_rpt_no){
		logger.info("======= SuimPrint1001_print1 =======");
		/** 단순보고서 정보 SELECT 후 없으면 한줄 insert 후, rptPrintNo값 세팅 **/
		SuimPrint1001VO print_1_1001 = sqlSession.selectOne("SuimRptPrintMapper.get1001Print_1", suim_rpt_no);
		if(print_1_1001 == null){
			HashMap<String, String> mapForRptPrintNo = new HashMap<String, String>();
			mapForRptPrintNo.put("rptPrintNo", "");
			mapForRptPrintNo.put("suim_rpt_no", suim_rpt_no);
			sqlSession.insert("SuimRptPrintMapper.ins1001Print_1", mapForRptPrintNo);
			print_1_1001 = new SuimPrint1001VO();
			print_1_1001.setRptPrintNo(mapForRptPrintNo.get("rptPrintNo"));
		}
		
		/** 청구사항 - 담보내역  **/
		List<SuimPrint1001VO> print_1_assure = sqlSession.selectList("SuimRptPrintMapper.get1001Print_1_assure", print_1_1001.getRptPrintNo());
		
		/** 타 보험사 계약 및 지급사항 **/
		List<SuimPrint1001VO> print_1_2_1001 = sqlSession.selectList("SuimRptPrintMapper.get1001Print_1_2", print_1_1001.getRptPrintNo());
		
		/** 사고처리과정표 첨부서류 종류 셀렉트 **/
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("tbl_nm", "top_rpt_print_1_8");
		map.put("col_nm", "attach_name");
		List<SuimPrint1001VO> sagoDocKindList = sqlSession.selectList("SuimRptPrintMapper.getCodeList",map);
		
		/** 4. 중점 조사사항 및 조사 결과 - 중점 조사사항 codedic **/
		map.put("tbl_nm", "top_rpt_print_1");
		map.put("col_nm", "inspect_point_4");
		List<SuimPrint1001VO> inspectPointList = sqlSession.selectList("SuimRptPrintMapper.getCodeList",map);

		/** 4. 중점 조사사항 및 조사 결과 - 조사결과 codedic **/
		map.put("tbl_nm", "top_rpt_print_1");
		map.put("col_nm", "inspect_result_4");
		List<SuimPrint1001VO> inspectResultList = sqlSession.selectList("SuimRptPrintMapper.getCodeList",map);

		/** 5. 총괄 경과표 **/
		List<SuimPrint1001VO> print_1_6_1_1001 = sqlSession.selectList("SuimRptPrintMapper.get1001Print_1_6_1", print_1_1001.getRptPrintNo());
		
		/** 6. 상세 확인사항 **/
		List<SuimPrint1001VO> print_1_detail_check = sqlSession.selectList("SuimRptPrintMapper.get1001Print_1_detail_check",print_1_1001.getRptPrintNo());
		HashMap<String,String> detailMap = new HashMap<String,String>();
		for(int i=0; i < print_1_detail_check.size() ; i++){
			if (print_1_detail_check.get(i).getDetailGubun().equals("1")){
				detailMap.put("jobContent", print_1_detail_check.get(i).getDetailContent() );
				detailMap.put("jobContentSub", print_1_detail_check.get(i).getDetailContentSub() );
				detailMap.put("jobUseFlag", print_1_detail_check.get(i).getUseFlag() );
				//map에 담은 것들은 삭제
//				print_1_detail_check.remove(i);
			}else if (print_1_detail_check.get(i).getDetailGubun().equals("2")) {
				detailMap.put("accidentContent", print_1_detail_check.get(i).getDetailContent() );
				detailMap.put("accidentContentSub", print_1_detail_check.get(i).getDetailContentSub() );
				detailMap.put("accidentUseFlag", print_1_detail_check.get(i).getUseFlag() );
			}else if (print_1_detail_check.get(i).getDetailGubun().equals("3")) {
				detailMap.put("hospitalContent", print_1_detail_check.get(i).getDetailContent() );
				detailMap.put("hospitalUseFlag", print_1_detail_check.get(i).getUseFlag() );				
			}else if (print_1_detail_check.get(i).getDetailGubun().equals("4")) {
				detailMap.put("adviceContent", print_1_detail_check.get(i).getDetailContent() );
				detailMap.put("adviceUseFlag", print_1_detail_check.get(i).getUseFlag() );				
			}else if (print_1_detail_check.get(i).getDetailGubun().equals("5")) {
				detailMap.put("hurdleContent", print_1_detail_check.get(i).getDetailContent() );
				detailMap.put("hurdleUseFlag", print_1_detail_check.get(i).getUseFlag() );
			}
		}
		
		/** 상세 확인사항 - 직업확인 CODE**/
		map.put("tbl_nm", "top_rpt_print_1_detail_check");
		map.put("col_nm", "job");
		List<SuimPrint1001VO> dtlJobList = sqlSession.selectList("SuimRptPrintMapper.getCodeList",map);
		
		/** 상세 확인사항 - 사고경위 CODE**/
		map.put("tbl_nm", "top_rpt_print_1_detail_check");
		map.put("col_nm", "accident");
		List<SuimPrint1001VO> dtlAccidentList = sqlSession.selectList("SuimRptPrintMapper.getCodeList",map);
		
		/** 사고처리과정표 - 처리과정 **/
		List<SuimPrint1001VO> print_1_ctrl = sqlSession.selectList("SuimRptPrintMapper.get1001Print_1_ctrl", print_1_1001.getRptPrintNo());
		SuimPrint1001VO print_1_ctrl_delay_cnt = sqlSession.selectOne("SuimRptPrintMapper.get1001Print_1_ctrl_delay_cnt", print_1_1001.getRptPrintNo());
		
		//지연주체가 보험사인 경우의 지연 일수의 합.
		int insuDelayCnt = 0;
		for(int i=0; i < print_1_ctrl.size() ;i++){
			if ( print_1_ctrl.get(i).getControlDelayCnt() != null && !print_1_ctrl.get(i).getControlDelayCnt().equals("") ){
				if ( print_1_ctrl.get(i).getControlDelayAgent().equals("1") ){
					insuDelayCnt += Integer.parseInt( print_1_ctrl.get(i).getControlDelayCnt() ) ;
				}
			}
		}
		
		model.addAttribute("insuDelayCnt",insuDelayCnt);
		
		/** 사고처리과정표 - 첨부서류 셀렉트 **/
		List<SuimPrint1001VO> print1_8_1001 = sqlSession.selectList("SuimRptPrintMapper.get1001Print_1_8",print_1_1001.getRptPrintNo());
        
        //=============================================================
        // 병의원 탐문 기록지
        //=============================================================
        Map<String, String> paramMap = new HashMap<>();
        paramMap.put("rpt_print_no", print_1_1001.getRptPrintNo());
        List<Map<String, Object>> reportHospitalQuestionList = sqlSession.selectList("SuimReportMapper.selectHospitalQuestionList",paramMap);
		
		
		
		
		
		model.addAttribute("print1",print_1_1001); //기본
		model.addAttribute("print_1_assure",print_1_assure); //담보내역
		model.addAttribute("print_1_2",print_1_2_1001); //타보험사 계약 및 지급사항
		
		model.addAttribute("print_1_6_1",print_1_6_1_1001); //총괄경과표
		model.addAttribute("print_1_detail",print_1_detail_check); //상세 확인사항	
		model.addAttribute("detailMap",detailMap); //상세 확인사항
		
		
		model.addAttribute("print_1_ctrl",print_1_ctrl); //사고처리과정표 - 처리과정
		model.addAttribute("print_1_ctrl_delay_cnt",print_1_ctrl_delay_cnt); //사고처리과정표 - 처리과정 - 지연일수
		
		
		model.addAttribute("print1_8",print1_8_1001); //사고처리과정표 - 첨부서류
		
		model.addAttribute("inspectPointList",inspectPointList);
		model.addAttribute("inspectResultList",inspectResultList);
		model.addAttribute("sagoDocKindList",sagoDocKindList);
		
		model.addAttribute("dtlJobList",dtlJobList); 
		model.addAttribute("dtlAccidentList",dtlAccidentList);
        model.addAttribute("reportHospitalQuestionList", reportHospitalQuestionList);
		
	}
	
}

