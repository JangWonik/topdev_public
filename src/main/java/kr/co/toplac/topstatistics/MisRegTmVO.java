package kr.co.toplac.topstatistics;

public class MisRegTmVO {

	private String team_id;
	private String center_name;
	private String team_name;
	private String team_type;
	private String user_no;
	private String user_name;
	private String ptnr_id;
	private String ptnr_nick;
	private String team_sector;		//부문정보추가
	private String team_sector_val;		//부문정보이름
	private String team_center;		//센터정보추가
	private String team_center_val;		//센터정보이름
	private int member_cnt = 0;			//팀내 인원수 (업무지원, 퇴사자 제외)
	private String team_written;			//서면심사팀여부 (0:일반, 1:서면심사)
	private String suim_rpt_no;			//보고서 번호

	private String reg_0;
	private String reg_1;
	private String reg_2;
	private String reg_3;
	private String reg_4;
	private String reg_5;
	private String reg_6;
	private String reg_7;
	private String reg_8;
	private String reg_9;
	
	private String reg_00;
	private String reg_01;
	private String reg_02;
	private String reg_03;
	private String reg_04;
	private String reg_05;
	private String reg_06;
	private String reg_07;
	private String reg_08;
	private String reg_09;
	
	private String reg_10;
	private String reg_11;
	private String reg_12;
	private String reg_13;
	private String reg_14;
	private String reg_15;
	private String reg_16;
	private String reg_17;
	private String reg_18;
	private String reg_19;
	private String reg_20;
	private String reg_21;
	private String reg_22;
	private String reg_23;
	private String reg_24;
	private String reg_25;
	private String reg_26;
	private String reg_27;
	private String reg_28;
	private String reg_29;
	private String reg_30;
	
	private String reg_wc_0;
	private String reg_wc_1;
	private String reg_wc_2;
	private String reg_wc_3;
	private String reg_wc_4;
	private String reg_wc_5;
	private String reg_wc_6;
	private String reg_wc_7;
	private String reg_wc_8;
	private String reg_wc_9;
	
	private String reg_wc_00;
	private String reg_wc_01;
	private String reg_wc_02;
	private String reg_wc_03;
	private String reg_wc_04;
	private String reg_wc_05;
	private String reg_wc_06;
	private String reg_wc_07;
	private String reg_wc_08;
	private String reg_wc_09;
	
	private String reg_wc_10;
	private String reg_wc_11;
	private String reg_wc_12;
	private String reg_wc_13;
	private String reg_wc_14;
	private String reg_wc_15;
	private String reg_wc_16;
	private String reg_wc_17;
	private String reg_wc_18;
	private String reg_wc_19;
	private String reg_wc_20;
	private String reg_wc_21;
	private String reg_wc_22;
	private String reg_wc_23;
	private String reg_wc_24;
	private String reg_wc_25;
	private String reg_wc_26;
	private String reg_wc_27;
	private String reg_wc_28;
	private String reg_wc_29;
	private String reg_wc_30;
	
	private String cls_1;
	private String cls_2;
	private String cls_3;
	private String cls_4;
	private String cls_5;
	private String cls_6;
	private String cls_7;
	private String cls_8;
	private String cls_9;
	private String cls_10;
	private String cls_11;
	private String cls_12;
	
	private String cls_wc_1;
	private String cls_wc_2;
	private String cls_wc_3;
	private String cls_wc_4;
	private String cls_wc_5;
	private String cls_wc_6;
	private String cls_wc_7;
	private String cls_wc_8;
	private String cls_wc_9;
	private String cls_wc_10;
	private String cls_wc_11;
	private String cls_wc_12;
	
	private String day_00;
	private String day_01;
	private String day_02;
	private String day_03;
	private String day_04;
	private String day_05;
	private String day_06;
	private String day_07;
	private String day_08;
	private String day_09;
	private String day_10;
	private String day_11;
	private String day_12;
	private String day_13;
	private String day_14;
	private String day_15;
	private String day_16;
	private String day_17;
	private String day_18;
	private String day_19;
	private String day_20;
	private String day_21;
	private String day_22;
	private String day_23;
	private String day_24;
	private String day_25;
	private String day_26;
	private String day_27;
	private String day_28;
	private String day_29;
	private String day_30;
	
