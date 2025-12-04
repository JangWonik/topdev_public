package kr.co.toplac.toprptinv;

public class TopRptInvListSearchVO {

	private String tmSearch;
	private String tmGubun;
	private String ptnrSearch;
	private String ptnrGubun;
	private String type1Search;
	private String speedCheck;
	private String invoice_date_From;
	private String invoice_date_To;
	private String invDateEditCheck;
	private String userNmSearch;
	private String ptnrUserNmSearch;
	private String orderBy;
	private String close_date_From;
	private String close_date_To;
	private String benefiNmSearch;
	private String policyhNmSearch;
	private String acceptNoSearch;
	private String deposit_date_From;
	private String deposit_date_To;
	private String totAmtF;
	private String totAmtT;
	private String depositNoCheck;
	private String amtEditCheck;
	private String taxNoSearch;
	private String taxNoCheck;
	private String tax_date_From;
	private String tax_date_To;
	private String ROWNUM;
	private int queryPgNoInt;			//paging
	private int queryPgSizeInt = 18;		//paging size 기본크기는 18개
	private String taxEditEnd;			//작업완료여부
	private String workUserNo;		//작업중인자의 사번
	private String workState;			//작업상태
	private String invWorkIng;		//작업중 플래그
	private String summary_date_from;
	private String summary_date_to;
	private String accidentNoSearch;		//사고번호 추가
			
	public String getAccidentNoSearch() {
		return accidentNoSearch;
	}
	public void setAccidentNoSearch(String accidentNoSearch) {
		this.accidentNoSearch = accidentNoSearch;
	}
	public String getSummary_date_from() {
		return summary_date_from;
	}
	public void setSummary_date_from(String summary_date_from) {
		this.summary_date_from = summary_date_from;
	}
	public String getSummary_date_to() {
		return summary_date_to;
	}
	public void setSummary_date_to(String summary_date_to) {
		this.summary_date_to = summary_date_to;
	}
	public String getInvWorkIng() {
		return invWorkIng;
	}
	public void setInvWorkIng(String invWorkIng) {
		this.invWorkIng = invWorkIng;
	}
	public String getWorkUserNo() {
		return workUserNo;
	}
	public void setWorkUserNo(String workUserNo) {
		this.workUserNo = workUserNo;
	}
	public String getWorkState() {
		return workState;
	}
	public void setWorkState(String workState) {
		this.workState = workState;
	}
	public String getTaxEditEnd() {
		return taxEditEnd;
	}
	public void setTaxEditEnd(String taxEditEnd) {
		this.taxEditEnd = taxEditEnd;
	}
	private String tax_no_flag;//미발행 체크
	
