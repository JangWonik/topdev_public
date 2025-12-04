package kr.co.toplac.topteam;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

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
public class PopMbrAuthListController {
	
private static final Logger logger = LoggerFactory.getLogger(PopMbrAuthListController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "AuthListPage", method = RequestMethod.POST)
	public void AuthListPage(Model model, String user_no,  HttpServletResponse response) {
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("contentType:text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		List<TopMbrAuthVO> authList = sqlSession.selectList("PopMbrAuthList.userAuthList", user_no);
		
		JSONArray arr = new JSONArray();
		for(int i=0; i < authList.size(); i++){
			TopMbrAuthVO tmpvo = authList.get(i);
			
			/*보고서 접수(수임)*/
			if(tmpvo.getMbr_pms_1().equals("0")){
				tmpvo.setMbr_pms_1("X");
			}else{
				tmpvo.setMbr_pms_1("O");
			}
			
			/*보고서 열람*/
			/* 권한2가 생기면서 not used */
//			if( tmpvo.getMbr_pms_2().equals("0")){
//				tmpvo.setMbr_pms_2("X");
//			}else{
//				tmpvo.setMbr_pms_2("O");
//			}
			
			/*보고서 삭제*/
			if(tmpvo.getMbr_pms_3().equals("0")){
				tmpvo.setMbr_pms_3("X");
			}else{
				tmpvo.setMbr_pms_3("O");
			}
			
			/*보고서 종결(결재) 취소*/
			if(tmpvo.getMbr_pms_4().equals("0")){
				tmpvo.setMbr_pms_4("X");
			}else{
				tmpvo.setMbr_pms_4("O");
			}
			
			/*보고서 잠금 해제*/
			if(tmpvo.getMbr_pms_5().equals("0")){
				tmpvo.setMbr_pms_5("X");
			}else{
				tmpvo.setMbr_pms_5("O");
			}
			
			/*조사 보고서 엑셀 다운*/
			if(tmpvo.getMbr_pms_6().equals("0")){
				tmpvo.setMbr_pms_6("X");
			}else if(tmpvo.getMbr_pms_6().equals("1")){
				tmpvo.setMbr_pms_6("팀");
			}else if(tmpvo.getMbr_pms_6().equals("2")){
				tmpvo.setMbr_pms_6("지역본부");
			}else if(tmpvo.getMbr_pms_6().equals("3")){
				tmpvo.setMbr_pms_6("업종");
			}else if(tmpvo.getMbr_pms_6().equals("4")){
				tmpvo.setMbr_pms_6("전체");
			}
			
			/*총무 경리 열람*/
			if(tmpvo.getMbr_pms_7().equals("0")){
				tmpvo.setMbr_pms_7("X");
			}else if(tmpvo.getMbr_pms_7().equals("1")){
				tmpvo.setMbr_pms_7("팀");
			}else if(tmpvo.getMbr_pms_7().equals("2")){
				tmpvo.setMbr_pms_7("지역본부");
			}else if(tmpvo.getMbr_pms_7().equals("3")){
				tmpvo.setMbr_pms_7("업종");
			}else if(tmpvo.getMbr_pms_7().equals("4")){
				tmpvo.setMbr_pms_7("전체");
			}
			
			/*총무 경리 수정*/
			if(tmpvo.getMbr_pms_8().equals("0")){
				tmpvo.setMbr_pms_8("X");
			}else{
				tmpvo.setMbr_pms_8("O");
			}
			
			/*보험사 정보 수정*/
			if(tmpvo.getMbr_pms_9().equals("0")){
				tmpvo.setMbr_pms_9("X");
			}else{
				tmpvo.setMbr_pms_9("O");
			}
			
			/*관련 업체 엑셀 다운*/
			if(tmpvo.getMbr_pms_10().equals("0")){
				tmpvo.setMbr_pms_10("X");
			}else{
				tmpvo.setMbr_pms_10("O");
			}
			
			/*보험사 공지 관리(1종)*/
			if(tmpvo.getMbr_pms_11().equals("0")){
				tmpvo.setMbr_pms_11("X");
			}else{
				tmpvo.setMbr_pms_11("O");
			}
			
			/*보험사 공지 관리(4종)*/
			if(tmpvo.getMbr_pms_12().equals("0")){
				tmpvo.setMbr_pms_12("X");
			}else{
				tmpvo.setMbr_pms_12("O");
			}
			
			/*팀관리*/
			if(tmpvo.getMbr_pms_13().equals("0")){
				tmpvo.setMbr_pms_13("X");
			}else{
				tmpvo.setMbr_pms_13("O");
			}
			
			/*인사 기록*/
			if(tmpvo.getMbr_pms_14().equals("0")){
				tmpvo.setMbr_pms_14("X");
			}else{
				tmpvo.setMbr_pms_14("O");
			}
			
			/*인사 평가 관리 권한*/
			if(tmpvo.getMbr_pms_15().equals("0")){
				tmpvo.setMbr_pms_15("X");
			}else{
				tmpvo.setMbr_pms_15("O");
			}
			
			/*재직 증명서 승인*/
			if(tmpvo.getMbr_pms_16().equals("0")){
				tmpvo.setMbr_pms_16("X");
			}else{
				tmpvo.setMbr_pms_16("O");
			}
			
			/*경비 내역 결재 & 취소*/
			if(tmpvo.getMbr_pms_17().equals("0")){
				tmpvo.setMbr_pms_17("X");
			}else{
				tmpvo.setMbr_pms_17("O");
			}
			
			/*경비 승인 결재 & 취소*/
			if(tmpvo.getMbr_pms_18().equals("0")){
				tmpvo.setMbr_pms_18("X");
			}else{
				tmpvo.setMbr_pms_18("O");
			}
			
			/*적부 워드전환*/
			if(tmpvo.getMbr_pms_19().equals("0")){
				tmpvo.setMbr_pms_19("X");
			}else{
				tmpvo.setMbr_pms_19("O");
			}
			
			/*응답 전문*/
			if(tmpvo.getMbr_pms_20().equals("0")){
				tmpvo.setMbr_pms_20("X");
			}else{
				tmpvo.setMbr_pms_20("O");
			}
			
			/*통계*/
			if(tmpvo.getMbr_pms_21().equals("0")){
				tmpvo.setMbr_pms_21("X");
			}else{
				tmpvo.setMbr_pms_21("O");
			}
			
			/*당직 결재*/
			if(tmpvo.getMbr_pms_22().equals("0")){
				tmpvo.setMbr_pms_22("X");
			}else{
				tmpvo.setMbr_pms_22("O");
			}
			
			/*당직 등록*/
			if(tmpvo.getMbr_pms_23().equals("0")){
				tmpvo.setMbr_pms_23("X");
			}else{
				tmpvo.setMbr_pms_23("O");
			}
			
			/*보고서 알림*/
			if(tmpvo.getMbr_pms_24().equals("0")){
				tmpvo.setMbr_pms_24("X");
			}else if(tmpvo.getMbr_pms_24().equals("1")){
				tmpvo.setMbr_pms_24("개인");
			}else if(tmpvo.getMbr_pms_24().equals("2")){
				tmpvo.setMbr_pms_24("팀장");
			}else if(tmpvo.getMbr_pms_24().equals("3")){
				tmpvo.setMbr_pms_24("관리자");
			}
			
			/*보고서 이첩*/
			if(tmpvo.getMbr_pms_25().equals("0")){
				tmpvo.setMbr_pms_25("X");
			}else if(tmpvo.getMbr_pms_25().equals("1")){
				tmpvo.setMbr_pms_25("개인");
			}else if(tmpvo.getMbr_pms_25().equals("2")){
				tmpvo.setMbr_pms_25("팀장");
			}else if(tmpvo.getMbr_pms_25().equals("3")){
				tmpvo.setMbr_pms_25("센터장");
			}else if(tmpvo.getMbr_pms_25().equals("4")){
				tmpvo.setMbr_pms_25("관리자");
			}
			
			/*사내지침*/
			if(tmpvo.getMbr_pms_26().equals("0")){
				tmpvo.setMbr_pms_26("X");
			}else{
				tmpvo.setMbr_pms_26("O");
			}
			
			/* 강의실 결재 권한*/
			if(tmpvo.getMbr_pms_27().equals("0")){
				tmpvo.setMbr_pms_27("X");
			}else{
				tmpvo.setMbr_pms_27("O");
			}
			
			/* 휴가 결재 권한 */
			if(tmpvo.getMbr_pms_28().equals("0")){
				tmpvo.setMbr_pms_28("X");
			}else if(tmpvo.getMbr_pms_28().equals("1")){
				tmpvo.setMbr_pms_28("1종");
			}else if(tmpvo.getMbr_pms_28().equals("4")){
				tmpvo.setMbr_pms_28("4종");
			}
			
			JSONObject obj = new JSONObject();
			obj.put("rownum", tmpvo.getROWNUM());
			obj.put("user_no", tmpvo.getUser_no());
			obj.put("mbr_pms_1", tmpvo.getMbr_pms_1());
			obj.put("mbr_pms_2", tmpvo.getMbr_pms_2());
			obj.put("mbr_pms_3", tmpvo.getMbr_pms_3());
			obj.put("mbr_pms_4", tmpvo.getMbr_pms_4());
			obj.put("mbr_pms_5", tmpvo.getMbr_pms_5());
			obj.put("mbr_pms_6", tmpvo.getMbr_pms_6());
			obj.put("mbr_pms_7", tmpvo.getMbr_pms_7());
			obj.put("mbr_pms_8", tmpvo.getMbr_pms_8());
			obj.put("mbr_pms_9", tmpvo.getMbr_pms_9());
			obj.put("mbr_pms_10", tmpvo.getMbr_pms_10());
			obj.put("mbr_pms_11", tmpvo.getMbr_pms_11());
			obj.put("mbr_pms_12", tmpvo.getMbr_pms_12());
			obj.put("mbr_pms_13", tmpvo.getMbr_pms_13());
			obj.put("mbr_pms_14", tmpvo.getMbr_pms_14());
			obj.put("mbr_pms_15", tmpvo.getMbr_pms_15());
			obj.put("mbr_pms_16", tmpvo.getMbr_pms_16());
			obj.put("mbr_pms_17", tmpvo.getMbr_pms_17());
			obj.put("mbr_pms_18", tmpvo.getMbr_pms_18());
			obj.put("mbr_pms_19", tmpvo.getMbr_pms_19());
			obj.put("mbr_pms_20", tmpvo.getMbr_pms_20());
			obj.put("mbr_pms_21", tmpvo.getMbr_pms_21());
			obj.put("mbr_pms_22", tmpvo.getMbr_pms_22());
			obj.put("mbr_pms_23", tmpvo.getMbr_pms_23());
			obj.put("mbr_pms_24", tmpvo.getMbr_pms_24());
			obj.put("mbr_pms_25", tmpvo.getMbr_pms_25());
			obj.put("mbr_pms_26", tmpvo.getMbr_pms_26());
			obj.put("mbr_pms_27", tmpvo.getMbr_pms_27());
			obj.put("mbr_pms_28", tmpvo.getMbr_pms_28());			
			obj.put("reg_user", tmpvo.getReg_user());
			obj.put("reg_date", tmpvo.getReg_date());
			arr.add(obj);
		}
		String jsonStr = arr.toString();
		out.print(jsonStr);
		out.close();
	}

}