	private String day_wc_00;
	private String day_wc_01;
	private String day_wc_02;
	private String day_wc_03;
	private String day_wc_04;
	private String day_wc_05;
	private String day_wc_06;
	private String day_wc_07;
	private String day_wc_08;
	private String day_wc_09;
	private String day_wc_10;
	private String day_wc_11;
	private String day_wc_12;
	private String day_wc_13;
	private String day_wc_14;
	private String day_wc_15;
	private String day_wc_16;
	private String day_wc_17;
	private String day_wc_18;
	private String day_wc_19;
	private String day_wc_20;
	private String day_wc_21;
	private String day_wc_22;
	private String day_wc_23;
	private String day_wc_24;
	private String day_wc_25;
	private String day_wc_26;
	private String day_wc_27;
	private String day_wc_28;
	private String day_wc_29;
	private String day_wc_30;
	
	private String reg_y;
	private String reg_mi;
	private String cls_m;
	private String cls_y;
	
	private String reg_wc_y;
	private String reg_wc_mi;
	private String cls_wc_m;
	private String cls_wc_y;
	
	private String basicYN;
	private String primYN;	
	
	private String wc_center_flag;			//서면심사 센터 표시여부 (0:표시안함, 1:표시함)
	private String wc_sector_flag;			//서면심사 부분 표시여부 (0:표시안함, 1:표시함)
	
