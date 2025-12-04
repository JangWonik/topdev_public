package kr.co.toplac.searchmain;

public class SearchMainQueryVO {
	private String ptnr_tm2_nm;
	
	private String stateSearch;
	private String noUserSearch;
	private String type1Search;
	private String regDateFromSearch;
	private String regDateToSearch;
	private String cancelDateFromSearch;
	private String cancelDateToSearch;
	private String tmSearch;
	private String tmGubun;
	private String userNmSearch;
	private String aprvDateFromSearch;
	private String aprvDateToSearch;
	private String closeDateFromSearch;
	private String closeDateToSearch;
	private String ptnrSearch;
	private String ptnrGubun;
	private String ptnrDeptNmSearch;
	private String ptnrUserNmSearch;
	private String insuNmSearch;
	private String policyhNmSearch;
	private String policySsn1Search;
	private String policySsn2Search;
	private String benefiNmSearch;
	private String benefiSsn1Search;
	private String benefiSsn2Search;
	private String damagedNmSearch;
	private String accidentNoSearch;	
	private String policyNoSearch;
	private String accidentFactsSearch;
	
	//사고번호검색값
	private String acceptNoSearch;
	private String moralSearch;
	private String minwonSearch;
	private int queryPgNoInt;//paging
	private String searchMainSimpleQueryTxt;
	
	private String minwonDateToSearch;
	private String minwonDateFromSearch;
	
	private String moralDateToSearch;
	private String moralDateFromSearch;
	
	//검색 조건식에서 벗어난 건 처리
	private String notSearch;	
	
	//검색 파라미터 분리
	private String userNo;
	
	//빠른결재 플래그
	private String approvalId;
	
	//사고번호
	private String acceptNo;
	
	//현장보고서 결재 상태 추가 by top3009
	private String siteStateSearch;
	
	//필수업무프로세스 상태 추가 by top3009
	private String processStateSearch;
	
	//현장보고서 종류관련 상태값 추가 by top3009
	private String siteResultSearch;
			
