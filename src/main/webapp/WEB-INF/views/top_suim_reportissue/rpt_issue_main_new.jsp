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
		_initMask();		
		_initCalendar();
		_initEvent();
		getSendList();
		
		//손해사정시 적용된 법규 및 약관 불러오기
		getLawEtcContent();
		
		//약관상 보험자 지급책임의 범위 불러오기
		getLawSelContent();
		
		//손해액 및 보험금 사정에 크게 영향을 미친사항 불러오기
		getLawReason();
		
		//입력값에 '~' 있으면 분리해서 넣어준다.
		var sDate = '${rptIssueMain.insuTerm}';						
		if( sDate.indexOf("~") > -1 ){
			var bDate = sDate.split("~");
			$("#insu_term").val(bDate[0]);
			$("#insu_term_end").val(bDate[1]);
		}
		//달력추가 끝 by top3009
		
		//지급보험금 옵션처리
		$("#insupayment_disable").click( function(){
			if( $('input:checkbox[id="insupayment_disable"]').is(":checked") ){			//체크				
				$("#amt_insu_payment").prop('readonly','true');
				$("#amt_insu_payment").attr('style','background-color:#e2e2e2;');
			}else{			//체크해제				
				$("#amt_insu_payment").prop('readonly','');
				$("#amt_insu_payment").attr('style','background-color:#FFFFFF;');
			}			
		});
		
	});

      function fnInsupaymentEdit(){
          $("#btn_insupayment_edit").hide();
          $("#btn_insupayment_save").show();
          $("#btn_insupayment_cancel").show();

          $("#table_insupayment_view").hide();
          $("#table_insupayment_edit").show();
          
      }
      
      function fnInsupaymentCancel() {
          $("#btn_insupayment_edit").show();
          $("#btn_insupayment_save").hide();
          $("#btn_insupayment_cancel").hide();

          $("#table_insupayment_view").show();
          $("#table_insupayment_edit").hide();
      }
      

      function fnInsupaymentSave() {
          var param = {};
          param.suim_rpt_no		= $("#suim_rpt_no").val();
          param.amt_insu_payment	= $("#amt_insu_payment").val().num();
          
          if( $('input:checkbox[id="insupayment_disable"]').is(":checked") ){			//지급금액 표시안함
        	  param.amt_insu_payment_disable = '1';
          }else{																								//지급금액 표시
        	  param.amt_insu_payment_disable = '0';
          }
          
          var url = "./rptissue_insupayment_update";

          $.ajax({
              type: "POST",
              url: url,
              data: param,
              contentType: "application/x-www-form-urlencoded; charset=UTF-8",
              dataType: "html",
              timeout: 20000,
              success: function(data){
                  $("#div_insupayment").html(data);
                  fnInsupaymentCancel();	                        
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
      
    function fnReportWord(){
        var cw=screen.availWidth;
        var ch=screen.availHeight;

        var sw=1000; //띄울 창의 넓이

        var sh=740;  //띄울 창의 높이
        var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
        var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치

        window.open('/reportIssueMainNew?suim_rpt_no='+'${param.suim_rpt_no}'+'&cmd=word'+'&suim_rpt_type1='+'${suimVO.suim_rpt_type1}','word','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
    }

    function fnReportPrintNew(){
        var cw=screen.availWidth;
        var ch=screen.availHeight;

        var sw=700; //띄울 창의 넓이
        var sh=550;  //띄울 창의 높이

        var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
        var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치

        window.open('/reportIssueMainNew?suim_rpt_no='+'${param.suim_rpt_no}'+'&cmd=print'+'&suim_rpt_type1='+'${suimVO.suim_rpt_type1}','print','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
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

	function fnWriteDateSave( infoMsg ) {			//날짜 수동 저장 외 변경사항이 있는 경우 현재 날짜로 갱신한다. by top3009	        	
	
	    var param = {};
	    param.suim_rpt_no	= $("#suim_rpt_no").val();
	    param.write_date	= $("#sToday").val();	            
	    
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
	        		alert(infoMsg+'\n(손해사정서 교부 작성일이 변경되었습니다.)');	                		
	        		$("#write_date").val($("#sToday").val());		//날짜 갱신
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
	
    function fnIssueContractEdit(){
        $("#btn_issue_cont_edit").hide();
        $("#btn_issue_cont_save").show();
        $("#btn_issue_cont_cancel").show();

        $("#table_issue_contract_view").hide();
        $("#table_issue_contract_edit").show();
        
    }
    
    function fnIssueContractCancel() {
        $("#btn_issue_cont_edit").show();
        $("#btn_issue_cont_save").hide();
        $("#btn_issue_cont_cancel").hide();

        $("#table_issue_contract_view").show();
        $("#table_issue_contract_edit").hide();
    }
    
    function fnIssueContractSave() {					//보험계약사항 수정 저장
    	
    	var amt_compensation_limit_val = $("#amt_compensation_limit").val().num(); 
    	var amt_self_pay_val = $("#amt_self_pay").val().num();
    	
    	if( amt_compensation_limit_val == '' ){
    		amt_compensation_limit_val = 0;
    	}
    
    	if( amt_self_pay_val == '' ){
    		amt_self_pay_val = 0;
    	}
    	
    	if ( $("#poltel_1").val()=="" || $("#poltel_2").val()=="" ||  $("#poltel_3").val()==""){
        	var policyholderTel = "";
        }else{
        	var policyholderTel = $("#poltel_1").val()+"-"+$("#poltel_2").val()+"-"+$("#poltel_3").val();
        }

        if ( $("#bentel_1").val()=="" || $("#bentel_2").val()=="" ||  $("#bentel_3").val()==""){
        	var beneficiaryTel = "";
        }else{
        	var beneficiaryTel = $("#bentel_1").val()+"-"+$("#bentel_2").val()+"-"+$("#bentel_3").val();
        }
    	
        var param = {};
        param.suim_rpt_no       			= $("#suim_rpt_no").val();
        param.insurance_nm       			= $("#insurance_nm").val();
        param.insu_term       				= $("#insu_term").val()+"~"+$("#insu_term_end").val();
        param.insu_condition       			= $("#insu_condition").val();
        param.amt_compensation_limit_unit   = $("#amt_compensation_limit_unit").val();
        param.amt_compensation_limit       	= amt_compensation_limit_val;
        param.amt_self_pay_unit       		= $("#amt_self_pay_unit").val();
        param.amt_self_pay       			= amt_self_pay_val;
        
        //계약자, 피보험자 추가
        param.policyholder_nm				= $("#policyholder_nm").val();
        param.beneficiary_nm				= $("#beneficiary_nm").val();
        
        //계약자, 피보험자 연락처 추가
        param.policyholder_tel				= policyholderTel;
        param.beneficiary_tel				= beneficiaryTel;        
        
        //신규 보험 계약사항 수정
        var url = "./rptissue_contract_new_update";        

        $.ajax({
            type: "POST",
            url: url,
            data: param,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            dataType: "html",
            timeout: 20000,
            success: function(data){
                $("#div_issue_contract").html(data);
                fnIssueContractCancel();
                _initEvent();
                
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

    $(function(){
    //직접입력 인풋박스 기존에는 숨어있다가
    $("#insu_content").hide();
    $("#selbox").change(function() {            		
                    //직접입력을 누를 때 나타남
    		if($("#selbox").val() == "direct") {
    			$("#insu_content").show();
    		}  else {
    			$("#insu_content").hide().val($(this).val());
    			$("#insu_content").attr("readonly",ture);
    		}
    	}) 
    });   

    function fnAccidentSave() {
        var param = {};
        param.suim_rpt_no		= $("#suim_rpt_no").val();
        param.accident_date		= $("#accident_date_2").val();                
        param.insu_content	= $("#insu_content").val().replace(/\n/g, "\r\n");
        var url = "./rptissue_accident_update";

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

    /* function fnLawEdit(){
        $("#btn_law_edit").hide();
        $("#btn_law_save").show();
        $("#btn_law_cancel").show();                

        fnSelectAppendOption("insupayment");

        $("#table_law_view").hide();
        $("#table_law_edit").show();
        
    }
    
    function fnLawCancel() {
        $("#btn_law_edit").show();
        $("#btn_law_save").hide();
        $("#btn_law_cancel").hide();

        $("#table_law_view").show();
        $("#table_law_edit").hide();
    }
    
    function fnLawSave() {
        var param = {};
        param.suim_rpt_no       			= $("#suim_rpt_no").val();                
        param.reparation_liability_type		= $("#select_reparation_liability_type").val();
        param.reparation_liability_reason   = $("#reparation_liability_reason").val().replace(/\n/g, "\r\n");
        
        var url = "./rptissue_law_update";

        $.ajax({
            type: "POST",
            url: url,
            data: param,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            dataType: "html",
            timeout: 20000,
            success: function(data){
                $("#div_law").html(data);
                fnLawCancel();                        
                _initEvent();                        
                //새로고침 하지 않아도 수정되도록 기능 변경 by top3009
                $("#reparationLiabilityType").val(param.reparation_liability_type);						
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
    } */
    
	function fnSelectInit(gubun){
	   	if ("liability" == gubun){
	    	$("#reparation_liability_reason").val("");
	    	if ( $("#select_reparation_liability_type option:selected").val() == 1 ){
 	    	$("#btn_pop_law").show();
 	    	$("#reparation_liability_reason").show();
	    	}else{
 	    	$("#btn_pop_law").show();
 	    	$("#reparation_liability_reason").show();
 	    	    	
	    	}
	    	
		}else if ("insupayment" == gubun){
			
		}	   
   }

 	function fnInputClean(){        		
 		$("#mobile_display").hide();
 		$("#disagree_display").hide();
 		$("#none_display").show();
 	}
 
     /* function fnIssueSendAdd(){                
         fnInputClean();
         $("#btn_issue_send_add").hide();
         $("#tr_issue_send_add").show();
     } */
     
     function fnIssueSendAdd(){			//손해사정서 추가버튼		
 		$("#btn_send_add").hide();
 		$("#btn_send_save").show();
 		$("#btn_send_cancel").show();
 		
 		$("#send_edit_type").val("edit");		//모드를 에디트모드로 변경한다.
 		getSendList();
 	}
     
     /* function fnIssueSendCancel(){                
         fnInputClean();
         $("#btn_issue_send_add").show();
         $("#tr_issue_send_add").hide();
     } */
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
     
     /* function fnIssueSendSave(){
     	if ( !$("#privacy_agree1_add").is(":checked") && !$("#privacy_agree2_add").is(":checked")){
     		alert("개인정보 동의 여부를 체크 해 주세요..");
     		return;
     	}            	
     		
     	if ( !$("#privacy_agree2_add").is(":checked") && ($("#tel1_add").val() == "" || $("#tel2_add").val() == "" || $("#tel3_add").val() == "")){
     		alert("연락처를 정확히 입력 해 주세요..");
     		
     		return;
     	} 
     	
     	var flg;
     	
     	if( $("#privacy_agree1_add").is(":checked")){
     		flg = 1;
     	}else{
     		flg = 0;
     	}            	
     	
     	fnIssueSend("C","add",flg);
             
     } */
     
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
             		//alert("교부 대상자 등록에 성공했습니다.");
             		fnWriteDateSave('교부 대상자 등록에 성공했습니다.');		//날짜 갱신되도록 수정
             		$("#sendListSize").val(sendListSize + 1);
             	}else if (type == "D"){ 
             		//alert("교부 대상자 삭제에 성공했습니다.");
             		fnWriteDateSave('교부 대상자 삭제에 성공했습니다.');		//날짜 갱신되도록 수정
             		$("#sendListSize").val(sendListSize - 1);
             	}else if (type == "U"){
             		//alert("교부 대상자 수정에 성공했습니다.");
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
            
            //var url = "./report_Issue_send_email";
            var url = "./report_Issue_send_new_email";				//신규 이메일발송

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
              //param.serial_no         = $("#send_serial_no_" + idx).val();                    
              param.serial_no         = idx;

              //var url = "./report_Issue_send_msg";
              var url = "./report_Issue_send_new_msg";			//신규 문자 발송              

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
	
	function _initEvent(){
        $(".selectTxt").on("change", function () {
        	fnSelectTxtView(this);
        });

        $(".lawSelect").on("change", function () {
        	var gubun = $(this).data("gubun");
        	fnSelectInit(gubun);
        });
        
        $(".lawSelect2").on("change", function () {
        	var gubun = $(this).data("gubun");
        	fnSelectAppendOption(gubun);
        });
        
        $("#btn_pop_law").on("click", function () {
        	fnOpenLawModal();
        });        
        
        var bSendChk = $("#bSendChk").val();        
        if( bSendChk == 'true'){		//발송성공건이 하나라도 있는경우        	
        	$("#write_date").val('${rptIssue.writeDate}');
        }        
	}
	
    function fnSelectTxtView(that){    	
    	var selectVal = $(that).val();
		var txtId = $(that).prop("id").substring(7);
		
		if (selectVal == '99'){
			$("#"+txtId).show();
		}else{
			$("#"+txtId).val(selectVal);
			$("#"+txtId).hide();
		}
    }
    
    function fnSelectAppendOption(gubun){
        var param = {};
        param.gubun = gubun;
        
        var url = "./rptissue_stb_option_select";

        $.ajax({
            type: "POST",
            url: url,
            data: param,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            dataType: "JSON",
            timeout: 20000,
            success: function(data){
            	var id,type, val = "";
            	
            	if ("liability" == gubun){
            		//모달 체크박스방식으로 변경 -> 미사용
            		id = "select_reparation_liability_reason";
            		type = $("#select_reparation_liability_type option:selected").val();
                	txtId = id.substring(7);
                	txtVal = $("#"+txtId).val();
                	
            	}else if ("insupayment" == gubun){
                	id = "select_insu_payment_reason";
                	type = $("#select_insu_payment_type option:selected").val();
                	txtId = id.substring(7);
                	txtVal = $("#"+txtId).val();
                	
            	}
            	
           		$("#"+id+" option").remove();
           		$("#"+id).prepend("<option value='99'>직접입력</option>");
           		nullFlag = 1;
           		if (type == 1){
					$.each(data, function(key, value){
						if (txtVal == value.col_val){
							$("#"+id).append("<option value='"+value.col_val+"' selected >"+value.col_val+"</option>");
							nullFlag = 0;
						}else{
							$("#"+id).append("<option value='"+value.col_val+"'>"+value.col_val+"</option>");
						}
					});
					$("#"+id).change();
           		}
				if (nullFlag == 1){
					$("#"+txtId).val(txtVal);						
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

    function fnWinClose(){
        window.opener.location.href = "/";
        self.close();
        
    }
    
    //3. 손해사정시 적용된 관계 법령 불러오기
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
    
    //3. 손해사정서 적용된 관계 법령 수정하기
    function fnLawContentEdit(){
    	
    	//버튼 변경
    	$("#btn_law_content_edit").hide();
    	$("#btn_law_content_save").show();
    	$("#btn_law_content_cancel").show();
    	
    	//수정모드로 변경 후 호출
    	$("#lawEtcContentFlag").val('edit');
    	getLawEtcContent();
    }
    
    //3. 손해사정서 적용된 관계 법령 수정 취소
    function fnLawContentCancel(){
    	
    	//버튼 변경
    	$("#btn_law_content_edit").show();
    	$("#btn_law_content_save").hide();
    	$("#btn_law_content_cancel").hide();
    	
    	//보기모드로 변경 후 호출
    	$("#lawEtcContentFlag").val('view');
    	getLawEtcContent();
    	
    }
    
    //3. 손해사정서 적용된 관계 법령 수정 저장
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
    
  	//4. 약관상 보험자 지급책임의 범위 불러오기
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
  	
	//4. 약관상 보험자 지급책임의 범위 수정하기
  	function fnLawEdit(){
  		//버튼 변경
    	$("#btn_law_edit").hide();
    	$("#btn_law_save").show();
    	$("#btn_law_cancel").show();
    	
    	//수정모드로 변경 후 호출
    	$("#lawSelContentFlag").val('edit');
    	getLawSelContent();
  	}
	
	//4. 약관상 보험자 지급책임의 범위 수정취소하기
    function fnLawCancel(){
    	
    	//버튼 변경
    	$("#btn_law_edit").show();
    	$("#btn_law_save").hide();
    	$("#btn_law_cancel").hide();
    	
    	//보기모드로 변경 후 호출
    	$("#lawSelContentFlag").val('view');
    	getLawSelContent();
    	
    }
	
  	//4. 약관상 보험자 지급책임의 범위 수정저장
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
  	
  	//5. 손해액 및 보험금 사정에 크게 영향을 미친 사항 불러오기
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
  	
  	//5. 손해액 및 보험금 사정에 크게 영향을 미친 사항 수정하기
  	function fnLawReasonEdit(){
  		//버튼 변경
    	$("#btn_law_reason_edit").hide();
    	$("#btn_law_reason_save").show();
    	$("#btn_law_reason_cancel").show();
    	
    	//수정모드로 변경 후 호출
    	$("#lawReasonFlag").val('edit');
    	getLawReason();
  	}
  	
  	//5. 손해액 및 보험금 사정에 크게 영향을 미친 사항 수정 취소하기
  	function fnLawReasonCancel(){
    	
    	//버튼 변경
    	$("#btn_law_reason_edit").show();
    	$("#btn_law_reason_save").hide();
    	$("#btn_law_reason_cancel").hide();
    	
    	//보기모드로 변경 후 호출
    	$("#lawReasonFlag").val('view');
    	getLawReason();
    	
    }
  	
  	//5. 손해액 및 보험금 사정에 크게 영향을 미친 사항 수정 저장
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
        
        <div class="text-right">
            <%-- <a href="/reportIssueMain?suim_rpt_no=${param.suim_rpt_no}&cmd=word&suim_rpt_type1=${suimVO.suim_rpt_type1}"><img src="./resources/ls_img/report/btn_word.gif"></a> --%>
            <a href="/reportIssueMainNew?suim_rpt_no=${param.suim_rpt_no}&cmd=word&suim_rpt_type1=${suimVO.suim_rpt_type1}"><img src="./resources/ls_img/report/btn_word.gif"></a>
            <!-- <a href="#noloc" onclick="fnReportPrint()"><img src="./resources/ls_img/report/icon_print.gif"></a> -->
            <a href="#noloc" onclick="fnReportPrintNew()"><img src="./resources/ls_img/report/icon_print.gif"></a>
        </div>
        <div>
            <img src="//www.toplac.co.kr/resources/ls_img/ls_body/print_head.jpg" width="640" height="56">
            <p class="text-center" style="padding-top: 6px;"><span style="font-size: 9pt;">${reportTeamInfo.teamAddr}</span></p>
            <p class="text-center">
					<span style="font-size: 9pt;">
                        전화 : ${reportInvgUser.officeTel} &nbsp;팩스 : ${reportInvgUser.officeFax} &nbsp;이메일 : ${reportInvgUser.email}
                    </span>
            </p>
            <p class="text-center" style="padding-top: 2px;">
                <img src="//www.toplac.co.kr/resources/ls_img/ls_body/print_hr.jpg" width="640" height="3" border="0" class="img-responsive center-block">
            </p>
        </div>
        <div style="margin-top: 10px;">
            <div style="width: 76%; float: left">
            	<p class="issuetitle">Report No.&nbsp;&nbsp;:&nbsp; ${rptIssueMain.suimAcceptNo}</p>
                <p class="issuetitle">
                	수 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;신&nbsp;&nbsp;:&nbsp;&nbsp;보험계약자, 피보험자 및 보험금청구권자
               	</p>
                <p class="issuetitle">
                    제 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목&nbsp;&nbsp;:&nbsp;&nbsp;손해사정서[사고번호 : ${rptIssueMain.accidentNo}]
                </p>
                <!-- 수임일추가 시작 by top3009 -->
                <p class="issuetitle">수&nbsp;&nbsp;&nbsp;임&nbsp;&nbsp;&nbsp;일&nbsp;&nbsp;:&nbsp;&nbsp;${rptIssueMain.regDate}</p>
                <!-- 수임일추가 끝 by top3009 -->
            </div>
            
            <div style="width: 24%; float: right">
				<p class="issuetitle" style="margin-right: 0; text-align: right;">
					<!-- 작성날짜를 DB 에서 가져오지 않고 열람시간을 기준으로 넣어준다. -->
					Date <input class="calendar" type="text" id="write_date" value="${sToday}" style="width: 50%;"/>
					<a href="#noloc" id="btn_wirte_date_edit" onclick="fnWriteDateSaveUp();"><img src="./resources/ls_img/btn_edit_s.gif"/></a>
				</p>
			</div>
            <div style="clear: both"></div>            
        </div>        
        <!--// 1.보험계약사항 -->
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell">
                <p class="subtitle">1. 보험계약사항</p>
            </div>
            <div class="display-cell text-right">
                <a id="btn_issue_cont_edit" href="#noloc" onclick="fnIssueContractEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
                <a id="btn_issue_cont_save" href="#noloc" style="display: none" onclick="fnIssueContractSave();"><img src="./resources/ls_img/icon_write.gif"/></a>
                <a id="btn_issue_cont_cancel" href="#noloc" onclick="fnIssueContractCancel();" style="display: none"><img src="./resources/ls_img/btn_write_cancel.gif"/></a>
            </div>
        </div>
        
        <div id="div_issue_contract"> 
            <table id="table_issue_contract_view" style="border: 1px solid">
                <colgroup>
                    <col width="15%">
                    <col width="35%">
                    <col width="15%">                    
                    <col width="35%">
                </colgroup>                
                <tr>
                    <th>보&nbsp;&nbsp;험&nbsp;&nbsp;사&nbsp;&nbsp;명</th>
                    <td style="text-align: left;">&nbsp;${rptIssueMain.ptnrName}</td>
                    <th>보&nbsp;&nbsp;험&nbsp;&nbsp;종&nbsp;&nbsp;목</th>
                    <td style="text-align: left;">&nbsp;${rptIssueMain.insuranceNm}</td>
                </tr>
                <!-- 계약자 피보험자 시작 by top3009 -->
                <tr>
                    <th>계&nbsp;&nbsp;&nbsp;&nbsp;약&nbsp;&nbsp;&nbsp;&nbsp;자</th>
                    <td style="text-align: left;">&nbsp;${rptIssueMain.policyholderNm}</td>
                    <th>피&nbsp;&nbsp;보&nbsp;&nbsp;험&nbsp;&nbsp;자</th>
                    <td style="text-align: left;">&nbsp;${rptIssueMain.beneficiaryNm}</td>
                </tr>
                <!-- 계약자 피보험자 끝 by top3009 -->   
                <tr>
                    <th>보&nbsp;&nbsp;험&nbsp;&nbsp;기&nbsp;&nbsp;간</th>
                    <td style="text-align: left;">&nbsp;${rptIssueMain.insuTerm}</td>
                    <th>담&nbsp;&nbsp;보&nbsp;&nbsp;내&nbsp;&nbsp;용</th>
                    <td style="text-align: left;">&nbsp;${rptIssueMain.insuCondition}</td>
                </tr>                    
                <tr>
                    <th>가&nbsp;&nbsp;입&nbsp;&nbsp;금&nbsp;&nbsp;액</th>
                    <td style="text-align: left;">&nbsp;${rptIssueMain.amtCompensationLimitUnit} 
                    	<span class="money">${rptIssueMain.amtCompensationLimit}</span>                    
                    </td>
                    <th>자 기 부 담 금</th>
                    <td style="text-align: left;">&nbsp;${rptIssueMain.amtSelfPayUnit} 
                    	<span class="money">${rptIssueMain.amtSelfPay}</span>                    
                    </td>
                </tr>                
            </table>
            <table id="table_issue_contract_edit" style="display:none;">
                    <col width="15%">
                    <col width="35%">
                    <col width="15%">                    
                    <col width="35%">
                <tr>
                    <th>보&nbsp;&nbsp;험&nbsp;&nbsp;사&nbsp;&nbsp;명</th>
                    <td style="text-align: left;">&nbsp;${rptIssueMain.ptnrName}</td>
                    <th>보&nbsp;&nbsp;험&nbsp;&nbsp;종&nbsp;&nbsp;목</th>
                    <td style="text-align: left;"><input type="text" id="insurance_nm" value="${rptIssueMain.insuranceNm}"></td>
                </tr>
                
                <!-- 계약자 피보험자 시작 by top3009 -->
                <tr>
                    <th>계&nbsp;&nbsp;&nbsp;&nbsp;약&nbsp;&nbsp;&nbsp;&nbsp;자</th>
                    <td style="text-align: left;"><input type="text" id="policyholder_nm" value="${rptIssueMain.policyholderNm}"></td>
                    <th>피&nbsp;&nbsp;보&nbsp;&nbsp;험&nbsp;&nbsp;자</th>
                    <td style="text-align: left;"><input type="text" id="beneficiary_nm" value="${rptIssueMain.beneficiaryNm}"></td>
                </tr>
                <tr>
                    <th>계약자연락처</th>
                    <td style="text-align: left;padding-left:5px;">
                    	<input type="text" size="5" maxlength="4" id="poltel_1" value="${policyholder_tel_1}" onkeydown="javascript:onlyNumberFunc2(this);" style="width:50px;IME-MODE: disabled;"> -
						<input type="text" size="5" maxlength="4" id="poltel_2" value="${policyholder_tel_2}" onkeydown="javascript:onlyNumberFunc2(this);" style="width:60px;IME-MODE: disabled;"> -
						<input type="text" size="5" maxlength="4" id="poltel_3" value="${policyholder_tel_3}" onkeydown="javascript:onlyNumberFunc2(this);" style="width:60px;IME-MODE: disabled;"> 
                    </td>
                    <th>피보험자연락처</th>
                    <td style="text-align: left; left;padding-left:5px;">
                    	<input type="text" size="5" maxlength="4" id="bentel_1" value="${beneficiary_tel_1}" onkeydown="javascript:onlyNumberFunc2(this);" style="width:50px;IME-MODE: disabled;"> -
						<input type="text" size="5" maxlength="4" id="bentel_2" value="${beneficiary_tel_2}" onkeydown="javascript:onlyNumberFunc2(this);" style="width:60px;IME-MODE: disabled;"> -
						<input type="text" size="5" maxlength="4" id="bentel_3" value="${beneficiary_tel_3}" onkeydown="javascript:onlyNumberFunc2(this);" style="width:60px;IME-MODE: disabled;"> 
                    </td>
                </tr>
                <!-- 계약자 피보험자 끝 by top3009 -->
                
                <tr>
                    <th>보&nbsp;&nbsp;험&nbsp;&nbsp;기&nbsp;&nbsp;간</th>
						<td style="text-align: left;">
						    <input class="calendar" type="text" id="insu_term" value="" style="width: 35%;"/>
						    &nbsp;~&nbsp;
						    <input class="calendar" type="text" id="insu_term_end" value="" style="width: 35%;"/>	                    
						</td>
                    <th>담&nbsp;&nbsp;보&nbsp;&nbsp;내&nbsp;&nbsp;용</th>
                    <td style="text-align: left;"><input type="text" id="insu_condition" value="${rptIssueMain.insuCondition}"></td>
                </tr>      
                <tr>
                    <th>가&nbsp;&nbsp;입&nbsp;&nbsp;금&nbsp;&nbsp;액</th>
                    <td style="text-align: left;">
						<select class="selectTxt" id="select_amt_compensation_limit_unit" >
							<option value="￦" <c:if test="${rptIssueMain.amtCompensationLimitUnit eq '￦'}"> selected="selected" </c:if>>￦</option>
							<option value="$" <c:if test="${rptIssueMain.amtCompensationLimitUnit eq '$'}"> selected="selected" </c:if>>$</option>
							<option value="99" <c:if test="${rptIssueMain.amtCompensationLimitUnit ne null && rptIssueMain.amtCompensationLimitUnit ne '' && rptIssueMain.amtCompensationLimitUnit ne '￦' && rptIssueMain.amtCompensationLimitUnit ne '$'}"> selected="selected" </c:if>>직접입력</option>
						</select>
						<input type="text" id="amt_compensation_limit_unit" style="display: none;" value="${rptIssueMain.amtCompensationLimitUnit}"> 
                    	<input class="money"  type="text" id="amt_compensation_limit" value="${rptIssueMain.amtCompensationLimit}">                    
                    </td>
                    <th>자 기 부 담 금</th>
                    <td style="text-align: left;">
						<select class="selectTxt" id="select_amt_self_pay_unit"  >
							<option value="￦" <c:if test="${rptIssueMain.amtSelfPayUnit eq '￦'}"> selected="selected" </c:if>>￦</option>
							<option value="$" <c:if test="${rptIssueMain.amtSelfPayUnit eq '$'}"> selected="selected" </c:if>>$</option>
							<option value="99" <c:if test="${rptIssueMain.amtSelfPayUnit ne null && rptIssueMain.amtSelfPayUnit ne '' && rptIssueMain.amtSelfPayUnit ne '￦' && rptIssueMain.amtSelfPayUnit ne '$'}"> selected="selected" </c:if>>직접입력</option>
						</select>
				        <input type="text" id="amt_self_pay_unit" style="display: none;" value="${rptIssueMain.amtSelfPayUnit}"> 
                    	<input class="money"  type="text" id="amt_self_pay" value="${rptIssueMain.amtSelfPay}">                    
                    </td>
                </tr>                             
            </table>
        </div>
        <!--// 1.보험계약사항 -->        
        <!--// 2.사고사항 -->
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell">
                <p class="subtitle">2. 사고사항</p>
            </div>
            <div class="display-cell text-right">
                <a id="btn_accident_edit" href="#noloc" onclick="fnAccidentEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
                <a id="btn_accident_save" href="#noloc" style="display: none" onclick="fnAccidentSave();"><img src="./resources/ls_img/icon_write.gif"/></a>
                <a id="btn_accident_cancel" href="#noloc" onclick="fnAccidentCancel();" style="display: none"><img src="./resources/ls_img/btn_write_cancel.gif"/></a>
            </div>
        </div>        
        <div id="div_accident">
            <table id="table_accident_view">
                   <col width="15%">
                   <col width="85%">
                <tr>
                    <th>사&nbsp;&nbsp;고&nbsp;&nbsp;일&nbsp;&nbsp;자</th>
                    <td style="text-align: left;">&nbsp;${rptIssueMain.accidentDate5}</td>
                </tr> 
                <tr>
                    <th>사&nbsp;&nbsp;고&nbsp;&nbsp;내&nbsp;&nbsp;용</th>
                    <td style="text-align: left;">
               		&nbsp;${fn:replace(fn:replace(fn:escapeXml(rptIssue.insuContent) , CRLF , '<br>'), ' ', '&nbsp;')}
                    </td>
                </tr>                 
            </table>
            
            <table id="table_accident_edit" style="display:none;">
                <col width="15%">
                <col width="85%">
                <tr>
                    <th>사&nbsp;&nbsp;고&nbsp;&nbsp;일&nbsp;&nbsp;자</th>
                    <td style="text-align: left;"><input type="text" class="calendar" id="accident_date_2" value="${rptIssueMain.accidentDate4}" style="width:90px;" maxlength="10"></td> 
  				   
                </tr>
                <tr>
                   <th>사&nbsp;&nbsp;고&nbsp;&nbsp;내&nbsp;&nbsp;용</th>
 					<td style="text-align: left;">			  		
 							<select id="selbox" name="selbox" style="margin-bottom: 5px;">
  								<option value="${rptIssue.insuContent}">선택하세요</option>
                            	<option value="direct">직접입력</option>
	                            <option value="건강정보 등의 민간정보가 포함되어 보험업법 시행령 제99조에 의거 이를 제외하고 교부합니다.">건강정보 등의 민간정보가 포함되어 보험업법 시행령 제99조에 의거 이를 제외하고 교부합니다.</option>
                        	</select> 
                         	<textarea id=insu_content rows="5">${fn:replace(fn:replace(rptIssue.insuContent , '<br>', CRLF), ' ', '&nbsp;')}</textarea> 
					</td>	                  
                     <td>
                   	</td>
                </tr>
            </table>
        </div>
        <!--// 2.사고사항 -->
        
        <!-- 3 손해사정 시 적용된 관계 법규 및 약관 시작 -->        
        <form name="lawEtcContentForm" id="lawEtcContentForm" method="post">
		<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${suimVO.suim_rpt_no}">
		<input type="hidden" id="lawEtcContentFlag" name="lawEtcContentFlag" value="view">		
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell">
                <p class="subtitle" style="width: 440px;">3. 손해사정 시 적용된 관계 법규 및 약관</p>		                
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
        <!-- 3 손해사정 시 적용된 관계 법규 및 약관 끝 -->
        
        <!-- 4.약관상 보험자 지급책임의 범위 시작 -->
        <form name="lawSelContentForm" id="lawSelContentForm" method="post">
		<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${suimVO.suim_rpt_no}">
		<input type="hidden" id="lawSelContentFlag" name="lawSelContentFlag" value="view">
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell">
                <p class="subtitle" style="width: 440px;">4. 약관상 보험자 지급책임의 범위</p>		                
            </div>		       		            
            <div class="display-cell text-right">
                <a id="btn_law_edit" href="#noloc" onclick="fnLawEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
                <a id="btn_law_save" href="#noloc" style="display: none" onclick="fnLawSave();"><img src="./resources/ls_img/icon_write.gif"/></a>
                <a id="btn_law_cancel" href="#noloc" onclick="fnLawCancel();" style="display: none"><img src="./resources/ls_img/btn_write_cancel.gif"/></a>
            </div>
        </div>
        <div id="lawSelContent"></div>
        </form>
        <!-- 4.약관상 보험자 지급책임의 범위 끝 -->
        
        <!-- 5. 손해액 및 보험금 사정에 크게 영향을 미친 사항 시작-->
        <form name="lawReasonForm" id="lawReasonForm" method="post">
		<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${suimVO.suim_rpt_no}">
		<input type="hidden" id="lawReasonFlag" name="lawReasonFlag" value="view">		
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell">
                <p class="subtitle" style="width: 440px;">5. 손해액 및 보험금 사정에 크게 영향을 미친 사항</p>		                
            </div>		       		            
            <div class="display-cell text-right">
                <a id="btn_law_reason_edit" href="#noloc" onclick="fnLawReasonEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
                <a id="btn_law_reason_save" href="#noloc" style="display: none" onclick="fnLawReasonSave();"><img src="./resources/ls_img/icon_write.gif"/></a>
                <a id="btn_law_reason_cancel" href="#noloc" onclick="fnLawReasonCancel();" style="display: none"><img src="./resources/ls_img/btn_write_cancel.gif"/></a>
            </div>
        </div>
        <div id="lawReason"></div>
        </form>
        <!-- 5. 손해액 및 보험금 사정에 크게 영향을 미친 사항 끝-->
        		       	
        <!--// 4.손해액 및 보험금 사정에 관한 중요 근거 --> 
         <!-- 5. 지급보험금 -->
	        <div class="display-table" style="margin-top: 30px;">
	            <div class="display-cell" style="width: 70% !important;">
	                <p class="subtitle">6. 지급보험금</p>
	            </div>
	            <div class="display-cell text-right" style="width: 30% !important;">
	                <a id="btn_insupayment_edit" href="#noloc" onclick="fnInsupaymentEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
	                <a id="btn_insupayment_save" href="#noloc" style="display: none" onclick="fnInsupaymentSave();"><img src="./resources/ls_img/icon_write.gif"/></a>
	                <a id="btn_insupayment_cancel" href="#noloc" onclick="fnInsupaymentCancel();" style="display: none"><img src="./resources/ls_img/btn_write_cancel.gif"/></a>            
	            </div>
	        </div>	                      
			<div id="div_insupayment">
	        	<table id="table_insupayment_view">
	            	<tr>
	                    <th>
	                    	<c:choose>
	                    		<c:when test="${rptIssueMain.amtInsuPaymentDisable eq 1}">
	                    			<!-- 협의금액에 따름 -->단체 사고의 경우 개별 안내 금액에 따름
	                    		</c:when>
	                    		<c:otherwise>
	                    			￦ <span class="money">${rptIssueMain.amtInsuPayment}</span>		
	                    		</c:otherwise>
	                    	</c:choose>
	                   	</th>
	                </tr>
	            </table>
	            
	            <table id="table_insupayment_edit" style="display:none;">
	                <tr>
	                    <td>
	                    	<c:choose>
	                    		<c:when test="${rptIssueMain.amtInsuPaymentDisable eq 1}">
	                    			<input type="checkbox" id="insupayment_disable" checked /> 단체 사고의 경우 개별 안내 금액에 따름<br/>
	                    			<input class="money"  type="text" id="amt_insu_payment" value="${rptIssueMain.amtInsuPayment}" readonly style="background-color:#e2e2e2;">
	                    		</c:when>
	                    		<c:otherwise>
	                    			<input type="checkbox" id="insupayment_disable"/> 단체 사고의 경우 개별 안내 금액에 따름<br/>
	                    			<input class="money"  type="text" id="amt_insu_payment" value="${rptIssueMain.amtInsuPayment}">		
	                    		</c:otherwise>
	                    	</c:choose>	                    	
	                   	</td> 
	                </tr>
	            </table>            
			</div>
		 	<!-- 조사자, 담당손해사정사 시작 -->		 	
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
		 			<c:forEach items="${certiReportUser}" var="certiUserVo">
		 				<div style="padding:10px 0 10px 0;">
						 	<table>
						 		<tr>						 			
						 			<td width="12%" style="font-size:14px; font-family: 돋움; color: #000; text-align:left;">
						 				${certiUserVo.certi_state_val}
						 			</td>
						 			<td width="20%" style="font-size:14px; font-family: 돋움; color: #000; text-align:center;">
						 				${certiUserVo.user_name}
						 			</td>
						 			<td width="18%" style="font-size:14px; font-family: 돋움; color: #000; text-align:left;">						 										 				
						 				<img src="https://www.toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${certiUserVo.user_no}/${certiUserVo.user_sign}" width="30px" height="20px">
						 			</td>
						 			<td width="50%" style="font-size:13px; font-family: 돋움; color: #000; text-align:left;"></td>						 			
						 		</tr>
						 		<tr>
						 			<td colspan="4" style="font-size:14px; font-family: 돋움; color: #000; text-align:left;">
						 			 [ 등록번호 : ${certiUserVo.certi_number} <c:if test='${certiUserVo.work_phone != ""}'>/ 연락처 : ${certiUserVo.work_phone} </c:if>]
						 			</td>						 							 			
						 		</tr>
						 	</table>
					 	</div>
		 			</c:forEach>
		 		</c:otherwise>
		 	</c:choose>		 	
		 	<!-- 조사자, 담당손해사정사 끝 -->
		 	
		 	<!-- <div style="padding:20px 0 20px 0;">
			 	<table>
			 		<tr>
			 			<td width="50%" rowspan="2"></td>
			 			<td width="15%" style="font-size:14px; font-family: 돋움; color: #000; text-align:left;">손해사정사</td>
			 			<td width="12%" style="font-size:14px; font-family: 돋움; color: #000; text-align:left;">홍길동</td>
			 			<td width="23%" style="font-size:13px; font-family: 돋움; color: #000; text-align:left;">( &#9742; : 010-5333-3009 )</td>
			 		</tr>
			 		<tr>
			 			<td colspan="3" style="font-size:14px; font-family: 돋움; color: #000; text-align:left;">[등록번호 : 1234123123123]</td>
			 		</tr>
			 	</table>
		 	</div> -->
		 
         <%-- <div class="text-right" style="font-size: 14px;; font-family: 돋움; color: #000; margin: 20px 0px; padding-right: 4px;" >
			담당자 : ${reportInvgUser.disWorkLevel} ${reportInvgUser.userName}  (연락처 : ${reportInvgUser.handphone})<br/>	
		</div>
         <div class="text-right" style="font-size: 14px;; font-family: 돋움; color: #000; margin: 20px 0px; padding-right: 121px;" >
			<img src="./resources/ne_img/sign_yun2.jpg" /><br/>     	   			
		</div> --%>
		
		<div class="text-center" style="padding:20px 0 20px 0;">	
			<img src="./resources/ne_img/sign_ceo.jpg" /><br/><br/>		
        </div>        
		<div style="font-size: 14px; float:left; font-family: 돋움; color: #000; margin: 20px 0px;" >
			※본 손해사정서는 보험업법 제188조에 근거한 손해사정사의 의견으로 보험업법 제189조에 따라 발송하는 서식이며 보험사의
			최종의사결과에 따라 달라질 수 있음을 양지해 주시기 바랍니다.
		</div>		
        <!-- 5.총괄 경과표 -->
        <div class="display-table" style="margin-top: 10px;">
	    	<!-- 손해사정서 교부대상자 추가 by 요기 작업중 oniku -->      	
	        <div class="display-cell">
				<p class="subtitle">▣ 손해사정서 교부 대상자</p>			
			</div>
			<div class="display-cell text-right">
				   <img src="./resources/ls_img/report/icon_print.gif" border="0" onclick="fnSendReportPrint()" style="cursor:pointer;">
	               <img id="btn_send_add" src="./resources/ls_img/ls_body/btn_add.gif" onclick="fnIssueSendAdd()" border="0" style="cursor:pointer;"/>
	               <!-- <img id="btn_send_save" src="./resources/ls_img/icon_write.gif" onclick="fnIssueSendSave()" border="0" style="cursor:pointer;display:none;"/> -->
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