package kr.co.toplac.topstatistics;

import java.util.List;

public class MisTmBscViewVO {

	private String user_no;
	private String user_name;
	private String team_id;
	private String team_name;
	private String team_type;
	private String team_written;
	private String ptnr_id;
	private String ptnr_nick;
	
	private String viewFromDate;
	private String viewToDate;	
	private String viewFromYear;
	private String viewToYear;
	
	private String basicYN;
	private String primYN;
	private String primContractYN;
	private List<String> userNoList;
	
	private String search_no;
	
	private String srch_user_no;
	private String srch_team_id;
	
	public String getTeam_written() {
		return team_written;
	}
	public void setTeam_written(String team_written) {
		this.team_written = team_written;
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
	public String getTeam_type() {
		return team_type;
	}
	public void setTeam_type(String team_type) {
		this.team_type = team_type;
	}
	public String getViewFromDate() {
		return viewFromDate;
	}
	public void setViewFromDate(String viewFromDate) {
		this.viewFromDate = viewFromDate;
	}
	public String getViewToDate() {
		return viewToDate;
	}
	public void setViewToDate(String viewToDate) {
		this.viewToDate = viewToDate;
	}
	public String getViewFromYear() {
		return viewFromYear;
	}
	public void setViewFromYear(String viewFromYear) {
		this.viewFromYear = viewFromYear;
	}
	public String getViewToYear() {
		return viewToYear;
	}
	public void setViewToYear(String viewToYear) {
		this.viewToYear = viewToYear;
	}
	public String getBasicYN() {
		return basicYN;
	}
	public void setBasicYN(String basicYN) {
		this.basicYN = basicYN;
	}
	public String getPrimYN() {
		return primYN;
	}
	public void setPrimYN(String primYN) {
		this.primYN = primYN;
	}
	public String getPrimContractYN() {
		return primContractYN;
	}
	public void setPrimContractYN(String primContractYN) {
		this.primContractYN = primContractYN;
	}
	public List<String> getUserNoList() {
		return userNoList;
	}
	public void setUserNoList(List<String> userNoList) {
		this.userNoList = userNoList;
	}
	
	public String getSearch_no() {
		return search_no;
	}
	public void setSearch_no(String search_no) {
		this.search_no = search_no;
	}
	public String getSrch_user_no() {
		return srch_user_no;
	}
	
	public void setSrch_user_no(String srch_user_no) {
		this.srch_user_no = srch_user_no;
	}
	public String getSrch_team_id() {
		return srch_team_id;
	}
	public void setSrch_team_id(String srch_team_id) {
		this.srch_team_id = srch_team_id;
	}
	
	

}
