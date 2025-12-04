<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>보고서 기본정보 수정</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	
	<%--spiner start--%>
    <script src="/resources/jquery/spin.js"></script>
    <script src="/resources/jquery/jquery.spin.js"></script>
    <%--spiner end --%>
	
	
	
	
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<script src="./resources/ne_js/ne_number.js"></script>
	
	<%--<script src="./resources/daum/161109.js"></script>--%>
	<script src="./resources/daum/postcode.v2.js"></script>
	<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script>	
	<c:set var="auth24Flag" value="${auth24Flag}"/>
	<script>
	
		var workload_ea_first = false;	//최초 진입시 종결건수값 변경 안되도록 하기 위한 값
		
		$(document).ready(function(){
			_initSelectFlag();
			
			//달력추가 시작 by top3009
			_initCalendar();
			//입력값에 '~' 있으면 분리해서 넣어준다.
			var sDate = '${rptOne.insuTerm}';						
			if( sDate.indexOf("~") > -1 ){
				var bDate = sDate.split("~");
				$("#sdate").val(bDate[0]);
				$("#edate").val(bDate[1]);
			}
			//달력추가 끝 by top3009
			
			//4종 지정건 구분 및 보험사 상세 구분 초기화 180709
			if ("${rptOne.report_type}" == 3 || "${rptOne.report_type}" == 4){
				$("input:radio[name='ptnrAssignGubun']:radio[value='"+'${rptOne.ptnrAssignGubun}'+"']").prop('checked', true);
				$("input:radio[name='ptnrDetailGubun']:radio[value='"+'${rptOne.ptnrDetailGubun}'+"']").prop('checked', true);
			}
			
			//부서상세 구분 표시
			if ("${rptOne.report_type}" == 11 || "${rptOne.report_type}" == 12 || "${rptOne.report_type}" == 13 || "${rptOne.report_type}" == 2){
				getPtnrIdSubForm();
				getPeriodFlagForm();
				
				$("#ptnrSubDiv").show();				
			}else{
				getPtnrIdSubFormDisable();
				getPeriodFlagFormDisable();
				
				$("#ptnrSubDiv").hide();
			}
			
			$("input:radio[name='gubun_rpt2']:radio[value='${suimVO.suim_rpt_type2}']").prop('checked', true);
			
			//원스톱 체크박스 초기화
			if ( "${rptOne.speedOnestop}" == 1 ){
				$("#chkSpeedOnestop").attr("checked","true");
			}
			
			//처리 구분 체크
			$("input:radio[name='gubun_rpt1']:radio[value='"+'${rptOne.report_type}'+"']").click();
			
			//기준업무량 초기화 
			$("#workload_type"+"${rptOne.report_type}"+"_"+"${rptOne.workloadType}").prop("checked",true);
			if ("${rptOne.workloadType}" == ""){
				workload_ea_first = true;
				workloadValid = false;
			}else{
				workloadValid = true;
			}
			
			$("#postCodeBtnRptUdt").click(function(){				
				var themeObj = {
						   bgColor: "#C00C0C", //바탕 배경색
						   //searchBgColor: "", //검색창 배경색
						   //contentBgColor: "", //본문 배경색(검색결과,결과없음,첫화면,검색서제스트)
						   //pageBgColor: "", //페이지 배경색
						   //textColor: "", //기본 글자색
						   //queryTextColor: "", //검색창 글자색
						   //postcodeTextColor: "", //우편번호 글자색
						   emphTextColor: "#C01160" //강조 글자색
						   //outlineColor: "", //테두리
						};
				new daum.Postcode({
					theme: themeObj,
					oncomplete: function(data) {
						$("#postcode_rptUdt").val(data.zonecode);
						$("#addr_rptUdt_1").val(data.roadAddress);
					}
				}).open();
			});//$("#postCodeBtn").click
			
			$("#cancel").click(function(){
				history.back(-1);
			});
			
			
			/* 모랄 플래그 체크 */
			if('${rptOne.moralFlag}' != ''){
				$("input:radio[name='moralId']:radio[value='"+'${rptOne.moralFlag}'+"']").prop('checked', true);				
			}else{
				$("input:radio[name='moralId']:radio[value='"+'0'+"']").prop('checked', true);
			}
			
			/* 민원 플래그 체크 */
			if('${rptOne.minwonFlag}' != ''){
				$("input:radio[name='complainId']:radio[value='"+'${rptOne.minwonFlag}'+"']").prop('checked', true);
			}else{
				$("input:radio[name='complainId']:radio[value='"+'0'+"']").prop('checked', true);
			}
			

			
			/* 결재자 세팅 */
			/* if("${rptOne.suimRptAprvUserNo}" != '' ){
				$("#rptUserNoChange").val('${rptOne.suimRptAprvUserNo}');				
			} */
			
			/* 보고서 양식 세팅 */
			if("${rptOne.report_type2}" != ''){
				$("input:radio[name='gubun_rpt2']:radio[value='"+'${rptOne.report_type2}'+"']").prop('checked', true);	
			}
			
			
			/* 수정 확인 버튼 동작 */
			$("#edite").click(function(){
				
				/** 입력데이터가 공백일 경우 체크 **/
				/*
				if ( $("#polSsn1Id").val()=="" || $("#polSsn2Id").val()==""){
					var policyholderSsn = "";
				}else{
					var policyholderSsn = $("#polSsn1Id").val()+"-"+$("#polSsn2Id").val();
					
				}
				
				if ( $("#benSsn1Id").val()=="" || $("#benSsn2Id").val()==""){
					var beneficiarySsn = "";
				}else{
					var beneficiarySsn = $("#benSsn1Id").val()+"-"+$("#benSsn2Id").val();
					
				}
				*/
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
				
				if ( $("#dmgtel_1").val()=="" || $("#dmgtel_2").val()=="" ||  $("#dmgtel_3").val()==""){
					var damagedTel = "";
				}else{
					var damagedTel = $("#dmgtel_1").val()+"-"+$("#dmgtel_2").val()+"-"+$("#dmgtel_3").val();
				}
				
				var compensationUnitVal = "";
				var selfPayUnitVal = "";
				if($("#amtCompensationLimitSelect").val() == '0'){
					compensationUnitVal = "￦";
				}else if($("#amtCompensationLimitSelect").val() == '1'){
					compensationUnitVal = "$";
				}else{
					compensationUnitVal = $("#CompensationUnit").val()
				}
				
				
				if($("#amtSelfSelect").val() == '0'){
					selfPayUnitVal = "￦";
				}else if($("#amtSelfSelect").val() == '1'){
					selfPayUnitVal = "$";
				}else{
					selfPayUnitVal = $("#selfPayUnit").val()
				}
				
				//대상구분 권한에 따른 값 넘기기
				if($("#auth24Flag").val() == '0'){
					pendncyTrgetAt = $("#pendncyTrgetAt").val();
				}else{
					pendncyTrgetAt = $("input:radio[name='pendncyTrgetAt']:checked").val()
				}
				
				var speedOneStop; 
				if( $("#chkSpeedOnestop").is(":checked") ){
					speedOneStop = 1;
				}else{
					speedOneStop = 0;
				}
				
				if ( "${rptOne.report_type}" != 3 && "${rptOne.report_type}" != 4 ){
					if (!workloadValid && "${rptOne.workloadUseAt}" == 1){
						alert("기준업무량 상세구분을 선택 해 주세요..");
						return;
					} 
					
					if ($("#workload_ea").val() == "" && "${rptOne.workloadUseAt}" == 1){
						alert("기준업무량 종결건수를 입력 해 주세요..");
						return;
					} 
				}				
				
				if( !$("input:radio[name='gubun_rpt1']").is(':checked') ){
					alert("처리구분을 선택해 주세요.");
					return;
				}				
				
				//일반전환일 체크(메리츠인 경우만 체크+현대해상인경우도 체크)
				if( (${rptOne.ptnr_id} == 16 || ${rptOne.ptnr_id} == 14) && $("#trans_time").val() != '' ){					
					//업무프로세스가(2:비대상, 3:과정관리 인 경우는 대상으로 변경)
					if( pendncyTrgetAt == '2' || pendncyTrgetAt == '3' ){
						alert("일반전환건으로 업무프로세스가 대상건으로 변경됩니다.");
						pendncyTrgetAt = 1;
					}
				}
				
				//부서상세 구분과 계약기간 체크박스 값이 있는지 먼저 확인한다.
				var ptnrIdSubVal = $("input:radio[name='ptnrIdSub']:checked").val();
				var periodFlagVal = $("input:radio[name='periodFlag']:checked").val();				
				
				if( typeof ptnrIdSubVal == "undefined" || typeof periodFlagVal == "undefined"){		//기존 보고서 값을 넣어준다.					
					ptnrIdSubVal = $("#ptnrIdSub").val();
					periodFlagVal = $("#periodFlag").val();
				}
				
				//부서상세 구분 값의 계약기간 선택이 여러개 인 경우 없음을 선택할 수 없도록 한다.
				var periodFlagChkVal = $("#periodFlagChk").val();				
				
				if( periodFlagChkVal == 1 ){
					periodFlagVal = $("input:radio[name='periodFlag']:checked").val();					
					if( periodFlagVal == 0 ){
						alert("보험사 계약기간 구분을 선택해주세요.(장기 또는 일반 체크)");
						return;
					}
				}
				
				//처리구분이 변경되는 경우 체크해서 세부구분을 초기화해야함
				var suimRptType1Val = $("input:radio[name='gubun_rpt1']:checked").val();				
				
				if( suimRptType1Val != 11 && suimRptType1Val != 12 && suimRptType1Val != 13 && suimRptType1Val != 2 ){
					ptnrIdSubVal = "0";
					periodFlagVal = "0";
				}				
				
				//사고일이 없는 경우 저장이 안되는 오류 수정 by top3009
				if($("#sago_time").val() != '' || $("#sago_time").val().length == 10 ){ //수임일 자릿수 체크
					if( 0 < $("#sago_time").val().substr(5,2) && $("#sago_time").val().substr(5,2) <= 12 && 
						0 < $("#sago_time").val().substr(8,2) && $("#sago_time").val().substr(8,2) <= 31 ){ //날짜 정상 체크
					}else{
						alert("사고일의 날짜를 정확히 입력하세요.");
						$("#sago_time").focus();
						return;
					}
				}else{
					alert("사고일을 정확히 입력하세요.");
					$("#sago_time").focus();
					return;
				}
				
				$.post("./rptBscUdt",
						{	
// 							 moralFlag         			:$("input:radio[name='moralId']:checked").val()  // 
// 							minwonFlag         		:$("input:radio[name='complainId']:checked").val()  //
							suimRptNo           		:$("#suimRptNo").val() // 
							,suimRptType1          		:$("input:radio[name='gubun_rpt1']:checked").val() //
							,suimRptType2          		:$("input:radio[name='gubun_rpt2']:checked").val() //
							,policyNo    				:$("#polNoId").val() //
							,insuranceNm     			:$("#insNmId").val() //
                            //,insuTerm                   :$("#insuTerm").val() //
                            ,insuTerm                   :$("#sdate").val()+"~"+$("#edate").val()			//달력관련 수정 by top3009
							,policyholderNm  			:$("#polNmId").val() // 
							,beneficiaryNm       		:$("#benNmId").val() // 
							,damagedNm         			:$("#dmgNmId").val() //
							
							,ptnrIdSub				: ptnrIdSubVal
							,periodFlag				: periodFlagVal
							
							,policyholderSsn    	: ''//policyholderSsn //
							,beneficiarySsn  		: ''//beneficiarySsn //
							
							,policyholderTel 			: policyholderTel
							,beneficiaryTel  			: beneficiaryTel
							,damagedTel  				: damagedTel 
							,pendncyTrgetAt				: pendncyTrgetAt //차 후 실제 적용할 대상 구분
							//,pendncyTrgetAt				:$("input:radio[name='pendncyTrgetAt']:checked").val() //임시로 열어놓을 대상 구분
							,accidentFacts    			:$("#accFactsId").val()
							,accidentDate    			:$("#sago_time").val() //														
							,regDate 					:$("#suim_time").val() //
							,transDate 					:$("#trans_time").val() //메리츠 일반건 전환항목 추고 by top3009
							//,amtEstimatedDamage 	:removeCommaFunc($("#amtEstId").val()) //
							//,commissionEstimated  	:removeCommaFunc($("#comEstId").val()) //
							,investigatePostcode 		:$("#postcode_rptUdt").val() // 
							,investigateAddr1 			:$("#addr_rptUdt_1").val() //
							,investigateAddr2   		:$("#addr_rptUdt_2").val() //  
							,accidentNo					:$("#accId").val() // 
							,amtCompensationLimit  		:removeCommaFunc($("#amtCompensationLimit").val()) 								// 보상한도액
							,compensationLimitUnit		:compensationUnitVal 
							,compensationLimitEtcAmt	:$("#amtCompensationLimitEtc").val() 							// 보상한도액 직접입력
							,amtSelfPay					:removeCommaFunc($("#amtSelfPay").val()) 										// 자기부담금
							,selfPayEtcAmt	 			:$("#selfPayEtcAmtEtc").val() 									// 자기부담 분류 직접입력
							,selfPayUnit				:selfPayUnitVal 
							,speedType					:$("#speedTypeList").val()
							,speedOneStop				:speedOneStop
							,befSpeedType				:$("#befSpeedType").val()
							,workloadType				:$("input:radio[name='workload_type']:checked").val()
							,workloadEa					:$("#workload_ea").val()
							,retirePendingFlag			:$("input:radio[name='retire_pending_flag']:checked").val()
							,ptnrAssignGubun			:$("input:radio[name='ptnrAssignGubun']:checked").val()
							,ptnrDetailGubun			:$("input:radio[name='ptnrDetailGubun']:checked").val()
							,insu_condition				:$("#insu_condition").val()
							
							 
							,compensationLimitFlag  	:$("#compensation_limit_flag").val() 			// 보상한도액 분류
							,selfPayFlag    			:$("#self_pay_flag").val() 						// 자기부담 분류
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									alert("저장되었습니다.");
									location.href = "suimRptBscDtl?suim_rpt_no="+$("#suimRptNo").val();
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}//function
				);//post				
			});
			
			
			
			/* 보고서 기본정보의 처리 담당자 변경 동작 호출 */
			$("#rptUserNoChangeBtn").click(function(){
				
				$.post("./suimRptUserNoEdite",
						{	
					 		topTeamId  	:"${rptOne.team_id}" 
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("불러오기를 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$("#rptUserNoChange").css("display","inline");
									$("#rptUserNoChangeBtn").css("display","none");
									$("#rptUserName").css("display","none");
									
									$("#rptUserNoChange").html("");
									
									$.each(data, function(index, entry) {
										$("#rptUserNoChange").append(
											"<option value='"+entry.user_no+"'>"+entry.user_name+"</option>"	
										);
									});
									
									$("#rptUserNoChange").val($("#rptUserNameHidden").val());
									$("#changeRptTopUserOkBtn").css("display","inline");
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						},"json"
				);//post	
			});
			
			/* 보고서 기본정보의 처리 담당자 변경 */ 
			$("#changeRptTopUserOkBtn").click(function(){
				
				if($("#rptUserNoChange").val() == null ){
					alert("결재자를 선택하세요.");
					$("#rptUserNoChange").focus();
					return;
				}
				
				$.post("./suimRptSantionNoEditeOk",
						{	
					 		 topUserNo  	:$("#rptUserNoChange").val()
					 		,suimRptNo   	:"${rptOne.suim_rpt_no}"  //
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									
									$("#rptUserNoChange").css("display","none");
									$("#rptUserNoChangeBtn").css("display","inline");
									$("#rptUserName").css("display","inline");
									
									$("#rptUserName").html($("#rptUserNoChange option:selected").html());
									
									$("#changeRptTopUserOkBtn").css("display","none");
									$("#rptUserNameHidden").val($("#rptUserNoChange option:selected").val());
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post 
			});
			
			//부서상세 구분 호출
			//getPtnrIdSubForm();
			//보험사 계약기간 호출
			//getPeriodFlagForm('S');
			
		});
		
		//부서상세 구분 값이 변경될 때 기간설정 폼을 새로 불러온다.
		function fnClickPtnrSub(){
			//보험사 변경시 설정 폼을 다시 불러온다.	(C:change)
			getPeriodFlagForm('C');
		}		
				
		//보험사 계약기간 구분 시작
		function getPeriodFlagForm( p_flag ){
			
			var ptnrIdVal = $("#ptnrId").val();
			var ptnrIdSubVal;
			
			if( p_flag == 'C' ){
				ptnrIdSubVal = $("input:radio[name='ptnrIdSub']:checked").val();
			}else{				
				ptnrIdSubVal = $("#ptnrIdSub").val();	
			}
			
			var periodFlagVal = $("#periodFlag").val();
			
			var param = {};
			param.ptnr_id = ptnrIdVal;
			param.ptnr_id_sub = ptnrIdSubVal;
			param.period_flag = periodFlagVal; 

			var url = "./getPeriodFlagInfo";
	        
	        $.ajax({
	            type: "POST",
	            url: url,
	            data: param,
	            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	            timeout: 20000,
	            dataType: "html", 
	            success: function(data){	            	
	            	$("#periodFlagForm").html(data);
	            },
	            error: function(e){
	                alert("네트웍 상태가 불안정합니다. 잠시 후 다시 시도해 주십시요.");
	            }
	        });
			
		}
		
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
		
		/* 단위 직접 입력부 보이기,안보이기 */
		function CompensationUnitInput(obj,id){
			
			if(obj == 2){
				//$("#"+id).css("display","inline-block");
				$("#"+id).show();
				
			}else{
				//$("#"+id).css("display","none");
				$("#"+id).hide();
			}	
			
		}
		
		/* 단위 직접 입력부 보이기,안보이기 */
		function selfPayUnitInput(obj,id){
			
			if(obj == 2){
				//$("#"+id).css("display","inline-block");
				$("#"+id).show();
				
			}else{
				//$("#"+id).css("display","none");
				$("#"+id).hide();
			}	
			
		}
		
		function fnVisibleSpeedOneStop(obj){
			//if (obj.value == 14){
			if (obj.value == 14 || obj.value == 15 || obj.value == 16 || obj.value == 17 || obj.value == 18 || obj.value == 19 ){
				$(".onlySpeedTr").show();
			}else{
				$(".onlySpeedTr").hide();
			}
		}
		
		
		//====================================================
		// 기준업무량 관련 스크립트 180110, by lds
		//====================================================
			
		var workloadValid = true;
		
		function fnShowWorkload(gubunRpt1){
			$(".workload_type_tr").hide();
			$("#workload_type_tr_"+gubunRpt1).show();
			
			$("input:radio[name='workload_type']").prop("checked",false);

			//기준업무량 코드가 있는 처리구분 선택 시, validation 값 세팅
			var workloadKind = $("#workloadKind").val().split(",");
			for ( var i in workloadKind ) {
				if ( workloadKind[i] == gubunRpt1 && "${rptOne.workloadUseAt}" == 1){
					workloadValid = false; 
					$("#workload_ea_tr").show();
					break;
				}else{
					workloadValid = true;
					$("#workload_ea_tr").hide();
				}
			}
			
			//부서상세 구분 표시
			if ( gubunRpt1 == 11 || gubunRpt1 == 12 || gubunRpt1 == 13 || gubunRpt1 == 2){
				getPtnrIdSubForm();
				getPeriodFlagForm();
				
				$("#ptnrSubDiv").show();
			}else{
				getPtnrIdSubFormDisable();
				getPeriodFlagFormDisable();
				
				$("#ptnrSubDiv").hide();
			}			
		} 
		
		function fnValidWorkload(col_cd1,col_cd2){
			/* 간혹 Ajax가 통신속도차이로 인해 workload값을 못가져오는 경우가 있어서 임시로 하드코딩으로 변경함 180327.lds
			*/
		    var workloadType = $("input:radio[name='workload_type']:checked").prop("id").substring(13);
		    var workloadTypeVal = $("input:radio[name='workload_type']:checked").val();
		    var retirePendingFlag = $("input:radio[name='retire_pending_flag']:checked").val();
			var workloadEa = 0;
			
			var param = {};
			param.col_cd1 = workloadType.split("_")[0];
			param.col_cd2 = workloadType.split("_")[1];
			
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
		        	workloadEa = data.workloadEa;
		        	
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
					$('body').spin();
		        },
		        complete: function(){
		            $('body').spin(false);
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
				case "14_99" : workloadEa = 0.3; break;		//퇴사자 종결 후 추가 청구(서면심사)
			}
			
			if (retirePendingFlag == 1 && workloadTypeVal != 99){
				workloadEa = workloadEa * 1.3;
				workloadEa = workloadEa.toFixed(3); //반올림 하여 소숫점 셋째 자리까지 표기
			}
			
			$("#workload_ea").val( workloadEa );
			
			workloadValid = true;
			*/
		}
		
	    function fnSelectTxtView(that){
	    	var selectVal = $(that).val();
			var txtId = $(that).prop("id").substring(7);
			var spanId = "span_"+$(that).prop("id").substring(7);
			
			if (selectVal == '99'){
				$("#"+spanId).css("display","inline-block");
			}else{
				$("#"+txtId).val(selectVal);
				$("#"+spanId).hide();
			}
	    }

	    function _initSelectFlag(){
			var selfPayFlag = "${rptOne.selfPayFlag}";
			var compensationLimitFlag = "${rptOne.compensationLimitFlag}";
			
			if (selfPayFlag == "1청구당"){
				$("#select_self_pay_flag").val("1청구당").prop("selected", true);
			}else if (selfPayFlag == "1사고당"){
				$("#select_self_pay_flag").val("1사고당").prop("selected", true);
			}else if (selfPayFlag == "1인당"){
				$("#select_self_pay_flag").val("1인당").prop("selected", true);
			}else{
				$("#select_self_pay_flag").val("99").prop("selected", true);
			}
			
			if (compensationLimitFlag == "1청구당"){
				$("#select_compensation_limit_flag").val("1청구당").prop("selected", true);
			}else if (compensationLimitFlag == "1사고당"){
				$("#select_compensation_limit_flag").val("1사고당").prop("selected", true);
			}else if (compensationLimitFlag == "1인당"){
				$("#select_compensation_limit_flag").val("1인당").prop("selected", true);
			}else{
				$("#select_compensation_limit_flag").val("99").prop("selected", true);
			}
			
			$("#select_compensation_limit_flag").change();
			$("#select_self_pay_flag").change();	
	    }
		
	    
	  	//부서상세 구분 시작
		function getPtnrIdSubForm(){
	  		
			var ptnrIdVal = $("#ptnrId").val();
			
			var param = {};
			param.ptnr_id = ptnrIdVal;

			var url = "./getPtnrIdSubInfo";
	        
	        $.ajax({
	            type: "POST",
	            url: url,
	            data: param,
	            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	            timeout: 20000,
	            dataType: "html", 
	            success: function(data){
	            	$("#ptnrIdSubForm").html(data);
	            	setPtnrIdSubFormChk();
	            },
	            error: function(e){
	                alert("네트웍 상태가 불안정합니다. 잠시 후 다시 시도해 주십시요.");
	            }
	        });			
		}
	  	
		//보험사 계약기간 구분 시작
		function getPeriodFlagFormDisable(){
			$("#periodFlagForm").html("");
		}
		//부서상세 구분 미표시
		function getPtnrIdSubFormDisable(){			
	        $("#ptnrIdSubForm").html("");	        
		}
	  	
		//부서상세 구분 체크
        function setPtnrIdSubFormChk(){        
        	var ptnrIdSubVal = ${rptOne.ptnr_id_sub};        	
        	//보험사 세부코드 설정
			$("input:radio[name='ptnrIdSub']:radio[value='"+ptnrIdSubVal+"']").prop('checked',true);
        }
	</script>
	
	<style>
		textarea{
			width: 100%;
			resize: none;
			box-sizing:border-box;
			-moz-box-sizing: border-box;
			-webkit-box-sizing: border-box;
		}
	</style>
</head>

<body>
	<!-- header --><!--2016.01.14.rjh.수정.교체.-->
	<div id="headerpop_mbr">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="40" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> 수임건 정보 수정</span></b></font>
			</div>
		</div>
	</div>
	<!-- //header -->

	<!-- center -->
	<div id ="container">
		<div class="contetnsPop">
			<div class="center_cnt">
				<div class="centercnt_bot1_5">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">보고서 기본정보</a></li>
								
							</ul>
						</div>

						<!-- 관련업체 멤버 정보 컨텐츠 탭 -->
						<div class="guestcnt6" style="display:block;">

						<div class= "tableStyle6">
							<input type="hidden" value = "${rptOne.suim_rpt_no}" id = "suimRptNo"/>
							<input type="hidden" value = "${rptOne.speedType}" id = "befSpeedType"/>
							<input type="hidden" value = "${rptOne.ptnr_id}" id = "ptnrId"/>
							<input type="hidden" value = "${rptOne.ptnr_id_sub}" id = "ptnrIdSub"/>
							<input type="hidden" value = "${rptOne.period_flag}" id = "periodFlag"/>
							
							
							<table align="center" style = "margin-top:10px; width:80% !important;"  >
								<colgroup>
									<col width="18%">
									<col width="35%">
									<col width="18%">
									<col width="29%">
								</colgroup>
									<tr>
										<td bgcolor="#efefef"><b>ㆍ접수번호</b></td>
										<td colspan="3">
											${rptOne.suim_accept_no}
										</td>
									</tr>
									<!-- <tr>
										<td bgcolor="#efefef"><b>ㆍ중간보고</b></td>
										<td colspan="3">
											<input type="checkbox" id= "midReportId"/>중간보고
										</td>
									</tr> -->
<!-- 									<tr> -->
<!-- 										<td bgcolor="#efefef"><b>ㆍ보험사기</b></td> -->
<!-- 										<td colspan="3"> -->
<!-- 											<input type="radio" name= "moralId" value = "0"/>조사중&nbsp;&nbsp; -->
<!-- 											<input type="radio" name= "moralId" value = "1"/>해당&nbsp;&nbsp; -->
<!-- 											<input type="radio" name= "moralId" value = "2"/>해당없음 -->
<!-- 										</td> -->
<!-- 									</tr> -->
<!-- 									<tr> -->
<!-- 										<td bgcolor="#efefef"><b>ㆍ민원</b></td> -->
<!-- 										<td colspan="3"> -->
<!-- 											<input type="radio" name= "complainId" value ="0"/>없음&nbsp;&nbsp; -->
<!-- 											<input type="radio" name= "complainId" value ="1"/>민원 예상&nbsp;&nbsp; -->
<!-- 											<input type="radio" name= "complainId" value ="2"/>민원 발생 -->
<!-- 										</td> -->
<!-- 									</tr> -->
									<tr>
										<td bgcolor="#efefef"><b>ㆍ처리팀</b></td>
										<td>${rptOne.team_name}</td>
										<td bgcolor="#efefef"><b>ㆍ처리 담당자</b></td>
										<td>
											${rptOne.user_name}
										</td>
									</tr>
									
									<tr>
										<td bgcolor="#efefef"><b>ㆍ보험사</b></td>
										<td>
											${rptOne.ptnr_name}
										</td>
										<td bgcolor="#efefef"><b>ㆍ보험사 담당자</b></td>
										<td>
											${rptOne.ptnr_mbr_nm}
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef"><b>ㆍ담당부서</b></td>
										<td colspan="3">
											<!-- 종결된 경우는 종결시점저장된 보험사 부서팀명으로 표시 by top3009 -->
											<c:choose>
												<c:when test="${rptOne.suimRptState eq 2}">
													${rptOne.close_ptnr_dept_nm}
													<c:if test="${rptOne.close_ptnr_tm2_nm ne ''}">(${rptOne.close_ptnr_tm2_nm})</c:if>
												</c:when>
												<c:otherwise>
													${rptOne.ptnr_dept_nm}
													<c:if test="${rptOne.ptnr_tm2_nm ne '' and rptOne.ptnr_tm2_nm ne null}">
														(${rptOne.ptnr_tm2_nm})
													</c:if>
												</c:otherwise>
											</c:choose>										
											<input type="hidden" id="auth24Flag" name="auth24Flag" value="${auth24Flag}"/>
											<input type="hidden" id="pendncyTrgetAt" name="pendncyTrgetAt" value="${rptOne.pendncyTrgetAt}"/>
										</td>										
									</tr>
									<!-- 수임등록 권한이 있는 직원만 부서상세 구분이 수정 가능함 by top3009 20230629 -->
									<c:if test="${mbrAuthVo_Session.mbr_pms_1 > 0 }">
										<tr id="ptnrSubDiv">
											<td bgcolor="#efefef"><b>ㆍ부서상세 구분</b></td>
											<td>
												<div id="ptnrIdSubForm"></div>
											</td>
											<td bgcolor="#efefef"><b>ㆍ장기/일반 구분</b></td>
											<td>
												<div id="periodFlagForm"></div>
											</td>
										</tr>
									</c:if>
									<c:if test="${auth24Flag > 0}">
									<tr>
					                	<td bgcolor="#efefef"><b>ㆍ필수업무프로세스</b></td>
					                    <td colspan="3">
											<input type="radio" id="pendncyTrgetAt" name = "pendncyTrgetAt" value = "1" <c:if test="${rptOne.pendncyTrgetAt eq '1'}"> checked</c:if> />&nbsp;대상
											&nbsp;
											<input type="radio" id="pendncyTrgetAt" name = "pendncyTrgetAt" value = "2" <c:if test="${rptOne.pendncyTrgetAt eq '2'}"> checked</c:if> />&nbsp;비대상
											&nbsp;
											<input type="radio" id="pendncyTrgetAt" name = "pendncyTrgetAt" value = "3" <c:if test="${rptOne.pendncyTrgetAt eq '3'}"> checked</c:if> />&nbsp;과정관리
											&nbsp;
											<input type="radio" id="pendncyTrgetAt" name = "pendncyTrgetAt" value = "4" <c:if test="${rptOne.pendncyTrgetAt eq '4'}"> checked</c:if> />&nbsp;현장+과정관리
					                    </td>
					                </tr>
					                </c:if>
					                
                                    <tr>
                                        <td bgcolor="#efefef"><b>ㆍ처리구분</b></td>
                                        <td colspan="3">
                                            <b>ㆍ배상</b> &nbsp;
                                            (
                                            <input type="radio" id="gubun_rpt1" name = "gubun_rpt1" onclick="fnVisibleSpeedOneStop(this);fnShowWorkload(11);" value = "11"/> 대인
                                            <input type="radio" id="gubun_rpt1" name = "gubun_rpt1" onclick="fnVisibleSpeedOneStop(this);fnShowWorkload(12);" value = "12"/> 대물
                                            <input type="radio" id="gubun_rpt1" name = "gubun_rpt1" onclick="fnVisibleSpeedOneStop(this);fnShowWorkload(13);" value = "13"/> 신종
                                            )
                                            &nbsp;&nbsp;&nbsp; <b>|</b>&nbsp;&nbsp;&nbsp;
                                            <input type="radio" id="gubun_rpt1" name = "gubun_rpt1" onclick="fnVisibleSpeedOneStop(this);fnShowWorkload(2);" value = "2"/> 재물
                                            <br/>
                                            <input type="radio" id="gubun_rpt1" name = "gubun_rpt1" onclick="fnVisibleSpeedOneStop(this);fnShowWorkload(14);" value = "14"/> 서면심사(메리츠/장기)
                                            &nbsp;&nbsp;&nbsp; <b>|</b>&nbsp;&nbsp;&nbsp;
                                            <!-- 추가 시작 by top3009 -->
                                            <input type="radio" id="gubun_rpt1" name = "gubun_rpt1" onclick="fnVisibleSpeedOneStop(this);fnShowWorkload(15);" value = "15"/> 서면심사(흥국)
                                            &nbsp;&nbsp;&nbsp; <b>|</b>&nbsp;&nbsp;&nbsp;
                                            <input type="radio" id="gubun_rpt1" name = "gubun_rpt1" onclick="fnVisibleSpeedOneStop(this);fnShowWorkload(16);" value = "16"/> 서면심사(롯데)
                                            &nbsp;&nbsp;&nbsp; <b>|</b>&nbsp;&nbsp;&nbsp;
                                            <input type="radio" id="gubun_rpt1" name = "gubun_rpt1" onclick="fnVisibleSpeedOneStop(this);fnShowWorkload(17);" value = "17"/> 서면심사(농협)
                                            <br/>
                                            <input type="radio" id="gubun_rpt1" name = "gubun_rpt1" onclick="fnVisibleSpeedOneStop(this);fnShowWorkload(18);" value = "18"/> 서면심사(메리츠/일반)
                                            &nbsp;&nbsp;&nbsp; <b>|</b>&nbsp;&nbsp;&nbsp;
                                            <input type="radio" id="gubun_rpt1" name = "gubun_rpt1" onclick="fnVisibleSpeedOneStop(this);fnShowWorkload(19);" value = "19"/> 서면심사(DB)
                                            <br/>
                                            <!-- 추가 끝 by top3009 -->
                                            <input type="radio" id="gubun_rpt1" name = "gubun_rpt1" onclick="fnVisibleSpeedOneStop(this);fnShowWorkload(3);" value = "3"/> 상해
                                            <input type="radio" id="gubun_rpt1" name = "gubun_rpt1" onclick="fnVisibleSpeedOneStop(this);fnShowWorkload(4);" value = "4"/> 질병
                                        </td>
                                    </tr>					                
									<!-- 
									 --
									 --  기준업무량 상세구분
									 --
									 -->
									<c:set var="bef_workload_type" value="0"/>
									<c:set var="workloadKind" value=""/> <!-- 기준업무량이 설정된 처리 구분 값들 ex)14,12,11,2, 식으로 저장됨 -->
									
									<c:if test="${rptOne.workloadUseAt == 1}">
										<c:forEach items="${workloadTypeList}" var="item" varStatus="status">
											<c:if test="${bef_workload_type != item.col_cd1}">
												<c:set var="curr_cnt" value="1"/>
												<c:set var="workloadKind" value="${item.col_cd1},${workloadKind}" />
												<tr class="workload_type_tr" id="workload_type_tr_${item.col_cd1}">
													<td bgcolor="#efefef" style="letter-spacing:-1px;"><b>ㆍ기준업무량 상세구분</b></td>
													<td colspan="3" id="workload_type${item.col_cd1}">
											</c:if>
											
											<input type="radio" name="workload_type" id="workload_type${item.col_cd1}_${item.col_cd2}" value="${item.col_cd2}"  
												   onclick="fnValidWorkload('${item.col_cd1}','${item.col_cd2}');"/> 
											<label for='workload_type${item.col_cd1}_${item.col_cd2}'>${item.col_val}</label>
											<c:if test="${curr_cnt == 4}">
												<br/>
												<c:set var="curr_cnt" value="0"/>
											</c:if>
											
											<c:if test="${item.col_cd1 == workloadTypeList[status.count].col_cd1 and curr_cnt != 4 and curr_cnt != 0}">
												<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>	
											</c:if>
												
											<c:if test="${item.col_cd1 != workloadTypeList[status.count].col_cd1}">
													</td>
												</tr>
											</c:if>
											
											<c:set var="curr_cnt" value="${curr_cnt+1}"/>
											<c:set var="bef_workload_type" value="${item.col_cd1}"/>
										</c:forEach>
										
										<tr class="workload_ea_tr" id="workload_ea_tr" style="display:none;" >
											<td bgcolor="#efefef" style="letter-spacing:-1px;"><b>ㆍ기준업무량 종결건수</b></td>
											<td>
												<input type="text" id="workload_ea" value="${rptOne.workloadEa}" style="ime-mode:active;width: 20%;" disabled="disabled"/>
											</td>
											<td bgcolor="#efefef"><b>ㆍ퇴사자(휴직자)<br/>&nbsp;&nbsp;&nbsp;미결 내첩여부</b></td>
											<td>
							                    <input type="radio" id="retire_pending_flag0" name="retire_pending_flag" value="0" onclick="fnValidWorkload();" <c:if test="${rptOne.retirePendingFlag == 0}">checked</c:if>><label for="retire_pending_flag0"> 해당없음 </label>&nbsp;&nbsp;
												<input type="radio" id="retire_pending_flag1" name="retire_pending_flag" value="1" onclick="fnValidWorkload();" <c:if test="${rptOne.retirePendingFlag == 1}">checked</c:if>><label for="retire_pending_flag1"> 해당</label>												
											</td>
										</tr>
									</c:if>
									
									<c:if test="${rptOne.report_type eq 3 or rptOne.report_type eq 4}">
										<tr>
											<td bgcolor="#efefef"><b>ㆍ지정건 구분</b></td>
											<td>
												<input type="radio" id="ptnrAssignGubun1" name="ptnrAssignGubun" value = "1" /><label for="ptnrAssignGubun1">&nbsp;지정</label>
												<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
												<input type="radio" id="ptnrAssignGubun0" name="ptnrAssignGubun" value = "0"/><label for="ptnrAssignGubun0">&nbsp;비지정</label>
											</td>
											<td bgcolor="#efefef"><b>ㆍ보험사 상세 구분</b></td>
											<td>
												<input type="radio" id="ptnrDetailGubun1" name="ptnrDetailGubun" value = "1" /><label for="ptnrDetailGubun1">&nbsp;원수사</label>
												<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
												<input type="radio" id="ptnrDetailGubun2" name="ptnrDetailGubun" value = "2"/><label for="ptnrDetailGubun2">&nbsp;자회사</label>
												<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
												<input type="radio" id="ptnrDetailGubun3" name="ptnrDetailGubun" value = "3"/><label for="ptnrDetailGubun3">&nbsp;외주사</label>											
											</td>																				
										</tr>
									</c:if>									
											                
									<tr>
										<td bgcolor="#efefef"><b>ㆍ사고번호</b></td>
										<td colspan="3">
											<input type="text" id = "accId" value = "${rptOne.accident_no}" style="ime-mode:active;width: 60%;" maxlength="200"/>
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef"><b>ㆍ증권번호</b></td>
										<td colspan="3">
											<input type="text" id = "polNoId" value = "${rptOne.policy_no}" style="ime-mode:active;width: 60%;"/>
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef"><b>ㆍ보험종목</b></td>
										<td colspan="3">
											<input type="text" id = "insNmId" value = "${rptOne.insurance_nm}" style="ime-mode:active;width: 60%;"/>
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef"><b>ㆍ보험기간</b></td>
										<td colspan="3">
											<input class="calendar" type="text" id="sdate" value="" style="width: 20%;"/> ~
											<input class="calendar" type="text" id="edate" value="" style="width: 20%;"/>
											<input type="hidden" id = "insuTerm" />
											<%-- <input type="text" id = "insuTerm" value = "${rptOne.insuTerm}" style="ime-mode:active;width: 60%;" maxlength="120"/> --%>
											<!-- 보험기간 달력으로 변경 -->
											
										</td>
									</tr>
									
									<tr>
										<td bgcolor="#efefef"><b>ㆍ보상한도액</b></td>
										<td colspan="3">
											<select id="amtCompensationLimitSelect" onchange="CompensationUnitInput(this.value, 'CompensationUnitSpan');">
												<option value="0" <c:if test="${rptOne.amtCompensationLimitUnit eq '￦'}"> selected="selected" </c:if>>￦</option>
												<option value="1" <c:if test="${rptOne.amtCompensationLimitUnit eq '$'}"> selected="selected" </c:if>>$</option>
												<option value="2" <c:if test="${rptOne.amtCompensationLimitUnit ne null && rptOne.amtCompensationLimitUnit ne '' && rptOne.amtCompensationLimitUnit ne '￦' && rptOne.amtCompensationLimitUnit ne '$'}"> selected="selected" </c:if>>직접입력</option>
											</select>
											<c:choose>
												<c:when test="${rptOne.amtCompensationLimitUnit == null || rptOne.amtCompensationLimitUnit == '' || rptOne.amtCompensationLimitUnit == '￦' || rptOne.amtCompensationLimitUnit == '$'}">
													<span id = "CompensationUnitSpan" style="display:none;"> &nbsp;<input type="text" size="7" id="CompensationUnit" value="" maxlength="5"/></span>
												</c:when>
												<c:otherwise>
													<span id = "CompensationUnitSpan"> &nbsp;<input type="text" size="7" id="CompensationUnit" value="${rptOne.amtCompensationLimitUnit}" maxlength="5"/></span>
												</c:otherwise>
											</c:choose>
											
											<input type="text" size="12" id = "amtCompensationLimit"
													 VALUE="<fmt:formatNumber value="${rptOne.amtCompensationLimit}" pattern="###,###,##0.##"/>"
													 ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;" />
													 
											<select id="select_compensation_limit_flag" onchange="fnSelectTxtView(this);">
												<option value="1사고당">1사고당</option>
												<option value="1청구당">1청구당</option>
												<option value="1인당">1인당</option>
												<option value="99">직접입력</option>
											</select>
											<span id = "span_compensation_limit_flag"  style="display:none;  padding-left: 5px;">
												ㆍ직접입력 : <input type="text" size="12" id = "compensation_limit_flag" value="${rptOne.compensationLimitFlag}"/>
											</span>
										</td>
									</tr>
									
									<tr>
										<td bgcolor="#efefef"><b>ㆍ자기부담금</b></td>
										<td colspan="3">
											<select id="amtSelfSelect" onchange="fnSelectTxtView(this);">
												<option value="0" <c:if test="${rptOne.amtSelfPayUnit eq '￦'}"> selected="selected" </c:if>>￦</option>
												<option value="1" <c:if test="${rptOne.amtSelfPayUnit eq '$'}"> selected="selected" </c:if>>$</option>
												<option value="2" <c:if test="${rptOne.amtSelfPayUnit ne null && rptOne.amtSelfPayUnit ne '' && rptOne.amtSelfPayUnit ne '￦' && rptOne.amtSelfPayUnit ne '$'}"> selected="selected" </c:if>>직접입력</option>
											</select>
											<c:choose>
												<c:when test="${rptOne.amtSelfPayUnit == null || rptOne.amtSelfPayUnit == '' || rptOne.amtSelfPayUnit == '￦' || rptOne.amtSelfPayUnit == '$'}">
													<span id = "selfPayUnitSpan" style="display:none;"> &nbsp;<input type="text" size="7" id="selfPayUnit" value="" maxlength="5"/></span>
												</c:when>
												<c:otherwise>
													<span id = "selfPayUnitSpan"> &nbsp;<input type="text" size="7" id="selfPayUnit" value="${rptOne.amtSelfPayUnit}" maxlength="5"/></span>
												</c:otherwise>
											</c:choose>
											
											<span id = "selfPayUnitSpan" style="display:none;"> &nbsp;<input type="text" size="20" id="selfPayUnit"/></span>
											
											<input type="text" size="12" id = "amtSelfPay"
													 VALUE="<fmt:formatNumber value="${rptOne.amtSelfPay}" pattern="###,###,##0.##"/>"
													 ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;" />
											
											<select id="select_self_pay_flag" onchange="fnSelectTxtView(this);">
												<option <c:if test='${rptOne.selfPayFlag eq "1사고당"}'>selected</c:if> value="1사고당">1사고당</option>
												<option <c:if test='${rptOne.selfPayFlag eq "1청구당"}'>selected</c:if> value="1청구당">1청구당</option>
												<option <c:if test='${rptOne.selfPayFlag eq "1인당"}'>selected</c:if> value="1인당">1인당</option>
												<option value="99">직접입력</option>
											</select>
											<span id="span_self_pay_flag" style="display:none;  padding-left: 5px;">
												ㆍ직접입력 : <input type="text" size="12" id="self_pay_flag" value="${rptOne.selfPayFlag}" />
											</span>
										</td>
									</tr>
									
									<tr>
										<td bgcolor="#efefef"><b>ㆍ보험조건</b></td>
										<td colspan="3">
											<input type="text" id="insu_condition" value = "${rptOne.insu_condition}" style="width: 60%;" maxlength="200"/>
										</td>
									</tr>
									
                                    <tr class="onlySpeedTr" style="display: none;">
                                        <td bgcolor="#efefef"><b>ㆍOne Stop 체크</b></td>
                                        <td>
                                        	<input  type="checkbox" id="chkSpeedOnestop"  name="chkSpeedOnestop" value="1" />
                                        </td>    
                                   		<td bgcolor="#efefef"><b>ㆍ사고 유형</b></td>
										<td>
											<select id="speedTypeList"  <c:if test="${rptOne.suimRptState eq '2'}">disabled="disabled"</c:if> >
													<option value="0" <c:if test="${0 ==  rptOne.speedType}">selected</c:if>>스피드아님</option>
<%-- 												<c:forEach items="${speedCodeList}" var="speedCodeList" varStatus="codeListStatus"> --%>
<%-- 													<option value="1" <c:if test="${1 ==  rptOne.speedType}">selected</c:if>>간이</option> --%>
													<option value="11" <c:if test="${11 ==  rptOne.speedType || 1 ==  rptOne.speedType}">selected</c:if>>간이(타사중복)</option>
													<option value="12" <c:if test="${12 ==  rptOne.speedType}">selected</c:if>>간이(구내치료비)</option>
													<option value="13" <c:if test="${13 ==  rptOne.speedType}">selected</c:if>>간이(홀인원)</option>
													<option value="2" <c:if test="${2 ==  rptOne.speedType}">selected</c:if>>대인</option>
													<option value="3" <c:if test="${3 ==  rptOne.speedType}">selected</c:if>>대물</option>
<%-- 													<option value="4" <c:if test="${4 ==  rptOne.speedType}">selected</c:if>>재물</option> --%>
													<option value="41" <c:if test="${41 ==  rptOne.speedType || 4 ==  rptOne.speedType}">selected</c:if>>재물(6대가전)</option>
													<option value="42" <c:if test="${42 ==  rptOne.speedType}">selected</c:if>>재물(도난)</option>
													<option value="43" <c:if test="${43 ==  rptOne.speedType}">selected</c:if>>재물(골프용품)</option>
													<option value="44" <c:if test="${44 ==  rptOne.speedType}">selected</c:if>>재물(풍수재)</option>
													<option value="45" <c:if test="${45 ==  rptOne.speedType}">selected</c:if>>재물(여행자)</option>
													<option value="46" <c:if test="${46 ==  rptOne.speedType}">selected</c:if>>재물(위로금)</option>
													<option value="47" <c:if test="${47 ==  rptOne.speedType}">selected</c:if>>재물(일반)</option>
													<option value="5" <c:if test="${5 ==  rptOne.speedType}">selected</c:if>>대인+대물</option>
													<option value="7" <c:if test="${7 ==  rptOne.speedType}">selected</c:if>>면책</option>
													<option value="6" <c:if test="${6 ==  rptOne.speedType}">selected</c:if>>임의종결</option>
<%-- 												</c:forEach> --%>
											</select>
										</td>      
                                    </tr>
									<tr>
										<td class="td" bgcolor="#efefef"><b>ㆍ계약자</b></td>
										<td>
											<input type="text" id = "polNmId" value = "${rptOne.policyholder_nm}" style="ime-mode:active;width: 90%;"/>
										</td>
										<td bgcolor="#efefef"><b>ㆍ연락처</b></td>
										<td>
											<input type="text" size="5" maxlength="4" id = "poltel_1" value = "${policyholder_tel_1}" ONKEYDOWN="javascript:onlyNumberFunc2(this);" style="IME-MODE: disabled;"/> -
											<input type="text" size="5" maxlength="4" id = "poltel_2" value = "${policyholder_tel_2}" ONKEYDOWN="javascript:onlyNumberFunc2(this);" style="IME-MODE: disabled;"/> -
											<input type="text" size="5" maxlength="4" id = "poltel_3" value = "${policyholder_tel_3}" ONKEYDOWN="javascript:onlyNumberFunc2(this);" style="IME-MODE: disabled;"/> 
										</td>
									</tr>
<%--
									<tr>
										<td bgcolor="#efefef"><b>ㆍ주민번호</b></td>
										<td>
											<input type="text" size="10" maxlength="6" id="polSsn1Id" value = "${polSsn1Id}" ONKEYDOWN="javascript:onlyNumberFunc2(this);" style="IME-MODE: disabled;"/>-
											<input type="text" size="10" maxlength="7" id="polSsn2Id" value = "${polSsn2Id}" ONKEYDOWN="javascript:onlyNumberFunc2(this);" style="IME-MODE: disabled;"/>
										</td>
									</tr>
--%>

									<tr>
										<td class="td" bgcolor="#efefef"><b>ㆍ피보험자</b></td>
										<td>
											<input type="text" id = "benNmId" value = "${rptOne.beneficiary_nm}" style="ime-mode:active;width: 90%;"/>
										</td>
										<td bgcolor="#efefef"><b>ㆍ연락처</b></td>
										<td>
											<input type="text" size="5" maxlength="4" id = "bentel_1" value = "${beneficiary_tel_1}" ONKEYDOWN="javascript:onlyNumberFunc2(this);" style="IME-MODE: disabled;"/> -
											<input type="text" size="5" maxlength="4" id = "bentel_2" value = "${beneficiary_tel_2}" ONKEYDOWN="javascript:onlyNumberFunc2(this);" style="IME-MODE: disabled;"/> -
											<input type="text" size="5" maxlength="4" id = "bentel_3" value = "${beneficiary_tel_3}" ONKEYDOWN="javascript:onlyNumberFunc2(this);" style="IME-MODE: disabled;"/> 
										</td>
									</tr>
<%--
									<tr>
										<td bgcolor="#efefef"><b>ㆍ주민번호</b></td>
										<td>
											<input type="text" size="10" maxlength="6" id="benSsn1Id" value="${benSsn1Id }" ONKEYDOWN="javascript:onlyNumberFunc2(this);" style="IME-MODE: disabled;"/>-
											<input type="text" size="10" maxlength="7" id="benSsn2Id" value ="${benSsn2Id }" ONKEYDOWN="javascript:onlyNumberFunc2(this);" style="IME-MODE: disabled;"/>
										</td>
									</tr>
--%>

									<tr>
										<td bgcolor="#efefef"><b>ㆍ피해자/물</b></td>
										<td>
											<input type="text" id= "dmgNmId" value="${rptOne.damaged_nm}" style="ime-mode:active;width: 90%;"/>
										</td>
										<td bgcolor="#efefef"><b>ㆍ연락처</b></td>
										<td>
											<input type="text" size="5" maxlength="4" id = "dmgtel_1" value = "${damaged_tel_1}" ONKEYDOWN="javascript:onlyNumberFunc2(this);"/> -
											<input type="text" size="5" maxlength="4" id = "dmgtel_2" value = "${damaged_tel_2}" ONKEYDOWN="javascript:onlyNumberFunc2(this);"/> -
											<input type="text" size="5" maxlength="4" id = "dmgtel_3" value = "${damaged_tel_3}" ONKEYDOWN="javascript:onlyNumberFunc2(this);"/>
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef"><b>ㆍ사고일</b></td>
										<td>
											<input type="text" class="classCalendar" size="15" id="sago_time" name="sago_time" value="${rptOne.accident_date}" maxlength="10" />
										</td>
										<td bgcolor="#efefef"><b>ㆍ수임일</b></td>
										<td>
											<c:choose>
												<c:when test="${mbrAuthVo_Session.mbr_pms_1 == 1}">
													<input type="text" class="classCalendar" size="15" id="suim_time" name="suim_time" value="${rptOne.reg_date}" maxlength="10" />
												</c:when>
												<c:otherwise>
													<input type="text" size="15" id="suim_time" name="suim_time" value="${rptOne.reg_date}" maxlength="10" disabled="disabled" />
												</c:otherwise>
											</c:choose>
											
										</td>
									</tr>
									<%-- 일반건 전환일 시작 (보험사가 메리츠, 현대해상 인 경우만 보이도록 한다.)--%>									
									<c:if test="${rptOne.ptnr_id eq 16 or rptOne.ptnr_id eq 14}">
									<tr>
										<td bgcolor="#efefef"><b>ㆍ일반전환일</b></td>
										<td colspan="3">
											<c:choose>
												<c:when test="${mbrAuthVo_Session.mbr_pms_1 == 1}">
													<input type="text" class="classCalendar" size="15" id="trans_time" name="trans_time" value="${rptOne.trans_date}" maxlength="10" />
												</c:when>
												<c:otherwise>
													<input type="text" size="15" id="trans_time" name="trans_time" value="${rptOne.trans_date}" maxlength="10" disabled="disabled" />
												</c:otherwise>
											</c:choose>																						
										</td>
									</tr>	
									</c:if>
									<%--
									<tr>
										<td bgcolor="#efefef"><b>ㆍ추정손해액</b></td>
										<td>
											<input type="text" name="amtEstId" id="amtEstId"
												value="<fmt:formatNumber value="${rptOne.amt_estimated_damage}" pattern="###,###,##0.##"/>"
												ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;" /> 원
										</td>
										<td bgcolor="#efefef"><b>ㆍ추정수수료</b></td>
										<td>
											<input type="text" name="comEstId" id="comEstId"
												value="<fmt:formatNumber value="${rptOne.commission_estimated}" pattern="###,###,##0.##"/>"
												ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;" /> 원
										</td>
									</tr>
									--%>
									<tr>
										<td bgcolor="#efefef"><b>ㆍ사고장소</b></td>
										<td colspan="3" >
											우편번호 : 
											<input type="text" name="" id="postcode_rptUdt" size="10" readonly style="background-color:lightgrey;" value ="${rptOne.investigate_postcode}"/>													  
											<input type="button" id="postCodeBtnRptUdt" value="우편번호 찾기">
											<input type="text" name="" id="addr_rptUdt_1"  size="40" readonly style="background-color:lightgrey;" value="${rptOne.investigate_addr1}"/>
											<!-- <input type="hidden" name="" id="addr_rptUdt_2" value=""/> -->
											<div style="height:3px;"></div>											
										    <input type="text" name="" id="addr_rptUdt_2"  size="77" value="${rptOne.investigate_addr2}"/>
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef"><b>ㆍ사고내용</b></td>
										<td colspan="3">
											<textarea rows="5" cols="88" id= "accFactsId" style="ime-mode:active;">${rptOne.accident_facts}</textarea>
										</td>
									</tr>

									<c:if test="${rptOne.report_type eq 3 or rptOne.report_type eq 4}">
										<%-- <tr>
											<td bgcolor="#efefef"><b>ㆍ결재자</b></td>
											<td colspan="3">
												<img style= "cursor:pointer;" id = "rptUserNoChangeBtn" src="./resources/ls_img/btn_edit_s.gif"/>
												<select id = "rptUserNoChange" style="display:none; ">
													
												</select>
												<c:if test="${rptOne.suimRptAprvUserName ne ''}">
													<span id = "rptUserName">${rptOne.suimRptAprvUserName}</span>
													<input type="hidden" id = "rptUserNameHidden" value = "${rptOne.suimRptAprvUserNo}"/>
												</c:if>
												<img id = "changeRptTopUserOkBtn" src="./resources/ls_img/btn_check_s.gif" title="담당자 변경" style="display:none; cursor:pointer;"/>
											</td>
										</tr> --%>
										<tr>
											<td bgcolor="#efefef"><b>ㆍ보고서 양식</b></td>
											<td colspan="3">
												<input type="radio" name = "gubun_rpt2" value = "1"/> 일반
												<input type="radio" name = "gubun_rpt2" value = "1001"/> 단순
												<input type="radio" name = "gubun_rpt2" value = "3001"/> 건설공제
												
												<input type="radio" name = "gubun_rpt2" value = "6"/> 농협
												<input type="radio" name = "gubun_rpt2" value = "16"/> 메리츠
												<input type="radio" name = "gubun_rpt2" value = "9"/> 롯데
												&nbsp;&nbsp;&nbsp; <b>|</b>&nbsp;&nbsp;&nbsp;
												&nbsp;&nbsp;
												<b>흥국</b> : 
												<input type="radio" name = "gubun_rpt2" value = "17"/> 일반
												<input type="radio" name = "gubun_rpt2" value = "1700"/> 의료
											</td>
										</tr>
									</c:if>
							</table>
						</div>
						<br>
						<p align="center">
							<img id="edite" src="./resources/ls_img/btn_ok.gif" alt="저장" style ="cursor:pointer" />
							<img id="cancel" src="./resources/ls_img/btn_cancel.gif" alt="취소" style ="cursor:pointer" />
							
							<input type="hidden" id="workloadKind" name="workloadKind" value="${workloadKind}" /> <!-- 기준업무량 종류 -->
						</p>
						<%-- <a style="cursor:pointer;" onclick="suimFldRptPop(<c:out value='${rptOne.getSuim_rpt_no()}'/>)">
						임시버튼 생성</a> --%>
						</div>
					</div><!-- //guest -->
				</div><!-- //bot1-3 -->
			</div>
		</div>
	</div>
	<!--//center -->

	<!-- footer -->
	<%--<c:import url="../top_main/top_pop_footer.jsp"></c:import>--%>
	<!-- //footer -->


</body>