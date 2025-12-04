package kr.co.toplac.sysadm;

public class CardLogBean {
	private int log_no = 0;						//로그키
	private int bkey = 0;						//카드테이블 ckey (외래키)	
	private int log_user_no = 0;					//로그 작업자 사번
	private String log_user_name = "";		//로그 작업자 이름
	private String log_action = "";				//실행 상태 (Insert, Update, Delete)	
	private String log_content = "";			//실행 내용
	private String log_ip = "";					//로그 등록자 아이피
	private String log_reg_date = "";			//로그 등록시간	
	private String user_name = "";				//사용자 이름
	private String team_name = "";			//사용팀 이름
	
	public int getBkey() {
		return bkey;
	}
	public void setBkey(int bkey) {
		this.bkey = bkey;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}	
	public String getLog_user_name() {
		return log_user_name;
	}
	public void setLog_user_name(String log_user_name) {
		this.log_user_name = log_user_name;
	}
	public int getLog_no() {
		return log_no;
	}
	public void setLog_no(int log_no) {
		this.log_no = log_no;
	}	
	public int getLog_user_no() {
		return log_user_no;
	}
	public void setLog_user_no(int log_user_no) {
		this.log_user_no = log_user_no;
	}
	public String getLog_action() {
		return log_action;
	}
	public void setLog_action(String log_action) {
		this.log_action = log_action;
	}
	public String getLog_content() {
		return log_content;
	}
	public void setLog_content(String log_content) {
		this.log_content = log_content;
	}
	public String getLog_ip() {
		return log_ip;
	}
	public void setLog_ip(String log_ip) {
		this.log_ip = log_ip;
	}
	public String getLog_reg_date() {
		return log_reg_date;
	}
	public void setLog_reg_date(String log_reg_date) {
		this.log_reg_date = log_reg_date;
	}
}
