package kr.co.toplac.rptin;

public class SuimPrint1001VO {
	/* 공통 */
	private String serialNo;
	private String flag;
	
	/* top_print_1 */
	private String rptPrintNo;
	private String insuTerm1;		
	
	private String insuMortgage1;
	private String insuMortgageDtl1;
	private String insuMortgageValue1;
	
	private String faceInsuredJob6;
	private String diagnosisDisease3;
	private String diagnosisHospital3;  
	
	private String accidentDtl3;
	
	private String inspectPoint4;
	private String inspectResult4;
	
	private String pastHospital6;
	
	private String sagoDocFlag;
	
	/* top_print1_claim */
	private String assureDtl;
	private String joinAmount;
	private String estimationAmount;
	
	/* top_print_1_6_1 */
	private String investigateToDate;
	private String investigateFromDate;
	private String investigateDateDtl;
	
	private String investigateOutline;
	private String investigateDtl;
	
	/* top_print_1_2 */
	private String otherInsuCom;
	private String otherInsuDtl;
	private String otherInsuContract;
	
	/* top_print_1_8 */
	private String attachName;
	private String attachCopy;
	private String attachEtcMemo;
	
	/* top_print_1_ctrl */
	private String controlDate;
	private String controlSubject;
	private String controlMemo;
	private String controlEndDate;
	private String controlDelayAgent;
	private String controlDelayDate;
	private String controlDateCnt;
	private String controlDelayCnt;
	private String allDelayCnt;
	private String insuDelayCnt;
	private String notInsuDelayCnt;
	
	/* top_print_1_detail_check*/
	private String detailContent;
	private String detailContentSub;
	private String detailTitle;
	private String detailGubun;
	private String useFlag;
	  
	
	/* top_rpt */
	private String suimRptNo;
	private String insuNm;
	private String policyNo;
	
	/* sysadm_codedic */
	private String tbl_nm;
	private String col_nm;
	private String col_cd;
	private String col_val;
	
	public String getRptPrintNo() {
		return rptPrintNo;
	}
	public void setRptPrintNo(String rptPrintNo) {
		this.rptPrintNo = rptPrintNo;
	}
	public String getInsuTerm1() {
		return insuTerm1;
	}
	public void setInsuTerm1(String insuTerm1) {
		this.insuTerm1 = insuTerm1;
	}
	public String getInsuMortgage1() {
		return insuMortgage1;
	}
	public void setInsuMortgage1(String insuMortgage1) {
		this.insuMortgage1 = insuMortgage1;
	}
	public String getFaceInsuredJob6() {
		return faceInsuredJob6;
	}
	public void setFaceInsuredJob6(String faceInsuredJob6) {
		this.faceInsuredJob6 = faceInsuredJob6;
	}
	public String getDiagnosisDisease3() {
		return diagnosisDisease3;
	}
	public void setDiagnosisDisease3(String diagnosisDisease3) {
		this.diagnosisDisease3 = diagnosisDisease3;
	}
	public String getAccidentDtl3() {
		return accidentDtl3;
	}
	public void setAccidentDtl3(String accidentDtl3) {
		this.accidentDtl3 = accidentDtl3;
	}
	public String getInspectPoint4() {
		return inspectPoint4;
	}
	public void setInspectPoint4(String inspectPoint4) {
		this.inspectPoint4 = inspectPoint4;
	}
	public String getInspectResult4() {
		return inspectResult4;
	}
	public void setInspectResult4(String inspectResult4) {
		this.inspectResult4 = inspectResult4;
	}
	public String getPastHospital6() {
		return pastHospital6;
	}
	public void setPastHospital6(String pastHospital6) {
		this.pastHospital6 = pastHospital6;
	}
	public String getPolicyNo() {
		return policyNo;
	}
	public void setPolicyNo(String policyNo) {
		this.policyNo = policyNo;
	}
	public String getInsuNm() {
		return insuNm;
	}
	public void setInsuNm(String insuNm) {
		this.insuNm = insuNm;
	}
	public String getSuimRptNo() {
		return suimRptNo;
	}
	public void setSuimRptNo(String suimRptNo) {
		this.suimRptNo = suimRptNo;
	}
	
