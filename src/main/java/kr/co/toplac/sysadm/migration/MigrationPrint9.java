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
public class MigrationPrint9 {

	@Autowired
	private SqlSession sqlSession;

	private static final Logger logger = LoggerFactory.getLogger(MigrationPrint9.class);

	@RequestMapping(value = "/migrationPrint951", method = RequestMethod.GET)
	public String migrationPrint951(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= migrationPrint951 =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migrationPrint951 - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		//기존 data 삭제
		sqlSession.delete("MigPrint9UtilMapper.print951DeleteAll");

		//입력 대상 data 조회
		List<MigrationPrint9VO> targetList = sqlSession.selectList("MigPrint9UtilMapper.report9Forprint951List");

		//data 입력
		MigrationPrint9VO tmpVO = null;
		String tmpStr = null;
		String [] tmpArr1 = null;
		String [] tmpArr2 = null;
		MigrationPrint9VO inVO = null;
		for(int i = 0; i < targetList.size(); i++){
			tmpVO = targetList.get(i);
			tmpStr = tmpVO.getSplitTargetData();
			tmpArr1 = tmpStr.split("enterpoint");
			for(int k = 0; k < tmpArr1.length; k++){
				tmpArr2 = tmpArr1[k].split("breakpoint");
				inVO = new MigrationPrint9VO();
				inVO.setRpt_print_no(tmpVO.getNo());
				inVO.setProcess_date_s(tmpArr2[0]);
				inVO.setProcess_dtl(tmpArr2[1]);
				inVO.setProcess_hospital(tmpArr2[2]);
				inVO.setProcess_date_e(tmpArr2[3]);
				sqlSession.selectList("MigPrint9UtilMapper.print951Write", inVO);
			}
		}

		//기존 테이블에서 따라온 공백 값을 가진 data 삭제
		sqlSession.update("MigPrint9UtilMapper.print951UpdateSpaceData1");
		sqlSession.update("MigPrint9UtilMapper.print951UpdateSpaceData2");
		sqlSession.update("MigPrint9UtilMapper.print951UpdateSpaceData3");
		sqlSession.update("MigPrint9UtilMapper.print951UpdateSpaceData4");
		sqlSession.delete("MigPrint9UtilMapper.print951DeleteSpaceData");
		sqlSession.update("MigPrint9UtilMapper.print951UpdateSpaceData11");
		sqlSession.update("MigPrint9UtilMapper.print951UpdateSpaceData12");
		sqlSession.update("MigPrint9UtilMapper.print951UpdateSpaceData13");
		sqlSession.update("MigPrint9UtilMapper.print951UpdateSpaceData14");
		sqlSession.update("MigPrint9UtilMapper.print951UpdateSpaceData15");
		sqlSession.update("MigPrint9UtilMapper.print951UpdateSpaceData16");
		sqlSession.update("MigPrint9UtilMapper.print951UpdateSpaceData17");
		sqlSession.update("MigPrint9UtilMapper.print951UpdateSpaceData18");

		return "sys_adm_migration/migration_print1_ok";
	}//migrationPrint951

	@RequestMapping(value = "/migrationPrint952", method = RequestMethod.GET)
	public String migrationPrint952(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= migrationPrint952 =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migrationPrint952 - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		//기존 data 삭제
		sqlSession.delete("MigPrint9UtilMapper.print952DeleteAll");

		//입력 대상 data 조회
		List<MigrationPrint9VO> targetList = sqlSession.selectList("MigPrint9UtilMapper.report9Forprint952List");

		//data 입력
		MigrationPrint9VO tmpVO = null;
		String tmpStr = null;
		String [] tmpArr1 = null;
		String [] tmpArr2 = null;
		MigrationPrint9VO inVO = null;
		for(int i = 0; i < targetList.size(); i++){
			tmpVO = targetList.get(i);
			tmpStr = tmpVO.getSplitTargetData();
			tmpArr1 = tmpStr.split("enterpoint");
			for(int k = 0; k < tmpArr1.length; k++){
				tmpArr2 = tmpArr1[k].split("breakpoint");
				inVO = new MigrationPrint9VO();
				inVO.setRpt_print_no(tmpVO.getNo());
				inVO.setOther_insu_com(tmpArr2[0]);
				inVO.setOther_insu_contract(tmpArr2[1]);
				inVO.setOther_insu_process(tmpArr2[2]);
				inVO.setOther_insu_etc_memo(tmpArr2[3]);
				sqlSession.selectList("MigPrint9UtilMapper.print952Write", inVO);
			}
		}

		//기존 테이블에서 따라온 공백 값을 가진 data 삭제
		sqlSession.update("MigPrint9UtilMapper.print952UpdateSpaceData1");
		sqlSession.update("MigPrint9UtilMapper.print952UpdateSpaceData2");
		sqlSession.update("MigPrint9UtilMapper.print952UpdateSpaceData3");
		sqlSession.update("MigPrint9UtilMapper.print952UpdateSpaceData4");
		sqlSession.delete("MigPrint9UtilMapper.print952DeleteSpaceData");
		sqlSession.update("MigPrint9UtilMapper.print952UpdateSpaceData11");
		sqlSession.update("MigPrint9UtilMapper.print952UpdateSpaceData12");
		sqlSession.update("MigPrint9UtilMapper.print952UpdateSpaceData13");
		sqlSession.update("MigPrint9UtilMapper.print952UpdateSpaceData14");
		sqlSession.update("MigPrint9UtilMapper.print952UpdateSpaceData15");
		sqlSession.update("MigPrint9UtilMapper.print952UpdateSpaceData16");
		sqlSession.update("MigPrint9UtilMapper.print952UpdateSpaceData17");
		sqlSession.update("MigPrint9UtilMapper.print952UpdateSpaceData18");

		return "sys_adm_migration/migration_print1_ok";
	}//migrationPrint952

