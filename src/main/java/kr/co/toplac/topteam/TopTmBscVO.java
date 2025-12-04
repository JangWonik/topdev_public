package kr.co.toplac.topteam;

public class TopTmBscVO {
	
	private String team_id;
	private String team_level;
	private String team_group_order;
	private String team_order;
	private String team_type;
	private String suim_scode;
	private String suim_ecode;
	private String team_name;
	private String team_interphone;
	private String team_telephone;
	private String team_fax;
	private String team_addr;
	private String team_mark;
	private String team_manager;
	private String team_statistics1;
	private String team_statistics4;
	private String only_statistics;
	private String originTeamCode;
	private String cnt;
	private String team_sector;
	private String team_sector_val;
	private String team_center;
	private String team_center_val;
	private String team_written;				//서면심사팀 여부 (0:일반팀, 1:서면심사팀)
	private String written_ptnr_id;			//서면심사팀의 경우 소속 보험사
	private String team_part;					//팀 업무구분 (0:없음, 1:실무팀, 2:지원팀, 3:센터, 4:부문)
	private String team_zone;					//팀 지역구분(0:본사, 그 외 sysadm_codedic 참고)
	private String team_ptnr_id;				//팀 보험사 지정(0:없음, top_ptnr_bsc 외래키)
	
	public String getTeam_zone() {
		return team_zone;
	}
	public void setTeam_zone(String team_zone) {
		this.team_zone = team_zone;
	}
	public String getTeam_ptnr_id() {
		return team_ptnr_id;
	}
	public void setTeam_ptnr_id(String team_ptnr_id) {
		this.team_ptnr_id = team_ptnr_id;
	}
	public String getTeam_part() {
		return team_part;
	}
	public void setTeam_part(String team_part) {
		this.team_part = team_part;
	}
	public String getWritten_ptnr_id() {
		return written_ptnr_id;
	}
	public void setWritten_ptnr_id(String written_ptnr_id) {
		this.written_ptnr_id = written_ptnr_id;
	}
	public String getTeam_written() {
		return team_written;
	}
	public void setTeam_written(String team_written) {
		this.team_written = team_written;
	}
	public String getTeam_center() {
		return team_center;
	}
	public void setTeam_center(String team_center) {
		this.team_center = team_center;
	}
	public String getTeam_center_val() {
		return team_center_val;
	}
	public void setTeam_center_val(String team_center_val) {
		this.team_center_val = team_center_val;
	}
	public String getTeam_sector_val() {
		return team_sector_val;
	}
	public void setTeam_sector_val(String team_sector_val) {
		this.team_sector_val = team_sector_val;
	}
	public String getTeam_sector() {
		return team_sector;
	}
	public void setTeam_sector(String team_sector) {
		this.team_sector = team_sector;
	}
	public String getTeam_id() {
		return team_id;
	}
	public void setTeam_id(String team_id) {
		this.team_id = team_id;
	}
	public String getTeam_level() {
		return team_level;
	}
	public void setTeam_level(String team_level) {
		this.team_level = team_level;
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
	public String getTeam_type() {
		return team_type;
	}
	public void setTeam_type(String team_type) {
		this.team_type = team_type;
	}
	public String getSuim_scode() {
		return suim_scode;
	}
	public void setSuim_scode(String suim_scode) {
		this.suim_scode = suim_scode;
	}
	public String getSuim_ecode() {
		return suim_ecode;
	}
	public void setSuim_ecode(String suim_ecode) {
		this.suim_ecode = suim_ecode;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
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
	public String getTeam_fax() {
		return team_fax;
	}
	public void setTeam_fax(String team_fax) {
		this.team_fax = team_fax;
	}
	public String getTeam_addr() {
		return team_addr;
	}
	public void setTeam_addr(String team_addr) {
		this.team_addr = team_addr;
	}
	public String getTeam_mark() {
		return team_mark;
	}
	public void setTeam_mark(String team_mark) {
		this.team_mark = team_mark;
	}
	public String getTeam_statistics1() {
		return team_statistics1;
	}
	public void setTeam_statistics1(String team_statistics1) {
		this.team_statistics1 = team_statistics1;
	}
	public String getTeam_statistics4() {
		return team_statistics4;
	}
	public void setTeam_statistics4(String team_statistics4) {
		this.team_statistics4 = team_statistics4;
	}
	public String getOnly_statistics() {
		return only_statistics;
	}
	public void setOnly_statistics(String only_statistics) {
		this.only_statistics = only_statistics;
	}
	public String getOriginTeamCode() {
		return originTeamCode;
	}
	public void setOriginTeamCode(String originTeamCode) {
		this.originTeamCode = originTeamCode;
	}
	public String getCnt() {
		return cnt;
	}
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	public String getTeam_manager() {
		return team_manager;
	}
	public void setTeam_manager(String team_manager) {
		this.team_manager = team_manager;
	}


}