	public String getInvestigateOutline() {
		return investigateOutline;
	}
	public void setInvestigateOutline(String investigateOutline) {
		this.investigateOutline = investigateOutline;
	}
	public String getInvestigateDtl() {
		return investigateDtl;
	}
	public void setInvestigateDtl(String investigateDtl) {
		this.investigateDtl = investigateDtl;
	}
	public String getSerialNo() {
		return serialNo;
	}
	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}

	public String getOtherInsuCom() {
		return otherInsuCom;
	}
	public void setOtherInsuCom(String otherInsuCom) {
		this.otherInsuCom = otherInsuCom;
	}
	public String getOtherInsuDtl() {
		return otherInsuDtl;
	}
	public void setOtherInsuDtl(String otherInsuDtl) {
		this.otherInsuDtl = otherInsuDtl;
	}
	public String getOtherInsuContract() {
		return otherInsuContract;
	}
	public void setOtherInsuContract(String otherInsuContract) {
		this.otherInsuContract = otherInsuContract;
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
	
	public String getAttachName() {
		return attachName;
	}
	public void setAttachName(String attachName) {
		this.attachName = attachName;
	}
	public String getAttachCopy() {
		return attachCopy;
	}
	public void setAttachCopy(String attachCopy) {
		this.attachCopy = attachCopy;
	}
	public String getAttachEtcMemo() {
		return attachEtcMemo;
	}
	public void setAttachEtcMemo(String attachEtcMemo) {
		this.attachEtcMemo = attachEtcMemo;
	}
	
	public String getInsuMortgageDtl1() {
		return insuMortgageDtl1;
	}
	public void setInsuMortgageDtl1(String insuMortgageDtl1) {
		this.insuMortgageDtl1 = insuMortgageDtl1;
	}
	public String getInsuMortgageValue1() {
		return insuMortgageValue1;
	}
	public void setInsuMortgageValue1(String insuMortgageValue1) {
		this.insuMortgageValue1 = insuMortgageValue1;
	}
	public String getDiagnosisHospital3() {
		return diagnosisHospital3;
	}
	public void setDiagnosisHospital3(String diagnosisHospital3) {
		this.diagnosisHospital3 = diagnosisHospital3;
	}
	
	public String getAssureDtl() {
		return assureDtl;
	}
	public void setAssureDtl(String assureDtl) {
		this.assureDtl = assureDtl;
	}
	public String getJoinAmount() {
		return joinAmount;
	}
	public void setJoinAmount(String joinAmount) {
		this.joinAmount = joinAmount;
	}
	public String getEstimationAmount() {
		return estimationAmount;
	}
	public void setEstimationAmount(String estimationAmount) {
		this.estimationAmount = estimationAmount;
	}
	public String getInvestigateToDate() {
		return investigateToDate;
	}
	public void setInvestigateToDate(String investigateToDate) {
		this.investigateToDate = investigateToDate;
	}
	public String getInvestigateFromDate() {
		return investigateFromDate;
	}
	public void setInvestigateFromDate(String investigateFromDate) {
		this.investigateFromDate = investigateFromDate;
	}
	public String getInvestigateDateDtl() {
		return investigateDateDtl;
	}
	public void setInvestigateDateDtl(String investigateDateDtl) {
		this.investigateDateDtl = investigateDateDtl;
	}
	public String getControlDate() {
		return controlDate;
	}
	public void setControlDate(String controlDate) {
		this.controlDate = controlDate;
	}
	public String getControlSubject() {
		return controlSubject;
	}
	public void setControlSubject(String controlSubject) {
		this.controlSubject = controlSubject;
	}
	public String getControlMemo() {
		return controlMemo;
	}
	public void setControlMemo(String controlMemo) {
		this.controlMemo = controlMemo;
	}
	public String getSagoDocFlag() {
		return sagoDocFlag;
	}
	public void setSagoDocFlag(String sagoDocFlag) {
		this.sagoDocFlag = sagoDocFlag;
	}
	
	public String getDetailContent() {
		return detailContent;
	}
	public void setDetailContent(String detailContent) {
		this.detailContent = detailContent;
	}
	public String getDetailTitle() {
		return detailTitle;
	}
	public void setDetailTitle(String detailTitle) {
		this.detailTitle = detailTitle;
	}
	public String getDetailGubun() {
		return detailGubun;
	}
	public void setDetailGubun(String detailGubun) {
		this.detailGubun = detailGubun;
	}
	public String getUseFlag() {
		return useFlag;
	}
	public void setUseFlag(String useFlag) {
		this.useFlag = useFlag;
	}
	public String getDetailContentSub() {
		return detailContentSub;
	}
	public void setDetailContentSub(String detailContentSub) {
		this.detailContentSub = detailContentSub;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getControlEndDate() {
		return controlEndDate;
	}
	public void setControlEndDate(String controlEndDate) {
		this.controlEndDate = controlEndDate;
	}
	public String getControlDelayAgent() {
		return controlDelayAgent;
	}
	public void setControlDelayAgent(String controlDelayAgent) {
		this.controlDelayAgent = controlDelayAgent;
	}
	public String getControlDelayDate() {
		return controlDelayDate;
	}
	public void setControlDelayDate(String controlDelayDate) {
		this.controlDelayDate = controlDelayDate;
	}
	public String getControlDateCnt() {
		return controlDateCnt;
	}
	public void setControlDateCnt(String controlDateCnt) {
		this.controlDateCnt = controlDateCnt;
	}
	public String getControlDelayCnt() {
		return controlDelayCnt;
	}
	public void setControlDelayCnt(String controlDelayCnt) {
		this.controlDelayCnt = controlDelayCnt;
	}
	public String getAllDelayCnt() {
		return allDelayCnt;
	}
	public void setAllDelayCnt(String allDelayCnt) {
		this.allDelayCnt = allDelayCnt;
	}
	public String getInsuDelayCnt() {
		return insuDelayCnt;
	}
	public void setInsuDelayCnt(String insuDelayCnt) {
		this.insuDelayCnt = insuDelayCnt;
	}
	public String getNotInsuDelayCnt() {
		return notInsuDelayCnt;
	}
	public void setNotInsuDelayCnt(String notInsuDelayCnt) {
		this.notInsuDelayCnt = notInsuDelayCnt;
	}
}
