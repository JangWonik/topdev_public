<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<script type="text/javascript">
	$(document).ready(function(){
		_initDatePicker();
		
		getAccList();		//현장진행사항 불러오기
		getContentList();		//특이사항 및 민원 예방 활동 불러오기
		getReportList();		//제출일자 불러오기
	});
	
	function fnReportSave(suim_rpt_no){		
		
		var param = {};
		
		param.suimRptNo = suim_rpt_no;
		param.reportDate = $("#reportDate").val();
		param.action = "report";
		
		$.ajax({
			type : "post",
			url : "/meritz/meritz_mid_content_action",					
			data : param,
			success : function(result){			
				if( result == 'success' ){
					alert('저장하였습니다.');
					fnReportCancel();		//초기상태로 돌아간다.	
				}else{
					alert('저장에 실패하였습니다.');
					fnReportCancel();		//초기상태로 돌아간다.	
				}
								
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});		
		
	}
	
	function fnReportCancel(){
		$("#btn_report_edit").show();
	    $("#btn_report_save").hide();
	    $("#btn_report_cancel").hide();	    
	    
	    $("#report_edit_type").val("view");		//모드를 보기모드로 변경한다.
	  	getReportList();
	}
	
	function fnReportEdit(){		
	    $("#btn_report_edit").hide();
	    $("#btn_report_save").show();
	    $("#btn_report_cancel").show();	    
	    
	    $("#report_edit_type").val("edit");		//모드를 에디트모드로 변경한다.
	  	getReportList();	    
	}
	
	function fnContentEdit(){		
	    $("#btn_content_edit").hide();
	    $("#btn_content_save").show();
	    $("#btn_content_cancel").show();	    
	    
	    $("#content_edit_type").val("edit");		//모드를 에디트모드로 변경한다.
	  	getContentList();	    
	}
	
	function fnContentCancel(){
		$("#btn_content_edit").show();
	    $("#btn_content_save").hide();
	    $("#btn_content_cancel").hide();	    
	    
	    $("#content_edit_type").val("view");		//모드를 보기모드로 변경한다.
	  	getContentList();
	}
	
	function fnContentSave(suim_rpt_no){
		var minwon_act_comment_val = $("#minwon_act_comment").val();
		
		minwon_act_comment_val = minwon_act_comment_val.replace(/(?:\r\n|\r|\n)/g, '<br/>');
		
		var param = {};
		
		param.suimRptNo = suim_rpt_no;
		param.minwonActComment = minwon_act_comment_val;
		param.action = "minwon";
		
		$.ajax({
			type : "post",
			url : "/meritz/meritz_mid_content_action",					
			data : param,
			success : function(result){			
				if( result == 'success' ){
					alert('저장하였습니다.');
					fnContentCancel();		//초기상태로 돌아간다.	
				}else{
					alert('저장에 실패하였습니다.');
					fnContentCancel();		//초기상태로 돌아간다.	
				}
								
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});		
		
	}
	
	function fnAccEdit(){		
	    $("#btn_acc_edit").hide();
	    $("#btn_acc_save").hide();
	    $("#btn_acc_cancel").show();	    
	    
	    $("#acc_edit_type").val("edit");		//모드를 에디트모드로 변경한다.
	  	getAccList();
	}
		
	function fnAccCancel(){
		$("#btn_acc_edit").show();
	    $("#btn_acc_save").show();
	    $("#btn_acc_cancel").hide();	    
	    
	    $("#acc_edit_type").val("view");		//모드를 조회로 변경한다.
	  	getAccList();
	}
	
	function fnAccSave(){
		$("#btn_acc_edit").hide();
	    $("#btn_acc_save").hide();
	    $("#btn_acc_cancel").show();	    
	    
	    $("#acc_edit_type").val("add");		//모드를 에디트모드로 변경한다.
	  	getAccList();
	}
	
    function fnReportWord(){
        var cw=screen.availWidth;
        var ch=screen.availHeight;

        var sw=1000; //띄울 창의 넓이
        var sh=740;  //띄울 창의 높이

        var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
        var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치

        window.open('/meritz/reportMeritzMidInfo?suim_rpt_no='+'${param.suim_rpt_no}'+'&cmd=word','word','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
    }

    function fnReportMidPrint(){
        var cw=screen.availWidth;
        var ch=screen.availHeight;

        var sw=700; //띄울 창의 넓이
        var sh=550;  //띄울 창의 높이

        var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
        var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치

        window.open('/meritz/reportMeritzMidInfo?suim_rpt_no='+'${param.suim_rpt_no}'+'&cmd=print','print','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
    }
    
	/* DatePicker 적용 */
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
		
		$(".calendar").keypress(function(){
	 		if (event.keyCode == 8){ 
	 			return false;
	 		}
			if($(this).val().length == 4 || $(this).val().length == 7){
				$(this).val($(this).val()+"-")
			}
		});
	}
	
	function getAccList(){			//현장진행사항 불러오기		
		var formData = $("#accForm").serialize();
		$.ajax({
			type : "post",
			url : "/meritz/meritz_mid_acc",					
			data : formData,
			success : function(result){				
				$("#acc_list").html(result);				
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});
	}
	
	function getContentList(){			//특이사항 및 민원예방활동 불러오기		
		var formData = $("#contentForm").serialize();
		$.ajax({
			type : "post",
			url : "/meritz/meritz_mid_content",					
			data : formData,
			success : function(result){				
				$("#content_list").html(result);				
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});
	}
	
	function getReportList(){
		var formData = $("#reportForm").serialize();
		$.ajax({
			type : "post",
			url : "/meritz/meritz_mid_report",					
			data : formData,
			success : function(result){				
				$("#report_list").html(result);				
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});
	}
	
	function accModify(serial_no){		
		
		var controlDateVal_mod = "#controlDateVal_"+serial_no;
		var controlWhoVal_mod = "#controlWhoVal_"+serial_no;
		var controlContactVal_mod = "#controlContactVal_"+serial_no;
		var controlMemoVal_mod = "#controlMemoVal_"+serial_no;
				
		if( $(controlDateVal_mod).val() == '' ){
			alert('진행일자를 입력해주세요.');
			$(controlDateVal_mod).focus();
			return;
		}
		
		if( $(controlWhoVal_mod).val() == '' ){
			alert('대상자를 입력해주세요.');
			$(controlWhoVal_mod).focus();
			return;
		}
		
		if( $(controlContactVal_mod).val() == '' ){
			alert('접촉방법을 입력해주세요.');
			$(controlContactVal_mod).focus();
			return;
		}
		
		if( $(controlMemoVal_mod).val() == '' ){
			alert('진행내용을 입력해주세요.');
			$(controlMemoVal_mod).focus();
			return;
		}
		
		var param = {};
		
		param.controlDate = $(controlDateVal_mod).val();
		param.controlWho = $(controlWhoVal_mod).val()
		param.controlContact = $(controlContactVal_mod).val();
		param.controlMemo = $(controlMemoVal_mod).val();
		param.suimRptNo = $("#suim_rpt_no").val();
		param.serialNo = serial_no;		
		param.action = "mod";
		
		$.ajax({
			type : "post",
			url : "/meritz/meritz_mid_acc_action",					
			data : param,
			success : function(result){			
				if( result == 'success' ){
					alert('수정하였습니다.');
					fnAccCancel();		//초기상태로 돌아간다.	
				}else{
					alert('수정에 실패하였습니다.');
					fnAccCancel();		//초기상태로 돌아간다.	
				}
								
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});
		
		
	}
	
	function accDelete(serial_no){
		var param = {};
		
		param.serialNo = serial_no;
		param.action = "del";
		
		if(confirm("해당 진행사항을 삭제하시겠습니까?")){
			$.ajax({
				type : "post",
				url : "/meritz/meritz_mid_acc_action",					
				data : param,
				success : function(result){			
					if( result == 'success' ){
						alert('삭제하였습니다.');
						fnAccEdit();		//수정상태로 돌아간다.	
					}else{
						alert('삭제에 실패하였습니다.');
						fnAccEdit();		//수정상태로 돌아간다.	
					}
									
				},
				error: function (request, status, error) {			
					console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
				}
			});	
		}
		
	}
	
function accAdd(){
		
		if( $("#controlDateVal").val() == '' ){
			alert('진행일자를 입력해주세요.');
			$("#controlDateVal").focus();
			return;
		}
		
		if( $("#controlWhoVal").val() == '' ){
			alert('대상자를 입력해주세요.');
			$("#controlWhoVal").focus();
			return;
		}
		
		if( $("#controlContactVal").val() == '' ){
			alert('접촉방법을 입력해주세요.');
			$("#controlContactVal").focus();
			return;
		}
		
		if( $("#controlMemoVal").val() == '' ){
			alert('진행내용을 입력해주세요.');
			$("#controlMemoVal").focus();
			return;
		}
		
		var param = {};
		
		param.controlDate = $("#controlDateVal").val();
		param.controlWho = $("#controlWhoVal").val();
		param.controlContact = $("#controlContactVal").val();
		param.controlMemo = $("#controlMemoVal").val();
		param.suimRptNo = $("#suim_rpt_no").val();
		param.action = "add";
		
		//alert("param="+$("#suim_rpt_no").val()+" : "+$("#controlDateVal").val()+": "+$("#controlWhoVal").val()+" : "+$("#controlContactVal").val()+" : "+$("#controlMemoVal").val());
		
		$.ajax({
			type : "post",
			url : "/meritz/meritz_mid_acc_action",					
			data : param,
			success : function(result){			
				if( result == 'success' ){
					alert('추가하였습니다.');
					fnAccCancel();		//초기상태로 돌아간다.	
				}else{
					alert('추가에 실패하였습니다.');
					fnAccCancel();		//초기상태로 돌아간다.	
				}
								
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});
				
	}
	
</script>

<div class="reportWrap">
    <div class="reportContent">
    	<!-- 현장진행사항 폼 -->
    	<form name="accForm" id="accForm" method="post">
		<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${param.suim_rpt_no}">
		<input type="hidden" id="acc_edit_type" name="acc_edit_type" value="view">		
		</form>
		
		<!-- 특이사항 및 민원예방활동 폼 -->
		<form name="contentForm" id="contentForm" method="post">
		<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${param.suim_rpt_no}">
		<input type="hidden" id="content_edit_type" name="content_edit_type" value="view">		
		</form>
		
		<!-- 보고서 제출일자 수정 폼 -->
    	<form name="reportForm" id="reportForm" method="post">
		<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${param.suim_rpt_no}">
		<input type="hidden" id="report_edit_type" name="report_edit_type" value="view">		
		</form>
		
        <input type="hidden" id="suim_rpt_no" value="${param.suim_rpt_no}">
        <input type="hidden" id="rpt_print_no" value="${rptBasic.rptPrintNo}">        
        <div class="text-right">
            <a href="/meritz/reportMeritzMidInfo?suim_rpt_no=${param.suim_rpt_no}&cmd=word"><img src="./resources/ls_img/report/btn_word.gif"></a>
            <a href="#noloc" onclick="fnReportMidPrint()"><img src="./resources/ls_img/report/icon_print.gif"></a>
        </div>
        
        <div style="margin-top:30px;">
        	<div class="text-center" style="margin-bottom: 20px;">
        		<b><font size="5" color="BLACK">메리츠화재(주) 중간보고서</font></b>
        	</div>
       	</div>
       	        
        <div class="display-table" style="margin-top: 10px;">
        	<div class="display-cell">
				<p class="subtitle">◆ 사고관련 사항</p>			
			</div>        	
        </div>
        	<table id=table_issue_contract_view>
        		<tr>
        			<th><b>사고번호</b></th>
        			<td>${reportBscInfo.accidentNo}</td>
        			<th><b>증권번호</b></th>
        			<td>${reportBscInfo.policyNo}</td>        			
        		</tr>
        		<tr>
        			<th><b>피보험자</b></th>
        			<td>${reportBscInfo.beneficiaryNm}</td>
        			<th><b>계 약 자</b></th>
        			<td>${reportBscInfo.policyholderNm}</td>
        		</tr>
        	</table>
        
        <div class="display-table" style="margin-top: 15px;">	    	    	
	        <div class="display-cell">
				<p class="subtitle">◆ 현장 진행사항</p>			
			</div>
			<div class="display-cell text-right">					
					<a id="btn_acc_edit" href="#noloc" onclick="fnAccEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>					
	               <a id="btn_acc_save" href="#noloc" onclick="fnAccSave();"><img src="./resources/ls_img/btn_add.gif"/></a>
	               <a id="btn_acc_cancel" href="#noloc" onclick="fnAccCancel();" style="display: none"><img src="./resources/ls_img/btn_close.gif"/></a>
	       	</div>	       	
       	</div>
       	<div id="acc_list"></div>
       	
       	<div class="display-table" style="margin-top: 15px;">	    	    	
	        <div class="display-cell">
				<p class="subtitle">◆ 특이사항 및 민원예방활동</p>			
			</div>
			<div class="display-cell text-right">
	               <a id="btn_content_edit" href="#noloc" onclick="fnContentEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
	               <a id="btn_content_save" href="#noloc" onclick="fnContentSave('${param.suim_rpt_no}');" style="display: none"><img src="./resources/ls_img/btn_save.gif"/></a>
	               <a id="btn_content_cancel" href="#noloc" onclick="fnContentCancel();" style="display: none"><img src="./resources/ls_img/btn_close.gif"/></a>
	       	</div>	       	
       	</div>
       	<div id="content_list"></div>
       	
       	<div class="display-table" style="margin-top: 20px;">	    	    	
	        <div class="display-cell">							
			</div>
			<div class="display-cell text-right">
	               <a id="btn_report_edit" href="#noloc" onclick="fnReportEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
	               <a id="btn_report_save" href="#noloc" onclick="fnReportSave('${param.suim_rpt_no}');" style="display: none"><img src="./resources/ls_img/btn_save.gif"/></a>
	               <a id="btn_report_cancel" href="#noloc" onclick="fnReportCancel();" style="display: none"><img src="./resources/ls_img/btn_close.gif"/></a>
	       	</div>	       	
       	</div>
       	<div id="report_list"></div>
       	
       	<div style="margin-top:30px;">
        	<div class="text-center" style="margin-bottom: 20px;">
        		<c:choose>
        			<c:when test="${empty reportInvgUser.userName}">조사자(처리담당자) 정보가 없습니다. 보고서 기본정보에서 입력해주세요.</c:when>
        			<c:when test="${empty userSignPath}">
        				<b><font size="3" color="BLACK">조사자 : ${reportInvgUser.userName}</font>&nbsp;
        					<a href="myInfo" target="_blank" style="color:red;">(My Menu > 정보수정에서 도장 또는 사인을 등록해주세요.)</a></b>
        			</c:when>
        			<c:otherwise>
        				<b><font size="3" color="BLACK">조사자 : ${reportInvgUser.userName}</font></b>&nbsp;<img src="${userSignPath}" width="50" height="50">        				
        			</c:otherwise>
        		</c:choose>
        	</div>
       	</div>       	
	</div>
</div>
