package kr.co.toplac.toprptalarm;

public class RptAlarmVO {
	
	/****************************/
	/******** 보고서 알림 VO ********/
	/****************************/
	
	private String serialNo; 		/* 일련번호 */ 
	private String suimRptNo;		/* 수임번호 */
	private String alarmState;		/* 알림상태 */
	private String alarmDate;		/* 알림날짜(unixtime) */
	private String alarmDateFormat;	/* 알림날짜(날짜포멧적용) */
	private String alarmComment;	/* 알림내용 */
	private String regUser;			/* 등록자 */
	private String regUserNm;		/* 등록자 이름 */
	private String regDate;			/* 등록일 */
	private String endDate;			/* 완료일 */
	
	
	public String getSerialNo() {
		return serialNo;
	}
	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}
	public String getSuimRptNo() {
		return suimRptNo;
	}
	public void setSuimRptNo(String suimRptNo) {
		this.suimRptNo = suimRptNo;
	}
	public String getAlarmState() {
		return alarmState;
	}
	public void setAlarmState(String alarmState) {
		this.alarmState = alarmState;
	}
	public String getAlarmDate() {
		return alarmDate;
	}
	public void setAlarmDate(String alarmDate) {
		this.alarmDate = alarmDate;
	}
	public String getAlarmComment() {
		return alarmComment;
	}
	public void setAlarmComment(String alarmComment) {
		this.alarmComment = alarmComment;
	}
	public String getRegUser() {
		return regUser;
	}
	public void setRegUser(String regUser) {
		this.regUser = regUser;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getAlarmDateFormat() {
		return alarmDateFormat;
	}
	public void setAlarmDateFormat(String alarmDateFormat) {
		this.alarmDateFormat = alarmDateFormat;
	}
	public String getRegUserNm() {
		return regUserNm;
	}
	public void setRegUserNm(String regUserNm) {
		this.regUserNm = regUserNm;
	}
}
