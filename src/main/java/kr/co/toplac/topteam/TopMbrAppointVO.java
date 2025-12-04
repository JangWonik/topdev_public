package kr.co.toplac.topteam;

public class TopMbrAppointVO {
	
	//발령사항
	private String user_no;
	private String appoint_date;
	private String appoint_depart;
	private String appoint_team_id;
	private String appoint_work_level; 	//직위
	private String appoint_work_level_cd; 	//직위코드
	private String appoint_work_rank;	//직급
	private String appoint_work_rank_cd;	//직급코드
	private String appoint_work_type;	//직책
	private String appoint_work_type_cd;	//직책코드
	private String appoint_work_job;	//직무
	private String appoint_work_job_cd;	//직무코드
	private String appoint_work_job_tm_type;		//직무코드 팀 타입(1,4종)
	private String appoint_place;
	private String appoint_comment;
	private String appoint_etc;
	private String appoint_position;
	private String appoint_no;
	
	//진급사항
	private String position_date;
	private String position_depart;
	private String position_team_id;			//팀코드
	private String position_work_level;
	private String position_work_level_cd;		//직위코드
	private String position_work_rank;
	private String position_work_rank_cd;		//직급코드
	private String position_work_type;
	private String position_work_type_cd;		//직무코드
	private String position_place;
	private String position_comment;
	private String position_etc;
	private String position_no;	
	
	public String getPosition_team_id() {
		return position_team_id;
	}
	public void setPosition_team_id(String position_team_id) {
		this.position_team_id = position_team_id;
	}
	public String getPosition_work_level_cd() {
		return position_work_level_cd;
	}
	public void setPosition_work_level_cd(String position_work_level_cd) {
		this.position_work_level_cd = position_work_level_cd;
	}
	public String getPosition_work_rank_cd() {
		return position_work_rank_cd;
	}
	public void setPosition_work_rank_cd(String position_work_rank_cd) {
		this.position_work_rank_cd = position_work_rank_cd;
	}
	public String getPosition_work_type_cd() {
		return position_work_type_cd;
	}
	public void setPosition_work_type_cd(String position_work_type_cd) {
		this.position_work_type_cd = position_work_type_cd;
	}
	public String getAppoint_work_type_cd() {
		return appoint_work_type_cd;
	}
	public void setAppoint_work_type_cd(String appoint_work_type_cd) {
		this.appoint_work_type_cd = appoint_work_type_cd;
	}
	public String getAppoint_work_rank_cd() {
		return appoint_work_rank_cd;
	}
	public void setAppoint_work_rank_cd(String appoint_work_rank_cd) {
		this.appoint_work_rank_cd = appoint_work_rank_cd;
	}
	public String getAppoint_work_level_cd() {
		return appoint_work_level_cd;
	}
	public void setAppoint_work_level_cd(String appoint_work_level_cd) {
		this.appoint_work_level_cd = appoint_work_level_cd;
	}
	public String getAppoint_work_job_tm_type() {
		return appoint_work_job_tm_type;
	}
	public void setAppoint_work_job_tm_type(String appoint_work_job_tm_type) {
		this.appoint_work_job_tm_type = appoint_work_job_tm_type;
	}
	public String getAppoint_team_id() {
		return appoint_team_id;
	}
	public void setAppoint_team_id(String appoint_team_id) {
		this.appoint_team_id = appoint_team_id;
	}
	public String getAppoint_no() {
		return appoint_no;
	}
	public void setAppoint_no(String appoint_no) {
		this.appoint_no = appoint_no;
	}
	public String getPosition_no() {
		return position_no;
	}
	public void setPosition_no(String position_no) {
		this.position_no = position_no;
	}
	public String getUser_no() {
		return user_no;
	}
	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}
	public String getAppoint_date() {
		return appoint_date;
	}
	public void setAppoint_date(String appoint_date) {
		this.appoint_date = appoint_date;
	}
	public String getAppoint_depart() {
		return appoint_depart;
	}
	public void setAppoint_depart(String appoint_depart) {
		this.appoint_depart = appoint_depart;
	}
	public String getAppoint_place() {
		return appoint_place;
	}
	public void setAppoint_place(String appoint_place) {
		this.appoint_place = appoint_place;
	}
	public String getAppoint_comment() {
		return appoint_comment;
	}
	public void setAppoint_comment(String appoint_comment) {
		this.appoint_comment = appoint_comment;
	}
	public String getAppoint_etc() {
		return appoint_etc;
	}
	public void setAppoint_etc(String appoint_etc) {
		this.appoint_etc = appoint_etc;
	}
	public String getPosition_date() {
		return position_date;
	}
	public void setPosition_date(String position_date) {
		this.position_date = position_date;
	}
	public String getPosition_depart() {
		return position_depart;
	}
	public void setPosition_depart(String position_depart) {
		this.position_depart = position_depart;
	}
	public String getPosition_place() {
		return position_place;
	}
	public void setPosition_place(String position_place) {
		this.position_place = position_place;
	}
	public String getPosition_comment() {
		return position_comment;
	}
	public void setPosition_comment(String position_comment) {
		this.position_comment = position_comment;
	}
	public String getPosition_etc() {
		return position_etc;
	}
	public void setPosition_etc(String position_etc) {
		this.position_etc = position_etc;
	}
	
	public String getAppoint_position() {
		return appoint_position;
	}
	public void setAppoint_position(String appoint_position) {
		this.appoint_position = appoint_position;
	}
	public String getAppoint_work_level() {
		return appoint_work_level;
	}
	public void setAppoint_work_level(String appoint_work_level) {
		this.appoint_work_level = appoint_work_level;
	}
	public String getAppoint_work_rank() {
		return appoint_work_rank;
	}
	public void setAppoint_work_rank(String appoint_work_rank) {
		this.appoint_work_rank = appoint_work_rank;
	}
	public String getAppoint_work_type() {
		return appoint_work_type;
	}
	public void setAppoint_work_type(String appoint_work_type) {
		this.appoint_work_type = appoint_work_type;
	}
	public String getAppoint_work_job() {
		return appoint_work_job;
	}
	public void setAppoint_work_job(String appoint_work_job) {
		this.appoint_work_job = appoint_work_job;
	}
	public String getAppoint_work_job_cd() {
		return appoint_work_job_cd;
	}
	public void setAppoint_work_job_cd(String appoint_work_job_cd) {
		this.appoint_work_job_cd = appoint_work_job_cd;
	}
	public String getPosition_work_level() {
		return position_work_level;
	}
	public void setPosition_work_level(String position_work_level) {
		this.position_work_level = position_work_level;
	}
	public String getPosition_work_rank() {
		return position_work_rank;
	}
	public void setPosition_work_rank(String position_work_rank) {
		this.position_work_rank = position_work_rank;
	}
	public String getPosition_work_type() {
		return position_work_type;
	}
	public void setPosition_work_type(String position_work_type) {
		this.position_work_type = position_work_type;
	}
	
	
	
	
}
