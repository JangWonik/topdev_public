package kr.co.toplac.topsuim;

public class SuimRptSiteCompositeVO {
	
	private String suimRptNo;
	private String accidentNo;
	private String policyNo;
	private String insuranceNm;
	private String policyholderSsn;
	private String policyholderTel;
	private String beneficiarySsn;
	private String beneficiaryTel;
	private String damagedTel;
	private String accidentFacts;
	private String investigatePostcode;
	private String investigateAddr1;
	private String investigateAddr2;
	private String amtEstimatedDamage;
	private String commissionEstimated;
	private String ptnr_mbr_office_tel;
	
	private String suimAcceptNo;
	private String suimCloseNo;
	private String reportType;
	private String reportType2;
	private String teamId;
	private String userNo;
	private String ptnrId;
	private String ptnrDeptId;
	private String ptnrMbrNo;
	private String policyholderNm;
	private String beneficiaryNm;
	private String damagedNm;
	private String accidentDate;
	private String regDate;
	private String transDate;		//일반건 전환일 추가 (20210402) by top3009
	
	private String userName;
	private String teamName;
	private String ptnrNick;
	private String ptnrName;
	private String ptnrDeptNm;
	private String ptnrMbrNm;
	private String suimRptType1Nm;
	private String suimRptType2Nm;
	
	private String suimRptType1;
	private String suimRptType2;
	
	private String moralFlag;
	private String minwonFlag;
	
	private String ptnrMbrHp;
	private String rptUserHp;
	private String insuTerm;
	private String amtCompensationLimit;
	
	private String compensationLimitFlag;
	private String compensationLimitEtcAmt;
	
	private String selfPayFlag;
	private String selfPayEtcAmt;
	private String insuMortgage;
	private String policyholderContact;
	private String policyholderAddr;
	private String referenceFacts;
	private String damagedFacts;
	
	private String ptnrMbrJobMemo;
	private String siteChamjo;
	private String amtSelfPay;
	private String selfPayEtcAmtEtc;
	
	private String siteReportId;
	private String interimFlag;
	private String orderNo;
	private String siteDate;
	private String exemptionFlag;
	private String dmgCtgr;
	private String dmgCtgrEtcNm;
	private String memoProblem;
	private String memoRemedy;
	private String memoAttach;
	private String damagedNegligence;
	private String ptnrMbrPositionNm4edit;
	private String siteZone;
	private String compensationLimitUnit;
	private String amtSelfPayUnit;
	private String selfPayLimitUnit;
	
	private String rptSiteNo;
	private String subDate;
	
	private String officeFax;
	
	private String siteFlag;
	
