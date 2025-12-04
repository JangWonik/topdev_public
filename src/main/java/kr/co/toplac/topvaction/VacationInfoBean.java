package kr.co.toplac.topvaction;

/**
 * 휴가신청 및 결제내역 Bean
 * 2019.05.10
 * @author top3009
 */

public class VacationInfoBean {
	
	private int serial_no = 0;						//고유키
	private int user_no = 0;						//신청자사번
	private String user_id = "";					//사용자아이디
	
	private String center_name = "";			//센터명
	private String team_name = "";			//팀명
	private String user_name = "";				//신청자이름
	
	private String work_level = "";				//신청자 직급
	private String join_date = "";				//신청자 입사일
	
	private int vacation_type = 0;				//100:연차, 200:반차, 300:경조사, 400:배우자출산, 500:출산전/후, 600:유/사산, 700:예비군(민방위)
	private String vacation_type_val = "";	//vacation_type 으로 가져온 코드 한글값
	private String vacation_content = "";		//휴가사유
	
	private int vacation_option = 0;			//201:오전반차, 202:오후반차, 211:반반차 09시~12시 ~ 217:반반차 16시~18시
	private String vacation_option_val = "";	//vacation_option 으로 가져온 코드 한글값
	
	private int approval_state = 0;				//팀장승인대기 : 10, 센터장 승인대기 : 20, 최종승인대기 : 30, 팀장반려 : 12, 센터장 반려 : 22, 최종반려 : 32, 최종승인 : 31
	private String approval_state_val = "";		//approval_state 으로 가져온 코드 한글값
	private String sdate = "";						//휴가시작일
	private String edate = "";						//휴가종료일
	
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
	
	private String regdate = "";					//휴가신청일자
	private String cancel_date = "";			//휴가취소일자
	
	private String base_year = "";				//기준년도
	
	private String vacation_org_file = "";		//파일원본이름
	private String vacation_enc_file = "";		//파일명(서버내 이름)
	
	private double vacation_interval = 0;		//휴가신청 일수
	private double annual_set = 0;				//연차발생 일수
	private double annual_use = 0;				//연차사용 일수
	
	private double col_1 = 0;						//1월 휴가사용일수
	private double col_2 = 0;						//2월 휴가사용일수
	private double col_3 = 0;						//3월 휴가사용일수
	private double col_4 = 0;						//4월 휴가사용일수
	private double col_5 = 0;						//5월 휴가사용일수
	private double col_6 = 0;						//6월  휴가사용일수
	private double col_7 = 0;						//7월 휴가사용일수
	private double col_8 = 0;						//8월 휴가사용일수
	private double col_9 = 0;						//9월 휴가사용일수
	private double col_10 = 0;						//10월 휴가사용일수
	private double col_11 = 0;						//11월 휴가사용일수
	private double col_12 = 0;						//12월 휴가사용일수
	
	private String now_join_date = "";				//입사일 기준 현재년도시작일 변환값
	private String after_join_date = "";				//입사일 기준 차기년도시작일 변환값
	
	//연차계산을 위한 변수 시작	
	private double in_365 = 0;			//1년 이내 입사자 여부 (0: 1년이내 입사자가 아님, 1~ : 1년이내입사자로 연차발생일수)
	private String in_month = "0";		//2017년 5월 31일 이후 입사자 여부 (월차생성)
	private double in_month_val = 0;		//월차생성플래그에 따른 월차생성값
	private double result_year = 0;		//최종월차할당 값
	private int n2019month_cal = 0;		//2019년 기본년차 차감수 (1년 미만자)
	private double out_365 = 0;		//1년 이상 입사자 기본 연차수
	private double n2019work_cal = 0;		//1년이상 입사자 근무일기준 생성연차
	private int n2019month_over_cal = 0;		//2019년 기본년차 차감수 (1년 이상자)
	
	private double org_year_cal = 0;				//마이너스를 포함한 연차환산 변수
	private double upper_year_cal = 0;			//마이너스인경우 0으로 처리한 연차환산 변수
	private double n2019_vacation_use = 0;		//2019년 현재 사용한 휴가수
	private double n2019_vacation_work_use = 0;		//2019년 입사일 이후 현재 사용한 휴가수
	
	//by 통합조회용 변수
	private double nYearset = 0;			//발생연차
	private double nWorkset = 0;			//근무일(월차)에 따른 발생월차
	private double nHoliday = 0;			//공휴일로 인한 차감연차
	private double nUsework_all_vacation = 0;		//사용한 휴가일수
	private double nUsework_after_vacation = 0;		//근무월 이후 사용한 휴가일수
	private int nWorkday_year = 0;			//1년기준 입사일로부터 근무일수
	
	private double n2019_vacation = 0;			//2019휴가사용일수
	
	private double n2018Yearset = 0;		//2018년 발생연차
	private double n2018Holiday = 0;			//2018년 대체사용연차
	private double n2018_vacation_work_use = 0;		//2018년 입사일 이후 현재 사용한 휴가수
	private double n2018Extraset = 0;			//2018년 잔여연차
	private double n2018Overset = 0;			//2018년 이월연차
	private double nTotalYearset = 0;			//이월분포함 발생연차	
	private double n2019Extraset = 0;			//2018년 잔여연차
	private double nVacationProgress = 0;			//현재 휴가 사용율
	private double nVacationPer100 = 0;			//사용량/할당량  * 100
	
