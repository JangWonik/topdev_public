<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
<script src="./resources/ne_js/calendar.js?v=20170321111520"></script><!-- calendar -->
<script src="./resources/ne_js/ne_number.js"></script>
<style>
	.td-overflow-none{
			text-overflow : ellipsis;
			overflow : hidden;
			white-space : nowrap;
			word-wrap:normal;
		}
		
		.btn-vacation-aprv {
			font-weight:bold;
			text-decoration:none;
			font-family:Arial;
			text-indent:0px;
			line-height:0px;
			-moz-border-radius:5px;
			-webkit-border-radius:5px;
			border-radius:5px;
			text-align:center;
			vertical-align:middle;
			display:inline-block;
			font-size:12px;
			color:#696969  !important;
			width:40px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #e1e1e1;
		}
		
		.btn-vacation-detail {
			font-weight:bold;
			text-decoration:none;
			font-family:Arial;
			text-indent:0px;
			line-height:0px;
			-moz-border-radius:5px;
			-webkit-border-radius:5px;
			border-radius:5px;
			text-align:center;
			vertical-align:middle;
			display:inline-block;
			font-size:12px;
			color:#696969  !important;
			width:60px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #CEE3F6;
		}

		.btn-vacation-aprv:active {
			position:relative;
			top:4px
		}
		
		/* 모달 버튼 */
		.ui-button-text-only {
			height:2.1em !important;
		}
		
		.buttonMini{
			width:40px;
			height:20px;
		    background-color:#CEE3F6;
		    color:#666;
		    text-align: center;
			border-radius:5px;
		    font-size: 10px;
		    cursor: pointer;
		    text-decoration:none;
		    border: solid 1px grey;		    
		}
