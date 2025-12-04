package kr.co.toplac.topvaction;

/**
 * @author 임대성
 *
 */
public class VacationVo {
	
	//=========================================
	// 휴가 (재개발)
	//=========================================
	private int vacationNo;
	private int teamType;
	private int teamId;
	private int userNo;
	private int vacationKind;
	private String vacationKindValue;
	private String vacationComment;
	private String returnComment;
	
	private int vacationState;
	private String vacationStateValue;
	
	private String vacationStartDate;
	private String vacationEndDate;
	
	private int startMonthDay;
	private int endMonthDay;
	
	private int subAprvUserNo;
	private String subAprvUserNm;
	private String subAprvDate;
	
	private int finAprvUserNo;
	private String finAprvUserNm;
	private String finAprvDate;
	
	private int serialNo;
	private int year;
	private int vacationDayCnt;
	private double vacationUseCnt;
	
	//private int vacationReqCnt; 	//휴가 신청 중인 갯수
	//private int vacationAppvCnt;	//휴가 승인 갯수
	
	private float vacationReqCnt; 	//휴가 신청 중인 갯수
	private float vacationAppvCnt;	//휴가 승인 갯수
	
	private String vacationOrgFile;
	private String vacationEncFile;

	private String centerNm;
	private String teamNm;
	private String userNm;
	private String workLevelNm;
	private String joinDate;
	private String regDate;
	
	private int next_use;			//선연차 사용유무
	
	public int getNext_use() {
		return next_use;
	}
	public void setNext_use(int next_use) {
		this.next_use = next_use;
	}
	public float getVacationReqCnt() {
		return vacationReqCnt;
	}
	public void setVacationReqCnt(float vacationReqCnt) {
		this.vacationReqCnt = vacationReqCnt;
	}
	public float getVacationAppvCnt() {
		return vacationAppvCnt;
	}
	public void setVacationAppvCnt(float vacationAppvCnt) {
		this.vacationAppvCnt = vacationAppvCnt;
	}
	public int getVacationNo() {
		return vacationNo;
	}
	public void setVacationNo(int vacationNo) {
		this.vacationNo = vacationNo;
	}
	public int getTeamType() {
		return teamType;
	}
	public void setTeamType(int teamType) {
		this.teamType = teamType;
	}
	public int getTeamId() {
		return teamId;
	}
	public void setTeamId(int teamId) {
		this.teamId = teamId;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public int getVacationKind() {
		return vacationKind;
	}
	public void setVacationKind(int vacationKind) {
		this.vacationKind = vacationKind;
	}
	public String getVacationKindValue() {
		return vacationKindValue;
	}
	public void setVacationKindValue(String vacationKindValue) {
		this.vacationKindValue = vacationKindValue;
	}
	public String getVacationComment() {
		return vacationComment;
	}
	public void setVacationComment(String vacationComment) {
		this.vacationComment = vacationComment;
	}
	public int getVacationState() {
		return vacationState;
	}
	public void setVacationState(int vacationState) {
		this.vacationState = vacationState;
	}
	public String getVacationStateValue() {
		return vacationStateValue;
	}
	public void setVacationStateValue(String vacationStateValue) {
		this.vacationStateValue = vacationStateValue;
	}
	public String getVacationStartDate() {
		return vacationStartDate;
	}
	public void setVacationStartDate(String vacationStartDate) {
		this.vacationStartDate = vacationStartDate;
	}
	public String getVacationEndDate() {
		return vacationEndDate;
	}
	public void setVacationEndDate(String vacationEndDate) {
		this.vacationEndDate = vacationEndDate;
	}
	public int getSubAprvUserNo() {
		return subAprvUserNo;
	}
	public void setSubAprvUserNo(int subAprvUserNo) {
		this.subAprvUserNo = subAprvUserNo;
	}
	public String getSubAprvUserNm() {
		return subAprvUserNm;
	}
	public void setSubAprvUserNm(String subAprvUserNm) {
		this.subAprvUserNm = subAprvUserNm;
	}
	public String getSubAprvDate() {
		return subAprvDate;
	}
	public void setSubAprvDate(String subAprvDate) {
		this.subAprvDate = subAprvDate;
	}
	public int getFinAprvUserNo() {
		return finAprvUserNo;
	}
	public void setFinAprvUserNo(int finAprvUserNo) {
		this.finAprvUserNo = finAprvUserNo;
	}
	public String getFinAprvUserNm() {
		return finAprvUserNm;
	}
	public void setFinAprvUserNm(String finAprvUserNm) {
		this.finAprvUserNm = finAprvUserNm;
	}
	public String getFinAprvDate() {
		return finAprvDate;
	}
	public void setFinAprvDate(String finAprvDate) {
		this.finAprvDate = finAprvDate;
	}
	public int getSerialNo() {
		return serialNo;
	}
	public void setSerialNo(int serialNo) {
		this.serialNo = serialNo;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public int getVacationDayCnt() {
		return vacationDayCnt;
	}
	public void setVacationDayCnt(int vacationDayCnt) {
		this.vacationDayCnt = vacationDayCnt;
	}
	
	public double getVacationUseCnt() {
		return vacationUseCnt;
	}
	public void setVacationUseCnt(double vacationUseCnt) {
		this.vacationUseCnt = vacationUseCnt;
	}
	public int getStartMonthDay() {
		return startMonthDay;
	}
	public void setStartMonthDay(int startMonthDay) {
		this.startMonthDay = startMonthDay;
	}
	public int getEndMonthDay() {
		return endMonthDay;
	}
	public void setEndMonthDay(int endMonthDay) {
		this.endMonthDay = endMonthDay;
	}
	public String getTeamNm() {
		return teamNm;
	}
	public void setTeamNm(String teamNm) {
		this.teamNm = teamNm;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getWorkLevelNm() {
		return workLevelNm;
	}
	public void setWorkLevelNm(String workLevelNm) {
		this.workLevelNm = workLevelNm;
	}
	public String getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getReturnComment() {
		return returnComment;
	}
	public void setReturnComment(String returnComment) {
		this.returnComment = returnComment;
	}
	public void setVacationReqCnt(int vacationReqCnt) {
		this.vacationReqCnt = vacationReqCnt;
	}
	public void setVacationAppvCnt(int vacationAppvCnt) {
		this.vacationAppvCnt = vacationAppvCnt;
	}
	public String getCenterNm() {
		return centerNm;
	}
	public void setCenterNm(String centerNm) {
		this.centerNm = centerNm;
	}
	public String getVacationOrgFile() {
		return vacationOrgFile;
	}
	public void setVacationOrgFile(String vacationOrgFile) {
		this.vacationOrgFile = vacationOrgFile;
	}
	public String getVacationEncFile() {
		return vacationEncFile;
	}
	public void setVacationEncFile(String vacationEncFile) {
		this.vacationEncFile = vacationEncFile;
	}
	
	
	
}
