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
public class MigrationLsAdmin {

	@Autowired
	private SqlSession sqlSession;

	private static final Logger logger = LoggerFactory.getLogger(MigrationLsAdmin.class);

	@RequestMapping(value = "/migrationLsAdmin34", method = RequestMethod.GET)
	public String migrationLsAdmin34(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= migrationLsAdmin34 =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migrationLsAdmin34 - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		//기존 data 삭제
		sqlSession.delete("MigLsAdminUtilMapper.lsAdmin34DeleteAll");

		//입력 대상 data 조회
		List<MigrationLsAdminVO> targetList = sqlSession.selectList("MigLsAdminUtilMapper.lsAdmin34List");

		//data 입력
		MigrationLsAdminVO tmpVO = null;
		String tmpStr = null;
		String [] tmpArr1 = null;
		MigrationLsAdminVO inVO = null;
		for(int i = 0; i < targetList.size(); i++){
			tmpVO = targetList.get(i);

			inVO = new MigrationLsAdminVO();
			inVO.setTask_code("911");
			inVO.setAprv_user_no(tmpVO.getAprv_user_no());
			inVO.setReg_reason("1st registration");
			inVO.setReg_ip("0.0.0.0");
			inVO.setReg_user_no("834");

			tmpStr = tmpVO.getSplitTargetData();
			tmpArr1 = tmpStr.split(" ");
			for(int k = 0; k < tmpArr1.length; k++){
				if(tmpArr1[k].trim().length() > 0){
					inVO.setTeam_id(tmpArr1[k]);
					sqlSession.selectList("MigLsAdminUtilMapper.lsAdmin34Write", inVO);
				}
			}
		}

		return "sys_adm_migration/migration_print1_ok";
	}//migrationLsAdmin34

	@RequestMapping(value = "/migrationLsAdmin35", method = RequestMethod.GET)
	public String migrationLsAdmin35(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= migrationLsAdmin35 =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migrationLsAdmin35 - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		//기존 data 삭제
		sqlSession.delete("MigLsAdminUtilMapper.lsAdmin35DeleteAll");

		//입력 대상 data 조회
		List<MigrationLsAdminVO> targetList = sqlSession.selectList("MigLsAdminUtilMapper.lsAdmin35List");

		//data 입력
		MigrationLsAdminVO tmpVO = null;
		String tmpStr = null;
		String [] tmpArr1 = null;
		MigrationLsAdminVO inVO = null;
		for(int i = 0; i < targetList.size(); i++){
			tmpVO = targetList.get(i);

			inVO = new MigrationLsAdminVO();
			inVO.setTask_code("912");
			inVO.setAprv_user_no(tmpVO.getAprv_user_no());
			inVO.setReg_reason("1st registration");
			inVO.setReg_ip("0.0.0.0");
			inVO.setReg_user_no("834");

			tmpStr = tmpVO.getSplitTargetData();
			tmpArr1 = tmpStr.split(" ");
			for(int k = 0; k < tmpArr1.length; k++){
				if(tmpArr1[k].trim().length() > 0){
					inVO.setTeam_id(tmpArr1[k]);
					sqlSession.selectList("MigLsAdminUtilMapper.lsAdmin35Write", inVO);
				}
			}
		}

		return "sys_adm_migration/migration_print1_ok";
	}//migrationLsAdmin35

	@RequestMapping(value = "/migrationLsAdmin38", method = RequestMethod.GET)
	public String migrationLsAdmin38(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= migrationLsAdmin38 =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migrationLsAdmin38 - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		//기존 data 삭제
		sqlSession.delete("MigLsAdminUtilMapper.lsAdmin38DeleteAll");

		//입력 대상 data 조회
		List<MigrationLsAdminVO> targetList = sqlSession.selectList("MigLsAdminUtilMapper.lsAdmin38List");

		//data 입력
		MigrationLsAdminVO tmpVO = null;
		String tmpStr = null;
		String [] tmpArr1 = null;
		MigrationLsAdminVO inVO = null;
		for(int i = 0; i < targetList.size(); i++){
			tmpVO = targetList.get(i);

			inVO = new MigrationLsAdminVO();
			inVO.setTask_code("913");
			inVO.setAprv_user_no(tmpVO.getAprv_user_no());
			inVO.setReg_reason("1st registration");
			inVO.setReg_ip("0.0.0.0");
			inVO.setReg_user_no("834");

			tmpStr = tmpVO.getSplitTargetData();
			tmpArr1 = tmpStr.split(" ");
			for(int k = 0; k < tmpArr1.length; k++){
				if(tmpArr1[k].trim().length() > 0){
					inVO.setTeam_id(tmpArr1[k]);
					sqlSession.selectList("MigLsAdminUtilMapper.lsAdmin38Write", inVO);
				}
			}
		}

		return "sys_adm_migration/migration_print1_ok";
	}//migrationLsAdmin38

}//end of class
