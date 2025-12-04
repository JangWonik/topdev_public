package kr.co.toplac.brd.faq;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class faqController {
	private static final Logger logger = LoggerFactory.getLogger(faqController.class);
	
	@RequestMapping(value = "/faq_list", method = RequestMethod.GET)
	public String faqList() {
		return "brd_faq/faq_list";
	}
	
	@RequestMapping(value = "/faq_view", method = RequestMethod.GET)
	public String faqView() {
		return "brd_faq/faq_view";
	}
	
	@RequestMapping(value = "/faq_write", method = RequestMethod.GET)
	public String faqWrite() {
		return "brd_faq/faq_write";
	}
	
	@RequestMapping(value = "/faq_edit", method = RequestMethod.GET)
	public String faqEdit() {
		return "brd_faq/faq_edit";
	}
	
	@RequestMapping(value = "/faq_insert", method = RequestMethod.POST)
	public void faqInsert() {		
	}
	
	@RequestMapping(value = "/faq_update", method = RequestMethod.POST)
	public void faqUpdate() {
	}
	
	@RequestMapping(value = "/faq_delete", method = RequestMethod.POST)
	public void faqDelete() {
		
	}

}

