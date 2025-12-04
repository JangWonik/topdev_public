package kr.co.toplac.topteam;

public class NilinkRecordVO {
	private int rkey = 0;						//녹음목록키(고유키)
	private String rtype = "";					//통화종류(내외부송수신종류)
	private String send_num = "";			//송신번호
	private String receive_num = "";		//수신번호
	private String folder_date = "";			//날짜(폴더명)
	private String record_time = "";		//녹음시간
	private String file_name = "";			//녹음파일명
	private String file_name_fmt = "";		//표시할 녹음파일명
	private String full_path = "";			//전체경로
	private long file_size = 0;				//파일사이즈(byte)
	
	public String getFile_name_fmt() {
		return file_name_fmt;
	}
	public void setFile_name_fmt(String file_name_fmt) {
		this.file_name_fmt = file_name_fmt;
	}
	public String getRecord_time() {
		return record_time;
	}
	public void setRecord_time(String record_time) {
		this.record_time = record_time;
	}
	public int getRkey() {
		return rkey;
	}
	public void setRkey(int rkey) {
		this.rkey = rkey;
	}
	public String getRtype() {
		return rtype;
	}
	public void setRtype(String rtype) {
		this.rtype = rtype;
	}
	public String getSend_num() {
		return send_num;
	}
	public void setSend_num(String send_num) {
		this.send_num = send_num;
	}
	public String getReceive_num() {
		return receive_num;
	}
	public void setReceive_num(String receive_num) {
		this.receive_num = receive_num;
	}
	public String getFolder_date() {
		return folder_date;
	}
	public void setFolder_date(String folder_date) {
		this.folder_date = folder_date;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getFull_path() {
		return full_path;
	}
	public void setFull_path(String full_path) {
		this.full_path = full_path;
	}
	public long getFile_size() {
		return file_size;
	}
	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}
}
