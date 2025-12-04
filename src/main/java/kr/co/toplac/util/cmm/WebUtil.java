package kr.co.toplac.util.cmm;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.regex.Pattern;

/**
 * Created by icwking on 2015. 10. 10..
 */
public class WebUtil {
    public static String clearXSSMinimum(String value) {
        if (value == null || value.trim().equals("")) {
            return "";
        }

        String returnValue = value;

        returnValue = returnValue.replaceAll("&", "&amp;");
        returnValue = returnValue.replaceAll("<", "&lt;");
        returnValue = returnValue.replaceAll(">", "&gt;");
        returnValue = returnValue.replaceAll("\"", "&#34;");
        returnValue = returnValue.replaceAll("\'", "&#39;");
        returnValue = returnValue.replaceAll(".", "&#46;");
        returnValue = returnValue.replaceAll("%2E", "");
        returnValue = returnValue.replaceAll("%2F", "");
        return returnValue;
    }

    public static String clearXSSMaximum(String value) {
        String returnValue = value;
        returnValue = clearXSSMinimum(returnValue);

        returnValue = returnValue.replaceAll("%00", null);

        returnValue = returnValue.replaceAll("%", "&#37;");

        // \\. => .

        returnValue = returnValue.replaceAll("\\.\\./", ""); // ../
        returnValue = returnValue.replaceAll("\\.\\.\\\\", ""); // ..\
        returnValue = returnValue.replaceAll("\\./", ""); // ./
        returnValue = returnValue.replaceAll("%2F", "");

        return returnValue;
    }

    public static String unscript(String data) {
        if (data == null || data.trim().equals("")) {
            return "";
        }

        String ret = data.toLowerCase();
        ret = ret.replaceAll("javascript", "x-javascript");
        ret = ret.replaceAll("script", "x-script");
        ret = ret.replaceAll("iframe", "x-iframe");
        ret = ret.replaceAll("document", "x-document");
        ret = ret.replaceAll("vbscript", "x-vbscript");
        ret = ret.replaceAll("applet", "x-applet");
        ret = ret.replaceAll("embed", "x-embed");
        ret = ret.replaceAll("object", "x-object");
        ret = ret.replaceAll("frame", "x-frame");
        ret = ret.replaceAll("grameset", "x-grameset");
        ret = ret.replaceAll("layer", "x-layer");
        ret = ret.replaceAll("bgsound", "x-bgsound");
        ret = ret.replaceAll("alert", "x-alert");
        ret = ret.replaceAll("onblur", "x-onblur");
        ret = ret.replaceAll("onchange", "x-onchange");
        ret = ret.replaceAll("onclick", "x-onclick");
        ret = ret.replaceAll("ondblclick","x-ondblclick");
        ret = ret.replaceAll("onerror", "x-onerror");
        ret = ret.replaceAll("onfocus", "x-onfocus");
        ret = ret.replaceAll("onload", "x-onload");
        ret = ret.replaceAll("onmouse", "x-onmouse");
        ret = ret.replaceAll("onscroll", "x-onscroll");
        ret = ret.replaceAll("onsubmit", "x-onsubmit");
        ret = ret.replaceAll("onunload", "x-onunload");        

//        ret = ret.replaceAll("<(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;script");
//        ret = ret.replaceAll("</(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;/script");
//
//        ret = ret.replaceAll("<(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;object");
//        ret = ret.replaceAll("</(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;/object");
//
//        ret = ret.replaceAll("<(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;applet");
//        ret = ret.replaceAll("</(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;/applet");
//
//        ret = ret.replaceAll("<(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
//        ret = ret.replaceAll("</(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
//
//        ret = ret.replaceAll("<(F|f)(O|o)(R|r)(M|m)", "&lt;form");
//        ret = ret.replaceAll("</(F|f)(O|o)(R|r)(M|m)", "&lt;form");
//
//        ret = ret.replaceAll("<(I|i)(F|f)(R|r)(A|a)(M|m)(E|e)", "&lt;iframe");
//        ret = ret.replaceAll("</(I|i)(F|f)(R|r)(A|a)(M|m)(E|e)", "&lt;/iframe");

        return ret;
    }

