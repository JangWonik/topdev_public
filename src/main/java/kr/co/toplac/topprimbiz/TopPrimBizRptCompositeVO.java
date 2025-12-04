package kr.co.toplac.topprimbiz;

public class TopPrimBizRptCompositeVO {

	//top_prim_biz_rpt_head
	private String suim_rpt_no;
	private String suim_accept_no;
	private String suim_close_no;
	private String suim_rpt_type1;
	private String suim_rpt_type1_nm;
	private String suim_rpt_state;
	private String suim_rpt_state_nm;
	private String suim_rpt_type1_close12;
	private String suim_rpt_type1_close12_nm;
	private String team_id;
	private String team_name;
	private String user_no;
	private String user_name;
	private String ptnr_id;
	private String ptnr_nick;
	private String ptnr_name;
	private String ptnr_dept_id;
	private String ptnr_dept_name;
	private String ptnr_tm2_nm;
	private String ptnr_mbr_no;
	private String ptnr_mbr_name;
	private String ptnr_dept_nm_4edit;
	private String ptnbr_mbr_nm_4edit;
	private String policyholder_nm;
	private String beneficiary_nm;
	private String damaged_nm;
	private String suim_rpt_ea;
	private String accident_date;
	private String accident_date_fmt;
	private String reg_date;
	private String reg_date_fmt;
	private String suim_cancel_date;
	private String lawsuit_date;
	private String suim_rpt_aprv_date;
	private String close_date;
	private String close_date_fmt;
	private String del_date;
	private String lock_flag;
	//top_prim_biz_rpt_body
	private String moral_flag;
	private String moral_flag_nm;
	private String minwon_flag;
	private String minwon_flag_nm;
	private String accident_no;
	private String policy_no;
	private String insurance_nm;
	private String policyholder_ssn;
	private String policyholder_tel;
	private String beneficiary_ssn;
	private String beneficiary_tel;
	private String damaged_tel;
	private String accident_facts;
	private String amt_estimated_damage;
	private String amt_definite;
	private String amt_reduction;
	private String commission_estimated;
	private String amt_claimed;
	private String amt_settlement;
	private String amt_self_pay;
	private String amt_insu_payment;
	private String investigate_postcode;
	private String investigate_addr1;
	private String investigate_addr2;
	//top_prim_biz_inv
	private String rpt_invoice_no;
	private String amt_basic;
	private String amt_basic_dtl;
	private String amt_daily;
	private String amt_daily_dtl;
	private String amt_counsel;
	private String amt_counsel_dtl;
	private String amt_traffic;
	private String amt_traffic_dtl;
	private String amt_etc;
	private String amt_etc_dtl;
	private String amt_total;
	private String rpt_invoice_memo;
	private String tax_invoice_no;
	private String invoice_date;
	private String invoice_date_fmt;
	private String deposit_date;
	private String deposit_date_fmt;
	private String tax_date;
	private String tax_date_fmt;
	private String edit_amt_cnt;
	private String edit_date_cnt;
	//top_prim_biz_inv_share
	private String serial_no;
	private String share_user_no;
	private String share_team_id;
	private String share_user_name;
	private String share_amt_basic;
	private String share_amt_daily;
	private String share_amt_etc;
	private String share_amt_traffic;
	private String share_amt_counsel;
	private String share_amt_total;
	private String share_ea;
	private String share_workload_ea;
	
	//top_prim_biz_inv_share_log
	private String prim_biz_inv_share_no;
	private String reg_user_no;
	private String reg_type;
	//
	private String share_rpt_no;
	private String sum_share_basic;
	private String sum_share_daily;
	private String sum_share_etc;
	private String sum_share_traffic;
	private String sum_share_counsel;
	private String sum_share_total;
	private String sum_share_ea;
	private String log_ip;
	private String log_user_no;
	private String suimRptNo;
	//top_mbr_bsc
	private String handphone;
	//top_ptnr_mbr_bsc
	private String ptnr_mbr_nm;
	private String ptnr_mbr_hp;
	//etc
	private String present_user_no;
	private String read_yn;
	private String edit_yn;
	private String close_pms_yn;
	private String mbrChgAuthYN;
	private String ptnrMbrChgAuthYN;
	
	private String endModAuth; //종결 후 수정
	
	private String editYN2;
	
