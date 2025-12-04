package kr.co.toplac.toprptinv;

public class TopRptTaxListSearchVO {

	private String tmSearch = "";				//검색 담당팀
	private String ptnrSearch = "";				//검색 보험사명
	private String srchUserNoMain = "";		//검색 조사자 이름
	private String rptTypeSearch = "";			//보고서 구분
	
	private String tax_date_from = "";		//세금계산서 검색 시작일
	private String tax_date_to = "";			//세금계산서 검색 종료일
	
	private String deposit_date_from = "";		//입금 검색 시작일
	private String deposit_date_to = "";		//입금 검색 종료일
	
	private String close_date_from = "";			//종결 검색 시작일
	private String close_date_to = "";				//종결 검색 종료일
	
	private String orderBy	= "";							//정렬방식
	private String ROWNUM = "";						//페이지표시수
	private int queryPgNoInt = 1;						//paging 번호
	
	private String taxNoCheck = "";					//미수체크 여부	
	private String endNoCheck = "";					//미완료체크 여부
	
	private String summary_date_from = "";
	private String summary_date_to = "";
		
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

	public String getEndNoCheck() {
		return endNoCheck;
	}

	public void setEndNoCheck(String endNoCheck) {
		this.endNoCheck = endNoCheck;
	}

	public String getTaxNoCheck() {
		return taxNoCheck;
	}

	public void setTaxNoCheck(String taxNoCheck) {
		this.taxNoCheck = taxNoCheck;
	}

	public String getTax_date_from() {
		return tax_date_from;
	}

	public void setTax_date_from(String tax_date_from) {
		this.tax_date_from = tax_date_from;
	}

	public String getTax_date_to() {
		return tax_date_to;
	}

	public void setTax_date_to(String tax_date_to) {
		this.tax_date_to = tax_date_to;
	}

	public String getDeposit_date_from() {
		return deposit_date_from;
	}

	public void setDeposit_date_from(String deposit_date_from) {
		this.deposit_date_from = deposit_date_from;
	}

	public String getDeposit_date_to() {
		return deposit_date_to;
	}

	public void setDeposit_date_to(String deposit_date_to) {
		this.deposit_date_to = deposit_date_to;
	}

	public String getClose_date_from() {
		return close_date_from;
	}

	public void setClose_date_from(String close_date_from) {
		this.close_date_from = close_date_from;
	}

	public String getClose_date_to() {
		return close_date_to;
	}

	public void setClose_date_to(String close_date_to) {
		this.close_date_to = close_date_to;
	}

	public String getTmSearch() {
		return tmSearch;
	}

	public void setTmSearch(String tmSearch) {
		this.tmSearch = tmSearch;
	}

	public String getPtnrSearch() {
		return ptnrSearch;
	}

	public void setPtnrSearch(String ptnrSearch) {
		this.ptnrSearch = ptnrSearch;
	}

	public String getSrchUserNoMain() {
		return srchUserNoMain;
	}

	public void setSrchUserNoMain(String srchUserNoMain) {
		this.srchUserNoMain = srchUserNoMain;
	}

	public String getRptTypeSearch() {
		return rptTypeSearch;
	}

	public void setRptTypeSearch(String rptTypeSearch) {
		this.rptTypeSearch = rptTypeSearch;
	}

	public String getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}

	public String getROWNUM() {
		return ROWNUM;
	}

	public void setROWNUM(String rOWNUM) {
		ROWNUM = rOWNUM;
	}

	public int getQueryPgNoInt() {
		return queryPgNoInt;
	}

	public void setQueryPgNoInt(int queryPgNoInt) {
		this.queryPgNoInt = queryPgNoInt;
	}

}
