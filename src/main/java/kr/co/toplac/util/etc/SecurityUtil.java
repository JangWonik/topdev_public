package kr.co.toplac.util.etc;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;

public class SecurityUtil {

    public static String aesEncrypt(String input, String key){
        byte[] crypted = null;
        
        if("".equals(key)) {
        	key = "toplac_securekey";
        }
        
        try{
            SecretKeySpec skey = new SecretKeySpec(key.getBytes(), "AES");
            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
            cipher.init(Cipher.ENCRYPT_MODE, skey);
            crypted = cipher.doFinal(input.getBytes());
        }catch(Exception e){
            System.out.println(e.toString());
        }
        return new String(Base64.encodeBase64(crypted));
    }

    public static String aesDecrypt(String input, String key){
        byte[] output = null;
        
        if("".equals(key)) {
        	key = "toplac_securekey";
        }
        
        try{
            SecretKeySpec skey = new SecretKeySpec(key.getBytes(), "AES");
            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
            cipher.init(Cipher.DECRYPT_MODE, skey);
            output = cipher.doFinal(Base64.decodeBase64(input));
        }catch(Exception e){
            System.out.println(e.toString());
        }
        return new String(output);
    }
    
    //public static void main(String[] args) {
		//String sKey = "toplac_securekey";
		//String localpasswd = "top!4600";
		//String secuMsg = aesEncrypt(localpasswd,sKey);
		//System.out.println("secuMsg="+secuMsg);
		//String decodeMsg = aesDecrypt(secuMsg, sKey);
		//System.out.println("decodeMsg="+decodeMsg);
	//}
    
}