	//기준업무량 상세
	private String workloadType; 
	private String workload_type; 
	
	private String workloadEa; 
	private String workload_ea; 
	
	private String workloadTypeVal; 
	private String workloadUseAt;

	private String year;
	
	private String registrant;			//수임등록자
	private String registrant_nm;	//수임등록자 이름
	
	private String close_ptnr_dept_nm;			//종결시점 보험사 부서명
	private String close_ptnr_tm2_nm;				//종결시점 보험사 팀명
	
	private String rptCancelApprovalAuthYN;		//위임취소 결재권한 (기존 종결권한에서 별도권한으로 처리) by top3009 (20240725)
		
	public String getRptCancelApprovalAuthYN() {
		return rptCancelApprovalAuthYN;
	}
	public void setRptCancelApprovalAuthYN(String rptCancelApprovalAuthYN) {
		this.rptCancelApprovalAuthYN = rptCancelApprovalAuthYN;
	}
	public String getClose_ptnr_dept_nm() {
		return close_ptnr_dept_nm;
	}
	public void setClose_ptnr_dept_nm(String close_ptnr_dept_nm) {
		this.close_ptnr_dept_nm = close_ptnr_dept_nm;
	}
	public String getClose_ptnr_tm2_nm() {
		return close_ptnr_tm2_nm;
	}
	public void setClose_ptnr_tm2_nm(String close_ptnr_tm2_nm) {
		this.close_ptnr_tm2_nm = close_ptnr_tm2_nm;
	}
	public String getRegistrant() {
		return registrant;
	}
	public void setRegistrant(String registrant) {
		this.registrant = registrant;
	}
	public String getRegistrant_nm() {
		return registrant_nm;
	}
	public void setRegistrant_nm(String registrant_nm) {
		this.registrant_nm = registrant_nm;
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
	public String getSuim_rpt_type1_nm() {
		return suim_rpt_type1_nm;
	}
	public void setSuim_rpt_type1_nm(String suim_rpt_type1_nm) {
		this.suim_rpt_type1_nm = suim_rpt_type1_nm;
	}
	public String getSuim_rpt_state() {
		return suim_rpt_state;
	}
	public void setSuim_rpt_state(String suim_rpt_state) {
		this.suim_rpt_state = suim_rpt_state;
	}
	public String getSuim_rpt_state_nm() {
		return suim_rpt_state_nm;
	}
	public void setSuim_rpt_state_nm(String suim_rpt_state_nm) {
		this.suim_rpt_state_nm = suim_rpt_state_nm;
	}
	public String getSuim_rpt_type1_close12() {
		return suim_rpt_type1_close12;
	}
	public void setSuim_rpt_type1_close12(String suim_rpt_type1_close12) {
		this.suim_rpt_type1_close12 = suim_rpt_type1_close12;
	}
	public String getSuim_rpt_type1_close12_nm() {
		return suim_rpt_type1_close12_nm;
	}
	public void setSuim_rpt_type1_close12_nm(String suim_rpt_type1_close12_nm) {
		this.suim_rpt_type1_close12_nm = suim_rpt_type1_close12_nm;
	}
	public String getTeam_id() {
		return team_id;
	}
	public void setTeam_id(String team_id) {
		this.team_id = team_id;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	public String getUser_no() {
		return user_no;
	}
	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getPtnr_id() {
		return ptnr_id;
	}
	public void setPtnr_id(String ptnr_id) {
		this.ptnr_id = ptnr_id;
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
	public String getPtnr_dept_id() {
		return ptnr_dept_id;
	}
	public void setPtnr_dept_id(String ptnr_dept_id) {
		this.ptnr_dept_id = ptnr_dept_id;
	}
	public String getPtnr_dept_name() {
		return ptnr_dept_name;
	}
	public void setPtnr_dept_name(String ptnr_dept_name) {
		this.ptnr_dept_name = ptnr_dept_name;
	}
	public String getPtnr_mbr_no() {
		return ptnr_mbr_no;
	}
	public void setPtnr_mbr_no(String ptnr_mbr_no) {
		this.ptnr_mbr_no = ptnr_mbr_no;
	}
	public String getPtnr_mbr_name() {
		return ptnr_mbr_name;
	}
	public void setPtnr_mbr_name(String ptnr_mbr_name) {
		this.ptnr_mbr_name = ptnr_mbr_name;
	}
	public String getPtnr_dept_nm_4edit() {
		return ptnr_dept_nm_4edit;
	}
	public void setPtnr_dept_nm_4edit(String ptnr_dept_nm_4edit) {
		this.ptnr_dept_nm_4edit = ptnr_dept_nm_4edit;
	}
	public String getPtnbr_mbr_nm_4edit() {
		return ptnbr_mbr_nm_4edit;
	}
	public void setPtnbr_mbr_nm_4edit(String ptnbr_mbr_nm_4edit) {
		this.ptnbr_mbr_nm_4edit = ptnbr_mbr_nm_4edit;
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
	public String getSuim_rpt_ea() {
		return suim_rpt_ea;
	}
	public void setSuim_rpt_ea(String suim_rpt_ea) {
		this.suim_rpt_ea = suim_rpt_ea;
	}
	public String getAccident_date() {
		return accident_date;
	}
	public void setAccident_date(String accident_date) {
		this.accident_date = accident_date;
	}
	public String getAccident_date_fmt() {
		return accident_date_fmt;
	}
	public void setAccident_date_fmt(String accident_date_fmt) {
		this.accident_date_fmt = accident_date_fmt;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getReg_date_fmt() {
		return reg_date_fmt;
	}
	public void setReg_date_fmt(String reg_date_fmt) {
		this.reg_date_fmt = reg_date_fmt;
	}
	public String getSuim_cancel_date() {
		return suim_cancel_date;
	}
	public void setSuim_cancel_date(String suim_cancel_date) {
		this.suim_cancel_date = suim_cancel_date;
	}
	public String getLawsuit_date() {
		return lawsuit_date;
	}
	public void setLawsuit_date(String lawsuit_date) {
		this.lawsuit_date = lawsuit_date;
	}
	public String getSuim_rpt_aprv_date() {
		return suim_rpt_aprv_date;
	}
	public void setSuim_rpt_aprv_date(String suim_rpt_aprv_date) {
		this.suim_rpt_aprv_date = suim_rpt_aprv_date;
	}
	public String getClose_date() {
		return close_date;
	}
	public void setClose_date(String close_date) {
		this.close_date = close_date;
	}
	public String getClose_date_fmt() {
		return close_date_fmt;
	}
	public void setClose_date_fmt(String close_date_fmt) {
		this.close_date_fmt = close_date_fmt;
	}
	public String getDel_date() {
		return del_date;
	}
	public void setDel_date(String del_date) {
		this.del_date = del_date;
	}
	public String getLock_flag() {
		return lock_flag;
	}
	public void setLock_flag(String lock_flag) {
		this.lock_flag = lock_flag;
	}
	public String getMoral_flag() {
		return moral_flag;
	}
	public void setMoral_flag(String moral_flag) {
		this.moral_flag = moral_flag;
	}
	public String getMoral_flag_nm() {
		return moral_flag_nm;
	}
	public void setMoral_flag_nm(String moral_flag_nm) {
		this.moral_flag_nm = moral_flag_nm;
	}
	public String getMinwon_flag() {
		return minwon_flag;
	}
	public void setMinwon_flag(String minwon_flag) {
		this.minwon_flag = minwon_flag;
	}
	public String getMinwon_flag_nm() {
		return minwon_flag_nm;
	}
	public void setMinwon_flag_nm(String minwon_flag_nm) {
		this.minwon_flag_nm = minwon_flag_nm;
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
	public String getAmt_estimated_damage() {
		return amt_estimated_damage;
	}
	public void setAmt_estimated_damage(String amt_estimated_damage) {
		this.amt_estimated_damage = amt_estimated_damage;
	}
	public String getAmt_definite() {
		return amt_definite;
	}
	public void setAmt_definite(String amt_definite) {
		this.amt_definite = amt_definite;
	}
	public String getAmt_reduction() {
		return amt_reduction;
	}
	public void setAmt_reduction(String amt_reduction) {
		this.amt_reduction = amt_reduction;
	}
	public String getCommission_estimated() {
		return commission_estimated;
	}
	public void setCommission_estimated(String commission_estimated) {
		this.commission_estimated = commission_estimated;
	}
	public String getAmt_claimed() {
		return amt_claimed;
	}
	public void setAmt_claimed(String amt_claimed) {
		this.amt_claimed = amt_claimed;
	}
	public String getAmt_settlement() {
		return amt_settlement;
	}
	public void setAmt_settlement(String amt_settlement) {
		this.amt_settlement = amt_settlement;
	}
	public String getAmt_self_pay() {
		return amt_self_pay;
	}
	public void setAmt_self_pay(String amt_self_pay) {
		this.amt_self_pay = amt_self_pay;
	}
	public String getAmt_insu_payment() {
		return amt_insu_payment;
	}
	public void setAmt_insu_payment(String amt_insu_payment) {
		this.amt_insu_payment = amt_insu_payment;
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
	public String getRpt_invoice_no() {
		return rpt_invoice_no;
	}
	public void setRpt_invoice_no(String rpt_invoice_no) {
		this.rpt_invoice_no = rpt_invoice_no;
	}
	public String getAmt_basic() {
		return amt_basic;
	}
	public void setAmt_basic(String amt_basic) {
		this.amt_basic = amt_basic;
	}
	public String getAmt_basic_dtl() {
		return amt_basic_dtl;
	}
	public void setAmt_basic_dtl(String amt_basic_dtl) {
		this.amt_basic_dtl = amt_basic_dtl;
	}
	public String getAmt_daily() {
		return amt_daily;
	}
	public void setAmt_daily(String amt_daily) {
		this.amt_daily = amt_daily;
	}
	public String getAmt_daily_dtl() {
		return amt_daily_dtl;
	}
	public void setAmt_daily_dtl(String amt_daily_dtl) {
		this.amt_daily_dtl = amt_daily_dtl;
	}
	public String getAmt_counsel() {
		return amt_counsel;
	}
	public void setAmt_counsel(String amt_counsel) {
		this.amt_counsel = amt_counsel;
	}
	public String getAmt_counsel_dtl() {
		return amt_counsel_dtl;
	}
	public void setAmt_counsel_dtl(String amt_counsel_dtl) {
		this.amt_counsel_dtl = amt_counsel_dtl;
	}
	public String getAmt_traffic() {
		return amt_traffic;
	}
	public void setAmt_traffic(String amt_traffic) {
		this.amt_traffic = amt_traffic;
	}
	public String getAmt_traffic_dtl() {
		return amt_traffic_dtl;
	}
	public void setAmt_traffic_dtl(String amt_traffic_dtl) {
		this.amt_traffic_dtl = amt_traffic_dtl;
	}
	public String getAmt_etc() {
		return amt_etc;
	}
	public void setAmt_etc(String amt_etc) {
		this.amt_etc = amt_etc;
	}
	public String getAmt_etc_dtl() {
		return amt_etc_dtl;
	}
	public void setAmt_etc_dtl(String amt_etc_dtl) {
		this.amt_etc_dtl = amt_etc_dtl;
	}
	public String getAmt_total() {
		return amt_total;
	}
	public void setAmt_total(String amt_total) {
		this.amt_total = amt_total;
	}
	public String getRpt_invoice_memo() {
		return rpt_invoice_memo;
	}
	public void setRpt_invoice_memo(String rpt_invoice_memo) {
		this.rpt_invoice_memo = rpt_invoice_memo;
	}
	public String getTax_invoice_no() {
		return tax_invoice_no;
	}
	public void setTax_invoice_no(String tax_invoice_no) {
		this.tax_invoice_no = tax_invoice_no;
	}
	public String getInvoice_date() {
		return invoice_date;
	}
	public void setInvoice_date(String invoice_date) {
		this.invoice_date = invoice_date;
	}
	public String getInvoice_date_fmt() {
		return invoice_date_fmt;
	}
	public void setInvoice_date_fmt(String invoice_date_fmt) {
		this.invoice_date_fmt = invoice_date_fmt;
	}
	public String getDeposit_date() {
		return deposit_date;
	}
	public void setDeposit_date(String deposit_date) {
		this.deposit_date = deposit_date;
	}
	public String getDeposit_date_fmt() {
		return deposit_date_fmt;
	}
	public void setDeposit_date_fmt(String deposit_date_fmt) {
		this.deposit_date_fmt = deposit_date_fmt;
	}
	public String getTax_date() {
		return tax_date;
	}
	public void setTax_date(String tax_date) {
		this.tax_date = tax_date;
	}
	public String getTax_date_fmt() {
		return tax_date_fmt;
	}
	public void setTax_date_fmt(String tax_date_fmt) {
		this.tax_date_fmt = tax_date_fmt;
	}
	public String getEdit_amt_cnt() {
		return edit_amt_cnt;
	}
	public void setEdit_amt_cnt(String edit_amt_cnt) {
		this.edit_amt_cnt = edit_amt_cnt;
	}
	public String getEdit_date_cnt() {
		return edit_date_cnt;
	}
	public void setEdit_date_cnt(String edit_date_cnt) {
		this.edit_date_cnt = edit_date_cnt;
	}
	public String getSerial_no() {
		return serial_no;
	}
	public void setSerial_no(String serial_no) {
		this.serial_no = serial_no;
	}
	public String getShare_user_no() {
		return share_user_no;
	}
	public void setShare_user_no(String share_user_no) {
		this.share_user_no = share_user_no;
	}
	public String getShare_user_name() {
		return share_user_name;
	}
	public void setShare_user_name(String share_user_name) {
		this.share_user_name = share_user_name;
	}
	public String getShare_amt_basic() {
		return share_amt_basic;
	}
	public void setShare_amt_basic(String share_amt_basic) {
		this.share_amt_basic = share_amt_basic;
	}
	public String getShare_amt_daily() {
		return share_amt_daily;
	}
	public void setShare_amt_daily(String share_amt_daily) {
		this.share_amt_daily = share_amt_daily;
	}
	public String getShare_amt_etc() {
		return share_amt_etc;
	}
	public void setShare_amt_etc(String share_amt_etc) {
		this.share_amt_etc = share_amt_etc;
	}
	public String getShare_amt_traffic() {
		return share_amt_traffic;
	}
	public void setShare_amt_traffic(String share_amt_traffic) {
		this.share_amt_traffic = share_amt_traffic;
	}
	public String getShare_amt_counsel() {
		return share_amt_counsel;
	}
	public void setShare_amt_counsel(String share_amt_counsel) {
		this.share_amt_counsel = share_amt_counsel;
	}
	public String getShare_amt_total() {
		return share_amt_total;
	}
	public void setShare_amt_total(String share_amt_total) {
		this.share_amt_total = share_amt_total;
	}
	public String getShare_ea() {
		return share_ea;
	}
	public void setShare_ea(String share_ea) {
		this.share_ea = share_ea;
	}
	public String getPrim_biz_inv_share_no() {
		return prim_biz_inv_share_no;
	}
	public void setPrim_biz_inv_share_no(String prim_biz_inv_share_no) {
		this.prim_biz_inv_share_no = prim_biz_inv_share_no;
	}
	public String getReg_user_no() {
		return reg_user_no;
	}
	public void setReg_user_no(String reg_user_no) {
		this.reg_user_no = reg_user_no;
	}
	public String getReg_type() {
		return reg_type;
	}
	public void setReg_type(String reg_type) {
		this.reg_type = reg_type;
	}
	public String getShare_rpt_no() {
		return share_rpt_no;
	}
	public void setShare_rpt_no(String share_rpt_no) {
		this.share_rpt_no = share_rpt_no;
	}
	public String getSum_share_basic() {
		return sum_share_basic;
	}
	public void setSum_share_basic(String sum_share_basic) {
		this.sum_share_basic = sum_share_basic;
	}
	public String getSum_share_daily() {
		return sum_share_daily;
	}
	public void setSum_share_daily(String sum_share_daily) {
		this.sum_share_daily = sum_share_daily;
	}
	public String getSum_share_etc() {
		return sum_share_etc;
	}
	public void setSum_share_etc(String sum_share_etc) {
		this.sum_share_etc = sum_share_etc;
	}
	public String getSum_share_traffic() {
		return sum_share_traffic;
	}
	public void setSum_share_traffic(String sum_share_traffic) {
		this.sum_share_traffic = sum_share_traffic;
	}
	public String getSum_share_counsel() {
		return sum_share_counsel;
	}
	public void setSum_share_counsel(String sum_share_counsel) {
		this.sum_share_counsel = sum_share_counsel;
	}
	public String getSum_share_total() {
		return sum_share_total;
	}
	public void setSum_share_total(String sum_share_total) {
		this.sum_share_total = sum_share_total;
	}
	public String getSum_share_ea() {
		return sum_share_ea;
	}
	public void setSum_share_ea(String sum_share_ea) {
		this.sum_share_ea = sum_share_ea;
	}
	public String getLog_ip() {
		return log_ip;
	}
	public void setLog_ip(String log_ip) {
		this.log_ip = log_ip;
	}
	public String getLog_user_no() {
		return log_user_no;
	}
	public void setLog_user_no(String log_user_no) {
		this.log_user_no = log_user_no;
	}
	public String getSuimRptNo() {
		return suimRptNo;
	}
	public void setSuimRptNo(String suimRptNo) {
		this.suimRptNo = suimRptNo;
	}
	public String getHandphone() {
		return handphone;
	}
	public void setHandphone(String handphone) {
		this.handphone = handphone;
	}
	public String getPtnr_mbr_nm() {
		return ptnr_mbr_nm;
	}
	public void setPtnr_mbr_nm(String ptnr_mbr_nm) {
		this.ptnr_mbr_nm = ptnr_mbr_nm;
	}
	public String getPtnr_mbr_hp() {
		return ptnr_mbr_hp;
	}
	public void setPtnr_mbr_hp(String ptnr_mbr_hp) {
		this.ptnr_mbr_hp = ptnr_mbr_hp;
	}
	public String getPresent_user_no() {
		return present_user_no;
	}
	public void setPresent_user_no(String present_user_no) {
		this.present_user_no = present_user_no;
	}
	public String getRead_yn() {
		return read_yn;
	}
	public void setRead_yn(String read_yn) {
		this.read_yn = read_yn;
	}
	public String getEdit_yn() {
		return edit_yn;
	}
	public void setEdit_yn(String edit_yn) {
		this.edit_yn = edit_yn;
	}
	public String getClose_pms_yn() {
		return close_pms_yn;
	}
	public void setClose_pms_yn(String close_pms_yn) {
		this.close_pms_yn = close_pms_yn;
	}
	public String getMbrChgAuthYN() {
		return mbrChgAuthYN;
	}
	public void setMbrChgAuthYN(String mbrChgAuthYN) {
		this.mbrChgAuthYN = mbrChgAuthYN;
	}
	public String getPtnrMbrChgAuthYN() {
		return ptnrMbrChgAuthYN;
	}
	public void setPtnrMbrChgAuthYN(String ptnrMbrChgAuthYN) {
		this.ptnrMbrChgAuthYN = ptnrMbrChgAuthYN;
	}
	public String getPtnr_tm2_nm() {
		return ptnr_tm2_nm;
	}
	public void setPtnr_tm2_nm(String ptnr_tm2_nm) {
		this.ptnr_tm2_nm = ptnr_tm2_nm;
	}
	public String getEditYN2() {
		return editYN2;
	}
	public void setEditYN2(String editYN2) {
		this.editYN2 = editYN2;
	}

	public String getShare_team_id() {
		return share_team_id;
	}

	public void setShare_team_id(String share_team_id) {
		this.share_team_id = share_team_id;
	}
	public String getEndModAuth() {
		return endModAuth;
	}
	public void setEndModAuth(String endModAuth) {
		this.endModAuth = endModAuth;
	}
	public String getWorkloadType() {
		return workloadType;
	}
	public void setWorkloadType(String workloadType) {
		this.workloadType = workloadType;
	}
	public String getWorkloadTypeVal() {
		return workloadTypeVal;
	}
	public void setWorkloadTypeVal(String workloadTypeVal) {
		this.workloadTypeVal = workloadTypeVal;
	}
	public String getWorkloadUseAt() {
		return workloadUseAt;
	}
	public void setWorkloadUseAt(String workloadUseAt) {
		this.workloadUseAt = workloadUseAt;
	}
	public String getWorkload_type() {
		return workload_type;
	}
	public void setWorkload_type(String workload_type) {
		this.workload_type = workload_type;
	}
	public String getWorkloadEa() {
		return workloadEa;
	}
	public void setWorkloadEa(String workloadEa) {
		this.workloadEa = workloadEa;
	}
	public String getWorkload_ea() {
		return workload_ea;
	}
	public void setWorkload_ea(String workload_ea) {
		this.workload_ea = workload_ea;
	}
	public String getShare_workload_ea() {
		return share_workload_ea;
	}
	public void setShare_workload_ea(String share_workload_ea) {
		this.share_workload_ea = share_workload_ea;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	
	
}
