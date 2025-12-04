package kr.co.toplac.topsuim;

public class SuimRptCompositeVO {
	
	private String suim_rpt_no;
	private String accident_no;
	private String policy_no;
	private String insurance_nm;
	private String policyholder_ssn;
	private String policyholder_ssn2;
	private String policyholder_tel;
	private String beneficiary_ssn;
	private String beneficiary_ssn2;
	private String beneficiary_tel;
	private String damaged_tel;
	private String accident_facts;
	private String investigate_postcode;
	private String investigate_addr1;
	private String investigate_addr2;
	private String amt_estimated_damage;
	private String commission_estimated;
	private String ptnr_mbr_office_tel;
	
	private String suim_accept_no;
	private String suim_close_no;
	private String report_type;
	private String report_type2;
	private String team_id;
	private String user_no;
	private String ptnr_id;
	private String ptnr_dept_id;
	private String ptnr_mbr_no;
	private String ptnr_tm2_nm;//0117
	private String ptnrPositionNm;
	
	private String ptnr_id_sub;			//보험사 세부코드
	private String ptnr_id_sub_nm;		//보험사 세부코드 명
	
	private String period_flag;			//보험사별 계약기간 코드
	private String period_flag_nm;		//보험사별 계약기간 명
	
	private String policyholder_nm;
	private String beneficiary_nm;
	private String damaged_nm;
	private String accident_date;
	private String reg_date;
	private String trans_date;		//일반전환일 (20210402) by top3009
	
	private String user_name;
	private String team_name;
	private String ptnr_nick;
	private String ptnr_name;
	private String ptnr_dept_nm;
	private String ptnr_mbr_nm;
	private String email;			//담당자 이메일 항목 추가 by top3009
	
	private String suim_rpt_type1;
	private String suim_rpt_type1_nm;
	private String suim_rpt_type2;
	private String suim_rpt_type2_nm;
	
	private String moralFlag;
	private String moralFlagVal;	
	private String moralDate;
	private String moralDateVal;
	
	private String minwonFlag;
	private String minwonFlagVal;
	private String minwonDate;
	private String minwonDateVal;
	
	private String suimRptNo;

	private String amtClaimed;
	private String amtSettlement;
	private String amtReduction;
	private String amtInsuPayment;
	private String suimRptEa;
	private String suimRptType1Close12;
	private String suimRptType1Close34;
	private String amtSelfPay;              /* 자기부담금 */
    private String amtSelfPayUnit;          /* 자기부담금 단위 */
	private String amtEstimatedDamage;
	private String suimRptType1;
	
	private String suimRptState;
	private String suimRptReturn;
	private String closeDate;
	private String closeDateVal;
	private String ptnrMbrSanction;
	private String lockFlag;
	private String suimCancelDate;
	private String speedType;
	private String speedTypeNm;
	
	private String suimRptAprvDate;
	
	private String issueTaxInvoice;
	
	private String suimRptAprvUserNo;
	private String suimRptAprvUserName;
	
	private String ptnr_mbr_hp;
	private String handphone;
	
	private String ptnr_mbr_position_nm;			//직위추가
	
	private String memoProblem;
	private String memoRemedy;
	
	/*경과일 세팅*/
	private String pastDays;
	
	/*보고서 상태 value*/
	private String suimRptStateVal;

	private String delDate;

	private String ptnr_notice_yn;

	private String closeAuthYN;
	private String editYN;
	private String mbrChgYN;
	private String ptnrMbrChgYN;
	private String pendncyTrgetAt;

	private String preEstmtAt; 		        /* 선견적 여부 */
	private String preEstmtCmpy; 	        /* 선견적 업체명 */
	private String indAjmdmgeEnnc; 	        /* 독립 손사 유무 */
	private String docRceptAt; 		        /* 서류 접수 여부 */
	private String insuTerm;		        /* 보험기간 */
    private String amtCompensationLimit;    /* 보상한도액 */
    private String amtCompensationLimitUnit;    /* 보상한도액 단위 */
    
