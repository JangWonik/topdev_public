package kr.co.toplac.sysadm.migration;

import java.util.List;

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

@Controller
public class MigrationPrint17 {

	@Autowired
	private SqlSession sqlSession;

	private static final Logger logger = LoggerFactory.getLogger(MigrationPrint17.class);

	@RequestMapping(value = "/migrationPrint172", method = RequestMethod.GET)
	public String migrationPrint172(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= migrationPrint172 =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migrationPrint172 - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		//기존 data 삭제
		sqlSession.delete("MigPrint17UtilMapper.print172DeleteAll");

		//입력 대상 data 조회
		List<MigrationPrint17VO> targetList = sqlSession.selectList("MigPrint17UtilMapper.report17Forprint172List");

		//data 입력
		MigrationPrint17VO tmpVO = null;
		String tmpStr = null;
		String [] tmpArr1 = null;
		MigrationPrint17VO inVO = null;
		for(int i = 0; i < targetList.size(); i++){
			tmpVO = targetList.get(i);
			tmpStr = tmpVO.getSplitTargetData();
			tmpArr1 = tmpStr.split("breakpoint");
			inVO = new MigrationPrint17VO();
			inVO.setSuim_rpt_no(tmpVO.getRid());
			inVO.setChunggu_dtl_1(tmpArr1[0]);
			inVO.setChunggu_dtl_2(tmpArr1[1]);
			inVO.setChunggu_dtl_3(tmpArr1[2]);
			inVO.setChunggu_dtl_4(tmpArr1[3]);
			inVO.setChunggu_dtl_5(tmpArr1[4]);
			inVO.setChunggu_dtl_6(tmpArr1[5]);
			inVO.setChunggu_dtl_7(tmpArr1[6]);
			inVO.setChunggu_dtl_8(tmpArr1[7]);
			inVO.setChunggu_dtl_9(tmpArr1[8]);
			inVO.setChunggu_dtl_10(tmpArr1[9]);
			sqlSession.selectList("MigPrint17UtilMapper.print172Write", inVO);
		}

		//기존 테이블에서 따라온 공백 값을 가진 data 삭제
		sqlSession.update("MigPrint17UtilMapper.print172UpdateSpaceData1");
		sqlSession.update("MigPrint17UtilMapper.print172UpdateSpaceData2");
		sqlSession.update("MigPrint17UtilMapper.print172UpdateSpaceData3");
		sqlSession.update("MigPrint17UtilMapper.print172UpdateSpaceData4");
		sqlSession.update("MigPrint17UtilMapper.print172UpdateSpaceData5");
		sqlSession.update("MigPrint17UtilMapper.print172UpdateSpaceData6");
		sqlSession.update("MigPrint17UtilMapper.print172UpdateSpaceData7");
		sqlSession.update("MigPrint17UtilMapper.print172UpdateSpaceData8");
		sqlSession.update("MigPrint17UtilMapper.print172UpdateSpaceData9");
		sqlSession.update("MigPrint17UtilMapper.print172UpdateSpaceData10");
		sqlSession.delete("MigPrint17UtilMapper.print172DeleteSpaceData");
		sqlSession.update("MigPrint17UtilMapper.print172UpdateSpaceData11");
		sqlSession.update("MigPrint17UtilMapper.print172UpdateSpaceData110");
		sqlSession.update("MigPrint17UtilMapper.print172UpdateSpaceData121");
		sqlSession.update("MigPrint17UtilMapper.print172UpdateSpaceData122");
		sqlSession.update("MigPrint17UtilMapper.print172UpdateSpaceData131");
		sqlSession.update("MigPrint17UtilMapper.print172UpdateSpaceData132");
		sqlSession.update("MigPrint17UtilMapper.print172UpdateSpaceData141");
		sqlSession.update("MigPrint17UtilMapper.print172UpdateSpaceData142");
		sqlSession.update("MigPrint17UtilMapper.print172UpdateSpaceData151");
		sqlSession.update("MigPrint17UtilMapper.print172UpdateSpaceData152");
		sqlSession.update("MigPrint17UtilMapper.print172UpdateSpaceData161");
		sqlSession.update("MigPrint17UtilMapper.print172UpdateSpaceData162");
		sqlSession.update("MigPrint17UtilMapper.print172UpdateSpaceData171");
		sqlSession.update("MigPrint17UtilMapper.print172UpdateSpaceData172");
		sqlSession.update("MigPrint17UtilMapper.print172UpdateSpaceData181");
		sqlSession.update("MigPrint17UtilMapper.print172UpdateSpaceData182");
		sqlSession.update("MigPrint17UtilMapper.print172UpdateSpaceData191");
		sqlSession.update("MigPrint17UtilMapper.print172UpdateSpaceData192");

		return "sys_adm_migration/migration_print1_ok";
	}//migrationPrint172

