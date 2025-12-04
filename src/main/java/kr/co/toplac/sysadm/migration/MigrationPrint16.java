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
public class MigrationPrint16 {

	@Autowired
	private SqlSession sqlSession;

	private static final Logger logger = LoggerFactory.getLogger(MigrationPrint16.class);

	@RequestMapping(value = "/migrationPrint163", method = RequestMethod.GET)
	public String migrationPrint163(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= migrationPrint163 =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migrationPrint163 - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		//기존 data 삭제
		sqlSession.delete("MigPrint16UtilMapper.print163DeleteAll");

		//입력 대상 data 조회
		List<MigrationPrint16VO> targetList = sqlSession.selectList("MigPrint16UtilMapper.report16Forprint163List");

		//data 입력
		MigrationPrint16VO tmpVO = null;
		String tmpStr = null;
		String [] tmpArr1 = null;
		String [] tmpArr2 = null;
		MigrationPrint16VO inVO = null;
		for(int i = 0; i < targetList.size(); i++){
			tmpVO = targetList.get(i);
			tmpStr = tmpVO.getSplitTargetData();
			tmpArr1 = tmpStr.split("enterpoint");
			for(int k = 0; k < tmpArr1.length; k++){
				tmpArr2 = tmpArr1[k].split("breakpoint");
				inVO = new MigrationPrint16VO();
				inVO.setRpt_print_no(tmpVO.getNo());
				inVO.setContract_ba(tmpVO.getTmpGubun());
				inVO.setConfirm_date(tmpArr2[0]);
				inVO.setConfirm_dtl(tmpArr2[1]);
				inVO.setRelative_organ(tmpArr2[2]);
				sqlSession.selectList("MigPrint16UtilMapper.print163Write", inVO);
			}
		}

		//기존 테이블에서 따라온 공백 값을 가진 data 삭제
		sqlSession.update("MigPrint16UtilMapper.print163UpdateSpaceData1");
		sqlSession.update("MigPrint16UtilMapper.print163UpdateSpaceData2");
		sqlSession.update("MigPrint16UtilMapper.print163UpdateSpaceData3");
		sqlSession.delete("MigPrint16UtilMapper.print163DeleteSpaceData");
		sqlSession.update("MigPrint16UtilMapper.print163UpdateSpaceData4");
		sqlSession.update("MigPrint16UtilMapper.print163UpdateSpaceData5");
		sqlSession.update("MigPrint16UtilMapper.print163UpdateSpaceData6");
		sqlSession.update("MigPrint16UtilMapper.print163UpdateSpaceData7");

		return "sys_adm_migration/migration_print1_ok";
	}//migrationPrint163

	@RequestMapping(value = "/migrationPrint164", method = RequestMethod.GET)
	public String migrationPrint164(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= migrationPrint164 =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migrationPrint164 - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		//기존 data 삭제
		sqlSession.delete("MigPrint16UtilMapper.print164DeleteAll");

		//입력 대상 data 조회
		List<MigrationPrint16VO> targetList = sqlSession.selectList("MigPrint16UtilMapper.report16Forprint164List");

		//data 입력
		MigrationPrint16VO tmpVO = null;
		String tmpStr = null;
		String [] tmpArr1 = null;
		String [] tmpArr2 = null;
		MigrationPrint16VO inVO = null;
		for(int i = 0; i < targetList.size(); i++){
			tmpVO = targetList.get(i);
			tmpStr = tmpVO.getSplitTargetData();
			tmpArr1 = tmpStr.split("enterpoint");
			for(int k = 0; k < tmpArr1.length; k++){
				tmpArr2 = tmpArr1[k].split("breakpoint");
				inVO = new MigrationPrint16VO();
				inVO.setRpt_print_no(tmpVO.getNo());
				inVO.setOther_insu_com(tmpArr2[0]);
				inVO.setOther_insu_mortgage(tmpArr2[1]);
				inVO.setOther_insu_period(tmpArr2[2]);
				inVO.setOther_insu_etc_memo(tmpArr2[3]);
				sqlSession.selectList("MigPrint16UtilMapper.print164Write", inVO);
			}
		}

		//기존 테이블에서 따라온 공백 값을 가진 data 삭제
		sqlSession.update("MigPrint16UtilMapper.print164UpdateSpaceData1");
		sqlSession.update("MigPrint16UtilMapper.print164UpdateSpaceData2");
		sqlSession.update("MigPrint16UtilMapper.print164UpdateSpaceData3");
		sqlSession.update("MigPrint16UtilMapper.print164UpdateSpaceData4");
		sqlSession.delete("MigPrint16UtilMapper.print164DeleteSpaceData");
		sqlSession.update("MigPrint16UtilMapper.print164UpdateSpaceData11");
		sqlSession.update("MigPrint16UtilMapper.print164UpdateSpaceData132");
		sqlSession.update("MigPrint16UtilMapper.print164UpdateSpaceData13");
		sqlSession.update("MigPrint16UtilMapper.print164UpdateSpaceData15");
		sqlSession.update("MigPrint16UtilMapper.print164UpdateSpaceData16");
		sqlSession.update("MigPrint16UtilMapper.print164UpdateSpaceData17");
		sqlSession.update("MigPrint16UtilMapper.print164UpdateSpaceData18");

		return "sys_adm_migration/migration_print1_ok";
	}//migrationPrint164

}//end of class