	public String getSiteResultSearch() {
		return siteResultSearch;
	}
	public void setSiteResultSearch(String siteResultSearch) {
		this.siteResultSearch = siteResultSearch;
	}
	public String getProcessStateSearch() {
		return processStateSearch;
	}
	public void setProcessStateSearch(String processStateSearch) {
		this.processStateSearch = processStateSearch;
	}
	public String getSiteStateSearch() {
		return siteStateSearch;
	}
	public void setSiteStateSearch(String siteStateSearch) {
		this.siteStateSearch = siteStateSearch;
	}
	public String getAcceptNo() {
		return acceptNo;
	}
	public void setAcceptNo(String acceptNo) {
		this.acceptNo = acceptNo;
	}
	public String getApprovalId() {
		return approvalId;
	}
	public void setApprovalId(String approvalId) {
		this.approvalId = approvalId;
	}
	public String getStateSearch() {
		return stateSearch;
	}
	public void setStateSearch(String stateSearch) {
		this.stateSearch = stateSearch;
	}
	public String getNoUserSearch() {
		return noUserSearch;
	}
	public void setNoUserSearch(String noUserSearch) {
		this.noUserSearch = noUserSearch;
	}
	public String getType1Search() {
		return type1Search;
	}
	public void setType1Search(String type1Search) {
		this.type1Search = type1Search;
	}
	public String getRegDateFromSearch() {
		return regDateFromSearch;
	}
	public void setRegDateFromSearch(String regDateFromSearch) {
		this.regDateFromSearch = regDateFromSearch;
	}
	public String getRegDateToSearch() {
		return regDateToSearch;
	}
	public void setRegDateToSearch(String regDateToSearch) {
		this.regDateToSearch = regDateToSearch;
	}
	public String getCancelDateFromSearch() {
		return cancelDateFromSearch;
	}
	public void setCancelDateFromSearch(String cancelDateFromSearch) {
		this.cancelDateFromSearch = cancelDateFromSearch;
	}
	public String getCancelDateToSearch() {
		return cancelDateToSearch;
	}
	public void setCancelDateToSearch(String cancelDateToSearch) {
		this.cancelDateToSearch = cancelDateToSearch;
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
	public String getUserNmSearch() {
		return userNmSearch;
	}
	public void setUserNmSearch(String userNmSearch) {
		this.userNmSearch = userNmSearch;
	}
	public String getAprvDateFromSearch() {
		return aprvDateFromSearch;
	}
	public void setAprvDateFromSearch(String aprvDateFromSearch) {
		this.aprvDateFromSearch = aprvDateFromSearch;
	}
	public String getAprvDateToSearch() {
		return aprvDateToSearch;
	}
	public void setAprvDateToSearch(String aprvDateToSearch) {
		this.aprvDateToSearch = aprvDateToSearch;
	}
	public String getCloseDateFromSearch() {
		return closeDateFromSearch;
	}
	public void setCloseDateFromSearch(String closeDateFromSearch) {
		this.closeDateFromSearch = closeDateFromSearch;
	}
	public String getCloseDateToSearch() {
		return closeDateToSearch;
	}
	public void setCloseDateToSearch(String closeDateToSearch) {
		this.closeDateToSearch = closeDateToSearch;
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
	public String getPtnrDeptNmSearch() {
		return ptnrDeptNmSearch;
	}
	public void setPtnrDeptNmSearch(String ptnrDeptNmSearch) {
		this.ptnrDeptNmSearch = ptnrDeptNmSearch;
	}
	public String getPtnrUserNmSearch() {
		return ptnrUserNmSearch;
	}
	public void setPtnrUserNmSearch(String ptnrUserNmSearch) {
		this.ptnrUserNmSearch = ptnrUserNmSearch;
	}
	public String getInsuNmSearch() {
		return insuNmSearch;
	}
	public void setInsuNmSearch(String insuNmSearch) {
		this.insuNmSearch = insuNmSearch;
	}
	public String getPolicyhNmSearch() {
		return policyhNmSearch;
	}
	public void setPolicyhNmSearch(String policyhNmSearch) {
		this.policyhNmSearch = policyhNmSearch;
	}
	public String getPolicySsn1Search() {
		return policySsn1Search;
	}
	public void setPolicySsn1Search(String policySsn1Search) {
		this.policySsn1Search = policySsn1Search;
	}
	public String getPolicySsn2Search() {
		return policySsn2Search;
	}
	public void setPolicySsn2Search(String policySsn2Search) {
		this.policySsn2Search = policySsn2Search;
	}
	public String getBenefiNmSearch() {
		return benefiNmSearch;
	}
	public void setBenefiNmSearch(String benefiNmSearch) {
		this.benefiNmSearch = benefiNmSearch;
	}
	public String getBenefiSsn1Search() {
		return benefiSsn1Search;
	}
	public void setBenefiSsn1Search(String benefiSsn1Search) {
		this.benefiSsn1Search = benefiSsn1Search;
	}
	public String getBenefiSsn2Search() {
		return benefiSsn2Search;
	}
	public void setBenefiSsn2Search(String benefiSsn2Search) {
		this.benefiSsn2Search = benefiSsn2Search;
	}
	public String getDamagedNmSearch() {
		return damagedNmSearch;
	}
	public void setDamagedNmSearch(String damagedNmSearch) {
		this.damagedNmSearch = damagedNmSearch;
	}
	public String getAccidentNoSearch() {
		return accidentNoSearch;
	}
	public void setAccidentNoSearch(String accidentNoSearch) {
		this.accidentNoSearch = accidentNoSearch;
	}
	public String getPolicyNoSearch() {
		return policyNoSearch;
	}
	public void setPolicyNoSearch(String policyNoSearch) {
		this.policyNoSearch = policyNoSearch;
	}
	public String getAccidentFactsSearch() {
		return accidentFactsSearch;
	}
	public void setAccidentFactsSearch(String accidentFactsSearch) {
		this.accidentFactsSearch = accidentFactsSearch;
	}
	public String getAcceptNoSearch() {
		return acceptNoSearch;
	}
	public void setAcceptNoSearch(String acceptNoSearch) {
		this.acceptNoSearch = acceptNoSearch;
	}
	public String getMoralSearch() {
		return moralSearch;
	}
	public void setMoralSearch(String moralSearch) {
		this.moralSearch = moralSearch;
	}
	public String getMinwonSearch() {
		return minwonSearch;
	}
	public void setMinwonSearch(String minwonSearch) {
		this.minwonSearch = minwonSearch;
	}
	public int getQueryPgNoInt() {
		return queryPgNoInt;
	}
	public void setQueryPgNoInt(int queryPgNoInt) {
		this.queryPgNoInt = queryPgNoInt;
	}
	public String getSearchMainSimpleQueryTxt() {
		return searchMainSimpleQueryTxt;
	}
	public void setSearchMainSimpleQueryTxt(String searchMainSimpleQueryTxt) {
		this.searchMainSimpleQueryTxt = searchMainSimpleQueryTxt;
	}
	public String getPtnr_tm2_nm() {
		return ptnr_tm2_nm;
	}
	public void setPtnr_tm2_nm(String ptnr_tm2_nm) {
		this.ptnr_tm2_nm = ptnr_tm2_nm;
	}
	
	public String getMinwonDateToSearch() {
		return minwonDateToSearch;
	}
	public void setMinwonDateToSearch(String minwonDateToSearch) {
		this.minwonDateToSearch = minwonDateToSearch;
	}
	public String getMinwonDateFromSearch() {
		return minwonDateFromSearch;
	}
	public void setMinwonDateFromSearch(String minwonDateFromSearch) {
		this.minwonDateFromSearch = minwonDateFromSearch;
	}
	public String getNotSearch() {
		return notSearch;
	}
	public void setNotSearch(String notSearch) {
		this.notSearch = notSearch;
	}
	public String getMoralDateToSearch() {
		return moralDateToSearch;
	}
	public void setMoralDateToSearch(String moralDateToSearch) {
		this.moralDateToSearch = moralDateToSearch;
	}
	public String getMoralDateFromSearch() {
		return moralDateFromSearch;
	}
	public void setMoralDateFromSearch(String moralDateFromSearch) {
		this.moralDateFromSearch = moralDateFromSearch;
	}
	
	public String getUserNo() {
		return userNo;
	}
	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}
	
	

}