    private String cancelReason; //위임 취소 사유
    private String cancelGubun;  //위임취소 구분
    
    private String serial_no; 	  //위임 취소건 No
	private String depositDate; 	//입금일
	
	private String speedOnestop; 	//스피드 원스탑
	
	private String onestopTeamId;	//원스탑 현장 조사 담당부서	(숫자)
	private String onestopTeamNm;	//원스탑 현장 조사 담당부서 (한글)
	private String onestopMbrNo;	//원스탑 현장 조사 담당자	(숫자)
	private String onestopMbrNm;	//원스탑 현장 조사 담당자	(한글)
	private String onestopMbrHandphone; //원스탑 현장 조사 담당자 전화번호
	
	private String workloadType;	//기준업무량 상세 구분 코드
	private String workloadTypeVal;	//기준업무량 상세 구분 값
	private String workloadUseAt;	//기준업무량 사용 여부 -- 종결일 기준 2017.12.16 부터 Y, 이전은 N
	private String workloadEa;		//기준업무량 종결건수
	private String retirePendingFlag; //퇴사자 미결 내첩 여부 (기준업무량 종결 건수 조정용) 
	
	private String ptnrAssignGubun;	//4종 보험사 지정 구분
	private String ptnrDetailGubun; //4종 보험사 상세 구분
	
	private String insu_condition;
	
	private String selfPayFlag; 			//자기부담금 청구기준
	private String compensationLimitFlag;	//보상한도액 청구기준
	
	private String ptnr_url;				//보험사 prm 주소
	private String ptnr_homepage;				//보험사 홈페이지 주소
	
	private String damagedNm;			//피해자(피해물) 추가	
	
	private String reference_facts;		//특이사항 추가
	
	private String registrant;				//수임당당자
	
	private String registrant_nm;		//수임당당자 이름
	
	private String close_ptnr_dept_nm;	//종결시점 보험사 부서명
	private String close_ptnr_tm2_nm;		//종결시점 보험사 팀명	
	
	private String site_rpt_state;			//현장보고서 결재상태 (0:기본, 1:결재대기, 2:결재완료)	
	private String site_rpt_aprv_date;		//현장보고서 결재일자
	private String site_rpt_aprv_date_fmt;		//현장보고서 결재일자 (날짜형태)
	private String site_result_flag;				//현장보고서 타입상태 (0:기본, 1:일정보고서 결재완료, 2:정식보고서 결재완료)
	
	private String rptCancelApprovalAuthYN;		//위임취소 결재권한 (기존 종결권한에서 별도권한으로 처리) by top3009 (20240725)
	
	private String work_level_nm;					//처리담당자 직급 추가 (20250103)
		
