<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="true" %>


<script src="./resources/ne_js/ne_number.js"></script>
	
<script>
	
	var workload_ea_first = false;	//최초 진입시 종결건수값 변경 안되도록 하기 위한 값
	
	$(document).ready(function(){
		
		//기준업무량 초기화 
		$("#workload_type"+"${suimVO.suimRptType1}"+"_"+"${suimVO.workloadType}").attr("checked",true);
		if ("${suimVO.workloadType}" == ""){
			workload_ea_first = true;
		}
		
		//추정 손해액이 0원이면 화면에 출력하지 않기. 170222 최원일 차장님 요청
		if(	"${suimVO.amtEstimatedDamage}" == 0 ){
			$("#amtEstimatedDamage").val('');
		}
		
		$("#editeEndContentsOkBtnId").click(function(){
			
			if($("#invoiceDate").val() == ''){
				alert("인보이스 제출일을 입력하십시오.");
				return;
			}
			if ($("#suimRptEa").val() == '' ){
				alert("종결건수를 입력해 주세요.");
				return
			}
						
            if (!$('input:radio[name=cMinwonFlag]').is(':checked')) {
                alert("민원발생 여부를 선택해 주세요.");
                $("#c_minwonFlag1").focus();
                return;
                
            }else if( $('input:radio[name=cMinwonFlag]:checked').val() == 2 && $("#c_minwonDate").val() == "" ){
            	alert("민원 발생일을 입력 해 주세요.");
            	return;
            }

            if (!$('input:radio[name=cMoralFlag]').is(':checked')) {
                alert("모랄적발 여부를 선택해 주세요.");
                $("#c_moralFlag1").focus();
                return;
            }
            
            if ( $("input:radio[name='cMoralFlag']:checked").val() == 1 && $("#c_moralDate").val() == "" && suimRptType == 14 ){
            	alert("공문 수신일을 입력해 주세요.");
                $("#c_moralDate").focus();
            	return;
            }
                               
            
            if ( $("#workloadUseAt").val() == 1  && ($("#suimRptType1").val() != 3 && $("#suimRptType1").val() != 4) ){
            	if ( $("input:radio[name='workload_type']:checked").val() == null ){
            		alert("기준업무량 상세구분을 선택 해 주세요..");
            		return;
            	}
				if ( $("#workload_ea").val() == ''){
					alert("기준업무량 종결건수가 없습니다.\n기준업무량 상세구분을 한번 더 클릭해주세요..");
					return;
				}
            }
            
            var suimRptType = $("#suimRptType").val(); 
            
            var param = {};
            param.suimRptNo				= $("#suimRptNo").val();
            param.suimRptType1			= $("#suimRptType1").val();
            param.suimRptEa  			= $("#suimRptEa").val();			//종결건수
            param.amtClaimed  			= uncomma($("#amtClaimed").val());			//청구금액
            param.amtEstimatedDamage  	= uncomma($("#amtEstimatedDamage").val()); 	//평가손해액
            param.amtSettlement  		= uncomma($("#amtSettlement").val());		//합의금액
            param.amtSelfPay  			= uncomma($("#amtSelfPay").val());			//자기부담금
            param.amtInsuPayment  		= uncomma($("#amtInsuPayment").val());		//지급보험금
            param.amtReduction  		= uncomma($("#amtReduction").val());			//절감액
            param.suimRptType1Close12  	= $("#suimRptType1Close12 option:selected").val(); 	//종결 구분
            param.suimRptType1Close34  	= $("#suimRptType1Close34 option:selected").val(); 	//종결 구분
            param.minwonFlag            = $("input:radio[name='cMinwonFlag']:checked").val();
            param.moralFlag             = $("input:radio[name='cMoralFlag']:checked").val();
            if ( param.minwonFlag == 2){
	            param.minwonDate = $("#c_minwonDate").val();
            }else{
            	param.minwonDate = "";            	
            }
			
            if ( $("input:radio[name='cMoralFlag']:checked").val() == 1 && suimRptType == 14 ) {
            	param.moralDate 		= $("#c_moralDate").val();
            }else{
            	param.moralDate 		= "";
            }
            
			param.workloadUseAt			= $("#workloadUseAt").val();
            if ( $("#workloadUseAt").val() == 1){
	            param.workloadType = $("input:radio[name='workload_type']:checked").val();
	            param.retirePendingFlag = $("input:radio[name='retire_pending_flag']:checked").val();
				
				if ( $("#workload_ea").val() == ''){
					param.workloadEa = 0;
				}else{
					param.workloadEa = $("#workload_ea").val();
				}
            }
            
			//현대해상인 경우는 결재수수료 항목을 체크한다.            
            var collaboApprovalPriceVal = "0";
            var collaboApprovalUserNo = "0";
            var approvalUseFlag = "0";			//결재 수수료 입력 여부
            
			var p_ptnrId = ${suimVO.ptnr_id};
			var p_suimRptType1 = ${suimVO.suimRptType1};
			
			if( p_ptnrId == 14 && p_suimRptType1 != 3 && p_suimRptType1 != 4 ){
				collaboApprovalPriceVal = uncomma($("#collaboApprovalPrice").val());
				collaboApprovalUserNo = $("#collaboApprovalUserList").val();			
				
				//결재수수료가 있는 경우 결재자 정보가 있는지 확인한다.
				if(collaboApprovalPriceVal > 0){				
					if( collaboApprovalUserNo == 0 ){
						alert("결재수수료 결재자를 선택해주세요.");
						$("#collaboApprovalUserList").focus();
						return;
					}
				}
				
				//결재자가 있는 경우 결재수수료를 입력했는지 확인한다.
				if( collaboApprovalUserNo > 0 ){				
					if( collaboApprovalPriceVal == '' || collaboApprovalPriceVal == 0 ){
						alert("결재수수료를 입력해 주세요.");
						$("#collaboApprovalPrice").focus();
						return;
					}
				}
				
				if( collaboApprovalPriceVal > 0 &&  collaboApprovalUserNo > 0 ){
					approvalUseFlag = "1";					
					var apChgName = $("select[name=collaboApprovalUserList] option:selected").text();
					var buttonText = "<input class='buttonMini' type='button' value='결재자' style='background-color:#D8F6CE;pointer-events:none;font-weight:none;width:60px;'>";
					$("#apChgNameFrm").val(apChgName);					
				}
			}
			
            $.post("./editeEndInfoOk"
                    ,param
                    ,function(data,status){
						if(status == "success"){
							if(data == 0){
								alert(" 종결내용 저장 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								
								$("#suimRptEaSpan").html( $("#suimRptEa").val());										//종결건수
								$("#amtClaimedSpan").html( chkZeroAmt($("#amtClaimed").val(),1) ); 						//청구금액
								$("#amtEstimatedDamageSpan").html( chkZeroAmt($("#amtEstimatedDamage").val(),1) ); 		//평가손해액
								$("#amtSettlementSpan").html( chkZeroAmt($("#amtSettlement").val(),1) ); 				//합의금액

                                var tmpVal = $("#h_amtSelfPayUnit").val() + " " + chkZeroAmt1($("#amtSelfPay").val(),1)
                                $("#amtSelfPaySpan").html( tmpVal ); 						//자기부담금

								$("#amtInsuPaymentSpan").html( chkZeroAmt($("#amtInsuPayment").val(),1) ); 				//지급보험금
								$("#amtReductionSpan").html( chkZeroAmt($("#amtReduction").val(),1) ); 					//절감액
								
								//기준업무량
					            if ( $("#workloadUseAt").val() == 1){
									$("#workloadTypeSpan").html( $("input:radio[name='workload_type']:checked").attr("textValue") );
									$("#workloadEaSpan").html( $("#workload_ea").val() );
					            }
								
								$('#invoiceDateDiv').hide();
								$(".endContents").hide();
								$(".endContentsSpan").show();
								$(".endContentsSelect").prop("disabled",true);
								$("#editeEndContentsCancelBtnId").hide();
								$("#editeEndContentsOkBtnId").hide();
								$("#editeEndContentsBtnId").show();
								
                                fnEditEndInForOKComplete();
							}
						}else{
							alert("종결내용  시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
			
			$.post("./editeInvInfoOk", 
					{
						 regUserNo				: '${mbrAuthVo_Session.user_no}'
						,rptInvNo				: $("#rptInvNo").val()
						,suimRptNo				: $("#suimRptNo").val()
						,invoiceDate			: $("#invoiceDate").val() 
						,amtBasicText  			: $("#amtBasicDtl").val()				//
						,amtBasic	  			: uncomma($("#amtBasic").val()) 		//
						,amtDailyText		  	: $("#amtDailyDtl").val() 				//
						,amtDaily  				: uncomma($("#amtDaily").val()) 		//
						,amtTrafficText  		: $("#amtTrafficDtl").val() 			//
						,amtTraffic  			: uncomma($("#amtTraffic").val()) 		//
						,amtCounselText  		: $("#amtCounselDtl").val() 			//
						,amtCounsel  			: uncomma($("#amtCounsel").val()) 		//
						,amtEtcText				: $("#amtEtcDtl").val() 				//
						,amtEtc					: uncomma($("#amtEtc").val()) 			//
						,amtTotal				: uncomma($("#amtTotal").val()) 		//	
						,approvalUseFlag		: approvalUseFlag
						,approvalUserNo		: collaboApprovalUserNo
						,approvalPrice			: collaboApprovalPriceVal
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("인보이스 저장 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								
								$("#invoiceDateSpan").html( $("#invoiceDate").val()); //""+$("#invoiceDate").val()+""
								$("#amtBasicDtlSpan").html( $("#amtBasicDtl").val());
								$("#amtBasicSpan").html( chkZeroAmt($("#amtBasic").val(),1) );
															
								$("#amtClaimedSpan").html( chkZeroAmt($("#amtClaimed").val(),1) ); 
								
								
								$("#amtDailyDtlSpan").html($("#amtDailyDtl").val());
								$("#amtDailySpan").html( chkZeroAmt($("#amtDaily").val(),1) );
								
								$("#amtTrafficDtlSpan").html($("#amtTrafficDtl").val());
								$("#amtTrafficSpan").html( chkZeroAmt($("#amtTraffic").val(),1) );
								
								$("#amtCounselDtlSpan").html($("#amtCounselDtl").val());
								$("#amtCounselSpan").html( chkZeroAmt($("#amtCounsel").val(),1) );
								
								$("#amtEtcDtlSpan").html($("#amtEtcDtl").val());
								$("#amtEtcSpan").html( chkZeroAmt($("#amtEtc").val(),1) );
								$("#amtTotalSpan").html( chkZeroAmt($("#amtTotal").val(),1) );
								
								$("#apUserNoFrm").val(collaboApprovalUserNo);
								
								if( $("#collaboApprovalPrice").val() == '' ){
									$("#collaboApproval").html( '-' )
								}else{
									$("#collaboApproval").html( chkZeroAmt($("#collaboApprovalPrice").val(),1) )	
								}
								
								if( $("#apChgNameFrm").val() == '' ){
									$("#collaboApprovalUserName").html( "<input class='buttonMini' type='button' value='결재자 정보 없음' style='background-color:#D8F6CE;pointer-events:none;font-weight:none;width:120px;'>" );
								}else{
									$("#collaboApprovalUserName").html( buttonText+" "+$("#apChgNameFrm").val() );									
								}
								
								$("#collaboApprovalUserListDiv").hide();
								
								//결재수수료 정보 삭제버튼 체크
								chkApDeleteForm();
							}
						}else{
							alert("인보이스 시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
		});
		
		/* 종결 내용의 구분값 설정 */
		if('${suimVO.suimRptType1}' == 1 || '${suimVO.suimRptType1}' == 2 ||'${suimVO.suimRptType1}' == 11 ||'${suimVO.suimRptType1}' == 12 ||'${suimVO.suimRptType1}' == 13 ||'${suimVO.suimRptType1}' == 14||'${suimVO.suimRptType1}' == 15||'${suimVO.suimRptType1}' == 16||'${suimVO.suimRptType1}' == 17||'${suimVO.suimRptType1}' == 18){
			$("#suimRptType1Close12").val('${suimVO.suimRptType1Close12}').attr("selected","selected");
		}else{
			$("#suimRptType1Close34").val('${suimVO.suimRptType1Close34}').attr("selected","selected");
		}

		/* 날짜 아이콘 초기 화면시 숨기기 */
		$(".ui-datepicker-trigger").css( "display","none");
		
		/* 컴마 사용하기 */
		//inputNumberFormat($(".endContentsSpan"));
		
		/* 공동수행자 영역 보이기 버튼 클릭 */
		$("#collaboAddAreaShowBtn").click(function(){

//			$("#collaboAddArea").css("display","inline");
//			$("#collaboAddAreaCloseBtn").css("display","inline");
//			$("#collaboAddAreaShowBtn").css("display","none");

			$("#collaboAddArea").show();
			$("#collaboAddAreaCloseBtn").show();
			$("#collaboAddAreaShowBtn").hide();


		});
		
		/* 공동수행자 영역 닫기 버튼 클릭 */
		$("#collaboAddAreaCloseBtn").click(function(){
//			$("#collaboAddArea").css("display","none");
//			$("#collaboAddAreaCloseBtn").css("display","none");
//			$("#collaboAddAreaShowBtn").css("display","inline");

			$("#collaboAddArea").hide();
			$("#collaboAddAreaCloseBtn").hide();
			$("#collaboAddAreaShowBtn").show();

		});
		
		//현대해상 결재수수료 결재자 목록 불러오기
		//$("#collaboApprovalUserList").select2();
		
		//현대해상 결재수수료 삭제 버튼 체크
		var p_ptnrId = ${suimVO.ptnr_id};
		var p_suimRptType1 = ${suimVO.suimRptType1};
		
		if( p_ptnrId == 14 && p_suimRptType1 != 3 && p_suimRptType1 != 4 ){
			chkApDeleteForm();
		}
		
	});
	
	//결재 수수료 데이터가 있는지 확인해서 삭제 버튼을 활성화한다.
	function chkApDeleteForm(){
		
		var suimRptNoVal = $("#suimRptNo").val();
		
		var url = "/getCollaboApSerialNo";
		var param = {};
		param.suim_rpt_no = suimRptNoVal; 
		
	    $.ajax({
	        type: "POST",
	        url: url,
	        data: param,
	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        timeout: 20000,
	        async: false,
	        dataType: "JSON", 
	        success: function(data){	        	
	        	if( data.result == "success" ){	        		
	        		$("#apInfoSerialNo").val(data.serialNo);
	        		$("#apInfoDeleteDiv").show();
	        	}else{
	        		$("#apInfoSerialNo").val('');
	        		$("#apInfoDeleteDiv").hide();
	        	}
	        }
	    });		
	}
	
	//결재 수수료 결재자 정보를 삭제한다.
	function doDeleteApprovalInfo(){
		
		var serialNoVal = $("#apInfoSerialNo").val();		
		var sMsg = "결재자 정보를 삭제하시겠습니까?";
		
		if( serialNoVal == '' ){
			alert("삭제할 결재자 정보가 없습니다.");
			return;
		}
		
		if( confirm(sMsg) ){			
			
			var url = "/deleteCollaboApSerialNo";
			
			var param = {};
			param.serial_no = serialNoVal; 
			
		    $.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        async: false,
		        dataType: "JSON", 
		        success: function(data){
		        	if( data.result == "success" ){	        		
		        		alert("결재수수료 정보가 삭제되었습니다.");
		        		location.reload();
		        	}else{
		        		alert("결재수수료 정보삭제에 실패하였습니다.");
		        	}
		        }
		    });
			
		}
		
	}

    /* 종결 수정처리 성공 후 처리*/
    function fnEditEndInForOKComplete(){
        var cMinwonFlag = $("input:radio[name='cMinwonFlag']:checked").val();
        var cMinwonDate = $("#c_minwonDate").val();
        var cMoralFlag = $("input:radio[name='cMoralFlag']:checked").val();
        var cMoralDate = $("#c_moralDate").val();
        var retirePendingFlag = $("input:radio[name='retire_pending_flag']:checked").val();

        $("#dis_tr_minwon_flag").show();
        $("#tr_minwon_flag").hide();
        
        var cAmtEstimatedDamage = $("#amtEstimatedDamage").val();
        var cAmtClaimed = $("#amtClaimed").val();

        $("#dis_amtEstimatedDamage").text(cAmtEstimatedDamage.money() + " 원");
        $("#p_amtEstimatedDamage").val(cAmtEstimatedDamage.money());

        $("#dis_amtClaimed").text(cAmtClaimed.money() + " 원");
        $("#p_amtClaimed").val(cAmtClaimed.money());

        
        $("#dis_cMinwonDate_tr").show();
        $("#edit_cMinwonDate_tr").hide();
        
        
        if (cMinwonFlag == 0){
            $("#dis_minwonFlag").text("없음");
            $("#dis_pMinwonDate_tr").hide();
            
            $("#dis_cMinwonFlag").text("없음"); //아래 종결내용 수정
            $("#dis_cMinwonDate_tr").hide();
            
            $("#dis_vminwonFlag").text("민원없음"); //아래 종결내용 수정
            $("#p_minwonFlag1").prop("checked", true); //아래 종결내용 수정

        }else if(cMinwonFlag == 1){
            $("#dis_minwonFlag").text("민원예상");
            $("#dis_pMinwonDate_tr").hide();
            
            $("#dis_cMinwonFlag").text("민원예상"); //아래 종결내용 수정
            $("#dis_cMinwonDate_tr").hide();
            
            $("#dis_vminwonFlag").text("민원예상"); //아래 종결내용 수정
            $("#p_minwonFlag2").prop("checked", true); //아래 종결내용 수정

        }else if(cMinwonFlag == 2){
            $("#dis_minwonFlag").text("민원발생");
            $("#dis_pMinwonDate_tr").show();
            $("#dis_pMinwonDate").text(cMinwonDate);
            $("#p_minwonDate").val(cMinwonDate);
            
            $("#dis_cMinwonFlag").text("민원발생"); //아래 종결내용 수정
            $("#dis_cMinwonDate_tr").show();
            $("#dis_cMinwonDate").text(cMinwonDate);
            $("#c_minwonDate").val(cMinwonDate);
            
            $("#p_minwonFlag3").prop("checked", true);
            
            $("#dis_vminwonFlag").text("민원발생"); //아래 종결내용 수정
        }        
        
        
        if (cMoralFlag == 0){
            $("#dis_moralFlag").text("조사중"); // check list 수정
            $("#dis_cMoralFlag").text("조사중"); //아래 종결내용 수정
            $("#p_moralFlag1").prop("checked", true); // check list 수정

        }else if(cMoralFlag == 1){
            $("#dis_moralFlag").text("해당"); // check list 수정
            $("#dis_cMoralFlag").text("해당"); //아래 종결내용 수정
            $("#p_moralFlag2").prop("checked", true); // check list 수정
            
            $("#dis_pMoralDate").text(cMoralDate);
            $("#dis_cMoralDate").text(cMoralDate);
            $("#p_moralDate").val(cMoralDate);
            $("#c_moralDate").val(cMoralDate);

        }else if(cMoralFlag == 2){
            $("#dis_moralFlag").text("해당없음"); // check list 수정
            $("#dis_cMoralFlag").text("해당없음"); //아래 종결내용 수정
            $("#p_moralFlag3").prop("checked", true); // check list 수정
            
        }
        
        if (retirePendingFlag == 0){
        	$("#retirePendingFlagSpan").text("해당없음");
        }else if (retirePendingFlag == 1){
        	$("#retirePendingFlagSpan").text("해당");
        }
        
        _initMinwonDisplay("update",cMinwonFlag,cMoralFlag);
        
    }



	/* 종결내용에 작성한 금액이 0이거나 ""일 경우 치환해서 전달 */
	function chkZeroAmt(str, flag){
		//00원등 입력 시 화면 출력에러를 회피하기 위함
		var tmpStr = parseInt(str);
		if(tmpStr == "" || tmpStr == 0){
			var returnStr = "-";	
		}else{
			if (flag == 1){
				var returnStr = str+" 원";
			}else{
				var returnStr = str;
			}
		}
		return returnStr;
	}

    /* 종결내용에 작성한 금액이 0이거나 ""일 경우 치환해서 전달 */
    function chkZeroAmt1(str, flag){
        //00원등 입력 시 화면 출력에러를 회피하기 위함
        var tmpStr = parseInt(str);
        if(tmpStr == "" || tmpStr == 0){
            var returnStr = "-";
        }else{
            if (flag == 1){
                var returnStr = str+"";
            }else{
                var returnStr = str;
            }
        }
        return returnStr;
    }
	
	/* 인보이스 인쇄 시작 */
	function invoicePrint(rptNo){
		
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		
		var sw=840; //띄울 창의 넓이
		var sh=640;  //띄울 창의 높이
	
		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		
		window.open('invoicePrintPage?suimRptNo='+rptNo,'_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
	}
	/* 인보이스 인쇄 끝 */
	
	function editeEndContents(){
		$(".endContents").show();
		$(".endContentsSpan").hide();

        $("#dis_tr_minwon_flag").hide();
        $("#tr_minwon_flag").show();
        
        $("#dis_cMinwonDate_tr").hide();
        fnMinwonDateUseAt('end');
        
		$(".endContentsSelect").prop("disabled",false);
		$("#editeEndContentsCancelBtnId").css("display","block");
		$("#editeEndContentsOkBtnId").css("display","inline");
		$("#editeEndContentsBtnId").css("display","none");
		$("#suimRptType1Close").focus();
		
		$('#invoiceDateDiv').show();
		$("#invoiceDate").css( "display","inline");
		$('#invoiceDate').datepicker({ 
	    	   showOn: 'button',
	    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	    	   buttonImageOnly: true,
	    	   buttonText: "달력", 
	    	   changeMonth: true,
	    	   changeYear: true,
	    	   showButtonPanel: false
	    });
		
		$('#c_minwonDate').datepicker({ 
	    	   showOn: 'button',
	    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	    	   buttonImageOnly: true,
	    	   buttonText: "달력", 
	    	   changeMonth: true,
	    	   changeYear: true,
	    	   showButtonPanel: false
	    });
		
		$('#c_moralDate').datepicker({ 
	    	   showOn: 'button',
	    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	    	   buttonImageOnly: true,
	    	   buttonText: "달력", 
	    	   changeMonth: true,
	    	   changeYear: true,
	    	   showButtonPanel: false
	    });
		
		//현대해상 (ptnr_id = 14) 인 경우 결재수수료 대상자 항목 표시
		var p_ptnrId = ${suimVO.ptnr_id};
		var p_suimRptType1 = ${suimVO.suimRptType1};
		
		
		if( p_ptnrId == 14 && p_suimRptType1 != 3 && p_suimRptType1 != 4 ){
			$("#apInfoDeleteDiv").hide();
			$("#collaboApprovalUserListDiv").show();
			$("#collaboApprovalUserList").select2();
			if( $("#apUserNoFrm").val() > 0 ){
				$("#collaboApprovalUserList").select2().val($("#apUserNoFrm").val()).trigger("change");	
			}
		}
		
	}
	
	function editeCancelEndContents(){
		$(".endContents").hide();
		$(".endContentsSpan").show();

        $("#dis_tr_minwon_flag").show();
        $("#tr_minwon_flag").hide();

        $("#dis_cMinwonDate_tr").show();
        $("#edit_cMinwonDate_tr").hide();
        
		$(".endContentsSelect").prop("disabled",true);
		$("#editeEndContentsCancelBtnId").hide();
		$("#editeEndContentsOkBtnId").hide();
		$("#editeEndContentsBtnId").show();
		
		$('#invoiceDateDiv').hide();
		
		$("#collaboApprovalUserListDiv").hide();
		
		//결재수수료 정보 삭제버튼 체크
		chkApDeleteForm();
		
	}
	
	//콤마찍기
	function comma(str) {
		if(str == '0'){
			return "-";
		}else{
		    str = String(str);
		    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');			
		}
	}
	
	function commaTotal(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');			
	}
	
	//콤마풀기
	function uncomma(str) {
		if(str == '' || str == '-'){
			return "0";
		}else{
		    str = String(str);
		    return str.replace(/[^\d]+/g, '');		
		}
	}
	
	/* 인보이스 금액 합치기 */
	function plusInvVal(){
		
		var p_ptnrId = ${suimVO.ptnr_id};
		var p_suimRptType1 = ${suimVO.suimRptType1};		
		
		if( p_ptnrId == 14 && p_suimRptType1 != 3 && p_suimRptType1 != 4 ){
			//결재수수료 항목 추가
			priceTotal =
				parseInt(uncomma($("#amtBasic").val()))+
				parseInt(uncomma($("#collaboApprovalPrice").val()))+
				parseInt(uncomma($("#amtDaily").val()))+
				parseInt(uncomma($("#amtTraffic").val()))+
				parseInt(uncomma($("#amtCounsel").val()))+
				parseInt(uncomma($("#amtEtc").val()));
		}else{
			priceTotal =
				parseInt(uncomma($("#amtBasic").val()))+
				parseInt(uncomma($("#amtDaily").val()))+
				parseInt(uncomma($("#amtTraffic").val()))+
				parseInt(uncomma($("#amtCounsel").val()))+
				parseInt(uncomma($("#amtEtc").val()));
		}		
		
		$("#amtTotal").val(commaTotal(priceTotal)); 		
	}
	
	
	function addCollaboOk(){
		
		if($("#mbrNo1").val() == ''){
			alert('수행자를 입력하세요.');
			return;
		}
		
		if($("#collaboPp").val() == ''){
			alert('수행율을 입력하세요.');
			$("#collaboPp").focus();
			return;
		}
		var gubun1 ="";
		var gubun2 ="";
		
		if ( "${suimVO.suim_rpt_type1}" != 3 && "${suimVO.suim_rpt_type1}" != 4){
			gubun1 ="공동수행률";
			gubun2 ="%";
		}else{
			gubun1 ="공동수행금액";
			gubun2 ="원";
		}
		
		$.post("./addCollaboOk",
				{
					 suimRptNo		: $("#suimRptNo").val()
					,userId			: $("#mbrNo0").val()
					,userName		: $("#mbrNm0").val()
					,shareTeamId	: $("#share_team_id0").val()
					,collaboPp		: $("#collaboPp").val() 
					
				},
				function(data,status){
					if(status == "success"){
						if(data == 0){
							alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
						}else{
							 $.each(data, function(index, entry) {
								$("#collaboArea").append(
								
									"<tr id='collaboTr_"+entry.serialNo+"' align='center'>"
									+	"<th>ㆍ공동수행자</th>"
									+	"<td >"
									+ 		entry.userName
									+	"</td>"
									+	"<th>ㆍ"+gubun1+"</th>"
									+	"<td style='font-family:굴림;letter-spacing:0;'>"
									+		entry.collaboPp + gubun2
									+		"<img src='./resources/ls_img/btn_del_s.gif' onclick=\"delCollabo('"+entry.serialNo+"');\" style='cursor:pointer; float:right; margin-right:20px;'/>"
									+	"</td>"
									+"</tr>"
								);
							 });
							 
							$("#collaboAddArea").css("display","none");
							$("#collaboAddAreaCloseBtn").css("display","none");
							$("#collaboAddAreaShowBtn").css("display","inline");
						}
					}else{
						alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
					}
				},"json"
		);//post
	}

	/* 공동수행자 1행 삭제 시작 */
	function delCollabo(serialNo){

			if(confirm("공동 수행자를 삭제하시겠습니까?")){
				
				$.post("./delCollaboOk",
						{	
							serialNo : serialNo  //
							
						},
						function(data,status){
							if(status == "success"){
								if(data != 0){
									$("#collaboTr_"+serialNo).html("");									
								}else{
									alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");	
								}
							}else{
								alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");
							}
						}
				);
				
			}
	}
	/* 공동수행자 1행 삭제 끝 */
	
	
	function fnGetWorkloadEa(){
		
	    var workloadType = $("input:radio[name='workload_type']:checked").prop("id").substring(13);
	    var workloadTypeVal = $("input:radio[name='workload_type']:checked").val();
	    var retirePendingFlag = $("input:radio[name='retire_pending_flag']:checked").val();
		var workloadEa = 0;
		
		var param = {};
		param.col_cd1 = workloadType.split("_")[0];
		param.col_cd2 =  workloadType.split("_")[1];
		
		param.retirePendingFlag = retirePendingFlag;
		param.workloadTypeVal = workloadTypeVal;
		
	    var url = "/getWorkloadEaGubun";
	    $.ajax({
	        type: "POST",
	        url: url,
	        data: param,
	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        timeout: 20000,
	        dataType: "JSON", 
	        success: function(data){
	        	var workloadEa = data.workloadEa;
	        	
	        	/*
	    		if (retirePendingFlag == 1 && workloadTypeVal != 99){
	    			//workloadEa = workloadEa * 1.3;
	    			workloadEa = workloadEa * 1.5;
	    			workloadEa = workloadEa.toFixed(3); //반올림 하여 소숫점 셋째 자리까지 표기
	    		}
	        	*/
	    		
	    		$("#workload_ea").val( workloadEa );
	    		
	    		workloadValid = true;
	        },
            beforeSend: function(){
            	$('#rpt_end_tbl').spin();
	        },
	        complete: function(){
	            $('#rpt_end_tbl').spin(false);
	        }
	        
	    });
				
		
		/*
	    var workloadType = $("input:radio[name='workload_type']:checked").prop("id").substring(13);
	    var workloadTypeVal = $("input:radio[name='workload_type']:checked").val();
	    var retirePendingFlag = $("input:radio[name='retire_pending_flag']:checked").val();
		var workloadEa = 0;
		switch (workloadType){
			case "2_5" : workloadEa = 1; break; 		//재물(화재 등)
			case "2_10" : workloadEa = 0.5; break;		//메리츠 One_Stop(재물)
			//case "2_15" : workloadEa = 1; break;		//정책(화재 등)
			case "2_20" : workloadEa = 1; break;		//정책(가축재해_일반)
			case "2_25" : workloadEa = 0.22; break;		//정책(가축재해_소)
			case "2_30" : workloadEa = 0.275; break;	//농기계(간편심사)
			case "2_35" : workloadEa = 0.183; break;	//농기계(전수조사)
			case "2_40" : workloadEa = 0.917; break;	//수협(양식보험)
			case "2_45" : workloadEa = 0.647; break;	//재물(풍수재)
			case "2_50" : workloadEa = 0.647; break;	//재물(홀인원)
			case "2_55" : workloadEa = 0.647; break;	//재물(골프용품)
			case "2_60" : workloadEa = 0; break;		//서면심사(신차)
			case "2_65" : workloadEa = 0; break;		//서면심사(맥도날드/재물)
			case "2_99" : workloadEa = 0.3; break;		//퇴사자 종결 후 추가 청구(재물)
			
			case "5_5" : workloadEa = 1; break;			//농작물(착과수, 벼 등)
			case "5_10" : workloadEa = 1; break;		//원예시설
			case "5_99" : workloadEa = 0.3; break;		//퇴사자 종결 후 추가 청구(농작물)
			
			case "11_5" : workloadEa = 1; break;		//대인(일반)
			case "11_10" : workloadEa = 0.1; break;		//대인(이랜드/구내치료비)
			case "11_15" : workloadEa = 0.5; break;		//메리츠 One_Stop(대인)
			case "11_20" : workloadEa = 1; break;		//정책(농기계_일반/대인)
			case "11_25" : workloadEa = 0; break;		//서면심사(w.c/대인)
			case "11_30" : workloadEa = 0; break;		//서면심사(맥도날드/대인)
			case "11_99" : workloadEa = 0.3; break;		//퇴사자 종결 후 추가 청구(대인)
			
			case "12_5" : workloadEa = 1; break;		//대물(일반)
			case "12_10" : workloadEa = 0.5; break;		//메리츠 One_Stop(대물)
			case "12_15" : workloadEa = 1; break;		//정책(농기계_일반/대물,자차)
			case "12_20" : workloadEa = 0; break;		//서면심사(맥도날드/대물)
			case "12_99" : workloadEa = 0.3; break;		//퇴사자 종결 후 추가 청구(대물)
			
			case "13_5" : workloadEa = 1; break;		//신종(일반)
			case "13_99" : workloadEa = 0.3; break;		//퇴사자 종결 후 추가 청구(신종)
			
			case "14_5" : workloadEa = 1; break;		//서면심사(메리츠)
			case "14_10" : workloadEa = 0; break;		//서면심사(흥국)
			case "14_15" : workloadEa = 0; break;		//서면심사(롯데)
			case "14_99" : workloadEa = 0.3; break;	//퇴사자 종결 후 추가 청구(서면심사)
		}
		
		
		
		if (retirePendingFlag == 1 && workloadTypeVal != 99){
			workloadEa = workloadEa * 1.3;
			workloadEa = workloadEa.toFixed(3); //반올림 하여 소숫점 셋째 자리까지 표기
		}
		
		$("#workload_ea").val( workloadEa );
		
		workloadValid = true;
		*/
		
	}
	

    /* 종결 내용 자동계산 */
    function fnCloseCalc(){
/*
        var c_amtEstimatedDamage = uncomma($("#amtEstimatedDamage").val()); //평가손해액
        var c_amtSettlement = uncomma($("#amtSettlement").val());           //합의금액
        var c_amtSelfPay = uncomma($("#amtSelfPay").val());                 //자기부담금

        var c_amtInsuPayment = c_amtSettlement - c_amtSelfPay;              //지급보험금
        var c_amtReduction = c_amtEstimatedDamage - c_amtSettlement;        //절감액

        $("#amtInsuPayment").val((c_amtInsuPayment + "").money());
        $("#amtReduction").val((c_amtReduction + "").money());
*/

    }
	
</script>


	<input type="hidden" id="workloadUseAt" value="${suimVO.workloadUseAt}" />
	<!-- 종결내용 -->
	<table id="rpt_end_tbl" align="center" style="margin-top:10px;">
		<colgroup>
			<col width="20%">
			<col width="30%">
			<col width="20%">
			<col width="30%">
		</colgroup>
		<thead>
            <tr>
                <td colspan="4" height="30" style="background-color: #e7f5ff"><span style="font-size: 20px;"><b>4. 종결 및 인보이스</b></span></td>
            </tr>

			<tr>
				<td colspan="4">
					<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;" /> 4-1. 종결 내용</b>
					<c:if test="${suimVO.suimRptState eq '0' or suimVO.suimRptState eq '11' }">
						<c:if test="${suimVO.editYN > 0}">
							<img style = "cursor:pointer; float:right; margin-right:5px;" title="종결내용 및 인보이스 수정" id = "editeEndContentsBtnId" src="./resources/ls_img/btn_edite.gif" onclick="editeEndContents();" />
							<img src="./resources/ls_img/btn_write_cancel.gif" title="종결내용 수정 취소" id = "editeEndContentsCancelBtnId" style="float:right; display:none; cursor:pointer; margin-right:10px;" onclick="editeCancelEndContents();"/>
							<img src="./resources/ls_img/icon_write.gif" title="종결내용 저장" id = "editeEndContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:10px; onclick=""/>					
						</c:if>
					</c:if>
					
					<c:if test="${endModFlag > 0 && suimVO.suimRptState eq '2'}">
						<img style = "cursor:pointer; float:right; margin-right:5px;" title="종결내용 및 인보이스 수정" id = "editeEndContentsBtnId" src="./resources/ne_img/btn/btn_end_mod.jpg" onclick="editeEndContents();" />
						<img src="./resources/ls_img/btn_write_cancel.gif" title="종결내용 수정 취소" id = "editeEndContentsCancelBtnId" style="float:right; display:none; cursor:pointer; margin-right:10px;" onclick="editeCancelEndContents();"/>
							<img src="./resources/ls_img/icon_write.gif" title="종결내용 저장" id = "editeEndContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:10px;"/>					
					</c:if>						
				</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td bgcolor="#E7ECF1"><b>ㆍ종결구분</b></td>
				<td colspan="3">
				<input type="hidden" id= "suimRptType1" value = "${suimVO.suimRptType1}"/>
				<c:choose>
					<c:when test="${suimVO.suimRptType1 eq '1' or suimVO.suimRptType1 eq '2'
					or suimVO.suimRptType1 eq '11' or suimVO.suimRptType1 eq '12' or suimVO.suimRptType1 eq '13' or suimVO.suimRptType1 eq '14'}">
						<select id="suimRptType1Close12" class="endContentsSelect" disabled="disabled" onfocus="this.select();">
							<!-- 보고서형식이 배상 or 재물일 경우 1: 부책 2: 면책 3: 청구포기 4: 구내치료비 5: 모럴 6: 소송 -->
							<option value="0">없음</option>
							<option value="1">부책</option>
							<option value="2">면책</option>
							<option value="3">청구포기</option>
							<option value="4">구내치료비</option>
							<option value="5">모럴</option>
							<option value="6">소송</option>
						</select>
						<select id="suimRptType1Close34"  style="display: none;">
							<option value="0"></option>
						</select>
					</c:when>
					<c:when test="${suimVO.suimRptType1 eq '3' or suimVO.suimRptType1 eq '4'}">
						<select id="suimRptType1Close34" class="endContentsSelect" disabled="disabled" >
							<!-- 보고서형식이 상해 or 질병일 경우 1: 유지/지급 2: 유지/삭감 3: 유지/면책 4: 해지/지급 5: 해지/삭감 6: 해지/면책 7: 부담보/지급 8: 부담보/삭감 9: 부담보/면책 -->
							<option value="0">없음</option>
							<option value="1">유지/지급</option>
							<option value="2">유지/삭감</option>
							<option value="3">유지/면책</option>
							<option value="4">해지/지급</option>
							<option value="5">해지/삭감</option>
							<option value="6">해지/면책</option>
							<option value="7">부담보/지급</option>
							<option value="8">부담보/삭감</option>
							<option value="9">부담보/면책</option>
						</select>
						<select id="suimRptType1Close12"  style="display: none;">
							<option value="0"></option>
						</select>
					</c:when>
				</c:choose>
				<%-- suimRptEa 입력창 삭제로인해 기본값 0을 넣는다. --%>
				<input type="hidden" id="suimRptEa" name="suimRptEa" value="0"/>
				</td>

				<%-- <td bgcolor="#E7ECF1"><b>ㆍ종결(평가) 건수</b></td>
				<td style="font-family:'굴림';letter-spacing:0;">
					<span class="endContentsSpan" id="suimRptEaSpan">
						${suimVO.suimRptEa}
					</span>
					<input type="text" id="suimRptEa" style="display:none; width: 80%;IME-MODE: disabled;" class="endContents" onkeyup="decimalPointOnly(this);" size="22" value="${suimVO.suimRptEa }"/>
				</td> --%>				
			</tr>
			
			
			<c:if test="${suimVO.workloadUseAt == 1 and ( suimVO.suimRptType1 != 3 and suimVO.suimRptType1 != 4)}" >
				<tr class="endContentsSpan">
					<td bgcolor="#E7ECF1" style="letter-spacing:-1px;"><b>ㆍ기준업무량 상세구분</b></td>
					<td colspan="3">
						<span id="workloadTypeSpan">
							${suimVO.workloadTypeVal}
						</span>
					</td>
				</tr>			
				<tr class="endContents" style="display: none;">
					<td bgcolor="#E7ECF1" style="letter-spacing:-1px;"><b>ㆍ기준업무량 상세구분</b></td>
					<td colspan="3">
						<c:set var="curr_cnt" value="1" />
						<c:forEach items="${workloadTypeList}" var="item" varStatus="status">
							<c:if test="${suimVO.suimRptType1 == item.col_cd1}">
								<input type="radio" name="workload_type" id="workload_type${item.col_cd1}_${item.col_cd2}" value="${item.col_cd2}" textValue="${item.col_val}" onclick="fnGetWorkloadEa();"/> 
								<label for='workload_type${item.col_cd1}_${item.col_cd2}'>${item.col_val}</label>
								<c:choose>
									<c:when test="${item.col_cd1 == workloadTypeList[status.count].col_cd1 and curr_cnt != 3}">
										<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>	
									</c:when>
									<c:when test="${item.col_cd1 == workloadTypeList[status.count].col_cd1 and curr_cnt == 3}">
										<br/>
										<c:set var="curr_cnt" value="0"/>
									</c:when>
								</c:choose>
								<c:set var="curr_cnt" value="${curr_cnt+1}"/>
								<c:set var="bef_workload_type" value="${item.col_cd1}"/>
							</c:if>	
						</c:forEach>				
					</td>
				</tr>
				
				<tr class="endContentsSpan">
					<td bgcolor="#E7ECF1" style="letter-spacing:-1px;"><b>ㆍ기준업무량 종결건수</b></td>
					<td>
						<span id="workloadEaSpan">
							${suimVO.workloadEa}
						</span>
					</td>
					<td bgcolor="#E7ECF1"  style="letter-spacing: -2px !important;"><b>ㆍ퇴사자(휴직자)<br/>&nbsp;&nbsp;&nbsp;미결 내첩여부</b></td>
					<td>
		                <span id="retirePendingFlagSpan">
		                    <c:if test="${suimVO.retirePendingFlag == 0}">해당 없음</c:if>
		                    <c:if test="${suimVO.retirePendingFlag == 1}">해당</c:if>
		                </span>						
					</td>
				</tr>	
				
				<tr class="endContents" style="display: none;">
					<td bgcolor="#E7ECF1" style="letter-spacing:-1px;"><b>ㆍ기준업무량 종결건수</b></td>
					<td>
						<input type="text" id="workload_ea" style="width: 30%;IME-MODE: disabled;" onkeyup="decimalPointOnly(this);" disabled="disabled" size="22" value="${suimVO.workloadEa}"/>
					</td>
					<td bgcolor="#E7ECF1"  style="letter-spacing: -2px !important;"><b>ㆍ퇴사자(휴직자)<br/>&nbsp;&nbsp;&nbsp;미결 내첩여부</b></td>
					<td>
	                    <input type="radio" id="retire_pending_flag0" name="retire_pending_flag" value="0" onclick="fnGetWorkloadEa();" <c:if test="${suimVO.retirePendingFlag == 0}">checked</c:if>><label for="retire_pending_flag0"> 해당없음 </label>&nbsp;&nbsp;
						<input type="radio" id="retire_pending_flag1" name="retire_pending_flag" value="1" onclick="fnGetWorkloadEa();" <c:if test="${suimVO.retirePendingFlag == 1}">checked</c:if>><label for="retire_pending_flag1"> 해당</label>
					</td>
				</tr>
			</c:if>
			
			<tr>
				<td bgcolor="#E7ECF1"><b>ㆍ청구금액</b></td>
				<td style="font-family:'굴림';letter-spacing:0;">
					<span class="endContentsSpan" id="amtClaimedSpan" >
						<c:choose>
							<c:when test="${suimVO.amtClaimed ne null and suimVO.amtClaimed ne '' and suimVO.amtClaimed ne '0'}">
								<fmt:formatNumber value="${suimVO.amtClaimed}" pattern="###,###,##0.##"/> 원
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>
						</c:choose>
					</span>					
					<input type="text" id="amtClaimed" name="amtClaimed" class="endContents money"
						<c:if test="${suimVO.amtClaimed ne null and suimVO.amtClaimed ne '' and suimVO.amtClaimed ne '0'}"> value="${suimVO.amtClaimed}" </c:if> 
						style="display: none; width: 80%; text-align: right; padding-right: 1px;" maxlength="15" />
				</td>
				<td bgcolor="#E7ECF1"><b>ㆍ평가(추정)손해액</b></td>
				<td style="font-family:'굴림';letter-spacing:0;">				
					<c:choose>
						<c:when test="${suimVO.suimRptType1 eq '3' or suimVO.suimRptType1 eq '4'}">
							<c:choose>								
								<c:when test="${suimVO.amtEstimatedDamage ne null and suimVO.amtEstimatedDamage ne '0' and mbrVo_Session.team_id_main ne 33}" >
									<fmt:formatNumber value="${suimVO.amtEstimatedDamage}" pattern="###,###,##0.##"/> 원
									<input type="hidden" id="amtEstimatedDamage" style="display:none;IME-MODE: disabled;" class="endContents"  size="22"
									<c:if test="${suimVO.amtEstimatedDamage ne '' and suimVO.amtEstimatedDamage ne '0'}"> 
									value="${suimVO.amtEstimatedDamage}"
									</c:if> />
								</c:when>	
								
								<c:otherwise>
									<span class="endContentsSpan" id="amtEstimatedDamageSpan">
										<c:choose>
											<c:when test="${suimVO.amtEstimatedDamage ne null and suimVO.amtEstimatedDamage ne '' and suimVO.amtEstimatedDamage ne '0'}">
												<fmt:formatNumber value="${suimVO.amtEstimatedDamage}" pattern="###,###,##0.##"/> 원
											</c:when>
											<c:otherwise>
												-
											</c:otherwise>
										</c:choose>
									</span>									
                                    <input type="text" id="amtEstimatedDamage" name="amtEstimatedDamage" class="endContents money" onkeyup="fnCloseCalc();"
                                    <c:if test="${suimVO.amtEstimatedDamage ne null and suimVO.amtEstimatedDamage ne '0'}"> value="${suimVO.amtEstimatedDamage}" </c:if> style="display: none; width: 80%;text-align: right; padding-right:1px;" maxlength="15"/>									
								</c:otherwise>
							</c:choose>
						</c:when>
						
						<c:otherwise>
							<span class="endContentsSpan" id="amtEstimatedDamageSpan">
								<c:choose>
									<c:when test="${suimVO.amtEstimatedDamage ne null and suimVO.amtEstimatedDamage ne '' and suimVO.amtEstimatedDamage ne '0'}">
										<fmt:formatNumber value="${suimVO.amtEstimatedDamage}" pattern="###,###,##0.##"/> 원
									</c:when>
									<c:otherwise>
										-
									</c:otherwise>
								</c:choose>
							</span>
                            <input type="text" id="amtEstimatedDamage" name="amtEstimatedDamage" class="endContents money" onkeyup="fnCloseCalc();"
                            <c:if test="${suimVO.amtEstimatedDamage ne null and suimVO.amtEstimatedDamage ne '0'}">
                            value="${suimVO.amtEstimatedDamage}"
                            </c:if>
                            style="display: none; width: 80%;text-align: right; padding-right:1px;" maxlength="15"/>
							</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr  >
				<td bgcolor="#E7ECF1"><b>ㆍ합의금액</b></td>
				<td style="font-family:'굴림';letter-spacing:0;">
					<span class="endContentsSpan" id="amtSettlementSpan">
						<c:choose>
							<c:when test="${suimVO.amtSettlement ne null and suimVO.amtSettlement ne '' and suimVO.amtSettlement ne '0'}">
								<fmt:formatNumber value="${suimVO.amtSettlement}" pattern="###,###,##0.##"/> 원
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>
						</c:choose>
					</span>
                    <input type="text" id="amtSettlement" name="amtSettlement" class="endContents money" onkeyup="fnCloseCalc();"
                    <c:if test="${suimVO.amtSettlement ne null and suimVO.amtSettlement ne '0'}">
                    value="${suimVO.amtSettlement}"
                    </c:if>
                    style="display: none; width: 80%;text-align: right; padding-right:1px;" maxlength="15"/>
				</td>
				
				<td bgcolor="#E7ECF1"><b>ㆍ자기부담금</b></td>
				<td style="font-family:'굴림';letter-spacing:0;">
					<input type="hidden" id="h_amtSelfPayUnit" value="${suimVO.amtSelfPayUnit}"/>
					<span class="endContentsSpan" id="amtSelfPaySpan">	
						<c:choose>
							<c:when test="${suimVO.amtSelfPay ne null and suimVO.amtSelfPay ne '' and suimVO.amtSelfPay ne '0'}">
								${suimVO.amtSelfPayUnit}&nbsp;<fmt:formatNumber value="${suimVO.amtSelfPay}" pattern="###,###,##0.##"/>
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>
						</c:choose>
					</span>					
                    <input type="text" id="amtSelfPay" name="amtSelfPay" class="endContents money" onkeyup="fnCloseCalc();"
                    <c:if test="${suimVO.amtSelfPay ne null and suimVO.amtSelfPay ne '' and suimVO.amtSelfPay ne '0'}">
                    value="${suimVO.amtSelfPay}"
                    </c:if>
                    style="display: none; width: 80%;text-align: right; padding-right:1px;" maxlength="15"/>
				</td>
			</tr>
			<tr>
				<td bgcolor="#E7ECF1"><b>ㆍ지급보험금</b></td>
				<td style="font-family:'굴림';letter-spacing:0;">
					<span class="endContentsSpan" id="amtInsuPaymentSpan">
						<c:choose>
							<c:when test="${suimVO.amtInsuPayment ne null and suimVO.amtInsuPayment ne '' and suimVO.amtInsuPayment ne '0'}">
								<fmt:formatNumber value="${suimVO.amtInsuPayment}" pattern="###,###,##0.##"/> 원
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>
						</c:choose>
					</span>					
                    <input type="text" id="amtInsuPayment" name="amtInsuPayment" class="endContents money"
                    <c:if test="${suimVO.amtInsuPayment ne null and suimVO.amtInsuPayment ne '' and suimVO.amtInsuPayment ne '0'}"> 
                    value="${suimVO.amtInsuPayment}"
                    </c:if>
                    style="display: none; width: 80%;text-align: right; padding-right:1px;" maxlength="15"/>
				</td>
				
				<td bgcolor="#E7ECF1"><b>ㆍ절감액</b></td>
				<td style="font-family:'굴림';letter-spacing:0;">
					<span class="endContentsSpan" id="amtReductionSpan">
						<c:choose>
							<c:when test="${suimVO.amtReduction ne null and suimVO.amtReduction ne '' and suimVO.amtReduction ne '0'}">
								<fmt:formatNumber value="${suimVO.amtReduction}" pattern="###,###,##0.##"/> 원
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>
						</c:choose>					
					</span>					
                    <input type="text" id="amtReduction" name="amtReduction" class="endContents money"
                    <c:if test="${suimVO.amtReduction ne null and suimVO.amtReduction ne '' and suimVO.amtReduction ne '0'}"> 
                    value="${suimVO.amtReduction}"
                    </c:if>
                    style="display: none; width: 80%;text-align: right; padding-right:1px;" maxlength="15"/>
				</td>
			</tr>
			
			
			<!-- 민원 발생(예상)일 추가 180119 -->
            <tr id="dis_tr_minwon_flag">
                <td bgcolor="#E7ECF1"><b>ㆍ민원</b></td>
                <td>
	                <span id="dis_cMinwonFlag">
	                    <c:if test="${suimVO.minwonFlag == 0}">없음</c:if>
	                    <c:if test="${suimVO.minwonFlag == 1}">민원예상</c:if>
	                    <c:if test="${suimVO.minwonFlag == 2}">민원발생</c:if>
	                </span>
                </td>
				<td bgcolor="#E7ECF1"><b>ㆍ보험사기</b></td>
                <td>
	                <span id="dis_cMoralFlag">
	                    <c:if test="${suimVO.moralFlag == 0}">조사중</c:if>
	                    <c:if test="${suimVO.moralFlag == 1}">해당</c:if>
	                    <c:if test="${suimVO.moralFlag == 2}">해당없음</c:if>
	                </span>
                </td>
            </tr>
            
            <tr id="tr_minwon_flag" style="display: none;">
                <td bgcolor="#E7ECF1"><b>ㆍ민원</b></td>
                <td>
                    <input type="radio" id="c_minwonFlag1" name="cMinwonFlag" value="0" onclick="fnMinwonDateUseAt('end');" <c:if test="${suimVO.minwonFlag == 0}">checked</c:if>><label for="c_minwonFlag1"> 없음 </label>&nbsp;&nbsp;
                    <input type="radio" id="c_minwonFlag2" name="cMinwonFlag" value="1" onclick="fnMinwonDateUseAt('end');" <c:if test="${suimVO.minwonFlag == 1}">checked</c:if>><label for="c_minwonFlag2"> 민원예상 </label>&nbsp;&nbsp;
                    <input type="radio" id="c_minwonFlag3" name="cMinwonFlag" value="2" onclick="fnMinwonDateUseAt('end');" <c:if test="${suimVO.minwonFlag == 2}">checked</c:if>><label for="c_minwonFlag3"> 민원발생</label>
                </td>
                <td bgcolor="#E7ECF1"><b>ㆍ보험사기</b></td>
                <td colspan="3">
                    <input type="radio" id="c_moralFlag3" name="cMoralFlag" value="2" onclick="fnMinwonDateUseAt('end');" <c:if test="${suimVO.moralFlag == 2}">checked</c:if>><label for="c_moralFlag3"> 해당없음</label>&nbsp;&nbsp;
                    <input type="radio" id="c_moralFlag1" name="cMoralFlag" value="0" onclick="fnMinwonDateUseAt('end');" <c:if test="${suimVO.moralFlag == 0}">checked</c:if>><label for="c_moralFlag1"> 조사중 </label>&nbsp;&nbsp;
                    <input type="radio" id="c_moralFlag2" name="cMoralFlag" value="1" onclick="fnMinwonDateUseAt('end');" <c:if test="${suimVO.moralFlag == 1}">checked</c:if>><label for="c_moralFlag2"> 해당 </label>
                </td>
            </tr>
            <tr id="dis_cMinwonDate_tr"  <c:if test="${suimVO.minwonFlag != 2}">style="display:none;"</c:if> >
                <td bgcolor="#E7ECF1"><b>ㆍ민원 발생일</b></td>
                <td colspan="3">
	                <span id="dis_cMinwonDate">
	                	<c:if test="${suimVO.minwonDate != 0}">
                			${suimVO.minwonDateVal}
	                	</c:if>
	                </span>
                </td>
                <td bgcolor="#E7ECF1" style="display: none;"><b>ㆍ공문 수신일</b></td>
                <td style="display:none;">
	                <span id="dis_cMoralDate">
	                	<c:if test="${suimVO.moralDate != 0}">
                			${suimVO.moralDateVal}
	                	</c:if>
	                </span>
                </td>                
                
            </tr>
            
            <tr id="edit_cMinwonDate_tr" style="display:none">
           		<td bgcolor="#E7ECF1"><b>ㆍ민원 발생일</b></td>
                <td colspan="3">
             		<input type="text" id="c_minwonDate" <c:if test="${suimVO.minwonDate != 0}"> value="${suimVO.minwonDateVal}" </c:if> />
                </td> 
                
                <td bgcolor="#E7ECF1" style="display: none;"><b>ㆍ공문 수신일</b></td>
                <td colspan="1" style="display: none;">
             		<input type="text" id="c_moralDate" <c:if test="${suimVO.moralDate != 0}"> value="${suimVO.moralDateVal}" </c:if> />
                </td> 
            </tr>            
	</table>
	
	<table align="center" style="margin-top: 5px;" >
		<colgroup>
			<col width="25%">
			<col width="45%">
			<col width="30%">
		</colgroup>
		<thead>
			<tr>
				<td colspan="4">
					<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle; " /> 4-2. 인보이스</b>
					<img src="./resources/ls_img/btn_print_s.gif" title="인쇄" style="cursor:pointer;" onclick="invoicePrint('${suimRptNoFromServer}');"/>
					<input type="hidden" id="rptInvNo" value="${suimInvVO.rptInvNo}"/>
				</td>
			</tr>
			<tr>
				<th>항목</th>
				<th>내역</th>
				<th>금액(원)</th>
			</tr>
		</thead>
		<tbody align="left" id = "">
			<tr>
				<td bgcolor="#E7ECF1"><b>ㆍ제출일</b></td>
				<td>
					<c:choose>
						<c:when test="${suimInvVO.invoiceDate ne null and suimInvVO.invoiceDate ne ''}">
							<span id="invoiceDateSpan" class="endContentsSpan" style="font-family:'굴림'">${suimInvVO.invoiceDate}</span>
							<div id="invoiceDateDiv">
								<input type="text" style="display:none;" id="invoiceDate" size="20" class="endContents" value = "${suimInvVO.invoiceDate }"/>
							</div>
						</c:when>
						<c:otherwise>
							<!-- 오늘날짜 강제세팅 -->
							<jsp:useBean id="toDay" class="java.util.Date"/>
							<fmt:formatDate value="${toDay}" pattern="yyyy-MM-dd" var="toDay" />
							
							<span id="invoiceDateSpan" class="endContentsSpan" style="font-family:'굴림'"></span>
							<div id="invoiceDateDiv">
								<input type="text" style="display:none;" id="invoiceDate" size="20" class="endContents" value = "${toDay}"/>
							</div>
						</c:otherwise>
					</c:choose>
				</td>
				<td></td>
			</tr>
			<tr> 
				<td bgcolor="#E7ECF1"><b>ㆍ기본보수</b></td>
				<td>
					<span id="amtBasicDtlSpan" style="font-family:'굴림';" class="endContentsSpan">
						${suimInvVO.amtBasicText}
					</span>
					<input type="text" style="display:none; ime-mode:active;" id="amtBasicDtl" class="endContents" value ="${suimInvVO.amtBasicText}"/>
				</td>
				<td>
					<span id="amtBasicSpan" style="font-family:'굴림'; letter-spacing:0" class="endContentsSpan">
						<c:choose>
							<c:when test="${suimInvVO.amtBasic ne null and suimInvVO.amtBasic ne '' and suimInvVO.amtBasic ne '0'}">
								<fmt:formatNumber value="${suimInvVO.amtBasic}" pattern="###,###,##0.##"/> 원
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>
						</c:choose>
					</span>
					<input  type="text" name="amtBasic" id="amtBasic" class="endContents"
							value="<fmt:formatNumber value="${suimInvVO.amtBasic}" pattern="###,###,##0.##"/>"
							ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);plusInvVal();"
							style="display:none;IME-MODE: disabled;" /> 
							
<%-- 					<input type="text" style="display:none;" id = "amtBasic" class="endContents" onkeyup="plusInvVal();" value="${suimInvVO.amtBasic}"/> --%>
				</td>
			</tr>
			<!-- 보험사가 현대해상인 경우 결재 수수료항목 추가 시작 by top3009 (20231228)-->
			<c:if test="${suimVO.ptnr_id eq 14 and suimVO.suimRptType1 != 3 and suimVO.suimRptType1 != 4}">
			<input type="hidden" id="apUserNoFrm" name="apUserNoFrm" value="${collaboApprovalVO.approvalUserNo}"/>
			<input type="hidden" id="apChgNameFrm" name="apChgNameFrm" />	
			<input type="hidden" id="apInfoSerialNo" name="apInfoSerialNo"/>		
			<tr> 
				<td bgcolor="#E7ECF1"><b>ㆍ결재수수료</b></td>
				<td>
					<span id="collaboApprovalUserName" style="font-family:'굴림'; letter-spacing:0" class="endContentsSpan">					
						<c:choose>
							<c:when test="${not empty collaboApprovalVO.approvalUserName}">								
								<input class="buttonMini" type="button" value="결재자" style="background-color:#D8F6CE;pointer-events:none;font-weight:none;width:60px;"> 
								${collaboApprovalVO.approvalTeamName} / ${collaboApprovalVO.approvalUserName}															
							</c:when>
							<c:otherwise>								
								<input class="buttonMini" type="button" value="결재자 정보 없음" style="background-color:#D8F6CE;pointer-events:none;font-weight:none;width:120px;">
							</c:otherwise>
						</c:choose>						
					</span>							
					<div id="collaboApprovalUserListDiv" style="display:none;">						
						<input class="buttonMini" type="button" value="결재자" style="background-color:#D8F6CE;pointer-events:none;font-weight:none;width:60px;">					
						<select name="collaboApprovalUserList" id="collaboApprovalUserList" class="endContents" style="display:none;width:200px;">
							<option value="0">- 선택 -</option>
							<c:forEach items="${approvalUserList}" var="member" varStatus="status">
								<option value="${member.userNo}">${member.teamName} / ${member.userName}</option>
							</c:forEach>
						</select>						
					</div> 										
				</td>
				<td>
					<div style="float:left">
					<span id="collaboApproval" style="font-family:'굴림'; letter-spacing:0" class="endContentsSpan">						
						<c:choose>
							<c:when test="${collaboApprovalVO.collaboPrice ne null and collaboApprovalVO.collaboPrice ne '' and collaboApprovalVO.collaboPrice ne '0'}">
								<fmt:formatNumber value="${collaboApprovalVO.collaboPrice}" pattern="###,###,##0.##"/> 원
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>
						</c:choose>
					</span>
					<c:choose>
						<c:when test="${empty collaboApprovalVO.collaboPrice}">
							<input  type="text" name="collaboApprovalPrice" id="collaboApprovalPrice" class="endContents"
							value="0"
							ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);plusInvVal();"
							style="display:none;IME-MODE: disabled;" />
						</c:when>
						<c:otherwise>
							<input  type="text" name="collaboApprovalPrice" id="collaboApprovalPrice" class="endContents"
							value="<fmt:formatNumber value="${collaboApprovalVO.collaboPrice}" pattern="###,###,##0.##"/>"
							ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);plusInvVal();"
							style="display:none;IME-MODE: disabled;" />		
						</c:otherwise>
					</c:choose>
					</div>
					<div id="apInfoDeleteDiv" style="float:right;padding-right:5px;">
						<input id="apInfoDelete" name="apInfoDelete" class="buttonMini" type="button" value="삭제" onclick="javascript:doDeleteApprovalInfo();" style="background-color:#F6CEEC;font-weight:none;width:50px;">
					</div>
				</td>
			</tr>	
			</c:if>
			<!-- 보험사가 현대해상인 경우 결재 수수료항목 추가 끝 by top3009 (20231228)-->
			<tr>
				<td bgcolor="#E7ECF1"><b>ㆍ일비</b></td>
				<td>
					<span id="amtDailyDtlSpan" style="font-family:'굴림';" class="endContentsSpan">${suimInvVO.amtDailyText}</span>
					<input type="text" style="ime-mode:active;display:none;" id = "amtDailyDtl" class="endContents" value="${suimInvVO.amtDailyText}"/>
				</td>
				<td>
					<span id="amtDailySpan" style="font-family:'굴림'; letter-spacing:0" class="endContentsSpan">
						<c:choose>
							<c:when test="${suimInvVO.amtDaily ne null and suimInvVO.amtDaily ne '' and suimInvVO.amtDaily ne '0'}">
								<fmt:formatNumber value="${suimInvVO.amtDaily}" pattern="###,###,##0.##"/> 원
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>
						</c:choose>
					</span>
					<input  type="text" name="amtDaily" id="amtDaily" class="endContents"
							value="<fmt:formatNumber value="${suimInvVO.amtDaily}" pattern="###,###,##0.##"/>"
							ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);plusInvVal();"style="display:none;IME-MODE: disabled;" /> 
<%-- 					<input type="text"  style="display:none;" id = "amtDaily" class="endContents" onkeyup="plusInvVal();" value="${suimInvVO.amtDaily}"/> --%>
				</td>
			</tr>
			<tr>
				<td bgcolor="#E7ECF1"><b>ㆍ교통비</b></td>
				<td>
					<span id="amtTrafficDtlSpan" style="font-family:'굴림';" class="endContentsSpan">${suimInvVO.amtTrafficText}</span>
					<input type="text"  style="display:none;ime-mode:active;" id = "amtTrafficDtl"  class="endContents" value="${suimInvVO.amtTrafficText}"/>
				</td>
				<td>
					<span id="amtTrafficSpan" style="font-family:'굴림'; letter-spacing:0" class="endContentsSpan">
						<c:choose>
							<c:when test="${suimInvVO.amtTraffic ne null and suimInvVO.amtTraffic ne '' and suimInvVO.amtTraffic ne '0'}">
								<fmt:formatNumber value="${suimInvVO.amtTraffic}" pattern="###,###,##0.##"/> 원
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>
						</c:choose>
					</span>
					<input  type="text" name="amtTraffic" id="amtTraffic" class="endContents" 
							value="<fmt:formatNumber value="${suimInvVO.amtTraffic}" pattern="###,###,##0.##"/>"
							ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);plusInvVal();"style="display:none;IME-MODE: disabled;" /> 
							
<%-- 					<input type="text"  style="display:none;" id = "amtTraffic"  class="endContents" onkeyup="plusInvVal();" value="${suimInvVO.amtTraffic}"/> --%>
				</td>
			</tr>
			<tr>
				<td bgcolor="#E7ECF1"><b>ㆍ자문료</b></td>
				<td>
					<span id="amtCounselDtlSpan" style="font-family:'굴림';" class="endContentsSpan">${suimInvVO.amtCounselText}</span>
					<input type="text"  style="display:none;ime-mode:active;" id = "amtCounselDtl" class="endContents" value="${suimInvVO.amtCounselText}"/>
				</td>
				<td>
					<span id="amtCounselSpan" class="endContentsSpan" style="font-family:'굴림'; letter-spacing:0" >
						<c:choose>
							<c:when test="${suimInvVO.amtCounsel ne null and suimInvVO.amtCounsel ne '' and suimInvVO.amtCounsel ne '0'}">
								<fmt:formatNumber value="${suimInvVO.amtCounsel}" pattern="###,###,##0.##"/> 원
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>
						</c:choose>
					</span>
					<input  type="text" name="amtCounsel" id="amtCounsel" class="endContents"
							value="<fmt:formatNumber value="${suimInvVO.amtCounsel}" pattern="###,###,##0.##"/>"
							ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);plusInvVal();"style="display:none;IME-MODE: disabled;" /> 
					
