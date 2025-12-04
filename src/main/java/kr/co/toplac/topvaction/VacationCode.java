package kr.co.toplac.topvaction;

public class VacationCode {
	private int vacation_code = 0;				//휴가코드 값
	private double vacation_point = 0;		//연차차감 값 
	private String vacation_type = "";			//휴가명
	private String vacation_content = "";		//휴가설명
	private int approval_code = 0;			//휴가결재 코드값
	private String approval_val = "";		//휴가결재명
	
	public int getApproval_code() {
		return approval_code;
	}
	public void setApproval_code(int approval_code) {
		this.approval_code = approval_code;
	}
	public String getApproval_val() {
		return approval_val;
	}
	public void setApproval_val(String approval_val) {
		this.approval_val = approval_val;
	}
	public int getVacation_code() {
		return vacation_code;
	}
	public void setVacation_code(int vacation_code) {
		this.vacation_code = vacation_code;
	}
	public double getVacation_point() {
		return vacation_point;
	}
	public void setVacation_point(double vacation_point) {
		this.vacation_point = vacation_point;
	}
	public String getVacation_type() {
		return vacation_type;
	}
	public void setVacation_type(String vacation_type) {
		this.vacation_type = vacation_type;
	}
	public String getVacation_content() {
		return vacation_content;
	}
	public void setVacation_content(String vacation_content) {
		this.vacation_content = vacation_content;
	}
	
}
