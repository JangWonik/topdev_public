package kr.co.toplac.util.ftp;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.SocketException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPFile;
import org.apache.commons.net.ftp.FTPReply;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;



@Controller
public class FtpControll {
	
	private static final Logger logger = LoggerFactory.getLogger(FtpControll.class);
	/*삼성 FTP ip :*/

	private static String FTP_IP = "1.224.84.89";
	private static String FTP_ID = "samsungsurvey";
    private static String FTP_PWD = "sam09070907";
    private static String REMOTE_DIR = "/samsung/get"; //원격피씨의 경로 : 삼성에서 보낸 적부파일(txt)이 들어있음
    //public static String LOCAL_DIR = "/samsung/tmp";  //로컬피씨의 경로 : 삼성에서 보낸 적부파일(txt)을 가져와 로컬에 저장되는 경로 , 이 파일로 적부 일괄 등록 수행
    public static String LOCAL_DIR = "/home/hosting_users/toplac/www/ls_contract/tmp/";  //운영서버의 임시 폴더로 변경.. 171229
    public static String RS_DIR = "/samsung/send";    //응답전문 출력시 업로드 되는 삼성 적부 피씨의 경로
    public static String IMG_DIR = "/samsung/IMG";    //이미지 파일 전송 시 삼성 적부 피씨에 저장되는 경로
    public static String IMG_TMP = "/home/hosting_users/toplac/www/ls_contract/tmp/";    //이미지 파일 전송 시 로컬 피씨에 일시적으로 저장되는 경로 : 업로드 직후 지움
	
	/*
	private static String FTP_IP = "10.50.51.173";
	private static String FTP_ID = "toptest";
    private static String FTP_PWD = "toptest";
    private static String REMOTE_DIR = "/samsung/get"; //원격피씨의 경로 : 삼성에서 보낸 적부파일(txt)이 들어있음
    public static String LOCAL_DIR = "/samsung/tmp";  //로컬피씨의 경로 : 삼성에서 보낸 적부파일(txt)을 가져와 로컬에 저장되는 경로 , 이 파일로 적부 일괄 등록 수행
    public static String RS_DIR = "/samsung/send";    //응답전문 출력시 업로드 되는 삼성 적부 피씨의 경로
    public static String IMG_DIR = "/samsung/IMG";    //이미지 파일 전송 시 삼성 적부 피씨에 저장되는 경로
    public static String IMG_TMP = "/home/hosting_users/toplac/www/ls_contract/tmp/";    //이미지 파일 전송 시 로컬 피씨에 일시적으로 저장되는 경로 : 업로드 직후 지움
	*/
	
	/*삼성 적부 피씨의 파일 존재 여부 확인 후 파일 목록 문자열 배열로 내보내기*/
	public static String[] bGetFTPFiles(FTPClient ftpClient){
		
		String[] arr = null;
		
        try {
            ftpClient.changeWorkingDirectory(REMOTE_DIR);
            doLog("" + ftpClient.printWorkingDirectory());
            FTPFile[] fList = ftpClient.listFiles();
            
            int cnt =0;
            for (int i = 0; i < fList.length; i++) {
            	if(fList[i].getName().toLowerCase().endsWith(".txt")){
            		cnt++;
            	}
			}
            
            if(fList != null){
            	arr = new String[cnt];
            	
            	if (fList == null || fList.length < 1) {
            		return null;
            	}else{
            		String tmpFileName = null;
            		// 대상파일 찾기(txt파일만)
            		int j=0;
            		for (int i = 0; i < fList.length; i++) {
            			if (fList[i] != null) {
            				tmpFileName = fList[i].getName();
            				if (tmpFileName.toLowerCase().endsWith(".txt"))
            				{
            					arr[j] = (tmpFileName);
            					j++;
            					//doLog("---> " + tmpFileName);
            				}
            			}
            		}
            	}
            }
        } catch (Exception e) {
            doLog("bGetFTPFiles Exception :");
            e.printStackTrace();
            return null;
        }
        return arr;
    }
	
