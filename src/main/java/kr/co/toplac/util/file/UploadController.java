package kr.co.toplac.util.file;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.toplac.topteam.TopMbrBscVO;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import kr.co.toplac.topsuim.TopRptCtrlAllBean;
import kr.co.toplac.topsuim.TopRptLogFileVO;
import kr.co.toplac.topteam.TopMbrSgnVO;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.ftp.FtpControll;

@Controller
public class UploadController {
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final Logger logger = LoggerFactory.getLogger(UploadController.class);
    private static final String UPLOAD_PATH = "/home/hosting_users/toplac/www/";
    //private static final String UPLOAD_PATH = "/Users/kohyeonseok/devroot/91.devUpload/toplac/hosting_users/toplac/www/";
    private static final String UPLOAD_PATH_MMS = "/home/hosting_users/toplac/www/ls_data/member_mms/";
    //private static final String UPLOAD_PATH_MMS = "/Users/kohyeonseok/devroot/91.devUpload/toplac/hosting_users/toplac/www/ls_data/member_mms/";

	/** 이미지/파일 올리기 **/
	@RequestMapping(value = "upload", method = RequestMethod.POST)
	public void upload(Model model, HttpServletRequest req , MultipartRequest request, PrintWriter out,
			String no, int gubun, int imgpage, int func, String id, String rptSiteNo, String suimRptNo, 
			String rptSiteImgExplain, String rptprint1ImgExplain, String imgRank, String cost_deposit_no, String interimFlag) throws IOException { //param

		String filekind = "";
		String funckind = "";
		String uppath = null;
		int result = 0;
		
		/*********************** 파일 종류 구분 ***********************/
		switch (gubun) {
		case 0:
			filekind ="img";
			break;
		case 1:
			filekind ="file";
			break;
		case 2:
			filekind ="composite";
			break;
		}		
		
		/*********************** 파일명 생성 ***********************/
		MultipartFile file = request.getFile("attchFile");
		Date today = new Date();//오늘날자구하기
		DateFormat timeForNaming = new SimpleDateFormat("yyyyMMddHHmmss");
		String sigan = timeForNaming.format(today);//String형으로 변환
		String year = sigan.substring(0, 4);
		String month = sigan.substring(4, 6);
		String day = sigan.substring(6, 8);
		
		int isSecure = 0;		//파일 암호화 상태 여부 (0:평문, 1:암호화파일)
		
		//파일 정보 확인
		String secuMsg = "This document is protected by ShadowCube Tech. & Policies.";
		String sContent = new String(file.getBytes()).substring(0,100);
		//logger.info("file info start :"+sContent);
		
		if( sContent.contains(secuMsg) ) {
			isSecure = 1;
		}else{
			isSecure = 0;
		}
		
		String fileName = file.getOriginalFilename();
		String fileName2 = fileName.substring(0, fileName.lastIndexOf(".")); //파일명 한글 입력 시, 워드 출력상 엑박 표기 되는 경우 있어 주석처리함 by lds, 171226
		String fileType = fileName.substring(fileName.lastIndexOf("."), fileName.length());
		//암호화 된 8자리 값 생성
		String uid = UUID.randomUUID().toString().replaceAll("-", "").substring(0, 8);
		
		String replaceName =  uid + fileType;  //파일 이름의 중복을 막기 위해서 이름을 재설정합니다.
		
		if(filekind.equals("file") ||  filekind.equals("composite")){
			replaceName =  fileName2+fileType;  //파일은 원본명 그대로 올립니다.
		}
		
		if(funckind.equals("suit10Img")){
			replaceName = sigan.substring(0, 8)+"_"+sigan.substring(8, sigan.length())+fileType;
		}
		
		//logger.info("isSecure : "+isSecure);		
		//logger.info("filekind : "+filekind);
		
		//파일 암호화 여부 체크 by top3009
		if( filekind.equals("img") ) {				//이미지(사진,서명) 파일은 암호화 되면 안됨
			if( isSecure == 1 ) {
				out.print(9);							//암호화 오류
				return;
			}
		}else{											//보고서로 제출되는 문서 파일은 암호화 되어야함
			if( isSecure == 0 ) {
				out.print(9);							//암호화 오류
				return;
			}
		}
		
		/*********************** 파일 종류 체크 ***********************/
		boolean checkval = false;
		if(filekind.equals("img")){
			checkval = (fileType.toUpperCase().equals(".JPG") || fileType.toUpperCase().equals(".JPEG") || fileType.toUpperCase().equals(".GIF") || fileType.toUpperCase().equals(".PNG") || fileType.toUpperCase().equals(".BMP"));
		}else if(filekind.equals("file")){
			checkval = (fileType.toUpperCase().equals(".PDF") || fileType.toUpperCase().equals(".XLS") || fileType.toUpperCase().equals(".DOC") || fileType.toUpperCase().equals(".HWP")
					|| fileType.toUpperCase().equals(".DOCX") || fileType.toUpperCase().equals(".XLSX"));
		}else if(filekind.equals("composite")){
			checkval = (fileType.toUpperCase().equals(".PDF") || fileType.toUpperCase().equals(".XLS") || fileType.toUpperCase().equals(".DOC") || fileType.toUpperCase().equals(".HWP"))
					|| (fileType.toUpperCase().equals(".JPG") || fileType.toUpperCase().equals(".GIF") || fileType.toUpperCase().equals(".PNG") || fileType.toUpperCase().equals(".BMP")
							|| fileType.toUpperCase().equals(".TIF") || fileType.toUpperCase().equals(".DOCX") || fileType.toUpperCase().equals(".XLSX"));
		}
		
		if(checkval == false){
			/* 
			 * 결과 반환 
			 * 1 : 지정된 이미지 종류가 아닐경우 등록 실패
			 * 
			 * */
			out.print(1);
			return;
		}
		
		int nextRptSiteImgNo = 0;
		int nextRptFileSerial = 0;
		int nextPrimBizRptFileSerial =0;
		int nextMyCostBillFileSerial = 0;
		int nextRptPrint1ImgSerial = 0;
		int nextRptSuit10ImgSerial = 0;
		int nextRptSuit18ImgSerial = 0;
		int nextRptSuit18ImgSendSerial = 0;
		int nextSuimSuit17RptFileSerial = 0;
		int nextSuimSuit12RptFileSerial = 0;
		
		/******************************실제 파일 업로드 및 DB********************************/
		if (func == 0){//My Menu > 정보수정 > 내사진 수정  @@@DB에 file path 없음@@@
			/*기존 내사진 제거*/
			String myOldPicName = sqlSession.selectOne("MbrStatListMapper.mypicture", no);
			String myOldPic = uppath + "/" + myOldPicName;
			//파일 삭제 시작
			if(myOldPicName != ""){
				if(myOldPic != ""){
					File tmpFile = new File(myOldPic);
					tmpFile.delete();

				}
			}
			//파일 삭제 종료
			
			uppath = "/home/hosting_users/toplac/www/ls_data/member/";
			replaceName = no + fileType;
			
			localUploadFunc(file, uppath, replaceName, func);
			
			/******************************파일명 DB 등록 시작********************************/
			
			/*새로운 사진 업데이트*/
			HashMap<String,String> map =  new HashMap<String,String>();
			map.put("user_no", no);
			map.put("filename", replaceName);
			result = sqlSession.update("MbrStatListMapper.myimageup", map);
			/******************************파일명 DB 등록 끝********************************/	
			
		}else if (func == 1){//My Menu > 정보수정 > 도장 및 사인   @@@DB에 file path 없음@@@
			uppath = "/home/hosting_users/toplac/www/ls_data/member_sign/"+no+"/";
			replaceName = sigan + fileType;  //파일 이름의 중복을 막기 위해서 이름을 재설정합니다.
			localUploadFunc(file, uppath, replaceName, func);
			/******************************파일명 DB 등록 시작********************************/
			HashMap<String,String> map =  new HashMap<String,String>();
			map.put("user_no", no);
			map.put("filename", replaceName);
			
			result = sqlSession.insert("MbrStatListMapper.mysignup", map);
			/******************************파일명 DB 등록 끝********************************/			
			
		}else if (func == 2){//관리자 - 보험사 관리 - 보험사 정보수정 - 로고 소  @@@DB에 file path 없음@@@
			/*기존 보험사 작은 사진 제거*/
			String oldSmallImgName = sqlSession.selectOne("PtnrMngUdtMapper.getSmallImgName", id);
			String oldImg = uppath + "/" + oldSmallImgName;
			
			//파일 삭제 시작
			if(oldSmallImgName != ""){
				if(oldImg != ""){
					File tmpFile = new File(oldImg);
					tmpFile.delete();
				}
			}
			//파일 삭제 종료
			
			uppath = "/home/hosting_users/toplac/www/ls_data/ig/small";
			replaceName = id + "_s" + fileType;
			localUploadFunc(file, uppath, replaceName, func);
			
			/******************************파일명 DB 등록 시작********************************/
			HashMap<String,String> map =  new HashMap<String,String>();
			map.put("ptnr_id", id);
			map.put("filename", replaceName);
			
			result = sqlSession.update("PtnrMngUdtMapper.sImgUp", map);
			/******************************파일명 DB 등록 끝********************************/		
			
		}else if (func == 3){//관리자 - 보험사 관리 - 보험사 정보수정 - 로고 대   @@@DB에 file path 없음@@@
			/*기존 보험사 작은 사진 제거*/
			String oldSmallImgName = sqlSession.selectOne("PtnrMngUdtMapper.getBigImgName", id);
			String oldImg = uppath + "/" + oldSmallImgName;
			
			//파일 삭제 시작
			if(oldSmallImgName != ""){
				if(oldImg != ""){
					File tmpFile = new File(oldImg);
					tmpFile.delete();
				}
			}
			//파일 삭제 종료
			
			uppath = "/home/hosting_users/toplac/www/ls_data/ig/large";
			replaceName = id + "_l" + fileType;
			localUploadFunc(file, uppath, replaceName, func);
			
			/******************************파일명 DB 등록 시작********************************/
			HashMap<String,String> map =  new HashMap<String,String>();
			map.put("ptnr_id", id);
			map.put("filename", replaceName);
			
			result = sqlSession.update("PtnrMngUdtMapper.bImgUp", map);
			/******************************파일명 DB 등록 끝********************************/	
			
		}else if(func == 4){// 수임대장 > 현장보고서 이미지   
			//1.Dummy 컬럼 insert를 통해 다음 순서 번호 알아내기.
			HashMap<String,String> map =  new HashMap<String,String>();
			map.put("rptSiteNo", suimRptNo);
			map.put("imgSubject", "");
			map.put("imgName", "");
			map.put("imgPath", "");
			map.put("primaryKey", "");
			sqlSession.insert("SuimRptSiteMapper.insImg", map); //dummy data 삽입
			nextRptSiteImgNo= Integer.parseInt(map.get("primaryKey"));
			
			System.out.println("interimFlag : "+interimFlag);
			
			//2. 파일 업로드 경로 설정 및 파일 업로드
			if (interimFlag.equals("site")){
				uppath = "/home/hosting_users/toplac/www/ls_data/report_other/site/"+year+"/"+month+"/"+day+"/"+rptSiteNo+"/";
			}else {
				uppath = "/home/hosting_users/toplac/www/ls_data/report_other/interim/"+year+"/"+month+"/"+day+"/"+rptSiteNo+"/";
			}
			replaceName = sigan + fileType;
			
			localUploadFunc(file, uppath, replaceName, func);
			
			//3. Dummy 컬럼의 Data를 실제 Data로 Update 및 마무리
			/******************************파일명 DB 등록 시작********************************/
			
			if (interimFlag.equals("site")){
				uppath = "/ls_data/report_other/site/"+year+"/"+month+"/"+day+"/"+rptSiteNo+"/";
			}else {
				uppath = "/ls_data/report_other/interim/"+year+"/"+month+"/"+day+"/"+rptSiteNo+"/";
			}
			
			map.put("rptSiteNo", rptSiteNo);
			map.put("imgPath", uppath);
			map.put("imgName", replaceName);
			map.put("imgSubject", rptSiteImgExplain);
			map.put("nextRptSiteImgNo", ""+nextRptSiteImgNo);
			result = sqlSession.update("SuimRptSiteMapper.udtImg", map); //실 data로 update
			/******************************파일명 DB 등록 끝********************************/		
			/*반환할 현재시간 (yyyy-mm-dd) 형태*/
			timeForNaming = new SimpleDateFormat("yyyy-MM-dd");
			sigan = timeForNaming.format(today);
			
		}else if(func == 5){//수임대장 > 현장, 중간보고서 파일
			//현장 중간 보고서 파일의 경우 update로직이므로 dummy 작업이 필요없음.
			//2. 파일 업로드 경로 설정 및 파일 업로드
			if (interimFlag.equals("site")){
				uppath = "/home/hosting_users/toplac/www/ls_data/report_other/site/"+year+"/"+month+"/"+day+"/"+rptSiteNo+"/";
			}else {
				uppath = "/home/hosting_users/toplac/www/ls_data/report_other/interim/"+year+"/"+month+"/"+day+"/"+rptSiteNo+"/";
			}
			localUploadFunc(file, uppath, replaceName, func);
			/******************************파일명 DB 등록 시작********************************/
			
			if (interimFlag.equals("site")){
				uppath = "/ls_data/report_other/site/"+year+"/"+month+"/"+day+"/"+rptSiteNo+"/";
			}else {
				uppath = "/ls_data/report_other/interim/"+year+"/"+month+"/"+day+"/"+rptSiteNo+"/";
			}
			HashMap<String,String> map =  new HashMap<String,String>();
			map.put("rptSiteNo", rptSiteNo);
			map.put("path", uppath);
			map.put("filename", replaceName);
			
			result = sqlSession.update("SuimRptSiteMapper.insSiteInterimFile", map);
			/******************************파일명 DB 등록 끝********************************/
			
			/*반환할 현재시간 (yyyy-mm-dd) 형태*/
			timeForNaming = new SimpleDateFormat("yyyy-MM-dd");
			sigan = timeForNaming.format(today);
		
		}else if(func == 6){//수임대장 > 보고서 원본파일
			//1.Dummy 컬럼 insert를 통해 다음 순서 번호 알아내기.
			HashMap<String,String> map =  new HashMap<String,String>();
			map.put("suimRptNo", suimRptNo);
			map.put("fileName", "");
			map.put("filePath", "");
			map.put("primaryKey", "");
			sqlSession.insert("SuimBookUdtMapper.rptOrgFileUploadForSelectKey", map); //dummy data 삽입
			nextRptFileSerial= Integer.parseInt(map.get("primaryKey"));
			
			//2. 파일 업로드 경로 설정 및 파일 업로드
			uppath = "/home/hosting_users/toplac/www/ls_report_d/"+year+"/"+month+"/"+day+"/"+suimRptNo+"/";
			localUploadFunc(file, uppath, replaceName, func);
			
			//3. Dummy 컬럼의 Data를 실제 Data로 Update 및 마무리
			/******************************파일명 DB 등록 시작********************************/
			uppath = "/ls_report_d/"+year+"/"+month+"/"+day+"/"+suimRptNo+"/";
			map.put("suimRptNo", suimRptNo);
			map.put("filePath", uppath);
			map.put("fileName", replaceName);
			map.put("nextRptFileSerial", ""+nextRptFileSerial);
			result = sqlSession.update("SuimBookUdtMapper.rptOrgFileUploadForUpdate", map); //실 data로 update
			/******************************파일명 DB 등록 끝********************************/		
			/*반환할 현재시간 (yyyy-mm-dd) 형태*/
			timeForNaming = new SimpleDateFormat("yyyy-MM-dd");
			sigan = timeForNaming.format(today);
			
		}else if (func == 7){//협조건 첨부파일
			uppath = "/home/hosting_users/toplac/www/ls_data/help/"+year+"/"+month+"/"+day+"/"+no+"/";
			localUploadFunc(file, uppath, replaceName, func);
			
			/******************************파일명 DB 등록 시작********************************/
			uppath = "/ls_data/help/"+year+"/"+month+"/"+day+"/"+no+"/";
			HashMap<String,String> map =  new HashMap<String,String>();
			map.put("serialNo", no);
			map.put("filePath", uppath);
			map.put("fileName", replaceName);
			
			result = sqlSession.update("HelpBscMapper.helpFileUp", map);
			/******************************파일명 DB 등록 끝********************************/
			
		}else if(func == 8){//농작물 보고서 원본 file
			HashMap<String,String> map =  new HashMap<String,String>();
			map.put("suimRptNo", suimRptNo);
			map.put("filePath", "");
			map.put("fileName", "");
			map.put("primaryKey", "");
			sqlSession.insert("PrimBizSuimUdtMapper.primBizRptOrgFileUploadForSelectKey", map);
			nextPrimBizRptFileSerial = Integer.parseInt(map.get("primaryKey"));
			uppath = "/home/hosting_users/toplac/www/nsc_report_d/"+year+"/"+month+"/"+day+"/"+suimRptNo+"/";
			
			localUploadFunc(file, uppath, replaceName, func);
			/******************************파일명 DB 등록 시작********************************/
			uppath = "/nsc_report_d/"+year+"/"+month+"/"+day+"/"+suimRptNo+"/";
			map.put("suimRptNo", suimRptNo);
			map.put("nextPrimBizRptFileSerial", ""+nextPrimBizRptFileSerial);
			map.put("filePath", uppath);
			map.put("fileName", replaceName);
			result = sqlSession.update("PrimBizSuimUdtMapper.primBizRptOrgFileUpload", map);
			/******************************파일명 DB 등록 끝********************************/
			/*반환할 현재시간 (yyyy-mm-dd) 형태*/
			timeForNaming = new SimpleDateFormat("yyyy-MM-dd");
			sigan = timeForNaming.format(today);
			
		}else if(func == 9){//경비내역 > 영수증 업로드
			//1.Dummy 컬럼 insert를 통해 다음 순서 번호 알아내기.
			HashMap<String,String> map =  new HashMap<String,String>();
			System.out.println("cost_deposit_no : "+ cost_deposit_no);
			map.put("cost_deposit_no", cost_deposit_no);
			map.put("filePath", "");
			map.put("fileName", "");
			
			result = sqlSession.insert("MyCostUdt.myCostBillFileUploadForSelectKey", map);
			nextMyCostBillFileSerial= Integer.parseInt(map.get("primaryKey"));
			
			//2. 파일 업로드 경로 설정 및 파일 업로드
			uppath = "/home/hosting_users/toplac/www/ls_data/cost/"+year+"/"+month+"/"+day+"/"+cost_deposit_no+"/";
			
			localUploadFunc(file, uppath, replaceName, func);
			
			//3. Dummy 컬럼의 Data를 실제 Data로 Update 및 마무리
			/******************************파일명 DB 등록 시작********************************/
			uppath = "/ls_data/cost/"+year+"/"+month+"/"+day+"/"+cost_deposit_no+"/";
			map.put("cost_deposit_no", cost_deposit_no);
			map.put("filePath", uppath);
			map.put("fileName", replaceName);
			map.put("nextMyCostBillFileSerial", ""+nextMyCostBillFileSerial);
			result = sqlSession.update("MyCostUdt.myCostBillFileUpload", map); //실 data로 update
			
			/******************************파일명 DB 등록 끝********************************/		
			/*반환할 현재시간 (yyyy-mm-dd) 형태*/
			timeForNaming = new SimpleDateFormat("yyyy-MM-dd");
			sigan = timeForNaming.format(today);
			
		}else if(func == 10){ // 수임대장(4종) - 보고서 작성 > 첨부사진
			//1.Dummy 컬럼 insert를 통해 다음 순서 번호 알아내기.
			HashMap<String,String> map =  new HashMap<String,String>();
			map.put("suimRptNo", suimRptNo);
			map.put("filePath", "");
			map.put("imgName", "");
			map.put("imgRank", imgRank);
			map.put("imgMemo", rptprint1ImgExplain);
			map.put("primaryKey", "");
			sqlSession.insert("SuimRptBodyMapper.insNewPrint1ImgForKey", map); //dummy data 삽입
			nextRptPrint1ImgSerial = Integer.parseInt(map.get("primaryKey"));
			
			//2. 파일 업로드 경로 설정 및 파일 업로드
			uppath = "/home/hosting_users/toplac/www/ls_report_d/"+year+"/"+month+"/"+day+"/"+suimRptNo+"/img/";
			
			replaceName = sigan + fileType;
			localUploadFunc(file, uppath, replaceName, func);
			
			//3. Dummy 컬럼의 Data를 실제 Data로 Update 및 마무리
			/******************************파일명 DB 등록 시작********************************/
			uppath = "/ls_report_d/"+year+"/"+month+"/"+day+"/"+suimRptNo+"/img/";
			map.put("filePath", uppath);	
			map.put("imgName", replaceName);
			map.put("nextRptPrint1ImgSerial", ""+nextRptPrint1ImgSerial);
			result = sqlSession.update("SuimRptBodyMapper.insNewPrint1ImgForUpdate", map); //실 data로 update
			/******************************파일명 DB 등록 끝********************************/		
			/*반환할 현재시간 (yyyy-mm-dd) 형태*/
			timeForNaming = new SimpleDateFormat("yyyy-MM-dd");
			sigan = timeForNaming.format(today);
			
		}else if(func == 11){//적부(흥국) - 보고서 > 첨부파일
			
			//1.Dummy 컬럼 insert를 통해 다음 순서 번호 알아내기.
			HashMap<String,String> map =  new HashMap<String,String>();
			map.put("suimRptNo", suimRptNo);
			map.put("filePath", "");
			map.put("fileName", "");
			
			sqlSession.insert("SuimSuit17DtlMapper.suimSuit17RptFileUploadForKey", map); //dummy data 삽입
			nextSuimSuit17RptFileSerial= Integer.parseInt(map.get("primaryKey"));
			
			//2. 파일 업로드 경로 설정 및 파일 업로드
			uppath = "/home/hosting_users/toplac/www/ls_suitability_d/17/"+year+"/"+month+"/"+day+"/"+suimRptNo+"/";
			
			localUploadFunc(file, uppath, replaceName, func);
			
			//3. Dummy 컬럼의 Data를 실제 Data로 Update 및 마무리
			/******************************파일명 DB 등록 시작********************************/
			uppath = "/ls_suitability_d/17/"+year+"/"+month+"/"+day+"/"+suimRptNo+"/";
			map.put("suimRptNo", suimRptNo);
			map.put("filePath", uppath);
			map.put("fileName", replaceName);
			map.put("nextSuimSuit17RptFileSerial", ""+nextSuimSuit17RptFileSerial);
			result = sqlSession.update("SuimSuit17DtlMapper.suimSuit17RptFileUploadForUpdate", map); //실 data로 update
			/******************************파일명 DB 등록 끝********************************/		
			/*반환할 현재시간 (yyyy-mm-dd) 형태*/
			timeForNaming = new SimpleDateFormat("yyyy-MM-dd");
			sigan = timeForNaming.format(today);
			
		}else if(func == 12){//적부(KB) - 보고서 > 실사사진
			//1.Dummy 컬럼 insert를 통해 다음 순서 번호 알아내기.
			HashMap<String,String> map =  new HashMap<String,String>();
			map.put("suimRptNo", suimRptNo);
			map.put("filePath", "");
			map.put("fileName", "");
			
			sqlSession.insert("Suit10Mapper.suimSuit10ImgUploadForKey", map); //dummy data 삽입
			nextRptSuit10ImgSerial= Integer.parseInt(map.get("primaryKey"));
			
			//2. 파일 업로드 경로 설정 및 파일 업로드
			uppath = "/home/hosting_users/toplac/www/ls_suitability_d/"+year+"/"+month+"/"+day+"/"+suimRptNo+"/";
			
			localUploadFunc(file, uppath, replaceName, func);
			
			//3. Dummy 컬럼의 Data를 실제 Data로 Update 및 마무리
			/******************************파일명 DB 등록 시작********************************/
			uppath = "/ls_suitability_d/"+year+"/"+month+"/"+day+"/"+suimRptNo+"/";
			map.put("suimRptNo", suimRptNo);
			map.put("filePath", uppath);
			map.put("fileName", replaceName);
			map.put("nextRptSuit10ImgSerial", ""+nextRptSuit10ImgSerial);
			result = sqlSession.update("Suit10Mapper.suimSuit10ImgUploadForUpdate", map); //실 data로 update
			/******************************파일명 DB 등록 끝********************************/		
			
			/*반환할 현재시간 (yyyy-mm-dd) 형태*/
			timeForNaming = new SimpleDateFormat("yyyy-MM-dd");
			sigan = timeForNaming.format(today);
			
		}else if(func == 13){ //적부(한화) - 보고서 > 첨부파일
			//1.Dummy 컬럼 insert를 통해 다음 순서 번호 알아내기.
			HashMap<String,String> map =  new HashMap<String,String>();
			map.put("suimRptNo", suimRptNo);
			map.put("filePath", "");
			map.put("fileName", "");
			
			sqlSession.insert("SuimSuit12DtlMapper.suimSuit12RptFileUploadForKey", map); //dummy data 삽입
			nextSuimSuit12RptFileSerial= Integer.parseInt(map.get("primaryKey"));
			
			//2. 파일 업로드 경로 설정 및 파일 업로드
			uppath = "/home/hosting_users/toplac/www/ls_suitability_d/12/"+year+"/"+month+"/"+day+"/"+suimRptNo+"/";
			
			localUploadFunc(file, uppath, replaceName, func);
			
			//3. Dummy 컬럼의 Data를 실제 Data로 Update 및 마무리
			/******************************파일명 DB 등록 시작********************************/
			uppath = "/ls_suitability_d/12/"+year+"/"+month+"/"+day+"/"+suimRptNo+"/";
			map.put("suimRptNo", suimRptNo);
			map.put("filePath", uppath);
			map.put("fileName", replaceName);
			map.put("nextSuimSuit12RptFileSerial", ""+nextSuimSuit12RptFileSerial);
			result = sqlSession.update("SuimSuit12DtlMapper.suimSuit12RptFileUploadForUpdate", map); //실 data로 update
			/******************************파일명 DB 등록 끝********************************/		
			/*반환할 현재시간 (yyyy-mm-dd) 형태*/
			timeForNaming = new SimpleDateFormat("yyyy-MM-dd");
			sigan = timeForNaming.format(today);
			
			
		}else if(func == 14){//적부(삼성) - 보고서 > 실사사진
			//1.Dummy 컬럼 insert를 통해 다음 순서 번호 알아내기.
			HashMap<String,String> map =  new HashMap<String,String>();
			map.put("suimRptNo", suimRptNo);
			map.put("filePath", "");
			map.put("fileName", "");
			
			sqlSession.insert("Suit18Mapper.suimSuit18ImgUploadForKey", map); //dummy data 삽입
			nextRptSuit18ImgSerial= Integer.parseInt(map.get("primaryKey"));
			
			//2. 파일 업로드 경로 설정 및 파일 업로드
			uppath = "/home/hosting_users/toplac/www/ls_contract_d/"+year+"/"+month+"/"+day+"/"+suimRptNo+"/";
			
			localUploadFunc(file, uppath, replaceName, func);
			
			//3. Dummy 컬럼의 Data를 실제 Data로 Update 및 마무리
			/******************************파일명 DB 등록 시작********************************/
			uppath = "/ls_contract_d/"+year+"/"+month+"/"+day+"/"+suimRptNo+"/";
			map.put("suimRptNo", suimRptNo);
			map.put("filePath", uppath);
			map.put("fileName", replaceName);
			map.put("nextRptSuit18ImgSerial", ""+nextRptSuit18ImgSerial);
			result = sqlSession.update("Suit18Mapper.suimSuit18ImgUploadForUpdate", map); //실 data로 update
			/******************************파일명 DB 등록 끝********************************/		
			
			/*반환할 현재시간 (yyyy-mm-dd) 형태*/
			timeForNaming = new SimpleDateFormat("yyyy-MM-dd");
			sigan = timeForNaming.format(today);
			
		}else if(func == 15){//삼성(적부) - 이미지 올리기
			uppath = "/home/hosting_users/toplac/www/ls_contract/tmp/";
			
			/******************************파일명 DB 등록 시작********************************/
			HashMap<String,String> map =  new HashMap<String,String>();
			map.put("suimRptNo", suimRptNo);
			
			int codeNum = sqlSession.selectOne("Suit18Mapper.getCodeNum", suimRptNo);
			String entyDsgnNo = sqlSession.selectOne("Suit18Mapper.getEntyDsgnNo", suimRptNo);
			String codeNumStr = "";
			if(Integer.toString(codeNum).length() == 1){
				codeNumStr = "000"+Integer.toString(codeNum);
			}else if(Integer.toString(codeNum).length() == 2){
				codeNumStr = "00"+Integer.toString(codeNum);
			}else if(Integer.toString(codeNum).length() == 3){
				codeNumStr = "0"+Integer.toString(codeNum);
			}
			
			DateFormat timeForSamsungSend = new SimpleDateFormat("yyyyMMdd");
			String sendDay = timeForSamsungSend.format(today);//String형으로 변환
			
			replaceName = entyDsgnNo+"70990890A0A032"+ codeNumStr+"_"+sendDay+".jpg";
			
			map.put("fileName", replaceName);
			
			localUploadFunc(file, uppath, replaceName, func);
			
			result = sqlSession.insert("Suit18Mapper.insNewSuit18ImgSend", map);
			/******************************파일명 DB 등록 끝********************************/
			
			/*Todo : 보내기 전 파일과 전송 후 파일의 사이즈를 비교하여 스테이트 값을 업데이트 한다*/
			/*if($file_size==$send_size){
				mysql_query("update ls_contract_img set state='1' where no='$no'") or die(mysql_error());
			}*/
			
			/*Todo : ftp 전송 구현*/
			/*삼성 적부 피씨로 업로드*/
			
			try {
				FtpControll.upload(uppath + replaceName, FtpControll.IMG_DIR, replaceName, req);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				result = 1;
				e.printStackTrace();
			}
			
			//임시 파일 삭제 시작
			if(replaceName != ""){
					/*파일삭제*/
					File tmpFile = new File(uppath + replaceName);
					tmpFile.delete();
						
			}
			//파일 삭제 종료
		}else if(func == 16){ //  My Menu > 정보수정 > MMS 사진 수정  @@@DB에 file path 없음@@@

			//===========================================================
            //  저장될 파일 위치 설정
            //===========================================================
            uppath = UPLOAD_PATH_MMS;

            //===========================================================
            //  파일 이름 설정
            //===========================================================
			replaceName = no + fileType;

            //===========================================================
            //  업로드 프로세스 진행
            //===========================================================
			localUploadFunc(file, uppath, replaceName, func);

            //===========================================================
            //  입력 파라미터 세팅
            //===========================================================
			HashMap<String,String> map =  new HashMap<String,String>();
			map.put("user_no", no);
			map.put("filename", replaceName);

            //===========================================================
            //  디비 업데이트 처리
            //===========================================================
            result = sqlSession.insert("MbrStatListMapper.updateMmsImage", map);

		}else if(func == 17) {			//손해사정서 교부동의서 첨부파일 등록 (보고서 >> 손해사정서교부 >> 손해사정서 교부대상자 등록)
			//1.Dummy 컬럼 insert를 통해 다음 순서 번호 알아내기.
			HashMap<String,String> map =  new HashMap<String,String>();
			map.put("suimRptNo", suimRptNo);
			map.put("fileName", "");
			map.put("filePath", "");
			map.put("primaryKey", "");
			sqlSession.insert("SuimBookUdtMapper.rptIssueFileUploadForSelectKey", map); //dummy data 삽입
			nextRptFileSerial= Integer.parseInt(map.get("primaryKey"));
			
			//2. 파일 업로드 경로 설정 및 파일 업로드
			//uppath = "/home/hosting_users/toplac/www/ls_report_d/"+year+"/"+month+"/"+day+"/"+suimRptNo+"/";
			//운영
			uppath = "/home/hosting_users/toplac/www/top_issue_report/"+year+"/"+month+"/"+day+"/"+suimRptNo+"/";
			//개발
			/*
			 * uppath = "D:\\home" + File.separator + "hosting_users" + File.separator +
			 * "toplac" + File.separator + "www" + File.separator + "top_issue_report" +
			 * File.separator + year + File.separator + month + File.separator + day +
			 * File.separator + suimRptNo + File.separator;
			 */
			localUploadFunc(file, uppath, replaceName, func);
			
			//3. Dummy 컬럼의 Data를 실제 Data로 Update 및 마무리
			/******************************파일명 DB 등록 시작********************************/
			//uppath = "/ls_report_d/"+year+"/"+month+"/"+day+"/"+suimRptNo+"/";
			
			uppath = "/top_issue_report/"+year+"/"+month+"/"+day+"/"+suimRptNo+"/";
			
			map.put("suimRptNo", suimRptNo);
			map.put("filePath", uppath);
			map.put("fileName", replaceName);
			map.put("nextRptFileSerial", ""+nextRptFileSerial);
			result = sqlSession.update("SuimBookUdtMapper.rptIssueFileUploadForUpdate", map); //실 data로 update
			/******************************파일명 DB 등록 끝********************************/		
			/*반환할 현재시간 (yyyy-mm-dd) 형태*/
			timeForNaming = new SimpleDateFormat("yyyy-MM-dd");
			sigan = timeForNaming.format(today);
		}
		
		

		/*
		 * 결과 반환  *
		 * 
		 * 업로드 실제 파일명 반환 ex) replaceName : 등록 성공*
		 * 0 : DB 등록 실패(DB 등록이 필요 없을 경우 = 파일만 업로드 할 경우)*
		 * 
		 * 
		 */
		if(result == 1){
			if(func == 4){
				out.print(nextRptSiteImgNo+"+"+uppath+"+"+replaceName);					
			}else if(func ==5){
				out.print(rptSiteNo+"+"+replaceName+"+"+sigan);
			}else if(func == 6){
				out.print(sigan+"+"+nextRptFileSerial);
			}else if(func == 7){
				out.print("helpFileNo_"+no);
			}else if(func == 8){
				out.print(sigan+"+"+nextPrimBizRptFileSerial);
			}else if(func == 9){
				out.print(sigan+"+"+nextMyCostBillFileSerial);
			}else if(func == 10){
				out.print(nextRptPrint1ImgSerial+"+"+replaceName);
			}else if(func == 11){
				out.print(nextSuimSuit17RptFileSerial+"+"+replaceName);
			}else if(func == 12){
				out.print(nextRptSuit10ImgSerial+"+"+replaceName);
			}else if(func == 13){
				out.print(nextSuimSuit12RptFileSerial+"+"+replaceName);
			}else if(func == 14){
				out.print(nextRptSuit18ImgSerial+"+"+replaceName);
			}else if(func == 15){
				out.print(nextRptSuit18ImgSendSerial+"+"+replaceName); 
			}else if(func == 17) {
				out.print(sigan+"+"+nextRptFileSerial);
			}else{
				out.print(replaceName);
			}
		}else{
			out.print(0);
		}
	}
	