	@RequestMapping(value = "/migrationPrint174", method = RequestMethod.GET)
	public String migrationPrint174(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= migrationPrint174 =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migrationPrint174 - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		//기존 data 삭제
		sqlSession.delete("MigPrint17UtilMapper.print174DeleteAll");

		//입력 대상 data 조회
		List<MigrationPrint17VO> targetList = sqlSession.selectList("MigPrint17UtilMapper.report17Forprint174List");

		//data 입력
		MigrationPrint17VO tmpVO = null;
		String tmpStr = null;
		String [] tmpArr1 = null;
		String [] tmpArr2 = null;
		MigrationPrint17VO inVO = null;
		for(int i = 0; i < targetList.size(); i++){
			tmpVO = targetList.get(i);
			tmpStr = tmpVO.getSplitTargetData();
			tmpArr1 = tmpStr.split("enterpoint");
			for(int k = 0; k < tmpArr1.length; k++){
				tmpArr2 = tmpArr1[k].split("breakpoint");
				inVO = new MigrationPrint17VO();
				inVO.setSuim_rpt_no(tmpVO.getRid());
				inVO.setOther_insu_com(tmpArr2[0]);
				inVO.setOther_insu_join_date(tmpArr2[1]);
				inVO.setOther_insu_join_amt(tmpArr2[2]);
				inVO.setOther_insu_premium(tmpArr2[3]);
				inVO.setOther_insu_agent(tmpArr2[4]);
				sqlSession.selectList("MigPrint17UtilMapper.print174Write", inVO);
			}
		}

		//기존 테이블에서 따라온 공백 값을 가진 data 삭제
		sqlSession.update("MigPrint17UtilMapper.print174UpdateSpaceData1");
		sqlSession.update("MigPrint17UtilMapper.print174UpdateSpaceData2");
		sqlSession.update("MigPrint17UtilMapper.print174UpdateSpaceData3");
		sqlSession.update("MigPrint17UtilMapper.print174UpdateSpaceData4");
		sqlSession.update("MigPrint17UtilMapper.print174UpdateSpaceData5");
		sqlSession.delete("MigPrint17UtilMapper.print174DeleteSpaceData");
		sqlSession.update("MigPrint17UtilMapper.print174UpdateSpaceData11");
		sqlSession.update("MigPrint17UtilMapper.print174UpdateSpaceData15");
		sqlSession.update("MigPrint17UtilMapper.print174UpdateSpaceData121");
		sqlSession.update("MigPrint17UtilMapper.print174UpdateSpaceData122");
		sqlSession.update("MigPrint17UtilMapper.print174UpdateSpaceData131");
		sqlSession.update("MigPrint17UtilMapper.print174UpdateSpaceData132");
		sqlSession.update("MigPrint17UtilMapper.print174UpdateSpaceData141");
		sqlSession.update("MigPrint17UtilMapper.print174UpdateSpaceData142");

		return "sys_adm_migration/migration_print1_ok";
	}//migrationPrint174