	public int getQueryPgSizeInt() {
		return queryPgSizeInt;
	}
	public void setQueryPgSizeInt(int queryPgSizeInt) {
		this.queryPgSizeInt = queryPgSizeInt;
	}
	public String getROWNUM() {
		return ROWNUM;
	}
	public void setROWNUM(String rOWNUM) {
		ROWNUM = rOWNUM;
	}
	public String getTmSearch() {
		return tmSearch;
	}
	public void setTmSearch(String tmSearch) {
		this.tmSearch = tmSearch;
	}
	public String getTmGubun() {
		return tmGubun;
	}
	public void setTmGubun(String tmGubun) {
		this.tmGubun = tmGubun;
	}
	public String getPtnrSearch() {
		return ptnrSearch;
	}
	public void setPtnrSearch(String ptnrSearch) {
		this.ptnrSearch = ptnrSearch;
	}
	public String getPtnrGubun() {
		return ptnrGubun;
	}
	public void setPtnrGubun(String ptnrGubun) {
		this.ptnrGubun = ptnrGubun;
	}
	public String getType1Search() {
		return type1Search;
	}
	public void setType1Search(String type1Search) {
		this.type1Search = type1Search;
	}
	public String getSpeedCheck() {
		return speedCheck;
	}
	public void setSpeedCheck(String speedCheck) {
		this.speedCheck = speedCheck;
	}
	public String getInvoice_date_From() {
		return invoice_date_From;
	}
	public void setInvoice_date_From(String invoice_date_From) {
		this.invoice_date_From = invoice_date_From;
	}
	public String getInvoice_date_To() {
		return invoice_date_To;
	}
	public void setInvoice_date_To(String invoice_date_To) {
		this.invoice_date_To = invoice_date_To;
	}
	public String getInvDateEditCheck() {
		return invDateEditCheck;
	}
	public void setInvDateEditCheck(String invDateEditCheck) {
		this.invDateEditCheck = invDateEditCheck;
	}
	public String getUserNmSearch() {
		return userNmSearch;
	}
	public void setUserNmSearch(String userNmSearch) {
		this.userNmSearch = userNmSearch;
	}
	public String getPtnrUserNmSearch() {
		return ptnrUserNmSearch;
	}
	public void setPtnrUserNmSearch(String ptnrUserNmSearch) {
		this.ptnrUserNmSearch = ptnrUserNmSearch;
	}
	public String getOrderBy() {
		return orderBy;
	}
	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}
	public String getClose_date_From() {
		return close_date_From;
	}
	public void setClose_date_From(String close_date_From) {
		this.close_date_From = close_date_From;
	}
	public String getClose_date_To() {
		return close_date_To;
	}
	public void setClose_date_To(String close_date_To) {
		this.close_date_To = close_date_To;
	}
	public String getBenefiNmSearch() {
		return benefiNmSearch;
	}
	public void setBenefiNmSearch(String benefiNmSearch) {
		this.benefiNmSearch = benefiNmSearch;
	}
	public String getPolicyhNmSearch() {
		return policyhNmSearch;
	}
	public void setPolicyhNmSearch(String policyhNmSearch) {
		this.policyhNmSearch = policyhNmSearch;
	}
	public String getAcceptNoSearch() {
		return acceptNoSearch;
	}
	public void setAcceptNoSearch(String acceptNoSearch) {
		this.acceptNoSearch = acceptNoSearch;
	}
	public String getDeposit_date_From() {
		return deposit_date_From;
	}
	public void setDeposit_date_From(String deposit_date_From) {
		this.deposit_date_From = deposit_date_From;
	}
	public String getDeposit_date_To() {
		return deposit_date_To;
	}
	public void setDeposit_date_To(String deposit_date_To) {
		this.deposit_date_To = deposit_date_To;
	}
	public String getTotAmtF() {
		return totAmtF;
	}
	public void setTotAmtF(String totAmtF) {
		this.totAmtF = totAmtF;
	}
	public String getTotAmtT() {
		return totAmtT;
	}
	public void setTotAmtT(String totAmtT) {
		this.totAmtT = totAmtT;
	}
	public String getDepositNoCheck() {
		return depositNoCheck;
	}
	public void setDepositNoCheck(String depositNoCheck) {
		this.depositNoCheck = depositNoCheck;
	}
	public String getAmtEditCheck() {
		return amtEditCheck;
	}
	public void setAmtEditCheck(String amtEditCheck) {
		this.amtEditCheck = amtEditCheck;
	}
	public String getTaxNoSearch() {
		return taxNoSearch;
	}
	public void setTaxNoSearch(String taxNoSearch) {
		this.taxNoSearch = taxNoSearch;
	}
	public String getTaxNoCheck() {
		return taxNoCheck;
	}
	public void setTaxNoCheck(String taxNoCheck) {
		this.taxNoCheck = taxNoCheck;
	}
	public String getTax_date_From() {
		return tax_date_From;
	}
	public void setTax_date_From(String tax_date_From) {
		this.tax_date_From = tax_date_From;
	}
	public String getTax_date_To() {
		return tax_date_To;
	}
	public void setTax_date_To(String tax_date_To) {
		this.tax_date_To = tax_date_To;
	}
	public int getQueryPgNoInt() {
		return queryPgNoInt;
	}
	public void setQueryPgNoInt(int queryPgNoInt) {
		this.queryPgNoInt = queryPgNoInt;
	}
	public String getTax_no_flag() {
		return tax_no_flag;
	}
	public void setTax_no_flag(String tax_no_flag) {
		this.tax_no_flag = tax_no_flag;
	}

}
