package kr.co.toplac.topsuim;

public class SuimRptSagoBsc16MidVO {
	
	private String serialNo = "";								//메리츠 인보험 중간보고서 키
	private String suimRptNo = "";							//보고서 키
	private String minwonActComment = "";				//특이사항 및 민원예방활동내용
	private String reportDate = "";							//보고서등록일
	private String regDate = "";								//데이터틍록일
	
	public String getSerialNo() {
		return serialNo;
	}
	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}
	public String getSuimRptNo() {
		return suimRptNo;
	}
	public void setSuimRptNo(String suimRptNo) {
		this.suimRptNo = suimRptNo;
	}
	public String getMinwonActComment() {
		return minwonActComment;
	}
	public void setMinwonActComment(String minwonActComment) {
		this.minwonActComment = minwonActComment;
	}
	public String getReportDate() {
		return reportDate;
	}
	public void setReportDate(String reportDate) {
		this.reportDate = reportDate;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
}