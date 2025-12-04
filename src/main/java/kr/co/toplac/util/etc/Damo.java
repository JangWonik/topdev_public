package kr.co.toplac.util.etc;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;

import com.penta.scpdb.ScpDbAgent;

/*
*********************************************************
* Program ID	: 디아모 암호화 및 복호화
* Program Name	: 디아모 암호화 및 복호화
* Description	: 디아모 암호화 및 복호화
* Author		: lds
* Date			: 2016.12.13.
*********************************************************
*/
public class Damo {

	private static final Logger logger = LoggerFactory.getLogger(Damo.class);
	
	/*
	 * public String decodeDamo(String text){ //String iniFilePath =
	 * "C:\\scp\\scpdb_agent.ini"; //디아모 설정파일 위치 String iniFilePath =
	 * "/scp/scpdb_agent.ini"; //디아모 설정파일 위치 - renew용 ScpDbAgent agt = new
	 * ScpDbAgent(); //디아모 객체생성
	 * 
	 * //String strDec = agt.ScpDecStr( iniFilePath, "KEY1", text, "EUC-KR"); String
	 * strDec = agt.ScpDecStr( iniFilePath, "KEY1", text, "UTF-8"); return strDec;
	 * }//end of decodeDamo
	 * 
	 * public String encodeDamo(String text){
	 * 
	 * // String iniFilePath = "C:\\scp\\scpdb_agent.ini"; //디아모 설정파일 위치 String
	 * iniFilePath = "/scp/scpdb_agent.ini"; //디아모 설정파일 위치 - renew용 ScpDbAgent agt =
	 * new ScpDbAgent(); //디아모 객체생성
	 * 
	 * //String strEnc = agt.ScpEncStr( iniFilePath, "KEY1", text, "UTF-8"); String
	 * strEnc = agt.ScpEncStr( iniFilePath, "KEY1", text, "UTF-8");
	 * 
	 * return strEnc;
	 * 
	 * }//end of encodeDamo
	 */	
	
	public String decodeDamo(String text){
		return text;
	}//end of decodeDamo
	
	public String encodeDamo(String text){
		return text;
	}//end of encodeDamo
	
}//end of class
