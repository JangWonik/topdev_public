package kr.co.toplac.topsuim;

public class TopRptHeadAndBodyVO {
	/*top_rpt_head*/
	private String suim_rpt_no;
	private String suim_accept_no;
	private String suim_close_no;
	private String suim_rpt_type1;
	private String suim_rpt_type2;
	private String team_id;
	private String user_no;
	private String ptnr_id;
	private String ptnr_dept_id;
	private String ptnr_mbr_no;
	private String policyholder_nm;
	private String beneficiary_nm;
	private String damaged_nm;
	private String accident_date;
	private String reg_date;
	private String close_date;
	/*top_rpt_head Add*/
	private String suim_rpt_type1_nm;
	private String suim_rpt_type2_nm;
	private String team_name;
	private String user_name;
	private String ptnr_nick;
	private String ptnr_name;
	private String ptnr_dept_nm;
	private String ptnr_mbr_nm;
	private String accident_date_fmt;
	private String reg_date_fmt;
	private String close_date_fmt;
	private String lock_value;
	private String ROWNUM;
	private String ptnr_id_sub;
	private String period_flag;
	/*top_rpt_head*/
	
	/*top_rpt_body*/
	private String accident_no;
	private String policy_no;
	private String insurance_nm;
	private String policyholder_ssn;
	private String policyholder_tel;
	private String beneficiary_ssn;
	private String beneficiary_tel;
	private String damaged_tel;
	private String accident_facts;
	private String investigate_postcode;
	private String investigate_addr1;
	private String investigate_addr2;
	private String amt_estimated_damage;
	private String commission_estimated;
	private String minwon_flag;		
	
