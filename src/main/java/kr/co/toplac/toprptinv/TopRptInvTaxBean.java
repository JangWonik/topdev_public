package kr.co.toplac.toprptinv;

public class TopRptInvTaxBean {
	private int tax_no = 0;						//인보이스 세금계산서 키
	private String suim_rpt_no = "";			//보고서 ID
	private String ptnr_id = "";					//보험사아이디
	private String ptnr_nm = "";					//보험사이름
	private String suim_accept_no = "";		//보고서 접수번호
	private String beneficiary_nm = "";		//피보험자 이름
	private String publish_date = "";			//발행일자
	private String publish_date_fmt = "";			//발행일자
	private String publish_amount = "";		//발행금액
	private String deposit_date = "";			//입금일자
	private String deposit_date_fmt = "";			//입금일자
	private String deposit_amount = "";		//입금액
	private String reg_date = "";				//등록일자
	private String reg_date_fmt = "";				//등록일자
	private String amt_total = "";				//인보이스(top_rpt_invoice 의 입금액 합
	
	public int getTax_no() {
		return tax_no;
	}
	public void setTax_no(int tax_no) {
		this.tax_no = tax_no;
	}
	public String getPublish_date_fmt() {
		return publish_date_fmt;
	}
	public void setPublish_date_fmt(String publish_date_fmt) {
		this.publish_date_fmt = publish_date_fmt;
	}
	public String getDeposit_date_fmt() {
		return deposit_date_fmt;
	}
	public void setDeposit_date_fmt(String deposit_date_fmt) {
		this.deposit_date_fmt = deposit_date_fmt;
	}
	public String getReg_date_fmt() {
		return reg_date_fmt;
	}
	public void setReg_date_fmt(String reg_date_fmt) {
		this.reg_date_fmt = reg_date_fmt;
	}
	public String getAmt_total() {
		return amt_total;
	}
	public void setAmt_total(String amt_total) {
		this.amt_total = amt_total;
	}	
	public String getSuim_rpt_no() {
		return suim_rpt_no;
	}
	public void setSuim_rpt_no(String suim_rpt_no) {
		this.suim_rpt_no = suim_rpt_no;
	}
	public String getPtnr_id() {
		return ptnr_id;
	}
	public void setPtnr_id(String ptnr_id) {
		this.ptnr_id = ptnr_id;
	}
	public String getPtnr_nm() {
		return ptnr_nm;
	}
	public void setPtnr_nm(String ptnr_nm) {
		this.ptnr_nm = ptnr_nm;
	}
	public String getSuim_accept_no() {
		return suim_accept_no;
	}
	public void setSuim_accept_no(String suim_accept_no) {
		this.suim_accept_no = suim_accept_no;
	}
	public String getBeneficiary_nm() {
		return beneficiary_nm;
	}
	public void setBeneficiary_nm(String beneficiary_nm) {
		this.beneficiary_nm = beneficiary_nm;
	}
	public String getPublish_date() {
		return publish_date;
	}
	public void setPublish_date(String publish_date) {
		this.publish_date = publish_date;
	}
	public String getPublish_amount() {
		return publish_amount;
	}
	public void setPublish_amount(String publish_amount) {
		this.publish_amount = publish_amount;
	}
	public String getDeposit_date() {
		return deposit_date;
	}
	public void setDeposit_date(String deposit_date) {
		this.deposit_date = deposit_date;
	}
	public String getDeposit_amount() {
		return deposit_amount;
	}
	public void setDeposit_amount(String deposit_amount) {
		this.deposit_amount = deposit_amount;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
}
