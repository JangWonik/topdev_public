package kr.co.toplac.util.enc;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class EncryptUtil {
	
	/**/
	/*
	 * ***************************************
	 * Method ID : getEncryptSHA256
	 * Method Name :  getEncryptSHA256
	 * Description : SHA -256 방식의 암호화
	 * 번호 1 : 입력 str 암호화 처리
	 * 번호 2 : 암호화 문자열 반환
	 * Author : 이선형
	 * Date : 20160421
	 * ***************************************
	 * */
	public static String getEncryptSHA256(String str){
		
        String encryptedSHA256 = "";
        MessageDigest md = null;
        
        try {
        	
        	/*번호 1*/
            md = MessageDigest.getInstance("SHA-256");
            md.update(str.getBytes(), 0, str.length());
            encryptedSHA256 = new BigInteger(1, md.digest()).toString(16); 
            
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        
        /*번호 2*/
        return encryptedSHA256;
    }
}
