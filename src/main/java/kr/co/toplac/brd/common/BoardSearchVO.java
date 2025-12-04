package kr.co.toplac.brd.common;

public class BoardSearchVO {

	private int boardSrcType;
	private String boardSrcWord;
	private String reqPgNo;
	private int queryPgNoInt;
	//보험사공지
	private String insu;
	//보험사자료실
	private String ptnrSearch;
	private String ptnrGubun;
	private String titleSearch;
	private String typeSearch;
	private String yearSearch;	
	//결재조회권한
	private String approval_auth;		//0:권한없음, 1:1종, 4:4종, 5:전체	
	//물보험 자료실
	private String eventSearch;			//물보험자료실 종목검색
	private String cateSearch;				//물보험자료실 카테고리
	
	//교육qna게시판추가
	private String pkeySearch;			//교육과정키
	
	//교육qna,자료실 구분자추가
	private String boardType;				//교육게시판 구분자(0:qna, 1:교육자료실)
	
	//공개강의실 구분자추가
	private String teamType;				//교육구분
	private String categoryType;			//교육분류
	private String subjectSearch;			//강의명
	
	public String getTeamType() {
		return teamType;
	}
	public void setTeamType(String teamType) {
		this.teamType = teamType;
	}
	public String getCategoryType() {
		return categoryType;
	}
	public void setCategoryType(String categoryType) {
		this.categoryType = categoryType;
	}
	public String getSubjectSearch() {
		return subjectSearch;
	}
	public void setSubjectSearch(String subjectSearch) {
		this.subjectSearch = subjectSearch;
	}
	public String getBoardType() {
		return boardType;
	}
	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}
	public String getPkeySearch() {
		return pkeySearch;
	}
	public void setPkeySearch(String pkeySearch) {
		this.pkeySearch = pkeySearch;
	}
	public String getCateSearch() {
		return cateSearch;
	}
	public void setCateSearch(String cateSearch) {
		this.cateSearch = cateSearch;
	}
	public String getEventSearch() {
		return eventSearch;
	}
	public void setEventSearch(String eventSearch) {
		this.eventSearch = eventSearch;
	}
	public String getApproval_auth() {
		return approval_auth;
	}
	public void setApproval_auth(String approval_auth) {
		this.approval_auth = approval_auth;
	}
	public int getBoardSrcType() {
		return boardSrcType;
	}
	public void setBoardSrcType(int boardSrcType) {
		this.boardSrcType = boardSrcType;
	}
	public String getBoardSrcWord() {
		return boardSrcWord;
	}
	public void setBoardSrcWord(String boardSrcWord) {
		this.boardSrcWord = boardSrcWord;
	}
	public String getReqPgNo() {
		return reqPgNo;
	}
	public void setReqPgNo(String reqPgNo) {
		this.reqPgNo = reqPgNo;
	}
	public int getQueryPgNoInt() {
		return queryPgNoInt;
	}
	public void setQueryPgNoInt(int queryPgNoInt) {
		this.queryPgNoInt = queryPgNoInt;
	}
	public String getInsu() {
		return insu;
	}
	public void setInsu(String insu) {
		this.insu = insu;
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
	public String getTitleSearch() {
		return titleSearch;
	}
	public void setTitleSearch(String titleSearch) {
		this.titleSearch = titleSearch;
	}
	public String getTypeSearch() {
		return typeSearch;
	}
	public void setTypeSearch(String typeSearch) {
		this.typeSearch = typeSearch;
	}
	public String getYearSearch() {
		return yearSearch;
	}
	public void setYearSearch(String yearSearch) {
		this.yearSearch = yearSearch;
	}

}
