 package kr.co.toplac.lslog;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class LogIndexController {
	
	private static final Logger logger = LoggerFactory.getLogger(LogIndexController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/ls_log", method = RequestMethod.GET)
	public String home(Model model) {

		return "ls_log/log_index";
	}

}