	@RequestMapping(value = "/migrationPrint177", method = RequestMethod.GET)
	public String migrationPrint177(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= migrationPrint177 =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migrationPrint177 - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		//기존 data 삭제
		sqlSession.delete("MigPrint17UtilMapper.print177DeleteAll");

		//입력 대상 data 조회
		List<MigrationPrint17VO> targetList = sqlSession.selectList("MigPrint17UtilMapper.report17Forprint177List");

		//data 입력
		MigrationPrint17VO tmpVO = null;
		String tmpStr = null;
		String [] tmpArr1 = null;
		String [] tmpArr2 = null;
		MigrationPrint17VO inVO = null;
		for(int i = 0; i < targetList.size(); i++){
			tmpVO = targetList.get(i);
			tmpStr = tmpVO.getSplitTargetData();
			tmpArr1 = tmpStr.split("enterpoint");
			for(int k = 0; k < tmpArr1.length; k++){
				tmpArr2 = tmpArr1[k].split("breakpoint");
				inVO = new MigrationPrint17VO();
				inVO.setSuim_rpt_no(tmpVO.getRid());
				inVO.setMedical_history_period(tmpArr2[0]);
				inVO.setMedical_history_hospital(tmpArr2[1]);
				inVO.setMedical_history_diagnosis(tmpArr2[2]);
				inVO.setMedical_history_test(tmpArr2[3]);
				inVO.setMedical_history_medicine(tmpArr2[4]);
				sqlSession.selectList("MigPrint17UtilMapper.print177Write", inVO);
			}
		}

		//기존 테이블에서 따라온 공백 값을 가진 data 삭제
		sqlSession.update("MigPrint17UtilMapper.print177UpdateSpaceData1");
		sqlSession.update("MigPrint17UtilMapper.print177UpdateSpaceData2");
		sqlSession.update("MigPrint17UtilMapper.print177UpdateSpaceData3");
		sqlSession.update("MigPrint17UtilMapper.print177UpdateSpaceData4");
		sqlSession.update("MigPrint17UtilMapper.print177UpdateSpaceData5");
		sqlSession.delete("MigPrint17UtilMapper.print177DeleteSpaceData");
		sqlSession.update("MigPrint17UtilMapper.print177UpdateSpaceData11");
		sqlSession.update("MigPrint17UtilMapper.print177UpdateSpaceData15");
		sqlSession.update("MigPrint17UtilMapper.print177UpdateSpaceData121");
		sqlSession.update("MigPrint17UtilMapper.print177UpdateSpaceData122");
		sqlSession.update("MigPrint17UtilMapper.print177UpdateSpaceData131");
		sqlSession.update("MigPrint17UtilMapper.print177UpdateSpaceData132");
		sqlSession.update("MigPrint17UtilMapper.print177UpdateSpaceData141");
		sqlSession.update("MigPrint17UtilMapper.print177UpdateSpaceData142");

		return "sys_adm_migration/migration_print1_ok";
	}//migrationPrint177

	@RequestMapping(value = "/migrationPrint1713", method = RequestMethod.GET)
	public String migrationPrint1713(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= migrationPrint1713 =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migrationPrint1713 - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		//기존 data 삭제
		sqlSession.delete("MigPrint17UtilMapper.print1713DeleteAll");

		//입력 대상 data 조회
		List<MigrationPrint17VO> targetList = sqlSession.selectList("MigPrint17UtilMapper.report17Forprint1713List");

		//data 입력
		MigrationPrint17VO tmpVO = null;
		String tmpStr = null;
		String [] tmpArr1 = null;
		String [] tmpArr2 = null;
		MigrationPrint17VO inVO = null;
		for(int i = 0; i < targetList.size(); i++){
			tmpVO = targetList.get(i);
			tmpStr = tmpVO.getSplitTargetData();
			tmpArr1 = tmpStr.split("enterpoint");
			for(int k = 0; k < tmpArr1.length; k++){
				tmpArr2 = tmpArr1[k].split("breakpoint");
				inVO = new MigrationPrint17VO();
				inVO.setSuim_rpt_no(tmpVO.getRid());
				inVO.setQuestioning_hospital(tmpArr2[0]);
				inVO.setQuestioning_basis(tmpArr2[1]);
				inVO.setQuestioning_visit(tmpArr2[2]);
				inVO.setQuestioning_etc(tmpArr2[3]);
				sqlSession.selectList("MigPrint17UtilMapper.print1713Write", inVO);
			}
		}

		//기존 테이블에서 따라온 공백 값을 가진 data 삭제
		sqlSession.update("MigPrint17UtilMapper.print1713UpdateSpaceData1");
		sqlSession.update("MigPrint17UtilMapper.print1713UpdateSpaceData2");
		sqlSession.update("MigPrint17UtilMapper.print1713UpdateSpaceData3");
		sqlSession.update("MigPrint17UtilMapper.print1713UpdateSpaceData4");
		sqlSession.delete("MigPrint17UtilMapper.print1713DeleteSpaceData");
		sqlSession.update("MigPrint17UtilMapper.print1713UpdateSpaceData11");
		sqlSession.update("MigPrint17UtilMapper.print1713UpdateSpaceData14");
		sqlSession.update("MigPrint17UtilMapper.print1713UpdateSpaceData121");
		sqlSession.update("MigPrint17UtilMapper.print1713UpdateSpaceData122");
		sqlSession.update("MigPrint17UtilMapper.print1713UpdateSpaceData131");
		sqlSession.update("MigPrint17UtilMapper.print1713UpdateSpaceData132");

		return "sys_adm_migration/migration_print1_ok";
	}//migrationPrint1713

}//end of class
