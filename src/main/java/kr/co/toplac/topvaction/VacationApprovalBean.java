package kr.co.toplac.topvaction;

public class VacationApprovalBean {
	
	private String approval_level = "";			//결재자 차수 ( 1, 2, 3(최종) )
	private String user_name = "";				//결재자 이름
	private String user_no = "";					//결재자 사번
	
	public String getApproval_level() {
		return approval_level;
	}
	public void setApproval_level(String approval_level) {
		this.approval_level = approval_level;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_no() {
		return user_no;
	}
	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}	
	
}