	public String getSuim_rpt_no() {
		return suim_rpt_no;
	}
	public void setSuim_rpt_no(String suim_rpt_no) {
		this.suim_rpt_no = suim_rpt_no;
	}
	public String getTeam_written() {
		return team_written;
	}
	public void setTeam_written(String team_written) {
		this.team_written = team_written;
	}
	public int getMember_cnt() {
		return member_cnt;
	}
	public void setMember_cnt(int member_cnt) {
		this.member_cnt = member_cnt;
	}
	public String getWc_center_flag() {
		return wc_center_flag;
	}
	public void setWc_center_flag(String wc_center_flag) {
		this.wc_center_flag = wc_center_flag;
	}
	public String getWc_sector_flag() {
		return wc_sector_flag;
	}
	public void setWc_sector_flag(String wc_sector_flag) {
		this.wc_sector_flag = wc_sector_flag;
	}
	public String getReg_wc_0() {
		return reg_wc_0;
	}
	public void setReg_wc_0(String reg_wc_0) {
		this.reg_wc_0 = reg_wc_0;
	}
	public String getReg_wc_1() {
		return reg_wc_1;
	}
	public void setReg_wc_1(String reg_wc_1) {
		this.reg_wc_1 = reg_wc_1;
	}
	public String getReg_wc_2() {
		return reg_wc_2;
	}
	public void setReg_wc_2(String reg_wc_2) {
		this.reg_wc_2 = reg_wc_2;
	}
	public String getReg_wc_3() {
		return reg_wc_3;
	}
	public void setReg_wc_3(String reg_wc_3) {
		this.reg_wc_3 = reg_wc_3;
	}
	public String getReg_wc_4() {
		return reg_wc_4;
	}
	public void setReg_wc_4(String reg_wc_4) {
		this.reg_wc_4 = reg_wc_4;
	}
	public String getReg_wc_5() {
		return reg_wc_5;
	}
	public void setReg_wc_5(String reg_wc_5) {
		this.reg_wc_5 = reg_wc_5;
	}
	public String getReg_wc_6() {
		return reg_wc_6;
	}
	public void setReg_wc_6(String reg_wc_6) {
		this.reg_wc_6 = reg_wc_6;
	}
	public String getReg_wc_7() {
		return reg_wc_7;
	}
	public void setReg_wc_7(String reg_wc_7) {
		this.reg_wc_7 = reg_wc_7;
	}
	public String getReg_wc_8() {
		return reg_wc_8;
	}
	public void setReg_wc_8(String reg_wc_8) {
		this.reg_wc_8 = reg_wc_8;
	}
	public String getReg_wc_9() {
		return reg_wc_9;
	}
	public void setReg_wc_9(String reg_wc_9) {
		this.reg_wc_9 = reg_wc_9;
	}
	public String getReg_wc_00() {
		return reg_wc_00;
	}
	public void setReg_wc_00(String reg_wc_00) {
		this.reg_wc_00 = reg_wc_00;
	}
	public String getReg_wc_01() {
		return reg_wc_01;
	}
	public void setReg_wc_01(String reg_wc_01) {
		this.reg_wc_01 = reg_wc_01;
	}
	public String getReg_wc_02() {
		return reg_wc_02;
	}
	public void setReg_wc_02(String reg_wc_02) {
		this.reg_wc_02 = reg_wc_02;
	}
	public String getReg_wc_03() {
		return reg_wc_03;
	}
	public void setReg_wc_03(String reg_wc_03) {
		this.reg_wc_03 = reg_wc_03;
	}
	public String getReg_wc_04() {
		return reg_wc_04;
	}
	public void setReg_wc_04(String reg_wc_04) {
		this.reg_wc_04 = reg_wc_04;
	}
	public String getReg_wc_05() {
		return reg_wc_05;
	}
	public void setReg_wc_05(String reg_wc_05) {
		this.reg_wc_05 = reg_wc_05;
	}
	public String getReg_wc_06() {
		return reg_wc_06;
	}
	public void setReg_wc_06(String reg_wc_06) {
		this.reg_wc_06 = reg_wc_06;
	}
	public String getReg_wc_07() {
		return reg_wc_07;
	}
	public void setReg_wc_07(String reg_wc_07) {
		this.reg_wc_07 = reg_wc_07;
	}
	public String getReg_wc_08() {
		return reg_wc_08;
	}
	public void setReg_wc_08(String reg_wc_08) {
		this.reg_wc_08 = reg_wc_08;
	}
	public String getReg_wc_09() {
		return reg_wc_09;
	}
	public void setReg_wc_09(String reg_wc_09) {
		this.reg_wc_09 = reg_wc_09;
	}
	public String getReg_wc_10() {
		return reg_wc_10;
	}
	public void setReg_wc_10(String reg_wc_10) {
		this.reg_wc_10 = reg_wc_10;
	}
	public String getReg_wc_11() {
		return reg_wc_11;
	}
	public void setReg_wc_11(String reg_wc_11) {
		this.reg_wc_11 = reg_wc_11;
	}
	public String getReg_wc_12() {
		return reg_wc_12;
	}
	public void setReg_wc_12(String reg_wc_12) {
		this.reg_wc_12 = reg_wc_12;
	}
	public String getReg_wc_13() {
		return reg_wc_13;
	}
	public void setReg_wc_13(String reg_wc_13) {
		this.reg_wc_13 = reg_wc_13;
	}
	public String getReg_wc_14() {
		return reg_wc_14;
	}
	public void setReg_wc_14(String reg_wc_14) {
		this.reg_wc_14 = reg_wc_14;
	}
	public String getReg_wc_15() {
		return reg_wc_15;
	}
	public void setReg_wc_15(String reg_wc_15) {
		this.reg_wc_15 = reg_wc_15;
	}
	public String getReg_wc_16() {
		return reg_wc_16;
	}
	public void setReg_wc_16(String reg_wc_16) {
		this.reg_wc_16 = reg_wc_16;
	}
	public String getReg_wc_17() {
		return reg_wc_17;
	}
	public void setReg_wc_17(String reg_wc_17) {
		this.reg_wc_17 = reg_wc_17;
	}
	public String getReg_wc_18() {
		return reg_wc_18;
	}
	public void setReg_wc_18(String reg_wc_18) {
		this.reg_wc_18 = reg_wc_18;
	}
	public String getReg_wc_19() {
		return reg_wc_19;
	}
	public void setReg_wc_19(String reg_wc_19) {
		this.reg_wc_19 = reg_wc_19;
	}
	public String getReg_wc_20() {
		return reg_wc_20;
	}
	public void setReg_wc_20(String reg_wc_20) {
		this.reg_wc_20 = reg_wc_20;
	}
	public String getReg_wc_21() {
		return reg_wc_21;
	}
	public void setReg_wc_21(String reg_wc_21) {
		this.reg_wc_21 = reg_wc_21;
	}
	public String getReg_wc_22() {
		return reg_wc_22;
	}
	public void setReg_wc_22(String reg_wc_22) {
		this.reg_wc_22 = reg_wc_22;
	}
	public String getReg_wc_23() {
		return reg_wc_23;
	}
	public void setReg_wc_23(String reg_wc_23) {
		this.reg_wc_23 = reg_wc_23;
	}
	public String getReg_wc_24() {
		return reg_wc_24;
	}
	public void setReg_wc_24(String reg_wc_24) {
		this.reg_wc_24 = reg_wc_24;
	}
	public String getReg_wc_25() {
		return reg_wc_25;
	}
	public void setReg_wc_25(String reg_wc_25) {
		this.reg_wc_25 = reg_wc_25;
	}
	public String getReg_wc_26() {
		return reg_wc_26;
	}
	public void setReg_wc_26(String reg_wc_26) {
		this.reg_wc_26 = reg_wc_26;
	}
	public String getReg_wc_27() {
		return reg_wc_27;
	}
	public void setReg_wc_27(String reg_wc_27) {
		this.reg_wc_27 = reg_wc_27;
	}
	public String getReg_wc_28() {
		return reg_wc_28;
	}
	public void setReg_wc_28(String reg_wc_28) {
		this.reg_wc_28 = reg_wc_28;
	}
	public String getReg_wc_29() {
		return reg_wc_29;
	}
	public void setReg_wc_29(String reg_wc_29) {
		this.reg_wc_29 = reg_wc_29;
	}
	public String getReg_wc_30() {
		return reg_wc_30;
	}
	public void setReg_wc_30(String reg_wc_30) {
		this.reg_wc_30 = reg_wc_30;
	}
	public String getCls_wc_1() {
		return cls_wc_1;
	}
	public void setCls_wc_1(String cls_wc_1) {
		this.cls_wc_1 = cls_wc_1;
	}
	public String getCls_wc_2() {
		return cls_wc_2;
	}
	public void setCls_wc_2(String cls_wc_2) {
		this.cls_wc_2 = cls_wc_2;
	}
	public String getCls_wc_3() {
		return cls_wc_3;
	}
	public void setCls_wc_3(String cls_wc_3) {
		this.cls_wc_3 = cls_wc_3;
	}
	public String getCls_wc_4() {
		return cls_wc_4;
	}
	public void setCls_wc_4(String cls_wc_4) {
		this.cls_wc_4 = cls_wc_4;
	}
	public String getCls_wc_5() {
		return cls_wc_5;
	}
	public void setCls_wc_5(String cls_wc_5) {
		this.cls_wc_5 = cls_wc_5;
	}
	public String getCls_wc_6() {
		return cls_wc_6;
	}
	public void setCls_wc_6(String cls_wc_6) {
		this.cls_wc_6 = cls_wc_6;
	}
	public String getCls_wc_7() {
		return cls_wc_7;
	}
	public void setCls_wc_7(String cls_wc_7) {
		this.cls_wc_7 = cls_wc_7;
	}
	public String getCls_wc_8() {
		return cls_wc_8;
	}
	public void setCls_wc_8(String cls_wc_8) {
		this.cls_wc_8 = cls_wc_8;
	}
	public String getCls_wc_9() {
		return cls_wc_9;
	}
	public void setCls_wc_9(String cls_wc_9) {
		this.cls_wc_9 = cls_wc_9;
	}
	public String getCls_wc_10() {
		return cls_wc_10;
	}
	public void setCls_wc_10(String cls_wc_10) {
		this.cls_wc_10 = cls_wc_10;
	}
	public String getCls_wc_11() {
		return cls_wc_11;
	}
	public void setCls_wc_11(String cls_wc_11) {
		this.cls_wc_11 = cls_wc_11;
	}
	public String getCls_wc_12() {
		return cls_wc_12;
	}
	public void setCls_wc_12(String cls_wc_12) {
		this.cls_wc_12 = cls_wc_12;
	}
	public String getDay_wc_00() {
		return day_wc_00;
	}
	public void setDay_wc_00(String day_wc_00) {
		this.day_wc_00 = day_wc_00;
	}
	public String getDay_wc_01() {
		return day_wc_01;
	}
	public void setDay_wc_01(String day_wc_01) {
		this.day_wc_01 = day_wc_01;
	}
	public String getDay_wc_02() {
		return day_wc_02;
	}
	public void setDay_wc_02(String day_wc_02) {
		this.day_wc_02 = day_wc_02;
	}
	public String getDay_wc_03() {
		return day_wc_03;
	}
	public void setDay_wc_03(String day_wc_03) {
		this.day_wc_03 = day_wc_03;
	}
	public String getDay_wc_04() {
		return day_wc_04;
	}
	public void setDay_wc_04(String day_wc_04) {
		this.day_wc_04 = day_wc_04;
	}
	public String getDay_wc_05() {
		return day_wc_05;
	}
	public void setDay_wc_05(String day_wc_05) {
		this.day_wc_05 = day_wc_05;
	}
	public String getDay_wc_06() {
		return day_wc_06;
	}
	public void setDay_wc_06(String day_wc_06) {
		this.day_wc_06 = day_wc_06;
	}
	public String getDay_wc_07() {
		return day_wc_07;
	}
	public void setDay_wc_07(String day_wc_07) {
		this.day_wc_07 = day_wc_07;
	}
	public String getDay_wc_08() {
		return day_wc_08;
	}
	public void setDay_wc_08(String day_wc_08) {
		this.day_wc_08 = day_wc_08;
	}
	public String getDay_wc_09() {
		return day_wc_09;
	}
	public void setDay_wc_09(String day_wc_09) {
		this.day_wc_09 = day_wc_09;
	}
	public String getDay_wc_10() {
		return day_wc_10;
	}
	public void setDay_wc_10(String day_wc_10) {
		this.day_wc_10 = day_wc_10;
	}
	public String getDay_wc_11() {
		return day_wc_11;
	}
	public void setDay_wc_11(String day_wc_11) {
		this.day_wc_11 = day_wc_11;
	}
	public String getDay_wc_12() {
		return day_wc_12;
	}
	public void setDay_wc_12(String day_wc_12) {
		this.day_wc_12 = day_wc_12;
	}
	public String getDay_wc_13() {
		return day_wc_13;
	}
	public void setDay_wc_13(String day_wc_13) {
		this.day_wc_13 = day_wc_13;
	}
	public String getDay_wc_14() {
		return day_wc_14;
	}
	public void setDay_wc_14(String day_wc_14) {
		this.day_wc_14 = day_wc_14;
	}
	public String getDay_wc_15() {
		return day_wc_15;
	}
	public void setDay_wc_15(String day_wc_15) {
		this.day_wc_15 = day_wc_15;
	}
	public String getDay_wc_16() {
		return day_wc_16;
	}
	public void setDay_wc_16(String day_wc_16) {
		this.day_wc_16 = day_wc_16;
	}
	public String getDay_wc_17() {
		return day_wc_17;
	}
	public void setDay_wc_17(String day_wc_17) {
		this.day_wc_17 = day_wc_17;
	}
	public String getDay_wc_18() {
		return day_wc_18;
	}
	public void setDay_wc_18(String day_wc_18) {
		this.day_wc_18 = day_wc_18;
	}
	public String getDay_wc_19() {
		return day_wc_19;
	}
	public void setDay_wc_19(String day_wc_19) {
		this.day_wc_19 = day_wc_19;
	}
	public String getDay_wc_20() {
		return day_wc_20;
	}
	public void setDay_wc_20(String day_wc_20) {
		this.day_wc_20 = day_wc_20;
	}
	public String getDay_wc_21() {
		return day_wc_21;
	}
	public void setDay_wc_21(String day_wc_21) {
		this.day_wc_21 = day_wc_21;
	}
	public String getDay_wc_22() {
		return day_wc_22;
	}
	public void setDay_wc_22(String day_wc_22) {
		this.day_wc_22 = day_wc_22;
	}
	public String getDay_wc_23() {
		return day_wc_23;
	}
	public void setDay_wc_23(String day_wc_23) {
		this.day_wc_23 = day_wc_23;
	}
	public String getDay_wc_24() {
		return day_wc_24;
	}
	public void setDay_wc_24(String day_wc_24) {
		this.day_wc_24 = day_wc_24;
	}
	public String getDay_wc_25() {
		return day_wc_25;
	}
	public void setDay_wc_25(String day_wc_25) {
		this.day_wc_25 = day_wc_25;
	}
	public String getDay_wc_26() {
		return day_wc_26;
	}
	public void setDay_wc_26(String day_wc_26) {
		this.day_wc_26 = day_wc_26;
	}
	public String getDay_wc_27() {
		return day_wc_27;
	}
	public void setDay_wc_27(String day_wc_27) {
		this.day_wc_27 = day_wc_27;
	}
	public String getDay_wc_28() {
		return day_wc_28;
	}
	public void setDay_wc_28(String day_wc_28) {
		this.day_wc_28 = day_wc_28;
	}
	public String getDay_wc_29() {
		return day_wc_29;
	}
	public void setDay_wc_29(String day_wc_29) {
		this.day_wc_29 = day_wc_29;
	}
	public String getDay_wc_30() {
		return day_wc_30;
	}
	public void setDay_wc_30(String day_wc_30) {
		this.day_wc_30 = day_wc_30;
	}
	public String getReg_wc_y() {
		return reg_wc_y;
	}
	public void setReg_wc_y(String reg_wc_y) {
		this.reg_wc_y = reg_wc_y;
	}
	public String getReg_wc_mi() {
		return reg_wc_mi;
	}
	public void setReg_wc_mi(String reg_wc_mi) {
		this.reg_wc_mi = reg_wc_mi;
	}
	public String getCls_wc_m() {
		return cls_wc_m;
	}
	public void setCls_wc_m(String cls_wc_m) {
		this.cls_wc_m = cls_wc_m;
	}
	public String getCls_wc_y() {
		return cls_wc_y;
	}
	public void setCls_wc_y(String cls_wc_y) {
		this.cls_wc_y = cls_wc_y;
	}
	public String getTeam_center() {
		return team_center;
	}
	public void setTeam_center(String team_center) {
		this.team_center = team_center;
	}
	public String getTeam_center_val() {
		return team_center_val;
	}
	public void setTeam_center_val(String team_center_val) {
		this.team_center_val = team_center_val;
	}
	public String getTeam_sector_val() {
		return team_sector_val;
	}
	public void setTeam_sector_val(String team_sector_val) {
		this.team_sector_val = team_sector_val;
	}
	public String getTeam_sector() {
		return team_sector;
	}
	public void setTeam_sector(String team_sector) {
		this.team_sector = team_sector;
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
	public String getReg_00() {
		return reg_00;
	}
	public void setReg_00(String reg_00) {
		this.reg_00 = reg_00;
	}
	public String getReg_01() {
		return reg_01;
	}
	public void setReg_01(String reg_01) {
		this.reg_01 = reg_01;
	}
	public String getReg_02() {
		return reg_02;
	}
	public void setReg_02(String reg_02) {
		this.reg_02 = reg_02;
	}
	public String getReg_03() {
		return reg_03;
	}
	public void setReg_03(String reg_03) {
		this.reg_03 = reg_03;
	}
	public String getReg_04() {
		return reg_04;
	}
	public void setReg_04(String reg_04) {
		this.reg_04 = reg_04;
	}
	public String getReg_05() {
		return reg_05;
	}
	public void setReg_05(String reg_05) {
		this.reg_05 = reg_05;
	}
	public String getReg_06() {
		return reg_06;
	}
	public void setReg_06(String reg_06) {
		this.reg_06 = reg_06;
	}
	public String getReg_07() {
		return reg_07;
	}
	public void setReg_07(String reg_07) {
		this.reg_07 = reg_07;
	}
	public String getReg_08() {
		return reg_08;
	}
	public void setReg_08(String reg_08) {
		this.reg_08 = reg_08;
	}
	public String getReg_09() {
		return reg_09;
	}
	public void setReg_09(String reg_09) {
		this.reg_09 = reg_09;
	}
	public String getReg_10() {
		return reg_10;
	}
	public void setReg_10(String reg_10) {
		this.reg_10 = reg_10;
	}
	public String getReg_11() {
		return reg_11;
	}
	public void setReg_11(String reg_11) {
		this.reg_11 = reg_11;
	}
	public String getReg_12() {
		return reg_12;
	}
	public void setReg_12(String reg_12) {
		this.reg_12 = reg_12;
	}
	public String getReg_13() {
		return reg_13;
	}
	public void setReg_13(String reg_13) {
		this.reg_13 = reg_13;
	}
	public String getReg_14() {
		return reg_14;
	}
	public void setReg_14(String reg_14) {
		this.reg_14 = reg_14;
	}
	public String getReg_15() {
		return reg_15;
	}
	public void setReg_15(String reg_15) {
		this.reg_15 = reg_15;
	}
	public String getReg_16() {
		return reg_16;
	}
	public void setReg_16(String reg_16) {
		this.reg_16 = reg_16;
	}
	public String getReg_17() {
		return reg_17;
	}
	public void setReg_17(String reg_17) {
		this.reg_17 = reg_17;
	}
	public String getReg_18() {
		return reg_18;
	}
	public void setReg_18(String reg_18) {
		this.reg_18 = reg_18;
	}
	public String getReg_19() {
		return reg_19;
	}
	public void setReg_19(String reg_19) {
		this.reg_19 = reg_19;
	}
	public String getReg_20() {
		return reg_20;
	}
	public void setReg_20(String reg_20) {
		this.reg_20 = reg_20;
	}
	public String getReg_21() {
		return reg_21;
	}
	public void setReg_21(String reg_21) {
		this.reg_21 = reg_21;
	}
	public String getReg_22() {
		return reg_22;
	}
	public void setReg_22(String reg_22) {
		this.reg_22 = reg_22;
	}
	public String getReg_23() {
		return reg_23;
	}
	public void setReg_23(String reg_23) {
		this.reg_23 = reg_23;
	}
	public String getReg_24() {
		return reg_24;
	}
	public void setReg_24(String reg_24) {
		this.reg_24 = reg_24;
	}
	public String getReg_25() {
		return reg_25;
	}
	public void setReg_25(String reg_25) {
		this.reg_25 = reg_25;
	}
	public String getReg_26() {
		return reg_26;
	}
	public void setReg_26(String reg_26) {
		this.reg_26 = reg_26;
	}
	public String getReg_27() {
		return reg_27;
	}
	public void setReg_27(String reg_27) {
		this.reg_27 = reg_27;
	}
	public String getReg_28() {
		return reg_28;
	}
	public void setReg_28(String reg_28) {
		this.reg_28 = reg_28;
	}
	public String getReg_29() {
		return reg_29;
	}
	public void setReg_29(String reg_29) {
		this.reg_29 = reg_29;
	}
	public String getReg_30() {
		return reg_30;
	}
	public void setReg_30(String reg_30) {
		this.reg_30 = reg_30;
	}
	public String getCls_1() {
		return cls_1;
	}
	public void setCls_1(String cls_1) {
		this.cls_1 = cls_1;
	}
	public String getCls_2() {
		return cls_2;
	}
	public void setCls_2(String cls_2) {
		this.cls_2 = cls_2;
	}
	public String getCls_3() {
		return cls_3;
	}
	public void setCls_3(String cls_3) {
		this.cls_3 = cls_3;
	}
	public String getCls_4() {
		return cls_4;
	}
	public void setCls_4(String cls_4) {
		this.cls_4 = cls_4;
	}
	public String getCls_5() {
		return cls_5;
	}
	public void setCls_5(String cls_5) {
		this.cls_5 = cls_5;
	}
	public String getCls_6() {
		return cls_6;
	}
	public void setCls_6(String cls_6) {
		this.cls_6 = cls_6;
	}
	public String getCls_7() {
		return cls_7;
	}
	public void setCls_7(String cls_7) {
		this.cls_7 = cls_7;
	}
	public String getCls_8() {
		return cls_8;
	}
	public void setCls_8(String cls_8) {
		this.cls_8 = cls_8;
	}
	public String getCls_9() {
		return cls_9;
	}
	public void setCls_9(String cls_9) {
		this.cls_9 = cls_9;
	}
	public String getCls_10() {
		return cls_10;
	}
	public void setCls_10(String cls_10) {
		this.cls_10 = cls_10;
	}
	public String getCls_11() {
		return cls_11;
	}
	public void setCls_11(String cls_11) {
		this.cls_11 = cls_11;
	}
	public String getCls_12() {
		return cls_12;
	}
	public void setCls_12(String cls_12) {
		this.cls_12 = cls_12;
	}
	public String getReg_y() {
		return reg_y;
	}
	public void setReg_y(String reg_y) {
		this.reg_y = reg_y;
	}
	public String getReg_mi() {
		return reg_mi;
	}
	public void setReg_mi(String reg_mi) {
		this.reg_mi = reg_mi;
	}
	public String getCls_m() {
		return cls_m;
	}
	public void setCls_m(String cls_m) {
		this.cls_m = cls_m;
	}
	public String getCls_y() {
		return cls_y;
	}
	public void setCls_y(String cls_y) {
		this.cls_y = cls_y;
	}
	public String getDay_00() {
		return day_00;
	}
	public void setDay_00(String day_00) {
		this.day_00 = day_00;
	}
	public String getDay_01() {
		return day_01;
	}
	public void setDay_01(String day_01) {
		this.day_01 = day_01;
	}
	public String getDay_02() {
		return day_02;
	}
	public void setDay_02(String day_02) {
		this.day_02 = day_02;
	}
	public String getDay_03() {
		return day_03;
	}
	public void setDay_03(String day_03) {
		this.day_03 = day_03;
	}
	public String getDay_04() {
		return day_04;
	}
	public void setDay_04(String day_04) {
		this.day_04 = day_04;
	}
	public String getDay_05() {
		return day_05;
	}
	public void setDay_05(String day_05) {
		this.day_05 = day_05;
	}
	public String getDay_06() {
		return day_06;
	}
	public void setDay_06(String day_06) {
		this.day_06 = day_06;
	}
	public String getDay_07() {
		return day_07;
	}
	public void setDay_07(String day_07) {
		this.day_07 = day_07;
	}
	public String getDay_08() {
		return day_08;
	}
	public void setDay_08(String day_08) {
		this.day_08 = day_08;
	}
	public String getDay_09() {
		return day_09;
	}
	public void setDay_09(String day_09) {
		this.day_09 = day_09;
	}
	public String getDay_10() {
		return day_10;
	}
	public void setDay_10(String day_10) {
		this.day_10 = day_10;
	}
	public String getDay_11() {
		return day_11;
	}
	public void setDay_11(String day_11) {
		this.day_11 = day_11;
	}
	public String getDay_12() {
		return day_12;
	}
	public void setDay_12(String day_12) {
		this.day_12 = day_12;
	}
	public String getDay_13() {
		return day_13;
	}
	public void setDay_13(String day_13) {
		this.day_13 = day_13;
	}
	public String getDay_14() {
		return day_14;
	}
	public void setDay_14(String day_14) {
		this.day_14 = day_14;
	}
	public String getDay_15() {
		return day_15;
	}
	public void setDay_15(String day_15) {
		this.day_15 = day_15;
	}
	public String getDay_16() {
		return day_16;
	}
	public void setDay_16(String day_16) {
		this.day_16 = day_16;
	}
	public String getDay_17() {
		return day_17;
	}
	public void setDay_17(String day_17) {
		this.day_17 = day_17;
	}
	public String getDay_18() {
		return day_18;
	}
	public void setDay_18(String day_18) {
		this.day_18 = day_18;
	}
	public String getDay_19() {
		return day_19;
	}
	public void setDay_19(String day_19) {
		this.day_19 = day_19;
	}
	public String getDay_20() {
		return day_20;
	}
	public void setDay_20(String day_20) {
		this.day_20 = day_20;
	}
	public String getDay_21() {
		return day_21;
	}
	public void setDay_21(String day_21) {
		this.day_21 = day_21;
	}
	public String getDay_22() {
		return day_22;
	}
	public void setDay_22(String day_22) {
		this.day_22 = day_22;
	}
	public String getDay_23() {
		return day_23;
	}
	public void setDay_23(String day_23) {
		this.day_23 = day_23;
	}
	public String getDay_24() {
		return day_24;
	}
	public void setDay_24(String day_24) {
		this.day_24 = day_24;
	}
	public String getDay_25() {
		return day_25;
	}
	public void setDay_25(String day_25) {
		this.day_25 = day_25;
	}
	public String getDay_26() {
		return day_26;
	}
	public void setDay_26(String day_26) {
		this.day_26 = day_26;
	}
	public String getDay_27() {
		return day_27;
	}
	public void setDay_27(String day_27) {
		this.day_27 = day_27;
	}
	public String getDay_28() {
		return day_28;
	}
	public void setDay_28(String day_28) {
		this.day_28 = day_28;
	}
	public String getDay_29() {
		return day_29;
	}
	public void setDay_29(String day_29) {
		this.day_29 = day_29;
	}
	public String getDay_30() {
		return day_30;
	}
	public void setDay_30(String day_30) {
		this.day_30 = day_30;
	}
	public String getReg_0() {
		return reg_0;
	}
	public void setReg_0(String reg_0) {
		this.reg_0 = reg_0;
	}
	public String getReg_1() {
		return reg_1;
	}
	public void setReg_1(String reg_1) {
		this.reg_1 = reg_1;
	}
	public String getReg_2() {
		return reg_2;
	}
	public void setReg_2(String reg_2) {
		this.reg_2 = reg_2;
	}
	public String getReg_3() {
		return reg_3;
	}
	public void setReg_3(String reg_3) {
		this.reg_3 = reg_3;
	}
	public String getReg_4() {
		return reg_4;
	}
	public void setReg_4(String reg_4) {
		this.reg_4 = reg_4;
	}
	public String getReg_5() {
		return reg_5;
	}
	public void setReg_5(String reg_5) {
		this.reg_5 = reg_5;
	}
	public String getReg_6() {
		return reg_6;
	}
	public void setReg_6(String reg_6) {
		this.reg_6 = reg_6;
	}
	public String getReg_7() {
		return reg_7;
	}
	public void setReg_7(String reg_7) {
		this.reg_7 = reg_7;
	}
	public String getReg_8() {
		return reg_8;
	}
	public void setReg_8(String reg_8) {
		this.reg_8 = reg_8;
	}
	public String getReg_9() {
		return reg_9;
	}
	public void setReg_9(String reg_9) {
		this.reg_9 = reg_9;
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
	public String getCenter_name() {
		return center_name;
	}
	public void setCenter_name(String center_name) {
		this.center_name = center_name;
	}
	
	
	
}