	/*삼성 적부 피씨의 파일 존재 여부 확인 후 플래그에 따라 다운로드 할지 결정*/
	public static String[] bGetFTPFiles(FTPClient ftpClient, String[] arr, boolean downFlag/*, String[] successFlag*/  )
    {
		
		logger.info("bGetFTPFiles");
		
        try {
            ftpClient.changeWorkingDirectory(REMOTE_DIR);
            //doLog("" + ftpClient.printWorkingDirectory());
            FTPFile[] fList = ftpClient.listFiles();
            
            int cnt =0;
            for (int i = 0; i < fList.length; i++) {
            	if(fList[i].getName().toLowerCase().endsWith(".txt")){
            		cnt++;
            	}
			}
            
            if (fList == null || fList.length < 1) {
                //doLog(" stop : cause - file not existed!!!");
                return null;
            } else {
                // Get FileList && Find Target file
                //ArrayList targetList = new ArrayList();
                String tmpFileName = null;
                arr = new String[cnt];
                // 대상파일 찾기(txt파일만)
                int k=0;
                for (int i = 0; i < fList.length; i++) {
                    if (fList[i] != null) {
                        tmpFileName = fList[i].getName();
                        if (tmpFileName.toLowerCase().endsWith(".txt"))
                        {
                        	arr[k] = (tmpFileName);
                        	k++;
                            //doLog("---> " + tmpFileName);
                        }
                    }
                }
                
                if(downFlag){
                	if (arr.length < 1) {
                		return null;
                	} else {
                		//boolean downSuccessResult = false;
                		for (int j = 0; j < arr.length; j++) {
                			String strFileName = arr[j];
                			// File Download
                			/*downSuccessResult = doGetFile(ftpClient, strFileName, strFileName);*/
                			doGetFile(ftpClient, strFileName.trim(), strFileName.trim());
                			/*if(downSuccessResult){
                				successFlag[j] = "1";
                			}else{
                				successFlag[j] = "0";
                			}*/
                		}
                	}                	
                }
            }
        } catch (Exception e) {
            doLog("bGetFTPFiles Exception :");
            e.printStackTrace();
            return null;
        }
        return arr;
    }
	
	
	 /**
     * FTP 파일수신(get)
     * @param ftpClient FTP커넷션
     * @param strFromFileNm 대상파일명
     * @param strToFileNm 수신 신규파일명
     * @return
     */
    public static boolean doGetFile(FTPClient ftpClient, String strFromFileNm, String strToFileNm) {
    	
    	logger.info("doGetFile");
    	
        boolean result = true;
        try {
            File get_file = new File(LOCAL_DIR + "/" + strToFileNm);
            
            OutputStream outputStream = new FileOutputStream(get_file);
            result = ftpClient.retrieveFile(strFromFileNm, outputStream);
            //doLog(" doGetFile :" + strFromFileNm + " / " + strToFileNm + " " + result);
            outputStream.close();
        } catch (Exception e) {
            //doLog("doGetFile Exception :");
            e.printStackTrace();
            return result;
        }
        return result;
    }
	
	 /**
     * 로그남기기
     * @param message
     */
    public static void doLog(Object message) {
        System.out.println(CURRENT_DATETIME() + " : [Top User FtpClient]: " + message.toString());
    }
    
    /**
     * 현재시간 추출
     * @return
     */
    public static String CURRENT_DATETIME()
    {
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        Date currentdate = cal.getTime();
        return String.valueOf(formatter.format(currentdate));
    }
 
