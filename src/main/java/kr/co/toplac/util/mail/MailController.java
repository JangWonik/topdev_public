package kr.co.toplac.util.mail;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.etc.SecurityUtil;

@Controller
public class MailController {

	private static final Logger logger = LoggerFactory.getLogger(MailController.class);	
	
	@RequestMapping(value = "/topMailForm", method = RequestMethod.GET)
	public String topMailForm(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= topMailForm =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("groupSMSForm - no permession : "+request.getRemoteAddr());
			session.invalidate();
			return "top_login/top_login";
		}
		
		//String sUrl ="";
		
		//return sUrl;
		return "/util_mail/simple_mail_form";
	}
	
	@RequestMapping(value = "/topMailSSO", method = RequestMethod.POST)
	public String topMailFormSSO(Model model, HttpSession session, HttpServletRequest request) {
		
		logger.info("======= topMailSSO =======");
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null){
			logger.info("topMailSSO - no permession");
			session.invalidate();
			return "top_login/top_login";
		}
		
		String sEmail = mbrVo.getEmail();
		String sUserid = mbrVo.getUser_id();
		
		String sUserEmailId = "";
		
		if(!"".equals(sEmail)) {
			sUserEmailId = sEmail.substring(0, sEmail.indexOf("@"));
		}else{
			sUserEmailId = sUserid;
			sEmail = sUserEmailId+"@toplac.co.kr";
		}
		
		String sDomain = "toplac.co.kr";
		String sEmail_pwd = mbrVo.getEmail_pwd();
		String decEmail_pwd = SecurityUtil.aesDecrypt(sEmail_pwd, "");
		
		model.addAttribute("userid", sUserEmailId);
		model.addAttribute("email", sEmail);
		model.addAttribute("email_pwd", decEmail_pwd);
		model.addAttribute("domain", sDomain);
				
		return "/util_mail/topmail_sso";
	}
	
}
