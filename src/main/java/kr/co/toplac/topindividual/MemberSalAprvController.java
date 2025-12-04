/*
*********************************************************
* Program ID	: PrimbizSuimListController
* Program Name	: PrimbizSuimListController
* Description	: 농작물 수임대장 리스트
* Author		: 
* Date			: 2016.06.09.
*********************************************************
*/
package kr.co.toplac.topindividual;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.topteam.TopMbrBscVO;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MemberSalAprvController {

	private static final Logger logger = LoggerFactory.getLogger(MemberSalAprvController.class);

	@Autowired
	private SqlSession sqlSession;
	
	
	@RequestMapping(value = "memberSalIndex", method = RequestMethod.GET)
	public String memberSalIndex(HttpSession session, String user_no, HttpServletResponse response) {
		logger.info("memberSalIndex");
		
		return "top_individual/member_sal_index";
	}
	
	@RequestMapping(value = "memberSalDtlPop", method = RequestMethod.GET)
	public String memberSalDtlPop(HttpSession session, HttpServletResponse response, Model model) {
		logger.info("memberSalDtlPop");
        
        /*
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("user_no", mbrVo.getUser_no());

        Map<String, Object> salaryInfo = sqlSession.selectOne("MemberSalAprvMapper.selectSalaryExist", paramMap);

        model.addAttribute("salaryInfo", salaryInfo);
		*/
		
        String user_no = (String) session.getAttribute("user_no_Session");
		BoardMemSalVO memberDtl = sqlSession.selectOne("MemberSalAprvMapper.getMemberDtl",user_no);
		List<BoardMemSalVO> bef3YearSal = sqlSession.selectList("MemberSalAprvMapper.getBef3YearSal",user_no);
		model.addAttribute("memberDtl",memberDtl);
		model.addAttribute("bef3YearSal",bef3YearSal);
		
		
		return "top_individual/member_sal_dtl_pop";
		//return "top_individual/member_request_salary";
	}
    
    @RequestMapping(value = "member_request_salary", method = RequestMethod.GET)
    public String memberRequestSalary(HttpSession session, HttpServletResponse response, Model model) {
        logger.info("member_request_salary");
        
        
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
        
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("user_no", mbrVo.getUser_no());
        
        Map<String, Object> salaryInfo = sqlSession.selectOne("MemberSalAprvMapper.selectSalaryExist", paramMap);
        
        if (salaryInfo == null){
        	return "redirect:/";
		}
        
        model.addAttribute("salaryInfo", salaryInfo);
		
        return "top_individual/member_request_salary";
    }
    
    @RequestMapping(value = "member_request_intern", method = RequestMethod.GET)
    public String memberRequestIntern(HttpSession session, HttpServletResponse response, Model model) {
        logger.info("member_request_intern");
        
        
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
        
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("user_no", mbrVo.getUser_no());
        
        Map<String, Object> salaryInfo = sqlSession.selectOne("MemberSalAprvMapper.selectSalaryExist", paramMap);
        
        if (salaryInfo == null){
        	return "redirect:/";
		}
        
        model.addAttribute("salaryInfo", salaryInfo);
		
        return "top_individual/member_request_intern";
    }
	
	
	
	
	@RequestMapping(value = "memberSalAprv", method = RequestMethod.GET)
	public String memberSalAprv(HttpSession session, HttpServletResponse response, Model model, String user_no, String flag) {
		logger.info("memberSalAprv");
		
		//임원이 호출할떄는 정상 작동해야함.
		if ( user_no == null ){
			user_no = (String) session.getAttribute("user_no_Session");
		}else{
			model.addAttribute("BoardFlag","1");
			model.addAttribute("flag",flag);
		}	
		
		BoardMemSalVO salDetail = sqlSession.selectOne("MemberSalAprvMapper.getDetail",user_no);
		String userSign = sqlSession.selectOne("MemberSalAprvMapper.getUserSign",user_no);
		String userSignPath = "https://toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/"+user_no+"/" + sqlSession.selectOne("MemberSalAprvMapper.getUserSign",user_no);
		
		String userAgreeFlag = sqlSession.selectOne("MemberSalAprvMapper.getUserAgree",user_no);
		
		
		/**** 생년월일 세팅 ****/ 
		String birthYear = salDetail.getJumin_no1().substring(0, 2);
		String birthMonth= salDetail.getJumin_no1().substring(2, 4);
		String birthDay = salDetail.getJumin_no1().substring(4);
		String birth = "19"+birthYear+"년 "+birthMonth+"월 "+birthDay+"일";
		/**** 생년월일 세팅 끝****/
		
		/**** 입사일 세팅 ****/ 
		String joinYear = salDetail.getJoin_date().split("-")[0];
		String joinMonth= salDetail.getJoin_date().split("-")[1];
		String joinDay = salDetail.getJoin_date().split("-")[2];
		if ( joinMonth.substring(0, 1).equals("0") ){
			joinMonth = joinMonth.substring(1,2);
		}
		if ( joinDay.substring(0, 1).equals("0") ){
			joinDay = joinDay.substring(1,2);
		}
		salDetail.setJoin_date(joinYear+"년 "+joinMonth+"월 "+joinDay+"일");
		/**** 입사일 세팅 끝****/
		
		/**** 면수습일 세팅 ****/
		String probationYear;
		String probationMonth;
		String probationDay;
		if ( salDetail.getProbation_date() != null ){
			probationYear = salDetail.getProbation_date().split("-")[0];
			probationMonth= salDetail.getProbation_date().split("-")[1];
			probationDay = salDetail.getProbation_date().split("-")[2];
			
			if ( probationMonth.substring(0, 1).equals("0") ){
				probationMonth = probationMonth.substring(1,2);
			}
			if ( probationDay.substring(0, 1).equals("0") ){
				probationDay = probationDay.substring(1,2);
			}
			salDetail.setProbation_date(probationYear+"년 "+probationMonth+"월 "+probationDay+"일");
		}
		/**** 면수습일 세팅 끝****/
		
		
		/** 연봉 값 임시 세팅 **/
		double sal_amt = Double.parseDouble(salDetail.getSal_amt()) * 10000;
		salDetail.setSal_amt(""+sal_amt); //DB값 * 10000 - 만원단위를 원단위로 보정
		
		sal_amt = Double.parseDouble(salDetail.getSal_amt());
		double sal_month = Math.ceil(sal_amt / 13); //월급액
		double sal_hours = sal_month / 257.7; //통상시급
		double sal_weekrest =   Math.round( sal_hours * 34.80 ); //주휴수당
		String tmp = ""+sal_hours;
        
        System.out.println("sal_hours:["+ sal_hours +"]");
        
        tmp = tmp.substring(0,tmp.indexOf(".")+4) ;
        System.out.println("tmp:["+ tmp +"]");
        System.out.println("tmp2:["+ tmp.substring(tmp.length()-1) +"]");
		
		if ( Integer.parseInt(tmp.substring(tmp.length()-1)) > 5 ){
			sal_hours  = Double.parseDouble(tmp.substring( 0, tmp.indexOf(".")+3 )) + 0.01;
		}else{
			sal_hours  = Double.parseDouble(tmp.substring( 0, tmp.indexOf(".")+3 )) - 0.01;
		}
		
		double sal_adv =   Math.round( sal_hours * 32.60 * 1.5 ); //연장근로수당
		double sal_car = 200000;	//차량유지비
		double sal_food = 100000;	//식대
		double sal_basic = (sal_month - sal_weekrest - sal_adv - sal_car - sal_food); //기본급
		
		
		salDetail.setSal_month((int)sal_month);
		salDetail.setSal_hours((int)sal_hours);
		salDetail.setSal_weekrest((int)sal_weekrest);
		salDetail.setSal_adv((int)sal_adv);
		salDetail.setSal_car((int)sal_car);
		salDetail.setSal_food((int)sal_food); 
		salDetail.setSal_basic((int)sal_basic);
		
		Calendar oCalendar = Calendar.getInstance( ); 
		
		int year = oCalendar.get(Calendar.YEAR);
	    int month = (oCalendar.get(Calendar.MONTH) + 1);
	    int day = oCalendar.get(Calendar.DAY_OF_MONTH);

	    model.addAttribute("birth",birth);
		model.addAttribute("year",year);
		model.addAttribute("month",month);
		model.addAttribute("day",day);

		model.addAttribute("userAgreeFlag",userAgreeFlag);
		
		model.addAttribute("salDetail",salDetail);
		
		model.addAttribute("userSign",userSign);
		model.addAttribute("userSignPath",userSignPath);
		
		return "top_individual/member_sal_contract";
	}//BoardMemSalList
	
	
	@RequestMapping(value = "AgreeSalary", method = RequestMethod.POST)
	public void AgreeSalary(HttpSession session, String user_no, String gubun, HttpServletResponse response) {
		logger.info("AgreeSalary");
		
		int result = 0;
		if ( gubun.equals("intern") ){
			result = sqlSession.update("MemberSalAprvMapper.udtAprvIntern",user_no);
		}else{
			result = sqlSession.update("MemberSalAprvMapper.udtAprvSalary",user_no);
		}
		
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		if(result > 0){
			out.print(result);
		}
		out.close();
	}
	
	
	
	@RequestMapping(value = "internContract", method = RequestMethod.GET)
	public String internContract(HttpSession session, HttpServletResponse response, Model model,String user_no,String flag) {
		if (user_no == null){
			user_no = (String)session.getAttribute("user_no_Session");
			model.addAttribute("boardFlag",0);
		}
		
		BoardMemSalVO userDetail = sqlSession.selectOne("MemberSalAprvMapper.getInternDetail",user_no);
		String userSign = "https://toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/"+user_no+"/"+sqlSession.selectOne("MemberSalAprvMapper.getUserSign",user_no);
		
		/**** 입사일 세팅 ****/ 
		String joinYear = userDetail.getJoin_date().split("-")[0];
		String joinMonth= userDetail.getJoin_date().split("-")[1];
		String joinDay = userDetail.getJoin_date().split("-")[2];
		if ( joinMonth.substring(0, 1).equals("0") ){
			joinMonth = joinMonth.substring(1,2);
		}
		if ( joinDay.substring(0, 1).equals("0") ){
			joinDay = joinDay.substring(1,2);
		}
		userDetail.setJoin_date(joinYear+". "+joinMonth+". "+joinDay);
		/**** 입사일 세팅 끝****/
		
		model.addAttribute("userDetail", userDetail);
		model.addAttribute("userSign", userSign);
		model.addAttribute("flag",flag);
		
		return "top_individual/member_intern_sal_contract";
	}
	
//	udtAprvIntern
	
}
