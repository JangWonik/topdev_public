package kr.co.toplac.topsuim;

public class SuimRptUdtViewVO {
	private String suimRptNo;
	private String suimRptType1 ;
	private String suimRptType2 ;
	private String suimRptType3 ;
	private String suimAcceptNo ;
	private String teamId ;
	private String userNo ;
	private String ptnrId ;
	private String ptnrDeptId ;
	private String ptnrMbrNo ;
	private String policyholderNm ;
	private String beneficiaryNm ;
	private String damagedNm ;
	private String accidentDate ;
	private String regDate ;
	private String transDate;			//일반전환일 추가 (20210402) by top3009
	private String accidentNo ;
	private String policyNo ;
	private String insuranceNm ;
	private String policyholderTel ;
	private String beneficiaryTel ;
	private String damagedTel ;
	private String accidentFacts ;
	private String investigatePostcode ;
	private String investigateAddr1 ;
	private String investigateAddr2 ;
	private String amtEstimatedDamage ;
	private String commissionEstimated ;
	private String moralFlag;
	private String minwonFlag;
	
	private String beneficiarySsn;
	private String policyholderSsn;
	
	private String amtCompensationLimit;    /* 보상한도액 */
    private String compensationLimitUnit;    /* 보상한도액 단위 */
    private String amtSelfPay;              /* 자기부담금 */
    private String selfPayUnit;          /* 자기부담금 단위 */
	private String insuTerm;            /* 보험기간 */
	
	private String pendncyTrgetAt;
	
	private String speedType;
	private String befSpeedType;
	private String speedOneStop;//스피드 원스탑 체크
	private String workloadType; 
	private String workloadEa; 
	private String retirePendingFlag; 
	
	private String ptnrAssignGubun;		//4종 보험사 지정건
	private String ptnrDetailGubun;		//4종 보험사 상세구분
	
	private String insu_condition;	//181123, 보험조건 추가
	
	private String compensationLimitFlag;
	private String selfPayFlag;
	
	private String ptnrIdSub;
	private String periodFlag;
	    
	public String getPeriodFlag() {
		return periodFlag;
	}
	public void setPeriodFlag(String periodFlag) {
		this.periodFlag = periodFlag;
	}
	public String getPtnrIdSub() {
		return ptnrIdSub;
	}
	public void setPtnrIdSub(String ptnrIdSub) {
		this.ptnrIdSub = ptnrIdSub;
	}
	public String getTransDate() {
		return transDate;
	}
	public void setTransDate(String transDate) {
		this.transDate = transDate;
	}
	public String getPendncyTrgetAt() {
		return pendncyTrgetAt;
	}
	public void setPendncyTrgetAt(String pendncyTrgetAt) {
		this.pendncyTrgetAt = pendncyTrgetAt;
	}
	public String getCompensationLimitUnit() {
		return compensationLimitUnit;
	}
	public void setCompensationLimitUnit(String compensationLimitUnit) {
		this.compensationLimitUnit = compensationLimitUnit;
	}
	public String getSelfPayUnit() {
		return selfPayUnit;
	}
	public void setSelfPayUnit(String selfPayUnit) {
		this.selfPayUnit = selfPayUnit;
	}
	public String getAmtCompensationLimit() {
		return amtCompensationLimit;
	}
	public void setAmtCompensationLimit(String amtCompensationLimit) {
		this.amtCompensationLimit = amtCompensationLimit;
	}
	public String getAmtSelfPay() {
		return amtSelfPay;
	}
	public void setAmtSelfPay(String amtSelfPay) {
		this.amtSelfPay = amtSelfPay;
	}
	public String getSuimRptNo() {
		return suimRptNo;
	}
	public void setSuimRptNo(String suimRptNo) {
		this.suimRptNo = suimRptNo;
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
	public String getSuimRptType3() {
		return suimRptType3;
	}
	public void setSuimRptType3(String suimRptType3) {
		this.suimRptType3 = suimRptType3;
	}
	public String getSuimAcceptNo() {
		return suimAcceptNo;
	}
	public void setSuimAcceptNo(String suimAcceptNo) {
		this.suimAcceptNo = suimAcceptNo;
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
	public String getBeneficiarySsn() {
		return beneficiarySsn;
	}
	public void setBeneficiarySsn(String beneficiarySsn) {
		this.beneficiarySsn = beneficiarySsn;
	}
	public String getPolicyholderSsn() {
		return policyholderSsn;
	}
	public void setPolicyholderSsn(String policyholderSsn) {
		this.policyholderSsn = policyholderSsn;
	}

    public String getInsuTerm() {
        return insuTerm;
    }

    public void setInsuTerm(String insuTerm) {
        this.insuTerm = insuTerm;
    }
	public String getSpeedOneStop() {
		return speedOneStop;
	}
	public void setSpeedOneStop(String speedOneStop) {
		this.speedOneStop = speedOneStop;
	}
	public String getSpeedType() {
		return speedType;
	}
	public void setSpeedType(String speedType) {
		this.speedType = speedType;
	}
	public String getBefSpeedType() {
		return befSpeedType;
	}
	public void setBefSpeedType(String befSpeedType) {
		this.befSpeedType = befSpeedType;
	}
	public String getWorkloadType() {
		return workloadType;
	}
	public void setWorkloadType(String workloadType) {
		this.workloadType = workloadType;
	}
	public String getWorkloadEa() {
		return workloadEa;
	}
	public void setWorkloadEa(String workloadEa) {
		this.workloadEa = workloadEa;
	}
	public String getRetirePendingFlag() {
		return retirePendingFlag;
	}
	public void setRetirePendingFlag(String retirePendingFlag) {
		this.retirePendingFlag = retirePendingFlag;
	}
	public String getPtnrAssignGubun() {
		return ptnrAssignGubun;
	}
	public void setPtnrAssignGubun(String ptnrAssignGubun) {
		this.ptnrAssignGubun = ptnrAssignGubun;
	}
	public String getPtnrDetailGubun() {
		return ptnrDetailGubun;
	}
	public void setPtnrDetailGubun(String ptnrDetailGubun) {
		this.ptnrDetailGubun = ptnrDetailGubun;
	}
	public String getInsu_condition() {
		return insu_condition;
	}
	public void setInsu_condition(String insu_condition) {
		this.insu_condition = insu_condition;
	}
	public String getCompensationLimitFlag() {
		return compensationLimitFlag;
	}
	public void setCompensationLimitFlag(String compensationLimitFlag) {
		this.compensationLimitFlag = compensationLimitFlag;
	}
	public String getSelfPayFlag() {
		return selfPayFlag;
	}
	public void setSelfPayFlag(String selfPayFlag) {
		this.selfPayFlag = selfPayFlag;
	}
	
	
	
}
