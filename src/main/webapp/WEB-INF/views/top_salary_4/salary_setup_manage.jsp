<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
<script src="./resources/ne_js/calendar.js?v=20170321111520"></script><!-- calendar -->
<script src="./resources/ne_js/ne_number.js"></script>
<script>
	$(document).ready(function () {
		fnSalarySearch();
	});
	
	//기본급 정보 삭제
	function doSalarySetupDelete( p_skey, p_title ){
		
		if( confirm( "등록명 : ' "+p_title+" ' 을(를) 삭제하시겠습니까?" ) ){			
			$("#skey_val").val( p_skey );
			fnSalaryAction( 'D' );
		}
	}
	
	//기본급 정보 수정
	function doSalarySetupMod( p_skey ){
		
		var sUrl = "get_salary_setup_info";
		
		var param = {};
		param.skey = p_skey;			
		
		$.ajax({
	        type: "POST",
	        url: sUrl,
	        data: param,		         
	        dataType: "JSON", 
	        success: function(data){	        		
        		//alert(JSON.stringify(data));
        		//alert("data="+data.user_no);
        		
        		//수정폼 설정
        		$("#skey_val").val(data.skey);        		
        		$("#salary_subject").val(data.salary_subject);
        		$("#term_sdate").val(data.term_sdate_fmt);
        		$("#term_edate").val(data.term_edate_fmt);
        		$("#intern_pay").val(data.intern_pay);
        		$("#intern_pay_1").val(data.intern_pay_1);
        		$("#intern_pay_2").val(data.intern_pay_2);
        		$("#intern_pay_3").val(data.intern_pay_3);        		
        		$("#career_pay_1").val(data.career_pay_1);
        		$("#career_pay_2").val(data.career_pay_2);
        		$("#career_pay_3").val(data.career_pay_3);
        		$("#career_pay_4").val(data.career_pay_4);        		
        		$("#conti_pay_1").val(data.conti_pay_1);
        		$("#conti_pay_2").val(data.conti_pay_2);
        		$("#conti_pay_3").val(data.conti_pay_3);
        		$("#conti_pay_4").val(data.conti_pay_4);
        		$("#manager_pay").val(data.manager_pay);
        		$("#max_pay").val(data.max_pay);        		
        		$("#is_use").val(data.is_use);        		
        		
    			$("#salary-action-dialog").dialog({
    				height: 550,
    				width: 800,
    				closeOnEscape : true,
    				draggable : true,
    				appendTo : "#salaryActionFrm",
    				title: "기본급 설정 수정",
    				buttons:{
    					"수정" : function(){
    						var action = fnSalaryAction('U');		//수정
    						if (action){
    							$(this).dialog("close");
    						}
    					},
    					"취소" : function(){
    						$(this).dialog("close");
    					}
    				},
    				modal: true,
    				overlay:{ opacity: 0., background: '#000000'}
    			});
    			
    			$("#is_use").select2({
    				dropdownParent: $("#salary-action-dialog")	
    			});
    			
	        },
	        error: function(e){
	            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	        }
	    });
	}
	
	//기본급 정보보기
	function doSalarySetupInfoView( p_skey ){
		
		var sUrl = "salary_setup_manage_modal_detail";
		
		var skeyVal = p_skey;
		var param = {};
		param.skey = skeyVal;		
		
		$.ajax({
			type: "POST",
			url: sUrl,
			data: param,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			timeout: 20000,
			dataType: "HTML", 
			success: function(data){				
				$("#salary-detail-dialog").html();				
				$("#salary-detail-dialog").html(data);
					$("#salary-detail-dialog").dialog({
						height: 550,
						width: 800,
						closeOnEscape : true,
						draggable : true,
						title: "기본급 설정정보 상세",
						buttons:{							
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
	
	//기본급 등록
	function salarySetupAdd(){
		
		//등록폼 초기화
		$("#salary_subject").val('');
		$("#term_sdate").val('');
		$("#term_edate").val('');
		$("#intern_pay").val(0);
		$("#intern_pay_1").val(0);
		$("#intern_pay_2").val(0);
		$("#intern_pay_3").val(0);		
		$("#career_pay_1").val(0);
		$("#career_pay_2").val(0);
		$("#career_pay_3").val(0);
		$("#career_pay_4").val(0);
		$("#conti_pay_1").val(0);
		$("#conti_pay_2").val(0);
		$("#conti_pay_3").val(0);
		$("#conti_pay_4").val(0);
		$("#manager_pay").val(0);
		$("#max_pay").val(0);
		$("#is_use option:eq(0)").prop('selected', true);
		
		$("#salary-action-dialog").dialog({
			height: 550,
			width: 800,
			closeOnEscape : true,
			draggable : true,
			appendTo : "#salaryActionFrm",
			title: "기본급 설정 등록",
			buttons:{
				"등록" : function(){
					var action = fnSalaryAction('I');		//등록
					if (action){
						$(this).dialog("close");
					}
				},
				"취소" : function(){
					$(this).dialog("close");
				}
			},
			modal: true,
			overlay:{ opacity: 0., background: '#000000'}
		});
		
		$("#is_use").select2({
			dropdownParent: $("#salary-action-dialog")	
		});
	}
	
	function fnSalaryAction( action ){
		
		var sUrl = "salary_action";
		
		var skeyVal = $("#skey_val").val();
		var salarySubjectVal = $("#salary_subject").val();
		var questionVal = $("#quiz_question").val();
		var termSdateVal = $("#term_sdate").val();
		var termEdateVal = $("#term_edate").val();
		var internPayVal = $("#intern_pay").val().replace(/,/gi,"");		
		var internPay1Val = $("#intern_pay_1").val().replace(/,/gi,"");
		var internPay2Val = $("#intern_pay_2").val().replace(/,/gi,"");
		var internPay3Val = $("#intern_pay_3").val().replace(/,/gi,"");
		var careerPay1Val = $("#career_pay_1").val().replace(/,/gi,"");
		var careerPay2Val = $("#career_pay_2").val().replace(/,/gi,"");
		var careerPay3Val = $("#career_pay_3").val().replace(/,/gi,"");
		var careerPay4Val = $("#career_pay_4").val().replace(/,/gi,"");
		var contiPay1Val = $("#conti_pay_1").val().replace(/,/gi,"");
		var contiPay2Val = $("#conti_pay_2").val().replace(/,/gi,"");
		var contiPay3Val = $("#conti_pay_3").val().replace(/,/gi,"");
		var contiPay4Val = $("#conti_pay_4").val().replace(/,/gi,"");
		var managerPayVal = $("#manager_pay").val().replace(/,/gi,"");
		var maxPayVal = $("#max_pay").val().replace(/,/gi,"");
		var isUseVal = $("#is_use").val();		
		
		var param = {};
		
		param.action = action;
		param.skey = skeyVal;
		param.salary_subject = salarySubjectVal;
		param.term_sdate = termSdateVal;
		param.term_edate = termEdateVal;
		param.intern_pay = internPayVal;
		param.intern_pay_1 = internPay1Val;
		param.intern_pay_2	 = internPay2Val;
		param.intern_pay_3 = internPay3Val;
		param.career_pay_1 = careerPay1Val;
		param.career_pay_2 = careerPay2Val;
		param.career_pay_3 = careerPay3Val;
		param.career_pay_4 = careerPay4Val;
		param.conti_pay_1 = contiPay1Val;
		param.conti_pay_2 = contiPay2Val;
		param.conti_pay_3 = contiPay3Val;
		param.conti_pay_4 = contiPay4Val;
		param.manager_pay = managerPayVal;
		param.max_pay = maxPayVal;
		param.is_use = isUseVal;
		
		//등록 또는 수정
		if( action == 'I' || action == 'U' ){
			
			if( salarySubjectVal == '' ){
				alert( "등록 명을 입력해주세요." );
				$("#salary_subject").focus();
				return;
			}
			
			if( termSdateVal == '' ){
				alert( "적용 시작일자를 입력해주세요." );
				$("#term_sdate").focus();
				return;
			}
			
			if( termEdateVal == '' ){
				alert( "적용 종료일자를 입력해주세요." );
				$("#term_edate").focus();
				return;
			}
			
			//종료날짜가 시작날짜보다 이전일자인지 체크한다.
			if( dateChk( termSdateVal,  termEdateVal) ){
				alert('적용 시작일자가 종료일자보다 작아야합니다. ');
				$("#term_sdate").focus();
				return;
			}
			
			if( internPayVal == '' || internPayVal == 0 ){
				alert( "수습기간 기본급을 입력해주세요." );
				$("#intern_pay").focus();
				return;
			}
			
			if( careerPay1Val == '' || careerPay1Val == 0 ){
				alert( "경력기간 1년미만 기본급을 입력해주세요." );
				$("#career_pay_1").focus();
				return;
			}
			
			if( careerPay2Val == '' || careerPay2Val == 0 ){
				alert( "경력기간 2년차 기본급을 입력해주세요." );
				$("#career_pay_2").focus();
				return;
			}
			
			if( careerPay3Val == '' || careerPay3Val == 0 ){
				alert( "경력기간 3년차 기본급을 입력해주세요." );
				$("#career_pay_3").focus();
				return;
			}
			
			if( careerPay4Val == '' || careerPay4Val == 0 ){
				alert( "경력기간 4년차 이상 기본급을 입력해주세요." );
				$("#career_pay_4").focus();
				return;
			}
			
			if( contiPay1Val == '' || contiPay1Val == 0 ){
				alert( "근속기간 1년 이상 기본급을 입력해주세요." );
				$("#conti_pay_1").focus();
				return;
			}
			
			if( contiPay2Val == '' || contiPay2Val == 0 ){
				alert( "근속기간 2년 이상 기본급을 입력해주세요." );
				$("#conti_pay_2").focus();
				return;
			}
			
			if( contiPay3Val == '' || contiPay3Val == 0 ){
				alert( "근속기간 3년 이상 기본급을 입력해주세요." );
				$("#conti_pay_3").focus();
				return;
			}
			
			if( contiPay4Val == '' || contiPay4Val == 0 ){
				alert( "근속기간 4년 이상 기본급을 입력해주세요." );
				$("#conti_pay_4").focus();
				return;
			}
			
			if( managerPayVal == '' || managerPayVal == 0 ){
				alert( "팀장수당을 입력해주세요." );
				$("#manager_pay").focus();
				return;
			}
			
			if( maxPayVal == '' || maxPayVal == 0 ){
				alert( "기본급 최대 허용 액을 입력해주세요." );
				$("#max_pay").focus();
				return;
			}
			
			if( careerPay1Val > maxPayVal ){
				alert( "기본급 최대 허용 액은 경력기간 기본급보다는 커야 합니다." );
				$("#max_pay").focus();
				return;
			}
		}
		
		$.ajax({
			type: "POST",
   	        url: sUrl,
   	        data: param,
   	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
   	        timeout: 20000,
   	        async: false,
   	        dataType: "html", 
   	        success: function(data){   	        	
   	        	if (data == 1){
					alert("기본급 설정 정보를 등록하였습니다.");
					$("#salary-action-dialog").dialog("close");
					fnSalarySearch();
   	        	}else if(data == 2){
   	        		alert("기본급 설정 정보를 수정하였습니다.");
   	        		$("#salary-action-dialog").dialog("close");
   	        		fnSalarySearch();
   	        	}else if(data == 9){
   	        		alert("기본급 설정 정보를 삭제하였습니다.");   	        		
   	        		fnSalarySearch();
   	        	}else{
   	        		alert("기본급 설정 정보 작업을 실패하였습니다.");
   	        	}
   	        	
   	        },
			error: function(e){
			    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
			}
		});
		
	}
	
	function fnSalarySearch(){
		
		var param = {};
		
		var sUrl = "./getSalarySetupInfoList";		//개별목록 가져오기
		
		$.ajax({
    		type: "POST",
    		url: sUrl,
    		data: param,
    		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    		dataType: "html",
    		timeout: 20000,
    		success: function(data){
    			$("#salarySetupInfoList").html(data);    			
    		},            		
    		error: function (request, status, error) {
    			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
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
</script>
<!-- 테스트 등록 폼시작 -->

<form id="salaryActionFrm">
	<input type="hidden" id="skey_val" name="skey_val"/>		
	<div id="salary-action-dialog" title="기본급 설정 등록" style="font-size: 15px;display:none;" align="center">
		<br/>
		<div class="tableStyle2" style="width: 750px;">
			<table class="vacation-ins-table">
				<colgroup>
					<col style="width:25%;">
					<col style="width:25%;">
					<col style="width:25%;">
					<col style="width:25%;">					
				</colgroup>
				<tbody>
				<tr>
					<th><font color="red">*</font> 등록명</th>
					<td style="font-weight:bold;">
						<input type="text" id="salary_subject" name="salary_subject" style="width:160px;"/>
					</td>
					<th><font color="red">*</font> 사용여부</th>
					<td>
						<select id="is_use" name="is_use" style="width:160px;text-align:center;">
							<option value="0">사용</option>
							<option value="1">사용안함</option>																					
						</select>
					</td>
				</tr>
				<tr>
					<th><font color="red">*</font> 적용 시작일자</th>
					<td style="font-weight:bold;"><input type="text" class="classCalendar" id="term_sdate" name="term_sdate" style="width:140px;"/></td>
					<th><font color="red">*</font> 적용 종료일자</th>
					<td style="font-weight:bold;"><input type="text" class="classCalendar" id="term_edate" name="term_sdate" style="width:140px;"/></td>					
				</tr>
				<tr>
					<td colspan="4" style="border:0px;"></td>
				</tr>
				<tr>
					<th colspan="4">수습기간 기본급</th>
				</tr>				
				<tr>
					<th><font color="red">*</font> 기본</th>
					<th>1개월</th>
					<th>2개월</th>
					<th>3개월</th>
				</tr>
				<tr>
					<td><input type="text" id="intern_pay" name="intern_pay" style="text-align:right;width:120px;" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;" class="amt" /> 원</td>
					<td><input type="text" id="intern_pay_1" name="intern_pay_1" style="text-align:right;width:120px;" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;" class="amt" /> 원</td>
					<td><input type="text" id="intern_pay_2" name="intern_pay_2" style="text-align:right;width:120px;" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;" class="amt" /> 원</td>
					<td><input type="text" id="intern_pay_3" name="intern_pay_3" style="text-align:right;width:120px;" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;" class="amt" /> 원</td>
				</tr>
				<tr>
					<td colspan="4" style="border:0px;"></td>
				</tr>
				<tr>
					<th colspan="4">경력기간 기본급</th>
				</tr>				
				<tr>
					<th><font color="red">*</font> 1년 미만</th>
					<th><font color="red">*</font> 2년차</th>
					<th><font color="red">*</font> 3년차</th>
					<th><font color="red">*</font> 4년차 이상</th>
				</tr>
				<tr>
					<td><input type="text" id="career_pay_1" name="career_pay_1" style="text-align:right;width:120px;" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;" class="amt" /> 원</td>
					<td><input type="text" id="career_pay_2" name="career_pay_2" style="text-align:right;width:120px;" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;" class="amt" /> 원</td>
					<td><input type="text" id="career_pay_3" name="career_pay_3" style="text-align:right;width:120px;" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;" class="amt" /> 원</td>
					<td><input type="text" id="career_pay_4" name="career_pay_4" style="text-align:right;width:120px;" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;" class="amt" /> 원</td>
				</tr>
				<tr>
					<td colspan="4" style="border:0px;"></td>
				</tr>
				<tr>
					<th colspan="4">근속수당(당사)</th>
				</tr>				
				<tr>
					<th><font color="red">*</font> 1년 이상</th>
					<th><font color="red">*</font> 2년 이상</th>
					<th><font color="red">*</font> 3년 이상</th>
					<th><font color="red">*</font> 4년 이상</th>
				</tr>
				<tr>
					<td><input type="text" id="conti_pay_1" name="conti_pay_1" style="text-align:right;width:120px;" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;" class="amt" /> 원</td>
					<td><input type="text" id="conti_pay_2" name="conti_pay_2" style="text-align:right;width:120px;" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;" class="amt" /> 원</td>
					<td><input type="text" id="conti_pay_3" name="conti_pay_3" style="text-align:right;width:120px;" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;" class="amt" /> 원</td>
					<td><input type="text" id="conti_pay_4" name="conti_pay_4" style="text-align:right;width:120px;" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;" class="amt" /> 원</td>
				</tr>
				<tr>
					<td colspan="4" style="border:0px;"></td>
				</tr>
				<tr>
					<th><font color="red">*</font> 팀장 수당</th>
					<td><input type="text" id="manager_pay" name="manager_pay" style="text-align:right;width:120px;" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;" class="amt" /> 원</td>
					<th><font color="red">*</font> 기본급 최대 허용 액</th>
					<td><input type="text" id="max_pay" name="max_pay" style="text-align:right;width:120px;" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;" class="amt" /> 원</td>
				</tr>
				<tr>
					<td colspan="4" style="border:0px;text-align:left;padding-left:5px;font-weight:bold;">
						<font color="red">*</font> 필수 입력 값
					</td>
				</tr>					
				</tbody>																																																		
			</table>				
		</div>
	</div>
</form>
<!-- 테스트 등록 폼 끝 -->

<!-- 급여목록 시작 -->
<div>
	<table>
		<tr>
			<td align="left"><b>(단위 : 만원)</b></td>
			<td align="right" style="padding-bottom:5px;"><a href="#noloc" class="btn-equipment-save" id="btn-search" onclick='javascript:salarySetupAdd();'>기본급 등록</a></td>
		</tr>
	</table>
</div>
<!-- 검색창 추가시 사용 -->
<form id="searchFrm" name="searchFrm" method="post"></form>
<div class="tableStyle99">															
	<table>
		<tr>
			<th width="3%" rowspan="2">No</th>
			<th width="12%" rowspan="2">등록명</th>
			<th width="15%" rowspan="2">적용기간</th>
			<th width="4%" rowspan="2">수습<br/>기본급</th>			
			<th width="20%" colspan="4">경력기간 기본급</th>
			<th width="20%" colspan="4">근속수당(당사)</th>
			<th width="4%" rowspan="2">팀장<br/>수당</th>
			<th width="6%" rowspan="2">최대<br/>허용액</th>
			<th width="4%" rowspan="2">사용<br/>여부</th>
			<!-- <th rowspan="2">등록자</th>
			<th rowspan="2">등록일자</th> -->
			<th width="12%" rowspan="2">기능</th>	
		</tr>
		<tr>
			<th>1년미만</th>
			<th>2년차</th>
			<th>3년차</th>
			<th>4년차이상</th>
			<th>1년 이상</th>
			<th>2년 이상</th>
			<th>3년 이상</th>
			<th>4년 이상</th>
		</tr>
	</table>
	<div id="salarySetupInfoList"></div>
</div>
<div id="salary-detail-dialog" title="기본급 설정 상세 보기" style="font-size: 15px;display:none;" align="center"></div>	
<!-- 기본급 설정 분류 끝 -->