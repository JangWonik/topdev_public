package kr.co.toplac.brd.common;

public class BoardVO {

	private String board_no;
	private String user_no;
	private String user_nm;
	private String title_classify;
	private String title_classify_nm;
	private String title;
	private String title_text;
	private String contents;
	private String reg_ip;
	private String reg_date;
	private String reg_date_fmt;
	private String view_cnt;
	private int file_cnt;
	private int memo_cnt;
	//보험사공지
	private String ptnr_id;
	private String ptnr_name;
	//보험사자료실
	private String type_classify;
	private String type_classify_nm;
	private String year_classify;
	//보험사공지
	private String team_id;
	private String team_name;
	private String accept_date;
	private String accept_date_fmt;
	private String accept_user_no;
	private String accept_user_nm;
	private String accept_classify;
	private String accept_classify_nm;
	private String solve_date;
	private String solve_date_fmt;
	private String solve_user_no;
	private String solve_user_nm;
	private String solve_memo;
	private String solve_state;
	private String solve_state_nm;
	//top_main
	private String board_type;
	private String day_cnt;
	
	//전산권한 신청결재관련 변수
	private String auth_memo = "";			//결재요청내용
	private String auth_type = "";				//결재구분 (1: 1종, 4: 4종)
	private String drafter_no = "";				//기안자 사번
	private String drafter_nm = "";				//기안자 이름
	private String draft_date = "";				//기안일자
	private String draft_date_fmt = "";		//기안일자 (년월일포맷)
	private String approval_no = "";			//결재자 사번
	private String approval_nm = "";			//결재자 이름
	private String approval_comment = "";		//결재자 의견
	private String approval_date = "";			//결재일자
	private String approval_date_fmt = "";	//결재일자 (년월일포맷)
	
	//물보험 자료실
	private String category_id;			//탭메뉴
	private String category_id_nm;
	private String event_id;				//종목
	private String event_id_nm;	
	private String type_id;					//유형
	private String type_id_nm;
	private String board_file_no;			//첨부파일 키
	private String use_at;
	private String guide_no;
	private String best_flag;				//중요글 설정	
	
	//교육 qna 게시판
	private String pkey;						//교육과정 키
	private String pkey_nm;				//교육과정 명
	
	//공개 강의실 목록
	private String okey;
	private String team_type;
	private String ckey;
	private String category_name;
	private String subject;
	private String manager_name;
	private String reg_user_no;
	private String reg_user_name;
	private String introduce;
	private String link_path;
	private String file_path;
	private String file_org_name;
	private String file_enc_name;
	
