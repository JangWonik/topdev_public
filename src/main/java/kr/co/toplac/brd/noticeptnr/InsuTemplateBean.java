package kr.co.toplac.brd.noticeptnr;

public class InsuTemplateBean {
	
	private String tkey = "";							//보험사 서식 키
	private String user_no = "";						//서식등록자 사번
	private String user_name = "";					//서식등록자 이름
	private String team_type = "";					//종구분 (1,4종)
	private String ptnr_id = "";						//보험사 아이디
	private String ptnr_name = "";					//보험사 명
	private String category_id = "";					//서식구분 아이디
	private String category_name = "";			//서식명
	private String file_path ="";						//서식 파일 경로
	private String template_enc_file = "";		//서버에 저장되는 파일 명(랜덤키:중복방지)
	private String template_org_file = "";		//원본 파일명
	private String nofile_content = "";				//파일안내문구(키값)
	private String nofile_content_val = "";		//파일안내문구(코드내용)
	private String reg_date = "";					//등록일
	private String reg_date_fmt = "";				//등록일 변환값 (년월일)
	
	public String getNofile_content_val() {
		return nofile_content_val;
	}
	public void setNofile_content_val(String nofile_content_val) {
		this.nofile_content_val = nofile_content_val;
	}
	public String getNofile_content() {
		return nofile_content;
	}
	public void setNofile_content(String nofile_content) {
		this.nofile_content = nofile_content;
	}
	public String getTkey() {
		return tkey;
	}
	public void setTkey(String tkey) {
		this.tkey = tkey;
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
	public String getTeam_type() {
		return team_type;
	}
	public void setTeam_type(String team_type) {
		this.team_type = team_type;
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
	public String getCategory_id() {
		return category_id;
	}
	public void setCategory_id(String category_id) {
		this.category_id = category_id;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public String getTemplate_enc_file() {
		return template_enc_file;
	}
	public void setTemplate_enc_file(String template_enc_file) {
		this.template_enc_file = template_enc_file;
	}
	public String getTemplate_org_file() {
		return template_org_file;
	}
	public void setTemplate_org_file(String template_org_file) {
		this.template_org_file = template_org_file;
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
}