	public String getSiteFlag() {
		return siteFlag;
	}
	public void setSiteFlag(String siteFlag) {
		this.siteFlag = siteFlag;
	}
	public String getTransDate() {
		return transDate;
	}
	public void setTransDate(String transDate) {
		this.transDate = transDate;
	}
	public String getSelfPayLimitUnit() {
		return selfPayLimitUnit;
	}
	public void setSelfPayLimitUnit(String selfPayLimitUnit) {
		this.selfPayLimitUnit = selfPayLimitUnit;
	}
	public String getAmtSelfPayUnit() {
		return amtSelfPayUnit;
	}
	public void setAmtSelfPayUnit(String amtSelfPayUnit) {
		this.amtSelfPayUnit = amtSelfPayUnit;
	}
	public String getCompensationLimitUnit() {
		return compensationLimitUnit;
	}
	public void setCompensationLimitUnit(String compensationLimitUnit) {
		this.compensationLimitUnit = compensationLimitUnit;
	}
	public String getPtnr_mbr_office_tel() {
		return ptnr_mbr_office_tel;
	}
	public void setPtnr_mbr_office_tel(String ptnr_mbr_office_tel) {
		this.ptnr_mbr_office_tel = ptnr_mbr_office_tel;
	}
	public String getSuimRptNo() {
		return suimRptNo;
	}
	public void setSuimRptNo(String suimRptNo) {
		this.suimRptNo = suimRptNo;
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
	public String getInsuranceNm() {
		return insuranceNm;
	}
	public void setInsuranceNm(String insuranceNm) {
		this.insuranceNm = insuranceNm;
	}
	
	public String getPolicyholderTel() {
		return policyholderTel;
	}
	public void setPolicyholderTel(String policyholderTel) {
		this.policyholderTel = policyholderTel;
	}
	public String getBeneficiarySsn() {
		return beneficiarySsn;
	}
	public void setBeneficiarySsn(String beneficiarySsn) {
		this.beneficiarySsn = beneficiarySsn;
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
	public String getAccidentFacts() {
		return accidentFacts;
	}
	public void setAccidentFacts(String accidentFacts) {
		this.accidentFacts = accidentFacts;
	}
	public String getInvestigatePostcode() {
		return investigatePostcode;
	}
	public void setInvestigatePostcode(String investigatePostcode) {
		this.investigatePostcode = investigatePostcode;
	}
	public String getInvestigateAddr1() {
		return investigateAddr1;
	}
	public void setInvestigateAddr1(String investigateAddr1) {
		this.investigateAddr1 = investigateAddr1;
	}
	public String getInvestigateAddr2() {
		return investigateAddr2;
	}
	public void setInvestigateAddr2(String investigateAddr2) {
		this.investigateAddr2 = investigateAddr2;
	}
	public String getAmtEstimatedDamage() {
		return amtEstimatedDamage;
	}
	public void setAmtEstimatedDamage(String amtEstimatedDamage) {
		this.amtEstimatedDamage = amtEstimatedDamage;
	}
	public String getCommissionEstimated() {
		return commissionEstimated;
	}
	public void setCommissionEstimated(String commissionEstimated) {
		this.commissionEstimated = commissionEstimated;
	}
	public String getSuimAcceptNo() {
		return suimAcceptNo;
	}
	public void setSuimAcceptNo(String suimAcceptNo) {
		this.suimAcceptNo = suimAcceptNo;
	}
	public String getSuimCloseNo() {
		return suimCloseNo;
	}
	public void setSuimCloseNo(String suimCloseNo) {
		this.suimCloseNo = suimCloseNo;
	}
	public String getReportType() {
		return reportType;
	}
	public void setReportType(String reportType) {
		this.reportType = reportType;
	}
	public String getReportType2() {
		return reportType2;
	}
	public void setReportType2(String reportType2) {
		this.reportType2 = reportType2;
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
	public String getPtnrId() {
		return ptnrId;
	}
	public void setPtnrId(String ptnrId) {
		this.ptnrId = ptnrId;
	}
	public String getPtnrDeptId() {
		return ptnrDeptId;
	}
	public void setPtnrDeptId(String ptnrDeptId) {
		this.ptnrDeptId = ptnrDeptId;
	}
	public String getPtnrMbrNo() {
		return ptnrMbrNo;
	}
	public void setPtnrMbrNo(String ptnrMbrNo) {
		this.ptnrMbrNo = ptnrMbrNo;
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
	public String getAccidentDate() {
		return accidentDate;
	}
	public void setAccidentDate(String accidentDate) {
		this.accidentDate = accidentDate;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	public String getPtnrNick() {
		return ptnrNick;
	}
	public void setPtnrNick(String ptnrNick) {
		this.ptnrNick = ptnrNick;
	}
	public String getPtnrName() {
		return ptnrName;
	}
	public void setPtnrName(String ptnrName) {
		this.ptnrName = ptnrName;
	}
	public String getPtnrDeptNm() {
		return ptnrDeptNm;
	}
	public void setPtnrDeptNm(String ptnrDeptNm) {
		this.ptnrDeptNm = ptnrDeptNm;
	}
	public String getPtnrMbrNm() {
		return ptnrMbrNm;
	}
	public void setPtnrMbrNm(String ptnrMbrNm) {
		this.ptnrMbrNm = ptnrMbrNm;
	}
	public String getSuimRptType1Nm() {
		return suimRptType1Nm;
	}
	public void setSuimRptType1Nm(String suimRptType1Nm) {
		this.suimRptType1Nm = suimRptType1Nm;
	}
	public String getSuimRptType2Nm() {
		return suimRptType2Nm;
	}
	public void setSuimRptType2Nm(String suimRptType2Nm) {
		this.suimRptType2Nm = suimRptType2Nm;
	}
	public String getMoralFlag() {
		return moralFlag;
	}
	public void setMoralFlag(String moralFlag) {
		this.moralFlag = moralFlag;
	}
	public String getMinwonFlag() {
		return minwonFlag;
	}
	public void setMinwonFlag(String minwonFlag) {
		this.minwonFlag = minwonFlag;
	}
	public String getPtnrMbrHp() {
		return ptnrMbrHp;
	}
	public void setPtnrMbrHp(String ptnrMbrHp) {
		this.ptnrMbrHp = ptnrMbrHp;
	}
	public String getRptUserHp() {
		return rptUserHp;
	}
	public void setRptUserHp(String rptUserHp) {
		this.rptUserHp = rptUserHp;
	}
	public String getInsuTerm() {
		return insuTerm;
	}
	public void setInsuTerm(String insuTerm) {
		this.insuTerm = insuTerm;
	}
	public String getAmtCompensationLimit() {
		return amtCompensationLimit;
	}
	public void setAmtCompensationLimit(String amtCompensationLimit) {
		this.amtCompensationLimit = amtCompensationLimit;
	}
	public String getCompensationLimitFlag() {
		return compensationLimitFlag;
	}
	public void setCompensationLimitFlag(String compensationLimitFlag) {
		this.compensationLimitFlag = compensationLimitFlag;
	}
	public String getCompensationLimitEtcAmt() {
		return compensationLimitEtcAmt;
	}
	public void setCompensationLimitEtcAmt(String compensationLimitEtcAmt) {
		this.compensationLimitEtcAmt = compensationLimitEtcAmt;
	}
	public String getSelfPayFlag() {
		return selfPayFlag;
	}
	public void setSelfPayFlag(String selfPayFlag) {
		this.selfPayFlag = selfPayFlag;
	}
	public String getSelfPayEtcAmt() {
		return selfPayEtcAmt;
	}
	public void setSelfPayEtcAmt(String selfPayEtcAmt) {
		this.selfPayEtcAmt = selfPayEtcAmt;
	}
	public String getInsuMortgage() {
		return insuMortgage;
	}
	public void setInsuMortgage(String insuMortgage) {
		this.insuMortgage = insuMortgage;
	}
	public String getPolicyholderSsn() {
		return policyholderSsn;
	}
	public void setPolicyholderSsn(String policyholderSsn) {
		this.policyholderSsn = policyholderSsn;
	}
	public String getPolicyholderContact() {
		return policyholderContact;
	}
	public void setPolicyholderContact(String policyholderContact) {
		this.policyholderContact = policyholderContact;
	}
	public String getPolicyholderAddr() {
		return policyholderAddr;
	}
	public void setPolicyholderAddr(String policyholderAddr) {
		this.policyholderAddr = policyholderAddr;
	}
	public String getReferenceFacts() {
		return referenceFacts;
	}
	public void setReferenceFacts(String referenceFacts) {
		this.referenceFacts = referenceFacts;
	}
	public String getDamagedFacts() {
		return damagedFacts;
	}
	public void setDamagedFacts(String damagedFacts) {
		this.damagedFacts = damagedFacts;
	}
	public String getPtnrMbrJobMemo() {
		return ptnrMbrJobMemo;
	}
	public void setPtnrMbrJobMemo(String ptnrMbrJobMemo) {
		this.ptnrMbrJobMemo = ptnrMbrJobMemo;
	}
	public String getSiteChamjo() {
		return siteChamjo;
	}
	public void setSiteChamjo(String siteChamjo) {
		this.siteChamjo = siteChamjo;
	}
	public String getAmtSelfPay() {
		return amtSelfPay;
	}
	public void setAmtSelfPay(String amtSelfPay) {
		this.amtSelfPay = amtSelfPay;
	}
	public String getSelfPayEtcAmtEtc() {
		return selfPayEtcAmtEtc;
	}
	public void setSelfPayEtcAmtEtc(String selfPayEtcAmtEtc) {
		this.selfPayEtcAmtEtc = selfPayEtcAmtEtc;
	}
	public String getSiteReportId() {
		return siteReportId;
	}
	public void setSiteReportId(String siteReportId) {
		this.siteReportId = siteReportId;
	}
	public String getInterimFlag() {
		return interimFlag;
	}
	public void setInterimFlag(String interimFlag) {
		this.interimFlag = interimFlag;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getSiteDate() {
		return siteDate;
	}
	public void setSiteDate(String siteDate) {
		this.siteDate = siteDate;
	}
	public String getExemptionFlag() {
		return exemptionFlag;
	}
	public void setExemptionFlag(String exemptionFlag) {
		this.exemptionFlag = exemptionFlag;
	}
	public String getDmgCtgr() {
		return dmgCtgr;
	}
	public void setDmgCtgr(String dmgCtgr) {
		this.dmgCtgr = dmgCtgr;
	}
	public String getDmgCtgrEtcNm() {
		return dmgCtgrEtcNm;
	}
	public void setDmgCtgrEtcNm(String dmgCtgrEtcNm) {
		this.dmgCtgrEtcNm = dmgCtgrEtcNm;
	}
	public String getMemoProblem() {
		return memoProblem;
	}
	public void setMemoProblem(String memoProblem) {
		this.memoProblem = memoProblem;
	}
	public String getMemoRemedy() {
		return memoRemedy;
	}
	public void setMemoRemedy(String memoRemedy) {
		this.memoRemedy = memoRemedy;
	}
	public String getMemoAttach() {
		return memoAttach;
	}
	public void setMemoAttach(String memoAttach) {
		this.memoAttach = memoAttach;
	}
	public String getDamagedNegligence() {
		return damagedNegligence;
	}
	public void setDamagedNegligence(String damagedNegligence) {
		this.damagedNegligence = damagedNegligence;
	}
	public String getPtnrMbrPositionNm4edit() {
		return ptnrMbrPositionNm4edit;
	}
	public void setPtnrMbrPositionNm4edit(String ptnrMbrPositionNm4edit) {
		this.ptnrMbrPositionNm4edit = ptnrMbrPositionNm4edit;
	}
	public String getSiteZone() {
		return siteZone;
	}
	public void setSiteZone(String siteZone) {
		this.siteZone = siteZone;
	}
	public String getRptSiteNo() {
		return rptSiteNo;
	}
	public void setRptSiteNo(String rptSiteNo) {
		this.rptSiteNo = rptSiteNo;
	}
	public String getSubDate() {
		return subDate;
	}
	public void setSubDate(String subDate) {
		this.subDate = subDate;
	}
	public String getOfficeFax() {
		return officeFax;
	}
	public void setOfficeFax(String officeFax) {
		this.officeFax = officeFax;
	}
	public String getSuimRptType1() {
		return suimRptType1;
	}
	public void setSuimRptType1(String suimRptType1) {
		this.suimRptType1 = suimRptType1;
	}
	public String getSuimRptType2() {
		return suimRptType2;
	}
	public void setSuimRptType2(String suimRptType2) {
		this.suimRptType2 = suimRptType2;
	}
	
	
}

