package kr.co.toplac.sysadm.migration;

public class MigrationRptFileVO {

	private String rid;
	private String splitTargetData;
	private String suim_rpt_no;
	//rpt_file
	private String up_dir;
	private String up_file;
	private String up_date;

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getSplitTargetData() {
		return splitTargetData;
	}
	public void setSplitTargetData(String splitTargetData) {
		this.splitTargetData = splitTargetData;
	}
	public String getSuim_rpt_no() {
		return suim_rpt_no;
	}
	public void setSuim_rpt_no(String suim_rpt_no) {
		this.suim_rpt_no = suim_rpt_no;
	}
	public String getUp_dir() {
		return up_dir;
	}
	public void setUp_dir(String up_dir) {
		this.up_dir = up_dir;
	}
	public String getUp_file() {
		return up_file;
	}
	public void setUp_file(String up_file) {
		this.up_file = up_file;
	}
	public String getUp_date() {
		return up_date;
	}
	public void setUp_date(String up_date) {
		this.up_date = up_date;
	}

}
