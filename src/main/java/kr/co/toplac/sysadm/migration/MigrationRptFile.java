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
public class MigrationRptFile {

	@Autowired
	private SqlSession sqlSession;

	private static final Logger logger = LoggerFactory.getLogger(MigrationRptFile.class);

	@RequestMapping(value = "/migrationRptFile", method = RequestMethod.GET)
	public String migrationRptFile(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= migrationRptFile =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migrationRptFile - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		//기존 data 삭제
		sqlSession.delete("MigRptFileUtilMapper.rptFileDeleteAll");

		//입력 대상 data 조회
		List<MigrationRptFileVO> targetList = sqlSession.selectList("MigRptFileUtilMapper.forRptCtrlList");

		//data 입력
		MigrationRptFileVO tmpVO = null;
		String tmpStr = null;
		String [] tmpArr1 = null;
		MigrationRptFileVO inVO = null;
		for(int i = 0; i < targetList.size(); i++){
			tmpVO = targetList.get(i);

			inVO = new MigrationRptFileVO();
			inVO.setSuim_rpt_no(tmpVO.getRid());
			inVO.setUp_dir(tmpVO.getUp_dir());
			inVO.setUp_date(tmpVO.getUp_date());

			tmpStr = tmpVO.getSplitTargetData();
			tmpArr1 = tmpStr.split("-breakpoint-");
			for(int k = 0; k < tmpArr1.length; k++){
				inVO.setUp_file(tmpArr1[k]);
				sqlSession.selectList("MigRptFileUtilMapper.rptFileWrite", inVO);
			}
		}

		return "sys_adm_migration/migration_print1_ok";
	}//migrationRptFile

}//end of class
