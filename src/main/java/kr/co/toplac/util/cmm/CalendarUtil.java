package kr.co.toplac.util.cmm;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
//import org.json.JSONObject;
import org.json.XML;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.FormHttpMessageConverter;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;


public class CalendarUtil{
	
	public static ArrayList<Map<String,Object>> makeCalendar(int year, int month, SqlSession sqlSession){
		
		ArrayList<Map<String,Object>> dayList = new ArrayList<>();
		
		//당월의 특일 정보
    	Map<String,Object> tmpMap = new HashMap<String,Object>();
    	tmpMap.put("year", year);
    	tmpMap.put("month", month);
    	List<Map<String,Object>> eventDateList = sqlSession.selectList("topVacationMapper.selectEventDayThisMonth",tmpMap);
    	
		
    	Calendar cal = Calendar.getInstance();
    	
    	//입력받은 년월의 1일
    	cal.set(year, month-1, 1);
    	int thisMonthEnd = cal.getActualMaximum(Calendar.DATE);
    	int thisDayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
    	String thisMonth = makePaddingZero(month);
    	
    	//입력받은 년월의 이전달
    	cal.set(year, month-2, 1);
    	int befMonthEnd = cal.getActualMaximum(Calendar.DATE);
    	int befDayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
    	String befMonth = makePaddingZero(month-1);
    	
    	//입력받은 년월의 다음달
    	cal.set(year, month, 1);
    	int aftMonthEnd = cal.getActualMaximum(Calendar.DATE);
    	int aftDayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
    	String aftMonth = makePaddingZero(month+1);
    	
    	//이전달 DATA
    	for (int i=1; i < thisDayOfWeek ; i++){
    		cal.set(year, month-2, 1);
    		
    		int tmpDay = befMonthEnd - (thisDayOfWeek - 1 - i);
    		String monthDay = befMonth + tmpDay;
    		
    		Map<String,Object> tmpDateMap = new HashMap<String,Object>();
    		tmpDateMap.put("dayOfWeek", i);
    		tmpDateMap.put("monthDay", monthDay);
    		
			tmpDateMap.put( "year", cal.get(Calendar.YEAR) );
			tmpDateMap.put( "month", cal.get(Calendar.MONTH) );
			tmpDateMap.put( "day", tmpDay);
			
			List<Map<String,Object>> tmpEventList = new ArrayList<>();
			HashMap<String,Object> tmpEventDayMap = new HashMap<>();
			tmpEventDayMap.put( "name", "" );
			tmpEventDayMap.put( "type", "bef" );
			tmpEventList.add(tmpEventDayMap);
			tmpDateMap.put("eventDay", tmpEventList);
    		
    		dayList.add(tmpDateMap);
    	}
    	
    	//이번달 DATA
    	for(int i=1; i <= thisMonthEnd ; i++){
    		cal.set(year, month-1, i);
    		
    		String tmpDay = makePaddingZero(i);
    		String monthDay = thisMonth + tmpDay;
    		int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
    		
    		Map<String,Object> tmpDateMap = new HashMap<String,Object>();
    		tmpDateMap.put("dayOfWeek", dayOfWeek);
    		tmpDateMap.put("monthDay", monthDay);
    		
			tmpDateMap.put( "year", cal.get(Calendar.YEAR) );
			tmpDateMap.put( "month", cal.get(Calendar.MONTH) );
			tmpDateMap.put( "day", tmpDay);
			
			List<Map<String,Object>> tmpEventList = new ArrayList<>();
    		for(int j=0; j < eventDateList.size() ;j++){
    			if (tmpDay.equals(eventDateList.get(j).get("day")) ){
    				HashMap<String,Object> tmpEventDayMap = new HashMap<>();
    				tmpEventDayMap.put( "name", eventDateList.get(j).get("name") );
    				tmpEventDayMap.put( "type", eventDateList.get(j).get("type") );
    				tmpEventList.add(tmpEventDayMap);
    			}
    		}
    		tmpDateMap.put("eventDay", tmpEventList);
    		
    		dayList.add(tmpDateMap);
    	}
    	
    	//다음달 DATA
    	int tmpCnt;
    	if (dayList.size() > 35){
    		tmpCnt = 42-dayList.size();
    	}else{
    		tmpCnt = 35-dayList.size();
    	}
    	
    	for(int i=1; i <= tmpCnt ;i++){
    		cal.set(year, month, i);
    		
    		String tmpDay = makePaddingZero(i);
    		String monthDay = aftMonth + tmpDay;
    		int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
    		
    		Map<String,Object> tmpDateMap = new HashMap<String,Object>();
    		tmpDateMap.put("dayOfWeek", dayOfWeek);
    		tmpDateMap.put("monthDay", monthDay);
    		
			tmpDateMap.put( "year", cal.get(Calendar.YEAR) );
			tmpDateMap.put( "month", cal.get(Calendar.MONTH) );
			tmpDateMap.put( "day", tmpDay);
			
			List<Map<String,Object>> tmpEventList = new ArrayList<>();
			HashMap<String,Object> tmpEventDayMap = new HashMap<>();
			tmpEventDayMap.put( "name", "" );
			tmpEventDayMap.put( "type", "aft" );
			tmpEventList.add(tmpEventDayMap);
			tmpDateMap.put("eventDay", tmpEventList);
			
    		dayList.add(tmpDateMap);
    	}
		return dayList;
    }
	
	public static String makePaddingZero(int num){
		String returnStr = ""+num;
		if (num / 10 < 1){
			returnStr = "0"+num;
		}
		
		return returnStr;
	}
	
	
	
