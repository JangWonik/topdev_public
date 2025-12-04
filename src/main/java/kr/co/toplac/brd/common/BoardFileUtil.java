package kr.co.toplac.brd.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;

import org.apache.ibatis.session.SqlSession;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import kr.co.toplac.util.file.FileUpload;

public class BoardFileUtil {

	public int fileUploadProcessor(MultipartRequest multipartRequest, String boardNo, String path, SqlSession sqlSession, String listMapper){
		String saveDBPath = path.replace("/home/hosting_users/toplac/www", "");
		DateFormat sd1 = new SimpleDateFormat("yyyyMMdd");
		DateFormat sd2 = new SimpleDateFormat("HHmmss");

		Iterator<String> iter = multipartRequest.getFileNames();
		MultipartFile file = null;
		Date today = null;
		String nalja = null, sigan = null, fileNameOnly = null, fileType = null, replaceName = null;
		int have_file = 0, file_result = 0, return_int = 1;
		while(iter.hasNext()) {
			file = multipartRequest.getFile((String) iter.next());
			String fileName = file.getOriginalFilename();
			if(fileName == null || fileName.trim().length() < 3){continue;}
			have_file = 1;//저장할 파일이 있음

			today = new Date();//오늘날자구하기
			nalja = sd1.format(today);//String형으로 변환
			sigan = sd2.format(today);//String형으로 변환
			fileNameOnly = fileName.substring(0, fileName.lastIndexOf("."));
			fileType = fileName.substring(fileName.lastIndexOf("."), fileName.length());
			replaceName = nalja + "_" + sigan + "_" + fileNameOnly+ fileType;  //파일 이름의 중복을 막기 위해서 이름을 재설정합니다.
			try {
				FileUpload.fileUpload(file, path, replaceName);

				BoardFileVO fileVO = new BoardFileVO();
				fileVO.setBoard_no(boardNo);
				fileVO.setFile_path(saveDBPath);
				fileVO.setFile_name(replaceName);
				file_result = sqlSession.insert(listMapper, fileVO);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}//while

		if(have_file > 0 && file_result < 1){//저장 대상 파일은 있는데, 저장 결과가 0인 경우
			return_int = 0;//저장 실패
		}
		return return_int;
	}//boardFileUploadProcess

	public String mvCKFileDirTmpToReal(String inContents, String realFolder, String boardNo) {
		String ckStr = null, ckStrPath = null, ckStrName = null;
		File ckFile = null, ckDir = null;
		FileInputStream fis = null;
		FileOutputStream fos = null;
		String [] tmpArr = inContents.split("src=\"");//src 표현이 있는 부분 잘라내기
		for(int i = 0; i < tmpArr.length; i++){
			if(tmpArr[i].startsWith("/home/hosting_users/toplac/www/wp_board/data/ckeditor_tmp")){///home/hosting_users/toplac/www/wp_board/data/ckeditor_tmp 표현이 있는 부분 잘라내기
				ckStr = tmpArr[i].substring(0, tmpArr[i].indexOf("\""));//url 부분만 잘라내기
				ckStrPath = ckStr.substring(0, ckStr.lastIndexOf("/")+1);//url 에서 경로만 잘라내기
				ckStrName = ckStr.substring(ckStr.lastIndexOf("/")+1);//url 에서 파일 이름만 잘라내기
				ckFile = new File(ckStr);//임시 폴더 내의 파일
				try {
					fis = new FileInputStream(ckFile);//임시 폴더 내의 파일 읽어 들이기
					ckDir = new File("/home/hosting_users/toplac/www/wp_board/data/"+realFolder+"/"+boardNo+"/");//정식 폴더
					if (!ckDir.exists()) {ckDir.mkdirs();}//정식 폴더 만들기
					fos = new FileOutputStream("/home/hosting_users/toplac/www/wp_board/data/"+realFolder+"/"+boardNo+"/" + ckStrName);//읽어 들인 임시 파일을 정식 폴더에 쓰기
					FileCopyUtils.copy(fis, fos);//실행
				} catch (FileNotFoundException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				} finally{
					try {
						fis.close();
						fos.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}//finally
			}//if
		}//for
		return ckStrPath;
	}

	public void deleteDir(String deletePath) {
		if(deletePath != null){
			File DeleteTarget = new File(deletePath);
			File tmpFileArr [] = DeleteTarget.listFiles();
			if(tmpFileArr != null && tmpFileArr.length > 0){
				for(int i = 0; i < tmpFileArr.length; i++){
					File toDeleteFile = tmpFileArr[i];
					toDeleteFile.delete();
				}
			}
			DeleteTarget.delete();
		}
	}//deleteDir

	public int deleteDirReturnFlag(String deletePath) {
		int file_flag = 0;
		if(deletePath != null){
			File DeleteTarget = new File(deletePath);
			File tmpFileArr [] = DeleteTarget.listFiles();
			if(tmpFileArr != null && tmpFileArr.length > 0){
				file_flag = 1;
				for(int i = 0; i < tmpFileArr.length; i++){
					File toDeleteFile = tmpFileArr[i];
					toDeleteFile.delete();
				}
			}
			DeleteTarget.delete();
		}
		return file_flag;
	}//deleteDir

	public String mvCKFileDirRealToTmp(String inContents, String userNo) {
		String ckStr = null, ckStrPath = null, ckStrName = null;
		File ckFile = null, ckDir = null;
		FileInputStream fis = null;
		FileOutputStream fos = null;
		String [] tmpArr = inContents.split("src=\"");//src 표현이 있는 부분 잘라내기
		for(int i = 0; i < tmpArr.length; i++){
			//if(tmpArr[i].startsWith("/home/hosting_users/toplac/www/wp_board/data/")){///home/hosting_users/toplac/www/wp_board/data/ 표현이 있는 부분 잘라내기
			if(tmpArr[i].startsWith("/wp_board/data/")){///home/hosting_users/toplac/www/wp_board/data/ 표현이 있는 부분 잘라내기
				ckStr = tmpArr[i].substring(0, tmpArr[i].indexOf("\""));//url 부분만 잘라내기
				ckStrPath = ckStr.substring(0, ckStr.lastIndexOf("/")+1);//url 에서 경로만 잘라내기
				ckStrName = ckStr.substring(ckStr.lastIndexOf("/")+1);//url 에서 파일 이름만 잘라내기
				ckFile = new File(ckStr);//정식 폴더 내의 파일
				try {
					fis = new FileInputStream(ckFile);//정식 폴더 내의 파일 읽어 들이기
					ckDir = new File("/home/hosting_users/toplac/www/wp_board/data/ckeditor_tmp/"+userNo+"/");//임시 폴더
					if (!ckDir.exists()) {ckDir.mkdirs();}//임시 폴더 만들기
					fos = new FileOutputStream("/home/hosting_users/toplac/www/wp_board/data/ckeditor_tmp/"+userNo+"/"+ckStrName);//읽어 들인 정식 파일을 임시 폴더에 쓰기
					FileCopyUtils.copy(fis, fos);//실행
				} catch (FileNotFoundException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				} finally{
					try {
						fis.close();
						fos.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}//finally
			}//if
		}//for
		return ckStrPath;
	}

}//end of class