	public String getPeriod_flag() {
		return period_flag;
	}
	public void setPeriod_flag(String period_flag) {
		this.period_flag = period_flag;
	}
	public String getPtnr_id_sub() {
		return ptnr_id_sub;
	}
	public void setPtnr_id_sub(String ptnr_id_sub) {
		this.ptnr_id_sub = ptnr_id_sub;
	}
	public String getSuim_rpt_no() {
		return suim_rpt_no;
	}
	public void setSuim_rpt_no(String suim_rpt_no) {
		this.suim_rpt_no = suim_rpt_no;
	}
	public String getSuim_accept_no() {
		return suim_accept_no;
	}
	public void setSuim_accept_no(String suim_accept_no) {
		this.suim_accept_no = suim_accept_no;
	}
	public String getSuim_close_no() {
		return suim_close_no;
	}
	public void setSuim_close_no(String suim_close_no) {
		this.suim_close_no = suim_close_no;
	}
	public String getSuim_rpt_type1() {
		return suim_rpt_type1;
	}
	public void setSuim_rpt_type1(String suim_rpt_type1) {
		this.suim_rpt_type1 = suim_rpt_type1;
	}
	public String getSuim_rpt_type2() {
		return suim_rpt_type2;
	}
	public void setSuim_rpt_type2(String suim_rpt_type2) {
		this.suim_rpt_type2 = suim_rpt_type2;
	}
	public String getTeam_id() {
		return team_id;
	}
	public void setTeam_id(String team_id) {
		this.team_id = team_id;
	}
	public String getUser_no() {
		return user_no;
	}
	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}
	public String getPtnr_id() {
		return ptnr_id;
	}
	public void setPtnr_id(String ptnr_id) {
		this.ptnr_id = ptnr_id;
	}
	public String getPtnr_dept_id() {
		return ptnr_dept_id;
	}
	public void setPtnr_dept_id(String ptnr_dept_id) {
		this.ptnr_dept_id = ptnr_dept_id;
	}
	public String getPtnr_mbr_no() {
		return ptnr_mbr_no;
	}
	public void setPtnr_mbr_no(String ptnr_mbr_no) {
		this.ptnr_mbr_no = ptnr_mbr_no;
	}
	public String getPolicyholder_nm() {
		return policyholder_nm;
	}
	public void setPolicyholder_nm(String policyholder_nm) {
		this.policyholder_nm = policyholder_nm;
	}
	public String getBeneficiary_nm() {
		return beneficiary_nm;
	}
	public void setBeneficiary_nm(String beneficiary_nm) {
		this.beneficiary_nm = beneficiary_nm;
	}
	public String getDamaged_nm() {
		return damaged_nm;
	}
	public void setDamaged_nm(String damaged_nm) {
		this.damaged_nm = damaged_nm;
	}
	public String getAccident_date() {
		return accident_date;
	}
	public void setAccident_date(String accident_date) {
		this.accident_date = accident_date;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	/*top_rpt_head Add*/
	public String getSuim_rpt_type1_nm() {
		return suim_rpt_type1_nm;
	}
	public void setSuim_rpt_type1_nm(String suim_rpt_type1_nm) {
		this.suim_rpt_type1_nm = suim_rpt_type1_nm;
	}
	public String getSuim_rpt_type2_nm() {
		return suim_rpt_type2_nm;
	}
	public void setSuim_rpt_type2_nm(String suim_rpt_type2_nm) {
		this.suim_rpt_type2_nm = suim_rpt_type2_nm;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getPtnr_nick() {
		return ptnr_nick;
	}
	public void setPtnr_nick(String ptnr_nick) {
		this.ptnr_nick = ptnr_nick;
	}
	public String getPtnr_name() {
		return ptnr_name;
	}
	public void setPtnr_name(String ptnr_name) {
		this.ptnr_name = ptnr_name;
	}
	public String getPtnr_dept_nm() {
		return ptnr_dept_nm;
	}
	public void setPtnr_dept_nm(String ptnr_dept_nm) {
		this.ptnr_dept_nm = ptnr_dept_nm;
	}
	public String getPtnr_mbr_nm() {
		return ptnr_mbr_nm;
	}
	public void setPtnr_mbr_nm(String ptnr_mbr_nm) {
		this.ptnr_mbr_nm = ptnr_mbr_nm;
	}
	public String getAccident_date_fmt() {
		return accident_date_fmt;
	}
	public void setAccident_date_fmt(String accident_date_fmt) {
		this.accident_date_fmt = accident_date_fmt;
	}
	public String getReg_date_fmt() {
		return reg_date_fmt;
	}
	public void setReg_date_fmt(String reg_date_fmt) {
		this.reg_date_fmt = reg_date_fmt;
	}
	public String getClose_date_fmt() {
		return close_date_fmt;
	}
	public void setClose_date_fmt(String close_date_fmt) {
		this.close_date_fmt = close_date_fmt;
	}
	public String getClose_date() {
		return close_date;
	}
	public void setClose_date(String close_date) {
		this.close_date = close_date;
	}
	public String getLock_value() {
		return lock_value;
	}
	public void setLock_value(String lock_value) {
		this.lock_value = lock_value;
	}
	public String getROWNUM() {
		return ROWNUM;
	}
	public void setROWNUM(String rOWNUM) {
		ROWNUM = rOWNUM;
	}
	public String getAccident_no() {
		return accident_no;
	}
	public void setAccident_no(String accident_no) {
		this.accident_no = accident_no;
	}
	public String getPolicy_no() {
		return policy_no;
	}
	public void setPolicy_no(String policy_no) {
		this.policy_no = policy_no;
	}
	public String getInsurance_nm() {
		return insurance_nm;
	}
	public void setInsurance_nm(String insurance_nm) {
		this.insurance_nm = insurance_nm;
	}
	public String getPolicyholder_ssn() {
		return policyholder_ssn;
	}
	public void setPolicyholder_ssn(String policyholder_ssn) {
		this.policyholder_ssn = policyholder_ssn;
	}
	public String getPolicyholder_tel() {
		return policyholder_tel;
	}
	public void setPolicyholder_tel(String policyholder_tel) {
		this.policyholder_tel = policyholder_tel;
	}
	public String getBeneficiary_ssn() {
		return beneficiary_ssn;
	}
	public void setBeneficiary_ssn(String beneficiary_ssn) {
		this.beneficiary_ssn = beneficiary_ssn;
	}
	public String getBeneficiary_tel() {
		return beneficiary_tel;
	}
	public void setBeneficiary_tel(String beneficiary_tel) {
		this.beneficiary_tel = beneficiary_tel;
	}
	public String getDamaged_tel() {
		return damaged_tel;
	}
	public void setDamaged_tel(String damaged_tel) {
		this.damaged_tel = damaged_tel;
	}
	public String getAccident_facts() {
		return accident_facts;
	}
	public void setAccident_facts(String accident_facts) {
		this.accident_facts = accident_facts;
	}
	public String getInvestigate_postcode() {
		return investigate_postcode;
	}
	public void setInvestigate_postcode(String investigate_postcode) {
		this.investigate_postcode = investigate_postcode;
	}
	public String getInvestigate_addr1() {
		return investigate_addr1;
	}
	public void setInvestigate_addr1(String investigate_addr1) {
		this.investigate_addr1 = investigate_addr1;
	}
	public String getInvestigate_addr2() {
		return investigate_addr2;
	}
	public void setInvestigate_addr2(String investigate_addr2) {
		this.investigate_addr2 = investigate_addr2;
	}

	public String getCommission_estimated() {
		return commission_estimated;
	}
	public void setCommission_estimated(String commission_estimated) {
		this.commission_estimated = commission_estimated;
	}
	public String getMinwon_flag() {
		return minwon_flag;
	}
	public void setMinwon_flag(String minwon_flag) {
		this.minwon_flag = minwon_flag;
	}
	public String getAmt_estimated_damage() {
		return amt_estimated_damage;
	}
	public void setAmt_estimated_damage(String amt_estimated_damage) {
		this.amt_estimated_damage = amt_estimated_damage;
	}

}
