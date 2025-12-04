package kr.co.toplac.topteam;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.util.enc.EncryptUtil;

@Controller
public class MbrRegInsController {

	private static final Logger logger = LoggerFactory.getLogger(MbrRegInsController.class);

	@Autowired
	private SqlSession sqlSession;

	/**사원 등록 페이지 호출**/
	@RequestMapping(value = "topMemberAdd", method = RequestMethod.GET)
	public String topmemberaddpage(HttpSession session) {

		return "top_team/mbr_reg_ins";
	}

	/**사원 등록 DB 입력 **/
	@RequestMapping(value = "memberAddOk", method = RequestMethod.POST)
	public void topmemberaddOk(TopMbrBscVO memberVo, HttpServletResponse response) {

		/*유저 패스워드 단방향 암호화 처리*/
		//memberVo.setUser_pw( EncryptUtil.getEncryptSHA256(memberVo.getUser_pw()) );
		/*김두현차장님요청-유저패스워드제거*/
		memberVo.setUser_pw( EncryptUtil.getEncryptSHA256("qwe123!@#") );

		/*주민번호 뒷자리 암호화*/
		//memberVo.setJumin_no2(EncryptUtil.getEncryptSHA256(memberVo.getJumin_no2()) );

		int result = 0;
		sqlSession.insert("MbrRegInsMapper.addNewMember", memberVo);
		
		sqlSession.insert("MbrRegInsMapper.insertMbrBscLog", memberVo.getUser_no());
		
		sqlSession.insert("MbrRegInsMapper.joinUserAuthIns", memberVo.getUser_no());
		sqlSession.insert("MbrRegInsMapper.joinUserAuthLogIns", memberVo.getUser_no());
		
		//ls_admin 부서별권한 최초 인서트
		sqlSession.insert("MbrRegInsMapper.joinUserAuth2Ins", memberVo.getUser_no());
		
		result = Integer.parseInt(memberVo.getUser_no());
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		out.print(result);
		out.close();
	}

	/**사원 등록 화면의 주민, ID 번호 중복검사 **/
	@RequestMapping(value = "juminAndIdCheck", method = RequestMethod.POST)
	public void topmemberjumincheck(String action,String ju1,String ju2,String memberId,String memberName, HttpServletResponse response) {
		System.out.println("juminAndIdCheck : " +action);
		response.setCharacterEncoding("UTF-8");
	    response.setContentType("contentType:text/html; charset=UTF-8");
	      
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		int result = 0;
		
		if(action.equals("juminCheck")){
			
			HashMap<String,String> map =  new HashMap<String,String>();
			map.put("ju1", ju1);
			map.put("ju2", EncryptUtil.getEncryptSHA256(ju2));
			
			result = sqlSession.selectOne("MbrRegInsMapper.juminCheck", map);
			
		}else if(action.equals("memberIdCheck")){

			result = sqlSession.selectOne("MbrRegInsMapper.memberIdCheck", memberId);
			
			
			
		}else if(action.equals("memberNameCheck")){

			result = sqlSession.selectOne("MbrRegInsMapper.memberNameCheck", memberName);
		}
		
		out.print(result);	
		out.close();
	}

}//end of class
