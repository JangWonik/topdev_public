package kr.co.toplac.toprptmbrchg;

public class RptMbrchgVO {
	
	/*********************************/
	/******** 보고서 이내첩 대장 VO ********/
	/*********************************/
	private String serialNo;		//일련번호
	private String suimRptNo;		//보고서번호
	private String regUserNo;		//등록자
	private String regUserNm;		//등록자 이름
	
	private String fromUserNo;		//기존 담당자
	private String fromUserNm;		//기존 담당자 이름
	private String fromTeamId;		//기존 담당자 부서
	private String fromTeamNm;		//기존 담당자 부서명
	
	private String toUserNo;		//변경 담당자
	private String toUserNm;		//변경 담당자 이름
	private String toTeamId;		//변경 담당자 부서
	private String toTeamNm;		//변경 담당자 부서명
	
	
	
	private String mbrchgState;		//변경 상태 코드값
	private String mbrchgStateVal;	//변경 상태 
	
	private String mbrchgReason;	//변경 사유
	private String mbrchgReasonVal;	//변경 사유
	
	private String mbrchgDate;		//변경일
	
	private String regDate;			//등록일
	
	/* 공통 */
	private String flag;
	
	/* HEAD & BODY */ 
	private String suimAcceptNo;
	private String accidentNo;
	private String accidentNo1;
	private String accidentNo2;
	private String policyNo;
	private String teamId;
	private String teamNm;
	private String userNo;
	private String userNm; 
	private String policyholderNm;
	private String beneficiaryNm;
	private String damagedNm;
	
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
	public String getRegUserNo() {
		return regUserNo;
	}
	public void setRegUserNo(String regUserNo) {
		this.regUserNo = regUserNo;
	}
	public String getFromUserNo() {
		return fromUserNo;
	}
	public void setFromUserNo(String fromUserNo) {
		this.fromUserNo = fromUserNo;
	}
	public String getToUserNo() {
		return toUserNo;
	}
	public void setToUserNo(String toUserNo) {
		this.toUserNo = toUserNo;
	}
	public String getMbrchgState() {
		return mbrchgState;
	}
	public void setMbrchgState(String mbrchgState) {
		this.mbrchgState = mbrchgState;
	}
	public String getMbrchgReason() {
		return mbrchgReason;
	}
	public void setMbrchgReason(String mbrchgReason) {
		this.mbrchgReason = mbrchgReason;
	}
	public String getMbrchgDate() {
		return mbrchgDate;
	}
	public void setMbrchgDate(String mbrchgDate) {
		this.mbrchgDate = mbrchgDate;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getSuimAcceptNo() {
		return suimAcceptNo;
	}
	public void setSuimAcceptNo(String suimAcceptNo) {
		this.suimAcceptNo = suimAcceptNo;
	}
	public String getAccidentNo() {
		return accidentNo;
	}
	public void setAccidentNo(String accidentNo) {
		this.accidentNo = accidentNo;
	}
	public String getPolicyNo() {
		return policyNo;
	}
	public void setPolicyNo(String policyNo) {
		this.policyNo = policyNo;
	}
	public String getTeamId() {
		return teamId;
	}
	public void setTeamId(String teamId) {
		this.teamId = teamId;
	}
	public String getTeamNm() {
		return teamNm;
	}
	public void setTeamNm(String teamNm) {
		this.teamNm = teamNm;
	}
	public String getUserNo() {
		return userNo;
	}
	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getPolicyholderNm() {
		return policyholderNm;
	}
	public void setPolicyholderNm(String policyholderNm) {
		this.policyholderNm = policyholderNm;
	}
	public String getBeneficiaryNm() {
		return beneficiaryNm;
	}
	public void setBeneficiaryNm(String beneficiaryNm) {
		this.beneficiaryNm = beneficiaryNm;
	}
	public String getDamagedNm() {
		return damagedNm;
	}
	public void setDamagedNm(String damagedNm) {
		this.damagedNm = damagedNm;
	}
	public String getAccidentNo1() {
		return accidentNo1;
	}
	public void setAccidentNo1(String accidentNo1) {
		this.accidentNo1 = accidentNo1;
	}
	public String getAccidentNo2() {
		return accidentNo2;
	}
	public void setAccidentNo2(String accidentNo2) {
		this.accidentNo2 = accidentNo2;
	}
	public String getRegUserNm() {
		return regUserNm;
	}
	public void setRegUserNm(String regUserNm) {
		this.regUserNm = regUserNm;
	}
	public String getFromUserNm() {
		return fromUserNm;
	}
	public void setFromUserNm(String fromUserNm) {
		this.fromUserNm = fromUserNm;
	}
	public String getToUserNm() {
		return toUserNm;
	}
	public void setToUserNm(String toUserNm) {
		this.toUserNm = toUserNm;
	}
	public String getMbrchgStateVal() {
		return mbrchgStateVal;
	}
	public void setMbrchgStateVal(String mbrchgStateVal) {
		this.mbrchgStateVal = mbrchgStateVal;
	}
	public String getMbrchgReasonVal() {
		return mbrchgReasonVal;
	}
	public void setMbrchgReasonVal(String mbrchgReasonVal) {
		this.mbrchgReasonVal = mbrchgReasonVal;
	}
	public String getFromTeamId() {
		return fromTeamId;
	}
	public void setFromTeamId(String fromTeamId) {
		this.fromTeamId = fromTeamId;
	}
	public String getFromTeamNm() {
		return fromTeamNm;
	}
	public void setFromTeamNm(String fromTeamNm) {
		this.fromTeamNm = fromTeamNm;
	}
	public String getToTeamId() {
		return toTeamId;
	}
	public void setToTeamId(String toTeamId) {
		this.toTeamId = toTeamId;
	}
	public String getToTeamNm() {
		return toTeamNm;
	}
	public void setToTeamNm(String toTeamNm) {
		this.toTeamNm = toTeamNm;
	}
	
	
	
}
