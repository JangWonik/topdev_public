<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>서면심사(물) 실적등록</title>
    <link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css?v=20170411111520" />
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->
    
    <script src="./resources/jquery/jquery.min_1_12.js"></script>
    <script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
    <script src="./resources/ne_js/calendar.js?v=20170321111520"></script><!-- calendar -->
    <script src="./resources/jquery/jquery.mask.min.js"></script>
    
    <script src="./resources/wm_js/common.js"></script>
    <script src="./resources/cmm/js/common.js"></script>

	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>	
	
	<style>
	
		/* 모달창 셀렉트 박스 */
		.select2-container--default{
			text-align : left;
			font-color:#444;
			font-size:12px;
		}
		
		/*상세보기 버튼*/
		.btn-equipment-view {
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
			background: #eeeeee;
		}
		
		/*수정 버튼*/
		.btn-equipment-mod {
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
			color:#FFFFFF  !important;
			width:70px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #0033FF;
		}
		
		/*저장 버튼*/
		.btn-equipment-save {
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
			color:#FFFFFF  !important;
			width:70px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #3399FF;
		}
		
		/*취소 버튼*/
		.btn-equipment-cancel {
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
			color:#FFFFFF  !important;
			width:50px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #FF3333;
		}
	
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
			width:60px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #eeeeee;
		}

		.btn-vacation-aprv:active {
			position:relative;
			top:4px
		}
		
		/* 모달 버튼 */
		.ui-button-text-only {
			height:2.1em !important;
		}
	</style>
	<script>
	$(document).ready(function(){
		$("#tmAddMain").select2();
		$("#addUserNoMain").select2();
		
		$("#tmSearchMain").select2();
		$("#srchUserNoMain").select2();
		
		$("#t_trans_user_no").select2();
		
		$("#written_ptnr_id").select2();
		
		//사용자 검색에 퇴직자 포함할것인지 여부
		$("#outUserChk").change(function(){		
			
			if( $('input:checkbox[id="outUserChk"]').is(":checked") ){			
				$("#s_out_user").val(1);			
			}else{			
				$("#s_out_user").val(0);			
			}		
			
			//검색페이지까지 리프레쉬
			$("#searchForm").submit();
			
		});
		
		_initDatePicker();
		_initCalCalcelArea();
		_initCalTransArea();
	});
	
	function _initCalCalcelArea(){
		//취소건수 값이 변경될때 합계계산
		$(".cancelArea").on("blur",function(){			
			var cSum = 0;			
			$(".cancelArea").each(function(){
				if(!isNaN(this.value) && this.value.length != 0){
					cSum += parseFloat(this.value);
			    }
			});
			$("#cancalAreaSum").text(cSum+" 건");			
		});
	}
	
	function _initCalTransArea(){
		//이첩건수 값이 변경될때 합계계산
		$(".transArea").on("blur",function(){			
			var tSum = 0;			
			$(".transArea").each(function(){
				if(!isNaN(this.value) && this.value.length != 0){
					tSum += parseFloat(this.value);
			    }
			});
			$("#transAreaSum").text(tSum+" 건");			
		});
	}
	
	function _initMask(){
        var options = {
            onKeyPress : function(cep, event, currentField, options){
                var tid = event.currentTarget.id;
                var tidx = tid.substr(tid.length - 1, 1);                
            },
            reverse : true
        };
        
        $('input.count').mask('###',options);
        
    }
	
	function doModify(){
		
		var base_date = $("#baseDate").val();
		
		if( base_date == '' ){
			alert("등록(검색) 할 기준일을 입력해 주세요.");
			$("#baseDate").focus();
			return;
		}
		
		var list_total_size = $("#written_total_size").val();
		
		var state = 0;
		
		while( state < list_total_size){
			$("#written_view_"+state).hide();
			$("#written_edit_"+state).show();	
			state++;
		}
		_initDatePicker();
		$("#btn-modify").hide();
		$("#btn-save").show();
		$("#btn-cancel").show();
	}
	
	function doSearch(){
		
		var sUrl = "./getWrittenList";		
		
		var param = {};		
		param.s_team_id = $("#tmSearchMain").val();
		param.s_user_no = $("#srchUserNoMain").val();
		param.s_out_user = $("#s_out_user").val();
		param.s_base_date = $("#baseDate").val();
		param.s_ptnr_id = $("#written_ptnr_id").val();
		
		if( param.s_base_date == '' ){			
			alert("등록(검색) 할 기준일을 입력해 주세요.");
			$("#baseDate").focus();
			return;
		}
		
		$("#top_loading").show();
		
		//검색결과 페이지를 가져온다.
		$.ajax({
    		type: "POST",
    		url: sUrl,
    		data: param,
    		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    		dataType: "html",
    		timeout: 20000,    		         
    		success: function(data){
    			//console.log("data="+data);
    			$("#writtenList").html(data);    			
    			$("#btn-modify").show();
    			$("#btn-save").hide();
    			$("#btn-cancel").hide();
    			//이전날짜는 수정불가
    			nChkDate();
    		},            		
    		error: function (request, status, error) {
    			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
    		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
    		}            		
    	});
		
		//alert('test='+$("#tmSearchMain").val()+" : "+$("#srchUserNoMain").val()+ " : "+$("#outUserChkVal").val() +" : "+$("#baseDate").val());
		
	}	
	
	//일괄 수정 버튼활성화여부 체크 (오늘이후 날짜의 경우 등록 수정이 불가하도록 변경)
	function nChkDate(){
		
		//nChkDate = ( -1 : 과거, 0: 오늘, 1: 내일이후 )
		var nChkDate = $("#nChkDate").val();
		//var nChkDate = 1;
		
		if( nChkDate > 0 ){			
			$(".btn-equipment-mod").hide();
			$(".change-button").hide();
			$("#searchText").show();
		}else{
			$("#searchText").hide();
		}
	}
	
	//일괄 저장
	function doSave(){
		//일괄저장용 배열	
		var arrList = new Array();
		
		var list_total_size = $("#written_total_size").val();
		
		if( list_total_size == 0 ){
			alert("저장할 데이터가 없습니다.");
			return;
		}
		
		var total_trans_val = 0;
		
		//1개인경우 배열로 인식못함
		if( list_total_size == 1 ){
			//arrList[0] = $("#user_no_0").val()+"|"+$("#suim_cnt_0").val()+"|"+$("#end_cnt_0").val()+"|"+$("#unsolve_cnt_0").val()+"|"+$("#base_date_0").val()+"|"+$("#team_id_0").val();	
			//arrList[0] = $("#user_no_0").val()+"|"+$("#suim_cnt_0").val()+"|"+$("#end_cnt_0").val()+"|"+$("#cancel_cnt_0").val()+"|"+$("#trans_cnt_0").val()+"|"+$("#base_date_0").val()+"|"+$("#team_id_0").val();
			
			arrList[0] = $("#user_no_0").val()+"|"+$("#suim_cnt_0").val()+"|"+$("#end_cnt_0").val()+"|"+$("#base_date_0").val()+"|"+$("#team_id_0").val()+"|"+$("#ptnr_id_0").val();
			
			//total_trans_val = $("#trans_cnt_0").val();
			
		}else{
			for( var i=0; i < list_total_size; i++ ){
				//arrList[i] = $("#user_no_"+i).val()+"|"+$("#suim_cnt_"+i).val()+"|"+$("#end_cnt_"+i).val()+"|"+$("#unsolve_cnt_"+i).val()+"|"+$("#base_date_"+i).val()+"|"+$("#team_id_"+i).val();
				//arrList[i] = $("#user_no_"+i).val()+"|"+$("#suim_cnt_"+i).val()+"|"+$("#end_cnt_"+i).val()+"|"+$("#cancel_cnt_"+i).val()+"|"+$("#trans_cnt_"+i).val()+"|"+$("#base_date_"+i).val()+"|"+$("#team_id_"+i).val();
				
				arrList[i] = $("#user_no_"+i).val()+"|"+$("#suim_cnt_"+i).val()+"|"+$("#end_cnt_"+i).val()+"|"+$("#base_date_"+i).val()+"|"+$("#team_id_"+i).val()+"|"+$("#ptnr_id_"+i).val();
				
				//이내첩숫자는 합이 0이어야 한다.
				//total_trans_val = total_trans_val + parseInt($("#trans_cnt_"+i).val());				
			}
		}
		
		
		//alert("total_trans_val="+total_trans_val);
		
		/* if( total_trans_val != 0 ){
			alert("이·내첩건수의 합은 0이 되어야 합니다.");
			return;
		} */		
		
		$("#top_loading").show();
		
		var param = {};
		param.writtenList = arrList;			//배열형태로 넘김.
		
		var url = "./writtenUpdateAll";

	    $.ajax({
			type: "POST",
			url: url,
			data: param,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "JSON",
			traditional: true,						//배열허용
			timeout: 20000,
			success: function(data){				
				alert(data.msg);				
				doSearch();
				$("#btn-modify").hide();
				$("#btn-save").hide();
				$("#btn-cancel").hide();				                	
			}                
	    });
	}
	
	function doCancel(){				
		
		var list_total_size = $("#written_total_size").val();
		
		var state = 0;
		
		while( state < list_total_size){
			$("#written_view_"+state).show();
			$("#written_edit_"+state).hide();	
			state++;
		}
		_initDatePicker();
		$("#btn-modify").show();
		$("#btn-save").hide();
		$("#btn-cancel").hide();
	}
	
	function doDelete(p_serial_no){
		
		if(confirm("해당 데이터를 삭제(초기화) 하시겠습니까?")){
			
			var url = "./writtenDelete";
			
			var param = {};
			param.serial_no = p_serial_no;
			
			$.ajax({
				type: "POST",
				url: url,
				data: param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: "html",				
				timeout: 20000,
				success: function(data){
					if( data ){		//1인 경우 성공 
						alert("정보를 삭제(초기화)하였습니다.");
						doSearch();
						$("#btn-modify").hide();
						$("#btn-save").hide();
						$("#btn-cancel").hide();					
					}                	
				}                
		    });
		}
	}
	
	//이내첩 로그 modal
	function doTransView(p_user_no, p_team_id, p_team_name, p_user_name, p_base_date){
		
		var url = "writtenTransViewModal";
		
		var param = {};
		
		param.user_no = p_user_no;		
		param.team_id = p_team_id;
		param.team_name = p_team_name;
		param.user_name = p_user_name;
		param.base_date = p_base_date;
		
		$.ajax({
			type: "POST",
			url: url,
			data: param,
			timeout: 20000,				        
			dataType: "html", 
			success: function(data){				
				$("#writtenCancelView").html(data);				
				showViewDialog();
			},
			error: function(e){
			    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
			}
		});
	}
	
	//취소 로그 modal
	function doCancelView(p_user_no, p_team_id, p_team_name, p_user_name, p_base_date){		
		
		var url = "writtenCancelViewModal";
		
		var param = {};
		
		param.user_no = p_user_no;		
		param.team_id = p_team_id;
		param.team_name = p_team_name;
		param.user_name = p_user_name;
		param.base_date = p_base_date;
		
		$.ajax({
			type: "POST",
			url: url,
			data: param,
			timeout: 20000,				        
			dataType: "html", 
			success: function(data){				
				$("#writtenCancelView").html(data);				
				//showDialog();
				showViewDialog();
			},
			error: function(e){
			    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
			}
		});
	}
	
	function showDialog(){
		$("#cancel-action-dialog").dialog({
			height: 300,
			width: 600,
			closeOnEscape : true,
			draggable : true,					
			title: "서면심사 취소, 이내첩 내역 조회",
			buttons:{						
				"닫기" : function(){
					$(this).dialog("close");
				}
			},
			modal: true,
			overlay:{ opacity: 0., background: '#000000'}
		});
	}
	
	function showViewDialog(){
		$("#cancel-view-dialog").dialog({
			height: 300,
			width: 600,
			closeOnEscape : true,
			draggable : true,					
			title: "서면심사 취소, 이내첩 내역 조회",
			buttons:{						
				"닫기" : function(){
					$(this).dialog("close");
				}
			},
			modal: true,
			overlay:{ opacity: 0., background: '#000000'}
		});
	}
	
	//이내첩 modal
	function doTransModal(p_user_no, p_team_id, p_team_name, p_user_name, p_base_date){		
		//p_base_date 가 없으면 취소전 수임, 종결정보가 등록되지 않은 상태
		if( p_base_date == '' ){
			alert("해당기준일의 수임, 종결건수 등록후 이내첩처리가 가능합니다.");
			return;
		}
		
		//alert("취소 시작 : "+p_user_no + " : "+ p_base_date);
		
		$("#t_user_no").val(p_user_no);
		$("#t_team_id").val(p_team_id);
		$("#t_base_date").val(p_base_date);
		
		$("#t_team_name").text(p_team_name);
		$("#t_user_name").text(p_user_name);
		
		//창을 다시 여는 경우 c_tr_count 값 초기화
		$("#t_tr_count").val(0);		
		//추가했던 등록창 초기화
		$(".add_t_tr").remove();
		//이내첩 창 기본값 초기화
		$("#transAreaSum").text("0 건");
		$("#t_suim_date_0").val('');
		$("#t_suim_cnt_0").text('0');
		$("#t_end_cnt_0").text('0');
		$("#t_cancel_cnt_0").val(0);
		
		//이첩담당자 초기화
		$("#t_trans_user_no").val('0');
		$("#t_trans_user_no").trigger('change');
		
		//모달창을 불러온다.
		$("#trans-action-dialog").dialog({
			height: 420,
			width: 800,
			closeOnEscape : true,
			draggable : true,
			title: "이 내첩 처리",
			buttons:{
				"저장" : function(){
					//var action = fnWrittenCancelAction();
					var action = fnWrittenTransAction();
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
				
	}
	
	//이내첩 처리
	function fnWrittenTransAction(){
		
		var t_user_no = $("#t_user_no").val();
		var t_team_id = $("#t_team_id").val();
		var t_base_date = $("#t_base_date").val();
		var t_tr_count = parseInt($("#t_tr_count").val()) + 1;		//취소행은 1부터 시작됨 (배열)
				
		//alert("수임취소 저장할 정보 : "+c_user_no+" : "+c_tr_count);
		
		//일괄취소용 배열	
		var arrList = new Array();
		
		//alert("c_tr_count="+c_tr_count);		
		
		//1개인 경우 배열로 인식못함
		if( t_tr_count == 1 ){
			//arrList[0] = t_user_no+"|"+t_team_id+"|"+t_base_date+"|"+$("#t_suim_date_0").val()+"|"+$("#t_trans_cnt_0").val()+"|"+$("#t_trans_user_no_0").val();
			arrList[0] = t_user_no+"|"+t_team_id+"|"+t_base_date+"|"+$("#t_suim_date_0").val()+"|"+$("#t_trans_cnt_0").val()+"|"+$("#t_trans_user_no").val();
			if( $("#t_suim_date_0").val() == '' ){
				alert("이첩할 수임일자를 입력해주세요.");
				return;
			}
			
			if( $("#t_trans_user_no").val() == '0' ){
				alert("이첩대상자를 선택해주세요.");
				return;
			}
			
			if( t_user_no == $("#t_trans_user_no").val() ){			
				alert("이 내첩 대상자가 동일합니다.");
				return;
			}
			
		}else{
			for( var i=0; i < t_tr_count; i++ ){
				//arrList[i] = t_user_no+"|"+t_team_id+"|"+t_base_date+"|"+$("#t_suim_date_"+i).val()+"|"+$("#t_trans_cnt_"+i).val()+"|"+$("#t_trans_user_no_"+i).val();
				arrList[i] = t_user_no+"|"+t_team_id+"|"+t_base_date+"|"+$("#t_suim_date_"+i).val()+"|"+$("#t_trans_cnt_"+i).val()+"|"+$("#t_trans_user_no").val();
				
				if( $("#t_suim_date_"+i).val() == '' ){
					alert("이첩할 수임일자를 입력해주세요.");
					return;
				}
				
				if( $("#t_trans_user_no").val() == '0' ){
					alert("이첩대상자를 선택해주세요.");
					return;
				}
				
				if( t_user_no == $("#t_trans_user_no").val() ){
					alert("이 내첩 대상자가 동일합니다.");
					return;
				}
			}
		}
		
		var param = {};
		param.transList = arrList;			//배열형태로 넘김.
		
		var url = "./writtenTransAll";
		
		$.ajax({
			type: "POST",
			url: url,
			data: param,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "JSON",
			traditional: true,						//배열허용
			timeout: 20000,
			success: function(data){				
				alert(data.msg);
				
				//취소 창 관련 데이터 초기화 후 창닫기
				$("#t_tr_count").val(0);
				$(".add_t_tr").remove();				
				$("#transAreaSum").text("0 건");
				$("#t_suim_date_0").val('');
				$("#t_suim_cnt_0").text('0');
				$("#t_end_cnt_0").text('0');
				$("#t_trans_cnt_0").val(0);
				$("#t_trans_user_no").val('0');
				
				$("#trans-action-dialog").dialog("close");
				
				doSearch();
			}                
	    });
	}
	
	//취소 modal
	function doCancelModal(p_user_no, p_team_id, p_team_name, p_user_name, p_base_date){		
		//p_base_date 가 없으면 취소전 수임, 종결정보가 등록되지 않은 상태
		if( p_base_date == '' ){
			alert("해당기준일의 수임, 종결건수 등록후 취소가 가능합니다.");
			return;
		}
		
		//alert("취소 시작 : "+p_user_no + " : "+ p_base_date);
		
		$("#c_user_no").val(p_user_no);
		$("#c_team_id").val(p_team_id);
		$("#c_base_date").val(p_base_date);
		
		$("#c_team_name").text(p_team_name);
		$("#c_user_name").text(p_user_name);
		$("#c_base_date_val").text(p_base_date);
		
		//창을 다시 여는 경우 c_tr_count 값 초기화
		$("#c_tr_count").val(0);		
		//추가했던 등록창 초기화
		$(".add_c_tr").remove();
		//취소창 기본값 초기화
		$("#cancalAreaSum").text("0 건");
		$("#c_suim_date_0").val('');
		$("#c_suim_cnt_0").text('0');
		$("#c_end_cnt_0").text('0');
		$("#c_cancel_cnt_0").val(0);
		
		//모달창을 불러온다.
		$("#cancel-action-dialog").dialog({
			height: 420,
			width: 600,
			closeOnEscape : true,
			draggable : true,
			title: "수임 취소",
			buttons:{
				"저장" : function(){
					var action = fnWrittenCancelAction();
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
				
	}
	
	//수임취소 저장
	function fnWrittenCancelAction(){
		var c_user_no = $("#c_user_no").val();
		var c_team_id = $("#c_team_id").val();
		var c_base_date = $("#c_base_date").val();
		var c_tr_count = parseInt($("#c_tr_count").val()) + 1;		//취소행은 1부터 시작됨 (배열)		
		
		//alert("수임취소 저장할 정보 : "+c_user_no+" : "+c_tr_count);
		
		//일괄취소용 배열	
		var arrList = new Array();
		
		//alert("c_tr_count="+c_tr_count);		
		
		//1개인 경우 배열로 인식못함
		if( c_tr_count == 1 ){
			arrList[0] = c_user_no+"|"+c_team_id+"|"+c_base_date+"|"+$("#c_suim_date_0").val()+"|"+$("#c_cancel_cnt_0").val();
			if( $("#c_suim_date_0").val() == '' ){
				alert("취소할 수임일자를 입력해주세요.");
				return;
			}
		}else{
			for( var i=0; i < c_tr_count; i++ ){
				arrList[i] = c_user_no+"|"+c_team_id+"|"+c_base_date+"|"+$("#c_suim_date_"+i).val()+"|"+$("#c_cancel_cnt_"+i).val();
				
				if( $("#c_suim_date_"+i).val() == '' ){
					alert("취소할 수임일자를 입력해주세요.");
					return;
				}
			}
		}
		
		var param = {};
		param.cancelList = arrList;			//배열형태로 넘김.
		
		//var url = "./writtenUpdateAll";
		var url = "./writtenCancelAll";
		
		$.ajax({
			type: "POST",
			url: url,
			data: param,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "JSON",
			traditional: true,						//배열허용
			timeout: 20000,
			success: function(data){				
				alert(data.msg);
				
				//취소 창 관련 데이터 초기화 후 창닫기
				$("#c_tr_count").val(0);
				$(".add_c_tr").remove();				
				$("#cancalAreaSum").text("0 건");
				$("#c_suim_date_0").val('');
				$("#c_suim_cnt_0").text('0');
				$("#c_end_cnt_0").text('0');
				$("#c_cancel_cnt_0").val(0);				
				
				$("#cancel-action-dialog").dialog("close");
				
				doSearch();
			}                
	    });
		
	}
	
	function _initDatePicker(){
        $(".calendar").datepicker({
            showOn: 'button',
            buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
            buttonImageOnly: true,
            buttonText: "달력",
            changeMonth: true,
            changeYear: true,
            showButtonPanel: false
        });
    }
	
	function addTransTr(){
		
		var t_tr_row = $("#t_tr_count").val();
		var t_tr_base = "t_tr_"+$("#t_tr_count").val();
				
		t_tr_row++;		
		$("#t_tr_count").val(t_tr_row);
		
		var addTTr = "";
		
		addTTr = 
			'<tr id="t_tr_'+t_tr_row+'" class="add_t_tr">'+
				'<td><input class="calendar" id="t_suim_date_'+t_tr_row+'" style="width: 80%;"/>'+
				'</td>'+
				'<td><a href="javascript:getTransInfo('+t_tr_row+')" class="btn-equipment-save" id="get-data">불러오기</a></td>'+
				'<td><span id="t_suim_cnt_'+t_tr_row+'" style="color:blue">0</span></td>'+
				'<td><span id="t_end_cnt_'+t_tr_row+'" style="color:red">0</span></td>'+				
				'<td><input type="text" id="t_trans_cnt_'+t_tr_row+'"  class="transArea" style="width: 60%;text-align:right;" value="0"> 건</td>'+
			'</tr>';			
		
		var trHtml = $("#"+t_tr_base);
		trHtml.after(addTTr);
		
		_initDatePicker();
		_initCalTransArea();
		//$("#t_trans_user_no_"+t_tr_row).select2();
	}
	
	function delTransTr(){
		var t_tr_row = $("#t_tr_count").val();		
		var t_tr_base = "t_tr_"+$("#t_tr_count").val();
		
		var trHtml = $("#"+t_tr_base);		
		
		if( t_tr_row == 0 ){
			alert("첫 행은 삭제할 수 없습니다.");
		}else{
			trHtml.remove();
			t_tr_row--;		
			$("#t_tr_count").val(t_tr_row);
		}
	}
	
	function addCancalTr(){
		
		var c_tr_row = $("#c_tr_count").val();
		var c_tr_base = "c_tr_"+$("#c_tr_count").val();
				
		c_tr_row++;		
		$("#c_tr_count").val(c_tr_row);		
		//alert("c_tr_row="+c_tr_row);
		
		var addCTr = "";
		
		addCTr = 
			'<tr id="c_tr_'+c_tr_row+'" class="add_c_tr">'+			
				'<td><input class="calendar" id="c_suim_date_'+c_tr_row+'" style="width: 80%;"/>'+
				'</td>'+
				'<td><a href="javascript:getCancelInfo('+c_tr_row+')" class="btn-equipment-save" id="get-data">불러오기</a></td>'+
				'<td><span id="c_suim_cnt_'+c_tr_row+'" style="color:blue">0</span></td>'+
				'<td><span id="c_end_cnt_'+c_tr_row+'" style="color:red">0</span></td>'+
				'<td><input type="text" id="c_cancel_cnt_'+c_tr_row+'"  class="cancelArea" style="width: 60%;text-align:right;" value="0"> 건</td>'+
			'</tr>';
			
		//alert("c_tr_base="+c_tr_base);
		var trHtml = $("#"+c_tr_base);
		trHtml.after(addCTr);
		
		_initDatePicker();
		_initCalCalcelArea();
	}
	
	function delCancalTr(){
		var c_tr_row = $("#c_tr_count").val();		
		var c_tr_base = "c_tr_"+$("#c_tr_count").val();
		
		var trHtml = $("#"+c_tr_base);		
		
		if( c_tr_row == 0 ){
			alert("첫 행은 삭제할 수 없습니다.");
		}else{
			trHtml.remove();
			c_tr_row--;		
			$("#c_tr_count").val(c_tr_row);
		}
	}
	
	//ajax 로 취소전 수입종결 건수를 가져온다.
	function getCancelInfo(p_param){
		
		//특정일의 수임 종결 수를 가져온다.
		var url = "/getWrittenSuimInfo";
		
		var chk_user_no = $("#c_user_no").val();
		var chk_base_date = $("#c_suim_date_"+p_param).val();
		
		var temp_suim_cnt = 0;
		var temp_end_cnt = 0;
		
		var param = {};		
		param.user_no = chk_user_no;
		param.base_date = chk_base_date; 
		
		if( chk_base_date == '' ){
			alert('불러올 수임일자를 입력하세요.');
			return;
		}else{
			//alert(chk_base_date +"의 수임, 종결건수를 불러왔습니다.");
			$("#top_loading").show();
			$.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        timeout: 20000,
		        dataType: "JSON", 
		        success: function(data){	        	
		        	temp_suim_cnt = data.suimCnt;
		        	temp_end_cnt = data.endCnt;
		        	$("#c_suim_cnt_"+p_param).text(temp_suim_cnt);
		        	$("#c_end_cnt_"+p_param).text(temp_end_cnt);
		        	$("#top_loading").hide();
		        },		        
		        error:function(request,status,error){	            
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요. ("+request.responseText+")");
				}
		    });
			
		}
		
	}
	
	function getTransInfo(p_param){
		
		//특정일의 수임 종결 수를 가져온다.
		var url = "/getWrittenSuimInfo";
		
		var chk_user_no = $("#t_user_no").val();
		var chk_base_date = $("#t_suim_date_"+p_param).val();
		
		var temp_suim_cnt = 0;
		var temp_end_cnt = 0;
		
		var param = {};		
		param.user_no = chk_user_no;
		param.base_date = chk_base_date; 
		
		if( chk_base_date == '' ){
			alert('불러올 수임일자를 입력하세요.');
			return;
		}else{
			//alert(chk_base_date +"의 수임, 종결건수를 불러왔습니다.");
			$("#top_loading").show();
			$.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        timeout: 20000,
		        dataType: "JSON", 
		        success: function(data){	        	
		        	temp_suim_cnt = data.suimCnt;
		        	temp_end_cnt = data.endCnt;
		        	$("#t_suim_cnt_"+p_param).text(temp_suim_cnt);
		        	$("#t_end_cnt_"+p_param).text(temp_end_cnt);
		        	$("#top_loading").hide();
		        },		        
		        error:function(request,status,error){	            
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요. ("+request.responseText+")");
				}
		    });
			
		}
		
	}
	
	//취소내역 삭제
	function cancelDel(p_serial_no){
		
		var param = {};
		
		param.serial_no = p_serial_no;
		
		if(confirm('해당 취소건을 삭제 하시겠습니까?')){
			
			//특정일의 수임 종결 수를 가져온다.
			var url = "/deleteWrittenCancel";
			$.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        timeout: 20000,
		        dataType: "JSON", 
		        success: function(data){
		        	//모달 전체 창 닫기
					$(".ui-dialog-content").dialog("close");
					doSearch();
		        	alert("삭제되었습니다.");
		        	doCancelView(data.userNo,data.teamId,data.teamName,data.userName,data.baseDateFmt);		        	
		        },		        
		        error:function(request,status,error){	            
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요. ("+request.responseText+")");
				}
		    });
			
		}
		
	}
</script>
</head>
<body>
<!-- 이내첩 팝업시작 -->
<form name="writtenTransFrm" id="writtenTransFrm" method="post">
<input type="hidden" id="t_user_no" name="t_user_no"/>
<input type="hidden" id="t_team_id" name="t_team_id"/>
<input type="hidden" id="t_base_date" name="t_base_date"/>
<input type="hidden" id="t_tr_count" name="t_tr_count" value="0"/>
<div id="trans-action-dialog" title="이내첩처리" style="font-size: 15px;display:none;" align="center">
	<br/>
	<div class="tableStyle2">
		<table class="vacation-ins-table">					
			<tbody>	
				<tr>
					<th width="10%">부서명</th>
					<td width="20%"><span id="t_team_name"></span></td>
					<th width="10%">이름</th>
					<td width="20%"><span id="t_user_name"></span></td>
					<th width="10%">이첩대상자</th>
					<td width="30%">
						<select id="t_trans_user_no" name="t_trans_user_no" style="width:120px;text-align:left;">
							<option value="0" <c:if test="${empty s_user_no}">selected</c:if> > - 선택 - </option>											
							<c:forEach items="${memberList}" var="item" >
								<option value="${item.userNo}" <c:if test="${s_user_no == item.userNo}">selected</c:if> >${item.userName}</option>									
							</c:forEach>										
						</select>
					</td>
				</tr>
			</tbody>																																										
		</table>
		<div style="display: inline-block;float:left;text-align:left;padding:5px 5px 5px 5px;">
			<span style="font-family:굴림;font-size:12px;font-weight:bold;">
				이내첩합계 : 
			</span>
			<span style="font-family:굴림;font-size:12px;font-weight:bold;color:blue;" id="transAreaSum">
				0 건
			</span>			
		</div>		
		<div style="display: inline-block;float:right;text-align:right;padding:5px 5px 5px">
			<a href="javascript:addTransTr();">
				<img src="/resources/ls_img/btn_add_s.gif" style="cursor:pointer;">
			</a>
			
			<a href="javascript:delTransTr();">
				<img src="/resources/ls_img/btn_del_s.gif" style="cursor:pointer;">
			</a>
		</div>
		<table class="vacation-ins-table">					
			<tbody>	
				<tr>
					<th width="20%">수임일자</th>
					<th width="20%">수임종결확인</th>
					<th width="20%">수임건수</th>
					<th width="20%">종결건수</th>
					<!-- <th width="20%">이첩대상자</th> -->
					<th width="20%">이첩건수</th>
				</tr>
				<tr id="t_tr_0">
					<td>
						<input class="calendar" id="t_suim_date_0" style="width: 80%;"/>
					</td>
					<td><a href="javascript:getTransInfo(0)" class="btn-equipment-save" id="get-data">불러오기</a></td>
					<td><span id="t_suim_cnt_0" style="color:blue">0</span></td>
					<td><span id="t_end_cnt_0" style="color:red">0</span></td>
					<%-- <td>
						<select id="t_trans_user_no_0" name="t_trans_user_no_0" style="width:120px;text-align:left;">
							<option value="0" <c:if test="${empty s_user_no}">selected</c:if> > - 선택 - </option>											
							<c:forEach items="${memberList}" var="item" >
								<option value="${item.userNo}" <c:if test="${s_user_no == item.userNo}">selected</c:if> >${item.userName}</option>									
							</c:forEach>										
						</select>
					</td> --%>
					<td><input type="text" id="t_trans_cnt_0" class="transArea" style="width: 60%;text-align:right;" value="0"> 건</td>
				</tr>
			</tbody>																																										
		</table>
	</div>
</div>
</form>
<!-- 이내첩 팝업끝 -->

<!-- 수임취소,이내첩 내역 조회시작 -->
<div id="writtenCancelView" class="dialogbox"></div>
<!-- 수임취소,이내첩 내역 조회끝 -->
<!-- 수임취소 팝업시작 -->
<form name="writtenCancelFrm" id="writtenCancelFrm" method="post">
<input type="hidden" id="c_user_no" name="c_user_no"/>
<input type="hidden" id="c_team_id" name="c_team_id"/>
<input type="hidden" id="c_base_date" name="c_base_date"/>
<input type="hidden" id="c_tr_count" name="c_tr_count" value="0"/>
<div id="cancel-action-dialog" title="수임취소" style="font-size: 15px;display:none;" align="center">
	<br/>
	<div class="tableStyle2">
		<table class="vacation-ins-table">					
			<tbody>	
				<tr>
					<th width="10%">부서명</th>
					<td width="20%"><span id="c_team_name"></span></td>
					<th width="10%">이름</th>
					<td width="20%"><span id="c_user_name"></span></td>
					<th width="10%">기준일</th>
					<td width="20%"><span id="c_base_date_val"></span></td>
				</tr>
			</tbody>																																										
		</table>
		<div style="display: inline-block;float:left;text-align:left;padding:5px 5px 5px 5px;">
			<span style="font-family:굴림;font-size:12px;font-weight:bold;">
				취소합계 : 
			</span>
			<span style="font-family:굴림;font-size:12px;font-weight:bold;color:blue;" id="cancalAreaSum">
				0 건
			</span>			
		</div>		
		<div style="display: inline-block;float:right;text-align:right;padding:5px 5px 5px">
			<a href="javascript:addCancalTr();">
				<img src="/resources/ls_img/btn_add_s.gif" style="cursor:pointer;">
			</a>
			
			<a href="javascript:delCancalTr();">
				<img src="/resources/ls_img/btn_del_s.gif" style="cursor:pointer;">
			</a>
		</div>
		<table class="vacation-ins-table">					
			<tbody>	
				<tr>
					<th width="25%">수임일자</th>
					<th width="25%">수임종결확인</th>
					<th width="15%">수임건수</th>
					<th width="15%">종결건수</th>
					<th width="20%">취소건수</th>
				</tr>
				<tr id="c_tr_0">
					<td>
						<input class="calendar" id="c_suim_date_0" style="width: 80%;"/>
					</td>
					<td><a href="javascript:getCancelInfo(0)" class="btn-equipment-save" id="get-data">불러오기</a></td>
					<td><span id="c_suim_cnt_0" style="color:blue">0</span></td>
					<td><span id="c_end_cnt_0" style="color:red">0</span></td>
					<td><input type="text" id="c_cancel_cnt_0" class="cancelArea" style="width: 60%;text-align:right;" value="0"> 건</td>
				</tr>
			</tbody>																																										
		</table>
	</div>
</div>
</form>
<!-- 수임취소 팝업 끝 -->
<div id="wrapper">
	<!-- top menu import -->
	<c:import url="../top_statistics/statistics_menu.jsp"></c:import>
	
	<!-- contents -->
	<div id="container">
		<div class="contetns">
		<!-- centercnt_top -->
			<div class="center_cnt_1300">
				<!-- centercnt_bot -->
				<div class="center_cnt_vacation" >
					<div class="guest">
						<div style="float: left;padding:10px 0 10px;">
							<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" >
							&nbsp;&nbsp;<b>서면심사(물) 실적등록</b>								
                          	</div>
					</div>			
					<!-- 일괄등록 검색 창 시작 -->
					<div class="guestTap">												
						<form id="searchForm" name="searchForm" method="post" action="writtenReviewManage">
						<input type="hidden" id="s_out_user" name=s_out_user value="0" />																							
						<div class="tableStyle99">							
							<table style="width: 100%;height:30px;" align="center">								
								<tr>
									<th width="60px;">보험사</th>
									<td width="120px;" style="text-align:center;">
										<select id="written_ptnr_id" name="written_ptnr_id" style="width:110px;">
											<option value="0">- 전체 -</option>
											<c:forEach items="${writtenPtnrIdList}" var="ptnrInfo" varStatus="status">														
												<option value="${ptnrInfo.ptnr_id}">${ptnrInfo.ptnr_nick}</option>																											
											</c:forEach>
										</select>																				
									</td>									
									<th width="60px;">부서명</th>
									<td width="140px;" style="text-align:center;">
										<select id="tmSearchMain" name="tmSearchMain" style="width:130px;text-align:left;">
											<option value="" <c:if test="${empty s_team_id}">selected</c:if> > - 전체 - </option>										
											<c:forEach items="${teamList}" var = "teamVo">
												<option value="${teamVo.teamId}"
													<c:if test="${s_team_id eq teamVo.teamId}">selected</c:if>>
													<c:if test="${teamVo.teamLevel == 1}">&nbsp;└</c:if>
													<c:if test="${teamVo.teamLevel == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
													${teamVo.teamName}
												</option>
											</c:forEach>
										</select>										
									</td>
									<th width="60px;">
										이 름
									</th>
									<td width="200px;" style="text-align:center;">
										<select id="srchUserNoMain" name="srchUserNoMain" style="width:100px;text-align:left;">
											<option value="" <c:if test="${empty s_user_no}">selected</c:if> > - 전체 - </option>											
											<c:forEach items="${memberList}" var="item" >
												<option value="${item.userNo}" <c:if test="${s_user_no == item.userNo}">selected</c:if> >${item.userName}</option>									
											</c:forEach>										
										</select>
										&nbsp;<input type="checkbox" id="outUserChk" <c:if test="${s_out_user eq 1}">checked</c:if>> 퇴직자포함
									</td>
									<th width="60px;">기준일</th>
									<td width="130px;" style="text-align:center;">
										<input type="text" class="classCalendar" id="baseDate" name="baseDate" style="width:100px;" value="${s_base_date}"/>										 
									</td>									
									<td style="text-align:center;"  width="100px;">
										<a href="#noloc" class="btn-vacation-aprv" id="btn-search" onclick='javascript:doSearch();'>검색</a>
									</td>
									<td style="padding-left:5px;">
										<span id="searchText">※ 정보등록이전 날짜 및 오늘 이후날짜는 수정이 불가합니다.</span>
										<a href="#noloc" style="display:none;" class="btn-equipment-mod" id="btn-modify" onclick='javascript:doModify();'>일괄수정</a>
										<a href="#noloc" style="display:none;" class="btn-equipment-save" id="btn-save" onclick='javascript:doSave();'>일괄저장</a>
										<a href="#noloc"  style="display:none;" class="btn-equipment-cancel" id="btn-cancel" onclick='javascript:doCancel();'>취소</a>
									</td>
								</tr>
							</table>					
							<br/>					
							<table>
								<tr>
									<th width="120px;">보험사</th>
									<th width="140px;">센터명</th>
									<th width="120px;">부서명</th>
									<th width="100px;">이 름</th>
									<th width="85px;">수임건수</th>
									<th width="85px;">종결건수</th>
									<th width="85px;">취소건수</th>
									<th width="85px;">이&middot;내첩건수</th>										
									<th width="85px;">미결건수</th>
									<th width="100px;">기준일</th>
									<th width="100px;">등록일</th>
									<!-- <th width="110px;">기능</th> -->
									<th width="15px;"></th>
								</tr>								
							</table>
							<div id="writtenList" style="overflow:scroll; width:1299px; height:700px;"></div>
						</div>
						</form>
					</div>
					<!-- 일괄등록 검색 창 시작 -->
				</div>
			</div>
		</div>
		<!-- //통합로딩바 -->
		<div id="top_loading" style="display: none;">
			<img id="loading-image" src="/resources/cmm/images/spinner.gif" alt="Loading..." />
		</div>
		<!-- //통합로딩바끝 -->	
	</div>	
</div>
</body>
</html>