	//실제 파일 업로드 함수
	public void localUploadFunc(MultipartFile file, String uppath, String replaceName, int func){
		File dir = new File(uppath);		

		if(!dir.exists()){
			dir.mkdirs();
		}

		try {
			FileUpload.fileUpload(file, uppath, replaceName);			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}//localUploadFunc
	
	
	/*등록한 이미지를 화면에 출력해야 할 경우*/
	@RequestMapping(value = "getimgstream", method = RequestMethod.POST)
	public void getimg(Model model, String no,String path, String id, int func, PrintWriter out,String filename, String suimRptNo){

		String uppath = null;
		
		if( (func == 0) ){
			uppath = "/home/hosting_users/toplac/www/ls_data/member/";
		}else if( (func == 1) ){
			uppath = "/home/hosting_users/toplac/www/ls_data/member_sign/"+no+"/";
		}else if( (func == 2) ) {
			uppath = "/home/hosting_users/toplac/www/ls_data/ig/small";
		}else if ( (func ==3) ){
			uppath = "/home/hosting_users/toplac/www/ls_data/ig/large";
		}else if(func == 4){
			uppath = "/home/hosting_users/toplac/www" + path;
		}else if(func == 10){
			uppath = "/home/hosting_users/toplac/www" + sqlSession.selectOne("SuimRptBodyMapper.getPrint1FilePath", no);
			System.out.println(uppath);
//			uppath = "/home/hosting_users/toplac/www/ls_report_d/"+year+"/"+month+"/"+day+"/"+suimRptNo+"/img/";
		}else if(func == 16){
            uppath = UPLOAD_PATH_MMS;
        }
		
		String dbpath = uppath+filename;
		/*func
		 * 
		 * 0 : 내사진
		 * 1 : 내Sign
		 * 
		 * */
		TopMbrSgnVO memberSignOne = null;
		
		if(func == 1){
			HashMap<String,String> map =  new HashMap<String,String>();
			map.put("user_no", no);
			map.put("filename", filename);		
			
			memberSignOne = sqlSession.selectOne("MbrStatListMapper.memberSignOne",map);
		}

		String fileType = dbpath.substring(dbpath.lastIndexOf(".")+1, dbpath.length());
		File uploadFile = new File(dbpath);
		
		
		System.out.println("dbpath : " +dbpath);
		System.out.println("fileType : " +fileType);
		
		if ("jpg".equalsIgnoreCase(fileType)
				|| "jpeg".equalsIgnoreCase( fileType) 
				|| "gif".equalsIgnoreCase( fileType)
				|| "png".equalsIgnoreCase( fileType)
			){
	    	
			BufferedImage originalImage = null;
			
			try {
				originalImage = ImageIO.read(uploadFile);
			} catch (IOException e1) {
				e1.printStackTrace();
			}
	    	
			int iheight = originalImage.getHeight();
	    	int iwidth = originalImage.getWidth();

			File thumbnail = null;
			try {

                thumbnail = File.createTempFile("c:\\", "." + fileType);
                //thumbnail = File.createTempFile(UPLOAD_PATH, "." + fileType);

			} catch (IOException e) {
				e.printStackTrace();
			} 
			try {
				ThumbnailUtil.makeThumbnail( uploadFile, thumbnail, iwidth, iheight);
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			String imageBase64 = ImageUtils.encodeToString( thumbnail, fileType);
			
			if(func == 0){
				out.print("data:image/png;base64,"+imageBase64);
			}else if(func == 1){
				
				memberSignOne.setSign_buffer(imageBase64);
				
				out.print("data:image/png;base64,"+imageBase64+"-"+memberSignOne.getSerial_no());				
			}else if( (func == 2) || (func == 3)){
				
				out.print("data:image/png;base64,"+imageBase64);				
			}else{
				out.print("data:image/png;base64,"+imageBase64);
			}

			//out.print("data:image/png;base64," + imageBase64);
		}
	}
	
	/**파일 삭제 **/
	@RequestMapping(value = "deleteimg", method = RequestMethod.POST)
	public void deleteimg(String user_no, String serial_no,int gubun, int func ,PrintWriter out) {
		
		//파일 삭제를 위한 경로
		String filePath = "";
		
		//파일 종류 설정
		String filekind = "";
		
		/*구분 : gubun
		 * 
		 * 0 : 이미지
		 * 1 : 파일
		 * 
		 * */
		
		if(gubun == 0){
			filekind = "img";
		}else if(gubun == 1){
			filekind = "file";
		}
		
		TopMbrSgnVO memberSignOne = sqlSession.selectOne("MbrStatListMapper.getMemberSignForDelete",serial_no);
		
		/*func 값에 따라 삭제 대상을 정함
		 * 
		 * 1 : 내 Sign
		 * 
		 * */
		int result = 0;
		if(func == 1){
			filePath = "/home/hosting_users/toplac/www/ls_data/member_sign/"+memberSignOne.getUser_no()+"/"+memberSignOne.getUser_sign();
			
			result = sqlSession.update("MbrStatListMapper.delOneofMysign", serial_no);
		}else if(func == 16){
            TopMbrBscVO memberVo = sqlSession.selectOne("MyInfoUdtMapper.myinfo", user_no);
            filePath = UPLOAD_PATH_MMS + memberVo.getMmsPicture();
            result = sqlSession.update("MbrStatListMapper.deleteMmsPicture", user_no);
        }
		
		//파일 삭제 시작
		if(result > 0){
			// 내 사인의 경우 delete state만 변경하므로 이전 파일을 남겨 놓는다 2016.0407 lsh 수정
			if( (filePath != null) && (func != 1) ){
				File tmpFile = new File(filePath);
				tmpFile.delete();
			}
			result++;
		}
		//파일 삭제 종료
		
		out.print(result);
	}
	
	/**
	 * 
	 */
	@RequestMapping(value = "filelogModal", method = RequestMethod.POST)
    public String filelogModal(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		
    	logger.info("======= filelogModal =======");
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	//CommonUtils.printMap(paramMap);
    	
    	List<Map<String, Object>> getFileDownLog = sqlSession.selectList("SuimRptBscDtlLogMapper.selectFileDownLogList", paramMap);
    	
    	model.addAttribute("filedownLogList", getFileDownLog);
    	model.addAttribute("paramMap", paramMap);
    	//return "include/filedown_modal";
    	return "include/filelog_modal";
    }
	
	/**
	 * 파일 다운로드 모달
	 * @param key
	 * @param type
	 * @param suimRptNo
	 * @param session
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value = "filedownModal", method = RequestMethod.POST)
    public String filedownModal(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		
    	logger.info("======= filedownModal =======");
    	
    	Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    	
    	//CommonUtils.printMap(paramMap);
    	
    	model.addAttribute("paramMap", paramMap);
    	return "include/filedown_modal";
    }
	
	@RequestMapping(value = "fileDownloadNew")
	 public void fileDownloadNew(String key,String type,String suimRptNo, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws IOException{
		
		logger.info("fileDownloadNew");
		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String downComment = paramMap.get("downComment").toString();
		
		String path = "";
		String fname = "";
		String encFName = "";
		
		if(type.equals("siteInterim") ){
			path = sqlSession.selectOne("SuimRptSiteMapper.getSiteFilePathForDown", key);
			fname = path.substring(path.lastIndexOf("/")+1);
		}else if(type.equals("rptOrigin")){
			path = sqlSession.selectOne("SuimBookUdtMapper.getRptOrgFileNameForDown", key);
			fname = path.substring(path.lastIndexOf("/")+1);
		}else if(type.equals("rptHelpFile")){
			path = sqlSession.selectOne("HelpBscMapper.helpFilePathForDown", key);
			fname = path.substring(path.lastIndexOf("/")+1);
		}else if(type.equals("rptIssue")){		//손해사정서교부동의서 추가
			path = sqlSession.selectOne("SuimBookUdtMapper.getRptIssueFileNameForDown", key);
			fname = path.substring(path.lastIndexOf("/")+1);
		}

		//log start
		TopRptLogFileVO logFileVo = new TopRptLogFileVO();
		logFileVo.setSuim_rpt_no(suimRptNo);
		logFileVo.setFile_name(fname);
		logFileVo.setUser_no((String) session.getAttribute("user_no_Session"));
		logFileVo.setUser_ip(CommonUtils.getClientIP(request));
		logFileVo.setKey(key);
		logFileVo.setDown_comment(downComment);
		//logFileVo.setUser_ip(request.getRemoteAddr());
		//sqlSession.insert("SuimRptBscDtlLogMapper.insTopRptLogFile", logFileVo);
		//신규 로그 추가 by top3009
		sqlSession.insert("SuimRptBscDtlLogMapper.insTopRptLogFileNew", logFileVo);
		//log end
		try {
			//다운로드 파일명 재설정(파일명만 나오게)
			encFName = java.net.URLEncoder.encode(fname,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		response.setHeader("Content-Disposition","attachment;filename="+encFName);

		String fullPath = ""; // "C:/upload/" +		
		
		if(type.equals("siteInterim")){
			fullPath = "/home/hosting_users/toplac/www" + path;
		}else if(type.equals("rptOrigin")){
			fullPath = "/home/hosting_users/toplac/www" + path;
		}else if(type.equals("rptHelpFile")){ //협조건 첨부파일 다운로드
			fullPath = "/home/hosting_users/toplac/www" + path;
		}else if(type.equals("rptIssue")){
			fullPath = "/home/hosting_users/toplac/www" + path;			
		}
		
		System.out.println("upload - fullpath : " + fullPath);
		
		ServletOutputStream sout = response.getOutputStream();
		FileInputStream fin = new FileInputStream(fullPath);
		
		byte[] buf = new byte[1024];
		int size=0;
		while((size=fin.read(buf,0,1024))!=-1){
			sout.write(buf,0,size);
		}
		sout.flush();
		fin.close();
		sout.close();
	}
	
	@RequestMapping(value = "fileDownload", method = RequestMethod.GET)
	 public void fileDownload(String key,String type,String suimRptNo
			 , HttpSession session, HttpServletRequest request, HttpServletResponse response) throws IOException{
		
		logger.info("fileDownload");
		
		String path = "";
		String fname = "";
		String encFName = "";
		
		if(type.equals("siteInterim") ){
			path = sqlSession.selectOne("SuimRptSiteMapper.getSiteFilePathForDown", key);
			fname = path.substring(path.lastIndexOf("/")+1);
		}else if(type.equals("rptOrigin")){
			path = sqlSession.selectOne("SuimBookUdtMapper.getRptOrgFileNameForDown", key);
			fname = path.substring(path.lastIndexOf("/")+1);
		}else if(type.equals("rptHelpFile")){
			path = sqlSession.selectOne("HelpBscMapper.helpFilePathForDown", key);
			fname = path.substring(path.lastIndexOf("/")+1);
		}else if(type.equals("rptIssue")){		//손해사정서교부동의서 추가
			path = sqlSession.selectOne("SuimBookUdtMapper.getRptIssueFileNameForDown", key);
			fname = path.substring(path.lastIndexOf("/")+1);
		}else if(type.equals("emailAttach")){		//손해사정서 이메일 발송첨부파일 다운기능 추가
			path = sqlSession.selectOne("SuimBookUdtMapper.getRptIssueFileEmailAttachForDown", key);
			fname = sqlSession.selectOne("SuimBookUdtMapper.getRptIssueFileEmailAttachForFileName", key);			
		}

		//log start
		TopRptLogFileVO logFileVo = new TopRptLogFileVO();
		logFileVo.setSuim_rpt_no(suimRptNo);
		logFileVo.setFile_name(fname);
		logFileVo.setUser_no((String) session.getAttribute("user_no_Session"));
		logFileVo.setUser_ip(CommonUtils.getClientIP(request));
		//logFileVo.setUser_ip(request.getRemoteAddr());
		sqlSession.insert("SuimRptBscDtlLogMapper.insTopRptLogFile", logFileVo);
		//log end
		try {
			//다운로드 파일명 재설정(파일명만 나오게)
			encFName = java.net.URLEncoder.encode(fname,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		response.setHeader("Content-Disposition","attachment;filename="+encFName);

		String fullPath = ""; // "C:/upload/" +		
		
		if(type.equals("siteInterim")){
			fullPath = "/home/hosting_users/toplac/www" + path;
		}else if(type.equals("rptOrigin")){
			fullPath = "/home/hosting_users/toplac/www" + path;
		}else if(type.equals("rptHelpFile")){ //협조건 첨부파일 다운로드
			fullPath = "/home/hosting_users/toplac/www" + path;
		}else if(type.equals("rptIssue")){
			fullPath = "/home/hosting_users/toplac/www" + path;			
		}else if(type.equals("emailAttach")) {
			fullPath = path;
		}
		
		//System.out.println("upload - fullpath : " + fullPath);
		
		ServletOutputStream sout = response.getOutputStream();
		FileInputStream fin = new FileInputStream(fullPath);
		
		byte[] buf = new byte[1024];
		int size=0;
		while((size=fin.read(buf,0,1024))!=-1){
			sout.write(buf,0,size);
		}
		sout.flush();
		fin.close();
		sout.close();
	}

	/* 농작물 보고서 파일 다운로드 */
	@RequestMapping(value = "primBizFileDownload", method = RequestMethod.GET)
	 public void primBizFileDownload(String key,String type,String suimRptNo, HttpServletResponse response) throws IOException{
		
		logger.info("primBizFileDownload");
		
		String fname = "";
		String path = "";
		
		if(type.equals("rptOrigin")){
			path = sqlSession.selectOne("PrimBizSuimUdtMapper.getPrimBizRptOrgFileNameForDown", key);
			fname = path.substring(path.lastIndexOf("/")+1);
			System.out.println("path :" +path);
			System.out.println("fname : "+fname);
		}
		
		String tmpFName = "";
		
		try {
			tmpFName = java.net.URLEncoder.encode(fname,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		response.setHeader("Content-Disposition","attachment;filename="+tmpFName);

		String fullPath = ""; // "C:/upload/" +
		
		if(type.equals("rptOrigin")){
			fullPath = "/home/hosting_users/toplac/www" + path;
		}

		ServletOutputStream sout = response.getOutputStream();
		FileInputStream fin = new FileInputStream(fullPath);
		
		byte[] buf = new byte[1024];
		int size=0;
		while((size=fin.read(buf,0,1024))!=-1){
			sout.write(buf,0,size);
		}
		sout.flush();
		fin.close();
		sout.close();
	}
	
}
