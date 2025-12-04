package kr.co.toplac.topsuim;

/**
 * top_rpt_ctrl, top_rpt_ctrl_16 통합 Bean 
 * @author Top3009
 *
 */
public class TopRptCtrlAllBean {
	private String serial_no = "";						//일련번호
	private String suim_rpt_no = "";					//리포트 아이디
	private String control_date = "";					//처리일자
	private String control_subject = "";				//처리항목
	private String control_memo = "";					//처리내용
	private String control_who = "";					//면담자
	private String control_relation = "";				//관계
	private String control_contact = "";				//접촉방법
	private String reg_date = "";						//등록일
	
	public String getSerial_no() {
		return serial_no;
	}
	public void setSerial_no(String serial_no) {
		this.serial_no = serial_no;
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
	public String getControl_subject() {
		return control_subject;
	}
	public void setControl_subject(String control_subject) {
		this.control_subject = control_subject;
	}
	public String getControl_memo() {
		return control_memo;
	}
	public void setControl_memo(String control_memo) {
		this.control_memo = control_memo;
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
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
}
