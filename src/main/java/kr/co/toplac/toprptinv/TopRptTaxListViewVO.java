package kr.co.toplac.toprptinv;

public class TopRptTaxListViewVO {

	private String rpt_type = "";			//보고서 구분
	private String suim_rpt_no = "";			//보고서 번호
	private String suim_accept_no = "";		//보고서 접수 번호
	private String ptnr_id = "";					//보험사 아이디
	private String ptnr_name = "";				//보험사 이름
	private String user_no = "";					//조사자 사번
	private String user_name = "";				//조사자 이름
	private double sum_tax_val = 0;				//계산서 합계
	private double sum_deposit_val = 0;		//입금합계
	private double sum_minus_val = 0;			//미수금액
	private String tax_edit_end = "";				//작업완료여부
	
	private String publish_date = "";				//계산서 발행일자
	private String publish_date_fmt = "";				//계산서 발행일자(년월일 표시)
	private String deposit_date = "";				//입금일자
	private String close_date = "";					//종결일
	private String close_date_fmt = "";			//종결일 (년월일 표시)
	
	private String center_name = "";				//센터명
	private String team_name = "";				//팀명
	
	private String rpt_invoice_no = "";			//인보이스 번호
	
	private String invoice_deposit_date = "";		//인보이스 내 입금금액
	private String invoice_amt_total = "";			//인보이스 총합금액 (입금금액으로 표시)
		
	public String getPublish_date_fmt() {
		return publish_date_fmt;
	}
	public void setPublish_date_fmt(String publish_date_fmt) {
		this.publish_date_fmt = publish_date_fmt;
	}
	public String getInvoice_amt_total() {
		return invoice_amt_total;
	}
	public void setInvoice_amt_total(String invoice_amt_total) {
		this.invoice_amt_total = invoice_amt_total;
	}
	public String getInvoice_deposit_date() {
		return invoice_deposit_date;
	}
	public void setInvoice_deposit_date(String invoice_deposit_date) {
		this.invoice_deposit_date = invoice_deposit_date;
	}
	public String getRpt_invoice_no() {
		return rpt_invoice_no;
	}
	public void setRpt_invoice_no(String rpt_invoice_no) {
		this.rpt_invoice_no = rpt_invoice_no;
	}
	public String getClose_date_fmt() {
		return close_date_fmt;
	}
	public void setClose_date_fmt(String close_date_fmt) {
		this.close_date_fmt = close_date_fmt;
	}
	public String getCenter_name() {
		return center_name;
	}
	public void setCenter_name(String center_name) {
		this.center_name = center_name;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	public String getPtnr_name() {
		return ptnr_name;
	}
	public void setPtnr_name(String ptnr_name) {
		this.ptnr_name = ptnr_name;
	}
	public String getPublish_date() {
		return publish_date;
	}
	public void setPublish_date(String publish_date) {
		this.publish_date = publish_date;
	}
	public String getDeposit_date() {
		return deposit_date;
	}
	public void setDeposit_date(String deposit_date) {
		this.deposit_date = deposit_date;
	}
	public String getClose_date() {
		return close_date;
	}
	public void setClose_date(String close_date) {
		this.close_date = close_date;
	}
	public String getRpt_type() {
		return rpt_type;
	}
	public void setRpt_type(String rpt_type) {
		this.rpt_type = rpt_type;
	}
	public String getSuim_rpt_no() {
		return suim_rpt_no;
	}
	public void setSuim_rpt_no(String suim_rpt_no) {
		this.suim_rpt_no = suim_rpt_no;
	}
	public String getSuim_accept_no() {
		return suim_accept_no;
	}
	public void setSuim_accept_no(String suim_accept_no) {
		this.suim_accept_no = suim_accept_no;
	}
	public String getPtnr_id() {
		return ptnr_id;
	}
	public void setPtnr_id(String ptnr_id) {
		this.ptnr_id = ptnr_id;
	}	
	public String getUser_no() {
		return user_no;
	}
	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public double getSum_tax_val() {
		return sum_tax_val;
	}
	public void setSum_tax_val(double sum_tax_val) {
		this.sum_tax_val = sum_tax_val;
	}
	public double getSum_deposit_val() {
		return sum_deposit_val;
	}
	public void setSum_deposit_val(double sum_deposit_val) {
		this.sum_deposit_val = sum_deposit_val;
	}
	public double getSum_minus_val() {
		return sum_minus_val;
	}
	public void setSum_minus_val(double sum_minus_val) {
		this.sum_minus_val = sum_minus_val;
	}
	public String getTax_edit_end() {
		return tax_edit_end;
	}
	public void setTax_edit_end(String tax_edit_end) {
		this.tax_edit_end = tax_edit_end;
	}
}
