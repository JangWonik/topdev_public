package kr.co.toplac.util.mail;

import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;
import javax.xml.rpc.ServiceException;

public class Sendmail {
	
	/**
	 * 손해사정서 전송계정으로 분리
	 * @param sFromName : 보내는사람 이름
	 * @param sFromAddress : 보내는 사람 주소 (표기)
	 * @param sToAddress : 수신자주소
	 * @param sSubject : 메일제목
	 * @param sContent : 메일내용
	 * @param sFilePath : 첨부파일 절대경로
	 * @param sFileName : 첨부파일 명
	 * @throws ServiceException
	 */
	public String send( String sFromName, String sFromAddress, String sToAddress, String sSubject, String sContent, String sFilePath, String sFileName ) throws ServiceException {
		
		String sRet = "";
		
		Properties props = System.getProperties();
		
		props.put("mail.smtp.host", "mail.toplac.co.kr");
		props.put("mail.smtp.port", "25");
		props.put("mail.smtp.auth", "true");
		
		Session session = Session.getDefaultInstance(props, new Authenticator() {
			String userId = "webnotice@toplac.co.kr";
			String userPw = "notice1004!";
			
			@Override
			protected PasswordAuthentication getPasswordAuthentication(){
				return new PasswordAuthentication(userId, userPw);
			}
			
		});		
		
		try {
			MimeMessage message = new MimeMessage(session);
			
			InternetAddress sFrom = new InternetAddress();
			
			if( !"".equals(sFromName) ) {				
				sFrom.setPersonal(sFromName, "UTF-8");				
			}
			
			sFrom.setAddress(sFromAddress);
			
			message.setFrom(sFrom);					//보내는 사람주소 (이름 주소형식)
			message.setRecipients(Message.RecipientType.TO, sToAddress);	//받는 사람 주소
			message.setSubject(sSubject);
			
			MimeBodyPart mbp1 = new MimeBodyPart();
			mbp1.setText(sContent, "UTF-8", "html");			
			
			Multipart mp = new MimeMultipart();
			mp.addBodyPart(mbp1);
			
			//첨부파일 정보가 없는 경우 본문 내용만 발송한다.
			if( !"".equals(sFilePath) && !"".equals(sFileName)) {
				MimeBodyPart mbp2 = new MimeBodyPart();		//첨부파일
				FileDataSource fds = new FileDataSource(sFilePath);
				
				//한글파일명 깨짐 방지
				String enCodeFileName = MimeUtility.encodeText(sFileName,"UTF-8","B");
				
				mbp2.setDataHandler( new DataHandler(fds) );			
				mbp2.setFileName(enCodeFileName);
				mp.addBodyPart(mbp2);
			}
			
			message.setContent(mp);
			
			Transport.send(message);
			
			sRet = "Success";
			
		} catch (Exception e) {
			System.out.println("Sendmail Error : "+e.getMessage());
			sRet = "Sendmail Error : "+e.getMessage();
		}
		return sRet;
		
	}
	
	/**
	 * 알림, 시스템 공지용 계정 분리
	 * @param sFromName : 보내는사람 이름
	 * @param sFromAddress : 보내는 사람 주소 (표기)
	 * @param sToAddress : 수신자주소
	 * @param sSubject : 메일제목
	 * @param sContent : 메일내용
	 * @param sFilePath : 첨부파일 절대경로
	 * @param sFileName : 첨부파일 명
	 * @throws ServiceException
	 */	
	public String sendContract( String sFromName, String sFromAddress, String sToAddress, String sSubject, String sContent, String sFilePath, String sFileName ) throws ServiceException {
		
		String sRet = "";
		
		Properties props = System.getProperties();
		
		props.put("mail.smtp.host", "mail.toplac.co.kr");
		props.put("mail.smtp.port", "25");
		props.put("mail.smtp.auth", "true");
		
		Session session = Session.getDefaultInstance(props, new Authenticator() {
			String userId = "webcontract@toplac.co.kr";
			String userPw = "contract1004!";
			
			@Override
			protected PasswordAuthentication getPasswordAuthentication(){
				return new PasswordAuthentication(userId, userPw);
			}
			
		});		
		
		try {
			MimeMessage message = new MimeMessage(session);
			
			InternetAddress sFrom = new InternetAddress();
			
			if( !"".equals(sFromName) ) {				
				sFrom.setPersonal(sFromName, "UTF-8");				
			}
			
			sFrom.setAddress(sFromAddress);
			
			message.setFrom(sFrom);					//보내는 사람주소 (이름 주소형식)
			message.setRecipients(Message.RecipientType.TO, sToAddress);	//받는 사람 주소
			message.setSubject(sSubject);
			
			MimeBodyPart mbp1 = new MimeBodyPart();
			mbp1.setText(sContent, "UTF-8", "html");			
			
			Multipart mp = new MimeMultipart();
			mp.addBodyPart(mbp1);
			
			//첨부파일 정보가 없는 경우 본문 내용만 발송한다.
			if( !"".equals(sFilePath) && !"".equals(sFileName)) {
				MimeBodyPart mbp2 = new MimeBodyPart();		//첨부파일
				FileDataSource fds = new FileDataSource(sFilePath);
				
				//한글파일명 깨짐 방지
				String enCodeFileName = MimeUtility.encodeText(sFileName,"UTF-8","B");
				
				mbp2.setDataHandler( new DataHandler(fds) );			
				mbp2.setFileName(enCodeFileName);
				mp.addBodyPart(mbp2);
			}
			
			message.setContent(mp);
			
			Transport.send(message);
			
			sRet = "Success";
			
		} catch (Exception e) {
			System.out.println("Sendmail Error : "+e.getMessage());
			sRet = "Sendmail Error : "+e.getMessage();
		}
		return sRet;
		
	}
	
	/*
	public static void main(String[] args) {
		Sendmail sendmail = new Sendmail();
		String sFromAddress = "oniku81@gmail.com";
		String sFromName = "장원익";
		String sToAddress = "top5991@toplac.co.kr";		
		String sSubject = "탑손해사정 인트라넷 메일 발송 테스트입니다.";
		String sContent = "본문내용 발송 테스트\n발신전용 메일입니다.";
		//String sFilePath = "C:\\home\\salary_contract\\2021\\1786\\2021_1786_secu.html";
		String sFilePath = "";
		//String sFileName = "2021_1786.html";
		String sFileName = "";
		
		//sendmail.send( sToAddress, sSubject, sContent, sFilePath, sFileName );
		try {
			String sRet = sendmail.send( sFromName, sFromAddress, sToAddress, sSubject, sContent, sFilePath, sFileName );			
			System.out.println( "sRet : "+sRet );
		} catch (ServiceException e) {
			System.out.println("Send Error : " + e.getMessage() );
		}
	}
	*/
	
}
