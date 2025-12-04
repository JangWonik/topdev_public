package kr.co.toplac.searchmain;

public class SearchMainExcelVO {

	private String suim_rpt_no;
	private String suim_accept_no;
	private String suim_close_no;
	private String suim_rpt_state_nm;
    private String team_id;     /* 팀 아이디 */
	private String team_name;   /* 팀 이름 */
	private String pTeamName;   /* 상위 팀이름 */
	private String user_name;
	private String handphone;
	private String ptnr_name;
	private String ptnr_mbr_nm;
	private String ptnr_dept_nm;
	private String ptnr_tm2_nm;
	
	private String suim_rpt_type1;
	private String suim_rpt_type1_nm;
	private String speed_type;
	private String accident_no;
	private String policy_no;
	private String insurance_nm;
	private String policyholder_nm;
	private String beneficiary_nm;
	private String damaged_nm;
	private String accident_facts;
	private String investigate_addr1;
	private String investigate_addr2;
	private String rpt_now_txt;
	private String accident_date_fmt;
	private String reg_date_fmt;
	private String site_date_fmt;
	private String schedule_date_fmt;			//일정보고서 제출일자
	private String interim_date_fmt;
	private String past_date;
	private String close_date;
	private String close_date_fmt;
	private String amt_estimated_damage;
	private String commission_estimated;
	private String suim_rpt_type1_close12;
	private String suim_rpt_type1_close34;
	private String amt_claimed;
	private String amt_settlement;
	private String amt_self_pay;
	private String amt_insu_payment;
	private String amt_reduction;
	private String amt_basic;
	private String amt_daily;
	private String amt_traffic;
	private String amt_counsel;
	private String amt_etc;
	private String amt_total;
	private String memo_problem;
	private String memo_remedy;
	private String ptnr_tm_nm;
	private String now_memo;
	private String prb_memo;
	private String pln_memo;
	private String control_date_cnt;
	private String control_memo;
	private String ptnr_mbr_no;
	private String ptnr_dept_id;
	private String site_date;
	private String schedule_date;			//일정보고서 제출일
	private String interim_date;
	private String reg_date;
	private String past_date_ing;
	private String past_date_fmt;

	private String minwon_flag;
	private String minwon_date;
    private String moral_flag;
    private String moral_date;
    private String pre_estmt_at;
    private String pre_estmt_cmpy;
    private String ind_ajmdmge_ennc;
    private String doc_rcept_at;

	private String processManageMemo;

	private String closePrarnDate;
	
	private String onestopTeamId;	//원스탑 현장 조사 담당부서	(숫자)
	private String onestopTeamNm;	//원스탑 현장 조사 담당부서 (한글)
	private String onestopMbrNo;	//원스탑 현장 조사 담당자	(숫자)
	private String onestopMbrNm;	//원스탑 현장 조사 담당자	(한글)
	private String onestopMbrHandphone; //원스탑 현장 조사 담당자 전화번호
	
	private String workloadTypeVal;
	private String workloadEa;
	
	private String ptnrAssignGubun;
	private String ptnrDetailGubun;
	
	private String sagoTotalMsg = "";		//신규 사고처리과정표 내역
	
	private String registrant;				//수임등록자
	private String registrant_nm;		//수임등록자 이름	
	
	private String deposit_date;				//입금일
	private String deposit_date_fmt;		//입금일 (년월일)
	
	private String close_ptnr_dept_nm;		//종결일 기준 보험사 부서정보
	private String close_ptnr_tm2_nm;			//종결일 기준 보험사 팀정보
	
	private String pendncy_trget_at;			//과정관리 (1:대상, 2:비대상, 3:과정관리, 4:현장관리)
	
	private String site_rpt_aprv_date;			//현장보고서 제출일(결재일)
	private String site_rpt_aprv_date_fmt;	//현장보고서 제출일(결재일) 년월일
	
	private String ptnr_id_sub_nm;				//보험사 세부구분명
	private String period_flag_nm;				//계약기간(장기,일반)
	
	private String amt_approval;					//현대해상 결재수수료 항목
	
	private String cancel_reason;				//위임취소 사유
	private String suim_cancel_date_fmt;		//위임취소 일자
	
	private String insu_condition;				//보험조건 추가
			