	private double remain_vacation_use= 0;		//휴가 신청시점의 연차잔여일
	
	private String approve_date = "";				//목록에 표시될 결재일 (마지막 결재일)
	
	public String getApprove_date() {
		return approve_date;
	}
	public void setApprove_date(String approve_date) {
		this.approve_date = approve_date;
	}
	public double getRemain_vacation_use() {
		return remain_vacation_use;
	}
	public void setRemain_vacation_use(double remain_vacation_use) {
		this.remain_vacation_use = remain_vacation_use;
	}
	public int getVacation_option() {
		return vacation_option;
	}
	public void setVacation_option(int vacation_option) {
		this.vacation_option = vacation_option;
	}
	public String getVacation_option_val() {
		return vacation_option_val;
	}
	public void setVacation_option_val(String vacation_option_val) {
		this.vacation_option_val = vacation_option_val;
	}
	public String getApprovaler_now_name() {
		return approvaler_now_name;
	}
	public void setApprovaler_now_name(String approvaler_now_name) {
		this.approvaler_now_name = approvaler_now_name;
	}
	private int nNext_use = 0;				//선연차 사용유무 플래그	
	//연차계산을 위한 변수 끝
		
	public String getUser_id() {
		return user_id;
	}	
	public int getnNext_use() {
		return nNext_use;
	}
	public void setnNext_use(int nNext_use) {
		this.nNext_use = nNext_use;
	}
	public double getnVacationPer100() {
		return nVacationPer100;
	}
	public void setnVacationPer100(double nVacationPer100) {
		this.nVacationPer100 = nVacationPer100;
	}
	public double getnVacationProgress() {
		return nVacationProgress;
	}
	public void setnVacationProgress(double nVacationProgress) {
		this.nVacationProgress = nVacationProgress;
	}
	public String getNow_join_date() {
		return now_join_date;
	}
	public void setNow_join_date(String now_join_date) {
		this.now_join_date = now_join_date;
	}
	public String getAfter_join_date() {
		return after_join_date;
	}
	public void setAfter_join_date(String after_join_date) {
		this.after_join_date = after_join_date;
	}
	public double getN2019Extraset() {
		return n2019Extraset;
	}
	public void setN2019Extraset(double n2019Extraset) {
		this.n2019Extraset = n2019Extraset;
	}
	public double getnTotalYearset() {
		return nTotalYearset;
	}
	public void setnTotalYearset(double nTotalYearset) {
		this.nTotalYearset = nTotalYearset;
	}
	public double getN2018Overset() {
		return n2018Overset;
	}
	public void setN2018Overset(double n2018Overset) {
		this.n2018Overset = n2018Overset;
	}
	public double getN2018Extraset() {
		return n2018Extraset;
	}
	public void setN2018Extraset(double n2018Extraset) {
		this.n2018Extraset = n2018Extraset;
	}
	public double getN2018_vacation_work_use() {
		return n2018_vacation_work_use;
	}
	public void setN2018_vacation_work_use(double n2018_vacation_work_use) {
		this.n2018_vacation_work_use = n2018_vacation_work_use;
	}
	public double getN2018Holiday() {
		return n2018Holiday;
	}
	public void setN2018Holiday(double n2018Holiday) {
		this.n2018Holiday = n2018Holiday;
	}
	public double getN2018Yearset() {
		return n2018Yearset;
	}
	public void setN2018Yearset(double n2018Yearset) {
		this.n2018Yearset = n2018Yearset;
	}
	public double getN2019_vacation() {
		return n2019_vacation;
	}
	public void setN2019_vacation(double n2019_vacation) {
		this.n2019_vacation = n2019_vacation;
	}
	public int getnWorkday_year() {
		return nWorkday_year;
	}
	public void setnWorkday_year(int nWorkday_year) {
		this.nWorkday_year = nWorkday_year;
	}
	public double getnYearset() {
		return nYearset;
	}
	public void setnYearset(double nYearset) {
		this.nYearset = nYearset;
	}
	public double getnWorkset() {
		return nWorkset;
	}
	public void setnWorkset(double nWorkset) {
		this.nWorkset = nWorkset;
	}
	public double getnHoliday() {
		return nHoliday;
	}
	public void setnHoliday(double nHoliday) {
		this.nHoliday = nHoliday;
	}
	public double getnUsework_all_vacation() {
		return nUsework_all_vacation;
	}
	public void setnUsework_all_vacation(double nUsework_all_vacation) {
		this.nUsework_all_vacation = nUsework_all_vacation;
	}
	public double getnUsework_after_vacation() {
		return nUsework_after_vacation;
	}
	public void setnUsework_after_vacation(double nUsework_after_vacation) {
		this.nUsework_after_vacation = nUsework_after_vacation;
	}
	public double getN2019_vacation_work_use() {
		return n2019_vacation_work_use;
	}
	public void setN2019_vacation_work_use(double n2019_vacation_work_use) {
		this.n2019_vacation_work_use = n2019_vacation_work_use;
	}
	public double getN2019_vacation_use() {
		return n2019_vacation_use;
	}
	public void setN2019_vacation_use(double n2019_vacation_use) {
		this.n2019_vacation_use = n2019_vacation_use;
	}
	public double getOrg_year_cal() {
		return org_year_cal;
	}
	public void setOrg_year_cal(double org_year_cal) {
		this.org_year_cal = org_year_cal;
	}
	public double getUpper_year_cal() {
		return upper_year_cal;
	}
	public void setUpper_year_cal(double upper_year_cal) {
		this.upper_year_cal = upper_year_cal;
	}
	public int getN2019month_over_cal() {
		return n2019month_over_cal;
	}
	public void setN2019month_over_cal(int n2019month_over_cal) {
		this.n2019month_over_cal = n2019month_over_cal;
	}
	public double getN2019work_cal() {
		return n2019work_cal;
	}
	public void setN2019work_cal(double n2019work_cal) {
		this.n2019work_cal = n2019work_cal;
	}
	public double getOut_365() {
		return out_365;
	}
	public void setOut_365(double out_365) {
		this.out_365 = out_365;
	}
	public int getN2019month_cal() {
		return n2019month_cal;
	}
	public void setN2019month_cal(int n2019month_cal) {
		this.n2019month_cal = n2019month_cal;
	}
	public double getIn_365() {
		return in_365;
	}
	public void setIn_365(double in_365) {
		this.in_365 = in_365;
	}
	public String getIn_month() {
		return in_month;
	}
	public void setIn_month(String in_month) {
		this.in_month = in_month;
	}
	public double getIn_month_val() {
		return in_month_val;
	}
	public void setIn_month_val(double in_month_val) {
		this.in_month_val = in_month_val;
	}
	public double getResult_year() {
		return result_year;
	}
	public void setResult_year(double result_year) {
		this.result_year = result_year;
	}	
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public double getCol_1() {
		return col_1;
	}
	public void setCol_1(double col_1) {
		this.col_1 = col_1;
	}
	public double getCol_2() {
		return col_2;
	}
	public void setCol_2(double col_2) {
		this.col_2 = col_2;
	}
	public double getCol_3() {
		return col_3;
	}
	public void setCol_3(double col_3) {
		this.col_3 = col_3;
	}
	public double getCol_4() {
		return col_4;
	}
	public void setCol_4(double col_4) {
		this.col_4 = col_4;
	}
	public double getCol_5() {
		return col_5;
	}
	public void setCol_5(double col_5) {
		this.col_5 = col_5;
	}
	public double getCol_6() {
		return col_6;
	}
	public void setCol_6(double col_6) {
		this.col_6 = col_6;
	}
	public double getCol_7() {
		return col_7;
	}
	public void setCol_7(double col_7) {
		this.col_7 = col_7;
	}
	public double getCol_8() {
		return col_8;
	}
	public void setCol_8(double col_8) {
		this.col_8 = col_8;
	}
	public double getCol_9() {
		return col_9;
	}
	public void setCol_9(double col_9) {
		this.col_9 = col_9;
	}
	public double getCol_10() {
		return col_10;
	}
	public void setCol_10(double col_10) {
		this.col_10 = col_10;
	}
	public double getCol_11() {
		return col_11;
	}
	public void setCol_11(double col_11) {
		this.col_11 = col_11;
	}
	public double getCol_12() {
		return col_12;
	}
	public void setCol_12(double col_12) {
		this.col_12 = col_12;
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
	public double getVacation_interval() {
		return vacation_interval;
	}
	public void setVacation_interval(double vacation_interval) {
		this.vacation_interval = vacation_interval;
	}
	public String getVacation_type_val() {
		return vacation_type_val;
	}
	public void setVacation_type_val(String vacation_type_val) {
		this.vacation_type_val = vacation_type_val;
	}
	public String getApproval_state_val() {
		return approval_state_val;
	}
	public void setApproval_state_val(String approval_state_val) {
		this.approval_state_val = approval_state_val;
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
	public String getVacation_org_file() {
		return vacation_org_file;
	}
	public void setVacation_org_file(String vacation_org_file) {
		this.vacation_org_file = vacation_org_file;
	}
	public String getVacation_enc_file() {
		return vacation_enc_file;
	}
	public void setVacation_enc_file(String vacation_enc_file) {
		this.vacation_enc_file = vacation_enc_file;
	}
	public String getBase_year() {
		return base_year;
	}
	public void setBase_year(String base_year) {
		this.base_year = base_year;
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
	public int getVacation_type() {
		return vacation_type;
	}
	public void setVacation_type(int vacation_type) {
		this.vacation_type = vacation_type;
	}
	public String getVacation_content() {
		return vacation_content;
	}
	public void setVacation_content(String vacation_content) {
		this.vacation_content = vacation_content;
	}
	public int getApproval_state() {
		return approval_state;
	}
	public void setApproval_state(int approval_state) {
		this.approval_state = approval_state;
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
	
}
