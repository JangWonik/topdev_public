<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css?v=2" />
	
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/ne_js/ne_number.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->
	<script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
	<script src="./resources/ne_js/calendar.js"></script><!-- calendar -->
	<script src="./resources/wm_js/common.js"></script>
	
	<script defer src="./resources/fontawesome_5.0/svg-with-js/js/fontawesome-all.js"></script>
	
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	
	<style>
		.memberDetailTable tr td{
			letter-spacing: 0px;
			height: 23px;
		}
		.guestcnt7{
			height: 745px !important;
		}
		
		.memoTextarea{
	      	OVERFLOW-Y:auto; OVERFLOW-X:hidden; width:780px; padding:2px; word-break:break-all; line-height:120%; height:100px;
  			border: 1px solid #b3b3b3;
    		border-radius: 2px;
   		    font-size: 10pt;
    		font-family: 굴림,굴림체;
   		    line-height: 140%;
		}
	</style>
	
	<script>
		$(document).ready(function(){
			
 			if('${presentPage}' != "" ){
				$("#"+"${presentPage}").click();
			} 
			
			if('${mbrAuthVo_Session.user_no}' == null || ('${mbrAuthVo_Session.mbr_pms_14}' == 0 && '${mbrAuthVo_Session.mbr_pms_15}' == 0)){
				window.opener.location.assign("./logout");
				window.self.close();
			}
			
			$("#tid").val('${memberVo.team_id_main}');
			$("#tid2").val('${memberVo.team_id_loc}');
			
			$("#workLevel").val('${memberVo.work_level_cd}');
			$("#workType").val('${memberVo.work_type_cd}');
			$("#workRank").val('${memberVo.work_rank_cd}');
			$("#workJob").val('${memberVo.work_job_cd}');
			
			$("#mbrInfoEdit").click(function(){
				
				var work_job = $("#workJob").val();
				var work_rank = $("#workRank").val();
				
				if (work_job == null){
					work_job = 0;
				}
				if (work_rank == null){
					work_rank = 0;
				}
				
				$.post("popMbrUdt",
						{	 user_no:$("#user_no").val()
							,user_id:$("#user_id").val()
							,home_address:$("#home_address").val()
							
							/* 추가 시작*/
							,team_id_main:$("#tid").val()
							,team_id_loc:$("#tid2").val()
							,join_date:$("#join_date").val()
							,out_date:$("#out_date").val()
							,probation_date:$("#probation_date").val()//면수습일 추가 170406 by lds;
							,user_state:$("#user_state").val()
							,job_memo:$("#job_memo").val()
							
							,workLevel:$("#workLevel").val()
							,workType:$("#workType").val()
							,workRank: work_rank
							,workJob: work_job 
							
							/* 추가 끝*/
							,home_tel_1:$("#home_tel_1").val()
							,home_tel_2:$("#home_tel_2").val()
							,home_tel_3:$("#home_tel_3").val()
							,officetel_1:$("#officetel_1").val()
							,officetel_2:$("#officetel_2").val()
							,officetel_3:$("#officetel_3").val()
							,officefax_1:$("#officefax_1").val()
							,officefax_2:$("#officefax_2").val()
							,officefax_3:$("#officefax_3").val()
							,handphone_1:$("#handphone_1").val()
							,handphone_2:$("#handphone_2").val()
							,handphone_3:$("#handphone_3").val()
							,comment:$("#comment").val()
							,insa_memo:$("#insa_memo").val()
							,insa_memo_only:$("#insa_memo_only").val()
							,email : $("#email").val()
						},
						function(data,status){
							if(data == 1){
								alert("사원 정보 변경이 완료 되었습니다.");
								location.reload();
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});//click
			
			/* 전산 권한 수정 페이지 탭 클릭 동작 */
			$("#authInsTab").click(function(){

				$.post(
						"AuthInsPage",
						{	
							user_no : $("#user_no").val()
						},
						function(data,status){
							
							if(status == "success"){
								
								if(data.length == 0){
									alert("권한 정보가 없습니다.");
									$("input:radio[name='pms1']:input[value='0']").prop("checked", true);
				 		        	$("input:radio[name='pms2']:input[value='0']").prop("checked", true);
				 		        	$("input:radio[name='pms3']:input[value='0']").prop("checked", true);
				 		        	$("input:radio[name='pms4']:input[value='0']").prop("checked", true);
				 		        	$("input:radio[name='pms5']:input[value='0']").prop("checked", true);
				 		        	$("input:radio[name='pms6']:input[value='0']").prop("checked", true);
				 		        	$("input:radio[name='pms7']:input[value='0']").prop("checked", true);
				 		        	$("input:radio[name='pms8']:input[value='0']").prop("checked", true);
				 		        	$("input:radio[name='pms9']:input[value='0']").prop("checked", true);
				 		        	$("input:radio[name='pms10']:input[value='0']").prop("checked", true);
				 		        	$("input:radio[name='pms11']:input[value='0']").prop("checked", true);
				 		        	$("input:radio[name='pms12']:input[value='0']").prop("checked", true);
				 		        	$("input:radio[name='pms13']:input[value='0']").prop("checked", true);
				 		        	$("input:radio[name='pms14']:input[value='0']").prop("checked", true);
				 		        	$("input:radio[name='pms15']:input[value='0']").prop("checked", true);
				 		        	$("input:radio[name='pms16']:input[value='0']").prop("checked", true);
				 		        	$("input:radio[name='pms17']:input[value='0']").prop("checked", true);
				 		        	$("input:radio[name='pms18']:input[value='0']").prop("checked", true);
				 		        	$("input:radio[name='pms19']:input[value='0']").prop("checked", true);
				 		        	$("input:radio[name='pms20']:input[value='0']").prop("checked", true);
				 		        	$("input:radio[name='pms21']:input[value='0']").prop("checked", true);
				 		        	$("input:radio[name='pms22']:input[value='0']").prop("checked", true);
				 		        	$("input:radio[name='pms23']:input[value='0']").prop("checked", true);
				 		        	$("input:radio[name='pms24']:input[value='0']").prop("checked", true);
				 		        	$("input:radio[name='pms25']:input[value='0']").prop("checked", true);
				 		        	$("input:radio[name='pms26']:input[value='0']").prop("checked", true);
				 		        	$("input:radio[name='pms27']:input[value='0']").prop("checked", true);
				 		        	$("input:radio[name='pms28']:input[value='0']").prop("checked", true);
				 		        	$("input:radio[name='pms29']:input[value='0']").prop("checked", true);
								}else{
				                    $.each(data, function(index, entry) {
				                    
					                    /* 보고서 접수(수임) */
			                    		if(entry.mbr_pms_1 == 0){ 
			                    			$("#mbr_pms_1_0").prop("checked",true);
			                    		}else{
			                    			$("#mbr_pms_1_1").prop("checked",true);
			                    		}
					                    
			                    		/* 보고서 열람 */
			                    		if(entry.mbr_pms_2 == 0){ 
			                    			$("#mbr_pms_2_0").prop("checked",true);
			                    		}else{
			                    			$("#mbr_pms_2_1").prop("checked",true);
			                    		}
					                    
			                    		/* 보고서 삭제 */
			                    		if(entry.mbr_pms_3 == 0){ 
			                    			$("#mbr_pms_3_0").prop("checked",true);
			                    		}else{
			                    			$("#mbr_pms_3_1").prop("checked",true);
			                    		}
			                    		
			                    		/* 보고서 종결(결재) 취소*/
			                    		if(entry.mbr_pms_4 == 0){ 
			                    			$("#mbr_pms_4_0").prop("checked",true);
			                    		}else{
			                    			$("#mbr_pms_4_1").prop("checked",true);
			                    		}
			                    		
			                    		/* 보고서 잠금 해제 */
			                    		if(entry.mbr_pms_5 == 0){ 
			                    			$("#mbr_pms_5_0").prop("checked",true);
			                    		}else{
			                    			$("#mbr_pms_5_1").prop("checked",true);
			                    		}
			                    		
			                    		/* 조사보고서 엑셀다운 */
			                    		if(entry.mbr_pms_6 == 0){ 
			                    			$("#mbr_pms_6_0").prop("checked",true);
			                    		}else if(entry.mbr_pms_6 == 1){
			                    			$("#mbr_pms_6_1").prop("checked",true);
			                    		}else if(entry.mbr_pms_6 == 2){
			                    			$("#mbr_pms_6_2").prop("checked",true);
			                    		}else if(entry.mbr_pms_6 == 3){
			                    			$("#mbr_pms_6_3").prop("checked",true);
			                    		}else if(entry.mbr_pms_6 == 4){
			                    			$("#mbr_pms_6_4").prop("checked",true);
			                    		}
			                    		
			                    		/* 총무경리 열람(인보이스) */
			                    		if(entry.mbr_pms_7 == 0){ 
			                    			$("#mbr_pms_7_0").prop("checked",true);
			                    		}else if(entry.mbr_pms_7 == 1){
			                    			$("#mbr_pms_7_1").prop("checked",true);
			                    		}else if(entry.mbr_pms_7 == 2){
			                    			$("#mbr_pms_7_2").prop("checked",true);
			                    		}else if(entry.mbr_pms_7 == 3){
			                    			$("#mbr_pms_7_3").prop("checked",true);
			                    		}else if(entry.mbr_pms_7 == 4){
			                    			$("#mbr_pms_7_4").prop("checked",true);
			                    		}
			                    		
			                    		/* 총무경리 수정(인보이스) */
			                    		if(entry.mbr_pms_8 == 0){ 
			                    			$("#mbr_pms_8_0").prop("checked",true);
			                    		}else{
			                    			$("#mbr_pms_8_1").prop("checked",true);
			                    		}
			                    		
			                    		/* 보험사 정보 수정 */
			                    		if(entry.mbr_pms_9 == 0){ 
			                    			$("#mbr_pms_9_0").prop("checked",true);
			                    		}else{
			                    			$("#mbr_pms_9_1").prop("checked",true);
			                    		}
			                    		
			                    		/* 관련업체 엑셀 다운 */
			                    		if(entry.mbr_pms_10 == 0){ 
			                    			$("#mbr_pms_10_0").prop("checked",true);
			                    		}else{
			                    			$("#mbr_pms_10_1").prop("checked",true);
			                    		}
			                    		
			                    		/* 보험사 공지사항 1종 */
			                    		if(entry.mbr_pms_11 == 0){ 
			                    			$("#mbr_pms_11_0").prop("checked",true);
			                    		}else{
			                    			$("#mbr_pms_11_1").prop("checked",true);
			                    		}
			                    		
			                    		/* 보험사 공지사항 4종 */
			                    		if(entry.mbr_pms_12 == 0){ 
			                    			$("#mbr_pms_12_0").prop("checked",true);
			                    		}else{
			                    			$("#mbr_pms_12_1").prop("checked",true);
			                    		}
			                    		
			                    		/* 팀관리 */
			                    		if(entry.mbr_pms_13 == 0){ 
			                    			$("#mbr_pms_13_0").prop("checked",true);
			                    		}else{
			                    			$("#mbr_pms_13_1").prop("checked",true);
			                    		}
			                    		
			                    		/* 인사기록 */
			                    		if(entry.mbr_pms_14 == 0){ 
			                    			$("#mbr_pms_14_0").prop("checked",true);
			                    		}else{
			                    			$("#mbr_pms_14_1").prop("checked",true);
			                    		}
					                    
			                    		/* 인사평가 관리 권한 */
			                    		if(entry.mbr_pms_15 == 0){ 
			                    			$("#mbr_pms_15_0").prop("checked",true);
			                    		}else{
			                    			$("#mbr_pms_15_1").prop("checked",true);
			                    		}
			                    		
			                    		/* 재직 증명 승인 */
			                    		if(entry.mbr_pms_16 == 0){ 
			                    			$("#mbr_pms_16_0").prop("checked",true);
			                    		}else{
			                    			$("#mbr_pms_16_1").prop("checked",true);
			                    		}
			                    		
			                    		/* 경비내역 결제 취소(top_cost) */
			                    		if(entry.mbr_pms_17 == 0){ 
			                    			$("#mbr_pms_17_0").prop("checked",true);
			                    		}else{
			                    			$("#mbr_pms_17_1").prop("checked",true);
			                    		}
			                    		
			                    		/* 경비내역 승인 취소(top_cost) */
			                    		if(entry.mbr_pms_18 == 0){ 
			                    			$("#mbr_pms_18_0").prop("checked",true);
			                    		}else{
			                    			$("#mbr_pms_18_1").prop("checked",true);
			                    		}
			                    		
			                    		/* 적부 워드 전환 */
			                    		if(entry.mbr_pms_19 == 0){ 
			                    			$("#mbr_pms_19_0").prop("checked",true);
			                    		}else{
			                    			$("#mbr_pms_19_1").prop("checked",true);
			                    		}
			                    		
			                    		/* 적부 응답 전문 */
			                    		if(entry.mbr_pms_20 == 0){ 
			                    			$("#mbr_pms_20_0").prop("checked",true);
			                    		}else{
			                    			$("#mbr_pms_20_1").prop("checked",true);
			                    		}
			                    		
			                    		/* 통계 권한 */
			                    		if(entry.mbr_pms_21 == 0){ 
			                    			$("#mbr_pms_21_0").prop("checked",true);
			                    		}else{
			                    			$("#mbr_pms_21_1").prop("checked",true);
			                    		}
			                    		
			                    		/* 당직 결재 권한 */
			                    		if(entry.mbr_pms_22 == 0){ 
			                    			$("#mbr_pms_22_0").prop("checked",true);
			                    		}else{
			                    			$("#mbr_pms_22_1").prop("checked",true);
			                    		}
			                    		
			                    		/* 당직 등록 권한 */
			                    		if(entry.mbr_pms_23 == 0){ 
			                    			$("#mbr_pms_23_0").prop("checked",true);
			                    		}else{
			                    			$("#mbr_pms_23_1").prop("checked",true);
			                    		}
			                    		
			                    		/* 보고서 알림 접근 권한 */
			                    		if(entry.mbr_pms_24 == 0){ 
			                    			$("#mbr_pms_24_0").prop("checked",true);
			                    		}else if(entry.mbr_pms_24 == 1){
			                    			$("#mbr_pms_24_1").prop("checked",true);
			                    		}else if(entry.mbr_pms_24 == 2){
			                    			$("#mbr_pms_24_2").prop("checked",true);
			                    		}else if(entry.mbr_pms_24 == 3){
			                    			$("#mbr_pms_24_3").prop("checked",true);
			                    		}
			                    		
			                    		/* 보고서 이첩 접근 권한 */
			                    		if(entry.mbr_pms_25 == 0){ 
			                    			$("#mbr_pms_25_0").prop("checked",true);
			                    		}else if(entry.mbr_pms_24 == 1){
			                    			$("#mbr_pms_25_1").prop("checked",true);
			                    		}else if(entry.mbr_pms_24 == 2){
			                    			$("#mbr_pms_25_2").prop("checked",true);
			                    		}else if(entry.mbr_pms_24 == 3){
			                    			$("#mbr_pms_25_3").prop("checked",true);
			                    		}else if(entry.mbr_pms_24 == 4){
			                    			$("#mbr_pms_25_4").prop("checked",true);
			                    		}			 
		                    			
			                    		/* 사내지침 글쓰기 권한 */
			                    		if(entry.mbr_pms_26 == 0){ 
			                    			$("#mbr_pms_26_0").prop("checked",true);
			                    		}else if(entry.mbr_pms_26 == 1){
			                    			$("#mbr_pms_26_1").prop("checked",true);
			                    		}
			                    		
			                    		/* 강의실 결재 권한*/
			                    		if(entry.mbr_pms_27 == 0){ 
			                    			$("#mbr_pms_27_0").prop("checked",true);
			                    		}else if(entry.mbr_pms_27 == 1){
			                    			$("#mbr_pms_27_1").prop("checked",true);
			                    		}	
			                    		
			                    		/* 휴가 결재 권한 */
			                    		if(entry.mbr_pms_28 == 0){ 
			                    			$("#mbr_pms_28_0").prop("checked",true);
			                    		}else if(entry.mbr_pms_28 == 1){
			                    			$("#mbr_pms_28_1").prop("checked",true);
			                    		}else if(entry.mbr_pms_28 == 4){
			                    			$("#mbr_pms_28_4").prop("checked",true);
			                    		}
			                    		
			                    		/* 빠른 결재 권한*/
			                    		if(entry.mbr_pms_29 == 0){ 
			                    			$("#mbr_pms_29_0").prop("checked",true);
			                    		}else if(entry.mbr_pms_27 == 1){
			                    			$("#mbr_pms_29_1").prop("checked",true);
			                    		}
			                    		
			                    		
									});//each
									
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						},"json"
				);//post
				
		
			}); //authInsTab click
			

			$("#authEditeBtn").click(function(){				
				
				$.post("AuthUdtAndIns",
						{	user_no:$("#user_no").val()
							,mbr_pms_1:$("input:radio[name='pms1']:checked").val()
							,mbr_pms_2:$("input:radio[name='pms2']:checked").val()
							,mbr_pms_3:$("input:radio[name='pms3']:checked").val()
							,mbr_pms_4:$("input:radio[name='pms4']:checked").val()
							,mbr_pms_5:$("input:radio[name='pms5']:checked").val()
							,mbr_pms_6:$("input:radio[name='pms6']:checked").val()
							,mbr_pms_7:$("input:radio[name='pms7']:checked").val()
							,mbr_pms_8:$("input:radio[name='pms8']:checked").val()
							,mbr_pms_9:$("input:radio[name='pms9']:checked").val()
							,mbr_pms_10:$("input:radio[name='pms10']:checked").val()
							,mbr_pms_11:$("input:radio[name='pms11']:checked").val()
							,mbr_pms_12:$("input:radio[name='pms12']:checked").val()
							,mbr_pms_13:$("input:radio[name='pms13']:checked").val()
							,mbr_pms_14:$("input:radio[name='pms14']:checked").val()
							,mbr_pms_15:$("input:radio[name='pms15']:checked").val()
							,mbr_pms_16:$("input:radio[name='pms16']:checked").val()
							,mbr_pms_17:$("input:radio[name='pms17']:checked").val()
							,mbr_pms_18:$("input:radio[name='pms18']:checked").val()
							,mbr_pms_19:$("input:radio[name='pms19']:checked").val()
							,mbr_pms_20:$("input:radio[name='pms20']:checked").val()
							,mbr_pms_21:$("input:radio[name='pms21']:checked").val()
							,mbr_pms_22:$("input:radio[name='pms22']:checked").val()
							,mbr_pms_23:$("input:radio[name='pms23']:checked").val()
							,mbr_pms_24:$("input:radio[name='pms24']:checked").val()
							,mbr_pms_25:$("input:radio[name='pms25']:checked").val()
							,mbr_pms_26:$("input:radio[name='pms26']:checked").val()
							,mbr_pms_27:$("input:radio[name='pms27']:checked").val()
							,mbr_pms_28:$("input:radio[name='pms28']:checked").val()
							,mbr_pms_29:$("input:radio[name='pms29']:checked").val()							
							,mbr_pms_30:$("input:radio[name='pms30']:checked").val()
							,mbr_pms_31:$("input:radio[name='pms31']:checked").val()
							,mbr_pms_32:$("input:radio[name='pms32']:checked").val()
							,mbr_pms_33:$("input:radio[name='pms33']:checked").val()
							,mbr_pms_34:$("input:radio[name='pms34']:checked").val()
							,mbr_pms_35:$("input:radio[name='pms35']:checked").val()
							,mbr_pms_36:$("input:radio[name='pms36']:checked").val()
							,mbr_pms_37:$("input:radio[name='pms37']:checked").val()
							,mbr_pms_38:$("input:radio[name='pms38']:checked").val()
							,mbr_pms_39:$("input:radio[name='pms39']:checked").val()
							
							,mbr_pms_40:$("input:radio[name='pms40']:checked").val()
							,mbr_pms_41:$("input:radio[name='pms41']:checked").val()
							,mbr_pms_42:$("input:radio[name='pms42']:checked").val()
							,mbr_pms_43:$("input:radio[name='pms43']:checked").val()
							,mbr_pms_44:$("input:radio[name='pms44']:checked").val()
							,mbr_pms_45:$("input:radio[name='pms45']:checked").val()
							,mbr_pms_46:$("input:radio[name='pms46']:checked").val()
							,mbr_pms_47:$("input:radio[name='pms47']:checked").val()
						},
						function(data,status){
							if(data == 1){
								alert("권한 정보 변경이 완료 되었습니다.");
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});
			
			/* 전산권한 변경 로그 탭 클릭 동작 */
			$("#authListTab").click(function(){
 				$.post("AuthListPage",
 						{	
 							user_no : $("#user_no").val()
 						}, 
 						function(data,status){

 							if(status == "success"){
 								$("#authListTable").empty();
 								if(data.length == 0){
 									
 									$("#authListTable").append(
 										"<tr>"
 											+"<td colspan='28'> 권한 변경 로그 없음</td>"
 										+"</tr>"
 									);
 									
 								}else{
 				                    $.each(data, function(index, entry) {
 				                    	
 				                    		$("#authListTable").append(
 				                    				"<tr onMouseOver='this.style.backgroundColor=\"#FFECEC\"' onMouseOut='this.style.backgroundColor=\"\"'>"
 													+ "<td>"+entry.mbr_pms_1+"</td>"
 													+ "<td>"+entry.mbr_pms_3+"</td>"
 													+ "<td>"+entry.mbr_pms_4+"</td>"
 													+ "<td>"+entry.mbr_pms_5+"</td>"
 													+ "<td>"+entry.mbr_pms_6+"</td>"
 													+ "<td>"+entry.mbr_pms_7+"</td>"
 													+ "<td>"+entry.mbr_pms_8+"</td>"
 													+ "<td>"+entry.mbr_pms_9+"</td>"
 													+ "<td>"+entry.mbr_pms_10+"</td>"
 													+ "<td>"+entry.mbr_pms_11+"</td>"
 													+ "<td>"+entry.mbr_pms_12+"</td>"
 													+ "<td>"+entry.mbr_pms_13+"</td>"
 													+ "<td>"+entry.mbr_pms_14+"</td>"
 													+ "<td>"+entry.mbr_pms_15+"</td>"
 													+ "<td>"+entry.mbr_pms_16+"</td>"
 													+ "<td>"+entry.mbr_pms_17+"</td>"
 													+ "<td>"+entry.mbr_pms_18+"</td>"
 													+ "<td>"+entry.mbr_pms_19+"</td>"
 													+ "<td>"+entry.mbr_pms_20+"</td>"
 													+ "<td>"+entry.mbr_pms_21+"</td>"
 													+ "<td>"+entry.mbr_pms_22+"</td>"
 													+ "<td>"+entry.mbr_pms_23+"</td>"
 													+ "<td>"+entry.mbr_pms_24+"</td>"
 													+ "<td>"+entry.mbr_pms_25+"</td>"
 													+ "<td>"+entry.mbr_pms_26+"</td>"
 													+ "<td>"+entry.mbr_pms_27+"</td>"
 													+ "<td>"+entry.mbr_pms_28+"</td>"
 													+ "<td>"+entry.reg_user+"</td>"
 													+ "<td>"+entry.reg_date+"</td>"
 			                                		+ "</tr>"
 				   							);
 				                    		
 									});//each
 									
 				                   $("#searchStr").focus();
 								}
 							}else{
 								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
 							}
 						},"json"
 				);//post
 				
 			});
			
 			$("#checkAlltoNo").click(function() {
 		         if( $(this).is(":checked") ) {
 		        	
 		        	$("input:radio[name='pms1']:input[value='0']").prop("checked", true);
 		        	$("input:radio[name='pms2']:input[value='0']").prop("checked", true);
 		        	$("input:radio[name='pms3']:input[value='0']").prop("checked", true);
 		        	$("input:radio[name='pms4']:input[value='0']").prop("checked", true);
 		        	$("input:radio[name='pms5']:input[value='0']").prop("checked", true);
 		        	$("input:radio[name='pms6']:input[value='0']").prop("checked", true);
 		        	$("input:radio[name='pms7']:input[value='0']").prop("checked", true);
 		        	$("input:radio[name='pms8']:input[value='0']").prop("checked", true);
 		        	$("input:radio[name='pms9']:input[value='0']").prop("checked", true);
 		        	$("input:radio[name='pms10']:input[value='0']").prop("checked", true);
 		        	$("input:radio[name='pms11']:input[value='0']").prop("checked", true);
 		        	$("input:radio[name='pms12']:input[value='0']").prop("checked", true);
 		        	$("input:radio[name='pms13']:input[value='0']").prop("checked", true);
 		        	$("input:radio[name='pms14']:input[value='0']").prop("checked", true);
 		        	$("input:radio[name='pms15']:input[value='0']").prop("checked", true);
 		        	$("input:radio[name='pms16']:input[value='0']").prop("checked", true);
 		        	$("input:radio[name='pms17']:input[value='0']").prop("checked", true);
 		        	$("input:radio[name='pms18']:input[value='0']").prop("checked", true);
 		        	$("input:radio[name='pms19']:input[value='0']").prop("checked", true);
 		        	$("input:radio[name='pms20']:input[value='0']").prop("checked", true);
 		        	$("input:radio[name='pms21']:input[value='0']").prop("checked", true);
 		        	$("input:radio[name='pms22']:input[value='0']").prop("checked", true);
 		        	$("input:radio[name='pms23']:input[value='0']").prop("checked", true);
 		        	$("input:radio[name='pms24']:input[value='0']").prop("checked", true);
 		        	$("input:radio[name='pms25']:input[value='0']").prop("checked", true);
 		        	$("input:radio[name='pms26']:input[value='0']").prop("checked", true);
 		        	$("input:radio[name='pms27']:input[value='0']").prop("checked", true);
 		        	$("input:radio[name='pms28']:input[value='0']").prop("checked", true);
 		        	
 		         }
 	     	});
			
 			/* 전체 체크 하기 */
 			$("#checkAlltoYes").click(function() {
 		         if( $(this).is(":checked") ) {
 		        	
 		        	$("input:radio[name='pms1']:input[value='1']").prop("checked", true);
 		        	$("input:radio[name='pms2']:input[value='1']").prop("checked", true);
 		        	$("input:radio[name='pms3']:input[value='1']").prop("checked", true);
 		        	$("input:radio[name='pms4']:input[value='1']").prop("checked", true);
 		        	$("input:radio[name='pms5']:input[value='1']").prop("checked", true);
 		        	$("input:radio[name='pms6']:input[value='4']").prop("checked", true);
 		        	$("input:radio[name='pms7']:input[value='4']").prop("checked", true);
 		        	$("input:radio[name='pms8']:input[value='1']").prop("checked", true);
 		        	$("input:radio[name='pms9']:input[value='1']").prop("checked", true);
 		        	$("input:radio[name='pms10']:input[value='1']").prop("checked", true);
 		        	$("input:radio[name='pms11']:input[value='1']").prop("checked", true);
 		        	$("input:radio[name='pms12']:input[value='1']").prop("checked", true);
 		        	$("input:radio[name='pms13']:input[value='1']").prop("checked", true);
 		        	$("input:radio[name='pms14']:input[value='1']").prop("checked", true);
 		        	$("input:radio[name='pms15']:input[value='1']").prop("checked", true);
 		        	$("input:radio[name='pms16']:input[value='1']").prop("checked", true);
 		        	$("input:radio[name='pms17']:input[value='1']").prop("checked", true);
 		        	$("input:radio[name='pms18']:input[value='1']").prop("checked", true);
 		        	$("input:radio[name='pms19']:input[value='1']").prop("checked", true);
 		        	$("input:radio[name='pms20']:input[value='1']").prop("checked", true);
 		        	$("input:radio[name='pms21']:input[value='1']").prop("checked", true);
 		        	$("input:radio[name='pms22']:input[value='1']").prop("checked", true);
 		        	$("input:radio[name='pms23']:input[value='1']").prop("checked", true);
 		        	$("input:radio[name='pms24']:input[value='1']").prop("checked", true);
 		        	$("input:radio[name='pms25']:input[value='1']").prop("checked", true);
 		        	$("input:radio[name='pms26']:input[value='1']").prop("checked", true);
 		        	$("input:radio[name='pms27']:input[value='1']").prop("checked", true);
 		        	$("input:radio[name='pms28']:input[value='1']").prop("checked", true);
 		        	
 		        	
 		         }
 	     	});
			
 			/* 비밀번호 초기화 */ 
 			/* $("#initialPw").click(function(){
 				var sUser_name = $("#user_name").val();
 				var sUser_no = $("#user_no").val();
 				var sComment = sUser_name + "님의 비밀번호를 초기화 하시겠습니까?"; 				
 				
 				if(confirm(sComment)){
 					$.post("./initializePw",
 	 						{	
 	 							user_no : sUser_no
 	 						},
 	 						function(data,status){

 	 							if(status == "success"){
 	 								if(data == 0){
 	 									alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
 	 								}else{
 	 									$("#message").val("Top PassWord : "+data);
 	 									resFrom.submit();
 	 									alert("비밀번호가 초기화 되었습니다. 임시 비밀번호가 "+sUser_name+"님에게 SMS로 전송되었습니다.");
 	 									location.href = "popMemberDetail?user_no="+sUser_no;
 	 								}
 	 							}else{
 	 								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
 	 							}
 	 						}
 	 				);//post
 				}
 			}); */
 			$("#myimageDel").click(function(){
 				var r = confirm("사진을 삭제 하시겠습니까?");
 				if (!r){
 					return false;
 				}
				$.post("popMemberDtlImgDel",
						{user_no : $("#user_no").val()},
						function(data,status){
							if(data == 1 && status == 'success'){
								alert("사진을 삭제하였습니다.");
								location.reload();
								/*
								$("#myimage").attr("src","");
								$("#myimageDel").css("display","none");
								*/
							}else{
								alert("삭제에 실패했습니다. 잠시 후 시도해주세요.")
								
							}
						}
				);
 				
 			});
		});
		
		function check(obj){			
			$("#user_state").val(obj);
			
			if((obj == 0) || (obj == 2)){
				$("#out_date").val("");
			}
		}
	</script>
	
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<style>
		#initialPw {
			border:1x solid #ff0080;    /*---테두리 정의---*/
			background-Color:#ffe6f2;   /*--백그라운드 정의---*/
			font:12px 굴림;      /*--폰트 정의---*/
			font-weight:bold;   /*--폰트 굵기---*/
			color:#ff0080;    /*--폰트 색깔---*/
			width:130;height:30;  /*--버튼 크기---*/
			margin-left:10px;
		}
		
		.ui-button-text-only {
			height:2.1em !important;
		}
		
	</style>
</head>
<body>
	<!-- header --><!--2016.01.14.rjh.수정.교체.-->
	<div id="headerpop_mbr">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="40" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> 인 사 관 리</span></b></font>
			</div>
		</div>
	</div>
	<!-- //header -->
	
	<!-- center -->
	<div id ="container" style="height: 860px !important; overflow-Y:hidden;">
		<div class="contetnsPop" style="width: 1480px;">
			<div class="center_cnt">
				<div class="centercnt_bot1-3" style="width:1480px; height:820px;">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="<c:if test="${presentPage == null || presentPage == ''}">on</c:if>"><a href="#">사원 정보</a></li>
								<!-- IT지원파트, 윤경수전무님-->
								<c:if test="${mbrVo_Session.user_state == 9 or mbrVo_Session.user_no == 62}">
									<li id = "authInsTab"><a href="#">전산권한관리</a></li>
									<li id = "authListTab"><a href="#">전산권한변경내역</a></li>
								</c:if>
								<c:if test="${mbrAuthVo_Session.mbr_pms_15 == 1 }">
									<li id="appointTab"><a href="#">발령, 진급 및 휴직,상/벌</a></li>
									<li id="career"><a href="#">경력 및 자격</a></li>
									<li id="education"><a href="#">교육 및 강의이력</a></li>
									<li id="family"><a href="#">학력 및 가족관계</a></li>
<%-- 									<li><a href="#"><c:out value="${yearInt}" /> 년도 인사평가</a></li>
									<li><a href="#">인사평가내역</a></li> --%>
								</c:if>
								<c:if test="${mbrAuthVo_Session.mbr_pms_14 == 1 }">
									<li id="mbrDocTab"><a href="#">인사서식관리</a></li>	
								</c:if>
							</ul>
						</div>
						<form action="./popMemberDetail" name="popMemberDetail" method="get">
							<input type="hidden" name="presentPage" id="presentPage" value="" />
							<input type="hidden" name="user_no" id="user_no" value="${memberVo.user_no}" />
						</form>
						
						<!-- 사원 정보 컨텐츠 탭 -->
						<c:choose>
							<c:when test="${presentPage == null || presentPage == ''}">
								<div class="guestcnt7" style="display: block;">
							</c:when>
							<c:otherwise>
								<div class="guestcnt7" style="display: none;" >
							</c:otherwise>
						</c:choose>
						
						<div class= "tableStyle5">
							<div style = "width:29%; float:right; text-align:center; ">
								<div style = "width:100%;  height:200px; margin-top:20px; margin-bottom: 20px;r">
									<img id="myimage" src="${imageBase64}"  width="120" height="150" alt="사원사진" />
									<br /><br />
									<c:choose>
										<c:when test="${imageBase64 != null}">
											<img src="./resources/ls_img/btn_del.gif" id="myimageDel" style="margin-top:10px;cursor: pointer;"/>
										</c:when>
										<c:otherwise>
											<%@include file="../include/uploadform.jsp"%>	
										</c:otherwise>
									</c:choose>
								</div>
								
								<div style = "border:1px solid gray; width:98%;  height:100px; overflow:scroll;">
									도장 : <%@include file="../include/uploadform_sign.jsp"%>
								</div>
								<div style = "border:1px solid gray; width:98%;  height:100px; overflow:scroll;margin-top: 5px;">
									MMS 이미지(220 X 180) : <c:import url="../include/uploadform_mms.jsp"/>
								</div>
								
							</div>
							
							<form id = "myinfoForm" name = "myinfoForm" method="post"> 
								<input type="hidden" name ="user_no" id ="user_no" value = "${memberVo.user_no}"/>
								<input type="hidden" name ="team_id_loc" id ="team_id_loc" value = "${memberVo.team_id_loc}"/>
								<input type="hidden" name ="job_memo" id ="job_memo" value="${memberVo.job_memo}"/>
								<input type="hidden" name="user_id" id="user_id" value="${memberVo.user_id}" />
								<input type="hidden" name="user_name" id="user_name" value="${memberVo.user_name}" />
																
								<table class="memberDetailTable" style="float:left;" border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td width="20%" class = "tdHead" bgcolor="#efefef">이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름</td>
										<td width="80%" style="text-align:left; padding-left:10px;"><span>${memberVo.user_name}</span></td>
									</tr>
									<tr>
										<td  width="100" class = "tdHead" bgcolor="#efefef">아&nbsp;이&nbsp;디&nbsp;</td>
										<td width="400" style="text-align:left; padding-left:10px;"><span>${memberVo.user_id}</span>
										<input type="button" value = "비밀번호 초기화" id = "initialPw" />
										</td>
									</tr>
									<tr>
										<td  width="100" class = "tdHead" bgcolor="#efefef">주&nbsp;민&nbsp;번&nbsp;호&nbsp;</td>
										<td width="400" style="text-align:left; padding-left:10px;"><span>${memberVo.jumin_no1}</span>&nbsp;&nbsp;-&nbsp;&nbsp;<span>${memberVo.jumin_no2}</span></td>
									</tr>
									<tr>
										<td width="20%" class = "tdHead" bgcolor="#efefef">부&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;서&nbsp;</td>
										<td width="80%" style="text-align:left; padding-left:10px;">
											<select id="tid">
												<option value="0" selected>선택</option>
												<c:forEach items="${teamList}" var = "teamVo">
													<option value="${teamVo.team_id}">
													
													<c:if test="${teamVo.team_level eq 1}">&nbsp;&nbsp;└</c:if>
													<c:if test="${teamVo.team_level eq 2}">&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
													${teamVo.team_name}
													
													</option>
												</c:forEach>
											</select>
										</td>
									</tr>
									
									<tr>
										<td width="20%" class = "tdHead" bgcolor="#efefef">현&nbsp;재&nbsp;위&nbsp;치</td>
										<td width="80%" style="text-align:left; padding-left:10px;">
											<select id="tid2">
												<option value="0" selected>선택</option>
												<c:forEach items="${teamList}" var = "teamVo">
													<option value="${teamVo.team_id}">
													
													<c:if test="${teamVo.team_level eq 1}">&nbsp;&nbsp;└</c:if>
													<c:if test="${teamVo.team_level eq 2}">&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
													${teamVo.team_name}
													
													</option>
												</c:forEach>
											</select>
										</td>
									</tr>									
									
									
									<tr>
										<!-- 180108 직급/직책 에서 직위/직급으로 변경 -->
										<td class = "tdHead" bgcolor="#efefef">직위 / 직급 / 직책</td>
										<td style="text-align:left; padding-left:10px;">
											<select id="workLevel">
												<c:forEach items="${workLevelList}" var = "levelVo">
													<option value="${levelVo.col_cd}">${levelVo.col_val}</option>
												</c:forEach>
											</select>
											
											<!-- 직급  -->
											<select id="workRank" style="width:60px;">
												<option value="0">선택</option>
												<c:forEach var="item" items="${workRankList}" varStatus="status">
													<option value="${item.col_cd}">
														${item.col_val}
													</option>
												</c:forEach>
											</select>											

											<select id="workType">
												<c:forEach items="${workTypeList}" var = "levelVo">
													<option value="${levelVo.col_cd}">${levelVo.col_val}</option>
												</c:forEach>
											</select>
											<input type="button" class="pop" onclick="fnCodeDsc();" value="코드설명" />
										</td>
									</tr>
									
									<tr>
										<td class = "tdHead" bgcolor="#efefef">직무 / 직무코드</td>
										<td style="text-align:left; padding-left:10px;">
											<select id="workJob">
												<option value="0">선택</option>
												<c:forEach items="${workJobList}" var="item" varStatus="status">
													<c:if test="${item.col_cd1 == memberVo.team_type2}">
														<option value="${item.col_cd2}" >
															${item.col_val}
														</option>
													</c:if>
												</c:forEach>
											</select>
										
<!-- 											<select id="position"> -->
<%-- 												<c:choose> --%>
<%-- 													<c:when test="${memberVo.team_type != 4 }"> --%>
<!-- 														<option value="0">선택</option> -->
<%-- 															<c:forEach var="item" items="${position1}" varStatus="status"> --%>
<%-- 																	<option value="${item.col_cd2}" <c:if test="${item.col_cd2 == memberVo.position && item.col_cd1 == 1}">selected</c:if>>${item.col_val}</option> --%>
<%-- 															</c:forEach> --%>
<%-- 													</c:when> --%>
<%-- 													<c:otherwise> --%>
<!-- 														<option value="0">선택</option> -->
<%-- 															<c:forEach var="item" items="${position4}" varStatus="status"> --%>
<%-- 																	<option value="${item.col_cd2}" <c:if test="${item.col_cd2 == memberVo.position && item.col_cd1 == 4}">selected</c:if>>${item.col_val}</option> --%>
<%-- 															</c:forEach> --%>
<%-- 													</c:otherwise>											 --%>
<%-- 												</c:choose> --%>
<!-- 											</select> -->
											
											<span id="positionCode" style="padding-left: 3px;">
												${memberVo.work_job_code}
											</span>
											
<!-- 											<select id="positionCode" style="width:80px;"> -->
<%-- 												<c:choose> --%>
<%-- 													<c:when test="${memberVo.team_type != 4 }"> --%>
<!-- 														<option value="0">선택</option> -->
<%-- 															<c:forEach var="item" items="${positionCode1}" varStatus="status"> --%>
<%-- 																<option value="${item.col_cd2}" <c:if test="${item.col_cd2 == memberVo.position_code && item.col_cd1 == 1}">selected</c:if>>${item.col_val}</option> --%>
<%-- 															</c:forEach> --%>
<%-- 													</c:when> --%>
<%-- 													<c:otherwise> --%>
<!-- 														<option value="0">선택</option> -->
<%-- 															<c:forEach var="item" items="${positionCode4}" varStatus="status"> --%>
<%-- 																<option value="${item.col_cd2}" <c:if test="${item.col_cd2 == memberVo.position_code && item.col_cd1 == 4}">selected</c:if>>${item.col_val}</option> --%>
<%-- 															</c:forEach> --%>
<%-- 													</c:otherwise>			 --%>
<%-- 												</c:choose> --%>
<!-- 											</select> -->
											
										</td>
									</tr>
									
									<tr>
										<td class = "tdHead" bgcolor="#efefef">입&nbsp;사&nbsp;/&nbsp;퇴&nbsp;사&nbsp;일&nbsp;</td>
										<td style="text-align:left; padding-left:10px;">
											<input type="hidden" id = "user_state" value = "${memberVo.user_state}"/>
											＊ 입사&nbsp;:&nbsp;<input type="text" id="join_date" name="join_date" size="10" value="${memberVo.join_date}" maxlength="10" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											＊ 퇴사&nbsp;:&nbsp;<input type="text" id="out_date" name="out_date" size="10" value="${memberVo.out_date}" maxlength="10" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											＊ 면수습 : <input type="text" id="probation_date" name="probation_date" size="10" value="${memberVo.probation_date}" maxlength="10" />
											<br />
											
											<c:choose>
												<c:when test="${memberVo.user_state eq '0' or memberVo.user_state eq '9'}">
													<input type="radio" name="user_state" value="0" checked="checked" onchange="check(0);"> 근무중 
													<input type="radio" name="user_state" value="2" onchange="check(2);"> 발령대기
													<input type="radio" name="user_state" value="1"  onchange="check(1);"> 퇴사	
												</c:when>
												<c:when test="${memberVo.user_state eq '2' }">
													<input type="radio" name="user_state" value="0" onchange="check(0);"> 근무중 
													<input type="radio" name="user_state" value="2" checked="checked" onchange="check(2);"> 발령대기
													<input type="radio" name="user_state" value="1" onchange="check(1);"> 퇴사	
												</c:when>
												<c:otherwise>
													<input type="radio" name="user_state" value="0" onchange="check(0);"> 근무중 
													<input type="radio" name="user_state" value="2" onchange="check(2);"> 발령대기
													<input type="radio" name="user_state" value="1" checked="checked" onchange="check(1);"> 퇴사
												</c:otherwise>
											</c:choose>
										</td>
										
									</tr>
									<tr>
										<td class = "tdHead" bgcolor="#efefef">주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소&nbsp;</td>
										<td style="text-align:left; padding-left:10px;">
											<input type="text" name="home_address" id="home_address" size="70" value ="${memberVo.home_address}" style="ime-mode:active;">
											<span></span>
										</td>
									</tr>
									<tr>
										<td class = "tdHead"  bgcolor="#efefef">자택 전화번호&nbsp;</td>
										<td style="text-align:left; padding-left:10px;">
											<input type="text" name="home_tel_1" id="home_tel_1" size="5" maxlength="4" value ="${home_tel_1}">
											-
											<input type="text" name="home_tel_2" id="home_tel_2" size="5" maxlength="4" value ="${home_tel_2}">
											-
											<input type="text" name="home_tel_3" id="home_tel_3" size="5" maxlength="4" value ="${home_tel_3}"> 
										</td>
									</tr>
									<tr>
										<td class = "tdHead"  bgcolor="#efefef">직통 전화번호&nbsp;</td>
										<td style="text-align:left; padding-left:10px;">
											<input type="text" name="officetel_1" id="officetel_1" size="5" maxlength="4" value = "${officetel_1}">
											-
											<input type="text" name="officetel_2" id="officetel_2" size="5" maxlength="4" value = "${officetel_2}">
											-
											<input type="text" name="officetel_3" id="officetel_3" size="5" maxlength="4" value = "${officetel_3}"> 
										</td> 
									</tr>
									<tr>
										<td class = "tdHead"  bgcolor="#efefef">팩스번호&nbsp;</td>
										<td style="text-align:left; padding-left:10px;">
											<input type="text" name="officefax_1" id="officefax_1" size="5" maxlength="4" value = "${officefax_1}">
											-
											<input type="text" name="officefax_2" id="officefax_2" size="5" maxlength="4" value = "${officefax_2}">
											-
											<input type="text" name="officefax_3" id="officefax_3" size="5" maxlength="4" value = "${officefax_3}"> 
										</td> 
									</tr>
									<tr>
										<td  class = "tdHead" bgcolor="#efefef">핸 드 폰&nbsp;</td>
										<td style="text-align:left; padding-left:10px;">
											<input type="text" name="handphone_1" id="handphone_1" size="5" maxlength="4" value ="${handphone_1}" >
											-
											<input type="text" name="handphone_2" id="handphone_2" size="5" maxlength="4" value = "${handphone_2}">
											-
											<input type="text" name="handphone_3" id="handphone_3" size="5" maxlength="4" value = "${handphone_3}"> 
										</td>
									</tr>
									<tr>
										<td class = "tdHead"  bgcolor="#efefef">E - mail</td>
										<td style="text-align:left; padding-left:10px;">
											<input type="text" id="email" name="email" size="25" value="${memberVo.email}" />
										</td>
									</tr>
									
									<c:if test="${mbrVo_Session.user_no == 966 || mbrVo_Session.user_no == 670 || mbrVo_Session.user_no == 882
									|| mbrVo_Session.user_no == 62 || mbrVo_Session.user_no == 6 || mbrVo_Session.user_no == 215 || mbrVo_Session.user_no == 1421 || mbrVo_Session.user_no == 1265
									|| mbrVo_Session.user_no == 770 }">
										<tr>
											<td class = "tdHead" bgcolor="#efefef">인사 관련 사항</td>
											<td style="text-align:left; padding-left:10px;">
												<textarea class="memoTextarea" name="insa_memo" id="insa_memo" rows="7" cols="70"  style="ime-mode:active;">${memberVo.memo}</textarea>
											</td>
										</tr>
									</c:if>
									<c:if test="${mbrVo_Session.user_no == 966 || mbrVo_Session.user_no == 6}">
										<tr>
											<td class = "tdHead" bgcolor="#efefef">인사 관련</td>
											<td style="text-align:left; padding-left:10px;">
												<textarea class="memoTextarea" name="insa_memo_only" id="insa_memo_only" rows="7" cols="70" style="ime-mode:active;">${memberVo.insa_memo_only}</textarea>
											</td>
										</tr>
									</c:if>
									<%-- <tr>
										<td class = "tdHead" bgcolor="#efefef">자기소개</td>
										<td style="text-align:left; padding-left:10px;">
											<textarea name="comment" id="comment" rows="4" cols="70">${memberVo.comment}</textarea>
										</td>
									</tr> --%>
									<tr>
										<td colspan="2" style = "border:0; text-align:center;">
											<img src="./resources/ne_img/btn_edite.gif" id="mbrInfoEdit" style = "cursor:pointer;"/>
										</td>
									</tr>
								</table>
							</form>
					
						<%-- 	<table style = "float:right; " >
								<tr>
									<td  class = "tdHead" width="20%"  bgcolor="#efefef">도장 및 사인</td>
									<td style="text-align:left; padding-left:10px;">
										<%@include file="../include/uploadform_sign.jsp"%>
									</td>
								</tr>
							</table> --%>
					
							<!-- <div id= "button" style ="float:right; text-align:center;">	
								<br />
								<input type="image" src="./resources/ne_img/btn_edite.gif" id="mbrInfoEdit"/>
							</div> -->
					
						</div><!-- //tableStyle4 -->
						</div><!-- //guestcnt7 -->
						<c:if test="${mbrVo_Session.user_state == 9 or mbrVo_Session.user_no == 62}">
							<div class="guestcnt7" style="display:none;">
								<c:import url="../top_team/pop_mbr_auth_ins.jsp"></c:import>
							</div><!-- //guestcnt7 -->
						</c:if>

						<c:if test="${mbrVo_Session.user_state == 9 or mbrVo_Session.user_no == 62}">
							<div class="guestcnt7" style="display:none;">
								<c:import url="../top_team/pop_mbr_auth_list.jsp"></c:import>
							</div><!-- //guestcnt7 -->
						</c:if>	

						<c:if test="${mbrAuthVo_Session.mbr_pms_15 == 1 }">
						
							<div class="guestcnt7" style="display:none;">
								<c:import url="../top_team/pop_mbr_appoint_list.jsp"></c:import>
							</div>
							<div class="guestcnt7" style="display:none;">
								<c:import url="../top_team/pop_mbr_career_list.jsp"></c:import>
							</div>
							<div class="guestcnt7" style="display:none;">
								<c:import url="../top_team/pop_mbr_education_list.jsp"></c:import>
							</div>
							<div class="guestcnt7" style="display:none;">
								<c:import url="../top_team/pop_mbr_family_list.jsp"></c:import>
							</div>
<%-- 							<div class="guestcnt7" style="display:none;">
								<c:import url="../top_team/pop_mbr_eval.jsp"></c:import>
							</div><!-- //guestcnt7 -->

							<div class="guestcnt7" style="display:none;">
								<c:import url="../top_team/pop_mbr_eval_list.jsp"></c:import>
							</div><!-- //guestcnt7 --> --%>
						</c:if>
						
						
						<!-- 품의서 관리 -->
						<c:if test="${mbrAuthVo_Session.mbr_pms_14 == 1 }">
							<div class="guestcnt7" style="display:none;">
								<c:import url="../top_team/pop_mbr_doc_list.jsp"></c:import>
							</div><!-- //guestcnt7 -->
						</c:if>
						
									<div id="code-modal" title="코드설명" style="font-size: 15px;display:none;" align="center">
										
											<table>
												<tr height="30">
													<th align="left" style="color:#013ADF"><font size="3">  ● 직 급 ( 공 통 )  </font></th>
												</tr>
												<tr>
													<td align="left" style="padding:3px;">
														<div>회장  CE0  ,  사장  SJ  ,  부사장  BSJ  ,  전무  JM  , 상무  SM1~5  ,  이사  E1~5  ,</div> 
														<div>부장  B1~4  ,  차장  C1~4  ,  과장  G1~4  ,  대리  D1~4  ,  주임  J1~2  ,  사원  S1~5  ,</div>
														<div>수습  S1  ,  실장  HD,  고문  KM</div>
														<!-- <div>실장  SJ </div> -->
													</td>
												</tr>
												<tr height="30">
													<th align="left" style="color:#013ADF"><font size="3">  ● 직 무 코 드  </font></th>
												</tr>
												<tr>
													<td align="left" style="padding:3px;">
														▪ 1 종<br />
														임원  M00  ,  농업손사  W00  ,  정책손사  W01  ,  재물손사  W10  ,  대인손사  W20,<br />
														대물손사  W21  ,  서면심사  W30  ,  재경  S00  ,  인사총무  S01,  IT  S02  ,<br />
														물보험기획  S10,  업무지원  S11  ,  의료심사  S12  ,  SIU  S13  ,  센터총무  S20<br />
														<br />
														<br />
														▪ 4 종<br />
														본부 - 임원  ST0  ,  총괄  ST1  ,  팀장  ST2  ,  실무  ST3<br />
														조사팀 - 센터장  SU0  ,  팀장  SU1  ,  실무  SU2  ,  업무지원  SU3<br />
														서면팀 - 총괄  CR0  , 센터장  CR1  ,  팀장  CR2  ,  실무  CR3  ,  업무지원  CR4<br />
													</td>
												</tr>
																								
												
											</table>
										
									</div>									
					</div><!-- //guest -->
				</div><!-- //bot1-3 -->
			</div>
		</div>
	</div>
	<!--//center -->

	<!-- footer -->
<%-- 	<c:import url="../top_main/top_pop_footer.jsp"></c:import> --%>
	<!-- //footer -->
	
	<!-- 비밀번호 초기화 문자보내기 -->
	<%-- <form action=" http://munjamadang.co.kr/smsasp/smsasp.html " method="post" name="resFrom" onsubmit="wait()" style="display:none;">
		<input type="hidden" name="send_time" value="">
		<!-- <input type="hidden" name="return_url" value="this"> -->
		<input type="hidden" name="end_alert" value="1">
		<input id="msgfocus" name="msgfocus" type="hidden" value="0"/>
		<input type="hidden" name="userid" value="toplac">
		<input type="hidden" name="passwd" value="toplac3000">
		<input type="hidden" name="message" id = "message" value="">
		<input type="hidden" name="sender" value="0260774600">
		<input type="hidden" name="receiver" value="${handphone_1}${handphone_2}${handphone_3}">
	</form> --%>

<script type="text/javascript">
    $(document).ready(function () {
        _initButton();
    });

    //버튼 이벤트
    function _initButton() {
//         $(".codePopUp").on("click", function () {
//             fnPopUp();
//             console.log("call fnpopup");
//         });
        
        $(".pop").on("click", function () {
        	fnCodeDsc();
            //console.log("call fnpopup");
        });
    }

//     function fnPopUp() {
//     	var cw=screen.availWidth;
// 		var ch=screen.availHeight;
// 		var sw=300; //띄울 창의 넓이
// 		var sh=400;  //띄울 창의 높이
// 		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
// 		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
// 		window.open('./popWorkCode','workCodePopUp','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
//     }
    
    function fnCodeDsc(){
    	$("#code-modal").dialog({
    		height: 450,
    		width: 500,
    		closeOnEscape : true,
    		draggable : false,
//    		appendTo : "#rptCancelForm",
    		buttons:{
    			"닫기" : function(){
    				$(this).dialog("close");
    			}
    		},
    		modal: true,
    		overlay:{ opacity: 0., background: '#000000'}
    	});
    }


</script>

</body>
