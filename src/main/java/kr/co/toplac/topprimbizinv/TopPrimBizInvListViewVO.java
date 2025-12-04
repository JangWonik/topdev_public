package kr.co.toplac.topprimbizinv;

public class TopPrimBizInvListViewVO {

	private String rpt_invoice_no;
	private String suim_rpt_no;
	private String amt_basic;
	private String amt_daily;
	private String amt_etc;
	private String amt_traffic;
	private String amt_counsel;
	private String amt_total;
	private String rpt_invoice_memo;
	private String invoice_date;
	private String invoice_date_fmt;
	private String deposit_date;
	private String deposit_date_fmt;
	private String issue_tax_invoice;
	private String tax_invoice_no;
	private String tax_date;
	private String tax_date_fmt;
	private String edit_amt_cnt;
	private String edit_date_cnt;
	private String suim_accept_no;
	private String suim_rpt_type1;
	private String suim_rpt_type1_nm;
	private String team_id;
	private String team_mark;
	private String user_no;
	private String user_nm;
	private String ptnr_id;
	private String ptnr_nick;
	private String ptnr_mbr_no;
	private String ptnr_mbr_nm_4edit;
	private String policyholder_nm;
	private String beneficiary_nm;
	private String close_date;
	private String close_date_fmt;
	private int totCntInt;
	private double totAmtBasic;
	private int totAmtDaily;
	private int totAmtEtc;
	private int totAmtTraffic;
	private int totAmtCounsel;
	private double totAmtTotal;
	private String suim_close_no;
	private String accident_no;
	private String insurance_nm;
	private String policy_no;
	private String reg_date;
	private String reg_date_fmt;
	private String sum_share_amt_basic;
	private String sum_share_amt_daily;
	private String sum_share_amt_etc;
	private String sum_share_amt_traffic;
	private String sum_share_amt_counsel;
	private String sum_share_amt_total;
	private String tax_edit_end;						//세금계산서작업종료여부(0:작업중,1:작업종료)
	private String ptnr_name;						//보험사이름
	
