package kr.co.toplac.sysadm;

public class EquipmentBean {
	
	private int serial_no = 0;			//고유번호
	private int user_no = 0;				//소유자번호
	private int team_id = 0;			//소유팀아이디 (9999 : 서버실보유장비)
	private String eq_no = "";				//장비일련번호
	private int eq_state = 0;				//장비상태 (0:대기,1:사용중,2:고장,9:폐기)
	private int eq_type = 0;					//장비종류 (0:없음,1:데스크탑,2:노트북,9:기타)
	private String eq_memo = "";			//장비 메모
	private String reg_date = "";			//장비 등록일
	private String close_date = "";			//장비 폐기일
	private long eq_price = 0;				//장비가격
	
	private String center_name = "";			//센터명
	private String team_name = "";			//부서명
	private String user_name = "";				//소유자이름
	private String eq_type_nm = "";			//장비타입이름
	private String eq_state_nm = "";			//장비상태이름
	private String team_type = "";				//종구분(0,1,4)
	
	private int is_del = 0;							//삭제여부 (0:정상, 1:삭제)
	private String del_date = "";				//삭제일
	
	private int cpu_info = 0;					//CPU 종류코드
	private String cpu_info_nm = "";		//CPU 이름
	private int memory_size = 0;			//RAM 크기
	
	public int getCpu_info() {
		return cpu_info;
	}
	public void setCpu_info(int cpu_info) {
		this.cpu_info = cpu_info;
	}
	public String getCpu_info_nm() {
		return cpu_info_nm;
	}
	public void setCpu_info_nm(String cpu_info_nm) {
		this.cpu_info_nm = cpu_info_nm;
	}
	public int getMemory_size() {
		return memory_size;
	}
	public void setMemory_size(int memory_size) {
		this.memory_size = memory_size;
	}
	public int getIs_del() {
		return is_del;
	}
	public void setIs_del(int is_del) {
		this.is_del = is_del;
	}
	public String getDel_date() {
		return del_date;
	}
	public void setDel_date(String del_date) {
		this.del_date = del_date;
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
	public String getEq_type_nm() {
		return eq_type_nm;
	}
	public void setEq_type_nm(String eq_type_nm) {
		this.eq_type_nm = eq_type_nm;
	}
	public String getEq_state_nm() {
		return eq_state_nm;
	}
	public void setEq_state_nm(String eq_state_nm) {
		this.eq_state_nm = eq_state_nm;
	}
	public String getTeam_type() {
		return team_type;
	}
	public void setTeam_type(String team_type) {
		this.team_type = team_type;
	}
	public long getEq_price() {
		return eq_price;
	}
	public void setEq_price(long eq_price) {
		this.eq_price = eq_price;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getClose_date() {
		return close_date;
	}
	public void setClose_date(String close_date) {
		this.close_date = close_date;
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
	public int getTeam_id() {
		return team_id;
	}
	public void setTeam_id(int team_id) {
		this.team_id = team_id;
	}
	public String getEq_no() {
		return eq_no;
	}
	public void setEq_no(String eq_no) {
		this.eq_no = eq_no;
	}
	public int getEq_state() {
		return eq_state;
	}
	public void setEq_state(int eq_state) {
		this.eq_state = eq_state;
	}
	public int getEq_type() {
		return eq_type;
	}
	public void setEq_type(int eq_type) {
		this.eq_type = eq_type;
	}
	public String getEq_memo() {
		return eq_memo;
	}
	public void setEq_memo(String eq_memo) {
		this.eq_memo = eq_memo;
	}	
}
