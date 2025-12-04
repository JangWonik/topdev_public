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
</style>
<script type="text/javascript">
	$(document).ready(function() {
		
		//수입정보 페이지 불러오기
		getIssueSuimInfo('view');
		//계약정보 페이지 불러오기
		getIssueContractInfo('view');
		//담보정보 페이지 불러오기
		getCoverageInfo('view');
		
		//손해사정시 적용된 관계법규 및 약관 불러오기
		getLawEtcContent();
		
		//약관상 보험자 지급책임의 범위 불러오기
	    getLawSelContent();
		
	  	//손해액 및 보험금 사정에 크게 영향을 미친 사항 불러오기
	    getLawReason();
	  	
	  	//작성일자 불러오기
	  	getWriteDate('view');
	  	
	  	//손해사정서 교부대상자 정보 불러오기
	  	getSendList();
		
		_initCalendar();
	});
	
	var Coverage_Cnt = 0;		//담보명 row
	
	function _initCalendar(){
		$('.calendar').datepicker({ 
		   showOn: 'button',
		   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		   buttonImageOnly: true,
		   buttonText: "달력", 
		   changeMonth: true,
		   changeYear: true,	    	   
		   showButtonPanel: false	    	   
	    });				
	}
	
	function fnSendReportPrint(){		//손해사정서 교부 대상자 보고서    	
    	var cw=screen.availWidth;
        var ch=screen.availHeight;

        var sw=700; //띄울 창의 넓이
        var sh=550;  //띄울 창의 높이

        var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
        var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
        
        var ptnr_nm = encodeURI("${ suimVO.ptnr_mbr_nm }");	//한글 uri 인코딩 처리
        
		window.open("/reportIssueMeritz?suim_rpt_no=${param.suim_rpt_no}&cmd=report&suim_rpt_type1=${suimVO.suim_rpt_type1}&ptnr_mbr_nm="+ptnr_nm,'print','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
    }
	
	function fnReportPrintNew(){
        var cw=screen.availWidth;
        var ch=screen.availHeight;

        var sw=700; //띄울 창의 넓이
        var sh=550;  //띄울 창의 높이

        var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
        var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치

        window.open('/reportIssueMeritz?suim_rpt_no='+'${param.suim_rpt_no}'+'&cmd=print'+'&suim_rpt_type1='+'${suimVO.suim_rpt_type1}','print','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
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
	
	function fnPrivacyAgreeChk(){
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
             		//location.reload();	
             		//목록페이지를 불러온다.
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
	
	function fnIssueSendDelete(idx){
        if(confirm("삭제하시겠습니까?")){
        	fnIssueSend('D', idx);
        }
    }
    
    function fnIssueSendUpdate(idx){
        if(confirm("수정하시겠습니까?")){
        	fnIssueSend('U', idx);
        }
    }           
           
    function fnIssueSend(type, idx, agr){
        var param = {};
        param.suim_rpt_no           = $("#suim_rpt_no").val();
        param.suimRptState			= $("#suimRptState").val();
        param.type                  = type;                

        if (type == 'U' || type == 'D' ){
            param.serial_no         = $("#send_serial_no_" + idx).val();
        }
        
        param.send_target   = $("#send_target_" + idx).val();
        param.tel1 			= $("#tel1_" + idx).val();
        param.tel2 			= $("#tel2_" + idx).val();
        param.tel3 			= $("#tel3_" + idx).val();
                        
        //시분초까지 비 동의 설정추가
        if( $("#disagree_date").val() != "" ){
        	var nowDate = new Date(Date.now());
            var dateFormat = nowDate.getHours()+":"+nowDate.getMinutes()+":"+nowDate.getSeconds();
            param.disagree_date		= $("#disagree_date").val()+" "+dateFormat;	
        }else{
        	param.disagree_date		= $("#disagree_date").val();
        }                                
        
        if (agr != '1'){
         	param.privacy_agree = $("#privacy_agree2_" + idx).val();
        }else{
        	param.privacy_agree = $("#privacy_agree1_" + idx).val();
        }

        var url = "./report_Issue_send_action";

        $.ajax({
            type: "POST",
            url: url,
            data: param,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            dataType: "html",
            timeout: 20000,
            success: function(data){
            	var sendListSize = parseInt($("#sendListSize").val());
            	if (type == "C"){
            		fnWriteDateSave('교부 대상자 등록에 성공했습니다.');		//날짜 갱신되도록 수정
            		$("#sendListSize").val(sendListSize + 1);
            	}else if (type == "D"){
            		fnWriteDateSave('교부 대상자 삭제에 성공했습니다.');		//날짜 갱신되도록 수정
            		$("#sendListSize").val(sendListSize - 1);
            	}else if (type == "U"){
            		fnWriteDateSave('교부 대상자 수정에 성공했습니다.');		//날짜 갱신되도록 수정
            	}
            	fnInputClean();
                $("#div_issue_send").html(data);
                $("#btn_issue_send_add").show();
                _initCalendar();                 
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
    
  //이메일 발송 추가
	function fnIssueSendEmail(idx){		
		
		if(confirm("해당 대상자에게 이메일 발송을 하시겠습니까?\n발송 후에는 취소는 불가능합니다.\n발송실패시 이메일 재등록후 발송하세요.")){
			var param = {};
            param.suim_rpt_no           = $("#suim_rpt_no").val();                                
            param.serial_no         = idx;
            
            //var url = "./report_Issue_send_new_email";				//신규 이메일발송
            var url = "./report_Issue_send_meritz_email";				//메리츠 이메일발송

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
            
      function fnIssueSendMsg(idx){
          if(confirm("해당 대상자에게 메시지 발송을 하시겠습니까?\n발송실패로 인한 재발송 시에는 연락처 수정 후 \n수정버튼을 클릭하시고 문자발송하세요.")){
        	            	
              var param = {};
              param.suim_rpt_no           = $("#suim_rpt_no").val();                    
              param.serial_no         = idx;
              
              var url = "./report_Issue_send_meritz_msg";			//메리츠 문자발송

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
      }        
    
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
	
	//메리츠 작성일자 수정 폼 불러오기
	function fnWriteDateSaveUp(){
		getWriteDate('edit');
	}
	
	//메리츠 작성일자 수정 폼 취소
	function fnIssueWriteDateCancel() {
      	//작성일자 보기 불러오기
        getWriteDate('view');
    }
	
	//메리츠 작성일자 수정정보 갱신
	function fnIssueWriteDateSave() {
    	
		//메리츠 작성일자 정보 갱신		
		var url = "updateMeritzWriteDateInfo";
    	
		var formData = $("#writeEditForm").serialize();
    	
		$.ajax({
	        type: "POST",
	        url: url,
	        data: formData,
	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        dataType: "JSON",
	        timeout: 20000,
	        success: function(data){
	        	if (data == 1){
	        		alert("작성일자가 수정되었습니다.");	        		
	        		//보기페이지로 호출
	        		getWriteDate('view');
	        		
	        	}else{
	        		alert("작성일자 수정에 실패 하였습니다. IT정보보호파트에 문의 해 주세요.");
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
	
	//메리츠 작성일자 불러오기
	function getWriteDate(p_mode){
		
		var sSuimRptNoVal = $("#suim_rpt_no").val();		
		var param = {};
		param.suim_rpt_no = sSuimRptNoVal;
		param.write_edit_type = p_mode;		
		
		//메리츠담보정보 가져오기
		var url = "./getIssueWriteDateMeritz";

        $.ajax({
            type: "POST",
            url: url,
            data: param,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            dataType: "html",
            timeout: 20000,
            success: function(data){
                $("#div_issue_write_date").html(data);				                
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
	
	//메리츠 담보설정 불러오기
	function getCoverageInfo(p_mode){
	
		var sSuimRptNoVal = $("#suim_rpt_no").val();		
		var param = {};
		param.suim_rpt_no = sSuimRptNoVal;
		param.coverage_edit_type = p_mode;		
		
		//메리츠담보정보 가져오기
		var url = "./getIssueCoverageInfoMeritz";

        $.ajax({
            type: "POST",
            url: url,
            data: param,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            dataType: "html",
            timeout: 20000,
            success: function(data){
                $("#div_issue_coverage").html(data);				                
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
	
	//계약정보 불러오기
	function getIssueContractInfo(p_mode){
		
		var sSuimRptNoVal = $("#suim_rpt_no").val();		
		var param = {};
		param.suim_rpt_no = sSuimRptNoVal;
		param.contract_edit_type = p_mode;
		
		//메리츠계약정보 가져오기
		var url = "./getIssueContractMeritz";

        $.ajax({
            type: "POST",
            url: url,
            data: param,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            dataType: "html",
            timeout: 20000,
            success: function(data){
                $("#div_issue_contract").html(data);				                
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
	
	//계약정보 수정기능
	function fnIssueContractEdit(){
        $("#btn_issue_contract_edit").hide();
        $("#btn_issue_contract_save").show();
        $("#btn_issue_contract_cancel").show();
        
        //계약폼 불러오기
        getIssueContractInfo('edit');
        
    }
    
    function fnIssueContractCancel() {
        $("#btn_issue_contract_edit").show();
        $("#btn_issue_contract_save").hide();
        $("#btn_issue_contract_cancel").hide();

      	//수입정보 보기 불러오기
        getIssueContractInfo('view');
    }
    
    function fnIssueContractSave(){
    	//메리츠 계약사항 갱신		
		var url = "updateMeritzContractInfo";
    	
		var formData = $("#contractEditForm").serialize();
    	
		$.ajax({
	        type: "POST",
	        url: url,
	        data: formData,
	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        dataType: "JSON",
	        timeout: 20000,
	        success: function(data){
	        	if (data == 2){				//2개테이블에 업데이트 되기때문에 2가 return 됨
	        		alert("계약사항이 수정되었습니다.");	        		
	        		//보기페이지로 호출
	        		fnIssueContractCancel();	        		
	        	}else{
	        		alert("계약사항 수정에 실패 하였습니다. IT정보보호파트에 문의 해 주세요.");
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
	
	//수임정보 불러오기
	function getIssueSuimInfo(p_mode){
		
		var sSuimRptNoVal = $("#suim_rpt_no").val();		
		var param = {};
		param.suim_rpt_no = sSuimRptNoVal;
		param.suim_edit_type = p_mode;		
		
		//메리츠수임정보 가져오기                
		var url = "./getIssueSuimInfoMeritz";

        $.ajax({
            type: "POST",
            url: url,
            data: param,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            dataType: "html",
            timeout: 20000,
            success: function(data){
                $("#div_issue_suim").html(data);				                
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
	
	//수임정보 수정기능
	function fnIssueSuimEdit(){
        $("#btn_issue_suim_edit").hide();
        $("#btn_issue_suim_save").show();
        $("#btn_issue_suim_cancel").show();
        
        //수정폼 불러오기
        getIssueSuimInfo('edit');
        
    }
    
    function fnIssueSuimCancel() {
        $("#btn_issue_suim_edit").show();
        $("#btn_issue_suim_save").hide();
        $("#btn_issue_suim_cancel").hide();

      	//수입정보 보기 불러오기
        getIssueSuimInfo('view');
    }
    
    
	function fnIssueSuimSave() {					//수임정보 수정사항 저장
    	
		//메리츠 수임정보 갱신
		var url = "updateMeritzSuimInfo";
    	
		var formData = $("#suimEditForm").serialize();
    	
		$.ajax({
	        type: "POST",
	        url: url,
	        data: formData,
	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        dataType: "JSON",
	        timeout: 20000,
	        success: function(data){	        	
	        	alert("수임정보가 수정되었습니다.");	        		
	        	//보기페이지로 호출
	        	fnIssueSuimCancel();	        	
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
	
	function fnCoverage_add(){
		
		//변경가능
		if( Coverage_Cnt > 2){
			alert("담보 내용은 3개까지 추가가 가능합니다.");
			return;
		}
		
		Coverage_Cnt++;		
		
		var addContTr = "";			
		
		addContTr = '<tr id='+Coverage_Cnt+'>'+
			'<td>'+
				'<input type="text" id="coverage_nm" name="coverage_nm">'+        		
        	'</td>'+								
			'<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="join_price" name="join_price" value="0" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>'+			
			'<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="bill_price" name="bill_price" value="0" style="text-align: right;padding-right:5px;width:80px; onkeydown="return showKeyCode(event)"">'+
			'&nbsp;<img src="./resources/ls_img/btn_del_s.gif" border="0" style="cursor:pointer" onclick="fnCoverage_del2('+Coverage_Cnt+');"/></td>'+
		'</tr>';
		
		var trHtml = $( "tr[name=coverage_tr]:last" );
		trHtml.after(addContTr);
	}
	
	function fnCoverage_del2(param){		//브라우저에서 삭제하는 경우		
		var trHtml = $( "tr[id='"+param+"']" );		
		Coverage_Cnt--;		
		trHtml.remove();
	}
	
	function fnCoverage_del(suim_rpt_no, coverage_no){
		if(confirm("선택한 담보물 정보를 삭제 하시겠습니까?")){
			var param = {};
            param.suim_rpt_no       			= suim_rpt_no;
            param.ckey								= coverage_no;
            
            var url = "./reportIssueMeritzCoverageInfoDelete";

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
                	  	getCoverageInfo('edit');                		
                	}                	
                }                
            });	
		}		
	}
	
	function fnIssueCoverageEdit(){		
	    $("#btn_issue_coverage_edit").hide();
	    $("#btn_issue_coverage_save").show();
	    $("#btn_issue_coverage_cancel").show();
	    
	  	getCoverageInfo('edit');
	}
	
	function fnIssueCoverageCancel(){		
	    $("#btn_issue_coverage_edit").show();
	    $("#btn_issue_coverage_save").hide();
	    $("#btn_issue_coverage_cancel").hide();
	    
	  	getCoverageInfo('view');
	}
	
	function fnIssueCoverageSave(){
		if(confirm("담보정보를 수정하시겠습니까?")){			
			var sForm = document.coverageEditForm;
			var nCnt = $("input[name='bill_price']").length;		//공통으로 있는 청구금액으로 row수를 계산한다.
			
			var arrList = new Array();			
							
			if( nCnt == 1 ){			//한개일때는 배열로 인식을 못함
				if( sForm.coverage_nm.value == '' ){
					alert('담보명을 입력해주세요.');
					return;
				}else{
					arrList[0] = sForm.coverage_nm.value +"|"+sForm.join_price.value+"|"+sForm.bill_price.value;	
				}					
			}else{
				for( var i=0; i < nCnt; i++ ){
					if( sForm.coverage_nm[i].value == '' ){
						alert('담보명을 입력해주세요.');
						return;
					}else{
						arrList[i] = sForm.coverage_nm[i].value +"|"+sForm.join_price[i].value+"|"+sForm.bill_price[i].value;	
					}												
				}		
			}					
			
			var param = {};
            param.suim_rpt_no       			= $("#suim_rpt_no").val();
            param.coverageList					= arrList;						//담보정보를 배열형태로 넘김
            
            var url = "./reportIssueMeritzCoverageUpdate";

            $.ajax({
                type: "POST",
                url: url,
                data: param,
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                dataType: "html",
                traditional: true,						//배열허용
                timeout: 20000,
                success: function(data){
                	if( data ){		//1이상인 경우 성공
                		alert("담보정보가 수정되었습니다.");
                		fnIssueCoverageCancel();
                	}                	
                }                
            });
		}		
	}
	
	function fnAccidentEdit(){
        $("#btn_accident_edit").hide();
        $("#btn_accident_save").show();
        $("#btn_accident_cancel").show();

        $("#table_accident_view").hide();
        $("#table_accident_edit").show();
        
    }
    
    function fnAccidentCancel() {
        $("#btn_accident_edit").show();
        $("#btn_accident_save").hide();
        $("#btn_accident_cancel").hide();

        $("#table_accident_view").show();
        $("#table_accident_edit").hide();
    }
    
    function fnAccidentSave() {
        var param = {};
        param.suim_rpt_no		= $("#suim_rpt_no").val();
        param.accident_date		= $("#accident_date_2").val();                
        param.insu_content	= $("#insu_content").val().replace(/\n/g, "\r\n");
        var url = "./rptissue_meritz_accident_update";

        $.ajax({
            type: "POST",
            url: url,
            data: param,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            dataType: "html",
            timeout: 20000,
            success: function(data){
                $("#div_accident").html(data);
                fnAccidentCancel();                        
                _initCalendar();						
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
    
  	//4. 손해사정시 적용된 관계 법령 불러오기
    function getLawEtcContent(){
    	
    	var formData = $("#lawEtcContentForm").serialize();
    	
    	$.ajax({
    		type : "post",
    		url : "getLawEtcContent",
    		data : formData,
    		success : function(result){					
    			$("#lawEtcContent").html(result);				
    		},
    		error: function (request, status, error) {			
    			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
    		}
    	});
    }
    
  	//4. 손해사정시 적용된 관계 법령 수정하기
    function fnLawContentEdit(){
    	
    	//버튼 변경
    	$("#btn_law_content_edit").hide();
    	$("#btn_law_content_save").show();
    	$("#btn_law_content_cancel").show();
    	
    	//수정모드로 변경 후 호출
    	$("#lawEtcContentFlag").val('edit');
    	getLawEtcContent();
    }
    
    //4. 손해사정시 적용된 관계 법령 수정 취소
    function fnLawContentCancel(){
    	
    	//버튼 변경
    	$("#btn_law_content_edit").show();
    	$("#btn_law_content_save").hide();
    	$("#btn_law_content_cancel").hide();
    	
    	//보기모드로 변경 후 호출
    	$("#lawEtcContentFlag").val('view');
    	getLawEtcContent();
    	
    }
    
    //4. 손해사정시 적용된 관계 법령 수정 저장
    function fnLawContentSave(){
    	
    	var url = "updateLawEtcContent";
    	
		var formData = $("#lawEtcContentForm").serialize();
    	
		$.ajax({
	        type: "POST",
	        url: url,
	        data: formData,
	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        dataType: "JSON",
	        timeout: 20000,
	        success: function(data){
	        	if (data == 1){
	        		alert("손해사정 시 적용된 관계 법규 및 약관이 수정되었습니다.");
	        		
	        		//버튼 변경
	            	$("#btn_law_content_edit").show();
	            	$("#btn_law_content_save").hide();
	            	$("#btn_law_content_cancel").hide();
	            	
	            	//보기모드로 변경 후 호출
	            	$("#lawEtcContentFlag").val('view');
	            	getLawEtcContent();
	        		
	        	}else{
	        		alert("손해사정 시 적용된 관계 법규 및 약관 수정에 실패 하였습니다. IT정보보호파트에 문의 해 주세요.");
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
    
  	//5. 약관상 보험자 지급책임의 범위 불러오기
    function getLawSelContent(){
    	
    	var formData = $("#lawSelContentForm").serialize();
    	
    	$.ajax({
    		type : "post",    		
    		url : "getLawSelContent",
    		data : formData,
    		success : function(result){					
    			$("#lawSelContent").html(result);				
    		},
    		error: function (request, status, error) {			
    			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
    		}
    	});
    }
  	
	//5. 약관상 보험자 지급책임의 범위 수정하기
  	function fnLawEdit(){
  		//버튼 변경
    	$("#btn_law_edit").hide();
    	$("#btn_law_save").show();
    	$("#btn_law_cancel").show();
    	
    	//수정모드로 변경 후 호출
    	$("#lawSelContentFlag").val('edit');
    	getLawSelContent();
  	}
	
	//5. 약관상 보험자 지급책임의 범위 수정취소하기
    function fnLawCancel(){
    	
    	//버튼 변경
    	$("#btn_law_edit").show();
    	$("#btn_law_save").hide();
    	$("#btn_law_cancel").hide();
    	
    	//보기모드로 변경 후 호출
    	$("#lawSelContentFlag").val('view');
    	getLawSelContent();
    	
    }
	
  	//5. 약관상 보험자 지급책임의 범위 수정저장
    function fnLawSave(){
    	
    	var url = "updateLawSelContent";
    	
		var formData = $("#lawSelContentForm").serialize();
    	
		$.ajax({
	        type: "POST",
	        url: url,
	        data: formData,
	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        dataType: "JSON",
	        timeout: 20000,
	        success: function(data){
	        	if (data == 1){
	        		alert("약관상 보험자 지급책임의 범위가 수정되었습니다.");
	        		
	        		//버튼 변경
	            	$("#btn_law_edit").show();
	            	$("#btn_law_save").hide();
	            	$("#btn_law_cancel").hide();
	            	
	            	//보기모드로 변경 후 호출
	            	$("#lawSelContentFlag").val('view');
	            	getLawSelContent();
	        		
	        	}else{
	        		alert("약관상 보험자 지급책임의 범위 수정에 실패 하였습니다. IT정보보호파트에 문의 해 주세요.");
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
  	
  	//6. 손해액 및 보험금 사정에 크게 영향을 미친 사항 불러오기
    function getLawReason(){
    	
    	var formData = $("#lawReasonForm").serialize();
    	
    	$.ajax({
    		type : "post",
    		url : "getLawReason",
    		data : formData,
    		success : function(result){					
    			$("#lawReason").html(result);				
    		},
    		error: function (request, status, error) {			
    			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
    		}
    	});
    }
  	
  	//6. 손해액 및 보험금 사정에 크게 영향을 미친 사항 수정하기
  	function fnLawReasonEdit(){
  		//버튼 변경
    	$("#btn_law_reason_edit").hide();
    	$("#btn_law_reason_save").show();
    	$("#btn_law_reason_cancel").show();
    	
    	//수정모드로 변경 후 호출
    	$("#lawReasonFlag").val('edit');
    	getLawReason();
  	}
  	
  	//6. 손해액 및 보험금 사정에 크게 영향을 미친 사항 수정 취소하기
  	function fnLawReasonCancel(){
    	
    	//버튼 변경
    	$("#btn_law_reason_edit").show();
    	$("#btn_law_reason_save").hide();
    	$("#btn_law_reason_cancel").hide();
    	
    	//보기모드로 변경 후 호출
    	$("#lawReasonFlag").val('view');
    	getLawReason();
    	
    }
  	
  	//6. 손해액 및 보험금 사정에 크게 영향을 미친 사항 수정 저장
    function fnLawReasonSave(){
    	
    	var url = "updateLawReason";
    	
		var formData = $("#lawReasonForm").serialize();
    	
		$.ajax({
	        type: "POST",
	        url: url,
	        data: formData,
	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        dataType: "JSON",
	        timeout: 20000,
	        success: function(data){
	        	if (data == 1){
	        		alert("손해액 및 보험금 사정에 크게 영향을 미친 사항이 수정되었습니다.");
	        		
	        		//버튼 변경
	            	$("#btn_law_reason_edit").show();
	            	$("#btn_law_reason_save").hide();
	            	$("#btn_law_reason_cancel").hide();
	            	
	            	//보기모드로 변경 후 호출
	            	$("#lawReasonFlag").val('view');
	            	getLawReason();
	        		
	        	}else{
	        		alert("손해액 및 보험금 사정에 크게 영향을 미친 사항이 수정에 실패 하였습니다. IT정보보호파트에 문의 해 주세요.");
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
</script>
<form name="sendForm" id="sendForm" method="post">
<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${suimVO.suim_rpt_no}">
<input type="hidden" id="send_edit_type" name="send_edit_type" value="view">
<input type="hidden" id="ctype" name="ctype" value="${ctype}">
<input type="hidden" id="suimRptState" value="${suimVO.suimRptState}">
</form>
<div class="reportWrap">
    <div class="issue_reportContent">
        <input type="hidden" id="suim_rpt_no" value="${param.suim_rpt_no}">
        <input type="hidden" id="suim_rpt_type1" value="${suimVO.suim_rpt_type1}">
        <input type="hidden" id="suimRptState" value="${suimVO.suimRptState}">
        <input type="hidden" id="sendListSize" value="${rptIssueSendList.size()}">
        <input type="hidden" id="sToday" value="${ sToday }" >
        <input type="hidden" id="bSendChk" value="${ sendChk }" >
        <input type="hidden" id="ptnr_mbr_nm" value="${ suimVO.ptnr_mbr_nm }" >
        <input type="hidden" id="reparationLiabilityType" value="${ rptIssue.reparationLiabilityType }">        
        
        <div class="text-right" style="margin-top: 10px;">            
            <a href="/reportIssueMeritz?suim_rpt_no=${param.suim_rpt_no}&cmd=word&suim_rpt_type1=${suimVO.suim_rpt_type1}"><img src="./resources/ls_img/report/btn_word.gif"></a>
            <a href="#noloc" onclick="fnReportPrintNew()"><img src="./resources/ls_img/report/icon_print.gif"></a>
        </div>
        
        <div class="text-center">    		
    		<p class="text-center" style="padding-top: 10px;">
    			<span style="font-size: 20px;">
    				<b>[손 해 사 정 서]</b>
    			</span>
    		</p>
    	</div>
                
        <!--// 1.수임 정보 시작-->
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell">
                <p class="subtitle">1. 수임 정보</p>
            </div>
            <div class="display-cell text-right">
                <a id="btn_issue_suim_edit" href="#noloc" onclick="fnIssueSuimEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
                <a id="btn_issue_suim_save" href="#noloc" style="display: none" onclick="fnIssueSuimSave();"><img src="./resources/ls_img/icon_write.gif"/></a>
                <a id="btn_issue_suim_cancel" href="#noloc" onclick="fnIssueSuimCancel();" style="display: none"><img src="./resources/ls_img/btn_write_cancel.gif"/></a>
            </div>
        </div>                
        <div id="div_issue_suim"></div>
        <!-- 1.수임정보 끝 -->
        
        <!-- 2.계약사항 시작 -->
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell">
                <p class="subtitle">2. 계약 사항</p>
            </div>
            <div class="display-cell text-right">
                <a id="btn_issue_contract_edit" href="#noloc" onclick="fnIssueContractEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
                <a id="btn_issue_contract_save" href="#noloc" style="display: none" onclick="fnIssueContractSave();"><img src="./resources/ls_img/icon_write.gif"/></a>
                <a id="btn_issue_contract_cancel" href="#noloc" onclick="fnIssueContractCancel();" style="display: none"><img src="./resources/ls_img/btn_write_cancel.gif"/></a>
            </div>
        </div>        
        <div id="div_issue_contract"></div>
        <!-- 2.계약사항 끝 -->
        
        <!-- 2.1 담보정보 시작 -->
        <div class="display-table" style="margin-top: 20px;margin-bottom:10px;">			
			<div class="display-cell text-right">
	               <a id="btn_issue_coverage_edit" href="#noloc" onclick="fnIssueCoverageEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
	               <a id="btn_issue_coverage_save" href="#noloc" style="display: none" onclick="fnIssueCoverageSave();"><img src="./resources/ls_img/icon_write.gif"/></a>
	               <a id="btn_issue_coverage_cancel" href="#noloc" onclick="fnIssueCoverageCancel();" style="display: none"><img src="./resources/ls_img/btn_write_cancel.gif"/></a>
	       	</div>
       	</div>
        <div id="div_issue_coverage"></div>
        <!-- 2.1 담보정보 끝 -->
        
        <!--// 3.사고 및 손해조사내용 시작-->
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell">
                <p class="subtitle">3. 사고 및 손해조사내용</p>
            </div>
            <div class="display-cell text-right">
                <a id="btn_accident_edit" href="#noloc" onclick="fnAccidentEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
                <a id="btn_accident_save" href="#noloc" style="display: none" onclick="fnAccidentSave();"><img src="./resources/ls_img/icon_write.gif"/></a>
                <a id="btn_accident_cancel" href="#noloc" onclick="fnAccidentCancel();" style="display: none"><img src="./resources/ls_img/btn_write_cancel.gif"/></a>
            </div>
        </div>        
        <div id="div_accident">
            <table id="table_accident_view">
                <tr>                    
                    <td style="text-align: left;">
               		&nbsp;${fn:replace(fn:replace(fn:escapeXml(rptIssue.insuContent) , CRLF , '<br>'), ' ', '&nbsp;')}
                    </td>
                </tr>                 
            </table>
            <input type="hidden" id="accident_date_2" name="accident_date_2" value="${rptIssueMain.accidentDate4}">
            <table id="table_accident_edit" style="display:none;">
                <tr>                   
 					<td style="text-align: left;">			  		
 							<select id="selbox" name="selbox" style="margin-bottom: 5px;">
  								<option value="${rptIssue.insuContent}">선택하세요</option>
                            	<option value="direct">직접입력</option>
	                            <option value="건강정보 등의 민간정보가 포함되어 보험업법 시행령 제99조에 의거 이를 제외하고 교부합니다.">건강정보 등의 민간정보가 포함되어 보험업법 시행령 제99조에 의거 이를 제외하고 교부합니다.</option>
                        	</select> 
                         	<textarea id=insu_content rows="5">${fn:replace(fn:replace(rptIssue.insuContent , '<br>', CRLF), ' ', '&nbsp;')}</textarea> 
					</td>
                </tr>
            </table>
        </div>
        <!--// 3.사고 및 손해조사내용 끝-->
        
        <!--// 4. 손해사정시 적용된 관계 법규 및 약관 시작 -->        
        <form name="lawEtcContentForm" id="lawEtcContentForm" method="post">
		<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${suimVO.suim_rpt_no}">
		<input type="hidden" id="lawEtcContentFlag" name="lawEtcContentFlag" value="view">		
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell">
                <p class="subtitle" style="width: 440px;">4. 손해사정시 적용된 관계 법규 및 약관</p>		                
            </div>		       		            
            <div class="display-cell text-right">
                <a id="btn_law_content_edit" href="#noloc" onclick="fnLawContentEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
                <a id="btn_law_content_save" href="#noloc" style="display: none" onclick="fnLawContentSave();"><img src="./resources/ls_img/icon_write.gif"/></a>
                <a id="btn_law_content_cancel" href="#noloc" onclick="fnLawContentCancel();" style="display: none"><img src="./resources/ls_img/btn_write_cancel.gif"/></a>
            </div>
        </div>
        <!-- 손해사정 시 적용된 관계 법규 및 약관 내용 -->
        <div id="lawEtcContent"></div>
        </form>
        <!--// 4. 손해사정시 적용된 관계 법규 및 약관 끝 -->
        
        <!-- 5.약관상 보험자 지급책임의 범위 시작 -->
        <form name="lawSelContentForm" id="lawSelContentForm" method="post">
		<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${suimVO.suim_rpt_no}">
		<input type="hidden" id="lawSelContentFlag" name="lawSelContentFlag" value="view">
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell">
                <p class="subtitle" style="width: 440px;">5. 약관상 보험자 지급책임의 범위</p>		                
            </div>		       		            
            <div class="display-cell text-right">
                <a id="btn_law_edit" href="#noloc" onclick="fnLawEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
                <a id="btn_law_save" href="#noloc" style="display: none" onclick="fnLawSave();"><img src="./resources/ls_img/icon_write.gif"/></a>
                <a id="btn_law_cancel" href="#noloc" onclick="fnLawCancel();" style="display: none"><img src="./resources/ls_img/btn_write_cancel.gif"/></a>
            </div>
        </div>
        <div id="lawSelContent"></div>
        </form>
        <!-- 5.약관상 보험자 지급책임의 범위 끝 -->
        
        <!-- 6.그 밖에 손해액 및 보험금 사정에 크게 영향을 미친사항 시작-->
        <form name="lawReasonForm" id="lawReasonForm" method="post">
		<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${suimVO.suim_rpt_no}">
		<input type="hidden" id="lawReasonFlag" name="lawReasonFlag" value="view">		
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell">
                <p class="subtitle" style="width: 460px;">6. 그 밖에 손해액 및 보험금 사정에 크게 영향을 미친사항</p>		                
            </div>		       		            
            <div class="display-cell text-right">
                <a id="btn_law_reason_edit" href="#noloc" onclick="fnLawReasonEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
                <a id="btn_law_reason_save" href="#noloc" style="display: none" onclick="fnLawReasonSave();"><img src="./resources/ls_img/icon_write.gif"/></a>
                <a id="btn_law_reason_cancel" href="#noloc" onclick="fnLawReasonCancel();" style="display: none"><img src="./resources/ls_img/btn_write_cancel.gif"/></a>
            </div>
        </div>
        <div id="lawReason"></div>
        </form>
        <!-- 6.그 밖에 손해액 및 보험금 사정에 크게 영향을 미친사항 끝-->
        
        <!-- 하단 안내 문구 시작 -->
        <div class="display-table" style="margin-top: 20px;margin-left:20px;">
            <div class="display-cell">
                <p class="subtitle">민감정보가 포함된 내용은 피보험자의 동의가 있을 경우에만 제공됩니다.</p>
                <p class="subtitle">상기 손해사정결과는 보험금 최종심사 결과와 상이할 수 있습니다.</p>		                
            </div>
		</div>
        <!-- 하단 안내 문구 끝 -->
                
        <!-- 작성일자 입력 기능 시작 -->
        <div id="div_issue_write_date"></div>
        <!-- 작성일자 입력 기능 끝 -->
        
        <!-- 조사자, 담당손해사정사 표시 시작 -->        
        <c:choose>
		 		<c:when test="${empty certiReportUser}">
		 			<div style="padding:20px 0 20px 0;">
					 	<table>
					 		<tr>					 			
					 			<td style="font-size:14px; font-family: 돋움; color: red; text-align:left;">
					 				[미배당건으로 담당자 정보가 없습니다.]
					 			</td>					 			
					 		</tr>					 		
					 	</table>
				 	</div>
		 		</c:when>
		 		<c:otherwise>		 			
		 				<div style="padding:20px 0 10px 0;">
		 					<table id="table_issue_meritz">
		 						<c:forEach items="${certiReportUser}" var="certiUserVo" varStatus="status">
			 						<tr>
			 							<th width="15%">
			 								<c:choose>
			 									<c:when test="${status.index eq 0}">조사자</c:when>
			 									<c:otherwise>${certiUserVo.certi_state_val}</c:otherwise>
			 								</c:choose>
			 							</th>
			 							<td width="25%">
			 								${certiUserVo.user_name}&nbsp;
			 								<img src="https://www.toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${certiUserVo.user_no}/${certiUserVo.user_sign}" width="30px" height="20px">
			 							</td>
			 							<th width="10%">등록번호</th>
			 							<td>${certiUserVo.certi_number}</td>
			 							<th width="10%">연락처</th>
			 							<td><c:if test='${certiUserVo.work_phone != ""}'>${certiUserVo.work_phone}</c:if></td>
			 						</tr>
		 						</c:forEach>		 						
		 					</table>						 	
					 	</div>
		 			
		 		</c:otherwise>
		 	</c:choose>        
        <!-- 조사자, 담당손해사정사 표시 끝 -->
        
		
		<div class="text-center" style="padding:20px 0 20px 0;">	
			<img src="./resources/ne_img/sign_ceo.jpg" /><br/><br/>		
        </div>        
		<!-- <div style="font-size: 14px; float:left; font-family: 돋움; color: #000; margin: 20px 0px;" >
			※본 손해사정서는 보험업법 제188조에 근거한 손해사정사의 의견으로 보험업법 제189조에 따라 발송하는 서식이며 보험사의
			최종의사결과에 따라 달라질 수 있음을 양지해 주시기 바랍니다.
		</div> -->	
        
        <div class="display-table" style="margin-top: 10px;">
	    	<!-- 손해사정서 교부대상자 추가 -->      	
	        <div class="display-cell">
				<p class="subtitle">▣ 손해사정서 교부 대상자</p>			
			</div>
			<div class="display-cell text-right">
				   <img src="./resources/ls_img/report/icon_print.gif" border="0" onclick="fnSendReportPrint()" style="cursor:pointer;">
	               <img id="btn_send_add" src="./resources/ls_img/ls_body/btn_add.gif" onclick="fnIssueSendAdd()" border="0" style="cursor:pointer;"/>	               
	               <img id="btn_send_cancel" src="./resources/ls_img/btn_write_cancel.gif" onclick="fnIssueSendCancel()" border="0" style="cursor:pointer;display:none;"/>	               
	       	</div>
	    </div>
		<div class="issue_lotte">
			<div id="send_list"></div>			
		</div>
		<br/>
        <c:import url="/rptissue_law_modal" />        
		<br/>
		<br/>
    </div> <!-- //reportContent-->
</div> <!-- //reportWrap-->