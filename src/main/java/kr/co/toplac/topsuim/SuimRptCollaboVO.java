package kr.co.toplac.topsuim;

public class SuimRptCollaboVO {
	private String suimRptNo;
	private String serialNo;
	private String userId;
	private String shareTeamId;
	private String collaboPp;
	
	private String collaboPrice;				//공동기본보수, 20210923 추가
	private String collaboPriceType;			//공동 기본보수 구분, 20210923 추가
	
	private String collaboDaily;		//공동 일비, 180410추가
	private String collaboDailyType;	//공동 일비 구분, 180410추가
	private String collaboTraffic;		//공동 교통비, 180410추가
	
	private String regDate;
	private String delState;
	private String delDate;
	private String userName;
	
	private String writtenCnt;		//서면심사, 종결건수 20191017 추가
	private String writtenBasic;		//서면심사, 기본보수추가 20191017 추가
	
	private String approvalUserNo;		//결재수수료 결재자 사번 20231228 추가
	private String approvalUserName;	//결재수수료 결재자 이름 20231228 추가
	private String approvalTeamName;	//결재수수료 결재 팀이름 20231228 추가
	private String approvalTeamId;		//결재수수료 결재 팀 아이디 20231228 추가
	private String approvalFlag;			//공동수행 결재 수수료 여부 (0:기본, 1:결재수수료) 20231228 추가  
		
	public String getApprovalTeamId() {
		return approvalTeamId;
	}
	public void setApprovalTeamId(String approvalTeamId) {
		this.approvalTeamId = approvalTeamId;
	}
	public String getApprovalTeamName() {
		return approvalTeamName;
	}
	public void setApprovalTeamName(String approvalTeamName) {
		this.approvalTeamName = approvalTeamName;
	}
	public String getApprovalUserNo() {
		return approvalUserNo;
	}
	public void setApprovalUserNo(String approvalUserNo) {
		this.approvalUserNo = approvalUserNo;
	}
	public String getApprovalUserName() {
		return approvalUserName;
	}
	public void setApprovalUserName(String approvalUserName) {
		this.approvalUserName = approvalUserName;
	}
	public String getApprovalFlag() {
		return approvalFlag;
	}
	public void setApprovalFlag(String approvalFlag) {
		this.approvalFlag = approvalFlag;
	}
	public String getCollaboPrice() {
		return collaboPrice;
	}
	public void setCollaboPrice(String collaboPrice) {
		this.collaboPrice = collaboPrice;
	}
	public String getCollaboPriceType() {
		return collaboPriceType;
	}
	public void setCollaboPriceType(String collaboPriceType) {
		this.collaboPriceType = collaboPriceType;
	}
	public String getWrittenCnt() {
		return writtenCnt;
	}
	public void setWrittenCnt(String writtenCnt) {
		this.writtenCnt = writtenCnt;
	}
	public String getWrittenBasic() {
		return writtenBasic;
	}
	public void setWrittenBasic(String writtenBasic) {
		this.writtenBasic = writtenBasic;
	}
	public String getSuimRptNo() {
		return suimRptNo;
	}
	public void setSuimRptNo(String suimRptNo) {
		this.suimRptNo = suimRptNo;
	}
	public String getSerialNo() {
		return serialNo;
	}
	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getCollaboPp() {
		return collaboPp;
	}
	public void setCollaboPp(String collaboPp) {
		this.collaboPp = collaboPp;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getDelState() {
		return delState;
	}
	public void setDelState(String delState) {
		this.delState = delState;
	}
	public String getDelDate() {
		return delDate;
	}
	public void setDelDate(String delDate) {
		this.delDate = delDate;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getShareTeamId() {
		return shareTeamId;
	}

	public void setShareTeamId(String shareTeamId) {
		this.shareTeamId = shareTeamId;
	}
	public String getCollaboDaily() {
		return collaboDaily;
	}
	public void setCollaboDaily(String collaboDaily) {
		this.collaboDaily = collaboDaily;
	}
	public String getCollaboDailyType() {
		return collaboDailyType;
	}
	public void setCollaboDailyType(String collaboDailyType) {
		this.collaboDailyType = collaboDailyType;
	}
	public String getCollaboTraffic() {
		return collaboTraffic;
	}
	public void setCollaboTraffic(String collaboTraffic) {
		this.collaboTraffic = collaboTraffic;
	}
	
	
}
