package kr.co.toplac.topmain;

public class MainLeftSuimVO {

	private String suimTotalCnt;
	private String suimState0Cnt;
	private String siteCnt;
	private String interimCnt;
	private String interimCnt2;
	private String suimState1Cnt;
	private String suimState11Cnt;
	private String aIACnt;
	private String aIACntState1AllTm;
	private String aIACntState11AllTm;
	private String aIACntAllTm;
	private String suimState2Cnt;
	private String suimState3Cnt;
	private String suimNoUserCnt;
	private String cHelpState0Cnt;
	private String cHelpState1Cnt;
	private String cHelpState2Cnt;
	private String cHelpState3Cnt;
	private String aHelpState0Cnt;
	private String aHelpState1Cnt;
	private String aHelpState2Cnt;
	private String aHelpState3Cnt;
	private String suit10TotalCnt;
	private String suit10State0Cnt;
	private String suit10State1Cnt;
	private String suit10State11Cnt;
	private String suit10State2Cnt;
	private String suit10State3Cnt;
	private String suit12TotalCnt;
	private String suit12State0Cnt;
	private String suit12State1Cnt;
	private String suit12State11Cnt;
	private String suit12State2Cnt;
	private String suit12State3Cnt;
	private String suit17TotalCnt;
	private String suit17State0Cnt;
	private String suit17State1Cnt;
	private String suit17State11Cnt;
	private String suit17State2Cnt;
	private String suit17State3Cnt;
	private String suit18TotalCnt;
	private String suit18State0Cnt;
	private String suit18State1Cnt;
	private String suit18State11Cnt;
	private String suit18State2Cnt;
	private String suit18State3Cnt;
	private String suit10State1CntAllTm;
	private String suit12State1CntAllTm;
	private String suit17State1CntAllTm;
	private String suit18State1CntAllTm;
	private String primTotalCnt;
	private String primState0Cnt;
	private String primState1Cnt;
	private String primState11Cnt;
	private String primState2Cnt;
	private String primState3Cnt;
	private String ptnr19State0CntAllTm;
	private String ptnr19State1CntAllTm;
	private String ptnr27State0CntAllTm;
	private String ptnr27State1CntAllTm;
	private String ptnr26State0CntAllTm;
	private String ptnr26State1CntAllTm;
	private String ptnr29State0CntAllTm;
	private String ptnr29State1CntAllTm;
	private String reqHelpDesk;
	private String reqEmpCert;
	private String dayoffStateCnt;
	private String dayoffStateMainCnt;
	private String dayoffFinalCnt;
	private String rptCancelReqCnt;	//위임취소 요청 건 170728
	private String dutyCostAppCnt;
	private String dutyCostDepCnt;
	private String rptAlarmCnt;			//보고서 알림 건
	private String rptMbrchgOutCnt;		//보고서 이첩 건
	private String rptMbrchgInCnt;		//보고서 내첩 건
	
	private String purposeWorkload;		//기준업무량 목표건수
	private String calcWorkload;		//기준업무량 종결건수
	private String rankWorkload;		//기준업무량 등수
	private String workloadCnt;			//기준업무량 백분위 계산을 위한 대상 CNT
	
	private String vacationTeamCnt;		//팀(센터)기준 휴가신청건수
	private String vacation1Cnt;		//1종 휴가신청건수
	private String vacation4Cnt;		//4종 휴가신청건수
	
	private String vacationApprovalCnt;		//신규 휴가신청건수 (1,4종 통합)
	private String vacationLastChkCnt;		//신규 최종확인 신청건수
	
	private String leaveApprovalCnt;			//휴직신청건수 (1,4종 통합)
	private String leaveLastChkCnt;			//휴직 최종확인 신청건수
	
	private String site3DayCnt;
	private String siteOverCnt;
	private String interim5DayCnt;
	private String interimOverCnt;
	
	private String lectureRoomCnt;
	
	private String quickApprovalCnt;		//빠른 결재건수
	
	private String approvalCnt;			//전산권한요청 결재대기건수
	
	private int subTeamApprovalCnt = 0;		//겸직부서 결재요청 건수 합계
	
	private int nLectureApproval = 0;			//교육신청 결재요청건
	
	private String sitePopAuth;				//현장보고서 권한
	
	private String siteApprovalCnt = "0";		//현장보고서 결재요청건수
	
