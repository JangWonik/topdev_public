package kr.co.toplac.topsuim;

public class SuimRegInsViewVO {
	private String suimRptNo;
	private String suimRptType1 ;
	private String suimRptType2 ;
	private String suimRptType3 ;
	private String speedType ;
	private String suimAcceptNo ;
	private String teamId ;
	private String userNo ;
	
	private String ptnrMbrNo ;
	private String policyholderNm ;
	private String beneficiaryNm ;
	private String damagedNm ;
	private String accidentDate ;
	private String regDate ;
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
	private String damagedAmtEstimated ;
	private String commissionEstimated ;
	
	private String suimCloseNo ;
	
	private String gubun_rpt1; //suimRptType1         
	private String gubun_rpt2; //,suimRptType2         
	private String topTeamId;  //,teamId           
	private String topMbr;	   //,userNo           
	private String ptnrId;		//,ptnrId       
	private String ptnrDeptId;	//,ptnrDeptId    
	private String ptnrDeptMbr;	//,ptnrMbrNo     
	private String conName;		//,policyholderNm 
	private String insName;		//,beneficiaryNm      
	private String insItem;		//,damagedNm        
	
	private String sago_time;	//,accidentDate    
	private String suim_time;	//,regDate    
	private String accNo;		//,accidentNo  
	private String conNo;		//,policyNo   
	private String accType;		//,insuranceNm   
	
	private String conPhone1;	//,policyholderTel   
	private String conPhone2;	//,policyholderTel   
	private String conPhone3;	//,policyholderTel   
	
	private String insPhone1;	//,beneficiaryTel   
	private String insPhone2;	//,beneficiaryTel   
	private String insPhone3;	//,beneficiaryTel   
	private String insItemPhone1;	//,damagedTel 
	private String insItemPhone2;	//,damagedTel 
	private String insItemPhone3;	//,damagedTel 
	private String accContent;	//,accidentFacts 
	private String postcode1;	//,investigatePostcode 
	private String addr_1st;	//,investigateAddr1 
	private String addr_1st_1;	//,investigateAddr2 
	private String estLoss;		//,damagedAmtEstimated    
	private String estFee;		//,commissionEstimated 
	private String suimRptType1Close12;	//,suimRptType1Close12	
	private String reportEa;		//,,reportEa					
	private String amtInsuPayment;	//,,amtInsuPayment						
	private String amtBasic;		//,amtInsuPayment			
	private String speed_type;		//,speedType		
	private String pendncyTrgetAt;
	
	private String speed_onestop; //서면심사 원스탑 체크 - 170811, 최중찬대리 요청
	
	private String onestopTeamId; //서면심사 원스탑 현장조사 담당 부서
	private String onestopMbrNo; //서면심사 원스탑 현장조사 담당자
	
	private String workloadType; //기준업무량 상세구분 코드
	private String workloadEa; //기준업무량 상세구분 코드
	
	private String ptnrAssignGubun; //4종 보험사 지정건 구분
	private String ptnrDetailGubun; //4종 보험사 상세 구분
	
	private String registrant;			//수임등록자
	
