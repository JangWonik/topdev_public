package kr.co.toplac.topsuim;

public class SuimRptHelpCompositeVO {
	
	private String serialNo;
	private String suimRptNo ;
	private String clientTm;
	private String clientMbr ;
	private String acceptTm ;
	private String acceptMbr ;
	private String helpMemo ;
	private String helpResult ;
	private String helpFile ;
	private String helpState ;
	private String trafficFee ;
	private String chartFee ;
	private String priceTotal ;
	private String regDate ;
	private String endDate ;
	private String acceptTmId ;
	private String acceptMbrId;
	private String ROWNUM ;
	private String clientMbrId ;
	private String clientTmId;
	
	/*수임건 정보*/
	private String acceptNo ;
	private String beneficiaryNm ;
	private String rptTm ;
	private String rptMbr ;
	private String ptnrName ;
	private String ptnrMbrNm ;
	private String policyholderNm ;
	private String damagedNm ;
	private String policyholderTel ;
	private String beneficiaryTel ;
	private String damagedTel ;
	
	/*사원 정보*/
	private String rptUserPhone ;
	private String editYN;

	public String getEditYN() {
		return editYN;
	}
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
	public String getClientTm() {
		return clientTm;
	}
	public void setClientTm(String clientTm) {
		this.clientTm = clientTm;
	}
	public String getClientMbr() {
		return clientMbr;
	}
	public void setClientMbr(String clientMbr) {
		this.clientMbr = clientMbr;
	}
	public String getAcceptTm() {
		return acceptTm;
	}
	public void setAcceptTm(String acceptTm) {
		this.acceptTm = acceptTm;
	}
	public String getAcceptMbr() {
		return acceptMbr;
	}
	public void setAcceptMbr(String acceptMbr) {
		this.acceptMbr = acceptMbr;
	}
	public String getHelpMemo() {
		return helpMemo;
	}
	public void setHelpMemo(String helpMemo) {
		this.helpMemo = helpMemo;
	}
	public String getHelpResult() {
		return helpResult;
	}
	public void setHelpResult(String helpResult) {
		this.helpResult = helpResult;
	}
	public String getHelpFile() {
		return helpFile;
	}
	public void setHelpFile(String helpFile) {
		this.helpFile = helpFile;
	}
	public String getHelpState() {
		return helpState;
	}
	public void setHelpState(String helpState) {
		this.helpState = helpState;
	}
	public String getTrafficFee() {
		return trafficFee;
	}
	public void setTrafficFee(String trafficFee) {
		this.trafficFee = trafficFee;
	}
	public String getChartFee() {
		return chartFee;
	}
	public void setChartFee(String chartFee) {
		this.chartFee = chartFee;
	}
	public String getPriceTotal() {
		return priceTotal;
	}
	public void setPriceTotal(String priceTotal) {
		this.priceTotal = priceTotal;
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
	public String getAcceptTmId() {
		return acceptTmId;
	}
	public void setAcceptTmId(String acceptTmId) {
		this.acceptTmId = acceptTmId;
	}
	public String getROWNUM() {
		return ROWNUM;
	}
	public void setROWNUM(String rOWNUM) {
		ROWNUM = rOWNUM;
	}
	public String getAcceptNo() {
		return acceptNo;
	}
	public void setAcceptNo(String acceptNo) {
		this.acceptNo = acceptNo;
	}
	public String getBeneficiaryNm() {
		return beneficiaryNm;
	}
	public void setBeneficiaryNm(String beneficiaryNm) {
		this.beneficiaryNm = beneficiaryNm;
	}
	public String getRptTm() {
		return rptTm;
	}
	public void setRptTm(String rptTm) {
		this.rptTm = rptTm;
	}
	public String getRptMbr() {
		return rptMbr;
	}
	public void setRptMbr(String rptMbr) {
		this.rptMbr = rptMbr;
	}
	public String getPtnrName() {
		return ptnrName;
	}
	public void setPtnrName(String ptnrName) {
		this.ptnrName = ptnrName;
	}
	public String getPtnrMbrNm() {
		return ptnrMbrNm;
	}
	public void setPtnrMbrNm(String ptnrMbrNm) {
		this.ptnrMbrNm = ptnrMbrNm;
	}
	public String getPolicyholderNm() {
		return policyholderNm;
	}
	public void setPolicyholderNm(String policyholderNm) {
		this.policyholderNm = policyholderNm;
	}
	public String getDamagedNm() {
		return damagedNm;
	}
	public void setDamagedNm(String damagedNm) {
		this.damagedNm = damagedNm;
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
	public String getAcceptMbrId() {
		return acceptMbrId;
	}
	public void setAcceptMbrId(String acceptMbrId) {
		this.acceptMbrId = acceptMbrId;
	}
	public String getRptUserPhone() {
		return rptUserPhone;
	}
	public void setRptUserPhone(String rptUserPhone) {
		this.rptUserPhone = rptUserPhone;
	}
	public String getClientMbrId() {
		return clientMbrId;
	}
	public void setClientMbrId(String clientMbrId) {
		this.clientMbrId = clientMbrId;
	}
	public String getClientTmId() {
		return clientTmId;
	}
	public void setClientTmId(String clientTmId) {
		this.clientTmId = clientTmId;
	}
	
}
