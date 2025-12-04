package kr.co.toplac.topgeneral;

public class EmpNmlstTmDtlVO {
	
	private String user_no;
	private String user_id;
	private String user_name;
	private String user_state;
	private String team_id_main;
	private String team_id_loc;
	private String work_level;
	private String work_type;
	private String work_level_cd;
	private String work_type_cd;
	private String col_val;
	private String office_tel;
	private String office_fax;
	private String jumin_no;
	private String jumin_no1;
	private String jumin_no2;
	private String home_address;
	private String home_tel;
	private String handphone;
	private String email;
	private String comment;
	private String memo;
	private String job_memo;
	private String picture;
	private String reg_date;
	private String join_date;
	private String out_date;
	private String team_name;
	private String rownum;
	private String team_interphone;
	private String team_telephone;
	private String team_addr;
	private String team_fax;
	private String center_name;
	
	private int nNoSend_Type1 = 0;			//손해사정서 미발송 수(계약자)
	private int nNoSend_Type5 = 0;			//손해사정서 미발송 수(피보험자)
	private int nNoSend_Type10 = 0;			//손해사정서 미발송 수(보험청구권자)
	
	private int nNoSend_Total = 0;			//손해사정서 미발송 수(보고서기준)
	
	private String person_zone;			//현재위치
	
	public String getPerson_zone() {
		return person_zone;
	}
	public void setPerson_zone(String person_zone) {
		this.person_zone = person_zone;
	}
	public int getnNoSend_Total() {
		return nNoSend_Total;
	}
	public void setnNoSend_Total(int nNoSend_Total) {
		this.nNoSend_Total = nNoSend_Total;
	}
	public int getnNoSend_Type1() {
		return nNoSend_Type1;
	}
	public void setnNoSend_Type1(int nNoSend_Type1) {
		this.nNoSend_Type1 = nNoSend_Type1;
	}
	public int getnNoSend_Type5() {
		return nNoSend_Type5;
	}
	public void setnNoSend_Type5(int nNoSend_Type5) {
		this.nNoSend_Type5 = nNoSend_Type5;
	}
	public int getnNoSend_Type10() {
		return nNoSend_Type10;
	}
	public void setnNoSend_Type10(int nNoSend_Type10) {
		this.nNoSend_Type10 = nNoSend_Type10;
	}
	public String getUser_no() {
		return user_no;
	}
	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_state() {
		return user_state;
	}
	public void setUser_state(String user_state) {
		this.user_state = user_state;
	}
	public String getTeam_id_main() {
		return team_id_main;
	}
	public void setTeam_id_main(String team_id_main) {
		this.team_id_main = team_id_main;
	}
	public String getTeam_id_loc() {
		return team_id_loc;
	}
	public void setTeam_id_loc(String team_id_loc) {
		this.team_id_loc = team_id_loc;
	}
	public String getWork_level() {
		return work_level;
	}
	public void setWork_level(String work_level) {
		this.work_level = work_level;
	}
	public String getWork_type() {
		return work_type;
	}
	public void setWork_type(String work_type) {
		this.work_type = work_type;
	}
	public String getWork_level_cd() {
		return work_level_cd;
	}
	public void setWork_level_cd(String work_level_cd) {
		this.work_level_cd = work_level_cd;
	}
	public String getWork_type_cd() {
		return work_type_cd;
	}
	public void setWork_type_cd(String work_type_cd) {
		this.work_type_cd = work_type_cd;
	}
	public String getCol_val() {
		return col_val;
	}
	public void setCol_val(String col_val) {
		this.col_val = col_val;
	}
	public String getOffice_tel() {
		return office_tel;
	}
	public void setOffice_tel(String office_tel) {
		this.office_tel = office_tel;
	}
	public String getOffice_fax() {
		return office_fax;
	}
	public void setOffice_fax(String office_fax) {
		this.office_fax = office_fax;
	}
	public String getJumin_no() {
		return jumin_no;
	}
	public void setJumin_no(String jumin_no) {
		this.jumin_no = jumin_no;
	}
	public String getJumin_no1() {
		return jumin_no1;
	}
	public void setJumin_no1(String jumin_no1) {
		this.jumin_no1 = jumin_no1;
	}
	public String getJumin_no2() {
		return jumin_no2;
	}
	public void setJumin_no2(String jumin_no2) {
		this.jumin_no2 = jumin_no2;
	}
	public String getHome_address() {
		return home_address;
	}
	public void setHome_address(String home_address) {
		this.home_address = home_address;
	}
	public String getHome_tel() {
		return home_tel;
	}
	public void setHome_tel(String home_tel) {
		this.home_tel = home_tel;
	}
	public String getHandphone() {
		return handphone;
	}
	public void setHandphone(String handphone) {
		this.handphone = handphone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getJob_memo() {
		return job_memo;
	}
	public void setJob_memo(String job_memo) {
		this.job_memo = job_memo;
	}
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getJoin_date() {
		return join_date;
	}
	public void setJoin_date(String join_date) {
		this.join_date = join_date;
	}
	public String getOut_date() {
		return out_date;
	}
	public void setOut_date(String out_date) {
		this.out_date = out_date;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	public String getRownum() {
		return rownum;
	}
	public void setRownum(String rownum) {
		this.rownum = rownum;
	}
	public String getTeam_interphone() {
		return team_interphone;
	}
	public void setTeam_interphone(String team_interphone) {
		this.team_interphone = team_interphone;
	}
	public String getTeam_telephone() {
		return team_telephone;
	}
	public void setTeam_telephone(String team_telephone) {
		this.team_telephone = team_telephone;
	}
	public String getTeam_addr() {
		return team_addr;
	}
	public void setTeam_addr(String team_addr) {
		this.team_addr = team_addr;
	}
	public String getTeam_fax() {
		return team_fax;
	}
	public void setTeam_fax(String team_fax) {
		this.team_fax = team_fax;
	}
	public String getCenter_name() {
		return center_name;
	}
	public void setCenter_name(String center_name) {
		this.center_name = center_name;
	}
	
	

}