	public String getWork_level_nm() {
		return work_level_nm;
	}
	public void setWork_level_nm(String work_level_nm) {
		this.work_level_nm = work_level_nm;
	}
	public String getRptCancelApprovalAuthYN() {
		return rptCancelApprovalAuthYN;
	}
	public void setRptCancelApprovalAuthYN(String rptCancelApprovalAuthYN) {
		this.rptCancelApprovalAuthYN = rptCancelApprovalAuthYN;
	}
	public String getPeriod_flag() {
		return period_flag;
	}
	public void setPeriod_flag(String period_flag) {
		this.period_flag = period_flag;
	}
	public String getPeriod_flag_nm() {
		return period_flag_nm;
	}
	public void setPeriod_flag_nm(String period_flag_nm) {
		this.period_flag_nm = period_flag_nm;
	}
	public String getPtnr_id_sub() {
		return ptnr_id_sub;
	}
	public void setPtnr_id_sub(String ptnr_id_sub) {
		this.ptnr_id_sub = ptnr_id_sub;
	}
	public String getPtnr_id_sub_nm() {
		return ptnr_id_sub_nm;
	}
	public void setPtnr_id_sub_nm(String ptnr_id_sub_nm) {
		this.ptnr_id_sub_nm = ptnr_id_sub_nm;
	}
	public String getPtnr_mbr_position_nm() {
		return ptnr_mbr_position_nm;
	}
	public void setPtnr_mbr_position_nm(String ptnr_mbr_position_nm) {
		this.ptnr_mbr_position_nm = ptnr_mbr_position_nm;
	}
	public String getCloseDateVal() {
		return closeDateVal;
	}
	public void setCloseDateVal(String closeDateVal) {
		this.closeDateVal = closeDateVal;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSite_result_flag() {
		return site_result_flag;
	}
	public void setSite_result_flag(String site_result_flag) {
		this.site_result_flag = site_result_flag;
	}
	public String getTrans_date() {
		return trans_date;
	}
	public void setTrans_date(String trans_date) {
		this.trans_date = trans_date;
	}
	public String getSite_rpt_state() {
		return site_rpt_state;
	}
	public void setSite_rpt_state(String site_rpt_state) {
		this.site_rpt_state = site_rpt_state;
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
	public String getReference_facts() {
		return reference_facts;
	}
	public void setReference_facts(String reference_facts) {
		this.reference_facts = reference_facts;
	}
	public String getDamagedNm() {
		return damagedNm;
	}
	public void setDamagedNm(String damagedNm) {
		this.damagedNm = damagedNm;
	}
	public String getPtnr_homepage() {
		return ptnr_homepage;
	}
	public void setPtnr_homepage(String ptnr_homepage) {
		this.ptnr_homepage = ptnr_homepage;
	}
	public String getPtnr_url() {
		return ptnr_url;
	}
	public void setPtnr_url(String ptnr_url) {
		this.ptnr_url = ptnr_url;
	}
	public String getPendncyTrgetAt() {
		return pendncyTrgetAt;
	}
	public void setPendncyTrgetAt(String pendncyTrgetAt) {
		this.pendncyTrgetAt = pendncyTrgetAt;
	}
	public String getPtnr_mbr_office_tel() {
		return ptnr_mbr_office_tel;
	}
	public void setPtnr_mbr_office_tel(String ptnr_mbr_office_tel) {
		this.ptnr_mbr_office_tel = ptnr_mbr_office_tel;
	}
	public String getSuim_rpt_no() {
		return suim_rpt_no;
	}
	public void setSuim_rpt_no(String suim_rpt_no) {
		this.suim_rpt_no = suim_rpt_no;
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
	public String getReport_type() {
		return report_type;
	}
	public void setReport_type(String report_type) {
		this.report_type = report_type;
	}
	public String getReport_type2() {
		return report_type2;
	}
	public void setReport_type2(String report_type2) {
		this.report_type2 = report_type2;
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
	public String getAmt_estimated_damage() {
		return amt_estimated_damage;
	}
	public void setAmt_estimated_damage(String amt_estimated_damage) {
		this.amt_estimated_damage = amt_estimated_damage;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
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
	public String getMoralFlag() {
		return moralFlag;
	}
	public void setMoralFlag(String moralFlag) {
		this.moralFlag = moralFlag;
	}
	public String getMinwonFlag() {
		return minwonFlag;
	}
	public void setMinwonFlag(String minwonFlag) {
		this.minwonFlag = minwonFlag;
	}
	public String getSuimRptNo() {
		return suimRptNo;
	}
	public void setSuimRptNo(String suimRptNo) {
		this.suimRptNo = suimRptNo;
	}
	public String getAmtClaimed() {
		return amtClaimed;
	}
	public void setAmtClaimed(String amtClaimed) {
		this.amtClaimed = amtClaimed;
	}
	public String getAmtSettlement() {
		return amtSettlement;
	}
	public void setAmtSettlement(String amtSettlement) {
		this.amtSettlement = amtSettlement;
	}
	public String getAmtReduction() {
		return amtReduction;
	}
	public void setAmtReduction(String amtReduction) {
		this.amtReduction = amtReduction;
	}
	public String getAmtInsuPayment() {
		return amtInsuPayment;
	}
	public void setAmtInsuPayment(String amtInsuPayment) {
		this.amtInsuPayment = amtInsuPayment;
	}
	public String getSuimRptEa() {
		return suimRptEa;
	}
	public void setSuimRptEa(String suimRptEa) {
		this.suimRptEa = suimRptEa;
	}
	public String getSuimRptType1Close12() {
		return suimRptType1Close12;
	}
	public void setSuimRptType1Close12(String suimRptType1Close12) {
		this.suimRptType1Close12 = suimRptType1Close12;
	}
	public String getSuimRptType1Close34() {
		return suimRptType1Close34;
	}
	public void setSuimRptType1Close34(String suimRptType1Close34) {
		this.suimRptType1Close34 = suimRptType1Close34;
	}
	public String getAmtSelfPay() {
		return amtSelfPay;
	}
	public void setAmtSelfPay(String amtSelfPay) {
		this.amtSelfPay = amtSelfPay;
	}
	public String getAmtEstimatedDamage() {
		return amtEstimatedDamage;
	}
	public void setAmtEstimatedDamage(String amtEstimatedDamage) {
		this.amtEstimatedDamage = amtEstimatedDamage;
	}
	public String getSuimRptType1() {
		return suimRptType1;
	}
	public void setSuimRptType1(String suimRptType1) {
		this.suimRptType1 = suimRptType1;
	}
	public String getSuimRptState() {
		return suimRptState;
	}
	public void setSuimRptState(String suimRptState) {
		this.suimRptState = suimRptState;
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
	public String getSuimRptReturn() {
		return suimRptReturn;
	}
	public void setSuimRptReturn(String suimRptReturn) {
		this.suimRptReturn = suimRptReturn;
	}
	public String getCloseDate() {
		return closeDate;
	}
	public void setCloseDate(String closeDate) {
		this.closeDate = closeDate;
	}
	public String getPtnrMbrSanction() {
		return ptnrMbrSanction;
	}
	public void setPtnrMbrSanction(String ptnrMbrSanction) {
		this.ptnrMbrSanction = ptnrMbrSanction;
	}
	public String getLockFlag() {
		return lockFlag;
	}
	public void setLockFlag(String lockFlag) {
		this.lockFlag = lockFlag;
	}
	public String getSuimCancelDate() {
		return suimCancelDate;
	}
	public void setSuimCancelDate(String suimCancelDate) {
		this.suimCancelDate = suimCancelDate;
	}
	public String getIssueTaxInvoice() {
		return issueTaxInvoice;
	}
	public void setIssueTaxInvoice(String issueTaxInvoice) {
		this.issueTaxInvoice = issueTaxInvoice;
	}
	public String getSpeedType() {
		return speedType;
	}
	public void setSpeedType(String speedType) {
		this.speedType = speedType;
	}
	public String getSuimRptAprvDate() {
		return suimRptAprvDate;
	}
	public void setSuimRptAprvDate(String suimRptAprvDate) {
		this.suimRptAprvDate = suimRptAprvDate;
	}
	public String getSuimRptAprvUserNo() {
		return suimRptAprvUserNo;
	}
	public void setSuimRptAprvUserNo(String suimRptAprvUserNo) {
		this.suimRptAprvUserNo = suimRptAprvUserNo;
	}
	public String getSuimRptAprvUserName() {
		return suimRptAprvUserName;
	}
	public void setSuimRptAprvUserName(String suimRptAprvUserName) {
		this.suimRptAprvUserName = suimRptAprvUserName;
	}
	public String getPastDays() {
		return pastDays;
	}
	public void setPastDays(String pastDays) {
		this.pastDays = pastDays;
	}
	public String getSuimRptStateVal() {
		return suimRptStateVal;
	}
	public void setSuimRptStateVal(String suimRptStateVal) {
		this.suimRptStateVal = suimRptStateVal;
	}
	public String getMinwonFlagVal() {
		return minwonFlagVal;
	}
	public void setMinwonFlagVal(String minwonFlagVal) {
		this.minwonFlagVal = minwonFlagVal;
	}
	public String getPtnr_mbr_hp() {
		return ptnr_mbr_hp;
	}
	public void setPtnr_mbr_hp(String ptnr_mbr_hp) {
		this.ptnr_mbr_hp = ptnr_mbr_hp;
	}
	public String getHandphone() {
		return handphone;
	}
	public void setHandphone(String handphone) {
		this.handphone = handphone;
	}
	public String getDelDate() {
		return delDate;
	}
	public void setDelDate(String delDate) {
		this.delDate = delDate;
	}
	public String getMemoProblem() {
		return memoProblem;
	}
	public void setMemoProblem(String memoProblem) {
		this.memoProblem = memoProblem;
	}
	public String getMemoRemedy() {
		return memoRemedy;
	}
	public void setMemoRemedy(String memoRemedy) {
		this.memoRemedy = memoRemedy;
	}
	public String getPtnr_notice_yn() {
		return ptnr_notice_yn;
	}
	public void setPtnr_notice_yn(String ptnr_notice_yn) {
		this.ptnr_notice_yn = ptnr_notice_yn;
	}
	public String getCloseAuthYN() {
		return closeAuthYN;
	}
	public void setCloseAuthYN(String closeAuthYN) {
		this.closeAuthYN = closeAuthYN;
	}
	public String getEditYN() {
		return editYN;
	}
	public void setEditYN(String editYN) {
		this.editYN = editYN;
	}
	public String getMbrChgYN() {
		return mbrChgYN;
	}
	public void setMbrChgYN(String mbrChgYN) {
		this.mbrChgYN = mbrChgYN;
	}
	public String getPtnrMbrChgYN() {
		return ptnrMbrChgYN;
	}
	public void setPtnrMbrChgYN(String ptnrMbrChgYN) {
		this.ptnrMbrChgYN = ptnrMbrChgYN;
	}
	public String getPtnr_tm2_nm() {
		return ptnr_tm2_nm;
	}
	public void setPtnr_tm2_nm(String ptnr_tm2_nm) {
		this.ptnr_tm2_nm = ptnr_tm2_nm;
	}
	public String getBeneficiary_ssn2() {
		return beneficiary_ssn2;
	}
	public void setBeneficiary_ssn2(String beneficiary_ssn2) {
		this.beneficiary_ssn2 = beneficiary_ssn2;
	}
	public String getPolicyholder_ssn2() {
		return policyholder_ssn2;
	}
	public void setPolicyholder_ssn2(String policyholder_ssn2) {
		this.policyholder_ssn2 = policyholder_ssn2;
	}

    public String getPreEstmtAt() {
        return preEstmtAt;
    }

    public void setPreEstmtAt(String preEstmtAt) {
        this.preEstmtAt = preEstmtAt;
    }

    public String getPreEstmtCmpy() {
        return preEstmtCmpy;
    }

    public void setPreEstmtCmpy(String preEstmtCmpy) {
        this.preEstmtCmpy = preEstmtCmpy;
    }

    public String getIndAjmdmgeEnnc() {
        return indAjmdmgeEnnc;
    }

    public void setIndAjmdmgeEnnc(String indAjmdmgeEnnc) {
        this.indAjmdmgeEnnc = indAjmdmgeEnnc;
    }

    public String getDocRceptAt() {
        return docRceptAt;
    }

    public void setDocRceptAt(String docRceptAt) {
        this.docRceptAt = docRceptAt;
    }

    public String getInsuTerm() {
        return insuTerm;
    }

    public void setInsuTerm(String insuTerm) {
        this.insuTerm = insuTerm;
    }

    public String getAmtCompensationLimit() {
        return amtCompensationLimit;
    }

    public void setAmtCompensationLimit(String amtCompensationLimit) {
        this.amtCompensationLimit = amtCompensationLimit;
    }

    public String getAmtSelfPayUnit() {
        return amtSelfPayUnit;
    }


    public void setAmtSelfPayUnit(String amtSelfPayUnit) {
        this.amtSelfPayUnit = amtSelfPayUnit;
    }

    public String getAmtCompensationLimitUnit() {
        return amtCompensationLimitUnit;
    }

    public void setAmtCompensationLimitUnit(String amtCompensationLimitUnit) {
        this.amtCompensationLimitUnit = amtCompensationLimitUnit;
    }
	public String getSerial_no() {
		return serial_no;
	}
	public void setSerial_no(String serial_no) {
		this.serial_no = serial_no;
	}

    public String getDepositDate() {
        return depositDate;
    }

    public void setDepositDate(String depositDate) {
        this.depositDate = depositDate;
    }
	public String getSpeedOnestop() {
		return speedOnestop;
	}
	public void setSpeedOnestop(String speedOnestop) {
		this.speedOnestop = speedOnestop;
	}
	public String getSpeedTypeNm() {
		return speedTypeNm;
	}
	public void setSpeedTypeNm(String speedTypeNm) {
		this.speedTypeNm = speedTypeNm;
	}
	public String getCancelReason() {
		return cancelReason;
	}
	public void setCancelReason(String cancelReason) {
		this.cancelReason = cancelReason;
	}
	public String getCancelGubun() {
		return cancelGubun;
	}
	public void setCancelGubun(String cancelGubun) {
		this.cancelGubun = cancelGubun;
	}
	public String getOnestopTeamId() {
		return onestopTeamId;
	}
	public void setOnestopTeamId(String onestopTeamId) {
		this.onestopTeamId = onestopTeamId;
	}
	public String getOnestopMbrNo() {
		return onestopMbrNo;
	}
	public void setOnestopMbrNo(String onestopMbrNo) {
		this.onestopMbrNo = onestopMbrNo;
	}
	public String getOnestopTeamNm() {
		return onestopTeamNm;
	}
	public void setOnestopTeamNm(String onestopTeamNm) {
		this.onestopTeamNm = onestopTeamNm;
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
	public String getMinwonDate() {
		return minwonDate;
	}
	public void setMinwonDate(String minwonDate) {
		this.minwonDate = minwonDate;
	}
	public String getMinwonDateVal() {
		return minwonDateVal;
	}
	public void setMinwonDateVal(String minwonDateVal) {
		this.minwonDateVal = minwonDateVal;
	}
	public String getWorkloadEa() {
		return workloadEa;
	}
	public void setWorkloadEa(String workloadEa) {
		this.workloadEa = workloadEa;
	}
	public String getPtnrPositionNm() {
		return ptnrPositionNm;
	}
	public void setPtnrPositionNm(String ptnrPositionNm) {
		this.ptnrPositionNm = ptnrPositionNm;
	}
	public String getRetirePendingFlag() {
		return retirePendingFlag;
	}
	public void setRetirePendingFlag(String retirePendingFlag) {
		this.retirePendingFlag = retirePendingFlag;
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
	public String getMoralFlagVal() {
		return moralFlagVal;
	}
	public void setMoralFlagVal(String moralFlagVal) {
		this.moralFlagVal = moralFlagVal;
	}
	public String getMoralDate() {
		return moralDate;
	}
	public void setMoralDate(String moralDate) {
		this.moralDate = moralDate;
	}
	public String getMoralDateVal() {
		return moralDateVal;
	}
	public void setMoralDateVal(String moralDateVal) {
		this.moralDateVal = moralDateVal;
	}
	public String getInsu_condition() {
		return insu_condition;
	}
	public void setInsu_condition(String insu_condition) {
		this.insu_condition = insu_condition;
	}
	public String getSelfPayFlag() {
		return selfPayFlag;
	}
	public void setSelfPayFlag(String selfPayFlag) {
		this.selfPayFlag = selfPayFlag;
	}
	public String getCompensationLimitFlag() {
		return compensationLimitFlag;
	}
	public void setCompensationLimitFlag(String compensationLimitFlag) {
		this.compensationLimitFlag = compensationLimitFlag;
	}
	
	
	
}
