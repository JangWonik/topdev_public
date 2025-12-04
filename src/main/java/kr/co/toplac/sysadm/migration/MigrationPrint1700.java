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
public class MigrationPrint1700 {

	@Autowired
	private SqlSession sqlSession;

	private static final Logger logger = LoggerFactory.getLogger(MigrationPrint1700.class);

	@RequestMapping(value = "/migrationPrint17007", method = RequestMethod.GET)
	public String migrationPrint17007(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= migrationPrint17007 =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migrationPrint17007 - no permession user_no : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		//기존 data 삭제
		sqlSession.delete("MigPrint1700UtilMapper.print17007DeleteAll");

		//입력 대상 data 조회
		List<MigrationPrint1700VO> targetList = sqlSession.selectList("MigPrint1700UtilMapper.report1Forprint17007List");

		//data 입력
		MigrationPrint1700VO tmpVO = null;
		String tmpStr = null;
		String [] tmpArr1 = null;
		String [] tmpArr2 = null;
		MigrationPrint1700VO inVO = null;
		for(int i = 0; i < targetList.size(); i++){
			tmpVO = targetList.get(i);
			tmpStr = tmpVO.getSplitTargetData();
			tmpArr1 = tmpStr.split("enterpoint");
			for(int k = 0; k < tmpArr1.length; k++){
				tmpArr2 = tmpArr1[k].split("breakpoint");
				inVO = new MigrationPrint1700VO();
				inVO.setSuim_rpt_no(tmpVO.getRid());
				inVO.setAttach_name(tmpArr2[0]);
				inVO.setAttach_copy(tmpArr2[1]);
				inVO.setAttach_etc_memo(tmpArr2[2]);
				sqlSession.selectList("MigPrint1700UtilMapper.print17007Write", inVO);
			}
		}

		//기존 테이블에서 따라온 공백 값을 가진 data 삭제
		sqlSession.update("MigPrint1700UtilMapper.print17007UpdateSpaceData1");
		sqlSession.update("MigPrint1700UtilMapper.print17007UpdateSpaceData2");
		sqlSession.update("MigPrint1700UtilMapper.print17007UpdateSpaceData3");
		sqlSession.delete("MigPrint1700UtilMapper.print17007DeleteSpaceData");
		sqlSession.update("MigPrint1700UtilMapper.print17007UpdateSpaceData4");
		sqlSession.update("MigPrint1700UtilMapper.print17007UpdateSpaceData5");
		sqlSession.update("MigPrint1700UtilMapper.print17007UpdateSpaceData6");
		sqlSession.update("MigPrint1700UtilMapper.print17007UpdateSpaceData7");

		return "sys_adm_migration/migration_print1_ok";
	}//migrationPrint17007

}//end of class