</style>
<script>
	$(document).ready(function () {
		
		$("#srchTeamId").select2();
		$("#srchUserState").select2();
		
		//폼에서 엔터 입력시 검색버튼 클릭
		$("form input").keydown(function(e) {
			if( e.keyCode == 13 ){
				doSearch();
			}
		});
		
		//페이지 로딩 후 검색
		doSearch();
	});
	
	//기본급 확정계산
	function doBasePayCal(){
		
		var base_date_text = $("#base_edate").val().substring(0,4)+"년 "+$("#base_edate").val().substring(5,7)+"월";
		
		if( !confirm(base_date_text+"의 기본급을 확정하시겠습니까?\n기존 등록된 확정정보는 초기화됩니다.") ){
			alert('기본급 확정을 취소하였습니다.');
			return;
		}		
		
		var sUrl = "confirmSalary4BasePay";
		
		var formData = $("#searchFrm").serialize();
		
		$.ajax({
	        type: "POST",
	        url: sUrl,
	        data: formData,		         
	        dataType: "JSON", 
	        success: function(data){
	        	alert("기본급을 확정하였습니다\n추가 : "+data.insertCnt+"명\n갱신 : "+data.updateCnt+"명");
	        	doSearch();
	        	doConfirmSearch();
	        },	        
	        error: function(e){
	            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	        }
	        
		});
		
	}
	
	function doSearch(){
		var formData = $("#searchFrm").serialize();
		
		$.ajax({
			type : "post",			
			url : "salaryMemberListAjax",
			data : formData,
			success : function(result){
				$("#salaryMemberList").html(result);	 				
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});		
	}
	
	//팀장설정 추가
	function doMemberOptionAdd(){
		$("#manager_sdate_add").val('');
		$("#manager_edate_add").val('');
		$("#manager_add_tr").show();		
	}
	
	//팀장설정 취소
	function doMemberOptionCancel(){
		$("#manager_sdate_add").val('');
		$("#manager_edate_add").val('');
		$("#manager_add_tr").hide();
	}
	
	//팀장설정 수정
	function doMemberOptionMod( p_mkey ){
		$("#tr_manager_view_"+p_mkey).hide();
		$("#tr_manager_edit_"+p_mkey).show();
	}
	
	//팀장설정 수정 취소
	function doMemberOptionModCancel( p_mkey ){
		$("#tr_manager_edit_"+p_mkey).hide();
		$("#tr_manager_view_"+p_mkey).show();
	}
	
	//팀장설정 수정 저장
	function doMemberOptionModSave( p_mkey ){
		
		var user_no_val = $("#user_no_val").val();
		var base_sdate = $("#manager_sdate_val").val();
		var base_edate = $("#manager_edate_val").val();
		
		var manager_sdate = $("#manager_sdate_mod_"+p_mkey).val();
		var manager_edate = $("#manager_edate_mod_"+p_mkey).val();
		
		if( manager_sdate == '' ){
			alert('팀장 지정 시작일자를 입력해주세요.');
			$("#manager_sdate_mod_"+p_mkey).focus();
			return;
		}
		
		if( manager_edate == '' ){
			alert('팀장 지정 종료일자를 입력해주세요.');
			$("#manager_edate_mod_"+p_mkey).focus();
			return;
		}
		
		//종료날짜가 시작날짜보다 이전일자인지 체크한다.
		if( dateChk( manager_sdate,  manager_edate) ){
			alert('팀장지정 시작일자가 종료일자보다 작아야합니다. ');
			$("#manager_sdate_mod_"+p_mkey).focus();
			return;
		}
		
		var sUrl = "salary_manager_option_action";
		
		var param = {};
		
		param.mkey = p_mkey;
		param.user_no = user_no_val;
		param.manager_sdate = manager_sdate;
		param.manager_edate = manager_edate;		
		param.action_flag = "U";
		
		$.ajax({
			type: "POST",
			url: sUrl,
			data: param,		         
			dataType: "JSON", 
			success: function(data){	 
				//console.log("msg = "+JSON.stringify(data));
				if( data.result == 'Dup' ){
					alert('기존에 등록된 팀장 지정기간과 지정기간이 겹칩니다.\n확인 후 추가 해 주세요.');
				}else if( data.result == 'Update' ){
					alert('팀장 지정기간을 수정하였습니다.');
					$("#salary-member-dialog").dialog("close");
					//모달창 뒤의 페이지 새로운 값으로 리로딩
					doSearch();
					//새로운 갱신정보로 창을 연다.
					doSalaryMemberDetail(user_no_val,base_sdate,base_edate);
					$("#tr_manager_edit_"+p_mkey).hide();
				}
				
			},	        
			error: function(e){
			    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
			}
		
	    });
		
	}
	
	//팀장 설정 삭제
	function doMemberOptionDel( p_mkey ){
		
		var user_no_val = $("#user_no_val").val();
		var base_sdate = $("#manager_sdate_val").val();
		var base_edate = $("#manager_edate_val").val();
		
		if( confirm('해당 팀장 설정을 삭제하시겠습니까?') ){
						
			var sUrl = "salary_manager_option_action";
			
			var param = {};		
			param.mkey = p_mkey;
			param.action_flag = "D";					
			
			$.ajax({
		        type: "POST",
		        url: sUrl,
		        data: param,		         
		        dataType: "JSON", 
		        success: function(data){
		        	
		        	if( data.result == 'Delete' ){
		        		alert('팀장 지정기간을 삭제하였습니다.');
		        		$("#salary-member-dialog").dialog("close");
		        		//모달창 뒤의 페이지 새로운 값으로 리로딩
		        		doSearch();
		        		//새로운 갱신정보로 창을 연다.
		        		doSalaryMemberDetail(user_no_val,base_sdate,base_edate);		        		
		        	}
		        	
		        },	        
		        error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
		        
		    });
		}
	}
	
	//팀장설정 목록 불러오기
	function getManagerInfoAjax( p_user_no ){
		
		var param = {};		
		param.user_no = p_user_no;
		
		$.ajax({
			type : "post",
			url : "memberManagerListAjax",
			data : param,
			success : function(result){			
				//팀장 정보목록을 불러온다.				
				$("#div_manager_list").html(result);	 				
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});
	}
	
	//팀장설정 저장
	function doMemberOptionSave( p_action ){
		
		var user_no_val = $("#user_no_val").val();
		var manager_sdate = $("#manager_sdate_add").val();
		var manager_edate = $("#manager_edate_add").val();
		
		var base_sdate = $("#manager_sdate_val").val();
		var base_edate = $("#manager_edate_val").val();
		
		if( p_action == 'I' ){
			
			if( manager_sdate == '' ){
				alert('팀장 지정 시작일자를 입력해주세요.');
				$("#manager_sdate_add").focus();
				return;
			}
			
			if( manager_edate == '' ){
				alert('팀장 지정 종료일자를 입력해주세요.');
				$("#manager_edate_add").focus();
				return;
			}
			
			//종료날짜가 시작날짜보다 이전일자인지 체크한다.
			if( dateChk( manager_sdate,  manager_edate) ){
				alert('팀장지정 시작일자가 종료일자보다 작아야합니다. ');
				$("#manager_sdate_add").focus();
				return;
			}			
		}
		
		var sUrl = "salary_manager_option_action";
		
		var param = {};
		
		param.user_no = user_no_val;
		param.manager_sdate = manager_sdate;
		param.manager_edate = manager_edate;		
		param.action_flag = p_action;
		
		$.ajax({
	        type: "POST",
	        url: sUrl,
	        data: param,		         
	        dataType: "JSON", 
	        success: function(data){	 
	        	//console.log("msg = "+JSON.stringify(data));
	        	if( data.result == 'Dup' ){
	        		alert('기존에 등록된 팀장 지정기간과 지정기간이 겹칩니다.\n확인 후 추가 해 주세요.');
	        	}else if( data.result == 'Insert' ){
	        		alert('팀장 지정기간을 등록하였습니다.');
	        		$("#salary-member-dialog").dialog("close");
	        		//모달창 뒤의 페이지 새로운 값으로 리로딩
	        		doSearch();
	        		//새로운 갱신정보로 창을 연다.
	        		doSalaryMemberDetail(user_no_val,base_sdate,base_edate);
	        		$("#manager_add_tr").hide();
	        	}
	        	
	        },	        
	        error: function(e){
	            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	        }
	        
	    });
		
	}
	
	//개인 기본급(급여) 상세보기 및 설정 수정
	function doSalaryMemberDetail( p_user_no, p_base_sdate, p_base_edate ){		
		
		var sUrl = "get_salary_member_detail";
		
		var param = {};
		param.user_no = p_user_no;
		param.base_sdate = p_base_sdate;
		param.base_edate = p_base_edate;
		
		$.ajax({
	        type: "POST",
	        url: sUrl,
	        data: param,		         
	        dataType: "JSON", 
	        success: function(data){	        		
        		//alert(JSON.stringify(data));
        		//alert("data="+data.user_no);        		
        		//console.log("msg = "+JSON.stringify(data));
        		
        		//확인폼 설정
        		$("#user_no_val").val(data.user_no);        		
        		$("#manager_sdate_val").val(data.base_sdate);
        		$("#manager_edate_val").val(data.base_edate);
        		$("#base_date_text").text(data.base_sdate+" ~ "+data.base_edate);
        		$("#user_name_val").text(data.user_name);
        		$("#pay_flag_val").text(data.pay_flag_val);
        		$("#center_name_val").text(data.center_name);
        		$("#team_name_val").text(data.team_name);
        		$("#work_level_val").text(data.work_level_nm);
        		$("#join_date_val").text(data.join_date_fmt);
        		
        		$("#work_month_val").text(data.work_month_val);
        		$("#career_month_val").text(data.career_month_val);
        		$("#career_month_mod").val(data.career_month);
        		
        		$("#leave_month_val").text(data.leave_month_val);
        		$("#leave_month_mod").val(data.leave_month);
        		
        		$("#total_career_pay_val").html("<div style='text-align:right;padding-right:10px;'>"+data.total_career_pay+"</div>");
        		$("#total_work_pay_val").html("<div style='text-align:right;padding-right:10px;'>"+data.total_work_pay+"</div>");        		
        		
        		$("#manager_pay_val").html("<div style='text-align:right;padding-right:10px;'>"+data.manager_pay+"</div>");
        		$("#base_total_pay_val").html("<div style='text-align:right;padding-right:10px;'>"+data.base_total_pay+"</div>");
        		
        		$("#career_month_view").show();
        		$("#career_month_edit").hide();
        		
        		$("#leave_month_view").show();
        		$("#leave_month_edit").hide();
        		
        		//기본급확정을 위한 파라미터
        		var resultParam = {};
        		resultParam.user_no = data.user_no;
        		resultParam.join_date_fmt = data.join_date_fmt;
        		resultParam.base_edate = data.base_edate;
        		resultParam.team_id = data.team_id;
        		resultParam.work_level = data.work_level;
        		resultParam.work_month = data.work_month;
        		resultParam.career_month = data.career_month;
        		resultParam.leave_month = data.leave_month;
        		resultParam.pay_flag = data.pay_flag;
        		resultParam.career_pay = data.total_career_pay;
        		resultParam.work_pay = data.total_work_pay;
        		resultParam.manager_pay = data.manager_pay;
        		resultParam.base_total_pay = data.base_total_pay;
        		
        		//팀장 설정 목록 불러오기
        		getManagerInfoAjax(data.user_no);
        		
        		//연봉 설정 목록 불러오기
        		getAnnualInfoAjax(data.user_no);
        		
    			$("#salary-member-dialog").dialog({
    				height: 600,
    				width: 800,
    				closeOnEscape : true,
    				draggable : true,
    				appendTo : "#salaryMemberActionFrm",
    				title: "직원 기본급 설정 수정",
    				buttons:{
    					"기본급확정" : function(){
							var action = fnBasePayConfirm(resultParam);		//기본급확정
							if (action){
								$(this).dialog("close");
							}
						},
    					"닫기" : function(){
    						$(this).dialog("close");
    					}
    				},
    				modal: true,
    				overlay:{ opacity: 0., background: '#000000'}
    			});
	        },
	        error: function(e){
	            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	        }
	    });
	}
	
	
	//개인 기본급 확정
	function fnBasePayConfirm( p_param ){
		
		var sUrl = "confirmSalary4BasePayPerson";
		
		var param = p_param;
		
		$.ajax({
	        type: "POST",
	        url: sUrl,
	        data: param,		         
	        dataType: "JSON", 
	        success: function(data){
	        	
	        	if( data.result == 'I' ){
	        		alert('기본급을 확정(등록)하였습니다.');	
	        	}else{
	        		alert('기본급을 확정(갱신)하였습니다.');
	        	}
	        	doSearch();
	        	doConfirmSearch();
	        	$("#salary-member-dialog").dialog("close");
	        },	        
	        error: function(e){
	            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	        }
	        
		});
		
		
	}
	
	//두날짜를 비교해서 시작일이 종료일보다 작으면 false, 크면 true
	function dateChk(startDate, endDate){			
		var sDate = new Date(startDate);
		var eDate = new Date(endDate);
		//날짜 비교
		if( sDate.getTime() > eDate.getTime() ){
			return true;
		}else{
			return false;
		}
	}
	
	//경력 수정창클릭
	function modCareerMonth(){
		$("#career_month_view").hide();
		$("#career_month_edit").show();			
	}
	
	//경력 취소창클릭
	function cancelCareerMonth(){
		$("#career_month_view").show();
		$("#career_month_edit").hide();			
	}
	
	function saveCareerMonth(){
		
		var base_sdate = $("#manager_sdate_val").val();
		var base_edate = $("#manager_edate_val").val();
		
		var user_no_val = $("#user_no_val").val();
		var p_career_month = $("#career_month_mod").val();
		
		if( p_career_month == '' ){
			alert("경력일수를 입력해주세요.");
			$("#career_month_mod").focus();
			return;
		}		
		
		var sUrl = "updateCareerMonthMember";
		
		var param = {};
		
		param.user_no = user_no_val;
		param.career_month = p_career_month;
		
		$.ajax({
	        type: "POST",
	        url: sUrl,
	        data: param,		         
	        dataType: "JSON", 
	        success: function(data){
	        	
	        	if( data.result == 'Success' ){
	        		alert('경력기간을 수정하였습니다.');
	        		$("#salary-member-dialog").dialog("close");
	        		//모달창 뒤의 페이지 새로운 값으로 리로딩
	        		doSearch();
	        		//새로운 갱신정보로 창을 연다.
	        		doSalaryMemberDetail(user_no_val,base_sdate,base_edate);	        		
	        	}
	        	
	        },	        
	        error: function(e){
	            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	        }
	        
		});		
		
	}
	
	//휴직 수정창클릭
	function modLeaveMonth(){
		$("#leave_month_view").hide();
		$("#leave_month_edit").show();			
	}
	
	//휴직 취소창클릭
	function cancelLeaveMonth(){
		$("#leave_month_view").show();
		$("#leave_month_edit").hide();			
	}
	
	//휴직 저장
	function saveLeaveMonth(){
		
		var base_sdate = $("#manager_sdate_val").val();
		var base_edate = $("#manager_edate_val").val();
		
		var user_no_val = $("#user_no_val").val();
		var p_leave_month = $("#leave_month_mod").val();
		
		if( p_leave_month == '' ){
			alert("휴직일(개월)을 입력해주세요.");
			$("#leave_month_mod").focus();
			return;
		}		
		
		var sUrl = "updateLeaveMonthMember";
		
		var param = {};
		
		param.user_no = user_no_val;
		param.leave_month = p_leave_month;
		
		$.ajax({
	        type: "POST",
	        url: sUrl,
	        data: param,		         
	        dataType: "JSON", 
	        success: function(data){
	        	
	        	if( data.result == 'Success' ){
	        		alert('무급휴직기간을 수정하였습니다.');
	        		$("#salary-member-dialog").dialog("close");
	        		//모달창 뒤의 페이지 새로운 값으로 리로딩
	        		doSearch();
	        		//새로운 갱신정보로 창을 연다.
	        		doSalaryMemberDetail(user_no_val,base_sdate,base_edate);	        		
	        	}
	        	
	        },	        
	        error: function(e){
	            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	        }
	        
		});		
		
	}
	
	//연봉설정 목록 불러오기
	function getAnnualInfoAjax( p_user_no ){
		
		var param = {};		
		param.user_no = p_user_no;
		
		$.ajax({
			type : "post",			
			url : "memberAnnualListAjax",
			data : param,
			success : function(result){			
				//연봉 정보목록을 불러온다.				
				$("#div_annual_list").html(result);	 				
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});
	}
	
	//연봉제 설정 삭제
	function doAnnualOptionDel( p_akey ){
		
		var user_no_val = $("#user_no_val").val();
		var base_sdate = $("#manager_sdate_val").val();
		var base_edate = $("#manager_edate_val").val();
		
		if( confirm('해당 연봉 설정을 삭제하시겠습니까?') ){
						
			var sUrl = "salary_annual_option_action";
			
			var param = {};		
			param.akey = p_akey;
			param.action_flag = "D";					
			
			$.ajax({
		        type: "POST",
		        url: sUrl,
		        data: param,		         
		        dataType: "JSON", 
		        success: function(data){
		        	
		        	if( data.result == 'Delete' ){
		        		alert('연봉정보를 삭제하였습니다.');
		        		$("#salary-member-dialog").dialog("close");
		        		//모달창 뒤의 페이지 새로운 값으로 리로딩
		        		doSearch();
		        		//새로운 갱신정보로 창을 연다.
		        		doSalaryMemberDetail(user_no_val,base_sdate,base_edate);		        		
		        	}
		        	
		        },	        
		        error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
		        
		    });
		}
	}
	
	//연봉제 설정 수정
	function doMemberAnnualModSave( p_akey ){
		
		var user_no_val = $("#user_no_val").val();
		var base_sdate = $("#manager_sdate_val").val();
		var base_edate = $("#manager_edate_val").val();
		
		var akey_val = p_akey;
		var annual_pay_val = $("#annual_pay_mod_"+p_akey).val().replace(/,/gi,"");			//연봉액(콤마제거)
		var annual_sdate_val = $("#annual_sdate_mod_"+p_akey).val();
		var annual_edate_val = $("#annual_edate_mod_"+p_akey).val();		
		
		if( annual_pay_val == '' || annual_pay_val == 0 ){
			alert('연봉액을 입력해주세요.');
			$("#annual_pay_mod_"+p_akey).focus();
			return;
		}
		
		if( annual_sdate_val == '' ){
			alert('연봉계약 개시일자를 입력해주세요.');
			$("#annual_sdate_"+p_akey).focus();
			return;
		}
		
		if( annual_edate_val == '' ){
			alert('연봉계약 종료일자를 입력해주세요.');
			$("#annual_edate_"+p_akey).focus();
			return;
		}
		
		var sUrl = "salary_annual_option_action";
		
		var param = {};
		
		param.user_no = user_no_val;
		param.akey = akey_val;
		param.annual_pay = annual_pay_val;
		param.annual_sdate = annual_sdate_val;
		param.annual_edate = annual_edate_val;
		param.action_flag = "U";
		
		$.ajax({
	        type: "POST",
	        url: sUrl,
	        data: param,		         
	        dataType: "JSON", 
	        success: function(data){
	        	
	        	if( data.result == 'Dup' ){
					alert('기존에 등록된 연봉계약정보와 중복됩니다.\n확인 후 수정 해 주세요.');
				}else if( data.result == 'Update' ){
	        		alert('연봉정보를 수정하였습니다.');
	        		$("#salary-member-dialog").dialog("close");
	        		//모달창 뒤의 페이지 새로운 값으로 리로딩
	        		doSearch();
	        		//새로운 갱신정보로 창을 연다.
	        		doSalaryMemberDetail(user_no_val,base_sdate,base_edate);		        		
	        	}
	        	
	        },	        
	        error: function(e){
	            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	        }
	        
	    });
		
		
		
	}
	
	//연봉제 설정 추가 
	function doMemberAnnualAdd(){
		$("#annual_pay_add").val('');
		$("#annual_sdate_add").val('');		
		$("#annual_add_tr").show();
	}
	
	//연봉제 추가 저장취소
	function doMemberAnnualCancel(){		
		$("#annual_pay_add").val('');
		$("#annual_sdate_add").val('');		
		$("#annual_add_tr").hide();		
	}
	
	//연봉제 설정 수정 취소
	function doMemberAnnualModCancel( p_akey ){		
		$("#annual_edit_tr_"+p_akey).hide();
		$("#annual_view_tr_"+p_akey).show();
	}
	
	//연봉제 설정 수정
	function doAnnualOptionMod( p_akey ){		
		$("#annual_view_tr_"+p_akey).hide();
		$("#annual_edit_tr_"+p_akey).show();		
	}
	
	//연봉제 정보 저장
	function doMemberAnnualSave( p_action ){
		
		var user_no_val = $("#user_no_val").val();
		var base_sdate = $("#manager_sdate_val").val();
		var base_edate = $("#manager_edate_val").val();
		
		var annual_pay_val = $("#annual_pay_add").val().replace(/,/gi,"");			//연봉액(콤마제거)
		var annual_sdate_val = $("#annual_sdate_add").val();			//연봉계약 시작일자
				
		if( p_action == 'I' ){
			
			if( annual_pay_val == '' || annual_pay_val == 0 ){
				alert('연봉액을 입력해주세요.');
				$("#annual_pay_add").focus();
				return;
			}
			
			if( annual_sdate_val == '' ){
				alert('연봉계약일자를 입력해주세요.');
				$("#annual_sdate_add").focus();
				return;
			}			
		}
				
		var sUrl = "salary_annual_option_action";
		
		var param = {};
		
		param.user_no = user_no_val;
		param.annual_pay = annual_pay_val;
		param.annual_sdate = annual_sdate_val;
		param.action_flag = p_action;
		
		$.ajax({
			type: "POST",
			url: sUrl,
			data: param,		         
			dataType: "JSON", 
			success: function(data){	 
				//console.log("msg = "+JSON.stringify(data));
				if( data.result == 'Dup' ){
					alert('기존에 등록된 연봉계약정보와 중복됩니다.\n확인 후 추가 해 주세요.');
				}else if( data.result == 'Insert' ){
					alert('새로운 연봉계약정보를 등록하였습니다.');
					$("#salary-member-dialog").dialog("close");
					//모달창 뒤의 페이지 새로운 값으로 리로딩
					doSearch();
					//새로운 갱신정보로 창을 연다.
					doSalaryMemberDetail(user_no_val,base_sdate,base_edate);
					$("#annual_add_tr").hide();
				}
				
			},	        
			error: function(e){
			    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
			}
			
		});
		
	}
</script>

<!-- 직원상세정보조회 수정시작 -->
<form id="salaryMemberActionFrm">
	<input type="hidden" id="user_no_val" name="user_no_val"/>
	<input type="hidden" id="manager_sdate_val" name="manager_sdate_val"/>
	<input type="hidden" id="manager_edate_val" name="manager_edate_val"/>			
	<div id="salary-member-dialog" title="직원 기본급 조회 및 수정" style="font-size: 15px;display:none;" align="center">
		<table>				
			<tr>
				<td style="text-align:left;padding: 7px 0 7px 12px;border:0px;">
					<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" >&nbsp;&nbsp;<b>기준일자 : <span id="base_date_text"></span></b>
				</td>				
			</tr>
		</table>				
		<div class="tableStyle2" style="width: 750px;">			
			<table class="vacation-ins-table">				
				<tr>
					<th>이름</th>
					<td style="font-weight:bold;">
						<b><span id="user_name_val"></span></b>
					</td>
					<th>급여방식</th>
					<td style="font-weight:bold;">
						<span id="pay_flag_val"></span>
					</td>
				</tr>				
				<tr>
					<th>센터명</th>
					<td style="font-weight:bold;">
						<span id="center_name_val"></span>
					</td>
					<th>팀명</th>
					<td style="font-weight:bold;">
						<span id="team_name_val"></span>
					</td>
				</tr>
				<tr>
					<th>입사일자</th>
					<td style="font-weight:bold;">
						<span id="join_date_val"></span>
					</td>
					<th>직급</th>
					<td style="font-weight:bold;">
						<span id="work_level_val"></span>
					</td>
				</tr>
			</table>
			<table>
				<tr>
					<td colspan="4" style="border:0px;"></td>
				</tr>
				<tr>
					<th>근속일수</th>
					<td style="font-weight:bold;">
						<span id="work_month_val"></span>
					</td>
					<th>경력일수</th>
					<td style="font-weight:bold;">						
						<div id="career_month_view">
							<span id="career_month_val"></span>							
							<input class="buttonMini" onclick="javascript:modCareerMonth();" type="button" value="수정">
						</div>
						<div id="career_month_edit" style="display:none;">
							<input type="text" id="career_month_mod" name="career_month_mod" style="width:30px;text-align:right;padding-right:5px;"/> 개월
							<input class="buttonMini" style="background-color:#CEE3F6;" onclick="javascript:saveCareerMonth();" type="button" value="저장">
							<input class="buttonMini" style="background-color:#F6CECE;" onclick="javascript:cancelCareerMonth();" type="button" value="취소">							
						</div>
					</td>					
				</tr>
				<tr>
					<td colspan="2"></td>
					<th>휴직(무급)일수</th>
					<td style="font-weight:bold;">						
						<div id="leave_month_view">
							<span id="leave_month_val"></span>							
							<input class="buttonMini" onclick="javascript:modLeaveMonth();" type="button" value="수정">
						</div>
						<div id="leave_month_edit" style="display:none;">
							<input type="text" id="leave_month_mod" name="leave_month_mod" style="width:30px;text-align:right;padding-right:5px;"/> 개월
							<input class="buttonMini" style="background-color:#CEE3F6;" onclick="javascript:saveLeaveMonth();" type="button" value="저장">
							<input class="buttonMini" style="background-color:#F6CECE;" onclick="javascript:cancelLeaveMonth();" type="button" value="취소">							
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="border:0px;"></td>
				</tr>				
				<tr>
					<th>기본급</th>
					<td style="font-weight:bold;">
						<div id="total_career_pay_val"></div>
					</td>
					<th>근속수당</th>
					<td style="font-weight:bold;">
						<div id="total_work_pay_val"></div>
					</td>
				</tr>
				<tr>
					<th>팀장 수당</th>
					<td style="font-weight:bold;">
						<div id="manager_pay_val"></div>
					</td>
					<th>기본급 합계</th>
					<td style="font-weight:bold;">
						<div id="base_total_pay_val"></div>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="border:0px;"></td>
				</tr>																																																						
			</table>
			<!-- 팀장 설정 기능 시작 -->			
			<table>				
				<tr>
					<td style="text-align:left;padding-left:1px;border:0px;">
						<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" >&nbsp;&nbsp;<b>팀장설정</b>
					</td>
					<td style="text-align:right;border:0px;">
						<a class="btn-vacation-detail" id="btn-detail" style="width: 58px;background:#F8E0F7;" onclick="javascript:doMemberOptionAdd()" href="#noloc">추가</a>
					</td>
				</tr>
			</table>
			<table>
				<tr id="manager_add_tr" style="display:none;">
					<th width="25%">팀장 지정기간</th>				
					<td width="50%">
						<input type="text" class="classCalendar" id="manager_sdate_add" name="manager_sdate_add" style="width:100px;"/>
						 ~ 					
						<input type="text" class="classCalendar" id="manager_edate_add" name="manager_edate_add" style="width:100px;"/>
					</td>
					<td width="25%">
						<a class="btn-equipment-save-s" id="btn-detail" style="width: 50px;" onclick="javascript:doMemberOptionSave('I')" href="#noloc">저장</a>
						<a class="btn-equipment-cancel" id="btn-detail" style="width: 50px;" onclick="javascript:doMemberOptionCancel()" href="#noloc">취소</a>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="border:0px;"></td>
				</tr>
			</table>
			<div id="div_manager_list"></div>
			<!-- 팀장 설정 기능 끝 -->	
			
			<!-- 연봉제 설정 기능 시작 -->
			<table>
				<tr>
					<td colspan="2" style="border:0px;"></td>
				</tr>				
				<tr>
					<td style="text-align:left;padding-left:1px;border:0px;">
						<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" >&nbsp;&nbsp;<b>연봉제 설정</b>
					</td>
					<td style="text-align:right;border:0px;">
						<a class="btn-vacation-detail" id="btn-detail" style="width: 58px;background:#F8E0F7;" onclick="javascript:doMemberAnnualAdd()" href="#noloc">추가</a>
					</td>
				</tr>
			</table>
			<table>
				<tr id="annual_add_tr" style="display:none;">
					<th width="15%">연봉액</th>
					<td width="24%">						
						<input type="text" id="annual_pay_add" name="annual_pay_add" style="text-align:right;width:120px;" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;" class="amt" /> 원
					</td>
					<th width="15%">계약일자</th>
					<td width="24%">
						<input type="text" class="classCalendar" id="annual_sdate_add" name="annual_sdate_add" style="width:100px;"/>						
					</td>
					<td width="22%">
						<a class="btn-equipment-save-s" id="btn-detail" style="width: 40px;" onclick="javascript:doMemberAnnualSave('I')" href="#noloc">저장</a>
						<a class="btn-equipment-cancel" id="btn-detail" style="width: 40px;" onclick="javascript:doMemberAnnualCancel()" href="#noloc">취소</a>
					</td>
				</tr>
				<tr>
					<td colspan="5" style="border:0px;"></td>
				</tr>
			</table>
			<div id="div_annual_list"></div>
			<!-- 연봉제 설정 기능 끝 -->
		</div>
	</div>
</form>
<!-- 직원상세정보조회 수정 끝 -->

<!-- 검색창 추가시 사용 -->
<form id="searchFrm" name="searchFrm" method="post">
<div class="tableStyle99">
	<table>											
		<tr>			
			<th width="7%">
				기준일자
			</th>
			<td align="center" width="15%">
				<input type="text" id="base_sdate" name="base_sdate" value="${srchParam.base_sdate}" readonly style="width:70px;"/> ~ 
				<input type="text" id="base_edate" name="base_edate" value="${srchParam.base_edate}" readonly style="width:70px;"/>				
			</td>
			<th width="7%">부서</th>
			<td width="17%" style="text-align:left;padding-left:10px;">
				<span style="text-align: left !important;">
					<select id="srchTeamId" name="srchTeamId" style="width: 195px;">
						<option value="0">- 전체 -</option>
						<c:forEach items="${teamList}" var="teamVo">
							<c:choose>
								<c:when test="${srchTeamId == teamVo.team_id}">
									<option value="${teamVo.team_id}" selected="selected">
								</c:when>
								<c:otherwise>
									<option value="${teamVo.team_id}">
								</c:otherwise>
							</c:choose>																
								<c:if test="${teamVo.team_level == 1}">&nbsp;└</c:if>
								<c:if test="${teamVo.team_level == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
								${teamVo.team_name}																
						</c:forEach>
					</select>
				</span>
			</td>
			<th width="7%">이름</th>
			<td width="12%" style="text-align:left;padding-left:10px;">
				<input type="text" style="width: 130px;" id="srchUserName" name="srchUserName" value="${srchParam.srchUserName }"/>	
			</td>
			<th width="7%">재직상태</th>
			<td width="10%" style="text-align:left;padding-left:10px;">
				<select id="srchUserState" name="srchUserState" style="width: 105px;">																											
					<option value="99" <c:if test="${srchParam.srchUserState eq '99'}">selected</c:if> >- 전체 -</option>
					<option value="0" <c:if test="${srchParam.srchUserState eq '0'}">selected</c:if>>근무자</option>
					<option value="2" <c:if test="${srchParam.srchUserState eq '2'}">selected</c:if>>대기자</option>
					<option value="1"<c:if test="${srchParam.srchUserState eq '1'}">selected</c:if>>퇴사자</option>
					<option value="9" <c:if test="${srchParam.srchUserState eq '9'}">selected</c:if>>SA</option>													
				</select>													
			</td>
			<td align="center" width="18%">
				<a href="#noloc" class="btn-vacation-aprv" id="btn-search" onclick='doSearch();'>검색</a>&nbsp;
				<a href="#noloc" class="btn-vacation-aprv" style="width:80px;background:#A9F5A9;" id="btn-search" onclick='doBasePayCal();'>기본급 확정</a>
			</td>
		</tr>
	</table>
</div>	
</form>
<br/>
<div class="tableStyle99">
	<table>
		<tr>
			<th width="4%">No</th>
			<!-- <th width="15%">센터명</th> -->
			<th width="12%">팀명</th>
			<th width="5%">직급</th>
			<th width="11%">이름</th>			
			<th width="7%">입사일자</th>
			<th width="7%">근속일수</th>
			<th width="7%">경력일수</th>
			<th width="7%">휴직일수</th>
			<th width="5%">방식</th>
			<th width="7%">기본급</th>
			<th width="7%">근속수당</th>
			<th width="7%">팀장수당</th>
			<th width="7%">합계</th>
			<th width="8%">-</th>
		</tr>
	</table>
	<div id="salaryMemberList"></div>
</div>
<div id="salary-detail-dialog" title="기본급 설정 상세 보기" style="font-size: 15px;display:none;" align="center"></div>	
<!-- 기본급 설정 분류 끝 -->