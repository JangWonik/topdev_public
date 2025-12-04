package kr.co.toplac.util.cmm;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by icwking on 2017. 3. 7..
 */
public class RequestUtil {
    public static Map<String, Object> getParameterMap(HttpServletRequest request){
        Map<String, Object> parameterMap = new HashMap<String, Object>();

        @SuppressWarnings("rawtypes")
        Enumeration enums = request.getParameterNames();

        while(enums.hasMoreElements()){
            String paramName = (String)enums.nextElement();
            String[] parameters = request.getParameterValues(paramName);

            //배열일경우
            if(parameters.length > 1){
                parameterMap.put(paramName, parameters);
            }else{
                parameterMap.put(paramName, parameters[0]);
            }
        }

        return parameterMap;
    }
    
    
    /**
     * Map 에 들어간 값을 하나의 String 으로 변환해서 리턴
     * @param inputMap
     * @return key : value , 형태로 변환
     */
    public static String conversionMap(Map<String, Object> inputMap) {
    	String sRet = "";
    	
    	try {    		
    		Set<String> keySet = inputMap.keySet();
        	Iterator<String> iterator = keySet.iterator();
        	
        	while( iterator.hasNext() ) {
        		String key = iterator.next();
        		Object value = inputMap.get(key);
        		String sMessage = "";
        		if( !"".equals(value.toString())) {
        			sMessage = value.toString();        			
        			if( sMessage.length() > 150 ) {
        				sMessage = sMessage.substring(0,148)+".. ";        				
        			}
        			sRet += key+" : "+sMessage+" ,";
        		}
        	}
        	
        	if( sRet.length() > 0 ) {
        		sRet = sRet.substring(0,sRet.length()-1);
        	}
    	}catch (Exception e) {
    		sRet = inputMap.toString();
			e.printStackTrace();
		}
    	
    	return sRet;
    }

}