    /*
     *  XSS 방지
     */
    public static String removeXSS(String str, boolean use_html) {
        String str_low = "";
        if(use_html){ // HTML tag를 사용하게 할 경우 부분 허용
            // HTML tag를 모두 제거
            str = str.replaceAll("<","&lt;");
            str = str.replaceAll(">","&gt;");

            // 특수 문자 제거
            str = str.replaceAll("\"","&gt;");
            str = str.replaceAll("&", "&amp;");
            str = str.replaceAll("%00", null);
            str = str.replaceAll("\"", "&#34;");
            str = str.replaceAll("\'", "&#39;");
            str = str.replaceAll("%", "&#37;");
            str = str.replaceAll("../", "");
            str = str.replaceAll("..\\\\", "");
            str = str.replaceAll("./", "");
            str = str.replaceAll("%2F", "");
            // 허용할 HTML tag만 변경
            str = str.replaceAll("&lt;p&gt;", "<p>");
            str = str.replaceAll("&lt;P&gt;", "<P>");
            str = str.replaceAll("&lt;br&gt;", "<br>");
            str = str.replaceAll("&lt;BR&gt;", "<BR>");
            // 스크립트 문자열 필터링 (선별함 - 필요한 경우 보안가이드에 첨부된 구문 추가)
            str_low= str.toLowerCase();
            if( str_low.contains("javascript") || str_low.contains("script")     || str_low.contains("iframe") ||
                    str_low.contains("document")   || str_low.contains("vbscript")   || str_low.contains("applet") ||
                    str_low.contains("embed")      || str_low.contains("object")     || str_low.contains("frame") ||
                    str_low.contains("grameset")   || str_low.contains("layer")      || str_low.contains("bgsound") ||
                    str_low.contains("alert")      || str_low.contains("onblur")     || str_low.contains("onchange") ||
                    str_low.contains("onclick")    || str_low.contains("ondblclick") || str_low.contains("onerror") ||
                    str_low.contains("onfocus")    || str_low.contains("onload")     || str_low.contains("onmouse") ||
                    str_low.contains("onscroll")   || str_low.contains("onsubmit")   || str_low.contains("onunload"))
            {
                str = str_low;
                str = str.replaceAll("javascript", "x-javascript");
                str = str.replaceAll("script", "x-script");
                str = str.replaceAll("iframe", "x-iframe");
                str = str.replaceAll("document", "x-document");
                str = str.replaceAll("vbscript", "x-vbscript");
                str = str.replaceAll("applet", "x-applet");
                str = str.replaceAll("embed", "x-embed");
                str = str.replaceAll("object", "x-object");
                str = str.replaceAll("frame", "x-frame");
                str = str.replaceAll("grameset", "x-grameset");
                str = str.replaceAll("layer", "x-layer");
                str = str.replaceAll("bgsound", "x-bgsound");
                str = str.replaceAll("alert", "x-alert");
                str = str.replaceAll("onblur", "x-onblur");
                str = str.replaceAll("onchange", "x-onchange");
                str = str.replaceAll("onclick", "x-onclick");
                str = str.replaceAll("ondblclick","x-ondblclick");
                str = str.replaceAll("onerror", "x-onerror");
                str = str.replaceAll("onfocus", "x-onfocus");
                str = str.replaceAll("onload", "x-onload");
                str = str.replaceAll("onmouse", "x-onmouse");
                str = str.replaceAll("onscroll", "x-onscroll");
                str = str.replaceAll("onsubmit", "x-onsubmit");
                str = str.replaceAll("onunload", "x-onunload");
            }
        }else{ // HTML tag를 사용하지 못하게 할 경우
            str = str.replaceAll("\"","&gt;");
            str = str.replaceAll("&", "&amp;");
            str = str.replaceAll("<", "&lt;");
            str = str.replaceAll(">", "&gt;");
            str = str.replaceAll("%00", null);
            str = str.replaceAll("\"", "&#34;");
            str = str.replaceAll("\'", "&#39;");
            str = str.replaceAll("%", "&#37;");
            str = str.replaceAll("../", "");
            str = str.replaceAll("..\\\\", "");
            str = str.replaceAll("./", "");
            str = str.replaceAll("%2F", "");
        }
        return str;
    }

