<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<link rel="stylesheet" type="text/css" href="./resources/wm_css/rpt_issue.css?v=20181204?v=2018"/>
<script src="./resources/jquery/jquery-ui.min.js"></script>
<script src="./resources/ne_js/calendar.js"></script>
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
	
	.buttonMiniFunction{
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
	    border: solid 1px grey;	    		    
	}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		//손해사정서 발송 내역 불러오기
		getSendList();
	});
	
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
	
	function fnIssueSendAdd(){			//손해사정서 추가버튼		
 		$("#btn_send_add").hide();
 		$("#btn_send_save").show();
 		$("#btn_send_cancel").show();
 		
 		$("#send_edit_type").val("edit");		//모드를 에디트모드로 변경한다.
 		getSendList();
 	}
	
	function fnIssueSendCancel(){
 		$("#btn_send_add").show();
 		$("#btn_send_save").hide();
 		$("#btn_send_cancel").hide();
 		
 		$("#send_edit_type").val("view");		//모드를 에디트모드로 변경한다.
 		getSendList();
 	}
	
	function fnSendReportPrint(){		//손해사정서 교부 대상자 보고서    	
    	var cw=screen.availWidth;
        var ch=screen.availHeight;

        var sw=700; //띄울 창의 넓이
        var sh=550;  //띄울 창의 높이

        var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
        var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
        
        var ptnr_nm = encodeURI("${ suimVO.ptnr_mbr_nm }");	//한글 uri 인코딩 처리
		window.open("/reportIssueMainNew?suim_rpt_no=${param.suim_rpt_no}&cmd=report&suim_rpt_type1=${suimVO.suim_rpt_type1}&ptnr_mbr_nm="+ptnr_nm,'print','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
    }
	
	function getSendList(){		
 		var formData = $("#sendForm").serialize();
 		$.ajax({
 			type : "post",
 			url : "./ajax/ajax_email_send",					
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
	
	function fnPrivacyAgreeChk(){						//by oniku
       	if ($("#privacy_agree1_add").is(":checked")){			//동의 클릭 시
     		$("#tel1_add").attr("disabled",false);
     		$("#tel2_add").attr("disabled",false);
     		$("#tel3_add").attr("disabled",false);
     		$("#disagree_date").val('');
     		$("#mobile_display").show();
     		$("#disagree_display").hide();
     		$("#none_display").hide();            		
     	}else{														//비 동의 클릭 시
     		$("#disagree_date").val('${sToday}');		//오늘날짜로 다시 셋팅
     		$("#tel1_add").attr("disabled",true);
     		$("#tel2_add").attr("disabled",true);
     		$("#tel3_add").attr("disabled",true);
     		$("#mobile_display").hide();
     		$("#disagree_display").show();
     		$("#none_display").hide();            		
     	}
     }
     
     function fnIssueSendSave(){
    	 
 		if ( !$("#privacy_agree1_add").is(":checked") && !$("#privacy_agree2_add").is(":checked")){
 			alert("손해사정서 교부 동의여부를 체크해주세요.");
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
         
         //휴대폰 발송시 실제발송이 아닌 기록방식으로 변경 20250827
         if( param.send_method == 'mobile' ){		//휴대폰발송시 발송(예정일)
         	param.temp_send_date		= $("#mobile_send_date").val();         	
           	param.complete_flag = 1; 
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
     
	//첨부파일을 통한 이메일 발송 전 파일 저장
	function fnIssueEmailSave(){
		
		if ( !$("#privacy_agree1_add").is(":checked") && !$("#privacy_agree2_add").is(":checked")){
 			alert("손해사정서 교부 동의여부를 체크해주세요.");
 			return;
 		}		
		
		var emailVal = $("#email_add").val();		
		var sendMethod = $("#send_method").val();
		
		//이메일 값 확인		
		if( emailVal == '' ){
				alert("이메일주소를 입력해주세요.");
				$("#email_add").focus();
				return;
		}
		
		//이메일 패턴 확인
		if( !chkEmail(emailVal) ){
			alert("이메일 주소 양식이 맞지 않습니다.");
			$("#email_add").focus();
			return;
		}
		
		var url = "./report_Issue_send_action_email";
		
		var formElement = document.getElementById("issueEmailForm");
		var formData = new FormData(formElement);
		
 		$.ajax({
 			type : "post",
 			url : url,					
 			data : formData,
 			contentType: false,      // FormData가 자체적으로 Content-Type을 설정하게 함
 			processData: false,      // jQuery가 데이터를 문자열로 변환하지 않도록 함
 			success : function(data){
 				if( data == 9 ){
 					alert("암호화 된 첨부파일은 발송이 불가합니다.\n암호해제 후 업로드해주세요."); 					
 				}else if( data == 99 ){
 					alert("PDF파일만 가능합니다.\nPDF파일로 업로드해주세요.");
 				}else if( data == 999 ){
 					alert("첨부파일이 없습니다.\n파일을 업로드해주세요.");
 				}else if( data == 9999 ){
 					alert("첨부파일이 5Mbyte가 넘습니다.\n파일크기를 줄이고 업로드해주세요.");
 				}else if( data == 99999 ){
 					alert("파일 업로드 중 문제가 발생하였습니다.\nIT정보보호파트로 연락해주세요.");
 				}else if( data == 999999 ){
 					alert("비밀번호가 설정된 PDF 파일만 업로드가 가능합니다.\nPDF 비밀번호 설정 후 업로드해주세요.");
 				}else{
 					alert("손해사정서 교부대상자를 추가하였습니다.");
 	         		fnIssueSendCancel();
 				}
 			},
 			error: function (request, status, error) {			
 				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
 			}
 		});
		
	}
		
	//증적자료 추가를 통한 모바일 발송기록저장
	function fnIssueMobileSave(){
		
		if ( !$("#privacy_agree1_add").is(":checked") && !$("#privacy_agree2_add").is(":checked")){
 			alert("손해사정서 교부 동의여부를 체크해주세요.");
 			return;
 		}
		
		var tel1Val = $("#tel1_add").val();
		var tel2Val = $("#tel2_add").val();
		var tel3Val = $("#tel3_add").val();
		var mobileSendDateVal = $("#mobile_send_date").val();
		
		
		//핸드폰 값 확인
		if( tel1Val == '' ){
			alert("핸드폰 번호를 입력해주세요.");
			$("#tel1_add").focus();
			return;
		}
		
		if( tel2Val == '' ){
			alert("핸드폰 번호를 입력해주세요.");
			$("#tel2_add").focus();
			return;
		}
		
		if( tel3Val == '' ){
			alert("핸드폰 번호를 입력해주세요.");
			$("#tel3_add").focus();
			return;
		}
		
		/** 교부일자 제거
		if( mobileSendDateVal == '' ){
			alert("교부일자를 입력해주세요.");
			$("#mobile_send_date").focus();
			return;
		}	
		**/
		
		var url = "./report_Issue_send_action_mobile";
		
		var formElement = document.getElementById("issueEmailForm");
		var formData = new FormData(formElement);
		
 		$.ajax({
 			type : "post",
 			url : url,					
 			data : formData,
 			contentType: false,      // FormData가 자체적으로 Content-Type을 설정하게 함
 			processData: false,      // jQuery가 데이터를 문자열로 변환하지 않도록 함
 			success : function(data){ 				
 				if( data == 9 ){
 					alert("암호화 된 첨부파일은 발송이 불가합니다.\n암호해제 후 업로드해주세요."); 					
 				}else if( data == 99 ){
 					alert("PDF파일만 가능합니다.\nPDF파일로 업로드해주세요.");
 				}else if( data == 999 ){
 					alert("첨부파일이 없습니다.\n파일을 업로드해주세요.");
 				}else if( data == 9999 ){
 					alert("첨부파일이 5Mbyte가 넘습니다.\n파일크기를 줄이고 업로드해주세요.");
 				}else if( data == 99999 ){
 					alert("파일 업로드 중 문제가 발생하였습니다.\nIT정보보호파트로 연락해주세요.");
 				}else if( data == 999999 ){
 					alert("비밀번호가 설정된 PDF 파일만 업로드가 가능합니다.\nPDF 비밀번호 설정 후 업로드해주세요.");
 				}else{
 					alert("손해사정서 교부대상자를 추가하였습니다.");
 	         		fnIssueSendCancel();
 				} 				
 			},
 			error: function (request, status, error) {			
 				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
 			}
 		});
 		
	}
	
	//보낸기록, 파일 삭제
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
	
	//첨부를 통한 문자발송
	function fnIssueSendMsg(idx){
  	  
        if(confirm("해당 대상자에게 메시지 발송을 하시겠습니까?\n발송 후에는 취소는 불가능합니다.\n발송실패시 휴대폰 재등록후 발송하세요.")){
      	            	
            var param = {};
            param.suim_rpt_no           = $("#suim_rpt_no").val();
            param.serial_no         = idx;

            var url = "./report_Issue_send_new_attach";			//파일 첨부방식의 문자 발송
            
            $("#top_mobile_loading").show();

            $.ajax({
                type: "POST",
                url: url,
                data: param,
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                dataType: "JSON",
                timeout: 60000,
                success: function(data){
                	
						$("#top_mobile_loading").hide();
                		
						alert(data.RESULT_MSG);
						fnIssueSendCancel();	//교부대상자 목록 호출                	  						
                },
                error: function(xhr, status, error){
                	
                	//console.log("xhr.status:", xhr.status);   // HTTP 응답 코드
                    //console.log("status:", status);           // jQuery가 분류한 상태 (timeout, error 등)
                    //console.log("error:", error);             // 브라우저/서버에서 내려준 메시지
                    
                    $("#top_mobile_loading").hide();
                	
                    if(xhr.status == "901"){
                        fnWinClose();
                    }else{
                        alert("손해사정서 발송에 실패하였습니다. \nIT정보보호파트에 문의하세요.");
                    }
                },
                beforeSend : function(xmlHttpRequest){
                    xmlHttpRequest.setRequestHeader("AJAX", "true");
                }
            });
        }
    }
	
	//첨부파일을 통한 이메일 발송 추가
	function fnIssueSendEmailAttach(idx){
		
		if(confirm("해당 대상자에게 이메일 발송을 하시겠습니까?\n발송 후에는 취소는 불가능합니다.\n발송실패시 이메일 재등록후 발송하세요.")){
			var param = {};
            param.suim_rpt_no           = $("#suim_rpt_no").val();                                
            param.serial_no         = idx;
            
            var url = "./report_Issue_send_email_attach";
            
            $("#top_email_loading").show();

            $.ajax({
                type: "POST",
                url: url,
                data: param,
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                dataType: "JSON",
                timeout: 20000,
                success: function(data){
                		
                		$("#top_email_loading").hide();
                		
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
     
	//email 양식체크
	function chkEmail(str) {		
		
		var regExp = /^(?:[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}|(?:\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-zA-Z0-9-]*[a-zA-Z0-9]:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]+)\]))$/;
		
		if (regExp.test(str)){
			return true;
		}else{
			return false;
		}
	}	

</script>
<form name="sendForm" id="sendForm" method="post">
<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${suimVO.suim_rpt_no}">
<input type="hidden" id="send_edit_type" name="send_edit_type" value="view">
<input type="hidden" id="ctype" name="ctype" value="${ctype}">
<input type="hidden" id="suimRptState" value="${suimVO.suimRptState}">
</form>
<div class="reportWrap" style="height:680px;">
    <div class="issue_reportContent">
        <div class="display-table" style="margin-top: 10px;">
	    	<!-- 손해사정서 교부대상자 시작 -->      	
	        <div class="display-cell">
				<p class="subtitle">▣ 손해사정서 교부 대상자</p>			
			</div>
			<div class="display-cell text-right">				   
				   <input type="button" class="buttonMiniFunction" value="인쇄" style="background-color:#D8F6CE;" onclick="fnSendReportPrint()">
				   <input type="button" class="buttonMiniFunction" id="btn_send_add" value="추가" onclick="fnIssueSendAdd()">
	               <input type="button" class="buttonMiniFunction" id="btn_send_cancel" style="background-color:#F6CECE;display:none;" value="취소" onclick="fnIssueSendCancel()">
	       	</div>
	    </div>
		<div class="issue_lotte">
			<div id="send_list"></div>			
		</div>
		<!-- //이메일 로딩바 시작-->
		<div id="top_email_loading" style="display: none;">
			<img id="loading-image" src="/resources/cmm/images/email_loading.gif" alt="Loading..." />
		</div>
		<!-- //이메일 로딩바 끝 -->
		<!-- //모바일 로딩바 시작-->
		<div id="top_mobile_loading" style="display: none;">
			<img id="loading-image" src="/resources/cmm/images/mobile_loading.gif" alt="Loading..." />
		</div>
		<!-- //모바일 로딩바 끝 -->		
    </div> <!-- //reportContent-->
</div> <!-- //reportWrap-->