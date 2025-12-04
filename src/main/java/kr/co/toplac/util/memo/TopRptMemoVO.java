package kr.co.toplac.util.memo;

/**
 * @author rjh
 *
 */
public class TopRptMemoVO {
	
	private String memo_no;
	private String fk_no;
	private String user_no;
	private String user_nm;
	private String memo;
	private String reg_ip;
	private String reg_date;

	public String getMemo_no() {
		return memo_no;
	}
	public void setMemo_no(String memo_no) {
		this.memo_no = memo_no;
	}
	public String getFk_no() {
		return fk_no;
	}
	public void setFk_no(String fk_no) {
		this.fk_no = fk_no;
	}
	public String getUser_no() {
		return user_no;
	}
	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getReg_ip() {
		return reg_ip;
	}
	public void setReg_ip(String reg_ip) {
		this.reg_ip = reg_ip;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

}
