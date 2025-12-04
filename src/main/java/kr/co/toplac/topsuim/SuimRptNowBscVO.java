package kr.co.toplac.topsuim;

public class SuimRptNowBscVO {
	
	private String nowNo;
	private String content ;
	private String regDate ;
	private String closePrarnDate;  /*종결예정일*/
	private String suimRptNo ;
	
	public String getNowNo() {
		return nowNo;
	}
	public void setNowNo(String nowNo) {
		this.nowNo = nowNo;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getSuimRptNo() {
		return suimRptNo;
	}
	public void setSuimRptNo(String suimRptNo) {
		this.suimRptNo = suimRptNo;
	}

    public String getClosePrarnDate() {
        return closePrarnDate;
    }

    public void setClosePrarnDate(String closePrarnDate) {
        this.closePrarnDate = closePrarnDate;
    }
}
