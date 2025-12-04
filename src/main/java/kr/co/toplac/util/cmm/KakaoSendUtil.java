package kr.co.toplac.util.cmm;

import java.net.URI;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.converter.FormHttpMessageConverter;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

public class KakaoSendUtil {
	
	/**
	 * IT정보보호파트에서 사용하는 접수, 안내 발송함수 
	 * @param senderNo
	 * @param receiveNo
	 * @param sMsg
	 * @param smsType
	 * @return
	 */
	public static String sendKakaoTalkByIt(String senderNo, String receiveNo, String sMsg, int smsType){				//smsType에 따라 메세지가 달라짐
		String sRet = "";
		
		String tmplId = "toplac_helpdesk_1";		//helpdesk 접수시 안내문자
		
		if( smsType == 2 ){			//helpdesk 완료시 안내문자 
			tmplId = "toplac_helpdesk_2";
		}
		
		String msg = sMsg;								//발송메세지
		
		String phn = "82"+receiveNo.substring(1);
		
		RestTemplate restTemplate = new RestTemplate();
		// RestTemplate 에 MessageConverter 세팅
	    List<HttpMessageConverter<?>> converters = new ArrayList<HttpMessageConverter<?>>();
	    converters.add(new FormHttpMessageConverter());
	    converters.add(new StringHttpMessageConverter(Charset.forName("UTF-8")));
		
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.add("Accept", "application/json");
		httpHeaders.add("Content-type", "application/json");
		httpHeaders.add("userId", "toplac"); //실제
		
		
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		obj.put("message_type", "at");
		obj.put("phn", phn);
		obj.put("profile", "22e9cd927d652e02daca5dc631170e021f02ae51");	//실제
		obj.put("tmplId", tmplId);
		obj.put("msg", msg);
	
		obj.put("smsKind", "L");
		obj.put("msgSms", msg);
		obj.put("smsSender", "0260774600");
	
		obj.put("smsLmsTit", "탑손해사정주식회사");
		obj.put("reserveDt", "00000000000000");
		
		//메시지 길이가 930자 이상인경우 SMS 로 전환하여 발송
		int msgLength = msg.length();
		if( msgLength > 930 ) {
			obj.put("smsOnly", "Y");
		}
		
		arr.add(obj);
		
		HttpEntity entity = new HttpEntity(arr, httpHeaders);
		
		URI uri = UriComponentsBuilder.fromHttpUrl("https://alimtalk-api.bizmsg.kr/v2/sender/send")
				.build().toUri();
				
		
		String responseEntity = restTemplate.postForObject(uri, entity, String.class);
		
		//logger.info("IT Helpdesk SendKakao : "+phn+" : "+msg+" : "+tmplId);
		
		return sRet;		
	}
}