	private String rptCancelApproval;			//위임취소 요청건(결재대상건)
		
	public String getRptCancelApproval() {
		return rptCancelApproval;
	}
	public void setRptCancelApproval(String rptCancelApproval) {
		this.rptCancelApproval = rptCancelApproval;
	}
	public String getSiteApprovalCnt() {
		return siteApprovalCnt;
	}
	public void setSiteApprovalCnt(String siteApprovalCnt) {
		this.siteApprovalCnt = siteApprovalCnt;
	}
	public String getSitePopAuth() {
		return sitePopAuth;
	}
	public void setSitePopAuth(String sitePopAuth) {
		this.sitePopAuth = sitePopAuth;
	}
	public int getnLectureApproval() {
		return nLectureApproval;
	}
	public void setnLectureApproval(int nLectureApproval) {
		this.nLectureApproval = nLectureApproval;
	}
	public String getLeaveApprovalCnt() {
		return leaveApprovalCnt;
	}
	public void setLeaveApprovalCnt(String leaveApprovalCnt) {
		this.leaveApprovalCnt = leaveApprovalCnt;
	}
	public String getLeaveLastChkCnt() {
		return leaveLastChkCnt;
	}
	public void setLeaveLastChkCnt(String leaveLastChkCnt) {
		this.leaveLastChkCnt = leaveLastChkCnt;
	}
	public int getSubTeamApprovalCnt() {
		return subTeamApprovalCnt;
	}
	public void setSubTeamApprovalCnt(int subTeamApprovalCnt) {
		this.subTeamApprovalCnt = subTeamApprovalCnt;
	}
	public String getApprovalCnt() {
		return approvalCnt;
	}
	public void setApprovalCnt(String approvalCnt) {
		this.approvalCnt = approvalCnt;
	}
	public String getVacationApprovalCnt() {
		return vacationApprovalCnt;
	}
	public void setVacationApprovalCnt(String vacationApprovalCnt) {
		this.vacationApprovalCnt = vacationApprovalCnt;
	}
	public String getVacationLastChkCnt() {
		return vacationLastChkCnt;
	}
	public void setVacationLastChkCnt(String vacationLastChkCnt) {
		this.vacationLastChkCnt = vacationLastChkCnt;
	}
	public String getQuickApprovalCnt() {
		return quickApprovalCnt;
	}
	public void setQuickApprovalCnt(String quickApprovalCnt) {
		this.quickApprovalCnt = quickApprovalCnt;
	}
	public String getDayoffStateMainCnt() {
		return dayoffStateMainCnt;
	}
	public void setDayoffStateMainCnt(String dayoffStateMainCnt) {
		this.dayoffStateMainCnt = dayoffStateMainCnt;
	}
	public String getDayoffStateCnt() {
		return dayoffStateCnt;
	}
	public void setDayoffStateCnt(String dayoffStateCnt) {
		this.dayoffStateCnt = dayoffStateCnt;
	}
	public String getDayoffFinalCnt() {
		return dayoffFinalCnt;
	}
	public void setDayoffFinalCnt(String dayoffFinalCnt) {
		this.dayoffFinalCnt = dayoffFinalCnt;
	}
	public String getSuimTotalCnt() {
		return suimTotalCnt;
	}
	public void setSuimTotalCnt(String suimTotalCnt) {
		this.suimTotalCnt = suimTotalCnt;
	}
	public String getSuimState0Cnt() {
		return suimState0Cnt;
	}
	public void setSuimState0Cnt(String suimState0Cnt) {
		this.suimState0Cnt = suimState0Cnt;
	}
	public String getSiteCnt() {
		return siteCnt;
	}
	public void setSiteCnt(String siteCnt) {
		this.siteCnt = siteCnt;
	}
	public String getInterimCnt() {
		return interimCnt;
	}
	public void setInterimCnt(String interimCnt) {
		this.interimCnt = interimCnt;
	}
	public String getInterimCnt2() {
		return interimCnt2;
	}
	public void setInterimCnt2(String interimCnt2) {
		this.interimCnt2 = interimCnt2;
	}
	public String getSuimState1Cnt() {
		return suimState1Cnt;
	}
	public void setSuimState1Cnt(String suimState1Cnt) {
		this.suimState1Cnt = suimState1Cnt;
	}
	public String getSuimState11Cnt() {
		return suimState11Cnt;
	}
	public void setSuimState11Cnt(String suimState11Cnt) {
		this.suimState11Cnt = suimState11Cnt;
	}
	public String getaIACnt() {
		return aIACnt;
	}
	public void setaIACnt(String aIACnt) {
		this.aIACnt = aIACnt;
	}
	public String getaIACntState1AllTm() {
		return aIACntState1AllTm;
	}
	public void setaIACntState1AllTm(String aIACntState1AllTm) {
		this.aIACntState1AllTm = aIACntState1AllTm;
	}
	public String getaIACntState11AllTm() {
		return aIACntState11AllTm;
	}
	public void setaIACntState11AllTm(String aIACntState11AllTm) {
		this.aIACntState11AllTm = aIACntState11AllTm;
	}
	public String getaIACntAllTm() {
		return aIACntAllTm;
	}
	public void setaIACntAllTm(String aIACntAllTm) {
		this.aIACntAllTm = aIACntAllTm;
	}
	public String getSuimState2Cnt() {
		return suimState2Cnt;
	}
	public void setSuimState2Cnt(String suimState2Cnt) {
		this.suimState2Cnt = suimState2Cnt;
	}
	public String getSuimState3Cnt() {
		return suimState3Cnt;
	}
	public void setSuimState3Cnt(String suimState3Cnt) {
		this.suimState3Cnt = suimState3Cnt;
	}
	public String getSuimNoUserCnt() {
		return suimNoUserCnt;
	}
	public void setSuimNoUserCnt(String suimNoUserCnt) {
		this.suimNoUserCnt = suimNoUserCnt;
	}
	public String getcHelpState0Cnt() {
		return cHelpState0Cnt;
	}
	public void setcHelpState0Cnt(String cHelpState0Cnt) {
		this.cHelpState0Cnt = cHelpState0Cnt;
	}
	public String getcHelpState1Cnt() {
		return cHelpState1Cnt;
	}
	public void setcHelpState1Cnt(String cHelpState1Cnt) {
		this.cHelpState1Cnt = cHelpState1Cnt;
	}
	public String getcHelpState2Cnt() {
		return cHelpState2Cnt;
	}
	public void setcHelpState2Cnt(String cHelpState2Cnt) {
		this.cHelpState2Cnt = cHelpState2Cnt;
	}
	public String getcHelpState3Cnt() {
		return cHelpState3Cnt;
	}
	public void setcHelpState3Cnt(String cHelpState3Cnt) {
		this.cHelpState3Cnt = cHelpState3Cnt;
	}
	public String getaHelpState0Cnt() {
		return aHelpState0Cnt;
	}
	public void setaHelpState0Cnt(String aHelpState0Cnt) {
		this.aHelpState0Cnt = aHelpState0Cnt;
	}
	public String getaHelpState1Cnt() {
		return aHelpState1Cnt;
	}
	public void setaHelpState1Cnt(String aHelpState1Cnt) {
		this.aHelpState1Cnt = aHelpState1Cnt;
	}
	public String getaHelpState2Cnt() {
		return aHelpState2Cnt;
	}
	public void setaHelpState2Cnt(String aHelpState2Cnt) {
		this.aHelpState2Cnt = aHelpState2Cnt;
	}
	public String getaHelpState3Cnt() {
		return aHelpState3Cnt;
	}
	public void setaHelpState3Cnt(String aHelpState3Cnt) {
		this.aHelpState3Cnt = aHelpState3Cnt;
	}
	public String getSuit10TotalCnt() {
		return suit10TotalCnt;
	}
	public void setSuit10TotalCnt(String suit10TotalCnt) {
		this.suit10TotalCnt = suit10TotalCnt;
	}
	public String getSuit10State0Cnt() {
		return suit10State0Cnt;
	}
	public void setSuit10State0Cnt(String suit10State0Cnt) {
		this.suit10State0Cnt = suit10State0Cnt;
	}
	public String getSuit10State1Cnt() {
		return suit10State1Cnt;
	}
	public void setSuit10State1Cnt(String suit10State1Cnt) {
		this.suit10State1Cnt = suit10State1Cnt;
	}
	public String getSuit10State11Cnt() {
		return suit10State11Cnt;
	}
	public void setSuit10State11Cnt(String suit10State11Cnt) {
		this.suit10State11Cnt = suit10State11Cnt;
	}
	public String getSuit10State2Cnt() {
		return suit10State2Cnt;
	}
	public void setSuit10State2Cnt(String suit10State2Cnt) {
		this.suit10State2Cnt = suit10State2Cnt;
	}
	public String getSuit10State3Cnt() {
		return suit10State3Cnt;
	}
	public void setSuit10State3Cnt(String suit10State3Cnt) {
		this.suit10State3Cnt = suit10State3Cnt;
	}
	public String getSuit12TotalCnt() {
		return suit12TotalCnt;
	}
	public void setSuit12TotalCnt(String suit12TotalCnt) {
		this.suit12TotalCnt = suit12TotalCnt;
	}
	public String getSuit12State0Cnt() {
		return suit12State0Cnt;
	}
	public void setSuit12State0Cnt(String suit12State0Cnt) {
		this.suit12State0Cnt = suit12State0Cnt;
	}
	public String getSuit12State1Cnt() {
		return suit12State1Cnt;
	}
	public void setSuit12State1Cnt(String suit12State1Cnt) {
		this.suit12State1Cnt = suit12State1Cnt;
	}
	public String getSuit12State11Cnt() {
		return suit12State11Cnt;
	}
	public void setSuit12State11Cnt(String suit12State11Cnt) {
		this.suit12State11Cnt = suit12State11Cnt;
	}
	public String getSuit12State2Cnt() {
		return suit12State2Cnt;
	}
	public void setSuit12State2Cnt(String suit12State2Cnt) {
		this.suit12State2Cnt = suit12State2Cnt;
	}
	public String getSuit12State3Cnt() {
		return suit12State3Cnt;
	}
	public void setSuit12State3Cnt(String suit12State3Cnt) {
		this.suit12State3Cnt = suit12State3Cnt;
	}
	public String getSuit17TotalCnt() {
		return suit17TotalCnt;
	}
	public void setSuit17TotalCnt(String suit17TotalCnt) {
		this.suit17TotalCnt = suit17TotalCnt;
	}
	public String getSuit17State0Cnt() {
		return suit17State0Cnt;
	}
	public void setSuit17State0Cnt(String suit17State0Cnt) {
		this.suit17State0Cnt = suit17State0Cnt;
	}
	public String getSuit17State1Cnt() {
		return suit17State1Cnt;
	}
	public void setSuit17State1Cnt(String suit17State1Cnt) {
		this.suit17State1Cnt = suit17State1Cnt;
	}
	public String getSuit17State11Cnt() {
		return suit17State11Cnt;
	}
	public void setSuit17State11Cnt(String suit17State11Cnt) {
		this.suit17State11Cnt = suit17State11Cnt;
	}
	public String getSuit17State2Cnt() {
		return suit17State2Cnt;
	}
	public void setSuit17State2Cnt(String suit17State2Cnt) {
		this.suit17State2Cnt = suit17State2Cnt;
	}
	public String getSuit17State3Cnt() {
		return suit17State3Cnt;
	}
	public void setSuit17State3Cnt(String suit17State3Cnt) {
		this.suit17State3Cnt = suit17State3Cnt;
	}
	public String getSuit18TotalCnt() {
		return suit18TotalCnt;
	}
	public void setSuit18TotalCnt(String suit18TotalCnt) {
		this.suit18TotalCnt = suit18TotalCnt;
	}
	public String getSuit18State0Cnt() {
		return suit18State0Cnt;
	}
	public void setSuit18State0Cnt(String suit18State0Cnt) {
		this.suit18State0Cnt = suit18State0Cnt;
	}
	public String getSuit18State1Cnt() {
		return suit18State1Cnt;
	}
	public void setSuit18State1Cnt(String suit18State1Cnt) {
		this.suit18State1Cnt = suit18State1Cnt;
	}
	public String getSuit18State11Cnt() {
		return suit18State11Cnt;
	}
	public void setSuit18State11Cnt(String suit18State11Cnt) {
		this.suit18State11Cnt = suit18State11Cnt;
	}
	public String getSuit18State2Cnt() {
		return suit18State2Cnt;
	}
	public void setSuit18State2Cnt(String suit18State2Cnt) {
		this.suit18State2Cnt = suit18State2Cnt;
	}
	public String getSuit18State3Cnt() {
		return suit18State3Cnt;
	}
	public void setSuit18State3Cnt(String suit18State3Cnt) {
		this.suit18State3Cnt = suit18State3Cnt;
	}
	public String getSuit10State1CntAllTm() {
		return suit10State1CntAllTm;
	}
	public void setSuit10State1CntAllTm(String suit10State1CntAllTm) {
		this.suit10State1CntAllTm = suit10State1CntAllTm;
	}
	public String getSuit12State1CntAllTm() {
		return suit12State1CntAllTm;
	}
	public void setSuit12State1CntAllTm(String suit12State1CntAllTm) {
		this.suit12State1CntAllTm = suit12State1CntAllTm;
	}
	public String getSuit17State1CntAllTm() {
		return suit17State1CntAllTm;
	}
	public void setSuit17State1CntAllTm(String suit17State1CntAllTm) {
		this.suit17State1CntAllTm = suit17State1CntAllTm;
	}
	public String getSuit18State1CntAllTm() {
		return suit18State1CntAllTm;
	}
	public void setSuit18State1CntAllTm(String suit18State1CntAllTm) {
		this.suit18State1CntAllTm = suit18State1CntAllTm;
	}
	public String getPrimTotalCnt() {
		return primTotalCnt;
	}
	public void setPrimTotalCnt(String primTotalCnt) {
		this.primTotalCnt = primTotalCnt;
	}
	public String getPrimState0Cnt() {
		return primState0Cnt;
	}
	public void setPrimState0Cnt(String primState0Cnt) {
		this.primState0Cnt = primState0Cnt;
	}
	public String getPrimState1Cnt() {
		return primState1Cnt;
	}
	public void setPrimState1Cnt(String primState1Cnt) {
		this.primState1Cnt = primState1Cnt;
	}
	public String getPrimState11Cnt() {
		return primState11Cnt;
	}
	public void setPrimState11Cnt(String primState11Cnt) {
		this.primState11Cnt = primState11Cnt;
	}
	public String getPrimState2Cnt() {
		return primState2Cnt;
	}
	public void setPrimState2Cnt(String primState2Cnt) {
		this.primState2Cnt = primState2Cnt;
	}
	public String getPrimState3Cnt() {
		return primState3Cnt;
	}
	public void setPrimState3Cnt(String primState3Cnt) {
		this.primState3Cnt = primState3Cnt;
	}
	public String getPtnr19State0CntAllTm() {
		return ptnr19State0CntAllTm;
	}
	public void setPtnr19State0CntAllTm(String ptnr19State0CntAllTm) {
		this.ptnr19State0CntAllTm = ptnr19State0CntAllTm;
	}
	public String getPtnr19State1CntAllTm() {
		return ptnr19State1CntAllTm;
	}
	public void setPtnr19State1CntAllTm(String ptnr19State1CntAllTm) {
		this.ptnr19State1CntAllTm = ptnr19State1CntAllTm;
	}
	public String getPtnr27State0CntAllTm() {
		return ptnr27State0CntAllTm;
	}
	public void setPtnr27State0CntAllTm(String ptnr27State0CntAllTm) {
		this.ptnr27State0CntAllTm = ptnr27State0CntAllTm;
	}
	public String getPtnr27State1CntAllTm() {
		return ptnr27State1CntAllTm;
	}
	public void setPtnr27State1CntAllTm(String ptnr27State1CntAllTm) {
		this.ptnr27State1CntAllTm = ptnr27State1CntAllTm;
	}
	public String getPtnr26State0CntAllTm() {
		return ptnr26State0CntAllTm;
	}
	public void setPtnr26State0CntAllTm(String ptnr26State0CntAllTm) {
		this.ptnr26State0CntAllTm = ptnr26State0CntAllTm;
	}
	public String getPtnr26State1CntAllTm() {
		return ptnr26State1CntAllTm;
	}
	public void setPtnr26State1CntAllTm(String ptnr26State1CntAllTm) {
		this.ptnr26State1CntAllTm = ptnr26State1CntAllTm;
	}
	public String getPtnr29State0CntAllTm() {
		return ptnr29State0CntAllTm;
	}
	public void setPtnr29State0CntAllTm(String ptnr29State0CntAllTm) {
		this.ptnr29State0CntAllTm = ptnr29State0CntAllTm;
	}
	public String getPtnr29State1CntAllTm() {
		return ptnr29State1CntAllTm;
	}
	public void setPtnr29State1CntAllTm(String ptnr29State1CntAllTm) {
		this.ptnr29State1CntAllTm = ptnr29State1CntAllTm;
	}
	public String getReqHelpDesk() {
		return reqHelpDesk;
	}
	public void setReqHelpDesk(String reqHelpDesk) {
		this.reqHelpDesk = reqHelpDesk;
	}
	public String getReqEmpCert() {
		return reqEmpCert;
	}
	public void setReqEmpCert(String reqEmpCert) {
		this.reqEmpCert = reqEmpCert;
	}
	public String getRptCancelReqCnt() {
		return rptCancelReqCnt;
	}
	public void setRptCancelReqCnt(String rptCancelReqCnt) {
		this.rptCancelReqCnt = rptCancelReqCnt;
	}
	public String getDutyCostAppCnt() {
		return dutyCostAppCnt;
	}
	public void setDutyCostAppCnt(String dutyCostAppCnt) {
		this.dutyCostAppCnt = dutyCostAppCnt;
	}
	public String getDutyCostDepCnt() {
		return dutyCostDepCnt;
	}
	public void setDutyCostDepCnt(String dutyCostDepCnt) {
		this.dutyCostDepCnt = dutyCostDepCnt;
	}
	public String getRptAlarmCnt() {
		return rptAlarmCnt;
	}
	public void setRptAlarmCnt(String rptAlarmCnt) {
		this.rptAlarmCnt = rptAlarmCnt;
	}
	public String getRptMbrchgOutCnt() {
		return rptMbrchgOutCnt;
	}
	public void setRptMbrchgOutCnt(String rptMbrchgOutCnt) {
		this.rptMbrchgOutCnt = rptMbrchgOutCnt;
	}
	public String getRptMbrchgInCnt() {
		return rptMbrchgInCnt;
	}
	public void setRptMbrchgInCnt(String rptMbrchgInCnt) {
		this.rptMbrchgInCnt = rptMbrchgInCnt;
	}
	public String getPurposeWorkload() {
		return purposeWorkload;
	}
	public void setPurposeWorkload(String purposeWorkload) {
		this.purposeWorkload = purposeWorkload;
	}
	public String getCalcWorkload() {
		return calcWorkload;
	}
	public void setCalcWorkload(String calcWorkload) {
		this.calcWorkload = calcWorkload;
	}
	public String getRankWorkload() {
		return rankWorkload;
	}
	public void setRankWorkload(String rankWorkload) {
		this.rankWorkload = rankWorkload;
	}
	public String getWorkloadCnt() {
		return workloadCnt;
	}
	public void setWorkloadCnt(String workloadCnt) {
		this.workloadCnt = workloadCnt;
	}
	public String getLectureRoomCnt() {
		return lectureRoomCnt;
	}
	public void setLectureRoomCnt(String lectureRoomCnt) {
		this.lectureRoomCnt = lectureRoomCnt;
	}
	public String getVacationTeamCnt() {
		return vacationTeamCnt;
	}
	public void setVacationTeamCnt(String vacationTeamCnt) {
		this.vacationTeamCnt = vacationTeamCnt;
	}
	public String getVacation1Cnt() {
		return vacation1Cnt;
	}
	public void setVacation1Cnt(String vacation1Cnt) {
		this.vacation1Cnt = vacation1Cnt;
	}
	public String getVacation4Cnt() {
		return vacation4Cnt;
	}
	public void setVacation4Cnt(String vacation4Cnt) {
		this.vacation4Cnt = vacation4Cnt;
	}
	
	
	public String getSite3DayCnt() {
		return site3DayCnt;
	}
	public void setSite3DayCnt(String site3DayCnt) {
		this.site3DayCnt = site3DayCnt;
	}
	public String getSiteOverCnt() {
		return siteOverCnt;
	}
	public void setSiteOverCnt(String siteOverCnt) {
		this.siteOverCnt = siteOverCnt;
	}
	public String getInterim5DayCnt() {
		return interim5DayCnt;
	}
	public void setInterim5DayCnt(String interim5DayCnt) {
		this.interim5DayCnt = interim5DayCnt;
	}
	public String getInterimOverCnt() {
		return interimOverCnt;
	}
	public void setInterimOverCnt(String interimOverCnt) {
		this.interimOverCnt = interimOverCnt;
	}
	
	

}