	@RequestMapping(value = "/migrationPrint96", method = RequestMethod.GET)
	public String migrationPrint96(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= migrationPrint96 =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migrationPrint96 - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		//기존 data 삭제
		sqlSession.delete("MigPrint9UtilMapper.print96DeleteAll");

		//입력 대상 data 조회
		List<MigrationPrint9VO> targetList = sqlSession.selectList("MigPrint9UtilMapper.report9Forprint96List");

		//data 입력
		MigrationPrint9VO tmpVO = null;
		String tmpStr = null;
		String [] tmpArr1 = null;
		String [] tmpArr2 = null;
		MigrationPrint9VO inVO = null;
		for(int i = 0; i < targetList.size(); i++){
			tmpVO = targetList.get(i);
			tmpStr = tmpVO.getSplitTargetData();
			tmpArr1 = tmpStr.split("enterpoint");
			for(int k = 0; k < tmpArr1.length; k++){
				tmpArr2 = tmpArr1[k].split("breakpoint");
				inVO = new MigrationPrint9VO();
				inVO.setRpt_print_no(tmpVO.getNo());
				inVO.setInvestigate_outline(tmpArr2[0]);
				inVO.setInvestigate_dtl(tmpArr2[1]);
				sqlSession.selectList("MigPrint9UtilMapper.print96Write", inVO);
			}
		}

		//기존 테이블에서 따라온 공백 값을 가진 data 삭제
		sqlSession.update("MigPrint9UtilMapper.print96UpdateSpaceData1");
		sqlSession.update("MigPrint9UtilMapper.print96UpdateSpaceData2");
		sqlSession.delete("MigPrint9UtilMapper.print96DeleteSpaceData");
		sqlSession.update("MigPrint9UtilMapper.print96UpdateSpaceData3");
		sqlSession.update("MigPrint9UtilMapper.print96UpdateSpaceData4");

		return "sys_adm_migration/migration_print1_ok";
	}//migrationPrint96

	@RequestMapping(value = "/migrationPrint98", method = RequestMethod.GET)
	public String migrationPrint98(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= migrationPrint98 =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migrationPrint98 - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		//기존 data 삭제
		sqlSession.delete("MigPrint9UtilMapper.print98DeleteAll");

		//입력 대상 data 조회
		List<MigrationPrint9VO> targetList = sqlSession.selectList("MigPrint9UtilMapper.report9Forprint98List");

		//data 입력
		MigrationPrint9VO tmpVO = null;
		String tmpStr = null;
		String [] tmpArr1 = null;
		String [] tmpArr2 = null;
		MigrationPrint9VO inVO = null;
		for(int i = 0; i < targetList.size(); i++){
			tmpVO = targetList.get(i);
			tmpStr = tmpVO.getSplitTargetData();
			tmpArr1 = tmpStr.split("enterpoint");
			for(int k = 0; k < tmpArr1.length; k++){
				tmpArr2 = tmpArr1[k].split("breakpoint");
				inVO = new MigrationPrint9VO();
				inVO.setRpt_print_no(tmpVO.getNo());
				inVO.setAttach_name(tmpArr2[0]);
				inVO.setAttach_copy(tmpArr2[1]);
				inVO.setAttach_etc_memo(tmpArr2[2]);
				sqlSession.selectList("MigPrint9UtilMapper.print98Write", inVO);
			}
		}

		//기존 테이블에서 따라온 공백 값을 가진 data 삭제
		sqlSession.update("MigPrint9UtilMapper.print98UpdateSpaceData1");
		sqlSession.update("MigPrint9UtilMapper.print98UpdateSpaceData2");
		sqlSession.update("MigPrint9UtilMapper.print98UpdateSpaceData3");
		sqlSession.delete("MigPrint9UtilMapper.print98DeleteSpaceData");
		sqlSession.update("MigPrint9UtilMapper.print98UpdateSpaceData4");
		sqlSession.update("MigPrint9UtilMapper.print98UpdateSpaceData5");
		sqlSession.update("MigPrint9UtilMapper.print98UpdateSpaceData6");
		sqlSession.update("MigPrint9UtilMapper.print98UpdateSpaceData7");

		return "sys_adm_migration/migration_print1_ok";
	}//migrationPrint98

}//end of class