	private String ptnrIdSub;			//보험사 상세구분코드
	private String periodFlag;			//계약기간 구분코드 (0:없음, 1:장기, 2:일반)	
	
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
	public String getRegistrant() {
		return registrant;
	}
	public void setRegistrant(String registrant) {
		this.registrant = registrant;
	}
	public String getPendncyTrgetAt() {
		return pendncyTrgetAt;
	}
	public void setPendncyTrgetAt(String pendncyTrgetAt) {
		this.pendncyTrgetAt = pendncyTrgetAt;
	}
	public String getGubun_rpt1() {
		return gubun_rpt1;
	}
	public void setGubun_rpt1(String gubun_rpt1) {
		this.gubun_rpt1 = gubun_rpt1;
	}
	public String getGubun_rpt2() {
		return gubun_rpt2;
	}
	public void setGubun_rpt2(String gubun_rpt2) {
		this.gubun_rpt2 = gubun_rpt2;
	}
	public String getTopTeamId() {
		return topTeamId;
	}
	public void setTopTeamId(String topTeamId) {
		this.topTeamId = topTeamId;
	}
	public String getTopMbr() {
		return topMbr;
	}
	public void setTopMbr(String topMbr) {
		this.topMbr = topMbr;
	}
	public String getPtnrDeptMbr() {
		return ptnrDeptMbr;
	}
	public void setPtnrDeptMbr(String ptnrDeptMbr) {
		this.ptnrDeptMbr = ptnrDeptMbr;
	}
	public String getConName() {
		return conName;
	}
	public void setConName(String conName) {
		this.conName = conName;
	}
	public String getInsName() {
		return insName;
	}
	public void setInsName(String insName) {
		this.insName = insName;
	}
	public String getInsItem() {
		return insItem;
	}
	public void setInsItem(String insItem) {
		this.insItem = insItem;
	}
	public String getSago_time() {
		return sago_time;
	}
	public void setSago_time(String sago_time) {
		this.sago_time = sago_time;
	}
	public String getSuim_time() {
		return suim_time;
	}
	public void setSuim_time(String suim_time) {
		this.suim_time = suim_time;
	}
	public String getAccNo() {
		return accNo;
	}
	public void setAccNo(String accNo) {
		this.accNo = accNo;
	}
	public String getConNo() {
		return conNo;
	}
	public void setConNo(String conNo) {
		this.conNo = conNo;
	}
	public String getAccType() {
		return accType;
	}
	public void setAccType(String accType) {
		this.accType = accType;
	}
	public String getConPhone1() {
		return conPhone1;
	}
	public void setConPhone1(String conPhone1) {
		this.conPhone1 = conPhone1;
	}
	public String getConPhone2() {
		return conPhone2;
	}
	public void setConPhone2(String conPhone2) {
		this.conPhone2 = conPhone2;
	}
	public String getConPhone3() {
		return conPhone3;
	}
	public void setConPhone3(String conPhone3) {
		this.conPhone3 = conPhone3;
	}
	public String getInsPhone1() {
		return insPhone1;
	}
	public void setInsPhone1(String insPhone1) {
		this.insPhone1 = insPhone1;
	}
	public String getInsPhone2() {
		return insPhone2;
	}
	public void setInsPhone2(String insPhone2) {
		this.insPhone2 = insPhone2;
	}
	public String getInsPhone3() {
		return insPhone3;
	}
	public void setInsPhone3(String insPhone3) {
		this.insPhone3 = insPhone3;
	}
	public String getInsItemPhone1() {
		return insItemPhone1;
	}
	public void setInsItemPhone1(String insItemPhone1) {
		this.insItemPhone1 = insItemPhone1;
	}
	public String getInsItemPhone2() {
		return insItemPhone2;
	}
	public void setInsItemPhone2(String insItemPhone2) {
		this.insItemPhone2 = insItemPhone2;
	}
	public String getInsItemPhone3() {
		return insItemPhone3;
	}
	public void setInsItemPhone3(String insItemPhone3) {
		this.insItemPhone3 = insItemPhone3;
	}
	public String getAccContent() {
		return accContent;
	}
	public void setAccContent(String accContent) {
		this.accContent = accContent;
	}
	public String getPostcode1() {
		return postcode1;
	}
	public void setPostcode1(String postcode1) {
		this.postcode1 = postcode1;
	}
	public String getAddr_1st() {
		return addr_1st;
	}
	public void setAddr_1st(String addr_1st) {
		this.addr_1st = addr_1st;
	}
	public String getAddr_1st_1() {
		return addr_1st_1;
	}
	public void setAddr_1st_1(String addr_1st_1) {
		this.addr_1st_1 = addr_1st_1;
	}
	public String getEstLoss() {
		return estLoss;
	}
	public void setEstLoss(String estLoss) {
		this.estLoss = estLoss;
	}
	public String getEstFee() {
		return estFee;
	}
	public void setEstFee(String estFee) {
		this.estFee = estFee;
	}
	public String getSpeed_type() {
		return speed_type;
	}
	public void setSpeed_type(String speed_type) {
		this.speed_type = speed_type;
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
	public String getDamagedAmtEstimated() {
		return damagedAmtEstimated;
	}
	public void setDamagedAmtEstimated(String damagedAmtEstimated) {
		this.damagedAmtEstimated = damagedAmtEstimated;
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
	public String getSuimRptNo() {
		return suimRptNo;
	}
	public void setSuimRptNo(String suimRptNo) {
		this.suimRptNo = suimRptNo;
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
	public String getSpeedType() {
		return speedType;
	}
	public void setSpeedType(String speedType) {
		this.speedType = speedType;
	}
	public String getSuimRptType1Close12() {
		return suimRptType1Close12;
	}
	public void setSuimRptType1Close12(String suimRptType1Close12) {
		this.suimRptType1Close12 = suimRptType1Close12;
	}
	public String getReportEa() {
		return reportEa;
	}
	public void setReportEa(String reportEa) {
		this.reportEa = reportEa;
	}
	public String getAmtInsuPayment() {
		return amtInsuPayment;
	}
	public void setAmtInsuPayment(String amtInsuPayment) {
		this.amtInsuPayment = amtInsuPayment;
	}
	public String getAmtBasic() {
		return amtBasic;
	}
	public void setAmtBasic(String amtBasic) {
		this.amtBasic = amtBasic;
	}
	public String getSuimCloseNo() {
		return suimCloseNo;
	}
	public void setSuimCloseNo(String suimCloseNo) {
		this.suimCloseNo = suimCloseNo;
	}
	public String getSpeed_onestop() {
		return speed_onestop;
	}
	public void setSpeed_onestop(String speed_onestop) {
		this.speed_onestop = speed_onestop;
	}
	public String getOnestopTeamId() {
		return onestopTeamId;
	}
	public void setOnestopTeamId(String onestopTeamId) {
		this.onestopTeamId = onestopTeamId;
	}
	public String getOnestopMbrNo() {
		return onestopMbrNo;
	}
	public void setOnestopMbrNo(String onestopMbrNo) {
		this.onestopMbrNo = onestopMbrNo;
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

}
