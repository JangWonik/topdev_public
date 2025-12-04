package kr.co.toplac.brd.common;

import java.io.UnsupportedEncodingException;

/**
 * @author GOLDMAN
 *
 */
public class BoardFileVO {
	private String board_file_no;
	private String board_no;
	private String file_path;
	private String file_name;
	private String reg_date;
	private String encodedFilePathName;
	private String stre_file_nm;
	private String file_no;	
	
	public String getFile_no() {
		return file_no;
	}
	public void setFile_no(String file_no) {
		this.file_no = file_no;
	}
	public String getStre_file_nm() {
		return stre_file_nm;
	}
	public void setStre_file_nm(String stre_file_nm) {
		this.stre_file_nm = stre_file_nm;
	}
	public String getBoard_file_no() {
		return board_file_no;
	}
	public void setBoard_file_no(String board_file_no) {
		this.board_file_no = board_file_no;
	}
	public String getBoard_no() {
		return board_no;
	}
	public void setBoard_no(String board_no) {
		this.board_no = board_no;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getEncodedFilePathName() {
		return encodedFilePathName;
	}
	public void setEncodedFilePathName(String encodedFilePathName) {
		try {
			this.encodedFilePathName = java.net.URLEncoder.encode(encodedFilePathName,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

}
