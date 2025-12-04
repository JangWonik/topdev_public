package kr.co.toplac.lslog;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class Ls_ReportController {
	
	//private static final Logger logger = LoggerFactory.getLogger(Ls_ReportController.class);

	@Autowired
		private SqlSession sqlSession;

		/*
		*********************************************************
		* Method ID		: // 영문 메소드 이름
		* Method Name	: // 국문 메소드 이름
		* Description	: // 간략한 설명
		* Author		: // 개발자 이름
		* Date			: // 최초 작성일
		* Update		: // 수정일 + 수정 요청자(있는 경우) + 수정 내용
		*********************************************************
		*/
		@RequestMapping(value = "/ls_report_pop", method = RequestMethod.GET)
		public String ls_report_pop(Model model, Ls_ReportVO vo, String rid, String report_id) {
			String viewName = ls_report_popPost(model, vo, rid, report_id);
			return viewName;
			
			
		}
		

		@RequestMapping(value = "/ls_report_pop", method = RequestMethod.POST)
		public String ls_report_popPost(Model model, Ls_ReportVO vo, String rid, String report_id) {
	
		
			//String rid ="";
			//String report_id="";
			
			
			String mid_date="";
			String key_moral="";
			String report_type="";
			String report_type2="";
			String report_ch="";
			String report_return="";
			String minwon="";
			String ig_id="";
			String end_date="";
			String ok_date="";
			String ok_user="";
			String name="";
			String no="";
			String user_id="";
			String team_name="";
			String handphone="";
			String ig_title="";
			String hp="";
			String tell="";
			String ig_team="";
			String report_type3="";
			String ig_client="";
			String ig_client_hp="";
			String ig_client_ju="";
			String ig_insured="";
			String ig_insured_hp="";
			String ig_insured_ju="";
			String report_4="";
			String report_4_hp="";
			String suim_type="";
			String report_5="";
			String trouble_date="";
			String reg_date="";
			String price_top="";
			
			
			//HashMap<String, String> map = new HashMap<String, String>();
			
			
			
			
			List<Ls_ReportVO> reportpList = new ArrayList<Ls_ReportVO>();
			reportpList = sqlSession.selectList("LsReportMapper.reportp", vo);
			
			
			
			model.addAttribute("vo", vo);
			model.addAttribute("rid", rid);
			model.addAttribute("report_id", report_id);
			model.addAttribute("reportpList", reportpList);
			model.addAttribute("pgid", "ls_report_pop");
			return "ls_log/log_index";
		}
}
