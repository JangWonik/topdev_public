package kr.co.toplac.topvaction;

public class LeaveCode {
	private int leave_code = 0;				//휴직코드 값
	private double leave_point = 0;		//휴직에따른 년월차 차감 값 
	private String leave_type = "";			//휴직명
	private String leave_content = "";		//휴직설명
	private int approval_leave_code = 0;			//휴직결재 코드값
	private String approval_leave_val = "";		//휴직결재명
	
	public int getLeave_code() {
		return leave_code;
	}
	public void setLeave_code(int leave_code) {
		this.leave_code = leave_code;
	}
	public double getLeave_point() {
		return leave_point;
	}
	public void setLeave_point(double leave_point) {
		this.leave_point = leave_point;
	}
	public String getLeave_type() {
		return leave_type;
	}
	public void setLeave_type(String leave_type) {
		this.leave_type = leave_type;
	}
	public String getLeave_content() {
		return leave_content;
	}
	public void setLeave_content(String leave_content) {
		this.leave_content = leave_content;
	}
	public int getApproval_leave_code() {
		return approval_leave_code;
	}
	public void setApproval_leave_code(int approval_leave_code) {
		this.approval_leave_code = approval_leave_code;
	}
	public String getApproval_leave_val() {
		return approval_leave_val;
	}
	public void setApproval_leave_val(String approval_leave_val) {
		this.approval_leave_val = approval_leave_val;
	}
}
