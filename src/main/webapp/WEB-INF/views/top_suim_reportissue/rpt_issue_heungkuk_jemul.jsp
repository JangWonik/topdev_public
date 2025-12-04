<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/rpt_issue.css?v=20181204?v=2018"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<script src="./resources/ne_js/ne_number.js"></script>
	<%--<script src="./resources/daum/161109.js"></script>--%>
	<script src="./resources/daum/postcode.v2.js"></script>
	<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script>
	<style>
		.buttonMini{
			width:60px;
			height:20px;
		    background-color:#CEE3F6;
		    color:#666;
		    text-align: center;
			border-radius:5px;
		    font-size: 11px;
		    font-weight: bold;
		    cursor: pointer;
		    text-decoration:none;
		    border: solid 0px grey;		    
		}
	</style>
	<script>
	
	$(document).ready(function(){		
 		getContList();
 		getAccList();
 		getSummaryList();
 		getRemarkList();
 		getWriteList();
 		getSendList();
 		_initMask();
 		$("#summary_info").click( function(){
			alert("1. 총괄표 목적물은 8글자까지 입력이 가능합니다.\n2. 입력된 목적물은 4개까지 1페이지 출력이 가능합니다.\n5개 이상은 워드파일로 다운로드후 편집하여 사용하세요.");
		});
 		 		
 	});
	
	function _initMask(){
	    var options = {
		onKeyPress : function(cep, event, currentField, options){
			
		    var tid = event.currentTarget.id;
		    var tidx = tid.substr(tid.length - 1, 1);
		    
		},
		reverse : true
	    };
	    
	    $('input.calendar').mask('0000-00-00',options);
	    $('input.money').mask('#,###,###',options);
	    $('td.money').mask('#,##0',{reverse:true});
	    $('div.money').mask('#,##0',{reverse:true});
	    $('span.money').mask('#,##0',{reverse:true});
	}
	
     function _initCalendar(){    	 
  		$('.calendar').datepicker({
  			showOn: 'button',
  			buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
  			buttonImageOnly: true,
  			buttonText: "달력", 
  			changeMonth: true,
  			changeYear: true,	    	   
  			showButtonPanel: false,
  			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
  			dayNamesMin: ['일','월','화','수','목','금','토'],
  			dateFormat: 'yy-mm-dd',
  			firstDay: 0,
  			isRTL: false,
  			showMonthAfterYear: true
  	    }); 		
  		
  	}
	
	var Cont_Cnt = 0;			//계약사항 row
	var Summary_Cnt = 0;		//총괄표 row
	
	function getSendList(){		
		var formData = $("#sendForm").serialize();
		$.ajax({
			type : "post",
			url : "./ajax/ajax_lotte_send",					
			data : formData,
			success : function(result){			
				//날짜수정 페이지를 가져온다.				
				$("#send_list").html(result);				
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});
	}
	
	function getWriteList(){			//계약사항 표 불러오기		
		var formData = $("#writeForm").serialize();
		$.ajax({
			type : "post",
			url : "./ajax/ajax_samsung_write",					
			data : formData,
			success : function(result){			
				//날짜수정 페이지를 가져온다.								
				$("#write_list").html(result);				
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});
	}
	
	function getAccList(){			//계약사항 표 불러오기		
		var formData = $("#accForm").serialize();
		$.ajax({
			type : "post",
			url : "./ajax/ajax_heungkuk_jemul_acc",				//롯데하고 삼성이 같은 폼을 쓴다.					
			data : formData,
			success : function(result){			
				//보험목적물 페이지를 가져온다.		
				//alert('result='+result);				
				$("#acc_list").html(result);				
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});
	}
	
	function getContList(){			//계약사항 표 불러오기		
		var formData = $("#contForm").serialize();
		$.ajax({
			type : "post",
			url : "./ajax/ajax_samsung_jemul",					
			data : formData,
			success : function(result){			
				//보험목적물 페이지를 가져온다.		
				//alert('result='+result);				
				$("#cont_list").html(result);				
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});
	}
	
	function getSummaryList(){			//총괄표 불러오기		
		var formData = $("#summaryForm").serialize();
		$.ajax({
			type : "post",
			url : "./ajax/ajax_heungkuk_jemul_summary",					
			data : formData,
			success : function(result){				
				//총괄표 페이지를 가져온다.				
				$("#summary_list").html(result);			
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});
	}
	
	function getRemarkList(){			//특이사항 불러오기		
		var formData = $("#remarkForm").serialize();
		$.ajax({
			type : "post",
			url : "./ajax/ajax_samsung_jemul_remark",					
			data : formData,
			success : function(result){				
				//특이사항 페이지를 가져온다.				
				$("#remark_list").html(result);			
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});
	}
	
	function fnSummary_add(param){
		
		//변경가능
		if( Summary_Cnt > 2){
			alert("총괄표 내용은 3개까지 추가가 가능합니다.");
			return;
		}
		
		Summary_Cnt++;		
		
		var addContTr = "";
			
		if( param == 'C' ){
			addContTr = '<tr id='+Summary_Cnt+'>'+
				'<td>'+
					'<input type="text" id="summary_cate" name="summary_cate" maxlength="8">'+	        		
	        	'</td>'+								
				'<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="join_price" name="join_price" value="0" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>'+
				'<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="insu_price" name="insu_price" value="0" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>'+
				'<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="loss_price" name="loss_price" value="0" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>'+
				'<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="remain_price" name="remain_price" value="0" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>'+
				'<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="pay_price" name="pay_price" value="0" style="text-align: right;padding-right:5px;width:80px; onkeydown="return showKeyCode(event)"">'+
				'&nbsp;<img src="./resources/ls_img/btn_del_s.gif" border="0" style="cursor:pointer" onclick="fnSummary_del2('+Summary_Cnt+');"/></td>'+
			'</tr>';
		}else if( param == 'B' ){
			addContTr = '<tr id='+Summary_Cnt+'>'+
				'<td>'+
					'<input type="text" id="summary_cate" name="summary_cate" maxlength="8">'+	    		
	    	'</td>'+								
			'<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="comp_limit_price" name="comp_limit_price" value="0" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>'+
			'<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="loss_price" name="loss_price" value="0" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>'+
			'<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="net_loss_price" name="net_loss_price" value="0" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>'+			
			'<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="pay_price" name="pay_price" value="0" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)">'+
			'<td style="text-align: right;padding-right:5px;"><input type="text" id="exception_val" name="exception_val" value="" style="text-align: right;padding-right:5px;width:80px;">'+
			'&nbsp;<img src="./resources/ls_img/btn_del_s.gif" border="0" style="cursor:pointer" onclick="fnSummary_del2('+Summary_Cnt+');"/></td>'+
		'</tr>';
		}else if( param == 'I' ){
			addContTr = '<tr id='+Summary_Cnt+'>'+
			'<td>'+
			'<input type="text" id="insu_nm" name="insu_nm" maxlength="20">'+	    		
			'</td>'+
			'<td>'+
					'<input type="text" id="summary_cate" name="summary_cate" maxlength="8">'+	    		
	    	'</td>'+								
			'<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="join_price" name="join_price" value="0" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>'+
			'<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="bill_price" name="bill_price" value="0" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>'+
			'<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="pay_price" name="pay_price" value="0" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>'+
			'<td style="text-align: right;padding-right:5px;"><input type="text" id="exception_val" name="exception_val" value="" style="text-align: right;padding-right:5px;width:80px;">'+			
			'&nbsp;<img src="./resources/ls_img/btn_del_s.gif" border="0" style="cursor:pointer" onclick="fnSummary_del2('+Summary_Cnt+');"/></td>'+
		'</tr>';
		}	
		
		var trHtml = $( "tr[name=summary_tr]:last" );
		trHtml.after(addContTr);
	}	
	
	function fnCont_add(param){
		//흥국에서는 사용안함
		//변경가능
		/* if( Cont_Cnt > 2){
			alert("보험목적물 및 계약약관은 3개까지 추가가 가능합니다.");
			return;
		}
		
		Cont_Cnt++;		
		
		var addContTr = "";
			
		if( param == 'C' ){
			addContTr = '<tr id='+Cont_Cnt+'>'+
				'<th>'+
	        		'<select name="cont_cate">'+
	        		'	<option value="건물">건물</option>'+
	        		'	<option value="기계">기계</option>'+
	        		'	<option value="동산">동산</option>'+
	        		'</select>'+
	        	'</th>'+								
				'<td  style="text-align: left;padding-left:5px;"><input type="text" name="cont_content" style="width:417px">&nbsp;<img src="./resources/ls_img/btn_del_s.gif" border="0" onclick="fnCont_del2('+Cont_Cnt+');" style="cursor:pointer" /></td>'+
			'</tr>';
		}else if( param == 'B' ){
			addContTr = '<tr id='+Cont_Cnt+'>'+
			'<th>'+
        		'<select name="cont_cate">'+
        		'	<option value="시설소유자배상">시설소유자배상</option>'+
        		'	<option value="주차장배상">주차장배상</option>'+
        		'	<option value="물적확장특약">물적확장특약</option>'+
        		'</select>'+
        	'</th>'+								
			'<td  style="text-align: left;padding-left:5px;"><input type="text" name="cont_content" style="width:417px">&nbsp;<img src="./resources/ls_img/btn_del_s.gif" border="0" onclick="fnCont_del2('+Cont_Cnt+');" style="cursor:pointer" /></td>'+
		'</tr>';
		}else if( param == 'T' ){
			addContTr = '<tr id='+Cont_Cnt+'>'+
			'<th>'+
        		'<select name="cont_cate">'+
        		'	<option value="휴대품손해">휴대품손해</option>'+        		
        		'</select>'+
        	'</th>'+								
			'<td  style="text-align: left;padding-left:5px;"><input type="text" name="cont_content" style="width:417px">&nbsp;<img src="./resources/ls_img/btn_del_s.gif" border="0" onclick="fnCont_del2('+Cont_Cnt+');" style="cursor:pointer" /></td>'+
		'</tr>';
		}
		
		
		var trHtml = $( "tr[name=cont_tr]:last" );
		trHtml.after(addContTr); */
	}	
	
	function fnSummary_del2(param){		//브라우저에서 삭제하는 경우		
		var trHtml = $( "tr[id='"+param+"']" );		
		Summary_Cnt--;		
		trHtml.remove();
	}
	
	function fnCont_del2(param){		//브라우저에서 삭제하는 경우		
		var trHtml = $( "tr[id='"+param+"']" );
		Cont_Cnt--;		
		trHtml.remove();
	}
	
	function fnIssueWritedateEdit(){		
	    $("#btn_issue_writedate_edit").hide();
	    $("#btn_issue_writedate_save").show();
	    $("#btn_issue_writedate_cancel").show();	    
	    	    
	    $("#write_edit_type").val("edit");		//모드를 에디트모드로 변경한다.
	  	getWriteList();	    	    
	}
	
	function fnIssueContractEdit(){		
	    $("#btn_issue_cont_edit").hide();
	    $("#btn_issue_cont_save").show();
	    $("#btn_issue_cont_cancel").show();	    
	    	    
	    $("#cont_edit_type").val("edit");		//모드를 에디트모드로 변경한다.
	  	getContList();	    	    
	}
	
	function fnIssueAccEdit(){		
	    $("#btn_issue_acc_edit").hide();
	    $("#btn_issue_acc_save").show();
	    $("#btn_issue_acc_cancel").show();	    
	    
	    $("#acc_edit_type").val("edit");		//모드를 에디트모드로 변경한다.
	  	getAccList();	    	    
	}
	
	function fnIssueSummaryEdit(){		
	    $("#btn_issue_summary_edit").hide();
	    $("#btn_issue_summary_save").show();
	    $("#btn_issue_summary_cancel").show();
	    
	    $("#summary_edit_type").val("edit");		//모드를 에디트모드로 변경한다.
	  	getSummaryList();
	}
	
	function fnIssueRemarkEdit(){		
	    $("#btn_issue_remark_edit").hide();
	    $("#btn_issue_remark_save").show();
	    $("#btn_issue_remark_cancel").show();
	    
	    $("#remark_edit_type").val("edit");		//모드를 에디트모드로 변경한다.
	  	getRemarkList();
	}
	
	function fnIssueWritedateCancel() {		
	    $("#btn_issue_writedate_edit").show();
	    $("#btn_issue_writedate_save").hide();
	    $("#btn_issue_writedate_cancel").hide();
	    
	    $("#write_edit_type").val("view");		//모드를 에디트모드로 변경한다.
	  	getWriteList();		
	}
	
	function fnIssueWriteCancel() {		
	    $("#btn_issue_writedate_edit").show();
	    $("#btn_issue_writedate_save").hide();
	    $("#btn_issue_writedate_cancel").hide();
	    
	    $("#write_edit_type").val("view");		//모드를 에디트모드로 변경한다.
	  	getWriteList();		
	}
	
	function fnIssueAccCancel() {		
	    $("#btn_issue_acc_edit").show();
	    $("#btn_issue_acc_save").hide();
	    $("#btn_issue_acc_cancel").hide();
	    
	    $("#acc_edit_type").val("view");		//모드를 에디트모드로 변경한다.
	  	getAccList();		
	}
	
	function fnIssueContractCancel() {
		Cont_Cnt = 0;
	    $("#btn_issue_cont_edit").show();
	    $("#btn_issue_cont_save").hide();
	    $("#btn_issue_cont_cancel").hide();
	    
	    $("#cont_edit_type").val("view");		//모드를 에디트모드로 변경한다.
	  	getContList();		
	}
	
	function fnIssueSummaryCancel() {
		Summary_Cnt = 0;
	    $("#btn_issue_summary_edit").show();
	    $("#btn_issue_summary_save").hide();
	    $("#btn_issue_summary_cancel").hide();
	    
	    $("#summary_edit_type").val("view");		//모드를 에디트모드로 변경한다.
	  	getSummaryList();		
	}
	
	function fnIssueRemarkCancel() {		
	    $("#btn_issue_remark_edit").show();
	    $("#btn_issue_remark_save").hide();
	    $("#btn_issue_remark_cancel").hide();
	    
	    $("#remark_edit_type").val("view");		//모드를 에디트모드로 변경한다.
	  	getRemarkList();
	}
	
	function fnIssueSendAdd(){			//손해사정서 추가버튼		
		$("#btn_send_add").hide();
		$("#btn_send_save").show();
		$("#btn_send_cancel").show();
		
		$("#send_edit_type").val("edit");		//모드를 에디트모드로 변경한다.
		getSendList();
	}
	
	function fnIssueSendSave(){
		if ( !$("#privacy_agree1_add").is(":checked") && !$("#privacy_agree2_add").is(":checked")){
			alert("개인정보 동의 여부를 체크 해 주세요..");
			return;
		}
		
		var param = {};
        param.suim_rpt_no           = $("#suim_rpt_no").val();
        param.send_target				= $("#send_target_add").val();
        param.suimRptState			= $("#suimRptState").val();
        param.send_method			= $("#send_method").val();        
        
        if( param.send_method == 'fax' ){
			param.tel1 			= $("#fax1_add").val();
            param.tel2 			= $("#fax2_add").val();
            param.tel3 			= $("#fax3_add").val();
        }else{
			param.tel1 			= $("#tel1_add").val();
            param.tel2 			= $("#tel2_add").val();
            param.tel3 			= $("#tel3_add").val();	 
        }
        
        param.email		= $("#email_add").val();
        
        param.privacy_agree =	$("#privacy_agree_val").val();
        param.type = "C";		//추가
        
        param.complete_flag = 0;			//완료플래그 추가
        
      	//시분초까지 비 동의 설정추가
        if( $("#disagree_date").val() != "" ){
        	var nowDate = new Date(Date.now());
            var dateFormat = nowDate.getHours()+":"+nowDate.getMinutes()+":"+nowDate.getSeconds();
            param.disagree_date		= $("#disagree_date").val()+" "+dateFormat;	
        }else{
        	param.disagree_date		= $("#disagree_date").val();
        }
        
        if( $("#privacy_agree_val").val() == '1' ){		//동의시
         	if( param.send_method == 'email' || param.send_method == 'email_send' ){
     			if( param.email == '' ){
     				alert("이메일주소를 입력해주세요.");
     				return;
     			}
     			//이메일 패턴 확인
     			if( !chkEmail(param.email) ){
     				alert("이메일 주소 양식이 맞지 않습니다.");
     				$("#email_add").focus();
     				return;
     			}     			
     		}else if( param.send_method == 'mobile' || param.send_method == 'fax' ){
     			if( param.tel1 == '' || param.tel2 == '' || param.tel3 == '' ){
     				alert("휴대폰 번호 또는 팩스번호를 입력해주세요.");
     				return;
     			}
     		}
        	//동의시 disagree_date 값을 초기화 한다.
        	param.disagree_date = "";
        }else{														// 비 동의
        	if( $("#disagree_date").val() == "" ){
        		alert("비 동의 날짜를 입력해주세요.");
        		return;
        	}
        	//비 동의인경우 비 동의 날짜 외 정보삭제
        	param.send_method = "";            
            param.tel1 			= "";
            param.tel2 			= "";
            param.tel3 			= "";            
            param.email		= "";
        }
        
		if( param.send_method == 'email' ){
			param.temp_send_date		= $("#email_send_date").val();         	
			param.complete_flag = 1;  
        }
         
        if( param.send_method == 'fax' ){		//팩스발송시 발송(예정)일
			param.temp_send_date		= $("#fax_send_date").val();         	
			param.complete_flag = 1; 
        }
         
         
        if( param.privacy_agree == '2' ){
			param.complete_flag = 1;
        }
        
        var url = "./report_Issue_send_action_lotte";            

        $.ajax({
            type: "POST",
            url: url,
            data: param,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            dataType: "html",
            traditional: true,						//배열허용
            timeout: 20000,
            success: function(data){            	
            	if( data ){		//1인 경우 성공
            		alert("손해사정서 교부대상자를 추가하였습니다.");
            		fnIssueSendCancel();            		
            	}                	
            }                
        });        	
	}
	
	//email 양식체크
	function chkEmail(str) {
		
		var regExp = /^(?:[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}|(?:\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-zA-Z0-9-]*[a-zA-Z0-9]:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]+)\]))$/;
		
		if (regExp.test(str)){
			return true;
		}else{
			return false;
		}
	}
	
	//이메일 발송 추가
	function fnIssueSendEmail(idx){		
		
		if(confirm("해당 대상자에게 이메일 발송을 하시겠습니까?\n발송 후에는 취소는 불가능합니다.\n발송실패시 이메일 재등록후 발송하세요.")){
			var param = {};
            param.suim_rpt_no           = $("#suim_rpt_no").val();                                
            param.serial_no         = idx;
            param.ctype					  = $("#ctype").val();
            
            var url = "./report_Issue_send_heungkuk_email";

            $.ajax({
                type: "POST",
                url: url,
                data: param,
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                dataType: "JSON",
                timeout: 20000,
                success: function(data){
                	
						if( data.RESULT_MSG == 'Success'){
							alert('이메일이 발송되었습니다.');
						}else{
							alert("이메일 발송실패 (이메일주소를 확인해주세요) : \n"+data.RESULT_MSG);		
						}
						
						fnIssueSendCancel();	//교부대상자 목록 호출                	  						
                },
                error: function(xhr, status, error){                        	
                    if(xhr.status == "901"){
                        fnWinClose();
                    }else{
                        alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
                    }
                },
                beforeSend : function(xmlHttpRequest){
                    xmlHttpRequest.setRequestHeader("AJAX", "true");
                }
            });
		}
	}
	
	function fnIssueSendCancel(){
		$("#btn_send_add").show();
		$("#btn_send_save").hide();
		$("#btn_send_cancel").hide();
		
		$("#send_edit_type").val("view");		//모드를 에디트모드로 변경한다.
		getSendList();
	}
	
	function fnCont_del(suim_rpt_no, cont_no){
		if(confirm("해당 보험목적물의 계약사항을 삭제 하시겠습니까?")){
			var param = {};
            param.suim_rpt_no       			= suim_rpt_no;
            param.cont_no				= cont_no;                        
            
            var url = "./reportIssueLotteJemulDelete";            

            $.ajax({
                type: "POST",
                url: url,
                data: param,
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                dataType: "html",
                traditional: true,						//배열허용
                timeout: 20000,
                success: function(data){
                	if( data ){		//1인 경우 성공 
                		$("#cont_edit_type").val("edit");		//모드를 에디트모드로 불러온다.
                	  	getContList();                		
                	}                	
                }                
            });	
		}		
	}
	
	function fnSend_del(suim_rpt_no, serial_no){
		if(confirm("해당 손해사정서 교부대상자정보를 삭제 하시겠습니까?")){
			var param = {};
            param.suim_rpt_no       		= suim_rpt_no;
            param.serial_no				= serial_no;                        
            
            var url = "./reportIssueLotteSendDelete";            

            $.ajax({
                type: "POST",
                url: url,
                data: param,
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                dataType: "html",
                traditional: true,						//배열허용
                timeout: 20000,
                success: function(data){
                	if( data ){		//1인 경우 성공
                		fnIssueSendCancel();		//발송목록불러오기
                	}                	
                }                
            });
		}
	}
	
	function fnSummary_del(suim_rpt_no, summary_no){
		if(confirm("총괄표의 해당목적물 정보를 삭제 하시겠습니까?")){
			var param = {};
            param.suim_rpt_no       			= suim_rpt_no;
            param.summary_no				= summary_no;                        
            
            var url = "./reportIssueLotteSummaryDelete";            

            $.ajax({
                type: "POST",
                url: url,
                data: param,
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                dataType: "html",
                traditional: true,						//배열허용
                timeout: 20000,
                success: function(data){
                	if( data ){		//1인 경우 성공 
                		$("#summary_edit_type").val("edit");		//모드를 에디트모드로 불러온다.
                	  	getSummaryList();                		
                	}                	
                }                
            });	
		}		
	}
	
	//사고사항 저장
	function fnIssueAccSave() {	        	
    	
        var param = {};
        param.suim_rpt_no	= $("#suim_rpt_no").val();
        param.accident_date	= $("#acc_date").val();
        param.investigate_addr1	= $("#investigate_addr1").val();
        param.investigate_addr2	= $("#investigate_addr2").val();
        param.insu_content	= $("#acc_facts").val();
        
        if( param.insu_content.length > 150 ){
        	alert("사고원인은 150자까지 입력이 가능합니다.");
        	return;
        }
        
        var url = "./rptissue_acc_update";

        $.ajax({
            type: "POST",
            url: url,
            data: param,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            dataType: "JSON",
            timeout: 20000,
            success: function(data){
            	if (data == 1){
            		alert("손해사정서 사고사항이 수정되었습니다.");
            		$("#acc_edit_type").val("view");		//모드를 에디트모드로 변경한다.
            		getAccList();
            		fnIssueAccCancel();
            	}else{
            		alert("사고사항 변경에 실패 하였습니다. IT정보보호파트에 문의 해 주세요.");
            	}
            },
            error: function(xhr, status, error){
                if(xhr.status == "901"){
                    fnWinClose();
                }else{
                    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
                }
            },
            beforeSend : function(xmlHttpRequest){
                xmlHttpRequest.setRequestHeader("AJAX", "true");
            }

        });
    }
	
	//작성일자 수동변경	
	function fnWriteDateSaveUp() {	        	
    	
        var param = {};
        param.suim_rpt_no	= $("#suim_rpt_no").val();
        param.write_date	= $("#write_date").val();
        
        var url = "./rptissue_write_date_update";

        $.ajax({
            type: "POST",
            url: url,
            data: param,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            dataType: "JSON",
            timeout: 20000,
            success: function(data){
            	if (data == 1){
            		alert("손해사정서 교부 작성일이 변경되었습니다.");
            		$("#write_edit_type").val("view");		//모드를 에디트모드로 변경한다.
            		getWriteList();
            		fnIssueWriteCancel();
            	}else{
            		alert("작성일 변경에 실패 하였습니다. IT정보보호파트에 문의 해 주세요.");
            	}
            },
            error: function(xhr, status, error){
                if(xhr.status == "901"){
                    fnWinClose();
                }else{
                    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
                }
            },
            beforeSend : function(xmlHttpRequest){
                xmlHttpRequest.setRequestHeader("AJAX", "true");
            }

        });
    }
	
	function fnIssueContractSave(){
		if(confirm("1. 계약사항의 내용을 수정하시겠습니까?")){			
			var sForm = document.contEditForm;						
			
			var arrList = new Array();								
			
			var param = {};
            param.suim_rpt_no       			= $("#suim_rpt_no").val();            
            param.suim_address 				= $("#addr_rptUdt_1").val();            
            param.insu_term       				= $("#sdate").val()+"~"+$("#edate").val();
            param.ctype							= $("#ctype").val();
            var sdateTemp						= $("#sdate").val();
            var edateTemp						= $("#edate").val();           
            
            var url = "./reportIssueSamsungJemulUpdate";

            $.ajax({
                type: "POST",
                url: url,
                data: param,
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                dataType: "html",
                traditional: true,						//배열허용
                timeout: 20000,
                success: function(data){
                	if( data ){		//1인 경우 성공 
                		$("#cont_edit_type").val("view");		//모드를 에디트모드로 변경한다.
                	  	getContList();                	  	
                		//성공한경우는 에디터를 닫아준다.
                		fnIssueContractCancel();
                	}                	
                }                
            });
		}		
	}
	
	function fnIssueRemarkSave(){
		
		if(confirm("4. 특이사항 내용을 수정하시겠습니까?")){			
			var sForm = document.remarkEditForm;					
			
			var param = {};
            param.suim_rpt_no       			= $("#suim_rpt_no").val();            
            param.ctype							= $("#ctype").val();                        
            param.remark_val					= $("#remark_val").val();                        
            
            var url = "./reportIssueSamsungRemarkUpdate";

            $.ajax({
                type: "POST",
                url: url,
                data: param,
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                dataType: "html",
                traditional: true,						//배열허용
                timeout: 20000,
                success: function(data){
                	if( data ){		//1인 경우 성공 
                		$("#remark_edit_type").val("view");		//모드를 에디트모드로 변경한다.
                	  	getRemarkList();                	  	
                		//성공한경우는 에디터를 닫아준다.
                		fnIssueRemarkCancel();
                	}                	
                }                
            });
		}		
	}
	
	function fnIssueSummarySave(){
		
		if(confirm("3. 총괄표 내용을 수정하시겠습니까?")){			
			var sForm = document.summaryEditForm;
			var nCnt = 0;
			
			var arrList = new Array();			
			
			if( $("#ctype").val() == 'C' ){				//재물인경우
				
				nCnt = $("input[name='pay_price']").length;		// row수를 계산한다.
				
				if( nCnt == 1 ){			//한개일때는 배열로 인식을 못함
					if( sForm.summary_cate.value == '' ){
						alert('총괄표의 목적물 정보를 입력해주세요.');
						return
					}else{
						arrList[0] = sForm.summary_cate.value +"|"+sForm.join_price.value+"|"+sForm.insu_price.value+"|"+sForm.loss_price.value+"|"+sForm.remain_price.value+"|"+sForm.pay_price.value;	
					}					
				}else{
					for( var i=0; i < nCnt; i++ ){
						if( sForm.summary_cate[i].value == '' ){
							alert('총괄표의 목적물 정보를 입력해주세요.');
							return	
						}else{
							arrList[i] = sForm.summary_cate[i].value +"|"+sForm.join_price[i].value+"|"+sForm.insu_price[i].value+"|"+sForm.loss_price[i].value+"|"+sForm.remain_price[i].value+"|"+sForm.pay_price[i].value;	
						}
												
					}		
				}				
			}else if( $("#ctype").val() == 'B' ){				//배상인경우
				
				nCnt = $("input[name='loss_price']").length;		// row수를 계산한다.
				
				if( nCnt == 1 ){
					
					if( sForm.exception_val.value == '' ){
						sForm.exception_val.value = "-";
					}
					
					if( sForm.summary_cate.value == '' ){
						alert('총괄표의 목적물 정보를 입력해주세요.');
						return
					}else{
						arrList[0] = sForm.summary_cate.value +"|"+sForm.comp_limit_price.value+"|"+sForm.loss_price.value+"|"+sForm.net_loss_price.value+"|"+sForm.pay_price.value+"|"+sForm.exception_val.value;	
					}					
				}else{
					for( var i=0; i < nCnt; i++ ){
						
						if( sForm.exception_val[i].value == '' ){
							sForm.exception_val[i].value = "-";
						}
						
						if( sForm.summary_cate[i].value == '' ){
							alert('총괄표의 목적물 정보를 입력해주세요.');
							return	
						}else{
							arrList[i] = sForm.summary_cate[i].value +"|"+sForm.comp_limit_price[i].value+"|"+sForm.loss_price[i].value+"|"+sForm.net_loss_price[i].value+"|"+sForm.pay_price[i].value+"|"+sForm.exception_val[i].value;							
						}												
					}		
				}
			}else if( $("#ctype").val() == 'I' ){				//인보험인 경우
				
				nCnt = $("input[name='join_price']").length;		// row수를 계산한다.
				
				if( nCnt == 1 ){			//한개일때는 배열로 인식을 못함
					
					if( sForm.insu_nm.value == '' ){
						sForm.insu_nm.value = "-";
					}
					
					if( sForm.exception_val.value == '' ){
						sForm.exception_val.value = "-";
					}
				
					if( sForm.summary_cate.value == '' ){
						alert('총괄표의 목적물 정보를 입력해주세요.');
						return
					}else{
						arrList[0] = sForm.insu_nm.value+"|"+sForm.summary_cate.value +"|"+sForm.join_price.value+"|"+sForm.bill_price.value+"|"+sForm.pay_price.value+"|"+sForm.exception_val.value;	
					}					
										
				}else{
					for( var i=0; i < nCnt; i++ ){						
						if( sForm.insu_nm[i].value == ''){							//제외사유. 빈값체크
							sForm.insu_nm[i].value = "-";
						}
						
						if( sForm.exception_val[i].value == ''){							//제외사유. 빈값체크
							sForm.exception_val[i].value = "-";
						}
						if( sForm.summary_cate[i].value == '' ){
							alert('총괄표의 목적물 정보를 입력해주세요.');
							return	
						}else{
							arrList[i] = sForm.insu_nm[i].value+"|"+sForm.summary_cate[i].value +"|"+sForm.join_price[i].value+"|"+sForm.bill_price[i].value+"|"+sForm.pay_price[i].value+"|"+sForm.exception_val[i].value;	
						}																		
					}		
				}
			}			
			
			//return;
			
			//자기부담금을 직접입력했는지 확인한다.			
			var sPayUnit = "";
			
			if( $("#amt_self_pay_unit option:selected").val() == 'direct' ){
				sPayUnit = $("#amt_self_pay_unit_direct").val();
			}else{
				sPayUnit = $("#amt_self_pay_unit option:selected").val();
			}			
			
			var param = {};
            param.suim_rpt_no       			= $("#suim_rpt_no").val();            
            param.ctype							= $("#ctype").val();
            param.amt_self_pay_unit			= sPayUnit;
            param.amt_self_pay				= $("#amt_self_pay").val();            
            //param.remark_val					= $("#remark_val").val();            
            param.summaryList					= arrList;						//총괄표 정보를 배열형태로 넘김            
            
            var url = "./reportIssueHeungkukSummaryUpdate";			//추가컨트롤러 별도로 만들어야함.

            $.ajax({
                type: "POST",
                url: url,
                data: param,
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                dataType: "html",
                traditional: true,						//배열허용
                timeout: 20000,
                success: function(data){
                	if( data ){		//1인 경우 성공 
                		$("#summary_edit_type").val("view");		//모드를 에디트모드로 변경한다.
                	  	getSummaryList();                	  	
                		//성공한경우는 에디터를 닫아준다.
                		fnIssueSummaryCancel();
                	}                	
                }                
            });
		}		
	}	
	
	function fnReportPrint(){
        var cw=screen.availWidth;
        var ch=screen.availHeight;        

        var sw=700; //띄울 창의 넓이
        var sh=550;  //띄울 창의 높이

        var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
        var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치

        window.open('/reportIssueHeungkukJemul?suim_rpt_no='+'${param.suim_rpt_no}'+'&cmd=print'+'&ctype=${ctype}','print','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
    }
	
	//숫자입력만 가능하도록 이벤트 추가 by top3009
	function showKeyCode(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if( ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 || keyID == 9 ) ){
			return;
		}else{
			return false;
		}
	}
	
	function fnIssueSendMsg(msgIdx){		
		var param = {};
		param.suim_rpt_no           = $("#suim_rpt_no").val();
		param.serial_no         = msgIdx;
		param.ctype			= $("#ctype").val();        

		var url = "./report_Issue_send_heungkuk_msg";

		$.ajax({
		    type: "POST",
		    url: url,
		    data: param,
		    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		    dataType: "JSON",
		    timeout: 20000,
		    success: function(data){
					alert(data.RESULT_MSG);
					fnIssueSendCancel();	//교부대상자 목록 호출
		    },
		    error: function(xhr, status, error){                        	
			if(xhr.status == "901"){
			    fnWinClose();
			}else{
			    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
			}
		    },
		    beforeSend : function(xmlHttpRequest){
			xmlHttpRequest.setRequestHeader("AJAX", "true");
		    }
		});
	}
	
	function fnSendReportPrint(){		
        var cw=screen.availWidth;
        var ch=screen.availHeight;

        var sw=700; //띄울 창의 넓이
        var sh=550;  //띄울 창의 높이

        var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
        var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
        
        var ptnr_nm = encodeURI("${ptnr_mbr_nm}");	//한글 uri 인코딩 처리
		
		window.open("/reportIssueLotteJemul?suim_rpt_no=${param.suim_rpt_no}&cmd=report&suim_rpt_type1=${suimVO.suim_rpt_type1}&ctype=${ctype}&ptnr_mbr_nm="+ptnr_nm,'print','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
    }
	
	//사고장소 주소정보를 소재지정보와 맞춘다.
	function fnSameAddress(){				
		var addrRptUdt1Text = $("#addr_rptUdt_1_text").text();			//DB에서 불러온값
		
		if( addrRptUdt1Text == '' ){
			alert("계약사항의 소재지를 입력, 저장 후에 사용해주세요.\n소재지 주소 수정 중에는 사용할 수 없습니다.");
			return;
		}
		
		$("#investigate_addr1").val(addrRptUdt1Text);
	}
</script>
</head>
<form name="contForm" id="contForm" method="post">
<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${suimVO.suim_rpt_no}">
<input type="hidden" id="cont_edit_type" name="cont_edit_type" value="view">
<input type="hidden" id="ctype" name="ctype" value="${ctype}">
</form>
<form name="summaryForm" id="summaryForm" method="post">
<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${suimVO.suim_rpt_no}">
<input type="hidden" id="summary_edit_type" name="summary_edit_type" value="view">
<input type="hidden" id="ctype" name="ctype" value="${ctype}">
</form>
<form name="remarkForm" id="remarkForm" method="post">
<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${suimVO.suim_rpt_no}">
<input type="hidden" id="remark_edit_type" name="remark_edit_type" value="view">
<input type="hidden" id="ctype" name="ctype" value="${ctype}">
</form>
<form name="accForm" id="accForm" method="post">
<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${suimVO.suim_rpt_no}">
<input type="hidden" id="acc_edit_type" name="acc_edit_type" value="view">
<input type="hidden" id="ctype" name="ctype" value="${ctype}">
</form>
<form name="writeForm" id="writeForm" method="post">
<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${suimVO.suim_rpt_no}">
<input type="hidden" id="write_edit_type" name="write_edit_type" value="view">
</form>
<form name="sendForm" id="sendForm" method="post">
<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${suimVO.suim_rpt_no}">
<input type="hidden" id="send_edit_type" name="send_edit_type" value="view">
<input type="hidden" id="ctype" name="ctype" value="${ctype}">
<input type="hidden" id="suimRptState" value="${suimVO.suimRptState}">
</form>
<input type="hidden" id="ptnr_mbr_nm" name="ptnr_mbr_nm" value="${ptnr_mbr_nm}">
<input type="hidden" id="sendListSize" value="${rptIssueSendList.size()}">
<div class="reportWrap">
    <div class="issue_reportContent"> 
    	<div class="text-right">
            <a href="/reportIssueHeungkukJemul?suim_rpt_no=${suimVO.suim_rpt_no}&cmd=word&ctype=${ctype}"><img src="./resources/ls_img/report/btn_word.gif"></a>
            <a href="#noloc" onclick="fnReportPrint()"><img src="./resources/ls_img/report/icon_print.gif"></a>
        </div>   	
    	<div class="text-center">    		
    		<p class="text-center" style="padding-top: 30px;">
    			<span style="font-size: 20px;"><b>
    			<c:if test="${ctype eq 'C'}">
    				재물보험 손해사정서
    			</c:if>
    			<c:if test="${ctype eq 'B'}">
    				배상책임보험 손해사정서
    			</c:if>
    			<c:if test="${ctype eq 'I'}">
    				인보험 손해사정서
    			</c:if>
    			</b></span></p>    				   		
    	</div>
    	<div class="display-table" style="margin-top: 10px;">
	    	<!-- 1. 계약사항 -->    	
	        <div class="display-cell">
				<p class="subtitle">1. 계약사항</p>			
			</div>
			<div class="display-cell text-right">
	               <a id="btn_issue_cont_edit" href="#noloc" onclick="fnIssueContractEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
	               <a id="btn_issue_cont_save" href="#noloc" style="display: none" onclick="fnIssueContractSave();"><img src="./resources/ls_img/icon_write.gif"/></a>
	               <a id="btn_issue_cont_cancel" href="#noloc" onclick="fnIssueContractCancel();" style="display: none"><img src="./resources/ls_img/btn_write_cancel.gif"/></a>
	       	</div>
       	</div>
		<div class="issue_lotte">			
			<div id="cont_list"></div>		
		</div>
                        
        <div class="display-table" style="margin-top: 10px;">
			<!-- 2. 사고사항 -->
			<div class="display-cell">
				<p class="subtitle">2. 사고사항</p>
			</div>
			<div class="display-cell text-right">
	               <a id="btn_issue_acc_edit" href="#noloc" onclick="fnIssueAccEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
	               <a id="btn_issue_acc_save" href="#noloc" style="display: none" onclick="fnIssueAccSave();"><img src="./resources/ls_img/icon_write.gif"/></a>
	               <a id="btn_issue_acc_cancel" href="#noloc" onclick="fnIssueAccCancel();" style="display: none"><img src="./resources/ls_img/btn_write_cancel.gif"/></a>
	       	</div>
       	</div>
		<div class="issue_lotte">
			<div id="acc_list"></div>        	
		</div>
		<!-- 3총괄표 -->
		<div class="display-table">
			<div class="display-cell">
				<p class="subtitle">3. 총괄표 <span id="summary_info" style="font-size:9px;cursor:pointer;">[?]</span></p>
			</div>
			<div class="display-cell text-right">
	               <a id="btn_issue_summary_edit" href="#noloc" onclick="fnIssueSummaryEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
	               <a id="btn_issue_summary_save" href="#noloc" style="display: none" onclick="fnIssueSummarySave();"><img src="./resources/ls_img/icon_write.gif"/></a>
	               <a id="btn_issue_summary_cancel" href="#noloc" onclick="fnIssueSummaryCancel();" style="display: none"><img src="./resources/ls_img/btn_write_cancel.gif"/></a>
	       	</div>
       	</div>
		<div class="issue_lotte">
			<div id="summary_list"></div>					
		<br/>
		<!-- 4.특이사항 -->
		<div class="display-table">
			<div class="display-cell">
				<p class="subtitle">
				<c:choose>
					<c:when test="${ctype eq 'I'}">
						4. 확인사항
					</c:when>
					<c:otherwise>
						4. 특이사항
					</c:otherwise>
				</c:choose>
				</p>
			</div>
			<div class="display-cell text-right">
	               <a id="btn_issue_remark_edit" href="#noloc" onclick="fnIssueRemarkEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
	               <a id="btn_issue_remark_save" href="#noloc" style="display: none" onclick="fnIssueRemarkSave();"><img src="./resources/ls_img/icon_write.gif"/></a>
	               <a id="btn_issue_remark_cancel" href="#noloc" onclick="fnIssueRemarkCancel();" style="display: none"><img src="./resources/ls_img/btn_write_cancel.gif"/></a>
	       	</div>
       	</div>
		<div class="issue_lotte">
			<div id="remark_list"></div>					
		<br/>
		<div class="display-table" style="margin-top: 10px;">
			<div class="display-cell">						
				</div>
				<div class="display-cell text-right">
			       <a id="btn_issue_writedate_edit" href="#noloc" onclick="fnIssueWritedateEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
			       <a id="btn_issue_writedate_save" href="#noloc" style="display: none" onclick="fnWriteDateSaveUp();"><img src="./resources/ls_img/icon_write.gif"/></a>
			       <a id="btn_issue_writedate_cancel" href="#noloc" onclick="fnIssueWritedateCancel();" style="display: none"><img src="./resources/ls_img/btn_write_cancel.gif"/></a>
			</div>
		</div>
		<!-- 작성일자 중앙정렬 -->
		<div id="write_list"></div>
		<br/>
		
		<!-- 조사자, 담당손해사정사 시작 -->		 	
		<c:choose>
			<c:when test="${empty certiReportUser}">
				<div style="padding:20px 0 20px 0;">
					<table>
						<tr>					 			
							<td style="font-weight:bold; color: red; text-align:left;">
								[미배당건으로 담당자 정보가 없습니다.]
							</td>					 			
						</tr>					 		
					</table>
				</div>
			</c:when>
			<c:otherwise>
				<c:forEach items="${certiReportUser}" var="certiUserVo">
					<div style="padding:10px 0 10px 0;">
						<table>
							<tr>						 			
								<td width="12%" style="font-weight:bold; text-align:left;">
									${certiUserVo.certi_state_val}
								</td>
								<td width="20%" style="font-weight:bold; text-align:center;">
									${certiUserVo.user_name}
								</td>
								<td width="18%" style="font-weight:bold; text-align:left;">						 										 				
									<img src="https://www.toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${certiUserVo.user_no}/${certiUserVo.user_sign}" width="30px" height="20px">
								</td>
								<td width="50%" style="font-weight:bold; text-align:left;"></td>						 			
							</tr>
							<tr>
								<td colspan="4" style="font-weight:bold; text-align:left;">
								 [ 등록번호 : ${certiUserVo.certi_number} <c:if test='${certiUserVo.work_phone != ""}'>/ 연락처 : ${certiUserVo.work_phone} </c:if>]
								</td>						 							 			
							</tr>
						</table>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>		 	
		<!-- 조사자, 담당손해사정사 끝 -->
		<%-- <table>
			<colgroup>
			    <col width="50%">
			    <col width="50%">
			</colgroup>
			<tbody>				
				<tr>
					<td></td>
					<td><b>담 당 자 : ${reportInvgUser.disWorkLevel} ${reportInvgUser.userName}  (연락처 : ${reportInvgUser.handphone})</b></td>	
				</tr>
				<tr>
					<td></td>
					<td><b>대표손해사정사 : 윤경수</b><img alt="윤경수" src="./resources/ne_img/sign_yun.jpg" width="50" height="30"></td>	
				</tr>
			</tbody>			
		</table> --%>		
		<br/>
		<div align="center"><img src="https://www.toplac.co.kr/resources/ne_img/sign_ceo.jpg" border="0"/></div>					
    </div>
    <br/>
	<br/>	  
		<div class="display-table" style="margin-top: 10px;">	    	    	
	        <div class="display-cell">
				<p class="subtitle">▣ 손해사정서 교부 대상자</p>			
			</div>
			<div class="display-cell text-right">
					<img src="./resources/ls_img/report/icon_print.gif" border="0" onclick="fnSendReportPrint()" style="cursor:pointer;">
	               <img id="btn_send_add" src="./resources/ls_img/ls_body/btn_add.gif" onclick="fnIssueSendAdd()" border="0" style="cursor:pointer;"/>
	               <img id="btn_send_save" src="./resources/ls_img/icon_write.gif" onclick="fnIssueSendSave()" border="0" style="cursor:pointer;display:none;"/>
	               <img id="btn_send_cancel" src="./resources/ls_img/btn_write_cancel.gif" onclick="fnIssueSendCancel()" border="0" style="cursor:pointer;display:none;"/>	               
	       	</div>
	    </div>
		<div class="issue_lotte">
			<div id="send_list"></div>			
		</div>
		<br/>
		<br/>
    </div>
</div>
</div>
</html>