	public String getInvestigate_addr2() {
		return investigate_addr2;
	}
	public void setInvestigate_addr2(String investigate_addr2) {
		this.investigate_addr2 = investigate_addr2;
	}
	public String getInsu_condition() {
		return insu_condition;
	}
	public void setInsu_condition(String insu_condition) {
		this.insu_condition = insu_condition;
	}
	public String getSuim_cancel_date_fmt() {
		return suim_cancel_date_fmt;
	}
	public void setSuim_cancel_date_fmt(String suim_cancel_date_fmt) {
		this.suim_cancel_date_fmt = suim_cancel_date_fmt;
	}
	public String getCancel_reason() {
		return cancel_reason;
	}
	public void setCancel_reason(String cancel_reason) {
		this.cancel_reason = cancel_reason;
	}
	public String getAmt_approval() {
		return amt_approval;
	}
	public void setAmt_approval(String amt_approval) {
		this.amt_approval = amt_approval;
	}
	public String getPtnr_id_sub_nm() {
		return ptnr_id_sub_nm;
	}
	public void setPtnr_id_sub_nm(String ptnr_id_sub_nm) {
		this.ptnr_id_sub_nm = ptnr_id_sub_nm;
	}
	public String getPeriod_flag_nm() {
		return period_flag_nm;
	}
	public void setPeriod_flag_nm(String period_flag_nm) {
		this.period_flag_nm = period_flag_nm;
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
	public String getSchedule_date_fmt() {
		return schedule_date_fmt;
	}
	public void setSchedule_date_fmt(String schedule_date_fmt) {
		this.schedule_date_fmt = schedule_date_fmt;
	}
	public String getSchedule_date() {
		return schedule_date;
	}
	public void setSchedule_date(String schedule_date) {
		this.schedule_date = schedule_date;
	}
	public String getPendncy_trget_at() {
		return pendncy_trget_at;
	}
	public void setPendncy_trget_at(String pendncy_trget_at) {
		this.pendncy_trget_at = pendncy_trget_at;
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
	public String getSagoTotalMsg() {
		return sagoTotalMsg;
	}
	public void setSagoTotalMsg(String sagoTotalMsg) {
		this.sagoTotalMsg = sagoTotalMsg;
	}
	public String getPast_date_fmt() {
		return past_date_fmt;
	}
	public void setPast_date_fmt(String past_date_fmt) {
		this.past_date_fmt = past_date_fmt;
	}
	public String getClose_date() {
		return close_date;
	}
	public void setClose_date(String close_date) {
		this.close_date = close_date;
	}
	public String getPast_date_ing() {
		return past_date_ing;
	}
	public void setPast_date_ing(String past_date_ing) {
		this.past_date_ing = past_date_ing;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getSite_date() {
		return site_date;
	}
	public void setSite_date(String site_date) {
		this.site_date = site_date;
	}
	public String getInterim_date() {
		return interim_date;
	}
	public void setInterim_date(String interim_date) {
		this.interim_date = interim_date;
	}
	public String getPtnr_mbr_no() {
		return ptnr_mbr_no;
	}
	public void setPtnr_mbr_no(String ptnr_mbr_no) {
		this.ptnr_mbr_no = ptnr_mbr_no;
	}
	public String getPtnr_dept_id() {
		return ptnr_dept_id;
	}
	public void setPtnr_dept_id(String ptnr_dept_id) {
		this.ptnr_dept_id = ptnr_dept_id;
	}
	public String getPln_memo() {
		return pln_memo;
	}
	public void setPln_memo(String pln_memo) {
		this.pln_memo = pln_memo;
	}
	public String getNow_memo() {
		return now_memo;
	}
	public void setNow_memo(String now_memo) {
		this.now_memo = now_memo;
	}
	public String getPrb_memo() {
		return prb_memo;
	}
	public void setPrb_memo(String prb_memo) {
		this.prb_memo = prb_memo;
	}
	public String getControl_date_cnt() {
		return control_date_cnt;
	}
	public void setControl_date_cnt(String control_date_cnt) {
		this.control_date_cnt = control_date_cnt;
	}
	public String getControl_memo() {
		return control_memo;
	}
	public void setControl_memo(String control_memo) {
		this.control_memo = control_memo;
	}
	public String getPtnr_tm_nm() {
		return ptnr_tm_nm;
	}
	public void setPtnr_tm_nm(String ptnr_tm_nm) {
		this.ptnr_tm_nm = ptnr_tm_nm;
	}
	public String getMemo_problem() {
		return memo_problem;
	}
	public void setMemo_problem(String memo_problem) {
		this.memo_problem = memo_problem;
	}
	public String getMemo_remedy() {
		return memo_remedy;
	}
	public void setMemo_remedy(String memo_remedy) {
		this.memo_remedy = memo_remedy;
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
	public String getSuim_rpt_state_nm() {
		return suim_rpt_state_nm;
	}
	public void setSuim_rpt_state_nm(String suim_rpt_state_nm) {
		this.suim_rpt_state_nm = suim_rpt_state_nm;
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
	public String getHandphone() {
		return handphone;
	}
	public void setHandphone(String handphone) {
		this.handphone = handphone;
	}
	public String getPtnr_name() {
		return ptnr_name;
	}
	public void setPtnr_name(String ptnr_name) {
		this.ptnr_name = ptnr_name;
	}
	public String getPtnr_mbr_nm() {
		return ptnr_mbr_nm;
	}
	public void setPtnr_mbr_nm(String ptnr_mbr_nm) {
		this.ptnr_mbr_nm = ptnr_mbr_nm;
	}
	public String getPtnr_dept_nm() {
		return ptnr_dept_nm;
	}
	public void setPtnr_dept_nm(String ptnr_dept_nm) {
		this.ptnr_dept_nm = ptnr_dept_nm;
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
	public String getSpeed_type() {
		return speed_type;
	}
	public void setSpeed_type(String speed_type) {
		this.speed_type = speed_type;
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
	public String getAccident_facts() {
		return accident_facts;
	}
	public void setAccident_facts(String accident_facts) {
		this.accident_facts = accident_facts;
	}
	public String getInvestigate_addr1() {
		return investigate_addr1;
	}
	public void setInvestigate_addr1(String investigate_addr1) {
		this.investigate_addr1 = investigate_addr1;
	}
	public String getRpt_now_txt() {
		return rpt_now_txt;
	}
	public void setRpt_now_txt(String rpt_now_txt) {
		this.rpt_now_txt = rpt_now_txt;
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
	public String getPast_date() {
		return past_date;
	}
	public void setPast_date(String past_date) {
		this.past_date = past_date;
	}
	public String getClose_date_fmt() {
		return close_date_fmt;
	}
	public void setClose_date_fmt(String close_date_fmt) {
		this.close_date_fmt = close_date_fmt;
	}
	public String getAmt_estimated_damage() {
		return amt_estimated_damage;
	}
	public void setAmt_estimated_damage(String amt_estimated_damage) {
		this.amt_estimated_damage = amt_estimated_damage;
	}
	public String getCommission_estimated() {
		return commission_estimated;
	}
	public void setCommission_estimated(String commission_estimated) {
		this.commission_estimated = commission_estimated;
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
	public String getAmt_reduction() {
		return amt_reduction;
	}
	public void setAmt_reduction(String amt_reduction) {
		this.amt_reduction = amt_reduction;
	}
	public String getAmt_basic() {
		return amt_basic;
	}
	public void setAmt_basic(String amt_basic) {
		this.amt_basic = amt_basic;
	}
	public String getAmt_daily() {
		return amt_daily;
	}
	public void setAmt_daily(String amt_daily) {
		this.amt_daily = amt_daily;
	}
	public String getAmt_traffic() {
		return amt_traffic;
	}
	public void setAmt_traffic(String amt_traffic) {
		this.amt_traffic = amt_traffic;
	}
	public String getAmt_counsel() {
		return amt_counsel;
	}
	public void setAmt_counsel(String amt_counsel) {
		this.amt_counsel = amt_counsel;
	}
	public String getAmt_etc() {
		return amt_etc;
	}
	public void setAmt_etc(String amt_etc) {
		this.amt_etc = amt_etc;
	}
	public String getAmt_total() {
		return amt_total;
	}
	public void setAmt_total(String amt_total) {
		this.amt_total = amt_total;
	}
	public String getPtnr_tm2_nm() {
		return ptnr_tm2_nm;
	}
	public void setPtnr_tm2_nm(String ptnr_tm2_nm) {
		this.ptnr_tm2_nm = ptnr_tm2_nm;
	}

    public String getMinwon_flag() {
        return minwon_flag;
    }

    public void setMinwon_flag(String minwon_flag) {
        this.minwon_flag = minwon_flag;
    }

    public String getMoral_flag() {
        return moral_flag;
    }

    public void setMoral_flag(String moral_flag) {
        this.moral_flag = moral_flag;
    }

    public String getPre_estmt_at() {
        return pre_estmt_at;
    }

    public void setPre_estmt_at(String pre_estmt_at) {
        this.pre_estmt_at = pre_estmt_at;
    }

    public String getPre_estmt_cmpy() {
        return pre_estmt_cmpy;
    }

    public void setPre_estmt_cmpy(String pre_estmt_cmpy) {
        this.pre_estmt_cmpy = pre_estmt_cmpy;
    }

    public String getInd_ajmdmge_ennc() {
        return ind_ajmdmge_ennc;
    }

    public void setInd_ajmdmge_ennc(String ind_ajmdmge_ennc) {
        this.ind_ajmdmge_ennc = ind_ajmdmge_ennc;
    }

    public String getDoc_rcept_at() {
        return doc_rcept_at;
    }

    public void setDoc_rcept_at(String doc_rcept_at) {
        this.doc_rcept_at = doc_rcept_at;
    }

    public String getpTeamName() {
        return pTeamName;
    }

    public void setpTeamName(String pTeamName) {
        this.pTeamName = pTeamName;
    }

    public String getTeam_id() {
        return team_id;
    }

    public void setTeam_id(String team_id) {
        this.team_id = team_id;
    }

	public String getProcessManageMemo() {
		return processManageMemo;
	}

	public void setProcessManageMemo(String processManageMemo) {
		this.processManageMemo = processManageMemo;
	}

    public String getClosePrarnDate() {
        return closePrarnDate;
    }

    public void setClosePrarnDate(String closePrarnDate) {
        this.closePrarnDate = closePrarnDate;
    }
    
	public String getOnestopTeamId() {
		return onestopTeamId;
	}
	public void setOnestopTeamId(String onestopTeamId) {
		this.onestopTeamId = onestopTeamId;
	}
	public String getOnestopTeamNm() {
		return onestopTeamNm;
	}
	public void setOnestopTeamNm(String onestopTeamNm) {
		this.onestopTeamNm = onestopTeamNm;
	}
	public String getOnestopMbrNo() {
		return onestopMbrNo;
	}
	public void setOnestopMbrNo(String onestopMbrNo) {
		this.onestopMbrNo = onestopMbrNo;
	}
	public String getOnestopMbrNm() {
		return onestopMbrNm;
	}
	public void setOnestopMbrNm(String onestopMbrNm) {
		this.onestopMbrNm = onestopMbrNm;
	}
	public String getOnestopMbrHandphone() {
		return onestopMbrHandphone;
	}
	public void setOnestopMbrHandphone(String onestopMbrHandphone) {
		this.onestopMbrHandphone = onestopMbrHandphone;
	}
	public String getWorkloadTypeVal() {
		return workloadTypeVal;
	}
	public void setWorkloadTypeVal(String workloadTypeVal) {
		this.workloadTypeVal = workloadTypeVal;
	}
	public String getWorkloadEa() {
		return workloadEa;
	}
	public void setWorkloadEa(String workloadEa) {
		this.workloadEa = workloadEa;
	}
	public String getPtnrAssignGubun() {
		return ptnrAssignGubun;
	}
	public void setPtnrAssignGubun(String ptnrAssignGubun) {
		this.ptnrAssignGubun = ptnrAssignGubun;
	}
	public String getPtnrDetailGubun() {
		return ptnrDetailGubun;
	}
	public void setPtnrDetailGubun(String ptnrDetailGubun) {
		this.ptnrDetailGubun = ptnrDetailGubun;
	}
	public String getMinwon_date() {
		return minwon_date;
	}
	public void setMinwon_date(String minwon_date) {
		this.minwon_date = minwon_date;
	}
	public String getMoral_date() {
		return moral_date;
	}
	public void setMoral_date(String moral_date) {
		this.moral_date = moral_date;
	}
    
    
    
    
}
