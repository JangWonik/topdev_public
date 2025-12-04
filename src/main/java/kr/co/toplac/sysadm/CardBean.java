package kr.co.toplac.sysadm;

public class CardBean {
	
	private int ckey = 0;				//고유번호
	private int user_no = 0;			//소유자번호	
	private String card_number = "";				//장비일련번호
	private int card_state = 0;				//카드상태(0:미사용,1:사용중,2:폐기,3:분실,4:기타)  
	private int card_type = 0;					//카드종류(0:정상,1:임시)
	private String card_memo = "";			//카드 메모
	private String reg_date = "";				//카드 등록일
	private String mod_date = "";			//카드 수정일
	
	private String center_name = "";			//센터명
	private String team_id = "";					//팀아이디
	private String team_name = "";				//부서명
	private String user_name = "";				//소유자이름
	private String card_type_nm = "";			//장비타입이름
	private String card_state_nm = "";			//장비상태이름
	private String team_type = "";				//종구분(0,1,4)
	
	private int is_del = 0;							//삭제여부 (0:정상, 1:삭제)
	private String del_date = "";					//삭제일
	
	private String card_zone = "";				//카드사용지역 코드
	private String card_zone_nm = "";			//카드사용지역 이름
	
	private String card_uid = "";					//카드별칭
	private String card_serial_no = "";			//카드 시리얼 번호
	
	public String getMod_date() {
		return mod_date;
	}
	public void setMod_date(String mod_date) {
		this.mod_date = mod_date;
	}
	public String getCard_serial_no() {
		return card_serial_no;
	}
	public void setCard_serial_no(String card_serial_no) {
		this.card_serial_no = card_serial_no;
	}
	public String getCard_uid() {
		return card_uid;
	}
	public void setCard_uid(String card_uid) {
		this.card_uid = card_uid;
	}
	public int getCkey() {
		return ckey;
	}
	public void setCkey(int ckey) {
		this.ckey = ckey;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public String getCard_number() {
		return card_number;
	}
	public void setCard_number(String card_number) {
		this.card_number = card_number;
	}
	public int getCard_state() {
		return card_state;
	}
	public void setCard_state(int card_state) {
		this.card_state = card_state;
	}
	public int getCard_type() {
		return card_type;
	}
	public void setCard_type(int card_type) {
		this.card_type = card_type;
	}
	public String getCard_memo() {
		return card_memo;
	}
	public void setCard_memo(String card_memo) {
		this.card_memo = card_memo;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getCenter_name() {
		return center_name;
	}
	public void setCenter_name(String center_name) {
		this.center_name = center_name;
	}
	public String getTeam_id() {
		return team_id;
	}
	public void setTeam_id(String team_id) {
		this.team_id = team_id;
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
	public String getCard_type_nm() {
		return card_type_nm;
	}
	public void setCard_type_nm(String card_type_nm) {
		this.card_type_nm = card_type_nm;
	}
	public String getCard_state_nm() {
		return card_state_nm;
	}
	public void setCard_state_nm(String card_state_nm) {
		this.card_state_nm = card_state_nm;
	}
	public String getTeam_type() {
		return team_type;
	}
	public void setTeam_type(String team_type) {
		this.team_type = team_type;
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
	public String getCard_zone() {
		return card_zone;
	}
	public void setCard_zone(String card_zone) {
		this.card_zone = card_zone;
	}
	public String getCard_zone_nm() {
		return card_zone_nm;
	}
	public void setCard_zone_nm(String card_zone_nm) {
		this.card_zone_nm = card_zone_nm;
	}
	
}
