<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE HTML>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css">
	<!--<link rel="stylesheet" type="text/css" href="./resources/ne_css/style2.css">-->
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/ne_js/ne_number.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->
	<script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
	<script src="./resources/ne_js/calendar.js"></script><!-- calendar -->
	<script src="./resources/wm_js/common.js"></script>

	<script>
		$(document).ready(function(){
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_no}'.trim() == ''){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				window.location.assign("./logout");
			}
		});//ready

		$(document).ready(function(){

			$.ajaxSetup({cache:false});

			var tabCode = $("#tab_code").val(); 
			$("#tab"+tabCode).click();
			
			$("#yearprev").click(function(){
		        var imsiyeartxt = $("#yeartxt").text();
		        $("#yeartxt").text(--imsiyeartxt);
	        	$("#viewFromDate").val(--imsiyeartxt+"-12-16");
	        	$("#viewToDate").val($("#yeartxt").text()+"-12-15");
		        //newCostSearchForm.submit();
		    });
		    $("#yearnext").click(function(){
		        var imsiyeartxt = $("#yeartxt").text();
		        $("#yeartxt").text(++imsiyeartxt);
	        	$("#viewFromDate").val($("#yeartxt").text()+"-12-16");
	        	$("#viewToDate").val(++imsiyeartxt+"-12-15");
		        //newCostSearchForm.submit();
		    });
	
		    //월별 선택 버튼 클릭시 해당월에 해당하는 날짜 text 입력
		    $(".monthbtn").click(function(){
		    	var imsimonth = $(this).attr("id");
		    	var imsiMonthStart = imsimonth -1;
		    	if(imsimonth.length < 2) imsimonth = "0"+imsimonth;
		    	var imsiMonthStartStr = "0"+imsiMonthStart;
		    	if(imsiMonthStartStr.length > 2) imsiMonthStartStr = imsiMonthStartStr.substring(1, imsiMonthStartStr.length);
		        	$("#viewFromDate").val($("#yeartxt").text()+"-"+imsiMonthStartStr +"-"+ "16");
		        	$("#viewToDate").val($("#yeartxt").text()+"-"+imsimonth+"-"+ "15");
		        if(imsimonth == 1){
		        	$("#viewFromDate").val(($("#yeartxt").text()-1)+"-"+"12" +"-"+ "16");
		        }
		        newCostSearchForm.submit();
		    });//monthbtn.click

			$("#printMyCost").click(function(){
				var cw=screen.availWidth;
				var ch=screen.availHeight;
				var sw=1010; //띄울 창의 넓이
				var sh=740;  //띄울 창의 높이
				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
				window.open('printCost?user_no='+$("#user_no").val()+'&viewFromDate='+$("#viewFromDate").val()+'&viewToDate='+$("#viewToDate").val()+ '&excelYN=N','_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			});

			$("#btn_excel").click(function(){
				var cw=screen.availWidth;
				var ch=screen.availHeight;
				var sw=1010; //띄울 창의 넓이
				var sh=740;  //띄울 창의 높이
				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
				window.open('printCost?user_no='+$("#user_no").val()+'&viewFromDate='+$("#viewFromDate").val()+'&viewToDate='+$("#viewToDate").val()+ '&excelYN=Y','_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			});

		    $("#addMyCostIns").click(function(){
// 				if($("#hid_cost_aprv_state").val() != 0){
// 					alert("팀장 결재 이후 추가할 수 없습니다. '결재 취소'를 하거나 결재자에게 '결재 취소'를 받으십시오.");
// 					return;
// 				}
				if($("#cost_occur_date").val().trim() == ''){
					alert("날짜를 선택하세요.");
					$("#cost_occur_date").focus();
					return;
				}
		    	if($("#cost_class_no").val().trim() == ''){
					alert("계정명을 선택하세요.");
					$("#cost_class_no").focus();
					return;
				}
				if($("#cost_pay_type").val().trim() == ''){
					alert("구분을 선택하세요.");
					$("#cost_pay_type").focus();
					return;
				}
				if($("#cost_bill_ea").val().trim() == ''){
					alert("영수증 수를 입력하세요.");
					$("#cost_bill_ea").focus();
					return;
				}
				if($("#cost_pay_amt").val().trim() == ''){
					alert("금액을 입력하세요.");
					$("#cost_pay_amt").focus();
					return;
				}
				$.post("./newCostMbrAddOK",
						{	cost_occur_date     				:$("#cost_occur_date").val()
							,cost_class_no					:$("#cost_class_no").val()
							,cost_pay_type  					:$("#cost_pay_type").val()
							,cost_bill_ea   					:$("#cost_bill_ea").val()
							,cost_pay_amt  					:removeCommaFunc( $("#cost_pay_amt").val() )
							,cost_pay_place					:$("#cost_pay_place").val()
							,cost_involved_com     			:$("#cost_involved_com").val()
							,cost_involved_man      		:$("#cost_involved_man").val()
							,cost_memo    					:$("#cost_memo").val()
							,team_id							:$("#team_id").val()
							,user_no								:$("#user_no").val()
						},
						function(data,status){
							if(status == "success"){
									alert(data);
									$("#viewFromDate").val($("#cost_occur_date").val());
							        newCostSearchForm.submit();
									//window.location.reload();
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}//function
				);//post
			});//$("#addMyCostIns").click
			
			 $("#addMyCostIns2").click(function(){
					if($("#cost_occur_date_2").val().trim() == ''){
						alert("날짜를 선택하세요.");
						$("#cost_occur_date_2").focus();
						return;
					}
			    	if($("#cost_class_no_claim_2").val().trim() == ''){
						alert("계정명을 선택하세요.");
						$("#cost_class_no_claim_2").focus();
						return;
					}
					if($("#cost_pay_type_2").val().trim() == ''){
						alert("구분을 선택하세요.");
						$("#cost_pay_type_2").focus();
						return;
					}
					if($("#cost_bill_ea_2").val().trim() == ''){
						alert("영수증 수를 입력하세요.");
						$("#cost_bill_ea_2").focus();
						return;
					}
					if($("#cost_pay_amt_2").val().trim() == ''){
						alert("금액을 입력하세요.");
						$("#cost_pay_amt_2").focus();
						return;
					}
					if($("#cost_suim_accept_no_2").val().trim() == ''){
						alert("접수번호를 입력하세요.");
						$("#cost_suim_accept_no_2").focus();
						return;
					}
					if($("#cost_distance_2").val().trim() == ''){
						alert("거리를 입력하세요.");
						$("#cost_distance_2").focus();
						return;
					}
					$.post("./newCostMbrAddOK",
							{	cost_occur_date     				:$("#cost_occur_date_2").val()
								,cost_class_no_claim			:$("#cost_class_no_claim_2").val()
								,cost_pay_type  					:$("#cost_pay_type_2").val()
								,cost_bill_ea   					:$("#cost_bill_ea_2").val()
								,cost_pay_amt  					:removeCommaFunc( $("#cost_pay_amt_2").val() )
								,cost_involved_com     			:$("#cost_involved_com_2").val()
								,cost_involved_man      		:$("#cost_involved_man_2").val()
								,cost_memo    					:$("#cost_memo_2").val()
								,team_id							:$("#team_id").val()
								,user_no								:$("#user_no").val()
								,cost_suim_accept_no			:$("#cost_suim_accept_no_2").val()
								,cost_distance						:$("#cost_distance_2").val()
							},
							function(data,status){
								if(status == "success"){
										alert(data);
										$("#viewFromDate").val($("#cost_occur_date_2").val());
								        newCostSearchForm.submit();
										//window.location.reload();
								}else{
									alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
								}
							}//function
					);//post
				});//$("#addMyCostIns").click

				$("#addMyCostIns_addition").click(function(){					
					if($("#cost_occur_date_addition").val().trim() == ''){
						alert("날짜를 선택하세요.");
						$("#cost_occur_date_addition").focus();
						return;
					}
			    	if($("#cost_class_no_addition").val().trim() == ''){
						alert("계정명을 선택하세요.");
						$("#cost_class_no").focus();
						return;
					}
					if($("#cost_pay_type_addition").val().trim() == ''){
						alert("구분을 선택하세요.");
						$("#cost_pay_type_addition").focus();
						return;
					}
					if($("#cost_bill_ea_addition").val().trim() == ''){
						alert("영수증 수를 입력하세요.");
						$("#cost_bill_ea_addition").focus();
						return;
					}
					if($("#cost_pay_amt_addition").val().trim() == ''){
						alert("금액을 입력하세요.");
						$("#cost_pay_amt_addition").focus();
						return;
					}
					
					$.post("./newCostMbrAddOK",
							{	cost_occur_date     				:$("#cost_occur_date_addition").val()
								,cost_apply_date					:$("#cost_apply_date_addition").val()
								,cost_class_no					:$("#cost_class_no_addition").val()
								,cost_pay_type  					:$("#cost_pay_type_addition").val()
								,cost_bill_ea   					:$("#cost_bill_ea_addition").val()
								,cost_pay_amt  					:removeCommaFunc( $("#cost_pay_amt_addition").val() )
								,cost_pay_place					:$("#cost_pay_place_addition").val()
								,cost_involved_com     			:$("#cost_involved_com_addition").val()
								,cost_involved_man      		:$("#cost_involved_man_addition").val()
								,cost_memo    					:$("#cost_memo_addition").val()
								,team_id							:$("#team_id").val()
								,user_no								:$("#user_no").val()
								,cost_gubun_flag    				:3
							},
							
							function(data,status){
								if(status == "success"){
									alert(data);
									$("#viewFromDate").val($("#cost_apply_date_addition").val());
									newCostSearchForm.submit();
								}else{
									alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
								}
							}//function
					);//post						
					
				});//$("#addMyCostIns").click					
				
				
			$(".delMyCost").click(function(){
				var r = confirm("해당 건을 삭제 하시겠습니까?");
				if (!r){
					return;
				}				
				var tmpVar = $(this).attr("value");
				if($("#hid_cost_aprv_state" + tmpVar).val() != 0){
					alert("팀장 결재 이후 삭제할 수 없습니다. '결재 취소'를 하거나 결재자에게 '결재 취소'를 받으십시오.");
					return;
				}
				$.post("./myCostInsNewDelOK",
						{cost_no:$("#cost_no"+tmpVar).val()
						,cost_occur_date:$("#cost_occur_date" + tmpVar).val()},
						function(data,status){
							if(status == "success"){
								$("#viewFromDate").val($("#cost_occur_date" + tmpVar).val());
						        newCostSearchForm.submit();
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}//function
				);//post
			});/* $(".delMyCost").click */
			
			$(".delMyCost2").click(function(){
				var r = confirm("해당 건을 삭제 하시겠습니까?");
				if (!r){
					return;
				}
				var tmpVar = $(this).attr("value");
				if($("#hid_cost_claim_aprv_state" +tmpVar).val() != 0){
					alert("팀장 결재 이후 삭제할 수 없습니다. '결재 취소'를 하거나 결재자에게 '결재 취소'를 받으십시오.");
					return;
				}
				$.post("./myCostInsNewDelOK",
						{cost_no:$("#cost_no_2_"+tmpVar).val()
						,cost_occur_date:$("#cost_occur_date_2_"+tmpVar).val()},
						function(data,status){
							if(status == "success"){
								$("#viewFromDate").val($("#cost_occur_date_2_" + tmpVar).val());
						        newCostSearchForm.submit();
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}//function
				);//post
			});/* $(".delMyCost").click */

			$(".delMyCostAddition").click(function(){
				var tmpVar = $(this).attr("value");
				var r = confirm("해당 건을 삭제 하시겠습니까?");
				if (!r){
					return;
				}				
				if($("#hid_cost_aprv_state_addition" + tmpVar).val() != 0){
					alert("팀장 결재 이후 삭제할 수 없습니다. '결재 취소'를 하거나 결재자에게 '결재 취소'를 받으십시오.");
					return;					
				}	
				$.post("./myCostInsNewDelOK",
						{cost_no:$("#cost_no_addition"+tmpVar).val()
						,cost_occur_date:$("#cost_occur_date_addition"+tmpVar).val()},
						function(data,status){
							if(status == "success"){
// 								$("#viewFromDate").val($("#cost_occur_date").val());
						        newCostSearchForm.submit();
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}//function
				);//post
			});/* $(".delMyCost").click */			
			
			
			$(".udtMyCost").click(function(){
				var r = confirm("해당 건을 수정 하시겠습니까?");
				if (!r){
					return;
				}				
				var tmpVar = $(this).attr("value");
				if($("#hid_cost_aprv_state" + tmpVar).val() != 0){
					alert("팀장 결재 이후 수정할 수 없습니다. '결재 취소'를 하거나 결재자에게 '결재 취소'를 받으십시오.");
					return;
				}
				if($("#cost_occur_date"+tmpVar).val().trim() == ''){
					alert("날짜를 선택하세요.");
					$("#cost_occur_date"+tmpVar).focus();
					return;
				}
				if($("#cost_class_no"+tmpVar).val().trim() == ''){
					alert("계정명을 선택하세요.");
					$("#cost_class_no"+tmpVar).focus();
					return;
				}
				if($("#cost_pay_type"+tmpVar).val().trim() == ''){
					alert("구분을 선택하세요.");
					$("#cost_pay_type"+tmpVar).focus();
					return;
				}
				if($("#cost_bill_ea"+tmpVar).val().trim() == ''){
					alert("영수증 수를 입력하세요.");
					$("#cost_bill_ea"+tmpVar).focus();
					return;
				}
				if($("#cost_pay_amt"+tmpVar).val().trim() == ''){
					alert("금액을 입력하세요.");
					$("#cost_pay_amt"+tmpVar).focus();
					return;
				}
				if($("#cost_deposit_amt"+tmpVar).val().trim() == ''){
					$("#cost_deposit_amt"+tmpVar).val("0");
				}
				$.post("./newCostMbrUdtOK",
						{	cost_no								:$("#cost_no"+tmpVar).val()
							,cost_occur_date     			:$("#cost_occur_date"+tmpVar).val()
							,cost_class_no					:$("#cost_class_no"+tmpVar).val()
							,cost_pay_type  					:$("#cost_pay_type"+tmpVar).val()
							,cost_bill_ea   					:$("#cost_bill_ea"+tmpVar).val()
							,cost_pay_amt  					:removeCommaFunc( $("#cost_pay_amt"+tmpVar).val() )
							,cost_pay_place					:$("#cost_pay_place"+tmpVar).val()
							,cost_involved_com     			:$("#cost_involved_com"+tmpVar).val()
							,cost_involved_man      		:$("#cost_involved_man"+tmpVar).val()
							,cost_memo    					:$("#cost_memo"+tmpVar).val()
							,cost_deposit_amt  				:removeCommaFunc( $("#cost_deposit_amt"+tmpVar).val() )
							,team_id							:$("#team_id").val()
							,user_no								:$("#user_no").val()
							,cost_gubun_flag   				:1
						},
						function(data,status){
							if(status == "success"){
								alert("경비 내역 입력이 완료 되었습니다.");
								$("#viewFromDate").val($("#cost_occur_date" +tmpVar).val());
						        newCostSearchForm.submit();
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}//function
				);//post
			});//$(".udtMyCost").click
			
			$(".udtMyCost2").click(function(){
				var r = confirm("해당 건을 수정 하시겠습니까?");
				if (!r){
					return;
				}
				
				var tmpVar = $(this).attr("value");
				if($("#hid_cost_claim_aprv_state" + tmpVar).val() != 0){
					alert("팀장 결재 이후 수정할 수 없습니다. '결재 취소'를 하거나 결재자에게 '결재 취소'를 받으십시오.");
					return;
				}
				if($("#cost_occur_date_2_"+tmpVar).val().trim() == ''){
					alert("날짜를 선택하세요.");
					$("#cost_occur_date_2_"+tmpVar).focus();
					return;
				}
				if($("#cost_class_no_claim_2_"+tmpVar).val().trim() == ''){
					alert("계정명을 선택하세요.");
					$("#cost_class_no_claim_2_"+tmpVar).focus();
					return;
				}
				if($("#cost_pay_type_2_"+tmpVar).val().trim() == ''){
					alert("구분을 선택하세요.");
					$("#cost_pay_type_2_"+tmpVar).focus();
					return;
				}
				if($("#cost_bill_ea_2_"+tmpVar).val().trim() == ''){
					alert("영수증 수를 입력하세요.");
					$("#cost_bill_ea_2_"+tmpVar).focus();
					return;
				}
				if($("#cost_pay_amt_2_"+tmpVar).val().trim() == ''){
					alert("금액을 입력하세요.");
					$("#cost_pay_amt_2_"+tmpVar).focus();
					return;
				}
				if($("#cost_suim_accept_no_2_"+tmpVar).val().trim() == ''){
					alert("접수번호를 입력하세요.");
					$("#cost_suim_accept_no_2_"+tmpVar).focus();
					return;
				}
				if($("#cost_distance_2_"+tmpVar).val().trim() == ''){
					alert("거리를 입력하세요.");
					$("#cost_distance_2_"+tmpVar).focus();
					return;
				}
				if($("#cost_deposit_amt_2_"+tmpVar).val().trim() == ''){
					$("#cost_deposit_amt_2_"+tmpVar).val("0");
				}
				$.post("./newCostMbrUdtOK",
						{	cost_no								:$("#cost_no_2_"+tmpVar).val()
							,cost_occur_date     			:$("#cost_occur_date_2_"+tmpVar).val()
							,cost_class_no_claim			:$("#cost_class_no_claim_2_"+tmpVar).val()
							,cost_pay_type  					:$("#cost_pay_type_2_"+tmpVar).val()
							,cost_bill_ea   					:$("#cost_bill_ea_2_"+tmpVar).val()
							,cost_pay_amt  					:removeCommaFunc( $("#cost_pay_amt_2_"+tmpVar).val() )
							,cost_pay_place					:$("#cost_pay_place_2_"+tmpVar).val()
							,cost_involved_com     			:$("#cost_involved_com_2_"+tmpVar).val()
							,cost_involved_man      		:$("#cost_involved_man_2_"+tmpVar).val()
							,cost_memo    					:$("#cost_memo_2_"+tmpVar).val()
							,cost_deposit_amt  				:removeCommaFunc( $("#cost_deposit_amt_2_"+tmpVar).val() )
							,cost_suim_accept_no    		:$("#cost_suim_accept_no_2_"+tmpVar).val()
							,cost_distance    					:$("#cost_distance_2_"+tmpVar).val()
							,team_id							:$("#team_id").val()
							,user_no								:$("#user_no").val()
							,cost_gubun_flag   				:2
						},
						function(data,status){
							if(status == "success"){
								alert("경비 내역 입력이 완료 되었습니다.");
								$("#viewFromDate").val($("#cost_occur_date_2_" + tmpVar).val());
						        newCostSearchForm.submit();
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}//function
				);//post
			});//$(".udtMyCost").click

			$(".udtMyCostAddition").click(function(){
				var tmpVar = $(this).attr("value");
				var r = confirm("해당 건을 수정 하시겠습니까?");
				if (!r){
					return;
				}				
				if($("#hid_cost_aprv_state_addition" + tmpVar).val() != 0){
					alert("팀장 결재 이후 수정할 수 없습니다. '결재 취소'를 하거나 결재자에게 '결재 취소'를 받으십시오.");
					return;					
				}
				if($("#cost_occur_date_addition"+tmpVar).val().trim() == ''){
					alert("날짜를 선택하세요.");
					$("#cost_occur_date"+tmpVar).focus();
					return;
				}
				if($("#cost_class_no_addition"+tmpVar).val().trim() == ''){
					alert("계정명을 선택하세요.");
					$("#cost_class_no"+tmpVar).focus();
					return;
				}
				if($("#cost_pay_type_addition"+tmpVar).val().trim() == ''){
					alert("구분을 선택하세요.");
					$("#cost_pay_type"+tmpVar).focus();
					return;
				}
				if($("#cost_bill_ea_addition"+tmpVar).val().trim() == ''){
					alert("영수증 수를 입력하세요.");
					$("#cost_bill_ea"+tmpVar).focus();
					return;
				}
				if($("#cost_pay_amt_addition"+tmpVar).val().trim() == ''){
					alert("금액을 입력하세요.");
					$("#cost_pay_amt"+tmpVar).focus();
					return;
				}
				if($("#cost_deposit_amt_addition"+tmpVar).val().trim() == ''){
					$("#cost_deposit_amt_addition"+tmpVar).val("0");
				}
				$.post("./newCostMbrUdtOK",
						{	cost_no								:$("#cost_no_addition"+tmpVar).val()
							,cost_occur_date     			:$("#cost_occur_date_addition"+tmpVar).val()
							,cost_apply_date     			:$("#cost_apply_date_addition"+tmpVar).val()
							,cost_class_no					:$("#cost_class_no_addition"+tmpVar).val()
							,cost_pay_type  					:$("#cost_pay_type_addition"+tmpVar).val()
							,cost_bill_ea   					:$("#cost_bill_ea_addition"+tmpVar).val()
							,cost_pay_amt  					:removeCommaFunc( $("#cost_pay_amt_addition"+tmpVar).val() )
							,cost_pay_place					:$("#cost_pay_place_addition"+tmpVar).val()
							,cost_involved_com     			:$("#cost_involved_com_addition"+tmpVar).val()
							,cost_involved_man      		:$("#cost_involved_man_addition"+tmpVar).val()
							,cost_memo    					:$("#cost_memo_addition"+tmpVar).val()
							,cost_deposit_amt  				:removeCommaFunc( $("#cost_deposit_amt_addition"+tmpVar).val() )
							,team_id							:$("#team_id").val()
							,user_no								:$("#user_no").val()
							,cost_gubun_flag   				:3
						},
						function(data,status){
							if(status == "success"){
								alert("경비 내역 입력이 완료 되었습니다.");
								$("#viewFromDate").val($("#cost_apply_date_addition"+tmpVar).val());
						        newCostSearchForm.submit();
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}//function
				);//post
			});//$(".udtMyCost").click
			
			$("#select_class_no").change(function(){
		        newCostSearchForm.submit();
			});

		});//$(document).ready

		/* 협조건 내역 상세보기 */
		function viewhelpbtn(serial_no){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('helpRptBscDtl?serialNo='+serial_no+'&viewFromDate='+$("#viewFromDate").val()+'&viewToDate='+$("#viewToDate").val(),'_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}//viewhelpbtn

		/* 보고서 원본파일 삭제 */
		function MyCostBillOrgFileDel(serialNo){
			if(confirm("보고서 원본 파일을 삭제하시겠습니까?")){
				$.post("./myCostBillFileDel",
						{serialNo 	:	serialNo},
						function(data,status){
							if(status == "success"){
								if(data != 0){
									$("#myCostBillFileOrgTr_"+serialNo).css("display","none");
									$("#viewFromDate").val($("#cost_occur_date").val());
							        newCostSearchForm.submit();
// 									window.location.reload();
								}else{
									alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");	
								}
							}else{
								alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");
							}
						}
					);
				}
			}//MyCostBillOrgFileDel

			function goNewCostTmList(){
				newCostSearchForm.action = "./getNewCostTmList";
				newCostSearchForm.submit();
			}
			
			
			function goCostTmAprv(aprvCode, stateNo, aprvNo){
					$.post("./newCostTmAprv",
						{	aprvCode  			:aprvCode
							,stateNo   			:stateNo
							,aprvNo   			:aprvNo
							,user_no   			:$("#user_no").val()
							,viewFromDate		:$("#viewFromDate").val()
							,viewToDate			:$("#viewToDate").val()
							,stateGubun			:1
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
// 									$("#viewFromDate").val($("#cost_occur_date").val());
							        newCostSearchForm.submit();									
// 									window.location.reload();
								}//else
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}//else
						}//function
					);//post
			}//function goCostAprvChg
			
			function goCostTmAprv2(aprvCode, stateNo, aprvNo){
				$.post("./newCostTmAprv",
					{	aprvCode  			:aprvCode
						,stateNo   			:stateNo
						,aprvNo   			:aprvNo
						,user_no   			:$("#user_no").val()
						,viewFromDate		:$("#viewFromDate").val()
						,viewToDate			:$("#viewToDate").val()
						,stateGubun			:2
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
// 								$("#viewFromDate").val($("#cost_occur_date_2").val());
						        newCostSearchForm.submit();
// 								window.location.reload();
							}//else
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}//else
					}//function
				);//post
		}//function goCostAprvChg
		
		function goCostTmAprv3(aprvCode, stateNo, aprvNo){
			$.post("./newCostTmAprv",
				{	aprvCode  				:aprvCode
					,stateNo   				:stateNo
					,aprvNo   				:aprvNo
					,user_no   				:$("#user_no").val()
					,viewFromDate		:$("#viewFromDate").val()
					,viewToDate			:$("#viewToDate").val()
					,stateGubun			:3
				},
				function(data,status){
					if(status == "success"){
						if(data == 0){
							alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
						}else{
// 							$("#viewFromDate").val($("#cost_apply_date_addition").val());
					        newCostSearchForm.submit();
// 							window.location.reload();
						}//else
					}else{
						alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
					}//else
				}//function
			);//post
	}//function goCostAprvChg
		
	function fnSelectgubun(idx){
		$("#tab_code").val(idx);
	}
	</script>

</head>

<body>

<!-- wrapper -->
<div id="wrapper">

	<!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>
	<!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns">
			<div class="center_cnt_1300">

				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">

							<div style="float: left;">
								<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0">
								&nbsp;<b>${inVO.team_name} ${inVO.user_name} 경비내역</b>
							</div>

							<div style="text-align: right;">
								<img id="yearprev" src="./resources/ne_img/icon_prev.gif" width="17" height="13" border="0">
								<a id="yeartxt" href="#">${inVO.viewToDate.substring(0,4)}</a>
								<img id="yearnext" src="./resources/ne_img/icon_next.gif" width="17" height="13" border="0">
								<c:forEach var="i" begin="1" end="12" step="1" varStatus="">
									<input id="${i}" class="monthbtn" type="button" value="${i}월" />
								</c:forEach>
								<input type="button" value="뒤로가기"
										onclick="javascript:goNewCostTmList();" />
							</div>

							<form name="newCostSearchForm" id="newCostSearchForm" method="GET" action="./getNewCostMbrList">
								<b>${inVO.viewFromDate}</b>
								<b><font color="#0066CC">부터</font></b>&nbsp;&nbsp;
								<b>${inVO.viewToDate}</b>
								<b><font color="#0066CC">까지</font></b>&nbsp;&nbsp;
								<input	type="hidden" id="viewFromDate" name="viewFromDate" value="${inVO.viewFromDate}"
										size="10" maxlength="10" readonly style="background-color:lightgrey;" />
								<input	type="hidden" id="viewToDate"  name="viewToDate" value="${inVO.viewToDate}"
										size="10" maxlength="10" readonly style="background-color:lightgrey;" />
								<input type="hidden" id="user_no" name="user_no" value="${inVO.user_no}" />
								<input type="hidden" id="user_name" name="user_name" value="${inVO.user_name}" />
								<input type="hidden" id="team_id" name="team_id" value="${inVO.team_id}" />
								<input type="hidden" id="team_name" name="team_name" value="${inVO.team_name}" />
								<input type="hidden" id="team_type" name="team_type" value="${inVO.team_type}" />
								<input type="hidden" id="srch_flag" name="srch_flag" value="${srch_flag}"/>
								<input type="hidden" id="tab_code" name="tab_code" value="${srchArg.tab_code}"/>
							</form>

							<p style="display: inline; float: right;">
								<a id="btn_excel" href="#noloc"><img src="./resources/ls_img/btn_excel.gif"></a>&nbsp;&nbsp;&nbsp;&nbsp;
								<img id="printMyCost" style = "cursor:pointer; float:right;" src="./resources/ls_img/icon_print.gif"/>
							</p>

							<br/>

						</div>
					</div>
				</div><!-- //centercnt_top -->

				<div class="center_cnt_1300_bot" >
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on" id="tab1" onclick="fnSelectgubun(1);">
									<a href="#" >경비내역</a>
								</li>
								<li class="" id="tab2" onclick="fnSelectgubun(2);">
									<a href="#" >추가경비내역</a>
								</li>
								<li class="" id="tab3" onclick="fnSelectgubun(3);">
									<a href="#">클레임 교통비 내역</a>
								</li>
							</ul>
							<div class="guestcnt4" style="display:block;">
								<c:import url="./new_cost_mbr_list_1.jsp"></c:import>
							</div>
							<div class="guestcnt4" style="display:none;">
								<c:import url="./new_cost_mbr_list_2.jsp"></c:import>
							</div>
							<div class="guestcnt4" style="display:none;">
								<c:import url="./new_cost_mbr_list_3.jsp"></c:import>
							</div>							
						</div>
					</div><!-- //guest -->
				</div><!-- centercnt_bot2 -->

			</div><!-- //center_cnt -->
		</div><!-- //contents -->
	</div><!-- //container -->

	<!-- footer -->
	<c:import url="../top_statistics/statistics_footer.jsp"></c:import>
	<!-- //footer -->

</div>
<!-- //wrapper -->

</body>

</html>
