package kr.co.toplac.toprptinv;

public class TopRptInvCompositeVO {
	
	private String rpt_invoice_no;
	private String suim_rpt_no;
	private String amt_basic;
	private String amt_basic_dtl;
	private String amt_daily;
	private String amt_daily_dtl;
	private String amt_counsel;
	private String amt_counsel_dtl;
	private String amt_traffic;
	private String amt_traffic_dtl;
	private String amt_etc;
	private String amt_etc_dtl;
	private String amt_total;
	private String sum_amt_total;
	private String rpt_invoice_memo;
	private String tax_invoice_no;
	private String invoice_date;
	private String invoice_date_fmt;
	private String deposit_date;
	private String deposit_date_fmt;
	private String tax_date;
	private String tax_date_fmt;
	private String edit_amt_cnt;
	private String edit_date_cnt;
	private String close_date;
	private String close_date_fmt;
	private String ptnr_id;
	private String ptnr_name;
	private String ptnr_mbr_no;
	private String ptnr_mbr_name;
	private String team_id;
	private String team_name;
	private String user_no;
	private String user_name;
	private String policyholder_nm;
	private String beneficiary_nm;
	private String suim_accept_no;
	private String suim_close_no;
	private String accident_no;
	private String policy_no;
	private String suim_rpt_ea;
	private String tax_edit_end;				//세금계산서 작성 완료 여부 (0:작업중, 1:작업완료)
	private String ptnr_tax_nm;				//세금계산서 담당자 이름
	private String work_state;					//작업상태 (0:대기, 1:작업중)
	private String work_user_no;				//작업자 사번
	private String work_user_nm;			//작업자 이름
	
