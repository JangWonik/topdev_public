package kr.co.toplac.topvaction;

/**
 * 휴가할당 및 사용내역 Bean
 * 2019.05.10
 * @author top3009
 */

public class VacationUseBean {
	private int serial_no = 0;					//고유키
	private int user_no = 0;					//사번
	private double annual_set = 0;		//연차할당일수
	private double annual_use = 0;		//연차사용일수
	private double annual_apply = 0;		//연차신청일수(결재완료, 신청 취소시 차감됨)
	private double vacation_apply = 0;	//휴가신청일수
	private double vacation_use = 0;		//휴가사용일수	
	private String base_date = "";			//기준년도
	private String now_date = "";			//신청년도
	private String annual_start_date = "";		//연차발생사용 시작날짜
	private String annual_end_date = "";			//연차발생사용 종료날짜
	private int base_year = 0;				//입사일자기준:연차기준년도
	private String reg_date = "";			//등록일
	private double vacation_progress = 0;		//휴가 사용율
	private double day_progress = 0;		//기간 사용율
	
	//추가Bean
	private String center_name = "";			//센터명
	private String team_name = "";			//팀명
	private String user_name = "";				//직원이름
	private String work_level_nm = "";		//직급명
	private String join_date = "";				//입사일
	private String team_id = "";					//팀아이디
	private String team_type = "0";			//팀타입 (0,1:물보험 // 4:인보험)
	
	public String getTeam_type() {
		return team_type;
	}
	public void setTeam_type(String team_type) {
		this.team_type = team_type;
	}
	public String getTeam_id() {
		return team_id;
	}
	public void setTeam_id(String team_id) {
		this.team_id = team_id;
	}
	public double getDay_progress() {
		return day_progress;
	}
	public void setDay_progress(double day_progress) {
		this.day_progress = day_progress;
	}
	public String getCenter_name() {
		return center_name;
	}
	public void setCenter_name(String center_name) {
		this.center_name = center_name;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getWork_level_nm() {
		return work_level_nm;
	}
	public void setWork_level_nm(String work_level_nm) {
		this.work_level_nm = work_level_nm;
	}
	public String getJoin_date() {
		return join_date;
	}
	public void setJoin_date(String join_date) {
		this.join_date = join_date;
	}
	public double getVacation_progress() {
		return vacation_progress;
	}
	public void setVacation_progress(double vacation_progress) {
		this.vacation_progress = vacation_progress;
	}
	public String getAnnual_start_date() {
		return annual_start_date;
	}
	public void setAnnual_start_date(String annual_start_date) {
		this.annual_start_date = annual_start_date;
	}
	public String getAnnual_end_date() {
		return annual_end_date;
	}
	public void setAnnual_end_date(String annual_end_date) {
		this.annual_end_date = annual_end_date;
	}
	public int getBase_year() {
		return base_year;
	}
	public void setBase_year(int base_year) {
		this.base_year = base_year;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public double getAnnual_apply() {
		return annual_apply;
	}
	public void setAnnual_apply(double annual_apply) {
		this.annual_apply = annual_apply;
	}
	public String getNow_date() {
		return now_date;
	}
	public void setNow_date(String now_date) {
		this.now_date = now_date;
	}
	public int getSerial_no() {
		return serial_no;
	}
	public void setSerial_no(int serial_no) {
		this.serial_no = serial_no;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public double getAnnual_set() {
		return annual_set;
	}
	public void setAnnual_set(double annual_set) {
		this.annual_set = annual_set;
	}
	public double getAnnual_use() {
		return annual_use;
	}
	public void setAnnual_use(double annual_use) {
		this.annual_use = annual_use;
	}
	public double getVacation_apply() {
		return vacation_apply;
	}
	public void setVacation_apply(double vacation_apply) {
		this.vacation_apply = vacation_apply;
	}
	public double getVacation_use() {
		return vacation_use;
	}
	public void setVacation_use(double vacation_use) {
		this.vacation_use = vacation_use;
	}
	public String getBase_date() {
		return base_date;
	}
	public void setBase_date(String base_date) {
		this.base_date = base_date;
	}
}
