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
public class MigrationPrint1 {

	@Autowired
	private SqlSession sqlSession;

	private static final Logger logger = LoggerFactory.getLogger(MigrationPrint1.class);

	@RequestMapping(value = "/migrationPrint1Pan", method = RequestMethod.GET)
	public String migrationPrint1Pan(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= migrationPrint1Pan =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migrationPrint1Pan - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		return "sys_adm_migration/migration_print1_pan";
	}//migrationPrint1Pan

	@RequestMapping(value = "/migrationPrint12", method = RequestMethod.GET)
	public String migrationPrint12(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= migrationPrint12 =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migrationPrint12 - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		//기존 data 삭제
		sqlSession.delete("MigPrint1UtilMapper.print12DeleteAll");

		//입력 대상 data 조회
		List<MigrationPrint1VO> targetList = sqlSession.selectList("MigPrint1UtilMapper.report1Forprint12List");

		//data 입력
		MigrationPrint1VO tmpVO = null;
		String tmpStr = null;
		String [] tmpArr1 = null;
		String [] tmpArr2 = null;
		MigrationPrint1VO inVO = null;
		for(int i = 0; i < targetList.size(); i++){
			tmpVO = targetList.get(i);
			tmpStr = tmpVO.getSplitTargetData();
			tmpArr1 = tmpStr.split("enterpoint");
			for(int k = 0; k < tmpArr1.length; k++){
				tmpArr2 = tmpArr1[k].split("breakpoint");
				inVO = new MigrationPrint1VO();
				inVO.setRpt_print_no(tmpVO.getNo());
				inVO.setOther_insu_com(tmpArr2[0]);
				inVO.setOther_insu_dtl(tmpArr2[1]);
				sqlSession.selectList("MigPrint1UtilMapper.print12Write", inVO);
			}
		}

		//기존 테이블에서 따라온 공백 값을 가진 data 삭제
		sqlSession.update("MigPrint1UtilMapper.print12UpdateSpaceData1");
		sqlSession.update("MigPrint1UtilMapper.print12UpdateSpaceData2");
		sqlSession.delete("MigPrint1UtilMapper.print12DeleteSpaceData");
		sqlSession.update("MigPrint1UtilMapper.print12UpdateSpaceData3");
		sqlSession.update("MigPrint1UtilMapper.print12UpdateSpaceData4");

		return "sys_adm_migration/migration_print1_ok";
	}//migrationPrint12

	@RequestMapping(value = "/migrationPrint15", method = RequestMethod.GET)
	public String migrationPrint15(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= migrationPrint15 =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migrationPrint15 - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		//기존 data 삭제
		sqlSession.delete("MigPrint1UtilMapper.print15DeleteAll");

		//입력 대상 data 조회
		List<MigrationPrint1VO> targetList = sqlSession.selectList("MigPrint1UtilMapper.report1Forprint15List");

		//data 입력
		MigrationPrint1VO tmpVO = null;
		String tmpStr = null;
		String [] tmpArr1 = null;
		String [] tmpArr2 = null;
		MigrationPrint1VO inVO = null;
		for(int i = 0; i < targetList.size(); i++){
			tmpVO = targetList.get(i);
			tmpStr = tmpVO.getSplitTargetData();
			tmpArr1 = tmpStr.split("enterpoint");
			for(int k = 0; k < tmpArr1.length; k++){
				tmpArr2 = tmpArr1[k].split("breakpoint");
				inVO = new MigrationPrint1VO();
				inVO.setRpt_print_no(tmpVO.getNo());
				inVO.setProcess_date_s(tmpArr2[0]);
				inVO.setProcess_dtl(tmpArr2[1]);
				inVO.setProcess_etc_memo(tmpArr2[2]);
				inVO.setProcess_date_e(tmpArr2[3]);
				sqlSession.selectList("MigPrint1UtilMapper.print15Write", inVO);
			}
		}

		//기존 테이블에서 따라온 공백 값을 가진 data 삭제
		sqlSession.update("MigPrint1UtilMapper.print15UpdateSpaceData1");
		sqlSession.update("MigPrint1UtilMapper.print15UpdateSpaceData2");
		sqlSession.update("MigPrint1UtilMapper.print15UpdateSpaceData3");
		sqlSession.update("MigPrint1UtilMapper.print15UpdateSpaceData4");
		sqlSession.delete("MigPrint1UtilMapper.print15DeleteSpaceData");
		sqlSession.update("MigPrint1UtilMapper.print15UpdateSpaceData11");
		sqlSession.update("MigPrint1UtilMapper.print15UpdateSpaceData12");
		sqlSession.update("MigPrint1UtilMapper.print15UpdateSpaceData13");
		sqlSession.update("MigPrint1UtilMapper.print15UpdateSpaceData14");
		sqlSession.update("MigPrint1UtilMapper.print15UpdateSpaceData15");
		sqlSession.update("MigPrint1UtilMapper.print15UpdateSpaceData16");
		sqlSession.update("MigPrint1UtilMapper.print15UpdateSpaceData17");
		sqlSession.update("MigPrint1UtilMapper.print15UpdateSpaceData18");

		return "sys_adm_migration/migration_print1_ok";
	}//migrationPrint15