	public String getWork_state() {
		return work_state;
	}
	public void setWork_state(String work_state) {
		this.work_state = work_state;
	}
	public String getWork_user_no() {
		return work_user_no;
	}
	public void setWork_user_no(String work_user_no) {
		this.work_user_no = work_user_no;
	}
	public String getWork_user_nm() {
		return work_user_nm;
	}
	public void setWork_user_nm(String work_user_nm) {
		this.work_user_nm = work_user_nm;
	}
	public String getPtnr_tax_nm() {
		return ptnr_tax_nm;
	}
	public void setPtnr_tax_nm(String ptnr_tax_nm) {
		this.ptnr_tax_nm = ptnr_tax_nm;
	}
	public String getTax_edit_end() {
		return tax_edit_end;
	}
	public void setTax_edit_end(String tax_edit_end) {
		this.tax_edit_end = tax_edit_end;
	}
	public String getSum_amt_total() {
		return sum_amt_total;
	}
	public void setSum_amt_total(String sum_amt_total) {
		this.sum_amt_total = sum_amt_total;
	}
	public String getRpt_invoice_no() {
		return rpt_invoice_no;
	}
	public void setRpt_invoice_no(String rpt_invoice_no) {
		this.rpt_invoice_no = rpt_invoice_no;
	}
	public String getSuim_rpt_no() {
		return suim_rpt_no;
	}
	public void setSuim_rpt_no(String suim_rpt_no) {
		this.suim_rpt_no = suim_rpt_no;
	}
	public String getAmt_basic() {
		return amt_basic;
	}
	public void setAmt_basic(String amt_basic) {
		this.amt_basic = amt_basic;
	}
	public String getAmt_basic_dtl() {
		return amt_basic_dtl;
	}
	public void setAmt_basic_dtl(String amt_basic_dtl) {
		this.amt_basic_dtl = amt_basic_dtl;
	}
	public String getAmt_daily() {
		return amt_daily;
	}
	public void setAmt_daily(String amt_daily) {
		this.amt_daily = amt_daily;
	}
	public String getAmt_daily_dtl() {
		return amt_daily_dtl;
	}
	public void setAmt_daily_dtl(String amt_daily_dtl) {
		this.amt_daily_dtl = amt_daily_dtl;
	}
	public String getAmt_counsel() {
		return amt_counsel;
	}
	public void setAmt_counsel(String amt_counsel) {
		this.amt_counsel = amt_counsel;
	}
	public String getAmt_counsel_dtl() {
		return amt_counsel_dtl;
	}
	public void setAmt_counsel_dtl(String amt_counsel_dtl) {
		this.amt_counsel_dtl = amt_counsel_dtl;
	}
	public String getAmt_traffic() {
		return amt_traffic;
	}
	public void setAmt_traffic(String amt_traffic) {
		this.amt_traffic = amt_traffic;
	}
	public String getAmt_traffic_dtl() {
		return amt_traffic_dtl;
	}
	public void setAmt_traffic_dtl(String amt_traffic_dtl) {
		this.amt_traffic_dtl = amt_traffic_dtl;
	}
	public String getAmt_etc() {
		return amt_etc;
	}
	public void setAmt_etc(String amt_etc) {
		this.amt_etc = amt_etc;
	}
	public String getAmt_etc_dtl() {
		return amt_etc_dtl;
	}
	public void setAmt_etc_dtl(String amt_etc_dtl) {
		this.amt_etc_dtl = amt_etc_dtl;
	}
	public String getAmt_total() {
		return amt_total;
	}
	public void setAmt_total(String amt_total) {
		this.amt_total = amt_total;
	}
	public String getRpt_invoice_memo() {
		return rpt_invoice_memo;
	}
	public void setRpt_invoice_memo(String rpt_invoice_memo) {
		this.rpt_invoice_memo = rpt_invoice_memo;
	}
	public String getTax_invoice_no() {
		return tax_invoice_no;
	}
	public void setTax_invoice_no(String tax_invoice_no) {
		this.tax_invoice_no = tax_invoice_no;
	}
	public String getInvoice_date() {
		return invoice_date;
	}
	public void setInvoice_date(String invoice_date) {
		this.invoice_date = invoice_date;
	}
	public String getInvoice_date_fmt() {
		return invoice_date_fmt;
	}
	public void setInvoice_date_fmt(String invoice_date_fmt) {
		this.invoice_date_fmt = invoice_date_fmt;
	}
	public String getDeposit_date() {
		return deposit_date;
	}
	public void setDeposit_date(String deposit_date) {
		this.deposit_date = deposit_date;
	}
	public String getDeposit_date_fmt() {
		return deposit_date_fmt;
	}
	public void setDeposit_date_fmt(String deposit_date_fmt) {
		this.deposit_date_fmt = deposit_date_fmt;
	}
	public String getTax_date() {
		return tax_date;
	}
	public void setTax_date(String tax_date) {
		this.tax_date = tax_date;
	}
	public String getTax_date_fmt() {
		return tax_date_fmt;
	}
	public void setTax_date_fmt(String tax_date_fmt) {
		this.tax_date_fmt = tax_date_fmt;
	}
	public String getEdit_amt_cnt() {
		return edit_amt_cnt;
	}
	public void setEdit_amt_cnt(String edit_amt_cnt) {
		this.edit_amt_cnt = edit_amt_cnt;
	}
	public String getEdit_date_cnt() {
		return edit_date_cnt;
	}
	public void setEdit_date_cnt(String edit_date_cnt) {
		this.edit_date_cnt = edit_date_cnt;
	}
	public String getClose_date() {
		return close_date;
	}
	public void setClose_date(String close_date) {
		this.close_date = close_date;
	}
	public String getClose_date_fmt() {
		return close_date_fmt;
	}
	public void setClose_date_fmt(String close_date_fmt) {
		this.close_date_fmt = close_date_fmt;
	}
	public String getPtnr_id() {
		return ptnr_id;
	}
	public void setPtnr_id(String ptnr_id) {
		this.ptnr_id = ptnr_id;
	}
	public String getPtnr_name() {
		return ptnr_name;
	}
	public void setPtnr_name(String ptnr_name) {
		this.ptnr_name = ptnr_name;
	}
	public String getPtnr_mbr_no() {
		return ptnr_mbr_no;
	}
	public void setPtnr_mbr_no(String ptnr_mbr_no) {
		this.ptnr_mbr_no = ptnr_mbr_no;
	}
	public String getPtnr_mbr_name() {
		return ptnr_mbr_name;
	}
	public void setPtnr_mbr_name(String ptnr_mbr_name) {
		this.ptnr_mbr_name = ptnr_mbr_name;
	}
	public String getTeam_id() {
		return team_id;
	}
	public void setTeam_id(String team_id) {
		this.team_id = team_id;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
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
	public String getPolicyholder_nm() {
		return policyholder_nm;
	}
	public void setPolicyholder_nm(String policyholder_nm) {
		this.policyholder_nm = policyholder_nm;
	}
	public String getBeneficiary_nm() {
		return beneficiary_nm;
	}
	public void setBeneficiary_nm(String beneficiary_nm) {
		this.beneficiary_nm = beneficiary_nm;
	}
	public String getSuim_accept_no() {
		return suim_accept_no;
	}
	public void setSuim_accept_no(String suim_accept_no) {
		this.suim_accept_no = suim_accept_no;
	}
	public String getSuim_close_no() {
		return suim_close_no;
	}
	public void setSuim_close_no(String suim_close_no) {
		this.suim_close_no = suim_close_no;
	}
	public String getAccident_no() {
		return accident_no;
	}
	public void setAccident_no(String accident_no) {
		this.accident_no = accident_no;
	}
	public String getPolicy_no() {
		return policy_no;
	}
	public void setPolicy_no(String policy_no) {
		this.policy_no = policy_no;
	}
	public String getSuim_rpt_ea() {
		return suim_rpt_ea;
	}
	public void setSuim_rpt_ea(String suim_rpt_ea) {
		this.suim_rpt_ea = suim_rpt_ea;
	}
	
}
