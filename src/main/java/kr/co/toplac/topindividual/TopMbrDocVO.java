package kr.co.toplac.topindividual;

public class TopMbrDocVO {
	private int serial_no;
	private int doc_type;
	private String doc_title;
	private String file_path;
	private String file_name;
	private int user_no;
	private int doc_state;
	private int reg_user_no;
	private int reg_date;
	
	private String user_name;
	
	private String col_val;//sysadm_codedic의 값
	
	public int getSerial_no() {
		return serial_no;
	}
	public void setSerial_no(int serial_no) {
		this.serial_no = serial_no;
	}
	public int getDoc_type() {
		return doc_type;
	}
	public void setDoc_type(int doc_type) {
		this.doc_type = doc_type;
	}
	public String getDoc_title() {
		return doc_title;
	}
	public void setDoc_title(String doc_title) {
		this.doc_title = doc_title;
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
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public int getDoc_state() {
		return doc_state;
	}
	public void setDoc_state(int doc_state) {
		this.doc_state = doc_state;
	}
	public int getReg_user_no() {
		return reg_user_no;
	}
	public void setReg_user_no(int reg_user_no) {
		this.reg_user_no = reg_user_no;
	}
	public int getReg_date() {
		return reg_date;
	}
	public void setReg_date(int reg_date) {
		this.reg_date = reg_date;
	}
	
	public String getCol_val() {
		return col_val;
	}
	public void setCol_val(String col_val) {
		this.col_val = col_val;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	
}
