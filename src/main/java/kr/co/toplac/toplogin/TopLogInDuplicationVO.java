package kr.co.toplac.toplogin;

public class TopLogInDuplicationVO {
	private String user_no;
	private String ip_addr;
	private int login_state;
	
	public String getIp_addr() {
		return ip_addr;
	}
	public void setIp_addr(String ip_addr) {
		this.ip_addr = ip_addr;
	}
	public int getLogin_state() {
		return login_state;
	}
	public void setLogin_state(int login_state) {
		this.login_state = login_state;
	}

	public String getUser_no() {
		return user_no;
	}
	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}
	
}