    public static String filePathBlackList(String value) {
        String returnValue = value;
        if (returnValue == null || returnValue.trim().equals("")) {
            return "";
        }

        returnValue = returnValue.replaceAll("\\.\\./", ""); // ../
        returnValue = returnValue.replaceAll("\\.\\.\\\\", ""); // ..\

        return returnValue;
    }

    /**
     * 행안부 보안취약점 점검 조치 방안.
     *
     * @param value
     * @return
     */
    public static String filePathReplaceAll(String value) {
        String returnValue = value;
        if (returnValue == null || returnValue.trim().equals("")) {
            return "";
        }

        returnValue = returnValue.replaceAll("/", "");
        returnValue = returnValue.replaceAll("\\", "");
        returnValue = returnValue.replaceAll("\\.\\.", ""); // ..
        returnValue = returnValue.replaceAll("&", "");

        return returnValue;
    }

    public static String filePathWhiteList(String value) {
        return value;
    }

    public static boolean isIPAddress(String str) {
        Pattern ipPattern = Pattern.compile("\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}");

        return ipPattern.matcher(str).matches();
    }

    public static String removeCRLF(String parameter) {
        return parameter.replaceAll("\r", "").replaceAll("\n", "");
    }

    public static String removeSQLInjectionRisk(String parameter) {
        return parameter.replaceAll("\\p{Space}", "").replaceAll("\\*", "").replaceAll("%", "").replaceAll(";", "").replaceAll("-", "").replaceAll("\\+", "").replaceAll(",", "");
    }

    public static String removeOSCmdRisk(String parameter) {
        return parameter.replaceAll("\\p{Space}", "").replaceAll("\\*", "").replaceAll("|", "").replaceAll(";", "");
    }
    /**
     * 특정기호로 구분된 String 을 temp,temp2 형태로 변경해준다.
     * @param sSource
     * @param divString (특수문자 | 인경우 \\| 로 넣어주어야 정상작동함)
     * @return Sql In 조건에 들어가도록 변경된 String return
     * @author top3009 
     */
    public static String makeInsqlString(String sSource, String divString) {
    	String sRet = "";
    	String [] sList = null;
    	
    	if( sSource == null ) {		//입력되는 string 이 null 일 경우 빈값을 리턴
    		sRet = "";
    	}else{    	
	    	sList = sSource.split(divString);    	
	    	
	    	for(int i = 0; i < sList.length; i++){
	    		if( !"".equals(sList[i]) ) {
	    			sRet += sList[i]+",";
	    		}
	    	}
	    	
	    	//마지막 콤마 제거
	    	if( !"".equals(sRet)){
	    		sRet = sRet.substring(0, sRet.length()-1);
	    	}
    	}
    	
    	return sRet;
    }
    
    public static long parseStringToLong(String sTemp) {
    	long nRet = 0;
    	
    	if( sTemp != null && !sTemp.equals("") ) {
    		nRet = Long.parseLong(sTemp);
    	}    	
    	
    	return nRet;
    }
    
    /**
     * 공인아이피 정보 가져오기
     * @return String sRetIp
     */
    public static String getPublicIPFetcher() {
    	
    	String sRetIp = "";
    	
    	try {
            String ipService = "https://api.ipify.org";		// 또는 https://checkip.amazonaws.com
            URL url = new URL(ipService);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");

            BufferedReader in = new BufferedReader(
                new InputStreamReader(connection.getInputStream())
            );
            sRetIp = in.readLine();
            in.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
    	return sRetIp;
                        
    }
    
    /*
    public static void main(String[] args) {
    	
    	String sPublicIp = WebUtil.getPublicIPFetcher();
    	
    	System.out.println("sPublicIp : "+sPublicIp);
    	
	}
	*/
    
}
