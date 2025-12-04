package kr.co.toplac.sysadm;

import java.io.PrintWriter;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;

@Controller
public class TopSetupEndController {

	private static final Logger logger = LoggerFactory.getLogger(TopSetupEndController.class);

	@Autowired
	SqlSession sqlSession;

	@RequestMapping(value = "setupEnd", method = RequestMethod.GET)
	public String setupEnd(Model model, HttpSession session) {
		
		logger.info("setupEnd");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9")){
			
			logger.info("topSysAdmAprvUser - no permession user_no : "+mbrVo.getUser_no());
			session.invalidate();
			return "top_login/top_login";
		}else{
			TopEndSetupVO topEndSetupVo =  sqlSession.selectOne("SetupEndMapper.getSetupEndInfo");
			model.addAttribute("topEndSetupVo",topEndSetupVo);
			return "sys_adm/top_setup_end";			
		}
		
	}

	@RequestMapping(value = "udtSetupEnd", method = RequestMethod.POST)
	public void udtSetupEnd(PrintWriter out, TopEndSetupVO topEndSetupVo) {
		
		logger.info("udtSetupEnd");
		
		int result = sqlSession.update("SetupEndMapper.udtSetupEnd",topEndSetupVo);
		
		
		out.print(result);
	}

}//end of class
