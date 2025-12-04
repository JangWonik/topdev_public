package kr.co.toplac.toprptalarm;

	
public class SuimSpeedVO {
	/* 공통 */
	private String flag;
	
	/* HEAD & BODY */ 
	private String suimRptNo;
	private String suimAcceptNo;
	private String suimRptType1;
	
	private String accidentNo;
	private String accidentNo1;
	private String accidentNo2;
	
	private String policyNo;
	
	private String speedTypeCd;
	private String speedTypeVal;
	
	private String suimRptStateCd;
	private String suimRptStateVal;
	private String suimRptType1Close12Cd;
	private String suimRptType1Close12Val;
	
	private String teamId;
	private String teamNm;
	private String userNo;
	private String userNm; 

	private String policyholderNm;
	private String policyholderTel;

	private String beneficiaryNm;
	private String beneficiaryTel; 
	private String damagedNm;
	private String damagedTel;
	
	private String speedMngCode;
	private String speedMngCodeVal;

	private String speedComment;
	private String speedOneStop;
	
	private String regDate;
	
	private String delDate;
	private String suimCancelDateFmt;
	private String closeDateFmt;
	
	private String recentAlarmDateFmt;
	
	private String alarmData;
	
	
	/* sysadm_codedic */
	private String tbl_nm;
	private String col_nm;
	private String col_cd;
	private String col_val;
	
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getSuimRptNo() {
		return suimRptNo;
	}
	public void setSuimRptNo(String suimRptNo) {
		this.suimRptNo = suimRptNo;
	}
	public String getSuimAcceptNo() {
		return suimAcceptNo;
	}
	public void setSuimAcceptNo(String suimAcceptNo) {
		this.suimAcceptNo = suimAcceptNo;
	}
	public String getSuimRptType1() {
		return suimRptType1;
	}
	public void setSuimRptType1(String suimRptType1) {
		this.suimRptType1 = suimRptType1;
	}
	public String getTeamId() {
		return teamId;
	}
	public void setTeamId(String teamId) {
		this.teamId = teamId;
	}
	public String getUserNo() {
		return userNo;
	}
	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}
	public String getDamagedNm() {
		return damagedNm;
	}
	public void setDamagedNm(String damagedNm) {
		this.damagedNm = damagedNm;
	}
	public String getSpeedMngCode() {
		return speedMngCode;
	}
	public void setSpeedMngCode(String speedMngCode) {
		this.speedMngCode = speedMngCode;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getSuimRptStateCd() {
		return suimRptStateCd;
	}
	public void setSuimRptStateCd(String suimRptStateCd) {
		this.suimRptStateCd = suimRptStateCd;
	}
	public String getSuimRptStateVal() {
		return suimRptStateVal;
	}
	public void setSuimRptStateVal(String suimRptStateVal) {
		this.suimRptStateVal = suimRptStateVal;
	}
	public String getSuimRptType1Close12Cd() {
		return suimRptType1Close12Cd;
	}
	public void setSuimRptType1Close12Cd(String suimRptType1Close12Cd) {
		this.suimRptType1Close12Cd = suimRptType1Close12Cd;
	}
	public String getSuimRptType1Close12Val() {
		return suimRptType1Close12Val;
	}
	public void setSuimRptType1Close12Val(String suimRptType1Close12Val) {
		this.suimRptType1Close12Val = suimRptType1Close12Val;
	}
	public String getSpeedMngCodeVal() {
		return speedMngCodeVal;
	}
	public void setSpeedMngCodeVal(String speedMngCodeVal) {
		this.speedMngCodeVal = speedMngCodeVal;
	}
	public String getSpeedTypeCd() {
		return speedTypeCd;
	}
	public void setSpeedTypeCd(String speedTypeCd) {
		this.speedTypeCd = speedTypeCd;
	}
	public String getSpeedTypeVal() {
		return speedTypeVal;
	}
	public void setSpeedTypeVal(String speedTypeVal) {
		this.speedTypeVal = speedTypeVal;
	}
	public String getBeneficiaryNm() {
		return beneficiaryNm;
	}
	public void setBeneficiaryNm(String beneficiaryNm) {
		this.beneficiaryNm = beneficiaryNm;
	}
	
	public String getTbl_nm() {
		return tbl_nm;
	}
	public void setTbl_nm(String tbl_nm) {
		this.tbl_nm = tbl_nm;
	}
	public String getCol_nm() {
		return col_nm;
	}
	public void setCol_nm(String col_nm) {
		this.col_nm = col_nm;
	}
	public String getCol_cd() {
		return col_cd;
	}
	public void setCol_cd(String col_cd) {
		this.col_cd = col_cd;
	}
	public String getCol_val() {
		return col_val;
	}
	public void setCol_val(String col_val) {
		this.col_val = col_val;
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
	public String getPolicyholderNm() {
		return policyholderNm;
	}
	public void setPolicyholderNm(String policyholderNm) {
		this.policyholderNm = policyholderNm;
	}
	public String getPolicyholderTel() {
		return policyholderTel;
	}
	public void setPolicyholderTel(String policyholderTel) {
		this.policyholderTel = policyholderTel;
	}
	public String getBeneficiaryTel() {
		return beneficiaryTel;
	}
	public void setBeneficiaryTel(String beneficiaryTel) {
		this.beneficiaryTel = beneficiaryTel;
	}
	public String getDamagedTel() {
		return damagedTel;
	}
	public void setDamagedTel(String damagedTel) {
		this.damagedTel = damagedTel;
	}
	public String getSpeedComment() {
		return speedComment;
	}
	public void setSpeedComment(String speedComment) {
		this.speedComment = speedComment;
	}
	public String getAccidentNo() {
		return accidentNo;
	}
	public void setAccidentNo(String accidentNo) {
		this.accidentNo = accidentNo;
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
	public String getPolicyNo() {
		return policyNo;
	}
	public void setPolicyNo(String policyNo) {
		this.policyNo = policyNo;
	}
	public String getDelDate() {
		return delDate;
	}
	public void setDelDate(String delDate) {
		this.delDate = delDate;
	}
	public String getSuimCancelDateFmt() {
		return suimCancelDateFmt;
	}
	public void setSuimCancelDateFmt(String suimCancelDateFmt) {
		this.suimCancelDateFmt = suimCancelDateFmt;
	}
	public String getCloseDateFmt() {
		return closeDateFmt;
	}
	public void setCloseDateFmt(String closeDateFmt) {
		this.closeDateFmt = closeDateFmt;
	}
	public String getSpeedOneStop() {
		return speedOneStop;
	}
	public void setSpeedOneStop(String speedOneStop) {
		this.speedOneStop = speedOneStop;
	}
	public String getRecentAlarmDateFmt() {
		return recentAlarmDateFmt;
	}
	public void setRecentAlarmDateFmt(String recentAlarmDateFmt) {
		this.recentAlarmDateFmt = recentAlarmDateFmt;
	}
	public String getAlarmData() {
		return alarmData;
	}
	public void setAlarmData(String alarmData) {
		this.alarmData = alarmData;
	}

}