<%-- 					<input type="text"  style="display:none;" id = "amtEtc" class="endContents" onkeyup="plusInvVal();" value="${suimInvVO.amtEtc}"/> --%>
				</td>
			</tr>
			
			<tr>
				<td bgcolor="#E7ECF1"><b>ㆍ기타</b></td>
				<td>
					<span id="amtEtcDtlSpan" style="font-family:'굴림';" class="endContentsSpan">${suimInvVO.amtEtcText}</span>
					<input type="text"  style="display:none;ime-mode:active;" id = "amtEtcDtl" class="endContents" value="${suimInvVO.amtEtcText}"/>
				</td>
				<td>
					<span id="amtEtcSpan" class="endContentsSpan" style="font-family:'굴림'; letter-spacing:0">
						<c:choose>
							<c:when test="${suimInvVO.amtEtc ne null and suimInvVO.amtEtc ne '' and suimInvVO.amtEtc ne '0'}">
								<fmt:formatNumber value="${suimInvVO.amtEtc}" pattern="###,###,##0.##"/> 원
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>
						</c:choose>
					</span>
					<input  type="text" name="amtEtc" id="amtEtc" class="endContents" 
							value="<fmt:formatNumber value="${suimInvVO.amtEtc}" pattern="###,###,##0.##"/>"
							ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);plusInvVal();"style="display:none;IME-MODE: disabled;" /> 
					
