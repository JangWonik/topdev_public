package kr.co.toplac.topteam;

public class TopMbrWorkVO {
	String work_no;							//휴 복직키
	String user_no;							//사번
	String work_sdate;						//휴직 시작 일자
	String work_sdate_fmt;				//휴직 시작 일자 (YYYY-MM-DD)형식
	String work_edate;						//휴직 종료 일자
	String work_edate_fmt;				//휴직 종료 일자 (YYYY-MM-DD)형식
	String leave_type;						//휴직유형
	String leave_type_val;					//휴직유형명칭
	String leave_interval;					//휴직기간
	String work_comment;					//휴 복직 사유	
	String work_etc;							//비고
	String reg_date;							//등록일
	String reg_user_no;						//등록 / 수정자
	String work_team_id;					//팀아이디
	String work_team_id_val;				//팀명
	String work_level;						//직위코드
	String work_level_val;					//직위명
	String work_interval;					//소정근로일수
	
	public String getWork_interval() {
		return work_interval;
	}
	public void setWork_interval(String work_interval) {
		this.work_interval = work_interval;
	}
	public String getWork_sdate() {
		return work_sdate;
	}
	public void setWork_sdate(String work_sdate) {
		this.work_sdate = work_sdate;
	}
	public String getWork_sdate_fmt() {
		return work_sdate_fmt;
	}
	public void setWork_sdate_fmt(String work_sdate_fmt) {
		this.work_sdate_fmt = work_sdate_fmt;
	}
	public String getWork_edate() {
		return work_edate;
	}
	public void setWork_edate(String work_edate) {
		this.work_edate = work_edate;
	}
	public String getWork_edate_fmt() {
		return work_edate_fmt;
	}
	public void setWork_edate_fmt(String work_edate_fmt) {
		this.work_edate_fmt = work_edate_fmt;
	}
	public String getLeave_type_val() {
		return leave_type_val;
	}
	public void setLeave_type_val(String leave_type_val) {
		this.leave_type_val = leave_type_val;
	}
	public String getWork_team_id() {
		return work_team_id;
	}
	public void setWork_team_id(String work_team_id) {
		this.work_team_id = work_team_id;
	}
	public String getWork_team_id_val() {
		return work_team_id_val;
	}
	public void setWork_team_id_val(String work_team_id_val) {
		this.work_team_id_val = work_team_id_val;
	}
	public String getWork_level() {
		return work_level;
	}
	public void setWork_level(String work_level) {
		this.work_level = work_level;
	}
	public String getWork_level_val() {
		return work_level_val;
	}
	public void setWork_level_val(String work_level_val) {
		this.work_level_val = work_level_val;
	}	
	public String getWork_no() {
		return work_no;
	}
	public void setWork_no(String work_no) {
		this.work_no = work_no;
	}
	public String getUser_no() {
		return user_no;
	}
	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}	
	public String getLeave_type() {
		return leave_type;
	}
	public void setLeave_type(String leave_type) {
		this.leave_type = leave_type;
	}
	public String getLeave_interval() {
		return leave_interval;
	}
	public void setLeave_interval(String leave_interval) {
		this.leave_interval = leave_interval;
	}
	public String getWork_comment() {
		return work_comment;
	}
	public void setWork_comment(String work_comment) {
		this.work_comment = work_comment;
	}	
	public String getWork_etc() {
		return work_etc;
	}
	public void setWork_etc(String work_etc) {
		this.work_etc = work_etc;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getReg_user_no() {
		return reg_user_no;
	}
	public void setReg_user_no(String reg_user_no) {
		this.reg_user_no = reg_user_no;
	}
}
