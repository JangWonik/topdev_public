package kr.co.toplac.sysadm.migration;

public class MigPrimBizVO {

	//common
	private String rid;
	private String splitTargetData;
	private String suim_rpt_no;
	//nsc_report_data
	private String up_dir;
	private String up_date;
	//top_prim_biz_rpt_file
	private String file_path;
	private String file_name;
	private String reg_date;

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
	public String getUp_dir() {
		return up_dir;
	}
	public void setUp_dir(String up_dir) {
		this.up_dir = up_dir;
	}
	public String getUp_date() {
		return up_date;
	}
	public void setUp_date(String up_date) {
		this.up_date = up_date;
	}
	public String getSuim_rpt_no() {
		return suim_rpt_no;
	}
	public void setSuim_rpt_no(String suim_rpt_no) {
		this.suim_rpt_no = suim_rpt_no;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

}
