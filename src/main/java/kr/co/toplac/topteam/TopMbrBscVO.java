package kr.co.toplac.topteam;

public class TopMbrBscVO {
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
	private String mmsPicture;  //170808 mms 이미지
	private String reg_date;
	private String join_date;
	private String out_date;
	private String team_name;
	private String center_name;
	private String team_type;
	private String team_type2;
	private String team_group_order;
	private String team_order;
	private String rownum;
	private String yearcnt;
	private String juminNo2;
	private String user_pw;
	private String pwd_date;
	private String user_sign;
	private String insa_memo_only;
	private String team_telephone;
	
	//면수습일자 추가 170406, by lds;
	private String probation_date;

	private String insa_memo;
	
	private String work_rank;
	private String work_rank_val;
	private String work_rank_cd;
	private String work_job;
	private String work_job_val;
	private String work_job_cd;
	private String work_job_code;
	private String work_job_code_val;	
	
	private String team_center;			//소속센터
	private String team_sector;			//소속부문
	
	//180618 로그메모
	private String log_memo; 
	
	//180725 팀장 여부체크
	private String team_manager_yn;
	
	//190708 계약일자 추가
	private String CTDay;
	
	//20200116 email 패스워드 추가
	private String email_pwd;
	
	//20200529 사용자 접근(로그인)아이피 추가 
	private String user_ip;
	
	//20220428 출입카드 키 추가
	private String card_key;
	
	//20220701 손해사정사 상태값 추가
	private String certi_state;
	
	//이중 인증 사용여부
	private String is_pass;
	
	//경조사 갹출 동의 여부
	private String exp_agree;
	
	//경력직 여부
	private String bonus_career_state;
	
	//현재지역
	private String person_zone;
	
	//센터장 검색용 센터 구분 팀아이디
	private String center_team_id;
		
	public String getCenter_team_id() {
		return center_team_id;
	}
	public void setCenter_team_id(String center_team_id) {
		this.center_team_id = center_team_id;
	}
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
	public String getCerti_state() {
		return certi_state;
	}
	public void setCerti_state(String certi_state) {
		this.certi_state = certi_state;
	}
	public String getCard_key() {
		return card_key;
	}
	public void setCard_key(String card_key) {
		this.card_key = card_key;
	}
	public String getTeam_center() {
		return team_center;
	}
	public void setTeam_center(String team_center) {
		this.team_center = team_center;
	}
	public String getTeam_sector() {
		return team_sector;
	}
	public void setTeam_sector(String team_sector) {
		this.team_sector = team_sector;
	}
	public String getUser_ip() {
		return user_ip;
	}
	public void setUser_ip(String user_ip) {
		this.user_ip = user_ip;
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
	public String getTeam_type() {
		return team_type;
	}
	public void setTeam_type(String team_type) {
		this.team_type = team_type;
	}
	public String getRownum() {
		return rownum;
	}
	public void setRownum(String rownum) {
		this.rownum = rownum;
	}
	public String getYearcnt() {
		return yearcnt;
	}
	public void setYearcnt(String yearcnt) {
		this.yearcnt = yearcnt;
	}
	public String getJuminNo2() {
		return juminNo2;
	}
	public void setJuminNo2(String juminNo2) {
		this.juminNo2 = juminNo2;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	public String getPwd_date() {
		return pwd_date;
	}
	public void setPwd_date(String pwd_date) {
		this.pwd_date = pwd_date;
	}
	public String getUser_sign() {
		return user_sign;
	}
	public void setUser_sign(String user_sign) {
		this.user_sign = user_sign;
	}
	public String getInsa_memo() {
		return insa_memo;
	}
	public void setInsa_memo(String insa_memo) {
		this.insa_memo = insa_memo;
	}
	public String getProbation_date() {
		return probation_date;
	}
	public void setProbation_date(String probation_date) {
		this.probation_date = probation_date;
	}

    public String getMmsPicture() {
        return mmsPicture;
    }

    public void setMmsPicture(String mmsPicture) {
        this.mmsPicture = mmsPicture;
    }
	public String getWork_rank() {
		return work_rank;
	}
	public void setWork_rank(String work_rank) {
		this.work_rank = work_rank;
	}
	public String getWork_job() {
		return work_job;
	}
	public void setWork_job(String work_job) {
		this.work_job = work_job;
	}
	public String getWork_job_code() {
		return work_job_code;
	}
	public void setWork_job_code(String work_job_code) {
		this.work_job_code = work_job_code;
	}
	public String getWork_rank_val() {
		return work_rank_val;
	}
	public void setWork_rank_val(String work_rank_val) {
		this.work_rank_val = work_rank_val;
	}
	public String getWork_job_val() {
		return work_job_val;
	}
	public void setWork_job_val(String work_job_val) {
		this.work_job_val = work_job_val;
	}
	public String getWork_job_code_val() {
		return work_job_code_val;
	}
	public void setWork_job_code_val(String work_job_code_val) {
		this.work_job_code_val = work_job_code_val;
	}
	public String getTeam_type2() {
		return team_type2;
	}
	public void setTeam_type2(String team_type2) {
		this.team_type2 = team_type2;
	}
	public String getWork_rank_cd() {
		return work_rank_cd;
	}
	public void setWork_rank_cd(String work_rank_cd) {
		this.work_rank_cd = work_rank_cd;
	}
	public String getWork_job_cd() {
		return work_job_cd;
	}
	public void setWork_job_cd(String work_job_cd) {
		this.work_job_cd = work_job_cd;
	}
	public String getTeam_group_order() {
		return team_group_order;
	}
	public void setTeam_group_order(String team_group_order) {
		this.team_group_order = team_group_order;
	}
	public String getTeam_order() {
		return team_order;
	}
	public void setTeam_order(String team_order) {
		this.team_order = team_order;
	}
	public String getCenter_name() {
		return center_name;
	}
	public void setCenter_name(String center_name) {
		this.center_name = center_name;
	}
	public String getLog_memo() {
		return log_memo;
	}
	public void setLog_memo(String log_memo) {
		this.log_memo = log_memo;
	}
	public String getTeam_telephone() {
		return team_telephone;
	}
	public void setTeam_telephone(String team_telephone) {
		this.team_telephone = team_telephone;
	}
	public String getTeam_manager_yn() {
		return team_manager_yn;
	}
	public void setTeam_manager_yn(String team_manager_yn) {
		this.team_manager_yn = team_manager_yn;
	}
	
    
    
}