<%-- 					<input type="text"  style="display:none;" id = "amtEtc" class="endContents" onkeyup="plusInvVal();" value="${suimInvVO.amtEtc}"/> --%>
				</td>
			</tr>
			<tr>
				<th colspan="2">합계</th>
				<td>
					<span id="amtTotalSpan" class="endContentsSpan" style="font-family:'굴림'; letter-spacing:0;">
						<%-- <fmt:formatNumber value="${suimInvVO.amtBasic + suimInvVO.amtDaily + suimInvVO.amtTraffic + suimInvVO.amtCounsel+suimInvVO.amtEtc }" pattern="###,###,##0.##"/> 원 --%>
						<fmt:formatNumber value="${suimInvVO.amtTotal }" pattern="###,###,##0.##"/> 원
					</span>
					<input  type="text" name="amtTotal" id="amtTotal" class="endContents" onkeyup="plusInvVal();" readonly="readonly"
							value="<fmt:formatNumber value="${suimInvVO.amtTotal }" pattern="###,###,##0.##"/>"
							ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);" style="display:none;IME-MODE: disabled;" /> 
					
<%-- 					<input type="text"  style="display:none; font-family:'굴림';" readonly="readonly" id = "amtTotal" class="endContents" value="${suimInvVO.amtTotal}"/> --%>
				</td>
			</tr>
		</tbody>
	</table>
	
	<table align="center" style="margin-top: 5px;" >
		<colgroup>
			<col width="20%" />
			<col width="30%" />
			<col width="17%" />
			<col width="33%" />
		</colgroup>
		<!-- 공동 수행 시작 -->
		<tr>
			<td colspan="4" align="center">
				<c:choose>
					<c:when test="${ (suimVO.suimRptState eq '0' and suimVO.editYN > 0) or (endModFlag > 0) }">
						공동 수행자 추가
						<img src="./resources/ls_img/btn_add_s.gif" title="공동 수행자 추가" id="collabo_add_view_btn" style="cursor:pointer; "/>
						<img src="./resources/ls_img/btn_close.gif" title="공동 수행자 추가 취소" id="collabo_add_cancel_btn" style="cursor:pointer; display:none;"/>
					</c:when>
					
					<c:otherwise>
						<font color="red">※ 공동 수행자는 상신하기 전에 등록할수 있습니다.</font>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
			
		<tbody class="collabo_add" style="display: none;">
			<c:choose>
			
				<c:when test="${ suimVO.suim_rpt_type1 eq 14 or suimVO.suim_rpt_type1 eq 15 or suimVO.suim_rpt_type1 eq 16 or suimVO.suim_rpt_type1 eq 17}">		
					<!-- 1종 공동수행 -->	
					<tr>
						<td bgcolor="#E7ECF1"><b>ㆍ공동수행자</b></td>
						<td>
							<input type="hidden" id="mbrNo0" />
							<input type="hidden" id="share_team_id0"/>
							<input type="text" id="mbrNm0" style="background-color:lightgrey;" readonly   size="15" /> 
							<input type="image" src='./resources/ls_img/btn_edit_s.gif' class="popOpenBtn" value="0"  /> 
						</td>						
						<td bgcolor="#E7ECF1" style="letter-spacing:-1px;"><b>ㆍ공동(종결) 건수</b></td>
						<td>
							<!-- <input type="text" id="collaboPp" size="15" /> % -->
							<input type="text" id="writtenCnt" size="15" /> 건
							<input type="hidden" id="collaboPp" name="collaboPp" value="0"/>
							<input type="hidden"id="collaboPrice" value="0"/>
							<input type="hidden"id="collaboPriceTypeVal" value="0"/> 
						</td>						
					</tr>
					
					<tr>
						<td bgcolor="#E7ECF1"><b>ㆍ공동(기본) 보수</b></td>
						<td>
							<input type="text" class="money" id="writtenBasic" size="15" value="0"/>
							<input type="hidden"id="collaboDaily" size="15" value="0"/> 
							<span id="collaboDailyUnit">원</span>							
							<input type="hidden" id="collaboDailyType2" name="collaboDailyType" value="1">
							<input type="hidden" id="collaboDailyTypeVal" value="0"/>
							<img src="./resources/ls_img/btn_check_s.gif" title="공동 수행자 추가 확인"style="cursor:pointer;margin-left:10px;;" onclick="fnInsertCollabo();"/>
						</td>
						<td bgcolor="#E7ECF1"></td>
						<td>
							<input type="hidden" class="money" id="collaboTraffic" size="15" value="0"/>							
						</td>
					</tr>
					
					<tr>
						<td colspan="2" style="border:0px !important;"></td>
					</tr>
				</c:when>
				
				<c:when test="${ suimVO.ptnr_id ne 14 and suimVO.suim_rpt_type1 ne 3 and suimVO.suim_rpt_type1 ne 4 }">		
					<!-- 1종 공동수행 -->	
					<tr>
						<td bgcolor="#E7ECF1"><b>ㆍ공동수행자</b></td>
						<td>
							<input type="hidden" id="mbrNo0" />
							<input type="hidden" id="share_team_id0"/>
							<input type="text" id="mbrNm0" style="background-color:lightgrey;" readonly   size="15" /> 
							<input type="image" src='./resources/ls_img/btn_edit_s.gif' class="popOpenBtn" value="0"  /> 
						</td>						
						<td bgcolor="#E7ECF1"><b>ㆍ공동수행율(건)</b></td>
						<td>
							<input type="text" id="collaboPp" size="15" /> %						
						</td>						
					</tr>
					
					<tr>
						<td bgcolor="#E7ECF1"><b>ㆍ공동수행 기본보수</b></td>
						<td colspan="3">
							<input type="text" class="money" id="collaboPrice" size="15" value="0" disabled="disabled"/> 
							<span id="collaboPriceUnit">%</span>
							&nbsp;&nbsp;
							<input type="radio" id="collaboPriceType1" name="collaboPriceType" onclick="fnCollaboPriceRadio(this);" value="0" checked="checked"> 비율
							<input type="radio" id="collaboPriceType2" name="collaboPriceType" onclick="fnCollaboPriceRadio(this);" value="1"> 금액
							<input type="hidden" id="collaboPriceTypeVal" value="0"/>
						</td>						
					</tr>
					<tr>
						<td bgcolor="#E7ECF1"><b>ㆍ공동수행 일비</b></td>
						<td colspan="3">
							<input type="text" class="money" id="collaboDaily" size="15" value="0" disabled="disabled"/> 
							<span id="collaboDailyUnit">%</span>
							&nbsp;&nbsp;
							<input type="radio" id="collaboDailyType1" name="collaboDailyType" onclick="fnCollaboDailyRadio(this);" value="0" checked="checked"> 비율
							<input type="radio" id="collaboDailyType2" name="collaboDailyType" onclick="fnCollaboDailyRadio(this);" value="1"> 금액
							<input type="hidden" id="collaboDailyTypeVal" value="0"/>
						</td>						
					</tr>	
					<tr>
						<td bgcolor="#E7ECF1" style="letter-spacing:-1px;"><b>ㆍ공동수행 교통비</b></td>
						<td colspan="3">
							<input type="text" class="money" id="collaboTraffic" size="15" value="0"/> 원
							<img src="./resources/ls_img/btn_check_s.gif" title="공동 수행자 추가 확인"style="cursor:pointer;margin-left:10px;;" onclick="fnInsertCollabo();"/>
						</td>
					</tr>				
					<tr>
						<td colspan="2" style="border:0px !important;"></td>
					</tr>
				</c:when>
				
				<c:when test="${ suimVO.ptnr_id eq 14 and suimVO.suim_rpt_type1 ne 3 and suimVO.suim_rpt_type1 ne 4 }">
					<!-- 현대 수수료입력시 1종 공동수행 (작업중)-->	
					<tr>
						<td bgcolor="#E7ECF1"><b>ㆍ공동수행자</b></td>
						<td>
							<input type="hidden" id="mbrNo0" />
							<input type="hidden" id="share_team_id0"/>
							<input type="text" id="mbrNm0" style="background-color:lightgrey;" readonly   size="15" /> 
							<input type="image" src='./resources/ls_img/btn_edit_s.gif' class="popOpenBtn" value="0"  /> 
						</td>						
						<td bgcolor="#E7ECF1"><b>ㆍ공동수행율(건)</b></td>
						<td>
							<input type="text" id="collaboPp" size="15" /> %						
						</td>						
					</tr>
					
					<tr>
						<td bgcolor="#E7ECF1"><b>ㆍ공동수행 기본보수</b></td>
						<td colspan="3">
							<input type="text" class="money" id="collaboPrice" size="15" value="0"/> 
							<span id="collaboPriceUnit">원</span>
							&nbsp;&nbsp;							
							<input type="radio" id="collaboPriceType2" name="collaboPriceType" onclick="fnCollaboPriceRadio(this);" value="1" checked="checked"> 금액
							<input type="hidden" id="collaboPriceTypeVal" value="0"/>
						</td>						
					</tr>
					<tr>
						<td bgcolor="#E7ECF1"><b>ㆍ공동수행 일비</b></td>
						<td colspan="3">
							<input type="text" class="money" id="collaboDaily" size="15" value="0"/> 
							<span id="collaboDailyUnit">원</span>
							&nbsp;&nbsp;
							
							<input type="radio" id="collaboDailyType2" name="collaboDailyType" onclick="fnCollaboDailyRadio(this);" value="1" checked="checked"> 금액
							<input type="hidden" id="collaboDailyTypeVal" value="0"/>
						</td>						
					</tr>	
					<tr>
						<td bgcolor="#E7ECF1" style="letter-spacing:-1px;"><b>ㆍ공동수행 교통비</b></td>
						<td colspan="3">
							<input type="text" class="money" id="collaboTraffic" size="15" value="0"/> 원
							<img src="./resources/ls_img/btn_check_s.gif" title="공동 수행자 추가 확인"style="cursor:pointer;margin-left:10px;;" onclick="fnInsertCollabo();"/>
						</td>
					</tr>				
					<tr>
						<td colspan="2" style="border:0px !important;"></td>
					</tr>
				</c:when>
					
				<c:otherwise>
					<!-- 4종 공동수행 -->
					<tr>
						<td bgcolor="#E7ECF1"><b>ㆍ공동수행자 입력</b></td>
						<td align="center">
							<input type="hidden" id="mbrNo0" />
							<input type="hidden" id="share_team_id0"/>
							<input type="text" id="mbrNm0" style="background-color:lightgrey;" readonly   size="15" /> 
							<input type="image" src='./resources/ls_img/btn_edit_s.gif' class="popOpenBtn" value="0"  /> 
						</td>
						
						<td bgcolor="#E7ECF1"><b>ㆍ공동수행금액</b></td>
						<td>
							<input type="text" id="collaboPp" size="10" /> 원
							<img src="./resources/ls_img/btn_check_s.gif" title="공동 수행자 추가 확인"style="cursor:pointer;margin-left:10px;;" onclick="fnInsertCollabo();"/>
						</td>		
					</tr>
				</c:otherwise>
			</c:choose>				
		</tbody>
			
		<tbody class="collabo_view" id="collabo_view" >
			<c:choose>
			
				<c:when test="${ suimVO.suim_rpt_type1 eq 14 or suimVO.suim_rpt_type1 eq 15 or suimVO.suim_rpt_type1 eq 16 or suimVO.suim_rpt_type1 eq 17}">
					<c:forEach items="${collaboList}" var="item" varStatus="status">
					<fmt:parseNumber var="written_cnt" value="${item.writtenCnt}"/>
					<fmt:parseNumber var="written_basic" value="${item.writtenBasic}"/>
						<c:if test="${!status.first}">					
							<tr>
								<td colspan="2" style="border:0px !important; padding: 1px 0 1px 0 !important;"></td>
							</tr>
						</c:if>												
						<c:choose>
								<c:when test="${ written_cnt == 0 and written_basic == 0}">
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ공동수행자</b></td>
										<td>
											${item.userName}
											<c:if test="${(suimVO.suimRptState eq '0' and suimVO.editYN > 0) or (endModFlag > 0) }">
												<img src="./resources/ls_img/btn_del_s.gif" onclick="fnDeleteCollabo('${item.serialNo}');" style='cursor:pointer; float:right; margin-right:20px;'/>
											</c:if>								
										</td>
										
										<td bgcolor="#E7ECF1"><b>ㆍ공동수행율(건)</b></td>
										<td>
											${item.collaboPp} %
										</td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ공동수행 일비</b></td>
										<td>
											<c:choose>
												<c:when test="${item.collaboDailyType eq '0' }">
													${item.collaboDaily} %
												</c:when>
												<c:otherwise>
													<fmt:formatNumber value="${item.collaboDaily}" pattern="###,###,##0.##"/> 원
												</c:otherwise>
											</c:choose>
										</td>
										<td bgcolor="#E7ECF1" style="letter-spacing:-1px;"><b>ㆍ공동수행 교통비</b></td>
										<td>
											<fmt:formatNumber value="${item.collaboTraffic}" pattern="###,###,##0.##"/> 원
										</td>
									</tr>
								</c:when>
								<c:otherwise>
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ공동수행자</b></td>
										<td>
											${item.userName}
											<c:if test="${(suimVO.suimRptState eq '0' and suimVO.editYN > 0) or (endModFlag > 0) }">
												<img src="./resources/ls_img/btn_del_s.gif" onclick="fnDeleteCollabo('${item.serialNo}');" style='cursor:pointer; float:right; margin-right:20px;'/>
											</c:if>								
										</td>
										
										<td bgcolor="#E7ECF1"><b>ㆍ공동(종결) 건수</b></td>
										<td>
											${item.writtenCnt} 건
										</td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ공동(기본) 보수</b></td>
										<td>
											<fmt:formatNumber value="${item.writtenBasic}" pattern="###,###,##0.##"/> 원
										</td>
										<td bgcolor="#E7ECF1"></td>
										<td>										
										</td>
									</tr>
								</c:otherwise>		
						</c:choose>
										
					</c:forEach>
				</c:when>
			
				<c:when test="${ suimVO.suim_rpt_type1 ne 3 and suimVO.suim_rpt_type1 ne 4 }">
					<c:forEach items="${collaboList}" var="item" varStatus="status">
						<c:if test="${!status.first}">					
							<tr>
								<td colspan="2" style="border:0px !important; padding: 1px 0 1px 0 !important;"></td>
							</tr>
						</c:if>
										
						<tr>
							<td bgcolor="#E7ECF1"><b>ㆍ공동수행자</b></td>
							<td>
								${item.userName}
								<c:if test="${(suimVO.suimRptState eq '0' and suimVO.editYN > 0) or (endModFlag > 0) }">
									<img src="./resources/ls_img/btn_del_s.gif" onclick="fnDeleteCollabo('${item.serialNo}');" style='cursor:pointer; float:right; margin-right:20px;'/>
								</c:if>								
							</td>
							
							<td bgcolor="#E7ECF1"><b>ㆍ공동수행율(건)</b></td>
							<td>
								${item.collaboPp} %
							</td>
						</tr>						
						<tr>
							<td bgcolor="#E7ECF1"><b>ㆍ공동수행 기본보수</b></td>
							<td colspan="3">
								<c:choose>
									<c:when test="${item.collaboPriceType eq '0' }">
										${item.collaboPrice} %
									</c:when>
									<c:otherwise>
										<fmt:formatNumber value="${item.collaboPrice}" pattern="###,###,##0.##"/> 원
									</c:otherwise>
								</c:choose>
							</td>							
						</tr>
						<tr>
							<td bgcolor="#E7ECF1"><b>ㆍ공동수행 일비</b></td>
							<td colspan="3">
								<c:choose>
									<c:when test="${item.collaboDailyType eq '0' }">
										${item.collaboDaily} %
									</c:when>
									<c:otherwise>
										<fmt:formatNumber value="${item.collaboDaily}" pattern="###,###,##0.##"/> 원
									</c:otherwise>
								</c:choose>
							</td>							
						</tr>
						<tr>
							<td bgcolor="#E7ECF1" style="letter-spacing:-1px;"><b>ㆍ공동수행 교통비</b></td>
							<td colspan="3">
								<fmt:formatNumber value="${item.collaboTraffic}" pattern="###,###,##0.##"/> 원
							</td>
						</tr>										
					</c:forEach>
				</c:when>
				
				<c:otherwise>
					<c:forEach items="${collaboList}" var="item" varStatus="status">
						<c:if test="${!status.first}">					
							<tr>
								<td colspan="2" style="border:0px !important; padding: 1px 0 1px 0 !important;"></td>
							</tr>
						</c:if>
										
						<tr>
							<td bgcolor="#E7ECF1"><b>ㆍ공동수행자</b></td>
							<td>
								${item.userName}
							</td>
							
							<td bgcolor="#E7ECF1"><b>ㆍ공동수행금액</b></td>
							<td>
								${item.collaboPp} 원
								<c:if test="${(suimVO.suimRptState eq '0' and suimVO.editYN > 0) or (endModFlag > 0) }">
									<img src="./resources/ls_img/btn_del_s.gif" onclick="fnDeleteCollabo('${item.serialNo}');" style='cursor:pointer; float:right; margin-right:20px;'/>
								</c:if>
							</td>
						</tr>
					</c:forEach>					
				</c:otherwise>
			</c:choose>	
		</tbody>
	</table>
	
	<script>
		$(document).ready(function(){
			_initButton();	
		});
		
		//공동 수행 스크립트 180409
    	function _initButton() {
			//추가 버튼
	        $("#collabo_add_view_btn").on("click", function () {
	        	$(".collabo_add").show();
	        	$("#collabo_add_view_btn").hide();
	        	$("#collabo_add_cancel_btn").show();
	        });
			
	        //취소 버튼
	        $("#collabo_add_cancel_btn").on("click", function () {
	        	$(".collabo_add").hide();
	        	$("#collabo_add_view_btn").show();
	        	$("#collabo_add_cancel_btn").hide();	        	
	        });
	        
	        //비율적용 체크박스
	        
	        
	        //공동수행율 변경시
	        $("#collaboPp").on("keyup",function() {
	        	
	        	//기본보수 추가
	        	if ( $("input:radio[name='collaboPriceType']").val() == 0 ){
	        		$("#collaboPrice").val( $("#collaboPp").val() );
	        	}
	        	
	        	if ( $("input:radio[name='collaboDailyType']").val() == 0 ){
	        		$("#collaboDaily").val( $("#collaboPp").val() );
	        	}
	        });
		}
		
		//기본보수 추가 by top3009
    	function fnCollaboPriceRadio(that){
			var priceGubun = $(that).val(); //0:비율, 1:금액
		
        	if ( priceGubun == 0 ){
        		$("#collaboPrice").val( $("#collaboPp").val() );
        		$("#collaboPrice").prop("disabled",true);
        		$("#collaboPriceUnit").html("%");
        		$("#collaboPriceTypeVal").val("0");
        	}else{
        		$("#collaboPrice").val("0");
        		$("#collaboPrice").prop("disabled",false);
        		$("#collaboPriceUnit").html("원");
        		$("#collaboPriceTypeVal").val("1");
        	}
			
		}
		
		function fnCollaboDailyRadio(that){
			var dailyGubun = $(that).val(); //0:비율, 1:금액
		
        	if ( dailyGubun == 0 ){
        		$("#collaboDaily").val( $("#collaboPp").val() );
        		$("#collaboDaily").prop("disabled",true);
        		$("#collaboDailyUnit").html("%");
        		$("#collaboDailyTypeVal").val("0");
        	}else{
        		$("#collaboDaily").val("0");
        		$("#collaboDaily").prop("disabled",false);
        		$("#collaboDailyUnit").html("원");
        		$("#collaboDailyTypeVal").val("1");
        	}
			
		}
		
    	function fnInsertCollabo() {
    		var suimRptNo 			= $("#suimRptNo").val();
    		var suimRptType1		= "${suimVO.suim_rpt_type1}";
    		var userId 				= $("#mbrNo0").val(); 
    		var shareTeamId 		= $("#share_team_id0").val();
    		var collaboPp 			= $("#collaboPp").val();
    		
    		var p_ptnrId = ${suimVO.ptnr_id};
    		
    		if( suimRptType1 == 14 || suimRptType1 == 15 || suimRptType1 == 16 || suimRptType1 == 17 || suimRptType1 == 18 ){
    			var writtenCnt = $("#writtenCnt").val();
    			var writtenBasic = $("#writtenBasic").val().num();    			
    		}
    		
    		if (suimRptType1 != 3 && suimRptType1 != 4){
	    		var collaboDaily 		= $("#collaboDaily").val().num(); 
	    		var collaboDailyType	= $("#collaboDailyTypeVal").val(); 
	    		var collaboTraffic 		= $("#collaboTraffic").val().num();
	    		
	    		//기본보수 항목 추가
	    		var collaboPrice = $("#collaboPrice").val().num();
	    		var collaboPriceType	= $("#collaboPriceTypeVal").val();
    		}
    		
    		//공동수행자에 담당자 정보를 입력할수 없다.    		
    		if( ${suimVO.user_no} == userId ){
    			alert("처리담당자는 공동수행자로 입력할 수 없습니다.");
    			returnl
    		}    		
    		
    		if (userId == ""){
    			alert("공동수행자를 입력 해 주세요..");
    			return;
    		}
    		
    		if (collaboPp == ""){
    			alert("공동수행율을 입력 해 주세요..");
    			$("#collaboPp").focus();
    			return;
    		}
    		
    		if (suimRptType1 != 3 && suimRptType1 != 4){    			
    			if (collaboPrice == "" ){
    				alert("공동수행 기본보수를 입력 해 주세요..");
	    			$("#collaboPrice").focus();
	    			return;
    			}    			
	    		if (collaboDaily == ""){
	    			alert("공동수행 일비를 입력 해 주세요..");
	    			$("#collaboDaily").focus();
	    			return;
	    		}
	    		if (collaboTraffic == ""){
	    			alert("공동수행 교통비를 입력 해 주세요..");
	    			$("#collaboTraffic").focus();
	    			return;
	    		}
    		}
    		
    		//alert("collaboPrice : "+collaboPrice);
    		//alert("collaboPriceType : "+collaboPriceType);
    		//return;
    		
    		var param = {};
    		param.suimRptNo			= suimRptNo;
    		param.suimRptType1		= suimRptType1;
    		param.userId 			= userId; 
    		param.shareTeamId 		= shareTeamId;
    		param.collaboPp 		= collaboPp;
    		param.action 			= "C";
    		
    		if( suimRptType1 == 14 || suimRptType1 == 15 || suimRptType1 == 16 || suimRptType1 == 17 || suimRptType1 == 18 ){
    			param.writtenCnt = writtenCnt;
    			param.writtenBasic = writtenBasic;
    		}else{			//서면심사가 아닌경우 0으로 넣어준다. by top3009 (20191101)
    			param.writtenCnt = 0;
    			param.writtenBasic = 0;
    		}
    		
    		if( p_ptnrId == 14 && suimRptType1 != 3 && suimRptType1 != 4 ){		//현대해상 1종은 기본보수와 일비를 금액으로 고정
    			param.collaboPrice = collaboPrice;
	    		param.collaboPriceType = 1;	    		
	    		param.collaboDaily 		= collaboDaily;
	    		param.collaboDailyType 	= 1; 
	    		param.collaboTraffic 	= collaboTraffic;    			
    		}else if (suimRptType1 != 3 && suimRptType1 != 4){
    			param.collaboPrice = collaboPrice;
	    		param.collaboPriceType = collaboPriceType;	    		
	    		param.collaboDaily 		= collaboDaily;
	    		param.collaboDailyType 	= collaboDailyType; 
	    		param.collaboTraffic 	= collaboTraffic;	    		
    		}else{
    			param.collaboPrice = 0;
	    		param.collaboPriceType = 0;
	    		param.collaboDaily 		= 0;
	    		param.collaboDailyType 	= 0; 
	    		param.collaboTraffic 	= 0;	    		
    		}
    		
    		actionCollabo(param);
    	    
    	}
    	
    	function fnDeleteCollabo(serialNo) {
    		var msg = confirm("해당 공동수행을 삭제 하시겠습니까?");
    		
    		if (!msg) return;
    		
    		var param = {};
    		param.serialNo			= serialNo;    		
    		param.suimRptNo 		= $("#suimRptNo").val();
    		param.suimRptType1		= "${suimVO.suim_rpt_type1}";
    		param.action 			= "D";
    		
    		actionCollabo(param);
    	}
    	
    	
    	function actionCollabo(param) {
    		
    		var actionFlag = true;
    		
    		if ( (param.suimRptType1 != 3 && param.suimRptType1 != 4) && param.action == "C" ){
    			
    			if ($("#amtBasic").val() == ""  ){
    				alert("인보이스 기본보수를 먼저 입력 해 주세요.");
    				return;
    			}
        		
    			var url = "/validCollabo";
        		
        	    $.ajax({
        	        type: "POST",
        	        url: url,
        	        data: param,
        	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        	        timeout: 20000,
        	        async: false,
        	        dataType: "JSON", 
        	        success: function(data){
        	        	
        	        	if (data.validBasic == 1){
        	        		var msg = "총 공동수행 기본보수의 환산 값이 인보이스의 기본보수보다 큽니다..";
        	        		msg += "\n인보이스 : "+data.amtBasic+"원, 공동수행 : "+data.collaboBasic+"원";
        	        		actionFlag = false;
        	        		alert(msg);
        	        		
        	        	}else if (data.validDaily == 1){
        	        		var msg = "총 공동수행 일비의 환산 값이 인보이스의 일비보다 큽니다..";
        	        		msg += "\n인보이스 : "+data.amtDaily+"원, 공동수행 : "+data.collaboDaily+"원";
        	        		actionFlag = false;
        	        		alert(msg);
        	        		
        	        	}else if (data.validTraffic == 1){
        	        		var msg = "총 공동수행 교통비의 환산 값이 인보이스의 교통비보다 큽니다..";
        	        		msg += "\n인보이스 : "+data.amtTraffic+"원, 공동수행 : "+data.collaboTraffic+"원";
        	        		actionFlag = false;
        	        		alert(msg);
        	        	}
        	        }
        	    });    			
    			
    		} 
    		
    		if ( actionFlag ){
	    		var url = "/actionCollabo";
	    	    $.ajax({
	    	        type: "POST",
	    	        url: url,
	    	        data: param,
	    	        async: false,
	    	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	    	        timeout: 20000,
	    	        dataType: "HTML", 
	    	        success: function(data){
	    	        	
	    	        	//console.log("data="+data);	    	        	
	    	        	
	    	        	$("#collabo_add_cancel_btn").click();
	       	        	$("#collabo_view").html("");
	       	        	$("#collabo_view").html(data);
	    	        	_initButton();
	    	        	
	    	        	if (param.action == "C"){
	    	        		alert("공동 수행자 등록에 성공 하였습니다..");
	    	        	}else if (param.action == "D"){
	    	        		alert("공동 수행자 삭제에 성공 하였습니다..");
	    	        	}
	    	        }
	    	    });
    		}
    		
    	}
	</script>	