	public String getPtnr_name() {
		return ptnr_name;
	}
	public void setPtnr_name(String ptnr_name) {
		this.ptnr_name = ptnr_name;
	}
	public String getTax_edit_end() {
		return tax_edit_end;
	}
	public void setTax_edit_end(String tax_edit_end) {
		this.tax_edit_end = tax_edit_end;
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
	public String getInsurance_nm() {
		return insurance_nm;
	}
	public void setInsurance_nm(String insurance_nm) {
		this.insurance_nm = insurance_nm;
	}
	public String getPolicy_no() {
		return policy_no;
	}
	public void setPolicy_no(String policy_no) {
		this.policy_no = policy_no;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getReg_date_fmt() {
		return reg_date_fmt;
	}
	public void setReg_date_fmt(String reg_date_fmt) {
		this.reg_date_fmt = reg_date_fmt;
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
	public String getAmt_daily() {
		return amt_daily;
	}
	public void setAmt_daily(String amt_daily) {
		this.amt_daily = amt_daily;
	}
	public String getAmt_etc() {
		return amt_etc;
	}
	public void setAmt_etc(String amt_etc) {
		this.amt_etc = amt_etc;
	}
	public String getAmt_traffic() {
		return amt_traffic;
	}
	public void setAmt_traffic(String amt_traffic) {
		this.amt_traffic = amt_traffic;
	}
	public String getAmt_counsel() {
		return amt_counsel;
	}
	public void setAmt_counsel(String amt_counsel) {
		this.amt_counsel = amt_counsel;
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
	public String getIssue_tax_invoice() {
		return issue_tax_invoice;
	}
	public void setIssue_tax_invoice(String issue_tax_invoice) {
		this.issue_tax_invoice = issue_tax_invoice;
	}
	public String getTax_invoice_no() {
		return tax_invoice_no;
	}
	public void setTax_invoice_no(String tax_invoice_no) {
		this.tax_invoice_no = tax_invoice_no;
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
	public String getSuim_accept_no() {
		return suim_accept_no;
	}
	public void setSuim_accept_no(String suim_accept_no) {
		this.suim_accept_no = suim_accept_no;
	}
	public String getSuim_rpt_type1() {
		return suim_rpt_type1;
	}
	public void setSuim_rpt_type1(String suim_rpt_type1) {
		this.suim_rpt_type1 = suim_rpt_type1;
	}
	public String getSuim_rpt_type1_nm() {
		return suim_rpt_type1_nm;
	}
	public void setSuim_rpt_type1_nm(String suim_rpt_type1_nm) {
		this.suim_rpt_type1_nm = suim_rpt_type1_nm;
	}
	public String getTeam_id() {
		return team_id;
	}
	public void setTeam_id(String team_id) {
		this.team_id = team_id;
	}
	public String getTeam_mark() {
		return team_mark;
	}
	public void setTeam_mark(String team_mark) {
		this.team_mark = team_mark;
	}
	public String getUser_no() {
		return user_no;
	}
	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	public String getPtnr_id() {
		return ptnr_id;
	}
	public void setPtnr_id(String ptnr_id) {
		this.ptnr_id = ptnr_id;
	}
	public String getPtnr_nick() {
		return ptnr_nick;
	}
	public void setPtnr_nick(String ptnr_nick) {
		this.ptnr_nick = ptnr_nick;
	}
	public String getPtnr_mbr_no() {
		return ptnr_mbr_no;
	}
	public void setPtnr_mbr_no(String ptnr_mbr_no) {
		this.ptnr_mbr_no = ptnr_mbr_no;
	}
	public String getPtnr_mbr_nm_4edit() {
		return ptnr_mbr_nm_4edit;
	}
	public void setPtnr_mbr_nm_4edit(String ptnr_mbr_nm_4edit) {
		this.ptnr_mbr_nm_4edit = ptnr_mbr_nm_4edit;
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
	public int getTotCntInt() {
		return totCntInt;
	}
	public void setTotCntInt(int totCntInt) {
		this.totCntInt = totCntInt;
	}
	public double getTotAmtBasic() {
		return totAmtBasic;
	}
	public void setTotAmtBasic(double totAmtBasic) {
		this.totAmtBasic = totAmtBasic;
	}
	public int getTotAmtDaily() {
		return totAmtDaily;
	}
	public void setTotAmtDaily(int totAmtDaily) {
		this.totAmtDaily = totAmtDaily;
	}
	public int getTotAmtEtc() {
		return totAmtEtc;
	}
	public void setTotAmtEtc(int totAmtEtc) {
		this.totAmtEtc = totAmtEtc;
	}
	public int getTotAmtTraffic() {
		return totAmtTraffic;
	}
	public void setTotAmtTraffic(int totAmtTraffic) {
		this.totAmtTraffic = totAmtTraffic;
	}
	public int getTotAmtCounsel() {
		return totAmtCounsel;
	}
	public void setTotAmtCounsel(int totAmtCounsel) {
		this.totAmtCounsel = totAmtCounsel;
	}
	public double getTotAmtTotal() {
		return totAmtTotal;
	}
	public void setTotAmtTotal(double totAmtTotal) {
		this.totAmtTotal = totAmtTotal;
	}
	public String getSum_share_amt_basic() {
		return sum_share_amt_basic;
	}
	public void setSum_share_amt_basic(String sum_share_amt_basic) {
		this.sum_share_amt_basic = sum_share_amt_basic;
	}
	public String getSum_share_amt_daily() {
		return sum_share_amt_daily;
	}
	public void setSum_share_amt_daily(String sum_share_amt_daily) {
		this.sum_share_amt_daily = sum_share_amt_daily;
	}
	public String getSum_share_amt_etc() {
		return sum_share_amt_etc;
	}
	public void setSum_share_amt_etc(String sum_share_amt_etc) {
		this.sum_share_amt_etc = sum_share_amt_etc;
	}
	public String getSum_share_amt_traffic() {
		return sum_share_amt_traffic;
	}
	public void setSum_share_amt_traffic(String sum_share_amt_traffic) {
		this.sum_share_amt_traffic = sum_share_amt_traffic;
	}
	public String getSum_share_amt_counsel() {
		return sum_share_amt_counsel;
	}
	public void setSum_share_amt_counsel(String sum_share_amt_counsel) {
		this.sum_share_amt_counsel = sum_share_amt_counsel;
	}
	public String getSum_share_amt_total() {
		return sum_share_amt_total;
	}
	public void setSum_share_amt_total(String sum_share_amt_total) {
		this.sum_share_amt_total = sum_share_amt_total;
	}

}
