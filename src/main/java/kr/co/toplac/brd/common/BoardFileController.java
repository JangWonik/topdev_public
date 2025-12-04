/*
*********************************************************
* Program ID	: BoardFileCommonController
* Program Name	: BoardFileCommonController
* Description	: 게시판 공통
* Author		: 
* Date			: 2016.06.17.
*********************************************************
*/
package kr.co.toplac.brd.common;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import kr.co.toplac.util.file.FileUpload;

@Controller
public class BoardFileController {

	private static final Logger logger = LoggerFactory.getLogger(BoardFileController.class);

	@Autowired
	SqlSession sqlSession;

	@RequestMapping(value = "/commonFileDownload", method = RequestMethod.GET)
	 public void commonFileDownload(HttpServletResponse response, String fileName)
			 throws IOException{
		logger.info("======= commonFileDownload =======");
		
		String tmpFName = "";
		
		try {
			//다운로드 파일명 재설정(파일명만 나오게)
			
			String tmp = fileName.substring(fileName.lastIndexOf("/")+1, fileName.length());
			tmpFName = java.net.URLEncoder.encode(tmp,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		response.setHeader("Content-Disposition","attachment;filename="+tmpFName);
		
		fileName = "/home/hosting_users/toplac/www"+fileName;
		
		ServletOutputStream sout = response.getOutputStream();
		FileInputStream fin = new FileInputStream(fileName);
//		FileInputStream fin = new FileInputStream(java.net.URLEncoder.encode(fileName,"euc-kr"));

		byte[] buf = new byte[1024];
		int size=0;
		while((size=fin.read(buf,0,1024))!=-1){
			sout.write(buf,0,size);
		}
		sout.flush();
		fin.close();
		sout.close();

//		String toOutFileName = fileName.substring(fileName.lastIndexOf("/")+1);
//		
//		String oriFileName =toOutFileName.substring(0,toOutFileName.lastIndexOf("."));
//		String extendFileName = toOutFileName.substring(toOutFileName.lastIndexOf("."));
//		
//		oriFileName = java.net.URLEncoder.encode(oriFileName,"UTF-8");
//		response.setHeader("Content-Disposition",
//				"attachment;filename="+oriFileName+extendFileName);
//
//		ServletOutputStream sout = response.getOutputStream();
//		FileInputStream fin = new FileInputStream(fileName);
//
//		byte[] buf = new byte[1024];
//		int size=0;
//		while((size=fin.read(buf,0,1024))!=-1){
//			sout.write(buf,0,size);
//		}
//		sout.flush();
//		fin.close();
//		sout.close();
	}//commonFileDownload

	@RequestMapping(value = "/brdFreeFileDownload", method = RequestMethod.GET)
	 public void brdFreeFileDownload(HttpServletResponse response, String fileNo)
			 throws IOException{
		logger.info("======= brdFreeFileDownload =======");

		BoardFileVO tmpBoardFreeFileVO = sqlSession.selectOne("BoardFreeMapper.freeBoardFileOneSelect", fileNo);

		String tmpFName = "";

		try {
			String tmp = tmpBoardFreeFileVO.getFile_name();
			tmpFName = java.net.URLEncoder.encode(tmp,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		response.setHeader("Content-Disposition","attachment;filename="+tmpFName);
		
		String fileName = "/home/hosting_users/toplac/www"+tmpBoardFreeFileVO.getFile_path()+tmpBoardFreeFileVO.getFile_name();
		
		ServletOutputStream sout = response.getOutputStream();
		FileInputStream fin = new FileInputStream(fileName);

		byte[] buf = new byte[1024];
		int size=0;
		while((size=fin.read(buf,0,1024))!=-1){
			sout.write(buf,0,size);
		}
		sout.flush();
		fin.close();
		sout.close();
	}//brdFreeFileDownload

	@RequestMapping(value = "/brdHelpDeskFileDownload", method = RequestMethod.GET)
	 public void brdHelpDeskFileDownload(HttpServletResponse response, String fileNo)
			 throws IOException{
		logger.info("======= brdHelpDeskFileDownload =======");

		BoardFileVO tmpBoardFreeFileVO = sqlSession.selectOne("BoardHelpDeskMapper.helpDeskFileOneSelect", fileNo);

		String tmpFName = "";

		try {
			String tmp = tmpBoardFreeFileVO.getFile_name();
			tmpFName = java.net.URLEncoder.encode(tmp,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		response.setHeader("Content-Disposition","attachment;filename="+tmpFName);

		String fileName = "/home/hosting_users/toplac/www"+tmpBoardFreeFileVO.getFile_path()+tmpBoardFreeFileVO.getFile_name();

		ServletOutputStream sout = response.getOutputStream();
		FileInputStream fin = new FileInputStream(fileName);

		byte[] buf = new byte[1024];
		int size=0;
		while((size=fin.read(buf,0,1024))!=-1){
			sout.write(buf,0,size);
		}
		sout.flush();
		fin.close();
		sout.close();
	}//brdHelpDeskFileDownload

	@RequestMapping(value = "/brdNoticePtnr1FileDownload", method = RequestMethod.GET)
	 public void brdNoticePtnr1FileDownload(HttpServletResponse response, String fileNo)
			 throws IOException{
		logger.info("======= brdNoticePtnr1FileDownload =======");

		BoardFileVO tmpBoardFreeFileVO = sqlSession.selectOne("BoardNoticePtnr1Mapper.noticePtnr1FileOneSelect", fileNo);

		String tmpFName = "";

		try {
			String tmp = tmpBoardFreeFileVO.getFile_name();
			tmpFName = java.net.URLEncoder.encode(tmp,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		response.setHeader("Content-Disposition","attachment;filename="+tmpFName);

		String fileName = "/home/hosting_users/toplac/www"+tmpBoardFreeFileVO.getFile_path()+tmpBoardFreeFileVO.getFile_name();

		ServletOutputStream sout = response.getOutputStream();
		FileInputStream fin = new FileInputStream(fileName);

		byte[] buf = new byte[1024];
		int size=0;
		while((size=fin.read(buf,0,1024))!=-1){
			sout.write(buf,0,size);
		}
		sout.flush();
		fin.close();
		sout.close();
	}//brdNoticePtnr1FileDownload

	@RequestMapping(value = "/brdNoticePtnr4FileDownload", method = RequestMethod.GET)
	 public void brdNoticePtnr4FileDownload(HttpServletResponse response, String fileNo)
			 throws IOException{
		logger.info("======= brdNoticePtnr4FileDownload =======");

		BoardFileVO tmpBoardFreeFileVO = sqlSession.selectOne("BoardNoticePtnr4Mapper.noticePtnr4FileOneSelect", fileNo);

		String tmpFName = "";

		try {
			String tmp = tmpBoardFreeFileVO.getFile_name();
			tmpFName = java.net.URLEncoder.encode(tmp,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		response.setHeader("Content-Disposition","attachment;filename="+tmpFName);

		String fileName = "/home/hosting_users/toplac/www"+tmpBoardFreeFileVO.getFile_path()+tmpBoardFreeFileVO.getFile_name();

		ServletOutputStream sout = response.getOutputStream();
		FileInputStream fin = new FileInputStream(fileName);

		byte[] buf = new byte[1024];
		int size=0;
		while((size=fin.read(buf,0,1024))!=-1){
			sout.write(buf,0,size);
		}
		sout.flush();
		fin.close();
		sout.close();
	}//brdNoticePtnr4FileDownload
	
	@RequestMapping(value = "/brdSupportTopFileDownload", method = RequestMethod.GET)
	 public void brdSupportTopFileDownload(HttpServletResponse response, String fileNo)
			 throws IOException{
		logger.info("======= brdSupportTopFileDownload =======");

		BoardFileVO tmpBoardFreeFileVO = sqlSession.selectOne("BoardNoticeTopMapper.supportTopFileOneSelect", fileNo);

		String tmpFName = "";

		try {
			String tmp = tmpBoardFreeFileVO.getFile_name();
			tmpFName = java.net.URLEncoder.encode(tmp,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		response.setHeader("Content-Disposition","attachment;filename="+tmpFName);

		String fileName = "/home/hosting_users/toplac/www"+tmpBoardFreeFileVO.getFile_path()+tmpBoardFreeFileVO.getFile_name();

		ServletOutputStream sout = response.getOutputStream();
		FileInputStream fin = new FileInputStream(fileName);

		byte[] buf = new byte[1024];
		int size=0;
		while((size=fin.read(buf,0,1024))!=-1){
			sout.write(buf,0,size);
		}
		sout.flush();
		fin.close();
		sout.close();
	}
	
	@RequestMapping(value = "/lectureTopFileDownload", method = RequestMethod.GET)
	 public void lectureTopFileDownload(HttpServletResponse response, String fileNo)
			 throws IOException{
		logger.info("======= lectureTopFileDownload =======");

		BoardFileVO tmpBoardFreeFileVO = sqlSession.selectOne("BrdLectureMapper.noticeTopFileOneSelect", fileNo);

		String tmpFName = "";

		try {
			String tmp = tmpBoardFreeFileVO.getFile_name();
			tmpFName = java.net.URLEncoder.encode(tmp,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		response.setHeader("Content-Disposition","attachment;filename="+tmpFName);

		String fileName = "/home/hosting_users/toplac/www"+tmpBoardFreeFileVO.getFile_path()+tmpBoardFreeFileVO.getFile_name();

		ServletOutputStream sout = response.getOutputStream();
		FileInputStream fin = new FileInputStream(fileName);

		byte[] buf = new byte[1024];
		int size=0;
		while((size=fin.read(buf,0,1024))!=-1){
			sout.write(buf,0,size);
		}
		sout.flush();
		fin.close();
		sout.close();
	}

	@RequestMapping(value = "/brdNoticeTopFileDownload", method = RequestMethod.GET)
	 public void brdNoticeTopFileDownload(HttpServletResponse response, String fileNo)
			 throws IOException{
		logger.info("======= brdNoticeTopFileDownload =======");

		BoardFileVO tmpBoardFreeFileVO = sqlSession.selectOne("BoardNoticeTopMapper.noticeTopFileOneSelect", fileNo);

		String tmpFName = "";

		try {
			String tmp = tmpBoardFreeFileVO.getFile_name();
			tmpFName = java.net.URLEncoder.encode(tmp,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		response.setHeader("Content-Disposition","attachment;filename="+tmpFName);

		String fileName = "/home/hosting_users/toplac/www"+tmpBoardFreeFileVO.getFile_path()+tmpBoardFreeFileVO.getFile_name();

		ServletOutputStream sout = response.getOutputStream();
		FileInputStream fin = new FileInputStream(fileName);

		byte[] buf = new byte[1024];
		int size=0;
		while((size=fin.read(buf,0,1024))!=-1){
			sout.write(buf,0,size);
		}
		sout.flush();
		fin.close();
		sout.close();
	}//brdNoticeTopFileDownload
	
	@RequestMapping(value = "/brdRefReportFileDownload", method = RequestMethod.GET)
	 public void brdRefReportFileDownload(HttpServletResponse response, String fileNo)
			 throws IOException{
		logger.info("======= brdRefReportFileDownload =======");

		BoardFileVO tmpBoardFreeFileVO = sqlSession.selectOne("BoardRefReportMapper.refPtnrFileOneSelect", fileNo);

		String tmpFName = "";

		try {
			String tmp = tmpBoardFreeFileVO.getFile_name();
			tmpFName = java.net.URLEncoder.encode(tmp,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		response.setHeader("Content-Disposition","attachment;filename="+tmpFName);

		String fileName = "/home/hosting_users/toplac/www"+tmpBoardFreeFileVO.getFile_path()+tmpBoardFreeFileVO.getFile_name();

		ServletOutputStream sout = response.getOutputStream();
		FileInputStream fin = new FileInputStream(fileName);

		byte[] buf = new byte[1024];
		int size=0;
		while((size=fin.read(buf,0,1024))!=-1){
			sout.write(buf,0,size);
		}
		sout.flush();
		fin.close();
		sout.close();
	}

	@RequestMapping(value = "/brdRefPtnrFileDownload", method = RequestMethod.GET)
	 public void brdRefPtnrFileDownload(HttpServletResponse response, String fileNo)
			 throws IOException{
		logger.info("======= brdRefPtnrFileDownload =======");

		BoardFileVO tmpBoardFreeFileVO = sqlSession.selectOne("BoardReferencePtnrMapper.refPtnrFileOneSelect", fileNo);

		String tmpFName = "";

		try {
			String tmp = tmpBoardFreeFileVO.getFile_name();
			tmpFName = java.net.URLEncoder.encode(tmp,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		response.setHeader("Content-Disposition","attachment;filename="+tmpFName);

		String fileName = "/home/hosting_users/toplac/www"+tmpBoardFreeFileVO.getFile_path()+tmpBoardFreeFileVO.getFile_name();

		ServletOutputStream sout = response.getOutputStream();
		FileInputStream fin = new FileInputStream(fileName);

		byte[] buf = new byte[1024];
		int size=0;
		while((size=fin.read(buf,0,1024))!=-1){
			sout.write(buf,0,size);
		}
		sout.flush();
		fin.close();
		sout.close();
	}//brdRefPtnrFileDownload

	@RequestMapping(value = "/brdRefTopFileDownload", method = RequestMethod.GET)
	 public void brdRefTopFileDownload(HttpServletResponse response, String fileNo)
			 throws IOException{
		logger.info("======= brdRefTopFileDownload =======");

		BoardFileVO tmpBoardFreeFileVO = sqlSession.selectOne("BoardReferenceTopMapper.refTopFileOneSelect", fileNo);

		String tmpFName = "";

		try {
			String tmp = tmpBoardFreeFileVO.getFile_name();
			tmpFName = java.net.URLEncoder.encode(tmp,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		response.setHeader("Content-Disposition","attachment;filename="+tmpFName);

		String fileName = "/home/hosting_users/toplac/www"+tmpBoardFreeFileVO.getFile_path()+tmpBoardFreeFileVO.getFile_name();

		ServletOutputStream sout = response.getOutputStream();
		FileInputStream fin = new FileInputStream(fileName);

		byte[] buf = new byte[1024];
		int size=0;
		while((size=fin.read(buf,0,1024))!=-1){
			sout.write(buf,0,size);
		}
		sout.flush();
		fin.close();
		sout.close();
	}//brdRefTopFileDownload

	@RequestMapping(value = "/ckeditorUpload", method = RequestMethod.POST)
	public void ckeditorUpload(String CKEditorFuncNum, HttpServletResponse response, MultipartRequest multipartRequest, String tmpNo) {
		DateFormat sd1 = new SimpleDateFormat("yyyyMMdd");
		DateFormat sd2 = new SimpleDateFormat("HHmmss");

		Iterator<String> iter = multipartRequest.getFileNames();
		MultipartFile file = null;
		Date today = null;
		String nalja = null, sigan = null, fileNameOnly = null, fileType = null, replaceName = null;
		String path = "/home/hosting_users/toplac/www/wp_board/data/ckeditor_tmp/"+tmpNo+"/";
		while(iter.hasNext()) {
			file = multipartRequest.getFile((String) iter.next());
			String fileName = file.getOriginalFilename();
			if(fileName == null || fileName.trim().length() < 3){continue;}

			today = new Date();//오늘날자구하기
			nalja = sd1.format(today);//String형으로 변환
			sigan = sd2.format(today);//String형으로 변환
			fileNameOnly = fileName.substring(0, fileName.lastIndexOf("."));
			fileType = fileName.substring(fileName.lastIndexOf("."), fileName.length());
			replaceName = nalja + "_" + sigan + "_" + fileNameOnly+ fileType;  //파일 이름의 중복을 막기 위해서 이름을 재설정합니다.
			try {
				FileUpload.fileUpload(file, path, replaceName);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}//while

		response.setCharacterEncoding("UTF-8");
	    response.setContentType("text/html;charset=UTF-8");
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		String fileUrl = path + replaceName;
		out.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("
			+ CKEditorFuncNum
			+ ",'"
			+ fileUrl
			+ "','이미지를 업로드 하였습니다.'"
			+ ")</script>");
		out.flush();
		out.close();
		return;
	}//ckeditorUpload

}//end of class