	public String getOkey() {
		return okey;
	}
	public void setOkey(String okey) {
		this.okey = okey;
	}
	public String getTeam_type() {
		return team_type;
	}
	public void setTeam_type(String team_type) {
		this.team_type = team_type;
	}
	public String getCkey() {
		return ckey;
	}
	public void setCkey(String ckey) {
		this.ckey = ckey;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getManager_name() {
		return manager_name;
	}
	public void setManager_name(String manager_name) {
		this.manager_name = manager_name;
	}
	public String getReg_user_no() {
		return reg_user_no;
	}
	public void setReg_user_no(String reg_user_no) {
		this.reg_user_no = reg_user_no;
	}
	public String getReg_user_name() {
		return reg_user_name;
	}
	public void setReg_user_name(String reg_user_name) {
		this.reg_user_name = reg_user_name;
	}
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	public String getLink_path() {
		return link_path;
	}
	public void setLink_path(String link_path) {
		this.link_path = link_path;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public String getFile_org_name() {
		return file_org_name;
	}
	public void setFile_org_name(String file_org_name) {
		this.file_org_name = file_org_name;
	}
	public String getFile_enc_name() {
		return file_enc_name;
	}
	public void setFile_enc_name(String file_enc_name) {
		this.file_enc_name = file_enc_name;
	}
	public String getPkey() {
		return pkey;
	}
	public void setPkey(String pkey) {
		this.pkey = pkey;
	}
	public String getPkey_nm() {
		return pkey_nm;
	}
	public void setPkey_nm(String pkey_nm) {
		this.pkey_nm = pkey_nm;
	}
	public String getBest_flag() {
		return best_flag;
	}
	public void setBest_flag(String best_flag) {
		this.best_flag = best_flag;
	}
	public String getGuide_no() {
		return guide_no;
	}
	public void setGuide_no(String guide_no) {
		this.guide_no = guide_no;
	}
	public String getUse_at() {
		return use_at;
	}
	public void setUse_at(String use_at) {
		this.use_at = use_at;
	}
	public String getBoard_file_no() {
		return board_file_no;
	}
	public void setBoard_file_no(String board_file_no) {
		this.board_file_no = board_file_no;
	}
	public String getCategory_id_nm() {
		return category_id_nm;
	}
	public void setCategory_id_nm(String category_id_nm) {
		this.category_id_nm = category_id_nm;
	}
	public String getEvent_id_nm() {
		return event_id_nm;
	}
	public void setEvent_id_nm(String event_id_nm) {
		this.event_id_nm = event_id_nm;
	}
	public String getType_id_nm() {
		return type_id_nm;
	}
	public void setType_id_nm(String type_id_nm) {
		this.type_id_nm = type_id_nm;
	}
	public String getCategory_id() {
		return category_id;
	}
	public void setCategory_id(String category_id) {
		this.category_id = category_id;
	}
	public String getEvent_id() {
		return event_id;
	}
	public void setEvent_id(String event_id) {
		this.event_id = event_id;
	}
	public String getType_id() {
		return type_id;
	}
	public void setType_id(String type_id) {
		this.type_id = type_id;
	}
	public String getTitle_text() {
		return title_text;
	}
	public void setTitle_text(String title_text) {
		this.title_text = title_text;
	}
	public String getAuth_memo() {
		return auth_memo;
	}
	public void setAuth_memo(String auth_memo) {
		this.auth_memo = auth_memo;
	}
	public String getAuth_type() {
		return auth_type;
	}
	public void setAuth_type(String auth_type) {
		this.auth_type = auth_type;
	}
	public String getDrafter_no() {
		return drafter_no;
	}
	public void setDrafter_no(String drafter_no) {
		this.drafter_no = drafter_no;
	}
	public String getDrafter_nm() {
		return drafter_nm;
	}
	public void setDrafter_nm(String drafter_nm) {
		this.drafter_nm = drafter_nm;
	}
	public String getDraft_date() {
		return draft_date;
	}
	public void setDraft_date(String draft_date) {
		this.draft_date = draft_date;
	}
	public String getDraft_date_fmt() {
		return draft_date_fmt;
	}
	public void setDraft_date_fmt(String draft_date_fmt) {
		this.draft_date_fmt = draft_date_fmt;
	}
	public String getApproval_no() {
		return approval_no;
	}
	public void setApproval_no(String approval_no) {
		this.approval_no = approval_no;
	}
	public String getApproval_nm() {
		return approval_nm;
	}
	public void setApproval_nm(String approval_nm) {
		this.approval_nm = approval_nm;
	}
	public String getApproval_comment() {
		return approval_comment;
	}
	public void setApproval_comment(String approval_comment) {
		this.approval_comment = approval_comment;
	}
	public String getApproval_date() {
		return approval_date;
	}
	public void setApproval_date(String approval_date) {
		this.approval_date = approval_date;
	}
	public String getApproval_date_fmt() {
		return approval_date_fmt;
	}
	public void setApproval_date_fmt(String approval_date_fmt) {
		this.approval_date_fmt = approval_date_fmt;
	}
	public String getBoard_no() {
		return board_no;
	}
	public void setBoard_no(String board_no) {
		this.board_no = board_no;
	}
	public String getUser_no() {
		return user_no;
	}
	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	public String getTitle_classify() {
		return title_classify;
	}
	public void setTitle_classify(String title_classify) {
		this.title_classify = title_classify;
	}
	public String getTitle_classify_nm() {
		return title_classify_nm;
	}
	public void setTitle_classify_nm(String title_classify_nm) {
		this.title_classify_nm = title_classify_nm;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getReg_ip() {
		return reg_ip;
	}
	public void setReg_ip(String reg_ip) {
		this.reg_ip = reg_ip;
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
	public String getView_cnt() {
		return view_cnt;
	}
	public void setView_cnt(String view_cnt) {
		this.view_cnt = view_cnt;
	}
	public int getFile_cnt() {
		return file_cnt;
	}
	public void setFile_cnt(int file_cnt) {
		this.file_cnt = file_cnt;
	}
	public int getMemo_cnt() {
		return memo_cnt;
	}
	public void setMemo_cnt(int memo_cnt) {
		this.memo_cnt = memo_cnt;
	}
	public String getPtnr_id() {
		return ptnr_id;
	}
	public void setPtnr_id(String ptnr_id) {
		this.ptnr_id = ptnr_id;
	}
	public String getPtnr_name() {
		return ptnr_name;
	}
	public void setPtnr_name(String ptnr_name) {
		this.ptnr_name = ptnr_name;
	}
	public String getType_classify() {
		return type_classify;
	}
	public void setType_classify(String type_classify) {
		this.type_classify = type_classify;
	}
	public String getType_classify_nm() {
		return type_classify_nm;
	}
	public void setType_classify_nm(String type_classify_nm) {
		this.type_classify_nm = type_classify_nm;
	}
	public String getYear_classify() {
		return year_classify;
	}
	public void setYear_classify(String year_classify) {
		this.year_classify = year_classify;
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
	public String getAccept_date() {
		return accept_date;
	}
	public void setAccept_date(String accept_date) {
		this.accept_date = accept_date;
	}
	public String getAccept_date_fmt() {
		return accept_date_fmt;
	}
	public void setAccept_date_fmt(String accept_date_fmt) {
		this.accept_date_fmt = accept_date_fmt;
	}
	public String getAccept_user_no() {
		return accept_user_no;
	}
	public void setAccept_user_no(String accept_user_no) {
		this.accept_user_no = accept_user_no;
	}
	public String getAccept_user_nm() {
		return accept_user_nm;
	}
	public void setAccept_user_nm(String accept_user_nm) {
		this.accept_user_nm = accept_user_nm;
	}
	public String getAccept_classify() {
		return accept_classify;
	}
	public void setAccept_classify(String accept_classify) {
		this.accept_classify = accept_classify;
	}
	public String getAccept_classify_nm() {
		return accept_classify_nm;
	}
	public void setAccept_classify_nm(String accept_classify_nm) {
		this.accept_classify_nm = accept_classify_nm;
	}
	public String getSolve_date() {
		return solve_date;
	}
	public void setSolve_date(String solve_date) {
		this.solve_date = solve_date;
	}
	public String getSolve_date_fmt() {
		return solve_date_fmt;
	}
	public void setSolve_date_fmt(String solve_date_fmt) {
		this.solve_date_fmt = solve_date_fmt;
	}
	public String getSolve_user_no() {
		return solve_user_no;
	}
	public void setSolve_user_no(String solve_user_no) {
		this.solve_user_no = solve_user_no;
	}
	public String getSolve_user_nm() {
		return solve_user_nm;
	}
	public void setSolve_user_nm(String solve_user_nm) {
		this.solve_user_nm = solve_user_nm;
	}
	public String getSolve_memo() {
		return solve_memo;
	}
	public void setSolve_memo(String solve_memo) {
		this.solve_memo = solve_memo;
	}
	public String getSolve_state() {
		return solve_state;
	}
	public void setSolve_state(String solve_state) {
		this.solve_state = solve_state;
	}
	public String getSolve_state_nm() {
		return solve_state_nm;
	}
	public void setSolve_state_nm(String solve_state_nm) {
		this.solve_state_nm = solve_state_nm;
	}
	public String getBoard_type() {
		return board_type;
	}
	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}
	public String getDay_cnt() {
		return day_cnt;
	}
	public void setDay_cnt(String day_cnt) {
		this.day_cnt = day_cnt;
	}

}
