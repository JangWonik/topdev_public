package kr.co.toplac.sysadm.migration;

public class MigrationRptCtrlVO {

	private String rid;
	private String splitTargetData;
	private String suim_rpt_no;
	private String control_date;
	private String control_memo;
	//rpt_ctrl
	private String control_subject;
	//rpt_ctrl16
	private String control_who;
	private String control_relation;
	private String control_contact;

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
	public String getControl_date() {
		return control_date;
	}
	public void setControl_date(String control_date) {
		this.control_date = control_date;
	}
	public String getControl_memo() {
		return control_memo;
	}
	public void setControl_memo(String control_memo) {
		this.control_memo = control_memo;
	}
	public String getControl_subject() {
		return control_subject;
	}
	public void setControl_subject(String control_subject) {
		this.control_subject = control_subject;
	}
	public String getControl_who() {
		return control_who;
	}
	public void setControl_who(String control_who) {
		this.control_who = control_who;
	}
	public String getControl_relation() {
		return control_relation;
	}
	public void setControl_relation(String control_relation) {
		this.control_relation = control_relation;
	}
	public String getControl_contact() {
		return control_contact;
	}
	public void setControl_contact(String control_contact) {
		this.control_contact = control_contact;
	}

}