    /*삼성 적부 시스템 파일 존재 여부 검출 및 파일 목록 반환*/
    @RequestMapping(value = "getSamsungFtpFileCount", method = RequestMethod.POST)
	public void getSamsungFtpFileCount(PrintWriter out, int downFlag) {
    	
    	logger.info("getSamsungFtpFileCount");
    	
    	FTPClient ftpClient = new FTPClient();
    	
    	try {
    		
			 ftpClient.connect(FTP_IP);
			 int reply = ftpClient.getReplyCode();
			 
			 if (!FTPReply.isPositiveCompletion(reply)) {
				 out.print("fail");
				 ftpClient.disconnect();
				 doLog(">> FTP server refused connection.");
			 }else{
				
				ftpClient.login(FTP_ID, FTP_PWD);
                ftpClient.enterLocalActiveMode();
                //ftpClient.setSoTimeout(10000); //Wait time - 10second
                
                if(downFlag > 0){
                	
                }else{
                	String[] arrTmp = bGetFTPFiles(ftpClient);
                	JSONArray jsonArr = new JSONArray();
                	String jsonStr = null;
                	
                	if (arrTmp.length > 0){
                		
                		for(int i=0; i < arrTmp.length; i++){
                			
                			JSONObject obj = new JSONObject();
                			
                			obj.put("file", arrTmp[i]);
                			jsonArr.add(obj);
                		}
                		
                		jsonStr = jsonArr.toString();
                		ftpClient.disconnect();
                		out.print(jsonStr);
                	}else{
                		ftpClient.disconnect(); 
                		out.print(jsonStr);
                	}                	
                }
			 }
		} catch (SocketException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    /**
     * 삼성 적부 수임 등록 실행 전단계 : 커넥션/파일읽기
     * @return
     */
    @SuppressWarnings("null")
	public static String[] getSSFileInfo()
    {
    	logger.info("getSSFileInfo");
    	
    	FTPClient ftpClient = new FTPClient();
    	String[] fileNameList = null;
    	try {
    		
			 ftpClient.connect(FTP_IP);
			 int reply = ftpClient.getReplyCode();
			 
			 if (!FTPReply.isPositiveCompletion(reply)) {
	           ftpClient.disconnect();
	           doLog(">> FTP server refused connection.");
			 }else{
				
				 ftpClient.login(FTP_ID, FTP_PWD);
				 ftpClient.enterLocalActiveMode();
				 ftpClient.setSoTimeout(10000); //Wait time - 10second
				 
				 fileNameList = bGetFTPFiles(ftpClient,fileNameList,true);
				 ftpClient.disconnect();
			 }
		} catch (SocketException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        return fileNameList;        
    }
    
    public static int upload(String localFilePath, String remoteFilePath, String fileName, HttpServletRequest request) throws Exception {
    	  
    	  FTPClient ftp = null; // FTP Client 객체
    	  FileInputStream fis = null; // File Input Stream
    	  File uploadfile = new File(localFilePath); // File 객체
    	  
    	  String url  = FTP_IP ;  
    	  String id  = FTP_ID ;
    	  String pwd  = FTP_PWD ; 
    	  String port = "21";

    	  int result = -1;

    	  try{          
    	      ftp = new FTPClient(); // FTP Client 객체 생성
    	      ftp.setControlEncoding("UTF-8"); // 문자 코드를 UTF-8로 인코딩
    	      ftp.connect(url, Integer.parseInt(port)); // 서버접속 " "안에 서버 주소 입력 또는 "서버주소", 포트번호
    	      ftp.login(id, pwd); // FTP 로그인 ID, PASSWORLD 입력
    	      ftp.enterLocalPassiveMode(); // Passive Mode 접속일때 
    	      ftp.changeWorkingDirectory(remoteFilePath); // 작업 디렉토리 변경
    	      ftp.setFileType(FTP.BINARY_FILE_TYPE); // 업로드 파일 타입 셋팅
    	      
    	      try{
    	          fis = new FileInputStream(uploadfile); // 업로드할 File 생성
    	          boolean isSuccess = ftp.storeFile(fileName, fis); // File 업로드
    	          
    	          if (isSuccess){
    	     result = 1; // 성공     
    	    }
    	    else{
    	     throw new Exception("파일 업로드를 할 수 없습니다.");
    	    }
    	      } catch(IOException ex){
    	          System.out.println("IO Exception : " + ex.getMessage());
    	      }finally{
    	          if (fis != null){
    	              try{
    	                  fis.close(); // Stream 닫기
    	                  return result;
    	                  
    	              }
    	              catch(IOException ex){
    	                  System.out.println("IO Exception : " + ex.getMessage());
    	              }
    	          }
    	      }
    	      ftp.logout(); // FTP Log Out
    	  }catch(IOException e){
    	      System.out.println("IO:"+e.getMessage());
    	  }finally{
    	      if (ftp != null && ftp.isConnected()){
    	          try{
    	              ftp.disconnect(); // 접속 끊기
    	              return result;
    	          }
    	          catch (IOException e){
    	              System.out.println("IO Exception : " + e.getMessage());
    	          }
    	      }
    	  }
    	  return result;  
    	 }
}
