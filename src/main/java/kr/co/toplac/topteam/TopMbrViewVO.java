package kr.co.toplac.topteam;

public class TopMbrViewVO {
	
	private String user_no;
	private String user_id;
	
	private String comment;
	private String picture;
	private String user_state;
	private String curr_user_state;
	private String team_id_main;
	private String team_id_loc;
	
	private String work_level;
	private String work_type;
	private String join_date;
	private String out_date;
	private String probation_date;//면수습일 추가 170406 by lds;
	private String CTDay;				//계약일자추가 190708 by top3009;
	
	private String job_memo;
	private String insa_memo;
	private String insa_memo_only;
	
	private String officetel_1;
	private String officetel_2;
	private String officetel_3;
	
	private String handphone_1;
	private String handphone_2;
	private String handphone_3;
	
	private String home_tel_1;
	private String home_tel_2;
	private String home_tel_3;
	
	
	private String officefax_1;
	private String officefax_2;
	private String officefax_3;
	
	private String home_address;
	
	private String email;
	
	private String workLevel;
	private String workType;
	private String workRank;
	private String workJob;
	
	private String email_pwd;
	
	private String is_pass;			//카카오(문자) 인증 사용여부
	
	private String exp_agree;		//경조사 갹출 동의여부
	
	private String bonus_career_state;			//성과급 신입/경력 여부
	
	private String person_zone;					//현재지역
	
	public String getPerson_zone() {
		return person_zone;
	}

	public void setPerson_zone(String person_zone) {
		this.person_zone = person_zone;
	}

	public String getBonus_career_state() {
		return bonus_career_state;
	}

	public void setBonus_career_state(String bonus_career_state) {
		this.bonus_career_state = bonus_career_state;
	}

	public String getExp_agree() {
		return exp_agree;
	}

	public void setExp_agree(String exp_agree) {
		this.exp_agree = exp_agree;
	}

	public String getIs_pass() {
		return is_pass;
	}

	public void setIs_pass(String is_pass) {
		this.is_pass = is_pass;
	}

	public String getEmail_pwd() {
		return email_pwd;
	}

	public void setEmail_pwd(String email_pwd) {
		this.email_pwd = email_pwd;
	}

	public String getCTDay() {
		return CTDay;
	}

	public void setCTDay(String cTDay) {
		CTDay = cTDay;
	}

	public String getInsa_memo_only() {
		return insa_memo_only;
	}

	public void setInsa_memo_only(String insa_memo_only) {
		this.insa_memo_only = insa_memo_only;
	}

	public String getUser_no() {
		return user_no;
	}

	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
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

	public String getJob_memo() {
		return job_memo;
	}

	public void setJob_memo(String job_memo) {
		this.job_memo = job_memo;
	}

	public String getTeam_id_loc() {
		return team_id_loc;
	}

	public void setTeam_id_loc(String team_id_loc) {
		this.team_id_loc = team_id_loc;
	}

	public String getOfficetel_1() {
		return officetel_1;
	}

	public void setOfficetel_1(String officetel_1) {
		this.officetel_1 = officetel_1;
	}

	public String getOfficetel_2() {
		return officetel_2;
	}

	public void setOfficetel_2(String officetel_2) {
		this.officetel_2 = officetel_2;
	}

	public String getOfficetel_3() {
		return officetel_3;
	}

	public void setOfficetel_3(String officetel_3) {
		this.officetel_3 = officetel_3;
	}

	public String getHandphone_1() {
		return handphone_1;
	}

	public void setHandphone_1(String handphone_1) {
		this.handphone_1 = handphone_1;
	}

	public String getHandphone_2() {
		return handphone_2;
	}

	public void setHandphone_2(String handphone_2) {
		this.handphone_2 = handphone_2;
	}

	public String getHandphone_3() {
		return handphone_3;
	}

	public void setHandphone_3(String handphone_3) {
		this.handphone_3 = handphone_3;
	}

	public String getHome_tel_1() {
		return home_tel_1;
	}

	public void setHome_tel_1(String home_tel_1) {
		this.home_tel_1 = home_tel_1;
	}

	public String getHome_tel_2() {
		return home_tel_2;
	}

	public void setHome_tel_2(String home_tel_2) {
		this.home_tel_2 = home_tel_2;
	}

	public String getHome_tel_3() {
		return home_tel_3;
	}

	public void setHome_tel_3(String home_tel_3) {
		this.home_tel_3 = home_tel_3;
	}

	public String getOfficefax_1() {
		return officefax_1;
	}

	public void setOfficefax_1(String officefax_1) {
		this.officefax_1 = officefax_1;
	}

	public String getOfficefax_2() {
		return officefax_2;
	}

	public void setOfficefax_2(String officefax_2) {
		this.officefax_2 = officefax_2;
	}

	public String getOfficefax_3() {
		return officefax_3;
	}

	public void setOfficefax_3(String officefax_3) {
		this.officefax_3 = officefax_3;
	}

	public String getHome_address() {
		return home_address;
	}

	public void setHome_address(String home_address) {
		this.home_address = home_address;
	}

	public String getInsa_memo() {
		return insa_memo;
	}

	public void setInsa_memo(String insa_memo) {
		this.insa_memo = insa_memo;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getProbation_date() {
		return probation_date;
	}

	public void setProbation_date(String probation_date) {
		this.probation_date = probation_date;
	}

	public String getWorkLevel() {
		return workLevel;
	}

	public void setWorkLevel(String workLevel) {
		this.workLevel = workLevel;
	}

	public String getWorkType() {
		return workType;
	}

	public void setWorkType(String workType) {
		this.workType = workType;
	}

	public String getWorkRank() {
		return workRank;
	}

	public void setWorkRank(String workRank) {
		this.workRank = workRank;
	}

	public String getWorkJob() {
		return workJob;
	}

	public void setWorkJob(String workJob) {
		this.workJob = workJob;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getCurr_user_state() {
		return curr_user_state;
	}

	public void setCurr_user_state(String curr_user_state) {
		this.curr_user_state = curr_user_state;
	}
	
	

	
}
