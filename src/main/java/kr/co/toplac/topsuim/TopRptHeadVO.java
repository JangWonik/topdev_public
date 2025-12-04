package kr.co.toplac.topsuim;

/**
 * @author GOLDMAN
 *
 */
public class TopRptHeadVO {
	/*top_rpt_head*/
	private String suim_rpt_no;
	private String suim_accept_no;
	private String suim_close_no;
	private String suim_rpt_type1;
	private String suim_rpt_type2;
	private String suim_rpt_type3;
	private String speed_type;
	private String suim_rpt_state;
	private String suim_rpt_type1_close12;
	private String suim_rpt_type1_close34;
	private String team_id;
	private String user_no;
	private String ptnr_id;
	private String ptnr_dept_id;
	private String ptnr_mbr_no;
	private String ptnr_dept_nm_4edit;
	private String ptnr_mbr_nm_4edit;
	private String policyholder_nm;
	private String beneficiary_nm;
	private String damaged_nm;
	private String suim_rpt_ea;
	private String accident_date;
	private String reg_date;
	private String trans_date;
	private String suim_cancel_date;
	private String lawsuit_date;
	private String suim_rpt_aprv_date;
	private String close_date;
	private String del_date;
	private String lock_flag;
	/*top_rpt_head Add*/
	private String suim_rpt_type1_nm;
	private String suim_rpt_type2_nm;
	private String suim_rpt_state_nm;
	private String suim_rpt_type1_close12_nm;
	private String team_name;
	private String team_mark;
	private String user_name;
	private String ptnr_nick;
	private String ptnr_name;
	private String ptnr_dept_nm;
	private String ptnr_mbr_nm;
	private String accident_date_fmt;
	private String reg_date_fmt;
	private String trans_date_fmt;
	private String suim_cancel_date_fmt;
	private String close_date_fmt;
	private String ROWNUM;
	private String past_date;
	private String past_trans_date;
	private String rpt_invoice_no;
	private String memo_cnt;
	private String file_cnt;
	private String rpt_now_txt;
	private String site_date_fmt;
	private String interim_date_fmt;
	private String minwon_flag;
	private String minwon_flag_nm;
	private String policyholder_nm_tultip;
	private String beneficiary_nm_tultip;
	private String lock_value;
	private String suimRptReturn;
	private String ptnrMbrSanction;
	private String pastDays;
	private String delDate;
	private String now_reg_date_fmt;
	private String now_memo_length;	
	private String accident_no;						//사고번호
	private String suim_rpt_aprv_date_fmt;		//보고서 상신일
	private String deposit_date;					//입금일
	private String deposit_date_fmt;			//입금일 (년월일)
	private String site_rpt_aprv_date;			//현장보고서 결재일(제출일)
	private String site_rpt_aprv_date_fmt;	//현장보고서 결재일(제출일) 년월일
	private String close_ptnr_dept_nm;		//종결시점의 보험사 부서명
	private String close_ptnr_tm2_nm;			//종결시점의 보험사 팀명
		
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
	public String getSite_rpt_aprv_date() {
		return site_rpt_aprv_date;
	}
	public void setSite_rpt_aprv_date(String site_rpt_aprv_date) {
		this.site_rpt_aprv_date = site_rpt_aprv_date;
	}
	public String getSite_rpt_aprv_date_fmt() {
		return site_rpt_aprv_date_fmt;
	}
	public void setSite_rpt_aprv_date_fmt(String site_rpt_aprv_date_fmt) {
		this.site_rpt_aprv_date_fmt = site_rpt_aprv_date_fmt;
	}
	public String getPast_trans_date() {
		return past_trans_date;
	}
	public void setPast_trans_date(String past_trans_date) {
		this.past_trans_date = past_trans_date;
	}
	public String getTrans_date() {
		return trans_date;
	}
	public void setTrans_date(String trans_date) {
		this.trans_date = trans_date;
	}
	public String getTrans_date_fmt() {
		return trans_date_fmt;
	}
	public void setTrans_date_fmt(String trans_date_fmt) {
		this.trans_date_fmt = trans_date_fmt;
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
	public String getSuim_rpt_aprv_date_fmt() {
		return suim_rpt_aprv_date_fmt;
	}
	public void setSuim_rpt_aprv_date_fmt(String suim_rpt_aprv_date_fmt) {
		this.suim_rpt_aprv_date_fmt = suim_rpt_aprv_date_fmt;
	}
	public String getAccident_no() {
		return accident_no;
	}
	public void setAccident_no(String accident_no) {
		this.accident_no = accident_no;
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
	public String getSuim_rpt_type3() {
		return suim_rpt_type3;
	}
	public void setSuim_rpt_type3(String suim_rpt_type3) {
		this.suim_rpt_type3 = suim_rpt_type3;
	}
	public String getSpeed_type() {
		return speed_type;
	}
	public void setSpeed_type(String speed_type) {
		this.speed_type = speed_type;
	}
	public String getSuim_rpt_state() {
		return suim_rpt_state;
	}
	public void setSuim_rpt_state(String suim_rpt_state) {
		this.suim_rpt_state = suim_rpt_state;
	}
	public String getSuim_rpt_type1_close12() {
		return suim_rpt_type1_close12;
	}
	public void setSuim_rpt_type1_close12(String suim_rpt_type1_close12) {
		this.suim_rpt_type1_close12 = suim_rpt_type1_close12;
	}
	public String getSuim_rpt_type1_close34() {
		return suim_rpt_type1_close34;
	}
	public void setSuim_rpt_type1_close34(String suim_rpt_type1_close34) {
		this.suim_rpt_type1_close34 = suim_rpt_type1_close34;
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
	public String getPtnr_dept_nm_4edit() {
		return ptnr_dept_nm_4edit;
	}
	public void setPtnr_dept_nm_4edit(String ptnr_dept_nm_4edit) {
		this.ptnr_dept_nm_4edit = ptnr_dept_nm_4edit;
	}
	public String getPtnr_mbr_nm_4edit() {
		return ptnr_mbr_nm_4edit;
	}
	public void setPtnr_mbr_nm_4edit(String ptnr_mbr_nm_4edit) {
		this.ptnr_mbr_nm_4edit = ptnr_mbr_nm_4edit;
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
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
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
	public String getSuim_rpt_state_nm() {
		return suim_rpt_state_nm;
	}
	public void setSuim_rpt_state_nm(String suim_rpt_state_nm) {
		this.suim_rpt_state_nm = suim_rpt_state_nm;
	}
	public String getSuim_rpt_type1_close12_nm() {
		return suim_rpt_type1_close12_nm;
	}
	public void setSuim_rpt_type1_close12_nm(String suim_rpt_type1_close12_nm) {
		this.suim_rpt_type1_close12_nm = suim_rpt_type1_close12_nm;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	public String getTeam_mark() {
		return team_mark;
	}
	public void setTeam_mark(String team_mark) {
		this.team_mark = team_mark;
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
	public String getSuim_cancel_date_fmt() {
		return suim_cancel_date_fmt;
	}
	public void setSuim_cancel_date_fmt(String suim_cancel_date_fmt) {
		this.suim_cancel_date_fmt = suim_cancel_date_fmt;
	}
	public String getClose_date_fmt() {
		return close_date_fmt;
	}
	public void setClose_date_fmt(String close_date_fmt) {
		this.close_date_fmt = close_date_fmt;
	}
	public String getROWNUM() {
		return ROWNUM;
	}
	public void setROWNUM(String rOWNUM) {
		ROWNUM = rOWNUM;
	}
	public String getPast_date() {
		return past_date;
	}
	public void setPast_date(String past_date) {
		this.past_date = past_date;
	}
	public String getRpt_invoice_no() {
		return rpt_invoice_no;
	}
	public void setRpt_invoice_no(String rpt_invoice_no) {
		this.rpt_invoice_no = rpt_invoice_no;
	}
	public String getMemo_cnt() {
		return memo_cnt;
	}
	public void setMemo_cnt(String memo_cnt) {
		this.memo_cnt = memo_cnt;
	}
	public String getFile_cnt() {
		return file_cnt;
	}
	public void setFile_cnt(String file_cnt) {
		this.file_cnt = file_cnt;
	}
	public String getRpt_now_txt() {
		return rpt_now_txt;
	}
	public void setRpt_now_txt(String rpt_now_txt) {
		this.rpt_now_txt = rpt_now_txt;
	}
	public String getSite_date_fmt() {
		return site_date_fmt;
	}
	public void setSite_date_fmt(String site_date_fmt) {
		this.site_date_fmt = site_date_fmt;
	}
	public String getInterim_date_fmt() {
		return interim_date_fmt;
	}
	public void setInterim_date_fmt(String interim_date_fmt) {
		this.interim_date_fmt = interim_date_fmt;
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
	public String getPolicyholder_nm_tultip() {
		return policyholder_nm_tultip;
	}
	public void setPolicyholder_nm_tultip(String policyholder_nm_tultip) {
		this.policyholder_nm_tultip = policyholder_nm_tultip;
	}
	public String getBeneficiary_nm_tultip() {
		return beneficiary_nm_tultip;
	}
	public void setBeneficiary_nm_tultip(String beneficiary_nm_tultip) {
		this.beneficiary_nm_tultip = beneficiary_nm_tultip;
	}
	public String getLock_value() {
		return lock_value;
	}
	public void setLock_value(String lock_value) {
		this.lock_value = lock_value;
	}
	public String getSuimRptReturn() {
		return suimRptReturn;
	}
	public void setSuimRptReturn(String suimRptReturn) {
		this.suimRptReturn = suimRptReturn;
	}
	public String getPtnrMbrSanction() {
		return ptnrMbrSanction;
	}
	public void setPtnrMbrSanction(String ptnrMbrSanction) {
		this.ptnrMbrSanction = ptnrMbrSanction;
	}
	public String getPastDays() {
		return pastDays;
	}
	public void setPastDays(String pastDays) {
		this.pastDays = pastDays;
	}
	public String getDelDate() {
		return delDate;
	}
	public void setDelDate(String delDate) {
		this.delDate = delDate;
	}
	public String getNow_reg_date_fmt() {
		return now_reg_date_fmt;
	}
	public void setNow_reg_date_fmt(String now_reg_date_fmt) {
		this.now_reg_date_fmt = now_reg_date_fmt;
	}
	public String getNow_memo_length() {
		return now_memo_length;
	}
	public void setNow_memo_length(String now_memo_length) {
		this.now_memo_length = now_memo_length;
	}

}
