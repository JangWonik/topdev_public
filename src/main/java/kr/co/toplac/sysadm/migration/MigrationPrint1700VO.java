package kr.co.toplac.sysadm.migration;

public class MigrationPrint1700VO {

	private String rid;
	private String splitTargetData;
	private String suim_rpt_no;
	//print_1700_7
	private String attach_name;
	private String attach_copy;
	private String attach_etc_memo;

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
	public String getAttach_name() {
		return attach_name;
	}
	public void setAttach_name(String attach_name) {
		this.attach_name = attach_name;
	}
	public String getAttach_copy() {
		return attach_copy;
	}
	public void setAttach_copy(String attach_copy) {
		this.attach_copy = attach_copy;
	}
	public String getAttach_etc_memo() {
		return attach_etc_memo;
	}
	public void setAttach_etc_memo(String attach_etc_memo) {
		this.attach_etc_memo = attach_etc_memo;
	}

}
