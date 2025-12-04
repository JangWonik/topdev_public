package kr.co.toplac.sysadm;

public class EquipmentSummaryBean {
	
	private String tbl_nm;
	private String col_nm;
	private String col_cd;
	private String col_val;
	
	private String col_cd1;
	private String col_cd2;
	
	String eq_type = "";						//장비 타입코드
	String eq_type_val = "";				//장비 타입명
	int eq_use_cnt = 0;						//사용중
	int eq_wait_cnt = 0;					//사용가능(대기)
	int eq_break_cnt = 0;					//사용불가능
	int eq_hold_cnt = 0;					//보류
	int eq_uncollect_cnt = 0;				//미회수
	int eq_close_cnt = 0;					//폐기
	
	public int getEq_close_cnt() {
		return eq_close_cnt;
	}
	public void setEq_close_cnt(int eq_close_cnt) {
		this.eq_close_cnt = eq_close_cnt;
	}
	public int getEq_hold_cnt() {
		return eq_hold_cnt;
	}
	public void setEq_hold_cnt(int eq_hold_cnt) {
		this.eq_hold_cnt = eq_hold_cnt;
	}
	public String getTbl_nm() {
		return tbl_nm;
	}
	public void setTbl_nm(String tbl_nm) {
		this.tbl_nm = tbl_nm;
	}
	public String getCol_nm() {
		return col_nm;
	}
	public void setCol_nm(String col_nm) {
		this.col_nm = col_nm;
	}
	public String getCol_cd() {
		return col_cd;
	}
	public void setCol_cd(String col_cd) {
		this.col_cd = col_cd;
	}
	public String getCol_val() {
		return col_val;
	}
	public void setCol_val(String col_val) {
		this.col_val = col_val;
	}
	public String getCol_cd1() {
		return col_cd1;
	}
	public void setCol_cd1(String col_cd1) {
		this.col_cd1 = col_cd1;
	}
	public String getCol_cd2() {
		return col_cd2;
	}
	public void setCol_cd2(String col_cd2) {
		this.col_cd2 = col_cd2;
	}
	public String getEq_type() {
		return eq_type;
	}
	public void setEq_type(String eq_type) {
		this.eq_type = eq_type;
	}
	public String getEq_type_val() {
		return eq_type_val;
	}
	public void setEq_type_val(String eq_type_val) {
		this.eq_type_val = eq_type_val;
	}
	public int getEq_use_cnt() {
		return eq_use_cnt;
	}
	public void setEq_use_cnt(int eq_use_cnt) {
		this.eq_use_cnt = eq_use_cnt;
	}
	public int getEq_wait_cnt() {
		return eq_wait_cnt;
	}
	public void setEq_wait_cnt(int eq_wait_cnt) {
		this.eq_wait_cnt = eq_wait_cnt;
	}
	public int getEq_break_cnt() {
		return eq_break_cnt;
	}
	public void setEq_break_cnt(int eq_break_cnt) {
		this.eq_break_cnt = eq_break_cnt;
	}
	public int getEq_uncollect_cnt() {
		return eq_uncollect_cnt;
	}
	public void setEq_uncollect_cnt(int eq_uncollect_cnt) {
		this.eq_uncollect_cnt = eq_uncollect_cnt;
	}
}
