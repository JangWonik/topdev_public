package kr.co.toplac.util.nice;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
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
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import kr.co.toplac.toplogin.TopLogInController;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.enc.EncryptUtil;


@Controller
public class NiceCertController {
	private static final Logger logger = LoggerFactory.getLogger(NiceCertController.class);
	@RequestMapping(value = "NiceCert", method = RequestMethod.POST)
	public String NiceCert(Model model, HttpSession session, String resid_no) {
		logger.info("TOP NICE CERT Process");
		return "util_nice/TopNiceCert"; 
	}
	
	
	@RequestMapping(value = "NiceCertPopup", method = RequestMethod.POST)
	public String NiceCertPopup(Model model, HttpSession session, String resid_no) {
		logger.info("NiceCertPopup");
		return "util_nice/NiceCertPopup"; 
	}
	
	@RequestMapping(value = "NewNiceCert", method = RequestMethod.POST)
	public String NewNiceCert(Model model, HttpSession session, String resid_no) {
		logger.info("TOP New NICE CERT Process");
		return "util_nice/checkplus_main"; 
	}
	
	@RequestMapping(value = "NewNiceCertPopup")
	public String NewNiceCertPopup(Model model, HttpSession session, String resid_no) {
		logger.info("NewNiceCertPopup");
		return "util_nice/checkplus_success"; 
	}
	
	@RequestMapping(value = "NewNiceCertPopupFail", method = RequestMethod.POST)
	public String NewNiceCertPopupFail(Model model, HttpSession session, String resid_no) {
		logger.info("NewNiceCertPopupFail");
		return "util_nice/checkplus_fail"; 
	}
}//end of class


