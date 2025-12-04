package kr.co.toplac.util.sms;

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
public class SimpleSMSController {
	
private static final Logger logger = LoggerFactory.getLogger(SimpleSMSController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/simpleSMSForm", method = RequestMethod.GET)
	public String simpleSMSForm(Model model, HttpSession session, HttpServletRequest request, String hpNo) {

		logger.info("======= simpleSMSForm =======");

		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("simpleSMSForm - no permession : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}

		String fromHpNo = sqlSession.selectOne("SimpleSMSMapper.getLogInUserHpNo", mbrVo);

		model.addAttribute("toHpNo", hpNo.replaceAll("-", ""));
		model.addAttribute("fromHpNo", fromHpNo.replaceAll("-", ""));

		return "util_sms/simple_sms_form";
	}//simpleSMSForm
	
	@RequestMapping(value = "/smsClose", method = RequestMethod.GET)
	public String smsClose(Model model, HttpSession session, HttpServletRequest request, String hpNo) {
		logger.info("======= smsClose =======");
		return "util_sms/sms_close";
	}//simpleSMSForm
	
	

}
