package kr.co.toplac.topvaction;

/**
 * 연차계산내역을 표시하기 위한 Bean
 * 2019.06.14
 * @author top3009
 */

public class VacationCalBean {
	
	private String sUsername = "";			//사용자 이름
	private String sJoindate = "";			//입사일자
	private double nYearset = 0;			//발생연차
	private double nWorkset = 0;			//근무일(월차)에 따른 발생월차
	private double nHoliday = 0;			//공휴일로 인한 차감연차
	private double nUsework_all_vacation = 0;		//사용한 휴가일수
	private double nUsework_after_vacation = 0;		//근무월 이후 사용한 휴가일수
	
	public String getsUsername() {
		return sUsername;
	}
	public void setsUsername(String sUsername) {
		this.sUsername = sUsername;
	}
	public String getsJoindate() {
		return sJoindate;
	}
	public void setsJoindate(String sJoindate) {
		this.sJoindate = sJoindate;
	}
	public double getnYearset() {
		return nYearset;
	}
	public void setnYearset(double nYearset) {
		this.nYearset = nYearset;
	}
	public double getnWorkset() {
		return nWorkset;
	}
	public void setnWorkset(double nWorkset) {
		this.nWorkset = nWorkset;
	}
	public double getnHoliday() {
		return nHoliday;
	}
	public void setnHoliday(double nHoliday) {
		this.nHoliday = nHoliday;
	}
	public double getnUsework_all_vacation() {
		return nUsework_all_vacation;
	}
	public void setnUsework_all_vacation(double nUsework_all_vacation) {
		this.nUsework_all_vacation = nUsework_all_vacation;
	}
	public double getnUsework_after_vacation() {
		return nUsework_after_vacation;
	}
	public void setnUsework_after_vacation(double nUsework_after_vacation) {
		this.nUsework_after_vacation = nUsework_after_vacation;
	}
}