	/***
	 * 
	 * SKT 의 event api 사용 하여 TABLE 구성 - 2022년까지만....
	 * @param sqlSession
	 * @throws Exception
	 */	
	
	public static void restDayMaker(SqlSession sqlSession) throws Exception{
		//============================================
		// 2018.05.31 기준 2022년 DATA까지 밖에 존재 하지 않음.
		// 추후 년도 바꿔서 돌려야함
		//============================================
		
		RestTemplate restTemplate = new RestTemplate();
		// RestTemplate 에 MessageConverter 세팅
	    List<HttpMessageConverter<?>> converters = new ArrayList<HttpMessageConverter<?>>();
	    converters.add(new FormHttpMessageConverter());
	    converters.add(new StringHttpMessageConverter(Charset.forName("UTF-8")));
		
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.add("Accept", "application/json");
		httpHeaders.add("TDCProjectKey", "0d0249aa-792b-4c6e-8f12-229bfdc6e995");
		
		
		for(int i=2018; i <= 2050 ;i++){
			URI uri = UriComponentsBuilder.fromHttpUrl("https://apis.sktelecom.com/v1/eventday/days")
					.queryParam("year", i)
					.build().toUri();
			
			ResponseEntity<String> responseEntity = restTemplate.exchange(uri, HttpMethod.GET, new HttpEntity(httpHeaders), String.class);
			
			JSONParser jsonParser = new JSONParser();
			JSONObject eventObj = (JSONObject) jsonParser.parse(responseEntity.getBody().toString());
			System.out.println(eventObj);
			
			JSONArray eventList = (JSONArray) eventObj.get("results");
			ObjectMapper objectMapper = new ObjectMapper();
			List<Map<String, Object>> list = new ArrayList<>();
			list = objectMapper.readValue(eventList.toString(), new TypeReference<List<Map<String, Object>>>(){});
			
			sqlSession.insert("topVacationMapper.insertVacationRestDay",list);
			
		}
	}
	
	/***
	 * 
	 * data.go.kr 의 특일정보 api 사용 하여 TABLE 구성 - 당해년도만 나옴..
	 * @param sqlSession
	 * @throws Exception
	 */
	public static void restDayMakerDatagokr(SqlSession sqlSession) throws Exception{
		// RestTemplate 에 MessageConverter 세팅
	    List<HttpMessageConverter<?>> converters = new ArrayList<HttpMessageConverter<?>>();
	    converters.add(new FormHttpMessageConverter());
	    converters.add(new StringHttpMessageConverter(Charset.forName("UTF-8")));
	 
	    RestTemplate restTemplate = new RestTemplate();
	    restTemplate.setMessageConverters(converters);
	    
	    String serviceKey = "";
		try {
			serviceKey = URLDecoder.decode("xGUfGUAwZqk8pEjAWbwyTCnyfOVTZu5g9xLpRxVaadflNZ2cr3Z6CdFBXYN%2F8t6egAC8ucIlVDbFynEfwuzpHg%3D%3D", "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		for(int i=2018; i <= 2050 ; i++){
			for(int j=1; j <= 12 ; j++){
				String year = ""+i;
				String month = makePaddingZero(j);
				System.out.println(year);
				System.out.println(month);
				
			    URI uri = UriComponentsBuilder.fromHttpUrl("http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getRestDeInfo")
			    		 					  .queryParam("solYear", year)
			    		 					  .queryParam("solMonth", month)
			    		 					  .queryParam("ServiceKey",serviceKey)
			    		 					  .build().toUri();
			    
			    ResponseEntity<String> responseEntity = restTemplate.getForEntity(uri, String.class);
			    
			    //XML -> JSON 변환
			    org.json.JSONObject xmlJSONObj = XML.toJSONObject(responseEntity.getBody());
			    	
			    //JSON -> MAP 형변환
		        ObjectMapper objectMapper = new ObjectMapper();
		        Map<String, Object> map = new HashMap<>();
		        map = objectMapper.readValue(xmlJSONObj.toString(), new TypeReference<Map<String, Object>>(){});
		        Map<String, Object> dataResponse = (Map<String, Object>) map.get("response");
		        Map<String, Object> body = (Map<String, Object>) dataResponse.get("body");
		        Map<String, Object> items = null;
		        List<Map<String, Object>> itemList = null;
		        Object testObj = null;
		        
		        testObj = body.get("items");
		        if (testObj instanceof Map){
		        	items = (Map<String, Object>)body.get("items");
		        	
		        	testObj = items.get("item");
		        	if (testObj instanceof Map){
		        		sqlSession.insert("topVacationMapper.insertVacationRestDay",(Map<String, Object>) items.get("item"));
		        	}else{
		        		itemList = (List<Map<String, Object>>) items.get("item");
				        for(Map<String,Object> restDateMap : itemList){
				        	sqlSession.insert("topVacationMapper.insertVacationRestDay",restDateMap);
				        }
		        		
		        	}
		        }
		        
//		        
//		        Map<String, Object> aa = (Map<String, Object>) items.get("item");
//		        System.out.println(aa);
		        
//		        itemList = (List<Map<String, Object>>) items.get("item");
//		        System.out.println(itemList);
		      
//		        if (items.size() == 1){
//		        	sqlSession.insert("topVacationMapper.insertVacationRestDay",(Map<String, Object>) items.get("item"));
//		        }else if (items.size() > 1){
//			        
//			        for(Map<String,Object> restDateMap : itemList){
//			        	System.out.println(restDateMap);
//			        	sqlSession.insert("topVacationMapper.insertVacationRestDay",restDateMap);
//			        }
//		        }
        
			}
			
		}
        
	    
	    
	}
	

}
