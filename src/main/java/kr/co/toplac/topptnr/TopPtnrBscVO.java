package kr.co.toplac.topptnr;

public class TopPtnrBscVO {
	
	private String ptnr_id;
	private String ptnr_type;
	private String ptnr_level;
	private String ptnr_group_order;
	private String ptnr_order;
	private String ptnr_nick;
	private String ptnr_name;
	private String ptnr_biz_reg_no;
	private String ptnr_biz_type1;
	private String ptnr_biz_type2;
	
	private String ptnr_addr;
	private String ptnr_addr1;
	private String ptnr_addr2;
	private String ptnr_postcode;
	private String ptnr_tel;
	private String ptnr_homepage;
	private String ptnr_url;	
	private String ptnr_img_small;
	private String ptnr_img_big;
	private String ptnr_big;
	private String ptnr_sms1;
	private String ptnr_sms2;
	private String ptnr_sms3;
	private String ptnr_sms1_msg;
	private String ptnr_sms2_msg;
	
	private String ptnr_sms3_msg;
	private String issue_tax_invoice;
	private String suitability_yn;
	private String ptnr_fee1;
	private String ptnr_fee2;
	private String top_accnt_id;
	private String ptnr_ceo_nm;
	private String statistics_yn;
	private String statistics_written_yn;			//보험사별 통계 내 심사표시여부
	private String reg_date;
	private String del_state;
	private String del_date;
	private String imgStream_s;
	private String imgStream_b;
	
	private String suitability_fee1;
	private String suitability_fee2;
	
	/*top_accnt field*/
	private String bank_title;

	//BoardNoticePtnr1Controller
	private String ptnr_group_order_cnt;
	private String ptnr_notice_cnt;
	private int template_cnt;
	
	private int notice_ptnr1_cnt;
	private int notice_ptnr4_cnt;
	
	private int statistics_order;
	
