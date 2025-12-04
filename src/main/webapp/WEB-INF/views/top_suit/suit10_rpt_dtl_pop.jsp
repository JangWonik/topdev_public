<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>보고서 상세</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<!-- 
	<%--<script src="./resources/daum/161109.js"></script>--%>
	<script src="./resources/daum/postcode.v2.js"></script>
	<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script> -->

	<script>
	
		$(document).ready(function(){
			
			if ( "${suimSuit_10Vo.editYN2}" < 1 ){
				alert("접근 권한이 없습니다.");
				window.close();
				return false;
			}

			/* 조사 조기값 셋팅 시작*/
			$("input:radio[name='report1']:radio[value='${suimSuit_10Vo.report1}']").prop('checked', true);
			$("input:radio[name='report2']:radio[value='${suimSuit_10Vo.report2}']").prop('checked', true);
			$("input:radio[name='report3']:radio[value='${suimSuit_10Vo.report3}']").prop('checked', true);
			$("input:radio[name='report4']:radio[value='${suimSuit_10Vo.report4}']").prop('checked', true);
			$("input:radio[name='report5']:radio[value='${suimSuit_10Vo.report5}']").prop('checked', true);
			$("input:radio[name='report6']:radio[value='${suimSuit_10Vo.report6}']").prop('checked', true);
			$("input:radio[name='report7']:radio[value='${suimSuit_10Vo.report7}']").prop('checked', true);
			$("input:radio[name='report8']:radio[value='${suimSuit_10Vo.report8}']").prop('checked', true);
			$("input:radio[name='report9']:radio[value='${suimSuit_10Vo.report9}']").prop('checked', true);
			$("input:radio[name='report11']:radio[value='${suimSuit_10Vo.report11}']").prop('checked', true);
			/* 조사 조기값 셋팅 끝*/
			
			$(".inputJosaClass10").hide();
			
			$("#josaEditeBtn").click(function(){
				
				if("${suimSuit_10Vo.suimRptState}" != 0 && "${suimSuit_10Vo.suimRptState}" != 11 && ("${mbrVo_Session.user_no}" != "4") && ("${mbrVo_Session.user_no}" != "1117") ){
					alert("상신 이후 수정할 수 없습니다. '상신 취소'를 하거나 결재자에게 '결재 취소'를 받으십시오.");
					return;
				}
				
				if("${suimSuit_10Vo.delDate}" > 0){
					alert("삭제된 보고서는 수정할 수 없습니다.");
					return;
				}
				
				$("#josaEditeBtn").hide();
				$("#rptEditeBtn").hide();
				$("#josaEditeCancelBtn").show();
				$("#josaEditeOkBtn").show();
				
				$(".spanJosaClass10").hide();
				$(".inputJosaClass10").show();
			});
			
			$("#rptEditeBtn").click(function(){
				
				if("${suimSuit_10Vo.delDate}" > 0){
					alert("삭제된 보고서는 수정할 수 없습니다.");
					return;
				}
				
				if("${suimSuit_10Vo.suimRptState}" != 0 && "${suimSuit_10Vo.suimRptState}" != 11 && ("${mbrVo_Session.user_no}" != "1305") && ("${mbrVo_Session.user_no}" != "1337") && ("${mbrVo_Session.user_no}" != "1117")){
					alert("상신 이후 수정할 수 없습니다. '상신 취소'를 하거나 결재자에게 '결재 취소'를 받으십시오.");
					return;
				}
				
				rpt10EditePop('${suimSuit_10Vo.suimRptNo}');
			});
			
			$("#josaEditeCancelBtn").click(function(){
				$("#rptEditeBtn").show();
				$("#josaEditeBtn").show();
				$("#josaEditeCancelBtn").hide();
				$("#josaEditeOkBtn").hide();
				
				$(".spanJosaClass10").show();
				$(".inputJosaClass10").hide();
				
			});
			
			$("#rptEditeCancelBtn").click(function(){
				$("#rptEditeBtn").show();
				$("#josaEditeBtn").show();
			});
			
			/* 조사 수정 완료 */
			$("#josaEditeOkBtn").click(function(){
				
				var r1 = $("input:radio[name='report1']:checked").val();
				var r2 = $("input:radio[name='report2']:checked").val();
				var r3 = $("input:radio[name='report3']:checked").val();
				var r4 = $("input:radio[name='report4']:checked").val();
				var r5 = $("input:radio[name='report5']:checked").val();
				var r6 = $("input:radio[name='report6']:checked").val();
				var r7 = $("input:radio[name='report7']:checked").val();
				var r8 = $("input:radio[name='report8']:checked").val();
				var r9 = $("input:radio[name='report9']:checked").val();
				var r10 = $("#report10").val();
				var r11 = $("input:radio[name='report11']:checked").val();
				
				
				$.post("./josaEditeOk",
						
						{	 
							 suimRptNo	         	:'${suimSuit_10Vo.suimRptNo}'
							,report1 	        	:r1
							,report2 	        	:r2
							,report3 	        	:r3
							,report4 	        	:r4
							,report5 	        	:r5
							,report6 	        	:r6
							,report7 	        	:r7
							,report8 	        	:r8
							,report9 	        	:r9
							,report10 	        	:$.trim(r10)
							,report11 	        	:r11
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									alert("저장되었습니다.");
									
									/* 버튼 처리 */
									$("#rptEditeBtn").show();
									$("#josaEditeBtn").show();
									$("#josaEditeCancelBtn").hide();
									$("#josaEditeOkBtn").hide();
									
									$(".spanJosaClass10").show();
									$(".inputJosaClass10").hide();
									
									/* 수정된 값 셋팅 */
									$("#spanIdReport1").html(getValForJosa1(r1));
									$("#spanIdReport2").html(getValForJosa2(r2));
									$("#spanIdReport3").html(getValForJosa3(r3));
									$("#spanIdReport4").html(getValForJosa45678911(r4));
									$("#spanIdReport5").html(getValForJosa45678911(r5));
									$("#spanIdReport6").html(getValForJosa45678911(r6));
									$("#spanIdReport7").html(getValForJosa45678911(r7));
									$("#spanIdReport8").html(getValForJosa45678911(r8));
									$("#spanIdReport9").html(getValForJosa45678911(r9));
									$("#spanIdReport10").html(r10);
									$("#spanIdReport11").html(getValForJosa45678911(r11));
									
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}//function
				);//post
			});
			
			/* 워드다운 */
			$("#suit10Word").click(function(){
				/*
				//박우현				
				if("${suimSuit_10Vo.suimRptState}" == 2 && "${mbrVo_Session.user_no}" != 4 && "${mbrVo_Session.user_no}" != 1877 && "${mbrVo_Session.user_no}" != 2411 && "${mbrVo_Session.user_no}" != 2586 && "${mbrVo_Session.user_no}" != 2941 && "${mbrVo_Session.user_no}" != 1305 && "${mbrVo_Session.user_no}" != 1337 && "${mbrVo_Session.user_no}" != 2079){
					alert("종결건은 워드전환이 불가능합니다.\n인보험기획팀에 문의하세요.");
					return;
				}
				
				suit10Word("${suimSuit_10Vo.suimRptNo}");
				*/
				
				var url = "suitWorkAuthChk";
				
				var param = {};
				
				param.suim_rpt_state = "${suimSuit_10Vo.suimRptState}";				//보고서 종결상태
				
				$.ajax({
		       	        type: "POST",
		       	        url: url,
		       	        data: param,
		       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		       	        timeout: 20000,
		       	        async: false,
		       	        dataType: "html", 
		       	        success: function(data){
		       	        	
		       	        	if (data == 1){			//권한이 있는 경우
		       	        		suit10Word("${suimSuit_10Vo.suimRptNo}");
		       	        	}else if(data == 9){	//종결로인해 전환이 불가능한 경우
		       	        		alert("종결건은 워드전환이 불가능합니다.\n인보험기획팀에 문의하세요.");    		
		       	        	}else{
		       	        		alert("워드전환 권한이 없습니다.\n인보험기획팀에 문의하세요.");
		       	        	}
		       	        	
		       	        }
		       	    });
			});
			
			/* 응답전문 */
			$("#suit10Rs").click(function(){
				
				if("${suimSuit_10Vo.suimRptState}" != 2){
					alert("종결건만 가능합니다.");
					return;
				}
				
				suit10Rs("${suimSuit_10Vo.suimRptNo}");
			});
			
			$("#suimTmMbrPopBtn").click(function(){//담당 팀, 담당 직원 바꾸기 팝업
				var cw=screen.availWidth;
				var ch=screen.availHeight;
				var sw=500; //띄울 창의 넓이
				var sh=550;  //띄울 창의 높이
				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
				window.open('suimTmMbrPop?gbNo='+$("#gbNoForPop").val()+'&smNo='+$("#smNoForPop").val()+'&tmNo='+$("#tmNoForPop").val(),'SuimTmMbrPop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			});//$("#suimTmMbrPopBtn").click
			
			//적부 보안데이터 팝업창 버튼
			$(".popView").click(function(){
				
				var param = {};
				param.suimRptNo = $(this).attr("suimRptNo");
				param.ptnrId	= $(this).attr("ptnrId");
				param.target	= $(this).attr("target");
				param.suitFlag	= "10";
				
		        var url = "./getContractInfo";

		        $.ajax({
		            type: "POST",
		            url: url,
		            data: param,
		            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		            dataType: "json",
		            timeout: 20000,
		            success: function(data){
		                if(data.result == "0000"){
		     				$("#secuDataHead").html(data.title);
		     				$("#secuDataContent").html(data.contents);
		     				
		     				fnOpenSecuData();
		                }else{
		                	alert("입력된 데이터가 없습니다.");
		                }
		            },
		            error: function(e){
		                alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		            }
		        });
// 				var suimRptNo = $(this).attr("suimRptNo");
// 				var ptnrId= $(this).attr("ptnrId");
// 				var target = $(this).attr("target");
// 				var suitFlag = $(this).attr("suitFlag"); 
				
// 				var cw=screen.availWidth;
// 				var ch=screen.availHeight;
// 				var sw=540; //띄울 창의 넓이
// 				var sh=160;  //띄울 창의 높이
// 				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
// 				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
//  				window.open('getContractInfo?suimRptNo='+suimRptNo+'&ptnrId='+ptnrId+'&target='+target+'&suitFlag='+suitFlag,'_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+'scrollbars=no,resizable=no');
			});
		}); //document.ready
		
		function fnOpenSecuData(){
			$("#secu-dialog").dialog({
				height: 200,
				width: 500,
				closeOnEscape : true,
				draggable : false,
				buttons:{
					"취소" : function(){
						$(this).dialog("close");
					}
				},
				modal: true,
				overlay:{ opacity: 0., background: '#000000'}
			});
		}

		function suit10Rs(suimRptNo){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('suit10Rs?suim_rpt_no='+suimRptNo,'rptEditePop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}//suit10Rs
		
		function suit10Word(suimRptNo){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('suit10Word?suim_rpt_no='+suimRptNo,'rptEditePop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}//suit10Word
		
		
		function getValForJosa45678911(obj){
			
			var str ='';
			
			if(obj == '1'){
				str = '일치';
			}else if(obj == '2'){
				str = '불일치';
			}else if(obj == '3'){
				str = '미확인';
			}
			return str;
		}
		
		function getValForJosa1(obj){
			
			var str ='';
			
			if(obj == '01'){
				str = '조사완료';
			}else if(obj == '02'){
				str = '조사실패';
			}
			return str;
		}
		
		function getValForJosa2(obj){
			
			var str ='';
			
			if(obj == '00'){
				str = '정상';
			}else if(obj == '01'){
				str = '전화연락 안됨(3회이상)';
			}else if(obj == '02'){
				str = '방문 자체에 불만표시';
			}else if(obj == '03'){
				str = '방문은 허용하였으나 조사에 불만표시';
			}else if(obj == '04'){
				str = 'RC거절';
			}else if(obj == '05'){
				str = '기타';
			}
			
			return str;
		}
		
		function getValForJosa3(obj){
			
			var str ='';
			
			if(obj == '1'){
				str = '전부일치';
			}else if(obj == '2'){
				str = '일부일치';
			}else if(obj == '9'){
				str = '조사실패';
			}
			return str;
		}
		
		function rpt10EditePop(suimRptNo){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('rpt10EditePop?suim_rpt_no='+suimRptNo,'rptEditePop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}//rptEdite
		
		function openSMS(hpNo){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=380; //띄울 창의 넓이
			var sh=533;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('simpleSMSForm?hpNo='+hpNo,'simpleSMS','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}//openSMS
		
		function subEndPass(){
			/* var r1 = "${suimSuit_10Vo.report1}"; 
			var r2 = "${suimSuit_10Vo.report2}";
			var r3 = "${suimSuit_10Vo.report3}";
			var r4 = "${suimSuit_10Vo.report4}";
			var r5 = "${suimSuit_10Vo.report5}";
			var r6 = "${suimSuit_10Vo.report6}";
			var r7 = "${suimSuit_10Vo.report7}";
			var r8 = "${suimSuit_10Vo.report8}";
			var r9 = "${suimSuit_10Vo.report9}";
			var r10 = "${suimSuit_10Vo.report10}";
			var r11 = "${suimSuit_10Vo.report11}"; */
			
			var r1 = $("#spanIdReport1").html();
			var r2 = $("#spanIdReport2").html();
			var r3 = $("#spanIdReport3").html();
			var r4 = $("#spanIdReport4").html();
			var r5 = $("#spanIdReport5").html();
			var r6 = $("#spanIdReport6").html();
			var r7 = $("#spanIdReport7").html();
			var r8 = $("#spanIdReport8").html();
			var r9 = $("#spanIdReport9").html();
			var r10 = $("#spanIdReport10").html();
			var r11 = $("#spanIdReport11").html();
			
			
			/* 처리 결과가 미완일 경우 결재 불가 */
			if( (r1 == '') || (r2 == '') ||(r3 == '') ||(r4 == '') ||(r5 == '') ||
					(r6 == '') ||(r7 == '') ||(r8 == '') ||(r9 == '') ||(r10 == '') ||(r11 == '') ){
				alert("결재 불가 : 처리 결과가 완전하지 않습니다.");
				return false;
			}else{
				return true;
			}
			
			/* 조사 완료 상태 -> 방문승낙, 거절 사유 가 비정상 or 조사 실패일 경우 결재 불가 */
			if( (r1 == '01') && ( (r2 !='00') || (r3 =='9') )){
				alert("조사완료 되었으나 방문승낙,거절사유가 정상이 아니거나 조사실패 입니다.!!!");
				return false;
			}else{
				return true;
			}
			
			/* 조사 실패 상태 -> 방문승낙, 거절 사유 가 비정상 or 조사 실패일 경우 결재 불가 */
			if( (r1 == '02') && ( (r2 =='00') || (r3 !='9') )){
				alert("조사실패 되었으나 방문승낙,거절사유가 정상이거나 조사실패가 아닙니다.!!!");
				return false;
			}else{
				return true;
			}
			
			/* 조사 결과가 전부 일치가 아님*/
			if( (r3 == '1') && ( (r4 != '1') || (r5 != '1') || (r6 != '1') || (r7 != '1') || (r8 != '1') || (r9 != '1') ||
					(r11 != '1') ) ){
				alert("조사결과 전부일치가 아닙니다.!!!");
				return false;
			}else{
				return true;
			}
			
			/* 조사 결과가 전부 일치가 아님*/
			if( (r3 != '1') && (r4 == '1') && (r5 == '1') && (r6 == '1') && (r7 == '1') && (r8 == '1') && (r9 == '1') &&
					(r11 == '1') ){
				alert("조사결과 전부일치가 아닙니다.!!!");
				return false;
			}else{
				return true;
			}
			
			if( !( ( (r1 =='02') && r2 && (r3 =='9') ) ||  
				( r1 && r2 && r3 && r4 && r5 && r6 && r7 && r8 && r9 && r10 )	)){
				
				alert("처리 결과가 완전하지 않습니다.");
				return false;
			}else{
				return true;
			}
		}
		
		/* 보고서 결재 동작 시작 */
		function action_report(action){
			
			if(action =='end') {
				if(!confirm("종결 하시겠습니까?")){
					return;
				}	
			}else if(action =='returnRpt'){
				if(!confirm("반려 하시겠습니까?")){
					return;
				}
			}else if(action =='return_x'){
				if(!confirm("반려건을 재결재 하시겠습니까?")){
					return;
				}
			}else if(action =='submit_x'){
				if(!confirm("결재 상신을 취소 하시겠습니까?")){
					return;
				}
			}else if(action =='submit'){
				if(!confirm("결재를 올리겠습니까?")){
					return;
				}
			}else if(action == 'submit_e_x'){
				if(!confirm("종결 취소하시겠습니까?")){
					return;
				}
			}else if(action == 'report_del'){
				if(!confirm("보고서를 삭제 하시겠습니까?")){
					return;
				}
			}else if(action == 'cancel'){
				if(!confirm("위임 취소 하시겠습니까?")){
					return;
				}
			}else if(action == 'cancel_x'){
				if(!confirm("위임 취소를 취소 하시겠습니까?")){
					return;
				}
			}
			
			if(action == 'submit'){ /* 결재하기 시작 */
				
				if(!subEndPass()){
					return;	
				}
				
			}else if(action == 'end'){ /* 종결하기 시작 */
				
				if(!subEndPass()){
					return;	
				}
			}
			
			/* 결재 취소 submit_x : 유효 검사 없음 */
			/* 반려하기 returnRpt : 유효 검사 없음 */
			
			$.post("./actionSuit10ReportOk",
					{	
						 action  		:action
				 		,suimRptNo   	:"${suimSuit_10Vo.suimRptNo}"  
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("실패하였습니다. 관리자에게 문의해 주세요.");
							}else if(data ==1){
								
								if(action == 'submit'){
									alert("결재 완료 하였습니다.");
								}else if(action == 'submit_x'){
									alert("결재 취소 하였습니다.");
								}else if(action == 'returnRpt'){
									alert("반려 하였습니다.");
								}else if(action == 'return_x'){
									alert("재결재 하였습니다.");
								}else if(action == 'end'){
									alert("종결 하였습니다.");
								}else if(action == 'submit_e_x'){
									alert("종결 취소 하였습니다.");
								}else if(action == 'cancel'){
									alert("위임 취소 하였습니다.");
								}else if(action == 'cancel_x'){
									alert("위임 취소를 취소 하였습니다. 최초 수임 상태로 되돌아갑니다.");
								}else if(action == 'report_del'){
									alert("보고서를 삭제하였습니다.");
								}
							}
							window.opener.location.reload();	
							location.reload();								
							
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
		
		/* 보고서 결재 동작 끝 */
		}
		
		
	</script>
	<style>
		.tableStyle2 td{
			letter-spacing: 0px !important;
		}
		
		.ui-button-text-only {
			height:2.1em !important;
		}
		.ui-widget-overlay{
			opacity: 1.0;
			background: '#000000'
		}
	</style>

</head>

<body>
	<input type="hidden" name="gbNoForPop" id="gbNoForPop" value="310" />
	<input type="hidden" name="ptnrNoForPop" id="ptnrNoForPop" value="${suimSuit_10Vo.ptnrId}" />
	<input type="hidden" name="smNoForPop" id="smNoForPop" value="${suimSuit_10Vo.suimRptNo}" />
	<input type="hidden" name="tmNoForPop" id="tmNoForPop" value="${suimSuit_10Vo.teamId}" />
	<!-- header --><!--2016.01.14.rjh.수정.교체.-->
	<div id="headerpop_mbr">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="40" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> 장기 물보험 적부 시스템 - KB</span></b></font>
			</div>
		</div>
	</div>
	<!-- //header -->

	<!-- center -->
	<div id ="container">
		<div class="contetnsPop">
			<div class="center_cnt">
				<div class="centercnt_bot1-3">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on" id="rptBase"><a href="#">보고서 기본정보</a></li>
								<li><a href="#">Todo : 로그 열람</a></li>
							</ul>
						</div>

						<div class="guestcnt5" style="display:block;">

							<div class= "tableStyle6">
								<input type="hidden" id = "suimRptNo" value= "${suimSuit_10Vo.suimRptNo}"/>
								<input type="hidden" id = "suimRptTopTm" value= "${suimSuit_10Vo.teamId}"/>
								
								<table align="center" style = "margin-top:10px;" >
								
									<colgroup>
										<col width="25%">
										<col width="30%">
										<col width="15%">
										<col width="30%">
									</colgroup>
									<tr>
										<td colspan="2" align="left" style="border-right:0px;">
											<b> 보고서 기본 정보</b>
										</td>
										<td colspan="2" align="right" style="border-left:0px;" >
											<c:choose>
												<c:when test="${suimSuit_10Vo.delDate != 0 }">
													<font color="red"><b>※ 삭제된 보고서 입니다.</b></font>
												</c:when>
												<c:otherwise>
													<!-- 결재하기 -->
													<c:if test="${suimSuit_10Vo.suimRptState eq '0'}"> <!-- $_a_work5_w -->
														<c:if test="${suimSuit_10Vo.editYN2 > 0 or (mbrVo.user_no eq '1337' or mbrVo.user_no eq '1305') }">
															<img src="./resources/ls_img/report/btn_rch_1.gif" onclick="action_report('submit');" style="cursor:pointer;"/>
														</c:if>
													</c:if>
													
													<!-- 결재취소하기 -->
													<c:if test="${suimSuit_10Vo.suimRptState eq '1'}"> <!-- $_a_work6_w -->
														<c:if test="${suimSuit_10Vo.editYN2 > 0 or (mbrVo.user_no eq '1337' or mbrVo.user_no eq '1305') }">
															<img src="./resources/ls_img/report/btn_rch_1x.gif" onclick="action_report('submit_x');" style="cursor:pointer;"/>
														</c:if>
														
														<c:if test="${suimSuit_10Vo.suimRptState eq '11'}"> <!-- 반려건인지 확인 -->
															<c:if test="${suimSuit_10Vo.editYN2 > 0 or (mbrVo.user_no eq '1337' or mbrVo.user_no eq '1305') }">
																<img src="./resources/ls_img/report/btn_rch_return_x.gif" onclick="action_report('return_x');" style="cursor:pointer;"/>												
															</c:if>
														</c:if>																										
													</c:if>
													
													<c:if test="${suimSuit_10Vo.suimRptState eq '11'}">
														<c:if test="${mbrVo.user_no eq suimSuit_10Vo.userNo }">
															<img src="./resources/ls_img/report/btn_rch_1x.gif" onclick="action_report('submit_x');" style="cursor:pointer;"/>
															<img src="./resources/ls_img/report/btn_rch_return_x.gif" onclick="action_report('return_x');" style="cursor:pointer;"/>	
														</c:if>
													</c:if>
													
													<!-- 종결하기 -->
													<c:if test="${suimSuit_10Vo.suimRptState eq '1'}"> <!-- 건상태가 진행중이면 -->
														<c:if test="${mbrVo.user_no eq '1337' or mbrVo.user_no eq '1305'}" >
<%-- 														<c:if test="${suimSuit_10Vo.suimRptAprvUserNo eq mbrVo.user_no}"> <!-- and mbrAuthSessionVo.mbr_pms_4 eq '1'  --> --%>
															<img src="./resources/ls_img/report/btn_rch_return.gif" border=0 onclick="action_report('returnRpt');" style="cursor:pointer;"/>
															<img src="./resources/ls_img/report/btn_rch_2.gif" border=0 onclick="action_report('end');" style="cursor:pointer;"/>
														</c:if>
													</c:if>
													
													<!-- 종결취소하기 -->
													<c:if test="${suimSuit_10Vo.suimRptState eq '2'  }"> <!-- and suimSuit_10Vo.suimRptAprvUserNo eq mbrVo.user_no --> <!-- and mbrAuthSessionVo.mbr_pms_4 eq '1' -->
														<c:if test="${mbrVo.user_no eq '1337' or mbrVo.user_no eq '1305'}" >
															<img src="./resources/ls_img/report/btn_rch_2x.gif" border=0 onclick="action_report('submit_e_x');" style="cursor:pointer;"/>
														</c:if>
													</c:if>	
													
													<!-- 위임취소하기 -->
													<c:if test="${suimSuit_10Vo.suimRptState ne '3' and suimSuit_10Vo.suimRptState ne '4' and suimSuit_10Vo.suimRptState ne '2' and  mbrAuthVo.mbr_pms_4 eq '1' }">
														<img src="./resources/ls_img/report/btn_rch_3.gif" border=0 onclick="action_report('cancel');" style="cursor:pointer;"/>
													</c:if>
													
													<!-- 위임취소하기를 취소하기 -->
													<c:if test="${suimSuit_10Vo.suimRptState eq '3' and mbrAuthVo.mbr_pms_4 eq '1' }">
														<img src="./resources/ls_img/report/btn_rch_3x.gif" border=0 onclick="action_report('cancel_x');" style="cursor:pointer;"/>
													</c:if>
													
													<!-- 보고서 삭제하기 -->
													<c:if test="${suimSuit_10Vo.suimRptState ne '2' and mbrAuthVo.mbr_pms_3 eq '1'}">
														<img src="./resources/ls_img/report/btn_report_del.gif" border=0 onclick="action_report('report_del');" style="cursor:pointer;"/>
													</c:if>
													
													<!-- 세금계산서 발행 -->
													<%-- <c:if test="${mbrVo.team_id_main eq suimSuit_10Vo.teamId and suimInvVO.taxNo ne null and suimInvVO.taxNo ne '' and suimSuit_10Vo.issueTaxInvoice eq 1}">
														<img src="./resources/ls_img/report/btn_tax.gif" border=0 onclick="taxPop('${suimInvVO.rptInvNo}');" style="cursor:pointer;"/>
													</c:if> --%>
												</c:otherwise>
											</c:choose>
											
												
										</td>
										<!-- 보고서 상태 값 변경 관리 끝 -->
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ접수번호</b></td>
										<td colspan="3">
											${suimSuit_10Vo.suimAcceptNo}
										</td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ처리팀</b></td>
										<td>${suimSuit_10Vo.teamName}</td>
										<td bgcolor="#E7ECF1"><b>ㆍ처리 담당자</b></td>
										<td >
											<c:if test="${suimSuit_10Vo.mbrChgYN > '0'}">
												<img src="./resources/ls_img/report/icon_change.gif" id="suimTmMbrPopBtn" style="cursor:pointer;" border="0" width="14" height="14">
											</c:if>
											${suimSuit_10Vo.userName}
											<c:if test="${suimSuit_10Vo.handphone != ''}">
												&nbsp;<img src="./resources/ls_img/report/icon_hp.gif" style="cursor:pointer;" onclick="openSMS('${suimSuit_10Vo.handphone}');" />
												${suimSuit_10Vo.handphone}
											</c:if>
										</td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ보험사</b></td>
										<td colspan="3">
											${suimSuit_10Vo.ptnrName}
										</td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ조사내용</b></td>
										<td >
											<c:if test="${suimSuit_10Vo.editYN2 > 0}">
												<img src="./resources/ls_img/report/icon_contract_josa.gif" id="josaEditeBtn" style="cursor:pointer; margin-right:5px;" border="0" >
												<img src="./resources/ls_img/report/icon_contract_report.gif" id="rptEditeBtn" style="cursor:pointer;" border="0" >
											</c:if>
											<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "josaEditeCancelBtn" style="display:none; cursor:pointer; " />
											<img src="./resources/ls_img/icon_write.gif" title="저장" id = "josaEditeOkBtn" style=" display:none; cursor:pointer; margin-right:5px;" />
										</td>
										<td bgcolor="#E7ECF1"><b>ㆍ처리결과</b></td>
										<td style="text-align:center;">
										
<%-- 											<c:if test="${mbrAuthVo.mbr_pms_19 == 1}"> --%>
												<img src="./resources/ls_img/report/icon_word.gif" id="suit10Word" style="cursor:pointer; margin-right:5px;" border="0" >
<%-- 											</c:if> --%>
<%-- 											<c:if test="${mbrAuthVo.mbr_pms_20 == 1}"> --%>
												<img src="./resources/ls_img/report/icon_contract_rs.gif" id="suit10Rs" style="cursor:pointer;" border="0" >
<%-- 											</c:if> --%>
										</td>
									</tr>
									<tr>
					                    <td bgcolor="#DCFFDC" class="td" height="25">
											<p><b>ㆍ<input type="radio" class = "inputJosaClass10" name = "report1"  value=""/>조사완료여부</b></p>
					                    </td>
					                    <td class="td" colspan="3">
											<p>
												<span class="spanJosaClass10" id = "spanIdReport1">
													<c:choose>
														<c:when test="${suimSuit_10Vo.report1 eq '01'}">조사완료</c:when>
														<c:when test="${suimSuit_10Vo.report1 eq '02'}">조사실패</c:when>
													</c:choose>											
												</span>
												<span class = "inputJosaClass10">
													<input type="radio" name = "report1"  value="01"/> 조사완료
													<input type="radio" name = "report1"  value="02"/> 조사실패
												</span>										
											</p>
					                    </td>
									</tr>
					                <tr>
					                    <td bgcolor="#DCFFDC" class="td" height="25">
											<p><b>ㆍ<input type="radio" class = "inputJosaClass10" name="report2"  value=''>방문승낙,거절사유</b></p>
					                    </td>
					                    <td class="td" colspan="3">
					                    	<p>
												<span class="spanJosaClass10" id = "spanIdReport2">
													<c:choose>
														<c:when test="${suimSuit_10Vo.report2 eq '00'}">정상</c:when>
														<c:when test="${suimSuit_10Vo.report2 eq '01'}">전화연락 안됨(3회이상)</c:when>
														<c:when test="${suimSuit_10Vo.report2 eq '02'}">방문자체에 불만표시</c:when>
														<c:when test="${suimSuit_10Vo.report2 eq '03'}">방문은 허용하였으나 조사에 불만표시</c:when>
														<c:when test="${suimSuit_10Vo.report2 eq '04'}">RC거절</c:when>
														<c:when test="${suimSuit_10Vo.report2 eq '05'}">기타</c:when>
													</c:choose>											
												</span>
												<span class = "inputJosaClass10">
													<input type="radio" name="report2"  value='00'> 정상
													<input type="radio" name="report2"  value='01'> 전화연락 안됨(3회이상)
													<input type="radio" name="report2"  value='02'> 방문자체에 불만표시 <br />
													<input type="radio" name="report2"  value='03'> 방문은 허용하였으나 조사에 불만표시
													<input type="radio" name="report2"  value='04'> RC거절
													<input type="radio" name="report2"  value='05'> 기타
												</span>
											</p>
					                    </td>
									</tr>
					                <tr>
					                    <td bgcolor="#DCFFDC" class="td" height="25">
											<p><b>ㆍ<input type="radio" class = "inputJosaClass10" name="report3"  value='' >조사결과</b></p>
					                    </td>
					                    <td class="td" colspan="3">
											<p>
												<span class="spanJosaClass10" id = "spanIdReport3">
													<c:choose>
														<c:when test="${suimSuit_10Vo.report3 eq '1'}">전부일치</c:when>
														<c:when test="${suimSuit_10Vo.report3 eq '2'}">일부일치</c:when>
														<c:when test="${suimSuit_10Vo.report3 eq '9'}">조사실패</c:when>
													</c:choose>											
												</span>
												<span class = "inputJosaClass10">
													<input type="radio" name="report3"  value='1' > 전부일치
													<input type="radio" name="report3"  value='2' > 일부일치
													<input type="radio" name="report3"  value='9' > 조사실패
												</span>
											</p>
					                    </td>
									</tr>
					                <tr>
					                    <td bgcolor="#DCFFDC" class="td" height="25">
											<p><b>ㆍ<input type="radio" class = "inputJosaClass10" name="report4"  value='' >소유자 일치여부</b></p>
					                    </td>
					                    <td class="td" colspan="3">
					                    	<p>
												<span class="spanJosaClass10" id = "spanIdReport4">
													<c:choose>
														<c:when test="${suimSuit_10Vo.report4 eq '1'}">일치</c:when>
														<c:when test="${suimSuit_10Vo.report4 eq '2'}">불일치</c:when>
														<c:when test="${suimSuit_10Vo.report4 eq '3'}">미확인</c:when>
													</c:choose>											
												</span>
												<span class = "inputJosaClass10">
													<input type="radio" name="report4"  value='1' > 일치
													<input type="radio" name="report4"  value='2' > 불일치
													<input type="radio" name="report4"  value='3' > 미확인
												</span>
											</p>
					                    </td>
									</tr>
					                <tr>
					                    <td bgcolor="#DCFFDC" class="td" height="25">
											<p><b>ㆍ<input type="radio" class = "inputJosaClass10" name="report5"  value='' >소재지 일치여부</b></p>
					                    </td>
					                    <td class="td" colspan="3">
											<p>
												<span class="spanJosaClass10" id = "spanIdReport5">
													<c:choose>
														<c:when test="${suimSuit_10Vo.report5 eq '1'}">일치</c:when>
														<c:when test="${suimSuit_10Vo.report5 eq '2'}">불일치</c:when>
														<c:when test="${suimSuit_10Vo.report5 eq '3'}">미확인</c:when>
													</c:choose>											
												</span>
												<span class = "inputJosaClass10">
													<input type="radio" name="report5"  value='1' > 일치
													<input type="radio" name="report5"  value='2' > 불일치
													<input type="radio" name="report5"  value='3' > 미확인
												</span>
											</p>
					                    </td>
									</tr>
					                <tr>
					                    <td bgcolor="#DCFFDC" class="td" height="25">
											<p><b>ㆍ<input type="radio" class = "inputJosaClass10" name="report6"  value='' >건물급수 일치여부</b></p>
					                    </td>
					                    <td class="td" colspan="3">
											<p>
												<span class="spanJosaClass10" id = "spanIdReport6">
													<c:choose>
														<c:when test="${suimSuit_10Vo.report6 eq '1'}">일치</c:when>
														<c:when test="${suimSuit_10Vo.report6 eq '2'}">불일치</c:when>
														<c:when test="${suimSuit_10Vo.report6 eq '3'}">미확인</c:when>
													</c:choose>											
												</span>
												<span class = "inputJosaClass10">
													<input type="radio" name="report6"  value='1' > 일치
													<input type="radio" name="report6"  value='2' > 불일치
													<input type="radio" name="report6"  value='3' > 미확인
												</span>
											</p>
					                    </td>
									</tr>
					                <tr>
					                    <td bgcolor="#DCFFDC" class="td" height="25">
											<p><b>ㆍ<input type="radio" class = "inputJosaClass10" name="report7"  value='' >가입업종 일치여부</b></p>
					                    </td>
					                    <td class="td" colspan="3">
											<p>
												<span class="spanJosaClass10" id = "spanIdReport7">
													<c:choose>
														<c:when test="${suimSuit_10Vo.report7 eq '1'}">일치</c:when>
														<c:when test="${suimSuit_10Vo.report7 eq '2'}">불일치</c:when>
														<c:when test="${suimSuit_10Vo.report7 eq '3'}">미확인</c:when>
													</c:choose>											
												</span>
												<span class = "inputJosaClass10">
													<input type="radio" name="report7"  value='1' > 일치
													<input type="radio" name="report7"  value='2' > 불일치
													<input type="radio" name="report7"  value='3' > 미확인
												</span>
											</p>
					                    </td>
									</tr>
					                <tr>
					                    <td bgcolor="#DCFFDC" class="td" height="25">
											<p><b>ㆍ<input type="radio" class = "inputJosaClass10" name="report8"  value='' >요율업종 일치여부</b></p>
					                    </td>
					                    <td class="td" colspan="3">
											<p>
												<span class="spanJosaClass10" id = "spanIdReport8">
													<c:choose>
														<c:when test="${suimSuit_10Vo.report8 eq '1'}">일치</c:when>
														<c:when test="${suimSuit_10Vo.report8 eq '2'}">불일치</c:when>
														<c:when test="${suimSuit_10Vo.report8 eq '3'}">미확인</c:when>
													</c:choose>											
												</span>
												<span class = "inputJosaClass10">
													<input type="radio" name="report8"  value='1' > 일치
													<input type="radio" name="report8"  value='2' > 불일치
													<input type="radio" name="report8"  value='3' > 미확인
												</span>
											</p>
					                    </td>
									</tr>
					                <tr>
					                    <td bgcolor="#DCFFDC" class="td" height="25">
											<p><b>ㆍ<input type="radio" class = "inputJosaClass10" name="report9"  value='' >야적동산 일치여부</b></p>
					                    </td>
					                    <td class="td" colspan="3">
											<p>
												<span class="spanJosaClass10" id = "spanIdReport9">
													<c:choose>
														<c:when test="${suimSuit_10Vo.report9 eq '1'}">일치</c:when>
														<c:when test="${suimSuit_10Vo.report9 eq '2'}">불일치</c:when>
														<c:when test="${suimSuit_10Vo.report9 eq '3'}">미확인</c:when>
													</c:choose>											
												</span>
												<span class = "inputJosaClass10">
													<input type="radio" name="report9"  value='1' > 일치
													<input type="radio" name="report9"  value='2' > 불일치
													<input type="radio" name="report9"  value='3' > 미확인
												</span>
											</p>
					                    </td>
									</tr>
					                <tr>
					                    <td bgcolor="#DCFFDC" class="td" height="25" nowrap>
											<p><b>ㆍ<input type="radio" class = "inputJosaClass10" name="report11"  value='' >중점요청사항 일치여부</b></p>
					                    </td>
					                    <td class="td" colspan="3">
											<p>
												<span class="spanJosaClass10" id = "spanIdReport11">
													<c:choose>
														<c:when test="${suimSuit_10Vo.report11 eq '1'}">일치</c:when>
														<c:when test="${suimSuit_10Vo.report11 eq '2'}">불일치</c:when>
														<c:when test="${suimSuit_10Vo.report11 eq '3'}">미확인</c:when>
													</c:choose>											
												</span>
												<span class = "inputJosaClass10">
													<input type="radio" name="report11"  value='1' > 일치
													<input type="radio" name="report11"  value='2' > 불일치
													<input type="radio" name="report11"  value='3' > 미확인
												</span>
											</p>
					                    </td>
									</tr>
					                <tr>
					                    <td bgcolor="#DCFFDC" class="td" height="25">
											<p><b>ㆍ조사결과 텍스트</b></p>
					                    </td>
					                    <td class="td" colspan="3">
											<p>
												<span class="spanJosaClass10" id = "spanIdReport10">
													${suimSuit_10Vo.report10}
												</span>
												<span class = "inputJosaClass10">
													<input type="text" name="report10" id="report10" value='${suimSuit_10Vo.report10}'size="50" maxlength="300" >
												</span>
											</p>
					                    </td>
									</tr>
								</table>
								
								<!-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& -->
								
								<p>&nbsp;</p>
					            <table cellpadding="0" cellspacing="0" align="center" width="600">
	                                <tr>
					                    <td bgcolor="#EDEDED" class="td" width="125" height="25">
											<p><b>ㆍ적부번호</b></p>
					                    </td>
					                    <td class="td" width="475">
											<p>${suimSuit_10Vo.juckbuNo}</p>
					                    </td>
									</tr>
	                                <tr>
					                    <td bgcolor="#EDEDED" class="td" width="125" height="25">
											<p><b>ㆍ전문발송일자</b></p>
					                    </td>
					                    <td class="td" width="475">
											<p>${suimSuit_10Vo.sendDate}</p>
					                    </td>
									</tr>
	                                <tr>
					                    <td bgcolor="#EDEDED" class="td" height="25">
											<p><b>ㆍ적부업체</b></p>
					                    </td>
					                    <td class="td">
											<p>
												<c:if test="${suimSuit_10Vo.ivstComName eq '01'}">탑</c:if>
											</p>
					                    </td>
									</tr>
	                                <tr>
					                    <td bgcolor="#EDEDED" class="td" height="25">
											<p><b>ㆍ물건구분</b></p>
					                    </td>
					                    <td class="td">
											<p>
												<c:choose>
													<c:when test="${suimSuit_10Vo.bdType eq '01'}">일반</c:when>
													<c:when test="${suimSuit_10Vo.bdType eq '02'}">공장</c:when>
													<c:when test="${suimSuit_10Vo.bdType eq '99'}">아파트</c:when>
												</c:choose>
											</p>
					                    </td>
									</tr>
	                                <tr>
					                    <td bgcolor="#EDEDED" class="td" height="25">
											<p><b>ㆍ증권번호</b></p>
					                    </td>
					                    <td class="td">
											<p>${suimSuit_10Vo.plcyNo}</p>
					                    </td>
									</tr>
	                                <tr>
					                    <td bgcolor="#EDEDED" class="td" height="25">
											<p><b>ㆍ청약번호</b></p>
					                    </td>
					                    <td class="td">
											<p>${suimSuit_10Vo.entyDsgnNo}</p>
					                    </td>
									</tr>
	                                <tr>
					                    <td bgcolor="#EDEDED" class="td" height="25">
											<p><b>ㆍ상품명</b></p>
					                    </td>
					                    <td class="td">
											<p>${suimSuit_10Vo.pkgName}</p>
					                    </td>
									</tr>
	                                <tr>
					                    <td bgcolor="#EDEDED" class="td" height="25">
											<p><b>ㆍ보험시작일자</b></p>
					                    </td>
					                    <td class="td">
											<p>${suimSuit_10Vo.agrmDate}</p>
					                    </td>
									</tr>
	                                <tr>
					                    <td bgcolor="#E4CAFF" class="td" colspan="2">
											<p><font color="black"><b>ㆍ계약자 정보</b></font></p>
					                    </td>
									</tr>
	                                <tr>
					                    <td bgcolor="#EDEDED" class="td" height="25">
											<p><b>ㆍ계약자명</b></p>
					                    </td>
					                    <td class="td">
											<p>
												<img class="popView" suimRptNo="${suimSuit_10Vo.suimRptNo}" ptnrId="${suimSuit_10Vo.ptnrId}" suitFlag="10" target="contractorName" style="cursor:pointer;" src="./resources/ls_img/btns_view.gif" width="30" height="18" border="0">
											</p>
					                    </td>
									</tr>
	                                <tr>
					                    <td bgcolor="#EDEDED" class="td" height="25">
											<p><b>ㆍ계약자핸드폰</b></p>
					                    </td>
					                    <td class="td">
											<p>
												<img class="popView" suimRptNo="${suimSuit_10Vo.suimRptNo}" ptnrId="${suimSuit_10Vo.ptnrId}" suitFlag="10" target="conHndPhoneNo" style="cursor:pointer;" src="./resources/ls_img/btns_view.gif" width="30" height="18" border="0">
											</p>
					                    </td>
									</tr>
	                                <tr>
					                    <td bgcolor="#EDEDED" class="td" height="25">
											<p><b>ㆍ계약자자택</b></p>
					                    </td>
					                    <td class="td">
											<p>
												<img class="popView" suimRptNo="${suimSuit_10Vo.suimRptNo}" ptnrId="${suimSuit_10Vo.ptnrId}" suitFlag="10" target="conHomeTelNo" style="cursor:pointer; "src="./resources/ls_img/btns_view.gif" width="30" height="18" border="0">
											</p>
					                    </td>
									</tr>
	                                <tr>
					                    <td bgcolor="#EDEDED" class="td" height="25">
											<p><b>ㆍ계약자직장</b></p>
					                    </td>
					                    <td class="td">
											<p>
												<img class="popView" suimRptNo="${suimSuit_10Vo.suimRptNo}" ptnrId="${suimSuit_10Vo.ptnrId}" suitFlag="10" target="conOfficeNo" style="cursor:pointer;"src="./resources/ls_img/btns_view.gif" width="30" height="18" border="0">
											</p>
					                    </td>
									</tr>
	                                <tr>
					                    <td bgcolor="#E4CAFF" class="td" colspan="2">
											<p><font color="black"><b>ㆍ소유자 정보</b></font></p>
					                    </td>
									</tr>
	                                <tr>
					                    <td bgcolor="#EDEDED" class="td" height="25">
											<p><b>ㆍ소유자명</b></p>
					                    </td>
					                    <td class="td">
											<p>
												<img class="popView" suitFlag="10" suimRptNo="${suimSuit_10Vo.suimRptNo}" ptnrId="${suimSuit_10Vo.ptnrId}" target="hostName" style="cursor:pointer;" src="./resources/ls_img/btns_view.gif" width="30" height="18" border="0">
											</p>
					                    </td>
									</tr>
	                                <tr>
					                    <td bgcolor="#EDEDED" class="td" height="25">
											<p><b>ㆍ소유자핸드폰</b></p>
					                    </td>
					                    <td class="td">
											<p>
												<img class="popView" suitFlag="10" suimRptNo="${suimSuit_10Vo.suimRptNo}" ptnrId="${suimSuit_10Vo.ptnrId}" target="hostHndPhoneNo" style="cursor:pointer;" src="./resources/ls_img/btns_view.gif" width="30" height="18" border="0">
											</p>
					                    </td>
									</tr>
	                                <tr>
					                    <td bgcolor="#EDEDED" class="td" height="25">
											<p><b>ㆍ소유자자택</b></p>
					                    </td>
					                    <td class="td">
											<p>
												<img class="popView" suitFlag="10" suimRptNo="${suimSuit_10Vo.suimRptNo}" ptnrId="${suimSuit_10Vo.ptnrId}" target="hostHomeTelNo" style="cursor:pointer;" src="./resources/ls_img/btns_view.gif" width="30" height="18" border="0">
											</p>
					                    </td>
									</tr>
	                                <tr>
					                    <td bgcolor="#EDEDED" class="td" height="25">
											<p><b>ㆍ소유자직장</b></p>
					                    </td>
					                    <td class="td">
											<p>
												<img class="popView" suitFlag="10" suimRptNo="${suimSuit_10Vo.suimRptNo}" ptnrId="${suimSuit_10Vo.ptnrId}" target="hostOfficeNo" style="cursor:pointer;" src="./resources/ls_img/btns_view.gif" width="30" height="18" border="0">
											</p>
					                    </td>
									</tr>
	                                <tr>
					                    <td bgcolor="#EDEDED" class="td" height="25">
											<p><b>ㆍ계약자와의관계</b></p>
					                    </td>
					                    <td class="td">
											<p>
												<c:choose>
													<c:when test="${suimSuit_10Vo.hostContractor eq '01'}">본인</c:when>
													<c:when test="${suimSuit_10Vo.hostContractor eq '02'}">배우자</c:when>
													<c:when test="${suimSuit_10Vo.hostContractor eq '03'}">자녀</c:when>
													<c:when test="${suimSuit_10Vo.hostContractor eq '04'}">부모</c:when>
													<c:when test="${suimSuit_10Vo.hostContractor eq '05'}">고용주 등</c:when>
													<c:when test="${suimSuit_10Vo.hostContractor eq '99'}">기타</c:when>
												</c:choose>
											</p>
					                    </td>
									</tr>
	                                <tr>
					                    <td bgcolor="#E4CAFF" class="td" colspan="2">
											<p><font color="black"><b>ㆍ건물 정보</b></font></p>
					                    </td>
									</tr>
	                                <tr>
					                    <td bgcolor="#EDEDED" class="td" height="25">
											<p><b>ㆍ소재지우편번호</b></p>
					                    </td>
					                    <td class="td">
											<p>
												${suimSuit_10Vo.buildingZipcode}
											</p>
					                    </td>
									</tr>
	                                <tr>
					                    <td bgcolor="#EDEDED" class="td" height="25">
											<p><b>ㆍ소재지상세</b></p>
					                    </td>
					                    <td class="td">
											<p>
												<img class="popView" suitFlag="10" suimRptNo="${suimSuit_10Vo.suimRptNo}" ptnrId="${suimSuit_10Vo.ptnrId}" target="buildingAddr" style="cursor:pointer;" src="./resources/ls_img/btns_view.gif" width="30" height="18" border="0">
											</p>
					                    </td>
									</tr>
	                                <tr>
					                    <td bgcolor="#EDEDED" class="td" height="25">
											<p><b>ㆍ목적물일련번호</b></p>
					                    </td>
					                    <td class="td">
											<p>1</p>
					                    </td>
									</tr>
	                                <tr>
					                    <td bgcolor="#EDEDED" class="td" height="25">
											<p><b>ㆍ실제업종명</b></p>
					                    </td>
					                    <td class="td">
											<p>${suimSuit_10Vo.buildinginfo01}</p>
					                    </td>
									</tr>
	                                <tr>
					                    <td bgcolor="#EDEDED" class="td">
											<p><b>ㆍ요율업종명</b></p>
					                    </td>
					                    <td class="td">
											<p>${suimSuit_10Vo.buildinginfo02}</p>
					                    </td>
									</tr>
					                <tr>
					                    <td bgcolor="#EDEDED" class="td">
											<p><b>ㆍ건물급수</b></p>
					                    </td>
					                    <td class="td">
											<p>${suimSuit_10Vo.buildinginfo03}</p>
					                    </td>
					                </tr>
					                <tr>
					                    <td bgcolor="#EDEDED" class="td">
											<p><b>ㆍ중점요청사항</b></p>
					                    </td>
					                    <td class="td">
											<p>${suimSuit_10Vo.buildingMemo}</p>
					                    </td>
					                </tr>
	                                <tr>
					                    <td bgcolor="#E4CAFF" class="td" colspan="2">
											<p><font color="black"><b>ㆍ취급자 정보</font></p>
					                    </td>
									</tr>
					                <tr>
					                    <td bgcolor="#EDEDED" class="td">
											<p><b>ㆍ취급자명</b></p>
					                    </td>
					                    <td class="td">
											<p>${suimSuit_10Vo.clerkName}</p>
					                    </td>
					                </tr>
					                <tr>
					                    <td bgcolor="#EDEDED" class="td">
											<p><b>ㆍ취급자소속지점명</b></p>
					                    </td>
					                    <td class="td">
											<p>${suimSuit_10Vo.clerkSectName}</p>
					                    </td>
					                </tr>
					                <tr>
					                    <td bgcolor="#EDEDED" class="td">
											<p><b>ㆍ취급자소속지역단명</b></p>
					                    </td>
					                    <td class="td">
											<p>${suimSuit_10Vo.clerkDeptName}</p>
					                    </td>
					                </tr>
					                <tr>
					                    <td bgcolor="#EDEDED" class="td">
											<p><b>ㆍ사용인명</b></p>
					                    </td>
					                    <td class="td">
											<p>${suimSuit_10Vo.clerkName2}</p>
					                    </td>
					                </tr>
					                <tr>
					                    <td bgcolor="#EDEDED" class="td">
											<p><b>ㆍ취급자핸드폰</b></p>
					                    </td>
					                    <td class="td">
											<p>${suimSuit_10Vo.clerkHndPhoneNo}</p>
					                    </td>
					                </tr>
					                <tr>
					                    <td bgcolor="#EDEDED" class="td">
											<p><b>ㆍ취급자직장</b></p>
					                    </td>
					                    <td class="td">
											<p>${suimSuit_10Vo.clerkOfcTelNo}</p>
					                    </td>
									</tr>
					            </table>
					            <p>&nbsp;</p>
							</div>
							<!-- 보안데이터 출력 모달 -->
							<div id="secu-dialog" title="보안 데이터 확인" style="font-size: 15px;display:none;" align="center">
								<br/>
								<div style="width: 380px;">
									<table border="1">
										<tr height="30">
											<th align="center" id="secuDataHead"  bgcolor="white"></th>
										<tr>
											<td align="center" id="secuDataContent" bgcolor="white" style="padding:3px;">
											</td>
										</tr>
									</table>
								</div>
							</div>
						<br>
						</div> <!-- guestcnt5 -->
					</div><!-- //guest -->
				</div><!-- //bot1-3 -->
			</div>
		</div>
	</div>
	<!--//center -->

	<!-- footer -->
	<c:import url="../top_main/top_pop_footer.jsp"></c:import>
	<!-- //footer -->
	
	<!-- 공동수행자 사원 찾기 다이어로그 -->
	<c:import url="../util_etc/module_mbrpop_1_rptdtl.jsp"></c:import>
</body>