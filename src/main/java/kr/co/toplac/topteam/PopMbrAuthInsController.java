package kr.co.toplac.topteam;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class PopMbrAuthInsController {
	
private static final Logger logger = LoggerFactory.getLogger(PopMbrAuthInsController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	/*
	 * 180801 이후 코드 재 작성, 미사용  
	 */
	
	/*
	 * ***************************************
	 * Method ID : AuthInsPage
	 * Method Name :  AuthInsPage
	 * Description : 전산 권한 관리 수정 페이지 컨트롤러
	 * 번호 1 : 사원의 전산 권한 추출
	 * Author : 이선형
	 * Date : 20160418
	 * ***************************************
	 * */
	@RequestMapping(value = "AuthInsPage", method = RequestMethod.POST)
	public void AuthInsPage(Model model, String user_no, PrintWriter out) {
		
		/*번호 1 - 사원의 전산 권한 추출*/
		List<TopMbrAuthVO> authList = sqlSession.selectList("PopMbrAuthIns.userAuth", user_no);
		
		JSONArray arr = new JSONArray();
		
		for (int i = 0; i < authList.size(); i++) {

			JSONObject obj = new JSONObject();
			
			obj.put("serial_no", authList.get(i).getSerial_no());
			obj.put("user_no", authList.get(i).getUser_no());
			obj.put("mbr_pms_1", authList.get(i).getMbr_pms_1());
			obj.put("mbr_pms_2", authList.get(i).getMbr_pms_2());
			obj.put("mbr_pms_3", authList.get(i).getMbr_pms_3());
			obj.put("mbr_pms_4", authList.get(i).getMbr_pms_4());
			obj.put("mbr_pms_5", authList.get(i).getMbr_pms_5());
			obj.put("mbr_pms_6", authList.get(i).getMbr_pms_6());
			obj.put("mbr_pms_7", authList.get(i).getMbr_pms_7());
			obj.put("mbr_pms_8", authList.get(i).getMbr_pms_8());
			obj.put("mbr_pms_9", authList.get(i).getMbr_pms_9());
			obj.put("mbr_pms_10", authList.get(i).getMbr_pms_10());
			obj.put("mbr_pms_11", authList.get(i).getMbr_pms_11());
			obj.put("mbr_pms_12", authList.get(i).getMbr_pms_12());
			obj.put("mbr_pms_13", authList.get(i).getMbr_pms_13());
			obj.put("mbr_pms_14", authList.get(i).getMbr_pms_14());
			obj.put("mbr_pms_15", authList.get(i).getMbr_pms_15());
			obj.put("mbr_pms_16", authList.get(i).getMbr_pms_16());
			obj.put("mbr_pms_17", authList.get(i).getMbr_pms_17());
			obj.put("mbr_pms_18", authList.get(i).getMbr_pms_18());
			obj.put("mbr_pms_19", authList.get(i).getMbr_pms_19());
			obj.put("mbr_pms_20", authList.get(i).getMbr_pms_20());
			obj.put("mbr_pms_21", authList.get(i).getMbr_pms_21());
			obj.put("mbr_pms_22", authList.get(i).getMbr_pms_22());
			obj.put("mbr_pms_23", authList.get(i).getMbr_pms_23());
			obj.put("mbr_pms_24", authList.get(i).getMbr_pms_24());
			obj.put("mbr_pms_25", authList.get(i).getMbr_pms_25());
			obj.put("mbr_pms_26", authList.get(i).getMbr_pms_26());
			obj.put("mbr_pms_27", authList.get(i).getMbr_pms_27());
			obj.put("mbr_pms_28", authList.get(i).getMbr_pms_28());
			obj.put("mbr_pms_29", authList.get(i).getMbr_pms_29());
			obj.put("mbr_pms_30", authList.get(i).getMbr_pms_30());
			obj.put("mbr_pms_31", authList.get(i).getMbr_pms_31());
				
			obj.put("reg_date", authList.get(i).getReg_date());
			
			arr.add(obj);
			
		}

		String jsonStr = arr.toString();
		out.print(jsonStr);
	
		
	}
	
	/*
	 * ***************************************
	 * Method ID : AuthUdtAndIns
	 * Method Name :  AuthUdtAndIns
	 * Description : 전산 권한 관리 삭제/삽입 
	 * 
	 * Author : 이선형
	 * Date : 20160418
	 * ***************************************
	 * */
	@RequestMapping(value = "AuthUdtAndIns", method = RequestMethod.POST)
	public void AuthUdtAndIns(Model model, String user_no, PrintWriter out,TopMbrAuthVO authVo, HttpSession session) {
		
		int deletePms = 0;
		
		/*사원의 전산로그 정보가 있는지 확인*/
		int isAuth = sqlSession.selectOne("PopMbrAuthList.userAuthOne", authVo.getUser_no());
		if(isAuth > 0){
			/*있으면 삭제*/
			deletePms = sqlSession.delete("PopMbrAuthIns.userAuthDel",authVo.getUser_no());
		}
		
		/*사원의 권한 인서트*/
		int resultIns = sqlSession.insert("PopMbrAuthIns.userAuthIns", authVo);
		
		/*사원의 권한 로그 인서트*/
		authVo.setReg_user( (String)session.getAttribute("user_no_Session") );
		int resultLogIns = sqlSession.insert("PopMbrAuthIns.userAuthLogIns", authVo);
		
		if(isAuth > 0){
			if((resultIns== 1) && (resultLogIns == 1) &&(deletePms == 1)){
				out.print(1);
			}else{
				out.print(0);
			}			
		}else{
			if((resultIns== 1) && (resultLogIns == 1)){
				out.print(1);
			}else{
				out.print(0);
			}
		}
		
	}
}