	@RequestMapping(value = "/migrationPrint161", method = RequestMethod.GET)
	public String migrationPrint161(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= migrationPrint161 =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migrationPrint161 - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		//기존 data 삭제
		sqlSession.delete("MigPrint1UtilMapper.print161DeleteAll");

		//입력 대상 data 조회
		List<MigrationPrint1VO> targetList = sqlSession.selectList("MigPrint1UtilMapper.report1Forprint161List");

		//data 입력
		MigrationPrint1VO tmpVO = null;
		String tmpStr = null;
		String [] tmpArr1 = null;
		String [] tmpArr2 = null;
		MigrationPrint1VO inVO = null;
		for(int i = 0; i < targetList.size(); i++){
			tmpVO = targetList.get(i);
			tmpStr = tmpVO.getSplitTargetData();
			tmpArr1 = tmpStr.split("enterpoint");
			for(int k = 0; k < tmpArr1.length; k++){
				tmpArr2 = tmpArr1[k].split("breakpoint");
				inVO = new MigrationPrint1VO();
				inVO.setRpt_print_no(tmpVO.getNo());
				inVO.setInvestigate_outline(tmpArr2[0]);
				inVO.setInvestigate_dtl(tmpArr2[1]);
				sqlSession.selectList("MigPrint1UtilMapper.print161Write", inVO);
			}
		}

		//기존 테이블에서 따라온 공백 값을 가진 data 삭제
		sqlSession.update("MigPrint1UtilMapper.print161UpdateSpaceData1");
		sqlSession.update("MigPrint1UtilMapper.print161UpdateSpaceData2");
		sqlSession.delete("MigPrint1UtilMapper.print161DeleteSpaceData");
		sqlSession.update("MigPrint1UtilMapper.print161UpdateSpaceData3");
		sqlSession.update("MigPrint1UtilMapper.print161UpdateSpaceData4");

		return "sys_adm_migration/migration_print1_ok";
	}//migrationPrint161

	@RequestMapping(value = "/migrationPrint162", method = RequestMethod.GET)
	public String migrationPrint162(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= migrationPrint162 =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migrationPrint162 - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		//기존 data 삭제
		sqlSession.delete("MigPrint1UtilMapper.print162DeleteAll");

		//입력 대상 data 조회
		List<MigrationPrint1VO> targetList = sqlSession.selectList("MigPrint1UtilMapper.report1Forprint162List");

		//data 입력
		MigrationPrint1VO tmpVO = null;
		String tmpStr = null;
		String [] tmpArr1 = null;
		String [] tmpArr2 = null;
		MigrationPrint1VO inVO = null;
		for(int i = 0; i < targetList.size(); i++){
			tmpVO = targetList.get(i);
			tmpStr = tmpVO.getSplitTargetData();
			tmpArr1 = tmpStr.split("enterpoint");
			for(int k = 0; k < tmpArr1.length; k++){
				tmpArr2 = tmpArr1[k].split("breakpoint");
				inVO = new MigrationPrint1VO();
				inVO.setRpt_print_no(tmpVO.getNo());
				inVO.setConfirm_outline(tmpArr2[0]);
				inVO.setConfirm_dtl(tmpArr2[1]);
				sqlSession.selectList("MigPrint1UtilMapper.print162Write", inVO);
			}
		}

		//기존 테이블에서 따라온 공백 값을 가진 data 삭제
		sqlSession.update("MigPrint1UtilMapper.print162UpdateSpaceData1");
		sqlSession.update("MigPrint1UtilMapper.print162UpdateSpaceData2");
		sqlSession.delete("MigPrint1UtilMapper.print162DeleteSpaceData");
		sqlSession.update("MigPrint1UtilMapper.print162UpdateSpaceData3");
		sqlSession.update("MigPrint1UtilMapper.print162UpdateSpaceData4");

		return "sys_adm_migration/migration_print1_ok";
	}//migrationPrint162

	@RequestMapping(value = "/migrationPrint18", method = RequestMethod.GET)
	public String migrationPrint18(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= migrationPrint18 =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migrationPrint18 - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		//기존 data 삭제
		sqlSession.delete("MigPrint1UtilMapper.print18DeleteAll");

		//입력 대상 data 조회
		List<MigrationPrint1VO> targetList = sqlSession.selectList("MigPrint1UtilMapper.report1Forprint18List");

		//data 입력
		MigrationPrint1VO tmpVO = null;
		String tmpStr = null;
		String [] tmpArr1 = null;
		String [] tmpArr2 = null;
		MigrationPrint1VO inVO = null;
		for(int i = 0; i < targetList.size(); i++){
			tmpVO = targetList.get(i);
			tmpStr = tmpVO.getSplitTargetData();
			tmpArr1 = tmpStr.split("enterpoint");
			for(int k = 0; k < tmpArr1.length; k++){
				tmpArr2 = tmpArr1[k].split("breakpoint");
				inVO = new MigrationPrint1VO();
				inVO.setRpt_print_no(tmpVO.getNo());
				inVO.setAttach_name(tmpArr2[0]);
				inVO.setAttach_copy(tmpArr2[1]);
				inVO.setAttach_etc_memo(tmpArr2[2]);
				sqlSession.selectList("MigPrint1UtilMapper.print18Write", inVO);
			}
		}

		//기존 테이블에서 따라온 공백 값을 가진 data 삭제
		sqlSession.update("MigPrint1UtilMapper.print18UpdateSpaceData1");
		sqlSession.update("MigPrint1UtilMapper.print18UpdateSpaceData2");
		sqlSession.update("MigPrint1UtilMapper.print18UpdateSpaceData3");
		sqlSession.delete("MigPrint1UtilMapper.print18DeleteSpaceData");
		sqlSession.update("MigPrint1UtilMapper.print18UpdateSpaceData4");
		sqlSession.update("MigPrint1UtilMapper.print18UpdateSpaceData5");
		sqlSession.update("MigPrint1UtilMapper.print18UpdateSpaceData6");
		sqlSession.update("MigPrint1UtilMapper.print18UpdateSpaceData7");

		return "sys_adm_migration/migration_print1_ok";
	}//migrationPrint18

}//end of class
