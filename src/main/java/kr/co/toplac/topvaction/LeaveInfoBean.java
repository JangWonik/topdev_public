package kr.co.toplac.topvaction;

public class LeaveInfoBean {
	private int serial_no = 0;						//고유키
	private int user_no = 0;						//신청자사번
	private String user_id = "";					//사용자아이디
	
	private String center_name = "";			//센터명
	private String team_name = "";			//팀명
	private String user_name = "";				//신청자이름
	
	private String work_level = "";				//신청자 직급
	private String join_date = "";				//신청자 입사일
	
	private int leave_type = 0;				//1001:육아휴직, 2001:가족돌봄휴직, 9001:기타휴직
	private String leave_type_val = "";	//leave_type 으로 가져온 코드 한글값
	private String leave_content = "";		//휴직사유
	
	private int approval_state = 0;				//팀장승인대기 : 10, 센터장 승인대기 : 20, 최종승인대기 : 30, 팀장반려 : 12, 센터장 반려 : 22, 최종반려 : 32, 최종승인 : 31
	private String approval_state_val = "";		//approval_state 으로 가져온 코드 한글값
	private String sdate = "";						//휴직시작일
	private String edate = "";						//휴직종료일
	
	private int approvaler_01 = 0;				//1차결재자(팀장)
	private int approvaler_02 = 0;				//2차결재자(센터장)
	private int approvaler_03 = 0;				//3차결재자(인사총무팀장)
	
	private String approvaler_01_val = "";				//1차결재자(팀장)이름
	private String approvaler_02_val = "";				//2차결재자(센터장)이름
	private String approvaler_03_val = "";				//3차결재자(인사총무팀장)이름
	
	private String ap_date_01 = "";			//1차결재일자
	private String ap_date_02 = "";			//2차결재일자
	private String ap_date_03 = "";			//3차결재일자
	
	private String ap_comment_01 = "";		//1차결재의견
	private String ap_comment_02 = "";		//2차결재의견
	private String ap_comment_03 = "";		//3차결재의견
	
	private int approvaler_now = 0;			//현재결재자사번
	private String approvaler_now_name = "";			//현재결재자 이름
	
	private String regdate = "";					//휴직신청일자
	private String cancel_date = "";			//휴직취소일자
	
	private double use_count = 0;			//휴직신청 일수 (휴무일 제외)
	private double leave_interval = 0;	//휴직신청일수 (휴무일 포함)
	private double work_interval = 0;		//소정근로일수
	
	public double getWork_interval() {
		return work_interval;
	}
	public void setWork_interval(double work_interval) {
		this.work_interval = work_interval;
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
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
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
	public String getWork_level() {
		return work_level;
	}
	public void setWork_level(String work_level) {
		this.work_level = work_level;
	}
	public String getJoin_date() {
		return join_date;
	}
	public void setJoin_date(String join_date) {
		this.join_date = join_date;
	}
	public int getLeave_type() {
		return leave_type;
	}
	public void setLeave_type(int leave_type) {
		this.leave_type = leave_type;
	}
	public String getLeave_type_val() {
		return leave_type_val;
	}
	public void setLeave_type_val(String leave_type_val) {
		this.leave_type_val = leave_type_val;
	}
	public String getLeave_content() {
		return leave_content;
	}
	public void setLeave_content(String leave_content) {
		this.leave_content = leave_content;
	}
	public int getApproval_state() {
		return approval_state;
	}
	public void setApproval_state(int approval_state) {
		this.approval_state = approval_state;
	}
	public String getApproval_state_val() {
		return approval_state_val;
	}
	public void setApproval_state_val(String approval_state_val) {
		this.approval_state_val = approval_state_val;
	}
	public String getSdate() {
		return sdate;
	}
	public void setSdate(String sdate) {
		this.sdate = sdate;
	}
	public String getEdate() {
		return edate;
	}
	public void setEdate(String edate) {
		this.edate = edate;
	}
	public int getApprovaler_01() {
		return approvaler_01;
	}
	public void setApprovaler_01(int approvaler_01) {
		this.approvaler_01 = approvaler_01;
	}
	public int getApprovaler_02() {
		return approvaler_02;
	}
	public void setApprovaler_02(int approvaler_02) {
		this.approvaler_02 = approvaler_02;
	}
	public int getApprovaler_03() {
		return approvaler_03;
	}
	public void setApprovaler_03(int approvaler_03) {
		this.approvaler_03 = approvaler_03;
	}
	public String getApprovaler_01_val() {
		return approvaler_01_val;
	}
	public void setApprovaler_01_val(String approvaler_01_val) {
		this.approvaler_01_val = approvaler_01_val;
	}
	public String getApprovaler_02_val() {
		return approvaler_02_val;
	}
	public void setApprovaler_02_val(String approvaler_02_val) {
		this.approvaler_02_val = approvaler_02_val;
	}
	public String getApprovaler_03_val() {
		return approvaler_03_val;
	}
	public void setApprovaler_03_val(String approvaler_03_val) {
		this.approvaler_03_val = approvaler_03_val;
	}
	public String getAp_date_01() {
		return ap_date_01;
	}
	public void setAp_date_01(String ap_date_01) {
		this.ap_date_01 = ap_date_01;
	}
	public String getAp_date_02() {
		return ap_date_02;
	}
	public void setAp_date_02(String ap_date_02) {
		this.ap_date_02 = ap_date_02;
	}
	public String getAp_date_03() {
		return ap_date_03;
	}
	public void setAp_date_03(String ap_date_03) {
		this.ap_date_03 = ap_date_03;
	}
	public String getAp_comment_01() {
		return ap_comment_01;
	}
	public void setAp_comment_01(String ap_comment_01) {
		this.ap_comment_01 = ap_comment_01;
	}
	public String getAp_comment_02() {
		return ap_comment_02;
	}
	public void setAp_comment_02(String ap_comment_02) {
		this.ap_comment_02 = ap_comment_02;
	}
	public String getAp_comment_03() {
		return ap_comment_03;
	}
	public void setAp_comment_03(String ap_comment_03) {
		this.ap_comment_03 = ap_comment_03;
	}
	public int getApprovaler_now() {
		return approvaler_now;
	}
	public void setApprovaler_now(int approvaler_now) {
		this.approvaler_now = approvaler_now;
	}
	public String getApprovaler_now_name() {
		return approvaler_now_name;
	}
	public void setApprovaler_now_name(String approvaler_now_name) {
		this.approvaler_now_name = approvaler_now_name;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getCancel_date() {
		return cancel_date;
	}
	public void setCancel_date(String cancel_date) {
		this.cancel_date = cancel_date;
	}
	public double getUse_count() {
		return use_count;
	}
	public void setUse_count(double use_count) {
		this.use_count = use_count;
	}
	public double getLeave_interval() {
		return leave_interval;
	}
	public void setLeave_interval(double leave_interval) {
		this.leave_interval = leave_interval;
	}	
}