	public int getStatistics_order() {
		return statistics_order;
	}
	public void setStatistics_order(int statistics_order) {
		this.statistics_order = statistics_order;
	}
	public String getStatistics_written_yn() {
		return statistics_written_yn;
	}
	public void setStatistics_written_yn(String statistics_written_yn) {
		this.statistics_written_yn = statistics_written_yn;
	}
	public int getNotice_ptnr1_cnt() {
		return notice_ptnr1_cnt;
	}
	public void setNotice_ptnr1_cnt(int notice_ptnr1_cnt) {
		this.notice_ptnr1_cnt = notice_ptnr1_cnt;
	}
	public int getNotice_ptnr4_cnt() {
		return notice_ptnr4_cnt;
	}
	public void setNotice_ptnr4_cnt(int notice_ptnr4_cnt) {
		this.notice_ptnr4_cnt = notice_ptnr4_cnt;
	}
	public int getTemplate_cnt() {
		return template_cnt;
	}
	public void setTemplate_cnt(int template_cnt) {
		this.template_cnt = template_cnt;
	}
	public String getPtnr_homepage() {
		return ptnr_homepage;
	}
	public void setPtnr_homepage(String ptnr_homepage) {
		this.ptnr_homepage = ptnr_homepage;
	}
	public String getPtnr_id() {
		return ptnr_id;
	}
	public void setPtnr_id(String ptnr_id) {
		this.ptnr_id = ptnr_id;
	}
	public String getPtnr_type() {
		return ptnr_type;
	}
	public void setPtnr_type(String ptnr_type) {
		this.ptnr_type = ptnr_type;
	}
	public String getPtnr_level() {
		return ptnr_level;
	}
	public void setPtnr_level(String ptnr_level) {
		this.ptnr_level = ptnr_level;
	}
	public String getPtnr_group_order() {
		return ptnr_group_order;
	}
	public void setPtnr_group_order(String ptnr_group_order) {
		this.ptnr_group_order = ptnr_group_order;
	}
	public String getPtnr_order() {
		return ptnr_order;
	}
	public void setPtnr_order(String ptnr_order) {
		this.ptnr_order = ptnr_order;
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
	public String getPtnr_biz_reg_no() {
		return ptnr_biz_reg_no;
	}
	public void setPtnr_biz_reg_no(String ptnr_biz_reg_no) {
		this.ptnr_biz_reg_no = ptnr_biz_reg_no;
	}
	public String getPtnr_biz_type1() {
		return ptnr_biz_type1;
	}
	public void setPtnr_biz_type1(String ptnr_biz_type1) {
		this.ptnr_biz_type1 = ptnr_biz_type1;
	}
	public String getPtnr_biz_type2() {
		return ptnr_biz_type2;
	}
	public void setPtnr_biz_type2(String ptnr_biz_type2) {
		this.ptnr_biz_type2 = ptnr_biz_type2;
	}
	public String getPtnr_addr() {
		return ptnr_addr;
	}
	public void setPtnr_addr(String ptnr_addr) {
		this.ptnr_addr = ptnr_addr;
	}
	public String getPtnr_tel() {
		return ptnr_tel;
	}
	public void setPtnr_tel(String ptnr_tel) {
		this.ptnr_tel = ptnr_tel;
	}
	public String getPtnr_url() {
		return ptnr_url;
	}
	public void setPtnr_url(String ptnr_url) {
		this.ptnr_url = ptnr_url;
	}
	public String getPtnr_img_small() {
		return ptnr_img_small;
	}
	public void setPtnr_img_small(String ptnr_img_small) {
		this.ptnr_img_small = ptnr_img_small;
	}
	public String getPtnr_img_big() {
		return ptnr_img_big;
	}
	public void setPtnr_img_big(String ptnr_img_big) {
		this.ptnr_img_big = ptnr_img_big;
	}
	public String getPtnr_big() {
		return ptnr_big;
	}
	public void setPtnr_big(String ptnr_big) {
		this.ptnr_big = ptnr_big;
	}
	public String getPtnr_sms1() {
		return ptnr_sms1;
	}
	public void setPtnr_sms1(String ptnr_sms1) {
		this.ptnr_sms1 = ptnr_sms1;
	}
	public String getPtnr_sms2() {
		return ptnr_sms2;
	}
	public void setPtnr_sms2(String ptnr_sms2) {
		this.ptnr_sms2 = ptnr_sms2;
	}
	public String getPtnr_sms3() {
		return ptnr_sms3;
	}
	public void setPtnr_sms3(String ptnr_sms3) {
		this.ptnr_sms3 = ptnr_sms3;
	}
	public String getPtnr_sms1_msg() {
		return ptnr_sms1_msg;
	}
	public void setPtnr_sms1_msg(String ptnr_sms1_msg) {
		this.ptnr_sms1_msg = ptnr_sms1_msg;
	}
	public String getPtnr_sms2_msg() {
		return ptnr_sms2_msg;
	}
	public void setPtnr_sms2_msg(String ptnr_sms2_msg) {
		this.ptnr_sms2_msg = ptnr_sms2_msg;
	}
	public String getPtnr_sms3_msg() {
		return ptnr_sms3_msg;
	}
	public void setPtnr_sms3_msg(String ptnr_sms3_msg) {
		this.ptnr_sms3_msg = ptnr_sms3_msg;
	}
	public String getIssue_tax_invoice() {
		return issue_tax_invoice;
	}
	public void setIssue_tax_invoice(String issue_tax_invoice) {
		this.issue_tax_invoice = issue_tax_invoice;
	}
	public String getSuitability_yn() {
		return suitability_yn;
	}
	public void setSuitability_yn(String suitability_yn) {
		this.suitability_yn = suitability_yn;
	}
	public String getPtnr_fee1() {
		return ptnr_fee1;
	}
	public void setPtnr_fee1(String ptnr_fee1) {
		this.ptnr_fee1 = ptnr_fee1;
	}
	public String getPtnr_fee2() {
		return ptnr_fee2;
	}
	public void setPtnr_fee2(String ptnr_fee2) {
		this.ptnr_fee2 = ptnr_fee2;
	}
	public String getTop_accnt_id() {
		return top_accnt_id;
	}
	public void setTop_accnt_id(String top_accnt_id) {
		this.top_accnt_id = top_accnt_id;
	}
	public String getStatistics_yn() {
		return statistics_yn;
	}
	public void setStatistics_yn(String statistics_yn) {
		this.statistics_yn = statistics_yn;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getDel_state() {
		return del_state;
	}
	public void setDel_state(String del_state) {
		this.del_state = del_state;
	}
	public String getDel_date() {
		return del_date;
	}
	public void setDel_date(String del_date) {
		this.del_date = del_date;
	}
	public String getBank_title() {
		return bank_title;
	}
	public void setBank_title(String bank_title) {
		this.bank_title = bank_title;
	}
	
	public String getPtnr_ceo_nm() {
		return ptnr_ceo_nm;
	}
	public void setPtnr_ceo_nm(String ptnr_ceo_nm) {
		this.ptnr_ceo_nm = ptnr_ceo_nm;
	}
	public String getSuitability_fee1() {
		return suitability_fee1;
	}
	public void setSuitability_fee1(String suitability_fee1) {
		this.suitability_fee1 = suitability_fee1;
	}
	public String getSuitability_fee2() {
		return suitability_fee2;
	}
	public void setSuitability_fee2(String suitability_fee2) {
		this.suitability_fee2 = suitability_fee2;
	}
	public String getImgStream_s() {
		return imgStream_s;
	}
	public void setImgStream_s(String imgStream_s) {
		this.imgStream_s = imgStream_s;
	}
	public String getImgStream_b() {
		return imgStream_b;
	}
	public void setImgStream_b(String imgStream_b) {
		this.imgStream_b = imgStream_b;
	}
	public String getPtnr_addr1() {
		return ptnr_addr1;
	}
	public void setPtnr_addr1(String ptnr_addr1) {
		this.ptnr_addr1 = ptnr_addr1;
	}
	public String getPtnr_postcode() {
		return ptnr_postcode;
	}
	public void setPtnr_postcode(String ptnr_postcode) {
		this.ptnr_postcode = ptnr_postcode;
	}
	public String getPtnr_addr2() {
		return ptnr_addr2;
	}
	public void setPtnr_addr2(String ptnr_addr2) {
		this.ptnr_addr2 = ptnr_addr2;
	}

	//BoardNoticePtnr1Controller
	public String getPtnr_group_order_cnt() {
		return ptnr_group_order_cnt;
	}
	public void setPtnr_group_order_cnt(String ptnr_group_order_cnt) {
		this.ptnr_group_order_cnt = ptnr_group_order_cnt;
	}
	public String getPtnr_notice_cnt() {
		return ptnr_notice_cnt;
	}
	public void setPtnr_notice_cnt(String ptnr_notice_cnt) {
		this.ptnr_notice_cnt = ptnr_notice_cnt;
	}

}
