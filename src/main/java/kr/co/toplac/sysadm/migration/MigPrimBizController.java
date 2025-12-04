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
public class MigPrimBizController {

	@Autowired
	private SqlSession sqlSession;

	private static final Logger logger = LoggerFactory.getLogger(MigPrimBizController.class);

	@RequestMapping(value = "/migPrimBiz", method = RequestMethod.GET)
	public String migPrimBiz(Model model, HttpSession session) {

		logger.info("======= migPrimBiz =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migPrimBiz - no permession user_no : " + session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		return "sys_adm_migration/mig_prim_biz";
	}//migPrimBiz

	@RequestMapping(value = "/migrationPrimBizRptFile", method = RequestMethod.GET)
	public String migrationPrimBizRptFile(Model model, HttpSession session) {

		logger.info("======= migrationPrimBizRptFile =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migrationPrimBizRptFile - no permession user_no : " + session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		//기존 data 삭제
		sqlSession.delete("MigPrimBizUtilMapper.primBizRptFileDeleteAll");

		//입력 대상 data 조회
		List<MigPrimBizVO> targetList = sqlSession.selectList("MigPrimBizUtilMapper.migForPrimBizRptFileList");

		//data 입력
		MigPrimBizVO tmpVO = null;
		String tmpStr = null;
		String [] tmpArr1 = null;
		MigPrimBizVO inVO = null;
		for(int i = 0; i < targetList.size(); i++){
			tmpVO = targetList.get(i);
			tmpStr = tmpVO.getSplitTargetData();
			tmpArr1 = tmpStr.split("enterpoint");
			for(int k = 0; k < tmpArr1.length; k++){
				inVO = new MigPrimBizVO();
				inVO.setSuim_rpt_no(tmpVO.getRid());
				inVO.setFile_path(tmpVO.getUp_dir());
				inVO.setFile_name(tmpArr1[k]);
				inVO.setReg_date(tmpVO.getUp_date());;
				sqlSession.insert("MigPrimBizUtilMapper.migPrimBizRptFileWrite", inVO);
			}
		}

		return "sys_adm_migration/migration_print1_ok";
	}//migrationPrimBizRptFile

}//end of class
