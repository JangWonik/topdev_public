package kr.co.toplac.sysadm;

/**
 * 팝업관리자 Bean 파일
 * @author by top3009
 *
 */

public class TopDivPopupVO {
	
	private int popup_no = 0;			//팝업키
	private String subject = "";			//팝업제목
	private String contents = "";			//팝업내용
	private String sdate = "";				//시작일자
	private String edate = "";				//종료일자
	private String repeat_flag = "";		//반복여부 (0:매일, 1:매주반복, 2:매월반복)
	private int week_flag = 0;			//요일 (1~7 : 일 ~ 토)
	private int month_flag = 0;			//반복 날짜 (1~31)
	private String is_use = "";			//사용여부 (0:사용안함, 1:로그인전 사용, 2:로그인후 사용)
	private String reg_date = "";		//등록일자
	private String reg_ip = "";			//등록아이피
	private int popup_height = 0;		//팝업높이
	private int popup_width = 0;		//팝업너비
	
	
	public int getWeek_flag() {
		return week_flag;
	}
	public void setWeek_flag(int week_flag) {
		this.week_flag = week_flag;
	}
	public String getReg_ip() {
		return reg_ip;
	}
	public void setReg_ip(String reg_ip) {
		this.reg_ip = reg_ip;
	}
	public int getPopup_no() {
		return popup_no;
	}
	public void setPopup_no(int popup_no) {
		this.popup_no = popup_no;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getSdate() {
		return sdate;
	}
	public void setSdate(String sdate) {
		this.sdate = sdate;
	}
	public String getEdate() {
		return edate;
	}
	public void setEdate(String edate) {
		this.edate = edate;
	}
	public String getRepeat_flag() {
		return repeat_flag;
	}
	public void setRepeat_flag(String repeat_flag) {
		this.repeat_flag = repeat_flag;
	}	
	public int getMonth_flag() {
		return month_flag;
	}
	public void setMonth_flag(int month_flag) {
		this.month_flag = month_flag;
	}
	public String getIs_use() {
		return is_use;
	}
	public void setIs_use(String is_use) {
		this.is_use = is_use;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public int getPopup_height() {
		return popup_height;
	}
	public void setPopup_height(int popup_height) {
		this.popup_height = popup_height;
	}
	public int getPopup_width() {
		return popup_width;
	}
	public void setPopup_width(int popup_width) {
		this.popup_width = popup_width;
	}
}
