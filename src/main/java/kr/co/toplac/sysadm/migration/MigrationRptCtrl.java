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
public class MigrationRptCtrl {

	@Autowired
	private SqlSession sqlSession;

	private static final Logger logger = LoggerFactory.getLogger(MigrationRptCtrl.class);

	@RequestMapping(value = "/migrationReport", method = RequestMethod.GET)
	public String migrationReport(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= migrationReport =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migrationReport - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		return "sys_adm_migration/mig_report";
	}//migrationReport

	@RequestMapping(value = "/migrationRptCtrl", method = RequestMethod.GET)
	public String migrationRptCtrl(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= migrationRptCtrl =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migrationRptCtrl - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		//기존 data 삭제
		sqlSession.delete("MigRptCtrlUtilMapper.rptCtrlDeleteAll");

		//입력 대상 data 조회
		List<MigrationRptCtrlVO> targetList = sqlSession.selectList("MigRptCtrlUtilMapper.forRptCtrlList");

		//data 입력
		MigrationRptCtrlVO tmpVO = null;
		String tmpStr = null;
		String [] tmpArr1 = null;
		String [] tmpArr2 = null;
		MigrationRptCtrlVO inVO = null;
		for(int i = 0; i < targetList.size(); i++){
			tmpVO = targetList.get(i);
			tmpStr = tmpVO.getSplitTargetData();
			tmpArr1 = tmpStr.split("enterpoint");
			for(int k = 0; k < tmpArr1.length; k++){
				tmpArr2 = tmpArr1[k].split("breakpoint");
				inVO = new MigrationRptCtrlVO();
				inVO.setSuim_rpt_no(tmpVO.getRid());
				inVO.setControl_date(tmpArr2[0]);
				inVO.setControl_subject(tmpArr2[1]);
				inVO.setControl_memo(tmpArr2[2]);
				sqlSession.selectList("MigRptCtrlUtilMapper.rptCtrlWrite", inVO);
			}
		}

		//기존 테이블에서 따라온 공백 값을 가진 data 삭제
		sqlSession.update("MigRptCtrlUtilMapper.rptCtrlUpdateSpaceData1");
		sqlSession.update("MigRptCtrlUtilMapper.rptCtrlUpdateSpaceData2");
		sqlSession.update("MigRptCtrlUtilMapper.rptCtrlUpdateSpaceData3");
		sqlSession.delete("MigRptCtrlUtilMapper.rptCtrlDeleteSpaceData");
		sqlSession.update("MigRptCtrlUtilMapper.rptCtrlUpdateSpaceData4");
		sqlSession.update("MigRptCtrlUtilMapper.rptCtrlUpdateSpaceData5");
		sqlSession.update("MigRptCtrlUtilMapper.rptCtrlUpdateSpaceData6");
		sqlSession.update("MigRptCtrlUtilMapper.rptCtrlUpdateSpaceData7");

		return "sys_adm_migration/migration_print1_ok";
	}//migrationRptCtrl

	@RequestMapping(value = "/migrationRptCtrl16", method = RequestMethod.GET)
	public String migrationRptCtrl16(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= migrationRptCtrl16 =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migrationRptCtrl16 - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		//기존 data 삭제
		//sqlSession.delete("MigRptCtrlUtilMapper.rptCtrl16DeleteAll");

		//입력 대상 data 조회
		List<MigrationRptCtrlVO> targetList = sqlSession.selectList("MigRptCtrlUtilMapper.forRptCtrl16List");

		//data 입력
		MigrationRptCtrlVO tmpVO = null;
		String tmpStr = null;
		String [] tmpArr1 = null;
		String [] tmpArr2 = null;
		MigrationRptCtrlVO inVO = null;
		for(int i = 0; i < targetList.size(); i++){
			tmpVO = targetList.get(i);
			tmpStr = tmpVO.getSplitTargetData();
			tmpArr1 = tmpStr.split("enterpoint");
			for(int k = 0; k < tmpArr1.length; k++){
				tmpArr2 = tmpArr1[k].split("breakpoint");
				inVO = new MigrationRptCtrlVO();
				inVO.setSuim_rpt_no(tmpVO.getRid());
				inVO.setControl_date(tmpArr2[0]);
				inVO.setControl_memo(tmpArr2[1]);
				inVO.setControl_who(tmpArr2[2]);
				try{
					inVO.setControl_relation(tmpArr2[3]);
				}catch(ArrayIndexOutOfBoundsException e){
					inVO.setControl_relation("-");
				}
				try{
					inVO.setControl_contact(tmpArr2[4]);
				}catch(ArrayIndexOutOfBoundsException e){
					inVO.setControl_contact("-");
				}
				sqlSession.selectList("MigRptCtrlUtilMapper.rptCtrl16Write", inVO);
			}
		}

		//기존 테이블에서 따라온 공백 값을 가진 data 삭제
		sqlSession.update("MigRptCtrlUtilMapper.rptCtrl16UpdateSpaceData1");
		sqlSession.update("MigRptCtrlUtilMapper.rptCtrl16UpdateSpaceData2");
		sqlSession.update("MigRptCtrlUtilMapper.rptCtrl16UpdateSpaceData3");
		sqlSession.update("MigRptCtrlUtilMapper.rptCtrl16UpdateSpaceData4");
		sqlSession.update("MigRptCtrlUtilMapper.rptCtrl16UpdateSpaceData5");
		sqlSession.delete("MigRptCtrlUtilMapper.rptCtrl16DeleteSpaceData");
		sqlSession.update("MigRptCtrlUtilMapper.rptCtrl16UpdateSpaceData6");
		sqlSession.update("MigRptCtrlUtilMapper.rptCtrl16UpdateSpaceData7");
		sqlSession.update("MigRptCtrlUtilMapper.rptCtrl16UpdateSpaceData81");
		sqlSession.update("MigRptCtrlUtilMapper.rptCtrl16UpdateSpaceData82");
		sqlSession.update("MigRptCtrlUtilMapper.rptCtrl16UpdateSpaceData91");
		sqlSession.update("MigRptCtrlUtilMapper.rptCtrl16UpdateSpaceData92");
		sqlSession.update("MigRptCtrlUtilMapper.rptCtrl16UpdateSpaceData101");
		sqlSession.update("MigRptCtrlUtilMapper.rptCtrl16UpdateSpaceData102");

		return "sys_adm_migration/migration_print1_ok";
	}//migrationRptCtrl16

}//end of class
